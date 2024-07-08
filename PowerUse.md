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

### Cart Power Only

I furthered these measurements with a different test setup, so as to get a more accurate idea of how much power the cart uses. I cut the thin part of the 5V plane and bridged it with a 0.5Ω shunt resistor. I wanted to try it this way, instead of my multimeter inline, to sanity check previous measurements and accuracy of my multimeter. The measurments below seem to match what Alex recorded in his blog. Bear in mind this is for the whole cart and Alex was using SRAM. So there will be some difference and innacuracies.

Alex's blog: https://www.insidegadgets.com/2018/08/12/building-a-2mb-mbc5-gameboy-cart-part-3-pcbs-arrived-adding-some-mbc1-support-and-troubleshooting-a-few-games/

1mV = 1mA x 2

This is for the EPM3032A cart. I would like to repeat these measurments for the 3064A version in the future.

| Pokemon Shin Red | Resistance Ω | Vdrop | Current mA | Power mW |
| ---------------- | ------------ | ----- | ---------- | -------- |
| Intro Animation | 0.5 | 19.2 | 38.4 | 192 |
| Title Screen | 0.5 | 19.4 | 38.8 | 194 |
| Overworld A | 0.5 | 20 | 40 | 200 |
| Overworld B | 0.5 | 21 | 42 | 210 |
| Overworld Talking | 0.5 | 26.1 | 52.2 | 261 |
| Pokemon Centre Nurse | 0.5 | 26.1 | 52.2 | 261 |
| Battle Scene | 0.5 | 23.3 | 46.6 | 233 |
| Pause Menu | 0.5 | 25.9 | 51.8 | 259 |
| Pokemon Stats | 0.5 | 26.1 | 52.2 | 261 |


