<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet"%>  
<%
	String sSelVen = request.getParameter("Ven");
	String sSelVenNm = request.getParameter("VenNm");
	
if (session.getAttribute("USER")!=null)
{
	 
	String sStmt = "with itemf as (" 
	    + "select  ADGTIN, ADVSTYLE"
		+ " from rci.rc846"
		+ " where ADVENHDR = " + sSelVen
		+ " and adsts = ' '"
		+ " and adcls = 0 and ADDTAVL >= current date - 2 days and ADQTYAVL > 0"
		+ " and not exists(select 1 from iptsfil.IpItHdr where igtin like('%' concat trim(adgtin) concat '%') )"
		+ " group by ADGTIN, ADVSTYLE"
		+ ")" 
		+ " select ADGTIN, ADVSTYLE" 
		+ ", (select ADQTYAVL from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE" 
		+ " order by ADDTAVL desc, ADTMAVL desc  fetch first 1 row only) as ADQTYAVL" 
		+ ", (select ADCOST from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE" 
		+ " order by ADDTAVL desc, ADTMAVL desc  fetch first 1 row only) as ADCOST" 
		+ ", (select ADDTAVL from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE"
		+ " order by ADDTAVL desc, ADTMAVL desc  fetch first 1 row only) as ADDTAVL" 
		+ ", (select digits(ADTMAVL) from rci.rc846 b where a.adgtin=b.adgtin and a.ADVSTYLE=b.ADVSTYLE"
		+ " order by ADDTAVL desc, ADTMAVL desc  fetch first 1 row only) as ADTMAVL"
		+ " from itemf a" 
		+ " order by ADGTIN"
	;
		
	System.out.println("\n" + sStmt);	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vGtin = new Vector();
	Vector<String> vVenSty = new Vector();
	Vector<String> vQty = new Vector();
	Vector<String> vCost = new Vector();
	Vector<String> vAvailDt = new Vector();
	Vector<String> vAvailTm = new Vector();
	
	while(runsql.readNextRecord())
	{
		vGtin.add(runsql.getData("ADGTIN").trim());
		vVenSty.add(runsql.getData("ADVSTYLE").trim());
		vQty.add(runsql.getData("ADQTYAVL").trim());
		vCost.add(runsql.getData("ADCOST").trim());
		vAvailDt.add(runsql.getData("ADDTAVL").trim());	
		vAvailTm.add(runsql.getData("ADTMAVL").trim());	
	}
	rs.close();
	runsql.disconnect();
	
	
	%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>Undefined In IP for VDS</title>

<SCRIPT>
//--------------- Global variables -----------------------
var BegTime = "Current";
var progressIntFunc = null;
var progressTime = 0;

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
            <br>Undefined Items (In IP) Available VDS
 
            <br>Vendor: <%=sSelVen%> - <%=sSelVenNm%>            
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
          <th class="th02">No.</th>
          <th class="th02">GTIN</th>
          <th class="th02">Vendor Style</th>
          <th class="th02">QTY</th>
          <th class="th02">Cost</th>
          <th class="th02">Avalable<br>Date/Time</th>
          <th>Search<br>on<br>Google</th>
        </tr>    
        <%
        for(int i=0; i < vGtin.size(); i++){
        %>
          <tr id="trId" class="trDtl04">
            <td class="td12" nowrap><%=i+1%></td>
	        <td class="td12" nowrap><%=vGtin.get(i)%></td>
	        <td class="td11" nowrap><%=vVenSty.get(i)%></td>
	        <td class="td18" nowrap><%=vQty.get(i)%></td>
	        <td class="td18" nowrap><%=vCost.get(i)%></td>
	        <td class="td18" nowrap><%=vAvailDt.get(i)%> <%=vAvailTm.get(i)%></td>
	        <td class="td18" nowrap><a href="https://www.google.com/search?q=<%=vGtin.get(i)%>&tbm=shop#" target="_blank">Google</a>
	      </tr>   
        <%}%>
       </table>
       <br>
       <br>
       
        
    </td>
   </tr>
 </table>
   
 </body>
</html>
<%}%>