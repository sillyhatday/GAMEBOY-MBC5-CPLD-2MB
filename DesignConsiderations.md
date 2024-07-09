## Design Considerrations

I thought I'd note down some thoughts here about the design, alternatives and future plans. 

### Supply Voltages:

MAX 3000A datasheet shows the absolute maximum supply voltage for the CPLD is 4.6v. Using a diode to drop 0.7v from 5v, the CPLD could potentially run on 4.3v. Two diodes in series would bring things to 3.6v. Just within the max recommended supply voltage.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/7ad6c4f1-474b-430a-8a7c-38a094d51354)

Recommended values.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c5e22615-49fd-4911-9b55-f17689f92b26)

Input pin max operating voltage

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c0ca1e72-9525-43fb-be55-a84cd655be1b)

If you were in China selling these beyond cheap, then a single diode would be acceptable. Saying that, many designs I see slam 3.3v parts onto 5v. You'd think that for GBA 3.3v logic they would be fine with those 3.3v parts, nope, they use 1.8v parts.

Moving to the Atmel part will solve any need for supply regulation with its 5v rating.

### FRAM Precharge

I've used an OR gate to generate the RAMCS signal from the memory mapper output and system clock signal. This is a hold over from the traditional fix done on DIY carts or FRAM retrofits to Nintendo carts.

The CPLD can perform this operation internally and the software is there in Alex's code, but it doesn't seem to work correctly. I have no doubt this is due to my low quality FRAM, but it is interesting as to why this doesn't work. It can only be a timing issue as far as I can see. I don't have the tools required to be able to look at the data signals and determine what the problem might be. It's also worth noting that I've not come across a MBC5 2MB game that required this logic. 

The symptoms being that not only does the game not save correctly, some games glitch and crash. It's as though the RAM is putting data on the bus. I wonder if it's conflicting with a read operation with the ROM somehow. Not sure.

CPLD code segment:

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/677a3d42-db7b-4875-b0e2-3d32b3634d5c)

If clock signal is high then set ramCE high to disable FRAM (chip enable pin 20). If clock signal is low the pass through inputCE value (1 or 0) to ramCE output.
