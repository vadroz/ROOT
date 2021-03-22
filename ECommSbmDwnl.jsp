<%@ page import="ecommerce.ECommSbmDwnl, java.util.*"%>
<%
    String sAction = request.getParameter("Action");
    String sUser = request.getParameter("User");
    String sJobId = request.getParameter("JobId");
    String sStatus = null;
    boolean bSubmit = false;
    ECommSbmDwnl sbmdwn = null;

    if(sJobId==null)
    {
       bSubmit = true;
       sbmdwn = new ECommSbmDwnl(sAction, sUser);
       sJobId = sbmdwn.getJobId();
       sbmdwn.disconnect();
       sbmdwn = null;
    }
    else
    {
       //System.out.println("CheckJob " + sJobId);
       sbmdwn = new ECommSbmDwnl(sJobId);
       sStatus = sbmdwn.getStatus();
       sbmdwn.disconnect();
       sbmdwn = null;
    }
%>
<script name="javascript1.2">
  <%if(bSubmit){%>returnJobId("<%=sJobId%>")<%}
  else{%>returnStatus("<%=sStatus%>")<%}%>
//==============================================================================
// download files with new and update items for Volusion
//==============================================================================
function returnJobId(job)
{
   parent.setJobId(job);
}
//==============================================================================
// download files with new and update items for Volusion
//==============================================================================
function returnStatus(sts)
{
   parent.showStatus(sts);
}
</script>