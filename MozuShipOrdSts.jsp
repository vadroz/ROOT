<!DOCTYPE html>	
<%@ page import="mozu_com.MozuShipOrdSts, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sBy = request.getParameter("By");
   String sSort = request.getParameter("Sort");
   
   if(sBy == null){ sBy = "STR"; }
   if(sSort == null){ sSort = "STR"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuShipOrdSts.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	MozuShipOrdSts shporsts = new MozuShipOrdSts(sSelStr, sFrDate, sToDate, sBy, sSort, sUser);
	int iNumOfGrp = shporsts.getNumOfGrp();
	int iNumOfReg = shporsts.getNumOfReg();
	
	String sColGrpNm = "Store";
	if(!sBy.equals("STR")){sColGrpNm = "Division";}
	String sExchGrp = "By Div";
	if(!sBy.equals("STR")){sExchGrp = "By Str";}
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Shipped Ord Stat</title>

<SCRIPT>

//--------------- Global variables -----------------------
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
var Sort = "<%=sSort%>"
var ByGrp = "<%=sBy%>";

var ArrSelStr = new Array();
<%for(int i=0; i < sSelStr.length; i++){%>ArrSelStr[<%=i%>] = "<%=sSelStr[i]%>";<%}%>

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
	var url = "MozuShipOrdSts.jsp?"
	 + "FrDate=" + FrDate
	 + "&ToDate=" + ToDate
	 + "&By=" + ByGrp
	 + "&Sort=" + sort
	
	for(var i=0; i < ArrSelStr.length; i++)	{ url += "&Str=" + ArrSelStr[i]; }
	
	window.location.href=url;
}
//==============================================================================
// regroup report 
//==============================================================================
function regrp()
{	
	if(ByGrp == "STR"){ByGrp = "DIV"}
	else {ByGrp = "STR"}
	
	var url = "MozuShipOrdSts.jsp?"
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
            <br>E-Commerce - Shipped Orders Statistics   
            <br>Stores:
               <%String sComa = "";%>
               <%for(int i=0; i < sSelStr.length;i++){%>
                  <%if(i > 0 && i%20 == 0){%><br><%}%>
                  <%=sComa%><%=sSelStr[i]%>
                  <%sComa = ", ";%>
               <%}%>
            <br>Dates: <%=sFrDate%> - <%=sToDate%>
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuShipOrdStsSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02"><a href="javascript: resort('GRP')"><%=sColGrpNm%></a><br><br>
              <a href="javascript: regrp()"><%=sExchGrp%></a>
          </th>
          <th class="th02"><a href="javascript: resort('TYRET')">Ret</a></th>
          <th class="th02"><a href="javascript: resort('TYCST')">Cost</a></th>
          <th class="th02"><a href="javascript: resort('TYMARGP')">Margin<br>%</a></th>
          <th class="th02"><a href="javascript: resort('TYSHPCST')">Shipping<br>Cost</a></th>
          <th class="th02"><a href="javascript: resort('TYSHPCHRG')">Shipping<br>Charge</a></th>
          <th class="th02"><a href="javascript: resort('TYMARGP')">Margin<br>Sls & Shp<br>%</a></th>
        </tr>
       
<!------------------------------- Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++) {
        	   shporsts.setItemLst();
               
               String sGrp = shporsts.getGrp();
               String sGrpNm = shporsts.getGrpNm();
               String sTyRet = shporsts.getTyRet();
               String sTyCst = shporsts.getTyCst();
               String sLyRet = shporsts.getLyRet();
               String sLyCst = shporsts.getLyCst();
               String sTyMargPrc = shporsts.getTyMargPrc();
               String sLyMargPrc = shporsts.getLyMargPrc();
               String sTyShpCost = shporsts.getTyShpCost();
               String sLyShpCost = shporsts.getLyShpCost();
               String sTyShpCharge = shporsts.getTyShpCharge();
               String sLyShpCharge = shporsts.getLyShpCharge();       
               String sTyMargWShp = shporsts.getTyMargWShp();
               String sLyMargWShp = shporsts.getLyMargWShp();
           %>
              <tr id="trId" class="trDtl04">
                <td class="td11" nowrap><%=sGrp%> - <%=sGrpNm%></td>
                <td class="td12" nowrap>$<%=sTyRet%></td>
                <td class="td12" nowrap>$<%=sTyCst%></td>
                <td class="td12" nowrap><%=sTyMargPrc%>%</td>
                <td class="td12" nowrap>$<%=sTyShpCost%></td>
                <td class="td12" nowrap>$<%=sTyShpCharge%></td>
                <td class="td12" nowrap><%=sTyMargWShp%>%</td>
                </th>
              </tr>
           <%}%>           
           
           <!------------------------------- Regional Total --------------------------------->
           <tr class="trHdr01"><td class="Separator02" nowrap colspan=10>&nbsp;</td></tr> 
           
           <%for(int i=0; i < iNumOfReg; i++) {
        	   shporsts.setRegTot();
               
               String sGrp = shporsts.getGrp();
               String sGrpNm = shporsts.getGrpNm();
               String sTyRet = shporsts.getTyRet();
               String sTyCst = shporsts.getTyCst();
               String sLyRet = shporsts.getLyRet();
               String sLyCst = shporsts.getLyCst();
               String sTyMargPrc = shporsts.getTyMargPrc();
               String sLyMargPrc = shporsts.getLyMargPrc();
               String sTyShpCost = shporsts.getTyShpCost();
               String sLyShpCost = shporsts.getLyShpCost();
               String sTyShpCharge = shporsts.getTyShpCharge();
               String sLyShpCharge = shporsts.getLyShpCharge();       
               String sTyMargWShp = shporsts.getTyMargWShp();
               String sLyMargWShp = shporsts.getLyMargWShp();
           %>
              <tr id="trId" class="trDtl02">
                <td class="td11" nowrap><%=sGrpNm%></td>
                <td class="td12" nowrap>$<%=sTyRet%></td>
                <td class="td12" nowrap>$<%=sTyCst%></td>
                <td class="td12" nowrap><%=sTyMargPrc%>%</td>
                <td class="td12" nowrap>$<%=sTyShpCost%></td>
                <td class="td12" nowrap>$<%=sTyShpCharge%></td>
                <td class="td12" nowrap><%=sTyMargWShp%>%</td>
                </th>
              </tr>
           <%}%>
           
           <!------------------------------- Total --------------------------------->
           <tr class="trHdr01"><td class="Separator02" nowrap colspan=10>&nbsp;</td></tr> 
           <%
               shporsts.setTotal();
               
               String sGrp = shporsts.getGrp();
               String sGrpNm = shporsts.getGrpNm();
               String sTyRet = shporsts.getTyRet();
               String sTyCst = shporsts.getTyCst();
               String sLyRet = shporsts.getLyRet();
               String sLyCst = shporsts.getLyCst();
               String sTyMargPrc = shporsts.getTyMargPrc();
               String sLyMargPrc = shporsts.getLyMargPrc();
               String sTyShpCost = shporsts.getTyShpCost();
               String sLyShpCost = shporsts.getLyShpCost();
               String sTyShpCharge = shporsts.getTyShpCharge();
               String sLyShpCharge = shporsts.getLyShpCharge();       
               String sTyMargWShp = shporsts.getTyMargWShp();
               String sLyMargWShp = shporsts.getLyMargWShp();
           %>
              <tr id="trId" class="trDtl03">
                <td class="td11" nowrap><%=sGrpNm%></td>
                <td class="td12" nowrap>$<%=sTyRet%></td>
                <td class="td12" nowrap>$<%=sTyCst%></td>
                <td class="td12" nowrap><%=sTyMargPrc%>%</td>
                <td class="td12" nowrap>$<%=sTyShpCost%></td>
                <td class="td12" nowrap>$<%=sTyShpCharge%></td>
                <td class="td12" nowrap><%=sTyMargWShp%>%</td>
                </th>
              </tr>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
shporsts.disconnect();
shporsts = null;
}
%>