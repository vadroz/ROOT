<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sInvId = request.getParameter("InvId");
   String sAction = request.getParameter("Action");

   SimpleDateFormat smpDtIso = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat smpDtMdy = new SimpleDateFormat("MM/dd/yyyy");
   SimpleDateFormat smpTmIso = new SimpleDateFormat("HH:mm:ss");
   SimpleDateFormat smpTmUsa = new SimpleDateFormat("hh:mm a");

   String sStmt = "select *"
     + " from RCI.ReCommt"
     + " where FIRST_TY = 'INVENTORY' and First_Id = " + sInvId
     + " order by COMM_ID";

   //System.out.println("\n" + sStmt);
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();
   int j=0;

   String sCommId = "";
   String sFirstTy = "";
   String sFirstId = "";
   String sSecondTy = "";
   String sSecondId = "";
   String sThirdTy = "";
   String sThirdId = "";
   String sLine = "";
   String sSubType = "";
   String sCommt = "";
   String sRecUsr = "";
   String sRecDt = "";
   String sRecTm = "";
   String sComa = "";

   while(runsql.readNextRecord())
   {
      sCommId += sComa + "\"" + runsql.getData("COMM_ID").trim() + "\"";
      sFirstTy += sComa + "\"" + runsql.getData("First_Ty").trim() + "\"";
      sFirstId += sComa + "\"" + runsql.getData("First_Id").trim() + "\"";
      sSecondTy += sComa + "\"" + runsql.getData("Second_Ty").trim() + "\"";
      sSecondId += sComa + "\"" + runsql.getData("Second_Id").trim() + "\"";
      sThirdTy += sComa + "\"" + runsql.getData("Third_Ty").trim() + "\"";
      sThirdId += sComa + "\"" + runsql.getData("Third_Id").trim() + "\"";
      sLine += sComa + "\"" + runsql.getData("Line").trim() + "\"";
      sSubType += sComa + "\"" + runsql.getData("Subtype").trim() + "\"";
      sCommt += sComa + "\"" + runsql.getData("Comment").trim() + "\"";
      sRecUsr += sComa + "\"" + runsql.getData("Rec_Us").trim() + "\"";
      sRecDt += sComa + "\"" + smpDtMdy.format(smpDtIso.parse(runsql.getData("Rec_Dt"))) + "\"";
      sRecTm += sComa + "\"" + smpTmUsa.format(smpTmIso.parse(runsql.getData("Rec_Tm"))) + "\"";

      sComa= ",";
   }
%>

<SCRIPT language="JavaScript1.2">
var CommId = [<%=sCommId%>];
var FirstTy = [<%=sFirstTy%>];
var FirstId = [<%=sFirstId%>];
var SecondTy = [<%=sSecondTy%>];
var SecondId = [<%=sSecondId%>];
var ThirdTy = [<%=sThirdTy%>];
var ThirdId = [<%=sThirdId%>];
var Line = [<%=sLine%>];
var SubType = [<%=sSubType%>];
var Commt = [<%=sCommt%>];
var RecUsr = [<%=sRecUsr%>];
var RecDt = [<%=sRecDt%>];
var RecTm = [<%=sRecTm%>];

parent.showComments(CommId, FirstTy, FirstId, SecondTy, SecondId, ThirdTy, ThirdId
      , Line, SubType, Commt, RecUsr, RecDt, RecTm)

</SCRIPT>













