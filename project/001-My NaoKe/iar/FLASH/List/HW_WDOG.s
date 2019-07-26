///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:37
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_WDOG.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_WDOG.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\HW_WDOG.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN g_bus_clock

        PUBLIC LPLD_WDOG_Disable
        PUBLIC LPLD_WDOG_Enable
        PUBLIC LPLD_WDOG_Feed
        PUBLIC LPLD_WDOG_Init

// D:\2019.IAR\lib\LPLD\HW\HW_WDOG.c
//    1 /**
//    2  * @file HW_WDOG.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief WDOG底层模块相关函数
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
//   23 #include "HW_WDOG.h"
//   24 
//   25 static void LPLD_WDOG_Unlock(void);
//   26 
//   27 /*
//   28  * LPLD_WDOG_Init
//   29  * 看门狗初始化
//   30  * 
//   31  * 参数:
//   32  *    period_ms--看门狗复位周期
//   33  *      |__单位为毫秒
//   34  *
//   35  * 输出:
//   36  *    0--配置错误
//   37  *    1--配置成功
//   38  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   39 uint8 LPLD_WDOG_Init(uint32 period_ms)
//   40 {
LPLD_WDOG_Init:
        PUSH     {R3-R5,LR}
//   41   uint8 presc = 3;
        MOVS     R4,#+3
//   42   uint32 bus_khz = g_bus_clock / 1000;
        LDR.N    R1,??DataTable4
        LDR      R1,[R1, #+0]
        MOV      R2,#+1000
        UDIV     R1,R1,R2
//   43   uint32 value;
//   44   
//   45   if(period_ms==0)
        CMP      R0,#+0
        BNE.N    ??LPLD_WDOG_Init_0
//   46   {
//   47     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_WDOG_Init_1
//   48   }
//   49     
//   50   value=(period_ms*bus_khz)/(presc+1);
??LPLD_WDOG_Init_0:
        MULS     R0,R1,R0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R4,#+1
        UDIV     R5,R0,R1
//   51     
//   52   //先解锁寄存器
//   53   LPLD_WDOG_Unlock();
        BL       LPLD_WDOG_Unlock
//   54   //设置分频
//   55   WDOG->PRESC = WDOG_PRESC_PRESCVAL(presc);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+8
        ANDS     R0,R0,#0x700
        LDR.N    R1,??DataTable4_1  ;; 0x40052016
        STRH     R0,[R1, #+0]
//   56   //设置计时溢出值
//   57   WDOG->TOVALH = (value&0xFFFF0000)>>16;
        LSRS     R0,R5,#+16
        LDR.N    R1,??DataTable4_2  ;; 0x40052004
        STRH     R0,[R1, #+0]
//   58   WDOG->TOVALL = (value&0x0000FFFF)>>0;  
        LDR.N    R0,??DataTable4_3  ;; 0x40052006
        STRH     R5,[R0, #+0]
//   59   //使能WDOG
//   60   WDOG->STCTRLH |= WDOG_STCTRLH_WDOGEN_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40052000
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_4  ;; 0x40052000
        STRH     R0,[R1, #+0]
//   61   
//   62   return 1;
        MOVS     R0,#+1
??LPLD_WDOG_Init_1:
        POP      {R1,R4,R5,PC}    ;; return
//   63 }
//   64 
//   65 /*
//   66  * LPLD_WDOG_Enable
//   67  * 看门狗使能
//   68  * 
//   69  * 参数:
//   70  *    无
//   71  *
//   72  * 输出:
//   73  *    无
//   74  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   75 void LPLD_WDOG_Enable(void)
//   76 {
LPLD_WDOG_Enable:
        PUSH     {R7,LR}
//   77   //先解锁寄存器
//   78   LPLD_WDOG_Unlock();
        BL       LPLD_WDOG_Unlock
//   79   //使能WDOG
//   80   WDOG->STCTRLH |= WDOG_STCTRLH_WDOGEN_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40052000
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_4  ;; 0x40052000
        STRH     R0,[R1, #+0]
//   81 }
        POP      {R0,PC}          ;; return
//   82 
//   83 /*
//   84  * LPLD_WDOG_Disable
//   85  * 看门狗禁用
//   86  * 
//   87  * 参数:
//   88  *    无
//   89  *
//   90  * 输出:
//   91  *    无
//   92  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 void LPLD_WDOG_Disable(void)
//   94 {
LPLD_WDOG_Disable:
        PUSH     {R7,LR}
//   95   //先解锁寄存器
//   96   LPLD_WDOG_Unlock();
        BL       LPLD_WDOG_Unlock
//   97   //禁用WDOG
//   98   WDOG->STCTRLH &= ~(WDOG_STCTRLH_WDOGEN_MASK);
        LDR.N    R0,??DataTable4_4  ;; 0x40052000
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+65534
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable4_4  ;; 0x40052000
        STRH     R0,[R1, #+0]
//   99 }
        POP      {R0,PC}          ;; return
//  100 
//  101 /*
//  102  * LPLD_WDOG_Feed
//  103  * 喂狗
//  104  * 
//  105  * 参数:
//  106  *    无
//  107  *
//  108  * 输出:
//  109  *    无
//  110  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  111 void LPLD_WDOG_Feed(void)
//  112 {
//  113   WDOG->REFRESH = 0xA602;
LPLD_WDOG_Feed:
        MOVW     R0,#+42498
        LDR.N    R1,??DataTable4_5  ;; 0x4005200c
        STRH     R0,[R1, #+0]
//  114   WDOG->REFRESH = 0xB480;
        MOVW     R0,#+46208
        LDR.N    R1,??DataTable4_5  ;; 0x4005200c
        STRH     R0,[R1, #+0]
//  115 }
        BX       LR               ;; return
//  116 
//  117 /*
//  118  * LPLD_WDOG_Unlock
//  119  * WDOG解锁函数，内部调用
//  120  * 
//  121  * 参数:
//  122  *    无
//  123  *
//  124  * 输出:
//  125  *    无
//  126  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  127 static void LPLD_WDOG_Unlock(void)
//  128 {
//  129   //以下代码必须在20个时钟周期内完成，否则会复位
//  130   DisableInterrupts;
LPLD_WDOG_Unlock:
        CPSID    I
//  131   
//  132   //写0xC520来解锁寄存器
//  133   WDOG->UNLOCK = 0xC520;
        MOVW     R0,#+50464
        LDR.N    R1,??DataTable4_6  ;; 0x4005200e
        STRH     R0,[R1, #+0]
//  134   
//  135   //接下来写0xD928完成解锁
//  136   WDOG->UNLOCK = 0xD928;
        MOVW     R0,#+55592
        LDR.N    R1,??DataTable4_6  ;; 0x4005200e
        STRH     R0,[R1, #+0]
//  137   	
//  138   EnableInterrupts;
        CPSIE    I
//  139 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     g_bus_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x40052016

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x40052004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x40052006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x40052000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x4005200c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x4005200e

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
// 186 bytes in section .text
// 
// 186 bytes of CODE memory
//
//Errors: none
//Warnings: none
