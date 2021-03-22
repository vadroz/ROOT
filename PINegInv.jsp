<%@ page import="inventoryreports.PINegInv"%>
<%
    String sDivision = request.getParameter("DIVISION");
    String sDepartment = request.getParameter("DEPARTMENT");
    String sClass = request.getParameter("CLASS");
    String sStore = request.getParameter("STORE");
    String sControlQty = request.getParameter("Qty");
    String sSign = request.getParameter("Sign");
    String sSelSku = request.getParameter("Sku");
    String sSort = request.getParameter("Sort");
    String sPiYearMo = request.getParameter("PICal");

    if(sSort==null) sSort = "0"; // sort by department and retail amount

    PINegInv pineg = new PINegInv(sDivision, sDepartment, sClass, sSelSku, sStore, sSign,
              sControlQty, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sSort);

    int iNumOfItm = pineg.getNumOfItm();
    String [] sDiv = pineg.getDiv();
    String [] sDpt = pineg.getDpt();
    String [] sCls = pineg.getCls();
    String [] sVen = pineg.getVen();
    String [] sSty = pineg.getSty();
    String [] sClr = pineg.getClr();
    String [] sSiz = pineg.getSiz();
    String [] sDesc = pineg.getDesc();
    String [] sClrName = pineg.getClrName();
    String [] sSizName = pineg.getSizName();
    String [] sVenSty = pineg.getVenSty();
    String [] sVenName = pineg.getVenName();
    String [] sSku = pineg.getSku();
    String [] sQty = pineg.getQty();
    String [] sRet = pineg.getRet();
    String [] sSls = pineg.getSls();
    String [] sDstOut = pineg.getDstOut();
    String [] sDstIn = pineg.getDstIn();
    String [] sUpc = pineg.getUpc();
    String [] sPiAdj = pineg.getPiAdj();

    pineg.disconnect();

%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        a.hdg:link { color:blue; font-size:12px; font-weight:bold} a.hdg:visited { color:blue;font-size:12px; font-weight:bold}   a.hdg:hover { color:red; font-size:12px; font-weight:bold}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: Azure; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        td.DataTable3 { cursor:hand; color:blue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap; text-decoration: underline;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:left;
                   font-family:Arial; font-size:10px; }


</style>


<script name="javascript1.2">
var SelRow = 0;
var Total = false;
var NumOfItm = <%=iNumOfItm%>
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt", "dvUpload"]);
}
//==============================================================================
// new Search
//==============================================================================
function newSearch()
{
   var ven = document.all.Vendor.value
   if(isNaN(ven) || ven.trim()=="") ven = 0;
   var vennm = document.all.Search.value;
   if(vennm.trim()=="") vennm = " ";

   var url = 'MrVendforStr.jsp?'
    + "Vendor=" + ven
    + "&Search=" + vennm

   //alert(url);
   window.location.href = url;
}
//==============================================================================
// show next page
//==============================================================================
function showMoreRec()
{
   var url = 'MrVendforStr.jsp?'
    + "Vendor=" + LastVendor
    + "&Search=" + Search;

   //alert(url);
   window.location.href = url;
}

//---------------------------------------------------------
// show Vendor for update
//---------------------------------------------------------
function showVend(ven, num)
{
   var url = "MrVendPrt.jsp?"
    + "Ven=" + ven
    + "&VenName=" + cvtText(VenName[num])
    + "&Cont=" + Cont[num]
    + "&Phone=" + Phone[num]
    + "&Web=" + Web[num]
    + "&EMail=" + EMail[num]

    for(var i=0; i < Addr[num].length; i++) { url += "&Addr=" + Addr[num][i]; }
    for(var i=0; i < Ins[num].length; i++) { url += "&Ins=" + Ins[num][i]; }

   open(url, "DocUpload", "width=600,height=400, left=100,top=100, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes")
   SelRow = num;
}
//---------------------------------------------------------
// convert text -  replace next line %0A on &#92;n
//---------------------------------------------------------
function cvtText(text)
{
   var newstr = "";

   for(var i=0; i < text.length; i++)
   {
      if(text.substring(i, i+1) == "#") { newstr += " " }
      else { newstr += text.substring(i, i+1) }
   }

   return newstr;
}


//--------------------------------------------------------
// position objec on the screen
//--------------------------------------------------------
function objPosition(obj)
{
   var curLeft = 0;
   var curTop = 0;
   var pos = new Array(2);


   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       curLeft += obj.offsetLeft
       curTop += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     curLeft += obj.x;
     curTop += obj.y;
   }

   pos[0]=curLeft;
   pos[1]=curTop;
   return pos;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}
//--------------------------------------------------------
// switch Total/Detail module
//--------------------------------------------------------
function switchTotDtl()
{
   var disp = "none";
   if (Total) { disp="block" }

   for(var i = 0; i < NumOfItm; i++)
   {
     if (document.all["trItm" + i] != null) { document.all["trItm" + i].style.display=disp; }
   }

   Total = !Total;
}
//==============================================================================
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
  <div id="dvUpload" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>On-Hand - Review by Quantity on Hand
        <br>Store: <%=sStore%></B><br>

       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       <a href="PINegInvSel.jsp"><font color="red" size="-1">PI Select</font></a>&#62;
       <font size="-1">This Page.</font>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript:switchTotDtl();"><span id="spnTotSwitch">Total</span></a>

<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable" rowspan="2">Div</th>
           <th class="DataTable" rowspan="2">Dpt</th>
           <th class="DataTable" rowspan="2"><a class="hdg" href="PINegInv.jsp?DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&STORE=<%=sStore%>&Qty=<%=sControlQty%>&Sign=<%=sSign%>&Sku=<%=sSelSku%>&Sort=1&PICal=<%=sPiYearMo%>">Item<br>Cls-Ven-Sty-Clr-Siz</a></th>
           <th class="DataTable" colspan="3">Item Information</th>
           <th class="DataTable" colspan="2">Vendor Information</th>
           <th class="DataTable" rowspan="2">Short<br>Sku</th>
           <th class="DataTable" rowspan="2">Upc</th>
           <th class="DataTable" rowspan="2">Qty<br>On Hand</th>
           <th class="DataTable" colspan="2">Since Last PI Calendar</th>
           <th class="DataTable" colspan="2">Distros</th>
           <th class="DataTable" rowspan="2">Pi<br>Adj</th>
         </tr>

         <tr  class="DataTable">
           <th class="DataTable" >Description</th>
           <th class="DataTable" >Color</th>
           <th class="DataTable" >Size</th>
           <th class="DataTable" >Style</th>
           <th class="DataTable" >Name</th>
           <th class="DataTable" ><a class="hdg" href="PINegInv.jsp?DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&STORE=<%=sStore%>&Qty=<%=sControlQty%>&Sign=<%=sSign%>&Sku=<%=sSelSku%>&Sort=0&PICal=<%=sPiYearMo%>">Retail</a></th>
           <th class="DataTable" >Sales</th>
           <th class="DataTable" >Out</th>
           <th class="DataTable" >In</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ ){%>
         <tr id="trItm<%if(sSku[i].indexOf("TOT") >= 0){%>Tot<%}%><%=i%>" class="DataTable<%if(sSku[i].equals("DIVTOT")){%>1<%} else if(sSku[i].equals("REPTOT")){%>2<%}%>">
         <%if(sSku[i].indexOf("TOT") < 0){%>
            <td class="DataTable1" nowrap><%=sDiv[i]%></td>
            <td class="DataTable1" nowrap><%=sDpt[i]%></td>
            <td class="DataTable1" nowrap><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
            <td class="DataTable1" nowrap><%=sDesc[i]%></td>
            <td class="DataTable1" nowrap><%=sClrName[i]%></td>
            <td class="DataTable1" nowrap><%=sSizName[i]%></td>
            <td class="DataTable1" nowrap><%=sVenSty[i]%></td>
            <td class="DataTable1" nowrap><%=sVenName[i]%></td>
            <td class="DataTable1" nowrap>
            	<%if(!sSls[i].trim().equals(".00") && sSku[i].indexOf("TOT") < 0){%>
              		<a target="_blank" href="PIItmSlsHst.jsp?Sku=<%=sSku[i]%>&STORE=<%=sStore%>&SlsOnTop=1PIItmSlsHst&PICal=<%=sPiYearMo%>&FromDate=01/01/0001&ToDate=12/31/2099"><%=sSku[i]%><%}
              	else {%><%=sSku[i]%><%}%></a>
            </td>
            <td class="DataTable1" nowrap><%=sUpc[i]%></td>
         <%}
           else {%>
            <td class="DataTable1" nowrap colspan="10"><%if(sSku[i].equals("DIVTOT")) {%><%=sDiv[i]%> - Division Totals<%} else {%>Store Totals<%}%></td>
          <%}%>
            <td class="DataTable1" nowrap><%=sQty[i]%></td>
            <td class="DataTable1" nowrap><%=sRet[i]%></td>
            <td class="DataTable1" nowrap><%=sSls[i]%></td>
            <td class="DataTable1" nowrap>
              <%if(!sDstOut[i].trim().equals("0") && sSku[i].indexOf("TOT") < 0){%><a target="_blank" href="PIItmSlsHst.jsp?Sku=<%=sSku[i]%>&STORE=<%=sStore%>&SlsOnTop=0&PICal=<%=sPiYearMo%>&FromDate=01/01/0001&ToDate=12/31/2099"><%=sDstOut[i]%><%}
                else {%><%=sDstOut[i]%><%}%></a></td>
           <td class="DataTable1" nowrap>
              <%if(!sDstIn[i].trim().equals("0") && sSku[i].indexOf("TOT") < 0){%><a target="_blank" href="PIItmSlsHst.jsp?Sku=<%=sSku[i]%>&STORE=<%=sStore%>&SlsOnTop=0&PICal=<%=sPiYearMo%>&FromDate=01/01/0001&ToDate=12/31/2099"><%=sDstIn[i]%><%}
                else {%><%=sDstIn[i]%><%}%></a></td>
           <%if(sSku[i].indexOf("TOT") < 0){%><td class="DataTable1" nowrap><%=sPiAdj[i]%></td><%} else {%><td class="DataTable1" nowrap>&nbsp;</td><%}%>
          </tr>
       <%}%>
       </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
