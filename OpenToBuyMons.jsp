<%@ page import="agedanalysis.OpenToBuyEOY, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDivName = request.getParameter("DIVNAME");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sDptName = request.getParameter("DPTNAME");
   String sClass = request.getParameter("CLASS");
   String sClsName = request.getParameter("CLSNAME");
   String sUCR = request.getParameter("UCR");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";
   if(sDivName == null) sDivName = "All Divisions";
   if(sDepartment == null) sDepartment = "ALL";
   if(sDptName == null) sDptName = "All Departments";
   if(sClass == null) sClass = "ALL";
   if(sClsName == null) sClsName = "All Classes";

   //System.out.println(sStore  + " " + sDivision + " " + sDepartment + " " + sClass );
   OpenToBuyEOY opnbuy = new OpenToBuyEOY(sStore, sDivision, sDepartment, sClass, sUCR, "Y");

    int iNumOfGrp = opnbuy.getNumOfGrp();
    String [] sGrp = opnbuy.getGrp();
    String [] sGrpName = opnbuy.getGrpName();
    String [] sBegInvA = opnbuy.getBegInvA();
    String [] sBegInvB = opnbuy.getBegInvA();
    String [] sBegVar = opnbuy.getBegVar();
    String [] sEndInvA = opnbuy.getEndInvA();
    String [] sEndInvB = opnbuy.getEndInvB();
    String [] sEndVar = opnbuy.getEndVar();
    String [] sLessA = opnbuy.getLessA();
    String [] sLessB = opnbuy.getLessB();
    String [] sLessVar = opnbuy.getLessVar();
    String [] sMosA = opnbuy.getMosA();
    String [] sMosB = opnbuy.getMosB();
    String [] sMosVar = opnbuy.getMosVar();
    String [] sOpnRcvA = opnbuy.getOpnRcvA();
    String [] sOpnRcvB = opnbuy.getOpnRcvB();
    String [] sOpnRcvVar = opnbuy.getOpnRcvVar();
    String [] sActSls = opnbuy.getActSls();
    String [] sActSlsVar = opnbuy.getActSlsVar();
    String [] sActMkd = opnbuy.getActMkd();
    String [] sActMkdVar = opnbuy.getActMkdVar();

    String sTotal = opnbuy.getTotal();
    String sTotBegInvA = opnbuy.getTotBegInvA();
    String sTotBegInvB = opnbuy.getTotBegInvA();
    String sTotBegVar = opnbuy.getTotBegVar();
    String sTotEndInvA = opnbuy.getTotEndInvA();
    String sTotEndInvB = opnbuy.getTotEndInvB();
    String sTotEndVar = opnbuy.getTotEndVar();
    String sTotLessA = opnbuy.getTotLessA();
    String sTotLessB = opnbuy.getTotLessB();
    String sTotLessVar = opnbuy.getTotLessVar();
    String sTotMosA = opnbuy.getTotMosA();
    String sTotMosB = opnbuy.getTotMosB();
    String sTotMosVar = opnbuy.getTotMosVar();
    String sTotOpnRcvA = opnbuy.getTotOpnRcvA();
    String sTotOpnRcvB = opnbuy.getTotOpnRcvB();
    String sTotOpnRcvVar = opnbuy.getTotOpnRcvVar();
    String sTotActSls = opnbuy.getTotActSls();
    String sTotActSlsVar = opnbuy.getTotActSlsVar();
    String sTotActMkd = opnbuy.getTotActMkd();
    String sTotActMkdVar = opnbuy.getTotActMkdVar();

    // history
    String [] sHGrp = opnbuy.getHGrp();
    String [] sHGrpName = opnbuy.getHGrpName();
    String [] sHBegInvA = opnbuy.getHBegInvA();
    String [] sHBegInvB = opnbuy.getHBegInvA();
    String [] sHBegVar = opnbuy.getHBegVar();
    String [] sHEndInvA = opnbuy.getHEndInvA();
    String [] sHEndInvB = opnbuy.getHEndInvB();
    String [] sHEndVar = opnbuy.getHEndVar();
    String [] sHLessA = opnbuy.getHLessA();
    String [] sHLessB = opnbuy.getHLessB();
    String [] sHLessVar = opnbuy.getHLessVar();
    String [] sHMosA = opnbuy.getHMosA();
    String [] sHMosB = opnbuy.getHMosB();
    String [] sHMosVar = opnbuy.getHMosVar();
    String [] sHOpnRcvA = opnbuy.getHOpnRcvA();
    String [] sHOpnRcvB = opnbuy.getHOpnRcvB();
    String [] sHOpnRcvVar = opnbuy.getHOpnRcvVar();
    String [] sHActSls = opnbuy.getHActSls();
    String [] sHActSlsVar = opnbuy.getHActSlsVar();
    String [] sHActMkd = opnbuy.getHActMkd();
    String [] sHActMkdVar = opnbuy.getHActMkdVar();

    String sHTotal = opnbuy.getHTotal();
    String sHTotBegInvA = opnbuy.getHTotBegInvA();
    String sHTotBegInvB = opnbuy.getHTotBegInvA();
    String sHTotBegVar = opnbuy.getHTotBegVar();
    String sHTotEndInvA = opnbuy.getHTotEndInvA();
    String sHTotEndInvB = opnbuy.getHTotEndInvB();
    String sHTotEndVar = opnbuy.getHTotEndVar();
    String sHTotLessA = opnbuy.getHTotLessA();
    String sHTotLessB = opnbuy.getHTotLessB();
    String sHTotLessVar = opnbuy.getHTotLessVar();
    String sHTotMosA = opnbuy.getHTotMosA();
    String sHTotMosB = opnbuy.getHTotMosB();
    String sHTotMosVar = opnbuy.getHTotMosVar();
    String sHTotOpnRcvA = opnbuy.getHTotOpnRcvA();
    String sHTotOpnRcvB = opnbuy.getHTotOpnRcvB();
    String sHTotOpnRcvVar = opnbuy.getHTotOpnRcvVar();
    String sHTotActSls = opnbuy.getHTotActSls();
    String sHTotActSlsVar = opnbuy.getHTotActSlsVar();
    String sHTotActMkd = opnbuy.getHTotActMkd();
    String sHTotActMkdVar = opnbuy.getHTotActMkdVar();


   opnbuy.disconnect();

   int iNumOfHst = sHGrp.length;

   String sByUCR = "Retail";
   if(sUCR.equals("C")) sByUCR = "Cost";
   else if(sUCR.equals("U")) sByUCR = "Unit";
 %>

<html>
<head>

<style>
     body { background:ivory;}
        a:link { color:blue; font-size:12px } a:visited { color:blue; font-size:12px }  a:hover { color:blue; font-size:12px }
        a.blue:link { color:blue; font-size:10px } a:visited { color:blue; font-size:10px }  a:hover { color:red; font-size:10px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#EfEfEf; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:white; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:Azure; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:SeaShell; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}
        td.DataTable3 {color:blue; cursor: hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right; text-decoration: underline;}


        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        button.Smallest {background:gainsboro; height: 18px; margin-top:5px; font-family:Arial;
                         font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
        div.dvPO { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1, startColorStr=MidnightBlue , endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px;
                   padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                   text-align:center;font-family:Arial; font-size:10px; }

        button.panel { font-size: 10px; font-weight: bold; color: white; background-color: brown;
                  width: 160px; text-align: center; padding: 3px;text-decoration: none;
                  filter: alpha(opacity=100,finishopacity=0,style=2,startX=10,startY=10,
                  finishX=200,finishY=200)}
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------

//---------------------------------------------------------
// on time of body load
//---------------------------------------------------------
function bodyLoad()
{
   window.focus();
}
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}

</SCRIPT>

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
  <div id="dvPO" class="dvPO"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Open To Buy Report - End of Month Inventory (<%=sByUCR%>)
        <br>Store: <%=sStore%>
        <br>Division: <%=sDivName%>&nbsp;&nbsp;&nbsp;
            Department: <%=sDptName%>&nbsp;&nbsp;&nbsp;
            Class: <%=sClsName%>
        </b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2">Month</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="5">Beginning<br>Inventory</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="5">Sales<br>Plan</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="5">Markdown<br>Of Sales</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="5">End of Year<br>Inventory</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="5">Open To<br>Receive</th>
        </tr>
        <tr>
          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Actual</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>

          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Actual</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>

          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Actual</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>

          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Actual</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>

          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Actual</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++) {%>
              <tr class="DataTable">
                <td class="DataTable1" nowrap><%=sGrpName[i]%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable"><%=sBegInvA[i]%></td>
                <td class="DataTable"><%=sBegInvB[i]%></td>
                <td class="DataTable"><%=sBegVar[i]%></td>
                <td class="DataTable"><%if( i < iNumOfHst) {%><%=sHBegInvB[i]%><%} else {%>&nbsp;<%}%></td>
                <td class="DataTable"><%if( i < iNumOfHst) {%><%=sHBegVar[i]%><%} else {%>&nbsp;<%}%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable"><%=sLessA[i]%></td>
                <td class="DataTable"><%=sLessB[i]%></td>
                <td class="DataTable"><%=sLessVar[i]%></td>
                <td class="DataTable"><%if( i <= iNumOfHst) {%><%=sActSls[i]%><%} else {%>&nbsp;<%}%></td>
                <td class="DataTable"><%if( i <= iNumOfHst) {%><%=sActSlsVar[i]%><%} else {%>&nbsp;<%}%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sMosA[i]%></td>
                <td class="DataTable"><%=sMosB[i]%></td>
                <td class="DataTable"><%=sMosVar[i]%></td>
                <td class="DataTable"><%if( i <= iNumOfHst) {%><%=sActMkd[i]%><%} else {%>&nbsp;<%}%></td>
                <td class="DataTable"><%if( i <= iNumOfHst) {%><%=sActMkdVar[i]%><%} else {%>&nbsp;<%}%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sEndInvA[i]%></td>
                <td class="DataTable"><%=sEndInvB[i]%></td>
                <td class="DataTable"><%=sEndVar[i]%></td>
                <td class="DataTable"><%if( i < iNumOfHst) {%><%=sHEndInvB[i]%><%} else {%>&nbsp;<%}%></td>
                <td class="DataTable"><%if( i < iNumOfHst) {%><%=sHEndVar[i]%><%} else {%>&nbsp;<%}%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sOpnRcvA[i]%></td>
                <td class="DataTable"><%=sOpnRcvB[i]%></td>
                <td class="DataTable"><%=sOpnRcvVar[i]%></td>
                <td class="DataTable"><%if( i < iNumOfHst) {%><%=sHOpnRcvB[i]%><%} else {%>&nbsp;<%}%></td>
                <td class="DataTable"><%if( i < iNumOfHst) {%><%=sHOpnRcvVar[i]%><%} else {%>&nbsp;<%}%></td>
             </tr>
          <%}%>
<!------------------- Company Total -------------------------------->
             <tr class="DataTable2">
                <td class="DataTable1"><%=sTotal%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable"><%=sTotBegInvA%></td>
                <td class="DataTable"><%=sTotBegInvB%></td>
                <td class="DataTable"><%=sTotBegVar%></td>
                <td class="DataTable"><%=sHTotBegInvB%></td>
                <td class="DataTable"><%=sHTotBegVar%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sTotLessA%></td>
                <td class="DataTable"><%=sTotLessB%></td>
                <td class="DataTable"><%=sTotLessVar%></td>
                <td class="DataTable"><%=sTotActSls%></td>
                <td class="DataTable"><%=sTotActSlsVar%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sTotMosA%></td>
                <td class="DataTable"><%=sTotMosB%></td>
                <td class="DataTable"><%=sTotMosVar%></td>
                <td class="DataTable"><%=sTotActMkd%></td>
                <td class="DataTable"><%=sTotActMkdVar%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sTotEndInvA%></td>
                <td class="DataTable"><%=sTotEndInvB%></td>
                <td class="DataTable"><%=sTotEndVar%></td>
                <td class="DataTable"><%=sHTotEndInvB%></td>
                <td class="DataTable"><%=sHTotEndVar%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable"><%=sTotOpnRcvA%></td>
                <td class="DataTable"><%=sTotOpnRcvB%></td>
                <td class="DataTable"><%=sTotOpnRcvVar%></td>
                <td class="DataTable"><%=sHTotOpnRcvB%></td>
                <td class="DataTable"><%=sHTotOpnRcvVar%></td>
             </tr>

      </table>
      <!----------------------- end of table ------------------------>
  </table>
  <p align="center">
    <button class="panel" onClick="window.close()"
       onMouseOver="this.style.background='#5e2217'" onMouseOut="this.style.background='brown'" >Close</button>
 </body>
</html>
