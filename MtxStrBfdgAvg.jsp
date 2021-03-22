<%@ page import="payrollreports.MtxStrBfdgAvg, java.util.*, java.sql.*"%>
<%
String sInFrame = request.getParameter("InFrame");
if(sInFrame == null){sInFrame = "N";}

String sAppl = "PRHIST";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MtxStrMonBfdgAvg.jsp&APPL=" + sAppl);
}
else
{
    String sUser = session.getAttribute("USER").toString();

    MtxStrBfdgAvg bdgmtx = new MtxStrBfdgAvg();
    int iNumStr = bdgmtx.getNumStr();
    String [] sStr = bdgmtx.getStr();

    int iNumOfGrp = bdgmtx.getNumGrp();
    String [] sGrp = bdgmtx.getGrp();
    String [] sGrpNm = bdgmtx.getGrpNm();

    String sStrJsa = bdgmtx.getStrJsa();
    String sGrpJsa = bdgmtx.getGrpJsa();
    String sGrpNmJsa = bdgmtx.getGrpNmJsa();
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
        tr.DataTable2 { background: white; font-size:10px }
        tr.DataTable3 { background: #CCFFCC; font-size:10px }
        tr.DataTable4 { background: #CCCFFF; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}


        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvBdgAvg { position:absolute;  background-attachment: scroll;
              border: MidnightBlue solid 2px; width:150; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; visibility:hidden;}

        div.dvToolTip { position:absolute;  background-attachment: scroll;
              border: lightgray outset 1px; width:150; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; visibility:hidden;}

        div.dvMonSel { position:absolute;  background-attachment: scroll;
              border: lightgray outset 1px; width:160; background-color:LemonChiffon; z-index:10;
              text-align:left; font-size:11px;  visibility:hidden;}

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

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script language="javascript">
var Str = [<%=sStrJsa%>];
var Grp = [<%=sGrpJsa%>];
var GrpNm = [<%=sGrpNmJsa%>];
var Avg = new Array();
var Adj = new Array();
var SelStrArg = null;
var SelGrpArg = null;

var Mon = ["April", "May", "June", "July", "August", "September", "October", "November"
     , "December", "January", "February", "March"  ];

//==============================================================================
// iniitalize at loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvBdgAvg"]);
   <%if(!sInFrame.equals("Y")) {%>setMonSel();<%}%>
}
//==============================================================================
// set Month selection
//==============================================================================
function setMonSel()
{
   var dvmon = document.all.dvMonSel;

   var html="<u><b>Select Month for adjustments.</b></u>"
   for(var i=0; i < 12; i++)
   {
      html += "<br> &nbsp; &nbsp; &nbsp; &nbsp; <a href='MtxStrMonBfdgAvg.jsp?Mon=" + (i+1) + "'>" + Mon[i] + "</a>";
   }
   dvmon.innerHTML = html
   dvmon.style.pixelTop= 20;
   dvmon.style.visibility="visible";
}
//==============================================================================
// set new Average wages
//==============================================================================
function setNewAvg(args, type)
{

   var hdr = "Change Store " + Str[args] + " Budget Average Wages";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblHrsEarn'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2 id='dvHrsEarn'>"
          + "<div id='dvCals' style='overflow:auto;'>"
            + popAvgWage(args, type)
          + "</div>"
       + "</td></tr>"
     + "</table>"

   var objnm = "trAvg" + args;
   var obj = document.all[objnm];
   var vpos = getOffset(obj).top

   document.all.dvBdgAvg.innerHTML=html
   document.all.dvBdgAvg.style.pixelLeft = getOffset(obj).left - 50;
   document.all.dvBdgAvg.style.pixelTop= document.documentElement.scrollTop + 200;
   document.all.dvBdgAvg.style.visibility="visible"

   if(type=="AVG")
   {
     document.all.Avg[0].select();
     document.all.Avg[0].focus();
   }
   else
   {
     document.all.Adj.select();
     document.all.Adj.focus();
   }
}
//==============================================================================
// get Offset
//==============================================================================
function getOffset( el )
{
  var _x = 0;     var _y = 0;
  while( el && !isNaN( el.offsetLeft ) && !isNaN( el.offsetTop ) )
  { _x += el.offsetLeft - el.scrollLeft;
    _y += el.offsetTop - el.scrollTop;
    el = el.offsetParent;
  }
  return { top: _y, left: _x };
}
//==============================================================================
// set panel
//==============================================================================
function popAvgWage(args, type)
{
    SelStrArg = args;

    var panel = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
       + "<tr class='DataTable'>"
          + "<th class='DataTable' nowrap>Budget<br>Group</th>"
    for(var i=0; i < Grp.length; i++)
    {
       panel += "<th class='DataTable' nowrap>" + Grp[i] + "</th>"
    }
    panel += "</tr>"

    // apply adjustment % for all buckets
    if(type=="ADJ")
    {
       panel += "<tr class='DataTable1'>"
             + "<th class='DataTable' nowrap>Adj</th>"
       panel += "<td class='DataTable' colspan='" + Grp.length
             + "' nowrap><input class='Small' id='Adj' size=5 maxlength=5>%"
             + "</td>"
       panel += "</tr>"

       panel += "<tr class='DataTable1'>"
             + "<th class='DataTable' nowrap>Adj</th>"

       for(var i=0; i < Grp.length; i++)
       {
          panel += "<td class='DataTable' nowrap><input class='Small' id='AdjGrp' size=5 maxlength=5></td>"
       }
       panel += "</tr>"
    }

    panel += "<tr class='DataTable1'>"
             + "<th class='DataTable' nowrap>Avg</th>"

    for(var i=0; i < Grp.length; i++)
    {
       panel += "<td class='DataTable' nowrap><input class='Small' id='Avg' value='" + Avg[args][i] + "' size=5 maxlength=5></td>"
    }
    panel += "</tr>"



    panel += "<tr class='DataTable'>"
          + "<td class='DataTable' colspan=20>"
    if(type=="ADJ")
    {
      panel += "<button onClick='validCalcAvg();' class='Small'>Calculate</button> &nbsp; &nbsp;"
    }
    panel += "<button onClick='validAvg(&#34;" + Str[args] + "&#34;);' class='Small'>Change</button> &nbsp; &nbsp;"
             + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
             + "<button onClick='setNewAvg(&#34;" + args + "&#34;,&#34;" + type + "&#34;)' class='Small'>Reset</button>"
          + "</td>"
       + "</tr>"
     + "</table>"

    return panel;
}
//==============================================================================
// calculate new budget average wages
//==============================================================================
function validCalcAvg()
{
   var error= false;
   var msg = "";

   var adj = document.all.Adj.value.trim();
   if(adj !="" && isNaN(adj)){ error=true; msg += "\nAverage wage must be numeric value."; }

   var adjg = new Array();
   var adjobj = document.all.AdjGrp;
   var err1 = false
   for(var i=0; i < adjobj.length; i++)
   {
        adjg[i] = adjobj[i].value.trim();
        if(adjg[i] != "" && isNaN(adjg[i])){ err1 = true; }
   }
   if(err1){ error=true; msg += "\nAverage wage must be numeric value."; }

   if(error){alert(msg)}
   else{ calcNewAvg(adj, adjg)}
}
//==============================================================================
// calculate new averages
//==============================================================================
function calcNewAvg(adj, adjg)
{
   var avgobj = document.all.Avg;

   for(var i=0; i < avgobj.length; i++)
   {
      var avg = avgobj[i].value.trim();
      var newval = avg;

      // apply percent applying for all
      if(adj != ""){ newval = ((1 + eval(adj)/100) * eval(avg)).toFixed(2); }

      // apply individual percent
      if(adjg[i] != ""){ newval = ((1 + eval(adjg[i])/100) * eval(avg)).toFixed(2); }

      //save value in input fields
      avgobj[i].value = newval;

      document.all.AdjGrp[i].value = "";
   }

   document.all.Adj.value = "";
}
//==============================================================================
// validate new entries
//==============================================================================
function validAvg(str)
{
   var error= false;
   var msg = "";

   var avg = new Array();
   var avgobj = document.all.Avg;
   var avgerr = [false,false,false];

   for(var i=0; i < avgobj.length; i++)
   {
      avg[i] = avgobj[i].value.trim();
      avgobj[i].style.background="white";

      if(avg[i] == ""){ avgerr[0] = true; avgobj[i].style.background="pink"; }
      else if(isNaN(avg[i])){ avgerr[1] = true;  avgobj[i].style.background="pink";}
      else if(eval(avg[i]) < 0){ avgerr[2] = true;  avgobj[i].style.background="pink";}

   }

   if(avgerr[0]){ error=true; msg += "\nPlease, enter average wage value." }
   if(avgerr[1]){ error=true; msg += "\nAverage wage must be numeric value." }
   if(avgerr[2]){ error=true; msg += "\nAverage wage cannot be negative." }

   if(error){alert(msg)}
   else{ sbmAvg(str, avg)}
}
//==============================================================================
// submit new entries
//==============================================================================
function sbmAvg(str, avg)
{
   var url = "MtxBdgAvgSave.jsp?Str=" + str
   for(var i=0; i < avg.length; i++)
   {
      url += "&Avg=" + avg[i]
      url += "&Grp=" + Grp[i]
   }
   url += "&Action=UPD_STR_AVG"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// update selected store matrix
//==============================================================================
function updStrBdgAvg(str)
{
   for(var i=0; i < Grp.length; i++)
   {
      var cellnm = "tdAvgV" + SelStrArg + "_" + i;
      var oldval = document.all[cellnm].innerHTML;
      var newval = document.all.Avg[i].value.trim();
      if(oldval != newval)
      {
         document.all[cellnm].innerHTML = document.all.Avg[i].value;
         document.all[cellnm].style.background = "#ccffcc";
      }
   }
   hidePanel();
}

//==============================================================================
// set new averages by Budget Group for all stores
//==============================================================================
function setNewAvgByGrp(argb)
{
   var hdr = " &nbsp; Change " + GrpNm[argb] + " Average Wages for all stores &nbsp; ";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblHrsEarn'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2 id='dvHrsEarn'>"
          + "<div id='dvCals' style='overflow: AUTO; width: 100%; height: 500px; POSITION: relative;'>"
            + popNewAvgByGrp(argb)
          + "</div>"
       + "</td></tr>"
     + "</table>"

   document.all.dvBdgAvg.innerHTML=html
   document.all.dvBdgAvg.style.pixelLeft = document.documentElement.scrollLeft + 100;
   document.all.dvBdgAvg.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvBdgAvg.style.visibility="visible";

}
//==============================================================================
// set panel
//==============================================================================
function popNewAvgByGrp(argb)
{
    SelGrpArg = argb;

    var panel = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
       + "<tr class='DataTable' style='position: relative; top: expression(this.offsetParent.scrollTop-2);'>"
          + "<th class='DataTable' nowrap>Store</th>"
          + "<th class='DataTable' nowrap>" + GrpNm[argb]  + "<br>Average Wage</th>"
    panel += "</tr>"

    panel += "<tr class='DataTable' style='position: relative; top: expression(this.offsetParent.scrollTop-2);'>"
          + "<td class='DataTable' colspan=50>"
             + "<button onClick='validCalcAvgByGrp();' class='Small'>Calculate</button> &nbsp; &nbsp;"
             + "<button onClick='validAvgByGrp(&#34;" + Grp[argb] + "&#34;);' class='Small'>Change</button> &nbsp; &nbsp;"
             + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
             + "<button onClick='setNewAvgByGrp(&#34;" + argb + "&#34;)' class='Small'>Reset</button>"
          + "</td>"
       + "</tr>"

    panel += "<tr class='DataTable1' style='position: relative; top: expression(this.offsetParent.scrollTop-2);'>"
             + "<th class='DataTable' nowrap>Adj</th>"
    panel += "<th class='DataTable' colspan='" + Str.length
             + "' nowrap><input class='Small' id='Adj' size=5 maxlength=5>%"
             + "</th>"
    panel += "</tr>"

    for(var i=0; i < Str.length; i++)
    {
       panel += "<tr class='DataTable1'>"
       panel += "<td class='DataTable' nowrap>" + Str[i] + "</td>"
       panel += "<td class='DataTable' nowrap>"
              + "$<input class='Small' id='Avg' value='" + Avg[i][argb] + "' size=5 maxlength=5>"
              + " &nbsp; &nbsp; &nbsp; "
              + "<input class='Small' id='AdjGrp' size=5 maxlength=5>%"
            + "</td>"

       panel += "</tr>"
    }

    panel += "<tr class='DataTable'>"
          + "<td class='DataTable' colspan=50>"
             + "<button onClick='validCalcAvgByGrp();' class='Small'>Calculate</button> &nbsp; &nbsp;"
             + "<button onClick='validAvgByGrp(&#34;" + Grp[argb] + "&#34;);' class='Small'>Change</button> &nbsp; &nbsp;"
             + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
             + "<button onClick='setNewAvgByGrp(&#34;" + argb + "&#34;)' class='Small'>Reset</button>"
          + "</td>"
       + "</tr>"
     + "</table>"

    return panel;
}
//==============================================================================
// calculate new budget average wages
//==============================================================================
function validCalcAvgByGrp()
{
   var error= false;
   var msg = "";

   var adj = document.all.Adj.value.trim();

   if(adj != "" && isNaN(adj)){ error=true; msg += "\nAverage wage must be numeric value."; }

   var adjg = new Array();
   var adjobj = document.all.AdjGrp;
   var err1 = false
   for(var i=0; i < adjobj.length; i++)
   {
        adjg[i] = adjobj[i].value.trim();
        if(adjg[i] != "" && isNaN(adjg[i])){ err1 = true; }
   }
   if(err1){ error=true; msg += "\nAverage wage must be numeric value."; }

   if(error){alert(msg)}
   else{ calcNewAvgByGrp(adj, adjg)}
}
//==============================================================================
// calculate new averages
//==============================================================================
function calcNewAvgByGrp(adj, adjg)
{
   var avgobj = document.all.Avg;

   for(var i=0; i < avgobj.length; i++)
   {
      var avg = avgobj[i].value.trim();
      var newval = avg;

      // apply percent applying for all
      if(adj != ""){ newval = ((1 + eval(adj)/100) * eval(avg)).toFixed(2); }

      // apply individual percent
      if(adjg[i] != ""){ newval = ((1 + eval(adjg[i])/100) * eval(avg)).toFixed(2); }

      //save value in input fields
      avgobj[i].value = newval;

      document.all.AdjGrp[i].value = "";
   }

   document.all.Adj.value = "";
}
//==============================================================================
// validate new entries
//==============================================================================
function validAvgByGrp(grp)
{
   var error= false;
   var msg = "";

   var avg = new Array();
   var avgobj = document.all.Avg;
   var avgerr = [false,false,false];

   for(var i=0; i < avgobj.length; i++)
   {
      avg[i] = avgobj[i].value.trim();
      avgobj[i].style.background="white";

      if(avg[i] == ""){ avgerr[0] = true; avgobj[i].style.background="pink"; }
      else if(isNaN(avg[i])){ avgerr[1] = true;  avgobj[i].style.background="pink";}
      else if(eval(avg[i]) < 0){ avgerr[2] = true;  avgobj[i].style.background="pink";}

   }

   if(avgerr[0]){ error=true; msg += "\nPlease, enter average wage value." }
   if(avgerr[1]){ error=true; msg += "\nAverage wage must be numeric value." }
   if(avgerr[2]){ error=true; msg += "\nAverage wage cannot be negative." }

   if(error){alert(msg)}
   else{ sbmAvgByGrp(grp, avg)}
}
//==============================================================================
// submit new entries
//==============================================================================
function sbmAvgByGrp(grp, avg)
{
   var url = "MtxBdgAvgSave.jsp?&Grp=" + grp
   for(var i=0; i < avg.length; i++)
   {
      url += "&Avg=" + avg[i]
      url += "&Str=" + Str[i]
   }
   url += "&Action=UPD_BDG_AVG"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// update selected group matrix
//==============================================================================
function updGrpBdgAvg()
{
   for(var i=0; i < Str.length; i++)
   {
      var cellnm = "tdAvgV" + i + "_" + SelGrpArg;
      var oldval = document.all[cellnm].innerHTML;
      var newval = document.all.Avg[i].value.trim();
      if(oldval != newval)
      {
         try
         {
           document.all[cellnm].innerHTML = newval;
           document.all[cellnm].style.background = "#ccffcc";
         }
         catch(err) { }
      }
   }
   hidePanel();
}
//==============================================================================
// reload page
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// Apply Matrix to selected store and stores
//==============================================================================
function setApplyMtx()
{
   var hdr = "Apply Matrix to Store/Month";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblHrsEarn'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2 id='dvHrsEarn'>"
            + popApplyMtx()
       + "</td></tr>"
     + "</table>"

   document.all.dvBdgAvg.innerHTML=html
   document.all.dvBdgAvg.style.width = 420;
   document.all.dvBdgAvg.style.pixelLeft = document.documentElement.scrollLeft + 400;
   document.all.dvBdgAvg.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvBdgAvg.style.visibility="visible";
}
//==============================================================================
// Apply Matrix to selected store and stores
//==============================================================================
function popApplyMtx()
{
    var panel = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"

    panel += "<tr class='DataTable3'>"
          + "<td class='DataTable'>"
             + "<a class='small' href='javascript: chkAllStr(&#34;ALL&#34;)'>All Store<a> &nbsp; &nbsp;"
             + "<a class='small' href='javascript: chkAllStr(&#34;CLEAR&#34;)'>Clear<a> &nbsp; &nbsp;"
          + "</td>"
       + "</tr>"

    panel += "<tr class='DataTable1'>"
       + "<td class='DataTable1'>"
       + "<table><tr class='DataTable1'>"

    for(var i=0; i < Str.length; i++)
    {
       if(i > 0 && i%10 ==0){ panel += "</tr><tr class='DataTable1'>"}
       panel += "<td class='DataTable1'><input type='checkbox' name='Str' value='" + Str[i] + "'>" + Str[i] + "</td>"
    }
    panel += "</table>"
    panel += "</td></tr>"

    panel += "<tr class='DataTable3'>"
          + "<td class='DataTable'>"
             + "<a class='small' href='javascript: chkAllMon(&#34;ALL&#34;)'>All Month<a> &nbsp; &nbsp;"
             + "<a class='small' href='javascript: chkAllMon(&#34;CLEAR&#34;)'>Clear<a> &nbsp; &nbsp;"
          + "</td>"
       + "</tr>"

    panel += "<tr class='DataTable1'>"
       + "<td class='DataTable1'>"
       + "<table><tr class='DataTable1'>"

    for(var i=0; i < Mon.length; i++)
    {

       if(i > 0 && i%5 ==0){ panel += "</tr><tr class='DataTable1'>"}
       panel += "<td class='DataTable1'><input type='checkbox' name='Mon' value='" + (i+1) + "'>" + Mon[i] + "</td>"
    }
    panel += "</table>"
    panel += "</td></tr>"

    panel += "<tr class='DataTable3'>"
          + "<td class='DataTable'>"
             + "<button onClick='validApply();' class='Small'>Change</button> &nbsp; &nbsp;"
             + "<button onClick='hidePanel();' class='Small'>Close</button>"
          + "</td>"
       + "</tr>"
     + "</table>"

    return panel;
}
//==============================================================================
// check/clear all stores
//==============================================================================
function chkAllStr(type)
{
   var chk = true;
   if(type=="CLEAR")
   {
      chk = false;
   }
   for(var i=0; i < document.all.Str.length; i++)
   {
       document.all.Str[i].checked=chk
   }
}
//==============================================================================
// check/clear all month
//==============================================================================
function chkAllMon(type)
{
   var chk = true;
   if(type=="CLEAR")
   {
      chk = false;
   }
   for(var i=0; i < document.all.Mon.length; i++)
   {
       document.all.Mon[i].checked=chk
   }
}
//==============================================================================
// validate - apply matrix to store
//==============================================================================
function validApply()
{
   var error= false;
   var msg = "";

   var str = document.all.Str;
   var strval = new Array();
   var strsel = false;
   for(var i=0,j=0; i < str.length; i++)
   {
      if(str[i].checked){ strval[j++]=str[i].value; strsel = true; }
   }
   if(!strsel){ error=true; msg+="\nPlease, select at least 1 store." }

   var mon = document.all.Mon;
   var monval = new Array();
   var monsel = false;
   for(var i=0,j=0; i < mon.length; i++)
   {
      if(mon[i].checked){ monval[j++]=mon[i].value; monsel = true; }
   }
   if(!monsel){ error=true; msg+="\nPlease, select at least 1 month." }


   if(error){alert(msg)}
   else{ sbmApplyMtx(strval, monval)}
}
//==============================================================================
// submit - apply matrix to store
//==============================================================================
function sbmApplyMtx(str, mon)
{
   var url = "MtxBdgAvgSave.jsp?Action=APPLY_STR_MTX_MON"
   for(var i=0; i < str.length; i++)  {  url += "&Str=" + str[i]; }
   for(var i=0; i < mon.length; i++)  {  url += "&Mon=" + mon[i]; }

   //alert(url)
   window.frame1.location.href = url;

   hidePanel();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvBdgAvg.innerHTML = " ";
   document.all.dvBdgAvg.style.visibility = "hidden";
}
//==============================================================================
// scroll table with fixed header
//==============================================================================
function setTblScroll()
{
   document.all.trHdr1.style.position = "relative";
   document.all.trHdr2.style.position = "relative";
}
//==============================================================================
// get Group Name
//==============================================================================
function getGrpName(argb, obj, show)
{
   var vpos = getOffset(obj).top

   document.all.dvToolTip.innerHTML=GrpNm[argb];
   document.all.dvToolTip.style.pixelLeft = getOffset(obj).left + 25;
   document.all.dvToolTip.style.pixelTop= getOffset(obj).top - 10;
   document.all.dvToolTip.style.visibility="visible"
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel1()
{
   document.all.dvToolTip.innerHTML = " ";
   document.all.dvToolTip.style.visibility = "hidden";
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
<div id="dvBdgAvg" class="dvBdgAvg"></div>
<div id="dvToolTip" class="dvToolTip"></div>
<!-------------------------------------------------------------------->
<div id="dvMonSel" class="dvMonSel"></div>
<!-------------------------------------------------------------------->

  <div style="overflow: AUTO; width: 100%; height: 100%; POSITION: relative;" onscroll="setTblScroll()">
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <thead>
     <tr bgColor="ivory" style="position: relative; top: expression(this.offsetParent.scrollTop);">
       <td ALIGN="center" VALIGN="TOP" width="10%">
         <b>Retail Concepts Inc.
         <br>Store Budget Average Wage Matrix
         </b>
         <br>
         <%if(!sInFrame.equals("Y")) {%>
            <a href="../" class="small"><font color="red">Home</font></a>&#62;
            <a href="MtxCompBfdgAvg.jsp" class="small"><font color="red">Company Budget</font></a>&#62;
            <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
         <%}%>
         <a href="javascript: setApplyMtx()" class="small">Apply Matrix</a>
       </td>
     </tr>
     </thead>
     <tbody style="overflow: auto">
     <tr bgColor="ivory">
       <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <thead>
         <tr  id="trHdr1" style="top: expression(this.offsetParent.scrollTop);">
           <th class="DataTable">Str</th>
           <th class="DataTable">&nbsp;</th>
           <th class="DataTable" colspan="<%=iNumOfGrp%>">Budget Group</th>
         </tr>
         <tr  id="trHdr2" style="top: expression(this.offsetParent.scrollTop);">
           <th class="DataTable">&nbsp;</th>
           <th class="DataTable">&nbsp;</th>
           <%for(int j=0; j < iNumOfGrp; j++){%>
             <th class="DataTable"
                onmouseover="getGrpName('<%=j%>', this, true)"
                onmouseout="hidePanel1()">
                <a href="javascript: setNewAvgByGrp('<%=j%>')"><%=sGrp[j]%></a>
             </th>
           <%}%>
         </tr>
       </thead>
       <tbody>
     <!------------------------------- Data Detail --------------------------------->
      <%for(int i=0; i < iNumStr; i++){
          bdgmtx.setBdgAvg();
          String [] sAvg = bdgmtx.getAvg();
          String [] sAdj = bdgmtx.getAdj();
          String sAvgJsa = bdgmtx.getAvgJsa();
          String sAdjJsa = bdgmtx.getAdjJsa();
      %>
         <tr class="DataTable">
           <td class="DataTable2" rowspan=2><%=sStr[i]%></td>
           <td class="DataTable21" id="trAvg<%=i%>"><a href="javascript: setNewAvg('<%=i%>','AVG')">Avg</a></td>
           <%for(int j=0; j < iNumOfGrp; j++){%>
             <td class="DataTable" id="tdAvgV<%=i%>_<%=j%>"><%=sAvg[j]%></td>
           <%}%>
         </tr>
         <tr class="DataTable2">
            <td class="DataTable21">
               <a href="javascript: setNewAvg('<%=i%>','ADJ')">Adj</a>
            </td>
            <%for(int j=0; j < iNumOfGrp; j++){%>
              <td class="DataTable" id="tdAdjV<%=i%><%=j%>"><%=sAdj[j]%>%</td>
            <%}%>
         </tr>
         <tr>
            <td style="font-size:1px;border-bottom:grey 1px outset" colspan=<%=iNumOfGrp+2%>>&nbsp;</td>
         </tr>
         <script>Avg[<%=i%>] = [<%=sAvgJsa%>]; Adj[<%=i%>] = [<%=sAdjJsa%>]; </script>
      <%}%>
      <!------------------------ End Details ---------------------------------->
      </tbody>
   </table>
   </td>
   </tr>
    <!----------------------- end of table ---------------------------------->
    </tbody>
  </table>
 <div>

</body>

</html>

<%
  bdgmtx.disconnect();
  bdgmtx = null;
  }
%>
