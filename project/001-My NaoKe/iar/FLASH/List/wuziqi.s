///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       14/May/2019  18:35:39
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\wuziqi.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\wuziqi.c" -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\wuziqi.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_CLS
        EXTERN LCD_Fill
        EXTERN LCD_P14x16Ch
        EXTERN LCD_P6x8Str
        EXTERN LCD_P8x16Str
        EXTERN LPLD_ADC_Get
        EXTERN board
        EXTERN chess_board
        EXTERN codn_x
        EXTERN codn_y
        EXTERN delay
        EXTERN gameing
        EXTERN gamestart
        EXTERN memset

        PUBLIC board_scan
        PUBLIC key_scan
        PUBLIC player
        PUBLIC rou
        PUBLIC show_win
        PUBLIC wuziqi

// D:\2019.IAR\project\001-My NaoKe\app\wuziqi.c
//    1 #include "common.h"
//    2 #include "LQ12864.h"
//    3 #include "wuziqi.h"
//    4 #include "yingjian.h"
//    5 
//    6 extern uint16 gameing,gamestart;
//    7 extern uint8 board[8][8];
//    8 extern int8 codn_x,codn_y;

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//    9 uint8 player = 1;
player:
        DATA
        DC8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   10 uint8 rou = 0;
rou:
        DS8 1
//   11 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   12 void wuziqi(void){
wuziqi:
        PUSH     {R3-R5,LR}
//   13   for(int n=0;n<8;n++)
        MOVS     R4,#+0
        B.N      ??wuziqi_0
//   14   {
//   15     for(int m=0;m<5;m++){
//   16       LCD_P14x16Ch(30+m*14,n,m+33);
??wuziqi_1:
        ADDS     R2,R5,#+33
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+14
        MUL      R0,R0,R5
        ADDS     R0,R0,#+30
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
//   17     }
        ADDS     R5,R5,#+1
??wuziqi_2:
        CMP      R5,#+5
        BLT.N    ??wuziqi_1
//   18     delay(7000);
        MOVW     R0,#+7000
        BL       delay
//   19     LCD_Fill(0);
        MOVS     R0,#+0
        BL       LCD_Fill
        ADDS     R4,R4,#+1
??wuziqi_0:
        CMP      R4,#+8
        BGE.N    ??wuziqi_3
        MOVS     R5,#+0
        B.N      ??wuziqi_2
//   20   }  
//   21   gameing=1;
??wuziqi_3:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3
        STRH     R0,[R1, #+0]
//   22   /*pwm_init(50);                            背景音乐
//   23   LPLD_FTM_PWM_ChangeDuty(FTM0,FTM_Ch0, 0);*/
//   24   LCD_P8x16Str(70,3,"PLAYER1");
        LDR.W    R2,??DataTable3_1
        MOVS     R1,#+3
        MOVS     R0,#+70
        BL       LCD_P8x16Str
//   25   LCD_P8x16Str(74,1,"GoBang");
        LDR.W    R2,??DataTable3_2
        MOVS     R1,#+1
        MOVS     R0,#+74
        BL       LCD_P8x16Str
        B.N      ??wuziqi_4
//   26   while(gamestart){
//   27   	key_scan();}
??wuziqi_5:
        BL       key_scan
??wuziqi_4:
        LDR.W    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??wuziqi_5
//   28   	player=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+0]
//   29   	rou=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_5
        STRB     R0,[R1, #+0]
//   30   	codn_x=codn_y=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_6
        STRB     R0,[R1, #+0]
        LDR.W    R0,??DataTable3_6
        LDRB     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_7
        STRB     R0,[R1, #+0]
//   31     memset(board,0,sizeof(board));
        MOVS     R2,#+64
        MOVS     R1,#+0
        LDR.W    R0,??DataTable3_8
        BL       memset
//   32   	gameing=gamestart=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable3_3
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable3
        STRH     R0,[R1, #+0]
//   33 }
        POP      {R0,R4,R5,PC}    ;; return
//   34 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   35 void show_win(void)
//   36 {
show_win:
        PUSH     {R7,LR}
//   37   gameing=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3
        STRH     R0,[R1, #+0]
//   38   LCD_CLS();
        BL       LCD_CLS
//   39   chess_board();
        BL       chess_board
//   40   if(player == 2)
        LDR.N    R0,??DataTable3_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??show_win_0
//   41     LCD_P6x8Str(84,7,"PLAYER1");
        LDR.N    R2,??DataTable3_1
        MOVS     R1,#+7
        MOVS     R0,#+84
        BL       LCD_P6x8Str
        B.N      ??show_win_1
//   42   else if(player == 1)
??show_win_0:
        LDR.N    R0,??DataTable3_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??show_win_1
//   43     LCD_P6x8Str(84,7,"PLAYER2");
        LDR.N    R2,??DataTable3_9
        MOVS     R1,#+7
        MOVS     R0,#+84
        BL       LCD_P6x8Str
//   44 }
??show_win_1:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   45 void key_scan(void)
//   46 {
key_scan:
        PUSH     {R7,LR}
//   47 
//   48     if(LPLD_ADC_Get(ADC0, DAD1)>3000)
        MOVS     R1,#+1
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        MOVW     R1,#+3001
        CMP      R0,R1
        BLT.N    ??key_scan_0
//   49     {
//   50       delay(8000);
        MOV      R0,#+8000
        BL       delay
//   51       if(LPLD_ADC_Get(ADC0, DAD1)>3000)codn_x+=8;
        MOVS     R1,#+1
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        MOVW     R1,#+3001
        CMP      R0,R1
        BLT.N    ??key_scan_1
        LDR.N    R0,??DataTable3_7
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+8
        LDR.N    R1,??DataTable3_7
        STRB     R0,[R1, #+0]
//   52       if(codn_x > 56) codn_x = 0;
??key_scan_1:
        LDR.N    R0,??DataTable3_7
        LDRSB    R0,[R0, #+0]
        CMP      R0,#+57
        BLT.N    ??key_scan_2
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_7
        STRB     R0,[R1, #+0]
        B.N      ??key_scan_2
//   53     }
//   54     else if(LPLD_ADC_Get(ADC0, DAD1) < 1000)
??key_scan_0:
        MOVS     R1,#+1
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        CMP      R0,#+1000
        BGE.N    ??key_scan_2
//   55     {
//   56       delay(8000);
        MOV      R0,#+8000
        BL       delay
//   57       if(LPLD_ADC_Get(ADC0, DAD1)< 1000)codn_x-=8;
        MOVS     R1,#+1
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        CMP      R0,#+1000
        BGE.N    ??key_scan_3
        LDR.N    R0,??DataTable3_7
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+8
        LDR.N    R1,??DataTable3_7
        STRB     R0,[R1, #+0]
//   58       if(codn_x < 0) codn_x = 56;
??key_scan_3:
        LDR.N    R0,??DataTable3_7
        LDRSB    R0,[R0, #+0]
        CMP      R0,#+0
        BPL.N    ??key_scan_2
        MOVS     R0,#+56
        LDR.N    R1,??DataTable3_7
        STRB     R0,[R1, #+0]
//   59     }
//   60     if(LPLD_ADC_Get(ADC0, DAD3)>3000)
??key_scan_2:
        MOVS     R1,#+3
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        MOVW     R1,#+3001
        CMP      R0,R1
        BLT.N    ??key_scan_4
//   61     {
//   62       delay(8000);
        MOV      R0,#+8000
        BL       delay
//   63       if(LPLD_ADC_Get(ADC0, DAD3)>3000)codn_y++;
        MOVS     R1,#+3
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        MOVW     R1,#+3001
        CMP      R0,R1
        BLT.N    ??key_scan_5
        LDR.N    R0,??DataTable3_6
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable3_6
        STRB     R0,[R1, #+0]
//   64       if(codn_y > 7) codn_y = 0;
??key_scan_5:
        LDR.N    R0,??DataTable3_6
        LDRSB    R0,[R0, #+0]
        CMP      R0,#+8
        BLT.N    ??key_scan_6
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_6
        STRB     R0,[R1, #+0]
        B.N      ??key_scan_6
//   65     }
//   66     else if(LPLD_ADC_Get(ADC0, DAD3) < 1000)
??key_scan_4:
        MOVS     R1,#+3
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        CMP      R0,#+1000
        BGE.N    ??key_scan_6
//   67     {
//   68       delay(8000);
        MOV      R0,#+8000
        BL       delay
//   69       if(LPLD_ADC_Get(ADC0, DAD3)< 1000)codn_y--;
        MOVS     R1,#+3
        LDR.N    R0,??DataTable3_10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        CMP      R0,#+1000
        BGE.N    ??key_scan_7
        LDR.N    R0,??DataTable3_6
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable3_6
        STRB     R0,[R1, #+0]
//   70       if(codn_y < 0) codn_y = 7;
??key_scan_7:
        LDR.N    R0,??DataTable3_6
        LDRSB    R0,[R0, #+0]
        CMP      R0,#+0
        BPL.N    ??key_scan_6
        MOVS     R0,#+7
        LDR.N    R1,??DataTable3_6
        STRB     R0,[R1, #+0]
//   71     }
//   72 }
??key_scan_6:
        POP      {R0,PC}          ;; return
//   73 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   74 uint8 board_scan(int num)
//   75 {
board_scan:
        PUSH     {R4,R5}
//   76   uint8 count = 0;
        MOVS     R1,#+0
//   77   
//   78   for(int i = 0; i < 8;i++)   //行扫描
        MOVS     R2,#+0
        B.N      ??board_scan_0
??board_scan_1:
        ADDS     R2,R2,#+1
??board_scan_0:
        CMP      R2,#+8
        BGE.N    ??board_scan_2
//   79   { 
//   80     for(int j = 0; j < 7;j++)
        MOVS     R3,#+0
        B.N      ??board_scan_3
??board_scan_4:
        ADDS     R3,R3,#+1
??board_scan_3:
        CMP      R3,#+7
        BGE.N    ??board_scan_1
//   81     { 
//   82       uint8 tmp = board[i][j];
        LDR.N    R4,??DataTable3_8
        ADDS     R4,R4,R2, LSL #+3
        LDRB     R4,[R3, R4]
//   83       if(tmp != board[i][j+1] || tmp ==0){count = 0;}
        LDR.N    R5,??DataTable3_8
        ADDS     R5,R5,R2, LSL #+3
        ADDS     R5,R3,R5
        LDRB     R5,[R5, #+1]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R5
        BNE.N    ??board_scan_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??board_scan_6
??board_scan_5:
        MOVS     R1,#+0
        B.N      ??board_scan_7
//   84       else count++;
??board_scan_6:
        ADDS     R1,R1,#+1
//   85       if(count > num)return 1;
??board_scan_7:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R0,R1
        BGE.N    ??board_scan_4
        MOVS     R0,#+1
        B.N      ??board_scan_8
//   86     }
//   87   }
//   88   for(int i = 0; i < 8;i++)  //列扫描
??board_scan_2:
        MOVS     R2,#+0
        B.N      ??board_scan_9
??board_scan_10:
        ADDS     R2,R2,#+1
??board_scan_9:
        CMP      R2,#+8
        BGE.N    ??board_scan_11
//   89   { 
//   90     for(int j = 0; j < 7;j++)
        MOVS     R3,#+0
        B.N      ??board_scan_12
??board_scan_13:
        ADDS     R3,R3,#+1
??board_scan_12:
        CMP      R3,#+7
        BGE.N    ??board_scan_10
//   91     { 
//   92       uint8 tmp = board[j][i];
        LDR.N    R4,??DataTable3_8
        ADDS     R4,R4,R3, LSL #+3
        LDRB     R4,[R2, R4]
//   93       if(tmp != board[j+1][i] || tmp ==0)count = 0;
        LDR.N    R5,??DataTable3_8
        ADDS     R5,R5,R3, LSL #+3
        ADDS     R5,R2,R5
        LDRB     R5,[R5, #+8]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R5
        BNE.N    ??board_scan_14
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??board_scan_15
??board_scan_14:
        MOVS     R1,#+0
        B.N      ??board_scan_16
//   94       else count++;
??board_scan_15:
        ADDS     R1,R1,#+1
//   95       if(count > num)return 1;
??board_scan_16:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R0,R1
        BGE.N    ??board_scan_13
        MOVS     R0,#+1
        B.N      ??board_scan_8
//   96     }
//   97   }
//   98   
//   99   for(int i = 0; i < 4;i++)
??board_scan_11:
        MOVS     R0,#+0
        B.N      ??board_scan_17
??board_scan_18:
        ADDS     R0,R0,#+1
??board_scan_17:
        CMP      R0,#+4
        BGE.N    ??board_scan_19
//  100   { 
//  101     int a = i;
        MOVS     R2,R0
//  102     for(int j = 0; j < 8 - i;j++)
        MOVS     R3,#+0
        B.N      ??board_scan_20
//  103     { 
//  104       uint8 tmp = board[a][j];
//  105       if(tmp != board[a+1][j+1] || tmp ==0)count = 0;
//  106       else {count++;}
//  107       if(count > 3)return 1;
//  108       a++;
??board_scan_21:
        ADDS     R2,R2,#+1
        ADDS     R3,R3,#+1
??board_scan_20:
        RSBS     R4,R0,#+8
        CMP      R3,R4
        BGE.N    ??board_scan_18
        LDR.N    R4,??DataTable3_8
        ADDS     R4,R4,R2, LSL #+3
        LDRB     R4,[R3, R4]
        LDR.N    R5,??DataTable3_8
        ADDS     R5,R5,R2, LSL #+3
        ADDS     R5,R3,R5
        LDRB     R5,[R5, #+9]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R5
        BNE.N    ??board_scan_22
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??board_scan_23
??board_scan_22:
        MOVS     R1,#+0
        B.N      ??board_scan_24
??board_scan_23:
        ADDS     R1,R1,#+1
??board_scan_24:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+4
        BLT.N    ??board_scan_21
        MOVS     R0,#+1
        B.N      ??board_scan_8
//  109     }
//  110   }
//  111   
//  112   for(int i = 0; i<4;i++)//斜方向下遍历次数3
??board_scan_19:
        MOVS     R0,#+0
        B.N      ??board_scan_25
??board_scan_26:
        ADDS     R0,R0,#+1
??board_scan_25:
        CMP      R0,#+4
        BGE.N    ??board_scan_27
//  113   {
//  114     int a = 0;
        MOVS     R2,#+0
//  115     for(int j = 4-i;j < 8;j++)//斜线中遍历次数与i有关 j4i0 5 j3i1 6
        RSBS     R3,R0,#+4
        B.N      ??board_scan_28
//  116     {
//  117       uint8 tmp = board[a][j];
//  118       if(tmp != board[a+1][j+1] || tmp ==0)count = 0;
//  119       else {count++;}
//  120       if(count > 3)return 1;
//  121       a++;
??board_scan_29:
        ADDS     R2,R2,#+1
        ADDS     R3,R3,#+1
??board_scan_28:
        CMP      R3,#+8
        BGE.N    ??board_scan_26
        LDR.N    R4,??DataTable3_8
        ADDS     R4,R4,R2, LSL #+3
        LDRB     R4,[R3, R4]
        LDR.N    R5,??DataTable3_8
        ADDS     R5,R5,R2, LSL #+3
        ADDS     R5,R3,R5
        LDRB     R5,[R5, #+9]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R5
        BNE.N    ??board_scan_30
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??board_scan_31
??board_scan_30:
        MOVS     R1,#+0
        B.N      ??board_scan_32
??board_scan_31:
        ADDS     R1,R1,#+1
??board_scan_32:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+4
        BLT.N    ??board_scan_29
        MOVS     R0,#+1
        B.N      ??board_scan_8
//  122     }
//  123   }
//  124    
//  125   for(int i = 0; i<4;i++)//斜方向下遍历次数4
??board_scan_27:
        MOVS     R0,#+0
        B.N      ??board_scan_33
??board_scan_34:
        ADDS     R0,R0,#+1
??board_scan_33:
        CMP      R0,#+4
        BGE.N    ??board_scan_35
//  126   {
//  127     int a = i;
        MOVS     R2,R0
//  128     for(int j = 7;j > i;j--)//
        MOVS     R3,#+7
        B.N      ??board_scan_36
//  129     {
//  130       uint8 tmp = board[a][j];
//  131       if(tmp != board[a+1][j-1] || tmp ==0)count = 0;
//  132       else {count++;}
//  133       if(count > 3)return 1;
//  134       a++;
??board_scan_37:
        ADDS     R2,R2,#+1
        SUBS     R3,R3,#+1
??board_scan_36:
        CMP      R0,R3
        BGE.N    ??board_scan_34
        LDR.N    R4,??DataTable3_8
        ADDS     R4,R4,R2, LSL #+3
        LDRB     R4,[R3, R4]
        LDR.N    R5,??DataTable3_8
        ADDS     R5,R5,R2, LSL #+3
        ADDS     R5,R3,R5
        LDRB     R5,[R5, #+7]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R5
        BNE.N    ??board_scan_38
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??board_scan_39
??board_scan_38:
        MOVS     R1,#+0
        B.N      ??board_scan_40
??board_scan_39:
        ADDS     R1,R1,#+1
??board_scan_40:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+4
        BLT.N    ??board_scan_37
        MOVS     R0,#+1
        B.N      ??board_scan_8
//  135     }
//  136   }
//  137   
//  138   for(int i = 0; i<3;i++)//斜方向下遍历次数4
??board_scan_35:
        MOVS     R0,#+0
        B.N      ??board_scan_41
??board_scan_42:
        ADDS     R0,R0,#+1
??board_scan_41:
        CMP      R0,#+3
        BGE.N    ??board_scan_43
//  139   {
//  140     int a = 0;
        MOVS     R2,#+0
//  141     for(int j = 4+i;j > 0;j--)//
        ADDS     R3,R0,#+4
        B.N      ??board_scan_44
//  142     {
//  143       uint8 tmp = board[a][j];
//  144       if(tmp != board[a+1][j-1] || tmp ==0)count = 0;
//  145       else {count++;}
//  146       if(count > 3)return 1;
//  147       a++;
??board_scan_45:
        ADDS     R2,R2,#+1
        SUBS     R3,R3,#+1
??board_scan_44:
        CMP      R3,#+1
        BLT.N    ??board_scan_42
        LDR.N    R4,??DataTable3_8
        ADDS     R4,R4,R2, LSL #+3
        LDRB     R4,[R3, R4]
        LDR.N    R5,??DataTable3_8
        ADDS     R5,R5,R2, LSL #+3
        ADDS     R5,R3,R5
        LDRB     R5,[R5, #+7]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R5
        BNE.N    ??board_scan_46
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??board_scan_47
??board_scan_46:
        MOVS     R1,#+0
        B.N      ??board_scan_48
??board_scan_47:
        ADDS     R1,R1,#+1
??board_scan_48:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+4
        BLT.N    ??board_scan_45
        MOVS     R0,#+1
        B.N      ??board_scan_8
//  148     }
//  149   }  
//  150   return 0;
??board_scan_43:
        MOVS     R0,#+0
??board_scan_8:
        POP      {R4,R5}
        BX       LR               ;; return
//  151 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     gameing

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     gamestart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     player

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     rou

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     codn_y

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     codn_x

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     board

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     0x4003b000

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
        DC8 "PLAYER1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "GoBang"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "PLAYER2"

        END
// 
//   1 byte  in section .bss
//   1 byte  in section .data
//  24 bytes in section .rodata
// 966 bytes in section .text
// 
// 966 bytes of CODE  memory
//  24 bytes of CONST memory
//   2 bytes of DATA  memory
//
//Errors: none
//Warnings: none
