<!DOCTYPE html>	
<%@ page import="ecommerce.EComFxUnship, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSelSku= request.getParameter("Sku");
   String sSelOrd= request.getParameter("Order");
   String sSort = request.getParameter("Sort");
   String [] sSelMth = request.getParameterValues("Mth");
   
   if(sSelSku == null){ sSelSku = " "; }  
   if(sSelOrd == null){ sSelOrd = " "; }
   if(sSort == null){ sSort = "STR"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=EComFxUnship.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	EComFxUnship fxunshp = new EComFxUnship(sSelStr, sSelMth, sFrDate, sToDate, sSelSku
			 , sSelOrd, sSort, sUser);
    int iNumOfItm = fxunshp.getNumOfItm();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Non Shipped FedEx</title>

<SCRIPT>

//--------------- Global variables -----------------------
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
var SelSku = "<%=sSelSku%>";
var SelOrd = "<%=sSelOrd%>"
var Sort = "<%=sSort%>"

var ArrSelStr = new Array();
<%for(int i=0; i < sSelStr.length; i++){%>ArrSelStr[<%=i%>] = "<%=sSelStr[i]%>";<%}%>

var ArrSelMth = new Array(); 
<%for(int i=0; i < sSelMth.length; i++){%>ArrSelMth[<%=i%>] = "<%=sSelMth[i]%>";<%}%>


//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getFedEx(site, ord, sku)
{	
	url = "EComFedExInfo.jsp?"
	    + "Site=" + site
	    + "&Order=" + ord.replace(/\b0+/g, '') 
	    + "&Action=GETFEDEX";

	window.frame1.location.href = url;
}
//==============================================================================
//show fedex data
//==============================================================================
function showFedEx(fxhdr, fxdtl)
{
	FxHdr = fxhdr;
	FxDtl = fxdtl;
	var hdr = "Federal Express Information. Order: " + fxhdr[0];
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popFedEx(fxhdr, fxdtl)
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=600;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
	  
	  if( fxhdr[5] != null && fxhdr[5] !=""){document.all.Cmpny.value = fxhdr[5];}
	  if( fxhdr[6] != null && fxhdr[6] !=""){document.all.Addrs1.value = fxhdr[6];}
	  if( fxhdr[8] != null && fxhdr[8] !=""){document.all.City.value = fxhdr[8];}
	  if( fxhdr[9] != null && fxhdr[9] !=""){document.all.State.value = fxhdr[9];}
	  if( fxhdr[10] != null && fxhdr[10] !=""){document.all.Zip.value = fxhdr[10];}
	  if( fxhdr[12] != null && fxhdr[12] !=""){document.all.Phone.value = fxhdr[12];}
	  
	  for(var i=0; i < fxdtl.length; i++)
	  {
		 var sts = "Status" + i;
		 var obj = document.all[sts];
		 obj.options[0] = new Option("None", "None");
		 obj.options[1] = new Option("SHIPPED", "SHIPPED");
		 if(fxdtl[i][3]=="SHIPPED"){ obj.selectedIndex = 1; }
		 else{ obj.selectedIndex = 0; }
	  }
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popFedEx(fxhdr, fxdtl)
	{		   
	   var panel = "<table class='tbl01' id='tblLog'>"
	    + "<tr>"
	       + "<th colspan='2' width='50%'>Shipping Address</th>"
	       + "<th colspan='2' width='50%'>Payments</th>"
	    + "</tr>"   
	    + "<tr>"   
	       + "<th class='th01'>Name</th><td class='td02'>" + fxhdr[3] + "&nbsp;</td>"
	       + "<th class='th01'>Total Shipping Cost</th><td class='td02'>" + fxhdr[15] + "&nbsp;</td>"
	    + "</tr>"   
		+ "<tr>"   
	       + "<th class='th01'>Company</th>"
	       + "<td class='td02'><input name='Cmpny' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='th01'>Shipping Method</th><td class='td02'>" + fxhdr[16] + "&nbsp;</td>"
	    + "</tr>"   
		+ "<tr>"   
	       + "<th class='th01'>Address 1</th>"
	       + "<td class='td02'><input name='Addrs1' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='th01'>Residential? (Y/N)</th><td class='td02'>" + fxhdr[18] + "&nbsp;</td>"
	    + "</tr>"   
		+ "<tr>"   
	       + "<th class='th01'>Address 2</th><td class='td02'>" + fxhdr[7] + "&nbsp;</td>"
	       + "<th class='th01'>Notification</th><td class='td02'>" + fxhdr[21] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='th01'>City</th>" 
	       + "<td class='td02'><input name='City' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='th01'>Notification Type</th><td class='td02'>" + fxhdr[22] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='th01'>State</th>" 
	       + "<td class='td02'><input name='State' class='Small' size='2' maxlength='2'></td>"
	       + "<th class='th01'>Delivery Note</th><td class='td02'>" + fxhdr[23] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='th01'>Zip Code</th>" 
	       + "<td class='td02'><input name='Zip' class='Small' size='10' maxlength='10'></td>"
	       + "<th class='th01'>Insurance</th><td class='td02'>" + fxhdr[26] + "&nbsp;</td>"
	    + "</tr>"	    
	    + "<tr>"   
	       + "<th class='th01'>Country</th><td class='td02'>" + fxhdr[11] + "&nbsp;</td>"
	       + "<th class='th01'>Insurance Option</th><td class='td02'>" + fxhdr[27] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='th01' nowrap>Phone Number</th>" 
	       + "<td class='td02'><input name='Phone' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='th01'>USPS</th><td class='td02'>" + fxhdr[24] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='th01'>Fax Number</th><td class='td02'>" + fxhdr[13] + "&nbsp;</td>"
	       + "<th class='th01'>USPS</th><td class='td02'>" + fxhdr[29] + "&nbsp;</td>"
	    + "</tr>"
	    
	    + "<tr>"   
	       + "<th class='th01'>E-Mail</th><td class='td02'>" + fxhdr[4] + "&nbsp;</td>"
	       + "<th class='th01'>Product Code</th><td class='td02'>" + fxhdr[17] + "&nbsp;</td>"
	    + "</tr>";
	panel += "</table> <br/>"
	    
	    // details
	panel += "<table class='tbl01' id='tblLog'>"
		    + "<tr class='trDtl02'>"
		       + "<th class='th01'>Store</th>"
		       + "<th class='th01'>SKU</th>"
		       + "<th class='th01'>S/N</th>"
		       + "<th class='th01'>Status</th>"
		       + "<th class='th01'>Description</th>"
		       + "<th class='th01'>Manufacturer</th>"
		       + "<th class='th01'>Retail</th>"
		       + "<th class='th01'>Pick ID</th>"
		       + "<th class='th01'>Pack ID</th>"		       		       
		    + "</tr>";
	    
	for(var i=0; i < fxdtl.length; i++)
	{
		panel += "<tr class='trDtl01'>"
		   + "<td class='td01'>" + fxdtl[i][0] + "&nbsp;</td>"
		   + "<td class='td01'>" + fxdtl[i][1] + "&nbsp;</td>"
		   + "<td class='td01'>" + fxdtl[i][2] + "&nbsp;</td>"
		   + "<td class='td01'><select name='Status" + i + "' class='Small'></select></td>"
		   + "<td class='td01'>" + fxdtl[i][4] + "&nbsp;</td>"
		   + "<td class='td01'>" + fxdtl[i][5] + "&nbsp;</td>"
		   + "<td class='td01'>" + fxdtl[i][6] + "&nbsp;</td>"
		   + "<td class='td01'>" + fxdtl[i][7] + "&nbsp;</td>"
		   + "<td class='td01'>" + fxdtl[i][8] + "&nbsp;</td>"
		 + "</tr>";
	}	    
	
	panel += "<tr>"
  		  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
		   + "</tr>";
		   
	panel += "</table>"
	        + "<button onClick='vldFedEx();' class='Small'>Save Changes</button>&nbsp; &nbsp;"
	        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}
//==============================================================================
//validate fed ex corrections
//==============================================================================
function vldFedEx()
{
	var error = false;
  var msg = "";
  document.all.tdError.innerHTML="";

  var cmpny = document.all.Cmpny.value.trim();    
  var addrs1 = document.all.Addrs1.value.trim();
  if(addrs1==""){error=true;msg += "Please enter Address 1 line"; }    
  var city = document.all.City.value.trim();
  if(city==""){error=true;msg += "Please enter City"; }
  var state = document.all.State.value.trim();
  if(state==""){error=true;msg += "Please enter State"; }
  var zip = document.all.Zip.value.trim();
  if(zip==""){error=true;msg += "Please enter Zip"; }
  var phone = document.all.Phone.value.trim();
  if(phone==""){error=true;msg += "Please enter Phone"; }
  
  var sts = new Array();
  for(var i=0; i < FxDtl.length; i++)
  {
  	var stsnm = "Status" + i;
  	var obj = document.all[stsnm];
  	sts[i] = obj.options[obj.selectedIndex].value;
  }
  
  if(error){ document.all.tdError.innerHTML=msg; }
  else{ sbmFedEx(cmpny, addrs1, city, state, zip, phone, sts); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmFedEx(cmpny, addrs1, city, state, zip, phone, sts)
{
	cmpny = cmpny.replace(/\n\r?/g, '<br />');
	addrs1 = addrs1.replace(/\n\r?/g, '<br />');
	city = city.replace(/\n\r?/g, '<br />');
	state = state.replace(/\n\r?/g, '<br />');
	zip = zip.replace(/\n\r?/g, '<br />');
	phone = phone.replace(/\n\r?/g, '<br />');

  var nwelem = window.frame1.document.createElement("div");
  nwelem.id = "dvSbmStrSts"

  var html = "<form name='frmChgFedEx'"
     + " METHOD=Post ACTION='EComFedExInfo.jsp'>"
     + "<input name='Order'>"
     + "<input name='Company'>"
     + "<input name='Address1'>"
     + "<input name='City'>"
     + "<input name='State'>"
     + "<input name='Zip'>"
     + "<input name='Phone'>"       
     + "<input name='Action'>"

  for(var i=0; i < sts.length ;i++)
  { 
  	html += "<input name='Sts'>"; 
  }

  html += "</form>"

  nwelem.innerHTML = html;
  window.frame1.document.appendChild(nwelem);

  window.frame1.document.all.Order.value = FxHdr[0];
  window.frame1.document.all.Company.value = cmpny;
  window.frame1.document.all.Address1.value = addrs1;
  window.frame1.document.all.City.value = city;
  window.frame1.document.all.State.value = state;
  window.frame1.document.all.Zip.value = zip;
  window.frame1.document.all.Phone.value = phone;    
  window.frame1.document.all.Action.value="Save";

  if(sts.length == 1)
  { 
  	window.frame1.document.all.Sts.value = sts[0]; 
  }
  else 
  {
  	for(var i=0; i < sts.length ;i++)
  	{
     		window.frame1.document.all.Sts[i].value = sts[i];
  	}
  }
  window.frame1.document.frmChgFedEx.submit();
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
// resort report
//==============================================================================
function resort(sort)
{	
	var url = "EcomFxUnship.jsp?"
	 + "FrDate=" + FrDate
	 + "&ToDate=" + ToDate
	 + "&Sku=" + SelSku
	 + "&Ord=" + SelOrd
	 + "&Sort=" + sort
	
	for(var i=0; i < ArrSelStr.length; i++)	{ url += "&Str=" + ArrSelStr[i]; }	
	for(var i=0; i < ArrSelMth.length; i++)	{ url += "&Mth=" + ArrSelMth[i]; }
	window.location.href=url;
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
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>E-Commerce - Items are not Shipped by FedEx   
            <br>Stores:
               <%String sComa = "";%>
               <%for(int i=0; i < sSelStr.length;i++){%>
                  <%if(i > 0 && i%20 == 0){%><br><%}%>
                  <%=sComa%><%=sSelStr[i]%>
                  <%sComa = ", ";%>
               <%}%>
            <br>Dates: <%=sFrDate%> - <%=sToDate%>
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="EComFxUnshipSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02"><a href="javascript: resort('ORD')">Order<br>#</a></th>
          <th class="th02"><a href="javascript: resort('ORDDT')">Order<br>Date</a></th>
          <th class="th02"><a href="javascript: resort('ITEM')">Item Number</a></th>
          <th class="th02"><a href="javascript: resort('DESC')">Description</a></th>
          <th class="th02"><a href="javascript: resort('SKU')">Short<br>SKU</a></th>
          <th class="th02"><a href="javascript: resort('STR')">Str<br>#</a></th>
          <th class="th02"><a href="javascript: resort('STS')">Status</a></th>
          <th class="th02"><a href="javascript: resort('SHPMTH')">Method Name</a></th>
          <th class="th02"><a href="javascript: resort('PACKID')">Pack ID</a></th>
          <th class="th02">Qty</th>    
          <th class="th02">FX</th>
          <th class="th02">Shipped/Packed<br>Date/Time</th>
          <th class="th02">Shipped/Packed<br>Packed By</th>
        </tr>
       
<!------------------------------- Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++) {
        	   fxunshp.setItemLst();
               
               String sOrd = fxunshp.getOrd();
               String sSku = fxunshp.getSku();
               String sStr = fxunshp.getStr();
               String sSts = fxunshp.getSts();
               String sPackId = fxunshp.getPackId();
               String sCls = fxunshp.getCls();
               String sVen = fxunshp.getVen();
               String sSty = fxunshp.getSty();
               String sClr = fxunshp.getClr();
               String sSize = fxunshp.getSiz();
               String sDesc = fxunshp.getDesc();
               String sMeth = fxunshp.getMeth();
               String sMethNm = fxunshp.getMethNm();
               String sOrdDt = fxunshp.getOrdDt();
               String sQty = fxunshp.getQty();
               String sStsUs = fxunshp.getStsUs();
               String sStsDt = fxunshp.getStsDt();
               String sStsTm = fxunshp.getStsTm();
           %>
              <tr id="trId" class="trDtl04">
                <td class="td12" nowrap><%=sOrd%></td>
                <td class="td12" nowrap><%=sOrdDt%></td>
                <td class="td11" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSize%></td>
                <td class="td11" nowrap><%=sDesc%></td>
                <td class="td12" nowrap><%=sSku%></td>                
                <td class="td12" nowrap><%=sStr%></td>
                <td class="td12" nowrap><%=sSts%></td>
                <td class="td11" nowrap><%=sMeth%>-<%=sMethNm%></td>
                <td class="td11" nowrap><%=sPackId%></td>
                <td class="td12" nowrap><%=sQty%></td>
                <th class="th01" style="vertical-align:middle;" id="thLog<%=i%>">
                       <a href="javascript: getFedEx('SASS' , '<%=sOrd%>', '<%=sSku%>');">&nbsp;FX&nbsp;</a>               
                </th>
                <td class="td11" nowrap><%=sStsDt%> <%=sStsTm%></td>
                <td class="td11" nowrap><%=sStsUs%></td>
              </tr>
           <%}%>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
fxunshp.disconnect();
fxunshp = null;
}
%>