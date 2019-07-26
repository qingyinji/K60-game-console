///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:14:01
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_I2C.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_I2C.c -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\HW_I2C.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC I2C0_IRQHandler
        PUBLIC I2C1_IRQHandler
        PUBLIC I2C_ISR
        PUBLIC LPLD_I2C_Deinit
        PUBLIC LPLD_I2C_DisableIrq
        PUBLIC LPLD_I2C_EnableIrq
        PUBLIC LPLD_I2C_Init
        PUBLIC LPLD_I2C_ReStart
        PUBLIC LPLD_I2C_ReadByte
        PUBLIC LPLD_I2C_SetMasterWR
        PUBLIC LPLD_I2C_Start
        PUBLIC LPLD_I2C_StartTrans
        PUBLIC LPLD_I2C_Stop
        PUBLIC LPLD_I2C_WaitAck
        PUBLIC LPLD_I2C_WriteByte

// D:\2019.IAR\lib\LPLD\HW\HW_I2C.c
//    1 /*
//    2  * @file HW_I2C.c
//    3  * @version 3.02[By LPLD]
//    4  * @date 2013-11-22
//    5  * @brief I2C底层模块相关函数
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
//   22 
//   23 #include "common.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_EnableIRQ(IRQn_Type)
NVIC_EnableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.W    R2,??DataTable7  ;; 0xe000e100
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
        LDR.W    R2,??DataTable7_1  ;; 0xe000e180
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return
//   24 #include "HW_I2C.h"
//   25 
//   26 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 I2C_ISR_CALLBACK I2C_ISR[2];
I2C_ISR:
        DS8 8
//   28 
//   29 /*
//   30  * LPLD_I2C_Init
//   31  * I2C通用初始化函数，在该函数中选择I2C通道，选择I2C SCK总线频率，
//   32  * 选择I2C SDA 和 I2C SCL的引脚，配置I2C的中断回调函数
//   33  * 
//   34  * 参数:
//   35  *    I2C_InitTypeDef--i2c_init_structure
//   36  *                     具体定义见I2C_InitTypeDef
//   37  * 输出:
//   38  *    0--配置错误
//   39  *    1--配置成功
//   40  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 uint8 LPLD_I2C_Init(I2C_InitTypeDef i2c_init_structure)
//   42 {
LPLD_I2C_Init:
        PUSH     {R0-R10,LR}
//   43   I2C_Type *i2cx = i2c_init_structure.I2C_I2Cx;
        LDR      R4,[SP, #+0]
//   44   uint8 bus_speed = i2c_init_structure.I2C_ICR;
        LDRB     R5,[SP, #+4]
//   45   PortPinsEnum_Type scl_pin = i2c_init_structure.I2C_SclPin;
        LDRB     R6,[SP, #+6]
//   46   PortPinsEnum_Type sda_pin = i2c_init_structure.I2C_SdaPin;
        LDRB     R7,[SP, #+7]
//   47   I2C_ISR_CALLBACK isr_func = i2c_init_structure.I2C_Isr;
        LDR      R8,[SP, #+12]
//   48   boolean ode = i2c_init_structure.I2C_OpenDrainEnable;
        LDRB     R10,[SP, #+8]
//   49   uint8 ode_mask = 0;
        MOVS     R9,#+0
//   50 
//   51   //参数检查，判断SCL频率
//   52   ASSERT( bus_speed <= 0x3F);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+64
        BLT.N    ??LPLD_I2C_Init_0
        MOVS     R1,#+52
        LDR.W    R0,??DataTable7_2
        BL       assert_failed
//   53   
//   54   if(ode == TRUE)
??LPLD_I2C_Init_0:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+1
        BNE.N    ??LPLD_I2C_Init_1
//   55   {
//   56     ode_mask = PORT_PCR_ODE_MASK;
        MOVS     R9,#+32
//   57   }
//   58 
//   59   if(i2cx == I2C0)
??LPLD_I2C_Init_1:
        LDR.N    R0,??DataTable7_3  ;; 0x40066000
        CMP      R4,R0
        BNE.N    ??LPLD_I2C_Init_2
//   60   {
//   61     SIM->SCGC4 |= SIM_SCGC4_I2C0_MASK; //开启I2C0时钟
        LDR.N    R0,??DataTable7_4  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable7_4  ;; 0x40048034
        STR      R0,[R1, #+0]
//   62 
//   63     if(scl_pin == PTD8)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+100
        BNE.N    ??LPLD_I2C_Init_3
//   64     {
//   65       PORTD->PCR[8] = PORT_PCR_MUX(2) | ode_mask;         
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_5  ;; 0x4004c020
        STR      R0,[R1, #+0]
        B.N      ??LPLD_I2C_Init_4
//   66     }
//   67     else if(scl_pin == PTB0) 
??LPLD_I2C_Init_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+32
        BNE.N    ??LPLD_I2C_Init_5
//   68     {
//   69       PORTB->PCR[0] = PORT_PCR_MUX(2) | ode_mask;
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_6  ;; 0x4004a000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_I2C_Init_4
//   70     }
//   71     else //scl_pin = PTB2
//   72     {
//   73       PORTB->PCR[2] = PORT_PCR_MUX(2) | ode_mask;
??LPLD_I2C_Init_5:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_7  ;; 0x4004a008
        STR      R0,[R1, #+0]
//   74     }
//   75 
//   76     if(sda_pin == PTD9)
??LPLD_I2C_Init_4:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+101
        BNE.N    ??LPLD_I2C_Init_6
//   77     {
//   78       PORTD->PCR[9] = PORT_PCR_MUX(2) | ode_mask;
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_8  ;; 0x4004c024
        STR      R0,[R1, #+0]
//   79     }
//   80     else if(sda_pin == PTB1) 
//   81     {
//   82       PORTB->PCR[1] = PORT_PCR_MUX(2) | ode_mask;
//   83     }
//   84     else //sda_pin = PTB3
//   85     {
//   86       PORTB->PCR[3] = PORT_PCR_MUX(2) | ode_mask; 
//   87     }
//   88   }
//   89   else if(i2cx == I2C1)
//   90   { 
//   91     SIM->SCGC4 |= SIM_SCGC4_I2C1_MASK; //开启I2C1时钟
//   92 
//   93     if(scl_pin == PTE1)
//   94     {
//   95       PORTE->PCR[1] = PORT_PCR_MUX(6) | ode_mask;         
//   96     }
//   97     else //scl_pin = PTC10
//   98     {
//   99       PORTC->PCR[10] = PORT_PCR_MUX(2) | ode_mask;  
//  100     }
//  101 
//  102     if(sda_pin == PTE0)
//  103     {
//  104       PORTE->PCR[0] = PORT_PCR_MUX(6) | ode_mask;
//  105     }
//  106     else //sda_pin = PTC11
//  107     {
//  108       PORTC->PCR[11] = PORT_PCR_MUX(2) | ode_mask; 
//  109     }
//  110   }
//  111   else
//  112     return 0;
//  113   
//  114   if(i2c_init_structure.I2C_IntEnable == TRUE && isr_func != NULL)
??LPLD_I2C_Init_7:
        LDRB     R0,[SP, #+5]
        CMP      R0,#+1
        BNE.N    ??LPLD_I2C_Init_8
        MOV      R0,R8
        CMP      R0,#+0
        BEQ.N    ??LPLD_I2C_Init_8
//  115   {
//  116     //产生I2C中断的中断源：
//  117     //1,完成1个字节传输时，IICIF置位产生中断;
//  118     //2,当Calling Address匹配成功时产生中断，参考K60文档1456页I2Cx_S寄存器IAAS位;
//  119     //3,从机模式下当总线仲裁丢失时，IICIF置位产生中断;
//  120     //  需要同时写1清除II2Cx_S的ARBL标志位和 I2Cx_S的 IICIF的标志位;
//  121     //4,如果SMB寄存器的SHTF2 interrupt使能，当SHTF2 timeout时IICIF置位产生中断;
//  122     //  需要同时写1清除I2Cx_SMB的SLTF标志位和 I2Cx_S的 IICIF的标志位;
//  123     //5,当SLT寄存器不为0时，SMBus的SCL low timer计数等于SLT的值时IICIF置位产生中断;
//  124     //  需要同时写1清除I2Cx_SMB的SHTF2标志位和 I2Cx_S的 IICIF的标志位;
//  125     //6,当Wakeup 使能，I2C在停止模式下接收到Wakeup信号，将产生中断.
//  126 
//  127     i2cx->C1 |= I2C_C1_IICIE_MASK;
        LDRB     R0,[R4, #+2]
        ORRS     R0,R0,#0x40
        STRB     R0,[R4, #+2]
//  128 
//  129     if(i2cx == I2C0)
        LDR.N    R0,??DataTable7_3  ;; 0x40066000
        CMP      R4,R0
        BNE.N    ??LPLD_I2C_Init_9
//  130     {
//  131       I2C_ISR[0] = isr_func;
        LDR.N    R0,??DataTable7_9
        STR      R8,[R0, #+0]
//  132     }
//  133     else if(i2cx == I2C0)
//  134     {
//  135       I2C_ISR[1] = isr_func;
//  136     }
//  137     else 
//  138       return 0;
//  139   }
//  140 
//  141   //i2cx->C2 |= I2C_C2_HDRS_MASK;      //提高I2C驱动能力
//  142   i2cx->F  = I2C_F_ICR(bus_speed)|I2C_F_MULT(0);   //配置I2Cx SCL BusSpeed
??LPLD_I2C_Init_8:
        ANDS     R0,R5,#0x3F
        STRB     R0,[R4, #+1]
//  143   i2cx->C1 |= I2C_C1_IICEN_MASK;      //使能I2Cx
        LDRB     R0,[R4, #+2]
        ORRS     R0,R0,#0x80
        STRB     R0,[R4, #+2]
//  144   
//  145   return 1;
        MOVS     R0,#+1
??LPLD_I2C_Init_10:
        ADD      SP,SP,#+16
        POP      {R4-R10,PC}      ;; return
??LPLD_I2C_Init_6:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+33
        BNE.N    ??LPLD_I2C_Init_11
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_10  ;; 0x4004a004
        STR      R0,[R1, #+0]
        B.N      ??LPLD_I2C_Init_7
??LPLD_I2C_Init_11:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_11  ;; 0x4004a00c
        STR      R0,[R1, #+0]
        B.N      ??LPLD_I2C_Init_7
??LPLD_I2C_Init_2:
        LDR.N    R0,??DataTable7_12  ;; 0x40067000
        CMP      R4,R0
        BNE.N    ??LPLD_I2C_Init_12
        LDR.N    R0,??DataTable7_4  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable7_4  ;; 0x40048034
        STR      R0,[R1, #+0]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+125
        BNE.N    ??LPLD_I2C_Init_13
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x600
        LDR.N    R1,??DataTable7_13  ;; 0x4004d004
        STR      R0,[R1, #+0]
        B.N      ??LPLD_I2C_Init_14
??LPLD_I2C_Init_13:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_14  ;; 0x4004b028
        STR      R0,[R1, #+0]
??LPLD_I2C_Init_14:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+124
        BNE.N    ??LPLD_I2C_Init_15
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x600
        LDR.N    R1,??DataTable7_15  ;; 0x4004d000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_I2C_Init_7
??LPLD_I2C_Init_15:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        ORRS     R0,R9,#0x200
        LDR.N    R1,??DataTable7_16  ;; 0x4004b02c
        STR      R0,[R1, #+0]
        B.N      ??LPLD_I2C_Init_7
??LPLD_I2C_Init_12:
        MOVS     R0,#+0
        B.N      ??LPLD_I2C_Init_10
??LPLD_I2C_Init_9:
        LDR.N    R0,??DataTable7_3  ;; 0x40066000
        CMP      R4,R0
        BNE.N    ??LPLD_I2C_Init_16
        LDR.N    R0,??DataTable7_9
        STR      R8,[R0, #+4]
        B.N      ??LPLD_I2C_Init_8
??LPLD_I2C_Init_16:
        MOVS     R0,#+0
        B.N      ??LPLD_I2C_Init_10
//  146 }
//  147 
//  148 /*
//  149  * LPLD_I2C_Deinit
//  150  * I2C模块反初始化函数，在该函数中关闭I2Cx的外设总线时钟，关闭I2C模块的
//  151  * 时钟，禁止外设中断。
//  152  *
//  153  * 参数:
//  154  *    I2C_InitTypeDef--i2c_init_structure
//  155  *                     具体定义见I2C_InitTypeDef
//  156  *
//  157  * 输出:
//  158  *    无
//  159  *
//  160  */  

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  161 uint8 LPLD_I2C_Deinit(I2C_InitTypeDef i2c_init_structure)
//  162 {
LPLD_I2C_Deinit:
        PUSH     {R7,LR}
//  163   I2C_Type *i2cx = i2c_init_structure.I2C_I2Cx;
//  164 
//  165   i2cx->C1 &= ~I2C_C1_IICEN_MASK;      //I2Cx
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0x7F
        STRB     R1,[R0, #+2]
//  166   if(i2cx == I2C0)
        LDR.N    R1,??DataTable7_3  ;; 0x40066000
        CMP      R0,R1
        BNE.N    ??LPLD_I2C_Deinit_0
//  167   {
//  168     SIM->SCGC4 &= ~SIM_SCGC4_I2C0_MASK; //关闭I2C0时钟
        LDR.N    R0,??DataTable7_4  ;; 0x40048034
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable7_4  ;; 0x40048034
        STR      R0,[R1, #+0]
//  169     disable_irq((IRQn_Type)I2C0_IRQn);
        MOVS     R0,#+24
        BL       NVIC_DisableIRQ
//  170   }
//  171   else if (i2cx == I2C1)
//  172   {
//  173     SIM->SCGC4 &= ~SIM_SCGC4_I2C1_MASK; //关闭I2C1时钟
//  174     disable_irq((IRQn_Type)I2C1_IRQn);
//  175   }
//  176   else
//  177   {
//  178     return 0;
//  179   }
//  180   return 1;
??LPLD_I2C_Deinit_1:
        MOVS     R0,#+1
??LPLD_I2C_Deinit_2:
        POP      {R1,PC}          ;; return
??LPLD_I2C_Deinit_0:
        LDR.N    R1,??DataTable7_12  ;; 0x40067000
        CMP      R0,R1
        BNE.N    ??LPLD_I2C_Deinit_3
        LDR.N    R0,??DataTable7_4  ;; 0x40048034
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x80
        LDR.N    R1,??DataTable7_4  ;; 0x40048034
        STR      R0,[R1, #+0]
        MOVS     R0,#+25
        BL       NVIC_DisableIRQ
        B.N      ??LPLD_I2C_Deinit_1
??LPLD_I2C_Deinit_3:
        MOVS     R0,#+0
        B.N      ??LPLD_I2C_Deinit_2
//  181 }
//  182 
//  183 /*
//  184  * LPLD_I2C_EnableIrq
//  185  * I2C外设中断使能
//  186  *
//  187  * 参数:
//  188  *    I2C_InitTypeDef--i2c_init_structure
//  189  *                     具体定义见I2C_InitTypeDef
//  190  *
//  191  * 输出:
//  192  *    无
//  193  *
//  194  */  

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  195 void LPLD_I2C_EnableIrq(I2C_InitTypeDef i2c_init_structure)
//  196 {
LPLD_I2C_EnableIrq:
        PUSH     {R7,LR}
//  197   I2C_Type *i2cx = i2c_init_structure.I2C_I2Cx; 
//  198 
//  199   if(i2cx == I2C0)
        LDR.N    R1,??DataTable7_3  ;; 0x40066000
        CMP      R0,R1
        BNE.N    ??LPLD_I2C_EnableIrq_0
//  200   {
//  201     enable_irq((IRQn_Type)I2C0_IRQn);
        MOVS     R0,#+24
        BL       NVIC_EnableIRQ
//  202   }
//  203   else if (i2cx == I2C1)
//  204   {
//  205     enable_irq((IRQn_Type)I2C1_IRQn);
//  206   }
//  207   else
//  208   {
//  209     return;
//  210   }
//  211 }
??LPLD_I2C_EnableIrq_1:
??LPLD_I2C_EnableIrq_2:
        POP      {R0,PC}          ;; return
??LPLD_I2C_EnableIrq_0:
        LDR.N    R1,??DataTable7_12  ;; 0x40067000
        CMP      R0,R1
        BNE.N    ??LPLD_I2C_EnableIrq_3
        MOVS     R0,#+25
        BL       NVIC_EnableIRQ
        B.N      ??LPLD_I2C_EnableIrq_1
??LPLD_I2C_EnableIrq_3:
        B.N      ??LPLD_I2C_EnableIrq_2
//  212 
//  213 /*
//  214  * LPLD_I2C_DisableIrq
//  215  * 禁止I2C外设中断
//  216  *
//  217  * 参数:
//  218  *    I2C_InitTypeDef--i2c_init_structure
//  219  *                     具体定义见I2C_InitTypeDef
//  220  *
//  221  * 输出:
//  222  *    无
//  223  *
//  224  */  

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  225 void LPLD_I2C_DisableIrq(I2C_InitTypeDef i2c_init_structure)
//  226 {
LPLD_I2C_DisableIrq:
        PUSH     {R7,LR}
//  227   I2C_Type *i2cx = i2c_init_structure.I2C_I2Cx;
//  228   i2cx->C1 &= ~I2C_C1_IICIE_MASK;
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0xBF
        STRB     R1,[R0, #+2]
//  229 
//  230   if(i2cx == I2C0)
        LDR.N    R1,??DataTable7_3  ;; 0x40066000
        CMP      R0,R1
        BNE.N    ??LPLD_I2C_DisableIrq_0
//  231   {
//  232     disable_irq((IRQn_Type)I2C0_IRQn);
        MOVS     R0,#+24
        BL       NVIC_DisableIRQ
//  233   }
//  234   else if (i2cx == I2C1)
//  235   {
//  236     disable_irq((IRQn_Type)I2C1_IRQn);
//  237   }
//  238   else
//  239   {
//  240     return;
//  241   }
//  242 }
??LPLD_I2C_DisableIrq_1:
??LPLD_I2C_DisableIrq_2:
        POP      {R0,PC}          ;; return
??LPLD_I2C_DisableIrq_0:
        LDR.N    R1,??DataTable7_12  ;; 0x40067000
        CMP      R0,R1
        BNE.N    ??LPLD_I2C_DisableIrq_3
        MOVS     R0,#+25
        BL       NVIC_DisableIRQ
        B.N      ??LPLD_I2C_DisableIrq_1
??LPLD_I2C_DisableIrq_3:
        B.N      ??LPLD_I2C_DisableIrq_2
//  243 
//  244 /*
//  245  * LPLD_I2C_Start
//  246  * 产生I2C开始信号
//  247  * 
//  248  * 参数:
//  249  *    i2cx--选择I2C模块的通道
//  250  *      |__I2C0           --I2C通道0
//  251  *      |__I2C1           --I2C通道1
//  252  * 输出:
//  253  *    无
//  254  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  255 void LPLD_I2C_Start(I2C_Type *i2cx)
//  256 {
//  257   i2cx->C1 |= I2C_C1_TX_MASK ;
LPLD_I2C_Start:
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+2]
//  258   i2cx->C1 |= I2C_C1_MST_MASK ;
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x20
        STRB     R1,[R0, #+2]
//  259 }
        BX       LR               ;; return
//  260 
//  261 /*
//  262  * LPLD_ReStart
//  263  * I2C再次产生开始信号
//  264  * 
//  265  * 参数:
//  266  *    i2cx--选择I2C模块的通道
//  267  *      |__I2C0           --I2C通道0
//  268  *      |__I2C1           --I2C通道1
//  269  * 输出:
//  270  *    无
//  271 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  272 void LPLD_I2C_ReStart(I2C_Type *i2cx)
//  273 {
//  274   i2cx->C1 |= I2C_C1_RSTA_MASK ;
LPLD_I2C_ReStart:
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x4
        STRB     R1,[R0, #+2]
//  275 }
        BX       LR               ;; return
//  276 
//  277 /*
//  278  * LPLD_I2C_Stop
//  279  * 产生I2C停止信号
//  280  * 
//  281  * 参数:
//  282  *    i2cx--选择I2C模块的通道
//  283  *      |__I2C0           --I2C通道0
//  284  *      |__I2C1           --I2C通道1
//  285  * 输出:
//  286  *    无
//  287  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  288 void LPLD_I2C_Stop(I2C_Type *i2cx)
//  289 {
//  290   i2cx->C1 &=(~I2C_C1_MST_MASK);
LPLD_I2C_Stop:
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0xDF
        STRB     R1,[R0, #+2]
//  291   i2cx->C1 &=(~I2C_C1_TX_MASK); 
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0xEF
        STRB     R1,[R0, #+2]
//  292 }
        BX       LR               ;; return
//  293 
//  294 /*
//  295  * LPLD_I2C_WaitAck
//  296  * I2C设置等待应答信号，开启则等待，关闭则不等待
//  297  * 
//  298  * 参数:
//  299  *    i2cx--选择I2C模块的通道
//  300  *      |__I2C0           --I2C通道0
//  301  *      |__I2C1           --I2C通道1
//  302  *    is_wait--选择是否等待应答
//  303  *      |__I2C_ACK_OFF    --关闭等待Ack
//  304  *      |__I2C_ACK_ON     --开启等待Ack，并等待ACK信号
//  305  * 输出:
//  306  *    无
//  307  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  308 void LPLD_I2C_WaitAck(I2C_Type *i2cx, uint8 is_wait)
//  309 {
//  310   uint16 time_out;
//  311   if(is_wait == I2C_ACK_ON)
LPLD_I2C_WaitAck:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+1
        BEQ.N    ??LPLD_I2C_WaitAck_0
//  312   {
//  313     while(!(i2cx->S & I2C_S_IICIF_MASK))
//  314     {
//  315       if(time_out>60000) //如果等待超时，强行退出
//  316         break;
//  317       else time_out++;
//  318     }
//  319     i2cx->S |= I2C_S_IICIF_MASK;
//  320   }
//  321   else
//  322   {
//  323     //关闭I2C的ACK
//  324     i2cx->C1 |= I2C_C1_TXAK_MASK; 
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x8
        STRB     R1,[R0, #+2]
//  325   }
//  326 }
??LPLD_I2C_WaitAck_1:
        BX       LR               ;; return
??LPLD_I2C_WaitAck_2:
        ADDS     R2,R2,#+1
??LPLD_I2C_WaitAck_0:
        LDRB     R1,[R0, #+3]
        LSLS     R1,R1,#+30
        BMI.N    ??LPLD_I2C_WaitAck_3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVW     R1,#+60001
        CMP      R2,R1
        BLT.N    ??LPLD_I2C_WaitAck_2
??LPLD_I2C_WaitAck_3:
        LDRB     R1,[R0, #+3]
        ORRS     R1,R1,#0x2
        STRB     R1,[R0, #+3]
        B.N      ??LPLD_I2C_WaitAck_1
//  327 
//  328 /*
//  329  * LPLD_I2C_Write
//  330  * I2C发送一个字节给目的地址设备
//  331  * 
//  332  * 参数:
//  333  *    i2cx--选择I2C模块的通道
//  334  *      |__I2C0           --I2C通道0
//  335  *      |__I2C1           --I2C通道1
//  336  *    data8--要发送的字节数据
//  337  * 输出:
//  338  *    无
//  339  *
//  340  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  341 void LPLD_I2C_WriteByte(I2C_Type *i2cx, uint8 data8)
//  342 {
//  343   i2cx->D = data8; 
LPLD_I2C_WriteByte:
        STRB     R1,[R0, #+4]
//  344 }
        BX       LR               ;; return
//  345 
//  346 /*
//  347  * LPLD_I2C_Read
//  348  * I2C从外部设备读一个字节
//  349  * 
//  350  * 参数:
//  351  *    i2cx--选择I2C模块的通道
//  352  *      |__I2C0           --I2C通道0
//  353  *      |__I2C1           --I2C通道1
//  354  * 输出:
//  355  *    I2C读取的字节 
//  356  */
//  357 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  358 uint8 LPLD_I2C_ReadByte(I2C_Type *i2cx)
//  359 {
//  360   uint8 temp;
//  361   temp = i2cx->D; 
LPLD_I2C_ReadByte:
        LDRB     R0,[R0, #+4]
//  362   return temp;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  363 }
//  364 
//  365 /*
//  366  * LPLD_I2C_SetMasterWR
//  367  * I2C主机读写模式配置
//  368  * 
//  369  * 参数:
//  370  *    IICx--选择I2C模块的通道
//  371  *      |__I2C0           --I2C通道0
//  372  *      |__I2C1           --I2C通道1
//  373  *    mode--读写模式选择
//  374  *      |__I2C_MWSR         --主机写
//  375  *      |__I2C_MRSW         --主机读
//  376  * 输出:
//  377  *    无
//  378  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  379 void LPLD_I2C_SetMasterWR(I2C_Type *i2cx, uint8 mode)
//  380 {
//  381   if(mode==I2C_MRSW) 
LPLD_I2C_SetMasterWR:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+1
        BNE.N    ??LPLD_I2C_SetMasterWR_0
//  382     i2cx->C1 &= (~I2C_C1_TX_MASK);
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0xEF
        STRB     R1,[R0, #+2]
        B.N      ??LPLD_I2C_SetMasterWR_1
//  383   else
//  384     i2cx->C1 |= ( I2C_C1_TX_MASK);
??LPLD_I2C_SetMasterWR_0:
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+2]
//  385 }
??LPLD_I2C_SetMasterWR_1:
        BX       LR               ;; return
//  386 
//  387 /*
//  388  * LPLD_I2C_StartTrans
//  389  * I2C开始传输函数，需要设置外围设备地址和读写模式
//  390  * 
//  391  * 参数:
//  392  *    IICx--选择I2C模块的通道
//  393  *      |__I2C0           --I2C通道0
//  394  *      |__I2C1           --I2C通道1
//  395  *    addr--外围设备地址     
//  396  *    mode--读写模式选择
//  397  *      |__I2C_MWSR         --主机写
//  398  *      |__I2C_MRSW         --主机读
//  399  * 输出:
//  400  *    无
//  401  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  402 void LPLD_I2C_StartTrans(I2C_Type *i2cx, uint8 addr, uint8 mode)
//  403 {
LPLD_I2C_StartTrans:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  404   //I2C产生start信号
//  405   LPLD_I2C_Start(i2cx);
        MOVS     R0,R4
        BL       LPLD_I2C_Start
//  406   //将从机地址和主机读写位合成一个字节写入
//  407   LPLD_I2C_WriteByte(i2cx, (addr<<1)|mode );
        ORRS     R1,R6,R5, LSL #+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        BL       LPLD_I2C_WriteByte
//  408 }
        POP      {R4-R6,PC}       ;; return
//  409 
//  410 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  411 void I2C0_IRQHandler(void)
//  412 {
I2C0_IRQHandler:
        PUSH     {R7,LR}
//  413 #if (UCOS_II > 0u)
//  414   OS_CPU_SR  cpu_sr = 0u;
//  415   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  416   OSIntEnter();
//  417   OS_EXIT_CRITICAL();
//  418 #endif
//  419   if(I2C0->S & I2C_S_IICIF_MASK)
        LDR.N    R0,??DataTable7_17  ;; 0x40066003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??I2C0_IRQHandler_0
//  420   {
//  421     I2C_ISR[0]();
        LDR.N    R0,??DataTable7_9
        LDR      R0,[R0, #+0]
        BLX      R0
//  422     if(I2C0->SMB & I2C_SMB_SLTF_MASK)
        LDR.N    R0,??DataTable7_18  ;; 0x40066008
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL.N    ??I2C0_IRQHandler_1
//  423     {
//  424       I2C0->SMB |= I2C_SMB_SLTF_MASK;
        LDR.N    R0,??DataTable7_18  ;; 0x40066008
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable7_18  ;; 0x40066008
        STRB     R0,[R1, #+0]
//  425     }
//  426     if(I2C0->SMB & I2C_SMB_SHTF2_MASK)
??I2C0_IRQHandler_1:
        LDR.N    R0,??DataTable7_18  ;; 0x40066008
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??I2C0_IRQHandler_2
//  427     {
//  428       I2C0->SMB |= I2C_SMB_SHTF2_MASK;
        LDR.N    R0,??DataTable7_18  ;; 0x40066008
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable7_18  ;; 0x40066008
        STRB     R0,[R1, #+0]
//  429     }
//  430     if(I2C0->S & I2C_S_ARBL_MASK)
??I2C0_IRQHandler_2:
        LDR.N    R0,??DataTable7_17  ;; 0x40066003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL.N    ??I2C0_IRQHandler_3
//  431     {
//  432       I2C0->S |= I2C_S_ARBL_MASK;
        LDR.N    R0,??DataTable7_17  ;; 0x40066003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable7_17  ;; 0x40066003
        STRB     R0,[R1, #+0]
//  433     }
//  434     I2C0->S |= I2C_S_IICIF_MASK;
??I2C0_IRQHandler_3:
        LDR.N    R0,??DataTable7_17  ;; 0x40066003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable7_17  ;; 0x40066003
        STRB     R0,[R1, #+0]
//  435   }
//  436 #if (UCOS_II > 0u)
//  437   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  438 #endif
//  439 }
??I2C0_IRQHandler_0:
        POP      {R0,PC}          ;; return
//  440 //HW层中断函数，用户无需调用

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  441 void I2C1_IRQHandler(void)
//  442 {
I2C1_IRQHandler:
        PUSH     {R7,LR}
//  443 
//  444 #if (UCOS_II > 0u)
//  445   OS_CPU_SR  cpu_sr = 0u;
//  446   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  447   OSIntEnter();
//  448   OS_EXIT_CRITICAL();
//  449 #endif
//  450 
//  451   if(I2C1->S & I2C_S_IICIF_MASK)
        LDR.N    R0,??DataTable7_19  ;; 0x40067003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??I2C1_IRQHandler_0
//  452   {
//  453     I2C_ISR[1]();
        LDR.N    R0,??DataTable7_9
        LDR      R0,[R0, #+4]
        BLX      R0
//  454     if(I2C1->SMB & I2C_SMB_SLTF_MASK)
        LDR.N    R0,??DataTable7_20  ;; 0x40067008
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL.N    ??I2C1_IRQHandler_1
//  455     {
//  456       I2C1->SMB |= I2C_SMB_SLTF_MASK;
        LDR.N    R0,??DataTable7_20  ;; 0x40067008
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable7_20  ;; 0x40067008
        STRB     R0,[R1, #+0]
//  457     }
//  458     if(I2C1->SMB & I2C_SMB_SHTF2_MASK)
??I2C1_IRQHandler_1:
        LDR.N    R0,??DataTable7_20  ;; 0x40067008
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??I2C1_IRQHandler_2
//  459     {
//  460       I2C1->SMB |= I2C_SMB_SHTF2_MASK;
        LDR.N    R0,??DataTable7_20  ;; 0x40067008
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable7_20  ;; 0x40067008
        STRB     R0,[R1, #+0]
//  461     }
//  462     if(I2C1->S & I2C_S_ARBL_MASK)
??I2C1_IRQHandler_2:
        LDR.N    R0,??DataTable7_19  ;; 0x40067003
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL.N    ??I2C1_IRQHandler_3
//  463     {
//  464       I2C1->S |= I2C_S_ARBL_MASK;
        LDR.N    R0,??DataTable7_19  ;; 0x40067003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable7_19  ;; 0x40067003
        STRB     R0,[R1, #+0]
//  465     }
//  466     I2C1->S |= I2C_S_IICIF_MASK;
??I2C1_IRQHandler_3:
        LDR.N    R0,??DataTable7_19  ;; 0x40067003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable7_19  ;; 0x40067003
        STRB     R0,[R1, #+0]
//  467   }
//  468   
//  469 #if (UCOS_II > 0u)
//  470   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  471 #endif
//  472 }
??I2C1_IRQHandler_0:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_1:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_3:
        DC32     0x40066000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_4:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_5:
        DC32     0x4004c020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_6:
        DC32     0x4004a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_7:
        DC32     0x4004a008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_8:
        DC32     0x4004c024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_9:
        DC32     I2C_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_10:
        DC32     0x4004a004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_11:
        DC32     0x4004a00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_12:
        DC32     0x40067000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_13:
        DC32     0x4004d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_14:
        DC32     0x4004b028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_15:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_16:
        DC32     0x4004b02c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_17:
        DC32     0x40066003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_18:
        DC32     0x40066008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_19:
        DC32     0x40067003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_20:
        DC32     0x40067008

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
        DC8 "D:\\2019.IAR\\lib\\LPLD\\HW\\HW_I2C.c"
        DC8 0, 0, 0

        END
//  473 
//  474 
//  475 
// 
//   8 bytes in section .bss
//  36 bytes in section .rodata
// 946 bytes in section .text
// 
// 946 bytes of CODE  memory
//  36 bytes of CONST memory
//   8 bytes of DATA  memory
//
//Errors: none
//Warnings: none
