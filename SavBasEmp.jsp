<%@ page import="payrollreports.SavBasEmp, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sEmp =  request.getParameter("EMPNUM");
   String sFName =  request.getParameter("FNAME");
   String sLName =  request.getParameter("LNAME");
   String sTitle =  request.getParameter("TITLE");
   String sDept =  request.getParameter("DEPT");
   String sSalType =  request.getParameter("SALARY");
   String sRate =  request.getParameter("RATE");
   String sSCom =  request.getParameter("SCOM");
   String sAction = request.getParameter("ACTION");
   String sUserId = " ";

   if(sStore == null) sStore = " ";
   if(sFName == null) sFName = " ";
   if(sLName == null) sLName = " ";
   if(sTitle == null) sTitle = " ";
   if(sDept == null) sDept = " ";
   if(sSalType == null) sSalType = " ";
   if(sRate == null) sRate = " ";
   if(sSCom == null) sSCom = " ";
   if(sSCom.equals("N")) sSCom = " ";

   //-------------- Security ---------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=SavBasEmp.jsp&APPL=" + sAppl;
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

       SavBasEmp svBEmp = new SavBasEmp();
      // save event
         svBEmp.setEmployee(sStore, sEmp, sFName, sLName, sTitle, sSalType,
                             sDept, sRate, sSCom, sAction, sUserId);
     svBEmp.disconnect();

     String sLink = null;
         sLink = "BasicEmp.jsp?STORE=" + sStore;
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
  <br>FName= <%=sFName%>
  <br>LName= <%=sLName%>
  <br>Title= <%=sTitle%>
  <br>Dept= <%=sDept%>
  <br>Salary Type= <%=sSalType%>
  <br>Rate= <%=sRate%>
  <br>sSCom= <%=sSCom%>
 <%}%>
 </body>
</html>
