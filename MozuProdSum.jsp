<!DOCTYPE html>	
<%@ page import="mozu_com.MozuProdSum, java.util.*, java.text.*"%>
<%
String sSrchDiv = request.getParameter("Div");
String sSrchDpt = request.getParameter("Dpt");
String sSrchCls = request.getParameter("Cls");
String sSrchVen = request.getParameter("Ven");
String sSeason = request.getParameter("Season");
String sReady = request.getParameter("Ready");
String sApproved = request.getParameter("Approved");
String sSrchAssign = request.getParameter("Assign");
String sSrchSite = request.getParameter("Site");
String sSrchStock = request.getParameter("Stock");
String sExcel = request.getParameter("Excel");
String sSort = request.getParameter("Sort");
String sPO30Dy = request.getParameter("PO30Dy");
String sPO60Dy = request.getParameter("PO60Dy");
String sPO90Dy = request.getParameter("PO90Dy");
String [] sGrp = request.getParameterValues("Grp");

if(sSort==null){ sSort = "GRP"; }
if(sPO30Dy==null){ sPO30Dy = "0"; }
if(sPO60Dy==null){ sPO60Dy = "0"; }
if(sPO90Dy==null){ sPO90Dy = "0"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuProdSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	MozuProdSum prodlst = new MozuProdSum(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen, sSeason, sReady
	, sApproved, sSrchAssign, sSrchSite, sSrchStock, sPO30Dy, sPO60Dy, sPO90Dy, sGrp , sSort, sUser);
	
	int iNumOfProd = prodlst.getNumOfProd();
	
	boolean [] bColDsp = {false, false, false, false};
	
	for(int i=0; i < sGrp.length;i++)
	{
		if(sGrp[i].equals("DIV")){ bColDsp[0] = true; }
		if(sGrp[i].equals("DPT")){ bColDsp[1] = true; }
		if(sGrp[i].equals("CLASS")){ bColDsp[2] = true; }
		if(sGrp[i].equals("VEND")){ bColDsp[3] = true; }
	}
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Mo_Prod_Summ</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelDiv = "<%=sSrchDiv%>";
var SelDpt = "<%=sSrchDpt%>";
var SelCls = "<%=sSrchCls%>";
var SelVen = "<%=sSrchVen%>";
var Season = "<%=sSeason%>";
var Ready = "<%=sReady%>";
var Approved = "<%=sApproved%>";
var Assign = "<%=sSrchAssign%>";
var Site = "<%=sSrchSite%>";
var Stock = "<%=sSrchStock%>";
var Sort = "<%=sSort%>";
var PO30Dy = "<%=sPO30Dy%>";
var PO60Dy = "<%=sPO60Dy%>";
var PO90Dy = "<%=sPO90Dy%>";
var Grp = new Array(); <%for(int i=0; i < sGrp.length; i++){%>Grp[Grp.length] = "<%=sGrp[i]%>";<%}%>
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{	
	var url = "MozuProdSum.jsp?"
		+ "Div=" + SelDiv
        + "&Dpt=" + SelDpt
        + "&Cls=" + SelCls
        + "&Ven=" + SelVen
        + "&Season=" + Season
        + "&Ready=" + Ready
        + "&Approved=" + Approved
        + "&Assign=" + Assign
        + "&Site=" + Site
        + "&Stock=" + Stock
        + "&Sort=" + sort;
	
	for(var i=0; i < Grp.length; i++)	{ url += "&Grp=" + Grp[i]; }
	
	window.location.href=url;
}
//==============================================================================
// regroup report 
//==============================================================================
function regrp()
{	
	if(ByGrp == "STR"){ByGrp = "DIV"}
	else {ByGrp = "STR"}
	
	var url = "MozuProdSum.jsp?"
	 + "FrDate=" + FrDate
	 + "&ToDate=" + ToDate
	 + "&By=" + ByGrp
	 + "&Sort=" + Sort
	
	for(var i=0; i < ArrSelStr.length; i++)	{ url += "&Str=" + ArrSelStr[i]; }
	
	window.location.href=url;
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>E-Commerce - Product Summary   
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuProdSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <%if(bColDsp[0]){%><th class="th02"><a href="javascript: resort('GRP')">Div</a></th><%}%>
          <%if(bColDsp[1]){%><th class="th02"><a href="javascript: resort('GRP')">Dpt</a></th><%}%>
          <%if(bColDsp[2]){%><th class="th02"><a href="javascript: resort('GRP')">Class</a></th><%}%>
          <%if(bColDsp[3]){%><th class="th02"><a href="javascript: resort('GRP')">Vendor</a></th><%}%>
          <th class="th02"><a href="javascript: resort('STYLE')">Parents</a></th>
          <th class="th02"><a href="javascript: resort('UNIT')">Options</a></th>          
          <th class="th02"><a href="javascript: resort('STOCK')">Number<br>Of<br>Units</a></th>
          <th class="th02"><a href="javascript: resort('PRICE')">Price</a></th>
          <th class="th02"><a href="javascript: resort('AVGPRC')">ROI</a></th>
        </tr>
       
<!------------------------------- Detail --------------------------------->
           <%for(int i=0; i < iNumOfProd; i++) {
        	   prodlst.setDetail();               
               String sDiv = prodlst.getDiv();
               String sDivNm = prodlst.getDivNm();
               String sDpt = prodlst.getDpt();
               String sDptNm = prodlst.getOnhand();
               String sCls = prodlst.getCls();
               String sClsNm = prodlst.getClsNm();
               String sVen = prodlst.getVen();
               String sVenNm = prodlst.getVenNm();
               String sNumSty = prodlst.getNumSty();
               String sNumUnit = prodlst.getNumUnit();               
               String sStock = prodlst.getStock();
               String sProdPrice = prodlst.getProdPrice();
               String sListPrice = prodlst.getListPrice();
               String sSlsPrice = prodlst.getSlsPrice();
               String sAvgPrc = prodlst.getAvgPrc();
               
           %>
              <tr id="trId" class="trDtl04">
                <%if(bColDsp[0]){%><td class="td11" nowrap><%=sDiv%> - <%=sDivNm%></td><%}%>                
                <%if(bColDsp[1]){%><td class="td11" nowrap><%=sDpt%> - <%=sDptNm%></td><%}%>
                <%if(bColDsp[2]){%><td class="td11" nowrap><%=sCls%> - <%=sClsNm%></td><%}%>
                <%if(bColDsp[3]){%><td class="td11" nowrap><%=sVen%> - <%=sVenNm%></td><%}%>
                <td class="td12" nowrap><%=sNumSty%></td>
                <td class="td12" nowrap><%=sNumUnit%></td>
                <td class="td12" nowrap><%=sStock%></td>
                <td class="td12" nowrap><%=sProdPrice%></td>
                <td class="td12" nowrap><%=sAvgPrc%></td>
                </th>
              </tr>
           <%}%>           
           
           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
prodlst.disconnect();
prodlst = null;
}
%>