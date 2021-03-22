<%@ page import="fileutility.FileQuerySave , java.util.*, java.math.BigDecimal"%>
<%
   String sKey = request.getParameter("Key");
   String sTitle = request.getParameter("Title");
   String sTitle1 = request.getParameter("Title1");
   String sTitle2 = request.getParameter("Title2");
   String sCount = request.getParameter("Count");
   String sStmt = request.getParameter("Stmt");
   String [] sColHdg = request.getParameterValues("ColHdg");
   String sAction = request.getParameter("Action");

   if(sKey==null) { sKey = " " ; }
   if(sTitle==null) { sTitle = " " ; }
   if(sTitle1==null) { sTitle1 = " " ; }
   if(sTitle2==null) { sTitle2 = " " ; }
   if(sCount==null) { sCount = "N" ; }
   if(sStmt==null) { sStmt = " " ; }

   FileQuerySave qrysave = null;
   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   qrysave = new FileQuerySave(sKey, sTitle, sTitle1, sTitle2, sCount, sStmt,
                   sColHdg, sAction, session.getAttribute("USER").toString());

   sKey = qrysave.getKey();
   iNumOfErr = qrysave.getNumOfErr();
   sError = qrysave.getError();

   qrysave.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   var Key = "<%=sKey%>"
   var Action = "<%=sAction%>"
   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   if(NumOfErr > 0) parent.displayError(Error);
   else parent.restart(Key, Action);
}
<%}
else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
<%}%>
</SCRIPT>
