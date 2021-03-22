<%@ page import="patiosales.PsOrdGetVenLst, java.util.*"%>
<%
   int iNumOfVen = 0;
   String sVen = null;
   String sName = null;
   String sAddr1 = null;
   String sAddr2 = null;
   String sCity = null;
   String sState = null;
   String sZip = null;
   String sPhone = null;

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   PsOrdGetVenLst getvend = new PsOrdGetVenLst(session.getAttribute("USER").toString());

   iNumOfVen = getvend.getNumOfVen();
   sVen = getvend.getVen();
   sName = getvend.getName();
   sAddr1 = getvend.getAddr1();
   sAddr2 = getvend.getAddr2();
   sCity = getvend.getCity();
   sState = getvend.getState();
   sZip = getvend.getZip();
   sPhone = getvend.getPhone();	
   getvend.disconnect();

}
%>
 <%=sVen%>
 <br><%=sName%>
<SCRIPT language="JavaScript1.2">

<%if  (session.getAttribute("USER")!=null){%>
   var NumOfVen = <%=iNumOfVen%>;
   var Ven = [<%=sVen%>];
   var VenName = [<%=sName%>];
   var Addr1 = [<%=sAddr1%>];
   var Addr2 = [<%=sAddr2%>];
   var City = [<%=sCity%>];
   var State = [<%=sState%>];
   var Zip = [<%=sZip%>];
   var Phone = [<%=sPhone%>];
   
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
   //alert(Ven)	
   parent.popVenInfo(Ven, VenName, Addr1, Addr2, City, State, Zip, Phone);
}
</SCRIPT>
