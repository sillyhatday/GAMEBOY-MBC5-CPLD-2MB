# GAMEBOY-MBC5-CPLD-2MB

## Introduction:

This is my take of a CPLD based flash cart. This is my first version of it, as I intend to make others with different CPLD in future.

The whole project is based from Alex's project from years back. Without that project, I would never have picked this up and spend my time figuring out how to work with CPLDs. I am not a programmer and do not claim to be. Picking up Alex's code I can see how things work with my previous knowledge of how carts operate.

### Alex's project can be found here: https://github.com/insidegadgets/Gameboy-MBC5-MBC1-Hybrid

## Advantages vs disadvantages:

### Advantages:

	- No need for sourcing a donor cartridge
	- Multi MBC compatibility
	- Cheaper to build vs other carts*

### Disadvantages:

	- Parts are all obsolete and found second hand
	- Programming the CPLD is non-trivial
	- Power use is high
	- Extra components required to program CPLD

## Parts List

### Cartridge x1

| Part No. | Package | Qty |
| -------- | ------- | --- |
| 29F016 | TSOP48 | 1 |
| FM1808 | SOIC28 | 1 |
| EPM3064A/32A | TQFP44 | 1 |
| 74LVC1G332 | TSOP6 | 1 |
| AP2127K | SOT23-5 | 1 |
| Cap 100nF | 0603 | 6 |
| Res 10K | 0603 | 1 |


### JTAG Adaptor

| Part No. | Qty |
| -------- | --- |
| DS Lite Cart Conn | 1 |
| USB C USB4125 | 1 |
| Pin Headers | 2x5-P2.54mm |

## Design Considerrations

### Supply Voltages:

MAX 3000A datasheet shows the maximum supply voltage for the CPLD is 4.6v. Using a diode to drop 0.7v from 5v, the CPLD could potentially run on 4.3v. Two diodes in series would bring things to 3.6v. Just within the max recommended supply voltage.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/7ad6c4f1-474b-430a-8a7c-38a094d51354)

Recommended values.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c5e22615-49fd-4911-9b55-f17689f92b26)

Input pin max operating voltage

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c0ca1e72-9525-43fb-be55-a84cd655be1b)

If you were in China selling these beyond cheap, then a single diode would be acceptable. Even then I could see them being put straight to 5v.

### FRAM Precharge

I've used an OR gate to generate the RAMCS signal from the memory mapper output and system clock signal. This is a hold over from the traditional fix done on DIY carts or FRAM retrofits to Nintendo carts.

The CPLD can perform this operation internally and the software is there in Alex's code, but it doesn't seem to work correctly. I have no doubt this is due to my low quality FRAM, but it is interesting as to why this doesn't work. It can only be a timing issue as far as I can see. I don't have the tools required to be able to look at the data signals and determine what the problem might be.

The symptoms being that not only does the game not save correctly, some games glitch and crash. It's as though the RAM is putting data on the bus. I wonder if it's conflicting with a read operation with the ROM somehow. Not sure.

CPLD code segment:

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/677a3d42-db7b-4875-b0e2-3d32b3634d5c)

If clock signal is high then set ramCE high to disable FRAM (chip enable pin 20). If clock signal is low the pass through inputCE value (1 or 0) to ramCE output.

## Power use:

Power usage vs Nintendo carts vs DIY carts.

Power use so far seems to fall inline with the EZ flash Jr. This is unfortunate, but logical as the EZ Flash uses the same PLD/FPGA technology. Overall based on measurments takenm, the CPLD memory mapper looks to use 45 to 47mA more current than a regular cart. I intend to eventually measure cartridge current alone and not whole system current. This should remove any differences in hardware silicon and hardware revisions.

These are some rough current measurements taken at the battery terminals of a Bucket Mouse DMGC and a stock DMG. These are done with the screen on max brightness and no sound. Pokemon Blue and Red were used interchangeably, as they are virtually the same game.

For projected battery life in hours [Batt] it is in reference to the Duracell 2450mAh ones I use for Gameboy gaming. It is calculated based on mWh (11760mWh) to eliminate the voltage decrease as capacity is used. The mWh was calculated using the duracell datasheet for mAh and nominal voltage. Discharge rates were ignored as these batteries have an excellent ability to maintain capacity under high loads (1C, 2C, etc). Between 1C and 0.1C is about 5% difference.

Datasheet: https://panda-bg.com/datasheet/1602-362229-Battery-Cell-AA-2450-mAh-Ni-MH-DURACELL.pdf

### DMGC

| Pokemon Blue [Nintendo] | Voltage V | Current mA | Power mW | Batt | Diff |
| ----------------------------------- | ------------ | ---------------- | --------------- | -------- | ---- |
| Intro Animation | 5.08V | 111mA | 564mW | 20 hours 51 minutes | 100% |
| Title Screen | 5.08V | 112-125mA | 568-635mW | 20 h  42m - 18 h 31 m | 100% |
| Overworld | 5.08V | 123mA | 624mW | 18 hours 51 minutes | 100% |
| **Pokemon Red [SillyHatMBC5]** | ----- | ----- | ----- | ----- | ----- |
| Intro Animation | 5.08V | 110mA | 559mW | 21 hours 2 minutes | 99.1% |
| Title Screen | 5.08V | 110-124mA | 559-630mW | 21 h 1 m - 18 h 40 m | 98.4-100.7% |
| Overworld | 5.08V | 123mA | 624mW | 18 hours 50 minutes | 100% |
| **Pokemon Red [CPLD]** | ----- | ----- | ----- | ----- |
| Intro Animation | 5.02V | 158mA | 793mW | 14 hours 50 minutes | 66.3% |
| Title Screen | 5.02V | 158-174mA | 793-873mW | 14 h 50 m - 13 h 28 m | 67-68.4%
| Overworld | 5.02V | 160mA | 803mW | 14 hours 39 minutes | 74.9% |

### DMG

| Pokemon Blue [Nintendo] | Voltage V | Current mA | Power mW | Batt | Diff |
| ----------------------------------- | ------------ | ---------------- | --------------- | -------- | --- |
| Intro Animation | 5.14V | 44mA | 226mW | 52 hours 2 minutes | 100% |
| Title Screen | 5.14V | 44-60mA | 226-308mW | 52 h 2 m - 38 h 11 m | 100% |
| Overworld | 5.14V | 47.6mA | 245mW | 48 hours 0 minutes | 100% |
| **Pokemon Red [SillyHatMBC5]** | ----- | ----- | ----- | ----- |
| Intro Animation | 5.14V | 41mA | 210mW | 56 hours 0 minutes | 107.3% |
| Title Screen | 5.13V | 42-59mA | 215-303mW | 54 h 41 m - 38 h 49 m | 105-101.6% |
| Overworld | 5.13V | 49mA | 251mW | 46 hours 51 minutes | 97.6% |
| **Pokemon Red [CPLD]** | ----- | ----- | ----- | ----- |
| Intro Animation | 5.13V | 89mA | 457mW | 25 hours 44 minutes | 67.6% |
| Title Screen | 5.10V | 89-109mA | 457-559mW | 25 h 44 m - 21 h 2 m | 67.6-58%
| Overworld | 5.10V | 91mA | 467mW | 25 hours 11 minutes | 62.4% |

# Guide

This is a rough guide and you are expected to know some things already, such as how to use a Windows PC, solder SMD parts, etc.

First off, order the cart PCB from your manufacturer of choice. I use JLC for small quantity orders like this as they work out cheapest. Make sure to choose ENIG finish and 0.8mm thickness. You do not need to order the JTAG adaptor if you wish to manually solder to the test points on each cart. The adaptor does not need to be ENIG finsih.


Order your parts from the list for however many carts you ordered. Get them all from Aliexpress, unless you want to order legit FRAM from Digikey. The flash chip and CPLD are obsolete long ago and only available second hand. You can get some generic USB blaster from eBay, Aliexpress, Amazon also.

Get your USB Blaster drivers installed. I used a github repo for the drivers. Install them through device manager.

More detail: https://www.terasic.com.tw/wiki/Intel_USB_Blaster_Driver_Installation_Instructions


Link: https://github.com/sudhamshu091/USB-Blaster-Driver-for-DE10-lite

Assemble the cart. Make sure you have good solder joints and that any flux is thoroughly cleaned from IC pins. The JTAG interface seems sensitive and excess flux has caused me issues trying to program.

Make sure to download the programmer software from here or source it yourself if you wish. The install is simple, just click through and wait.

Insert your assembled cart into the JTAG adaptor using the 3D printed shim so that the cart can be inserted upside down. (The side with the 6 cart edge pins). If you don’t have  access to a shim, you can sacrifice an old Gameboy cart by cutting it up so that your cart can fit in it upside down.

Launch the Quartus software you just installed.

![2 MainProgUSBBlasterSelected](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/70f33a9c-51d2-422a-b8f0-de7029f098a5)

Make sure that the USB Blaster is detected and selected in Quartus. If not click “Hardware Setup…” and find it.

![1USB Blaster selection](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/b13a9b11-7825-42f8-b04a-1348c170efce)

Once selected select the POF file for the CPLD you are using, 3064A or 3032A.

![3 FileSelected](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/509d84be-c925-4928-9327-ad6c75a6f1af)


If the CPLD is unproven to work yet, it may also be programmed from its previous life. Click “Erase” and press start. If your JTAG is connected properly and working, it should erase quickly.

![4 EraseCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/0c7be1bc-0fed-4b33-837c-dfc981d2b265)

Once erased, it is worth doing a “Blank-Check” to be sure that the erase worked correctly. If this fails, then it is not blank.

![5 BlankCheckCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/dcc28a9e-5c8f-4fdf-b71e-3b5c782faf33)

Finally time to program the CPLD. Check “Program/Configure” and “Verify”, then click start for the last time. It should take about 2 seconds. If you have any trouble, check your JTAG connections, reflow the CPLD, make sure the adaptor board is powered, clean off flux residue.

![6 ProgVerifyCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/22686784-cfa1-4366-9776-a0bd3121f770)

Now move over to your GBxCart software and test it out. Unplug the JTAG hardware and plug your cart into your GBxCart.
