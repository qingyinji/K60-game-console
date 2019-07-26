#ifndef __WAV_H
#define __WAV_H	
#include "yingjian.h"
#include "common.h"

typedef struct 
{
	uint8 chRIFF[4];
	uint32 wavlen;
	uint8 chWAV[4];
	uint8 chFMT[4];
	uint16 formart;
	uint16 CHnum;
	uint32 SampleRate;
	uint32 speed;
	uint16 ajust;
	uint16 SampleBits;
	uint8 chDATA[4];
	uint32 DATAlen;
}WAV_file;


uint8 WAV_Init(uint8* pbuf);
uint8 Playwav(uint8 qumu);
uint8 Check_Ifo(uint8* pbuf1,uint8* pbuf2);
uint32 Get_num(uint8* pbuf,uint8 len);
void pit_time2(void);

#endif
