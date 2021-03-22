<%@ page import="salesreport.SlsRep02"%>
<%
      String sDiv = request.getParameter("Div");
      String sDivName = request.getParameter("DivName");
      String sDpt = request.getParameter("Dpt");
      String sDptName = request.getParameter("DptName");
      String sCls = request.getParameter("Cls");
      String sClsName = request.getParameter("ClsName");
      String sVen = request.getParameter("Ven");
      String sVenName = request.getParameter("VenName");
      String sYear = request.getParameter("Year");
      String sItemGrp = request.getParameter("ItemGrp");
      String sComment = request.getParameter("Comment");

      if(sItemGrp == null){ sItemGrp = " "; }

      String sUser = session.getAttribute("USER").toString();

      SlsRep02 slsrep = new SlsRep02(sDiv, sDpt, sCls, sVen, sYear, sComment, sItemGrp ,sUser );

      slsrep.disconnect();
      slsrep = null;
%>

<script>
parent.closeFrame();
</script>