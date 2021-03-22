<%@ page import="ecommerce.EcItmRmvSave"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMDWNL")!=null)
{
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sCls + " " + sVen + " " + sSty + " " + sAction + " " + sUser );

    EcItmRmvSave itmrmvsv = new EcItmRmvSave(sCls, sVen, sSty, sAction, sUser);
    itmrmvsv.disconnect();
    itmrmvsv = null;
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER") == null){%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
<%}%>
</SCRIPT>
