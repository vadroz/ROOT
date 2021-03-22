<!DOCTYPE html>	
<%@ page import="inventoryreports.AgedSumByDiv, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelDiv = request.getParameter("SelDiv");
   String sSelStr = request.getParameter("SelStr");
   String sNumMon = request.getParameter("NumMon");   
   String sSort = request.getParameter("Sort");
   
   if(sSelDiv == null){ sSelDiv = "ALL"; }
   if(sSelStr== null){ sSelStr = "ALL"; }
   if(sNumMon == null){ sNumMon = "12"; }
   if(sSort == null){ sSort = "Div"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=AgedSumByDiv.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	AgedSumByDiv agedSum = new AgedSumByDiv();	
	
	agedSum.setAged(sSelDiv, sSelStr, sNumMon, sSort, sUser);

	int iNumOfMon = agedSum.getNumOfMon();
	int iNumOfAge = agedSum.getNumOfAge();
	
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Aged Summary Report</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Store = "<%=sSelStr%>";
var Div = "<%=sSelDiv%>";
var NumMon = "<%=sNumMon%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";
var NumOfAge = "<%=iNumOfAge%>";

var progressIntFunc = null;
var progressTime = 0;

//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//reload page
//==============================================================================
function restart()
{
	window.location.reload();  
}
//==============================================================================
// re-sort page
//==============================================================================
function resort(sort)
{		
	
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
}</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th >
            <b>Retail Concepts, Inc
            <br>Aged Summary Report
                      
            <br>Div: <%=sSelDiv%>
            <br>Store: <%=sSelStr%>
            </b>
            <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
                <a href="AgedSumByDivSel.jsp"><font color="red" size="-1">Selection</font></a>&#62; 
            <font size="-1">This Page</font>
             
          </th>
       </tr>      
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=2>Divisions</th>
          <th class="th02" colspan="<%=iNumOfMon+2%>">Months</th>
          <th class="th02" rowspan=2>Aged<br>%</th>
        </tr>
        
        <tr class="trHdr01">
          <th class="th02" >Current<br>Aged<br>Inv</th>
          <%for(int i=0; i < iNumOfMon; i++)
            {
        	  agedSum.setMonYear();
        	  String sMon = agedSum.getMon();
  			  String sMonNm = agedSum.getMonNm();
  			  String sYear = agedSum.getYear();
          %>
            <th class="th02" ><%=sMonNm %><br><%=sYear%></th>
          <%}%>
          <th class="th02" >Current<br>On-hands<br>Inv</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl04"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfAge; i++) {        	   
        	   agedSum.setDetail();
   			    
        	   String sDiv = agedSum.getDiv();
   			   String sDivNm = agedSum.getDivNm();
   		       String [] sUnit = agedSum.getUnit();			
   			   String [] sCost = agedSum.getCost();
   			   String [] sRet = agedSum.getRet();
   			   String sPrcUnit = agedSum.getPrcUnit();
   			   String sPrcCost = agedSum.getPrcCost();
   			   String sPrcRet = agedSum.getPrcRet();
   			   
   			   if(sDivNm.equals("Total")){ sTrCls = "trDtl15"; }
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>">
                <td class="td11" nowrap>
                   <%if(!sDivNm.equals("Total")){%><%=sDiv%> - <%}%><%=sDivNm%> 
                </td>
                <td class="td12" nowrap><%=sCost[iNumOfMon+1]%></td>
                <%for(int j=0; j < iNumOfMon; j++){%>
                    <td class="td12" nowrap><%=sCost[j]%></td>
                <%}%>                
                <td class="td12" nowrap><%=sCost[iNumOfMon]%></td>
                <td class="td12" nowrap><%=sPrcCost%></td>
              </tr>
              <script></script>	
           <%}%>
           
            
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   
 </body>
</html>
<%
agedSum.disconnect();
agedSum = null;
}
%>