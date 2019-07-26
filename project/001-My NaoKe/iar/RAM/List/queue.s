///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:14:12
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\common\queue.c
//    Command line =  
//        D:\2019.IAR\lib\common\queue.c -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\queue.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC queue_add
        PUBLIC queue_init
        PUBLIC queue_isempty
        PUBLIC queue_move
        PUBLIC queue_peek
        PUBLIC queue_remove

// D:\2019.IAR\lib\common\queue.c
//    1 /**
//    2  * @file queue.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief 实现先进先出链表
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
//   24 #include "queue.h"
//   25 
//   26 /********************************************************************/
//   27 /* 
//   28  * Initialize the specified queue to an empty state
//   29  * 
//   30  * Parameters:
//   31  *  q   Pointer to queue structure
//   32  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void queue_init(QUEUE *q)
//   34 {
//   35     q->head = NULL;
queue_init:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   36 }
        BX       LR               ;; return
//   37 /********************************************************************/
//   38 /* 
//   39  * Check for an empty queue
//   40  *
//   41  * Parameters:
//   42  *  q       Pointer to queue structure
//   43  * 
//   44  * Return Value:
//   45  *  1 if Queue is empty
//   46  *  0 otherwise
//   47  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   48 int32 queue_isempty(QUEUE *q)
//   49 {
//   50     return (q->head == NULL);
queue_isempty:
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??queue_isempty_0
        MOVS     R0,#+1
        B.N      ??queue_isempty_1
??queue_isempty_0:
        MOVS     R0,#+0
??queue_isempty_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//   51 }
//   52 /********************************************************************/
//   53 /* 
//   54  * Add an item to the end of the queue 
//   55  *
//   56  * Parameters:
//   57  *  q       Pointer to queue structure
//   58  *  node    New node to add to the queue
//   59  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 void queue_add(QUEUE *q, QNODE *node)
//   61 {
queue_add:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   62     if (queue_isempty(q))
        MOVS     R0,R4
        BL       queue_isempty
        CMP      R0,#+0
        BEQ.N    ??queue_add_0
//   63     {
//   64         q->head = q->tail = node;
        STR      R5,[R4, #+4]
        LDR      R0,[R4, #+4]
        STR      R0,[R4, #+0]
        B.N      ??queue_add_1
//   65     }
//   66     else
//   67     {
//   68         q->tail->next = node;
??queue_add_0:
        LDR      R0,[R4, #+4]
        STR      R5,[R0, #+0]
//   69         q->tail = node;
        STR      R5,[R4, #+4]
//   70     }
//   71     
//   72     node->next = NULL;
??queue_add_1:
        MOVS     R0,#+0
        STR      R0,[R5, #+0]
//   73 }
        POP      {R0,R4,R5,PC}    ;; return
//   74 
//   75 /********************************************************************/
//   76 /* 
//   77  * Remove and return first (oldest) entry from the specified queue 
//   78  *
//   79  * Parameters:
//   80  *  q       Pointer to queue structure
//   81  *
//   82  * Return Value:
//   83  *  Node at head of queue - NULL if queue is empty
//   84  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   85 QNODE* queue_remove(QUEUE *q)
//   86 {
queue_remove:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   87     QNODE *oldest;
//   88     
//   89     if (queue_isempty(q))
        MOVS     R0,R4
        BL       queue_isempty
        CMP      R0,#+0
        BEQ.N    ??queue_remove_0
//   90         return NULL;
        MOVS     R0,#+0
        B.N      ??queue_remove_1
//   91     
//   92     oldest = q->head;
??queue_remove_0:
        LDR      R0,[R4, #+0]
//   93     q->head = oldest->next;
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+0]
//   94     return oldest;
??queue_remove_1:
        POP      {R4,PC}          ;; return
//   95 }
//   96 /********************************************************************/
//   97 /* 
//   98  * Peek into the queue and return pointer to first (oldest) entry.
//   99  * The queue is not modified
//  100  *
//  101  * Parameters:
//  102  *  q       Pointer to queue structure
//  103  *
//  104  * Return Value:
//  105  *  Node at head of queue - NULL if queue is empty
//  106  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  107 QNODE* queue_peek(QUEUE *q)
//  108 {
//  109     return q->head;
queue_peek:
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//  110 }
//  111 /********************************************************************/
//  112 /* 
//  113  * Move entire contents of one queue to the other
//  114  *
//  115  * Parameters:
//  116  *  src     Pointer to source queue
//  117  *  dst     Pointer to destination queue
//  118  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  119 void queue_move(QUEUE *dst, QUEUE *src)
//  120 {
queue_move:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  121     if (queue_isempty(src))
        MOVS     R0,R5
        BL       queue_isempty
        CMP      R0,#+0
        BNE.N    ??queue_move_0
//  122         return;
//  123     
//  124     if (queue_isempty(dst))
??queue_move_1:
        MOVS     R0,R4
        BL       queue_isempty
        CMP      R0,#+0
        BEQ.N    ??queue_move_2
//  125         dst->head = src->head;
        LDR      R0,[R5, #+0]
        STR      R0,[R4, #+0]
        B.N      ??queue_move_3
//  126     else
//  127         dst->tail->next = src->head;
??queue_move_2:
        LDR      R0,[R5, #+0]
        LDR      R1,[R4, #+4]
        STR      R0,[R1, #+0]
//  128 
//  129     dst->tail = src->tail;
??queue_move_3:
        LDR      R0,[R5, #+4]
        STR      R0,[R4, #+4]
//  130     src->head = NULL;
        MOVS     R0,#+0
        STR      R0,[R5, #+0]
//  131     return;
??queue_move_0:
        POP      {R0,R4,R5,PC}    ;; return
//  132 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  133 /********************************************************************/
// 
// 136 bytes in section .text
// 
// 136 bytes of CODE memory
//
//Errors: none
//Warnings: none
