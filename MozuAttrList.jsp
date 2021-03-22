<%@ page import="java.text.*, java.util.*, mozu_com.MozuAttrLst, java.sql.ResultSet"%>
<%
   String sSite = request.getParameter("Site");
   String sParent = request.getParameter("Parent");
   String sAttr = request.getParameter("Attr");
   
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  		
	//System.out.println(sSite + " " + sParent + " " + sAttr);
	MozuAttrLst attrlst = new MozuAttrLst();
	attrlst.setAttrByCls(sSite, sParent, sAttr);
	int iNumOfOpt = attrlst.getNumOfOpt();
	  		
	String [] sOpts = new String[iNumOfOpt];
	String [] sOptNms = new String[iNumOfOpt];
	
	for(int i=0; i < iNumOfOpt; i++)
	{    
		attrlst.setDetail();
		String sOpt = attrlst.getOpt();
		sOpt = sOpt.replaceAll("'", "&#39;");
		sOpts[i] = sOpt;
		
		String sOptNm = attrlst.getOptNm();
		sOptNm = sOptNm.replaceAll("'", "&#39;");
		//sOptNm = sOptNm.replaceAll("\"", "&#34;");
		sOptNms[i] = sOptNm;		
	}	
	String sOptJsa = attrlst.cvtToJavaScriptArray(sOpts);
	String sOptNmJsa = attrlst.cvtToJavaScriptArray(sOptNms);
	//System.out.println(sOptJsa);
	
	String sProdType = attrlst.getProdType();
    String sProdTypeId = attrlst.getProdTypeId();
%>
	
<SCRIPT>	
   var attr = "<%=sAttr%>";
   var opts = [<%=sOptJsa%>];
   var optnms = [<%=sOptNmJsa%>];
   var prodty = "<%=sProdType%>";
   var ptid = "<%=sProdTypeId%>";
   
   opts = removeSubst(opts, "&#39;", "'");
   optnms = removeSubst(optnms, "&#39;", "'");
   
   
   
   parent.showAttr(attr, opts, optnms, prodty, ptid);
//=========================================================================
// remove substitute for special characters
//=========================================================================
function removeSubst(arr, search, replace)
{
	for(var i=0; i < arr.length; i++)
	{
		if(arr[i].indexOf(search) >= 0)
		{	
			while(arr[i].indexOf(search) >= 0)
			{
				arr[i] = arr[i].replace(search, replace);  
			}
		}
	}
	return arr;
}
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

