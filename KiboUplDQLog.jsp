<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet"%>  
<%
 String sDate = request.getParameter("Date");

 boolean bToday = false;
 if(sDate == null)
 {
	 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	 sDate = formatter.format(new Date());
	 bToday = true;
 }
 else
 {
	 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	 String sToday = formatter.format(new Date());
	 bToday = sToday.equals(sDate);
 }

if (session.getAttribute("USER")!=null)
{
	 
	String sStmt = "select DLPARENT" 
	 + ", digits(DLCLS) as DLCLS, digits(DLVEN) as DLVen, digits(DLSTY) as DLSty" 
	 + ", digits(DLCLR) as DLClr, digits(DLSIZ) as DLSiz" 
	 + ",DLRECUS,DLRECDT,DLRECTM,DLPROC"
	 + ", (select vnam from IpTsFil.IpMrVen where vven=dlven) as vennm"
	 + ", (select ides from IpTsFil.IpItHdr where icls=dlcls and iven=dlven and isty=dlsty fetch first 1 row only) as desc"
	 + ", case when dlparent='2' then (select clrn from IpTsFil.IpColor where cclr=dlclr) else ' ' end as clrnm"
	 + ", case when dlparent='2' then (select snam from IpTsFil.IpSizes where ssiz=dlsiz) else ' ' end as siznm"
	 + ", case when iderr is null then ' ' else iderr end as iderr"
	 + " from rci.MoDqLog"	  
	 + " left join rci.moitdlog on idsite='11961' and DLITDTS=idrects and idcls=dlcls and idven=dlven and idsty=dlsty and idclr=dlclr and idsiz=dlsiz"
	 + " where DLDQUE='MONEWITM'" 
	 + " and DlRecDt = '" + sDate + "'"
	 + " order by rrn(rci.MoDqLog) desc"
	 ;
	
	//System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vParent = new Vector<String>();
	Vector<String> vCls = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vSty = new Vector<String>();
	Vector<String> vClr = new Vector<String>();
	Vector<String> vSiz = new Vector<String>();
	Vector<String> vRecUs = new Vector<String>();
	Vector<String> vRecDt = new Vector<String>();
	Vector<String> vRecTm = new Vector<String>();
	Vector<String> vProc = new Vector<String>(); 
	Vector<String> vVenNm = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
	Vector<String> vClrNm = new Vector<String>();
	Vector<String> vSizNm = new Vector<String>();
	Vector<String> vError = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vParent.add(runsql.getData("DLPARENT").trim());	
		vCls.add(runsql.getData("dlcls").trim());
		vVen.add(runsql.getData("dlven").trim());	
		vSty.add(runsql.getData("dlsty").trim());	
		vClr.add(runsql.getData("dlclr").trim());	
		vSiz.add(runsql.getData("dlsiz").trim());	
		vRecUs.add(runsql.getData("dlrecus").trim());	
		vRecDt.add(runsql.getData("dlrecdt").trim());	
		vRecTm.add(runsql.getData("dlrectm").trim());	
		vProc.add(runsql.getData("dlproc").trim());
		vVenNm.add(runsql.getData("vennm").trim());
		vDesc.add(runsql.getData("desc").trim());
		vClrNm.add(runsql.getData("clrnm").trim());
		vSizNm.add(runsql.getData("siznm").trim());
		vError.add(runsql.getData("iderr").trim());
	}
	rs.close();
	runsql.disconnect();
	
	SimpleDateFormat fmtYmd = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat fmtMdy = new SimpleDateFormat("MM/dd/yyyy");
	
	String sSelDate = fmtMdy.format(fmtYmd.parse(sDate));
	
%>
<html>
<head>
<%if(bToday){%>
	<meta http-equiv="refresh" content="30">
<%}%>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>KIBO - Item Upload Log</title>

<SCRIPT>
//--------------- Global variables -----------------------
var BegTime = "Current";
var progressIntFunc = null;
var progressTime = 0;
 
var SelDate = "<%=sSelDate%>";
var NumOfRec = "<%=vCls.size()%>"

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
	
	document.all.Date.value = SelDate; 
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
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
var button = document.all[id];
var date = new Date(button.value);


if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
else if(direction == "UP") date = new Date(new Date(date) - -86400000);
button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
//re-submit report with another date
//==============================================================================
function  sbmReport()
{
	var date = document.all.Date.value;
	
	var datePart = date.match(/\d+/g)
	
	var month = datePart[0];
	var day = datePart[1];
	var year = datePart[2];
	
	if(day.length == 1){ day = "0" + day; }
	if(month.length == 1){ month = "0" + month; }

	date = year + '-' + month + '-' + day;
	
	var url = "KiboUplDQLog.jsp?Date=" + date
	window.location.href=url;
}
//==============================================================================
//re-submit report with another date
//==============================================================================
function setFilter(obj)
{
	var filter = obj.value;
	
	for(var i=0; i < NumOfRec; i++)
	{	
		var proc = document.getElementById("tdProc" + i).innerHTML;
		 
		if(filter=="A")
		{
			document.getElementById("trItem" + i).style.display = "table-row";
		}
		else if(filter=="B")
		{
			if(proc==""){ document.getElementById("trItem" + i).style.display = "table-row"; }
			else{ document.getElementById("trItem" + i).style.display = "none"; }
		}
		else if(filter=="Y")
		{
			if(proc=="Y"){ document.getElementById("trItem" + i).style.display = "table-row"; }
			else{ document.getElementById("trItem" + i).style.display = "none"; }
		}
		else if(filter=="E")
		{
			if(proc=="E")
			{ 
				document.getElementById("trItem" + i).style.display = "table-row"; 
			}
			else
			{ 
				document.getElementById("trItem" + i).style.display = "none"; 
			}
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
            <br>KIBO - Item Upload Queue             
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font>
              <br>
             
             <b>Select Upload Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Date')">&#60;</button>
              <input class="Small" name="Date" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'Date')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 600, 200, document.all.Date)">
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              &nbsp;&nbsp;
              <button class="Small" name="Go" onClick="sbmReport()">Go</button>
             <br>
             <br>
              <table class="tbl02">
              	<tr class="trDtl04">
              	    <td rowspan="3">Proc Flag:<br><input type="radio" name="SelFlag" value="A" onclick="setFilter(this)" checked></td>
              	    <td class="td11"><input type="radio" name="SelFlag" value="B" onclick="setFilter(this)">Blank = Being sent to KIBO</td>
              	</tr>
                <tr class="trDtl04">
                	<td class="td11"><input type="radio" name="SelFlag" value="Y" onclick="setFilter(this)">Y = Sent to KIBO</td></tr>
                <tr class="trDtl04">
                	<td class="td11"><input type="radio" name="SelFlag" value="E" onclick="setFilter(this)">E = Errors</td></tr>
              </table>
          </th>                    
        </tr>
         
  <tr class="trHdr">
    <td>
       <table class="tbl02" id="tblSsn">
        <tr class="trHdr01">
          <th class="th02">No.</th>
          <th class="th02">Parent=1<br>Child=2</th>
          <th class="th02">Item Number</th>
          <th class="th02">Proc<br>Flag</th>          
          <th class="th02">Submitted<br>User/Date/Time</th>
          <th class="th02">Vendor Name</th>
          <th class="th02">Item Description</th>
          <th class="th02">Color Name</th>
          <th class="th02">Size Name</th>
          <th class="th02">Error</th>
        </tr>    
        
         
        
        <%
        String sRowCls = "trDtl06";
        for(int i=0; i < vCls.size(); i++){
        	if(vProc.get(i).equals("Y")){ sRowCls = "trDtl06";}
        	else if(vProc.get(i).equals("")) { sRowCls = "trDtl04"; }
        	if(vProc.get(i).equals("E")) { sRowCls = "trDtl13"; }
        %>
          
          <tr class="<%=sRowCls%>" id="trItem<%=i%>">
            <td class="td12" nowrap><%=i+1%></td>
            <td class="td18" nowrap><%=vParent.get(i)%></td>
	        <td class="td11" nowrap>
	        <%=vCls.get(i)%>-<%=vVen.get(i)%>-<%=vSty.get(i)%><%if(vParent.get(i).equals("2")){%>-<%=vClr.get(i)%><%=vSiz.get(i)%><%}%>
	        </td>	        
	        <td class="td18" id="tdProc<%=i%>" nowrap><%=vProc.get(i)%></td>
	        <td class="td11" nowrap><%=vRecUs.get(i)%> <%=vRecDt.get(i)%> <%=vRecTm.get(i)%></td>
	        <td class="td11" nowrap><%=vVenNm.get(i)%></td>
	        <td class="td11" nowrap><%=vDesc.get(i)%></td>
	        <td class="td11" nowrap><%=vClrNm.get(i)%></td>
	        <td class="td11" nowrap><%=vSizNm.get(i)%></td>
	        <td class="td11" nowrap><%=vError.get(i)%></td>
	      </tr>   
        <%}%>
       </table>
       
      
    </td>
   </tr>
 </table>
   
 </body>
</html>
<%}%>