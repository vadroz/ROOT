<%@ page import="salesreport.SlsRep01"%>
<%
      String sDiv = request.getParameter("Div");
      String sDivName = request.getParameter("DivName");
      String sDpt = request.getParameter("Dpt");
      String sDptName = request.getParameter("DptName");
      String sCls = request.getParameter("Cls");
      String sClsName = request.getParameter("ClsName");
      String sVen = request.getParameter("Ven");
      String sVenName = request.getParameter("VenName");

      String [] sStr = request.getParameterValues("Str");
      String sSlsFr = request.getParameter("SlsFr");
      String sSlsTo = request.getParameter("SlsTo");
      String [] sSumOpt = request.getParameterValues("SO");
      String sStrLvl = request.getParameter("StrLvl");
      String sComment = request.getParameter("Comment");
      String sDatLvl = request.getParameter("DatLvl");
      String sItemGrp = request.getParameter("ItemGrp");

      if(sItemGrp==null){ sItemGrp = " ";}

      String sUser = session.getAttribute("USER").toString();

      SlsRep01 slsrep = new SlsRep01(sDiv, sDpt, sCls, sVen, sStr, sSlsFr, sSlsTo,
                      sSumOpt, sStrLvl, sComment, sDatLvl, sItemGrp, sUser );

      slsrep.disconnect();
      slsrep = null;
%>

<script>
parent.closeFrame();
</script>