<%@ page import="advertising.AdFileUpload, java.io.*"%>
<%
   String saveFile = null;
   String sUrl = null;
   String sMarket = request.getParameter("Market");
   String sMedia = request.getParameter("Media");
   String sPromoType = request.getParameter("PromoType");
   String sPromoDesc = request.getParameter("PromoDesc");
   String sOrigWk = request.getParameter("OrigWk");
   String sSeq = request.getParameter("Seq");
   String sFileName = request.getParameter("Doc");
   String sMktName = request.getParameter("MktName");
   String sMonBeg = request.getParameter("MonBeg");
   String sMonName = request.getParameter("MonName");
   String sAction = request.getParameter("Action");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null && session.getAttribute("ADVERTISES")!=null)
   {
        // generat/save/return file name in as400
        AdFileUpload adupl = new AdFileUpload(sMarket, sMedia, sPromoType, sPromoDesc,
                   sOrigWk, sSeq, sFileName, session.getAttribute("USER").toString(), sAction);
        adupl.disconnect();

        saveFile = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/Advertising/" + sFileName;
        //saveFile = "/var/tomcat4/webapps/ROOT/Advertising/" + sFileName.trim();

        try
        {
           File file = new File(saveFile);
           file.delete();
        }
        catch(Exception e) { System.out.println("File: " + saveFile + " - is not deleted");  }
  }
  sUrl = "AdFisCal.jsp?MonBeg=" + sMonBeg + "&MonName=" + sMonName
              +  "&Market=" + sMarket + "&MktName=" + sMktName;
  response.sendRedirect(sUrl);
%>

Url<%=sUrl%><br>
SaveFile=<%=saveFile%>




