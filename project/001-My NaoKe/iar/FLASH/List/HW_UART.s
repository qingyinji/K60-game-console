///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:36
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_UART.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_UART.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\HW_UART.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN g_bus_clock
        EXTERN g_core_clock

        PUBLIC LPLD_UART_DisableIrq
        PUBLIC LPLD_UART_EnableIrq
        PUBLIC LPLD_UART_GetChar
        PUBLIC LPLD_UART_GetChar_Present
        PUBLIC LPLD_UART_Init
        PUBLIC LPLD_UART_PutChar
        PUBLIC LPLD_UART_PutCharArr
        PUBLIC UART0_IRQHandler
        PUBLIC UART1_IRQHandler
        PUBLIC UART2_IRQHandler
        PUBLIC UART3_IRQHandler
        PUBLIC UART4_IRQHandler
        PUBLIC UART5_IRQHandler
        PUBLIC UART_R_ISR
        PUBLIC UART_T_ISR

// D:\2019.IAR\lib\LPLD\HW\HW_UART.c
//    1 /**
//    2  * @file HW_UART.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief UART底层模块相关函数
//    6  *
//    7  * 更改建议:不建议修改
//    8  *
//    9  * 版权所有:北京拉普兰德电子技术有限公司
//   10  * http://www.lpld.cn
//   11  * mail:support@lpld.cn
//   12  *
//   13  * @par
//   14  * 本代码由拉普兰德[LPLD]开发并维护，并向所有使用者开放源代码。
//   15  * 开发者可以随意修使用或改源代码。但本段及以上注释应予以保留。
//   16  * 不得更改或删除原版权所有者姓名，二次开发者可以加注二次版权所有者。
//   17  * 但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   18  * 拉普兰德不负责由于使用本代码所带来的任何事故、法律责任或相关不良影响。
//   19  * 拉普兰德无义务解释、说明本代码的具体原理、功能、实现方法。
//   20  * 除非拉普兰德[LPLD]授权，开发者不得将本代码用于商业产品。
//   21  */
//   22 #include "common.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_EnableIRQ(IRQn_Type)
NVIC_EnableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.W    R2,??DataTable10  ;; 0xe000e100
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_DisableIRQ(IRQn_Type)
NVIC_DisableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.W    R2,??DataTable10_1  ;; 0xe000e180
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return
//   23 #include "HW_UART.h"
//   24 
//   25 //用户接收中断函数入口地址数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   26 UART_ISR_CALLBACK UART_R_ISR[6];
UART_R_ISR:
        DS8 24
//   27 //用户发送中断函数入口地址数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   28 UART_ISR_CALLBACK UART_T_ISR[6];  
UART_T_ISR:
        DS8 24
//   29 
//   30 
//   31 /*
//   32  * LPLD_UART_Init
//   33  * 初始化UART通道、波特率、发送接收引脚
//   34  * 
//   35  * 参数:
//   36  *    uart_init_structure--UART初始化结构体，
//   37  *                        具体定义见UART_InitTypeDef
//   38  *
//   39  * 输出:
//   40  *    无
//   41  *
//   42  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   43 void LPLD_UART_Init(UART_InitTypeDef uart_init_structure)
//   44 {
LPLD_UART_Init:
        PUSH     {R0-R3}
        PUSH     {R4-R7,LR}
//   45   register uint16 sbr, brfa;
//   46   uint32 sysclk;
//   47   uint8 temp, x;
//   48   UART_Type *uartx = uart_init_structure.UART_Uartx;
        LDR      R0,[SP, #+20]
//   49   uint32 baud = uart_init_structure.UART_BaudRate;
        LDR      R3,[SP, #+24]
//   50   PortPinsEnum_Type tx_pin = uart_init_structure.UART_TxPin;
        LDRB     R7,[SP, #+28]
//   51   PortPinsEnum_Type rx_pin = uart_init_structure.UART_RxPin;
        LDRB     R5,[SP, #+29]
//   52   UART_ISR_CALLBACK rx_isr = uart_init_structure.UART_RxIsr;
        LDR      R1,[SP, #+32]
//   53   UART_ISR_CALLBACK tx_isr = uart_init_structure.UART_TxIsr;
        LDR      R2,[SP, #+36]
//   54   
//   55   if(baud == NULL)
        CMP      R3,#+0
        BNE.N    ??LPLD_UART_Init_0
//   56   {
//   57     baud = 9600;
        MOV      R3,#+9600
//   58   }
//   59   
//   60   //使能选中的UART串口通道时钟，相应GPIO的UART复用功能   
//   61   if(uartx == UART0)
??LPLD_UART_Init_0:
        LDR.W    R4,??DataTable10_2  ;; 0x4006a000
        CMP      R0,R4
        BNE.N    ??LPLD_UART_Init_1
//   62   {
//   63     x = 0;
        MOVS     R4,#+0
//   64     sysclk = g_core_clock;
        LDR.W    R6,??DataTable10_3
        LDR      R6,[R6, #+0]
//   65     SIM->SCGC4 |= SIM_SCGC4_UART0_MASK;
        LDR.W    R12,??DataTable10_4  ;; 0x40048034
        LDR      R12,[R12, #+0]
        ORRS     R12,R12,#0x400
        LDR.W    LR,??DataTable10_4  ;; 0x40048034
        STR      R12,[LR, #+0]
//   66     
//   67     if(tx_pin == PTA2)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+2
        BNE.N    ??LPLD_UART_Init_2
//   68       PORTA->PCR[2] = PORT_PCR_MUX(2); 
        MOV      R7,#+512
        LDR.W    R12,??DataTable10_5  ;; 0x40049008
        STR      R7,[R12, #+0]
        B.N      ??LPLD_UART_Init_3
//   69     else if(tx_pin == PTA14)
??LPLD_UART_Init_2:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+14
        BNE.N    ??LPLD_UART_Init_4
//   70       PORTA->PCR[14] = PORT_PCR_MUX(3); 
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_6  ;; 0x40049038
        STR      R7,[R12, #+0]
        B.N      ??LPLD_UART_Init_3
//   71     else
//   72       PORTB->PCR[17] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_4:
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_7  ;; 0x4004a044
        STR      R7,[R12, #+0]
//   73     
//   74     if(rx_pin == PTA1)
??LPLD_UART_Init_3:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??LPLD_UART_Init_5
//   75       PORTA->PCR[1] = PORT_PCR_MUX(2); 
        MOV      R5,#+512
        LDR.W    R7,??DataTable10_8  ;; 0x40049004
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//   76     else if(rx_pin == PTA15)
??LPLD_UART_Init_5:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+15
        BNE.N    ??LPLD_UART_Init_7
//   77       PORTA->PCR[15] = PORT_PCR_MUX(3); 
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_9  ;; 0x4004903c
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//   78     else
//   79       PORTB->PCR[16] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_7:
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_10  ;; 0x4004a040
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//   80   }
//   81   else
//   82   {
//   83     if (uartx == UART1)
??LPLD_UART_Init_1:
        LDR.W    R4,??DataTable10_11  ;; 0x4006b000
        CMP      R0,R4
        BNE.N    ??LPLD_UART_Init_8
//   84     {
//   85       x = 1;
        MOVS     R4,#+1
//   86       sysclk = g_core_clock;
        LDR.W    R6,??DataTable10_3
        LDR      R6,[R6, #+0]
//   87       SIM->SCGC4 |= SIM_SCGC4_UART1_MASK;
        LDR.W    R12,??DataTable10_4  ;; 0x40048034
        LDR      R12,[R12, #+0]
        ORRS     R12,R12,#0x800
        LDR.W    LR,??DataTable10_4  ;; 0x40048034
        STR      R12,[LR, #+0]
//   88       
//   89       if(tx_pin == PTE0)   
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+124
        BNE.N    ??LPLD_UART_Init_9
//   90         PORTE->PCR[0] = PORT_PCR_MUX(3); 
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_12  ;; 0x4004d000
        STR      R7,[R12, #+0]
        B.N      ??LPLD_UART_Init_10
//   91       else
//   92         PORTC->PCR[4] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_9:
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_13  ;; 0x4004b010
        STR      R7,[R12, #+0]
//   93       
//   94       if(rx_pin == PTE1)
??LPLD_UART_Init_10:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+125
        BNE.N    ??LPLD_UART_Init_11
//   95         PORTE->PCR[1] = PORT_PCR_MUX(3); 
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_14  ;; 0x4004d004
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//   96       else
//   97         PORTC->PCR[3] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_11:
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_15  ;; 0x4004b00c
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//   98     }
//   99     else
//  100     {
//  101       sysclk = g_bus_clock;
??LPLD_UART_Init_8:
        LDR.W    R4,??DataTable10_16
        LDR      R6,[R4, #+0]
//  102       if (uartx == UART2)
        LDR.W    R4,??DataTable10_17  ;; 0x4006c000
        CMP      R0,R4
        BNE.N    ??LPLD_UART_Init_12
//  103       {
//  104         x = 2;
        MOVS     R4,#+2
//  105         SIM->SCGC4 |= SIM_SCGC4_UART2_MASK;
        LDR.W    R5,??DataTable10_4  ;; 0x40048034
        LDR      R5,[R5, #+0]
        ORRS     R5,R5,#0x1000
        LDR.W    R7,??DataTable10_4  ;; 0x40048034
        STR      R5,[R7, #+0]
//  106         
//  107         PORTD->PCR[3] = PORT_PCR_MUX(3); 
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_18  ;; 0x4004c00c
        STR      R5,[R7, #+0]
//  108         PORTD->PCR[2] = PORT_PCR_MUX(3);
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_19  ;; 0x4004c008
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//  109       }
//  110       else
//  111       {
//  112         if(uartx == UART3)
??LPLD_UART_Init_12:
        LDR.W    R4,??DataTable10_20  ;; 0x4006d000
        CMP      R0,R4
        BNE.N    ??LPLD_UART_Init_13
//  113         {
//  114           x = 3;
        MOVS     R4,#+3
//  115           SIM->SCGC4 |= SIM_SCGC4_UART3_MASK;
        LDR.W    R12,??DataTable10_4  ;; 0x40048034
        LDR      R12,[R12, #+0]
        ORRS     R12,R12,#0x2000
        LDR.W    LR,??DataTable10_4  ;; 0x40048034
        STR      R12,[LR, #+0]
//  116           
//  117           if(tx_pin == PTE4)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+128
        BNE.N    ??LPLD_UART_Init_14
//  118             PORTE->PCR[4] = PORT_PCR_MUX(3); 
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_21  ;; 0x4004d010
        STR      R7,[R12, #+0]
        B.N      ??LPLD_UART_Init_15
//  119           else if(tx_pin == PTB11)
??LPLD_UART_Init_14:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+43
        BNE.N    ??LPLD_UART_Init_16
//  120             PORTB->PCR[11] = PORT_PCR_MUX(3); 
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_22  ;; 0x4004a02c
        STR      R7,[R12, #+0]
        B.N      ??LPLD_UART_Init_15
//  121           else 
//  122             PORTC->PCR[17] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_16:
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_23  ;; 0x4004b044
        STR      R7,[R12, #+0]
//  123           
//  124           if(rx_pin == PTE5)
??LPLD_UART_Init_15:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+129
        BNE.N    ??LPLD_UART_Init_17
//  125             PORTE->PCR[5] = PORT_PCR_MUX(3); 
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_24  ;; 0x4004d014
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//  126           else if(rx_pin == PTB10)
??LPLD_UART_Init_17:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+42
        BNE.N    ??LPLD_UART_Init_18
//  127             PORTB->PCR[10] = PORT_PCR_MUX(3); 
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_25  ;; 0x4004a028
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//  128           else
//  129             PORTC->PCR[16] = PORT_PCR_MUX(3);
??LPLD_UART_Init_18:
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_26  ;; 0x4004b040
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//  130         }
//  131         else
//  132         {
//  133           if(uartx == UART4)
??LPLD_UART_Init_13:
        LDR.W    R4,??DataTable10_27  ;; 0x400ea000
        CMP      R0,R4
        BNE.N    ??LPLD_UART_Init_19
//  134           {
//  135             x = 4;
        MOVS     R4,#+4
//  136             SIM->SCGC1 |= SIM_SCGC1_UART4_MASK;
        LDR.W    R12,??DataTable10_28  ;; 0x40048028
        LDR      R12,[R12, #+0]
        ORRS     R12,R12,#0x400
        LDR.W    LR,??DataTable10_28  ;; 0x40048028
        STR      R12,[LR, #+0]
//  137             
//  138             if(tx_pin == PTE24)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+148
        BNE.N    ??LPLD_UART_Init_20
//  139               PORTE->PCR[24] = PORT_PCR_MUX(3); 
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_29  ;; 0x4004d060
        STR      R7,[R12, #+0]
        B.N      ??LPLD_UART_Init_21
//  140             else
//  141               PORTC->PCR[15] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_20:
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_30  ;; 0x4004b03c
        STR      R7,[R12, #+0]
//  142             
//  143             if(rx_pin == PTE25)
??LPLD_UART_Init_21:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+149
        BNE.N    ??LPLD_UART_Init_22
//  144               PORTE->PCR[25] = PORT_PCR_MUX(3); 
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_31  ;; 0x4004d064
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//  145             else
//  146               PORTC->PCR[14] = PORT_PCR_MUX(3);
??LPLD_UART_Init_22:
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_32  ;; 0x4004b038
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//  147           }
//  148           else
//  149           {
//  150             x = 5;
??LPLD_UART_Init_19:
        MOVS     R4,#+5
//  151             uartx = UART5;
        LDR.W    R0,??DataTable10_33  ;; 0x400eb000
//  152             SIM->SCGC1 |= SIM_SCGC1_UART5_MASK;
        LDR.W    R12,??DataTable10_28  ;; 0x40048028
        LDR      R12,[R12, #+0]
        ORRS     R12,R12,#0x800
        LDR.W    LR,??DataTable10_28  ;; 0x40048028
        STR      R12,[LR, #+0]
//  153             
//  154             if(tx_pin == PTD9)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+101
        BNE.N    ??LPLD_UART_Init_23
//  155               PORTD->PCR[9] = PORT_PCR_MUX(3); 
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_34  ;; 0x4004c024
        STR      R7,[R12, #+0]
        B.N      ??LPLD_UART_Init_24
//  156             else
//  157               PORTE->PCR[8] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_23:
        MOV      R7,#+768
        LDR.W    R12,??DataTable10_35  ;; 0x4004d020
        STR      R7,[R12, #+0]
//  158             
//  159             if(rx_pin == PTD8)
??LPLD_UART_Init_24:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+100
        BNE.N    ??LPLD_UART_Init_25
//  160               PORTD->PCR[8] = PORT_PCR_MUX(3); 
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_36  ;; 0x4004c020
        STR      R5,[R7, #+0]
        B.N      ??LPLD_UART_Init_6
//  161             else
//  162               PORTE->PCR[9] = PORT_PCR_MUX(3); 
??LPLD_UART_Init_25:
        MOV      R5,#+768
        LDR.W    R7,??DataTable10_37  ;; 0x4004d024
        STR      R5,[R7, #+0]
//  163           }
//  164         }
//  165       }
//  166     }
//  167   }
//  168   
//  169   //在配置好其他寄存器前，先关闭发送器和接收器
//  170   uartx->C2 &= ~(UART_C2_TE_MASK | UART_C2_RE_MASK );
??LPLD_UART_Init_6:
        LDRB     R5,[R0, #+3]
        ANDS     R5,R5,#0xF3
        STRB     R5,[R0, #+3]
//  171   
//  172   //配置UART为 8位, 无奇偶校验 */
//  173   uartx->C1 = 0;	
        MOVS     R5,#+0
        STRB     R5,[R0, #+2]
//  174   
//  175   //计算波特率
//  176   sbr = (uint16)((sysclk)/(baud * 16));
        LSLS     R5,R3,#+4
        UDIV     R5,R6,R5
//  177   
//  178   //保存UARTx_BDH寄存器中除了SBR的值
//  179   temp = uartx->BDH & ~(UART_BDH_SBR(0x1F));
        LDRB     R7,[R0, #+0]
        ANDS     R7,R7,#0xE0
//  180   
//  181   uartx->BDH = temp |  UART_BDH_SBR(((sbr & 0x1F00) >> 8));
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LSRS     R12,R5,#+8
        ANDS     R12,R12,#0x1F
        ORRS     R7,R12,R7
        STRB     R7,[R0, #+0]
//  182   uartx->BDL = (uint8)(sbr & UART_BDL_SBR_MASK);
        STRB     R5,[R0, #+1]
//  183   
//  184   //配置波特率的微调分数
//  185   brfa = (((sysclk*32)/(baud * 16)) - (sbr * 32));
        LSLS     R6,R6,#+5
        LSLS     R3,R3,#+4
        UDIV     R3,R6,R3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        SUBS     R3,R3,R5, LSL #+5
//  186   
//  187   //保存UARTx_C4寄存器中除了BRFA的值
//  188   temp = uartx->C4 & ~(UART_C4_BRFA(0x1F));
        LDRB     R5,[R0, #+10]
        ANDS     R7,R5,#0xE0
//  189   
//  190   uartx->C4 = temp |  UART_C4_BRFA(brfa);    
        ANDS     R3,R3,#0x1F
        ORRS     R3,R3,R7
        STRB     R3,[R0, #+10]
//  191   
//  192   //配置发送接收中断
//  193   if(uart_init_structure.UART_RxIntEnable == TRUE && rx_isr != NULL)
        LDRB     R3,[SP, #+30]
        CMP      R3,#+1
        BNE.N    ??LPLD_UART_Init_26
        MOVS     R3,R1
        CMP      R3,#+0
        BEQ.N    ??LPLD_UART_Init_26
//  194   {
//  195     uartx->C2 |= UART_C2_RIE_MASK; 
        LDRB     R3,[R0, #+3]
        ORRS     R3,R3,#0x20
        STRB     R3,[R0, #+3]
//  196     UART_R_ISR[x] = rx_isr;
        LDR.N    R3,??DataTable10_38
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R1,[R3, R4, LSL #+2]
        B.N      ??LPLD_UART_Init_27
//  197   } 
//  198   else
//  199   {
//  200     uartx->C2 &= ~(UART_C2_RIE_MASK); 
??LPLD_UART_Init_26:
        LDRB     R1,[R0, #+3]
        ANDS     R1,R1,#0xDF
        STRB     R1,[R0, #+3]
//  201   }
//  202   if(uart_init_structure.UART_TxIntEnable == TRUE && tx_isr != NULL)
??LPLD_UART_Init_27:
        LDRB     R1,[SP, #+31]
        CMP      R1,#+1
        BNE.N    ??LPLD_UART_Init_28
        MOVS     R1,R2
        CMP      R1,#+0
        BEQ.N    ??LPLD_UART_Init_28
//  203   {
//  204     uartx->C2 |= UART_C2_TIE_MASK; 
        LDRB     R1,[R0, #+3]
        ORRS     R1,R1,#0x80
        STRB     R1,[R0, #+3]
//  205     UART_T_ISR[x] = tx_isr;
        LDR.N    R1,??DataTable10_39
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R2,[R1, R4, LSL #+2]
        B.N      ??LPLD_UART_Init_29
//  206   } 
//  207   else
//  208   {
//  209     uartx->C2 &= ~(UART_C2_TIE_MASK); 
??LPLD_UART_Init_28:
        LDRB     R1,[R0, #+3]
        ANDS     R1,R1,#0x7F
        STRB     R1,[R0, #+3]
//  210   }
//  211   
//  212   //使能发送器和接收器
//  213   uartx->C2 |= (UART_C2_TE_MASK | UART_C2_RE_MASK );    
??LPLD_UART_Init_29:
        LDRB     R1,[R0, #+3]
        ORRS     R1,R1,#0xC
        STRB     R1,[R0, #+3]
//  214 }
        POP      {R4-R7}
        LDR      PC,[SP], #+20    ;; return
//  215 
//  216 /*
//  217  * LPLD_UART_GetChar
//  218  * 串口查询方式读取一个字节
//  219  * 
//  220  * 参数:
//  221  *    uartx--UART模块号
//  222  *      |__UART0          --UART0
//  223  *      |__UART1          --UART1
//  224  *      |__UART2          --UART2
//  225  *      |__UART3          --UART3
//  226  *      |__UART4          --UART4
//  227  *      |__UART5          --UART5
//  228  *
//  229  * 输出:
//  230  *    串口接收的1个字节
//  231  *
//  232  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  233 int8 LPLD_UART_GetChar(UART_Type *uartx)
//  234 {
//  235   //等待数据接收
//  236   while (!(uartx->S1 & UART_S1_RDRF_MASK));
LPLD_UART_GetChar:
??LPLD_UART_GetChar_0:
        LDRB     R1,[R0, #+4]
        LSLS     R1,R1,#+26
        BPL.N    ??LPLD_UART_GetChar_0
//  237   
//  238   //返回接收的1个字节数据
//  239   return uartx->D;
        LDRSB    R0,[R0, #+7]
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  240 }
//  241 
//  242 /********************************************************************/
//  243 /*
//  244  * LPLD_UART_GetChar_Present
//  245  * 检查是否接收到字符
//  246  * 
//  247  * 参数:
//  248  *    uartx--UART模块号
//  249  *      |__UART0          --UART0
//  250  *      |__UART1          --UART1
//  251  *      |__UART2          --UART2
//  252  *      |__UART3          --UART3
//  253  *      |__UART4          --UART4
//  254  *      |__UART5          --UART5
//  255  *
//  256  * 输出:
//  257  *  0       没有接收到字符
//  258  *  1       已经接收到字符
//  259  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  260 int32 LPLD_UART_GetChar_Present(UART_Type *uartx)
//  261 {
//  262     return (uartx->S1 & UART_S1_RDRF_MASK);
LPLD_UART_GetChar_Present:
        LDRB     R0,[R0, #+4]
        ANDS     R0,R0,#0x20
        BX       LR               ;; return
//  263 }
//  264 
//  265 /*
//  266  * LPLD_UART_PutChar
//  267  * 串口查询方式发送一个字节
//  268  * 
//  269  * 参数:
//  270  *    uartx--UART模块号
//  271  *      |__UART0          --UART0
//  272  *      |__UART1          --UART1
//  273  *      |__UART2          --UART2
//  274  *      |__UART3          --UART3
//  275  *      |__UART4          --UART4
//  276  *      |__UART5          --UART5
//  277  *    ch--待发送的1个字节
//  278  *
//  279  * 输出:
//  280  *    无
//  281  *
//  282  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  283 void LPLD_UART_PutChar(UART_Type *uartx, int8 ch)
//  284 {
//  285   //等待FIFO准备就绪
//  286   while(!(uartx->S1 & UART_S1_TDRE_MASK));
LPLD_UART_PutChar:
??LPLD_UART_PutChar_0:
        LDRB     R2,[R0, #+4]
        LSLS     R2,R2,#+24
        BPL.N    ??LPLD_UART_PutChar_0
//  287   
//  288   //将要发送的1个字节发给UART数据寄存器
//  289   uartx->D = (uint8)ch;
        STRB     R1,[R0, #+7]
//  290 }
        BX       LR               ;; return
//  291 
//  292 
//  293 /*
//  294  * LPLD_UART_PutCharArr
//  295  * 串口查询方式发送字节型数组
//  296  * 
//  297  * 参数:
//  298  *    uartx--UART模块号
//  299  *      |__UART0          --UART0
//  300  *      |__UART1          --UART1
//  301  *      |__UART2          --UART2
//  302  *      |__UART3          --UART3
//  303  *      |__UART4          --UART4
//  304  *      |__UART5          --UART5
//  305  *    *ch--待发送的字节数组头地址
//  306  *    len--字节数组长度
//  307  *
//  308  * 输出:
//  309  *    无
//  310  *
//  311  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  312 void LPLD_UART_PutCharArr(UART_Type *uartx, int8 *ch, int32 len)
//  313 {
LPLD_UART_PutCharArr:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        B.N      ??LPLD_UART_PutCharArr_0
//  314   while(len--)
//  315   {
//  316     LPLD_UART_PutChar(uartx, *(ch++));
??LPLD_UART_PutCharArr_1:
        LDRSB    R1,[R5, #+0]
        MOVS     R0,R4
        BL       LPLD_UART_PutChar
        ADDS     R5,R5,#+1
//  317   }
??LPLD_UART_PutCharArr_0:
        MOVS     R0,R6
        SUBS     R6,R0,#+1
        CMP      R0,#+0
        BNE.N    ??LPLD_UART_PutCharArr_1
//  318 }
        POP      {R4-R6,PC}       ;; return
//  319 
//  320 /*
//  321  * LPLD_UART_EnableIrq
//  322  * 使能串口数据接收中断
//  323  * 
//  324  * 参数:
//  325  *    uart_init_structure--UART初始化结构体，
//  326  *                        具体定义见UART_InitTypeDef
//  327  *
//  328  * 输出:
//  329  *    无
//  330  *
//  331  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  332 void LPLD_UART_EnableIrq(UART_InitTypeDef uart_init_structure)
//  333 {
LPLD_UART_EnableIrq:
        PUSH     {R0-R3}
        PUSH     {R7,LR}
//  334   if(uart_init_structure.UART_Uartx == UART0)
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_2  ;; 0x4006a000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_EnableIrq_0
//  335   {
//  336     enable_irq(UART0_RX_TX_IRQn);
        MOVS     R0,#+45
        BL       NVIC_EnableIRQ
        B.N      ??LPLD_UART_EnableIrq_1
//  337   }
//  338   else if(uart_init_structure.UART_Uartx == UART1)
??LPLD_UART_EnableIrq_0:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_11  ;; 0x4006b000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_EnableIrq_2
//  339   {
//  340     enable_irq(UART1_RX_TX_IRQn);
        MOVS     R0,#+47
        BL       NVIC_EnableIRQ
        B.N      ??LPLD_UART_EnableIrq_1
//  341   }
//  342   else if(uart_init_structure.UART_Uartx == UART2)
??LPLD_UART_EnableIrq_2:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_17  ;; 0x4006c000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_EnableIrq_3
//  343   {
//  344     enable_irq(UART2_RX_TX_IRQn);
        MOVS     R0,#+49
        BL       NVIC_EnableIRQ
        B.N      ??LPLD_UART_EnableIrq_1
//  345   }
//  346   else if(uart_init_structure.UART_Uartx == UART3)
??LPLD_UART_EnableIrq_3:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_20  ;; 0x4006d000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_EnableIrq_4
//  347   {
//  348     enable_irq(UART3_RX_TX_IRQn);
        MOVS     R0,#+51
        BL       NVIC_EnableIRQ
        B.N      ??LPLD_UART_EnableIrq_1
//  349   }
//  350   else if(uart_init_structure.UART_Uartx == UART4)
??LPLD_UART_EnableIrq_4:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_27  ;; 0x400ea000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_EnableIrq_5
//  351   {
//  352     enable_irq(UART4_RX_TX_IRQn);
        MOVS     R0,#+53
        BL       NVIC_EnableIRQ
        B.N      ??LPLD_UART_EnableIrq_1
//  353   }
//  354   else if(uart_init_structure.UART_Uartx == UART5)
??LPLD_UART_EnableIrq_5:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_33  ;; 0x400eb000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_EnableIrq_1
//  355   {
//  356     enable_irq(UART5_RX_TX_IRQn);
        MOVS     R0,#+55
        BL       NVIC_EnableIRQ
//  357   }
//  358 }
??LPLD_UART_EnableIrq_1:
        POP      {R0}
        LDR      PC,[SP], #+20    ;; return
//  359 
//  360 /*
//  361  * LPLD_UART_DisableIrq
//  362  * 禁用串口数据接收中断
//  363  * 
//  364  * 参数:
//  365  *    uart_init_structure--UART初始化结构体，
//  366  *                        具体定义见UART_InitTypeDef
//  367  *
//  368  * 输出:
//  369  *    无
//  370  *
//  371  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  372 void LPLD_UART_DisableIrq(UART_InitTypeDef uart_init_structure)
//  373 {
LPLD_UART_DisableIrq:
        PUSH     {R0-R3}
        PUSH     {R7,LR}
//  374   //根据中断请求号使能相应中断
//  375   if(uart_init_structure.UART_Uartx == UART0)
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_2  ;; 0x4006a000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_DisableIrq_0
//  376     disable_irq(UART0_RX_TX_IRQn);
        MOVS     R0,#+45
        BL       NVIC_DisableIRQ
        B.N      ??LPLD_UART_DisableIrq_1
//  377   else if(uart_init_structure.UART_Uartx == UART1)
??LPLD_UART_DisableIrq_0:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_11  ;; 0x4006b000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_DisableIrq_2
//  378     disable_irq(UART1_RX_TX_IRQn);
        MOVS     R0,#+47
        BL       NVIC_DisableIRQ
        B.N      ??LPLD_UART_DisableIrq_1
//  379   else if(uart_init_structure.UART_Uartx == UART2)
??LPLD_UART_DisableIrq_2:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_17  ;; 0x4006c000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_DisableIrq_3
//  380     disable_irq(UART2_RX_TX_IRQn);
        MOVS     R0,#+49
        BL       NVIC_DisableIRQ
        B.N      ??LPLD_UART_DisableIrq_1
//  381   else if(uart_init_structure.UART_Uartx == UART3)
??LPLD_UART_DisableIrq_3:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_20  ;; 0x4006d000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_DisableIrq_4
//  382     disable_irq(UART3_RX_TX_IRQn);
        MOVS     R0,#+51
        BL       NVIC_DisableIRQ
        B.N      ??LPLD_UART_DisableIrq_1
//  383   else if(uart_init_structure.UART_Uartx == UART4)
??LPLD_UART_DisableIrq_4:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_27  ;; 0x400ea000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_DisableIrq_5
//  384     disable_irq(UART4_RX_TX_IRQn);
        MOVS     R0,#+53
        BL       NVIC_DisableIRQ
        B.N      ??LPLD_UART_DisableIrq_1
//  385   else if(uart_init_structure.UART_Uartx == UART5)
??LPLD_UART_DisableIrq_5:
        LDR      R0,[SP, #+8]
        LDR.N    R1,??DataTable10_33  ;; 0x400eb000
        CMP      R0,R1
        BNE.N    ??LPLD_UART_DisableIrq_1
//  386     disable_irq(UART5_RX_TX_IRQn);
        MOVS     R0,#+55
        BL       NVIC_DisableIRQ
//  387 }
??LPLD_UART_DisableIrq_1:
        POP      {R0}
        LDR      PC,[SP], #+20    ;; return
//  388 
//  389 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  390 void UART0_IRQHandler(void)
//  391 {
UART0_IRQHandler:
        PUSH     {R7,LR}
//  392 #if (UCOS_II > 0u)
//  393   OS_CPU_SR  cpu_sr = 0u;
//  394   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  395   OSIntEnter();
//  396   OS_EXIT_CRITICAL();
//  397 #endif
//  398   
//  399   //进入接收中断函数
//  400   if((UART0->S1 & UART_S1_RDRF_MASK) && (UART0->C2 & UART_C2_RIE_MASK))
        LDR.N    R0,??DataTable10_40  ;; 0x4006a004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART0_IRQHandler_0
        LDR.N    R0,??DataTable10_41  ;; 0x4006a003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART0_IRQHandler_0
//  401   {
//  402     UART_R_ISR[0]();
        LDR.N    R0,??DataTable10_38
        LDR      R0,[R0, #+0]
        BLX      R0
//  403   }
//  404   //进入发送中断函数
//  405   if((UART0->S1 & UART_S1_TDRE_MASK) && (UART0->C2 & UART_C2_TIE_MASK))
??UART0_IRQHandler_0:
        LDR.N    R0,??DataTable10_40  ;; 0x4006a004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART0_IRQHandler_1
        LDR.N    R0,??DataTable10_41  ;; 0x4006a003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART0_IRQHandler_1
//  406   {
//  407     UART_T_ISR[0]();
        LDR.N    R0,??DataTable10_39
        LDR      R0,[R0, #+0]
        BLX      R0
//  408   }
//  409   
//  410 #if (UCOS_II > 0u)
//  411   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  412 #endif
//  413 }
??UART0_IRQHandler_1:
        POP      {R0,PC}          ;; return
//  414 
//  415 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  416 void UART1_IRQHandler(void)
//  417 {
UART1_IRQHandler:
        PUSH     {R7,LR}
//  418 #if (UCOS_II > 0u)
//  419   OS_CPU_SR  cpu_sr = 0u;
//  420   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  421   OSIntEnter();
//  422   OS_EXIT_CRITICAL();
//  423 #endif
//  424   
//  425   //进入接收中断函数
//  426   if((UART1->S1 & UART_S1_RDRF_MASK) && (UART1->C2 & UART_C2_RIE_MASK))
        LDR.N    R0,??DataTable10_42  ;; 0x4006b004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART1_IRQHandler_0
        LDR.N    R0,??DataTable10_43  ;; 0x4006b003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART1_IRQHandler_0
//  427   {
//  428     UART_R_ISR[1]();
        LDR.N    R0,??DataTable10_38
        LDR      R0,[R0, #+4]
        BLX      R0
//  429   }
//  430   //进入发送中断函数
//  431   if((UART1->S1 & UART_S1_TDRE_MASK) && (UART1->C2 & UART_C2_TIE_MASK))
??UART1_IRQHandler_0:
        LDR.N    R0,??DataTable10_42  ;; 0x4006b004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART1_IRQHandler_1
        LDR.N    R0,??DataTable10_43  ;; 0x4006b003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART1_IRQHandler_1
//  432   {
//  433     UART_T_ISR[1]();
        LDR.N    R0,??DataTable10_39
        LDR      R0,[R0, #+4]
        BLX      R0
//  434   }
//  435   
//  436 #if (UCOS_II > 0u)
//  437   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  438 #endif
//  439 }
??UART1_IRQHandler_1:
        POP      {R0,PC}          ;; return
//  440 
//  441 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  442 void UART2_IRQHandler(void)
//  443 {
UART2_IRQHandler:
        PUSH     {R7,LR}
//  444 #if (UCOS_II > 0u)
//  445   OS_CPU_SR  cpu_sr = 0u;
//  446   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  447   OSIntEnter();
//  448   OS_EXIT_CRITICAL();
//  449 #endif
//  450   
//  451   //进入接收中断函数
//  452   if((UART2->S1 & UART_S1_RDRF_MASK) && (UART2->C2 & UART_C2_RIE_MASK))
        LDR.N    R0,??DataTable10_44  ;; 0x4006c004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART2_IRQHandler_0
        LDR.N    R0,??DataTable10_45  ;; 0x4006c003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART2_IRQHandler_0
//  453   {
//  454     UART_R_ISR[2]();
        LDR.N    R0,??DataTable10_38
        LDR      R0,[R0, #+8]
        BLX      R0
//  455   }
//  456   //进入发送中断函数
//  457   if((UART2->S1 & UART_S1_TDRE_MASK) && (UART2->C2 & UART_C2_TIE_MASK))
??UART2_IRQHandler_0:
        LDR.N    R0,??DataTable10_44  ;; 0x4006c004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART2_IRQHandler_1
        LDR.N    R0,??DataTable10_45  ;; 0x4006c003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART2_IRQHandler_1
//  458   {
//  459     UART_T_ISR[2]();
        LDR.N    R0,??DataTable10_39
        LDR      R0,[R0, #+8]
        BLX      R0
//  460   }
//  461   
//  462 #if (UCOS_II > 0u)
//  463   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  464 #endif
//  465 }
??UART2_IRQHandler_1:
        POP      {R0,PC}          ;; return
//  466 
//  467 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  468 void UART3_IRQHandler(void)
//  469 {
UART3_IRQHandler:
        PUSH     {R7,LR}
//  470 #if (UCOS_II > 0u)
//  471   OS_CPU_SR  cpu_sr = 0u;
//  472   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  473   OSIntEnter();
//  474   OS_EXIT_CRITICAL();
//  475 #endif
//  476   
//  477   //进入接收中断函数
//  478   if((UART3->S1 & UART_S1_RDRF_MASK) && (UART3->C2 & UART_C2_RIE_MASK))
        LDR.N    R0,??DataTable10_46  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART3_IRQHandler_0
        LDR.N    R0,??DataTable10_47  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART3_IRQHandler_0
//  479   {
//  480     UART_R_ISR[3]();
        LDR.N    R0,??DataTable10_38
        LDR      R0,[R0, #+12]
        BLX      R0
//  481   }
//  482   //进入发送中断函数
//  483   if((UART3->S1 & UART_S1_TDRE_MASK) && (UART3->C2 & UART_C2_TIE_MASK))
??UART3_IRQHandler_0:
        LDR.N    R0,??DataTable10_46  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART3_IRQHandler_1
        LDR.N    R0,??DataTable10_47  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART3_IRQHandler_1
//  484   {
//  485     UART_T_ISR[3]();
        LDR.N    R0,??DataTable10_39
        LDR      R0,[R0, #+12]
        BLX      R0
//  486   }
//  487   
//  488 #if (UCOS_II > 0u)
//  489   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  490 #endif
//  491 }
??UART3_IRQHandler_1:
        POP      {R0,PC}          ;; return
//  492 
//  493 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  494 void UART4_IRQHandler(void)
//  495 {
UART4_IRQHandler:
        PUSH     {R7,LR}
//  496 #if (UCOS_II > 0u)
//  497   OS_CPU_SR  cpu_sr = 0u;
//  498   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  499   OSIntEnter();
//  500   OS_EXIT_CRITICAL();
//  501 #endif
//  502   
//  503   //进入接收中断函数
//  504   if((UART4->S1 & UART_S1_RDRF_MASK) && (UART4->C2 & UART_C2_RIE_MASK))
        LDR.N    R0,??DataTable10_48  ;; 0x400ea004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART4_IRQHandler_0
        LDR.N    R0,??DataTable10_49  ;; 0x400ea003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART4_IRQHandler_0
//  505   {
//  506     UART_R_ISR[4]();
        LDR.N    R0,??DataTable10_38
        LDR      R0,[R0, #+16]
        BLX      R0
//  507   }
//  508   //进入发送中断函数
//  509   if((UART4->S1 & UART_S1_TDRE_MASK) && (UART4->C2 & UART_C2_TIE_MASK))
??UART4_IRQHandler_0:
        LDR.N    R0,??DataTable10_48  ;; 0x400ea004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART4_IRQHandler_1
        LDR.N    R0,??DataTable10_49  ;; 0x400ea003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART4_IRQHandler_1
//  510   {
//  511     UART_T_ISR[4]();
        LDR.N    R0,??DataTable10_39
        LDR      R0,[R0, #+16]
        BLX      R0
//  512   }
//  513   
//  514 #if (UCOS_II > 0u)
//  515   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  516 #endif
//  517 }
??UART4_IRQHandler_1:
        POP      {R0,PC}          ;; return
//  518 
//  519 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  520 void UART5_IRQHandler(void)
//  521 {
UART5_IRQHandler:
        PUSH     {R7,LR}
//  522 #if (UCOS_II > 0u)
//  523   OS_CPU_SR  cpu_sr = 0u;
//  524   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  525   OSIntEnter();
//  526   OS_EXIT_CRITICAL();
//  527 #endif
//  528   
//  529   //进入接收中断函数
//  530   if((UART5->S1 & UART_S1_RDRF_MASK) && (UART5->C2 & UART_C2_RIE_MASK))
        LDR.N    R0,??DataTable10_50  ;; 0x400eb004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART5_IRQHandler_0
        LDR.N    R0,??DataTable10_51  ;; 0x400eb003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART5_IRQHandler_0
//  531   {
//  532     UART_R_ISR[5]();
        LDR.N    R0,??DataTable10_38
        LDR      R0,[R0, #+20]
        BLX      R0
//  533   }
//  534   //进入发送中断函数
//  535   if((UART5->S1 & UART_S1_TDRE_MASK) && (UART5->C2 & UART_C2_TIE_MASK))
??UART5_IRQHandler_0:
        LDR.N    R0,??DataTable10_50  ;; 0x400eb004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART5_IRQHandler_1
        LDR.N    R0,??DataTable10_51  ;; 0x400eb003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART5_IRQHandler_1
//  536   {
//  537     UART_T_ISR[5]();
        LDR.N    R0,??DataTable10_39
        LDR      R0,[R0, #+20]
        BLX      R0
//  538   }
//  539   
//  540 #if (UCOS_II > 0u)
//  541   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  542 #endif
//  543 }
??UART5_IRQHandler_1:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     g_core_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     0x40049008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     0x40049038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     0x4004a044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_8:
        DC32     0x40049004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_9:
        DC32     0x4004903c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_10:
        DC32     0x4004a040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_11:
        DC32     0x4006b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_12:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_13:
        DC32     0x4004b010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_14:
        DC32     0x4004d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_15:
        DC32     0x4004b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_16:
        DC32     g_bus_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_17:
        DC32     0x4006c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_18:
        DC32     0x4004c00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_19:
        DC32     0x4004c008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_20:
        DC32     0x4006d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_21:
        DC32     0x4004d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_22:
        DC32     0x4004a02c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_23:
        DC32     0x4004b044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_24:
        DC32     0x4004d014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_25:
        DC32     0x4004a028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_26:
        DC32     0x4004b040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_27:
        DC32     0x400ea000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_28:
        DC32     0x40048028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_29:
        DC32     0x4004d060

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_30:
        DC32     0x4004b03c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_31:
        DC32     0x4004d064

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_32:
        DC32     0x4004b038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_33:
        DC32     0x400eb000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_34:
        DC32     0x4004c024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_35:
        DC32     0x4004d020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_36:
        DC32     0x4004c020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_37:
        DC32     0x4004d024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_38:
        DC32     UART_R_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_39:
        DC32     UART_T_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_40:
        DC32     0x4006a004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_41:
        DC32     0x4006a003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_42:
        DC32     0x4006b004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_43:
        DC32     0x4006b003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_44:
        DC32     0x4006c004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_45:
        DC32     0x4006c003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_46:
        DC32     0x4006d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_47:
        DC32     0x4006d003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_48:
        DC32     0x400ea004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_49:
        DC32     0x400ea003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_50:
        DC32     0x400eb004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_51:
        DC32     0x400eb003

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
//    48 bytes in section .bss
// 1 600 bytes in section .text
// 
// 1 600 bytes of CODE memory
//    48 bytes of DATA memory
//
//Errors: none
//Warnings: none
