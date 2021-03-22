<%@ page import="advertising.AdMediaList, java.util.*"%>
<%
   String sMedia = request.getParameter("Media");

   AdMediaList adMedia = new AdMediaList();

   adMedia.setMktMediaList(sMedia);

   String sMktJsa = adMedia.getMktJsa();
   String sMktNameJsa = adMedia.getMktNameJsa();
   String sMktMediaJsa = adMedia.getMktMediaJsa();
   String sDlyRateJsa= adMedia.getDlyRateJsa();
   String sFriRateJsa= adMedia.getFriRateJsa();
   String sSatRateJsa= adMedia.getSatRateJsa();
   String sSunRateJsa= adMedia.getSunRateJsa();

   adMedia.disconnect();
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Mkt = [<%=sMktJsa%>];
var MktName = [<%=sMktNameJsa%>];
var Media = [<%=sMktMediaJsa%>];
var DlyRate = [<%=sDlyRateJsa%>];
var FriRate = [<%=sFriRateJsa%>];
var SatRate = [<%=sSatRateJsa%>];
var SunRate = [<%=sSunRateJsa%>];

setMktMedia();

// send market media list in parent window
function setMktMedia()
{
  parent.popMktMedia(Mkt, MktName, Media, DlyRate, FriRate, SatRate, SunRate);
  // window.close();
}
</SCRIPT>

