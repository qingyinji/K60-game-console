///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:36
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_TSI.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_TSI.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\HW_TSI.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC LPLD_TSI_Deinit
        PUBLIC LPLD_TSI_Init
        PUBLIC LPLD_TSI_IsChxTouched
        PUBLIC TSI_CNTR
        PUBLIC TSI_ChxBaseVal
        PUBLIC TSI_IRQHandler
        PUBLIC TSI_ISR
        PUBLIC TSI_PORT

// D:\2019.IAR\lib\LPLD\HW\HW_TSI.c
//    1 /**
//    2  * @file HW_TSI.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief TSI底层模块相关函数
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
//   24 #include "HW_TSI.h"
//   25 
//   26 
//   27 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   28 TSI_ISR_CALLBACK TSI_ISR[2];
TSI_ISR:
        DS8 8
//   29 
//   30 //通道基准值

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   31 uint16 TSI_ChxBaseVal[16];
TSI_ChxBaseVal:
        DS8 32
//   32 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   33 const uint16* TSI_CNTR[16]={(uint16*)&TSI0->CNTR1, (uint16*)(&TSI0->CNTR1)+1,
TSI_CNTR:
        DATA
        DC32 40045100H, 40045102H, 40045104H, 40045106H, 40045108H, 4004510AH
        DC32 4004510CH, 4004510EH, 40045110H, 40045112H, 40045114H, 40045116H
        DC32 40045118H, 4004511AH, 4004511CH, 4004511EH
//   34                             (uint16*)&TSI0->CNTR3, (uint16*)(&TSI0->CNTR3)+1,
//   35                             (uint16*)&TSI0->CNTR5, (uint16*)(&TSI0->CNTR5)+1,
//   36                             (uint16*)&TSI0->CNTR7, (uint16*)(&TSI0->CNTR7)+1,
//   37                             (uint16*)&TSI0->CNTR9, (uint16*)(&TSI0->CNTR9)+1,
//   38                             (uint16*)&TSI0->CNTR11, (uint16*)(&TSI0->CNTR11)+1,
//   39                             (uint16*)&TSI0->CNTR13, (uint16*)(&TSI0->CNTR13)+1,
//   40                             (uint16*)&TSI0->CNTR15, (uint16*)(&TSI0->CNTR15)+1}; 
//   41  

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   42 const uint32* TSI_PORT[32]={(uint32*)&PORTB->PCR[0], (uint32*)&PORTA->PCR[0], (uint32*)&PORTA->PCR[1], (uint32*)&PORTA->PCR[2],
TSI_PORT:
        DATA
        DC32 4004A000H, 40049000H, 40049004H, 40049008H, 4004900CH, 40049010H
        DC32 4004A004H, 4004A008H, 4004A00CH, 4004A040H, 4004A044H, 4004A048H
        DC32 4004A04CH, 4004B000H, 4004B004H, 4004B008H
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   43                             (uint32*)&PORTA->PCR[3], (uint32*)&PORTA->PCR[4], (uint32*)&PORTB->PCR[1], (uint32*)&PORTB->PCR[2], 
//   44                             (uint32*)&PORTB->PCR[3], (uint32*)&PORTB->PCR[16], (uint32*)&PORTB->PCR[17], (uint32*)&PORTB->PCR[18], 
//   45                             (uint32*)&PORTB->PCR[19], (uint32*)&PORTC->PCR[0], (uint32*)&PORTC->PCR[1], (uint32*)&PORTC->PCR[2]};
//   46 
//   47 /*
//   48  * LPLD_TSI_Init
//   49  * TSI通用初始化函数
//   50  * 
//   51  * 参数:
//   52  *    tsi_init_struct--TSI初始化结构体，
//   53  *                        具体定义见TSI_InitTypeDef
//   54  *
//   55  * 输出:
//   56  *    0--配置错误
//   57  *    1--配置成功
//   58  */

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   59 uint8 LPLD_TSI_Init(TSI_InitTypeDef tsi_init_struct)
//   60 {
LPLD_TSI_Init:
        PUSH     {R0-R3}
        PUSH     {R3-R7,LR}
//   61   uint16 chs = tsi_init_struct.TSI_Chs;
        LDRH     R5,[SP, #+24]
//   62   uint8 mode = tsi_init_struct.TSI_ScanTriggerMode;
        LDRB     R4,[SP, #+26]
//   63   uint8 esor = tsi_init_struct.TSI_EndScanOrOutRangeInt;
        LDRB     R6,[SP, #+27]
//   64   boolean err = tsi_init_struct.TIS_ErrIntEnable;
        LDRB     R7,[SP, #+28]
//   65    
//   66   //参数检查
//   67   ASSERT( chs != 0);                  //判断通道
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BNE.N    ??LPLD_TSI_Init_0
        MOVS     R1,#+67
        LDR.N    R0,??DataTable4_1
        BL       assert_failed
//   68   ASSERT( mode <= TSI_SCAN_PERIOD);   //判断中断模式
??LPLD_TSI_Init_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BLT.N    ??LPLD_TSI_Init_1
        MOVS     R1,#+68
        LDR.N    R0,??DataTable4_1
        BL       assert_failed
//   69   ASSERT( esor <= TSI_ENDOFDCAN_INT);//判断中断模式
??LPLD_TSI_Init_1:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BLT.N    ??LPLD_TSI_Init_2
        MOVS     R1,#+69
        LDR.N    R0,??DataTable4_1
        BL       assert_failed
//   70   
//   71   //开启TSI模块时钟
//   72   SIM->SCGC5 |= (SIM_SCGC5_TSI_MASK); 
??LPLD_TSI_Init_2:
        LDR.N    R0,??DataTable4_2  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable4_2  ;; 0x40048038
        STR      R0,[R1, #+0]
//   73   
//   74   //这里使能相关通道的引脚复用功能
//   75   for(uint8 i=0; i<16; i++)
        MOVS     R0,#+0
        B.N      ??LPLD_TSI_Init_3
//   76   {
//   77     if((chs>>i)&0x1L)
??LPLD_TSI_Init_4:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ASRS     R1,R5,R0
        LSLS     R1,R1,#+31
        BPL.N    ??LPLD_TSI_Init_5
//   78     {
//   79       *((uint32 *)TSI_PORT) = PORT_PCR_MUX(0); 
        MOVS     R1,#+0
        LDR.N    R2,??DataTable4_3
        STR      R1,[R2, #+0]
//   80     }
//   81   }
??LPLD_TSI_Init_5:
        ADDS     R0,R0,#+1
??LPLD_TSI_Init_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+16
        BLT.N    ??LPLD_TSI_Init_4
//   82   
//   83   //配置通用控制寄存器
//   84   TSI0->GENCS = ((TSI_GENCS_NSCN(10))  //每个电极每次扫描(10)次、
//   85                   |(TSI_GENCS_PS(3)));  //电极晶振(2^3)分频
        MOVS     R0,#+5439488
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//   86   //配置扫描寄存器
//   87   TSI0->SCANC = ((TSI_SCANC_EXTCHRG(3))        //0.8pF内部参考电容
//   88                   |(TSI_SCANC_REFCHRG(31))      //32uA充电电流
//   89                   |(TSI_SCANC_DELVOL(7))        //600mV间隔电压
//   90                   |(TSI_SCANC_SMOD(0))          //扫描周期mod
//   91                   |(TSI_SCANC_AMPSC(0)));       //输入时钟(2^0)分频
        LDR.N    R0,??DataTable4_5  ;; 0xf81f0000
        LDR.N    R1,??DataTable4_6  ;; 0x40045004
        STR      R0,[R1, #+0]
//   92   //使能通道
//   93   TSI0->PEN = chs;
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LDR.N    R0,??DataTable4_7  ;; 0x40045008
        STR      R5,[R0, #+0]
//   94   
//   95   //使能相关中断
//   96   //TSI_ENDOFDCAN_INT和TSI_OUTOFRANGE_INT只能选择其一
//   97   if(tsi_init_struct.TSI_EndScanIsr!=NULL && esor==TSI_ENDOFDCAN_INT)
        LDR      R0,[SP, #+32]
        CMP      R0,#+0
        BEQ.N    ??LPLD_TSI_Init_6
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??LPLD_TSI_Init_6
//   98   {
//   99     TSI0->GENCS |= TSI_GENCS_ESOR_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  100     TSI_ISR[0] = tsi_init_struct.TSI_EndScanIsr;
        LDR      R0,[SP, #+32]
        LDR.N    R1,??DataTable4_8
        STR      R0,[R1, #+0]
//  101     TSI0->GENCS |= TSI_GENCS_TSIIE_MASK;   
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_TSI_Init_7
//  102   }
//  103   else if(tsi_init_struct.TSI_OutRangeIsr!=NULL && esor==TSI_OUTOFRANGE_INT)
??LPLD_TSI_Init_6:
        LDR      R0,[SP, #+36]
        CMP      R0,#+0
        BEQ.N    ??LPLD_TSI_Init_7
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??LPLD_TSI_Init_7
//  104   {
//  105     TSI0->GENCS &= ~(TSI_GENCS_ESOR_MASK);
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x10
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  106     TSI_ISR[0] = tsi_init_struct.TSI_OutRangeIsr;
        LDR      R0,[SP, #+36]
        LDR.N    R1,??DataTable4_8
        STR      R0,[R1, #+0]
//  107     TSI0->GENCS |= TSI_GENCS_TSIIE_MASK;  
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  108   }
//  109   if(tsi_init_struct.TSI_ErrIsr!=NULL && err==TRUE)
??LPLD_TSI_Init_7:
        LDR      R0,[SP, #+40]
        CMP      R0,#+0
        BEQ.N    ??LPLD_TSI_Init_8
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+1
        BNE.N    ??LPLD_TSI_Init_8
//  110   {
//  111     TSI0->GENCS |= TSI_GENCS_ERIE_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  112     TSI_ISR[1] = tsi_init_struct.TSI_EndScanIsr;
        LDR      R0,[SP, #+32]
        LDR.N    R1,??DataTable4_8
        STR      R0,[R1, #+4]
//  113     TSI0->GENCS |= TSI_GENCS_TSIIE_MASK;  
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  114   }
//  115     
//  116   //使能TSI模块  
//  117   TSI0->GENCS |= (TSI_GENCS_TSIEN_MASK); 
??LPLD_TSI_Init_8:
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  118  
//  119   //是否进行基准值校验
//  120   if(tsi_init_struct.TSI_IsInitSelfCal == TRUE)
        LDRB     R0,[SP, #+44]
        CMP      R0,#+1
        BNE.N    ??LPLD_TSI_Init_9
//  121   {
//  122     //使能软件触发
//  123     TSI0->GENCS |= TSI_GENCS_SWTS_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  124     //等待扫描结束
//  125     while(!(TSI0->GENCS&TSI_GENCS_EOSF_MASK)){};
??LPLD_TSI_Init_10:
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+16
        BPL.N    ??LPLD_TSI_Init_10
//  126     for(uint16 i=0; i<5000; i++)
        MOVS     R0,#+0
        B.N      ??LPLD_TSI_Init_11
//  127     {
//  128       for(uint8 j=0; j<200; j++)
//  129       {
//  130         asm("NOP");
??LPLD_TSI_Init_12:
        NOP
//  131       }
        ADDS     R1,R1,#+1
??LPLD_TSI_Init_13:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+200
        BLT.N    ??LPLD_TSI_Init_12
        ADDS     R0,R0,#+1
??LPLD_TSI_Init_11:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVW     R1,#+5000
        CMP      R0,R1
        BGE.N    ??LPLD_TSI_Init_14
        MOVS     R1,#+0
        B.N      ??LPLD_TSI_Init_13
//  132     }
//  133     //填充基准值数组、阈值寄存器
//  134     for(uint8 i=0; i<16; i++)
??LPLD_TSI_Init_14:
        MOVS     R0,#+0
??LPLD_TSI_Init_15:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+16
        BGE.N    ??LPLD_TSI_Init_16
//  135     {
//  136       if((chs>>i)&0x1L)
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ASRS     R1,R5,R0
        LSLS     R1,R1,#+31
        BPL.N    ??LPLD_TSI_Init_17
//  137       {
//  138         TSI_ChxBaseVal[i] = *((uint16 *)TSI_CNTR[i]);
        LDR.N    R1,??DataTable4_9
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R1,[R1, R0, LSL #+2]
        LDRH     R1,[R1, #+0]
        LDR.N    R2,??DataTable4_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRH     R1,[R2, R0, LSL #+1]
//  139         TSI0->THRESHLD[i] = TSI_ChxBaseVal[i] + TSI_OVERRUN_VAL;
        LDR.N    R1,??DataTable4_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRH     R1,[R1, R0, LSL #+1]
        ADDS     R1,R1,#+196608
        LDR.N    R2,??DataTable4_11  ;; 0x40045120
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R1,[R2, R0, LSL #+2]
//  140       }
//  141     }
??LPLD_TSI_Init_17:
        ADDS     R0,R0,#+1
        B.N      ??LPLD_TSI_Init_15
//  142   }
//  143   else
//  144   {
//  145     for(uint8 i=0; i<16; i++)
??LPLD_TSI_Init_9:
        MOVS     R0,#+0
        B.N      ??LPLD_TSI_Init_18
//  146     {
//  147       TSI_ChxBaseVal[i] = TSI_BASE_VAL;
??LPLD_TSI_Init_19:
        MOV      R1,#+2048
        LDR.N    R2,??DataTable4_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRH     R1,[R2, R0, LSL #+1]
//  148     }
        ADDS     R0,R0,#+1
??LPLD_TSI_Init_18:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+16
        BLT.N    ??LPLD_TSI_Init_19
//  149   }
//  150   
//  151   //周期扫描模式or软件触发模式
//  152   if(mode == TSI_SCAN_PERIOD)
??LPLD_TSI_Init_16:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_TSI_Init_20
//  153   {
//  154     TSI0->GENCS |= TSI_GENCS_STM_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_TSI_Init_21
//  155   }
//  156   else
//  157   {
//  158     TSI0->GENCS &= ~(TSI_GENCS_STM_MASK);
??LPLD_TSI_Init_20:
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x2
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  159   }
//  160   
//  161   return 1;
??LPLD_TSI_Init_21:
        MOVS     R0,#+1
        POP      {R1,R4-R7}
        LDR      PC,[SP], #+20    ;; return
//  162 }
//  163 
//  164 /*
//  165  * LPLD_TSI_Deinit
//  166  * TSI反初始化函数
//  167  * 
//  168  * 参数:
//  169  *    无
//  170  *
//  171  * 输出:
//  172  *    无
//  173  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  174 void LPLD_TSI_Deinit(void)
//  175 {
LPLD_TSI_Deinit:
        PUSH     {R7,LR}
//  176   LPLD_TSI_DisableIrq();
        MOVS     R0,#+83
        BL       NVIC_DisableIRQ
//  177   TSI0->STATUS = 0xFFFFFFFF;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable4_12  ;; 0x4004500c
        STR      R0,[R1, #+0]
//  178   TSI0->PEN = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_7  ;; 0x40045008
        STR      R0,[R1, #+0]
//  179   TSI0->SCANC = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_6  ;; 0x40045004
        STR      R0,[R1, #+0]
//  180   TSI0->GENCS = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  181   //关闭TSI模块时钟
//  182   SIM->SCGC5 &= ~(SIM_SCGC5_TSI_MASK); 
        LDR.N    R0,??DataTable4_2  ;; 0x40048038
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x20
        LDR.N    R1,??DataTable4_2  ;; 0x40048038
        STR      R0,[R1, #+0]
//  183 }
        POP      {R0,PC}          ;; return
//  184 
//  185 /*
//  186  * LPLD_TSI_IsChxTouched
//  187  * 通道x的电极是否被触摸
//  188  * 
//  189  * 参数:
//  190  *    ch_num--通道x的数字
//  191  *      |_0~15
//  192  *
//  193  * 输出:
//  194  *    TRUE-有触摸
//  195  *    FALSE-未触摸
//  196  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  197 boolean LPLD_TSI_IsChxTouched(uint8 ch_num)
//  198 { 
//  199   if(TSI_ChxBaseVal[ch_num]<*((uint16 *)TSI_CNTR[ch_num]))
LPLD_TSI_IsChxTouched:
        LDR.N    R1,??DataTable4_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.N    R2,??DataTable4_9
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R0,[R2, R0, LSL #+2]
        LDRH     R0,[R0, #+0]
        CMP      R1,R0
        BCS.N    ??LPLD_TSI_IsChxTouched_0
//  200     return TRUE;
        MOVS     R0,#+1
        B.N      ??LPLD_TSI_IsChxTouched_1
//  201   return FALSE;
??LPLD_TSI_IsChxTouched_0:
        MOVS     R0,#+0
??LPLD_TSI_IsChxTouched_1:
        BX       LR               ;; return
//  202 }
//  203 
//  204 /*
//  205  * TSI中断处理函数
//  206  * 与启动文件startup_K60.s中的中断向量表关联
//  207  * 用户无需修改，程序自动进入对应通道中断函数
//  208  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  209 void TSI_IRQHandler(void)
//  210 {
TSI_IRQHandler:
        PUSH     {R7,LR}
//  211 #if (UCOS_II > 0u)
//  212   OS_CPU_SR  cpu_sr = 0u;
//  213   OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
//  214   OSIntEnter();
//  215   OS_EXIT_CRITICAL();
//  216 #endif
//  217   
//  218   if(TSI0->GENCS&(TSI_GENCS_ESOR_MASK|TSI_GENCS_EOSF_MASK) &&
//  219      TSI_ISR[0] != NULL)
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        MOVW     R1,#+32784
        TST      R0,R1
        BEQ.N    ??TSI_IRQHandler_0
        LDR.N    R0,??DataTable4_8
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??TSI_IRQHandler_0
//  220   {
//  221     TSI_ISR[0]();
        LDR.N    R0,??DataTable4_8
        LDR      R0,[R0, #+0]
        BLX      R0
//  222     TSI0->GENCS |= TSI_GENCS_OUTRGF_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  223     TSI0->GENCS |= TSI_GENCS_EOSF_MASK;
        LDR.N    R0,??DataTable4_4  ;; 0x40045000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000
        LDR.N    R1,??DataTable4_4  ;; 0x40045000
        STR      R0,[R1, #+0]
//  224     TSI0->STATUS = 0x0000FFFF;
        MOVW     R0,#+65535
        LDR.N    R1,??DataTable4_12  ;; 0x4004500c
        STR      R0,[R1, #+0]
        B.N      ??TSI_IRQHandler_1
//  225   }
//  226   else if(TSI0->STATUS != 0 && TSI_ISR[1] != NULL)
??TSI_IRQHandler_0:
        LDR.N    R0,??DataTable4_12  ;; 0x4004500c
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??TSI_IRQHandler_1
        LDR.N    R0,??DataTable4_8
        LDR      R0,[R0, #+4]
        CMP      R0,#+0
        BEQ.N    ??TSI_IRQHandler_1
//  227   {
//  228     TSI_ISR[1]();
        LDR.N    R0,??DataTable4_8
        LDR      R0,[R0, #+4]
        BLX      R0
//  229     TSI0->STATUS = 0xFFFF0000;
        LDR.N    R0,??DataTable4_13  ;; 0xffff0000
        LDR.N    R1,??DataTable4_12  ;; 0x4004500c
        STR      R0,[R1, #+0]
//  230   }
//  231     
//  232 #if (UCOS_II > 0u)
//  233   OSIntExit();          //告知系统此时即将离开中断服务子函数
//  234 #endif
//  235 }
??TSI_IRQHandler_1:
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
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x40048038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     TSI_PORT

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x40045000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0xf81f0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x40045004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     0x40045008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     TSI_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     TSI_CNTR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     TSI_ChxBaseVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_11:
        DC32     0x40045120

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_12:
        DC32     0x4004500c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_13:
        DC32     0xffff0000

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
        DC8 "D:\\2019.IAR\\lib\\LPLD\\HW\\HW_TSI.c"
        DC8 0, 0, 0

        END
// 
//  40 bytes in section .bss
// 192 bytes in section .data
//  36 bytes in section .rodata
// 690 bytes in section .text
// 
// 690 bytes of CODE  memory
//  36 bytes of CONST memory
// 232 bytes of DATA  memory
//
//Errors: none
//Warnings: none
