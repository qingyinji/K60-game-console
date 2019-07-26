///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       14/May/2019  18:38:12
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\project\001-My NaoKe\app\tuixiangzi.c
//    Command line =  
//        "D:\2019.IAR\project\001-My NaoKe\app\tuixiangzi.c" -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\tuixiangzi.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_CLS
        EXTERN LCD_P128x64Ch1
        EXTERN LCD_P14x16Ch
        EXTERN LCD_P16x8Ch
        EXTERN LCD_P8x16Str
        EXTERN delay
        EXTERN flag
        EXTERN flag1
        EXTERN flag2
        EXTERN gameing
        EXTERN gameover
        EXTERN huatu1
        EXTERN key
        EXTERN key_down
        EXTERN key_left
        EXTERN key_right
        EXTERN key_up
        EXTERN playmusic
        EXTERN time
        EXTERN timeflag

        PUBLIC X
        PUBLIC cur_x
        PUBLIC cur_y
        PUBLIC dir
        PUBLIC fun
        PUBLIC gameovertxz
        PUBLIC judge
        PUBLIC map
        PUBLIC mapshu
        PUBLIC mat
        PUBLIC mat1
        PUBLIC mat2
        PUBLIC mat3
        PUBLIC show_map
        PUBLIC show_start
        PUBLIC start
        PUBLIC tuixiangzi
        PUBLIC wherex
        PUBLIC wherey

// D:\2019.IAR\project\001-My NaoKe\app\tuixiangzi.c
//    1 #include "common.h"
//    2 #include "LQ12864.h"
//    3 #include "tuixiangzi.h"
//    4 #include "yingjian.h"
//    5 extern uint16 key_up,key_down,key_left,key_right;//分别对应摇杆的上下左右
//    6 extern uint16 flag;//返回
//    7 extern uint16 flag1,flag2;
//    8 extern uint16 time;
//    9 extern uint16 timeflag;
//   10 extern uint16 gameover,gameing,xuanzhetx;
//   11 extern uint16 huatu1[8][8];//储存自制地图
//   12 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   13 uint16 cur_x,cur_y,X,dir[4][2]={-1,0,1,0,0,-1,0,1},wherex[4]={0,0,0,0},wherey[4]={0,0,0,0};
cur_x:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
cur_y:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
X:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(2)
dir:
        DATA
        DC16 65535, 0, 1, 0, 0, 65535, 0, 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
wherex:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
wherey:
        DS8 8

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   14 uint16 mat1[8][8]={  // 0表示空格，1表示墙，2表示人，3表示箱子，4表示目的地
mat1:
        DATA
        DC16 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1
        DC16 1, 1, 1, 1, 1, 3, 0, 3, 4, 1, 1, 4, 0, 3, 2, 1, 1, 1, 1, 1, 1, 1
        DC16 3, 1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
//   15 1,1,1,1,1,1,1,1,
//   16 1,1,1,4,1,1,1,1,
//   17 1,1,1,0,1,1,1,1,
//   18 1,1,1,3,0,3,4,1,
//   19 1,4,0,3,2,1,1,1,
//   20 1,1,1,1,3,1,1,1,
//   21 1,1,1,1,4,1,1,1,
//   22 1,1,1,1,1,1,1,1
//   23 };

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   24 uint16 mat2[8][8]={
mat2:
        DATA
        DC16 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, 1, 1, 1, 1, 0, 0, 3, 0
        DC16 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 4, 1, 1, 0, 1, 0
        DC16 0, 3, 4, 1, 1, 0, 3, 0, 0, 0, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1
//   25 1,1,1,1,1,1,1,1,
//   26 1,1,1,1,0,2,1,1,
//   27 1,1,0,0,3,0,1,1,
//   28 1,1,0,1,0,1,1,1,
//   29 1,0,0,1,0,1,4,1,
//   30 1,0,1,0,0,3,4,1,
//   31 1,0,3,0,0,0,4,1,
//   32 1,1,1,1,1,1,1,1
//   33 };

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   34 uint16 mat3[8][8]={
mat3:
        DATA
        DC16 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 2, 3, 0, 1
        DC16 1, 1, 1, 1, 1, 3, 0, 1, 1, 1, 1, 1, 1, 0, 3, 0, 1, 1, 1, 1, 4, 3
        DC16 0, 0, 1, 1, 1, 1, 4, 4, 0, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
//   35 1,1,1,1,1,1,1,1,
//   36 1,1,1,0,0,1,1,1,
//   37 1,1,2,3,0,1,1,1,
//   38 1,1,1,3,0,1,1,1,
//   39 1,1,1,0,3,0,1,1,
//   40 1,1,4,3,0,0,1,1,
//   41 1,1,4,4,0,4,1,1,
//   42 1,1,1,1,1,1,1,1
//   43 };

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   44 uint16 map[8][8];
map:
        DS8 128

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   45 uint16 mat[8][8];
mat:
        DS8 128

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   46 uint16 mapshu=1;
mapshu:
        DATA
        DC16 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   47 uint16 gameovertxz=0;
gameovertxz:
        DS8 2
//   48 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void tuixiangzi(void){
tuixiangzi:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        B.N      ??tuixiangzi_0
//   50   head:
//   51   //playmusic();
//   52   show_start();//显示地图选择界面
//   53   //if(gameover==1)
//   54       if(gameovertxz==1){//判断是否退出
//   55         gameovertxz=0;
//   56         flag=mapshu=1;gameovertxz=flag1=flag2=0;return;//清空所有标志
//   57       }
//   58   start();//读取地图数据
//   59   show_map();//显示地图
//   60   uint16 i,num,index=6;
//   61   uint16 bushu=0;
//   62   uint16 cj=500;
//   63   unsigned char s[]="0";
//   64   /////////////////////////////显示右面板信息
//   65   for (uint16 i=0;i<3;++i){
//   66       LCD_P14x16Ch(66+i*14,0,i);
//   67     }
//   68       LCD_P8x16Str(66+14*2,0,":");
//   69   for (uint16 i=0;i<2;++i){
//   70       LCD_P14x16Ch(66+i*14,2,i+17);
//   71     }
//   72       LCD_P8x16Str(66+14*2,2,":");
//   73 ////////////////////////////////////////////
//   74       gameing=1;
//   75   while(1){
//   76     if(gameover==1)
//   77       if(gameovertxz==1){
//   78         gameovertxz=0;return;
//   79       }
//   80     key();//查询摇杆状态
//   81     delay(1000);
//   82     gameover=0;//游戏退出标志位为0，1为退出
//   83     ///////////////////////////显示右面板的步数、剩余时间
//   84     s[0]=(int)bushu/10+48;
//   85     LCD_P8x16Str(66+14*2+8,0,s);
//   86     s[0]=bushu%10+48;
//   87     LCD_P8x16Str(66+14*2+16,0,s);
//   88     timeflag=1;
//   89     s[0]=(int)time/10+48;
//   90     LCD_P8x16Str(66+14*2+8,2,s);
//   91     s[0]=time%10+48;
//   92     LCD_P8x16Str(66+14*2+16,2,s);
//   93     ////////////////////////////////////////////
//   94     if(flag2==1){
//   95       flag2=0;
??tuixiangzi_1:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable4
        STRH     R0,[R1, #+0]
//   96       gameover=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+0]
//   97       LCD_CLS();
        BL       LCD_CLS
//   98       goto head;
//   99     }
??tuixiangzi_0:
        BL       show_start
        LDR.W    R0,??DataTable5_1
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??tuixiangzi_2
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_2
        STRH     R0,[R1, #+0]
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable5_3
        STRH     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable4
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable5_4
        STRH     R0,[R1, #+0]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+0]
??tuixiangzi_3:
        POP      {R0,R1,R4-R6,PC}  ;; return
??tuixiangzi_2:
        BL       start
        BL       show_map
        MOVS     R0,#+6
        MOVS     R4,#+0
        MOV      R5,#+500
        LDR.W    R1,??DataTable5_5
        LDRH     R1,[R1, #+0]
        STRH     R1,[SP, #+0]
        MOVS     R6,#+0
        B.N      ??tuixiangzi_4
??tuixiangzi_5:
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R6
        ADDS     R0,R0,#+66
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R6,R6,#+1
??tuixiangzi_4:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+3
        BLT.N    ??tuixiangzi_5
        ADR.N    R2,??DataTable0  ;; ":"
        MOVS     R1,#+0
        MOVS     R0,#+94
        BL       LCD_P8x16Str
        MOVS     R5,#+0
        B.N      ??tuixiangzi_6
??tuixiangzi_7:
        ADDS     R2,R5,#+17
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R5
        ADDS     R0,R0,#+66
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R5,R5,#+1
??tuixiangzi_6:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+2
        BLT.N    ??tuixiangzi_7
        ADR.N    R2,??DataTable0  ;; ":"
        MOVS     R1,#+2
        MOVS     R0,#+94
        BL       LCD_P8x16Str
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_6
        STRH     R0,[R1, #+0]
??tuixiangzi_8:
        LDR.W    R0,??DataTable5
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??tuixiangzi_9
        LDR.W    R0,??DataTable5_1
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??tuixiangzi_9
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+0]
        B.N      ??tuixiangzi_3
??tuixiangzi_9:
        BL       key
        MOV      R0,#+1000
        BL       delay
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+0]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+10
        SDIV     R0,R4,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        MOVS     R0,#+102
        BL       LCD_P8x16Str
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+10
        SDIV     R1,R4,R0
        MLS      R0,R0,R1,R4
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        MOVS     R0,#+110
        BL       LCD_P8x16Str
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_7
        STRH     R0,[R1, #+0]
        LDR.W    R0,??DataTable5_8
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        MOVS     R0,#+102
        BL       LCD_P8x16Str
        LDR.W    R0,??DataTable5_8
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        MOVS     R0,#+110
        BL       LCD_P8x16Str
        LDR.W    R0,??DataTable4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.W    ??tuixiangzi_1
//  100     if(time==0)
        LDR.W    R0,??DataTable5_8
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_10
//  101       goto LOSS;
//  102     num=0;
//  103     for(i=0;i<X;i++){
//  104       if(map[wherex[i]][wherey[i]]==3)num++;
//  105       else break;
//  106     }
//  107     if(num==X)goto WIN;
//  108     if(key_up==0){
//  109       delay(500);
//  110       if(key_up==0){
//  111         index=judge(cur_x,cur_y,2);
//  112         fun(index,2);
//  113         bushu++;
//  114       }while(!key_up){key();}
//  115     }
//  116     else if(key_down==0){
//  117       delay(500);
//  118       if(key_down==0){
//  119         index=judge(cur_x,cur_y,3);
//  120         fun(index,3);
//  121         bushu++;
//  122       }while(!key_down){key();}
//  123     }
//  124     else if(key_left==0){
//  125       delay(500);
//  126       if(key_left==0){
//  127         index=judge(cur_x,cur_y,0);
//  128         fun(index,0);
//  129         bushu++;
//  130       }while(!key_left){key();}
//  131     }
//  132     else if(key_right==0){
//  133       delay(500);
//  134       if(key_right==0){
//  135         index=judge(cur_x,cur_y,1);
//  136         fun(index,1);
//  137         bushu++;
//  138       }while(!key_right){key();}
//  139     }
//  140   }
//  141 WIN:
//  142   gameover=1;
//  143   gameing=0;
//  144   for (uint16 i=0;i<4;++i){
//  145       LCD_P14x16Ch(66+i*14,2,i+2);
//  146     }
//  147     cj=(int)(((100-bushu)+time)/2);
//  148     s[0]=(int)cj/100+48;
//  149     LCD_P8x16Str(66+14+8,4,s);
//  150     s[0]=(int)cj/10+48;
//  151     LCD_P8x16Str(66+14+8,4,s);
//  152     s[0]=cj%10+48;
//  153     LCD_P8x16Str(66+14+16,4,s);
//  154   LCD_P8x16Str(66,6,"YON WIN");
//  155   flag1=1;
//  156   while(flag);
//  157   flag=1;
//  158   LCD_CLS();
//  159   goto head;
//  160 
//  161 LOSS:
//  162 gameover=1;gameing=0;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_6
        STRH     R0,[R1, #+0]
//  163 //LCD_P8x16Str(66,6,"YON DIE");
//  164 //delay(1000);
//  165 LCD_CLS();
        BL       LCD_CLS
//  166   LCD_P128x64Ch1();
        BL       LCD_P128x64Ch1
//  167   for (uint16 i=0;i<4;++i){
        MOVS     R4,#+0
        B.N      ??tuixiangzi_11
??tuixiangzi_10:
        MOVS     R1,#+0
        MOVS     R0,#+0
        B.N      ??tuixiangzi_12
??tuixiangzi_13:
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
??tuixiangzi_12:
        LDR.W    R2,??DataTable5_9
        LDRH     R2,[R2, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,R2
        BCS.N    ??tuixiangzi_14
        LDR.W    R2,??DataTable5_10
        LDR.W    R3,??DataTable5_11
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R3,[R3, R0, LSL #+1]
        ADDS     R2,R2,R3, LSL #+4
        LDR.W    R3,??DataTable5_12
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R3,[R3, R0, LSL #+1]
        LDRH     R2,[R2, R3, LSL #+1]
        CMP      R2,#+3
        BEQ.N    ??tuixiangzi_13
??tuixiangzi_14:
        LDR.W    R0,??DataTable5_9
        LDRH     R0,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,R0
        BNE.N    ??tuixiangzi_15
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_6
        STRH     R0,[R1, #+0]
        MOVS     R5,#+0
        B.N      ??tuixiangzi_16
??tuixiangzi_15:
        LDR.W    R0,??DataTable5_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_17
        MOV      R0,#+500
        BL       delay
        LDR.W    R0,??DataTable5_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_18
        MOVS     R2,#+2
        LDR.W    R0,??DataTable5_14
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable5_15
        LDRH     R0,[R0, #+0]
        BL       judge
        MOVS     R1,#+2
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       fun
        ADDS     R4,R4,#+1
??tuixiangzi_18:
        LDR.W    R0,??DataTable5_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??tuixiangzi_8
        BL       key
        B.N      ??tuixiangzi_18
??tuixiangzi_17:
        LDR.W    R0,??DataTable5_16
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_19
        MOV      R0,#+500
        BL       delay
        LDR.W    R0,??DataTable5_16
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_20
        MOVS     R2,#+3
        LDR.W    R0,??DataTable5_14
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable5_15
        LDRH     R0,[R0, #+0]
        BL       judge
        MOVS     R1,#+3
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       fun
        ADDS     R4,R4,#+1
??tuixiangzi_20:
        LDR.W    R0,??DataTable5_16
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??tuixiangzi_8
        BL       key
        B.N      ??tuixiangzi_20
??tuixiangzi_19:
        LDR.W    R0,??DataTable5_17
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_21
        MOV      R0,#+500
        BL       delay
        LDR.W    R0,??DataTable5_17
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_22
        MOVS     R2,#+0
        LDR.W    R0,??DataTable5_14
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable5_15
        LDRH     R0,[R0, #+0]
        BL       judge
        MOVS     R1,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       fun
        ADDS     R4,R4,#+1
??tuixiangzi_22:
        LDR.W    R0,??DataTable5_17
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??tuixiangzi_8
        BL       key
        B.N      ??tuixiangzi_22
??tuixiangzi_21:
        LDR.W    R0,??DataTable5_18
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??tuixiangzi_8
        MOV      R0,#+500
        BL       delay
        LDR.W    R0,??DataTable5_18
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_23
        MOVS     R2,#+1
        LDR.W    R0,??DataTable5_14
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable5_15
        LDRH     R0,[R0, #+0]
        BL       judge
        MOVS     R1,#+1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       fun
        ADDS     R4,R4,#+1
??tuixiangzi_23:
        LDR.W    R0,??DataTable5_18
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??tuixiangzi_8
        BL       key
        B.N      ??tuixiangzi_23
??tuixiangzi_24:
        ADDS     R2,R5,#+2
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R5
        ADDS     R0,R0,#+66
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R5,R5,#+1
??tuixiangzi_16:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+4
        BLT.N    ??tuixiangzi_24
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        RSBS     R0,R4,#+100
        LDR.W    R1,??DataTable5_8
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        MOVS     R1,#+2
        SDIV     R5,R0,R1
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R0,#+100
        SDIV     R0,R5,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
        ADD      R2,SP,#+0
        MOVS     R1,#+4
        MOVS     R0,#+88
        BL       LCD_P8x16Str
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R0,#+10
        SDIV     R0,R5,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
        ADD      R2,SP,#+0
        MOVS     R1,#+4
        MOVS     R0,#+88
        BL       LCD_P8x16Str
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R0,#+10
        SDIV     R1,R5,R0
        MLS      R0,R0,R1,R5
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+0]
        ADD      R2,SP,#+0
        MOVS     R1,#+4
        MOVS     R0,#+96
        BL       LCD_P8x16Str
        LDR.W    R2,??DataTable5_19
        MOVS     R1,#+6
        MOVS     R0,#+66
        BL       LCD_P8x16Str
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_4
        STRH     R0,[R1, #+0]
??tuixiangzi_25:
        LDR.W    R0,??DataTable5_3
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_25
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_3
        STRH     R0,[R1, #+0]
        BL       LCD_CLS
        B.N      ??tuixiangzi_0
//  168       LCD_P14x16Ch(100,i*2,i+19);
??tuixiangzi_26:
        ADDS     R2,R4,#+19
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R1,R0,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+100
        BL       LCD_P14x16Ch
//  169     }
        ADDS     R4,R4,#+1
??tuixiangzi_11:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+4
        BLT.N    ??tuixiangzi_26
//  170   flag1=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_4
        STRH     R0,[R1, #+0]
//  171   while(flag);
??tuixiangzi_27:
        LDR.W    R0,??DataTable5_3
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??tuixiangzi_27
//  172   flag=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_3
        STRH     R0,[R1, #+0]
//  173   LCD_CLS();
        BL       LCD_CLS
//  174   goto head;
        B.N      ??tuixiangzi_0
//  175 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC8      ":",0x0,0x0
//  176 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  177 void show_start(void){
show_start:
        PUSH     {R4-R6,LR}
//  178   uint16 a=33;
        MOVS     R6,#+33
//  179   uint16 b=45;
        MOVS     R4,#+45
//  180   uint16 d=1;
        MOVS     R5,#+1
//  181   LCD_P14x16Ch(80,mapshu*2-2,16);
        MOVS     R2,#+16
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        LSLS     R0,R0,#+1
        SUBS     R1,R0,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  182   gameovertxz=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+0]
//  183 while(d){
??show_start_0:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BEQ.W    ??show_start_1
//  184   if(gameovertxz)
        LDR.W    R0,??DataTable5_1
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??show_start_2
//  185     return;
//  186   key();
??show_start_3:
        BL       key
//  187     for (uint16 i=0;i<2;++i){
        MOVS     R6,#+0
        B.N      ??show_start_4
//  188       LCD_P14x16Ch(b+14*i,0,i+9);}//地图1
??show_start_5:
        ADDS     R2,R6,#+9
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+0
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R6
        UXTAH    R0,R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R6,R6,#+1
??show_start_4:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+2
        BLT.N    ??show_start_5
//  189       for (uint16 i=0;i<2;++i){
        MOVS     R6,#+0
        B.N      ??show_start_6
//  190       LCD_P14x16Ch(b+14*i,2,i+11);}//地图2
??show_start_7:
        ADDS     R2,R6,#+11
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+2
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R6
        UXTAH    R0,R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R6,R6,#+1
??show_start_6:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+2
        BLT.N    ??show_start_7
//  191       for (uint16 i=0;i<2;++i){
        MOVS     R6,#+0
        B.N      ??show_start_8
//  192       LCD_P14x16Ch(b+14*i,4,i+13);}//地图3
??show_start_9:
        ADDS     R2,R6,#+13
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+4
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R6
        UXTAH    R0,R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R6,R6,#+1
??show_start_8:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+2
        BLT.N    ??show_start_9
//  193       for (uint16 i=0;i<2;++i){
        MOVS     R6,#+0
        B.N      ??show_start_10
//  194       LCD_P14x16Ch(b+14*i,6,i+55);}//地图4
??show_start_11:
        ADDS     R2,R6,#+55
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+6
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+14
        MUL      R0,R0,R6
        UXTAH    R0,R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P14x16Ch
        ADDS     R6,R6,#+1
??show_start_10:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+2
        BLT.N    ??show_start_11
//  195     if(key_up==0){
        LDR.W    R0,??DataTable5_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??show_start_12
//  196       delay(500);
        MOV      R0,#+500
        BL       delay
//  197       if(key_up==0){
        LDR.W    R0,??DataTable5_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??show_start_13
//  198         mapshu--;
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable5_2
        STRH     R0,[R1, #+0]
//  199         playmusic(2);
        MOVS     R0,#+2
        BL       playmusic
//  200         if(mapshu==0)
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??show_start_14
//  201           mapshu=4;
        MOVS     R0,#+4
        LDR.W    R1,??DataTable5_2
        STRH     R0,[R1, #+0]
//  202     LCD_P14x16Ch(80,0,15);
??show_start_14:
        MOVS     R2,#+15
        MOVS     R1,#+0
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  203     LCD_P14x16Ch(80,2,15);
        MOVS     R2,#+15
        MOVS     R1,#+2
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  204     LCD_P14x16Ch(80,4,15);
        MOVS     R2,#+15
        MOVS     R1,#+4
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  205     LCD_P14x16Ch(80,6,15);
        MOVS     R2,#+15
        MOVS     R1,#+6
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  206     LCD_P14x16Ch(80,mapshu*2-2,16);
        MOVS     R2,#+16
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        LSLS     R0,R0,#+1
        SUBS     R1,R0,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
        B.N      ??show_start_13
//  207       }while(!key_up){key();}
??show_start_15:
        BL       key
??show_start_13:
        LDR.W    R0,??DataTable5_13
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??show_start_15
//  208     }
//  209     if(key_down==0){
??show_start_12:
        LDR.W    R0,??DataTable5_16
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??show_start_16
//  210       delay(500);
        MOV      R0,#+500
        BL       delay
//  211       if(key_down==0){
        LDR.W    R0,??DataTable5_16
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??show_start_17
//  212         mapshu++;
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable5_2
        STRH     R0,[R1, #+0]
//  213         playmusic(2);
        MOVS     R0,#+2
        BL       playmusic
//  214         if(mapshu==5)
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??show_start_18
//  215           mapshu=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_2
        STRH     R0,[R1, #+0]
//  216     LCD_P14x16Ch(80,0,15);
??show_start_18:
        MOVS     R2,#+15
        MOVS     R1,#+0
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  217     LCD_P14x16Ch(80,2,15);
        MOVS     R2,#+15
        MOVS     R1,#+2
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  218     LCD_P14x16Ch(80,4,15);
        MOVS     R2,#+15
        MOVS     R1,#+4
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  219     LCD_P14x16Ch(80,6,15);
        MOVS     R2,#+15
        MOVS     R1,#+6
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
//  220     LCD_P14x16Ch(80,mapshu*2-2,16);
        MOVS     R2,#+16
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        LSLS     R0,R0,#+1
        SUBS     R1,R0,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+80
        BL       LCD_P14x16Ch
        B.N      ??show_start_17
//  221       }while(!key_down){key();}
??show_start_19:
        BL       key
??show_start_17:
        LDR.W    R0,??DataTable5_16
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??show_start_19
//  222     }
//  223     if(key_left==0||key_right==0){
??show_start_16:
        LDR.W    R0,??DataTable5_17
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??show_start_20
        LDR.W    R0,??DataTable5_18
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??show_start_0
//  224       delay(500);
??show_start_20:
        MOV      R0,#+500
        BL       delay
//  225       if(key_left==0||key_right==0){
        LDR.W    R0,??DataTable5_17
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??show_start_21
        LDR.W    R0,??DataTable5_18
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??show_start_22
//  226         d=0;
??show_start_21:
        MOVS     R5,#+0
//  227       }while(!key_left||!key_right){key();}
??show_start_22:
        LDR.W    R0,??DataTable5_17
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??show_start_23
        LDR.W    R0,??DataTable5_18
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??show_start_0
??show_start_23:
        BL       key
        B.N      ??show_start_22
//  228     }
//  229   }
//  230 LCD_CLS();
??show_start_1:
        BL       LCD_CLS
//  231 }
??show_start_2:
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  232 void start(void){
start:
        SUB      SP,SP,#+16
//  233   uint16 i,j;
//  234 
//  235   switch(mapshu){
        LDR.W    R0,??DataTable5_2
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??start_0
        BCC.W    ??start_1
        CMP      R0,#+3
        BEQ.N    ??start_2
        BCC.W    ??start_3
        CMP      R0,#+4
        BEQ.W    ??start_4
        B.N      ??start_1
//  236     case 1:{
//  237       time=30;
??start_0:
        MOVS     R0,#+30
        LDR.W    R1,??DataTable5_8
        STRH     R0,[R1, #+0]
//  238       cur_x=4; cur_y=4;
        MOVS     R0,#+4
        LDR.W    R1,??DataTable5_15
        STRH     R0,[R1, #+0]
        MOVS     R0,#+4
        LDR.W    R1,??DataTable5_14
        STRH     R0,[R1, #+0]
//  239       uint16 wherex1[4]={1,4,6,3};
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable5_20
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//  240       uint16 wherey1[4]={4,6,3,1};
        ADD      R0,SP,#+8
        LDR.W    R1,??DataTable5_21
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//  241       for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??start_5
//  242         wherex[i]=wherex1[i];
??start_6:
        ADD      R1,SP,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??DataTable5_11
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_5:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+4
        BLT.N    ??start_6
//  243       for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??start_7
//  244         wherey[i]=wherey1[i];
??start_8:
        ADD      R1,SP,#+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??DataTable5_12
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_7:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+4
        BLT.N    ??start_8
//  245       X=4;
        MOVS     R0,#+4
        LDR.W    R1,??DataTable5_9
        STRH     R0,[R1, #+0]
//  246        for(i=0;i<8;i++){
        MOVS     R0,#+0
        B.N      ??start_9
//  247         for(j=0;j<8;j++)mat[i][j]=mat1[i][j];
??start_10:
        LDR.W    R2,??DataTable5_22
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.W    R3,??DataTable5_23
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R3,R3,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R3,[R3, R1, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_11:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_10
        ADDS     R0,R0,#+1
??start_9:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_12
        MOVS     R1,#+0
        B.N      ??start_11
//  248       }
//  249       for(i=0;i<8;i++){
??start_12:
        MOVS     R0,#+0
        B.N      ??start_13
//  250         for(j=0;j<8;j++)map[i][j]=mat[j][i];
??start_14:
        LDR.W    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.W    R3,??DataTable5_22
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R3,R3,R1, LSL #+4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R3,[R3, R0, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_15:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_14
        ADDS     R0,R0,#+1
??start_13:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_16
        MOVS     R1,#+0
        B.N      ??start_15
//  251       }
//  252       break;}
??start_16:
        B.N      ??start_1
//  253     case 3:{
//  254       time=35;
??start_2:
        MOVS     R0,#+35
        LDR.W    R1,??DataTable5_8
        STRH     R0,[R1, #+0]
//  255       cur_x=5; cur_y=1;
        MOVS     R0,#+5
        LDR.W    R1,??DataTable5_15
        STRH     R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.W    R1,??DataTable5_14
        STRH     R0,[R1, #+0]
//  256       uint16 wherex1[4]={6,6,6,0};
        ADD      R0,SP,#+8
        LDR.W    R1,??DataTable5_24
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//  257       uint16 wherey1[4]={4,5,6,0};
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable5_25
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//  258       for(i=0;i<3;i++)
        MOVS     R0,#+0
        B.N      ??start_17
//  259         wherex[i]=wherex1[i];
??start_18:
        ADD      R1,SP,#+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??DataTable5_11
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_17:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+3
        BLT.N    ??start_18
//  260       for(i=0;i<3;i++)
        MOVS     R0,#+0
        B.N      ??start_19
//  261         wherey[i]=wherey1[i];
??start_20:
        ADD      R1,SP,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??DataTable5_12
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_19:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+3
        BLT.N    ??start_20
//  262       X=3;
        MOVS     R0,#+3
        LDR.W    R1,??DataTable5_9
        STRH     R0,[R1, #+0]
//  263        for(i=0;i<8;i++){
        MOVS     R0,#+0
        B.N      ??start_21
//  264         for(j=0;j<8;j++)mat[i][j]=mat2[i][j];
??start_22:
        LDR.W    R2,??DataTable5_22
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.W    R3,??DataTable5_26
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R3,R3,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R3,[R3, R1, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_23:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_22
        ADDS     R0,R0,#+1
??start_21:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_24
        MOVS     R1,#+0
        B.N      ??start_23
//  265       }
//  266       for(i=0;i<8;i++){
??start_24:
        MOVS     R0,#+0
        B.N      ??start_25
//  267         for(j=0;j<8;j++)map[i][j]=mat[j][i];
??start_26:
        LDR.W    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.W    R3,??DataTable5_22
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R3,R3,R1, LSL #+4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R3,[R3, R0, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_27:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_26
        ADDS     R0,R0,#+1
??start_25:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_28
        MOVS     R1,#+0
        B.N      ??start_27
//  268       }
//  269       break;}
??start_28:
        B.N      ??start_1
//  270     case 2:{
//  271       time=40;
??start_3:
        MOVS     R0,#+40
        LDR.W    R1,??DataTable5_8
        STRH     R0,[R1, #+0]
//  272       cur_x=2; cur_y=2;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable5_15
        STRH     R0,[R1, #+0]
        MOVS     R0,#+2
        LDR.W    R1,??DataTable5_14
        STRH     R0,[R1, #+0]
//  273       uint16 wherex1[4]={2,2,3,5};
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable5_27
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//  274       uint16 wherey1[4]={5,6,6,6};
        ADD      R0,SP,#+8
        LDR.W    R1,??DataTable5_28
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//  275       for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??start_29
//  276         wherex[i]=wherex1[i];
??start_30:
        ADD      R1,SP,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??DataTable5_11
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_29:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+4
        BLT.N    ??start_30
//  277       for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??start_31
//  278         wherey[i]=wherey1[i];
??start_32:
        ADD      R1,SP,#+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.W    R2,??DataTable5_12
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_31:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+4
        BLT.N    ??start_32
//  279       X=4;
        MOVS     R0,#+4
        LDR.W    R1,??DataTable5_9
        STRH     R0,[R1, #+0]
//  280        for(i=0;i<8;i++){
        MOVS     R0,#+0
        B.N      ??start_33
//  281         for(j=0;j<8;j++)mat[i][j]=mat3[i][j];
??start_34:
        LDR.W    R2,??DataTable5_22
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.W    R3,??DataTable5_29
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R3,R3,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R3,[R3, R1, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_35:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_34
        ADDS     R0,R0,#+1
??start_33:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_36
        MOVS     R1,#+0
        B.N      ??start_35
//  282       }
//  283       for(i=0;i<8;i++){
??start_36:
        MOVS     R0,#+0
        B.N      ??start_37
//  284         for(j=0;j<8;j++)map[i][j]=mat[j][i];
??start_38:
        LDR.W    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.W    R3,??DataTable5_22
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R3,R3,R1, LSL #+4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R3,[R3, R0, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_39:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_38
        ADDS     R0,R0,#+1
??start_37:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_40
        MOVS     R1,#+0
        B.N      ??start_39
//  285       }
//  286       break;}
??start_40:
        B.N      ??start_1
//  287 
//  288       case 4:{
//  289       time=50;X=0;
??start_4:
        MOVS     R0,#+50
        LDR.W    R1,??DataTable5_8
        STRH     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_9
        STRH     R0,[R1, #+0]
//  290       uint16 wherex1[4]={0};
        ADD      R0,SP,#+8
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
//  291       uint16 wherey1[4]={0};
        ADD      R0,SP,#+0
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
//  292       cur_x=2; cur_y=2;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable5_15
        STRH     R0,[R1, #+0]
        MOVS     R0,#+2
        LDR.W    R1,??DataTable5_14
        STRH     R0,[R1, #+0]
//  293       for(uint16 aaa=0;aaa<8;aaa++){
        MOVS     R0,#+0
        B.N      ??start_41
//  294         for(uint16 bbb=0;bbb<8;bbb++){
//  295           if(huatu1[aaa][bbb]==4){
??start_42:
        LDR.W    R2,??DataTable5_30
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R2,[R2, R1, LSL #+1]
        CMP      R2,#+4
        BNE.N    ??start_43
//  296             wherex1[X]=aaa;
        ADD      R2,SP,#+8
        LDR.W    R3,??DataTable5_9
        LDRH     R3,[R3, #+0]
        STRH     R0,[R2, R3, LSL #+1]
//  297             wherey1[X]=bbb;
        ADD      R2,SP,#+0
        LDR.W    R3,??DataTable5_9
        LDRH     R3,[R3, #+0]
        STRH     R1,[R2, R3, LSL #+1]
//  298             X++;
        LDR.W    R2,??DataTable5_9
        LDRH     R2,[R2, #+0]
        ADDS     R2,R2,#+1
        LDR.W    R3,??DataTable5_9
        STRH     R2,[R3, #+0]
//  299           }
//  300         }
??start_43:
        ADDS     R1,R1,#+1
??start_44:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_42
        ADDS     R0,R0,#+1
??start_41:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_45
        MOVS     R1,#+0
        B.N      ??start_44
//  301       }
//  302       for(i=0;i<4;i++)
??start_45:
        MOVS     R0,#+0
        B.N      ??start_46
//  303         wherex[i]=wherex1[i];
??start_47:
        ADD      R1,SP,#+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.N    R2,??DataTable5_11
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_46:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+4
        BLT.N    ??start_47
//  304       for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??start_48
//  305         wherey[i]=wherey1[i];
??start_49:
        ADD      R1,SP,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R1,[R1, R0, LSL #+1]
        LDR.N    R2,??DataTable5_12
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STRH     R1,[R2, R0, LSL #+1]
        ADDS     R0,R0,#+1
??start_48:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+4
        BLT.N    ??start_49
//  306       //X=4;
//  307        for(i=0;i<8;i++){
        MOVS     R0,#+0
        B.N      ??start_50
//  308         for(j=0;j<8;j++)mat[i][j]=huatu1[j][i];
??start_51:
        LDR.N    R2,??DataTable5_22
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R3,??DataTable5_30
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R3,R3,R1, LSL #+4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R3,[R3, R0, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_52:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_51
        ADDS     R0,R0,#+1
??start_50:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_53
        MOVS     R1,#+0
        B.N      ??start_52
//  309       }
//  310       for(i=0;i<8;i++){
??start_53:
        MOVS     R0,#+0
        B.N      ??start_54
//  311         for(j=0;j<8;j++)map[i][j]=mat[j][i];
??start_55:
        LDR.N    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R3,??DataTable5_22
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R3,R3,R1, LSL #+4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRH     R3,[R3, R0, LSL #+1]
        STRH     R3,[R2, R1, LSL #+1]
        ADDS     R1,R1,#+1
??start_56:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+8
        BLT.N    ??start_55
        ADDS     R0,R0,#+1
??start_54:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+8
        BGE.N    ??start_57
        MOVS     R1,#+0
        B.N      ??start_56
//  312       }
//  313       break;}
//  314   }
//  315 }
??start_57:
??start_1:
        ADD      SP,SP,#+16
        BX       LR               ;; return
//  316 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  317 void show_map(void){
show_map:
        PUSH     {R3-R5,LR}
//  318   uint16 i,j;
//  319 
//  320   for(i=0;i<8;i++){
        MOVS     R4,#+0
        B.N      ??show_map_0
//  321     for(j=0;j<8;j++){
//  322       LCD_P16x8Ch(i*8,j,map[i][j]);
??show_map_1:
        LDR.N    R0,??DataTable5_10
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ADDS     R0,R0,R4, LSL #+4
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LDRH     R2,[R0, R5, LSL #+1]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LCD_P16x8Ch
//  323     }
        ADDS     R5,R5,#+1
??show_map_2:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+8
        BLT.N    ??show_map_1
        ADDS     R4,R4,#+1
??show_map_0:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+8
        BGE.N    ??show_map_3
        MOVS     R5,#+0
        B.N      ??show_map_2
//  324   }
//  325 }
??show_map_3:
        POP      {R0,R4,R5,PC}    ;; return
//  326 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  327 uint16 judge(uint16 x,uint16 y,uint16 id){ //id 表示方向数组的行标，0,1,2,3 分别表示上下左右
//  328   uint16 xx,yy,xxx,yyy;
//  329   xx=x+dir[id][0]; yy=y+dir[id][1];
judge:
        LDR.N    R3,??DataTable5_31
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRH     R3,[R3, R2, LSL #+2]
        ADDS     R0,R3,R0
        LDR.N    R3,??DataTable5_31
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R3,R3,R2, LSL #+2
        LDRH     R3,[R3, #+2]
        ADDS     R1,R3,R1
//  330   if(map[xx][yy]==0 || map[xx][yy]==4)return 1; //1表示前面是 空格 或者 目的地，就是可以直接移动
        LDR.N    R3,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R3,R3,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R3,[R3, R1, LSL #+1]
        CMP      R3,#+0
        BEQ.N    ??judge_0
        LDR.N    R3,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R3,R3,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R3,[R3, R1, LSL #+1]
        CMP      R3,#+4
        BNE.N    ??judge_1
??judge_0:
        MOVS     R0,#+1
        B.N      ??judge_2
//  331   else if(map[xx][yy]==1)return 0;               //0表示无法移动
??judge_1:
        LDR.N    R3,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R3,R3,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R3,[R3, R1, LSL #+1]
        CMP      R3,#+1
        BNE.N    ??judge_3
        MOVS     R0,#+0
        B.N      ??judge_2
//  332   else if(map[xx][yy]==3){
??judge_3:
        LDR.N    R3,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R3,R3,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R3,[R3, R1, LSL #+1]
        CMP      R3,#+3
        BNE.N    ??judge_4
//  333     xxx=xx+dir[id][0]; yyy=yy+dir[id][1];
        LDR.N    R3,??DataTable5_31
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRH     R3,[R3, R2, LSL #+2]
        ADDS     R0,R3,R0
        LDR.N    R3,??DataTable5_31
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ADDS     R2,R3,R2, LSL #+2
        LDRH     R2,[R2, #+2]
        ADDS     R1,R2,R1
//  334     if(map[xxx][yyy]==1 || map[xxx][yyy]==3)return 0;
        LDR.N    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R2,[R2, R1, LSL #+1]
        CMP      R2,#+1
        BEQ.N    ??judge_5
        LDR.N    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R2,[R2, R1, LSL #+1]
        CMP      R2,#+3
        BNE.N    ??judge_6
??judge_5:
        MOVS     R0,#+0
        B.N      ??judge_2
//  335     else if(map[xxx][yyy]==0 || map[xxx][yyy]==4)return 2; //2表示需要间接移动，先把前面的箱子移动一，再让人移动一
??judge_6:
        LDR.N    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R2,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R2,[R2, R1, LSL #+1]
        CMP      R2,#+0
        BEQ.N    ??judge_7
        LDR.N    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R0,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R0,[R0, R1, LSL #+1]
        CMP      R0,#+4
        BNE.N    ??judge_4
??judge_7:
        MOVS     R0,#+2
        B.N      ??judge_2
//  336   }return 0;
??judge_4:
        MOVS     R0,#+0
??judge_2:
        BX       LR               ;; return
//  337 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     flag2
//  338 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  339 void fun(uint16 key,uint16 dirction){
fun:
        PUSH     {R7,LR}
//  340   uint16 x,y;
//  341   if(key==1){//直接移动
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+1
        BNE.N    ??fun_0
//  342     if(mat[cur_y][cur_x]==4)map[cur_x][cur_y]=4;
        LDR.N    R0,??DataTable5_22
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2, LSL #+4
        LDR.N    R2,??DataTable5_15
        LDRH     R2,[R2, #+0]
        LDRH     R0,[R0, R2, LSL #+1]
        CMP      R0,#+4
        BNE.N    ??fun_1
        LDR.N    R0,??DataTable5_10
        LDR.N    R2,??DataTable5_15
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2, LSL #+4
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        MOVS     R3,#+4
        STRH     R3,[R0, R2, LSL #+1]
        B.N      ??fun_2
//  343     else map[cur_x][cur_y]=0;
??fun_1:
        LDR.N    R0,??DataTable5_10
        LDR.N    R2,??DataTable5_15
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2, LSL #+4
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        MOVS     R3,#+0
        STRH     R3,[R0, R2, LSL #+1]
//  344     //update(cur_x,cur_y);
//  345 
//  346     cur_x+=dir[dirction][0]; cur_y+=dir[dirction][1];
??fun_2:
        LDR.N    R0,??DataTable5_15
        LDRH     R0,[R0, #+0]
        LDR.N    R2,??DataTable5_31
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R2,[R2, R1, LSL #+2]
        ADDS     R0,R2,R0
        LDR.N    R2,??DataTable5_15
        STRH     R0,[R2, #+0]
        LDR.N    R0,??DataTable5_14
        LDRH     R0,[R0, #+0]
        LDR.N    R2,??DataTable5_31
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R1,R2,R1, LSL #+2
        LDRH     R1,[R1, #+2]
        ADDS     R0,R1,R0
        LDR.N    R1,??DataTable5_14
        STRH     R0,[R1, #+0]
//  347     map[cur_x][cur_y]=2;
        LDR.N    R0,??DataTable5_10
        LDR.N    R1,??DataTable5_15
        LDRH     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+4
        LDR.N    R1,??DataTable5_14
        LDRH     R1,[R1, #+0]
        MOVS     R2,#+2
        STRH     R2,[R0, R1, LSL #+1]
//  348     //update(cur_x,cur_y);
//  349     show_map();
        BL       show_map
        B.N      ??fun_3
//  350 
//  351   }
//  352   else if(key==2){//间接移动
??fun_0:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+2
        BNE.N    ??fun_3
//  353     if(mat[cur_y][cur_x]==4)map[cur_x][cur_y]=4;
        LDR.N    R0,??DataTable5_22
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2, LSL #+4
        LDR.N    R2,??DataTable5_15
        LDRH     R2,[R2, #+0]
        LDRH     R0,[R0, R2, LSL #+1]
        CMP      R0,#+4
        BNE.N    ??fun_4
        LDR.N    R0,??DataTable5_10
        LDR.N    R2,??DataTable5_15
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2, LSL #+4
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        MOVS     R3,#+4
        STRH     R3,[R0, R2, LSL #+1]
        B.N      ??fun_5
//  354     else map[cur_x][cur_y]=0;
??fun_4:
        LDR.N    R0,??DataTable5_10
        LDR.N    R2,??DataTable5_15
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2, LSL #+4
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        MOVS     R3,#+0
        STRH     R3,[R0, R2, LSL #+1]
//  355     //update(cur_x,cur_y);
//  356 
//  357     cur_x+=dir[dirction][0]; cur_y+=dir[dirction][1];
??fun_5:
        LDR.N    R0,??DataTable5_15
        LDRH     R0,[R0, #+0]
        LDR.N    R2,??DataTable5_31
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R2,[R2, R1, LSL #+2]
        ADDS     R0,R2,R0
        LDR.N    R2,??DataTable5_15
        STRH     R0,[R2, #+0]
        LDR.N    R0,??DataTable5_14
        LDRH     R0,[R0, #+0]
        LDR.N    R2,??DataTable5_31
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R2,R2,R1, LSL #+2
        LDRH     R2,[R2, #+2]
        ADDS     R0,R2,R0
        LDR.N    R2,??DataTable5_14
        STRH     R0,[R2, #+0]
//  358     map[cur_x][cur_y]=2;
        LDR.N    R0,??DataTable5_10
        LDR.N    R2,??DataTable5_15
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2, LSL #+4
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        MOVS     R3,#+2
        STRH     R3,[R0, R2, LSL #+1]
//  359     //update(cur_x,cur_y);
//  360 
//  361     x=cur_x+dir[dirction][0]; y=cur_y+dir[dirction][1];
        LDR.N    R0,??DataTable5_15
        LDRH     R0,[R0, #+0]
        LDR.N    R2,??DataTable5_31
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRH     R2,[R2, R1, LSL #+2]
        ADDS     R0,R2,R0
        LDR.N    R2,??DataTable5_14
        LDRH     R2,[R2, #+0]
        LDR.N    R3,??DataTable5_31
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R1,R3,R1, LSL #+2
        LDRH     R1,[R1, #+2]
        ADDS     R1,R1,R2
//  362     map[x][y]=3;
        LDR.N    R2,??DataTable5_10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADDS     R0,R2,R0, LSL #+4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R2,#+3
        STRH     R2,[R0, R1, LSL #+1]
//  363     show_map();
        BL       show_map
//  364     //update(x,y);
//  365   }
//  366 }
??fun_3:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     gameover

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     gameovertxz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     mapshu

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     flag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     flag1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     gameing

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     timeflag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     X

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     map

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     wherex

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     wherey

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_13:
        DC32     key_up

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_14:
        DC32     cur_y

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_15:
        DC32     cur_x

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_16:
        DC32     key_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_17:
        DC32     key_left

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_18:
        DC32     key_right

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_19:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_20:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_21:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_22:
        DC32     mat

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_23:
        DC32     mat1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_24:
        DC32     ?_5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_25:
        DC32     ?_6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_26:
        DC32     mat2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_27:
        DC32     ?_7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_28:
        DC32     ?_8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_29:
        DC32     mat3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_30:
        DC32     huatu1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_31:
        DC32     dir

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
?_0:
        DATA
        DC8 "0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 ":"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "YON WIN"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC16 1, 4, 6, 3

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC16 4, 6, 3, 1

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_5:
        DATA
        DC16 6, 6, 6, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_6:
        DATA
        DC16 4, 5, 6, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_7:
        DATA
        DC16 2, 2, 3, 5

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_8:
        DATA
        DC16 5, 6, 6, 6

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC16 0
        DC8 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC16 0
        DC8 0, 0, 0, 0, 0, 0

        END
// 
//   280 bytes in section .bss
//   402 bytes in section .data
//    76 bytes in section .rodata
// 3 388 bytes in section .text
// 
// 3 388 bytes of CODE  memory
//    76 bytes of CONST memory
//   682 bytes of DATA  memory
//
//Errors: none
//Warnings: 1
