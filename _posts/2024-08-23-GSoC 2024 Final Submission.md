---
layout: post
title:  "GSoC 2024 Final Submission: BSP Improvements for RPi4"
---

Project Proposal: [https://docs.google.com/document/d/1NjlUSWhqwUvrsQPBISU05ah0I0IGkEuq6BIThrkMBsg/edit?usp=sharing](https://docs.google.com/document/d/1NjlUSWhqwUvrsQPBISU05ah0I0IGkEuq6BIThrkMBsg/edit?usp=sharing)

Project epic: [https://gitlab.rtems.org/groups/rtems/-/epics/6](https://gitlab.rtems.org/groups/rtems/-/epics/6)

## Goal
This project aims to improve the Raspberry Pi 4B BSP support on RTEMS. Project intends to add the following supports to the Raspberry Pi 4B BSP: SPI support, Watchdog support and SD card support.

## Work Done

### GPIO Driver

The gpio driver is necessary for the development of other peripheral drivers. 

Merge requests:
- [aarch64/raspberrypi: Add gpio driver (merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/59)
- [raspberrypi4.rst: Documation for the gpio driver(merged)](https://gitlab.rtems.org/rtems/docs/rtems-docs/-/merge_requests/18)

issues:
- [Add gpio driver for aarch64/raspberrypi BSP](https://gitlab.rtems.org/rtems/rtos/rtems/-/issues/5029)

Repository:
- [https://gitlab.rtems.org/yangn0/rtems/-/tree/gpio?ref_type=heads](https://gitlab.rtems.org/yangn0/rtems/-/tree/gpio?ref_type=heads)

These codes were mainly completed by GSOC2023 student Utkarsh Verma. Due to some reasons they could not be merged. I improved and merged them as a co-author.

### Refactor the PL011 Peripheral Controller Driver

- Refactor the pl011 driver to be extensible.
- Add IRQ support and baudrate configuration support for pl011 driver.
- Modify related BSP.

This is an unplanned task, but it is very meaningful and will be an improvement that is shared by many arm BSPs.

Merge requests:
- [Add new PL011 driver with IRQ support (Closed)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/43)
- [dev/serial: Refactor the pl011 driver to be extensible (Open)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/47)

issues:
- [Refactor the pl011 driver to be extensible](https://gitlab.rtems.org/rtems/rtos/rtems/-/issues/5026)

These codes were mainly completed by GSOC2023 student Utkarsh Verma. Due to some reasons they could not be merged. I improved and merged them as a co-author.

### SPI Driver
Finished the SPI driver for Raspberry Pi 4B BSP and SSD1306 driver. I connected a 1306 OLED screen to RPi4 via SPI and output the RTEMS logo.

Merge requests:
- [aarch64/raspberrypi: Add SPI support (Merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/103)

issues:
- [Add SPI support to Raspberry Pi 4B BSP (Closed)](https://gitlab.rtems.org/rtems/rtos/rtems/-/issues/5056)

SSD1306 Driver:
- [https://github.com/yangn0/RTEMS_app/blob/main/test/test_SSD1306.c](https://github.com/yangn0/RTEMS_app/blob/main/test/test_SSD1306.c)

Blog Post:
- [Add SPI support for RTEMS Raspberrypi4 BSP](https://yangn0.github.io/2024/07/24/Add-SPI-support-for-RTEMS-Raspberrypi4-BSP.html)

<iframe width="560" height="315" src="https://www.youtube.com/embed/DFtzoiYVMiQ?si=sG2gWWefTS6fUv-X" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

### Timer
Finished the system timer support and the Wathdog Timer driver.

Merge requests:
- [bsps/aarch64/raspberrypi: Add system timer support (Merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/commit/00f0d307b49097236dd10329456bb4103c283024)
- [aarch64/raspberrypi: Add Watchdog Timer driver (Merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/120)

WDT test:
- [https://github.com/yangn0/RTEMS_app/blob/main/test/test_WDT.c](https://github.com/yangn0/RTEMS_app/blob/main/test/test_WDT.c)

Blog Post:
- [RTEMS RPi4B BSP add system timer driver support](https://yangn0.github.io/2024/05/22/RTEMS-RPi4B-BSP-add-system-timer-driver-support.html)

### FDT support for sdhci
[FDT support for sdhci (Unmerged)](https://gitlab.rtems.org/yangn0/rtems/-/commit/470d9cb763b4689b519ef069b61717d7a23c7780)

### bug
Some bugs I found and fixed.

[termios: scanf() is not blocking in UART interrupt mode (Merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/issues/5012)

[Found RTEMS_FATAL_SOURCE_SPURIOUS_INTERRUPT fatal of a72_lp64_qemu BSP related to clock interrupt. ](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/29)

[bsps/xilinx-versal: fix BSP_INTERRUPT_VECTOR_COUNT too large (Merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/51)

[dev/pl011: Fix incorrect macro definition (Merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/64)

## Current State
I completed most of the tasks in the proposal such as SPI support (polling mode and interrupt mode), watchdog support, and some unplanned tasks such as improving and merging gpio and pl011 driver.

## Work Left
### 1. sdhci driver
The sdhci driver in freebsd requires BSP to support DMA, FDT, and mailbox. If I want to port it to libbsd, I need to implement DMA support, FDT support, and mailbox support first. There is a lot of work to support sd card. I only implemented [FDT support for sdhci (Unmerged)](https://gitlab.rtems.org/yangn0/rtems/-/commit/470d9cb763b4689b519ef069b61717d7a23c7780). So the left work is DMA support, mailbox support and SD card support.
And the FDT support for sdhci may still need improvement.  

### 2. GSOC2023 unmerged code
There is still some unmerged code from Utkarsh Verma.

I will focus on RTEMS in the next two years, continue to work and complete them.

## Unmerged MR
- [dev/serial: Refactor the pl011 driver to be extensible (Open)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/47)

## Conclusion
I was very lucky. RTEMS was migrated to gitlab in the early stage of GSOC2024. This greatly reduced the difficulty of code merging. All my questions were answered promptly. I learned more about RTEMS and embedded development. Contributed to a very worthy cause and worked with many RTEMS people and great mentors from various parts of the world. I really enjoy working with RTEMS.

I would like to thank my mentors, and the whole RTEMS community for every suggestion, discussion, and comment which helps me to deal with all the difficulties and problems. I would also like to thank Google for providing this opportunity.