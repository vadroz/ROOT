<%@ page import="ecommerce.EComRmaSav"%>
<%
   String sSite = request.getParameter("Site");
   String sOrd = request.getParameter("Ord");
   String sOrdDtl = request.getParameter("OrdDtl");
   String sRet = request.getParameter("Ret");
   String sTax = request.getParameter("Tax");
   String sShip = request.getParameter("Ship");
   String sTender = request.getParameter("Tender");
   String sAction = request.getParameter("Action");

   if (sTender == null) { sTender = " ";}

   String sNewRet = null;
   String sNewTax = null;
   String sNewShip = null;
   String sNewTender = null;

   boolean sExpired = false;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null && session.getAttribute("ECOMDWNL")==null)
   {
      sExpired = true;
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      EComRmaSav rmasav = new EComRmaSav( sSite, sOrd, sOrdDtl, sRet, sTax, sShip, sTender, sAction, sUser);
      sNewRet = rmasav.getRet();
      sNewTax = rmasav.getTax();
      sNewShip = rmasav.getShip();
      sNewTender = rmasav.getTender();

      rmasav.disconnect();
      rmasav = null;
   }
%>

<SCRIPT language="JavaScript1.2">
<%if(sExpired) {%>alert("This ssession is expired. The changes were not saved.")
<%}
  else{%>
    parent.chgSaved("<%=sNewRet%>","<%=sNewTax%>","<%=sNewShip%>", "<%=sNewTender%>");
<%}%>

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<%

%>
