//+------------------------------------------------------------------+
//|                                            HPCS_MISSTICK_MT4_INDI_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
int tick_count=0, seccount=0;
static datetime dt;
int i=0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
 dt=Time[0];
EventSetTimer(1);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
tick_count++;
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()

{ 
       if(!NewBar())
       {
          if(tick_count==0)
          {
             //Print("NO TICKS");
             seccount++;
          }
          else
          {   
             //Print("Ticks Found");
             tick_count=0;
          }
       }
       else
       {
          i++;
          Print(seccount," seconds had no ticks."); 
          ObjectCreate(ChartID(),"Obj"+string(i),OBJ_TEXT,0,Time[1],High[1]+(10*Point));
          ObjectSetText("Obj"+(string)i,(string)seccount,10,NULL,White);
          ObjectSet("Obj"+(string)i,OBJPROP_ANGLE,0);
          seccount=0;
       }  
 
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

bool NewBar()
{
if(dt==Time[0])
return false;
else
dt=Time[0];
return true;
}