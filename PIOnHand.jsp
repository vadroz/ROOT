<%@ page import="rciutility.StoreSelect, inventoryreports.PIOnHand, inventoryreports.PiCalendar"%>
<%
   String sClass = request.getParameter("Class");
   String sVendor = request.getParameter("Vendor");
   String sPiYearMo = request.getParameter("PICal");

   int iNumOfItm = 0;
   String [] sSty = new String[0];
   String [] sClr = new String[0];
   String [] sSiz = new String[0];
   String [] sSku = new String[0];
   String [] sDesc = new String[0];
   String [][] sPiCnt = new String[0][0];
   String [][] sItmCnt = new String[0][0];

   StoreSelect strsel = new StoreSelect(1);
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();

   if (sClass == null)
   {
      if(sClass==null) sClass = " ";
      if(sVendor==null) sVendor = " ";
   }
   else
   {
      PIOnHand setPi = new PIOnHand(sClass, sVendor, sPiYearMo.substring(0, 4), sPiYearMo.substring(4));

      iNumOfItm = setPi.getNumOfItm();
      sSty = setPi.getSty();
      sClr = setPi.getClr();
      sSiz = setPi.getSiz();
      sSku = setPi.getSku();
      sDesc = setPi.getDesc();
      sPiCnt = setPi.getPiCnt();
      sItmCnt = setPi.getItmCnt();

      setPi.disconnect();
   }
   // get PI Calendar
   PiCalendar setcal = new PiCalendar();
   String sPiYear = setcal.getYear();
   String sPiMonth = setcal.getMonth();
   String sPiDesc = setcal.getDesc();
   setcal.disconnect();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:12px}
        table.DataTable { background: darkred}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: #b5eaaa; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable3 { cursor:hand; color:blue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap; text-decoration: underline;}
        td.DataTable4 { padding-top:0px; padding-bottom:0px; text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:left;
                   font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.2">
var Class = "<%=sClass%>";
var Vendor = "<%=sVendor%>";
var PiYear = [<%=sPiYear%>];
var PiMonth = [<%=sPiMonth%>];
var PiDesc =  [<%=sPiDesc%>];

var SelRow = 0;
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt", "dvUpload"]);
   popPICal();
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
// new Search
//==============================================================================
function newSearch()
{
   var ven = document.all.Vendor.value
   if(isNaN(ven) || ven.trim()=="") ven = 0;
   var vennm = document.all.Class.value;
   if(vennm.trim()=="") vennm = " ";

   var cal = document.all.PICal.options[document.all.PICal.selectedIndex].value;

   var url = 'PIOnHand.jsp?'
    + "Vendor=" + ven
    + "&Class=" + vennm
    + "&PICal=" + cal;

   //alert(url);
   window.location.href = url;
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
function hilight(col, hili)
{
  var obj = document.all[col]
  for(var i=0; i < obj.length; i++)
  {
     if(hili) obj[i].style.background = "yellow";
     else obj[i].style.background = "#E7E7E7";
  }
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
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
        <BR>PI Count vs. On-Hand</B><br>

        <table border=0 cellPadding="0" cellSpacing="0" id="tbClass">
          <tr>
              <tr><td align="right">Class:&nbsp;</td>
              <td align="left"><input class="Small" name="Class" maxlength=5 size=5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
              <td align="right">Vendor:&nbsp;</td>
              <td align="left"><input class="Small" name="Vendor" maxlength=5 size=5></td>
              <td align="right">PI Calendar:&nbsp;</td>
              <td align="left"><select name="PICal"></select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
              <td align="right">&nbsp;&nbsp;&nbsp;<input onClick="newSearch()" type="submit" class="Small" name="Submit" value="Search"></td>
          </tr>
        </table>

       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page.</font>

<!-- ======================================================================= -->
       <table border=1 class="DataTable" cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable" rowspan="2">Sty-Clr-Size</th>
           <th class="DataTable" rowspan="2">Description</th>
           <th class="DataTable" rowspan="2">Short<br>Sku</th>
           <th class="DataTable" rowspan="2">S<br>r<br>c</th>
           <th class="DataTable" colspan="<%=iNumOfStr*2%>">Store</th>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < iNumOfStr; i++ ){%>
               <th class="DataTable" colspan=2><%=sStrLst[i]%></th>
            <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%int iHeader=0;%>
       <%for(int i=0; i < iNumOfItm; i++ ){%>

          <%if(iHeader==8){%>
            <tr  class="DataTable1">
               <td class="DataTable" colspan="4">&nbsp;</td>
               <%for(int j=0; j < iNumOfStr; j++ ){%>
                  <td class="DataTable4" colspan=2><%=sStrLst[j]%></td>
               <%}%>
            </tr>
            <%iHeader=0;%>
          <%}%>

          <tr id="trItm<%=i%>" class="DataTable">
            <td class="DataTable2" id="tdSCV<%=i%>" nowrap rowspan="2"><%=sSty[i] + "-" +sClr[i] + "-" + sSiz[i]%></td>
            <td class="DataTable" id="tdDesc<%=i%>" nowrap rowspan="2"><%=sDesc[i]%></td>
            <td class="DataTable" id="tdDesc<%=i%>" rowspan="2"><%=sSku[i]%></td>

            <th class="DataTable">PI</th>
            <%for(int j=0; j < iNumOfStr; j++ ){%>
               <td class="DataTable" onMouseOver="hilight('tdPiCnt<%=j%>', true)"  onMouseOut="hilight('tdPiCnt<%=j%>', false)"
                   id="tdPiCnt<%=j%>"><%=sPiCnt[i][j]%></td>
               <td class="DataTable" onMouseOver="hilight('tdItmCnt<%=j%>', true)" onMouseOut="hilight('tdItmCnt<%=j%>', false)">&nbsp;</td>
            <%}%>
          </tr>

          <tr id="trItmA<%=i%>" class="DataTable">
            <th class="DataTable">OH</th>
            <%for(int j=0; j < iNumOfStr; j++ ){%>
               <td class="DataTable" onMouseOver="hilight('tdPiCnt<%=j%>', true)"  onMouseOut="hilight('tdPiCnt<%=j%>', false)">&nbsp;</td>
               <td class="DataTable" onMouseOver="hilight('tdItmCnt<%=j%>', true)" onMouseOut="hilight('tdItmCnt<%=j%>', false)"
                   id="tdItmCnt<%=j%>"><%=sItmCnt[i][j]%></td>
            <%}%>
          </tr>
          <tr class="Line"><td colspan="47"></td><tr>
          <%iHeader++;%>
       <%}%>
       </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
