<%@ page import="mozu_com.MozuImageSave, java.util.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sSeq = request.getParameter("Seq");
   String sFile = request.getParameter("File");
   String sComment = request.getParameter("Comment");
   String sClrId = request.getParameter("ClrId");
   String sAction = request.getParameter("Action");
   
   if(sFile == null || sFile.equals("")){ sFile = " "; }
   if(sComment == null || sComment.equals("")){ sComment = " "; }
   if(sClrId == null || sClrId.equals("")){ sClrId = " "; }
//--------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMMERCE")!=null)
{ 	
	String sUser = session.getAttribute("USER").toString();
	String sName = null;
	
	MozuImageSave imgsv = new MozuImageSave();
	imgsv.saveImage(sCls, sVen, sSty, sSeq, sFile, sComment, sClrId, sAction, sUser);
	imgsv.disconnect();
	imgsv = null;
	
%>
<SCRIPT language="JavaScript1.2">   

   var Action = "<%=sAction%>";
   
   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
	   if(Action=="ADD") { parent.location.reload(); }
	   else if(Action=="DLT") { parent.location.reload(); }
	   else if(Action=="UPD") { parent.location.reload(); }
   }
   </SCRIPT>  
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
     </SCRIPT>
<%}%>








