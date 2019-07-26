///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:43
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\common\relocate.c
//    Command line =  
//        D:\2019.IAR\lib\common\relocate.c -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\relocate.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION `.data`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION `.data_init`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocate:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocateRam:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        EXTERN __VECTOR_RAM
        EXTERN __VECTOR_TABLE

        PUBLIC common_relocate

// D:\2019.IAR\lib\common\relocate.c
//    1 /**
//    2  * @file relocate.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief Kinetis通用数据代码迁移函数
//    6  *
//    7  * 更改建议:不建议修改
//    8  *
//    9  * 实现数据、代码由ROM向RAM迁移的过程
//   10  *
//   11  * 版权所有:北京拉普兰德电子技术有限公司
//   12  * http://www.lpld.cn
//   13  * mail:support@lpld.cn
//   14  *
//   15  * @par
//   16  * 本代码由拉普兰德[LPLD]开发并维护，并向所有使用者开放源代码。
//   17  * 开发者可以随意修使用或改源代码。但本段及以上注释应予以保留。
//   18  * 不得更改或删除原版权所有者姓名，二次开发者可以加注二次版权所有者。
//   19  * 但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   20  * 拉普兰德不负责由于使用本代码所带来的任何事故、法律责任或相关不良影响。
//   21  * 拉普兰德无义务解释、说明本代码的具体原理、功能、实现方法。
//   22  * 除非拉普兰德[LPLD]授权，开发者不得将本代码用于商业产品。
//   23  */
//   24 
//   25 #include "common.h"
//   26 
//   27 #if defined(__IAR_SYSTEMS_ICC__)
//   28   #pragma section = ".data"
//   29   #pragma section = ".data_init"
//   30   #pragma section = ".bss"
//   31   #pragma section = "CodeRelocate"
//   32   #pragma section = "CodeRelocateRam"
//   33 #endif
//   34    
//   35 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   36 void common_relocate(void)
//   37 {
//   38     #ifndef __IAR_SYSTEMS_ICC__
//   39       #warning 非IAR编译器需确定此处地址
//   40       extern char __START_BSS[];
//   41       extern char __END_BSS[];
//   42       extern uint32 __DATA_ROM[];
//   43       extern uint32 __DATA_RAM[];
//   44       extern char __DATA_END[];
//   45     #endif
//   46   
//   47   /* 声明一个计数器在拷贝循环中使用 */
//   48   uint32 n;
//   49   
//   50   /* 为不同的数据段定义指针。
//   51   * 这些变量将由链接文件中获取的值初始化
//   52   */
//   53   uint8 * data_ram, * data_rom, * data_rom_end;
//   54   uint8 * bss_start, * bss_end;
//   55   
//   56   
//   57   /* 引进链接文件中的VECTOR_TABLE和VECTOR_RAM的地址 */
//   58   extern uint32 __VECTOR_TABLE[];
//   59   extern uint32 __VECTOR_RAM[];
//   60   
//   61   /* 将中断向量表复制到RAM中 */
//   62   if (__VECTOR_RAM != __VECTOR_TABLE)
common_relocate:
        LDR.N    R0,??common_relocate_0
        LDR.N    R1,??common_relocate_0+0x4
        CMP      R0,R1
        BEQ.N    ??common_relocate_1
//   63   {
//   64     for (n = 0; n < 0x410; n++)
        MOVS     R0,#+0
        B.N      ??common_relocate_2
//   65       __VECTOR_RAM[n] = __VECTOR_TABLE[n];
??common_relocate_3:
        LDR.N    R1,??common_relocate_0+0x4
        LDR      R1,[R1, R0, LSL #+2]
        LDR.N    R2,??common_relocate_0
        STR      R1,[R2, R0, LSL #+2]
        ADDS     R0,R0,#+1
??common_relocate_2:
        CMP      R0,#+1040
        BCC.N    ??common_relocate_3
//   66   }
//   67   /* 将新的中断向量表指针赋给VTOR寄存器 */
//   68   write_vtor((uint32)__VECTOR_RAM);
??common_relocate_1:
        LDR.N    R0,??common_relocate_0
        LDR.N    R1,??common_relocate_0+0x8  ;; 0xe000ed08
        STR      R0,[R1, #+0]
//   69   
//   70   /* 获得.data段的地址(已初始化的数据段) */
//   71   #if defined(__IAR_SYSTEMS_ICC__)
//   72     data_ram = __section_begin(".data");
        LDR.N    R1,??common_relocate_0+0xC
//   73     data_rom = __section_begin(".data_init");
        LDR.N    R2,??common_relocate_0+0x10
//   74     data_rom_end = __section_end(".data_init");
        LDR.N    R0,??common_relocate_0+0x14
//   75     n = data_rom_end - data_rom;	
        SUBS     R0,R0,R2
        B.N      ??common_relocate_4
//   76   #else
//   77     #warning 非IAR编译器需确定此处地址
//   78     data_ram = (uint8 *)__DATA_RAM;
//   79     data_rom = (uint8 *)__DATA_ROM;
//   80     data_rom_end  = (uint8 *)__DATA_END; /* 该段在CodeWarrior编译器中为RAM地址 */
//   81     n = data_rom_end - data_rom;
//   82   #endif
//   83   
//   84   /* 从ROM复制已初始化的数据到RAM */
//   85   while (n--)
//   86     *data_ram++ = *data_rom++;
??common_relocate_5:
        LDRB     R3,[R2, #+0]
        STRB     R3,[R1, #+0]
        ADDS     R2,R2,#+1
        ADDS     R1,R1,#+1
??common_relocate_4:
        MOVS     R3,R0
        SUBS     R0,R3,#+1
        CMP      R3,#+0
        BNE.N    ??common_relocate_5
//   87   
//   88   
//   89   /* 获得.bss段的地址 (初始化为0的数据) */
//   90   #if defined(__IAR_SYSTEMS_ICC__)
//   91   bss_start = __section_begin(".bss");
        LDR.N    R1,??common_relocate_0+0x18
//   92   bss_end = __section_end(".bss");  
        LDR.N    R0,??common_relocate_0+0x1C
//   93   #else
//   94   #warning 非IAR编译器需确定此处地址
//   95   bss_start = (uint8 *)__START_BSS;
//   96   bss_end = (uint8 *)__END_BSS;
//   97   #endif
//   98   
//   99   /* 清零初始化为0的数据段 */
//  100   n = bss_end - bss_start;
        SUBS     R0,R0,R1
        B.N      ??common_relocate_6
//  101   while(n--)
//  102     *bss_start++ = 0;
??common_relocate_7:
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
        ADDS     R1,R1,#+1
??common_relocate_6:
        MOVS     R2,R0
        SUBS     R0,R2,#+1
        CMP      R2,#+0
        BNE.N    ??common_relocate_7
//  103   
//  104   /* 取得所有应该从ROM复制到RAM的代码段的地址。
//  105   * IAR有一个预定义的关键字可以标记独立的函数为从RAM执行。
//  106   * 在函数的返回类型前添加"__ramfunc"关键字可以将函数标记为从RAM中执行。
//  107   * 例如:__ramfunc void foo(void);
//  108   */
//  109   #if defined(__IAR_SYSTEMS_ICC__)
//  110   uint8* code_relocate_ram = __section_begin("CodeRelocateRam");
        LDR.N    R1,??common_relocate_0+0x20
//  111   uint8* code_relocate = __section_begin("CodeRelocate");
        LDR.N    R2,??common_relocate_0+0x24
//  112   uint8* code_relocate_end = __section_end("CodeRelocate");
        LDR.N    R0,??common_relocate_0+0x28
//  113   
//  114   /* 将函数从ROM复制到RAM */
//  115   n = code_relocate_end - code_relocate;
        SUBS     R0,R0,R2
        B.N      ??common_relocate_8
//  116   while (n--)
//  117     *code_relocate_ram++ = *code_relocate++;
??common_relocate_9:
        LDRB     R3,[R2, #+0]
        STRB     R3,[R1, #+0]
        ADDS     R2,R2,#+1
        ADDS     R1,R1,#+1
??common_relocate_8:
        MOVS     R3,R0
        SUBS     R0,R3,#+1
        CMP      R3,#+0
        BNE.N    ??common_relocate_9
//  118   #endif
//  119 }
        BX       LR               ;; return
        Nop      
        DATA
??common_relocate_0:
        DC32     __VECTOR_RAM
        DC32     __VECTOR_TABLE
        DC32     0xe000ed08
        DC32     SFB(`.data`)
        DC32     SFB(`.data_init`)
        DC32     SFE(`.data_init`)
        DC32     SFB(`.bss`)
        DC32     SFE(`.bss`)
        DC32     SFB(CodeRelocateRam)
        DC32     SFB(CodeRelocate)
        DC32     SFE(CodeRelocate)

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data_init`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocate:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocateRam:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  120 /********************************************************************/
// 
// 160 bytes in section .text
// 
// 160 bytes of CODE memory
//
//Errors: none
//Warnings: none
