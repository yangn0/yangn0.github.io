---
layout: post
title:  "RTEMS RPi4B BSP add system timer driver support"
---

# Abstract

RPi4 has two timers, ARM timer and system timer.

The ARM Timer is based on a ARM SP804, but it has a number of differences with the standard SP804.

The clock from the ARM timer is derived from the system clock. This clock can
change dynamically e.g. if the system goes into reduced power or in low power
mode. Thus the clock speed adapts to the overall system performance
capabilities. For accurate timing it is recommended to use the system timers.

RPi4 BSP currently uses ARM timer to provide clock. The driver file is `bsps/shared/dev/clock/arm-generic-timer.c`.

I added the system timer driver to provide accurate timing.

# Detail
1. According to the data sheet, the system timer of RPi4 (BCM2811) is compatible with RPi1-3 (BCM2835). Ported the system timer driver located in `bsps/arm/raspberrypi/clock/clockdrv.c` to the shared directory `bsps/shared/dev/clock/bcm2835-system-timer.c`. The `spec` file of rpi1-3 BSP needs to be modified. `spec/build/bsps/arm/raspberrypi/obj.yml`.

2. Add system timer support for RPi4 BSP.
    - Modify the `bsps/aarch64/raspberrypi/include/bsp/irq.h` file. Add system timer interrupt number.
    
    ```c
    #define BCM2711_IRQ_VC_PERIPHERAL_BASE 96

    /* Interrupt Vectors: System Timer */
    #define BCM2835_IRQ_ID_GPU_TIMER_M0    (BCM2711_IRQ_VC_PERIPHERAL_BASE + 0)
    #define BCM2835_IRQ_ID_GPU_TIMER_M1    (BCM2711_IRQ_VC_PERIPHERAL_BASE + 1)
    #define BCM2835_IRQ_ID_GPU_TIMER_M2    (BCM2711_IRQ_VC_PERIPHERAL_BASE + 2)
    #define BCM2835_IRQ_ID_GPU_TIMER_M3    (BCM2711_IRQ_VC_PERIPHERAL_BASE + 3)
    ```

    - Modify the `bsps/aarch64/raspberrypi/include/bsp/raspberrypi.h` file. Compatible with BCM2835 system timer in variable naming.
    - Create a new `spec/build/bsps/aarch64/raspberrypi/objsystemtimer.yml` file and introduce system timer.
    - Use the `enabled-by: not:` field in `spec/build/bsps/aarch64/raspberrypi/objclock.yml` to implement the selection of ARM timer and system timer.
    ```yml
    enabled-by:
        not: BSP_CLOCK_USE_SYSTEMTIMER
    ```
    - Create a new file `spec/build/bsps/aarch64/raspberrypi/optsystemtimer.yml`. If the configuration is `true`, the system timer will be used, and if it is `false`, the ARM timer will be used.