<%@ page import="patiosales.PfsCheckDelDate, java.util.*"%>
<%
   String sSingle = request.getParameter("single");
   String [] sCheckDate = request.getParameterValues("chkdt");
   String [] sStr = request.getParameterValues("str");

   int iNumOfDate = 0;
   String sClosed = null;

   PfsCheckDelDate getclosed = new PfsCheckDelDate(sStr, sCheckDate);


   iNumOfDate = getclosed.getNumOfDate();
   sClosed = getclosed.getClosed();

   getclosed.disconnect();
%>

<SCRIPT language="JavaScript1.2">
var NumOfDate = <%=iNumOfDate%>
var Closed = [<%=sClosed%>];
goBack();

//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   <%if (sSingle == null) {%>
        parent.markClosed(Closed);
   <%}
     else {%>
        if(NumOfDate == 0) parent.markSingleDateSts(false);
        else parent.markSingleDateSts(true);
   <%}%>
}
</SCRIPT>
