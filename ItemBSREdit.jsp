<%@ page import="java.util.*, onhand01.ItemBSREdit"%>
<%
   String sSrchDiv = request.getParameter("Div");
   String sSrchDpt = request.getParameter("Dpt");
   String sSrchCls = request.getParameter("Cls");
   String sSrchVen = request.getParameter("Ven");
   String sSrchItem = request.getParameter("Item");

   if (sSrchItem == null) sSrchItem = "";

   String sFile = "filename=";
   if (!sSrchDiv.equals("ALL")) sFile = sFile + "Div" + sSrchDiv.trim();
   if (!sSrchDpt.equals("ALL")) sFile = sFile + "Dpt" + sSrchDpt.trim();
   if (!sSrchCls.equals("ALL")) sFile = sFile + "Cls" + sSrchCls.trim();
   if (!sSrchVen.equals("ALL")) sFile = sFile + "Ven" + sSrchVen.trim();

   ItemBSREdit itmbsr = new ItemBSREdit(sSrchDiv,  sSrchDpt, sSrchCls, sSrchVen);
   int iNumOfStr = itmbsr.getNumOfStr();
   String [] sStr = itmbsr.getStr();
   String sStrJsa = itmbsr.getStrJsa();
   String sSvCVS = "";

   int iNumOfItm = 0;
%>

<html>
<head>
<title>Item BSR Editing</title>
<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}
  a.Small:link { color:blue;  font-size:10px;} a.Small:visited { color:purple; font-size:10px;}  a.Small:hover { color:darkblue; font-size:10px;}

  table.DataTable { border: gray solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: gray solid 1px; border-right: gray solid 1px;}

  tr.DataTable1 { background:#e7e7e7; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable11 { background:gold; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.Break { background:#FFCC99; font-family:Verdanda; text-align:center; font-size:10px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}



  td.DataTable { border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1a { background: #ccd1e8; border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1b { background: #e0d1d0; border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
                    
  td.DataTable11 { border-bottom: gray solid 1px; border-right: gray solid 2px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable11a { background: #e2e2d0; border-bottom: gray solid 1px; border-right: gray solid 2px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
                 
  td.DataTable2 { border-bottom: gray solid 1px; border-right: gray solid 1px; text-align:center;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable21 { cursor: hand; border-bottom: gray solid 1px; border-right: gray solid 1px; text-align:center;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}

  td.Break {border-bottom: gray solid 1px; border-right: gray solid 2px;}


  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px }


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  .Small1{ text-align:center; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Store = [<%=sStrJsa%>];

var SelCls = null;
var SelVen = null;
var SelSty = null;
var SelClr = null;
var SelSiz = null;
var SelRow = null;
var NewMin = null;
var NewIdeal = null;
var NewMax = null;
var PositionTo = null;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) {  isSafari = true;}
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);

   // scroll window to show selected Item
   if(PositionTo != null)
   {
      var pos = getPosition(document.all[PositionTo]);
      window.scrollTo(0, pos[1]-100)
   }
}
//==============================================================================
// get object coordinats
//==============================================================================
function getPosition(obj)
{
   var pos = [0, 0];

   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}
//==============================================================================
// change BSR level
//==============================================================================
function chgBSR(i, cls, ven, sty, clr, siz, desc, min, ideal, max, stock, sales)
{
   SelCls = cls;
   SelVen = ven;
   SelSty = sty;
   SelClr = clr;
   SelSiz = siz;
   SelRow = i;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Item: " + cls + "-" + ven + "-" + sty + "-" + clr + "-" + siz + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popBSRPanel(desc, stock, sales)+ "</td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.Left= getLeftScreenPos() + 100;
   document.all.dvPrompt.style.Top= getTopScreenPos() + 10;
   document.all.dvPrompt.style.visibility = "visible";

   for(var i=0; i < Store.length; i++)
   {
	   document.all.Min[i].value = min[i];
	   document.all.Ideal[i].value = ideal[i];
   	   document.all.Max[i].value = max[i];
   }
}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popBSRPanel(desc, stock, sales)
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

  // Description
  panel += "<tr><td class='Prompt' nowrap>Item Description:</td>"
         + "<td class='Prompt' colspan=2>" + desc + "</td></tr>";
  // Store
  panel += "<tr><td class='Prompt1' nowrap>Store</td>"
	     + "<td class='Prompt1' nowrap>Min</td>"
         + "<td class='Prompt1' nowrap>Ideal</td>"
         + "<td class='Prompt1' nowrap>Maximum</td>"
         + "<td class='Prompt1' nowrap>Inv</td>"
         + "<td class='Prompt1' nowrap>Sales</td>"
         + "</tr>"
         ;

  for(var i=0; i < Store.length; i++)
  {
     panel += "<tr><td class='Prompt1' nowrap>" + Store[i] + "</td>"
        + "<td class='Prompt1'><input id='Min' class='Small' maxlength=5 size=5></td>"         
     	+ "<td class='Prompt1'><input id='Ideal' class='Small' maxlength=5 size=5></td>"
        + "<td class='Prompt1'><input id='Max' class='Small' maxlength=5 size=5></td>"
        + "<td class='Prompt2'>&nbsp;" + stock[i] + "</td>"
        + "<td class='Prompt2'>&nbsp;" + sales[i] + "</td>"
      + "</tr>";
  }

  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='ValidateBSR()' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}

//==============================================================================
// change UPC level
//==============================================================================
function chgUPC(i, cls, ven, sty, clr, siz, desc, upc)
{
   SelCls = cls;
   SelVen = ven;
   SelSty = sty;
   SelClr = clr;
   SelSiz = siz;
   SelRow = i;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Item: " + cls + "-" + ven + "-" + sty + "-" + clr + "-" + siz + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popUPCPanel(desc)+ "</td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.Left= getLeftScreenPos() + 100;
   document.all.dvPrompt.style.Top= getTopScreenPos() + 10;
   document.all.dvPrompt.style.visibility = "visible";
   if(upc != ""){ document.all.Upc.value=upc}
}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popUPCPanel(desc)
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

  // Description
  panel += "<tr><td class='Prompt' nowrap>Item Description:</td>"
         + "<td class='Prompt'>" + desc + "</td></tr>";
  // Store
  panel += "<tr><td class='Prompt1' nowrap>UPC</td>"
         + "<td class='Prompt1' nowrap>"
         + "<input class='Small' name='Upc' size=12 maxlength=12>"
         + "</td>"
         + "</tr>"
         ;

  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='ValidateUPC()' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//--------------------------------------------------------
// show approve message for BSR zeroout action
//--------------------------------------------------------
function showZeroMsg(i, cls, ven, sty, clr, siz, desc, min, ideal, max, stock, sales)
{
   var msg = "Item: " + cls + "-" + ven + "-" + sty + "-" + clr + "-" + siz + "\n" + desc + "\n"
            + "\nAre You sure you want to delete the stock level for this item?"
   var a = confirm(msg, "Yes","No");
   if(a)
   {
	  var min = new Array(Store.length);
      var ideal = new Array(Store.length);
      var max = new Array(Store.length);
      for(var i=0; i < Store.length; i++) { ideal[i] = 0; max[i] = 0; min[i] = 0; }

      SelCls = cls;
      SelVen = ven;
      SelSty = sty;
      SelClr = clr;
      SelSiz = siz;
      SelRow = i;

      NewMin = min;
      NewIdeal = ideal;
      NewMax = max;
      
      SubmitBSR(min, ideal, max)
   }
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function hidePanel(){ document.all.dvPrompt.style.visibility = "hidden"; }

//--------------------------------------------------------
// Validate entry
//--------------------------------------------------------
function ValidateBSR()
{
   var min = new Array(Store.length);
   var ideal = new Array(Store.length);
   var max = new Array(Store.length);
   var error=false;
   var msg = "";
   for(var i=0; i < Store.length; i++)
   {
	  min[i] = document.all.Min[i].value.trim(" ");
	  if(min[i]=="" || min[i]==" ") { min[i]=0; }
	  ideal[i] = document.all.Ideal[i].value.trim(" ");
      if(ideal[i]=="" || ideal[i]==" ") { ideal[i]=0; }
      max[i] = document.all.Max[i].value.trim(" ");
      if(max[i]=="" || max[i]==" ") { max[i]=0; }

      if(isNaN(min[i])){ error = true; document.all.Min[i].focus(); break; }
      if(isNaN(ideal[i])){ error = true; document.all.Ideal[i].focus(); break; }
      if(isNaN(max[i])){ error = true; document.all.Max[i].focus(); break; }      
   }

   NewMin = min;
   NewIdeal = ideal;
   NewMax = max;
   msg = "Entered Value is not numeric\n";
   if(error){ alert(msg) }
   else(SubmitBSR(min, ideal, max))
}
//--------------------------------------------------------
// submit changes
//--------------------------------------------------------
function SubmitBSR(min, ideal, max)
{
   if (document.all.Submit != null) { document.all.Submit.disabled = true; } //disable submit button

   var url = "ItemBSRSave.jsp?"
       + "Cls=" + SelCls
       + "&Ven=" + SelVen
       + "&Sty=" + SelSty
       + "&Clr=" + SelClr
       + "&Siz=" + SelSiz

   for(var i=0; i < Store.length; i++)
   {
      url += "&Ideal=" + eval(ideal[i]) 
          + "&Max=" + eval(max[i])
          + "&Min=" + eval(min[i]);
   }
   url += "&Action=CHGBSR"

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}

//--------------------------------------------------------
// Validate entry
//--------------------------------------------------------
function ValidateUPC()
{
   var error=false;
   var msg = "";
   var upc = document.all.Upc.value.trim(" ");
   if(upc=="" || upc==" ") { error = true; msg += "Please enter UPC code.\n";}
   else if(isNaN(upc)){ error = true; msg += "Entered Value is not numeric\n";}

   if(error){ alert(msg) }
   else(SubmitUPC(upc))
}
//--------------------------------------------------------
// submit changes
//--------------------------------------------------------
function SubmitUPC(upc)
{
   document.all.Submit.disabled = true; //disable submit button

   var url = "ItemBSRSave.jsp?"
       + "Cls=" + SelCls
       + "&Ven=" + SelVen
       + "&Sty=" + SelSty
       + "&Clr=" + SelClr
       + "&Siz=" + SelSiz
       + "&Upc=" + upc
       + "&Action=CHGUPC"

   alert(url)
   //window.location.href=url;
   //window.frame1.location.href=url;
}

//--------------------------------------------------------
// update line
//--------------------------------------------------------
function updateLine(error)
{
   hidePanel();
   window.frame1.close();
   var ideal = "tdIdeal" + SelRow;
   var max = "tdMax" + SelRow;
   var min = "tdMin" + SelRow;
   var row = "trIdeal" + SelRow;

   for(var i=0; i < Store.length; i++)
   {
	 if(NewMin[i] > 0) document.all[min][i].innerHTML = NewMin[i];
	 else document.all[min][i].innerHTML = "&nbsp;";
     if(NewIdeal[i] > 0) document.all[ideal][i].innerHTML = NewIdeal[i];
     else document.all[ideal][i].innerHTML = "&nbsp;";
     if(NewMax[i] > 0) document.all[max][i].innerHTML = NewMax[i];
     else document.all[max][i].innerHTML = "&nbsp;";
   }
   document.all[row].style.backgroundColor = "pink";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Item BSR Editing List
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;&#62
        <a href="ItemBSREditSel.jsp"><font color="red" size="-1">Selection</font></a>;&#62
        <font size="-1">This page</font>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" rowspan="4">Div</th>
               <th class="DataTable" rowspan="4">Dpt</th>
               <th class="DataTable" rowspan="4">Item Long SKU</th>
               <th class="DataTable" rowspan="4">Short SKU</th>
               <th class="DataTable" rowspan="4">UPC</th>
               <th class="DataTable" rowspan="4">Z<br>e<br>r<br>o<br>e<br>d</th>
               <th class="DataTable" rowspan="4">&nbsp;</th>
               <th class="DataTable" colspan="<%=(iNumOfStr * 3)%>">Store</th>
               <th class="DataTable" rowspan="4">Item Long SKU</th>
             </tr>
             <tr class="DataTable">
               <%for(int i=0; i < iNumOfStr; i++){%>
                  <th class="DataTable" colspan=3><%=sStr[i]%></th>
               <%}%>
             </tr>

             <tr class="DataTable">
               <%for(int i=0; i < iNumOfStr; i++){%>
                  <th class="DataTable">Min</th>
                  <th class="DataTable">Ideal</th>
                  <th class="DataTable">Max</th>
               <%}%>
             </tr>
             <tr class="DataTable">
               <%for(int i=0; i < iNumOfStr; i++){%>
                  <th class="DataTable" colspan=2>Inv</th>
                  <th class="DataTable">Sls</th>
               <%}%>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <%
            while(itmbsr.setNext())
             {
               itmbsr.setItmList();
               String sDiv = itmbsr.getDiv();
               String sDpt = itmbsr.getDpt();
               String sCls = itmbsr.getCls();
               String sVen = itmbsr.getVen();
               String sSty = itmbsr.getSty();
               String sClr = itmbsr.getClr();
               String sSiz = itmbsr.getSiz();
               String sSku = itmbsr.getSku();
               String sDesc = itmbsr.getDesc();
               String [] sStock = itmbsr.getStock();
               String [] sSales = itmbsr.getSales();
               
               String [] sMin = itmbsr.getMin();
               String [] sIdeal = itmbsr.getIdeal();
               String [] sMax = itmbsr.getMax();               
               String sUpc = itmbsr.getUpc();

               String sMinJsa = itmbsr.getMinJsa();
               String sIdealJsa = itmbsr.getIdealJsa();
               String sMaxJsa = itmbsr.getMaxJsa();
               String sStockJsa = itmbsr.getStockJsa();
               String sSalesJsa = itmbsr.getSalesJsa();

               // check level break on Cls-Vendor-Style
               String sCVS = sCls + "-" + sVen + "-" + sSty;
               boolean bBreak = !sSvCVS.equals(sCVS);
               sSvCVS = sCls + "-" + sVen + "-" + sSty;
               String sItem = sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz;

        %>

              <!-- ------------ Division line ------------------------- -->
              <%if(bBreak){%><tr class="Break"><td class="Break" colspan=7>&nbsp</td><%for(int i=0; i < iNumOfStr; i++){%><td class="Break" colspan=3><%=sStr[i]%></th>
               <%}%><%}%>

              <tr id="trIdeal<%=iNumOfItm%>" class="DataTable1<%if(sSrchItem.equals(sItem)){%>1<%}%>">
                <%if(sItem != null && sSrchItem.equals(sItem)){%><script>PositionTo = "trIdeal" + <%=iNumOfItm%>; </script><%}%>
                <td class="DataTable2" rowspan=2><%=sDiv%></td>
                <td class="DataTable2" rowspan=2><%=sDpt%></td>
                <td class="DataTable2" rowspan=2 nowrap>
                    <a class="Small" href="javascript: chgBSR(<%=iNumOfItm%>, '<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sDesc%>', [<%=sMinJsa%>], [<%=sIdealJsa%>], [<%=sMaxJsa%>], [<%=sStockJsa%>], [<%=sSalesJsa%>])">
                    <%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%><br>
                    <%=sDesc%></a>

                </td>
                <td class="DataTable2" rowspan=2><%=sSku%></td>
                <!--td class="DataTable2" rowspan=2><a class="Small" href="javascript: chgUPC(<%=iNumOfItm%>, '<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sDesc%>', '<%=sUpc%>')">
                      <%if(!sUpc.equals("")){%><%=sUpc%><%} else {%>not found<%}%></a></td -->
                <td class="DataTable2" rowspan=2><%if(!sUpc.equals("")){%><%=sUpc%><%} else {%>not found<%}%></td>
                <th class="DataTable" rowspan=2 ><button onclick="showZeroMsg(<%=iNumOfItm%>, '<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sDesc%>', [<%=sMinJsa%>], [<%=sIdealJsa%>], [<%=sMaxJsa%>], [<%=sStockJsa%>], [<%=sSalesJsa%>])" class="Small1">0</button></th>
                <th class="DataTable">Ideal/Max</th>

                <%for(int j=0; j < iNumOfStr; j++){%>
                    <td id="tdMin<%=iNumOfItm%>" class="DataTable1a"><%if(!sMin[j].equals("")){%><%=sMin[j]%><%} else {%>&nbsp;<%}%></td>
                    <td id="tdIdeal<%=iNumOfItm%>" class="DataTable1b"><%if(!sIdeal[j].equals("")){%><%=sIdeal[j]%><%} else {%>&nbsp;<%}%></td>
                    <td id="tdMax<%=iNumOfItm%>" class="DataTable11a"><%if(!sMax[j].equals("")){%><%=sMax[j]%><%} else {%>&nbsp;<%}%></td>
                <%}%>
                <td class="DataTable21" rowspan=2 nowrap
                    onClick="chgBSR(<%=iNumOfItm%>, '<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sDesc%>', [<%=sMinJsa%>], [<%=sIdealJsa%>], [<%=sMaxJsa%>], [<%=sStockJsa%>], [<%=sSalesJsa%>])">
                    <%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%>
                </td>
              </tr>
              <tr class="DataTable1">
                <th class="DataTable">Inv/Sls</th>
                <%for(int j=0; j < iNumOfStr; j++){%>
                    <td class="DataTable1" colspan=2><%if(!sStock[j].equals("")){%><%=sStock[j]%><%} else {%>&nbsp;<%}%></td>
                    <td class="DataTable11"><%if(!sSales[j].equals("")){%><%=sSales[j]%><%} else {%>&nbsp;<%}%></td>
                <%}%>
              </tr>
            <%iNumOfItm++;%>
          <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>

<%
  itmbsr.disconnect();
  itmbsr = null;
%>