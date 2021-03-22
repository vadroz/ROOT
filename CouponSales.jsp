<%@ page import="salesreport3.CouponSales, java.util.*, java.text.*"%>
<%
   long lStartTime = (new Date()).getTime();

   String sSelType = request.getParameter("SelType");
   String sSelFrom = request.getParameter("SelFrDate");
   String sSelTo = request.getParameter("SelToDate");
   String sSelName = request.getParameter("SelName");
   String sSelReimb = request.getParameter("SelReimb");
   String [] sSelCode = request.getParameterValues("SelCode");
   String sSort = request.getParameter("Sort");

   if(sSort == null) sSort = "Code";
   if(sSelCode == null){ sSelCode = new String[]{" "};}

if (session.getAttribute("USER")==null )
{
   response.sendRedirect("SignOn1.jsp?TARGET=CouponSales.jsp&APPL=ALL");
}
else
{

    String sUser = session.getAttribute("USER").toString();
    /*System.out.println(sSelType + "|" + sSelFrom + "|" + sSelTo + "|" + sSelName + "|" + sSelReimb  );
    for(int i=0; i < sSelCode.length; i++)
    {
    	System.out.println("Code=" + sSelCode[i] + " is null? " + sSelCode[i] == null);
    }*/
    
    CouponSales coupsls = 
    new CouponSales(sSelType, sSelFrom, sSelTo, sSelCode, sSelName, sSelReimb, sSort,	sUser);
    
    int iNumOfCode = coupsls.getNumOfCode();

    //Calendar cal = Calendar.getInstance();
    SimpleDateFormat sdfNow = new SimpleDateFormat("MM/dd/yyyy");
    Date curdt = new Date((new Date()).getTime() - 86400000);
    String sTodate = sdfNow.format(curdt);
%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:white;text-align:center; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:SeaShell; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { border-top: double darkred;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//report parameters
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
}
//========================================================
// load page to excel
//========================================================
function startExcelApp()
{
	var tbl = document.getElementById("tblData");
	var NumOfRow = tbl.rows.length;
	var content = "<table border='1'>";
	for(var i=0; i < NumOfRow; i++ )
	{
		content += "<tr>" 
		cells = tbl.rows[i].cells;
		for(var j=0; j < cells.length; j++ )
		{
			content += "<td>" + cells[j].innerHTML; + "</td>";			
		}
		content += "</tr>"
		
	}
	content += "</table>";
	
	if(isIE){ nwelem = document.createElement("div"); }
	else if(isSafari){ nwelem = document.createElement("div"); }
	else{ nwelem = window.contentDocument.createElement("div");}
 
 	nwelem.id = "dvSbmCoupLst"

 	var html = "<form name='frmPostCoupLst'"
    	+ " METHOD=Post ACTION='CouponSalesExcel.jsp'>"
    	+ "<input name='Content'>"
    	;
    	
  	html += "</form>"

 	nwelem.innerHTML = html;
 
 	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.document.appendChild(nwelem); }
 	else if(isIE){ window.document.body.appendChild(nwelem); }
 	else if(isSafari){ window.document.body.appendChild(nwelem); }
 	else{ window.contentDocument.body.appendChild(nwelem); }

 	if(isIE || isSafari)
	{
	    document.all.Content.value = content;        
        document.frmPostCoupLst.submit();
	 }
 	else
 	{
	   	window.contentDocument.forms[0].Content.value = content;	   	 
	   	window.contentDocument.forms[0].submit();
 	}
	
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Multiple Code Sales Review/Export</b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <b>From: <%=sSelFrom%> &nbsp; Thru: <%=sSelTo%>
      </b>


      <br><a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="CouponSalesSel.jsp?mode=1">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>
          &nbsp; &nbsp; &nbsp;
          <a href="javascript: startExcelApp()">Load to Excel</a>
          <br><br>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblData">
        <tr>
          <th class="DataTable" id="colReg">Code</th>
          <th class="DataTable" id="colReg">Name</th>
          <th class="DataTable" id="colReg">Discount</th>
          <th class="DataTable" id="colReg">Text</th>
          <th class="DataTable" id="colReg">Start<br>Date</th>
          <th class="DataTable" id="colReg">End<br>Date</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="colReg">Store</th>
          <th class="DataTable" id="colReg">% of<br>Transaction</th>
          <th class="DataTable" id="colReg">Retail</th>
          <th class="DataTable" id="colReg">Qty</th>
          <th class="DataTable" id="colReg">Average Qty<br>per Transaction</th>
          <th class="DataTable" id="colReg">Reimbursement</th>
        </tr>

<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfCode; i++) {%>
           <%
               coupsls.setSales();
               String sCode = coupsls.getCode();
               String sName = coupsls.getName();
               String sDisc = coupsls.getDisc();
               String sText = coupsls.getText();
               String sBegDt = coupsls.getBegDt();
               String sEndDt = coupsls.getEndDt();
               String sStr = coupsls.getStr();
               String sTran = coupsls.getTran();
               String sQty = coupsls.getQty();
               String sRet = coupsls.getRet();
               String sAvgQty = coupsls.getAvgQty();
               String sReimb = coupsls.getReimb();
               String sNameFix = sName.replace("&", "%26");
           %>
              <tr class="DataTable1">
                <td class="DataTable1" nowrap>                
                	<a href="CustomerPurchase.jsp?Code=<%=sCode%>&From=<%=sSelFrom%>&To=<%=sSelTo%>&Customer=<%=sNameFix%>" target="_blank"><%=sCode%></a>
                </td>
                <td class="DataTable1" nowrap><%=sName%>&nbsp;</td>
                <td class="DataTable" nowrap><%=sDisc%>&nbsp;</td>
                <td class="DataTable1"nowrap><%=sText%>&nbsp;</td>
                <td class="DataTable1"nowrap><%=sBegDt%>&nbsp;</td>
                <td class="DataTable1"nowrap><%=sEndDt%>&nbsp;</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable"nowrap><%=sStr%></td>
                <td class="DataTable"nowrap><%=sTran%></td>
                <td class="DataTable"nowrap>$<%=sRet%></td>
                <td class="DataTable"nowrap><%=sQty%></td>
                <td class="DataTable"nowrap><%=sAvgQty%></td>
                <td class="DataTable"nowrap>$<%=sReimb%></td>
              </tr>
           <%}%>
      <!-- ==============  Total =========================================== -->
        <%
         coupsls.setTotal();
         String sCode = coupsls.getCode();
         String sName = coupsls.getName();
         String sDisc = coupsls.getDisc();
         String sText = coupsls.getText();
         String sBegDt = coupsls.getBegDt();
         String sEndDt = coupsls.getEndDt();
         String sStr = coupsls.getStr();
         String sTran = coupsls.getTran();
         String sQty = coupsls.getQty();
         String sRet = coupsls.getRet();
         String sAvgQty = coupsls.getAvgQty();
         String sReimb = coupsls.getReimb();
        %>
        <tr class="DataTable2">
                <td class="DataTable"nowrap><%=sCode%></td>
                <td class="DataTable1"nowrap><%=sName%></td>
                <td class="DataTable"nowrap><%=sDisc%></td>
                <td class="DataTable1"nowrap><%=sText%></td>
                <td class="DataTable1"nowrap><%=sBegDt%></td>
                <td class="DataTable1"nowrap><%=sEndDt%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable"nowrap><%=sStr%></td>
                <td class="DataTable"nowrap><%=sTran%></td>
                <td class="DataTable"nowrap>$<%=sRet%></td>
                <td class="DataTable"nowrap><%=sQty%></td>
                <td class="DataTable"nowrap><%=sAvgQty%></td>
                <td class="DataTable"nowrap>$<%=sReimb%></td>
        </tr>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
  <%
      long lEndTime = (new Date()).getTime();
      long lElapse = (lEndTime - lStartTime) / 1000;
      if (lElapse==0) lElapse = 1;
%>
  <p style="font-size:10px;">Elapse: <%=lElapse%> sec
 </body>
</html>

<%
  coupsls.disconnect();
  coupsls = null;
  }
%>

