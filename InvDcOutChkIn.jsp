<!DOCTYPE html>	
<%@ page import="inventoryreports.InvDcOutstChkIn, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelDiv = request.getParameterValues("Div");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   
   String sSelDivNm = request.getParameter("DivName");   
   String sSelDptNm = request.getParameter("DptName");
   String sSelClsNm = request.getParameter("ClsName");
   
   String sSort = request.getParameter("Sort");
   
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
   
   if(sSelDivNm == null){ sSelDivNm = "All Divisions"; }
   if(sSelDptNm == null){ sSelDptNm = "All Departments"; }
   if(sSelClsNm == null){ sSelClsNm = "All Classes"; }
   if(sSort == null){ sSort = "DATE"; }
   
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=InvDcOutChkIn.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	InvDcOutstChkIn indcout = new InvDcOutstChkIn();
	indcout.setInvSum(sSelDiv, sSelDpt, sSelCls, sSort, "vrozen");
	int iNumOfCin = indcout.getNumOfCin();
	int iNumOfGrp = indcout.getNumOfGrp();	 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Inv.Outstanding Check-In</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelDiv = [<%=indcout.cvtToJavaScriptArray(sSelDiv)%>];
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";

var SelDivNm = "<%=sSelDivNm%>";
var SelDptNm = "<%=sSelDptNm%>";
var SelClsNm = "<%=sSelClsNm%>";

//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//===================================================================
//drill down
//===================================================================
function drillDown(grp, grpnm)
{	
	var url = "InvDcOutChkIn.jsp?";		
	
	if(SelDpt != "ALL")
	{ 		
		url += "&Div=" + SelDiv[0] + "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		     + "&Cls=" + grp + "&ClsName=" + grpnm;
	}
	else if(SelDiv[0] != "ALL" && SelDiv.length == 1 && SelDpt == "ALL")
	{ 
		url += "&Div=" + SelDiv[0] + "&DivName=" + SelDivNm + "&Dpt=" + grp + "&DptName=" + grpnm;
	}
	else if(SelDiv[0] == "ALL" || SelDiv.length > 1){ url += "&Div=" + grp + "&DivName=" + grpnm;}
	
	
	window.location.href = url;
} 
//===================================================================
// re-sort report
//===================================================================
function resort(sort)
{
	var url = "InvDcOutChkIn.jsp?";		
	
	url += "&Div=" + SelDiv + "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		+ "&Cls=" + SelCls + "&ClsName=" + SelClsNm
		+ "&Sort=" + sort
		; 
	
	window.location.href = url;
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
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Outstanding Check-In Report 
             <%if(sSelDiv.length > 1){%><br>Divisions: 
                  <%String sComa = ""; %>
          	      <%for(int i=0; i < sSelDiv.length; i++){%><%=sComa + sSelDiv[i]%><%sComa = ",";%><%} %>
             <%} else {%><br>Division: <%=sSelDiv[0]%>-<%=sSelDivNm%><%}%>
             <%if(!sSelDpt.equals("ALL")){%><br>Dpt: <%=sSelDpt%>-<%=sSelDptNm%><%}%>
             <%if(!sSelCls.equals("ALL")){%><br>Cls: <%=sSelCls%>-<%=sSelClsNm%><%}%>              
            </b>                                    
          </th>
        </tr>
        <tr>
          <td>
             <a href="../"><font color="red" size="-1">Home</font></a>&#62;
      		 <font size="-1">This Page</font>   
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02"><a href="javascript: resort('CINUM')">CI#</a></th>
          <th class="th02">Str</th>
          <th class="th02">P.O.<br>Str</th>
          <th class="th02">ASN</th>
          <th class="th02"><a href="javascript: resort('DATE')">Date</a></th>
          <th class="th02">User</th>
          <th class="th02">Freight<br>Company</th>
          <th class="th02">Cartons<br>Shipped</th>
          <th class="th02">Cartons<br>Received</th>
          <th class="th02"><a href="javascript: resort('VEN')">Vendor Name</a></th>
          <th class="th02">Str<br>Need</th>
          <th class="th02">P.O. #</th>
          <th class="th02">B.O. #</th>
          <th class="th02"><a href="javascript: resort('GRP')">
             <%if(!sSelDpt.equals("ALL")){%>Class<%}
             else if(!sSelDiv.equals("ALL")){%>Dpt<%}
             else if(sSelDiv.equals("ALL")){%>Div<%}%>
            </a>             
          </th>
          <th class="th02"><a href="javascript: resort('BUYER')">Buyer</a></th>
          <th class="th02">BSR</th>
          <th class="th02"><a href="javascript: resort('QTY')">Chk-In<br>Units</a></th>
          <th class="th02"><a href="javascript: resort('COST')">Chk-In<br>Cost</a></th>
          <th class="th02"><a href="javascript: resort('RET')">Chk-In<br>Retail</a></th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%
             String sTrCls = "trDtl06";
           %>
         <%for(int i=0; i < iNumOfCin; i++) {        	   
        	indcout.setDetail();
   			String sAsn = indcout.getAsn();
   			String sDate = indcout.getDate();
   			String sRecUsr = indcout.getUser();
   			String sCiNum = indcout.getCiNum();
   			String sVen = indcout.getVen();
   			String sPoNum = indcout.getPoNum();
   			String sGrp = indcout.getGrp();
   			String sQty = indcout.getQty();
   			String sCost = indcout.getCost();
   			String sRet = indcout.getRet();
   			String sGrpNm = indcout.getGrpNm();
   			String sVenNm = indcout.getVenNm();
   			String sCtnShp = indcout.getCtnShp();
   			String sCtnRcv = indcout.getCtnRcv();
   			String sBuyer = indcout.getBuyer();
   			String sBsr = indcout.getBsr();
   			String sShpNm = indcout.getShpNm();
   			String sType = indcout.getType();
			String sBolNum = indcout.getBolNum();
			String sStr = indcout.getStr();
			String sPoStr = indcout.getPoStr();
			String sNeed = indcout.getNeed();
			
			if(sTrCls.equals("trDtl06")){ sTrCls = "trDtl04"; }
			else{ sTrCls = "trDtl06"; }
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>">                
                <td class="td11" nowrap><%=sAsn%></td>    
                <td class="td11" nowrap><%=sStr%></td> 
                <td class="td11" nowrap><%=sPoStr%></td>
                <td class="td11" nowrap><%=sType%></td>
                <td class="td11" nowrap><%=sDate%></td>
                <td class="td11" nowrap><%=sRecUsr%></td>
                <td class="td11" nowrap><%=sShpNm%></td>  
                <td class="td12" nowrap><%=sCtnShp%></td>
                <td class="td12" nowrap><%=sCtnRcv%></td>
                <td class="td11" nowrap><%=sVenNm%></td>
                <td class="td12" nowrap><%=sNeed%>%</td>
                <td class="td11" nowrap><%=sPoNum%></td>
                <td class="td11" nowrap><%=sBolNum%></td>
                <td class="td11" nowrap><%=sGrp%></td>
                <td class="td11" nowrap><%=sBuyer%></td>
                <td class="td11" nowrap><%=sBsr%></td>
                <td class="td12" nowrap><%=sQty%></td>
                <td class="td12" nowrap><%=sCost%></td>
                <td class="td12" nowrap><%=sRet%></td>                                
              </tr>
              <script></script>	
           <%}%>
           
           <!-- ==============Total Line  -->
           
           <tr id="trTotal" class="Divider">
               <td class="td18" colspan=25>&nbsp;</td>
           </tr>     
           
           <%
           for(int i=0; i < iNumOfGrp; i++)
   		   {
        	   indcout.setGrpTot();
   			   String sGrp = indcout.getGrp();
   			   String sGrpNm = indcout.getGrpNm();
   			   String sQty = indcout.getQty();
   			   String sCost = indcout.getCost();
   			   String sRet = indcout.getRet();   			   
           %> 
           <tr id="trTotal" class="trDtl02">
                <td class="td11" colspan=3>
                   <%if(sSelCls.equals("ALL")){%><a href="javascript: drillDown('<%=sGrp%>', '<%=sGrpNm%>')"><%=sGrp%> - <%=sGrpNm%></a><%}
                   else {%><%=sGrp%> - <%=sGrpNm%><%}%>
                </td>
                <td class="td18" colspan=13 ></td>
                <td class="td12" nowrap><%=sQty%></td>
                <td class="td12" nowrap>$<%=sCost%></td>
                <td class="td12" nowrap>$<%=sRet%></td>    
           </tr>
           <%}%>
           
           
           <tr id="trTotal" class="Divider">
               <td class="td18" colspan=25>&nbsp;</td>
           </tr>  
           
           <%
           	indcout.setRepTot();
   			String sGrp = indcout.getGrp();
   			String sGrpNm = indcout.getGrpNm();
   			String sQty = indcout.getQty();
   			String sCost = indcout.getCost();
   			String sRet = indcout.getRet();
   			System.out.println(" Total " + sQty);
           %>
           
           <tr id="trTotal" class="trDtl03">
                <td class="td11" colspan=3>Report Total</td>
                <td class="td18" colspan=13 ></td>
                <td class="td12" nowrap><%=sQty%></td>
                <td class="td12" nowrap>$<%=sCost%></td>
                <td class="td12" nowrap>$<%=sRet%></td>    
           </tr>
         </table>
         <br>&nbsp;<br>&nbsp;<br>&nbsp;
      <!----------------------- end of table ------------------------>
      </tr>
   </table>   
 </body>
</html>
<%
indcout.disconnect();
indcout = null;
}
%>