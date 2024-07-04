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

## Supply Voltages:

MAX 3000A datasheet shows the maximum supply voltage for the CPLD is 4.6v. Using a diode to drop 0.7v from 5v, the CPLD could potentially run on 4.3v. Two diodes in series would bring things to 3.6v. Just within the max recommended supply voltage.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/7ad6c4f1-474b-430a-8a7c-38a094d51354)

Recommended values.

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c5e22615-49fd-4911-9b55-f17689f92b26)

Input pin max operating voltage

![image](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/c0ca1e72-9525-43fb-be55-a84cd655be1b)

If you were in China selling these beyond cheap, then a single diode would be acceptable. Even then I could see them being put straight to 5v.

## Power use:

Power usage vs Nintendo carts vs DIY carts.

Power use so far seems to fall inline with the EZ flash Jr. This is unfortunate but logical as the EZ Flash uses the same PLD/FPGA technology to function.

These are some rough current measurements taken at the battery terminals of a Bucket Mouse DMGC and a stock DMG, with the screen on max brightness and no sound.

Pokemon Blue and Red were used interchangeably, as they are virtually the same game.

For projected battery life in hours [Batt] it is in reference to the Duracell 2450mAh ones I use for Gameboy gaming. It is calculated based on mWh to eliminate the voltage decrease as capacity is used. 11760mWh 11.76Wh

### DMGC

| Pokemon Blue [Nintendo] | Voltage V | Current mA | Power mW | Batt |
| ----------------------------------- | ------------ | ---------------- | --------------- | -------- |
| Intro Animation | 5.08V | 111mA | 564mW | 20 hours 51 minutes |
| Title Screen | 5.08V | 112-125mA | 568-635mW | 20 h  42m - 18 h 31 m |
| Overworld | 5.08V | 123mA | 624mW | 18 hours 51 minutes |

| Pokemon Red [SillyHatMBC5] | Voltage V | Current mA | Power mW | Batt H |
| ----------------------------------- | ------------ | ---------------- | --------------- | ------------- |
| Intro Animation | 5.08V | 110mA | 559mW | 21 hours 2 minutes |
| Title Screen | 5.08V | 110-124mA | 559-630mW | 21 h 1 m - 18 h 40 m |
| Overworld | 5.08V | 123mA | 624mW | 18 hours 50 minutes |

| Pokemon Red [CPLD] | Voltage V | Current mA | Power mW | Batt H |
| ----------------------------------- | ------------ | ---------------- | --------------- | ------------- |
| Intro Animation | 5.02V | 158mA | 793mW | 14 hours 50 minutes |
| Title Screen | 5.02V | 158-174mA | 793-873mW | 14 h 50 m - 13 h 28 m |
| Overworld | 5.02V | 160mA | 803mW | 14 hours 39 minutes |

### DMG

| Pokemon Blue [Nintendo] | Voltage V | Current mA | Power mW | Batt |
| ----------------------------------- | ------------ | ---------------- | --------------- | -------- |
| Intro Animation | 5.14V | 44mA | 226mW |  hours  minutes |
| Title Screen | 5.14V | 44-60mA | 226-308mW |  h  m -  h  m |
| Overworld | 5.14V | 47.6mA | 245mW |  hours  minutes |

| Pokemon Red [SillyHatMBC5] | Voltage V | Current mA | Power mW | Batt H |
| ----------------------------------- | ------------ | ---------------- | --------------- | ------------- |
| Intro Animation | 5.14V | 41mA | 210mW |  hours  minutes |
| Title Screen | 5.13V | 42-59mA | 215-303mW |  h  m -  h  m |
| Overworld | 5.13V | 49mA | 251mW |  hours  minutes |

| Pokemon Red [CPLD] | Voltage V | Current mA | Power mW | Batt H |
| ----------------------------------- | ------------ | ---------------- | --------------- | ------------- |
| Intro Animation | 5.13V | 89mA | 457mW |  hours  minutes |
| Title Screen | 5.10V | 89-109mA | 457-559mW |  h  m -  h  m |
| Overworld | 5.10V | 91mA | 467mW |  hours  minutes |

