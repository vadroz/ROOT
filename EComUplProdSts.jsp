<%@ page import="rciutility.CheckUpdateStatus"%>
<%
   CheckUpdateStatus chksts = new CheckUpdateStatus("ECPROD_UPD");

   String sStatus = chksts.getStatus();
   String sRecords = chksts.getRecords();
   String sDate = chksts.getDate();
   String sTime = chksts.getTime();
   String sUser = chksts.getUser();
%>
<script name="javascript1.2">
var Status = "<%=sStatus%>";
var Records = "<%=sRecords%>";
var Date = "<%=sDate%>";
var Time = "<%=sTime%>";
var User = "<%=sUser%>";

showMessage();
//==============================================================================
// show error
//==============================================================================
function showMessage()
{
   alert(Status);
}
</script>


