<%@ page import="advertising.AdPrintByGroup, java.util.*"%>
<%
   String sGroup = request.getParameter("Group");
   String sMonBeg = request.getParameter("MonBeg");
   String sMonName = request.getParameter("MonName");
   int iNumOfWk = Integer.parseInt(request.getParameter("NumOfWk"));
   String [] sWeeks = request.getParameterValues("Week");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AdPrintByGroup.jsp&APPL=ADVERTISES&" + request.getQueryString());
   }
   else
   {

    AdPrintByGroup adprt = new AdPrintByGroup(sGroup, sMonBeg);

    int iNumOfMkt = adprt.getNumOfMkt();
    int [] iNumOfAdv = adprt.getNumOfAdv();
    String [] sMktName = adprt.getMktName();
    String [] sMkt = adprt.getMkt();
    String [][] sMedia = adprt.getMedia();
    String [][] sWkDay = adprt.getWkDay();
    String [][] sDate = adprt.getDate();
    String [][] sPromo = adprt.getPromo();
    String [][] sPayee = adprt.getPayee();
    String [][] sSize = adprt.getSize();
    String [][] sCost = adprt.getCost();
    String [][] sCombo = adprt.getCombo();
    String [][] sComboType = adprt.getComboType();
    String [][] sZone = adprt.getZone();

    String sMediaJsa = adprt.getMediaJsa();
    String sWkDayJsa = adprt.getWkDayJsa();
    String sDateJsa = adprt.getDateJsa();
    String sPromoJsa = adprt.getPromoJsa();
    String sPayeeJsa = adprt.getPayeeJsa();
    String sSizeJsa = adprt.getSizeJsa();
    String sSectJsa = adprt.getSectJsa();
    String sCostJsa = adprt.getCostJsa();
    String sRateJsa = adprt.getRateJsa();
    String sWkendJsa = adprt.getWkendJsa();
    String sNumOfAdv = adprt.getNumOfAdvJsa();
    String sComboJsa = adprt.getComboJsa();
    String sComboTypeJsa = adprt.getComboTypeJsa();
    String sZoneJsa = adprt.getZoneJsa();

    String sWeekJsa = adprt.cvtToJavaScriptArray(sWeeks);

    adprt.disconnect();
%>
<html>
<head>
<style>
        body {background:white; text-align:center;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }



        td.DataTable  { background:white; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:left; font-family:Arial;font-size:10px }

        td.DataTable1  { background:white; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }


        .small{ text-align:left; font-family:Arial; font-size:10px;}

@media screen
{
        th.Order { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                  border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                  font-family:Verdanda; font-size:12px }
        td.Order { background:white; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:left; font-family:Arial;font-size:10px }
}
@media print
{
        th.Order {display: none; }
        td.Order  {display: none; }
}

</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
var NumOfMkt = <%=iNumOfMkt%>;
var NumOfAdv = [<%=sNumOfAdv%>];
var WkDay = [<%=sWkDayJsa%>];
var Date = [<%=sDateJsa%>];
var Promo = [<%=sPromoJsa%>];
var Payee = [<%=sPayeeJsa%>];
var Size = [<%=sSizeJsa%>];
var Sect = [<%=sSectJsa%>];
var Cost = [<%=sCostJsa%>];
var Rate = [<%=sRateJsa%>];
var Wkend = [<%=sWkendJsa%>];
var Weeks = [<%=sWeekJsa%>];
var Combo = [<%=sComboJsa%>];
var ComboType = [<%=sComboTypeJsa%>];
var Zone = [<%=sZoneJsa%>];

var selWkDay = new Array();
var selDate = new Array();
var selPromo = new Array();
var selPayee = new Array();
var selSize = new Array();
var selSect = new Array();
var selCost = new Array();
var selRate = new Array();
var selWkend = new Array();
var selCombo = new Array();
var selComboType = new Array();
var selZone = new Array();
//---------------------------------------------------------
// work on loading time
//---------------------------------------------------------
function bodyLoad()
{
   showOnlyComboLeading();
}
//---------------------------------------------------------
// show Only Combo Leading check box
//---------------------------------------------------------
function showOnlyComboLeading()
{
  for(var i=0; i < NumOfMkt; i++ )
  {
    for(var j=0, l=0; j < NumOfAdv[i]; j++ )
    {
       if(ComboType[i][j]=="T")
       {
          obj = "M" + i + "A" + j;
          document.all[obj].style.visibility="hidden";
       }
    }
  }

}
//---------------------------------------------------------
// Check/uncheck all orders
//---------------------------------------------------------
function checkAll(action)
{
   var i=0;
   var j=0;
   var obj = "M" + i + "A" + j;
   while(document.all[obj] != null)
   {
     while(document.all[obj] != null)
     {
       document.all[obj].checked = action;
       j++;
       obj = "M" + i + "A" + j;
     }
     i++;
     j=0;
     obj = "M" + i + "A" + j;
   }
}
//---------------------------------------------------------
// show selected ads on next page ad Order form
//---------------------------------------------------------
function printOrder()
{
  var NumOfPage = 0;
  var svPayee = null;
  var svWkend = null;

  for(var i=0; i < NumOfMkt; i++ )
  {
    for(var j=0, l=0; j < NumOfAdv[i]; j++ )
    {
       obj = "M" + i + "A" + j;
       if( document.all[obj].checked )
       {
          if(svPayee == null || svPayee != Payee[i][j] || svWkend != Wkend[i][j])
          {
            NumOfPage++; l=0;
            selWkDay[NumOfPage-1] = new Array();
            selDate[NumOfPage-1] = new Array();
            selPromo[NumOfPage-1] = new Array();
            selPayee[NumOfPage-1] = new Array();
            selSize[NumOfPage-1] = new Array();
            selSect[NumOfPage-1] = new Array();
            selCost[NumOfPage-1] = new Array();
            selRate[NumOfPage-1] = new Array();
            selWkend[NumOfPage-1] = new Array();
            selCombo[NumOfPage-1] = new Array();
            selComboType[NumOfPage-1] = new Array();
            selZone[NumOfPage-1] = new Array();
          }

          svPayee = Payee[i][j]; svWkend = Wkend[i][j];

          selWkDay[NumOfPage-1][l] = WkDay[i][j];
          selDate[NumOfPage-1][l] = Date[i][j];
          selPromo[NumOfPage-1][l] = Promo[i][j];
          selPayee[NumOfPage-1][l] = Payee[i][j];
          selSize[NumOfPage-1][l] = Size[i][j];
          selSect[NumOfPage-1][l] = Sect[i][j];
          selCost[NumOfPage-1][l] = Cost[i][j];
          selRate[NumOfPage-1][l] = Rate[i][j];
          selWkend[NumOfPage-1][l++] = Wkend[i][j];
          selCombo[NumOfPage-1][l] = Combo[i][j];
          selComboType[NumOfPage-1][l] = ComboType[i][j];
          markComboTrailer(Combo[i][j], ComboType[i][j]);
          selZone[NumOfPage-1][l] = Zone[i][j];
       }
    }
 }
   openOrderPage(NumOfPage);
}
//---------------------------------------------------------
// check combo trailer records for selected leading
//---------------------------------------------------------
function markComboTrailer(combo, combotype)
{
  if (combotype=="L")
  {
    for(var i=0; i < NumOfMkt; i++ )
    {
      for(var j=0, l=0; j < NumOfAdv[i]; j++ )
      {
         if(combo==Combo[i][j] && ComboType[i][j]=="T")
         {
            obj = "M" + i + "A" + j;
            document.all[obj].checked=true;
         }
      }
    }
  }
}
//---------------------------------------------------------
// open Order form in new page
//---------------------------------------------------------
function openOrderPage(NumOfPage)
{
  var url = 'AdPrintOrder.jsp?Page=' + NumOfPage;
  var WindowName = 'PrintOrder';
  var WindowOptions =
   'width=800,height=500, left=100,top=50, resizable=yes , toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,menubar=yes';

  var OpenWindow = window.open(url, WindowName, WindowOptions);
}

//---------------------------------------------------------
// check ads for selected week
//---------------------------------------------------------
function chkSelWk(box)
{
  var obj = null;
  var chk = box.checked;
  var wk = Weeks[box.value];

  for(var i=0; i < NumOfMkt; i++ )
  {
    for(var j=0, l=0; j < NumOfAdv[i]; j++ )
    {
       obj = "M" + i + "A" + j;
       if(wk == Wkend[i][j]) document.all[obj].checked = chk;
    }
  }
}
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad()" >
<!-------------------------------------------------------------------->
<div id="dvCalendar" class="Cal"></div>
<!-------------------------------------------------------------------->
   <b><font size="+2"><%=sMonName%> Newspaper Advertising</font></b><br><br>

   <a href="../"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This page.</font>&nbsp;&nbsp;
   <a href="javascript: window.print()"><font color="blue" size="-1">Print</font></a>
   &nbsp;&nbsp;&nbsp;
   <font size="-1">Weeks:
     <%for(int i=0; i < iNumOfWk; i++) {%>
       <%=i+1%><input name="Week" type="checkbox" value="<%=i%>" onClick="chkSelWk(this)">&nbsp; &nbsp;
     <%}%>
   </font>

   <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
        <th class='DataTable' >Market</th>
        <th class='DataTable' >Media</th>
        <th class='DataTable' >Run Date</th>
        <th class='DataTable' >Theme</th>
        <th class='DataTable' >Size</th>
        <th class='DataTable' >Cost</th>
        <th class='Order' ><a href="javascript: printOrder()">Order</a><br>
           <span style="font-size:10px"><a href="javascript: checkAll(false)">Reset</a>,
                   <a href="javascript: checkAll(true)">Check</a></span>
        </th>
      </tr>
     <!---------------- Market ---------------------------------------------------->
     <%for(int i=0; i < iNumOfMkt; i++) {%>
       <%if(iNumOfAdv[i] > 0) {%>
           <tr>
               <td class="DataTable" rowspan="<%=iNumOfAdv[i]%>" ><%=sMktName[i]%></td>
           <!---------------- Ads ---------------------------------------------------->
           <%for(int j=0; j < iNumOfAdv[i]; j++) {
              if(j>0){%><tr><%}%>
              <td class="DataTable">&nbsp;<%=sPayee[i][j]%>
                 <%if(sComboType[i][j].equals("L")){%><font color="red"><sup>cl</sup></font><%}%>
                 <%if(sComboType[i][j].equals("T")){%><font color="red"><sup>ct</sup></font><%}%>
              </td>
              <td class="DataTable">&nbsp;<%=sWkDay[i][j]%> <%=sDate[i][j]%></td>
              <td class="DataTable">&nbsp;<%=sPromo[i][j]%></td>
              <td class="DataTable">&nbsp;<%=sSize[i][j]%></td>
              <td class="DataTable1">$<%=sCost[i][j]%></td>
              <td class="Order">
                 <input name="M<%=i%>A<%=j%>" class="Small" type="checkbox" value="M<%=i%>A<%=j%>"></td>
              </tr>
           <%}%>
       <%}%>
     <%}%>
    </table>
    <p align=left>
    <font size="-1">
      <font color="red"><sup>cl</sup></font> - Combo package: leading record<br>
      <font color="red"><sup>ct</sup></font> - Combo package: trailer record
    </font>
</body>
</html>

<%
   adprt.disconnect();
 }
%>

