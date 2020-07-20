//+------------------------------------------------------------------+
//|                                        HPCS_INDIADVC3_MT4_WE.mq4 |
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
   ObjectCreate(0,"Button",OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,"Button",OBJPROP_XDISTANCE,0);
   ObjectSetInteger(0,"Button",OBJPROP_YDISTANCE,25);
   ObjectSetInteger(0,"Button",OBJPROP_XSIZE,125);
   ObjectSetInteger(0,"Button",OBJPROP_YSIZE,50);
   ObjectSetString(0,"Button",OBJPROP_TEXT,"SCREENSHOT");
   ObjectSetInteger(0,"Button",OBJPROP_FONTSIZE,10);
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
   
//--- return value of prev_calculated for next call
   return(rates_total);
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
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      Print("The mouse has been clicked on the object with name '"+sparam+"'");
    
     string ls_name=StringConcatenate("Pic ",TimeToString(TimeLocal(),TIME_SECONDS));
     StringReplace(ls_name," ","-");
     StringReplace(ls_name,".","-");
     StringReplace(ls_name,":","-");
     if(ChartScreenShot(0,ls_name+".gif",800,600,ALIGN_LEFT))
     Print("Screenshot ",ls_name," saved in the files...");
     }
  }
//+------------------------------------------------------------------+