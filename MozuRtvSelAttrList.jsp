<%@ page import="java.text.*, java.util.*, com.test.api.MozuRtvSelAttrList"%>
<%
   String sAttr = request.getParameter("Attr"); 
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
	MozuRtvSelAttrList rtvattrl = new MozuRtvSelAttrList();
	rtvattrl.rtvAttrList("Tenant~Color");
	
	int iNumOfAttr = rtvattrl.getNumOfAttr();		
	String [] sOptId = rtvattrl.getOptId();
	String [] sOptNm = rtvattrl.getOptNm();
	for(int i=0; i < sOptNm.length; i++)
	{
		sOptNm[i] = sOptNm[i].replaceAll("\"", "&#34");
		sOptNm[i] = sOptNm[i].replaceAll("'", "&#39");
		sOptNm[i] = sOptNm[i].replaceAll("/", "&#47");
		
		//sOptNm[i] = sOptNm[i].replaceAll("\"", "%22");
		//sOptNm[i] = sOptNm[i].replaceAll("'", "%27");
		//sOptNm[i] = sOptNm[i].replaceAll("/", "%2F");
	}
%>
<div id="dvOption">Option Name:</div>

<SCRIPT>	
var max = "<%=iNumOfAttr%>";
var optid = new Array();
var optnm = new Array();
<%for(int i=0; i < iNumOfAttr; i++){%>optid[<%=i%>] = "<%=sOptId[i]%>"; optnm[<%=i%>] = "<%=sOptNm[i]%>";<%}%>

/*var opt = "";
for(var i=0; i < optid.length; i++)
{
	 opt += "<br>" + optnm[i];
}
document.all.dvOption.innerHTML += opt;
*/
parent.showOptList(max, optid, optnm); 

   
</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
<%}%>

