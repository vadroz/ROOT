<%@ page import="agedanalysis.PlanSave , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanSave.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String [] sStore = request.getParameterValues("STORE");
   String [] sDivision = request.getParameterValues("Div");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sChgPlan = request.getParameter("ChgPlan");
   String sHist = request.getParameter("Hist");
   String [] sMonSls = request.getParameterValues("Sls");
   String [] sMonMkd = request.getParameterValues("Mkd");
   String [] sMonInv = request.getParameterValues("Inv");

   //if(sClass == null) sClass = "ALL";

   /*System.out.println("\nDiv: " + sDivision + "  Dpt: " + sDepartment + " Cls:" + sClass
          + " Chgpln: " + sChgPlan + " Hist: " + sHist);

   for(int i=0;  i < 24; i++ )
   {
       if(!sMonSls[i].trim().equals("") || !sMonMkd[i].trim().equals("") || !sMonInv[i].trim().equals(""))
       {
          System.out.println(i + " -  sls:" + sMonSls[i] + "  mkd:" + sMonMkd[i] + "  inv:" + sMonInv[i]);
       }
   }*/
   PlanSave plans = new PlanSave(sStore, sDivision, sDepartment, sClass,
         sChgPlan, sHist, sMonSls, sMonMkd, sMonInv);

%>

<SCRIPT language="JavaScript1.2">
goBack();

// send employee availability to schedule
function goBack()
{
  parent.redisplayPlanning();
}
</SCRIPT>
<%}%>