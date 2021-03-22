<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String sUser = null;

//----------------------------------
// Application Authorization
//----------------------------------
String sAppl = "PRHIST";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
    && !session.getAttribute("APPLICATION").equals(sAppl))
{
     response.sendRedirect("SignOn1.jsp?TARGET=AllwBdgWkHistSel.jsp.jsp&APPL=" + sAppl);
}
else
{

   SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat sdfUSA = new SimpleDateFormat("MM/dd/yyyy");

   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();

   String sPrepStmt = "select Week from rci.BgWkHst group by Week order by Week desc";
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   Vector vWeek = new Vector();

   while(runsql.readNextRecord())
   {
      java.util.Date dWkend = sdfISO.parse(runsql.getData("Week"));
      vWeek.add(sdfUSA.format(dWkend));
   }

   Iterator it = vWeek.iterator();
   String [] sWeek = new String[vWeek.size()];
   vWeek.toArray((String []) sWeek);

   runsql.disconnect();
   runsql = null;
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var Week = new Array();
<%for(int i=0; i < sWeek.length; i++){%>Week[<%=i%>] = "<%=sWeek[i]%>"; <%}%>

//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
   setWeek();
}
//==============================================================================
// set week in a menu
//==============================================================================
function setWeek()
{
  for(var i=0; i < Week.length; i++)
  {
     document.all.Week.options[i] = new Option(Week[i], Week[i]);
  }
}
//==============================================================================
// validate
//==============================================================================
function validate()
{
   var error;
   var msg ="";
   var week = document.all.Week.options[document.all.Week.selectedIndex].value

   if(error){ alert(msg);}
   else { submit(week); }
}
//==============================================================================
// submit report
//==============================================================================
function submit(week)
{
   var url = "AllwBdgWkHist.jsp?Week=" + week;
   //alert(url)
   window.location.href = url;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Allowable Budget vs. Schedule and Actual Payroll History - Selection
       </b><br><br>

       <a href="index.jsp">Home</a>

      <table>
      <!-- ============================== Weekly ================================= -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR>
          <TD align=center colspan=2><br>
           Saved Week Ending Date: &nbsp;
           <select name="Week"></select>
          </TD>
      </TR>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button name="submit" onClick="validate()">Submit</button>
      </tr>
      </table>
                </td>
            </tr>
       </table>

        </body>
      </html>
<%}%>