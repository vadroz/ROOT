<%@ page import="customermgmt.CmList"%>
<%
    String [] sSrchStore = request.getParameterValues("Store");
    String [] sSrchSport = request.getParameterValues("Sport");
    String [] sSrchDbase = request.getParameterValues("Dbase");
    String [] sSrchRadius = request.getParameterValues("Radius");
    String [] sSrchResAddr = request.getParameterValues("Addr");
    String sComment = request.getParameter("Comment");
    String sDownl = request.getParameter("Downl");

    if (sComment == null) { sComment = ""; }

    String sUser = session.getAttribute("USER").toString();

    CmList cmlist = new CmList(sSrchStore, sSrchSport, sSrchDbase, sSrchRadius, sSrchResAddr, sComment, sDownl, sUser);
    String sStrTot = cmlist.getStrTotJsa();
    String sStr = cmlist.getStrJsa();

    String sTotal = cmlist.getTotal();
    //System.out.println("Total: " + sTotal);
%>
<script name="javascript1.3">
//------------------------------------------------------------------------------
var Str = [<%=sStr%>];
var StrTot = [<%=sStrTot%>];
var Total = "<%=sTotal%>";
var Downl = "<%=sDownl%>"
setStoreCount();
//==============================================================================
// run on loading
//==============================================================================
function setStoreCount()
{
   if(Downl != 'Y') {  parent.popStrCount(Str, StrTot, Total); }
   else { alert("Customer List is generating now.\nYou will get e-mail when it completed.") }
}
</script>
<%
   cmlist.disconnect();
   cmlist = null;
%>