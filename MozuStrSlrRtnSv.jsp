<%@ page import="java.text.*, java.util.*, mozu_com.MozuStrSlrRtnSv, java.sql.ResultSet"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Ord");
   String sPack = request.getParameter("Pack");
   String sSku = request.getParameter("Sku");
   String sSrl = request.getParameter("Srl");
   String sStr = request.getParameter("Str");
   String sReas = request.getParameter("Reas");
   String sRtnSts = request.getParameter("RtnSts");
   String sRtnAct = request.getParameter("RtnAct");
   String sTrans = request.getParameter("Trans");
   String sEmp = request.getParameter("Emp");
   String sUser = request.getParameter("User");
   String sComment = request.getParameter("Comment");
   String sRefOpt = request.getParameter("RefOpt");
   String sTrack = request.getParameter("Track");
   String sType = request.getParameter("Type");
   String sAction = request.getParameter("Action");
   
   if(sPack == null){ sPack = " "; }
   if(sRtnAct == null){ sRtnAct = " "; }
   if(sTrans == null){ sTrans = " "; }
   if(sTrack == null){ sTrack = " "; }
  
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  	
	
	MozuStrSlrRtnSv svrtninf = new MozuStrSlrRtnSv();
	
	if(sAction.equals("AddRtn") || sAction.equals("UpdRtn")  || sAction.equals("DltRtn")
			  || sAction.equals("AddItem") )
	{	  
		svrtninf.saveRtnInfo(sSite, sOrder, sPack, sSku, sSrl, sStr, sReas, sRtnSts, sEmp
			  , sComment, sRtnAct, sTrans, sTrack, sRefOpt, sAction, sUser);		  
	}
	else if(sAction.equals("SendProbOrd"))
	{	
		svrtninf.sendProbOrd(sType, sSku, sTrack,sComment,sUser);
	}
	
	svrtninf.disconnect();
	svrtninf = null;
%> 
<%System.out.println("act=" + sAction);%>

<SCRIPT  language="JavaScript1.2">	    
   parent.restart();   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

