<%@ page import="advertising.AdMktMed, java.util.*"%>
<%
   String sMarket = request.getParameter("Market");
   String sMedia = request.getParameter("Media");

   AdMktMed adMktMed = new AdMktMed(sMarket, sMedia);
   String sMediaJsa = adMktMed.getMediaJsa();
   String sRateTypeJsa = adMktMed.getRateTypeJsa();
   String sRateJsa = adMktMed.getRateJsa();
   adMktMed.disconnect();
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Media = [<%=sMediaJsa%>];
var RateType = [<%=sRateTypeJsa%>];
var Rate = [<%=sRateJsa%>];

setMediaPrompt();

// send employee availability to schedule
function setMediaPrompt()
{
  parent.popMediaPrompt(Media, RateType, Rate);
  // window.close();
}
</SCRIPT>
<body>
 Market = "<%=sMarket%>";
 Media = "<%=sMedia%>";
</body>
</html>


