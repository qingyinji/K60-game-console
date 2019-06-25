#ifndef _LQOLED_H
#define _LQOLED_H
//#include"stc.h"
//#include "intrins.h"
 	#define byte  unsigned char
	#define word  unsigned int
	#define dword unsigned long
 void LCD_Init(void);
 void LCD_CLS(void);
 void LCD_P6x8Str(byte x,byte y,byte ch[]);
 void LCD_P8x16Str(byte x,byte y,byte ch[]);
 void LCD_P14x16Ch(byte x,byte y,byte N);
 void LCD_P14x16Ch1(byte x,byte y,byte N);
 void LCD_P16x8Ch(byte x,byte y,byte N);
 void LCD_P8x8Ch(byte x,byte y,byte N);
 void LCD_P128x64Ch(void);
 void LCD_P128x64Ch1(void);
 void LCD_Fill(byte dat);

 void LCD_HLFCLS(void);
 void chess_board();
 void chess_board1();
 void MY_LCD(unsigned char y, unsigned int bmp_dat);
 //void LCD_kuan(int kuan);
 void LCD_badapple(unsigned char x,unsigned char y);
 void LCD_siping(unsigned char x,unsigned char N);
 void LCD_tuxing(byte x,byte y,byte N);
 void LCD_tuxing1(byte x,byte y,byte N);
 void LCD_tuxing2(byte x,byte y,byte N);
#endif
