<%@ page import="salesreport3.MarkdownInq, java.util.*, java.text.*"%>
<%
    long lStartTime = (new Date()).getTime();
   //Div=1 Dpt=1 Cls=ALL
   //Str=4 Str=5 Str=8 Str=10 Str=11 Str=20 Str=28 Str=30 Str=35 Str=40 Str=45 Str=46 Str=50 Str=55 Str=61 Str=82 Str=86 Str=88 Str=89 Str=98 Level=1 ByStr=0

   String [] sStore = request.getParameterValues("Str");
   String sDivision = request.getParameter("Div");
   String sDepartment = request.getParameter("Dpt");
   String sClass = request.getParameter("Cls");
   String sByStr = request.getParameter("ByStr");
   String sWkend = request.getParameter("Wkend");
   String sWkend2 = request.getParameter("Wkend2");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sDateLvl = request.getParameter("DateLvl");
   String sVendor = request.getParameter("Ven");
   String sSort = request.getParameter("Sort");

   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";   
   if(sVendor == null) sVendor = "ALL";
   if(sByStr == null) sByStr = "1";
   if(sSort == null) { sSort = "Grp"; }

if (session.getAttribute("USER")==null )
{
   response.sendRedirect("SignOn1.jsp?TARGET=MarkdownInqSel.jsp&APPL=ALL");
}
else
{

    String sUser = session.getAttribute("USER").toString();

    MarkdownInq mdninq = new MarkdownInq(sDivision, sDepartment, sClass, sVendor,
               sStore, sWkend, sWkend2, sYear, sMonth, sDateLvl, sByStr, sSort, sUser);

    int iNumOfSls = mdninq.getNumOfSls();
    int iNumOfReg = mdninq.getNumOfReg();
    String [] sReg = mdninq.getReg();
    boolean bMerch = sDivision.equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL");
    boolean bStore = sStore.length > 1;

    //Calendar cal = Calendar.getInstance();
    SimpleDateFormat sdfNow = new SimpleDateFormat("MM/dd/yyyy");
    Date curdt = new Date((new Date()).getTime() - 86400000);
    String sTodate = sdfNow.format(curdt);

    String sGroupNm = "";
    if(sByStr.equals("Y")){ sGroupNm = "Store"; }
    else if(sDivision.equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL")){ sGroupNm = "Division"; }
    else if(sDepartment.equals("ALL") && sClass.equals("ALL")){ sGroupNm = "Department"; }
    else if(sClass.equals("ALL")){ sGroupNm = "Class"; }
    else { sGroupNm = "Vendor"; }
%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:white;text-align:center; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { border-top: double darkred;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//report parameters
//--------------- Global variables -----------------------
var Store = new Array(<%=sStore.length%>);
<%for(int i=0; i < sStore.length; i++) {%>Store[<%=i%>] = "<%=sStore[i]%>"; <%}%>

var Division = "<%=sDivision%>";
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";
var Vendor = "<%=sVendor%>";
var Wkend = "<%=sWkend%>";
var Wkend2 = "<%=sWkend2%>";
var Year = "<%=sYear%>";
var Month = "<%=sMonth%>";
var DateLvl = "<%=sDateLvl%>";
var ByStr = "<%=sByStr%>";
//--------------- End of Global variables ----------------
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
   	showCol('MGR');
   	//showCol('FUR');
}

//--------------------------------------------------------
// Show data by Store
//--------------------------------------------------------
function drillDown(grp, level)
{
  var url = "MarkdownInq.jsp?";
  if(level == "Store"){ url += "Div=" + Division + "&Dpt=" + Department + "&Cls=" + Class + "&Ven=" + Vendor}
  else if(level == "Division"){ url += "Div=" + grp + "&Dpt=" + Department + "&Cls=" + Class + "&Ven=" + Vendor}
  else if(level == "Department"){ url += "Div=" + Division + "&Dpt=" + grp + "&Cls=" + Class + "&Ven=" + Vendor}
  else if(level == "Class"){ url += "Div=" + Division + "&Dpt=" + Department + "&Cls=" + grp + "&Ven=" + Vendor}

  url += "&Wkend=" + Wkend
  url += "&Wkend2=" + Wkend2
  url += "&Year=" + Year
  url += "&Month=" + Month
  url += "&DateLvl=" + DateLvl

  if(level == "Store"){ url += "&Str=" + grp + "&ByStr=N"; }
  else
  {
     for(var i = 0; i < Store.length; i++){ url += "&Str=" + Store[i]; }
     url += "&ByStr=" + ByStr
  }
  
  url += "&Sort=<%=sSort%>"

  //alert(url);
  window.location.href = url;
}
//--------------------------------------------------------
// Show data by Store
//--------------------------------------------------------
function drillByStr(grp, level)
{
  var url = "MarkdownInq.jsp?";
  if(level == "SAME"){ url += "Div=" + Division + "&Dpt=" + Department + "&Cls=" + Class + "&Ven=" + Vendor  }
  else if(level == "Division"){ url += "Div=" + grp + "&Dpt=" + Department + "&Cls=" + Class + "&Ven=" + Vendor  }
  else if(level == "Department"){ url += "Div=" + Division + "&Dpt=" + grp + "&Cls=" + Class + "&Ven=" + Vendor}
  else if(level == "Class"){ url += "Div=" + Division + "&Dpt=" + Department + "&Cls=" + grp + "&Ven=" + Vendor}

  url += "&Wkend=" + Wkend
     + "&Wkend2=" + Wkend2
     + "&Year=" + Year
     + "&Month=" + Month
     + "&DateLvl=" + DateLvl
     + "&ByStr=Y"
  url += "&Sort=<%=sSort%>"

  for(var i = 0; i < Store.length; i++){ url += "&Str=" + Store[i]; }

  //alert(url);
  window.location.href = url;
}
//--------------------------------------------------------
// sort by selected column
//--------------------------------------------------------
function resort(sort)
{
var url = "MarkdownInq.jsp?";
url += "Div=" + Division + "&Dpt=" + Department + "&Cls=" + Class + "&Ven=" + Vendor
  + "&Wkend=" + Wkend
  + "&Wkend2=" + Wkend2
  + "&Year=" + Year
  + "&Month=" + Month
  + "&DateLvl=" + DateLvl
  + "&ByStr=" + ByStr  

for(var i = 0; i < Store.length; i++){ url += "&Str=" + Store[i]; }

url += "&Sort=" + sort;  

//alert(url);
window.location.href = url;
}
//==============================================================================
// display group of columns
//==============================================================================
function showCol(grp)
{
   var disp = "none";
   var col = null;
   var block= "table-cell";
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ block= "block"; }

   if(grp=="REG" && document.all.chbReg.checked){ disp = block; }
   else if(grp=="PROM" && document.all.chbProm.checked){ disp = block; }
   else if(grp=="MGR" && document.all.chbMgr.checked){ disp = block; }
   else if(grp=="CLR" && document.all.chbClr.checked){ disp = block; }
   else if(grp=="FUR" && document.all.chbFur.checked){ disp = block; }
   else if(grp=="TOT" && document.all.chbTot.checked){ disp = block; }

   if(grp=="REG"){ col = document.all.colReg;}
   else if(grp=="PROM"){ col = document.all.colProm;}
   else if(grp=="MGR"){ col = document.all.colMgr;}
   else if(grp=="CLR"){ col = document.all.colClr;}
   else if(grp=="FUR"){ col = document.all.colFur;}
   else if(grp=="TOT"){ col = document.all.colTot;}

   for(var i=0; i < col.length; i++)
   {
      col[i].style.display=disp;
   }
}
</SCRIPT>


</head>
<body onload="bodyLoad()">

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Sales By Type</b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <b>Store: <%String sComa = "";%>
      <%for(int i=0; i < sStore.length; i++) {%><%=sComa + sStore[i]%><%sComa = ", "; }%>
       <br>Division: <%=sDivision%> &nbsp;&nbsp;
           Department: <%=sDepartment%> &nbsp;&nbsp;
           Class: <%=sClass%>
       <br><%if(sDateLvl.equals("W")){%>Week: <%=sWkend%><%}
              else  if(sDateLvl.equals("V")){%>Week: <%=sWkend%> - <%=sWkend2%><%}
              else if(sDateLvl.equals("M")){%>Month: <%=sYear + "/" + sMonth%><%}
              else if(sDateLvl.equals("Y")){%>Year: <%=sYear%><%}%>
         </b>


      <br><a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="MarkdownInqSel.jsp?mode=1">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font><br><br>
<!-------------------------------------------------------------------->
      <table class="DataTable1" cellPadding="0" cellSpacing="0">
        <tr>
          <th colspan=18>Display Columns</th>
        </tr>
        <tr>
          <th><input type="Checkbox" name="chbReg" onClick="showCol('REG')" value="1" checked>Regular Sales &nbsp; &nbsp; &nbsp;
              <input type="Checkbox" name="chbMgr" onClick="showCol('MGR')" value="1">Mgr Clearance Sales &nbsp; &nbsp; &nbsp;
              <input type="Checkbox" name="chbProm" onClick="showCol('PROM')" value="1" checked>Promo Sales &nbsp; &nbsp; &nbsp;
              <input type="Checkbox" name="chbClr" onClick="showCol('CLR')" value="1" checked>Clearance Sales &nbsp; &nbsp; &nbsp;
              <input type="Checkbox" name="chbFur" onClick="showCol('FUR')" value="1" checked>Patio Sales &nbsp; &nbsp; &nbsp;
              <input type="Checkbox" name="chbTot" onClick="showCol('TOT')" value="1" checked>Totals
          <th>
        </tr>
      </table><br>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan=3><%=sGroupNm%></th>
          <th class="DataTable" rowspan=3>
             <%if(!sGroupNm.equals("Store") && sStore.length > 1){%>
                <a href="javascript: drillByStr('ALL', 'SAME')">B<br>y<br>S<br>t<br>r</a><%} else{%>&nbsp;<%}%>
          </th>
          <th class="DataTable" id="colReg" colspan=10 >
             Regular Priced
             <br>(Cent ending in .x0, x1, x2, x4, x5, x6, x7, x8, x9)
             <br>(excludes all Reg-Promo/Clearance cent endings)
             <br>(and NOT on Sale)</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="colMgr" colspan=10 >Manager Priced<br>(this colulmn no longer used)</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="colProm" colspan=10 >
            Regular Priced - and on PROMO (TEMP Sale)
            <br>(Cent ending in .x3 and .98)
            <br>(excludes all Regular/Clearance cent endings)
            <br>(and ON Sale)
          </th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="colClr" colspan=10 >
             Clearance Priced
             <br>(Cent ending in .80 to .89, and .94, .96, .97)
             <br>(excludes all Regular/Reg-Promo cent endings)
             <br>(All - On Sale or Not)</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="colFur" colspan=8 nowrap>Patio<br>(All cent endings if Div=50, or Div=95 for Patio S/O)<br>(All - On Sale or Not)</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="colTot" colspan=8 >Grand Total - of All Sales<br>(regardless of check marked columns being displayed)</th>
          <th class="DataTable" rowspan=3><%=sGroupNm%></th>
        </tr>
        <tr>
          <th class="DataTable" id="colReg" colspan=2>Ret</th>
          <th class="DataTable" id="colReg" colspan=2>Unauth<br>POS</th>
          <th class="DataTable" id="colReg" colspan=2>GM $</th>
          <th class="DataTable" id="colReg" colspan=2>GM %</th>
          <th class="DataTable" id="colReg" colspan=2>% Total<br>Sales</th>

          <th class="DataTable" id="colMgr" colspan=2>Ret</th>
          <th class="DataTable" id="colMgr" colspan=2>Unauth<br>POS</th>
          <th class="DataTable" id="colMgr" colspan=2>GM $</th>
          <th class="DataTable" id="colMgr" colspan=2>GM %</th>
          <th class="DataTable" id="colMgr" colspan=2>% Total<br>Sales</th>

          <th class="DataTable" id="colProm" colspan=2>Ret</th>
          <th class="DataTable" id="colProm" colspan=2>Unauth<br>POS</th>
          <th class="DataTable" id="colProm" colspan=2>GM $</th>
          <th class="DataTable" id="colProm" colspan=2>GM %</th>
          <th class="DataTable" id="colProm" colspan=2>% Total<br>Sales</th>

          <th class="DataTable" id="colClr" colspan=2>Ret</th>
          <th class="DataTable" id="colClr" colspan=2>Unauth<br>POS</th>
          <th class="DataTable" id="colClr" colspan=2>GM $</th>
          <th class="DataTable" id="colClr" colspan=2>GM %</th>
          <th class="DataTable" id="colClr" colspan=2>% Total<br>Sales</th>

          <th class="DataTable" id="colFur" colspan=2>Ret</th>
          <th class="DataTable" id="colFur" colspan=2>GM $</th>
          <th class="DataTable" id="colFur" colspan=2>GM %</th>
          <th class="DataTable" id="colFur" colspan=2>% Total<br>Sales</th>

          <th class="DataTable" id="colTot" colspan=2>Ret</th>
          <th class="DataTable" id="colTot" colspan=2>Unauth<br>POS</th>
          <th class="DataTable" id="colTot" colspan=2>GM $</th>
          <th class="DataTable" id="colTot" colspan=2>GM %</th>
        </tr>
        <tr>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegRetTy')">TY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegRetLy')">LY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegUnapTy')">TY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegUnapLy')">LY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegGM$Ty')">TY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegGM$Ly')">LY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegGMPTy')">TY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegGMPLy')">LY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegSlsPTy')">TY</a></th>
          <th class="DataTable" id="colReg"><a href="javascript:resort('RegSlsPLy')">LY</a></th>

          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrRetTy')">TY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrRetLy')">LY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrUnapTy')">TY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrUnapLy')">LY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrGM$Ty')">TY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrGM$Ly')">LY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrGMPTy')">TY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrGMPLy')">LY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrSlsPTy')">TY</a></th>
          <th class="DataTable" id="colMgr"><a href="javascript:resort('MgrSlsPLy')">LY</a></th>


          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmRetTy')">TY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmRetLy')">LY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmUnapTy')">TY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmUnapLy')">LY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmGM$Ty')">TY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmGM$Ly')">LY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmGMPTy')">TY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmGMPLy')">LY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmSlsPTy')">TY</a></th>
          <th class="DataTable" id="colProm"><a href="javascript:resort('PrmSlsPLy')">LY</a></th>

          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrRetTy')">TY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrRetLy')">LY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrUnapTy')">TY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrUnapLy')">LY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrGM$Ty')">TY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrGM$Ly')">LY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrGMPTy')">TY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrGMPLy')">LY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrSlsPTy')">TY</a></th>
          <th class="DataTable" id="colClr"><a href="javascript:resort('ClrSlsPLy')">LY</a></th>

          <th class="DataTable" id="colFur"><a href="javascript:resort('FurRetTy')">TY</a></th>
          <th class="DataTable" id="colFur"><a href="javascript:resort('FurRetLy')">LY</a></th>
          <th class="DataTable" id="colFur"><a href="javascript:resort('FurGM$Ty')">TY</a></th>
          <th class="DataTable" id="colFur"><a href="javascript:resort('FurGM$Ly')">LY</a></th>
          <th class="DataTable" id="colFur"><a href="javascript:resort('FurGMPTy')">TY</a></th>
          <th class="DataTable" id="colFur"><a href="javascript:resort('FurGMPLy')">LY</a></th>
          <th class="DataTable" id="colFur"><a href="javascript:resort('FurSlsPTy')">TY</a></th>
          <th class="DataTable" id="colFur"><a href="javascript:resort('FurSlsPLy')">LY</a></th>

          <th class="DataTable" id="colTot"><a href="javascript:resort('TotRetTy')">TY</a></th>
          <th class="DataTable" id="colTot"><a href="javascript:resort('TotRetLy')">LY</a></th>
          <th class="DataTable" id="colTot"><a href="javascript:resort('TotUnapTy')">TY</a></th>
          <th class="DataTable" id="colTot"><a href="javascript:resort('TotUnapLy')">LY</a></th>
          <th class="DataTable" id="colTot"><a href="javascript:resort('TotGM$Ty')">TY</a></th>
          <th class="DataTable" id="colTot"><a href="javascript:resort('TotGM$Ly')">LY</a></th>
          <th class="DataTable" id="colTot"><a href="javascript:resort('TotGMPTy')">TY</a></th>
          <th class="DataTable" id="colTot"><a href="javascript:resort('TotGMPLy')">LY</a></th>
        </tr>


<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfSls; i++) {%>
           <%
               mdninq.setSales();

               String sGrp = mdninq.getGrp();
               String sGrpNm = mdninq.getGrpNm();
               String sDiv = mdninq.getDiv();
               String sDpt = mdninq.getDpt();
               String sCls = mdninq.getCls();
               String sVen = mdninq.getVen();

               String sTyRegCost = mdninq.getTyRegCost();
               String sTyRegRet = mdninq.getTyRegRet();
               String sTyRegDisc = mdninq.getTyRegDisc();
               String sTyRegGrm = mdninq.getTyRegGrm();
               String sTyRegGrmPrc = mdninq.getTyRegGrmPrc();
               String sTyRegSlsPrc = mdninq.getTyRegSlsPrc();

               String sTyPromCost = mdninq.getTyPromCost();
               String sTyPromRet = mdninq.getTyPromRet();
               String sTyPromDisc = mdninq.getTyPromDisc();
               String sTyPromGrm = mdninq.getTyPromGrm();
               String sTyPromGrmPrc = mdninq.getTyPromGrmPrc();
               String sTyPromSlsPrc = mdninq.getTyPromSlsPrc();

               String sTyClrCost = mdninq.getTyClrCost();
               String sTyClrRet = mdninq.getTyClrRet();
               String sTyClrDisc = mdninq.getTyClrDisc();
               String sTyClrGrm = mdninq.getTyClrGrm();
               String sTyClrGrmPrc = mdninq.getTyClrGrmPrc();
               String sTyClrSlsPrc = mdninq.getTyClrSlsPrc();

               String sTyMgrCost = mdninq.getTyMgrCost();
               String sTyMgrRet = mdninq.getTyMgrRet();
               String sTyMgrDisc = mdninq.getTyMgrDisc();
               String sTyMgrGrm = mdninq.getTyMgrGrm();
               String sTyMgrGrmPrc = mdninq.getTyMgrGrmPrc();
               String sTyMgrSlsPrc = mdninq.getTyMgrSlsPrc();

               String sTyFurCost = mdninq.getTyFurCost();
               String sTyFurRet = mdninq.getTyFurRet();
               String sTyFurDisc = mdninq.getTyFurDisc();
               String sTyFurGrm = mdninq.getTyFurGrm();
               String sTyFurGrmPrc = mdninq.getTyFurGrmPrc();
               String sTyFurSlsPrc = mdninq.getTyFurSlsPrc();

               String sLyRegCost = mdninq.getLyRegCost();
               String sLyRegRet = mdninq.getLyRegRet();
               String sLyRegDisc = mdninq.getLyRegDisc();
               String sLyRegGrm = mdninq.getLyRegGrm();
               String sLyRegGrmPrc = mdninq.getLyRegGrmPrc();
               String sLyRegSlsPrc = mdninq.getLyRegSlsPrc();

               String sLyPromCost = mdninq.getLyPromCost();
               String sLyPromRet = mdninq.getLyPromRet();
               String sLyPromDisc = mdninq.getLyPromDisc();
               String sLyPromGrm = mdninq.getLyPromGrm();
               String sLyPromGrmPrc = mdninq.getLyPromGrmPrc();
               String sLyPromSlsPrc = mdninq.getLyPromSlsPrc();

               String sLyClrCost = mdninq.getLyClrCost();
               String sLyClrRet = mdninq.getLyClrRet();
               String sLyClrDisc = mdninq.getLyClrDisc();
               String sLyClrGrm = mdninq.getLyClrGrm();
               String sLyClrGrmPrc = mdninq.getLyClrGrmPrc();
               String sLyClrSlsPrc = mdninq.getLyClrSlsPrc();

               String sLyMgrCost = mdninq.getLyMgrCost();
               String sLyMgrRet = mdninq.getLyMgrRet();
               String sLyMgrDisc = mdninq.getLyMgrDisc();
               String sLyMgrGrm = mdninq.getLyMgrGrm();
               String sLyMgrGrmPrc = mdninq.getLyMgrGrmPrc();
               String sLyMgrSlsPrc = mdninq.getLyMgrSlsPrc();

               String sLyFurCost = mdninq.getLyFurCost();
               String sLyFurRet = mdninq.getLyFurRet();
               String sLyFurDisc = mdninq.getLyFurDisc();
               String sLyFurGrm = mdninq.getLyFurGrm();
               String sLyFurGrmPrc = mdninq.getLyFurGrmPrc();
               String sLyFurSlsPrc = mdninq.getLyFurSlsPrc();

               // row totals
               String sTyTotCost = mdninq.getTyTotCost();
               String sTyTotRet = mdninq.getTyTotRet();
               String sTyTotDisc = mdninq.getTyTotDisc();
               String sTyTotGrm = mdninq.getTyTotGrm();
               String sTyTotGrmPrc = mdninq.getTyTotGrmPrc();
               String sTyTotSlsPrc = mdninq.getTyTotSlsPrc();

               String sLyTotCost = mdninq.getLyTotCost();
               String sLyTotRet = mdninq.getLyTotRet();
               String sLyTotDisc = mdninq.getLyTotDisc();
               String sLyTotGrm = mdninq.getLyTotGrm();
               String sLyTotGrmPrc = mdninq.getLyTotGrmPrc();
               String sLyTotSlsPrc = mdninq.getLyTotSlsPrc();
           %>
              <tr class="DataTable">
                <td class="DataTable1" nowrap>
                  <%if(!sGroupNm.equals("Vendor")){%><a href="javascript: drillDown('<%=sGrp%>', '<%=sGroupNm%>')"><%=sGrp%><%if(!sGroupNm.equals("Store")){%> - <%=sGrpNm%><%}%></a><%}
                  else{%><%=sGrp%> - <%=sGrpNm%><%}%>
                </td>
                <th class="DataTable">
                   <%if(!sGroupNm.equals("Store") && sStore.length > 1){%>
                      <a href="javascript: drillByStr('<%=sGrp%>', '<%=sGroupNm%>')">S</a><%} else{%>&nbsp;<%}%>
                </th>
                <td class="DataTable" id="colReg" nowrap>$<%=sTyRegRet%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sLyRegRet%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sTyRegDisc%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sLyRegDisc%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sTyRegGrm%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sLyRegGrm%></td>
                <td class="DataTable" id="colReg" nowrap><%=sTyRegGrmPrc%>%</td>
                <td class="DataTable" id="colReg" nowrap><%=sLyRegGrmPrc%>%</td>
                <td class="DataTable" id="colReg" nowrap><%=sTyRegSlsPrc%>%</td>
                <td class="DataTable" id="colReg" nowrap><%=sLyRegSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colMgr" nowrap>$<%=sTyMgrRet%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sLyMgrRet%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sTyMgrDisc%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sLyMgrDisc%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sTyMgrGrm%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sLyMgrGrm%></td>
                <td class="DataTable" id="colMgr" nowrap><%=sTyMgrGrmPrc%>%</td>
                <td class="DataTable" id="colMgr" nowrap><%=sLyMgrGrmPrc%>%</td>
                <td class="DataTable" id="colMgr" nowrap><%=sTyMgrSlsPrc%>%</td>
                <td class="DataTable" id="colMgr" nowrap><%=sLyMgrSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colProm" nowrap>$<%=sTyPromRet%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sLyPromRet%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sTyPromDisc%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sLyPromDisc%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sTyPromGrm%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sLyPromGrm%></td>
                <td class="DataTable" id="colProm" nowrap><%=sTyPromGrmPrc%>%</td>
                <td class="DataTable" id="colProm" nowrap><%=sLyPromGrmPrc%>%</td>
                <td class="DataTable" id="colProm" nowrap><%=sTyPromSlsPrc%>%</td>
                <td class="DataTable" id="colProm" nowrap><%=sLyPromSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colClr" nowrap>$<%=sTyClrRet%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sLyClrRet%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sTyClrDisc%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sLyClrDisc%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sTyClrGrm%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sLyClrGrm%></td>
                <td class="DataTable" id="colClr" nowrap><%=sTyClrGrmPrc%>%</td>
                <td class="DataTable" id="colClr" nowrap><%=sLyClrGrmPrc%>%</td>
                <td class="DataTable" id="colClr" nowrap><%=sTyClrSlsPrc%>%</td>
                <td class="DataTable" id="colClr" nowrap><%=sLyClrSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colFur" nowrap>$<%=sTyFurRet%></td>
                <td class="DataTable" id="colFur" nowrap>$<%=sLyFurRet%></td>
                <td class="DataTable" id="colFur" nowrap>$<%=sTyFurGrm%></td>
                <td class="DataTable" id="colFur" nowrap>$<%=sLyFurGrm%></td>
                <td class="DataTable" id="colFur" nowrap><%=sTyFurGrmPrc%>%</td>
                <td class="DataTable" id="colFur" nowrap><%=sLyFurGrmPrc%>%</td>
                <td class="DataTable" id="colFur" nowrap><%=sTyFurSlsPrc%>%</td>
                <td class="DataTable" id="colFur" nowrap><%=sLyFurSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colTot" nowrap>$<%=sTyTotRet%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sLyTotRet%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sTyTotDisc%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sLyTotDisc%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sTyTotGrm%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sLyTotGrm%></td>
                <td class="DataTable" id="colTot" nowrap><%=sTyTotGrmPrc%>%</td>
                <td class="DataTable" id="colTot" nowrap><%=sLyTotGrmPrc%>%</td>
                <td class="DataTable1" nowrap>
                  <%if(!sGroupNm.equals("Vendor")){%><a href="javascript: drillDown('<%=sGrp%>', '<%=sGroupNm%>')"><%=sGrp%><%if(!sGroupNm.equals("Store")){%> - <%=sGrpNm%><%}%></a><%}
                  else{%><%=sGrp%> - <%=sGrpNm%><%}%>
                </td>
              </tr>
           <%}%>

           <%int iMax = iNumOfReg + 3;%>
           <%for(int i=0; i < iMax; i++) {%>
           <%
               String sTotal = null;
               boolean bDisp = false;

               if(bMerch && i==0){mdninq.setTotMerch("M"); sTotal = "Merchandise"; bDisp = true;}
               else if(bMerch && i==1){ mdninq.setTotMerch("N"); sTotal = "Non-Merchandise"; bDisp = true;}
               else if(bStore && i >= 2 && i-2 < iNumOfReg)
               {
                  mdninq.setTotReg(Integer.toString(i-1));
                  sTotal = "Reg " + sReg[i-2];
                   bDisp = true;
               }
               else if(i == iMax-1){ mdninq.setTotal(); sTotal = "Total";  bDisp = true;}


             if( bDisp )
             {
               String sTyRegCost = mdninq.getTyRegCost();
               String sTyRegRet = mdninq.getTyRegRet();
               String sTyRegDisc = mdninq.getTyRegDisc();
               String sTyRegGrm = mdninq.getTyRegGrm();
               String sTyRegGrmPrc = mdninq.getTyRegGrmPrc();
               String sTyRegSlsPrc = mdninq.getTyRegSlsPrc();

               String sTyPromCost = mdninq.getTyPromCost();
               String sTyPromRet = mdninq.getTyPromRet();
               String sTyPromDisc = mdninq.getTyPromDisc();
               String sTyPromGrm = mdninq.getTyPromGrm();
               String sTyPromGrmPrc = mdninq.getTyPromGrmPrc();
               String sTyPromSlsPrc = mdninq.getTyPromSlsPrc();

               String sTyClrCost = mdninq.getTyClrCost();
               String sTyClrRet = mdninq.getTyClrRet();
               String sTyClrDisc = mdninq.getTyClrDisc();
               String sTyClrGrm = mdninq.getTyClrGrm();
               String sTyClrGrmPrc = mdninq.getTyClrGrmPrc();
               String sTyClrSlsPrc = mdninq.getTyClrSlsPrc();

               String sTyMgrCost = mdninq.getTyMgrCost();
               String sTyMgrRet = mdninq.getTyMgrRet();
               String sTyMgrDisc = mdninq.getTyMgrDisc();
               String sTyMgrGrm = mdninq.getTyMgrGrm();
               String sTyMgrGrmPrc = mdninq.getTyMgrGrmPrc();
               String sTyMgrSlsPrc = mdninq.getTyMgrSlsPrc();

               String sTyFurCost = mdninq.getTyFurCost();
               String sTyFurRet = mdninq.getTyFurRet();
               String sTyFurDisc = mdninq.getTyFurDisc();
               String sTyFurGrm = mdninq.getTyFurGrm();
               String sTyFurGrmPrc = mdninq.getTyFurGrmPrc();
               String sTyFurSlsPrc = mdninq.getTyFurSlsPrc();

               String sLyRegCost = mdninq.getLyRegCost();
               String sLyRegRet = mdninq.getLyRegRet();
               String sLyRegDisc = mdninq.getLyRegDisc();
               String sLyRegGrm = mdninq.getLyRegGrm();
               String sLyRegGrmPrc = mdninq.getLyRegGrmPrc();
               String sLyRegSlsPrc = mdninq.getLyRegSlsPrc();

               String sLyPromCost = mdninq.getLyPromCost();
               String sLyPromRet = mdninq.getLyPromRet();
               String sLyPromDisc = mdninq.getLyPromDisc();
               String sLyPromGrm = mdninq.getLyPromGrm();
               String sLyPromGrmPrc = mdninq.getLyPromGrmPrc();
               String sLyPromSlsPrc = mdninq.getLyPromSlsPrc();

               String sLyClrCost = mdninq.getLyClrCost();
               String sLyClrRet = mdninq.getLyClrRet();
               String sLyClrDisc = mdninq.getLyClrDisc();
               String sLyClrGrm = mdninq.getLyClrGrm();
               String sLyClrGrmPrc = mdninq.getLyClrGrmPrc();
               String sLyClrSlsPrc = mdninq.getLyClrSlsPrc();

               String sLyMgrCost = mdninq.getLyMgrCost();
               String sLyMgrRet = mdninq.getLyMgrRet();
               String sLyMgrDisc = mdninq.getLyMgrDisc();
               String sLyMgrGrm = mdninq.getLyMgrGrm();
               String sLyMgrGrmPrc = mdninq.getLyMgrGrmPrc();
               String sLyMgrSlsPrc = mdninq.getLyMgrSlsPrc();

               String sLyFurCost = mdninq.getLyFurCost();
               String sLyFurRet = mdninq.getLyFurRet();
               String sLyFurDisc = mdninq.getLyFurDisc();
               String sLyFurGrm = mdninq.getLyFurGrm();
               String sLyFurGrmPrc = mdninq.getLyFurGrmPrc();
               String sLyFurSlsPrc = mdninq.getLyFurSlsPrc();

               // row totals
               String sTyTotCost = mdninq.getTyTotCost();
               String sTyTotRet = mdninq.getTyTotRet();
               String sTyTotDisc = mdninq.getTyTotDisc();
               String sTyTotGrm = mdninq.getTyTotGrm();
               String sTyTotGrmPrc = mdninq.getTyTotGrmPrc();
               String sTyTotSlsPrc = mdninq.getTyTotSlsPrc();

               String sLyTotCost = mdninq.getLyTotCost();
               String sLyTotRet = mdninq.getLyTotRet();
               String sLyTotDisc = mdninq.getLyTotDisc();
               String sLyTotGrm = mdninq.getLyTotGrm();
               String sLyTotGrmPrc = mdninq.getLyTotGrmPrc();
               String sLyTotSlsPrc = mdninq.getLyTotSlsPrc();

           %>
           <tr class="DataTable3">
                <td class="DataTable1" nowrap><%=sTotal%></td>
                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colReg" nowrap>$<%=sTyRegRet%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sLyRegRet%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sTyRegDisc%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sLyRegDisc%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sTyRegGrm%></td>
                <td class="DataTable" id="colReg" nowrap>$<%=sLyRegGrm%></td>
                <td class="DataTable" id="colReg" nowrap><%=sTyRegGrmPrc%>%</td>
                <td class="DataTable" id="colReg" nowrap><%=sLyRegGrmPrc%>%</td>
                <td class="DataTable" id="colReg" nowrap><%=sTyRegSlsPrc%>%</td>
                <td class="DataTable" id="colReg" nowrap><%=sLyRegSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colMgr" nowrap>$<%=sTyMgrRet%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sLyMgrRet%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sTyMgrDisc%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sLyMgrDisc%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sTyMgrGrm%></td>
                <td class="DataTable" id="colMgr" nowrap>$<%=sLyMgrGrm%></td>
                <td class="DataTable" id="colMgr" nowrap><%=sTyMgrGrmPrc%>%</td>
                <td class="DataTable" id="colMgr" nowrap><%=sLyMgrGrmPrc%>%</td>
                <td class="DataTable" id="colMgr" nowrap><%=sTyMgrSlsPrc%>%</td>
                <td class="DataTable" id="colMgr" nowrap><%=sLyMgrSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colProm" nowrap>$<%=sTyPromRet%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sLyPromRet%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sTyPromDisc%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sLyPromDisc%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sTyPromGrm%></td>
                <td class="DataTable" id="colProm" nowrap>$<%=sLyPromGrm%></td>
                <td class="DataTable" id="colProm" nowrap><%=sTyPromGrmPrc%>%</td>
                <td class="DataTable" id="colProm" nowrap><%=sLyPromGrmPrc%>%</td>
                <td class="DataTable" id="colProm" nowrap><%=sTyPromSlsPrc%>%</td>
                <td class="DataTable" id="colProm" nowrap><%=sLyPromSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colClr" nowrap>$<%=sTyClrRet%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sLyClrRet%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sTyClrDisc%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sLyClrDisc%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sTyClrGrm%></td>
                <td class="DataTable" id="colClr" nowrap>$<%=sLyClrGrm%></td>
                <td class="DataTable" id="colClr" nowrap><%=sTyClrGrmPrc%>%</td>
                <td class="DataTable" id="colClr" nowrap><%=sLyClrGrmPrc%>%</td>
                <td class="DataTable" id="colClr" nowrap><%=sTyClrSlsPrc%>%</td>
                <td class="DataTable" id="colClr" nowrap><%=sLyClrSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colFur" nowrap>$<%=sTyFurRet%></td>
                <td class="DataTable" id="colFur" nowrap>$<%=sLyFurRet%></td>
                <td class="DataTable" id="colFur" nowrap>$<%=sTyFurGrm%></td>
                <td class="DataTable" id="colFur" nowrap>$<%=sLyFurGrm%></td>
                <td class="DataTable" id="colFur" nowrap><%=sTyFurGrmPrc%>%</td>
                <td class="DataTable" id="colFur" nowrap><%=sLyFurGrmPrc%>%</td>
                <td class="DataTable" id="colFur" nowrap><%=sTyFurSlsPrc%>%</td>
                <td class="DataTable" id="colFur" nowrap><%=sLyFurSlsPrc%>%</td>

                <th class="DataTable">&nbsp</th>
                <td class="DataTable" id="colTot" nowrap>$<%=sTyTotRet%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sLyTotRet%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sTyTotDisc%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sLyTotDisc%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sTyTotGrm%></td>
                <td class="DataTable" id="colTot" nowrap>$<%=sLyTotGrm%></td>
                <td class="DataTable" id="colTot" nowrap><%=sTyTotGrmPrc%>%</td>
                <td class="DataTable" id="colTot" nowrap><%=sLyTotGrmPrc%>%</td>
                <td class="DataTable1" nowrap><%=sTotal%></td>
              </tr>
            <%}%>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
  <p style="font-size:12px;">
    <b>Note:</b> Each Item is slotted in the appropriate column, based on the "cent ending" of the current (file) Store, or Chain Retail on the date of the transaction.
             <br>Then, is moved to appear in the appropriate column IF the item was 'On Sale' (had an authorized 'TEMP' sale price), on the date of the transaction.   
  <%
      long lEndTime = (new Date()).getTime();
      long lElapse = (lEndTime - lStartTime) / 1000;
      if (lElapse==0) lElapse = 1;
%>
  <p style="font-size:10px;">Elapse: <%=lElapse%> sec
 </body>
</html>
<%}%>