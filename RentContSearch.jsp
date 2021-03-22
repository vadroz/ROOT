<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
, rciutility.CallAs400SrvPgmSup"%>
<%
   String sSearchCust = request.getParameter("Cust");
   String sAction = request.getParameter("Action");
   
   if (sAction == null || sAction.equals("")){ sAction = "Search_Flex"; }
  
   String sStmt = "select CtCont, CtCust, char(CtPicDt, usa) as CtPickDt" 
     + " , char(CtRtnDt, usa) as CtRtnDt, CtSts, CtStr, CTONLI, char(CtRecDt, usa) as CtRecDt"
     + ", case when CtSts='OPEN' then 1"
     + " when CtSts='READY' then 2"
     + " when CtSts='PICKEDUP' then 3" 
     + " when CtSts='RETURNED' then 4"
     + " when CtSts='CANCELLED' then 5"
     + " else 6 end as StsSort"
     + " from RCI.ReContH h"
     + " where ctcust=" + sSearchCust
     + " and ctrecdt > current date - (365 * 2) days"
   ;    
   
   sStmt += " order by StsSort, CTPICDT desc, CtCont desc";

   System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   ResultSetMetaData rsmd = rs.getMetaData();

   int j=0;
    
   Vector<String> vCont = new Vector<String>();
   Vector<String> vCust = new Vector<String>();
   Vector<String> vPickDt = new Vector<String>();
   Vector<String> vRtnDt = new Vector<String>();
   Vector<String> vSts = new Vector<String>();
   Vector<String> vStr = new Vector<String>();
   Vector<String> vOnline = new Vector<String>();
   Vector<String> vRecDt = new Vector<String>();
   
   
   while(runsql.readNextRecord())
   {
      vCont.add(runsql.getData("ctcont").trim());
      vCust.add(runsql.getData("ctcust").trim());
      vPickDt.add(runsql.getData("CtPickDt").trim());
      vRtnDt.add(runsql.getData("CtRtnDt").trim());
      vSts.add(runsql.getData("CtSts").trim());
      vStr.add(runsql.getData("CtStr").trim());
      vOnline.add(runsql.getData("CtOnli").trim());
      vRecDt.add(runsql.getData("CtRecDt").trim());
   }
   
   CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   
   String sCont = srvpgm.cvtToJavaScriptArray(vCont.toArray(new String[vCont.size()]));
   String sCust = srvpgm.cvtToJavaScriptArray(vCust.toArray(new String[vCust.size()]));
   String sPickDt = srvpgm.cvtToJavaScriptArray(vPickDt.toArray(new String[vPickDt.size()]));
   String sRtnDt = srvpgm.cvtToJavaScriptArray(vRtnDt.toArray(new String[vRtnDt.size()]));
   String sSts = srvpgm.cvtToJavaScriptArray(vSts.toArray(new String[vSts.size()]));
   String sStr = srvpgm.cvtToJavaScriptArray(vStr.toArray(new String[vStr.size()]));
   String sOnline = srvpgm.cvtToJavaScriptArray(vOnline.toArray(new String[vOnline.size()]));
   String sRecDt = srvpgm.cvtToJavaScriptArray(vRecDt.toArray(new String[vRecDt.size()]));   
%>

<SCRIPT language="JavaScript1.2">
var Cont = [<%=sCont%>];
var Cust = [<%=sCust%>];
var PickDt = [<%=sPickDt%>];
var RtnDt = [<%=sRtnDt%>];
var Sts = [<%=sSts%>];
var Str = [<%=sStr%>];
var Online = [<%=sOnline%>];
var RecDt = [<%=sRecDt%>];

parent.showContLst(Cont, Cust, PickDt, RtnDt, Sts, Str, Online, RecDt);

</SCRIPT>










