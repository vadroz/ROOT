<%@ page import="specialorder.SpecOrdSave"%>
<%
   String sStore = request.getParameter("Store");
   String sOrder = request.getParameter("Order");
   String sCommt = request.getParameter("Commt");
   String sAction = request.getParameter("Action");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null)
   {
    String sUser = session.getAttribute("USER").toString();

    SpecOrdSave sosave = new SpecOrdSave();

    if(sAction.equals("ADD_COMMT"))
    {
       sosave.saveComments(sStore, sOrder, sCommt, sUser);
    }
    else if(sAction.equals("ADD_ACKNOWLEDGE") || sAction.equals("RMV_ACKNOWLEDGE"))
    {
       System.out.println(sStore + "|" + sOrder + "|" + sAction + "|" + sUser);
       sosave.saveAcknowledge(sStore, sOrder, sAction, sUser);
    }

    sosave.disconnect();
    sosave = null;

%>

<SCRIPT language="JavaScript1.2">
  parent.window.location.reload();
</SCRIPT>
<%}%>