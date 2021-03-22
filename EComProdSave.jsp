<%@ page import="ecommerce.EComProdSave , java.util.*"%>
<%
   String sSite = request.getParameter("Site");
   String sProd = request.getParameter("Prod");
   String sAssign = request.getParameter("Assign");
   String sType = request.getParameter("Type");
   String sNoteOpt = request.getParameter("NoteOpt");
   String sNote = request.getParameter("Note");
   String sAction = request.getParameter("Action");

   if(sType == null) sType = " ";
   if(sAssign == null) sAssign = " ";

   EComProdSave prodsav = null;
   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMMERCE")!=null)
{

   //System.out.println("Site: " + sSite + "Prod: " + sProd + "| Assign: " + sAssign
   //                 + "| Type:" + sType + "| Action:" + sAction);
   prodsav = new EComProdSave();

   if(sAction.indexOf("NOTE") < 0)
   {
      prodsav.saveTypeAssignment(sSite, sProd, sAssign, sType, sAction, session.getAttribute("USER").toString());
   }
   else
   {
      prodsav.saveNote(sSite, sProd, sType, sNoteOpt, sNote, sAction, session.getAttribute("USER").toString());
   }

   // special Order Item Entry
   iNumOfErr = prodsav.getNumOfErr();
   sError = prodsav.getError();
   //System.out.println(iNumOfErr + " Error: " + sError);
   prodsav.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   var Action = "<%=sAction%>"

   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
     if(NumOfErr > 0) parent.displayError(Error);
     else
     {
        if(Action == "UPDASSIGN") { parent.reuseFrame(); }
        if(Action == "UPDNOTE") { parent.window.location.reload(); }
     }
   }
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







