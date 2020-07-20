//+------------------------------------------------------------------+
//|                                           _hpcs_a1_mt4_ea_we.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
extern string start="12:00";//Start Time
extern string finish="18:00";//End Time
input double gi_lots=1.0;//Lots
input int gi_mn=1;//Magic Number
input double gi_sl=1;//Stop Loss in pips
input double gi_tp=1;//Take Profit in pips
input int gi_sp=10;//Sleapage

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   
 // Print(iCustom(Symbol(),Period(),"FastSlowMAsCrossOver",30,5,0,0));
   
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
Print(iCustom(Symbol(),Period(),"FastSlowMAsCrossOver",30,5,1,0)==Low[0]);

   double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   Print("Minimum Stop Level=",minstoplevel," points");
   double price=Ask;
   double price1=Bid;
   
   datetime ldt_currtime = TimeLocal();
   datetime ldt_start = StringToTime( TimeToString(ldt_currtime, TIME_DATE ) + " " + start );
   datetime ldt_stop = StringToTime( TimeToString(ldt_currtime, TIME_DATE ) + " " + finish );
   if(ldt_currtime>=ldt_start && ldt_currtime<=ldt_stop ){
   
   if(isnewcandle()){
   
   
   
    if(iCustom(Symbol(),Period(),"FastSlowMAsCrossOver",30,5,0,0)==High[0])
    {
    double LossLevel=Ask-gi_sl*10*Point;
   double ProfitLevel=Ask+gi_tp*10*Point;
   
   if(ProfitLevel>=Bid-(minstoplevel*Point))
     ProfitLevel=Bid-(minstoplevel*Point);
   
   if(LossLevel<=Bid+(minstoplevel*Point))
     LossLevel=Bid+(minstoplevel*Point);
   
       int ticket=OrderSend(Symbol(),OP_BUY,gi_lots,price,gi_sp,LossLevel,ProfitLevel,"My order",gi_mn,0,clrRed);
       
       if(ticket<0)
         {
          Print("OrderSend failed with error #",GetLastError());
         }
       else
          Print("OrderSend placed successfully");
          
    }
    if(iCustom(Symbol(),Period(),"FastSlowMAsCrossOver",30,5,1,0)==Low[0])
    {
     double  LossLevel=Bid+gi_sl*10*Point;
     double  ProfitLevel=Bid-gi_tp*10*Point;
               
                if(ProfitLevel<=Ask+(minstoplevel*Point))
                    ProfitLevel=Ask+(minstoplevel*Point);
                
                if(LossLevel>=Ask-(minstoplevel*Point))
                    LossLevel=Ask-(minstoplevel*Point);
               
               int ticket=OrderSend(Symbol(),OP_SELL,gi_lots,price1,gi_sp,LossLevel,ProfitLevel,"My order",gi_mn,0,clrGreen);
               
               if(ticket<0)
                 {
                  Print("OrderSend failed with error #",GetLastError());
                 }
               else
                  Print("OrderSend placed successfully");
                 
   }
}

   }
  }
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


bool isnewcandle(){
static datetime saved_candle_time;
if(Time[0]==saved_candle_time)
return false;
else
saved_candle_time=Time[0];
return true;




}
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
