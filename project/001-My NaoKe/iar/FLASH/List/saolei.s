///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       14/May/2019  18:35:35
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\saolei.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\saolei.c" -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\saolei.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_CLS
        EXTERN LCD_P14x16Ch
        EXTERN LCD_P6x8Str
        EXTERN LCD_P8x16Str
        EXTERN LCD_P8x8Ch
        EXTERN LPLD_ADC_Get
        EXTERN delay
        EXTERN gameing
        EXTERN gamestart
        EXTERN key_down
        EXTERN key_left
        EXTERN key_right
        EXTERN key_up
        EXTERN pit_init
        EXTERN result
        EXTERN result1
        EXTERN sprintf

        PUBLIC Game
        PUBLIC Sweep
        PUBLIC a
        PUBLIC `b`
        PUBLIC biaozhi
        PUBLIC cit
        PUBLIC count
        PUBLIC counter
        PUBLIC ct
        PUBLIC delay1
        PUBLIC display
        PUBLIC f
        PUBLIC g
        PUBLIC gameoversl
        PUBLIC get_num
        PUBLIC k
        PUBLIC kaiguan
        PUBLIC kongzhi
        PUBLIC menu
        PUBLIC mine
        PUBLIC panduan
        PUBLIC s
        PUBLIC saolei
        PUBLIC set_mine
        PUBLIC show
        PUBLIC surrond
        PUBLIC t
        PUBLIC t1
        PUBLIC t2
        PUBLIC t3
        PUBLIC t4
        PUBLIC t5
        PUBLIC t6
        PUBLIC ti
        PUBLIC time1
        PUBLIC timesl
        PUBLIC x
        PUBLIC y

// D:\2019.IAR\project\001-My NaoKe\app\saolei.c
//    1 #include "common.h"
//    2 #include "LQ12864.h"
//    3 #include "saolei.h"
//    4 #include "yingjian.h"
//    5 #define rows 8
//    6 #define cols 8
//    7 #define Count 10
//    8 
//    9 extern uint16 result;
//   10 extern uint16 result1;
//   11 extern uint16 key_down,key_up,key_left,key_right;
//   12 extern uint16 gamestart,gameing;

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   13 uint16 gameoversl=0;
gameoversl:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   14 uint16 t1=0;
t1:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   15 uint16 t2=0;
t2:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   16 uint16 counter=0;
counter:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   17 uint16 a;
a:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   18 uint16 b;
`b`:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   19 uint16 t3=0;
t3:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   20 uint16 t4=0;
t4:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   21 uint16 t5=0;
t5:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   22 uint16 t6=0;
t6:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   23 uint16 ct=0;
ct:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24 unsigned char mine[rows][cols];
mine:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   25 unsigned  char show[rows][cols];
show:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   26 uint16 x=0;
x:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   27 uint16 y=0;
y:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   28 uint16 biaozhi=0; 
biaozhi:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   29 uint16 count = Count ;
count:
        DATA
        DC16 10

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   30 uint16 t=0;
t:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   31 uint16 ti=0;
ti:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   32 uint16 kaiguan[4]={0};
kaiguan:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   33 uint16 cit=0;
cit:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   34 uint16 k=0;
k:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   35 uint16 timesl=0;
timesl:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   36 unsigned char s[]="0";
s:
        DATA
        DC8 "0"

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   37 unsigned char f[]="0";
f:
        DATA
        DC8 "0"

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   38 unsigned char g[]="0";
g:
        DATA
        DC8 "0"
//   39 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   40 void saolei(void){
saolei:
        PUSH     {R7,LR}
//   41   gamestart=1;gameoversl=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8
        STRH     R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_1
        STRH     R0,[R1, #+0]
//   42 	uint16 i = 0;
        MOVS     R0,#+0
//   43 	uint16 j = 0;
        MOVS     R1,#+0
//   44 	for (i = 0; i < rows ; i++)
        MOVS     R2,#+0
        MOVS     R0,R2
        B.N      ??saolei_0
//   45 	{
//   46 		for (j = 0; j < cols ; j++)
//   47 		{
//   48 			mine[i][j] = '0';
??saolei_1:
        LDR.W    R2,??DataTable8_2
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+3
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R3,#+48
        STRB     R3,[R1, R2]
//   49 			show[i][j] = '*';
        LDR.W    R2,??DataTable8_3
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+3
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R3,#+42
        STRB     R3,[R1, R2]
//   50 		}
        ADDS     R1,R1,#+1
??saolei_2:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??saolei_1
        ADDS     R0,R0,#+1
??saolei_0:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??saolei_3
        MOVS     R1,#+0
        B.N      ??saolei_2
//   51 	}
//   52   menu();
??saolei_3:
        BL       menu
//   53   while(1)
//   54   {  //duqu();
//   55     gamestart=1;
??saolei_4:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8
        STRH     R0,[R1, #+0]
//   56     kaiguan[0]=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_4
        STRH     R0,[R1, #+0]
//   57 		if (kaiguan[0]==1)
        LDR.W    R0,??DataTable8_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??saolei_5
//   58 		{      if(t1==0&&t2==0){
        LDR.W    R0,??DataTable8_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??saolei_6
        LDR.W    R0,??DataTable8_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??saolei_6
//   59 	          LCD_CLS();
        BL       LCD_CLS
//   60                     pit_init();
        BL       pit_init
//   61                        delay(10);
        MOVS     R0,#+10
        BL       delay
//   62                        t2=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_6
        STRH     R0,[R1, #+0]
//   63                 }     if(cit==0)
??saolei_6:
        LDR.W    R0,??DataTable8_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??saolei_7
//   64                 {  LCD_P8x8Ch(8*x,y,0);
        MOVS     R2,#+0
        LDR.W    R0,??DataTable8_8
        LDRH     R1,[R0, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.W    R0,??DataTable8_9
        LDRH     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P8x8Ch
//   65                 }
//   66 			Game(mine,show);
??saolei_7:
        LDR.W    R1,??DataTable8_3
        LDR.W    R0,??DataTable8_2
        BL       Game
//   67 		}
//   68     if(gameoversl==1){
??saolei_5:
        LDR.W    R0,??DataTable8_1
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??saolei_4
//   69       if(gamestart==0){
        LDR.W    R0,??DataTable8
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??saolei_4
//   70         gameoversl=0;gameing=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_1
        STRH     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_10
        STRH     R0,[R1, #+0]
//   71         t1=t2=counter=t3=t4=t5=t6=ct=x=y=biaozhi=t=ti=cit=k=timesl=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_11
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_12
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_7
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_13
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_14
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_15
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_8
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_9
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_16
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_17
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_18
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_19
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_20
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_21
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_6
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable8_5
        STRH     R0,[R1, #+0]
//   72         count = Count ;
        MOVS     R0,#+10
        LDR.W    R1,??DataTable8_22
        STRH     R0,[R1, #+0]
//   73         return;
        POP      {R0,PC}          ;; return
//   74       }
//   75   } 
//   76   }   
//   77 }
//   78 
//   79 //菜单函数

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   80 uint16 menu()
//   81 {
//   82   //LCD_P128x64Ch();
//   83 	return 0;
menu:
        MOVS     R0,#+0
        BX       LR               ;; return
//   84 }
//   85 
//   86  
//   87 //设置雷的位置

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   88 void set_mine(unsigned char mine[rows][cols])
//   89 {   
set_mine:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   90 	uint16 n = 0;
        MOVS     R0,#+0
//   91 	uint16 m = 0;
        MOVS     R1,#+0
        B.N      ??set_mine_0
//   92 	while (count)
//   93 	{     delay1(20);
??set_mine_1:
        MOVS     R0,#+20
        BL       delay1
//   94           a= LPLD_ADC_Get(ADC1, DAD1)%10;
        MOVS     R1,#+1
        LDR.W    R0,??DataTable8_23  ;; 0x400bb000
        BL       LPLD_ADC_Get
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        LDR.W    R1,??DataTable8_24
        STRH     R0,[R1, #+0]
//   95              delay1(20);
        MOVS     R0,#+20
        BL       delay1
//   96                 b= LPLD_ADC_Get(ADC1, DAD1)%10;
        MOVS     R1,#+1
        LDR.W    R0,??DataTable8_23  ;; 0x400bb000
        BL       LPLD_ADC_Get
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        LDR.W    R1,??DataTable8_25
        STRH     R0,[R1, #+0]
//   97 		n = (a*8)/10;
        LDR.W    R0,??DataTable8_24
        LDRH     R0,[R0, #+0]
        LSLS     R0,R0,#+3
        MOVS     R1,#+10
        SDIV     R0,R0,R1
//   98 		m = (b*8)/10;
        LDR.W    R1,??DataTable8_25
        LDRH     R1,[R1, #+0]
        LSLS     R1,R1,#+3
        MOVS     R2,#+10
        SDIV     R1,R1,R2
//   99 		if (mine[n][m] == '0')     
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R4,R0, LSL #+3
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRB     R2,[R1, R2]
        CMP      R2,#+48
        BNE.N    ??set_mine_0
//  100 		{
//  101 			mine[n][m] = '1';
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R0,R4,R0, LSL #+3
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R2,#+49
        STRB     R2,[R1, R0]
//  102 			count--;
        LDR.W    R0,??DataTable8_22
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable8_22
        STRH     R0,[R1, #+0]
//  103 		}
//  104 	}
??set_mine_0:
        LDR.W    R0,??DataTable8_22
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??set_mine_1
//  105 }
        POP      {R4,PC}          ;; return
//  106  
//  107 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  108 void display(unsigned char show[rows][cols])  
//  109 {  
display:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
//  110 	uint16 i = 0;
        MOVS     R5,#+0
//  111 	uint16 j = 0;
        MOVS     R6,#+0
//  112  
//  113 	for (i = 0; i < rows ; i++)
        MOVS     R0,#+0
        MOVS     R5,R0
        B.N      ??display_0
//  114 	{
//  115 		for (j = 0; j <cols ; j++)
//  116 		{   	s[0]=show[i][j];
??display_1:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R4,R5, LSL #+3
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LDRB     R0,[R6, R0]
        LDR.W    R1,??DataTable8_26
        STRB     R0,[R1, #+0]
//  117 			   LCD_P6x8Str(8*i,j,s);  
        LDR.W    R2,??DataTable8_26
        MOVS     R1,R6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P6x8Str
//  118 		}
        ADDS     R6,R6,#+1
??display_2:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+8
        BLT.N    ??display_1
        ADDS     R5,R5,#+1
??display_0:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+8
        BGE.N    ??display_3
        MOVS     R6,#+0
        B.N      ??display_2
//  119 	
//  120 	}
//  121         
//  122 }
??display_3:
        POP      {R4-R6,PC}       ;; return
//  123  
//  124 //计算雷的个数

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 uint16 get_num(unsigned char mine[rows][cols], uint16 x, uint16 y) 
//  126 {  
get_num:
        PUSH     {R4}
//  127 	uint16 count = 0;
        MOVS     R3,#+0
//  128 	if (mine[x - 1][y - 1] == '1'&&(x-1)>=0&&(y-1)>=0)//左上方
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,R4
        LDRB     R4,[R4, #-9]
        CMP      R4,#+49
        BNE.N    ??get_num_0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        SUBS     R4,R1,#+1
        CMP      R4,#+0
        BMI.N    ??get_num_0
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        SUBS     R4,R2,#+1
        CMP      R4,#+0
        BMI.N    ??get_num_0
//  129 	{
//  130 		count++;
        ADDS     R3,R3,#+1
//  131 	}
//  132 	if (mine[x - 1][y] == '1'&&(x-1)>=0)//左边
??get_num_0:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,R4
        LDRB     R4,[R4, #-8]
        CMP      R4,#+49
        BNE.N    ??get_num_1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        SUBS     R4,R1,#+1
        CMP      R4,#+0
        BMI.N    ??get_num_1
//  133 	{
//  134 		count++;
        ADDS     R3,R3,#+1
//  135 	}
//  136 	if (mine[x - 1][y + 1] == '1'&&(x-1)>=0&&(y+1)<=7)//左下方
??get_num_1:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,R4
        LDRB     R4,[R4, #-7]
        CMP      R4,#+49
        BNE.N    ??get_num_2
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        SUBS     R4,R1,#+1
        CMP      R4,#+0
        BMI.N    ??get_num_2
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,#+1
        CMP      R4,#+8
        BGE.N    ??get_num_2
//  137 	{
//  138 		count++;
        ADDS     R3,R3,#+1
//  139 	}
//  140 	if (mine[x][y - 1] == '1'&&(y-1)>=0)//上方
??get_num_2:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,R4
        LDRB     R4,[R4, #-1]
        CMP      R4,#+49
        BNE.N    ??get_num_3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        SUBS     R4,R2,#+1
        CMP      R4,#+0
        BMI.N    ??get_num_3
//  141 	{
//  142 		count++;
        ADDS     R3,R3,#+1
//  143 	}
//  144 	if (mine[x][y + 1] == '1'&&(y+1)<=7)//下方
??get_num_3:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,R4
        LDRB     R4,[R4, #+1]
        CMP      R4,#+49
        BNE.N    ??get_num_4
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,#+1
        CMP      R4,#+8
        BGE.N    ??get_num_4
//  145 	{
//  146 		count++;
        ADDS     R3,R3,#+1
//  147 	}
//  148 	if (mine[x + 1][y - 1] == '1'&&(x+1)<=7&&(y-1)>=0)//右上方
??get_num_4:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,R4
        LDRB     R4,[R4, #+7]
        CMP      R4,#+49
        BNE.N    ??get_num_5
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R1,#+1
        CMP      R4,#+8
        BGE.N    ??get_num_5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        SUBS     R4,R2,#+1
        CMP      R4,#+0
        BMI.N    ??get_num_5
//  149 	{
//  150 		count++;
        ADDS     R3,R3,#+1
//  151 	}
//  152 	if (mine[x + 1][y] == '1'&&(x+1)<=7)//右方
??get_num_5:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R4,R2,R4
        LDRB     R4,[R4, #+8]
        CMP      R4,#+49
        BNE.N    ??get_num_6
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R4,R1,#+1
        CMP      R4,#+8
        BGE.N    ??get_num_6
//  153 	{
//  154 		count++;
        ADDS     R3,R3,#+1
//  155 	}
//  156 	if (mine[x + 1][y + 1] == '1'&&(x+1)<=7&&(y+1)<=7)//右下方
??get_num_6:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R0,R0,R1, LSL #+3
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R0,R2,R0
        LDRB     R0,[R0, #+9]
        CMP      R0,#+49
        BNE.N    ??get_num_7
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R0,R1,#+1
        CMP      R0,#+8
        BGE.N    ??get_num_7
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R0,R2,#+1
        CMP      R0,#+8
        BGE.N    ??get_num_7
//  157 	{
//  158 		count++;
        ADDS     R3,R3,#+1
//  159 	}
//  160 	return  count;
??get_num_7:
        MOVS     R0,R3
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R4}
        BX       LR               ;; return
//  161 }
//  162 //扫雷

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  163 uint16 Sweep(unsigned char mine[rows][cols],unsigned  char show[rows][cols])
//  164 {        
Sweep:
        PUSH     {R4,LR}
        MOVS     R4,R1
//  165         
//  166          if(key_up==1&&ti==0)
        LDR.W    R0,??DataTable8_27
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??Sweep_0
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_0
//  167          {
//  168            y--;
        LDR.W    R0,??DataTable8_8
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable8_8
        STRH     R0,[R1, #+0]
//  169            ti++;
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_13
        STRH     R0,[R1, #+0]
//  170          } 
//  171           if(key_down==1&&ti==0)
??Sweep_0:
        LDR.W    R0,??DataTable8_28
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??Sweep_1
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_1
//  172           {
//  173            y++;
        LDR.W    R0,??DataTable8_8
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_8
        STRH     R0,[R1, #+0]
//  174            ti++;
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_13
        STRH     R0,[R1, #+0]
//  175           }
//  176           if(key_left==1&&ti==0)
??Sweep_1:
        LDR.W    R0,??DataTable8_29
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??Sweep_2
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_2
//  177          {
//  178            x--;
        LDR.W    R0,??DataTable8_9
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable8_9
        STRH     R0,[R1, #+0]
//  179            ti++;
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_13
        STRH     R0,[R1, #+0]
//  180          }
//  181           if(key_right==1&&ti==0)
??Sweep_2:
        LDR.W    R0,??DataTable8_30
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??Sweep_3
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_3
//  182          {
//  183            x++;
        LDR.W    R0,??DataTable8_9
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_9
        STRH     R0,[R1, #+0]
//  184            ti++;
        LDR.W    R0,??DataTable8_13
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_13
        STRH     R0,[R1, #+0]
//  185          }
//  186          if(x<=0)
??Sweep_3:
        LDR.W    R0,??DataTable8_9
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_4
//  187          { x=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_9
        STRH     R0,[R1, #+0]
//  188          }
//  189           if(x>=7)
??Sweep_4:
        LDR.W    R0,??DataTable8_9
        LDRH     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??Sweep_5
//  190          { x=7;}
        MOVS     R0,#+7
        LDR.W    R1,??DataTable8_9
        STRH     R0,[R1, #+0]
//  191           if(y<=0)
??Sweep_5:
        LDR.W    R0,??DataTable8_8
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_6
//  192          { y=0;}
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_8
        STRH     R0,[R1, #+0]
//  193           if(y>=7)
??Sweep_6:
        LDR.W    R0,??DataTable8_8
        LDRH     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??Sweep_7
//  194          { y=7;}
        MOVS     R0,#+7
        LDR.W    R1,??DataTable8_8
        STRH     R0,[R1, #+0]
//  195          if(cit==0){
??Sweep_7:
        LDR.W    R0,??DataTable8_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??Sweep_8
//  196            display(show); 
        MOVS     R0,R4
        BL       display
//  197         k=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_12
        STRH     R0,[R1, #+0]
//  198         uint16 i = 0;
        MOVS     R0,#+0
//  199 	uint16 j = 0;
        MOVS     R1,#+0
//  200 	for (i = 0; i < rows ; i++)
        MOVS     R2,#+0
        MOVS     R0,R2
        B.N      ??Sweep_9
//  201 	{
//  202 		for (j = 0; j <cols ; j++)
//  203 		{   	
//  204                   if(show[i][j]=='*')
??Sweep_10:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R4,R0, LSL #+3
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRB     R2,[R1, R2]
        CMP      R2,#+42
        BNE.N    ??Sweep_11
//  205                   {  k++;
        LDR.W    R2,??DataTable8_12
        LDRH     R2,[R2, #+0]
        ADDS     R2,R2,#+1
        LDR.W    R3,??DataTable8_12
        STRH     R2,[R3, #+0]
//  206 
//  207                   }
//  208 		}
??Sweep_11:
        ADDS     R1,R1,#+1
??Sweep_12:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??Sweep_10
        ADDS     R0,R0,#+1
??Sweep_9:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??Sweep_13
        MOVS     R1,#+0
        B.N      ??Sweep_12
//  209 	}
//  210       sprintf(g, "%d", k);
??Sweep_13:
        LDR.W    R0,??DataTable8_12
        LDRH     R2,[R0, #+0]
        ADR.N    R1,??DataTable4  ;; 0x25, 0x64, 0x00, 0x00
        LDR.W    R0,??DataTable8_31
        BL       sprintf
//  211        LCD_P8x16Str(70,3,"*");
        ADR.N    R2,??DataTable5  ;; "*"
        MOVS     R1,#+3
        MOVS     R0,#+70
        BL       LCD_P8x16Str
//  212 LCD_P14x16Ch(78,3,26);
        MOVS     R2,#+26
        MOVS     R1,#+3
        MOVS     R0,#+78
        BL       LCD_P14x16Ch
//  213 LCD_P14x16Ch(92,3,27);
        MOVS     R2,#+27
        MOVS     R1,#+3
        MOVS     R0,#+92
        BL       LCD_P14x16Ch
//  214     if(t6==0&&g[0]<10){
        LDR.W    R0,??DataTable8_17
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_14
        LDR.W    R0,??DataTable8_31
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BGE.N    ??Sweep_14
//  215             LCD_CLS();
        BL       LCD_CLS
//  216                        delay1(10);
        MOVS     R0,#+10
        BL       delay1
//  217                        t6=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_17
        STRH     R0,[R1, #+0]
//  218                 } 
//  219 LCD_P8x16Str(106,3,g);
??Sweep_14:
        LDR.W    R2,??DataTable8_31
        MOVS     R1,#+3
        MOVS     R0,#+106
        BL       LCD_P8x16Str
//  220         if(k<=15&&k>Count){
        LDR.W    R0,??DataTable8_12
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+11
        CMP      R0,#+5
        BCS.N    ??Sweep_15
//  221         LCD_P14x16Ch(70,0,23);
        MOVS     R2,#+23
        MOVS     R1,#+0
        MOVS     R0,#+70
        BL       LCD_P14x16Ch
//  222         LCD_P14x16Ch(84,0,24);
        MOVS     R2,#+24
        MOVS     R1,#+0
        MOVS     R0,#+84
        BL       LCD_P14x16Ch
//  223         LCD_P14x16Ch(98,0,25);
        MOVS     R2,#+25
        MOVS     R1,#+0
        MOVS     R0,#+98
        BL       LCD_P14x16Ch
//  224         }
//  225         if(k==Count){
??Sweep_15:
        LDR.W    R0,??DataTable8_12
        LDRH     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??Sweep_16
//  226           cit=2;  
        MOVS     R0,#+2
        LDR.W    R1,??DataTable8_7
        STRH     R0,[R1, #+0]
//  227 		                 if(t5==0){
        LDR.W    R0,??DataTable8_18
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_17
//  228             LCD_CLS();
        BL       LCD_CLS
//  229                        delay1(10);
        MOVS     R0,#+10
        BL       delay1
//  230                        t5=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_18
        STRH     R0,[R1, #+0]
//  231                 } 
//  232             LCD_P8x16Str(30,2,"you are a ");
??Sweep_17:
        LDR.W    R2,??DataTable8_32
        MOVS     R1,#+2
        MOVS     R0,#+30
        BL       LCD_P8x16Str
//  233              LCD_P8x16Str(40,4," winner ");
        LDR.W    R2,??DataTable8_33
        MOVS     R1,#+4
        MOVS     R0,#+40
        BL       LCD_P8x16Str
//  234              gameoversl=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_1
        STRH     R0,[R1, #+0]
//  235         }
//  236 
//  237             if(ct==1){
??Sweep_16:
        LDR.W    R0,??DataTable8_16
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??Sweep_8
//  238                      if(t4==0){
        LDR.W    R0,??DataTable8_19
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Sweep_18
//  239             LCD_CLS();
        BL       LCD_CLS
//  240                        delay1(10);
        MOVS     R0,#+10
        BL       delay1
//  241                        t4=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_19
        STRH     R0,[R1, #+0]
//  242                 } 
//  243             cit=2;
??Sweep_18:
        MOVS     R0,#+2
        LDR.W    R1,??DataTable8_7
        STRH     R0,[R1, #+0]
//  244             LCD_P8x16Str(20,3,"try again ! ");
        LDR.W    R2,??DataTable8_34
        MOVS     R1,#+3
        MOVS     R0,#+20
        BL       LCD_P8x16Str
//  245             gameoversl=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_1
        STRH     R0,[R1, #+0]
//  246 /*             for (int i=0;i<500;i++)//蜂鸣器
//  247 	{
//  248 		LPLD_GPIO_Toggle_b(PTC,9); 
//  249              delay1(100);
//  250               LPLD_GPIO_Toggle_b(PTC,9); 
//  251              delay1(100);
//  252 	}*/        
//  253            }
//  254          } 
//  255 	return 0;
??Sweep_8:
        MOVS     R0,#+0
        POP      {R4,PC}          ;; return
//  256 }
//  257  
//  258  
//  259 //游戏

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  260 uint16 Game(unsigned char mine[rows][cols],unsigned char show[rows][cols])
//  261 {    
Game:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  262   time1();
        BL       time1
//  263   kongzhi();
        BL       kongzhi
//  264 	set_mine(mine);
        MOVS     R0,R4
        BL       set_mine
//  265         if(cit==0){
        LDR.W    R0,??DataTable8_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Game_0
//  266 	display(show);
        MOVS     R0,R5
        BL       display
//  267         }
//  268 	//display(mine);//可以将雷的位置显示出来
//  269 	Sweep(mine,show);
??Game_0:
        MOVS     R1,R5
        MOVS     R0,R4
        BL       Sweep
//  270 	return 0;
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  271 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC8      0x25, 0x64, 0x00, 0x00
//  272 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  273 void kongzhi(void)
//  274   {  
kongzhi:
        PUSH     {R7,LR}
//  275 result1 = LPLD_ADC_Get(ADC0, DAD1);//获得数字量
        MOVS     R1,#+1
        LDR.W    R0,??DataTable8_35  ;; 0x4003b000
        BL       LPLD_ADC_Get
        LDR.W    R1,??DataTable8_36
        STRH     R0,[R1, #+0]
//  276 result = LPLD_ADC_Get(ADC0, DAD3);
        MOVS     R1,#+3
        LDR.W    R0,??DataTable8_35  ;; 0x4003b000
        BL       LPLD_ADC_Get
        LDR.W    R1,??DataTable8_37
        STRH     R0,[R1, #+0]
//  277 if(result<1800&&t==0){
        LDR.W    R0,??DataTable8_37
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1800
        BGE.N    ??kongzhi_0
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??kongzhi_0
//  278 
//  279    key_up=1;  
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_27
        STRH     R0,[R1, #+0]
//  280     key_left=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_29
        STRH     R0,[R1, #+0]
//  281   key_right=0; 
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_30
        STRH     R0,[R1, #+0]
//  282   key_down=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_28
        STRH     R0,[R1, #+0]
//  283  t++;
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_14
        STRH     R0,[R1, #+0]
        B.N      ??kongzhi_1
//  284            //up
//  285 }
//  286 else if(result>2200&&t==0){
??kongzhi_0:
        LDR.W    R0,??DataTable8_37
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+2201
        CMP      R0,R1
        BLT.N    ??kongzhi_1
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??kongzhi_1
//  287      key_up=0;  
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_27
        STRH     R0,[R1, #+0]
//  288     key_left=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_29
        STRH     R0,[R1, #+0]
//  289   key_right=0; 
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_30
        STRH     R0,[R1, #+0]
//  290   key_down=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_28
        STRH     R0,[R1, #+0]
//  291     t++;         //down
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_14
        STRH     R0,[R1, #+0]
//  292 }
//  293 
//  294 if(result1<1800&&t==0){
??kongzhi_1:
        LDR.W    R0,??DataTable8_36
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1800
        BGE.N    ??kongzhi_2
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??kongzhi_2
//  295       key_up=0;  
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_27
        STRH     R0,[R1, #+0]
//  296     key_left=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_29
        STRH     R0,[R1, #+0]
//  297   key_right=0; 
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_30
        STRH     R0,[R1, #+0]
//  298   key_down=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_28
        STRH     R0,[R1, #+0]
//  299      t++;     //left
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_14
        STRH     R0,[R1, #+0]
        B.N      ??kongzhi_3
//  300 }
//  301 else if(result1>2200&&t==0){
??kongzhi_2:
        LDR.W    R0,??DataTable8_36
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+2201
        CMP      R0,R1
        BLT.N    ??kongzhi_3
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??kongzhi_3
//  302       key_up=0;  
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_27
        STRH     R0,[R1, #+0]
//  303     key_left=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_29
        STRH     R0,[R1, #+0]
//  304   key_right=1; 
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_30
        STRH     R0,[R1, #+0]
//  305   key_down=0;            //right
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_28
        STRH     R0,[R1, #+0]
//  306   t++;
        LDR.W    R0,??DataTable8_14
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable8_14
        STRH     R0,[R1, #+0]
//  307 }
//  308 if(result>=1800&&result<=2200&&result1>=1800&&result1<=2200)
??kongzhi_3:
        LDR.W    R0,??DataTable8_37
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1800
        CMP      R0,#+400
        BHI.N    ??kongzhi_4
        LDR.W    R0,??DataTable8_36
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1800
        CMP      R0,#+400
        BHI.N    ??kongzhi_4
//  309 {
//  310  t=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_14
        STRH     R0,[R1, #+0]
//  311  ti=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_13
        STRH     R0,[R1, #+0]
//  312    key_up=0;  
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_27
        STRH     R0,[R1, #+0]
//  313    key_left=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_29
        STRH     R0,[R1, #+0]
//  314   key_right=0; 
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_30
        STRH     R0,[R1, #+0]
//  315   key_down=0; 
        MOVS     R0,#+0
        LDR.W    R1,??DataTable8_28
        STRH     R0,[R1, #+0]
//  316 }
//  317   delay1(100);
??kongzhi_4:
        MOVS     R0,#+100
        BL       delay1
//  318 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC8      "*",0x0,0x0
//  319 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  320 void delay1(uint16 ms)
//  321 {  
//  322    uint16 ii,jj;
//  323    if (ms<1) ms=1;
delay1:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??delay1_0
        MOVS     R0,#+1
//  324    for(ii=0;ii<ms;ii++)
??delay1_0:
        MOVS     R1,#+0
        B.N      ??delay1_1
//  325      for(jj=0;jj<500;jj++);  
??delay1_2:
        ADDS     R2,R2,#+1
??delay1_3:
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        CMP      R2,#+500
        BLT.N    ??delay1_2
        ADDS     R1,R1,#+1
??delay1_1:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R1,R0
        BCS.N    ??delay1_4
        MOVS     R2,#+0
        B.N      ??delay1_3
//  326        
//  327 } 
??delay1_4:
        BX       LR               ;; return
//  328 
//  329 /*void duqu(void){   
//  330   
//  331   if(LPLD_GPIO_Input_b(PTC, 0)==0){
//  332     delay1(10);
//  333     if(LPLD_GPIO_Input_b(PTC, 0)==0)
//  334     {
//  335       kaiguan[0]=1;
//  336     }
//  337   }
//  338 }*/
//  339 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  340 void time1(void)      
//  341 {        
time1:
        PUSH     {R7,LR}
//  342      timesl=counter;
        LDR.W    R0,??DataTable8_21
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable8_11
        STRH     R0,[R1, #+0]
//  343      if(cit==0){
        LDR.W    R0,??DataTable8_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??time1_0
//  344        sprintf(f, "%d", timesl);
        LDR.W    R0,??DataTable8_11
        LDRH     R2,[R0, #+0]
        ADR.N    R1,??DataTable7  ;; 0x25, 0x64, 0x00, 0x00
        LDR.W    R0,??DataTable8_38
        BL       sprintf
//  345    LCD_P8x16Str(100,6,f);
        LDR.W    R2,??DataTable8_38
        MOVS     R1,#+6
        MOVS     R0,#+100
        BL       LCD_P8x16Str
//  346   LCD_P14x16Ch(70,6,17);
        MOVS     R2,#+17
        MOVS     R1,#+6
        MOVS     R0,#+70
        BL       LCD_P14x16Ch
//  347 LCD_P14x16Ch(84,6,18);
        MOVS     R2,#+18
        MOVS     R1,#+6
        MOVS     R0,#+84
        BL       LCD_P14x16Ch
//  348      }
//  349        if(timesl>=200&&cit!=2)
??time1_0:
        LDR.W    R0,??DataTable8_11
        LDRH     R0,[R0, #+0]
        CMP      R0,#+200
        BLT.N    ??time1_1
        LDR.W    R0,??DataTable8_7
        LDRH     R0,[R0, #+0]
        CMP      R0,#+2
        BEQ.N    ??time1_1
//  350        {  
//  351          cit=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_7
        STRH     R0,[R1, #+0]
//  352             if(t3==0){
        LDR.W    R0,??DataTable8_20
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??time1_2
//  353 	          LCD_CLS();
        BL       LCD_CLS
//  354                        delay1(10);
        MOVS     R0,#+10
        BL       delay1
//  355                        t3=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable8_20
        STRH     R0,[R1, #+0]
//  356                 } 
//  357         
//  358           LCD_P8x16Str(10,2,"you are out of ");
??time1_2:
        LDR.W    R2,??DataTable8_39
        MOVS     R1,#+2
        MOVS     R0,#+10
        BL       LCD_P8x16Str
//  359              LCD_P8x16Str(40,4," time ");
        LDR.W    R2,??DataTable8_40
        MOVS     R1,#+4
        MOVS     R0,#+40
        BL       LCD_P8x16Str
//  360              gameoversl=1;    
        MOVS     R0,#+1
        LDR.N    R1,??DataTable8_1
        STRH     R0,[R1, #+0]
//  361        }    
//  362 }
??time1_1:
        POP      {R0,PC}          ;; return
//  363 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  364 void surrond(uint16 a, uint16 b)
//  365 {   if((a+1)<=7&&(b+1)<=7){
surrond:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R4,#+1
        CMP      R0,#+8
        BGE.N    ??surrond_0
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,#+1
        CMP      R0,#+8
        BGE.N    ??surrond_0
//  366   if(mine[a+1][b+1] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #+9]
        CMP      R0,#+49
        BEQ.N    ??surrond_0
//  367   {   
//  368        show[a+1][b+1] = get_num(mine, a+1, b+1)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        ADDS     R2,R5,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R1,R4,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #+9]
//  369                     //    set_mine(mine);
//  370                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  371   }
//  372 }  if((b+1)<=7){
??surrond_0:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,#+1
        CMP      R0,#+8
        BGE.N    ??surrond_1
//  373    if(mine[a][b+1] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #+1]
        CMP      R0,#+49
        BEQ.N    ??surrond_1
//  374   {
//  375        show[a][b+1] = get_num(mine, a, b+1)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        ADDS     R2,R5,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,R4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #+1]
//  376                        //  set_mine(mine);
//  377                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  378   }
//  379 }
//  380 if((a+1)<=7){
??surrond_1:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R4,#+1
        CMP      R0,#+8
        BGE.N    ??surrond_2
//  381  if(mine[a+1][b] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #+8]
        CMP      R0,#+49
        BEQ.N    ??surrond_2
//  382   {
//  383        show[a+1][b] = get_num(mine, a+1, b)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R1,R4,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #+8]
//  384                     //    set_mine(mine);
//  385                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  386   }}
//  387   if((a-1)>=0&&(b+1)<=7){
??surrond_2:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        SUBS     R0,R4,#+1
        CMP      R0,#+0
        BMI.N    ??surrond_3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,#+1
        CMP      R0,#+8
        BGE.N    ??surrond_3
//  388  if(mine[a-1][b+1] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #-7]
        CMP      R0,#+49
        BEQ.N    ??surrond_3
//  389   {
//  390        show[a-1][b+1] = get_num(mine, a-1, b+1)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        ADDS     R2,R5,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        SUBS     R1,R4,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #-7]
//  391                    //      set_mine(mine);
//  392                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  393   }
//  394   }
//  395   if((b-1)>=0&&(a-1)>=0){
??surrond_3:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        SUBS     R0,R5,#+1
        CMP      R0,#+0
        BMI.N    ??surrond_4
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        SUBS     R0,R4,#+1
        CMP      R0,#+0
        BMI.N    ??surrond_4
//  396  if(mine[a-1][b-1] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #-9]
        CMP      R0,#+49
        BEQ.N    ??surrond_4
//  397   {
//  398        show[a-1][b-1] = get_num(mine, a-1, b-1)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        SUBS     R2,R5,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        SUBS     R1,R4,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #-9]
//  399                     //    set_mine(mine);
//  400                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  401   }  }
//  402         if((a+1)<=7&&(b-1)>=0){
??surrond_4:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R4,#+1
        CMP      R0,#+8
        BGE.N    ??surrond_5
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        SUBS     R0,R5,#+1
        CMP      R0,#+0
        BMI.N    ??surrond_5
//  403  if(mine[a+1][b-1] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #+7]
        CMP      R0,#+49
        BEQ.N    ??surrond_5
//  404   {
//  405        show[a+1][b-1] = get_num(mine, a+1, b-1)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        SUBS     R2,R5,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R1,R4,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #+7]
//  406                       //  set_mine(mine);
//  407                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  408   }} 
//  409         if((b-1)>=0){
??surrond_5:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        SUBS     R0,R5,#+1
        CMP      R0,#+0
        BMI.N    ??surrond_6
//  410   if(mine[a][b-1] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #-1]
        CMP      R0,#+49
        BEQ.N    ??surrond_6
//  411   {
//  412        show[a][b-1] = get_num(mine, a, b-1)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        SUBS     R2,R5,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,R4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #-1]
//  413                  //       set_mine(mine);
//  414                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  415   } }  if((a-1)>=0){
??surrond_6:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        SUBS     R0,R4,#+1
        CMP      R0,#+0
        BMI.N    ??surrond_7
//  416   if(mine[a-1][b] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R5,R0
        LDRB     R0,[R0, #-8]
        CMP      R0,#+49
        BEQ.N    ??surrond_7
//  417   {
//  418        show[a-1][b] = get_num(mine, a-1, b)+ '0';
        LDR.N    R0,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R6,R5,R0
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        SUBS     R1,R4,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
        ADDS     R0,R0,#+48
        STRB     R0,[R6, #-8]
//  419                       //   set_mine(mine);
//  420                         delay1(50);
        MOVS     R0,#+50
        BL       delay1
//  421   }
//  422   }
//  423      return;
??surrond_7:
        POP      {R4-R6,PC}       ;; return
//  424 
//  425 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC8      0x25, 0x64, 0x00, 0x00

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  426 void panduan(uint16 a, uint16 b) {
panduan:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  427     uint16 i, j;
//  428     if (mine[a][b] != '1')
        LDR.N    R0,??DataTable8_2
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LDRB     R0,[R5, R0]
        CMP      R0,#+49
        BEQ.N    ??panduan_0
//  429     {
//  430     uint16 ret = get_num(mine, a, b);  
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,R4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
//  431      if(ret!=0){    
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BEQ.N    ??panduan_1
//  432                           show[a][b] = ret + '0';   //‘0'+1=‘1’
        LDR.N    R1,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R1,R1,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,#+48
        STRB     R0,[R5, R1]
//  433                     //   set_mine(mine);
//  434                         delay1(10);
        MOVS     R0,#+10
        BL       delay1
//  435                            return;
        B.N      ??panduan_2
//  436      }
//  437      if(biaozhi<=80){
??panduan_1:
        LDR.N    R1,??DataTable8_15
        LDRH     R1,[R1, #+0]
        CMP      R1,#+81
        BGE.N    ??panduan_0
//  438     if (ret==0) {    
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??panduan_0
//  439     show[a][b] = ret + '0';
        LDR.N    R1,??DataTable8_3
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R1,R1,R4, LSL #+3
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,#+48
        STRB     R0,[R5, R1]
//  440         surrond(a, b);
        MOVS     R1,R5
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       surrond
//  441            biaozhi++;
        LDR.N    R0,??DataTable8_15
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable8_15
        STRH     R0,[R1, #+0]
//  442         if(a>=0&&a<=7&&b>=0&&b<=7)
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+8
        BGE.N    ??panduan_0
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+8
        BGE.N    ??panduan_0
//  443         for (i = -1; i <= 1; i++) {
        MOVW     R6,#+65535
        B.N      ??panduan_3
??panduan_4:
        ADDS     R6,R6,#+1
??panduan_3:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+2
        BGE.N    ??panduan_0
//  444             for (j = -1; j <= 1; j++) {
        MOVW     R7,#+65535
        B.N      ??panduan_5
//  445            
//  446                 if (i == 0 && j == 0) continue;
//  447 
//  448                else if((a+i)>=0&&(a+i)<=7&&(b+j)>=0&&(b+j)<=7){
??panduan_6:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        UXTAH    R0,R6,R4
        SUBS     R0,R0,#+0
        CMP      R0,#+8
        BCS.N    ??panduan_7
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        UXTAH    R0,R7,R5
        SUBS     R0,R0,#+0
        CMP      R0,#+8
        BCS.N    ??panduan_7
//  449                      uint16 ret1 = get_num(mine, a+i, b+j);
        ADDS     R2,R7,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R1,R6,R4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable8_2
        BL       get_num
//  450                      if(ret1==0){
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??panduan_7
//  451             panduan(a + i, b + j);
        ADDS     R1,R7,R5
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R0,R6,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       panduan
//  452                 }  
//  453                }
??panduan_7:
        ADDS     R7,R7,#+1
??panduan_5:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+2
        BGE.N    ??panduan_4
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+0
        BNE.N    ??panduan_6
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BNE.N    ??panduan_6
        B.N      ??panduan_7
//  454             }
//  455         }
//  456     }
//  457     }
//  458     }
//  459     return;
??panduan_0:
??panduan_2:
        POP      {R0,R4-R7,PC}    ;; return
//  460 } 

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8:
        DC32     gamestart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_1:
        DC32     gameoversl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_2:
        DC32     mine

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_3:
        DC32     show

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_4:
        DC32     kaiguan

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_5:
        DC32     t1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_6:
        DC32     t2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_7:
        DC32     cit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_8:
        DC32     y

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_9:
        DC32     x

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_10:
        DC32     gameing

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_11:
        DC32     timesl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_12:
        DC32     k

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_13:
        DC32     ti

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_14:
        DC32     t

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_15:
        DC32     biaozhi

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_16:
        DC32     ct

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_17:
        DC32     t6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_18:
        DC32     t5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_19:
        DC32     t4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_20:
        DC32     t3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_21:
        DC32     counter

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_22:
        DC32     count

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_23:
        DC32     0x400bb000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_24:
        DC32     a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_25:
        DC32     `b`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_26:
        DC32     s

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_27:
        DC32     key_up

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_28:
        DC32     key_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_29:
        DC32     key_left

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_30:
        DC32     key_right

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_31:
        DC32     g

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_32:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_33:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_34:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_35:
        DC32     0x4003b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_36:
        DC32     result1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_37:
        DC32     result

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_38:
        DC32     f

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_39:
        DC32     ?_5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_40:
        DC32     ?_6

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "%d"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "*"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "you are a "
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 " winner "
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "try again ! "
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_5:
        DATA
        DC8 "you are out of "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_6:
        DATA
        DC8 " time "
        DC8 0

        END
// 
//   174 bytes in section .bss
//     8 bytes in section .data
//    70 bytes in section .rodata
// 3 074 bytes in section .text
// 
// 3 074 bytes of CODE  memory
//    70 bytes of CONST memory
//   182 bytes of DATA  memory
//
//Errors: none
//Warnings: 4
