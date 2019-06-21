---
date: 2019-06-01
title: X-MEM
description: ""
tags: [AMSTRAD]

---

****************************************
               X - M E M 
              GET STARTED!

  2014 Arnold Computer Multi-Expansion
****************************************


INTRODUCTION
============

Thank you for choosing this new ACME hardware for your good old CPC! The X-MEM is the state of the art of the memory expansions. It embeds up to 512K RAM/ROM and allows to replace the Lower ROM and ROM 0 to use different Firmwares and BASIC to push all CPC at the same level of compatibility.


X-MEM DIAGRAM
=============
                  (1) (2) (3)
                   |   |   |
+----------------------------+
| +------------+ [=-][=-][=-]|
| |  512K ROM  |    +------+ |
| +------------+ || |      | |
| +------------+    |      | |
| |  512K RAM  | !! +------+ |
| +------------+ ( )   .[..] | --(4)
+----------------------------+
|_____________||_____________| --(5)

1. CPC 464/6128 switch       = Set RAM mode for 464/664 or 6128	
2. BOOT CPC/ROM switch       = Set boot mode from CPC or X-MEM
3. ROM LOCK/FREE switch      = Set ROM write protect, like a floppy tab
4. READ ROM NO/YES jumper    = Ignore the ROM part. Rescue mode only!
5. Expansion port connector  = To MotherX4 or CPC using a ribbon cable

WARNING: Moving the ROM switch when the BOOT switch is set to ROM should hang the CPC!
Leave it set to FREE will not corrupt the data and will allow a more simple X-MEM usage.


RAM MAPPING
===========

8x 64K banks (of 4x16K pages) are available from &7Fxx,&C0 to &7Fxx,&FF
+-----------------------+-------------------------------------------------------------------+
|    BANK     S   M   M |                 CPC BASE RAM / X-MEM EXTENDED RAM                 |
| 5   4   3   2   1   0 |   #0000-#3FFF     #4000-#7FFF      #8000-#BFFF      #C000-#FFFF   |
+-----------+---+---+---+----------------+----------------+----------------+----------------+
|     -     | 0 | 0 | 0 |   CPC page 0   |   CPC page 1   |   CPC page 2   |   CPC page 3   |
|     B     | 0 | 0 | 1 |   CPC page 0   |   CPC page 1   |   CPC page 2   | Bank B, page 3 |
|     B     | 0 | 1 | 0 | Bank B, page 0 | Bank B, page 1 | Bank B, page 2 | Bank B, page 3 |
|     B     | 0 | 1 | 1 |   CPC page 0   |   CPC page 3   |   CPC page 2   | Bank B, page 3 |
+-----------+---+---+---+----------------+----------------+----------------+----------------+
|     B     | 1 |   P   |   CPC page 0   | Bank B, page P |   CPC page 2   |   CPC page 3   |
+-----------+---+-------+-------------------------------------------------------------------+
Due to a Gate Array limitation, the â€œC3â€ mode with upper selected will wrongly map the ROM at #4000.
Because X-MEM decode A8 to allow up to 1MB RAM, you have to deal with that for the memory access.


ROM MAPPING
===========

32 ROMs (4x8) of 16K each are available from the buffer &DFxx,
+-------------------------------+------------------+---------------------------------------+
|       X-MEM 8bit buffer       |     Firmware     |             X-MEM ROM ID              |
| 7   6   5   4   3   2   1   0 |  Initialization  |               (bit5=0)                |
+---+---+---+---+---+---+---+---+------------------+----+----+----+----+----+----+----+----+
| 0 | 0 | - | 0 | 0 | P | P | P |      FW1.0       |  0 |  1 |  2 |  3 |  4 |  5 |  6 |  7 |
| 0 | 0 | - | 0 | 1 | P | P | P |   FW2.0, FW3.0   |  8 |  9 | 10 | 11 | 12 | 13 | 14 | 15 |
| 0 | 0 | - | 1 | 0 | P | P | P |                  | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 |
| 0 | 0 | - | 1 | 1 | P | P | P |      FW3.14      | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 |
+---+---+---+---+---+---+---+---+------------------+----+----+----+----+----+----+----+----+
The ROM 7 is not altered by the X-MEM device. The Firmware is used instead. 
You must set the bit5 to 1 for writing the Lower ROM (&47) and ROM 0 (&40).


X-MEM FLOPPY DISC UTILITIES
===========================
 
1. X-MEM Init Pass
------------------
This program allows to clear all the 32 ROMs stored inside your X-MEM board.

RUN"INIT"

The process takes one minute to erase all the slots. After that, your X-MEM will be not able to boot if you donâ€™t install it first. Donâ€™t forget to set the BOOT switch (2) to "CPC" position to continue.

2. X-MEM Install Pass
---------------------
This program allows to install the X-MEM after the Init pass. Also, it can update the Firmware and BASIC, targeting your CPC and keyboard layout. 

RUN"INSTALL"

The process takes some seconds for programming the Lower ROM, ROM 0 and ROM 1. Then you will be able to choose the CPC target model for programming the X-MEM. Optionally, you can install CP/M on ROM8 and ROM9.

ROM 1 is used to extend the Firmware 3.15 with:
- 256K or 448K "C" RAM Drive. Use |C from BASIC or C: from CP/M.
- |HELP command, for displaying information about installed ROMs.
- |FLASH command, for programming ROMs from the BASIC.

3. X-MEM Rescue Pass
--------------------
If your X-MEM is programmed with one (or more) defective ROM(s) that prevent your computer to boot properly, please turn it off. After that, set the READ ROM jumper (4) to "NO" and turn it on again. 

RUN"RESCUE"

In all these cases, make sure that your X-MEM ROM switch (3) is set to "FREE".
For software updates and support, please visit: http://www.centpourcent.net


FIRMWARE 3.15
=============

1. FW Boot
----------
Display the real amount of RAM and the CRTC type of your computer. 
You can skip the ROMs initialization by keeping the ESC key pressed while (re)booting. 
Itâ€™s a safe way to run conflicting programs and avoids to apply a rescue pass.

2. ROMs Init
------------
The Firmware 3.15 initializes the first 32 ROMs with RSX support on all CPCs. 
The ROMs messages are disabled to boot faster and not scroll the screen.

3. Burning ROMs
---------------
You can program from BASIC the X-MEM ROMs: |FLASH,, or |FLASH,,  
i.e. |FLASH,&4000,15 set the ROM 15 with 16K loaded at &4000.
i.e. |FLASH,"FILENAME.ROM",15 set the ROM 15 with a given filename.

4. Display ROMs
---------------
You can display from BASIC the X-MEM ROMs: |HELP or |HELP,
i.e. |HELP display all the 32 X-MEM ROMs slots with name, versions, type and addresses.
i.e. |HELP,7 display the ROM 7 name, version, type, address and the RSXs commands list.


TROUBLESHOOTING
===============

Q1: After plugging properly the expansion, I get random bugs or no display. 
A1: Check the boot switch (2) position and clean your CPC Expansion port.

Q2: All programs donâ€™t detect the extra RAM on my 464/664 and fail to run. 
A2: Check the RAM switch (1) position, then your +5V power supply.

Q3: My favorite utilities fail to program the X-MEM ROMs. (RMA, ROMAN,...) 
A3: Check the ROM switch (3) position. Use only the provided programs.

Q4: After programming some ROMs, my CPC gets sticked at FW initialization. 
A4: Try to boot with the ESC key pressed, then apply the X-MEM rescue pass.

Q5: After turning off my CPC, I lose the content of the "C" RAM Drive.
A5: To keep the RAM Drive content, you can plug the X-MEM to the MotherX4 with a 5V PSU.
