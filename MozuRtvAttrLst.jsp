<%@ page import="java.text.*, java.util.*, com.test.api.MozuRtvAttrLst"%>
<%  
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
	MozuRtvAttrLst rtvattrl = new MozuRtvAttrLst();
	rtvattrl.rtvAttrList();
	String [] sAttr = rtvattrl.getAttr();
	String [] sAttrNm = rtvattrl.getAttrNm();
	String [] sAttrTy = rtvattrl.getAttrTy();
%>
<div id="dvOption">Option Name:</div>

<SCRIPT>	
var attr = new Array();
var attrnm = new Array();
var attrty = new Array();

<%for(int i=0; i < sAttr.length; i++){%>attr[<%=i%>] = "<%=sAttr[i]%>"; attrnm[<%=i%>] = "<%=sAttrNm[i]%>"; attrty[<%=i%>] = "<%=sAttrTy[i]%>";<%}%>

var opt = "";
for(var i=0; i < attr.length; i++)
{
	opt += "<br>" + attr[i] + " " + attrnm[i];
}
document.all.dvOption.innerHTML += attr;

parent.showOptPropList(attr, attrnm, attrty); 

   
</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
<%}%>

