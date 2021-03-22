<%@ page import="com.test.api.RtvOptionUpdAs4, com.test.api.RtvCategoryLst, java.text.*, java.util.*"%>
<%
String sAction = request.getParameter("Action");
//----------------------------------
//Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
	String msg = "";
	if(sAction.equals("Upd_Option"))
	{		
		msg = "The Mozu Options are retrieved. The AS/400 database have been updated.";
		RtvOptionUpdAs4 rtvattr = new RtvOptionUpdAs4();
		
	}
	else if(sAction.equals("Upd_Categ"))
	{
		msg = "The Mozu Categories are retrieved. The AS/400 database have been updated.";
		RtvCategoryLst rtvattr = new RtvCategoryLst();
	}
	
	
%>

<SCRIPT>	
var msg = "<%=msg%>";
parent.showMsg(msg);

</SCRIPT>
<%}
else {%>
<SCRIPT language="JavaScript1.2">
   alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
</SCRIPT>
<%}%>

