---
layout: post
title:  "GSoC 2024 Final Submission: BSP Improvements for RPi4"
---

This year RTEMS support gitlab.

Project Proposal: https://docs.google.com/document/d/1NjlUSWhqwUvrsQPBISU05ah0I0IGkEuq6BIThrkMBsg/edit?usp=sharing

Project epic: https://gitlab.rtems.org/groups/rtems/-/epics/6


# Goal
This project aims to improve the Raspberry Pi 4B BSP support on RTEMS. Project intends to add the following supports to the Raspberry Pi 4B BSP: SPI support, Watchdog support and SD card support.

# Work Done

## GPIO Driver

The gpio driver is necessary for the development of other peripheral drivers. 

Merge requests:
- [aarch64/raspberrypi: Add gpio driver (merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/59)
- [raspberrypi4.rst: Documation for the gpio driver(merged)](https://gitlab.rtems.org/rtems/docs/rtems-docs/-/merge_requests/18)

issues: 
- [Add gpio driver for aarch64/raspberrypi BSP](https://gitlab.rtems.org/rtems/rtos/rtems/-/issues/5029)

Repository:
- https://gitlab.rtems.org/yangn0/rtems/-/tree/gpio?ref_type=heads

These codes were mainly completed by GSOC2023 student Utkarsh Verma. Due to some reasons they could not be merged. I improved and merged them as a co-author.

## Refactor the PL011 Peripheral Controller Driver

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

## SPI Driver
Finished the SPI driver for Raspberry Pi 4B BSP.

Merge requests:
- [aarch64/raspberrypi: Add SPI support (Merged)](https://gitlab.rtems.org/rtems/rtos/rtems/-/merge_requests/103)

issues:
- [Add SPI support to Raspberry Pi 4B BSP (Closed)](https://gitlab.rtems.org/rtems/rtos/rtems/-/issues/5056)

<iframe width="560" height="315"
src="https://www.youtube.com/embed/MUQfKFzIOeU" 
frameborder="0" 
allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" 
allowfullscreen>
</iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/DFtzoiYVMiQ?si=sG2gWWefTS6fUv-X" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>