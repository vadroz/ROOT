<!DOCTYPE html>	
<%@ page import="inventoryreports.InvPutaway, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelDiv = request.getParameterValues("Div");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   
   String sSelDivNm = request.getParameter("DivName");   
   String sSelDptNm = request.getParameter("DptName");
   String sSelClsNm = request.getParameter("ClsName");
   
   String sSort = request.getParameter("Sort");
   
   if(sSelDiv == null){ sSelDiv = new String[]{"ALL"}; }
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
     response.sendRedirect("SignOn1.jsp?TARGET=InvPutaway.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	InvPutaway invputawy = new InvPutaway();
	invputawy.setInvSum(sSelDiv, sSelDpt, sSelCls, sSort, "vrozen");
	int iNumOfInv = invputawy.getNumOfInv();
	int iNumOfGrp = invputawy.getNumOfGrp();	 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Putaway Stock Report</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelDiv = [<%=invputawy.cvtToJavaScriptArray(sSelDiv)%>];
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";

var SelDivNm = "<%=sSelDivNm%>";
var SelDptNm = "<%=sSelDptNm%>";
var SelClsNm = "<%=sSelClsNm%>";

var NumOfInv = "<%=iNumOfInv%>"
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
   setFilter();
}
//===================================================================
//drill down
//===================================================================
function drillDown(grp, grpnm)
{	
	var url = "InvPutaway.jsp?";		
	
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
	var url = "InvPutaway.jsp?";		
	
	for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]; }
	url += "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		+ "&Cls=" + SelCls + "&ClsName=" + SelClsNm
		+ "&Sort=" + sort
		; 
	
	window.location.href = url;
}
//===================================================================
// show Putaway details
//===================================================================
function showDtl(src,  desc)
{
    var url = "InvPutawayDtl.jsp?Src=" + src 
     + "&Desc=" + desc;
    
	window.open(url);
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
	for(var i=0; i < NumOfInv ; i++)
	{
		var rownm = "trInv" + i;
		var descnm = "tdDesc" + i;
		var row = document.all[rownm];
		var desc = document.all[descnm];
		
		var disp = "none";
		for(var j=0; j < filter.length ; j++)
		{
			if(filter[j].checked && desc.innerHTML.indexOf(filter[j].value) >= 0 )
			{ 
				disp = "table-row";
				if(clsnm =="trDtl06"){ clsnm = "trDtl04";}
				else { clsnm = "trDtl06"; }
				break;
			}
		}		
		row.style.display = disp;
		row.className = clsnm;
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
            <br>Putaway Stock Report 
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
      		 &nbsp; &nbsp; &nbsp;
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="ORDER" checked>PO/Receipts
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="TRANS" >Transfers
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="ALLOCATION" > Allocation
      		 &nbsp; <input type="checkbox" name="inpFilter" onclick="setFilter()" value="STOCK" > Stock Adjs
      		 &nbsp; <a href="javascript: setFilterAll(true)">All</a>
      		 &nbsp; <a href="javascript: setFilterAll(false)">Reset</a>
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02"><a href="javascript: resort('DATE')">Date</a></th>
          <th class="th02">Description</th>          
          <th class="th02">
          	<a href="javascript: resort('GRP')">
          		<%if(!sSelDpt.equals("ALL")){%>Class<%}
             	else if(!sSelDiv.equals("ALL")){%>Dpt<%}
             	else if(sSelDiv.equals("ALL")){%>Div<%}%>
          	</a>
          </th>
          <th class="th02">Dst</th>
          <th class="th02">P.O.<br>Str</th>
          <th class="th02">Str<br>Need</th>
          <th class="th02"><a href="javascript: resort('VEN')">Vendor</a></th>
          <th class="th02"><a href="javascript: resort('VENNM')">Vendor Name</a></th>
          <th class="th02"><a href="javascript: resort('QTYIN')">Rec'd<br>Units</a></th>
          <th class="th02"><a href="javascript: resort('QTY')">Remaining<br>Units</a></th> 
          <th class="th02"><a href="javascript: resort('COUNT')">Record<br>Count</a></th>
          <th class="th02"><a href="javascript: resort('COST')">Cost</a></th>
          <th class="th02"><a href="javascript: resort('RET')">Ret</a></th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%
             String sTrCls = "trDtl06";
           %>
         <%for(int i=0; i < iNumOfInv; i++) {        	   
        	invputawy.setDetail();
   			  
        	String sGrp = invputawy.getGrp();
			String sGrpNm = invputawy.getGrpNm();
			String sVen = invputawy.getVen();
			String sVenNm = invputawy.getVenNm();	
			String sQtyIn = invputawy.getQtyIn();
			String sQty = invputawy.getQty();
			String sCost = invputawy.getCost();
			String sRet = invputawy.getRet();
			String sCount = invputawy.getCount();			
			String sFrDate = invputawy.getFrDate();
			String sToDate = invputawy.getToDate();
			String sDst = invputawy.getDst();
			String sDesc = invputawy.getDesc();
			String sSrc = invputawy.getSrc();
			String sPoStr = invputawy.getPoStr();
			String sNeed = invputawy.getNeed();
			
			if(sTrCls.equals("trDtl06")){ sTrCls = "trDtl04"; }
			else{ sTrCls = "trDtl06"; }
           %>                           
             <tr id="trInv<%=i%>" class="<%=sTrCls%>">                                 
                <td class="td11" nowrap><%=sFrDate%></td>                
                <td class="td11" id="tdDesc<%=i%>" nowrap><a href="javascript: showDtl('<%=sSrc%>','<%=sDesc%>')"><%=sDesc%></a></td>
                <td class="td11" nowrap><%=sGrp%></td> 
                <td class="td11" nowrap><%=sDst%></td>
                <td class="td12" nowrap><%=sPoStr%></td>
                <td class="td12" nowrap><%if(!sDst.equals("")){%><%=sNeed%>%<%} else{%>&nbsp;<%}%></td>
                <td class="td11" nowrap><%=sVen%></td>
                <td class="td11" nowrap><%=sVenNm%></td> 
                <td class="td12" nowrap><%=sQtyIn%></td>
                <td class="td12" nowrap><%=sQty%></td>
                <td class="td12" nowrap><%=sCount%></td>
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
        	   invputawy.setGrpTot();
   			   String sGrp = invputawy.getGrp();
   			   String sGrpNm = invputawy.getGrpNm();
   			   String sQtyIn = invputawy.getQtyIn();
   			   String sQty = invputawy.getQty();
   			   String sCost = invputawy.getCost();
   			   String sRet = invputawy.getRet(); 
   			   String sCount = invputawy.getCount();	
           %> 
           <tr id="trTotal" class="trDtl02">
                <td class="td11" colspan=3>
                   <%if(sSelCls.equals("ALL")){%><a href="javascript: drillDown('<%=sGrp%>', '<%=sGrpNm%>')"><%=sGrp%> - <%=sGrpNm%></a><%}
                   else {%><%=sGrp%> - <%=sGrpNm%><%}%>
                </td>
                <td class="td18" colspan=5 ></td>
                <td class="td12" nowrap><%=sQtyIn%></td>
                <td class="td12" nowrap><%=sQty%></td>
                <td class="td12" nowrap><%=sCount%></td>
                <td class="td12" nowrap>$<%=sCost%></td>
                <td class="td12" nowrap>$<%=sRet%></td>    
           </tr>
           <%}%>
           
           
           <tr id="trTotal" class="Divider">
               <td class="td18" colspan=25>&nbsp;</td>
           </tr>  
           
           <%
           	invputawy.setRepTot();
   			String sGrp = invputawy.getGrp();
   			String sGrpNm = invputawy.getGrpNm();
   			String sQtyIn = invputawy.getQtyIn();
   			String sQty = invputawy.getQty();
   			String sCost = invputawy.getCost();
   			String sRet = invputawy.getRet();
   			String sCount = invputawy.getCount();	
           %>
           
           <tr id="trTotal" class="trDtl03">
                <td class="td11" colspan=3>Report Total</td>
                <td class="td18" colspan=5></td>
                <td class="td12" nowrap><%=sQtyIn%></td>
                <td class="td12" nowrap><%=sQty%></td>
                <td class="td12" nowrap><%=sCount%></td>
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
invputawy.disconnect();
invputawy = null;
}
%>