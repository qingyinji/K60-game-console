///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:29
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_GPIO.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_GPIO.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\HW_GPIO.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC GPIO_ISR
        PUBLIC LPLD_GPIO_DisableIrq
        PUBLIC LPLD_GPIO_EnableIrq
        PUBLIC LPLD_GPIO_Init
        PUBLIC LPLD_GPIO_Input
        PUBLIC LPLD_GPIO_Input_8b
        PUBLIC LPLD_GPIO_Input_b
        PUBLIC LPLD_GPIO_Output_8b
        PUBLIC LPLD_GPIO_Output_b
        PUBLIC LPLD_GPIO_Toggle
        PUBLIC LPLD_GPIO_Toggle_8b
        PUBLIC LPLD_GPIO_Toggle_b
        PUBLIC PORTA_IRQHandler
        PUBLIC PORTB_IRQHandler
        PUBLIC PORTC_IRQHandler
        PUBLIC PORTD_IRQHandler
        PUBLIC PORTE_IRQHandler

// D:\2019.IAR\lib\LPLD\HW\HW_GPIO.c
//    1 /**
//    2  * @file HW_GPIO.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief GPIO底层模块相关函数
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
        LDR.N    R2,??DataTable9  ;; 0xe000e100
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
        LDR.N    R2,??DataTable9_1  ;; 0xe000e180
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return
//   23 #include "HW_GPIO.h"
//   24 
//   25 
//   26 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 GPIO_ISR_CALLBACK GPIO_ISR[5];
GPIO_ISR:
        DS8 20
//   28 
//   29 /*
//   30  * LPLD_GPIO_Init
//   31  * GPIO通用初始化函数
//   32  * 
//   33  * 参数:
//   34  *    gpio_init_structure--GPIO初始化结构体，
//   35  *                        具体定义见GPIO_InitTypeDef
//   36  *
//   37  * 输出:
//   38  *    0--配置错误
//   39  *    1--配置成功
//   40  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 uint8 LPLD_GPIO_Init(GPIO_InitTypeDef gpio_init_structure)
//   42 {
LPLD_GPIO_Init:
        PUSH     {R0-R3}
        PUSH     {R3-R9,LR}
//   43   uint8 i;
//   44   PORT_Type *portx;
//   45   uint32 pcr = PORT_PCR_MUX(1)| gpio_init_structure.GPIO_PinControl; 
        LDR      R0,[SP, #+40]
        ORRS     R4,R0,#0x100
//   46   GPIO_Type *ptx = gpio_init_structure.GPIO_PTx;
        LDR      R7,[SP, #+32]
//   47   uint32 pins = gpio_init_structure.GPIO_Pins;
        LDR      R5,[SP, #+36]
//   48   uint8 dir = gpio_init_structure.GPIO_Dir;
        LDRB     R8,[SP, #+44]
//   49   uint8 output = gpio_init_structure.GPIO_Output;
        LDRB     R9,[SP, #+45]
//   50   GPIO_ISR_CALLBACK isr_func = gpio_init_structure.GPIO_Isr;
        LDR      R6,[SP, #+48]
//   51   
//   52   //参数检查
//   53   ASSERT( ptx <= PTE);                  //判断端口
        LDR.N    R0,??DataTable9_2  ;; 0x400ff101
        CMP      R7,R0
        BCC.N    ??LPLD_GPIO_Init_0
        MOVS     R1,#+53
        LDR.N    R0,??DataTable9_3
        BL       assert_failed
//   54   ASSERT( dir <= 1 );                   //判断方向
??LPLD_GPIO_Init_0:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+2
        BLT.N    ??LPLD_GPIO_Init_1
        MOVS     R1,#+54
        LDR.N    R0,??DataTable9_3
        BL       assert_failed
//   55   ASSERT( output <= 1 );                //判断输出电平状态
??LPLD_GPIO_Init_1:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        CMP      R9,#+2
        BLT.N    ??LPLD_GPIO_Init_2
        MOVS     R1,#+55
        LDR.N    R0,??DataTable9_3
        BL       assert_failed
//   56   
//   57   if(ptx == PTA)
??LPLD_GPIO_Init_2:
        LDR.N    R0,??DataTable9_4  ;; 0x400ff000
        CMP      R7,R0
        BNE.N    ??LPLD_GPIO_Init_3
//   58   {
//   59     portx = PORTA;  
        LDR.N    R1,??DataTable9_5  ;; 0x40049000
//   60     i = 0;
        MOVS     R0,#+0
//   61   }
//   62   else if(ptx == PTB) 
//   63   {
//   64     portx = PORTB;
//   65     i = 1;
//   66   }
//   67   else if(ptx == PTC) 
//   68   {
//   69     portx = PORTC;
//   70     i = 2;
//   71   }
//   72   else if(ptx == PTD) 
//   73   {
//   74     portx = PORTD;
//   75     i = 3; 
//   76   }
//   77   else if(ptx == PTE) 
//   78   {
//   79     portx = PORTE;
//   80     i = 4;
//   81   }
//   82   else
//   83     return 0;
//   84   
//   85   //输入或输出设置
//   86   if(dir==DIR_OUTPUT)
??LPLD_GPIO_Init_4:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+1
        BNE.N    ??LPLD_GPIO_Init_5
//   87   {
//   88     ptx->PDDR |= pins;
        LDR      R2,[R7, #+20]
        ORRS     R2,R5,R2
        STR      R2,[R7, #+20]
//   89     //设置初始输出
//   90     if(output==OUTPUT_H)
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        CMP      R9,#+1
        BNE.N    ??LPLD_GPIO_Init_6
//   91     {
//   92       ptx->PSOR = pins; 
        STR      R5,[R7, #+4]
        B.N      ??LPLD_GPIO_Init_7
//   93     }
??LPLD_GPIO_Init_3:
        LDR.N    R0,??DataTable9_6  ;; 0x400ff040
        CMP      R7,R0
        BNE.N    ??LPLD_GPIO_Init_8
        LDR.N    R1,??DataTable9_7  ;; 0x4004a000
        MOVS     R0,#+1
        B.N      ??LPLD_GPIO_Init_4
??LPLD_GPIO_Init_8:
        LDR.N    R0,??DataTable9_8  ;; 0x400ff080
        CMP      R7,R0
        BNE.N    ??LPLD_GPIO_Init_9
        LDR.N    R1,??DataTable9_9  ;; 0x4004b000
        MOVS     R0,#+2
        B.N      ??LPLD_GPIO_Init_4
??LPLD_GPIO_Init_9:
        LDR.N    R0,??DataTable9_10  ;; 0x400ff0c0
        CMP      R7,R0
        BNE.N    ??LPLD_GPIO_Init_10
        LDR.N    R1,??DataTable9_11  ;; 0x4004c000
        MOVS     R0,#+3
        B.N      ??LPLD_GPIO_Init_4
??LPLD_GPIO_Init_10:
        LDR.N    R0,??DataTable9_12  ;; 0x400ff100
        CMP      R7,R0
        BNE.N    ??LPLD_GPIO_Init_11
        LDR.N    R1,??DataTable9_13  ;; 0x4004d000
        MOVS     R0,#+4
        B.N      ??LPLD_GPIO_Init_4
??LPLD_GPIO_Init_11:
        MOVS     R0,#+0
        B.N      ??LPLD_GPIO_Init_12
//   94     else
//   95     {
//   96       ptx->PCOR = pins;
??LPLD_GPIO_Init_6:
        STR      R5,[R7, #+8]
        B.N      ??LPLD_GPIO_Init_7
//   97     }
//   98   }
//   99   else
//  100   { 
//  101     ptx->PDDR &= ~(pins);
??LPLD_GPIO_Init_5:
        LDR      R2,[R7, #+20]
        BICS     R2,R2,R5
        STR      R2,[R7, #+20]
//  102   }
//  103   
//  104   //配置所选引脚的控制寄存器
//  105   for(uint8 i=0; i<32; i++)
??LPLD_GPIO_Init_7:
        MOVS     R2,#+0
        B.N      ??LPLD_GPIO_Init_13
//  106   {
//  107     if(pins&(1ul<<i))
??LPLD_GPIO_Init_14:
        LSRS     R3,R5,R2
        LSLS     R3,R3,#+31
        BPL.N    ??LPLD_GPIO_Init_15
//  108     {
//  109       portx->PCR[i] = pcr;
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        STR      R4,[R1, R2, LSL #+2]
//  110     }
//  111   }
??LPLD_GPIO_Init_15:
        ADDS     R2,R2,#+1
??LPLD_GPIO_Init_13:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+32
        BLT.N    ??LPLD_GPIO_Init_14
//  112 
//  113   if(isr_func!=NULL)
        MOVS     R1,R6
        CMP      R1,#+0
        BEQ.N    ??LPLD_GPIO_Init_16
//  114     GPIO_ISR[i] = isr_func;
        LDR.N    R1,??DataTable9_14
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R6,[R1, R0, LSL #+2]
//  115   
//  116   return 1;
??LPLD_GPIO_Init_16:
        MOVS     R0,#+1
??LPLD_GPIO_Init_12:
        POP      {R1,R4-R9}
        LDR      PC,[SP], #+20    ;; return
//  117 }
//  118 
//  119 /*
//  120  * LPLD_GPIO_EnableIrq
//  121  * 使能GPIO外部中断
//  122  * 
//  123  * 参数:
//  124  *    gpio_init_structure--GPIO初始化结构体，
//  125  *                        具体定义见GPIO_InitTypeDef
//  126  *
//  127  * 输出:
//  128  *    0--配置错误
//  129  *    1--配置成功
//  130  *
//  131  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  132 uint8 LPLD_GPIO_EnableIrq(GPIO_InitTypeDef gpio_init_structure)
//  133 {
LPLD_GPIO_EnableIrq:
        PUSH     {R0-R3}
        PUSH     {R4,LR}
//  134   uint8 i;
//  135   GPIO_Type *ptx = gpio_init_structure.GPIO_PTx;
        LDR      R4,[SP, #+8]
//  136   
//  137   //参数检查
//  138   ASSERT( ptx <= PTE);                  //判断端口
        LDR.N    R0,??DataTable9_2  ;; 0x400ff101
        CMP      R4,R0
        BCC.N    ??LPLD_GPIO_EnableIrq_0
        MOVS     R1,#+138
        LDR.N    R0,??DataTable9_3
        BL       assert_failed
//  139   
//  140   if(ptx == PTA)
??LPLD_GPIO_EnableIrq_0:
        LDR.N    R0,??DataTable9_4  ;; 0x400ff000
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_EnableIrq_1
//  141     i = 0;
        MOVS     R0,#+0
        B.N      ??LPLD_GPIO_EnableIrq_2
//  142   else if(ptx == PTB) 
??LPLD_GPIO_EnableIrq_1:
        LDR.N    R0,??DataTable9_6  ;; 0x400ff040
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_EnableIrq_3
//  143     i = 1;
        MOVS     R0,#+1
        B.N      ??LPLD_GPIO_EnableIrq_2
//  144   else if(ptx == PTC) 
??LPLD_GPIO_EnableIrq_3:
        LDR.N    R0,??DataTable9_8  ;; 0x400ff080
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_EnableIrq_4
//  145     i = 2;
        MOVS     R0,#+2
        B.N      ??LPLD_GPIO_EnableIrq_2
//  146   else if(ptx == PTD) 
??LPLD_GPIO_EnableIrq_4:
        LDR.N    R0,??DataTable9_10  ;; 0x400ff0c0
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_EnableIrq_5
//  147     i = 3;
        MOVS     R0,#+3
        B.N      ??LPLD_GPIO_EnableIrq_2
//  148   else
//  149     i = 4;
??LPLD_GPIO_EnableIrq_5:
        MOVS     R0,#+4
//  150 
//  151   enable_irq((IRQn_Type)(i + PORTA_IRQn));
??LPLD_GPIO_EnableIrq_2:
        ADDS     R0,R0,#+87
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_EnableIRQ
//  152   
//  153   return 1;
        MOVS     R0,#+1
        POP      {R4}
        LDR      PC,[SP], #+20    ;; return
//  154 }
//  155 
//  156 /*
//  157  * LPLD_GPIO_DisableIrq
//  158  * 禁用GPIO外部中断
//  159  * 
//  160  * 参数:
//  161  *    gpio_init_structure--GPIO初始化结构体，
//  162  *                        具体定义见GPIO_InitTypeDef
//  163  *
//  164  * 输出:
//  165  *    0--配置错误
//  166  *    1--配置成功
//  167  *
//  168  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  169 uint8 LPLD_GPIO_DisableIrq(GPIO_InitTypeDef gpio_init_structure)
//  170 {
LPLD_GPIO_DisableIrq:
        PUSH     {R0-R3}
        PUSH     {R4,LR}
//  171   uint8 i;
//  172   GPIO_Type *ptx = gpio_init_structure.GPIO_PTx;
        LDR      R4,[SP, #+8]
//  173   
//  174   //参数检查
//  175   ASSERT( ptx <= PTE);                  //判断端口
        LDR.N    R0,??DataTable9_2  ;; 0x400ff101
        CMP      R4,R0
        BCC.N    ??LPLD_GPIO_DisableIrq_0
        MOVS     R1,#+175
        LDR.N    R0,??DataTable9_3
        BL       assert_failed
//  176   
//  177   if(ptx == PTA)
??LPLD_GPIO_DisableIrq_0:
        LDR.N    R0,??DataTable9_4  ;; 0x400ff000
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_DisableIrq_1
//  178     i = 0;
        MOVS     R0,#+0
        B.N      ??LPLD_GPIO_DisableIrq_2
//  179   else if(ptx == PTB) 
??LPLD_GPIO_DisableIrq_1:
        LDR.N    R0,??DataTable9_6  ;; 0x400ff040
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_DisableIrq_3
//  180     i = 1;
        MOVS     R0,#+1
        B.N      ??LPLD_GPIO_DisableIrq_2
//  181   else if(ptx == PTC) 
??LPLD_GPIO_DisableIrq_3:
        LDR.N    R0,??DataTable9_8  ;; 0x400ff080
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_DisableIrq_4
//  182     i = 2;
        MOVS     R0,#+2
        B.N      ??LPLD_GPIO_DisableIrq_2
//  183   else if(ptx == PTD) 
??LPLD_GPIO_DisableIrq_4:
        LDR.N    R0,??DataTable9_10  ;; 0x400ff0c0
        CMP      R4,R0
        BNE.N    ??LPLD_GPIO_DisableIrq_5
//  184     i = 3;
        MOVS     R0,#+3
        B.N      ??LPLD_GPIO_DisableIrq_2
//  185   else
//  186     i = 4;
??LPLD_GPIO_DisableIrq_5:
        MOVS     R0,#+4
//  187   
//  188   disable_irq((IRQn_Type)(i + PORTA_IRQn));
??LPLD_GPIO_DisableIrq_2:
        ADDS     R0,R0,#+87
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_DisableIRQ
//  189   
//  190   return 1;
        MOVS     R0,#+1
        POP      {R4}
        LDR      PC,[SP], #+20    ;; return
//  191 }
//  192 
//  193 /*
//  194  * LPLD_GPIO_Ouptut
//  195  * 设置GPIO端口0~31位的输出
//  196  * 
//  197  * 参数:
//  198  *    ptx--端口号
//  199  *      |__PTA        --Port A
//  200  *      |__PTB        --Port B
//  201  *      |__PTC        --Port C
//  202  *      |__PTD        --Port D
//  203  *      |__PTE        --Port E
//  204  *    data32--输出数据
//  205  *      |__0x00000000~0xFFFFFFFF--低到高代表GPIO口的第0~31位数据
//  206  *
//  207  * 输出:
//  208  *
//  209  */
//  210 __INLINE void LPLD_GPIO_Ouptut(GPIO_Type *ptx, uint32 data32)
//  211 { 
//  212   ptx->PDOR = data32;
//  213 }
//  214 
//  215 /*
//  216  * LPLD_GPIO_Ouptut_b
//  217  * 设置GPIO端口一位的输出
//  218  * 
//  219  * 参数:
//  220  *    ptx--端口号
//  221  *      |__PTA        --Port A
//  222  *      |__PTB        --Port B
//  223  *      |__PTC        --Port C
//  224  *      |__PTD        --Port D
//  225  *      |__PTE        --Port E
//  226  *    lsb_num--端口引脚位数编号
//  227  *      |__0~31       --GPIO口的第0~31位
//  228  *    data1--输出数据
//  229  *      |__0          --输出低电平
//  230  *      |__1          --输出高电平
//  231  *
//  232  * 输出:
//  233  *
//  234  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  235 __INLINE void LPLD_GPIO_Output_b(GPIO_Type *ptx, uint8 lsb_num, uint8 data1)
//  236 {
LPLD_GPIO_Output_b:
        PUSH     {R4}
//  237   ptx->PDOR = (ptx->PDOR & ~(0x01L<<lsb_num)) | (uint32)data1<<lsb_num;
        LDR      R3,[R0, #+0]
        MOVS     R4,#+1
        LSLS     R4,R4,R1
        BICS     R3,R3,R4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSLS     R1,R2,R1
        ORRS     R1,R1,R3
        STR      R1,[R0, #+0]
//  238 }
        POP      {R4}
        BX       LR               ;; return
//  239 
//  240 /*
//  241  * LPLD_GPIO_Ouptut_8b
//  242  * 设置GPIO端口8位的输出
//  243  * 
//  244  * 参数:
//  245  *    ptx--端口号
//  246  *      |__PTA        --Port A
//  247  *      |__PTB        --Port B
//  248  *      |__PTC        --Port C
//  249  *      |__PTD        --Port D
//  250  *      |__PTE        --Port E
//  251  *    lsb_num--代表8个端口引脚的最低位数编号
//  252  *      |__0~24       --GPIO口的第0~24位
//  253  *    data8--输出数据
//  254  *      |__0x00~0xFF--代表GPIO口输出的8位数据
//  255  *
//  256  * 输出:
//  257  *
//  258  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  259 __INLINE void LPLD_GPIO_Output_8b(GPIO_Type *ptx, uint8 lsb_num, uint8 data8)
//  260 {
LPLD_GPIO_Output_8b:
        PUSH     {R4}
//  261   ptx->PDOR = (ptx->PDOR & ~(0xFFL<<lsb_num)) | (uint32)data8<<lsb_num;
        LDR      R3,[R0, #+0]
        MOVS     R4,#+255
        LSLS     R4,R4,R1
        BICS     R3,R3,R4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSLS     R1,R2,R1
        ORRS     R1,R1,R3
        STR      R1,[R0, #+0]
//  262 }
        POP      {R4}
        BX       LR               ;; return
//  263 
//  264 /*
//  265  * LPLD_GPIO_Toggle
//  266  * 设置GPIO端口0~31的电平翻转
//  267  * 
//  268  * 参数:
//  269  *    ptx--端口号
//  270  *      |__PTA        --Port A
//  271  *      |__PTB        --Port B
//  272  *      |__PTC        --Port C
//  273  *      |__PTD        --Port D
//  274  *      |__PTE        --Port E
//  275  *    data32--翻转数据
//  276  *      |__0x00000000~0xFFFFFFFF--低到高代表GPIO口的第0~31位的翻转，1为反转，0为保持不变。
//  277  *
//  278  * 输出:
//  279  *
//  280  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  281 __INLINE void LPLD_GPIO_Toggle(GPIO_Type *ptx, uint32 data32)
//  282 {  
//  283   ptx->PTOR = data32;
LPLD_GPIO_Toggle:
        STR      R1,[R0, #+12]
//  284 }
        BX       LR               ;; return
//  285 
//  286 /*
//  287  * LPLD_GPIO_Toggle_b
//  288  * 设置GPIO端口一位的翻转
//  289  * 
//  290  * 参数:
//  291  *    ptx--端口号
//  292  *      |__PTA        --Port A
//  293  *      |__PTB        --Port B
//  294  *      |__PTC        --Port C
//  295  *      |__PTD        --Port D
//  296  *      |__PTE        --Port E
//  297  *    lsb_num--端口引脚位数编号
//  298  *      |__0~31       --GPIO口的第0~31位
//  299  *
//  300  * 输出:
//  301  *
//  302  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  303 __INLINE void LPLD_GPIO_Toggle_b(GPIO_Type *ptx, uint8 lsb_num)
//  304 {  
//  305   ptx->PTOR = 0x01L<<lsb_num;
LPLD_GPIO_Toggle_b:
        MOVS     R2,#+1
        LSLS     R1,R2,R1
        STR      R1,[R0, #+12]
//  306 }
        BX       LR               ;; return
//  307 
//  308 /*
//  309  * LPLD_GPIO_Toggle_8b
//  310  * 设置GPIO端口8位的翻转
//  311  * 
//  312  * 参数:
//  313  *    ptx--端口号
//  314  *      |__PTA        --Port A
//  315  *      |__PTB        --Port B
//  316  *      |__PTC        --Port C
//  317  *      |__PTD        --Port D
//  318  *      |__PTE        --Port E
//  319  *    lsb_num--代表8个端口引脚的最低位数编号
//  320  *      |__0~24       --GPIO口的第0~24位
//  321  *    data8--输出数据
//  322  *      |__0x00~0xFF--代表GPIO口输出的8位数据
//  323  *
//  324  * 输出:
//  325  *
//  326  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  327 __INLINE void LPLD_GPIO_Toggle_8b(GPIO_Type *ptx, uint8 lsb_num, uint8 data8)
//  328 {
//  329   ptx->PTOR = (uint32)data8<<lsb_num;
LPLD_GPIO_Toggle_8b:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSLS     R1,R2,R1
        STR      R1,[R0, #+12]
//  330 }
        BX       LR               ;; return
//  331 
//  332 /*
//  333  * LPLD_GPIO_Input
//  334  * 取得GPIO口0~31位的数据
//  335  * 
//  336  * 参数:
//  337  *    ptx--端口号
//  338  *      |__PTA        --Port A
//  339  *      |__PTB        --Port B
//  340  *      |__PTC        --Port C
//  341  *      |__PTD        --Port D
//  342  *      |__PTE        --Port E
//  343  *
//  344  * 输出:
//  345  *    指定GPIO口的32位输入
//  346  *
//  347  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  348 __INLINE uint32 LPLD_GPIO_Input(GPIO_Type *ptx)
//  349 {
//  350   return ptx->PDIR;
LPLD_GPIO_Input:
        LDR      R0,[R0, #+16]
        BX       LR               ;; return
//  351 }
//  352 
//  353 /*
//  354  * LPLD_GPIO_Input_b
//  355  * 取得GPIO口某一位的数据
//  356  * 
//  357  * 参数:
//  358  *    ptx--端口号
//  359  *      |__PTA        --Port A
//  360  *      |__PTB        --Port B
//  361  *      |__PTC        --Port C
//  362  *      |__PTD        --Port D
//  363  *      |__PTE        --Port E
//  364  *    lsb_num--端口引脚位数编号
//  365  *      |__0~31       --GPIO口的第0~31位
//  366  *
//  367  * 输出:
//  368  *    指定GPIO口的指定位数的电平
//  369  *
//  370  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  371 __INLINE uint8 LPLD_GPIO_Input_b(GPIO_Type *ptx, uint8 lsb_num)
//  372 {  
//  373   return (uint8)((ptx->PDIR>>lsb_num)&0x01L);
LPLD_GPIO_Input_b:
        LDR      R0,[R0, #+16]
        LSRS     R0,R0,R1
        ANDS     R0,R0,#0x1
        BX       LR               ;; return
//  374 }
//  375 
//  376 /*
//  377  * LPLD_GPIO_Input_8b
//  378  * 取得GPIO端口8位数据的输入
//  379  * 
//  380  * 参数:
//  381  *    ptx--端口号
//  382  *      |__PTA        --Port A
//  383  *      |__PTB        --Port B
//  384  *      |__PTC        --Port C
//  385  *      |__PTD        --Port D
//  386  *      |__PTE        --Port E
//  387  *    lsb_num--代表8个端口引脚的最低位数编号
//  388  *      |__0~24       --GPIO口的第0~24位
//  389  *
//  390  * 输出:
//  391  *    指定GPIO口的8位数据的电平
//  392  *
//  393  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  394 __INLINE uint8 LPLD_GPIO_Input_8b(GPIO_Type *ptx, uint8 lsb_num)
//  395 {
//  396   return (uint8)((ptx->PDIR>>lsb_num)&0xFFL);
LPLD_GPIO_Input_8b:
        LDR      R0,[R0, #+16]
        LSRS     R0,R0,R1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  397 }
//  398 
//  399 /*
//  400  * PORTA--PORTE中断处理函数
//  401  * 与启动文件startup_K60.s中的中断向量表关联
//  402  * 用户无需修改，程序自动进入对应通道中断函数
//  403  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  404 void PORTA_IRQHandler(void)
//  405 {
PORTA_IRQHandler:
        PUSH     {R7,LR}
//  406 #if (UCOS_II > 0u)
//  407   OS_CPU_SR  cpu_sr = 0u;
//  408   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  409   OSIntEnter();
//  410   OS_EXIT_CRITICAL();
//  411 #endif
//  412   
//  413   //调用用户自定义中断服务
//  414   GPIO_ISR[0](); 
        LDR.N    R0,??DataTable9_14
        LDR      R0,[R0, #+0]
        BLX      R0
//  415   PORTA->ISFR =0xFFFFFFFF;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_15  ;; 0x400490a0
        STR      R0,[R1, #+0]
//  416   
//  417 #if (UCOS_II > 0u)
//  418   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  419 #endif
//  420 }//           ;87:  PORT A interrupt
        POP      {R0,PC}          ;; return
//  421 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  422 void PORTB_IRQHandler(void)
//  423 {
PORTB_IRQHandler:
        PUSH     {R7,LR}
//  424 #if (UCOS_II > 0u)
//  425   OS_CPU_SR  cpu_sr = 0u;
//  426   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  427   OSIntEnter();
//  428   OS_EXIT_CRITICAL();
//  429 #endif
//  430   
//  431   //调用用户自定义中断服务
//  432   GPIO_ISR[1](); 
        LDR.N    R0,??DataTable9_14
        LDR      R0,[R0, #+4]
        BLX      R0
//  433   PORTB->ISFR =0xFFFFFFFF;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_16  ;; 0x4004a0a0
        STR      R0,[R1, #+0]
//  434   
//  435 #if (UCOS_II > 0u)
//  436   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  437 #endif
//  438 }//           ;88:  PORT B interrupt
        POP      {R0,PC}          ;; return
//  439 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  440 void PORTC_IRQHandler(void)
//  441 {
PORTC_IRQHandler:
        PUSH     {R7,LR}
//  442 #if (UCOS_II > 0u)
//  443   OS_CPU_SR  cpu_sr = 0u;
//  444   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  445   OSIntEnter();
//  446   OS_EXIT_CRITICAL();
//  447 #endif
//  448   
//  449   //调用用户自定义中断服务
//  450   GPIO_ISR[2](); 
        LDR.N    R0,??DataTable9_14
        LDR      R0,[R0, #+8]
        BLX      R0
//  451   PORTC->ISFR =0xFFFFFFFF;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_17  ;; 0x4004b0a0
        STR      R0,[R1, #+0]
//  452   
//  453 #if (UCOS_II > 0u)
//  454   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  455 #endif
//  456 }//           ;89:  PORT C interrupt
        POP      {R0,PC}          ;; return
//  457 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  458 void PORTD_IRQHandler(void)
//  459 {
PORTD_IRQHandler:
        PUSH     {R7,LR}
//  460 #if (UCOS_II > 0u)
//  461   OS_CPU_SR  cpu_sr = 0u;
//  462   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  463   OSIntEnter();
//  464   OS_EXIT_CRITICAL();
//  465 #endif
//  466   
//  467   //调用用户自定义中断服务
//  468   GPIO_ISR[3](); 
        LDR.N    R0,??DataTable9_14
        LDR      R0,[R0, #+12]
        BLX      R0
//  469   PORTD->ISFR =0xFFFFFFFF;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_18  ;; 0x4004c0a0
        STR      R0,[R1, #+0]
//  470   
//  471 #if (UCOS_II > 0u)
//  472   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  473 #endif
//  474 }//           ;90:  PORT D interrupt
        POP      {R0,PC}          ;; return
//  475 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  476 void PORTE_IRQHandler(void)
//  477 {
PORTE_IRQHandler:
        PUSH     {R7,LR}
//  478 #if (UCOS_II > 0u)
//  479   OS_CPU_SR  cpu_sr = 0u;
//  480   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  481   OSIntEnter();
//  482   OS_EXIT_CRITICAL();
//  483 #endif
//  484   
//  485   //调用用户自定义中断服务
//  486   GPIO_ISR[4](); 
        LDR.N    R0,??DataTable9_14
        LDR      R0,[R0, #+16]
        BLX      R0
//  487   PORTE->ISFR =0xFFFFFFFF;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_19  ;; 0x4004d0a0
        STR      R0,[R1, #+0]
//  488   
//  489 #if (UCOS_II > 0u)
//  490   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  491 #endif
//  492 }//           ;91:  PORT E interrupt
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
        DC32     0x400ff101

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0x400ff000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     0x40049000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC32     0x400ff040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC32     0x4004a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC32     0x400ff080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_9:
        DC32     0x4004b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_10:
        DC32     0x400ff0c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_11:
        DC32     0x4004c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_12:
        DC32     0x400ff100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_13:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_14:
        DC32     GPIO_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_15:
        DC32     0x400490a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_16:
        DC32     0x4004a0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_17:
        DC32     0x4004b0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_18:
        DC32     0x4004c0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_19:
        DC32     0x4004d0a0

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
        DC8 "D:\\2019.IAR\\lib\\LPLD\\HW\\HW_GPIO.c"
        DC8 0, 0

        END
// 
//  20 bytes in section .bss
//  36 bytes in section .rodata
// 688 bytes in section .text
// 
// 688 bytes of CODE  memory
//  36 bytes of CONST memory
//  20 bytes of DATA  memory
//
//Errors: none
//Warnings: none
