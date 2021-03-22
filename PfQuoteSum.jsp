<%@ page import="patiosales.PfQuoteSum ,java.util.*, java.text.*"%>
<%
   String sFrOrdDate = request.getParameter("FrOrdDt");
   String sToOrdDate = request.getParameter("ToOrdDt");
   String sSort = request.getParameter("Sort");

   if(sSort==null) { sSort="STR"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PfQuoteSum.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      PfQuoteSum ordlst = new PfQuoteSum(sFrOrdDate, sToOrdDate, sSort, session.getAttribute("USER").toString());
      int iNumOfStr = ordlst.getNumOfStr();
%>

<html>
<head>
<title>Patio_Furniture_Sales_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        th.DataTable { background: #FFCC99;padding-top:3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background: #FFCC99; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background: darkred; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background: green; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: ivory; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 { background:PowderBlue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { background:khaki; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}

//==============================================================================
// restart application after heading entry
//==============================================================================
function reStart()
{
   window.location.reload();
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Patio Furniture - All Quotes Recap
        <br>
        <%if(sFrOrdDate.equals("01/01/0001") && sToOrdDate.equals("12/31/2999") ){%>All Dates<%}
          else if(sFrOrdDate.startsWith("01/01")){%>This Season<%}
          else{%>From <%=sFrOrdDate%> &nbsp - To <%=sToOrdDate%><%}%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="PfQuoteSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable" width="40px" rowspan=4>Str</th>
        <th class="DataTable2"  rowspan=4>&nbsp;</th>
        <th class="DataTable" style="background:yellow" nowrap colspan=22>Quotes</th>
        <th class="DataTable2"  rowspan=4>&nbsp;</th>
        <th class="DataTable" style="background:lightgreen" nowrap colspan=6>Sold Orders</th>
        <th class="DataTable2"  rowspan=4>&nbsp;</th>
        <th class="DataTable" style="background:gold" nowrap colspan=2>Total</th>
       </tr>

       <tr  class="DataTable">        
        <th class="DataTable" nowrap colspan=11>Converted To Sales</th>
        <th class="DataTable3"  rowspan=3>&nbsp;</th>
        <th class="DataTable" width="180px" nowrap rowspan=2 colspan=3>Outstanding</th>
        <th class="DataTable1"  rowspan=3>&nbsp;</th>
        <th class="DataTable" width="200px" nowrap rowspan=2 colspan=3>Unsuccessful</th>
        <th class="DataTable1"  rowspan=3>&nbsp;</th>
        <th class="DataTable" nowrap rowspan=2 colspan=2>Total<br>Quotes Written</th>
        <th class="DataTable" nowrap rowspan=2 colspan=3>Orders<br>(Direct Sales)</th>
        <th class="DataTable1"  rowspan=3>&nbsp;</th>
        <th class="DataTable" nowrap  rowspan=2 colspan=2>Cash/Carry<br>(POS Sales)</th>
        <th class="DataTable" nowrap  rowspan=2 colspan=1>Converted Sales<br>Sold Orders<br>Cash/Carry</th>
      </tr>
      
      <tr  class="DataTable">
        <th class="DataTable" width="140px" nowrap colspan=3>Same Date<br>(Worksheet)</th>
        <th class="DataTable1"  rowspan=2>&nbsp;</th>
        <th class="DataTable" width="170px" nowrap colspan=3>Day(s) After<br>(Real)</th>        
        <th class="DataTable1"  rowspan=2>&nbsp;</th>
        <th class="DataTable" width="135px" nowrap colspan=3>Total</th>
      </tr>   
      
      
      <tr  class="DataTable">      
        <th class="DataTable" nowrap>#</th>
        <th class="DataTable" nowrap>$</th>
        <th class="DataTable" nowrap>%</th>

        <th class="DataTable" nowrap>#</th>
        <th class="DataTable" nowrap>$</th>
        <th class="DataTable" nowrap>%</th>
         
        <th class="DataTable" nowrap>#</th>
        <th class="DataTable" nowrap>$</th>
        <th class="DataTable" nowrap>%</th>

        <th class="DataTable" nowrap>#</th>
        <th class="DataTable" nowrap>$</th>
        <th class="DataTable" nowrap>%</th>

        <th class="DataTable" nowrap>#</th>
        <th class="DataTable" nowrap>$</th>
        <th class="DataTable" nowrap>%</th>

        <th class="DataTable" nowrap>#</th>
        <th class="DataTable" nowrap>$</th>

        <th class="DataTable" nowrap>#</th>
        <th class="DataTable" nowrap>$</th>
        <th class="DataTable" nowrap>%</th>

        <th class="DataTable" nowrap>$</th>
        <th class="DataTable" nowrap>%</th>

        <th class="DataTable" nowrap>$</th>
      </tr>

      <TBODY>

  <!-------------------------- Order List ------------------------------->
  <%for(int i=0; i < iNumOfStr; i++) {%>
    <%
      ordlst.setQuoCounts();

       String sStr = ordlst.getStr();
       String sQuoCnt = ordlst.getQuoCnt();
       String sQuoAmt = ordlst.getQuoAmt();
       String sQuoVar = ordlst.getQuoVar();
       String sOrdCnt = ordlst.getOrdCnt();
       String sOrdAmt = ordlst.getOrdAmt();
       String sOrdVar = ordlst.getOrdVar();
       String sCnlCnt = ordlst.getCnlCnt();
       String sCnlAmt = ordlst.getCnlAmt();
       String sCnlVar = ordlst.getCnlVar();
       String sAllCnt = ordlst.getAllCnt();
       String sAllAmt = ordlst.getAllAmt();

       String sNqoCnt = ordlst.getNqoCnt();
       String sNqoAmt = ordlst.getNqoAmt();
       String sNqoVar = ordlst.getNqoVar();

       String sSlsAmt = ordlst.getSlsAmt();
       String sSlsVar = ordlst.getSlsVar();

       String sQocAmt = ordlst.getQocAmt();
       
       String sOsdCnt = ordlst.getOsdCnt();
       String sOsdAmt = ordlst.getOsdAmt();
       String sOsdVar = ordlst.getOsdVar();
       
       String sOldCnt = ordlst.getOldCnt();
       String sOldAmt = ordlst.getOldAmt();
       String sOldVar = ordlst.getOldVar();
       
       %>
        <tr  class="DataTable">
            <td class="DataTable2" nowrap><%=sStr%></td>
            <th class="DataTable2">&nbsp;</th>
            
            <td class="DataTable2"><%=sOsdCnt%></td>
            <td class="DataTable2">$<%=sOsdAmt%></td>
            <td class="DataTable2"><%=sOsdVar%>%</td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sOldCnt%></td>
            <td class="DataTable2">$<%=sOldAmt%></td>
            <td class="DataTable2"><%=sOldVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sOrdCnt%></td>
            <td class="DataTable2">$<%=sOrdAmt%></td>
            <td class="DataTable2"><%=sOrdVar%>%</td>

            <th class="DataTable3">&nbsp;</th>
            <td class="DataTable2"><%=sQuoCnt%></td>
            <td class="DataTable2">$<%=sQuoAmt%></td>
            <td class="DataTable2"><%=sQuoVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sCnlCnt%></td>
            <td class="DataTable2">$<%=sCnlAmt%></td>
            <td class="DataTable2"><%=sCnlVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sAllCnt%></td>
            <td class="DataTable2">$<%=sAllAmt%></td>

            <th class="DataTable2">&nbsp;</th>
            <td class="DataTable3"><%=sNqoCnt%></td>
            <td class="DataTable3">$<%=sNqoAmt%></td>
            <td class="DataTable3"><%=sNqoVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable3">$<%=sSlsAmt%></td>
            <td class="DataTable3"><%=sSlsVar%>%</td>

            <th class="DataTable2">&nbsp;</th>
            <td class="DataTable4">$<%=sQocAmt%></td>
          </tr>

      <!----------------------------------------------------------------------->
      <!-- Group Total -->
      <!----------------------------------------------------------------------->
        <%if(sStr.equals("50") || sStr.equals("86") || sStr.equals("68")){%>
          <%
          ordlst.setGrpTotals();

          String sTot = ordlst.getTot();
          sQuoCnt = ordlst.getQuoCnt();
          sQuoAmt = ordlst.getQuoAmt();
          sQuoVar = ordlst.getQuoVar();
          sOrdCnt = ordlst.getOrdCnt();
          sOrdAmt = ordlst.getOrdAmt();
          sOrdVar = ordlst.getOrdVar();
          sCnlCnt = ordlst.getCnlCnt();
          sCnlAmt = ordlst.getCnlAmt();
          sCnlVar = ordlst.getCnlVar();
          sAllCnt = ordlst.getAllCnt();
          sAllAmt = ordlst.getAllAmt();

          sNqoCnt = ordlst.getNqoCnt();
          sNqoAmt = ordlst.getNqoAmt();
          sNqoVar = ordlst.getNqoVar();

          sSlsAmt = ordlst.getSlsAmt();
          sSlsVar = ordlst.getSlsVar();

          sQocAmt = ordlst.getQocAmt();
          
          sOsdCnt = ordlst.getOsdCnt();
          sOsdAmt = ordlst.getOsdAmt();
          sOsdVar = ordlst.getOsdVar();
          
          sOldCnt = ordlst.getOldCnt();
          sOldAmt = ordlst.getOldAmt();
          sOldVar = ordlst.getOldVar();

         %>
          <tr class="DataTable2">
            <td class="DataTable2" nowrap><%=sTot%></td>
            <th class="DataTable2">&nbsp;</th>
            
            <td class="DataTable2"><%=sOsdCnt%></td>
            <td class="DataTable2">$<%=sOsdAmt%></td>
            <td class="DataTable2"><%=sOsdVar%>%</td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sOldCnt%></td>
            <td class="DataTable2">$<%=sOldAmt%></td>
            <td class="DataTable2"><%=sOldVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sOrdCnt%></td>
            <td class="DataTable2">$<%=sOrdAmt%></td>
            <td class="DataTable2"><%=sOrdVar%>%</td>

            <th class="DataTable3">&nbsp;</th>
            <td class="DataTable2"><%=sQuoCnt%></td>
            <td class="DataTable2">$<%=sQuoAmt%></td>
            <td class="DataTable2"><%=sQuoVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sCnlCnt%></td>
            <td class="DataTable2">$<%=sCnlAmt%></td>
            <td class="DataTable2"><%=sCnlVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sAllCnt%></td>
            <td class="DataTable2">$<%=sAllAmt%></td>

            <th class="DataTable2">&nbsp;</th>
            <td class="DataTable2"><%=sNqoCnt%></td>
            <td class="DataTable2">$<%=sNqoAmt%></td>
            <td class="DataTable2"><%=sNqoVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">$<%=sSlsAmt%></td>
            <td class="DataTable2"><%=sSlsVar%>%</td>

            <th class="DataTable2">&nbsp;</th>
            <td class="DataTable2">$<%=sQocAmt%></td>
         </tr>
        <%}%>
      <%}%>
      <!----------------------------------------------------------------------->
      <!-- Total -->
      <!----------------------------------------------------------------------->
      <%
      ordlst.setTotals();

       String sTot = ordlst.getTot();
       String sQuoCnt = ordlst.getQuoCnt();
       String sQuoAmt = ordlst.getQuoAmt();
       String sQuoVar = ordlst.getQuoVar();
       String sOrdCnt = ordlst.getOrdCnt();
       String sOrdAmt = ordlst.getOrdAmt();
       String sOrdVar = ordlst.getOrdVar();
       String sCnlCnt = ordlst.getCnlCnt();
       String sCnlAmt = ordlst.getCnlAmt();
       String sCnlVar = ordlst.getCnlVar();
       String sAllCnt = ordlst.getAllCnt();
       String sAllAmt = ordlst.getAllAmt();

       String sNqoCnt = ordlst.getNqoCnt();
       String sNqoAmt = ordlst.getNqoAmt();
       String sNqoVar = ordlst.getNqoVar();

       String sSlsAmt = ordlst.getSlsAmt();
       String sSlsVar = ordlst.getSlsVar();

       String sQocAmt = ordlst.getQocAmt();
       
       String sOsdCnt = ordlst.getOsdCnt();
       String sOsdAmt = ordlst.getOsdAmt();
       String sOsdVar = ordlst.getOsdVar();
       
       String sOldCnt = ordlst.getOldCnt();
       String sOldAmt = ordlst.getOldAmt();
       String sOldVar = ordlst.getOldVar();
      %>
          <tr class="DataTable1">
            <td class="DataTable2" nowrap><%=sTot%></td>
            <th class="DataTable2">&nbsp;</th>
            
            <td class="DataTable2"><%=sOsdCnt%></td>
            <td class="DataTable2">$<%=sOsdAmt%></td>
            <td class="DataTable2"><%=sOsdVar%>%</td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sOldCnt%></td>
            <td class="DataTable2">$<%=sOldAmt%></td>
            <td class="DataTable2"><%=sOldVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sOrdCnt%></td>
            <td class="DataTable2">$<%=sOrdAmt%></td>
            <td class="DataTable2"><%=sOrdVar%>%</td>

            <th class="DataTable3">&nbsp;</th>
            <td class="DataTable2"><%=sQuoCnt%></td>
            <td class="DataTable2">$<%=sQuoAmt%></td>
            <td class="DataTable2"><%=sQuoVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sCnlCnt%></td>
            <td class="DataTable2">$<%=sCnlAmt%></td>
            <td class="DataTable2"><%=sCnlVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2"><%=sAllCnt%></td>
            <td class="DataTable2">$<%=sAllAmt%></td>

            <th class="DataTable2">&nbsp;</th>
            <td class="DataTable2"><%=sNqoCnt%></td>
            <td class="DataTable2">$<%=sNqoAmt%></td>
            <td class="DataTable2"><%=sNqoVar%>%</td>

            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">$<%=sSlsAmt%></td>
            <td class="DataTable2"><%=sSlsVar%>%</td>

            <th class="DataTable2">&nbsp;</th>
            <td class="DataTable2">$<%=sQocAmt%></td>
      </tr>

      </TBODY>
      
      <tbody id="tbody3">
       <tr  class="DataTable3"><td colspan=40>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;</td></tr>
       <tr>
        <td colspan=40 align=left>
       <table class="DataTable" border=1 cellPadding="0" cellSpacing="0">
       <tr  class="DataTable">
        <th class="DataTable" width="40px" nowrap rowspan=4>Str</th>
        <th class="DataTable2" rowspan=4>&nbsp;</th>
        <th class="DataTable1" width="140px" rowspan=20>&nbsp;</th>                 
        <th class="DataTable" width="170px" colspan=7>Follow-up<br>Converted (Days After)</th>	
        <th class="DataTable1" width="135px" rowspan=20>&nbsp;</th>                 
        <th class="DataTable" width="180px" colspan=7>Follow-up<br>Outstanding</th>
        <th class="DataTable1" rowspan=20>&nbsp;</th>                 
        <th class="DataTable" width="200px" colspan=7>Follow-up<br>Unsuccessful</th>
       </tr>
       <tr  class="DataTable">
       	<th class="DataTable" colspan=3># Tardy</th>
       	<th class="DataTable1" rowspan=3>&nbsp;</th>
       	<th class="DataTable" colspan=3 rowspan=2>Var %</th>
       	<th class="DataTable" colspan=3># Tardy</th>
       	<th class="DataTable1" rowspan=3>&nbsp;</th>
       	<th class="DataTable" colspan=3 rowspan=2>Var %</th>
       	<th class="DataTable" colspan=3># Tardy</th>
       	<th class="DataTable1" rowspan=3>&nbsp;</th>
       	<th class="DataTable" colspan=3 rowspan=2>Var %</th>
       </tr>
       
       <tr  class="DataTable">
       	<th class="DataTable" colspan=3># Steps</th>
       	<th class="DataTable" colspan=3># Steps</th>
       	<th class="DataTable" colspan=3># Steps</th>       	       	
       </tr>
        
       <tr  class="DataTable">
       		<th class="DataTable">1</th>
       		<th class="DataTable">2</th>
       		<th class="DataTable">3</th>	
       		
       		<th class="DataTable">1</th>
       		<th class="DataTable">2</th>
       		<th class="DataTable">3</th>
       		
       		<th class="DataTable">1</th>
       		<th class="DataTable">2</th>
       		<th class="DataTable">3</th>
       		
       		<th class="DataTable">1</th>
       		<th class="DataTable">2</th>
       		<th class="DataTable">3</th>
       		
       		<th class="DataTable">1</th>
       		<th class="DataTable">2</th>
       		<th class="DataTable">3</th>
       		
       		<th class="DataTable">1</th>
       		<th class="DataTable">2</th>
       		<th class="DataTable">3</th>       		       		
       </tr>
       
       
       <%for(int i=0; i < iNumOfStr; i++)
       {
          ordlst.setStrFup();

          String sStr = ordlst.getStr();
          String [] sFup1Ontime = ordlst.getFup1Ontime();
          String [] sFup2Ontime = ordlst.getFup2Ontime();
          String [] sFup3Ontime = ordlst.getFup3Ontime();
          
          String [] sFup1Offtime = ordlst.getFup1Offtime();
          String [] sFup2Offtime = ordlst.getFup2Offtime();
          String [] sFup3Offtime = ordlst.getFup3Offtime();
          
          String [] sFup1Var = ordlst.getFup1Var();
          String [] sFup2Var = ordlst.getFup2Var();
          String [] sFup3Var = ordlst.getFup3Var();
      	%>
          <tr  class="DataTable">
            <td class="DataTable2"><%=sStr%></td>
            <th class="DataTable2">&nbsp;</th>   
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[0]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[0]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[0]%></td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">&nbsp;<%=sFup1Var[0]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[0]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[0]%>%</td>
            
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[1]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[1]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[1]%></td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">&nbsp;<%=sFup1Var[1]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[1]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[1]%>%</td>
                
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[2]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[2]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[2]%></td>
            
            <th class="DataTable1">&nbsp;</th>   
            <td class="DataTable2">&nbsp;<%=sFup1Var[2]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[2]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[2]%>%</td>
            
      	</tr>
      	<%if(sStr.equals("50") || sStr.equals("86") || sStr.equals("68")){%>
         <%
          ordlst.setGrpFup();

          sStr = ordlst.getStr();
          sFup1Ontime = ordlst.getFup1Ontime();
          sFup2Ontime = ordlst.getFup2Ontime();
          sFup3Ontime = ordlst.getFup3Ontime();
          
          sFup1Offtime = ordlst.getFup1Offtime();
          sFup2Offtime = ordlst.getFup2Offtime();
          sFup3Offtime = ordlst.getFup3Offtime();
          
          sFup1Var = ordlst.getFup1Var();
          sFup2Var = ordlst.getFup2Var();
          sFup3Var = ordlst.getFup3Var();
      	%>
      	<tr class="DataTable2">
            <td class="DataTable2"><%=sStr%></td>
            <th class="DataTable2">&nbsp;</th>   
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[0]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[0]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[0]%></td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">&nbsp;<%=sFup1Var[0]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[0]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[0]%>%</td>
            
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[1]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[1]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[1]%></td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">&nbsp;<%=sFup1Var[1]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[1]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[1]%>%</td>
                
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[2]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[2]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[2]%></td>
            
            <th class="DataTable1">&nbsp;</th>   
            <td class="DataTable2">&nbsp;<%=sFup1Var[2]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[2]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[2]%>%</td>             
        </tr>    
      	<%}%>
      	
        <%}%>
        
        
        <%
          ordlst.setTotFup();

        String sStr = ordlst.getStr();
        String [] sFup1Ontime = ordlst.getFup1Ontime();
        String [] sFup2Ontime = ordlst.getFup2Ontime();
        String [] sFup3Ontime = ordlst.getFup3Ontime();
        
        String [] sFup1Offtime = ordlst.getFup1Offtime();
        String [] sFup2Offtime = ordlst.getFup2Offtime();
        String [] sFup3Offtime = ordlst.getFup3Offtime();
        
        String [] sFup1Var = ordlst.getFup1Var();
        String [] sFup2Var = ordlst.getFup2Var();
        String [] sFup3Var = ordlst.getFup3Var();
      	%>
      	<tr class="DataTable1">
            <td class="DataTable2"><%=sStr%></td>
            <th class="DataTable2">&nbsp;</th>   
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[0]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[0]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[0]%></td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">&nbsp;<%=sFup1Var[0]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[0]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[0]%>%</td>
            
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[1]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[1]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[1]%></td>
            
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable2">&nbsp;<%=sFup1Var[1]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[1]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[1]%>%</td>
                
            <td class="DataTable2">&nbsp;<%=sFup1Offtime[2]%></td>
            <td class="DataTable2">&nbsp;<%=sFup2Offtime[2]%></td>
            <td class="DataTable2">&nbsp;<%=sFup3Offtime[2]%></td>
            
            <th class="DataTable1">&nbsp;</th>   
            <td class="DataTable2">&nbsp;<%=sFup1Var[2]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup2Var[2]%>%</td>
            <td class="DataTable2">&nbsp;<%=sFup3Var[2]%>%</td>           
        </tr>    
      	
        </table>
        	</td>
        </tr>
      </tbody>
    </table>

    <p style="text-align:left; font-size:12px">
    Quote Analysis represented on this recap:
    <br><u>Converted Sales:</u>   All Quotes, that were later converted to a Sale Order (will include
    <u>both</u> open and closed patio sale orders)<br>
    <u>Outstanding:</u>   All Quotes still Active
    <br><u>Unsuccessful:</u>  All Quotes Closed
    <br><u>Total Quotes Written:</u>  All Quotes written (sum of all above columns)
    <br><br><u>Orders (Direct Sales):</u>  All Orders entered initially as a SALE, that were not converted from a Quote.
    <br><u>Cash/Carry (POS Sales):</u>  Any cash/carry items sold directly to customers through POS.
    <br><br><u>Total:</u> Quotes converted to Sales + Orders (Direct Sales) + Cash/Carry (POS Sales)


    <br><br>1-2-3 Follow Up Steps 
      
	<br># of days before Follow Up Steps are Past Due 
    <br>Step 1 - 2 days after initial Quote 
    <br>Step 2 - 5 days after initial Quote 
    <br>Step 3 - 8 days after initial Quote 


     </td>
   </tr>

  </table>
 </body>
</html>
<%
   ordlst.disconnect();
}%>


