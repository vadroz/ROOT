<%@ page import="ecommerce.EComSTSSave"%>
<%
   String sSite = request.getParameter("Site");
   String sOrd = request.getParameter("Ord");
   String sCarton = request.getParameter("Carton");
   String sRcvSts = request.getParameter("RcvSts");
   String sNote = request.getParameter("Note");
   String sAction = request.getParameter("Action");

   if (sRcvSts == null) { sRcvSts = " ";}
   if (sNote == null) { sNote = " ";}

   //System.out.println(sNote);

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

      EComSTSSave stssave = new EComSTSSave();

      if(sAction.equals("CTNNOTE")) { stssave.addNote( sSite, sOrd, sCarton, sNote, sAction, sUser );}
      else
      {
         stssave.rcvCarton( sSite, sOrd, sCarton, sRcvSts, sAction, sUser );
      }


      stssave.disconnect();
      stssave = null;
   }
%>

<SCRIPT language="JavaScript1.2">
<%if(sExpired) {%>alert("This ssession is expired. The changes were not saved.")
<%}
  else{%>
    parent.refresh();
<%}%>

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<%

%>
