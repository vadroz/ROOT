<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*
, com.test.api.CreateParent"%>
<%
	String sSite = request.getParameter("Site");
	String sProd = request.getParameter("Prod");
	String sBind = request.getParameter("Bind");
	String sPrice = request.getParameter("Price");
	String sQty = request.getParameter("Qty");
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
	
	System.out.println(sSite + "|" + sProd + "|" + sBind + "|" + sPrice + "|" + sQty + "|" + sAction);
	
	if(sAction.equals("ADD"))
	{		
		CreateParent crtpar = new CreateParent();
		int iQty = Integer.parseInt(sQty);
		double dPrice = Double.parseDouble(sPrice);
		crtpar.addProdExtras(sProd, sBind, dPrice, iQty);
		bError = crtpar.isError();
		sError = crtpar.getError();
		
		if(!bError)
		{
			// check if record exists
			String sExist = "select IBPCLS from rci.MOITBIND " 
			+ " where IbSite='" + sSite + "'"
			+ " and IbPCls=" + sBind.substring(0, 4) + " and IbPVen=" + sBind.substring(4, 10)
			+ " and IbPSty=" + sBind.substring(10, 17) 			
			+ " and IbBCls=" + sBind.substring(0, 4) + " and IbBVen=" + sBind.substring(4, 10)
			+ " and IbBSty=" + sBind.substring(10, 17) + " and IbBClr=" + sBind.substring(18, 22)
			+ " and IbBSiz=" + sBind.substring(22)
			;	
			//System.out.println(sExist); 
			runsql.setPrepStmt(sExist);		   
			runsql.runQuery();
			if(runsql.readNextRecord())
			{
				bExist = true;
				bError = true;
				sError = "The Binding is already attched to Product.";
			}
			runsql.disconnect();
		
			if(!bExist)
			{
				String sInsert = "insert into rci.MOITBIND values("
				 + "'" + sSite + "'" 
				 + "," + sProd.substring(0, 4) + "," + sProd.substring(4, 10) 
				 + "," + sProd.substring(10, 17)
				 + "," + sBind.substring(0, 4) + "," + sBind.substring(4, 10) 
				 + "," + sBind.substring(10, 17)
				 + "," + sBind.substring(18, 22) + "," + sBind.substring(22)
				 + "," + sQty
				 + ",'" + sUser + "', current date, current time"	
		   	     + ")";   	
				//System.out.println(sInsert); 
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
		CreateParent crtpar = new CreateParent();
		String sExtra = sBind.substring(0,13) + "-" + sBind.substring(13);
		crtpar.deleteProdExtras(sProd, sBind);
		bError = crtpar.isError();
		sError = crtpar.getError();
		
		if(!bError)
		{
			String sDelete = "delete from rci.MOITBIND"
	   	 	+ " where IbSite='" + sSite + "'" 
	   	    + "," + sProd.substring(0, 4) + "," + sProd.substring(4, 10) 
			+ "," + sProd.substring(10, 17)
			+ "," + sBind.substring(0, 4) + "," + sBind.substring(4, 10) 
			+ "," + sBind.substring(10, 17)
			+ "," + sBind.substring(18, 22) + "," + sBind.substring(22)
	   		;
	   		//System.out.println(sDelete);  
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