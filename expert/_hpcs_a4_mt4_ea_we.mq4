//+------------------------------------------------------------------+
//|                                           _hpcs_a4_mt4_ea_we.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
input double gi_lots=0.01;//Lots
input int gi_mn=1;//Magic Number
input double gi_sl=1;//Stop Loss in pips
input double gi_tp=1;//Take Profit in pips
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
bool isnewcandle(){
static datetime saved_candle_time;
if(Time[0]==saved_candle_time)
return false;
else
saved_candle_time=Time[0];
return true;
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   double price=Ask;
   double price1=Bid;
   
   
   
     double  sLossLevel=Bid+gi_sl*10*Point;
     double  sProfitLevel=Bid-gi_tp*10*Point;
     
               
               if(sProfitLevel<=Ask+(minstoplevel*Point))
                    sProfitLevel=Ask+(minstoplevel*Point);
                
               if(sLossLevel>=Ask-(minstoplevel*Point))
                    sLossLevel=Ask-(minstoplevel*Point);
                int sticket;
                
                
              if(iCustom(Symbol(),Period(),"WPRTrend",0,0)==High[0])
              {
        
               if(isnewcandle())
                 {
                      sticket=OrderSend(Symbol(),OP_SELL,gi_lots,price1,10,0,0,"My order",gi_mn,0,clrGreen);
                   
                   if(sticket<0)
                     {
                      Print("OrderSend failed with error #",GetLastError());
                     }
                   else
                      Print("OrderSend placed successfully");
                 }
              }   
             
    double bLossLevel=Ask-gi_sl*10*Point;
    double bProfitLevel=Ask+gi_tp*10*Point;
 
       if(bProfitLevel>=Bid-(minstoplevel*Point))
         bProfitLevel=Bid-(minstoplevel*Point);
       
       if(bLossLevel<=Bid+(minstoplevel*Point))
         bLossLevel=Bid+(minstoplevel*Point);
       
       int bticket;
       
    if(iCustom(Symbol(),Period(),"WPRTrend",1,0)==Low[0])
    {
        
       
       if(isnewcandle())
       
       {
            bticket=OrderSend(Symbol(),OP_BUY,gi_lots,price,10,0,0,"My order",gi_mn,0,clrRed);
           
           if(bticket<0)
             {
              Print("OrderSend failed with error #",GetLastError());
             }
           else
              Print("OrderSend placed successfully");
       }  
     }     
     
     
          for(int i=OrdersTotal();i>=0;i--)
          {
              if(OrderSelect(i,SELECT_BY_POS))
              {
                  if(OrderType()==OP_BUY)
                  {
                     // OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),10,clrGreen);
                      Print("Hello");
                      if(Bid>OrderOpenPrice()-bLossLevel)
                      {
                        OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),10,clrGreen);
                        Print("101");
                      }
                      if(Bid<OrderOpenPrice()+bProfitLevel)
                      {
                        OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),10,clrGreen);
                        Print("102");
                      }
                   }
                   
                   if(OrderType()==OP_SELL)
                   {
                      // OrderClose(OrderTicket(),OrderLots(),OrderOpenPrice(),10,clrGreen);
                       Print("hello");
                             if(Ask<OrderClosePrice()+sLossLevel)
                             {
                                Print("101");
                                if(!OrderClose(OrderTicket(),OrderLots(),OrderOpenPrice(),10,clrGreen))
                                   Print("102", GetLastError());
                             }
                             if(Ask>OrderClosePrice()-sProfitLevel)
                             { 
                                Print("103");
                                if(!OrderClose(OrderTicket(),OrderLots(),OrderOpenPrice(),10,clrGreen))
                                  Print("104", GetLastError());
                             }
                   }
              }
          }
      
    
  }
//---
   
  
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
