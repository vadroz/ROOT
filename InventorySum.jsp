<%@ page import="inventoryreports.InventorySum, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");   
   String [] sSelDiv = request.getParameterValues("Div");
   String sSelDivNm = request.getParameter("DivName");
   String sNumOfDays = request.getParameter("NumOfDays");
   
   String sSelDpt = request.getParameter("Dpt");
   String sSelDptNm = request.getParameter("DptName");
   String sSelCls = request.getParameter("Cls");
   String sSelClsNm = request.getParameter("ClsName");
   
   if(sSelDpt == null || sSelDpt.equals("")){ sSelDpt = "ALL"; }
   if(sSelCls == null || sSelCls.equals("")){ sSelCls = "ALL"; }
   if(sSelDivNm == null){ sSelDivNm = "All Divisions"; }
   if(sSelDptNm == null){ sSelDptNm = "All Departments"; }
   if(sSelClsNm == null){ sSelClsNm = "All Classes"; }
   
   
   if(sNumOfDays == null || sNumOfDays.equals("")){sNumOfDays="14";}
  
   InventorySum invsum = new InventorySum(sStore, sSelDiv, sSelDpt, sSelCls, sNumOfDays);

   String [] sColName = invsum.getColName();
   String [] sWkRet = invsum.getWkRet();
   String [] sWkCost = invsum.getWkCost();
   String [] sWkUnit = invsum.getWkUnit();
   String [] sMnRet = invsum.getMnRet();
   String [] sMnCost = invsum.getMnCost();
   String [] sMnUnit = invsum.getMnUnit();
   
   String [] sSeRet = invsum.getSeRet();
   String [] sSeCost = invsum.getSeCost();
   String [] sSeUnit = invsum.getSeUnit();
   
   String [] sYrRet = invsum.getYrRet();
   String [] sYrCost = invsum.getYrCost();
   String [] sYrUnit = invsum.getYrUnit();

   // from destribution center
   int iNumOfDst = invsum.getNumOfDst();
   String [] sDstSts = invsum.getDstSts();
   String [] sDstNum = invsum.getDstNum();
   String [] sDstTrfDate = invsum.getDstTrfDate();
   String [] sDstRet = invsum.getDstRet();
   String [] sDstCost = invsum.getDstCost();
   String [] sDstUnit = invsum.getDstUnit();
   String [] sDstDiv = invsum.getDstDiv();

   // incomming not from DC
   int iNumOfInc = invsum.getNumOfInc();
   String [] sIncStr = invsum.getIncStr();
   String [] sIncNum = invsum.getIncNum();
   String [] sIncTrfDate = invsum.getIncTrfDate();
   String [] sIncRet = invsum.getIncRet();
   String [] sIncCost = invsum.getIncCost();
   String [] sIncUnit = invsum.getIncUnit();
   String [] sIncDiv = invsum.getIncDiv();

   int iNumOfOut = invsum.getNumOfOut();
   String [] sOutStr = invsum.getOutStr();
   String [] sOutNum = invsum.getOutNum();
   String [] sOutTrfDate = invsum.getOutTrfDate();
   String [] sOutRet = invsum.getOutRet();
   String [] sOutCost = invsum.getOutCost();
   String [] sOutUnit = invsum.getOutUnit();
   String [] sOutDiv = invsum.getOutDiv();
   
   int iNumOfDat = invsum.getNumOfDat();
   String [] sDates = invsum.getDates();
   String [] sDayOfWk = invsum.getDayOfWk();
   int iNumOfDiv = invsum.getNumOfDiv();
   
   String [] sStsNm = new String[]{
    "<span style='font-size: 12px'><b>Outstanding Check-In</b></span> <span style='font-size: 10px'>(Not Received)</span>"
   , "<span style='font-size: 12px'><b>Pending Putaway</b></span> <span style='font-size: 10px'>(Unlocated)</span>"
   ,"<span style='font-size: 12px'><b>Allocated</b></span> <span style='font-size: 10px'>(Ready to Pick)</span>"
   ,"<span style='font-size: 12px'><b>Picks Run</b></span> <span style='font-size: 10px'>(Being Picked)</span>"
   , "<span style='font-size: 12px'><b>Pick Completed</b></span> <span style='font-size: 10px'>(Pending Shipment)</span>"
   , "<span style='font-size: 12px'><b>Shipped</b></span> <span style='font-size: 10px'>(In Transit)</span>"
   
   };
   String sDivJsa = invsum.cvtToJavaScriptArray(sSelDiv);
%>

<html>
<head>
<title>Inv Sum</title>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.Row { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.Row1 { background:Cornsilk; font-family:Arial; font-size:10px }
        tr.Row2 { background:Azure; font-family:Arial; font-size:10px }
        tr.Row3 { background: white; font-family:Arial; font-size:10px }
        tr.Divider { background: black; font-family:Arial; font-size:2px }
        tr.Divider1 { background: salmon; font-family:Arial; font-size:2px }

        td.Cell { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
        td.Cell1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:right;}                 
        td.Cell1g { background:#e7e7e7; padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:right;}  
        td.Cell1w { background: white; padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:right;}                  

        td.Cell2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:Center;}
                 
        td.Cell3 { background:#FFCC99; border-left: salmon solid 2px; padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:Center;}         

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
var SelStr = "<%=sStore%>"
var SelDiv = [<%=sDivJsa%>];
var SelDivNm = "<%=sSelDivNm%>"
var SelDpt = "<%=sSelDpt%>"
var SelDptNm = "<%=sSelDptNm%>"
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
	setAmtType("U");
}
//===================================================================
// set selected type amount
//===================================================================
function setAmtType(type)
{
	var ret = document.all.spnRet;
	var cost = document.all.spnCost;
	var unit = document.all.spnUnit;
	
	for(var i=0; i < ret.length; i++)
	{
		if(type=="R"){ ret[i].style.display="block";}
		else{ ret[i].style.display="none";}
		if(type=="C"){ cost[i].style.display="block";}
		else{ cost[i].style.display="none";}
		if(type=="U"){ unit[i].style.display="block";}
		else{ unit[i].style.display="none";}
	}
}
//===================================================================
// drill down
//===================================================================
function drillDown(grp, grpnm)
{	
	var url = "InventorySum.jsp?Store=" + SelStr;		
	
	if(SelDiv[0] == "ALL")
	{ 
		url += "&Div=" + grp;
	}
	else if(SelDiv[0] != "ALL" && SelDiv.length==1 && SelDpt == "ALL")
	{ 
		url += "&Div=" + SelDiv + "&DivName=" + SelDivNm + "&Dpt=" + grp + "&DptName=" + grpnm;
	}
	else if(SelDiv[0] != "ALL" || SelDiv.length > 1){ url += "&Div=" + grp + "&DivName=" + grpnm;}
	
	window.location.href = url;
}
//===================================================================
//drill down
//===================================================================
function showOutChkIn(grp, grpnm, tot)
{
	var url = "InvDcOutChkIn.jsp?";		
	
	if(tot)
	{ 
		for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]}
		url += "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm; 
	}
	else if(SelDpt != "ALL")
	{ 
		url += "&Div=" + SelDiv[0] + "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		     + "&Cls=" + grp + "&ClsName=" + grpnm;
	}
	else if(SelDiv[0] != "ALL" && SelDiv.length == 1 && SelDpt == "ALL")
	{ 
		url += "&Div=" + SelDiv[0] + "&DivName=" + SelDivNm + "&Dpt=" + grp + "&DptName=" + grpnm;
	}
	else if(SelDiv[0] == "ALL" || SelDiv.length > 1){ url += "&Div=" + grp + "&DivName=" + grpnm;}
	
	
	window.open(url);
}
//===================================================================
// show Putaway details
//===================================================================
function showPutaway(grp, grpnm, tot)
{
	var url = "InvPutaway.jsp?";		
	
	if(tot)
	{ 
		for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]}
		url += "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm; 
	}
	else if(SelDpt != "ALL")
	{ 
		url += "&Div=" + SelDiv + "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		     + "&Cls=" + grp + "&ClsName=" + grpnm;
	}
	else if(SelDiv[0] != "ALL" && SelDiv.length == 1 && SelDpt == "ALL")
	{ 
		url += "&Div=" + SelDiv + "&DivName=" + SelDivNm + "&Dpt=" + grp + "&DptName=" + grpnm;
	}
	else if(SelDiv[0] == "ALL" || SelDiv.length > 1){ url += "&Div=" + grp + "&DivName=" + grpnm;}
	
	
	window.open(url);
}
//===================================================================
//show Putaway details
//===================================================================
function showStsDtl(grp, grpnm, sts, tot)
{
	var url = "InvPndDst.jsp?Str=" + SelStr;		
	
	if(tot)
	{ 
		for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]}
		url += "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm; 
	}
	else if(SelDpt != "ALL")
	{ 
		url += "&Div=" + SelDiv[0] + "&DivName=" + SelDivNm + "&Dpt=" + SelDpt + "&DptName=" + SelDptNm
		     + "&Cls=" + grp + "&ClsName=" + grpnm;
	}
	else if(SelDiv[0] != "ALL" && SelDiv.length == 1 && SelDpt == "ALL")
	{ 
		url += "&Div=" + SelDiv[0] + "&DivName=" + SelDivNm + "&Dpt=" + grp + "&DptName=" + grpnm;
	}
	else if(SelDiv[0] == "ALL" || SelDiv.length > 1){ url += "&Div=" + grp + "&DivName=" + grpnm;}
	
	url += "&Sts=" + sts;
	
	window.open(url);
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------------------->
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
<!-------------------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Inventory Summary
      <br>Store: <%=sStore%>
      <%if(!sSelDiv[0].equals("ALL")){%>
          <br>
          <%if(sSelDiv.length > 1){%>Divisions: 
          <%String sComa = ""; %>
          	<%for(int i=0; i < sSelDiv.length; i++){%><%=sComa + sSelDiv[i]%><%sComa = ",";%><%} %>
          <%} else {%>Division: <%=sSelDiv[0]%>-<%=sSelDivNm%><%}%>
      <%}%>
      <%if(!sSelDpt.equals("ALL")){%><br>Department: <%=sSelDpt%>-<%=sSelDptNm%><%}%>
      </b>
     </tr>
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan=4>
      <a href="../"><font color="red" size="-1">Home</font></a>&#62;
      <a href="../InventorySumSel.jsp"><font color="red" size="-1">Select Store/Division</font></a>&#62;
      <font size="-1">This Page</font>
      &nbsp;  &nbsp; &nbsp; 
      <a href="DcStockSum.jsp" target="_blank">DC Productivity</a>
      

<!--------------------- Summary Table ----------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
            <th class="DataTable" rowspan="2">Description</th>
            <th class="DataTable" rowspan="2">&nbsp;</th>
            <th class="DataTable" colspan="3">WTD</th>
            <th class="DataTable" rowspan="2">&nbsp;</th>
            <th class="DataTable" colspan="3">MTD</th>
            <th class="DataTable" rowspan="2">&nbsp;</th>
            <th class="DataTable" colspan="3">STD</th>
            <th class="DataTable" rowspan="2">&nbsp;</th>
            <th class="DataTable" colspan="3">YTD</th>
        </tr>
        <tr>
            <%for(int i=0; i < 4; i++) {%>
               <th class="DataTable">Retail</th>
               <th class="DataTable">Cost</th>
               <th class="DataTable">Unit</th>
            <%}%>
        </tr>
<!------------------------------- Summary Table --------------------------------->
          <%for(int i=0; i < 8; i++) {%>
            <tr class="Row1">
               <td class="Cell" nowrap><%=sColName[i]%></td>
               <th class="DataTable">&nbsp;</th>
               <td class="Cell1" nowrap><%=sWkRet[i]%></td>
               <td class="Cell1" nowrap><%=sWkCost[i]%></td>
               <td class="Cell1" nowrap><%=sWkUnit[i]%></td>
               <th class="DataTable">&nbsp;</th>
               <td class="Cell1g" nowrap><%=sMnRet[i]%></td>
               <td class="Cell1g" nowrap><%=sMnCost[i]%></td>
               <td class="Cell1g" nowrap><%=sMnUnit[i]%></td>
               <th class="DataTable">&nbsp;</th>
               <td class="Cell1w" nowrap><%=sSeRet[i]%></td>
               <td class="Cell1w" nowrap><%=sSeCost[i]%></td>
               <td class="Cell1w" nowrap><%=sSeUnit[i]%></td>
               <th class="DataTable">&nbsp;</th>
               <td class="Cell1" nowrap><%=sYrRet[i]%></td>
               <td class="Cell1" nowrap><%=sYrCost[i]%></td>
               <td class="Cell1" nowrap><%=sYrUnit[i]%></td>
            </tr>
         <%}%>
     </table>
<!-------------------------- end of table ------------------------------------->
<!------------------------- Destribution from DC  ----------------------------->
      <!-- %if(sStore.equals("ALL")){% -->

      <!----------------- beginning of table ------------------------>
      <p>
          <b>From: 01 - Distribution Center</b>
          &nbsp; &nbsp; &nbsp;
          Retail<input name="Type" type="radio" onclick="setAmtType('R')"> &nbsp;
          Cost<input name="Type" type="radio" onclick="setAmtType('C')"> &nbsp;
          Unit<input name="Type" type="radio" onclick="setAmtType('U')"  checked>
      <br><span style="color:darkred; font-size:11px">Data is positioned by original date for check-in, putaway stock source, and allocations by Distro statuses.</span>     
      <table class="DataTable" cellPadding="0" cellSpacing="0" width="50%">
        <tr>
            <th class="DataTable" rowspan=3>
                <%if(!sSelDpt.equals("ALL")){%>Class<%}
                else if(!sSelDiv.equals("ALL")){%>Dpt<%}
                else if(sSelDiv.equals("ALL")){%>Div<%}%>
            </th>
            <th class="DataTable" colspan=2 rowspan=3>Code</th>
            <th class="DataTable" rowspan=3>Receiving/Putaway<br>Distribution Processing Status</th>
            <th class="DataTable" colspan=3>Prior Dates</th> 
            <th class="DataTable" rowspan=3>&nbsp;</th>
            <th class="DataTable" colspan=7>8-14 Days Before</th>
            <th class="DataTable" rowspan=3>&nbsp;</th>
            <th class="DataTable" colspan=7>Last 7 Days</th>
            <th class="DataTable" rowspan=3>&nbsp;</th>
            <th class="DataTable" rowspan=3 nowrap>Today</th>
            <th class="DataTable" rowspan=3 nowrap>Total</th>
        </tr>
        <tr>
        	<th class="DataTable" rowspan=2 >Oldest</th>
            <th class="DataTable" rowspan=2 >Newest</th>            
            <th class="DataTable" rowspan=2 >Prior<br>Totals</th>            
            <%for(int i=1; i < iNumOfDat-1; i++){%>
            	<th class="DataTable" nowrap>&nbsp;<%=sDayOfWk[i]%>&nbsp;</th>
            <%}%>
        </tr>
        <tr>        	
            <%for(int i=1; i < iNumOfDat-1; i++){%>
            	<th class="DataTable" nowrap>&nbsp;<%=sDates[i].substring(0,5)%>&nbsp;</th>
            <%}%>
        </tr>

          <%String sRowCls = "Row";           
          iNumOfDiv += 2;
          
          for(int i=0; i < iNumOfDiv; i++) {
        	  if(i==0 || i == iNumOfDiv-1){invsum.setPndTot();}
        	  else{invsum.setPndByDiv();}            	 
            	 String sDiv = invsum.getDiv();
            	 String sDivNm = invsum.getDivNm();
            	 String [] sSts = invsum.getSts();
            	 String [][] sRet = invsum.getRet();
            	 String [][] sCost = invsum.getCost();
            	 String [][] sUnit = invsum.getUnit();
            	 String [] sFrDate = invsum.getFrDate();
            	 String [] sToDate = invsum.getToDate();
            	 if(i==0 || i == iNumOfDiv-1){ sRowCls = "Row1"; }
            	 else if(sRowCls.equals("Row")){ sRowCls = "Row3"; }
            	 else { sRowCls = "Row"; }
            	 
            	 int iRowSpan = 8;
            	 int iBegSts = 0;
            	 if(!sStore.equals("ALL")){ iRowSpan = 6; iBegSts = 2; }
            	 boolean bTot = i==0 || i == iNumOfDiv-1; 
             %>
               <tr class="Divider"><td colspan="26">&nbsp;</td></tr>
                  
               <tr class="<%=sRowCls%>">
                  <td class="Cell" nowrap rowspan="<%=iRowSpan%>">
                     <%if(!sSelDpt.equals("ALL") || i==0 || i == iNumOfDiv-1){%>                      
                     	<%if(!sDiv.equals("0")){%><%=sDiv%> - <%=sDivNm%><%}
                     	else {%><%=sDivNm%><%}%>
                     <%}
                     else {%>
                        <a href="javascript: drillDown('<%=sDiv%>', '<%=sDivNm%>')"><%=sDiv%> - <%=sDivNm%></a>
                     <%}%>                     
                     </a>                     
                  </td>
                  <%for(int j=iBegSts; j < 6; j++) {%>
                    <%if(j == 2){%><tr class="Divider1"><td colspan="25">&nbsp;</td></tr><%}%>
                    <%if(j >= iBegSts){%><tr class="<%=sRowCls%>" ><%}%>
                    <%if(j == 2){%><td class="Cell3" rowspan=4 nowrap>
                    		<%if(i > 0 && i < iNumOfDiv-1){%><a href="javascript: showStsDtl('<%=sDiv%>','<%=sDivNm%>', 'ALL',<%=bTot%>)">D<br>I<br>S<br>T<br>R<br>O</a><%}
                    		else {%>D<br>I<br>S<br>T<br>R<br>O<%}%>
                    	</td>
                    <%}%>
                    <td class="Cell" <%if(j < 2){%>colspan=2<%}%> nowrap>
                    	<%if(i > 0 && i < iNumOfDiv-1){%>
                    	       <a href="javascript: showStsDtl('<%=sDiv%>','<%=sDivNm%>', '<%=sSts[j]%>',<%=bTot%>)"><%=sSts[j]%></a><%}
                        else {%><%=sSts[j]%><%}%>                    	
                    </td>
                    <td class="Cell" nowrap>
                    	<%if(j==0){%><a href="javascript: showOutChkIn('<%=sDiv%>', '<%=sDivNm%>', <%=bTot%>)"><%=sStsNm[j]%></a><%}
                    	else if(j==1){%><a href="javascript: showPutaway('<%=sDiv%>', '<%=sDivNm%>', <%=bTot%>)"><%=sStsNm[j]%></a><%}
                    	else{%><%=sStsNm[j]%> 
                    	
                    	<%if(sSelDiv[0].equals("ALL")){%>
                    		&nbsp; <a href="PendDistByDate.jsp?Div=<%=sDiv%>&By=Str&Sts=<%=sSts[j]%>" style="font-size: 8px;" target="_blank">By Str</a> 
                    		<%if(sDiv.equals("0")){%>&nbsp; <a href="PendDistByDate.jsp?Div=<%=sDiv%>&By=Div&Sts=<%=sSts[j]%>" style="font-size: 8px;" target="_blank">By Div</a><%}%><%}%>
                        <%}%>
                    </td>
                    <td class="Cell" nowrap><%=sFrDate[j]%>
                    <td class="Cell" nowrap><%=sToDate[j]%>
                    <%for(int k=0; k < iNumOfDat; k++) {                    	 
                    	 if(sRet[j][k].equals("0")){ sRet[j][k] = ""; }
                    	 if(sCost[j][k].equals("0")){ sCost[j][k] = ""; }
                    	 if(sUnit[j][k].equals("0")){ sUnit[j][k] = ""; }
                    %>                         
                         <%if(k==1 || k == 8 || k == iNumOfDat-1){%><th class="DataTable">&nbsp;</th><%}%>
                         <td class="Cell1" nowrap>
                           <span id="spnRet"><%=sRet[j][k]%></span>
                           <span id="spnCost"><%=sCost[j][k]%></span>
                           <span id="spnUnit"><%=sUnit[j][k]%></span>
                         </td>
                    <%}%>
                    <%
                    if(sRet[j][iNumOfDat].equals("0")){ sRet[j][iNumOfDat] = ""; }
               		if(sCost[j][iNumOfDat].equals("0")){ sCost[j][iNumOfDat] = ""; }
               	 	if(sUnit[j][iNumOfDat].equals("0")){ sUnit[j][iNumOfDat] = ""; }
                    %>
                    <td class="Cell1" nowrap>
                       <span id="spnRet"><%=sRet[j][iNumOfDat]%></span>
                       <span id="spnCost"><%=sCost[j][iNumOfDat]%></span>
                       <span id="spnUnit"><%=sUnit[j][iNumOfDat]%></span>
                    </td>		   
                   </tr>                
                  <%} %>
              
              <%if(i > 0 && i % 4 == 0){%>
               <tr>
            	<th class="DataTable">Div</th>
            	<th class="DataTable" colspan=2>Code</th>
            	<th class="DataTable">Current Status</th>
            	<th class="DataTable">Oldest</th>     
            	<th class="DataTable">Newest</th>
            	<th class="DataTable">Totals</th>  
            	<th class="DataTable">&nbsp;</th>      
            	<%for(int k=1; k < iNumOfDat-1; k++){%> 
            	    <%if(k==8){%><th class="DataTable">&nbsp;</th><%}%>           	    
            		<th class="DataTable" nowrap><%=sDates[k].substring(0,5)%></th>
            	<%}%> 
            	<th class="DataTable">&nbsp;</th>
            	<th class="DataTable">Today</th>
            	<th class="DataTable">Total</th>
        	  </tr>
        	 <%}%>
               
          <%}%>           
     </table>
     
     <!--  %}% -->
<!-------------------------------- end of table ------------------------------->
<!------------------ Incomming Destribution not from DC  ---------------------->
      <!----------------- beginning of table ------------------------>
      <%if(!sStore.equals("ALL")){%>
      <p>
          <b>Store Incomming Transfer</b>

      <table class="DataTable" cellPadding="0" cellSpacing="0" width="50%">
        <tr>
            <th class="DataTable">From<br>Store</th>
            <th class="DataTable">Dist<br>#</th>
            <th class="DataTable">Transfer<br>Date</th>
            <th class="DataTable">Retail</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Unit</th>
            <th class="DataTable">Divisions</th>
        </tr>

          <% for(int i=0; i < iNumOfInc; i++) {%>
               <tr class="Row">
                  <td class="Cell2" nowrap><%=sIncStr[i]%></td>
                  <td class="Cell1" nowrap><%=sIncNum[i]%></td>
                  <td class="Cell2" nowrap><%=sIncTrfDate[i]%></td>
                  <td class="Cell1" nowrap><%=sIncRet[i]%></td>
                  <td class="Cell1" nowrap><%=sIncCost[i]%></td>
                  <td class="Cell1" nowrap><%=sIncUnit[i]%></td>
                  <td class="Cell" nowrap><%=sIncDiv[i]%></td>
               </tr>
          <%}%>
      </table>
<!-------------------------------- end of table ------------------------------->
<!------------------ Outgoing Destribution not from DC  ---------------------->
      <!----------------- beginning of table ------------------------>
      <p>
          <b>Store Outgoing Transfer</b>

      <table class="DataTable" cellPadding="0" cellSpacing="0" width="50%">
        <tr>
            <th class="DataTable">To<br>Store</th>
            <th class="DataTable">Dist<br>#</th>
            <th class="DataTable">Transfer<br>Date</th>
            <th class="DataTable">Retail</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Unit</th>
            <th class="DataTable">Divisions</th>
        </tr>

          <% for(int i=0; i < iNumOfOut; i++) {%>
               <tr class="Row">
                  <td class="Cell2" nowrap><%=sOutStr[i]%></td>
                  <td class="Cell1" nowrap><%=sOutNum[i]%></td>
                  <td class="Cell2" nowrap><%=sOutTrfDate[i]%></td>
                  <td class="Cell1" nowrap><%=sOutRet[i]%></td>
                  <td class="Cell1" nowrap><%=sOutCost[i]%></td>
                  <td class="Cell1" nowrap><%=sOutUnit[i]%></td>
                  <td class="Cell" nowrap><%=sOutDiv[i]%></td>
               </tr>
          <%}%>
      </table>
      
      <%} %>
<!-------------------------------- end of table ------------------------------->


  </table>
 </body>
</html>
<%

invsum.disconnect(); %>
