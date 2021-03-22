<%@ page import="ecommerce.EComProdSts"%>
<%
    String sSrchDiv = request.getParameter("Div");
    String sSrchDpt = request.getParameter("Dpt");
    String sSrchCls = request.getParameter("Cls");
    String sSrchVen = request.getParameter("Ven");
    String sSeason = request.getParameter("Season");
    String sSrchSite = request.getParameter("Site");
    String sLevel = request.getParameter("Level");
    String sPoNum = request.getParameter("Pon");
    String sParent = request.getParameter("Parent");
    String sSort = request.getParameter("Sort");
    String [] sStr = request.getParameterValues("Str");
    String sWeb = request.getParameter("Web");

    if(sSort==null) sSort = "GRP";
    if(sPoNum==null) sPoNum = " ";
    if(sParent==null) sParent = " ";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComProdSts.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    EComProdSts prodlst = new EComProdSts(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen, sStr
                  , sSeason, sSrchSite, sLevel, sParent, sPoNum, sWeb, sSort, sUser);
    int iNumOfProd = prodlst.getNumOfProd();
    String sColGrp = null;
    String sColGrpName = null;

    if(!sPoNum.trim().equals("") && sLevel.equals("S")){ sColGrp = "CVS"; sColGrpName = "Class-Vendor-Style Name"; }
    else if(!sPoNum.trim().equals("") && sLevel.equals("I")){ sColGrp = "ITEM"; sColGrpName = "Item Number"; }

    else if(!sParent.trim().equals("") && sLevel.equals("S")){ sColGrp = "CVS"; sColGrpName = "Class-Vendor-Style Name"; }
    else if(!sParent.trim().equals("") && sLevel.equals("I")){ sColGrp = "ITEM"; sColGrpName = "Item Number"; }

    else if(sSrchDiv.equals("ALL") && sSrchDpt.equals("ALL") && sSrchCls.equals("ALL")) { sColGrp = "Div"; sColGrpName = "Division Name"; }
    else if(sSrchDpt.equals("ALL") && sSrchCls.equals("ALL")) { sColGrp = "Dpt"; sColGrpName = "Department Name"; }
    else if(sSrchCls.equals("ALL")){ sColGrp = "Class"; sColGrpName = "Class Name"; }
    else if(!sSrchCls.equals("ALL") && sLevel.equals("S")){ sColGrp = "CVS"; sColGrpName = "Class-Vendor-Style Name"; }
    else if(!sSrchCls.equals("ALL") && sLevel.equals("I")){ sColGrp = "ITEM"; sColGrpName = "Item Number"; }

    String sSelStrJsa = prodlst.cvtToJavaScriptArray(sStr);
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvAttr { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.3">
//------------------------------------------------------------------------------
var Site = "<%=sSrchSite%>"
var Dsp5Cat = true;
var DspRCU = true;
var DspLong = true;
var SelStr = [<%=sSelStrJsa%>];
var Web = "<%=sWeb%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvAttr"]);
   //switch5Cat();
   //switchRCU();
   switchLong();
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
// show table with different sorting
//==============================================================================
function resort(sort)
{
   var url = "EComProdSts.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>"
           + "&Season=<%=sSeason%>"
           + "&Site=<%=sSrchSite%>"
           + "&Sort=" + sort
           + "&Level=<%=sLevel%>"
           + "&Web=" + Web;
   for(var i=0; i < SelStr.length; i++)
   {
      url += "&Str=" + SelStr[i];
   }

   //alert(url)
   window.location.href=url;
}

//==============================================================================
// switch Volusion site
//==============================================================================
function drilldown(grp, level)
{
   var url = "EComProdSts.jsp?"
   if(level=="Div") { url += "Div=" + grp; } else { url += "Div=<%=sSrchDiv%>"; }
   if(level=="Dpt") { url += "&Dpt=" + grp; } else { url += "&Dpt=<%=sSrchDpt%>"; }
   if(level=="Class") { url += "&Cls=" + grp; } else { url += "&Cls=<%=sSrchCls%>"; }
   url += "&Ven=<%=sSrchVen%>"
        + "&Season=<%=sSeason%>"
        + "&Site=<%=sSrchSite%>"
        + "&Sort=<%=sSort%>"
        + "&Level=<%=sLevel%>"
        + "&Web=" + Web;
   for(var i=0; i < SelStr.length; i++)
   {
      url += "&Str=" + SelStr[i];
   }
   //alert(url)
   window.location.href=url;
}

//==============================================================================
// shows Product Complete or Incomplete
//==============================================================================
function showProd(grp, level)
{
   var url = "EComProd.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=" + grp
           + "&Ven=<%=sSrchVen%>"
           + "&Season=<%=sSeason%>"
           + "&Site=<%=sSrchSite%>"
           + "&Stock=0"
           + "&Ready=0&Approved=0&Assign=ALL&Excel=N";

   //alert(url)
   window.location.href=url;
}
//==============================================================================
// shows Product Complete or Incomplete
//==============================================================================
function showItem(grp, level)
{
   var url = "EComItmLst.jsp?"
   if(level != "CVS" && level !="ITEM")
   {
       url += "Div=<%=sSrchDiv%>&Dpt=<%=sSrchDpt%>"
           + "&Cls=" + grp
           + "&Ven=<%=sSrchVen%>&Parent="
   }
   else
   {
      url += "Div=ALL&Dpt=ALL&Cls=ALL&Ven=ALL"
           + "&Parent=" + grp
   }

    url += "&Web=1&Web=2&Web=0"
           + "&From=ALL"
           + "&To=ALL"
           + "&Site=ALL"
           + "&MarkDownl=0"
           + "&Excel=N&Pon=&ModelYr=&MapExpDt="

   //alert(url)
   window.location.href=url;
}
//==============================================================================
// switch Volusion site
//==============================================================================
function otherSite()
{
   var url = "EComProdSts.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>"
           + "&Season=<%=sSeason%>"
           + "&Sort=<%=sSort%>"

   if(Site=="SASS"){ url += "&Site=SKCH"; }
   else { url += "&Site=SASS"; }

   url += "&Web=" + Web;
   for(var i=0; i < SelStr.length; i++)
   {
      url += "&Str=" + SelStr[i];
   }
   //alert(url)
   window.location.href=url;
}
//==============================================================================
// hide /display 5 categories
//==============================================================================
function switch5Cat()
{
   Dsp5Cat = !Dsp5Cat;
   var disp = "none"
   if(Dsp5Cat) { disp = "block" }

   if(disp == "block")
   {
     if(DspRCU){ document.all.thAtrl.colSpan=34; }
     else{ document.all.thAtrl.colSpan=28; }
   }
   else
   {
     if(DspRCU){ document.all.thAtrl.colSpan=28; }
     else{ document.all.thAtrl.colSpan=22; }
   }

   switchCell(document.all.thAtrl, disp);
   switchCell(document.all.cellDesc, disp);
   switchCell(document.all.cellFeat, disp);
   switchCell(document.all.cellPhoto, disp);
   switchCell(document.all.cellCateg, disp);
   switchCell(document.all.cellOpt ,disp);
   switchCell(document.all.thBlank, disp);
}
//==============================================================================
// hide /display 5 categories
//==============================================================================
function switchRCU()
{
   DspRCU = !DspRCU;
   var disp = "none"
   if(DspRCU) { disp = "block" }

   switchCell(document.all.cellLvRet, disp);
   switchCell(document.all.cellLvCost, disp);
   switchCell(document.all.cellLvUnit, disp);
   switchCell(document.all.cellInRet, disp);
   switchCell(document.all.cellInCost ,disp);
   switchCell(document.all.cellInUnit ,disp);

   //if(document.all.thCompl.colSpan==11)
   if(!DspRCU)
   {
      if(Dsp5Cat){ document.all.thAtrl.colSpan=28; }
      else{ document.all.thAtrl.colSpan=22; }
      document.all.thCompl.colSpan=8;
      document.all.thLive.colSpan=2;
      document.all.thInCompl.colSpan=9;
      document.all.thIncWS.colSpan=2;
   }
   else
   {
      if(Dsp5Cat){document.all.thAtrl.colSpan=34; }
      else{document.all.thAtrl.colSpan=28;}
      document.all.thCompl.colSpan=11;
      document.all.thLive.colSpan=5;
      document.all.thInCompl.colSpan=12;
      document.all.thIncWS.colSpan=5;
   }
}
//==============================================================================
// hide /display Long foorm
//==============================================================================
function switchLong()
{
   DspLong = !DspLong;
   var disp = "none"
   var disp1 = "none";
   if(DspLong)
   {
      disp = "block"; disp1 = "inline";
      DspRCU = true;
      Dsp5Cat = true;
      switch5Cat();
      switchRCU();
   }

   switchCell(document.all.cellLvRet, "none");
   switchCell(document.all.cellLvCost, "none");
   switchCell(document.all.cellLvUnit, "none");
   switchCell(document.all.cellInRet, "none");
   switchCell(document.all.cellInCost, "none");
   switchCell(document.all.cellInUnit, "none");
   switchCell(document.all.thAtrl, "none");
   switchCell(document.all.cellDesc, "none");
   switchCell(document.all.cellFeat, "none");
   switchCell(document.all.cellPhoto, "none");
   switchCell(document.all.cellCateg, "none");
   switchCell(document.all.cellOpt, "none");
   switchCell(document.all.thBlank, "none");

   document.all.lnkHS5Cat.style.display=disp1;
   document.all.lnkHSRCU.style.display=disp1;
   document.all.thCompl.style.display=disp;
   document.all.thLive.style.display=disp;
   document.all.thNotLive.style.display=disp;
   document.all.thCompl01.style.display=disp;
   document.all.thIncWS.style.display=disp;
   document.all.thIncTot.style.display=disp;
   document.all.thItAtrTot.style.display=disp;

   switchCell(document.all.thNotLive01, disp);
   switchCell(document.all.cellLv11, disp);
   switchCell(document.all.cellNLv11, disp);
   switchCell(document.all.cellWStk01, disp);
   switchCell(document.all.cellWoStk01, disp);
   switchCell(document.all.cellIncTot01, disp);
   switchCell(document.all.cellTot01, disp);
   switchCell(document.all.cellItNotAtr01, disp);

   //if(document.all.thCompl.colSpan==11)
   if(!DspLong)
   {
      document.all.thAtrl.colSpan=6;
      document.all.thIncWStk.colSpan=1;
      document.all.thInCompl.colSpan=4;
      document.all.thItNotAtr.colSpan=4;
   }
   else
   {
      document.all.thAtrl.colSpan=22;
      document.all.thIncWStk.colSpan=2;
      document.all.thInCompl.colSpan=9;
      document.all.thItNotAtr.colSpan=5;
   }
}
//==============================================================================
// hide /display 5 categories
//==============================================================================
function switchCell(cells, disp)
{
   for(var i=0; i < cells.length; i++)  {  cells[i].style.display=disp }
}

//==============================================================================
// show calculation
//==============================================================================
function showCalc(obj, amt1, name1, amt2, name2, prc, name3)
{
   var html = "<table border=0 cellPadding='0' cellSpacing='0' style='font-size:10px'>"
        + "<tr><td>" + name1 + "</td><td>&nbsp;</td><td>" + amt1 + "</td>"

        if(name3=="Percent"){ html += "<tr><td><td>&nbsp;</td><td>/</td></td>" }
        else if(name3=="Total") { html += "<tr><td><td>&nbsp;</td><td>+</td></td>"  }


        html += "<tr><td>" + name2 + "</td><td>&nbsp;</td><td>" + amt2 + "</td>"
        + "<tr><td colspan=2 style='border-bottom:black 1px solid;'>&nbsp;</td>"
        + "<tr><td>" + name3 + "</td><td>&nbsp;</td><td>" + prc

        if(name3=="Percent"){ html += "%"; }

        html += "&nbsp;</td>"

   html += "</table>"

   var pos = getObjPosition(obj);

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= pos[0] + 40;
   document.all.dvItem.style.pixelTop= pos[1];
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// save Attribute 01
//==============================================================================
function saveAttr(item, obj)
{
   var url = "EComUpdItemAttr.jsp?Item=" + item
   if(obj.checked){ url += "&Checked=Y"; }
   else{ url += "&Checked=N"; }

   window.frame1.location.href = url;
}
//==============================================================================
// get number of attributed item for last 4 weeks
//==============================================================================
function getWkAttr(grp, grpnm, wk1, wk2, wk3, wk4)
{
   var hdr = "Items Attributed: &nbsp;" + grp + " - " + grpnm;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel1();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popWkAttr(wk1, wk2, wk3, wk4)
     + "</td></tr>"
   + "</table>"

   document.all.dvAttr.innerHTML = html;
   document.all.dvAttr.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvAttr.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvAttr.style.visibility = "visible";

}
//==============================================================================
// populate employee commission panel
//==============================================================================
function popWkAttr(wk1, wk2, wk3, wk4)
{
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
   panel +=  "<tr class='DataTable'>"
           + "<th class='DataTable'>This<br>Week</th>"
           + "<th class='DataTable'>Week<br>2</th>"
           + "<th class='DataTable'>Week<br>3</th>"
           + "<th class='DataTable'>Week<br>4</th>"
         + "</tr>"
   panel += "<tr class='DataTable'>"
           + "<td class='DataTable'>&nbsp;" + wk1 + "</td>"
           + "<td class='DataTable'>&nbsp;" + wk2 + "</td>"
           + "<td class='DataTable'>&nbsp;" + wk3 + "</td>"
           + "<td class='DataTable'>&nbsp;" + wk4 + "</td>"
         + "</tr>"

   panel += "<tr class='DataTable2'><td class='Prompt1' colspan='4'>"
        + "<button onClick='hidePanel1();' class='Small'>Close</button></td></tr>"

   panel += "</table>";

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel1()
{
   document.all.dvAttr.innerHTML = " ";
   document.all.dvAttr.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvAttr" class="dvAttr"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Production Status Report
        <br>Division:<%=sSrchDiv%>&nbsp;&nbsp;&nbsp;
            Department:<%=sSrchDpt%>&nbsp;&nbsp;&nbsp;
            Class:<%=sSrchCls%>
        <br>Stores:
        <%for(int i=0; i < sStr.length; i++){%> <%=sStr[i]%> <%}%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComProdStsSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a id="lnkHS5Cat" href="javascript: switch5Cat()">Hide/Show 5 Categories</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a id="lnkHSRCU" href="javascript: switchRCU()">Hide/Show Ret/Cost/Unit</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a id="lnkHSLong" href="javascript: switchLong()">Hide/Show Long Form</a>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable" rowspan=5><a href="javascript:resort('GRP')"><%=sColGrp%></a></th>
             <th class="DataTable" rowspan=5><a href="javascript:resort('GRPNM')"><%=sColGrpName%></a></th>
             <th class="DataTable" rowspan=5>P<br>r<br>o<br>d</th>
             <th class="DataTable" rowspan=5>I<br>t<br>e<br>m</th>
             <th class="DataTable" id="thAtrl" colspan=22>Items (Styles) Attributed</th>
             <th class="DataTable" rowspan=5>&nbsp;</th>
             <th id="thItNotAtr" class="DataTable"  rowspan=2 colspan=5>Items (Styles) Not <br>Attributed</th>
             <%if(sColGrp.equals("ITEM")){%>
                <th class="DataTable" rowspan=5>Do Not<br>Attribute!</th>
             <%}%>
             <th class="DataTable" id="thAtr2" rowspan=5>Attributed<br>Last<br>Week</th>
         </tr>

         <tr class="DataTable">
             <th class="DataTable" id="thCompl" colspan=11>Items (Styles) Complete</th>
             <th class="DataTable" rowspan=4>&nbsp;</th>
             <th class="DataTable" id="thInCompl" colspan=12>Item (Styles) Incomplete<span style="font-size:8px; vertical-align:top;">(2)</span></th>
             <th class="DataTable" rowspan=4>&nbsp;</th>
             <th class="DataTable" id="cellDesc" colspan=5 rowspan=3>5 Completion Categories</th>
             <th class="DataTable" id="thBlank" rowspan=4>&nbsp;</th>
             <!-- th class="DataTable" colspan=3>Attributed<br>in IP</th -->
             <th class="DataTable" id="thItAtrTot" colspan=3 rowspan=3>Total</th>
         </tr>

         <tr class="DataTable">
           <th class="DataTable" id="thLive" rowspan=2 colspan=5>Live<span style="font-size:8px; vertical-align:top;">(1)</span></th>
           <th class="DataTable" id="thNotLive" colspan=4>Not Live</th>
           <th class="DataTable" id="thCompl01" rowspan=2 colspan=2>Total</th>

           <th id="thIncWStk" class="DataTable" rowspan=2 colspan=2>With Stock<span style="font-size:8px; vertical-align:top;">(3)</span></th>
           <th class="DataTable" rowspan=3>Due in<br>30 Days</th>
           <th class="DataTable" rowspan=3>Due in<br>60 Days</th>
           <th class="DataTable" rowspan=3>Due in<br>90 Days</th>
           <th class="DataTable" id="thIncWS" rowspan=2 colspan=5>W/O Stock</th>
           <th class="DataTable" id="thIncTot" rowspan=2 colspan=2>Total</th>

           <th id="cellItNotAtr01" class="DataTable" rowspan=3>With Stock in 1<br>W/O Stock in 70</th>
           <th class="DataTable" rowspan=3>With Stock<br>in sel<br>Str</th>
           <th class="DataTable" rowspan=3>Due in<br>30 Days</th>
           <th class="DataTable" rowspan=3>Due in<br>60 Days</th>
           <th class="DataTable" rowspan=3>Due in<br>90 Days</th>
           <!--th class="DataTable" rowspan=2>Total</th -->
         </tr>

         <tr class="DataTable">
           <th class="DataTable" id="thNotLive01" colspan=2>With Stock<br>Not Turned On</th>
           <th class="DataTable" id="thNotLive01" colspan=2>W/O Stock</th>
         </tr>

         <tr class="DataTable">
             <th id="cellLv11" class="DataTable"><a href="javascript:resort('HIDE')">Count</a></th>
             <th id="cellLv11" class="DataTable"><a href="javascript:resort('HIDEPRC')">%</a></th>
             <th class="DataTable" id="cellLvRet"><a href="javascript:resort('LIVERET')">Retail</a></th>
             <th class="DataTable" id="cellLvCost"><a href="javascript:resort('LIVECOST')">Cost</a></th>
             <th class="DataTable" id="cellLvUnit"><a href="javascript:resort('LIVEUNIT')">Units</a></th>

             <th id="cellNLv11" class="DataTable"><a href="javascript:resort('NOTTRN')">Count</a></th>
             <th id="cellNLv11" class="DataTable"><a href="javascript:resort('NOTTRNPRC')">%</a></th>
             <th id="cellNLv11" class="DataTable"><a href="javascript:resort('COMPNOS')">Count</a></th>
             <th id="cellNLv11" class="DataTable"><a href="javascript:resort('COMPNOSPRC')">%</a></th>
             <th id="cellNLv11" class="DataTable"><a href="javascript:resort('COMPALL')">Count</a></th>
             <th id="cellNLv11" class="DataTable"><a href="javascript:resort('COMPALLPRC')">%</a></th>

             <th class="DataTable"><a href="javascript:resort('INCSTK')">Count</a></th>
             <th id="cellWStk01" class="DataTable"><a href="javascript:resort('INCSTKPRC')">%</a></th>
             <th class="DataTable" id="cellInRet"><a href="javascript:resort('INCOMRET')">Retail</a></th>
             <th class="DataTable" id="cellInCost"><a href="javascript:resort('INCOMCOST')">Cost</a></th>
             <th class="DataTable" id="cellInUnit"><a href="javascript:resort('INCOMUNIT')">Units</a></th>

             <th id="cellWoStk01" class="DataTable"><a href="javascript:resort('INCNOS')">Count</a></th>
             <th id="cellWoStk01" class="DataTable"><a href="javascript:resort('INCNOSPRC')">%</a></th>
             <th id="cellIncTot01" class="DataTable"><a href="javascript:resort('INCOM')">Count</a></th>
             <th id="cellIncTot01" class="DataTable"><a href="javascript:resort('INCOMPRC')">%</a></th>

             <th class="DataTable" id="cellDesc"><a href="javascript:resort('DESC')">Desc</a></th>
             <th class="DataTable" id="cellFeat"><a href="javascript:resort('FEAT')">Feature</a></th>
             <th class="DataTable" id="cellPhoto"><a href="javascript:resort('PHOTO')">Photo</a></th>
             <th class="DataTable" id="cellCateg"><a href="javascript:resort('CATEG')">Category</a></th>
             <th class="DataTable" id="cellOpt"><a href="javascript:resort('OPTION')">Option</a></th>

             <th id="cellTot01" class="DataTable"><a href="javascript:resort('TOT')">RCI</a></th>
             <th id="cellTot01" class="DataTable"><a href="javascript:resort('VOL')">Live<br>Volusion</a></th>
             <th id="cellTot01" class="DataTable"><a href="javascript:resort('TOTPRC')">Vol %</a></th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfProd; i++ )
         {
            prodlst.setDetail();
            String sGrp = prodlst.getGrp().trim();
            String sGrpName = prodlst.getGrpName();
            String sGrpTotWs = prodlst.getGrpTotWs();
            String sGrpTotOs = prodlst.getGrpTotOs();
            String sGrpTot = prodlst.getGrpTot();
            String sGrpVol = prodlst.getGrpVol();
            String sDesc = prodlst.getDesc();
            String sFeature = prodlst.getFeature();
            String sPhoto = prodlst.getPhoto();
            String sCateg = prodlst.getCateg();
            String sOption = prodlst.getOption();
            String sGrpPrc = prodlst.getGrpPrc();
            String sOnhand = prodlst.getOnhand();

            String sLive = prodlst.getLive();
            String sLivePrc = prodlst.getLivePrc();

            String sCompNoStk = prodlst.getCompNoStk();
            String sCompNoStkPrc = prodlst.getCompNoStkPrc();
            String sNotTurn = prodlst.getNotTurn();
            String sNotTurnPrc = prodlst.getNotTurnPrc();
            String sCompAll = prodlst.getCompAll();
            String sCompAllPrc = prodlst.getCompAllPrc();

            String sIncomHasStk = prodlst.getIncomHasStk();
            String sIncomHasStkPrc = prodlst.getIncomHasStkPrc();
            String sIncomNoStk = prodlst.getIncomNoStk();
            String sIncomNoStkPrc = prodlst.getIncomNoStkPrc();
            String sIncom = prodlst.getIncom();
            String sIncomPrc = prodlst.getIncomPrc();

            String sLiveRet = prodlst.getLiveRet();
            String sLiveCost = prodlst.getLiveCost();
            String sLiveUnit = prodlst.getLiveUnit();
            String sIncomRet = prodlst.getIncomRet();
            String sIncomCost = prodlst.getIncomCost();
            String sIncomUnit = prodlst.getIncomUnit();

            String sOnhand70 = prodlst.getOnhand70();
            String sBsr70 = prodlst.getBsr70();
            String sOnhand01 = prodlst.getOnhand01();
            String sGrpTotUna = prodlst.getGrpTotUna();
            String sAtt01 = prodlst.getAtt01();
            String sNADue30Days = prodlst.getNADue30Days();
            String sNADue60Days = prodlst.getNADue60Days();
            String sNADue90Days = prodlst.getNADue90Days();

            String sNRDue30Days = prodlst.getNRDue30Days();
            String sNRDue60Days = prodlst.getNRDue60Days();
            String sNRDue90Days = prodlst.getNRDue90Days();
            String sWk1Attr = prodlst.getWk1Attr();
            String sWk2Attr = prodlst.getWk2Attr();
            String sWk3Attr = prodlst.getWk3Attr();
            String sWk4Attr = prodlst.getWk4Attr();
        %>
            <tr id="trProd" class="DataTable">
            <td class="DataTable2" id="tdGrp" nowrap><%=sGrp%></td>
            <%if(!sColGrp.equals("CVS")) {%>
                 <td class="DataTable1" nowrap id="tdGrpNm"><a class="Small" href="javascript: drilldown('<%=sGrp%>', '<%=sColGrp%>')"><%=sGrpName%></a></td>
            <%}
              else {%>
                 <td class="DataTable1" id="tdGrpNm" nowrap><%=sGrpName%></td>
              <%}%>

            <th class="DataTable"><%if(sColGrp.equals("Class") || sColGrp.equals("CVS") || sColGrp.equals("ITEM")){%><a class="Small" href="javascript: showProd('<%=sGrp%>', '<%=sColGrp%>')">&nbsp;P&nbsp;</a><%} else {%>&nbsp;<%}%></th>
            <th class="DataTable"><%if(sColGrp.equals("Class") || sColGrp.equals("CVS") || sColGrp.equals("ITEM")){%><a class="Small" href="javascript: showItem('<%=sGrp%>', '<%=sColGrp%>')">&nbsp;I&nbsp;</a><%} else {%>&nbsp;<%}%></th>
            <td id="cellLv11" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellLv11" class="DataTable2" onmouseover="showCalc(this, '<%=sLive%>', 'Live', '<%=sCompAll%>', 'All Completed', '<%=sLivePrc%>', 'Percent' )" onmouseout="hidePanel();" nowrap><%=sLivePrc%>%</td>
            <td class="DataTable2" id="cellLvRet" nowrap><%=sLiveRet%></td>
            <td class="DataTable2" id="cellLvCost" nowrap><%=sLiveCost%></td>
            <td class="DataTable2" id="cellLvUnit" nowrap><%=sLiveUnit%></td>

            <td id="cellNLv11" class="DataTable2" nowrap><%=sNotTurn%></td>
            <td id="cellNLv11" class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sNotTurn%>', 'With Stock Not Turned On', '<%=sCompAll%>', 'All Completed', '<%=sNotTurnPrc%>', 'Percent' )" onmouseout="hidePanel();"><%=sNotTurnPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompNoStk%></td>
            <td id="cellNLv11" class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sCompNoStk%>', 'W/O Stock', '<%=sCompAll%>', 'All Completed', '<%=sCompNoStkPrc%>', 'Percent' )" onmouseout="hidePanel();"><%=sCompNoStkPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompAll%></td>
            <td id="cellNLv11" class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sCompAll%>', 'All Completed', '<%=sGrpVol%>', 'All', '<%=sCompAllPrc%>', 'Percent' )" onmouseout="hidePanel();"><%=sCompAllPrc%>%</td>
            <th class="DataTable">&nbsp;</th>

            <td  class="DataTable2" style="background:blue; color:white" nowrap><%=sIncomHasStk%></td>
            <td id="cellWStk01" class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sIncomHasStk%>', 'Incompleted With Stock', '<%=sGrpVol%>', 'All Incompleted', '<%=sIncomHasStkPrc%>', 'Percent' )" onmouseout="hidePanel();"><%=sIncomHasStkPrc%>%</td>

            <td class="DataTable2" style="background:DarkCyan;" nowrap><%=sNRDue30Days%></td>
            <td class="DataTable2" style="background:DarkTurquoise" nowrap><%=sNRDue60Days%></td>
            <td class="DataTable2" style="background:lightblue" nowrap><%=sNRDue90Days%></td>

            <td  class="DataTable2" id="cellInRet" nowrap><%=sIncomRet%></td>
            <td  class="DataTable2" id="cellInCost" nowrap><%=sIncomCost%></td>
            <td  class="DataTable2" id="cellInUnit" nowrap><%=sIncomUnit%></td>
            <td id="cellWoStk01" class="DataTable2" nowrap><%=sIncomNoStk%></td>
            <td id="cellWoStk01"  class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sIncomNoStk%>', 'Incompleted W/O Stock', '<%=sGrpVol%>', 'All Incompleted', '<%=sIncomNoStkPrc%>', 'Percent' )" onmouseout="hidePanel();"><%=sIncomNoStkPrc%>%</td>
            <td id="cellIncTot01"  class="DataTable2" nowrap><%=sIncom%></td>
            <td id="cellIncTot01"  class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sIncom%>', 'All Incompleted', '<%=sGrpVol%>', 'Complete + Incompleted', '<%=sIncomPrc%>', 'Percent' )" onmouseout="hidePanel();"><%=sIncomPrc%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td id="cellDesc" class="DataTable2" nowrap><%=sDesc%></td>
            <td id="cellFeat" class="DataTable2" nowrap><%=sFeature%></td>
            <td id="cellPhoto" class="DataTable2" nowrap><%=sPhoto%></td>
            <td id="cellCateg" class="DataTable2" nowrap><%=sCateg%></td>
            <td id="cellOpt" class="DataTable2" nowrap><%=sOption%></td>
            <th class="DataTable" id="thBlank">&nbsp;</th>

            <td id="cellTot01" class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sGrpTotWs%>', 'With Stock', '<%=sGrpTotOs%>', 'W/O Stock', '<%=sGrpTot%>', 'Total' )" onmouseout="hidePanel();"><%=sGrpTot%></td>
            <td id="cellTot01" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellTot01" class="DataTable2" nowrap onmouseover="showCalc(this, '<%=sLive%>', 'Live', '<%=sGrpTot%>', 'Complete + Incomplete', '<%=sGrpPrc%>', 'Percent' )" onmouseout="hidePanel();"><%=sGrpPrc%>%</td>

            <th class="DataTable">&nbsp;</th>

            <td id="cellItNotAtr01" class="DataTable2" nowrap><%=sOnhand01%></td>
            <td class="DataTable2"  id="tdOnh70" style="background:red; color:white" nowrap><%=sOnhand70%></td>
            <td class="DataTable2" style="background:orange" nowrap><%=sNADue30Days%></td>
            <td class="DataTable2" style="background:gold" nowrap><%=sNADue60Days%></td>
            <td class="DataTable2" style="background:yellow" nowrap><%=sNADue90Days%></td>

            <%if(sColGrp.equals("ITEM")) {%>
               <td class="DataTable" nowrap><input type="checkbox" name="Att01"
                   value="<%=sAtt01%>" <%if(sAtt01.equals("4")){%>checked<%} else if(sAtt01.equals("1") || sAtt01.equals("2")){%>disabled readonly<%}%>
                  onclick="saveAttr('<%=sGrp%>', this)" ></a></td>
            <%}%>
            <td class="DataTable2" nowrap><a href="javascript: getWkAttr('<%=sGrp%>','<%=sGrpName%>','<%=sWk1Attr%>', '<%=sWk2Attr%>', '<%=sWk3Attr%>', '<%=sWk4Attr%>')">
              <%if(sWk2Attr.equals("")){%>none<%} else{%><%=sWk2Attr%><%}%><a>
            </td>
         </tr>
       <%}%>

       <!-- -------------------------- Total for Ski Division -------------- -->
   <%if(sSrchDiv.equals("ALL") && sSrchDpt.equals("ALL") && sSrchCls.equals("ALL")){%>
       <%
          prodlst.setTotal(1);
          String sGrp = prodlst.getGrp();
          String sGrpName = prodlst.getGrpName();
          String sGrpTotWs = prodlst.getGrpTotWs();
          String sGrpTotOs = prodlst.getGrpTotOs();
          String sGrpTot = prodlst.getGrpTot();
          String sGrpVol = prodlst.getGrpVol();
          String sDesc = prodlst.getDesc();
          String sFeature = prodlst.getFeature();
          String sPhoto = prodlst.getPhoto();
          String sCateg = prodlst.getCateg();
          String sOption = prodlst.getOption();
          String sGrpPrc = prodlst.getGrpPrc();
          String sOnhand = prodlst.getOnhand();

          String sLive = prodlst.getLive();
          String sLivePrc = prodlst.getLivePrc();

          String sCompNoStk = prodlst.getCompNoStk();
          String sCompNoStkPrc = prodlst.getCompNoStkPrc();
          String sNotTurn = prodlst.getNotTurn();
          String sNotTurnPrc = prodlst.getNotTurnPrc();
          String sCompAll = prodlst.getCompAll();
          String sCompAllPrc = prodlst.getCompAllPrc();

          String sIncomHasStk = prodlst.getIncomHasStk();
          String sIncomHasStkPrc = prodlst.getIncomHasStkPrc();
          String sIncomNoStk = prodlst.getIncomNoStk();
          String sIncomNoStkPrc = prodlst.getIncomNoStkPrc();
          String sIncom = prodlst.getIncom();
          String sIncomPrc = prodlst.getIncomPrc();
          String sLiveRet = prodlst.getLiveRet();
          String sLiveCost = prodlst.getLiveCost();
          String sLiveUnit = prodlst.getLiveUnit();
          String sIncomRet = prodlst.getIncomRet();
          String sIncomCost = prodlst.getIncomCost();
          String sIncomUnit = prodlst.getIncomUnit();

          String sGrpTotUna = prodlst.getGrpTotUna();
          String sOnhand70 = prodlst.getOnhand70();
          String sBsr70 = prodlst.getBsr70();
          String sOnhand01 = prodlst.getOnhand01();
          String sNADue30Days = prodlst.getNADue30Days();
          String sNADue60Days = prodlst.getNADue60Days();
          String sNADue90Days = prodlst.getNADue90Days();

          String sNRDue30Days = prodlst.getNRDue30Days();
          String sNRDue60Days = prodlst.getNRDue60Days();
          String sNRDue90Days = prodlst.getNRDue90Days();
          String sWk1Attr = prodlst.getWk1Attr();
          String sWk2Attr = prodlst.getWk2Attr();
          String sWk3Attr = prodlst.getWk3Attr();
          String sWk4Attr = prodlst.getWk4Attr();
       %>
       <tr id="trProd" class="DataTable1">
            <td  class="DataTable1" id="tdGrp" colspan=2 nowrap >Ski Total</td>
            <th class="DataTable" id="tdGrpNm">&nbsp;</th>
            <th class="DataTable">&nbsp;</th>

            <td id="cellLv11" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellLv11" class="DataTable2" nowrap><%=sLivePrc%>%</td>
            <td  class="DataTable2" id="cellLvRet" nowrap><%=sLiveRet%></td>
            <td  class="DataTable2" id="cellLvCost" nowrap><%=sLiveCost%></td>
            <td  class="DataTable2" id="cellLvUnit" nowrap><%=sLiveUnit%></td>

            <td id="cellNLv11" class="DataTable2" nowrap><%=sNotTurn%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sNotTurnPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompNoStk%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompNoStkPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompAll%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompAllPrc%>%</td>
            <th class="DataTable">&nbsp;</th>

            <td class="DataTable2" nowrap><%=sIncomHasStk%></td>
            <td id="cellWStk01" class="DataTable2" nowrap><%=sIncomHasStkPrc%>%</td>
            <td class="DataTable2" nowrap><%=sNRDue30Days%></td>
            <td class="DataTable2" nowrap><%=sNRDue60Days%></td>
            <td class="DataTable2" nowrap><%=sNRDue90Days%></td>

            <td  class="DataTable2" id="cellInRet" nowrap><%=sIncomRet%></td>
            <td  class="DataTable2" id="cellInCost" nowrap><%=sIncomCost%></td>
            <td  class="DataTable2" id="cellInUnit" nowrap><%=sIncomUnit%></td>
            <td id="cellWoStk01" class="DataTable2" nowrap><%=sIncomNoStk%></td>
            <td id="cellWoStk01" class="DataTable2" nowrap><%=sIncomNoStkPrc%>%</td>
            <td id="cellIncTot01"  class="DataTable2" nowrap><%=sIncom%></td>
            <td id="cellIncTot01"  class="DataTable2" nowrap><%=sIncomPrc%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td id="cellDesc" class="DataTable2" nowrap><%=sDesc%></td>
            <td id="cellFeat" class="DataTable2" nowrap><%=sFeature%></td>
            <td id="cellPhoto" class="DataTable2" nowrap><%=sPhoto%></td>
            <td id="cellCateg" class="DataTable2" nowrap><%=sCateg%></td>
            <td id="cellOpt" class="DataTable2" nowrap><%=sOption%></td>
            <th class="DataTable" id="thBlank">&nbsp;</th>


            <td id="cellTot01" class="DataTable2" nowrap><%=sGrpTotWs%></td>
            <td id="cellTot01" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellTot01" class="DataTable2" nowrap><%=sGrpPrc%>%</td>


            <th class="DataTable">&nbsp;</th>

            <td id="cellItNotAtr01" class="DataTable2" nowrap><%=sOnhand01%></td>
            <td class="DataTable2" id="tdOnh70" nowrap><%=sOnhand70%></td>
            <td class="DataTable2" nowrap><%=sNADue30Days%></td>
            <td class="DataTable2" nowrap><%=sNADue60Days%></td>
            <td class="DataTable2" nowrap><%=sNADue90Days%></td>

            <%if(sColGrp.equals("ITEM")){%><td class="DataTable2" nowrap>&nbsp;</td><%}%>

            <td class="DataTable2" nowrap><%=sWk1Attr%></td>
         </tr>
       <!-- -------------------------- Total for Non - Ski Division -------------- -->
       <%
          prodlst.setTotal(2);
          sGrp = prodlst.getGrp();
          sGrpName = prodlst.getGrpName();
            sGrpTotWs = prodlst.getGrpTotWs();
            sGrpTotOs = prodlst.getGrpTotOs();
            sGrpTot = prodlst.getGrpTot();
            sGrpVol = prodlst.getGrpVol();
            sDesc = prodlst.getDesc();
            sFeature = prodlst.getFeature();
            sPhoto = prodlst.getPhoto();
            sCateg = prodlst.getCateg();
            sOption = prodlst.getOption();
            sGrpPrc = prodlst.getGrpPrc();
            sOnhand = prodlst.getOnhand();

            sLive = prodlst.getLive();
            sLivePrc = prodlst.getLivePrc();

            sCompNoStk = prodlst.getCompNoStk();
            sCompNoStkPrc = prodlst.getCompNoStkPrc();
            sNotTurn = prodlst.getNotTurn();
            sNotTurnPrc = prodlst.getNotTurnPrc();
            sCompAll = prodlst.getCompAll();
            sCompAllPrc = prodlst.getCompAllPrc();

            sIncomHasStk = prodlst.getIncomHasStk();
            sIncomHasStkPrc = prodlst.getIncomHasStkPrc();
            sIncomNoStk = prodlst.getIncomNoStk();
            sIncomNoStkPrc = prodlst.getIncomNoStkPrc();
            sIncom = prodlst.getIncom();
            sIncomPrc = prodlst.getIncomPrc();
            sLiveRet = prodlst.getLiveRet();
            sLiveCost = prodlst.getLiveCost();
            sLiveUnit = prodlst.getLiveUnit();
            sIncomRet = prodlst.getIncomRet();
            sIncomCost = prodlst.getIncomCost();
            sIncomUnit = prodlst.getIncomUnit();

            sGrpTotUna = prodlst.getGrpTotUna();
            sOnhand70 = prodlst.getOnhand70();
            sBsr70 = prodlst.getBsr70();
            sOnhand01 = prodlst.getOnhand01();
            sNADue30Days = prodlst.getNADue30Days();
            sNADue60Days = prodlst.getNADue60Days();
            sNADue90Days = prodlst.getNADue90Days();
            sNRDue30Days = prodlst.getNRDue30Days();
            sNRDue60Days = prodlst.getNRDue60Days();
            sNRDue90Days = prodlst.getNRDue90Days();
            sWk1Attr = prodlst.getWk1Attr();
            sWk2Attr = prodlst.getWk2Attr();
            sWk3Attr = prodlst.getWk3Attr();
            sWk4Attr = prodlst.getWk4Attr();
       %>
       <tr id="trProd" class="DataTable1">
            <td  class="DataTable1" id="tdGrp" colspan=2 nowrap >Non-Ski Total</td>
            <th class="DataTable" id="tdGrpNm">&nbsp;</th>
            <th class="DataTable">&nbsp;</th>

            <td id="cellLv11" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellLv11" class="DataTable2" nowrap><%=sLivePrc%>%</td>
            <td class="DataTable2" id="cellLvRet" nowrap><%=sLiveRet%></td>
            <td class="DataTable2" id="cellLvCost" nowrap><%=sLiveCost%></td>
            <td class="DataTable2" id="cellLvUnit" nowrap><%=sLiveUnit%></td>

            <td id="cellNLv11" class="DataTable2" nowrap><%=sNotTurn%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sNotTurnPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompNoStk%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompNoStkPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompAll%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompAllPrc%>%</td>
            <th class="DataTable">&nbsp;</th>

            <td class="DataTable2" nowrap><%=sIncomHasStk%></td>
            <td id="cellWStk01" class="DataTable2" nowrap><%=sIncomHasStkPrc%>%</td>
            <td class="DataTable2" nowrap><%=sNRDue30Days%></td>
            <td class="DataTable2" nowrap><%=sNRDue60Days%></td>
            <td class="DataTable2" nowrap><%=sNRDue90Days%></td>

            <td  class="DataTable2" id="cellInRet" nowrap><%=sIncomRet%></td>
            <td  class="DataTable2" id="cellInCost" nowrap><%=sIncomCost%></td>
            <td  class="DataTable2" id="cellInUnit" nowrap><%=sIncomUnit%></td>
            <td id="cellWoStk01" class="DataTable2" nowrap><%=sIncomNoStk%></td>
            <td id="cellWoStk01" class="DataTable2" nowrap><%=sIncomNoStkPrc%>%</td>
            <td id="cellIncTot01"  class="DataTable2" nowrap><%=sIncom%></td>
            <td id="cellIncTot01"  class="DataTable2" nowrap><%=sIncomPrc%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td id="cellDesc" class="DataTable2" nowrap><%=sDesc%></td>
            <td id="cellFeat" class="DataTable2" nowrap><%=sFeature%></td>
            <td id="cellPhoto" class="DataTable2" nowrap><%=sPhoto%></td>
            <td id="cellCateg" class="DataTable2" nowrap><%=sCateg%></td>
            <td id="cellOpt" class="DataTable2" nowrap><%=sOption%></td>
            <th class="DataTable" id="thBlank">&nbsp;</th>

            <td id="cellTot01" class="DataTable2" nowrap><%=sGrpTotWs%></td>
            <td id="cellTot01" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellTot01" class="DataTable2" nowrap><%=sGrpPrc%>%</td>

            <th class="DataTable">&nbsp;</th>

            <td id="cellItNotAtr01" class="DataTable2" nowrap><%=sOnhand01%></td>
            <td class="DataTable2" id="tdOnh70" nowrap><%=sOnhand70%></td>
            <td class="DataTable2" nowrap><%=sNADue30Days%></td>
            <td class="DataTable2" nowrap><%=sNADue60Days%></td>
            <td class="DataTable2" nowrap><%=sNADue90Days%></td>
            <%if(sColGrp.equals("ITEM")){%><td class="DataTable2" nowrap>&nbsp;</td><%}%>

            <td class="DataTable2" nowrap><%=sWk1Attr%></td>
         </tr>
    <%}%>
         <!-- -------------------------- Total ------------------------------- -->
       <%
          prodlst.setTotal(0);
          String sGrp = prodlst.getGrp();
          String sGrpName = prodlst.getGrpName();
          String sGrpTotWs = prodlst.getGrpTotWs();
          String sGrpTotOs = prodlst.getGrpTotOs();
          String sGrpTot = prodlst.getGrpTot();
          String sGrpVol = prodlst.getGrpVol();
          String sDesc = prodlst.getDesc();
          String sFeature = prodlst.getFeature();
          String sPhoto = prodlst.getPhoto();
          String sCateg = prodlst.getCateg();
          String sOption = prodlst.getOption();
          String sGrpPrc = prodlst.getGrpPrc();
          String sOnhand = prodlst.getOnhand();

          String sLive = prodlst.getLive();
          String sLivePrc = prodlst.getLivePrc();

          String sCompNoStk = prodlst.getCompNoStk();
          String sCompNoStkPrc = prodlst.getCompNoStkPrc();
          String sNotTurn = prodlst.getNotTurn();
          String sNotTurnPrc = prodlst.getNotTurnPrc();
          String sCompAll = prodlst.getCompAll();
          String sCompAllPrc = prodlst.getCompAllPrc();

          String sIncomHasStk = prodlst.getIncomHasStk();
          String sIncomHasStkPrc = prodlst.getIncomHasStkPrc();
          String sIncomNoStk = prodlst.getIncomNoStk();
          String sIncomNoStkPrc = prodlst.getIncomNoStkPrc();
          String sIncom = prodlst.getIncom();
          String sIncomPrc = prodlst.getIncomPrc();
          String sLiveRet = prodlst.getLiveRet();
          String sLiveCost = prodlst.getLiveCost();
          String sLiveUnit = prodlst.getLiveUnit();
          String sIncomRet = prodlst.getIncomRet();
          String sIncomCost = prodlst.getIncomCost();
          String sIncomUnit = prodlst.getIncomUnit();

          String sGrpTotUna = prodlst.getGrpTotUna();
          String sOnhand70 = prodlst.getOnhand70();
          String sBsr70 = prodlst.getBsr70();
          String sOnhand01 = prodlst.getOnhand01();
          String sNADue30Days = prodlst.getNADue30Days();
          String sNADue60Days = prodlst.getNADue60Days();
          String sNADue90Days = prodlst.getNADue90Days();
          String sNRDue30Days = prodlst.getNRDue30Days();
          String sNRDue60Days = prodlst.getNRDue60Days();
          String sNRDue90Days = prodlst.getNRDue90Days();
          String sWk1Attr = prodlst.getWk1Attr();
          String sWk2Attr = prodlst.getWk2Attr();
          String sWk3Attr = prodlst.getWk3Attr();
          String sWk4Attr = prodlst.getWk4Attr();
       %>
       <tr id="trProd" class="DataTable1">
            <td  class="DataTable1" id="tdGrp" colspan=2 nowrap >Total</td>
            <th class="DataTable" id="tdGrpNm">&nbsp;</th>
            <th class="DataTable">&nbsp;</th>

            <td id="cellLv11" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellLv11" class="DataTable2" nowrap><%=sLivePrc%>%</td>
            <td class="DataTable2" id="cellLvRet" nowrap><%=sLiveRet%></td>
            <td class="DataTable2" id="cellLvCost" nowrap><%=sLiveCost%></td>
            <td class="DataTable2" id="cellLvUnit" nowrap><%=sLiveUnit%></td>

            <td id="cellNLv11" class="DataTable2" nowrap><%=sNotTurn%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sNotTurnPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompNoStk%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompNoStkPrc%>%</td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompAll%></td>
            <td id="cellNLv11" class="DataTable2" nowrap><%=sCompAllPrc%>%</td>
            <th class="DataTable">&nbsp;</th>

            <td class="DataTable2" nowrap><%=sIncomHasStk%></td>
            <td id="cellWStk01" class="DataTable2" nowrap><%=sIncomHasStkPrc%>%</td>
            <td class="DataTable2" nowrap><%=sNRDue30Days%></td>
            <td class="DataTable2" nowrap><%=sNRDue60Days%></td>
            <td class="DataTable2" nowrap><%=sNRDue90Days%></td>

            <td  class="DataTable2" id="cellInRet" nowrap><%=sIncomRet%></td>
            <td  class="DataTable2" id="cellInCost" nowrap><%=sIncomCost%></td>
            <td  class="DataTable2" id="cellInUnit" nowrap><%=sIncomUnit%></td>
            <td id="cellWoStk01" class="DataTable2" nowrap><%=sIncomNoStk%></td>
            <td id="cellWoStk01" class="DataTable2" nowrap><%=sIncomNoStkPrc%>%</td>
            <td id="cellIncTot01" class="DataTable2" nowrap><%=sIncom%></td>
            <td id="cellIncTot01" class="DataTable2" nowrap><%=sIncomPrc%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td id="cellDesc" class="DataTable2" nowrap><%=sDesc%></td>
            <td id="cellFeat" class="DataTable2" nowrap><%=sFeature%></td>
            <td id="cellPhoto" class="DataTable2" nowrap><%=sPhoto%></td>
            <td id="cellCateg" class="DataTable2" nowrap><%=sCateg%></td>
            <td id="cellOpt" class="DataTable2" nowrap><%=sOption%></td>
            <th class="DataTable" id="thBlank">&nbsp;</th>

            <td id="cellTot01" class="DataTable2" nowrap><%=sGrpTotWs%></td>
            <td id="cellTot01" class="DataTable2" nowrap><%=sLive%></td>
            <td id="cellTot01" class="DataTable2" nowrap><%=sGrpPrc%>%</td>

            <th class="DataTable">&nbsp;</th>

            <td id="cellItNotAtr01" class="DataTable2" nowrap><%=sOnhand01%></td>
            <td class="DataTable2" id="tdOnh70" nowrap><%=sOnhand70%></td>
            <td class="DataTable2" nowrap><%=sNADue30Days%></td>
            <td class="DataTable2" nowrap><%=sNADue60Days%></td>
            <td class="DataTable2" nowrap><%=sNADue90Days%></td>

            <%if(sColGrp.equals("ITEM")){%><td class="DataTable2" nowrap>&nbsp;</td><%}%>

            <td class="DataTable2" nowrap><%=sWk1Attr%></td>
         </tr>
     </table>
<!-- ======================================================================= -->
     <p style="text-align:left; font-size: 12px">
     <font color="red">Notes:</font>
     <br> &nbsp;&nbsp;&nbsp; <span style="font-size:8px; vertical-align:top;">(1)</span><font color="darkblue">Live</font> = Item is complete and has stock
     <br> &nbsp;&nbsp;&nbsp; <span style="font-size:8px; vertical-align:top;">(2)</span><font color="darkblue">Incomplete</font> = one or more attributes is incomplete
     <br> &nbsp;&nbsp;&nbsp; <span style="font-size:8px; vertical-align:top;">(3)</span><font color="darkblue">With Stock</font> = At least 1 child SKU has a stock.
     <br> &nbsp;&nbsp;&nbsp; <font color="darkblue">%'s</font> are based on #of items per Volusion.
     <br> &nbsp;&nbsp;&nbsp; Number of items are based on parent SKUs(Style)

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   prodlst.disconnect();
   prodlst = null;
   }
%>