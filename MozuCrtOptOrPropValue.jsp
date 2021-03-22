<%@ page import="java.text.*, java.util.*
, com.test.api.CreateAttribute
, com.test.api.CreateProperty
, rciutility.RunSQLStmt, java.sql.ResultSet"%>
<%
	String sAttr = request.getParameter("Attr");    
   	String sProdType = request.getParameter("ProdType"); 
   	String sProdTypeId = request.getParameter("PtId");
   	String sOptNm = request.getParameter("OptNm");
   	String sSite = request.getParameter("Site");
   
   	String sOptId = sOptNm;   
   
   	CreateAttribute crtattr = null;   
   	CreateProperty crtprop = null;   
   	
   	String sError = "";
	boolean bError = false;
  //----------------------------------
 // Application Authorization
 //----------------------------------
 if  (session.getAttribute("USER")!=null)
 {	 
	 System.out.println("Create Attribiute ==> PT=" + sProdType + "-" + sProdTypeId
				+ " sAttr=" + sAttr + " sOptNm=" + sOptNm); 
	 
	 
	if(sAttr.equals("tenant~brand") || sAttr.equals("tenant~normalized-color"))
	{
		crtprop = new CreateProperty(sSite);
		crtprop.setNewProp(sAttr, sProdType, sProdTypeId, sOptNm);  
		bError = crtprop.isInError();
		sError = crtprop.getError();
	}
	
	if(sAttr.toLowerCase().equals("tenant~color") || sAttr.toLowerCase().equals("tenant~size"))
	{		
		crtattr = new CreateAttribute(sSite);	
		
   		crtattr.setNewAttrinProdType(sAttr, sProdType, sProdTypeId, sOptNm);
   		bError = crtattr.isInError();
		sError = crtattr.getError();	    	
		if(sAttr.toLowerCase().equals("tenant~color") || sAttr.toLowerCase().equals("tenant~size"))
		{
			sOptId = crtattr.getId();
			System.out.println(" New Id " + sOptId);
		}
	}	
%> 
<br> <%=sError%>
<SCRIPT>	
var ErrFlg = <%=bError%>;
var Error = "<%=sError%>";
var Attr = "<%=sAttr%>";

if(ErrFlg){	parent.showAddOptErr(Error); }
else { parent.updMozuOpt(Attr);  }

   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
<%}%>
  

