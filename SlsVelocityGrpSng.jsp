<%@ page import="salesvelocity.SlsVelocityGrp, rciutility.StoreSelect, java.util.*"%>
<%
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");
   String sFrWeek = request.getParameter("FrWeek");
   String sToWeek = request.getParameter("ToWeek");
   String [] sSelStr = request.getParameterValues("Str");
   String sLevel = "I";

   SlsVelocityGrp slsVel = new SlsVelocityGrp(sSelCls, sSelVen, sSelSty, sSelStr
              , sFrWeek, sToWeek);
   int iNumOfItm = slsVel.getNumOfItm();

   int iNumOfStr = slsVel.getNumOfStr();
   String [] sStr = slsVel.getStr();
%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}

        th.DataTable  { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }


        tr.DataTable  { background:LightGrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable2  { background:#cccfff; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#ccffcc; font-family:Arial; font-size:10px }

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

        div.dvStyle { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:900; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; overflow:none;}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>
<SCRIPT language="JavaScript1.2">

//--------------- Global variables -----------------------
var FrWeek = "<%=sFrWeek%>"
var ToWeek = "<%=sToWeek%>"

var SelStr = new Array();
<%for(int i=0; i < sSelStr.length; i++){%>
   SelStr[<%=i%>] = "<%=sSelStr[i]%>";
<%}%>


//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStyle"]);
   document.all.lnkIncl.style.display = "none";
}
//==============================================================================
// show details
//==============================================================================
function showDtl(cls, ven, sty)
{
   var url = "SlsVelocityGrpSng.jsp?Cls=" + cls
     + "&Ven=" + ven
     + "&Sty=" + sty
     + "&FrWeek=" + FrWeek
     + "&ToWeek=" + ToWeek

   for(var i=0; i < SelStr.length; i++)
   {
      url += "&Str=" + SelStr[i];
   }

   window.open(url, "Item_Group_Sellers")
   //window.frame1.location.href=url
}
//==============================================================================
// display single style details
//==============================================================================
function setDtl(dtl)
{
   var hdr = "Item Details";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt1' colspan=2>"
        + popItmPanel(dtl)
     + "</td></tr>"
   + "</table>"


   document.all.dvStyle.innerHTML = html;
   document.all.dvStyle.innerHTML = html;
   document.all.dvStyle.style.pixelLeft= document.documentElement.scrollLeft + 20;
   document.all.dvStyle.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvStyle.style.visibility = "visible";
}
//==============================================================================
// display tem panel
//==============================================================================
function popItmPanel(dtl)
{
   var panel = "<table border=0 cellPadding='5' cellSpacing='0'>"
   panel += "<tr><td class='Prompt'>"
      + dtl
   panel += "</td></tr>"

   panel += "<tr><td class='Prompt1'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvStyle.innerHTML = " ";
   document.all.dvStyle.style.visibility = "hidden";
}

//==============================================================================
// show details
//==============================================================================
function switchOnhand(type)
{
   var spincl = document.all.spIncl;
   var spexcl = document.all.spExcl;
   var sponly = document.all.spOnly;

   var dispi = "block", dispe = "none", dispo = "none";
   var lnkdispi = "none", lnkdispe = "inline", lnkdispo = "inline";

   if(type=="E") { dispi = "none"; dispe = "block"; dispo = "none";}
   if(type=="O") { dispi = "none"; dispe = "none"; dispo = "block"; }

   if(type=="E") { lnkdispi = "inline"; lnkdispe = "none"; lnkdispo = "inline";}
   if(type=="O") { lnkdispi = "inline"; lnkdispe = "inline"; lnkdispo = "none";}

   document.all.lnkIncl.style.display = lnkdispi;
   document.all.lnkExcl.style.display = lnkdispe;
   document.all.lnkOnly.style.display = lnkdispo;

   document.all.spnInvHdr.innerHTML = "Net On Hand + In Transit";
   if(type=="E") { document.all.spnInvHdr.innerHTML = "Exclude In Transit"; }
   if(type=="O") { document.all.spnInvHdr.innerHTML = "In Transit Only"; }

   for(var i=0; i < spincl.length; i++)
   {
      spincl[i].style.display = dispi;
      spexcl[i].style.display = dispe;
      sponly[i].style.display = dispo;
   }
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStyle" class="dvStyle"></div>
<!-------------------------------------------------------------------->
  <div style="clear: both; overflow: AUTO; width: 100%; height: 100%; POSITION: relative; color:black;" >
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <thead>
        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable" style="border-right:none" colspan=20>
            <b>Retail Concepts, Inc
            <br>Item Group Sellers Report
            <br>Stores:
               <%String sComa = "";%>
               <%for(int i=0; i < sSelStr.length;i++){%>
                  <%=sComa%><%=sSelStr[i]%>
                  <%sComa = ", ";%>
               <%}%>

              <br>From Week: <%=sFrWeek%> &nbsp;&nbsp;&nbsp;&nbsp;
                  To Week: <%=sToWeek%> &nbsp;&nbsp;&nbsp;&nbsp;
              <br>Inventory: <span id="spnInvHdr">Net On Hand + In Transit</span>
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="SlsVelocityGrpSel.jsp"><font color="red" size="-1">Select Report</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp;

              <a id="lnkIncl" class="Small" href="javascript: switchOnhand('I')">Include In Transit</a> &nbsp; &nbsp;
              <a id="lnkExcl" class="Small" href="javascript: switchOnhand('E')">Exclude In Transit</a> &nbsp; &nbsp;
              <a id="lnkOnly" class="Small" href="javascript: switchOnhand('O')">In Transit</a>

          </th>
          <th class="DataTable" colspan=29>&nbsp;</th>
        </tr>


        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable">Div<br>#</th>
          <th class="DataTable">Dpt<br>#</th>
          <th class="DataTable">Item<br>Number</th>
          <th class="DataTable">Item<br>Description</th>
          <th class="DataTable">Vendor<br>Name</th>
          <th class="DataTable">Chain<br>Retail</th>
          <th class="DataTable" colspan="2">WTD<br>Chain Sales</th>
          <th class="DataTable" colspan="2">Total Units</th>
          <th class="DataTable" colspan="<%=iNumOfStr + 1%>">Sales / Current Inventory by Store</th>
        </tr>

        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable" colspan=6>&nbsp;</th>
          <th class="DataTable" >Units</th>
          <th class="DataTable" >Retail</th>
          <th class="DataTable" >On<br>Hand</th>
          <th class="DataTable" >On<br>Order</th>

          <th class="DataTable" >&nbsp;</th>
          <%for(int i=0; i < iNumOfStr; i++) {%>
            <th class="DataTable" ><%=sStr[i]%></th>
          <%}%>
        </tr>
        </thead>
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
              String sClr = slsVel.getClr();
              String sSiz = slsVel.getSiz();
              String sChnRet = slsVel.getChnRet();
              String sDesc = slsVel.getDesc();
              String sVenName = slsVel.getVenName();
              String [] sOnhand = slsVel.getOnhand();
              String [] sTrans = slsVel.getTrans();
              String [] sSlsRet = slsVel.getSlsRet();
              String [] sSlsUnit = slsVel.getSlsUnit();
              String sTotOnhand = slsVel.getTotOnhand();
              String sTotTrans = slsVel.getTotTrans();
              String sTotSlsRet = slsVel.getTotSlsRet();
              String sTotSlsUnit = slsVel.getTotSlsUnit();
              boolean bCvs = slsVel.getCvs();
              String [] sExclTrn = slsVel.getExclTrn();
              String sTotExcl = slsVel.getTotExcl();
           %>

              <%if(bCvs) { sClass = "DataTable1";}
                else { sClass = "DataTable3";}%>

              <tr class=<%=sClass%> id="tr<%=sCls+sVen+sSty%>0">
                <td class="DataTable" rowspan="2"><%=sDiv%></td>
                <td class="DataTable" rowspan="2"><%=sDpt%></td>
                <td class="DataTable1" rowspan="2" nowrap>
                    <%if(sLevel.equals("S")){%>
                       <a href="javascript:showDtl('<%=sCls%>', '<%=sVen%>', '<%=sSty%>')"><%=sCls%>-<%=sVen%>-<%=sSty%></a>
                    <%}
                      else {%>
                         <%if(!bCvs){%><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%><%}
                           else {%><%=sCls%>-<%=sVen%>-<%=sSty%><%}%>
                    <%}%>
                </td>
                <td class="DataTable1" rowspan="2" nowrap><%if(bCvs){%><%=sDesc%><%}%>&nbsp;</td>
                <td class="DataTable1" rowspan="2" nowrap><%if(bCvs){%><%=sVenName%><%}%>&nbsp;</td>
                <td class="DataTable" rowspan="2"><%=sChnRet%></td>
                <td class="DataTable" rowspan="2"><%=sTotSlsUnit%></td>
                <td class="DataTable" rowspan="2"><%=sTotSlsRet%></td>
                <td class="DataTable" rowspan="2"><%=sTotOnhand%></td>
                <td class="DataTable" rowspan="2"><%=sTotTrans%></td>

                <td class="DataTable3" >Sales</td>
                  <%for(int j=0; j < iNumOfStr; j++) {%>
                      <td class="DataTable" ><%if(!sSlsUnit[j].equals("0")){%><%=sSlsUnit[j]%><%} else {%>&nbsp;<%}%></td>
                  <%}%>
              </tr>
              <tr class=<%=sClass%> id="tr<%=sCls+sVen+sSty%>1">
                <td class="DataTable3">I</td>
                  <%for(int j=0; j < iNumOfStr; j++) {%>
                      <td class="DataTable" >
                        <span id="spIncl"><%if(!sOnhand[j].equals("0")){%><%=sOnhand[j]%><%} else {%>&nbsp;<%}%></span>
                        <span id="spExcl" style="display:none;"><%if(!sExclTrn[j].equals("0")){%><%=sExclTrn[j]%><%} else {%>&nbsp;<%}%></span>
                        <span id="spOnly" style="display:none;"><%if(!sTrans[j].equals("0")){%><%=sTrans[j]%><%} else {%>&nbsp;<%}%></span>
                      </td>
                  <%}%>
                </td>
              </tr>
              <%if(bCvs) { bOdd = !bOdd;}%>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
 </div>
 </body>
</html>
<%
slsVel.disconnect();
slsVel = null;
%>