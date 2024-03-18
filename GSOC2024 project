# Project Abstract.  

This project aims to improve the Raspberry Pi 4B(RPi4B) BSP support on RTEMS. Last year, RPi4B BSP supported GPIO, six UARTs, I2C, and IO interrupt. Although SPI and SD card are planned, they cannot be supported due to time reasons. This project intends to add the following supports to the RPi4B BSP: SPI support, Watchdog support and SD card support. Watchdog are essential in remote, automated systems such as Mars Exploration Rover.

# Project Description. 

Last year, Utkarsh Verma's project brought huge improvements to the RPi4 BSP.

The improvements he made are as follows:
Adding support for basic GPIO operations
Writing drivers to allows using any of the six UARTs
Refactoring the BSP to make it more configurable by the user
Making IO interrupt-driven for more efficient operation
Writing driver for the mailbox to allow the CPU to talk to the GPU
Adding I2C support

This project will continue his unfinished work, and bring some new improvements.

This project will bring the following improvements to RTEMS RPi4B BSP:
SPI driver support (GSOC2023 left),
Watchdog timer support,
SD R/W access support(GSOC2023 left).

SPI is a basic function. It will help users use RTEMS more conveniently.

A watchdog timer (WDT) is a timer that monitors microcontroller (MCU) programs to see if they are out of control or have stopped operating. It acts as a “watchdog” watching over MCU operation.

The Watchdog support makes the RTEMS be applying to some unmanned systems. In such systems, the computer cannot depend on a human to invoke a reboot if it hangs; it must be self-reliant. For example, remote embedded systems such as space probes are not physically accessible to human operators; these could become permanently disabled if they were unable to autonomously recover from faults.

why I chose this project:
I have been studying RTEMS for half a year. I've been using RPi4 since I first came into contact with RTEMS. I'm familiar enough with RPi4.
RTEMS is my master's research topic. I hope to learn RTEMS through this project.
