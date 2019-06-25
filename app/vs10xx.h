#ifndef __VS10XX_H__
#define __VS10XX_H__
#include "common.h"
#include "yingjian.h"
//与外部的接口
#define VS_DQ       PTC0_I  	//DREQ PTC0
/*#define VS_RST      PEout(6) 	//RST PTC1
#define VS_XCS      PFout(7)  	//XCS PTC2
#define VS_XDCS     PFout(6)  	//XDCS PTC3*/
//////////////////////////////////////////////////////////////
#define VS_WRITE_COMMAND 	0x02
#define VS_READ_COMMAND 	0x03
//VS10XX寄存器定义
#define SPI_MODE        	0x00   
#define SPI_STATUS      	0x01   
#define SPI_BASS        	0x02   
#define SPI_CLOCKF      	0x03   
#define SPI_DECODE_TIME 	0x04   
#define SPI_AUDATA      	0x05   
#define SPI_WRAM        	0x06   
#define SPI_WRAMADDR    	0x07   
#define SPI_HDAT0       	0x08   
#define SPI_HDAT1       	0x09 
  
#define SPI_AIADDR      	0x0a   
#define SPI_VOL         	0x0b   
#define SPI_AICTRL0     	0x0c   
#define SPI_AICTRL1     	0x0d   
#define SPI_AICTRL2     	0x0e   
#define SPI_AICTRL3     	0x0f   
#define SM_DIFF         	0x01   
#define SM_JUMP         	0x02   
#define SM_RESET        	0x04   
#define SM_OUTOFWAV     	0x08   
#define SM_PDOWN        	0x10   
#define SM_TESTS        	0x20   
#define SM_STREAM       	0x40   
#define SM_PLUSV        	0x80   
#define SM_DACT         	0x100   
#define SM_SDIORD       	0x200   
#define SM_SDISHARE     	0x400   
#define SM_SDINEW       	0x800   
#define SM_ADPCM        	0x1000   
#define SM_ADPCM_HP     	0x2000 		 

#define I2S_CONFIG			0XC040
#define GPIO_DDR			0XC017
#define GPIO_IDATA			0XC018
#define GPIO_ODATA			0XC019

void VS_WR_Cmd(uint8 address,uint16 data);	//写命令
void VS_HD_Reset(void);			    	//硬复位												 
uint8 VS_SPI_ReadWriteByte(uint8 data); 
void VS_Set_Vol(uint8 volx);				//设置主音量   
#endif