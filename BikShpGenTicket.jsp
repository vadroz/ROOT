<%@ page import="specialorder.TicketEntry, java.util.*, java.text.*"%>
<%
   String [] sParamName = new String[]
   { "JobNum", "Store", "User", "CustNum",
     "TicketType", "Make", "Model", "Color", "Gender", "Part", "LastName",
     "FirstName", "Date", "Address", "City", "State", "Zip", "HomePh", "CellPh",
     "WorkPh", "ExtWorkPh", "EMail"
   };

   String [] sParam = new String[sParamName.length];

   // receive entry parameters
   for(int i=0; i < sParamName.length; i++)
   {
      sParam[i] = request.getParameter(sParamName[i]);
   }

   int [] iPrmLng = new int[]{  10, 5, 10, 10, 1, 25, 25, 25, 1, 120, 25, 25, 10,
                                 100, 25, 2, 10, 12, 12, 12, 5, 65};

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BikeWorkShop.jsp&APPL=ALL" + request.getQueryString());
   }
   else
   {
      StringBuffer sbTest = new StringBuffer();
      for(int i=0; i < sParam.length; i++)
      {
        sbTest.append(sParamName[i] + "=" + sParam[i]) ;
      }
      TicketEntry ticket = new TicketEntry(sParam, iPrmLng);
%>

<SCRIPT language="JavaScript1.2">

var Param = "<%=sbTest.toString()%>"
var Ticket = 5;

setJobNumber(Ticket);

// send employee availability to schedule
function setJobNumber(ticket)
{
  //alert(Param)
  parent.setTicket(ticket);
}



</SCRIPT>
<%}%>