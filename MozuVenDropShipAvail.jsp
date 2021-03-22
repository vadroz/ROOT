<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet,java.math.BigDecimal,java.math.RoundingMode"%>  
<%
	String sSite = request.getParameter("Site");
	String sSelVen = request.getParameter("Ven");
	String sSelSku = request.getParameter("Sku");
	
	if(sSelSku == null){sSelSku = ""; }
	
if (session.getAttribute("USER")!=null)
{
	 
	/*String sStmt = "select veven, veallow, vnam"
	 + ", (select sum(ADQTYAVL) from rci.rc846 where ADVENHDR=veven and adcls = 0" 
	 //+ " and exists(select 1 from IpTsFil.IpItHdr where icls=adcls and iven=adven and isty=adsty" 
	 //+ " and iclr=adclr and isiz=adsiz and iatt01 <> 2)" 
	 //+ " and exists(select 1 from Rci.MoItWeb where wcls=adcls and wven=adven and wsty=adsty" 
	 //+ " and wclr=adclr and wsiz=adsiz and WDDAT > '0001-01-01') " 
	 + " and adsts = ' '" 
	 + ") as venqty"
	 + " from  rci.movdsven"
	 + " inner join IpTsFil.IpMrVen on vven=veven"
	;
	*/
	String sStmt = "with itemf as (" 
	  + " select ADVENHDR, ADGTIN, ADVSTYLE" 
	  + " from rci.rc846" 
	  + " where adsts = ' ' and adcls = 0 and ADDTAVL >= current date - 2 days and ADQTYAVL > 0" 
	  + " group by ADVENHDR, ADGTIN, ADVSTYLE" 
	  + " ), sumf as (" 
	  + " select ADVENHDR, ADGTIN, ADVSTYLE" 
	  + " , (select ADQTYAVL from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE"
	  + " order by ADDTAVL desc, ADTMAVL desc fetch first 1 row only) as ADQTYAVL" 
	  + " , (select ADCOST from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE"
	  + " order by ADDTAVL desc, ADTMAVL desc fetch first 1 row only) as ADCOST" 
	  + " , (select ADDTAVL from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE" 
	  + " order by ADDTAVL desc, ADTMAVL desc fetch first 1 row only) as ADDTAVL" 
	  + ", (select digits(ADTMAVL) from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE"
	  + " order by ADDTAVL desc, ADTMAVL desc fetch first 1 row only) as ADTMAVL"
	  + ", 1 as count"
	  + " from itemf a" 
	  + " order by ADGTIN" 
	  + " )" 
	  + " select veven, veallow, vnam" 
	  + ", sum(case when ADQTYAVL is not null then ADQTYAVL else  0 end) as venqty"
	  + ", sum(case when count is not null then count else 0 end) as count "
	  + " from rci.movdsven"
	  + " inner join IpTsFil.IpMrVen on vven=veven" 
	  + " left join sumf  on ADVENHDR = veven"
	  + " group by veven, veallow, vnam,ADVENHDR" 
	  + " order by veven"
	;
	
	System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vVen = new Vector();
	Vector<String> vVenAlw = new Vector();
	Vector<String> vVenNm = new Vector();
	Vector<String> vVenQty = new Vector();
	Vector<String> vCount = new Vector();
	while(runsql.readNextRecord())
	{
		vVen.add(runsql.getData("veven").trim());
		vVenAlw.add(runsql.getData("veallow").trim());
		vVenNm.add(runsql.getData("vnam").trim());
		String sVenQty = runsql.getData("venqty");
		if(sVenQty == null){ sVenQty = "0"; }
		vVenQty.add(sVenQty);
		vCount.add(runsql.getData("count").trim());
	}
	rs.close();
	runsql.disconnect();
	
	Vector<String> vSelCls = new Vector();
	Vector<String> vSelVen = new Vector();
	Vector<String> vSelSty = new Vector();
	Vector<String> vSelClr = new Vector();
	Vector<String> vSelSiz = new Vector();
	Vector<String> vSelQty = new Vector();
	Vector<String> vSelDtAvl = new Vector();
	Vector<String> vSelTmAvl = new Vector();
	Vector<String> vSelKiProd = new Vector();
	Vector<String> vSelSentVdsQty = new Vector();
	Vector<String> vSelSentStrQty = new Vector();
	Vector<String> vSelSentDate  = new Vector();
	Vector<String> vSelDesc  = new Vector();
	Vector<String> vSelVenSty  = new Vector();
	Vector<String> vSelClrNm  = new Vector();
	Vector<String> vSelSizNm  = new Vector();
	Vector<String> vSelPermMd  = new Vector();
	Vector<String> vSelCost  = new Vector();
	Vector<String> vSelEcPrc  = new Vector();
	Vector<String> vSelEcSls  = new Vector();
	
	Vector<String> vOpnStr  = new Vector();
	
	if(sSelVen != null)
	{
		sStmt = "select sstr from IpTsFil.IpStore where ssts='S' and sstr <> 75" 
	     + " and sdci > current date or sstr=1"
		;
		//System.out.println("\n" + sStmt);
		runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		rs = runsql.runQuery();
		while(runsql.readNextRecord())
		{
			vOpnStr.add(runsql.getData("sstr").trim());
		}
		rs.close();
		runsql.disconnect();
		
		sStmt = "with lastf as" 
		 + " (select digits(AdCls) as adcls, digits(AdVen) as adven, digits(AdSty) as adsty"
		 + ", digits(AdClr) as adclr, digits(AdSiz) as adsiz"
	  	 + " from rci.rc846"
		 + " where adven = " + sSelVen
		 + " and exists(select 1 from IpTsFil.IpItHdr where icls=adcls and iven=adven and isty=adsty " 
		 + " and iclr=adclr and isiz=adsiz and iatt01=2)"
		 + " and exists(select 1 from Rci.MoItWeb where wcls=adcls and wven=adven and wsty=adsty " 
		 + " and wclr=adclr and wsiz=adsiz and WDDAT > '0001-01-01')"
		 + " and adsts = ' '"
		 + " group by adcls, adven, adsty, adclr, adsiz"
		 + ") "		 
		 + " select adcls, adven, adsty, adclr, adsty, adclr, adsiz"
		 
		 + ",(select ADDTAVL from rci.rc846 b where a.adcls=b.adcls and a.adven=b.adven"
		 + "  and a.adsty=b.adsty and a.adclr=b.adclr and a.adsiz=b.adsiz" 
		 + " order by ADDTAVL desc fetch first 1 rows only) as ADDTAVL"
		 
		 + ",(select digits(ADTMAVL) from rci.rc846 b where a.adcls=b.adcls and a.adven=b.adven"
		 + "  and a.adsty=b.adsty and a.adclr=b.adclr and a.adsiz=b.adsiz" 
		 + " order by ADDTAVL desc, ADTMAVL desc fetch  first 1 rows only) as ADTMAVL"
		 
		 + ",(select ADQTYAVL from rci.rc846 b where a.adcls=b.adcls and a.adven=b.adven " 
		 + " and a.adsty=b.adsty and a.adclr=b.adclr and a.adsiz=b.adsiz" 
		 + " order by ADDTAVL desc, ADTMAVL desc fetch first 1 rows only) as ADQTYAVL"
		  
		 + ", (select vxkiprod from rci.MoPrcInv where vxsite='11961' and vxparent='1'"
		 + " and vxprod = adcls concat adven concat adsty"
		 + " order by VXRECDT desc fetch first 1 row only) as kiprod"
		 
		 + ", (select vxPrice from rci.MoPrcInv where vxsite='11961' and vxparent='1'"
         + " and vxprod = adcls concat adven concat adsty" 
		 + " order by VXRECDT desc fetch first 1 row only) as EcomPrc"
		 
		 + ", (select vxSls from rci.MoPrcInv where vxsite='11961' and vxparent='1'"
		 + " and vxprod = adcls concat adven concat adsty" 
		 + " order by VXRECDT desc fetch first 1 row only) as EcomSls"
		 
		 + ", (select LoQty from rci.MOINVLOC where  loprod = adcls concat adven concat adsty" 
		 + " concat '-' concat adclr concat adsiz and Lostr='VDS' order by LoRECDT desc fetch first 1 row only)"
		 + " as LoVdsQty"
		 + ", (select dec(VXSTOCK,9,0) from rci.MoPrcInv where vxsite='11961' and vxparent='2'" 
		 + " and vxprod = adcls concat adven concat adsty concat '-' concat adclr concat adsiz" 
		 + " order by VXRECDT desc fetch first 1 row only)" 
		 + " - "
		 + " (select LoQty from rci.MOINVLOC where loprod = adcls concat adven concat adsty concat '-'" 
		 + " concat adclr concat adsiz and Lostr='VDS' order by LoRECDT desc" 
		 + " fetch first 1 row only)  as StrQty"
		
		 + ", (select LORECDT from rci.MOINVLOC where  loprod = adcls concat adven concat adsty"
		 + " concat '-' concat adclr concat adsiz and Lostr='VDS' order by LoRECDT desc fetch first 1 row only)" 
		 + " as LORECDT"
		 + ",ides, ivst,clrn, snam, case when imkd = 'Y' then imkd else ' ' end as imkd" 
		 + ", dec(ivlc, 7, 2) as ivlc"
		 + " from lastf a"
		 + " left join IpTsFil.IpItHdr on icls=adcls and iven=adven and isty=adsty and iclr=adclr and isiz=adsiz"
		 + " left join IpTsFil.IpColor on cclr=adclr"
		 + " left join IpTsFil.IpSizes on ssiz=adsiz"
		 + " order by AdCls, AdVen, AdSty, AdClr, AdSiz"
		;
		//System.out.println("\n" + sStmt);
		runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		rs = runsql.runQuery();
		while(runsql.readNextRecord())
		{
			vSelCls.add(runsql.getData("AdCls").trim());
			vSelVen.add(runsql.getData("AdVen").trim());
			vSelSty.add(runsql.getData("AdSty").trim());
			vSelClr.add(runsql.getData("AdClr").trim());
			vSelSiz.add(runsql.getData("AdSiz").trim());
			vSelQty.add(runsql.getData("ADQTYAVL").trim());
			vSelDtAvl.add(runsql.getData("ADDTAVL").trim());
			vSelTmAvl.add(runsql.getData("ADTMAVL").trim());
			String skiprod = runsql.getData("kiprod");
			if(skiprod != null){ skiprod = skiprod.trim(); } else { skiprod = "";}
			vSelKiProd.add(skiprod);
			
			String sqty = runsql.getData("LoVdsQty");
			if(sqty != null){ sqty = sqty.trim(); } else { sqty = "";}
			vSelSentVdsQty.add(sqty);
			
			sqty = runsql.getData("StrQty");
			if(sqty != null){ sqty = sqty.trim(); } else { sqty = "";}
			vSelSentStrQty.add(sqty);
			
			String srecdt = runsql.getData("LORECDT");
			if(srecdt != null){ srecdt = srecdt.trim(); } else { srecdt = "";}
			vSelSentDate.add(srecdt);
			
			vSelDesc.add(runsql.getData("ides"));
			vSelVenSty.add(runsql.getData("ivst"));
			vSelClrNm.add(runsql.getData("clrn"));
			vSelSizNm.add(runsql.getData("snam"));
			vSelPermMd.add(runsql.getData("imkd"));
			vSelCost.add(runsql.getData("ivlc"));
			vSelEcPrc.add(runsql.getData("EcomPrc"));
			vSelEcSls.add(runsql.getData("EcomSls"));
		}
		rs.close();
		runsql.disconnect();
	} 
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>VDS Availability</title>

<SCRIPT>
//--------------- Global variables -----------------------
var BegTime = "Current";
var progressIntFunc = null;
var progressTime = 0;
var SelLow = false;
var SelPermMd = false;
var NumOfRow = 0;
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{
		isSafari = true;
	}
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
    
    
}

 
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//send Price again to KIBO
//==============================================================================
function sendPriceAgain(parent)
{
	url = "KiboCurrPrice.jsp?Parent=" + parent
	window.frame1.location.href = url;	
	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000); 
}
//==============================================================================
//set KIBo price
//==============================================================================
function setKiboPrc()
{	
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
}
//==============================================================================
//show only Low GM or ALL
//==============================================================================
function showLowGM()
{
	SelLow = !SelLow;
	var disp = "table-row";	
	if(SelLow){ disp = "none"; }
	for(var i=0; i < NumOfRow; i++)
	{
		var row = document.getElementById("trId" + i);
		var gm = document.getElementById("tdGm" + i).innerHTML;
		var qty = document.getElementById("tdQty" + i).innerHTML.trim();
		 
		if(gm.indexOf("*") < 0 || eval(qty) <= 0)
		{
			row.style.display = disp;
		}
	}
}
//==============================================================================
//show only Low GM or ALL
//==============================================================================
function showPermMd()
{
	SelPermMd = !SelPermMd;
	var disp = "table-row";
	if(SelPermMd){ disp = "none"; }
	for(var i=0; i < NumOfRow; i++)
	{
		var row = document.getElementById("trId" + i);
		var gm = document.getElementById("tdPermMd" + i).innerHTML;
		var qty = document.getElementById("tdQty" + i).innerHTML.trim();
		
		if(gm.indexOf("Y") < 0 || eval(qty) <= 0)
		{
			row.style.display = disp;
		}
	}
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvSelect" class="dvSelect"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Vendor Direct Ship Availability           
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> 
                         
          </th>                    
        </tr>
  <tr class="trHdr">
    <td>
       <table class="tbl02" id="tblSsn">
        <tr class="trHdr01">
          <th class="th02">Vendor</th>
          <th class="th02">Vendor Name</th>           
          <th class="th02">Allowed</th>
          <th class="th02">Undefined<br>Items (In IP)<br>Available VDS</th>
        </tr>    
        <%
        for(int i=0; i < vVen.size(); i++){
        %>
          <tr id="trId" class="trDtl04">
	        <td class="td12" nowrap><a href="MozuVenDropShipAvail.jsp?Ven=<%=vVen.get(i)%>"><%=vVen.get(i)%></a></td>
	        <td class="td11" nowrap><%=vVenNm.get(i)%></td>
	        <td class="td18" nowrap><%=vVenAlw.get(i)%></td>
	        <td class="td12" nowrap><a href="MozuVDSUnattrAvail.jsp?Ven=<%=vVen.get(i)%>&VenNm=<%=vVenNm.get(i)%>" target="_blank"><%=vCount.get(i)%></a></td>
	      </tr>   
        <%}%>
       </table>
       <br>
       <br>
       
       <%if(sSelVen != null){%>
        <script>NumOfRow = "<%=vSelCls.size()%>";</script>
        <a class="Medium" href="javascript: showLowGM()">Low GM/All</a> &nbsp; 
        <a class="Medium" href="javascript: showPermMd()">Perm MD/All</a>
        
        <table class="tbl02" id="tblSsn">
        <tr class="trHdr01">
          <th class="th02">Item</th>
          <th class="th02">Qty</th>
          <th class="th02">Available<br>Date</th>
          <th class="th02">Available<br>Time</th>
          <th class="th02">Link<br>To<br>KIBO</th>
          <th class="th02">Last Qty<br>Sent to<br>KIBO<br>From VDS</th>
          <th class="th02">Last Qty<br>Sent to<br>KIBO<br>From Stores</th>
          <th class="th02">Last Date/Time<br>Sent to<br>KIBO</th>
          <th class="th02">Description</th>
          <th class="th02">Vendor Style</th>
          <th class="th02">Color Name</th>
          <th class="th02">Size Name</th>
          <th class="th02">Perm<br>MD</th>
          <th class="th02">Kibo<br>Price</th>
          <th class="th02">Valued<br>Cost</th>
          <th class="th02">GM%</th>
          <th class="th02">Send<br>Price/Stock<br>To KIBO</th>
        </tr>     
         
        <%String sSvParent = "FIRST";
          String sParCls = "trDtl06";
          boolean bNewPar = false;
          for(int i=0; i < vSelCls.size(); i++){
        	 String sTime = vSelTmAvl.get(i);
        	 String sFmtTime = sTime.substring(0,2) 
        	   + ":" + sTime.substring(2,4) + ":" + sTime.substring(4);
        	 
        	 String sCurrParent = vSelCls.get(i) + vSelVen.get(i) + vSelSty.get(i);
        	 if(!sSvParent.equals(sCurrParent))
        	 {
        		 bNewPar = true;
        		 sSvParent = vSelCls.get(i) + vSelVen.get(i) + vSelSty.get(i);
        		 if(sParCls.equals("trDtl04")){sParCls = "trDtl06";}
        		 else{sParCls = "trDtl04";}
        	 }
        	 else
        	 {
        		 bNewPar = false;
        	 }
        	 
        	 String sDiffClr = "";
        	 if(!vSelQty.get(i).equals(vSelSentVdsQty.get(i))){ sDiffClr = "style=\"background: pink;\""; }
        	 
        	 String sStrQtyClr = "";
        	 if(!vSelSentStrQty.get(i).equals("0")){ sStrQtyClr = "style=\"background: #ccffcc;\""; }
        	
        	 double dEcPrc = Double.valueOf(vSelEcPrc.get(i).trim());        	 
        	 BigDecimal bd = new BigDecimal(dEcPrc);
        	 bd = bd.setScale(2, RoundingMode.HALF_UP);
        	 dEcPrc = bd.doubleValue();
        	 
        	 double dEcSls = Double.valueOf(vSelEcSls.get(i).trim());
        	 bd = new BigDecimal(dEcSls);
        	 bd = bd.setScale(2, RoundingMode.HALF_UP);
        	 dEcSls = bd.doubleValue();
        	 
        	 double dCost = Double.valueOf(vSelCost.get(i).trim());
        	 bd = new BigDecimal(dCost);
        	 bd = bd.setScale(2, RoundingMode.HALF_UP);
        	 dCost = bd.doubleValue();
        	 
        	 if(dEcSls > 0 ){ dEcPrc = dEcSls; }
        	 
        	 double dGrsMrg = dEcPrc - dCost; 
        	 bd = new BigDecimal(dGrsMrg);
        	 bd = bd.setScale(1, RoundingMode.HALF_UP);
        	 dGrsMrg = bd.doubleValue(); 
        	 
        	 double dGrsMrgPrc = dGrsMrg / dEcPrc * 100;
        	 bd = new BigDecimal(dGrsMrgPrc);
        	 bd = bd.setScale(2, RoundingMode.HALF_UP);
        	 dGrsMrgPrc = bd.doubleValue(); 
        	 
        	 
        	 String sGmClr = "";  
        	 String sGmAstr = "";
        	 if(dGrsMrg <= 0  || dGrsMrgPrc < 20)
        	 { 
        		 sGmClr = "style=\"background: pink;\" "; 
        		 sGmAstr = "*";
        	 }
        %>
        	<tr id="trId<%=i%>" class="<%=sParCls%>">
        		<td class="td11" nowrap><%=vSelCls.get(i)%>-<%=vSelVen.get(i)%>-<%=vSelSty.get(i)%>-<%=vSelClr.get(i)%>-<%=vSelSiz.get(i)%></td>
        		<td class="td12" id="tdQty<%=i%>"  <%=sDiffClr%> nowrap><%=vSelQty.get(i)%></td>
        		<td class="td11" nowrap><%=vSelDtAvl.get(i)%></td>
        		<td class="td11" nowrap><%=sFmtTime%></td>
        		<td class="td11" nowrap>
        		<%if(bNewPar){%>
        			<a href="https://www.sunandski.com/p/<%=vSelKiProd.get(i)%>" target="_blank"><%=vSelKiProd.get(i)%></a>
        		<%} else {%>&nbsp;<%}%>
        		</td>
        		<td class="td12" <%=sDiffClr%> nowrap><%=vSelSentVdsQty.get(i)%></td>
        		<td class="td12" <%=sStrQtyClr%> nowrap><%=vSelSentStrQty.get(i)%></td>
        		<td class="td11" nowrap><%=vSelSentDate.get(i)%></td>
        		<td class="td11" nowrap><%=vSelDesc.get(i)%></td>
        		<td class="td11" nowrap><%=vSelVenSty.get(i)%></td>
        		<td class="td11" nowrap><%=vSelClrNm.get(i)%></td>
        		<td class="td11" nowrap><%=vSelSizNm.get(i)%></td>
        		<td class="td18" id="tdPermMd<%=i%>" nowrap><%=vSelPermMd.get(i)%></td>
        		<td class="td12" nowrap><%=String.format("%.02f",dEcPrc)%></td>
        		<td class="td12" nowrap><%=String.format("%.02f",dCost)%></td>
        		<td class="td12" id="tdGm<%=i%>" <%=sGmClr%> nowrap><%=sGmAstr%>&nbsp;<%=String.format("%.02f",dGrsMrgPrc)%>%</td>
        		<td class="td11" nowrap>
        		<%if(bNewPar){%>
        			<a href="javascript: sendPriceAgain('<%=vSelCls.get(i)%><%=vSelVen.get(i)%><%=vSelSty.get(i)%>')">Send Again</a>
        		<%} else {%>&nbsp;<%}%>
        		</td>
        		
        	</tr>        	
        <%}%>
       <%}%>
    </td>
   </tr>
 </table>
   
 </body>
</html>
<%}%>