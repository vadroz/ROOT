<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet, inventoryreports.PiCalendar"%>  
<%
 //String sSts = request.getParameter("Sts");

if (session.getAttribute("USER")!=null)
{
	 
	String sStmt = "with ord_sku_f as (" 
	 + " select iven, vnam, pnsts, ohordsts" 
	 + ", case when (select  hono from IpTSFil.IpPoHdr where hblk = digits(opord) fetch first 1 rows only)" 
	 + "  is not null then (select  hono from IpTSFil.IpPoHdr where hblk = digits(opord) fetch first 1 rows only)" 
	 + " else 0  end as PO#" 
	 + ", case when pnsts='Assigned' and timestamp(PNRECDT,PNRECTM) <= current timestamp - 48 hours"
	 + " then 1 else 0 end as errflg"
	 
	 + ", (select 1 from iptsfil.IpAnItm"
	 + " inner join iptsfil.IpAnDtl on bono=cono and basn=casn and bstr=cstr" 
	 + " where cstr=70" 
	 + " and ccls=icls and cven=iven and csty=isty" 
	 + " and cclr=iclr and csiz=isiz" 
	 + " and exists(select 1 from IpTsFil.IpPoHdr" 
	 + " where hblk = digits(opord) and hono=cono)" 
	 + " fetch first 1 rows only" 
	 + ") as asn_count"
	 
	 + " from rci.MoOrPas" 
	 + " inner join rci.MoOrdH on ohord=opord" 
	 + " inner join rci.mospstn on opid=pnpickid" 
	 + " inner join IpTSFil.ipithdr on isku=opsku" 
	 + " inner join IpTSFil.IpMrVen on iven=vven" 
	 + " where pnstr=70 and (pnsts in ('Assigned', 'Printed', 'Picked', 'Shipped', 'Cancelled', 'Sold Out')" 
	 + " or ohordsts = 'Cancelled')" 
	 //+ " and (pnsts not in ('Shipped', 'Cancelled')" 
	 //+ " or pnsts in ('Shipped', 'Cancelled') and PNRECDT > current date - 30 days)"
	
 	 + "), chk_asn_f as ("
 	 + " select iven, vnam, pnsts, ohordsts, PO#,  errflg"
 	 + ", case when asn_count is null then '*' else ' ' end as asn_count"
 	 + " from ord_sku_f"
	 
	 + "), stssumf as (" + " select iven, vnam, po#" 
	 + ", case when ohordsts <> 'Cancelled' and pnsts = 'Assigned' and Po# > 0 then 1 else 0 end as cnt_Po_assig" 
	 + ", case when ohordsts <> 'Cancelled' and pnsts = 'Printed'  and Po# > 0 then 1 else 0 end as cnt_Po_prt" 
	 + ", case when ohordsts <> 'Cancelled' and pnsts = 'Picked'   and Po# > 0 then 1 else 0 end as cnt_Po_pick" 
	 + ", case when ohordsts <> 'Cancelled' and pnsts = 'Shipped'  and Po# > 0 then 1 else 0 end as cnt_Po_ship" 
	 + ", case when (ohordsts = 'Cancelled' or pnsts in('Cancelled', 'Sold Out'))  and Po# > 0 then 1 else 0 end as cnt_Cancel"
	 + ", sum(errflg) as errflg"
	 + ", case when ohordsts <> 'Cancelled' and pnsts = 'Shipped'  and Po# > 0 then max(asn_count) else ' ' end as asn_count"
	 + " from chk_asn_f"
	 + " group by iven, vnam, po#, pnsts, ohordsts" 
	
	 + ") , posumf as (" 
	 + " select  iven, vnam, po#" 
	 + ", case when sum(cnt_Po_assig) > 0  then 1 else 0 end as cnt_Po_assig" 
	 + ", case when sum(cnt_Po_prt) > 0 then 1 else 0 end as cnt_Po_prt" 
	 + ", case when sum(cnt_Po_pick) > 0 then 1 else 0 end as cnt_Po_pick" 
	 + ", case when sum(cnt_Po_ship)  > 0 then 1 else 0 end as cnt_Po_ship" 
	 + ", case when sum(cnt_Cancel) > 0 then 1 else 0 end as cnt_Cancel"
	 + ", sum(errflg) as errflg"
	 + ", case when max(asn_count) = '*' then '*' else ' ' end as asn_count"
	 + " from stssumf" 
	 + " group by iven, vnam, po#" 
	 + " )" 
	 + " select iven, vnam" 
	 + ", sum(cnt_po_assig + cnt_po_prt + cnt_po_pick + cnt_po_ship) as po_num" 
	 + ", sum(cnt_po_assig) as cnt_po_assig, sum(cnt_po_prt) as cnt_po_prt, sum(cnt_po_pick) as cnt_po_pick" 
	 + " , sum(cnt_po_ship) as cnt_po_ship" 
	 + ", sum(cnt_Cancel) as cnt_Cancel"
	 + ", sum(errflg) as errflg"
	 + ", max(asn_count) as asn_count"
	 + " from posumf" 
	 + " group by iven, vnam" 
	 + " order  by iven, vnam"
	 ;
	
	System.out.println("\n" + sStmt);
	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vVen = new Vector<String>();
	Vector<String> vVenNm = new Vector<String>();
	Vector<String> vNumPo = new Vector<String>();
	Vector<String> vQtyAssig = new Vector<String>();
	Vector<String> vQtyPrint = new Vector<String>();
	Vector<String> vQtyPick = new Vector<String>();
	Vector<String> vQtyShip = new Vector<String>();
	Vector<String> vQtyCancel = new Vector<String>();
	Vector<String> vErrFlg = new Vector<String>();
	Vector<String> vMissing = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vVen.add(runsql.getData("iven").trim());	
		vVenNm.add(runsql.getData("vnam").trim());
		vNumPo.add(runsql.getData("po_num").trim());
		vQtyAssig.add(runsql.getData("cnt_po_assig").trim());
		vQtyPrint.add(runsql.getData("cnt_po_prt").trim());
		vQtyPick.add(runsql.getData("cnt_po_pick").trim());
		vQtyShip.add(runsql.getData("cnt_po_ship").trim());
		vQtyCancel.add(runsql.getData("cnt_Cancel").trim());
		vErrFlg.add(runsql.getData("ErrFlg").trim());
		vMissing.add(runsql.getData("asn_count").trim());
	}
	rs.close();
	runsql.disconnect();
	
	// get PI Calendar
    PiCalendar setcal = new PiCalendar();
    String sYear = setcal.getYear();
    String sMonth = setcal.getMonth();
    String sMonName = setcal.getDesc();
    setcal.disconnect(); 
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>VDS P.O. Summary</title>

<SCRIPT>
//--------------- Global variables -----------------------
var BegTime = "Current";
var progressIntFunc = null;
var progressTime = 0;

var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sMonName%>];

SelPos = [0,0];

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
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvEdi"]); 
}

//==============================================================================
// get PO List for selected vendor and status
//==============================================================================
function getPoList(ven, sts)
{
	var url = "VdsPoListDtl.jsp?Ven=" + ven
	 + "&Sts=" + sts
	 ;
	window.frame1.location.href = url;
}
//==============================================================================
//doisplay Cell details for selected date and store 
//==============================================================================
function setCellDtl(selVen, selSts, cls, ven, sty, clr, siz, po, ord, sku, srln, desc
		, venSty, stsDt, errFlg, asn)
{
	 var hdr = "Vendor: " + selVen +  " Staus: " + selSts;
	  
	 var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(1);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>"
	        + popCellDtl(selVen, selSts, cls, ven, sty, clr, siz, po, ord, sku, srln, desc
	        		, venSty, stsDt, errFlg, asn)
	     + "</td></tr>"
	   + "</table>"

	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	  document.all.dvItem.style.width = 900;
	  document.all.dvItem.style.visibility = "visible"; 
}
//==============================================================================
//populate quantity and status change panel
//==============================================================================
function popCellDtl(selVen, selSts, cls, ven, sty, clr, siz, po, ord, sku, srln, desc
		, venSty, stsDt, errFlg, asn)
{
	var panel = "<table border =1 class='tbl01' id='tblLog'>"
	    + "<tr class='trHdr01'>"
	       + "<th class='th02'>PO#</th>"
	  ;
	       
	if(selSts!="Shipped"){ panel += "<th class='th02'>EDI(855)</th>"; }
	else{ panel += "<th class='th02'>EDI(856)</th>"; }
	       
	panel += "<th class='th02'>Ord#</th>"	       
	       + "<th class='th02'>Long Item Number</th>"
	       + "<th class='th02'>Sku</th>"
	       + "<th class='th02'>S/N</th>"
	       + "<th class='th02'>Description</th>"
	       + "<th class='th02'>Vendor Style</th>"
	       + "<th class='th02'>Status Date</th>"
	       + "<th class='th02' nowrap>ASN is<br>Not Found</th>"
	    + "</tr>"
	    ;
	    
	    for(var i=0; i < cls.length;i++)
	    {
	    	panel += "<tr class='trDtl04'>"
	    	   + "<td class='td11' id='tdPo" + i + "'>" + po[i] + "</td>"
	    	   + "<td class='td11'>"
	    	   ;  
	    	
	    	if(selSts!="Assigned")
	    	{
	    	   panel += "<a href='javascript: getPoDtl(&#34;" + po[i] + "&#34;,&#34;tdPo" + i + "&#34;,&#34;" + selSts + "&#34;,&#34;" + sku[i] + "&#34;)'>EDI</a>"
	    	} 
	    	else { panel += "&nbsp;"; }
	    	
	    	panel += "</td>"
	    	   
	    	   + "<td class='td12'>"
	    	      + "<a href='MozuSrlAsgCtl.jsp?StsFrDate=01/01/2000&StsToDate=12/31/2099&Ord=" + ord[i] + "&OrdSts=1&Sts=Open&Sts=Assigned&Sts=Printed&Sts=Picked&Sts=Problem&Sts=Resolve&Sts=Shipped&Sts=Cannot Fill&Sts=Sold Out&Sts=Error&Sts=Cancelled' target='_blank'>"
	    	         + ord[i]
	    	      + "</a>" 
	    	   + "</td>"	 
	    	   
	    	   + "<td class='td11' nowrap>" + cls[i] + "-" + ven[i] + "-" + sty[i] + "-" + clr[i] + "-" + siz[i] + "</td>"		       
		       + "<td class='td12'><a href='javascript: getSlsBySku(&#34;" + sku[i] + "&#34;, &#34;1&#34;)'>" + sku[i] + "</a></td>"
		       + "<td class='td12'>" + srln[i] + "</td>"             
		       + "<td class='td11' nowrap>" + desc[i] + "</td>"
		       + "<td class='td11' nowrap>" + venSty[i] + "</td>"
		       ;
		       
		       if(errFlg[i] == "1" ) { panel += "<td class='td85' nowrap>" + stsDt[i] + "</td>"; }
		       else { panel += "<td class='td11' nowrap>" + stsDt[i] + "</td>"; }
		    panel +=  "<td class='td11' nowrap>" + asn[i] + "</td>"
		    panel += "</tr>"
		    ;
	    }
		panel += "</table>  <p style='text-align:center'>";
	    panel += "<button onClick='hidePanel(1);' class='Small'>Close</button>&nbsp;"
	    ;
	        
	return panel;
}

//==============================================================================
//get PO details 
//==============================================================================
function getPoDtl(po, td, sts, sku)
{
	var obj = document.getElementById(td);
	SelPos = getObjPosition(obj)
	
	var url = "VdsEdiDtl.jsp?Po=" + po
	 + "&Sts=" + sts
	 + "&Sku=" + sku
	 ;
	window.frame1.location.href = url;
}
//==============================================================================
// display PO EDI details 
//==============================================================================
function setPoDtl(selPo, date, sts, item, sku, phone, email, venSty, trackId)
{
	 var hdr = "PO: " + selPo;
	  
	 var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(2);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>"
	        + popPoDtl(selPo, date, sts, item, sku, phone, email, venSty, trackId)
	     + "</td></tr>"
	   + "</table>"

	  document.all.dvEdi.innerHTML = html;	 
	  document.all.dvEdi.style.left = SelPos[0] + 50;
	  document.all.dvEdi.style.top = SelPos[1] + 50;
	  document.all.dvEdi.style.width = 1000;
	  document.all.dvEdi.style.visibility = "visible"; 
}
//==============================================================================
//populate quantity and status change panel
//==============================================================================
function popPoDtl(selPo, date, sts, item, sku, phone, email, venSty, trackId)
{
	var panel = "<table border =1 class='tbl01' id='tblLog'>"
	    + "<tr class='trHdr01'>"
	       + "<th class='th02'>Date</th>"
	       + "<th class='th02'>Sts</th>"	       
	       + "<th class='th02'>Item</th>"
	       + "<th class='th02'>Sku</th>"
	       + "<th class='th02'>Phone</th>"
	       + "<th class='th02'>E-Mail</th>"
	       + "<th class='th02'>Vendor Style</th>"
	       + "<th class='th02'>Track Id(856)</th>"
	    + "</tr>"
	    ;
	    
	    for(var i=0; i < item.length;i++)
	    {
	    	panel += "<tr class='trDtl04'>"
	    	   + "<td class='td11' nowrap>" + date[i] + "</td>"
	    	   + "<td class='td11' nowrap>" + sts[i] + "</td>"
	    	   + "<td class='td11' nowrap>" + item[i] + "</td>"
	    	   + "<td class='td11' nowrap>" + sku[i] + "</td>"
	    	   + "<td class='td11' nowrap>" + phone[i] + "</td>"
	    	   + "<td class='td11' nowrap>" + email[i] + "</td>"
	    	   + "<td class='td11' nowrap>" + venSty[i] + "</td>"
	    	   + "<td class='td11' nowrap>" + trackId[i] + "</td>"
		    + "</tr>"
		    ;
	    }
		panel += "</table>  <p style='text-align:center'>";
	    panel += "<button onClick='hidePanel(2);' class='Small'>Close</button>&nbsp;"
	    ;
	        
	return panel;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel(div)
{
	if(div=="1")
	{
		document.all.dvItem.innerHTML = " ";
		document.all.dvItem.style.visibility = "hidden";
	}
	if(div=="2")
	{
		document.all.dvEdi.innerHTML = " ";
		document.all.dvEdi.style.visibility = "hidden";
	}
}
//==============================================================================
//link to Return Validation page
//==============================================================================
function getSlsBySku(sku, str)
{
	var iEoY = 0;

	for(var i=0; i < PiYear.length; i++)
	{
  	if(PiDesc[i].indexOf("End of Year PI") >= 0) { iEoY = i; break; }
	}
	var lastPI = PiYear[iEoY] + PiMonth[iEoY];

	url ="PIItmSlsHst.jsp?Sku=" + sku
  + "&SlsOnTop=1"
  + "&STORE=" + str
  + "&FromDate=01/01/0001"
  + "&ToDate=12/31/2999"
  + "&PICal=" + lastPI

	//alert(url)
	window.open(url, "_blank");
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
<div id="dvEdi" class="dvItem"></div>
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
            <br>VDS P.O. Summary
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
          <th class="th02" rowspan=2>Vendor</th>
          <th class="th02" rowspan=2>Number of POs</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=5>Number of POs by ECOM FFL Status</th>
        </tr>    
        
        <tr class="trHdr01">
         <th class="th02">Assigned</th>
         <th class="th02">Printed</th>
         <th class="th02">Picked</th>
         <th class="th02">Shipped</th>
         <th class="th02">Cancelled</th>
        </tr>
        
        <%
        String sRowCls = "trDtl06";
        for(int i=0; i < vVen.size(); i++){
        	if(sRowCls.equals("trDtl06")){ sRowCls = "trDtl04";}
        	else { sRowCls = "trDtl06"; }
        %>
          
          <tr id="trId" class="<%=sRowCls%>">
	        <td class="td11" nowrap><%=vVen.get(i)%> - <%=vVenNm.get(i)%></td>
	        <td class="td12" nowrap><%=vNumPo.get(i)%></td>
	        <td class="td43" nowrap>&nbsp;</td>
	        <td class="td12" <%if(!vErrFlg.get(i).equals("0")){%>style="background: pink"<%}%> nowrap>
	         <%if(!vQtyAssig.get(i).equals("0")){%>
	         	<a href="javascript: getPoList('<%=vVen.get(i)%>','Assigned');"><%=vQtyAssig.get(i)%></a>
	         <%} else {%>&nbsp;<%}%>	
	        </td>
	        <td class="td12" nowrap>
	         <%if(!vQtyPrint.get(i).equals("0")){%>
	        	<a href="javascript: getPoList('<%=vVen.get(i)%>','Printed');"><%=vQtyPrint.get(i)%></a>
	         <%} else {%>&nbsp;<%}%>
	        </td>
	        <td class="td12" nowrap>
	          <%if(!vQtyPick.get(i).equals("0")){%>
	        	<a href="javascript: getPoList('<%=vVen.get(i)%>','Picked');"><%=vQtyPick.get(i)%></a>
	          <%} else {%>&nbsp;<%}%>
	        </td>
	        <td class="td12" nowrap>
	          <%if(!vQtyShip.get(i).equals("0")){%>
	        	<a href="javascript: getPoList('<%=vVen.get(i)%>','Shipped');"
	        	 <%if(vMissing.get(i).equals("*")){%>style="background:pink;"<%}%> ><%=vQtyShip.get(i)%></a>	        	
	          <%} else {%>&nbsp;<%}%>	
	        </td>
	        <td class="td12" nowrap>
	          <%if(!vQtyCancel.get(i).equals("0")){%>
	        	<a href="javascript: getPoList('<%=vVen.get(i)%>','Cancelled');"><%=vQtyCancel.get(i)%></a>
	          <%} else {%>&nbsp;<%}%>	
	        </td>
	      </tr>   
        <%}%>
       </table>
       
      
    </td>
   </tr>
 </table>
   
 </body>
</html>
<%}%>