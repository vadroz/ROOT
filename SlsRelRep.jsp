<%@ page import="classreports.SlsRelRep, java.util.*"%>
<%
    String [] sFrom = request.getParameterValues("From");
    String [] sTo = request.getParameterValues("To");
    String sRepName = request.getParameter("RepName");
    String sSort = request.getParameter("Sort");
    String sTyLyF = request.getParameter("TyLyF");

    if(sSort==null) sSort = "STR";

    SlsRelRep slsRep = new SlsRelRep(sFrom, sTo, sSort, sTyLyF);
    int iNumOfStr = slsRep.getNumOfStr();

    String [] sStr = slsRep.getStr();
    String [] sFrWkUnt = slsRep.getFrWkUnt();
    String [] sFrWkRet = slsRep.getFrWkRet();
    String [] sToWkUnt = slsRep.getToWkUnt();
    String [] sToWkRet = slsRep.getToWkRet();

    String [] sFrMnUnt = slsRep.getFrMnUnt();
    String [] sFrMnRet = slsRep.getFrMnRet();
    String [] sToMnUnt = slsRep.getToMnUnt();
    String [] sToMnRet = slsRep.getToMnRet();

    String [] sFrYrUnt = slsRep.getFrYrUnt();
    String [] sFrYrRet = slsRep.getFrYrRet();
    String [] sToYrUnt = slsRep.getToYrUnt();
    String [] sToYrRet = slsRep.getToYrRet();

    // ratios
    String [] sWkUntVar = slsRep.getWkUntVar();
    String [] sWkRetVar = slsRep.getWkRetVar();
    String [] sMnUntVar = slsRep.getMnUntVar();
    String [] sMnRetVar = slsRep.getMnRetVar();
    String [] sYrUntVar = slsRep.getYrUntVar();
    String [] sYrRetVar = slsRep.getYrRetVar();

    //totals
    String sTotFrWkUnt = slsRep.getTotFrWkUnt();
    String sTotFrWkRet = slsRep.getTotFrWkRet();
    String sTotToWkUnt = slsRep.getTotToWkUnt();
    String sTotToWkRet = slsRep.getTotToWkRet();

    String sTotFrMnUnt = slsRep.getTotFrMnUnt();
    String sTotFrMnRet = slsRep.getTotFrMnRet();
    String sTotToMnUnt = slsRep.getTotToMnUnt();
    String sTotToMnRet = slsRep.getTotToMnRet();

    String sTotFrYrUnt = slsRep.getTotFrYrUnt();
    String sTotFrYrRet = slsRep.getTotFrYrRet();
    String sTotToYrUnt = slsRep.getTotToYrUnt();
    String sTotToYrRet = slsRep.getTotToYrRet();

    String sTotWkUntVar = slsRep.getTotWkUntVar();
    String sTotWkRetVar = slsRep.getTotWkRetVar();
    String sTotMnUntVar = slsRep.getTotMnUntVar();
    String sTotMnRetVar = slsRep.getTotMnRetVar();
    String sTotYrUntVar = slsRep.getTotYrUntVar();
    String sTotYrRetVar = slsRep.getTotYrRetVar();

    // from / to classes
    int iNumOfFrCls = slsRep.getNumOfFrCls();
    String [] sFrCls = slsRep.getFrCls();
    String [] sFrClsName = slsRep.getFrClsName();
    int iNumOfToCls = slsRep.getNumOfToCls();
    String [] sToCls = slsRep.getToCls();
    String [] sToClsName = slsRep.getToClsName();

    String sFromJSA = slsRep.cvtToJavaScriptArray(sFrom);
    String sToJSA = slsRep.cvtToJavaScriptArray(sTo);

    slsRep.disconnect();
 %>

<html>
<head>

<style>
     body { background:ivory;}
        a.blue:link { color:blue; font-size:12px } a.blue:visited { color:blue; font-size:12px }  a.blue:hover { color:red; font-size:12px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}


        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#EfEfEf; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var From = [<%=sFromJSA%>];
var To = [<%=sToJSA%>];
var RepName = "<%=sRepName%>";
//---------------------------------------------------------
// on time of body load
//---------------------------------------------------------
function bodyLoad()
{
}
//---------------------------------------------------------
// re-sort report by selected column
//---------------------------------------------------------
function sortReport(sort)
{
   var url = "SlsRelRep.jsp?RepName=" + RepName;

   for(var i=0; i < From.length; i++) {  url += "&From=" + From[i];  }
   for(var i=0; i < To.length; i++) {  url += "&To=" + To[i]; }
   url += "&Sort=" + sort
     + "&TyLyF=<%=sTyLyF%>";
  
   //alert(url);
   window.location.href = url;

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
  <div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Sales Relation Report
        <br><%=sRepName%> -
        <%if(sTyLyF.equals("0")) {%>This Year
        <%} else if(sTyLyF.equals("1")){%>Last Year "Year-To-Date"
        <%} else{%>Entire Last Year<%}%>

        </b>
        <br>
          <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="SlsRelSel.jsp?">
            <font color="red" size="-1">Selection</font></a>&#62;
          <font size="-1">This Page.</font>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="3"><a href="javascript:sortReport('STR')">Store</a></th>
          <th class="DataTable" rowspan="3">&nbsp;</th>
          <th class="DataTable" colspan="6">Week-To-Date</th>
          <th class="DataTable" rowspan="3">&nbsp;</th>
          <th class="DataTable" colspan="6">Month-To-Date</th>
          <th class="DataTable" rowspan="3">&nbsp;</th>
          <th class="DataTable" colspan="6">Year-To-Date</th>
        </tr>
        <tr>
           <th class="DataTable" colspan="3">Unit</th>
           <th class="DataTable" colspan="3">Retail</th>
           <th class="DataTable" colspan="3">Unit</th>
           <th class="DataTable" colspan="3">Retail</th>
           <th class="DataTable" colspan="3">Unit</th>
           <th class="DataTable" colspan="3">Retail</th>
        </tr>
        <tr>
          <th class="DataTable"><a href="javascript:sortReport('WKUNTFROM')" class="blue">From</a></th>
          <th class="DataTable"><a href="javascript:sortReport('WKUNTTO')" class="blue">To</a></th>
          <th class="DataTable"><a href="javascript:sortReport('WKUNTVAR')" class="blue">Ratio</a></th>

          <th class="DataTable"><a href="javascript:sortReport('WKRETFROM')" class="blue">From</a></th>
          <th class="DataTable"><a href="javascript:sortReport('WKRETTO')" class="blue">To</a></th>
          <th class="DataTable"><a href="javascript:sortReport('WKRETVAR')" class="blue">Ratio</a></th>

          <th class="DataTable"><a href="javascript:sortReport('MNUNTFROM')" class="blue">From</a></th>
          <th class="DataTable"><a href="javascript:sortReport('MNUNTTO')" class="blue">To</a></th>
          <th class="DataTable"><a href="javascript:sortReport('MNUNTVAR')" class="blue">Ratio</a></th>

          <th class="DataTable"><a href="javascript:sortReport('MNRETFROM')" class="blue">From</a></th>
          <th class="DataTable"><a href="javascript:sortReport('MNRETTO')" class="blue">To</a></th>
          <th class="DataTable"><a href="javascript:sortReport('MNRETVAR')" class="blue">Ratio</a></th>

          <th class="DataTable"><a href="javascript:sortReport('YRUNTFROM')" class="blue">From</a></th>
          <th class="DataTable"><a href="javascript:sortReport('YRUNTTO')" class="blue">To</a></th>
          <th class="DataTable"><a href="javascript:sortReport('YRUNTVAR')" class="blue">Ratio</a></th>

          <th class="DataTable"><a href="javascript:sortReport('YRRETFROM')" class="blue">From</a></th>
          <th class="DataTable"><a href="javascript:sortReport('YRRETTO')" class="blue">To</a></th>
          <th class="DataTable"><a href="javascript:sortReport('YRRETVAR')" class="blue">Ratio</a></th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfStr; i++) {%>
              <tr class="DataTable">
                <td class="DataTable2" nowrap><%=sStr[i]%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sFrWkUnt[i]%></td>
                <td class="DataTable"><%=sToWkUnt[i]%></td>
                <td class="DataTable"><%=sWkUntVar[i]%></td>
                <td class="DataTable">$<%=sFrWkRet[i]%></td>
                <td class="DataTable">$<%=sToWkRet[i]%></td>
                <td class="DataTable"><%=sWkRetVar[i]%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sFrMnUnt[i]%></td>
                <td class="DataTable"><%=sToMnUnt[i]%></td>
                <td class="DataTable"><%=sMnUntVar[i]%></td>
                <td class="DataTable">$<%=sFrMnRet[i]%></td>
                <td class="DataTable">$<%=sToMnRet[i]%></td>
                <td class="DataTable"><%=sMnRetVar[i]%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sFrYrUnt[i]%></td>
                <td class="DataTable"><%=sToYrUnt[i]%></td>
                <td class="DataTable"><%=sYrUntVar[i]%></td>
                <td class="DataTable">$<%=sFrYrRet[i]%></td>
                <td class="DataTable">$<%=sToYrRet[i]%></td>
                <td class="DataTable"><%=sYrRetVar[i]%></td>
             </tr>
          <%}%>
<!------------------- Company Total -------------------------------->
          <tr class="DataTable1">
             <td class="DataTable">Total</td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable"><%=sTotFrWkUnt%></td>
             <td class="DataTable"><%=sTotToWkUnt%></td>
             <td class="DataTable"><%=sTotWkUntVar%></td>
             <td class="DataTable">$<%=sTotFrWkRet%></td>
             <td class="DataTable">$<%=sTotToWkRet%></td>
             <td class="DataTable"><%=sTotWkRetVar%></td>
             <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sTotFrMnUnt%></td>
                <td class="DataTable"><%=sTotToMnUnt%></td>
                <td class="DataTable"><%=sTotMnUntVar%></td>
                <td class="DataTable">$<%=sTotFrMnRet%></td>
                <td class="DataTable">$<%=sTotToMnRet%></td>
                <td class="DataTable"><%=sTotMnRetVar%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sTotFrYrUnt%></td>
                <td class="DataTable"><%=sTotToYrUnt%></td>
                <td class="DataTable"><%=sTotYrUntVar%></td>
                <td class="DataTable">$<%=sTotFrYrRet%></td>
                <td class="DataTable">$<%=sTotToYrRet%></td>
                <td class="DataTable"><%=sTotYrRetVar%></td>
           </tr>
      </table>
      <!----------------------- end of table ------------------------>
      </td>
     </tr>
     <tr>
       <td ALIGN="Center" VALIGN="TOP" colspan=3>
         <br><br>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
          <tr>
             <th class="DataTable" colspan="5">Selected Classes</th>
            <tr>
           <tr>
             <th class="DataTable" colspan="2">From</th>
             <th class="DataTable" rowspan="3">&nbsp;</th>
             <th class="DataTable" colspan="2">To</th>
            <tr>
            <tr>
             <th class="DataTable">Classes</th>
             <th class="DataTable">Class Names</th>
             <th class="DataTable">Classes</th>
             <th class="DataTable">Class Names</th>
            <tr>
            <!------------------------------- Data Detail --------------------------------->
           <%
              int iMax = iNumOfFrCls;
              if(iNumOfFrCls < iNumOfToCls) iMax = iNumOfToCls;
           %>
           <%for(int i=0; i < iMax; i++) {%>
              <tr class="DataTable">
                <td class="DataTable" nowrap><%if(i < iNumOfFrCls) {%><%=sFrCls[i]%><%}%>&nbsp;</td>
                <td class="DataTable1" nowrap><%if(i < iNumOfFrCls) {%><%=sFrClsName[i]%><%}%>&nbsp;</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" nowrap><%if(i < iNumOfToCls) {%><%=sToCls[i]%><%}%>&nbsp;</td>
                <td class="DataTable1" nowrap><%if(i < iNumOfToCls) {%><%=sToClsName[i]%><%}%>&nbsp;</td>
           <%}%>
          </table>
       </td>
     </tr>
  </table>
 </body>
</html>
