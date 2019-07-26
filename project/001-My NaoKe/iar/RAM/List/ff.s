///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:13:52
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\FatFs\ff.c
//    Command line =  
//        D:\2019.IAR\lib\FatFs\ff.c -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\ff.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN disk_initialize
        EXTERN disk_ioctl
        EXTERN disk_read
        EXTERN disk_status
        EXTERN disk_write
        EXTERN ff_convert
        EXTERN ff_memalloc
        EXTERN ff_memfree
        EXTERN ff_wtoupper
        EXTERN get_fattime

        PUBLIC clust2sect
        PUBLIC f_chdir
        PUBLIC f_chdrive
        PUBLIC f_chmod
        PUBLIC f_close
        PUBLIC f_getcwd
        PUBLIC f_getfree
        PUBLIC f_gets
        PUBLIC f_lseek
        PUBLIC f_mkdir
        PUBLIC f_mkfs
        PUBLIC f_mount
        PUBLIC f_open
        PUBLIC f_opendir
        PUBLIC f_printf
        PUBLIC f_putc
        PUBLIC f_puts
        PUBLIC f_read
        PUBLIC f_readdir
        PUBLIC f_rename
        PUBLIC f_stat
        PUBLIC f_sync
        PUBLIC f_truncate
        PUBLIC f_unlink
        PUBLIC f_utime
        PUBLIC f_write
        PUBLIC gen_numname
        PUBLIC get_fat
        PUBLIC put_fat

// D:\2019.IAR\lib\FatFs\ff.c
//    1 /*----------------------------------------------------------------------------/
//    2 /  FatFs - FAT file system module  R0.09b                 (C)ChaN, 2013
//    3 /-----------------------------------------------------------------------------/
//    4 / FatFs module is a generic FAT file system module for small embedded systems.
//    5 / This is a free software that opened for education, research and commercial
//    6 / developments under license policy of following terms.
//    7 /
//    8 /  Copyright (C) 2013, ChaN, all right reserved.
//    9 /
//   10 / * The FatFs module is a free software and there is NO WARRANTY.
//   11 / * No restriction on use. You can use, modify and redistribute it for
//   12 /   personal, non-profit or commercial products UNDER YOUR RESPONSIBILITY.
//   13 / * Redistributions of source code must retain the above copyright notice.
//   14 /
//   15 /-----------------------------------------------------------------------------/
//   16 / Feb 26,'06 R0.00  Prototype.
//   17 /
//   18 / Apr 29,'06 R0.01  First stable version.
//   19 /
//   20 / Jun 01,'06 R0.02  Added FAT12 support.
//   21 /                   Removed unbuffered mode.
//   22 /                   Fixed a problem on small (<32M) partition.
//   23 / Jun 10,'06 R0.02a Added a configuration option (_FS_MINIMUM).
//   24 /
//   25 / Sep 22,'06 R0.03  Added f_rename().
//   26 /                   Changed option _FS_MINIMUM to _FS_MINIMIZE.
//   27 / Dec 11,'06 R0.03a Improved cluster scan algorithm to write files fast.
//   28 /                   Fixed f_mkdir() creates incorrect directory on FAT32.
//   29 /
//   30 / Feb 04,'07 R0.04  Supported multiple drive system.
//   31 /                   Changed some interfaces for multiple drive system.
//   32 /                   Changed f_mountdrv() to f_mount().
//   33 /                   Added f_mkfs().
//   34 / Apr 01,'07 R0.04a Supported multiple partitions on a physical drive.
//   35 /                   Added a capability of extending file size to f_lseek().
//   36 /                   Added minimization level 3.
//   37 /                   Fixed an endian sensitive code in f_mkfs().
//   38 / May 05,'07 R0.04b Added a configuration option _USE_NTFLAG.
//   39 /                   Added FSInfo support.
//   40 /                   Fixed DBCS name can result FR_INVALID_NAME.
//   41 /                   Fixed short seek (<= csize) collapses the file object.
//   42 /
//   43 / Aug 25,'07 R0.05  Changed arguments of f_read(), f_write() and f_mkfs().
//   44 /                   Fixed f_mkfs() on FAT32 creates incorrect FSInfo.
//   45 /                   Fixed f_mkdir() on FAT32 creates incorrect directory.
//   46 / Feb 03,'08 R0.05a Added f_truncate() and f_utime().
//   47 /                   Fixed off by one error at FAT sub-type determination.
//   48 /                   Fixed btr in f_read() can be mistruncated.
//   49 /                   Fixed cached sector is not flushed when create and close without write.
//   50 /
//   51 / Apr 01,'08 R0.06  Added fputc(), fputs(), fprintf() and fgets().
//   52 /                   Improved performance of f_lseek() on moving to the same or following cluster.
//   53 /
//   54 / Apr 01,'09 R0.07  Merged Tiny-FatFs as a configuration option. (_FS_TINY)
//   55 /                   Added long file name feature.
//   56 /                   Added multiple code page feature.
//   57 /                   Added re-entrancy for multitask operation.
//   58 /                   Added auto cluster size selection to f_mkfs().
//   59 /                   Added rewind option to f_readdir().
//   60 /                   Changed result code of critical errors.
//   61 /                   Renamed string functions to avoid name collision.
//   62 / Apr 14,'09 R0.07a Separated out OS dependent code on reentrant cfg.
//   63 /                   Added multiple sector size feature.
//   64 / Jun 21,'09 R0.07c Fixed f_unlink() can return FR_OK on error.
//   65 /                   Fixed wrong cache control in f_lseek().
//   66 /                   Added relative path feature.
//   67 /                   Added f_chdir() and f_chdrive().
//   68 /                   Added proper case conversion to extended char.
//   69 / Nov 03,'09 R0.07e Separated out configuration options from ff.h to ffconf.h.
//   70 /                   Fixed f_unlink() fails to remove a sub-dir on _FS_RPATH.
//   71 /                   Fixed name matching error on the 13 char boundary.
//   72 /                   Added a configuration option, _LFN_UNICODE.
//   73 /                   Changed f_readdir() to return the SFN with always upper case on non-LFN cfg.
//   74 /
//   75 / May 15,'10 R0.08  Added a memory configuration option. (_USE_LFN = 3)
//   76 /                   Added file lock feature. (_FS_SHARE)
//   77 /                   Added fast seek feature. (_USE_FASTSEEK)
//   78 /                   Changed some types on the API, XCHAR->TCHAR.
//   79 /                   Changed fname member in the FILINFO structure on Unicode cfg.
//   80 /                   String functions support UTF-8 encoding files on Unicode cfg.
//   81 / Aug 16,'10 R0.08a Added f_getcwd(). (_FS_RPATH = 2)
//   82 /                   Added sector erase feature. (_USE_ERASE)
//   83 /                   Moved file lock semaphore table from fs object to the bss.
//   84 /                   Fixed a wrong directory entry is created on non-LFN cfg when the given name contains ';'.
//   85 /                   Fixed f_mkfs() creates wrong FAT32 volume.
//   86 / Jan 15,'11 R0.08b Fast seek feature is also applied to f_read() and f_write().
//   87 /                   f_lseek() reports required table size on creating CLMP.
//   88 /                   Extended format syntax of f_printf function.
//   89 /                   Ignores duplicated directory separators in given path name.
//   90 /
//   91 / Sep 06,'11 R0.09  f_mkfs() supports multiple partition to finish the multiple partition feature.
//   92 /                   Added f_fdisk(). (_MULTI_PARTITION = 2)
//   93 / Aug 27,'12 R0.09a Fixed assertion failure due to OS/2 EA on FAT12/16 volume.
//   94 /                   Changed f_open() and f_opendir reject null object pointer to avoid crash.
//   95 /                   Changed option name _FS_SHARE to _FS_LOCK.
//   96 / Jan 24,'13 R0.09b Added f_setlabel() and f_getlabel(). (_USE_LABEL = 1)
//   97 /---------------------------------------------------------------------------*/
//   98 
//   99 #include "ff.h"			/* FatFs configurations and declarations */
//  100 #include "diskio.h"		/* Declarations of low level disk I/O functions */
//  101 
//  102 
//  103 /*--------------------------------------------------------------------------
//  104 
//  105    Module Private Definitions
//  106 
//  107 ---------------------------------------------------------------------------*/
//  108 
//  109 #if _FATFS != 82786	/* Revision ID */
//  110 #error Wrong include file (ff.h).
//  111 #endif
//  112 
//  113 
//  114 /* Definitions on sector size */
//  115 #if _MAX_SS != 512 && _MAX_SS != 1024 && _MAX_SS != 2048 && _MAX_SS != 4096
//  116 #error Wrong sector size.
//  117 #endif
//  118 #if _MAX_SS != 512
//  119 #define	SS(fs)	((fs)->ssize)	/* Variable sector size */
//  120 #else
//  121 #define	SS(fs)	512U			/* Fixed sector size */
//  122 #endif
//  123 
//  124 
//  125 /* Reentrancy related */
//  126 #if _FS_REENTRANT
//  127 #if _USE_LFN == 1
//  128 #error Static LFN work area must not be used in re-entrant configuration.
//  129 #endif
//  130 #define	ENTER_FF(fs)		{ if (!lock_fs(fs)) return FR_TIMEOUT; }
//  131 #define	LEAVE_FF(fs, res)	{ unlock_fs(fs, res); return res; }
//  132 #else
//  133 #define	ENTER_FF(fs)
//  134 #define LEAVE_FF(fs, res)	return res
//  135 #endif
//  136 
//  137 #define	ABORT(fs, res)		{ fp->flag |= FA__ERROR; LEAVE_FF(fs, res); }
//  138 
//  139 
//  140 /* File access control feature */
//  141 #if _FS_LOCK
//  142 #if _FS_READONLY
//  143 #error _FS_LOCK must be 0 on read-only cfg.
//  144 #endif
//  145 typedef struct {
//  146 	FATFS *fs;				/* File ID 1, volume (NULL:blank entry) */
//  147 	DWORD clu;				/* File ID 2, directory */
//  148 	WORD idx;				/* File ID 3, directory index */
//  149 	WORD ctr;				/* File open counter, 0:none, 0x01..0xFF:read open count, 0x100:write mode */
//  150 } FILESEM;
//  151 #endif
//  152 
//  153 
//  154 
//  155 /* DBCS code ranges and SBCS extend char conversion table */
//  156 
//  157 #if _CODE_PAGE == 932	/* Japanese Shift-JIS */
//  158 #define _DF1S	0x81	/* DBC 1st byte range 1 start */
//  159 #define _DF1E	0x9F	/* DBC 1st byte range 1 end */
//  160 #define _DF2S	0xE0	/* DBC 1st byte range 2 start */
//  161 #define _DF2E	0xFC	/* DBC 1st byte range 2 end */
//  162 #define _DS1S	0x40	/* DBC 2nd byte range 1 start */
//  163 #define _DS1E	0x7E	/* DBC 2nd byte range 1 end */
//  164 #define _DS2S	0x80	/* DBC 2nd byte range 2 start */
//  165 #define _DS2E	0xFC	/* DBC 2nd byte range 2 end */
//  166 
//  167 #elif _CODE_PAGE == 936	/* Simplified Chinese GBK */
//  168 #define _DF1S	0x81
//  169 #define _DF1E	0xFE
//  170 #define _DS1S	0x40
//  171 #define _DS1E	0x7E
//  172 #define _DS2S	0x80
//  173 #define _DS2E	0xFE
//  174 
//  175 #elif _CODE_PAGE == 949	/* Korean */
//  176 #define _DF1S	0x81
//  177 #define _DF1E	0xFE
//  178 #define _DS1S	0x41
//  179 #define _DS1E	0x5A
//  180 #define _DS2S	0x61
//  181 #define _DS2E	0x7A
//  182 #define _DS3S	0x81
//  183 #define _DS3E	0xFE
//  184 
//  185 #elif _CODE_PAGE == 950	/* Traditional Chinese Big5 */
//  186 #define _DF1S	0x81
//  187 #define _DF1E	0xFE
//  188 #define _DS1S	0x40
//  189 #define _DS1E	0x7E
//  190 #define _DS2S	0xA1
//  191 #define _DS2E	0xFE
//  192 
//  193 #elif _CODE_PAGE == 437	/* U.S. (OEM) */
//  194 #define _DF1S	0
//  195 #define _EXCVT {0x80,0x9A,0x90,0x41,0x8E,0x41,0x8F,0x80,0x45,0x45,0x45,0x49,0x49,0x49,0x8E,0x8F,0x90,0x92,0x92,0x4F,0x99,0x4F,0x55,0x55,0x59,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  196 				0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  197 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  198 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  199 
//  200 #elif _CODE_PAGE == 720	/* Arabic (OEM) */
//  201 #define _DF1S	0
//  202 #define _EXCVT {0x80,0x81,0x45,0x41,0x84,0x41,0x86,0x43,0x45,0x45,0x45,0x49,0x49,0x8D,0x8E,0x8F,0x90,0x92,0x92,0x93,0x94,0x95,0x49,0x49,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  203 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  204 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  205 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  206 
//  207 #elif _CODE_PAGE == 737	/* Greek (OEM) */
//  208 #define _DF1S	0
//  209 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x92,0x92,0x93,0x94,0x95,0x96,0x97,0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87, \ 
//  210 				0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0xAA,0x92,0x93,0x94,0x95,0x96,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  211 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  212 				0x97,0xEA,0xEB,0xEC,0xE4,0xED,0xEE,0xE7,0xE8,0xF1,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  213 
//  214 #elif _CODE_PAGE == 775	/* Baltic (OEM) */
//  215 #define _DF1S	0
//  216 #define _EXCVT {0x80,0x9A,0x91,0xA0,0x8E,0x95,0x8F,0x80,0xAD,0xED,0x8A,0x8A,0xA1,0x8D,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0x95,0x96,0x97,0x97,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  217 				0xA0,0xA1,0xE0,0xA3,0xA3,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  218 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xB5,0xB6,0xB7,0xB8,0xBD,0xBE,0xC6,0xC7,0xA5,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  219 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE3,0xE8,0xE8,0xEA,0xEA,0xEE,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  220 
//  221 #elif _CODE_PAGE == 850	/* Multilingual Latin 1 (OEM) */
//  222 #define _DF1S	0
//  223 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0xDE,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x59,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  224 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  225 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  226 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE7,0xE9,0xEA,0xEB,0xED,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  227 
//  228 #elif _CODE_PAGE == 852	/* Latin 2 (OEM) */
//  229 #define _DF1S	0
//  230 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xDE,0x8F,0x80,0x9D,0xD3,0x8A,0x8A,0xD7,0x8D,0x8E,0x8F,0x90,0x91,0x91,0xE2,0x99,0x95,0x95,0x97,0x97,0x99,0x9A,0x9B,0x9B,0x9D,0x9E,0x9F, \ 
//  231 				0xB5,0xD6,0xE0,0xE9,0xA4,0xA4,0xA6,0xA6,0xA8,0xA8,0xAA,0x8D,0xAC,0xB8,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBD,0xBF, \ 
//  232 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC6,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD2,0xD3,0xD2,0xD5,0xD6,0xD7,0xB7,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  233 				0xE0,0xE1,0xE2,0xE3,0xE3,0xD5,0xE6,0xE6,0xE8,0xE9,0xE8,0xEB,0xED,0xED,0xDD,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xEB,0xFC,0xFC,0xFE,0xFF}
//  234 
//  235 #elif _CODE_PAGE == 855	/* Cyrillic (OEM) */
//  236 #define _DF1S	0
//  237 #define _EXCVT {0x81,0x81,0x83,0x83,0x85,0x85,0x87,0x87,0x89,0x89,0x8B,0x8B,0x8D,0x8D,0x8F,0x8F,0x91,0x91,0x93,0x93,0x95,0x95,0x97,0x97,0x99,0x99,0x9B,0x9B,0x9D,0x9D,0x9F,0x9F, \ 
//  238 				0xA1,0xA1,0xA3,0xA3,0xA5,0xA5,0xA7,0xA7,0xA9,0xA9,0xAB,0xAB,0xAD,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB6,0xB6,0xB8,0xB8,0xB9,0xBA,0xBB,0xBC,0xBE,0xBE,0xBF, \ 
//  239 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD3,0xD3,0xD5,0xD5,0xD7,0xD7,0xDD,0xD9,0xDA,0xDB,0xDC,0xDD,0xE0,0xDF, \ 
//  240 				0xE0,0xE2,0xE2,0xE4,0xE4,0xE6,0xE6,0xE8,0xE8,0xEA,0xEA,0xEC,0xEC,0xEE,0xEE,0xEF,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF8,0xFA,0xFA,0xFC,0xFC,0xFD,0xFE,0xFF}
//  241 
//  242 #elif _CODE_PAGE == 857	/* Turkish (OEM) */
//  243 #define _DF1S	0
//  244 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0x98,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x98,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9E, \ 
//  245 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA6,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  246 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  247 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xDE,0x59,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  248 
//  249 #elif _CODE_PAGE == 858	/* Multilingual Latin 1 + Euro (OEM) */
//  250 #define _DF1S	0
//  251 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0xDE,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x59,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  252 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  253 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  254 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE7,0xE9,0xEA,0xEB,0xED,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  255 
//  256 #elif _CODE_PAGE == 862	/* Hebrew (OEM) */
//  257 #define _DF1S	0
//  258 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  259 				0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  260 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  261 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  262 
//  263 #elif _CODE_PAGE == 866	/* Russian (OEM) */
//  264 #define _DF1S	0
//  265 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  266 				0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  267 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  268 				0x90,0x91,0x92,0x93,0x9d,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F,0xF0,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  269 
//  270 #elif _CODE_PAGE == 874	/* Thai (OEM, Windows) */
//  271 #define _DF1S	0
//  272 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  273 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  274 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  275 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  276 
//  277 #elif _CODE_PAGE == 1250 /* Central Europe (Windows) */
//  278 #define _DF1S	0
//  279 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x8D,0x8E,0x8F, \ 
//  280 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xA3,0xB4,0xB5,0xB6,0xB7,0xB8,0xA5,0xAA,0xBB,0xBC,0xBD,0xBC,0xAF, \ 
//  281 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  282 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xFF}
//  283 
//  284 #elif _CODE_PAGE == 1251 /* Cyrillic (Windows) */
//  285 #define _DF1S	0
//  286 #define _EXCVT {0x80,0x81,0x82,0x82,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x80,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x8D,0x8E,0x8F, \ 
//  287 				0xA0,0xA2,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB2,0xA5,0xB5,0xB6,0xB7,0xA8,0xB9,0xAA,0xBB,0xA3,0xBD,0xBD,0xAF, \ 
//  288 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  289 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF}
//  290 
//  291 #elif _CODE_PAGE == 1252 /* Latin 1 (Windows) */
//  292 #define _DF1S	0
//  293 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0xAd,0x9B,0x8C,0x9D,0xAE,0x9F, \ 
//  294 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  295 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  296 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0x9F}
//  297 
//  298 #elif _CODE_PAGE == 1253 /* Greek (Windows) */
//  299 #define _DF1S	0
//  300 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  301 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  302 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xA2,0xB8,0xB9,0xBA, \ 
//  303 				0xE0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xF2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xFB,0xBC,0xFD,0xBF,0xFF}
//  304 
//  305 #elif _CODE_PAGE == 1254 /* Turkish (Windows) */
//  306 #define _DF1S	0
//  307 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x9D,0x9E,0x9F, \ 
//  308 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  309 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  310 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0x9F}
//  311 
//  312 #elif _CODE_PAGE == 1255 /* Hebrew (Windows) */
//  313 #define _DF1S	0
//  314 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  315 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  316 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  317 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  318 
//  319 #elif _CODE_PAGE == 1256 /* Arabic (Windows) */
//  320 #define _DF1S	0
//  321 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x8C,0x9D,0x9E,0x9F, \ 
//  322 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  323 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  324 				0x41,0xE1,0x41,0xE3,0xE4,0xE5,0xE6,0x43,0x45,0x45,0x45,0x45,0xEC,0xED,0x49,0x49,0xF0,0xF1,0xF2,0xF3,0x4F,0xF5,0xF6,0xF7,0xF8,0x55,0xFA,0x55,0x55,0xFD,0xFE,0xFF}
//  325 
//  326 #elif _CODE_PAGE == 1257 /* Baltic (Windows) */
//  327 #define _DF1S	0
//  328 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  329 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xA8,0xB9,0xAA,0xBB,0xBC,0xBD,0xBE,0xAF, \ 
//  330 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  331 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xFF}
//  332 
//  333 #elif _CODE_PAGE == 1258 /* Vietnam (OEM, Windows) */
//  334 #define _DF1S	0
//  335 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0xAC,0x9D,0x9E,0x9F, \ 
//  336 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  337 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  338 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xEC,0xCD,0xCE,0xCF,0xD0,0xD1,0xF2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xFE,0x9F}
//  339 
//  340 #elif _CODE_PAGE == 1	/* ASCII (for only non-LFN cfg) */
//  341 #if _USE_LFN
//  342 #error Cannot use LFN feature without valid code page.
//  343 #endif
//  344 #define _DF1S	0
//  345 
//  346 #else
//  347 #error Unknown code page
//  348 
//  349 #endif
//  350 
//  351 
//  352 /* Character code support macros */
//  353 #define IsUpper(c)	(((c)>='A')&&((c)<='Z'))
//  354 #define IsLower(c)	(((c)>='a')&&((c)<='z'))
//  355 #define IsDigit(c)	(((c)>='0')&&((c)<='9'))
//  356 
//  357 #if _DF1S		/* Code page is DBCS */
//  358 
//  359 #ifdef _DF2S	/* Two 1st byte areas */
//  360 #define IsDBCS1(c)	(((BYTE)(c) >= _DF1S && (BYTE)(c) <= _DF1E) || ((BYTE)(c) >= _DF2S && (BYTE)(c) <= _DF2E))
//  361 #else			/* One 1st byte area */
//  362 #define IsDBCS1(c)	((BYTE)(c) >= _DF1S && (BYTE)(c) <= _DF1E)
//  363 #endif
//  364 
//  365 #ifdef _DS3S	/* Three 2nd byte areas */
//  366 #define IsDBCS2(c)	(((BYTE)(c) >= _DS1S && (BYTE)(c) <= _DS1E) || ((BYTE)(c) >= _DS2S && (BYTE)(c) <= _DS2E) || ((BYTE)(c) >= _DS3S && (BYTE)(c) <= _DS3E))
//  367 #else			/* Two 2nd byte areas */
//  368 #define IsDBCS2(c)	(((BYTE)(c) >= _DS1S && (BYTE)(c) <= _DS1E) || ((BYTE)(c) >= _DS2S && (BYTE)(c) <= _DS2E))
//  369 #endif
//  370 
//  371 #else			/* Code page is SBCS */
//  372 
//  373 #define IsDBCS1(c)	0
//  374 #define IsDBCS2(c)	0
//  375 
//  376 #endif /* _DF1S */
//  377 
//  378 
//  379 /* Name status flags */
//  380 #define NS			11		/* Index of name status byte in fn[] */
//  381 #define NS_LOSS		0x01	/* Out of 8.3 format */
//  382 #define NS_LFN		0x02	/* Force to create LFN entry */
//  383 #define NS_LAST		0x04	/* Last segment */
//  384 #define NS_BODY		0x08	/* Lower case flag (body) */
//  385 #define NS_EXT		0x10	/* Lower case flag (ext) */
//  386 #define NS_DOT		0x20	/* Dot entry */
//  387 
//  388 
//  389 /* FAT sub-type boundaries */
//  390 /* Note that the FAT spec by Microsoft says 4085 but Windows works with 4087! */
//  391 #define MIN_FAT16	4086	/* Minimum number of clusters for FAT16 */
//  392 #define	MIN_FAT32	65526	/* Minimum number of clusters for FAT32 */
//  393 
//  394 
//  395 /* FatFs refers the members in the FAT structures as byte array instead of
//  396 / structure member because the structure is not binary compatible between
//  397 / different platforms */
//  398 
//  399 #define BS_jmpBoot			0	/* Jump instruction (3) */
//  400 #define BS_OEMName			3	/* OEM name (8) */
//  401 #define BPB_BytsPerSec		11	/* Sector size [byte] (2) */
//  402 #define BPB_SecPerClus		13	/* Cluster size [sector] (1) */
//  403 #define BPB_RsvdSecCnt		14	/* Size of reserved area [sector] (2) */
//  404 #define BPB_NumFATs			16	/* Number of FAT copies (1) */
//  405 #define BPB_RootEntCnt		17	/* Number of root dir entries for FAT12/16 (2) */
//  406 #define BPB_TotSec16		19	/* Volume size [sector] (2) */
//  407 #define BPB_Media			21	/* Media descriptor (1) */
//  408 #define BPB_FATSz16			22	/* FAT size [sector] (2) */
//  409 #define BPB_SecPerTrk		24	/* Track size [sector] (2) */
//  410 #define BPB_NumHeads		26	/* Number of heads (2) */
//  411 #define BPB_HiddSec			28	/* Number of special hidden sectors (4) */
//  412 #define BPB_TotSec32		32	/* Volume size [sector] (4) */
//  413 #define BS_DrvNum			36	/* Physical drive number (2) */
//  414 #define BS_BootSig			38	/* Extended boot signature (1) */
//  415 #define BS_VolID			39	/* Volume serial number (4) */
//  416 #define BS_VolLab			43	/* Volume label (8) */
//  417 #define BS_FilSysType		54	/* File system type (1) */
//  418 #define BPB_FATSz32			36	/* FAT size [sector] (4) */
//  419 #define BPB_ExtFlags		40	/* Extended flags (2) */
//  420 #define BPB_FSVer			42	/* File system version (2) */
//  421 #define BPB_RootClus		44	/* Root dir first cluster (4) */
//  422 #define BPB_FSInfo			48	/* Offset of FSInfo sector (2) */
//  423 #define BPB_BkBootSec		50	/* Offset of backup boot sector (2) */
//  424 #define BS_DrvNum32			64	/* Physical drive number (2) */
//  425 #define BS_BootSig32		66	/* Extended boot signature (1) */
//  426 #define BS_VolID32			67	/* Volume serial number (4) */
//  427 #define BS_VolLab32			71	/* Volume label (8) */
//  428 #define BS_FilSysType32		82	/* File system type (1) */
//  429 #define	FSI_LeadSig			0	/* FSI: Leading signature (4) */
//  430 #define	FSI_StrucSig		484	/* FSI: Structure signature (4) */
//  431 #define	FSI_Free_Count		488	/* FSI: Number of free clusters (4) */
//  432 #define	FSI_Nxt_Free		492	/* FSI: Last allocated cluster (4) */
//  433 #define MBR_Table			446	/* MBR: Partition table offset (2) */
//  434 #define	SZ_PTE				16	/* MBR: Size of a partition table entry */
//  435 #define BS_55AA				510	/* Boot sector signature (2) */
//  436 
//  437 #define	DIR_Name			0	/* Short file name (11) */
//  438 #define	DIR_Attr			11	/* Attribute (1) */
//  439 #define	DIR_NTres			12	/* NT flag (1) */
//  440 #define DIR_CrtTimeTenth	13	/* Created time sub-second (1) */
//  441 #define	DIR_CrtTime			14	/* Created time (2) */
//  442 #define	DIR_CrtDate			16	/* Created date (2) */
//  443 #define DIR_LstAccDate		18	/* Last accessed date (2) */
//  444 #define	DIR_FstClusHI		20	/* Higher 16-bit of first cluster (2) */
//  445 #define	DIR_WrtTime			22	/* Modified time (2) */
//  446 #define	DIR_WrtDate			24	/* Modified date (2) */
//  447 #define	DIR_FstClusLO		26	/* Lower 16-bit of first cluster (2) */
//  448 #define	DIR_FileSize		28	/* File size (4) */
//  449 #define	LDIR_Ord			0	/* LFN entry order and LLE flag (1) */
//  450 #define	LDIR_Attr			11	/* LFN attribute (1) */
//  451 #define	LDIR_Type			12	/* LFN type (1) */
//  452 #define	LDIR_Chksum			13	/* Sum of corresponding SFN entry */
//  453 #define	LDIR_FstClusLO		26	/* Filled by zero (0) */
//  454 #define	SZ_DIR				32		/* Size of a directory entry */
//  455 #define	LLE					0x40	/* Last long entry flag in LDIR_Ord */
//  456 #define	DDE					0xE5	/* Deleted directory entry mark in DIR_Name[0] */
//  457 #define	NDDE				0x05	/* Replacement of the character collides with DDE */
//  458 
//  459 
//  460 /*------------------------------------------------------------*/
//  461 /* Module private work area                                   */
//  462 /*------------------------------------------------------------*/
//  463 /* Note that uninitialized variables with static duration are
//  464 /  zeroed/nulled at start-up. If not, the compiler or start-up
//  465 /  routine is out of ANSI-C standard.
//  466 */
//  467 
//  468 #if _VOLUMES
//  469 static

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  470 FATFS *FatFs[_VOLUMES];	/* Pointer to the file system objects (logical drives) */
FatFs:
        DS8 4
//  471 #else
//  472 #error Number of volumes must not be 0.
//  473 #endif
//  474 
//  475 static

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  476 WORD Fsid;				/* File system mount ID */
Fsid:
        DS8 2
//  477 
//  478 #if _FS_RPATH
//  479 static

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  480 BYTE CurrVol;			/* Current drive */
CurrVol:
        DS8 1
//  481 #endif
//  482 
//  483 #if _FS_LOCK
//  484 static

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  485 FILESEM	Files[_FS_LOCK];	/* File lock semaphores */
Files:
        DS8 96
//  486 #endif
//  487 
//  488 #if _USE_LFN == 0			/* No LFN feature */
//  489 #define	DEF_NAMEBUF			BYTE sfn[12]
//  490 #define INIT_BUF(dobj)		(dobj).fn = sfn
//  491 #define	FREE_BUF()
//  492 
//  493 #elif _USE_LFN == 1			/* LFN feature with static working buffer */
//  494 static WCHAR LfnBuf[_MAX_LFN+1];
//  495 #define	DEF_NAMEBUF			BYTE sfn[12]
//  496 #define INIT_BUF(dobj)		{ (dobj).fn = sfn; (dobj).lfn = LfnBuf; }
//  497 #define	FREE_BUF()
//  498 
//  499 #elif _USE_LFN == 2 		/* LFN feature with dynamic working buffer on the stack */
//  500 #define	DEF_NAMEBUF			BYTE sfn[12]; WCHAR lbuf[_MAX_LFN+1]
//  501 #define INIT_BUF(dobj)		{ (dobj).fn = sfn; (dobj).lfn = lbuf; }
//  502 #define	FREE_BUF()
//  503 
//  504 #elif _USE_LFN == 3 		/* LFN feature with dynamic working buffer on the heap */
//  505 #define	DEF_NAMEBUF			BYTE sfn[12]; WCHAR *lfn
//  506 #define INIT_BUF(dobj)		{ lfn = ff_memalloc((_MAX_LFN + 1) * 2); \ 
//  507 							  if (!lfn) LEAVE_FF((dobj).fs, FR_NOT_ENOUGH_CORE); \ 
//  508 							  (dobj).lfn = lfn;	(dobj).fn = sfn; }
//  509 #define	FREE_BUF()			ff_memfree(lfn)
//  510 
//  511 #else
//  512 #error Wrong LFN configuration.
//  513 #endif
//  514 
//  515 
//  516 #ifdef _EXCVT
//  517 static
//  518 const BYTE ExCvt[] = _EXCVT;	/* Upper conversion table for extended chars */
//  519 #endif
//  520 
//  521 
//  522 
//  523 
//  524 
//  525 
//  526 /*--------------------------------------------------------------------------
//  527 
//  528    Module Private Functions
//  529 
//  530 ---------------------------------------------------------------------------*/
//  531 
//  532 
//  533 /*-----------------------------------------------------------------------*/
//  534 /* String functions                                                      */
//  535 /*-----------------------------------------------------------------------*/
//  536 
//  537 /* Copy memory to memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  538 static
//  539 void mem_cpy (void* dst, const void* src, UINT cnt) {
//  540 	BYTE *d = (BYTE*)dst;
//  541 	const BYTE *s = (const BYTE*)src;
mem_cpy:
        B.N      ??mem_cpy_0
//  542 
//  543 #if _WORD_ACCESS == 1
//  544 	while (cnt >= sizeof (int)) {
//  545 		*(int*)d = *(int*)s;
//  546 		d += sizeof (int); s += sizeof (int);
//  547 		cnt -= sizeof (int);
//  548 	}
//  549 #endif
//  550 	while (cnt--)
//  551 		*d++ = *s++;
??mem_cpy_1:
        LDRB     R3,[R1, #+0]
        STRB     R3,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
??mem_cpy_0:
        MOVS     R3,R2
        SUBS     R2,R3,#+1
        CMP      R3,#+0
        BNE.N    ??mem_cpy_1
//  552 }
        BX       LR               ;; return
//  553 
//  554 /* Fill memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  555 static
//  556 void mem_set (void* dst, int val, UINT cnt) {
//  557 	BYTE *d = (BYTE*)dst;
mem_set:
        B.N      ??mem_set_0
//  558 
//  559 	while (cnt--)
//  560 		*d++ = (BYTE)val;
??mem_set_1:
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
??mem_set_0:
        MOVS     R3,R2
        SUBS     R2,R3,#+1
        CMP      R3,#+0
        BNE.N    ??mem_set_1
//  561 }
        BX       LR               ;; return
//  562 
//  563 /* Compare memory to memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  564 static
//  565 int mem_cmp (const void* dst, const void* src, UINT cnt) {
mem_cmp:
        PUSH     {R4}
//  566 	const BYTE *d = (const BYTE *)dst, *s = (const BYTE *)src;
//  567 	int r = 0;
        MOVS     R3,#+0
//  568 
//  569 	while (cnt-- && (r = *d++ - *s++) == 0) ;
??mem_cmp_0:
        MOVS     R4,R2
        SUBS     R2,R4,#+1
        CMP      R4,#+0
        BEQ.N    ??mem_cmp_1
        LDRB     R3,[R0, #+0]
        LDRB     R4,[R1, #+0]
        SUBS     R3,R3,R4
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
        CMP      R3,#+0
        BEQ.N    ??mem_cmp_0
//  570 	return r;
??mem_cmp_1:
        MOVS     R0,R3
        POP      {R4}
        BX       LR               ;; return
//  571 }
//  572 
//  573 /* Check if chr is contained in the string */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  574 static
//  575 int chk_chr (const char* str, int chr) {
chk_chr:
        B.N      ??chk_chr_0
//  576 	while (*str && *str != chr) str++;
??chk_chr_1:
        ADDS     R0,R0,#+1
??chk_chr_0:
        LDRB     R2,[R0, #+0]
        CMP      R2,#+0
        BEQ.N    ??chk_chr_2
        LDRB     R2,[R0, #+0]
        CMP      R2,R1
        BNE.N    ??chk_chr_1
//  577 	return *str;
??chk_chr_2:
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//  578 }
//  579 
//  580 
//  581 
//  582 /*-----------------------------------------------------------------------*/
//  583 /* Request/Release grant to access the volume                            */
//  584 /*-----------------------------------------------------------------------*/
//  585 #if _FS_REENTRANT
//  586 
//  587 static
//  588 int lock_fs (
//  589 	FATFS *fs		/* File system object */
//  590 )
//  591 {
//  592 	return ff_req_grant(fs->sobj);
//  593 }
//  594 
//  595 
//  596 static
//  597 void unlock_fs (
//  598 	FATFS *fs,		/* File system object */
//  599 	FRESULT res		/* Result code to be returned */
//  600 )
//  601 {
//  602 	if (fs &&
//  603 		res != FR_NOT_ENABLED &&
//  604 		res != FR_INVALID_DRIVE &&
//  605 		res != FR_INVALID_OBJECT &&
//  606 		res != FR_TIMEOUT) {
//  607 		ff_rel_grant(fs->sobj);
//  608 	}
//  609 }
//  610 #endif
//  611 
//  612 
//  613 
//  614 /*-----------------------------------------------------------------------*/
//  615 /* File lock control functions                                           */
//  616 /*-----------------------------------------------------------------------*/
//  617 #if _FS_LOCK
//  618 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  619 static
//  620 FRESULT chk_lock (	/* Check if the file can be accessed */
//  621 	DIR* dj,		/* Directory object pointing the file to be checked */
//  622 	int acc			/* Desired access (0:Read, 1:Write, 2:Delete/Rename) */
//  623 )
//  624 {
chk_lock:
        PUSH     {R4,R5}
//  625 	UINT i, be;
//  626 
//  627 	/* Search file semaphore table */
//  628 	for (i = be = 0; i < _FS_LOCK; i++) {
        MOVS     R2,#+0
        MOVS     R3,R2
        B.N      ??chk_lock_0
//  629 		if (Files[i].fs) {	/* Existing entry */
//  630 			if (Files[i].fs == dj->fs &&	 	/* Check if the file matched with an open file */
//  631 				Files[i].clu == dj->sclust &&
//  632 				Files[i].idx == dj->index) break;
//  633 		} else {			/* Blank entry */
//  634 			be++;
??chk_lock_1:
        ADDS     R2,R2,#+1
//  635 		}
??chk_lock_2:
        ADDS     R3,R3,#+1
??chk_lock_0:
        CMP      R3,#+8
        BCS.N    ??chk_lock_3
        LDR.W    R4,??DataTable7
        MOVS     R5,#+12
        MLA      R4,R5,R3,R4
        LDR      R4,[R4, #+0]
        CMP      R4,#+0
        BEQ.N    ??chk_lock_1
        LDR.W    R4,??DataTable7
        MOVS     R5,#+12
        MLA      R4,R5,R3,R4
        LDR      R4,[R4, #+0]
        LDR      R5,[R0, #+0]
        CMP      R4,R5
        BNE.N    ??chk_lock_2
        LDR.W    R4,??DataTable7
        MOVS     R5,#+12
        MLA      R4,R5,R3,R4
        LDR      R4,[R4, #+4]
        LDR      R5,[R0, #+8]
        CMP      R4,R5
        BNE.N    ??chk_lock_2
        LDR.W    R4,??DataTable7
        MOVS     R5,#+12
        MLA      R4,R5,R3,R4
        LDRH     R4,[R4, #+8]
        LDRH     R5,[R0, #+6]
        CMP      R4,R5
        BNE.N    ??chk_lock_2
//  636 	}
//  637 	if (i == _FS_LOCK)	/* The file is not opened */
??chk_lock_3:
        CMP      R3,#+8
        BNE.N    ??chk_lock_4
//  638 		return (be || acc == 2) ? FR_OK : FR_TOO_MANY_OPEN_FILES;	/* Is there a blank entry for new file? */
        CMP      R2,#+0
        BNE.N    ??chk_lock_5
        CMP      R1,#+2
        BNE.N    ??chk_lock_6
??chk_lock_5:
        MOVS     R0,#+0
        B.N      ??chk_lock_7
??chk_lock_6:
        MOVS     R0,#+18
??chk_lock_7:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??chk_lock_8
//  639 
//  640 	/* The file has been opened. Reject any open against writing file and all write mode open */
//  641 	return (acc || Files[i].ctr == 0x100) ? FR_LOCKED : FR_OK;
??chk_lock_4:
        CMP      R1,#+0
        BNE.N    ??chk_lock_9
        LDR.W    R0,??DataTable7
        MOVS     R1,#+12
        MLA      R0,R1,R3,R0
        LDRH     R0,[R0, #+10]
        CMP      R0,#+256
        BNE.N    ??chk_lock_10
??chk_lock_9:
        MOVS     R0,#+16
        B.N      ??chk_lock_11
??chk_lock_10:
        MOVS     R0,#+0
??chk_lock_11:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??chk_lock_8:
        POP      {R4,R5}
        BX       LR               ;; return
//  642 }
//  643 
//  644 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  645 static
//  646 int enq_lock (void)	/* Check if an entry is available for a new file */
//  647 {
//  648 	UINT i;
//  649 
//  650 	for (i = 0; i < _FS_LOCK && Files[i].fs; i++) ;
enq_lock:
        MOVS     R0,#+0
        B.N      ??enq_lock_0
??enq_lock_1:
        ADDS     R0,R0,#+1
??enq_lock_0:
        CMP      R0,#+8
        BCS.N    ??enq_lock_2
        LDR.W    R1,??DataTable7
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+0]
        CMP      R1,#+0
        BNE.N    ??enq_lock_1
//  651 	return (i == _FS_LOCK) ? 0 : 1;
??enq_lock_2:
        CMP      R0,#+8
        BNE.N    ??enq_lock_3
        MOVS     R0,#+0
        B.N      ??enq_lock_4
??enq_lock_3:
        MOVS     R0,#+1
??enq_lock_4:
        BX       LR               ;; return
//  652 }
//  653 
//  654 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  655 static
//  656 UINT inc_lock (	/* Increment file open counter and returns its index (0:int error) */
//  657 	DIR* dj,	/* Directory object pointing the file to register or increment */
//  658 	int acc		/* Desired access mode (0:Read, !0:Write) */
//  659 )
//  660 {
inc_lock:
        PUSH     {R4,R5}
//  661 	UINT i;
//  662 
//  663 
//  664 	for (i = 0; i < _FS_LOCK; i++) {	/* Find the file */
        MOVS     R2,#+0
        B.N      ??inc_lock_0
??inc_lock_1:
        ADDS     R2,R2,#+1
??inc_lock_0:
        CMP      R2,#+8
        BCS.N    ??inc_lock_2
//  665 		if (Files[i].fs == dj->fs &&
//  666 			Files[i].clu == dj->sclust &&
//  667 			Files[i].idx == dj->index) break;
        LDR.W    R3,??DataTable7
        MOVS     R4,#+12
        MLA      R3,R4,R2,R3
        LDR      R3,[R3, #+0]
        LDR      R4,[R0, #+0]
        CMP      R3,R4
        BNE.N    ??inc_lock_1
        LDR.W    R3,??DataTable7
        MOVS     R4,#+12
        MLA      R3,R4,R2,R3
        LDR      R3,[R3, #+4]
        LDR      R4,[R0, #+8]
        CMP      R3,R4
        BNE.N    ??inc_lock_1
        LDR.W    R3,??DataTable7
        MOVS     R4,#+12
        MLA      R3,R4,R2,R3
        LDRH     R3,[R3, #+8]
        LDRH     R4,[R0, #+6]
        CMP      R3,R4
        BNE.N    ??inc_lock_1
//  668 	}
//  669 
//  670 	if (i == _FS_LOCK) {				/* Not opened. Register it as new. */
??inc_lock_2:
        CMP      R2,#+8
        BNE.N    ??inc_lock_3
//  671 		for (i = 0; i < _FS_LOCK && Files[i].fs; i++) ;
        MOVS     R2,#+0
        B.N      ??inc_lock_4
??inc_lock_5:
        ADDS     R2,R2,#+1
??inc_lock_4:
        CMP      R2,#+8
        BCS.N    ??inc_lock_6
        LDR.W    R3,??DataTable7
        MOVS     R4,#+12
        MLA      R3,R4,R2,R3
        LDR      R3,[R3, #+0]
        CMP      R3,#+0
        BNE.N    ??inc_lock_5
//  672 		if (i == _FS_LOCK) return 0;	/* No space to register (int err) */
??inc_lock_6:
        CMP      R2,#+8
        BNE.N    ??inc_lock_7
        MOVS     R0,#+0
        B.N      ??inc_lock_8
//  673 		Files[i].fs = dj->fs;
??inc_lock_7:
        LDR      R3,[R0, #+0]
        LDR.W    R4,??DataTable7
        MOVS     R5,#+12
        MLA      R4,R5,R2,R4
        STR      R3,[R4, #+0]
//  674 		Files[i].clu = dj->sclust;
        LDR      R3,[R0, #+8]
        LDR.W    R4,??DataTable7
        MOVS     R5,#+12
        MLA      R4,R5,R2,R4
        STR      R3,[R4, #+4]
//  675 		Files[i].idx = dj->index;
        LDRH     R0,[R0, #+6]
        LDR.W    R3,??DataTable7
        MOVS     R4,#+12
        MLA      R3,R4,R2,R3
        STRH     R0,[R3, #+8]
//  676 		Files[i].ctr = 0;
        MOVS     R0,#+0
        LDR.W    R3,??DataTable7
        MOVS     R4,#+12
        MLA      R3,R4,R2,R3
        STRH     R0,[R3, #+10]
//  677 	}
//  678 
//  679 	if (acc && Files[i].ctr) return 0;	/* Access violation (int err) */
??inc_lock_3:
        CMP      R1,#+0
        BEQ.N    ??inc_lock_9
        LDR.W    R0,??DataTable7
        MOVS     R3,#+12
        MLA      R0,R3,R2,R0
        LDRH     R0,[R0, #+10]
        CMP      R0,#+0
        BEQ.N    ??inc_lock_9
        MOVS     R0,#+0
        B.N      ??inc_lock_8
//  680 
//  681 	Files[i].ctr = acc ? 0x100 : Files[i].ctr + 1;	/* Set semaphore value */
??inc_lock_9:
        CMP      R1,#+0
        BEQ.N    ??inc_lock_10
        MOV      R0,#+256
        B.N      ??inc_lock_11
??inc_lock_10:
        LDR.W    R0,??DataTable7
        MOVS     R1,#+12
        MLA      R0,R1,R2,R0
        LDRH     R0,[R0, #+10]
        ADDS     R0,R0,#+1
??inc_lock_11:
        LDR.W    R1,??DataTable7
        MOVS     R3,#+12
        MLA      R1,R3,R2,R1
        STRH     R0,[R1, #+10]
//  682 
//  683 	return i + 1;
        ADDS     R0,R2,#+1
??inc_lock_8:
        POP      {R4,R5}
        BX       LR               ;; return
//  684 }
//  685 
//  686 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  687 static
//  688 FRESULT dec_lock (	/* Decrement file open counter */
//  689 	UINT i			/* Semaphore index */
//  690 )
//  691 {
//  692 	WORD n;
//  693 	FRESULT res;
//  694 
//  695 
//  696 	if (--i < _FS_LOCK) {
dec_lock:
        SUBS     R0,R0,#+1
        CMP      R0,#+8
        BCS.N    ??dec_lock_0
//  697 		n = Files[i].ctr;
        LDR.W    R1,??DataTable7
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDRH     R1,[R1, #+10]
//  698 		if (n == 0x100) n = 0;
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+256
        BNE.N    ??dec_lock_1
        MOVS     R1,#+0
//  699 		if (n) n--;
??dec_lock_1:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BEQ.N    ??dec_lock_2
        SUBS     R1,R1,#+1
//  700 		Files[i].ctr = n;
??dec_lock_2:
        LDR.W    R2,??DataTable7
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STRH     R1,[R2, #+10]
//  701 		if (!n) Files[i].fs = 0;
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BNE.N    ??dec_lock_3
        MOVS     R1,#+0
        LDR.W    R2,??DataTable7
        MOVS     R3,#+12
        MLA      R0,R3,R0,R2
        STR      R1,[R0, #+0]
//  702 		res = FR_OK;
??dec_lock_3:
        MOVS     R0,#+0
        B.N      ??dec_lock_4
//  703 	} else {
//  704 		res = FR_INT_ERR;
??dec_lock_0:
        MOVS     R0,#+2
//  705 	}
//  706 	return res;
??dec_lock_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  707 }
//  708 
//  709 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  710 static
//  711 void clear_lock (	/* Clear lock entries of the volume */
//  712 	FATFS *fs
//  713 )
//  714 {
clear_lock:
        PUSH     {R4}
//  715 	UINT i;
//  716 
//  717 	for (i = 0; i < _FS_LOCK; i++) {
        MOVS     R1,#+0
        B.N      ??clear_lock_0
//  718 		if (Files[i].fs == fs) Files[i].fs = 0;
??clear_lock_1:
        LDR.W    R2,??DataTable7
        MOVS     R3,#+12
        MLA      R2,R3,R1,R2
        LDR      R2,[R2, #+0]
        CMP      R2,R0
        BNE.N    ??clear_lock_2
        MOVS     R2,#+0
        LDR.W    R3,??DataTable7
        MOVS     R4,#+12
        MLA      R3,R4,R1,R3
        STR      R2,[R3, #+0]
//  719 	}
??clear_lock_2:
        ADDS     R1,R1,#+1
??clear_lock_0:
        CMP      R1,#+8
        BCC.N    ??clear_lock_1
//  720 }
        POP      {R4}
        BX       LR               ;; return
//  721 #endif
//  722 
//  723 
//  724 
//  725 /*-----------------------------------------------------------------------*/
//  726 /* Move/Flush disk access window                                         */
//  727 /*-----------------------------------------------------------------------*/
//  728 
//  729 
//  730 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  731 static
//  732 FRESULT sync_window (
//  733 	FATFS *fs		/* File system object */
//  734 )
//  735 {
sync_window:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
//  736 	DWORD wsect;
//  737 	UINT nf;
//  738 
//  739 	
//  740 	if (fs->wflag) {	/* Write back the sector if it is dirty */
        LDRB     R0,[R4, #+4]
        CMP      R0,#+0
        BEQ.N    ??sync_window_0
//  741 		wsect = fs->winsect;	/* Current sector number */
        LDR      R5,[R4, #+52]
//  742 		if (disk_write(fs->drv, fs->win, wsect, 1) != RES_OK)
        MOVS     R3,#+1
        MOVS     R2,R5
        ADDS     R1,R4,#+56
        LDRB     R0,[R4, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??sync_window_1
//  743 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??sync_window_2
//  744 		fs->wflag = 0;
??sync_window_1:
        MOVS     R0,#+0
        STRB     R0,[R4, #+4]
//  745 		if (wsect >= fs->fatbase && wsect < (fs->fatbase + fs->fsize)) {	/* In FAT area? */
        LDR      R0,[R4, #+40]
        CMP      R5,R0
        BCC.N    ??sync_window_0
        LDR      R0,[R4, #+40]
        LDR      R1,[R4, #+32]
        ADDS     R0,R1,R0
        CMP      R5,R0
        BCS.N    ??sync_window_0
//  746 			for (nf = fs->n_fats; nf >= 2; nf--) {	/* Reflect the change to all FAT copies */
        LDRB     R6,[R4, #+3]
        B.N      ??sync_window_3
//  747 				wsect += fs->fsize;
??sync_window_4:
        LDR      R0,[R4, #+32]
        ADDS     R5,R0,R5
//  748 				disk_write(fs->drv, fs->win, wsect, 1);
        MOVS     R3,#+1
        MOVS     R2,R5
        ADDS     R1,R4,#+56
        LDRB     R0,[R4, #+1]
        BL       disk_write
//  749 			}
        SUBS     R6,R6,#+1
??sync_window_3:
        CMP      R6,#+2
        BCS.N    ??sync_window_4
//  750 		}
//  751 	}
//  752 	return FR_OK;
??sync_window_0:
        MOVS     R0,#+0
??sync_window_2:
        POP      {R4-R6,PC}       ;; return
//  753 }
//  754 #endif
//  755 
//  756 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  757 static
//  758 FRESULT move_window (
//  759 	FATFS *fs,		/* File system object */
//  760 	DWORD sector	/* Sector number to make appearance in the fs->win[] */
//  761 )
//  762 {
move_window:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  763 	if (sector != fs->winsect) {	/* Changed current window */
        LDR      R0,[R4, #+52]
        CMP      R5,R0
        BEQ.N    ??move_window_0
//  764 #if !_FS_READONLY
//  765 		if (sync_window(fs) != FR_OK)
        MOVS     R0,R4
        BL       sync_window
        CMP      R0,#+0
        BEQ.N    ??move_window_1
//  766 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??move_window_2
//  767 #endif
//  768 		if (disk_read(fs->drv, fs->win, sector, 1) != RES_OK)
??move_window_1:
        MOVS     R3,#+1
        MOVS     R2,R5
        ADDS     R1,R4,#+56
        LDRB     R0,[R4, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??move_window_3
//  769 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??move_window_2
//  770 		fs->winsect = sector;
??move_window_3:
        STR      R5,[R4, #+52]
//  771 	}
//  772 
//  773 	return FR_OK;
??move_window_0:
        MOVS     R0,#+0
??move_window_2:
        POP      {R1,R4,R5,PC}    ;; return
//  774 }
//  775 
//  776 
//  777 
//  778 
//  779 /*-----------------------------------------------------------------------*/
//  780 /* Synchronize file system and strage device                             */
//  781 /*-----------------------------------------------------------------------*/
//  782 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  783 static
//  784 FRESULT sync_fs (	/* FR_OK: successful, FR_DISK_ERR: failed */
//  785 	FATFS *fs		/* File system object */
//  786 )
//  787 {
sync_fs:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  788 	FRESULT res;
//  789 
//  790 
//  791 	res = sync_window(fs);
        MOVS     R0,R4
        BL       sync_window
        MOVS     R5,R0
//  792 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??sync_fs_0
//  793 		/* Update FSInfo sector if needed */
//  794 		if (fs->fs_type == FS_FAT32 && fs->fsi_flag) {
        LDRB     R0,[R4, #+0]
        CMP      R0,#+3
        BNE.N    ??sync_fs_1
        LDRB     R0,[R4, #+5]
        CMP      R0,#+0
        BEQ.N    ??sync_fs_1
//  795 			fs->winsect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+52]
//  796 			/* Create FSInfo structure */
//  797 			mem_set(fs->win, 0, 512);
        MOV      R2,#+512
        MOVS     R1,#+0
        ADDS     R0,R4,#+56
        BL       mem_set
//  798 			ST_WORD(fs->win+BS_55AA, 0xAA55);
        MOVS     R0,#+85
        STRB     R0,[R4, #+566]
        MOVS     R0,#+170
        STRB     R0,[R4, #+567]
//  799 			ST_DWORD(fs->win+FSI_LeadSig, 0x41615252);
        MOVS     R0,#+82
        STRB     R0,[R4, #+56]
        MOVS     R0,#+82
        STRB     R0,[R4, #+57]
        MOVS     R0,#+97
        STRB     R0,[R4, #+58]
        MOVS     R0,#+65
        STRB     R0,[R4, #+59]
//  800 			ST_DWORD(fs->win+FSI_StrucSig, 0x61417272);
        MOVS     R0,#+114
        STRB     R0,[R4, #+540]
        MOVS     R0,#+114
        STRB     R0,[R4, #+541]
        MOVS     R0,#+65
        STRB     R0,[R4, #+542]
        MOVS     R0,#+97
        STRB     R0,[R4, #+543]
//  801 			ST_DWORD(fs->win+FSI_Free_Count, fs->free_clust);
        LDR      R0,[R4, #+16]
        STRB     R0,[R4, #+544]
        LDR      R0,[R4, #+16]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R4, #+545]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+16
        STRB     R0,[R4, #+546]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+24
        STRB     R0,[R4, #+547]
//  802 			ST_DWORD(fs->win+FSI_Nxt_Free, fs->last_clust);
        LDR      R0,[R4, #+12]
        STRB     R0,[R4, #+548]
        LDR      R0,[R4, #+12]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R4, #+549]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+16
        STRB     R0,[R4, #+550]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+24
        STRB     R0,[R4, #+551]
//  803 			/* Write it into the FSInfo sector */
//  804 			disk_write(fs->drv, fs->win, fs->fsi_sector, 1);
        MOVS     R3,#+1
        LDR      R2,[R4, #+20]
        ADDS     R1,R4,#+56
        LDRB     R0,[R4, #+1]
        BL       disk_write
//  805 			fs->fsi_flag = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+5]
//  806 		}
//  807 		/* Make sure that no pending write process in the physical drive */
//  808 		if (disk_ioctl(fs->drv, CTRL_SYNC, 0) != RES_OK)
??sync_fs_1:
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDRB     R0,[R4, #+1]
        BL       disk_ioctl
        CMP      R0,#+0
        BEQ.N    ??sync_fs_0
//  809 			res = FR_DISK_ERR;
        MOVS     R5,#+1
//  810 	}
//  811 
//  812 	return res;
??sync_fs_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//  813 }
//  814 #endif
//  815 
//  816 
//  817 
//  818 
//  819 /*-----------------------------------------------------------------------*/
//  820 /* Get sector# from cluster#                                             */
//  821 /*-----------------------------------------------------------------------*/
//  822 
//  823 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  824 DWORD clust2sect (	/* !=0: Sector number, 0: Failed - invalid cluster# */
//  825 	FATFS *fs,		/* File system object */
//  826 	DWORD clst		/* Cluster# to be converted */
//  827 )
//  828 {
//  829 	clst -= 2;
clust2sect:
        SUBS     R1,R1,#+2
//  830 	if (clst >= (fs->n_fatent - 2)) return 0;		/* Invalid cluster# */
        LDR      R2,[R0, #+28]
        SUBS     R2,R2,#+2
        CMP      R1,R2
        BCC.N    ??clust2sect_0
        MOVS     R0,#+0
        B.N      ??clust2sect_1
//  831 	return clst * fs->csize + fs->database;
??clust2sect_0:
        LDRB     R2,[R0, #+2]
        LDR      R0,[R0, #+48]
        MLA      R0,R2,R1,R0
??clust2sect_1:
        BX       LR               ;; return
//  832 }
//  833 
//  834 
//  835 
//  836 
//  837 /*-----------------------------------------------------------------------*/
//  838 /* FAT access - Read value of a FAT entry                                */
//  839 /*-----------------------------------------------------------------------*/
//  840 
//  841 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  842 DWORD get_fat (	/* 0xFFFFFFFF:Disk error, 1:Internal error, Else:Cluster status */
//  843 	FATFS *fs,	/* File system object */
//  844 	DWORD clst	/* Cluster# to get the link information */
//  845 )
//  846 {
get_fat:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  847 	UINT wc, bc;
//  848 	BYTE *p;
//  849 
//  850 
//  851 	if (clst < 2 || clst >= fs->n_fatent)	/* Check range */
        CMP      R5,#+2
        BCC.N    ??get_fat_0
        LDR      R0,[R4, #+28]
        CMP      R5,R0
        BCC.N    ??get_fat_1
//  852 		return 1;
??get_fat_0:
        MOVS     R0,#+1
        B.N      ??get_fat_2
//  853 
//  854 	switch (fs->fs_type) {
??get_fat_1:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??get_fat_3
        BCC.N    ??get_fat_4
        CMP      R0,#+3
        BEQ.N    ??get_fat_5
        BCC.N    ??get_fat_6
        B.N      ??get_fat_4
//  855 	case FS_FAT12 :
//  856 		bc = (UINT)clst; bc += bc / 2;
??get_fat_3:
        MOVS     R6,R5
        ADDS     R6,R6,R6, LSR #+1
//  857 		if (move_window(fs, fs->fatbase + (bc / SS(fs)))) break;
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R6, LSR #+9
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BEQ.N    ??get_fat_7
//  858 		wc = fs->win[bc % SS(fs)]; bc++;
//  859 		if (move_window(fs, fs->fatbase + (bc / SS(fs)))) break;
//  860 		wc |= fs->win[bc % SS(fs)] << 8;
//  861 		return (clst & 1) ? (wc >> 4) : (wc & 0xFFF);
//  862 
//  863 	case FS_FAT16 :
//  864 		if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)))) break;
//  865 		p = &fs->win[clst * 2 % SS(fs)];
//  866 		return LD_WORD(p);
//  867 
//  868 	case FS_FAT32 :
//  869 		if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)))) break;
//  870 		p = &fs->win[clst * 4 % SS(fs)];
//  871 		return LD_DWORD(p) & 0x0FFFFFFF;
//  872 	}
//  873 
//  874 	return 0xFFFFFFFF;	/* An error occurred at the disk I/O layer */
??get_fat_4:
        MOVS     R0,#-1
??get_fat_2:
        POP      {R1,R4-R7,PC}    ;; return
??get_fat_7:
        MOV      R0,#+512
        UDIV     R1,R6,R0
        MLS      R1,R1,R0,R6
        ADDS     R0,R1,R4
        LDRB     R7,[R0, #+56]
        ADDS     R6,R6,#+1
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R6, LSR #+9
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_8:
        MOV      R0,#+512
        UDIV     R1,R6,R0
        MLS      R1,R1,R0,R6
        ADDS     R0,R1,R4
        LDRB     R0,[R0, #+56]
        ORRS     R7,R7,R0, LSL #+8
        LSLS     R0,R5,#+31
        BPL.N    ??get_fat_9
        LSRS     R0,R7,#+4
        B.N      ??get_fat_10
??get_fat_9:
        LSLS     R0,R7,#+20       ;; ZeroExtS R0,R7,#+20,#+20
        LSRS     R0,R0,#+20
??get_fat_10:
        B.N      ??get_fat_2
??get_fat_6:
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R5, LSR #+8
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_11:
        LSLS     R0,R5,#+1
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        ADDS     R0,R2,R4
        ADDS     R0,R0,#+56
        LDRB     R1,[R0, #+1]
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,R1, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        B.N      ??get_fat_2
??get_fat_5:
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R5, LSR #+7
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_12:
        LSLS     R0,R5,#+2
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        ADDS     R0,R2,R4
        ADDS     R0,R0,#+56
        LDRB     R1,[R0, #+3]
        LDRB     R2,[R0, #+2]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R0, #+1]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,R1
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        B.N      ??get_fat_2
//  875 }
//  876 
//  877 
//  878 
//  879 
//  880 /*-----------------------------------------------------------------------*/
//  881 /* FAT access - Change value of a FAT entry                              */
//  882 /*-----------------------------------------------------------------------*/
//  883 #if !_FS_READONLY
//  884 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  885 FRESULT put_fat (
//  886 	FATFS *fs,	/* File system object */
//  887 	DWORD clst,	/* Cluster# to be changed in range of 2 to fs->n_fatent - 1 */
//  888 	DWORD val	/* New value to mark the cluster */
//  889 )
//  890 {
put_fat:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  891 	UINT bc;
//  892 	BYTE *p;
//  893 	FRESULT res;
//  894 
//  895 
//  896 	if (clst < 2 || clst >= fs->n_fatent) {	/* Check range */
        CMP      R5,#+2
        BCC.N    ??put_fat_0
        LDR      R0,[R4, #+28]
        CMP      R5,R0
        BCC.N    ??put_fat_1
//  897 		res = FR_INT_ERR;
??put_fat_0:
        MOVS     R0,#+2
        B.N      ??put_fat_2
//  898 
//  899 	} else {
//  900 		switch (fs->fs_type) {
??put_fat_1:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??put_fat_3
        BCC.N    ??put_fat_4
        CMP      R0,#+3
        BEQ.N    ??put_fat_5
        BCC.N    ??put_fat_6
        B.N      ??put_fat_4
//  901 		case FS_FAT12 :
//  902 			bc = (UINT)clst; bc += bc / 2;
??put_fat_3:
        MOVS     R7,R5
        ADDS     R7,R7,R7, LSR #+1
//  903 			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R7, LSR #+9
        MOVS     R0,R4
        BL       move_window
//  904 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  905 			p = &fs->win[bc % SS(fs)];
??put_fat_8:
        MOV      R0,#+512
        UDIV     R1,R7,R0
        MLS      R1,R1,R0,R7
        ADDS     R0,R1,R4
        ADDS     R1,R0,#+56
//  906 			*p = (clst & 1) ? ((*p & 0x0F) | ((BYTE)val << 4)) : (BYTE)val;
        LSLS     R0,R5,#+31
        BPL.N    ??put_fat_9
        LDRB     R0,[R1, #+0]
        ANDS     R0,R0,#0xF
        ORRS     R0,R0,R6, LSL #+4
        B.N      ??put_fat_10
??put_fat_9:
        MOVS     R0,R6
??put_fat_10:
        STRB     R0,[R1, #+0]
//  907 			bc++;
        ADDS     R7,R7,#+1
//  908 			fs->wflag = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+4]
//  909 			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R7, LSR #+9
        MOVS     R0,R4
        BL       move_window
//  910 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  911 			p = &fs->win[bc % SS(fs)];
??put_fat_11:
        MOV      R1,#+512
        UDIV     R2,R7,R1
        MLS      R2,R2,R1,R7
        ADDS     R1,R2,R4
        ADDS     R1,R1,#+56
//  912 			*p = (clst & 1) ? (BYTE)(val >> 4) : ((*p & 0xF0) | ((BYTE)(val >> 8) & 0x0F));
        LSLS     R2,R5,#+31
        BPL.N    ??put_fat_12
        LSRS     R2,R6,#+4
        B.N      ??put_fat_13
??put_fat_12:
        LDRB     R2,[R1, #+0]
        ANDS     R2,R2,#0xF0
        LSRS     R3,R6,#+8
        ANDS     R3,R3,#0xF
        ORRS     R2,R3,R2
??put_fat_13:
        STRB     R2,[R1, #+0]
//  913 			break;
        B.N      ??put_fat_7
//  914 
//  915 		case FS_FAT16 :
//  916 			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)));
??put_fat_6:
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R5, LSR #+8
        MOVS     R0,R4
        BL       move_window
//  917 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  918 			p = &fs->win[clst * 2 % SS(fs)];
??put_fat_14:
        LSLS     R1,R5,#+1
        MOV      R2,#+512
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        ADDS     R1,R3,R4
        ADDS     R1,R1,#+56
//  919 			ST_WORD(p, (WORD)val);
        STRB     R6,[R1, #+0]
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LSRS     R2,R6,#+8
        STRB     R2,[R1, #+1]
//  920 			break;
        B.N      ??put_fat_7
//  921 
//  922 		case FS_FAT32 :
//  923 			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)));
??put_fat_5:
        LDR      R0,[R4, #+40]
        ADDS     R1,R0,R5, LSR #+7
        MOVS     R0,R4
        BL       move_window
//  924 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  925 			p = &fs->win[clst * 4 % SS(fs)];
??put_fat_15:
        LSLS     R1,R5,#+2
        MOV      R2,#+512
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        ADDS     R1,R3,R4
        ADDS     R1,R1,#+56
//  926 			val |= LD_DWORD(p) & 0xF0000000;
        LDRB     R2,[R1, #+3]
        LSLS     R2,R2,#+24
        ANDS     R2,R2,#0xF0000000
        ORRS     R6,R2,R6
//  927 			ST_DWORD(p, val);
        STRB     R6,[R1, #+0]
        MOVS     R2,R6
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSRS     R2,R2,#+8
        STRB     R2,[R1, #+1]
        LSRS     R2,R6,#+16
        STRB     R2,[R1, #+2]
        LSRS     R2,R6,#+24
        STRB     R2,[R1, #+3]
//  928 			break;
        B.N      ??put_fat_7
//  929 
//  930 		default :
//  931 			res = FR_INT_ERR;
??put_fat_4:
        MOVS     R0,#+2
//  932 		}
//  933 		fs->wflag = 1;
??put_fat_7:
        MOVS     R1,#+1
        STRB     R1,[R4, #+4]
//  934 	}
//  935 
//  936 	return res;
??put_fat_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
//  937 }
//  938 #endif /* !_FS_READONLY */
//  939 
//  940 
//  941 
//  942 
//  943 /*-----------------------------------------------------------------------*/
//  944 /* FAT handling - Remove a cluster chain                                 */
//  945 /*-----------------------------------------------------------------------*/
//  946 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  947 static
//  948 FRESULT remove_chain (
//  949 	FATFS *fs,			/* File system object */
//  950 	DWORD clst			/* Cluster# to remove a chain from */
//  951 )
//  952 {
remove_chain:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R6,R1
//  953 	FRESULT res;
//  954 	DWORD nxt;
//  955 #if _USE_ERASE
//  956 	DWORD scl = clst, ecl = clst, rt[2];
//  957 #endif
//  958 
//  959 	if (clst < 2 || clst >= fs->n_fatent) {	/* Check range */
        CMP      R6,#+2
        BCC.N    ??remove_chain_0
        LDR      R0,[R4, #+28]
        CMP      R6,R0
        BCC.N    ??remove_chain_1
//  960 		res = FR_INT_ERR;
??remove_chain_0:
        MOVS     R5,#+2
        B.N      ??remove_chain_2
//  961 
//  962 	} else {
//  963 		res = FR_OK;
??remove_chain_1:
        MOVS     R5,#+0
        B.N      ??remove_chain_3
//  964 		while (clst < fs->n_fatent) {			/* Not a last link? */
//  965 			nxt = get_fat(fs, clst);			/* Get cluster status */
//  966 			if (nxt == 0) break;				/* Empty cluster? */
//  967 			if (nxt == 1) { res = FR_INT_ERR; break; }	/* Internal error? */
//  968 			if (nxt == 0xFFFFFFFF) { res = FR_DISK_ERR; break; }	/* Disk error? */
//  969 			res = put_fat(fs, clst, 0);			/* Mark the cluster "empty" */
//  970 			if (res != FR_OK) break;
//  971 			if (fs->free_clust != 0xFFFFFFFF) {	/* Update FSInfo */
??remove_chain_4:
        LDR      R0,[R4, #+16]
        CMN      R0,#+1
        BEQ.N    ??remove_chain_5
//  972 				fs->free_clust++;
        LDR      R0,[R4, #+16]
        ADDS     R0,R0,#+1
        STR      R0,[R4, #+16]
//  973 				fs->fsi_flag = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+5]
//  974 			}
//  975 #if _USE_ERASE
//  976 			if (ecl + 1 == nxt) {	/* Is next cluster contiguous? */
//  977 				ecl = nxt;
//  978 			} else {				/* End of contiguous clusters */ 
//  979 				rt[0] = clust2sect(fs, scl);					/* Start sector */
//  980 				rt[1] = clust2sect(fs, ecl) + fs->csize - 1;	/* End sector */
//  981 				disk_ioctl(fs->drv, CTRL_ERASE_SECTOR, rt);		/* Erase the block */
//  982 				scl = ecl = nxt;
//  983 			}
//  984 #endif
//  985 			clst = nxt;	/* Next cluster */
??remove_chain_5:
        MOVS     R6,R7
??remove_chain_3:
        LDR      R0,[R4, #+28]
        CMP      R6,R0
        BCS.N    ??remove_chain_2
        MOVS     R1,R6
        MOVS     R0,R4
        BL       get_fat
        MOVS     R7,R0
        CMP      R7,#+0
        BEQ.N    ??remove_chain_2
??remove_chain_6:
        CMP      R7,#+1
        BNE.N    ??remove_chain_7
        MOVS     R5,#+2
        B.N      ??remove_chain_2
??remove_chain_7:
        CMN      R7,#+1
        BNE.N    ??remove_chain_8
        MOVS     R5,#+1
        B.N      ??remove_chain_2
??remove_chain_8:
        MOVS     R2,#+0
        MOVS     R1,R6
        MOVS     R0,R4
        BL       put_fat
        MOVS     R5,R0
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??remove_chain_4
//  986 		}
//  987 	}
//  988 
//  989 	return res;
??remove_chain_2:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
//  990 }
//  991 #endif
//  992 
//  993 
//  994 
//  995 
//  996 /*-----------------------------------------------------------------------*/
//  997 /* FAT handling - Stretch or Create a cluster chain                      */
//  998 /*-----------------------------------------------------------------------*/
//  999 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1000 static
// 1001 DWORD create_chain (	/* 0:No free cluster, 1:Internal error, 0xFFFFFFFF:Disk error, >=2:New cluster# */
// 1002 	FATFS *fs,			/* File system object */
// 1003 	DWORD clst			/* Cluster# to stretch. 0 means create a new chain. */
// 1004 )
// 1005 {
create_chain:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R6,R1
// 1006 	DWORD cs, ncl, scl;
// 1007 	FRESULT res;
// 1008 
// 1009 
// 1010 	if (clst == 0) {		/* Create a new chain */
        CMP      R6,#+0
        BNE.N    ??create_chain_0
// 1011 		scl = fs->last_clust;			/* Get suggested start point */
        LDR      R7,[R4, #+12]
// 1012 		if (!scl || scl >= fs->n_fatent) scl = 1;
        CMP      R7,#+0
        BEQ.N    ??create_chain_1
        LDR      R0,[R4, #+28]
        CMP      R7,R0
        BCC.N    ??create_chain_2
??create_chain_1:
        MOVS     R7,#+1
        B.N      ??create_chain_2
// 1013 	}
// 1014 	else {					/* Stretch the current chain */
// 1015 		cs = get_fat(fs, clst);			/* Check the cluster status */
??create_chain_0:
        MOVS     R1,R6
        MOVS     R0,R4
        BL       get_fat
// 1016 		if (cs < 2) return 1;			/* It is an invalid cluster */
        CMP      R0,#+2
        BCS.N    ??create_chain_3
        MOVS     R0,#+1
        B.N      ??create_chain_4
// 1017 		if (cs < fs->n_fatent) return cs;	/* It is already followed by next cluster */
??create_chain_3:
        LDR      R1,[R4, #+28]
        CMP      R0,R1
        BCC.N    ??create_chain_4
// 1018 		scl = clst;
??create_chain_5:
        MOVS     R7,R6
// 1019 	}
// 1020 
// 1021 	ncl = scl;				/* Start cluster */
??create_chain_2:
        MOVS     R5,R7
// 1022 	for (;;) {
// 1023 		ncl++;							/* Next cluster */
??create_chain_6:
        ADDS     R5,R5,#+1
// 1024 		if (ncl >= fs->n_fatent) {		/* Wrap around */
        LDR      R0,[R4, #+28]
        CMP      R5,R0
        BCC.N    ??create_chain_7
// 1025 			ncl = 2;
        MOVS     R5,#+2
// 1026 			if (ncl > scl) return 0;	/* No free cluster */
        CMP      R7,R5
        BCS.N    ??create_chain_7
        MOVS     R0,#+0
        B.N      ??create_chain_4
// 1027 		}
// 1028 		cs = get_fat(fs, ncl);			/* Get the cluster status */
??create_chain_7:
        MOVS     R1,R5
        MOVS     R0,R4
        BL       get_fat
// 1029 		if (cs == 0) break;				/* Found a free cluster */
        CMP      R0,#+0
        BNE.N    ??create_chain_8
// 1030 		if (cs == 0xFFFFFFFF || cs == 1)/* An error occurred */
// 1031 			return cs;
// 1032 		if (ncl == scl) return 0;		/* No free cluster */
// 1033 	}
// 1034 
// 1035 	res = put_fat(fs, ncl, 0x0FFFFFFF);	/* Mark the new cluster "last link" */
        MVNS     R2,#-268435456
        MOVS     R1,R5
        MOVS     R0,R4
        BL       put_fat
// 1036 	if (res == FR_OK && clst != 0) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??create_chain_9
        CMP      R6,#+0
        BEQ.N    ??create_chain_9
// 1037 		res = put_fat(fs, clst, ncl);	/* Link it to the previous one if needed */
        MOVS     R2,R5
        MOVS     R1,R6
        MOVS     R0,R4
        BL       put_fat
// 1038 	}
// 1039 	if (res == FR_OK) {
??create_chain_9:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??create_chain_10
// 1040 		fs->last_clust = ncl;			/* Update FSINFO */
        STR      R5,[R4, #+12]
// 1041 		if (fs->free_clust != 0xFFFFFFFF) {
        LDR      R0,[R4, #+16]
        CMN      R0,#+1
        BEQ.N    ??create_chain_11
// 1042 			fs->free_clust--;
        LDR      R0,[R4, #+16]
        SUBS     R0,R0,#+1
        STR      R0,[R4, #+16]
// 1043 			fs->fsi_flag = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+5]
        B.N      ??create_chain_11
// 1044 		}
// 1045 	} else {
??create_chain_8:
        CMN      R0,#+1
        BEQ.N    ??create_chain_12
        CMP      R0,#+1
        BNE.N    ??create_chain_13
??create_chain_12:
        B.N      ??create_chain_4
??create_chain_13:
        CMP      R5,R7
        BNE.N    ??create_chain_6
        MOVS     R0,#+0
        B.N      ??create_chain_4
// 1046 		ncl = (res == FR_DISK_ERR) ? 0xFFFFFFFF : 1;
??create_chain_10:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??create_chain_14
        MOVS     R5,#-1
        B.N      ??create_chain_11
??create_chain_14:
        MOVS     R5,#+1
// 1047 	}
// 1048 
// 1049 	return ncl;		/* Return new cluster number or error code */
??create_chain_11:
        MOVS     R0,R5
??create_chain_4:
        POP      {R1,R4-R7,PC}    ;; return
// 1050 }
// 1051 #endif /* !_FS_READONLY */
// 1052 
// 1053 
// 1054 
// 1055 /*-----------------------------------------------------------------------*/
// 1056 /* FAT handling - Convert offset into cluster with link map table        */
// 1057 /*-----------------------------------------------------------------------*/
// 1058 
// 1059 #if _USE_FASTSEEK

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1060 static
// 1061 DWORD clmt_clust (	/* <2:Error, >=2:Cluster number */
// 1062 	FIL* fp,		/* Pointer to the file object */
// 1063 	DWORD ofs		/* File offset to be converted to cluster# */
// 1064 )
// 1065 {
// 1066 	DWORD cl, ncl, *tbl;
// 1067 
// 1068 
// 1069 	tbl = fp->cltbl + 1;	/* Top of CLMT */
clmt_clust:
        LDR      R2,[R0, #+36]
        ADDS     R2,R2,#+4
// 1070 	cl = ofs / SS(fp->fs) / fp->fs->csize;	/* Cluster order from top of the file */
        LSRS     R1,R1,#+9
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+2]
        UDIV     R0,R1,R0
        B.N      ??clmt_clust_0
// 1071 	for (;;) {
// 1072 		ncl = *tbl++;			/* Number of cluters in the fragment */
// 1073 		if (!ncl) return 0;		/* End of table? (error) */
// 1074 		if (cl < ncl) break;	/* In this fragment? */
// 1075 		cl -= ncl; tbl++;		/* Next fragment */
??clmt_clust_1:
        SUBS     R0,R0,R1
        ADDS     R2,R2,#+4
??clmt_clust_0:
        LDR      R1,[R2, #+0]
        ADDS     R2,R2,#+4
        CMP      R1,#+0
        BNE.N    ??clmt_clust_2
        MOVS     R0,#+0
        B.N      ??clmt_clust_3
??clmt_clust_2:
        CMP      R0,R1
        BCS.N    ??clmt_clust_1
// 1076 	}
// 1077 	return cl + *tbl;	/* Return the cluster number */
        LDR      R1,[R2, #+0]
        ADDS     R0,R1,R0
??clmt_clust_3:
        BX       LR               ;; return
// 1078 }
// 1079 #endif	/* _USE_FASTSEEK */
// 1080 
// 1081 
// 1082 
// 1083 /*-----------------------------------------------------------------------*/
// 1084 /* Directory handling - Set directory index                              */
// 1085 /*-----------------------------------------------------------------------*/
// 1086 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1087 static
// 1088 FRESULT dir_sdi (
// 1089 	DIR *dj,		/* Pointer to directory object */
// 1090 	WORD idx		/* Index of directory table */
// 1091 )
// 1092 {
dir_sdi:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1093 	DWORD clst;
// 1094 	WORD ic;
// 1095 
// 1096 
// 1097 	dj->index = idx;
        STRH     R5,[R4, #+6]
// 1098 	clst = dj->sclust;
        LDR      R0,[R4, #+8]
// 1099 	if (clst == 1 || clst >= dj->fs->n_fatent)	/* Check start cluster range */
        CMP      R0,#+1
        BEQ.N    ??dir_sdi_0
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+28]
        CMP      R0,R1
        BCC.N    ??dir_sdi_1
// 1100 		return FR_INT_ERR;
??dir_sdi_0:
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1101 	if (!clst && dj->fs->fs_type == FS_FAT32)	/* Replace cluster# 0 with root cluster# if in FAT32 */
??dir_sdi_1:
        CMP      R0,#+0
        BNE.N    ??dir_sdi_3
        LDR      R1,[R4, #+0]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+3
        BNE.N    ??dir_sdi_3
// 1102 		clst = dj->fs->dirbase;
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+44]
// 1103 
// 1104 	if (clst == 0) {	/* Static table (root-dir in FAT12/16) */
??dir_sdi_3:
        CMP      R0,#+0
        BNE.N    ??dir_sdi_4
// 1105 		dj->clust = clst;
        STR      R0,[R4, #+12]
// 1106 		if (idx >= dj->fs->n_rootdir)		/* Index is out of range */
        LDR      R0,[R4, #+0]
        LDRH     R0,[R0, #+8]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,R0
        BCC.N    ??dir_sdi_5
// 1107 			return FR_INT_ERR;
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1108 		dj->sect = dj->fs->dirbase + idx / (SS(dj->fs) / SZ_DIR);	/* Sector# */
??dir_sdi_5:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+44]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,R5, LSR #+4
        STR      R0,[R4, #+16]
        B.N      ??dir_sdi_6
// 1109 	}
// 1110 	else {				/* Dynamic table (sub-dirs or root-dir in FAT32) */
// 1111 		ic = SS(dj->fs) / SZ_DIR * dj->fs->csize;	/* Entries per cluster */
??dir_sdi_4:
        LDR      R1,[R4, #+0]
        LDRB     R1,[R1, #+2]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSLS     R6,R1,#+4
        B.N      ??dir_sdi_7
// 1112 		while (idx >= ic) {	/* Follow cluster chain */
// 1113 			clst = get_fat(dj->fs, clst);				/* Get next cluster */
// 1114 			if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
// 1115 			if (clst < 2 || clst >= dj->fs->n_fatent)	/* Reached to end of table or int error */
// 1116 				return FR_INT_ERR;
// 1117 			idx -= ic;
??dir_sdi_8:
        SUBS     R5,R5,R6
??dir_sdi_7:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R5,R6
        BCC.N    ??dir_sdi_9
        MOVS     R1,R0
        LDR      R0,[R4, #+0]
        BL       get_fat
        CMN      R0,#+1
        BNE.N    ??dir_sdi_10
        MOVS     R0,#+1
        B.N      ??dir_sdi_2
??dir_sdi_10:
        CMP      R0,#+2
        BCC.N    ??dir_sdi_11
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+28]
        CMP      R0,R1
        BCC.N    ??dir_sdi_8
??dir_sdi_11:
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1118 		}
// 1119 		dj->clust = clst;
??dir_sdi_9:
        STR      R0,[R4, #+12]
// 1120 		dj->sect = clust2sect(dj->fs, clst) + idx / (SS(dj->fs) / SZ_DIR);	/* Sector# */
        MOVS     R1,R0
        LDR      R0,[R4, #+0]
        BL       clust2sect
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,R5, LSR #+4
        STR      R0,[R4, #+16]
// 1121 	}
// 1122 
// 1123 	dj->dir = dj->fs->win + (idx % (SS(dj->fs) / SZ_DIR)) * SZ_DIR;	/* Ptr to the entry in the sector */
??dir_sdi_6:
        LDR      R0,[R4, #+0]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R1,#+16
        UDIV     R2,R5,R1
        MLS      R2,R2,R1,R5
        ADDS     R0,R0,R2, LSL #+5
        ADDS     R0,R0,#+56
        STR      R0,[R4, #+20]
// 1124 
// 1125 	return FR_OK;	/* Seek succeeded */
        MOVS     R0,#+0
??dir_sdi_2:
        POP      {R4-R6,PC}       ;; return
// 1126 }
// 1127 
// 1128 
// 1129 
// 1130 
// 1131 /*-----------------------------------------------------------------------*/
// 1132 /* Directory handling - Move directory table index next                  */
// 1133 /*-----------------------------------------------------------------------*/
// 1134 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1135 static
// 1136 FRESULT dir_next (	/* FR_OK:Succeeded, FR_NO_FILE:End of table, FR_DENIED:Could not stretch */
// 1137 	DIR *dj,		/* Pointer to the directory object */
// 1138 	int stretch		/* 0: Do not stretch table, 1: Stretch table if needed */
// 1139 )
// 1140 {
dir_next:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1141 	DWORD clst;
// 1142 	WORD i;
// 1143 
// 1144 
// 1145 	stretch = stretch;		/* To suppress warning on read-only cfg. */
// 1146 	i = dj->index + 1;
        LDRH     R0,[R4, #+6]
        ADDS     R6,R0,#+1
// 1147 	if (!i || !dj->sect)	/* Report EOT when index has reached 65535 */
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+0
        BEQ.N    ??dir_next_0
        LDR      R0,[R4, #+16]
        CMP      R0,#+0
        BNE.N    ??dir_next_1
// 1148 		return FR_NO_FILE;
??dir_next_0:
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1149 
// 1150 	if (!(i % (SS(dj->fs) / SZ_DIR))) {	/* Sector changed? */
??dir_next_1:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+16
        UDIV     R1,R6,R0
        MLS      R1,R1,R0,R6
        CMP      R1,#+0
        BNE.N    ??dir_next_3
// 1151 		dj->sect++;					/* Next sector */
        LDR      R0,[R4, #+16]
        ADDS     R0,R0,#+1
        STR      R0,[R4, #+16]
// 1152 
// 1153 		if (dj->clust == 0) {	/* Static table */
        LDR      R0,[R4, #+12]
        CMP      R0,#+0
        BNE.N    ??dir_next_4
// 1154 			if (i >= dj->fs->n_rootdir)	/* Report EOT when end of table */
        LDR      R0,[R4, #+0]
        LDRH     R0,[R0, #+8]
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,R0
        BCC.N    ??dir_next_3
// 1155 				return FR_NO_FILE;
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1156 		}
// 1157 		else {					/* Dynamic table */
// 1158 			if (((i / (SS(dj->fs) / SZ_DIR)) & (dj->fs->csize - 1)) == 0) {	/* Cluster changed? */
??dir_next_4:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+2]
        SUBS     R0,R0,#+1
        TST      R0,R6, LSR #+4
        BNE.N    ??dir_next_3
// 1159 				clst = get_fat(dj->fs, dj->clust);				/* Get next cluster */
        LDR      R1,[R4, #+12]
        LDR      R0,[R4, #+0]
        BL       get_fat
        MOVS     R7,R0
// 1160 				if (clst <= 1) return FR_INT_ERR;
        CMP      R7,#+2
        BCS.N    ??dir_next_5
        MOVS     R0,#+2
        B.N      ??dir_next_2
// 1161 				if (clst == 0xFFFFFFFF) return FR_DISK_ERR;
??dir_next_5:
        CMN      R7,#+1
        BNE.N    ??dir_next_6
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1162 				if (clst >= dj->fs->n_fatent) {					/* When it reached end of dynamic table */
??dir_next_6:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+28]
        CMP      R7,R0
        BCC.N    ??dir_next_7
// 1163 #if !_FS_READONLY
// 1164 					BYTE c;
// 1165 					if (!stretch) return FR_NO_FILE;			/* When do not stretch, report EOT */
        CMP      R5,#+0
        BNE.N    ??dir_next_8
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1166 					clst = create_chain(dj->fs, dj->clust);		/* Stretch cluster chain */
??dir_next_8:
        LDR      R1,[R4, #+12]
        LDR      R0,[R4, #+0]
        BL       create_chain
        MOVS     R7,R0
// 1167 					if (clst == 0) return FR_DENIED;			/* No free cluster */
        CMP      R7,#+0
        BNE.N    ??dir_next_9
        MOVS     R0,#+7
        B.N      ??dir_next_2
// 1168 					if (clst == 1) return FR_INT_ERR;
??dir_next_9:
        CMP      R7,#+1
        BNE.N    ??dir_next_10
        MOVS     R0,#+2
        B.N      ??dir_next_2
// 1169 					if (clst == 0xFFFFFFFF) return FR_DISK_ERR;
??dir_next_10:
        CMN      R7,#+1
        BNE.N    ??dir_next_11
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1170 					/* Clean-up stretched table */
// 1171 					if (sync_window(dj->fs)) return FR_DISK_ERR;	/* Flush active window */
??dir_next_11:
        LDR      R0,[R4, #+0]
        BL       sync_window
        CMP      R0,#+0
        BEQ.N    ??dir_next_12
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1172 					mem_set(dj->fs->win, 0, SS(dj->fs));			/* Clear window buffer */
??dir_next_12:
        MOV      R2,#+512
        MOVS     R1,#+0
        LDR      R0,[R4, #+0]
        ADDS     R0,R0,#+56
        BL       mem_set
// 1173 					dj->fs->winsect = clust2sect(dj->fs, clst);	/* Cluster start sector */
        MOVS     R1,R7
        LDR      R0,[R4, #+0]
        BL       clust2sect
        LDR      R1,[R4, #+0]
        STR      R0,[R1, #+52]
// 1174 					for (c = 0; c < dj->fs->csize; c++) {		/* Fill the new cluster with 0 */
        MOVS     R5,#+0
        B.N      ??dir_next_13
// 1175 						dj->fs->wflag = 1;
// 1176 						if (sync_window(dj->fs)) return FR_DISK_ERR;
// 1177 						dj->fs->winsect++;
??dir_next_14:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+52]
        ADDS     R0,R0,#+1
        LDR      R1,[R4, #+0]
        STR      R0,[R1, #+52]
        ADDS     R5,R5,#+1
??dir_next_13:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,R0
        BCS.N    ??dir_next_15
        MOVS     R0,#+1
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+4]
        LDR      R0,[R4, #+0]
        BL       sync_window
        CMP      R0,#+0
        BEQ.N    ??dir_next_14
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1178 					}
// 1179 					dj->fs->winsect -= c;						/* Rewind window address */
??dir_next_15:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+52]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        SUBS     R0,R0,R5
        LDR      R1,[R4, #+0]
        STR      R0,[R1, #+52]
// 1180 #else
// 1181 					return FR_NO_FILE;			/* Report EOT */
// 1182 #endif
// 1183 				}
// 1184 				dj->clust = clst;				/* Initialize data for new cluster */
??dir_next_7:
        STR      R7,[R4, #+12]
// 1185 				dj->sect = clust2sect(dj->fs, clst);
        MOVS     R1,R7
        LDR      R0,[R4, #+0]
        BL       clust2sect
        STR      R0,[R4, #+16]
// 1186 			}
// 1187 		}
// 1188 	}
// 1189 
// 1190 	dj->index = i;
??dir_next_3:
        STRH     R6,[R4, #+6]
// 1191 	dj->dir = dj->fs->win + (i % (SS(dj->fs) / SZ_DIR)) * SZ_DIR;
        LDR      R0,[R4, #+0]
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R1,#+16
        UDIV     R2,R6,R1
        MLS      R2,R2,R1,R6
        ADDS     R0,R0,R2, LSL #+5
        ADDS     R0,R0,#+56
        STR      R0,[R4, #+20]
// 1192 
// 1193 	return FR_OK;
        MOVS     R0,#+0
??dir_next_2:
        POP      {R1,R4-R7,PC}    ;; return
// 1194 }
// 1195 
// 1196 
// 1197 
// 1198 
// 1199 /*-----------------------------------------------------------------------*/
// 1200 /* Directory handling - Reserve directory entry                          */
// 1201 /*-----------------------------------------------------------------------*/
// 1202 
// 1203 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1204 static
// 1205 FRESULT dir_alloc (
// 1206 	DIR* dj,	/* Pointer to the directory object */
// 1207 	UINT nent	/* Number of contiguous entries to allocate (1-21) */
// 1208 )
// 1209 {
dir_alloc:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1210 	FRESULT res;
// 1211 	UINT n;
// 1212 
// 1213 
// 1214 	res = dir_sdi(dj, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
// 1215 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_alloc_0
// 1216 		n = 0;
        MOVS     R6,#+0
// 1217 		do {
// 1218 			res = move_window(dj->fs, dj->sect);
??dir_alloc_1:
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
// 1219 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_alloc_0
// 1220 			if (dj->dir[0] == DDE || dj->dir[0] == 0) {	/* Is it a blank entry? */
??dir_alloc_2:
        LDR      R1,[R4, #+20]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+229
        BEQ.N    ??dir_alloc_3
        LDR      R1,[R4, #+20]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        BNE.N    ??dir_alloc_4
// 1221 				if (++n == nent) break;	/* A block of contiguous entry is found */
??dir_alloc_3:
        ADDS     R6,R6,#+1
        CMP      R6,R5
        BNE.N    ??dir_alloc_5
        B.N      ??dir_alloc_0
// 1222 			} else {
// 1223 				n = 0;					/* Not a blank entry. Restart to search */
??dir_alloc_4:
        MOVS     R6,#+0
// 1224 			}
// 1225 			res = dir_next(dj, 1);		/* Next entry with table stretch enabled */
??dir_alloc_5:
        MOVS     R1,#+1
        MOVS     R0,R4
        BL       dir_next
// 1226 		} while (res == FR_OK);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??dir_alloc_1
// 1227 	}
// 1228 	return res;
??dir_alloc_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4-R6,PC}       ;; return
// 1229 }
// 1230 #endif
// 1231 
// 1232 
// 1233 
// 1234 /*-----------------------------------------------------------------------*/
// 1235 /* Directory handling - Load/Store start cluster number                  */
// 1236 /*-----------------------------------------------------------------------*/
// 1237 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1238 static
// 1239 DWORD ld_clust (
// 1240 	FATFS *fs,	/* Pointer to the fs object */
// 1241 	BYTE *dir	/* Pointer to the directory entry */
// 1242 )
// 1243 {
// 1244 	DWORD cl;
// 1245 
// 1246 	cl = LD_WORD(dir+DIR_FstClusLO);
ld_clust:
        LDRB     R2,[R1, #+27]
        LDRB     R3,[R1, #+26]
        ORRS     R2,R3,R2, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
// 1247 	if (fs->fs_type == FS_FAT32)
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??ld_clust_0
// 1248 		cl |= (DWORD)LD_WORD(dir+DIR_FstClusHI) << 16;
        LDRB     R0,[R1, #+21]
        LDRB     R1,[R1, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ORRS     R2,R2,R0, LSL #+16
// 1249 
// 1250 	return cl;
??ld_clust_0:
        MOVS     R0,R2
        BX       LR               ;; return
// 1251 }
// 1252 
// 1253 
// 1254 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1255 static
// 1256 void st_clust (
// 1257 	BYTE *dir,	/* Pointer to the directory entry */
// 1258 	DWORD cl	/* Value to be set */
// 1259 )
// 1260 {
// 1261 	ST_WORD(dir+DIR_FstClusLO, cl);
st_clust:
        STRB     R1,[R0, #+26]
        MOVS     R2,R1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSRS     R2,R2,#+8
        STRB     R2,[R0, #+27]
// 1262 	ST_WORD(dir+DIR_FstClusHI, cl >> 16);
        LSRS     R2,R1,#+16
        STRB     R2,[R0, #+20]
        LSRS     R1,R1,#+16
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+21]
// 1263 }
        BX       LR               ;; return

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 "\"*:<>?|\177"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "+,;=[]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "\353\376\220MSDOS5.0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "NO NAME    FAT32   "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "NO NAME    FAT     "
// 1264 #endif
// 1265 
// 1266 
// 1267 
// 1268 /*-----------------------------------------------------------------------*/
// 1269 /* LFN handling - Test/Pick/Fit an LFN segment from/to directory entry   */
// 1270 /*-----------------------------------------------------------------------*/
// 1271 #if _USE_LFN
// 1272 static

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// 1273 const BYTE LfnOfs[] = {1,3,5,7,9,14,16,18,20,22,24,28,30};	/* Offset of LFN chars in the directory entry */
LfnOfs:
        DATA
        DC8 1, 3, 5, 7, 9, 14, 16, 18, 20, 22, 24, 28, 30, 0, 0, 0
// 1274 
// 1275 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1276 static
// 1277 int cmp_lfn (			/* 1:Matched, 0:Not matched */
// 1278 	WCHAR *lfnbuf,		/* Pointer to the LFN to be compared */
// 1279 	BYTE *dir			/* Pointer to the directory entry containing a part of LFN */
// 1280 )
// 1281 {
cmp_lfn:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1282 	UINT i, s;
// 1283 	WCHAR wc, uc;
// 1284 
// 1285 
// 1286 	i = ((dir[LDIR_Ord] & ~LLE) - 1) * 13;	/* Get offset in the LFN buffer */
        LDRB     R0,[R5, #+0]
        BICS     R0,R0,#0x40
        SUBS     R0,R0,#+1
        MOVS     R1,#+13
        MUL      R6,R1,R0
// 1287 	s = 0; wc = 1;
        MOVS     R7,#+0
        MOVS     R8,#+1
// 1288 	do {
// 1289 		uc = LD_WORD(dir+LfnOfs[s]);	/* Pick an LFN character from the entry */
??cmp_lfn_0:
        LDR.W    R0,??DataTable9
        LDRB     R0,[R7, R0]
        ADDS     R0,R0,R5
        LDRB     R0,[R0, #+1]
        LDR.W    R1,??DataTable9
        LDRB     R1,[R7, R1]
        LDRB     R1,[R1, R5]
        ORRS     R0,R1,R0, LSL #+8
// 1290 		if (wc) {	/* Last char has not been processed */
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+0
        BEQ.N    ??cmp_lfn_1
// 1291 			wc = ff_wtoupper(uc);		/* Convert it to upper case */
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_wtoupper
        MOV      R8,R0
// 1292 			if (i >= _MAX_LFN || wc != ff_wtoupper(lfnbuf[i++]))	/* Compare it */
        CMP      R6,#+64
        BCS.N    ??cmp_lfn_2
        LDRH     R0,[R4, R6, LSL #+1]
        BL       ff_wtoupper
        ADDS     R6,R6,#+1
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R8,R0
        BEQ.N    ??cmp_lfn_3
// 1293 				return 0;				/* Not matched */
??cmp_lfn_2:
        MOVS     R0,#+0
        B.N      ??cmp_lfn_4
// 1294 		} else {
// 1295 			if (uc != 0xFFFF) return 0;	/* Check filler */
??cmp_lfn_1:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVW     R1,#+65535
        CMP      R0,R1
        BEQ.N    ??cmp_lfn_3
        MOVS     R0,#+0
        B.N      ??cmp_lfn_4
// 1296 		}
// 1297 	} while (++s < 13);				/* Repeat until all chars in the entry are checked */
??cmp_lfn_3:
        ADDS     R7,R7,#+1
        CMP      R7,#+13
        BCC.N    ??cmp_lfn_0
// 1298 
// 1299 	if ((dir[LDIR_Ord] & LLE) && wc && lfnbuf[i])	/* Last segment matched but different length */
        LDRB     R0,[R5, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??cmp_lfn_5
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+0
        BEQ.N    ??cmp_lfn_5
        LDRH     R0,[R4, R6, LSL #+1]
        CMP      R0,#+0
        BEQ.N    ??cmp_lfn_5
// 1300 		return 0;
        MOVS     R0,#+0
        B.N      ??cmp_lfn_4
// 1301 
// 1302 	return 1;						/* The part of LFN matched */
??cmp_lfn_5:
        MOVS     R0,#+1
??cmp_lfn_4:
        POP      {R4-R8,PC}       ;; return
// 1303 }
// 1304 
// 1305 
// 1306 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1307 static
// 1308 int pick_lfn (			/* 1:Succeeded, 0:Buffer overflow */
// 1309 	WCHAR *lfnbuf,		/* Pointer to the Unicode-LFN buffer */
// 1310 	BYTE *dir			/* Pointer to the directory entry */
// 1311 )
// 1312 {
pick_lfn:
        PUSH     {R4-R6}
// 1313 	UINT i, s;
// 1314 	WCHAR wc, uc;
// 1315 
// 1316 
// 1317 	i = ((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the LFN buffer */
        LDRB     R2,[R1, #+0]
        ANDS     R2,R2,#0x3F
        SUBS     R2,R2,#+1
        MOVS     R3,#+13
        MULS     R2,R3,R2
// 1318 
// 1319 	s = 0; wc = 1;
        MOVS     R3,#+0
        MOVS     R4,#+1
// 1320 	do {
// 1321 		uc = LD_WORD(dir+LfnOfs[s]);		/* Pick an LFN character from the entry */
??pick_lfn_0:
        LDR.W    R5,??DataTable9
        LDRB     R5,[R3, R5]
        ADDS     R5,R5,R1
        LDRB     R5,[R5, #+1]
        LDR.W    R6,??DataTable9
        LDRB     R6,[R3, R6]
        LDRB     R6,[R6, R1]
        ORRS     R5,R6,R5, LSL #+8
// 1322 		if (wc) {	/* Last char has not been processed */
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+0
        BEQ.N    ??pick_lfn_1
// 1323 			if (i >= _MAX_LFN) return 0;	/* Buffer overflow? */
        CMP      R2,#+64
        BCC.N    ??pick_lfn_2
        MOVS     R0,#+0
        B.N      ??pick_lfn_3
// 1324 			lfnbuf[i++] = wc = uc;			/* Store it */
??pick_lfn_2:
        MOVS     R4,R5
        STRH     R4,[R0, R2, LSL #+1]
        ADDS     R2,R2,#+1
// 1325 		} else {
// 1326 			if (uc != 0xFFFF) return 0;		/* Check filler */
// 1327 		}
// 1328 	} while (++s < 13);						/* Read all character in the entry */
??pick_lfn_4:
        ADDS     R3,R3,#+1
        CMP      R3,#+13
        BCC.N    ??pick_lfn_0
// 1329 
// 1330 	if (dir[LDIR_Ord] & LLE) {				/* Put terminator if it is the last LFN part */
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+25
        BPL.N    ??pick_lfn_5
// 1331 		if (i >= _MAX_LFN) return 0;		/* Buffer overflow? */
        CMP      R2,#+64
        BCC.N    ??pick_lfn_6
        MOVS     R0,#+0
        B.N      ??pick_lfn_3
??pick_lfn_1:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVW     R6,#+65535
        CMP      R5,R6
        BEQ.N    ??pick_lfn_4
        MOVS     R0,#+0
        B.N      ??pick_lfn_3
// 1332 		lfnbuf[i] = 0;
??pick_lfn_6:
        MOVS     R1,#+0
        STRH     R1,[R0, R2, LSL #+1]
// 1333 	}
// 1334 
// 1335 	return 1;
??pick_lfn_5:
        MOVS     R0,#+1
??pick_lfn_3:
        POP      {R4-R6}
        BX       LR               ;; return
// 1336 }
// 1337 
// 1338 
// 1339 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1340 static
// 1341 void fit_lfn (
// 1342 	const WCHAR *lfnbuf,	/* Pointer to the LFN buffer */
// 1343 	BYTE *dir,				/* Pointer to the directory entry */
// 1344 	BYTE ord,				/* LFN order (1-20) */
// 1345 	BYTE sum				/* SFN sum */
// 1346 )
// 1347 {
fit_lfn:
        PUSH     {R4-R7}
// 1348 	UINT i, s;
// 1349 	WCHAR wc;
// 1350 
// 1351 
// 1352 	dir[LDIR_Chksum] = sum;			/* Set check sum */
        STRB     R3,[R1, #+13]
// 1353 	dir[LDIR_Attr] = AM_LFN;		/* Set attribute. LFN entry */
        MOVS     R3,#+15
        STRB     R3,[R1, #+11]
// 1354 	dir[LDIR_Type] = 0;
        MOVS     R3,#+0
        STRB     R3,[R1, #+12]
// 1355 	ST_WORD(dir+LDIR_FstClusLO, 0);
        MOVS     R3,#+0
        STRB     R3,[R1, #+26]
        MOVS     R3,#+0
        STRB     R3,[R1, #+27]
// 1356 
// 1357 	i = (ord - 1) * 13;				/* Get offset in the LFN buffer */
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        SUBS     R3,R2,#+1
        MOVS     R4,#+13
        MULS     R3,R4,R3
// 1358 	s = wc = 0;
        MOVS     R5,#+0
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R4,R5
// 1359 	do {
// 1360 		if (wc != 0xFFFF) wc = lfnbuf[i++];	/* Get an effective char */
??fit_lfn_0:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVW     R6,#+65535
        CMP      R5,R6
        BEQ.N    ??fit_lfn_1
        LDRH     R5,[R0, R3, LSL #+1]
        ADDS     R3,R3,#+1
// 1361 		ST_WORD(dir+LfnOfs[s], wc);	/* Put it */
??fit_lfn_1:
        LDR.W    R6,??DataTable9
        LDRB     R6,[R4, R6]
        STRB     R5,[R6, R1]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LSRS     R6,R5,#+8
        LDR.W    R7,??DataTable9
        LDRB     R7,[R4, R7]
        ADDS     R7,R7,R1
        STRB     R6,[R7, #+1]
// 1362 		if (!wc) wc = 0xFFFF;		/* Padding chars following last char */
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BNE.N    ??fit_lfn_2
        MOVW     R5,#+65535
// 1363 	} while (++s < 13);
??fit_lfn_2:
        ADDS     R4,R4,#+1
        CMP      R4,#+13
        BCC.N    ??fit_lfn_0
// 1364 	if (wc == 0xFFFF || !lfnbuf[i]) ord |= LLE;	/* Bottom LFN part is the start of LFN sequence */
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVW     R4,#+65535
        CMP      R5,R4
        BEQ.N    ??fit_lfn_3
        LDRH     R0,[R0, R3, LSL #+1]
        CMP      R0,#+0
        BNE.N    ??fit_lfn_4
??fit_lfn_3:
        ORRS     R2,R2,#0x40
// 1365 	dir[LDIR_Ord] = ord;			/* Set the LFN order */
??fit_lfn_4:
        STRB     R2,[R1, #+0]
// 1366 }
        POP      {R4-R7}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     Files
// 1367 
// 1368 #endif
// 1369 #endif
// 1370 
// 1371 
// 1372 
// 1373 /*-----------------------------------------------------------------------*/
// 1374 /* Create numbered name                                                  */
// 1375 /*-----------------------------------------------------------------------*/
// 1376 #if _USE_LFN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1377 void gen_numname (
// 1378 	BYTE *dst,			/* Pointer to generated SFN */
// 1379 	const BYTE *src,	/* Pointer to source SFN to be modified */
// 1380 	const WCHAR *lfn,	/* Pointer to LFN */
// 1381 	WORD seq			/* Sequence number */
// 1382 )
// 1383 {
gen_numname:
        PUSH     {R2-R6,LR}
        MOVS     R4,R0
        MOVS     R6,R2
        MOVS     R5,R3
// 1384 	BYTE ns[8], c;
// 1385 	UINT i, j;
// 1386 
// 1387 
// 1388 	mem_cpy(dst, src, 11);
        MOVS     R2,#+11
        MOVS     R0,R4
        BL       mem_cpy
// 1389 
// 1390 	if (seq > 5) {	/* On many collisions, generate a hash number instead of sequential number */
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+6
        BLT.N    ??gen_numname_0
// 1391 		do seq = (seq >> 1) + (seq << 15) + (WORD)*lfn++; while (*lfn);
??gen_numname_1:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LSLS     R0,R5,#+15
        ADDS     R0,R0,R5, LSR #+1
        LDRH     R1,[R6, #+0]
        ADDS     R5,R1,R0
        ADDS     R6,R6,#+2
        LDRH     R0,[R6, #+0]
        CMP      R0,#+0
        BNE.N    ??gen_numname_1
// 1392 	}
// 1393 
// 1394 	/* itoa (hexdecimal) */
// 1395 	i = 7;
??gen_numname_0:
        MOVS     R0,#+7
// 1396 	do {
// 1397 		c = (seq % 16) + '0';
??gen_numname_2:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R1,#+16
        SDIV     R2,R5,R1
        MLS      R2,R2,R1,R5
        ADDS     R1,R2,#+48
// 1398 		if (c > '9') c += 7;
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+58
        BLT.N    ??gen_numname_3
        ADDS     R1,R1,#+7
// 1399 		ns[i--] = c;
??gen_numname_3:
        ADD      R2,SP,#+0
        STRB     R1,[R0, R2]
        SUBS     R0,R0,#+1
// 1400 		seq /= 16;
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R1,#+16
        SDIV     R5,R5,R1
// 1401 	} while (seq);
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BNE.N    ??gen_numname_2
// 1402 	ns[i] = '~';
        MOVS     R1,#+126
        ADD      R2,SP,#+0
        STRB     R1,[R0, R2]
// 1403 
// 1404 	/* Append the number */
// 1405 	for (j = 0; j < i && dst[j] != ' '; j++) {
        MOVS     R1,#+0
        B.N      ??gen_numname_4
// 1406 		if (IsDBCS1(dst[j])) {
// 1407 			if (j == i - 1) break;
// 1408 			j++;
??gen_numname_5:
        ADDS     R1,R1,#+1
??gen_numname_6:
        ADDS     R1,R1,#+1
??gen_numname_4:
        CMP      R1,R0
        BCS.N    ??gen_numname_7
        LDRB     R2,[R1, R4]
        CMP      R2,#+32
        BEQ.N    ??gen_numname_7
        LDRB     R2,[R1, R4]
        CMP      R2,#+129
        BLT.N    ??gen_numname_6
        LDRB     R2,[R1, R4]
        CMP      R2,#+255
        BEQ.N    ??gen_numname_6
        SUBS     R2,R0,#+1
        CMP      R1,R2
        BNE.N    ??gen_numname_5
// 1409 		}
// 1410 	}
// 1411 	do {
// 1412 		dst[j++] = (i < 8) ? ns[i++] : ' ';
??gen_numname_7:
        MOVS     R2,R1
        ADDS     R1,R2,#+1
        CMP      R0,#+8
        BCS.N    ??gen_numname_8
        ADD      R3,SP,#+0
        LDRB     R3,[R0, R3]
        ADDS     R0,R0,#+1
        B.N      ??gen_numname_9
??gen_numname_8:
        MOVS     R3,#+32
??gen_numname_9:
        STRB     R3,[R2, R4]
// 1413 	} while (j < 8);
        CMP      R1,#+8
        BCC.N    ??gen_numname_7
// 1414 }
        POP      {R0,R1,R4-R6,PC}  ;; return
// 1415 #endif
// 1416 
// 1417 
// 1418 
// 1419 
// 1420 /*-----------------------------------------------------------------------*/
// 1421 /* Calculate sum of an SFN                                               */
// 1422 /*-----------------------------------------------------------------------*/
// 1423 #if _USE_LFN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1424 static
// 1425 BYTE sum_sfn (
// 1426 	const BYTE *dir		/* Ptr to directory entry */
// 1427 )
// 1428 {
// 1429 	BYTE sum = 0;
sum_sfn:
        MOVS     R1,#+0
// 1430 	UINT n = 11;
        MOVS     R2,#+11
// 1431 
// 1432 	do sum = (sum >> 1) + (sum << 7) + *dir++; while (--n);
??sum_sfn_0:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R3,R1,#+7
        ADDS     R1,R3,R1, LSR #+1
        LDRB     R3,[R0, #+0]
        ADDS     R1,R3,R1
        ADDS     R0,R0,#+1
        SUBS     R2,R2,#+1
        CMP      R2,#+0
        BNE.N    ??sum_sfn_0
// 1433 	return sum;
        MOVS     R0,R1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
// 1434 }
// 1435 #endif
// 1436 
// 1437 
// 1438 
// 1439 
// 1440 /*-----------------------------------------------------------------------*/
// 1441 /* Directory handling - Find an object in the directory                  */
// 1442 /*-----------------------------------------------------------------------*/
// 1443 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1444 static
// 1445 FRESULT dir_find (
// 1446 	DIR *dj			/* Pointer to the directory object linked to the file name */
// 1447 )
// 1448 {
dir_find:
        PUSH     {R4-R8,LR}
        MOVS     R5,R0
// 1449 	FRESULT res;
// 1450 	BYTE c, *dir;
// 1451 #if _USE_LFN
// 1452 	BYTE a, ord, sum;
// 1453 #endif
// 1454 
// 1455 	res = dir_sdi(dj, 0);			/* Rewind directory object */
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_sdi
        MOVS     R4,R0
// 1456 	if (res != FR_OK) return res;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??dir_find_0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??dir_find_1
// 1457 
// 1458 #if _USE_LFN
// 1459 	ord = sum = 0xFF;
??dir_find_0:
        MOV      R8,#+255
        MOV      R7,R8
// 1460 #endif
// 1461 	do {
// 1462 		res = move_window(dj->fs, dj->sect);
??dir_find_2:
        LDR      R1,[R5, #+16]
        LDR      R0,[R5, #+0]
        BL       move_window
        MOVS     R4,R0
// 1463 		if (res != FR_OK) break;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dir_find_3
// 1464 		dir = dj->dir;					/* Ptr to the directory entry of current index */
??dir_find_4:
        LDR      R6,[R5, #+20]
// 1465 		c = dir[DIR_Name];
        LDRB     R0,[R6, #+0]
// 1466 		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_find_5
        MOVS     R4,#+4
        B.N      ??dir_find_3
// 1467 #if _USE_LFN	/* LFN configuration */
// 1468 		a = dir[DIR_Attr] & AM_MASK;
??dir_find_5:
        LDRB     R1,[R6, #+11]
        ANDS     R1,R1,#0x3F
// 1469 		if (c == DDE || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+229
        BEQ.N    ??dir_find_6
        LSLS     R2,R1,#+28
        BPL.N    ??dir_find_7
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+15
        BEQ.N    ??dir_find_7
// 1470 			ord = 0xFF;
??dir_find_6:
        MOVS     R7,#+255
// 1471 		} else {
// 1472 			if (a == AM_LFN) {			/* An LFN entry is found */
// 1473 				if (dj->lfn) {
// 1474 					if (c & LLE) {		/* Is it start of LFN sequence? */
// 1475 						sum = dir[LDIR_Chksum];
// 1476 						c &= ~LLE; ord = c;	/* LFN start order */
// 1477 						dj->lfn_idx = dj->index;
// 1478 					}
// 1479 					/* Check validity of the LFN entry and compare it with given name */
// 1480 					ord = (c == ord && sum == dir[LDIR_Chksum] && cmp_lfn(dj->lfn, dir)) ? ord - 1 : 0xFF;
// 1481 				}
// 1482 			} else {					/* An SFN entry is found */
// 1483 				if (!ord && sum == sum_sfn(dir)) break;	/* LFN matched? */
// 1484 				ord = 0xFF; dj->lfn_idx = 0xFFFF;	/* Reset LFN sequence */
// 1485 				if (!(dj->fn[NS] & NS_LOSS) && !mem_cmp(dir, dj->fn, 11)) break;	/* SFN matched? */
// 1486 			}
// 1487 		}
// 1488 #else		/* Non LFN configuration */
// 1489 		if (!(dir[DIR_Attr] & AM_VOL) && !mem_cmp(dir, dj->fn, 11)) /* Is it a valid entry? */
// 1490 			break;
// 1491 #endif
// 1492 		res = dir_next(dj, 0);		/* Next entry */
??dir_find_8:
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_next
        MOVS     R4,R0
// 1493 	} while (res == FR_OK);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??dir_find_2
// 1494 
// 1495 	return res;
??dir_find_3:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??dir_find_1:
        POP      {R4-R8,PC}       ;; return
??dir_find_7:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+15
        BNE.N    ??dir_find_9
        LDR      R1,[R5, #+28]
        CMP      R1,#+0
        BEQ.N    ??dir_find_8
        LSLS     R1,R0,#+25
        BPL.N    ??dir_find_10
        LDRB     R8,[R6, #+13]
        ANDS     R0,R0,#0xBF
        MOVS     R7,R0
        LDRH     R1,[R5, #+6]
        STRH     R1,[R5, #+32]
??dir_find_10:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R0,R7
        BNE.N    ??dir_find_11
        LDRB     R0,[R6, #+13]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,R0
        BNE.N    ??dir_find_11
        MOVS     R1,R6
        LDR      R0,[R5, #+28]
        BL       cmp_lfn
        CMP      R0,#+0
        BEQ.N    ??dir_find_11
        SUBS     R7,R7,#+1
        B.N      ??dir_find_8
??dir_find_11:
        MOVS     R7,#+255
        B.N      ??dir_find_8
??dir_find_9:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??dir_find_12
        MOVS     R0,R6
        BL       sum_sfn
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,R0
        BEQ.N    ??dir_find_3
??dir_find_12:
        MOVS     R7,#+255
        MOVW     R0,#+65535
        STRH     R0,[R5, #+32]
        LDR      R0,[R5, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+31
        BMI.N    ??dir_find_8
        MOVS     R2,#+11
        LDR      R1,[R5, #+24]
        MOVS     R0,R6
        BL       mem_cmp
        CMP      R0,#+0
        BNE.N    ??dir_find_8
        B.N      ??dir_find_3
// 1496 }
// 1497 
// 1498 
// 1499 
// 1500 
// 1501 /*-----------------------------------------------------------------------*/
// 1502 /* Read an object from the directory                                     */
// 1503 /*-----------------------------------------------------------------------*/
// 1504 #if _FS_MINIMIZE <= 1 || _USE_LABEL || _FS_RPATH >= 2

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1505 static
// 1506 FRESULT dir_read (
// 1507 	DIR *dj,		/* Pointer to the directory object */
// 1508 	int vol			/* Filtered by 0:file/dir or 1:volume label */
// 1509 )
// 1510 {
dir_read:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1511 	FRESULT res;
// 1512 	BYTE a, c, *dir;
// 1513 #if _USE_LFN
// 1514 	BYTE ord = 0xFF, sum = 0xFF;
        MOVS     R6,#+255
        MOVS     R7,#+255
// 1515 #endif
// 1516 
// 1517 	res = FR_NO_FILE;
        MOVS     R8,#+4
// 1518 	while (dj->sect) {
??dir_read_0:
        LDR      R0,[R4, #+16]
        CMP      R0,#+0
        BEQ.N    ??dir_read_1
// 1519 		res = move_window(dj->fs, dj->sect);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
        MOV      R8,R0
// 1520 		if (res != FR_OK) break;
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??dir_read_1
// 1521 		dir = dj->dir;					/* Ptr to the directory entry of current index */
??dir_read_2:
        LDR      R0,[R4, #+20]
// 1522 		c = dir[DIR_Name];
        LDRB     R2,[R0, #+0]
// 1523 		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??dir_read_3
        MOVS     R8,#+4
        B.N      ??dir_read_1
// 1524 		a = dir[DIR_Attr] & AM_MASK;
??dir_read_3:
        LDRB     R1,[R0, #+11]
        ANDS     R1,R1,#0x3F
// 1525 #if _USE_LFN	/* LFN configuration */
// 1526 		if (c == DDE || (!_FS_RPATH && c == '.') || (a == AM_VOL) != vol) {	/* An entry without valid data */
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+229
        BEQ.N    ??dir_read_4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+8
        BNE.N    ??dir_read_5
        MOVS     R3,#+1
        B.N      ??dir_read_6
??dir_read_5:
        MOVS     R3,#+0
??dir_read_6:
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,R5
        BEQ.N    ??dir_read_7
// 1527 			ord = 0xFF;
??dir_read_4:
        MOVS     R6,#+255
// 1528 		} else {
// 1529 			if (a == AM_LFN) {			/* An LFN entry is found */
// 1530 				if (c & LLE) {			/* Is it start of LFN sequence? */
// 1531 					sum = dir[LDIR_Chksum];
// 1532 					c &= ~LLE; ord = c;
// 1533 					dj->lfn_idx = dj->index;
// 1534 				}
// 1535 				/* Check LFN validity and capture it */
// 1536 				ord = (c == ord && sum == dir[LDIR_Chksum] && pick_lfn(dj->lfn, dir)) ? ord - 1 : 0xFF;
// 1537 			} else {					/* An SFN entry is found */
// 1538 				if (ord || sum != sum_sfn(dir))	/* Is there a valid LFN? */
// 1539 					dj->lfn_idx = 0xFFFF;		/* It has no LFN. */
// 1540 				break;
// 1541 			}
// 1542 		}
// 1543 #else		/* Non LFN configuration */
// 1544 		if (c != DDE && (_FS_RPATH || c != '.') && a != AM_LFN && (a == AM_VOL) == vol)	/* Is it a valid entry? */
// 1545 			break;
// 1546 #endif
// 1547 		res = dir_next(dj, 0);				/* Next entry */
??dir_read_8:
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
        MOV      R8,R0
// 1548 		if (res != FR_OK) break;
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??dir_read_0
// 1549 	}
// 1550 
// 1551 	if (res != FR_OK) dj->sect = 0;
??dir_read_1:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??dir_read_9
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
// 1552 
// 1553 	return res;
??dir_read_9:
        MOV      R0,R8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4-R8,PC}       ;; return
??dir_read_7:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+15
        BNE.N    ??dir_read_10
        LSLS     R1,R2,#+25
        BPL.N    ??dir_read_11
        LDRB     R7,[R0, #+13]
        ANDS     R2,R2,#0xBF
        MOVS     R6,R2
        LDRH     R1,[R4, #+6]
        STRH     R1,[R4, #+32]
??dir_read_11:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R2,R6
        BNE.N    ??dir_read_12
        LDRB     R1,[R0, #+13]
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,R1
        BNE.N    ??dir_read_12
        MOVS     R1,R0
        LDR      R0,[R4, #+28]
        BL       pick_lfn
        CMP      R0,#+0
        BEQ.N    ??dir_read_12
        SUBS     R6,R6,#+1
        B.N      ??dir_read_8
??dir_read_12:
        MOVS     R6,#+255
        B.N      ??dir_read_8
??dir_read_10:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??dir_read_13
        BL       sum_sfn
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,R0
        BEQ.N    ??dir_read_14
??dir_read_13:
        MOVW     R0,#+65535
        STRH     R0,[R4, #+32]
??dir_read_14:
        B.N      ??dir_read_1
// 1554 }
// 1555 #endif	/* _FS_MINIMIZE <= 1 || _USE_LABEL || _FS_RPATH >= 2 */
// 1556 
// 1557 
// 1558 
// 1559 /*-----------------------------------------------------------------------*/
// 1560 /* Register an object to the directory                                   */
// 1561 /*-----------------------------------------------------------------------*/
// 1562 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1563 static
// 1564 FRESULT dir_register (	/* FR_OK:Successful, FR_DENIED:No free entry or too many SFN collision, FR_DISK_ERR:Disk error */
// 1565 	DIR *dj				/* Target directory with object name to be created */
// 1566 )
// 1567 {
dir_register:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+16
        MOVS     R4,R0
// 1568 	FRESULT res;
// 1569 #if _USE_LFN	/* LFN configuration */
// 1570 	WORD n, ne;
// 1571 	BYTE sn[12], *fn, sum;
// 1572 	WCHAR *lfn;
// 1573 
// 1574 
// 1575 	fn = dj->fn; lfn = dj->lfn;
        LDR      R6,[R4, #+24]
        LDR      R7,[R4, #+28]
// 1576 	mem_cpy(sn, fn, 12);
        MOVS     R2,#+12
        MOVS     R1,R6
        ADD      R0,SP,#+0
        BL       mem_cpy
// 1577 
// 1578 	if (_FS_RPATH && (sn[NS] & NS_DOT))		/* Cannot create dot entry */
        LDRB     R0,[SP, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??dir_register_0
// 1579 		return FR_INVALID_NAME;
        MOVS     R0,#+6
        B.N      ??dir_register_1
// 1580 
// 1581 	if (sn[NS] & NS_LOSS) {			/* When LFN is out of 8.3 format, generate a numbered name */
??dir_register_0:
        LDRB     R0,[SP, #+11]
        LSLS     R0,R0,#+31
        BPL.N    ??dir_register_2
// 1582 		fn[NS] = 0; dj->lfn = 0;			/* Find only SFN */
        MOVS     R0,#+0
        STRB     R0,[R6, #+11]
        MOVS     R0,#+0
        STR      R0,[R4, #+28]
// 1583 		for (n = 1; n < 100; n++) {
        MOVS     R8,#+1
        B.N      ??dir_register_3
??dir_register_4:
        ADDS     R8,R8,#+1
??dir_register_3:
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+100
        BGE.N    ??dir_register_5
// 1584 			gen_numname(fn, sn, lfn, n);	/* Generate a numbered name */
        MOV      R3,R8
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R7
        ADD      R1,SP,#+0
        MOVS     R0,R6
        BL       gen_numname
// 1585 			res = dir_find(dj);				/* Check if the name collides with existing SFN */
        MOVS     R0,R4
        BL       dir_find
        MOVS     R5,R0
// 1586 			if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??dir_register_4
// 1587 		}
// 1588 		if (n == 100) return FR_DENIED;		/* Abort if too many collisions */
??dir_register_5:
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+100
        BNE.N    ??dir_register_6
        MOVS     R0,#+7
        B.N      ??dir_register_1
// 1589 		if (res != FR_NO_FILE) return res;	/* Abort if the result is other than 'not collided' */
??dir_register_6:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+4
        BEQ.N    ??dir_register_7
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??dir_register_1
// 1590 		fn[NS] = sn[NS]; dj->lfn = lfn;
??dir_register_7:
        LDRB     R0,[SP, #+11]
        STRB     R0,[R6, #+11]
        STR      R7,[R4, #+28]
// 1591 	}
// 1592 
// 1593 	if (sn[NS] & NS_LFN) {			/* When LFN is to be created, allocate entries for an SFN + LFNs. */
??dir_register_2:
        LDRB     R0,[SP, #+11]
        LSLS     R0,R0,#+30
        BPL.N    ??dir_register_8
// 1594 		for (n = 0; lfn[n]; n++) ;
        MOVS     R8,#+0
        B.N      ??dir_register_9
??dir_register_10:
        ADDS     R8,R8,#+1
??dir_register_9:
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        LDRH     R0,[R7, R8, LSL #+1]
        CMP      R0,#+0
        BNE.N    ??dir_register_10
// 1595 		ne = (n + 25) / 13;
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        ADDS     R0,R8,#+25
        MOVS     R1,#+13
        SDIV     R6,R0,R1
        B.N      ??dir_register_11
// 1596 	} else {						/* Otherwise allocate an entry for an SFN  */
// 1597 		ne = 1;
??dir_register_8:
        MOVS     R6,#+1
// 1598 	}
// 1599 	res = dir_alloc(dj, ne);		/* Allocate entries */
??dir_register_11:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R1,R6
        MOVS     R0,R4
        BL       dir_alloc
        MOVS     R5,R0
// 1600 
// 1601 	if (res == FR_OK && --ne) {		/* Set LFN entry if needed */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_12
        SUBS     R6,R6,#+1
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+0
        BEQ.N    ??dir_register_12
// 1602 		res = dir_sdi(dj, (WORD)(dj->index - ne));
        LDRH     R0,[R4, #+6]
        SUBS     R1,R0,R6
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,R4
        BL       dir_sdi
        MOVS     R5,R0
// 1603 		if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_12
// 1604 			sum = sum_sfn(dj->fn);	/* Sum value of the SFN tied to the LFN */
        LDR      R0,[R4, #+24]
        BL       sum_sfn
        MOVS     R7,R0
// 1605 			do {					/* Store LFN entries in bottom first */
// 1606 				res = move_window(dj->fs, dj->sect);
??dir_register_13:
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
        MOVS     R5,R0
// 1607 				if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_12
// 1608 				fit_lfn(dj->lfn, dj->dir, (BYTE)ne, sum);
??dir_register_14:
        MOVS     R3,R7
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+28]
        BL       fit_lfn
// 1609 				dj->fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+4]
// 1610 				res = dir_next(dj, 0);	/* Next entry */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
        MOVS     R5,R0
// 1611 			} while (res == FR_OK && --ne);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_12
        SUBS     R6,R6,#+1
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+0
        BNE.N    ??dir_register_13
// 1612 		}
// 1613 	}
// 1614 #else	/* Non LFN configuration */
// 1615 	res = dir_alloc(dj, 1);		/* Allocate an entry for SFN */
// 1616 #endif
// 1617 
// 1618 	if (res == FR_OK) {				/* Set SFN entry */
??dir_register_12:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_15
// 1619 		res = move_window(dj->fs, dj->sect);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
        MOVS     R5,R0
// 1620 		if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_15
// 1621 			mem_set(dj->dir, 0, SZ_DIR);	/* Clean the entry */
        MOVS     R2,#+32
        MOVS     R1,#+0
        LDR      R0,[R4, #+20]
        BL       mem_set
// 1622 			mem_cpy(dj->dir, dj->fn, 11);	/* Put SFN */
        MOVS     R2,#+11
        LDR      R1,[R4, #+24]
        LDR      R0,[R4, #+20]
        BL       mem_cpy
// 1623 #if _USE_LFN
// 1624 			dj->dir[DIR_NTres] = *(dj->fn+NS) & (NS_BODY | NS_EXT);	/* Put NT flag */
        LDR      R0,[R4, #+24]
        LDRB     R0,[R0, #+11]
        ANDS     R0,R0,#0x18
        LDR      R1,[R4, #+20]
        STRB     R0,[R1, #+12]
// 1625 #endif
// 1626 			dj->fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+4]
// 1627 		}
// 1628 	}
// 1629 
// 1630 	return res;
??dir_register_15:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??dir_register_1:
        ADD      SP,SP,#+16
        POP      {R4-R8,PC}       ;; return
// 1631 }
// 1632 #endif /* !_FS_READONLY */
// 1633 
// 1634 
// 1635 
// 1636 
// 1637 /*-----------------------------------------------------------------------*/
// 1638 /* Remove an object from the directory                                   */
// 1639 /*-----------------------------------------------------------------------*/
// 1640 #if !_FS_READONLY && !_FS_MINIMIZE

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1641 static
// 1642 FRESULT dir_remove (	/* FR_OK: Successful, FR_DISK_ERR: A disk error */
// 1643 	DIR *dj				/* Directory object pointing the entry to be removed */
// 1644 )
// 1645 {
dir_remove:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 1646 	FRESULT res;
// 1647 #if _USE_LFN	/* LFN configuration */
// 1648 	WORD i;
// 1649 
// 1650 	i = dj->index;	/* SFN index */
        LDRH     R5,[R4, #+6]
// 1651 	res = dir_sdi(dj, (WORD)((dj->lfn_idx == 0xFFFF) ? i : dj->lfn_idx));	/* Goto the SFN or top of the LFN entries */
        LDRH     R0,[R4, #+32]
        MOVW     R1,#+65535
        CMP      R0,R1
        BNE.N    ??dir_remove_0
        MOVS     R1,R5
        B.N      ??dir_remove_1
??dir_remove_0:
        LDRH     R1,[R4, #+32]
??dir_remove_1:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,R4
        BL       dir_sdi
// 1652 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_remove_2
// 1653 		do {
// 1654 			res = move_window(dj->fs, dj->sect);
??dir_remove_3:
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
// 1655 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_remove_4
// 1656 			*dj->dir = DDE;			/* Mark the entry "deleted" */
??dir_remove_5:
        MOVS     R1,#+229
        LDR      R2,[R4, #+20]
        STRB     R1,[R2, #+0]
// 1657 			dj->fs->wflag = 1;
        MOVS     R1,#+1
        LDR      R2,[R4, #+0]
        STRB     R1,[R2, #+4]
// 1658 			if (dj->index >= i) break;	/* When reached SFN, all entries of the object has been deleted. */
        LDRH     R1,[R4, #+6]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R1,R5
        BCS.N    ??dir_remove_4
// 1659 			res = dir_next(dj, 0);		/* Next entry */
??dir_remove_6:
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
// 1660 		} while (res == FR_OK);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??dir_remove_3
// 1661 		if (res == FR_NO_FILE) res = FR_INT_ERR;
??dir_remove_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??dir_remove_2
        MOVS     R0,#+2
// 1662 	}
// 1663 
// 1664 #else			/* Non LFN configuration */
// 1665 	res = dir_sdi(dj, dj->index);
// 1666 	if (res == FR_OK) {
// 1667 		res = move_window(dj->fs, dj->sect);
// 1668 		if (res == FR_OK) {
// 1669 			*dj->dir = DDE;			/* Mark the entry "deleted" */
// 1670 			dj->fs->wflag = 1;
// 1671 		}
// 1672 	}
// 1673 #endif
// 1674 
// 1675 	return res;
??dir_remove_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
// 1676 }
// 1677 #endif /* !_FS_READONLY */
// 1678 
// 1679 
// 1680 
// 1681 
// 1682 /*-----------------------------------------------------------------------*/
// 1683 /* Pick a segment and create the object name in directory form           */
// 1684 /*-----------------------------------------------------------------------*/
// 1685 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1686 static
// 1687 FRESULT create_name (
// 1688 	DIR *dj,			/* Pointer to the directory object */
// 1689 	const TCHAR **path	/* Pointer to pointer to the segment in the path string */
// 1690 )
// 1691 {
create_name:
        PUSH     {R3-R11,LR}
        MOVS     R4,R0
        MOV      R9,R1
// 1692 #if _USE_LFN	/* LFN configuration */
// 1693 	BYTE b, cf;
// 1694 	WCHAR w, *lfn;
// 1695 	UINT i, ni, si, di;
// 1696 	const TCHAR *p;
// 1697 
// 1698 	/* Create LFN in Unicode */
// 1699 	for (p = *path; *p == '/' || *p == '\\'; p++) ;	/* Strip duplicated separator */
        LDR      R10,[R9, #+0]
        B.N      ??create_name_0
??create_name_1:
        ADDS     R10,R10,#+1
??create_name_0:
        LDRB     R0,[R10, #+0]
        CMP      R0,#+47
        BEQ.N    ??create_name_1
        LDRB     R0,[R10, #+0]
        CMP      R0,#+92
        BEQ.N    ??create_name_1
// 1700 	lfn = dj->lfn;
        LDR      R0,[R4, #+28]
        STR      R0,[SP, #+0]
// 1701 	si = di = 0;
        MOVS     R5,#+0
        MOVS     R6,R5
        B.N      ??create_name_2
// 1702 	for (;;) {
// 1703 		w = p[si++];					/* Get a character */
// 1704 		if (w < ' ' || w == '/' || w == '\\') break;	/* Break on end of segment */
// 1705 		if (di >= _MAX_LFN)				/* Reject too long name */
// 1706 			return FR_INVALID_NAME;
// 1707 #if !_LFN_UNICODE
// 1708 		w &= 0xFF;
// 1709 		if (IsDBCS1(w)) {				/* Check if it is a DBC 1st byte (always false on SBCS cfg) */
// 1710 			b = (BYTE)p[si++];			/* Get 2nd byte */
// 1711 			if (!IsDBCS2(b))
// 1712 				return FR_INVALID_NAME;	/* Reject invalid sequence */
// 1713 			w = (w << 8) + b;			/* Create a DBC */
// 1714 		}
// 1715 		w = ff_convert(w, 1);			/* Convert ANSI/OEM to Unicode */
// 1716 		if (!w) return FR_INVALID_NAME;	/* Reject invalid code */
// 1717 #endif
// 1718 		if (w < 0x80 && chk_chr("\"*:<>\?|\x7F", w)) /* Reject illegal chars for LFN */
// 1719 			return FR_INVALID_NAME;
// 1720 		lfn[di++] = w;					/* Store the Unicode char */
??create_name_3:
        LDR      R0,[SP, #+0]
        STRH     R7,[R0, R5, LSL #+1]
        ADDS     R5,R5,#+1
??create_name_2:
        LDRB     R7,[R6, R10]
        ADDS     R6,R6,#+1
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BLT.N    ??create_name_4
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+47
        BEQ.N    ??create_name_4
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+92
        BNE.N    ??create_name_5
// 1721 	}
// 1722 	*path = &p[si];						/* Return pointer to the next segment */
??create_name_4:
        ADDS     R0,R6,R10
        STR      R0,[R9, #+0]
// 1723 	cf = (w < ' ') ? NS_LAST : 0;		/* Set last segment flag if end of path */
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BGE.N    ??create_name_6
        MOVS     R9,#+4
        B.N      ??create_name_7
??create_name_5:
        CMP      R5,#+64
        BCC.N    ??create_name_8
        MOVS     R0,#+6
        B.N      ??create_name_9
??create_name_8:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+129
        BLT.N    ??create_name_10
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+255
        BEQ.N    ??create_name_10
        LDRB     R8,[R6, R10]
        ADDS     R6,R6,#+1
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        SUBS     R0,R8,#+64
        CMP      R0,#+63
        BCC.N    ??create_name_11
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+128
        BLT.N    ??create_name_12
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+255
        BNE.N    ??create_name_11
??create_name_12:
        MOVS     R0,#+6
        B.N      ??create_name_9
??create_name_11:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        LSLS     R0,R7,#+8
        UXTAB    R7,R0,R8
??create_name_10:
        MOVS     R1,#+1
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_convert
        MOVS     R7,R0
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BNE.N    ??create_name_13
        MOVS     R0,#+6
        B.N      ??create_name_9
??create_name_13:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+128
        BGE.N    ??create_name_3
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        MOVS     R1,R7
        LDR.W    R0,??DataTable11
        BL       chk_chr
        CMP      R0,#+0
        BEQ.N    ??create_name_3
        MOVS     R0,#+6
        B.N      ??create_name_9
??create_name_6:
        MOVS     R9,#+0
// 1724 #if _FS_RPATH
// 1725 	if ((di == 1 && lfn[di-1] == '.') || /* Is this a dot entry? */
// 1726 		(di == 2 && lfn[di-1] == '.' && lfn[di-2] == '.')) {
??create_name_7:
        CMP      R5,#+1
        BNE.N    ??create_name_14
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R5, LSL #+1
        LDRH     R0,[R0, #-2]
        CMP      R0,#+46
        BEQ.N    ??create_name_15
??create_name_14:
        CMP      R5,#+2
        BNE.N    ??create_name_16
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R5, LSL #+1
        LDRH     R0,[R0, #-2]
        CMP      R0,#+46
        BNE.N    ??create_name_16
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R5, LSL #+1
        LDRH     R0,[R0, #-4]
        CMP      R0,#+46
        BNE.N    ??create_name_16
// 1727 		lfn[di] = 0;
??create_name_15:
        MOVS     R0,#+0
        LDR      R1,[SP, #+0]
        STRH     R0,[R1, R5, LSL #+1]
// 1728 		for (i = 0; i < 11; i++)
        MOVS     R10,#+0
        B.N      ??create_name_17
// 1729 			dj->fn[i] = (i < di) ? '.' : ' ';
??create_name_18:
        MOVS     R0,#+32
??create_name_19:
        LDR      R1,[R4, #+24]
        STRB     R0,[R10, R1]
        ADDS     R10,R10,#+1
??create_name_17:
        CMP      R10,#+11
        BCS.N    ??create_name_20
        CMP      R10,R5
        BCS.N    ??create_name_18
        MOVS     R0,#+46
        B.N      ??create_name_19
// 1730 		dj->fn[i] = cf | NS_DOT;		/* This is a dot entry */
??create_name_20:
        ORRS     R0,R9,#0x20
        LDR      R1,[R4, #+24]
        STRB     R0,[R10, R1]
// 1731 		return FR_OK;
        MOVS     R0,#+0
        B.N      ??create_name_9
// 1732 	}
// 1733 #endif
// 1734 	while (di) {						/* Strip trailing spaces and dots */
// 1735 		w = lfn[di-1];
// 1736 		if (w != ' ' && w != '.') break;
// 1737 		di--;
??create_name_21:
        SUBS     R5,R5,#+1
??create_name_16:
        CMP      R5,#+0
        BEQ.N    ??create_name_22
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R5, LSL #+1
        LDRH     R7,[R0, #-2]
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BEQ.N    ??create_name_21
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+46
        BEQ.N    ??create_name_21
// 1738 	}
// 1739 	if (!di) return FR_INVALID_NAME;	/* Reject nul string */
??create_name_22:
        CMP      R5,#+0
        BNE.N    ??create_name_23
        MOVS     R0,#+6
        B.N      ??create_name_9
// 1740 
// 1741 	lfn[di] = 0;						/* LFN is created */
??create_name_23:
        MOVS     R0,#+0
        LDR      R1,[SP, #+0]
        STRH     R0,[R1, R5, LSL #+1]
// 1742 
// 1743 	/* Create SFN in directory form */
// 1744 	mem_set(dj->fn, ' ', 11);
        MOVS     R2,#+11
        MOVS     R1,#+32
        LDR      R0,[R4, #+24]
        BL       mem_set
// 1745 	for (si = 0; lfn[si] == ' ' || lfn[si] == '.'; si++) ;	/* Strip leading spaces and dots */
        MOVS     R6,#+0
        B.N      ??create_name_24
??create_name_25:
        ADDS     R6,R6,#+1
??create_name_24:
        LDR      R0,[SP, #+0]
        LDRH     R0,[R0, R6, LSL #+1]
        CMP      R0,#+32
        BEQ.N    ??create_name_25
        LDR      R0,[SP, #+0]
        LDRH     R0,[R0, R6, LSL #+1]
        CMP      R0,#+46
        BEQ.N    ??create_name_25
// 1746 	if (si) cf |= NS_LOSS | NS_LFN;
        CMP      R6,#+0
        BEQ.N    ??create_name_26
        ORRS     R9,R9,#0x3
        B.N      ??create_name_26
// 1747 	while (di && lfn[di - 1] != '.') di--;	/* Find extension (di<=si: no extension) */
??create_name_27:
        SUBS     R5,R5,#+1
??create_name_26:
        CMP      R5,#+0
        BEQ.N    ??create_name_28
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R5, LSL #+1
        LDRH     R0,[R0, #-2]
        CMP      R0,#+46
        BNE.N    ??create_name_27
// 1748 
// 1749 	b = i = 0; ni = 8;
??create_name_28:
        MOVS     R10,#+0
        MOV      R8,R10
        MOVS     R11,#+8
        B.N      ??create_name_29
// 1750 	for (;;) {
// 1751 		w = lfn[si++];					/* Get an LFN char */
// 1752 		if (!w) break;					/* Break on end of the LFN */
// 1753 		if (w == ' ' || (w == '.' && si != di)) {	/* Remove spaces and dots */
// 1754 			cf |= NS_LOSS | NS_LFN; continue;
??create_name_30:
        ORRS     R9,R9,#0x3
// 1755 		}
??create_name_29:
        LDR      R0,[SP, #+0]
        LDRH     R7,[R0, R6, LSL #+1]
        ADDS     R6,R6,#+1
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BNE.N    ??create_name_31
// 1756 
// 1757 		if (i >= ni || si == di) {		/* Extension or end of SFN */
// 1758 			if (ni == 11) {				/* Long extension */
// 1759 				cf |= NS_LOSS | NS_LFN; break;
// 1760 			}
// 1761 			if (si != di) cf |= NS_LOSS | NS_LFN;	/* Out of 8.3 format */
// 1762 			if (si > di) break;			/* No extension */
// 1763 			si = di; i = 8; ni = 11;	/* Enter extension section */
// 1764 			b <<= 2; continue;
// 1765 		}
// 1766 
// 1767 		if (w >= 0x80) {				/* Non ASCII char */
// 1768 #ifdef _EXCVT
// 1769 			w = ff_convert(w, 0);		/* Unicode -> OEM code */
// 1770 			if (w) w = ExCvt[w - 0x80];	/* Convert extended char to upper (SBCS) */
// 1771 #else
// 1772 			w = ff_convert(ff_wtoupper(w), 0);	/* Upper converted Unicode -> OEM code */
// 1773 #endif
// 1774 			cf |= NS_LFN;				/* Force create LFN entry */
// 1775 		}
// 1776 
// 1777 		if (_DF1S && w >= 0x100) {		/* Double byte char (always false on SBCS cfg) */
// 1778 			if (i >= ni - 1) {
// 1779 				cf |= NS_LOSS | NS_LFN; i = ni; continue;
// 1780 			}
// 1781 			dj->fn[i++] = (BYTE)(w >> 8);
// 1782 		} else {						/* Single byte char */
// 1783 			if (!w || chk_chr("+,;=[]", w)) {	/* Replace illegal chars for SFN */
// 1784 				w = '_'; cf |= NS_LOSS | NS_LFN;/* Lossy conversion */
// 1785 			} else {
// 1786 				if (IsUpper(w)) {		/* ASCII large capital */
// 1787 					b |= 2;
// 1788 				} else {
// 1789 					if (IsLower(w)) {	/* ASCII small capital */
// 1790 						b |= 1; w -= 0x20;
// 1791 					}
// 1792 				}
// 1793 			}
// 1794 		}
// 1795 		dj->fn[i++] = (BYTE)w;
// 1796 	}
// 1797 
// 1798 	if (dj->fn[0] == DDE) dj->fn[0] = NDDE;	/* If the first char collides with deleted mark, replace it with 0x05 */
??create_name_32:
        LDR      R0,[R4, #+24]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+229
        BNE.N    ??create_name_33
        MOVS     R0,#+5
        LDR      R1,[R4, #+24]
        STRB     R0,[R1, #+0]
// 1799 
// 1800 	if (ni == 8) b <<= 2;
??create_name_33:
        CMP      R11,#+8
        BNE.N    ??create_name_34
        LSLS     R8,R8,#+2
// 1801 	if ((b & 0x0C) == 0x0C || (b & 0x03) == 0x03)	/* Create LFN entry when there are composite capitals */
??create_name_34:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        ANDS     R0,R8,#0xC
        CMP      R0,#+12
        BEQ.N    ??create_name_35
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        ANDS     R0,R8,#0x3
        CMP      R0,#+3
        BNE.N    ??create_name_36
// 1802 		cf |= NS_LFN;
??create_name_35:
        ORRS     R9,R9,#0x2
// 1803 	if (!(cf & NS_LFN)) {						/* When LFN is in 8.3 format without extended char, NT flags are created */
??create_name_36:
        LSLS     R0,R9,#+30
        BMI.N    ??create_name_37
// 1804 		if ((b & 0x03) == 0x01) cf |= NS_EXT;	/* NT flag (Extension has only small capital) */
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        ANDS     R0,R8,#0x3
        CMP      R0,#+1
        BNE.N    ??create_name_38
        ORRS     R9,R9,#0x10
// 1805 		if ((b & 0x0C) == 0x04) cf |= NS_BODY;	/* NT flag (Filename has only small capital) */
??create_name_38:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        ANDS     R0,R8,#0xC
        CMP      R0,#+4
        BNE.N    ??create_name_37
        ORRS     R9,R9,#0x8
// 1806 	}
// 1807 
// 1808 	dj->fn[NS] = cf;	/* SFN is created */
??create_name_37:
        LDR      R0,[R4, #+24]
        STRB     R9,[R0, #+11]
// 1809 
// 1810 	return FR_OK;
        MOVS     R0,#+0
??create_name_9:
        POP      {R1,R4-R11,PC}   ;; return
??create_name_31:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BEQ.N    ??create_name_30
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+46
        BNE.N    ??create_name_39
        CMP      R6,R5
        BNE.N    ??create_name_30
??create_name_39:
        CMP      R10,R11
        BCS.N    ??create_name_40
        CMP      R6,R5
        BNE.N    ??create_name_41
??create_name_40:
        CMP      R11,#+11
        BNE.N    ??create_name_42
        ORRS     R9,R9,#0x3
        B.N      ??create_name_32
??create_name_42:
        CMP      R6,R5
        BEQ.N    ??create_name_43
        ORRS     R9,R9,#0x3
??create_name_43:
        CMP      R5,R6
        BCC.N    ??create_name_32
??create_name_44:
        MOVS     R6,R5
        MOVS     R10,#+8
        MOVS     R11,#+11
        LSLS     R8,R8,#+2
        B.N      ??create_name_29
??create_name_41:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+128
        BLT.N    ??create_name_45
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_wtoupper
        MOVS     R1,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_convert
        MOVS     R7,R0
        ORRS     R9,R9,#0x2
??create_name_45:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+255
        BLE.N    ??create_name_46
        SUBS     R0,R11,#+1
        CMP      R10,R0
        BCC.N    ??create_name_47
        ORRS     R9,R9,#0x3
        MOV      R10,R11
        B.N      ??create_name_29
??create_name_47:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        LSRS     R0,R7,#+8
        LDR      R1,[R4, #+24]
        STRB     R0,[R10, R1]
        ADDS     R10,R10,#+1
        B.N      ??create_name_48
??create_name_46:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BEQ.N    ??create_name_49
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        MOVS     R1,R7
        LDR.W    R0,??DataTable12
        BL       chk_chr
        CMP      R0,#+0
        BEQ.N    ??create_name_50
??create_name_49:
        MOVS     R7,#+95
        ORRS     R9,R9,#0x3
        B.N      ??create_name_48
??create_name_50:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        SUBS     R0,R7,#+65
        CMP      R0,#+26
        BCS.N    ??create_name_51
        ORRS     R8,R8,#0x2
        B.N      ??create_name_48
??create_name_51:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        SUBS     R0,R7,#+97
        CMP      R0,#+26
        BCS.N    ??create_name_48
        ORRS     R8,R8,#0x1
        SUBS     R7,R7,#+32
??create_name_48:
        LDR      R0,[R4, #+24]
        STRB     R7,[R10, R0]
        ADDS     R10,R10,#+1
        B.N      ??create_name_29
// 1811 
// 1812 
// 1813 #else	/* Non-LFN configuration */
// 1814 	BYTE b, c, d, *sfn;
// 1815 	UINT ni, si, i;
// 1816 	const char *p;
// 1817 
// 1818 	/* Create file name in directory form */
// 1819 	for (p = *path; *p == '/' || *p == '\\'; p++) ;	/* Strip duplicated separator */
// 1820 	sfn = dj->fn;
// 1821 	mem_set(sfn, ' ', 11);
// 1822 	si = i = b = 0; ni = 8;
// 1823 #if _FS_RPATH
// 1824 	if (p[si] == '.') { /* Is this a dot entry? */
// 1825 		for (;;) {
// 1826 			c = (BYTE)p[si++];
// 1827 			if (c != '.' || si >= 3) break;
// 1828 			sfn[i++] = c;
// 1829 		}
// 1830 		if (c != '/' && c != '\\' && c > ' ') return FR_INVALID_NAME;
// 1831 		*path = &p[si];									/* Return pointer to the next segment */
// 1832 		sfn[NS] = (c <= ' ') ? NS_LAST | NS_DOT : NS_DOT;	/* Set last segment flag if end of path */
// 1833 		return FR_OK;
// 1834 	}
// 1835 #endif
// 1836 	for (;;) {
// 1837 		c = (BYTE)p[si++];
// 1838 		if (c <= ' ' || c == '/' || c == '\\') break;	/* Break on end of segment */
// 1839 		if (c == '.' || i >= ni) {
// 1840 			if (ni != 8 || c != '.') return FR_INVALID_NAME;
// 1841 			i = 8; ni = 11;
// 1842 			b <<= 2; continue;
// 1843 		}
// 1844 		if (c >= 0x80) {				/* Extended char? */
// 1845 			b |= 3;						/* Eliminate NT flag */
// 1846 #ifdef _EXCVT
// 1847 			c = ExCvt[c - 0x80];		/* To upper extended chars (SBCS cfg) */
// 1848 #else
// 1849 #if !_DF1S
// 1850 			return FR_INVALID_NAME;		/* Reject extended chars (ASCII cfg) */
// 1851 #endif
// 1852 #endif
// 1853 		}
// 1854 		if (IsDBCS1(c)) {				/* Check if it is a DBC 1st byte (always false on SBCS cfg) */
// 1855 			d = (BYTE)p[si++];			/* Get 2nd byte */
// 1856 			if (!IsDBCS2(d) || i >= ni - 1)	/* Reject invalid DBC */
// 1857 				return FR_INVALID_NAME;
// 1858 			sfn[i++] = c;
// 1859 			sfn[i++] = d;
// 1860 		} else {						/* Single byte code */
// 1861 			if (chk_chr("\"*+,:;<=>\?[]|\x7F", c))	/* Reject illegal chrs for SFN */
// 1862 				return FR_INVALID_NAME;
// 1863 			if (IsUpper(c)) {			/* ASCII large capital? */
// 1864 				b |= 2;
// 1865 			} else {
// 1866 				if (IsLower(c)) {		/* ASCII small capital? */
// 1867 					b |= 1; c -= 0x20;
// 1868 				}
// 1869 			}
// 1870 			sfn[i++] = c;
// 1871 		}
// 1872 	}
// 1873 	*path = &p[si];						/* Return pointer to the next segment */
// 1874 	c = (c <= ' ') ? NS_LAST : 0;		/* Set last segment flag if end of path */
// 1875 
// 1876 	if (!i) return FR_INVALID_NAME;		/* Reject nul string */
// 1877 	if (sfn[0] == DDE) sfn[0] = NDDE;	/* When first char collides with DDE, replace it with 0x05 */
// 1878 
// 1879 	if (ni == 8) b <<= 2;
// 1880 	if ((b & 0x03) == 0x01) c |= NS_EXT;	/* NT flag (Name extension has only small capital) */
// 1881 	if ((b & 0x0C) == 0x04) c |= NS_BODY;	/* NT flag (Name body has only small capital) */
// 1882 
// 1883 	sfn[NS] = c;		/* Store NT flag, File name is created */
// 1884 
// 1885 	return FR_OK;
// 1886 #endif
// 1887 }
// 1888 
// 1889 
// 1890 
// 1891 
// 1892 /*-----------------------------------------------------------------------*/
// 1893 /* Get file information from directory entry                             */
// 1894 /*-----------------------------------------------------------------------*/
// 1895 #if _FS_MINIMIZE <= 1 || _FS_RPATH >= 2

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1896 static
// 1897 void get_fileinfo (		/* No return code */
// 1898 	DIR *dj,			/* Pointer to the directory object */
// 1899 	FILINFO *fno	 	/* Pointer to the file information to be filled */
// 1900 )
// 1901 {
get_fileinfo:
        PUSH     {R3-R7,LR}
        MOVS     R4,R1
// 1902 	UINT i;
// 1903 	BYTE nt, *dir;
// 1904 	TCHAR *p, c;
// 1905 
// 1906 
// 1907 	p = fno->fname;
        ADDS     R1,R4,#+9
// 1908 	if (dj->sect) {
        LDR      R2,[R0, #+16]
        CMP      R2,#+0
        BEQ.N    ??get_fileinfo_0
// 1909 		dir = dj->dir;
        LDR      R2,[R0, #+20]
// 1910 		nt = dir[DIR_NTres];		/* NT flag */
        LDRB     R3,[R2, #+12]
// 1911 		for (i = 0; i < 8; i++) {	/* Copy name body */
        MOVS     R5,#+0
        B.N      ??get_fileinfo_1
// 1912 			c = dir[i];
// 1913 			if (c == ' ') break;
// 1914 			if (c == NDDE) c = (TCHAR)DDE;
??get_fileinfo_2:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+5
        BNE.N    ??get_fileinfo_3
        MOVS     R6,#+229
// 1915 			if (_USE_LFN && (nt & NS_BODY) && IsUpper(c)) c += 0x20;
??get_fileinfo_3:
        LSLS     R7,R3,#+28
        BPL.N    ??get_fileinfo_4
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        SUBS     R7,R6,#+65
        CMP      R7,#+26
        BCS.N    ??get_fileinfo_4
        ADDS     R6,R6,#+32
// 1916 #if _LFN_UNICODE
// 1917 			if (IsDBCS1(c) && i < 7 && IsDBCS2(dir[i+1]))
// 1918 				c = (c << 8) | dir[++i];
// 1919 			c = ff_convert(c, 1);
// 1920 			if (!c) c = '?';
// 1921 #endif
// 1922 			*p++ = c;
??get_fileinfo_4:
        STRB     R6,[R1, #+0]
        ADDS     R1,R1,#+1
        ADDS     R5,R5,#+1
??get_fileinfo_1:
        CMP      R5,#+8
        BCS.N    ??get_fileinfo_5
        LDRB     R6,[R5, R2]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+32
        BNE.N    ??get_fileinfo_2
// 1923 		}
// 1924 		if (dir[8] != ' ') {		/* Copy name extension */
??get_fileinfo_5:
        LDRB     R5,[R2, #+8]
        CMP      R5,#+32
        BEQ.N    ??get_fileinfo_6
// 1925 			*p++ = '.';
        MOVS     R5,#+46
        STRB     R5,[R1, #+0]
        ADDS     R1,R1,#+1
// 1926 			for (i = 8; i < 11; i++) {
        MOVS     R5,#+8
        B.N      ??get_fileinfo_7
// 1927 				c = dir[i];
// 1928 				if (c == ' ') break;
// 1929 				if (_USE_LFN && (nt & NS_EXT) && IsUpper(c)) c += 0x20;
??get_fileinfo_8:
        LSLS     R7,R3,#+27
        BPL.N    ??get_fileinfo_9
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        SUBS     R7,R6,#+65
        CMP      R7,#+26
        BCS.N    ??get_fileinfo_9
        ADDS     R6,R6,#+32
// 1930 #if _LFN_UNICODE
// 1931 				if (IsDBCS1(c) && i < 10 && IsDBCS2(dir[i+1]))
// 1932 					c = (c << 8) | dir[++i];
// 1933 				c = ff_convert(c, 1);
// 1934 				if (!c) c = '?';
// 1935 #endif
// 1936 				*p++ = c;
??get_fileinfo_9:
        STRB     R6,[R1, #+0]
        ADDS     R1,R1,#+1
        ADDS     R5,R5,#+1
??get_fileinfo_7:
        CMP      R5,#+11
        BCS.N    ??get_fileinfo_6
        LDRB     R6,[R5, R2]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+32
        BNE.N    ??get_fileinfo_8
// 1937 			}
// 1938 		}
// 1939 		fno->fattrib = dir[DIR_Attr];				/* Attribute */
??get_fileinfo_6:
        LDRB     R3,[R2, #+11]
        STRB     R3,[R4, #+8]
// 1940 		fno->fsize = LD_DWORD(dir+DIR_FileSize);	/* Size */
        LDRB     R3,[R2, #+31]
        LDRB     R5,[R2, #+30]
        LSLS     R5,R5,#+16
        ORRS     R3,R5,R3, LSL #+24
        LDRB     R5,[R2, #+29]
        ORRS     R3,R3,R5, LSL #+8
        LDRB     R5,[R2, #+28]
        ORRS     R3,R5,R3
        STR      R3,[R4, #+0]
// 1941 		fno->fdate = LD_WORD(dir+DIR_WrtDate);		/* Date */
        LDRB     R3,[R2, #+25]
        LDRB     R5,[R2, #+24]
        ORRS     R3,R5,R3, LSL #+8
        STRH     R3,[R4, #+4]
// 1942 		fno->ftime = LD_WORD(dir+DIR_WrtTime);		/* Time */
        LDRB     R3,[R2, #+23]
        LDRB     R2,[R2, #+22]
        ORRS     R2,R2,R3, LSL #+8
        STRH     R2,[R4, #+6]
// 1943 	}
// 1944 	*p = 0;		/* Terminate SFN str by a \0 */
??get_fileinfo_0:
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
// 1945 
// 1946 #if _USE_LFN
// 1947 	if (fno->lfname && fno->lfsize) {
        LDR      R1,[R4, #+24]
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_10
        LDR      R1,[R4, #+28]
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_10
// 1948 		TCHAR *tp = fno->lfname;
        LDR      R6,[R4, #+24]
// 1949 		WCHAR w, *lfn;
// 1950 
// 1951 		i = 0;
        MOVS     R5,#+0
// 1952 		if (dj->sect && dj->lfn_idx != 0xFFFF) {/* Get LFN if available */
        LDR      R1,[R0, #+16]
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_11
        LDRH     R1,[R0, #+32]
        MOVW     R2,#+65535
        CMP      R1,R2
        BEQ.N    ??get_fileinfo_11
// 1953 			lfn = dj->lfn;
        LDR      R7,[R0, #+28]
        B.N      ??get_fileinfo_12
// 1954 			while ((w = *lfn++) != 0) {			/* Get an LFN char */
// 1955 #if !_LFN_UNICODE
// 1956 				w = ff_convert(w, 0);			/* Unicode -> OEM conversion */
// 1957 				if (!w) { i = 0; break; }		/* Could not convert, no LFN */
// 1958 				if (_DF1S && w >= 0x100)		/* Put 1st byte if it is a DBC (always false on SBCS cfg) */
// 1959 					tp[i++] = (TCHAR)(w >> 8);
// 1960 #endif
// 1961 				if (i >= fno->lfsize - 1) { i = 0; break; }	/* Buffer overflow, no LFN */
// 1962 				tp[i++] = (TCHAR)w;
??get_fileinfo_13:
        STRB     R0,[R5, R6]
        ADDS     R5,R5,#+1
??get_fileinfo_12:
        LDRH     R0,[R7, #+0]
        ADDS     R7,R7,#+2
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_11
        MOVS     R1,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_convert
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??get_fileinfo_14
        MOVS     R5,#+0
        B.N      ??get_fileinfo_11
??get_fileinfo_14:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+255
        BLE.N    ??get_fileinfo_15
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R1,R0,#+8
        STRB     R1,[R5, R6]
        ADDS     R5,R5,#+1
??get_fileinfo_15:
        LDR      R1,[R4, #+28]
        SUBS     R1,R1,#+1
        CMP      R5,R1
        BCC.N    ??get_fileinfo_13
        MOVS     R5,#+0
// 1963 			}
// 1964 		}
// 1965 		tp[i] = 0;	/* Terminate the LFN str by a \0 */
??get_fileinfo_11:
        MOVS     R0,#+0
        STRB     R0,[R5, R6]
// 1966 	}
// 1967 #endif
// 1968 }
??get_fileinfo_10:
        POP      {R0,R4-R7,PC}    ;; return
// 1969 #endif /* _FS_MINIMIZE <= 1 || _FS_RPATH >= 2*/
// 1970 
// 1971 
// 1972 
// 1973 
// 1974 /*-----------------------------------------------------------------------*/
// 1975 /* Follow a file path                                                    */
// 1976 /*-----------------------------------------------------------------------*/
// 1977 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1978 static
// 1979 FRESULT follow_path (	/* FR_OK(0): successful, !=0: error code */
// 1980 	DIR *dj,			/* Directory object to return last directory and found object */
// 1981 	const TCHAR *path	/* Full-path string to find a file or directory */
// 1982 )
// 1983 {
follow_path:
        PUSH     {R0,R1,R4,LR}
        MOVS     R4,R0
// 1984 	FRESULT res;
// 1985 	BYTE *dir, ns;
// 1986 
// 1987 
// 1988 #if _FS_RPATH
// 1989 	if (*path == '/' || *path == '\\') { /* There is a heading separator */
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+47
        BEQ.N    ??follow_path_0
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+92
        BNE.N    ??follow_path_1
// 1990 		path++;	dj->sclust = 0;		/* Strip it and start from the root dir */
??follow_path_0:
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+4]
        MOVS     R0,#+0
        STR      R0,[R4, #+8]
        B.N      ??follow_path_2
// 1991 	} else {							/* No heading separator */
// 1992 		dj->sclust = dj->fs->cdir;	/* Start from the current dir */
??follow_path_1:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+24]
        STR      R0,[R4, #+8]
// 1993 	}
// 1994 #else
// 1995 	if (*path == '/' || *path == '\\')	/* Strip heading separator if exist */
// 1996 		path++;
// 1997 	dj->sclust = 0;						/* Start from the root dir */
// 1998 #endif
// 1999 
// 2000 	if ((UINT)*path < ' ') {			/* Nul path means the start directory itself */
??follow_path_2:
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+32
        BCS.N    ??follow_path_3
// 2001 		res = dir_sdi(dj, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
// 2002 		dj->dir = 0;
        MOVS     R1,#+0
        STR      R1,[R4, #+20]
// 2003 	} else {							/* Follow path */
// 2004 		for (;;) {
// 2005 			res = create_name(dj, &path);	/* Get a segment */
// 2006 			if (res != FR_OK) break;
// 2007 			res = dir_find(dj);				/* Find it */
// 2008 			ns = *(dj->fn+NS);
// 2009 			if (res != FR_OK) {				/* Failed to find the object */
// 2010 				if (res != FR_NO_FILE) break;	/* Abort if any hard error occurred */
// 2011 				/* Object not found */
// 2012 				if (_FS_RPATH && (ns & NS_DOT)) {	/* If dot entry is not exit */
// 2013 					dj->sclust = 0; dj->dir = 0;	/* It is the root dir */
// 2014 					res = FR_OK;
// 2015 					if (!(ns & NS_LAST)) continue;
// 2016 				} else {							/* Could not find the object */
// 2017 					if (!(ns & NS_LAST)) res = FR_NO_PATH;
// 2018 				}
// 2019 				break;
// 2020 			}
// 2021 			if (ns & NS_LAST) break;			/* Last segment match. Function completed. */
// 2022 			dir = dj->dir;						/* There is next segment. Follow the sub directory */
// 2023 			if (!(dir[DIR_Attr] & AM_DIR)) {	/* Cannot follow because it is a file */
// 2024 				res = FR_NO_PATH; break;
// 2025 			}
// 2026 			dj->sclust = ld_clust(dj->fs, dir);
// 2027 		}
// 2028 	}
// 2029 
// 2030 	return res;
??follow_path_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R2,R4,PC}    ;; return
??follow_path_5:
        MOVS     R0,#+0
        STR      R0,[R4, #+8]
        MOVS     R0,#+0
        STR      R0,[R4, #+20]
        MOVS     R0,#+0
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_6
??follow_path_3:
        ADD      R1,SP,#+4
        MOVS     R0,R4
        BL       create_name
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??follow_path_4
??follow_path_7:
        MOVS     R0,R4
        BL       dir_find
        LDR      R1,[R4, #+24]
        LDRB     R1,[R1, #+11]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??follow_path_8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??follow_path_4
??follow_path_9:
        LSLS     R2,R1,#+26
        BMI.N    ??follow_path_5
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_6
        MOVS     R0,#+5
??follow_path_6:
        B.N      ??follow_path_4
??follow_path_8:
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_4
??follow_path_10:
        LDR      R1,[R4, #+20]
        LDRB     R0,[R1, #+11]
        LSLS     R0,R0,#+27
        BMI.N    ??follow_path_11
        MOVS     R0,#+5
        B.N      ??follow_path_4
??follow_path_11:
        LDR      R0,[R4, #+0]
        BL       ld_clust
        STR      R0,[R4, #+8]
        B.N      ??follow_path_3
// 2031 }
// 2032 
// 2033 
// 2034 
// 2035 
// 2036 /*-----------------------------------------------------------------------*/
// 2037 /* Load a sector and check if it is an FAT Volume Boot Record            */
// 2038 /*-----------------------------------------------------------------------*/
// 2039 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2040 static
// 2041 BYTE check_fs (	/* 0:FAT-VBR, 1:Any BR but not FAT, 2:Not a BR, 3:Disk error */
// 2042 	FATFS *fs,	/* File system object */
// 2043 	DWORD sect	/* Sector# (lba) to check if it is an FAT boot record or not */
// 2044 )
// 2045 {
check_fs:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 2046 	if (disk_read(fs->drv, fs->win, sect, 1) != RES_OK)	/* Load boot record */
        MOVS     R3,#+1
        MOVS     R2,R1
        ADDS     R1,R4,#+56
        LDRB     R0,[R4, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??check_fs_0
// 2047 		return 3;
        MOVS     R0,#+3
        B.N      ??check_fs_1
// 2048 	if (LD_WORD(&fs->win[BS_55AA]) != 0xAA55)		/* Check record signature (always placed at offset 510 even if the sector size is >512) */
??check_fs_0:
        LDRB     R0,[R4, #+567]
        LDRB     R1,[R4, #+566]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVW     R1,#+43605
        CMP      R0,R1
        BEQ.N    ??check_fs_2
// 2049 		return 2;
        MOVS     R0,#+2
        B.N      ??check_fs_1
// 2050 
// 2051 	if ((LD_DWORD(&fs->win[BS_FilSysType]) & 0xFFFFFF) == 0x544146)	/* Check "FAT" string */
??check_fs_2:
        LDRB     R0,[R4, #+112]
        LDRB     R1,[R4, #+111]
        LSLS     R1,R1,#+8
        ORRS     R0,R1,R0, LSL #+16
        LDRB     R1,[R4, #+110]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13  ;; 0x544146
        CMP      R0,R1
        BNE.N    ??check_fs_3
// 2052 		return 0;
        MOVS     R0,#+0
        B.N      ??check_fs_1
// 2053 	if ((LD_DWORD(&fs->win[BS_FilSysType32]) & 0xFFFFFF) == 0x544146)
??check_fs_3:
        LDRB     R0,[R4, #+140]
        LDRB     R1,[R4, #+139]
        LSLS     R1,R1,#+8
        ORRS     R0,R1,R0, LSL #+16
        LDRB     R1,[R4, #+138]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13  ;; 0x544146
        CMP      R0,R1
        BNE.N    ??check_fs_4
// 2054 		return 0;
        MOVS     R0,#+0
        B.N      ??check_fs_1
// 2055 
// 2056 	return 1;
??check_fs_4:
        MOVS     R0,#+1
??check_fs_1:
        POP      {R4,PC}          ;; return
// 2057 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     LfnOfs
// 2058 
// 2059 
// 2060 
// 2061 
// 2062 /*-----------------------------------------------------------------------*/
// 2063 /* Check if the file system object is valid or not                       */
// 2064 /*-----------------------------------------------------------------------*/
// 2065 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2066 static
// 2067 FRESULT chk_mounted (	/* FR_OK(0): successful, !=0: any error occurred */
// 2068 	const TCHAR **path,	/* Pointer to pointer to the path name (drive number) */
// 2069 	FATFS **rfs,		/* Pointer to pointer to the found file system object */
// 2070 	BYTE wmode			/* !=0: Check write protection for write access */
// 2071 )
// 2072 {
chk_mounted:
        PUSH     {R3-R7,LR}
        MOVS     R5,R2
// 2073 	BYTE fmt, b, pi, *tbl;
// 2074 	UINT vol;
// 2075 	DSTATUS stat;
// 2076 	DWORD bsect, fasize, tsect, sysect, nclst, szbfat;
// 2077 	WORD nrsv;
// 2078 	const TCHAR *p = *path;
        LDR      R2,[R0, #+0]
// 2079 	FATFS *fs;
// 2080 
// 2081 
// 2082 	/* Get logical drive number from the path name */
// 2083 	vol = p[0] - '0';					/* Is there a drive number? */
        LDRB     R3,[R2, #+0]
        SUBS     R6,R3,#+48
// 2084 	if (vol <= 9 && p[1] == ':') {		/* Found a drive number, get and strip it */
        CMP      R6,#+10
        BCS.N    ??chk_mounted_0
        LDRB     R3,[R2, #+1]
        CMP      R3,#+58
        BNE.N    ??chk_mounted_0
// 2085 		p += 2; *path = p;				/* Return pointer to the path name */
        ADDS     R2,R2,#+2
        STR      R2,[R0, #+0]
        B.N      ??chk_mounted_1
// 2086 	} else {							/* No drive number, use default drive */
// 2087 #if _FS_RPATH
// 2088 		vol = CurrVol;					/* Use current drive */
??chk_mounted_0:
        LDR.W    R0,??DataTable13_1
        LDRB     R6,[R0, #+0]
// 2089 #else
// 2090 		vol = 0;						/* Use drive 0 */
// 2091 #endif
// 2092 	}
// 2093 
// 2094 	/* Check if the file system object is valid or not */
// 2095 	*rfs = 0;
??chk_mounted_1:
        MOVS     R0,#+0
        STR      R0,[R1, #+0]
// 2096 	if (vol >= _VOLUMES) 				/* Is the drive number valid? */
        CMP      R6,#+0
        BEQ.N    ??chk_mounted_2
// 2097 		return FR_INVALID_DRIVE;
        MOVS     R0,#+11
        B.N      ??chk_mounted_3
// 2098 	fs = FatFs[vol];					/* Get corresponding file system object */
??chk_mounted_2:
        LDR.W    R0,??DataTable13_2
        LDR      R4,[R0, R6, LSL #+2]
// 2099 	if (!fs) return FR_NOT_ENABLED;		/* Is the file system object available? */
        CMP      R4,#+0
        BNE.N    ??chk_mounted_4
        MOVS     R0,#+12
        B.N      ??chk_mounted_3
// 2100 
// 2101 	ENTER_FF(fs);						/* Lock volume */
// 2102 
// 2103 	*rfs = fs;							/* Return pointer to the corresponding file system object */
??chk_mounted_4:
        STR      R4,[R1, #+0]
// 2104 	if (fs->fs_type) {					/* If the volume has been mounted */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_5
// 2105 		stat = disk_status(fs->drv);
        LDRB     R0,[R4, #+1]
        BL       disk_status
// 2106 		if (!(stat & STA_NOINIT)) {		/* and the physical drive is kept initialized (has not been changed), */
        LSLS     R1,R0,#+31
        BMI.N    ??chk_mounted_5
// 2107 			if (!_FS_READONLY && wmode && (stat & STA_PROTECT))	/* Check write protection if needed */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??chk_mounted_6
        LSLS     R0,R0,#+29
        BPL.N    ??chk_mounted_6
// 2108 				return FR_WRITE_PROTECTED;
        MOVS     R0,#+10
        B.N      ??chk_mounted_3
// 2109 			return FR_OK;				/* The file system object is valid */
??chk_mounted_6:
        MOVS     R0,#+0
        B.N      ??chk_mounted_3
// 2110 		}
// 2111 	}
// 2112 
// 2113 	/* The file system object is not valid. */
// 2114 	/* Following code attempts to mount the volume. (analyze BPB and initialize the fs object) */
// 2115 
// 2116 	fs->fs_type = 0;					/* Clear the file system object */
??chk_mounted_5:
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
// 2117 	fs->drv = LD2PD(vol);				/* Bind the logical drive and a physical drive */
        STRB     R6,[R4, #+1]
// 2118 	stat = disk_initialize(fs->drv);	/* Initialize the physical drive */
        LDRB     R0,[R4, #+1]
        BL       disk_initialize
// 2119 	if (stat & STA_NOINIT)				/* Check if the initialization succeeded */
        LSLS     R1,R0,#+31
        BPL.N    ??chk_mounted_7
// 2120 		return FR_NOT_READY;			/* Failed to initialize due to no medium or hard error */
        MOVS     R0,#+3
        B.N      ??chk_mounted_3
// 2121 	if (!_FS_READONLY && wmode && (stat & STA_PROTECT))	/* Check disk write protection if needed */
??chk_mounted_7:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??chk_mounted_8
        LSLS     R0,R0,#+29
        BPL.N    ??chk_mounted_8
// 2122 		return FR_WRITE_PROTECTED;
        MOVS     R0,#+10
        B.N      ??chk_mounted_3
// 2123 #if _MAX_SS != 512						/* Get disk sector size (variable sector size cfg only) */
// 2124 	if (disk_ioctl(fs->drv, GET_SECTOR_SIZE, &fs->ssize) != RES_OK)
// 2125 		return FR_DISK_ERR;
// 2126 #endif
// 2127 	/* Search FAT partition on the drive. Supports only generic partitions, FDISK and SFD. */
// 2128 	fmt = check_fs(fs, bsect = 0);		/* Load sector 0 and check if it is an FAT-VBR (in SFD) */
??chk_mounted_8:
        MOVS     R5,#+0
        MOVS     R1,R5
        MOVS     R0,R4
        BL       check_fs
        MOVS     R6,R0
// 2129 	if (LD2PT(vol) && !fmt) fmt = 1;	/* Force non-SFD if the volume is forced partition */
// 2130 	if (fmt == 1) {						/* Not an FAT-VBR, the physical drive can be partitioned */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??chk_mounted_9
// 2131 		/* Check the partition listed in the partition table */
// 2132 		pi = LD2PT(vol);
        MOVS     R0,#+0
// 2133 		if (pi) pi--;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_10
        SUBS     R0,R0,#+1
// 2134 		tbl = &fs->win[MBR_Table + pi * SZ_PTE];/* Partition table */
??chk_mounted_10:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R0,R4,R0, LSL #+4
        ADDS     R0,R0,#+502
// 2135 		if (tbl[4]) {						/* Is the partition existing? */
        LDRB     R1,[R0, #+4]
        CMP      R1,#+0
        BEQ.N    ??chk_mounted_9
// 2136 			bsect = LD_DWORD(&tbl[8]);		/* Partition offset in LBA */
        LDRB     R1,[R0, #+11]
        LDRB     R2,[R0, #+10]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R0, #+9]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R0,[R0, #+8]
        ORRS     R5,R0,R1
// 2137 			fmt = check_fs(fs, bsect);		/* Check the partition */
        MOVS     R1,R5
        MOVS     R0,R4
        BL       check_fs
        MOVS     R6,R0
// 2138 		}
// 2139 	}
// 2140 	if (fmt == 3) return FR_DISK_ERR;
??chk_mounted_9:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??chk_mounted_11
        MOVS     R0,#+1
        B.N      ??chk_mounted_3
// 2141 	if (fmt) return FR_NO_FILESYSTEM;		/* No FAT volume is found */
??chk_mounted_11:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??chk_mounted_12
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2142 
// 2143 	/* An FAT volume is found. Following code initializes the file system object */
// 2144 
// 2145 	if (LD_WORD(fs->win+BPB_BytsPerSec) != SS(fs))		/* (BPB_BytsPerSec must be equal to the physical sector size) */
??chk_mounted_12:
        LDRB     R0,[R4, #+68]
        LDRB     R1,[R4, #+67]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+512
        BEQ.N    ??chk_mounted_13
// 2146 		return FR_NO_FILESYSTEM;
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2147 
// 2148 	fasize = LD_WORD(fs->win+BPB_FATSz16);				/* Number of sectors per FAT */
??chk_mounted_13:
        LDRB     R0,[R4, #+79]
        LDRB     R1,[R4, #+78]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
// 2149 	if (!fasize) fasize = LD_DWORD(fs->win+BPB_FATSz32);
        CMP      R0,#+0
        BNE.N    ??chk_mounted_14
        LDRB     R0,[R4, #+95]
        LDRB     R1,[R4, #+94]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+93]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+92]
        ORRS     R0,R1,R0
// 2150 	fs->fsize = fasize;
??chk_mounted_14:
        STR      R0,[R4, #+32]
// 2151 
// 2152 	fs->n_fats = b = fs->win[BPB_NumFATs];				/* Number of FAT copies */
        LDRB     R1,[R4, #+72]
        STRB     R1,[R4, #+3]
// 2153 	if (b != 1 && b != 2) return FR_NO_FILESYSTEM;		/* (Must be 1 or 2) */
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+1
        BEQ.N    ??chk_mounted_15
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+2
        BEQ.N    ??chk_mounted_15
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2154 	fasize *= b;										/* Number of sectors for FAT area */
??chk_mounted_15:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MULS     R0,R1,R0
// 2155 
// 2156 	fs->csize = b = fs->win[BPB_SecPerClus];			/* Number of sectors per cluster */
        LDRB     R1,[R4, #+69]
        STRB     R1,[R4, #+2]
// 2157 	if (!b || (b & (b - 1))) return FR_NO_FILESYSTEM;	/* (Must be power of 2) */
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??chk_mounted_16
        SUBS     R2,R1,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        TST      R1,R2
        BEQ.N    ??chk_mounted_17
??chk_mounted_16:
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2158 
// 2159 	fs->n_rootdir = LD_WORD(fs->win+BPB_RootEntCnt);	/* Number of root directory entries */
??chk_mounted_17:
        LDRB     R1,[R4, #+74]
        LDRB     R2,[R4, #+73]
        ORRS     R1,R2,R1, LSL #+8
        STRH     R1,[R4, #+8]
// 2160 	if (fs->n_rootdir % (SS(fs) / SZ_DIR)) return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must be sector aligned) */
        LDRH     R1,[R4, #+8]
        MOVS     R2,#+16
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        CMP      R3,#+0
        BEQ.N    ??chk_mounted_18
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2161 
// 2162 	tsect = LD_WORD(fs->win+BPB_TotSec16);				/* Number of sectors on the volume */
??chk_mounted_18:
        LDRB     R1,[R4, #+76]
        LDRB     R2,[R4, #+75]
        ORRS     R2,R2,R1, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
// 2163 	if (!tsect) tsect = LD_DWORD(fs->win+BPB_TotSec32);
        CMP      R2,#+0
        BNE.N    ??chk_mounted_19
        LDRB     R1,[R4, #+91]
        LDRB     R2,[R4, #+90]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R4, #+89]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R2,[R4, #+88]
        ORRS     R2,R2,R1
// 2164 
// 2165 	nrsv = LD_WORD(fs->win+BPB_RsvdSecCnt);				/* Number of reserved sectors */
??chk_mounted_19:
        LDRB     R1,[R4, #+71]
        LDRB     R3,[R4, #+70]
        ORRS     R1,R3,R1, LSL #+8
// 2166 	if (!nrsv) return FR_NO_FILESYSTEM;					/* (BPB_RsvdSecCnt must not be 0) */
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BNE.N    ??chk_mounted_20
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2167 
// 2168 	/* Determine the FAT sub type */
// 2169 	sysect = nrsv + fasize + fs->n_rootdir / (SS(fs) / SZ_DIR);	/* RSV+FAT+DIR */
??chk_mounted_20:
        UXTAH    R3,R0,R1
        LDRH     R6,[R4, #+8]
        ADDS     R3,R3,R6, LSR #+4
// 2170 	if (tsect < sysect) return FR_NO_FILESYSTEM;		/* (Invalid volume size) */
        CMP      R2,R3
        BCS.N    ??chk_mounted_21
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2171 	nclst = (tsect - sysect) / fs->csize;				/* Number of clusters */
??chk_mounted_21:
        SUBS     R2,R2,R3
        LDRB     R6,[R4, #+2]
        UDIV     R2,R2,R6
// 2172 	if (!nclst) return FR_NO_FILESYSTEM;				/* (Invalid volume size) */
        CMP      R2,#+0
        BNE.N    ??chk_mounted_22
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2173 	fmt = FS_FAT12;
??chk_mounted_22:
        MOVS     R6,#+1
// 2174 	if (nclst >= MIN_FAT16) fmt = FS_FAT16;
        MOVW     R7,#+4086
        CMP      R2,R7
        BCC.N    ??chk_mounted_23
        MOVS     R6,#+2
// 2175 	if (nclst >= MIN_FAT32) fmt = FS_FAT32;
??chk_mounted_23:
        MOVW     R7,#+65526
        CMP      R2,R7
        BCC.N    ??chk_mounted_24
        MOVS     R6,#+3
// 2176 
// 2177 	/* Boundaries and Limits */
// 2178 	fs->n_fatent = nclst + 2;							/* Number of FAT entries */
??chk_mounted_24:
        ADDS     R2,R2,#+2
        STR      R2,[R4, #+28]
// 2179 	fs->volbase = bsect;								/* Volume start sector */
        STR      R5,[R4, #+36]
// 2180 	fs->fatbase = bsect + nrsv; 						/* FAT start sector */
        UXTAH    R1,R5,R1
        STR      R1,[R4, #+40]
// 2181 	fs->database = bsect + sysect;						/* Data start sector */
        ADDS     R1,R3,R5
        STR      R1,[R4, #+48]
// 2182 	if (fmt == FS_FAT32) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??chk_mounted_25
// 2183 		if (fs->n_rootdir) return FR_NO_FILESYSTEM;		/* (BPB_RootEntCnt must be 0) */
        LDRH     R0,[R4, #+8]
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_26
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2184 		fs->dirbase = LD_DWORD(fs->win+BPB_RootClus);	/* Root directory start cluster */
??chk_mounted_26:
        LDRB     R0,[R4, #+103]
        LDRB     R1,[R4, #+102]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+101]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+100]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+44]
// 2185 		szbfat = fs->n_fatent * 4;						/* (Required FAT size) */
        LDR      R0,[R4, #+28]
        LSLS     R0,R0,#+2
        B.N      ??chk_mounted_27
// 2186 	} else {
// 2187 		if (!fs->n_rootdir)	return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must not be 0) */
??chk_mounted_25:
        LDRH     R1,[R4, #+8]
        CMP      R1,#+0
        BNE.N    ??chk_mounted_28
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2188 		fs->dirbase = fs->fatbase + fasize;				/* Root directory start sector */
??chk_mounted_28:
        LDR      R1,[R4, #+40]
        ADDS     R0,R0,R1
        STR      R0,[R4, #+44]
// 2189 		szbfat = (fmt == FS_FAT16) ?					/* (Required FAT size) */
// 2190 			fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BNE.N    ??chk_mounted_29
        LDR      R0,[R4, #+28]
        LSLS     R0,R0,#+1
        B.N      ??chk_mounted_27
??chk_mounted_29:
        LDR      R0,[R4, #+28]
        MOVS     R1,#+3
        MULS     R0,R1,R0
        LDRB     R1,[R4, #+28]
        ANDS     R1,R1,#0x1
        ADDS     R0,R1,R0, LSR #+1
// 2191 	}
// 2192 	if (fs->fsize < (szbfat + (SS(fs) - 1)) / SS(fs))	/* (BPB_FATSz must not be less than required) */
??chk_mounted_27:
        LDR      R1,[R4, #+32]
        ADDW     R0,R0,#+511
        CMP      R1,R0, LSR #+9
        BCS.N    ??chk_mounted_30
// 2193 		return FR_NO_FILESYSTEM;
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2194 
// 2195 #if !_FS_READONLY
// 2196 	/* Initialize cluster allocation information */
// 2197 	fs->free_clust = 0xFFFFFFFF;
??chk_mounted_30:
        MOVS     R0,#-1
        STR      R0,[R4, #+16]
// 2198 	fs->last_clust = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+12]
// 2199 
// 2200 	/* Get fsinfo if available */
// 2201 	if (fmt == FS_FAT32) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??chk_mounted_31
// 2202 	 	fs->fsi_flag = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+5]
// 2203 		fs->fsi_sector = bsect + LD_WORD(fs->win+BPB_FSInfo);
        LDRB     R0,[R4, #+105]
        LDRB     R1,[R4, #+104]
        ORRS     R0,R1,R0, LSL #+8
        UXTAH    R0,R5,R0
        STR      R0,[R4, #+20]
// 2204 		if (disk_read(fs->drv, fs->win, fs->fsi_sector, 1) == RES_OK &&
// 2205 			LD_WORD(fs->win+BS_55AA) == 0xAA55 &&
// 2206 			LD_DWORD(fs->win+FSI_LeadSig) == 0x41615252 &&
// 2207 			LD_DWORD(fs->win+FSI_StrucSig) == 0x61417272) {
        MOVS     R3,#+1
        LDR      R2,[R4, #+20]
        ADDS     R1,R4,#+56
        LDRB     R0,[R4, #+1]
        BL       disk_read
        CMP      R0,#+0
        BNE.N    ??chk_mounted_31
        LDRB     R0,[R4, #+567]
        LDRB     R1,[R4, #+566]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVW     R1,#+43605
        CMP      R0,R1
        BNE.N    ??chk_mounted_31
        LDRB     R0,[R4, #+59]
        LDRB     R1,[R4, #+58]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+57]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+56]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13_3  ;; 0x41615252
        CMP      R0,R1
        BNE.N    ??chk_mounted_31
        LDRB     R0,[R4, #+543]
        LDRB     R1,[R4, #+542]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+541]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+540]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13_4  ;; 0x61417272
        CMP      R0,R1
        BNE.N    ??chk_mounted_31
// 2208 				fs->last_clust = LD_DWORD(fs->win+FSI_Nxt_Free);
        LDRB     R0,[R4, #+551]
        LDRB     R1,[R4, #+550]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+549]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+548]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+12]
// 2209 				fs->free_clust = LD_DWORD(fs->win+FSI_Free_Count);
        LDRB     R0,[R4, #+547]
        LDRB     R1,[R4, #+546]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+545]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+544]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+16]
// 2210 		}
// 2211 	}
// 2212 #endif
// 2213 	fs->fs_type = fmt;		/* FAT sub-type */
??chk_mounted_31:
        STRB     R6,[R4, #+0]
// 2214 	fs->id = ++Fsid;		/* File system mount ID */
        LDR.W    R0,??DataTable13_5
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable13_5
        STRH     R0,[R1, #+0]
        LDR.W    R0,??DataTable13_5
        LDRH     R0,[R0, #+0]
        STRH     R0,[R4, #+6]
// 2215 	fs->winsect = 0;		/* Invalidate sector cache */
        MOVS     R0,#+0
        STR      R0,[R4, #+52]
// 2216 	fs->wflag = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+4]
// 2217 #if _FS_RPATH
// 2218 	fs->cdir = 0;			/* Current directory (root dir) */
        MOVS     R0,#+0
        STR      R0,[R4, #+24]
// 2219 #endif
// 2220 #if _FS_LOCK				/* Clear file lock semaphores */
// 2221 	clear_lock(fs);
        MOVS     R0,R4
        BL       clear_lock
// 2222 #endif
// 2223 
// 2224 	return FR_OK;
        MOVS     R0,#+0
??chk_mounted_3:
        POP      {R1,R4-R7,PC}    ;; return
// 2225 }
// 2226 
// 2227 
// 2228 
// 2229 
// 2230 /*-----------------------------------------------------------------------*/
// 2231 /* Check if the file/dir object is valid or not                          */
// 2232 /*-----------------------------------------------------------------------*/
// 2233 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2234 static
// 2235 FRESULT validate (	/* FR_OK(0): The object is valid, !=0: Invalid */
// 2236 	void* obj		/* Pointer to the object FIL/DIR to check validity */
// 2237 )
// 2238 {
validate:
        PUSH     {R7,LR}
// 2239 	FIL *fil = (FIL*)obj;	/* Assuming offset of fs and id in the FIL/DIR is identical */
// 2240 
// 2241 
// 2242 	if (!fil || !fil->fs || !fil->fs->fs_type || fil->fs->id != fil->id)
        CMP      R0,#+0
        BEQ.N    ??validate_0
        LDR      R1,[R0, #+0]
        CMP      R1,#+0
        BEQ.N    ??validate_0
        LDR      R1,[R0, #+0]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        BEQ.N    ??validate_0
        LDR      R1,[R0, #+0]
        LDRH     R1,[R1, #+6]
        LDRH     R2,[R0, #+4]
        CMP      R1,R2
        BEQ.N    ??validate_1
// 2243 		return FR_INVALID_OBJECT;
??validate_0:
        MOVS     R0,#+9
        B.N      ??validate_2
// 2244 
// 2245 	ENTER_FF(fil->fs);		/* Lock file system */
// 2246 
// 2247 	if (disk_status(fil->fs->drv) & STA_NOINIT)
??validate_1:
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_status
        LSLS     R0,R0,#+31
        BPL.N    ??validate_3
// 2248 		return FR_NOT_READY;
        MOVS     R0,#+3
        B.N      ??validate_2
// 2249 
// 2250 	return FR_OK;
??validate_3:
        MOVS     R0,#+0
??validate_2:
        POP      {R1,PC}          ;; return
// 2251 }
// 2252 
// 2253 
// 2254 
// 2255 
// 2256 /*--------------------------------------------------------------------------
// 2257 
// 2258    Public Functions
// 2259 
// 2260 --------------------------------------------------------------------------*/
// 2261 
// 2262 
// 2263 
// 2264 /*-----------------------------------------------------------------------*/
// 2265 /* Mount/Unmount a Logical Drive                                         */
// 2266 /*-----------------------------------------------------------------------*/
// 2267 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2268 FRESULT f_mount (
// 2269 	BYTE vol,		/* Logical drive number to be mounted/unmounted */
// 2270 	FATFS *fs		/* Pointer to new file system object (NULL for unmount)*/
// 2271 )
// 2272 {
f_mount:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 2273 	FATFS *rfs;
// 2274 
// 2275 
// 2276 	if (vol >= _VOLUMES)		/* Check if the drive number is valid */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??f_mount_0
// 2277 		return FR_INVALID_DRIVE;
        MOVS     R0,#+11
        B.N      ??f_mount_1
// 2278 	rfs = FatFs[vol];			/* Get current fs object */
??f_mount_0:
        LDR.W    R0,??DataTable13_2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R6,[R0, R4, LSL #+2]
// 2279 
// 2280 	if (rfs) {
        CMP      R6,#+0
        BEQ.N    ??f_mount_2
// 2281 #if _FS_LOCK
// 2282 		clear_lock(rfs);
        MOVS     R0,R6
        BL       clear_lock
// 2283 #endif
// 2284 #if _FS_REENTRANT				/* Discard sync object of the current volume */
// 2285 		if (!ff_del_syncobj(rfs->sobj)) return FR_INT_ERR;
// 2286 #endif
// 2287 		rfs->fs_type = 0;		/* Clear old fs object */
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
// 2288 	}
// 2289 
// 2290 	if (fs) {
??f_mount_2:
        CMP      R5,#+0
        BEQ.N    ??f_mount_3
// 2291 		fs->fs_type = 0;		/* Clear new fs object */
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
// 2292 #if _FS_REENTRANT				/* Create sync object for the new volume */
// 2293 		if (!ff_cre_syncobj(vol, &fs->sobj)) return FR_INT_ERR;
// 2294 #endif
// 2295 	}
// 2296 	FatFs[vol] = fs;			/* Register new fs object */
??f_mount_3:
        LDR.W    R0,??DataTable13_2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R5,[R0, R4, LSL #+2]
// 2297 
// 2298 	return FR_OK;
        MOVS     R0,#+0
??f_mount_1:
        POP      {R4-R6,PC}       ;; return
// 2299 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     ?_0
// 2300 
// 2301 
// 2302 
// 2303 
// 2304 /*-----------------------------------------------------------------------*/
// 2305 /* Open or Create a File                                                 */
// 2306 /*-----------------------------------------------------------------------*/
// 2307 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2308 FRESULT f_open (
// 2309 	FIL *fp,			/* Pointer to the blank file object */
// 2310 	const TCHAR *path,	/* Pointer to the file name */
// 2311 	BYTE mode			/* Access mode and file open mode flags */
// 2312 )
// 2313 {
f_open:
        PUSH     {R1,R4-R10,LR}
        SUB      SP,SP,#+52
        MOVS     R4,R0
        MOVS     R6,R2
// 2314 	FRESULT res;
// 2315 	DIR dj;
// 2316 	BYTE *dir;
// 2317 	DEF_NAMEBUF;
// 2318 
// 2319 
// 2320 	if (!fp) return FR_INVALID_OBJECT;
        CMP      R4,#+0
        BNE.N    ??f_open_0
        MOVS     R0,#+9
        B.N      ??f_open_1
// 2321 	fp->fs = 0;			/* Clear file object */
??f_open_0:
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
// 2322 
// 2323 #if !_FS_READONLY
// 2324 	mode &= FA_READ | FA_WRITE | FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW;
        ANDS     R6,R6,#0x1F
// 2325 	res = chk_mounted(&path, &dj.fs, (BYTE)(mode & ~FA_READ));
        ANDS     R2,R6,#0xFE
        ADD      R1,SP,#+0
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOV      R8,R0
// 2326 #else
// 2327 	mode &= FA_READ;
// 2328 	res = chk_mounted(&path, &dj.fs, 0);
// 2329 #endif
// 2330 	if (res == FR_OK) {
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.W    ??f_open_2
// 2331 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_open_3
        MOVS     R0,#+17
        B.N      ??f_open_1
??f_open_3:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 2332 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+0
        BL       follow_path
        MOV      R8,R0
// 2333 		dir = dj.dir;
        LDR      R7,[SP, #+20]
// 2334 #if !_FS_READONLY	/* R/W configuration */
// 2335 		if (res == FR_OK) {
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_open_4
// 2336 			if (!dir)	/* Current dir itself */
        CMP      R7,#+0
        BNE.N    ??f_open_5
// 2337 				res = FR_INVALID_NAME;
        MOVS     R8,#+6
        B.N      ??f_open_4
// 2338 #if _FS_LOCK
// 2339 			else
// 2340 				res = chk_lock(&dj, (mode & ~FA_READ) ? 1 : 0);
??f_open_5:
        MOVS     R0,#+254
        TST      R6,R0
        BEQ.N    ??f_open_6
        MOVS     R1,#+1
        B.N      ??f_open_7
??f_open_6:
        MOVS     R1,#+0
??f_open_7:
        ADD      R0,SP,#+0
        BL       chk_lock
        MOV      R8,R0
// 2341 #endif
// 2342 		}
// 2343 		/* Create or Open a file */
// 2344 		if (mode & (FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW)) {
??f_open_4:
        MOVS     R0,#+28
        TST      R6,R0
        BEQ.N    ??f_open_8
// 2345 			DWORD dw, cl;
// 2346 
// 2347 			if (res != FR_OK) {					/* No file, create new */
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??f_open_9
// 2348 				if (res == FR_NO_FILE)			/* There is no file to open, create a new entry */
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+4
        BNE.N    ??f_open_10
// 2349 #if _FS_LOCK
// 2350 					res = enq_lock() ? dir_register(&dj) : FR_TOO_MANY_OPEN_FILES;
        BL       enq_lock
        CMP      R0,#+0
        BEQ.N    ??f_open_11
        ADD      R0,SP,#+0
        BL       dir_register
        MOV      R8,R0
        B.N      ??f_open_12
??f_open_11:
        MOVS     R8,#+18
// 2351 #else
// 2352 					res = dir_register(&dj);
// 2353 #endif
// 2354 				mode |= FA_CREATE_ALWAYS;		/* File is created */
??f_open_12:
??f_open_10:
        ORRS     R6,R6,#0x8
// 2355 				dir = dj.dir;					/* New entry */
        LDR      R7,[SP, #+20]
        B.N      ??f_open_13
// 2356 			}
// 2357 			else {								/* Any object is already existing */
// 2358 				if (dir[DIR_Attr] & (AM_RDO | AM_DIR)) {	/* Cannot overwrite it (R/O or DIR) */
??f_open_9:
        LDRB     R0,[R7, #+11]
        MOVS     R1,#+17
        TST      R0,R1
        BEQ.N    ??f_open_14
// 2359 					res = FR_DENIED;
        MOVS     R8,#+7
        B.N      ??f_open_13
// 2360 				} else {
// 2361 					if (mode & FA_CREATE_NEW)	/* Cannot create as new file */
??f_open_14:
        LSLS     R0,R6,#+29
        BPL.N    ??f_open_13
// 2362 						res = FR_EXIST;
        MOVS     R8,#+8
// 2363 				}
// 2364 			}
// 2365 			if (res == FR_OK && (mode & FA_CREATE_ALWAYS)) {	/* Truncate it if overwrite mode */
??f_open_13:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_open_15
        LSLS     R0,R6,#+28
        BPL.N    ??f_open_15
// 2366 				dw = get_fattime();					/* Created time */
        BL       get_fattime
        MOV      R9,R0
// 2367 				ST_DWORD(dir+DIR_CrtTime, dw);
        STRB     R9,[R7, #+14]
        MOV      R0,R9
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+15]
        LSRS     R0,R9,#+16
        STRB     R0,[R7, #+16]
        LSRS     R0,R9,#+24
        STRB     R0,[R7, #+17]
// 2368 				dir[DIR_Attr] = 0;					/* Reset attribute */
        MOVS     R0,#+0
        STRB     R0,[R7, #+11]
// 2369 				ST_DWORD(dir+DIR_FileSize, 0);		/* size = 0 */
        MOVS     R0,#+0
        STRB     R0,[R7, #+28]
        MOVS     R0,#+0
        STRB     R0,[R7, #+29]
        MOVS     R0,#+0
        STRB     R0,[R7, #+30]
        MOVS     R0,#+0
        STRB     R0,[R7, #+31]
// 2370 				cl = ld_clust(dj.fs, dir);			/* Get start cluster */
        MOVS     R1,R7
        LDR      R0,[SP, #+0]
        BL       ld_clust
        MOV      R10,R0
// 2371 				st_clust(dir, 0);					/* cluster = 0 */
        MOVS     R1,#+0
        MOVS     R0,R7
        BL       st_clust
// 2372 				dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 2373 				if (cl) {							/* Remove the cluster chain if exist */
        CMP      R10,#+0
        BEQ.N    ??f_open_15
// 2374 					dw = dj.fs->winsect;
        LDR      R0,[SP, #+0]
        LDR      R9,[R0, #+52]
// 2375 					res = remove_chain(dj.fs, cl);
        MOV      R1,R10
        LDR      R0,[SP, #+0]
        BL       remove_chain
        MOV      R8,R0
// 2376 					if (res == FR_OK) {
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_open_15
// 2377 						dj.fs->last_clust = cl - 1;	/* Reuse the cluster hole */
        SUBS     R0,R10,#+1
        LDR      R1,[SP, #+0]
        STR      R0,[R1, #+12]
// 2378 						res = move_window(dj.fs, dw);
        MOV      R1,R9
        LDR      R0,[SP, #+0]
        BL       move_window
        MOV      R8,R0
        B.N      ??f_open_15
// 2379 					}
// 2380 				}
// 2381 			}
// 2382 		}
// 2383 		else {	/* Open an existing file */
// 2384 			if (res == FR_OK) {						/* Follow succeeded */
??f_open_8:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_open_15
// 2385 				if (dir[DIR_Attr] & AM_DIR) {		/* It is a directory */
        LDRB     R0,[R7, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_open_16
// 2386 					res = FR_NO_FILE;
        MOVS     R8,#+4
        B.N      ??f_open_15
// 2387 				} else {
// 2388 					if ((mode & FA_WRITE) && (dir[DIR_Attr] & AM_RDO)) /* R/O violation */
??f_open_16:
        LSLS     R0,R6,#+30
        BPL.N    ??f_open_15
        LDRB     R0,[R7, #+11]
        LSLS     R0,R0,#+31
        BPL.N    ??f_open_15
// 2389 						res = FR_DENIED;
        MOVS     R8,#+7
// 2390 				}
// 2391 			}
// 2392 		}
// 2393 		if (res == FR_OK) {
??f_open_15:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_open_17
// 2394 			if (mode & FA_CREATE_ALWAYS)			/* Set file change flag if created or overwritten */
        LSLS     R0,R6,#+28
        BPL.N    ??f_open_18
// 2395 				mode |= FA__WRITTEN;
        ORRS     R6,R6,#0x20
// 2396 			fp->dir_sect = dj.fs->winsect;			/* Pointer to the directory entry */
??f_open_18:
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+52]
        STR      R0,[R4, #+28]
// 2397 			fp->dir_ptr = dir;
        STR      R7,[R4, #+32]
// 2398 #if _FS_LOCK
// 2399 			fp->lockid = inc_lock(&dj, (mode & ~FA_READ) ? 1 : 0);
        MOVS     R0,#+254
        TST      R6,R0
        BEQ.N    ??f_open_19
        MOVS     R1,#+1
        B.N      ??f_open_20
??f_open_19:
        MOVS     R1,#+0
??f_open_20:
        ADD      R0,SP,#+0
        BL       inc_lock
        STR      R0,[R4, #+40]
// 2400 			if (!fp->lockid) res = FR_INT_ERR;
        LDR      R0,[R4, #+40]
        CMP      R0,#+0
        BNE.N    ??f_open_17
        MOVS     R8,#+2
// 2401 #endif
// 2402 		}
// 2403 
// 2404 #else				/* R/O configuration */
// 2405 		if (res == FR_OK) {					/* Follow succeeded */
// 2406 			dir = dj.dir;
// 2407 			if (!dir) {						/* Current dir itself */
// 2408 				res = FR_INVALID_NAME;
// 2409 			} else {
// 2410 				if (dir[DIR_Attr] & AM_DIR)	/* It is a directory */
// 2411 					res = FR_NO_FILE;
// 2412 			}
// 2413 		}
// 2414 #endif
// 2415 		FREE_BUF();
??f_open_17:
        MOVS     R0,R5
        BL       ff_memfree
// 2416 
// 2417 		if (res == FR_OK) {
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_open_2
// 2418 			fp->flag = mode;					/* File access mode */
        STRB     R6,[R4, #+6]
// 2419 			fp->sclust = ld_clust(dj.fs, dir);	/* File start cluster */
        MOVS     R1,R7
        LDR      R0,[SP, #+0]
        BL       ld_clust
        STR      R0,[R4, #+16]
// 2420 			fp->fsize = LD_DWORD(dir+DIR_FileSize);	/* File size */
        LDRB     R0,[R7, #+31]
        LDRB     R1,[R7, #+30]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R7, #+29]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R7, #+28]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+12]
// 2421 			fp->fptr = 0;						/* File pointer */
        MOVS     R0,#+0
        STR      R0,[R4, #+8]
// 2422 			fp->dsect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+24]
// 2423 #if _USE_FASTSEEK
// 2424 			fp->cltbl = 0;						/* Normal seek mode */
        MOVS     R0,#+0
        STR      R0,[R4, #+36]
// 2425 #endif
// 2426 			fp->fs = dj.fs; fp->id = dj.fs->id;	/* Validate file object */
        LDR      R0,[SP, #+0]
        STR      R0,[R4, #+0]
        LDR      R0,[SP, #+0]
        LDRH     R0,[R0, #+6]
        STRH     R0,[R4, #+4]
// 2427 		}
// 2428 	}
// 2429 
// 2430 	LEAVE_FF(dj.fs, res);
??f_open_2:
        MOV      R0,R8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_open_1:
        ADD      SP,SP,#+56
        POP      {R4-R10,PC}      ;; return
// 2431 }
// 2432 
// 2433 
// 2434 
// 2435 
// 2436 /*-----------------------------------------------------------------------*/
// 2437 /* Read File                                                             */
// 2438 /*-----------------------------------------------------------------------*/
// 2439 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2440 FRESULT f_read (
// 2441 	FIL *fp, 		/* Pointer to the file object */
// 2442 	void *buff,		/* Pointer to data buffer */
// 2443 	UINT btr,		/* Number of bytes to read */
// 2444 	UINT *br		/* Pointer to number of bytes read */
// 2445 )
// 2446 {
f_read:
        PUSH     {R4-R10,LR}
        MOVS     R5,R0
        MOVS     R6,R2
        MOVS     R7,R3
// 2447 	FRESULT res;
// 2448 	DWORD clst, sect, remain;
// 2449 	UINT rcnt, cc;
// 2450 	BYTE csect, *rbuff = (BYTE*)buff;
        MOVS     R4,R1
// 2451 
// 2452 
// 2453 	*br = 0;	/* Clear read byte counter */
        MOVS     R0,#+0
        STR      R0,[R7, #+0]
// 2454 
// 2455 	res = validate(fp);							/* Check validity */
        MOVS     R0,R5
        BL       validate
// 2456 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_read_0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_read_1
// 2457 	if (fp->flag & FA__ERROR)					/* Aborted file? */
??f_read_0:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_read_2
// 2458 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_read_1
// 2459 	if (!(fp->flag & FA_READ)) 					/* Check access mode */
??f_read_2:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+31
        BMI.N    ??f_read_3
// 2460 		LEAVE_FF(fp->fs, FR_DENIED);
        MOVS     R0,#+7
        B.N      ??f_read_1
// 2461 	remain = fp->fsize - fp->fptr;
??f_read_3:
        LDR      R0,[R5, #+12]
        LDR      R1,[R5, #+8]
        SUBS     R0,R0,R1
// 2462 	if (btr > remain) btr = (UINT)remain;		/* Truncate btr by remaining bytes */
        CMP      R0,R6
        BCS.N    ??f_read_4
        MOVS     R6,R0
        B.N      ??f_read_4
// 2463 
// 2464 	for ( ;  btr;								/* Repeat until all data read */
// 2465 		rbuff += rcnt, fp->fptr += rcnt, *br += rcnt, btr -= rcnt) {
// 2466 		if ((fp->fptr % SS(fp->fs)) == 0) {		/* On the sector boundary? */
// 2467 			csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 2468 			if (!csect) {						/* On the cluster boundary? */
// 2469 				if (fp->fptr == 0) {			/* On the top of the file? */
// 2470 					clst = fp->sclust;			/* Follow from the origin */
// 2471 				} else {						/* Middle or end of the file */
// 2472 #if _USE_FASTSEEK
// 2473 					if (fp->cltbl)
// 2474 						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
// 2475 					else
// 2476 #endif
// 2477 						clst = get_fat(fp->fs, fp->clust);	/* Follow cluster chain on the FAT */
// 2478 				}
// 2479 				if (clst < 2) ABORT(fp->fs, FR_INT_ERR);
// 2480 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2481 				fp->clust = clst;				/* Update current cluster */
// 2482 			}
// 2483 			sect = clust2sect(fp->fs, fp->clust);	/* Get current sector */
// 2484 			if (!sect) ABORT(fp->fs, FR_INT_ERR);
// 2485 			sect += csect;
// 2486 			cc = btr / SS(fp->fs);				/* When remaining bytes >= sector size, */
// 2487 			if (cc) {							/* Read maximum contiguous sectors directly */
// 2488 				if (csect + cc > fp->fs->csize)	/* Clip at cluster boundary */
// 2489 					cc = fp->fs->csize - csect;
// 2490 				if (disk_read(fp->fs->drv, rbuff, sect, (BYTE)cc) != RES_OK)
// 2491 					ABORT(fp->fs, FR_DISK_ERR);
// 2492 #if !_FS_READONLY && _FS_MINIMIZE <= 2			/* Replace one of the read sectors with cached data if it contains a dirty sector */
// 2493 #if _FS_TINY
// 2494 				if (fp->fs->wflag && fp->fs->winsect - sect < cc)
// 2495 					mem_cpy(rbuff + ((fp->fs->winsect - sect) * SS(fp->fs)), fp->fs->win, SS(fp->fs));
// 2496 #else
// 2497 				if ((fp->flag & FA__DIRTY) && fp->dsect - sect < cc)
// 2498 					mem_cpy(rbuff + ((fp->dsect - sect) * SS(fp->fs)), fp->buf, SS(fp->fs));
// 2499 #endif
// 2500 #endif
// 2501 				rcnt = SS(fp->fs) * cc;			/* Number of bytes transferred */
// 2502 				continue;
// 2503 			}
// 2504 #if !_FS_TINY
// 2505 			if (fp->dsect != sect) {			/* Load data sector if not in cache */
// 2506 #if !_FS_READONLY
// 2507 				if (fp->flag & FA__DIRTY) {		/* Write-back dirty sector cache */
// 2508 					if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
// 2509 						ABORT(fp->fs, FR_DISK_ERR);
// 2510 					fp->flag &= ~FA__DIRTY;
// 2511 				}
// 2512 #endif
// 2513 				if (disk_read(fp->fs->drv, fp->buf, sect, 1) != RES_OK)	/* Fill sector cache */
// 2514 					ABORT(fp->fs, FR_DISK_ERR);
// 2515 			}
// 2516 #endif
// 2517 			fp->dsect = sect;
??f_read_5:
        STR      R9,[R5, #+24]
// 2518 		}
// 2519 		rcnt = SS(fp->fs) - ((UINT)fp->fptr % SS(fp->fs));	/* Get partial sector data from sector buffer */
??f_read_6:
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        RSBS     R8,R2,#+512
// 2520 		if (rcnt > btr) rcnt = btr;
        CMP      R6,R8
        BCS.N    ??f_read_7
        MOV      R8,R6
// 2521 #if _FS_TINY
// 2522 		if (move_window(fp->fs, fp->dsect))		/* Move sector window */
// 2523 			ABORT(fp->fs, FR_DISK_ERR);
// 2524 		mem_cpy(rbuff, &fp->fs->win[fp->fptr % SS(fp->fs)], rcnt);	/* Pick partial sector */
// 2525 #else
// 2526 		mem_cpy(rbuff, &fp->buf[fp->fptr % SS(fp->fs)], rcnt);	/* Pick partial sector */
??f_read_7:
        MOV      R2,R8
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R3,R0,R1
        MLS      R3,R3,R1,R0
        ADDS     R0,R3,R5
        ADDS     R1,R0,#+44
        MOVS     R0,R4
        BL       mem_cpy
??f_read_8:
        ADDS     R4,R8,R4
        LDR      R0,[R5, #+8]
        ADDS     R0,R8,R0
        STR      R0,[R5, #+8]
        LDR      R0,[R7, #+0]
        ADDS     R0,R8,R0
        STR      R0,[R7, #+0]
        SUBS     R6,R6,R8
??f_read_4:
        CMP      R6,#+0
        BEQ.W    ??f_read_9
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BNE.N    ??f_read_6
        LDR      R0,[R5, #+8]
        LSRS     R0,R0,#+9
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        ANDS     R8,R1,R0
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_read_10
        LDR      R0,[R5, #+8]
        CMP      R0,#+0
        BNE.N    ??f_read_11
        LDR      R0,[R5, #+16]
        B.N      ??f_read_12
??f_read_11:
        LDR      R0,[R5, #+36]
        CMP      R0,#+0
        BEQ.N    ??f_read_13
        LDR      R1,[R5, #+8]
        MOVS     R0,R5
        BL       clmt_clust
        B.N      ??f_read_12
??f_read_13:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       get_fat
??f_read_12:
        CMP      R0,#+2
        BCS.N    ??f_read_14
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_read_1
??f_read_14:
        CMN      R0,#+1
        BNE.N    ??f_read_15
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_15:
        STR      R0,[R5, #+20]
??f_read_10:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOV      R9,R0
        CMP      R9,#+0
        BNE.N    ??f_read_16
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_read_1
??f_read_16:
        UXTAB    R9,R9,R8
        LSRS     R10,R6,#+9
        CMP      R10,#+0
        BEQ.N    ??f_read_17
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTAB    R1,R10,R8
        CMP      R0,R1
        BCS.N    ??f_read_18
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        SUBS     R10,R0,R8
??f_read_18:
        MOV      R3,R10
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOV      R2,R9
        MOVS     R1,R4
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??f_read_19
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_19:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_read_20
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        CMP      R0,R10
        BCS.N    ??f_read_20
        MOV      R2,#+512
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        MOV      R3,#+512
        MLA      R0,R3,R0,R4
        BL       mem_cpy
??f_read_20:
        MOV      R0,#+512
        MUL      R8,R0,R10
        B.N      ??f_read_8
??f_read_17:
        LDR      R0,[R5, #+24]
        CMP      R0,R9
        BEQ.W    ??f_read_5
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_read_21
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_read_22
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_22:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
??f_read_21:
        MOVS     R3,#+1
        MOV      R2,R9
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.W    ??f_read_5
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
// 2527 #endif
// 2528 	}
// 2529 
// 2530 	LEAVE_FF(fp->fs, FR_OK);
??f_read_9:
        MOVS     R0,#+0
??f_read_1:
        POP      {R4-R10,PC}      ;; return
// 2531 }
// 2532 
// 2533 
// 2534 
// 2535 
// 2536 #if !_FS_READONLY
// 2537 /*-----------------------------------------------------------------------*/
// 2538 /* Write File                                                            */
// 2539 /*-----------------------------------------------------------------------*/
// 2540 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2541 FRESULT f_write (
// 2542 	FIL *fp,			/* Pointer to the file object */
// 2543 	const void *buff,	/* Pointer to the data to be written */
// 2544 	UINT btw,			/* Number of bytes to write */
// 2545 	UINT *bw			/* Pointer to number of bytes written */
// 2546 )
// 2547 {
f_write:
        PUSH     {R4-R10,LR}
        MOVS     R5,R0
        MOVS     R6,R2
        MOVS     R7,R3
// 2548 	FRESULT res;
// 2549 	DWORD clst, sect;
// 2550 	UINT wcnt, cc;
// 2551 	const BYTE *wbuff = (const BYTE*)buff;
        MOVS     R4,R1
// 2552 	BYTE csect;
// 2553 
// 2554 
// 2555 	*bw = 0;	/* Clear write byte counter */
        MOVS     R0,#+0
        STR      R0,[R7, #+0]
// 2556 
// 2557 	res = validate(fp);						/* Check validity */
        MOVS     R0,R5
        BL       validate
// 2558 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_write_0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_write_1
// 2559 	if (fp->flag & FA__ERROR)				/* Aborted file? */
??f_write_0:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_write_2
// 2560 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_write_1
// 2561 	if (!(fp->flag & FA_WRITE))				/* Check access mode */
??f_write_2:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+30
        BMI.N    ??f_write_3
// 2562 		LEAVE_FF(fp->fs, FR_DENIED);
        MOVS     R0,#+7
        B.N      ??f_write_1
// 2563 	if ((DWORD)(fp->fsize + btw) < fp->fsize) btw = 0;	/* File size cannot reach 4GB */
??f_write_3:
        LDR      R0,[R5, #+12]
        ADDS     R0,R6,R0
        LDR      R1,[R5, #+12]
        CMP      R0,R1
        BCS.N    ??f_write_4
        MOVS     R6,#+0
        B.N      ??f_write_4
// 2564 
// 2565 	for ( ;  btw;							/* Repeat until all data written */
// 2566 		wbuff += wcnt, fp->fptr += wcnt, *bw += wcnt, btw -= wcnt) {
// 2567 		if ((fp->fptr % SS(fp->fs)) == 0) {	/* On the sector boundary? */
// 2568 			csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 2569 			if (!csect) {					/* On the cluster boundary? */
// 2570 				if (fp->fptr == 0) {		/* On the top of the file? */
// 2571 					clst = fp->sclust;		/* Follow from the origin */
// 2572 					if (clst == 0)			/* When no cluster is allocated, */
// 2573 						fp->sclust = clst = create_chain(fp->fs, 0);	/* Create a new cluster chain */
// 2574 				} else {					/* Middle or end of the file */
// 2575 #if _USE_FASTSEEK
// 2576 					if (fp->cltbl)
// 2577 						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
// 2578 					else
// 2579 #endif
// 2580 						clst = create_chain(fp->fs, fp->clust);	/* Follow or stretch cluster chain on the FAT */
// 2581 				}
// 2582 				if (clst == 0) break;		/* Could not allocate a new cluster (disk full) */
// 2583 				if (clst == 1) ABORT(fp->fs, FR_INT_ERR);
// 2584 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2585 				fp->clust = clst;			/* Update current cluster */
// 2586 			}
// 2587 #if _FS_TINY
// 2588 			if (fp->fs->winsect == fp->dsect && sync_window(fp->fs))	/* Write-back sector cache */
// 2589 				ABORT(fp->fs, FR_DISK_ERR);
// 2590 #else
// 2591 			if (fp->flag & FA__DIRTY) {		/* Write-back sector cache */
// 2592 				if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
// 2593 					ABORT(fp->fs, FR_DISK_ERR);
// 2594 				fp->flag &= ~FA__DIRTY;
// 2595 			}
// 2596 #endif
// 2597 			sect = clust2sect(fp->fs, fp->clust);	/* Get current sector */
// 2598 			if (!sect) ABORT(fp->fs, FR_INT_ERR);
// 2599 			sect += csect;
// 2600 			cc = btw / SS(fp->fs);			/* When remaining bytes >= sector size, */
// 2601 			if (cc) {						/* Write maximum contiguous sectors directly */
// 2602 				if (csect + cc > fp->fs->csize)	/* Clip at cluster boundary */
// 2603 					cc = fp->fs->csize - csect;
// 2604 				if (disk_write(fp->fs->drv, wbuff, sect, (BYTE)cc) != RES_OK)
// 2605 					ABORT(fp->fs, FR_DISK_ERR);
// 2606 #if _FS_TINY
// 2607 				if (fp->fs->winsect - sect < cc) {	/* Refill sector cache if it gets invalidated by the direct write */
// 2608 					mem_cpy(fp->fs->win, wbuff + ((fp->fs->winsect - sect) * SS(fp->fs)), SS(fp->fs));
// 2609 					fp->fs->wflag = 0;
// 2610 				}
// 2611 #else
// 2612 				if (fp->dsect - sect < cc) { /* Refill sector cache if it gets invalidated by the direct write */
// 2613 					mem_cpy(fp->buf, wbuff + ((fp->dsect - sect) * SS(fp->fs)), SS(fp->fs));
// 2614 					fp->flag &= ~FA__DIRTY;
// 2615 				}
// 2616 #endif
// 2617 				wcnt = SS(fp->fs) * cc;		/* Number of bytes transferred */
// 2618 				continue;
// 2619 			}
// 2620 #if _FS_TINY
// 2621 			if (fp->fptr >= fp->fsize) {	/* Avoid silly cache filling at growing edge */
// 2622 				if (sync_window(fp->fs)) ABORT(fp->fs, FR_DISK_ERR);
// 2623 				fp->fs->winsect = sect;
// 2624 			}
// 2625 #else
// 2626 			if (fp->dsect != sect) {		/* Fill sector cache with file data */
// 2627 				if (fp->fptr < fp->fsize &&
// 2628 					disk_read(fp->fs->drv, fp->buf, sect, 1) != RES_OK)
// 2629 						ABORT(fp->fs, FR_DISK_ERR);
// 2630 			}
// 2631 #endif
// 2632 			fp->dsect = sect;
??f_write_5:
        STR      R9,[R5, #+24]
// 2633 		}
// 2634 		wcnt = SS(fp->fs) - ((UINT)fp->fptr % SS(fp->fs));/* Put partial sector into file I/O buffer */
??f_write_6:
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        RSBS     R8,R2,#+512
// 2635 		if (wcnt > btw) wcnt = btw;
        CMP      R6,R8
        BCS.N    ??f_write_7
        MOV      R8,R6
// 2636 #if _FS_TINY
// 2637 		if (move_window(fp->fs, fp->dsect))	/* Move sector window */
// 2638 			ABORT(fp->fs, FR_DISK_ERR);
// 2639 		mem_cpy(&fp->fs->win[fp->fptr % SS(fp->fs)], wbuff, wcnt);	/* Fit partial sector */
// 2640 		fp->fs->wflag = 1;
// 2641 #else
// 2642 		mem_cpy(&fp->buf[fp->fptr % SS(fp->fs)], wbuff, wcnt);	/* Fit partial sector */
??f_write_7:
        MOV      R2,R8
        MOVS     R1,R4
        LDR      R0,[R5, #+8]
        MOV      R3,#+512
        UDIV     R12,R0,R3
        MLS      R12,R12,R3,R0
        ADDS     R0,R12,R5
        ADDS     R0,R0,#+44
        BL       mem_cpy
// 2643 		fp->flag |= FA__DIRTY;
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x40
        STRB     R0,[R5, #+6]
??f_write_8:
        ADDS     R4,R8,R4
        LDR      R0,[R5, #+8]
        ADDS     R0,R8,R0
        STR      R0,[R5, #+8]
        LDR      R0,[R7, #+0]
        ADDS     R0,R8,R0
        STR      R0,[R7, #+0]
        SUBS     R6,R6,R8
??f_write_4:
        CMP      R6,#+0
        BEQ.N    ??f_write_9
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BNE.N    ??f_write_6
        LDR      R0,[R5, #+8]
        LSRS     R0,R0,#+9
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        ANDS     R8,R1,R0
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_write_10
        LDR      R0,[R5, #+8]
        CMP      R0,#+0
        BNE.N    ??f_write_11
        LDR      R0,[R5, #+16]
        CMP      R0,#+0
        BNE.N    ??f_write_12
        MOVS     R1,#+0
        LDR      R0,[R5, #+0]
        BL       create_chain
        STR      R0,[R5, #+16]
        B.N      ??f_write_12
??f_write_11:
        LDR      R0,[R5, #+36]
        CMP      R0,#+0
        BEQ.N    ??f_write_13
        LDR      R1,[R5, #+8]
        MOVS     R0,R5
        BL       clmt_clust
        B.N      ??f_write_12
??f_write_13:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       create_chain
??f_write_12:
        CMP      R0,#+0
        BNE.N    ??f_write_14
// 2644 #endif
// 2645 	}
// 2646 
// 2647 	if (fp->fptr > fp->fsize) fp->fsize = fp->fptr;	/* Update file size if needed */
??f_write_9:
        LDR      R0,[R5, #+12]
        LDR      R1,[R5, #+8]
        CMP      R0,R1
        BCS.N    ??f_write_15
        LDR      R0,[R5, #+8]
        STR      R0,[R5, #+12]
// 2648 	fp->flag |= FA__WRITTEN;						/* Set file change flag */
??f_write_15:
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+6]
// 2649 
// 2650 	LEAVE_FF(fp->fs, FR_OK);
        MOVS     R0,#+0
??f_write_1:
        POP      {R4-R10,PC}      ;; return
??f_write_14:
        CMP      R0,#+1
        BNE.N    ??f_write_16
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_write_1
??f_write_16:
        CMN      R0,#+1
        BNE.N    ??f_write_17
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_17:
        STR      R0,[R5, #+20]
??f_write_10:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_write_18
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_write_19
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_19:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
??f_write_18:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOV      R9,R0
        CMP      R9,#+0
        BNE.N    ??f_write_20
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_write_1
??f_write_20:
        UXTAB    R9,R9,R8
        LSRS     R10,R6,#+9
        CMP      R10,#+0
        BEQ.N    ??f_write_21
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTAB    R1,R10,R8
        CMP      R0,R1
        BCS.N    ??f_write_22
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        SUBS     R10,R0,R8
??f_write_22:
        MOV      R3,R10
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOV      R2,R9
        MOVS     R1,R4
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_write_23
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_23:
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        CMP      R0,R10
        BCS.N    ??f_write_24
        MOV      R2,#+512
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        MOV      R1,#+512
        MLA      R1,R1,R0,R4
        ADDS     R0,R5,#+44
        BL       mem_cpy
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
??f_write_24:
        MOV      R0,#+512
        MUL      R8,R0,R10
        B.N      ??f_write_8
??f_write_21:
        LDR      R0,[R5, #+24]
        CMP      R0,R9
        BEQ.W    ??f_write_5
        LDR      R0,[R5, #+8]
        LDR      R1,[R5, #+12]
        CMP      R0,R1
        BCS.W    ??f_write_5
        MOVS     R3,#+1
        MOV      R2,R9
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.W    ??f_write_5
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
// 2651 }
// 2652 
// 2653 
// 2654 
// 2655 
// 2656 /*-----------------------------------------------------------------------*/
// 2657 /* Synchronize the File Object                                           */
// 2658 /*-----------------------------------------------------------------------*/
// 2659 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2660 FRESULT f_sync (
// 2661 	FIL *fp		/* Pointer to the file object */
// 2662 )
// 2663 {
f_sync:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 2664 	FRESULT res;
// 2665 	DWORD tm;
// 2666 	BYTE *dir;
// 2667 
// 2668 
// 2669 	res = validate(fp);					/* Check validity of the object */
        MOVS     R0,R4
        BL       validate
// 2670 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_sync_0
// 2671 		if (fp->flag & FA__WRITTEN) {	/* Has the file been written? */
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+26
        BPL.N    ??f_sync_0
// 2672 #if !_FS_TINY	/* Write-back dirty buffer */
// 2673 			if (fp->flag & FA__DIRTY) {
        LDRB     R0,[R4, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_sync_1
// 2674 				if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R4, #+24]
        ADDS     R1,R4,#+44
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_sync_2
// 2675 					LEAVE_FF(fp->fs, FR_DISK_ERR);
        MOVS     R0,#+1
        B.N      ??f_sync_3
// 2676 				fp->flag &= ~FA__DIRTY;
??f_sync_2:
        LDRB     R0,[R4, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R4, #+6]
// 2677 			}
// 2678 #endif
// 2679 			/* Update the directory entry */
// 2680 			res = move_window(fp->fs, fp->dir_sect);
??f_sync_1:
        LDR      R1,[R4, #+28]
        LDR      R0,[R4, #+0]
        BL       move_window
// 2681 			if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_sync_0
// 2682 				dir = fp->dir_ptr;
        LDR      R5,[R4, #+32]
// 2683 				dir[DIR_Attr] |= AM_ARC;					/* Set archive bit */
        LDRB     R0,[R5, #+11]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+11]
// 2684 				ST_DWORD(dir+DIR_FileSize, fp->fsize);		/* Update file size */
        LDR      R0,[R4, #+12]
        STRB     R0,[R5, #+28]
        LDR      R0,[R4, #+12]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+29]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+30]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+31]
// 2685 				st_clust(dir, fp->sclust);					/* Update start cluster */
        LDR      R1,[R4, #+16]
        MOVS     R0,R5
        BL       st_clust
// 2686 				tm = get_fattime();							/* Update updated time */
        BL       get_fattime
// 2687 				ST_DWORD(dir+DIR_WrtTime, tm);
        STRB     R0,[R5, #+22]
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R5, #+23]
        LSRS     R1,R0,#+16
        STRB     R1,[R5, #+24]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+25]
// 2688 				ST_WORD(dir+DIR_LstAccDate, 0);
        MOVS     R0,#+0
        STRB     R0,[R5, #+18]
        MOVS     R0,#+0
        STRB     R0,[R5, #+19]
// 2689 				fp->flag &= ~FA__WRITTEN;
        LDRB     R0,[R4, #+6]
        ANDS     R0,R0,#0xDF
        STRB     R0,[R4, #+6]
// 2690 				fp->fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+4]
// 2691 				res = sync_fs(fp->fs);
        LDR      R0,[R4, #+0]
        BL       sync_fs
// 2692 			}
// 2693 		}
// 2694 	}
// 2695 
// 2696 	LEAVE_FF(fp->fs, res);
??f_sync_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_sync_3:
        POP      {R1,R4,R5,PC}    ;; return
// 2697 }
// 2698 
// 2699 #endif /* !_FS_READONLY */
// 2700 
// 2701 
// 2702 
// 2703 
// 2704 /*-----------------------------------------------------------------------*/
// 2705 /* Close File                                                            */
// 2706 /*-----------------------------------------------------------------------*/
// 2707 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2708 FRESULT f_close (
// 2709 	FIL *fp		/* Pointer to the file object to be closed */
// 2710 )
// 2711 {
f_close:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 2712 	FRESULT res;
// 2713 
// 2714 
// 2715 #if _FS_READONLY
// 2716 	res = validate(fp);
// 2717 	{
// 2718 #if _FS_REENTRANT
// 2719 		FATFS *fs = fp->fs;
// 2720 #endif
// 2721 		if (res == FR_OK) fp->fs = 0;	/* Discard file object */
// 2722 		LEAVE_FF(fs, res);
// 2723 	}
// 2724 #else
// 2725 	res = f_sync(fp);		/* Flush cached data */
        MOVS     R0,R4
        BL       f_sync
// 2726 #if _FS_LOCK
// 2727 	if (res == FR_OK) {		/* Decrement open counter */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_close_0
// 2728 #if _FS_REENTRANT
// 2729 		FATFS *fs = fp->fs;;
// 2730 		res = validate(fp);
// 2731 		if (res == FR_OK) {
// 2732 			res = dec_lock(fp->lockid);	
// 2733 			unlock_fs(fs, FR_OK);
// 2734 		}
// 2735 #else
// 2736 		res = dec_lock(fp->lockid);
        LDR      R0,[R4, #+40]
        BL       dec_lock
// 2737 #endif
// 2738 	}
// 2739 #endif
// 2740 	if (res == FR_OK) fp->fs = 0;	/* Discard file object */
??f_close_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_close_1
        MOVS     R1,#+0
        STR      R1,[R4, #+0]
// 2741 	return res;
??f_close_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
// 2742 #endif
// 2743 }
// 2744 
// 2745 
// 2746 
// 2747 
// 2748 /*-----------------------------------------------------------------------*/
// 2749 /* Current Drive/Directory Handlings                                     */
// 2750 /*-----------------------------------------------------------------------*/
// 2751 
// 2752 #if _FS_RPATH >= 1
// 2753 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2754 FRESULT f_chdrive (
// 2755 	BYTE drv		/* Drive number */
// 2756 )
// 2757 {
// 2758 	if (drv >= _VOLUMES) return FR_INVALID_DRIVE;
f_chdrive:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_chdrive_0
        MOVS     R0,#+11
        B.N      ??f_chdrive_1
// 2759 
// 2760 	CurrVol = drv;
??f_chdrive_0:
        LDR.N    R1,??DataTable13_1
        STRB     R0,[R1, #+0]
// 2761 
// 2762 	return FR_OK;
        MOVS     R0,#+0
??f_chdrive_1:
        BX       LR               ;; return
// 2763 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12:
        DC32     ?_1
// 2764 
// 2765 
// 2766 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2767 FRESULT f_chdir (
// 2768 	const TCHAR *path	/* Pointer to the directory path */
// 2769 )
// 2770 {
f_chdir:
        PUSH     {R0,R4,R5,LR}
        SUB      SP,SP,#+48
// 2771 	FRESULT res;
// 2772 	DIR dj;
// 2773 	DEF_NAMEBUF;
// 2774 
// 2775 
// 2776 	res = chk_mounted(&path, &dj.fs, 0);
        MOVS     R2,#+0
        ADD      R1,SP,#+0
        ADD      R0,SP,#+48
        BL       chk_mounted
        MOVS     R4,R0
// 2777 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_chdir_0
// 2778 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_chdir_1
        MOVS     R0,#+17
        B.N      ??f_chdir_2
??f_chdir_1:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 2779 		res = follow_path(&dj, path);		/* Follow the path */
        LDR      R1,[SP, #+48]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R4,R0
// 2780 		FREE_BUF();
        MOVS     R0,R5
        BL       ff_memfree
// 2781 		if (res == FR_OK) {					/* Follow completed */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_chdir_3
// 2782 			if (!dj.dir) {
        LDR      R0,[SP, #+20]
        CMP      R0,#+0
        BNE.N    ??f_chdir_4
// 2783 				dj.fs->cdir = dj.sclust;	/* Start directory itself */
        LDR      R0,[SP, #+8]
        LDR      R1,[SP, #+0]
        STR      R0,[R1, #+24]
        B.N      ??f_chdir_3
// 2784 			} else {
// 2785 				if (dj.dir[DIR_Attr] & AM_DIR)	/* Reached to the directory */
??f_chdir_4:
        LDR      R0,[SP, #+20]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_chdir_5
// 2786 					dj.fs->cdir = ld_clust(dj.fs, dj.dir);
        LDR      R1,[SP, #+20]
        LDR      R0,[SP, #+0]
        BL       ld_clust
        LDR      R1,[SP, #+0]
        STR      R0,[R1, #+24]
        B.N      ??f_chdir_3
// 2787 				else
// 2788 					res = FR_NO_PATH;		/* Reached but a file */
??f_chdir_5:
        MOVS     R4,#+5
// 2789 			}
// 2790 		}
// 2791 		if (res == FR_NO_FILE) res = FR_NO_PATH;
??f_chdir_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BNE.N    ??f_chdir_0
        MOVS     R4,#+5
// 2792 	}
// 2793 
// 2794 	LEAVE_FF(dj.fs, res);
??f_chdir_0:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_chdir_2:
        ADD      SP,SP,#+52
        POP      {R4,R5,PC}       ;; return
// 2795 }
// 2796 
// 2797 
// 2798 #if _FS_RPATH >= 2

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2799 FRESULT f_getcwd (
// 2800 	TCHAR *buff,	/* Pointer to the directory path */
// 2801 	UINT len		/* Size of path */
// 2802 )
// 2803 {
f_getcwd:
        PUSH     {R0,R4-R8,LR}
        SUB      SP,SP,#+84
        MOVS     R4,R1
// 2804 	FRESULT res;
// 2805 	DIR dj;
// 2806 	UINT i, n;
// 2807 	DWORD ccl;
// 2808 	TCHAR *tp;
// 2809 	FILINFO fno;
// 2810 	DEF_NAMEBUF;
// 2811 
// 2812 
// 2813 	*buff = 0;
        MOVS     R0,#+0
        LDR      R1,[SP, #+84]
        STRB     R0,[R1, #+0]
// 2814 	res = chk_mounted((const TCHAR**)&buff, &dj.fs, 0);	/* Get current volume */
        MOVS     R2,#+0
        ADD      R1,SP,#+0
        ADD      R0,SP,#+84
        BL       chk_mounted
        MOVS     R6,R0
// 2815 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.W    ??f_getcwd_0
// 2816 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_getcwd_1
        MOVS     R0,#+17
        B.N      ??f_getcwd_2
??f_getcwd_1:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 2817 		i = len;			/* Bottom of buffer (dir stack base) */
        MOVS     R7,R4
// 2818 		dj.sclust = dj.fs->cdir;			/* Start to follow upper dir from current dir */
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        STR      R0,[SP, #+8]
        B.N      ??f_getcwd_3
// 2819 		while ((ccl = dj.sclust) != 0) {	/* Repeat while current dir is a sub-dir */
// 2820 			res = dir_sdi(&dj, 1);			/* Get parent dir */
// 2821 			if (res != FR_OK) break;
// 2822 			res = dir_read(&dj, 0);
// 2823 			if (res != FR_OK) break;
// 2824 			dj.sclust = ld_clust(dj.fs, dj.dir);	/* Goto parent dir */
// 2825 			res = dir_sdi(&dj, 0);
// 2826 			if (res != FR_OK) break;
// 2827 			do {							/* Find the entry links to the child dir */
// 2828 				res = dir_read(&dj, 0);
// 2829 				if (res != FR_OK) break;
// 2830 				if (ccl == ld_clust(dj.fs, dj.dir)) break;	/* Found the entry */
// 2831 				res = dir_next(&dj, 0);	
// 2832 			} while (res == FR_OK);
// 2833 			if (res == FR_NO_FILE) res = FR_INT_ERR;/* It cannot be 'not found'. */
// 2834 			if (res != FR_OK) break;
// 2835 #if _USE_LFN
// 2836 			fno.lfname = buff;
// 2837 			fno.lfsize = i;
// 2838 #endif
// 2839 			get_fileinfo(&dj, &fno);		/* Get the dir name and push it to the buffer */
// 2840 			tp = fno.fname;
// 2841 			if (_USE_LFN && *buff) tp = buff;
// 2842 			for (n = 0; tp[n]; n++) ;
// 2843 			if (i < n + 3) {
// 2844 				res = FR_NOT_ENOUGH_CORE; break;
// 2845 			}
// 2846 			while (n) buff[--i] = tp[--n];
??f_getcwd_4:
        SUBS     R7,R7,#+1
        SUBS     R1,R1,#+1
        LDRB     R2,[R1, R0]
        LDR      R3,[SP, #+84]
        STRB     R2,[R7, R3]
??f_getcwd_5:
        CMP      R1,#+0
        BNE.N    ??f_getcwd_4
// 2847 			buff[--i] = '/';
        SUBS     R7,R7,#+1
        MOVS     R0,#+47
        LDR      R1,[SP, #+84]
        STRB     R0,[R7, R1]
??f_getcwd_3:
        LDR      R8,[SP, #+8]
        CMP      R8,#+0
        BEQ.N    ??f_getcwd_6
        MOVS     R1,#+1
        ADD      R0,SP,#+0
        BL       dir_sdi
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_7:
        MOVS     R1,#+0
        ADD      R0,SP,#+0
        BL       dir_read
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_8:
        LDR      R1,[SP, #+20]
        LDR      R0,[SP, #+0]
        BL       ld_clust
        STR      R0,[SP, #+8]
        MOVS     R1,#+0
        ADD      R0,SP,#+0
        BL       dir_sdi
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_9:
        MOVS     R1,#+0
        ADD      R0,SP,#+0
        BL       dir_read
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_10
??f_getcwd_11:
        LDR      R1,[SP, #+20]
        LDR      R0,[SP, #+0]
        BL       ld_clust
        CMP      R8,R0
        BEQ.N    ??f_getcwd_10
??f_getcwd_12:
        MOVS     R1,#+0
        ADD      R0,SP,#+0
        BL       dir_next
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??f_getcwd_9
??f_getcwd_10:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_getcwd_13
        MOVS     R6,#+2
??f_getcwd_13:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_14:
        LDR      R0,[SP, #+84]
        STR      R0,[SP, #+72]
        STR      R7,[SP, #+76]
        ADD      R1,SP,#+48
        ADD      R0,SP,#+0
        BL       get_fileinfo
        ADD      R0,SP,#+57
        LDR      R1,[SP, #+84]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        BEQ.N    ??f_getcwd_15
        LDR      R0,[SP, #+84]
??f_getcwd_15:
        MOVS     R1,#+0
        B.N      ??f_getcwd_16
??f_getcwd_17:
        ADDS     R1,R1,#+1
??f_getcwd_16:
        LDRB     R2,[R1, R0]
        CMP      R2,#+0
        BNE.N    ??f_getcwd_17
        ADDS     R2,R1,#+3
        CMP      R7,R2
        BCS.N    ??f_getcwd_5
        MOVS     R6,#+17
// 2848 		}
// 2849 		tp = buff;
??f_getcwd_6:
        LDR      R0,[SP, #+84]
// 2850 		if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_18
// 2851 			*tp++ = '0' + CurrVol;			/* Put drive number */
        LDR.N    R1,??DataTable13_1
        LDRB     R1,[R1, #+0]
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
// 2852 			*tp++ = ':';
        MOVS     R1,#+58
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
// 2853 			if (i == len) {					/* Root-dir */
        CMP      R7,R4
        BNE.N    ??f_getcwd_19
// 2854 				*tp++ = '/';
        MOVS     R1,#+47
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
        B.N      ??f_getcwd_18
// 2855 			} else {						/* Sub-dir */
// 2856 				do		/* Add stacked path str */
// 2857 					*tp++ = buff[i++];
??f_getcwd_19:
        LDR      R1,[SP, #+84]
        LDRB     R1,[R7, R1]
        STRB     R1,[R0, #+0]
        ADDS     R7,R7,#+1
        ADDS     R0,R0,#+1
// 2858 				while (i < len);
        CMP      R7,R4
        BCC.N    ??f_getcwd_19
// 2859 			}
// 2860 		}
// 2861 		*tp = 0;
??f_getcwd_18:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
// 2862 		FREE_BUF();
        MOVS     R0,R5
        BL       ff_memfree
// 2863 	}
// 2864 
// 2865 	LEAVE_FF(dj.fs, res);
??f_getcwd_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_getcwd_2:
        ADD      SP,SP,#+88
        POP      {R4-R8,PC}       ;; return
// 2866 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13:
        DC32     0x544146

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_1:
        DC32     CurrVol

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_2:
        DC32     FatFs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_3:
        DC32     0x41615252

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_4:
        DC32     0x61417272

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_5:
        DC32     Fsid
// 2867 #endif /* _FS_RPATH >= 2 */
// 2868 #endif /* _FS_RPATH >= 1 */
// 2869 
// 2870 
// 2871 
// 2872 #if _FS_MINIMIZE <= 2
// 2873 /*-----------------------------------------------------------------------*/
// 2874 /* Seek File R/W Pointer                                                 */
// 2875 /*-----------------------------------------------------------------------*/
// 2876 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2877 FRESULT f_lseek (
// 2878 	FIL *fp,		/* Pointer to the file object */
// 2879 	DWORD ofs		/* File pointer from top of file */
// 2880 )
// 2881 {
f_lseek:
        PUSH     {R3-R11,LR}
        MOVS     R5,R0
        MOVS     R6,R1
// 2882 	FRESULT res;
// 2883 
// 2884 
// 2885 	res = validate(fp);					/* Check validity of the object */
        MOVS     R0,R5
        BL       validate
        MOVS     R4,R0
// 2886 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??f_lseek_0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_lseek_1
// 2887 	if (fp->flag & FA__ERROR)			/* Check abort flag */
??f_lseek_0:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_lseek_2
// 2888 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2889 
// 2890 #if _USE_FASTSEEK
// 2891 	if (fp->cltbl) {	/* Fast seek */
??f_lseek_2:
        LDR      R0,[R5, #+36]
        CMP      R0,#+0
        BEQ.W    ??f_lseek_3
// 2892 		DWORD cl, pcl, ncl, tcl, dsc, tlen, ulen, *tbl;
// 2893 
// 2894 		if (ofs == CREATE_LINKMAP) {	/* Create CLMT */
        CMN      R6,#+1
        BNE.N    ??f_lseek_4
// 2895 			tbl = fp->cltbl;
        LDR      R10,[R5, #+36]
// 2896 			tlen = *tbl++; ulen = 2;	/* Given table size and required table size */
        LDR      R8,[R10, #+0]
        ADDS     R10,R10,#+4
        MOVS     R9,#+2
// 2897 			cl = fp->sclust;			/* Top of the chain */
        LDR      R0,[R5, #+16]
// 2898 			if (cl) {
        CMP      R0,#+0
        BEQ.N    ??f_lseek_5
// 2899 				do {
// 2900 					/* Get a fragment */
// 2901 					tcl = cl; ncl = 0; ulen += 2;	/* Top, length and used items */
??f_lseek_6:
        MOVS     R7,R0
        MOVS     R6,#+0
        ADDS     R9,R9,#+2
// 2902 					do {
// 2903 						pcl = cl; ncl++;
??f_lseek_7:
        MOV      R11,R0
        ADDS     R6,R6,#+1
// 2904 						cl = get_fat(fp->fs, cl);
        MOVS     R1,R0
        LDR      R0,[R5, #+0]
        BL       get_fat
// 2905 						if (cl <= 1) ABORT(fp->fs, FR_INT_ERR);
        CMP      R0,#+2
        BCS.N    ??f_lseek_8
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2906 						if (cl == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
??f_lseek_8:
        CMN      R0,#+1
        BNE.N    ??f_lseek_9
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2907 					} while (cl == pcl + 1);
??f_lseek_9:
        ADDS     R1,R11,#+1
        CMP      R0,R1
        BEQ.N    ??f_lseek_7
// 2908 					if (ulen <= tlen) {		/* Store the length and top of the fragment */
        CMP      R8,R9
        BCC.N    ??f_lseek_10
// 2909 						*tbl++ = ncl; *tbl++ = tcl;
        STR      R6,[R10, #+0]
        ADDS     R10,R10,#+4
        STR      R7,[R10, #+0]
        ADDS     R10,R10,#+4
// 2910 					}
// 2911 				} while (cl < fp->fs->n_fatent);	/* Repeat until end of chain */
??f_lseek_10:
        LDR      R1,[R5, #+0]
        LDR      R1,[R1, #+28]
        CMP      R0,R1
        BCC.N    ??f_lseek_6
// 2912 			}
// 2913 			*fp->cltbl = ulen;	/* Number of items used */
??f_lseek_5:
        LDR      R0,[R5, #+36]
        STR      R9,[R0, #+0]
// 2914 			if (ulen <= tlen)
        CMP      R8,R9
        BCC.N    ??f_lseek_11
// 2915 				*tbl = 0;		/* Terminate table */
        MOVS     R0,#+0
        STR      R0,[R10, #+0]
        B.N      ??f_lseek_12
// 2916 			else
// 2917 				res = FR_NOT_ENOUGH_CORE;	/* Given table size is smaller than required */
??f_lseek_11:
        MOVS     R4,#+17
        B.N      ??f_lseek_12
// 2918 
// 2919 		} else {						/* Fast seek */
// 2920 			if (ofs > fp->fsize)		/* Clip offset at the file size */
??f_lseek_4:
        LDR      R0,[R5, #+12]
        CMP      R0,R6
        BCS.N    ??f_lseek_13
// 2921 				ofs = fp->fsize;
        LDR      R6,[R5, #+12]
// 2922 			fp->fptr = ofs;				/* Set file pointer */
??f_lseek_13:
        STR      R6,[R5, #+8]
// 2923 			if (ofs) {
        CMP      R6,#+0
        BEQ.W    ??f_lseek_12
// 2924 				fp->clust = clmt_clust(fp, ofs - 1);
        SUBS     R1,R6,#+1
        MOVS     R0,R5
        BL       clmt_clust
        STR      R0,[R5, #+20]
// 2925 				dsc = clust2sect(fp->fs, fp->clust);
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOVS     R7,R0
// 2926 				if (!dsc) ABORT(fp->fs, FR_INT_ERR);
        CMP      R7,#+0
        BNE.N    ??f_lseek_14
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2927 				dsc += (ofs - 1) / SS(fp->fs) & (fp->fs->csize - 1);
??f_lseek_14:
        SUBS     R0,R6,#+1
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        ANDS     R0,R1,R0, LSR #+9
        ADDS     R7,R0,R7
// 2928 				if (fp->fptr % SS(fp->fs) && dsc != fp->dsect) {	/* Refill sector cache if needed */
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BEQ.W    ??f_lseek_12
        LDR      R0,[R5, #+24]
        CMP      R7,R0
        BEQ.W    ??f_lseek_12
// 2929 #if !_FS_TINY
// 2930 #if !_FS_READONLY
// 2931 					if (fp->flag & FA__DIRTY) {		/* Write-back dirty sector cache */
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_lseek_15
// 2932 						if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_lseek_16
// 2933 							ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2934 						fp->flag &= ~FA__DIRTY;
??f_lseek_16:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
// 2935 					}
// 2936 #endif
// 2937 					if (disk_read(fp->fs->drv, fp->buf, dsc, 1) != RES_OK)	/* Load current sector */
??f_lseek_15:
        MOVS     R3,#+1
        MOVS     R2,R7
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??f_lseek_17
// 2938 						ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2939 #endif
// 2940 					fp->dsect = dsc;
??f_lseek_17:
        STR      R7,[R5, #+24]
        B.N      ??f_lseek_12
// 2941 				}
// 2942 			}
// 2943 		}
// 2944 	} else
// 2945 #endif
// 2946 
// 2947 	/* Normal Seek */
// 2948 	{
// 2949 		DWORD clst, bcs, nsect, ifptr;
// 2950 
// 2951 		if (ofs > fp->fsize					/* In read-only mode, clip offset with the file size */
// 2952 #if !_FS_READONLY
// 2953 			 && !(fp->flag & FA_WRITE)
// 2954 #endif
// 2955 			) ofs = fp->fsize;
??f_lseek_3:
        LDR      R0,[R5, #+12]
        CMP      R0,R6
        BCS.N    ??f_lseek_18
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+30
        BMI.N    ??f_lseek_18
        LDR      R6,[R5, #+12]
// 2956 
// 2957 		ifptr = fp->fptr;
??f_lseek_18:
        LDR      R0,[R5, #+8]
// 2958 		fp->fptr = nsect = 0;
        MOVS     R7,#+0
        STR      R7,[R5, #+8]
// 2959 		if (ofs) {
        CMP      R6,#+0
        BEQ.N    ??f_lseek_19
// 2960 			bcs = (DWORD)fp->fs->csize * SS(fp->fs);	/* Cluster size (byte) */
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        MOV      R2,#+512
        MUL      R8,R2,R1
// 2961 			if (ifptr > 0 &&
// 2962 				(ofs - 1) / bcs >= (ifptr - 1) / bcs) {	/* When seek to same or following cluster, */
        CMP      R0,#+0
        BEQ.N    ??f_lseek_20
        SUBS     R1,R0,#+1
        UDIV     R1,R1,R8
        SUBS     R2,R6,#+1
        UDIV     R2,R2,R8
        CMP      R2,R1
        BCC.N    ??f_lseek_20
// 2963 				fp->fptr = (ifptr - 1) & ~(bcs - 1);	/* start from the current cluster */
        SUBS     R0,R0,#+1
        SUBS     R1,R8,#+1
        BICS     R0,R0,R1
        STR      R0,[R5, #+8]
// 2964 				ofs -= fp->fptr;
        LDR      R0,[R5, #+8]
        SUBS     R6,R6,R0
// 2965 				clst = fp->clust;
        LDR      R1,[R5, #+20]
        B.N      ??f_lseek_21
// 2966 			} else {									/* When seek to back cluster, */
// 2967 				clst = fp->sclust;						/* start from the first cluster */
??f_lseek_20:
        LDR      R1,[R5, #+16]
// 2968 #if !_FS_READONLY
// 2969 				if (clst == 0) {						/* If no cluster chain, create a new chain */
        CMP      R1,#+0
        BNE.N    ??f_lseek_22
// 2970 					clst = create_chain(fp->fs, 0);
        MOVS     R1,#+0
        LDR      R0,[R5, #+0]
        BL       create_chain
        MOVS     R1,R0
// 2971 					if (clst == 1) ABORT(fp->fs, FR_INT_ERR);
        CMP      R1,#+1
        BNE.N    ??f_lseek_23
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2972 					if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
??f_lseek_23:
        CMN      R1,#+1
        BNE.N    ??f_lseek_24
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2973 					fp->sclust = clst;
??f_lseek_24:
        STR      R1,[R5, #+16]
// 2974 				}
// 2975 #endif
// 2976 				fp->clust = clst;
??f_lseek_22:
        STR      R1,[R5, #+20]
// 2977 			}
// 2978 			if (clst != 0) {
??f_lseek_21:
        CMP      R1,#+0
        BNE.N    ??f_lseek_25
        B.N      ??f_lseek_19
// 2979 				while (ofs > bcs) {						/* Cluster following loop */
// 2980 #if !_FS_READONLY
// 2981 					if (fp->flag & FA_WRITE) {			/* Check if in write mode or not */
// 2982 						clst = create_chain(fp->fs, clst);	/* Force stretch if in write mode */
// 2983 						if (clst == 0) {				/* When disk gets full, clip file size */
// 2984 							ofs = bcs; break;
// 2985 						}
// 2986 					} else
// 2987 #endif
// 2988 						clst = get_fat(fp->fs, clst);	/* Follow cluster chain if not in write mode */
// 2989 					if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2990 					if (clst <= 1 || clst >= fp->fs->n_fatent) ABORT(fp->fs, FR_INT_ERR);
// 2991 					fp->clust = clst;
??f_lseek_26:
        STR      R1,[R5, #+20]
// 2992 					fp->fptr += bcs;
        LDR      R0,[R5, #+8]
        ADDS     R0,R8,R0
        STR      R0,[R5, #+8]
// 2993 					ofs -= bcs;
        SUBS     R6,R6,R8
??f_lseek_25:
        CMP      R8,R6
        BCS.N    ??f_lseek_27
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+30
        BPL.N    ??f_lseek_28
        LDR      R0,[R5, #+0]
        BL       create_chain
        MOVS     R1,R0
        CMP      R1,#+0
        BNE.N    ??f_lseek_29
        MOV      R6,R8
// 2994 				}
// 2995 				fp->fptr += ofs;
??f_lseek_27:
        LDR      R0,[R5, #+8]
        ADDS     R0,R6,R0
        STR      R0,[R5, #+8]
// 2996 				if (ofs % SS(fp->fs)) {
        MOV      R0,#+512
        UDIV     R2,R6,R0
        MLS      R2,R2,R0,R6
        CMP      R2,#+0
        BEQ.N    ??f_lseek_19
// 2997 					nsect = clust2sect(fp->fs, clst);	/* Current sector */
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOVS     R7,R0
// 2998 					if (!nsect) ABORT(fp->fs, FR_INT_ERR);
        CMP      R7,#+0
        BNE.N    ??f_lseek_30
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
??f_lseek_28:
        LDR      R0,[R5, #+0]
        BL       get_fat
        MOVS     R1,R0
??f_lseek_29:
        CMN      R1,#+1
        BNE.N    ??f_lseek_31
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
??f_lseek_31:
        CMP      R1,#+2
        BCC.N    ??f_lseek_32
        LDR      R0,[R5, #+0]
        LDR      R0,[R0, #+28]
        CMP      R1,R0
        BCC.N    ??f_lseek_26
??f_lseek_32:
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2999 					nsect += ofs / SS(fp->fs);
??f_lseek_30:
        ADDS     R7,R7,R6, LSR #+9
// 3000 				}
// 3001 			}
// 3002 		}
// 3003 		if (fp->fptr % SS(fp->fs) && nsect != fp->dsect) {	/* Fill sector cache if needed */
??f_lseek_19:
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BEQ.N    ??f_lseek_33
        LDR      R0,[R5, #+24]
        CMP      R7,R0
        BEQ.N    ??f_lseek_33
// 3004 #if !_FS_TINY
// 3005 #if !_FS_READONLY
// 3006 			if (fp->flag & FA__DIRTY) {			/* Write-back dirty sector cache */
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_lseek_34
// 3007 				if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_lseek_35
// 3008 					ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 3009 				fp->flag &= ~FA__DIRTY;
??f_lseek_35:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
// 3010 			}
// 3011 #endif
// 3012 			if (disk_read(fp->fs->drv, fp->buf, nsect, 1) != RES_OK)	/* Fill sector cache */
??f_lseek_34:
        MOVS     R3,#+1
        MOVS     R2,R7
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??f_lseek_36
// 3013 				ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 3014 #endif
// 3015 			fp->dsect = nsect;
??f_lseek_36:
        STR      R7,[R5, #+24]
// 3016 		}
// 3017 #if !_FS_READONLY
// 3018 		if (fp->fptr > fp->fsize) {			/* Set file change flag if the file size is extended */
??f_lseek_33:
        LDR      R0,[R5, #+12]
        LDR      R1,[R5, #+8]
        CMP      R0,R1
        BCS.N    ??f_lseek_12
// 3019 			fp->fsize = fp->fptr;
        LDR      R0,[R5, #+8]
        STR      R0,[R5, #+12]
// 3020 			fp->flag |= FA__WRITTEN;
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+6]
// 3021 		}
// 3022 #endif
// 3023 	}
// 3024 
// 3025 	LEAVE_FF(fp->fs, res);
??f_lseek_12:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_lseek_1:
        POP      {R1,R4-R11,PC}   ;; return
// 3026 }
// 3027 
// 3028 
// 3029 
// 3030 #if _FS_MINIMIZE <= 1
// 3031 /*-----------------------------------------------------------------------*/
// 3032 /* Create a Directory Object                                             */
// 3033 /*-----------------------------------------------------------------------*/
// 3034 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3035 FRESULT f_opendir (
// 3036 	DIR *dj,			/* Pointer to directory object to create */
// 3037 	const TCHAR *path	/* Pointer to the directory path */
// 3038 )
// 3039 {
f_opendir:
        PUSH     {R1,R4-R7,LR}
        SUB      SP,SP,#+16
        MOVS     R4,R0
// 3040 	FRESULT res;
// 3041 	FATFS *fs;
// 3042 	DEF_NAMEBUF;
// 3043 
// 3044 
// 3045 	if (!dj) return FR_INVALID_OBJECT;
        CMP      R4,#+0
        BNE.N    ??f_opendir_0
        MOVS     R0,#+9
        B.N      ??f_opendir_1
// 3046 
// 3047 	res = chk_mounted(&path, &dj->fs, 0);
??f_opendir_0:
        MOVS     R2,#+0
        MOVS     R1,R4
        ADD      R0,SP,#+16
        BL       chk_mounted
        MOVS     R6,R0
// 3048 	fs = dj->fs;
        LDR      R5,[R4, #+0]
// 3049 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_opendir_2
// 3050 		INIT_BUF(*dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R7,R0
        CMP      R7,#+0
        BNE.N    ??f_opendir_3
        MOVS     R0,#+17
        B.N      ??f_opendir_1
??f_opendir_3:
        STR      R7,[R4, #+28]
        ADD      R0,SP,#+0
        STR      R0,[R4, #+24]
// 3051 		res = follow_path(dj, path);			/* Follow the path to the directory */
        LDR      R1,[SP, #+16]
        MOVS     R0,R4
        BL       follow_path
        MOVS     R6,R0
// 3052 		FREE_BUF();
        MOVS     R0,R7
        BL       ff_memfree
// 3053 		if (res == FR_OK) {						/* Follow completed */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_opendir_4
// 3054 			if (dj->dir) {						/* It is not the root dir */
        LDR      R0,[R4, #+20]
        CMP      R0,#+0
        BEQ.N    ??f_opendir_5
// 3055 				if (dj->dir[DIR_Attr] & AM_DIR) {	/* The object is a directory */
        LDR      R0,[R4, #+20]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_opendir_6
// 3056 					dj->sclust = ld_clust(fs, dj->dir);
        LDR      R1,[R4, #+20]
        MOVS     R0,R5
        BL       ld_clust
        STR      R0,[R4, #+8]
        B.N      ??f_opendir_5
// 3057 				} else {						/* The object is not a directory */
// 3058 					res = FR_NO_PATH;
??f_opendir_6:
        MOVS     R6,#+5
// 3059 				}
// 3060 			}
// 3061 			if (res == FR_OK) {
??f_opendir_5:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_opendir_4
// 3062 				dj->id = fs->id;
        LDRH     R0,[R5, #+6]
        STRH     R0,[R4, #+4]
// 3063 				res = dir_sdi(dj, 0);			/* Rewind dir */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
        MOVS     R6,R0
// 3064 			}
// 3065 		}
// 3066 		if (res == FR_NO_FILE) res = FR_NO_PATH;
??f_opendir_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_opendir_7
        MOVS     R6,#+5
// 3067 		if (res != FR_OK) dj->fs = 0;			/* Invalidate the dir object if function faild */
??f_opendir_7:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??f_opendir_8
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
        B.N      ??f_opendir_8
// 3068 	} else {
// 3069 		dj->fs = 0;
??f_opendir_2:
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
// 3070 	}
// 3071 
// 3072 	LEAVE_FF(fs, res);
??f_opendir_8:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_opendir_1:
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
// 3073 }
// 3074 
// 3075 
// 3076 
// 3077 
// 3078 /*-----------------------------------------------------------------------*/
// 3079 /* Read Directory Entry in Sequence                                      */
// 3080 /*-----------------------------------------------------------------------*/
// 3081 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3082 FRESULT f_readdir (
// 3083 	DIR *dj,			/* Pointer to the open directory object */
// 3084 	FILINFO *fno		/* Pointer to file information to return */
// 3085 )
// 3086 {
f_readdir:
        PUSH     {R1-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 3087 	FRESULT res;
// 3088 	DEF_NAMEBUF;
// 3089 
// 3090 
// 3091 	res = validate(dj);						/* Check validity of the object */
        MOVS     R0,R4
        BL       validate
        MOVS     R6,R0
// 3092 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_readdir_0
// 3093 		if (!fno) {
        CMP      R5,#+0
        BNE.N    ??f_readdir_1
// 3094 			res = dir_sdi(dj, 0);			/* Rewind the directory object */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
        MOVS     R6,R0
        B.N      ??f_readdir_0
// 3095 		} else {
// 3096 			INIT_BUF(*dj);
??f_readdir_1:
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R7,R0
        CMP      R7,#+0
        BNE.N    ??f_readdir_2
        MOVS     R0,#+17
        B.N      ??f_readdir_3
??f_readdir_2:
        STR      R7,[R4, #+28]
        ADD      R0,SP,#+0
        STR      R0,[R4, #+24]
// 3097 			res = dir_read(dj, 0);			/* Read an item */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_read
        MOVS     R6,R0
// 3098 			if (res == FR_NO_FILE) {		/* Reached end of dir */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_readdir_4
// 3099 				dj->sect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
// 3100 				res = FR_OK;
        MOVS     R6,#+0
// 3101 			}
// 3102 			if (res == FR_OK) {				/* A valid entry is found */
??f_readdir_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_readdir_5
// 3103 				get_fileinfo(dj, fno);		/* Get the object information */
        MOVS     R1,R5
        MOVS     R0,R4
        BL       get_fileinfo
// 3104 				res = dir_next(dj, 0);		/* Increment index for next */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
        MOVS     R6,R0
// 3105 				if (res == FR_NO_FILE) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_readdir_5
// 3106 					dj->sect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
// 3107 					res = FR_OK;
        MOVS     R6,#+0
// 3108 				}
// 3109 			}
// 3110 			FREE_BUF();
??f_readdir_5:
        MOVS     R0,R7
        BL       ff_memfree
// 3111 		}
// 3112 	}
// 3113 
// 3114 	LEAVE_FF(dj->fs, res);
??f_readdir_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_readdir_3:
        POP      {R1-R7,PC}       ;; return
// 3115 }
// 3116 
// 3117 
// 3118 
// 3119 #if _FS_MINIMIZE == 0
// 3120 /*-----------------------------------------------------------------------*/
// 3121 /* Get File Status                                                       */
// 3122 /*-----------------------------------------------------------------------*/
// 3123 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3124 FRESULT f_stat (
// 3125 	const TCHAR *path,	/* Pointer to the file path */
// 3126 	FILINFO *fno		/* Pointer to file information to return */
// 3127 )
// 3128 {
f_stat:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+52
        MOVS     R4,R1
// 3129 	FRESULT res;
// 3130 	DIR dj;
// 3131 	DEF_NAMEBUF;
// 3132 
// 3133 
// 3134 	res = chk_mounted(&path, &dj.fs, 0);
        MOVS     R2,#+0
        ADD      R1,SP,#+12
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOVS     R5,R0
// 3135 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_stat_0
// 3136 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R6,R0
        CMP      R6,#+0
        BNE.N    ??f_stat_1
        MOVS     R0,#+17
        B.N      ??f_stat_2
??f_stat_1:
        STR      R6,[SP, #+40]
        ADD      R0,SP,#+0
        STR      R0,[SP, #+36]
// 3137 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+12
        BL       follow_path
        MOVS     R5,R0
// 3138 		if (res == FR_OK) {				/* Follow completed */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_stat_3
// 3139 			if (dj.dir)		/* Found an object */
        LDR      R0,[SP, #+32]
        CMP      R0,#+0
        BEQ.N    ??f_stat_4
// 3140 				get_fileinfo(&dj, fno);
        MOVS     R1,R4
        ADD      R0,SP,#+12
        BL       get_fileinfo
        B.N      ??f_stat_3
// 3141 			else			/* It is root dir */
// 3142 				res = FR_INVALID_NAME;
??f_stat_4:
        MOVS     R5,#+6
// 3143 		}
// 3144 		FREE_BUF();
??f_stat_3:
        MOVS     R0,R6
        BL       ff_memfree
// 3145 	}
// 3146 
// 3147 	LEAVE_FF(dj.fs, res);
??f_stat_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_stat_2:
        ADD      SP,SP,#+56
        POP      {R4-R6,PC}       ;; return
// 3148 }
// 3149 
// 3150 
// 3151 
// 3152 #if !_FS_READONLY
// 3153 /*-----------------------------------------------------------------------*/
// 3154 /* Get Number of Free Clusters                                           */
// 3155 /*-----------------------------------------------------------------------*/
// 3156 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3157 FRESULT f_getfree (
// 3158 	const TCHAR *path,	/* Path name of the logical drive number */
// 3159 	DWORD *nclst,		/* Pointer to a variable to return number of free clusters */
// 3160 	FATFS **fatfs		/* Pointer to return pointer to corresponding file system object */
// 3161 )
// 3162 {
f_getfree:
        PUSH     {R0,R4-R10,LR}
        SUB      SP,SP,#+4
        MOVS     R4,R1
        MOVS     R5,R2
// 3163 	FRESULT res;
// 3164 	FATFS *fs;
// 3165 	DWORD n, clst, sect, stat;
// 3166 	UINT i;
// 3167 	BYTE fat, *p;
// 3168 
// 3169 
// 3170 	/* Get drive number */
// 3171 	res = chk_mounted(&path, fatfs, 0);
        MOVS     R2,#+0
        MOVS     R1,R5
        ADD      R0,SP,#+4
        BL       chk_mounted
        MOVS     R7,R0
// 3172 	fs = *fatfs;
        LDR      R5,[R5, #+0]
// 3173 	if (res == FR_OK) {
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_getfree_0
// 3174 		/* If free_clust is valid, return it without full cluster scan */
// 3175 		if (fs->free_clust <= fs->n_fatent - 2) {
        LDR      R0,[R5, #+28]
        SUBS     R0,R0,#+2
        LDR      R1,[R5, #+16]
        CMP      R0,R1
        BCC.N    ??f_getfree_1
// 3176 			*nclst = fs->free_clust;
        LDR      R0,[R5, #+16]
        STR      R0,[R4, #+0]
        B.N      ??f_getfree_0
// 3177 		} else {
// 3178 			/* Get number of free clusters */
// 3179 			fat = fs->fs_type;
??f_getfree_1:
        LDRB     R6,[R5, #+0]
// 3180 			n = 0;
        MOVS     R8,#+0
// 3181 			if (fat == FS_FAT12) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??f_getfree_2
// 3182 				clst = 2;
        MOVS     R9,#+2
// 3183 				do {
// 3184 					stat = get_fat(fs, clst);
??f_getfree_3:
        MOV      R1,R9
        MOVS     R0,R5
        BL       get_fat
// 3185 					if (stat == 0xFFFFFFFF) { res = FR_DISK_ERR; break; }
        CMN      R0,#+1
        BNE.N    ??f_getfree_4
        MOVS     R7,#+1
        B.N      ??f_getfree_5
// 3186 					if (stat == 1) { res = FR_INT_ERR; break; }
??f_getfree_4:
        CMP      R0,#+1
        BNE.N    ??f_getfree_6
        MOVS     R7,#+2
        B.N      ??f_getfree_5
// 3187 					if (stat == 0) n++;
??f_getfree_6:
        CMP      R0,#+0
        BNE.N    ??f_getfree_7
        ADDS     R8,R8,#+1
// 3188 				} while (++clst < fs->n_fatent);
??f_getfree_7:
        ADDS     R9,R9,#+1
        LDR      R0,[R5, #+28]
        CMP      R9,R0
        BCC.N    ??f_getfree_3
        B.N      ??f_getfree_5
// 3189 			} else {
// 3190 				clst = fs->n_fatent;
??f_getfree_2:
        LDR      R9,[R5, #+28]
// 3191 				sect = fs->fatbase;
        LDR      R10,[R5, #+40]
// 3192 				i = 0; p = 0;
        MOVS     R1,#+0
        MOVS     R0,#+0
// 3193 				do {
// 3194 					if (!i) {
??f_getfree_8:
        CMP      R1,#+0
        BNE.N    ??f_getfree_9
// 3195 						res = move_window(fs, sect++);
        MOV      R1,R10
        MOVS     R0,R5
        BL       move_window
        MOVS     R7,R0
        ADDS     R10,R10,#+1
// 3196 						if (res != FR_OK) break;
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_getfree_5
// 3197 						p = fs->win;
??f_getfree_10:
        ADDS     R0,R5,#+56
// 3198 						i = SS(fs);
        MOV      R1,#+512
// 3199 					}
// 3200 					if (fat == FS_FAT16) {
??f_getfree_9:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BNE.N    ??f_getfree_11
// 3201 						if (LD_WORD(p) == 0) n++;
        LDRB     R2,[R0, #+1]
        LDRB     R3,[R0, #+0]
        ORRS     R2,R3,R2, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        CMP      R2,#+0
        BNE.N    ??f_getfree_12
        ADDS     R8,R8,#+1
// 3202 						p += 2; i -= 2;
??f_getfree_12:
        ADDS     R0,R0,#+2
        SUBS     R1,R1,#+2
        B.N      ??f_getfree_13
// 3203 					} else {
// 3204 						if ((LD_DWORD(p) & 0x0FFFFFFF) == 0) n++;
??f_getfree_11:
        LDRB     R2,[R0, #+3]
        LDRB     R3,[R0, #+2]
        LSLS     R3,R3,#+16
        ORRS     R2,R3,R2, LSL #+24
        LDRB     R3,[R0, #+1]
        ORRS     R2,R2,R3, LSL #+8
        LDRB     R3,[R0, #+0]
        ORRS     R2,R3,R2
        LSLS     R2,R2,#+4
        BNE.N    ??f_getfree_14
        ADDS     R8,R8,#+1
// 3205 						p += 4; i -= 4;
??f_getfree_14:
        ADDS     R0,R0,#+4
        SUBS     R1,R1,#+4
// 3206 					}
// 3207 				} while (--clst);
??f_getfree_13:
        SUBS     R9,R9,#+1
        CMP      R9,#+0
        BNE.N    ??f_getfree_8
// 3208 			}
// 3209 			fs->free_clust = n;
??f_getfree_5:
        STR      R8,[R5, #+16]
// 3210 			if (fat == FS_FAT32) fs->fsi_flag = 1;
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_getfree_15
        MOVS     R0,#+1
        STRB     R0,[R5, #+5]
// 3211 			*nclst = n;
??f_getfree_15:
        STR      R8,[R4, #+0]
// 3212 		}
// 3213 	}
// 3214 	LEAVE_FF(fs, res);
??f_getfree_0:
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R2,R4-R10,PC}  ;; return
// 3215 }
// 3216 
// 3217 
// 3218 
// 3219 
// 3220 /*-----------------------------------------------------------------------*/
// 3221 /* Truncate File                                                         */
// 3222 /*-----------------------------------------------------------------------*/
// 3223 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3224 FRESULT f_truncate (
// 3225 	FIL *fp		/* Pointer to the file object */
// 3226 )
// 3227 {
f_truncate:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 3228 	FRESULT res;
// 3229 	DWORD ncl;
// 3230 
// 3231 
// 3232 	res = validate(fp);						/* Check validity of the object */
        MOVS     R0,R4
        BL       validate
// 3233 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_0
// 3234 		if (fp->flag & FA__ERROR) {			/* Check abort flag */
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+24
        BPL.N    ??f_truncate_1
// 3235 			res = FR_INT_ERR;
        MOVS     R0,#+2
        B.N      ??f_truncate_0
// 3236 		} else {
// 3237 			if (!(fp->flag & FA_WRITE))		/* Check access mode */
??f_truncate_1:
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+30
        BMI.N    ??f_truncate_0
// 3238 				res = FR_DENIED;
        MOVS     R0,#+7
// 3239 		}
// 3240 	}
// 3241 	if (res == FR_OK) {
??f_truncate_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_2
// 3242 		if (fp->fsize > fp->fptr) {
        LDR      R1,[R4, #+8]
        LDR      R2,[R4, #+12]
        CMP      R1,R2
        BCS.N    ??f_truncate_3
// 3243 			fp->fsize = fp->fptr;	/* Set file size to current R/W point */
        LDR      R0,[R4, #+8]
        STR      R0,[R4, #+12]
// 3244 			fp->flag |= FA__WRITTEN;
        LDRB     R0,[R4, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R4, #+6]
// 3245 			if (fp->fptr == 0) {	/* When set file size to zero, remove entire cluster chain */
        LDR      R0,[R4, #+8]
        CMP      R0,#+0
        BNE.N    ??f_truncate_4
// 3246 				res = remove_chain(fp->fs, fp->sclust);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       remove_chain
// 3247 				fp->sclust = 0;
        MOVS     R1,#+0
        STR      R1,[R4, #+16]
        B.N      ??f_truncate_3
// 3248 			} else {				/* When truncate a part of the file, remove remaining clusters */
// 3249 				ncl = get_fat(fp->fs, fp->clust);
??f_truncate_4:
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+0]
        BL       get_fat
        MOVS     R5,R0
// 3250 				res = FR_OK;
        MOVS     R0,#+0
// 3251 				if (ncl == 0xFFFFFFFF) res = FR_DISK_ERR;
        CMN      R5,#+1
        BNE.N    ??f_truncate_5
        MOVS     R0,#+1
// 3252 				if (ncl == 1) res = FR_INT_ERR;
??f_truncate_5:
        CMP      R5,#+1
        BNE.N    ??f_truncate_6
        MOVS     R0,#+2
// 3253 				if (res == FR_OK && ncl < fp->fs->n_fatent) {
??f_truncate_6:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_3
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+28]
        CMP      R5,R1
        BCS.N    ??f_truncate_3
// 3254 					res = put_fat(fp->fs, fp->clust, 0x0FFFFFFF);
        MVNS     R2,#-268435456
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+0]
        BL       put_fat
// 3255 					if (res == FR_OK) res = remove_chain(fp->fs, ncl);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_3
        MOVS     R1,R5
        LDR      R0,[R4, #+0]
        BL       remove_chain
// 3256 				}
// 3257 			}
// 3258 		}
// 3259 		if (res != FR_OK) fp->flag |= FA__ERROR;
??f_truncate_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_truncate_2
        LDRB     R1,[R4, #+6]
        ORRS     R1,R1,#0x80
        STRB     R1,[R4, #+6]
// 3260 	}
// 3261 
// 3262 	LEAVE_FF(fp->fs, res);
??f_truncate_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
// 3263 }
// 3264 
// 3265 
// 3266 
// 3267 
// 3268 /*-----------------------------------------------------------------------*/
// 3269 /* Delete a File or Directory                                            */
// 3270 /*-----------------------------------------------------------------------*/
// 3271 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3272 FRESULT f_unlink (
// 3273 	const TCHAR *path		/* Pointer to the file or directory path */
// 3274 )
// 3275 {
f_unlink:
        PUSH     {R0,R4-R7,LR}
        SUB      SP,SP,#+88
// 3276 	FRESULT res;
// 3277 	DIR dj, sdj;
// 3278 	BYTE *dir;
// 3279 	DWORD dclst;
// 3280 	DEF_NAMEBUF;
// 3281 
// 3282 
// 3283 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+88
        BL       chk_mounted
        MOVS     R5,R0
// 3284 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_0
// 3285 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R4,R0
        CMP      R4,#+0
        BNE.N    ??f_unlink_1
        MOVS     R0,#+17
        B.N      ??f_unlink_2
??f_unlink_1:
        STR      R4,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3286 		res = follow_path(&dj, path);		/* Follow the file path */
        LDR      R1,[SP, #+88]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R5,R0
// 3287 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_3
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_unlink_3
// 3288 			res = FR_INVALID_NAME;			/* Cannot remove dot entry */
        MOVS     R5,#+6
// 3289 #if _FS_LOCK
// 3290 		if (res == FR_OK) res = chk_lock(&dj, 2);	/* Cannot remove open file */
??f_unlink_3:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_4
        MOVS     R1,#+2
        ADD      R0,SP,#+0
        BL       chk_lock
        MOVS     R5,R0
// 3291 #endif
// 3292 		if (res == FR_OK) {					/* The object is accessible */
??f_unlink_4:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
// 3293 			dir = dj.dir;
        LDR      R7,[SP, #+20]
// 3294 			if (!dir) {
        CMP      R7,#+0
        BNE.N    ??f_unlink_6
// 3295 				res = FR_INVALID_NAME;		/* Cannot remove the start directory */
        MOVS     R5,#+6
        B.N      ??f_unlink_7
// 3296 			} else {
// 3297 				if (dir[DIR_Attr] & AM_RDO)
??f_unlink_6:
        LDRB     R0,[R7, #+11]
        LSLS     R0,R0,#+31
        BPL.N    ??f_unlink_7
// 3298 					res = FR_DENIED;		/* Cannot remove R/O object */
        MOVS     R5,#+7
// 3299 			}
// 3300 			dclst = ld_clust(dj.fs, dir);
??f_unlink_7:
        MOVS     R1,R7
        LDR      R0,[SP, #+0]
        BL       ld_clust
        MOVS     R6,R0
// 3301 			if (res == FR_OK && (dir[DIR_Attr] & AM_DIR)) {	/* Is it a sub-dir? */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_8
        LDRB     R0,[R7, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_unlink_8
// 3302 				if (dclst < 2) {
        CMP      R6,#+2
        BCS.N    ??f_unlink_9
// 3303 					res = FR_INT_ERR;
        MOVS     R5,#+2
        B.N      ??f_unlink_8
// 3304 				} else {
// 3305 					mem_cpy(&sdj, &dj, sizeof (DIR));	/* Check if the sub-dir is empty or not */
??f_unlink_9:
        MOVS     R2,#+36
        ADD      R1,SP,#+0
        ADD      R0,SP,#+48
        BL       mem_cpy
// 3306 					sdj.sclust = dclst;
        STR      R6,[SP, #+56]
// 3307 					res = dir_sdi(&sdj, 2);		/* Exclude dot entries */
        MOVS     R1,#+2
        ADD      R0,SP,#+48
        BL       dir_sdi
        MOVS     R5,R0
// 3308 					if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_8
// 3309 						res = dir_read(&sdj, 0);	/* Read an item */
        MOVS     R1,#+0
        ADD      R0,SP,#+48
        BL       dir_read
        MOVS     R5,R0
// 3310 						if (res == FR_OK		/* Not empty dir */
// 3311 #if _FS_RPATH
// 3312 						|| dclst == dj.fs->cdir	/* Current dir */
// 3313 #endif
// 3314 						) res = FR_DENIED;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??f_unlink_10
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        CMP      R6,R0
        BNE.N    ??f_unlink_11
??f_unlink_10:
        MOVS     R5,#+7
// 3315 						if (res == FR_NO_FILE) res = FR_OK;	/* Empty */
??f_unlink_11:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+4
        BNE.N    ??f_unlink_8
        MOVS     R5,#+0
// 3316 					}
// 3317 				}
// 3318 			}
// 3319 			if (res == FR_OK) {
??f_unlink_8:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
// 3320 				res = dir_remove(&dj);		/* Remove the directory entry */
        ADD      R0,SP,#+0
        BL       dir_remove
        MOVS     R5,R0
// 3321 				if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
// 3322 					if (dclst)				/* Remove the cluster chain if exist */
        CMP      R6,#+0
        BEQ.N    ??f_unlink_12
// 3323 						res = remove_chain(dj.fs, dclst);
        MOVS     R1,R6
        LDR      R0,[SP, #+0]
        BL       remove_chain
        MOVS     R5,R0
// 3324 					if (res == FR_OK) res = sync_fs(dj.fs);
??f_unlink_12:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
        LDR      R0,[SP, #+0]
        BL       sync_fs
        MOVS     R5,R0
// 3325 				}
// 3326 			}
// 3327 		}
// 3328 		FREE_BUF();
??f_unlink_5:
        MOVS     R0,R4
        BL       ff_memfree
// 3329 	}
// 3330 
// 3331 	LEAVE_FF(dj.fs, res);
??f_unlink_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_unlink_2:
        ADD      SP,SP,#+92
        POP      {R4-R7,PC}       ;; return
// 3332 }
// 3333 
// 3334 
// 3335 
// 3336 
// 3337 /*-----------------------------------------------------------------------*/
// 3338 /* Create a Directory                                                    */
// 3339 /*-----------------------------------------------------------------------*/
// 3340 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3341 FRESULT f_mkdir (
// 3342 	const TCHAR *path		/* Pointer to the directory path */
// 3343 )
// 3344 {
f_mkdir:
        PUSH     {R0,R4-R10,LR}
        SUB      SP,SP,#+52
// 3345 	FRESULT res;
// 3346 	DIR dj;
// 3347 	BYTE *dir, n;
// 3348 	DWORD dsc, dcl, pcl, tm = get_fattime();
        BL       get_fattime
        MOVS     R4,R0
// 3349 	DEF_NAMEBUF;
// 3350 
// 3351 
// 3352 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOVS     R6,R0
// 3353 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.W    ??f_mkdir_0
// 3354 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_mkdir_1
        MOVS     R0,#+17
        B.N      ??f_mkdir_2
??f_mkdir_1:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3355 		res = follow_path(&dj, path);			/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R6,R0
// 3356 		if (res == FR_OK) res = FR_EXIST;		/* Any object with same name is already existing */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_3
        MOVS     R6,#+8
// 3357 		if (_FS_RPATH && res == FR_NO_FILE && (dj.fn[NS] & NS_DOT))
??f_mkdir_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_mkdir_4
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_mkdir_4
// 3358 			res = FR_INVALID_NAME;
        MOVS     R6,#+6
// 3359 		if (res == FR_NO_FILE) {				/* Can create a new directory */
??f_mkdir_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.W    ??f_mkdir_5
// 3360 			dcl = create_chain(dj.fs, 0);		/* Allocate a cluster for the new directory table */
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       create_chain
        MOVS     R7,R0
// 3361 			res = FR_OK;
        MOVS     R6,#+0
// 3362 			if (dcl == 0) res = FR_DENIED;		/* No space to allocate a new cluster */
        CMP      R7,#+0
        BNE.N    ??f_mkdir_6
        MOVS     R6,#+7
// 3363 			if (dcl == 1) res = FR_INT_ERR;
??f_mkdir_6:
        CMP      R7,#+1
        BNE.N    ??f_mkdir_7
        MOVS     R6,#+2
// 3364 			if (dcl == 0xFFFFFFFF) res = FR_DISK_ERR;
??f_mkdir_7:
        CMN      R7,#+1
        BNE.N    ??f_mkdir_8
        MOVS     R6,#+1
// 3365 			if (res == FR_OK)					/* Flush FAT */
??f_mkdir_8:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_9
// 3366 				res = sync_window(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync_window
        MOVS     R6,R0
// 3367 			if (res == FR_OK) {					/* Initialize the new directory table */
??f_mkdir_9:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_10
// 3368 				dsc = clust2sect(dj.fs, dcl);
        MOVS     R1,R7
        LDR      R0,[SP, #+0]
        BL       clust2sect
        MOV      R8,R0
// 3369 				dir = dj.fs->win;
        LDR      R0,[SP, #+0]
        ADDS     R9,R0,#+56
// 3370 				mem_set(dir, 0, SS(dj.fs));
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R9
        BL       mem_set
// 3371 				mem_set(dir+DIR_Name, ' ', 11);	/* Create "." entry */
        MOVS     R2,#+11
        MOVS     R1,#+32
        MOV      R0,R9
        BL       mem_set
// 3372 				dir[DIR_Name] = '.';
        MOVS     R0,#+46
        STRB     R0,[R9, #+0]
// 3373 				dir[DIR_Attr] = AM_DIR;
        MOVS     R0,#+16
        STRB     R0,[R9, #+11]
// 3374 				ST_DWORD(dir+DIR_WrtTime, tm);
        STRB     R4,[R9, #+22]
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+23]
        LSRS     R0,R4,#+16
        STRB     R0,[R9, #+24]
        LSRS     R0,R4,#+24
        STRB     R0,[R9, #+25]
// 3375 				st_clust(dir, dcl);
        MOVS     R1,R7
        MOV      R0,R9
        BL       st_clust
// 3376 				mem_cpy(dir+SZ_DIR, dir, SZ_DIR); 	/* Create ".." entry */
        MOVS     R2,#+32
        MOV      R1,R9
        ADDS     R0,R9,#+32
        BL       mem_cpy
// 3377 				dir[33] = '.'; pcl = dj.sclust;
        MOVS     R0,#+46
        STRB     R0,[R9, #+33]
        LDR      R1,[SP, #+8]
// 3378 				if (dj.fs->fs_type == FS_FAT32 && pcl == dj.fs->dirbase)
        LDR      R0,[SP, #+0]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??f_mkdir_11
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+44]
        CMP      R1,R0
        BNE.N    ??f_mkdir_11
// 3379 					pcl = 0;
        MOVS     R1,#+0
// 3380 				st_clust(dir+SZ_DIR, pcl);
??f_mkdir_11:
        ADDS     R0,R9,#+32
        BL       st_clust
// 3381 				for (n = dj.fs->csize; n; n--) {	/* Write dot entries and clear following sectors */
        LDR      R0,[SP, #+0]
        LDRB     R10,[R0, #+2]
        B.N      ??f_mkdir_12
// 3382 					dj.fs->winsect = dsc++;
// 3383 					dj.fs->wflag = 1;
// 3384 					res = sync_window(dj.fs);
// 3385 					if (res != FR_OK) break;
// 3386 					mem_set(dir, 0, SS(dj.fs));
??f_mkdir_13:
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R9
        BL       mem_set
        SUBS     R10,R10,#+1
??f_mkdir_12:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??f_mkdir_10
        LDR      R0,[SP, #+0]
        STR      R8,[R0, #+52]
        ADDS     R8,R8,#+1
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
        LDR      R0,[SP, #+0]
        BL       sync_window
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??f_mkdir_13
// 3387 				}
// 3388 			}
// 3389 			if (res == FR_OK) res = dir_register(&dj);	/* Register the object to the directoy */
??f_mkdir_10:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_14
        ADD      R0,SP,#+0
        BL       dir_register
        MOVS     R6,R0
// 3390 			if (res != FR_OK) {
??f_mkdir_14:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??f_mkdir_15
// 3391 				remove_chain(dj.fs, dcl);			/* Could not register, remove cluster chain */
        MOVS     R1,R7
        LDR      R0,[SP, #+0]
        BL       remove_chain
        B.N      ??f_mkdir_5
// 3392 			} else {
// 3393 				dir = dj.dir;
??f_mkdir_15:
        LDR      R9,[SP, #+20]
// 3394 				dir[DIR_Attr] = AM_DIR;				/* Attribute */
        MOVS     R0,#+16
        STRB     R0,[R9, #+11]
// 3395 				ST_DWORD(dir+DIR_WrtTime, tm);		/* Created time */
        STRB     R4,[R9, #+22]
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+23]
        LSRS     R0,R4,#+16
        STRB     R0,[R9, #+24]
        LSRS     R0,R4,#+24
        STRB     R0,[R9, #+25]
// 3396 				st_clust(dir, dcl);					/* Table start cluster */
        MOVS     R1,R7
        MOV      R0,R9
        BL       st_clust
// 3397 				dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3398 				res = sync_fs(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync_fs
        MOVS     R6,R0
// 3399 			}
// 3400 		}
// 3401 		FREE_BUF();
??f_mkdir_5:
        MOVS     R0,R5
        BL       ff_memfree
// 3402 	}
// 3403 
// 3404 	LEAVE_FF(dj.fs, res);
??f_mkdir_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_mkdir_2:
        ADD      SP,SP,#+56
        POP      {R4-R10,PC}      ;; return
// 3405 }
// 3406 
// 3407 
// 3408 
// 3409 
// 3410 /*-----------------------------------------------------------------------*/
// 3411 /* Change Attribute                                                      */
// 3412 /*-----------------------------------------------------------------------*/
// 3413 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3414 FRESULT f_chmod (
// 3415 	const TCHAR *path,	/* Pointer to the file path */
// 3416 	BYTE value,			/* Attribute bits */
// 3417 	BYTE mask			/* Attribute mask to change */
// 3418 )
// 3419 {
f_chmod:
        PUSH     {R0,R4-R7,LR}
        SUB      SP,SP,#+48
        MOVS     R4,R1
        MOVS     R5,R2
// 3420 	FRESULT res;
// 3421 	DIR dj;
// 3422 	BYTE *dir;
// 3423 	DEF_NAMEBUF;
// 3424 
// 3425 
// 3426 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+48
        BL       chk_mounted
        MOVS     R6,R0
// 3427 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_chmod_0
// 3428 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R7,R0
        CMP      R7,#+0
        BNE.N    ??f_chmod_1
        MOVS     R0,#+17
        B.N      ??f_chmod_2
??f_chmod_1:
        STR      R7,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3429 		res = follow_path(&dj, path);		/* Follow the file path */
        LDR      R1,[SP, #+48]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R6,R0
// 3430 		FREE_BUF();
        MOVS     R0,R7
        BL       ff_memfree
// 3431 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_chmod_3
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_chmod_3
// 3432 			res = FR_INVALID_NAME;
        MOVS     R6,#+6
// 3433 		if (res == FR_OK) {
??f_chmod_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_chmod_0
// 3434 			dir = dj.dir;
        LDR      R0,[SP, #+20]
// 3435 			if (!dir) {						/* Is it a root directory? */
        CMP      R0,#+0
        BNE.N    ??f_chmod_4
// 3436 				res = FR_INVALID_NAME;
        MOVS     R6,#+6
        B.N      ??f_chmod_0
// 3437 			} else {						/* File or sub directory */
// 3438 				mask &= AM_RDO|AM_HID|AM_SYS|AM_ARC;	/* Valid attribute mask */
??f_chmod_4:
        ANDS     R5,R5,#0x27
// 3439 				dir[DIR_Attr] = (value & mask) | (dir[DIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
        ANDS     R1,R5,R4
        LDRB     R2,[R0, #+11]
        BICS     R2,R2,R5
        ORRS     R1,R2,R1
        STRB     R1,[R0, #+11]
// 3440 				dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3441 				res = sync_fs(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync_fs
        MOVS     R6,R0
// 3442 			}
// 3443 		}
// 3444 	}
// 3445 
// 3446 	LEAVE_FF(dj.fs, res);
??f_chmod_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_chmod_2:
        ADD      SP,SP,#+52
        POP      {R4-R7,PC}       ;; return
// 3447 }
// 3448 
// 3449 
// 3450 
// 3451 
// 3452 /*-----------------------------------------------------------------------*/
// 3453 /* Change Timestamp                                                      */
// 3454 /*-----------------------------------------------------------------------*/
// 3455 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3456 FRESULT f_utime (
// 3457 	const TCHAR *path,	/* Pointer to the file/directory name */
// 3458 	const FILINFO *fno	/* Pointer to the time stamp to be set */
// 3459 )
// 3460 {
f_utime:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+52
        MOVS     R4,R1
// 3461 	FRESULT res;
// 3462 	DIR dj;
// 3463 	BYTE *dir;
// 3464 	DEF_NAMEBUF;
// 3465 
// 3466 
// 3467 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOVS     R5,R0
// 3468 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_utime_0
// 3469 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R6,R0
        CMP      R6,#+0
        BNE.N    ??f_utime_1
        MOVS     R0,#+17
        B.N      ??f_utime_2
??f_utime_1:
        STR      R6,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3470 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R5,R0
// 3471 		FREE_BUF();
        MOVS     R0,R6
        BL       ff_memfree
// 3472 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_utime_3
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_utime_3
// 3473 			res = FR_INVALID_NAME;
        MOVS     R5,#+6
// 3474 		if (res == FR_OK) {
??f_utime_3:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_utime_0
// 3475 			dir = dj.dir;
        LDR      R0,[SP, #+20]
// 3476 			if (!dir) {					/* Root directory */
        CMP      R0,#+0
        BNE.N    ??f_utime_4
// 3477 				res = FR_INVALID_NAME;
        MOVS     R5,#+6
        B.N      ??f_utime_0
// 3478 			} else {					/* File or sub-directory */
// 3479 				ST_WORD(dir+DIR_WrtTime, fno->ftime);
??f_utime_4:
        LDRH     R1,[R4, #+6]
        STRB     R1,[R0, #+22]
        LDRH     R1,[R4, #+6]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+23]
// 3480 				ST_WORD(dir+DIR_WrtDate, fno->fdate);
        LDRH     R1,[R4, #+4]
        STRB     R1,[R0, #+24]
        LDRH     R1,[R4, #+4]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+25]
// 3481 				dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3482 				res = sync_fs(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync_fs
        MOVS     R5,R0
// 3483 			}
// 3484 		}
// 3485 	}
// 3486 
// 3487 	LEAVE_FF(dj.fs, res);
??f_utime_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_utime_2:
        ADD      SP,SP,#+56
        POP      {R4-R6,PC}       ;; return
// 3488 }
// 3489 
// 3490 
// 3491 
// 3492 
// 3493 /*-----------------------------------------------------------------------*/
// 3494 /* Rename File/Directory                                                 */
// 3495 /*-----------------------------------------------------------------------*/
// 3496 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3497 FRESULT f_rename (
// 3498 	const TCHAR *path_old,	/* Pointer to the old name */
// 3499 	const TCHAR *path_new	/* Pointer to the new name */
// 3500 )
// 3501 {
f_rename:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+108
        MOVS     R4,R1
// 3502 	FRESULT res;
// 3503 	DIR djo, djn;
// 3504 	BYTE buf[21], *dir;
// 3505 	DWORD dw;
// 3506 	DEF_NAMEBUF;
// 3507 
// 3508 
// 3509 	res = chk_mounted(&path_old, &djo.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+108
        BL       chk_mounted
        MOVS     R6,R0
// 3510 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.W    ??f_rename_0
// 3511 		djn.fs = djo.fs;
        LDR      R0,[SP, #+0]
        STR      R0,[SP, #+36]
// 3512 		INIT_BUF(djo);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_rename_1
        MOVS     R0,#+17
        B.N      ??f_rename_2
??f_rename_1:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+72
        STR      R0,[SP, #+24]
// 3513 		res = follow_path(&djo, path_old);		/* Check old object */
        LDR      R1,[SP, #+108]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R6,R0
// 3514 		if (_FS_RPATH && res == FR_OK && (djo.fn[NS] & NS_DOT))
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_3
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_rename_3
// 3515 			res = FR_INVALID_NAME;
        MOVS     R6,#+6
// 3516 #if _FS_LOCK
// 3517 		if (res == FR_OK) res = chk_lock(&djo, 2);
??f_rename_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_4
        MOVS     R1,#+2
        ADD      R0,SP,#+0
        BL       chk_lock
        MOVS     R6,R0
// 3518 #endif
// 3519 		if (res == FR_OK) {						/* Old object is found */
??f_rename_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_5
// 3520 			if (!djo.dir) {						/* Is root dir? */
        LDR      R0,[SP, #+20]
        CMP      R0,#+0
        BNE.N    ??f_rename_6
// 3521 				res = FR_NO_FILE;
        MOVS     R6,#+4
        B.N      ??f_rename_5
// 3522 			} else {
// 3523 				mem_cpy(buf, djo.dir+DIR_Attr, 21);		/* Save the object information except for name */
??f_rename_6:
        MOVS     R2,#+21
        LDR      R0,[SP, #+20]
        ADDS     R1,R0,#+11
        ADD      R0,SP,#+84
        BL       mem_cpy
// 3524 				mem_cpy(&djn, &djo, sizeof (DIR));		/* Check new object */
        MOVS     R2,#+36
        ADD      R1,SP,#+0
        ADD      R0,SP,#+36
        BL       mem_cpy
// 3525 				res = follow_path(&djn, path_new);
        MOVS     R1,R4
        ADD      R0,SP,#+36
        BL       follow_path
        MOVS     R6,R0
// 3526 				if (res == FR_OK) res = FR_EXIST;		/* The new object name is already existing */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_7
        MOVS     R6,#+8
// 3527 				if (res == FR_NO_FILE) { 				/* Is it a valid path and no name collision? */
??f_rename_7:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_rename_5
// 3528 /* Start critical section that any interruption can cause a cross-link */
// 3529 					res = dir_register(&djn);			/* Register the new entry */
        ADD      R0,SP,#+36
        BL       dir_register
        MOVS     R6,R0
// 3530 					if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_5
// 3531 						dir = djn.dir;					/* Copy object information except for name */
        LDR      R4,[SP, #+56]
// 3532 						mem_cpy(dir+13, buf+2, 19);
        MOVS     R2,#+19
        ADD      R1,SP,#+86
        ADDS     R0,R4,#+13
        BL       mem_cpy
// 3533 						dir[DIR_Attr] = buf[0] | AM_ARC;
        LDRB     R0,[SP, #+84]
        ORRS     R0,R0,#0x20
        STRB     R0,[R4, #+11]
// 3534 						djo.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3535 						if (djo.sclust != djn.sclust && (dir[DIR_Attr] & AM_DIR)) {		/* Update .. entry in the directory if needed */
        LDR      R0,[SP, #+8]
        LDR      R1,[SP, #+44]
        CMP      R0,R1
        BEQ.N    ??f_rename_8
        LDRB     R0,[R4, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_rename_8
// 3536 							dw = clust2sect(djo.fs, ld_clust(djo.fs, dir));
        MOVS     R1,R4
        LDR      R0,[SP, #+0]
        BL       ld_clust
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       clust2sect
        MOVS     R1,R0
// 3537 							if (!dw) {
        CMP      R1,#+0
        BNE.N    ??f_rename_9
// 3538 								res = FR_INT_ERR;
        MOVS     R6,#+2
        B.N      ??f_rename_8
// 3539 							} else {
// 3540 								res = move_window(djo.fs, dw);
??f_rename_9:
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R6,R0
// 3541 								dir = djo.fs->win+SZ_DIR;	/* .. entry */
        LDR      R0,[SP, #+0]
        ADDS     R4,R0,#+88
// 3542 								if (res == FR_OK && dir[1] == '.') {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_8
        LDRB     R0,[R4, #+1]
        CMP      R0,#+46
        BNE.N    ??f_rename_8
// 3543 									dw = (djo.fs->fs_type == FS_FAT32 && djn.sclust == djo.fs->dirbase) ? 0 : djn.sclust;
        LDR      R0,[SP, #+0]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??f_rename_10
        LDR      R0,[SP, #+44]
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+44]
        CMP      R0,R1
        BNE.N    ??f_rename_10
        MOVS     R1,#+0
        B.N      ??f_rename_11
??f_rename_10:
        LDR      R1,[SP, #+44]
// 3544 									st_clust(dir, dw);
??f_rename_11:
        MOVS     R0,R4
        BL       st_clust
// 3545 									djo.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3546 								}
// 3547 							}
// 3548 						}
// 3549 						if (res == FR_OK) {
??f_rename_8:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_5
// 3550 							res = dir_remove(&djo);		/* Remove old entry */
        ADD      R0,SP,#+0
        BL       dir_remove
        MOVS     R6,R0
// 3551 							if (res == FR_OK)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_5
// 3552 								res = sync_fs(djo.fs);
        LDR      R0,[SP, #+0]
        BL       sync_fs
        MOVS     R6,R0
// 3553 						}
// 3554 					}
// 3555 /* End critical section */
// 3556 				}
// 3557 			}
// 3558 		}
// 3559 		FREE_BUF();
??f_rename_5:
        MOVS     R0,R5
        BL       ff_memfree
// 3560 	}
// 3561 
// 3562 	LEAVE_FF(djo.fs, res);
??f_rename_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_rename_2:
        ADD      SP,SP,#+112
        POP      {R4-R6,PC}       ;; return
// 3563 }
// 3564 
// 3565 #endif /* !_FS_READONLY */
// 3566 #endif /* _FS_MINIMIZE == 0 */
// 3567 #endif /* _FS_MINIMIZE <= 1 */
// 3568 #endif /* _FS_MINIMIZE <= 2 */
// 3569 
// 3570 
// 3571 
// 3572 #if _USE_LABEL
// 3573 /*-----------------------------------------------------------------------*/
// 3574 /* Get volume label                                                      */
// 3575 /*-----------------------------------------------------------------------*/
// 3576 
// 3577 FRESULT f_getlabel (
// 3578 	const TCHAR* path,	/* Path name of the logical drive number */
// 3579 	TCHAR* label,		/* Pointer to a buffer to return the volume label */
// 3580 	DWORD* sn			/* Pointer to a variable to return the volume serial number */
// 3581 )
// 3582 {
// 3583 	FRESULT res;
// 3584 	DIR dj;
// 3585 	UINT i, j;
// 3586 
// 3587 
// 3588 	/* Get logical drive */
// 3589 	res = chk_mounted(&path, &dj.fs, 0);
// 3590 
// 3591 	/* Get volume label */
// 3592 	if (res == FR_OK && label) {
// 3593 		dj.sclust = 0;					/* Open root dir */
// 3594 		res = dir_sdi(&dj, 0);
// 3595 		if (res == FR_OK) {
// 3596 			res = dir_read(&dj, 1);		/* Get an entry with AM_VOL */
// 3597 			if (res == FR_OK) {			/* A volume label is exist */
// 3598 #if _LFN_UNICODE
// 3599 				WCHAR w;
// 3600 				i = j = 0;
// 3601 				do {
// 3602 					w = (i < 11) ? dj.dir[i++] : ' ';
// 3603 					if (IsDBCS1(w) && i < 11 && IsDBCS2(dj.dir[i]))
// 3604 						w = (w << 8) | dj.dir[i++];
// 3605 					label[j++] = ff_convert(w, 1);
// 3606 				} while (j < 11);
// 3607 #else
// 3608 				mem_cpy(label, dj.dir, 11);
// 3609 #endif
// 3610 				j = 11;
// 3611 				do {
// 3612 					label[j] = 0;
// 3613 					if (!j) break;
// 3614 				} while (label[--j] == ' ');
// 3615 			}
// 3616 			if (res == FR_NO_FILE) {	/* No label, return nul string */
// 3617 				label[0] = 0;
// 3618 				res = FR_OK;
// 3619 			}
// 3620 		}
// 3621 	}
// 3622 
// 3623 	/* Get volume serial number */
// 3624 	if (res == FR_OK && sn) {
// 3625 		res = move_window(dj.fs, dj.fs->volbase);
// 3626 		if (res == FR_OK) {
// 3627 			i = dj.fs->fs_type == FS_FAT32 ? BS_VolID32 : BS_VolID;
// 3628 			*sn = LD_DWORD(&dj.fs->win[i]);
// 3629 		}
// 3630 	}
// 3631 
// 3632 	LEAVE_FF(dj.fs, res);
// 3633 }
// 3634 
// 3635 
// 3636 
// 3637 #if !_FS_READONLY
// 3638 /*-----------------------------------------------------------------------*/
// 3639 /* Set volume label                                                      */
// 3640 /*-----------------------------------------------------------------------*/
// 3641 
// 3642 FRESULT f_setlabel (
// 3643 	const TCHAR* label	/* Pointer to the volume label to set */
// 3644 )
// 3645 {
// 3646 	FRESULT res;
// 3647 	DIR dj;
// 3648 	BYTE vn[11];
// 3649 	UINT i, j, sl;
// 3650 	WCHAR w;
// 3651 	DWORD tm;
// 3652 
// 3653 
// 3654 	/* Get logical drive */
// 3655 	res = chk_mounted(&label, &dj.fs, 1);
// 3656 	if (res) LEAVE_FF(dj.fs, res);
// 3657 
// 3658 	/* Create a volume label in directory form */
// 3659 	vn[0] = 0;
// 3660 	for (sl = 0; label[sl]; sl++) ;				/* Get name length */
// 3661 	for ( ; sl && label[sl-1] == ' '; sl--) ;	/* Remove trailing spaces */
// 3662 	if (sl) {	/* Create volume label in directory form */
// 3663 		i = j = 0;
// 3664 		do {
// 3665 #if _LFN_UNICODE
// 3666 			w = ff_convert(ff_wtoupper(label[i++]), 0);
// 3667 #else
// 3668 			w = (BYTE)label[i++];
// 3669 			if (IsDBCS1(w))
// 3670 				w = (j < 10 && i < sl && IsDBCS2(label[i])) ? (w << 8) | (BYTE)label[i++] : 0;
// 3671 #if _USE_LFN
// 3672 			w = ff_convert(ff_wtoupper(ff_convert(w, 1)), 0);
// 3673 #else
// 3674 			if (IsLower(w)) w -= 0x20;			/* To upper ASCII chars */
// 3675 #ifdef _EXCVT
// 3676 			if (w >= 0x80) w = ExCvt[w - 0x80];	/* To upper extended chars (SBCS cfg) */
// 3677 #else
// 3678 			if (!_DF1S && w >= 0x80) w = 0;		/* Reject extended chars (ASCII cfg) */
// 3679 #endif
// 3680 #endif
// 3681 #endif
// 3682 			if (!w || chk_chr("\"*+,.:;<=>\?[]|\x7F", w) || j >= (UINT)((w >= 0x100) ? 10 : 11)) /* Reject invalid chars for volume label */
// 3683 				LEAVE_FF(dj.fs, FR_INVALID_NAME);
// 3684 			if (w >= 0x100) vn[j++] = (BYTE)(w >> 8);
// 3685 			vn[j++] = (BYTE)w;
// 3686 		} while (i < sl);
// 3687 		while (j < 11) vn[j++] = ' ';
// 3688 	}
// 3689 
// 3690 	/* Set volume label */
// 3691 	dj.sclust = 0;					/* Open root dir */
// 3692 	res = dir_sdi(&dj, 0);
// 3693 	if (res == FR_OK) {
// 3694 		res = dir_read(&dj, 1);		/* Get an entry with AM_VOL */
// 3695 		if (res == FR_OK) {			/* A volume label is found */
// 3696 			if (vn[0]) {
// 3697 				mem_cpy(dj.dir, vn, 11);	/* Change the volume label name */
// 3698 				tm = get_fattime();
// 3699 				ST_DWORD(dj.dir+DIR_WrtTime, tm);
// 3700 			} else {
// 3701 				dj.dir[0] = DDE;			/* Remove the volume label */
// 3702 			}
// 3703 			dj.fs->wflag = 1;
// 3704 			res = sync_fs(dj.fs);
// 3705 		} else {					/* No volume label is found or error */
// 3706 			if (res == FR_NO_FILE) {
// 3707 				res = FR_OK;
// 3708 				if (vn[0]) {				/* Create volume label as new */
// 3709 					res = dir_alloc(&dj, 1);	/* Allocate an entry for volume label */
// 3710 					if (res == FR_OK) {
// 3711 						mem_set(dj.dir, 0, SZ_DIR);	/* Set volume label */
// 3712 						mem_cpy(dj.dir, vn, 11);
// 3713 						dj.dir[DIR_Attr] = AM_VOL;
// 3714 						tm = get_fattime();
// 3715 						ST_DWORD(dj.dir+DIR_WrtTime, tm);
// 3716 						dj.fs->wflag = 1;
// 3717 						res = sync_fs(dj.fs);
// 3718 					}
// 3719 				}
// 3720 			}
// 3721 		}
// 3722 	}
// 3723 
// 3724 	LEAVE_FF(dj.fs, res);
// 3725 }
// 3726 
// 3727 #endif /* !_FS_READONLY */
// 3728 #endif /* _USE_LABEL */
// 3729 
// 3730 
// 3731 
// 3732 /*-----------------------------------------------------------------------*/
// 3733 /* Forward data to the stream directly (available on only tiny cfg)      */
// 3734 /*-----------------------------------------------------------------------*/
// 3735 #if _USE_FORWARD && _FS_TINY
// 3736 
// 3737 FRESULT f_forward (
// 3738 	FIL *fp, 						/* Pointer to the file object */
// 3739 	UINT (*func)(const BYTE*,UINT),	/* Pointer to the streaming function */
// 3740 	UINT btf,						/* Number of bytes to forward */
// 3741 	UINT *bf						/* Pointer to number of bytes forwarded */
// 3742 )
// 3743 {
// 3744 	FRESULT res;
// 3745 	DWORD remain, clst, sect;
// 3746 	UINT rcnt;
// 3747 	BYTE csect;
// 3748 
// 3749 
// 3750 	*bf = 0;	/* Clear transfer byte counter */
// 3751 
// 3752 	res = validate(fp);								/* Check validity of the object */
// 3753 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
// 3754 	if (fp->flag & FA__ERROR)						/* Check error flag */
// 3755 		LEAVE_FF(fp->fs, FR_INT_ERR);
// 3756 	if (!(fp->flag & FA_READ))						/* Check access mode */
// 3757 		LEAVE_FF(fp->fs, FR_DENIED);
// 3758 
// 3759 	remain = fp->fsize - fp->fptr;
// 3760 	if (btf > remain) btf = (UINT)remain;			/* Truncate btf by remaining bytes */
// 3761 
// 3762 	for ( ;  btf && (*func)(0, 0);					/* Repeat until all data transferred or stream becomes busy */
// 3763 		fp->fptr += rcnt, *bf += rcnt, btf -= rcnt) {
// 3764 		csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 3765 		if ((fp->fptr % SS(fp->fs)) == 0) {			/* On the sector boundary? */
// 3766 			if (!csect) {							/* On the cluster boundary? */
// 3767 				clst = (fp->fptr == 0) ?			/* On the top of the file? */
// 3768 					fp->sclust : get_fat(fp->fs, fp->clust);
// 3769 				if (clst <= 1) ABORT(fp->fs, FR_INT_ERR);
// 3770 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 3771 				fp->clust = clst;					/* Update current cluster */
// 3772 			}
// 3773 		}
// 3774 		sect = clust2sect(fp->fs, fp->clust);		/* Get current data sector */
// 3775 		if (!sect) ABORT(fp->fs, FR_INT_ERR);
// 3776 		sect += csect;
// 3777 		if (move_window(fp->fs, sect))				/* Move sector window */
// 3778 			ABORT(fp->fs, FR_DISK_ERR);
// 3779 		fp->dsect = sect;
// 3780 		rcnt = SS(fp->fs) - (WORD)(fp->fptr % SS(fp->fs));	/* Forward data from sector window */
// 3781 		if (rcnt > btf) rcnt = btf;
// 3782 		rcnt = (*func)(&fp->fs->win[(WORD)fp->fptr % SS(fp->fs)], rcnt);
// 3783 		if (!rcnt) ABORT(fp->fs, FR_INT_ERR);
// 3784 	}
// 3785 
// 3786 	LEAVE_FF(fp->fs, FR_OK);
// 3787 }
// 3788 #endif /* _USE_FORWARD */
// 3789 
// 3790 
// 3791 
// 3792 #if _USE_MKFS && !_FS_READONLY
// 3793 /*-----------------------------------------------------------------------*/
// 3794 /* Create File System on the Drive                                       */
// 3795 /*-----------------------------------------------------------------------*/
// 3796 #define N_ROOTDIR	512		/* Number of root dir entries for FAT12/16 */
// 3797 #define N_FATS		1		/* Number of FAT copies (1 or 2) */
// 3798 
// 3799 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3800 FRESULT f_mkfs (
// 3801 	BYTE vol,		/* Logical drive number */
// 3802 	BYTE sfd,		/* Partitioning rule 0:FDISK, 1:SFD */
// 3803 	UINT au			/* Allocation unit size [bytes] */
// 3804 )
// 3805 {
f_mkfs:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+28
        MOV      R10,R1
        MOVS     R4,R2
// 3806 	static const WORD vst[] = { 1024,   512,  256,  128,   64,    32,   16,    8,    4,    2,   0};
// 3807 	static const WORD cst[] = {32768, 16384, 8192, 4096, 2048, 16384, 8192, 4096, 2048, 1024, 512};
// 3808 	BYTE fmt, md, sys, *tbl, pdrv, part;
// 3809 	DWORD n_clst, vs, n, wsect;
// 3810 	UINT i;
// 3811 	DWORD b_vol, b_fat, b_dir, b_data;	/* LBA */
// 3812 	DWORD n_vol, n_rsv, n_fat, n_dir;	/* Size */
// 3813 	FATFS *fs;
// 3814 	DSTATUS stat;
// 3815 
// 3816 
// 3817 	/* Check mounted drive and clear work area */
// 3818 	if (vol >= _VOLUMES) return FR_INVALID_DRIVE;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_0
        MOVS     R0,#+11
        B.N      ??f_mkfs_1
// 3819 	if (sfd > 1) return FR_INVALID_PARAMETER;
??f_mkfs_0:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+2
        BLT.N    ??f_mkfs_2
        MOVS     R0,#+19
        B.N      ??f_mkfs_1
// 3820 	if (au & (au - 1)) return FR_INVALID_PARAMETER;
??f_mkfs_2:
        SUBS     R1,R4,#+1
        TST      R4,R1
        BEQ.N    ??f_mkfs_3
        MOVS     R0,#+19
        B.N      ??f_mkfs_1
// 3821 	fs = FatFs[vol];
??f_mkfs_3:
        LDR.W    R1,??DataTable14
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R1,[R1, R0, LSL #+2]
        STR      R1,[SP, #+12]
// 3822 	if (!fs) return FR_NOT_ENABLED;
        LDR      R1,[SP, #+12]
        CMP      R1,#+0
        BNE.N    ??f_mkfs_4
        MOVS     R0,#+12
        B.N      ??f_mkfs_1
// 3823 	fs->fs_type = 0;
??f_mkfs_4:
        MOVS     R1,#+0
        LDR      R2,[SP, #+12]
        STRB     R1,[R2, #+0]
// 3824 	pdrv = LD2PD(vol);	/* Physical drive */
        STRB     R0,[SP, #+8]
// 3825 	part = LD2PT(vol);	/* Partition (0:auto detect, 1-4:get from partition table)*/
        MOVS     R5,#+0
// 3826 
// 3827 	/* Get disk statics */
// 3828 	stat = disk_initialize(pdrv);
        LDRB     R0,[SP, #+8]
        BL       disk_initialize
// 3829 	if (stat & STA_NOINIT) return FR_NOT_READY;
        LSLS     R1,R0,#+31
        BPL.N    ??f_mkfs_5
        MOVS     R0,#+3
        B.N      ??f_mkfs_1
// 3830 	if (stat & STA_PROTECT) return FR_WRITE_PROTECTED;
??f_mkfs_5:
        LSLS     R0,R0,#+29
        BPL.N    ??f_mkfs_6
        MOVS     R0,#+10
        B.N      ??f_mkfs_1
// 3831 #if _MAX_SS != 512					/* Get disk sector size */
// 3832 	if (disk_ioctl(pdrv, GET_SECTOR_SIZE, &SS(fs)) != RES_OK || SS(fs) > _MAX_SS)
// 3833 		return FR_DISK_ERR;
// 3834 #endif
// 3835 	if (_MULTI_PARTITION && part) {
// 3836 		/* Get partition information from partition table in the MBR */
// 3837 		if (disk_read(pdrv, fs->win, 0, 1) != RES_OK) return FR_DISK_ERR;
// 3838 		if (LD_WORD(fs->win+BS_55AA) != 0xAA55) return FR_MKFS_ABORTED;
// 3839 		tbl = &fs->win[MBR_Table + (part - 1) * SZ_PTE];
// 3840 		if (!tbl[4]) return FR_MKFS_ABORTED;	/* No partition? */
// 3841 		b_vol = LD_DWORD(tbl+8);	/* Volume start sector */
// 3842 		n_vol = LD_DWORD(tbl+12);	/* Volume size */
// 3843 	} else {
// 3844 		/* Create a partition in this function */
// 3845 		if (disk_ioctl(pdrv, GET_SECTOR_COUNT, &n_vol) != RES_OK || n_vol < 128)
??f_mkfs_6:
        ADD      R2,SP,#+4
        MOVS     R1,#+1
        LDRB     R0,[SP, #+8]
        BL       disk_ioctl
        CMP      R0,#+0
        BNE.N    ??f_mkfs_7
        LDR      R0,[SP, #+4]
        CMP      R0,#+128
        BCS.N    ??f_mkfs_8
// 3846 			return FR_DISK_ERR;
??f_mkfs_7:
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3847 		b_vol = (sfd) ? 0 : 63;		/* Volume start sector */
??f_mkfs_8:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??f_mkfs_9
        MOVS     R7,#+0
        B.N      ??f_mkfs_10
??f_mkfs_9:
        MOVS     R7,#+63
// 3848 		n_vol -= b_vol;				/* Volume size */
??f_mkfs_10:
        LDR      R0,[SP, #+4]
        SUBS     R0,R0,R7
        STR      R0,[SP, #+4]
// 3849 	}
// 3850 
// 3851 	if (!au) {				/* AU auto selection */
        CMP      R4,#+0
        BNE.N    ??f_mkfs_11
// 3852 		vs = n_vol / (2000 / (SS(fs) / 512));
        LDR      R0,[SP, #+4]
        MOV      R1,#+2000
        UDIV     R0,R0,R1
// 3853 		for (i = 0; vs < vst[i]; i++) ;
        MOVS     R11,#+0
        B.N      ??f_mkfs_12
??f_mkfs_13:
        ADDS     R11,R11,#+1
??f_mkfs_12:
        LDR.W    R1,??DataTable14_1
        LDRH     R1,[R1, R11, LSL #+1]
        CMP      R0,R1
        BCC.N    ??f_mkfs_13
// 3854 		au = cst[i];
        LDR.W    R0,??DataTable14_2
        LDRH     R4,[R0, R11, LSL #+1]
// 3855 	}
// 3856 	au /= SS(fs);		/* Number of sectors per cluster */
??f_mkfs_11:
        LSRS     R4,R4,#+9
// 3857 	if (au == 0) au = 1;
        CMP      R4,#+0
        BNE.N    ??f_mkfs_14
        MOVS     R4,#+1
// 3858 	if (au > 128) au = 128;
??f_mkfs_14:
        CMP      R4,#+129
        BCC.N    ??f_mkfs_15
        MOVS     R4,#+128
// 3859 
// 3860 	/* Pre-compute number of clusters and FAT sub-type */
// 3861 	n_clst = n_vol / au;
??f_mkfs_15:
        LDR      R0,[SP, #+4]
        UDIV     R6,R0,R4
// 3862 	fmt = FS_FAT12;
        MOVS     R5,#+1
// 3863 	if (n_clst >= MIN_FAT16) fmt = FS_FAT16;
        MOVW     R0,#+4086
        CMP      R6,R0
        BCC.N    ??f_mkfs_16
        MOVS     R5,#+2
// 3864 	if (n_clst >= MIN_FAT32) fmt = FS_FAT32;
??f_mkfs_16:
        MOVW     R0,#+65526
        CMP      R6,R0
        BCC.N    ??f_mkfs_17
        MOVS     R5,#+3
// 3865 
// 3866 	/* Determine offset and size of FAT structure */
// 3867 	if (fmt == FS_FAT32) {
??f_mkfs_17:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_18
// 3868 		n_fat = ((n_clst * 4) + 8 + SS(fs) - 1) / SS(fs);
        LSLS     R0,R6,#+2
        ADDW     R0,R0,#+519
        LSRS     R9,R0,#+9
// 3869 		n_rsv = 32;
        MOVS     R8,#+32
// 3870 		n_dir = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+16]
        B.N      ??f_mkfs_19
// 3871 	} else {
// 3872 		n_fat = (fmt == FS_FAT12) ? (n_clst * 3 + 1) / 2 + 3 : (n_clst * 2) + 4;
??f_mkfs_18:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??f_mkfs_20
        MOVS     R0,#+3
        MUL      R0,R0,R6
        ADDS     R0,R0,#+1
        LSRS     R0,R0,#+1
        ADDS     R9,R0,#+3
        B.N      ??f_mkfs_21
??f_mkfs_20:
        LSLS     R0,R6,#+1
        ADDS     R9,R0,#+4
// 3873 		n_fat = (n_fat + SS(fs) - 1) / SS(fs);
??f_mkfs_21:
        ADDW     R0,R9,#+511
        LSRS     R9,R0,#+9
// 3874 		n_rsv = 1;
        MOVS     R8,#+1
// 3875 		n_dir = (DWORD)N_ROOTDIR * SZ_DIR / SS(fs);
        MOVS     R0,#+32
        STR      R0,[SP, #+16]
// 3876 	}
// 3877 	b_fat = b_vol + n_rsv;				/* FAT area start sector */
??f_mkfs_19:
        ADDS     R0,R8,R7
        STR      R0,[SP, #+20]
// 3878 	b_dir = b_fat + n_fat * N_FATS;		/* Directory area start sector */
        LDR      R0,[SP, #+20]
        ADDS     R0,R9,R0
// 3879 	b_data = b_dir + n_dir;				/* Data area start sector */
        LDR      R1,[SP, #+16]
        ADDS     R6,R1,R0
// 3880 	if (n_vol < b_data + au - b_vol) return FR_MKFS_ABORTED;	/* Too small volume */
        LDR      R0,[SP, #+4]
        ADDS     R1,R4,R6
        SUBS     R1,R1,R7
        CMP      R0,R1
        BCS.N    ??f_mkfs_22
        MOVS     R0,#+14
        B.N      ??f_mkfs_1
// 3881 
// 3882 	/* Align data start sector to erase block boundary (for flash memory media) */
// 3883 	if (disk_ioctl(pdrv, GET_BLOCK_SIZE, &n) != RES_OK || !n || n > 32768) n = 1;
??f_mkfs_22:
        ADD      R2,SP,#+0
        MOVS     R1,#+3
        LDRB     R0,[SP, #+8]
        BL       disk_ioctl
        CMP      R0,#+0
        BNE.N    ??f_mkfs_23
        LDR      R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_23
        LDR      R0,[SP, #+0]
        CMP      R0,#+32768
        BLS.N    ??f_mkfs_24
??f_mkfs_23:
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
// 3884 	n = (b_data + n - 1) & ~(n - 1);	/* Next nearest erase block from current data start */
??f_mkfs_24:
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R6
        SUBS     R0,R0,#+1
        LDR      R1,[SP, #+0]
        SUBS     R1,R1,#+1
        BICS     R0,R0,R1
        STR      R0,[SP, #+0]
// 3885 	n = (n - b_data) / N_FATS;
        LDR      R0,[SP, #+0]
        SUBS     R0,R0,R6
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        STR      R0,[SP, #+0]
// 3886 	if (fmt == FS_FAT32) {		/* FAT32: Move FAT offset */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_25
// 3887 		n_rsv += n;
        LDR      R0,[SP, #+0]
        ADDS     R8,R0,R8
// 3888 		b_fat += n;
        LDR      R0,[SP, #+20]
        LDR      R1,[SP, #+0]
        ADDS     R0,R1,R0
        STR      R0,[SP, #+20]
        B.N      ??f_mkfs_26
// 3889 	} else {					/* FAT12/16: Expand FAT size */
// 3890 		n_fat += n;
??f_mkfs_25:
        LDR      R0,[SP, #+0]
        ADDS     R9,R0,R9
// 3891 	}
// 3892 
// 3893 	/* Determine number of clusters and final check of validity of the FAT sub-type */
// 3894 	n_clst = (n_vol - n_rsv - n_fat * N_FATS - n_dir) / au;
??f_mkfs_26:
        LDR      R0,[SP, #+4]
        SUBS     R0,R0,R8
        SUBS     R0,R0,R9
        LDR      R1,[SP, #+16]
        SUBS     R0,R0,R1
        UDIV     R6,R0,R4
// 3895 	if (   (fmt == FS_FAT16 && n_clst < MIN_FAT16)
// 3896 		|| (fmt == FS_FAT32 && n_clst < MIN_FAT32))
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BNE.N    ??f_mkfs_27
        MOVW     R0,#+4086
        CMP      R6,R0
        BCC.N    ??f_mkfs_28
??f_mkfs_27:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_29
        MOVW     R0,#+65526
        CMP      R6,R0
        BCS.N    ??f_mkfs_29
// 3897 		return FR_MKFS_ABORTED;
??f_mkfs_28:
        MOVS     R0,#+14
        B.N      ??f_mkfs_1
// 3898 
// 3899 	switch (fmt) {	/* Determine system ID for partition table */
??f_mkfs_29:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        MOVS     R0,R5
        CMP      R0,#+1
        BEQ.N    ??f_mkfs_30
        CMP      R0,#+2
        BEQ.N    ??f_mkfs_31
        B.N      ??f_mkfs_32
// 3900 	case FS_FAT12:	sys = 0x01; break;
??f_mkfs_30:
        MOVS     R11,#+1
        B.N      ??f_mkfs_33
// 3901 	case FS_FAT16:	sys = (n_vol < 0x10000) ? 0x04 : 0x06; break;
??f_mkfs_31:
        LDR      R0,[SP, #+4]
        CMP      R0,#+65536
        BCS.N    ??f_mkfs_34
        MOVS     R11,#+4
        B.N      ??f_mkfs_35
??f_mkfs_34:
        MOVS     R11,#+6
??f_mkfs_35:
        B.N      ??f_mkfs_33
// 3902 	default: 		sys = 0x0C;
??f_mkfs_32:
        MOVS     R11,#+12
// 3903 	}
// 3904 
// 3905 	if (_MULTI_PARTITION && part) {
// 3906 		/* Update system ID in the partition table */
// 3907 		tbl = &fs->win[MBR_Table + (part - 1) * SZ_PTE];
// 3908 		tbl[4] = sys;
// 3909 		if (disk_write(pdrv, fs->win, 0, 1) != RES_OK) return FR_DISK_ERR;
// 3910 		md = 0xF8;
// 3911 	} else {
// 3912 		if (sfd) {	/* No partition table (SFD) */
??f_mkfs_33:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??f_mkfs_36
// 3913 			md = 0xF0;
        MOVS     R0,#+240
        STRB     R0,[SP, #+9]
        B.N      ??f_mkfs_37
// 3914 		} else {	/* Create partition table (FDISK) */
// 3915 			mem_set(fs->win, 0, SS(fs));
??f_mkfs_36:
        MOV      R2,#+512
        MOVS     R1,#+0
        LDR      R0,[SP, #+12]
        ADDS     R0,R0,#+56
        BL       mem_set
// 3916 			tbl = fs->win+MBR_Table;	/* Create partition table for single partition in the drive */
        LDR      R0,[SP, #+12]
        ADDS     R10,R0,#+502
// 3917 			tbl[1] = 1;						/* Partition start head */
        MOVS     R0,#+1
        STRB     R0,[R10, #+1]
// 3918 			tbl[2] = 1;						/* Partition start sector */
        MOVS     R0,#+1
        STRB     R0,[R10, #+2]
// 3919 			tbl[3] = 0;						/* Partition start cylinder */
        MOVS     R0,#+0
        STRB     R0,[R10, #+3]
// 3920 			tbl[4] = sys;					/* System type */
        STRB     R11,[R10, #+4]
// 3921 			tbl[5] = 254;					/* Partition end head */
        MOVS     R0,#+254
        STRB     R0,[R10, #+5]
// 3922 			n = (b_vol + n_vol) / 63 / 255;
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,R7
        MOVS     R1,#+63
        UDIV     R0,R0,R1
        MOVS     R1,#+255
        UDIV     R0,R0,R1
        STR      R0,[SP, #+0]
// 3923 			tbl[6] = (BYTE)((n >> 2) | 63);	/* Partition end sector */
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+2
        ORRS     R0,R0,#0x3F
        STRB     R0,[R10, #+6]
// 3924 			tbl[7] = (BYTE)n;				/* End cylinder */
        LDR      R0,[SP, #+0]
        STRB     R0,[R10, #+7]
// 3925 			ST_DWORD(tbl+8, 63);			/* Partition start in LBA */
        MOVS     R0,#+63
        STRB     R0,[R10, #+8]
        MOVS     R0,#+0
        STRB     R0,[R10, #+9]
        MOVS     R0,#+0
        STRB     R0,[R10, #+10]
        MOVS     R0,#+0
        STRB     R0,[R10, #+11]
// 3926 			ST_DWORD(tbl+12, n_vol);		/* Partition size in LBA */
        LDR      R0,[SP, #+4]
        STRB     R0,[R10, #+12]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+13]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+16
        STRB     R0,[R10, #+14]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+24
        STRB     R0,[R10, #+15]
// 3927 			ST_WORD(fs->win+BS_55AA, 0xAA55);	/* MBR signature */
        MOVS     R0,#+85
        LDR      R1,[SP, #+12]
        STRB     R0,[R1, #+566]
        MOVS     R0,#+170
        LDR      R1,[SP, #+12]
        STRB     R0,[R1, #+567]
// 3928 			if (disk_write(pdrv, fs->win, 0, 1) != RES_OK)	/* Write it to the MBR sector */
        MOVS     R3,#+1
        MOVS     R2,#+0
        LDR      R0,[SP, #+12]
        ADDS     R1,R0,#+56
        LDRB     R0,[SP, #+8]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_38
// 3929 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3930 			md = 0xF8;
??f_mkfs_38:
        MOVS     R0,#+248
        STRB     R0,[SP, #+9]
// 3931 		}
// 3932 	}
// 3933 
// 3934 	/* Create BPB in the VBR */
// 3935 	tbl = fs->win;							/* Clear sector */
??f_mkfs_37:
        LDR      R0,[SP, #+12]
        ADDS     R10,R0,#+56
// 3936 	mem_set(tbl, 0, SS(fs));
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R10
        BL       mem_set
// 3937 	mem_cpy(tbl, "\xEB\xFE\x90" "MSDOS5.0", 11);/* Boot jump code, OEM name */
        MOVS     R2,#+11
        LDR.W    R1,??DataTable14_3
        MOV      R0,R10
        BL       mem_cpy
// 3938 	i = SS(fs);								/* Sector size */
        MOV      R11,#+512
// 3939 	ST_WORD(tbl+BPB_BytsPerSec, i);
        STRB     R11,[R10, #+11]
        UXTH     R11,R11          ;; ZeroExt  R11,R11,#+16,#+16
        LSRS     R0,R11,#+8
        STRB     R0,[R10, #+12]
// 3940 	tbl[BPB_SecPerClus] = (BYTE)au;			/* Sectors per cluster */
        STRB     R4,[R10, #+13]
// 3941 	ST_WORD(tbl+BPB_RsvdSecCnt, n_rsv);		/* Reserved sectors */
        STRB     R8,[R10, #+14]
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        LSRS     R0,R8,#+8
        STRB     R0,[R10, #+15]
// 3942 	tbl[BPB_NumFATs] = N_FATS;				/* Number of FATs */
        MOVS     R0,#+1
        STRB     R0,[R10, #+16]
// 3943 	i = (fmt == FS_FAT32) ? 0 : N_ROOTDIR;	/* Number of rootdir entries */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_39
        MOVS     R11,#+0
        B.N      ??f_mkfs_40
??f_mkfs_39:
        MOV      R11,#+512
// 3944 	ST_WORD(tbl+BPB_RootEntCnt, i);
??f_mkfs_40:
        STRB     R11,[R10, #+17]
        UXTH     R11,R11          ;; ZeroExt  R11,R11,#+16,#+16
        LSRS     R0,R11,#+8
        STRB     R0,[R10, #+18]
// 3945 	if (n_vol < 0x10000) {					/* Number of total sectors */
        LDR      R0,[SP, #+4]
        CMP      R0,#+65536
        BCS.N    ??f_mkfs_41
// 3946 		ST_WORD(tbl+BPB_TotSec16, n_vol);
        LDR      R0,[SP, #+4]
        STRB     R0,[R10, #+19]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+20]
        B.N      ??f_mkfs_42
// 3947 	} else {
// 3948 		ST_DWORD(tbl+BPB_TotSec32, n_vol);
??f_mkfs_41:
        LDR      R0,[SP, #+4]
        STRB     R0,[R10, #+32]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+33]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+16
        STRB     R0,[R10, #+34]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+24
        STRB     R0,[R10, #+35]
// 3949 	}
// 3950 	tbl[BPB_Media] = md;					/* Media descriptor */
??f_mkfs_42:
        LDRB     R0,[SP, #+9]
        STRB     R0,[R10, #+21]
// 3951 	ST_WORD(tbl+BPB_SecPerTrk, 63);			/* Number of sectors per track */
        MOVS     R0,#+63
        STRB     R0,[R10, #+24]
        MOVS     R0,#+0
        STRB     R0,[R10, #+25]
// 3952 	ST_WORD(tbl+BPB_NumHeads, 255);			/* Number of heads */
        MOVS     R0,#+255
        STRB     R0,[R10, #+26]
        MOVS     R0,#+0
        STRB     R0,[R10, #+27]
// 3953 	ST_DWORD(tbl+BPB_HiddSec, b_vol);		/* Hidden sectors */
        STRB     R7,[R10, #+28]
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+29]
        LSRS     R0,R7,#+16
        STRB     R0,[R10, #+30]
        LSRS     R0,R7,#+24
        STRB     R0,[R10, #+31]
// 3954 	n = get_fattime();						/* Use current time as VSN */
        BL       get_fattime
        STR      R0,[SP, #+0]
// 3955 	if (fmt == FS_FAT32) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_43
// 3956 		ST_DWORD(tbl+BS_VolID32, n);		/* VSN */
        LDR      R0,[SP, #+0]
        STRB     R0,[R10, #+67]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+68]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R10, #+69]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R10, #+70]
// 3957 		ST_DWORD(tbl+BPB_FATSz32, n_fat);	/* Number of sectors per FAT */
        STRB     R9,[R10, #+36]
        MOV      R0,R9
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+37]
        LSRS     R0,R9,#+16
        STRB     R0,[R10, #+38]
        LSRS     R0,R9,#+24
        STRB     R0,[R10, #+39]
// 3958 		ST_DWORD(tbl+BPB_RootClus, 2);		/* Root directory start cluster (2) */
        MOVS     R0,#+2
        STRB     R0,[R10, #+44]
        MOVS     R0,#+0
        STRB     R0,[R10, #+45]
        MOVS     R0,#+0
        STRB     R0,[R10, #+46]
        MOVS     R0,#+0
        STRB     R0,[R10, #+47]
// 3959 		ST_WORD(tbl+BPB_FSInfo, 1);			/* FSInfo record offset (VBR+1) */
        MOVS     R0,#+1
        STRB     R0,[R10, #+48]
        MOVS     R0,#+0
        STRB     R0,[R10, #+49]
// 3960 		ST_WORD(tbl+BPB_BkBootSec, 6);		/* Backup boot record offset (VBR+6) */
        MOVS     R0,#+6
        STRB     R0,[R10, #+50]
        MOVS     R0,#+0
        STRB     R0,[R10, #+51]
// 3961 		tbl[BS_DrvNum32] = 0x80;			/* Drive number */
        MOVS     R0,#+128
        STRB     R0,[R10, #+64]
// 3962 		tbl[BS_BootSig32] = 0x29;			/* Extended boot signature */
        MOVS     R0,#+41
        STRB     R0,[R10, #+66]
// 3963 		mem_cpy(tbl+BS_VolLab32, "NO NAME    " "FAT32   ", 19);	/* Volume label, FAT signature */
        MOVS     R2,#+19
        LDR.N    R1,??DataTable14_4
        ADDS     R0,R10,#+71
        BL       mem_cpy
        B.N      ??f_mkfs_44
// 3964 	} else {
// 3965 		ST_DWORD(tbl+BS_VolID, n);			/* VSN */
??f_mkfs_43:
        LDR      R0,[SP, #+0]
        STRB     R0,[R10, #+39]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+40]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R10, #+41]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R10, #+42]
// 3966 		ST_WORD(tbl+BPB_FATSz16, n_fat);	/* Number of sectors per FAT */
        STRB     R9,[R10, #+22]
        MOV      R0,R9
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+23]
// 3967 		tbl[BS_DrvNum] = 0x80;				/* Drive number */
        MOVS     R0,#+128
        STRB     R0,[R10, #+36]
// 3968 		tbl[BS_BootSig] = 0x29;				/* Extended boot signature */
        MOVS     R0,#+41
        STRB     R0,[R10, #+38]
// 3969 		mem_cpy(tbl+BS_VolLab, "NO NAME    " "FAT     ", 19);	/* Volume label, FAT signature */
        MOVS     R2,#+19
        LDR.N    R1,??DataTable14_5
        ADDS     R0,R10,#+43
        BL       mem_cpy
// 3970 	}
// 3971 	ST_WORD(tbl+BS_55AA, 0xAA55);			/* Signature (Offset is fixed here regardless of sector size) */
??f_mkfs_44:
        MOVS     R0,#+85
        STRB     R0,[R10, #+510]
        MOVS     R0,#+170
        STRB     R0,[R10, #+511]
// 3972 	if (disk_write(pdrv, tbl, b_vol, 1) != RES_OK)	/* Write it to the VBR sector */
        MOVS     R3,#+1
        MOVS     R2,R7
        MOV      R1,R10
        LDRB     R0,[SP, #+8]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_45
// 3973 		return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3974 	if (fmt == FS_FAT32)							/* Write backup VBR if needed (VBR+6) */
??f_mkfs_45:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_46
// 3975 		disk_write(pdrv, tbl, b_vol + 6, 1);
        MOVS     R3,#+1
        ADDS     R2,R7,#+6
        MOV      R1,R10
        LDRB     R0,[SP, #+8]
        BL       disk_write
// 3976 
// 3977 	/* Initialize FAT area */
// 3978 	wsect = b_fat;
??f_mkfs_46:
        LDR      R8,[SP, #+20]
// 3979 	for (i = 0; i < N_FATS; i++) {		/* Initialize each FAT copy */
        MOVS     R11,#+0
        B.N      ??f_mkfs_47
??f_mkfs_48:
        ADDS     R11,R11,#+1
??f_mkfs_47:
        CMP      R11,#+0
        BNE.N    ??f_mkfs_49
// 3980 		mem_set(tbl, 0, SS(fs));			/* 1st sector of the FAT  */
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R10
        BL       mem_set
// 3981 		n = md;								/* Media descriptor byte */
        LDRB     R0,[SP, #+9]
        STR      R0,[SP, #+0]
// 3982 		if (fmt != FS_FAT32) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BEQ.N    ??f_mkfs_50
// 3983 			n |= (fmt == FS_FAT12) ? 0x00FFFF00 : 0xFFFFFF00;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??f_mkfs_51
        LDR.N    R0,??DataTable14_6  ;; 0xffff00
        B.N      ??f_mkfs_52
??f_mkfs_51:
        MVNS     R0,#+255
??f_mkfs_52:
        LDR      R1,[SP, #+0]
        ORRS     R0,R0,R1
        STR      R0,[SP, #+0]
// 3984 			ST_DWORD(tbl+0, n);				/* Reserve cluster #0-1 (FAT12/16) */
        LDR      R0,[SP, #+0]
        STRB     R0,[R10, #+0]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+1]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R10, #+2]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R10, #+3]
        B.N      ??f_mkfs_53
// 3985 		} else {
// 3986 			n |= 0xFFFFFF00;
??f_mkfs_50:
        LDR      R0,[SP, #+0]
        ORNS     R0,R0,#+255
        STR      R0,[SP, #+0]
// 3987 			ST_DWORD(tbl+0, n);				/* Reserve cluster #0-1 (FAT32) */
        LDR      R0,[SP, #+0]
        STRB     R0,[R10, #+0]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+1]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R10, #+2]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R10, #+3]
// 3988 			ST_DWORD(tbl+4, 0xFFFFFFFF);
        MOVS     R0,#+255
        STRB     R0,[R10, #+4]
        MOVS     R0,#+255
        STRB     R0,[R10, #+5]
        MOVS     R0,#+255
        STRB     R0,[R10, #+6]
        MOVS     R0,#+255
        STRB     R0,[R10, #+7]
// 3989 			ST_DWORD(tbl+8, 0x0FFFFFFF);	/* Reserve cluster #2 for root dir */
        MOVS     R0,#+255
        STRB     R0,[R10, #+8]
        MOVS     R0,#+255
        STRB     R0,[R10, #+9]
        MOVS     R0,#+255
        STRB     R0,[R10, #+10]
        MOVS     R0,#+15
        STRB     R0,[R10, #+11]
// 3990 		}
// 3991 		if (disk_write(pdrv, tbl, wsect++, 1) != RES_OK)
??f_mkfs_53:
        MOVS     R3,#+1
        MOV      R2,R8
        MOV      R1,R10
        LDRB     R0,[SP, #+8]
        BL       disk_write
        ADDS     R8,R8,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_54
// 3992 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3993 		mem_set(tbl, 0, SS(fs));			/* Fill following FAT entries with zero */
??f_mkfs_54:
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R10
        BL       mem_set
// 3994 		for (n = 1; n < n_fat; n++) {		/* This loop may take a time on FAT32 volume due to many single sector writes */
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
        B.N      ??f_mkfs_55
??f_mkfs_56:
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
??f_mkfs_55:
        LDR      R0,[SP, #+0]
        CMP      R0,R9
        BCS.N    ??f_mkfs_48
// 3995 			if (disk_write(pdrv, tbl, wsect++, 1) != RES_OK)
        MOVS     R3,#+1
        MOV      R2,R8
        MOV      R1,R10
        LDRB     R0,[SP, #+8]
        BL       disk_write
        ADDS     R8,R8,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_56
// 3996 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3997 		}
// 3998 	}
// 3999 
// 4000 	/* Initialize root directory */
// 4001 	i = (fmt == FS_FAT32) ? au : n_dir;
??f_mkfs_49:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_57
        MOV      R11,R4
        B.N      ??f_mkfs_58
??f_mkfs_57:
        LDR      R11,[SP, #+16]
// 4002 	do {
// 4003 		if (disk_write(pdrv, tbl, wsect++, 1) != RES_OK)
??f_mkfs_58:
        MOVS     R3,#+1
        MOV      R2,R8
        MOV      R1,R10
        LDRB     R0,[SP, #+8]
        BL       disk_write
        ADDS     R8,R8,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_59
// 4004 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 4005 	} while (--i);
??f_mkfs_59:
        SUBS     R11,R11,#+1
        CMP      R11,#+0
        BNE.N    ??f_mkfs_58
// 4006 
// 4007 #if _USE_ERASE	/* Erase data area if needed */
// 4008 	{
// 4009 		DWORD eb[2];
// 4010 
// 4011 		eb[0] = wsect; eb[1] = wsect + (n_clst - ((fmt == FS_FAT32) ? 1 : 0)) * au - 1;
// 4012 		disk_ioctl(pdrv, CTRL_ERASE_SECTOR, eb);
// 4013 	}
// 4014 #endif
// 4015 
// 4016 	/* Create FSInfo if needed */
// 4017 	if (fmt == FS_FAT32) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_60
// 4018 		ST_DWORD(tbl+FSI_LeadSig, 0x41615252);
        MOVS     R0,#+82
        STRB     R0,[R10, #+0]
        MOVS     R0,#+82
        STRB     R0,[R10, #+1]
        MOVS     R0,#+97
        STRB     R0,[R10, #+2]
        MOVS     R0,#+65
        STRB     R0,[R10, #+3]
// 4019 		ST_DWORD(tbl+FSI_StrucSig, 0x61417272);
        MOVS     R0,#+114
        STRB     R0,[R10, #+484]
        MOVS     R0,#+114
        STRB     R0,[R10, #+485]
        MOVS     R0,#+65
        STRB     R0,[R10, #+486]
        MOVS     R0,#+97
        STRB     R0,[R10, #+487]
// 4020 		ST_DWORD(tbl+FSI_Free_Count, n_clst - 1);	/* Number of free clusters */
        MOVS     R0,R6
        SUBS     R0,R0,#+1
        STRB     R0,[R10, #+488]
        MOVS     R0,R6
        SUBS     R0,R0,#+1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R10, #+489]
        SUBS     R0,R6,#+1
        LSRS     R0,R0,#+16
        STRB     R0,[R10, #+490]
        SUBS     R0,R6,#+1
        LSRS     R0,R0,#+24
        STRB     R0,[R10, #+491]
// 4021 		ST_DWORD(tbl+FSI_Nxt_Free, 2);				/* Last allocated cluster# */
        MOVS     R0,#+2
        STRB     R0,[R10, #+492]
        MOVS     R0,#+0
        STRB     R0,[R10, #+493]
        MOVS     R0,#+0
        STRB     R0,[R10, #+494]
        MOVS     R0,#+0
        STRB     R0,[R10, #+495]
// 4022 		ST_WORD(tbl+BS_55AA, 0xAA55);
        MOVS     R0,#+85
        STRB     R0,[R10, #+510]
        MOVS     R0,#+170
        STRB     R0,[R10, #+511]
// 4023 		disk_write(pdrv, tbl, b_vol + 1, 1);	/* Write original (VBR+1) */
        MOVS     R3,#+1
        ADDS     R2,R7,#+1
        MOV      R1,R10
        LDRB     R0,[SP, #+8]
        BL       disk_write
// 4024 		disk_write(pdrv, tbl, b_vol + 7, 1);	/* Write backup (VBR+7) */
        MOVS     R3,#+1
        ADDS     R2,R7,#+7
        MOV      R1,R10
        LDRB     R0,[SP, #+8]
        BL       disk_write
// 4025 	}
// 4026 
// 4027 	return (disk_ioctl(pdrv, CTRL_SYNC, 0) == RES_OK) ? FR_OK : FR_DISK_ERR;
??f_mkfs_60:
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDRB     R0,[SP, #+8]
        BL       disk_ioctl
        CMP      R0,#+0
        BNE.N    ??f_mkfs_61
        MOVS     R0,#+0
        B.N      ??f_mkfs_62
??f_mkfs_61:
        MOVS     R0,#+1
??f_mkfs_62:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_mkfs_1:
        ADD      SP,SP,#+28
        POP      {R4-R11,PC}      ;; return
// 4028 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14:
        DC32     FatFs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_1:
        DC32     ??vst

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_2:
        DC32     ??cst

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_3:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_4:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_5:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_6:
        DC32     0xffff00

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
??vst:
        DATA
        DC16 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 0
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
??cst:
        DATA
        DC16 32768, 16384, 8192, 4096, 2048, 16384, 8192, 4096, 2048, 1024, 512
        DC8 0, 0
// 4029 
// 4030 
// 4031 #if _MULTI_PARTITION
// 4032 /*-----------------------------------------------------------------------*/
// 4033 /* Divide Physical Drive                                                 */
// 4034 /*-----------------------------------------------------------------------*/
// 4035 
// 4036 FRESULT f_fdisk (
// 4037 	BYTE pdrv,			/* Physical drive number */
// 4038 	const DWORD szt[],	/* Pointer to the size table for each partitions */
// 4039 	void* work			/* Pointer to the working buffer */
// 4040 )
// 4041 {
// 4042 	UINT i, n, sz_cyl, tot_cyl, b_cyl, e_cyl, p_cyl;
// 4043 	BYTE s_hd, e_hd, *p, *buf = (BYTE*)work;
// 4044 	DSTATUS stat;
// 4045 	DWORD sz_disk, sz_part, s_part;
// 4046 
// 4047 
// 4048 	stat = disk_initialize(pdrv);
// 4049 	if (stat & STA_NOINIT) return FR_NOT_READY;
// 4050 	if (stat & STA_PROTECT) return FR_WRITE_PROTECTED;
// 4051 	if (disk_ioctl(pdrv, GET_SECTOR_COUNT, &sz_disk)) return FR_DISK_ERR;
// 4052 
// 4053 	/* Determine CHS in the table regardless of the drive geometry */
// 4054 	for (n = 16; n < 256 && sz_disk / n / 63 > 1024; n *= 2) ;
// 4055 	if (n == 256) n--;
// 4056 	e_hd = n - 1;
// 4057 	sz_cyl = 63 * n;
// 4058 	tot_cyl = sz_disk / sz_cyl;
// 4059 
// 4060 	/* Create partition table */
// 4061 	mem_set(buf, 0, _MAX_SS);
// 4062 	p = buf + MBR_Table; b_cyl = 0;
// 4063 	for (i = 0; i < 4; i++, p += SZ_PTE) {
// 4064 		p_cyl = (szt[i] <= 100) ? (DWORD)tot_cyl * szt[i] / 100 : szt[i] / sz_cyl;
// 4065 		if (!p_cyl) continue;
// 4066 		s_part = (DWORD)sz_cyl * b_cyl;
// 4067 		sz_part = (DWORD)sz_cyl * p_cyl;
// 4068 		if (i == 0) {	/* Exclude first track of cylinder 0 */
// 4069 			s_hd = 1;
// 4070 			s_part += 63; sz_part -= 63;
// 4071 		} else {
// 4072 			s_hd = 0;
// 4073 		}
// 4074 		e_cyl = b_cyl + p_cyl - 1;
// 4075 		if (e_cyl >= tot_cyl) return FR_INVALID_PARAMETER;
// 4076 
// 4077 		/* Set partition table */
// 4078 		p[1] = s_hd;						/* Start head */
// 4079 		p[2] = (BYTE)((b_cyl >> 2) + 1);	/* Start sector */
// 4080 		p[3] = (BYTE)b_cyl;					/* Start cylinder */
// 4081 		p[4] = 0x06;						/* System type (temporary setting) */
// 4082 		p[5] = e_hd;						/* End head */
// 4083 		p[6] = (BYTE)((e_cyl >> 2) + 63);	/* End sector */
// 4084 		p[7] = (BYTE)e_cyl;					/* End cylinder */
// 4085 		ST_DWORD(p + 8, s_part);			/* Start sector in LBA */
// 4086 		ST_DWORD(p + 12, sz_part);			/* Partition size */
// 4087 
// 4088 		/* Next partition */
// 4089 		b_cyl += p_cyl;
// 4090 	}
// 4091 	ST_WORD(p, 0xAA55);
// 4092 
// 4093 	/* Write it to the MBR */
// 4094 	return (disk_write(pdrv, buf, 0, 1) || disk_ioctl(pdrv, CTRL_SYNC, 0)) ? FR_DISK_ERR : FR_OK;
// 4095 }
// 4096 
// 4097 
// 4098 #endif /* _MULTI_PARTITION */
// 4099 #endif /* _USE_MKFS && !_FS_READONLY */
// 4100 
// 4101 
// 4102 
// 4103 
// 4104 #if _USE_STRFUNC
// 4105 /*-----------------------------------------------------------------------*/
// 4106 /* Get a string from the file                                            */
// 4107 /*-----------------------------------------------------------------------*/
// 4108 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 4109 TCHAR* f_gets (
// 4110 	TCHAR* buff,	/* Pointer to the string buffer to read */
// 4111 	int len,		/* Size of string buffer (characters) */
// 4112 	FIL* fp			/* Pointer to the file object */
// 4113 )
// 4114 {
f_gets:
        PUSH     {R2-R8,LR}
        MOVS     R4,R0
        MOVS     R7,R1
        MOV      R8,R2
// 4115 	int n = 0;
        MOVS     R6,#+0
// 4116 	TCHAR c, *p = buff;
        MOVS     R5,R4
        B.N      ??f_gets_0
// 4117 	BYTE s[2];
// 4118 	UINT rc;
// 4119 
// 4120 
// 4121 	while (n < len - 1) {			/* Read bytes until buffer gets filled */
// 4122 		f_read(fp, s, 1, &rc);
// 4123 		if (rc != 1) break;			/* Break on EOF or error */
// 4124 		c = s[0];
// 4125 #if _LFN_UNICODE					/* Read a character in UTF-8 encoding */
// 4126 		if (c >= 0x80) {
// 4127 			if (c < 0xC0) continue;	/* Skip stray trailer */
// 4128 			if (c < 0xE0) {			/* Two-byte sequence */
// 4129 				f_read(fp, s, 1, &rc);
// 4130 				if (rc != 1) break;
// 4131 				c = ((c & 0x1F) << 6) | (s[0] & 0x3F);
// 4132 				if (c < 0x80) c = '?';
// 4133 			} else {
// 4134 				if (c < 0xF0) {		/* Three-byte sequence */
// 4135 					f_read(fp, s, 2, &rc);
// 4136 					if (rc != 2) break;
// 4137 					c = (c << 12) | ((s[0] & 0x3F) << 6) | (s[1] & 0x3F);
// 4138 					if (c < 0x800) c = '?';
// 4139 				} else {			/* Reject four-byte sequence */
// 4140 					c = '?';
// 4141 				}
// 4142 			}
// 4143 		}
// 4144 #endif
// 4145 #if _USE_STRFUNC >= 2
// 4146 		if (c == '\r') continue;	/* Strip '\r' */
??f_gets_1:
??f_gets_0:
        SUBS     R0,R7,#+1
        CMP      R6,R0
        BGE.N    ??f_gets_2
        ADD      R3,SP,#+0
        MOVS     R2,#+1
        ADD      R1,SP,#+4
        MOV      R0,R8
        BL       f_read
        LDR      R0,[SP, #+0]
        CMP      R0,#+1
        BNE.N    ??f_gets_2
??f_gets_3:
        LDRB     R0,[SP, #+4]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+13
        BEQ.N    ??f_gets_1
// 4147 #endif
// 4148 		*p++ = c;
        STRB     R0,[R5, #+0]
        ADDS     R5,R5,#+1
// 4149 		n++;
        ADDS     R6,R6,#+1
// 4150 		if (c == '\n') break;		/* Break on EOL */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+10
        BNE.N    ??f_gets_0
// 4151 	}
// 4152 	*p = 0;
??f_gets_2:
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
// 4153 	return n ? buff : 0;			/* When no data read (eof or error), return with error. */
        CMP      R6,#+0
        BNE.N    ??f_gets_4
??f_gets_5:
        MOVS     R4,#+0
??f_gets_4:
        MOVS     R0,R4
        POP      {R1,R2,R4-R8,PC}  ;; return
// 4154 }
// 4155 
// 4156 
// 4157 
// 4158 #if !_FS_READONLY
// 4159 #include <stdarg.h>
// 4160 /*-----------------------------------------------------------------------*/
// 4161 /* Put a character to the file                                           */
// 4162 /*-----------------------------------------------------------------------*/
// 4163 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 4164 int f_putc (
// 4165 	TCHAR c,	/* A character to be output */
// 4166 	FIL* fp		/* Pointer to the file object */
// 4167 )
// 4168 {
f_putc:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
        MOVS     R5,R1
// 4169 	UINT bw, btw;
// 4170 	BYTE s[3];
// 4171 
// 4172 
// 4173 #if _USE_STRFUNC >= 2
// 4174 	if (c == '\n') f_putc ('\r', fp);	/* LF -> CRLF conversion */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+10
        BNE.N    ??f_putc_0
        MOVS     R1,R5
        MOVS     R0,#+13
        BL       f_putc
// 4175 #endif
// 4176 
// 4177 #if _LFN_UNICODE	/* Write the character in UTF-8 encoding */
// 4178 	if (c < 0x80) {			/* 7-bit */
// 4179 		s[0] = (BYTE)c;
// 4180 		btw = 1;
// 4181 	} else {
// 4182 		if (c < 0x800) {	/* 11-bit */
// 4183 			s[0] = (BYTE)(0xC0 | (c >> 6));
// 4184 			s[1] = (BYTE)(0x80 | (c & 0x3F));
// 4185 			btw = 2;
// 4186 		} else {			/* 16-bit */
// 4187 			s[0] = (BYTE)(0xE0 | (c >> 12));
// 4188 			s[1] = (BYTE)(0x80 | ((c >> 6) & 0x3F));
// 4189 			s[2] = (BYTE)(0x80 | (c & 0x3F));
// 4190 			btw = 3;
// 4191 		}
// 4192 	}
// 4193 #else				/* Write the character without conversion */
// 4194 	s[0] = (BYTE)c;
??f_putc_0:
        STRB     R4,[SP, #+0]
// 4195 	btw = 1;
        MOVS     R4,#+1
// 4196 #endif
// 4197 	f_write(fp, s, btw, &bw);		/* Write the char to the file */
        ADD      R3,SP,#+4
        MOVS     R2,R4
        ADD      R1,SP,#+0
        MOVS     R0,R5
        BL       f_write
// 4198 	return (bw == btw) ? 1 : EOF;	/* Return the result */
        LDR      R0,[SP, #+4]
        CMP      R0,R4
        BNE.N    ??f_putc_1
        MOVS     R0,#+1
        B.N      ??f_putc_2
??f_putc_1:
        MOVS     R0,#-1
??f_putc_2:
        POP      {R1-R5,PC}       ;; return
// 4199 }
// 4200 
// 4201 
// 4202 
// 4203 
// 4204 /*-----------------------------------------------------------------------*/
// 4205 /* Put a string to the file                                              */
// 4206 /*-----------------------------------------------------------------------*/
// 4207 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 4208 int f_puts (
// 4209 	const TCHAR* str,	/* Pointer to the string to be output */
// 4210 	FIL* fp				/* Pointer to the file object */
// 4211 )
// 4212 {
f_puts:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 4213 	int n;
// 4214 
// 4215 
// 4216 	for (n = 0; *str; str++, n++) {
        MOVS     R6,#+0
        B.N      ??f_puts_0
??f_puts_1:
        ADDS     R4,R4,#+1
        ADDS     R6,R6,#+1
??f_puts_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??f_puts_2
// 4217 		if (f_putc(*str, fp) == EOF) return EOF;
        MOVS     R1,R5
        LDRB     R0,[R4, #+0]
        BL       f_putc
        CMN      R0,#+1
        BNE.N    ??f_puts_1
        MOVS     R0,#-1
        B.N      ??f_puts_3
// 4218 	}
// 4219 	return n;
??f_puts_2:
        MOVS     R0,R6
??f_puts_3:
        POP      {R4-R6,PC}       ;; return
// 4220 }
// 4221 
// 4222 
// 4223 
// 4224 
// 4225 /*-----------------------------------------------------------------------*/
// 4226 /* Put a formatted string to the file                                    */
// 4227 /*-----------------------------------------------------------------------*/
// 4228 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 4229 int f_printf (
// 4230 	FIL* fp,			/* Pointer to the file object */
// 4231 	const TCHAR* str,	/* Pointer to the format string */
// 4232 	...					/* Optional arguments... */
// 4233 )
// 4234 {
f_printf:
        PUSH     {R0,R2,R3}
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+24
        MOVS     R4,R1
// 4235 	va_list arp;
// 4236 	BYTE f, r;
// 4237 	UINT i, j, w;
// 4238 	ULONG v;
// 4239 	TCHAR c, d, s[16], *p;
// 4240 	int res, chc, cc;
// 4241 
// 4242 
// 4243 	va_start(arp, str);
        ADD      R5,SP,#+64
// 4244 
// 4245 	for (cc = res = 0; cc != EOF; res += cc) {
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+0]
        B.N      ??f_printf_0
// 4246 		c = *str++;
// 4247 		if (c == 0) break;			/* End of string */
// 4248 		if (c != '%') {				/* Non escape character */
// 4249 			cc = f_putc(c, fp);
// 4250 			if (cc != EOF) cc = 1;
// 4251 			continue;
// 4252 		}
// 4253 		w = f = 0;
// 4254 		c = *str++;
// 4255 		if (c == '0') {				/* Flag: '0' padding */
// 4256 			f = 1; c = *str++;
// 4257 		} else {
// 4258 			if (c == '-') {			/* Flag: left justified */
// 4259 				f = 2; c = *str++;
// 4260 			}
// 4261 		}
// 4262 		while (IsDigit(c)) {		/* Precision */
// 4263 			w = w * 10 + c - '0';
// 4264 			c = *str++;
// 4265 		}
// 4266 		if (c == 'l' || c == 'L') {	/* Prefix: Size is long int */
// 4267 			f |= 4; c = *str++;
// 4268 		}
// 4269 		if (!c) break;
// 4270 		d = c;
// 4271 		if (IsLower(d)) d -= 0x20;
// 4272 		switch (d) {				/* Type is... */
// 4273 		case 'S' :					/* String */
// 4274 			p = va_arg(arp, TCHAR*);
// 4275 			for (j = 0; p[j]; j++) ;
// 4276 			chc = 0;
// 4277 			if (!(f & 2)) {
// 4278 				while (j++ < w) chc += (cc = f_putc(' ', fp));
// 4279 			}
// 4280 			chc += (cc = f_puts(p, fp));
// 4281 			while (j++ < w) chc += (cc = f_putc(' ', fp));
// 4282 			if (cc != EOF) cc = chc;
// 4283 			continue;
// 4284 		case 'C' :					/* Character */
// 4285 			cc = f_putc((TCHAR)va_arg(arp, int), fp); continue;
// 4286 		case 'B' :					/* Binary */
// 4287 			r = 2; break;
// 4288 		case 'O' :					/* Octal */
// 4289 			r = 8; break;
// 4290 		case 'D' :					/* Signed decimal */
// 4291 		case 'U' :					/* Unsigned decimal */
// 4292 			r = 10; break;
// 4293 		case 'X' :					/* Hexdecimal */
// 4294 			r = 16; break;
// 4295 		default:					/* Unknown type (pass-through) */
// 4296 			cc = f_putc(c, fp); continue;
// 4297 		}
// 4298 
// 4299 		/* Get an argument and put it in numeral */
// 4300 		v = (f & 4) ? (ULONG)va_arg(arp, long) : ((d == 'D') ? (ULONG)(long)va_arg(arp, int) : (ULONG)va_arg(arp, unsigned int));
// 4301 		if (d == 'D' && (v & 0x80000000)) {
// 4302 			v = 0 - v;
// 4303 			f |= 8;
// 4304 		}
// 4305 		i = 0;
// 4306 		do {
// 4307 			d = (TCHAR)(v % r); v /= r;
// 4308 			if (d > 9) d += (c == 'x') ? 0x27 : 0x07;
// 4309 			s[i++] = d + '0';
// 4310 		} while (v && i < sizeof s / sizeof s[0]);
// 4311 		if (f & 8) s[i++] = '-';
// 4312 		j = i; d = (f & 1) ? '0' : ' ';
// 4313 		chc = 0;
// 4314 		while (!(f & 2) && j++ < w) chc += (cc = f_putc(d, fp));
// 4315 		do chc += (cc = f_putc(s[--i], fp)); while(i);
// 4316 		while (j++ < w) chc += (cc = f_putc(' ', fp));
// 4317 		if (cc != EOF) cc = chc;
??f_printf_1:
        CMN      R0,#+1
        BEQ.N    ??f_printf_2
        MOVS     R0,R6
??f_printf_2:
        LDR      R1,[SP, #+0]
        ADDS     R1,R0,R1
        STR      R1,[SP, #+0]
??f_printf_0:
        CMN      R0,#+1
        BEQ.N    ??f_printf_3
        LDRB     R2,[R4, #+0]
        ADDS     R4,R4,#+1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??f_printf_4
// 4318 	}
// 4319 
// 4320 	va_end(arp);
// 4321 	return (cc == EOF) ? cc : res;
??f_printf_3:
        CMN      R0,#+1
        BNE.W    ??f_printf_5
        B.N      ??f_printf_6
??f_printf_4:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+37
        BEQ.N    ??f_printf_7
        LDR      R1,[SP, #+60]
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        CMN      R0,#+1
        BEQ.N    ??f_printf_8
        MOVS     R0,#+1
??f_printf_8:
        B.N      ??f_printf_2
??f_printf_7:
        MOVS     R7,#+0
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        MOV      R8,R7
        LDRB     R2,[R4, #+0]
        ADDS     R4,R4,#+1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+48
        BNE.N    ??f_printf_9
        MOVS     R7,#+1
        LDRB     R2,[R4, #+0]
        ADDS     R4,R4,#+1
        B.N      ??f_printf_10
??f_printf_9:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+45
        BNE.N    ??f_printf_10
        MOVS     R7,#+2
        LDRB     R2,[R4, #+0]
        ADDS     R4,R4,#+1
        B.N      ??f_printf_10
??f_printf_11:
        MOVS     R1,#+10
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MLA      R1,R1,R8,R2
        SUBS     R8,R1,#+48
        LDRB     R2,[R4, #+0]
        ADDS     R4,R4,#+1
??f_printf_10:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        SUBS     R1,R2,#+48
        CMP      R1,#+10
        BCC.N    ??f_printf_11
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+108
        BEQ.N    ??f_printf_12
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+76
        BNE.N    ??f_printf_13
??f_printf_12:
        ORRS     R7,R7,#0x4
        LDRB     R2,[R4, #+0]
        ADDS     R4,R4,#+1
??f_printf_13:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??f_printf_3
??f_printf_14:
        MOV      R11,R2
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        SUBS     R0,R11,#+97
        CMP      R0,#+26
        BCS.N    ??f_printf_15
        SUBS     R11,R11,#+32
??f_printf_15:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        MOV      R0,R11
        CMP      R0,#+66
        BEQ.N    ??f_printf_16
        CMP      R0,#+67
        BEQ.N    ??f_printf_17
        CMP      R0,#+68
        BEQ.N    ??f_printf_18
        CMP      R0,#+79
        BEQ.N    ??f_printf_19
        CMP      R0,#+83
        BEQ.N    ??f_printf_20
        CMP      R0,#+85
        BEQ.N    ??f_printf_18
        CMP      R0,#+88
        BEQ.N    ??f_printf_21
        B.N      ??f_printf_22
??f_printf_20:
        LDR      R10,[R5, #+0]
        ADDS     R5,R5,#+4
        MOVS     R9,#+0
        B.N      ??f_printf_23
??f_printf_24:
        ADDS     R9,R9,#+1
??f_printf_23:
        LDRB     R0,[R9, R10]
        CMP      R0,#+0
        BNE.N    ??f_printf_24
        MOVS     R6,#+0
        LSLS     R0,R7,#+30
        BMI.N    ??f_printf_25
        B.N      ??f_printf_26
??f_printf_27:
        LDR      R1,[SP, #+60]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R6,R0,R6
??f_printf_26:
        MOV      R0,R9
        ADDS     R9,R0,#+1
        CMP      R0,R8
        BCC.N    ??f_printf_27
??f_printf_25:
        LDR      R1,[SP, #+60]
        MOV      R0,R10
        BL       f_puts
        ADDS     R6,R0,R6
        B.N      ??f_printf_28
??f_printf_29:
        LDR      R1,[SP, #+60]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R6,R0,R6
??f_printf_28:
        MOV      R1,R9
        ADDS     R9,R1,#+1
        CMP      R1,R8
        BCC.N    ??f_printf_29
        CMN      R0,#+1
        BEQ.N    ??f_printf_30
        MOVS     R0,R6
??f_printf_30:
        B.N      ??f_printf_2
??f_printf_17:
        LDR      R0,[R5, #+0]
        ADDS     R5,R5,#+4
        LDR      R1,[SP, #+60]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        B.N      ??f_printf_2
??f_printf_16:
        MOVS     R0,#+2
??f_printf_31:
        LSLS     R1,R7,#+29
        BPL.N    ??f_printf_32
        LDR      R1,[R5, #+0]
        ADDS     R5,R5,#+4
        B.N      ??f_printf_33
??f_printf_19:
        MOVS     R0,#+8
        B.N      ??f_printf_31
??f_printf_18:
        MOVS     R0,#+10
        B.N      ??f_printf_31
??f_printf_21:
        MOVS     R0,#+16
        B.N      ??f_printf_31
??f_printf_22:
        LDR      R1,[SP, #+60]
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        B.N      ??f_printf_2
??f_printf_32:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+68
        BNE.N    ??f_printf_34
        LDR      R1,[R5, #+0]
        ADDS     R5,R5,#+4
        B.N      ??f_printf_33
??f_printf_34:
        LDR      R1,[R5, #+0]
        ADDS     R5,R5,#+4
??f_printf_33:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+68
        BNE.N    ??f_printf_35
        CMP      R1,#+0
        BPL.N    ??f_printf_35
        RSBS     R1,R1,#+0
        ORRS     R7,R7,#0x8
??f_printf_35:
        MOVS     R10,#+0
??f_printf_36:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UDIV     R3,R1,R0
        MLS      R11,R0,R3,R1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UDIV     R1,R1,R0
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+10
        BLT.N    ??f_printf_37
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+120
        BNE.N    ??f_printf_38
        MOVS     R3,#+39
        B.N      ??f_printf_39
??f_printf_38:
        MOVS     R3,#+7
??f_printf_39:
        ADDS     R11,R3,R11
??f_printf_37:
        ADDS     R3,R11,#+48
        ADD      R6,SP,#+4
        STRB     R3,[R10, R6]
        ADDS     R10,R10,#+1
        CMP      R1,#+0
        BEQ.N    ??f_printf_40
        CMP      R10,#+16
        BCC.N    ??f_printf_36
??f_printf_40:
        LSLS     R0,R7,#+28
        BPL.N    ??f_printf_41
        MOVS     R0,#+45
        ADD      R1,SP,#+4
        STRB     R0,[R10, R1]
        ADDS     R10,R10,#+1
??f_printf_41:
        MOV      R9,R10
        LSLS     R0,R7,#+31
        BPL.N    ??f_printf_42
        MOVS     R11,#+48
        B.N      ??f_printf_43
??f_printf_42:
        MOVS     R11,#+32
??f_printf_43:
        MOVS     R6,#+0
        B.N      ??f_printf_44
??f_printf_45:
        LDR      R1,[SP, #+60]
        MOV      R0,R11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        ADDS     R6,R0,R6
??f_printf_44:
        LSLS     R0,R7,#+30
        BMI.N    ??f_printf_46
        MOV      R0,R9
        ADDS     R9,R0,#+1
        CMP      R0,R8
        BCC.N    ??f_printf_45
??f_printf_46:
        SUBS     R10,R10,#+1
        LDR      R1,[SP, #+60]
        ADD      R0,SP,#+4
        LDRB     R0,[R10, R0]
        BL       f_putc
        ADDS     R6,R0,R6
        CMP      R10,#+0
        BNE.N    ??f_printf_46
??f_printf_47:
        MOV      R1,R9
        ADDS     R9,R1,#+1
        CMP      R1,R8
        BCS.W    ??f_printf_1
        LDR      R1,[SP, #+60]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R6,R0,R6
        B.N      ??f_printf_47
??f_printf_5:
        LDR      R0,[SP, #+0]
??f_printf_6:
        ADD      SP,SP,#+24
        POP      {R4-R11}
        LDR      PC,[SP], #+16    ;; return
// 4322 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 4323 
// 4324 #endif /* !_FS_READONLY */
// 4325 #endif /* _USE_STRFUNC */
// 
//    103 bytes in section .bss
//    136 bytes in section .rodata
// 13 986 bytes in section .text
// 
// 13 986 bytes of CODE  memory
//    136 bytes of CONST memory
//    103 bytes of DATA  memory
//
//Errors: none
//Warnings: none
