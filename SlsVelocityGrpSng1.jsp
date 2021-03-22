<%@ page import="salesvelocity.SlsVelocityGrp, rciutility.StoreSelect, java.util.*"%>
<%
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");
   String sFrWeek = request.getParameter("FrWeek");
   String sToWeek = request.getParameter("ToWeek");
   String [] sSelStr = request.getParameterValues("Str");

   SlsVelocityGrp slsVel = new SlsVelocityGrp(sSelCls, sSelVen, sSelSty, sSelStr
              , sFrWeek, sToWeek);
   int iNumOfItm = slsVel.getNumOfItm();

   int iNumOfStr = slsVel.getNumOfStr();
   String [] sStr = slsVel.getStr();
%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}

        th.DataTable  { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }


        tr.DataTable2  { background:#cccfff; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-top: double darkred; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}

        td.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }

        .Small {font-size:10px }
        select.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.dvForm { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>
<SCRIPT language="JavaScript1.2">

//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
}

</SCRIPT>

</head>
<body id="bdDtl" onload="bodyLoad()">

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <div style="clear: both; overflow: AUTO; width: 100%; height: 100%; POSITION: relative; color:black;" >

      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <thead>
        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable">Div<br>#</th>
          <th class="DataTable">Dpt<br>#</th>
          <th class="DataTable">Item<br>Number</th>
          <th class="DataTable">Item<br>Description</th>
          <th class="DataTable">Vendor<br>Name</th>
          <th class="DataTable">Chain<br>Retail</th>
          <th class="DataTable" colspan="2">WTD<br>Chain Sales</th>
          <th class="DataTable" colspan="2">Total Units</th>
          <th class="DataTable" colspan="<%=iNumOfStr + 1%>">Sales / Current Inventory by Store</th>
        </tr>

        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable" colspan=6>&nbsp;</th>
          <th class="DataTable" >Units</th>
          <th class="DataTable" >Retail</th>
          <th class="DataTable" >On<br>Hand</th>
          <th class="DataTable" >On<br>Order</th>

          <th class="DataTable" >&nbsp;</th>
          <%for(int i=0; i < iNumOfStr; i++) {%>
            <th class="DataTable" ><%=sStr[i]%></th>
          <%}%>
        </tr>
        </thead>
<!------------------------------- Data Detail --------------------------------->
           <%String sClass = null;
           boolean bOdd = true; %>
           <%for(int i=0; i < iNumOfItm; i++) {
              slsVel.setItems();
              String sDiv = slsVel.getDiv();
              String sDpt = slsVel.getDpt();
              String sCls = slsVel.getCls();
              String sVen = slsVel.getVen();
              String sSty = slsVel.getSty();
              String sClr = slsVel.getClr();
              String sSiz = slsVel.getSiz();
              String sChnRet = slsVel.getChnRet();
              String sDesc = slsVel.getDesc();
              String sVenName = slsVel.getVenName();
              String [] sOnhand = slsVel.getOnhand();
              String [] sTrans = slsVel.getTrans();
              String [] sSlsRet = slsVel.getSlsRet();
              String [] sSlsUnit = slsVel.getSlsUnit();
              String sTotOnhand = slsVel.getTotOnhand();
              String sTotTrans = slsVel.getTotTrans();
              String sTotSlsRet = slsVel.getTotSlsRet();
              String sTotSlsUnit = slsVel.getTotSlsUnit();
              boolean bCvs = slsVel.getCvs();
              String [] sExclTrn = slsVel.getExclTrn();
              String sTotExcl = slsVel.getTotExcl();
           %>

              <%if(bCvs) { sClass = "DataTable3";}
                else { sClass = "DataTable2";}%>

              <tr class=<%=sClass%> id="tr<%=sCls+sVen+sSty%>0">
                <td class="DataTable" rowspan="2"><%=sDiv%></td>
                <td class="DataTable" rowspan="2"><%=sDpt%></td>
                <td class="DataTable1" rowspan="2" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
                <td class="DataTable1" rowspan="2" nowrap><%=sDesc%></td>
                <td class="DataTable1" rowspan="2" nowrap><%=sVenName%></td>
                <td class="DataTable" rowspan="2"><%=sChnRet%></td>
                <td class="DataTable" rowspan="2"><%=sTotSlsUnit%></td>
                <td class="DataTable" rowspan="2"><%=sTotSlsRet%></td>
                <td class="DataTable" rowspan="2"><%=sTotOnhand%></td>
                <td class="DataTable" rowspan="2"><%=sTotTrans%></td>

                <td class="DataTable3" >Sales</td>
                  <%for(int j=0; j < iNumOfStr; j++) {%>
                      <td class="DataTable" ><%if(!sSlsUnit[j].equals("0")){%><%=sSlsUnit[j]%><%} else {%>&nbsp;<%}%></td>
                  <%}%>
              </tr>
              <tr class="<%=sClass%>">
                <td class="DataTable3">I</td>
                  <%for(int j=0; j < iNumOfStr; j++) {%>
                      <td class="DataTable" >
                        <span id="spIncl"><%if(!sOnhand[j].equals("0")){%><%=sOnhand[j]%><%} else {%>&nbsp;<%}%></span>
                        <span id="spExcl" style="display:none;"><%if(!sExclTrn[j].equals("0")){%><%=sExclTrn[j]%><%} else {%>&nbsp;<%}%></span>
                        <span id="spOnly" style="display:none;"><%if(!sTrans[j].equals("0")){%><%=sTrans[j]%><%} else {%>&nbsp;<%}%></span>
                      </td>
                  <%}%>
                </td>
              </tr>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
    </div>
 </body>
</html>
<%
slsVel.disconnect();
slsVel = null;
%>
<script>
  //html = document.all.bdDtl.innerHTML;
  //parent.setDtl(html);
</script>
