<%@ page import="mosregister.MosCtlwOther, java.util.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sSelCtl = request.getParameter("Ctl");
   String [] sSelSts = request.getParameterValues("Sts");   
   String sWkend = request.getParameter("Wkend");
   String sWkend2 = request.getParameter("Wkend2");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sDateLvl = request.getParameter("DateLvl");
   String sSort = request.getParameter("Sort");   
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sUser = session.getAttribute("USER").toString();
	
	MosCtlwOther ctlinfo = new MosCtlwOther();
	
	ctlinfo.setSkuLst(sSelStr, sSelCtl, sSelSts, sWkend, sWkend2, sYear, sMonth, sDateLvl
			,sSort, sUser);	
	int iNumOfSku = ctlinfo.getNumOfSku();	
%>
<html>  
<SCRIPT>
var ctl = new Array();
var itemid = new Array();
var sku = new Array();
var comm = new Array();
var qty = new Array();
var cost = new Array();
var ret = new Array();
var desc = new Array();
var user = new Array();

<%for(int i=0; i < iNumOfSku; i++ )
{
	ctlinfo.setSku();
	String sCtl = ctlinfo.getCtl();
	String sItemId = ctlinfo.getItemId();
	String sSku = ctlinfo.getSku();
	String sComm = ctlinfo.getComm();
	String sQty = ctlinfo.getQty();
	String sCost = ctlinfo.getCost();
	String sRet = ctlinfo.getRet();
	String sDesc = ctlinfo.getDesc();
	String sCmtUser = ctlinfo.getCmtUser();	
%>
	ctl[<%=i%>] = "<%=sCtl%>";
	itemid[<%=i%>] = "<%=sItemId%>";
	sku[<%=i%>] = "<%=sSku%>";
	comm[<%=i%>] = "<%=sComm%>";
	qty[<%=i%>] = "<%=sQty%>";
	cost[<%=i%>] = "<%=sCost%>";
	ret[<%=i%>] = "<%=sRet%>";
	desc[<%=i%>] = "<%=sDesc%>";
	user[<%=i%>] = "<%=sCmtUser%>";
<%}%>


   parent.setOtherByCommt(ctl, itemid, sku, comm, qty, cost, ret, desc, user);

</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>



