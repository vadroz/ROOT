<%@ page import="flashreps.FlashSlsEcomDtl, java.util.*"%>
<%
     String sDate = request.getParameter("Date");

     FlashSlsEcomDtl ecomdtl = new FlashSlsEcomDtl(sDate);
     int iNumOfSit = ecomdtl.getNumOfSit();

     String sSite = ecomdtl.getSite();
     String sTyAmt = ecomdtl.getTyAmt();
     String sLyAmt = ecomdtl.getLyAmt();
     String sVar = ecomdtl.getVar();

     ecomdtl.disconnect();
%>
<html>

<SCRIPT language="javascript">
  var Site = [<%=sSite%>];
  var TyAmt = [<%=sTyAmt%>];
  var LyAmt = [<%=sLyAmt%>];
  var Var = [<%=sVar%>];

  parent.showEComSlsBysite(Site, TyAmt, LyAmt, Var);
</script>


