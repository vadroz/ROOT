<%@ page import="discountcard.DiscountCard, java.util.*"%>
<%
    String sCard = request.getParameter("Card");
    String sCust = request.getParameter("Cust");
    String sTrack = request.getParameter("Track");
    String sTeam1 = request.getParameter("Team1");
    String sTeam2 = request.getParameter("Team2");
    String sAddr = request.getParameter("Addr");
    String sSubj = request.getParameter("Subj");
    String sCharity = request.getParameter("Charity");
    String sExpDate = request.getParameter("ExpDate");

    if(sTeam1 == null) sTeam1 = " ";
    if(sTeam2 == null) sTeam2 = " ";
    if(sAddr == null) sAddr = " ";
    if(sSubj == null) sSubj = " ";
    if(sCharity == null) sCharity = " ";
    if(sExpDate == null) sExpDate = " ";

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   //System.out.println(sCard + "|" + sCust + "|" + sTrack + "|" + sPage2 + "|" + sTeam1 + "|" + sTeam2
     //    + "|" + sExcl + "|" + sAddr + "|" + sSubj + "|" + session.getAttribute("USER").toString());
   DiscountCard dcsend = new DiscountCard(sCard, sCust, sTrack, sTeam1, sTeam2,
       sAddr, sSubj, sCharity, sExpDate, session.getAttribute("USER").toString());

   dcsend.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   goBack();
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
<%}%>


//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   alert("Message sent.");
}
</SCRIPT>
