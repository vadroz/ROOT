<%@ page import="java.text.*, java.util.*
, com.test.api.CreateProperty, com.test.api.CreateAttribute
, rciutility.RunSQLStmt, java.sql.ResultSet"%>
<%
   String sAttr = request.getParameter("Attr"); 
   String sProdType = request.getParameter("ProdType"); 
   String sProdTypeId = request.getParameter("PtId");
   String sOptNm = request.getParameter("OptNm");
   
   String sOptId = sOptNm;   
   
   CreateProperty crtprop = null;
   CreateAttribute crtattr = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{	
	String sError = "";
	boolean bError = false;
	
	if(sAttr.equals("Tenant~Brand"))
	{
		crtprop = new CreateProperty();
		crtprop.setNewProp(sAttr, sProdType, sOptNm);  
		bError = crtprop.isInError();
		sError = crtprop.getError();
	}	
	if(sAttr.equals("Tenant~Color") || sAttr.equals("Tenant~Size"))
	{
		crtattr = new CreateAttribute();
		System.out.println(" CreateAttribute()");
		crtattr.setNewAttrinProdType(sAttr, sProdType, sOptNm);  
		if(sAttr.equals("Tenant~Color"))
		{
			sOptId = crtattr.getNewOptionValueId();			
		}
		bError = crtattr.isInError();
		sError = crtattr.getError();		
		
	}
	
	
	if(!bError) 
	{  
		String  sPrepStmt = "insert into rci.MOPTATR values(" 
	     + sProdTypeId + ", '" + sAttr + "', '" + sOptId + "', '" + sOptNm + "')";
	    System.out.println(sPrepStmt);
	    
	    RunSQLStmt runsql = new RunSQLStmt();
		ResultSet rslset = runsql.getResult();		
		runsql.setPrepStmt(sPrepStmt);
		int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    runsql.disconnect();
	}
%>
<%=sOptNm%>	
<SCRIPT>	
var ErrFlg = <%=bError%>;
var Error = "<%=sError%>";
var Attr = "<%=sAttr%>";

if(ErrFlg){	parent.showAddOptErr(error); }
else { parent.updMozuOpt(Attr);  }

   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
<%}%>

