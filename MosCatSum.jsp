<%@ page import="mosregister.MosStrCtl, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
	String [] sStr = request.getParameterValues("Str");
	String sSts = request.getParameter("Sts");
	String sCtl = request.getParameter("Ctl");	
	String sWkend = request.getParameter("Wkend");
	String sWkend2 = request.getParameter("Wkend2");
	String sYear = request.getParameter("Year");
	String sMonth = request.getParameter("Month");
	String sDateLvl = request.getParameter("DateLvl");
	String sReas = request.getParameter("Reas");
	String sArgStr = request.getParameter("ArgStr");
	String sArgReas = request.getParameter("ArgReas");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	MosStrCtl ctlinfo = new MosStrCtl();
	ctlinfo.setCatSum(sStr, sSts, sWkend, sWkend2, sYear, sMonth, sDateLvl, sCtl, sReas);
	int iNumOfCat = ctlinfo.getNumOfCat();	
	String [] sSubCat = new String[iNumOfCat];
	String [] sCatQty = new String[iNumOfCat];
	String [] sCatCost = new String[iNumOfCat];
	String [] sCatRet =  new String[iNumOfCat];
			
	for(int j=0; j < iNumOfCat; j++ )
	{
		ctlinfo.setCat();
		sSubCat[j] = ctlinfo.getSubCat();
		sCatQty[j] = ctlinfo.getTotQty();
		sCatCost[j] = ctlinfo.getTotCost();
		sCatRet[j] = ctlinfo.getTotRet();	
	}
	
	String sSubCatJsa = ctlinfo.cvtToJavaScriptArray(sSubCat);
	String sCatQtyJsa = ctlinfo.cvtToJavaScriptArray(sCatQty);
	String sCatCostJsa = ctlinfo.cvtToJavaScriptArray(sCatCost);
	String sCatRetJsa = ctlinfo.cvtToJavaScriptArray(sCatRet);
	
	
	ctlinfo.disconnect();
%>
<html>  
<SCRIPT>
var subcat = [<%=sSubCatJsa%>];
var catqty = [<%=sCatQtyJsa%>];
var catcost = [<%=sCatCostJsa%>];
var catret = [<%=sCatRetJsa%>];
var argStr = "<%=sArgStr%>";
var argReas = "<%=sArgReas%>";

parent.setSubCatSum(argStr, argReas, subcat, catqty, catcost, catret );

</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>



