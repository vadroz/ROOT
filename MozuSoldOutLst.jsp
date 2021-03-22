<%@ page import="java.text.*, java.util.*, mozu_com.MozuSoldOutLst
, rciutility.RunSQLStmt, java.sql.*"%>
<%
   String sSite = request.getParameter("Site");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sDateType = request.getParameter("Type");
   String sSort = request.getParameter("Sort");
   
   
   if(sSort == null){ sSort = "DATE"; }
   if(sDateType == null){ sDateType = "D"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuSoldOutLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	if(sSite == null)
	{
		String sStmt = null;
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rs = null;
	    
	    sStmt = "select BxSite from RCI.MOSNDBX";           
		System.out.println(sStmt);
	    runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		rs = runsql.runQuery();
		if(runsql.readNextRecord())
		{
			sSite = runsql.getData("BxSite");
		}	
		rs.close();
		runsql.disconnect();
	}
	
	MozuSoldOutLst soldlst = new MozuSoldOutLst();
	soldlst.setSoldOutLst(sSite, sFrom, sTo, sDateType, sSort, sUser);
	int iNumOfSlo = soldlst.getNumOfSlo();
%>

<HTML>
<HEAD>
<title>Vendor Attribution Attribution</title>
 </HEAD>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css"> 

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
 
<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================
var Site = "<%=sSite%>";
var SelFrom = "<%=sFrom%>";
var SelTo = "<%=sTo%>";
var DateType = "<%=sDateType%>";
var Sort = "<%=sSort%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHist"]);
}
//==============================================================================
// get Oders by requered status
//==============================================================================
function getOrderList(sts, div)
{
	var url = "MozuSoldOutDtl.jsp?div=" + div
	 + "&from=" + SelFrom
	 + "&to=" + SelTo
	 + "&sts=" + sts;
	
	window.frame1.location.href = url;
}
//==============================================================================
//show order/sku list for selected date
//==============================================================================
function showOrdSku(div, ord, sku, sn, sts, ret)
{
	var hdr = "SKU List for Division:" + div;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	 + "<tr>"
	 	+ "<td class='BoxName' nowrap>" + hdr + "</td>"
 		+ "<td class='BoxClose' valign=top>"
  	  		+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
 		+ "</td></tr>"
	 + "<tr><td class='Prompt' colspan=2  align=center>" + popOrdSku(div, ord, sku, sn, sts, ret)
	 + "</td></tr>"
	+ "</table>"
	
	document.all.dvItem.style.width=250;
	document.all.dvItem.style.height=250;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate order/sku list panel
//==============================================================================
function popOrdSku(div, ord, sku, sn, sts, ret)
{
	var panel = "<div id='dvInt' class='dvInternal'><br>";
	
	panel += "<table class='tbl02' id='tblLog'>"
		+ "<tr class='trHdr01'>"
			+ "<th class='th04'>Order</th>"
			+ "<th class='th04'>SKU</th>"
			+ "<th class='th04'>S/N</th>"
			+ "<th class='th04'>Status</th>"
			+ "<th class='th04'>Ret</th>"
		+ "</tr>"
	for(var i=0; i < ord.length; i++)
	{
		panel += "<tr class='trDtl06'>"
 			+ "<td class='td11' nowrap>" + ord[i] + "</td>"
 			+ "<td class='td11' nowrap>" + sku[i] + "</td>"
 			+ "<td class='td11' nowrap>" + sn[i] + "</td>"
 			+ "<td class='td11' nowrap>" + sts[i] + "</td>"
 			+ "<td class='td11' nowrap>$" + ret[i] + "</td>"
	}

	panel += "</table></div>"
		+ "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"

	return panel;
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";	
}
//==============================================================================
// re-sort
//==============================================================================
function resort(sort)
{
	var url = "MozuSoldOutLst.jsp?Site=<%=sSite%>&From=<%=sFrom%>&To=<%=sTo%>"
	  + "&Sort=" + sort
	  + "&Type=<%=sDateType%>" 
	  ;
	window.location.href = url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>

<!----------------- beginning of table ------------------------>  
<table id="tbl01" border="1" cellPadding="0" cellSpacing="0">
   <tr id="trTopHdr" style="background:ivory; position: relative; top: expression(this.offsetParent.scrollTop-15);">
          <th colspan=45 align=center>
            <b>Retail Concepts, Inc
            <br>Mozu - Daily Sold Out List
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuSoldOutLstSel.jsp"><font color="red" size="-1">Select</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;                                                      
          </th>
        </tr> 
                
      <!-- ======================================================================= -->
      <tr id="trId" style="background:#FFE4C4; position: relative; top: expression(this.offsetParent.scrollTop-14);">
           <th class="th16" nowrap><a href="javascript: resort('Div')">Division</a></th>
           <th class="th16" nowrap><a href="javascript: resort('ShipQty')">Shipped<br>Qty</a></th>
           <th class="th16" nowrap><a href="javascript: resort('ShipRet')">Shipped<br>Ret</a></th>
           <th class="th16" nowrap><a href="javascript: resort('ShipPrc')">Shipped<br>Percent</a></th>
           <th class="th17" nowrap>&nbsp;</th>
           <th class="th16" nowrap><a href="javascript: resort('SoldQrty')">Sold Out<br>Qty</a></th>
           <th class="th16" nowrap><a href="javascript: resort('SoldRet')">Sold Out<br>Ret</a></th>
           <th class="th16" nowrap><a href="javascript: resort('SoldPrc')">Sold Out<br>Percent</a></th>
           <th class="th17" nowrap>&nbsp;</th>
           <th class="th16" nowrap><a href="javascript: resort('TotQty')">Total<br>Qty</a></th>
           <th class="th16" nowrap><a href="javascript: resort('TotRet')">Total<br>Ret</a></th>
        </tr> 
        <!----------------------- total line ------------------------>
        <%soldlst.setTotal();
          String sDiv = soldlst.getDiv();
		  String sDivNm = soldlst.getDivNm();
 		  String sShipQty = soldlst.getShipQty();     
 		  String sSloQty = soldlst.getSloQty();
 		  String sTotQty = soldlst.getTotQty();
 		  String sShpPrc = soldlst.getShpPrc();
 		  String sSloPrc = soldlst.getSloPrc();
 		  String sShipRet = soldlst.getShipRet();
 		  String sSloRet = soldlst.getSloRet();
 		  String sTotRet = soldlst.getTotRet();
 		%>
 		<tr id="trId"  class="trDtl12" style=" position: relative; top: expression(this.offsetParent.scrollTop-13);"> 
            <td class="td11" nowrap>Total</td>
            <td class="td11" nowrap><%=sShipQty%></td>
            <td class="td11" nowrap>$<%=sShipRet%></td>
            <td class="td11" nowrap><%=sShpPrc%>%</td>
            <td class="td16" nowrap>&nbsp;</td>
            <td class="td11" nowrap><%=sSloQty%></td>
            <td class="td11" nowrap>$<%=sSloRet%></td>
            <td class="td11" nowrap><%=sSloPrc%>%</td>
            <td class="td16" nowrap>&nbsp;</td>
            <td class="td11" nowrap><%=sTotQty%></td>
            <td class="td11" nowrap>$<%=sTotRet%></td>            
        </tr>       
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;        
        for(int i=0; i < iNumOfSlo; i++)
		{ 
			soldlst.setDetail();
			sDiv = soldlst.getDiv();
			sDivNm = soldlst.getDivNm();
	 		sShipQty = soldlst.getShipQty();     
	 		sSloQty = soldlst.getSloQty();
	 		sTotQty = soldlst.getTotQty();
	 		sShpPrc = soldlst.getShpPrc();
			sSloPrc = soldlst.getSloPrc();
			sShipRet = soldlst.getShipRet();
			sSloRet = soldlst.getSloRet();
			sTotRet = soldlst.getTotRet();
			
            bEven = !bEven;
         %>
         <tr id="trId" class="<%if(bEven) {%>trDtl06<%} else {%>trDtl04<%}%>">            
            <td class="td11" ><%=sDiv + " - " + sDivNm%>&nbsp;</td>
            <td class="td11" nowrap><a href="javascript: getOrderList('Shipped', '<%=sDiv%>');"><%=sShipQty%></a></td>
            <td class="td11" nowrap>$<%=sShipRet%></td>
            <td class="td11" nowrap><%=sShpPrc%>%</td>
            <td class="td16" nowrap>&nbsp;</td>
            <td class="td11" nowrap><a href="javascript: getOrderList('Sold Out', '<%=sDiv%>');"><%=sSloQty%></a></td>
            <td class="td11" nowrap>$<%=sSloRet%></td>            
            <td class="td11" nowrap><%=sSloPrc%>%</td>
            <td class="td16" nowrap>&nbsp;</td>
            <td class="td11" nowrap><%=sTotQty%></td>
            <td class="td11" nowrap>$<%=sTotRet%></td>
         </tr>  	
       <%}%>
	  </table>
             
      <!----------------------- end of table ------------------------>
      
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvToolTip" class="dvItem"></div>
<div id="dvHist" class="dvItem"></div>
<!-------------------------------------------------------------------->
       
    </body>
</html>
<%
soldlst.disconnect();
soldlst = null;
}
%>
