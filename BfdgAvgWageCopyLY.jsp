<%@ page import="payrollreports.BfdgAvgWageSave, java.util.*, java.sql.*"%>
<%
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sSelBdgGrp = request.getParameter("BdgGrp");
   String sFrStr = request.getParameter("FrStr");
   String sToStr = request.getParameter("ToStr");

   String [] sStr = request.getParameterValues("Str");
   String [] sBdgGrp = request.getParameterValues("Bdg");
   String [] sSubGrp = request.getParameterValues("Sub");
   String [] sWeek = request.getParameterValues("Week");

   String sAction = request.getParameter("Action");
   String sApply = request.getParameter("Apply");

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgAvgWage.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    BfdgAvgWageSave bgavgwsav = new BfdgAvgWageSave();
    for(int i=0; i < sStr.length; i++)
    {
       for(int j=0; j < sWeek.length; j++)
       {
          for(int k=0; k < sBdgGrp.length; k++)
          {
             for(int l=0; l < sSubGrp.length; l++)
             {
                System.out.println(sStr[i] + " " + sBdgGrp[k] + " " + sSubGrp[l] + " " + sWeek[j] + " " + "0"
                   + " " + "0" + " " + "1" + " " + sAction + " " + sUser);
                //bgavgwsav.saveAvgWage(sStr[i], sBdgGrp[k], sSubGrp[l], sWeek[j], "0", "0", sApply, sAction, sUser);
             }
          }
       }
    }
%>
<script language="javascript">
parent.window.location.reload();
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<%}%>
