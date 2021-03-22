<!DOCTYPE html>	
<%@ page import="inventoryreports.PiAreaEnt, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sPICal = request.getParameter("PICal");   
   String sFrom = request.getParameter("From");
   String sSize = request.getParameter("Size");   
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "AREA"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PiAreaEnt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	/*(sStr, sPiYr, sPiMo, sFrom, sSize, sSort, sUser )*/
	String sPiYr = sPICal.substring(0, 4);
	String sPiMo = sPICal.substring(4);
	PiAreaEnt piarea = new PiAreaEnt();
	System.out.println(sPiYr + " " + sPiMo);
	piarea.setStrArea(sStore, sPiYr, sPiMo, sFrom, sSize, sSort, sUser);

	int iNumOfArea = piarea.getNumOfArea();  
	
	String sSelStr = "ALL";
	String sStrAllowed = session.getAttribute("STORE").toString();
	if(!sStrAllowed.startsWith("ALL")){ sSelStr = sStrAllowed; }
	
	String sStrLst = "";
    String sStrNameLst = "";
	
    if (sSelStr.equals("ALL"))
    { 
		StoreSelect strlst = new StoreSelect(22);
    	int iNumOfStr = strlst.getNumOfStr();
    	sStrLst = strlst.getStrNum();
    	sStrNameLst = strlst.getStrName();
    }
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>PI Area Count</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var PiCal = "<%=sPICal%>";
var From = "<%=sFrom%>";
var Size = "<%=sSize%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";
var NumOfArea = "<%=iNumOfArea%>";

var ArrStr = [<%=sStrLst%>];
var ArrStrNm = [<%=sStrNameLst%>];

var aItems = new Array();
var MxItem = 0;

var progressIntFunc = null;
var progressTime = 0;

var CurrArea = null;
var UpdCol = null;
 
 
window.onkeydown = function(e) 
{
   var key = e.keyCode ? e.keyCode : e.which;
   if(key == 8 ) { e.preventDefault ? e.preventDefault() : (e.returnValue = false); }	   
}
 
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
  
}
//==============================================================================
// select/change return item  
//==============================================================================
function setLineEntry(line)
{		
	UpdCol = null;
	var name = "Area" + line;
	var area = document.all[name];
	CurrArea = area.value;
	
	name = "trArea" + line;
	var row = document.all[name];
	
	name = "WisCnt" + line;
	var wcnt = document.all[name];	
	name = "RciCnt" + line;
	var rcnt = document.all[name];
	name = "RecUsr" + line;
	var recusr = document.all[name];
	name = "ReCount" + line;
	var recnt = document.all[name];
	name = "Commt" + line;
	var commt = document.all[name];
	
	row.style.background = "white";
	
	wcnt.readOnly = false;
	rcnt.readOnly = false;
	recusr.readOnly = false;
	recnt.readOnly = false;	
	commt.readOnly = false;
	
	rcnt.blur();
	recusr.blur();
	commt.blur();
	
	wcnt.focus();
	wcnt.select();	
}

//==============================================================================
// set Update 1 column only
//==============================================================================
function setUpdColOnly(grp, line)
{	
	if(line == 0){ setBackClr(); }
	
	UpdCol = grp;
	var name = "Area" + line;
	var area = document.all[name];
	CurrArea = area.value;
	
	name = "trArea" + line;
	var row = document.all[name];
	
	name = "WisCnt" + line;
	var wcnt = document.all[name];	
	name = "RciCnt" + line;
	var rcnt = document.all[name];
	name = "RecUsr" + line;
	var recusr = document.all[name];
	name = "ReCount" + line;
	var recnt = document.all[name];
	name = "Commt" + line;
	var commt = document.all[name];
	
	row.style.background = "white";
	
	wcnt.blur();
	rcnt.blur();
	recusr.blur();
	commt.blur();
	
	
	if(grp == "WisCnt")  { wcnt.readOnly = false;   wcnt.style.background="yellow"; wcnt.focus(); wcnt.select(); } else { wcnt.readOnly = true; }
	if(grp == "RciCnt")  { rcnt.readOnly = false;   rcnt.style.background="yellow"; rcnt.focus(); rcnt.select(); } else { rcnt.readOnly = true; }
	if(grp == "RecUsr")  { recusr.readOnly = false; recusr.style.background="yellow"; recusr.focus(); recusr.select(); } else { recusr.readOnly = true; }
	if(grp == "ReCount") { recnt.readOnly = false;                                    recnt.focus(); recnt.select(); } else { recnt.readOnly = true; }
	if(grp == "Commt")   { commt.readOnly = false;  commt.style.background="yellow"; commt.focus(); commt.select(); } else { commt.readOnly = true; }
}
//==============================================================================
// set white color on background of all input field 
//=============================================================================	
function setBackClr()
{
   for(var i=0; i < NumOfArea ;i++)
   {
	    name = "WisCnt" + i;
		var wcnt = document.all[name];
		wcnt.style.background="white";
		name = "RciCnt" + i;
		var rcnt = document.all[name];
		rcnt.style.background="white";
		name = "RecUsr" + i;
		var recusr = document.all[name];
		recusr.style.background="white";
		//name = "ReCount" + i;
		//var recnt = document.all[name];
		//recnt.style.background="white";
		name = "Commt" + i;
		var commt = document.all[name];
		commt.style.background="white";
   }	
}
//==============================================================================
//check which Key Down pressed 
//==============================================================================
function chkKeyDown(grp, line, event)
{
	var name = grp + line;
	var obj = document.all[name];
	
	var name = "WisCnt" + line;
	var wcnt = document.all[name];	
	var name = "RciCnt" + line;
	var rcnt = document.all[name];
	var name = "RecUsr" + line;
	var recusr = document.all[name];
	var name = "ReCount" + line;
	var recnt = document.all[name];
	var name = "Commt" + line;
	var commt = document.all[name];
	
	var key = event.keyCode
		
	// enter key in any field or tab key in comment  
	if(key == 13 || key == 9 && UpdCol != null || key == 9 && grp == "Commt")
	{
		// save current line on comment field or selected column
		if(UpdCol != null || grp == "Commt")
		{  
			if (vldLine(grp, line))
			{
				sbmArea(line); 
				line++;
				if(line < NumOfArea)
				{ 
					if(UpdCol != null){setUpdColOnly(grp, line);}
					else{ setLineEntry(line); }
				}			
				 
			}
		}
		else if(vldLine(grp, line))
		{ 
			// jump to next field in line
			if(grp == "WisCnt") { rcnt.focus();	rcnt.select(); } 
			else if(grp == "RciCnt"){ recusr.focus(); recusr.select(); }
			else if(grp == "RecUsr"){ recnt[0].focus(); }
			else if(grp == "ReCount"){ commt.focus();	commt.select();	}
		}			
	}
	
	if(key == 9 ) { event.preventDefault ? event.preventDefault() : (event.returnValue = false); }
	if(key == 8 ) { event.preventDefault ? event.preventDefault() : (event.returnValue = false); }
}
//==============================================================================
// validate Line or single fiedls
//==============================================================================
function vldLine(grp, line)
{
	var error = false;
	var msg = "";
	var br = "";
	var name = "tdError" + line;
	var errfld = document.all[name];
	
	
	var name = "WisCnt" + line;
	var wcnt = document.all[name];	
	var name = "RciCnt" + line;
	var rcnt = document.all[name];
	var name = "RecUsr" + line;
	var recusr = document.all[name];
	var name = "ReCount" + line;
	var recnt = document.all[name];
	var name = "Commt" + line;
	var commt = document.all[name];	
	var name = "tdDiff" + line;
	var diff = document.all[name];
	
	errfld.innerHTML = "";
	
	if(grp=="ALL" || grp=="WisCnt")
	{
		if(isNaN(wcnt.value.trim())){ error = true; msg += br + "WIS Count is not numeric"; br = "<br>";}
		else if(eval(wcnt.value.trim()) < 0){ error = true; msg += br + "WIS Count is not positive"; br = "<br>";}
	}
	if(grp=="ALL" || grp=="WisCnt" || grp=="RciCnt")
	{
		if(isNaN(rcnt.value.trim())){ error = true; msg += br + "RCI Count is not numeric"; br = "<br>";}
		else if(eval(rcnt.value.trim()) < 0){ error = true; msg += br + "RCI Count is not positive"; br = "<br>";}
		else
		{ 
			try {
				diffcount = eval(wcnt.value) - eval(rcnt.value);
				diff.innerHTML = eval(wcnt.value) - eval(rcnt.value);	
				if(diffcount != 0){diff.style.background = "#F75D59";}
				else {diff.style.background = "lightgreen";}
			}
			catch(err) { diff.innerHTML = ""; }
		} 
	}
	
	if(error){errfld.innerHTML = msg;}
	
	return !error;
}
//==============================================================================
//submit area entries
//==============================================================================
function sbmArea(line)
{
	var url = "PiAreaEntSv.jsp";
		
	var name = "WisCnt" + line;
	var wcnt = document.all[name];	
	var name = "RciCnt" + line;
	var rcnt = document.all[name];
	var name = "RecUsr" + line;
	var recusr = document.all[name];
	var name = "ReCount" + line;
	var recnt = "N";
	
	if( document.all[name][0].checked ){recnt = "Y";}
	var name = "Commt" + line;
	var commt = document.all[name];
	
	var param = "str=" + Store
	 + "&area=" + CurrArea
	 + "&line=" + line
	 + "&piyr=" + PiCal.substring(0, 4)
	 + "&pimo=" + PiCal.substring(4)
	 + "&wis=" + wcnt.value
	 + "&rci=" + rcnt.value
	 + "&recusr=" + recusr.value
	 + "&recnt=" + recnt
	 + "&commt=" + commt.value
	 ;	 

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var resp = xmlhttp.responseText;
			var beg = resp.indexOf("<Area>") + 6;
      		var end = resp.indexOf("</Area>");
      		var area = resp.substring(beg, end);
      		
      		var resp = xmlhttp.responseText;
			var beg = resp.indexOf("<Line>") + 6;
      		var end = resp.indexOf("</Line>");
      		var updline = resp.substring(beg, end);
      		
      		var name = "trArea" + updline;
      		var row = document.all[name];
      		row.style.background = "#E0FFFF";
      		
      		if(line == NumOfArea - 1){ window.location.reload() }
   		}
	}
	xmlhttp.open("POST",url,true); // synchronize with this apps

	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", param.length);
	xmlhttp.setRequestHeader("Connection", "close");
	
	xmlhttp.send(param);
}

//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(item)
{
	var valid = true;
	var sku = null;
	var desc = null;
	var url = "EComItmAsgValidItem.jsp?Item=" + item;

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
   		if (xmlhttp.readyState==4 && xmlhttp.status==200)
   		{
      		var  resp = xmlhttp.responseText;
      		var beg = resp.indexOf("<UPC_Valid>") + 11;
      		var end = resp.indexOf("</UPC_Valid>");
      		valid = resp.substring(beg, end) == "true";

		    var beg = resp.indexOf("<SKU>") + 5;
      		var end = resp.indexOf("</SKU>");
      		sku = resp.substring(beg, end);
      		NewSku = sku;
      		
      		var beg = resp.indexOf("<DESC>") + 6;
      		var end = resp.indexOf("</DESC>");
      		desc = resp.substring(beg, end);
      		NewDesc = desc;      		
      		
      		clearInterval( progressIntFunc );
      		document.all.dvWait.style.visibility = "hidden";
   		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return sku.trim();
}

//==============================================================================
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
}
//==============================================================================
//reload page
//==============================================================================
function restart()
{
	window.location.reload();  
}
//==============================================================================
// re-sort page
//==============================================================================
function resort(sort)
{
		
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
// submit next page or set to new beginning or/and page size
//==============================================================================
function sbmNewSet(direct)
{
	var url ="PiAreaEnt.jsp?Store=" + Store + "&PICal=" + PiCal;
			
	if(direct == '1')
	{
		var from = eval(From) - eval(Size);
		if(from < 1){ from = 1;}
		url += "&From=" + from + "&Size=" + Size;
	}
	else if(direct == '2')
	{
		var from = eval(From) + eval(Size);
		url += "&From=" + from + "&Size=" + Size;
	}
	else if(direct == '3')
	{
		var from = document.all.From.value;
		var size = document.all.Size.value;
		url += "&From=" + from + "&Size=" + size;
	}
	
	window.location.href = url;
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()" >
  
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>PI Store Area Entry
            <br>Store: <%=sStore%>
             <br>
                 <a href="javascript: sbmNewSet('1')"><img alt="Arrow down" src="arrowLeft01.png"  width=30 height=20 style="border:none;"></a>
                 From Area: <input name="From" value="<%=sFrom%>" size=5 maxlength=4> &nbsp;  &nbsp; &nbsp;
                 <a href="javascript: sbmNewSet('2')"><img alt="Arrow down" src="arrowRight01.png"  width=30 height=20 style="border:none;"></a>
                 &nbsp;
                 
                 Page Size: <input name="Size" value="<%=sSize%>" size=5 maxlength=4> &nbsp;
                 <a href="javascript: sbmNewSet('3')">Go To</a> &nbsp;                 
                  
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PiAreaEntSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" >Area</th>
          <th class="th02" >Type</th>
          <th class="th02" >WIS<br>Count<br><a href="javascript: setUpdColOnly('WisCnt', '0')">Upd<br>Column
          	<br><img alt="Arrow down" src="arrowDown01.png" style="border:none"></a></th>
          <th class="th02" >RCI<br>Count<br><a href="javascript: setUpdColOnly('RciCnt', '0')">Upd<br>Column
          	<br><img alt="Arrow down" src="arrowDown01.png" style="border:none"></a></th>
          <th class="th02" >Unit<br>Diff</th>
          <th class="th02" >RCI<br>Team Member<br><a href="javascript: setUpdColOnly('RecUsr', '0')">Upd Only</a></th>
          <th class="th02" >Did<br>have to<br>recount<br>this?</th>
          <th class="th02" >Comment</th>
          <th class="th02" >Entry Validation<br>Error</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfArea; i++) {        	   
        	   piarea.setDetail();
   			   String sArea = piarea.getArea();
   			   String sType = piarea.getType();
   			   String sWisCnt = piarea.getWisCnt();
   			   String sRciCnt = piarea.getRciCnt();
   			   String sRecUsr = piarea.getRecUsr();
   			   String sReCount = piarea.getReCount();
   			   String sCommt = piarea.getCommt();
   			   String sHas = piarea.getHas();
   			   String sDiff = piarea.getDiff();
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>">
                <td class="td11" nowrap>
                    <a name="Line<%=i%>" href="javascript: setLineEntry('<%=i%>')"><%=sArea%>
                     &nbsp; <img alt="Arrow down" src="arrowRight01.png"  width=20 height=10 style="border:none;"></a>
                    <input name="Area<%=i%>" type="hidden" value="<%=sArea%>" readOnly size=5 maxlength=4>
                </td>
                <td class="td11" nowrap><%=sType%></td>
                <td class="td11" nowrap><input name="WisCnt<%=i%>" onkeydown="chkKeyDown('WisCnt', '<%=i%>', event)" value="<%=sWisCnt%>" readOnly size=5 maxlength=4></td>
                <td class="td11" nowrap><input name="RciCnt<%=i%>" onkeydown="chkKeyDown('RciCnt', '<%=i%>', event)" value="<%=sRciCnt%>" readOnly size=5 maxlength=4></td>
                <td  id="tdDiff<%=i%>" class="td12" style="background:#e7e7e7" nowrap><%=sDiff%></td>
                <td class="td11" nowrap><input name="RecUsr<%=i%>" onkeydown="chkKeyDown('RecUsr', '<%=i%>', event)" value="<%=sRecUsr%>" readOnly size=12 maxlength=10></td>
                <td class="td11" nowrap>
                   <input type="radio" name="ReCount<%=i%>" onkeydown="chkKeyDown('ReCount', '<%=i%>', event)" value="Y" <%if(sReCount.equals("Y")){%>checked<%}%> readOnly>Yes &nbsp; 
                   <input type="radio" name="ReCount<%=i%>" onkeydown="chkKeyDown('ReCount', '<%=i%>', event)" value="N" <%if(!sReCount.equals("Y")){%>checked<%}%> readOnly>No &nbsp;
                </td>
                <td class="td11" nowrap><input name="Commt<%=i%>" onkeydown="chkKeyDown('Commt', '<%=i%>', event)" value="<%=sCommt%>" readOnly></td>
                <td class="tdError" id="tdError<%=i%>" nowrap></td>
              </tr>
              <script></script>	
           <%}%> 
           <%
           	piarea.setTotal();
   			String sWisCnt = piarea.getWisCnt();
   			String sRciCnt = piarea.getRciCnt();
   			String sDiff = piarea.getDiff();
           %>          
            <tr id="trTotal" class="trDtl05">
                <td class="td11" nowrap>Store Total</td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap><%=sWisCnt%></td>
                <td class="td11" nowrap><%=sRciCnt%></td>
                <td class="td12" nowrap><%=sDiff%></td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
              </tr>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
piarea.disconnect();
piarea = null;
}
%>