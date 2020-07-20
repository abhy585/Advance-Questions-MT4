//+------------------------------------------------------------------+
//|                                           _hpcs_a4_mt4_ea_we.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
string str="Cahrt Edit";
string str1="RSI";
   ObjectCreate(ChartID(),str,OBJ_EDIT,0,0,0);
   
   ObjectSetInteger(0,str,OBJPROP_XDISTANCE,10);
   ObjectSetInteger(0,str,OBJPROP_YDISTANCE,25);
   ObjectSetInteger(0,str,OBJPROP_XSIZE,800);
   ObjectSetInteger(0,str,OBJPROP_YSIZE,125);
   ObjectSetInteger(0,str,OBJPROP_READONLY,true);
   ObjectSetString(0,str,OBJPROP_TEXT,"");
   
   
   ObjectCreate(ChartID(),str1,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,str1,OBJPROP_XDISTANCE,12);
   ObjectSetInteger(0,str1,OBJPROP_YDISTANCE,75);
   ObjectSetText(str1,"RSI: ",10,NULL);
      ObjectSetInteger(0,str1,OBJPROP_SELECTABLE,0);

   
   
   ObjectCreate(ChartID(),"str1",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str1",OBJPROP_XDISTANCE,12);
   ObjectSetInteger(0,"str1",OBJPROP_YDISTANCE,105);
   ObjectSetText("str1","Stochastic: ",10,NULL);
     ObjectSetInteger(0,"str1",OBJPROP_SELECTABLE,0);

   
   ObjectCreate(ChartID(),"str2",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str2",OBJPROP_XDISTANCE,200);
   ObjectSetInteger(0,"str2",OBJPROP_YDISTANCE,35);
   ObjectSetText("str2","M1",10,NULL);
      ObjectSetInteger(0,"str2",OBJPROP_SELECTABLE,0);

   
   ObjectCreate(ChartID(),"str3",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str3",OBJPROP_XDISTANCE,400);
   ObjectSetInteger(0,"str3",OBJPROP_YDISTANCE,35);
   ObjectSetText("str3","M5",10,NULL);
      ObjectSetInteger(0,"str3",OBJPROP_SELECTABLE,0);

   
   ObjectCreate(ChartID(),"str4",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str4",OBJPROP_XDISTANCE,600);
   ObjectSetInteger(0,"str4",OBJPROP_YDISTANCE,35);
   ObjectSetText("str4","M15",10,NULL);
      ObjectSetInteger(0,"str4",OBJPROP_SELECTABLE,0);



   ObjectSetInteger(0,str,OBJPROP_FONTSIZE,10);
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
string str5=DoubleToString(iRSI(Symbol(),PERIOD_M1,14,PRICE_CLOSE,0),3);
string str6=DoubleToString(iRSI(Symbol(),PERIOD_M5,14,PRICE_CLOSE,0),3);
string str7=DoubleToString(iRSI(Symbol(),PERIOD_M15,14,PRICE_CLOSE,0),3);

   ObjectCreate(ChartID(),"str5",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str5",OBJPROP_XDISTANCE,200);
   ObjectSetInteger(0,"str5",OBJPROP_YDISTANCE,75);
   ObjectSetText("str5",str5,10,NULL);
      ObjectSetInteger(0,"str5",OBJPROP_SELECTABLE,0);

   
   ObjectCreate(ChartID(),"str6",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str6",OBJPROP_XDISTANCE,400);
   ObjectSetInteger(0,"str6",OBJPROP_YDISTANCE,75);
   ObjectSetText("str6",str6,10,NULL);
      ObjectSetInteger(0,"str6",OBJPROP_SELECTABLE,0);

   
   ObjectCreate(ChartID(),"str7",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str7",OBJPROP_XDISTANCE,600);
   ObjectSetInteger(0,"str7",OBJPROP_YDISTANCE,75);
   ObjectSetText("str7",str7,10,NULL);
      ObjectSetInteger(0,"str7",OBJPROP_SELECTABLE,0);

   
   string str8=DoubleToString(iStochastic(Symbol(),PERIOD_M1,5,3,3,MODE_SMA,0,MODE_MAIN,0),3);
   string str9=DoubleToString(iStochastic(Symbol(),PERIOD_M5,5,3,3,MODE_SMA,0,MODE_MAIN,0),3);
   string str0=DoubleToString(iStochastic(Symbol(),PERIOD_M15,5,3,3,MODE_SMA,0,MODE_MAIN,0),3);
   
   
   ObjectCreate(ChartID(),"str8",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str8",OBJPROP_XDISTANCE,200);
   ObjectSetInteger(0,"str8",OBJPROP_YDISTANCE,105);
   ObjectSetText("str8",str8,10,NULL);
      ObjectSetInteger(0,"str8",OBJPROP_SELECTABLE,0);

   
   ObjectCreate(ChartID(),"str9",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str9",OBJPROP_XDISTANCE,400);
   ObjectSetInteger(0,"str9",OBJPROP_YDISTANCE,105);
   ObjectSetText("str9",str9,10,NULL);
      ObjectSetInteger(0,"str9",OBJPROP_SELECTABLE,0);

   
   ObjectCreate(ChartID(),"str0",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"str0",OBJPROP_XDISTANCE,600);
   ObjectSetInteger(0,"str0",OBJPROP_YDISTANCE,105);
   ObjectSetText("str0",str0,10,NULL);
      ObjectSetInteger(0,"str0",OBJPROP_SELECTABLE,0);

   
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
