#include "common.h"
void SPI1_Init(void){
  SPI_InitTypeDef spi_init_param;
  //配置SPI
  spi_init_param.SPI_SPIx = SPI0;
  spi_init_param.SPI_SckDivider = SPI_SCK_DIV_32;//1.56Mhz
  spi_init_param.SPI_Pcs0Pin = PTA14;
  spi_init_param.SPI_SckPin  = PTA15;
  spi_init_param.SPI_MosiPin = PTA16;
  spi_init_param.SPI_MisoPin = PTA17;
  
  LPLD_SPI_Init(spi_init_param);
  LPLD_SPI_EnableIrq(spi_init_param);
}

void SPI1_SetSpeed(uint8 speed){
	/*SPI_InitTypeDef spi_init_param;
  //配置SPI
  spi_init_param.SPI_SPIx = SPI0;
  //spi_init_param.SPI_SckDivider = SPI_SCK_DIV_32;//1.56Mhz
  spi_init_param.SPI_Pcs0Pin = PTA14;
  spi_init_param.SPI_SckPin  = PTA15;
  spi_init_param.SPI_MosiPin = PTA16;
  spi_init_param.SPI_MisoPin = PTA17;
  
	if(speed==32)
		spi_init_param.SPI_SckDivider=SPI_SCK_DIV_32;
	else
		spi_init_param.SPI_SckDivider=SPI_SCK_DIV_8;
	LPLD_SPI_Init(spi_init_param);*/
  return;
}

uint8 SPI1_ReadWriteByte(uint8 data){
	return LPLD_SPI_Master_WriteRead(SPI0,(uint8)data,SPI_PCS0,SPI_PCS_ASSERTED);
}