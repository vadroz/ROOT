<%@ page import="vendorsupport.VenApprovalReq , java.util.*"%>
<%
    String sUser = "NONE";
    if (session.getAttribute("USER") != null)  { sUser= session.getAttribute("USER").toString();}

    // Charts and table for div 1 challenage
    VenApprovalReq venappr = new VenApprovalReq(sUser);
    int iNumOfCln = venappr.getNumOfCln();
    String sStr = venappr.getStr();
    String sDate = venappr.getDate();
    String sBrand = venappr.getBrand();
    venappr.disconnect();
    venappr = null;
%>
<SCRIPT language="JavaScript1.2">
var Store = [<%=sStr%>]
var Date = [<%=sDate%>]
var Brand = [<%=sBrand%>]

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.showClinicApprReq(Store, Date, Brand);
}
</SCRIPT>







