///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       07/Feb/2019  15:37:45
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\2019.IAR\lib\common\stdlib.c
//    Command line =  
//        D:\2019.IAR\lib\common\stdlib.c -D LPLD_K60 -lCN
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
//    List file    =  D:\2019.IAR\project\001-My NaoKe\iar\FLASH\List\stdlib.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC isalnum
        PUBLIC isdigit
        PUBLIC isspace
        PUBLIC isupper
        PUBLIC memcpy
        PUBLIC memset
        PUBLIC strcasecmp
        PUBLIC strcat
        PUBLIC strcmp
        PUBLIC strcpy
        PUBLIC strlen
        PUBLIC strncasecmp
        PUBLIC strncat
        PUBLIC strncmp
        PUBLIC strncpy
        PUBLIC strtoul

// D:\2019.IAR\lib\common\stdlib.c
//    1 /**
//    2  * @file stdlib.c
//    3  * @version 3.01[By LPLD]
//    4  * @date 2013-11-4
//    5  * @brief C标准代码库
//    6  *
//    7  * 更改建议:不建议修改
//    8  *
//    9  * 由标准C代码库移植，仅支持ASCII
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
//   24 #include "stdlib.h"
//   25 
//   26 
//   27 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 int isspace (int ch)
//   29 {
//   30     if ((ch == ' ') || (ch == '\t'))    /* \n ??? */
isspace:
        CMP      R0,#+32
        BEQ.N    ??isspace_0
        CMP      R0,#+9
        BNE.N    ??isspace_1
//   31         return TRUE;
??isspace_0:
        MOVS     R0,#+1
        B.N      ??isspace_2
//   32     else
//   33         return FALSE;
??isspace_1:
        MOVS     R0,#+0
??isspace_2:
        BX       LR               ;; return
//   34 }
//   35 
//   36 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 int isalnum (int ch)
//   38 {
//   39     /* ASCII only */
//   40     if (((ch >= '0') && (ch <= '9')) ||
//   41         ((ch >= 'A') && (ch <= 'Z')) ||
//   42         ((ch >= 'a') && (ch <= 'z')))
isalnum:
        SUBS     R1,R0,#+48
        CMP      R1,#+10
        BCC.N    ??isalnum_0
        SUBS     R1,R0,#+65
        CMP      R1,#+26
        BCC.N    ??isalnum_0
        SUBS     R0,R0,#+97
        CMP      R0,#+26
        BCS.N    ??isalnum_1
//   43         return TRUE;
??isalnum_0:
        MOVS     R0,#+1
        B.N      ??isalnum_2
//   44     else
//   45         return FALSE;
??isalnum_1:
        MOVS     R0,#+0
??isalnum_2:
        BX       LR               ;; return
//   46 }
//   47 
//   48 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 int isdigit (int ch)
//   50 {
//   51     /* ASCII only */
//   52     if ((ch >= '0') && (ch <= '9'))
isdigit:
        SUBS     R0,R0,#+48
        CMP      R0,#+10
        BCS.N    ??isdigit_0
//   53         return TRUE;
        MOVS     R0,#+1
        B.N      ??isdigit_1
//   54     else
//   55         return FALSE;
??isdigit_0:
        MOVS     R0,#+0
??isdigit_1:
        BX       LR               ;; return
//   56 }
//   57 
//   58 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   59 int isupper (int ch)
//   60 {
//   61     /* ASCII only */
//   62     if ((ch >= 'A') && (ch <= 'Z'))
isupper:
        SUBS     R0,R0,#+65
        CMP      R0,#+26
        BCS.N    ??isupper_0
//   63         return TRUE;
        MOVS     R0,#+1
        B.N      ??isupper_1
//   64     else
//   65         return FALSE;
??isupper_0:
        MOVS     R0,#+0
??isupper_1:
        BX       LR               ;; return
//   66 }
//   67 
//   68 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   69 int strcasecmp (const int8 *s1, const int8 *s2)
//   70 {
strcasecmp:
        PUSH     {R4}
//   71     int8    c1, c2;
//   72     int     result = 0;
        MOVS     R2,#+0
//   73 
//   74     while (result == 0)
??strcasecmp_0:
        CMP      R2,#+0
        BNE.N    ??strcasecmp_1
//   75     {
//   76         c1 = *s1++;
        LDRSB    R3,[R0, #+0]
        ADDS     R0,R0,#+1
//   77         c2 = *s2++;
        LDRSB    R4,[R1, #+0]
        ADDS     R1,R1,#+1
//   78         if ((c1 >= 'a') && (c1 <= 'z'))
        SXTB     R3,R3            ;; SignExt  R3,R3,#+24,#+24
        SUBS     R2,R3,#+97
        CMP      R2,#+26
        BCS.N    ??strcasecmp_2
//   79             c1 = (int8)(c1 - ' ');
        SUBS     R3,R3,#+32
//   80         if ((c2 >= 'a') && (c2 <= 'z'))
??strcasecmp_2:
        SXTB     R4,R4            ;; SignExt  R4,R4,#+24,#+24
        SUBS     R2,R4,#+97
        CMP      R2,#+26
        BCS.N    ??strcasecmp_3
//   81             c2 = (int8)(c2 - ' ');
        SUBS     R4,R4,#+32
//   82         if ((result = (c1 - c2)) != 0)
??strcasecmp_3:
        SXTB     R3,R3            ;; SignExt  R3,R3,#+24,#+24
        SXTB     R4,R4            ;; SignExt  R4,R4,#+24,#+24
        SUBS     R2,R3,R4
        CMP      R2,#+0
        BNE.N    ??strcasecmp_1
//   83             break;
//   84         if ((c1 == 0) || (c2 == 0))
??strcasecmp_4:
        SXTB     R3,R3            ;; SignExt  R3,R3,#+24,#+24
        CMP      R3,#+0
        BEQ.N    ??strcasecmp_5
        SXTB     R4,R4            ;; SignExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??strcasecmp_0
//   85             break;
//   86     }
//   87     return result;
??strcasecmp_5:
??strcasecmp_1:
        MOVS     R0,R2
        POP      {R4}
        BX       LR               ;; return
//   88 }
//   89 
//   90 
//   91 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 int strncasecmp (const int8 *s1, const int8 *s2, int n)
//   93 {
strncasecmp:
        PUSH     {R4-R6}
//   94     int8    c1, c2;
//   95     int     k = 0;
        MOVS     R6,#+0
//   96     int     result = 0;
        MOVS     R3,#+0
//   97 
//   98     while ( k++ < n )
??strncasecmp_0:
        MOVS     R4,R6
        ADDS     R6,R4,#+1
        CMP      R4,R2
        BGE.N    ??strncasecmp_1
//   99     {
//  100         c1 = *s1++;
        LDRSB    R4,[R0, #+0]
        ADDS     R0,R0,#+1
//  101         c2 = *s2++;
        LDRSB    R5,[R1, #+0]
        ADDS     R1,R1,#+1
//  102         if ((c1 >= 'a') && (c1 <= 'z'))
        SXTB     R4,R4            ;; SignExt  R4,R4,#+24,#+24
        SUBS     R3,R4,#+97
        CMP      R3,#+26
        BCS.N    ??strncasecmp_2
//  103             c1 = (int8)(c1 - ' ');
        SUBS     R4,R4,#+32
//  104         if ((c2 >= 'a') && (c2 <= 'z'))
??strncasecmp_2:
        SXTB     R5,R5            ;; SignExt  R5,R5,#+24,#+24
        SUBS     R3,R5,#+97
        CMP      R3,#+26
        BCS.N    ??strncasecmp_3
//  105             c2 = (int8)(c2 - ' ');
        SUBS     R5,R5,#+32
//  106         if ((result = (c1 - c2)) != 0)
??strncasecmp_3:
        SXTB     R4,R4            ;; SignExt  R4,R4,#+24,#+24
        SXTB     R5,R5            ;; SignExt  R5,R5,#+24,#+24
        SUBS     R3,R4,R5
        CMP      R3,#+0
        BNE.N    ??strncasecmp_1
//  107             break;
//  108         if ((c1 == 0) || (c2 == 0))
??strncasecmp_4:
        SXTB     R4,R4            ;; SignExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??strncasecmp_5
        SXTB     R5,R5            ;; SignExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??strncasecmp_0
//  109             break;
//  110     }
//  111     return result;
??strncasecmp_5:
??strncasecmp_1:
        MOVS     R0,R3
        POP      {R4-R6}
        BX       LR               ;; return
//  112 }
//  113 
//  114 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  115 unsigned long strtoul (int8 *str, int8 **ptr, int base)
//  116 {
strtoul:
        PUSH     {R3-R11,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  117     unsigned long rvalue;
//  118     int c, err, neg;
//  119     int8 *endp;
//  120     int8 *startp;
//  121 
//  122     rvalue = 0;  err = 0;  neg = 0;
        MOVS     R7,#+0
        MOVS     R8,#+0
        MOVS     R9,#+0
//  123 
//  124     /* Check for invalid arguments */
//  125     if ((str == NULL) || (base < 0) || (base == 1) || (base > 36))
        CMP      R4,#+0
        BEQ.N    ??strtoul_0
        CMP      R6,#+0
        BMI.N    ??strtoul_0
        CMP      R6,#+1
        BEQ.N    ??strtoul_0
        CMP      R6,#+37
        BLT.N    ??strtoul_1
//  126     {
//  127         if (ptr != NULL)
??strtoul_0:
        CMP      R5,#+0
        BEQ.N    ??strtoul_2
//  128         {
//  129             *ptr = str;
        STR      R4,[R5, #+0]
//  130         }
//  131         return 0;
??strtoul_2:
        MOVS     R0,#+0
        B.N      ??strtoul_3
//  132     }
//  133 
//  134     /* Skip leading white spaces */
//  135     for (startp = str; isspace(*startp); ++startp)
??strtoul_1:
        MOV      R10,R4
        B.N      ??strtoul_4
??strtoul_5:
        ADDS     R10,R10,#+1
??strtoul_4:
        LDRSB    R0,[R10, #+0]
        BL       isspace
        CMP      R0,#+0
        BNE.N    ??strtoul_5
//  136         ;
//  137 
//  138     /* Check for notations */
//  139     switch (startp[0])
        LDRSB    R0,[R10, #+0]
        CMP      R0,#+45
        BEQ.N    ??strtoul_6
        CMP      R0,#+48
        BNE.N    ??strtoul_7
//  140     {
//  141         case '0':
//  142             if ((startp[1] == 'x') || (startp[1] == 'X'))
??strtoul_8:
        LDRSB    R0,[R10, #+1]
        CMP      R0,#+120
        BEQ.N    ??strtoul_9
        LDRSB    R0,[R10, #+1]
        CMP      R0,#+88
        BNE.N    ??strtoul_10
//  143             {
//  144                 if ((base == 0) || (base == 16))
??strtoul_9:
        CMP      R6,#+0
        BEQ.N    ??strtoul_11
        CMP      R6,#+16
        BNE.N    ??strtoul_10
//  145                 {
//  146                     base = 16;
??strtoul_11:
        MOVS     R6,#+16
//  147                     startp = &startp[2];
        ADDS     R10,R10,#+2
//  148                 }
//  149             }
//  150             break;
??strtoul_10:
        B.N      ??strtoul_12
//  151         case '-':
//  152             neg = 1;
??strtoul_6:
        MOVS     R9,#+1
//  153             startp = &startp[1];
        ADDS     R10,R10,#+1
//  154             break;
        B.N      ??strtoul_12
//  155         default:
//  156             break;
//  157     }
//  158 
//  159     if (base == 0)
??strtoul_7:
??strtoul_12:
        CMP      R6,#+0
        BNE.N    ??strtoul_13
//  160         base = 10;
        MOVS     R6,#+10
//  161 
//  162     /* Check for invalid chars in str */
//  163     for ( endp = startp; (c = *endp) != '\0'; ++endp)
??strtoul_13:
        B.N      ??strtoul_14
//  164     {
//  165         /* Check for 0..9,Aa-Zz */
//  166         if (!isalnum(c))
//  167         {
//  168             err = 1;
//  169             break;
//  170         }
//  171 
//  172         /* Convert int8 to num in 0..36 */
//  173         if (isdigit(c))
//  174         {
//  175             c = c - '0';
//  176         }
//  177         else
//  178         {
//  179             if (isupper(c))
//  180             {
//  181                 c = c - 'A' + 10;
//  182             }
//  183             else
//  184             {
//  185                 c = c - 'a' + 10;
//  186             }
//  187         }
//  188 
//  189         /* check c against base */
//  190         if (c >= base)
//  191         {
//  192             err = 1;
//  193             break;
//  194         }
//  195 
//  196         if (neg)
//  197         {
//  198             rvalue = (rvalue * base) - c;
//  199         }
//  200         else
//  201         {
//  202             rvalue = (rvalue * base) + c;
??strtoul_15:
        MLA      R7,R6,R7,R11
//  203         }
??strtoul_16:
        ADDS     R10,R10,#+1
??strtoul_14:
        LDRSB    R11,[R10, #+0]
        CMP      R11,#+0
        BEQ.N    ??strtoul_17
        MOV      R0,R11
        BL       isalnum
        CMP      R0,#+0
        BNE.N    ??strtoul_18
        MOVS     R8,#+1
//  204     }
//  205 
//  206     /* Upon exit, endp points to the character at which valid info */
//  207     /* STOPS.  No chars including and beyond endp are used.        */
//  208 
//  209     if (ptr != NULL)
??strtoul_17:
        CMP      R5,#+0
        BEQ.N    ??strtoul_19
//  210         *ptr = endp;
        STR      R10,[R5, #+0]
//  211 
//  212     if (err)
??strtoul_19:
        CMP      R8,#+0
        BEQ.N    ??strtoul_20
//  213     {
//  214         if (ptr != NULL)
        CMP      R5,#+0
        BEQ.N    ??strtoul_21
//  215             *ptr = str;
        STR      R4,[R5, #+0]
//  216         
//  217         return 0;
??strtoul_21:
        MOVS     R0,#+0
        B.N      ??strtoul_3
//  218     }
??strtoul_18:
        MOV      R0,R11
        BL       isdigit
        CMP      R0,#+0
        BEQ.N    ??strtoul_22
        SUBS     R11,R11,#+48
        B.N      ??strtoul_23
??strtoul_22:
        MOV      R0,R11
        BL       isupper
        CMP      R0,#+0
        BEQ.N    ??strtoul_24
        SUBS     R11,R11,#+55
        B.N      ??strtoul_23
??strtoul_24:
        SUBS     R11,R11,#+87
??strtoul_23:
        CMP      R11,R6
        BLT.N    ??strtoul_25
        MOVS     R8,#+1
        B.N      ??strtoul_17
??strtoul_25:
        CMP      R9,#+0
        BEQ.N    ??strtoul_15
        MUL      R0,R6,R7
        SUBS     R7,R0,R11
        B.N      ??strtoul_16
//  219     else
//  220     {
//  221         return rvalue;
??strtoul_20:
        MOVS     R0,R7
??strtoul_3:
        POP      {R1,R4-R11,PC}   ;; return
//  222     }
//  223 }
//  224 
//  225 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  226 int strlen (const int8 *str)
//  227 {
//  228     int8 *s = (int8 *)str;
//  229     int len = 0;
strlen:
        MOVS     R1,#+0
//  230 
//  231     if (s == NULL)
        CMP      R0,#+0
        BNE.N    ??strlen_0
//  232         return 0;
        MOVS     R0,#+0
        B.N      ??strlen_1
//  233 
//  234     while (*s++ != '\0')
//  235         ++len;
??strlen_2:
        ADDS     R1,R1,#+1
??strlen_0:
        MOVS     R2,R0
        ADDS     R0,R2,#+1
        LDRSB    R2,[R2, #+0]
        CMP      R2,#+0
        BNE.N    ??strlen_2
//  236 
//  237     return len;
        MOVS     R0,R1
??strlen_1:
        BX       LR               ;; return
//  238 }
//  239 
//  240 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  241 int8 * strcat (int8 *dest, const int8 *src)
//  242 {
strcat:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  243     int8 *dp;
//  244     int8 *sp = (int8 *)src;
        MOVS     R5,R1
//  245 
//  246     if ((dest != NULL) && (src != NULL))
        CMP      R4,#+0
        BEQ.N    ??strcat_0
        CMP      R1,#+0
        BEQ.N    ??strcat_0
//  247     {
//  248         dp = &dest[strlen(dest)];
        MOVS     R0,R4
        BL       strlen
        ADDS     R0,R0,R4
        B.N      ??strcat_1
//  249 
//  250         while (*sp != '\0')
//  251         {
//  252             *dp++ = *sp++;
??strcat_2:
        LDRB     R1,[R5, #+0]
        STRB     R1,[R0, #+0]
        ADDS     R5,R5,#+1
        ADDS     R0,R0,#+1
//  253         }
??strcat_1:
        LDRSB    R1,[R5, #+0]
        CMP      R1,#+0
        BNE.N    ??strcat_2
//  254         *dp = '\0';
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  255     }
//  256     return dest;
??strcat_0:
        MOVS     R0,R4
        POP      {R1,R4,R5,PC}    ;; return
//  257 }
//  258 
//  259 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  260 int8 * strncat (int8 *dest, const int8 *src, int n)
//  261 {
strncat:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R2
//  262     int8 *dp;
//  263     int8 *sp = (int8 *)src;
        MOVS     R6,R1
//  264 
//  265     if ((dest != NULL) && (src != NULL) && (n > 0))
        CMP      R4,#+0
        BEQ.N    ??strncat_0
        CMP      R1,#+0
        BEQ.N    ??strncat_0
        CMP      R5,#+1
        BLT.N    ??strncat_0
//  266     {
//  267         dp = &dest[strlen(dest)];
        MOVS     R0,R4
        BL       strlen
        ADDS     R0,R0,R4
        B.N      ??strncat_1
//  268 
//  269         while ((*sp != '\0') && (n-- > 0))
//  270         {
//  271             *dp++ = *sp++;
??strncat_2:
        LDRB     R1,[R6, #+0]
        STRB     R1,[R0, #+0]
        ADDS     R6,R6,#+1
        ADDS     R0,R0,#+1
//  272         }
??strncat_1:
        LDRSB    R1,[R6, #+0]
        CMP      R1,#+0
        BEQ.N    ??strncat_3
        MOVS     R1,R5
        SUBS     R5,R1,#+1
        CMP      R1,#+1
        BGE.N    ??strncat_2
//  273         *dp = '\0';
??strncat_3:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  274     }
//  275     return dest;
??strncat_0:
        MOVS     R0,R4
        POP      {R4-R6,PC}       ;; return
//  276 }
//  277 
//  278 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  279 int8 * strcpy (int8 *dest, const int8 *src)
//  280 {
//  281     int8 *dp = (int8 *)dest;
strcpy:
        MOVS     R2,R0
//  282     int8 *sp = (int8 *)src;
        MOVS     R3,R1
//  283 
//  284     if ((dest != NULL) && (src != NULL))
        CMP      R0,#+0
        BEQ.N    ??strcpy_0
        CMP      R1,#+0
        BEQ.N    ??strcpy_0
        B.N      ??strcpy_1
//  285     {
//  286         while (*sp != '\0')
//  287         {
//  288             *dp++ = *sp++;
??strcpy_2:
        LDRB     R1,[R3, #+0]
        STRB     R1,[R2, #+0]
        ADDS     R3,R3,#+1
        ADDS     R2,R2,#+1
//  289         }
??strcpy_1:
        LDRSB    R1,[R3, #+0]
        CMP      R1,#+0
        BNE.N    ??strcpy_2
//  290         *dp = '\0';
        MOVS     R1,#+0
        STRB     R1,[R2, #+0]
//  291     }
//  292     return dest;
??strcpy_0:
        BX       LR               ;; return
//  293 }
//  294 
//  295 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  296 int8 * strncpy (int8 *dest, const int8 *src, int n)
//  297 {
strncpy:
        PUSH     {R4}
//  298     int8 *dp = (int8 *)dest;
        MOVS     R3,R0
//  299     int8 *sp = (int8 *)src;
        MOVS     R4,R1
//  300 
//  301     if ((dest != NULL) && (src != NULL) && (n > 0))
        CMP      R0,#+0
        BEQ.N    ??strncpy_0
        CMP      R1,#+0
        BEQ.N    ??strncpy_0
        CMP      R2,#+1
        BLT.N    ??strncpy_0
        B.N      ??strncpy_1
//  302     {
//  303         while ((*sp != '\0') && (n-- > 0))
//  304         {
//  305             *dp++ = *sp++;
??strncpy_2:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R3, #+0]
        ADDS     R4,R4,#+1
        ADDS     R3,R3,#+1
//  306         }
??strncpy_1:
        LDRSB    R1,[R4, #+0]
        CMP      R1,#+0
        BEQ.N    ??strncpy_3
        MOVS     R1,R2
        SUBS     R2,R1,#+1
        CMP      R1,#+1
        BGE.N    ??strncpy_2
//  307         *dp = '\0';
??strncpy_3:
        MOVS     R1,#+0
        STRB     R1,[R3, #+0]
//  308     }
//  309     return dest;
??strncpy_0:
        POP      {R4}
        BX       LR               ;; return
//  310 }
//  311 
//  312 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  313 int strcmp (const int8 *s1, const int8 *s2)
//  314 {
//  315     /* No checks for NULL */
//  316     int8 *s1p = (int8 *)s1;
//  317     int8 *s2p = (int8 *)s2;
strcmp:
        B.N      ??strcmp_0
//  318 
//  319     while (*s2p != '\0')
//  320     {
//  321         if (*s1p != *s2p)
//  322             break;
//  323 
//  324         ++s1p;
??strcmp_1:
        ADDS     R0,R0,#+1
//  325         ++s2p;
        ADDS     R1,R1,#+1
??strcmp_0:
        LDRSB    R2,[R1, #+0]
        CMP      R2,#+0
        BEQ.N    ??strcmp_2
        LDRSB    R2,[R0, #+0]
        LDRSB    R3,[R1, #+0]
        CMP      R2,R3
        BEQ.N    ??strcmp_1
//  326     }
//  327     return (*s1p - *s2p);
??strcmp_2:
        LDRSB    R0,[R0, #+0]
        LDRSB    R1,[R1, #+0]
        SUBS     R0,R0,R1
        BX       LR               ;; return
//  328 }
//  329 
//  330 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  331 int strncmp (const int8 *s1, const int8 *s2, int n)
//  332 {
strncmp:
        PUSH     {R4}
//  333     /* No checks for NULL */
//  334     int8 *s1p = (int8 *)s1;
//  335     int8 *s2p = (int8 *)s2;
//  336 
//  337     if (n <= 0)
        CMP      R2,#+1
        BGE.N    ??strncmp_0
//  338         return 0;
        MOVS     R0,#+0
        B.N      ??strncmp_1
//  339 
//  340     while (*s2p != '\0')
//  341     {
//  342         if (*s1p != *s2p)
//  343             break;
//  344 
//  345         if (--n == 0)
//  346             break;
//  347 
//  348         ++s1p;
??strncmp_2:
        ADDS     R0,R0,#+1
//  349         ++s2p;
        ADDS     R1,R1,#+1
??strncmp_0:
        LDRSB    R3,[R1, #+0]
        CMP      R3,#+0
        BEQ.N    ??strncmp_3
        LDRSB    R3,[R0, #+0]
        LDRSB    R4,[R1, #+0]
        CMP      R3,R4
        BNE.N    ??strncmp_3
??strncmp_4:
        SUBS     R2,R2,#+1
        CMP      R2,#+0
        BNE.N    ??strncmp_2
//  350     }
//  351     return (*s1p - *s2p);
??strncmp_3:
        LDRSB    R0,[R0, #+0]
        LDRSB    R1,[R1, #+0]
        SUBS     R0,R0,R1
??strncmp_1:
        POP      {R4}
        BX       LR               ;; return
//  352 }
//  353 
//  354 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  355 void * memcpy (void *dest, const void *src, unsigned n)
//  356 {
memcpy:
        PUSH     {R4,R5}
//  357     int longs, bytes;
//  358     uint32 *dpl = (uint32 *)dest;
        MOVS     R4,R0
//  359     uint32 *spl = (uint32 *)src;
        MOVS     R5,R1
//  360     uint8  *dpb, *spb;
//  361 
//  362     if ((dest != NULL) && (src != NULL) && (n > 0))
        CMP      R0,#+0
        BEQ.N    ??memcpy_0
        CMP      R1,#+0
        BEQ.N    ??memcpy_0
        CMP      R2,#+0
        BEQ.N    ??memcpy_0
//  363     {
//  364         bytes = (n & 0x3);
        ANDS     R3,R2,#0x3
//  365         longs = (n - bytes) >> 2;
        SUBS     R1,R2,R3
        LSRS     R1,R1,#+2
        B.N      ??memcpy_1
//  366     
//  367         while (longs--)
//  368             *dpl++ = *spl++;
??memcpy_2:
        LDR      R2,[R5, #+0]
        STR      R2,[R4, #+0]
        ADDS     R5,R5,#+4
        ADDS     R4,R4,#+4
??memcpy_1:
        MOVS     R2,R1
        SUBS     R1,R2,#+1
        CMP      R2,#+0
        BNE.N    ??memcpy_2
//  369         
//  370         dpb = (uint8 *)dpl;
//  371         spb = (uint8 *)spl;
        B.N      ??memcpy_3
//  372         
//  373         while (bytes--)
//  374             *dpb++ = *spb++;
??memcpy_4:
        LDRB     R1,[R5, #+0]
        STRB     R1,[R4, #+0]
        ADDS     R5,R5,#+1
        ADDS     R4,R4,#+1
??memcpy_3:
        MOVS     R1,R3
        SUBS     R3,R1,#+1
        CMP      R1,#+0
        BNE.N    ??memcpy_4
//  375     }
//  376     return dest;
??memcpy_0:
        POP      {R4,R5}
        BX       LR               ;; return
//  377 }
//  378 
//  379 /****************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  380 void * memset (void *s, int c, unsigned n)
//  381 {
memset:
        PUSH     {R4}
//  382     /* Not optimized, but very portable */
//  383     uint8 *sp = (uint8 *)s;
        MOVS     R3,R0
//  384 
//  385     if ((s != NULL) && (n > 0))
        CMP      R0,#+0
        BEQ.N    ??memset_0
        CMP      R2,#+0
        BNE.N    ??memset_1
        B.N      ??memset_0
//  386     {
//  387         while (n--)
//  388         {
//  389             *sp++ = (uint8)c;
??memset_2:
        STRB     R1,[R3, #+0]
        ADDS     R3,R3,#+1
//  390         }
??memset_1:
        MOVS     R4,R2
        SUBS     R2,R4,#+1
        CMP      R4,#+0
        BNE.N    ??memset_2
//  391     }
//  392     return s;
??memset_0:
        POP      {R4}
        BX       LR               ;; return
//  393 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  394 
//  395 /****************************************************************/
// 
// 890 bytes in section .text
// 
// 890 bytes of CODE memory
//
//Errors: none
//Warnings: none
