///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       14/May/2019  18:35:29
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\jianmian.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\jianmian.c" -D LPLD_K60 -lCN
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
//    List file    =  
//        D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\jianmian.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_CLS
        EXTERN LCD_P14x16Ch
        EXTERN LCD_P8x16Str
        EXTERN LCD_tuxing
        EXTERN LCD_tuxing1
        EXTERN LCD_tuxing2
        EXTERN delay
        EXTERN gameing
        EXTERN gamestart
        EXTERN huatu
        EXTERN key
        EXTERN key_down
        EXTERN key_left
        EXTERN key_right
        EXTERN key_up
        EXTERN mosixuanzi
        EXTERN playmusic
        EXTERN readsd

        PUBLIC djm
        PUBLIC jianmian
        PUBLIC jmms
        PUBLIC xtjianmian

// D:\2019.IAR\project\001-My NaoKe\app\jianmian.c
//    1 #include "common.h"
//    2 #include "LQ12864.h"
//    3 #include "jianmian.h"
//    4 #include "yingjian.h"
//    5 #include "huatu.h"
//    6 extern uint16 mosixuanzi,gamestart,gameing;
//    7 extern uint16 key_up,key_down,key_left,key_right;

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//    8 uint8 djm=1,jmms;
djm:
        DATA
        DC8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
jmms:
        DS8 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    9 void jianmian(void){
jianmian:
        PUSH     {R2-R4,LR}
//   10   uint8 jmi,jma[5]={1,0,0,0,0};
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable1
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//   11   jmms=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable1_1
        STRB     R0,[R1, #+0]
        B.N      ??jianmian_0
//   12   while(djm){
//   13     key();
//   14     for(jmi=0;jmi<5;jmi++)
//   15       LCD_tuxing(jmi*26,0,jma[jmi]);
//   16     for(jmi=0;jmi<6;jmi++){
//   17       LCD_tuxing1(0,jmi+2,0);
//   18       LCD_tuxing1(127,jmi+2,0);
//   19   }
//   20     for(jmi=2;jmi<126;jmi++)
//   21       LCD_tuxing1(jmi,7,1);
//   22   switch (mosixuanzi){
//   23     case 1:for (uint16 i=0;i<3;++i){
//   24            LCD_P14x16Ch(72+14*i,3,i+6);}
//   25            LCD_tuxing2(15,3,0);
//   26            break;//推箱子
//   27     case 2:for (uint16 i=0;i<2;++i){
//   28            LCD_P14x16Ch(72+14*i,3,i+28);}LCD_P14x16Ch(72+14*2,3,15);
//   29            LCD_tuxing2(15,3,2);
//   30            break;//扫雷
//   31     case 3:for (uint16 i=0;i<3;++i){
//   32            LCD_P14x16Ch(72+14*i,3,i+34);}
//   33            LCD_tuxing2(15,3,1);
//   34            break;//五子棋
//   35     case 4:LCD_P8x16Str(72,3,"Flash ");
//   36            LCD_tuxing2(15,3,3);
//   37            break;//bad Apple
//   38     case 5:for (uint16 i=0;i<2;++i){
//   39            LCD_P14x16Ch(72+14*i,3,i+57);}LCD_P14x16Ch(72+14*2,3,15);
//   40            LCD_tuxing2(15,3,4);
//   41            break;//其他
//   42   }
//   43 
//   44     if(key_left==0){
//   45       delay(500);
//   46       if(key_left==0){
//   47         mosixuanzi--;
//   48         playmusic(2);
//   49         if(mosixuanzi==0)
//   50           mosixuanzi=5;
//   51          }while(!key_left){key();}
//   52        }
//   53     if(key_right==0){
//   54       delay(500);
//   55       if(key_right==0){
//   56         mosixuanzi++;
//   57         playmusic(2);
//   58         if(mosixuanzi==6)
//   59           mosixuanzi=1;
//   60       }while(!key_right){key();}
//   61     }
//   62     for(jmi=0;jmi<5;jmi++)
//   63       jma[jmi]=0;
??jianmian_1:
        MOVS     R0,#+0
        ADD      R1,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
        ADDS     R4,R4,#+1
??jianmian_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BLT.N    ??jianmian_1
//   64     jma[mosixuanzi-1]=1;
        MOVS     R0,#+1
        ADD      R1,SP,#+0
        LDR.W    R2,??DataTable1_2
        LDRH     R2,[R2, #+0]
        ADDS     R1,R2,R1
        STRB     R0,[R1, #-1]
??jianmian_0:
        LDR.W    R0,??DataTable1_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.W    ??jianmian_3
        BL       key
        MOVS     R4,#+0
        B.N      ??jianmian_4
??jianmian_5:
        ADD      R0,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R2,[R4, R0]
        MOVS     R1,#+0
        MOVS     R0,#+26
        SMULBB   R0,R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_tuxing
        ADDS     R4,R4,#+1
??jianmian_4:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BLT.N    ??jianmian_5
        MOVS     R4,#+0
        B.N      ??jianmian_6
??jianmian_7:
        MOVS     R2,#+0
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+0
        BL       LCD_tuxing1
        MOVS     R2,#+0
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+127
        BL       LCD_tuxing1
        ADDS     R4,R4,#+1
??jianmian_6:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+6
        BLT.N    ??jianmian_7
        MOVS     R4,#+2
        B.N      ??jianmian_8
??jianmian_9:
        MOVS     R2,#+1
        MOVS     R1,#+7
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_tuxing1
        ADDS     R4,R4,#+1
??jianmian_8:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+126
        BLT.N    ??jianmian_9
        LDR.W    R0,??DataTable1_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??jianmian_10
        BCC.N    ??jianmian_11
        CMP      R0,#+3
        BEQ.N    ??jianmian_12
        BCC.N    ??jianmian_13
        CMP      R0,#+5
        BEQ.N    ??jianmian_14
        BCC.N    ??jianmian_15
        B.N      ??jianmian_11
??jianmian_10:
        MOVS     R4,#+0
        B.N      ??jianmian_16
??jianmian_17:
        ADDS     R2,R4,#+6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R4,R4,#+1
??jianmian_16:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+3
        BLT.N    ??jianmian_17
        MOVS     R2,#+0
        MOVS     R1,#+3
        MOVS     R0,#+15
        BL       LCD_tuxing2
        B.N      ??jianmian_11
??jianmian_13:
        MOVS     R4,#+0
        B.N      ??jianmian_18
??jianmian_19:
        ADDS     R2,R4,#+28
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R4,R4,#+1
??jianmian_18:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??jianmian_19
        MOVS     R2,#+15
        MOVS     R1,#+3
        MOVS     R0,#+100
        BL       LCD_P14x16Ch
        MOVS     R2,#+2
        MOVS     R1,#+3
        MOVS     R0,#+15
        BL       LCD_tuxing2
        B.N      ??jianmian_11
??jianmian_12:
        MOVS     R4,#+0
        B.N      ??jianmian_20
??jianmian_21:
        ADDS     R2,R4,#+34
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R4,R4,#+1
??jianmian_20:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+3
        BLT.N    ??jianmian_21
        MOVS     R2,#+1
        MOVS     R1,#+3
        MOVS     R0,#+15
        BL       LCD_tuxing2
        B.N      ??jianmian_11
??jianmian_15:
        LDR.N    R2,??DataTable1_4
        MOVS     R1,#+3
        MOVS     R0,#+72
        BL       LCD_P8x16Str
        MOVS     R2,#+3
        MOVS     R1,#+3
        MOVS     R0,#+15
        BL       LCD_tuxing2
        B.N      ??jianmian_11
??jianmian_14:
        MOVS     R4,#+0
        B.N      ??jianmian_22
??jianmian_23:
        ADDS     R2,R4,#+57
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R4,R4,#+1
??jianmian_22:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??jianmian_23
        MOVS     R2,#+15
        MOVS     R1,#+3
        MOVS     R0,#+100
        BL       LCD_P14x16Ch
        MOVS     R2,#+4
        MOVS     R1,#+3
        MOVS     R0,#+15
        BL       LCD_tuxing2
??jianmian_11:
        LDR.N    R0,??DataTable1_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??jianmian_24
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable1_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??jianmian_25
        LDR.N    R0,??DataTable1_2
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable1_2
        STRH     R0,[R1, #+0]
        MOVS     R0,#+2
        BL       playmusic
        LDR.N    R0,??DataTable1_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??jianmian_25
        MOVS     R0,#+5
        LDR.N    R1,??DataTable1_2
        STRH     R0,[R1, #+0]
        B.N      ??jianmian_25
??jianmian_26:
        BL       key
??jianmian_25:
        LDR.N    R0,??DataTable1_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??jianmian_26
??jianmian_24:
        LDR.N    R0,??DataTable1_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??jianmian_27
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable1_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??jianmian_28
        LDR.N    R0,??DataTable1_2
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable1_2
        STRH     R0,[R1, #+0]
        MOVS     R0,#+2
        BL       playmusic
        LDR.N    R0,??DataTable1_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??jianmian_28
        MOVS     R0,#+1
        LDR.N    R1,??DataTable1_2
        STRH     R0,[R1, #+0]
        B.N      ??jianmian_28
??jianmian_29:
        BL       key
??jianmian_28:
        LDR.N    R0,??DataTable1_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??jianmian_29
??jianmian_27:
        MOVS     R4,#+0
        B.N      ??jianmian_2
//   65   }
//   66   djm=1;gamestart=1;
??jianmian_3:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable1_3
        STRB     R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable1_7
        STRH     R0,[R1, #+0]
//   67 LCD_CLS();
        BL       LCD_CLS
//   68 }
        POP      {R0,R1,R4,PC}    ;; return
//   69 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   70 void xtjianmian(void){
xtjianmian:
        PUSH     {R4-R6,LR}
//   71   uint8 xtshu=1;
        MOVS     R4,#+1
//   72   LCD_P14x16Ch(105,xtshu*2+1,16);
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
//   73   uint8 a=33;
        MOVS     R0,#+33
//   74   uint8 b=45;
        MOVS     R1,#+45
//   75   uint8 d=1;
        MOVS     R5,#+1
        B.N      ??xtjianmian_0
//   76 while(1){
//   77 while(d){
//   78   if(gamestart==0)
//   79     return;
//   80   key();
//   81   for (uint8 i=0;i<2;++i){LCD_P14x16Ch(40+30*i,0,i+64);}
//   82   for (uint8 i=0;i<5;++i){LCD_P14x16Ch(25+16*i,3,i+59);}
//   83   //LCD_P8x16Str(16,0,"Flash Player");
//   84   //LCD_P8x16Str(20,3,"666666");
//   85   LCD_P8x16Str(25,5,"  SD Card");
//   86   LCD_P14x16Ch(105,xtshu*2+1,16);
//   87     if(key_up==0){
//   88       delay(500);
//   89       if(key_up==0){
//   90         xtshu--;
//   91         playmusic(2);
//   92         if(xtshu==0)
//   93           xtshu=2;
//   94     LCD_P14x16Ch(105,3,15);
//   95     LCD_P14x16Ch(105,5,15);
//   96     //LCD_P14x16Ch(105,6,15);
//   97     LCD_P14x16Ch(105,xtshu*2+1,16);
//   98       }while(!key_up){key();}
//   99     }
//  100     if(key_down==0){
//  101       delay(500);
//  102       if(key_down==0){
//  103         xtshu++;
//  104         playmusic(2);
//  105         if(xtshu==3)
//  106           xtshu=1;
//  107     LCD_P14x16Ch(105,3,15);
//  108     LCD_P14x16Ch(105,5,15);
//  109     //LCD_P14x16Ch(105,6,15);
//  110     LCD_P14x16Ch(105,xtshu*2+1,16);
//  111       }while(!key_down){key();}
//  112     }
//  113     if(key_left==0||key_right==0){
//  114       delay(500);
//  115       if(key_left==0||key_right==0){
//  116         d=0;
//  117       }while(!key_left||!key_right){key();}
//  118     }
//  119   }
//  120   LCD_CLS();
//  121   gameing=1;
//  122   if(xtshu==1){
//  123     mosixuanzi=6;
//  124     huatu();
//  125     mosixuanzi=5;
//  126   }
//  127   else
//  128   readsd();
??xtjianmian_1:
        BL       readsd
//  129   LCD_CLS();
??xtjianmian_2:
        BL       LCD_CLS
//  130   gamestart=1;d=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable1_7
        STRH     R0,[R1, #+0]
        MOVS     R5,#+1
//  131   delay(100);
        MOVS     R0,#+100
        BL       delay
??xtjianmian_0:
??xtjianmian_3:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.W    ??xtjianmian_4
        LDR.N    R0,??DataTable1_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xtjianmian_5
        POP      {R4-R6,PC}       ;; return
??xtjianmian_5:
        BL       key
        MOVS     R6,#+0
        B.N      ??xtjianmian_6
??xtjianmian_7:
        ADDS     R2,R6,#+64
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        MOVS     R0,#+30
        MUL      R0,R0,R6
        ADDS     R0,R0,#+40
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R6,R6,#+1
??xtjianmian_6:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BLT.N    ??xtjianmian_7
        MOVS     R6,#+0
        B.N      ??xtjianmian_8
??xtjianmian_9:
        ADDS     R2,R6,#+59
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+3
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LSLS     R0,R6,#+4
        ADDS     R0,R0,#+25
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R6,R6,#+1
??xtjianmian_8:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+5
        BLT.N    ??xtjianmian_9
        LDR.N    R2,??DataTable1_8
        MOVS     R1,#+5
        MOVS     R0,#+25
        BL       LCD_P8x16Str
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        LDR.N    R0,??DataTable1_9
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xtjianmian_10
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable1_9
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xtjianmian_11
        SUBS     R4,R4,#+1
        MOVS     R0,#+2
        BL       playmusic
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??xtjianmian_12
        MOVS     R4,#+2
??xtjianmian_12:
        MOVS     R2,#+15
        MOVS     R1,#+3
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+15
        MOVS     R1,#+5
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        B.N      ??xtjianmian_11
??xtjianmian_13:
        BL       key
??xtjianmian_11:
        LDR.N    R0,??DataTable1_9
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xtjianmian_13
??xtjianmian_10:
        LDR.N    R0,??DataTable1_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xtjianmian_14
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable1_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xtjianmian_15
        ADDS     R4,R4,#+1
        MOVS     R0,#+2
        BL       playmusic
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+3
        BNE.N    ??xtjianmian_16
        MOVS     R4,#+1
??xtjianmian_16:
        MOVS     R2,#+15
        MOVS     R1,#+3
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+15
        MOVS     R1,#+5
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        B.N      ??xtjianmian_15
??xtjianmian_17:
        BL       key
??xtjianmian_15:
        LDR.N    R0,??DataTable1_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xtjianmian_17
??xtjianmian_14:
        LDR.N    R0,??DataTable1_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xtjianmian_18
        LDR.N    R0,??DataTable1_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??xtjianmian_3
??xtjianmian_18:
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable1_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xtjianmian_19
        LDR.N    R0,??DataTable1_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xtjianmian_20
??xtjianmian_19:
        MOVS     R5,#+0
??xtjianmian_20:
        LDR.N    R0,??DataTable1_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xtjianmian_21
        LDR.N    R0,??DataTable1_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??xtjianmian_3
??xtjianmian_21:
        BL       key
        B.N      ??xtjianmian_20
??xtjianmian_4:
        BL       LCD_CLS
        MOVS     R0,#+1
        LDR.N    R1,??DataTable1_11
        STRH     R0,[R1, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.W    ??xtjianmian_1
        MOVS     R0,#+6
        LDR.N    R1,??DataTable1_2
        STRH     R0,[R1, #+0]
        BL       huatu
        MOVS     R0,#+5
        LDR.N    R1,??DataTable1_2
        STRH     R0,[R1, #+0]
        B.N      ??xtjianmian_2
//  132   }
//  133 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     jmms

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     mosixuanzi

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     djm

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_5:
        DC32     key_left

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_6:
        DC32     key_right

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_7:
        DC32     gamestart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_8:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_9:
        DC32     key_up

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_10:
        DC32     key_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_11:
        DC32     gameing

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
        DC8 1, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "Flash "
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "  SD Card"
        DC8 0, 0

        END
// 
//     1 byte  in section .bss
//     1 byte  in section .data
//    28 bytes in section .rodata
// 1 078 bytes in section .text
// 
// 1 078 bytes of CODE  memory
//    28 bytes of CONST memory
//     2 bytes of DATA  memory
//
//Errors: none
//Warnings: 3
