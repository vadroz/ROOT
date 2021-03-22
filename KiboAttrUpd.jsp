<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup
, rciutility.ConnDataQueueObject, java.util.*
, java.text.*, java.io.*, java.math.*, java.sql.*"%>
<%
	String sSite = request.getParameter("Site");
	String sAttr = request.getParameter("Attr");	
	String sAttrOpt =  request.getParameter("AttrOpt");
	String sAttrType = request.getParameter("AttrType");
	String sAttrIsProp = request.getParameter("AttrIsProp");
	String sProdTypeId = request.getParameter("ProdTypeId");
	String sProdType = request.getParameter("ProdType");  
	String sAction = request.getParameter("Action");
	String sUser = request.getParameter("User");
	
	
	String [] sArrAttr =  request.getParameterValues("arrAttr");
	String [] sArrAttrOpt =  request.getParameterValues("arrAttrOpt");
	String [] sArrProdTyId =  request.getParameterValues("arrProdTypeId");
	String [] sArrProdTy =  request.getParameterValues("arrProdType");
	
	if(sAttr==null){sAttr = " ";}
	if(sAttrType==null){sAttrType = " ";}
	if(sAttrIsProp==null){sAttrIsProp = " ";}
	
	// replace string on special characters
	System.out.println("sAttrOpt=" + sAttrOpt);
	if(sAttrOpt != null)
	{
		sAttrOpt = sAttrOpt.replaceAll("XXXPLUSXXX", "+");				
		sAttrOpt = sAttrOpt.replaceAll("XXXFOOTXXX", "'");
		sAttrOpt = sAttrOpt.replaceAll("XXXINCHXXX", "\"");
		sAttrOpt = sAttrOpt.replaceAll("XXXANDXXX", "&");
	}
	
	if(sArrAttrOpt != null)
	{
		for(int i=0; i < sArrAttrOpt.length; i++)
		{
			sArrAttrOpt[i] = sArrAttrOpt[i].replaceAll("XXXPLUSXXX", "+");				
			sArrAttrOpt[i] = sArrAttrOpt[i].replaceAll("XXXFOOTXXX", "'");
			sArrAttrOpt[i] = sArrAttrOpt[i].replaceAll("XXXINCHXXX", "\"");
			sArrAttrOpt[i] = sArrAttrOpt[i].replaceAll("XXXANDXXX", "&");
		}
	}
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
	String sStmt = null;
	RunSQLStmt runsql = null;
	ResultSet rs = null;
	
	String sOpt = "";
	String sOptVal = "";
	String sPtAttr = "";
	String sPtAttrFQN = "";
	String sPtAttrCnt = "";
	
	Vector<String> vOpt = new Vector<String>();
	Vector<String> vOptVal = new Vector<String>();
	Vector<String> vPtAttr = new Vector<String>();
	Vector<String> vPtAttrFQN = new Vector<String>();
	Vector<String> vPtAttrCnt = new Vector<String>();
	
	if(sAction.equals("GetAttrList"))
	{
		sStmt = "select PAOPT, PAVAL" 
			+ " from rci.MOATTR"
     		+ " where pasite='" + sSite + "'"
     		+ " and PAFQN='" + sAttr + "'"
     		+ " order by PAOPT"
    	;
    	System.out.println(sStmt);
    
    	runsql = new RunSQLStmt();
    	runsql.setPrepStmt(sStmt);
    	rs = runsql.runQuery();	
 		int i=0;
 			
 		while(runsql.readNextRecord())
 		{
 			i++;
 			vOpt.add(runsql.getData("PAOPT").trim());
 			vOptVal.add(runsql.getData("PAVAL").trim());
 		} 			
 		sOpt = srvpgm.cvtToJavaScriptArray(vOpt.toArray(new String[vOpt.size()])); 
 		sOptVal = srvpgm.cvtToJavaScriptArray(vOptVal.toArray(new String[vOptVal.size()]));
	}
	
	
	// get attribute that is attached to product type 
	else if(sAction.equals("GetPtAttrList"))
	{
		sStmt = "select PhATTR as attrFqn"
		 + ", max((select paattr from rci.moattrh where phsite=pasite and phattr = pafqn group by paattr)) as attrnm" 
		 + ", max((select count(*) from rci.moptatr where pcsite=phsite and pcattr = phattr and PcTYID = PhTYID  group by pcattr)) as num_opt" 
		 + " from rci.MOPTATRh" 
		 + " where phsite ='" + sSite + "' and PhTYID = " + sProdTypeId
		 + " group by phattr"
    	;
    	System.out.println(sStmt);
    
    	runsql = new RunSQLStmt();
    	runsql.setPrepStmt(sStmt);
    	rs = runsql.runQuery();	
 		int i=0;
 				
 		while(runsql.readNextRecord())
 		{
 			i++;
 			
 			String sAttrNm = runsql.getData("attrnm");
 			if(sAttrNm == null){ sAttrNm = ""; }
 			vPtAttr.add(sAttrNm.trim());
 			
 			vPtAttrFQN.add(runsql.getData("attrFqn").trim());
 			
 			String sNumOpt = runsql.getData("num_opt");
 			if(sNumOpt == null){ sNumOpt = "0"; }
 			vPtAttrCnt.add(sNumOpt.trim());
 		} 			
 		sPtAttr = srvpgm.cvtToJavaScriptArray(vPtAttr.toArray(new String[vPtAttr.size()]));
 		sPtAttrFQN = srvpgm.cvtToJavaScriptArray(vPtAttrFQN.toArray(new String[vPtAttrFQN.size()]));
 		sPtAttrCnt = srvpgm.cvtToJavaScriptArray(vPtAttrCnt.toArray(new String[vPtAttrCnt.size()]));
	}
	
	// get attribute that is attached to product type 
	else if(sAction.equals("GetPtAttrOptList"))
	{
		sStmt = "select PCOPT,PCVAL"
		 + " from rci.MOPTATR" 
		 + " where pcsite ='" + sSite + "' and PCTYID = " + sProdTypeId
		 + " and pcattr = '" + sAttr + "'"
		;
	    System.out.println(sStmt);
	    
	   	runsql = new RunSQLStmt();
	   	runsql.setPrepStmt(sStmt);
	   	rs = runsql.runQuery();	
	 	int i=0;
	 				
	 	while(runsql.readNextRecord())
	 	{
	 		i++;
	 		vOpt.add(runsql.getData("pcopt").trim());
	 		vOptVal.add(runsql.getData("pcval").trim());
	 	} 			
	 	sOpt = srvpgm.cvtToJavaScriptArray(vOpt.toArray(new String[vOpt.size()]));
		sOptVal = srvpgm.cvtToJavaScriptArray(vOptVal.toArray(new String[vOptVal.size()]));
	}
		
	
	// create new attribute
	else if(sAction.equals("SaveNewAttr") || sAction.equals("DltAttr"))
	{
		ConnDataQueueObject dqParent  = new ConnDataQueueObject("TMPLIB","MONEWATR");	;
		 
		StringBuffer sbParam = new StringBuffer();
		
	    sbParam.append(srvpgm.setParamString(sSite, 10));
	    sbParam.append(srvpgm.setParamString("5", 1));
	    sbParam.append(srvpgm.setParamString(sAttr, 50));   
	    sbParam.append(srvpgm.setParamString(sAttrType, 20));
	    sbParam.append(srvpgm.setParamString(sAttrIsProp, 1));
	    sbParam.append(srvpgm.setParamString(sAction, 20));
	    sbParam.append(srvpgm.setParamString(sUser, 10));
	    
		dqParent.write(sbParam.toString());		
	}
	
	// add new option to attribute
	else if(sAction.equals("SaveNewAttrOpt") || sAction.equals("DltAttrOpt"))
	{
		System.out.println("Sending for SaveNewAttrOpt");
		ConnDataQueueObject dqParent  = new ConnDataQueueObject("TMPLIB","MONEWATR");	;
		 
		StringBuffer sbParam = new StringBuffer();
		
	    sbParam.append(srvpgm.setParamString(sSite, 10));
	    sbParam.append(srvpgm.setParamString("6", 1));
	    sbParam.append(srvpgm.setParamString(sAttr, 50));   
	    sbParam.append(srvpgm.setParamString(sAttrOpt, 100));
	    sbParam.append(srvpgm.setParamString(sAction, 20));
	    sbParam.append(srvpgm.setParamString(sUser, 10));
	    
		dqParent.write(sbParam.toString());		
	}	
	
	// attach attribute and option to product type
	else if(sAction.equals("SavePtAttrOpt"))
	{
		ConnDataQueueObject dqParent  = new ConnDataQueueObject("TMPLIB","MONEWATR");	;
		 
		for(int i=0; i < sArrProdTyId.length; i++)
		{
			for(int j=0; j < sArrAttrOpt.length; j++)
			{
				StringBuffer sbParam = new StringBuffer();
		
	    		sbParam.append(srvpgm.setParamString(sSite, 10));
	    		sbParam.append(srvpgm.setParamString("7", 1));
	    		sbParam.append(srvpgm.setParamString(sArrAttr[j], 50));   
		    	sbParam.append(srvpgm.setParamString(sArrAttrOpt[j], 100));
		    	sbParam.append(srvpgm.setParamString(sArrProdTyId[i], 5));   
		    	sbParam.append(srvpgm.setParamString(sArrProdTy[i], 50));
	    		sbParam.append(srvpgm.setParamString(sAction, 20));
	    		sbParam.append(srvpgm.setParamString(sUser, 10));
	    		
	    		
				dqParent.write(sbParam.toString());
			}
		}
	}
	
	else if(sAction.equals("DltPtAttrOpt"))
	{
		ConnDataQueueObject dqParent  = new ConnDataQueueObject("TMPLIB","MONEWATR");	;
		
		StringBuffer sbParam = new StringBuffer();
		
		sbParam.append(srvpgm.setParamString(sSite, 10));
	    sbParam.append(srvpgm.setParamString("7", 1));
	    sbParam.append(srvpgm.setParamString(sAttr, 50));   
		sbParam.append(srvpgm.setParamString(sAttrOpt, 100));
		sbParam.append(srvpgm.setParamString(sProdTypeId, 5));   
		sbParam.append(srvpgm.setParamString(sProdType, 50));
	    sbParam.append(srvpgm.setParamString(sAction, 20));
	    sbParam.append(srvpgm.setParamString(sUser, 10));
	    		
		dqParent.write(sbParam.toString());
	}
	
	else if(sAction.equals("DltPtAttr"))
	{
		ConnDataQueueObject dqParent  = new ConnDataQueueObject("TMPLIB","MONEWATR");	;
		
		StringBuffer sbParam = new StringBuffer();
		
		sbParam.append(srvpgm.setParamString(sSite, 10));
	    sbParam.append(srvpgm.setParamString("8", 1));
	    sbParam.append(srvpgm.setParamString(sAttr, 50));   
		sbParam.append(srvpgm.setParamString(sProdTypeId, 5));   
		sbParam.append(srvpgm.setParamString(sProdType, 50));
	    sbParam.append(srvpgm.setParamString(sAction, 20));
	    sbParam.append(srvpgm.setParamString(sUser, 10));
	    		
		dqParent.write(sbParam.toString());
	}
%>
<body>
<table>
 <%for(int i=0; i < vOpt.size(); i++){%>
   <tr><td id="tdOpt<%=i%>"><%=vOpt.get(i)%></td></tr>
 <%}%>
 
 <%for(int i=0; i < vOptVal.size(); i++){%>
   <tr><td id="tdOptVal<%=i%>"><%=vOptVal.get(i)%></td></tr>
 <%}%>
 
 <%for(int i=0; i < vPtAttr.size(); i++){%>
   <tr>
   		<td id="tdPtAttr<%=i%>"><%=vPtAttr.get(i)%></td>
   		<td id="tdPtAttrFQN<%=i%>"><%=vPtAttrFQN.get(i)%></td>
   		<td id="tdPtAttrCnt<%=i%>"><%=vPtAttrCnt.get(i)%></td>
   </tr>
 <%}%>
 
</table>

</body>

<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>"

var opt =  new Array();
var NumOfOpt = "<%=vOpt.size()%>";
for(var i=0; i < NumOfOpt; i++){ opt[i] = document.getElementById("tdOpt" + i).innerHTML; }

var optval =  new Array();
var NumOfOptVal = "<%=vOptVal.size()%>";
for(var i=0; i < NumOfOptVal; i++){ optval[i] = document.getElementById("tdOptVal" + i).innerHTML; }

var ptattr =  new Array();
var ptattrFqn =  new Array();
var ptattrCnt =  new Array();

var NumOfPtAttr = "<%=vPtAttr.size()%>";
for(var i=0; i < NumOfPtAttr; i++)
{ 
	ptattr[i] = document.getElementById("tdPtAttr" + i).innerHTML;
	ptattrFqn[i] = document.getElementById("tdPtAttrFQN" + i).innerHTML;
	ptattrCnt[i] = document.getElementById("tdPtAttrCnt" + i).innerHTML;
}

if( Action == "GetAttrList" ){ parent.showAttrVal(opt, optval); }
else if( Action == "GetPtAttrList" ){ parent.showPtAttr(ptattr, ptattrFqn, ptattrCnt); }
else if( Action == "GetPtAttrOptList" ){ parent.showPtAttrOpt(opt, optval); }
else if( Action == "SaveNewAttr" ){ parent.restart(); }
else if( Action == "DltAttr" ){ parent.restart(); }
else if( Action == "SaveNewAttrOpt" ){ parent.restart(); }
else if( Action == "SavePtAttrOpt" ){ parent.restart(); }
else if( Action == "SavePtAttr" ){ parent.restart(); }
else if( Action == "DltAttrOpt" ){ parent.restart(); }
else if( Action == "DltPtAttrOpt" ){ parent.restart(); }
else if( Action == "DltPtAttr" ){ parent.restart(); }

</SCRIPT>


