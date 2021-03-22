<%@ page import="rtvregister.RtvRegSave , java.util.*"%>
<%
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
   String [] sSearch = request.getParameterValues("Search");
   String sSequence = request.getParameter("Seq");
   String [] sReasonCode = request.getParameterValues("Reason");
   String [] sCommentEnt = request.getParameterValues("Comment");
   String sEntRaNum = request.getParameter("RaNum");
   String sEntMarkout = request.getParameter("Markout");
   String sEntRecall = request.getParameter("Recall");
   String sAction = request.getParameter("Action");

   String sDivision = request.getParameter("Division");
   String sVendor = request.getParameter("Vendor");
   String sSelReason = request.getParameter("SelReason");
   String sFrom = request.getParameter("From");
   String sSelect = request.getParameter("Select");
   String [] sDefectEnt = request.getParameterValues("Defect");

   if(sStore==null) sStore = " ";
   if(sEntRaNum==null) sEntRaNum = " ";
   if(sEntMarkout==null) sEntMarkout = " ";
   if(sEntRecall==null) sEntRecall = " ";
   if(sDivision==null) sDivision = " ";
   if(sVendor==null) sVendor = " ";
   if(sSelReason==null) sSelReason = " ";
   if(sFrom==null) sFrom = " ";
   if(sSelect==null) sSelect = " ";
      

   /*System.out.println(sStore + "|" + sSearch + "|" + sSequence + "|" + sReasonCode + "|" + sEntRaNum
      + "|" + sEntMarkout + "|" + sEntRecall + "|" + sUser + "|" + sAction + "|" + sDivision + "|" + sVendor
      + "|" + sSelReason + "|" + sFrom + "|" + sSelect);*/
   
   RtvRegSave rtvreg = null; 
   int iNumOfErr = 0;
   String sError = "[]";
   
       
   for(int i=0; i < sSearch.length;i++)
   {
	   System.out.println("sCommentEnt:" + sCommentEnt[i]==null);
	   if(sCommentEnt[i]==null) sCommentEnt[i] = " ";
	   
	   rtvreg = new RtvRegSave(sStore, sSearch[i], sSequence, sReasonCode[i], sEntRaNum, sEntMarkout
	    , sEntRecall, sUser, sAction, sDivision, sVendor, sSelReason, sCommentEnt[i], sFrom, sSelect, sDefectEnt[i]);
	   iNumOfErr = rtvreg.getNumOfErr();
	   sError = rtvreg.getErrorJsa();
	   System.out.println("Error:" + sError);
   }

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
var Mult = <%=sSearch.length > 1%>;
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
  if( !Mult )
  {   
  	if(NumOfErr > 0) parent.displayError(NumOfErr, Error);
  	else if(Action != "MARKOUT" && Action != "RECALL" && Action != "DEFECT"  && Action != "RANUM")
  	{
    	 parent.popTable(Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Sku, Upc, Desc, ClrName,
           SizName, VenName, VenSty, DocNum, RaNum, Markout, Recall, Comment, Defect, Action);
  	}
  	if(Action == "RANUM") { parent.reuseFrame(); }
  }
  else{parent.location.reload();}
}
</SCRIPT>
<%}%>