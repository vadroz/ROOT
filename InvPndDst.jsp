<!DOCTYPE html>	
<%@ page import="inventoryreports.InvPndDst, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelStr = request.getParameter("Str");

   String sSelDiv = request.getParameter("Div");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   
   String sSelDivNm = request.getParameter("DivName");   
   String sSelDptNm = request.getParameter("DptName");
   String sSelClsNm = request.getParameter("ClsName");
   
   String sSelSts = request.getParameter("Sts");
   String sSort = request.getParameter("Sort");
   
   if(sSelDiv == null){ sSelDiv = "ALL"; }
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
   
   if(sSelDivNm == null){ sSelDivNm = "All Divisions"; }
   if(sSelDptNm == null){ sSelDptNm = "All Departments"; }
   if(sSelClsNm == null){ sSelClsNm = "All Classes"; }
   
   if(sSelStr == null){ sSelStr = "ALL"; }
   if(sSelSts == null){ sSelSts = "ALL"; }
   if(sSort == null){ sSort = "DDATE"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=InvPndDst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	InvPndDst invputawy = new InvPndDst();
	invputawy.setInvSum(sSelStr, sSelDiv, sSelDpt, sSelCls, sSelSts, sSort, sUser);
	int iNumOfDst = invputawy.getNumOfDst();  
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Pending Distro Report</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelDiv = "<%=sSelDiv%>";
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";

var SelDivNm = "<%=sSelDivNm%>";
var SelDptNm = "<%=sSelDptNm%>";
var SelClsNm = "<%=sSelClsNm%>";

var SelSts = "<%=sSelSts%>";

var NumOfDst = "<%=iNumOfDst%>"
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
   //setFilter();
}
//===================================================================
//drill down
//===================================================================
function drillDown(grp, grpnm)
{	
	var url = "InvPndDst.jsp?";		
	
	if(SelDpt != "ALL")
	{ 
		url += "&Div=" + SelDiv + "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		     + "&Cls=" + grp + "&ClsName=" + grpnm;
	}
	else if(SelDiv != "ALL" && SelDpt == "ALL")
	{ 
		url += "&Div=" + SelDiv + "&DivName=" + SelDivNm + "&Dpt=" + grp + "&DptName=" + grpnm;
	}
	else if(SelDiv == "ALL"){ url += "&Div=" + grp + "&DivName=" + grpnm;}
	
	
	window.location.href = url;
} 
//===================================================================
// re-sort report
//===================================================================
function resort(sort)
{
	var url = "InvPndDst.jsp?";		
	
	url += "&Div=" + SelDiv + "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		+ "&Cls=" + SelCls + "&ClsName=" + SelClsNm
		+ "&Sts=" + SelSts
		+ "&Sort=" + sort
		; 
	
	window.location.href = url;
}
//===================================================================
//set all filters on/off
//===================================================================
function setFilterAll(type)
{
	var filter = document.all.inpFilter;
	for(var i=0; i < filter.length ; i++)
	{
		filter[i].checked = type;
	}
	
	setFilter();
}
//===================================================================
// set filter
//===================================================================
function setFilter()
{
	var filter = document.all.inpFilter;
	var clsnm = "trDtl06";
	for(var i=0; i < NumOfDst ; i++)
	{
		var rownm = "trInv" + i;
		var stsnm = "tdSts" + i;
		var row = document.all[rownm];
		var sts = document.all[stsnm];
		
		var disp = "none";
		for(var j=0; j < filter.length ; j++)
		{
			var stsval = sts.innerHTML;
			if(stsval == "P" ) { stsval = "M"; }
			
			if(filter[j].checked && stsval.indexOf(filter[j].value) >= 0)
			{ 
				disp = "table-row";
				if(clsnm =="trDtl06"){ clsnm = "trDtl04";}
				else { clsnm = "trDtl06"; }
				break;
			}	
		}		
		row.style.display = disp;
		//row.className = clsnm;
	}
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
            <br>Pending Distribution Report 
             <%if(!sSelDiv.equals("ALL")){%><br>Div: <%=sSelDiv%>-<%=sSelDivNm%><%}%>
             <%if(!sSelDpt.equals("ALL")){%><br>Dpt: <%=sSelDpt%>-<%=sSelDptNm%><%}%>
             <%if(!sSelCls.equals("ALL")){%><br>Cls: <%=sSelCls%>-<%=sSelClsNm%><%}%>              
            </b>                                    
          </th>
        </tr>
        <tr>
          <td>
             <a href="../"><font color="red" size="-1">Home</font></a>&#62;
      		 <font size="-1">This Page</font>  
      		 
      		 &nbsp; &nbsp; &nbsp;
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="R" checked>Allocated
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="C" checked>Pick Run
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="M" checked> Pick Completed
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="T" checked> Shipped
      		 &nbsp; <a href="javascript: setFilterAll(true)">All</a>
      		 &nbsp; <a href="javascript: setFilterAll(false)">Reset</a>
      		 
      		 
      		        		 
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02"><a href="javascript: resort('DSTR')">Dest<br>Str</a></th>
          <th class="th02">Distro<br>Number</th>
          <th class="th02"><a href="javascript: resort('DDATE')">Dist Date</a></th>
          <th class="th02">Cartons</th>
          <th class="th02">Status</th>
          <th class="th02">Status<br>Date</th>
          <th class="th02">Div<br>#</th>
          <th class="th02">Dpt<br>#</th>
          <th class="th02">Cls<br>#</th>
          <th class="th02">Short<br>SKU</th>
          <th class="th02">UPC</th>
          <th class="th02">Item<br>Description</th>
          <th class="th02">Vendor</th>
          <th class="th02">Orig<br>Qty</th>
          <th class="th02">Retail</th>
          <th class="th02">PO#</th>
          <th class="th02">Receipt<br>#</th>
          <th class="th02">Pick<br>#</th>
          <th class="th02">Pick<br>Date</th>
          <th class="th02">Alloc<br>#</th>
          <th class="th02">Shipment<br>#</th>                                  
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%
             String sTrCls = "trDtl04";
           %>
         <%for(int i=0; i < iNumOfDst; i++) {        	   
        	invputawy.setDetail();
   			  
        	String sDistro = invputawy.getDistro();
			String sDstStr = invputawy.getDstStr();
			String sDiv = invputawy.getDiv();
			String sDpt = invputawy.getDpt();
			String sCls = invputawy.getCls();			
			String sVen = invputawy.getVen();
			String sSty = invputawy.getSty();
			String sClr = invputawy.getClr();
			String sSiz = invputawy.getSiz();
			String sSku = invputawy.getSku();
			String sDesc = invputawy.getDesc();
			String sUpd = invputawy.getUpd();
			String sSts = invputawy.getSts();			
			String sRet = invputawy.getRet();	
			String sCost = invputawy.getCost();
			String sQty = invputawy.getQty();
			String sOrQty = invputawy.getOrQty();
			String sDate = invputawy.getDate();
			String sRct = invputawy.getRct();
			String sAlloc = invputawy.getAlloc();
			String sShip = invputawy.getShip();
			String sVenNm = invputawy.getVenNm();
			String sPoNum = invputawy.getPoNum();
			String sPick = invputawy.getPick();
			String sStsDt = invputawy.getStsDt();
			String sCarton = invputawy.getCarton();
			String sPickDt = invputawy.getPickDt();
			
			if(sDstStr.equals("99999"))
			{ 
				sTrCls = "trDtl03";
				sDstStr = "&nbsp;";
				sDate = "&nbsp;";
				sStsDt = "&nbsp;";							
			}
			else{ sTrCls = "trDtl04"; }
			
           %>                           
             <tr id="trInv<%=i%>" class="<%=sTrCls%>">                                 
                <td class="td11" nowrap><%=sDstStr%></td>
                <td class="td11" nowrap><%=sDistro%></td>
                <td class="td11" nowrap><%=sDate%></td>
                <td class="td11" nowrap><%=sCarton%></td>
                <td class="td18" id="tdSts<%=i%>" nowrap><%=sSts%></td>
                <td class="td11" nowrap><%=sStsDt%></td>
                <td class="td11" nowrap><%=sDiv%></td>
                <td class="td11" nowrap><%=sDpt%></td>
                <td class="td11" nowrap><%=sCls%></td>
                <td class="td11" nowrap><%=sSku%></td>
                <td class="td11" nowrap><%=sUpd%></td>
                <td class="td11" id="tdDesc<%=i%>" nowrap><%=sDesc%></td> 
                <td class="td11" nowrap><%=sVenNm%></td>  
                <td class="td12" nowrap><%=sOrQty%></td>
                <td class="td12" nowrap><%=sRet%></td> 
                <td class="td11" nowrap><%=sPoNum%></td>
                <td class="td12" nowrap><%=sRct%></td>
                <td class="td11" nowrap><%=sPick%></td>
                <td class="td11" nowrap><%=sPickDt%></td>
                <td class="td12" nowrap><%=sAlloc%></td>
                <td class="td12" nowrap><%=sShip%></td>                               
              </tr>
              
               
              <script></script>	
           <%}%>
           
           
           
           
           <!-- ==============Total Line  -->
           
           <tr id="trTotal" class="Divider">
               <td class="td18" colspan=25>&nbsp;</td>
           </tr>  
           
           <%
           	invputawy.setRepTot();
           	String sRet = invputawy.getRet();	
			String sCost = invputawy.getCost();
			String sQty = invputawy.getQty();
			String sOrQty = invputawy.getOrQty();
           %>
           
           <tr id="trTotal" class="trDtl03">
                <td class="td11" colspan=3>Report Total</td>
                <td class="td18" colspan=10>&nbsp;</td>
                <td class="td12" nowrap><%=sOrQty%></td>
                <td class="td12" nowrap><%=sRet%></td>
                <td class="td18" colspan=10>&nbsp;</td>
           </tr>
         </table>
         <br>&nbsp;<br>&nbsp;<br>&nbsp;
      <!----------------------- end of table ------------------------>
      </tr>
   </table>   
 </body>
</html>
<%
invputawy.disconnect();
invputawy = null;
}
%>