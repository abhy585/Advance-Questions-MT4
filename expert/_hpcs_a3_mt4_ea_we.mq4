//+------------------------------------------------------------------+
//|                                           _hpcs_a3_mt4_ea_we.mq4 |
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
extern double gd_nol=0.01;//No.of Lot
extern int gd_sl=50;//Enter SL
extern int gd_tp=50;//Enter TP
extern int gi_mn=0;//Enter Magic Number Buy
extern int gi_slippage=10;//Enter Slippage
extern int gi_ts=5;//Enter Trailing Stop
int gi_ticketb;
int gi_tickets;
datetime oldtime;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   datetime ldt_currtime = TimeLocal();
   datetime ldt_start = StringToTime( TimeToString(ldt_currtime, TIME_DATE ) + " " + start );
   datetime ldt_stop = StringToTime( TimeToString(ldt_currtime, TIME_DATE ) + " " + finish );
   if(ldt_currtime>=ldt_start && ldt_currtime<=ldt_stop)
       {
           double ld_buy=iCustom(Symbol(),0,"FastSlowRVIsCrossOver",10,25,0,0);
           double ld_sell=iCustom(Symbol(),0,"FastSlowRVIsCrossOver",10,25,1,0);
           if(ld_buy!= EMPTY_VALUE && ld_sell==EMPTY_VALUE && oldtime!=Time[0])
              {
               double ld_slb=NormalizeDouble(Bid-(gd_sl*Point),Digits);
               double ld_tpb=NormalizeDouble(Bid+(gd_tp*Point),Digits);
               if(ld_slb<Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point){}
               else
               {
                ld_slb=Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point;
               }
               gi_ticketb=OrderSend(Symbol(),OP_BUY,gd_nol,Ask,gi_slippage,ld_slb,ld_tpb,"Demo Open Buy",gi_mn,0,clrRed);
               if(gi_ticketb<0)
                 {
                  Print("OrderSend failed with error #",GetLastError());
                 }
               else
                  {
                   oldtime=Time[0];
                  }
              }
        
           if(ld_sell!= EMPTY_VALUE && ld_buy== EMPTY_VALUE && oldtime!=Time[0])
              {
               double ld_sls=NormalizeDouble(Ask+(gd_sl*Point),Digits);
               double ld_tps=NormalizeDouble(Ask-(gd_tp*Point),Digits);
               if(ld_sls>Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point){}
               else
               {
                ld_sls=Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point;
               }
               gi_tickets=OrderSend(Symbol(),OP_SELL,gd_nol,Bid,gi_slippage,ld_sls,ld_tps,"Demo Open Sell",gi_mn,0,clrGreen);
               if(gi_tickets<0)
                 {
                  Print("OrderSend failed with error #",GetLastError());
                 }
               else
                  {
                    oldtime=Time[0];
                  }
               }
       }
          
          //trailing stop
    for (int pos=0;pos<OrdersTotal();pos++)
    {
        if(OrderSelect(pos, SELECT_BY_POS))
             { 
                if (OrderType()==OP_SELL)
                {
                    if (OrderOpenPrice()-Ask>gi_ts*Point && OrderStopLoss()>Ask+gi_ts*Point) 
                    {
                        if(OrderModify(OrderTicket(),OrderOpenPrice(),Ask+(gi_ts*Point),OrderTakeProfit(),0,clrAqua))
                            Print("Modify Sell");
                    }
                } 
                if (OrderType()==OP_BUY) 
                {
                    if ( Bid-OrderOpenPrice()>gi_ts*Point && OrderStopLoss()<Bid-gi_ts*Point) 
                    { 
                        if(OrderModify(OrderTicket(), OrderOpenPrice( ) ,Bid-(gi_ts*Point), OrderTakeProfit() ,0,clrAqua))
                            Print("Modify Buy");
                    }
                } 
            }
    }
}
//+------------------------------------------------------------------+