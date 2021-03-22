<%@ page import="java.util.*, java.text.SimpleDateFormat, rciutility.RunSQLStmt, java.sql.*, java.text.*"%>
<%
   String sWkend = request.getParameter("Wkend");
   String sMinVar = request.getParameter("MinVar");

   String sSelWkend = null;

   if(sWkend == null){ sWkend = "current date"; sSelWkend = sWkend;}
   else { sSelWkend = "'" + sWkend.trim() + "'";}

   if(sMinVar == null){ sMinVar = "5"; }

   //===========================================================================
   // check last date
   //===========================================================================
   String sPrepStmt = "with sumf as ("
     + "select gbstr, gbgrp, bgName, gbbhrs, gbbpay,"
     + " dec(sum(dec( buavg * gbbhrs,9,0)),9,0) as amt"
     + " from rci.prgrpbdg inner join rci.fsyper on gbwken = piwe"
     + " and pida =" + sSelWkend
     + " left join rci.prbgbrk on bustr = gbstr and buyear=pyr#"
     + " and bumonth=pmo# and bugrp = gbgrp"
     + " inner join rci.BDGGROUP on bggrp=gbgrp"
     + " group by gbstr, gbgrp, bgname, gbbhrs, gbbpay"
     + " order by gbstr, gbgrp"
     + ")"
     + " select gbstr, gbgrp, bgname, gbbhrs, gbbpay, dec(gbbpay/gbbhrs,9,2) as bgavg,amt,"
     + " gbbpay - amt as var"
     + " from sumf"
     + " where abs(gbbpay - amt) >= " + sMinVar.trim()
     + " order by gbstr, gbgrp";

   System.out.println(sPrepStmt);
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();

   //============== Week array =====================================
   sPrepStmt = "select piwe from rci.fsyper"
      + " where piwe >= current date - 70 days and piwe <= current date + 70 days"
      + " and pida=piwe";
   RunSQLStmt sqlWeek = new RunSQLStmt();
   sqlWeek.setPrepStmt(sPrepStmt);
   sqlWeek.runQuery();
   String sWeekJsa = "";
   String sComa = "";
   while(sqlWeek.readNextRecord())
   {
      sWeekJsa += sComa + "\"" + sqlWeek.getData("piwe") + "\"";
      sComa = ",";
   }
   sqlWeek.disconnect();

   //============== Current Date =====================================
   sPrepStmt = "select piwe from rci.fsyper"
      + " where pida = current date";
   RunSQLStmt sqlCurr = new RunSQLStmt();
   sqlCurr.setPrepStmt(sPrepStmt);
   sqlCurr.runQuery();
   String sCurDate = null;
   if(sqlCurr.readNextRecord())
   {
      sCurDate = sqlCurr.getData("piwe");
   }
   sqlCurr.disconnect();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable0 { background: red; font-size:12px }
        tr.DataTable1 { background: CornSilk; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        .Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSelect { position:absolute; background-attachment: scroll; top:0px; left:0px;
              border: black solid 2px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>

<html>
<head><Meta http-equiv="refresh"></head>
<script language="javascript">
var Week = [<%=sWeekJsa%>];
var CurDate = "<%=sCurDate%>";

//==============================================================================
// initilize on loading
//==============================================================================
function bodyload()
{
   setWeek();
}
//==============================================================================
// set week in drop down menu
//==============================================================================
function setWeek()
{
   var curr = 0;
   var wkend = document.all.Wkend;

   for(var i=0; i < Week.length; i++)
   {
      wkend.options[i] = new Option(Week[i], Week[i]);
      if(CurDate==Week[i]){ curr = i; }
   }
   document.all.Wkend.selectedIndex=curr;
}

//==============================================================================
// submit report
//==============================================================================
function sbmReport()
{
   var url = "BgWkVar.jsp?"
      + "Wkend=" + document.all.Wkend.options[document.all.Wkend.selectedIndex].value
      + "&MinVar=" + document.all.MinVar.value;
   //alert(url);
   window.location.href=url;
}
</script>


<body onload="bodyload()">
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
        <br>Weekly Budget Variance Report
        <br>Date: <%=sWkend%> &nbsp; Minimum Variance: $<%=sMinVar%>
      </b>

      <br>

      <div id="dvSelect" class="dvSelect">
      <table border=0  cellPadding="0" cellSpacing="0">
        <tr class="Small" align="left">
          <th>Select Date:</th>
          <td> &nbsp; <select name="Wkend" class="Small"></select></td>
        </tr>
        <tr class="Small" align="left">
          <th>Select Minimum Amount:</th>
          <td> &nbsp; <input name="MinVar" class="Small" value="<%=sMinVar%>" size=3 maxlength=3></td>
        </tr>
        <tr class="Small">
          <td colspan=2 align="center"><button class="Small" onclick="sbmReport()">Submit</button></td>
        </tr>
      </table>
      </div>

      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan=2>Store</th>
          <th class="DataTable" rowspan=2>Budget Group</th>
          <th class="DataTable" colspan=3>Budget</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=5>Break Up Averages</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=2>Calculated</th>
        </tr>
        <tr>
          <th class="DataTable">Hours</th>
          <th class="DataTable">Pay</th>
          <th class="DataTable">Average</th>
          <th class="DataTable">Com</th>
          <th class="DataTable">Labor<br>Spiff</th>
          <th class="DataTable">Paid<br>Spiff</th>
          <th class="DataTable">Other</th>
          <th class="DataTable">Pay</th>
          <th class="DataTable">Calculated</th>
          <th class="DataTable">Variance</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
      <%while(runsql.readNextRecord()){
        String sStr = runsql.getData("gbstr");
        String sBdgGrp = runsql.getData("gbgrp");
        String sBdgGrpNm = runsql.getData("bgname");
        String sBdgHrs = runsql.getData("gbbhrs");
        String sBdgPay = runsql.getData("gbbpay");
        String sBdgAvg = runsql.getData("bgavg");
        String sClcPay = runsql.getData("amt");
        String sVar = runsql.getData("var");


        sPrepStmt = "select AVG_RATE"
           + " from rci.prbgbrk"
           + " inner join rci.fsyper on buyear = pyr# and bumonth = pmo# and pida = current date"
           + " where bustr =" + sStr + " and bugrp ='" + sBdgGrp + "'"
           + " order by bugrp, SUBGROUP";

        //System.out.println(sPrepStmt);

        RunSQLStmt runsql1 = new RunSQLStmt();
        runsql1.setPrepStmt(sPrepStmt);
        runsql1.runQuery();
        String [] sBrkAvg = new String[5];
        int i = 0;
        while(runsql1.readNextRecord())
        {
            sBrkAvg[i++] = runsql1.getData("AVG_RATE");
        }
        runsql1.disconnect();
      %>
        <tr class="DataTable">
          <td class="DataTable"><%=sStr%></td>
          <td class="DataTable1"><%=sBdgGrpNm%></td>
          <td class="DataTable2"><%=sBdgHrs%></td>
          <td class="DataTable2">$<%=sBdgPay%></td>
          <td class="DataTable2">$<%=sBdgAvg%></td>
          <th class="DataTable">&nbsp;</th>
          <%for(int j=0; j < sBrkAvg.length; j++){%><td class="DataTable2">$<%=sBrkAvg[j]%></td><%}%>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable2">$<%=sClcPay%></td>
          <td class="DataTable2">$<%=sVar%></td>
        </tr>
      <%}%>
      <!------------------------ End Details ---------------------------------->

   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%runsql.disconnect();%>
