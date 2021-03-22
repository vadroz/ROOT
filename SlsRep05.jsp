<%@ page import="salesreport.SlsRep05"%>
<%
      String [] sCls = request.getParameterValues("Cls");
      String [] sVen = request.getParameterValues("Ven");
      String sYear = request.getParameter("Year");
      String sItemGrp = request.getParameter("ItemGrp");
      String sComment = request.getParameter("Comment");

      if(sItemGrp == null){ sItemGrp = " "; }

      String sUser = session.getAttribute("USER").toString();
      //System.out.println(sCls[0] +  " " + sVen[0] + " " + sYear + " " + sItemGrp + " " + sComment);
      SlsRep05 slsrep = new SlsRep05(sCls, sVen, sYear, sComment, sItemGrp ,sUser );

      slsrep.disconnect();
      slsrep = null;
%>

<script>
parent.closeFrame();
</script>