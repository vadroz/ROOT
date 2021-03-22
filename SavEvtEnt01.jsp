<%@ page import="payrollreports.SavEvtEnt, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sEvent = request.getParameter("EVENT");
   String sAction = request.getParameter("ACTION");

   String sFrom = request.getParameter("FROM");
   String sPosition = request.getParameter("POS");
   String sDoc = request.getParameter("DOC");
   String sSchTyp = request.getParameter("SCHTYP");
   String sShwGoal = request.getParameter("SHWGOAL");

   String sUserId = null;
   String sWeekDay = request.getParameter("WKDATE");
   String sDayTime = request.getParameter("DAYTIME");
   String sEvtInfo = request.getParameter("EVTINF");

   //-------------- Security ---------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=SavEvtEnt.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
        sbQuery.append("&" + sParam + "=" + sPrmValue);
      }
   response.sendRedirect(sTarget + sbQuery.toString());
   }
  //-------------- End Security -----------------
   else
   {
     sUserId = session.getAttribute("USER").toString();

        SavEvtEnt svScd = new SavEvtEnt();
     // save event
         svScd.savSingleDay(sStore, sWeekDay, sDayTime, sEvent,
           sEvtInfo, sAction, sWeekEnd, sUserId);


     svScd.disconnect();

     String sLink = null;
     // redirect to topic list
      if(sDoc.equals("DAY")){
         sLink = "SchedbyDay.jsp?STORE=" + sStore
                   + "&STRNAME=" + sThisStrName
                   + "&MONBEG=" + sMonth
                   + "&WEEKEND=" + sWeekEnd
                   + "&WKDATE=" + sWeekDay
                   + "&FROM=" + sFrom
                   + "&POS=" + sPosition;

      }
      else{
         sLink = "PsWkSched.jsp?STORE=" + sStore
                   + "&STRNAME=" + sThisStrName
                   + "&MONBEG=" + sMonth
                   + "&WEEKEND=" + sWeekEnd
                   + "&FROM=" + sFrom
                   + "&POS=" + sPosition
                   + "&SCHTYP=" + sSchTyp
                   + "&SHWTYP=" + sShwGoal;
      }
      response.sendRedirect(sLink);
  }
 %>

<html>
<head>
<SCRIPT language="JavaScript1.2">
</SCRIPT>
</head>
 <body>
 <%if(sUserId!=null){%>
   Test:
  <p align="left">Str= <%=sStore%>
  <br>StrName= <%=sThisStrName %>
  <br>Month= <%=sMonth%>
  <br>Weekend= <%=sWeekEnd%>
  <br>Event= <%=sEvent%>
  <br>Action= <%=sAction%>
  <br>WeekDay= <%=sWeekDay%>
  <br>DayTime = <%=sDayTime%>
      Comment= <%=sEvtInfo%>

 <%}%>
 </body>
</html>
