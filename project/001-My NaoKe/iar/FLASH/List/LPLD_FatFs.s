///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       14/May/2019  19:13:49
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\LPLD_FatFs.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\LPLD_FatFs.c" -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\LPLD_FatFs.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_CLS
        EXTERN LCD_Init
        EXTERN LCD_P14x16Ch
        EXTERN LCD_P8x16Str
        EXTERN LCD_siping
        EXTERN __aeabi_memcpy
        EXTERN adc_init
        EXTERN delay
        EXTERN f_close
        EXTERN f_getfree
        EXTERN f_mount
        EXTERN f_open
        EXTERN f_read
        EXTERN init_gpio
        EXTERN jianmian
        EXTERN key
        EXTERN pit_init
        EXTERN playmusic
        EXTERN pwm_init
        EXTERN saolei
        EXTERN tuixiangzi
        EXTERN wuziqi
        EXTERN xtjianmian

        PUBLIC badapple
        PUBLIC badapple_time
        PUBLIC br
        PUBLIC buff_114
        PUBLIC buff_86
        PUBLIC bw
        PUBLIC die
        PUBLIC fatfs
        PUBLIC fil
        PUBLIC flag
        PUBLIC flag1
        PUBLIC flag2
        PUBLIC flash_start
        PUBLIC fs
        PUBLIC gameing
        PUBLIC gameover
        PUBLIC gamestart
        PUBLIC get_fattime
        PUBLIC key_down
        PUBLIC key_left
        PUBLIC key_right
        PUBLIC key_up
        PUBLIC main
        PUBLIC mosixuanzi
        PUBLIC rc
        PUBLIC readsd
        PUBLIC result
        PUBLIC result1
        PUBLIC start_pic
        PUBLIC time
        PUBLIC timeflag
        PUBLIC wj_wzq

// D:\2019.IAR\project\001-My NaoKe\app\LPLD_FatFs.c
//    1 #include "common.h"
//    2 #include "LQ12864.h"
//    3 #include "yingjian.h"
//    4 #include "jianmian.h"
//    5 #include "tuixiangzi.h"
//    6 #include "saolei.h"
//    7 #include "wuziqi.h"
//    8 #include "huatu.h"
//    9 //#include "wavplay.h"  软解失败
//   10 void start_pic(void);//开始界面
//   11 void readsd(void);
//   12 void die(FRESULT rc);
//   13 DWORD get_fattime (void);// 用户自定义的为FatFs系统提供实时时间的函数
//   14 void badapple(uint8 spshu);//视频播放
//   15 //void music(void);//音乐播放
//   16 void huatu(void);//自定义地图功能
//   17 void flash_start(void);//视频播放选择界面
//   18 // 以下变量定义均采用FatFs文件系统变量类型

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   19 FRESULT rc;     //结果代码
rc:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   20 FATFS fatfs,*fs;      // 文件系统对象
fatfs:
        DS8 568

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
fs:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   21 FIL fil;      // 文件对象
fil:
        DS8 556

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   22 UINT bw, br;
bw:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
br:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 unsigned char buff_86[688],buff_114[912];//86*64分辨率|114*64分辨率
buff_86:
        DS8 688

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
buff_114:
        DS8 912
//   24 //通用标志位

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   25 uint16 result,result1;//储存ADC模块的采集数据
result:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
result1:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   26 uint16 key_up,key_down,key_left,key_right;//
key_up:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
key_down:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
key_left:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
key_right:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   27 uint16 mosixuanzi=1;
mosixuanzi:
        DATA
        DC16 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   28 uint16 gamestart=0,gameing=0;
gamestart:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
gameing:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//   29 uint8 badapple_time=1;
badapple_time:
        DATA
        DC8 1
//   30 //傻吊汪酱标志位

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   31 uint16 flag=1;//返回
flag:
        DATA
        DC16 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   32 uint16 flag1=0,flag2=0;
flag1:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
flag2:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   33 uint16 time=60;
time:
        DATA
        DC16 60

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   34 uint16 timeflag=0;
timeflag:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   35 uint16 gameover=0;
gameover:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   36 uint8 wj_wzq=0;
wj_wzq:
        DS8 1
//   37 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   38 void main (void){
main:
        PUSH     {R7,LR}
//   39   init_gpio();//初始化gpio口
        BL       init_gpio
//   40   LCD_Init();//初始化OLED
        BL       LCD_Init
//   41   adc_init();//初始化ADC
        BL       adc_init
//   42   pit_init();
        BL       pit_init
//   43   pwm_init();//初始化PWM
        BL       pwm_init
//   44   //dac_init();//初始化DAC模块
//   45   start_pic();
        BL       start_pic
        B.N      ??main_0
//   46   //gameing=1;mosixuanzi=6;gamestart=1;
//   47   //huatu();
//   48   while(1){
//   49     jianmian();
//   50     if(gamestart==1)
//   51     switch(mosixuanzi){
//   52       case 1:gameover=0;tuixiangzi();break;
//   53       case 2:gamestart=1;gameing=1;saolei();break;
//   54       case 3:gameing=0;wj_wzq=1;wuziqi();wj_wzq=0;break;
//   55       case 4:gamestart=1;gameing=0;flash_start();break;
//   56       case 5:gamestart=1;gameing=0;xtjianmian();break;
??main_1:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6
        STRH     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_1
        STRH     R0,[R1, #+0]
        BL       xtjianmian
//   57     }
//   58     LCD_CLS();
??main_2:
        BL       LCD_CLS
??main_0:
        BL       jianmian
        LDR.W    R0,??DataTable6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??main_2
        LDR.W    R0,??DataTable6_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??main_3
        BCC.N    ??main_2
        CMP      R0,#+3
        BEQ.N    ??main_4
        BCC.N    ??main_5
        CMP      R0,#+5
        BEQ.N    ??main_1
        BCC.N    ??main_6
        B.N      ??main_2
??main_3:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+0]
        BL       tuixiangzi
        B.N      ??main_2
??main_5:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6
        STRH     R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6_1
        STRH     R0,[R1, #+0]
        BL       saolei
        B.N      ??main_2
??main_4:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_1
        STRH     R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        BL       wuziqi
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??main_2
??main_6:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6
        STRH     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_1
        STRH     R0,[R1, #+0]
        BL       flash_start
        B.N      ??main_2
//   59   }
//   60 }
//   61 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   62 void start_pic(void){
start_pic:
        PUSH     {R3-R5,LR}
//   63 	gameover=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+0]
//   64   uint16 pic=1;
        MOVS     R4,#+1
//   65   LCD_CLS();
        BL       LCD_CLS
//   66   //LCD_P128x64Ch();
//   67   for(uint8 i=0;i<6;i++)//图形交互系统
        MOVS     R5,#+0
        B.N      ??start_pic_0
//   68     LCD_P14x16Ch(i*16+10,0,i+66);
??start_pic_1:
        ADDS     R2,R5,#+66
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R0,R5,#+4
        ADDS     R0,R0,#+10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R5,R5,#+1
??start_pic_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+6
        BLT.N    ??start_pic_1
//   69 
//   70   for(uint8 i=0;i<4;i++)//指导老师
        MOVS     R5,#+0
        B.N      ??start_pic_2
//   71     LCD_P14x16Ch(i*15,4,i+66+6);
??start_pic_3:
        ADDS     R2,R5,#+72
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        MOVS     R0,#+15
        SMULBB   R0,R5,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R5,R5,#+1
??start_pic_2:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+4
        BLT.N    ??start_pic_3
//   72   for(uint8 i=0;i<2;i++)//11
        MOVS     R5,#+0
        B.N      ??start_pic_4
//   73     LCD_P14x16Ch(i*22+15*4+14,4,i+66+10);
??start_pic_5:
        ADDS     R2,R5,#+76
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        MOVS     R0,#+22
        MUL      R0,R0,R5
        ADDS     R0,R0,#+74
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R5,R5,#+1
??start_pic_4:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BLT.N    ??start_pic_5
//   74 
//   75   for(uint8 i=0;i<3;i++)//汇报人
        MOVS     R5,#+0
        B.N      ??start_pic_6
//   76     LCD_P14x16Ch(i*18,6,i+66+12);
??start_pic_7:
        ADDS     R2,R5,#+78
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        MOVS     R0,#+18
        SMULBB   R0,R5,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R5,R5,#+1
??start_pic_6:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BLT.N    ??start_pic_7
//   77   for(uint8 i=0;i<3;i++)//111
        MOVS     R5,#+0
        B.N      ??start_pic_8
//   78     LCD_P14x16Ch(i*15+15*4+14,6,i+66+15);
??start_pic_9:
        ADDS     R2,R5,#+81
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        MOVS     R0,#+15
        MUL      R0,R0,R5
        ADDS     R0,R0,#+74
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R5,R5,#+1
??start_pic_8:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BLT.N    ??start_pic_9
//   79     LCD_P8x16Str(58,4,":");
        ADR.N    R2,??DataTable4  ;; ":"
        MOVS     R1,#+4
        MOVS     R0,#+58
        BL       LCD_P8x16Str
//   80     LCD_P8x16Str(16*3,6,":");
        ADR.N    R2,??DataTable4  ;; ":"
        MOVS     R1,#+6
        MOVS     R0,#+48
        BL       LCD_P8x16Str
        B.N      ??start_pic_10
//   81 
//   82   while(pic){
//   83   key();
??start_pic_11:
        BL       key
//   84   if(key_up==0||key_down==0){
        LDR.W    R0,??DataTable6_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??start_pic_12
        LDR.W    R0,??DataTable6_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??start_pic_10
//   85       delay(500);
??start_pic_12:
        MOV      R0,#+500
        BL       delay
//   86       if(key_up==0||key_down==0){
        LDR.W    R0,??DataTable6_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??start_pic_13
        LDR.W    R0,??DataTable6_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??start_pic_10
//   87         pic=0;
??start_pic_13:
        MOVS     R4,#+0
//   88       }
//   89     }
//   90 }
??start_pic_10:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+0
        BNE.N    ??start_pic_11
//   91 while(1){
//   92 	key();
??start_pic_14:
        BL       key
//   93 	if(key_up==1&&key_down==1)
        LDR.W    R0,??DataTable6_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??start_pic_15
        LDR.W    R0,??DataTable6_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??start_pic_15
//   94 		delay(500);
        MOV      R0,#+500
        BL       delay
//   95       if(key_up==1&&key_down==1)
??start_pic_15:
        LDR.W    R0,??DataTable6_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??start_pic_14
        LDR.W    R0,??DataTable6_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??start_pic_14
//   96       	break;
//   97 }
//   98   LCD_CLS();
        BL       LCD_CLS
//   99 }
        POP      {R0,R4,R5,PC}    ;; return
//  100 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  101 void die(FRESULT rc)
//  102 {
die:
        PUSH     {R4,LR}
//  103   //printf("错误代码 rc=%u.\n", rc);
//  104   LCD_P8x16Str(30,2,"SD Error!");
        LDR.W    R2,??DataTable6_7
        MOVS     R1,#+2
        MOVS     R0,#+30
        BL       LCD_P8x16Str
//  105   LCD_P8x16Str(30,4,"Check it");
        LDR.W    R2,??DataTable6_8
        MOVS     R1,#+4
        MOVS     R0,#+30
        BL       LCD_P8x16Str
//  106   rc = f_close(&fil);
        LDR.W    R0,??DataTable6_9
        BL       f_close
        MOVS     R4,R0
//  107   f_mount(0,NULL);
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       f_mount
//  108   while(1);
??die_0:
        B.N      ??die_0
//  109 }
//  110 // 用户自定义的为FatFs系统提供实时时间的函数

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  111 DWORD get_fattime (void)
//  112 {
//  113   return ((DWORD)(2018 - 1980) << 25) //2018年
//  114        | ((DWORD)12 << 21)               //12月
//  115        | ((DWORD)12 << 16)              //12日
//  116        | ((DWORD)0 << 11)
//  117        | ((DWORD)0 << 5)
//  118        | ((DWORD)0 >> 1);
get_fattime:
        LDR.W    R0,??DataTable6_10  ;; 0x4d8c0000
        BX       LR               ;; return
//  119 }
//  120 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  121 void readsd(void)
//  122 {
readsd:
        PUSH     {R1-R5,LR}
//  123   DWORD fre_clust,fre_sect,tot_sect;
//  124   unsigned char s[]="00000";
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable6_11
        MOVS     R2,#+6
        BL       __aeabi_memcpy
//  125   // 注册一个磁盘工作区
//  126    f_mount(0,&fatfs);
        LDR.W    R1,??DataTable6_12
        MOVS     R0,#+0
        BL       f_mount
//  127    //printf("\n读取容量.\n");
//  128    rc = f_getfree("0:", &fre_clust, &fs);
        LDR.W    R2,??DataTable6_13
        ADD      R1,SP,#+8
        ADR.N    R0,??DataTable5  ;; 0x30, 0x3A, 0x00, 0x00
        BL       f_getfree
        LDR.W    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
//  129    if (rc) die(rc);
        LDR.W    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??readsd_0
        LDR.W    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        BL       die
//  130    /* Get total sectors and free sectors */
//  131    tot_sect=(fs->n_fatent-2)*fs->csize;
??readsd_0:
        LDR.W    R0,??DataTable6_13
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+28]
        SUBS     R0,R0,#+2
        LDR.W    R1,??DataTable6_13
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+2]
        MUL      R4,R1,R0
//  132    fre_sect=fre_clust*fs->csize;
        LDR      R0,[SP, #+8]
        LDR.W    R1,??DataTable6_13
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+2]
        MUL      R5,R1,R0
//  133    LCD_P14x16Ch(6,2,46);
        MOVS     R2,#+46
        MOVS     R1,#+2
        MOVS     R0,#+6
        BL       LCD_P14x16Ch
//  134    LCD_P14x16Ch(30-10,2,42);
        MOVS     R2,#+42
        MOVS     R1,#+2
        MOVS     R0,#+20
        BL       LCD_P14x16Ch
//  135    LCD_P14x16Ch(44-10,2,43);
        MOVS     R2,#+43
        MOVS     R1,#+2
        MOVS     R0,#+34
        BL       LCD_P14x16Ch
//  136    LCD_P8x16Str(59-10,2,":");
        ADR.N    R2,??DataTable4  ;; ":"
        MOVS     R1,#+2
        MOVS     R0,#+49
        BL       LCD_P8x16Str
//  137    LCD_P14x16Ch(30-10,4,44);
        MOVS     R2,#+44
        MOVS     R1,#+4
        MOVS     R0,#+20
        BL       LCD_P14x16Ch
//  138    LCD_P14x16Ch(44-10,4,45);
        MOVS     R2,#+45
        MOVS     R1,#+4
        MOVS     R0,#+34
        BL       LCD_P14x16Ch
//  139    LCD_P8x16Str(59-10,4,":");
        ADR.N    R2,??DataTable4  ;; ":"
        MOVS     R1,#+4
        MOVS     R0,#+49
        BL       LCD_P8x16Str
//  140     s[0]=(int)((fre_sect/2/1024))/10000+48;
        LSRS     R0,R5,#+11
        MOVW     R1,#+10000
        SDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
//  141     s[1]=(int)((fre_sect/2/1024))/1000%10+48;
        LSRS     R0,R5,#+11
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+1]
//  142     s[2]=(int)((fre_sect/2/1024))/100%10+48;
        LSRS     R0,R5,#+11
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+2]
//  143     s[3]=(int)((fre_sect/2/1024))/10%10+48;
        LSRS     R0,R5,#+11
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+3]
//  144     s[4]=(int)((fre_sect/2/1024))%10+48;
        LSRS     R0,R5,#+11
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+4]
//  145     LCD_P8x16Str(58,4,s);
        ADD      R2,SP,#+0
        MOVS     R1,#+4
        MOVS     R0,#+58
        BL       LCD_P8x16Str
//  146     LCD_P8x16Str(58+5*8,2,"MB");
        ADR.N    R2,??DataTable5_1  ;; 0x4D, 0x42, 0x00, 0x00
        MOVS     R1,#+2
        MOVS     R0,#+98
        BL       LCD_P8x16Str
//  147     s[0]=(int)((tot_sect/2/1024))/10000+48;
        LSRS     R0,R4,#+11
        MOVW     R1,#+10000
        SDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
//  148     s[1]=(int)((tot_sect/2/1024))/1000%10+48;
        LSRS     R0,R4,#+11
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+1]
//  149     s[2]=(int)((tot_sect/2/1024))/100%10+48;
        LSRS     R0,R4,#+11
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+2]
//  150     s[3]=(int)((tot_sect/2/1024))/10%10+48;
        LSRS     R0,R4,#+11
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+3]
//  151     s[4]=(int)((tot_sect/2/1024))%10+48;
        LSRS     R0,R4,#+11
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+4]
//  152     LCD_P8x16Str(58,2,s);
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        MOVS     R0,#+58
        BL       LCD_P8x16Str
//  153     LCD_P8x16Str(58+5*8,4,"MB");
        ADR.N    R2,??DataTable5_1  ;; 0x4D, 0x42, 0x00, 0x00
        MOVS     R1,#+4
        MOVS     R0,#+98
        BL       LCD_P8x16Str
//  154     //printf("%lu MB total drive space.\n""%lu MB available.\n",fre_sect/2/1024,tot_sect/2/1024);
//  155     while(gamestart);
??readsd_1:
        LDR.N    R0,??DataTable6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??readsd_1
//  156     f_close(&fil);
        LDR.N    R0,??DataTable6_9
        BL       f_close
//  157     if (rc) die(rc);
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??readsd_2
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        BL       die
//  158     f_mount(0,NULL);
??readsd_2:
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       f_mount
//  159 }
        POP      {R0-R2,R4,R5,PC}  ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC8      ":",0x0,0x0
//  160 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  161 void badapple(uint8 spshu){
badapple:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  162   uint16 i;
//  163   // 注册一个磁盘工作区
//  164   //printf("1\n");
//  165   rc=f_mount(0,&fatfs);
        LDR.N    R1,??DataTable6_12
        MOVS     R0,#+0
        BL       f_mount
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
//  166   if (rc) die(rc);
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??badapple_0
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        BL       die
//  167   //打开的文件
//  168   //printf("2\n");
//  169   switch(spshu){
??badapple_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R0,R4
        CMP      R0,#+1
        BEQ.N    ??badapple_1
        CMP      R0,#+2
        BEQ.N    ??badapple_2
        B.N      ??badapple_3
//  170     case 1:rc=f_open(&fil, "0:/cartoon/badapple.bin", FA_READ);
??badapple_1:
        MOVS     R2,#+1
        LDR.N    R1,??DataTable6_15
        LDR.N    R0,??DataTable6_9
        BL       f_open
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
//  171           if (rc) die(rc);
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??badapple_4
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        BL       die
//  172           break;
??badapple_4:
        B.N      ??badapple_3
//  173     case 2:rc=f_open(&fil, "0:/cartoon/jljt.bin", FA_READ);
??badapple_2:
        MOVS     R2,#+1
        LDR.N    R1,??DataTable6_16
        LDR.N    R0,??DataTable6_9
        BL       f_open
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
//  174           if (rc) die(rc);
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??badapple_5
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        BL       die
//  175           break;
//  176   }
//  177   //printf("3\n");
//  178   //打印出文件内的内容
//  179   //printf("打印此文件内容.\n");
//  180   while(1)
//  181   {
//  182     switch(spshu){
??badapple_5:
??badapple_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R0,R4
        CMP      R0,#+1
        BEQ.N    ??badapple_6
        CMP      R0,#+2
        BEQ.N    ??badapple_7
        B.N      ??badapple_8
//  183       case 1:{
//  184         rc = f_read(&fil,buff_86,sizeof(buff_86),&br); // 读取文件的一块
??badapple_6:
        LDR.N    R3,??DataTable6_17
        MOV      R2,#+688
        LDR.N    R1,??DataTable6_18
        LDR.N    R0,??DataTable6_9
        BL       f_read
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
//  185         if (rc || !br) break;     // 错误或读取完毕
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??badapple_9
        LDR.N    R0,??DataTable6_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??badapple_10
??badapple_9:
        B.N      ??badapple_8
//  186         LCD_siping(21,86);
??badapple_10:
        MOVS     R1,#+86
        MOVS     R0,#+21
        BL       LCD_siping
//  187         break;}
        B.N      ??badapple_8
//  188       case 2:{
//  189         rc = f_read(&fil,buff_114,sizeof(buff_114),&br); // 读取文件的一块
??badapple_7:
        LDR.N    R3,??DataTable6_17
        MOV      R2,#+912
        LDR.N    R1,??DataTable6_19
        LDR.N    R0,??DataTable6_9
        BL       f_read
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
//  190         if (rc || !br) break;     // 错误或读取完毕
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??badapple_11
        LDR.N    R0,??DataTable6_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??badapple_12
??badapple_11:
        B.N      ??badapple_8
//  191         LCD_siping(7,114);
??badapple_12:
        MOVS     R1,#+114
        MOVS     R0,#+7
        BL       LCD_siping
//  192         break;}
//  193     }
//  194         	while(badapple_time);
??badapple_8:
        LDR.N    R0,??DataTable6_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??badapple_8
//  195           badapple_time=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_20
        STRB     R0,[R1, #+0]
//  196       if(gameing==0){
        LDR.N    R0,??DataTable6_1
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??badapple_3
//  197         rc = f_close(&fil);
        LDR.N    R0,??DataTable6_9
        BL       f_close
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
//  198         if (rc) die(rc);
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??badapple_13
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        BL       die
//  199         //printf("\n解除挂载.\n");
//  200         f_mount(0,NULL);
??badapple_13:
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       f_mount
//  201         return;
        POP      {R4,PC}          ;; return
//  202       }
//  203   }
//  204   //关闭文件
//  205   //printf("\n关闭文件.\n");
//  206   rc=f_close(&fil);
//  207   if (rc) die(rc);
//  208   //printf("\n解除挂载.\n");
//  209   f_mount(0,NULL);
//  210   if (rc) die(rc);
//  211     while(gameing);
//  212 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC8      0x30, 0x3A, 0x00, 0x00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC8      0x4D, 0x42, 0x00, 0x00
//  213 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  214 void flash_start(void){
flash_start:
        PUSH     {R3-R5,LR}
//  215   uint8 spshu=1;
        MOVS     R4,#+1
//  216   LCD_P14x16Ch(105,spshu*2+1,16);
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
//  217   uint8 a=33;
        MOVS     R0,#+33
//  218   uint8 b=45;
        MOVS     R1,#+45
//  219   uint8 d=1;
        MOVS     R5,#+1
        B.N      ??flash_start_0
//  220 while(1){
//  221 while(d){
//  222   if(gamestart==0)
//  223     return;
//  224   key();
//  225   LCD_P8x16Str(16,0,"Flash Player");
//  226   LCD_P8x16Str(20,3,"Bad Apple");
//  227   LCD_P8x16Str(20,5,"Garnidelia");
//  228   LCD_P14x16Ch(105,spshu*2+1,16);
//  229     if(key_up==0){
//  230       delay(500);
//  231       if(key_up==0){
//  232         spshu--;
//  233         playmusic(2);
//  234         if(spshu==0)
//  235           spshu=2;
//  236     LCD_P14x16Ch(105,3,15);
//  237     LCD_P14x16Ch(105,5,15);
//  238     //LCD_P14x16Ch(105,6,15);
//  239     LCD_P14x16Ch(105,spshu*2+1,16);
//  240       }while(!key_up){key();}
//  241     }
//  242     if(key_down==0){
//  243       delay(500);
//  244       if(key_down==0){
//  245         spshu++;
//  246         playmusic(2);
//  247         if(spshu==3)
//  248           spshu=1;
//  249     LCD_P14x16Ch(105,3,15);
//  250     LCD_P14x16Ch(105,5,15);
//  251     //LCD_P14x16Ch(105,6,15);
//  252     LCD_P14x16Ch(105,spshu*2+1,16);
//  253       }while(!key_down){key();}
//  254     }
//  255     if(key_left==0||key_right==0){
//  256       delay(500);
//  257       if(key_left==0||key_right==0){
//  258         d=0;
//  259       }while(!key_left||!key_right){key();}
//  260     }
//  261   }
//  262   LCD_CLS();
??flash_start_1:
        BL       LCD_CLS
//  263   gameing=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1
        STRH     R0,[R1, #+0]
//  264   badapple(spshu);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       badapple
//  265   LCD_CLS();
        BL       LCD_CLS
//  266   gamestart=1;d=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6
        STRH     R0,[R1, #+0]
        MOVS     R5,#+1
//  267   delay(100);
        MOVS     R0,#+100
        BL       delay
??flash_start_0:
??flash_start_2:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??flash_start_1
        LDR.N    R0,??DataTable6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??flash_start_3
        POP      {R0,R4,R5,PC}    ;; return
??flash_start_3:
        BL       key
        LDR.N    R2,??DataTable6_21
        MOVS     R1,#+0
        MOVS     R0,#+16
        BL       LCD_P8x16Str
        LDR.N    R2,??DataTable6_22
        MOVS     R1,#+3
        MOVS     R0,#+20
        BL       LCD_P8x16Str
        LDR.N    R2,??DataTable6_23
        MOVS     R1,#+5
        MOVS     R0,#+20
        BL       LCD_P8x16Str
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        LDR.N    R0,??DataTable6_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??flash_start_4
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable6_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??flash_start_5
        SUBS     R4,R4,#+1
        MOVS     R0,#+2
        BL       playmusic
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??flash_start_6
        MOVS     R4,#+2
??flash_start_6:
        MOVS     R2,#+15
        MOVS     R1,#+3
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+15
        MOVS     R1,#+5
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        B.N      ??flash_start_5
??flash_start_7:
        BL       key
??flash_start_5:
        LDR.N    R0,??DataTable6_5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??flash_start_7
??flash_start_4:
        LDR.N    R0,??DataTable6_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??flash_start_8
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable6_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??flash_start_9
        ADDS     R4,R4,#+1
        MOVS     R0,#+2
        BL       playmusic
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+3
        BNE.N    ??flash_start_10
        MOVS     R4,#+1
??flash_start_10:
        MOVS     R2,#+15
        MOVS     R1,#+3
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+15
        MOVS     R1,#+5
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        MOVS     R2,#+16
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+105
        BL       LCD_P14x16Ch
        B.N      ??flash_start_9
??flash_start_11:
        BL       key
??flash_start_9:
        LDR.N    R0,??DataTable6_6
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??flash_start_11
??flash_start_8:
        LDR.N    R0,??DataTable6_24
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??flash_start_12
        LDR.N    R0,??DataTable6_25
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??flash_start_2
??flash_start_12:
        MOV      R0,#+500
        BL       delay
        LDR.N    R0,??DataTable6_24
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??flash_start_13
        LDR.N    R0,??DataTable6_25
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??flash_start_14
??flash_start_13:
        MOVS     R5,#+0
        B.N      ??flash_start_14
??flash_start_15:
        BL       key
??flash_start_14:
        LDR.N    R0,??DataTable6_24
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??flash_start_15
        LDR.N    R0,??DataTable6_25
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??flash_start_2
        B.N      ??flash_start_15
//  268   }
//  269 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     gamestart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     gameing

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     mosixuanzi

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     gameover

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     wj_wzq

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     key_up

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     key_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     fil

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_10:
        DC32     0x4d8c0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_11:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_12:
        DC32     fatfs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_13:
        DC32     fs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_14:
        DC32     rc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_15:
        DC32     ?_6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_16:
        DC32     ?_7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_17:
        DC32     br

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_18:
        DC32     buff_86

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_19:
        DC32     buff_114

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_20:
        DC32     badapple_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_21:
        DC32     ?_8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_22:
        DC32     ?_9

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_23:
        DC32     ?_10

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_24:
        DC32     key_left

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_25:
        DC32     key_right

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 ":"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "SD Error!"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "Check it"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "00000"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "0:"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "MB"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_6:
        DATA
        DC8 "0:/cartoon/badapple.bin"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_7:
        DATA
        DC8 "0:/cartoon/jljt.bin"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_8:
        DATA
        DC8 "Flash Player"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_9:
        DATA
        DC8 "Bad Apple"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_10:
        DATA
        DC8 "Garnidelia"
        DC8 0

        END
// 
// 2 762 bytes in section .bss
//     7 bytes in section .data
//   126 bytes in section .rodata
// 1 786 bytes in section .text
// 
// 1 786 bytes of CODE  memory
//   126 bytes of CONST memory
// 2 769 bytes of DATA  memory
//
//Errors: none
//Warnings: 6
