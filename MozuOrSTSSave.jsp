<%@ page import="mozu_com.MozuOrSTSSave"%>
<%
   String sSite = request.getParameter("Site");
   String sOrd = request.getParameter("Ord");
   String sPack = request.getParameter("Pack");
   String sSku = request.getParameter("Sku");
   String sSn = request.getParameter("Sn");   
   String sAction = request.getParameter("Action");
   
   boolean sExpired = false;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
      sExpired = true;
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      MozuOrSTSSave stssave = new MozuOrSTSSave();
      //System.out.println(sSite + "|" + sOrd + "|" + sPack + "|" + sSku + "|" + sSn + "|" 
      //+ sAction + "|" + sUser);
      stssave.chgSrlNumSts(sSite, sOrd, sPack, sSku, sSn, sAction, sUser); 

      stssave.disconnect();
      stssave = null;
   }
%>

<SCRIPT language="JavaScript1.2">
<%if(sExpired) {%>alert("This ssession is expired. The changes were not saved.")
<%}
  else{%>
    parent.location.reload(); 
<%}%>

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<%

%>
