<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
   String sCtl = request.getParameter("Ctl"); 
   String sAction = request.getParameter("Action"); 
   
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
	Vector<String> vHide = new Vector<String>();
	Vector<String> vRecUsr = new Vector<String>();
	Vector<String> vRecDt = new Vector<String>();
	Vector<String> vRecTm = new Vector<String>();
	
	Vector<String> vItem = new Vector<String>();
	Vector<String> vSku = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
	Vector<String> vVenSty = new Vector<String>();
	
	Vector<String> vFile = new Vector<String>();
	
	String sCommId = "";
	String sLine = "";
	String sType = "";
	String sCommt = "";
	String sHide = "";
	String sRecUsr = "";
	String sRecDt = "";
	String sRecTm = "";
	
	String sItem = "";
	String sSku = "";
	String sDesc = "";
	String sVenSty = "";
	String sFile = "";
	
	if(sAction.equals("Hdr_Comment"))
	{	
   		String sPrepStmt = "select RCCTLID,RCCOMMID,RCLINE,RCTYPE,RCCOMM,RCHIDE,RCRECUS,RCRECDT,RCRECTM"   	 	
   	 	+ " from rci.RvHdrCom"
   	 	+ " where RcCtlId=" + sCtl
   	 	+ " order by RcCommId, RcLine";
   	
   		//System.out.println(sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		
   	 	while(runsql.readNextRecord())
   		{
   	 		vCommId.add(runsql.getData("RcCommId"));
   			vLine.add(runsql.getData("RcLine"));
   			vType.add(runsql.getData("RcType"));
   			
   			String commt = runsql.getData("RcComm");
   			//commt = commt.replaceAll("'", "&quote;");
   			vCommt.add(commt);
   			vHide.add(runsql.getData("RcHide"));
   			vRecUsr.add(runsql.getData("RcRecUs"));
   			vRecDt.add(runsql.getData("RcRecDt"));
   			vRecTm.add(runsql.getData("RcRecTm"));
   		}
    
   	    runsql.disconnect();
   		runsql = null;
	}	
	else if(sAction.equals("Itm_Comment"))
	{	
   		String sPrepStmt = "select RPCOMMID,RPCTLID,RPITEMID,RPLINE,RPTYPE,RPCOMM" 
	    + ",RPHIDE,RPRECUS,RPRECDT,RPRECTM "
	    + ",RISKU, ides, ivst"
   	 	+ " from rci.RVITMCOM c inner join rci.RvItem i on i.item_id=c.item_id"
   	    + " inner join IpTsFil.IpItHDr on isku=risku"
   	 	+ " where RPCtlId=" + sCtl
   	 	+ " order by RPITEMID, RpCommId, RpLine";
   	
   		System.out.println(sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		   
   	 	while(runsql.readNextRecord())
   		{
   			vCommId.add(runsql.getData("RpCommId"));
   			vLine.add(runsql.getData("RpLine"));
   			vType.add(runsql.getData("RpType"));
   			
   			String commt = runsql.getData("RpComm");
   			//commt = commt.replaceAll("'", "&quote;");
   			vCommt.add(commt);
   			vHide.add(runsql.getData("RpHide"));
   			vRecUsr.add(runsql.getData("RpRecUs"));
   			vRecDt.add(runsql.getData("RpRecDt"));
   			vRecTm.add(runsql.getData("RpRecTm"));
   			
   			vItem.add(runsql.getData("RpItemId"));
   			vSku.add(runsql.getData("RiSku"));
   			
   			String desc = runsql.getData("ides");
   			desc = desc.replaceAll("'", "&quote;");
   			vDesc.add(desc);
   			
   			String vensty = runsql.getData("ivst");
   			vensty = vensty.replaceAll("'", "&quote;");
   			vVenSty.add(vensty);
   		}    
    	
    	runsql.disconnect();
   		runsql = null;
	}	
	else if(sAction.equals("Itm_Photo"))
	{	
   		String sPrepStmt = "select RFCTLID,RFITEMID,RFFILE,RFRECUS,RFRECDT,RFRECTM"
	    + ",RISKU, ides, ivst"
   	 	+ " from rci.RVITMPIC c inner join rci.RvItem i on i.item_id=c.item_id"
   	    + " inner join IpTsFil.IpItHDr on isku=risku"
   	 	+ " where RFCtlId=" + sCtl
   	 	+ " order by RFITEMID, RFFile";
   	
   		//System.out.println(sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		   
   	 	while(runsql.readNextRecord())
   		{
   	 		vItem.add(runsql.getData("RfItemId"));
   			vFile.add(runsql.getData("RfFile"));
   			vRecUsr.add(runsql.getData("RfRecUs"));
   			vRecDt.add(runsql.getData("RfRecDt"));
   			vRecTm.add(runsql.getData("RfRecTm"));
   			
   			vSku.add(runsql.getData("RiSku"));
   			
   			String desc = runsql.getData("ides");
   			desc = desc.replaceAll("'", "&quote;");
   			vDesc.add(desc);
   			
   			String vensty = runsql.getData("ivst");
   			vensty = vensty.replaceAll("'", "&quote;");
   			vVenSty.add(vensty);
   		}    
    	
    	runsql.disconnect();
   		runsql = null;
	}
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	sCommId = srvpgm.cvtToJavaScriptArray(vCommId.toArray(new String[]{}));
	sLine = srvpgm.cvtToJavaScriptArray(vLine.toArray(new String[]{}));
	sType = srvpgm.cvtToJavaScriptArray(vType.toArray(new String[]{}));
	sCommt = srvpgm.cvtToJavaScriptArray(vCommt.toArray(new String[]{}));
	sHide = srvpgm.cvtToJavaScriptArray(vHide.toArray(new String[]{}));
	sRecUsr = srvpgm.cvtToJavaScriptArray(vRecUsr.toArray(new String[]{}));
	sRecDt = srvpgm.cvtToJavaScriptArray(vRecDt.toArray(new String[]{}));
	sRecTm = srvpgm.cvtToJavaScriptArray(vRecTm.toArray(new String[]{}));
	
	if(sAction.equals("Itm_Comment"))
	{
		sItem = srvpgm.cvtToJavaScriptArray(vItem.toArray(new String[]{}));
		sSku = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[]{}));
		sDesc = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[]{}));
		sVenSty = srvpgm.cvtToJavaScriptArray(vVenSty.toArray(new String[]{}));
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
var hide = [<%=sHide%>];
var recusr = [<%=sRecUsr%>];
var recdt = [<%=sRecDt%>];
var rectm = [<%=sRecTm%>];

var item = [<%=sItem%>];
var sku = [<%=sSku%>];
var desc = [<%=sDesc%>];
var vensty = [<%=sVenSty%>];
var pic = [<%=sFile%>];

if(action == "Hdr_Comment")
{
	parent.setCtlComments(commid, line, type, commt, hide, recusr, recdt, rectm);
}
else if(action == "Itm_Comment")
{
	parent.setItemComments(commid, line, type, commt, hide, recusr, recdt, rectm, item, sku, desc, vensty);
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