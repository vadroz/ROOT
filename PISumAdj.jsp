<%@ page import="inventoryreports.PiSumAdj, rciutility.RunSQLStmt, java.util.*, java.sql.*"%>
<%
   String [] sStore = request.getParameterValues("STORE");
   String sDivision = request.getParameter("DIVISION");
   String [] sDivMlt = request.getParameterValues("DivM");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sLevel = request.getParameter("LEVEL");
   String sSortBy = request.getParameter("SORT");
   String sIncl900 = request.getParameter("Incl900");
   String sByChain = request.getParameter("BYCHAIN");
   String sPiYearMo = request.getParameter("PICal");
   String sPiYM1yrBk = request.getParameter("PICal1yrBk");
   String sPiYM2yrBk = request.getParameter("PICal2yrBk");
   String sPICalNm = request.getParameter("PICalNm");
   String sPICalNm1yb = request.getParameter("PICalNm1yb");
   String sPICalNm2yb = request.getParameter("PICalNm2yb");

   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sLevel == null) sLevel = "000";
   if(sSortBy == null) sSortBy = "GROUP";
   if (sIncl900 == null) sIncl900=" ";
   if(sByChain == null) sByChain = "N";
   if(sPiYM1yrBk==null) {sPiYM1yrBk = sPiYearMo;}
   if(sPiYM2yrBk==null) {sPiYM2yrBk = sPiYearMo;}

   if(sDivMlt == null){ sDivMlt = new String[]{ sDivision };  }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=PISumAdj.jsp&APPL=ALL");
}
else
{
   String sUser = session.getAttribute("USER").toString();
   boolean bShrinkAllow = true; //session.getAttribute("INVSRINK") != null;
   
   String sSortTitle = "Sort by";

   if(!sByChain.equals("Y") && sSortBy.equals("GROUP"))
         sSortTitle = "Sorted by Store";
   else if (sLevel.equals("000") && sSortBy.equals("GROUP"))
         sSortTitle = "Sorted by Divisions";
   else if(sLevel.equals("100") && sSortBy.equals("GROUP"))
         sSortTitle = "Sorted by Departments";
   else if(sLevel.equals("010") && sSortBy.equals("GROUP"))
         sSortTitle = "Sorted by Classes";
   else if(sSortBy.equals("SHRNK")) sSortTitle = "Sorted by Shrinkage";

   //System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
         //+ sStore[0] + " " + sLevel + " " + sSortBy + "|" +  sIncl900 + "|" + sByChain
         //+ "|" + sPiYearMo + "|" + sPiYM1yrBk + "|" + sPiYM2yrBk
   //);

   PiSumAdj setPi = new PiSumAdj(sDivMlt, sDepartment, sClass, sStore,
      sPiYearMo.substring(0, 4),  sPiYearMo.substring(4),
      sPiYM1yrBk.substring(0, 4),  sPiYM1yrBk.substring(4),
      sPiYM2yrBk.substring(0, 4),  sPiYM2yrBk.substring(4),
      sLevel, sSortBy, sIncl900, sByChain);
    String [] sGrp = setPi.getGroup();

    String sGrpJSA = setPi.getGrpJSA();
    String sDivJSA = setPi.getDivJSA();
    String sDptJSA = setPi.getDptJSA();
    String sClsJSA = setPi.getClsJSA();
    String sStrJSA = setPi.getStrJSA();

    String sDivNameJSA = setPi.getDivNameJSA();
    String sDptNameJSA = setPi.getDptNameJSA();
    String sClsNameJSA = setPi.getClsNameJSA();

    int iNumOfSls = setPi.getNumOfSls();
    // Physical Count
    String [] sPhQty = setPi.getPhQty();
    String [] sPhRet = setPi.getPhRet();
    String [] sPhCst = setPi.getPhCst();
    // Computer On Hand
    String [] sOhQty = setPi.getOhQty();
    String [] sOhRet = setPi.getOhRet();
    String [] sOhCst = setPi.getOhCst();
    // Adjustment
    String [][] sAdQty = setPi.getAdQty();
    String [][] sAdRet = setPi.getAdRet();
    String [][] sAdCst = setPi.getAdCst();
    String [][] sShrink = setPi.getShrink();
    String [][] sSales = setPi.getSales();

    //--------------------------------------------------------------------------
    //------------------------ Report Totals ---------------------------------
    // Physical Count
    String [] sRepPhQty = setPi.getRepPhQty();
    String [] sRepPhRet = setPi.getRepPhRet();
    String [] sRepPhCst = setPi.getRepPhCst();
    // Computer On Hand
    String [] sRepOhQty = setPi.getRepOhQty();
    String [] sRepOhRet = setPi.getRepOhRet();
    String [] sRepOhCst = setPi.getRepOhCst();
    // Adjustment
    String [][] sRepAdQty = setPi.getRepAdQty();
    String [][] sRepAdRet = setPi.getRepAdRet();
    String [][] sRepAdCst = setPi.getRepAdCst();
    String [][] sRepShrink = setPi.getRepShrink();
    String [][] sRepSales = setPi.getRepSales();

    String [] sInit = setPi.getInit();
    String [] sSts = setPi.getSts();
    String [] sComm = setPi.getComm();
    String [] sLastUpdDt = setPi.getLastUpdDt();
    String [] sAreaMaxAll = setPi.getAreaMaxAll();
    String [] sAreaMaxOk = setPi.getAreaMaxOk();
    String [] sAreaMaxCorr = setPi.getAreaMaxCorr();
    String [] sAreaMaxNoCorr = setPi.getAreaMaxNoCorr();
    String [] sAreaList = setPi.getAreaList();
    String [] sAreaMaxFin = setPi.getAreaMaxFin();
    String [] sAreaFinList = setPi.getAreaFinList();
    //--------------------------------------------------------------------------
    setPi.disconnect();

    String sColName = "Store";
    if(sByChain.equals("Y"))
    {
      if(sLevel.equals("000")) { sColName = "Division"; }
      else if(sLevel.equals("100")) { sColName = "Department"; }
      else if(sLevel.equals("010")) { sColName = "Class"; }
    }

    //==========================================================================
    String sDivName = "";
    if (!sDivision.equals("ALL"))
    {
        String sPrepStmt = "select dnam from IPTSFIL.IPDIVSN where ddiv=" + sDivision;
        RunSQLStmt runsql = new RunSQLStmt();
        runsql.setPrepStmt(sPrepStmt);
        runsql.runQuery();
        runsql.readNextRecord();
        sDivName = runsql.getData("dnam");
    }
    //==========================================================================
    String sDptName = "";
    if (!sDepartment.equals("ALL"))
    {
        String sPrepStmt = "select dnam from IPTSFIL.IPDEPTS where ddpt=" + sDepartment;
        RunSQLStmt runsql = new RunSQLStmt();
        runsql.setPrepStmt(sPrepStmt);
        runsql.runQuery();
        runsql.readNextRecord();
        sDptName = runsql.getData("dnam");
    }
    //==========================================================================
    String sClsName = "";
    if (!sClass.equals("ALL"))
    {
        String sPrepStmt = "select clnm from IPTSFIL.IPCLASS where ccls=" + sClass;
        RunSQLStmt runsql = new RunSQLStmt();
        runsql.setPrepStmt(sPrepStmt);
        runsql.runQuery();
        runsql.readNextRecord();
        sClsName = runsql.getData("clnm");
    }     
%>
<html>
<head>
<title>Tot Adj</title>
<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable1g { background:#ccffcc; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}               
        td.DataTable2 { border-top: double darkred;}
        td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}
        td.DataTable3g { background:#ccffcc; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Level = "<%=sLevel%>";
var Combined = <%=sLevel.indexOf('2') >= 0%>;
var Store = new Array();
<%for(int i=0; i < sStore.length; i++){%>Store[<%=i%>] = "<%=sStore[i]%>";<%}%>

var Div = [<%=sDivJSA%>];
var Dpt = [<%=sDptJSA%>];
var Cls = [<%=sClsJSA%>];
var Str = [<%=sStrJSA%>];;

var DivName = [<%=sDivNameJSA%>];
var DptName = [<%=sDptNameJSA%>];
var ClsName = [<%=sClsNameJSA%>];
var Grp = [<%=sGrpJSA%>];
var SortBy = "<%=sSortBy%>";
var ByChain = "<%=sByChain%>";

var PiYM1yrBk = "<%=sPiYM1yrBk%>";
var PiYM2yrBk = "<%=sPiYM2yrBk%>";

//--------------- End of Global variables ----------------
function bodyLoad()
{
  if(ByChain != "Y" && !Combined) doSelectGrp();
  else
  {
    document.all.dvForm.style.visibility="hidden";
  }

  show_hide_priorYr("tdPiCal1");
  show_hide_priorYr("tdPiCal2");
}
//==============================================================================
// show or hide prior year adjustment columns
//==============================================================================
function show_hide_priorYr(colnm)
{
   var show = "block";

   if(colnm.indexOf("1") >= 0 && PiYM1yrBk == "NONE") { show = "none";}
   if(colnm.indexOf("2") >= 0 && PiYM2yrBk == "NONE") { show = "none";}

   var col = document.all[colnm];
   for(var i=0; i < col.length; i++)
   {
      col[i].style.display = show;
   }
}
//==============================================================================
// show selection panel
//==============================================================================
function doSelectGrp()
{
    formHtml = "<Form name='LevelDown' >"
    if (ByChain != "Y" && (Level == "000" || Level == "200") || Level == "100" && ByChain == "Y")
    {
      formHtml += "Select Division: <Select name='DIVISION' class='Small'></Select><br>"
      if (ByChain != "Y" && Level == "000") formHtml += "<input name='LEVEL' value='100' type='hidden' >"
      else if (ByChain != "Y" && Level == "200") formHtml += "<input name='LEVEL' value='020' type='hidden' >"
      else formHtml += "<input name='LEVEL' value='010' type='hidden'>"
    }
    else if (ByChain != "Y" && (Level == "100" || Level == "020") || Level == "010" && ByChain == "Y")
    {
      formHtml += "Select Department: <Select name='DEPARTMENT' class='Small'></Select><br>"
      if (ByChain != "Y"  && Level == "100") formHtml += "<input  name='LEVEL' value='010' type='hidden'>"
      else if (ByChain != "Y"  && Level == "020") formHtml += "<input  name='LEVEL' value='002' type='hidden'>"
      else formHtml += "<input  name='LEVEL' value='001' type='hidden'>"
    }
    else if (ByChain != "Y" && Level == "010")
    {
      formHtml += "Select Class: <Select name='CLASS' class='Small'></Select><br>"
      formHtml += "<input name='LEVEL' value='001' type='hidden'>"
    }

    for(var i=0; i < Store.length; i++)
    {
      formHtml += "<input name='STORE' value='" + Store[i] + "' type='hidden'>"
    }

    // show submit button for next level down
    if (Level != "001" && Level != "002")
    {
      formHtml += "<input type='Submit' name='submit' value='  Go  ' class='Small'>"
    }
    formHtml += "<input type='hidden' name='PICal' value='<%=sPiYearMo%>'>"
        // show submit button to get for this level and by store
    if(Combined)
    {
      formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<input type='Submit' name='ByStore' value='SbmByStore' onclick='checkLevel();' class='Small'>"
    }

    formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<input type='BUTTON' name='Back' value='Back' onClick='javascript:history.back()' class='Small'>"
      + "</Form>"

    document.all.dvForm.innerHTML=formHtml
    document.all.dvForm.style.visibility="visible";

    if( ByChain != "Y" && (Level == "000" || Level == "200")
     || Level == "100" && ByChain == "Y")
             for(var i=0; i < Div.length;i++){ document.LevelDown.DIVISION.options[i] = new Option(Div[i] + " - " + unescape(DivName[i]), Div[i]); }
    else if( ByChain != "Y" && (Level == "100" || Level == "020")
          || Level == "010" && ByChain == "Y")
             for(var i=0; i < Dpt.length;i++){ document.LevelDown.DEPARTMENT.options[i] = new Option(Dpt[i] + " - " + unescape(DptName[i]), Dpt[i]); }
    else if( ByChain != "Y" && (Level == "010" || Level == "002")
          || Level == "001" && ByChain == "Y")
             for(var i=0; i < Cls.length;i++){ document.LevelDown.CLASS.options[i] = new Option(Cls[i] + " - " + unescape(ClsName[i]), Cls[i]); }
}

//==============================================================================
// Drill down on next div/dpt/class level
//==============================================================================
function drillDown(arg)
{
  var url = "PISumAdj.jsp?SORT=<%=sSortBy%>&Incl900=<%=sIncl900%>&BYCHAIN=<%=sByChain%>&PICal=<%=sPiYearMo%>&PICal1yrBk=<%=sPiYM1yrBk%>&PICal2yrBk=<%=sPiYM2yrBk%>&PICalNm=<%=sPICalNm%>&PICalNm1yb=<%=sPICalNm1yb%>&PICalNm2yb=<%=sPICalNm2yb%>"
  var group = "";
  var idx = 0;

  for(var i=0; i < Store.length; i++){url += "&STORE=" + Store[i];  }

  for (i=0; i<Grp[arg].length; i++)
  {
    if(Grp[arg].substring(i, i+1) != "-") group += Grp[arg].substring(i, i+1);
    else break;
  }

    if(Level == "000") url += "&DIVISION=" + group + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=100"
    else if(Level == "100") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=" + group + "&CLASS=<%=sClass%>&LEVEL=010"
    else if(Level == "010") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=" + group + "&LEVEL=001"


  //alert(url);
  window.location.href = url;
}
//==============================================================================
// Show data by Store
//==============================================================================
function showByStore(drill, grpName)
{
  var grp = "";

  for(var i=0; i < grpName.length; i++)
  {
    if  (grpName.substring(i, i+1) == "-"
      || grpName.substring(i, i+1) == " ") break;
    grp += grpName.substring(i, i+1);
  }

  var url = "PISumAdj.jsp?"
  url += "SORT=<%=sSortBy%>&Incl900=<%=sIncl900%>&PICal=<%=sPiYearMo%>&PICal1yrBk=<%=sPiYM1yrBk%>&PICal2yrBk=<%=sPiYM2yrBk%>&PICalNm=<%=sPICalNm%>&PICalNm1yb=<%=sPICalNm1yb%>&PICalNm2yb=<%=sPICalNm2yb%>";

  for(var i=0; i < Store.length; i++)
  {
     url += "&STORE=" + Store[i]
  }


  if (drill)
  {
    if(Level == "000") url += "&DIVISION=" + grp + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=100"
    else if(Level == "100") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=" + grp + "&CLASS=<%=sClass%>&LEVEL=010"
    else if(Level == "010") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=" + grp + "&LEVEL=001"
  }
  else
  {
    if(Level == "000") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=000"
    else if(Level == "100") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=100"
    else if(Level == "010") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=010"
  }


  url += "&BYCHAIN=N"
  //alert(url);
  window.location.href = url;
}

function showOneStore(str)
{
  var url = "PISumAdj.jsp?STORE=" + str

  if(Level == "000") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=<%=sLevel%>"
  else if(Level == "100") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=<%=sLevel%>"
  else if(Level == "010") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=<%=sLevel%>"

  url +="&SORT=<%=sSortBy%>&Incl900=<%=sIncl900%>&PICal=<%=sPiYearMo%>&PICal1yrBk=<%=sPiYM1yrBk%>&PICal2yrBk=<%=sPiYM2yrBk%>&PICalNm=<%=sPICalNm%>&PICalNm1yb=<%=sPICalNm1yb%>&PICalNm2yb=<%=sPICalNm2yb%>";
  url +="&BYCHAIN=Y";

  //alert(url);
  window.location.href = url;
}



//-------------------------------------------------------------
// show cls/ven/sty details
//-------------------------------------------------------------
function showItmGrp(grpName)
{
  var grp = "";
  for(var i=0; i < grpName.length; i++)
  {
    if  (grpName.substring(i, i+1) == "-"
      || grpName.substring(i, i+1) == " ") break;
    grp += grpName.substring(i, i+1);
  }

  var url = "PIDtlAdj.jsp?"

  url += "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS="
  if (Store == "ALL") { url += "<%=sClass%>"; }
  else { url += grp; }

  for(var i=0; i < Store.length; i++) { url += "&STORE=" + Store[i]}

  url += "&SORT=<%=sSortBy%>&Incl900=<%=sIncl900%>&BYCHAIN=<%=sByChain%>&PICal=<%=sPiYearMo%>&PICal1yrBk=<%=sPiYM1yrBk%>&PICal2yrBk=<%=sPiYM2yrBk%>&PICalNm=<%=sPICalNm%>&PICalNm1yb=<%=sPICalNm1yb%>&PICalNm2yb=<%=sPICalNm2yb%>";

  //alert(url);
  window.location.href = url;
}
//-------------------------------------------------------------
// show cls/ven/sty details
//-------------------------------------------------------------
function showAllItm()
{
   var url = "PIDtlAdj.jsp?"

   url += "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>"

   for(var i=0; i < Store.length; i++) { url += "&STORE=" + Store[i]}

   url += "&SORT=<%=sSortBy%>&Incl900=<%=sIncl900%>&BYCHAIN=<%=sByChain%>&PICal=<%=sPiYearMo%>&PICal1yrBk=<%=sPiYM1yrBk%>&PICal2yrBk=<%=sPiYM2yrBk%>&PICalNm=<%=sPICalNm%>&PICalNm1yb=<%=sPICalNm1yb%>&PICalNm2yb=<%=sPICalNm2yb%>";

   //alert(url);
   window.location.href = url;
}
//-------------------------------------------------------------
// Re-Sort table
//-------------------------------------------------------------
function reSort(sort)
{
  var url = "PISumAdj.jsp?"
          + "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=<%=sClass%>&LEVEL=<%=sLevel%>"
          + "&SORT=" + sort
          + "&Incl900=<%=sIncl900%>&BYCHAIN=<%=sByChain%>&PICal=<%=sPiYearMo%>&PICal1yrBk=<%=sPiYM1yrBk%>&PICal2yrBk=<%=sPiYM2yrBk%>&PICalNm=<%=sPICalNm%>&PICalNm1yb=<%=sPICalNm1yb%>&PICalNm2yb=<%=sPICalNm2yb%>";
  for(var i=0; i < Store.length; i++) { url += "&STORE=" + Store[i]}
  //alert(url);
  window.location.href = url;
}

//==============================================================================
// Update Item Status
//==============================================================================
function updItemSts(arg)
{
   var error = false;
   var msg = "";

   var div = "";
   var dpt = "";
   var cls = "";

  var group = "";
  for (i=0; i<Grp[arg].length; i++)
  {
    if(Grp[arg].substring(i, i+1) != "-") group += Grp[arg].substring(i, i+1);
    else break;
  }


   if(Level == "000"){ div = group; }
   else if(Level == "100"){ dpt = group; }
   else if(Level == "010"){ cls = group; }

   var initnm = "Init" + arg;
   var init = document.all[initnm].value.trim();

   var commnm = "Comm" + arg;
   var comm = document.all[commnm].value.trim();

   if(init==""){ error=true; msg +="\nPlease, enter initials before update.";}

   var sts = null;
   var stsnm = "Sts" + arg;
   var stsobj = document.all[stsnm];

   for(var i=0; i < stsobj.length; i++)
   {
     if(stsobj[i].checked){ sts = stsobj[i].value.trim(); }
   }
   if(sts == null){ error=true; msg +="\nPlease, click the status befor update."; }

   if(error){ alert(msg) }
   else { sbmItemSts(div, dpt, cls, init, comm, sts) }
}
//==============================================================================
// Update Item Status
//==============================================================================
function sbmItemSts(div, dpt, cls, init, comm, sts)
{
   var url = "PIItmStsSave.jsp?Store=<%=sStore[0]%>"
      + "&Div=" + div
      + "&Dpt=" + dpt
      + "&Class=" + cls
      + "&PICal=<%=sPiYearMo%>"
      + "&Init=" + init
      + "&Comm=" + comm
      + "&Status=" + sts
      + "&User=<%=sUser%>";

   //alert(url);
   //window.location.href=url;
   window.frame1.location.href=url;
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="left" width="300">
       <div id="dvForm" class="dvForm"></div>
      </td>
<!-------------------------------------------------------------------->

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Physical Inventory Adjustment Report
      <br>Inventory Period = <%=sPICalNm%>&nbsp;(<%=sPiYearMo.substring(0, 4) + "/" + sPiYearMo.substring(4)%>)
      <br>Store:
          <%if(sStore.length > 0){%>
             <%String sComa="";%>
             <%for(int i=0, j=0; i < sStore.length; i++, j++) {%>
                 <%=sComa%>
                 <%if(j==15){%><br><%j=0;%><%}%>
                 <%=sStore[i]%><%sComa=", ";%>
             <%}%>
          <%} else {%><%=sStore[0]%><%}%>
          <br>
          Div:
          <%String sComa ="";
            for(int i=0; i < sDivMlt.length; i++){%><%=sComa + sDivMlt[i]%><% sComa = ", ";}%>
          &nbsp;&nbsp&nbsp;&nbsp
          <%=sDivName%>&nbsp;&nbsp&nbsp;&nbsp
          Dpt: <%=sDepartment%> <%=sDptName%>&nbsp;&nbsp&nbsp;&nbsp
          Class: <%=sClass%> <%=sClsName%>
         <%if(sIncl900.trim().equals("")){%>
         	<br>Excluded divisions 94-99
         <%}%> 
         <br><%=sSortTitle%></b>
      </td>
      <td ALIGN="left" width="500">&nbsp;</td>
     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan=3>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="PISumAdjSel.jsp?mode=1">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.
          &nbsp;&nbsp;&nbsp;&nbsp;
          </font>

          <!-- a href="javascript: showAllItm()" style="font-size:11px">All Selected Items</a -->
<br><span style="font-size:12px"><sup>*</sup>Retail Sales are accumulative from each Store's last physical count date.</span>

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable"  rowspan="3"><a href="javascript: reSort('GROUP')"><%=sColName%></a></th>
          <th class="DataTable"  rowspan="3">
            <%if(sByChain.equals("Y")){%>
                <a href="javascript: showByStore(false, 0)">B<br>y<br>S<br>t<br>r</a><%}
              else{%>&nbsp;&nbsp;<%}%>
          </th>

            <th class="DataTable" rowspan="3" colspan="3">Physical Count</th>
            <th class="DataTable" rowspan="3">&nbsp;&nbsp;</th>
            <th class="DataTable" rowspan="3" colspan="3">Computer On Hand</th>
            <th class="DataTable" rowspan="3">&nbsp;&nbsp;</th>
            <th class="DataTable" colspan="5"><%=sPICalNm%></th>
            <th class="DataTable" id="tdPiCal1" rowspan="3">&nbsp;&nbsp;</th>
            <th class="DataTable" id="tdPiCal1"  colspan="5"><%=sPICalNm1yb%></th>
            <th class="DataTable" id="tdPiCal2"  rowspan="3">&nbsp;&nbsp;</th>
            <th class="DataTable" id="tdPiCal2"  colspan="5"><%=sPICalNm2yb%></th>
            <%if(sStore.length == 1 && sLevel.equals("010")){%>
               <th class="DataTable" rowspan="3">&nbsp;&nbsp;</th>
               <th class="DataTable" id="ItmSts" rowspan="2" colspan="5">On 5% Area Recount List</th>               
               <th class="DataTable" rowspan="3">&nbsp;&nbsp;</th>
               <th class="DataTable" id="ItmSts" rowspan="2" colspan="2">Final Adjustments</th>
               <th class="DataTable" rowspan="3">&nbsp;&nbsp;</th>
               <th class="DataTable" id="ItmSts" rowspan="2" colspan="5">Investigation Status</th>
            <%}%>
        </tr>
        <tr>
            <th class="DataTable"  colspan="3">Total Adjustment</th>
            <th class="DataTable"  rowspan="2"><%if(bShrinkAllow){%>*Retail<br>Sales<br>in<br>1,000's<%} %></th>
            <th class="DataTable" rowspan="2"><%if(bShrinkAllow){%><a href="javascript: reSort('SHRNK')">Shrinkage<br>%</a><%}%></th>

            <th class="DataTable" id="tdPiCal1" colspan="3">Total Adjustment</th>
            <th class="DataTable" id="tdPiCal1"  rowspan="2"><%if(bShrinkAllow){%>*Retail<br>Sales<br>in<br>1,000's<%} %></th>
            <th class="DataTable" id="tdPiCal1" rowspan="2"><%if(bShrinkAllow){%>Shrinkage<%}%></th>

            <th class="DataTable" id="tdPiCal2" colspan="3">Total Adjustment</th>
            <th class="DataTable" id="tdPiCal2"  rowspan="2"><%if(bShrinkAllow){%>Retail<br>Sales<br>in<br>1,000's<%} %></th>
            <th class="DataTable" id="tdPiCal2" rowspan="2"><%if(bShrinkAllow){%>Shrinkage<%}%></th>
        </tr>
        <tr>
            <th class="DataTable"><a href="javascript: reSort('ADQTY')">Units</a></th>
            <th class="DataTable"><a href="javascript: reSort('ADCST')">Cost</a></th>
            <th class="DataTable"><a href="javascript: reSort('ADRET')">Retail</a></th>

            <th class="DataTable" id="tdPiCal1">Units</th>
            <th class="DataTable" id="tdPiCal1">Cost</th>
            <th class="DataTable" id="tdPiCal1">Retail</th>

            <th class="DataTable" id="tdPiCal2">Units</th>
            <th class="DataTable" id="tdPiCal2">Cost</th>
            <th class="DataTable" id="tdPiCal2">Retail</th>

            <%if(sStore.length == 1 && sLevel.equals("010")){%>
               <th class="DataTable" id="ItmSts" rowspan="1">Areas</th>
               <th class="DataTable" id="ItmSts" rowspan="1" nowrap>Ok</th>
               <th class="DataTable" id="ItmSts" rowspan="1" nowrap>Corr</th>
               <th class="DataTable" id="ItmSts" rowspan="1" nowrap>No Corr</th>
               <th class="DataTable" id="ItmSts" rowspan="1" nowrap>All</th>
               <th class="DataTable" id="ItmSts" rowspan="1">Areas</th>
               <th class="DataTable" id="ItmSts" rowspan="1" nowrap>All</th>
               
               <th class="DataTable" id="ItmSts" rowspan="1">Initials</th>
               <th class="DataTable" id="ItmSts" rowspan="1">Status</th>
               <th class="DataTable" id="ItmSts" rowspan="1">Comments</th>
               <th class="DataTable" id="ItmSts" rowspan="1">Update</th>
               <th class="DataTable" id="ItmSts">Last Updated</th>
            <%}%>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfSls; i++) {%>

              <tr class="DataTable">
                <td class="DataTable1" nowrap>
                  <%if(sByChain.equals("Y") && !sLevel.equals("010")){%>
                     <a href="javascript: drillDown(<%=i%>)"><%=sGrp[i]%></a>
                  <%}
                  else if(!sByChain.equals("Y") && !sLevel.equals("001")){%>
                     <a href="javascript: showOneStore('<%=sGrp[i]%>')"><%=sGrp[i]%></a>
                      <%if((Long.parseLong(sPiYearMo) < 200812) && (sGrp[i].equals("35") || sGrp[i].equals("46") || sGrp[i].equals("50"))){%>
                         <sup style="font-size:12px; color:red; ">**</sup>
                      <%}%>
                  <%}
                  else {%>
                     <a href="javascript:showItmGrp(&#34;<%=sGrp[i]%>&#34;)"><%=sGrp[i]%></a>
                  <%}%></td>
                <th class="DataTable">
                   <%if(sByChain.equals("Y")) {%>
                      <a href="javascript: showByStore(true, '<%=sGrp[i]%>')">S</a>
                   <% } else{%>&nbsp;<%}%>
                </th>

                <td class="DataTable" nowrap><%=sPhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sOhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sOhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sOhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>
                <td class="DataTable" nowrap><%=sAdQty[i][0]%></td>
                <td class="DataTable" nowrap>$<%=sAdCst[i][0]%></td>
                <td class="DataTable" nowrap>$<%=sAdRet[i][0]%></td>
                <td class="DataTable" nowrap><%if(bShrinkAllow){%>$<%=sSales[i][0]%><%} %></td>
                <td class="DataTable" nowrap><%if(bShrinkAllow){%><%=sShrink[i][0]%>%<%} %></td>

                <th class="DataTable" id="tdPiCal1">&nbsp;&nbsp;</th>
                <td class="DataTable" id="tdPiCal1" nowrap><%=sAdQty[i][1]%></td>
                <td class="DataTable" id="tdPiCal1" nowrap>$<%=sAdCst[i][1]%></td>
                <td class="DataTable" id="tdPiCal1" nowrap>$<%=sAdRet[i][1]%></td>
                <td class="DataTable" id="tdPiCal1" nowrap><%if(bShrinkAllow){%>$<%=sSales[i][1]%><%} %></td>
                <td class="DataTable" id="tdPiCal1" nowrap><%if(bShrinkAllow){%><%=sShrink[i][1]%>%<%}%></td>

                <th class="DataTable" id="tdPiCal2">&nbsp;&nbsp;</th>
                <td class="DataTable" id="tdPiCal2" nowrap><%=sAdQty[i][2]%></td>
                <td class="DataTable" id="tdPiCal2" nowrap>$<%=sAdCst[i][2]%></td>
                <td class="DataTable" id="tdPiCal2" nowrap>$<%=sAdRet[i][2]%></td>
                <td class="DataTable" id="tdPiCal2" nowrap><%if(bShrinkAllow){%>$<%=sSales[i][2]%><%} %></td>
                <td class="DataTable" id="tdPiCal2" nowrap><%if(bShrinkAllow){%><%=sShrink[i][2]%>%<%} %></td>

                <%if(sStore.length == 1 && sLevel.equals("010")){
                   String sCellClr1 = ""; 
                   if(sAreaList[i] != null && !sAreaList[i].equals("")){sCellClr1 = "g"; }
                   String sCellClr2 = ""; 
                   if(sAreaFinList[i] != null && !sAreaFinList[i].equals("")){sCellClr2 = "g"; }
                %>    
                   <th class="DataTable" id="tdSts">&nbsp;&nbsp;</th>
                   <td class="DataTable1<%=sCellClr1%>" id="tdSts" nowrap><a href="PiReCntArea.jsp?Store=<%=sStore[0]%>&PICal=<%=sPiYearMo%>&Top=5" target="_blank"><%=sAreaList[i]%></a></td>
                   <td class="DataTable3<%=sCellClr1%>" id="tdSts" nowrap><%=sAreaMaxOk[i]%></td>
                   <td class="DataTable3<%=sCellClr1%>" id="tdSts" nowrap><%=sAreaMaxCorr[i]%></td>
                   <td class="DataTable3<%=sCellClr1%>" id="tdSts" nowrap><%=sAreaMaxNoCorr[i]%></td>
                   <td class="DataTable3<%=sCellClr1%>" id="tdSts" nowrap><%=sAreaMaxAll[i]%></td>
                   
                   <th class="DataTable" id="tdSts">&nbsp;&nbsp;</th>
                   <td class="DataTable1<%=sCellClr2%>" id="tdSts" nowrap><a href="PiStrAreaSkuEnt.jsp?Store=<%=sStore[0]%>&PICal=<%=sPiYearMo%>" target="_blank"><%=sAreaFinList[i]%></a></td>
                   <td class="DataTable3<%=sCellClr2%>" id="tdSts" nowrap><%=sAreaMaxFin[i]%></td>                   
                   
                   <th class="DataTable" id="tdSts">&nbsp;&nbsp;</th>
                   <td class="DataTable" id="tdSts" nowrap>
                      <input class="Small" name="Init<%=i%>" maxlength=10 size=3 value="<%=sInit[i]%>">
                   </td>
                   <td class="DataTable" id="tdSts" nowrap>
                      <input class="Small" type="radio" name="Sts<%=i%>" value="R" <%if(sSts[i].equals("R")){%>checked<%}%>>Researching &nbsp;
                      <input class="Small" type="radio" name="Sts<%=i%>" value="C" <%if(sSts[i].equals("C")){%>checked<%}%>>Correction Submitted &nbsp;
                      <input class="Small" type="radio" name="Sts<%=i%>" value="V" <%if(sSts[i].equals("V")){%>checked<%}%>>Verified OK &nbsp;
                   </td>
                   <td class="DataTable" id="tdSts" nowrap>
                      <input class="Small" name="Comm<%=i%>" maxlength=30 size=10 value="<%=sComm[i]%>">
                   </td>
                   <td class="DataTable" id="tdSts" nowrap>
                      <a href="javascript: updItemSts('<%=i%>')">update</a>
                   </td>
                   <td class="DataTable" id="tdSts" nowrap><%=sLastUpdDt[i]%></td>
                <%}%>
              </tr>
           <%}%>
      <!------------------- Company Total -------------------------------->
       <tr><td class="DataTable2"></td></tr>
       <%for(int i=0; i < 1; i++) {%>
              <tr class="DataTable3">
                <td class="DataTable1" nowrap>Totals</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap><%=sRepPhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepPhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepPhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sRepOhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepOhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepOhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>
                <td class="DataTable" nowrap><%=sRepAdQty[i][0]%></td>
                <td class="DataTable" nowrap>$<%=sRepAdCst[i][0]%></td>
                <td class="DataTable" nowrap>$<%=sRepAdRet[i][0]%></td>
                <td class="DataTable" nowrap><%if(bShrinkAllow){%>$<%=sRepSales[i][0]%><%} %></td>
                <td class="DataTable" nowrap><%if(bShrinkAllow){%><%=sRepShrink[i][0]%>%<%} %></td>

                <th class="DataTable" id="tdPiCal1">&nbsp;&nbsp;</th>
                <td class="DataTable" id="tdPiCal1" nowrap><%=sRepAdQty[i][1]%></td>
                <td class="DataTable" id="tdPiCal1" nowrap>$<%=sRepAdCst[i][1]%></td>
                <td class="DataTable" id="tdPiCal1" nowrap>$<%=sRepAdRet[i][1]%></td>
                <td class="DataTable" id="tdPiCal1" nowrap><%if(bShrinkAllow){%>$<%=sRepSales[i][1]%><%} %></td>
                <td class="DataTable" id="tdPiCal1" nowrap><%if(bShrinkAllow){%><%=sRepShrink[i][1]%>%<%} %></td>

                <th class="DataTable" id="tdPiCal2">&nbsp;&nbsp;</th>
                <td class="DataTable" id="tdPiCal2" nowrap><%=sRepAdQty[i][2]%></td>
                <td class="DataTable" id="tdPiCal2" nowrap>$<%=sRepAdCst[i][2]%></td>
                <td class="DataTable" id="tdPiCal2" nowrap>$<%=sRepAdRet[i][2]%></td>
                <td class="DataTable" id="tdPiCal2" nowrap><%if(bShrinkAllow){%>$<%=sRepSales[i][2]%><%} %></td>
                <td class="DataTable" id="tdPiCal2" nowrap><%if(bShrinkAllow){%><%=sRepShrink[i][2]%>%<%} %></td>

                <%if(sStore.length == 1 && sLevel.equals("010")){%>
                   <th class="DataTable">&nbsp;</th>
                   <td class="DataTable" colspan=15>&nbsp;</td>
                <%}%>
              </tr>
           <%}%>
      </table>
     </td>
    </tr>

    <tr>
     <td ALIGN="left" VALIGN="TOP" nowrap colspan=3><br>
      <font size="-1">
        <%for(int j=0; j < 65; j++) {%>&nbsp;<%}%>
          *Note: Shrinkage as a percentage of retail sales.<br>
      </font>
     </td>
    </tr>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%}%>