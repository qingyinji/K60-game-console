///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       19/Mar/2019  21:54:30
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\vs10xx.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\vs10xx.c" -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\vs10xx.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_GPIO_Output_b
        EXTERN delay
        EXTERN delay_us

        PUBLIC VS_HD_Reset
        PUBLIC VS_SPI_ReadWriteByte
        PUBLIC VS_Send_MusicData
        PUBLIC VS_WR_Cmd

// D:\2019.IAR\project\001-My NaoKe\app\vs10xx.c
//    1 #include "vs10xx.h"	
//    2 #include "common.h"
//    3 #include "yingjian.h"	  	    
//    4 ////////////////////////////////////////////////////////////////////////////////
//    5 //移植时候的接口
//    6 //data:要写入的数据
//    7 //返回值:读到的数据

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    8 uint8 VS_SPI_ReadWriteByte(uint8 data)
//    9 {			  	 
//   10 	//return LPLD_SPI_Master_Write(SPI0,data,SPI_PCS0,SPI_PCS_ASSERTED);	  
//   11 }
VS_SPI_ReadWriteByte:
        BX       LR               ;; return
//   12   
//   13 ////////////////////////////////////////////////////////////////////////////////	 	 
//   14 //硬复位MP3
//   15 //返回1:复位失败;0:复位成功	   

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   16 void VS_HD_Reset(void)
//   17 {
VS_HD_Reset:
        PUSH     {R4,LR}
//   18 	uint8 retry=0;
        MOVS     R4,#+0
//   19 	//VS_RST=0;
//   20 	LPLD_GPIO_Output_b(PTC,1,0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   21 	delay(100);
        MOVS     R0,#+100
        BL       delay
//   22 	//VS_XDCS=1;//取消数据传输
//   23 	LPLD_GPIO_Output_b(PTC,3,1);
        MOVS     R2,#+1
        MOVS     R1,#+3
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   24 	//VS_XCS=1;//取消数据传输
//   25 	LPLD_GPIO_Output_b(PTC,2,1);
        MOVS     R2,#+1
        MOVS     R1,#+2
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   26 	//VS_RST=1;
//   27 	LPLD_GPIO_Output_b(PTC,1,1);
        MOVS     R2,#+1
        MOVS     R1,#+1
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   28 	//VS_WR_Cmd(0x00,0x08,0x04);
//   29 	delay(10);	   
        MOVS     R0,#+10
        BL       delay
        B.N      ??VS_HD_Reset_0
//   30 	while(VS_DQ==0&&retry<200)//等待DREQ为高
//   31 	{
//   32 		retry++;
??VS_HD_Reset_1:
        ADDS     R4,R4,#+1
//   33 		delay_us(50);
        MOVS     R0,#+50
        BL       delay_us
//   34 	};
??VS_HD_Reset_0:
        LDR.N    R0,??DataTable2_1  ;; 0x43fe1200
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??VS_HD_Reset_2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+200
        BLT.N    ??VS_HD_Reset_1
//   35 	delay(100);
??VS_HD_Reset_2:
        MOVS     R0,#+100
        BL       delay
//   36 	//if(retry>=200)return 1;
//   37 	//else return 0;
//   38 	/* VS_WR_Cmd(0x03,0x98,0x00);
//   39 	delay(10);
//   40     VS_WR_Cmd(0x05,0xbb,0x81);
//   41 	delay(10);
//   42 	VS_WR_Cmd(0x02,0x00,0x55);
//   43 	delay(10);
//   44 	VS_WR_Cmd(0x0b,0x20,0x20);
//   45 	delay(10);
//   46 	LPLD_SPI_Master_Write(SPI0,0,SPI_PCS0,SPI_PCS_ASSERTED);
//   47 	LPLD_SPI_Master_Write(SPI0,0,SPI_PCS0,SPI_PCS_ASSERTED);
//   48 	LPLD_SPI_Master_Write(SPI0,0,SPI_PCS0,SPI_PCS_ASSERTED);
//   49 	LPLD_SPI_Master_Write(SPI0,0,SPI_PCS0,SPI_PCS_ASSERTED);  */		    		 
//   50 }
        POP      {R4,PC}          ;; return
//   51 //向VS10XX写命令
//   52 //address:命令地址
//   53 //data:命令数据

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   54 void VS_WR_Cmd(uint8 address,uint16 data){
VS_WR_Cmd:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   55 	while(!VS_DQ);//等待空闲		  	   
??VS_WR_Cmd_0:
        LDR.N    R0,??DataTable2_1  ;; 0x43fe1200
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??VS_WR_Cmd_0
//   56 	//VS_XDCS=1;
//   57 	LPLD_GPIO_Output_b(PTC,3,1); 	 
        MOVS     R2,#+1
        MOVS     R1,#+3
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   58 	//VS_XCS=0;
//   59 	LPLD_GPIO_Output_b(PTC,2,0); 	 
        MOVS     R2,#+0
        MOVS     R1,#+2
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   60 	VS_SPI_ReadWriteByte(VS_WRITE_COMMAND);//发送VS10XX的写命令
        MOVS     R0,#+2
        BL       VS_SPI_ReadWriteByte
//   61 	VS_SPI_ReadWriteByte(address); 	//地址
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       VS_SPI_ReadWriteByte
//   62 	VS_SPI_ReadWriteByte(data>>8); 	//发送高八位
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LSRS     R0,R5,#+8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       VS_SPI_ReadWriteByte
//   63 	VS_SPI_ReadWriteByte(data);	 	//第八位
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       VS_SPI_ReadWriteByte
//   64 	//VS_XCS=1;
//   65 	LPLD_GPIO_Output_b(PTC,2,1);              
        MOVS     R2,#+1
        MOVS     R1,#+2
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   66 } 
        POP      {R0,R4,R5,PC}    ;; return
//   67 
//   68 //发送一次音频数据
//   69 //固定为32字节
//   70 //返回值:0,发送成功
//   71 //		 1,VS10xx不缺数据,本次数据未成功发送    

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   72 uint8 VS_Send_MusicData(uint8* buf)
//   73 {
VS_Send_MusicData:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//   74 	uint8 n;
//   75 	if(VS_DQ!=0)  //送数据给VS10XX
        LDR.N    R0,??DataTable2_1  ;; 0x43fe1200
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??VS_Send_MusicData_0
//   76 	{			   	 
//   77 		//VS_XDCS=0;
//   78 		LPLD_GPIO_Output_b(PTC,3,0);  
        MOVS     R2,#+0
        MOVS     R1,#+3
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   79         for(n=0;n<32;n++)
        MOVS     R5,#+0
        B.N      ??VS_Send_MusicData_1
//   80 		{
//   81 			VS_SPI_ReadWriteByte(buf[n]);	 			
??VS_Send_MusicData_2:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDRB     R0,[R5, R4]
        BL       VS_SPI_ReadWriteByte
//   82 		}
        ADDS     R5,R5,#+1
??VS_Send_MusicData_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+32
        BLT.N    ??VS_Send_MusicData_2
//   83 		//VS_XDCS=1;
//   84 		LPLD_GPIO_Output_b(PTC,3,1);     				   
        MOVS     R2,#+1
        MOVS     R1,#+3
        LDR.N    R0,??DataTable2  ;; 0x400ff080
        BL       LPLD_GPIO_Output_b
//   85 	}else return 1;
//   86 	return 0;//成功发送了
        MOVS     R0,#+0
        B.N      ??VS_Send_MusicData_3
??VS_Send_MusicData_0:
        MOVS     R0,#+1
??VS_Send_MusicData_3:
        POP      {R1,R4,R5,PC}    ;; return
//   87 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0x400ff080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x43fe1200

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//   88 
//   89 //设定VS10XX播放的音量
//   90 //volx:音量大小(0~254)
//   91 /* void VS_Set_Vol(uint8 volx)
//   92 {
//   93     uint16 volt=0; 			//暂存音量值
//   94     volt=254-volx;			//取反一下,得到最大值,表示最大的表示 
//   95 	volt<<=8;
//   96     volt+=254-volx;			//得到音量设置后大小
//   97     VS_WR_Cmd(SPI_VOL,volt);//设音量 
//   98 } */
// 
// 236 bytes in section .text
// 
// 236 bytes of CODE memory
//
//Errors: none
//Warnings: 1
