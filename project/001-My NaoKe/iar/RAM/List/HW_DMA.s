///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:13:55
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_DMA.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_DMA.c -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\HW_DMA.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC DMA0_IRQHandler
        PUBLIC DMA10_IRQHandler
        PUBLIC DMA11_IRQHandler
        PUBLIC DMA12_IRQHandler
        PUBLIC DMA13_IRQHandler
        PUBLIC DMA14_IRQHandler
        PUBLIC DMA15_IRQHandler
        PUBLIC DMA1_IRQHandler
        PUBLIC DMA2_IRQHandler
        PUBLIC DMA3_IRQHandler
        PUBLIC DMA4_IRQHandler
        PUBLIC DMA5_IRQHandler
        PUBLIC DMA6_IRQHandler
        PUBLIC DMA7_IRQHandler
        PUBLIC DMA8_IRQHandler
        PUBLIC DMA9_IRQHandler
        PUBLIC DMA_ISR
        PUBLIC LPLD_DMA_DisableIrq
        PUBLIC LPLD_DMA_EnableIrq
        PUBLIC LPLD_DMA_Init
        PUBLIC LPLD_DMA_SoftwareStartService

// D:\2019.IAR\lib\LPLD\HW\HW_DMA.c
//    1 /**
//    2  * @file HW_DMA.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief DMA底层模块相关函数
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
        LDR.W    R2,??DataTable18  ;; 0xe000e100
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
        LDR.W    R2,??DataTable18_1  ;; 0xe000e180
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return
//   23 #include "HW_DMA.h"
//   24 
//   25 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   26 DMA_ISR_CALLBACK DMA_ISR[16];
DMA_ISR:
        DS8 64
//   27 
//   28 
//   29 /*
//   30  * LPLD_DMA_Init
//   31  * 初始化eDMA模块
//   32  * 
//   33  * 参数:
//   34  *    dma_init_struct--eDMA初始化结构体，
//   35  *                        具体定义见DMA_InitTypeDef
//   36  *
//   37  * 输出:
//   38  *    0--配置错误
//   39  *    1--配置成功
//   40  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 uint8 LPLD_DMA_Init(DMA_InitTypeDef dma_init_struct)
//   42 {
LPLD_DMA_Init:
        PUSH     {R0-R3}
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+20
//   43   uint8 chx = dma_init_struct.DMA_CHx;
        LDRB     R4,[SP, #+56]
//   44   uint8 req = dma_init_struct.DMA_Req;
        LDRB     R5,[SP, #+57]
//   45   boolean periodic_trigg = dma_init_struct.DMA_PeriodicTriggerEnable;
        LDRB     R0,[SP, #+58]
        STRB     R0,[SP, #+16]
//   46   uint16 major_cnt = dma_init_struct.DMA_MajorLoopCnt;
        LDRH     R6,[SP, #+60]
//   47   uint32 minor_cnt = dma_init_struct.DMA_MinorByteCnt;
        LDR      R0,[SP, #+64]
        STR      R0,[SP, #+12]
//   48   uint32 src_addr = dma_init_struct.DMA_SourceAddr;
        LDR      R7,[SP, #+68]
//   49   uint8 src_dsize = dma_init_struct.DMA_SourceDataSize;
        LDRB     R8,[SP, #+72]
//   50   int16 src_addroffset = dma_init_struct.DMA_SourceAddrOffset;
        LDRSH    R0,[SP, #+74]
        STRH     R0,[SP, #+2]
//   51   int32 src_lastadj = dma_init_struct.DMA_LastSourceAddrAdj;
        LDR      R0,[SP, #+76]
        STR      R0,[SP, #+8]
//   52   uint32 dst_addr = dma_init_struct.DMA_DestAddr;
        LDR      R9,[SP, #+80]
//   53   uint8 dst_dsize = dma_init_struct.DMA_DestDataSize;
        LDRB     R10,[SP, #+84]
//   54   int16 dst_addroffset = dma_init_struct.DMA_DestAddrOffset;
        LDRSH    R0,[SP, #+86]
        STRH     R0,[SP, #+0]
//   55   int32 dst_lastadj = dma_init_struct.DMA_LastDestAddrAdj;
        LDR      R0,[SP, #+88]
        STR      R0,[SP, #+4]
//   56   boolean auto_disable = dma_init_struct.DMA_AutoDisableReq;
        LDRB     R11,[SP, #+92]
//   57   
//   58   //参数检查
//   59   ASSERT( chx <= DMA_CH15 );       //eDMA通道选择
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+16
        BLT.N    ??LPLD_DMA_Init_0
        MOVS     R1,#+59
        LDR.W    R0,??DataTable18_2
        BL       assert_failed
//   60   ASSERT( req <= DMA_MUX_63 );     //请求源选择
??LPLD_DMA_Init_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+64
        BLT.N    ??LPLD_DMA_Init_1
        MOVS     R1,#+60
        LDR.W    R0,??DataTable18_2
        BL       assert_failed
//   61   ASSERT( major_cnt <= 0x7FFF );   //主计数判断
??LPLD_DMA_Init_1:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+32768
        BLT.N    ??LPLD_DMA_Init_2
        MOVS     R1,#+61
        LDR.W    R0,??DataTable18_2
        BL       assert_failed
//   62   ASSERT( src_addr != NULL );      //源地址判断
??LPLD_DMA_Init_2:
        CMP      R7,#+0
        BNE.N    ??LPLD_DMA_Init_3
        MOVS     R1,#+62
        LDR.W    R0,??DataTable18_2
        BL       assert_failed
//   63   ASSERT( (src_dsize <= DMA_SRC_32BIT)||(src_dsize == DMA_SRC_16BYTE) );     //源数据传输大小判断
??LPLD_DMA_Init_3:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+3
        BLT.N    ??LPLD_DMA_Init_4
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+4
        BEQ.N    ??LPLD_DMA_Init_4
        MOVS     R1,#+63
        LDR.W    R0,??DataTable18_2
        BL       assert_failed
//   64   ASSERT( dst_addr != NULL );      //目的地址判断
??LPLD_DMA_Init_4:
        CMP      R9,#+0
        BNE.N    ??LPLD_DMA_Init_5
        MOVS     R1,#+64
        LDR.W    R0,??DataTable18_2
        BL       assert_failed
//   65   ASSERT( (dst_dsize <= DMA_DST_32BIT)||(dst_dsize == DMA_DST_16BYTE) );     //目的数据传输大小判断
??LPLD_DMA_Init_5:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+3
        BLT.N    ??LPLD_DMA_Init_6
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+4
        BEQ.N    ??LPLD_DMA_Init_6
        MOVS     R1,#+65
        LDR.W    R0,??DataTable18_2
        BL       assert_failed
//   66  
//   67   SIM->SCGC6 |= SIM_SCGC6_DMAMUX_MASK;  //打开DMA通道多路复用器时钟   
??LPLD_DMA_Init_6:
        LDR.W    R0,??DataTable18_3  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.W    R1,??DataTable18_3  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   68   SIM->SCGC7 |= SIM_SCGC7_DMA_MASK;     //打开DMA模块时钟
        LDR.W    R0,??DataTable18_4  ;; 0x40048040
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.W    R1,??DataTable18_4  ;; 0x40048040
        STR      R0,[R1, #+0]
//   69   
//   70   //关闭通道x硬件DMA请求 
//   71   DMA0->ERQ &= ~(1<<chx);
        LDR.W    R0,??DataTable18_5  ;; 0x4000800c
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R4
        BICS     R0,R0,R1
        LDR.W    R1,??DataTable18_5  ;; 0x4000800c
        STR      R0,[R1, #+0]
//   72   
//   73   //选择 通道x 配置外设的DMA源请求编号
//   74   DMAMUX->CHCFG[chx] = DMAMUX_CHCFG_SOURCE(req);
        ANDS     R0,R5,#0x3F
        LDR.W    R1,??DataTable18_6  ;; 0x40021000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
//   75   //是否使能周期触发功能
//   76   if(periodic_trigg == TRUE)
        LDRB     R0,[SP, #+16]
        CMP      R0,#+1
        BNE.N    ??LPLD_DMA_Init_7
//   77   {
//   78     DMAMUX->CHCFG[chx] |= DMAMUX_CHCFG_TRIG_MASK;
        LDR.W    R0,??DataTable18_6  ;; 0x40021000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        ORRS     R0,R0,#0x40
        LDR.W    R1,??DataTable18_6  ;; 0x40021000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
        B.N      ??LPLD_DMA_Init_8
//   79   }
//   80   else
//   81   {
//   82     DMAMUX->CHCFG[chx] &= ~(DMAMUX_CHCFG_TRIG_MASK);
??LPLD_DMA_Init_7:
        LDR.W    R0,??DataTable18_6  ;; 0x40021000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        ANDS     R0,R0,#0xBF
        LDR.W    R1,??DataTable18_6  ;; 0x40021000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
//   83   }
//   84   
//   85   
//   86   //设置源地址   
//   87   DMA0->TCD[chx].SADDR = DMA_SADDR_SADDR(src_addr);
??LPLD_DMA_Init_8:
        LDR.W    R0,??DataTable18_7  ;; 0x40009000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        STR      R7,[R1, R0]
//   88   //在执行完针对源地址的操作之后，在源地址的基础上增加/减少偏移地址
//   89   DMA0->TCD[chx].SOFF = DMA_SOFF_SOFF(src_addroffset);
        LDRH     R0,[SP, #+2]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+4]
//   90   //设置源地址的传输大小
//   91   DMA0->TCD[chx].ATTR = 0 | DMA_ATTR_SSIZE(src_dsize);
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        LSLS     R0,R8,#+8
        ANDS     R0,R0,#0x700
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+6]
//   92   //主的计数次数（major iteration count）达到后，重新调整源地址
//   93   DMA0->TCD[chx].SLAST = DMA_SLAST_SLAST(src_lastadj);
        LDR      R0,[SP, #+8]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STR      R0,[R1, #+12]
//   94   
//   95   //设置目的地址 
//   96   DMA0->TCD[chx].DADDR = DMA_DADDR_DADDR(dst_addr);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        STR      R9,[R0, #+16]
//   97   //在执行完针对目的地址的操作之后，在目的地址的基础上增加/减少偏移地址
//   98   DMA0->TCD[chx].DOFF = DMA_DOFF_DOFF(dst_addroffset);
        LDRH     R0,[SP, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+20]
//   99   //设置目的地址的传输宽度
//  100   DMA0->TCD[chx].ATTR |= DMA_ATTR_DSIZE(dst_dsize);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        LDRH     R0,[R0, #+6]
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        ANDS     R1,R10,#0x7
        ORRS     R0,R1,R0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+6]
//  101   //主的计数次数（major iteration count）达到后，重新调整目的地址
//  102   DMA0->TCD[chx].DLAST_SGA = DMA_DLAST_SGA_DLASTSGA(dst_lastadj);
        LDR      R0,[SP, #+4]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STR      R0,[R1, #+24]
//  103   
//  104   //默认为禁用通道链接功能，后续更新添加此功能
//  105   if( 1 == 1)
//  106   {
//  107     //===============设置主计数器长度，循环次数====================================
//  108     //设置主循环计数器 current major loop count
//  109     DMA0->TCD[chx].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(major_cnt);
        LSLS     R0,R6,#+17       ;; ZeroExtS R0,R6,#+17,#+17
        LSRS     R0,R0,#+17
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+22]
//  110     //起始循环计数器，当主循环计数器为零的时候，将装载起始循环计数器的值
//  111     DMA0->TCD[chx].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(major_cnt);
        LSLS     R0,R6,#+17       ;; ZeroExtS R0,R6,#+17,#+17
        LSRS     R0,R0,#+17
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+30]
//  112   }
//  113   
//  114   //默认为禁用次循环地址偏移功能，后续更新添加此功能
//  115   if( 1 == 1)
//  116   {
//  117     //次循环一次传输字节的个数
//  118     DMA0->TCD[chx].NBYTES_MLNO = DMA_NBYTES_MLNO_NBYTES(minor_cnt);
        LDR      R0,[SP, #+12]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STR      R0,[R1, #+8]
//  119   }
//  120   
//  121   //清空TCD控制寄存器     
//  122   DMA0->TCD[chx].CSR = 0;
        MOVS     R0,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+28]
//  123   
//  124   //配置eDMA中断
//  125   if((dma_init_struct.DMA_Isr != NULL) && 
//  126      (dma_init_struct.DMA_MajorCompleteIntEnable == TRUE))
        LDR      R0,[SP, #+96]
        CMP      R0,#+0
        BEQ.N    ??LPLD_DMA_Init_9
        LDRB     R0,[SP, #+93]
        CMP      R0,#+1
        BNE.N    ??LPLD_DMA_Init_9
//  127   {
//  128 
//  129        DMA0->TCD[chx].CSR |= DMA_CSR_INTMAJOR_MASK; //使能DMA 主循环计数器减到零 中断
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        LDRH     R0,[R0, #+28]
        ORRS     R0,R0,#0x2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+28]
//  130        DMA_ISR[chx] = dma_init_struct.DMA_Isr;
        LDR      R0,[SP, #+96]
        LDR.N    R1,??DataTable18_8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R0,[R1, R4, LSL #+2]
//  131   }
//  132   if((dma_init_struct.DMA_Isr != NULL) && 
//  133      (dma_init_struct.DMA_MajorHalfCompleteIntEnable == TRUE))
??LPLD_DMA_Init_9:
        LDR      R0,[SP, #+96]
        CMP      R0,#+0
        BEQ.N    ??LPLD_DMA_Init_10
        LDRB     R0,[SP, #+94]
        CMP      R0,#+1
        BNE.N    ??LPLD_DMA_Init_10
//  134   {
//  135 
//  136        DMA0->TCD[chx].CSR |= DMA_CSR_INTHALF_MASK; //使能DMA 主循环计数器减到一半 中断
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        LDRH     R0,[R0, #+28]
        ORRS     R0,R0,#0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+28]
//  137        DMA_ISR[chx] = dma_init_struct.DMA_Isr;
        LDR      R0,[SP, #+96]
        LDR.N    R1,??DataTable18_8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R0,[R1, R4, LSL #+2]
//  138   }
//  139     
//  140   if(auto_disable == TRUE)
??LPLD_DMA_Init_10:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+1
        BNE.N    ??LPLD_DMA_Init_11
//  141   {
//  142      DMA0->TCD[chx].CSR |= DMA_CSR_DREQ_MASK; //主循环计数器等于零后，自动关闭DMA 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        LDRH     R0,[R0, #+28]
        ORRS     R0,R0,#0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+28]
        B.N      ??LPLD_DMA_Init_12
//  143   }
//  144   else
//  145   {
//  146      DMA0->TCD[chx].CSR &= ~(DMA_CSR_DREQ_MASK); //主循环计数器等于零后，不关闭DMA
??LPLD_DMA_Init_11:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        LDRH     R0,[R0, #+28]
        MOVW     R1,#+65527
        ANDS     R0,R1,R0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+28]
//  147   } 
//  148  
//  149   //DMA通道使能
//  150   DMAMUX->CHCFG[chx] |= DMAMUX_CHCFG_ENBL_MASK;
??LPLD_DMA_Init_12:
        LDR.N    R0,??DataTable18_6  ;; 0x40021000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable18_6  ;; 0x40021000
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
//  151     
//  152   return 1;
        MOVS     R0,#+1
        ADD      SP,SP,#+20
        POP      {R4-R11}
        LDR      PC,[SP], #+20    ;; return
//  153 }
//  154 
//  155 /*
//  156  * LPLD_DMA_EnableIrq
//  157  * 使能eDMA中断
//  158  * 
//  159  * 参数:
//  160  *    dma_init_struct--eDMA初始化结构体，
//  161  *                        具体定义见DMA_InitTypeDef
//  162  *
//  163  * 输出:
//  164  *    0--失败
//  165  *    1--成功
//  166  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  167 uint8 LPLD_DMA_EnableIrq(DMA_InitTypeDef dma_init_struct)
//  168 {
LPLD_DMA_EnableIrq:
        PUSH     {R0-R3}
        PUSH     {R7,LR}
//  169   enable_irq((IRQn_Type)(dma_init_struct.DMA_CHx + DMA0_IRQn));  
        LDRSB    R0,[SP, #+8]
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_EnableIRQ
//  170   return 1;
        MOVS     R0,#+1
        POP      {R1}
        LDR      PC,[SP], #+20    ;; return
//  171 }
//  172 
//  173 /*
//  174  * LPLD_DMA_DisableIrq
//  175  * 禁用eDMA中断
//  176  * 
//  177  * 参数:
//  178  *    dma_init_struct--eDMA初始化结构体，
//  179  *                        具体定义见DMA_InitTypeDef
//  180  *
//  181  * 输出:
//  182  *    0--失败
//  183  *    1--成功
//  184  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  185 uint8 LPLD_DMA_DisableIrq(DMA_InitTypeDef dma_init_struct)
//  186 {
LPLD_DMA_DisableIrq:
        PUSH     {R0-R3}
        PUSH     {R7,LR}
//  187   disable_irq((IRQn_Type)(dma_init_struct.DMA_CHx + DMA0_IRQn));
        LDRSB    R0,[SP, #+8]
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_DisableIRQ
//  188   return 1;
        MOVS     R0,#+1
        POP      {R1}
        LDR      PC,[SP], #+20    ;; return
//  189 }
//  190 
//  191 /*
//  192  * LPLD_DMA_SoftwareStartService
//  193  * DMA服务请求软件开始
//  194  * 
//  195  * 参数:
//  196  *    dma_init_struct--eDMA初始化结构体，
//  197  *                        具体定义见DMA_InitTypeDef
//  198  *
//  199  * 输出:
//  200  *    无
//  201  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  202 __INLINE void LPLD_DMA_SoftwareStartService(DMA_InitTypeDef dma_init_struct)
//  203 {
LPLD_DMA_SoftwareStartService:
        PUSH     {R0-R3}
//  204   DMA0->TCD[dma_init_struct.DMA_CHx].CSR |= DMA_CSR_START_MASK; 
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        LDRH     R0,[R0, #+28]
        ORRS     R0,R0,#0x1
        LDRB     R1,[SP, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+28]
//  205 }
        ADD      SP,SP,#+16
        BX       LR               ;; return
//  206 
//  207 /*
//  208  * eDMA中断处理函数
//  209  * 与启动文件startup_K60.s中的中断向量表关联
//  210  * 用户无需修改，程序自动进入对应通道中断函数
//  211  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  212 void DMA0_IRQHandler(void)
//  213 {
DMA0_IRQHandler:
        PUSH     {R7,LR}
//  214 #if (UCOS_II > 0u)
//  215   OS_CPU_SR  cpu_sr = 0u;
//  216   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  217   OSIntEnter();
//  218   OS_EXIT_CRITICAL();
//  219 #endif  
//  220   
//  221   //调用用户自定义中断服务
//  222   DMA_ISR[0]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+0]
        BLX      R0
//  223   //清除中断标志位
//  224   DMA0->INT |= 0x1u<<0;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  225   
//  226 #if (UCOS_II > 0u)
//  227   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  228 #endif
//  229 }
        POP      {R0,PC}          ;; return
//  230 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  231 void DMA1_IRQHandler(void)
//  232 {
DMA1_IRQHandler:
        PUSH     {R7,LR}
//  233 #if (UCOS_II > 0u)
//  234   OS_CPU_SR  cpu_sr = 0u;
//  235   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  236   OSIntEnter();
//  237   OS_EXIT_CRITICAL();
//  238 #endif  
//  239   
//  240   //调用用户自定义中断服务
//  241   DMA_ISR[1]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+4]
        BLX      R0
//  242   //清除中断标志位
//  243   DMA0->INT |= 0x1u<<1;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  244   
//  245 #if (UCOS_II > 0u)
//  246   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  247 #endif
//  248 }
        POP      {R0,PC}          ;; return
//  249 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  250 void DMA2_IRQHandler(void)
//  251 {
DMA2_IRQHandler:
        PUSH     {R7,LR}
//  252 #if (UCOS_II > 0u)
//  253   OS_CPU_SR  cpu_sr = 0u;
//  254   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  255   OSIntEnter();
//  256   OS_EXIT_CRITICAL();
//  257 #endif  
//  258   
//  259   //调用用户自定义中断服务
//  260   DMA_ISR[2]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+8]
        BLX      R0
//  261   //清除中断标志位
//  262   DMA0->INT |= 0x1u<<2;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  263   
//  264 #if (UCOS_II > 0u)
//  265   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  266 #endif
//  267 }
        POP      {R0,PC}          ;; return
//  268 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  269 void DMA3_IRQHandler(void)
//  270 {
DMA3_IRQHandler:
        PUSH     {R7,LR}
//  271 #if (UCOS_II > 0u)
//  272   OS_CPU_SR  cpu_sr = 0u;
//  273   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  274   OSIntEnter();
//  275   OS_EXIT_CRITICAL();
//  276 #endif  
//  277   
//  278   //调用用户自定义中断服务
//  279   DMA_ISR[3]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+12]
        BLX      R0
//  280   //清除中断标志位
//  281   DMA0->INT |= 0x1u<<3;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  282   
//  283 #if (UCOS_II > 0u)
//  284   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  285 #endif
//  286 }
        POP      {R0,PC}          ;; return
//  287 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  288 void DMA4_IRQHandler(void)
//  289 {
DMA4_IRQHandler:
        PUSH     {R7,LR}
//  290 #if (UCOS_II > 0u)
//  291   OS_CPU_SR  cpu_sr = 0u;
//  292   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  293   OSIntEnter();
//  294   OS_EXIT_CRITICAL();
//  295 #endif  
//  296   
//  297   //调用用户自定义中断服务
//  298   DMA_ISR[4]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+16]
        BLX      R0
//  299   //清除中断标志位
//  300   DMA0->INT |= 0x1u<<4;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  301   
//  302 #if (UCOS_II > 0u)
//  303   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  304 #endif
//  305 }
        POP      {R0,PC}          ;; return
//  306 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  307 void DMA5_IRQHandler(void)
//  308 {
DMA5_IRQHandler:
        PUSH     {R7,LR}
//  309 #if (UCOS_II > 0u)
//  310   OS_CPU_SR  cpu_sr = 0u;
//  311   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  312   OSIntEnter();
//  313   OS_EXIT_CRITICAL();
//  314 #endif  
//  315   
//  316   //调用用户自定义中断服务
//  317   DMA_ISR[5]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+20]
        BLX      R0
//  318   //清除中断标志位
//  319   DMA0->INT |= 0x1u<<5;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  320   
//  321 #if (UCOS_II > 0u)
//  322   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  323 #endif
//  324 }
        POP      {R0,PC}          ;; return
//  325 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  326 void DMA6_IRQHandler(void)
//  327 {
DMA6_IRQHandler:
        PUSH     {R7,LR}
//  328 #if (UCOS_II > 0u)
//  329   OS_CPU_SR  cpu_sr = 0u;
//  330   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  331   OSIntEnter();
//  332   OS_EXIT_CRITICAL();
//  333 #endif  
//  334   
//  335   //调用用户自定义中断服务
//  336   DMA_ISR[6]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+24]
        BLX      R0
//  337   //清除中断标志位
//  338   DMA0->INT |= 0x1u<<6;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  339   
//  340 #if (UCOS_II > 0u)
//  341   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  342 #endif
//  343 }
        POP      {R0,PC}          ;; return
//  344 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  345 void DMA7_IRQHandler(void)
//  346 {
DMA7_IRQHandler:
        PUSH     {R7,LR}
//  347 #if (UCOS_II > 0u)
//  348   OS_CPU_SR  cpu_sr = 0u;
//  349   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  350   OSIntEnter();
//  351   OS_EXIT_CRITICAL();
//  352 #endif  
//  353   
//  354   //调用用户自定义中断服务
//  355   DMA_ISR[7]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+28]
        BLX      R0
//  356   //清除中断标志位
//  357   DMA0->INT |= 0x1u<<7;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  358   
//  359 #if (UCOS_II > 0u)
//  360   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  361 #endif
//  362 }
        POP      {R0,PC}          ;; return
//  363 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  364 void DMA8_IRQHandler(void)
//  365 {
DMA8_IRQHandler:
        PUSH     {R7,LR}
//  366 #if (UCOS_II > 0u)
//  367   OS_CPU_SR  cpu_sr = 0u;
//  368   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  369   OSIntEnter();
//  370   OS_EXIT_CRITICAL();
//  371 #endif  
//  372   
//  373   //调用用户自定义中断服务
//  374   DMA_ISR[8]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+32]
        BLX      R0
//  375   //清除中断标志位
//  376   DMA0->INT |= 0x1u<<8;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  377   
//  378 #if (UCOS_II > 0u)
//  379   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  380 #endif
//  381 }
        POP      {R0,PC}          ;; return
//  382 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  383 void DMA9_IRQHandler(void)
//  384 {
DMA9_IRQHandler:
        PUSH     {R7,LR}
//  385 #if (UCOS_II > 0u)
//  386   OS_CPU_SR  cpu_sr = 0u;
//  387   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  388   OSIntEnter();
//  389   OS_EXIT_CRITICAL();
//  390 #endif  
//  391   
//  392   //调用用户自定义中断服务
//  393   DMA_ISR[9]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+36]
        BLX      R0
//  394   //清除中断标志位
//  395   DMA0->INT |= 0x1u<<9;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x200
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  396   
//  397 #if (UCOS_II > 0u)
//  398   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  399 #endif
//  400 }
        POP      {R0,PC}          ;; return
//  401 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  402 void DMA10_IRQHandler(void)
//  403 {
DMA10_IRQHandler:
        PUSH     {R7,LR}
//  404 #if (UCOS_II > 0u)
//  405   OS_CPU_SR  cpu_sr = 0u;
//  406   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  407   OSIntEnter();
//  408   OS_EXIT_CRITICAL();
//  409 #endif  
//  410   
//  411   //调用用户自定义中断服务
//  412   DMA_ISR[10]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+40]
        BLX      R0
//  413   //清除中断标志位
//  414   DMA0->INT |= 0x1u<10;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  415   
//  416 #if (UCOS_II > 0u)
//  417   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  418 #endif
//  419 }
        POP      {R0,PC}          ;; return
//  420 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  421 void DMA11_IRQHandler(void)
//  422 {
DMA11_IRQHandler:
        PUSH     {R7,LR}
//  423 #if (UCOS_II > 0u)
//  424   OS_CPU_SR  cpu_sr = 0u;
//  425   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  426   OSIntEnter();
//  427   OS_EXIT_CRITICAL();
//  428 #endif  
//  429   
//  430   //调用用户自定义中断服务
//  431   DMA_ISR[11]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+44]
        BLX      R0
//  432   //清除中断标志位
//  433   DMA0->INT |= 0x1u<<11;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  434   
//  435 #if (UCOS_II > 0u)
//  436   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  437 #endif
//  438 }
        POP      {R0,PC}          ;; return
//  439 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  440 void DMA12_IRQHandler(void)
//  441 {
DMA12_IRQHandler:
        PUSH     {R7,LR}
//  442 #if (UCOS_II > 0u)
//  443   OS_CPU_SR  cpu_sr = 0u;
//  444   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  445   OSIntEnter();
//  446   OS_EXIT_CRITICAL();
//  447 #endif  
//  448   
//  449   //调用用户自定义中断服务
//  450   DMA_ISR[12]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+48]
        BLX      R0
//  451   //清除中断标志位
//  452   DMA0->INT |= 0x1u<<12;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  453   
//  454 #if (UCOS_II > 0u)
//  455   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  456 #endif
//  457 }
        POP      {R0,PC}          ;; return
//  458 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  459 void DMA13_IRQHandler(void)
//  460 {
DMA13_IRQHandler:
        PUSH     {R7,LR}
//  461 #if (UCOS_II > 0u)
//  462   OS_CPU_SR  cpu_sr = 0u;
//  463   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  464   OSIntEnter();
//  465   OS_EXIT_CRITICAL();
//  466 #endif  
//  467   
//  468   //调用用户自定义中断服务
//  469   DMA_ISR[13]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+52]
        BLX      R0
//  470   //清除中断标志位
//  471   DMA0->INT |= 0x1u<<13;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  472   
//  473 #if (UCOS_II > 0u)
//  474   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  475 #endif
//  476 }
        POP      {R0,PC}          ;; return
//  477 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  478 void DMA14_IRQHandler(void)
//  479 {
DMA14_IRQHandler:
        PUSH     {R7,LR}
//  480 #if (UCOS_II > 0u)
//  481   OS_CPU_SR  cpu_sr = 0u;
//  482   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  483   OSIntEnter();
//  484   OS_EXIT_CRITICAL();
//  485 #endif  
//  486   
//  487   //调用用户自定义中断服务
//  488   DMA_ISR[14]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+56]
        BLX      R0
//  489   //清除中断标志位
//  490   DMA0->INT |= 0x1u<<14;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  491   
//  492 #if (UCOS_II > 0u)
//  493   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  494 #endif
//  495 }
        POP      {R0,PC}          ;; return
//  496 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  497 void DMA15_IRQHandler(void)
//  498 {
DMA15_IRQHandler:
        PUSH     {R7,LR}
//  499 #if (UCOS_II > 0u)
//  500   OS_CPU_SR  cpu_sr = 0u;
//  501   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  502   OSIntEnter();
//  503   OS_EXIT_CRITICAL();
//  504 #endif  
//  505   
//  506   //调用用户自定义中断服务
//  507   DMA_ISR[15]();
        LDR.N    R0,??DataTable18_8
        LDR      R0,[R0, #+60]
        BLX      R0
//  508   //清除中断标志位
//  509   DMA0->INT |= 0x1u<<15;
        LDR.N    R0,??DataTable18_9  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000
        LDR.N    R1,??DataTable18_9  ;; 0x40008024
        STR      R0,[R1, #+0]
//  510   
//  511 #if (UCOS_II > 0u)
//  512   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  513 #endif
//  514 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_1:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_3:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_4:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_5:
        DC32     0x4000800c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_6:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_7:
        DC32     0x40009000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_8:
        DC32     DMA_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18_9:
        DC32     0x40008024

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
        DC8 "D:\\2019.IAR\\lib\\LPLD\\HW\\HW_DMA.c"
        DC8 0, 0, 0

        END
//  515 
//  516 
//  517 
//  518 
//  519 
//  520 
//  521 
//  522 
//  523 
//  524 
//  525 
//  526 
//  527 
//  528 
//  529 
//  530 
// 
//    64 bytes in section .bss
//    36 bytes in section .rodata
// 1 292 bytes in section .text
// 
// 1 292 bytes of CODE  memory
//    36 bytes of CONST memory
//    64 bytes of DATA  memory
//
//Errors: none
//Warnings: none
