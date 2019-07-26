#ifndef  _YINGJIAN_H  //必须确保header guard宏名永不重名
#define  _YINGJIAN_H
#include "common.h"
void init_gpio(void);//初始化gpio口  
void adc_init(void);//初始化ADC
void pit_init(void);//初始化PIT定时器
void pwm_init(void);//初始化PWM模块
void SPI_Init(uint8 spi);
void delay(int ms);
void delay_us(int us);
void key(void);
void portb_isr(void);
void pit_time(void);
void pit_time0(void);
void dac_init(void);
void playmusic(uint16 play);
#endif