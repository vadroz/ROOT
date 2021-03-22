<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%
    String sSku = request.getParameter("Sku");
    String sStartDt = request.getParameter("StartDt");

    String sStmtOrd = "select OhSite, OhOrd, OhOrDate, OhSFNam, OhSLNam"
                  + " from rci.EcOrdH"
                  + " where ohordate >='" + sStartDt + "' and exists(select 1 from rci.EcOrdd where Ohsite=odsite and ohord=odord"
                  + " and odsku=" + sSku + ")"
                ;
    RunSQLStmt sqlOrd = new RunSQLStmt();
    sqlOrd.setPrepStmt(sStmtOrd);
    sqlOrd.runQuery();

    String sSite = new String();
    String sOrd = new String();
    String sOrdDt = new String();
    String sFName = new String();
    String sLName = new String();
    String sComa = "";

    while(sqlOrd.readNextRecord())
    {
      sSite += sComa + "'" + sqlOrd.getData("ohsite") + "'";
      sOrd += sComa + "'" + sqlOrd.getData("ohord") + "'";
      sOrdDt += sComa + "'" + sqlOrd.getData("ohordate") + "'";
      sFName += sComa + "'" + sqlOrd.getData("ohsfnam") + "'";
      sLName += sComa + "'" + sqlOrd.getData("ohslnam") + "'";
      sComa = ", ";
    }

    // disconnect from Sys i
    sqlOrd.disconnect();
    sqlOrd = null;
%>
<script name="javascript1.3">
var Sku = "<%=sSku%>";
var Site  = [<%=sSite%>];
var Order = [<%=sOrd%>];
var OrdDt = [<%=sOrdDt%>];
var FName = [<%=sFName%>];
var LName = [<%=sLName%>];

//------------------------------------------------------------------------------
// return order lists
//------------------------------------------------------------------------------
parent.showOrd(Sku, Site, Order, OrdDt, FName, LName);

</script>

