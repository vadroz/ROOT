<%@ page import="payrollreports.SavAvlEnt, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sEmpNum = request.getParameter("EMPNUM");
   String sAction = request.getParameter("ACTION");
   String sActRng = request.getParameter("ACTRANGE");

   String [] sWeekDay = null;
   String [] sBegTime = null;
   String [] sEndTime = null;


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

     if (sActRng == null) sActRng = " ";
     //
        SavAvlEnt svAvail = new SavAvlEnt();
     // save 1-7 days schedule
     for(int i=0; i<sWeekDay.length; i++)
     {
        if (sWeekDay[i] != null)
       {
         svAvail.savSingleDay(sEmpNum, sWeekDay[i], sBegTime[i], sEndTime[i],
                              sAction, sActRng);
       }
     }
     svAvail.disconnect();

     String sLink = null;
         sLink = "Availability.jsp?STORE=" + sStore
               + "&STRNAME=" + sThisStrName;

      response.sendRedirect(sLink);
 %>

<html>
<head>
<SCRIPT language="JavaScript1.2">
</SCRIPT>
</head>
 <body>
   Test:
  <p align="left">Str= <%=sStore%>
  <br>StrName= <%=sThisStrName %>
  <br>EmpNum= <%=sEmpNum%>
  <br>Action= "<%=sAction%>"

  <br>ActRange= "<%=sActRng%>"
  <%for(int i =0; i< 7; i++){%>
    <br>WeekDay= <%=sWeekDay[i]%>
        BegTime= <%=sBegTime[i]%>
        EndTime= <%=sEndTime[i]%>
  <%}%>
 </body>
</html>
