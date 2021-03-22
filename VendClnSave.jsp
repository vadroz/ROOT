<%@ page import="vendorsupport.VenClnSave , rciutility.SendMail, java.util.*"%>
<%
    String sStore = request.getParameter("Store");
    String sDate = request.getParameter("Date");
    String sVen = request.getParameter("Ven");
    String sLoc = request.getParameter("Loc");
    String sClnTime = request.getParameter("ClnTime");
    String sAvlTime = request.getParameter("AvlTime");
    String [] sBrand = request.getParameterValues("Brand");
    String sComment = request.getParameter("Comment");
    String sAction = request.getParameter("Action");
    String sUser = request.getParameter("User");

    if(sVen==null) sVen = " ";
    if(sLoc==null) sLoc = " ";
    if(sClnTime==null) sClnTime = " ";
    if(sAvlTime==null) sAvlTime = " ";
    if(sComment==null) sComment = " ";


    /*System.out.println("1 " + sStore + " 2 " + sDate + " 3 " + sVen + " 4 " + sLoc  + " 5 " + sClnTime
            + " 7 " + sComment + " 11 " + sAction); */

    VenClnSave venclnsv = new VenClnSave(sStore, sDate, sVen, sLoc, sClnTime, sAvlTime, sBrand, sComment, sAction, sUser);
    int iNumOfErr = venclnsv.getNumOfErr();
    String sError = venclnsv.getError();
    System.out.println("Error:" + iNumOfErr);

    String sAddr = venclnsv.getAddr();
    String sAddrName = venclnsv.getAddrName();
    String sSubj = venclnsv.getSubj();
    String sMsg = venclnsv.getMsg();

    venclnsv.disconnect();
    venclnsv = null;

    if (iNumOfErr==0 && sAddr != null && !sAddr.equals(""))
    {
       SendMail sndmail = new SendMail("support@retailconcepts.cc", sAddr, sSubj, sMsg);
    }
%>
<SCRIPT language="JavaScript1.2">
goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.showSaveResults(<%=iNumOfErr%>,[<%=sError%>])
}
</SCRIPT>







