## Design Considerations

I thought I'd note down some thoughts here about the design, alternatives and future plans. 

### Supply Voltages:

I honestly just copied what Alex used in his project. Not blindly mind you, I went to check it out to see if it was suitable and how best to use it. The AP2127K-3.3, nice and compact, while having way more current output than this will need.

Just copy the diagram in the datasheet and it is good to go. Some input capacitance and some output capacitance for stability. Slightly more capacitance on the output than the input.

The CPLD requires its own decoupling locally too. The regulator is positioned right next to the CPLD to help with supply issues, but it is best to still have decoupling for the chip. Another data sheet, for the PLD range, suggestes 220nF for decoupling. It states multiple times that it is an overkill value, so as I see it, it's a coverall bases number to cover their ass. I think that two 100nF capacitors will be more than enough with one on opposite ends of the chip. I'd honestly leave one unpopulated when building. That 220nF is for a PLD at full chat in a non ideal scenario. A single 100nF will be enough with the 1uF tucked agains the regulator too.

What can you get away with though? The MAX 3000A datasheet shows the absolute maximum supply voltage for the CPLD is 4.6v. Using a diode to drop 0.7v from 5v, the CPLD could potentially run on 4.3v. Two diodes in series would bring things to 3.6v. Just within the max recommended supply voltage.

If you were in China selling these beyond cheap, then a single diode would be acceptable. Saying that, many designs I see slam 3.3v parts onto 5v. You'd think that for GBA 3.3v logic they would be fine with those 3.3v parts, nope, they use 1.8v parts. I digress.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/7ad6c4f1-474b-430a-8a7c-38a094d51354)

Recommended values.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c5e22615-49fd-4911-9b55-f17689f92b26)

Input pin max operating voltage

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c0ca1e72-9525-43fb-be55-a84cd655be1b)

Moving to the Atmel part will solve any need for supply regulation with its 5v rating. Removing the need for an on cart voltage regulator.

### FRAM Precharge

I've used an OR gate to generate the RAMCS signal from the memory mapper output and system clock signal. This is a hold over from the traditional fix done on DIY carts or FRAM retrofits to Nintendo carts.

The CPLD can perform this operation internally and the software is there in Alex's code, but it doesn't seem to work correctly. I have no doubt this is due to my low quality FRAM, but it is interesting as to why this doesn't work. It can only be a timing issue as far as I can see. I don't have the tools required to be able to look at the data signals and determine what the problem might be. It's also worth noting that I've not come across a MBC5 2MB game that required this logic. 

The symptoms being that not only does the game not save correctly, some games glitch and crash. It's as though the RAM is putting data on the bus. I wonder if it's conflicting with a read operation with the ROM somehow. Not sure.

CPLD code segment:

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/677a3d42-db7b-4875-b0e2-3d32b3634d5c)

If clock signal is high then set ramCE high to disable FRAM (chip enable pin 20). If clock signal is low the pass through inputCE value (1 or 0) to ramCE output.
