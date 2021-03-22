<%@ page import="payrollreports.IncPlanFlSav, java.util.*, java.sql.*"%>
<%
   String sEmp = request.getParameter("Emp");
   String [] sMonth = request.getParameterValues("Mon");
   String [] sPrc = request.getParameterValues("Prc");
   String sStr = request.getParameter("Str");
   String sQtr = request.getParameter("Qtr");
   String sAction = request.getParameter("Action"); 

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=IncPlanFlSav.jsp");
}   
else
{
	//System.out.println(sStr + "|" + sQtr + "|" + sAction);
    String sUser = session.getAttribute("USER").toString();
 
    IncPlanFlSav saveflprc = new IncPlanFlSav( );
    if(sAction.equals("ADD") || sAction.equals("UPD"))
    {
    	saveflprc.saveMonthPrc(sEmp, sMonth, sPrc, sAction, sUser );
    }
    else if(sAction.equals("MARKEDPAY"))
    {
    	saveflprc.setQtrPay(sStr, sQtr, sAction, sUser);
    }
%>

<script language="javascript">
 parent.location.reload();
</script>


<%
saveflprc.disconnect();
saveflprc = null;
  }
%>
