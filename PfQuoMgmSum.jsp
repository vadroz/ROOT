<!DOCTYPE html>	
<%@ page import="patiosales.PfQuoMgmSum, java.util.*, java.text.*"%>
<%
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "STR"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PfQuoMgmSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	PfQuoMgmSum ordlst = new PfQuoMgmSum(sFrDate, sToDate, sSort, sUser);
	int iNumOfStr = ordlst.getNumOfStr();
	int iNumOfGrp = 3;
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
	var url = "PfQuoMgmSum.jsp?"
	 + "FrDate=" + FrDate
	 + "&ToDate=" + ToDate
	 + "&Sort=" + sort
	
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
            <br>Patio Furniture - Quote Management Summary   
            <br>Dates: <%=sFrDate%> - <%=sToDate%>
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PfQuoMgmSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th05" rowspan=2 colspan=3>&nbsp;</th>
          <th class="th02" rowspan=3>&nbsp;</th>
          <th class="th02" style="background:#cccfff" colspan=4>Follow Up Steps</th>
        </tr>
        <tr class="trHdr01">          
          <th class="th02" style="background:pink" colspan=3>Delinquent</th>
          <th class="th02" style="background:lightgreen" rowspan=2>Non-Delinquent</th>                    
        </tr>
        <tr class="trHdr01">
          <th class="th02" >Store</th>
          <th class="th02"># of Orders</th>
          <th class="th02">Total</th>          
          <th class="th02" style="background:pink">Step 1</th>
          <th class="th02" style="background:pink">Step 2</th>
          <th class="th02" style="background:pink">Step 3</th>
        </tr>
        
       
<!------------------------------- Detail --------------------------------->
           <%for(int i=0; i < iNumOfStr; i++) {
        	   ordlst.setQuoCounts();

    	       String sStr = ordlst.getStr();
    	       String sQuoCnt = ordlst.getQuoCnt();
    	       String sQuoAmt = ordlst.getQuoAmt();
    	       
    	       String sFup1b = ordlst.getFup1b();
    	       String sFup2b = ordlst.getFup2b();
    	       String sFup3b = ordlst.getFup3b();
    	       String sFup4b = ordlst.getFup4b();
    	       String sFupGood = ordlst.getFupGood();
           %>
              <tr id="trId" class="trDtl04">
                <td class="td11" nowrap><%=sStr%></td>
                <td class="td12" nowrap><%=sQuoCnt%></td>
                <td class="td12" nowrap>$<%=sQuoAmt%></td>
                <td class="td12">&nbsp;</td>
                <td class="td12" nowrap><%=sFup1b%></td>
                <td class="td12" nowrap><%=sFup2b%></td>
                <td class="td12" nowrap><%=sFup3b%></td>
                <td class="td12" nowrap><%=sFupGood%></td>               
              </tr>
                      
              <%if(sStr.equals("50") || sStr.equals("86") || sStr.equals("68")){%>
           		<!------------------------------- Regional Total --------------------------------->
           		<tr class="trHdr01"><td class="Separator02" nowrap colspan=10>&nbsp;</td></tr>
           		<%
           			ordlst.setGrpTotals();
               
        	   		sStr = ordlst.getTot();
    	       		sQuoCnt = ordlst.getQuoCnt();
    	       		sQuoAmt = ordlst.getQuoAmt();
    	       
    	       		sFup1b = ordlst.getFup1b();
    	       		sFup2b = ordlst.getFup2b();
    	       		sFup3b = ordlst.getFup3b();
    	       		sFup4b = ordlst.getFup4b();
    	       		sFupGood = ordlst.getFupGood();
           		%>
              		<tr id="trId" class="trDtl02">
                		<td class="td11" nowrap><%=sStr%></td>
                		<td class="td12" nowrap><%=sQuoCnt%></td>
                		<td class="td12" nowrap>$<%=sQuoAmt%></td>
                		<td class="td12">&nbsp;</td>
                		<td class="td12" nowrap><%=sFup1b%></td>
                		<td class="td12" nowrap><%=sFup2b%></td>
                		<td class="td12" nowrap><%=sFup3b%></td>
                		<td class="td12" nowrap><%=sFupGood%></td>             
              		</tr>           		
           	  <%}%>			
           <%}%>
           <!------------------------------- Total --------------------------------->
           <tr class="trHdr01"><td class="Separator02" nowrap colspan=10>&nbsp;</td></tr> 
           <%
               ordlst.setTotals();
               
           String sStr = ordlst.getTot();
	       String sQuoCnt = ordlst.getQuoCnt();
	       String sQuoAmt = ordlst.getQuoAmt();
	       
	       String sFup1b = ordlst.getFup1b();
	       String sFup2b = ordlst.getFup2b();
	       String sFup3b = ordlst.getFup3b();
	       String sFup4b = ordlst.getFup4b();
	       String sFupGood = ordlst.getFupGood();
           %>
              <tr id="trId" class="trDtl03">
                <td class="td11" nowrap><%=sStr%></td>
                <td class="td12" nowrap><%=sQuoCnt%></td>
                <td class="td12" nowrap>$<%=sQuoAmt%></td>
                <td class="td12">&nbsp;</td>
                <td class="td12" nowrap><%=sFup1b%></td>
                <td class="td12" nowrap><%=sFup2b%></td>
                <td class="td12" nowrap><%=sFup3b%></td>
                <td class="td12" nowrap><%=sFupGood%></td>  
                </th>
              </tr>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
ordlst.disconnect();
ordlst = null;
}
%>