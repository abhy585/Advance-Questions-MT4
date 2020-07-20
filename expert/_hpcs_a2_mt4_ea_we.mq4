//+------------------------------------------------------------------+
//|                                           _hpcs_a2_mt4_ea_we.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property  show_inputs
extern string start="12:00";//Start Time
extern string finish="18:00";//End Time
extern double gd_lotsb=0.01;// Lots for Buy
extern double gd_lotss=0.01;// Lots for Sell
input int gi_tp=50;//Take Profit
input int gi_sl=50;//Stop Loss
input int gi_magno=0;//Magic Number
input int trailstop=10;//Trailing Stop
extern int levelb=4;//Martingale Level Buy
extern int levels=4;//Martingale Level Sell
input int mul=2;//Martingale Multiplier
int ticketb=0;
int tickets=0;
double priceb=0,prices=0;
int OnInit()
  {
   EventSetTimer(60);
   
   return(INIT_SUCCEEDED);
  }
void OnTick()
  {
   datetime ldt_currtime = TimeLocal();
   datetime ldt_start = StringToTime( TimeToString(ldt_currtime, TIME_DATE ) + " " + start );
   datetime ldt_stop = StringToTime( TimeToString(ldt_currtime, TIME_DATE ) + " " + finish );
   if(ldt_currtime>=ldt_start && ldt_currtime<=ldt_stop ){
   if(levelb>0)
       {
                if(iCustom(Symbol(),Period(),"PosNegDIsCrossOver",0,0)==High[0] && ticketb==0)
                {
               
                   priceb=Ask;
                   double stoploss=NormalizeDouble(priceb-gi_sl*Point,Digits);
                   double takeprofit=NormalizeDouble(priceb+gi_tp*Point,Digits);
                   if(stoploss<Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point){}
                   else
                    {
                        stoploss=Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point;
                    }
                   
                   ticketb=OrderSend(Symbol(),OP_BUY,gd_lotsb,priceb,10,0,0,"My order",0,0,clrRed);
                   if(ticketb<0)
                     {
                      Print("OrderSend failed with error #",GetLastError());
                     }
                   else
                      Print("OrderSend placed successfully");               
                }
        }
    if(levels>0)
    {
        if(iCustom(Symbol(),Period(),"PosNegDIsCrossOver",1,0)==Low[0] && tickets==0)
        {
           prices=Bid;
           double stoploss=NormalizeDouble(prices+gi_sl*Point,Digits);
           double takeprofit=NormalizeDouble(prices-gi_tp*Point,Digits);
           if(stoploss>Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point){}
           else
           {
            stoploss=Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point; 
           }
        
           
           tickets=OrderSend(Symbol(),OP_SELL,gd_lotss,prices,10,0,0,"My order",0,0,clrGreen);
           if(tickets<0)
             {
              Print("OrderSend failed with error #",GetLastError());
             }
           else
              Print("OrderSend placed successfully");
              
         }
     } 
     }
  
  if(ticketb!=0)
     {
       if(OrderSelect(ticketb,SELECT_BY_TICKET,MODE_TRADES))
          if(Bid>OrderOpenPrice()+gi_tp*Point)
             if(OrderClose(OrderTicket(),gd_lotsb,OrderClosePrice(),10,clrAqua))
                {
                    Print("Closed with TP");
                    ticketb=0;
                    levelb=0;
                }
       
       
       if(OrderSelect(ticketb,SELECT_BY_TICKET,MODE_TRADES))
          if(Bid<OrderOpenPrice()-gi_sl*Point)
             if(OrderClose(OrderTicket(),gd_lotsb,OrderClosePrice(),10,clrAqua))
               { 
                   Print("Closed with SL");
                   ticketb=0;
                   levelb--;
                   gd_lotsb=gd_lotsb*mul;
               }
     }
 
     if(tickets!=0)
     {
       if(OrderSelect(tickets,SELECT_BY_TICKET,MODE_TRADES))
          if(Ask>=OrderOpenPrice()+gi_sl*Point)
             if(OrderClose(OrderTicket(),gd_lotss,OrderClosePrice(),10,clrAqua))
                {
                    Print("Closed with SL");
                    tickets=0;
                    levels--;
                    gd_lotss*=mul;
                }
                
       if(OrderSelect(tickets,SELECT_BY_TICKET,MODE_TRADES))
          if(Ask<=OrderOpenPrice()-gi_tp*Point)
             if(OrderClose(OrderTicket(),gd_lotss,OrderClosePrice(),10,clrAqua))
                {
                    Print("Closed with TP");
                    tickets=0;
                    levels=0;
                }
     }

}