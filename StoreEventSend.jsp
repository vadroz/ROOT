<%@ page import="rciutility.SendMail"%>
<%
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");
   String sEvent = request.getParameter("Event");
   String sDate = request.getParameter("Date");
   String sTime = request.getParameter("Time");
   String sDesc = request.getParameter("Desc");
   String sCont = request.getParameter("Cont");
   String sPhone = request.getParameter("Phone");
   String sEMail = request.getParameter("EMail");

   String sMessage = "Store: " + sStore + " - " + sStrName
                   + "<br>Event: " + sEvent
                   + "<br>Date: " + sDate
                   + "<br>Time: " + sTime
                   + "<br>Desc: " + sDesc
                   + "<br>Contact Name: " + sCont
                   + "<br>Contact Phone: " + sPhone
                   + "<br>Contact EMail: " + sEMail;

   SendMail sndmail = new SendMail("Store" + sStore, "kcavanaugh@retailconcepts.cc", "Store Event", sMessage);

   // redirect to home page
   response.sendRedirect("index.jsp");
 %>

