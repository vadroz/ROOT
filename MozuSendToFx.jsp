<%@ page import="rciutility.CallAs400SrvPgmSup, rciutility.RunSQLStmt, java.sql.*
, java.text.*, java.util.*"%>
<%
String sStr = request.getParameter("Str");
String sOrder = request.getParameter("Order");
String sPackId = request.getParameter("PackId");
//----------------------------------
//Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
	
	String sStmt = null;
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rs = null;
    
    String sSite = null;
    sStmt = "exec sql select BxSite from RCI.MOSNDBX";           
	System.out.println(sStmt);
    runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();
	if(runsql.readNextRecord())
	{
		sSite = runsql.getData("BxSite");
	}	
	rs.close();
	runsql.disconnect();
	
	// =====================================================
	// create record infedex
	// =====================================================
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	srvpgm.setSrvPgmName("RCI", "MOFDXADD" );
	StringBuffer sbParam = new StringBuffer();

    sbParam.append(srvpgm.setParamString(sSite, 10));
    sbParam.append(srvpgm.setParamString(sOrder, 10));
    
 	// set class and store list
    String [] sParam = new String[]{sbParam.toString()};
    int [] iPrmLng = {sbParam.toString().length()};
    srvpgm.runSrvPgmProc("SETSINGORD", sParam, iPrmLng);
    
    sParam = new String[]{ " " };
    iPrmLng = new int[]{ 1 };
    srvpgm.runSrvPgmProc("GETNEXT", sParam, iPrmLng);
    
    sParam = new String[]{ " " };
    iPrmLng = new int[]{ 32767 };
    srvpgm.runSrvPgmProc("GETORDERW", sParam, iPrmLng);
    
    out.print("<br>The Order SKUs added to the FedEx dBase.");
    
    // =====================================================
 	// ============ update store and package ===============
 	// =====================================================		
 	srvpgm = new CallAs400SrvPgmSup();
 	srvpgm.setSrvPgmName("RCI", "MOFEDEXO" ); 	
 	 	
 	sbParam = new StringBuffer();
    sbParam.append(srvpgm.setParamString(sSite, 10));
    sbParam.append(srvpgm.setParamString(sOrder, 10));
    sbParam.append(srvpgm.setParamString(sStr, 5));
    sbParam.append(srvpgm.setParamString(sPackId, 10));
     
  	// set class and store list
    sParam = new String[]{sbParam.toString()};
    iPrmLng = new int[]{sbParam.toString().length()};
    srvpgm.runSrvPgmProc("UPDPACK", sParam, iPrmLng);    
    
    out.print("<br>The Package ID added to the FedEx dBase.");
%>

<SCRIPT>
parent.alert("The FedEx dBase has been updated.");
</SCRIPT>
<%}
else {%>
<SCRIPT language="JavaScript1.2">
   alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
</SCRIPT>
<%}%>

