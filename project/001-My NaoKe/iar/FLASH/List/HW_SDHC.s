///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:34
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_SDHC.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_SDHC.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\HW_SDHC.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN g_core_clock
        EXTERN malloc

        PUBLIC LPLD_SDHC_IOC
        PUBLIC LPLD_SDHC_InitCard
        PUBLIC LPLD_SDHC_ReadBlocks
        PUBLIC LPLD_SDHC_WriteBlocks
        PUBLIC sdcard_ptr

// D:\2019.IAR\lib\LPLD\HW\HW_SDHC.c
//    1 /**
//    2  * @file HW_SDHC.c
//    3  * @version 3.01[By LPLD]
//    4  * @date 2013-10-21
//    5  * @brief SDHC底层模块相关函数
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
//   21  *
//   22  * 版权说明:
//   23  *  SDHC模块驱动程序摘取自飞思卡尔MQX底层驱动，部分功能由拉普兰德修改。
//   24  *  HW_SDHC.h及HW_SDHC.c内的代码版权归飞思卡尔公司享有。
//   25  * 
//   26  * 3.01-2013-10-21 修复低容量SD卡无法初始化BUG
//   27  */
//   28 #include "common.h"
//   29 #include "HW_SDHC.h"
//   30 
//   31 //SD卡信息全局变量

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   32 SDCARD_STRUCT_PTR sdcard_ptr;
sdcard_ptr:
        DS8 4
//   33 
//   34 /*
//   35  * LPLD_SDHC_InitGPIO
//   36  * 初始化SDHC模块相关的GPIO引脚,并使能SDHC寄存器时钟
//   37  * 
//   38  * 参数:
//   39  *    init--PCR寄存器掩码
//   40  *
//   41  * 输出:
//   42  *    无
//   43  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   44 static void LPLD_SDHC_InitGPIO(uint32 init)
//   45 {  
//   46   PORTE->PCR[0] = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D1  */
LPLD_SDHC_InitGPIO:
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8  ;; 0x4004d000
        STR      R1,[R2, #+0]
//   47   PORTE->PCR[1] = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D0  */
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8_1  ;; 0x4004d004
        STR      R1,[R2, #+0]
//   48   PORTE->PCR[2] = init & (PORT_PCR_MUX(4) | PORT_PCR_DSE_MASK);                                          /* SDHC.CLK */
        ANDS     R1,R0,#0x440
        LDR.W    R2,??DataTable8_2  ;; 0x4004d008
        STR      R1,[R2, #+0]
//   49   PORTE->PCR[3] = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.CMD */
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8_3  ;; 0x4004d00c
        STR      R1,[R2, #+0]
//   50   PORTE->PCR[4] = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D3  */
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8_4  ;; 0x4004d010
        STR      R1,[R2, #+0]
//   51   PORTE->PCR[5] = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D2  */
        MOVW     R1,#+1091
        ANDS     R0,R1,R0
        LDR.W    R1,??DataTable8_5  ;; 0x4004d014
        STR      R0,[R1, #+0]
//   52   
//   53   SIM->SCGC3 |= SIM_SCGC3_SDHC_MASK; 
        LDR.W    R0,??DataTable9  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000
        LDR.W    R1,??DataTable9  ;; 0x40048030
        STR      R0,[R1, #+0]
//   54 }
        BX       LR               ;; return
//   55 
//   56 
//   57 /*
//   58  * LPLD_SDHC_SetBaudrate
//   59  * 设置SDHC波特率
//   60  * 
//   61  * 参数:
//   62  *    clock--模块输入时钟，即g_core_clock*1000，单位Hz
//   63  *    baud--SDHC期望时钟频率，单位Hz
//   64  *
//   65  * 输出:
//   66  *    无
//   67  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   68 static void LPLD_SDHC_SetBaudrate(uint32 clock, uint32 baud)
//   69 {
LPLD_SDHC_SetBaudrate:
        PUSH     {R4-R7}
//   70   uint32 pres, div, min, minpres = 0x80, mindiv = 0x0F;
        MOVS     R2,#+128
        MOVS     R3,#+15
//   71   int32  val;
//   72   
//   73   //找到相近的分频因子
//   74   min = (uint32)-1;
        MOVS     R6,#-1
//   75   for (pres = 2; pres <= 256; pres <<= 1)
        MOVS     R4,#+2
        B.N      ??LPLD_SDHC_SetBaudrate_0
//   76   {
//   77     for (div = 1; div <= 16; div++)
//   78     {
//   79       val = pres * div * baud - clock;
??LPLD_SDHC_SetBaudrate_1:
        MUL      R7,R5,R4
        MULS     R7,R1,R7
        SUBS     R7,R7,R0
//   80       if (val >= 0)
        CMP      R7,#+0
        BMI.N    ??LPLD_SDHC_SetBaudrate_2
//   81       {
//   82         if (min > val)
        CMP      R7,R6
        BCS.N    ??LPLD_SDHC_SetBaudrate_2
//   83         {
//   84           min = val;
        MOVS     R6,R7
//   85           minpres = pres;
        MOVS     R2,R4
//   86           mindiv = div;
        MOVS     R3,R5
//   87         }
//   88       }
//   89     }
??LPLD_SDHC_SetBaudrate_2:
        ADDS     R5,R5,#+1
??LPLD_SDHC_SetBaudrate_3:
        CMP      R5,#+17
        BCC.N    ??LPLD_SDHC_SetBaudrate_1
        LSLS     R4,R4,#+1
??LPLD_SDHC_SetBaudrate_0:
        CMP      R4,#+256
        BHI.N    ??LPLD_SDHC_SetBaudrate_4
        MOVS     R5,#+1
        B.N      ??LPLD_SDHC_SetBaudrate_3
//   90   }
//   91   
//   92   //禁止SDHC模块时钟
//   93   SDHC->SYSCTL &= (~ SDHC_SYSCTL_SDCLKEN_MASK);
??LPLD_SDHC_SetBaudrate_4:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x8
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//   94   
//   95   //修改分频因子
//   96   div = SDHC->SYSCTL & (~ (SDHC_SYSCTL_DTOCV_MASK | SDHC_SYSCTL_SDCLKFS_MASK | SDHC_SYSCTL_DVS_MASK));
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        MOVS     R5,R0
        BFC      R5,#+4,#+16
//   97   SDHC->SYSCTL = div | (SDHC_SYSCTL_DTOCV(0x0E) | SDHC_SYSCTL_SDCLKFS(minpres >> 1) | SDHC_SYSCTL_DVS(mindiv - 1));
        LSLS     R0,R2,#+7
        ANDS     R0,R0,#0xFF00
        ORRS     R0,R0,R5
        SUBS     R1,R3,#+1
        LSLS     R1,R1,#+4
        ANDS     R1,R1,#0xF0
        ORRS     R0,R1,R0
        ORRS     R0,R0,#0xE0000
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//   98   
//   99   //等在时钟稳定
//  100   while (0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_SDSTB_MASK))
??LPLD_SDHC_SetBaudrate_5:
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL.N    ??LPLD_SDHC_SetBaudrate_5
//  101   {};
//  102   
//  103   //使能SDHC模块时钟
//  104   SDHC->SYSCTL |= SDHC_SYSCTL_SDCLKEN_MASK;
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  105   SDHC->IRQSTAT |= SDHC_IRQSTAT_DTOE_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100000
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  106 }
        POP      {R4-R7}
        BX       LR               ;; return
//  107 
//  108 /*
//  109  * LPLD_SDHC_IsRunning
//  110  * 获取SDHC模块运行状态
//  111  * 
//  112  * 参数:
//  113  *    无
//  114  *
//  115  * 输出:
//  116  *    TRUE--正在运行
//  117  *    FALSE--停止运行
//  118  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  119 static boolean LPLD_SDHC_IsRunning(void)
//  120 {
//  121   return (0 != (SDHC->PRSSTAT & (SDHC_PRSSTAT_RTA_MASK | SDHC_PRSSTAT_WTA_MASK | SDHC_PRSSTAT_DLA_MASK | SDHC_PRSSTAT_CDIHB_MASK | SDHC_PRSSTAT_CIHB_MASK)));
LPLD_SDHC_IsRunning:
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        MOVW     R1,#+775
        TST      R0,R1
        BEQ.N    ??LPLD_SDHC_IsRunning_0
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_IsRunning_1
??LPLD_SDHC_IsRunning_0:
        MOVS     R0,#+0
??LPLD_SDHC_IsRunning_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  122 }
//  123 
//  124 /*
//  125  * LPLD_SDHC_WaitStatus
//  126  * 等待指定状态标志位置位
//  127  * 
//  128  * 参数:
//  129  *    mask--状态标志位掩码
//  130  *
//  131  * 输出:
//  132  *    状态标志
//  133  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 static uint32 LPLD_SDHC_WaitStatus(uint32 mask)
//  135 {
//  136   uint32 result;
//  137   do
//  138   {
//  139     result = SDHC->IRQSTAT & mask;
LPLD_SDHC_WaitStatus:
??LPLD_SDHC_WaitStatus_0:
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        LDR      R1,[R1, #+0]
        ANDS     R1,R0,R1
//  140   }
//  141   while (0 == result);
        CMP      R1,#+0
        BEQ.N    ??LPLD_SDHC_WaitStatus_0
//  142   return result;
        MOVS     R0,R1
        BX       LR               ;; return
//  143 }
//  144 
//  145 /*
//  146  * LPLD_SDHC_Init
//  147  * SDHC模块初始化函数
//  148  * 
//  149  * 参数:
//  150  *    coreClk--系統主频，单位Hz
//  151  *    baud--SDHC期望时钟频率，单位Hz
//  152  *
//  153  * 输出:
//  154  *    SDHCSTA_OK--状态正常
//  155  *    SDHCSTA_NOINIT--驱动未初始化
//  156  *    SDHCSTA_NODISK--为插入卡
//  157  *    SDHCSTA_PROTECT--卡写保护
//  158  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  159 static SDHCRES LPLD_SDHC_Init(uint32 coreClk, uint32 baud)
//  160 {
LPLD_SDHC_Init:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  161   
//  162   sdcard_ptr->CARD = ESDHC_CARD_NONE;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  163   
//  164   //禁用GPIO的SDHC复用功能
//  165   LPLD_SDHC_InitGPIO (0);
        MOVS     R0,#+0
        BL       LPLD_SDHC_InitGPIO
//  166   
//  167   //复位SDHC模块
//  168   SDHC->SYSCTL = SDHC_SYSCTL_RSTA_MASK | SDHC_SYSCTL_SDCLKFS(0x80);
        LDR.W    R0,??DataTable9_1  ;; 0x1008000
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  169   while (SDHC->SYSCTL & SDHC_SYSCTL_RSTA_MASK)
??LPLD_SDHC_Init_0:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+7
        BMI.N    ??LPLD_SDHC_Init_0
//  170   { };
//  171   
//  172   //初始化寄存器值
//  173   SDHC->VENDOR = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_2  ;; 0x400b10c0
        STR      R0,[R1, #+0]
//  174   SDHC->BLKATTR = SDHC_BLKATTR_BLKCNT(1) | SDHC_BLKATTR_BLKSIZE(512);
        MOVS     R0,#+66048
        LDR.W    R1,??DataTable9_3  ;; 0x400b1004
        STR      R0,[R1, #+0]
//  175   SDHC->PROCTL = SDHC_PROCTL_EMODE(ESDHC_PROCTL_EMODE_LITTLE) | SDHC_PROCTL_D3CD_MASK;
        MOVS     R0,#+40
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  176   SDHC->WML = SDHC_WML_RDWML(2) | SDHC_WML_WRWML(1);
        LDR.W    R0,??DataTable9_4  ;; 0x10002
        LDR.W    R1,??DataTable9_5  ;; 0x400b1044
        STR      R0,[R1, #+0]
//  177   
//  178   //设置SDHC初始化时钟，最好不要超过400kHz
//  179   LPLD_SDHC_SetBaudrate (coreClk, baud);
        MOVS     R1,R5
        MOVS     R0,R4
        BL       LPLD_SDHC_SetBaudrate
//  180   
//  181   //等待
//  182   while (SDHC->PRSSTAT & (SDHC_PRSSTAT_CIHB_MASK | SDHC_PRSSTAT_CDIHB_MASK))
??LPLD_SDHC_Init_1:
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        TST      R0,#0x3
        BNE.N    ??LPLD_SDHC_Init_1
//  183   { };
//  184   
//  185   //使能GPIO的SDHC复用
//  186   LPLD_SDHC_InitGPIO (0xFFFF);
        MOVW     R0,#+65535
        BL       LPLD_SDHC_InitGPIO
//  187   
//  188   //使能各种请求
//  189   SDHC->IRQSTAT = 0xFFFF;
        MOVW     R0,#+65535
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  190   SDHC->IRQSTATEN = SDHC_IRQSTATEN_DEBESEN_MASK | SDHC_IRQSTATEN_DCESEN_MASK | SDHC_IRQSTATEN_DTOESEN_MASK
//  191     | SDHC_IRQSTATEN_CIESEN_MASK | SDHC_IRQSTATEN_CEBESEN_MASK | SDHC_IRQSTATEN_CCESEN_MASK | SDHC_IRQSTATEN_CTOESEN_MASK
//  192       | SDHC_IRQSTATEN_BRRSEN_MASK | SDHC_IRQSTATEN_BWRSEN_MASK | SDHC_IRQSTATEN_CRMSEN_MASK
//  193         | SDHC_IRQSTATEN_TCSEN_MASK | SDHC_IRQSTATEN_CCSEN_MASK;
        LDR.W    R0,??DataTable10_3  ;; 0x7f00b3
        LDR.W    R1,??DataTable10_4  ;; 0x400b1034
        STR      R0,[R1, #+0]
//  194   
//  195   //等待80个初始时钟
//  196   SDHC->SYSCTL |= SDHC_SYSCTL_INITA_MASK;
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  197   while (SDHC->SYSCTL & SDHC_SYSCTL_INITA_MASK)
??LPLD_SDHC_Init_2:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4
        BMI.N    ??LPLD_SDHC_Init_2
//  198   { };
//  199   
//  200   //检查卡是否插入
//  201   if (SDHC->PRSSTAT & SDHC_PRSSTAT_CINS_MASK)
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??LPLD_SDHC_Init_3
//  202   {
//  203     sdcard_ptr->CARD = ESDHC_CARD_UNKNOWN;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
        B.N      ??LPLD_SDHC_Init_4
//  204   }
//  205   else
//  206   {
//  207     sdcard_ptr->STATUS = SDHCSTA_NODISK;
??LPLD_SDHC_Init_3:
        MOVS     R0,#+2
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  208   }
//  209   SDHC->IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
??LPLD_SDHC_Init_4:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  210   
//  211   return SDHCRES_OK;
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  212 }
//  213 
//  214 /*
//  215  * LPLD_SDHC_SendCommand
//  216  * 向SD卡发送指定CMD命令
//  217  * 
//  218  * 参数:
//  219  *    command--SDHC命令信息结构体
//  220  *
//  221  * 输出:
//  222  *    SDHCRES--磁盘功能返回值
//  223  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 static SDHCRES LPLD_SDHC_SendCommand(ESDHC_COMMAND_STRUCT_PTR command)
//  225 {
LPLD_SDHC_SendCommand:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  226   uint32 xfertyp;
//  227   uint32 blkattr;
//  228   
//  229   //检查命令
//  230   xfertyp = command->COMMAND;
        LDR      R5,[R4, #+0]
//  231   
//  232   if (ESDHC_XFERTYP_CMDTYP_RESUME == ((xfertyp & SDHC_XFERTYP_CMDTYP_MASK) >> SDHC_XFERTYP_CMDTYP_SHIFT))
        UBFX     R0,R5,#+22,#+2
        CMP      R0,#+2
        BNE.N    ??LPLD_SDHC_SendCommand_0
//  233   {
//  234     //恢复类型命令必须设置DPSEL位
//  235     xfertyp |= SDHC_XFERTYP_DPSEL_MASK;
        ORRS     R5,R5,#0x200000
//  236   }
//  237   
//  238   if ((0 != command->BLOCKS) && (0 != command->BLOCKSIZE))
??LPLD_SDHC_SendCommand_0:
        LDR      R0,[R4, #+8]
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_SendCommand_1
        LDR      R0,[R4, #+12]
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_SendCommand_1
//  239   {
//  240     xfertyp |= SDHC_XFERTYP_DPSEL_MASK;
        ORRS     R5,R5,#0x200000
//  241     if (command->BLOCKS != 1)
        LDR      R0,[R4, #+8]
        CMP      R0,#+1
        BEQ.N    ??LPLD_SDHC_SendCommand_2
//  242     {
//  243       //多块传输
//  244       xfertyp |= SDHC_XFERTYP_MSBSEL_MASK;
        ORRS     R5,R5,#0x20
//  245     }
//  246     if ((uint32)-1 == command->BLOCKS)
??LPLD_SDHC_SendCommand_2:
        LDR      R0,[R4, #+8]
        CMN      R0,#+1
        BNE.N    ??LPLD_SDHC_SendCommand_3
//  247     {
//  248       //大量传输
//  249       blkattr = SDHC_BLKATTR_BLKSIZE(command->BLOCKSIZE) | SDHC_BLKATTR_BLKCNT(0xFFFF);
        LDR      R0,[R4, #+12]
        LSLS     R0,R0,#+19       ;; ZeroExtS R0,R0,#+19,#+19
        LSRS     R0,R0,#+19
        ORR      R0,R0,#0xFF000000
        ORRS     R0,R0,#0xFF0000
        B.N      ??LPLD_SDHC_SendCommand_4
//  250     }
//  251     else
//  252     {
//  253       blkattr = SDHC_BLKATTR_BLKSIZE(command->BLOCKSIZE) | SDHC_BLKATTR_BLKCNT(command->BLOCKS);
??LPLD_SDHC_SendCommand_3:
        LDR      R0,[R4, #+12]
        LSLS     R0,R0,#+19       ;; ZeroExtS R0,R0,#+19,#+19
        LSRS     R0,R0,#+19
        LDR      R1,[R4, #+8]
        ORRS     R0,R0,R1, LSL #+16
//  254       xfertyp |= SDHC_XFERTYP_BCEN_MASK;
        ORRS     R5,R5,#0x2
        B.N      ??LPLD_SDHC_SendCommand_4
//  255     }
//  256   }
//  257   else
//  258   {
//  259     blkattr = 0;
??LPLD_SDHC_SendCommand_1:
        MOVS     R0,#+0
//  260   }
//  261   
//  262   //卡移除状态清除
//  263   SDHC->IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
??LPLD_SDHC_SendCommand_4:
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x80
        LDR.W    R2,??DataTable10  ;; 0x400b1030
        STR      R1,[R2, #+0]
//  264   
//  265   //等待CMD线空闲
//  266   while (SDHC->PRSSTAT & SDHC_PRSSTAT_CIHB_MASK)
??LPLD_SDHC_SendCommand_5:
        LDR.W    R1,??DataTable8_7  ;; 0x400b1024
        LDR      R1,[R1, #+0]
        LSLS     R1,R1,#+31
        BMI.N    ??LPLD_SDHC_SendCommand_5
//  267   { };
//  268   
//  269   //初始化命令
//  270   SDHC->CMDARG = command->ARGUMENT;
        LDR      R1,[R4, #+4]
        LDR.W    R2,??DataTable10_5  ;; 0x400b1008
        STR      R1,[R2, #+0]
//  271   SDHC->BLKATTR = blkattr;
        LDR.W    R1,??DataTable9_3  ;; 0x400b1004
        STR      R0,[R1, #+0]
//  272   SDHC->DSADDR = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_6  ;; 0x400b1000
        STR      R0,[R1, #+0]
//  273   
//  274   //发送命令
//  275   SDHC->XFERTYP = xfertyp;
        LDR.W    R0,??DataTable10_7  ;; 0x400b100c
        STR      R5,[R0, #+0]
//  276   
//  277   //等待响应
//  278   if (LPLD_SDHC_WaitStatus (SDHC_IRQSTAT_CIE_MASK | SDHC_IRQSTAT_CEBE_MASK | SDHC_IRQSTAT_CCE_MASK | SDHC_IRQSTAT_CC_MASK) != SDHC_IRQSTAT_CC_MASK)
        LDR.W    R0,??DataTable10_8  ;; 0xe0001
        BL       LPLD_SDHC_WaitStatus
        CMP      R0,#+1
        BEQ.N    ??LPLD_SDHC_SendCommand_6
//  279   {
//  280     SDHC->IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CIE_MASK | SDHC_IRQSTAT_CEBE_MASK | SDHC_IRQSTAT_CCE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xF0000
        ORRS     R0,R0,#0x1
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  281     return SDHCRES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_SendCommand_7
//  282   }
//  283   
//  284   //检查卡是否移除
//  285   if (SDHC->IRQSTAT & SDHC_IRQSTAT_CRM_MASK)
??LPLD_SDHC_SendCommand_6:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??LPLD_SDHC_SendCommand_8
//  286   {
//  287     SDHC->IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10001
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  288     sdcard_ptr->STATUS = SDHCSTA_NODISK;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  289     return SDHCRES_NOTRDY;
        MOVS     R0,#+3
        B.N      ??LPLD_SDHC_SendCommand_7
//  290   }
//  291   
//  292   //获取响应
//  293   if (SDHC->IRQSTAT & SDHC_IRQSTAT_CTOE_MASK)
??LPLD_SDHC_SendCommand_8:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??LPLD_SDHC_SendCommand_9
//  294   {
//  295     SDHC->IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10001
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  296     return SDHCRES_NONRSPNS;
        MOVS     R0,#+5
        B.N      ??LPLD_SDHC_SendCommand_7
//  297   }
//  298   if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) != SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_NO))
??LPLD_SDHC_SendCommand_9:
        TST      R5,#0x30000
        BEQ.N    ??LPLD_SDHC_SendCommand_10
//  299   {
//  300     command->RESPONSE[0] = SDHC->CMDRSP[0];
        LDR.W    R0,??DataTable11  ;; 0x400b1010
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+16]
//  301     if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) == SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_136))
        ANDS     R0,R5,#0x30000
        CMP      R0,#+65536
        BNE.N    ??LPLD_SDHC_SendCommand_10
//  302     {
//  303       command->RESPONSE[1] = SDHC->CMDRSP[1];
        LDR.W    R0,??DataTable11_1  ;; 0x400b1014
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+20]
//  304       command->RESPONSE[2] = SDHC->CMDRSP[2];
        LDR.W    R0,??DataTable11_2  ;; 0x400b1018
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+24]
//  305       command->RESPONSE[3] = SDHC->CMDRSP[3];
        LDR.W    R0,??DataTable11_3  ;; 0x400b101c
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+28]
//  306     }
//  307   }
//  308   SDHC->IRQSTAT |= SDHC_IRQSTAT_CC_MASK;
??LPLD_SDHC_SendCommand_10:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  309   
//  310   return SDHCRES_OK;
        MOVS     R0,#+0
??LPLD_SDHC_SendCommand_7:
        POP      {R1,R4,R5,PC}    ;; return
//  311 }
//  312 
//  313 
//  314 /*
//  315  * LPLD_SDHC_IOC
//  316  * SDHC模块其他控制服务函数
//  317  * 
//  318  * 参数:
//  319  *    cmd--SDHC模块控制命令
//  320  *    *param_ptr--控制参数
//  321  *
//  322  * 输出:
//  323  *    SDHCRES--磁盘功能返回值
//  324  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  325 SDHCRES LPLD_SDHC_IOC(uint32 cmd, void *param_ptr)
//  326 {
LPLD_SDHC_IOC:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+36
        MOVS     R5,R1
//  327   
//  328   ESDHC_COMMAND_STRUCT    command;
//  329   boolean                 mem, io, mmc, ceata, mp, hc;
//  330   int32                  val;
//  331   SDHCRES                 result = SDHCRES_OK;
        MOVS     R4,#+0
//  332   uint32 *             param32_ptr = param_ptr;
//  333   
//  334   switch (cmd)
        CMP      R0,#+1
        BEQ.N    ??LPLD_SDHC_IOC_0
        CMP      R0,#+2
        BEQ.W    ??LPLD_SDHC_IOC_1
        CMP      R0,#+3
        BEQ.W    ??LPLD_SDHC_IOC_2
        CMP      R0,#+4
        BEQ.W    ??LPLD_SDHC_IOC_3
        CMP      R0,#+5
        BEQ.W    ??LPLD_SDHC_IOC_4
        CMP      R0,#+6
        BEQ.W    ??LPLD_SDHC_IOC_5
        CMP      R0,#+7
        BEQ.W    ??LPLD_SDHC_IOC_6
        CMP      R0,#+147
        BEQ.W    ??LPLD_SDHC_IOC_7
        B.N      ??LPLD_SDHC_IOC_8
//  335   {
//  336   case IO_IOCTL_ESDHC_INIT:  
//  337     //初始化SDHC模块
//  338     result = LPLD_SDHC_Init (g_core_clock*1000, 400000);
??LPLD_SDHC_IOC_0:
        LDR.W    R1,??DataTable11_4  ;; 0x61a80
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       LPLD_SDHC_Init
        MOVS     R4,R0
//  339     if (SDHCRES_OK != result)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  340     {
//  341       break;
//  342     }
//  343     
//  344     mem = FALSE;
??LPLD_SDHC_IOC_10:
        MOVS     R5,#+0
//  345     io = FALSE;
        MOVS     R6,#+0
//  346     mmc = FALSE;
        MOVS     R7,#+0
//  347     ceata = FALSE;
        MOVS     R8,#+0
//  348     hc = FALSE;
        MOVS     R10,#+0
//  349     mp = FALSE;
        MOVS     R9,#+0
//  350     
//  351     //CMD0 - 空闲命令，复位卡
//  352     command.COMMAND = ESDHC_CMD0;
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  353     command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  354     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  355     result = LPLD_SDHC_SendCommand (&command);
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  356     if (result!=SDHCRES_OK)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??LPLD_SDHC_IOC_11
//  357     {
//  358       sdcard_ptr->STATUS = SDHCSTA_NOINIT;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  359       break;
        B.N      ??LPLD_SDHC_IOC_9
//  360     }
//  361     
//  362     //CMD8 - 发送接口状态，检查是否支持高容量
//  363     command.COMMAND = ESDHC_CMD8;
??LPLD_SDHC_IOC_11:
        LDR.W    R0,??DataTable11_6  ;; 0x81a0000
        STR      R0,[SP, #+0]
//  364     command.ARGUMENT = 0x000001AA;
        MOV      R0,#+426
        STR      R0,[SP, #+4]
//  365     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  366     result = LPLD_SDHC_SendCommand (&command);
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  367     if (result==SDHCRES_ERROR)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_SDHC_IOC_12
//  368     {
//  369       sdcard_ptr->STATUS = SDHCSTA_NOINIT;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  370       break;
        B.N      ??LPLD_SDHC_IOC_9
//  371     }
//  372     if (result == SDHCRES_OK)
??LPLD_SDHC_IOC_12:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_SDHC_IOC_13
//  373     {
//  374       if (command.RESPONSE[0] != command.ARGUMENT)
        LDR      R0,[SP, #+16]
        LDR      R1,[SP, #+4]
        CMP      R0,R1
        BEQ.N    ??LPLD_SDHC_IOC_14
//  375       {
//  376         sdcard_ptr->STATUS = SDHCSTA_NOINIT;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  377         result = SDHCRES_ERROR;
        MOVS     R4,#+1
//  378         break;
        B.N      ??LPLD_SDHC_IOC_9
//  379       }
//  380       hc = TRUE;
??LPLD_SDHC_IOC_14:
        MOVS     R10,#+1
//  381     }
//  382     
//  383     //CMD5 - 发送操作状态，测试IO
//  384     command.COMMAND = ESDHC_CMD5;
??LPLD_SDHC_IOC_13:
        LDR.W    R0,??DataTable11_7  ;; 0x5020000
        STR      R0,[SP, #+0]
//  385     command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  386     command.BLOCKS = 0;      
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  387     result = LPLD_SDHC_SendCommand (&command);
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  388     if (result==SDHCRES_ERROR)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_SDHC_IOC_15
//  389     {
//  390       sdcard_ptr->STATUS = SDHCSTA_NOINIT;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  391       break;
        B.N      ??LPLD_SDHC_IOC_9
//  392     }
//  393     if (result == SDHCRES_OK)
??LPLD_SDHC_IOC_15:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_SDHC_IOC_16
//  394     {
//  395       if (((command.RESPONSE[0] >> 28) & 0x07) && (command.RESPONSE[0] & 0x300000))
        LDR      R0,[SP, #+16]
        UBFX     R0,R0,#+28,#+3
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_17
        LDR      R0,[SP, #+16]
        TST      R0,#0x300000
        BEQ.N    ??LPLD_SDHC_IOC_17
//  396       {
//  397         command.COMMAND = ESDHC_CMD5;
        LDR.W    R0,??DataTable11_7  ;; 0x5020000
        STR      R0,[SP, #+0]
//  398         command.ARGUMENT = 0x300000;
        MOVS     R0,#+3145728
        STR      R0,[SP, #+4]
//  399         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  400         val = 0;
        MOVS     R11,#+0
//  401         do
//  402         {
//  403           val++;
??LPLD_SDHC_IOC_18:
        ADDS     R11,R11,#+1
//  404           if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_19
//  405           {
//  406             break;
//  407           }
//  408         } while ((0 == (command.RESPONSE[0] & 0x80000000)) && (val < ESDHC_ALARM_FREQUENCY));
??LPLD_SDHC_IOC_20:
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BMI.N    ??LPLD_SDHC_IOC_19
        CMP      R11,#+100
        BLT.N    ??LPLD_SDHC_IOC_18
//  409         if (SDHCRES_OK != result)
??LPLD_SDHC_IOC_19:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  410         {
//  411           break;
//  412         }
//  413         if (command.RESPONSE[0] & 0x80000000)
??LPLD_SDHC_IOC_21:
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BPL.N    ??LPLD_SDHC_IOC_22
//  414         {
//  415           io = TRUE;
        MOVS     R6,#+1
//  416         }
//  417         if (command.RESPONSE[0] & 0x08000000)
??LPLD_SDHC_IOC_22:
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+4
        BPL.N    ??LPLD_SDHC_IOC_17
//  418         {
//  419           mp = TRUE;
        MOVS     R9,#+1
        B.N      ??LPLD_SDHC_IOC_17
//  420         }
//  421       }
//  422     }
//  423     else
//  424     {
//  425       mp = TRUE;
??LPLD_SDHC_IOC_16:
        MOVS     R9,#+1
//  426     }
//  427     
//  428     if (mp)
??LPLD_SDHC_IOC_17:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        CMP      R9,#+0
        BEQ.W    ??LPLD_SDHC_IOC_23
//  429     {
//  430       //CMD55 - 特殊应用命令，检查MMC卡
//  431       command.COMMAND = ESDHC_CMD55;
        LDR.W    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+0]
//  432       command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  433       command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  434       if ((result = LPLD_SDHC_SendCommand (&command))==SDHCRES_ERROR)
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BEQ.W    ??LPLD_SDHC_IOC_9
//  435       {
//  436         break;
//  437       }
//  438       if (result == SDHCRES_NONRSPNS)
??LPLD_SDHC_IOC_24:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BNE.N    ??LPLD_SDHC_IOC_25
//  439       {
//  440         //如果为MMC 或 CE-ATA 卡
//  441         io = FALSE;
        MOVS     R6,#+0
//  442         mem = FALSE;
        MOVS     R5,#+0
//  443         hc = FALSE;
        MOVS     R10,#+0
//  444         
//  445         //CMD1 - 发送测试命令，检查高容量支持
//  446         command.COMMAND = ESDHC_CMD1;
        MOVS     R0,#+16777216
        STR      R0,[SP, #+0]
//  447         command.ARGUMENT = 0x40300000;
        LDR.W    R0,??DataTable11_9  ;; 0x40300000
        STR      R0,[SP, #+4]
//  448         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  449         if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  450         {
//  451           break;
//  452         }
//  453         if (0x20000000 == (command.RESPONSE[0] & 0x60000000))
??LPLD_SDHC_IOC_26:
        LDR      R0,[SP, #+16]
        ANDS     R0,R0,#0x60000000
        CMP      R0,#+536870912
        BNE.N    ??LPLD_SDHC_IOC_27
//  454         {
//  455           hc = TRUE;
        MOVS     R10,#+1
//  456         }
//  457         mmc = TRUE;
??LPLD_SDHC_IOC_27:
        MOVS     R7,#+1
//  458         
//  459         //CMD39 - 快速IO，检查CE-ATA的CE签名 */
//  460         command.COMMAND = ESDHC_CMD39;
        LDR.W    R0,??DataTable11_10  ;; 0x27020000
        STR      R0,[SP, #+0]
//  461         command.ARGUMENT = 0x0C00;
        MOV      R0,#+3072
        STR      R0,[SP, #+4]
//  462         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  463         if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  464         {
//  465           break;
//  466         }
//  467         if (0xCE == (command.RESPONSE[0] >> 8) & 0xFF)
??LPLD_SDHC_IOC_28:
        LDR      R0,[SP, #+16]
        LSRS     R0,R0,#+8
        CMP      R0,#+206
        BNE.N    ??LPLD_SDHC_IOC_29
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_IOC_30
??LPLD_SDHC_IOC_29:
        MOVS     R0,#+0
??LPLD_SDHC_IOC_30:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_23
//  468         {
//  469           //CMD39 - 快速IO，检查CE-ATA的AA签名 */
//  470           command.COMMAND = ESDHC_CMD39;
        LDR.W    R0,??DataTable11_10  ;; 0x27020000
        STR      R0,[SP, #+0]
//  471           command.ARGUMENT = 0x0D00;
        MOV      R0,#+3328
        STR      R0,[SP, #+4]
//  472           command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  473           if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  474           {
//  475             break;
//  476           }
//  477           if (0xAA == (command.RESPONSE[0] >> 8) & 0xFF)
??LPLD_SDHC_IOC_31:
        LDR      R0,[SP, #+16]
        LSRS     R0,R0,#+8
        CMP      R0,#+170
        BNE.N    ??LPLD_SDHC_IOC_32
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_IOC_33
??LPLD_SDHC_IOC_32:
        MOVS     R0,#+0
??LPLD_SDHC_IOC_33:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_23
//  478           {
//  479             mmc = FALSE;
        MOVS     R7,#+0
//  480             ceata = TRUE;
        MOVS     R8,#+1
        B.N      ??LPLD_SDHC_IOC_23
//  481           }
//  482         }
//  483       }
//  484       else
//  485       {
//  486         //如果为SD卡
//  487         //ACMD41 - 发送操作状态
//  488         command.COMMAND = ESDHC_ACMD41;
??LPLD_SDHC_IOC_25:
        LDR.W    R0,??DataTable11_11  ;; 0x29020000
        STR      R0,[SP, #+0]
//  489         command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  490         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  491         if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_34
//  492         {
//  493           sdcard_ptr->STATUS = SDHCSTA_NOINIT;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  494           break;
        B.N      ??LPLD_SDHC_IOC_9
//  495         }
//  496         if (command.RESPONSE[0] & 0x300000)
??LPLD_SDHC_IOC_34:
        LDR      R0,[SP, #+16]
        TST      R0,#0x300000
        BEQ.N    ??LPLD_SDHC_IOC_23
//  497         {
//  498           val = 0;
        MOVS     R11,#+0
//  499           do
//  500           {
//  501             val++;
??LPLD_SDHC_IOC_35:
        ADDS     R11,R11,#+1
//  502             
//  503             //CMD55 + ACMD41 - 发送OCR
//  504             command.COMMAND = ESDHC_CMD55;
        LDR.W    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+0]
//  505             command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  506             command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  507             if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_36
//  508             {
//  509               break;
//  510             }
//  511             
//  512             command.COMMAND = ESDHC_ACMD41;
??LPLD_SDHC_IOC_37:
        LDR.W    R0,??DataTable11_11  ;; 0x29020000
        STR      R0,[SP, #+0]
//  513             if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_38
//  514             {
//  515               command.ARGUMENT = 0x40300000;
        LDR.W    R0,??DataTable11_9  ;; 0x40300000
        STR      R0,[SP, #+4]
        B.N      ??LPLD_SDHC_IOC_39
//  516             }
//  517             else
//  518             {
//  519               command.ARGUMENT = 0x00300000;
??LPLD_SDHC_IOC_38:
        MOVS     R0,#+3145728
        STR      R0,[SP, #+4]
//  520             }
//  521             command.BLOCKS = 0;
??LPLD_SDHC_IOC_39:
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  522             if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_36
//  523             {
//  524               break;
//  525             }
//  526           } while ((0 == (command.RESPONSE[0] & 0x80000000)) && (val < ESDHC_ALARM_FREQUENCY));
??LPLD_SDHC_IOC_40:
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BMI.N    ??LPLD_SDHC_IOC_36
        CMP      R11,#+100
        BLT.N    ??LPLD_SDHC_IOC_35
//  527           if (SDHCRES_OK != result)
??LPLD_SDHC_IOC_36:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  528           {
//  529             break;
//  530           }
//  531           if (val >= ESDHC_ALARM_FREQUENCY)
??LPLD_SDHC_IOC_41:
        CMP      R11,#+100
        BLT.N    ??LPLD_SDHC_IOC_42
//  532           {
//  533             hc = FALSE;
        MOVS     R10,#+0
        B.N      ??LPLD_SDHC_IOC_23
//  534           }
//  535           else
//  536           {
//  537             mem = TRUE;
??LPLD_SDHC_IOC_42:
        MOVS     R5,#+1
//  538             if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_23
//  539             {
//  540               hc = FALSE;
        MOVS     R10,#+0
//  541               if (command.RESPONSE[0] & 0x40000000)
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+1
        BPL.N    ??LPLD_SDHC_IOC_23
//  542               {
//  543                 hc = TRUE;
        MOVS     R10,#+1
//  544               }
//  545             }
//  546           }
//  547         }
//  548       }
//  549     }
//  550     if (mmc)
??LPLD_SDHC_IOC_23:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??LPLD_SDHC_IOC_43
//  551     {
//  552       sdcard_ptr->CARD = ESDHC_CARD_MMC;
        MOVS     R0,#+7
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  553     }
//  554     if (ceata)
??LPLD_SDHC_IOC_43:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??LPLD_SDHC_IOC_44
//  555     {
//  556       sdcard_ptr->CARD = ESDHC_CARD_CEATA;
        MOVS     R0,#+8
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  557     }
//  558     if (io)
??LPLD_SDHC_IOC_44:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??LPLD_SDHC_IOC_45
//  559     {
//  560       sdcard_ptr->CARD = ESDHC_CARD_SDIO;
        MOVS     R0,#+4
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  561     }
//  562     if (mem)
??LPLD_SDHC_IOC_45:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??LPLD_SDHC_IOC_46
//  563     {
//  564       sdcard_ptr->CARD = ESDHC_CARD_SD;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  565       if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_46
//  566       {
//  567         sdcard_ptr->CARD = ESDHC_CARD_SDHC;
        MOVS     R0,#+3
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  568       }
//  569     }
//  570     if (io && mem)
??LPLD_SDHC_IOC_46:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??LPLD_SDHC_IOC_47
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??LPLD_SDHC_IOC_47
//  571     {
//  572       sdcard_ptr->CARD = ESDHC_CARD_SDCOMBO;
        MOVS     R0,#+5
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  573       if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_47
//  574       {
//  575         sdcard_ptr->CARD = ESDHC_CARD_SDHCCOMBO;
        MOVS     R0,#+6
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  576       }
//  577     }
//  578     
//  579     //禁用GPIO的SDHC复用
//  580     LPLD_SDHC_InitGPIO (0);
??LPLD_SDHC_IOC_47:
        MOVS     R0,#+0
        BL       LPLD_SDHC_InitGPIO
//  581     
//  582     //设置SDHC工作状态下的默认波特率
//  583     LPLD_SDHC_SetBaudrate (g_core_clock*1000, 25000000);
        LDR.W    R1,??DataTable11_12  ;; 0x17d7840
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       LPLD_SDHC_SetBaudrate
//  584     
//  585     //使能GPIO的SDHC复用
//  586     LPLD_SDHC_InitGPIO (0xFFFF);
        MOVW     R0,#+65535
        BL       LPLD_SDHC_InitGPIO
//  587     
//  588     if(result == SDHCRES_OK)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_SDHC_IOC_48
//  589     {
//  590       sdcard_ptr->STATUS = SDHCSTA_OK;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  591     }
//  592     break;
??LPLD_SDHC_IOC_48:
        B.N      ??LPLD_SDHC_IOC_9
//  593   case IO_IOCTL_ESDHC_SEND_COMMAND:
//  594     result = LPLD_SDHC_SendCommand ((ESDHC_COMMAND_STRUCT_PTR)param32_ptr);
??LPLD_SDHC_IOC_1:
        MOVS     R0,R5
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  595     break;
        B.N      ??LPLD_SDHC_IOC_9
//  596   case IO_IOCTL_ESDHC_GET_BAUDRATE:
//  597     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_3:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_49
//  598     {
//  599       result = SDHCRES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_50
//  600     }
//  601     else
//  602     {
//  603       //获取波特率
//  604       val = ((SDHC->SYSCTL & SDHC_SYSCTL_SDCLKFS_MASK) >> SDHC_SYSCTL_SDCLKFS_SHIFT) << 1;
??LPLD_SDHC_IOC_49:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+7
        ANDS     R11,R0,#0x1FE
//  605       val *= ((SDHC->SYSCTL & SDHC_SYSCTL_DVS_MASK) >> SDHC_SYSCTL_DVS_SHIFT) + 1;
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+4
        ADDS     R0,R0,#+1
        MUL      R11,R0,R11
//  606       *param32_ptr = (uint32)((g_core_clock*1000 / val));
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        UDIV     R0,R0,R11
        STR      R0,[R5, #+0]
//  607     }
//  608     break;
??LPLD_SDHC_IOC_50:
        B.N      ??LPLD_SDHC_IOC_9
//  609   case IO_IOCTL_ESDHC_SET_BAUDRATE:
//  610     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_4:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_51
//  611     {
//  612       result = SDHCRES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_52
//  613     }
//  614     else if (0 == (*param32_ptr))
??LPLD_SDHC_IOC_51:
        LDR      R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_53
//  615     {
//  616       result = SDHCRES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_52
//  617     }
//  618     else
//  619     {
//  620       if (! LPLD_SDHC_IsRunning ())
??LPLD_SDHC_IOC_53:
        BL       LPLD_SDHC_IsRunning
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_54
//  621       {
//  622         //禁用GPIO的SDHC复用
//  623         LPLD_SDHC_InitGPIO (0);
        MOVS     R0,#+0
        BL       LPLD_SDHC_InitGPIO
//  624         
//  625         //设置波特率
//  626         LPLD_SDHC_SetBaudrate (g_core_clock*1000, *param32_ptr);
        LDR      R1,[R5, #+0]
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       LPLD_SDHC_SetBaudrate
//  627         
//  628         //使能GPIO的SDHC复用
//  629         LPLD_SDHC_InitGPIO (0xFFFF);
        MOVW     R0,#+65535
        BL       LPLD_SDHC_InitGPIO
        B.N      ??LPLD_SDHC_IOC_52
//  630       }
//  631       else
//  632       {
//  633         result = SDHCRES_ERROR;
??LPLD_SDHC_IOC_54:
        MOVS     R4,#+1
//  634       }
//  635     }
//  636     break;
??LPLD_SDHC_IOC_52:
        B.N      ??LPLD_SDHC_IOC_9
//  637   case IO_IOCTL_ESDHC_GET_BUS_WIDTH:
//  638     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_5:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_55
//  639     {
//  640       result = SDHCRES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_56
//  641     }
//  642     else
//  643     {
//  644       //获得SDHC总线宽度
//  645       val = (SDHC->PROCTL & SDHC_PROCTL_DTW_MASK) >> SDHC_PROCTL_DTW_SHIFT;
??LPLD_SDHC_IOC_55:
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        UBFX     R11,R0,#+1,#+2
//  646       if (ESDHC_PROCTL_DTW_1BIT == val)
        CMP      R11,#+0
        BNE.N    ??LPLD_SDHC_IOC_57
//  647       {
//  648         *param32_ptr = ESDHC_BUS_WIDTH_1BIT;
        MOVS     R0,#+0
        STR      R0,[R5, #+0]
        B.N      ??LPLD_SDHC_IOC_56
//  649       }
//  650       else if (ESDHC_PROCTL_DTW_4BIT == val)
??LPLD_SDHC_IOC_57:
        CMP      R11,#+1
        BNE.N    ??LPLD_SDHC_IOC_58
//  651       {
//  652         *param32_ptr = ESDHC_BUS_WIDTH_4BIT;
        MOVS     R0,#+1
        STR      R0,[R5, #+0]
        B.N      ??LPLD_SDHC_IOC_56
//  653       }
//  654       else if (ESDHC_PROCTL_DTW_8BIT == val)
??LPLD_SDHC_IOC_58:
        CMP      R11,#+16
        BNE.N    ??LPLD_SDHC_IOC_59
//  655       {
//  656         *param32_ptr = ESDHC_BUS_WIDTH_8BIT;
        MOVS     R0,#+2
        STR      R0,[R5, #+0]
        B.N      ??LPLD_SDHC_IOC_56
//  657       }
//  658       else
//  659       {
//  660         result = SDHCRES_ERROR;
??LPLD_SDHC_IOC_59:
        MOVS     R4,#+1
//  661       }
//  662     }
//  663     break;
??LPLD_SDHC_IOC_56:
        B.N      ??LPLD_SDHC_IOC_9
//  664   case IO_IOCTL_ESDHC_SET_BUS_WIDTH:
//  665     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_6:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_60
//  666     {
//  667       result = SDHCRES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_61
//  668     }
//  669     else
//  670     {
//  671       //设置SDHC总线宽度
//  672       if (! LPLD_SDHC_IsRunning ())
??LPLD_SDHC_IOC_60:
        BL       LPLD_SDHC_IsRunning
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_62
//  673       {
//  674         if (ESDHC_BUS_WIDTH_1BIT == *param32_ptr)
        LDR      R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_63
//  675         {
//  676           SDHC->PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  677           SDHC->PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_1BIT);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
        B.N      ??LPLD_SDHC_IOC_61
//  678         }
//  679         else if (ESDHC_BUS_WIDTH_4BIT == *param32_ptr)
??LPLD_SDHC_IOC_63:
        LDR      R0,[R5, #+0]
        CMP      R0,#+1
        BNE.N    ??LPLD_SDHC_IOC_64
//  680         {
//  681           SDHC->PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  682           SDHC->PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_4BIT);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
        B.N      ??LPLD_SDHC_IOC_61
//  683         }
//  684         else if (ESDHC_BUS_WIDTH_8BIT == *param32_ptr)
??LPLD_SDHC_IOC_64:
        LDR      R0,[R5, #+0]
        CMP      R0,#+2
        BNE.N    ??LPLD_SDHC_IOC_65
//  685         {
//  686           SDHC->PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  687           SDHC->PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_8BIT);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
        B.N      ??LPLD_SDHC_IOC_61
//  688         }
//  689         else
//  690         {
//  691           result = SDHCRES_ERROR;
??LPLD_SDHC_IOC_65:
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_61
//  692         }
//  693       }
//  694       else
//  695       {
//  696         result = SDHCRES_ERROR;
??LPLD_SDHC_IOC_62:
        MOVS     R4,#+1
//  697       }
//  698     }
//  699     break;
??LPLD_SDHC_IOC_61:
        B.N      ??LPLD_SDHC_IOC_9
//  700   case IO_IOCTL_ESDHC_GET_CARD:
//  701     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_2:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_66
//  702     {
//  703       result = SDHCRES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_67
//  704     }
//  705     else
//  706     {
//  707       //等待80个时钟
//  708       SDHC->SYSCTL |= SDHC_SYSCTL_INITA_MASK;
??LPLD_SDHC_IOC_66:
        LDR.N    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  709       while (SDHC->SYSCTL & SDHC_SYSCTL_INITA_MASK)
??LPLD_SDHC_IOC_68:
        LDR.N    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4
        BMI.N    ??LPLD_SDHC_IOC_68
//  710       { };
//  711       
//  712       //更新并返回卡实际状态
//  713       if (SDHC->IRQSTAT & SDHC_IRQSTAT_CRM_MASK)
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??LPLD_SDHC_IOC_69
//  714       {
//  715         SDHC->IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  716         sdcard_ptr->CARD = ESDHC_CARD_NONE;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  717         sdcard_ptr->STATUS = SDHCSTA_NODISK;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
//  718       }
//  719       if (SDHC->PRSSTAT & SDHC_PRSSTAT_CINS_MASK)
??LPLD_SDHC_IOC_69:
        LDR.N    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??LPLD_SDHC_IOC_70
//  720       {
//  721         if (ESDHC_CARD_NONE == sdcard_ptr->CARD)
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+16]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_71
//  722         {
//  723           sdcard_ptr->CARD = ESDHC_CARD_UNKNOWN;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
        B.N      ??LPLD_SDHC_IOC_71
//  724         }
//  725       }
//  726       else
//  727       {
//  728         sdcard_ptr->CARD = ESDHC_CARD_NONE;
??LPLD_SDHC_IOC_70:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  729       }
//  730       *param32_ptr = sdcard_ptr->CARD;
??LPLD_SDHC_IOC_71:
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+16]
        STR      R0,[R5, #+0]
//  731     }
//  732     break;
??LPLD_SDHC_IOC_67:
        B.N      ??LPLD_SDHC_IOC_9
//  733     
//  734   case IO_IOCTL_FLUSH_OUTPUT:
//  735     //等待传输完成
//  736     LPLD_SDHC_WaitStatus (SDHC_IRQSTAT_TC_MASK);
??LPLD_SDHC_IOC_7:
        MOVS     R0,#+2
        BL       LPLD_SDHC_WaitStatus
//  737     if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        TST      R0,#0x700000
        BEQ.N    ??LPLD_SDHC_IOC_72
//  738     {
//  739       SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x700000
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  740       result = SDHCRES_ERROR;
        MOVS     R4,#+1
//  741     }
//  742     SDHC->IRQSTAT |= SDHC_IRQSTAT_TC_MASK | SDHC_IRQSTAT_BRR_MASK | SDHC_IRQSTAT_BWR_MASK;
??LPLD_SDHC_IOC_72:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x32
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  743     break;
        B.N      ??LPLD_SDHC_IOC_9
//  744   default:
//  745     result = SDHCRES_ERROR;
??LPLD_SDHC_IOC_8:
        MOVS     R4,#+1
//  746     break;
//  747   }
//  748   
//  749   
//  750   return result;
??LPLD_SDHC_IOC_9:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+36
        POP      {R4-R11,PC}      ;; return
//  751 }
//  752 
//  753 /*
//  754  * LPLD_SDHC_Read
//  755  * SDHC读操作
//  756  * 
//  757  * 参数:
//  758  *    *data_ptr--存储数据地址指针
//  759  *    n--待读的数据长度
//  760  *
//  761  * 输出:
//  762  *    SDHCRES--磁盘功能返回值
//  763  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  764 static SDHCSTATUS LPLD_SDHC_Read(uint8 *data_ptr, int32 n)
//  765 {
LPLD_SDHC_Read:
        PUSH     {R4}
//  766   uint32 buffer;
//  767   int32 remains;
//  768   
//  769   remains = n;
        MOVS     R2,R1
//  770   if (((uint32)data_ptr & 0x03) == 0)
        ANDS     R3,R0,#0x3
        CMP      R3,#+0
        BNE.N    ??LPLD_SDHC_Read_0
        B.N      ??LPLD_SDHC_Read_1
//  771   {    
//  772     //数据位字对齐，可以以最快的速度直接从寄存器拷贝
//  773     while (remains >= 4)
//  774     {
//  775       if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  776       {
//  777         SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
//  778         return SDHCRES_ERROR;
//  779       }
//  780       
//  781       //等待，直到收到的数据达到水印长度或传输完成
//  782       while ((0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_BREN_MASK)) && (SDHC->PRSSTAT & SDHC_PRSSTAT_DLA_MASK))
??LPLD_SDHC_Read_2:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+20
        BMI.N    ??LPLD_SDHC_Read_3
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+29
        BMI.N    ??LPLD_SDHC_Read_2
//  783       { };
//  784       
//  785       *((uint32 *)data_ptr) = SDHC->DATPORT;
??LPLD_SDHC_Read_3:
        LDR.W    R3,??DataTable11_13  ;; 0x400b1020
        LDR      R3,[R3, #+0]
        STR      R3,[R0, #+0]
//  786       data_ptr += 4;
        ADDS     R0,R0,#+4
//  787       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Read_1:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Read_4
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_2
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  788     }
//  789   }
//  790   else
//  791   {
//  792     //非对齐数据，读到临时区域并以字节复制
//  793     while (remains >= 4)
//  794     {
//  795       if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  796       {
//  797         SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
//  798         return SDHCRES_ERROR;
//  799       }
//  800       
//  801       //等待，直到收到的数据达到水印长度或传输完成
//  802       while ((0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_BREN_MASK)) && (SDHC->PRSSTAT & SDHC_PRSSTAT_DLA_MASK))
??LPLD_SDHC_Read_6:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+20
        BMI.N    ??LPLD_SDHC_Read_7
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+29
        BMI.N    ??LPLD_SDHC_Read_6
//  803       { };
//  804       
//  805       buffer = SDHC->DATPORT;
??LPLD_SDHC_Read_7:
        LDR.W    R3,??DataTable11_13  ;; 0x400b1020
        LDR      R3,[R3, #+0]
//  806       
//  807       *data_ptr++ = buffer & 0xFF;
        STRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  808       *data_ptr++ = (buffer >> 8) & 0xFF;
        LSRS     R4,R3,#+8
        STRB     R4,[R0, #+0]
        ADDS     R0,R0,#+1
//  809       *data_ptr++ = (buffer >> 16) & 0xFF;
        LSRS     R4,R3,#+16
        STRB     R4,[R0, #+0]
        ADDS     R0,R0,#+1
//  810       *data_ptr++ = (buffer >> 24) & 0xFF;
        LSRS     R3,R3,#+24
        STRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  811       
//  812       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Read_0:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Read_4
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_6
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  813     }      
//  814   }
//  815   
//  816   if (remains)
??LPLD_SDHC_Read_4:
        CMP      R2,#+0
        BEQ.N    ??LPLD_SDHC_Read_8
//  817   {
//  818     //剩下的少于单字长度数据
//  819     if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_9
//  820     {
//  821       SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  822       return SDHCRES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  823     }
//  824     
//  825     //等待，直到收到的数据达到水印长度或传输完成
//  826     while ((0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_BREN_MASK)) && (SDHC->PRSSTAT & SDHC_PRSSTAT_DLA_MASK))
??LPLD_SDHC_Read_9:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+20
        BMI.N    ??LPLD_SDHC_Read_10
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+29
        BMI.N    ??LPLD_SDHC_Read_9
//  827     { };
//  828     
//  829     buffer = SDHC->DATPORT;
??LPLD_SDHC_Read_10:
        LDR.W    R3,??DataTable11_13  ;; 0x400b1020
        LDR      R3,[R3, #+0]
        B.N      ??LPLD_SDHC_Read_11
//  830     while (remains)
//  831     {
//  832       
//  833       *data_ptr++ = buffer & 0xFF;
??LPLD_SDHC_Read_12:
        STRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  834       buffer >>= 8;
        LSRS     R3,R3,#+8
//  835       
//  836       remains--;
        SUBS     R2,R2,#+1
//  837     }
??LPLD_SDHC_Read_11:
        CMP      R2,#+0
        BNE.N    ??LPLD_SDHC_Read_12
//  838   }
//  839   
//  840   if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
??LPLD_SDHC_Read_8:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        TST      R0,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_13
//  841   {
//  842     SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  843     return SDHCRES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  844   }
//  845   
//  846   return (n - remains);
??LPLD_SDHC_Read_13:
        SUBS     R0,R1,R2
??LPLD_SDHC_Read_5:
        POP      {R4}
        BX       LR               ;; return
//  847 }
//  848 
//  849 /*
//  850  * LPLD_SDHC_Write
//  851  * SDHC写操作
//  852  * 
//  853  * 参数:
//  854  *    *data_ptr--存储数据地址指针
//  855  *    n--待写的数据长度
//  856  *
//  857  * 输出:
//  858  *    SDHCRES--磁盘功能返回值
//  859  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  860 static SDHCSTATUS LPLD_SDHC_Write(uint8 *data_ptr, int32 n)
//  861 {
LPLD_SDHC_Write:
        PUSH     {R4}
//  862   uint8 *udata_ptr;
//  863   uint32 buffer;
//  864   int32 remains;
//  865   
//  866   //复制数据指针
//  867   udata_ptr = (uint8 *)data_ptr;
//  868   
//  869   remains = n;
        MOVS     R2,R1
//  870   if (((uint32)udata_ptr & 0x03) == 0)
        ANDS     R3,R0,#0x3
        CMP      R3,#+0
        BNE.N    ??LPLD_SDHC_Write_0
        B.N      ??LPLD_SDHC_Write_1
//  871   {
//  872     //数据位字对齐，可以以最快的速度直接拷贝到寄存器
//  873     while (remains >= 4)
//  874     {
//  875       if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  876       {
//  877         SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
//  878         return SDHCRES_ERROR;
//  879       }
//  880       
//  881       //等待，直到水印空间可用 
//  882       while (0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_2:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+21
        BPL.N    ??LPLD_SDHC_Write_2
//  883       { };
//  884       
//  885       SDHC->DATPORT = *((uint32 *)udata_ptr);
        LDR      R3,[R0, #+0]
        LDR.W    R4,??DataTable11_13  ;; 0x400b1020
        STR      R3,[R4, #+0]
//  886       udata_ptr += 4;
        ADDS     R0,R0,#+4
//  887       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Write_1:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Write_3
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_2
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  888     }
//  889   }
//  890   else
//  891   {
//  892     //非对齐数据，写到临时区域并以字节复制
//  893     while (remains >= 4)
//  894     {
//  895       if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  896       {
//  897         SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
//  898         return SDHCRES_ERROR;
//  899       }
//  900       
//  901       //等待，直到水印空间可用 
//  902       while (0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_5:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+21
        BPL.N    ??LPLD_SDHC_Write_5
//  903       { };
//  904       
//  905       buffer  = (*udata_ptr++);
        LDRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  906       buffer |= (*udata_ptr++) << 8;
        LDRB     R4,[R0, #+0]
        ORRS     R3,R3,R4, LSL #+8
        ADDS     R0,R0,#+1
//  907       buffer |= (*udata_ptr++) << 16;
        LDRB     R4,[R0, #+0]
        ORRS     R3,R3,R4, LSL #+16
        ADDS     R0,R0,#+1
//  908       buffer |= (*udata_ptr++) << 24;
        LDRB     R4,[R0, #+0]
        ORRS     R3,R3,R4, LSL #+24
        ADDS     R0,R0,#+1
//  909       
//  910       //等待，直到水印空间可用 
//  911       while (0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_6:
        LDR.N    R4,??DataTable8_7  ;; 0x400b1024
        LDR      R4,[R4, #+0]
        LSLS     R4,R4,#+21
        BPL.N    ??LPLD_SDHC_Write_6
//  912       { };
//  913       
//  914       SDHC->DATPORT = buffer;
        LDR.W    R4,??DataTable11_13  ;; 0x400b1020
        STR      R3,[R4, #+0]
//  915       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Write_0:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Write_3
        LDR.N    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_5
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  916     }      
//  917   }
//  918   
//  919   if (remains)
??LPLD_SDHC_Write_3:
        CMP      R2,#+0
        BEQ.N    ??LPLD_SDHC_Write_7
//  920   {
//  921     //剩余少于单字长度的数据
//  922     if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
        LDR.N    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_8
//  923     {
//  924       SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  925       return SDHCRES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  926     }
//  927     
//  928     buffer = 0xFFFFFFFF;
??LPLD_SDHC_Write_8:
        MOVS     R3,#-1
        B.N      ??LPLD_SDHC_Write_9
//  929     while (remains)
//  930     {
//  931       buffer <<= 8;
??LPLD_SDHC_Write_10:
        LSLS     R3,R3,#+8
//  932       buffer |= udata_ptr[remains];
        LDRB     R4,[R2, R0]
        ORRS     R3,R4,R3
//  933       remains--;
        SUBS     R2,R2,#+1
//  934     }
??LPLD_SDHC_Write_9:
        CMP      R2,#+0
        BNE.N    ??LPLD_SDHC_Write_10
//  935     
//  936     //等待，直到水印空间可用 
//  937     while (0 == (SDHC->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_11:
        LDR.N    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+21
        BPL.N    ??LPLD_SDHC_Write_11
//  938     { };
//  939     
//  940     SDHC->DATPORT = buffer;        
        LDR.W    R0,??DataTable11_13  ;; 0x400b1020
        STR      R3,[R0, #+0]
//  941   }
//  942   
//  943   if (SDHC->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
??LPLD_SDHC_Write_7:
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        TST      R0,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_12
//  944   {
//  945     SDHC->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  946     return SDHCRES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  947   }
//  948   
//  949   return (n - remains);
??LPLD_SDHC_Write_12:
        SUBS     R0,R1,R2
??LPLD_SDHC_Write_4:
        POP      {R4}
        BX       LR               ;; return
//  950 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_1:
        DC32     0x4004d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_2:
        DC32     0x4004d008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_3:
        DC32     0x4004d00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_4:
        DC32     0x4004d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_5:
        DC32     0x4004d014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_6:
        DC32     0x400b102c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_7:
        DC32     0x400b1024
//  951 
//  952 /*
//  953  * LPLD_SDHC_InitCard
//  954  * 初始化SDHC模块及SD卡，设置正常工作波特率为40MHz
//  955  * 
//  956  * 参数:
//  957  *    无
//  958  *
//  959  * 输出:
//  960  *    SDHCSTA_OK--状态正常
//  961  *    SDHCSTA_NOINIT--驱动未初始化
//  962  *    SDHCSTA_NODISK--为插入卡
//  963  *    SDHCSTA_PROTECT--卡写保护
//  964  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  965 SDHCSTATUS LPLD_SDHC_InitCard(void)
//  966 {
LPLD_SDHC_InitCard:
        PUSH     {R4,LR}
        SUB      SP,SP,#+40
//  967   uint32 param, c_size, c_size_mult, read_bl_len, time_out = 0;
        MOVS     R4,#+0
//  968   ESDHC_COMMAND_STRUCT command;
//  969   SDHCSTATUS result;
//  970   
//  971   //分配SD卡信息结构体的数据空间并初始化
//  972   sdcard_ptr = (SDCARD_STRUCT_PTR)malloc(sizeof(SDCARD_STRUCT));
        MOVS     R0,#+24
        BL       malloc
        LDR.N    R1,??DataTable10_1
        STR      R0,[R1, #+0]
//  973   sdcard_ptr->CARD = ESDHC_CARD_NONE;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+16]
//  974   sdcard_ptr->TIMEOUT = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+0]
//  975   sdcard_ptr->NUM_BLOCKS = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+4]
//  976   sdcard_ptr->ADDRESS = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+12]
//  977   sdcard_ptr->HC = FALSE;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STRB     R0,[R1, #+8]
//  978   sdcard_ptr->VERSION2 = FALSE;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STRB     R0,[R1, #+9]
//  979   sdcard_ptr->STATUS = SDHCSTA_OK;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+20]
        B.N      ??LPLD_SDHC_InitCard_0
//  980    
//  981   while(time_out < 1000)
//  982   {
//  983     
//  984     //初始化SDHC模块并检测卡
//  985     if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_INIT, NULL)))
//  986     {
//  987       continue;
??LPLD_SDHC_InitCard_1:
??LPLD_SDHC_InitCard_0:
        CMP      R4,#+1000
        BCS.N    ??LPLD_SDHC_InitCard_2
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_1
//  988     }
//  989     
//  990     //SDHC检查
//  991     param = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  992     if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_GET_CARD, &param)))
        ADD      R1,SP,#+0
        MOVS     R0,#+3
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_0
//  993     {
//  994       continue;
//  995     }
//  996     if ((ESDHC_CARD_SD == param) || (ESDHC_CARD_SDHC == param) || (ESDHC_CARD_SDCOMBO == param) || (ESDHC_CARD_SDHCCOMBO == param))
??LPLD_SDHC_InitCard_3:
        LDR      R0,[SP, #+0]
        CMP      R0,#+2
        BEQ.N    ??LPLD_SDHC_InitCard_4
        LDR      R0,[SP, #+0]
        CMP      R0,#+3
        BEQ.N    ??LPLD_SDHC_InitCard_4
        LDR      R0,[SP, #+0]
        CMP      R0,#+5
        BEQ.N    ??LPLD_SDHC_InitCard_4
        LDR      R0,[SP, #+0]
        CMP      R0,#+6
        BNE.N    ??LPLD_SDHC_InitCard_5
//  997     {
//  998       if ((ESDHC_CARD_SDHC == param) || (ESDHC_CARD_SDHCCOMBO == param))
??LPLD_SDHC_InitCard_4:
        LDR      R0,[SP, #+0]
        CMP      R0,#+3
        BEQ.N    ??LPLD_SDHC_InitCard_6
        LDR      R0,[SP, #+0]
        CMP      R0,#+6
        BNE.N    ??LPLD_SDHC_InitCard_7
//  999       {
// 1000         sdcard_ptr->HC = TRUE;
??LPLD_SDHC_InitCard_6:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STRB     R0,[R1, #+8]
// 1001         break;
// 1002       }
// 1003       else if(ESDHC_CARD_SD == param)
// 1004       {
// 1005         break;
// 1006       }
// 1007     }
// 1008     else
// 1009     {
// 1010       continue;
// 1011     }
// 1012     time_out++;
// 1013   }
// 1014   
// 1015   if(time_out >= 1000)
??LPLD_SDHC_InitCard_2:
        CMP      R4,#+1000
        BCC.N    ??LPLD_SDHC_InitCard_8
// 1016     return SDHCRES_NOTRDY;
        MOVS     R0,#+3
        B.N      ??LPLD_SDHC_InitCard_9
??LPLD_SDHC_InitCard_7:
        LDR      R0,[SP, #+0]
        CMP      R0,#+2
        BEQ.N    ??LPLD_SDHC_InitCard_2
??LPLD_SDHC_InitCard_10:
        ADDS     R4,R4,#+1
        B.N      ??LPLD_SDHC_InitCard_0
??LPLD_SDHC_InitCard_5:
        B.N      ??LPLD_SDHC_InitCard_0
// 1017   
// 1018   //卡识别
// 1019   command.COMMAND = ESDHC_CMD2;
??LPLD_SDHC_InitCard_8:
        LDR.W    R0,??DataTable11_14  ;; 0x2090000
        STR      R0,[SP, #+4]
// 1020   command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
// 1021   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1022   if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_InitCard_9
// 1023   {
// 1024     return result;
// 1025   }
// 1026   
// 1027   //获取卡地址
// 1028   command.COMMAND = ESDHC_CMD3;
??LPLD_SDHC_InitCard_11:
        LDR.N    R0,??DataTable11_15  ;; 0x31a0000
        STR      R0,[SP, #+4]
// 1029   command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
// 1030   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1031   if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_InitCard_9
// 1032   {
// 1033     return result;
// 1034   }
// 1035   sdcard_ptr->ADDRESS = command.RESPONSE[0] & 0xFFFF0000;
??LPLD_SDHC_InitCard_12:
        LDR      R0,[SP, #+20]
        LSRS     R0,R0,#+16
        LSLS     R0,R0,#+16
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+12]
// 1036   
// 1037   //获取卡参数
// 1038   command.COMMAND = ESDHC_CMD9;
        LDR.N    R0,??DataTable11_16  ;; 0x9090000
        STR      R0,[SP, #+4]
// 1039   command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1040   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1041   if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1042   {
// 1043     return result;
// 1044   }
// 1045   if (0 == (command.RESPONSE[3] & 0x00C00000))
??LPLD_SDHC_InitCard_13:
        LDR      R0,[SP, #+32]
        TST      R0,#0xC00000
        BNE.N    ??LPLD_SDHC_InitCard_14
// 1046   {
// 1047     read_bl_len = (command.RESPONSE[2] >> 8) & 0x0F;
        LDR      R0,[SP, #+28]
        UBFX     R2,R0,#+8,#+4
// 1048     c_size = command.RESPONSE[2] & 0x03;
        LDRB     R0,[SP, #+28]
        ANDS     R0,R0,#0x3
// 1049     c_size = (c_size << 10) | (command.RESPONSE[1] >> 22);
        LDR      R1,[SP, #+24]
        LSRS     R1,R1,#+22
        ORRS     R0,R1,R0, LSL #+10
// 1050     c_size_mult = (command.RESPONSE[1] >> 7) & 0x07;
        LDR      R1,[SP, #+24]
        UBFX     R1,R1,#+7,#+3
// 1051     sdcard_ptr->NUM_BLOCKS = (c_size + 1) * (1 << (c_size_mult + 2)) * (1 << (read_bl_len - 9));
        ADDS     R0,R0,#+1
        MOVS     R3,#+1
        ADDS     R1,R1,#+2
        LSLS     R1,R3,R1
        MULS     R0,R1,R0
        MOVS     R1,#+1
        SUBS     R2,R2,#+9
        LSLS     R1,R1,R2
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+4]
        B.N      ??LPLD_SDHC_InitCard_15
// 1052   }
// 1053   else
// 1054   {
// 1055     sdcard_ptr->VERSION2 = TRUE;
??LPLD_SDHC_InitCard_14:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STRB     R0,[R1, #+9]
// 1056     c_size = (command.RESPONSE[1] >> 8) & 0x003FFFFF;
        LDR      R0,[SP, #+24]
        UBFX     R0,R0,#+8,#+22
// 1057     sdcard_ptr->NUM_BLOCKS = (c_size + 1) << 10;
        ADDS     R0,R0,#+1
        LSLS     R0,R0,#+10
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+4]
// 1058   }
// 1059   
// 1060   //设置正常工作波特率为40MHz
// 1061   //param = 40000000;    
// 1062   param = 25000000;      
??LPLD_SDHC_InitCard_15:
        LDR.N    R0,??DataTable11_12  ;; 0x17d7840
        STR      R0,[SP, #+0]
// 1063   if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SET_BAUDRATE, &param)))
        ADD      R1,SP,#+0
        MOVS     R0,#+5
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1064   {
// 1065     return result;
// 1066   }
// 1067   
// 1068   //选择卡
// 1069   command.COMMAND = ESDHC_CMD7;
??LPLD_SDHC_InitCard_16:
        LDR.N    R0,??DataTable11_17  ;; 0x71b0000
        STR      R0,[SP, #+4]
// 1070   command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1071   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1072   if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1073   {
// 1074     return result;
// 1075   }
// 1076   
// 1077   //设置块大小为512字节
// 1078   command.COMMAND = ESDHC_CMD16;
??LPLD_SDHC_InitCard_17:
        LDR.N    R0,??DataTable11_18  ;; 0x101a0000
        STR      R0,[SP, #+4]
// 1079   command.ARGUMENT = IO_SDCARD_BLOCK_SIZE;
        MOV      R0,#+512
        STR      R0,[SP, #+8]
// 1080   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1081   if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1082   {
// 1083     return result;
// 1084   }
// 1085   
// 1086   if (ESDHC_BUS_WIDTH_4BIT == ESDHC_BUS_WIDTH_4BIT)
// 1087   {
// 1088     //特殊应用命令
// 1089     command.COMMAND = ESDHC_CMD55;
??LPLD_SDHC_InitCard_18:
        LDR.N    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+4]
// 1090     command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1091     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1092     if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1093     {
// 1094       return result;
// 1095     }
// 1096     
// 1097     //设置总线宽度为4bit
// 1098     command.COMMAND = ESDHC_ACMD6;
??LPLD_SDHC_InitCard_19:
        LDR.N    R0,??DataTable11_19  ;; 0x61a0000
        STR      R0,[SP, #+4]
// 1099     command.ARGUMENT = 2;
        MOVS     R0,#+2
        STR      R0,[SP, #+8]
// 1100     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1101     if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1102     {
// 1103       return result;
// 1104     }
// 1105     
// 1106     param = ESDHC_BUS_WIDTH_4BIT;
??LPLD_SDHC_InitCard_20:
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
// 1107     if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SET_BUS_WIDTH, &param)))
        ADD      R1,SP,#+0
        MOVS     R0,#+7
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1108     {
// 1109       return result;
// 1110     }
// 1111   }
// 1112   
// 1113   return SDHCRES_OK;
??LPLD_SDHC_InitCard_21:
        MOVS     R0,#+0
??LPLD_SDHC_InitCard_9:
        ADD      SP,SP,#+40
        POP      {R4,PC}          ;; return
// 1114 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0x1008000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0x400b10c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x400b1004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0x10002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     0x400b1044
// 1115 
// 1116 
// 1117 /*
// 1118  * LPLD_SDHC_ReadBlocks
// 1119  * 读指定扇区指定长度的块
// 1120  * 
// 1121  * 参数:
// 1122  *    buff--存储读出数据的地址指针
// 1123  *    sector--开始的扇区号
// 1124  *    count--读出的扇区数（块数）
// 1125  *
// 1126  * 输出:
// 1127  *    SDHCRES--磁盘功能返回值
// 1128  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1129 SDHCRES LPLD_SDHC_ReadBlocks(uint8 *buff, uint32 sector, uint32 count)
// 1130 {
LPLD_SDHC_ReadBlocks:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+32
        MOVS     R4,R0
        MOVS     R5,R2
// 1131   ESDHC_COMMAND_STRUCT command;
// 1132   int cnt;
// 1133   int32 result;
// 1134   
// 1135   //SD卡数据地址调节
// 1136   if (! sdcard_ptr->HC)
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+8]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_ReadBlocks_0
// 1137   {
// 1138     sector <<= IO_SDCARD_BLOCK_SIZE_POWER;
        LSLS     R1,R1,#+9
// 1139   }
// 1140   
// 1141   //设置读块命令
// 1142   if (count > 1)
??LPLD_SDHC_ReadBlocks_0:
        CMP      R5,#+2
        BCC.N    ??LPLD_SDHC_ReadBlocks_1
// 1143   {
// 1144     command.COMMAND = ESDHC_CMD18;
        LDR.N    R0,??DataTable11_20  ;; 0x121a0034
        STR      R0,[SP, #+0]
        B.N      ??LPLD_SDHC_ReadBlocks_2
// 1145   }   
// 1146   else
// 1147   {
// 1148     command.COMMAND = ESDHC_CMD17;
??LPLD_SDHC_ReadBlocks_1:
        LDR.N    R0,??DataTable11_21  ;; 0x111a0010
        STR      R0,[SP, #+0]
// 1149   }
// 1150   
// 1151   command.ARGUMENT = sector;
??LPLD_SDHC_ReadBlocks_2:
        STR      R1,[SP, #+4]
// 1152   command.BLOCKS = count;
        STR      R5,[SP, #+8]
// 1153   command.BLOCKSIZE = IO_SDCARD_BLOCK_SIZE;
        MOV      R0,#+512
        STR      R0,[SP, #+12]
// 1154   if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+0
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_ReadBlocks_3
// 1155   {
// 1156     return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_ReadBlocks_4
// 1157   }
// 1158   
// 1159   //读取数据
// 1160   for (cnt = 0; cnt < count; cnt++)
??LPLD_SDHC_ReadBlocks_3:
        MOVS     R6,#+0
        B.N      ??LPLD_SDHC_ReadBlocks_5
// 1161   {
// 1162     if (IO_SDCARD_BLOCK_SIZE != (result=LPLD_SDHC_Read(buff,IO_SDCARD_BLOCK_SIZE)))
// 1163     {
// 1164       return (SDHCRES)result;
// 1165     }
// 1166     buff += IO_SDCARD_BLOCK_SIZE;
??LPLD_SDHC_ReadBlocks_6:
        ADDS     R4,R4,#+512
        ADDS     R6,R6,#+1
??LPLD_SDHC_ReadBlocks_5:
        CMP      R6,R5
        BCS.N    ??LPLD_SDHC_ReadBlocks_7
        MOV      R1,#+512
        MOVS     R0,R4
        BL       LPLD_SDHC_Read
        CMP      R0,#+512
        BEQ.N    ??LPLD_SDHC_ReadBlocks_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_ReadBlocks_4
// 1167   }
// 1168   
// 1169   //等待传输结束
// 1170   if (SDHCRES_OK !=(result=LPLD_SDHC_IOC (IO_IOCTL_FLUSH_OUTPUT, NULL)))
??LPLD_SDHC_ReadBlocks_7:
        MOVS     R1,#+0
        MOVS     R0,#+147
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_ReadBlocks_8
// 1171   {
// 1172     return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_ReadBlocks_4
// 1173   }
// 1174   
// 1175   return (SDHCRES)result;
??LPLD_SDHC_ReadBlocks_8:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??LPLD_SDHC_ReadBlocks_4:
        ADD      SP,SP,#+32
        POP      {R4-R6,PC}       ;; return
// 1176 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     0x400b1030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     sdcard_ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     0x400b1028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     0x7f00b3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     0x400b1034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     0x400b1008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     0x400b1000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     0x400b100c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_8:
        DC32     0xe0001
// 1177 
// 1178 
// 1179 /*
// 1180  * LPLD_SDHC_WriteBlocks
// 1181  * 在指定扇区写入指定长度块数数据
// 1182  * 
// 1183  * 参数:
// 1184  *    buff--存储待写入数据的地址指针
// 1185  *    sector--开始的扇区号
// 1186  *    count--写入的扇区数（块数）
// 1187  *
// 1188  * 输出:
// 1189  *    SDHCRES--磁盘功能返回值
// 1190  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1191 SDHCRES LPLD_SDHC_WriteBlocks(uint8* buff, uint32 sector, uint32 count)
// 1192 {
LPLD_SDHC_WriteBlocks:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+40
        MOVS     R6,R0
        MOVS     R5,R2
// 1193     ESDHC_COMMAND_STRUCT command;
// 1194     uint8               tmp[4];
// 1195     int32             cnt;
// 1196       int32 result;
// 1197     
// 1198  
// 1199     //SD卡数据地址调节
// 1200     if (! sdcard_ptr->HC)
        LDR.N    R0,??DataTable11_22
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+8]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_WriteBlocks_0
// 1201     {
// 1202         sector <<= IO_SDCARD_BLOCK_SIZE_POWER;
        LSLS     R1,R1,#+9
// 1203     }
// 1204 
// 1205     //设置写块命令
// 1206     if (count > 1)
??LPLD_SDHC_WriteBlocks_0:
        CMP      R5,#+2
        BCC.N    ??LPLD_SDHC_WriteBlocks_1
// 1207     {
// 1208         command.COMMAND = ESDHC_CMD25;
        LDR.N    R0,??DataTable11_23  ;; 0x191a0024
        STR      R0,[SP, #+4]
        B.N      ??LPLD_SDHC_WriteBlocks_2
// 1209     }
// 1210     else
// 1211     {
// 1212         command.COMMAND = ESDHC_CMD24;
??LPLD_SDHC_WriteBlocks_1:
        LDR.N    R0,??DataTable11_24  ;; 0x181a0000
        STR      R0,[SP, #+4]
// 1213     }
// 1214 
// 1215     command.ARGUMENT = sector;
??LPLD_SDHC_WriteBlocks_2:
        STR      R1,[SP, #+8]
// 1216     command.BLOCKS = count;
        STR      R5,[SP, #+12]
// 1217     command.BLOCKSIZE = IO_SDCARD_BLOCK_SIZE;
        MOV      R0,#+512
        STR      R0,[SP, #+16]
// 1218     if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_3
// 1219     {
// 1220         return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1221     }
// 1222     
// 1223     //写数据
// 1224     for (cnt = 0; cnt < count; cnt++)
??LPLD_SDHC_WriteBlocks_3:
        MOVS     R4,#+0
        B.N      ??LPLD_SDHC_WriteBlocks_5
// 1225     {
// 1226         if (IO_SDCARD_BLOCK_SIZE != (result=LPLD_SDHC_Write (buff, IO_SDCARD_BLOCK_SIZE)))
// 1227         {
// 1228             return (SDHCRES)result;
// 1229         }
// 1230         buff += IO_SDCARD_BLOCK_SIZE;
??LPLD_SDHC_WriteBlocks_6:
        ADDS     R6,R6,#+512
        ADDS     R4,R4,#+1
??LPLD_SDHC_WriteBlocks_5:
        CMP      R4,R5
        BCS.N    ??LPLD_SDHC_WriteBlocks_7
        MOV      R1,#+512
        MOVS     R0,R6
        BL       LPLD_SDHC_Write
        CMP      R0,#+512
        BEQ.N    ??LPLD_SDHC_WriteBlocks_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1231     }
// 1232 
// 1233     //等待传输结束
// 1234     if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_FLUSH_OUTPUT, NULL)))
??LPLD_SDHC_WriteBlocks_7:
        MOVS     R1,#+0
        MOVS     R0,#+147
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_8
// 1235     {
// 1236         return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1237     }
// 1238 
// 1239     //等待卡准备好/传输状态
// 1240     do
// 1241     {
// 1242         command.COMMAND = ESDHC_CMD13;
??LPLD_SDHC_WriteBlocks_8:
        LDR.N    R0,??DataTable11_25  ;; 0xd1a0000
        STR      R0,[SP, #+4]
// 1243         command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable11_22
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1244         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1245         if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_9
// 1246         {
// 1247             return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1248         }
// 1249 
// 1250         //卡状态错误检查
// 1251         if (command.RESPONSE[0] & 0xFFD98008)
??LPLD_SDHC_WriteBlocks_9:
        LDR      R0,[SP, #+20]
        LDR.N    R1,??DataTable11_26  ;; 0xffd98008
        TST      R0,R1
        BEQ.N    ??LPLD_SDHC_WriteBlocks_10
// 1252         {
// 1253             count = 0; /* necessary to get real number of written blocks */
        MOVS     R5,#+0
// 1254             break;
        B.N      ??LPLD_SDHC_WriteBlocks_11
// 1255         }
// 1256 
// 1257     } while (0x000000900 != (command.RESPONSE[0] & 0x00001F00));
??LPLD_SDHC_WriteBlocks_10:
        LDR      R0,[SP, #+20]
        ANDS     R0,R0,#0x1F00
        CMP      R0,#+2304
        BNE.N    ??LPLD_SDHC_WriteBlocks_8
// 1258 
// 1259     if (cnt != count)
??LPLD_SDHC_WriteBlocks_11:
        CMP      R4,R5
        BEQ.N    ??LPLD_SDHC_WriteBlocks_12
// 1260     {
// 1261         //特殊应用命令
// 1262         command.COMMAND = ESDHC_CMD55;
        LDR.N    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+4]
// 1263         command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable11_22
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1264         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1265         if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_13
// 1266         {
// 1267             return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1268         }
// 1269                 
// 1270         //使用ACMD22命令获得写入的块数量
// 1271         command.COMMAND = ESDHC_ACMD22;
??LPLD_SDHC_WriteBlocks_13:
        LDR.N    R0,??DataTable11_27  ;; 0x161a0010
        STR      R0,[SP, #+4]
// 1272         command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
// 1273         command.BLOCKS = 1;
        MOVS     R0,#+1
        STR      R0,[SP, #+12]
// 1274         command.BLOCKSIZE = 4;
        MOVS     R0,#+4
        STR      R0,[SP, #+16]
// 1275         if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_14
// 1276         {
// 1277             return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1278         }
// 1279         
// 1280         if (4 != (result=LPLD_SDHC_Read (tmp, 4)))
??LPLD_SDHC_WriteBlocks_14:
        MOVS     R1,#+4
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_Read
        CMP      R0,#+4
        BEQ.N    ??LPLD_SDHC_WriteBlocks_15
// 1281         {
// 1282             return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1283             
// 1284         }
// 1285 
// 1286         if (SDHCRES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_FLUSH_OUTPUT, NULL)))
??LPLD_SDHC_WriteBlocks_15:
        MOVS     R1,#+0
        MOVS     R0,#+147
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_16
// 1287         {
// 1288             return (SDHCRES)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1289         }
// 1290 
// 1291         count = (tmp[0] << 24) | (tmp[1] << 16) | (tmp[2] << 8) | tmp[3];
??LPLD_SDHC_WriteBlocks_16:
        LDRB     R0,[SP, #+0]
        LDRB     R1,[SP, #+1]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[SP, #+2]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[SP, #+3]
        ORRS     R5,R1,R0
// 1292         if ((cnt < 0) || (cnt > count))
        CMP      R4,#+0
        BMI.N    ??LPLD_SDHC_WriteBlocks_17
        CMP      R5,R4
        BCS.N    ??LPLD_SDHC_WriteBlocks_12
// 1293             return SDHCRES_ERROR;
??LPLD_SDHC_WriteBlocks_17:
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1294     }
// 1295     
// 1296     return SDHCRES_OK;
??LPLD_SDHC_WriteBlocks_12:
        MOVS     R0,#+0
??LPLD_SDHC_WriteBlocks_4:
        ADD      SP,SP,#+40
        POP      {R4-R6,PC}       ;; return
// 1297 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     0x400b1010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_1:
        DC32     0x400b1014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_2:
        DC32     0x400b1018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_3:
        DC32     0x400b101c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_4:
        DC32     0x61a80

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_5:
        DC32     g_core_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_6:
        DC32     0x81a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_7:
        DC32     0x5020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_8:
        DC32     0x371a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_9:
        DC32     0x40300000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_10:
        DC32     0x27020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_11:
        DC32     0x29020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_12:
        DC32     0x17d7840

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_13:
        DC32     0x400b1020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_14:
        DC32     0x2090000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_15:
        DC32     0x31a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_16:
        DC32     0x9090000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_17:
        DC32     0x71b0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_18:
        DC32     0x101a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_19:
        DC32     0x61a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_20:
        DC32     0x121a0034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_21:
        DC32     0x111a0010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_22:
        DC32     sdcard_ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_23:
        DC32     0x191a0024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_24:
        DC32     0x181a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_25:
        DC32     0xd1a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_26:
        DC32     0xffd98008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_27:
        DC32     0x161a0010

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
//     4 bytes in section .bss
// 3 958 bytes in section .text
// 
// 3 958 bytes of CODE memory
//     4 bytes of DATA memory
//
//Errors: none
//Warnings: none
