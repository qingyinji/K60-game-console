///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:46
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\FatFs\option\syscall.c
//    Command line =  
//        D:\2019.IAR\lib\FatFs\option\syscall.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\syscall.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN free
        EXTERN malloc

        PUBLIC ff_memalloc
        PUBLIC ff_memfree

// D:\2019.IAR\lib\FatFs\option\syscall.c
//    1 /*------------------------------------------------------------------------*/
//    2 /* Sample code of OS dependent controls for FatFs                         */
//    3 /* (C)ChaN, 2012                                                          */
//    4 /*------------------------------------------------------------------------*/
//    5 
//    6 #include "stdlib.h"		/* ANSI memory controls */
//    7 //#include <malloc.h>		/* ANSI memory controls */
//    8 
//    9 #include "../ff.h"
//   10 
//   11 
//   12 #if _FS_REENTRANT
//   13 /*------------------------------------------------------------------------*/
//   14 /* Create a Synchronization Object
//   15 /*------------------------------------------------------------------------*/
//   16 /* This function is called in f_mount function to create a new
//   17 /  synchronization object, such as semaphore and mutex. When a FALSE is
//   18 /  returned, the f_mount function fails with FR_INT_ERR.
//   19 */
//   20 
//   21 int ff_cre_syncobj (	/* 1:Function succeeded, 0:Could not create due to any error */
//   22 	BYTE vol,			/* Corresponding logical drive being processed */
//   23 	_SYNC_t *sobj		/* Pointer to return the created sync object */
//   24 )
//   25 {
//   26 	int ret;
//   27 //	static _SYNC_t sem[_VOLUMES];	/* FreeRTOS */
//   28 
//   29 
//   30 	*sobj = CreateMutex(NULL, FALSE, NULL);		/* Win32 */
//   31 	ret = (*sobj != INVALID_HANDLE_VALUE);
//   32 
//   33 //	*sobj = SyncObjects[vol];		/* uITRON (give a static created sync object) */
//   34 //	ret = 1;						/* The initial value of the semaphore must be 1. */
//   35 
//   36 //	*sobj = OSMutexCreate(0, &err);	/* uC/OS-II */
//   37 //	ret = (err == OS_NO_ERR);
//   38 
//   39 //  if (!sem[vol])					/* FreeRTOS */
//   40 //		sem[vol] = xSemaphoreCreateMutex();
//   41 //	*sobj = sem[vol];
//   42 //	ret = (*sobj != NULL);
//   43 
//   44 	return ret;
//   45 }
//   46 
//   47 
//   48 
//   49 /*------------------------------------------------------------------------*/
//   50 /* Delete a Synchronization Object                                        */
//   51 /*------------------------------------------------------------------------*/
//   52 /* This function is called in f_mount function to delete a synchronization
//   53 /  object that created with ff_cre_syncobj function. When a FALSE is
//   54 /  returned, the f_mount function fails with FR_INT_ERR.
//   55 */
//   56 
//   57 int ff_del_syncobj (	/* 1:Function succeeded, 0:Could not delete due to any error */
//   58 	_SYNC_t sobj		/* Sync object tied to the logical drive to be deleted */
//   59 )
//   60 {
//   61 	int ret;
//   62 
//   63 
//   64 	ret = CloseHandle(sobj);	/* Win32 */
//   65 
//   66 //	ret = 1;					/* uITRON (nothing to do) */
//   67 
//   68 //	OSMutexDel(sobj, OS_DEL_ALWAYS, &err);	/* uC/OS-II */
//   69 //	ret = (err == OS_NO_ERR);
//   70 
//   71 //	ret = 1;					/* FreeRTOS (nothing to do) */
//   72 
//   73 	return ret;
//   74 }
//   75 
//   76 
//   77 
//   78 /*------------------------------------------------------------------------*/
//   79 /* Request Grant to Access the Volume                                     */
//   80 /*------------------------------------------------------------------------*/
//   81 /* This function is called on entering file functions to lock the volume.
//   82 /  When a FALSE is returned, the file function fails with FR_TIMEOUT.
//   83 */
//   84 
//   85 int ff_req_grant (	/* TRUE:Got a grant to access the volume, FALSE:Could not get a grant */
//   86 	_SYNC_t sobj	/* Sync object to wait */
//   87 )
//   88 {
//   89 	int ret;
//   90 
//   91 	ret = (WaitForSingleObject(sobj, _FS_TIMEOUT) == WAIT_OBJECT_0);	/* Win32 */
//   92 
//   93 //	ret = (wai_sem(sobj) == E_OK);				/* uITRON */
//   94 
//   95 //	OSMutexPend(sobj, _FS_TIMEOUT, &err));		/* uC/OS-II */
//   96 //	ret = (err == OS_NO_ERR);
//   97 
//   98 //	ret = (xSemaphoreTake(sobj, _FS_TIMEOUT) == pdTRUE);	/* FreeRTOS */
//   99 
//  100 	return ret;
//  101 }
//  102 
//  103 
//  104 
//  105 /*------------------------------------------------------------------------*/
//  106 /* Release Grant to Access the Volume                                     */
//  107 /*------------------------------------------------------------------------*/
//  108 /* This function is called on leaving file functions to unlock the volume.
//  109 */
//  110 
//  111 void ff_rel_grant (
//  112 	_SYNC_t sobj	/* Sync object to be signaled */
//  113 )
//  114 {
//  115 	ReleaseMutex(sobj);		/* Win32 */
//  116 
//  117 //	sig_sem(sobj);			/* uITRON */
//  118 
//  119 //	OSMutexPost(sobj);		/* uC/OS-II */
//  120 
//  121 //	xSemaphoreGive(sobj);	/* FreeRTOS */
//  122 }
//  123 
//  124 #endif
//  125 
//  126 
//  127 
//  128 
//  129 #if _USE_LFN == 3	/* LFN with a working buffer on the heap */
//  130 /*------------------------------------------------------------------------*/
//  131 /* Allocate a memory block                                                */
//  132 /*------------------------------------------------------------------------*/
//  133 /* If a NULL is returned, the file function fails with FR_NOT_ENOUGH_CORE.
//  134 */
//  135 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  136 void* ff_memalloc (	/* Returns pointer to the allocated memory block */
//  137 	UINT msize		/* Number of bytes to allocate */
//  138 )
//  139 {
ff_memalloc:
        PUSH     {R7,LR}
//  140 	return malloc(msize);
        BL       malloc
        POP      {R1,PC}          ;; return
//  141 }
//  142 
//  143 
//  144 /*------------------------------------------------------------------------*/
//  145 /* Free a memory block                                                    */
//  146 /*------------------------------------------------------------------------*/
//  147 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  148 void ff_memfree (
//  149 	void* mblock	/* Pointer to the memory block to free */
//  150 )
//  151 {
ff_memfree:
        PUSH     {R7,LR}
//  152 	free(mblock);
        BL       free
//  153 }
        POP      {R0,PC}          ;; return

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  154 
//  155 #endif
// 
// 16 bytes in section .text
// 
// 16 bytes of CODE memory
//
//Errors: none
//Warnings: 1
