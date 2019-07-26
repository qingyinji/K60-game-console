///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       28/Dec/2018  12:27:12
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\naospi.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\naospi.c" -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\naospi.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_SPI_EnableIrq
        EXTERN LPLD_SPI_Init
        EXTERN LPLD_SPI_Master_WriteRead
        EXTERN __aeabi_memcpy4

        PUBLIC SPI1_Init
        PUBLIC SPI1_ReadWriteByte
        PUBLIC SPI1_SetSpeed

// D:\2019.IAR\project\001-My NaoKe\app\naospi.c
//    1 #include "common.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    2 void SPI1_Init(void){
SPI1_Init:
        PUSH     {LR}
        SUB      SP,SP,#+92
//    3   SPI_InitTypeDef spi_init_param;
//    4   //配置SPI
//    5   spi_init_param.SPI_SPIx = SPI0;
        LDR.N    R0,??DataTable1  ;; 0x4002c000
        STR      R0,[SP, #+36]
//    6   spi_init_param.SPI_SckDivider = SPI_SCK_DIV_32;//1.56Mhz
        MOVS     R0,#+5
        STRB     R0,[SP, #+41]
//    7   spi_init_param.SPI_Pcs0Pin = PTA14;
        MOVS     R0,#+14
        STRB     R0,[SP, #+52]
//    8   spi_init_param.SPI_SckPin  = PTA15;
        MOVS     R0,#+15
        STRB     R0,[SP, #+58]
//    9   spi_init_param.SPI_MosiPin = PTA16;
        MOVS     R0,#+16
        STRB     R0,[SP, #+59]
//   10   spi_init_param.SPI_MisoPin = PTA17;
        MOVS     R0,#+17
        STRB     R0,[SP, #+60]
//   11   
//   12   LPLD_SPI_Init(spi_init_param);
        ADD      R1,SP,#+36
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+52
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_SPI_Init
//   13   LPLD_SPI_EnableIrq(spi_init_param);
        ADD      R1,SP,#+36
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+52
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_SPI_EnableIrq
//   14 }
        ADD      SP,SP,#+92
        POP      {PC}             ;; return
//   15 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   16 void SPI1_SetSpeed(uint8 speed){
//   17 	/*SPI_InitTypeDef spi_init_param;
//   18   //配置SPI
//   19   spi_init_param.SPI_SPIx = SPI0;
//   20   //spi_init_param.SPI_SckDivider = SPI_SCK_DIV_32;//1.56Mhz
//   21   spi_init_param.SPI_Pcs0Pin = PTA14;
//   22   spi_init_param.SPI_SckPin  = PTA15;
//   23   spi_init_param.SPI_MosiPin = PTA16;
//   24   spi_init_param.SPI_MisoPin = PTA17;
//   25   
//   26 	if(speed==32)
//   27 		spi_init_param.SPI_SckDivider=SPI_SCK_DIV_32;
//   28 	else
//   29 		spi_init_param.SPI_SckDivider=SPI_SCK_DIV_8;
//   30 	LPLD_SPI_Init(spi_init_param);*/
//   31   return;
SPI1_SetSpeed:
        BX       LR               ;; return
//   32 }
//   33 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   34 uint8 SPI1_ReadWriteByte(uint8 data){
SPI1_ReadWriteByte:
        PUSH     {R7,LR}
//   35 	return LPLD_SPI_Master_WriteRead(SPI0,(uint8)data,SPI_PCS0,SPI_PCS_ASSERTED);
        MOVS     R3,#+1
        MOVS     R2,#+1
        MOVS     R1,R0
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable1  ;; 0x4002c000
        BL       LPLD_SPI_Master_WriteRead
        POP      {R1,PC}          ;; return
//   36 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x4002c000

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
// 102 bytes in section .text
// 
// 102 bytes of CODE memory
//
//Errors: none
//Warnings: none
