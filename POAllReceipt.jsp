<%@ page import="posend.POAllReceipt"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POAllReceipt.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    String sPoNum = request.getParameter("PO");
    String sLastRctDt = request.getParameter("LastRctDt");
    String sAsn = request.getParameter("Asn");
    String sUser = session.getAttribute("USER").toString();

    if(sAsn == null){sAsn = "N";}
  
    POAllReceipt porct = new POAllReceipt(sPoNum);

    int iNumOfRct = porct.getNumOfRct();
    String [] sRct = porct.getRct();
    String [] sRctDt = porct.getRctDt();
    String [] sActShpDt = porct.getActShpDt();
    String [] sInvoice = porct.getInvoice();
    String [] sRctUsr = porct.getRctUsr();
    String [] sRctStr = porct.getRctStr();

    int iNumOfItm = porct.getNumOfItm();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc; padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable0 { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable2 { color:red; background: khaki; font-family:Arial; font-size:12px; font-weight:bold; }
        tr.DataTable3 { background: #cccfff; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin:none; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}


        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }


</style>


<script name="javascript1.2">
<%if(sAsn.equals("Y")){%>
   var PoNum = "<%=sPoNum%>"
   var LastRctDt = "<%=sLastRctDt%>"
   var Receipt = null;
   <%for(int i=0; i < iNumOfRct; i++){%>
      <%if(sLastRctDt == null || sLastRctDt.equals(sRctDt[i])){%>
          Receipt = "<%=sRct[i]%>"
      <%}%>
   <%}%>
<%}%>
var SelRow = 0;

var AllItems = true;
var NumOfItm = <%=iNumOfItm%>;
var NumOfRct = <%=iNumOfRct%>;
var aSeq = new Array();
var aSku = new Array();
var aRctQty = new Array();
var aActQty = new Array();
var aInit = new Array();
var aCommt = new Array();
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
}
//==============================================================================
// fold/unfold items
//==============================================================================
function setItemDisp()
{
   AllItems = !AllItems;
   var disp = "none";
   if(AllItems){disp = "block";}

   for(var i=0; i < NumOfItm; i++)
   {
	  for(var j=0; j < NumOfRct; j++)
      {
		  var rct = "tdRct" + i + j;
		  if(document.all[rct].innerHTML.trim() == "")
          { 
      	  	var row = "trGroup" + i;
          	document.all[row].style.display=disp;
          }
      }
   }
}
//==============================================================================
// set corrections
//==============================================================================
function setCorrRcv()
{
    var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>ASN Item Receiving Corrections</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
     + "<tr><td class='Prompt' colspan=2>" + popCorrRcv()
      + "</td></tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 200;
   document.all.Prompt.style.pixelTop= 50;
   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================
// populate correction table
//==============================================================================
function popCorrRcv()
{
  var error = new Array();
  var msg = false;
  var panel = "<span style='font-size:12px; font-weight:bold;'>"
    + "Submit to Inventory Control for corrections."
    + "<span>"

  aSeq = new Array();
  aSku = new Array();
  aActQty = new Array();
  aInit = new Array();
  aCommt = new Array();

  panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblCorr'>"
  panel += "<tr class='DataTable'>"
       + "<th class='DataTable1'>Seq</th>"
       + "<th class='DataTable1'>Short<br>Sku</th>"
       + "<th class='DataTable1'>UPC</th>"
       + "<th class='DataTable1'>Vendor<br>Style</th>"
       + "<th class='DataTable1'>Description</th>"
       + "<th class='DataTable1'>P.O.<br>Qty</th>"
       + "<th class='DataTable1'>Actual<br>Qty</th>"
       + "<th class='DataTable1'>Init</th>"
       + "<th class='DataTable1'>Commt</th></tr>"
  for(var i=0; i < NumOfItm; i++)
  {
       var aqtyf = "ActQty" + i
       var aqty = "";

       if(!document.all[aqtyf].readOnly){ aqty = document.all[aqtyf].value.trim(); }

       if( aqty != "" )
       {
          var cellSeq = "tdSeq" + i;
          var cellSku = "tdSku" + i;
          var cellUpc = "tdUpc" + i;
          var cellVenSty = "tdVenSty" + i;
          var cellDesc = "tdDesc" + i;
          var cellQty = "tdQty" + i;
          var cellRct = "tdRct" + i;
          var inpInit = "Init" + i;
          var inpCommt = "Commt" + i;

          var init = document.all[inpInit].value.trim();

          if(isNaN(aqty)){ error[0] = true; aqty += "<span style='color:red;background:yellow;'>*</span>" }
          else if(eval(aqty) < 0){ error[1] = true; aqty += "<span style='color:red;background:yellow;'>*</span>" }

          if(init==""){ error[2] = true; init += "<span style='color:red;background:yellow;'>*</span>" }

          var iMax = aSeq.length;
          aSeq[iMax] = document.all[cellSeq].innerHTML;
          aSku[iMax] = document.all[cellSku].innerHTML;
          if(document.all[cellRct].innerHTML.trim() != ""){aRctQty[iMax] = document.all[cellRct].innerHTML.trim()};
          else{aRctQty[iMax] = "0";}
          aActQty[iMax] = aqty;
          aInit[iMax] = init;
          aCommt[iMax] = document.all[inpCommt].value.trim();

          panel += "<tr class='DataTable3'>"
            + "<td class='DataTable'>" + document.all[cellSeq].innerHTML + "</td>"
            + "<td class='DataTable'>" + document.all[cellSku].innerHTML + "</td>"
            + "<td class='DataTable'>" + document.all[cellUpc].innerHTML + "</td>"
            + "<td class='DataTable'>" + document.all[cellVenSty].innerHTML + "</td>"
            + "<td class='DataTable'>" + document.all[cellDesc].innerHTML + "</td>"
            + "<td class='DataTable'>" + document.all[cellRct].innerHTML + "</td>"
            + "<td class='DataTable'>" + aqty + "</td>"
            + "<td class='DataTable'>" + init + "</td>"
            + "<td class='DataTable' nowrap>" + document.all[inpCommt].value.trim() + "</td>"
       }
  }
  if(error[0] != null)
  {
     panel += "<tr class='DataTable2'><td class='DataTable1' colspan=9>Actual Quantity is not numeric.</td></tr>"
  }
  if(error[1] != null)
  {
     panel += "<tr class='DataTable2'><td class='DataTable1' colspan=9>Actual Quantity is not less than 0.</td></tr>"
  }
  if(error[2] != null)
  {
     panel += "<tr class='DataTable2'><td class='DataTable1' colspan=9>Please, type initials</td></tr>"
  }

  panel += "<tr><td class='DataTable' colspan=9>";

  if(error[0] == null && error[1] == null && error[2] == null && aSeq.length > 0)
  {
    panel += "<button class='Small' onclick='sbmCorrRcv();'>Submit</button> &nbsp; "
  }

  panel += "<button class='Small' onclick='hidePanel();'>Close</button>"
      + "</td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// submit correction for received items
//==============================================================================
function sbmCorrRcv()
{
   var html = "<form method='post' action='POCorrSav.jsp' name='frmCorr'>"
     + "<input name='PO' value='" + PoNum + "'>"
     + "<input name='LastRctDt' value='" + LastRctDt + "'>"
     + "<input name='Receipt' value='" + Receipt + "'>"

   for(var i=0; i < aSeq.length; i++)
   {
      html += "<input name='Seq' value='" + aSeq[i] + "'>"
          + "<input name='Sku' value='" + aSku[i] + "'>"
          + "<input name='Qty' value='" + aRctQty[i] + "'>"
          + "<input name='ActQty' value='" + aActQty[i] + "'>"
          + "<input name='Init' value='" + aInit[i] + "'>"
          + "<input name='Commt' value='" + aCommt[i] + "'>"
   }
   html += "</form>";

   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"
   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   //alert(html)
   window.frame1.document.frmCorr.submit();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}
//==============================================================================
// clear corrcetion fields
//==============================================================================
function clrCorr()
{
    for(var i=0; i < NumOfItm; i++)
    {
       var aqtyf = "ActQty" + i
       document.all[aqtyf].value = "";
       var initf = "Init" + i
       document.all[initf].value = "";
       var commtf = "Commt" + i
       document.all[commtf].value = "";
    }
}
</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD>

<META content="RCI, Inc." name=porct></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR><%if(sAsn.equals("Y")){%>ASN Receiving Review<%}
              else {%>Purchase Order Receipts<%}%>
        <br>P.O.# <%=sPoNum%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="POWorksheetList.jsp?Sort=STR" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a class="small" href="javascript: setItemDisp()">Only Received/All</a>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <%if(sLastRctDt != null){%>
              <th class="DataTable" rowspan=2>Carton</th>
           <%}%>
           <th class="DataTable" rowspan=2>Seq</th>
           <th class="DataTable" rowspan=2>Short SKU</th>
           <th class="DataTable" rowspan=2>UPC</th>
           <th class="DataTable" rowspan=2>VenSty</th>
           <th class="DataTable" rowspan=2>Color</th>
           <th class="DataTable" rowspan=2>Size</th>
           <th class="DataTable" rowspan=2>Desc</th>
           <th class="DataTable" rowspan=2>Ret</th>
           <th class="DataTable" rowspan=2>P.O. Qty</th>
           <th class="DataTable" rowspan=2>Qty<br>On Hand</th>
           <th class="DataTable" rowspan=2>Qty<br>Pending</th>
           <th class="DataTable" colspan=<%=iNumOfRct + 1%>>
              <%if(sAsn.equals("Y")){%>ASN Received<br>Quantity<%} else {%>Receipts Quantity<%}%>
           </th>
           <%if(sAsn.equals("Y")){%>
              <th class="DataTable" colspan=3 rowspan=2>Corrections</th>
           <%}%>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">1)<br>2)<br>3)<br>4)<br>5)<br>&nbsp;</th>
           <%for(int i=0; i < iNumOfRct; i++){%>
               <%if(sLastRctDt == null || sLastRctDt.equals(sRctDt[i])){%>
                  <th class="DataTable"><%=sActShpDt[i]%><br><%=sInvoice[i]%><br><%=sRct[i]%><br><%=sRctDt[i]%><br><%=sRctUsr[i]%>
                    <br>Str: <%=sRctStr[i]%>
                  </td>
               <%}%>
           <%}%>
           <%if(sAsn.equals("Y")){%>
              <th class="DataTable">Actual<br>Received<br>Quantity</th>
              <th class="DataTable">Initials</th>
              <th class="DataTable">Comments</th>
           <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ ){
           porct.setPOItems(i+1);
           String sCls = porct.getCls();
           String sVen = porct.getVen();
           String sSty = porct.getSty();
           String sClr = porct.getClr();
           String sSiz = porct.getSiz();
           String sSku = porct.getSku();
           String sDesc = porct.getDesc();
           String sSeq = porct.getSeq();
           String sQty = porct.getQty();
           String [] sRctQty = porct.getRctQty();
           String sUpc = porct.getUpc();
           String sVenSty = porct.getVenSty();
           String sClrNm = porct.getClrNm();
           String sSizNm = porct.getSizNm();
           String [] sActQty = porct.getActQty();
           String [] sInit = porct.getInit();
           String [] sCommt = porct.getCommt();
           String sCarton = porct.getCarton();
           String sRet = porct.getRet();
           String sQtyDC = porct.getQtyDC();
           String sQtyDCPend = porct.getQtyDCPend();
       %>
         <tr id="trGroup<%=i%>" class="DataTable">
            <%if(sLastRctDt != null){%>
               <td class="DataTable" id="tdSeq<%=i%>" nowrap><%=sCarton%></td>
            <%}%>
            <td class="DataTable" id="tdSeq<%=i%>" nowrap><%=sSeq%></td>
            <td class="DataTable" id="tdSku<%=i%>" nowrap><%=sSku%></td>
            <td class="DataTable" id="tdUpc<%=i%>" nowrap><%=sUpc%></td>
            <td class="DataTable1" id="tdVenSty<%=i%>" nowrap><%=sVenSty%></td>
            <td class="DataTable1" id="tdClrNm<%=i%>" nowrap><%=sClrNm%></td>
            <td class="DataTable1" id="tdSizNm<%=i%>" nowrap><%=sSizNm%></td>
            <td class="DataTable1" id="tdDesc<%=i%>" nowrap><%=sDesc%></td>
            <td class="DataTable1" id="tdDesc<%=i%>" nowrap><%=sRet%></td>
            <td class="DataTable" id="tdQty<%=i%>" nowrap><%=sQty%></td>
            <td class="DataTable" id="tdQtyDC<%=i%>" nowrap><%=sQtyDC%></td>
            <td class="DataTable" id="tdQtyDCPend<%=i%>" nowrap><%=sQtyDCPend%></td>
            <th class="DataTable">&nbsp;</th>

            <%boolean bInp = false;
              int iArg = 0;%>
            <%for(int j=0; j < iNumOfRct; j++){%>
                <%if(sLastRctDt == null || sLastRctDt.equals(sRctDt[j])){%>
                   <td class="DataTable" id="tdRct<%=i%><%=j%>" nowrap><%=sRctQty[j]%></td>
                   <%if(sLastRctDt != null && !sActQty[j].equals("") && sAsn.equals("Y")){%>
                     <%bInp=true; iArg = j;%>
                   <%}%>
                <%}%>
            <%}%>

            <%if(sAsn.equals("Y")){%>
               <td class="DataTable" nowrap>
                 <input name="ActQty<%=i%>" class="Small" size="3" maxlength="3"
                   <%if(bInp){%>value="<%=sActQty[iArg]%>" readonly<%}%>>
               </td>
               <td class="DataTable" nowrap>
                 <input name="Init<%=i%>" class="Small" size="10" maxlength="10"
                 <%if(bInp){%>value="<%=sInit[iArg]%>" readonly<%}%>>
               </td>
               <td class="DataTable" nowrap>
                 <input name="Commt<%=i%>" class="Small" size="50" maxlength="50"
                 <%if(bInp){%>value="<%=sCommt[iArg]%>" readonly<%}%>>
               </td>
            <%}%>

          </tr>
       <%}%>
       
       <!-- ============ total Line ============= -->
       <%porct.setTotal();
         String sQty = porct.getQty();
         String [] sRctQty = porct.getRctQty();   
         String sQtyDC = porct.getQtyDC();
         String sQtyDCPend = porct.getQtyDCPend();
       %>
       <tr class="DataTable1">
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap colspan=7>Total</td>
         <td class="DataTable" nowrap><%=sQty%></td>
         <td class="DataTable" nowrap><%=sQtyDC%></td>
         <td class="DataTable" nowrap><%=sQtyDCPend%></td>
         <th class="DataTable">&nbsp;</th>
         <%for(int j=0; j < iNumOfRct; j++){%>
            <%if(sLastRctDt == null || sLastRctDt.equals(sRctDt[j])){%>
               <td class="DataTable" nowrap><%=sRctQty[j]%></td>               
             <%}%>
         <%}%>
       </tr>
       </table>

       <%if(sAsn.equals("Y")){%>
         <button onclick="setCorrRcv()">Submit corrections</button> &nbsp; &nbsp; &nbsp;
         <button onclick="clrCorr()">Clear corrections</button>
       <%}%>
<!-- ======================================================================= -->
      </TD>
     </TR>
     <tr>
      <td style="font-size:11px;">
            1) - Store Received Date
        <br>2) - ANS#, or Str#/Name/RCI# of E-Worksheet receipt
        <br>3) - Receipt #
        <br>4) - Actual Received in System Date
        <br>5) - Receiving User ID

      </td>
     </tr>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
  porct.disconnect();
  porct = null;
}%>