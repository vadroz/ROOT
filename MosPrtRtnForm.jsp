<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*
, java.util.*, rciutility.CallAs400SrvPgmSup, rciutility.BarcodeGen, java.text.*, java.io.*"%>
<%
   String sCtl = request.getParameter("Ctl"); 
   String sItem = request.getParameter("Item");
   
   String sAction = request.getParameter("Action"); 
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	String sSku = "";	
	String sDate = "";
	String sStr = "";
	String sVenNm = "";
	String sVenSty = "";
	String sClrNm = "";
	String sSizNm = "";
	String sVen = "";
	String sUpd = "";
	String sDesc = "";
		
   	String sPrepStmt = "select MiCTLID,MhStr,MiITEMID,MISKU, char(MIRECDT, USA) as date" 
	    + ", ides, ivst, vnam, clrn, snam, iven, ides, igtin"
	    + ", (select max(ugtin) from IpTsFil.IPUPCXF where iCls=uCls and iVen = uVen" 
	    + " and iSty = uSty and iClr = uClr and iSiz = uSiz"              
	    + " and substr(ugtin,1,1) <> '4' ) as ugtin"
   	 	+ " from rci.MkItem i"
   	 	+ " inner join Rci.MkHdr on MhCtlId=MiCtlId"
   	    + " inner join IpTsFil.IpItHDr on isku=misku"
   	    + " inner join IpTsFil.IpMrVen on vven=iven"
   	    + " inner join IpTsFil.IpColor on cclr=iclr"
   	    + " inner join IpTsFil.IpSizes on ssiz=isiz"   	    
   	 	+ " where MiCtlId=" + sCtl
   	    + " and MiItemId=" + sItem
   	 	;
   	//System.out.println(sPrepStmt);
   	
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sPrepStmt);		   
   	runsql.runQuery();
   	
   	if(runsql.readNextRecord())
   	{
   		sSku = runsql.getData("MiSku").trim();   		
   		sDate = runsql.getData("date").trim();
   		sStr = runsql.getData("MhStr").trim();
   		sVenNm = runsql.getData("vnam").trim();
   		sVenSty = runsql.getData("ivst").trim();
   		sClrNm = runsql.getData("clrn").trim();
   		sSizNm = runsql.getData("snam").trim();
   		sVen = runsql.getData("iven").trim();
   		
   		if(runsql.getData("ugtin") != null) { sUpd = runsql.getData("ugtin"); }
   		else { sUpd = runsql.getData("igtin"); }
   		
   		sDesc = runsql.getData("ides").trim();
   	}    
    	
    runsql.disconnect();
   	runsql = null; 
   
   	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   	
   	String sBcStr = sStr;
   	while(sBcStr.length() < 3){ sBcStr = "0" + sBcStr; }
   	String sBcCtl = sCtl;
   	while(sBcCtl.length() < 5){ sBcCtl = "0" + sBcCtl; }
   	String sCtlBarcode = sBcStr + sBcCtl + "099";
   	
   	try
    {
      String sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Defective Item Barcode/Control/" + sCtlBarcode + ".png";
      File f = new File(sFilePath);
      // not exists - generate picture
      if(!f.exists())
      {
         BarcodeGen bargen = new BarcodeGen();
         bargen.outputtingBarcodeAsPNG(sCtlBarcode, sFilePath);
      }
    }
    catch (Exception e) { System.out.println(e.getMessage()); }
   	
   	
   	try
    {
   		String sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Defective Item Barcode/Sku/" + sSku + ".png";
        File f = new File(sFilePath);
        // not exists - generate picture
        if(!f.exists())
        {
           BarcodeGen bargen = new BarcodeGen();
           bargen.outputtingBarcodeAsPNG(sSku, sFilePath);
        }
    }
    catch (Exception e) { System.out.println(e.getMessage()); }
%>
<html>  

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<SCRIPT>
//==============================================================================
//initialize process
//==============================================================================
function bodyLoad()
{
	myTable = document.getElementById("tbl01");
    myClone = myTable.cloneNode(true);
    document.body.appendChild(myClone); 
}
</SCRIPT>
<body onload="bodyLoad()">
<table class=tbl03  width=100% id="tbl01">
  <tr class="trHdr14">
    <td style="background: white;"  colspan=2><u>Defective Item(s) - Return to #99</u></td>
  </tr>
     
  <tr class="trDtl22">
    <td class="td48"  colspan=2>    
      <table width=100%>
         <tr class="trDtl22">
           <td class="td50" colspan=3><br><img width=200 src="/Defective Item Barcode/Control/<%=sCtlBarcode%>.png"></td>
           <td class="td48" width="20%">Str: <u><%=sStr%></u></td>
           <td class="td48" width="25%">Control#: <u><%=sCtl%></u></td>
           <td class="td48" width="25%">Date: <u><%=sDate%></u></td>
         </tr>
      </table>  
            
      <table width=100% border=0 cellSpacing="0" id="tblItmCommt">
         <tr class="trDtl23">
           <td class="td48" style="border-top:black solid 1px;border-bottom:black solid 1px;">Vendor:</td>
           <td class="td48"  style="border-top:black solid 1px;border-bottom:black solid 1px;" colspan=3> <b><u><%=sVen%></u> - <%=sVenNm%></b></td>
         </tr>
         <tr class="trDtl22"><td class="td48" width="20%">&nbsp;</td></tr>  
         <tr class="trDtl22">
           <td class="td48" width="20%">UPC:</td>
           <td class="td48" width="30%"><u><%=sUpd%></u></td>
           <td class="td48" width="20%">SKU:</td>
           <td class="td48" width="30%"><u><%=sSku%></u></td>
         </tr>  
      	 <tr class="trDtl22">
           <td class="td48">Item:</td>
           <td class="td48" nowrap><b><%=sDesc%></b></td>
           <td class="td48">Style</td>
           <td class="td48"><%=sVenSty%></td>
         </tr>
         <tr class="trDtl22">
           <td class="td48">Color:</td>
           <td class="td48"><%=sClrNm%></td>
           <td class="td48">Size</td>
           <td class="td48"><%=sSizNm%></td>
         </tr> 
       </table>        
    </td>
  </tr>  
  <tr class="trDtl22">
    <td class="td48"><br><u>Defective Reason(s):</u> &nbsp;     
    <br>
    <%
       String sDefect = null;
       sPrepStmt = "select MgDefect"
       	 	+ " from rci.MkItmDfc"   	    
       	 	+ " where MgCtlId=" + sCtl
       	    + " and MgItemId=" + sItem
       	 	;
       	//System.out.println(sPrepStmt);
       	
       	rslset = null;
       	runsql = new RunSQLStmt();
       	runsql.setPrepStmt(sPrepStmt);		   
       	runsql.runQuery();

       	int i=0;
       	String sComa = "";
        while(runsql.readNextRecord())
       	{
       		sDefect = runsql.getData("MgDefect").trim();
       		i++;
    %>
      <%=sComa + sDefect%><%sComa=",";%>
    <%}
        runsql.disconnect();
       	runsql = null;
    %>
    
    </td>
    <td class="td49"><img width=200 src="/Defective Item Barcode/Sku/<%=sSku%>.png"></td>
  </tr>
  <tr class="trDtl22" ><td class="td48" colspan=2>&nbsp;</td></tr>
    
  <tr class="trDtl22">
    <td class="td48"  colspan=2><u>Comment(s):</u><br>
    <%
       String sCommt = null;
       sPrepStmt = "select MPCOMMID,MPCTLID,MPITEMID,MPLINE,MPTYPE,MPCOMM" 
       		+ ",MPRECUS,MPRECDT,MPRECTM"
       		+ ",MISKU, ides, ivst, MpEmp, ename"
       	   	+ " from rci.MKITMCOM c inner join rci.MkItem i on i.item_id=c.item_id"
       	   	+ " inner join IpTsFil.IpItHDr on isku=misku"
       	   	+ " left join rci.rciemp on MiEmp=erci"
       	   	+ " where MPCtlId=" + sCtl + " and MPITEMID=" + sItem + " and MPTYPE='User'" 
       	   	+ " order by MPITEMID, MpCommId, MpLine";
       	System.out.println(sPrepStmt);
       	
       	rslset = null;
       	runsql = new RunSQLStmt();
       	runsql.setPrepStmt(sPrepStmt);		   
       	runsql.runQuery();

       	String br = "";
        while(runsql.readNextRecord())
       	{
        	sCommt = runsql.getData("MpComm").trim();
    %>
      <%=br + " &nbsp; &nbsp; &nbsp; &nbsp;" + sCommt%><%br="<br>";%>
    <%}
        runsql.disconnect();
       	runsql = null;
    %>
    </td>
  </tr>
  
  
  
  <tr class="trDtl22">
    <td class="td48"  colspan=2><br><br>
    Store Mgr Name: ______________________ 
    
    Store Mgr Signature: ____________________
    </td>
  </tr>
</table>
<br>&nbsp;<br>&nbsp;<br>
<span style="font-size:11px; border: none; border-bottom: 1px dashed black; width: 100%">
	<b>Stores - Keep fill page with defective item.</b>
</span>
<br>
<span style="font-size:11px; border: none; width: 100%">
	<b>DC - Keep the top portion attached to the defective item! *** Detach the bottom portion to be used with DEFECT/RTV paperwork.</b>
</span>
<br>&nbsp;<br>&nbsp;
 
  
</body>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>