<%@ page import="payrollreports.SavHrsEnt, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sGrp = request.getParameter("GRP");
   String sNewGrp = request.getParameter("NEWGRP");
   String sEmpNum = request.getParameter("EMPNUM");
   String sEmpName = request.getParameter("EMPNAME");
   String sAction = request.getParameter("ACTION");

   String sFrom = request.getParameter("FROM");
   String sPosition = request.getParameter("POS");
   String sDoc = request.getParameter("DOC");
   String sSchTyp = request.getParameter("SCHTYP");
   String sShwGoal = request.getParameter("SHWGOAL");
   String sActRng = request.getParameter("ACTRANGE");

   String sUserId = null;
   String [] sWeekDay = null;
   String [] sBegTime = null;
   String [] sEndTime = null;
   String [] sHrsType = null;

   int iNumOfErr = 0;
   String [] sError = null;

   //------------------------------------------------------------------------------------------------------
   // Application Authorization
   //------------------------------------------------------------------------------------------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SavHrsEnt.jsp&APPL=" + sAppl + "&" + request.getQueryString());
   }
   else
   {
     sUserId = session.getAttribute("USER").toString();

     sWeekDay = new String[]{request.getParameter("WKDATE0"), request.getParameter("WKDATE1"),
                             request.getParameter("WKDATE2"), request.getParameter("WKDATE3"),
                             request.getParameter("WKDATE4"), request.getParameter("WKDATE5"),
                             request.getParameter("WKDATE6")};
     sBegTime = new String[]{request.getParameter("BEGTIME0"),request.getParameter("BEGTIME1"),
                             request.getParameter("BEGTIME2"),request.getParameter("BEGTIME3"),
                             request.getParameter("BEGTIME4"),request.getParameter("BEGTIME5"),
                             request.getParameter("BEGTIME6")};
     sEndTime = new String[]{request.getParameter("ENDTIME0"),request.getParameter("ENDTIME1"),
                             request.getParameter("ENDTIME2"),request.getParameter("ENDTIME3"),
                             request.getParameter("ENDTIME4"),request.getParameter("ENDTIME5"),
                             request.getParameter("ENDTIME6")};

     sHrsType = new String[]{request.getParameter("HRSTYP0"),request.getParameter("HRSTYP1"),
                           request.getParameter("HRSTYP2"),request.getParameter("HRSTYP3"),
                           request.getParameter("HRSTYP4"),request.getParameter("HRSTYP5"),
                           request.getParameter("HRSTYP6")};


     if (sActRng == null) sActRng = " ";
     if (sNewGrp == null) sNewGrp = " ";
     SavHrsEnt svScd = new SavHrsEnt();

     // save 1-7 days schedule
     for(int i=0; i<sWeekDay.length; i++)
     {
        if (sWeekDay[i] != null)
       {
         svScd.savSingleDay(sStore, sWeekDay[i], sGrp, sEmpNum,
              sEmpName, sBegTime[i], sEndTime[i], sAction, sHrsType[i],
              sActRng, sWeekEnd, sNewGrp, sUserId);
         int ierr = svScd.getNumOfErr();
         if(ierr > 0)
         {
            String [] serr = sError;
            sError = new String[iNumOfErr + ierr];
            for(int j=0; j < iNumOfErr; j++)
            {
               sError[j] = serr[j];
            }
            serr = svScd.getError();
            for(int j = iNumOfErr; j < (iNumOfErr + ierr); j++)
            {
               sError[j] = serr[j];
            }
            iNumOfErr += ierr;
         }
       }
     }

     svScd.disconnect();

     String sLink = null;
     // redirect to topic list
      if(sDoc.equals("DAY")){
         sLink = "SchedbyDay.jsp?STORE=" + sStore
                   + "&STRNAME=" + sThisStrName
                   + "&MONBEG=" + sMonth
                   + "&WEEKEND=" + sWeekEnd
                   + "&WKDATE=" + sWeekDay[0]
                   + "&FROM=" + sFrom
                   + "&GRP=" + sGrp
                   + "&POS=" + sPosition;
      }
      else{
         sLink = "SchedbyWeek.jsp?STORE=" + sStore
                   + "&STRNAME=" + sThisStrName
                   + "&MONBEG=" + sMonth
                   + "&WEEKEND=" + sWeekEnd
                   + "&FROM=" + sFrom
                   + "&GRP=" + sGrp
                   + "&POS=" + sPosition
                   + "&SCHTYP=" + sSchTyp
                   + "&SHWTYP=" + sShwGoal;
      }
      if(iNumOfErr > 0 )
      {
        sLink += "&NumOfErr=" + iNumOfErr;
        for(int i=0; i < iNumOfErr; i++)
        {
          sLink += "&Error" + i + "=" + sError[i];
        }
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
  <br>Group= <%=sGrp%>
  <br>New Group= <%=sNewGrp%>
  <br>EmpNum= <%=sEmpNum%>
  <br>EmpName= <%=sEmpName%>
  <br>Action= <%=sAction%>

  <br>ActRange= <%=sActRng%>
  <%for(int i =0; i< 7; i++){%>
    <br>WeekDay= <%=sWeekDay[i]%>   BegTime= <%=sBegTime[i]%> EndTime= <%=sEndTime[i]%>
    <br>HrsType= <%=sHrsType[i]%>
  <%}%>
 <%}%>
 </body>
</html>
