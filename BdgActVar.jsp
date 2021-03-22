<%@ page import="payrollreports.BdgActVar, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
    String sStore = request.getParameter("STORE");
    String sStrName = request.getParameter("STRNAME");
    String sFrWkend = request.getParameter("FRWKEND");
    String sToWkend = request.getParameter("TOWKEND");
    String sSort = request.getParameter("Sort");

    if(sSort==null) sSort="STR";


    Vector vStr = (Vector) session.getAttribute("STRLST");
    String [] sStrAlwLst = new String[ vStr.size()];
    Iterator iter = vStr.iterator();
    String sStrAllowed = session.getAttribute("STORE").toString();

    int iStrAlwLst = 0;
    boolean bAuth = false;
    if (!sStrAllowed.startsWith("ALL"))
    {
       while (iter.hasNext())
       {
          sStrAlwLst[iStrAlwLst] = (String) iter.next();
          if (!bAuth) {  bAuth = sStrAlwLst[iStrAlwLst].trim().equals(sStore.trim()); }
          iStrAlwLst++;
       }
       if (!bAuth) { response.sendRedirect("index.jsp"); }
    }

    BdgActVar bdgvar = new BdgActVar(sStore, sFrWkend, sToWkend, sSort);

    int iNumOfGrp = bdgvar.getNumOfGrp();

    String [] sGrp = bdgvar.getGrp();
    String [] sGrpName = bdgvar.getGrpName();

    String [] sBdgHrs = bdgvar.getBdgHrs();
    String [] sActHrs = bdgvar.getActHrs();
    String [] sHrsVar = bdgvar.getHrsVar();

    String [] sBdgAvg = bdgvar.getBdgAvg();
    String [] sActAvg = bdgvar.getActAvg();
    String [] sAvgVar = bdgvar.getAvgVar();

    String [] sBdgLabor = bdgvar.getBdgLabor();
    String [] sActLabor = bdgvar.getActLabor();
    String [] sLbrVar = bdgvar.getLbrVar();

    String [] sActWage = bdgvar.getActWage();

    String [] sBdgTot = bdgvar.getBdgTot();
    String [] sActTot = bdgvar.getActTot();
    String [] sVarTot = bdgvar.getVarTot();

    String [] sOverHrs = bdgvar.getOverHrs();
    String [] sOverAvg = bdgvar.getOverAvg();
    String [] sOverTot = bdgvar.getOverTot();
    String [] sOverMgmt = bdgvar.getOverMgmt();
    String [] sOverTmc = bdgvar.getOverTmc();

    String sNmTotBdgHrs = bdgvar.getNmTotBdgHrs();
    String sNmTotActHrs = bdgvar.getNmTotActHrs();
    String sNmTotHrsVar = bdgvar.getNmTotHrsVar();

    String sNmTotBdgAvg = bdgvar.getNmTotBdgAvg();
    String sNmTotActAvg = bdgvar.getNmTotActAvg();
    String sNmTotAvgVar = bdgvar.getNmTotAvgVar();

    String sNmTotBdgLabor = bdgvar.getNmTotBdgLabor();
    String sNmTotActLabor = bdgvar.getNmTotActLabor();
    String sNmTotLbrVar = bdgvar.getNmTotLbrVar();
    String sNmTotActWage = bdgvar.getNmTotActWage();

    String sNmTotBdgTot = bdgvar.getNmTotBdgTot();
    String sNmTotActTot = bdgvar.getNmTotActTot();
    String sNmTotVarTot = bdgvar.getNmTotVarTot();

    String sNmTotOverHrs = bdgvar.getNmTotOverHrs();
    String sNmTotOverAvg = bdgvar.getNmTotOverAvg();
    String sNmTotOverTot = bdgvar.getNmTotOverTot();
    String sNmTotOverMgmt = bdgvar.getNmTotOverMgmt();
    String sNmTotOverTmc = bdgvar.getNmTotOverTmc();

    //grand total
    String sGrandBdgHrs = bdgvar.getGrandBdgHrs();
    String sGrandActHrs = bdgvar.getGrandActHrs();
    String sGrandHrsVar = bdgvar.getGrandHrsVar();

    String sGrandBdgAvg = bdgvar.getGrandBdgAvg();
    String sGrandActAvg = bdgvar.getGrandActAvg();
    String sGrandAvgVar = bdgvar.getGrandAvgVar();

    String sGrandBdgLabor = bdgvar.getGrandBdgLabor();
    String sGrandActLabor = bdgvar.getGrandActLabor();
    String sGrandLbrVar = bdgvar.getGrandLbrVar();
    String sGrandActWage = bdgvar.getGrandActWage();

    String sGrandBdgTot = bdgvar.getGrandBdgTot();
    String sGrandActTot = bdgvar.getGrandActTot();
    String sGrandVarTot = bdgvar.getGrandVarTot();

    String sGrandOverHrs = bdgvar.getGrandOverHrs();
    String sGrandOverAvg = bdgvar.getGrandOverAvg();
    String sGrandOverTot = bdgvar.getGrandOverTot();
    String sGrandOverMgmt = bdgvar.getGrandOverMgmt();
    String sGrandOverTmc = bdgvar.getGrandOverTmc();
    String sFrom = bdgvar.getFrom();
    String sTo = bdgvar.getTo();

    String [] sSls = new String[iNumOfGrp];
    String [] sPlan = new String[iNumOfGrp];
    String [] sVar = new String[iNumOfGrp];
    String sTotSls = new String();
    String sTotPlan = new String();
    String sTotVar = new String();

    if(sStore.trim().equals("ALL"))
    {
       sSls = bdgvar.getSls();
       sPlan = bdgvar.getPlan();
       sVar = bdgvar.getVar();
       sTotSls = bdgvar.getTotSls();
       sTotPlan = bdgvar.getTotPlan();
       sTotVar = bdgvar.getTotVar();
    }

    bdgvar.disconnect();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: CornSilk;font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.DataTable21 {background: gray; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.sep {background: darkred;padding-top:0px; padding-bottom:0px; padding-left:0px;
                       padding-right:0px; font-size:2px}

        div.Prompt { position:absolute; background-attachment: scroll; border: black solid 2px;
              width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        tr.Small {font-family:Arial; font-size:10px; text-align:center;}
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>


<script name="javascript1.2">
var SelRow = 0;
var Store = "<%=sStore%>";
var StrName = "<%=sStrName%>"
var FrWkend = "<%=sFrom%>";
var ToWkend = "<%=sTo%>";
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   loadSelPanel();
}
//==============================================================================
// load selection panel
//==============================================================================
function loadSelPanel()
{
   var html = "<table width='100%'>"
     + "<tr><th colspan='4'><u>Select another weeks</u></th></tr>"
     + "<tr class='Small'><td>From:</td>"
        + "<td>"
        + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FRWKEND&#34;)'>&#60;</button>"
        + "<input class='Small' name='FRWKEND' size=10 maxlength=10 readonly>"
        + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;FRWKEND&#34;)'>&#62;</button></td>"
        + "<td>To: </td>"
        + "<td nowrap>"
        + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;TOWKEND&#34;)'>&#60;</button>"
        + "<input class='Small' name='TOWKEND' size=10 maxlength=10 readonly>"
        + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;TOWKEND&#34;)'>&#62;</button> - or -</td>"
     + "</tr>"
     + "<tr class='Small'>"
       + "<td colspan='4'>"
         + "<input class='Small' type='radio' name='SELDT' value='W' onClick='chgDateRange(this.value)'>Weeks&nbsp;&nbsp;&nbsp;"
         + "<input class='Small' type='radio' name='SELDT' value='M' onClick='chgDateRange(this.value)'>MTD&nbsp;&nbsp;&nbsp;"
         + "<input class='Small' type='radio' name='SELDT' value='Q' onClick='chgDateRange(this.value)'>QTD&nbsp;&nbsp;&nbsp;"
         + "<input class='Small' type='radio' name='SELDT' value='Y' onClick='chgDateRange(this.value)'>YTD&nbsp;&nbsp;&nbsp;"
       + "</td></tr>"
     + "<tr class='Small'>"
        + "<td colspan='4' ><button class='Small' name='Submit' onClick='sbmReport()'>Submit</button></td>"
     + "</tr>"

     + "</table>"
   document.all.Prompt.innerHTML = html;
   document.all.FRWKEND.value=FrWkend;
   document.all.TOWKEND.value=ToWkend;
}
//==============================================================================
// populate weekends
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// change date selection
//==============================================================================
function chgDateRange(type)
{
  if(type=="W")
  {
    document.all.FRWKEND.value=FrWkend;
    document.all.TOWKEND.value=ToWkend;
    document.all.Down[0].style.visibility="visible";
    document.all.Up[0].style.visibility="visible";
    document.all.Down[1].style.visibility="visible";
    document.all.Up[1].style.visibility="visible";
  }
  else if(type=="M")
  {
    document.all.FRWKEND.value="MTD";
    document.all.TOWKEND.value="MTD";
    document.all.Down[0].style.visibility="hidden";
    document.all.Up[0].style.visibility="hidden";
    document.all.Down[1].style.visibility="hidden";
    document.all.Up[1].style.visibility="hidden";
  }
  else if(type=="Q")
  {
    document.all.FRWKEND.value="QTD";
    document.all.TOWKEND.value="QTD";
    document.all.Down[0].style.visibility="hidden";
    document.all.Up[0].style.visibility="hidden";
    document.all.Down[1].style.visibility="hidden";
    document.all.Up[1].style.visibility="hidden";
  }
  else if(type=="Y")
  {
    document.all.FRWKEND.value="YTD";
    document.all.TOWKEND.value="YTD";
    document.all.Down[0].style.visibility="hidden";
    document.all.Up[0].style.visibility="hidden";
    document.all.Down[1].style.visibility="hidden";
    document.all.Up[1].style.visibility="hidden";
  }
}
//==============================================================================
// submit new report
//==============================================================================
function sbmReport()
{
   //STORE=3&STRNAME=HOUSTON%20-%20WESTHEIMER&FRWKEND=07/10/2005&TOWKEND=07/10/2005
   var url = "BdgActVar.jsp?STORE=" + Store
      + "&STRNAME=" + StrName
      + "&FRWKEND=" + document.all.FRWKEND.value
      + "&TOWKEND=" + document.all.TOWKEND.value
   //alert(url)
   window.location.href=url;
}
//==============================================================================
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Budget vs. Actual Variance
        <br>Store: <%=sStore%> - <%=sStrName%>
        <br><%if(sFrWkend.equals("MTD")) {%>
           Month-To-Date (<%=sFrom%> - <%=sTo%>)
            <%} else if(sFrWkend.equals("QTD")) {%>
                Quater-To-Date (<%=sFrom%> - <%=sTo%>)
            <%} else if(sFrWkend.equals("YTD")) {%>
               Year-To-Date (<%=sFrom%> - <%=sTo%>)
            <%} else {%>
              Weekendings: <%=sFrWkend%> - <%=sToWkend%>
            <%}%></B><br><br>

        <a href="../"><font color="red">Home</font></a>&#62;
        <a href="PrMonBdgSel.jsp"><font color="red">Week Selector</font></a>&#62;
       <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;

       <a href="BdgActVar.jsp?STORE=ALL&STRNAME=All Stores&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">All Stores</a>



<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable" rowspan="3">
               <%if(sStore.equals("ALL")) {%><a href="BdgActVar.jsp?Sort=STR&STORE=<%=sStore%>&STRNAME=All Stores&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">Store</a><%} else{%>Position<%}%></th>
           <th class="DataTable" rowspan="3">&nbsp;</th>
           <th class="DataTable" colspan="22">Explanation of Variance</th>
           <th class="DataTable" rowspan="3">&nbsp;&nbsp;&nbsp;</th>

           <%if(sStore.trim().equals("ALL")){%>
               <th class="DataTable" rowspan="3">Actual Sales<br>vs.<br>Plan Sales</th>
           <%}%>
         </tr>

         <tr  class="DataTable">
           <th class="DataTable" colspan="3"><%if(sStore.equals("ALL")) {%><a href="BdgActVar.jsp?Sort=HRS&STORE=<%=sStore%>&STRNAME=All Stores&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">Hours</a><%} else{%>Hours<%}%></th>
           <th class="DataTable" rowspan="2">&nbsp;</th>
           <th class="DataTable" colspan="3"><%if(sStore.equals("ALL")) {%><a href="BdgActVar.jsp?Sort=AVG&STORE=<%=sStore%>&STRNAME=All Stores&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">Average Wage</a><%} else{%>Average Wage<%}%></th>
           <th class="DataTable" rowspan="2">&nbsp;</th>
           <th class="DataTable" colspan="3"><%if(sStore.equals("ALL")) {%><a href="BdgActVar.jsp?Sort=LBR&STORE=<%=sStore%>&STRNAME=All Stores&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">Labor</a><%} else{%>Labor<%}%></th>
           <th class="DataTable" rowspan="2">&nbsp;</th>
           <th class="DataTable" colspan="3"><%if(sStore.equals("ALL")) {%><a href="BdgActVar.jsp?Sort=TOT&STORE=<%=sStore%>&STRNAME=All Stores&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">Total $'s</a><%} else{%>Total $'s<%}%></th>
           <th class="DataTable" rowspan="2">&nbsp;</th>
           <th class="DataTable" colspan="6"><%if(sStore.equals("ALL")) {%><a href="BdgActVar.jsp?Sort=VAR&STORE=<%=sStore%>&STRNAME=All Stores&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">Variance<br>Due To</a><%} else{%>Variance<br>Due To<%}%></th>
         </tr>

         <tr  class="DataTable">
           <th class="DataTable" >Budget</th>
           <th class="DataTable" >Actual</th>
           <th class="DataTable" >Var</th>

           <th class="DataTable" >Budget</th>
           <th class="DataTable" >Actual</th>
           <th class="DataTable" >Var</th>

           <th class="DataTable" >Budget</th>
           <th class="DataTable" >Actual</th>
           <th class="DataTable" >Var</th>

           <th class="DataTable" >Budget</th>
           <th class="DataTable" >Actual</th>
           <th class="DataTable" >Var</th>

           <th class="DataTable" >Hours</th>
           <th class="DataTable" >Avg.<br>Wage</th>
           <th class="DataTable" >Labor</th>
           <th class="DataTable" >Mgmt</th>
           <th class="DataTable" >TMC</th>
           <th class="DataTable">Total<br>Variance</th>



         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfGrp; i++ ){%>
         <tr id="trGroup" class="DataTable">
            <td class="DataTable1" nowrap><%if(sStore.equals("ALL")){%><%=sGrp[i] + " - " + sGrpName[i].substring(0, 5)%><%} else{%><%=sGrpName[i]%><%}%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sBdgHrs[i]%></td>
            <td class="DataTable2" nowrap><%=sActHrs[i]%></td>
            <td class="DataTable2" nowrap><%=sHrsVar[i]%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2<%if(!sStore.equals("ALL") && sGrp[i].trim().equals("MNGR")){%>1<%}%>" nowrap>
                <%if(sStore.equals("ALL") || !sGrp[i].trim().equals("MNGR")){%>$<%=sBdgAvg[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.equals("ALL") && sGrp[i].trim().equals("MNGR")){%>1<%}%>" nowrap>
                <%if(sStore.equals("ALL") || !sGrp[i].trim().equals("MNGR")){%>$<%=sActAvg[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.equals("ALL") && sGrp[i].trim().equals("MNGR")){%>1<%}%>" nowrap>
                <%if(sStore.equals("ALL") || !sGrp[i].trim().equals("MNGR")){%>$<%=sAvgVar[i]%><%} else{%>&nbsp;<%}%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2<%if(!sStore.equals("ALL") && !sGrp[i].trim().equals("BKBLD")){%>1<%}%>" nowrap>
                <%if(sStore.equals("ALL") || sGrp[i].trim().equals("BKBLD")){%>$<%=sBdgLabor[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.equals("ALL") && !sGrp[i].trim().equals("BKBLD")){%>1<%}%>" nowrap>
                <%if(sStore.equals("ALL") || sGrp[i].trim().equals("BKBLD")){%>$<%=sActLabor[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.equals("ALL") && !sGrp[i].trim().equals("BKBLD")){%>1<%}%>" nowrap>
                <%if(sStore.equals("ALL") || sGrp[i].trim().equals("BKBLD")){%>$<%=sLbrVar[i]%><%} else{%>&nbsp;<%}%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sBdgTot[i]%></td>
            <td class="DataTable2" nowrap>$<%=sActTot[i]%></td>
            <td class="DataTable2" nowrap>$<%=sVarTot[i]%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2<%if(!sStore.equals("ALL") && (sGrp[i].trim().equals("MNGR") || sGrp[i].trim().equals("TMC"))){%>1<%}%>" nowrap>
              <%if(sStore.equals("ALL") || !sGrp[i].trim().equals("MNGR") && !sGrp[i].trim().equals("TMC")){%>$<%=sOverHrs[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.equals("ALL") && (sGrp[i].trim().equals("MNGR") || sGrp[i].trim().equals("TMC"))){%>1<%}%>" nowrap>
               <%if(sStore.equals("ALL") || !sGrp[i].trim().equals("MNGR") && !sGrp[i].trim().equals("TMC")){%>$<%=sOverAvg[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.equals("ALL") && !sGrp[i].trim().equals("BKBLD")){%>1<%}%>" nowrap>
               <%if(sStore.equals("ALL") || sGrp[i].trim().equals("BKBLD")){%>$<%=sLbrVar[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.equals("ALL") && !sGrp[i].trim().equals("MNGR")){%>1<%}%>" nowrap>
               <%if(sStore.equals("ALL") || sGrp[i].trim().equals("MNGR")){%>$<%=sOverMgmt[i]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2<%if(!sStore.equals("ALL") && !sGrp[i].trim().equals("TMC")){%>1<%}%>" nowrap>
               <%if(sStore.equals("ALL") || sGrp[i].trim().equals("TMC")){%>$<%=sOverTmc[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2" nowrap>$<%=sOverTot[i]%></td>


            <th class="DataTable">
               <%if(sStore.equals("ALL")) {%><a target="_blank" href="BdgActVar.jsp?STORE=<%=sGrp[i]%>&STRNAME=<%=sGrpName[i]%>&FRWKEND=<%=sFrWkend%>&TOWKEND=<%=sToWkend%>">D</a><%} else {%>&nbsp;<%}%>
            </th>
            <%if(sStore.trim().equals("ALL")){%>
               <td class="DataTable2" nowrap>$<%=sVar[i]%></td>
            <%}%>
          </tr>
          <%if(!sStore.equals("ALL") && sGrp[i].trim().equals("MNGR")){%><tr><td class="sep" colspan=24>&nbsp;</td></tr><%}%>
       <%}%>
      <!-- ================== Non-Management Totals =========================== -->
      <%if(!sStore.equals("ALL")) {%>
        <tr id="trTot" class="DataTable1">
            <td class="DataTable1" nowrap>Non-Management Totals</td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sNmTotBdgHrs%></td>
            <td class="DataTable2" nowrap><%=sNmTotActHrs%></td>
            <td class="DataTable2" nowrap><%=sNmTotHrsVar%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sNmTotBdgAvg%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotActAvg%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotAvgVar%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sNmTotBdgLabor%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotActLabor%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotLbrVar%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sNmTotBdgTot%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotActTot%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotVarTot%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sNmTotOverHrs%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotOverAvg%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotLbrVar%></td>
            <td class="DataTable21" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap>$<%=sNmTotOverTmc%></td>
            <td class="DataTable2" nowrap>$<%=sNmTotOverTot%></td>
            <th class="DataTable">&nbsp;</th>
          </tr>
          <%}%>
          <tr><td class="sep" colspan=25>&nbsp;</td></tr>

          <!-- ====================== Grand Totals ========================= -->
        <tr id="trTot" class="DataTable2">
            <td class="DataTable1" nowrap>Grand Totals</td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sGrandBdgHrs%></td>
            <td class="DataTable2" nowrap><%=sGrandActHrs%></td>
            <td class="DataTable2" nowrap><%=sGrandHrsVar%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2<%if(!sStore.trim().equals("ALL")){%>1<%}%>" nowrap>
               <%if(sStore.trim().equals("ALL")){%>$<%=sGrandBdgAvg%><%} else {%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.trim().equals("ALL")){%>1<%}%>" nowrap>
               <%if(sStore.trim().equals("ALL")){%>$<%=sGrandActAvg%><%} else {%>&nbsp;<%}%></td>
            <td class="DataTable2<%if(!sStore.trim().equals("ALL")){%>1<%}%>" nowrap>
               <%if(sStore.trim().equals("ALL")){%>$<%=sGrandAvgVar%><%} else {%>&nbsp;<%}%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sGrandBdgLabor%></td>
            <td class="DataTable2" nowrap>$<%=sGrandActLabor%></td>
            <td class="DataTable2" nowrap>$<%=sGrandLbrVar%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sGrandBdgTot%></td>
            <td class="DataTable2" nowrap>$<%=sGrandActTot%></td>
            <td class="DataTable2" nowrap>$<%=sGrandVarTot%></td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sGrandOverHrs%></td>
            <td class="DataTable2" nowrap>$<%=sGrandOverAvg%></td>
            <td class="DataTable2" nowrap>$<%=sGrandLbrVar%></td>

            <td class="DataTable2" nowrap>$<%=sGrandOverMgmt%></td>
            <td class="DataTable2" nowrap>$<%=sGrandOverTmc%></td>
            <td class="DataTable2" nowrap>$<%=sGrandOverTot%></td>
            <th class="DataTable">&nbsp;</th>
            <%if(sStore.trim().equals("ALL")){%>
               <td class="DataTable2" nowrap>$<%=sTotVar%></td>
          <%}%>
          </tr>
       </table>
<!-- ======================================================================= -->
<p style="font-size:10px">* Actual and budget payroll hours and dollars exclude holiday,
 vacation, sick pay, bonuses.
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
