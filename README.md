# GAMEBOY-MBC5-CPLD-2MB

## Introduction:

This is my take of a CPLD based flash cart. This is my first version of it, as I intend to make others with different CPLD in future.

The whole project is based from Alex's project from years back. Without that project, I would never have picked this up and spend my time figuring out how to work with CPLDs. I am not a programmer and do not claim to be. Picking up Alex's code I can see how things work with my previous knowledge of how carts operate.

### Alex's project can be found here: https://github.com/insidegadgets/Gameboy-MBC5-MBC1-Hybrid

![20240724_193152](https://github.com/user-attachments/assets/640603c4-fff9-43e4-a779-eaa6f85a892c)

![20240724_193237](https://github.com/user-attachments/assets/b2873e74-364e-4473-9696-c0db93efc231)

![20240724_193322](https://github.com/user-attachments/assets/1edb8943-bc68-4531-a703-fbf612c330d6)

## Advantages vs disadvantages:

### Advantages:

	+ No need for sourcing a donor cartridge
	+ Multi MBC compatibility
	+ Cheaper to build vs a donor cart (initially not, more made, more saved)

### Disadvantages:

	- Parts are all obsolete and found second hand
	- Programming the CPLD is non-trivial
	- Power use is high
	- Extra components required to program CPLD
 	- More circuit board components required

## Prerequisites

You are going to need a bunch of stuff to complete this project.

	* The full components parts list and cart PCB
	* (Optional) JTAG adaptor PCB
	* Altera USB Blaster for JTAG (Cheap copies work, see below)
	* Windows PC with Quartus II Programmer or Quartus II Web Edition
	* GBxCart and related software
 	* Modified Gameboy cart shell or (optional) 3D printed Game Gear cart adaptor
	* Equipment to solder tiny SMD components
	* Skills to solder tiny SMD components reliably

  
## Parts List

### Cartridge x1

| Part No. | Package | Qty |
| -------- | ------- | --- |
| 29F016 | TSOP48 | 1 |
| FM1808 | SOIC28 | 1 |
| EPM3064A/32A | TQFP44 | 1 |
| 74LVC1G332 | TSOP6 | 1 |
| AP2127K-3.3TRG1 | SOT23-5 | 1 |
| Cap 100nF | 0603 | 4 |
| Cap 1uF | 0603 | 2 |
| Res 10K | 0603 | 1 |


### JTAG Adaptor

| Part No. | Qty |
| -------- | --- |
| DS Lite Cart Conn | 1 |
| USB C USB4125 | 1 |
| Pin Headers | 2x5-P2.54mm |
| GG Adaptor or Shell | 1 |
| USB Blaster | 1 |

Link to GG Adaptor: https://www.thingiverse.com/thing:5830799

For the USB Blaster I would suggest avoiding the small ones shown below. I found them to be flakey. Talk to some CPLD and not others, even ones it could talk to it couldn't program. The same chips worked on other programmers.

![USB-Blaster-ALTERA-CPLDFPGA-Programmer-1-52150820](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c1cf440a-68b1-4ccf-bb4e-ad689d0300b6)


I suggest this one, it has been much more solid.

![AliJTAG](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/7360df56-3824-4cea-9fbe-50ed7c374452)

# Guide

This is a rough guide and you are expected to know some things already, such as how to use a Windows PC, solder SMD parts, etc.

First off, order the cart PCB from your manufacturer of choice. I use JLC for small quantity orders like this as they work out cheapest. Make sure to choose ENIG finish and 0.8mm thickness. You do not need to order the JTAG adaptor if you wish to manually solder to the test points on each cart. The adaptor does not need to be ENIG finsih.

Order your parts list for however many carts you ordered. Get them all from Aliexpress, unless you want to order legit FRAM from Digikey. The flash chip and CPLD are obsolete long ago and only available second hand.

Get your USB Blaster drivers installed. I used a github repo for the drivers. Install them through device manager. The links below have the details and drivers.

Driver Installation: https://www.terasic.com.tw/wiki/Intel_USB_Blaster_Driver_Installation_Instructions

Driver Download: https://github.com/sudhamshu091/USB-Blaster-Driver-for-DE10-lite

Assemble the cart. Make sure you have good solder joints and that any flux is thoroughly cleaned from IC pins. The JTAG interface seems sensitive and excess flux has caused me issues trying to program.

Make sure to download the programmer software from here or source it yourself if you wish. The install is simple, just click through and wait. I have also uploaded it here:

https://archive.org/details/quartus-iiprogrammer-and-signal-tap-ii-13.1.0.162.7z

Insert your assembled cart into the JTAG adaptor using the 3D printed shim so that the cart can be inserted upside down. (The side with the 6 cart edge pins). If you don’t have  access to a shim, you can sacrifice an old Gameboy cart by cutting it up so that your cart can fit in it upside down.

Launch the Quartus II Programmer software you just installed.

![2 MainProgUSBBlasterSelected](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/70f33a9c-51d2-422a-b8f0-de7029f098a5)

Make sure that the USB Blaster is detected and selected in Quartus. If not click “Hardware Setup…” and find it.

![1USB Blaster selection](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/b13a9b11-7825-42f8-b04a-1348c170efce)

Once selected select the POF file for the CPLD you are using, 3064A or 3032A.

![3 FileSelected](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/509d84be-c925-4928-9327-ad6c75a6f1af)

If the CPLD is unproven to work yet, it may also be programmed from its previous life. Click “Erase” and press start. If your JTAG is connected properly and working, it should erase quickly. If problems continue, recheck JTAG connections, solder joints and flux residue. By this point, if things still do not work, then the CPLD is already programmed with JTAG disabled (requiring an external programmer) or it is damaged internally.

![4 EraseCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/0c7be1bc-0fed-4b33-837c-dfc981d2b265)

Once erased, it is worth doing a “Blank-Check” to be sure that the erase worked correctly. If this fails, then it is not blank.

![5 BlankCheckCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/dcc28a9e-5c8f-4fdf-b71e-3b5c782faf33)

Finally time to program the CPLD. Check “Program/Configure” and “Verify”, then click start for the last time. It should take about 2 seconds. If you have any trouble, check your JTAG connections, reflow the CPLD, make sure the adaptor board is powered, clean off flux residue.

![6 ProgVerifyCPLD](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/22686784-cfa1-4366-9776-a0bd3121f770)

Now move over to your GBxCart software and test it out. Unplug the JTAG hardware and plug your cart into your GBxCart.

## Compatibility

Alex who wrote this code originally, designed it to be an MBC5 emulation. It behaves well enough as a MBC5, that Gameboys and Flash programmers do not seem to care. One difference from the top of my head, after reading Alex's blog, is that this CPLD version does not map bank 0 as true hardware does. This should never be an issue, as bank 0 is always available in the lower 16KB address space [0x0000-3FFF]. On real hardware, if you mapped bank 0 to the upper 16KB [0x4000-7FFF], you would get the data always available in 0x0000-3FFF in 0x4000-7FFF. In this implementation, it will do as the MBC1 does, by interpreting a bank 0 map request as a bank 1 request.

In theory this should never cause an issue. Logically there is no reason to map bank 0 in this use case. A much better idea would be, to map bank 1 as the default in the upper address space [0x4000-7FFF]. This way you would have the first 32KB chunk of the ROM available like any 32KB size game. The only way this will cause and issue is if the game programmer coded a zero bank map and then tried reading the upper memory space [0x4000-7FFF].

So why did Nintendo remove this idiot proof feature from their first mapper in the later ones? In my opinion, I think they realised mapping 0 bank is a waste of time and it doesn't hurt anything to do. But mostly as MBC1 and MBC5 use a second register to select the highest address bit in their extended ROM mode. Doing this you end up with holes in the address space you need to keep track of. For MBC1 you have 512KB of ROM space available, in extended mode you have 2MB available. The quadrupling of space uses another register to store 2 extra bits. These are then output on two extra I/O pins. If you want the first bank of the 1 to 1.5MB ROM space, that is bank zero, which switches to a 1. Each 512KB ROM space is missing bank 0. In MBC5 this does not exist as it is able to map bank zero, therefore, you do not have to keep track of things.

The theory is that this should be 100% compatible with MBC5. That said, it is not programmed to behave exactly like an MBC5, so there could be a game out there that doesn't work.

## Links

Here are the links mentioned through the readme. They are already in the readme, but also here for aid of finding them.

Driver Installation: https://www.terasic.com.tw/wiki/Intel_USB_Blaster_Driver_Installation_Instructions

Driver Download: https://github.com/sudhamshu091/USB-Blaster-Driver-for-DE10-lite

Game gear Adaptor: https://www.thingiverse.com/thing:5830799

Alternative Download for Quartus: https://archive.org/details/quartus-iiprogrammer-and-signal-tap-ii-13.1.0.162.7z

## Extra Links

https://shop.insidegadgets.com

https://github.com/insidegadgets

https://www.instagram.com/inside.gadgets

https://github.com/bytendomods

https://github.com/Bucket-Mouse

Thanks to Xukkorz, Drew, Jamo, Alex & Deceptive Thinker for their input and anyone else who I may have forgotten.
