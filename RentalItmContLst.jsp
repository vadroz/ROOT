<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sInvId = request.getParameter("InvId");

   String sUser = session.getAttribute("USER").toString();

   //System.out.println( sInvId + "|" + sSrlNum + "|"
   //     + sFrDate + "|" + sToDate + "|" + sUser );

   SimpleDateFormat smpDtIso = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat smpDtMdy = new SimpleDateFormat("MM/dd/yyyy");

   String sStmt = "select h.contract, h.cust_id, char(h.picup_dt, usa) as picup_dt" 
     + ", char(h.retrn_dt,usa) as retrn_dt"
     + ", c.First_Nm, c.Middle_Int, c.Last_Nm, c.Home_Phn, c.Cell_Phn, c.EMail"
     + " From Rci.ReContH h "
     + " left join RCI.ReCustH c on h.Cust_Id = c.Cust_Id"
     + " where exists( select 1 from Rci.ReContI i where i.Inv_id = " + sInvId
     + " and h.contract = i.contract)"
     + " and ctsts in ('OPEN', 'READY','PICKEDUP')"         
     + " order by contract";

   System.out.println("\n" + sStmt);
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   String sCont = "";
   String sCust = "";
   String sPickDt = "";
   String sRetDt = "";
   String sFirstNm = "";
   String sMInit = "";
   String sLastNm = "";
   String sHPhone = "";
   String sCPhone = "";
   String sEMail = "";

   String sComa = "";
   int iNumOfCont = 0;
   while(runsql.readNextRecord())
   {
      sCont += sComa + "\"" + runsql.getData("Contract").trim() + "\"";
      sCust += sComa + "\"" + runsql.getData("Cust_id").trim() + "\"";
      sPickDt += sComa + "\"" + runsql.getData("Picup_Dt").trim() + "\"";
      sRetDt += sComa + "\"" + runsql.getData("Retrn_Dt").trim() + "\"";
      sFirstNm += sComa + "\"" + runsql.getData("First_Nm").trim() + "\"";
      sMInit += sComa + "\"" + runsql.getData("Middle_int").trim() + "\"";
      sLastNm += sComa + "\"" + runsql.getData("Last_Nm").trim() + "\"";
      sHPhone += sComa + "\"" + runsql.getData("Home_phn").trim() + "\"";
      sCPhone += sComa + "\"" + runsql.getData("Cell_phn").trim() + "\"";
      sEMail += sComa + "\"" + runsql.getData("EMail").trim() + "\"";
      sComa = ",";
   }
%>


<SCRIPT language="JavaScript1.2">
var InvId = "<%=sInvId%>"
var Cont = [<%=sCont%>];
var Cust = [<%=sCust%>];
var PickDt = [<%=sPickDt%>];
var RetDt = [<%=sRetDt%>];
var FirstNm = [<%=sFirstNm%>];
var MInit = [<%=sMInit%>];
var LastNm = [<%=sLastNm%>];
var HPhone = [<%=sHPhone%>];
var CPhone = [<%=sCPhone%>];
var EMail = [<%=sEMail%>];

parent.showItemCont(InvId, Cont, Cust, PickDt, RetDt, FirstNm, MInit, LastNm, HPhone, CPhone, EMail);

</SCRIPT>

Test











