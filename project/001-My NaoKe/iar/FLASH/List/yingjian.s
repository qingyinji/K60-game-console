///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       14/May/2019  18:35:41
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\yingjian.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\yingjian.c" -D LPLD_K60 -lCN
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
//    List file    =  
//        D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\yingjian.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_CLS
        EXTERN LCD_P6x8Str
        EXTERN LCD_P8x16Str
        EXTERN LPLD_ADC_Chn_Enable
        EXTERN LPLD_ADC_Get
        EXTERN LPLD_ADC_Init
        EXTERN LPLD_DAC_Init
        EXTERN LPLD_FTM_Init
        EXTERN LPLD_FTM_PWM_ChangeDuty
        EXTERN LPLD_FTM_PWM_Enable
        EXTERN LPLD_GPIO_EnableIrq
        EXTERN LPLD_GPIO_Init
        EXTERN LPLD_PIT_EnableIrq
        EXTERN LPLD_PIT_Init
        EXTERN LPLD_SPI_Deinit
        EXTERN LPLD_SPI_EnableIrq
        EXTERN LPLD_SPI_Init
        EXTERN __aeabi_memcpy4
        EXTERN badapple_time
        EXTERN biaozhi
        EXTERN board
        EXTERN board_scan
        EXTERN chess_board1
        EXTERN cit
        EXTERN codn_x
        EXTERN codn_y
        EXTERN counter
        EXTERN ct
        EXTERN curCordBlink
        EXTERN djm
        EXTERN flag
        EXTERN flag1
        EXTERN flag2
        EXTERN gameing
        EXTERN gameover
        EXTERN gameovertxz
        EXTERN gamestart
        EXTERN jmms
        EXTERN key_down
        EXTERN key_left
        EXTERN key_right
        EXTERN key_up
        EXTERN memset
        EXTERN mine
        EXTERN mosixuanzi
        EXTERN panduan
        EXTERN player
        EXTERN result
        EXTERN result1
        EXTERN rou
        EXTERN show_win
        EXTERN time
        EXTERN timeflag
        EXTERN wj_wzq
        EXTERN x
        EXTERN xuanzhetx
        EXTERN y

        PUBLIC SPI_Init
        PUBLIC adc_init
        PUBLIC adc_init_struct
        PUBLIC dac_init
        PUBLIC dac_init_struct
        PUBLIC delay
        PUBLIC delay_us
        PUBLIC ftm_init_struct
        PUBLIC gpio_init_struct
        PUBLIC init_gpio
        PUBLIC key
        PUBLIC pit0_init_struct
        PUBLIC pit1_init_struct
        PUBLIC pit_init
        PUBLIC pit_n
        PUBLIC pit_time
        PUBLIC pit_time0
        PUBLIC playmusic
        PUBLIC portb_isr
        PUBLIC pwm_init
        PUBLIC round

// D:\2019.IAR\project\001-My NaoKe\app\yingjian.c
//    1 #include "common.h"
//    2 #include "wuziqi.h"
//    3 #include "LQ12864.h"
//    4 #include "yingjian.h"
//    5 #include "saolei.h"
//    6 #include "jianmian.h"
//    7 #define rows 8
//    8 #define cols 8
//    9 #define Count 10

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   10 GPIO_InitTypeDef gpio_init_struct;//变量声明
gpio_init_struct:
        DS8 20

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   11 ADC_InitTypeDef adc_init_struct;
adc_init_struct:
        DS8 20

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   12 PIT_InitTypeDef pit0_init_struct;
pit0_init_struct:
        DS8 20

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   13 PIT_InitTypeDef pit1_init_struct;
pit1_init_struct:
        DS8 20

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 FTM_InitTypeDef ftm_init_struct;
ftm_init_struct:
        DS8 28

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 DAC_InitTypeDef dac_init_struct;
dac_init_struct:
        DS8 28
//   16 
//   17 extern uint16 result,result1;//储存ADC模块的采集数据
//   18 extern uint16 key_up,key_down,key_left,key_right;
//   19 extern uint16 flag;//返回
//   20 extern uint16 flag1,flag2;
//   21 extern uint16 time;
//   22 extern uint16 timeflag;
//   23 extern uint16 gameover;
//   24 extern uint16 mosixuanzi;
//   25 extern uint16 cit,x,y,ct,biaozhi;
//   26 extern uint16 counter;
//   27 extern unsigned char mine[rows][cols];
//   28 extern uint16 gamestart,gameing,gameovertxz;
//   29 extern uint8 board[8][8];
//   30 extern int8 codn_x,codn_y,rou,player;
//   31 extern uint8 wj_wzq;
//   32 extern uint8 djm,jmms,badapple_time;
//   33 extern uint16 xuanzhetx;

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   34 unsigned char round[]="round:00";
round:
        DATA
        DC8 "round:00"
        DC8 0, 0, 0

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   35 uint16 pit_n=0;
pit_n:
        DS8 2
//   36 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 void key(void){
key:
        PUSH     {R7,LR}
//   38 result = LPLD_ADC_Get(ADC0, DAD1);//获得数字量
        MOVS     R1,#+1
        LDR.W    R0,??DataTable10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        LDR.W    R1,??DataTable10_1
        STRH     R0,[R1, #+0]
//   39 result1 = LPLD_ADC_Get(ADC0, DAD3);
        MOVS     R1,#+3
        LDR.W    R0,??DataTable10  ;; 0x4003b000
        BL       LPLD_ADC_Get
        LDR.W    R1,??DataTable10_2
        STRH     R0,[R1, #+0]
//   40 if(result<1000){
        LDR.W    R0,??DataTable10_1
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1000
        BGE.N    ??key_0
//   41   key_left=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_3
        STRH     R0,[R1, #+0]
//   42   key_right=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_4
        STRH     R0,[R1, #+0]
        B.N      ??key_1
//   43 }
//   44 else if(result>3000){
??key_0:
        LDR.W    R0,??DataTable10_1
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+3001
        CMP      R0,R1
        BLT.N    ??key_2
//   45   key_left=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_3
        STRH     R0,[R1, #+0]
//   46   key_right=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_4
        STRH     R0,[R1, #+0]
        B.N      ??key_1
//   47 }
//   48 else{
//   49   key_left=1;
??key_2:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_3
        STRH     R0,[R1, #+0]
//   50   key_right=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_4
        STRH     R0,[R1, #+0]
//   51 }
//   52 if(result1<1000){
??key_1:
        LDR.W    R0,??DataTable10_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1000
        BGE.N    ??key_3
//   53   key_down=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_5
        STRH     R0,[R1, #+0]
//   54   key_up=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_6
        STRH     R0,[R1, #+0]
        B.N      ??key_4
//   55 }
//   56 else if(result1>3000){
??key_3:
        LDR.W    R0,??DataTable10_2
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+3001
        CMP      R0,R1
        BLT.N    ??key_5
//   57   key_down=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_5
        STRH     R0,[R1, #+0]
//   58   key_up=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_6
        STRH     R0,[R1, #+0]
        B.N      ??key_4
//   59 }
//   60 else{
//   61   key_up=1;
??key_5:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_6
        STRH     R0,[R1, #+0]
//   62   key_down=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_5
        STRH     R0,[R1, #+0]
//   63 }
//   64 delay(100);
??key_4:
        MOVS     R0,#+100
        BL       delay
//   65 }
        POP      {R0,PC}          ;; return
//   66 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 void playmusic(uint16 play){
playmusic:
        PUSH     {R7,LR}
//   68   if(play==2){
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+2
        BNE.N    ??playmusic_0
//   69     LPLD_FTM_PWM_ChangeDuty(FTM0, FTM_Ch0,30);
        MOVS     R2,#+30
        MOVS     R1,#+0
        LDR.W    R0,??DataTable10_7  ;; 0x40038000
        BL       LPLD_FTM_PWM_ChangeDuty
//   70     delay(2000);
        MOV      R0,#+2000
        BL       delay
//   71     LPLD_FTM_PWM_ChangeDuty(FTM0, FTM_Ch0,0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDR.W    R0,??DataTable10_7  ;; 0x40038000
        BL       LPLD_FTM_PWM_ChangeDuty
        B.N      ??playmusic_1
//   72   }
//   73   else if(play==1){
??playmusic_0:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+1
        BNE.N    ??playmusic_1
//   74     LPLD_FTM_PWM_ChangeDuty(FTM0, FTM_Ch0,10000);
        MOVW     R2,#+10000
        MOVS     R1,#+0
        LDR.W    R0,??DataTable10_7  ;; 0x40038000
        BL       LPLD_FTM_PWM_ChangeDuty
//   75     delay(2000);
        MOV      R0,#+2000
        BL       delay
//   76     LPLD_FTM_PWM_ChangeDuty(FTM0, FTM_Ch0,0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDR.W    R0,??DataTable10_7  ;; 0x40038000
        BL       LPLD_FTM_PWM_ChangeDuty
//   77   }
//   78 }
??playmusic_1:
        POP      {R0,PC}          ;; return
//   79 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   80 void init_gpio(void){   //配置gpio口
init_gpio:
        PUSH     {R7,LR}
//   81   gpio_init_struct.GPIO_PTx = PTD;
        LDR.W    R0,??DataTable10_8  ;; 0x400ff0c0
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+0]
//   82   gpio_init_struct.GPIO_Pins = GPIO_Pin0|GPIO_Pin1|GPIO_Pin2|GPIO_Pin3;
        MOVS     R0,#+15
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+4]
//   83   gpio_init_struct.GPIO_Dir = DIR_OUTPUT;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_9
        STRB     R0,[R1, #+12]
//   84   gpio_init_struct.GPIO_Output = OUTPUT_H;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_9
        STRB     R0,[R1, #+13]
//   85   gpio_init_struct.GPIO_PinControl = IRQC_DIS;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+8]
//   86   LPLD_GPIO_Init(gpio_init_struct);
        LDR.W    R1,??DataTable10_9
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_GPIO_Init
//   87 
//   88   gpio_init_struct.GPIO_PTx = PTD;
        LDR.W    R0,??DataTable10_8  ;; 0x400ff0c0
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+0]
//   89   gpio_init_struct.GPIO_Pins = GPIO_Pin4;
        MOVS     R0,#+16
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+4]
//   90   gpio_init_struct.GPIO_Dir = DIR_OUTPUT;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_9
        STRB     R0,[R1, #+12]
//   91   gpio_init_struct.GPIO_Output = OUTPUT_L;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_9
        STRB     R0,[R1, #+13]
//   92   gpio_init_struct.GPIO_PinControl = IRQC_DIS;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+8]
//   93   LPLD_GPIO_Init(gpio_init_struct);
        LDR.W    R1,??DataTable10_9
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_GPIO_Init
//   94   // 配置 PTD5为GPIO功能,输入,内部上拉，上升沿产生中断
//   95   gpio_init_struct.GPIO_PTx = PTD;
        LDR.W    R0,??DataTable10_8  ;; 0x400ff0c0
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+0]
//   96   gpio_init_struct.GPIO_Pins = GPIO_Pin5|GPIO_Pin6;     //引脚5/6或运算置一//与运算置零（PDD=PDD&~（pin7|pin8））
        MOVS     R0,#+96
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+4]
//   97   gpio_init_struct.GPIO_Dir = DIR_INPUT;        //输入
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_9
        STRB     R0,[R1, #+12]
//   98   gpio_init_struct.GPIO_PinControl = INPUT_PULL_UP|IRQC_FA;     //内部上拉|上升沿中断
        LDR.W    R0,??DataTable10_10  ;; 0xa0003
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+8]
//   99   gpio_init_struct.GPIO_Isr = portb_isr;        //中断函数
        ADR.W    R0,portb_isr
        LDR.W    R1,??DataTable10_9
        STR      R0,[R1, #+16]
//  100   LPLD_GPIO_Init(gpio_init_struct);
        LDR.W    R1,??DataTable10_9
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_GPIO_Init
//  101   //使能中断
//  102   LPLD_GPIO_EnableIrq(gpio_init_struct);
        LDR.W    R1,??DataTable10_9
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_GPIO_EnableIrq
//  103 
//  104   /* gpio_init_struct.GPIO_PTx = PTC;      //PORTC
//  105   gpio_init_struct.GPIO_Pins = GPIO_Pin0;
//  106   gpio_init_struct.GPIO_Dir = DIR_INPUT;        //输入
//  107   gpio_init_struct.GPIO_PinControl = INPUT_PULL_UP|IRQC_DIS;     //内部上拉|不产生中断
//  108   LPLD_GPIO_Init(gpio_init_struct);
//  109 
//  110   gpio_init_struct.GPIO_PTx = PTC;
//  111   gpio_init_struct.GPIO_Pins = GPIO_Pin1|GPIO_Pin2|GPIO_Pin3;
//  112   gpio_init_struct.GPIO_Dir = DIR_OUTPUT;
//  113   gpio_init_struct.GPIO_Output = OUTPUT_H;
//  114   LPLD_GPIO_Init(gpio_init_struct); */
//  115 }
        POP      {R0,PC}          ;; return
//  116 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  117 void adc_init(void){//配置ADC采样参数
adc_init:
        PUSH     {R7,LR}
//  118   adc_init_struct.ADC_Adcx = ADC0;
        LDR.W    R0,??DataTable10  ;; 0x4003b000
        LDR.W    R1,??DataTable10_11
        STR      R0,[R1, #+0]
//  119   adc_init_struct.ADC_DiffMode = ADC_SE;        //单端采集
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+4]
//  120   adc_init_struct.ADC_BitMode = SE_12BIT;       //单端12位精度
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+5]
//  121   adc_init_struct.ADC_SampleTimeCfg = SAMTIME_SHORT;    //短采样时间
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+6]
//  122   adc_init_struct.ADC_HwAvgSel = HW_4AVG;       //4次硬件平均
        MOVS     R0,#+4
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+8]
//  123   adc_init_struct.ADC_CalEnable = TRUE; //使能初始化校验
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+11]
//  124   LPLD_ADC_Init(adc_init_struct);//初始化ADC
        LDR.W    R1,??DataTable10_11
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_ADC_Init
//  125   LPLD_ADC_Chn_Enable(ADC0, DAD1);//单端DAD1通道的引脚为(ADC0_DP1)
        MOVS     R1,#+1
        LDR.W    R0,??DataTable10  ;; 0x4003b000
        BL       LPLD_ADC_Chn_Enable
//  126   adc_init_struct.ADC_Adcx = ADC0;
        LDR.W    R0,??DataTable10  ;; 0x4003b000
        LDR.W    R1,??DataTable10_11
        STR      R0,[R1, #+0]
//  127   adc_init_struct.ADC_DiffMode = ADC_SE;        //单端采集
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+4]
//  128   adc_init_struct.ADC_BitMode = SE_12BIT;       //单端12位精度
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+5]
//  129   adc_init_struct.ADC_SampleTimeCfg = SAMTIME_SHORT;    //短采样时间
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+6]
//  130   adc_init_struct.ADC_HwAvgSel = HW_4AVG;       //4次硬件平均
        MOVS     R0,#+4
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+8]
//  131   adc_init_struct.ADC_CalEnable = TRUE; //使能初始化校验
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+11]
//  132   LPLD_ADC_Init(adc_init_struct);
        LDR.W    R1,??DataTable10_11
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_ADC_Init
//  133   LPLD_ADC_Chn_Enable(ADC0, DAD3);//单端DAD3通道的引脚为(ADC0_DP3)
        MOVS     R1,#+3
        LDR.W    R0,??DataTable10  ;; 0x4003b000
        BL       LPLD_ADC_Chn_Enable
//  134 
//  135   adc_init_struct.ADC_Adcx = ADC1;
        LDR.W    R0,??DataTable10_12  ;; 0x400bb000
        LDR.W    R1,??DataTable10_11
        STR      R0,[R1, #+0]
//  136   adc_init_struct.ADC_DiffMode = ADC_SE;        //单端采集
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+4]
//  137   adc_init_struct.ADC_BitMode = SE_12BIT;       //单端12位精度
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+5]
//  138   adc_init_struct.ADC_SampleTimeCfg = SAMTIME_SHORT;    //短采样时间
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+6]
//  139   adc_init_struct.ADC_HwAvgSel = HW_4AVG;       //4次硬件平均
        MOVS     R0,#+4
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+8]
//  140   adc_init_struct.ADC_CalEnable = TRUE; //使能初始化校验
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_11
        STRB     R0,[R1, #+11]
//  141   LPLD_ADC_Init(adc_init_struct);
        LDR.W    R1,??DataTable10_11
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_ADC_Init
//  142   LPLD_ADC_Chn_Enable(ADC1, DAD1);
        MOVS     R1,#+1
        LDR.W    R0,??DataTable10_12  ;; 0x400bb000
        BL       LPLD_ADC_Chn_Enable
//  143 
//  144   }
        POP      {R0,PC}          ;; return
//  145 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  146 void pit_init(void){//配置PIT1参数,初始化PIT1通道
pit_init:
        PUSH     {R7,LR}
//  147   pit0_init_struct.PIT_Pitx = PIT0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_13
        STRB     R0,[R1, #+0]
//  148   pit0_init_struct.PIT_PeriodMs = 50; //定时周期50毫秒
        MOVS     R0,#+50
        LDR.W    R1,??DataTable10_13
        STR      R0,[R1, #+8]
//  149   pit0_init_struct.PIT_Isr = pit_time0;  //设置中断函数
        ADR.W    R0,pit_time0
        LDR.W    R1,??DataTable10_13
        STR      R0,[R1, #+16]
//  150   LPLD_PIT_Init(pit0_init_struct);//初始化PIT0
        LDR.W    R1,??DataTable10_13
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_PIT_Init
//  151   LPLD_PIT_EnableIrq(pit0_init_struct);
        LDR.W    R1,??DataTable10_13
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_PIT_EnableIrq
//  152 
//  153   pit1_init_struct.PIT_Pitx = PIT1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_14
        STRB     R0,[R1, #+0]
//  154   pit1_init_struct.PIT_PeriodMs = 200; //定时周期200毫秒
        MOVS     R0,#+200
        LDR.W    R1,??DataTable10_14
        STR      R0,[R1, #+8]
//  155   pit1_init_struct.PIT_Isr = pit_time;  //设置中断函数
        ADR.W    R0,pit_time
        LDR.W    R1,??DataTable10_14
        STR      R0,[R1, #+16]
//  156   LPLD_PIT_Init(pit1_init_struct);//初始化PIT1
        LDR.W    R1,??DataTable10_14
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_PIT_Init
//  157   LPLD_PIT_EnableIrq(pit1_init_struct);
        LDR.W    R1,??DataTable10_14
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+20
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_PIT_EnableIrq
//  158 
//  159   }//使能PIT1
        POP      {R0,PC}          ;; return
//  160 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  161 void pwm_init(void){
pwm_init:
        PUSH     {R5-R7,LR}
//  162   ftm_init_struct.FTM_Ftmx = FTM0;  //使能FTM0通道
        LDR.W    R0,??DataTable10_7  ;; 0x40038000
        LDR.W    R1,??DataTable10_15
        STR      R0,[R1, #+0]
//  163   ftm_init_struct.FTM_Mode = FTM_MODE_PWM;  //使能PWM模式
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_15
        STRB     R0,[R1, #+4]
//  164   ftm_init_struct.FTM_PwmFreq = 50; //PWM频率50Hz
        MOVS     R0,#+50
        LDR.W    R1,??DataTable10_15
        STR      R0,[R1, #+8]
//  165   LPLD_FTM_Init(ftm_init_struct);
        LDR.W    R1,??DataTable10_15
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+28
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_FTM_Init
//  166   LPLD_FTM_PWM_Enable(FTM0, //使用FTM0
//  167                       FTM_Ch0, //使能Ch0通道
//  168                       0, //初始化角度0度
//  169                       PTC1, //使用Ch0通道的PTC1引脚
//  170                       ALIGN_LEFT        //脉宽左对齐
//  171                       );}
        MOVS     R0,#+40
        STR      R0,[SP, #+0]
        MOVS     R3,#+61
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDR.W    R0,??DataTable10_7  ;; 0x40038000
        BL       LPLD_FTM_PWM_Enable
        POP      {R0-R2,PC}       ;; return
//  172 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  173 void dac_init(void)
//  174 {
dac_init:
        PUSH     {R5-R7,LR}
//  175   //在不使用DAC缓冲区、各种中断DMA的情况下
//  176   //仅需初始化DAC通道即可
//  177   dac_init_struct.DAC_Dacx = DAC0;
        LDR.W    R0,??DataTable10_16  ;; 0x400cc000
        LDR.W    R1,??DataTable10_17
        STR      R0,[R1, #+0]
//  178   LPLD_DAC_Init(dac_init_struct);
        LDR.W    R1,??DataTable10_17
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+28
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_DAC_Init
//  179 }
        POP      {R0-R2,PC}       ;; return
//  180 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  181 void SPI_Init(uint8 spi){
SPI_Init:
        PUSH     {R4,LR}
        SUB      SP,SP,#+88
        MOVS     R4,R0
//  182   SPI_InitTypeDef spi_init_param;
//  183   //配置SPI
//  184   spi_init_param.SPI_SPIx = SPI0;
        LDR.W    R0,??DataTable10_18  ;; 0x4002c000
        STR      R0,[SP, #+36]
//  185   spi_init_param.SPI_SckDivider = SPI_SCK_DIV_64;//1.56Mhz
        MOVS     R0,#+6
        STRB     R0,[SP, #+41]
//  186   LPLD_SPI_Init(spi_init_param);
        ADD      R1,SP,#+36
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+52
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_SPI_Init
//  187   if(spi==1){
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??SPI_Init_0
//  188     LPLD_SPI_EnableIrq(spi_init_param);
        ADD      R1,SP,#+36
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+52
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_SPI_EnableIrq
        B.N      ??SPI_Init_1
//  189   }
//  190   else{
//  191     LPLD_SPI_Deinit(spi_init_param);
??SPI_Init_0:
        ADD      R1,SP,#+36
        SUB      SP,SP,#+16
        MOV      R0,SP
        MOVS     R2,#+52
        BL       __aeabi_memcpy4
        POP      {R0-R3}
        BL       LPLD_SPI_Deinit
//  192   }
//  193 }
??SPI_Init_1:
        ADD      SP,SP,#+88
        POP      {R4,PC}          ;; return
//  194 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  195 void delay(int ms){
//  196    int ii,jj;
//  197    if (ms<1) ms=1;
delay:
        CMP      R0,#+1
        BGE.N    ??delay_0
        MOVS     R0,#+1
//  198    for(ii=0;ii<ms;ii++)
??delay_0:
        MOVS     R1,#+0
        B.N      ??delay_1
//  199      for(jj=0;jj<500;jj++);}
??delay_2:
        ADDS     R2,R2,#+1
??delay_3:
        CMP      R2,#+500
        BLT.N    ??delay_2
        ADDS     R1,R1,#+1
??delay_1:
        CMP      R1,R0
        BGE.N    ??delay_4
        MOVS     R2,#+0
        B.N      ??delay_3
??delay_4:
        BX       LR               ;; return
//  200 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  201 void portb_isr(void){
portb_isr:
        PUSH     {R7,LR}
//  202   	delay(500);
        MOV      R0,#+500
        BL       delay
//  203     if(LPLD_GPIO_IsPinxExt(PORTD, GPIO_Pin5)){
        LDR.W    R0,??DataTable10_19  ;; 0x4004c0a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.W    ??portb_isr_0
//  204       if(jmms==1){
        LDR.W    R0,??DataTable10_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??portb_isr_1
//  205         djm=0;jmms=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_21
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_20
        STRB     R0,[R1, #+0]
//  206       }
//  207     if(gamestart)
??portb_isr_1:
        LDR.W    R0,??DataTable10_22
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.W    ??portb_isr_0
//  208     switch(mosixuanzi){
        LDR.W    R0,??DataTable10_23
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??portb_isr_2
        CMP      R0,#+2
        BEQ.N    ??portb_isr_3
        CMP      R0,#+3
        BEQ.N    ??portb_isr_4
        CMP      R0,#+6
        BEQ.W    ??portb_isr_5
        B.N      ??portb_isr_0
//  209       case 1:break;
??portb_isr_2:
        B.N      ??portb_isr_0
//  210       case 2:if(mine[x][y] == '1')ct=1;else {biaozhi=0;panduan(x,y);};break;
??portb_isr_3:
        LDR.W    R0,??DataTable10_24
        LDR.W    R1,??DataTable10_25
        LDRH     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+3
        LDR.W    R1,??DataTable10_26
        LDRH     R1,[R1, #+0]
        LDRB     R0,[R1, R0]
        CMP      R0,#+49
        BNE.N    ??portb_isr_6
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_27
        STRH     R0,[R1, #+0]
        B.N      ??portb_isr_7
??portb_isr_6:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_28
        STRH     R0,[R1, #+0]
        LDR.W    R0,??DataTable10_26
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable10_25
        LDRH     R0,[R0, #+0]
        BL       panduan
??portb_isr_7:
        B.N      ??portb_isr_0
//  211       case 3:if(board[codn_y][codn_x/8] == 0){
??portb_isr_4:
        LDR.W    R0,??DataTable10_29
        LDRSB    R0,[R0, #+0]
        MOVS     R1,#+8
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable10_30
        LDR.W    R2,??DataTable10_31
        LDRSB    R2,[R2, #+0]
        ADDS     R1,R1,R2, LSL #+3
        LDRB     R0,[R0, R1]
        CMP      R0,#+0
        BNE.N    ??portb_isr_8
//  212             board[codn_y][codn_x/8] = player;
        LDR.N    R0,??DataTable10_29
        LDRSB    R0,[R0, #+0]
        MOVS     R1,#+8
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable10_30
        LDR.N    R2,??DataTable10_31
        LDRSB    R2,[R2, #+0]
        ADDS     R1,R1,R2, LSL #+3
        LDR.N    R2,??DataTable10_32
        LDRB     R2,[R2, #+0]
        STRB     R2,[R0, R1]
//  213             /*pwm_init(50);                              背景音乐
//  214             LPLD_FTM_PWM_ChangeDuty(FTM0,FTM_Ch0, 5000);
//  215             delay(1000);
//  216             LPLD_FTM_PWM_ChangeDuty(FTM0,FTM_Ch0, 0);*/
//  217             if(player == 1)
        LDR.N    R0,??DataTable10_32
        LDRSB    R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??portb_isr_9
//  218             {
//  219               rou++;
        LDR.N    R0,??DataTable10_33
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable10_33
        STRB     R0,[R1, #+0]
//  220               round[6]=rou/10+48;
        LDR.N    R0,??DataTable10_33
        LDRSB    R0,[R0, #+0]
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        LDR.N    R1,??DataTable10_34
        STRB     R0,[R1, #+6]
//  221               round[7]=rou%10+48;
        LDR.N    R0,??DataTable10_33
        LDRSB    R0,[R0, #+0]
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        LDR.N    R1,??DataTable10_34
        STRB     R0,[R1, #+7]
//  222               LCD_P6x8Str(70,5,round);
        LDR.N    R2,??DataTable10_34
        MOVS     R1,#+5
        MOVS     R0,#+70
        BL       LCD_P6x8Str
//  223               player = 2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable10_32
        STRB     R0,[R1, #+0]
//  224               LCD_P8x16Str(70,3,"PLAYER2");
        LDR.N    R2,??DataTable10_35
        MOVS     R1,#+3
        MOVS     R0,#+70
        BL       LCD_P8x16Str
        B.N      ??portb_isr_10
//  225             }
//  226             else if(player == 2)
??portb_isr_9:
        LDR.N    R0,??DataTable10_32
        LDRSB    R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??portb_isr_10
//  227             {
//  228               player = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_32
        STRB     R0,[R1, #+0]
//  229               LCD_P8x16Str(70,3,"PLAYER1");
        LDR.N    R2,??DataTable10_36
        MOVS     R1,#+3
        MOVS     R0,#+70
        BL       LCD_P8x16Str
//  230             }
//  231             if(board_scan(3) == 1)
??portb_isr_10:
        MOVS     R0,#+3
        BL       board_scan
        CMP      R0,#+1
        BNE.N    ??portb_isr_8
//  232             {
//  233               show_win();
        BL       show_win
//  234             }
//  235         }break;
??portb_isr_8:
        B.N      ??portb_isr_0
//  236       case 6:if(gameing)xuanzhetx=1;
??portb_isr_5:
        LDR.N    R0,??DataTable10_37
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??portb_isr_11
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_38
        STRH     R0,[R1, #+0]
//  237     }
//  238   }
//  239   if(LPLD_GPIO_IsPinxExt(PORTD, GPIO_Pin6)){
??portb_isr_11:
??portb_isr_0:
        LDR.N    R0,??DataTable10_19  ;; 0x4004c0a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??portb_isr_12
//  240     if(mosixuanzi==1)
        LDR.N    R0,??DataTable10_23
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??portb_isr_13
//  241       if(gamestart){
        LDR.N    R0,??DataTable10_22
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??portb_isr_13
//  242         if(flag1==1)flag=0;flag1=0;if(gameover==0)flag2=1;while(PTD6_I==0);}
        LDR.N    R0,??DataTable10_39
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??portb_isr_14
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_40
        STRH     R0,[R1, #+0]
??portb_isr_14:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_39
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable10_41
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??portb_isr_15
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_42
        STRH     R0,[R1, #+0]
??portb_isr_15:
        LDR.N    R0,??DataTable10_43  ;; 0x43fe1a18
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??portb_isr_15
//  243     switch(mosixuanzi){
??portb_isr_13:
        LDR.N    R0,??DataTable10_23
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??portb_isr_16
        CMP      R0,#+2
        BEQ.N    ??portb_isr_17
        CMP      R0,#+3
        BEQ.N    ??portb_isr_18
        CMP      R0,#+4
        BEQ.N    ??portb_isr_19
        CMP      R0,#+6
        BEQ.N    ??portb_isr_20
        B.N      ??portb_isr_21
//  244       case 1:if(gamestart==1)gameovertxz=1;break;
??portb_isr_16:
        LDR.N    R0,??DataTable10_22
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??portb_isr_22
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_44
        STRH     R0,[R1, #+0]
??portb_isr_22:
        B.N      ??portb_isr_21
//  245       case 2:if(gamestart==1)gamestart=0;break;
??portb_isr_17:
        LDR.N    R0,??DataTable10_22
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??portb_isr_23
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_22
        STRH     R0,[R1, #+0]
??portb_isr_23:
        B.N      ??portb_isr_21
//  246       case 3:if(gameing==0&&gamestart==1){
??portb_isr_18:
        LDR.N    R0,??DataTable10_37
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??portb_isr_24
        LDR.N    R0,??DataTable10_22
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??portb_isr_24
//  247             LCD_CLS();
        BL       LCD_CLS
//  248             memset(board,0,sizeof(board));
        MOVS     R2,#+64
        MOVS     R1,#+0
        LDR.N    R0,??DataTable10_30
        BL       memset
//  249             gameing=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_37
        STRH     R0,[R1, #+0]
//  250             LCD_P8x16Str(70,3,"PLAYER1");
        LDR.N    R2,??DataTable10_36
        MOVS     R1,#+3
        MOVS     R0,#+70
        BL       LCD_P8x16Str
//  251             LCD_P8x16Str(4,1,"GoBang");}
        LDR.N    R2,??DataTable10_45
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       LCD_P8x16Str
        B.N      ??portb_isr_25
//  252           else
//  253              gamestart=0;
??portb_isr_24:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_22
        STRH     R0,[R1, #+0]
//  254            break;
??portb_isr_25:
        B.N      ??portb_isr_21
//  255       case 4:if(gameing==0)gamestart=0;else gameing=0;break;
??portb_isr_19:
        LDR.N    R0,??DataTable10_37
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??portb_isr_26
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_22
        STRH     R0,[R1, #+0]
        B.N      ??portb_isr_27
??portb_isr_26:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_37
        STRH     R0,[R1, #+0]
??portb_isr_27:
        B.N      ??portb_isr_21
//  256       case 6:gamestart=0;break;
??portb_isr_20:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_22
        STRH     R0,[R1, #+0]
//  257     }
//  258     if(mosixuanzi==5)
??portb_isr_21:
        LDR.N    R0,??DataTable10_23
        LDRH     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??portb_isr_12
//  259       gamestart=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_22
        STRH     R0,[R1, #+0]
//  260   }
//  261 }
??portb_isr_12:
        POP      {R0,PC}          ;; return
//  262 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  263 void pit_time0(void){
//  264   badapple_time=0;
pit_time0:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_46
        STRB     R0,[R1, #+0]
//  265 }
        BX       LR               ;; return
//  266 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  267 void pit_time(void){
pit_time:
        PUSH     {R7,LR}
//  268   if(pit_n<5)
        LDR.N    R0,??DataTable10_47
        LDRH     R0,[R0, #+0]
        CMP      R0,#+5
        BGE.N    ??pit_time_0
//  269     pit_n++;
        LDR.N    R0,??DataTable10_47
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable10_47
        STRH     R0,[R1, #+0]
        B.N      ??pit_time_1
//  270   else
//  271     pit_n=0;
??pit_time_0:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_47
        STRH     R0,[R1, #+0]
//  272 
//  273   switch(mosixuanzi){
??pit_time_1:
        LDR.N    R0,??DataTable10_23
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??pit_time_2
        BCC.N    ??pit_time_3
        CMP      R0,#+3
        BEQ.N    ??pit_time_4
        BCC.N    ??pit_time_5
        B.N      ??pit_time_3
//  274 case 1:
//  275 if(pit_n==4){
??pit_time_2:
        LDR.N    R0,??DataTable10_47
        LDRH     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??pit_time_6
//  276     if(timeflag==1){
        LDR.N    R0,??DataTable10_48
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??pit_time_6
//  277     time--;
        LDR.N    R0,??DataTable10_49
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable10_49
        STRH     R0,[R1, #+0]
//  278     if(time<=10&&gameover==0){
        LDR.N    R0,??DataTable10_49
        LDRH     R0,[R0, #+0]
        CMP      R0,#+11
        BGE.N    ??pit_time_6
        LDR.N    R0,??DataTable10_41
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??pit_time_6
//  279       playmusic(1);
        MOVS     R0,#+1
        BL       playmusic
//  280     }
//  281   }
//  282 }break;
??pit_time_6:
        B.N      ??pit_time_3
//  283 
//  284 case 2:
//  285 if(pit_n==4){
??pit_time_5:
        LDR.N    R0,??DataTable10_47
        LDRH     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??pit_time_7
//  286   if(cit==1)
        LDR.N    R0,??DataTable10_50
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??pit_time_8
//  287     counter=500;
        MOV      R0,#+500
        LDR.N    R1,??DataTable10_51
        STRH     R0,[R1, #+0]
//  288   if(cit==0)
??pit_time_8:
        LDR.N    R0,??DataTable10_50
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??pit_time_9
//  289     counter++;
        LDR.N    R0,??DataTable10_51
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable10_51
        STRH     R0,[R1, #+0]
//  290   if(cit==2)
??pit_time_9:
        LDR.N    R0,??DataTable10_50
        LDRH     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??pit_time_7
//  291     counter=counter;
        LDR.N    R0,??DataTable10_51
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable10_51
        STRH     R0,[R1, #+0]
//  292 }break;
??pit_time_7:
        B.N      ??pit_time_3
//  293 
//  294 case 3:
//  295 if(wj_wzq==1)
??pit_time_4:
        LDR.N    R0,??DataTable10_52
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??pit_time_10
//  296 if(gameing==1){
        LDR.N    R0,??DataTable10_37
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??pit_time_10
//  297   if((pit_n%2))
        LDR.N    R0,??DataTable10_47
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+2
        SDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BEQ.N    ??pit_time_11
//  298     curCordBlink();
        BL       curCordBlink
        B.N      ??pit_time_10
//  299   else
//  300     chess_board1();
??pit_time_11:
        BL       chess_board1
//  301 }
//  302 break;
//  303 }
//  304 }
??pit_time_10:
??pit_time_3:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     0x4003b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     result

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     result1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     key_left

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     key_right

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     key_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     key_up

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     0x40038000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_8:
        DC32     0x400ff0c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_9:
        DC32     gpio_init_struct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_10:
        DC32     0xa0003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_11:
        DC32     adc_init_struct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_12:
        DC32     0x400bb000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_13:
        DC32     pit0_init_struct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_14:
        DC32     pit1_init_struct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_15:
        DC32     ftm_init_struct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_16:
        DC32     0x400cc000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_17:
        DC32     dac_init_struct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_18:
        DC32     0x4002c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_19:
        DC32     0x4004c0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_20:
        DC32     jmms

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_21:
        DC32     djm

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_22:
        DC32     gamestart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_23:
        DC32     mosixuanzi

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_24:
        DC32     mine

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_25:
        DC32     x

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_26:
        DC32     y

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_27:
        DC32     ct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_28:
        DC32     biaozhi

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_29:
        DC32     codn_x

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_30:
        DC32     board

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_31:
        DC32     codn_y

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_32:
        DC32     player

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_33:
        DC32     rou

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_34:
        DC32     round

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_35:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_36:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_37:
        DC32     gameing

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_38:
        DC32     xuanzhetx

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_39:
        DC32     flag1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_40:
        DC32     flag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_41:
        DC32     gameover

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_42:
        DC32     flag2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_43:
        DC32     0x43fe1a18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_44:
        DC32     gameovertxz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_45:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_46:
        DC32     badapple_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_47:
        DC32     pit_n

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_48:
        DC32     timeflag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_49:
        DC32     time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_50:
        DC32     cit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_51:
        DC32     counter

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_52:
        DC32     wj_wzq
//  305 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  306 void delay_us(int us){
//  307    int ii;
//  308    if (us<1) us=1;
delay_us:
        CMP      R0,#+1
        BGE.N    ??delay_us_0
        MOVS     R0,#+1
//  309    for(ii=0;ii<us;ii++);}
??delay_us_0:
        MOVS     R1,#+0
        B.N      ??delay_us_1
??delay_us_2:
        ADDS     R1,R1,#+1
??delay_us_1:
        CMP      R1,R0
        BLT.N    ??delay_us_2
        BX       LR               ;; return

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
        DC8 "PLAYER2"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "PLAYER1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "GoBang"
        DC8 0

        END
// 
//   138 bytes in section .bss
//    12 bytes in section .data
//    24 bytes in section .rodata
// 2 128 bytes in section .text
// 
// 2 128 bytes of CODE  memory
//    24 bytes of CONST memory
//   150 bytes of DATA  memory
//
//Errors: none
//Warnings: none
