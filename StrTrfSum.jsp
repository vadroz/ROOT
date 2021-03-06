<%@ page import="itemtransfer.StrTrfSum, java.util.*"%>
<%
   StrTrfSum trfSum = new StrTrfSum();

   String sStrJSA = trfSum.getStrJSA();
   String sAvlJSA = trfSum.getAvlJSA();
   String sAvlDateJSA = trfSum.getAvlDateJSA();
   String sInPJSA = trfSum.getInPJSA();
   String sInPDateJSA = trfSum.getInPDateJSA();
   String sDestDivJSA = trfSum.getDestDivJSA();
   String sDestQtyJSA = trfSum.getDestQtyJSA();

   trfSum.disconnect();
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Store = [<%=sStrJSA%>];
var Avail = [<%=sAvlJSA%>];
var AvailDate = [<%=sAvlDateJSA%>];
var InProgress = [<%=sInPJSA%>];
var InProgDate = [<%=sInPDateJSA%>];
var DestDiv = [<%=sDestDivJSA%>];
var DestQty = [<%=sDestQtyJSA%>];

SendTrfSum();
//==============================================================================
// send employee availability to schedule
function SendTrfSum()
{
  var html = popTable();
  parent.setTrfSum(html);
  window.close();
}
//==============================================================================
// populate transfer table
//==============================================================================
function popTable()
{
     var html = "<table class='msg'>"
             + "<tr><td class='msg1' colspan=7 nowarp ><a class='blue' "
             + "href='DivTrfReqSel.jsp'>Manage Item Transfers</a></td></tr>"
             + "<tr><td class='msg1' rowspan='2'>Str</td>"
             + "<td class='msg1' colspan='2'>Not Printed</td>"
             + "<td class='msg1' colspan='2'>Printed<br>Not Completed</td>"
             + "<td class='msg1' colspan='2'>Total<br>Transfers</td>"
             + "</tr>"
             + "<tr>"
             + "<td class='msg1'>#</td><td class='msg1'>Oldest<br>Date</td>"
             + "<td class='msg1'>#</td><td class='msg1'>Oldest<br>Date</td>"
             + "<td class='msg1'># of Div</td><td class='msg1'>Unit</td>"
             + "</tr>"

  for(var i=0; i < Store.length; i++)
  {
    html += "<tr>"
    if(Store[i] != "100")
    {
       html += "<td class='msg2'><a href='DivTrfGrpSum.jsp?DIVISION=ALL&STORE="
           + Store[i] + "'>" + Store[i] + "</a></td>"
    }
    else html += "<td class='msg2'>" + Store[i] + "</td>"
    html += "<td class='msg2'>" + Avail[i] + "</td>"
           + "<td class='msg2'>" + AvailDate[i] + "</td>"
           + "<td class='msg2'>" + InProgress[i] + "</td>"
           + "<td class='msg2'>" + InProgDate[i] + "</td>"
           + "<td class='msg2'>" + DestDiv[i] + "</td>"
           + "<td class='msg2'>" + DestQty[i] + "</td>"
           + "</tr>"
  }
  html += "</table>";
  return html;
}
</SCRIPT>

</html>

