//+------------------------------------------------------------------+
//|                                            _hpcs_a1_mt4_i_we.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
input double gi_lmt=0;//Limit in pips

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping


   
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

double limit=10*gi_lmt*Point();
  for(int i=Bars-5;i>0;i--)
  {
      if(Open[i]>Close[i])
      {
          double a=High[i]-Open[i];
          double b=Close[i]-Low[i];
              if(a>limit)
              {
                  string str="high "+(string)i;
                  ObjectCreate(0,str,OBJ_TEXT,0,Time[i],High[i]+(40*Point));
                  ObjectSetText(str,DoubleToStr(a,5),10,NULL,Red); 
                  ObjectSet(str,OBJPROP_ANGLE,90) ; 
              }
          else
            Print((string)i+" a is less than the limit.");
                  
              if(b>limit){
              string str="Low "+(string)i;
              ObjectCreate(0,str,OBJ_TEXT,0,Time[i],Low[i]-(40*Point));
              ObjectSetText(str,DoubleToStr(b,5),10,NULL,Blue); 
               ObjectSet(str,OBJPROP_ANGLE,90);
              }
          else
            Print((string)i+" b is less than the limit.");  
          }
      else
      { 
          double a=High[i]-Close[i];
          double b=Open[i]-Low[i];
              if(a>limit){
              string str="high "+(string)i;
              ObjectCreate(0,str,OBJ_TEXT,0,Time[i],High[i]+(40*Point));
              ObjectSetText(str,DoubleToStr(a,5),10,NULL,Red); 
               ObjectSet(str,OBJPROP_ANGLE,90)  ;
              }
          else
            Print((string)i+" a is less than the limit.");
          
              if(b>limit){
              string str="Low "+(string)i;
              ObjectCreate(0,str,OBJ_TEXT,0,Time[i],Low[i]-(40*Point));
              ObjectSetText(str,DoubleToStr(b,5),10,NULL,Blue); 
               ObjectSet(str,OBJPROP_ANGLE,90) ;
              }
          else
            Print((string)i+" b is less than the limit.");     
      }  
  }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
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
