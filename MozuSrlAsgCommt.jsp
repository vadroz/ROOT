<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
   String sSku = request.getParameter("Sku");
   String sStr = request.getParameter("Str");
   String sAction = request.getParameter("Action");
   System.out.println("site="+ sSite + "|" + sOrder);
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   SimpleDateFormat smpDtIso = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat smpDtMdy = new SimpleDateFormat("MM/dd/yyyy");
   SimpleDateFormat smpTmIso = new SimpleDateFormat("HH:mm:ss");
   SimpleDateFormat smpTmUsa = new SimpleDateFormat("hh:mm a");

   String sStmt = "";
   sStmt = "select Type, Serial"

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
        + " and opsku=" + sSku
     + " order by PmRecTs desc";

   //System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();
   int j=0;

   String sType = "";
   String sSerial = "";
   String sEmp = "";
   String sCommt = "";
   String sRecUsr = "";
   String sRecDt = "";
   String sRecTm = "";
   String sAsgStr = "";
   String sComa = "";

   while(runsql.readNextRecord())
   {
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
   runsql.disconnect();
   runsql = null;
%> 
<SCRIPT language="JavaScript1.2">

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
var Sku = "<%=sSku%>";
parent.showComments(Site, Order, Sku, Serial, Str, Type,Emp, Commt, RecUsr, RecDt, RecTm)


</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

