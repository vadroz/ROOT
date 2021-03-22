<%@ page import="java.util.*, java.text.*, payrollreports.PrSlsToHrsCorrelation"%>
<%
   String sStore = request.getParameter("Store");
   String sWkend = request.getParameter("Wkend");

   String sUser = session.getAttribute("USER").toString();

   PrSlsToHrsCorrelation schcor = new PrSlsToHrsCorrelation(sStore, sWkend, sUser);
   int iNumOfStr = schcor.getNumOfStr();

   String [] sWkDays = new String[]{"Mon","Tue","Wed","Thu","Fri","Sat","Sun"};
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:20px; padding-right:20px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: yellow; font-size:12px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }
        tr.DataTable31 { background: #ffff99; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable10 { background: pink;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable11 { background: #ccffcc;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable21 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable22 {  background: azure; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable3 { background: black; font-size:12px }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmpList { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSlsGoal { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
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

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var WkDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
//==============================================================================

function bodyLoad()
{
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<body onload="bodyLoad();">
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Pass or Fail Scoring
      <br>Weekending date: <%=sWkend%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan=2>Store</th>
          <%for(int i=0; i < 7; i++){%>
             <th class="DataTable" rowspan=2><%=sWkDays[i]%></th>
          <%}%>
          <th class="DataTable" colspan=2>Total</th>
        </tr>
        <tr>
          <th class="DataTable">Ratio</th>
          <th class="DataTable">Pass<br>Fail</th>
        </tr>
     <!----------------------- Details ---------------------------------------->
     <%for(int i=0; i < iNumOfStr; i++){%>
     <%
        schcor.setStrScore();
        String sStr = schcor.getStr();
        String sStrName = schcor.getStrName();
        String [] sRatio = schcor.getRatio();
        String sPass = schcor.getPass();
        String sWkEmpNum = schcor.getWkEmpNum();
        String sWkHrlyPlan = schcor.getWkHrlyPlan();
     %>
        <tr class="DataTable">
          <td class="DataTable1"><%=sStr + " - " + sStrName%></td>
          <%for(int j=0; j < 8; j++){%>
             <td class="DataTable2"><%=sRatio[j]%></td>
          <%}%>
          <td class="DataTable1<%=sPass%>">
             <%if(sPass.equals("1")){%>Pass<%} else {%>Fail<%}%>
          </td>
        </tr>
     <%}%>
   </table>
   <!----------------------- end of table ---------------------------------->
  </table>
  <p style="text-align:left; font-size:12px;">
  Note: A formula is used to determine the association between projected sales, by hour, and
  scheduled sales employees, by hour. The formula is such that the results can be anywhere from -1.0 to +1.0.
  A negative result indicates that there is a weak correlation between expected sales and sales
  hours scheduled.  The higher the number, the stronger association. For determination of
  "Pass"or "Fail", a cut-off calculated of +.3 is used. Thus, a value (for the week) of +.3 or
  more will result in a "Pass" score. A calculated value of less than +.3 will result in a "Fail" score.

 </body>

</html>

<%schcor.disconnect();%>








