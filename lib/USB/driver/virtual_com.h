/******************************************************************************
 *
 * Freescale Semiconductor Inc.
 * (c) Copyright 2004-2009 Freescale Semiconductor, Inc.
 * ALL RIGHTS RESERVED.
 *
 **************************************************************************//*!
 *
 * @file virtual_com.h
 *
 * @author 
 *
 * @version 
 *
 * @date May-28-2009
 *
 * @brief The file contains Macro's and functions required for Virtual COM  
 *        Loopback Application
 *
 *****************************************************************************/

#ifndef _VIRTUAL_COM_H
#define _VIRTUAL_COM_H

#include "types.h"

/******************************************************************************
 * Constants - None
 *****************************************************************************/

/******************************************************************************
 * Macro's
 *****************************************************************************/
#define  CONTROLLER_ID      (0)   /* ID to identify USB CONTROLLER */ 

#define  KBI_STAT_MASK      (0x0F)

/* 
   DATA_BUFF_SIZE should be greater than or equal to the endpoint buffer size, 
   otherwise there will be data loss. For MC9S08JS16, maximum DATA_BUFF_SIZE 
   supported is 16 Bytes
*/
#ifndef _MC9S08JS16_H
#define  DATA_BUFF_SIZE     (16)
#else
#define  DATA_BUFF_SIZE     (16)
// lpld #define  DATA_BUFF_SIZE     (16)
#endif

//声明USB接收结构体
typedef struct _USB_REV
{
  uint8_t buffer[DATA_BUFF_SIZE]; //声明64字节的缓冲区
  uint8_t len;                    //声明接收长度
}tUSB_Rev;

extern tUSB_Rev tUSB_Rev_Data;    //定义结构体对象

typedef void(*USB_REV_CALLBACK)(void); //声明结接收回调函数
/*****************************************************************************
 * Global variables
 *****************************************************************************/

/*****************************************************************************
 * Global Functions
 *****************************************************************************/
extern void USB_CDC_Init(void);
extern void USB_CDC_Task(void);
void USB_Rev_SetIsr(USB_REV_CALLBACK );
#endif 
