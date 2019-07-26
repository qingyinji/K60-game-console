/**
 * @file HW_CAN.c
 * @version 3.0[By LPLD]
 * @date 2013-06-18
 * @brief CAN底层模块相关函数
 *
 * 更改建议:不建议修改
 *
 * 版权所有:北京拉普兰德电子技术有限公司
 * http://www.lpld.cn
 * mail:support@lpld.cn
 *
 * @par
 * 本代码由拉普兰德[LPLD]开发并维护，并向所有使用者开放源代码。
 * 开发者可以随意修使用或改源代码。但本段及以上注释应予以保留。
 * 不得更改或删除原版权所有者姓名，二次开发者可以加注二次版权所有者。
 * 但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 * 拉普兰德不负责由于使用本代码所带来的任何事故、法律责任或相关不良影响。
 * 拉普兰德无义务解释、说明本代码的具体原理、功能、实现方法。
 * 除非拉普兰德[LPLD]授权，开发者不得将本代码用于商业产品。
 */

#include "common.h"
#include "HW_CAN.h"

//FlexCAN模块设置波特率函数
static void LPLD_CAN_SetBaudRate(CAN_Type *,uint32 );
//FlexCAN 清楚中断标志位函数
static void LPLD_CAN_Interrupt_ClearPending(CAN_Type *, uint8 );
//FlexCAN 获得中断标志位函数
static uint8 LPLD_CAN_Interrupt_GetFlag(CAN_Type *, uint8 );
//FlexCAN 解锁Msg缓冲区函数
static uint16 LPLD_CAN_UnlockMsg(CAN_Type *);
//FlexCAN 使能Msg缓冲区中断函数
static void LPLD_CAN_EnableMsgInterrupt(CAN_Type *, uint8 );
//FlexCAN 设置Msg缓冲区的CODE
static void LPLD_CAN_SetMsgCode(CAN_Type *, uint8 , uint8 );
//FlexCAN 获得Msg缓冲区的CODE
static uint32 LPLD_CAN_GetMsgCode(CAN_Type *, uint8 );
//FlexCAN 获得Msg缓冲区的TIMESTAMP
static uint16 LPLD_CAN_GetMsgTimeStamp(CAN_Type *, uint8 );
//FlexCAN 设置Msg缓冲区的ID
void LPLD_CAN_SetMsgID(CAN_Type *, uint8 ,uint32 );
//FlexCAN 获得Msg缓冲区的ID
static uint32 LPLD_CAN_GetMsgID(CAN_Type *, uint8 );
//FlexCAN 设置Msg缓冲区的长度
static void LPLD_CAN_SetMsgLength(CAN_Type *, uint8 ,uint8 );
//FlexCAN 获得Msg缓冲区的长度
uint8 LPLD_CAN_GetMsgLength(CAN_Type *canx, uint8 MSG_NUM);
//FlexCAN 获得Msg缓冲区的数据
static void LPLD_CAN_GetData(CAN_Type *canx, uint8 , uint8 ,  uint8 *);
//FlexCAN 写Msg缓冲区的数据
static void LPLD_CAN_WriteData(CAN_Type *, uint8 , uint8, uint8 * );
//FlexCAN 传输中断函数
void LPLD_CAN_Transmit_Interrupt(CAN_Type *, uint8 );
//FlexCAN 接收中断函数
static void LPLD_CAN_Receive_Interrupt(CAN_Type *, uint8 );
//FlexCAN CAN0的中断处理函数
static void LPLD_CAN_CAN0_Interrupt_Handler(CAN_MSGOBJ_InitTypeDef *);
//FlexCAN CAN1的中断处理函数
static void LPLD_CAN_CAN1_Interrupt_Handler(CAN_MSGOBJ_InitTypeDef *);

//设置16个Msg的结构体
CAN_MSGOBJ_InitTypeDef  flexcan_msgobj_param_t[MSG_MAX_NO] = {0};
//设置CANx Msg的中断回掉函数
CAN_ISR_CALLBACK CAN0_ISR[MSG_MAX_NO];
CAN_ISR_CALLBACK CAN1_ISR[MSG_MAX_NO];

/*
 * LPLD_CAN_Init
 * 在该函数中使能CANx，设置CANx的波特率，选择相应的工作模式
 * 通过CAN_InitTypeDef结构体对CAN进行初始化。
 * 
 * 参数:
 *    CAN_InitTypeDef--can_init_structure
 *                     具体定义见HW_CAN.h can_init_structure
 *
 * 输出:
 *    无
 *
 */
void LPLD_CAN_Init(CAN_InitTypeDef can_init_structure)
{
  uint8 i;
  CAN_Type *canx = can_init_structure.CAN_Canx;
  uint32 baud = can_init_structure.CAN_BaudRate;
  uint8  mask_mode = can_init_structure.CAN_RxMaskMode;
  PortPinsEnum_Type tx_pin = can_init_structure.CAN_TxPin;
  PortPinsEnum_Type rx_pin = can_init_structure.CAN_RxPin;

  ASSERT(mask_mode <= CAN_MSGOBJ_GLOBAL_MASKING);
  ASSERT(baud <= CAN_BAUD_RATE_1MBPS);
    
  OSC->CR |= OSC_CR_ERCLKEN_MASK | OSC_CR_EREFSTEN_MASK;
  
  if(canx == CAN0)
    SIM->SCGC6 |= SIM_SCGC6_FLEXCAN0_MASK;
  else
    SIM->SCGC3 |= SIM_SCGC3_FLEXCAN1_MASK;
  
  if(canx == CAN0)
  {
    if(tx_pin == PTB18)//CAN0_TX
    {
      PORTB->PCR[18] = PORT_PCR_MUX(2)| PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; 
    }
    else
    {
      PORTA->PCR[12] = PORT_PCR_MUX(2); 
    }

    if(rx_pin == PTB19)//CAN0_RX
    {
      PORTB->PCR[19] = PORT_PCR_MUX(2)| PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; 
    }
    else
    {
      PORTA->PCR[13] = PORT_PCR_MUX(2); 
    }
  }
  else
  {
    if(tx_pin == PTC17)//CAN1_TX
    {
      PORTC->PCR[17] = PORT_PCR_MUX(2)| PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; 
    }
    else
    {
      PORTE->PCR[24] = PORT_PCR_MUX(2)| PORT_PCR_PE_MASK | PORT_PCR_PS_MASK;
    }

    if(rx_pin == PTC16)//CAN1_RX
    {
      PORTC->PCR[16] = PORT_PCR_MUX(2)| PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; 
    }
    else
    {
      PORTE->PCR[25] = PORT_PCR_MUX(2)| PORT_PCR_PE_MASK | PORT_PCR_PS_MASK;
    }
  } 	 
  //禁止CAN外设
  canx->MCR   |= CAN_MCR_MDIS_MASK;
  //只有在LPM_ACK = 1情况下才可以选择钟源
  canx->CTRL1 |= CAN_CTRL1_CLKSRC_MASK;  //选择peripheral clock作为CAN外设的时钟源
                                         //设置此位必须在CAN停止模式下
  //在时钟初始化完毕和CAN总线使能完毕后，
  //单片机自动进入冻结模式
  //只有在冻结模式下才能配置大多数CAN总线寄存器
  //使能冻结模式
  canx->MCR |= CAN_MCR_HALT_MASK; 
  canx->MCR |= CAN_MCR_FRZ_MASK;
  canx->MCR &= ~CAN_MCR_MDIS_MASK; 
  
  while(!(canx->MCR & CAN_MCR_LPMACK_MASK));	

  //进行软件复位
  canx->MCR ^= CAN_MCR_SOFTRST_MASK;
  while(canx->MCR & CAN_MCR_SOFTRST_MASK);
            
  //等待进入冻结模式 
  while(!(canx->MCR & CAN_MCR_FRZACK_MASK));
  
  if(mask_mode == CAN_MSGOBJ_GLOBAL_MASKING)
  {
    canx->MCR &= ~CAN_MCR_IRMQ_MASK;   //使能全局匹配寄存器禁止单独匹配 
  }
  else
  {
    canx->MCR |= CAN_MCR_IRMQ_MASK;   //使能Msg单独匹配 
  }
  
  canx->MCR |= CAN_MCR_SUPV_MASK ;   //设置成管理模式 
  canx->MCR |= CAN_MCR_SRXDIS_MASK ; //禁止自我接收
  canx->MCR &= ~CAN_MCR_WRNEN_MASK;  //不产生警告中断
  canx->MCR &= ~CAN_MCR_RFEN_MASK ;  //禁止接收FIFO
  canx->MCR &= ~CAN_MCR_AEN_MASK;    //禁止Abort
  canx->MCR &= ~CAN_MCR_LPRIOEN_MASK;//禁止本地优先
  
  //配置相关的寄存器
  canx->CTRL2 |= CAN_CTRL2_EACEN_MASK; //接收邮箱过滤IDE匹配，RTR不匹配
  canx->CTRL2 &= ~CAN_CTRL2_RRS_MASK;  //不自动产生远程请求帧产生
  canx->CTRL2 |= CAN_CTRL2_MRP_MASK;   //ID首先从邮箱中匹配

  //canx->CTRL1 |= CAN_CTRL1_LBUF_MASK;  //发送的时候从低Msg开始
  canx->CTRL1 &= ~CAN_CTRL1_LBUF_MASK;   //发送的时候从低优先级发送
                             
  //canx->CTRL1 |= CAN_CTRL1_LPB_MASK;  //loop 模式,用于测试
  canx->CTRL1 &= ~CAN_CTRL1_LPB_MASK;   //使用正常模式
  //设置CAN总线通信的波特率
  LPLD_CAN_SetBaudRate(canx,baud);
  //清空CAN自由计数器 
  canx->TIMER = 0x0000; 
  //将MB_MAX个邮箱缓冲区内容清0
  for(i = 0;i < MSG_MAX_NO; i++)
  {
    canx->MB[i].CS    = 0x00000000;
    canx->MB[i].ID    = 0x00000000;
    canx->MB[i].WORD0 = 0x00000000;
    canx->MB[i].WORD1 = 0x00000000;        
  }
  //清除64个邮箱的标志位
  canx->IFLAG1 = 0xFFFFFFFF;
  canx->IFLAG2 = 0xFFFFFFFF;
  //禁止邮箱中断
  canx->IMASK1 = 0x00000000;
  canx->IMASK2 = 0x00000000;
   /*
  如果MCR的IRMQ为1，表示每个邮箱都可以单独进行ID匹配
  注意：如果是low cost MCUs（低配置的MCU），没有单独匹配这项功能。
          1\ID匹配会选择free to receive状态的邮箱作为胜者，
          获胜的邮箱可以从接收缓冲区内将接收的帧 Move in 到MB中；
          2\如果出现ID号相同的邮箱，会首先从序号低的邮箱进行匹配，如果
          低序号邮箱是non free to receive状态，那么匹配过程将会查找
          下一个邮箱直到找到free to receive状态且ID相同的邮箱；
          3\如果ID号相同的邮箱都处于non free to receive状态，那么匹配过程
          将停止在最后一个有相同ID的邮箱位置，将帧Move in 到MB中并且将该邮
          箱的状态设置成OVERRUN。
          RXIMR[i]存储在单片机的RAM中，只有在CAN冻结模式下可写。
          此时CANx_RXMGMASK、CANx_RX14MASK、CANx_RX15MASK不起作用
  */

  for(i = 0;i < MSG_MAX_NO; i++)
  {
    canx->RXIMR[i] = 0x1FFFFFFF;//设置邮箱29位全部屏蔽
  }
 /*
  如果MCR的IRMQ为0，表示使用全局匹配寄存器进行匹配，
          此时CANx_RXMGMASK、CANx_RX14MASK、CANx_RX15MASK起作用；
          CANx_RXMGMASK管理除CANx_RX14MASK、CANx_RX15MASK以外的所有Msg；
          ID匹配过程会停止在找到的第一个ID相同的邮箱位置，不管该邮箱是否处于
          free to receive状态。
  */

  canx->RXMGMASK = 0x1FFFFFFF; //29位ID全部匹配            
  canx->RX14MASK = 0x1FFFFFFF;
  canx->RX15MASK = 0x1FFFFFFF; 

  canx->MCR &= ~CAN_MCR_FRZ_MASK; //退出冻结模式
  //等待直到退出冻结模式
  while( canx->MCR & CAN_MCR_FRZACK_MASK); 
  //只有在冻结模式下才能配置，配置完推出冻结模式
  canx->MCR &= ~(CAN_MCR_HALT_MASK); 
  //等到不在冻结模式，休眠模式或者停止模式
  while( canx->MCR & CAN_MCR_NOTRDY_MASK);
  //使能CAN外设
  canx->MCR &= ~CAN_MCR_MDIS_MASK;
}
/*
 * LPLD_CAN_SetBaudRate
 * 设置CAN波特率
 * 参数:
 *    CAN_Type *canx
 *      |___CAN0 --CAN0号模块
 *      |___CAN1 --CAN0号模块
 *    baud 波特率
 *      |__CAN_BAUD_RATE_50KBPS  --波特率50KBPS
 *      |__CAN_BAUD_RATE_100KBPS --波特率100KBPS
 *      |__CAN_BAUD_RATE_250KBPS --波特率250KBPS
 *      |__CAN_BAUD_RATE_500KBPS --波特率500KBPS
 *      |__CAN_BAUD_RATE_1MBPS   --波特率1MBPS
 *  输出：
 *    无
*/
static void LPLD_CAN_SetBaudRate(CAN_Type *canx,uint32 baud)
{
  uint8 prescale;
  //1个CAN总线位的时间量子：Time Quanta = SYNC_SEG + (PROP_SEG + PSEG1 + 2) + (PSEG2 + 1)，
  //SYNC_SEG =  1 （固定值）
  ASSERT(baud <= CAN_BAUD_RATE_1MBPS);
  switch(baud)
  {
    case CAN_BAUD_RATE_1MBPS:
      {
        prescale = CAN_GET_PRESCALE(g_bus_clock,baud,10); 
        //设置CAN总线通信的波特率
        canx->CTRL1 |= CAN_CTRL1_RJW(2) 
                 | CAN_CTRL1_PROPSEG(2)  
                 | CAN_CTRL1_PSEG1(2) 
                 | CAN_CTRL1_PSEG2(2)
                 | CAN_CTRL1_PRESDIV(prescale); 
        break;
      }
    case CAN_BAUD_RATE_500KBPS:
    case CAN_BAUD_RATE_250KBPS:
    case CAN_BAUD_RATE_100KBPS:
    case CAN_BAUD_RATE_50KBPS:
      {
        prescale = CAN_GET_PRESCALE(g_bus_clock,baud,20); 
        //设置CAN总线通信的波特率
        canx->CTRL1 |= CAN_CTRL1_RJW(2) 
                 | CAN_CTRL1_PROPSEG(6)  
                 | CAN_CTRL1_PSEG1(6) 
                 | CAN_CTRL1_PSEG2(4)
                 | CAN_CTRL1_PRESDIV(prescale); 
        break;
      }
    default:break;
  }
}

/*
 * LPLD_CAN_Deinit
 * CAN反初始化函数，在该函数中禁止CANx的总线时钟，禁止模块中断，关闭CAN模块
 * 
 * 参数:
 *    CAN_InitTypeDef--can_init_structure
 *                     具体定义见HW_CAN.h can_init_structure
 * 输出:
 *    无
 *
*/
void LPLD_CAN_Deinit(CAN_InitTypeDef can_init_structure)
{
  CAN_Type *canx = can_init_structure.CAN_Canx;
  
  if(canx == CAN0)
  {
    SIM->SCGC6 &= ~SIM_SCGC6_FLEXCAN0_MASK;
    disable_irq(CAN0_ORed_Message_buffer_IRQn);
  }
  else
  {
    SIM->SCGC3 &= ~SIM_SCGC3_FLEXCAN1_MASK;
    enable_irq(CAN1_ORed_Message_buffer_IRQn);
  }
  //禁止CAN外设
  canx->MCR |= CAN_MCR_MDIS_MASK;
  canx->MCR |= CAN_MCR_HALT_MASK; 
  canx->MCR |= CAN_MCR_FRZ_MASK;
}
/*
 * LPLD_CAN_EnableIrq
 * 使能CAN模块中断
 * 
 * 参数:
 *    CAN_InitTypeDef--can_init_structure
 *                     具体定义见HW_CAN.h can_init_structure
 * 输出:
 *    无
 *
*/
void LPLD_CAN_EnableIrq(CAN_InitTypeDef can_init_structure)
{
  CAN_Type *canx = can_init_structure.CAN_Canx;
    
  if(canx == CAN0)
  {
    enable_irq(CAN0_ORed_Message_buffer_IRQn);
  }
  else if(canx == CAN1)
  {
    enable_irq(CAN1_ORed_Message_buffer_IRQn);
  }
}

/*
 * LPLD_CAN_DisableIrq
 * 禁止CAN模块中断
 * 
 * 参数:
 *    CAN_InitTypeDef--can_init_structure
 *                     具体定义见HW_CAN.h can_init_structure
 * 输出:
 *    无
 *
*/
void LPLD_CAN_DisableIrq(CAN_InitTypeDef can_init_structure)
{
  CAN_Type *canx = can_init_structure.CAN_Canx;
    
  if(canx == CAN0)
  {
    disable_irq(CAN0_ORed_Message_buffer_IRQn);
  }
  else if(canx == CAN1)
  {
    disable_irq(CAN1_ORed_Message_buffer_IRQn);
  }
}

/*
 * LPLD_CAN_InitMessageObject
 *
 * 设置CAN Message buffer（Msg）格式，通过CAN_MSGOBJ_InitTypeDef
 * 结构体对CAN Message buffer进行初始化。
 * 
 * 参数:
 *    CAN_MSGOBJ_InitTypeDef--can_msg_init_structure
 *                            具体定义见HW_CAN.h CAN_MSGOBJ_InitTypeDef
 *    message_id
 *      设置message_id，id长度根据CAN_MSGOBJ_InitTypeDef的参数而定
 *      id的长度分为11位标准帧和29位扩展帧两种
 *      CAN_MSGOBJ_ID_STD 表示标准帧，如CAN_MSGOBJ_InitTypeDef中设置id长度为CAN_MSGOBJ_ID_STD
 *      此时message_id最长为11位，不能超过0x0FFF；
 *      CAN_MSGOBJ_ID_EXT 表示扩展帧，如CAN_MSGOBJ_InitTypeDef中设置id长度为CAN_MSGOBJ_ID_EXT
 *      此时message_id最长为29位，不能超过0x1FFFFFFF；
 * 输出:
 *    无
 *
 */
void LPLD_CAN_InitMessageObject(CAN_MSGOBJ_InitTypeDef can_msg_init_structure,uint32 message_id)	
{
  uint32    cs_temp;
  uint8     msg_num_temp  = can_msg_init_structure.CAN_MsgNum;
  CAN_Type *canx_ptr      = can_msg_init_structure.CAN_Canx;
  
  CAN_ISR_CALLBACK isr_func = can_msg_init_structure.CAN_Isr;
  
  cs_temp = CAN_MB_CS_RTR(can_msg_init_structure.CAN_MsgRTR) | \
            CAN_MB_CS_SRR(can_msg_init_structure.CAN_MsgSRR) | \
            CAN_MB_CS_IDE(can_msg_init_structure.CAN_MsgIdLength) |\
            CAN_MB_CS_DLC(can_msg_init_structure.CAN_MsgDataLength);
  //根据CAN_MsgDirection的类型设置Msg是发送功能还是接收功能
  if(can_msg_init_structure.CAN_MsgDirection == CAN_MSGOBJ_DIR_TX)
  {
    cs_temp |= CAN_MB_CS_CODE(CAN_MSGOBJ_TX_INACTIVE);
  }
  else if(can_msg_init_structure.CAN_MsgDirection == CAN_MSGOBJ_DIR_RX)
  {
    cs_temp |= CAN_MB_CS_CODE(CAN_MSGOBJ_RX_EMPTY);
  }
  //设置Msg CODE的初始值
  //如果是发送模式设置成为INACTIVE状态
  //如果是接收模式设置成为EMPTY状态
  canx_ptr->MB[msg_num_temp].CS = cs_temp;
  //设置Msg ID
  LPLD_CAN_SetMsgID(canx_ptr,msg_num_temp,message_id); 
  //
  if(can_msg_init_structure.CAN_MsgInterrupt == TRUE)
  {
    LPLD_CAN_EnableMsgInterrupt(canx_ptr,msg_num_temp);//使能Msg中断 
    //设置Msg中断回掉函数
    if(canx_ptr == CAN0)
    {
      if(isr_func != NULL)
      {
        CAN0_ISR[msg_num_temp] = isr_func;
      }
    }
    else
    {
      if(isr_func != NULL)
      {
        CAN1_ISR[msg_num_temp] = isr_func;
      }
    }
  }
  else
  {
    if(canx_ptr == CAN0)
    {
        CAN0_ISR[msg_num_temp] = NULL; 
    }
    else
    {
        CAN1_ISR[msg_num_temp] = NULL;
    }
  }
}

/*
 * LPLD_CAN_TransmitMessage
 * CAN 发送消息函数
 * 参数:
 *    CAN_MSGOBJ_InitTypeDef--can_msg_init_structure
 *                            具体定义见HW_CAN.h CAN_MSGOBJ_InitTypeDef
 *    CAN_MessageFormat_TypeDef--*can_rx_msg
 *                            具体定义见HW_CAN.h CAN_MessageFormat_TypeDef
 *    该结构体用于定义CAN的消息格式，当CAN发送消息时，会从CAN_MessageFormat_TypeDef定义的结构体对象中
 *    提取信息并存储到MSG中，MSG会将消息发送到CAN总线上。
 *    该结构体中的主要变量为 消息ID、时间戳、数据长度、存储数据的缓冲区
 * 输出:
 *    1 发送完毕
 *    0 发送失败
 *
 */
uint8 LPLD_CAN_TransmitMessage(CAN_MSGOBJ_InitTypeDef can_msg_init_structure,\
                               CAN_MessageFormat_TypeDef *can_tx_msg )
{
  uint8  request;
  uint8  msg_num_temp  = can_msg_init_structure.CAN_MsgNum;
  CAN_Type *canx_ptr   = can_msg_init_structure.CAN_Canx;
  uint32  message_id = can_tx_msg->CAN_MsgID;  
  uint8  *in_data_buffer = can_tx_msg->CAN_MsgDataBuffer;
  uint8   in_data_length = can_tx_msg->CAN_MsgDataLength;
  //如果发送Msg缓冲区中的CODE不等于CAN_MSGOBJ_TX_UNCONDITIONAL
  if( LPLD_CAN_GetMsgCode(canx_ptr,msg_num_temp) != CAN_MSGOBJ_TX_UNCONDITIONAL)
  {
    //向发送Msg缓冲区中的CODE中写INACTIVE命令
    canx_ptr->MB[msg_num_temp].CS |= CAN_MB_CS_CODE(CAN_MSGOBJ_TX_INACTIVE);
    //设置Msg的ID
    LPLD_CAN_SetMsgID(canx_ptr,msg_num_temp,message_id);
    //向Msg中写入要发送的数据
    LPLD_CAN_WriteData(canx_ptr,msg_num_temp,in_data_length,in_data_buffer);
    //设置Msg的长度
    LPLD_CAN_SetMsgLength(canx_ptr,msg_num_temp,in_data_length);
    //向发送Msg缓冲区中的CODE中写TX_UNCONDITIONAL命令，等待发送完成
    canx_ptr->MB[msg_num_temp].CS |= CAN_MB_CS_CODE(CAN_MSGOBJ_TX_UNCONDITIONAL);
    //如果开启发送中断，发送完毕后会触发中断
    request = 1;
  }
  else
  {
    request = 0;
  }
  return (request);
}

/*
 * LPLD_CAN_ReceivedMessage
 * CAN 处理接收函数，此函数一般在CAN中断函数中调用
 * 参数:
 *    CAN_MSGOBJ_InitTypeDef--can_msg_init_structure
 *                            具体定义见HW_CAN.h CAN_MSGOBJ_InitTypeDef
 *    CAN_MessageFormat_TypeDef--*can_rx_msg
 *                            具体定义见HW_CAN.h CAN_MessageFormat_TypeDef
 *    该结构体用于定义CAN的消息格式，当CAN成功接收消息以后，会从MSG中将信息存储到
 *    CAN_MessageFormat_TypeDef定义的结构体对象中。
 *    该结构体中的主要变量为 消息ID、时间戳、数据长度、存储数据的缓冲区
 *    
 *  输出：
 *    无
 */
void LPLD_CAN_ReceivedMessage(CAN_MSGOBJ_InitTypeDef can_msg_init_structure,\
                              CAN_MessageFormat_TypeDef *can_rx_msg)
{
  uint32 message_code,i;
  volatile uint16 timer;
  uint8 rx_data[CAN_DATA_MAX_BYTES];
  uint8 data_length;
  uint16 time_stamp;
  uint32 msg_id;
  CAN_Type *canx = can_msg_init_structure.CAN_Canx;
  uint8 msg_num = can_msg_init_structure.CAN_MsgNum;
  //获得Msg缓冲区中的code值
  message_code = LPLD_CAN_GetMsgCode(canx,msg_num);
  
  if ((message_code != CAN_MSGOBJ_RX_BUSY) && 
     (message_code != CAN_MSGOBJ_RX_OVERRUN))
  {
    //读取ID(可选)
    msg_id = LPLD_CAN_GetMsgID(canx, msg_num);
   
    //读取Msg缓冲区接收数据的长度
    data_length    = (uint8_t)LPLD_CAN_GetMsgLength(canx, msg_num);
    //读取Msg缓冲区接收数据
    LPLD_CAN_GetData(canx, msg_num,data_length,rx_data);
    //获得Msg缓冲区时间戳
    time_stamp = LPLD_CAN_GetMsgTimeStamp(canx, msg_num);
    
    for(i = data_length; i < 8; i++)
    {
       rx_data[i] = 0;
    }
    //将MSG中的消息存储到can_rx_msg中
    can_rx_msg->CAN_MsgID = msg_id;
    can_rx_msg->CAN_MsgDataLength = data_length;
    can_rx_msg->CAN_MsgTimeStamp  = time_stamp;
    memcpy(can_rx_msg->CAN_MsgDataBuffer,rx_data,data_length);
     
    //读取自由计数器，解锁当前Msg缓冲区
    timer = LPLD_CAN_UnlockMsg(canx);
    //清空Msg缓冲区的中断标志位
    LPLD_CAN_Interrupt_ClearPending(canx,msg_num);
    //再次写邮箱的code为empty状态
    LPLD_CAN_SetMsgCode(canx,msg_num,CAN_MSGOBJ_RX_EMPTY);
  }
  else
  {
    //接收邮箱溢出
    LPLD_CAN_Interrupt_ClearPending(canx,msg_num);
    //读取自由计数器，解锁当前Msg缓冲区
    timer = LPLD_CAN_UnlockMsg(canx);
  }
}

/*
 * LPLD_CAN_Interrupt_ClearPending
 * 清除Msg的中断标志位
 * 参数:
 *    CAN_Type *canx
 *      |___ CAN0 --CAN0号模块
 *      |___ CAN1 --CAN1号模块
 *    msg_num 选择要清除中断标志的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *   无
 */
static void LPLD_CAN_Interrupt_ClearPending(CAN_Type *canx, uint8 msg_num)
{   
  if(msg_num < 32)
  {
    canx->IFLAG1 |= (1<<msg_num); 
  }
  else
  {
    canx->IFLAG2 |= (1<<(msg_num-32));
  }
}

/*
 * LPLD_CAN_Interrupt_GetFlag
 * 获得CAN 的中断标志位
 * 参数:
 *    CAN_Type *canx
 *      |___ CAN0 --CAN0号模块
 *      |___ CAN1 --CAN1号模块
 *    msg_num 选择要获得中断标志的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *    返回需要 Msg缓冲区的中断标志位
 */
static uint8 LPLD_CAN_Interrupt_GetFlag(CAN_Type *canx, uint8 msg_num)
{   
  uint8 status;
  if(msg_num < 32)
  {
    status = (canx->IFLAG1 >> msg_num) & 0x01; 
  }
  else
  {
    status = (canx->IFLAG2 >> (msg_num - 32) )& 0x01; 
  }
  return status;
}

/*
 * LPLD_CAN_UnlockMsg
 * 该函数通过读取自由计数器，解锁Msg
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 * 输出:
 *    16位CAN自由计数器记录的时间戳
 */
static uint16 LPLD_CAN_UnlockMsg(CAN_Type *canx)
{
  return (canx->TIMER);
}

/*
 * LPLD_CAN_EnableMsgInterrupt
 * 该函数用于使能Msg中断
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要使能中断的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *    无
 *
 */
static void LPLD_CAN_EnableMsgInterrupt(CAN_Type *canx, uint8 msg_num)
{
  if(msg_num < 32)
  {
    canx->IMASK1 |= (1<<msg_num); 
  }
  else
  {
    canx->IMASK2 |= (1<<(msg_num-32));
  }
}

/*
 * LPLD_CAN_SetMsgCode
 * 该函数用于设置Msg的code值
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要设置CODE的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 *    code--需要设置的code值
 * 输出:
 *    无
 *
 */
static void LPLD_CAN_SetMsgCode(CAN_Type *canx, uint8 msg_num, uint8 code)
{
  //canx->MB[msg_num].CS &= (~CAN_MB_CS_CODE_MASK);
  canx->MB[msg_num].CS |= CAN_MB_CS_CODE(code);
}

/*
 * LPLD_CAN_GetMsgCode
 * 该函数用于获得Msg缓冲区的code值
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要获得CODE的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *     返回相应Msg缓冲区的code
 *
 */
static uint32 LPLD_CAN_GetMsgCode(CAN_Type *canx, uint8 msg_num)
{
   return CAN_GET_MB_CS_CODE(canx->MB[msg_num].CS);
}
/*
 * LPLD_CAN_GetMsgTimeStamp
 * 该函数用于获得Msg缓冲区的时间戳
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要获得时间戳的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *     返回相应Msg缓冲区的时间戳
 *
 */
static uint16 LPLD_CAN_GetMsgTimeStamp(CAN_Type *canx, uint8 msg_num)
{
  return CAN_GET_MB_CS_TIMESTAMP(canx->MB[msg_num].CS);
}

/*
 * LPLD_CAN_SetMsgID
 * 该函数用于设置Msg缓冲区的ID值
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要设置ID的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 *   message_id
 *      |__设置Msg缓冲区的ID
 * 输出：
 *   无
 */
static void LPLD_CAN_SetMsgID(CAN_Type *canx, uint8 msg_num,uint32 message_id)
{
  uint32 id_temp;
  if(CAN_GET_MB_CS_IDE(canx->MB[msg_num].CS) == CAN_MSGOBJ_ID_STD)
  {
    id_temp =  CAN_MB_ID_STD(message_id);
  }
  else
  {
    id_temp =  CAN_MB_ID_EXT(message_id);
  }
  canx->MB[msg_num].ID = id_temp;
}

/*
 * LPLD_CAN_GetMsgID
 * 该函数用于获得Msg缓冲区的ID值
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要获得ID的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *     返回相应Msg缓冲区的ID
 *
 */
static uint32 LPLD_CAN_GetMsgID(CAN_Type *canx, uint8 msg_num)
{
  uint32 id_temp;
  if(CAN_GET_MB_CS_IDE(canx->MB[msg_num].CS) == CAN_MSGOBJ_ID_STD)
  {
    id_temp =  CAN_GET_MB_ID_STD(canx->MB[msg_num].ID);
  }
  else
  {
    id_temp =  CAN_GET_MB_ID_EXT(canx->MB[msg_num].ID);
  }
  return id_temp;
}

/*
 * LPLD_CAN_SetMsgLength
 * 该函数用于设置Msg缓冲区的数据长度
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要设置数据长度的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 *   in_length
 *      |__数据长度
 * 输出:
 *     无
 *
 */
static void LPLD_CAN_SetMsgLength(CAN_Type *canx, uint8 msg_num,uint8 in_length)
{
  //canx->MB[msg_num].CS &= (~CAN_MB_CS_DLC_MASK);
  canx->MB[msg_num].CS |= CAN_MB_CS_DLC(in_length);  
}

/*
 * LPLD_CAN_GetMsgLength
 * 该函数用于获得Msg缓冲区的数据长度
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要获得数据长度的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *     数据的长度
 *
 */
static uint8 LPLD_CAN_GetMsgLength(CAN_Type *canx, uint8 msg_num)
{
  return CAN_GET_MB_CS_LENGTH(canx->MB[msg_num].CS);
}

/*
 * LPLD_CAN_GetData
 * 该函数用于获得Msg缓冲区中的数据
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要获得数据的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 *    in_length
 *      |__获得数据长度
 *    *in_buffer
 *      |__获得数据的缓冲区
 * 输出:
 *    无 
 */
static void LPLD_CAN_GetData(
    CAN_Type *canx, 
    uint8     msg_num, 
    uint8     in_length, 
    uint8    *in_buffer)
{
  int i;
  uint8  *pMBData;
  uint8  *pRecieve  = in_buffer;
  uint8  word_num   = (in_length - 1)/ 4; //Get the Message buffer word number
  uint8  rest_bytes = (in_length - 1)% 4; //Get the reset bytes of buffer
  if(word_num > 0)
  {  
    pMBData = (uint8*)&canx->MB[msg_num].WORD0+3;
    for(i = 0 ; i < 4 ; i++)   
    {
      pRecieve[i] = *pMBData--;
    }
    pMBData = (uint8*)&canx->MB[msg_num].WORD1+3;
  }
  else
  {
    pMBData = (uint8*)&canx->MB[msg_num].WORD0+3;
  }

  for(i = 0; i <= rest_bytes; i++)
  {
    pRecieve[i+(word_num<<2)] = *pMBData--;    
  }
}

/*
 * LPLD_CAN_WriteData
 * 该函数用于向Msg缓冲区中的写数据
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要写数据的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 *    in_length
 *      |__写入数据长度
 *    *in_buffer
 *      |__写入数据的缓冲区
 * 输出:
 *    无 
 */
static void LPLD_CAN_WriteData(
    CAN_Type *canx, 
    uint8     msg_num, 
    uint8     in_length, 
    uint8    *in_buffer )
{
  int i;
  uint32 word[2] = {0};  
  uint8  word_num   = (in_length - 1)/ 4; //获得 Msg 的Word 值
  uint8  rest_bytes = (in_length - 1)% 4; //获得剩余字节的值

  if(word_num < 1)
  {
    for (i = 0; i <= rest_bytes ; i++)
    {
      word[word_num] |=  (uint32)in_buffer[i] << (24-(i<<3));
    }
  }
  else
  {
    for (i = 0; i < 4; i++)
    {
      word[word_num-1] |= (uint32)in_buffer[i] << (24-(i<<3));
    }
    for (i = 0; i <= rest_bytes ; i++)
    {
      word[word_num] |=  (uint32)in_buffer[i+4] << (24-(i<<3));
    }
  }
  canx->MB[msg_num].WORD0 = word[0];
  canx->MB[msg_num].WORD1 = word[1];
}

/*
 * LPLD_CAN_Transmit_Interrupt
 * 该函数用于处理Msg缓冲区发送中断函数
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要处理发送中断的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *    无 
 */
static void LPLD_CAN_Transmit_Interrupt(CAN_Type *canx, uint8 msg_num)
{
  if(LPLD_CAN_Interrupt_GetFlag(canx,msg_num))
  {
   LPLD_CAN_Interrupt_ClearPending(canx,msg_num);
   if(canx == CAN0)
   {
    if( CAN0_ISR[msg_num] != NULL)
    {
      CAN0_ISR[msg_num]();
    }
   }
   else if (canx == CAN1)
   {
    if( CAN1_ISR[msg_num] != NULL)
    {
      CAN1_ISR[msg_num]();
    }
   }
   else
   {
      return;
   }
  }
}

/*
 * LPLD_CAN_Receive_Interrupt
 * 该函数用于处理Msg缓冲区接收中断函数
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0 --CAN0号模块
 *      |__CAN1 --CAN1号模块
 *    msg_num 选择需要处理接收中断的Msg缓冲区
 *      |___ MSG_NUM_0 --Msg缓冲区0
 *      |___ MSG_NUM_1 --Msg缓冲区1
 *      |___ MSG_NUM_2 --Msg缓冲区2
 *      |___ MSG_NUM_3 --Msg缓冲区3
 *      |___ MSG_NUM_4 --Msg缓冲区4
 *      ...... 
 *      |___ MSG_NUM_15 --Msg缓冲区15
 * 输出:
 *    无 
 */
static void LPLD_CAN_Receive_Interrupt(CAN_Type *canx, uint8 msg_num)
{
  if(LPLD_CAN_Interrupt_GetFlag(canx,msg_num))
  {
    //如果定义了中断回掉函数，在此执行
    if(canx == CAN0)
    {
      if( CAN0_ISR[msg_num] != NULL)
      {
          CAN0_ISR[msg_num]();
      }
    }
    else if (canx == CAN1)
    {
      if( CAN1_ISR[msg_num] != NULL)
      {
          CAN1_ISR[msg_num]();
      }
    }
    else
    {
      return;
    }
    LPLD_CAN_Interrupt_ClearPending(canx,msg_num);
  }
}

/*
 * LPLD_CAN_CAN0_Interrupt_Handler
 * CAN0中断处理函数
 * 
 * 参数:
 *    CAN_MSGOBJ_InitTypeDef *CAN_MSGOBJ_Ptr
 *                           轮询检查16个Msg的结构体
 * 输出:
 *    无 
 */
static void LPLD_CAN_CAN0_Interrupt_Handler(CAN_MSGOBJ_InitTypeDef *CAN_MSGOBJ_Ptr)
{
  uint8 msg_obj;
  uint8 direction;
  CAN_Type *canx_ptr;

  for (msg_obj = 0; msg_obj < MSG_MAX_NO; msg_obj++)
  {
    canx_ptr  = (CAN_MSGOBJ_Ptr + msg_obj)->CAN_Canx;
    direction = (CAN_MSGOBJ_Ptr + msg_obj)->CAN_MsgDirection;
    if(direction == CAN_MSGOBJ_DIR_TX)
    {
      LPLD_CAN_Transmit_Interrupt(canx_ptr,msg_obj);
    }
    else if(direction == CAN_MSGOBJ_DIR_RX)
    {
      LPLD_CAN_Receive_Interrupt(canx_ptr,msg_obj);
    }
  }
}

/*
 *  LPLD_CAN_CAN1_Interrupt_Handler
 *  CAN1中断处理函数
 * 
 * 参数:
 *    CAN_MSGOBJ_InitTypeDef *CAN_MSGOBJ_Ptr
 *                           轮询检查16个Msg的结构体
 * 输出:
 *    无 
 */
static void LPLD_CAN_CAN1_Interrupt_Handler(CAN_MSGOBJ_InitTypeDef *CAN_MSGOBJ_Ptr)
{
  uint8 msg_obj;
  uint8 direction;
  CAN_Type *canx_ptr;

  for (msg_obj = 0; msg_obj < MSG_MAX_NO; msg_obj++)
  {
    canx_ptr  = (CAN_MSGOBJ_Ptr + msg_obj)->CAN_Canx;
    direction = (CAN_MSGOBJ_Ptr + msg_obj)->CAN_MsgDirection;

    if(direction == CAN_MSGOBJ_DIR_TX)
    {
      LPLD_CAN_Transmit_Interrupt(canx_ptr,msg_obj);
    }
    else if(direction == CAN_MSGOBJ_DIR_RX)
    {
      LPLD_CAN_Receive_Interrupt(canx_ptr,msg_obj);
    }
  }
}

/*
 * CAN0中断处理函数
 * 与启动文件startup_K60.s中的中断向量表关联
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void CAN0_MESS_IRQHandler(void)
{
#if (UCOS_II > 0u)
  OS_CPU_SR  cpu_sr = 0u;
  OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
  OSIntEnter();
  OS_EXIT_CRITICAL();
#endif
  LPLD_CAN_CAN0_Interrupt_Handler(flexcan_msgobj_param_t);
#if (UCOS_II > 0u)
  OSIntExit();          //告知系统此时即将离开中断服务子函数
#endif
}      
//29:  CAM 0 OR'ed Message buffer (0-15)

void CAN0_BUS_OFF_IRQHandler(void){}   //30:  CAM 0 Bus Off
void CAN0_ERR_IRQHandler(void){}       //31:  CAM 0 Error
void CAN0_TW_IRQHandler(void){}        //32:  CAM 0 Transmit Warning
void CAN0_RW_IRQHandler(void){}        //33:  CAM 0 Receive Warning
void CAN0_WAKE_UP_IRQHandler(void){}   //34:  CAM 0 WakeUp
void CAN0_IMEU_IRQHandler(void){}      //35:  CAM 0 Individual Matching Elements Update (IMEU)
void CAN0_LR_IRQHandler(void){}        //36:  CAM 0 Lost receive

/*
 * CAN1中断处理函数
 * 与启动文件startup_K60.s中的中断向量表关联
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void CAN1_MESS_IRQHandler(void)
{
#if (UCOS_II > 0u)
  OS_CPU_SR  cpu_sr = 0u;
  OS_ENTER_CRITICAL(); //告知系统此时已经进入了中断服务子函数
  OSIntEnter();
  OS_EXIT_CRITICAL();
#endif
  LPLD_CAN_CAN1_Interrupt_Handler(flexcan_msgobj_param_t);
#if (UCOS_II > 0u)
  OSIntExit();          //告知系统此时即将离开中断服务子函数
#endif
}
//37:  CAM 1 OR'ed Message buffer (0-15)

void CAN1_BUS_OFF_IRQHandler(void){}   //38:  CAM 1 Bus Off
void CAN1_ERR_IRQHandler(void){}       //39:  CAM 1 Error
void CAN1_TW_IRQHandler(void){}        //40:  CAM 1 Transmit Warning
void CAN1_RW_IRQHandler(void){}        //41:  CAM 1 Receive Warning
void CAN1_WAKE_UP_IRQHandler(void){}   //42:  CAM 1 WakeUp
void CAN1_IMEU_IRQHandler(void){}      //43:  CAM 1 Individual Matching Elements Update (IMEU)
void CAN1_LR_IRQHandler(void){}        //44:  CAM 1 Lost receive


