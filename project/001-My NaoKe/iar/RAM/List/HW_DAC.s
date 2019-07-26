///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:13:55
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_DAC.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_DAC.c -D LPLD_K60 -lCN
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\" -lB
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\" -o
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\Obj\" --no_cse
//        --no_unroll --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "D:\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\app\" -I "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\CPU\" -I "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\common\" -I
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\..\..\..\lib\LPLD\"
//        -I "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\LPLD\HW\" -I
//        "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\LPLD\DEV\" -I
//        "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\uCOS-II\Ports\" -I
//        "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\uCOS-II\Source\" -I
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\..\..\..\lib\FatFs\"
//        -I "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\FatFs\option\" -I
//        "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\USB\common\" -I
//        "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\USB\driver\" -I
//        "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\USB\descriptor\" -I
//        "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\USB\class\" -Ol -I "D:\Embedded
//        Workbench 7.0\arm\CMSIS\Include\" -D ARM_MATH_CM4
//    List file    =  
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\HW_DAC.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC DAC0_IRQHandler
        PUBLIC DAC1_IRQHandler
        PUBLIC DAC_RDPTBOT_ISR
        PUBLIC DAC_RDPTTOP_ISR
        PUBLIC DAC_WATERMK_ISR
        PUBLIC LPLD_DAC_Deinit
        PUBLIC LPLD_DAC_DisableIrq
        PUBLIC LPLD_DAC_EnableIrq
        PUBLIC LPLD_DAC_Init
        PUBLIC LPLD_DAC_SetBufferData
        PUBLIC LPLD_DAC_SetBufferDataN
        PUBLIC LPLD_DAC_SoftwareTrigger

// D:\2019.IAR\lib\LPLD\HW\HW_DAC.c
//    1 /**
//    2  * @file HW_DAC.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief DAC底层模块相关函数
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
        LDR.W    R2,??DataTable9  ;; 0xe000e100
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
        LDR.W    R2,??DataTable9_1  ;; 0xe000e180
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return
//   23 #include "HW_DAC.h"
//   24 
//   25 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   26 DAC_ISR_CALLBACK DAC_RDPTBOT_ISR[2];
DAC_RDPTBOT_ISR:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 DAC_ISR_CALLBACK DAC_RDPTTOP_ISR[2];
DAC_RDPTTOP_ISR:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   28 DAC_ISR_CALLBACK DAC_WATERMK_ISR[2];
DAC_WATERMK_ISR:
        DS8 8
//   29 
//   30 
//   31 /*
//   32  * LPLD_DAC_Init
//   33  * DAC初始化函数，使能DAC各项功能
//   34  * 
//   35  * 参数:
//   36  *    dac_init_struct--DAC初始化结构体，
//   37  *                        具体定义见DAC_InitTypeDef
//   38  *
//   39  * 输出:
//   40  *    0--配置错误
//   41  *    1--配置成功
//   42  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   43 uint8 LPLD_DAC_Init(DAC_InitTypeDef dac_init_struct)
//   44 {
LPLD_DAC_Init:
        PUSH     {R0-R3}
        PUSH     {R4-R10,LR}
//   45   uint8 x;
//   46   DAC_Type *dacx = dac_init_struct.DAC_Dacx;
        LDR      R4,[SP, #+32]
//   47   uint8 work_mode = dac_init_struct.DAC_BufferWorkMode;
        LDRB     R5,[SP, #+37]
//   48   uint8 watermark = dac_init_struct.DAC_BufferWatermarkSel;
        LDRB     R6,[SP, #+38]
//   49   uint8 upper = dac_init_struct.DAC_BufferUpperLimit;
        LDRB     R10,[SP, #+40]
//   50   DAC_ISR_CALLBACK rdptbot_isr = dac_init_struct.DAC_ReadPointerBottomIsr;
        LDR      R7,[SP, #+48]
//   51   DAC_ISR_CALLBACK rdpttop_isr = dac_init_struct.DAC_ReadPointerTopIsr;
        LDR      R8,[SP, #+52]
//   52   DAC_ISR_CALLBACK watermk_isr = dac_init_struct.DAC_BufferWatermarkIsr;
        LDR      R9,[SP, #+56]
//   53   
//   54   upper = (upper==NULL?1:upper);
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BNE.N    ??LPLD_DAC_Init_0
        MOVS     R10,#+1
        B.N      ??LPLD_DAC_Init_1
//   55     
//   56   //参数检查
//   57   ASSERT( work_mode <= BUFFER_MODE_ONETIMESCAN );  //判断模式选择
??LPLD_DAC_Init_0:
??LPLD_DAC_Init_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BLT.N    ??LPLD_DAC_Init_2
        MOVS     R1,#+57
        LDR.W    R0,??DataTable9_2
        BL       assert_failed
//   58   ASSERT( watermark <= WATERMARK_4WORDS );      //判断缓冲区水印选择
??LPLD_DAC_Init_2:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BLT.N    ??LPLD_DAC_Init_3
        MOVS     R1,#+58
        LDR.W    R0,??DataTable9_2
        BL       assert_failed
//   59   ASSERT( upper <= 16);         //判断缓冲区上限数值
??LPLD_DAC_Init_3:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+17
        BLT.N    ??LPLD_DAC_Init_4
        MOVS     R1,#+59
        LDR.W    R0,??DataTable9_2
        BL       assert_failed
//   60     
//   61   //配置DAC时钟
//   62   if(dacx == DAC0)
??LPLD_DAC_Init_4:
        LDR.W    R0,??DataTable9_3  ;; 0x400cc000
        CMP      R4,R0
        BNE.W    ??LPLD_DAC_Init_5
//   63   {
//   64     x = 0;
        MOVS     R0,#+0
//   65     SIM->SCGC2 |= SIM_SCGC2_DAC0_MASK;   //开启DAC0时钟
        LDR.W    R1,??DataTable9_4  ;; 0x4004802c
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x1000
        LDR.W    R2,??DataTable9_4  ;; 0x4004802c
        STR      R1,[R2, #+0]
//   66   }
//   67   else if(dacx == DAC1)
//   68   {
//   69     x = 1;
//   70     SIM->SCGC2 |= SIM_SCGC2_DAC1_MASK;   //开启DAC1时钟
//   71   }
//   72   else 
//   73   {
//   74     return 0;
//   75   }
//   76   
//   77   //配置C2寄存器
//   78   dacx->C2 = DAC_C2_DACBFUP(upper - 1);     //配置缓冲区上限数值
??LPLD_DAC_Init_6:
        SUBS     R1,R10,#+1
        ANDS     R1,R1,#0xF
        STRB     R1,[R4, #+35]
//   79   
//   80   //配置C1寄存器
//   81   dacx->C1 = 0;
        MOVS     R1,#+0
        STRB     R1,[R4, #+34]
//   82   if(dac_init_struct.DAC_BufferEnable == TRUE)
        LDRB     R1,[SP, #+36]
        CMP      R1,#+1
        BNE.N    ??LPLD_DAC_Init_7
//   83   {
//   84     dacx->C1 |= DAC_C1_DACBFEN_MASK;    //使能缓冲区 
        LDRB     R1,[R4, #+34]
        ORRS     R1,R1,#0x1
        STRB     R1,[R4, #+34]
//   85   }
//   86   dacx->C1 |= DAC_C1_DACBFMD(work_mode);        //缓冲区工作模式配置
??LPLD_DAC_Init_7:
        LDRB     R1,[R4, #+34]
        LSLS     R2,R5,#+1
        ANDS     R2,R2,#0x6
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+34]
//   87   dacx->C1 |= DAC_C1_DACBFWM(watermark);        //缓冲区水印选择配置
        LDRB     R1,[R4, #+34]
        LSLS     R2,R6,#+3
        ANDS     R2,R2,#0x18
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+34]
//   88   if(dac_init_struct.DAC_DmaEnable == TRUE)
        LDRB     R1,[SP, #+39]
        CMP      R1,#+1
        BNE.N    ??LPLD_DAC_Init_8
//   89   {
//   90     dacx->C1 |= DAC_C1_DMAEN_MASK;      //使能DMA
        LDRB     R1,[R4, #+34]
        ORRS     R1,R1,#0x80
        STRB     R1,[R4, #+34]
//   91   }
//   92   
//   93   //配置C0寄存器
//   94   dacx->C0 = 0;
??LPLD_DAC_Init_8:
        MOVS     R1,#+0
        STRB     R1,[R4, #+33]
//   95   if(dac_init_struct.DAC_ReadPointerBottomIntEnable == TRUE && rdptbot_isr != NULL)
        LDRB     R1,[SP, #+42]
        CMP      R1,#+1
        BNE.N    ??LPLD_DAC_Init_9
        MOVS     R1,R7
        CMP      R1,#+0
        BEQ.N    ??LPLD_DAC_Init_9
//   96   {
//   97     dacx->C0 |= DAC_C0_DACBBIEN_MASK;   //使能缓冲区底部中断
        LDRB     R1,[R4, #+33]
        ORRS     R1,R1,#0x1
        STRB     R1,[R4, #+33]
//   98     DAC_RDPTBOT_ISR[x] = rdptbot_isr;
        LDR.N    R1,??DataTable9_5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R7,[R1, R0, LSL #+2]
//   99   }
//  100   if(dac_init_struct.DAC_ReadPointerTopIntEnable == TRUE && rdpttop_isr != NULL)
??LPLD_DAC_Init_9:
        LDRB     R1,[SP, #+43]
        CMP      R1,#+1
        BNE.N    ??LPLD_DAC_Init_10
        MOV      R1,R8
        CMP      R1,#+0
        BEQ.N    ??LPLD_DAC_Init_10
//  101   {
//  102     dacx->C0 |= DAC_C0_DACBTIEN_MASK;   //使能缓冲区顶部中断
        LDRB     R1,[R4, #+33]
        ORRS     R1,R1,#0x2
        STRB     R1,[R4, #+33]
//  103     DAC_RDPTTOP_ISR[x] = rdpttop_isr;
        LDR.N    R1,??DataTable9_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R8,[R1, R0, LSL #+2]
//  104   }
//  105   if(dac_init_struct.DAC_BufferWatermarkIntEnable == TRUE && watermk_isr != NULL)
??LPLD_DAC_Init_10:
        LDRB     R1,[SP, #+44]
        CMP      R1,#+1
        BNE.N    ??LPLD_DAC_Init_11
        MOV      R1,R9
        CMP      R1,#+0
        BEQ.N    ??LPLD_DAC_Init_11
//  106   {
//  107     dacx->C0 |= DAC_C0_DACBWIEN_MASK;   //使能缓冲区水印中断
        LDRB     R1,[R4, #+33]
        ORRS     R1,R1,#0x4
        STRB     R1,[R4, #+33]
//  108     DAC_WATERMK_ISR[x] = watermk_isr;
        LDR.N    R1,??DataTable9_7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R9,[R1, R0, LSL #+2]
//  109   }
//  110   if(dac_init_struct.DAC_SoftTrgEnable == TRUE)
??LPLD_DAC_Init_11:
        LDRB     R0,[SP, #+41]
        CMP      R0,#+1
        BNE.N    ??LPLD_DAC_Init_12
//  111   {
//  112     dacx->C0 |= DAC_C0_DACTRGSEL_MASK;  //使能软件触发缓冲区
        LDRB     R0,[R4, #+33]
        ORRS     R0,R0,#0x20
        STRB     R0,[R4, #+33]
//  113   }
//  114   dacx->C0 |= DAC_C0_DACRFS_MASK;       //使能DACREF_2(VDDA)为参考电压
??LPLD_DAC_Init_12:
        LDRB     R0,[R4, #+33]
        ORRS     R0,R0,#0x40
        STRB     R0,[R4, #+33]
//  115   
//  116   //使能DAC模块，可编程参考发生器开始工作
//  117   dacx->C0 |= DAC_C0_DACEN_MASK;
        LDRB     R0,[R4, #+33]
        ORRS     R0,R0,#0x80
        STRB     R0,[R4, #+33]
//  118   
//  119   return 1;
        MOVS     R0,#+1
??LPLD_DAC_Init_13:
        POP      {R4-R10}
        LDR      PC,[SP], #+20    ;; return
??LPLD_DAC_Init_5:
        LDR.N    R0,??DataTable9_8  ;; 0x400cd000
        CMP      R4,R0
        BNE.N    ??LPLD_DAC_Init_14
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_4  ;; 0x4004802c
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x2000
        LDR.N    R2,??DataTable9_4  ;; 0x4004802c
        STR      R1,[R2, #+0]
        B.N      ??LPLD_DAC_Init_6
??LPLD_DAC_Init_14:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Init_13
//  120 }
//  121 
//  122 /*
//  123  * LPLD_DAC_Deinit
//  124  * DAC反初始化函数，禁用DAC模块
//  125  * 
//  126  * 参数:
//  127  *    dac_init_struct--DAC初始化结构体，
//  128  *                        具体定义见DAC_InitTypeDef
//  129  *
//  130  * 输出:
//  131  *    0--配置错误
//  132  *    1--配置成功
//  133  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 uint8 LPLD_DAC_Deinit(DAC_InitTypeDef dac_init_struct)
//  135 {
LPLD_DAC_Deinit:
        PUSH     {R0-R3}
        PUSH     {R7,LR}
//  136   uint8 x;
//  137   DAC_Type *dacx = dac_init_struct.DAC_Dacx;
        LDR      R0,[SP, #+8]
//  138 
//  139   //关闭DAC模块
//  140   dacx->C0 &= ~(DAC_C0_DACEN_MASK);
        LDRB     R1,[R0, #+33]
        ANDS     R1,R1,#0x7F
        STRB     R1,[R0, #+33]
//  141   
//  142   //关闭DAC时钟
//  143   if(dacx == DAC0)
        LDR.N    R1,??DataTable9_3  ;; 0x400cc000
        CMP      R0,R1
        BNE.N    ??LPLD_DAC_Deinit_0
//  144   {
//  145     x = 0;
        MOVS     R0,#+0
//  146     SIM->SCGC2 &= ~(SIM_SCGC2_DAC0_MASK);   
        LDR.N    R1,??DataTable9_4  ;; 0x4004802c
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x1000
        LDR.N    R2,??DataTable9_4  ;; 0x4004802c
        STR      R1,[R2, #+0]
//  147   }
//  148   else if(dacx == DAC1)
//  149   {
//  150     x = 1;
//  151     SIM->SCGC2 &= ~(SIM_SCGC2_DAC1_MASK);   
//  152   }
//  153   else 
//  154   {
//  155     return 0;
//  156   }
//  157 
//  158   disable_irq((IRQn_Type)(DAC0_IRQn + x));
??LPLD_DAC_Deinit_1:
        ADDS     R0,R0,#+81
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_DisableIRQ
//  159   
//  160   return 1;
        MOVS     R0,#+1
??LPLD_DAC_Deinit_2:
        POP      {R1}
        LDR      PC,[SP], #+20    ;; return
??LPLD_DAC_Deinit_0:
        LDR.N    R1,??DataTable9_8  ;; 0x400cd000
        CMP      R0,R1
        BNE.N    ??LPLD_DAC_Deinit_3
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_4  ;; 0x4004802c
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x2000
        LDR.N    R2,??DataTable9_4  ;; 0x4004802c
        STR      R1,[R2, #+0]
        B.N      ??LPLD_DAC_Deinit_1
??LPLD_DAC_Deinit_3:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Deinit_2
//  161 }
//  162 
//  163 /*
//  164  * LPLD_DAC_EnableIrq
//  165  * 使能DACx中断
//  166  * 
//  167  * 参数:
//  168  *    dac_init_struct--DAC初始化结构体，
//  169  *                        具体定义见DAC_InitTypeDef
//  170  *
//  171  * 输出:
//  172  *    0--配置错误
//  173  *    1--配置成功
//  174  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  175 uint8 LPLD_DAC_EnableIrq(DAC_InitTypeDef dac_init_struct)
//  176 {
LPLD_DAC_EnableIrq:
        PUSH     {R0-R3}
        PUSH     {R7,LR}
//  177   uint8 x;
//  178   DAC_Type *dacx = dac_init_struct.DAC_Dacx;
        LDR      R0,[SP, #+8]
//  179   
//  180   if(dacx == DAC0)
        LDR.N    R1,??DataTable9_3  ;; 0x400cc000
        CMP      R0,R1
        BNE.N    ??LPLD_DAC_EnableIrq_0
//  181     x = 0;
        MOVS     R0,#+0
//  182   else if(dacx == DAC1)
//  183     x = 1;
//  184   else
//  185     return 0;
//  186 
//  187   enable_irq((IRQn_Type)(DAC0_IRQn + x));
??LPLD_DAC_EnableIrq_1:
        ADDS     R0,R0,#+81
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_EnableIRQ
//  188   
//  189   return 1;
        MOVS     R0,#+1
??LPLD_DAC_EnableIrq_2:
        POP      {R1}
        LDR      PC,[SP], #+20    ;; return
??LPLD_DAC_EnableIrq_0:
        LDR.N    R1,??DataTable9_8  ;; 0x400cd000
        CMP      R0,R1
        BNE.N    ??LPLD_DAC_EnableIrq_3
        MOVS     R0,#+1
        B.N      ??LPLD_DAC_EnableIrq_1
??LPLD_DAC_EnableIrq_3:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_EnableIrq_2
//  190 }
//  191 
//  192 /*
//  193  * LPLD_DAC_DisableIrq
//  194  * 禁用DACx中断
//  195  * 
//  196  * 参数:
//  197  *    dac_init_struct--DAC初始化结构体，
//  198  *                        具体定义见DAC_InitTypeDef
//  199  *
//  200  * 输出:
//  201  *    0--配置错误
//  202  *    1--配置成功
//  203  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  204 uint8 LPLD_DAC_DisableIrq(DAC_InitTypeDef dac_init_struct)
//  205 {
LPLD_DAC_DisableIrq:
        PUSH     {R0-R3}
        PUSH     {R7,LR}
//  206   uint8 x;
//  207   DAC_Type *dacx = dac_init_struct.DAC_Dacx;
        LDR      R0,[SP, #+8]
//  208   
//  209   if(dacx == DAC0)
        LDR.N    R1,??DataTable9_3  ;; 0x400cc000
        CMP      R0,R1
        BNE.N    ??LPLD_DAC_DisableIrq_0
//  210     x = 0;
        MOVS     R0,#+0
//  211   else if(dacx == DAC1)
//  212     x = 1;
//  213   else
//  214     return 0;
//  215 
//  216   disable_irq((IRQn_Type)(DAC0_IRQn + x));
??LPLD_DAC_DisableIrq_1:
        ADDS     R0,R0,#+81
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_DisableIRQ
//  217   
//  218   return 1;
        MOVS     R0,#+1
??LPLD_DAC_DisableIrq_2:
        POP      {R1}
        LDR      PC,[SP], #+20    ;; return
??LPLD_DAC_DisableIrq_0:
        LDR.N    R1,??DataTable9_8  ;; 0x400cd000
        CMP      R0,R1
        BNE.N    ??LPLD_DAC_DisableIrq_3
        MOVS     R0,#+1
        B.N      ??LPLD_DAC_DisableIrq_1
??LPLD_DAC_DisableIrq_3:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_DisableIrq_2
//  219 }
//  220 
//  221 /*
//  222  * LPLD_DAC_SetBufferDataN
//  223  * 设置DAC缓存区单个数据n
//  224  * 
//  225  * 参数:
//  226  *    dacx--DACx模块号
//  227  *      |__DAC0          --DAC0
//  228  *      |__DAC1          --DAC1
//  229  *    data--缓冲区输出数据
//  230  *      |__0~4095        --12位数据
//  231  *    num--指定缓冲区位置
//  232  *      |__1~16          --缓冲区第1至16个字
//  233  *
//  234  * 输出:
//  235  *    无
//  236  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  237 void LPLD_DAC_SetBufferDataN(DAC_Type *dacx, uint16 data, uint8 num)
//  238 {
LPLD_DAC_SetBufferDataN:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  239   //参数检查
//  240   ASSERT( (num <= 16)&&(num > 0) );  //判断数据序号
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+17
        BGE.N    ??LPLD_DAC_SetBufferDataN_0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??LPLD_DAC_SetBufferDataN_1
??LPLD_DAC_SetBufferDataN_0:
        MOVS     R1,#+240
        LDR.N    R0,??DataTable9_2
        BL       assert_failed
//  241 
//  242   dacx->DAT[num-1].DATL = data & 0x0FF;
??LPLD_DAC_SetBufferDataN_1:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R0,R4,R6, LSL #+1
        STRB     R5,[R0, #-2]
//  243   dacx->DAT[num-1].DATH = (data & 0xF00)>>8;
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ASRS     R0,R5,#+8
        ANDS     R0,R0,#0xF
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R1,R4,R6, LSL #+1
        STRB     R0,[R1, #-1]
//  244 }
        POP      {R4-R6,PC}       ;; return
//  245 
//  246 /*
//  247  * LPLD_DAC_SetBufferData
//  248  * 设置DAC缓存区所有数据
//  249  * 
//  250  * 参数:
//  251  *    dacx--DACx模块号
//  252  *      |__DAC0          --DAC0
//  253  *      |__DAC1          --DAC1
//  254  *    *data--缓冲区输出数据数组指针
//  255  *      |__*0~4095       --12位数据数组
//  256  *    len--数据数组长度
//  257  *      |__1~16          --长度为1~16
//  258  *
//  259  * 输出:
//  260  *    无
//  261  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  262 void LPLD_DAC_SetBufferData(DAC_Type *dacx, uint16 *data, uint8 len)
//  263 {
LPLD_DAC_SetBufferData:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  264   //参数检查
//  265   ASSERT( (len <= 16)&&(len > 0) );  //判断数据长度
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+17
        BGE.N    ??LPLD_DAC_SetBufferData_0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??LPLD_DAC_SetBufferData_1
??LPLD_DAC_SetBufferData_0:
        MOVW     R1,#+265
        LDR.N    R0,??DataTable9_2
        BL       assert_failed
//  266   
//  267   for(uint8 i=0; i < len; i++)
??LPLD_DAC_SetBufferData_1:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_SetBufferData_2
//  268   {
//  269     dacx->DAT[i].DATL = data[i] & 0x0FF;
??LPLD_DAC_SetBufferData_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRH     R1,[R5, R0, LSL #+1]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRB     R1,[R4, R0, LSL #+1]
//  270     dacx->DAT[i].DATH = (data[i] & 0xF00)>>8;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRH     R1,[R5, R0, LSL #+1]
        ASRS     R1,R1,#+8
        ANDS     R1,R1,#0xF
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R4,R0, LSL #+1
        STRB     R1,[R2, #+1]
//  271   }
        ADDS     R0,R0,#+1
??LPLD_DAC_SetBufferData_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R0,R6
        BCC.N    ??LPLD_DAC_SetBufferData_3
//  272 }
        POP      {R4-R6,PC}       ;; return
//  273 
//  274 /*
//  275  * LPLD_DAC_SoftwareTrigger
//  276  * 软件触发DAC缓冲区工作
//  277  * 
//  278  * 参数:
//  279  *    dacx--DACx模块号
//  280  *      |__DAC0          --DAC0
//  281  *      |__DAC1          --DAC1
//  282  *
//  283  * 输出:
//  284  *    无
//  285  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  286 void LPLD_DAC_SoftwareTrigger(DAC_Type *dacx)
//  287 {
//  288   dacx->C0 |= DAC_C0_DACSWTRG_MASK;
LPLD_DAC_SoftwareTrigger:
        LDRB     R1,[R0, #+33]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+33]
//  289 }
        BX       LR               ;; return
//  290 
//  291 /*
//  292  * DAC0--DAC1中断处理函数
//  293  * 与启动文件startup_K60.s中的中断向量表关联
//  294  * 用户无需修改，程序自动进入对应通道中断函数
//  295  */
//  296 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  297 void DAC0_IRQHandler(void)
//  298 {
DAC0_IRQHandler:
        PUSH     {R7,LR}
//  299 #if (UCOS_II > 0u)
//  300   OS_CPU_SR  cpu_sr = 0u;
//  301   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  302   OSIntEnter();
//  303   OS_EXIT_CRITICAL();
//  304 #endif
//  305   
//  306   //是否为指针底部中断
//  307   if((DAC0->SR & DAC_SR_DACBFRPBF_MASK) && (DAC0->C0 & DAC_C0_DACBBIEN_MASK))
        LDR.N    R0,??DataTable9_9  ;; 0x400cc020
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??DAC0_IRQHandler_0
        LDR.N    R0,??DataTable9_10  ;; 0x400cc021
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??DAC0_IRQHandler_0
//  308   {
//  309     //调用用户自定义中断服务
//  310     DAC_RDPTBOT_ISR[0]();  
        LDR.N    R0,??DataTable9_5
        LDR      R0,[R0, #+0]
        BLX      R0
//  311     DAC0->SR &= ~(DAC_SR_DACBFRPBF_MASK);
        LDR.N    R0,??DataTable9_9  ;; 0x400cc020
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFE
        LDR.N    R1,??DataTable9_9  ;; 0x400cc020
        STRB     R0,[R1, #+0]
//  312   }
//  313   //是否为指针顶部中断
//  314   if((DAC0->SR & DAC_SR_DACBFRPTF_MASK) && (DAC0->C0 & DAC_C0_DACBTIEN_MASK))
??DAC0_IRQHandler_0:
        LDR.N    R0,??DataTable9_9  ;; 0x400cc020
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??DAC0_IRQHandler_1
        LDR.N    R0,??DataTable9_10  ;; 0x400cc021
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??DAC0_IRQHandler_1
//  315   {
//  316     //调用用户自定义中断服务
//  317     DAC_RDPTTOP_ISR[0]();  
        LDR.N    R0,??DataTable9_6
        LDR      R0,[R0, #+0]
        BLX      R0
//  318     DAC0->SR &= ~(DAC_SR_DACBFRPTF_MASK);
        LDR.N    R0,??DataTable9_9  ;; 0x400cc020
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFD
        LDR.N    R1,??DataTable9_9  ;; 0x400cc020
        STRB     R0,[R1, #+0]
//  319   }
//  320   //是否为水印中断
//  321   if((DAC0->SR & DAC_SR_DACBFWMF_MASK) && (DAC0->C0 & DAC_C0_DACBWIEN_MASK))
??DAC0_IRQHandler_1:
        LDR.N    R0,??DataTable9_9  ;; 0x400cc020
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??DAC0_IRQHandler_2
        LDR.N    R0,??DataTable9_10  ;; 0x400cc021
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??DAC0_IRQHandler_2
//  322   {
//  323     //调用用户自定义中断服务
//  324     DAC_WATERMK_ISR[0]();  
        LDR.N    R0,??DataTable9_7
        LDR      R0,[R0, #+0]
        BLX      R0
//  325     DAC0->SR &= ~(DAC_SR_DACBFWMF_MASK);
        LDR.N    R0,??DataTable9_9  ;; 0x400cc020
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFB
        LDR.N    R1,??DataTable9_9  ;; 0x400cc020
        STRB     R0,[R1, #+0]
//  326   }
//  327   
//  328 #if (UCOS_II > 0u)
//  329   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  330 #endif
//  331 }
??DAC0_IRQHandler_2:
        POP      {R0,PC}          ;; return
//  332 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  333 void DAC1_IRQHandler(void)
//  334 {
DAC1_IRQHandler:
        PUSH     {R7,LR}
//  335 #if (UCOS_II > 0u)
//  336   OS_CPU_SR  cpu_sr = 0u;
//  337   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  338   OSIntEnter();
//  339   OS_EXIT_CRITICAL();
//  340 #endif
//  341   
//  342   //是否为指针底部中断
//  343   if((DAC1->SR & DAC_SR_DACBFRPBF_MASK) && (DAC1->C0 & DAC_C0_DACBBIEN_MASK))
        LDR.N    R0,??DataTable9_11  ;; 0x400cd020
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??DAC1_IRQHandler_0
        LDR.N    R0,??DataTable9_12  ;; 0x400cd021
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??DAC1_IRQHandler_0
//  344   {
//  345     //调用用户自定义中断服务
//  346     DAC_RDPTBOT_ISR[1]();  
        LDR.N    R0,??DataTable9_5
        LDR      R0,[R0, #+4]
        BLX      R0
//  347     DAC1->SR &= ~(DAC_SR_DACBFRPBF_MASK);
        LDR.N    R0,??DataTable9_11  ;; 0x400cd020
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFE
        LDR.N    R1,??DataTable9_11  ;; 0x400cd020
        STRB     R0,[R1, #+0]
//  348   }
//  349   //是否为指针顶部中断
//  350   if((DAC1->SR & DAC_SR_DACBFRPTF_MASK) && (DAC1->C0 & DAC_C0_DACBTIEN_MASK))
??DAC1_IRQHandler_0:
        LDR.N    R0,??DataTable9_11  ;; 0x400cd020
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??DAC1_IRQHandler_1
        LDR.N    R0,??DataTable9_12  ;; 0x400cd021
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??DAC1_IRQHandler_1
//  351   {
//  352     //调用用户自定义中断服务
//  353     DAC_RDPTTOP_ISR[1]();  
        LDR.N    R0,??DataTable9_6
        LDR      R0,[R0, #+4]
        BLX      R0
//  354     DAC1->SR &= ~(DAC_SR_DACBFRPTF_MASK);
        LDR.N    R0,??DataTable9_11  ;; 0x400cd020
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFD
        LDR.N    R1,??DataTable9_11  ;; 0x400cd020
        STRB     R0,[R1, #+0]
//  355   }
//  356   //是否为水印中断
//  357   if((DAC1->SR & DAC_SR_DACBFWMF_MASK) && (DAC1->C0 & DAC_C0_DACBWIEN_MASK))
??DAC1_IRQHandler_1:
        LDR.N    R0,??DataTable9_11  ;; 0x400cd020
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??DAC1_IRQHandler_2
        LDR.N    R0,??DataTable9_12  ;; 0x400cd021
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??DAC1_IRQHandler_2
//  358   {
//  359     //调用用户自定义中断服务
//  360     DAC_WATERMK_ISR[1]();  
        LDR.N    R0,??DataTable9_7
        LDR      R0,[R0, #+4]
        BLX      R0
//  361     DAC1->SR &= ~(DAC_SR_DACBFWMF_MASK);
        LDR.N    R0,??DataTable9_11  ;; 0x400cd020
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFB
        LDR.N    R1,??DataTable9_11  ;; 0x400cd020
        STRB     R0,[R1, #+0]
//  362   }
//  363   
//  364 #if (UCOS_II > 0u)
//  365   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  366 #endif
//  367 }
??DAC1_IRQHandler_2:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x400cc000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0x4004802c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     DAC_RDPTBOT_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC32     DAC_RDPTTOP_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC32     DAC_WATERMK_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC32     0x400cd000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_9:
        DC32     0x400cc020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_10:
        DC32     0x400cc021

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_11:
        DC32     0x400cd020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_12:
        DC32     0x400cd021

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
        DC8 "D:\\2019.IAR\\lib\\LPLD\\HW\\HW_DAC.c"
        DC8 0, 0, 0

        END
// 
//    24 bytes in section .bss
//    36 bytes in section .rodata
// 1 030 bytes in section .text
// 
// 1 030 bytes of CODE  memory
//    36 bytes of CONST memory
//    24 bytes of DATA  memory
//
//Errors: none
//Warnings: none
