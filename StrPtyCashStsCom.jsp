<%@ page import="storepettycash.StrPtyCashStsCom, java.util.*"%>
<%
   String sStr = request.getParameter("Store");
   String sWeek = request.getParameter("Week");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    String sUser = session.getAttribute("USER").toString();
    StrPtyCashStsCom strpty = new StrPtyCashStsCom(sStr, sWeek, sUser);

    String sSts = strpty.getStsJsa();
    String sDate = strpty.getDateJsa();
    String sComment = strpty.getCommentJsa();

    strpty.disconnect();
    strpty = null;
%>

<SCRIPT language="JavaScript1.2">
var Str = "<%=sStr%>";
var Sts = [<%=sSts%>];
var Date = [<%=sDate%>];
var Comment = [<%=sComment%>];

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.showStsComments(Str, Sts, Date, Comment);
   }

</SCRIPT>
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>