<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
   String sSku = request.getParameter("Sku");
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

   String sStmt = "";
   if(!sStr.equals("0"))
   {
     sStmt = "select Type, Emp, Log, Rec_Us, Rec_Dt, Rec_Tm, OaStr"
     + " from RCI.EcSpLog"
     + " inner join RCI.EcOrPst on oaid=PlPickId"
     + " where "
        + " oasite='" + sSite + "'"
        + " and oaord=" + sOrder
        + " and oasku=" + sSku
        + " and oaStr=" + sStr
     + " order by PlPickId, PlNoteId desc";
   }
   else
   {
     sStmt = "select Type, Emp, Log, Rec_Us, Rec_Dt, Rec_Tm"
     + ", case when OaStr is not null then OaStr else 0 end as OaStr"
     + " from RCI.EcSpLog"
     + " left join RCI.EcOrPst on oaid=PlPickId"
     + " left join RCI.EcOrPas on opid=PlPickId"
     + " where "
        + " oasite='" + sSite + "'"
        + " and oaord=" + sOrder
        + " and oasku=" + sSku
        + " or "
        + " opsite='" + sSite + "'"
        + " and opord=" + sOrder
        + " and opsku=" + sSku
     + " order by Rec_Dt desc, Rec_Tm desc";
   }
   //System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();
   int j=0;

   String sType = "";
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
      sEmp += sComa + "\"" + runsql.getData("EMP").trim() + "\"";
      sCommt += sComa + "\"" + runsql.getData("LOG").trim().replaceAll("\"", "'") + "\"";
      sRecUsr += sComa + "\"" + runsql.getData("Rec_Us").trim() + "\"";
      sRecDt += sComa + "\"" + smpDtMdy.format(smpDtIso.parse(runsql.getData("Rec_Dt"))) + "\"";
      sRecTm += sComa + "\"" + smpTmUsa.format(smpTmIso.parse(runsql.getData("Rec_Tm"))) + "\"";
      sAsgStr += sComa + "\"" + runsql.getData("OaStr").trim() + "\"";

      sComa= ",";
   }
   runsql.disconnect();
   runsql = null;
%>
<SCRIPT language="JavaScript1.2">

var Type = [<%=sType%>];
var Emp = [<%=sEmp%>];
var Commt = [<%=sCommt%>];
var RecUsr = [<%=sRecUsr%>];
var RecDt = [<%=sRecDt%>];
var RecTm = [<%=sRecTm%>];
var Str = [<%=sAsgStr%>];
var Site = "<%=sSite%>";
var Order = "<%=sOrder%>";
var Sku = "<%=sSku%>";
parent.showComments(Site, Order, Sku, Str, Type,Emp, Commt, RecUsr, RecDt, RecTm)


</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

