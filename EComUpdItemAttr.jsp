<%@ page import="java.sql.*, java.util.*, java.text.*, rciutility.RunSQLStmt"%>
<%
   String sItem = request.getParameter("Item");
   String sChecked = request.getParameter("Checked");

   String sCls = sItem.substring(0, 4);
   String sVen = sItem.substring(4, 9);
   String sSty = sItem.substring(9, 13);
   String sClr = sItem.substring(13, 16);
   String sSiz = sItem.substring(16);

   String sAttr = "0";
   if(sChecked.equals("Y")){ sAttr = "4"; }

   String sPrepStmt = "update IpTsFil.IpItHdr set iatt01=" + sAttr
     + " where icls=" + sCls
     + " and iven=" + sVen
     + " and isty=" + sSty
     + " and iclr=" + sClr
     + " and isiz=" + sSiz
   ;

    //System.out.println(sPrepStmt);

    ResultSet rslset = null;
    RunSQLStmt runsql = new RunSQLStmt();
    runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    runsql.disconnect();
    runsql = null;

%>
<script language="javascript1.2">
   window.status = "Item <%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%> is updated.";
</script>



