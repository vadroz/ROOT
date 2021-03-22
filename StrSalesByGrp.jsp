<%@ page import="java.util.*, java.text.*, payrollreports.BfSlsByGrp"%>
<%
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
   if(sSort == null){ sSort="STR"; }

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrSalesByGrp.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();

    BfSlsByGrp slsgrp = new BfSlsByGrp(sFrDate, sToDate, sSort, sUser);
    int iNumOfStr = slsgrp.getNumOfStr();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #e7e7e7; font-size:10px }
        tr.DataTable1 { background: LemonChiffon; font-size:10px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<SCRIPT language="JavaScript">
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpList"]);
}
//==============================================================================
// re-sort by
//==============================================================================
function resortBy(sort)
{
  var url = "StrSalesByGrp.jsp?"
       + "Sort=" + sort
       + "&FrDate=<%=sFrDate%>"
       + "&ToDate=<%=sToDate%>"

  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvEmpList" class="dvEmpList"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Store Sales by Group
      <br>From date: <%=sFrDate%> &nbsp;  &nbsp;
          To date: <%=sToDate%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <a href="StrSalesByGrpSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr class="DataTable">
          <th class="DataTable" rowspan=2>Store</th>
          <th class="DataTable" rowspan=2><a href="javascript: resortBy('TOTAL')">Total Sale</a></th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=2>Employee<br> # 1</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=2>Salary</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=2>Bike<br>Manager</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=2>Non-Sales<br>(excl non-coord sales<br>and coord sales)</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=2>Sales<br>(non-coord and cood sales)</th>
        </tr>
        <tr class="DataTable">
          <th class="DataTable"><a href="javascript: resortBy('NOEMP')">$</a></th>
          <th class="DataTable"><a href="javascript: resortBy('NOEMPPRC')">%</a></th>
          <th class="DataTable"><a href="javascript: resortBy('SALARY')">$</a></th>
          <th class="DataTable"><a href="javascript: resortBy('SALARYPRC')">%</a></th>
          <th class="DataTable"><a href="javascript: resortBy('BKMGR')">$</a></th>
          <th class="DataTable"><a href="javascript: resortBy('BKMGRPRC')">%</a></th>
          <th class="DataTable"><a href="javascript: resortBy('NONSLS')">$</a></th>
          <th class="DataTable"><a href="javascript: resortBy('NONSLSPRC')">%</a></th>
          <th class="DataTable"><a href="javascript: resortBy('SALES')">$</a></th>
          <th class="DataTable"><a href="javascript: resortBy('SALESPRC')">%</a></th>
        </tr>
     <!------------------------- Region --------------------------------------->
     <%for(int i=0; i < iNumOfStr; i++){
         slsgrp.setSlsAmt();
         String sStr = slsgrp.getStr();
         String [] sSlsAmt = slsgrp.getSlsAmt();
         String [] sSlsPrc = slsgrp.getSlsPrc();
     %>
        <tr class="DataTable">
           <td class="DataTable" nowrap><%=sStr%></td>
           <!-- ------------------- Stores --------------------------------------->
           <%for(int j=0; j < 6; j++){%>
               <%if(j > 0){%><th class="DataTable">&nbsp;</th><%}%>
               <td class="DataTable2" nowrap>$<%=sSlsAmt[j]%></td>
               <%if(j > 0){%><td class="DataTable2" nowrap><%=sSlsPrc[j]%>%</td><%}%>
           <%}%>
        </tr>
     <%}%>

     <!-- ======================= Totals ====================================-->
     <%
        slsgrp.setTotals();
        String sStr = slsgrp.getStr();
        String [] sSlsAmt = slsgrp.getSlsAmt();
        String [] sSlsPrc = slsgrp.getSlsPrc();
     %>
     <tr class="DataTable1">
       <td class="DataTable" nowrap><%=sStr%></td>

       <%for(int j=0; j < 6; j++){%>
          <%if(j > 0){%><th class="DataTable">&nbsp;</th><%}%>
             <td class="DataTable2" nowrap>$<%=sSlsAmt[j]%></td>
             <%if(j > 0){%><td class="DataTable2" nowrap><%=sSlsPrc[j]%>%</td><%}%>
       <%}%>
     </tr>
   </table>
    <!----------------------- end of table ---------------------------------->
  </table>
 </body>

</html>

<%slsgrp.disconnect();%>

<%}%>






