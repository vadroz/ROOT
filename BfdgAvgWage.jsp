<%@ page import="payrollreports.BfdgAvgWage, java.util.*, java.sql.*"%>
<%
   java.util.Date dStart = new java.util.Date();

   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sSelBdgGrp = request.getParameter("BdgGrp");
   String [] sSelStr = request.getParameterValues("Str");
   String sOver = request.getParameter("Over");
   String sUnder = request.getParameter("Under");

   if(sSelBdgGrp == null){ sSelBdgGrp = "ALL"; }
   if(sOver == null){ sOver = "10"; }
   if(sUnder == null){ sUnder = "10"; }

String sAppl = "PRHIST";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgAvgWage.jsp&APPL=" + sAppl);
}
else
{
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sYear + "|" + sMonth + "|" + sSelStr + "|" + sSelBdgGrp + "|" + sUser);
    BfdgAvgWage bgavgwage = new BfdgAvgWage(sYear, sMonth, sSelStr, sSelBdgGrp, sUser);

    int iNumOfStr = bgavgwage.getNumOfStr();
    String [] sStr = bgavgwage.getStr();

    int iNumOfWk = bgavgwage.getNumOfWk();
    String [] sWeek = bgavgwage.getWeek();

    int iNumOfBdg = bgavgwage.getNumOfBdg();
    String [] sBdgGrp = bgavgwage.getBdgGrp();
    String [] sBdgGrpName = bgavgwage.getBdgGrpName();
    String [] sBdgGrpType = bgavgwage.getBdgGrpType();
    String [] sBdgGrpSecTy = bgavgwage.getBdgGrpSecTy();

    int iNumOfSub = bgavgwage.getNumOfSub();
    String [] sSubGrp = bgavgwage.getSubGrp();
    String [] sSubGrpNm = bgavgwage.getSubGrpNm();
    String sSubGrpNmJsa = bgavgwage.getSubGrpNmJsa();

    String sStrJsa = bgavgwage.getStrJsa();
    String sWeekJsa = bgavgwage.getWeekJsa();
    String sBdgGrpJsa = bgavgwage.getBdgGrpJsa();
    String sBdgGrpNameJsa = bgavgwage.getBdgGrpNameJsa();
    String sSubGrpJsa = bgavgwage.getSubGrpJsa();

    int iOver = Integer.parseInt(sOver.trim());
    int iUnder = Integer.parseInt(sUnder.trim()) * -1;
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: #EfEf9f; font-size:10px }

        tr.DataTable1TY { display:none; background: #EfEf9f; font-size:10px }
        tr.DataTable1LY { display:none; background: #EfEf9f; font-size:10px }
        tr.DataTable1LLY { display:none; background: #EfEf9f; font-size:10px }

        tr.DataTable2 { background: cornsilk; font-size:12px }
        tr.DataTable3 { background: #cccfff; font-size:10px }
        tr.DataTable4 { background: #E7E7E7; font-size:10px }
        tr.DataTable5 { background: cornsilk; font-size:10px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        .SmallP {background: pink; margin-top:3px;  font-size:10px }
        .SmallG {background: gold; margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        input.Small1 {border:none; background: #EfEf9f; font-size:10px }
        input.Small1P {background: pink; border:none; font-size:10px }
        input.Small1G {background: gold; border:none; font-size:10px }

        div.dvConfirm { position:absolute;  background-attachment: scroll;
              border: MidnightBlue solid 2px; width:150; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; visibility:hidden;}

        div.dvTools { position:absolute; top: expression(this.offsetParent.scrollTop + 10);
               left: expression(this.offsetParent.scrollLeft + 450);
               background-attachment: scroll; border: MidnightBlue solid 2px; width:150;
               background-color:LemonChiffon; z-index:10; text-align:center; font-size:10px}


        tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; }

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
        td.Prompt4 {background: #e7e7e7; text-align:center; vertical-align:top; border-left: darkblue 3px ridge; font-size:10px;}
        td.Prompt5 {background: #ccffcc; text-align:center; vertical-align:top; border-left: darkblue 3px ridge; font-size:10px;}

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script language="javascript">
var StartDate = new Date(<%=dStart.getTime()%>);

NumOfStr = <%=iNumOfStr%>;
NumOfBdg = <%=iNumOfBdg%>;
NumOfWk = <%=iNumOfWk%>;
NumOfSub = <%=iNumOfSub-1%>;

SubGrpNm = [<%=sSubGrpNmJsa%>];

var StrArr = [<%=sStrJsa%>];
var WeekArr = [<%=sWeekJsa%>];
var BdgGrpArr = [<%=sBdgGrpJsa%>];
var BdgGrpNameArr = [<%=sBdgGrpNameJsa%>];
var SubGrpArr = [<%=sSubGrpJsa%>];

var AvgArr = new Array(NumOfStr);
var StrTotArr = new Array(NumOfStr);
var StrSubMaxArr = new Array(NumOfWk);

var SbmNext = -1;
var iUrl = 0;
var urlarr = new Array();
var DisabledLink = false;

//==============================================================================
// iniitalize at loading
//==============================================================================
function bodyLoad()
{
   setToolBox();
   setBoxclasses(["BoxName",  "BoxClose"], ["dvConfirm"]);

   var elapse = (new Date()).getTime() - StartDate
}
//==============================================================================
// set tool and link box
//==============================================================================
function setToolBox()
{
   var hdr = "Tool Box";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "</td></tr>"
    + "<tr><td class='Prompt'>"
        + popToolsPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvTools.innerHTML = html;
   //document.all.dvTools.style.pixelLeft= document.documentElement.scrollLeft + 450;
   //document.all.dvTools.style.pixelTop= document.documentElement.scrollTop + 10;

   for(var i=0; i < NumOfBdg; i++)
   {
       document.all.SelBdgGrp.options[i] = new Option(BdgGrpNameArr[i], BdgGrpArr[i])
   }
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popToolsPanel()
{
  var panel = "<table border=0 width='100%' cellPadding='1' cellSpacing='0'>"
  panel += "<tr>"
             + "<td class='Prompt' nowrap>"
               + "<a class='Small' id='lnkTool' href='javascript: if(!DisabledLink) { copyLY(&#34;ALL&#34;) }'>Copy LY Averages</a> &nbsp; "
               + "<br><a class='Small' id='lnkTool' href='javascript: if(!DisabledLink) { calcLY(&#34;ALL&#34;) }'>Calc Commission Based on LY</a>"
             + "</td>"

             + "<td class='Prompt4' rowspan='5' nowrap>"
             + "<button class='Small' onclick='window.scrollTo(document.documentElement.scrollLeft, 0);'>Top</button><br>"
             + "Skip to store:<br>"
  for(var i=0; i < NumOfStr; i++)
  {
      panel += "<button class='Small' onclick='scrollToObject(&#34;trStr" + StrArr[i] + "&#34;, false)'>" + StrArr[i] + "</button>"
      if(i > 0 && i % 10 == 0){ panel += "<br>"; }
  }

  panel += "</td>"
  panel += "<td class='Prompt4' rowspan='5' nowrap>"
             + "<button class='Small' onclick='window.scrollTo(0, document.documentElement.scrollTop);'>Left</button><br>"
             + "Skip to budget group:<br>"
  panel += "<select class='Small' name='SelBdgGrp' onchange='getSelBdg(this)'></select>"

  panel += "</td>"

  panel += "<td class='Prompt5' rowspan='5' nowrap>"
             + "Allowed Variance:<br>"
             + "Over: <input class='Small' name='Over' size=2 maxlength=2 value='<%=sOver%>'> &nbsp; &nbsp; &nbsp;"
             + "Under: <input class='Small' name='Under' size=2 maxlength=2 value='<%=sUnder%>'><br>"
             + "<button class='Small' onclick='validateOverUnder()'>Submit</button><br>"
             + "Note:<br>Changes will be discarded."
  panel += "</td>"


         + "</tr>"

         + "<tr><td class='Prompt' nowrap>"
             + "Apply Percent: <input class='Small' name='inpApplyPrc' size=3 maxlength=3>%&nbsp;"
             + "<a class='Small' id='lnkTool' href='javascript: if(!DisabledLink) { applyAvg(true); }'>Calculate</a></td>"
         + "</tr>"

         + "<tr><td class='Prompt' nowrap>"
             + "Apply Amount: $<input class='Small' name='inpApplyAmt' size=3 maxlength=3>&nbsp;"
             + "<a class='Small' id='lnkTool' href='javascript: if(!DisabledLink) { applyAvg(false); }'>Calculate</a></td>"
         + "</tr>"

         + "<tr><td class='Prompt' nowrap>"
             + "<a class='Small' id='lnkTool' href='javascript: if(!DisabledLink) { zeroOut(&#34;ALL&#34;); }'>Apply 0 to ALL</a></td>"
         + "</tr>"

         + "<tr>"
           + "<td class='Prompt' nowrap>"
             + "<a class='Small' id='lnkTool' href='javascript: if(!DisabledLink) { saveChg(); }'>Save</a> &nbsp; "
             + "<a class='Small' id='lnkTool' href='javascript: if(!DisabledLink) { printpr(); }'>Print</a>"
             + "<br>History: <input type='checkbox' name='Hist' class='Small' onclick='showHist(this, 0)'>TY&nbsp;"
             + "<input name='Hist' type='checkbox' class='Small' onclick='showHist(this, 1)'>LY &nbsp;"
             + "<input name='Hist' type='checkbox' class='Small' onclick='showHist(this, 2)'>LLY"
           + "</td>"
         + "</tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// show/hide History rows
//==============================================================================
function showHist(chkbox, iLine)
{
   var disp = "none";
   if(chkbox.checked){ disp = "block"; }

   document.styleSheets[0].rules[10 + iLine].style.display=disp;

   //var histnm = "trHist" + iLine;
   //var hist = document.all[histnm];
   //for(var i=0; i < hist.length; i++)
   //{
   //   hist[i].style.display = disp;
   //}
}
//==============================================================================
// get selected budget group name
//==============================================================================
function selBdgGrpCol()
{
   var sel = document.all.SelBdgGrp;
   var grp = sel.options[sel.selectedIndex].value;
   for(var i=0; i < NumOfStr ; i++)
   {
       cell = "thBdg" + grp + "S" + i
       var obj = document.all[cell];
       obj.style.background="gold";
       //obj.select();
   }
}
//==============================================================================
// get selected budget group name
//==============================================================================
function getSelBdg(sel)
{
   var grp = sel.options[sel.selectedIndex].value;
   scrollToObject("thBdg" + grp + "S0", true);
}
//==============================================================================
// copy LY processed payroll averages to selected month
//==============================================================================
function copyLY(grp)
{
   var hdr = "Apply LY Averages"
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top nowrap>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hideConfirm();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2 nowrap>" + popCopyLyPanel(grp)

     + "</td></tr>"
   + "</table>"

   document.all.dvConfirm.innerHTML = html;
   document.all.dvConfirm.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvConfirm.style.pixelTop= document.documentElement.scrollTop + 200;
   document.all.dvConfirm.style.visibility = "visible";

   document.all.Action.value= "COPY_LY";

   document.all.Apply.value= "0";
}
//==============================================================================
// populate Copy LY panel
//==============================================================================
function popCopyLyPanel(grp)
{
   panel = "<table>"

   if(grp != "ALL" && StrArr.length > 1)
   {
     panel += "<tr><td class='Prompt' >From Store:</td></tr>"

     panel += "<tr>"
            + "<td class='Prompt' >"
     for(var i=0; i < StrArr.length; i++)
     {
        panel += "<input name='selFrStr' type='radio' value='" + StrArr[i] + "'"
        if(grp == StrArr[i]){ panel += " checked"}
        panel += "> &nbsp; " + StrArr[i];
     }
     panel += "</td></tr>"

   }

   // Bugdet group selection
   panel += "<tr><td class='Prompt'>"
     + "<a class='small' href='javascript: setCopyBdgGrp(true)'>All Budget Group</a>"
     + " &nbsp; &nbsp; "
     + "<a class='small' href='javascript: setCopyBdgGrp(false)'>Clear</a>"
     + "<div style='border:gray 1px solid; background-color:khaki;'>"

   for(var i=0; i < NumOfBdg; i++)
   {
      panel += "<br><input type='checkbox' name='cbBdgGrp' value='" + BdgGrpArr[i] + "'>" + BdgGrpNameArr[i]
   }
   panel += "</div></td>"

   // Bugdet subgroup selection
   panel += "<td class='Prompt' nowrap>"
     + "<a class='small' href='javascript: setCopySubGrp(true)'>All Budget Subgroup</a>"
     + " &nbsp; &nbsp; "
     + "<a class='small' href='javascript: setCopySubGrp(false)'>Clear</a>"
     + "<div style='border:gray 1px solid; background-color:khaki;'>"

   for(var i=0; i < NumOfSub; i++)
   {
      panel += "<br><input type='checkbox' name='cbSubGrp' value='" + SubGrpArr[i] + "'>" + SubGrpArr[i]
   }
   panel += "</div></td>"
   panel += "</div></td></tr>"

   // command buttons
   panel += "<tr><td class='Prompt' nowrap>Are you sure you want to apply LY averages?</td></tr>"
   panel += "<tr><td class='Prompt'>&nbsp;  &nbsp; &nbsp; <button class='Small' onClick='validateCopyLY(&#34;" + grp + "&#34;);'>Submit</button> &nbsp;  &nbsp; &nbsp; "
       + "<button class='Small' onClick='hideConfirm();'>Cancel</button></td><tr>"
       + "</table>";
   return panel;
}
//==============================================================================
// check/clear budget group when copy LY
//==============================================================================
function setCopyBdgGrp(mark)
{
   var grp = document.all.cbBdgGrp;
   for(var i=0; i < NumOfBdg;i++) { grp[i].checked = mark; }
}
//==============================================================================
// check/clear budget group when copy LY
//==============================================================================
function setCopySubGrp(mark)
{
   var grp = document.all.cbSubGrp;
   for(var i=0; i < NumOfSub;i++) { grp[i].checked = mark; }
}
//==============================================================================
// submit Copy from LY average wages
//==============================================================================
function validateCopyLY(str)
{
   var error =false;
   var msg = "";

   var grp = document.all.cbBdgGrp;
   var agrp = new Array();
   var bgrp = false;
   for(var i=0; i < NumOfBdg;i++)
   {
     if(grp[i].checked){ agrp[agrp.length] = grp[i].value; bgrp = true;}
   }
   if(!bgrp){ error = true; msg += "\nPlease select at least 1 Budget Group."; }

   var sub = document.all.cbSubGrp;
   var asub = new Array();
   var bsub = false;
   for(var i=0; i < NumOfSub;i++)
   {
     if(sub[i].checked){ asub[asub.length] = sub[i].value; bsub = true;}
   }
   if(!bsub){ error = true; msg += "\nPlease select at least 1 Budget Subgroup."; }

   if (error) {alert(msg); }
   else { sbmCopyLY(str, agrp, asub) }
}
//==============================================================================
// submit Copy from LY average wages
//==============================================================================
function sbmCopyLY(str, agrp, asub)
{
   // activate store store
   for(var i=0; i < StrArr.length; i++)
   {
      if(str != "ALL" && StrArr.length > 1 && !document.all.selFrStr[i].checked)
      {
         if(StrArr.length > 1) {document.all.ActStr[i].disabled = true;}
         else { document.all.ActStr.disabled = true; }
      }
   }

   // activate/disable budget groups
   for(var i=0; i < NumOfBdg; i++)
   {
      var found = false;
      for(var m=0; m < agrp.length; m++)
      {
          if(BdgGrpArr[i] == agrp[m]) { found = true; break;}
      }
      if(!found){document.all.ActBdg[i].disabled = true;}
   }


   // activate/disable budget subgroups
   for(var i=0; i < NumOfSub; i++)
   {
      var found = false;
      for(var m=0; m < asub.length; m++)
      {
         if(SubGrpArr[i] == asub[m]){ found = true; break;}
      }
      if(!found){ document.all.ActSub[i].disabled = true; }
   }

   html = document.forms[0].outerHTML;

   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"
   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   //alert(html)
   window.frame1.document.frmCalc.submit();
}
//==============================================================================
// calculate Commissions based on LY processed payroll and selected month week
//==============================================================================
function calcLY(grp)
{
   var hdr = "Calculate Commissions Based on LY"
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top nowrap>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hideConfirm();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2 nowrap>" + popCalcLyPanel(grp)

     + "</td></tr>"
   + "</table>"

   document.all.dvConfirm.innerHTML = html;
   document.all.dvConfirm.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvConfirm.style.pixelTop= document.documentElement.scrollTop + 200;
   document.all.dvConfirm.style.visibility = "visible";

   document.all.Action.value= "COPY_LY_CLC";

   document.all.Apply.value= "0";
}
//==============================================================================
// populate Copy LY panel
//==============================================================================
function popCalcLyPanel(grp)
{
   panel = "<table>"

   if(grp != "ALL" && StrArr.length > 1)
   {
     panel += "<tr><td class='Prompt' >From Store:</td></tr>"

     panel += "<tr>"
            + "<td class='Prompt' >"
     for(var i=0; i < StrArr.length; i++)
     {
        panel += "<input name='selFrStr' type='radio' value='" + StrArr[i] + "'"
        if(grp == StrArr[i]){ panel += " checked"}
        panel += "> &nbsp; " + StrArr[i];
     }
     panel += "</td></tr>"
   }


   // command buttons
   panel += "<tr><td class='Prompt' nowrap>Are you sure you want to change averge commission rate?</td></tr>"
   panel += "<tr><td class='Prompt'>&nbsp;  &nbsp; &nbsp; <button class='Small' onClick='validateCalcLY(&#34;" + grp + "&#34;);'>Submit</button> &nbsp;  &nbsp; &nbsp; "
       + "<button class='Small' onClick='hideConfirm();'>Cancel</button></td><tr>"
       + "</table>";
   return panel;
}
//==============================================================================
// submit Copy from LY average wages
//==============================================================================
function validateCalcLY(str)
{
   var error =false;
   var msg = "";

   if (error) {alert(msg); }
   else { sbmCalcLY(str) }
}
//==============================================================================
// submit Copy from LY average wages
//==============================================================================
function sbmCalcLY(str)
{
   // activate store store
   for(var i=0; i < StrArr.length; i++)
   {
      if(str != "ALL" && StrArr.length > 1 && !document.all.selFrStr[i].checked)
      {
         if(StrArr.length > 1) {document.all.ActStr[i].disabled = true;}
         else { document.all.ActStr.disabled = true; }
      }
   }

   html = document.forms[0].outerHTML;

   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"
   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   //alert(html)
   window.frame1.document.frmCalc.submit();
}

//==============================================================================
// reset averages
//==============================================================================
function zeroOut(type)
{
   document.all.Action.value= "ZEROOUT";
   document.all.Apply.value= "0";

   confirm("Apply 0 to All", "Are you sure you want zeroout all?")
}
//==============================================================================
// apply percent of changing of averages wages
//==============================================================================
function applyAvg(bPrc)
{
   var apply = 1;
   var hdr = null;
   var quest = null;

   if(bPrc)
   {
      apply = eval(document.all.inpApplyPrc.value.trim());
      apply = (1 + apply / 100).toFixed(2);
      hdr = "Apply Percent";
      quest = "Are you sure you want apply percent?";
      document.all.Action.value= "APPLY_PERCENT";
   }
   else
   {
      apply = eval(document.all.inpApplyAmt.value.trim());
      hdr = "Apply Amount";
      quest = "Are you sure you want apply amount?";
      document.all.Action.value= "APPLY_AMOUNT";
   }

   document.all.Apply.value= apply;
   confirm(hdr, quest);
}
//==============================================================================
// save made changes to AS/400 database
//==============================================================================
function saveChg()
{
   document.all.Action.value= "SAVE";
   document.all.Apply.value= "0";
   confirm("Save", "Are you sure you want save changes?")
}
//==============================================================================
// save made changes to AS/400 database
//==============================================================================
function validateOverUnder()
{
   var error =false;
   var msg = "";

   var over = document.all.Over.value.trim();
   if(isNaN(over)){ error = true; msg += "Value of Over variance is not numeric"; }

   var under = document.all.Under.value.trim();
   if(isNaN(under)){ error = true; msg += "Value of Under variance is not numeric"; }

   if (error) {alert(msg); }
   else { sbmOverUnder(over, under) }
}
//==============================================================================
// save made changes to AS/400 database
//==============================================================================
function sbmOverUnder(over, under)
{
   var url = "BfdgAvgWage.jsp?"
     + "Year=<%=sYear%>"
     + "&Month=<%=sMonth%>"
     + "&BdgGrp=<%=sSelBdgGrp%>"

   for(var i=0; i < NumOfStr; i++) { url += "&Str=" + StrArr[i]; }

   url += "&Over=" + over
        + "&Under=" + under

   //alert(url);
   window.location.href = url;
}
//==============================================================================
// copy LY processed payroll averages to selected month
//==============================================================================
function confirm(hdr, quest)
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top nowrap>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hideConfirm();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2 nowrap>" + quest
       + "<br> &nbsp;  &nbsp; &nbsp; <button class='Small' onClick='sbmCalc();'>Submit</button> &nbsp;  &nbsp; &nbsp; "
       + "<button class='Small' onClick='hideConfirm();'>Cancel</button>"
     + "</td></tr>"
   + "</table>"

   document.all.dvConfirm.innerHTML = html;
   document.all.dvConfirm.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvConfirm.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvConfirm.style.visibility = "visible";
}

//==============================================================================
// hide dvConfirm panel
//==============================================================================
function hideConfirm()
{
   document.all.dvConfirm.innerHTML = " ";
   document.all.dvConfirm.style.visibility = "hidden";
}
//==============================================================================
// submit calculation
//==============================================================================
function sbmCalc()
{
   html = document.forms[0].outerHTML;
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"
   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   //alert(html)
   window.frame1.document.frmCalc.submit();
}

//==============================================================================
// disable / enable tools
//==============================================================================
function disableTootls(bActivity)
{
   for(var i=0; i < document.all.lnkTool.length ;i++)
   {
      document.all.lnkTool[i].disabled = bActivity;
   }
}
//==============================================================================
// submit budget averages for savings
//==============================================================================
function sbmBdgAvg()
{
   SbmNext++
   if(SbmNext < iUrl)
   {
      window.frame1.location.href=urlarr[SbmNext];
   }
   else
   {
      disableTootls(false);
      DisabledLink = false;
      window.location.reload();
   }
}
//==============================================================================
// scroll to Item picture
//==============================================================================
function scrollToObject(name, toX)
{
   var curLeft = document.documentElement.scrollLeft
   var curTop = document.documentElement.scrollTop;
   var obj = document.all[name];
   var pos = getObjPosition(obj);
   if (toX) { window.scrollTo(pos[0]-25, curTop); }
   else { window.scrollTo(curLeft, pos[1] - 110); }
}

//==============================================================================
// print
//==============================================================================
function printpr()
{
   var OLECMDID = 6;
   /* OLECMDID values:
    * 6 - print
    * 7 - print preview
    * 1 - open window
    * 4 - Save As
    */

   var PROMPT = 1; // 2 DONTPROMPTUSER
   var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
   document.body.insertAdjacentHTML("beforeEnd", WebBrowser);

   WebBrowser1.ExecWB(OLECMDID, PROMPT);
   WebBrowser1.outerHTML = "";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvConfirm" class="dvConfirm"></div>
<div id="dvTools" class="dvTools"></div>
<div id="dvTest" class="dvConfirm"></div>

<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
       <td ALIGN="left" VALIGN="TOP" width="10%">
         <b>Retail Concepts Inc.
         <br>Payroll: Budget group average wages break-up by subcategories
         <br>Year/Month: <%=sYear%>/<%=sMonth%></b>
         <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
           <a href="BfdgAvgWageSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
         <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
       </td>
     </tr>

     <tr bgColor="ivory">
       <td ALIGN="left" VALIGN="TOP"><br>
<!-------------------------------------------------------------------->
      <form method="post" action="BfdgAvgWageCalc.jsp" name="frmCalc">
       <input type="hidden" name="Year" value="<%=sYear%>">
       <input type="hidden" name="Month" value="<%=sMonth%>">
       <input type="hidden" name="BdgGrp" value="<%=sSelBdgGrp%>">

       <%for(int i=0; i < iNumOfStr; i++){%><input type="hidden" name="Str" value="<%=sStr[i]%>"> <%}%>
       <%for(int i=0; i < iNumOfBdg; i++){%><input type="hidden" name="Bdg" value="<%=sBdgGrp[i]%>"> <%}%>
       <%for(int i=0; i < iNumOfSub; i++){%><input type="hidden" name="Sub" value="<%=sSubGrp[i]%>"> <%}%>
       <%for(int i=0; i < iNumOfWk; i++){%><input type="hidden" name="Week" value="<%=sWeek[i]%>"> <%}%>

       <%for(int i=0; i < iNumOfStr; i++){%><input type="hidden" name="ActStr" value="<%=sStr[i]%>"> <%}%>
       <%for(int i=0; i < iNumOfBdg; i++){%><input type="hidden" name="ActBdg" value="<%=sBdgGrp[i]%>"> <%}%>
       <%for(int i=0; i < iNumOfSub; i++){%><input type="hidden" name="ActSub" value="<%=sSubGrp[i]%>"> <%}%>
       <%for(int i=0; i < iNumOfWk; i++){%><input type="hidden" name="ActWeek" value="<%=sWeek[i]%>"> <%}%>

       <input type="hidden" name="FrStr">
       <input type="hidden" name="ToStr">

       <input type="hidden" name="Action">
       <input type="hidden" name="Apply">

       <br>
      <!----------------- beginning of table ------------------------>
      <table border=0 cellPadding="0" cellSpacing="0">
     <!------------------------------- Data Detail --------------------------------->
      <%for(int i=0; i < iNumOfStr; i++){%>
        <tr id="trStr<%=sStr[i]%>">
          <th align="left">&nbsp; <br><div style="border-bottom: 1px black solid; position:absolute; left: expression(this.offsetParent.scrollLeft);">Store: <%=sStr[i]%>
              &nbsp;  <a class="Small" href="javascript: if(!DisabledLink) { copyLY('<%=sStr[i]%>') }">Copy LY</a></td>
              </div><br>&nbsp;</th>
        </tr>

        <tr>
          <td>
           <table border=0 cellPadding="0" cellSpacing="0" width=100% id="tblBdgGrp">
            <tr>

             <%for(int j=0; j < iNumOfBdg; j++){%>
                 <th id="thBdg<%=sBdgGrp[j]%>S<%=i%>">Budget Group: <%=sBdgGrpName[j]%>
                        <table border=1 cellPadding="0" cellSpacing="0" width=100%>
                           <tr>
                             <th class="DataTable">Week</th>
                             <%for(int l=0; l < iNumOfSub; l++){%>
                                <th class="DataTable"><%=sSubGrpNm[l]%></th>
                             <%}%>
                             <th class="DataTable">Bdg<br>Avg</th>
                           </tr>

                           <!-- ============= Detail ======================= -->

                           <%for(int k=0; k < iNumOfWk; k++){%>
                           <%
                               bgavgwage.setAvgWage(i, k, j);
                               String [] sSubAvg = bgavgwage.getSubAvg();
                               String [] sSubTyPrcAvg = bgavgwage.getSubTyPrcAvg();
                               String [] sSubLyPrcAvg = bgavgwage.getSubLyPrcAvg();
                               String [] sSubLLyPrcAvg = bgavgwage.getSubLLyPrcAvg();
                               int [] iSubVar = bgavgwage.getSubVar();
                               int [] iSubTyVar = bgavgwage.getSubTyVar();
                               int [] iSubLyVar = bgavgwage.getSubLyVar();
                               int [] iSubLLyVar = bgavgwage.getSubLLyVar();
                               String sBdgGrpAvg = bgavgwage.getBdgGrpAvg();
                           %>

                             <tr class="DataTable">
                                <td class="DataTable"><%=sWeek[k]%></td>
                                <%for(int l=0; l < iNumOfSub; l++){%>
                                   <td class="DataTable" >
                                     <%if(!sSubGrp[l].equals("TOTAL")){%>
                                       <input name="AvgS<%=i%>B<%=j%>W<%=k%>G<%=l%>" size=5 maxlength=6 value="<%=sSubAvg[l]%>"
                                        class="Small<%if( iSubVar[l] > iOver){%>P<%} else if( iSubVar[l] < iUnder){%>G<% }%>">
                                     <%} else {%><div class="Small<%if( iSubVar[l] > iOver){%>P<%} else if( iSubVar[l] < iUnder){%>G<% }%>"><%=sSubAvg[l]%></div><%}%>
                                   </td>
                                <%}%>
                                <td class="DataTable"><%=sBdgGrpAvg%></td>
                             </tr>

                             <!-- TY Processed -->
                             <tr class="DataTable1TY" id="trHist0">
                                <td class="DataTable">TY</td>
                                <%for(int l=0; l < iNumOfSub; l++){%>
                                   <td class="DataTable"><input name="PPTyS<%=i%>B<%=j%>W<%=k%>G<%=l%>" value="<%=sSubTyPrcAvg[l]%>" size=5 maxlength=6
                                      class="Small1<%if( iSubTyVar[l] > iOver){%>P<%} else if( iSubTyVar[l] < iUnder){%>G<% }%>" readonly></td>
                                <%}%>
                                <td class="DataTable">&nbsp;</td>
                             </tr>

                             <!-- LY Processed -->
                             <tr class="DataTable1LY" id="trHist1">
                                <td class="DataTable">LY</td>
                                <%for(int l=0; l < iNumOfSub; l++){%>
                                   <td class="DataTable"><input name="PPLyS<%=i%>B<%=j%>W<%=k%>G<%=l%>" value="<%=sSubLyPrcAvg[l]%>" size=5 maxlength=6
                                     class="Small1<%if( iSubLyVar[l] > iOver){%>P<%} else if( iSubLyVar[l] < iUnder){%>G<%}%>" readonly></td>
                                <%}%>
                                <td class="DataTable">&nbsp;</td>
                             </tr>

                             <!-- LLY Processed -->
                             <tr class="DataTable1LLY" id="trHist2">
                                <td class="DataTable">LLY</td>
                                <%for(int l=0; l < iNumOfSub; l++){%>
                                   <td class="DataTable"><input name="PPLLyS<%=i%>B<%=j%>W<%=k%>G<%=l%>" value="<%=sSubLLyPrcAvg[l]%>" size=5 maxlength=6
                                     class="Small1<%if( iSubLLyVar[l] > iOver){%>P<%} else if( iSubLLyVar[l] < iUnder){%>G<% }%>" readonly></td>
                                <%}%>
                                <td class="DataTable">&nbsp;</td>
                             </tr>
                           <%}%>

                           <!-- ============= Monthly Total  =============== -->
                           <tr style="background:darkred; font-size:1px;"><td colspan=<%=iNumOfSub+2%>>&nbsp;</td></tr>
                           <tr class="DataTable2">
                             <%
                                bgavgwage.setMonAvgWage();
                                String [] sSubAvg = bgavgwage.getSubAvg();
                             %>
                                <td class="DataTable">Monthly Total</td>
                                <%for(int l=0; l < iNumOfSub; l++){%>
                                   <td class="DataTable" id="AvgS<%=i%>B<%=j%>MonTotG<%=l%>"><%=sSubAvg[l]%></td>
                                <%}%>
                                <td class="DataTable">&nbsp;</td>
                             </tr>
                           <!-- ====== End Detail ====== -->
                        </table>
                      </th>
                      <th nowrap> &nbsp; &nbsp; <th>
             <%}%>
            </tr>
           </table>
           <!-- -->
          </td>
        </tr>
      <%}%>
      <!------------------------ End Details ---------------------------------->
   </table>
   </form>
   </td>
   </tr>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%
  bgavgwage.disconnect();
  bgavgwage = null;
  }
%>
