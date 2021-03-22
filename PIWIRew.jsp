<%@ page import="inventoryreports.PiWiRew"%>
<%
  String sStore = request.getParameter("STORE");
  String sArea = request.getParameter("AREA");
  String sSortBy = request.getParameter("SORT");
  String sPiYearMo = request.getParameter("PICal");
  String sSum = request.getParameter("Sum");
  String sMbr = request.getParameter("Mbr");
  String sSelDiv = request.getParameter("Div");

  if (sSortBy==null) sSortBy = "R";
  if (sSum==null) sSum = "N";
  if (sSelDiv == null || sSelDiv.trim().equals("")){sSelDiv="ALL";}

  PiWiRew invrep = new PiWiRew(sStore, sArea, sSortBy, sPiYearMo.substring(0, 4)
                              ,  sPiYearMo.substring(4), sSum, sMbr);
  invrep.setSingleArea();
      
  boolean bNewRate = sStore.equals("05");
%>

<html>
<head>

<style> body {background:ivory;  vertical-align:bottom;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:lightgrey;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:left; font-family:Arial; font-size:10px }
         td.DataTable2 { background:CornSilk;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
         td.DataTable3 { background:lightgrey;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:8px }

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; }

        .Small { font-size:10px; }

    @media screen
    {
        tr.Hdr {display:none; }
    }
    @media print
    {
        tr.Hdr {display:block }
    }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
var NumOfItm = '0';

var SelDiv = "<%=sSelDiv%>";
var ArrDiv = new Array();
var ArrArg = new Array();

var ArrDivSng = new Array();

function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){  isSafari = true; }
	
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
   
   setSelDiv();
}
//==============================================================================
//set Select division dropdown menu
//==============================================================================
function setSelDiv()
{
	var sel = document.getElementById("SelDiv");
	ArrDivSng = new Array();
	
	sel.options[0] = new Option("ALL", "ALL");
	
	for(var i=0, k=1; i < ArrDiv.length; i++)
	{
		var found = false;
		for(var j=0; j < ArrDivSng.length; j++)
		{	
			if(ArrDivSng[j] == ArrDiv[i]){ found = true; break; }
		}
		
		if(!found)
		{ 
			ArrDivSng[ArrDivSng.length] = ArrDiv[i];
			sel.options[k] = new Option(ArrDiv[i], ArrDiv[i]);
			k++;
		}
		
	}
}
//==============================================================================
//set division filter
//==============================================================================
function setFivFilter(sel)
{
	var filter = sel.options[sel.selectedIndex].value;
	
	for(var i=0; i < ArrDiv.length; i++)
	{
		if(filter == "ALL")
		{
			var row = document.getElementById("trItem" + i);
			row.style.display = "block";
		} 		
		else 
		{
			var rownm = "trItem" + i;			
			if(filter == ArrDiv[i]){ document.all[rownm].style.display = "block"; }
			else{document.all[rownm].style.display = "none";}
			
		} 
	}
}
//==============================================================================
// update Quantity
//==============================================================================
function updQty(sku, desc, qty, seq, action)
{
  var hdr = "Update Item quantity for SKU " + sku;
  if(action=="ADDITEM"){ hdr = "Add New Item"; }
  if(action=="DLTITEM"){ hdr = "Delete Item"; }

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popItmQty(sku, desc, qty, seq, action)

   html += "</td></tr></table>"

   document.all.dvSelWk.innerHTML = html;
   document.all.dvSelWk.style.pixelLeft= 400;
   document.all.dvSelWk.style.pixelTop= 100;
   document.all.dvSelWk.style.visibility = "visible";

   if(qty != null){ document.all.Qty.value = qty; }
   if(action=="ADDITEM"){ document.all.spnSure.innerHTML = "Are you sure you want to ADD new item?"; }
   if(action=="UPDITEM"){ document.all.spnSure.innerHTML = "Are you sure you want to UPDATE item quantity?"; }
   if(action=="DLTITEM")
   {
       document.all.spnSure.innerHTML = "Are you sure you want to DELETE item?";
       document.all.Qty.readOnly = true;
   }
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popItmQty(sku, desc, qty, seq, action)
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td style='font-size:12px; font-weight:bold; color:green; text-decoration:underline; white-space:nowrap;' colspan=2>"
          + "<span id='spnSure'></span>"
       + "</td>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt' width='20%'>Sku: &nbsp;</td>"

       if(sku != null){ panel += "<td class='Prompt'>" + sku + "</td>" }
       else{panel += "<td class='Prompt'><input class='Small' name='Sku' size=7, maxlength=7></td>"}

    panel += "</tr>"

    + "<tr>"
       + "<td class='Prompt' width='20%'>UPC: &nbsp;</td>"

       if(sku != null){ panel += "<td class='Prompt'>&nbsp;</td>" }
       else{panel += "<td class='Prompt'><input class='Small' name='Upc' size=12, maxlength=12></td>"}

    panel += "</tr>"

  if(sku != null)
  {
      panel += "<tr>"
         + "<td class='Prompt' width='20%' nowrap>Description: &nbsp;</td>"
         + "<td class='Prompt'>" + desc + "</td>"
      panel += "</tr>"
  }

  panel += "<tr>"
       + "<td class='Prompt' width='20%' nowrap>Quantity: &nbsp;</td>"
       + "<td class='Prompt'><input name='Qty' class='Small' size='5' maxlength='5'></td>"
    + "</tr>"


  + "<tr>"
       + "<td style='font-size:12px; font-weight:bold; color:red; text-decoration:underline; white-space:nowrap;' colspan=2>"
          + "<span id='spnError'></span>"
       + "</td>"
    + "</tr>"


  if(seq == null){ seq=""; }  
  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='vldUpdItem(&#34;" + sku + "&#34;,&#34;" + seq + "&#34;, &#34;" + action + "&#34;)' class='Small'>"
  if(action=="DLTITEM") { panel += "Delete" }
  else { panel += "Submit" }
  panel += "</button> &nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
  panel += "</table>";

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvSelWk.innerHTML = " ";
   document.all.dvSelWk.style.visibility = "hidden";
}

//==============================================================================
// validate area deletion
//==============================================================================
function vldUpdItem(sku, seq, action)
{
   var error = false;
   var msg = "";
   var upc ="";

   if(action == "ADDITEM")
   {
      sku = document.all.Sku.value.trim();
      if(isNaN(sku) || eval(sku) < 0 || eval(sku) > 9999999)
      {
         error="true"; msg += "\nThe Sku value is invalid.";
      }

      upc = document.all.Upc.value.trim();
      if(upc == "" && eval(sku) == 0)
      {
         error="true"; msg += "\nPlease enter SKU or UPC.";
      }
   }

   var qty = document.all.Qty.value.trim();
   if(isNaN(qty) || eval(qty) <= 0){ error="true"; msg += "\nThe Quantity value is invalid."; }

   if (error) { alert(msg); }
   else{ sbmUpdItem(sku, seq, upc, qty, action); }
}
//==============================================================================
// submit area deletion
//==============================================================================
function sbmUpdItem(sku, seq, upc, qty, action)
{
   var url = "PiWiSave.jsp?Store=<%=sStore%>&Mbr=<%=sMbr%>&Area=<%=sArea%>"
     + "&PICal=<%=sPiYearMo%>"
     + "&Sku=" + sku
     + "&Seq=" + seq
     + "&Upc=" + upc
     + "&Qty=" + qty
     + "&Action=" + action

   //alert(url)
   window.frame1.location = url;
}

//==============================================================================
// show errors
//==============================================================================
function showError(error)
{
    var url = "";
    var br = "";
    for(var i=0; i < error.length; i++)
    {
       url += br + error[i];
    }

    document.all.spnError.innerHTML = url;
}
 
//==============================================================================
//save new retail
//==============================================================================
function vldNewRet()
{
	var arrret = new Array();
	var arrsku = new Array();
	
	for(var i=0; i < NumOfItm; i++)
	{		
		var sku = document.getElementById("tdSku" + i).innerHTML;
		var nret = document.getElementById("inpRet" + i).value;
		var oret = document.getElementById("spnRet" + i).innerHTML;
		if(nret != oret)
		{				
			arrsku[arrsku.length] = sku;
			arrret[arrret.length] = nret;			
		}
	}
	
	if(arrsku.length == 0){ alert("There are no single retail price were changed."); }
	else{ saveNewRet(arrsku, arrret); }
}
//==============================================================================
//save new retail
//==============================================================================
function saveNewRet(sku, ret)
{
	var url = "PiWiSave.jsp?Store=<%=sStore%>&Mbr=<%=sMbr%>&Area=<%=sArea%>"
		  + "&PICal=<%=sPiYearMo%>"		  	  
		  + "&Action=UpdPrc"
	;
		
	for(var i=0; i < sku.length; i++)
	{		
		url += "&asku=" + sku[i]
		     + "&nwp=" + ret[i]; 
	}
	
	window.frame1.location = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
    <tr bgColor="moccasin">
     <td style="vertical-align:top; text-align:center;">
      <b>Retail Concepts, Inc
      <br>Cycle Counts by Area
      <br>Store:<%=sStore%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          Area: <%=sArea%></b>
<!------------- end of store selector ---------------------->
        <br><a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="PIWIRewArea.jsp?STORE=<%=sStore%>&AREA=ALL&PICal=<%=sPiYearMo%>"><font color="red" size="-1">Area</font></a>&#62;
        <font size="-1">This page</font><br><br>
        <span style="font-size:11px">
            *The initial display of this report is in the
            <a href="PIWIRew.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=R&PICal=<%=sPiYearMo%>&Mbr=<%=sMbr%>">
            EXACT order that Store counted</a>
            this area, you can click on SHORT SKU to re-rank the listing by Short Sku.
       </span>

       <br>
       <%if(sSum.equals("N")){%><a href="PIWIRew.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=<%=sSortBy%>&PICal=<%=sPiYearMo%>&Sum=Y&Mbr=<%=sMbr%>" style="font-size:11px">Total Qty by SKU</a><%}
       else {%><a href="PIWIRew.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=<%=sSortBy%>&PICal=<%=sPiYearMo%>&Sum=N&Mbr=<%=sMbr%>" style="font-size:11px">All Entires</a><%}%>

       &nbsp; &nbsp; &nbsp; &nbsp;
       <a href="javascript: updQty(null, null, null,null,'ADDITEM')">Add Item</a>
       
       <%if(bNewRate){%>       
       		<span id="spnSaveRet">
       			&nbsp; &nbsp; &nbsp; &nbsp;
       			<a href="javascript: vldNewRet()">Save New Price</a>
       		</span>
       <%}%>
       
       &nbsp; &nbsp; &nbsp; &nbsp;
       Select Division: <select class="Small" name="selDiv" id="selDiv" onchange="setFivFilter(this)"></select>
       
       
       

<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2">Div<br/>#</th>
          <th class="DataTable" rowspan="2">Dpt<br/>#</th>
          <th class="DataTable" rowspan="2">Item<br/>Number</th>
          <th class="DataTable" colspan="2">Vendor Information</th>
          <th class="DataTable" colspan="3">Item Information</th>
          <th class="DataTable" rowspan="2">RGIS Scanned<br>UPC</th>
          <th class="DataTable" rowspan="2">
              <a href="PIWIRew.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=S&Sum=<%=sSum%>&PICal=<%=sPiYearMo%>&Mbr=<%=sMbr%>">
                 Short<br>SKU</a></th>
          <th class="DataTable" rowspan="2">Q<br>t<br>y</th>
          <th class="DataTable" rowspan="2">D<br>l<br>t</th>
          
          <th class="DataTable" id="thPrice" rowspan="2">Str<br>Price</th>
          <%if(bNewRate){%>
          <th class="DataTable" id="thPrice" rowspan="2">New<br>Price</th>
          <%}%>
        </tr>
        <tr>
          <th class="DataTable">Name</th>
          <th class="DataTable">
            <a href="PIWIRew.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=V&Sum=<%=sSum%>&PICal=<%=sPiYearMo%>&Mbr=<%=sMbr%>">
              Style
            </a>
          </th>

          <th class="DataTable">Description</th>
          <th class="DataTable">Color</th>
          <th class="DataTable">Size</th>
        </tr>
     <!-- ---------------------- Detail Loop ----------------------- -->
     <% int iOverFlow = 1;
        int iArg = -1; 
     %>

     <%while(invrep.getNext())
     {
        invrep.setItemProp();
        int iNumOfItm = invrep.getNumOfItm();
        String [] sDiv = invrep.getDiv();
        String [] sDpt = invrep.getDpt();
        String [] sCls = invrep.getCls();
        String [] sVen = invrep.getVen();
        String [] sSty = invrep.getSty();
        String [] sClr = invrep.getClr();
        String [] sSiz = invrep.getSiz();
        String [] sDesc = invrep.getDesc();
        String [] sClrNm = invrep.getClrNm();
        String [] sSizNm = invrep.getSizNm();
        String [] sVenSty = invrep.getVenSty();
        String [] sVenNm = invrep.getVenNm();
        String [] sSku = invrep.getSku();
        String [] sUpc = invrep.getUpc();
        String [] sQty = invrep.getQty();
        String [] sSeq = invrep.getSeq();
        String [] sRet = invrep.getRet();
        String [] sNewRet = invrep.getNewRet();

        for(int i=0; i < iNumOfItm; i++) {
        	iArg++;
        %>

   <%if(iOverFlow++ > 29){%>
       <tr>
         <td colspan="11">
            <div style="page-break-before:always"></div>
            <% iOverFlow = 1; %>
         <tr class="Hdr">
          <th class="DataTable1" rowspan="2">Div<br/>#</th>
          <th class="DataTable1" rowspan="2">Dpt<br/>#</th>
          <th class="DataTable1" rowspan="2">Item<br/>Number</th>
          <th class="DataTable1" colspan="2">Vendor Information</th>
          <th class="DataTable1" colspan="3">Item Information</th>
          <th class="DataTable1" colspan="2">RGIS Scanned</th>
          <th class="DataTable1" rowspan="2">Qty</th>
          <th class="DataTable" id="thPrice" rowspan="2">Str<br>Price</th>
          <%if(bNewRate){%>
          <th class="DataTable" id="thPrice" rowspan="2">New<br>Price</th>
          <%} %>
        </tr>
        <tr class="Hdr">
          <th class="DataTable">Name</th>
          <th class="DataTable">Style</th>
          <th class="DataTable">Description</th>
          <th class="DataTable">Color</th>
          <th class="DataTable">Size</th>
          <th class="DataTable1" >UPC</th>
          <th class="DataTable" >Short<br>SKU</th>
        </tr>
             </td>
           </tr>
          <%}%>

           <tr id="trItem<%=iArg%>">
             <td class="DataTable"><%=sDiv[i]%></td>
             <td class="DataTable"><%=sDpt[i]%></td>
             <td class="DataTable3" nowrap>
                <%=sCls[i] + "-" +sVen[i] + "-" +sSty[i] + "-" +sClr[i] + "-" +sSiz[i]%></td>

             <td class="DataTable1" nowrap><%=sVenNm[i]%></td>
             <td class="DataTable1" nowrap><%=sVenSty[i]%></td>

             <td class="DataTable1" nowrap><%=sDesc[i]%></td>
             <td class="DataTable1" nowrap><%=sClrNm[i]%></td>
             <td class="DataTable1" nowrap><%=sSizNm[i]%></td>

             <td class="DataTable"><%=sUpc[i]%></td>
             <td class="DataTable" id="tdSku<%=iArg%>"><%=sSku[i]%></td>

             <td class="DataTable">
                <%if(sSum.equals("N")){%><a href="javascript: updQty('<%=sSku[i]%>', '<%=sDesc[i]%>', '<%=sQty[i]%>', '<%=sSeq[i]%>', 'UPDITEM')"><%=sQty[i]%></a><%}
                else{%><%=sQty[i]%><%}%>
             </td>
             <td class="DataTable">
               <%if(sSum.equals("N")){%><a href="javascript: updQty('<%=sSku[i]%>', '<%=sDesc[i]%>', '<%=sQty[i]%>', '<%=sSeq[i]%>', 'DLTITEM')">Delete</a><%}%>
             </td>
             
             <td id="tdPrc" class="DataTable"><%=sRet[i]%></td>
             <%if(bNewRate){%>
             <td id="tdPrc" class="DataTable">
               <input name="inpRet<%=iArg%>"   
                      id="inpRet<%=iArg%>" class="Small" <%if(!sNewRet[i].equals(".00")){%>value='<%=sNewRet[i]%>'<%}%>
                      tabindex="iArg">
                      <span style="display: none;" id="spnRet<%=iArg%>"><%if(!sNewRet[i].equals(".00")){%><%=sNewRet[i]%><%}%></span>       
             </td>
             <%}%>
           </tr>
           <script>ArrDiv[ArrDiv.length] = "<%=sDiv[i]%>"; ArrArg[ArrArg.length] = "<%=iArg%>";</script>
        <%}%>
        
      <%}%>
      <script>NumOfItm = "<%=iArg+1%>";</script>
      <%
        invrep.setTotQty();
        String sTotQty = invrep.getTotQty();
      %>
          <tr>
            <td class="DataTable2" colspan='10'>Total</td>
            <td class="DataTable2"><%=sTotQty%></td>
            <td class="DataTable2">&nbsp;</td>
            <td class="DataTable2">&nbsp;</td>
            <%if(bNewRate){%><td class="DataTable2">&nbsp;</td><%}%>
          </tr>

       </table>

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
<%invrep.disconnect();%>