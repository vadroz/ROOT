<%@ page import="dcfrtbill.CtnInq, inventoryreports.PiCalendar, java.util.*"%>
<%
   String sSelCtn = request.getParameter("Carton");
   String sSort = request.getParameter("Sort");
   
   if(sSort == null || sSort.trim().equals("")){ sSort = "Div"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CtnInqSel.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      //System.out.println("sort=" + sSort);
      CtnInq cartoninq = new CtnInq(sSelCtn, sSort, sUser);

      boolean bNotFound = cartoninq.getNotFound();
      String sCtn = cartoninq.getCtn();
      String sIssStr = cartoninq.getIssStr();
      String sDstStr = cartoninq.getDstStr();
      String sShipId = cartoninq.getShipId();
      String sShipTrackId = cartoninq.getShipTrackId();
      String sReg = cartoninq.getReg();
      String sTrans = cartoninq.getTrans();
      String sLastDate = cartoninq.getLastDate();
      String sDocNum = cartoninq.getDocNum();
      String sShipDt = cartoninq.getShipDt();
      
      
        
   // get PI Calendar
      PiCalendar setcal = new PiCalendar();
      String [] sYear = setcal.getArrYear();
      String [] sMonth = setcal.getArrMonth();
      String [] sMonName = setcal.getArrDesc();
      
      String sYearJsa = setcal.cvtToJavaScriptArray(sYear);
      String sMonthJsa = setcal.cvtToJavaScriptArray(sMonth);
      String sMonNameJsa = setcal.cvtToJavaScriptArray(sMonName);
      
      setcal.disconnect();
      
      int iEoY = 0;
  	  for(int i=0; i < sYear.length; i++)
  	  {
  	  	if(sMonName[i].indexOf("End of Year PI") >= 0) { iEoY = i; break; }
  	  }
  	  String sLastPI = sYear[iEoY] + sMonth[iEoY];
  	  
  	
%>

<html>
<head>
<title>Carton Inq</title>
<style>
        body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>

<SCRIPT language="JavaScript">
var PiYear = [<%=sYearJsa%>];
var PiMonth = [<%=sMonthJsa%>];
var PiDesc =  [<%=sMonNameJsa%>];
var LastPI = "";
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
	
}
//==============================================================================
//re-sort report
//==============================================================================
function resort(sort)
{
	var url = "CtnInq.jsp?Carton=<%=sSelCtn%>"
	 + "&Sort=" + sort
	;
	
    window.location.href = url
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>

<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Carton Inquiry: <%=sCtn%></b><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="CtnInqSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        
        <a href="javascript:window.print()">Print</a>

  <!-- Continue to build only if carton is found in history member of carton file  -->
  <%if (!bNotFound){%>
      <!-- ====================== Carton Header ============================ -->
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr class="DataTable1">
          <td class="DataTable1" nowrap>Issuing Store</td><td class="DataTable" nowrap><%=sIssStr%></td>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable1" nowrap>Destination Store</td><td class="DataTable" nowrap><%=sDstStr%></td>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable1" nowrap>Ship Date</td><td class="DataTable" nowrap><%=sShipDt%></td>
        </tr>
        <tr class="DataTable1">
          <td class="DataTable1" nowrap>Shipping Id</td><td class="DataTable" nowrap><%=sShipId%></td>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable1" nowrap>Shipping Tracking Id</td><td class="DataTable" nowrap><%=sShipTrackId%></td>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable1" nowrap>&nbsp;</td><td class="DataTable" nowrap>&nbsp;</td>
        </tr>
        <tr class="DataTable1">
          <td class="DataTable1" nowrap>&nbsp;</td><td class="DataTable" nowrap>&nbsp;</td>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable1" nowrap>Pallet Number</td><td class="DataTable" nowrap><%=sTrans%></td>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable1" nowrap>&nbsp;</td><td class="DataTable" nowrap>&nbsp;</td>
        </tr>
      </table>
      <p>
     
      <!-- a href="DstCtnItem.jsp?Carton=<%=sSelCtn%>" target="_blank">Additional Info</a -->
     
      <!-- ====================== Carton Items ============================ -->
      <table border=1 cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable"><a href="javascript: resort('Div')">Div</a><br>#</th>
           <th class="DataTable">Dpt<br>#</th>
           <th class="DataTable">Long Item Number</th>
           <th class="DataTable"><a href="javascript: resort('SKU')">Short SKU</a></th>
           <th class="DataTable"><a href="javascript: resort('Desc')">Item Description</a></th>
           <th class="DataTable"><a href="javascript: resort('UPC')">UPC</a></th>
           <th class="DataTable"><a href="javascript: resort('VenNm')">Vendor Name</a></th>
           <th class="DataTable"><a href="javascript: resort('VenSty')">Vendor<br>Style</a></th>
           <th class="DataTable">Color<br>Name</th>
           <th class="DataTable">Size<br>Name</th>
           
           <!-- th class="DataTable">Component<br>Qty</th -->
           <th class="DataTable">Current<br>Qty</th>
           <th class="DataTable">Qty<br>Allocated</th>
           <th class="DataTable">Qty<br>Picked</th>
           <th class="DataTable">Onhand</th>
           <th class="DataTable">Ret</th>
           <th class="DataTable">Extended<br>Ret</th>
           <th class="DataTable">Alloc<br>#</th>
           <th class="DataTable">Pick<br>#</th>
           <th class="DataTable">Distro<br>#</th>           
         </tr>
         <%while( cartoninq.getNext())
           {
             cartoninq.setItemList();
             String sDiv = cartoninq.getDiv();
             String sDpt = cartoninq.getDpt();
             String sCls = cartoninq.getCls();
             String sVen = cartoninq.getVen();
             String sSty = cartoninq.getSty();
             String sClr = cartoninq.getClr();
             String sSiz = cartoninq.getSiz();
             String sSku = cartoninq.getSku();
             String sDesc = cartoninq.getDesc();
             String sCompQty = cartoninq.getCompQty();
             String sCurrQty = cartoninq.getCurrQty();
             String sQtyAlc = cartoninq.getQtyAlc();
             String sQtyPick = cartoninq.getQtyPick();
             String sAlcNum = cartoninq.getAlcNum();
             String sUpc = cartoninq.getUpc();
             String sVenNm = cartoninq.getVenNm();
             String sVenSty = cartoninq.getVenSty();
             String sClrNm = cartoninq.getClrNm();
             String sSizNm = cartoninq.getSizNm();
             String sRet = cartoninq.getRet();
             String sExtRet = cartoninq.getExtRet();
             String sNewItm = cartoninq.getNewItm();
             String sOnhand = cartoninq.getOnhand();
             String sPick = cartoninq.getPick();
         %>
             <tr class="DataTable" <%if(sNewItm.equals("Y")){%>style="background: pink;"<%}%>>
                <td class="DataTable" nowrap><%=sDiv%></td>
                <td class="DataTable" nowrap><%=sDpt%></td>
                <td class="DataTable" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
                <td class="DataTable" nowrap>
                   <a class="Small" href="PIItmSlsHst.jsp?STORE=<%=sIssStr%>&Sku=<%=sSku%>&FromDate=01/01/0001&ToDate=12/31/2099&PICal=<%=sLastPI%>" target="_blank"><%=sSku%></a>
                </td>
                <td class="DataTable1" nowrap><%=sDesc%></td>
                
                <td class="DataTable1" nowrap><%=sUpc%></td>
                <td class="DataTable1" nowrap><%=sVenNm%></td>
                <td class="DataTable1" nowrap><%=sVenSty%></td>
                <td class="DataTable1" nowrap><%=sClrNm%></td>
                <td class="DataTable1" nowrap><%=sSizNm%></td>                
                
                <!--  td class="DataTable" nowrap><%=sCompQty%></td -->
                <td class="DataTable2" nowrap><%=sCurrQty%></td>
                <td class="DataTable2" nowrap><%=sQtyAlc%></td>
                <td class="DataTable2" nowrap><%=sQtyPick%></td>
                <td class="DataTable2" nowrap><%=sOnhand%></td>
                <td class="DataTable2" nowrap><%=sRet%></td>
                <td class="DataTable2" nowrap><%=sExtRet%></td>
                <td class="DataTable1" nowrap><%=sAlcNum%></td>
                <td class="DataTable1" nowrap><%if(!sNewItm.equals("Y")){%><%=sPick%><%}%></td>
                <td class="DataTable1" nowrap><%if(!sNewItm.equals("Y")){%><%=sDocNum%><%}%></td>                
             </tr>
         <%}%>
         <%
         cartoninq.setTotals();
         String sCompQty = cartoninq.getCompQty();
         String sCurrQty = cartoninq.getCurrQty();
         String sQtyAlc = cartoninq.getQtyAlc();
         String sQtyPick = cartoninq.getQtyPick();
         String sRet = cartoninq.getRet();
         String sExtRet = cartoninq.getExtRet();
         %>
         <tr class="DataTable1">
         	<td class="DataTable1" colspan=10>Totals</td>
         	<td class="DataTable2" nowrap><%=sCurrQty%></td>
            <td class="DataTable2" nowrap><%=sQtyAlc%></td>
            <td class="DataTable2" nowrap><%=sQtyPick%></td>
            <td class="DataTable2" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap><%=sExtRet%></td>
            <td class="DataTable" colspan=3>&nbsp;</td>                        
         </tr>
      </table>
      
      <%
     int iNumOfCont = cartoninq.getNumOfCont();
     String [] sContCtn = cartoninq.getContCtn(); 
     %>
     
     
     <%if(iNumOfCont > 0){%> 
     <br>
      <br>
      <!-- ============= Continuation Carton ============= -->
      
      <table border=1 cellPadding="0" cellSpacing="0">
         <tr>
         	<th class="DataTable" colspan=6>Carton Continued To</th>
         </tr>
      <tr class="DataTable">
        <td class="DataTable">
      <%for(int i=0; i < iNumOfCont; i++){%>       
       	 <a href="CtnInq.jsp?Carton=<%=sContCtn[i]%>"><%=sContCtn[i]%></a>&nbsp;       	       
      <%} %>
      </td>
      </tr>
     </table>
     <%}%> 
      
      
      <br>
      <br>
      <!-- ============= Display log ============= -->
      
      <table border=1 cellPadding="0" cellSpacing="0">
         <tr>
         	<th class="DataTable" colspan=6>Carton Status Log</th>
         </tr>
         <tr>
           <th class="DataTable">Date</th>
           <th class="DataTable">Time</th>
           <th class="DataTable">User</th>
           <th class="DataTable">Status</th>
           <th class="DataTable">Carton<br>Selection</th>
           <th class="DataTable">Comments</th>
         </tr>  
      
      <%int iNumOfLog = cartoninq.getNumOfLog();
      
      
      for(int i=0; i < iNumOfLog; i++)
      {
      	cartoninq.setCtnLog();
      	String sLogDt = cartoninq.getLogDt();
          String sLogTm = cartoninq.getLogTm();
          String sLogUser = cartoninq.getLogUser();
          String sLogUserNm = cartoninq.getLogUserNm();
          String sLogSts = cartoninq.getLogSts();
          String sLogSel = cartoninq.getLogSel();
          String sLogCmt = cartoninq.getLogCmt();
          
          String sOrgCmt = "";
          int iStop =  sLogCmt.indexOf("CONTINU.");
          if(iStop > 0)
          {
        	  sOrgCmt = sLogCmt.substring(0, iStop-1);
          }        	  
       %>
       <tr class="DataTable">
       	<td class="DataTable" nowrap><%=sLogDt%></td>
       	<td class="DataTable" nowrap><%=sLogTm%></td>
       	<td class="DataTable1" nowrap><%=sLogUser%> - <%=sLogUserNm%></td>
       	<td class="DataTable" nowrap><%=sLogSts%></td>
       	<td class="DataTable" nowrap><%=sLogSel%></td>
       	<td class="DataTable" nowrap>
       		<%if(iStop > 0){%><a href="CtnInq.jsp?Carton=<%=sOrgCmt%>"><%=sLogCmt%></a><%} else {%><%=sLogCmt%><%}%>
       	</td>
       </tr>
      <%} %>
     </table>
     
     
     
     
  
  <%} else{%>The carton is not found. Please, select correct number.<%}%>

      </td>
     </tr>
    </table>
    
  </body>
</html>

<%
    cartoninq.disconnect();
    cartoninq = null;
  }
%>



