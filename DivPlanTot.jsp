<%@ page import="salesreport3.DivPlanTot, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";

   DivPlanTot setSls = new DivPlanTot(sDivision, sStore);

    int iNumOfGrp = setSls.getNumOfGrp();
    String [] sGrp = setSls.getGrp();
    String [] sGrpName = setSls.getGrpName();
    String [][] sPlan = setSls.getPlan();
    String [][] sSales = setSls.getSales();
    String [][] sVarPrc = setSls.getVarPrc();

    String [] sTotPlan = setSls.getTotPlan();
    String [] sTotSales = setSls.getTotSales();
    String [] sTotVarPrc = setSls.getTotVarPrc();

    setSls.disconnect();

    // populate group colomn name
    String sGrpColName = "Division";
    if(sStore.equals("ALL")) sGrpColName = "Store";
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }

        td.DataTable  { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; border-bottom: darkred solid 1px;
                        border-right: double darkred ; text-align:right;}

        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var Div = null;
var DivName = null;

//--------------- End of Global variables ----------------
function bodyLoad()
{
}

</SCRIPT>


</head>
<body onload="bodyLoad()">

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="left" width="300">&nbsp;
       <!--div id="dvForm" class="dvForm"></div-->
      </td>
<!-------------------------------------------------------------------->

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Division Plan Totals vs TY Sales
      <br>Store: <%=sStore%> &nbsp;&nbsp
          Div: <%=sDivision%> &nbsp;&nbsp
      </b>
      </td>
      <td ALIGN="left" width="500">&nbsp;</td>
     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP" colspan=3>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="DivPlanTotSel.jsp">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>


<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="3"><%=sGrpColName%></th>
          <th class="DataTable" colspan="36">Fiscal Periods</th>
        </tr>
        <tr>
         <%for(int i=0; i<12; i++) {%>
            <th class="DataTable" colspan="3"><%=(i+1)%></th>
          <%}%>
        </tr>
        <tr>
         <%for(int i=0; i<12; i++) {%>
            <th class="DataTable">Sales</th>
            <th class="DataTable">Plan</th>
            <th class="DataTable">Var</th>
          <%}%>
        </tr>

<!------------------------------- Data Detail --------------------------------->
        <%for(int i=0; i < iNumOfGrp; i++) {%>
           <tr class="DataTable">
             <td class="DataTable1" nowrap><%=sGrp[i] + " - " + sGrpName[i]%></td>

             <%for(int j=0; j < 12; j++) {%>
               <td class="DataTable">$<%=sSales[i][j]%></td>
               <td class="DataTable">$<%=sPlan[i][j]%></td>
               <td class="DataTable2" nowrap><%=sVarPrc[i][j]%>%</td>
             <%}%>

           </tr>
        <%}%>
<!------------------------------- Report Totals ------------------------------->

           <tr class="DataTable3">
             <td class="DataTable1" nowrap>Total</td>

             <%for(int j=0; j < 12; j++) {%>
               <td class="DataTable">$<%=sTotSales[j]%></td>
               <td class="DataTable">$<%=sTotPlan[j]%></td>
               <td class="DataTable2" nowrap><%=sTotVarPrc[j]%>%</td>
             <%}%>
<!------------------------------- End Report Totals --------------------------->
           </tr>

      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
