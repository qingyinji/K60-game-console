#ifndef  _SAOLEI_H  //必须确保header guard宏名永不重名
#define  _SAOLEI_H
#define rows 8
#define cols 8
#define Count 10
void saolei(void);
uint16 menu();//一开始的界面
void display(unsigned char show[rows][cols]);
uint16 Game(unsigned char mine[rows][cols],unsigned char show[rows][cols]);//游戏
void set_mine(unsigned char mine[rows][cols]);//设置雷的位置
uint16 Sweep(unsigned char mine[rows][cols], unsigned char show[rows][cols]);//开始扫雷
uint16 get_num(unsigned char mine[rows][cols], uint16 x, uint16 y);//计算雷的个数
void shezhi(void);
void kongzhi(void);
//void duqu(void);
void portb_isr(void);
void time1(void);
void delay1(uint16 ms);
void surrond(uint16 a, uint16 b);
void panduan(uint16 a, uint16 b);
#endif