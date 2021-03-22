<!DOCTYPE html>	
<%@ page import="com.test.api.MozuCrtAttr, java.util.*, java.text.*"%>  
<%
	String sAttr = request.getParameter("Attr");
	String sLabel = request.getParameter("Label");
	String sDesc = request.getParameter("Desc");
	String sInpTy = request.getParameter("InpTy");
	String [] sAttrTy = request.getParameterValues("AttrTy");
	String sValueTy = request.getParameter("ValueTy");
	

if (session.getAttribute("USER")!=null)
{
	MozuCrtAttr crtattr = new MozuCrtAttr();
	boolean [] bAttrTy = new boolean[3];
	for(int i=0; i < 3;i++)
	{
		bAttrTy[i] = sAttrTy[i].equals("true");
	}
	
	System.out.println(" Attr=" + sAttr + "| sLabel=" + sLabel + "| Desc=" + sDesc 
		+ "| InpTy=" + sInpTy 
		+ "| attrTy(0)" + bAttrTy[0] + "| attrTy(1)" + bAttrTy[1] + "| attrTy(2)" + bAttrTy[2]
		+ "| ValTy=" + sValueTy);
	crtattr.crtNewAttr(sAttr,sLabel, sDesc, sInpTy, bAttrTy, "String", sValueTy);
	String sError = "";
	boolean bError = crtattr.isInError();
	if( bError )
	{
		sError = crtattr.getError();
	}
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Test MOZU Maven Project</title>   

<SCRIPT>
var ErrFlg = <%=bError%>;
var Error = "<%=sError%>";
if(ErrFlg){parent.showError(Error);}
else{ parent.location.reload(); }
</SCRIPT>

</head>
<body>

 </body>
</html>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
<%}%>
