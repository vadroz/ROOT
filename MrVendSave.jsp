<%@ page import="rtvregister.MrVendSave , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("MRVENDCHG") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MrVendSave.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sVendor = request.getParameter("Vendor");
   String sVenName = request.getParameter("VenName");
   String sAlwRate = request.getParameter("AlwRate");
   String sSigned = request.getParameter("Signed");
   String sPrtName = request.getParameter("PrtName");
   String sTitle = request.getParameter("Title");
   String sSignDate = request.getParameter("SignDate");

   String sCstCont = request.getParameter("CstCont");
   String sCstPhone = request.getParameter("CstPhone");
   String sCstWeb = request.getParameter("CstWeb");
   String sCstEMail = request.getParameter("CstEMail");
   String sCstAddr = request.getParameter("CstAddr");
   String sCstIns = request.getParameter("CstIns");

   String sRciCont = request.getParameter("RciCont");
   String sRciPhone = request.getParameter("RciPhone");
   String sRciWeb = request.getParameter("RciWeb");
   String sRciEMail = request.getParameter("RciEMail");
   String sRciAddr = request.getParameter("RciAddr");
   String sRciIns = request.getParameter("RciIns");

   String sAcct = request.getParameter("Acct");
   String sCoop = request.getParameter("Coop");
   String sCoopPrc = request.getParameter("CoopPrc");
   String sFrgAlw = request.getParameter("FrgAlw");
   String sFrgAlwPrc = request.getParameter("FrgAlwPrc");
   String sPreTick = request.getParameter("PreTick");
   String sSupTick = request.getParameter("SupTick");

   String sUser = request.getParameter("User");


   if(sVenName == null) sVenName = " ";
   if(sAlwRate == null) sAlwRate = " ";
   if(sSigned == null) sSigned = " ";
   if(sPrtName == null) sPrtName = " ";
   if(sTitle == null) sTitle = " ";
   if(sSignDate == null) sSignDate = " ";
   if(sCstCont == null) sCstCont = " ";
   if(sCstPhone == null) sCstPhone = " ";
   if(sCstWeb == null) sCstWeb = " ";
   if(sCstEMail == null) sCstEMail = " ";
   if(sCstAddr == null) sCstAddr = " ";
   if(sCstIns == null) sCstIns = " ";
   if(sRciCont == null) sRciCont = " ";
   if(sRciPhone == null) sRciPhone = " ";
   if(sRciWeb == null) sRciWeb = " ";
   if(sRciEMail == null) sRciEMail = " ";
   if(sRciAddr == null) sRciAddr = " ";
   if(sRciIns == null) sRciIns = " ";
   if(sAcct == null) sAcct = " ";
   if(sCoop == null) sCoop = "N";
   if(sCoopPrc == null) sCoopPrc = "0";
   if(sFrgAlw == null) sFrgAlw = "N";
   if(sFrgAlwPrc == null) sFrgAlwPrc = "0";
   if(sPreTick == null) sPreTick = "N";
   if(sSupTick == null) sSupTick = "N";

   /*System.out.println( sVendor + " " + sVenName + " " + sAlwRate + " " + sSigned + " "
                    + sPrtName + " " + sTitle + " " + sSignDate + " cp:"
                    + sCstPhone + " cw:" + sCstWeb  + " ce:" + sCstEMail + " ca:" + sCstAddr + " ci:" + sCstIns + " rp:"
                    + sRciPhone + " rw:" + sRciWeb  + " re:" + sRciEMail + " ra" + sRciAddr
                    + " ri" + sRciIns + " user:" + sUser + " |end"
                    );*/

   MrVendSave mrvsave = new MrVendSave(sVendor, sVenName, sAlwRate, sSigned, sPrtName, sTitle, sSignDate,
                    sCstCont, sCstPhone, sCstWeb, sCstEMail, sCstAddr, sCstIns,
                    sRciCont, sRciPhone, sRciWeb, sRciEMail, sRciAddr, sRciIns,
                    sAcct, sCoop, sCoopPrc, sFrgAlw, sFrgAlwPrc, sPreTick, sSupTick, sUser);

   mrvsave.disconnect();
%>

<SCRIPT language="JavaScript1.2">

</SCRIPT>
<%}%>