<%@ page import="rciutility.RunSQLStmt, badcredhist.BchSave, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSelCustId = request.getParameter("CustId");
   String sFName = request.getParameter("FName");
   String sMName = request.getParameter("MName");
   String sLName = request.getParameter("LName");
   String sCardNum = request.getParameter("CardNum");
   String sStore = request.getParameter("Store");
   String sCommt = request.getParameter("Commt");
   String sAction = request.getParameter("Action");

   if(sSelCustId == null){ sSelCustId = "0000000000"; }
   if(sFName == null){ sFName = " "; }
   if(sMName == null){ sMName = " "; }
   if(sLName == null){ sLName = " "; }
   if(sCardNum == null){ sCardNum = " "; }
   if(sStore == null){ sStore = " "; }
   if(sCommt == null){ sCommt = " "; }

   String sCust = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")!=null)
{
    String sUser = (String)session.getAttribute("USER");
    BchSave bchsv = new BchSave();

    if(!sAction.equals("STR_NOTE"))
    {
      bchsv.saveCustomer(sSelCustId, sFName, sMName, sLName, sCardNum, sStore, sCommt, sAction, sUser );
      sCust = bchsv.getCust();
    }
    else
    {
         bchsv.saveComment(sSelCustId, sCommt, sAction, sUser );
         sCust = sSelCustId;
    }
%>

Requered Cust Id = <%=sSelCustId%>
Return Cust = <%=sCust%>
First Name = <%=sFName%>
Middle Name = <%=sMName%>
Last Name = <%=sLName%>
Card Number = <%=sCardNum%>
Store = <%=sStore%>
Action = <%=sAction%>
User = <%=sUser%>
Commt = <%=sCommt%>

<script LANGUAGE="JavaScript1.2">
  parent.restart("<%=sCust%>");
</script>

<%
    bchsv.disconnect();
}%>










