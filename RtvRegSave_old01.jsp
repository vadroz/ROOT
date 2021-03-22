<%@ page import="rtvregister.RtvRegSave , java.util.*"%>
<%

System.out.println("Save 0");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("RTVREG") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=RtvRegSave.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
   String sUser = session.getAttribute("USER").toString();

   String sStore = request.getParameter("Store");
   String sSearch = request.getParameter("Search");
   String sSequence = request.getParameter("Seq");
   String sReasonCode = request.getParameter("Reason");
   String sCommentEnt = request.getParameter("Comment");
   String sEntRaNum = request.getParameter("RaNum");
   String sEntMarkout = request.getParameter("Markout");
   String sEntRecall = request.getParameter("Recall");
   String sAction = request.getParameter("Action");

   String sDivision = request.getParameter("Division");
   String sVendor = request.getParameter("Vendor");
   String sSelReason = request.getParameter("SelReason");
   String sFrom = request.getParameter("From");
   String sSelect = request.getParameter("Select");
   String sDefectEnt = request.getParameter("Defect");

   if(sStore==null) sStore = " ";
   if(sReasonCode==null) sReasonCode = " ";
   if(sEntRaNum==null) sEntRaNum = " ";
   if(sEntMarkout==null) sEntMarkout = " ";
   if(sEntRecall==null) sEntRecall = " ";
   if(sDivision==null) sDivision = " ";
   if(sVendor==null) sVendor = " ";
   if(sSelReason==null) sSelReason = " ";
   if(sFrom==null) sFrom = " ";
   if(sSelect==null) sSelect = " ";
   if(sCommentEnt==null) sCommentEnt = " ";
   if(sDefectEnt==null) sDefectEnt = " ";


   /*System.out.println(sStore + "|" + sSearch + "|" + sSequence + "|" + sReasonCode + "|" + sEntRaNum
      + "|" + sEntMarkout + "|" + sEntRecall + "|" + sUser + "|" + sAction + "|" + sDivision + "|" + sVendor
      + "|" + sSelReason + "|" + sFrom + "|" + sSelect);*/
   RtvRegSave rtvreg = new RtvRegSave(sStore, sSearch, sSequence, sReasonCode, sEntRaNum, sEntMarkout,
     sEntRecall, sUser, sAction, sDivision, sVendor, sSelReason, sCommentEnt, sFrom, sSelect, sDefectEnt);

   int iNumOfErr = rtvreg.getNumOfErr();
   String sError = rtvreg.getErrorJsa();

   int iNumOfItm = rtvreg.getNumOfItm();
   String sStr = rtvreg.getStr();
   String sCls = rtvreg.getCls();
   String sVen = rtvreg.getVen();
   String sSty = rtvreg.getSty();
   String sClr = rtvreg.getClr();
   String sSiz = rtvreg.getSiz();
   String sSeq = rtvreg.getSeq();
   String sReason = rtvreg.getReason();
   String sSku = rtvreg.getSku();
   String sUpc = rtvreg.getUpc();
   String sDesc = rtvreg.getDesc();
   String sClrName = rtvreg.getClrName();
   String sSizName = rtvreg.getSizName();
   String sVenName = rtvreg.getVenName();
   String sVenSty = rtvreg.getVenSty();
   String sDocNum = rtvreg.getDocNum();
   String sRaNum = rtvreg.getRaNum();
   String sMarkout = rtvreg.getMarkout();
   String sRecall = rtvreg.getRecall();
   String sRgDate = rtvreg.getRgDate();
   String sRgTime = rtvreg.getRgTime();
   String sRgUser = rtvreg.getRgUser();
   String sRaDate = rtvreg.getRaDate();
   String sRaTime = rtvreg.getRaTime();
   String sRaUser = rtvreg.getRaUser();
   String sComment = rtvreg.getComment();
   String sDefect = rtvreg.getDefect();

   rtvreg.disconnect();
%>

<SCRIPT language="JavaScript1.2">
var NumOfErr= <%=iNumOfErr%>;
var Error = [<%=sError%>];

var NumOfItm= <%=iNumOfItm%>;
var Str = [<%=sStr%>];
var Cls = [<%=sCls%>];
var Ven = [<%=sVen%>];
var Sty = [<%=sSty%>];
var Clr = [<%=sClr%>];
var Siz = [<%=sSiz%>];
var Seq = [<%=sSeq%>];
var Reason = [<%=sReason%>];
var Sku = [<%=sSku%>];
var Upc = [<%=sUpc%>];
var Desc = [<%=sDesc%>];
var ClrName = [<%=sClrName%>];
var SizName = [<%=sSizName%>];
var VenName = [<%=sVenName%>];
var VenSty = [<%=sVenSty%>];
var DocNum = [<%=sDocNum%>];
var RaNum = [<%=sRaNum%>];
var Markout = [<%=sMarkout%>];
var Recall = [<%=sRecall%>];
var Comment = [<%=sComment%>];
var Defect = [<%=sDefect%>];
var Action = "<%=sAction%>";


goBack();

// send employee availability to schedule
function goBack()
{
  if(NumOfErr > 0) parent.displayError(NumOfErr, Error);
  else if(Action != "MARKOUT" && Action != "RECALL" && Action != "DEFECT"  && Action != "RANUM")
  {
     parent.popTable(Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Sku, Upc, Desc, ClrName,
           SizName, VenName, VenSty, DocNum, RaNum, Markout, Recall, Comment, Defect, Action);
  }
  if(Action == "RANUM") { parent.reuseFrame(); }
}
</SCRIPT>
<%}%>