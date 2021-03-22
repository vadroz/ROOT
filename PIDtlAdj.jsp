<%@ page import="inventoryreports.PiDtlAdj, java.util.*, java.text.*"%>
<% String [] sStore = request.getParameterValues("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sVendor = request.getParameter("VENDOR");
   String sStyle = request.getParameter("STYLE");
   String sColor = request.getParameter("COLOR");
   String sSize = request.getParameter("SIZE");
   String sSortBy = request.getParameter("SORT");
   String sPiYearMo = request.getParameter("PICal");
   String sByChain = request.getParameter("BYCHAIN");

   if(sClass == null) sClass = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sVendor == null) sVendor = "ALL";
   if(sStyle == null) sStyle = "ALL";
   if(sColor == null) sColor = "ALL";
   if(sSize == null) sSize = "ALL";
   if(sSortBy == null) sSortBy = "GROUP";

   //System.out.println("sStyle=" + sStyle + "  Size=" + sSize);
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=PITopAdjDiffSel.jsp&APPL=ALL");
}
else
{
   String sUser = session.getAttribute("USER").toString();
   String sSortTitle = "Sort by";

   if(sSortBy.equals("GROUP")) sSortTitle = "Sorted by Cls/Ven/Sty";
   else if(sSortBy.equals("PHQTY")) sSortTitle = "Sorted by Physical Count Units";
   else if(sSortBy.equals("PHCST")) sSortTitle = "Sorted by Physical Count Cost";
   else if(sSortBy.equals("PHRET")) sSortTitle = "Sorted by Physical Count Retail";

   else if(sSortBy.equals("OHQTY")) sSortTitle = "Sorted by On Hand Units";
   else if(sSortBy.equals("OHCST")) sSortTitle = "Sorted by On Hand Cost";
   else if(sSortBy.equals("OHRET")) sSortTitle = "Sorted by On Hand Retail";

   else if(sSortBy.equals("ADQTY")) sSortTitle = "Sorted by Total Adjustment Units";
   else if(sSortBy.equals("ADCST")) sSortTitle = "Sorted by Total Adjustment Cost";
   else if(sSortBy.equals("ADRET")) sSortTitle = "Sorted by Total Adjustment Retail";

   //System.out.println(sClass + " " + sVendor + " " + sStyle + " " + sColor + " " + sSize
   //     + " " + sStore.length + " " + sByChain + " " + sSortBy);
   PiDtlAdj setPi = new PiDtlAdj(sClass, sVendor, sStyle, sColor, sSize,
      sStore,sPiYearMo.substring(0, 4), sPiYearMo.substring(4), sSortBy,  sByChain);

    int iNumOfItm = setPi.getNumOfItm();
    String [] sCls = setPi.getCls();
    String [] sVen = setPi.getVen();
    String [] sSty = setPi.getSty();
    String [] sClr = setPi.getClr();
    String [] sSiz = setPi.getSiz();
    String [] sItmDsc = setPi.getItmDsc();
    String [] sVenSty = setPi.getVenSty();
    String [] sVenName = setPi.getVenName();
    String [] sSku = setPi.getSku();
    String [] sUpc = setPi.getUpc();
    String [] sFRstDt = setPi.getFRstDt();

    String sStrJSA = setPi.getStrJSA();
    String sStrNameJSA = setPi.getStrNameJSA();

    // Physical Count
    String [] sPhQty = setPi.getPhQty();
    String [] sPhRet = setPi.getPhRet();
    String [] sPhCst = setPi.getPhCst();
    // Computer On Hand
    String [] sOhQty = setPi.getOhQty();
    String [] sOhRet = setPi.getOhRet();
    String [] sOhCst = setPi.getOhCst();
    // Adjustment
    String [] sAdQty = setPi.getAdQty();
    String [] sAdRet = setPi.getAdRet();
    String [] sAdCst = setPi.getAdCst();

    String [] sInit = setPi.getInit();
    String [] sSts = setPi.getSts();
    String [] sUpdByUsr = setPi.getUpdByUsr();
    String [] sUpdDate = setPi.getUpdDate();
    String [] sUpdTime = setPi.getUpdTime();
    String [] sComm = setPi.getComm();
    String [] sRet = setPi.getRet();
    String [] sClrNm = setPi.getClrNm();
    String [] sSizNm = setPi.getSizNm();
    String [] sAreaMaxAll = setPi.getAreaMaxAll();
    String [] sAreaMaxOk = setPi.getAreaMaxOk();
    String [] sAreaMaxCorr = setPi.getAreaMaxCorr();
    String [] sAreaMaxNoCorr = setPi.getAreaMaxNoCorr();
    String [] sAreaList = setPi.getAreaList();
    String [] sAreaMaxFin = setPi.getAreaMaxFin();
    String [] sAreaFinList = setPi.getAreaFinList();

    //--------------------------------------------------------------------------
    //------------------------ Report Totals ---------------------------------
    // Physical Count
    String sRepPhQty = setPi.getRepPhQty();
    String sRepPhRet = setPi.getRepPhRet();
    String sRepPhCst = setPi.getRepPhCst();
    // Computer On Hand
    String sRepOhQty = setPi.getRepOhQty();
    String sRepOhRet = setPi.getRepOhRet();
    String sRepOhCst = setPi.getRepOhCst();
    // Adjustment
    String sRepAdQty = setPi.getRepAdQty();
    String sRepAdRet = setPi.getRepAdRet();
    String sRepAdCst = setPi.getRepAdCst();
    //--------------------------------------------------------------------------

    setPi.disconnect();
    Date dYesterday = new Date(new Date().getTime() -  24 * 60 * 60 * 1000);
    SimpleDateFormat sdfUSA = new SimpleDateFormat("MM/dd/yyyy");
    String sYesterday = sdfUSA.format(dYesterday);
%>

<html>
<head>
<title>PI Adj Dtl</title>
<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:cornsilk; font-family:Arial; font-size:10px }
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
        td.DataTable3g { background: #ccffcc;  padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}
             
        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = new Array();
<%for(int i=0; i < sStore.length; i++){%>Store[<%=i%>] = "<%=sStore[i]%>";<%}%>
var SortBy = "<%=sSortBy%>";
var ByChain = "<%=sByChain%>";
var StrArr = [<%=sStrJSA%>];
var StrNameArr = [<%=sStrNameJSA%>];
var Vendor = "<%=sVendor%>";
//--------------- End of Global variables ----------------
function bodyLoad()
{
  var menuHtml = "Select Store: <select class='small' name='STORE'>"


  menuHtml += "<Option value='ALL'>All Store</Option>";
  for(var i=0; i < StrArr.length; i++)
  {
     menuHtml += "<Option value='" + StrArr[i] + "'>" + StrArr[i] + "-" + StrNameArr[i] + "</Option>";
  }
  menuHtml += "</select><br>"
    + "<button class='small' onclick='getStrDtl()'>Submit</button>";

  document.all.dvForm.innerHTML = menuHtml;
  document.all.dvForm.style.visibility="visible"

  // allow to enter Item status
  showItmSts();
}
//==============================================================================
// get Store Details
//==============================================================================
function showItmSts()
{
   var disp = "none";
   var cells = document.all.ItmSts;

   if(ByChain == "Y" && Vendor != "ALL" && Store.length == 1){ var disp = "block"; }

   for(var i=0; i < cells.length; i++)
   {
      cells[i].style.display = disp;
   }
}
//==============================================================================
// get Store Details
//==============================================================================
function getStrDtl()
{
  var selstr = document.all.STORE.options[document.all.STORE.selectedIndex].value;
  var url = "PIDtlAdj.jsp?STORE=" + selstr
          + "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=<%=sClass%>"
          + "&VENDOR=<%=sVendor%>"
          + "&STYLE=<%=sStyle%>"
          + "&SORT=" + SortBy
          + "&BYCHAIN=" + ByChain
          + "&PICal=<%=sPiYearMo%>";
  //alert(url);
  window.location.href = url;
}

//------------------------------------------------------------
// resort report by selected column
//------------------------------------------------------------
function reSort(sort)
{
  var url = "PIDtlAdj.jsp?"
          + "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=<%=sClass%>"
          + "&VENDOR=<%=sVendor%>"
          + "&STYLE=<%=sStyle%>"
          + "&SORT=" + sort
          + "&BYCHAIN=" + ByChain
          + "&PICal=<%=sPiYearMo%>";
  for(var i=0; i < Store.length; i++)
  {
     url += "&STORE=" + Store[i]
  }
  //alert(url);
  window.location.href = url;

}

//==============================================================================
// get report by Store
//==============================================================================
function getByStore(cls, ven, sty, clr, size)
{
  var url = "PIDtlAdj.jsp?"
  if(cls == null){
     url += "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=<%=sClass%>"
          + "&VENDOR=<%=sVendor%>"
          + "&STYLE=<%=sStyle%>"
  }
  else{
     url += "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=" + cls
          + "&VENDOR=" + ven
          + "&STYLE=" + sty
  }

  if(clr != null){ url += "&COLOR=" + clr + "&SIZE=" + size }

    url += "&SORT=<%=sSortBy%>"
          + "&BYCHAIN=N"
          + "&PICal=<%=sPiYearMo%>";
  for(var i=0; i < Store.length; i++)
  {
     url += "&STORE=" + Store[i]
  }
  //alert(url);
  window.location.href = url;

}

//==============================================================================
// get report by Store
//==============================================================================
function getByItem(str)
{
  var url = "PIDtlAdj.jsp?"
   url += "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
       + "&CLASS=<%=sClass%>"
       + "&VENDOR=<%=sVendor%>"
       + "&STYLE=<%=sStyle%>"
       + "&COLOR=ALL&SIZE=ALL"
       + "&SORT=<%=sSortBy%>"
       + "&BYCHAIN=Y"
       + "&PICal=<%=sPiYearMo%>"
       + "&STORE=" + str

  //alert(url);
  window.location.href = url;
}

//-------------------------------------------------------------
// show Item to clr/siz level
//-------------------------------------------------------------
function showItmDtl(cls, ven, sty)
{
  var url = "PIDtlAdj.jsp?"
      + "DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
      + "&CLASS=" + cls
      + "&VENDOR=" + ven
      + "&STYLE=" + sty
      + "&SORT=" + SortBy
      + "&BYCHAIN=" + ByChain
      + "&PICal=<%=sPiYearMo%>";
  for(var i=0; i < Store.length; i++)
  {
     url += "&STORE=" + Store[i]
  }

  //alert(url);
  window.location.href = url;
}
//-------------------------------------------------------------
// submit retreiving Item's Areas
//-------------------------------------------------------------
function getItemArea(cls, ven, sty, clr, size)
{
  var url = "PIRtvArea.jsp?STORE=" + Store
          + "&CLASS=" + cls
          + "&VENDOR=" + ven
          + "&STYLE=" + sty
          + "&PICal=<%=sPiYearMo%>"
  if(Vendor!="ALL")
  {
    url += "&COLOR=" + clr + "&SIZE=" + size
  }
  var MyWindowName = 'RtvItemArea';
  var MyWindowOptions =
   'width=350,height=150, left=280,top=180, toolbar=no, scrollbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=yes,menubar=no';

  //alert(url)
  window.open(url, MyWindowName, MyWindowOptions);
}
//==============================================================================
// Update Item Status
//==============================================================================
function updItemSts(arg, cls, ven, sty, clr, siz)
{
   var error = false;
   var msg = "";

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
   else { sbmItemSts(cls, ven, sty, clr, siz, init, comm, sts) }
}
//==============================================================================
// Update Item Status
//==============================================================================
function sbmItemSts(cls, ven, sty, clr, siz, init, comm, sts)
{
   var url = "PIItmStsSave.jsp?Store=<%=sStore[0]%>"
      + "&Class=" + cls
      + "&Vendor=" + ven
      + "&Style=" + sty
      + "&Color=" + clr
      + "&Size=" + siz
      + "&PICal=<%=sPiYearMo%>"
      + "&Init=" + init
      + "&Comm=" + comm
      + "&Status=" + sts
      + "&User=<%=sUser%>";

   //alert(url);
   // window.location.href=url;
   window.frame1.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
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
      <br>Physical Inventory Adjustment Detail Report
      <br>Store:
      <%String sComa = "";
        for(int i=0; i < sStore.length; i++) {%>
           <%=sComa%>
           <%if(i == sStore.length / 2 && sStore.length > 10){%><br><%}%>
           <%=sStore[i]%><%sComa=", ";%>
        <%}%>
        <%if(sStore.length > 1){%><br><%}%>
       &nbsp;&nbsp
          Div: <%=sDivision%> - <%=setPi.getDivName(sDivision)%>  &nbsp;&nbsp
          Dpt: <%=sDepartment%> - <%=setPi.getDptName(sDepartment)%> &nbsp;&nbsp
          Class: <%=sClass%> - <%=setPi.getClsName(sClass)%>
         <br><%=sSortTitle%></b>
      </td>
      <td ALIGN="left" width="500">&nbsp;</td>
     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP" colspan=3>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <font size="-1">This Page.
          &nbsp;&nbsp;&nbsp;&nbsp;
          </font>


<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <%if(sByChain.equals("Y") && sVendor.equals("ALL")){%>
               <th class="DataTable"  rowspan="2" nowrap>
                 <a href="javascript: reSort('GROUP')">Class-Ven-Sty</a></th>
          <%}
            else if(sByChain.equals("Y")){%>
               <th class="DataTable"  rowspan="2" nowrap>
                 <a href="javascript: reSort('GROUP')">Item Number</a></th>

          <%}
            else {%>
              <th class="DataTable"  rowspan="2" nowrap>
                   <a href="javascript: reSort('GROUP')">Store</a></th>
          <%}%>
          <%if(sByChain.equals("Y") && sStore.length == 1){%>
            <th class="DataTable"  rowspan="2">A<br>r<br>e<br>a</th>
          <%}%>
            <%if(sByChain.equals("Y")){%>
               <th class="DataTable"  rowspan="2">Item Description</th>
               <th class="DataTable"  rowspan="2">Vendor Name</th>
               <th class="DataTable"  rowspan="2">Color Name</th>
               <th class="DataTable"  rowspan="2">Size Name</th>
               <th class="DataTable"  rowspan="2">SKU</th>
               <th class="DataTable"  rowspan="2">UPC</th>
               <%if(sByChain.equals("Y") && !sVendor.equals("ALL")){%><th class="DataTable"  rowspan="2">First<br>Received<br>Date</th><%}%>
               <th class="DataTable"  rowspan="2">Chain<br>Retail</th>
            <%}%>

            <%if(sByChain.equals("Y")){%>
               <th class="DataTable"  rowspan="2"><a href="javascript: getByStore(null, null, null,null, null)">B<br>y<br><br>S<br>t<br>r</a></th>
               <th class="DataTable"  rowspan="2">A<br>l<br>l<br><br>S<br>t<br>r</th>
               <%if(!sStyle.equals("ALL")){%><th class="DataTable"  rowspan="2">H<br>i<br>s<br>t</th><%}%>
            <%}
              else {%><th class="DataTable"  rowspan="2">&nbsp;</th><%}%>

            <th class="DataTable" colspan="3">Physical Count</th>
            <th class="DataTable" rowspan="2">&nbsp;</th>
            <th class="DataTable" colspan="3">Computer On Hand</th>
            <th class="DataTable" rowspan="2">&nbsp;</th>
            <th class="DataTable" colspan="3">Total Adjustment</th>
            <th class="DataTable" id="ItmSts" rowspan="2">&nbsp;</th>
            <th class="DataTable" id="ItmSts" colspan="5">On 5% Area Recount List</th>
            <th class="DataTable" id="ItmSts" rowspan="2">&nbsp;</th>
            <th class="DataTable" id="ItmSts" colspan="2">Final Adjustments</th>
            <th class="DataTable" id="ItmSts" rowspan="2">&nbsp;</th>
            <th class="DataTable" id="ItmSts" colspan="5">Investigation Status</th>
        </tr>
        <tr>
            <th class="DataTable"><a href="javascript: reSort('PHQTY')">Units</a></th>
            <th class="DataTable"><a href="javascript: reSort('PHCST')">Cost</a></th>
            <th class="DataTable"><a href="javascript: reSort('PHRET')">Retail</a></th>

            <th class="DataTable"><a href="javascript: reSort('OHQTY')">Units</a></th>
            <th class="DataTable"><a href="javascript: reSort('OHCST')">Cost</a></th>
            <th class="DataTable"><a href="javascript: reSort('OHRET')">Retail</a></th>

            <th class="DataTable"><a href="javascript: reSort('ADQTY')">Units</a></th>
            <th class="DataTable"><a href="javascript: reSort('ADCST')">Cost</a></th>
            <th class="DataTable"><a href="javascript: reSort('ADRET')">Retail</a></th>

            <th class="DataTable" id="ItmSts" rowspan="1">Areas</th>
            <th class="DataTable" id="ItmSts" rowspan="1" nowrap>Ok</th>
            <th class="DataTable" id="ItmSts" rowspan="1" nowrap>Corr</th>
            <th class="DataTable" id="ItmSts" rowspan="1" nowrap>No Corr</th>
            <th class="DataTable" id="ItmSts" rowspan="1" nowrap>All</th>
            <th class="DataTable" id="ItmSts" rowspan="1">Areas</th>
            <th class="DataTable" id="ItmSts" rowspan="1" nowrap>All</th>
               
            <th class="DataTable" id="ItmSts">Initials&nbsp;</th>
            <th class="DataTable" id="ItmSts">Status</th>
            <th class="DataTable" id="ItmSts">Update</th>
            <th class="DataTable" id="ItmSts">Last Updated</th>
            <th class="DataTable" id="ItmSts">Comments</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++) {%>
            <tr class="DataTable">
              <%if(sByChain.equals("Y") && sVendor.equals("ALL")){%>
                  <td class="DataTable1" nowrap>
                    <a href="javascript: showItmDtl('<%=sCls[i]%>','<%=sVen[i]%>','<%=sSty[i]%>')">
                             <%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%></a></td>
              <%}
                else if(sByChain.equals("Y")){%>
                  <td class="DataTable" style="font-size:8px" nowrap>
                     <%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%>
                  </td>
              <%}
                else{%>
                  <td class="DataTable3" style="font-size:8px" nowrap><a href="javascript: getByItem('<%=sCls[i]%>')"><%=sCls[i]%></a></td>
              <%}%>

              <%if(sByChain.equals("Y") && sStore.length == 1){%>
                <th class="DataTable" id="i<%=sCls[i] + sVen[i] + sSty[i] + sClr[i] + sSiz[i]%>">
                    <a href="javascript: getItemArea('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', '<%=sClr[i]%>', '<%=sSiz[i]%>')">
                      A</a></th>
              <%}%>
                <%if(sByChain.equals("Y")){%>
                   <td class="DataTable1" nowrap><%=sItmDsc[i]%></td>
                   <td class="DataTable1" nowrap><%=sVenName[i]%></td>
                   <td class="DataTable1" nowrap><%=sClrNm[i]%></td>
                   <td class="DataTable1" nowrap><%=sSizNm[i]%></td>
                   <%if(!sVendor.equals("ALL")){%>
                       <td class="DataTable1" nowrap><%=sSku[i]%></td>
                       <td class="DataTable1" nowrap><%=sUpc[i]%></td>
                       <td class="DataTable1" nowrap><%=sFRstDt[i]%></td>
                   <%}
                     else {%>
                       <td class="DataTable1" nowrap>N/A</td>
                       <td class="DataTable1" nowrap>N/A</td>
                   <%}%>
                   <td class="DataTable1" nowrap><%=sRet[i]%></td>
                <%}%>

                <%if(sByChain.equals("Y")){%>
                    <th class="DataTable" >
                       <%if(sVendor.equals("ALL")){%>
                           <a href="javascript: getByStore('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', 'ALL', 'ALL')">S</a></th>
                       <%} else {%>
                           <a href="javascript: getByStore('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', '<%=sClr[i]%>', '<%=sSiz[i]%>')">S</a></th>
                       <%}%>
                <%} else {%><th class="DataTable">&nbsp;</th><%}%>


                <%if(sByChain.equals("Y")){%>
                    <th class="DataTable" >
                       <%if(sVendor.equals("ALL")){%>
                           <a href="PIStyleInv.jsp?Cls=<%=sCls[i]%>&Ven=<%=sVen[i]%>&Sty=<%=sSty[i]%>&PICal=<%=sPiYearMo%>">T</a></th>
                       <%} else {%>
                           <a href="PISkuInv.jsp?Sku=<%=sSku[i]%>&PICal=<%=sPiYearMo%>">T</a></th>
                       <%}%>
                <%}%>

                <%if(sByChain.equals("Y") && !sStyle.equals("ALL")){%>
                    <th class="DataTable" >
                        <a href="PIItmSlsHst.jsp?Sku=<%=sSku[i]%>&STORE=<%=sStore[0]%>&FromDate=01/01/0001&ToDate=12/31/2999&PICal=<%=sPiYearMo%>">H</a>
                    </th>
                <%}%>

                <td class="DataTable" nowrap><%=sPhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhRet[i]%></td>

                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap><%=sOhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sOhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sOhRet[i]%></td>

                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap><%=sAdQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sAdCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sAdRet[i]%></td>

                <% 
                   String sCellClr1 = ""; 
                   if(sAreaList[i] != null && !sAreaList[i].equals("")){sCellClr1 = "g"; }
                   String sCellClr2 = ""; 
                   if(sAreaFinList[i] != null && !sAreaFinList[i].equals("")){sCellClr2 = "g"; }
                %>
                <th class="DataTable" id="ItmSts">&nbsp;</th>
                <td class="DataTable1<%=sCellClr1%>" id="ItmSts" nowrap><a href="PiReCntArea.jsp?Store=<%=sStore[0]%>&PICal=<%=sPiYearMo%>&Top=5" target="_blank"><%=sAreaList[i]%></a></td>
                <td class="DataTable3<%=sCellClr1%>"" id="ItmSts" nowrap><%=sAreaMaxOk[i]%></td>
                <td class="DataTable3<%=sCellClr1%>"" id="ItmSts" nowrap><%=sAreaMaxCorr[i]%></td>
                <td class="DataTable3<%=sCellClr1%>"" id="ItmSts" nowrap><%=sAreaMaxNoCorr[i]%></td>
                <td class="DataTable3<%=sCellClr1%>"" id="ItmSts" nowrap><%=sAreaMaxAll[i]%></td>
                
                <th class="DataTable" id="ItmSts">&nbsp;</th>
                <td class="DataTable1<%=sCellClr2%>" id="ItmSts" nowrap><a href="PiStrAreaSkuEnt.jsp?Store=<%=sStore[0]%>&PICal=<%=sPiYearMo%>" target="_blank"><%=sAreaFinList[i]%></a></td>
                <td class="DataTable3<%=sCellClr2%>" id="ItmSts" nowrap><%=sAreaMaxFin[i]%></td>
                                
                <th class="DataTable" id="ItmSts">&nbsp;</th>
                <td class="DataTable" id="ItmSts" nowrap>
                   <input class="Small" name="Init<%=i%>" maxlength=10 size=10 value="<%=sInit[i]%>">
                </td>
                <td class="DataTable" id="ItmSts" nowrap>
                   <input class="Small" type="radio" name="Sts<%=i%>" value="R" <%if(sSts[i].equals("R")){%>checked<%}%>>Researching &nbsp;
                   <input class="Small" type="radio" name="Sts<%=i%>" value="C" <%if(sSts[i].equals("C")){%>checked<%}%>>Correction Submitted &nbsp;
                   <input class="Small" type="radio" name="Sts<%=i%>" value="V" <%if(sSts[i].equals("V")){%>checked<%}%>>Verified OK &nbsp;
                </td>
                <td class="DataTable" id="ItmSts" nowrap><a href="javascript: updItemSts('<%=i%>', '<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', '<%=sClr[i]%>', '<%=sSiz[i]%>')">update</a></td>
                <td class="DataTable" id="ItmSts" nowrap><%=sUpdByUsr[i]%> <%=sUpdDate[i]%> <%=sUpdTime[i]%></td>
                <td class="DataTable" id="ItmSts" nowrap>
                   <input class="Small" name="Comm<%=i%>" maxlength=30 size=10 value="<%=sComm[i]%>">
                </td>
              </tr>
           <%}%>
      <!------------------- Company Total -------------------------------->
       <tr><td class="DataTable3"></td></tr>
       <%
          String sColSpan = "1";
          if(sByChain.equals("Y") && sStore.length == 1 && !sVendor.equals("ALL")){ sColSpan = "10"; }
          else if(sByChain.equals("Y") && sStore.length == 1 && sVendor.equals("ALL")){ sColSpan = "9"; }
          else if(sByChain.equals("Y") && sStore.length > 1 && sVendor.equals("ALL")){ sColSpan = "8"; }
          else if(sByChain.equals("Y") && sStore.length > 1 && !sVendor.equals("ALL")){ sColSpan = "9"; }          
       %>
        <tr class="DataTable3">
            <td class="DataTable1" nowrap colspan="<%=sColSpan%>">Totals</td>
            <th class="DataTable">&nbsp;</a></th>
            <%if(sByChain.equals("Y")){%><th class="DataTable">&nbsp;</th> <%if(!sStyle.equals("ALL")){%><th class="DataTable">&nbsp;</th><%}%><%}%>

            <td class="DataTable" nowrap><%=sRepPhQty%></td>
            <td class="DataTable" nowrap>$<%=sRepPhCst%></td>
            <td class="DataTable" nowrap>$<%=sRepPhRet%></td>

            <th class="DataTable">&nbsp;</th>

            <td class="DataTable" nowrap><%=sRepOhQty%></td>
            <td class="DataTable" nowrap>$<%=sRepOhCst%></td>
            <td class="DataTable" nowrap>$<%=sRepOhRet%></td>

            <th class="DataTable">&nbsp;</th>

            <td class="DataTable" nowrap><%=sRepAdQty%></td>
            <td class="DataTable" nowrap>$<%=sRepAdCst%></td>
            <td class="DataTable" nowrap>$<%=sRepAdRet%></td>

            <th class="DataTable" id="ItmSts">&nbsp;</th>
            <td class="DataTable" id="ItmSts" colspan=15>&nbsp;</td>
        </tr>

      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%}%>