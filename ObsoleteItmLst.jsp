<%@ page import="agedanalysis.ObsoleteItmLst, rciutility.ClassSelect, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelStr = request.getParameter("Str");
   String sSelDiv = request.getParameter("Div");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelSku = request.getParameter("Sku");
   String sLevel = request.getParameter("Level");
   String sSort = request.getParameter("Sort");

   boolean bUnselect = sSelStr == null;

   if(sSelStr == null){ sSelStr = ""; }
   if(sSelDiv == null){ sSelDiv = "ALL"; }
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
   if(sSelSku == null){ sSelSku = "ALL"; }

   if(sLevel == null){ sLevel = "D"; }
   if(sSort == null){ sSort = "GRP"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=ObsoleteItmLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   StoreSelect strsel = new StoreSelect(16);
   String sStrJsa = strsel.getStrNum();
   String sStrNameJsa = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   String sStrRegJsa = strsel.getStrReg();

   String [] sStrDistLst = strsel.getStrDistLst();
   String sStrDistJsa = strsel.getStrDist();
   String [] sStrDistNmLst = strsel.getStrDistNmLst();
   String sStrDistNmJsa = strsel.getStrDistNm();

   String [] sStrMallLst = strsel.getStrMallLst();
   String sStrMallJsa = strsel.getStrMall();

   int iSpace = 6;
   String sUser = session.getAttribute("USER").toString();

   ClassSelect divsel = new ClassSelect();
   String sDivLst = divsel.getDivNum();
   String sDivNameLst = divsel.getDivName();
   String sDptLst = divsel.getDptNum();
   String sDptNameLst = divsel.getDptName();
   String sDptGroupLst = divsel.getDptGroup();

   //System.out.println(sSelSku + "|" + sSort + "|" + sUser);
   ObsoleteItmLst obsanl = null;
   int iNumOfGrp = 0;
   obsanl = new ObsoleteItmLst(sSelStr, sSelDiv, sSelDpt, sSelCls, sSelSku, sLevel, sSort, sUser);
   iNumOfGrp = obsanl.getNumOfItm();

   String sGrpColNm = "Group";
   if(sLevel.equals("S")){sGrpColNm = "Store";}
   else if(!sSelCls.equals("ALL")){sGrpColNm = "Div";}
   else if(!sSelDpt.equals("ALL")){sGrpColNm = "Class";}
   else if(!sSelDiv.equals("ALL")){sGrpColNm = "Department";}
   else if(sSelDiv.equals("ALL")){sGrpColNm = "Division";}

   String sRepSel = "Group";
   if(!sSelCls.equals("ALL")){sRepSel = "Class: " + sSelCls;}
   else if(!sSelDpt.equals("ALL")){sRepSel = "Department: " + sSelDpt;}
   else if(!sSelDiv.equals("ALL")){sRepSel = "Division: " + sSelDiv;}
   else if(sSelDiv.equals("ALL")){sRepSel = "Division: ALL";}

%>
<html>
<head>

<style>body {background:ivory;text-align:center; }
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { background:#FFE4C4;text-align:center;}

        th.DataTable  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:14px }


        tr.DataTable  { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable2  { background:gray; color:white; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#F6CEF5; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}

        td.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable4 { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        .Small {font-size:10px }
        select.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.dvStyle { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:900; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; overflow:none;}

       div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
</style>
<SCRIPT language="JavaScript1.2">

//--------------- Global variables -----------------------
var Unselect = <%=bUnselect%>;
var SelDiv = "<%=sSelDiv%>";
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";
var SelSku = "<%=sSelSku%>";
var Level = "<%=sLevel%>";

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var ArrDiv = [<%=sDivLst%>];
var ArrDivNm = [<%=sDivNameLst%>];
var ArrDpt = [<%=sDptLst%>];
var ArrDptNm = [<%=sDptNameLst%>];
var ArrDptGrp = [<%=sDptGroupLst%>];

var ArrSelStr = new Array();
ArrSelStr[0] = "<%=sSelStr%>";

//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStyle"]);

   if(!Unselect) { setSelectPanelShort(); }
   else { setSelectPanel(); }
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = "Select Report Parameters";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Resvtore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"

   document.all.dvSelect.innerHTML=html;
   document.all.dvSelect.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvSelect.style.width=200;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='padding-left:3px; padding-right:3px;'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelWk()

   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;

   // populate store dropdown menu
   var str = document.all.Str;
   for(var i=0; i < ArrStr.length; i++)
   {
       str.options[i] = new Option(ArrStr[i] + " - " + ArrStrNm[i], ArrStr[i]);
       if(ArrSelStr[0]==ArrStr[i]){ str.selectedIndex= i; }
   }

   doDivSelect(null);
   // set on selected division
   var seldiv = document.all.selDiv;
   for(var i=0; i < seldiv.length; i++)
   {
      if(SelDiv == seldiv.options[i].value){doDivSelect(i); break;}
   }
   //set on selected department
   var seldpt = document.all.selDpt;
   for(var i=0; i < seldpt.length; i++)
   {
      if(SelDpt == seldpt.options[i].value){showDptSelect(i); break;}
   }

   //set on selected department
   if( SelCls != "ALL")
   {
      rtvClasses();
      var selcls = document.all.selCls;
      for(var i=0; i < selcls.length; i++)
      {
         if(SelCls == selcls.options[i].value){alert(i); showClsSelect(i); break;}
      }
   }

   var lvl = document.all.Level;
   for(var i=0; i < lvl.length; i++)
   {
       if(Level==lvl[i].value){ lvl[i].checked = true; }
   }
   document.all.dvSelect.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvSelect.style.width=200;

}
//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt'>Stores &nbsp;</td>"
       + "<td class='Prompt' colspan=3>"
         + "<select class='Small' name='Str'></select>"
       + "</td>"
     + "</tr>"

     + "<tr><td class='Prompt'>&nbsp;</td></tr>"
     + "<tr>"
       + "<td class='Prompt'>Divisions &nbsp;</td>"
          + "<td class='Prompt'><input class='Small' name='DivName' size=50 readonly>"
          + "<input class='Small' name='Div' type='hidden'>"
          + "<input class='Small' name='DivArg' type='hidden' value=0>"
          + "<br><SELECT name='selDiv' class='Small' onchange='doDivSelect(this.selectedIndex);' size=5>"
               + "<OPTION value='ALL'>All Divisions</OPTION>"
          + "</SELECT>"
       + "</TD>"
     + "</tr>"

     + "<tr><td class='Prompt'>&nbsp;</td></tr>"
     + "<tr>"
       + "<td class='Prompt' nowrap>Departments &nbsp;</td>"
          + "<td class='Prompt' nowrap><input class='Small' name='DptName' size=50 readonly>"
          + "<input class='Small' name='Dpt' type='hidden' value='ALL'>"
          + "<input class='Small' name='DptArg' type='hidden' value=0>"
          + "<br><SELECT name='selDpt' class='Small' onchange='showDptSelect(this.selectedIndex);' size=5>"
               + "<OPTION value='ALL'>All Departments</OPTION>"
          + "</SELECT>"
       + "</TD>"
     + "</tr>"

     + "<tr><td class='Prompt'>&nbsp;</td></tr>"
     + "<tr>"
       + "<td class='Prompt' nowrap>Classes &nbsp;</td>"
          + "<td class='Prompt' nowrap><input class='Small' name='ClsName' size=50 value='All Classes' readonly>"
          + "<input class='Small' name='Cls' type='hidden' value='ALL'>"
          + "<input class='Small' name='ClsArg' type='hidden' value=0>"
          + "<button class='Small' name='GetCls' onClick='rtvClasses()'>Select Class</button>"
          + "<br><SELECT name='selCls' class='Small' onchange='showClsSelect(this.selectedIndex);' size=1>"
               + "<OPTION value='ALL'>All Classes</OPTION>"
          + "</SELECT>"
       + "</TD>"
     + "</tr>"

     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Report Option:</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Level' value='S'>By Store</td>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Level' value='D'>By Div, Dpt, Cls, Sku</td>"
              + "</tr>"

              + "<tr>"
                + "<td style='color:red; font-weight:bold; font-size:12px;' id='tdError' nowrap></td>"
              + "</tr>"
            + "</table>"
       + "</td>"
     + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Div.value
   var dpt = document.all.Dpt.value

   var url = "RetreiveDivDptCls.jsp?"
           + "Division=" + div
           + "&Department=" + dpt;
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
   // clear
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.selCls.options[i] = new Option(clsName[i], cls[i]);
   }
   document.all.selCls.size=5
}
//==============================================================================
// check all stores
//==============================================================================
function checkAll(chk)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk;
  }
}
//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var chg = id;

    var allowed;

    if (id == null || id == 0)
    {
        //  populate the division list
        var start = 0;
        for (var i = start, j=0; i < ArrDiv.length; i++, j++)
        {
           df.selDiv.options[j] = new Option(ArrDivNm[i],ArrDiv[i]);
        }
        if (id == null && document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        if (id == null) id = 0;
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = ArrDptGrp[id + 0].split(":");

    //  clear current depts
    for (var i = df.selDpt.length; i >= 0; i--)
    {
       df.selDpt.options[i] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (var i = 0; i < ArrDpt.length; i++)
            df.selDpt.options[i] = new Option(ArrDptNm[i],ArrDpt[i]);
    }
    //  else display the desired depts
    else
    {
       for (var i = 0; i < allowed.length; i++)
           df.selDpt.options[i] = new Option(ArrDptNm[allowed[i]], ArrDpt[allowed[i]]);
    }

    if(chg!=null)
    {
      showDptSelect(0);
      showClsSelect(0);
    }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showDptSelect(id)
{
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   // clear class
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.selectedIndex=0;
   document.all.selCls.size=1
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   document.all.ClsName.value = document.all.selCls.options[id].text
   document.all.Cls.value = document.all.selCls.options[id].value
}
//==============================================================================
// check by regions
//==============================================================================
function checkReg(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check by districts
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check mall
//==============================================================================
function checkMall(type)
{
  var str = document.all.Str
  var chk1 = true;
  var chk2 = false;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// Validate entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";
   var br = "";

   // get selected stores
   var selstr = document.all.Str.options[document.all.Str.selectedIndex].value;

   // get division, department class
   var seldiv = document.all.Div.value;
   var seldpt = document.all.Dpt.value;
   var selcls = document.all.Cls.value;

   // get report options
   var level = null;
   var levelobj = document.all.Level;
   for(var i=0; i < levelobj.length; i++)
   {
      if(levelobj[i].checked){  level = levelobj[i].value; break; }
   }

   if(error){alert(msg)}
   else{ submitForm(selstr, seldiv, seldpt, selcls, level) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, seldiv, seldpt, selcls, level)
{
   var url;
   url = "ObsoleteItmLst.jsp?"
   url += "Str=" + selstr;
   url += "&Div=" + seldiv;
   url += "&Dpt=" + seldpt;
   url += "&Cls=" + selcls;
   url += "&Sku=ALL";
   url += "&Level=" + level;
   url += "&Sort=<%=sSort%>";

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// select new report parameters
//==============================================================================
function selRep(str, date)
{
   var url;
   url = "ObsoleteItmLst.jsp?";

   if(str != null) { url += "&Str=" + str; }
   else
   {
     for(var i=0; i < ArrSelStr.length; i++)
     {
        url += "&Str=" + ArrSelStr[i];
     }
   }

   if(date != null) { url += "&From=" + date + "&To=" + date; }
   else { url += "&From=" + From + "&To=" + To; }

   url += "&Sort=<%=sSort%>";

   //alert(url);
   window.location.href=url;
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
// show selected div/batch
//==============================================================================
function drillDown(grp)
{
   var url;
   url = "ObsoleteItmLst.jsp?"

   if(Level=="S") { url += "Str=" + grp + "&Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>&Sku=<%=sSelSku%>&Level=D" }
   else if(SelDiv=="ALL" && SelDpt=="ALL" && SelCls=="ALL") { url += "Str=<%=sSelStr%>&Div=" + grp + "&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>&Sku=<%=sSelSku%>&Level=D" }
   else if(SelDpt=="ALL" && SelCls=="ALL"){ url += "Str=<%=sSelStr%>&Div=<%=sSelDiv%>&Dpt=" + grp + "&Cls=<%=sSelCls%>&Sku=<%=sSelSku%>&Level=D" }
   else if(SelCls=="ALL"){ url += "Str=<%=sSelStr%>&Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=" + grp + "&Sku=<%=sSelSku%>&Level=D" }

   url +="&Sort=<%=sSort%>";

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// pivot table by store
//==============================================================================
function pivotByStr(grp)
{
   var url;
   url = "ObsoleteItmLst.jsp?"

   if(grp=="ALL"){ url += "Str=ALL&Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>&Sku=<%=sSelSku%>" }
   else if(SelDiv=="ALL" && SelDpt=="ALL" && SelCls=="ALL"){ url += "Str=ALL&Div=" + grp + "&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>&Sku=<%=sSelSku%>" }
   else if(SelDpt=="ALL" && SelCls=="ALL"){ url += "Str=ALL&Div=<%=sSelDiv%>&Dpt=" + grp + "&Cls=<%=sSelCls%>&Sku=<%=sSelSku%>" }
   else if(SelCls=="ALL"){ url += "Str=ALL&Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=" + grp + "&Sku=<%=sSelSku%>" }
   else if(SelCls!="ALL"){ url += "Str=ALL&Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>&Sku=" + grp + "" }

   url +="&Level=S&Sort=<%=sSort%>";

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// resort curerent report
//==============================================================================
function resort(sort)
{
   var url;
   url = "ObsoleteItmLst.jsp?"
       + "Str=<%=sSelStr%>"
       + "&Div=<%=sSelDiv%>"
       + "&Dpt=<%=sSelDpt%>"
       + "&Cls=<%=sSelCls%>"
       + "&Sku=<%=sSelSku%>"
       + "&Level=<%=sLevel%>"
       + "&Sort=" + sort;

   //alert(url);
   window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<div id="dvStyle" class="dvStyle"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
 <div style="clear: both; overflow: AUTO; width: 100%; height: 94%; POSITION: relative; color:black;" >

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
        <thead>
        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable1" style="border-right:none" colspan=31>
            <b>Retail Concepts, Inc
            <br>Obsolete Items Analysis
            <br>Devision: <%=sSelDiv%>, Department: <%=sSelDpt%>, Class: <%=sSelCls%>, SKU: <%=sSelSku%>
            <br>Store: <%=sSelStr%>
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp;
          </th>
        </tr>


        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable"><a href="javascript: resort('GRP')"><%=sGrpColNm%></a></th>
          <%if(!sLevel.equals("S")){%>
             <th class="DataTable"><a href="javascript: pivotByStr('ALL')">B<br>y<br>S<br>t<br>r</a></th>
          <%}%>
          <%if(!sSelCls.equals("ALL") && !sLevel.equals("S")){%>
             <th class="DataTable"><a href="javascript: resort('DPT')">Dpt</a></th>
             <th class="DataTable"><a href="javascript: resort('ITEM')">Long Item Number</a></th>
             <th class="DataTable"><a href="javascript: resort('SKU')">Sku</a></th>
             <th class="DataTable"><a href="javascript: resort('DESC')">Item Description</a></th>
          <%}%>
          <th class="DataTable"><a href="javascript: resort('RET')">Retail</a></th>
          <th class="DataTable"><a href="javascript: resort('COST')">Cost</a></th>
          <th class="DataTable"><a href="javascript: resort('QTY')">Qty</a></th>

          <%if(!sSelCls.equals("ALL") && !sLevel.equals("S")){%>
             <th class="DataTable"><a href="javascript: resort('CLSNM')">Class Name</a></th>
             <th class="DataTable"><a href="javascript: resort('VENNM')">Vendor Name</a></th>
             <th class="DataTable"><a href="javascript: resort('CLRNM')">Color Name</a></th>
             <th class="DataTable"><a href="javascript: resort('SIZNM')">Size Name</a></th>
          <%}%>
        </tr>

        </thead>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++) {
              obsanl.setItemProperty();
              String sGroup = obsanl.getGroup();
              String sGrpNm = obsanl.getGrpNm();
              String sRet = obsanl.getRet();
              String sCost = obsanl.getCost();
              String sQty = obsanl.getQty();
              String sDpt = obsanl.getDpt();
              String sCls = obsanl.getCls();
              String sVen = obsanl.getVen();
              String sSty = obsanl.getSty();
              String sClr = obsanl.getClr();
              String sSiz = obsanl.getSiz();
              String sSku = obsanl.getSku();
              String sDesc = obsanl.getDesc();
              String sDptNm = obsanl.getDptNm();
              String sClsNm = obsanl.getClsNm();
              String sVenNm = obsanl.getVenNm();
              String sClrNm = obsanl.getClrNm();
              String sSizNm = obsanl.getSizNm();
           %>
              <tr class="DataTable">
                <%if(sSelCls.equals("ALL") || sLevel.equals("S")){%>
                   <td class="DataTable1" nowrap><a href="javascript: drillDown('<%=sGroup%>')"><%=sGroup%> - <%=sGrpNm%></a></td>
                <%} else {%><td class="DataTable" nowrap><%=sGroup%></td><%}%>

                <%if(!sLevel.equals("S") && sSelCls.equals("ALL")){%>
                   <th class="DataTable"><a href="javascript: pivotByStr('<%=sGroup%>')">S</a></th>
                <%} else if(!sLevel.equals("S") && !sSelCls.equals("ALL")){%>
                   <th class="DataTable"><a href="javascript: pivotByStr('<%=sSku%>')">S</a></th><%}%>

                <%if(!sSelCls.equals("ALL") && !sLevel.equals("S")){%>
                  <td class="DataTable1" nowrap><%=sDpt%></td>
                  <td class="DataTable1" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
                  <td class="DataTable1" nowrap><%=sSku%></td>
                  <td class="DataTable1" nowrap><%=sDesc%></td>
                <%}%>
                <td class="DataTable1" nowrap><%=sRet%></td>
                <td class="DataTable1" nowrap><%=sCost%></td>
                <td class="DataTable1" nowrap><%=sQty%></td>

                <%if(!sSelCls.equals("ALL") && !sLevel.equals("S")){%>
                   <td class="DataTable1" nowrap><%=sClsNm%></td>
                   <td class="DataTable1" nowrap><%=sVenNm%></td>
                   <td class="DataTable1" nowrap><%=sClrNm%></td>
                   <td class="DataTable1" nowrap><%=sSizNm%></td>
                <%}%>
              </tr>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
 </div>
 </body>
</html>
<%
  obsanl.disconnect();
  obsanl = null;
}
%>