<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*
, com.test.api.CreateAttribute"%>
<%
	String sSite = request.getParameter("Site");
	String sPtId = request.getParameter("PtId");
	String sBind = request.getParameter("Bind");
	String sBindNm = request.getParameter("BindNm");
	String sKiboItem = request.getParameter("KiboItem");
	String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") != null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();	
	
	boolean bExist = false;
	RunSQLStmt runsql = new RunSQLStmt();	
	boolean bError = false;
	String sError = null;
	
	System.out.println(sSite + "|" + sPtId + "|" + sBind + "|" + sBindNm 
		+ "|" + sKiboItem + "|" + sBindNm 
		+ "|" + sAction);
	
	if(sAction.equals("ADD"))
	{		
		CreateAttribute crtattr = new CreateAttribute();
		crtattr.setNewExtrasInProdType(sPtId, "tenant~bindings", sKiboItem, sBindNm);
		bError = crtattr.isInError();
		sError = crtattr.getError();
		bError = !sError.equals("NONE"); 
				
		System.out.println("Error=" + sError + " " + bError);
		
		if(!bError)
		{
			// check if record exists
			String sExist = "select BPNAME from rci.MOBINDPR " 
			+ " where BpSite='" + sSite + "' and BpPtId=" + sPtId 
			+ " and BpCls=" + sBind.substring(0, 4) + " and BpVen=" + sBind.substring(4, 10)
			+ " and BpSty=" + sBind.substring(10, 17) + " and BpClr=" + sBind.substring(17,21)
			+ " and BpSiz=" + sBind.substring(21)
			;	
			System.out.println(sExist); 
			runsql.setPrepStmt(sExist);		   
			runsql.runQuery();
			if(runsql.readNextRecord())
			{
				bExist = true;
				bError = true;
				sError = "The Binding is already exists.";
			}
			runsql.disconnect();
		
			if(!bExist)
			{
				String sInsert = "insert into rci.MOBINDPR values("
				 + "'" + sSite 
				 + "'," + sPtId 
				 + "," + sBind.substring(0, 4) 
				 + "," + sBind.substring(4, 10) 
				 + "," + sBind.substring(10, 17)
				 + "," + sBind.substring(17, 21) 
				 + "," + sBind.substring(21)
				 + ",'" + sUser + "'" 
				 + ", current date, current time"
				 + ",'" + sBindNm.replaceAll("'", "''") + "'"
		   	     + ")";   	
				System.out.println(sInsert); 
				runsql = new RunSQLStmt();
				runsql.setPrepStmt(sInsert);		   
				int irs = runsql.runSinglePrepStmt(sInsert, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
				runsql.disconnect();
				runsql = null;
			}
		}
	}
	
	// delete existing records for selected year/quoter and score name 
	if(sAction.equals("DLT"))
	{		
		CreateAttribute crtattr = new CreateAttribute();
		crtattr.deleteExtrasInProdType(sPtId, "tenant~bindings", sKiboItem);
		bError = crtattr.isInError();
		sError = crtattr.getError();
		
		if(!bError)
		{
			String sDelete = "delete from rci.MOBINDPR"
	   	 	+ " where BpSite='" + sSite + "' and BpPtId=" + sPtId 
	   	 	+ " and BpCls=" + sBind.substring(0, 4) + " and BpVen=" + sBind.substring(4, 10)
	   	 	+ " and BpSty=" + sBind.substring(10, 17) + " and BpClr=" + sBind.substring(17, 21)
	   	 	+ " and BpSiz=" + sBind.substring(21)
	   		;
	   		System.out.println(sDelete);  
	   		runsql = new RunSQLStmt();
	   		runsql.setPrepStmt(sDelete);
	   		int irs = runsql.runSinglePrepStmt(sDelete, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	   		runsql.disconnect();
		}
	}
%>
<html>
<SCRIPT>

var errorFlg = <%=bError%>;
var error = "<%=sError%>";

var Action = "<%=sAction%>";
if(errorFlg){ parent.showError(error);  }
else { parent.location.reload();  }

</SCRIPT>
</html>
<%
}
else
{%>
	<script>
	alert("Your session is expired. Please signon again.")
	</script>
<%}%>