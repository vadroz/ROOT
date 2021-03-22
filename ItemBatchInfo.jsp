<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*
, rciutility.CallAs400SrvPgmSup"%>
<%
	String sBatch = request.getParameter("Batch");
	
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") != null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();	
	
	RunSQLStmt runsql = new RunSQLStmt();	
	
	// check if record exists
	String sStmt = "select TBBATCH,TBCOMM, char(TBCDAT, USA) as TbCDat,TBCTIM,TBCUSER,TBTRWHSE" 
	 + ",TBWHSQT,TBBSRLVL,TBPERM, TBNEVER" 
	 + ", char(TBFRLRI, usa) as TBFRLRI, char(TBTOLRI, USA) as TBTOLRI" 
	 + ", char(TBFRLSI, USA) as TBFRLSI, char(TBTOLSI, USA) as TBTOLSI"
	 + ", char(TBFRLMI, usa) as TBFRLMI, char(TBTOLMI, usa) as TBTOLMI" 
	 + ", TBDCGT0, TBMINL"   
	 + ", TBIDEAL, TBMAXL" 
	 + " from rci.ItrfBch " 
	 + " where TbBatch=" + sBatch;		
	//System.out.println(sStmt); 
		
	runsql.setPrepStmt(sStmt);		   
	runsql.runQuery();
	String sComm = "";
	String sCrtDt = "";
	String sCrtTm = "";
	String sCrtUs = "";
	String sWhsOnly = "";
	String sWhsQty = "";
	String sBsrLvl = "";
	String sPerm = "";
	String sNever = "";
	String sFrLri = "";
	String sToLri = "";
	String sFrLsi = "";
	String sToLsi = "";
	String sFrLmi = "";
	String sToLmi = "";	
	String sDcGt0 = "";
	String sMin = "";
	String sIdeal = "";
	String sMax = "";	
		
	if(runsql.readNextRecord())
	{
		sComm = runsql.getData("TBCOMM");
		sCrtDt = runsql.getData("TbCDat");
		sCrtTm = runsql.getData("TbCTim");
		sCrtUs = runsql.getData("TbCUser");
		sWhsOnly = runsql.getData("TBTRWHSE");
		sWhsQty = runsql.getData("TBWHSQT");
		sBsrLvl = runsql.getData("TBBSRLVL");
		sPerm = runsql.getData("TBPERM");
		sNever = runsql.getData("TBNEVER");
		sFrLri = runsql.getData("TBFRLRI");
		sToLri = runsql.getData("TBTOLRI");
		sFrLsi = runsql.getData("TBFRLSI");
		sToLsi = runsql.getData("TBTOLSI");
		sFrLmi = runsql.getData("TBFRLMI");
		sToLmi = runsql.getData("TBTOLMI");
		sDcGt0 = runsql.getData("TBDCGT0");
		sMin = runsql.getData("TBMINL");
		sIdeal = runsql.getData("TBIDEAL");
		sMax = runsql.getData("TBMAXL");		
	}
	runsql.disconnect();

	if(sFrLri == null){ sFrLri = " "; }
    if(sToLri == null){ sToLri = " "; }
    if(sFrLsi == null){ sFrLsi = " "; }
    if(sToLsi == null){ sToLsi = " "; }
    if(sFrLmi == null){ sFrLmi = " "; }
    if(sToLmi == null){ sToLmi = " "; }
    
    if(sWhsQty.equals("0")){ sWhsQty = "N/A"; }
    
    if(sDcGt0.equals("Y")){ sDcGt0 = "Yes"; }
    else if(sDcGt0.equals("N")){ sDcGt0 = "No"; }
    else if(sDcGt0.equals("A")){ sDcGt0 = "Default"; }
    
    if(sMin.equals("Y")){ sMin = "Yes"; }
    else if(sMin.equals("N")){ sMin = "No"; }
    else if(sMin.equals("A")){ sMin = "Default"; }
    
    if(sIdeal.equals("Y")){ sIdeal = "Yes"; }
    else if(sIdeal.equals("N")){ sIdeal = "No"; }
    else if(sIdeal.equals("A")){ sIdeal = "Default"; }
    
    if(sMax.equals("Y")){ sMax = "Yes"; }
    else if(sMax.equals("N")){ sMax = "No"; }
    else if(sMax.equals("A")){ sMax = "Default"; }
    
    if(sPerm.equals("Y")){ sPerm = "Yes"; }
    else if(sPerm.equals("N")){ sPerm = "No"; }
    else if(sPerm.equals("B")){ sPerm = "Both"; }
    
    if(sBsrLvl.equals("Y")){ sBsrLvl = "Yes"; }
    else if(sBsrLvl.equals("N")){ sBsrLvl = "No"; }
    else if(sBsrLvl.equals("B")){ sBsrLvl = "Both"; }
    
		
    String [] sAttr = new String[]{};
    String [] sAttrDs = new String[]{};
    String [] sAttrVal = new String[]{};
    String [] sAttrValDs = new String[]{};
    
    String sAttrJsa = "";
    String sAttrDsJsa = "";
    String sAttrValJsa = "";
    String sAttrValDsJsa = "";
    
    System.out.println("never=" + sNever);
    
    if(sNever.equals("Y"))
    {
    	sStmt = "select TaAttr, ATTCCTD,TaVal, ATTDDSD" 
         + " from rci.ItrfBat"
         + " inner join iptsfil.ipattct on ATTCCTI=taattr" 
         + " inner join iptsfil.ipattds on ATTDTPI=attctpi and ATTDCTI = taattr and ATTDDSI = TaVal"
         + " where TaBatch = " + sBatch + " and attctpi=3";
    	//System.out.println(sStmt);
    	
        runsql = new RunSQLStmt();	
    	runsql.setPrepStmt(sStmt);		   
    	runsql.runQuery();
    	Vector<String> vAttr = new Vector<String>();
    	Vector<String> vAttrDs = new Vector<String>();
    	Vector<String> vAttrVal = new Vector<String>();
    	Vector<String> vAttrValDs = new Vector<String>();
    	 
    	while(runsql.readNextRecord())
    	{
    		vAttr.add(runsql.getData("TaAttr"));
    		vAttrDs.add(runsql.getData("ATTCCTD"));
    		vAttrVal.add(runsql.getData("TaVal"));
    		vAttrValDs.add(runsql.getData("ATTDDSD"));
    	}
    	sAttr = vAttr.toArray(new String[vAttr.size()]);
    	sAttrDs = vAttrDs.toArray(new String[vAttrDs.size()]);
    	sAttrVal = vAttrVal.toArray(new String[vAttrVal.size()]);
    	sAttrValDs = vAttrValDs.toArray(new String[vAttrValDs.size()]);
    	
    	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
    	sAttrJsa = srvpgm.cvtToJavaScriptArray(sAttr);
    	sAttrDsJsa = srvpgm.cvtToJavaScriptArray(sAttrDs);
    	sAttrValJsa = srvpgm.cvtToJavaScriptArray(sAttrVal);
    	sAttrValDsJsa = srvpgm.cvtToJavaScriptArray(sAttrValDs);
    }
    
%>
<html>
<SCRIPT>
var attr = [<%=sAttrJsa%>];
var attrDs = [<%=sAttrDsJsa%>];
var val = [<%=sAttrValJsa%>];
var valDs = [<%=sAttrValDsJsa%>];

parent.setBatchInfo("<%=sComm%>","<%=sCrtDt%>","<%=sCrtTm%>","<%=sCrtUs%>","<%=sWhsOnly%>","<%=sWhsQty%>"
	,"<%=sBsrLvl%>","<%=sPerm%>","<%=sNever%>","<%=sFrLri%>","<%=sToLri%>","<%=sFrLsi%>","<%=sToLsi%>"
	,"<%=sFrLmi%>","<%=sToLmi%>","<%=sDcGt0%>","<%=sMin%>","<%=sIdeal%>","<%=sMax%>"
	, attr, attrDs, val, valDs);
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