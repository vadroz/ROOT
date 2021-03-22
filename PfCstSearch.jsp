<%@ page import="patiosales.PfsCstSearch, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PfCstSearch.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sLast = request.getParameter("Last");
   String sFirst = request.getParameter("First");
   String sPhone = request.getParameter("Phone");
   String sEMail = request.getParameter("EMail");
   String sSelOrder = request.getParameter("Order");
   String sUser = session.getAttribute("USER").toString();

   if(sLast == null) { sLast = " "; }
   if(sFirst == null) { sFirst = " "; }
   if(sPhone == null) { sPhone = " "; }
   if(sEMail == null) { sEMail = " "; }
   if(sSelOrder == null) { sSelOrder = " "; }

   //System.out.println(sLast + " " + sFirst + " " + sPhone + " " + sEMail);
   PfsCstSearch custsrch = new PfsCstSearch(sFirst, sLast, sPhone, sEMail, sSelOrder, sUser);
   int iNumOfCst = custsrch.getNumOfCst();
%>

<SCRIPT language="JavaScript1.2">
var NumOfCst = <%=iNumOfCst%>;
var Cust = new Array(NumOfCst);
var CstProp = new Array(NumOfCst);
var SlsPerson = new Array(NumOfCst);
var ShipInstr = new Array(NumOfCst);
var OrdDate = new Array(NumOfCst);
var Paid = new Array(NumOfCst);
var Order = new Array(NumOfCst);

<%for(int i=0; i < iNumOfCst; i++){%>
    <%
       custsrch.setCustInfo();
       String sCust = custsrch.getCust();
       String sCstProp = custsrch.getCstProp();
       String sSlsPerson = custsrch.getSlsPerson();
       String sShipInstr = custsrch.getShipInstr();
       String sOrdDate = custsrch.getOrdDate();
       String sPaid = custsrch.getPaid();
       String sOrder = custsrch.getOrder();
    %>
    Cust[<%=i%>] = "<%=sCust%>";
    CstProp[<%=i%>] = [<%=sCstProp%>];
    SlsPerson[<%=i%>] = "<%=sSlsPerson%>";
    ShipInstr[<%=i%>] = "<%=sShipInstr%>";
    OrdDate[<%=i%>] = "<%=sOrdDate%>";
    Paid[<%=i%>] = "<%=sPaid%>";
    Order[<%=i%>] = "<%=sOrder%>";
<%}%>
goBack();

// send employee availability to schedule
function goBack()
{
  parent.showCustList(Cust, CstProp, SlsPerson, ShipInstr, OrdDate, Paid, Order);
}
</SCRIPT>
<%
    custsrch.disconnect();
    custsrch = null;
%>
<%}%>
