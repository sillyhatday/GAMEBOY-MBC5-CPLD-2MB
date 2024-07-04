module mbc5_2mb_v1 (
reset, 
clock,
inputAddress, inputData, inputCE, inputWR, inputRD,
highAddress, ramCE);

// Inputs
input reset;
input clock;
input [3:0] inputAddress; // a15 - a12
input [6:0] inputData; // d6 - d0
input inputCE;
input inputRD;
input inputWR;

// Outputs / Registers
output [7:0] highAddress; // a20 - a13
reg [7:0] highAddress;

reg [6:0] romBank; // a20 - a14 
reg [1:0] ramBank; // a14 - a13 
reg ramEnabled;

output ramCE;
reg ramCE;

reg mbc1Detect303FOn;
reg mbc1Detected607F;
reg mbc3or5Locked;

// ROM a0-a13 straight through, a14-a21 from CPLD highAddress [1:8]
// FRAM a0-a12 straight through, a13-a14 from CPLD highAddress [0:1]
// input RD, WR, CS straight through to ROM
// input RD, WR, straight through to RAM, CE handled by CPLD
// romCE to A15

always @ (reset or clock or inputCE or inputRD or inputWR) begin
	if (!reset) begin
		highAddress <= 8'b0;
		romBank <= 7'b1;
		ramBank <= 2'b0;
		ramEnabled <= 1'b0;
		ramCE <= 1'b1;
		mbc1Detect303FOn <= 1'b0;
		mbc1Detected607F <= 1'b0;
		mbc3or5Locked <= 1'b0;
	end
	else begin
		// *** ROM Functions ***
		// Only pass through on 0x0000-7FFF if reading or writing flash
		if (inputAddress <= 4'd7 && (!inputRD || !inputWR)) begin
			if (inputAddress <= 4'd3) begin // 0x0000-3FFF, Bank 0 always
				highAddress <= 8'b0; // All set to 0
			end
			else begin
				highAddress <= (romBank << 1); // Start at a14 for ROM
			end
		end
		
		// 0x2000-3FFF - Low 7 bits of ROM Bank Number (Write Only) with little MBC1 detection hack
		if (((inputAddress == 4'd2) || inputAddress == 4'd3 && mbc1Detect303FOn) && !inputWR && inputRD && inputCE) begin
			if (inputData == 7'd0) begin
				romBank <= 1'b1;
				mbc1Detect303FOn <= 1'b1;
			end
			else begin
				if (inputData >= 7'd32) begin
					mbc3or5Locked <= 1'b1;
				end
				
				romBank <= inputData;
			end
		end
		
		// *** RAM Functions ***
	   ramCE <= 1'b1;
		
		// Only pass through on 0xA000-BFFF if RAM is enabled
		if ((inputAddress == 4'hA || inputAddress == 4'hB) && ramEnabled && (!inputRD || !inputWR)) begin
			if (clock) begin
				ramCE <= 1'b1;
			end
			else begin
				ramCE <= inputCE;
			end
			highAddress <= ramBank;
		end
	
		// 0x0000-1FFF - RAM Enable (Write Only). 0x0A = Enable, 0x00 Disable
		if ((inputAddress == 4'd1 || inputAddress == 4'd0) && !inputWR && inputRD && inputCE) begin
			if (inputData == 7'hA) begin // Enable RAM
				ramEnabled <= 1'd1;
			end
			else begin // Disable RAM
				ramEnabled <= 1'd0;
			end
		end
  
		// 0x4000-5FFF - RAM Bank Number (Write Only)
		if ((inputAddress == 4'd4 || inputAddress == 4'd5) && !inputWR && inputRD && inputCE) begin
			if ((mbc1Detect303FOn && mbc1Detected607F) && !mbc3or5Locked) begin // Ignore RAM banking requests
			end
			else begin
				ramBank <= inputData[1:0];
			end
		end
		
		// 0x6000-7FFF - ROM/RAM Mode MBC1 Detection
		if ((inputAddress == 4'd6 || inputAddress == 4'd7) && !inputWR && inputRD && inputCE) begin
			mbc1Detected607F <= 1'b1;
		end
	end
end

endmodule