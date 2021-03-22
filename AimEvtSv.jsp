<%@ page import="aim.AmEvtSv"%>
<%
   String sSelId = request.getParameter("id");
   String sName = request.getParameter("name");
   String sSts = request.getParameter("sts");
   String sBegDt = request.getParameter("begdt");
   String sExpDt = request.getParameter("expdt");
   String sSngScr = request.getParameter("sngscr");
   String [] sScrLvl = request.getParameterValues("scrlvl");
   String sFreq = request.getParameter("freq");
   String sWkday = request.getParameter("wkday");
   String [] sStr = request.getParameterValues("str");
   String sCoupon = request.getParameter("coupon");
   String sGrp = request.getParameter("grp");
   String sType = request.getParameter("type");
   String sComment = request.getParameter("comment");
   String sAction = request.getParameter("action");
   String sEmp = request.getParameter("emp");
   String sEmail = request.getParameter("email");
   String sWaiver = request.getParameter("waiver");
   String sInit = request.getParameter("init");
   String sProdTy = request.getParameter("prodty");
   String sSize = request.getParameter("size");
   String sLvl = request.getParameter("lvl");
   String sScrDt = request.getParameter("scrdt");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null)
   {
      String sUser = session.getAttribute("USER").toString();
      AmEvtSv evtsv = new AmEvtSv();

      String sEvtId = null;
      int iNumOfErr = 0;
      String sError = null;

      if(sAction.equals("ADDEVT") || sAction.equals("UPDEVT"))
      {
         evtsv.saveEvent(sSelId, sName, sBegDt, sExpDt, sSts, sFreq, sWkday, sScrLvl
              , sStr, sAction, sUser);
         if(sAction.equals("ADDEVT"))
         {
           evtsv.rtvNewEvtId();
           sEvtId = evtsv.getEvtId();
         }
         else{ sEvtId = sSelId; }
      }

      // change event status
      if(sAction.equals("CHGEVTSTS"))
      {
         //System.out.println(sSelId + "|" + sSts + "|" + sAction + "|" + sUser);
         evtsv.saveEvtSts(sSelId, sSts, sAction, sUser);
      }

      // change/delete employee subscription on program
      if(sAction.equals("CHGEMPPGM"))
      {
         //System.out.println(sInit);
         evtsv.saveEmpPgm(sEmp, sEmail, sWaiver, sInit, sProdTy, sSize, sAction, sUser);
      }
      if(sAction.equals("DLTEMPPGM"))
      {
         evtsv.saveEmpPgm(sEmp, " ", " ", " ", " ", " ", sAction, sUser);
      }

      if(sAction.equals("ADDEMP") || sAction.equals("DLTEMP"))
      {
         evtsv.saveEvtEmp(sSelId, sEmp, sAction, sUser);
      }

      if(sAction.equals("ADDEMPSCR"))
      {
         evtsv.saveEvtEmpScr(sSelId, sEmp, sLvl, sScrDt, sAction, sUser);
      }

      if(sAction.equals("ADDCPN") || sAction.equals("UPDCPN"))
      {
         evtsv.saveCoupon(sCoupon, sName, sBegDt, sExpDt, sSts, sSngScr, sAction, sUser);
      }

      if(sAction.equals("ADDCMT"))
      {
         evtsv.saveCmtLog(sSelId, sGrp, sType, sComment, sAction, sUser);
      }

      if(sAction.equals("CHKFREEJERSEY"))
      {
         evtsv.saveSndJersey(sEmp, sAction, sUser);
      }


      evtsv.setError();
      iNumOfErr = evtsv.getNumOfErr();
      sError = evtsv.cvtToJavaScriptArray(evtsv.getError());
%>
<html>
<head>

<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>";
var EvtId = "<%=sEvtId%>";
var NumOfErr = eval("<%=iNumOfErr%>");
var Error = [<%=sError%>];

if(NumOfErr > 0){ parent.showError(Error); }
else if(Action == "ADDEVT"){ parent.restartNewEvt(EvtId); }
else { parent. restart(); }

</SCRIPT>

<%}
else{%><SCRIPT language="JavaScript1.2">alert("Please sign on")</SCRIPT><%}%>