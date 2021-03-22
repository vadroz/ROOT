<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
   String sCtl = request.getParameter("Ctl"); 
   String sItemId = request.getParameter("Item");
   String sAction = request.getParameter("Action");
   String [] sSelType = request.getParameterValues("Type");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	Vector<String> vCommId = new Vector<String>();
	Vector<String> vLine = new Vector<String>();
	Vector<String> vType = new Vector<String>();
	Vector<String> vCommt = new Vector<String>();
	Vector<String> vRecUsr = new Vector<String>();
	Vector<String> vRecDt = new Vector<String>();
	Vector<String> vRecTm = new Vector<String>();
	
	Vector<String> vItem = new Vector<String>();
	Vector<String> vSku = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
	Vector<String> vVenSty = new Vector<String>();
	Vector<String> vReas = new Vector<String>();
	
	Vector<String> vFile = new Vector<String>();
	
	String sCommId = "";
	String sLine = "";
	String sType = "";
	String sCommt = "";
	String sRecUsr = "";
	String sRecDt = "";
	String sRecTm = "";
	
	String sItem = "";
	String sSku = "";
	String sDesc = "";
	String sVenSty = "";
	String sReas = "";
	String sFile = "";
	
	if(sAction.equals("Hdr_Comment"))
	{	
   		String sPrepStmt = "select MCCTLID,MCCOMMID,MCLINE,MCTYPE,MCCOMM,MCRECUS,MCRECDT,MCRECTM"   	 	
   	 	+ " from rci.MkHdrCom"
   	 	+ " where McCtlId=" + sCtl;
   		sPrepStmt += " order by McCommId, McLine";
   	
   		//System.out.println("header Comments\n" + sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		
   	 	while(runsql.readNextRecord())
   		{
   	 		vCommId.add(runsql.getData("McCommId"));
   			vLine.add(runsql.getData("McLine"));
   			vType.add(runsql.getData("McType"));
   			
   			String commt = runsql.getData("McComm");
   			
   			commt = commt.replaceAll("'", "&#39;");
   			vCommt.add(commt);
   			vRecUsr.add(runsql.getData("McRecUs"));
   			vRecDt.add(runsql.getData("McRecDt"));
   			vRecTm.add(runsql.getData("McRecTm"));
   		}
    
   	    runsql.disconnect();
   		runsql = null;
	}	
	else if(sAction.equals("Itm_Comment"))
	{	
   		String sPrepStmt = "select MPCOMMID,MPCTLID,MPITEMID,MPLINE,MPTYPE,MPCOMM" 
	    + ",MPRECUS,MPRECDT,MPRECTM"
	    + ",MISKU, ides, ivst, MpEmp, ename, MIREAS"	    
   	 	+ " from rci.MKITMCOM c inner join rci.MkItem i on i.item_id=c.item_id"
   	 	+ " inner join IpTsFil.IpItHDr on isku=misku"
   	    + " left join rci.rciemp on MiEmp=erci"
   	 	+ " where MPCtlId=" + sCtl
   	 	;   	 	

   		if(sSelType != null)
   		{
   			String sComa = "";
   			sPrepStmt += " and MpType in (";
   			for(int i=0; i < sSelType.length; i++)
   			{ 
   				sPrepStmt += sComa + "'" + sSelType[i] + "'"; 
   				sComa = ","; 
   			}   			
   			sPrepStmt += ")";
   		}
   	 	
   		sPrepStmt += " order by MPITEMID, MpCommId, MpLine";
   	
   		//System.out.println(sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		   
   	 	while(runsql.readNextRecord())
   		{
   			vCommId.add(runsql.getData("MpCommId"));
   			vLine.add(runsql.getData("MpLine"));
   			vType.add(runsql.getData("MpType"));
   			
   			String commt = runsql.getData("MpComm");
   			//commt = commt.replaceAll("'", "&quote;");
   			vCommt.add(commt);
   			
   			String sEmp = runsql.getData("MpEmp");
   			if(sEmp.equals("0")){vRecUsr.add(runsql.getData("MpRecUs"));}
   			else
   			{
   				String sEmpNm = runsql.getData("ename");
    			vRecUsr.add( runsql.getData("MpRecUs") + "(" + sEmp + " " + sEmpNm + ")");	
   			}
   			
   			vRecDt.add(runsql.getData("MpRecDt"));
   			vRecTm.add(runsql.getData("MpRecTm"));
   			
   			vItem.add(runsql.getData("MpItemId"));
   			vSku.add(runsql.getData("MiSku"));
   			
   			String desc = runsql.getData("ides");
   			desc = desc.replaceAll("'", "&quote;");
   			vDesc.add(desc);
   			
   			String vensty = runsql.getData("ivst");
   			vensty = vensty.replaceAll("'", "&quote;");
   			vVenSty.add(vensty);
   			
   			vReas.add(runsql.getData("MiReas"));
   		}    
    	
    	runsql.disconnect();
   		runsql = null;
	}
	else if(sAction.equals("Itm_First_Not_Auto_Comment"))
	{	
   		String sPrepStmt = "select MPCOMMID,MPCTLID,MPITEMID,MPLINE,MPTYPE,MPCOMM" 
	    + ",MPRECUS,MPRECDT,MPRECTM"
	    + ",MISKU, ides, ivst, MpEmp, ename, MiReas"
   	 	+ " from rci.MKITMCOM c inner join rci.MkItem i on i.item_id=c.item_id"
   	 	+ " inner join IpTsFil.IpItHDr on isku=misku"
   	    + " left join rci.rciemp on MiEmp=erci"
   	 	+ " where MPCtlId=" + sCtl + " and MpType='User' and MpItemId=" + sItemId
   	 	+ " order by MPITEMID, MpCommId, MpLine"
   	 	+ " fetch first 1 rows only";
   	
   		//System.out.println("Itm_First_Not_Auto_Comment\n" + sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		   
   	 	while(runsql.readNextRecord())
   		{
   			vCommId.add(runsql.getData("MpCommId"));
   			vLine.add(runsql.getData("MpLine"));
   			vType.add(runsql.getData("MpType"));
   			
   			String commt = runsql.getData("MpComm");
   			//commt = commt.replaceAll("'", "&quote;");
   			vCommt.add(commt);
   			
   			String sEmp = runsql.getData("MpEmp");
   			if(sEmp.equals("0")){vRecUsr.add(runsql.getData("MpRecUs"));}
   			else
   			{
   				String sEmpNm = runsql.getData("ename");
    			vRecUsr.add( runsql.getData("MpRecUs") + "(" + sEmp + " " + sEmpNm + ")");	
   			}
   			
   			vRecDt.add(runsql.getData("MpRecDt"));
   			vRecTm.add(runsql.getData("MpRecTm"));
   			
   			vItem.add(runsql.getData("MpItemId"));
   			vSku.add(runsql.getData("MiSku"));
   			
   			String desc = runsql.getData("ides");
   			desc = desc.replaceAll("'", "&quote;");
   			vDesc.add(desc);
   			
   			String vensty = runsql.getData("ivst");
   			vensty = vensty.replaceAll("'", "&quote;");
   			vVenSty.add(vensty);
   			
   			vReas.add(runsql.getData("MiReas"));
   		}    
    	
    	runsql.disconnect();
   		runsql = null;
	}
	else if(sAction.equals("Itm_Photo"))
	{	
   		String sPrepStmt = "select MFCTLID,MFITEMID,MFFILE,MFRECUS,MFRECDT,MFRECTM"
	    + ",MISKU, ides, ivst, MiReas"
   	 	+ " from rci.MkITMPIC c inner join rci.MkItem i on i.item_id=c.item_id"
   	    + " inner join IpTsFil.IpItHDr on isku=misku"
   	 	+ " where MFCtlId=" + sCtl
   	 	+ " order by MFITEMID, MFFile";
   	
   		//System.out.println(sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		   
   	 	while(runsql.readNextRecord())
   		{
   	 		vItem.add(runsql.getData("MfItemId"));
   			vFile.add(runsql.getData("MfFile"));
   			vRecUsr.add(runsql.getData("MfRecUs"));
   			vRecDt.add(runsql.getData("MfRecDt"));
   			vRecTm.add(runsql.getData("MfRecTm"));
   			
   			vSku.add(runsql.getData("MiSku"));
   			
   			String desc = runsql.getData("ides");
   			desc = desc.replaceAll("'", "&quote;");
   			vDesc.add(desc);
   			
   			String vensty = runsql.getData("ivst");
   			vensty = vensty.replaceAll("'", "&quote;");
   			vVenSty.add(vensty);
   			vReas.add(runsql.getData("MiReas"));
   		}    
    	
    	runsql.disconnect();
   		runsql = null;
	}
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	sCommId = srvpgm.cvtToJavaScriptArray(vCommId.toArray(new String[]{}));
	sLine = srvpgm.cvtToJavaScriptArray(vLine.toArray(new String[]{}));
	sType = srvpgm.cvtToJavaScriptArray(vType.toArray(new String[]{}));
	sCommt = srvpgm.cvtToJavaScriptArray(vCommt.toArray(new String[]{}));
	sRecUsr = srvpgm.cvtToJavaScriptArray(vRecUsr.toArray(new String[]{}));
	sRecDt = srvpgm.cvtToJavaScriptArray(vRecDt.toArray(new String[]{}));
	sRecTm = srvpgm.cvtToJavaScriptArray(vRecTm.toArray(new String[]{}));
	
	if(sAction.equals("Itm_Comment"))
	{
		sItem = srvpgm.cvtToJavaScriptArray(vItem.toArray(new String[]{}));
		sSku = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[]{}));
		sDesc = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[]{}));
		sVenSty = srvpgm.cvtToJavaScriptArray(vVenSty.toArray(new String[]{}));
		sReas = srvpgm.cvtToJavaScriptArray(vReas.toArray(new String[]{}));
	}
	
	if(sAction.equals("Itm_Photo"))
	{
		sItem = srvpgm.cvtToJavaScriptArray(vItem.toArray(new String[]{}));
		sSku = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[]{}));
		sDesc = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[]{}));
		sVenSty = srvpgm.cvtToJavaScriptArray(vVenSty.toArray(new String[]{}));
		sFile = srvpgm.cvtToJavaScriptArray(vFile.toArray(new String[]{}));
	}
	
%>
<html>  
<SCRIPT>
var action = "<%=sAction%>";
var commid = [<%=sCommId%>];
var line = [<%=sLine%>];
var type = [<%=sType%>];
var commt = [<%=sCommt%>];
var recusr = [<%=sRecUsr%>];
var recdt = [<%=sRecDt%>];
var rectm = [<%=sRecTm%>];

var item = [<%=sItem%>];
var sku = [<%=sSku%>];
var desc = [<%=sDesc%>];
var vensty = [<%=sVenSty%>];
var reas = [<%=sReas%>];
var pic = [<%=sFile%>];

if(action == "Hdr_Comment")
{
	parent.setCtlComments(commid, line, type, commt, recusr, recdt, rectm);
}
else if(action == "Itm_Comment")
{
	parent.setItemComments(commid, line, type, commt, recusr, recdt, rectm, item, sku
			, desc, vensty, reas);
}
else if(action == "Itm_First_Not_Auto_Comment")
{
	parent.set1stItemComments(commid, line, type, commt, recusr, recdt, rectm, item, sku, desc, vensty);
}
else if(action == "Itm_Photo")
{
	parent.setPictures(item, pic, recusr, recdt, rectm, item, sku, desc, vensty);
}
</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>