module mbc5_4mb_v0.1 (
		// Variables
reset, 
clock,
inputAddress, inputData, inputCE, inputWR, inputRD,
highAddress, ramCE);

		// Inputs
input reset;				// Assign input pin for reset
input clock;				// Assign input pin for clock
input [3:0] inputAddress;	// a15 - a12 [3:0] is a VECTOR 4-bits, 3, 2, 1, 0 - 4 input pins
input [6:0] inputData;		// d6 - d0 [6:0] is a VECTOR 7 bits - 7 input pins
input inputCE;				// Chip enable input
input inputRD;				// Read enable input
input inputWR;				// Write enable input

		// Outputs / Registers
output [7:0] highAddress;	// a20 - a13 8 output pins
reg [7:0] highAddress;		// 8 bit registor

reg [6:0] romBank;		// a20 - a14 reg is used to store a STRING 7 bit registor
reg [1:0] ramBank;		// a14 - a13 [1:0] is the string size, just 2 bits registor
reg ramEnabled;			// 1 bit registor

output ramCE;			// RAM chip enable output
reg ramCE;				// 1 bit registor

reg mbc1Detect303FOn;		// Single bit registor 1 or 0
reg mbc1Detected607F;		// Single bit registor 1 or 0
reg mbc3or5Locked;		// Single bit registor 1 or 0

// ROM a0-a13 straight through, a14-a21 from CPLD highAddress [1:8]
// FRAM a0-a12 straight through, a13-a14 from CPLD highAddress [0:1]
// input RD, WR, CS straight through to ROM
// input RD, WR, straight through to RAM, CE handled by CPLD
// romCE to A15

				// Function below to reset all registors on CPU reset signal

always @ (reset or clock or inputCE or inputRD or inputWR) begin
	if (!reset) begin
		highAddress <= 8'b0;		// Set highAddress 8 bit registor to binary 0
		romBank <= 7'b1;		// Set romBank 7 bit registor to binary 1
		ramBank <= 2'b0;		// Set ramBank 2 bit registor to binary 0
		ramEnabled <= 1'b0;		// Set ramEnabled 1 bit registor to binary 0
		ramCE <= 1'b1;			// Set ramCE 1 bit resgistor to binary 1
		mbc1Detect303FOn <= 1'b0;	// Set registor to 0
		mbc1Detected607F <= 1'b0;	// Set registor to 0
		mbc3or5Locked <= 1'b0;		// Set registor to 0
	end
	
	else begin
				// *** ROM Functions ***
				// Only pass through on 0x0000-7FFF if reading or writing flash
				// Below is used for writing data to the ROM (flash chip) in FlashGBX
								
		if (inputAddress <= 4'd7 && (!inputRD || !inputWR)) begin	// ! inverts the value 1  is 0 and 0 is 1 || is OR
			if (inputAddress <= 4'd3) begin 						// 0x0000-3FFF, Bank 0 always
				highAddress <= 8'b0;								// All set all address pins to 0
			end
			else begin
				highAddress <= (romBank << 1);						// Start at a14 for ROM << shift operator
			end
		end
		
						/* This function is used to write the ROM (flash chip) bank number to the CPLD */
						// 0x2000-3FFF - 4MB - 256 banks - 8MB uses 0x3000-3FFF for 9th bit - should never be an issue
						// Low 7 bits of ROM Bank Number (Write Only) with little MBC1 detection hack
		
		if (((inputAddress == 4'd2) || inputAddress == 4'd3 && mbc1Detect303FOn) && !inputWR && inputRD && inputCE) begin
			
								// Function to lock CPLD in MBC1 mode
			
			if (inputData == 7'd0) begin		// If data is 0 exactly
				romBank <= 1'b1;				// <= is used to delay updating romBank until block has been processed
				mbc1Detect303FOn <= 1'b1;		// mbc1* will be updated simultaniously
			end
			
			else begin
			
								// Function to lock CPLD in MBC5 mode
			
				if (inputData >= 7'd32) begin	// Check for inputData to be equal or greater than decimal 32
					mbc3or5Locked <= 1'b1;	// Set mbc3or5Locked 1 bit reg to binary 1
				end
				
				romBank <= inputData;		// Set romBank to inputData at end of block???
			end
		end
		
								// *** RAM Functions ***
	   ramCE <= 1'b1;					// Set ramCE to binary 1
		
								// Only pass through on 0xA000-BFFF if RAM is enabled
								
		if ((inputAddress == 4'hA || inputAddress == 4'hB) && ramEnabled && (!inputRD || !inputWR)) begin
		
								// Below is the function used for pulsing the chip enable output for the FRAM "precharge"
								// doesn't seem to work needs further testing
		
			if (clock) begin
				ramCE <= 1'b1;			// If clock rises ramCE goes high or 1
			end
			else begin
				ramCE <= inputCE;		// Else ramCE is set to inputCE value
			end
			highAddress <= ramBank;		// highAddress is set to ramBank value
		end
	
		// 0x0000-1FFF - RAM Enable (Write Only). 0x0A = Enable, 0x00 Disable
		// Checks for correct address value to determine if to write data to RAM
		if ((inputAddress == 4'd1 || inputAddress == 4'd0) && !inputWR && inputRD && inputCE) begin
			if (inputData == 7'hA) begin		// Enable RAM
				ramEnabled <= 1'd1;
			end
			else begin				// Disable RAM
				ramEnabled <= 1'd0;
			end
		end
  
		// 0x4000-5FFF - RAM Bank Number (Write Only)
		// Checks for correct address value to determine if to store RAM bank in MBC registor
		if ((inputAddress == 4'd4 || inputAddress == 4'd5) && !inputWR && inputRD && inputCE) begin
			if ((mbc1Detect303FOn && mbc1Detected607F) && !mbc3or5Locked) begin	// Ignore RAM banking requests
			end									// mbcDetects both true and mbclocked false to continue else end
			else begin
				ramBank <= inputData[1:0];					// Set ramBank to inputData 2bit value D6 D5
			end
		end
		
		// 0x6000-7FFF - ROM/RAM Mode MBC1 Detection
		if ((inputAddress == 4'd6 || inputAddress == 4'd7) && !inputWR && inputRD && inputCE) begin // 0x6000-7000
			mbc1Detected607F <= 1'b1;
		end
	end
end

endmodule
