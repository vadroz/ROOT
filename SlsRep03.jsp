<%@ page import="salesreport.SlsRep03"%>
<%
      String sDiv = request.getParameter("Div");
      String sDivName = request.getParameter("DivName");
      String sDpt = request.getParameter("Dpt");
      String sDptName = request.getParameter("DptName");
      String sCls = request.getParameter("Cls");
      String sClsName = request.getParameter("ClsName");
      String [] sVen = request.getParameterValues("Ven");
      String [] sVenName = request.getParameterValues("VenName");

      String sSlsFr = request.getParameter("SlsFr");
      String sSlsTo = request.getParameter("SlsTo");
      String [] sSumOpt = request.getParameterValues("SO");
      String sComment = request.getParameter("Comment");
      String sDatLvl = request.getParameter("DatLvl");

      String sUser = session.getAttribute("USER").toString();

      SlsRep03 slsrep = new SlsRep03(sDiv, sDpt, sCls, sVen, sSlsFr, sSlsTo,
                      sSumOpt, sComment, sDatLvl, sUser );

      slsrep.disconnect();
      slsrep = null;
%>

<script>
parent.closeFrame();
</script>