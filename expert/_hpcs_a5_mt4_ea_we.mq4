//+------------------------------------------------------------------+
//|                                           _hpcs_a5_mt4_ea_we.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property  show_inputs
input double gd_lotsb=0.1;//Buy Lots
input double gd_lotss=0.1;//Sell Lots
input int gi_tp=50;//Take Profit in Points
input int gi_sl=50;//Stop Loss in Points
input int gi_magno=0;//Magic Number
input double  level=0.05;//Partial Close in Lots
int ticketb=0;
int tickets=0;
double priceb=0,prices=0;
datetime dtb;
datetime dts;
double lotsb=gd_lotsb,lotss=gd_lotss;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


    if(iCustom(Symbol(),Period(),"CloseBBCrossOver",0,0)==High[0] && ticketb==0)
    {
       
       priceb=Ask;
       double stoploss=NormalizeDouble(priceb-gi_sl*Point,Digits);
       double takeprofit=NormalizeDouble(priceb+gi_tp*Point,Digits);
       if(stoploss<Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point)
       {}
       else
       {stoploss=Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point;}
       
       ticketb=OrderSend(Symbol(),OP_BUY,lotsb,priceb,10,0,0,"My order",0,0,clrRed);
       if(ticketb<0)
         {
          Print("OrderSend failed with error #",GetLastError());
         }
       else
          Print("OrderSend placed successfully");
          if(OrderSelect(ticketb,SELECT_BY_TICKET))
          dtb=OrderOpenTime();
      
       
    }


    if(iCustom(Symbol(),Period(),"CloseBBCrossOver",1,0)==Low[0] && tickets==0)
    {
       prices=Bid;
       double stoploss=NormalizeDouble(prices+gi_sl*Point,Digits);
       double takeprofit=NormalizeDouble(prices-gi_tp*Point,Digits);
       if(stoploss>Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point)
       {}
       else
          stoploss=Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point;
    
       
       tickets=OrderSend(Symbol(),OP_SELL,lotsb,prices,10,0,0,"My order",0,0,clrGreen);
       if(tickets<0)
         {
          Print("OrderSend failed with error #",GetLastError());
         }
       else
          Print("OrderSend placed successfully");
       if(OrderSelect(tickets,SELECT_BY_TICKET))
       dts=OrderOpenTime();
    }
  

   if(TimeCurrent()-dtb>=60||TimeCurrent()-dts>=60)
   {  
      if(ticketb!=0)
         if(OrderSelect(ticketb,SELECT_BY_TICKET,MODE_TRADES))
         {  
            Print(OrderLots(),"....Buy Lots");
            if(OrderLots()>level)
            {  if(OrderClose(OrderTicket(),level,OrderClosePrice(),10,clrAqua))
               {
                  Print("Buy Order Partially Closed first time");
                  
                  
                   int magic=OrderMagicNumber();
                   
                   for(int i=0;i<=OrdersTotal();i++)
                     if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
                        if(OrderType()==OP_BUY && OrderMagicNumber()==magic)
                            ticketb=OrderTicket();
               }
            }
            
            if(OrderLots()==level)
            {
               if(OrderClose(OrderTicket(),level,OrderClosePrice(),10,clrAqua))
                  Print("Buy Order Partially Closed second time");
               ticketb=0;
            }
          }
               
   if(tickets!=0)
      if(OrderSelect(tickets,SELECT_BY_TICKET,MODE_TRADES))
      {
         Print(OrderLots(),"....Sell Lots");
         if(OrderLots()>level)
         {
            if(OrderClose(OrderTicket(),level,OrderClosePrice(),10,clrAqua))
            {              
               Print("Sell Order Partially Closed first time");               
               int magic=OrderMagicNumber();               
               for(int i=0;i<=OrdersTotal();i++)
               if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
               if(OrderType()==OP_SELL && OrderMagicNumber()==magic)
               tickets=OrderTicket();
            }
         }
         if(OrderLots()==level)
         {
            if(OrderClose(OrderTicket(),level,OrderClosePrice(),10,clrAqua))
            {
               Print("Sell Order Partially Closed second time");
            }
            tickets=0;
         }
         }
  dts=TimeCurrent();
  dtb=TimeCurrent();
  }
}