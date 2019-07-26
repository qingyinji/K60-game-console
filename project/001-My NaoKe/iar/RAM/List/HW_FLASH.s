///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       26/Dec/2018  16:13:57
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\LPLD\HW\HW_FLASH.c
//    Command line =  
//        D:\2019.IAR\lib\LPLD\HW\HW_FLASH.c -D LPLD_K60 -lCN
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
//        D:\2019.IAR\project\(FatFS SDHC)LPLD_FatFs\iar\RAM\List\HW_FLASH.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC LPLD_Flash_ByteProgram
        PUBLIC LPLD_Flash_Init
        PUBLIC LPLD_Flash_SectorErase

// D:\2019.IAR\lib\LPLD\HW\HW_FLASH.c
//    1 /**
//    2  * @file HW_FLASH.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief FTFL底层模块相关函数
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
//   22 #include "common.h"
//   23 #include "HW_FLASH.h"
//   24 
//   25 /*
//   26  * LPLD_Flash_Init
//   27  * Flash模块初始化
//   28  * 
//   29  * 参数:
//   30  *    无
//   31  *
//   32  * 输出:
//   33  *    无
//   34  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   35 void LPLD_Flash_Init(void)
//   36 {
//   37   //检查Flash访问错误
//   38   if (FTFL->FSTAT & FTFL_FSTAT_ACCERR_MASK)
LPLD_Flash_Init:
        LDR.N    R0,??DataTable2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??LPLD_Flash_Init_0
//   39   {
//   40     FTFL->FSTAT |= FTFL_FSTAT_ACCERR_MASK;       //清除错误标志
        LDR.N    R0,??DataTable2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable2  ;; 0x40020000
        STRB     R0,[R1, #+0]
        B.N      ??LPLD_Flash_Init_1
//   41   }
//   42   //检查保护错误
//   43   else if (FTFL->FSTAT & FTFL_FSTAT_FPVIOL_MASK)
??LPLD_Flash_Init_0:
        LDR.N    R0,??DataTable2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL.N    ??LPLD_Flash_Init_2
//   44   {
//   45     FTFL->FSTAT |= FTFL_FSTAT_FPVIOL_MASK;
        LDR.N    R0,??DataTable2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable2  ;; 0x40020000
        STRB     R0,[R1, #+0]
        B.N      ??LPLD_Flash_Init_1
//   46   }
//   47   //检查读冲突错误
//   48   else if (FTFL->FSTAT & FTFL_FSTAT_RDCOLERR_MASK)
??LPLD_Flash_Init_2:
        LDR.N    R0,??DataTable2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??LPLD_Flash_Init_1
//   49   {
//   50     FTFL->FSTAT |= FTFL_FSTAT_RDCOLERR_MASK;
        LDR.N    R0,??DataTable2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable2  ;; 0x40020000
        STRB     R0,[R1, #+0]
//   51   }
//   52   
//   53   //禁用Flash模块的数据缓存
//   54   FMC->PFB0CR &= ~FMC_PFB0CR_B0DCE_MASK;
??LPLD_Flash_Init_1:
        LDR.N    R0,??DataTable2_1  ;; 0x4001f004
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x10
        LDR.N    R1,??DataTable2_1  ;; 0x4001f004
        STR      R0,[R1, #+0]
//   55   FMC->PFB1CR &= ~FMC_PFB1CR_B1DCE_MASK;
        LDR.N    R0,??DataTable2_2  ;; 0x4001f008
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x10
        LDR.N    R1,??DataTable2_2  ;; 0x4001f008
        STR      R0,[R1, #+0]
//   56 } 
        BX       LR               ;; return
//   57 
//   58 
//   59 /*
//   60  * LPLD_Flash_SectorErase
//   61  * 擦除Flash扇区
//   62  * 
//   63  * 参数:
//   64  *    FlashPtr--扇区地址指针，即扇区号乘以2048
//   65  *
//   66  * 输出:
//   67  *    错误代码
//   68  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   69 uint8 LPLD_Flash_SectorErase(uint32 FlashPtr)
//   70 {
LPLD_Flash_SectorErase:
        MOVS     R1,R0
//   71   uint8 Return = FLASH_OK;
        MOVS     R0,#+0
//   72   
//   73   //等待CCIF置1
//   74   while (!(FTFL->FSTAT & FTFL_FSTAT_CCIF_MASK)){};
??LPLD_Flash_SectorErase_0:
        LDR.N    R2,??DataTable2  ;; 0x40020000
        LDRB     R2,[R2, #+0]
        LSLS     R2,R2,#+24
        BPL.N    ??LPLD_Flash_SectorErase_0
//   75   //写入命令道FCCOB寄存器
//   76   FTFL->FCCOB0 = FLASH_CMD_ERSSCR;
        MOVS     R2,#+9
        LDR.N    R3,??DataTable2_3  ;; 0x40020007
        STRB     R2,[R3, #+0]
//   77   FTFL->FCCOB1 = (uint8) (FlashPtr >> 16);
        LSRS     R2,R1,#+16
        LDR.N    R3,??DataTable2_4  ;; 0x40020006
        STRB     R2,[R3, #+0]
//   78   FTFL->FCCOB2 = (uint8)((FlashPtr >> 8 ) & 0xFF);
        LSRS     R2,R1,#+8
        LDR.N    R3,??DataTable2_5  ;; 0x40020005
        STRB     R2,[R3, #+0]
//   79   FTFL->FCCOB3 = (uint8)( FlashPtr & 0xFF);
        LDR.N    R2,??DataTable2_6  ;; 0x40020004
        STRB     R1,[R2, #+0]
//   80   
//   81   //执行命令
//   82   FTFL->FSTAT |= FTFL_FSTAT_CCIF_MASK;    
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        ORRS     R1,R1,#0x80
        LDR.N    R2,??DataTable2  ;; 0x40020000
        STRB     R1,[R2, #+0]
//   83   //等待命令完成
//   84   while (!(FTFL->FSTAT & FTFL_FSTAT_CCIF_MASK)) {};
??LPLD_Flash_SectorErase_1:
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??LPLD_Flash_SectorErase_1
//   85   
//   86   //检查Flash访问错误
//   87   if (FTFL->FSTAT & FTFL_FSTAT_ACCERR_MASK)
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+26
        BPL.N    ??LPLD_Flash_SectorErase_2
//   88   {
//   89     FTFL->FSTAT |= FTFL_FSTAT_ACCERR_MASK;       //清除错误标志
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        ORRS     R1,R1,#0x20
        LDR.N    R2,??DataTable2  ;; 0x40020000
        STRB     R1,[R2, #+0]
//   90     Return |= FLASH_FACCERR;                    //更新返回值
        ORRS     R0,R0,#0x1
        B.N      ??LPLD_Flash_SectorErase_3
//   91   }
//   92   //检查Flash保护标志
//   93   else if (FTFL->FSTAT & FTFL_FSTAT_FPVIOL_MASK)
??LPLD_Flash_SectorErase_2:
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+27
        BPL.N    ??LPLD_Flash_SectorErase_4
//   94   {
//   95     FTFL->FSTAT |= FTFL_FSTAT_FPVIOL_MASK;
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        ORRS     R1,R1,#0x10
        LDR.N    R2,??DataTable2  ;; 0x40020000
        STRB     R1,[R2, #+0]
//   96     Return |= FLASH_FPVIOL;
        ORRS     R0,R0,#0x2
        B.N      ??LPLD_Flash_SectorErase_3
//   97   }
//   98   //检查Flash读冲突错误
//   99   else if (FTFL->FSTAT & FTFL_FSTAT_RDCOLERR_MASK)
??LPLD_Flash_SectorErase_4:
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+25
        BPL.N    ??LPLD_Flash_SectorErase_5
//  100   {
//  101     FTFL->FSTAT |= FTFL_FSTAT_RDCOLERR_MASK;
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        ORRS     R1,R1,#0x40
        LDR.N    R2,??DataTable2  ;; 0x40020000
        STRB     R1,[R2, #+0]
//  102     Return |= FLASH_RDCOLERR;
        ORRS     R0,R0,#0x8
        B.N      ??LPLD_Flash_SectorErase_3
//  103   }
//  104   //检查MGSTAT0非可纠正错误
//  105   else if (FTFL->FSTAT & FTFL_FSTAT_MGSTAT0_MASK)
??LPLD_Flash_SectorErase_5:
        LDR.N    R1,??DataTable2  ;; 0x40020000
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+31
        BPL.N    ??LPLD_Flash_SectorErase_3
//  106   {
//  107     Return |= FLASH_MGSTAT0;
        ORRS     R0,R0,#0x4
//  108   } 
//  109   
//  110   return  Return;
??LPLD_Flash_SectorErase_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  111 }
//  112 
//  113 /*
//  114  * LPLD_Flash_ByteProgram
//  115  * 编程Flash
//  116  * 
//  117  * 参数:
//  118  *    FlashStartAdd--Flash编程起始地址
//  119  *    *DataSrcPtr--数据源指针
//  120  *    NumberOfBytes--数据字节长度
//  121  *
//  122  * 输出:
//  123  *    错误代码
//  124  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 uint8 LPLD_Flash_ByteProgram(uint32 FlashStartAdd, uint32 *DataSrcPtr, uint32 NumberOfBytes)
//  126 {
LPLD_Flash_ByteProgram:
        PUSH     {R4,R5}
        MOVS     R3,R2
//  127   uint8 Return = FLASH_OK;
        MOVS     R2,#+0
//  128   
//  129   uint32 size_buffer;
//  130   
//  131   if (NumberOfBytes == 0)
        CMP      R3,#+0
        BNE.N    ??LPLD_Flash_ByteProgram_0
//  132   {
//  133     return FLASH_CONTENTERR;
        MOVS     R0,#+17
        B.N      ??LPLD_Flash_ByteProgram_1
//  134   }
//  135   else
//  136   {
//  137     size_buffer = (NumberOfBytes - 1)/4 + 1;
??LPLD_Flash_ByteProgram_0:
        SUBS     R3,R3,#+1
        LSRS     R3,R3,#+2
        ADDS     R3,R3,#+1
//  138   }
//  139   //等待直到CCIF设置
//  140   while (!(FTFL->FSTAT & FTFL_FSTAT_CCIF_MASK)){};
??LPLD_Flash_ByteProgram_2:
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        LSLS     R4,R4,#+24
        BPL.N    ??LPLD_Flash_ByteProgram_2
//  141 
//  142   while ((size_buffer) && (Return == FLASH_OK))
??LPLD_Flash_ByteProgram_3:
        CMP      R3,#+0
        BEQ.N    ??LPLD_Flash_ByteProgram_4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??LPLD_Flash_ByteProgram_4
//  143   {
//  144     //写FLASH命令到FCCOB
//  145     FTFL->FCCOB0 = FLASH_CMD_PGM4;
        MOVS     R4,#+6
        LDR.N    R5,??DataTable2_3  ;; 0x40020007
        STRB     R4,[R5, #+0]
//  146     FTFL->FCCOB1 = (uint8)(FlashStartAdd >> 16);
        LSRS     R4,R0,#+16
        LDR.N    R5,??DataTable2_4  ;; 0x40020006
        STRB     R4,[R5, #+0]
//  147     FTFL->FCCOB2 = (uint8)((FlashStartAdd >> 8) & 0xFF);
        LSRS     R4,R0,#+8
        LDR.N    R5,??DataTable2_5  ;; 0x40020005
        STRB     R4,[R5, #+0]
//  148     FTFL->FCCOB3 = (uint8)(FlashStartAdd & 0xFF);
        LDR.N    R4,??DataTable2_6  ;; 0x40020004
        STRB     R0,[R4, #+0]
//  149     //如果K60设置成为小端格式，进行如下操作
//  150     FTFL->FCCOB4 = (uint8)(*((uint8*)DataSrcPtr+3));
        LDRB     R4,[R1, #+3]
        LDR.N    R5,??DataTable2_7  ;; 0x4002000b
        STRB     R4,[R5, #+0]
//  151     FTFL->FCCOB5 = (uint8)(*((uint8*)DataSrcPtr+2));
        LDRB     R4,[R1, #+2]
        LDR.N    R5,??DataTable2_8  ;; 0x4002000a
        STRB     R4,[R5, #+0]
//  152     FTFL->FCCOB6 = (uint8)(*((uint8*)DataSrcPtr+1));
        LDRB     R4,[R1, #+1]
        LDR.N    R5,??DataTable2_9  ;; 0x40020009
        STRB     R4,[R5, #+0]
//  153     FTFL->FCCOB7 = (uint8)(*((uint8*)DataSrcPtr+0));
        LDRB     R4,[R1, #+0]
        LDR.N    R5,??DataTable2_10  ;; 0x40020008
        STRB     R4,[R5, #+0]
//  154     //如果K60设置成为大端格式，进行如下操作
//  155     //FTFL_FCCOB4 = (uint8)(*((uint_8*)DataSrcPtr+0));
//  156     //FTFL_FCCOB5 = (uint8)(*((uint_8*)DataSrcPtr+1));
//  157     //FTFL_FCCOB6 = (uint8)(*((uint_8*)DataSrcPtr+2));
//  158     //FTFL_FCCOB7 = (uint8)(*((uint_8*)DataSrcPtr+3));
//  159     //设置FLASH加载命令
//  160     FTFL->FSTAT |= FTFL_FSTAT_CCIF_MASK;    
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        ORRS     R4,R4,#0x80
        LDR.N    R5,??DataTable2  ;; 0x40020000
        STRB     R4,[R5, #+0]
//  161     //等待命令完成
//  162     while (!(FTFL->FSTAT & FTFL_FSTAT_CCIF_MASK)) {};
??LPLD_Flash_ByteProgram_5:
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        LSLS     R4,R4,#+24
        BPL.N    ??LPLD_Flash_ByteProgram_5
//  163     
//  164     //检测FLASH访问错误
//  165     if (FTFL->FSTAT & FTFL_FSTAT_ACCERR_MASK)
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        LSLS     R4,R4,#+26
        BPL.N    ??LPLD_Flash_ByteProgram_6
//  166     {
//  167         
//  168         FTFL->FSTAT |= FTFL_FSTAT_ACCERR_MASK;
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        ORRS     R4,R4,#0x20
        LDR.N    R5,??DataTable2  ;; 0x40020000
        STRB     R4,[R5, #+0]
//  169     
//  170         Return |= FLASH_FACCERR;
        ORRS     R2,R2,#0x1
        B.N      ??LPLD_Flash_ByteProgram_7
//  171     }
//  172     //检测FLASH保护错误
//  173     else if (FTFL->FSTAT & FTFL_FSTAT_FPVIOL_MASK)
??LPLD_Flash_ByteProgram_6:
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        LSLS     R4,R4,#+27
        BPL.N    ??LPLD_Flash_ByteProgram_8
//  174     {
//  175         FTFL->FSTAT |= FTFL_FSTAT_FPVIOL_MASK;
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        ORRS     R4,R4,#0x10
        LDR.N    R5,??DataTable2  ;; 0x40020000
        STRB     R4,[R5, #+0]
//  176     
//  177         Return |= FLASH_FPVIOL;
        ORRS     R2,R2,#0x2
        B.N      ??LPLD_Flash_ByteProgram_7
//  178     }
//  179     
//  180     else if (FTFL->FSTAT & FTFL_FSTAT_RDCOLERR_MASK)
??LPLD_Flash_ByteProgram_8:
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        LSLS     R4,R4,#+25
        BPL.N    ??LPLD_Flash_ByteProgram_9
//  181     {
//  182         FTFL->FSTAT |= FTFL_FSTAT_RDCOLERR_MASK;
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        ORRS     R4,R4,#0x40
        LDR.N    R5,??DataTable2  ;; 0x40020000
        STRB     R4,[R5, #+0]
//  183     
//  184         Return |= FLASH_RDCOLERR;
        ORRS     R2,R2,#0x8
        B.N      ??LPLD_Flash_ByteProgram_7
//  185     }
//  186     else if (FTFL->FSTAT & FTFL_FSTAT_MGSTAT0_MASK)
??LPLD_Flash_ByteProgram_9:
        LDR.N    R4,??DataTable2  ;; 0x40020000
        LDRB     R4,[R4, #+0]
        LSLS     R4,R4,#+31
        BPL.N    ??LPLD_Flash_ByteProgram_7
//  187     {
//  188         Return |= FLASH_MGSTAT0;
        ORRS     R2,R2,#0x4
//  189     } 
//  190     size_buffer --;
??LPLD_Flash_ByteProgram_7:
        SUBS     R3,R3,#+1
//  191     (uint32*)DataSrcPtr++;
        ADDS     R1,R1,#+4
//  192     FlashStartAdd +=4;
        ADDS     R0,R0,#+4
        B.N      ??LPLD_Flash_ByteProgram_3
//  193   } 
//  194   return  Return;
??LPLD_Flash_ByteProgram_4:
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??LPLD_Flash_ByteProgram_1:
        POP      {R4,R5}
        BX       LR               ;; return
//  195 } 

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0x40020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x4001f004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     0x4001f008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     0x40020007

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0x40020006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     0x40020005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     0x40020004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     0x4002000b

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     0x4002000a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     0x40020009

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     0x40020008

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
// 492 bytes in section .text
// 
// 492 bytes of CODE memory
//
//Errors: none
//Warnings: none
