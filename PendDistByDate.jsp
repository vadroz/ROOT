<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet, inventoryreports.PiCalendar"%>  
<%
String sDiv = request.getParameter("Div");
String sByGrp = request.getParameter("By");
String sSts = request.getParameter("Sts");

if (session.getAttribute("USER")!=null)
{
	 
	String sStmt = "select ddti, dec(sum(dqty ),9,0) as totqty" 
	 + " from IpTsFil.IpPnDst"
	 + " inner join IpTsFil.IpClass on ccls=dcls"
	 + " where dis#=1 and dds# <> 1 and dds# <> 70   and dalc > 0 and dsts = '" + sSts + "'" 
	 + " and exists(select 1 from IpTsFil.IpStore where ssts='S' and sstr <> 75"
	 + " and sdci > current date and dds#=sstr)"
	 ;
	 
	 // select division
	 if(!sDiv.equals("0")){ sStmt += " and cdiv = " + sDiv; }
	 	 
	 sStmt += " group by ddti" 
	 + " order by ddti"
	;
	//System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vDate = new Vector<String>();
	Vector<String> vTotQty = new Vector<String>();
	while(runsql.readNextRecord())
	{
		vDate.add(runsql.getData("ddti").trim());	
		vTotQty.add(runsql.getData("totqty").trim());
	}
	rs.close();
	runsql.disconnect();
	
	//Store or Division list 
	if(sByGrp.equals("Str"))
	{
		sStmt = "select sstr as cols from IpTsFil.IpStore " 
	  	+ "where ssts='S' and sstr <> 75 and sdci > current date"
	  	;
	}  
	else
	{
		sStmt = "select ddiv as cols from IpTsFil.IpDivsn ";
	}
	
	System.out.println("\n" + sStmt);
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();
	Vector<String> vColGrp = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vColGrp.add(runsql.getData("cols").trim());
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

<title>DC Pending Destribution</title>

<SCRIPT>
//--------------- Global variables -----------------------
var BegTime = "Current";
var progressIntFunc = null;
var progressTime = 0;

var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sMonName%>];

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
// get Cell details for selected date and store 
//==============================================================================
function getCellDtl(date, str, div)
{
	var url = "PendDistByDateDtl.jsp?Date=" + date
	 + "&Str=" + str
	 + "&Div=" + div
	 + "&Sts=<%=sSts%>"
	 + "&By=<%=sByGrp%>"
	 ;
	window.frame1.location.href = url;
}
//==============================================================================
//doisplay Cell details for selected date and store 
//==============================================================================
function setCellDtl(date, selStr, selDiv, doc, po, str, div, cls, ven, sty, clr, siz, qty, sku, desc, ret, venNm)
{
	 var hdr = "Date: " + date +  " Store: " + selStr;
	 if(div==0){ hdr += " Div: All"}
	 else { hdr += " Div: " + selDiv}
	  
	 var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>"
	        + popCellDtl(date, selStr, selDiv, doc, po, str, div, cls, ven, sty, clr, siz, qty, sku, desc, ret, venNm)
	     + "</td></tr>"
	   + "</table>"

	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	  document.all.dvItem.style.width = 800;
	  document.all.dvItem.style.visibility = "visible"; 
}
//==============================================================================
// populate quantity and status change panel
//==============================================================================
function popCellDtl(date, selStr, selDiv, doc, po, str, div, cls, ven, sty, clr, siz, qty, sku, desc, ret, venNm)
{
	var panel = "<table border =1 class='tbl01' id='tblLog'>"
	    + "<tr class='trHdr01'>"
	       + "<th class='th02'>Doc#</th>"
	       + "<th class='th02'>PO#</th>"
	       + "<th class='th02'>Dest</th>"
	       + "<th class='th02'>Div</th>"	       
	       + "<th class='th02'>Long Item Number</th>"
	       + "<th class='th02'>Qty</th>"
	       + "<th class='th02'>Sku</th>"
	       + "<th class='th02'>Description</th>"
	       + "<th class='th02'>Ret</th>"
	       + "<th class='th02'>Vendor Name</th>"
	    + "</tr>"
	    ;
	    
	    for(var i=0; i < cls.length;i++)
	    {
	    	panel += "<tr class='trDtl04'>"
	    	   + "<td class='td11'>" + doc[i] + "</td>"
	    	   + "<td class='td11'>" + po[i] + "</td>"
	    	   + "<td class='td11'>" + str[i] + "</td>"
	    	   + "<td class='td11'>" + div[i] + "</td>"
		       + "<td class='td11' nowrap>" + cls[i] + "-" + ven[i] + "-" + sty[i] + "-" + clr[i] + "-" + siz[i] + "</td>"	
		       + "<td class='td11'>" + qty[i] + "</td>"
		       + "<td class='td11'><a href='javascript: getSlsBySku(&#34;" + sku[i] + "&#34;, &#34;" 
		                    + str + "&#34;)'>" + sku[i] + "</a></td>"
		       + "<td class='td11' nowrap>" + desc[i] + "</td>"
		       + "<td class='td11'>" + ret[i] + "</td>"
		       + "<td class='td11' nowrap>" + venNm[i] + "</td>"
		    + "</tr>"
		    ;
	    }
		panel += "</table>  <p style='text-align:center'>";
	    panel += "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
	    ;
	        
	return panel;
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
            <br>Pending Distributions Were Not Picked   
            <br>Div: <%if(sDiv.equals("0")){%>All<%} else {%><%=sDiv%><%}%>   
            <br>Status: <%=sSts%> - 
              <%if(sSts.equals("R")){%>Ready To Pick<%}
              else if(sSts.equals("C")){%>Being Pick<%}
              else if(sSts.equals("M")){%>Pending Shipment<%}
              else if(sSts.equals("T")){%>In Transit<%}%>    
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
          <th class="th02" rowspan=2>Distro<br>Date</th>
          <th class="th02" rowspan=2>Total<br>Qty</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=<%=vColGrp.size()%>>
           <%if(sByGrp.equals("Str")){%>Stores<%} else {%>Divisions<%}%>
          </th>
        </tr>    
        
        <tr class="trHdr01">
          <%for(int i=0; i < vColGrp.size(); i++){%>
          	<th class="th02"><%=vColGrp.get(i)%></th>
          <%} %>
        </tr>
        
        <%
        String sRowCls = "trDtl06";
        for(int i=0; i < vDate.size(); i++){
        	if(sRowCls.equals("trDtl06")){ sRowCls = "trDtl04";}
        	else { sRowCls = "trDtl06"; }
        %>
          <%if(i > 0 && i % 20 == 0){%>
          	<tr class="trHdr01">
          		<th class="th02">DistroDate</th>
          		<th class="th02">Total</th>
          		<th class="th02">&nbsp;</th>  
          		<%for(int j=0; j < vColGrp.size(); j++){%>
          	        <th class="th02"><%=vColGrp.get(j)%></th>
                <%}%>        		
        	</tr>    
          <%}%>
          <tr id="trId" class="<%=sRowCls%>">
	        <td class="td11" nowrap><%=vDate.get(i)%></td>
	        <td class="td11" nowrap><%=vTotQty.get(i)%></td>
	        <td class="td43" nowrap>&nbsp;</td>
	        
	       <%
	        if(sByGrp.equals("Str"))
	   	    {
	        	sStmt = "select sstr as cols" 
	        	+ ", (select dec(sum(dqty ),9,0) from IpTsFil.IpPnDst " 
	        	+ " inner join IpTsFil.IpClass on ccls=dcls"
	        	+ " where dds#=sstr"	    	
	        	+ " and dis#=1 and dds# <> 1 and dds# <> 70 and dalc > 0 and dsts = '" + sSts + "'" 
	        	+ " and ddti = '" + vDate.get(i) + "'";

	        	// select division
	  	 		if(!sDiv.equals("0")){ sStmt += " and cdiv = " + sDiv; }
	        
	        	sStmt += ") as qty";
	        	sStmt += " from IpTsFil.IpStore"	        
	        	+ " where ssts='S' and sstr <> 75 and sdci > current date"	        
		        + " order by sstr"
	    	    ;	
	   	    }
	        else 
	        {
	        	sStmt = "select ddiv as cols" 
	    	   	+ ", (select dec(sum(dqty ),9,0)" 
	        		+ " from IpTsFil.IpPnDst " 
	    	    	+ " inner join IpTsFil.IpClass on ddiv=cdiv and ccls=dcls"
	    	    	+ " where dis#=1 and dalc > 0 and dsts = '" + sSts + "'" 
	    	    	+ " and exists(select 1 from IpTsFil.IpStore"	        
	    		       	+ " where ssts='S' and sstr <> 75 and sdci > current date"
	    		       	+ " and dds#=sstr)"
	    	    	+ " and ddti = '" + vDate.get(i) + "'";

	    	    // select division
	    	  	if(!sDiv.equals("0")){ sStmt += " and cdiv = " + sDiv; }
	    	        
	    	    sStmt += ") as qty";
	    	    sStmt += " from IpTsFil.IpDivsn"
	    		+ " order by ddiv"
	    	    ;	
	        }
	       
	        System.out.println("\n" + sStmt);
	        
	        runsql = new RunSQLStmt();
	        runsql.setPrepStmt(sStmt);
	        rs = runsql.runQuery();
	        int j=0;
	        while(runsql.readNextRecord())
	        {	        	
	        	String sStrQty = runsql.getData("qty");
	        	if(sStrQty == null){ sStrQty = "&nbsp;" ;}
	        	String sCols = runsql.getData("cols").trim();
	        	j++;
	       %>	     
	         <td class="td11" nowrap>
	         	<%if(!sStrQty.equals("&nbsp;")){%>
	         	   <%if(sByGrp.equals("Str")){%>
	         			<a href="javascript: getCellDtl('<%=vDate.get(i)%>', '<%=sCols%>', <%=sDiv%>)"><%=sStrQty%></a>
	         	   <%} else {%>
	         	   		<a href="javascript: getCellDtl('<%=vDate.get(i)%>', 'ALL', <%=sCols%>)"><%=sStrQty%></a>
	         	   <%}%> 	
	         	<%} else {%><%=sStrQty%><%}%>
	         </td>   
	       <%}%> 
	      </tr>   
        <%}%>
       </table>
       
      
    </td>
   </tr>
 </table>
   
 </body>
</html>
<%}%>