<%@ page import="itemtransfer.DivTrfReq, rciutility.BarcodeGen, java.util.*, java.text.*, java.io.*"%>
<%
   String sDivision = request.getParameter("DIVISION");
   String sDivisionName = request.getParameter("DIVNAME");
   String sStore = request.getParameter("STORE");
   String sAppDate = request.getParameter("APPDATE");

   DivTrfReq trfReq = new DivTrfReq(sDivision, sStore, sAppDate);

   String sIssStrName = trfReq.getIssStrName();
   String sIssStrAddr1 = trfReq.getIssStrAddr1();
   String sIssStrAddr2 = trfReq.getIssStrAddr2();
   String sIssStrCity = trfReq.getIssStrCity();
   String sIssStrState = trfReq.getIssStrState();
   String sIssStrZip = trfReq.getIssStrZip();

   int iNumOfStr = trfReq.getNumOfStr();
   String [] sStr = trfReq.getStr();
   String [] sStrName = trfReq.getStrName();
   String [] sStrAddr1 = trfReq.getStrAddr1();
   String [] sStrAddr2 = trfReq.getStrAddr2();
   String [] sStrCity = trfReq.getStrCity();
   String [] sStrState = trfReq.getStrState();
   String [] sStrZip = trfReq.getStrZip();
   
   int iNumOfBch = trfReq.getNumOfBch();
   String [] sBatch = trfReq.getBatch();

   String [] sApprUser = trfReq.getApprUser();
   String [] sApprDate = trfReq.getApprDate();

   int [] iNumOfTrf = trfReq.getNumOfTrf();
   String [][] sCls = trfReq.getCls();
   String [][] sVen = trfReq.getVen();
   String [][] sSty = trfReq.getSty();
   String [][] sClr = trfReq.getClr();
   String [][] sSiz = trfReq.getSiz();
   String [][] sSku = trfReq.getSku();
   String [][] sDesc = trfReq.getDesc();
   String [][] sQty = trfReq.getQty();
   String [][] sOnHand = trfReq.getOnHand();
   String [][] sVenName = trfReq.getVenName();
   String [][] sVenSty = trfReq.getVenSty();
   String [][] sClrName = trfReq.getClrName();
   String [][] sSizName = trfReq.getSizName();
   String [][] sUPC = trfReq.getUPC();
   String [][] sRet = trfReq.getRet();
   String [][] sClsName = trfReq.getClsName();

   trfReq.disconnect();
    
%>

<html>
<head>

<style>
        body { vertical-align: top;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.BodyTbl { vertical-align: top; padding-top:3px; padding-bottom:3px;
                     padding-left:25px; padding-right:25px; text-align:center;
                     font-family:Arial; font-size:10px }

        td.BodyTbl1 { vertical-align: top; padding-top:3px; padding-bottom:3px;
                      padding-left:25px; padding-right:25px; text-align:center;
                      font-family:Arial; font-size:12px; font-weight:bold }

        <!------------------------------------------------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        div.Address { border: black solid 1px; width: 200;}
        <!------------------------------------------------->
 }
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
}
</SCRIPT>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
<!-- iNumOfStr = <%=iNumOfStr%>
<br>sDivision = <%=sDivision%>
<br>sStore = <%=sStore %>
<br>sAppDate = <%=sAppDate%>
<br>
 -->
<% boolean pageBreak = false;%>

<%for(int i=0; i<iNumOfStr; i++){%>       
    <%if(pageBreak){%><div style="page-break-before:always"></div><%}%>
    <% pageBreak = true;%>
    <!-- ---------- -->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr VALIGN="TOP">
       <td ALIGN="center" colspan="2">
         <b><br><font size="+1">TRANSFER REQUEST</font>
         <br><br>Batch Id: 
         <%String sComa = ""; 
         for(int j=0; j < iNumOfBch; j++)
         {        	        
        
        	String sFileNm = "Xfer_Batch_" + sBatch[j];
           	String sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Barcode/" + sFileNm + ".png";
            File f = new File(sFilePath);
            // not exists - generate picture
            try
         	{
            	if(!f.exists())
            	{
                	BarcodeGen bargen = new BarcodeGen();
                	bargen.outputtingBarcodeAsPNG(sFileNm, sFilePath);
            	}
            }
          	catch (Exception e) { System.out.println(e.getMessage()); }        	   
         %>
         	<%=sComa + sBatch[j]%>
         	<img width=200 src="/Barcode/<%=sFileNm%>.png">
         	<% sComa = ", ";%>
         <%}%>
         <br>
         
         <br>Div: <%=sDivision + " - " + sDivisionName%>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
             By: <%=sApprUser[i]%>&nbsp;&nbsp<%=sApprDate[i]%>
         </b><p>
       </td>
     </tr>

     <!---------------------------------------------------------->
     <tr>
       <td class="BodyTbl" nowrap><b>From:&nbsp;<font size="+1"><%=sStore%></font></b>
         <div class="Address"><%=sIssStrName%><br><%=sIssStrAddr1%>
          <%if(sIssStrAddr2!=null){%><%=sIssStrAddr2%><%} else {%><br>&nbsp;<%}%>
          <br><%=sIssStrCity + ", " + sIssStrState + ",&nbsp;" + sIssStrZip%></div>
       </td>
       <td class="BodyTbl" nowrap><b>To: &nbsp;<font size="+1"><%=sStr[i]%></font></b>
         <div class="Address"><%=sStrName[i]%><br><%=sStrAddr1[i]%>
         <%if(sStrAddr2[i]!=null && sStrAddr2[i].trim().length()>0){%><br><%=sStrAddr2[i]%><%}%>
         <br><%=sStrCity[i] + ", " + sStrState[i] + ",&nbsp;" + sStrZip[i]%></div>
       </td>
     </tr>
     
     <tr>
       <td class="BodyTbl1" colspan="2">&nbsp;</td>
     </td>
     <tr>
       <td class="BodyTbl" nowrap >
         &nbsp;&nbsp;&nbsp;
         Pulled By:<u><%for(int k=0; k < 70; k++){%>&nbsp;<%}%></u><br><br>
         Date Pulled:<u><%for(int k=0; k < 70; k++){%>&nbsp;<%}%></u>
         <br><br>
       </td>
       <td class="BodyTbl" nowrap >
         PC Document No:<u><%for(int k=0; k < 70; k++){%>&nbsp;<%}%></u><br><br>
         Date Completed:<u><%for(int k=0; k < 70; k++){%>&nbsp;<%}%></u>
       </td>
     </tr>
     
     <!---------------------------------------------------------->
     <tr>
       <td class="BodyTbl1" colspan="2">
         * All quantities sent <u>must</u> be transferred using the handheld scanners!
       </td>
     </tr>
     <!---------------------------------------------------------->
     <tr >
      <td ALIGN="center" colspan="2">
      <br>
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr><th class="DataTable" rowspan="2">Class</th>
      <th class="DataTable" >Long Item Number</th>
      <th class="DataTable" colspan="3">Item Information</th>
      <th class="DataTable" colspan="2">Vendor Inforamtion</th>
      <th class="DataTable" rowspan="2">File<br>Retail</th>
      <th class="DataTable" rowspan="2">Short Sku</th>
      <th class="DataTable" rowspan="2">UPC</th>
      <th class="DataTable" rowspan="2">On<br>Hand</th>
      <th class="DataTable" rowspan="2">X-fer<br>Qty</th>
      <th class="DataTable" rowspan="2">Qty<br>Sent</th>
    </tr>
    <tr>
      <th class="DataTable" >Cls-Ven-Sty-Clr-Siz</th>
      <th class="DataTable" >Description</th>
      <th class="DataTable" >Color</th>
      <th class="DataTable" >Size</th>
      <th class="DataTable" >Name</th>
      <th class="DataTable" >Style</th>
    </tr>
<!------------------------------- Detail Data --------------------------------->
    <%for(int j=0; j < iNumOfTrf[i]; j++) {%>
      <tr class="DataTable">
        <td class="DataTable1" nowrap><%=sCls[i][j] + " " + sClsName[i][j]%></td>
        <td class="DataTable1" nowrap><%=sCls[i][j] + "-" + sVen[i][j] + "-"
               + sSty[i][j] + "-" + sClr[i][j] + "-" + sSiz[i][j]%></td>
        <td class="DataTable1" nowrap><%=sDesc[i][j]%></td>
        <td class="DataTable1" nowrap><%=sClrName[i][j]%></td>
        <td class="DataTable1" nowrap><%=sSizName[i][j]%></td>
        <td class="DataTable1" nowrap><%=sVenName[i][j]%></td>
        <td class="DataTable1" nowrap><%=sVenSty[i][j]%></td>
        <td class="DataTable">$<%=sRet[i][j]%></td>
        <td class="DataTable"><%=sSku[i][j]%></td>
        <td class="DataTable"><%=sUPC[i][j]%></td>
        <td class="DataTable"><%=sOnHand[i][j]%></td>
        <td class="DataTable"><%=sQty[i][j]%></td>
        <td class="DataTable"><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></td>
      </tr>
    <%}%>
<!---------------------------- end of Detail data ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
<%}%>
 </body>
</html>
