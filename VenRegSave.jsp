<%@ page import="vendorsupport.VenRegSave , java.util.*"%>
<%
    String sName = request.getParameter("Name");
    String sUser = request.getParameter("User");
    String sPwd = request.getParameter("Pwd");
    String sAddr = request.getParameter("Addr");
    String sCity = request.getParameter("City");
    String sState = request.getParameter("State");
    String sZip = request.getParameter("Zip");
    String sPhone = request.getParameter("Phone");
    String sCell = request.getParameter("Cell");
    String sEMail = request.getParameter("EMail");
    String [] sBrand = request.getParameterValues("Brand");
    String sAction = request.getParameter("Action");

    System.out.println("1 " + sName + " 2 " + sUser + " 3 " + sPwd + " 4 " + sAddr  + " 5 " + sCity
      + " 6 " + sState + " 7 " + sZip + " 8 " + sPhone + " 9 " + sCell + " 10 " + sEMail + " 11 " + sAction);
    VenRegSave venreg = new VenRegSave(sName, sUser, sPwd, sAddr, sCity, sState, sZip, sPhone,
                                       sCell, sEMail, sBrand, sAction);
     int iNumOfErr = venreg.getNumOfErr();
     String sError = venreg.getError();
     String sErrorCode = venreg.getErrorCode();
     venreg.disconnect();

%>
<SCRIPT language="JavaScript1.2">
goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.showSaveResults(<%=iNumOfErr%>, [<%=sErrorCode%>],[<%=sError%>])
}
</SCRIPT>







