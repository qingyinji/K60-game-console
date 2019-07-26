///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:33
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_RTC.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_RTC.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\HW_RTC.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC LPLD_RTC_Deinit
        PUBLIC LPLD_RTC_Init
        PUBLIC LPLD_RTC_IsRunning
        PUBLIC RTC_IRQHandler
        PUBLIC RTC_ISR

// D:\2019.IAR\lib\LPLD\HW\HW_RTC.c
//    1 /**
//    2  * @file HW_RTC.c
//    3  * @version 3.01[By LPLD]
//    4  * @date 2013-10-4
//    5  * @brief RTC底层模块相关函数
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
// static __interwork __softfp void NVIC_DisableIRQ(IRQn_Type)
NVIC_DisableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.N    R2,??DataTable4  ;; 0xe000e180
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return
//   23 #include "HW_RTC.h"
//   24 
//   25 //用户自定义中断服务函数

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   26 RTC_ISR_CALLBACK RTC_ISR[3];
RTC_ISR:
        DS8 12
//   27 
//   28 /*
//   29  * LPLD_RTC_Init
//   30  * RTC通用初始化函数,在该函数需要设置RTC秒计数器，如果需要报警功能
//   31  * 需要使能报警中断，并设置报警寄存器
//   32  * 
//   33  * 参数:
//   34  *    rtc_init_structure--RTC初始化结构体，
//   35  *                        具体定义见RTC_InitTypeDef
//   36  *
//   37  * 输出:
//   38  *    0--配置错误
//   39  *    1--配置成功
//   40  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 uint8 LPLD_RTC_Init(RTC_InitTypeDef rtc_init_structure)
//   42 {
LPLD_RTC_Init:
        PUSH     {R0-R3}
        PUSH     {R4-R6}
//   43   int delay;
//   44   uint32 seconds = rtc_init_structure.RTC_Seconds;
        LDR      R0,[SP, #+12]
//   45   uint32 alarm_time = rtc_init_structure.RTC_AlarmTime;
        LDR      R1,[SP, #+16]
//   46   RTC_ISR_CALLBACK invalid_isr_func = rtc_init_structure.RTC_InvalidIsr;
        LDR      R2,[SP, #+24]
//   47   RTC_ISR_CALLBACK overflow_isr_func = rtc_init_structure.RTC_OverflowIsr;
        LDR      R3,[SP, #+28]
//   48   RTC_ISR_CALLBACK alarm_isr_func = rtc_init_structure.RTC_AlarmIsr;
        LDR      R4,[SP, #+32]
//   49 
//   50   SIM->SCGC6 |= SIM_SCGC6_RTC_MASK;
        LDR.N    R5,??DataTable4_1  ;; 0x4004803c
        LDR      R5,[R5, #+0]
        ORRS     R5,R5,#0x20000000
        LDR.N    R6,??DataTable4_1  ;; 0x4004803c
        STR      R5,[R6, #+0]
//   51   //复位所有RTC寄存器 除了SWR位 RTC_WAR和RTC_RAR寄存器
//   52   //在VBAT POR设置之后,用软件清除SWR
//   53   //复位RTC寄存器
//   54   RTC->CR  = RTC_CR_SWR_MASK; 
        MOVS     R5,#+1
        LDR.N    R6,??DataTable4_2  ;; 0x4003d010
        STR      R5,[R6, #+0]
//   55   //清除RTC复位标志  
//   56   RTC->CR  &= ~RTC_CR_SWR_MASK;  
        LDR.N    R5,??DataTable4_2  ;; 0x4003d010
        LDR      R5,[R5, #+0]
        LSRS     R5,R5,#+1
        LSLS     R5,R5,#+1
        LDR.N    R6,??DataTable4_2  ;; 0x4003d010
        STR      R5,[R6, #+0]
//   57   //使能RTC 32.768 kHzRTC时钟源
//   58   //使能之后要延时一段时间等待
//   59   //等待时钟稳定后在配置RTC时钟计数器
//   60   RTC->CR |= RTC_CR_OSCE_MASK;
        LDR.N    R5,??DataTable4_2  ;; 0x4003d010
        LDR      R5,[R5, #+0]
        ORRS     R5,R5,#0x100
        LDR.N    R6,??DataTable4_2  ;; 0x4003d010
        STR      R5,[R6, #+0]
//   61   
//   62   //等待32.768时钟起振
//   63   for(delay = 0;delay < 0x600000 ;delay++);
        MOVS     R5,#+0
        B.N      ??LPLD_RTC_Init_0
??LPLD_RTC_Init_1:
        ADDS     R5,R5,#+1
??LPLD_RTC_Init_0:
        CMP      R5,#+6291456
        BLT.N    ??LPLD_RTC_Init_1
//   64   
//   65   if(rtc_init_structure.RTC_InvalidIntEnable == TRUE)
        LDRB     R5,[SP, #+20]
        CMP      R5,#+1
        BNE.N    ??LPLD_RTC_Init_2
//   66   { 
//   67     RTC->IER |= (RTC_INT_INVALID & 0x07);//开启RTC无效数据中断
        LDR.N    R5,??DataTable4_3  ;; 0x4003d01c
        LDR      R5,[R5, #+0]
        ORRS     R5,R5,#0x1
        LDR.N    R6,??DataTable4_3  ;; 0x4003d01c
        STR      R5,[R6, #+0]
//   68     RTC_ISR[0] = invalid_isr_func;
        LDR.N    R5,??DataTable4_4
        STR      R2,[R5, #+0]
        B.N      ??LPLD_RTC_Init_3
//   69   }
//   70   else
//   71   {
//   72     RTC->IER &= ~RTC_INT_INVALID;
??LPLD_RTC_Init_2:
        LDR.N    R2,??DataTable4_3  ;; 0x4003d01c
        LDR      R2,[R2, #+0]
        LSRS     R2,R2,#+1
        LSLS     R2,R2,#+1
        LDR.N    R5,??DataTable4_3  ;; 0x4003d01c
        STR      R2,[R5, #+0]
//   73   }
//   74 
//   75   if(rtc_init_structure.RTC_OverflowIntEnable == TRUE)
??LPLD_RTC_Init_3:
        LDRB     R2,[SP, #+21]
        CMP      R2,#+1
        BNE.N    ??LPLD_RTC_Init_4
//   76   { 
//   77     RTC->IER |= (RTC_INT_OVERFLOW & 0x07);//开启RTC计数器溢出中断
        LDR.N    R2,??DataTable4_3  ;; 0x4003d01c
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x2
        LDR.N    R5,??DataTable4_3  ;; 0x4003d01c
        STR      R2,[R5, #+0]
//   78     RTC_ISR[1] = overflow_isr_func;
        LDR.N    R2,??DataTable4_4
        STR      R3,[R2, #+4]
        B.N      ??LPLD_RTC_Init_5
//   79   }
//   80   else
//   81   {
//   82     RTC->IER &= ~RTC_INT_OVERFLOW;
??LPLD_RTC_Init_4:
        LDR.N    R2,??DataTable4_3  ;; 0x4003d01c
        LDR      R2,[R2, #+0]
        BICS     R2,R2,#0x2
        LDR.N    R3,??DataTable4_3  ;; 0x4003d01c
        STR      R2,[R3, #+0]
//   83   }
//   84 
//   85   if(rtc_init_structure.RTC_AlarmIntEnable == TRUE)
??LPLD_RTC_Init_5:
        LDRB     R2,[SP, #+22]
        CMP      R2,#+1
        BNE.N    ??LPLD_RTC_Init_6
//   86   {   
//   87     RTC->IER |= (RTC_INT_ALARM & 0x07);//开启RTC报警中断
        LDR.N    R2,??DataTable4_3  ;; 0x4003d01c
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x4
        LDR.N    R3,??DataTable4_3  ;; 0x4003d01c
        STR      R2,[R3, #+0]
//   88     RTC_ISR[2] = alarm_isr_func;
        LDR.N    R2,??DataTable4_4
        STR      R4,[R2, #+8]
        B.N      ??LPLD_RTC_Init_7
//   89   }
//   90   else
//   91   {
//   92     RTC->IER &= ~RTC_INT_ALARM;
??LPLD_RTC_Init_6:
        LDR.N    R2,??DataTable4_3  ;; 0x4003d01c
        LDR      R2,[R2, #+0]
        BICS     R2,R2,#0x4
        LDR.N    R3,??DataTable4_3  ;; 0x4003d01c
        STR      R2,[R3, #+0]
//   93   }
//   94 
//   95   //设置时钟补偿寄存器
//   96   RTC->TCR = RTC_TCR_CIR(0) | RTC_TCR_TCR(0);
??LPLD_RTC_Init_7:
        MOVS     R2,#+0
        LDR.N    R3,??DataTable4_5  ;; 0x4003d00c
        STR      R2,[R3, #+0]
//   97   
//   98   //配置秒计数器
//   99   RTC->TSR = seconds;
        LDR.N    R2,??DataTable4_6  ;; 0x4003d000
        STR      R0,[R2, #+0]
//  100     
//  101   //配置报警寄存器
//  102   RTC->TAR = alarm_time;
        LDR.N    R0,??DataTable4_7  ;; 0x4003d008
        STR      R1,[R0, #+0]
//  103   
//  104   //使能秒计数器
//  105   RTC->SR |= RTC_SR_TCE_MASK;
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable4_8  ;; 0x4003d014
        STR      R0,[R1, #+0]
//  106   
//  107   return 1;
        MOVS     R0,#+1
        POP      {R4-R6}
        ADD      SP,SP,#+16
        BX       LR               ;; return
//  108 }
//  109 
//  110 /*
//  111  * LPLD_RTC_Deinit
//  112  * RTC反初始化函数，关闭RTCx并禁止RTC中断
//  113  * 
//  114  * 参数:
//  115  *    无
//  116  *
//  117  * 输出:
//  118  *    无
//  119  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  120 void LPLD_RTC_Deinit(void)
//  121 {
LPLD_RTC_Deinit:
        PUSH     {R7,LR}
//  122   //禁止RTC模块中断
//  123   disable_irq(RTC_IRQn);
        MOVS     R0,#+66
        BL       NVIC_DisableIRQ
//  124   //关闭RTC
//  125   RTC->SR &= (~RTC_SR_TCE_MASK);
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x10
        LDR.N    R1,??DataTable4_8  ;; 0x4003d014
        STR      R0,[R1, #+0]
//  126   //关闭RTC总线时钟
//  127   SIM->SCGC6 |= SIM_SCGC6_RTC_MASK;  
        LDR.N    R0,??DataTable4_1  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000000
        LDR.N    R1,??DataTable4_1  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  128 }
        POP      {R0,PC}          ;; return
//  129 
//  130 /*
//  131  * LPLD_RTC_IsRunning
//  132  * 判断RTC是否运行函数
//  133  * 
//  134  * 参数:
//  135  *    无
//  136  *
//  137  * 输出:
//  138  *    1，RTC计数器正在运行
//  139  *    0，RTC计数器以复位
//  140  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  141 uint8 LPLD_RTC_IsRunning(void)
//  142 {
//  143   uint8 request;
//  144   SIM->SCGC6 |= SIM_SCGC6_RTC_MASK;
LPLD_RTC_IsRunning:
        LDR.N    R0,??DataTable4_1  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000000
        LDR.N    R1,??DataTable4_1  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  145   
//  146   if(RTC->SR & RTC_SR_TIF_MASK)
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??LPLD_RTC_IsRunning_0
//  147   {
//  148     request = 0;
        MOVS     R0,#+0
        B.N      ??LPLD_RTC_IsRunning_1
//  149   }
//  150   else
//  151   {
//  152     request = 1;
??LPLD_RTC_IsRunning_0:
        MOVS     R0,#+1
//  153   }
//  154   return request;
??LPLD_RTC_IsRunning_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  155 }
//  156 
//  157 /*
//  158  * RTC中断处理函数
//  159  * 与启动文件startup_K60.s中的中断向量表关联
//  160  * 用户无需修改，程序自动进入对应通道中断函数
//  161  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  162 void RTC_IRQHandler(void)
//  163 {
RTC_IRQHandler:
        PUSH     {R7,LR}
//  164 #if (UCOS_II > 0u)
//  165   OS_CPU_SR  cpu_sr = 0u;
//  166   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  167   OSIntEnter();
//  168   OS_EXIT_CRITICAL();
//  169 #endif
//  170   
//  171   if((RTC->SR & RTC_SR_TIF_MASK)== 0x01)
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??RTC_IRQHandler_0
//  172   {
//  173     //调用用户自定义中断服务
//  174     RTC_ISR[0](); 
        LDR.N    R0,??DataTable4_4
        LDR      R0,[R0, #+0]
        BLX      R0
//  175     //清除中断标志位
//  176     RTC->SR |= RTC_SR_TIF_MASK;
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_8  ;; 0x4003d014
        STR      R0,[R1, #+0]
        B.N      ??RTC_IRQHandler_1
//  177     
//  178   }	
//  179   else if((RTC->SR & RTC_SR_TOF_MASK) == 0x02)
??RTC_IRQHandler_0:
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??RTC_IRQHandler_2
//  180   {
//  181     //调用用户自定义中断服务
//  182     RTC_ISR[1]();  
        LDR.N    R0,??DataTable4_4
        LDR      R0,[R0, #+4]
        BLX      R0
//  183     //清除中断标志位
//  184     RTC->SR |= RTC_SR_TOF_MASK;
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable4_8  ;; 0x4003d014
        STR      R0,[R1, #+0]
        B.N      ??RTC_IRQHandler_1
//  185   }	 	
//  186   else if((RTC->SR & RTC_SR_TAF_MASK) == 0x04)
??RTC_IRQHandler_2:
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??RTC_IRQHandler_1
//  187   {
//  188     //调用用户自定义中断服务
//  189     RTC_ISR[2]();  
        LDR.N    R0,??DataTable4_4
        LDR      R0,[R0, #+8]
        BLX      R0
//  190     //清除中断标志位
//  191     RTC->SR |= RTC_SR_TAF_MASK;
        LDR.N    R0,??DataTable4_8  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable4_8  ;; 0x4003d014
        STR      R0,[R1, #+0]
//  192   }	
//  193   
//  194 #if (UCOS_II > 0u)
//  195   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  196 #endif
//  197 }
??RTC_IRQHandler_1:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x4003d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x4003d01c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     RTC_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x4003d00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x4003d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     0x4003d008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     0x4003d014

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
//  12 bytes in section .bss
// 422 bytes in section .text
// 
// 422 bytes of CODE memory
//  12 bytes of DATA memory
//
//Errors: none
//Warnings: none
