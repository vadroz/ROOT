<%@ page import="java.util.*, java.text.SimpleDateFormat, rciutility.RunSQLStmt, java.sql.*"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComProd.jsp");
}
else
{
   boolean bError = false;
   boolean bOrder = false;
   int iRowsUpdated = 0;

   //===========================================================================
   // check last date
   //===========================================================================
   if (sOrder != null && !sOrder.trim().equals(""))
   {
      bOrder = true;
      try
      {
        String sPrepStmt = "update rci.ecordh set OhPick=' ', OhPickDa='0001-01-01', OhPickTi='00.00.00'"
          + " where ohsite='" + sSite + "' and ohord=" + sOrder;
        RunSQLStmt runsql = new RunSQLStmt();
        ResultSet rslset = runsql.getResult();
        iRowsUpdated = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE,
                                                                  ResultSet.CONCUR_UPDATABLE);
        bError = runsql.getError() != null;

        // verify
        sPrepStmt = "select 1 as result from rci.ecordh"
          + " where ohsite='" + sSite + "' and ohord=" + sOrder + " and OhPick=' ' and OhPickDa='0001-01-01'";
        rslset = runsql.getResult();
        runsql.setPrepStmt(sPrepStmt);
        runsql.runQuery();
        if (runsql.readNextRecord()){ iRowsUpdated = 1; }
        runsql.disconnect();
      }
      catch(Exception e){System.out.println("Error ===>" + e.getMessage());}
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
        tr.DataTable0 { background: red; font-size:12px }
        tr.DataTable1 { background: CornSilk; font-size:12px }

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

</style>
<html>
<head><Meta http-equiv="refresh"></head>
<script language="javascript">
var Error = <%=bError%>;
var OrderExist = <%=bOrder%>
var Order = null;
var RowsUpdated = <%=iRowsUpdated%>;
<%if(bOrder){%>Order = "<%=sOrder%>"<%}%>;
//==============================================================================
// initialize
//==============================================================================
function bodyload()
{
  if(OrderExist)
  {
     if( Error) {alert("Order " + Order + " is not updated. Error occured.")}
     if( RowsUpdated == 0) {alert("Order " + Order + " is not updated.")}
     else { alert("Order " + Order + " is updated.") }
  }
}
//==============================================================================
// validate entry parameters
//==============================================================================
function Validate()
{
   var site = document.all.Site[document.all.Site.selectedIndex].value;
   var order = document.all.Order.value;
   sbmUpdate(site, order);
}
//==============================================================================
// submit update
//==============================================================================
function sbmUpdate(site, order)
{
   var url = "EComUnflagOrd.jsp?Site=" + site
      + "&Order=" + order
   //alert(url)
   window.location.href = url;
}
</script>

<!-------------------------------------------------------------------->

<body onload=bodyload()>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>E-Commerce - Unflag Order</b>
      <br><br>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
  <table border=0>
    <tr>
      <td align=right>Site: </td>
      <td><select name="Site">
            <option value="SASS">Sun & Ski</option>
            <option value="SKCH">Ski Chalet</option>
            <option value="SSTP">Ski Stop</option>
            <option value="RLHD">Railhead</option>
            <option value="RACK">Total Car Rack</option>
          </select>
      </td>
    </tr>
    <tr>
      <td  align=right>Order Number: </td>
      <td><input name="Order" size=10 maxlength=10></td>
    </tr>
    <tr>
       <td align=center colspan=2><button onClick="Validate()">Update</button>
    <tr>

    </tr>
  </table>

<!-------------------------------------------------------------------->
  </table>
 </body>

</html>
<%}%>