<%@ page import="discountcard.CustomerPurchase ,java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CustomerPurchase.jsp&APPL=ALL");
   }
   else
   {
      String sSrchCode = request.getParameter("Code");
      String sCustomer = request.getParameter("Customer");
      String sSrchFrom = request.getParameter("From");
      String sSrchTo = request.getParameter("To");
      String sSort = request.getParameter("Sort");
      if(sSort == null){ sSort = "Str"; }
      
      int iNumOfPrch = 0;
      String sUser = session.getAttribute("USER").toString();
      //System.out.println(sSrchCode + "|" + sSrchFrom + "|" + sSrchTo + "|" + sUser);
      CustomerPurchase custprch = new CustomerPurchase(sSrchCode, sSrchFrom, sSrchTo, sSort, sUser);
      iNumOfPrch = custprch.getNumOfPrch();
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right;}
                   
        div.dvTrans { position:absolute; visibility:hidden; background-attachment: scroll; border:ridge; 
                       width:300; background-color:LemonChiffon; z-index:100; text-align:left; font-size:16px }
        
        tr.Detail { background: #e7e7e7; }
        tr.Total { background: cornsilk; }               
        td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background: #016aab; color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { padding-right:3px; padding-left:3px; text-align:left; font-family:Arial; font-size:10px; }
        td.Prompt1 { padding-right:3px; padding-left:3px; text-align:center;font-family:Arial; font-size:10px; }
        td.Prompt2 { padding-right:3px; padding-left:3px; text-align:right; font-family:Arial; font-size:10px; }
         
                                       
        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var NumOfPrch = "<%=iNumOfPrch%>";
var fold = false;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// convert table to excel document
//==============================================================================
function startExcelApp()
{
   window.status="Loading Table to Excel spreadsheet."

   var url = "CustomerPurchaseExcel.jsp?"
      + "&Code=<%=sSrchCode%>"
      + "&Customer=<%=sCustomer%>"
      + "&From=<%=sSrchFrom%>"
      + "&To=<%=sSrchTo%>"

   var WindowName = 'Customer_Purchase_List';
   var WindowOptions = 'height=500, width=900,left=10,top=10, resizable=yes , toolbar=no, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';

   //alert(url);
   window.open(url, WindowName, WindowOptions);
   window.status="Table Loaded."
}
//==============================================================================
//show details
//==============================================================================
function showDtl()
{
	for(var i=0; i < NumOfPrch; i++)
	{
		var row = "trRow" + i;
		var robj = document.getElementById(row);
		var cell = "tdStr" + i;
		var cobj = document.getElementById(cell);
		if(cobj)
		{
			if(fold){ robj.style.display = "none"; }
			else{ robj.style.display = "table-row"; }
		}		
	}
	fold = !fold;
}

//==============================================================================
//show details
//==============================================================================
function foldStr(str, line, id, arg )
{
	var f = document.getElementById("inpFold" + arg);
	
	for(var i=0; i < NumOfPrch; i++)
	{
		var ltype = document.getElementById("inpLine" + i);
		
		if(ltype.value == "0")
		{				
			var robj = document.getElementById("trRow" + i);
			var cobj = document.getElementById("tdStr" + i);			
			if(cobj.innerHTML == str)
			{
				if(f.value == "N"){ robj.style.display = "none"; }
				else{ robj.style.display = "table-row";  }
			}
		}
		
	}
	// reverse fold/unfold flag
	if(f.value == "N"){ f.value = "Y"; }
	else{ f.value = "N"; }
}
//==============================================================================
// re-sort
//==============================================================================
function reSort(sort)
{
	var url = "CustomerPurchase.jsp?"
	  + "&Code=<%=sSrchCode%>"
	  + "&Customer=<%=sCustomer%>"
	  + "&From=<%=sSrchFrom%>"
	  + "&To=<%=sSrchTo%>"
	  + "&Sort=" + sort
	;      
	window.location.href = url;      
}
//==============================================================================
//show transaction details
//==============================================================================
function showTrans(str, date, reg, trans)
{
var url = "../UnautMDTran.jsp?Store=" + str
    + "&Date=" + date
    + "&Reg=" + reg
    + "&Trans=" + trans
    + "&Folder=" + true
//alert(url)
//window.location.href = url;
window.frame1.location.href = url;
}

//==============================================================================
//show transaction details
//==============================================================================
function showTransDetail(html)
{
	document.all.dvTrans.innerHTML = html;
	document.all.dvTrans.style.pixelLeft= document.body.scrollLeft + 300;
	document.all.dvTrans.style.pixelTop= document.body.scrollTop + 100;
	document.all.dvTrans.style.visibility = "visible";
}
//--------------------------------------------------------
//Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
document.all.dvTrans.innerHTML = " ";
document.all.dvTrans.style.visibility = "hidden";
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvTrans" class="dvTrans"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder="0" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Marketing Code Sales/Export
      <br>Code: <%=sSrchCode%> &nbsp;  &nbsp;
          Customer: <%=sCustomer%>
      </b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%if(iNumOfPrch > 0) {%>
      		<a href="javascript: showDtl()">fold/unfold</a>
            &nbsp; &nbsp; &nbsp; &nbsp;
      		<a href="javascript: startExcelApp()">Load to Excel</a>
      <%}%>
      
      <%if(iNumOfPrch > 1000) {%>
        <br><br>
        <span style="font-size: 11px; color: darkred; background: yellow; border: 1px solid black;">
          The number of records on report is over 1000. The data is incomplete.  
        </span>
        <br><br>
      <%}%>
      
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable" nowrap> <a href="javascript: reSort('Str')">Store</a> </th>
        <th class="DataTable" nowrap> Purchase <br>Date</th>
        <th class="DataTable" nowrap> Ticket <br>#</th>
        <th class="DataTable" nowrap> Preferred<br>Customer</th>
        <th class="DataTable" nowrap> Cashier </th>
        <th class="DataTable" nowrap> Salesperson </th>
        <th class="DataTable" nowrap> Div </th>
        <th class="DataTable" nowrap> Short SKU </th>
        <th class="DataTable" nowrap> UPC </th>
        <th class="DataTable" nowrap> Item <br> Description </th>
        <th class="DataTable" nowrap> Vendor <br> Name </th>
        <th class="DataTable" nowrap> Quantity </th>
        <th class="DataTable" nowrap> <a href="javascript: reSort('StrRet')">Retail</a> </th>
        
      </tr>
      <TBODY>

     <!----------------------- Order List ------------------------>
     <%int j = 0; %>
     <%for(int i=0; i < iNumOfPrch; i++) {
         custprch.setPurchaseList();
         String sStr = custprch.getStr();
         String sDate = custprch.getDate();
         String sRet = custprch.getRet();
         String sQty = custprch.getQty();
         String sSku = custprch.getSku();
         String sDesc = custprch.getDesc();
         String sTran = custprch.getTran();
         String sEmp = custprch.getEmp();
         String sEmpNm = custprch.getEmpNm();
         String sCashr = custprch.getCashr();
         String sCshNm = custprch.getCshNm();
         String sUpc = custprch.getUpc();
         String sDiv = custprch.getDiv();
         String sVenNm = custprch.getVenNm();
         String sLine = custprch.getLine();
         String sPrefCust = custprch.getPrefCust();
         String sReg = custprch.getReg();
         
         String sClass = "DataTable";
         String sHide = "style=\"display:table-row;\"";          
         if(sLine.equals("0"))
         {
        	 sClass = "DataTable1";
        	 sHide = "style=\"display:none;\"";
         }
         
         String sId = "tdStr" + i;
         if( !sLine.equals("0") )
         {
        	 sId = "tdTotal" + j;
        	 j++;
         }
         
     %>
         <tr class="<%=sClass%>" <%=sHide%> id="trRow<%=i%>">
            <td class="DataTable1" id="<%=sId%>"><%=sStr%></td>
            <td class="DataTable"><%=sDate%></td>
            <td class="DataTable">
            	<a href="javascript: showTrans('<%=sStr%>', '<%=sDate%>', '<%=sReg%>', '<%=sTran%>')"><%=sTran%></a>
            </td>
            <td class="DataTable"><%=sPrefCust%></td>
            <td class="DataTable"><%=sCashr%> - <%=sCshNm%></td>
            <td class="DataTable"><%=sEmp%> - <%=sEmpNm%></td>            
            <td class="DataTable"><%=sDiv%></td>
            <td class="DataTable1"><%=sSku%></td>
            <td class="DataTable1"><%=sUpc%></td>
            <td class="DataTable"><%=sDesc%></td>
            <td class="DataTable"><%=sVenNm%></td>
            <td class="DataTable1"><%=sQty%></td>
            <td class="DataTable1">
                <%if(sLine.equals("1")){%> 
            	<a href="javascript: foldStr('<%=sStr%>', '<%=sLine%>', '<%=sId%>', '<%=i%>' )"><%=sRet%></a>
            	<input type="hidden" name="inpFold<%=i%>" id="inpFold<%=i%>" value="Y">
            	<%} else {%><%=sRet%><%}%>
            	<input type="hidden" name="inpline<%=i%>" id="inpLine<%=i%>" value="<%=sLine%>">            	            	
            </td>
         </tr>
     <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>
<%custprch.disconnect();%>
<%}%>