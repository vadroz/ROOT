<%@ page import="java.util.*, java.text.SimpleDateFormat, rciutility.RunSQLStmt, java.sql.*"%>
<%
   String sWeek = request.getParameter("Week");

   ResultSet rslset = null;
   RunSQLStmt runsql = null;

   ResultSet rslset2 = null;
   RunSQLStmt runsql2 = null;

   ResultSet rslset3 = null;
   RunSQLStmt runsql3 = null;

   if(sWeek != null)
   {
      String sPrepStmt =
"select SpStr, char(SpEmp) as emp, eName, sum(SpAmt) as amt"
+ " from rci.StrPtyD left join rci.rciemp on spemp=erci"
+ " where SpPayTy ='SPIFF' and spweek = '" + sWeek + "'"
+ " group by SpStr, SpEmp, ename"

+ " union"

+ " select SpStr, 'TOTAL' as emp, 'TOTAL',sum(SpAmt) as amt"
+ " from rci.StrPtyD"
+ " where SpPayTy ='SPIFF' and spweek = '" + sWeek + "'"
+ " group by SpStr"

+ " union"

+ " select 99999 as spstr, 'TOTAL' as emp, 'TOTAL',sum(SpAmt) as amt"
+ " from rci.StrPtyD"
+ " where SpPayTy ='SPIFF' and spweek = '" + sWeek + "'"
+ " order by  SpStr";

      //System.out.println(sPrepStmt);
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      runsql.runQuery();

    sPrepStmt =
"select SpStr, char(SpEmp) as emp, eName, sum(SpAmt) as amt"
+ " from rci.StrPtyD left join rci.rciemp on spemp=erci"
+ " where SpPayTy ='SPIFF'"
+ " and exists(select 1 from rci.SpStsCom a"
+ " where spstr = a.wcstr and spweek= a.wcweek "
+ " and a.wcstatus ='CLOSE'"
+ " and a.wcseq = (select max(b.wcseq) from rci.SpStsCom b"
+ "     where a.wcstr = b.wcstr and a.wcweek = b.wcweek"
+ "      group by b.wcstr, b.wcweek)"
+ "   )"
+ " group by SpStr, SpEmp, ename"

+ " union"

+ " select SpStr, 'TOTAL' as emp, 'TOTAL' as ename,sum(SpAmt) as amt"
+ " from rci.StrPtyD"
+ " where SpPayTy ='SPIFF'"
+ " and exists(select 1 from rci.SpStsCom a"
+ " where spstr = a.wcstr and spweek= a.wcweek"
+ " and a.wcstatus ='CLOSE'"
+ " and a.wcseq = (select max(b.wcseq) from rci.SpStsCom b"
+ "     where a.wcstr = b.wcstr and a.wcweek = b.wcweek"
+ "     group by b.wcstr, b.wcweek)"
+ ")"
+ " group by SpStr"

+ " union"

+ " select 99999 as SpStr, 'TOTAL' as emp, 'TOTAL' as ename,sum(SpAmt) as amt"
+ " from rci.StrPtyD"
+ " where SpPayTy ='SPIFF'"
+ " and exists(select 1 from rci.SpStsCom a"
+ " where spstr = a.wcstr and spweek= a.wcweek"
+ " and a.wcstatus ='CLOSE'"
+ " and a.wcseq = (select max(b.wcseq) from rci.SpStsCom b"
+ "     where a.wcstr = b.wcstr and a.wcweek = b.wcweek"
+ "     group by b.wcstr, b.wcweek)"
+ ")"

+ " order by  SpStr";
      //System.out.println(sPrepStmt);
      runsql2 = new RunSQLStmt();
      runsql2.setPrepStmt(sPrepStmt);
      runsql2.runQuery();

      sPrepStmt ="with spiff as ("
+ " select cStr, cEmp,"
+ " case when cc01 = 50 then CH$01 when cc02 = 50 then CH$02 when cc03 = 50 then CH$03"
    + " when cc04 = 50 then CH$04 when cc05 = 50 then CH$05 when cc06 = 50 then CH$06"
    + " when cc07 = 50 then CH$07 when cc08 = 50 then CH$08 when cc09 = 50 then CH$09"
    + " when cc10 = 50 then CH$10 when cc11 = 50 then CH$11 when cc12 = 50 then CH$12"
+ " end as amt"
+ " from rci.rciscs"
+ " where cwei = '" + sWeek + "'"
+ " and ( cc01 = 50 or cc02 = 50 or cc03 = 50 or cc04 = 50 or cc05 = 50 or cc06 = 50"
+ "    or cc07 = 50 or cc08 = 50 or cc09 = 50 or cc10 = 50 or cc11 = 50 or cc12 = 50)"
+ ")"
+ " select cstr, char(cemp) as emp, ename, amt"
+ " from spiff inner join rci.rciemp on cemp=erci"

+ " union"

+ " select cstr, 'TOTAL' as emp, 'TOTAL' as ename, dec(sum(amt),9,2) as amt"
+ " from spiff"
+ " group by cstr"
+ " union"

+ " select 99999 as cstr, 'TOTAL' as emp, 'TOTAL' as ename, dec(sum(amt),9,2) as amt"
+ " from spiff"
+ " order by cstr";

      //System.out.println(sPrepStmt);
      runsql3 = new RunSQLStmt();
      runsql3.setPrepStmt(sPrepStmt);
      runsql3.runQuery();
   }
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: CornSilk; font-size:12px }
        tr.DataTable2 { background: lightSalmon; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
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

        #trDtl { display:none; }
        #trDtl2 { display:none; }
        #trDtl3 { display:none; }
</style>
<script language="javascript">
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
  <%if(sWeek == null){%>
     doSelDate();
     document.all.trSpiffTables.style.display = "none";
  <%}%>

}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * (dofw));
  document.all.Week.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
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
// fold unfold detail records
//==============================================================================
function chgView(tbl)
{
   var trdtl = null;
   if(tbl == 1){ trdtl = document.all.trDtl; }
   else if(tbl == 2){ trdtl = document.all.trDtl2; }
   else if(tbl == 3){ trdtl = document.all.trDtl3; }

   if(trdtl != null)
   {
      var disp = "block";
      if(trdtl[0].style.display=="block"){ disp = "none"; }

      for(var i=0; i < trdtl.length; i++)
      {
        trdtl[i].style.display=disp;
      }
   }
}
</script>
<script LANGUAGE="JavaScript" src="Calendar.js"></script>

<html>
<head><Meta http-equiv="refresh"></head>

<body onload="bodyLoad()">

<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="20" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Weekly Payroll Process Spiffs</b>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
   <form name="fmSpiff" method="GET" action="PayProcSpiff.jsp">
     Weekending:
        <button class="Small" name="Down" onClick="setDate('DOWN', 'Week')">&#60;</button>
        <input name="Week" type="text" size=10 maxlength=10 <%if(sWeek != null){%>value="<%=sWeek%>"<%}%> readonly >
        <button class="Small" name="Up" onClick="setDate('UP', 'Week')">&#62;</button>
        <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.Week)" >
        <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

     <br><input type="Submit" value="Submit">
   </form>
<!-------------------------------------------------------------------->
   <tr id="trSpiffTables">
    <td ALIGN="center" VALIGN="TOP">
   <!----------------- beginning of table ------------------------>
      <b>1. Selected week spiffs</b>
      <br><a href="javascript:chgView(1)">Fold/Unfold</a>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Store</th>
          <th class="DataTable">Employee Number</th>
          <th class="DataTable">Paid Spiff<br>Amount</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
   <%if(sWeek != null){%>
      <%while(runsql.readNextRecord()){
        String sStr = runsql.getData("SpStr");
        String sEmpNum = runsql.getData("emp");
        String sEmpName = runsql.getData("ename");
        String sAmt = runsql.getData("amt");
      %>
        <tr class="DataTable<%if(sStr.equals("99999")){%>2<%} else if(sEmpNum.equals("TOTAL")){%>1<%}%>" id="<%if(sEmpNum.equals("TOTAL")){%>trTotal<%} else{%>trDtl<%}%>">
          <td class="DataTable"><%if(!sStr.equals("99999")){%><%=sStr%><%} else {%>Total<%}%></td>
          <td class="DataTable1"><%if(sStr.equals("99999")){%>&nbsp;<%} else if(!sEmpNum.equals("TOTAL")){%><%=sEmpNum%> <%=sEmpName%><%} else{%>Store Total<%}%></td>

          <td class="DataTable"><%=sAmt%></td>
        </tr>
      <%}%>
      <!------------------------ End Details ---------------------------------->
   <%}%>
   </table>
    <!----------------------- end of table ---------------------------------->

    <!----------------- beginning of table ------------------------>
    <td ALIGN="center" VALIGN="TOP">
     <b>2. Current spiffs available for payroll processing</b>
     <br><a href="javascript:chgView(2)">Fold/Unfold</a>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Store</th>
          <th class="DataTable">Employee Number</th>
          <th class="DataTable">Paid Spiff<br>Amount</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
   <%if(sWeek != null){%>
      <%while(runsql2.readNextRecord()){
        String sStr = runsql2.getData("SpStr");
        String sEmpNum = runsql2.getData("emp");
        String sEmpName = runsql2.getData("ename");
        String sAmt = runsql2.getData("amt");
        if (sAmt == null) { sAmt = "0"; }
      %>
      <tr class="DataTable<%if(sStr.equals("99999")){%>2<%} else if(sEmpNum.equals("TOTAL")){%>1<%}%>" id="<%if(sEmpNum.equals("TOTAL")){%>trTotal2<%} else{%>trDtl2<%}%>">
          <td class="DataTable"><%if(!sStr.equals("99999")){%><%=sStr%><%} else {%>Total<%}%></td>
          <td class="DataTable1"><%if(sStr.equals("99999")){%>&nbsp;<%} else if(!sEmpNum.equals("TOTAL")){%><%=sEmpNum%> <%=sEmpName%><%} else{%>Store Total<%}%></td>

          <td class="DataTable"><%=sAmt%></td>
      <%}%>
      <!------------------------ End Details ---------------------------------->
   <%}%>
   </table>


   <!----------------- beginning of table ------------------------>
   <td ALIGN="center" VALIGN="TOP">
     <b>3. Processed payroll spiff summary</b>
     <br><a href="javascript:chgView(3)">Fold/Unfold</a>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Store</th>
          <th class="DataTable">Employee Number</th>
          <th class="DataTable">Paid Spiff<br>Amount</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
   <%if(sWeek != null){%>
      <%while(runsql3.readNextRecord()){
        String sStr = runsql3.getData("cStr");
        String sEmpNum = runsql3.getData("emp");
        String sEmpName = runsql3.getData("ename");
        String sAmt = runsql3.getData("amt");
        if (sAmt == null) { sAmt = "0"; }
      %>
      <tr class="DataTable<%if(sStr.equals("99999")){%>2<%} else if(sEmpNum.equals("TOTAL")){%>1<%}%>" id="<%if(sEmpNum.equals("TOTAL")){%>trTotal3<%} else{%>trDtl3<%}%>">
          <td class="DataTable"><%if(!sStr.equals("99999")){%><%=sStr%><%} else {%>Total<%}%></td>
          <td class="DataTable1"><%if(sStr.equals("99999")){%>&nbsp;<%} else if(!sEmpNum.equals("TOTAL")){%><%=sEmpNum%> <%=sEmpName%><%} else{%>Store Total<%}%></td>

          <td class="DataTable"><%=sAmt%></td>
      <%}%>
      <!------------------------ End Details ---------------------------------->
   <%}%>
   </table>

  </table>
 </body>

</html>

<% if(runsql != null){ runsql.disconnect();} %>
