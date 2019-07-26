///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:14:10
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\app\LPLD_FatFs.c
//    Command line =  
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\app\LPLD_FatFs.c" -D
//        LPLD_K60 -lCN "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\RAM\List\" -lB "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\RAM\List\" -o "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\RAM\Obj\" --no_cse --no_unroll --no_inline
//        --no_code_motion --no_tbaa --no_clustering --no_scheduling --debug
//        --endian=little --cpu=Cortex-M4 -e --fpu=None --dlib_config
//        "D:\Embedded Workbench 7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\..\app\" -I
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\..\..\..\lib\CPU\" -I
//        "D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\..\..\..\lib\common\"
//        -I "D:\2019.IAR\project\(FatFS
//        SDHC)LPLD_FatFs\iar\..\..\..\lib\LPLD\" -I
//        "D:\2019.IAR\project\(FatFS
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
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\LPLD_FatFs.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_UART_PutChar
        EXTERN f_close
        EXTERN f_mount
        EXTERN f_open
        EXTERN f_read
        EXTERN f_write
        EXTERN printf

        PUBLIC die
        PUBLIC get_fattime
        PUBLIC main

// D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\app\LPLD_FatFs.c
//    1 /**
//    2  * --------------基于"拉普兰德K60底层库V3"的工程（LPLD_FatFs）-----------------
//    3  * @file LPLD_FatFs.c
//    4  * @version 0.1
//    5  * @date 2013-9-29
//    6  * @brief 利用SDHC+FatFs文件系统，对SD卡上的文件进行读写。
//    7  *
//    8  * 版权所有:北京拉普兰德电子技术有限公司
//    9  * http://www.lpld.cn
//   10  * mail:support@lpld.cn
//   11  * 硬件平台:  LPLD K60 Card / LPLD K60 Nano
//   12  *
//   13  * 本工程基于"拉普兰德K60底层库V3"开发，
//   14  * 所有开源代码均在"lib"文件夹下，用户不必更改该目录下代码，
//   15  * 所有用户工程需保存在"project"文件夹下，以工程名定义文件夹名，
//   16  * 底层库使用方法见相关文档。 
//   17  *
//   18  */
//   19 #include "common.h"
//   20 
//   21 /****************************************
//   22  说明：
//   23    *将MicroSD卡插入到K60核心板的SD卡插槽。
//   24    *将MiniUSB线插入RUSH Kinetis开发板的USB
//   25     插座，并连接至电脑USB接口。
//   26    *使用串口调试助手波特率设置为115200
//   27    *使用串口调试助手查看运行结果
//   28    *如果运行错误，建议在PC上先格式化SD卡再
//   29     插入到核心板上。或者更换SDHC大容量卡。
//   30  ****************************************/
//   31 
//   32 // 打印文件返回代码

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void die(FRESULT rc)
//   34 {
die:
        PUSH     {R7,LR}
//   35   printf("错误代码 rc=%u.\n", rc);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,R0
        LDR.N    R0,??DataTable2
        BL       printf
//   36   for (;;) ;
??die_0:
        B.N      ??die_0
//   37 }
//   38 // 用户自定义的为FatFs系统提供实时时间的函数

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   39 DWORD get_fattime (void)
//   40 {
//   41   return ((DWORD)(2013 - 1980) << 25)	//2013年
//   42        | ((DWORD)3 << 21)               //3月
//   43        | ((DWORD)15 << 16)              //15日
//   44        | ((DWORD)0 << 11)
//   45        | ((DWORD)0 << 5)
//   46        | ((DWORD)0 >> 1);
get_fattime:
        LDR.N    R0,??DataTable2_1  ;; 0x426f0000
        BX       LR               ;; return
//   47 }
//   48 
//   49 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   50 void main (void)
//   51 {
main:
        PUSH     {R4,LR}
        SUB      SP,SP,#+1264
//   52   uint16 i;
//   53   // 以下变量定义均采用FatFs文件系统变量类型
//   54   FRESULT rc;			//结果代码 
//   55   FATFS fatfs;			// 文件系统对象 
//   56   FIL fil;			// 文件对象 
//   57   UINT bw, br;
//   58   BYTE buff[128];
//   59   
//   60   // 注册一个磁盘工作区 
//   61   f_mount(0, &fatfs);		
        ADD      R1,SP,#+692
        MOVS     R0,#+0
        BL       f_mount
//   62   //创建一个新的txt文档
//   63   printf("新建一个文件 (LPLD_FatFs.TXT).\n");
        LDR.N    R0,??DataTable2_2
        BL       printf
//   64   rc = f_open(&fil, "0:/LPLD_FatFs.TXT", FA_WRITE | FA_CREATE_ALWAYS);
        MOVS     R2,#+10
        LDR.N    R1,??DataTable2_3
        ADD      R0,SP,#+136
        BL       f_open
//   65   if (rc) die(rc);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??main_0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       die
//   66   
//   67   //向新创建的文档中写入"Hello LPLD!"并换行
//   68   printf("写入文本数据. (Hello LPLD!)\n");
??main_0:
        LDR.N    R0,??DataTable2_4
        BL       printf
//   69   rc = f_write(&fil, "Hello LPLD!\r\n", 13, &bw);
        ADD      R3,SP,#+4
        MOVS     R2,#+13
        LDR.N    R1,??DataTable2_5
        ADD      R0,SP,#+136
        BL       f_write
//   70   if (rc) die(rc);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??main_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       die
//   71   printf("共写入 %u Bytes.\n", bw);
??main_1:
        LDR      R1,[SP, #+4]
        LDR.N    R0,??DataTable2_6
        BL       printf
//   72   
//   73   //关闭新建的文件
//   74   printf("关闭文件.\n\n");
        LDR.N    R0,??DataTable2_7
        BL       printf
//   75   rc = f_close(&fil);
        ADD      R0,SP,#+136
        BL       f_close
//   76   if (rc) die(rc);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??main_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       die
//   77   
//   78   //打开刚才新建的文件
//   79   printf("打开一个文件 (LPLD_FatFs.TXT).\n");
??main_2:
        LDR.N    R0,??DataTable2_8
        BL       printf
//   80   rc = f_open(&fil, "0:/LPLD_FatFs.TXT", FA_READ);
        MOVS     R2,#+1
        LDR.N    R1,??DataTable2_3
        ADD      R0,SP,#+136
        BL       f_open
//   81   if (rc) die(rc);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??main_3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       die
//   82   
//   83   //打印出文件内的内容
//   84   printf("打印此文件内容.\n");
??main_3:
        LDR.N    R0,??DataTable2_9
        BL       printf
//   85   for (;;) 
//   86   {
//   87     rc = f_read(&fil, buff, sizeof(buff), &br);	// 读取文件的一块 
??main_4:
        ADD      R3,SP,#+0
        MOVS     R2,#+128
        ADD      R1,SP,#+8
        ADD      R0,SP,#+136
        BL       f_read
//   88     if (rc || !br) break;			// 错误或读取完毕 
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??main_5
        LDR      R1,[SP, #+0]
        CMP      R1,#+0
        BNE.N    ??main_6
//   89     for (i = 0; i < br; i++)		        // 输出读取的字节数据 
//   90       LPLD_UART_PutChar(TERM_PORT, buff[i]);
//   91   }
//   92   if (rc) die(rc);
??main_5:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??main_7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       die
//   93   
//   94   //关闭文件
//   95   printf("\n关闭文件.\n");
??main_7:
        LDR.N    R0,??DataTable2_10
        BL       printf
//   96   rc = f_close(&fil);
        ADD      R0,SP,#+136
        BL       f_close
//   97   if (rc) die(rc);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??main_8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       die
//   98   
//   99   printf("文件系统测试完毕.\n");
??main_8:
        LDR.N    R0,??DataTable2_11
        BL       printf
//  100 
//  101   for (;;) 
??main_9:
        B.N      ??main_9
??main_6:
        MOVS     R4,#+0
??main_10:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        LDR      R0,[SP, #+0]
        CMP      R4,R0
        BCS.N    ??main_4
        ADD      R0,SP,#+8
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        LDRSB    R1,[R4, R0]
        SXTB     R1,R1            ;; SignExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable2_12  ;; 0x400eb000
        BL       LPLD_UART_PutChar
        ADDS     R4,R4,#+1
        B.N      ??main_10
//  102   {
//  103   }
//  104   
//  105 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x426f0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     ?_5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     ?_6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     ?_7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     ?_8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     ?_9

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_11:
        DC32     ?_10

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_12:
        DC32     0x400eb000

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
        DC8 "\264\355\316\363\264\372\302\353 rc=%u.\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "\320\302\275\250\322\273\270\366\316\304\274\376 (LPLD_FatFs.TXT).\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "0:/LPLD_FatFs.TXT"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "\320\264\310\353\316\304\261\276\312\375\276\335. (Hello LPLD!)\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "Hello LPLD!\015\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_5:
        DATA
        DC8 "\271\262\320\264\310\353 %u Bytes.\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_6:
        DATA
        DC8 "\271\330\261\325\316\304\274\376.\012\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_7:
        DATA
        DC8 "\264\362\277\252\322\273\270\366\316\304\274\376 (LPLD_FatFs.TXT).\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_8:
        DATA
        DC8 "\264\362\323\241\264\313\316\304\274\376\304\332\310\335.\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_9:
        DATA
        DC8 "\012\271\330\261\325\316\304\274\376.\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_10:
        DATA
        DC8 "\316\304\274\376\317\265\315\263\262\342\312\324\315\352\261\317.\012"
        DC8 0

        END
// 
// 236 bytes in section .rodata
// 304 bytes in section .text
// 
// 304 bytes of CODE  memory
// 236 bytes of CONST memory
//
//Errors: none
//Warnings: none
