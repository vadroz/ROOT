<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
   String sSelSku = request.getParameter("Sku");
   String sStr = request.getParameter("Str");
   String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   SimpleDateFormat smpDtIso = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat smpDtMdy = new SimpleDateFormat("MM/dd/yyyy");
   SimpleDateFormat smpTmIso = new SimpleDateFormat("HH:mm:ss");
   SimpleDateFormat smpTmUsa = new SimpleDateFormat("hh:mm a");
   
   RunSQLStmt runsql = new RunSQLStmt();
   ResultSet rs = null;
		   
   String sStmt = "";
   String sGrpCmt = "";
   String sType = "";
   String sSerial = "";
   String sEmp = "";
   String sCommt = "";
   String sRecUsr = "";
   String sRecDt = "";
   String sRecTm = "";
   String sAsgStr = "";
   String sComa = "";
   String sSku = "";
   
   if(sAction.equals("GETSTRCMMT"))
   {
	   sStmt = "select '1' as grpcmt,Type, RsSn"
    	 + ", 0 Emp"
     	+ ", Log, PmRecUs, PmRecDt, PmRecTm"
     	+ ", PmStr as Str"
     	+ " from rci.EcSrlRt"
     	+ " inner join RCI.MoSpLoj on pmpickid=rspickid"
     	+ " where "
	       	+ " rssite='" + sSite + "'"
        	+ " and rsord=" + sOrder
        	+ " and rsSku=" + sSelSku
        	+ " and (RSRECDT < PmRecDt or RSRECDT = PmRecDt and RSRECtm <= PmRectm)"        	
     	+ " order by PmRecTs desc";

	   System.out.println(sStmt);

   
   	runsql.setPrepStmt(sStmt);   
   	rs = runsql.runQuery();
   	int j=0;

   
   	while(runsql.readNextRecord())
   	{
	  sGrpCmt += sComa + "\"" + runsql.getData("grpcmt").trim() + "\"";
      sType += sComa + "\"" + runsql.getData("TYPE").trim() + "\"";
      sSerial += sComa + "\"" + runsql.getData("RsSn").trim() + "\"";
      String emp = runsql.getData("EMP");
      if(emp==null){emp = "";}
      sEmp += sComa + "\"" + emp + "\"";
      sCommt += sComa + "\"" + runsql.getData("LOG").trim().replaceAll("\"", "'") + "\"";
      sRecUsr += sComa + "\"" + runsql.getData("PmRecUs").trim() + "\"";
      sRecDt += sComa + "\"" + smpDtMdy.format(smpDtIso.parse(runsql.getData("PmRecDt"))) + "\"";
      sRecTm += sComa + "\"" + smpTmUsa.format(smpTmIso.parse(runsql.getData("PmRecTm"))) + "\"";
      sAsgStr += sComa + "\"" + runsql.getData("Str").trim() + "\"";

      sComa= ",";
   }
   
   sStmt = "select '2' as grpcmt, Type, Serial"

     + ", case when (select PnEmp from rci.MoSpStn where PnPickId=opid and pnsts=type"
     + " order by pnrecdt desc, pnrectm desc fetch first 1 row only) is null then 0"
     + " else (select PnEmp from rci.MoSpStn where PnPickId=opid and pnsts=type"
     + " order by pnrecdt desc, pnrectm desc fetch first 1 row only) end as Emp"

     + ", Log, Rec_Us, Rec_Dt, Rec_Tm"

     + ", PmStr as Str"

     + " from RCI.MoSpLoj"
     + " inner join RCI.MoOrPas on opid=PmPickId"
     + " where "
        + " opsite='" + sSite + "'"
        + " and opord=" + sOrder
        + " and opsku=" + sSelSku
        + " and not exists(select 1 from rci.ecsrlrt where opsku=rsSku and rspickid=pmpickid"
        + " and (RSRECDT < PmRecDt  or RSRECDT = PmRecDt and RSRECtm <= PmRectm))"
     + " order by PmRecTs desc";

   	//System.out.println(sStmt);

   	runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sStmt);
   	rs = runsql.runQuery();
   
   	while(runsql.readNextRecord())
   	{
	  sGrpCmt += sComa + "\"" + runsql.getData("grpcmt").trim() + "\"";
	  sType += sComa + "\"" + runsql.getData("TYPE").trim() + "\"";
      sSerial += sComa + "\"" + runsql.getData("Serial").trim() + "\"";
      String emp = runsql.getData("EMP");
      if(emp==null){emp = "";}
      sEmp += sComa + "\"" + emp + "\"";
      sCommt += sComa + "\"" + runsql.getData("LOG").trim().replaceAll("\"", "'") + "\"";
      sRecUsr += sComa + "\"" + runsql.getData("Rec_Us").trim() + "\"";
      sRecDt += sComa + "\"" + smpDtMdy.format(smpDtIso.parse(runsql.getData("Rec_Dt"))) + "\"";
      	sRecTm += sComa + "\"" + smpTmUsa.format(smpTmIso.parse(runsql.getData("Rec_Tm"))) + "\"";
      	sAsgStr += sComa + "\"" + runsql.getData("Str").trim() + "\"";

    	sComa= ",";
   	}
   }
   // order level comments only
   else if(sAction.equals("GETORDCMMT"))
   {
	   sStmt = "select '0' as grpcmt, Type, Serial"

     	+ ", case when (select PnEmp from rci.MoSpStn where PnPickId=opid and pnsts=type"
     	+ " order by pnrecdt desc, pnrectm desc fetch first 1 row only) is null then 0"
     	+ " else (select PnEmp from rci.MoSpStn where PnPickId=opid and pnsts=type"
     	+ " order by pnrecdt desc, pnrectm desc fetch first 1 row only) end as Emp"
     	+ ", Log, Rec_Us, Rec_Dt, Rec_Tm"
     	+ ", PmStr as Str, opsku"
     	+ " from RCI.MoSpLoj"
     	+ " inner join RCI.MoOrPas on opid=PmPickId"
     	+ " where "
        	+ " opsite='" + sSite + "'"
        	+ " and opord=" + sOrder        	
        	+ " and Type in ('Comment', 'ErrCode')"        	
     	+ " order by PmRecTs desc";

   		System.out.println(sStmt);

   		runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sStmt);
   		rs = runsql.runQuery();
   
   	while(runsql.readNextRecord())
   	{
	  sGrpCmt += sComa + "\"" + runsql.getData("grpcmt").trim() + "\"";
	  sType += sComa + "\"" + runsql.getData("TYPE").trim() + "\"";
      sSerial += sComa + "\"" + runsql.getData("Serial").trim() + "\"";
      String emp = runsql.getData("EMP");
      if(emp==null){emp = "";}
      sEmp += sComa + "\"" + emp + "\"";
      sCommt += sComa + "\"" + runsql.getData("LOG").trim().replaceAll("\"", "'") + "\"";
      sRecUsr += sComa + "\"" + runsql.getData("Rec_Us").trim() + "\"";
      sRecDt += sComa + "\"" + smpDtMdy.format(smpDtIso.parse(runsql.getData("Rec_Dt"))) + "\"";
      sRecTm += sComa + "\"" + smpTmUsa.format(smpTmIso.parse(runsql.getData("Rec_Tm"))) + "\"";
      sAsgStr += sComa + "\"" + runsql.getData("Str").trim() + "\"";
      sSku += sComa + "\"" + runsql.getData("opsku").trim() + "\"";
      
      sComa= ",";
   	}
   }
   runsql.disconnect();   
   runsql.disconnect();
   
   runsql = null;
%>
<SCRIPT language="JavaScript1.2">

var Grp = [<%=sGrpCmt%>];
var Type = [<%=sType%>];
var Emp = [<%=sEmp%>];
var Serial = [<%=sSerial%>];
var Commt = [<%=sCommt%>];
var RecUsr = [<%=sRecUsr%>];
var RecDt = [<%=sRecDt%>];
var RecTm = [<%=sRecTm%>];
var Str = [<%=sAsgStr%>];
var Site = "<%=sSite%>";
var Order = "<%=sOrder%>";
var SelSku = "<%=sSelSku%>";
var Sku = [<%=sSku%>];
var Action = "<%=sAction%>";

if(Action == "GETSTRCMMT")
{
	parent.showSkuComments(Site, Order, SelSku, Serial, Str, Type,Emp, Commt, RecUsr, RecDt, RecTm, Grp)
} 
if(Action == "GETORDCMMT")
{
	parent.showOrdComments(Site, Order, Serial, Str, Type,Emp, Commt, RecUsr, RecDt, RecTm, Grp, Sku)
}

</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

