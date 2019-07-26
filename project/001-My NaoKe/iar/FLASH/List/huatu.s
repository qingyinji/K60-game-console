///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       14/May/2019  18:35:26
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\huatu.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\huatu.c" -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\huatu.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_CLS
        EXTERN LCD_P14x16Ch
        EXTERN LCD_P14x16Ch1
        EXTERN LCD_P16x8Ch
        EXTERN delay
        EXTERN gamestart
        EXTERN key
        EXTERN key_down
        EXTERN key_left
        EXTERN key_right
        EXTERN key_up
        EXTERN playmusic

        PUBLIC cu_x
        PUBLIC cu_y
        PUBLIC dir1
        PUBLIC huatu
        PUBLIC huatu1
        PUBLIC move
        PUBLIC showtx
        PUBLIC txshu
        PUBLIC xuanzhetx
        PUBLIC xuanzhetxjm

// D:\2019.IAR\project\001-My NaoKe\app\huatu.c
//    1 #include "common.h"
//    2 #include "LQ12864.h"
//    3 #include "yingjian.h"
//    4 #include "huatu.h"

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    5 uint16 huatu1[8][8]={0};
huatu1:
        DS8 128

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//    6 uint16 dir1[4][2]={-1,0,1,0,0,-1,0,1};
dir1:
        DATA
        DC16 65535, 0, 1, 0, 0, 65535, 0, 1

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//    7 uint16 cu_x=4;
cu_x:
        DATA
        DC16 4

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//    8 uint16 cu_y=4;
cu_y:
        DATA
        DC16 4

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//    9 uint16 xuanzhetx,txshu=1;
xuanzhetx:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
txshu:
        DATA
        DC16 1
//   10 extern uint16 key_up,key_down,key_left,key_right;
//   11 extern uint16 gameing,xuanzhetx,mosixuanzi,gamestart;

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   12 void huatu(void){
huatu:
        PUSH     {R3-R5,LR}
//   13 LCD_CLS();
        BL       LCD_CLS
//   14 huatu1[2][2]=2;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable3
        STRH     R0,[R1, #+36]
//   15 for (uint16 i=0;i<2;++i){    //右面板
        MOVS     R4,#+0
        B.N      ??huatu_0
//   16       LCD_P14x16Ch1(72+i*14,0,i+46+1);
??huatu_1:
        ADDS     R2,R4,#+47
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch1
//   17     }
        ADDS     R4,R4,#+1
??huatu_0:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??huatu_1
//   18 for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??huatu_2
//   19       LCD_P14x16Ch(77+i*14,2,i+48+1);
??huatu_3:
        ADDS     R2,R4,#+49
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+77
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//   20     }
        ADDS     R4,R4,#+1
??huatu_2:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??huatu_3
//   21 for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??huatu_4
//   22       LCD_P14x16Ch(82+i*14,4,i+50+1);
??huatu_5:
        ADDS     R2,R4,#+51
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+82
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//   23     }
        ADDS     R4,R4,#+1
??huatu_4:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??huatu_5
//   24 for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??huatu_6
//   25       LCD_P14x16Ch(87+i*14,6,i+52+1);
??huatu_7:
        ADDS     R2,R4,#+53
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+87
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//   26     }
        ADDS     R4,R4,#+1
??huatu_6:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??huatu_7
//   27 for(uint16 i=0;i<8;i++){
        MOVS     R4,#+0
        B.N      ??huatu_8
//   28         for(uint16 j=0;j<8;j++){
//   29         LCD_P16x8Ch(i*8,j,huatu1[i][j]);
??huatu_9:
        LDR.W    R0,??DataTable3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+4
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LDRH     R2,[R0, R5, LSL #+1]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P16x8Ch
//   30         }
        ADDS     R5,R5,#+1
??huatu_10:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+8
        BLT.N    ??huatu_9
        ADDS     R4,R4,#+1
??huatu_8:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+8
        BGE.W    ??huatu_11
        MOVS     R5,#+0
        B.N      ??huatu_10
//   31     }
//   32 
//   33   while(1){
//   34       if(gamestart==0){
//   35           LCD_CLS();
//   36           return;
//   37       }
//   38     huatu1[2][2]=2;
??huatu_12:
        MOVS     R0,#+2
        LDR.W    R1,??DataTable3
        STRH     R0,[R1, #+36]
//   39     key();
        BL       key
//   40     if(xuanzhetx)
        LDR.W    R0,??DataTable3_1
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??huatu_13
//   41         xuanzhetxjm();
        BL       xuanzhetxjm
//   42 
//   43     LCD_P16x8Ch(cu_x*8,cu_y,5);
??huatu_13:
        MOVS     R2,#+5
        LDR.W    R0,??DataTable3_2
        LDRH     R1,[R0, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.W    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P16x8Ch
//   44     delay(1000);
        MOV      R0,#+1000
        BL       delay
//   45     if(key_up==0){
        LDR.W    R0,??DataTable3_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_14
//   46       delay(500);
        MOV      R0,#+500
        BL       delay
//   47       if(key_up==0){
        LDR.W    R0,??DataTable3_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_15
//   48         move(cu_x,cu_y,2);
        MOVS     R2,#+2
        LDR.W    R0,??DataTable3_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        BL       move
//   49       }while(!key_up){key();}
??huatu_15:
        LDR.W    R0,??DataTable3_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_11
        BL       key
        B.N      ??huatu_15
//   50     }
//   51     else if(key_down==0){
??huatu_14:
        LDR.W    R0,??DataTable3_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_16
//   52       delay(500);
        MOV      R0,#+500
        BL       delay
//   53       if(key_down==0){
        LDR.W    R0,??DataTable3_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_17
//   54         move(cu_x,cu_y,3);
        MOVS     R2,#+3
        LDR.W    R0,??DataTable3_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        BL       move
//   55       }while(!key_down){key();}
??huatu_17:
        LDR.W    R0,??DataTable3_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_11
        BL       key
        B.N      ??huatu_17
//   56     }
//   57     else if(key_left==0){
??huatu_16:
        LDR.W    R0,??DataTable3_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_18
//   58       delay(500);
        MOV      R0,#+500
        BL       delay
//   59       if(key_left==0){
        LDR.W    R0,??DataTable3_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_19
//   60         move(cu_x,cu_y,0);
        MOVS     R2,#+0
        LDR.W    R0,??DataTable3_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        BL       move
//   61       }while(!key_left){key();}
??huatu_19:
        LDR.W    R0,??DataTable3_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_11
        BL       key
        B.N      ??huatu_19
//   62     }
//   63     else if(key_right==0){
??huatu_18:
        LDR.W    R0,??DataTable3_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_11
//   64       delay(500);
        MOV      R0,#+500
        BL       delay
//   65       if(key_right==0){
        LDR.W    R0,??DataTable3_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??huatu_20
//   66         move(cu_x,cu_y,1);
        MOVS     R2,#+1
        LDR.W    R0,??DataTable3_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        BL       move
        B.N      ??huatu_20
//   67       }while(!key_right){key();}
??huatu_21:
        BL       key
??huatu_20:
        LDR.W    R0,??DataTable3_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??huatu_21
//   68     }
??huatu_11:
        LDR.W    R0,??DataTable3_8
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??huatu_12
        BL       LCD_CLS
        POP      {R0,R4,R5,PC}    ;; return
//   69   }
//   70 }
//   71 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   72 void move(uint16 x,uint16 y,uint16 id){
move:
        PUSH     {R3-R5,LR}
//   73     uint16 xx1,yy1,key1;
//   74     xx1=x+dir1[id][0]; yy1=y+dir1[id][1];
        LDR.W    R3,??DataTable3_9
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRH     R3,[R3, R2, LSL #+2]
        ADDS     R0,R3,R0
        LDR.W    R3,??DataTable3_9
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R3,R3,R2, LSL #+2
        LDRH     R3,[R3, #+2]
        ADDS     R1,R3,R1
//   75     if(xx1<0||xx1>=8||yy1<0||yy1>=8)
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??move_0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??move_1
//   76         key1=0;
??move_0:
        MOVS     R0,#+0
        B.N      ??move_2
//   77     else
//   78         key1=1;
??move_1:
        MOVS     R0,#+1
//   79 
//   80     if(key1==1){//直接移动
??move_2:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+1
        BNE.N    ??move_3
//   81     cu_x+=dir1[id][0]; cu_y+=dir1[id][1];
        LDR.W    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_9
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRH     R1,[R1, R2, LSL #+2]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable3_3
        STRH     R0,[R1, #+0]
        LDR.W    R0,??DataTable3_2
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_9
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R1,R1,R2, LSL #+2
        LDRH     R1,[R1, #+2]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable3_2
        STRH     R0,[R1, #+0]
//   82     //huatu1[cu_x][cu_y]=2;
//   83 
//   84     for(uint16 i=0;i<8;i++){
        MOVS     R4,#+0
        B.N      ??move_4
//   85         for(uint16 j=0;j<8;j++){
//   86         LCD_P16x8Ch(i*8,j,huatu1[i][j]);
??move_5:
        LDR.W    R0,??DataTable3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+4
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LDRH     R2,[R0, R5, LSL #+1]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P16x8Ch
//   87         }
        ADDS     R5,R5,#+1
??move_6:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+8
        BLT.N    ??move_5
        ADDS     R4,R4,#+1
??move_4:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+8
        BGE.N    ??move_3
        MOVS     R5,#+0
        B.N      ??move_6
//   88     }
//   89   }
//   90 }
??move_3:
        POP      {R0,R4,R5,PC}    ;; return
//   91 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 void xuanzhetxjm(void){
xuanzhetxjm:
        PUSH     {R4,LR}
//   93 uint16 d=1;
        MOVS     R4,#+1
//   94 while(d){
??xuanzhetxjm_0:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+0
        BEQ.W    ??xuanzhetxjm_1
//   95   /* if(gamestart==0)
//   96     return; */
//   97   key();
        BL       key
//   98     if(key_up==0){
        LDR.W    R0,??DataTable3_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xuanzhetxjm_2
//   99       delay(500);
        MOV      R0,#+500
        BL       delay
//  100       if(key_up==0){
        LDR.W    R0,??DataTable3_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xuanzhetxjm_3
//  101         txshu--;
        LDR.W    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable3_10
        STRH     R0,[R1, #+0]
//  102         playmusic(2);
        MOVS     R0,#+2
        BL       playmusic
//  103         showtx();
        BL       showtx
        B.N      ??xuanzhetxjm_3
//  104       }while(!key_up){key();}
??xuanzhetxjm_4:
        BL       key
??xuanzhetxjm_3:
        LDR.W    R0,??DataTable3_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xuanzhetxjm_4
//  105     }
//  106     if(key_down==0){
??xuanzhetxjm_2:
        LDR.W    R0,??DataTable3_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xuanzhetxjm_5
//  107       delay(500);
        MOV      R0,#+500
        BL       delay
//  108       if(key_down==0){
        LDR.W    R0,??DataTable3_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xuanzhetxjm_6
//  109         txshu++;
        LDR.W    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable3_10
        STRH     R0,[R1, #+0]
//  110         playmusic(2);
        MOVS     R0,#+2
        BL       playmusic
//  111         if(txshu==5)
        LDR.W    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??xuanzhetxjm_7
//  112           txshu=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_10
        STRH     R0,[R1, #+0]
//  113         showtx();
??xuanzhetxjm_7:
        BL       showtx
        B.N      ??xuanzhetxjm_6
//  114       }while(!key_down){key();}
??xuanzhetxjm_8:
        BL       key
??xuanzhetxjm_6:
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xuanzhetxjm_8
//  115     }
//  116     if(key_left==0||key_right==0){
??xuanzhetxjm_5:
        LDR.N    R0,??DataTable3_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xuanzhetxjm_9
        LDR.N    R0,??DataTable3_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xuanzhetxjm_0
//  117       delay(500);
??xuanzhetxjm_9:
        MOV      R0,#+500
        BL       delay
//  118       if(key_left==0||key_right==0){
        LDR.N    R0,??DataTable3_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xuanzhetxjm_10
        LDR.N    R0,??DataTable3_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??xuanzhetxjm_11
//  119         d=0;xuanzhetx=0;
??xuanzhetxjm_10:
        MOVS     R4,#+0
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_1
        STRH     R0,[R1, #+0]
//  120         if(txshu==1)
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??xuanzhetxjm_12
//  121         huatu1[cu_x][cu_y]=0;
        LDR.N    R0,??DataTable3
        LDR.N    R1,??DataTable3_3
        LDRH     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+4
        LDR.N    R1,??DataTable3_2
        LDRH     R1,[R1, #+0]
        MOVS     R2,#+0
        STRH     R2,[R0, R1, LSL #+1]
//  122         if(txshu==2)
??xuanzhetxjm_12:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??xuanzhetxjm_13
//  123         huatu1[cu_x][cu_y]=1;
        LDR.N    R0,??DataTable3
        LDR.N    R1,??DataTable3_3
        LDRH     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+4
        LDR.N    R1,??DataTable3_2
        LDRH     R1,[R1, #+0]
        MOVS     R2,#+1
        STRH     R2,[R0, R1, LSL #+1]
//  124         if(txshu==3)
??xuanzhetxjm_13:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??xuanzhetxjm_14
//  125         huatu1[cu_x][cu_y]=3;
        LDR.N    R0,??DataTable3
        LDR.N    R1,??DataTable3_3
        LDRH     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+4
        LDR.N    R1,??DataTable3_2
        LDRH     R1,[R1, #+0]
        MOVS     R2,#+3
        STRH     R2,[R0, R1, LSL #+1]
//  126         if(txshu==4)
??xuanzhetxjm_14:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??xuanzhetxjm_15
//  127         huatu1[cu_x][cu_y]=4;
        LDR.N    R0,??DataTable3
        LDR.N    R1,??DataTable3_3
        LDRH     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+4
        LDR.N    R1,??DataTable3_2
        LDRH     R1,[R1, #+0]
        MOVS     R2,#+4
        STRH     R2,[R0, R1, LSL #+1]
//  128         huatu1[2][2]=2;
??xuanzhetxjm_15:
        MOVS     R0,#+2
        LDR.N    R1,??DataTable3
        STRH     R0,[R1, #+36]
//  129       }while(!key_left||!key_right){key();}
??xuanzhetxjm_11:
        LDR.N    R0,??DataTable3_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??xuanzhetxjm_16
        LDR.N    R0,??DataTable3_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??xuanzhetxjm_0
??xuanzhetxjm_16:
        BL       key
        B.N      ??xuanzhetxjm_11
//  130     }
//  131   }
//  132 }
??xuanzhetxjm_1:
        POP      {R4,PC}          ;; return
//  133 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 void showtx(void){
showtx:
        PUSH     {R4,LR}
//  135     if(txshu==0)
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??showtx_0
//  136           txshu=4;
        MOVS     R0,#+4
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+0]
//  137         if(txshu==1){
??showtx_0:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??showtx_1
//  138             for (uint16 i=0;i<2;++i){    //右面板
        MOVS     R4,#+0
        B.N      ??showtx_2
//  139                 LCD_P14x16Ch1(72+i*14,0,i+46+1);
??showtx_3:
        ADDS     R2,R4,#+47
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch1
//  140                 }
        ADDS     R4,R4,#+1
??showtx_2:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_3
//  141             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_4
//  142                 LCD_P14x16Ch(77+i*14,2,i+48+1);
??showtx_5:
        ADDS     R2,R4,#+49
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+77
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  143                 }
        ADDS     R4,R4,#+1
??showtx_4:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_5
//  144             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_6
//  145                 LCD_P14x16Ch(82+i*14,4,i+50+1);
??showtx_7:
        ADDS     R2,R4,#+51
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+82
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  146                 }
        ADDS     R4,R4,#+1
??showtx_6:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_7
//  147             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_8
//  148                 LCD_P14x16Ch(87+i*14,6,i+52+1);
??showtx_9:
        ADDS     R2,R4,#+53
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+87
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  149                 }
        ADDS     R4,R4,#+1
??showtx_8:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_9
//  150         }
//  151         if(txshu==2){
??showtx_1:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??showtx_10
//  152             for (uint16 i=0;i<2;++i){    //右面板
        MOVS     R4,#+0
        B.N      ??showtx_11
//  153                 LCD_P14x16Ch(72+i*14,0,i+46+1);
??showtx_12:
        ADDS     R2,R4,#+47
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  154                 }
        ADDS     R4,R4,#+1
??showtx_11:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_12
//  155             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_13
//  156                 LCD_P14x16Ch1(77+i*14,2,i+48+1);
??showtx_14:
        ADDS     R2,R4,#+49
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+77
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch1
//  157                 }
        ADDS     R4,R4,#+1
??showtx_13:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_14
//  158             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_15
//  159                 LCD_P14x16Ch(82+i*14,4,i+50+1);
??showtx_16:
        ADDS     R2,R4,#+51
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+82
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  160                 }
        ADDS     R4,R4,#+1
??showtx_15:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_16
//  161             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_17
//  162                 LCD_P14x16Ch(87+i*14,6,i+52+1);
??showtx_18:
        ADDS     R2,R4,#+53
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+87
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  163                 }
        ADDS     R4,R4,#+1
??showtx_17:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_18
//  164         }
//  165         if(txshu==3){
??showtx_10:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??showtx_19
//  166             for (uint16 i=0;i<2;++i){    //右面板
        MOVS     R4,#+0
        B.N      ??showtx_20
//  167                 LCD_P14x16Ch(72+i*14,0,i+46+1);
??showtx_21:
        ADDS     R2,R4,#+47
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  168                 }
        ADDS     R4,R4,#+1
??showtx_20:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_21
//  169             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_22
//  170                 LCD_P14x16Ch(77+i*14,2,i+48+1);
??showtx_23:
        ADDS     R2,R4,#+49
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+77
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  171                 }
        ADDS     R4,R4,#+1
??showtx_22:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_23
//  172             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_24
//  173                 LCD_P14x16Ch1(82+i*14,4,i+50+1);
??showtx_25:
        ADDS     R2,R4,#+51
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+82
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch1
//  174                 }
        ADDS     R4,R4,#+1
??showtx_24:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_25
//  175             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_26
//  176                 LCD_P14x16Ch(87+i*14,6,i+52+1);
??showtx_27:
        ADDS     R2,R4,#+53
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+87
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  177                 }
        ADDS     R4,R4,#+1
??showtx_26:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_27
//  178         }
//  179         if(txshu==4){
??showtx_19:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??showtx_28
//  180             for (uint16 i=0;i<2;++i){    //右面板
        MOVS     R4,#+0
        B.N      ??showtx_29
//  181                 LCD_P14x16Ch(72+i*14,0,i+46+1);
??showtx_30:
        ADDS     R2,R4,#+47
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+72
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  182                 }
        ADDS     R4,R4,#+1
??showtx_29:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_30
//  183             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_31
//  184                 LCD_P14x16Ch(77+i*14,2,i+48+1);
??showtx_32:
        ADDS     R2,R4,#+49
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+77
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  185                 }
        ADDS     R4,R4,#+1
??showtx_31:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_32
//  186             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_33
//  187                 LCD_P14x16Ch(82+i*14,4,i+50+1);
??showtx_34:
        ADDS     R2,R4,#+51
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+82
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//  188                 }
        ADDS     R4,R4,#+1
??showtx_33:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_34
//  189             for (uint16 i=0;i<2;++i){
        MOVS     R4,#+0
        B.N      ??showtx_35
//  190                 LCD_P14x16Ch1(87+i*14,6,i+52+1);
??showtx_36:
        ADDS     R2,R4,#+53
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R4
        ADDS     R0,R0,#+87
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch1
//  191                 }
        ADDS     R4,R4,#+1
??showtx_35:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+2
        BLT.N    ??showtx_36
//  192         }
//  193 }
??showtx_28:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     huatu1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     xuanzhetx

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     cu_y

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     cu_x

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     key_up

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     key_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     key_left

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     key_right

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     gamestart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     dir1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     txshu

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
//   130 bytes in section .bss
//    22 bytes in section .data
// 1 736 bytes in section .text
// 
// 1 736 bytes of CODE memory
//   152 bytes of DATA memory
//
//Errors: none
//Warnings: 2
