<%@ page import="java.text.*, java.util.*, ecommerce.EcStrSrlSv, java.sql.ResultSet"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Ord");
   String sSku = request.getParameter("Sku");
   String sSrl = request.getParameter("Srl");
   String sStr = request.getParameter("Str");
   String sReas = request.getParameter("Reas");
   String sRtnSts = request.getParameter("RtnSts");
   String sEmp = request.getParameter("Emp");
   String sUser = request.getParameter("User");
   String sComment = request.getParameter("Comment");
   String sAction = request.getParameter("Action");
   
   
   //System.out.println("sAction=" + sAction);
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  	
	
	EcStrSrlSv svrtninf = new EcStrSrlSv();
	
	if(sAction.equals("AddRtn") || sAction.equals("UpdRtn"))
	{	  
		svrtninf.saveRtnInfo(sSite, sOrder, sSku, sSrl, sStr, sReas, sRtnSts, sEmp
			  , sComment, sAction, sUser);		  
	}
	
	svrtninf.disconnect();
	svrtninf = null;
%>
	
<SCRIPT>	
   parent.restart();
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

