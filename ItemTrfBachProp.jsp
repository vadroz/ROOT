<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
    String sBatch = request.getParameter("Batch");
	String sPrepStmt = "select TBCOMM, TBTRWHSE, TBWHSQT, TBBSRLVL, TBPERM, TBNEVER"
		+ ",TBFRLRI,TBTOLRI,TBFRLSI,TBTOLSI,TBFRLMI,TBTOLMI"
   	 	+ " from rci.ITrfBch"
   	 	+ " where TBBATCH=" + sBatch;
   		
   	System.out.println(sPrepStmt);
   	
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sPrepStmt);		   
   	runsql.runQuery();
   	
   	String sComm = "";
   	String sWhse = "";
   	String sWhsQty = "";
   	String sBsrLvl = "";
   	String sPerm = "";
   	String sNever = "";
   	String sFrRcvDt = "";
   	String sToRcvDt = "";
   	String sFrSlsDt = "";
   	String sToSlsDt = "";
   	String sFrMkdwnDt = "";
   	String sToMkdwnDt = "";
   	   	
   	if(runsql.readNextRecord())
   	{
   	 	sComm = runsql.getData("TBCOMM");
   	 	sWhse = runsql.getData("TBTRWHSE");
   	 	sWhsQty = runsql.getData("TBWHSQT");
    	sBsrLvl = runsql.getData("TBBSRLVL");
    	sPerm = runsql.getData("TBPERM");
    	sNever = runsql.getData("TbNever");
    	sFrRcvDt = runsql.getData("TBFRLRI");
    	if(sFrRcvDt == null){ sFrRcvDt = ""; }
    	
    	sToRcvDt = runsql.getData("TBTOLRI");
    	if(sToRcvDt == null){ sToRcvDt = ""; }
    	
    	sFrSlsDt = runsql.getData("TBFRLSI");
    	if(sFrSlsDt == null){ sFrSlsDt = ""; }
    	
    	sToSlsDt = runsql.getData("TBTOLSI");
    	if(sToSlsDt == null){ sToSlsDt = ""; }
    	
    	sFrMkdwnDt = runsql.getData("TBFRLMI");
    	if(sFrMkdwnDt == null){ sFrMkdwnDt = ""; }
    	
    	sToMkdwnDt = runsql.getData("TBTOLMI");
    	if(sToMkdwnDt == null){ sToMkdwnDt = ""; }
   	}
%>

<script name="javascript1.2">
var batch = "<%=sBatch%>";
var comm = "<%=sComm%>";
var whs = "<%=sWhse%>";
var whsQty = "<%=sWhsQty%>";
var bsrLvl = "<%=sBsrLvl%>";
var perm = "<%=sPerm%>";
var never = "<%=sNever%>";
var frRcvDt = "<%=sFrRcvDt%>";
var toRcvDt = "<%=sToRcvDt%>";
var frSlsDt = "<%=sFrSlsDt%>";
var toSlsDt = "<%=sToSlsDt%>";
var frMkdwnDt = "<%=sFrMkdwnDt%>";
var toMkdwnDt = "<%=sToMkdwnDt%>";

parent.setBatchProp(batch, comm, whs, whsQty, bsrLvl, perm, never
		, frRcvDt, toRcvDt, frSlsDt, toSlsDt, frMkdwnDt, toMkdwnDt );

//==============================================================================
// run on loading
//==============================================================================

</script>