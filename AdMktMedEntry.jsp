<%@ page import="advertising.AdMediaList, java.util.*"%>
<%
   String sMarket = request.getParameter("Market");
   String sMedType = request.getParameter("MedType");
   String sMedia  = request.getParameter("Media");
   String sDlyRate = request.getParameter("DlyRate");
   String sFriRate = request.getParameter("FriRate");
   String sSatRate = request.getParameter("SatRate");
   String sSunRate = request.getParameter("SunRate");
   String sAction = request.getParameter("Action");

   if(sDlyRate == null) sDlyRate = "0";
   if(sFriRate == null) sFriRate = "0";
   if(sSatRate == null) sSatRate = "0";
   if(sSunRate == null) sSunRate = "0";

   AdMediaList adMedia = new AdMediaList();

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AdMktMedEntry.jsp&APPL=ADVERTISES&" + request.getQueryString());
   }
   else
   {
      if(sAction.equals("ADD"))
      {
         adMedia.addMktMedia(sMarket, sMedType, sMedia, sDlyRate, sFriRate, sSatRate, sSunRate, sAction);
      }
      else if(sAction.equals("DLT"))
      {
         adMedia.dltMktMedia(sMarket, sMedType, sMedia, sAction);
      }
      else if(sAction.equals("CHG"))
      {
         adMedia.chgMktMedia(sMedia, sDlyRate, sFriRate, sSatRate, sSunRate, sAction);
      }

      String sUrl = "AdMediaList.jsp";
      response.sendRedirect(sUrl);
   }
%>
<html>
<body>

Market: <%=sMarket%><br>
MedType: <%=sMedType%><br>
Media: <%=sMedia%><br>
DlyRate: <%=sDlyRate%><br>
FriRate: <%=sFriRate%><br>
SatRate: <%=sSatRate%><br>
SunRate: <%=sSunRate%><br>
sAction: <%=sAction%><br>

</body>
</html>


