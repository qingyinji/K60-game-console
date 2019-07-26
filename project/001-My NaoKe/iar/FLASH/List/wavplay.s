///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       11/Mar/2019  10:13:07
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\wavplay.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\wavplay.c" -D LPLD_K60 -lCN
//        "D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\" -lB
//        "D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\" -o
//        "D:\2019.IAR\project\001-My NaoKe\iar\FLASH\Obj\" --no_cse
//        --no_unroll --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "D:\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\app\" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\..\..\lib\CPU\" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\..\..\lib\common\" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\..\..\lib\LPLD\" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\..\..\lib\LPLD\HW\" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\..\..\lib\LPLD\DEV\" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\..\..\lib\uCOS-II\Ports\" -I "D:\2019.IAR\project\001-My
//        NaoKe\iar\..\..\..\lib\uCOS-II\Source\" -I
//        "D:\2019.IAR\project\001-My NaoKe\iar\..\..\..\lib\FatFs\" -I
//        "D:\2019.IAR\project\001-My NaoKe\iar\..\..\..\lib\FatFs\option\" -I
//        "D:\2019.IAR\project\001-My NaoKe\iar\..\..\..\lib\USB\common\" -I
//        "D:\2019.IAR\project\001-My NaoKe\iar\..\..\..\lib\USB\driver\" -I
//        "D:\2019.IAR\project\001-My NaoKe\iar\..\..\..\lib\USB\descriptor\"
//        -I "D:\2019.IAR\project\001-My NaoKe\iar\..\..\..\lib\USB\class\" -Ol
//        -I "D:\Embedded Workbench 7.0\arm\CMSIS\Include\" -D ARM_MATH_CM4
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\wavplay.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_DAC_SetBufferDataN
        EXTERN LPLD_PIT_Deinit
        EXTERN LPLD_PIT_EnableIrq
        EXTERN LPLD_PIT_Init
        EXTERN __aeabi_memcpy4
        EXTERN br
        EXTERN die
        EXTERN f_close
        EXTERN f_mount
        EXTERN f_open
        EXTERN f_read
        EXTERN fil
        EXTERN rc
        EXTERN volume

        PUBLIC Bitnum
        PUBLIC CHanalnum
        PUBLIC Check_Ifo
        PUBLIC DACdone
        PUBLIC DApc
        PUBLIC Get_num
        PUBLIC Playwav
        PUBLIC WAV_Init
        PUBLIC pit2_init_struct
        PUBLIC pit_time2
        PUBLIC wav1
        PUBLIC wav_buf

// D:\2019.IAR\project\001-My NaoKe\app\wavplay.c
//    1 #include "wavplay.h"
//    2 #include "yingjian.h"
//    3 #include "common.h"
//    4 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    5 PIT_InitTypeDef pit2_init_struct;
pit2_init_struct:
        DS8 20

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    6 WAV_file wav1;//wav文件
wav1:
        DS8 40

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    7 uint8 wav_buf[1024];
wav_buf:
        DS8 1024

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//    8 uint16 DApc;
DApc:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//    9 uint8 CHanalnum;
CHanalnum:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   10 uint8 Bitnum;
Bitnum:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   11 uint8 DACdone;
DACdone:
        DS8 1
//   12 extern uint8 volume;
//   13 extern FRESULT rc;     //结果代码 
//   14 extern FATFS fatfs,*fs;      // 文件系统对象 
//   15 extern FIL fil;      // 文件对象 
//   16 extern UINT bw, br;
//   17 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   18 void pit_time2(void){
pit_time2:
        PUSH     {R7,LR}
//   19 	uint16 temp;
//   20       if(Bitnum==8)//8位精度
        LDR.N    R0,??DataTable2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??pit_time2_0
//   21       {
//   22         //DAC->DHR12R1=wav_buf[DApc]*10/volume;//通道1的12位右对齐数据
//   23         LPLD_DAC_SetBufferDataN(DAC0,wav_buf[DApc]*10/volume,1);
        MOVS     R2,#+1
        LDR.N    R0,??DataTable2_1
        LDR.N    R1,??DataTable2_2
        LDRH     R1,[R1, #+0]
        LDRB     R0,[R1, R0]
        MOVS     R1,#+10
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable2_3
        LDRB     R1,[R1, #+0]
        SDIV     R1,R0,R1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable2_4  ;; 0x400cc000
        BL       LPLD_DAC_SetBufferDataN
//   24         DApc++;
        LDR.N    R0,??DataTable2_2
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable2_2
        STRH     R0,[R1, #+0]
        B.N      ??pit_time2_1
//   25       }
//   26       else if(Bitnum==16)//16位精度(先低位后高位)
??pit_time2_0:
        LDR.N    R0,??DataTable2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+16
        BNE.N    ??pit_time2_1
//   27       {
//   28         temp=(((uint8)(wav_buf[DApc+1]-0x80)<<4)|(wav_buf[DApc]>>4))*10/volume;
        LDR.N    R0,??DataTable2_1
        LDR.N    R1,??DataTable2_2
        LDRH     R1,[R1, #+0]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+1]
        SUBS     R0,R0,#+128
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable2_1
        LDR.N    R2,??DataTable2_2
        LDRH     R2,[R2, #+0]
        LDRB     R1,[R2, R1]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSRS     R1,R1,#+4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ORRS     R0,R1,R0, LSL #+4
        MOVS     R1,#+10
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable2_3
        LDRB     R1,[R1, #+0]
        SDIV     R1,R0,R1
//   29         LPLD_DAC_SetBufferDataN(DAC0,temp,1);
        MOVS     R2,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable2_4  ;; 0x400cc000
        BL       LPLD_DAC_SetBufferDataN
//   30         DApc+=2;        
        LDR.N    R0,??DataTable2_2
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+2
        LDR.N    R1,??DataTable2_2
        STRH     R0,[R1, #+0]
//   31       } 
//   32     if(DApc==512)DACdone=1;
??pit_time2_1:
        LDR.N    R0,??DataTable2_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+512
        BNE.N    ??pit_time2_2
        MOVS     R0,#+1
        LDR.N    R1,??DataTable2_5
        STRB     R0,[R1, #+0]
//   33     if(DApc==1024){DApc=0;DACdone=1;}                                         
??pit_time2_2:
        LDR.N    R0,??DataTable2_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1024
        BNE.N    ??pit_time2_3
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_2
        STRH     R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable2_5
        STRB     R0,[R1, #+0]
//   34 }
??pit_time2_3:
        POP      {R0,PC}          ;; return
//   35 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   36 uint8 WAV_Init(uint8* pbuf)//初始化并显示文件信息
//   37 {
WAV_Init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   38 	if(Check_Ifo(pbuf,"RIFF"))return 1;//RIFF标志错误
        LDR.N    R1,??DataTable2_6
        MOVS     R0,R4
        BL       Check_Ifo
        CMP      R0,#+0
        BEQ.N    ??WAV_Init_0
        MOVS     R0,#+1
        B.N      ??WAV_Init_1
//   39 	wav1.wavlen=Get_num(pbuf+4,4);//文件长度，数据偏移4byte
??WAV_Init_0:
        MOVS     R1,#+4
        ADDS     R0,R4,#+4
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STR      R0,[R1, #+4]
//   40 	if(Check_Ifo(pbuf+8,"WAVE"))return 2;//WAVE标志错误
        LDR.N    R1,??DataTable2_8
        ADDS     R0,R4,#+8
        BL       Check_Ifo
        CMP      R0,#+0
        BEQ.N    ??WAV_Init_2
        MOVS     R0,#+2
        B.N      ??WAV_Init_1
//   41 	if(Check_Ifo(pbuf+12,"fmt "))return 3;//fmt标志错误
??WAV_Init_2:
        LDR.N    R1,??DataTable2_9
        ADDS     R0,R4,#+12
        BL       Check_Ifo
        CMP      R0,#+0
        BEQ.N    ??WAV_Init_3
        MOVS     R0,#+3
        B.N      ??WAV_Init_1
//   42 	wav1.formart=Get_num(pbuf+20,2);//格式类别
??WAV_Init_3:
        MOVS     R1,#+2
        ADDS     R0,R4,#+20
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STRH     R0,[R1, #+16]
//   43 	wav1.CHnum=Get_num(pbuf+22,2);//通道数
        MOVS     R1,#+2
        ADDS     R0,R4,#+22
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STRH     R0,[R1, #+18]
//   44 	CHanalnum=wav1.CHnum;
        LDR.N    R0,??DataTable2_7
        LDRH     R0,[R0, #+18]
        LDR.N    R1,??DataTable2_10
        STRB     R0,[R1, #+0]
//   45 	wav1.SampleRate=Get_num(pbuf+24,4);//采样率
        MOVS     R1,#+4
        ADDS     R0,R4,#+24
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STR      R0,[R1, #+20]
//   46 	wav1.speed=Get_num(pbuf+28,4);//音频传送速率
        MOVS     R1,#+4
        ADDS     R0,R4,#+28
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STR      R0,[R1, #+24]
//   47 	wav1.ajust=Get_num(pbuf+32,2);//数据块调速数
        MOVS     R1,#+2
        ADDS     R0,R4,#+32
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STRH     R0,[R1, #+28]
//   48 	wav1.SampleBits=Get_num(pbuf+34,2);//样本数据位数
        MOVS     R1,#+2
        ADDS     R0,R4,#+34
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STRH     R0,[R1, #+30]
//   49 	Bitnum=wav1.SampleBits;
        LDR.N    R0,??DataTable2_7
        LDRH     R0,[R0, #+30]
        LDR.N    R1,??DataTable2
        STRB     R0,[R1, #+0]
//   50 	if(Check_Ifo(pbuf+36,"data"))return 4;//data标志错误
        LDR.N    R1,??DataTable2_11
        ADDS     R0,R4,#+36
        BL       Check_Ifo
        CMP      R0,#+0
        BEQ.N    ??WAV_Init_4
        MOVS     R0,#+4
        B.N      ??WAV_Init_1
//   51 	wav1.DATAlen=Get_num(pbuf+40,4);//数据长度	
??WAV_Init_4:
        MOVS     R1,#+4
        ADDS     R0,R4,#+40
        BL       Get_num
        LDR.N    R1,??DataTable2_7
        STR      R0,[R1, #+36]
//   52 	///////////////////////////////////////////////
//   53 	/*if(wav1.wavlen<0x100000)
//   54 	{
//   55 		LCD_ShowNum(170,30,(wav1.wavlen)>>10,3,16);//文件长度
//   56 		LCD_ShowString(200,30,"Kb");
//   57 	}
//   58 	else
//   59 	{
//   60 		LCD_ShowNum(170,30,(wav1.wavlen)>>20,3,16);//文件长度
//   61 		LCD_ShowString(200,30,"Mb");
//   62 	}
//   63 	if(wav1.formart==1)LCD_ShowString(170,50,"WAV PCM");
//   64 	if(wav1.CHnum==1)LCD_ShowString(170,70,"single");
//   65 	else LCD_ShowString(170,70,"stereo");
//   66 	LCD_ShowNum(170,90,(wav1.SampleRate)/1000,3,16);//采样率
//   67 	LCD_ShowString(200,90,"KHz");
//   68 	LCD_ShowNum(170,110,(wav1.speed)/1000,3,16);//传送速度
//   69 	LCD_ShowString(200,110,"bps");
//   70 	LCD_ShowNum(177,130,wav1.SampleBits,2,16);//样本数据位数
//   71 	LCD_ShowString(200,130,"bit");*/
//   72 	return 0;
        MOVS     R0,#+0
??WAV_Init_1:
        POP      {R4,PC}          ;; return
//   73 }
//   74 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   75 uint8 Playwav(uint8 qumu)
//   76 {
Playwav:
        PUSH     {R3-R5,LR}
//   77 	uint16 i,times;
//   78 	/*F_Open(CurFile);
//   79 	F_Read(CurFile,wav_buf);//先读512字节到
//   80 	F_Read(CurFile,wav_buf+512);//再读512字节*/
//   81 
//   82 	f_open(&fil, "0:/music/test.wav", FA_READ);
        MOVS     R2,#+1
        LDR.N    R1,??DataTable2_12
        LDR.N    R0,??DataTable2_13
        BL       f_open
//   83 	f_read(&fil,wav_buf,512,&br);
        LDR.N    R3,??DataTable2_14
        MOV      R2,#+512
        LDR.N    R1,??DataTable2_1
        LDR.N    R0,??DataTable2_13
        BL       f_read
//   84 	f_read(&fil,wav_buf+512,512,&br);
        LDR.N    R3,??DataTable2_14
        MOV      R2,#+512
        LDR.N    R1,??DataTable2_15
        LDR.N    R0,??DataTable2_13
        BL       f_read
//   85 
//   86 	while(WAV_Init(wav_buf));
??Playwav_0:
        LDR.N    R0,??DataTable2_1
        BL       WAV_Init
        CMP      R0,#+0
        BNE.N    ??Playwav_0
//   87 	//LCD_ShowString(35,70,"format illegal!");
//   88 	//根据采样率（wav1.SampleRate）设置定时器，在中断中进行DA转换
//   89 	DACdone=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_5
        STRB     R0,[R1, #+0]
//   90 	DApc=44;//DA转换地址(跳过头信息)
        MOVS     R0,#+44
        LDR.N    R1,??DataTable2_2
        STRH     R0,[R1, #+0]
//   91 	//LCD_DrawRectangle(18,258,222,272);//进度框
//   92 	//LCD_Fill(20,260,220,270,WHITE);//进度条
//   93 	pit2_init_struct.PIT_Pitx = PIT2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable2_16
        STRB     R0,[R1, #+0]
//   94   	pit2_init_struct.PIT_PeriodUs =1000000/wav1.SampleRate; //定时周期
        LDR.N    R0,??DataTable2_17  ;; 0xf4240
        LDR.N    R1,??DataTable2_7
        LDR      R1,[R1, #+20]
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable2_16
        STR      R0,[R1, #+4]
//   95   	pit2_init_struct.PIT_Isr = pit_time2;  //设置中断函数
        LDR.N    R0,??DataTable2_18
        LDR.N    R1,??DataTable2_16
        STR      R0,[R1, #+16]
//   96   	LPLD_PIT_Init(pit2_init_struct);//初始化PIT2 
        LDR.N    R1,??DataTable2_16
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_PIT_Init
//   97   	LPLD_PIT_EnableIrq(pit2_init_struct);
        LDR.N    R1,??DataTable2_16
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_PIT_EnableIrq
//   98 	//Timerx_Init(1000000/wav1.SampleRate,72);//1MHz的计数频率,产生和采样率一样的中断频率
//   99 	times=(wav1.DATAlen>>10)-1;
        LDR.N    R0,??DataTable2_7
        LDR      R0,[R0, #+36]
        LSRS     R0,R0,#+10
        SUBS     R4,R0,#+1
//  100 	for(i=0;i<times;i++)//循环一次转换1KB数据
        MOVS     R5,#+0
        B.N      ??Playwav_1
//  101 	{	
//  102 		while(!DACdone);//等待前面512字节转换完成
??Playwav_2:
        LDR.N    R0,??DataTable2_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Playwav_2
//  103 		DACdone=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_5
        STRB     R0,[R1, #+0]
//  104 		//F_Read(CurFile,wav_buf);//读512字节
//  105 		f_read(&fil,wav_buf,512,&br);
        LDR.N    R3,??DataTable2_14
        MOV      R2,#+512
        LDR.N    R1,??DataTable2_1
        LDR.N    R0,??DataTable2_13
        BL       f_read
//  106 		//LCD_Fill(20,260,20+(200*i/times),270,BLUE);//进度条
//  107 		while(!DACdone);//等待前面512字节转换完成
??Playwav_3:
        LDR.N    R0,??DataTable2_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Playwav_3
//  108 		DACdone=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_5
        STRB     R0,[R1, #+0]
//  109 		//F_Read(CurFile,wav_buf+512);//读512字节
//  110 		f_read(&fil,wav_buf+512,512,&br);	
        LDR.N    R3,??DataTable2_14
        MOV      R2,#+512
        LDR.N    R1,??DataTable2_15
        LDR.N    R0,??DataTable2_13
        BL       f_read
//  111 	}
        ADDS     R5,R5,#+1
??Playwav_1:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R5,R4
        BCC.N    ??Playwav_2
//  112 	LPLD_PIT_Deinit(pit2_init_struct);
        LDR.N    R1,??DataTable2_16
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_PIT_Deinit
//  113 	rc = f_close(&fil);
        LDR.N    R0,??DataTable2_13
        BL       f_close
        LDR.N    R1,??DataTable2_19
        STRB     R0,[R1, #+0]
//  114     if (rc) die(rc);
        LDR.N    R0,??DataTable2_19
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Playwav_4
        LDR.N    R0,??DataTable2_19
        LDRB     R0,[R0, #+0]
        BL       die
//  115     //printf("\n解除挂载.\n");
//  116     f_mount(0,NULL);
??Playwav_4:
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       f_mount
//  117 	return 0;
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  118 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     Bitnum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     wav_buf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     DApc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     volume

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0x400cc000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     DACdone

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     wav1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     CHanalnum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_11:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_12:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_13:
        DC32     fil

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_14:
        DC32     br

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_15:
        DC32     wav_buf+0x200

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_16:
        DC32     pit2_init_struct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_17:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_18:
        DC32     pit_time2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_19:
        DC32     rc
//  119 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  120 uint8 Check_Ifo(uint8* pbuf1,uint8* pbuf2)
//  121 {
Check_Ifo:
        PUSH     {R4}
//  122 	uint8 i;
//  123 	for(i=0;i<4;i++)if(pbuf1[i]!=pbuf2[i])return 1;//不同
        MOVS     R2,#+0
        B.N      ??Check_Ifo_0
??Check_Ifo_1:
        ADDS     R2,R2,#+1
??Check_Ifo_0:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+4
        BGE.N    ??Check_Ifo_2
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDRB     R3,[R2, R0]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDRB     R4,[R2, R1]
        CMP      R3,R4
        BEQ.N    ??Check_Ifo_1
        MOVS     R0,#+1
        B.N      ??Check_Ifo_3
//  124 	return 0;//相同
??Check_Ifo_2:
        MOVS     R0,#+0
??Check_Ifo_3:
        POP      {R4}
        BX       LR               ;; return
//  125 }
//  126 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  127 uint32 Get_num(uint8* pbuf,uint8 len)
//  128 {
//  129     uint32 num;
//  130 	if(len==2)num=(pbuf[1]<<8)|pbuf[0];
Get_num:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+2
        BNE.N    ??Get_num_0
        LDRB     R1,[R0, #+1]
        LDRB     R0,[R0, #+0]
        ORRS     R2,R0,R1, LSL #+8
        B.N      ??Get_num_1
//  131 	else if(len==4)num=(pbuf[3]<<24)|(pbuf[2]<<16)|(pbuf[1]<<8)|pbuf[0];
??Get_num_0:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+4
        BNE.N    ??Get_num_1
        LDRB     R1,[R0, #+3]
        LDRB     R2,[R0, #+2]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R0, #+1]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R0,[R0, #+0]
        ORRS     R2,R0,R1
//  132 	return num;
??Get_num_1:
        MOVS     R0,R2
        BX       LR               ;; return
//  133 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 "RIFF"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "WAVE"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "fmt "
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "data"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "0:/music/test.wav"
        DC8 0, 0

        END
// 
// 1 089 bytes in section .bss
//    52 bytes in section .rodata
//   790 bytes in section .text
// 
//   790 bytes of CODE  memory
//    52 bytes of CONST memory
// 1 089 bytes of DATA  memory
//
//Errors: none
//Warnings: 2
