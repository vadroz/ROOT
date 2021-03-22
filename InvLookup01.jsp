<!DOCTYPE html>	
<%@ page import="onhand01.InvLookup01, java.util.*, java.text.*"%>
<%
	String sSelStr = request.getParameter("Str");
	String sSelDiv = request.getParameter("Div");
	String sSelDpt = request.getParameter("Dpt");
	String sSelCls = request.getParameter("Cls");
	String sSelVen = request.getParameter("Ven");
	String sSelVst = request.getParameter("Vst");
	String sSelDesc = request.getParameter("Desc");	
   	String [] sGCls = request.getParameterValues("GCls");
   	String sSort = request.getParameter("Sort");
   	
   	   
   if(sSelVst == null){ sSelVst = " "; }
   if(sSelDesc == null){ sSelDesc = "STR"; }
   if(sGCls == null){ sGCls = new String[]{" "}; }
   
   if(sSort == null){ sSort = "ITEM"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=InvLookup01.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	InvLookup01 itemlst = new InvLookup01( sSelStr, sSelDiv, sSelDpt, sSelCls, sSelVen
			, sSelVst, sSelDesc, sGCls, sSort, sUser);
	
	int iNumOfItm = itemlst.getNumOfItm();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Inventory Lookup</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Sort = "<%=sSort%>";


//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
//==============================================================================
//switch from store to intransit
//==============================================================================
function switch_Inv_InTr(invType)
{
	var inv = document.all.spnInv;
	var trn = document.all.spnTrn;
	var exc = document.all.spnExcl;
	
	var dinv = "none";
	var dtrn = "none";
	var dexc = "none";
	
	if(invType == "EXCLUDE") 
	{ 
		dinv = "none"; dtrn = "none"; dexc = "block"; 
		document.all.spnHdr.innerHTML = "In-Transit Excluded";
	}
	else if(invType == "INCLUDE")
	{ 
		dinv = "block"; dtrn = "none"; dexc = "none"; 
		document.all.spnHdr.innerHTML = "In-Transit Included";
	}
	else if(invType == "INTRANSIT") 
	{ 
		dinv = "none"; dtrn = "block"; dexc = "none"; 
		document.all.spnHdr.innerHTML = "In-Transit Details";
	}
	
	for(var i=0; i < inv.length ; i++)
	{
		inv[i].style.display = dinv; 
		trn[i].style.display = dtrn;
		exc[i].style.display = dexc;
		
		if(i > 0 && i % 100 == 0){	window.status = "Wait a few seconds... " +  i; }
	}
	window.status = " ";
}
//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{	
	//var url = "EcShipOrdSts.jsp?"	
	//window.location.href=url;
}
//==============================================================================
//resort report
//==============================================================================
function getPOList(cls, ven, sty, clr, siz)
{
   var url = "ItemPOList.jsp?Str=1"
     + "&Cls=" + cls
     + "&Ven=" + ven
     + "&Sty=" + sty
     + "&Clr=" + clr
     + "&Siz=" + siz

   //alert(url)
   //window.location.href = url
   window.frame1.location.href = url
}
//==============================================================================
//show PO List
//==============================================================================
function showPOList(ponum, antDt, poqty)
{
	var hdr = "PO List";

	var html = "<table class='tbl01' width='100%' cellPadding=0 cellSpacing=0>"
	  + "<tr>"
  		  + "<td class='BoxName' nowrap>" + hdr + "</td>"
   		  + "<td class='BoxClose' valign=top>"
    		  +  "<img src='../CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
    	  + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>"

	html += popPOList(ponum, antDt, poqty);

	html += "</td></tr></table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 150;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//========================================================
//populate Column Panel for update
//========================================================
function popPOList(ponum, antDt, poqty)
{
	var dummy = "<table>";
	var panel = "<table class='tbl03' width='100%' cellPadding='3' cellSpacing='0'>"

	panel += "<tr class='trHdr02'>"
       + "<th class='th01' nowrap>PO Number</th>"
       + "<th class='th01' nowrap>Anticipation<br>Delivery Date</th>"
       + "<th class='th01'>Qty</th>"
     + "</tr>"

	for(var i=0; i < ponum.length; i++)
	{
  		panel += "<tr class='trDtl03'>"
          + "<td class='td01' nowrap>" + ponum[i] + "</td>"
          + "<td class='td01' nowrap>" + antDt[i] + "</td>"
          + "<td class='td01' nowrap>" + poqty[i] + "</td>"
         + "</tr>"
}

	panel += "<tr class='trDtl04'><td class='td03' colspan=3>"
     + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

	panel += "</table>";

	return panel;
}
//========================================================
//Hide selection screen
//========================================================
function hidePanel()
{
 document.all.dvItem.innerHTML = " ";
 document.all.dvItem.style.visibility = "hidden";
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
            <br>Inventory Lookup
            <br/><span id="spnHdr">In-Transit Excluded</span>   
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="InvLookup01Sel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font>
               &nbsp; &nbsp; &nbsp; &nbsp; 
              
              <span id="spnSwith" style="font-size:12px"><a href="javascript:switch_Inv_InTr('INTRANSIT')">Show In-Transit</a></span> &#160; &#160; &#160; &#160;
      		  <span id="spnSwith" style="font-size:12px"><a href="javascript:switch_Inv_InTr('INCLUDE')">Show Include In-Transit</a></span> &#160; &#160; &#160; &#160;
      		  <span id="spnSwith" style="font-size:12px"><a href="javascript:switch_Inv_InTr('EXCLUDE')">Show Exclude In-Transit</a></span>             
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=2>Description</th>
          <th class="th02" rowspan=2>Vendor<br>Name</th>
          <th class="th02" rowspan=2>Vendor<br>Style</th>
          <th class="th02" rowspan=2>Color</th>
          <th class="th02" rowspan=2>Size</th>
          <th class="th02" rowspan=2>Short<br>SKU</th>
          <th class="th02" rowspan=2>MFG UPC<br>Code</th>
          <th class="th02" rowspan=2>Next<br>PO</th>
          <th class="th02" rowspan=2>Store<br>Retail</th>
          <th class="th02" rowspan=2>Total<br>Chain</th>
          <th class="th02" colspan=1>D.C</th>
          <th class="th02" colspan=1>E-<br>Comm</th>
          <th class="th02" colspan=1>LW</th>
          <th class="th02" colspan=5>Houston</th>
          <th class="th02" colspan=1>Aust</th>
          <th class="th02" colspan=1>San</th>
          <th class="th02" colspan=2>Ft.W</th>
          <th class="th02" colspan=1>Arl</th>
          <th class="th02" colspan=2>Dal</th>
          <th class="th02" colspan=3 nowrap>Tul/Okla/Norm</th>
          <th class="th02" colspan=1>Cinn</th>
          <th class="th02" colspan=2>Nash</th>
          <th class="th02" colspan=1>Atla</th>
          <th class="th02" colspan=1>Miam</th>
          <th class="th02" colspan=3>Ski<br>Chalet</th>
          <th class="th02" colspan=1>N.Y.</th>
          <th class="th02" colspan=1>Char</th>
          <th class="th02" colspan=1>Conc</th>
          <th class="th02" colspan=1>NH</th>
          <th class="th02" colspan=1>CT</th>
          <th class="th02" colspan=3>MA</th>
        </tr>
        <tr class="trHdr01">
          <th class="th02">01</th>
          <th class="th02">70</th>
          <th class="th02">13</th>
          <th class="th02">03</th>
          <th class="th02">04</th>
          <th class="th02">05</th>
          <th class="th02">08</th>
          <th class="th02">82</th>
          <th class="th02">11</th>
          <th class="th02">20</th>
          <th class="th02">90</th>
          <th class="th02">98</th>
          <th class="th02">92</th>
          <th class="th02">93</th>
          <th class="th02">96</th>
          <th class="th02">10</th>
          <th class="th02">28</th>
          <th class="th02">29</th>
          <th class="th02">30</th>
          <th class="th02">40</th>
          <th class="th02">42</th>
          <th class="th02">45</th>
          <th class="th02">61</th>
          <th class="th02">35</th>
          <th class="th02">46</th>
          <th class="th02">50</th>
          <th class="th02">86</th>
          <th class="th02">87</th>
          <th class="th02">88</th>
          <th class="th02">66</th>
          <th class="th02">63</th>
          <th class="th02">64</th>
          <th class="th02">68</th>
          <th class="th02">55</th>
        </tr>
       
<!------------------------------- Detail --------------------------------->
           <%for(int i=0; i < (iNumOfItm - 1); i++) {
        	   itemlst.getItemLst();
               String sDiv = itemlst.getDiv();
               String sDpt = itemlst.getDpt();
               String sCls = itemlst.getCls();
               String sVen = itemlst.getVen();
               String sSty = itemlst.getSty();
               String sClr = itemlst.getClr();
               String sSiz = itemlst.getSiz();
               String sSku = itemlst.getSku();
               String sUps = itemlst.getUps();
               String sRet = itemlst.getRet();
               String sStrRet = itemlst.getStrRet();
               String sVenNm = itemlst.capitalizeString(itemlst.getVenNm());               
               String sDesc = itemlst.capitalizeString(itemlst.getDesc());
               String sClrNm = itemlst.capitalizeString(itemlst.getClrNm());
               String sSizNm = itemlst.capitalizeString(itemlst.getSizNm());
               String sVst = itemlst.getVst();
               String [] sInvQty = itemlst.getInvQty();
               String [] sTrnQty = itemlst.getTrnQty();
               String [] sExclQty = itemlst.getExclQty();
               String sTotInv = itemlst.getTotInv();
               String sTotTrn = itemlst.getTotTrn();
               String sTotExcl = itemlst.getTotExcl();
           %>
              <tr id="trId" class="trDtl04">
                <td class="td11" nowrap><%=sDesc%></td>
                <td class="td11" nowrap><%=sVenNm%></td>
                <td class="td11" nowrap><%=sVst%></td>
                <td class="td11" nowrap><%=sClrNm%></td>
                <td class="td11" nowrap><%=sSizNm%></td>
                <td class="td12" nowrap><%=sSku%></td>
                <td class="td11" nowrap><%=sUps%></td>
                <td class="td11" nowrap><a href="javascript: getPOList('<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>')">PO</a></td>
                <td class="td12" nowrap>$<%=sStrRet%></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sTotInv%></span><span id="spnTrn" style="display:none;"><%=sTotTrn%></span><span id="spnExcl"><%=sTotExcl%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[0]%></span><span id="spnTrn" style="display:none;"><%=sTrnQty[0]%></span><span id="spnExcl"><%=sExclQty[0]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[24]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[24]%></span><span id="spnExcl" ><%=sExclQty[24]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[7]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[7]%></span><span id="spnExcl"><%=sExclQty[7]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[1]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[1]%></span><span id="spnExcl"><%=sExclQty[1]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[2]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[2]%></span><span id="spnExcl"><%=sExclQty[2]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[3]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[3]%></span><span id="spnExcl"><%=sExclQty[3]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[4]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[4]%></span><span id="spnExcl"><%=sExclQty[4]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[25]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[25]%></span><span id="spnExcl"><%=sExclQty[25]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[6]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[6]%></span><span id="spnExcl"><%=sExclQty[6]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[8]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[8]%></span><span id="spnExcl"><%=sExclQty[8]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[29]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[29]%></span><span id="spnExcl"><%=sExclQty[29]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[33]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[33]%></span><span id="spnExcl"><%=sExclQty[33]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[30]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[30]%></span><span id="spnExcl"><%=sExclQty[30]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[31]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[31]%></span><span id="spnExcl"><%=sExclQty[31]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[32]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[32]%></span><span id="spnExcl"><%=sExclQty[32]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[5]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[5]%></span><span id="spnExcl"><%=sExclQty[5]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[9]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[9]%></span><span id="spnExcl"><%=sExclQty[9]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[10]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[10]%></span><span id="spnExcl"><%=sExclQty[10]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[11]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[11]%></span><span id="spnExcl"><%=sExclQty[11]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[13]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[13]%></span><span id="spnExcl"><%=sExclQty[13]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[14]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[14]%></span><span id="spnExcl"><%=sExclQty[14]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[15]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[15]%></span><span id="spnExcl"><%=sExclQty[15]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[19]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[19]%></span><span id="spnExcl"><%=sExclQty[19]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[12]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[12]%></span><span id="spnExcl"><%=sExclQty[12]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[16]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[16]%></span><span id="spnExcl"><%=sExclQty[16]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[17]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[17]%></span><span id="spnExcl"><%=sExclQty[17]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[26]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[26]%></span><span id="spnExcl"><%=sExclQty[26]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[27]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[27]%></span><span id="spnExcl"><%=sExclQty[27]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[28]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[28]%></span><span id="spnExcl"><%=sExclQty[28]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[22]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[22]%></span><span id="spnExcl"><%=sExclQty[22]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[20]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[20]%></span><span id="spnExcl"><%=sExclQty[20]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[21]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[21]%></span><span id="spnExcl"><%=sExclQty[21]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[23]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[23]%></span><span id="spnExcl"><%=sExclQty[23]%></span></td>
                <td class="td12" nowrap><span id="spnInv" style="display:none;"><%=sInvQty[18]%></span></span><span id="spnTrn" style="display:none;"><%=sTrnQty[18]%></span><span id="spnExcl"><%=sExclQty[18]%></span></td>                                                                                                                                                
              </tr>
           <%}%>
         </table>
      <!----------------------- end of table ------------------------>
      <%if(iNumOfItm > 1000){%>
       <span style="color:darkblue;font-size:11px;">This page shows only first 1000 records.</span> 
      <%}%>
      </tr>
   </table>
 </body>
</html>
<%
itemlst.disconnect();
itemlst = null;
}
%>