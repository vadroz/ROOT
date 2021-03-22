<%@ page import="patiosales.PatioAdvRecap , java.util.*, java.math.BigDecimal"%>
<%
   String sLvl = request.getParameter("Lvl");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSeq = request.getParameter("Seq");
   String [] sSelStr = request.getParameterValues("Str");
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
	String sUser = session.getAttribute("USER").toString();
	PatioAdvRecap paheard = new PatioAdvRecap();
	paheard.setOtherResp(sSelStr, sFrDate, sToDate, sSeq, sUser);
	
	int iNumOfOth = paheard.getNumOfOth();
    String sOthStr = paheard.getOthStrJsa();
    String sOthResp = paheard.getOthRespJsa();
    String sOthTyLy = paheard.getOthTyLyJsa();
    String sOthCount = paheard.getOthCountJsa();

    paheard.disconnect();
%>

<SCRIPT language="JavaScript1.2">

   var NumOfErr = "<%=iNumOfOth%>";
   var Str = [<%=sOthStr%>];
   var Resp = [<%=sOthResp%>];
   var TyLy= [<%=sOthTyLy%>];
   var Count = [<%=sOthCount%>];
   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{  
   parent.showOtherResp(Str, Resp, TyLy, Count);
}    
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
 
</SCRIPT>
