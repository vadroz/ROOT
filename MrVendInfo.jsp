<%@ page import="rtvregister.MrVendInfo , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("MRVEND") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MrVendInfo.jsp&APPL=ALL&" + request.getQueryString());
}
else
{

   String sVendor = request.getParameter("Vendor");

   MrVendInfo mrvlst = new MrVendInfo(sVendor);

   String sCstCont = mrvlst.getCstCont();
   String sCstPhone = mrvlst.getCstPhone();
   String sCstWeb = mrvlst.getCstWeb();
   String sCstEMail = mrvlst.getCstEMail();
   String sCstAddr = mrvlst.getCstAddr();
   String sCstIns = mrvlst.getCstIns();

   String sRciCont = mrvlst.getRciCont();
   String sRciPhone = mrvlst.getRciPhone();
   String sRciWeb = mrvlst.getRciWeb();
   String sRciEMail = mrvlst.getRciEMail();
   String sRciAddr = mrvlst.getRciAddr();
   String sRciIns = mrvlst.getRciIns();

   mrvlst.disconnect();
%>

<SCRIPT language="JavaScript1.2">
var CstCont = "<%=sCstCont%>";
var CstPhone = "<%=sCstPhone%>";
var CstWeb = "<%=sCstWeb%>";
var CstEMail = "<%=sCstEMail%>";
var CstAddr = [<%=sCstAddr%>];
var CstIns = [<%=sCstIns%>];

var RciCont = "<%=sRciCont%>";
var RciPhone = "<%=sRciPhone%>";
var RciWeb = "<%=sRciWeb%>";
var RciEMail = "<%=sRciEMail%>";
var RciAddr = [<%=sRciAddr%>];
var RciIns = [<%=sRciIns%>];

goBack();

// send employee availability to schedule
function goBack()
{
   parent.popAddr(CstCont, CstPhone, CstWeb, CstEMail, CstAddr, CstIns,
                  RciCont, RciPhone, RciWeb, RciEMail, RciAddr, RciIns);
}
</SCRIPT>
<%}%>