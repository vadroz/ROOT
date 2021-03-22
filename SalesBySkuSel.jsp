<%@ page import=" rciutility.StoreSelect, inventoryreports.PiCalendar"%>
<%
   String sSelStr = request.getParameter("Str");
   String sSelSku = request.getParameter("Sku");
   String sSelDate = request.getParameter("Date");

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect(4);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   // get PI Calendar
   PiCalendar setcal = new PiCalendar();
   String sYear = setcal.getYear();
   String sMonth = setcal.getMonth();
   String sDesc = setcal.getDesc();
   setcal.disconnect();
%>
<title>Sku Hist Sel</title>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];

var SelStr = null;
var SelSku = null;
var SelDate = null;
<%if(sSelSku != null){%>
  SelStr = "<%=sSelStr%>"
  SelSku = "<%=sSelSku%>"
  SelDate = "<%=sSelDate%>"
<%}%>

var NewSku = "";
var NewDesc = "";
var NewStrQty = "";
var NewOnRtv = "";
var NewOnMos = "";
var NewRemind = "";
var NewRet = "";
var NewDiv = "";
var NewCls = "";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }	
	
	var sel_Str= "<%=request.getParameter("STORE")%>";
  	var str_opt;

  	doStrSelect();
  
  	setDateSel(false);  
  
  	popPICal();

  	if(SelSku != null){ document.forms[0].Sku.value = SelSku }
  
  	if(document.all.SvStr.value != ""){ setOldVal(); }  
}
//==============================================================================
// set selection fileds with previously enterd values
//==============================================================================
function setOldVal()
{
	// set store
	var str = document.all.SvStr.value;
	for(var i=0; i < document.all.STORE.length;i++)
	{
		if(str == document.all.STORE[i].value)
		{
			document.all.STORE.selectedIndex = i;
			break;
		}
	}
	
	var pical = document.all.SvPiCal.value;
	
	//document.all.Sku.value = document.all.SvSku.value;
	
	document.all.FromDate.value = document.all.SvFrDt.value;
	document.all.ToDate.value = document.all.SvToDt.value;	
	setDateSel( document.all.FromDate.value != "01/01/0001"); 
	 	
	for(var i=0; i < document.all.PICal.length;i++)
	{
		if(pical == document.all.PICal[i].value)
		{
			document.all.PICal.selectedIndex = i;
			break;
		}
	}
	
}
//==============================================================================
// check date type selection
//==============================================================================
function setDateSel(sel)
{
	if(sel)	
	{ 
		doSelDate();
		document.all.trSelDt.style.display = "none";
		document.all.trFrDt.style.display = "block";
		document.all.trToDt.style.display = "block";
	}
	else
	{
		document.all.trSelDt.style.display = "block";
		document.all.trFrDt.style.display = "none";
		document.all.trToDt.style.display = "none";
		document.all.FromDate.value = "01/01/0001";
		document.all.ToDate.value = "12/31/2099";
	}
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var date = new Date(new Date());
  date.setHours(18)
  document.all.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

  date = new Date(date - 86400000 * 30);
  document.all.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  if(SelDate != null){ document.all.FromDate.value = SelDate; document.all.ToDate.value = SelDate }
}

//==============================================================================
// populate date with yesterdate
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
// Load Stores
//==============================================================================
function doStrSelect() {
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];
    
    for (idx = 1; idx < stores.length; idx++)
    {
    	document.all.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    	if(SelStr != null && SelStr == stores[idx]){ document.all.STORE.selectedIndex = idx-1 }
    }
}
//==============================================================================
// change Store selection
//==============================================================================
function popPICal()
{
   for(var i=0; i < PiYear.length; i++)
   {
      document.all.PICal.options[i] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
   }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
	var error = false;
  	var msg = " ";
  	var id_str = document.all.STORE.selectedIndex;
  	var sel_Str = document.all.STORE.options[id_str].value;
  
  	var pcidx = document.all.PICal.selectedIndex;
  	var pc = document.all.PICal.options[pcidx].value;

  	var sku = document.all.Sku.value;
  	if(sku.trim()=="")
  	{
  		msg = "Please, enter SKU or UPC code"
     	error = true;
  	}
 
  	var from = document.all.FromDate.value;
  	var to = document.all.ToDate.value;
  	
  	if (error) alert(msg);
  	else { sbmSlsSku(sku, sel_Str, from, to, pc); }
}
//==============================================================================
// submit sales sku search
//==============================================================================
function sbmSlsSku(sku, str, from, to, pc)
{
	document.getElementById("SvStr").value = str;
	document.getElementById("SvFrDt").value = from;
	document.getElementById("SvToDt").value = to;
	document.getElementById("SvPiCal").value = pc;
	
	var url = "PIItmSlsHst.jsp?STORE=" + str
	  + "&Sku=" + sku
	  + "&FromDate=" + from
	  + "&ToDate=" + to
	  + "&PICal=" + pc
	window.location.href = url;
	
}
//==============================================================================
//get sku info
//==============================================================================
function getSkuInfo(obj)
{
	var error=false;
	var msg="";
	
	var item = obj.value.trim();
	if(item != "")
	{
		var search = getScannedItem(item);
		if(search == "") { error = true; msg = "Item is not found on System."; br="<br>";}
	
		if(error){alert(msg); }
		else
		{
			obj.value = NewSku;
		}
	}
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(item)
{
	var url = "MosCtlValidItem.jsp?Item=" + item
		+ "&Str=1";

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
    		
    		valid = parseElem(resp, "UPC_Valid") == "true";
		    NewSku = parseElem(resp, "SKU");
    		NewStrQty = parseElem(resp, "QTY");    		
    		NewOnRtv = parseElem(resp, "OnRTV");
    		NewOnMos = parseElem(resp, "OnMOS");
    		NewRemind = eval(NewStrQty) - eval(NewOnRtv) - eval(NewOnMos);    		
    		NewDesc = parseElem(resp, "DESC"); 
    		NewRet = parseElem(resp, "RET");
    		NewDiv = parseElem(resp, "DIV");
    		NewCls = parseElem(resp, "CLS");
    		
    		//clearInterval( progressIntFunc );
    		//document.all.dvWait.style.visibility = "hidden";
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return NewSku;
}

//==============================================================================
//parse XML elements
//==============================================================================
function parseElem(resp, tag )
{
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	return resp.substring(beg, end);
}
</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>



<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item History (All Activity by SKU or UPC) - Selection</B>

   <!--  FORM  method="GET" action="PIItmSlsHst.jsp" onSubmit="return Validate(this)" -->
      <TABLE>
       <TBODY>
        <!-- =============================================================== -->
        <TR id="trSku">
          <TD align=right ><br>Short Sku or UPC:</TD>
           <TD><br>
              <input name="Sku" type="text" size="20" maxlength="14" onblur="getSkuInfo(this)">&nbsp;&nbsp;
              <INPUT type="hidden" value="1" name="SlsOnTop"></TD>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left>   
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>
        <!-- ======================== From Date ======================================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR id="trSelDt">
          <TD class=DTb1 align=center colspan=2>
              <button class="Small"  onclick="setDateSel(true)">Select Date</button>
          </TD>          
        </TR>
        
        <TR id="trFrDt">
          <TD class=DTb1 align=right >From Date:</TD>
          <TD valign="middle">
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDate')">&#60;</button>
              <input name="FromDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 590, 200, document.all.FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>              
          </TD>
        </TR>
        <!-- ======================== To Date ======================================= -->
        <TR id="trToDt">
          <TD class=DTb1 align=right >To Date:</TD>
          <TD>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input name="ToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 590, 300, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <br><br><button class="Small"  onclick="setDateSel(false)">All Date</button>
          </TD>
        </TR>
        <tr>
            <td colspan=3 style="font-size:11px;">
            	Note:  Default date range is last Full PI Count to present day. Click 
            	<b>Selection Date</b> ONLY to specify a different date Range other than 
            	the default.
            	</div>
            </td>
        </tr>    
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell" colspan=2 nowrap>Display counts from PI Calendar:
          <select name="PICal"></select>
          <br><br>
          <div style="font-size:11px;">
            	Note:  This selection does not affect the search history of the SKU in question. This ONLY
            	changes which PI Count result are shown.
            	</div>
          </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <button name="SUBMIT" onclick="Validate()">Submit</button> 
               <input type="hidden" name="SvSku">              
           </TD>
          </TR>
         </TBODY>
        </TABLE>
       <!-- /FORM -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
   <input name="SvStr" type="hidden">
   <input name="SvFrDt" type="hidden">
   <input name="SvToDt" type="hidden">
   <input name="SvPiCal" type="hidden">
</BODY></HTML>
