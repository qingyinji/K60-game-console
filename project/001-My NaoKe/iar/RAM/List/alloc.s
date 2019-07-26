///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:13:48
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\common\alloc.c
//    Command line =  
//        D:\2019.IAR\lib\common\alloc.c -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\alloc.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        SECTION HEAP:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        PUBLIC free
        PUBLIC malloc

// D:\2019.IAR\lib\common\alloc.c
//    1 /**
//    2  * @file alloc.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief 通用 malloc()、free() 函数
//    6  *
//    7  * 更改建议:不建议修改
//    8  *
//    9  * 该代码提供系统内存分配和释放函数。
//   10  * 用户可选片内或片外内存，片外内存需FlexBus支持。
//   11  *
//   12  * 版权所有:北京拉普兰德电子技术有限公司
//   13  * http://www.lpld.cn
//   14  * mail:support@lpld.cn
//   15  *
//   16  * @par
//   17  * 本代码由拉普兰德[LPLD]开发并维护，并向所有使用者开放源代码。
//   18  * 开发者可以随意修使用或改源代码。但本段及以上注释应予以保留。
//   19  * 不得更改或删除原版权所有者姓名，二次开发者可以加注二次版权所有者。
//   20  * 但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   21  * 拉普兰德不负责由于使用本代码所带来的任何事故、法律责任或相关不良影响。
//   22  * 拉普兰德无义务解释、说明本代码的具体原理、功能、实现方法。
//   23  * 除非拉普兰德[LPLD]授权，开发者不得将本代码用于商业产品。
//   24  */
//   25 
//   26 #include "common.h"
//   27 #include "stdlib.h"
//   28 
//   29 #if defined(__IAR_SYSTEMS_ICC__)
//   30   #pragma section = "HEAP"
//   31 #endif
//   32 
//   33 /********************************************************************/
//   34 
//   35 /*
//   36  * This struct forms the minimum block size which is allocated, and
//   37  * also forms the linked list for the memory space used with alloc()
//   38  * and free().  It is padded so that on a 32-bit machine, all malloc'ed
//   39  * pointers are 16-byte aligned.
//   40  */
//   41 typedef struct ALLOC_HDR
//   42 {
//   43     struct
//   44     {
//   45         struct ALLOC_HDR     *ptr;
//   46         unsigned int size;
//   47     } s;
//   48     unsigned int align;
//   49     unsigned int pad;
//   50 } ALLOC_HDR;
//   51 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   52 static ALLOC_HDR base;
base:
        DS8 16

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   53 static ALLOC_HDR *freep = NULL;
freep:
        DS8 4
//   54 
//   55 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 void free (void *ap)
//   57 {
//   58     ALLOC_HDR *bp, *p;
//   59 
//   60     bp = (ALLOC_HDR *)ap - 1;   /* point to block header */
free:
        SUBS     R0,R0,#+16
//   61     for (p = freep; !((bp > p) && (bp < p->s.ptr)) ; p = p->s.ptr)
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+0]
        B.N      ??free_0
??free_1:
        LDR      R1,[R1, #+0]
??free_0:
        CMP      R1,R0
        BCS.N    ??free_2
        LDR      R2,[R1, #+0]
        CMP      R0,R2
        BCC.N    ??free_3
//   62     {
//   63         if ((p >= p->s.ptr) && ((bp > p) || (bp < p->s.ptr)))
??free_2:
        LDR      R2,[R1, #+0]
        CMP      R1,R2
        BCC.N    ??free_1
        CMP      R1,R0
        BCC.N    ??free_4
        LDR      R2,[R1, #+0]
        CMP      R0,R2
        BCS.N    ??free_1
//   64         {
//   65             break; /* freed block at start or end of arena */
//   66         }
//   67     }
//   68 
//   69     if ((bp + bp->s.size) == p->s.ptr)
??free_4:
??free_3:
        LDR      R2,[R0, #+4]
        ADDS     R2,R0,R2, LSL #+4
        LDR      R3,[R1, #+0]
        CMP      R2,R3
        BNE.N    ??free_5
//   70     {
//   71         bp->s.size += p->s.ptr->s.size;
        LDR      R2,[R0, #+4]
        LDR      R3,[R1, #+0]
        LDR      R3,[R3, #+4]
        ADDS     R2,R3,R2
        STR      R2,[R0, #+4]
//   72         bp->s.ptr = p->s.ptr->s.ptr;
        LDR      R2,[R1, #+0]
        LDR      R2,[R2, #+0]
        STR      R2,[R0, #+0]
        B.N      ??free_6
//   73     }
//   74     else
//   75     {
//   76         bp->s.ptr = p->s.ptr;
??free_5:
        LDR      R2,[R1, #+0]
        STR      R2,[R0, #+0]
//   77     }
//   78 
//   79     if ((p + p->s.size) == bp)
??free_6:
        LDR      R2,[R1, #+4]
        ADDS     R2,R1,R2, LSL #+4
        CMP      R2,R0
        BNE.N    ??free_7
//   80     {
//   81         p->s.size += bp->s.size;
        LDR      R2,[R1, #+4]
        LDR      R3,[R0, #+4]
        ADDS     R2,R3,R2
        STR      R2,[R1, #+4]
//   82         p->s.ptr = bp->s.ptr;
        LDR      R0,[R0, #+0]
        STR      R0,[R1, #+0]
        B.N      ??free_8
//   83     }
//   84     else
//   85     {
//   86         p->s.ptr = bp;
??free_7:
        STR      R0,[R1, #+0]
//   87     }
//   88 
//   89     freep = p;
??free_8:
        LDR.N    R0,??DataTable1
        STR      R1,[R0, #+0]
//   90 }
        BX       LR               ;; return
//   91 
//   92 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 void * malloc (unsigned nbytes)
//   94 {
//   95     /* Get addresses for the HEAP start and end */
//   96     #if defined(__IAR_SYSTEMS_ICC__)
//   97       char* __HEAP_START = __section_begin("HEAP");
malloc:
        LDR.N    R1,??DataTable1_1
//   98       char* __HEAP_END = __section_end("HEAP");
        LDR.N    R2,??DataTable1_2
//   99     #else
//  100       #warning 非IAR编译器需确定HEAP起始结束地址
//  101       extern char __HEAP_START;
//  102       extern char __HEAP_END[];
//  103     #endif
//  104    
//  105     ALLOC_HDR *p, *prevp;
//  106     unsigned nunits;
//  107 
//  108     nunits = ((nbytes+sizeof(ALLOC_HDR)-1) / sizeof(ALLOC_HDR)) + 1;
        ADDS     R0,R0,#+15
        LSRS     R0,R0,#+4
        ADDS     R0,R0,#+1
//  109 
//  110     if ((prevp = freep) == NULL)
        LDR.N    R3,??DataTable1
        LDR      R3,[R3, #+0]
        CMP      R3,#+0
        BNE.N    ??malloc_0
//  111     {
//  112         p = (ALLOC_HDR *)__HEAP_START;
//  113         p->s.size = ( ((uint32)__HEAP_END - (uint32)__HEAP_START)
//  114             / sizeof(ALLOC_HDR) );
        SUBS     R2,R2,R1
        LSRS     R2,R2,#+4
        STR      R2,[R1, #+4]
//  115         p->s.ptr = &base;
        LDR.N    R2,??DataTable1_3
        STR      R2,[R1, #+0]
//  116         base.s.ptr = p;
        LDR.N    R2,??DataTable1_3
        STR      R1,[R2, #+0]
//  117         base.s.size = 0;
        MOVS     R1,#+0
        LDR.N    R2,??DataTable1_3
        STR      R1,[R2, #+4]
//  118         prevp = freep = &base;
        LDR.N    R1,??DataTable1_3
        LDR.N    R2,??DataTable1
        STR      R1,[R2, #+0]
        LDR.N    R1,??DataTable1
        LDR      R3,[R1, #+0]
//  119     }
//  120 
//  121     for (p = prevp->s.ptr; ; prevp = p, p = p->s.ptr)
??malloc_0:
        LDR      R1,[R3, #+0]
        B.N      ??malloc_1
??malloc_2:
        MOVS     R3,R1
        LDR      R1,[R1, #+0]
//  122     {
//  123         if (p->s.size >= nunits)
??malloc_1:
        LDR      R2,[R1, #+4]
        CMP      R2,R0
        BCC.N    ??malloc_3
//  124         {
//  125             if (p->s.size == nunits)
        LDR      R2,[R1, #+4]
        CMP      R2,R0
        BNE.N    ??malloc_4
//  126             {
//  127                 prevp->s.ptr = p->s.ptr;
        LDR      R0,[R1, #+0]
        STR      R0,[R3, #+0]
        B.N      ??malloc_5
//  128             }
//  129             else
//  130             {
//  131                 p->s.size -= nunits;
??malloc_4:
        LDR      R2,[R1, #+4]
        SUBS     R2,R2,R0
        STR      R2,[R1, #+4]
//  132                 p += p->s.size;
        LDR      R2,[R1, #+4]
        ADDS     R1,R1,R2, LSL #+4
//  133                 p->s.size = nunits;
        STR      R0,[R1, #+4]
//  134             }
//  135             freep = prevp;
??malloc_5:
        LDR.N    R0,??DataTable1
        STR      R3,[R0, #+0]
//  136             return (void *)(p + 1);
        ADDS     R0,R1,#+16
        B.N      ??malloc_6
//  137         }
//  138 
//  139         if (p == freep)
??malloc_3:
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+0]
        CMP      R1,R2
        BNE.N    ??malloc_2
//  140             return NULL;
        MOVS     R0,#+0
??malloc_6:
        BX       LR               ;; return
//  141     }
//  142 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     freep

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     SFB(HEAP)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     SFE(HEAP)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     base

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION HEAP:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  143 
//  144 /********************************************************************/
// 
//  20 bytes in section .bss
// 228 bytes in section .text
// 
// 228 bytes of CODE memory
//  20 bytes of DATA memory
//
//Errors: none
//Warnings: none
