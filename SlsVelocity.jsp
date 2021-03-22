<%@ page import="salesvelocity.*, rciutility.StoreSelect, java.util.*"%>
<%
   String [] sDivision = request.getParameterValues("Div");
   String sFrWeek = request.getParameter("FrWeek");
   String sToWeek = request.getParameter("ToWeek");
   String [] sSelStr = request.getParameterValues("Str");
   String sOnPage = request.getParameter("OnPage");
   String sSortBy = request.getParameter("Sort");
   if (sOnPage == null){ sOnPage = "30"; }

   SlsVelocity slsVel = new SlsVelocity(sDivision, sSelStr, sFrWeek, sToWeek, sSortBy, sOnPage);
   int iNumOfItm = slsVel.getNumOfItm();

   int iNumOfStr = slsVel.getNumOfStr();
   String [] sStr = slsVel.getStr();
   String sStrJSA = slsVel.getStrJSA();

  // Division and Date selection Arrays
   SlsVelocitySel selVel = new SlsVelocitySel();
   String sDivJSA = selVel.getDivJSA();
   String sDivNameJSA = selVel.getDivNameJSA();
   String sFrWeekJSA = selVel.getDateJSA();

   selVel.disconnect();

   boolean bShow5Wk = sFrWeek.equals(sToWeek);

   StoreSelect strlst = new StoreSelect(12);
   int iNumOfAllStr = strlst.getNumOfStr();
   String [] sAllStr = strlst.getStrLst();
   strlst = null;
%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}

        th.DataTable  { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }


        tr.DataTable  { background:LightGrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-top: double darkred; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}

        td.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }

        .Small {font-size:10px }
        select.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.dvForm { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:auto; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; 
                     font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>
<SCRIPT language="JavaScript1.2">

//--------------- Global variables -----------------------
var Div = [<%=sDivJSA%>];
var DivName = [<%=sDivNameJSA%>];
var Date = [<%=sFrWeekJSA%>];

var SelDiv = new Array();
<%for(int i=0; i < sDivision.length; i++){%> SelDiv [<%=i%>] = "<%=sDivision[i]%>";<%}%>

var SelDate = "<%=sFrWeek%>"
var Sort = "<%=sSortBy%>"
var SelStrLst = [<%=sStrJSA%>];
var AllStr = new Array();
<%for(int i=0; i < iNumOfAllStr; i++){%>AllStr[<%=i%>] = "<%=sAllStr[i]%>";<%}%>
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
  selPanel();

  // checked current sort by
  if (Sort == "U")  document.all.Sort[0].checked = true;
  else if (Sort == "R")  document.all.Sort[1].checked = true;
  else if (Sort == "G")  document.all.Sort[2].checked = true;
}
//==============================================================================
// show reoport selection panel
//==============================================================================
function selPanel()
{

   var selHtml = "<table border=0 cellPadding='0' cellSpacing='0' style='font-size:10px' width='100%'>"
    + "<tr>"
      + "<td class='BoxName'>Select Report Parameters</td>"
      + "<td class='BoxClose'>"
         +  "<img src='miinimize_sign.bmp' onclick='javascript: dspSelPanel(&#34;none&#34;);' alt='Minimize'>&nbsp;"
         +  "<img src='restore_sign.bmp' onclick='javascript: dspSelPanel(&#34;block&#34;);' alt='Restore'>&nbsp;"
      + "</td>"
    + "<tr>"

   + "<tr><td colspan=2>"

   var dummy ="<table>";
   selHtml += "<div id='dvSelTbl' style='display:none; font-size:10px'>"

   selHtml += "<table border=0 cellPadding='0' cellSpacing='0' style='font-size:10px'>"
   selHtml += "<tr><td colspan=12>Division:</td></tr>"
   for(var i=1; i < Div.length; i++)
   {
       if((i-1)==0 || (i-1)%12==0) {selHtml += "<tr>" }

       selHtml += "<td style='text-align:right; padding-left:5px'>"
           + Div[i] + "<input style='font-size:10px' name='Div' type='checkbox' value='"
           + Div[i] + "'> &nbsp;  &nbsp;"
        + "</td>"
   }

   selHtml += "<tr><td colspan=12>"
      + "<button class='Small' onClick='markAll(&#34;Div&#34;, true)'>All Division</button> &nbsp;"
      + "<button class='Small' onClick='markAll(&#34;Div&#34;, false)'>Reset</button>"
    + "</td></tr>"

   selHtml += "<tr><td colspan=12><hr/></td></tr>"
   selHtml += "<tr><td colspan=12>Store:</td></tr>"

   for(var i=0; i < AllStr.length; i++)
   {
       if(i==0 || i%12==0) {selHtml += "<tr>" }
       selHtml += "<td style='text-align:right; padding-left:5px'>"
           + AllStr[i] + "<input style='font-size:10px' name='Str' type='checkbox' value='"
           + AllStr[i] + "'> &nbsp;  &nbsp;"
           + "</td>"
   }

   selHtml += "<tr><td colspan=12>"
      + "<button class='Small' onClick='markAll(&#34;Str&#34;, true)'>All Stores</button> &nbsp;"
      + "<button class='Small' onClick='markAll(&#34;Str&#34;, false)'>Reset</button>"
      + "</td></tr>"

   selHtml += "<tr><td colspan=12><hr/></td></tr>"
   selHtml += "</table>"

   selHtml += "<br>" + setDatePanel()
      + "<br>Sort By ==> Units:<input name='Sort' type='radio' value='U'>"
      + "&nbsp;&nbsp;&nbsp;"
      + "Retail<input name='Sort' type='radio' value='R'>"
      + "&nbsp;&nbsp;&nbsp;"
      + "GM$<input name='Sort' type='radio' value='G'>"
      + "&nbsp;&nbsp;&nbsp;"
      + "<button class='small' onClick='Validate()'>Submit</button>"

   selHtml += "</div>"
   selHtml += "</td></tr></table>"

   document.all.dvForm.innerHTML=selHtml;
   document.all.dvForm.style.left= document.documentElement.scrollLeft + 10;
   document.all.dvForm.style.top= document.documentElement.scrollTop + 0;
   document.all.dvForm.style.visibility="visible";

   switchWk();
   doDateSelect();
   markSelDiv();
   markSelStr();
}
//==============================================================================
// marked Selection Division
//==============================================================================
function markAll(fldnm, check)
{
   var fld = document.all[fldnm];

   for(var i=0; i < fld.length; i++)
   {
      fld[i].checked = check;
   }
}
//==============================================================================
// marked Selection Division
//==============================================================================
function markSelDiv()
{
   for(var i=0; i < document.all.Div.length; i++)
   {
      var div = document.all.Div[i].value;
      for(var j=0; j < SelDiv.length; j++)
      {
         if(eval(div) == eval(SelDiv[j])) { document.all.Div[i].checked = true; }
      }
   }
}
//==============================================================================
// marked Selection Division
//==============================================================================
function markSelStr()
{
   for(var i=0; i < document.all.Str.length; i++)
   {
      var str = document.all.Str[i].value;
      for(var j=0; j < SelStrLst.length; j++)
      {
         if(eval(str) == eval(SelStrLst[j])) { document.all.Str[i].checked = true; }
      }
   }
}
//==============================================================================
// display selection table
//==============================================================================
function dspSelPanel(disp)
{
   document.all.dvSelTbl.style.display = disp;
}

//==============================================================================
// set date panel
//==============================================================================
function setDatePanel()
{
   html = "<table style='font-size:10px'>"
      + "<TR id='Wk1'><TD align=center colspan=2>Week:"
         + " <SELECT  class='small' name='Week'></SELECT></TD></tr>"
      + "<TR id='Wk2'><TD align=center colspan=2 nowrap>"
         + " From Week: <SELECT class='small' name='FrWeek'></SELECT> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
         + " To Week: <SELECT class='small' name='ToWeek'></SELECT></TD></tr>"
      + "<tr><td colspan=2 align=center><button class='small' id='btnSwitch' onclick='switchWk()'></button></td></tr>"
    + "</table>"
   return html;
}
//==============================================================================
// populate date selection fields
//==============================================================================
function doDateSelect() {
    var date = [<%=sFrWeekJSA%>];

    document.all.Week.options[0] = new Option("Current Date", "CURDATE");

    for (idx = 0; idx < date.length; idx++)
    {
       document.all.FrWeek.options[idx] = new Option(date[idx],date[idx]);
       document.all.ToWeek.options[idx] = new Option(date[idx],date[idx]);
       document.all.Week.options[idx + 1] = new Option(date[idx],date[idx]);
    }
}
//==============================================================================
// switch between 1 and 2 weeks
//==============================================================================
function switchWk()
{
   var wk2sts = "block";
   var wk1sts = "none";
   var btnLit = "1 Weeks";

   if(document.all.Wk1.style.display != "block") {   wk2sts = "none";  wk1sts = "block"; btnLit = "2 Weeks"; }
   document.all.Wk1.style.display = wk1sts;
   document.all.Wk2.style.display = wk2sts;
   document.all.btnSwitch.innerHTML = btnLit;
}
//==============================================================================
// validate entries
//==============================================================================
function Validate()
{
   var error = false;
   var msg ="";

   div = new Array();
   divsel = false;
   for(var i=0, j=0; i < document.all.Div.length; i++)
   {
      if(document.all.Div[i].checked){ divsel = true; div[j++] = document.all.Div[i].value}
   }
   if(!divsel) { error = true; msg += "Check at least 1 division.\n";}

   str = new Array();
   strsel = false;
   for(var i=0, j=0; i < document.all.Str.length; i++)
   {
      if(document.all.Str[i].checked){ strsel = true; str[j++] = document.all.Str[i].value}
   }
   if(!strsel) { error = true; msg += "Check at least 1 store.\n";}


   if (document.all.Wk1.style.display != "block")
   {
      from = document.all.FrWeek.options[document.all.FrWeek.selectedIndex].value;
      to = document.all.ToWeek.options[document.all.ToWeek.selectedIndex].value;
   }
   else
   {
      from = document.all.Week.options[document.all.Week.selectedIndex].value;
      to = from;
   }

   var sort = null;
   for(var i=0; i < document.all.Sort.length; i++)
   {
      if(document.all.Sort[i].checked){ sort = document.all.Sort[i].value; break; }
   }

   if(error){ alert(msg); }
   else { submit(div, str, from, to, sort); }
}
//==============================================================================
//submit report
//==============================================================================
function submit(div, str, from, to, sort)
{
   var url = "SlsVelocity.jsp?"
       + "FrWeek=" + from
       + "&ToWeek=" + to
       + "&OnPage=<%=sOnPage%>"
       + "&Sort=" + sort;

   for(var i=0, j=0; i < div.length; i++)
   {
      url += "&Div=" + div[i]
   }

   for(var i=0, j=0; i < str.length; i++)
   {
      url += "&Str=" + str[i]
   }


   //alert(url);
   window.location.href = url;
}
</SCRIPT>


</head>
<body onload="bodyLoad()">

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="left" width="300">
       <div id="dvForm" class="dvForm"></div>
      </td>
<!-------------------------------------------------------------------->

      <td ALIGN="center" VALIGN="TOP" nowrap>
        <b>Retail Concepts, Inc
        <br>Top Style Sellers Report
        <br>Divisions:
            <%String sComa = "";%>
            <%for(int i=0; i < sDivision.length;i++){%>
              <%=sComa%><%=sDivision[i]%>
              <%sComa = ", ";%>
            <%}%>
        <br>Stores:
            <%sComa = "";%>
            <%for(int i=0; i < sSelStr.length;i++){%>
              <%=sComa%><%=sSelStr[i]%>
              <%sComa = ", ";%>
            <%}%>

            <%if(bShow5Wk){%>
              <br>Week: <%if(sFrWeek.equals("CURDATE")) out.print("Current");
                    else  out.print(sFrWeek);%> &nbsp;&nbsp;&nbsp;&nbsp;
            <%}
            else {%>
               <br>From Week: <%=sFrWeek%> &nbsp;&nbsp;&nbsp;&nbsp;
               To Week: <%=sToWeek%> &nbsp;&nbsp;&nbsp;&nbsp;
            <%}%>
            <br>Sorted By <%if(sSortBy.equals("U")) { out.print("Unit"); }
                    else if(sSortBy.equals("U")) { out.print("Retail"); }
                    else if(sSortBy.equals("G")) { out.print("Gross Margin"); }
                    %></b>
      </td>

      <td ALIGN="center" VALIGN="TOP" nowrap width="30%">&nbsp;</td>
     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan="3">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="SlsVelocitySel.jsp">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2">Div<br>#</th>
          <th class="DataTable" rowspan="2">Dpt<br>#</th>
          <th class="DataTable" rowspan="2">Item<br>Number</th>
          <th class="DataTable" rowspan="2">Item<br>Description</th>
          <th class="DataTable" rowspan="2">Vendor<br>Name</th>
          <th class="DataTable" rowspan="2">Avg<br>Chain<br>Retail</th>
          <th class="DataTable" colspan="3">WTD Selected<br>Stores Sales</th>
          <%if(bShow5Wk){%><th class="DataTable" colspan="2">Current <br>Total Units</th><%}%>
          <%if(bShow5Wk){%>
             <th class="DataTable" colspan="5">Prior 5 Week Unit Sales</th>
          <%}%>
          <th class="DataTable" colspan="<%=iNumOfStr + 1%>">WTD Sales<%if(bShow5Wk){%>/ Current Inventory byStore<%}%></th>
          <th class="DataTable" rowspan="2">Inv<br>Online</th>
        </tr>

        <tr>
          <th class="DataTable" >Units</th>
          <th class="DataTable" >Retail</th>
          <th class="DataTable" >GM$</th>
          <%if(bShow5Wk){%>
             <th class="DataTable" >On<br>Hand</th>
             <th class="DataTable" >On<br>Order</th>
          <%}%>

          <%if(bShow5Wk){%>
             <%for(int i=0; i < 5; i++) {%>
               <th class="DataTable" ><%=i+1%></th>
             <%}%>
          <%}%>

          <th class="DataTable" >&nbsp;</th>
          <%for(int i=0; i < iNumOfStr; i++) {%>
            <th class="DataTable" ><%=sStr[i]%></th>
          <%}%>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%String sClass = null;
           boolean bOdd = true; %>
           <%for(int i=0; i < iNumOfItm; i++) {
              slsVel.setItems();
              String sDiv = slsVel.getDiv();
              String sDpt = slsVel.getDpt();
              String sCls = slsVel.getCls();
              String sVen = slsVel.getVen();
              String sSty = slsVel.getSty();
              String sUnits = slsVel.getUnits();
              String sRetail = slsVel.getRetail();
              String sOnHand = slsVel.getOnHand();
              String sOnOrder = slsVel.getOnOrder();
              String sAvgRet = slsVel.getAvgRet();
              String sItmName = slsVel.getItmName();
              String sVenName = slsVel.getVenName();
              String [] sFiveWeekSls = slsVel.getFiveWeekSls();
              String [] sWkInv = slsVel.getWkInv();
              String [] sWkSls = slsVel.getWkSls();
              String sWtdGm = slsVel.getWtdGm();
              String sOnline = slsVel.getOnline();
           %>

              <%if(bOdd) { sClass = "DataTable"; bOdd = false;}
                else { sClass = "DataTable1"; bOdd = true; }%>

              <tr class=<%=sClass%>>
                <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>><%=sDiv%></td>
                <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>><%=sDpt%></td>
                <td class="DataTable1" <%if(bShow5Wk){%>rowspan="2"<%}%> nowrap><%=sCls + "-" + sVen + "-" + sSty%></td>
                <td class="DataTable1" <%if(bShow5Wk){%>rowspan="2"<%}%> nowrap><%=sItmName%></td>
                <td class="DataTable1" <%if(bShow5Wk){%>rowspan="2"<%}%> nowrap><%=sVenName%></td>
                <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>>$<%=sAvgRet%></td>
                <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>><%=sUnits%></td>
                <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>>$<%=sRetail%></td>
                <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>>$<%=sWtdGm%></td>
                <%if(bShow5Wk){%>
                    <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>><%=sOnHand%></td>
                    <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>><%=sOnOrder%></td>
                <%}%>

                <%if(bShow5Wk){%>
                   <%for(int j=0; j < 5; j++) {%>
                      <td class="DataTable" rowspan="2"><%=sFiveWeekSls[j]%></td>
                   <%}%>
                <%}%>

                <td class="DataTable3" >S</td>
                <%for(int j=0; j < iNumOfStr; j++) {%>
                   <td class="DataTable" ><%=sWkSls[j]%></td>
                <%}%>
                <td class="DataTable" <%if(bShow5Wk){%>rowspan="2"<%}%>><%=sOnline%></td>
              </tr>


              <%if(bShow5Wk){%>
              <tr class=<%=sClass%>>
                <td class="DataTable3" >I</td>
                <%for(int j=0; j < iNumOfStr; j++) {%>
                   <td class="DataTable" ><%=sWkInv[j]%></td>
                <%}%>
              <%}%>
              </tr>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
slsVel.disconnect();
slsVel = null;
%>