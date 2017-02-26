/*
 * stm32f429zi linker script
 */

ENTRY(reset_handler)

MEMORY
{
    FLASH1 (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K
    FLASH2 (rx)  : ORIGIN = 0x08100000, LENGTH = 1024K
    CCMRAM (rw)  : ORIGIN = 0x10000000, LENGTH = 64K
    SRAM1  (rwx) : ORIGIN = 0x20000000, LENGTH = 112K
    SRAM2  (rwx) : ORIGIN = 0x2001C000, LENGTH = 16K
    SRAM3  (rwx) : ORIGIN = 0x20020000, LENGTH = 64K
}

SECTIONS
{
    .vectors : {
        KEEP(*(.vectors))
    } > FLASH1

    .text : {
        *(.text*)
    } > FLASH1

    .rodata : {
        *(.rodata*)
    } > FLASH1

    .data : {
        *(.data*)
    } > SRAM1 AT > FLASH1

    .bss : {
        *(.bss*)
        *(COMMON)
    } > SRAM1

    /DISCARD/ : {
        *(.ARM.exidx*)
        *(.ARM.extab*)
    }

    __stack_top  = ORIGIN(SRAM3) + LENGTH(SRAM3);
    __data_load  = LOADADDR(.data);
    __data_start = ADDR(.data);
    __data_end   = ADDR(.data) + SIZEOF(.data);
    __bss_start  = ADDR(.bss);
    __bss_end    = ADDR(.bss) + SIZEOF(.bss);

    end = .;
}

/*
 * hardware registers
 */
TIM2          = 0x40000000;
TIM3          = 0x40000400;
TIM4          = 0x40000800;
TIM5          = 0x40000c00;
TIM6          = 0x40001000;
TIM7          = 0x40001400;
TIM12         = 0x40001800;
TIM13         = 0x40001c00;
TIM14         = 0x40002000;
RTC           = 0x40002800;
WWDG          = 0x40002c00;
IWDG          = 0x40003000;
I2S2ext       = 0x40003400;
SPI2          = 0x40003800;
SPI3          = 0x40003c00;
I2S3ext       = 0x40004000;
USART2        = 0x40004400;
USART3        = 0x40004800;
UART4         = 0x40004c00;
UART5         = 0x40005000;
I2C1          = 0x40005400;
I2C2          = 0x40005800;
I2C3          = 0x40005c00;
CAN1          = 0x40006400;
CAN2          = 0x40006800;
PWR           = 0x40007000;
DAC           = 0x40007400;
UART7         = 0x40007800;
UART8         = 0x40007c00;
TIM1          = 0x40010000;
TIM8          = 0x40010400;
USART1        = 0x40011000;
USART6        = 0x40011400;
ADC1          = 0x40012000;
ADC2          = 0x40012100;
ADC3          = 0x40012200;
C_ADC         = 0x40012300;
SDIO          = 0x40012c00;
SPI1          = 0x40013000;
SPI4          = 0x40013400;
SYSCFG        = 0x40013800;
EXTI          = 0x40013c00;
TIM9          = 0x40014000;
TIM10         = 0x40014400;
TIM11         = 0x40014800;
SPI5          = 0x40015000;
SPI6          = 0x40015400;
SAI           = 0x40015800;
LTDC          = 0x40016800;
GPIOA         = 0x40020000;
GPIOB         = 0x40020400;
GPIOC         = 0x40020800;
GPIOD         = 0x40020c00;
GPIOE         = 0x40021000;
GPIOF         = 0x40021400;
GPIOG         = 0x40021800;
GPIOH         = 0x40021c00;
GPIOI         = 0x40022000;
GPIOJ         = 0x40022400;
GPIOK         = 0x40022800;
CRC           = 0x40023000;
RCC           = 0x40023800;
FLASH         = 0x40023c00;
DMA1          = 0x40026000;
DMA2          = 0x40026400;
Ethernet_MAC  = 0x40028000;
Ethernet_MMC  = 0x40028100;
Ethernet_PTP  = 0x40028700;
Ethernet_DMA  = 0x40029000;
DMA2D         = 0x4002b000;
OTG_HS_GLOBAL = 0x40040000;
OTG_HS_HOST   = 0x40040400;
OTG_HS_DEVICE = 0x40040800;
OTG_HS_PWRCLK = 0x40040e00;
OTG_FS_GLOBAL = 0x50000000;
OTG_FS_HOST   = 0x50000400;
OTG_FS_DEVICE = 0x50000800;
OTG_FS_PWRCLK = 0x50000e00;
DCMI          = 0x50050000;
RNG           = 0x50060800;
FMC           = 0xa0000000;
NVIC          = 0xe000e000;
DBG           = 0xe0042000;

/*
 * interrupt handlers
 */
PROVIDE(reset_handler                 = default_handler);
PROVIDE(nmi_handler                   = default_handler);
PROVIDE(hardfault_handler             = default_handler);
PROVIDE(memmanage_handler             = default_handler);
PROVIDE(busfault_handler              = default_handler);
PROVIDE(usagefault_handler            = default_handler);
PROVIDE(svc_handler                   = default_handler);
PROVIDE(debugmon_handler              = default_handler);
PROVIDE(pendsv_handler                = default_handler);
PROVIDE(systick_handler               = default_handler);
PROVIDE(wwdg_irqhandler               = default_handler);
PROVIDE(pvd_irqhandler                = default_handler);
PROVIDE(tamp_stamp_irqhandler         = default_handler);
PROVIDE(rtc_wkup_irqhandler           = default_handler);
PROVIDE(flash_irqhandler              = default_handler);
PROVIDE(rcc_irqhandler                = default_handler);
PROVIDE(exti0_irqhandler              = default_handler);
PROVIDE(exti1_irqhandler              = default_handler);
PROVIDE(exti2_irqhandler              = default_handler);
PROVIDE(exti3_irqhandler              = default_handler);
PROVIDE(exti4_irqhandler              = default_handler);
PROVIDE(dma1_stream0_irqhandler       = default_handler);
PROVIDE(dma1_stream1_irqhandler       = default_handler);
PROVIDE(dma1_stream2_irqhandler       = default_handler);
PROVIDE(dma1_stream3_irqhandler       = default_handler);
PROVIDE(dma1_stream4_irqhandler       = default_handler);
PROVIDE(dma1_stream5_irqhandler       = default_handler);
PROVIDE(dma1_stream6_irqhandler       = default_handler);
PROVIDE(adc_irqhandler                = default_handler);
PROVIDE(can1_tx_irqhandler            = default_handler);
PROVIDE(can1_rx0_irqhandler           = default_handler);
PROVIDE(can1_rx1_irqhandler           = default_handler);
PROVIDE(can1_sce_irqhandler           = default_handler);
PROVIDE(exti9_5_irqhandler            = default_handler);
PROVIDE(tim1_brk_tim9_irqhandler      = default_handler);
PROVIDE(tim1_up_tim10_irqhandler      = default_handler);
PROVIDE(tim1_trg_com_tim11_irqhandler = default_handler);
PROVIDE(tim1_cc_irqhandler            = default_handler);
PROVIDE(tim2_irqhandler               = default_handler);
PROVIDE(tim3_irqhandler               = default_handler);
PROVIDE(tim4_irqhandler               = default_handler);
PROVIDE(i2c1_ev_irqhandler            = default_handler);
PROVIDE(i2c1_er_irqhandler            = default_handler);
PROVIDE(i2c2_ev_irqhandler            = default_handler);
PROVIDE(i2c2_er_irqhandler            = default_handler);
PROVIDE(spi1_irqhandler               = default_handler);
PROVIDE(spi2_irqhandler               = default_handler);
PROVIDE(usart1_irqhandler             = default_handler);
PROVIDE(usart2_irqhandler             = default_handler);
PROVIDE(usart3_irqhandler             = default_handler);
PROVIDE(exti15_10_irqhandler          = default_handler);
PROVIDE(rtc_alarm_irqhandler          = default_handler);
PROVIDE(otg_fs_wkup_irqhandler        = default_handler);
PROVIDE(tim8_brk_tim12_irqhandler     = default_handler);
PROVIDE(tim8_up_tim13_irqhandler      = default_handler);
PROVIDE(tim8_trg_com_tim14_irqhandler = default_handler);
PROVIDE(tim8_cc_irqhandler            = default_handler);
PROVIDE(dma1_stream7_irqhandler       = default_handler);
PROVIDE(fmc_irqhandler                = default_handler);
PROVIDE(sdio_irqhandler               = default_handler);
PROVIDE(tim5_irqhandler               = default_handler);
PROVIDE(spi3_irqhandler               = default_handler);
PROVIDE(uart4_irqhandler              = default_handler);
PROVIDE(uart5_irqhandler              = default_handler);
PROVIDE(tim6_dac_irqhandler           = default_handler);
PROVIDE(tim7_irqhandler               = default_handler);
PROVIDE(dma2_stream0_irqhandler       = default_handler);
PROVIDE(dma2_stream1_irqhandler       = default_handler);
PROVIDE(dma2_stream2_irqhandler       = default_handler);
PROVIDE(dma2_stream3_irqhandler       = default_handler);
PROVIDE(dma2_stream4_irqhandler       = default_handler);
PROVIDE(eth_irqhandler                = default_handler);
PROVIDE(eth_wkup_irqhandler           = default_handler);
PROVIDE(can2_tx_irqhandler            = default_handler);
PROVIDE(can2_rx0_irqhandler           = default_handler);
PROVIDE(can2_rx1_irqhandler           = default_handler);
PROVIDE(can2_sce_irqhandler           = default_handler);
PROVIDE(otg_fs_irqhandler             = default_handler);
PROVIDE(dma2_stream5_irqhandler       = default_handler);
PROVIDE(dma2_stream6_irqhandler       = default_handler);
PROVIDE(dma2_stream7_irqhandler       = default_handler);
PROVIDE(usart6_irqhandler             = default_handler);
PROVIDE(i2c3_ev_irqhandler            = default_handler);
PROVIDE(i2c3_er_irqhandler            = default_handler);
PROVIDE(otg_hs_ep1_out_irqhandler     = default_handler);
PROVIDE(otg_hs_ep1_in_irqhandler      = default_handler);
PROVIDE(otg_hs_wkup_irqhandler        = default_handler);
PROVIDE(otg_hs_irqhandler             = default_handler);
PROVIDE(dcmi_irqhandler               = default_handler);
PROVIDE(hash_rng_irqhandler           = default_handler);
PROVIDE(fpu_irqhandler                = default_handler);
PROVIDE(uart7_irqhandler              = default_handler);
PROVIDE(uart8_irqhandler              = default_handler);
PROVIDE(spi4_irqhandler               = default_handler);
PROVIDE(spi5_irqhandler               = default_handler);
PROVIDE(spi6_irqhandler               = default_handler);
PROVIDE(sai1_irqhandler               = default_handler);
PROVIDE(ltdc_irqhandler               = default_handler);
PROVIDE(ltdc_er_irqhandler            = default_handler);
PROVIDE(dma2d_irqhandler              = default_handler);
