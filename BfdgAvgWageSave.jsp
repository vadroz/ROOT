<%@ page import="payrollreports.BfdgAvgWageSave, java.util.*, java.sql.*"%>
<%
   String sStr = request.getParameter("Str");
   String sBdgGrp = request.getParameter("BdgGrp");
   String sWeek = request.getParameter("Week");
   String [] sSubGrp = request.getParameterValues("SubGrp");
   String [] sAvg = request.getParameterValues("Avg");

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgAvgWageSave.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sStr + "|" + sBdgGrp + "|" + sWeek + "|" + sSubGrp + "|" + sAvg[0]);

    BfdgAvgWageSave bgavgwsav = new BfdgAvgWageSave(sStr, sBdgGrp, sWeek, sSubGrp, sAvg, sUser);
%>

<script language="javascript">
 parent.sbmBdgAvg();
</script>


<%
  bgavgwsav.disconnect();
  bgavgwsav = null;
  }
%>
