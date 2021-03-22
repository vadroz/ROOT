<%@ page import="vendorsupport.ClinicStrWkLst , java.util.*"%>
<%
    String sStore = request.getParameter("Store");
    String sWeekend = request.getParameter("Weekend");
    String sUser = request.getParameter("User");

    // Charts and table for div 1 challenage
    ClinicStrWkLst venappr = new ClinicStrWkLst(sStore, sWeekend, sUser);
     int iNumOfCln = venappr.getNumOfCln();
     String sDate = venappr.getDate();
     String sBrand = venappr.getBrand();
     String sName = venappr.getName();

     venappr.disconnect();
     venappr = null;
%>
<SCRIPT language="JavaScript1.2">
var Date = [<%=sDate%>]
var Brand = [<%=sBrand%>]
var Name = [<%=sName%>]

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.showClinicWeekly(Name, Date, Brand);
}
</SCRIPT>







