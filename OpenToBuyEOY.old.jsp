<%@ page import="agedanalysis.OpenToBuyEOY, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDivName = request.getParameter("DIVNAME");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sDptName = request.getParameter("DPTNAME");
   String sClass = request.getParameter("CLASS");
   String sClsName = request.getParameter("CLSNAME");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";
   if(sDivName == null) sDivName = "All Divisions";
   if(sDepartment == null) sDepartment = "ALL";
   if(sDptName == null) sDptName = "All Departments";
   if(sClass == null) sClass = "ALL";
   if(sClsName == null) sClsName = "All Classes";

   //System.out.println(sStore  + " " + sDivision + " " + sDepartment + " " + sClass );
   OpenToBuyEOY opnbuy = new OpenToBuyEOY(sStore, sDivision, sDepartment, sClass, "N");

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


   opnbuy.disconnect();

   String sColName = "Division";
   if(!sClass.trim().equals("ALL")) sColName = "Class";
   else if(!sDepartment.trim().equals("ALL")) sColName = "Class";
   else if(!sDivision.trim().equals("ALL")) sColName = "Department";
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
//report parameters
var Store = "<%=sStore%>";
var Division = "<%=sDivision%>";
var DivName = "<%=sDivName%>";
var Department = "<%=sDepartment%>";
var DptName = "<%=sDptName%>";
var Class = "<%=sClass%>";
var ClsName = "<%=sClsName%>";

var SelGrp = null;
var SelGrpType = null;

//---------------------------------------------------------
// on time of body load
//---------------------------------------------------------
function bodyLoad()
{
   // activate move box
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
}
//---------------------------------------------------------
// drill Down to next level
//---------------------------------------------------------
function drillDown(grp, grpName, grpType)
{
   var url = "OpenToBuyEOY.jsp?"
      + "STORE=" + Store

      if(grpType=="Division")
      {
         url += "&DIVISION=" + grp + "&DIVNAME=" + grp + " - " + grpName
              + "&DEPARTMENT=" + Department + "&DPTNAME=" + DptName
              + "&CLASS=" + Class + "&CLSNAME=" + ClsName
      }
      else if(grpType=="Department")
      {
         url += "&DIVISION=" + Division + "&DIVNAME=" + DivName
              + "&DEPARTMENT=" + grp + "&DPTNAME=" + grp + " - " + grpName
              + "&CLASS=" + Class  + "&CLSNAME=" + ClsName
      }
      else if(grpType=="Class")
      {
         url += "&DIVISION=" + Division + "&DIVNAME=" + DivName
              + "&DEPARTMENT=" + Department + "&DPTNAME=" + DptName
              + "&CLASS=" + grp + "&CLSNAME=" + grp + " - " + grpName
      }

   //alert(url);
   window.location.href = url;
}
//---------------------------------------------------------
// show selected record by month
//---------------------------------------------------------
function getOTBbyMonth(grp, grpName, grpType)
{
   grp = grp.trim();
   SelGrp = grp;
   SelGrpType = grpType

   var WindowName = 'OtbEoMInv';
   var WindowOptions =
   'width=950,height=500, left=100,top=50, resizable=yes , toolbar=no, location=yes, directories=no, status=yes, scrollbars=yes,menubar=no';

   var url = "OpenToBuyMons.jsp?"
      + "STORE=" + Store

   if(grpType=="Division")
   {
     url += "&DIVISION=" + grp + "&DIVNAME=" + grp + " - " + grpName.trim()
         + "&DEPARTMENT=" + Department + "&DPTNAME=" + DptName.trim()
         + "&CLASS=" + Class + "&CLSNAME=" + ClsName.trim()
   }
   else if(grpType=="Department")
   {
     url += "&DIVISION=" + Division + "&DIVNAME=" + DivName.trim()
         + "&DEPARTMENT=" + grp + "&DPTNAME=" + grp + " - " + grpName.trim()
         + "&CLASS=" + Class  + "&CLSNAME=" + ClsName.trim()
   }
   else if(grpType=="Class")
   {
      url += "&DIVISION=" + Division + "&DIVNAME=" + DivName.trim()
          + "&DEPARTMENT=" + Department + "&DPTNAME=" + DptName.trim()
          + "&CLASS=" + grp + "&CLSNAME=" + grp + " - " + grpName.trim()
   }


   //alert(url);
   window.open(url, WindowName, WindowOptions);
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

<script LANGUAGE="JavaScript1.2" src="FormatNumerics.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


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
        <br>Open To Buy Report - End of Year Inventory
        <br>Store: <%=sStore%>
        <br>Division: <%=sDivName%>&nbsp;&nbsp;&nbsp;
            Department: <%=sDptName%>&nbsp;&nbsp;&nbsp;
            Class: <%=sClsName%>
        </b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>


      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="OpenToBuyEOYSel.jsp?mode=1">
            <font color="red" size="-1">Open to Buy EOY Selection</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2"><%=sColName%></th>
          <th class="DataTable" rowspan="2">M<br>o<br>n<br>t<br>h</th>
          <th class="DataTable" colspan="3">Beginning<br>Inventory</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="3">Sales<br>Plan</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="3">Markdown<br>Of Sales</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="3">End of Year<br>Inventory</th>
          <th class="DataTable" rowspan="2">&nbsp;</th>
          <th class="DataTable" colspan="3">Open To<br>Receive</th>
        </tr>
        <tr>
          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
          <th class="DataTable">Plan A</th>
          <th class="DataTable">Plan B</th>
          <th class="DataTable">&nbsp;Var&nbsp;</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++) {%>
              <tr class="DataTable">
              <%if(!sColName.equals("Class")) {%>
                  <td class="DataTable1" rowspan="2" nowrap><a href="javascript: drillDown('<%=sGrp[i]%>', '<%=sGrpName[i]%>', '<%=sColName%>')" class="blue"><%=sGrp[i] + " - " + sGrpName[i]%></a><br>&nbsp;&nbsp;&nbsp;History ----></td>
              <%}
                else  {%>
                  <td class="DataTable1" rowspan="2"  nowrap><%=sGrp[i] + " - " + sGrpName[i]%><br>&nbsp;&nbsp;&nbsp;History ----></td>
              <%}%>
                <th class="DataTable" rowspan="2"><a href="javascript: getOTBbyMonth('<%=sGrp[i]%>', '<%=sGrpName[i]%>', '<%=sColName%>')" class="blue">M</a></th>
                <td class="DataTable"><%=sBegInvA[i]%></td>
                <td class="DataTable"><%=sBegInvB[i]%></td>
                <td class="DataTable"><%=sBegVar[i]%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sLessA[i]%></td>
                <td class="DataTable"><%=sLessB[i]%></td>
                <td class="DataTable"><%=sLessVar[i]%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sMosA[i]%></td>
                <td class="DataTable"><%=sMosB[i]%></td>
                <td class="DataTable"><%=sMosVar[i]%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sEndInvA[i]%></td>
                <td class="DataTable"><%=sEndInvB[i]%></td>
                <td class="DataTable"><%=sEndVar[i]%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sOpnRcvA[i]%></td>
                <td class="DataTable"><%=sOpnRcvB[i]%></td>
                <td class="DataTable"><%=sOpnRcvVar[i]%></td>
             </tr>
             <tr class="DataTable3">
                <td class="DataTable"><%=sHBegInvA[i]%></td>
                <td class="DataTable"><%=sHBegInvB[i]%></td>
                <td class="DataTable"><%=sHBegVar[i]%></td>

                <td class="DataTable"><%=sHLessA[i]%></td>
                <td class="DataTable"><%=sHLessB[i]%></td>
                <td class="DataTable"><%=sHLessVar[i]%></td>

                <td class="DataTable"><%=sHMosA[i]%></td>
                <td class="DataTable"><%=sHMosB[i]%></td>
                <td class="DataTable"><%=sHMosVar[i]%></td>

                <td class="DataTable"><%=sHEndInvA[i]%></td>
                <td class="DataTable"><%=sHEndInvB[i]%></td>
                <td class="DataTable"><%=sHEndVar[i]%></td>

                <td class="DataTable"><%=sHOpnRcvA[i]%></td>
                <td class="DataTable"><%=sHOpnRcvB[i]%></td>
                <td class="DataTable"><%=sHOpnRcvVar[i]%></td>
             </tr>
          <%}%>
<!------------------- Company Total -------------------------------->
             <tr class="DataTable2">
                <td class="DataTable1" rowspan="2"><%=sTotal%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sTotBegInvA%></td>
                <td class="DataTable"><%=sTotBegInvB%></td>
                <td class="DataTable"><%=sTotBegVar%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sTotLessA%></td>
                <td class="DataTable"><%=sTotLessB%></td>
                <td class="DataTable"><%=sTotLessVar%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sTotMosA%></td>
                <td class="DataTable"><%=sTotMosB%></td>
                <td class="DataTable"><%=sTotMosVar%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sTotEndInvA%></td>
                <td class="DataTable"><%=sTotEndInvB%></td>
                <td class="DataTable"><%=sTotEndVar%></td>
                <th class="DataTable" rowspan="2">&nbsp;</th>
                <td class="DataTable"><%=sTotOpnRcvA%></td>
                <td class="DataTable"><%=sTotOpnRcvB%></td>
                <td class="DataTable"><%=sTotOpnRcvVar%></td>
             </tr>
             <tr class="DataTable4">
                <td class="DataTable"><%=sHTotBegInvA%></td>
                <td class="DataTable"><%=sHTotBegInvB%></td>
                <td class="DataTable"><%=sHTotBegVar%></td>

                <td class="DataTable"><%=sHTotLessA%></td>
                <td class="DataTable"><%=sHTotLessB%></td>
                <td class="DataTable"><%=sHTotLessVar%></td>

                <td class="DataTable"><%=sHTotMosA%></td>
                <td class="DataTable"><%=sHTotMosB%></td>
                <td class="DataTable"><%=sHTotMosVar%></td>

                <td class="DataTable"><%=sHTotEndInvA%></td>
                <td class="DataTable"><%=sHTotEndInvB%></td>
                <td class="DataTable"><%=sHTotEndVar%></td>

                <td class="DataTable"><%=sHTotOpnRcvA%></td>
                <td class="DataTable"><%=sHTotOpnRcvB%></td>
                <td class="DataTable"><%=sHTotOpnRcvVar%></td>
             </tr>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
