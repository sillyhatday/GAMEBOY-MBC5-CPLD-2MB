## Power use:

Power usage vs Nintendo carts vs DIY carts.

Power use so far seems to fall inline with the EZ flash Jr. This is unfortunate, but logical as the EZ Flash uses the same PLD/FPGA technology. Overall based on measurments taken, the CPLD memory mapper looks to use 45 to 47mA more current than a regular cart. (These measurments, as you will see, are higher than the actual cartridge power measurments. This is due to inaccuracies and efficiency of the internal regulator).

These are some rough current measurements taken at the battery terminals of a Bucket Mouse DMGC and a stock DMG. These are done with the screen on max brightness and no sound. Pokemon Blue and Red were used interchangeably, as they are virtually the same game.

For projected battery life in hours [Batt], it is in reference to the Duracell 2450mAh batteries I use for Gameboy gaming. It is calculated based on mWh (11760mWh) to eliminate the voltage decrease as capacity is used. The mWh was calculated using the duracell datasheet, taking their mAh and nominal voltage. Discharge rates were ignored as these batteries have an excellent ability to maintain capacity under high loads (1C, 2C, etc). Between 1C and 0.1C is about 5% difference.

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

I'm ending this test setup here, but I wanted to keep the data as it is still useful. Moving forwards, all tests will be done by measuring cart current only.

## Cart Power Only

I switched to a different test setup, so as to get a more accurate idea of how much power the cart uses. I cut the thin part of the 5V plane and bridged it with a 2.2Ω shunt resistor. Before that, I verified the resistor was 2.2Ω to one decimal place. I wanted to try this instead of my multimeter current measurment so as to sanity check previous measurements and accuracy of my multimeter. The measurments below seem to match what Alex recorded in his blog. Bear in mind though this is for the whole cart, and Alex was using SRAM in his cart. Meaning there will be some difference and innacuracies against his results.

Alex's blog: https://www.insidegadgets.com/2018/08/12/building-a-2mb-mbc5-gameboy-cart-part-3-pcbs-arrived-adding-some-mbc1-support-and-troubleshooting-a-few-games/

### Test Method:

Each reading was taken with no button inputs and the game just doing its thing. These are screen captures from an emulator to show the game locations used more clearly than photgraphs:

![First 4 caps](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/6d922528-0f3c-4c97-99e5-d01528b2b422)
![2nd 4 caps](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/b1a7457f-cfad-41b0-9095-e542acc54dcc)
![Stats](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/23b83c93-8640-450c-a5b1-dcf386569fcc)

1mV = 1mA / 2.2

### Altera EPM3064A V1.0:

| Pokemon Shin Red | Resistance Ω | Vdrop | Current mA | Power mW |
| ---------------- | ------------ | ----- | ---------- | -------- |
| Intro Animation | 2.2 | 68 | 30.9 | 155 |
| Title Screen Low | 2.2 | 66.7 | 30.3 | 151.6 |
| Title Screen High | 2.2 | 78.8 | 35.8 | 179.1 |
| Overworld A | 2.2 | 72 | 32.7 | 163.6 |
| Overworld B | 2.2 | 66.4 | 30.2 | 150.9 |
| Overworld Talking | 2.2 | 85.2 | 38.7 | 193.6 |
| Pokemon Centre Nurse | 2.2 | 85 | 38.6 | 193.2 |
| Battle Scene | 2.2 | 76.5 | 34.8 | 173.9 |
| Pause Menu | 2.2 | 84.6 | 38.5 | 192.3 |
| Pokemon Stats | 2.2 | 85.1 | 38.7 | 193.4 |

**Total average current: 34.92mA**

**Total average power: 174.6mW**

### Altera EPM3032A V1.0:

| Pokemon Shin Red | Resistance Ω | Vdrop | Current mA | Power mW |
| ---------------- | ------------ | ----- | ---------- | -------- |
| Intro Animation | 2.2 | 58 | 26.4 | 131.8 |
| Title Screen Low | 2.2 | 57 | 25.9 | 129.6 |
| Title Screen High | 2.2 | 70 | 31.8 | 159.1 |
| Overworld A | 2.2 | 63.8 | 29 | 145 |
| Overworld B | 2.2 | 58.2 | 26.5 | 132.3 |
| Overworld Talking | 2.2 | 76.8 | 34.9 | 174.6 |
| Pokemon Centre Nurse | 2.2 | 76.8 | 34.9 | 174.6 |
| Battle Scene | 2.2 | 68.6 | 31.2 | 155.9 |
| Pause Menu | 2.2 | 76.3 | 34.68 | 173.4 |
| Pokemon Stats | 2.2 | 76.9 | 35 | 174.8 |

**Total average current: 31mA**

**Total average power: 155.1mW**

For the Pokemon tests, this is an interesting result. I was hoping that it would turn out the way it has. The 3032A uses less power, 11.8% less in fact. I only ended up with the 3032A by accident, which is turning out to be a good thing. Let's try a small firmware adjustment before moving to another game.

### Altera EPM3064A V1.1:

| Pokemon Shin Red | Resistance Ω | Vdrop | Current mA | Power mW |
| ---------------- | ------------ | ----- | ---------- | -------- |
| Intro Animation | 2.2 | 68.1 | 31 | 154.8 |
| Title Screen Low | 2.2 | 66.5 | 30.2 | 151.1 |
| Title Screen High | 2.2 | 78.6 | 35.7 | 178.6 |
| Overworld A | 2.2 | 72.8 | 33.1 | 165.5 |
| Overworld B | 2.2 | 67.1 | 30.5 | 152.5 |
| Overworld Talking | 2.2 | 85.6 | 38.9 | 194.6 |
| Pokemon Centre Nurse | 2.2 | 85.2 | 38.7 | 193.6 |
| Battle Scene | 2.2 | 76.6 | 34.8 | 174.1 |
| Pause Menu | 2.2 | 84.7 | 38.5 | 192.5 |
| Pokemon Stats | 2.2 | 85.2 | 38.73 | 193.6 |

**Total average current: 35mA**

**Total average power: 175.1mW**

### Altera EPM3032A V1.1:

| Pokemon Shin Red | Resistance Ω | Vdrop | Current mA | Power mW |
| ---------------- | ------------ | ----- | ---------- | -------- |
| Intro Animation | 2.2 | 56.7 | 25.8 | 128.9 |
| Title Screen Low | 2.2 | 55.1 | 25.1 | 125.2 |
| Title Screen High | 2.2 | 66.1 | 30.1 | 150.2 |
| Overworld A | 2.2 | 61.9 | 28.1 | 140.7 |
| Overworld B | 2.2 | 56.4 | 25.6 | 128.2 |
| Overworld Talking | 2.2 | 75 | 34.1 | 170.5 |
| Pokemon Centre Nurse | 2.2 | 74.9 | 34.1 | 170.2 |
| Battle Scene | 2.2 | 66.7 | 30.3 | 151.6 |
| Pause Menu | 2.2 | 74.4 | 33.8 | 169.1 |
| Pokemon Stats | 2.2 | 74.9 | 34.1 | 170.2 |

**Total average current: 30.1mA**

**Total average power: 150.5 mW**

### Averages & Percents

| Firmware | Game | CPLD | Current | Power | % vs Self | % vs Other |
| -------- | ---- | ---- | ------- | ----- | --------- | ---------- |
| v1.0 | Shin Red | 3064A | 34.92mA | 174.6mW | ---- | ------- |
| v1.0 | Shin Red | 3032A | 31mA | 155.1mW | ---- | -11.3%
| v1.1 | Shin Red | 3064A | 35mA | 175.1mW | +0.23% | ------ |
| v1.1 | Shin Red | 3032A | 30.1mA | 150.5mW | -3.01% | -15.11% |

Well that is an interesting result. The 3032A reduced power use as expected. The 3064A increased slightly... The 0.5mW increase is well within margin of error, so it's unchanged. The 3032A has reduced by a larger margin, but still only 3%. That is also within margin of error, so I'd say that is also unchanged. Not what I expected.

So what changed? I removed the code for the PRECHARGE logic. I had a feeling that the CPLD watching every clock cycle all the time was a waste of energy. Turns out that might not be the case. The 3032A only reduced power by 3% with itself. Further testing and data logs would be needed, along with more accurate measuring equipment, to prove or disprove it. I think I'll just say there are no gains here.

In any case, I feel v1.1 is a step forwards. That bit of code isn't needed anyway. Further optimising could come from stripping out the MBC1 detect logic, as I don't need it anyway.

Next I think is to try another game. One that doesn't use any of the RAM and also one with no ROM banking too. It's worth seeing how much current the CPLD uses when only tasked with ROM banking and also idling. Then finally, butcher one of my own DIY MBC5 carts to see what a 'normal' cart uses. I don't feel like butchering my original Nintendo carts.

### Further Analysis

I want to look at each measurment and see if we can make sense of it. First up,

**The Intro Animation**

So the intro animation recorded almost the lowest power usage. This is not a result I would expect having a whole bunch of animations on screen. My guess is the Gameboy is working hard, but not the cartridge. I would be willing to guess that most of the power being used is the CPLD in an idle state (I think that Alex said it was around 30mA) and the rest being the ROM chip. I'm not convinced the RAM chip is doing much of anything due to data further down the table.

So, I think the Gameboy is just streaming data out of one ROM bank for the whole intro as it does not vary much through the whole thing.

**Title Screen (Low & High)**

These two fit together nicely as it shows what is exactly going on. From memory reading about the Pokemon games, they make clever use of the cartridge RAM as work RAM. There is also a clever compression algorithm going on for sprite/graphics data. The low power draw is when the Pokemon graphic is stationary on screen, the jump in power is when the graphics slides off screen and slides in a new one. This is when the Gameboy must be shuffling data in and out of cartridge RAM from the ROM and between the Gameboy onboard RAM. The cartridge must be swapping RAM and ROM banks while doing this, causing all chips onboard to be busy bodies.

**Overworld**

I can't really explain this one. The power use varies depending on where you are located on the map. It doesn't make a whole lot of sense as things don't line up with expectations. On screen animations you may expect to cause higher power but that's not always the case. Bit of a mystery as I'd imagine everything needed to be displayed would be in RAM and while stationary, there can't be much game logic being streamed from the cart.

**Overworld Talking, Pokemon Centre Nurse, Pause Menu and Pokemon Stats**

This was a supprise but also a mystery to me. Having the lower white text box on screen always causes high cartridge power use. I could see why while loading the nex text panel and putting it on screen, but while sat stationary doesn't make sense to me. Does it have something to do with the Gameboy feature of being able to overlay a window on top of things?

**Battle Screen**

This one makes no sense to me but also does. I wouldn't expect huge power use on this screen with nothing going on, which is the case. Yet we just saw that all text boxes on screen cause power to jump, while the battle scene has exactly that going on. There are spikes in power as things change around on screen as you'd expect. Once more the Gameboy is doing a lot of work with sprites and animations.

## Same Test, Different Game

To be filled out
