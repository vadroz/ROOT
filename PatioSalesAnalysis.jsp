<%@ page import="patiosales.PatioSalesAnalysis, java.util.*, java.text.*"%>
<%
    String sWkend = request.getParameter("Wkend");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PatioSalesAnalysis.jsp");
}
else
{
	Date dBegTime = new Date();
	String sUser = session.getAttribute("USER").toString();
    PatioSalesAnalysis pfslsanl = new PatioSalesAnalysis(sWkend, sUser);    
    int iNumOfStr = pfslsanl.getNumOfStr();
    String [] sStrLst = pfslsanl.getStrLst();
    String [] sGrpLst = pfslsanl.getGrpLst();
    String [] sDates = pfslsanl.getDates();
    
    Date dWkend = new SimpleDateFormat("mm/dd/yyyy").parse(sWkend);
    Calendar cal = Calendar.getInstance();
    cal.setTime(dWkend);
    int iCurYear = cal.get(Calendar.YEAR);    
    int iYear = cal.get(Calendar.YEAR) - 1;
    String LyEnd = "12/31/" + iYear; 
%>
<HTML>
<HEAD>
<title>Patio Sales</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:center; font-size:11px;}
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:10px }
        th.DataTable4 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:10px }
        th.DataTable5 { background: moccasin;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }              

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.DataTable2 { background: ccffcc; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background: #b0b0b0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
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


<script name="javascript1.3">
var BegDate = "<%=dBegTime.getTime()%>";
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}

</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture Sales Plus Open Orders<br>
            Selected Date: <%=sWkend%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="PatioSalesAnalysisSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
              <th class="DataTable" colspan=61>This Patio Selling Season</th>
              <th class="DataTable5" rowspan=6><%for(int i=0; i < 10; i++){%>&nbsp;<%}%></th>
             <th class="DataTable" colspan=5>Memo</th>
             <th class="DataTable5" rowspan=6><%for(int i=0; i < 10; i++){%>&nbsp;<%}%></th>
             <th class="DataTable" rowspan=3 colspan=3>Performance<br>vs<br>Opportunity</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable" rowspan=5>Store</th>

             <th class="DataTable" rowspan=5>&nbsp;</th>
             <th class="DataTable" colspan=19>Fiscal Week-To-Date</th>

             <th class="DataTable" rowspan=5>&nbsp;</th>
             <th class="DataTable" colspan=19>Fiscal Month-To-Date</th>

             <th class="DataTable" rowspan=5>&nbsp;</th>
             <th class="DataTable" colspan=19>Patio Season (Year-To-Date since January 1)</th>
             
             <th class="DataTable3" rowspan=5>
                Less Open<br>(Undelivered)<br>At End Of<br>Prior Year <!--  <br>(<%=LyEnd%>)  -->
             </th>
             <th class="DataTable3" rowspan=5>Plus Open<br>Remainder<br>(Undelivered)<br>At End of<br>Prior Year</th>
             <th class="DataTable3" rowspan=5>Delivered<br>of TY<br>Orders Only</th>
             <th class="DataTable3" rowspan=5>Delivered<br>of TY<br>Orders<br>vs. LY</th>
             <th class="DataTable" rowspan=5>Store</th>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 3; i++){%>
                <th class="DataTable3" colspan=10>Patio Sales<br>(Div 50/95)</th>
                <th class="DataTable3" colspan=2 rowspan=3><%if(i == 2){%>All<%}%> Open<br>(Undelivered)<br>(w/tax)</th>
                <th class="DataTable3" colspan=4>Initiated<br>Quotes<br>(Memo)</th>
                <th class="DataTable3" colspan=2 rowspan=3>Total</th>
                <th class="DataTable3" rowspan=3>Sales<br>Var %</th>
            <%}%>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 3; i++){%>
                <th class="DataTable3" colspan=5>Orders Entered + CC</th>
                <th class="DataTable3" colspan=2 rowspan=2>Released<br>(Delivered)<br>Orders<br>(no/tax)</th>                                
                <th class="DataTable3" rowspan=3>Total</th>
                <th class="DataTable3" rowspan=3>GM<br>$</th>
                <th class="DataTable3" rowspan=3>GM<br>%</th>
                <th class="DataTable3" rowspan=3>Total<br>#</th>
                <th class="DataTable3" rowspan=3>Total<br>$</th>
                <th class="DataTable3" rowspan=3>#<br>Cust</th>
                <th class="DataTable3" rowspan=3>#<br>Cust<br>Var%</th>
            <%}%>
            <th class="DataTable3" rowspan=3 nowrap>W-T-D</th>
            <th class="DataTable3" rowspan=3 nowrap>M-T-D</th>
            <th class="DataTable3" rowspan=3 nowrap>Y-T-D</th>
         </tr>
         
         <tr class="DataTable">
            <%for(int i=0; i < 3; i++){%>
            	<th class="DataTable3" colspan=3>Orders Entered<br>This <%if(i==0){%>Week<%} else if(i==1){%>Month<%} else{%>Year<%}%><br>(w/tax)</th>
                <th class="DataTable3" rowspan=2>Cash/<br>Carry<br>(no/tax)</th>
                <th class="DataTable3" rowspan=2>Orders Entered<br>/ CC<br>Total</th>                
            <%}%>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 3; i++){%>
            	<th class="DataTable3">#</th>
                <th class="DataTable3">$</th>
                <th class="DataTable3">%</th>                
                <th class="DataTable3">#</th>
                <th class="DataTable3">$</th>
                <th class="DataTable3">%</th>
                <th class="DataTable3">#</th>
                <th class="DataTable3">$</th>
                <th class="DataTable3">#</th>
                <th class="DataTable3">$</th>
            <%}%>
        </tr>           
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfStr; i++ )
         {
            pfslsanl.setFlashSls("TY");
            String sGrp = pfslsanl.getGrp();
            String [] sLayway = pfslsanl.getLayway();
            String [] sCash = pfslsanl.getCash();
            String [] sSls = pfslsanl.getSls();
            String [] sOrder = pfslsanl.getOrder();
            String [] sTotal = pfslsanl.getTotal();
            String [] sVar = pfslsanl.getVar();
            String [] sGmAmt = pfslsanl.getGmAmt();
            String [] sGmPrc = pfslsanl.getGmPrc();
            String [] sQuaAmt = pfslsanl.getQuaAmt();
            String [] sQuaCnt = pfslsanl.getQuaCnt();
            String [] sCurrFyOrd = pfslsanl.getCurrFyOrd();
            String [] sLastFyOrd = pfslsanl.getLastFyOrd();
            String [] sEoYOrd = pfslsanl.getEoYOrd(); 
            String [] sDlvOrd = pfslsanl.getDlvOrd();
            String [] sDlvOrdVar = pfslsanl.getDlvOrdVar();
            String [] sPrefvsOp = pfslsanl.getPrefvsOp();
            String [] sQuaCust = pfslsanl.getQuaCust();
            String [] sVarCust = pfslsanl.getVarCust();
            String [] sOrdCnt = pfslsanl.getOrdCnt();
            String [] sUndCnt = pfslsanl.getUndCnt();
            String [] sTotCnt = pfslsanl.getTotCnt();
            String [] sDlySls = pfslsanl.getDlySls();
            String [] sDlyCnt = pfslsanl.getDlyCnt();
            String [] sDlyVar = pfslsanl.getDlyVar();
            String [] sTotCash = pfslsanl.getTotCash();
            
            String sSvGrp = sGrpLst[i];
        %>
            <tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable2" nowrap><%=sDlyCnt[j]%></td>
               <td class="DataTable2" nowrap>
               	<%if(j==0) {%>
               		<a href="OrderLst.jsp?FrOrdDt=<%=sDates[0]%>&ToOrdDt=<%=sDates[2]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%}  else if(j==1){%>	
               		<a href="OrderLst.jsp?FrOrdDt=<%=sDates[1]%>&ToOrdDt=<%=sDates[2]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%} else if(j==2){%>
               		<a href="OrderLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=<%=sDates[2]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%} %>	
               </td>
               <td class="DataTable2" nowrap><%=sDlyVar[j]%>%</td>
               <td class="DataTable2" nowrap>$<%=sCash[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotCash[j]%></td>
               <td class="DataTable2" nowrap><%=sOrdCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLayway[j]%></td>
               
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sGmAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sGmPrc[j]%>%</td>               
               <td class="DataTable2" nowrap><%=sUndCnt[j]%></td>
               <td class="DataTable2" nowrap>
                  <%if(j==0) {%>
                     <a href="OrderLst.jsp?FrOrdDt=<%=sDates[0]%>&ToOrdDt=<%=sDates[2]%>&PyStatus=P&PyStatus=F&PyStatus=E&PyStatus=O&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                     $<%=sOrder[j]%></a>
                  <%} else if(j==1){%>
                    <a href="OrderLst.jsp?FrOrdDt=<%=sDates[1]%>&ToOrdDt=<%=sDates[2]%>&PyStatus=P&PyStatus=F&PyStatus=E&PyStatus=O&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                     $<%=sOrder[j]%></a>
                  <%} else if(j==2){%>
                    <a href="OrderLst.jsp?FrOrdDt=01/01/<%=iCurYear%>&ToOrdDt=<%=sDates[2]%>&PyStatus=P&PyStatus=F&PyStatus=E&PyStatus=O&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                     $<%=sOrder[j]%></a>
                  <%}%>
               </td>
               <td class="DataTable2" nowrap><%=sQuaCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sQuaAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCust[j]%></td>
               <td class="DataTable2" nowrap><%=sVarCust[j]%>%</td>
               <td class="DataTable2" nowrap><%=sTotCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotal[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
            <%}%>
            <th class="DataTable5">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sEoYOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sLastFyOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sDlvOrd[2]%></td>
            <td class="DataTable2" nowrap><%=sDlvOrdVar[2]%>%</td>
            <td class="DataTable1" nowrap><%=sGrp%></td>
            
            <th class="DataTable5">&nbsp;</th>
            <%for(int j=0; j < 3; j++){%>
            	<td class="DataTable1" nowrap><%=sPrefvsOp[j]%></td>
            <%}%>
          </tr>
          <!-- -------------------- Group Store Total ---------------------- -->
          <%if(i == iNumOfStr-1 ||  !sSvGrp.equals(sGrpLst[i+1]))
          {
             pfslsanl.setGrpTot("TY");
             sGrp = pfslsanl.getGrp();
             sLayway = pfslsanl.getLayway();
             sCash = pfslsanl.getCash();
             sSls = pfslsanl.getSls();
             sOrder = pfslsanl.getOrder();
             sTotal = pfslsanl.getTotal();
             sVar = pfslsanl.getVar();
             sGmAmt = pfslsanl.getGmAmt();
             sGmPrc = pfslsanl.getGmPrc();
             sQuaAmt = pfslsanl.getQuaAmt();
             sQuaCnt = pfslsanl.getQuaCnt();
             sCurrFyOrd = pfslsanl.getCurrFyOrd();
             sLastFyOrd = pfslsanl.getLastFyOrd();
             sEoYOrd = pfslsanl.getEoYOrd(); 
             sDlvOrd = pfslsanl.getDlvOrd();
             sDlvOrdVar = pfslsanl.getDlvOrdVar();
             sPrefvsOp = pfslsanl.getPrefvsOp();
             sQuaCust = pfslsanl.getQuaCust();
             sVarCust = pfslsanl.getVarCust();
             sOrdCnt = pfslsanl.getOrdCnt();
             sUndCnt = pfslsanl.getUndCnt();
             sTotCnt = pfslsanl.getTotCnt();
             sDlySls = pfslsanl.getDlySls();
             sDlyCnt = pfslsanl.getDlyCnt();
             sDlyVar = pfslsanl.getDlyVar();
             sTotCash = pfslsanl.getTotCash();

             String sGrpNm = "DC Area";
             if(sGrp.trim().equals("2")){ sGrpNm = "NY Store"; }
             if(sGrp.trim().equals("3")){ sGrpNm = "NE Area"; }
          %>
          <tr id="trGrp" class="DataTable2">
            <td class="DataTable1" nowrap><%=sGrpNm%></td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable2" nowrap><%=sDlyCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sDlySls[j]%></td>
               <td class="DataTable2" nowrap><%=sDlyVar[j]%>%</td>
               <td class="DataTable2" nowrap>$<%=sCash[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotCash[j]%></td>
               <td class="DataTable2" nowrap><%=sOrdCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLayway[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sGmAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sGmPrc[j]%>%</td>
               <td class="DataTable2" nowrap><%=sUndCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sOrder[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCnt[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sQuaAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCust[j]%></td>
               <td class="DataTable2" nowrap><%=sVarCust[j]%>%</td>
               <td class="DataTable2" nowrap><%=sTotCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotal[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
            <%}%>
            <th class="DataTable5">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sEoYOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sLastFyOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sDlvOrd[2]%></td>
            <td class="DataTable2" nowrap><%=sDlvOrdVar[2]%>%</td>
            <td class="DataTable1" nowrap><%=sGrpNm%></td>
            
            <th class="DataTable5">&nbsp;</th>
            <%for(int j=0; j < 3; j++){%>
            	<td class="DataTable1" nowrap><%=sPrefvsOp[j]%></td>
            <%}%>            
          </tr>          
          <%}%>
       <%}%>
       <!-- -------------------------- Total ------------------------------- -->
       <%
            pfslsanl.setCompTot("TY");
            String sGrp = pfslsanl.getGrp();
            String [] sLayway = pfslsanl.getLayway();
            String [] sCash = pfslsanl.getCash();
            String [] sSls = pfslsanl.getSls();
            String [] sOrder = pfslsanl.getOrder();
            String [] sTotal = pfslsanl.getTotal();
            String [] sVar = pfslsanl.getVar();
            String [] sGmAmt = pfslsanl.getGmAmt();
            String [] sGmPrc = pfslsanl.getGmPrc();
            String [] sQuaAmt = pfslsanl.getQuaAmt();
            String [] sQuaCnt = pfslsanl.getQuaCnt();
            String [] sCurrFyOrd = pfslsanl.getCurrFyOrd();
            String [] sLastFyOrd = pfslsanl.getLastFyOrd();
            String [] sEoYOrd = pfslsanl.getEoYOrd();
            String [] sDlvOrd = pfslsanl.getDlvOrd();
            String [] sDlvOrdVar = pfslsanl.getDlvOrdVar();
            String [] sPrefvsOp = pfslsanl.getPrefvsOp();
            String [] sQuaCust = pfslsanl.getQuaCust();
            String [] sVarCust = pfslsanl.getVarCust();
            String [] sOrdCnt = pfslsanl.getOrdCnt();
            String [] sUndCnt = pfslsanl.getUndCnt();
            String [] sTotCnt = pfslsanl.getTotCnt();
            String [] sDlySls = pfslsanl.getDlySls();
            String [] sDlyCnt = pfslsanl.getDlyCnt();
            String [] sDlyVar = pfslsanl.getDlyVar();
            String [] sTotCash = pfslsanl.getTotCash();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap>Comp Stores</td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable2" nowrap><%=sDlyCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sDlySls[j]%></td>
               <td class="DataTable2" nowrap><%=sDlyVar[j]%>%</td>
               <td class="DataTable2" nowrap>$<%=sCash[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotCash[j]%></td>               
               <td class="DataTable2" nowrap><%=sOrdCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLayway[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sGmAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sGmPrc[j]%>%</td>
               <td class="DataTable2" nowrap><%=sUndCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sOrder[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCnt[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sQuaAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCust[j]%></td>
               <td class="DataTable2" nowrap><%=sVarCust[j]%>%</td>
               <td class="DataTable2" nowrap><%=sTotCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotal[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
            <%}%>
            <th class="DataTable5">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sEoYOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sLastFyOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sDlvOrd[2]%></td>
            <td class="DataTable2" nowrap><%=sDlvOrdVar[2]%>%</td>
            <td class="DataTable1" nowrap>Comp Stores</td>
            
            <th class="DataTable5">&nbsp;</th>
            <%for(int j=0; j < 3; j++){%>
            	<td class="DataTable1" nowrap><%=sPrefvsOp[j]%></td>
            <%}%>
       </tr>
       <!-- -------------------------- Total ------------------------------- -->
       <%
            pfslsanl.setTotals("TY");
            sGrp = pfslsanl.getGrp();
            sLayway = pfslsanl.getLayway();
            sCash = pfslsanl.getCash();
            sSls = pfslsanl.getSls();
            sOrder = pfslsanl.getOrder();
            sTotal = pfslsanl.getTotal();
            sVar = pfslsanl.getVar();
            sGmAmt = pfslsanl.getGmAmt();
            sGmPrc = pfslsanl.getGmPrc();
            sQuaAmt = pfslsanl.getQuaAmt();
            sQuaCnt = pfslsanl.getQuaCnt();
            sCurrFyOrd = pfslsanl.getCurrFyOrd();
            sLastFyOrd = pfslsanl.getLastFyOrd();
            sEoYOrd = pfslsanl.getEoYOrd();
            sDlvOrd = pfslsanl.getDlvOrd();
            sDlvOrdVar = pfslsanl.getDlvOrdVar();
            sPrefvsOp = pfslsanl.getPrefvsOp();
            sQuaCust = pfslsanl.getQuaCust();
            sVarCust = pfslsanl.getVarCust();
            sOrdCnt = pfslsanl.getOrdCnt();
            sUndCnt = pfslsanl.getUndCnt();
            sTotCnt = pfslsanl.getTotCnt();
            sDlySls = pfslsanl.getDlySls();
            sDlyCnt = pfslsanl.getDlyCnt();
            sDlyVar = pfslsanl.getDlyVar();
            sTotCash = pfslsanl.getTotCash();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable2" nowrap><%=sDlyCnt[j]%></td>               
               <td class="DataTable2" nowrap>
               <%if(j==0) {%>
               		<a href="OrderLst.jsp?FrOrdDt=<%=sDates[0]%>&ToOrdDt=<%=sDates[2]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%}  else if(j==1){%>	
               		<a href="OrderLst.jsp?FrOrdDt=<%=sDates[1]%>&ToOrdDt=<%=sDates[2]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%} else if(j==2){%>
               		<a href="OrderLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=<%=sDates[2]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%} %>
               </td>
               <td class="DataTable2" nowrap><%=sDlyVar[j]%>%</td>
               <td class="DataTable2" nowrap>$<%=sCash[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotCash[j]%></td>
               <td class="DataTable2" nowrap><%=sOrdCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLayway[j]%></td>                              
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sGmAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sGmPrc[j]%>%</td>
               <td class="DataTable2" nowrap><%=sUndCnt[j]%></td>
               <td class="DataTable2" nowrap> 
               <%if(j==0) {%>
                     <a href="OrderLst.jsp?FrOrdDt=<%=sDates[0]%>&ToOrdDt=<%=sDates[2]%>&PyStatus=P&PyStatus=F&PyStatus=E&PyStatus=O&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                     $<%=sOrder[j]%></a>
                  <%} else if(j==1){%>
                    <a href="OrderLst.jsp?FrOrdDt=<%=sDates[1]%>&ToOrdDt=<%=sDates[2]%>&PyStatus=P&PyStatus=F&PyStatus=E&PyStatus=O&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                     $<%=sOrder[j]%></a>
                  <%} else if(j==2){%>
                    <a href="OrderLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=<%=sDates[2]%>&PyStatus=P&PyStatus=F&PyStatus=E&PyStatus=O&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                     $<%=sOrder[j]%></a>
                  <%}%>
               </td>
               <td class="DataTable2" nowrap><%=sQuaCnt[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sQuaAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCust[j]%></td>
               <td class="DataTable2" nowrap><%=sVarCust[j]%>%</td>
               <td class="DataTable2" nowrap><%=sTotCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotal[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
            <%}%>
            <th class="DataTable5">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sEoYOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sLastFyOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sDlvOrd[2]%></td>
            <td class="DataTable2" nowrap><%=sDlvOrdVar[2]%>%</td>
            <td class="DataTable1" nowrap><%=sGrp%></td>
            
            <th class="DataTable5">&nbsp;</th>
            <%for(int j=0; j < 3; j++){%>
            	<td class="DataTable1" nowrap><%=sPrefvsOp[j]%></td>
            <%}%>
       </tr>



       <!-- ------------------------ Last Year ----------------------------- -->
       <tr class="DataTable">
              <th class="DataTable" colspan=61>Last Year</th>
              <th class="DataTable5" >&nbsp;</th>
              <th class="DataTable" colspan=5>&nbsp;</th>
       </tr>

       <!-- ======================== LY Details =========================== -->
       <%for(int i=0; i < iNumOfStr; i++ )
         {
            pfslsanl.setFlashSls("LY");
            sGrp = pfslsanl.getGrp();
            sLayway = pfslsanl.getLayway();
            sCash = pfslsanl.getCash();
            sSls = pfslsanl.getSls();
            sOrder = pfslsanl.getOrder();
            sTotal = pfslsanl.getTotal();
            sVar = pfslsanl.getVar();
            sGmAmt = pfslsanl.getGmAmt();
            sGmPrc = pfslsanl.getGmPrc();
            sQuaAmt = pfslsanl.getQuaAmt();
            sQuaCnt = pfslsanl.getQuaCnt();
            sCurrFyOrd = pfslsanl.getCurrFyOrd();
            sLastFyOrd = pfslsanl.getLastFyOrd();
            sEoYOrd = pfslsanl.getEoYOrd();
            sDlvOrd = pfslsanl.getDlvOrd();
            sDlvOrdVar = pfslsanl.getDlvOrdVar();
            sPrefvsOp = pfslsanl.getPrefvsOp();
            sQuaCust = pfslsanl.getQuaCust();
            sVarCust = pfslsanl.getVarCust();
            sOrdCnt = pfslsanl.getOrdCnt();
            sUndCnt = pfslsanl.getUndCnt();
            sTotCnt = pfslsanl.getTotCnt();
            sDlySls = pfslsanl.getDlySls();
            sDlyCnt = pfslsanl.getDlyCnt();
            sDlyVar = pfslsanl.getDlyVar();
            sTotCash = pfslsanl.getTotCash();
            
            String sSvGrp = sGrpLst[i];
        %>
            <tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable2" nowrap><%=sDlyCnt[j]%></td>
               <td class="DataTable2" nowrap>
               <%if(j==0) {%>
               		<a href="OrderLst.jsp?FrOrdDt=<%=sDates[3]%>&ToOrdDt=<%=sDates[5]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%}  else if(j==1){%>	
               		<a href="OrderLst.jsp?FrOrdDt=<%=sDates[4]%>&ToOrdDt=<%=sDates[5]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%} else if(j==2){%>
               		<a href="OrderLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=<%=sDates[5]%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT"  target="_blank">$<%=sDlySls[j]%></a>
               	<%} %>	
               </td>
               <td class="DataTable21" nowrap>&nbsp;</td>
               <td class="DataTable2" nowrap>$<%=sCash[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotCash[j]%></td>
               <td class="DataTable2" nowrap><%=sOrdCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLayway[j]%></td>                              
               
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sGmAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sGmPrc[j]%>%</td>
               <td class="DataTable2" nowrap><%=sUndCnt[j]%></td>
               <td class="DataTable2" nowrap>
                  <%if(j==0) {%>
                     <a href="OrderLst.jsp?FrOrdDt=<%=sDates[3]%>&ToOrdDt=<%=sDates[5]%>&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                     $<%=sOrder[j]%></a>
                  <%} else if(j==1){%>
                    <a href="OrderLst.jsp?FrOrdDt=<%=sDates[4]%>&ToOrdDt=<%=sDates[5]%>&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                      $<%=sOrder[j]%></a></td>
                  <%} else if(j==2){%>
                    <a href="OrderLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=<%=sDates[5]%>&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&Sort=ORDER&StsOpt=HISTORICAL" target="_blank">
                      $<%=sOrder[j]%></a></td>
                  <%}%>
               </td>
               <td class="DataTable2" nowrap><%=sQuaCnt[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sQuaAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCust[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>
               <td class="DataTable2" nowrap><%=sTotCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotal[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>
            <%}%>
            
            <th class="DataTable5">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sEoYOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sLastFyOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sDlvOrd[2]%></td>
            <td class="DataTable21" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap><%=sGrp%></td>
          </tr>
          <!-- -------------------- Group Store Total ---------------------- -->
          <%if(i == iNumOfStr-1 ||  !sSvGrp.equals(sGrpLst[i+1]))
          {
             pfslsanl.setGrpTot("LY");
             sGrp = pfslsanl.getGrp();
             sLayway = pfslsanl.getLayway();
             sCash = pfslsanl.getCash();
             sSls = pfslsanl.getSls();
             sOrder = pfslsanl.getOrder();
             sTotal = pfslsanl.getTotal();
             sVar = pfslsanl.getVar();
             sGmAmt = pfslsanl.getGmAmt();
             sGmPrc = pfslsanl.getGmPrc();
             sQuaAmt = pfslsanl.getQuaAmt();
             sQuaCnt = pfslsanl.getQuaCnt();
             sCurrFyOrd = pfslsanl.getCurrFyOrd();
             sLastFyOrd = pfslsanl.getLastFyOrd();
             sEoYOrd = pfslsanl.getEoYOrd();
             sDlvOrd = pfslsanl.getDlvOrd();
             sDlvOrdVar = pfslsanl.getDlvOrdVar();
             sPrefvsOp = pfslsanl.getPrefvsOp();
             sQuaCust = pfslsanl.getQuaCust();
             sVarCust = pfslsanl.getVarCust();
             sOrdCnt = pfslsanl.getOrdCnt();
             sUndCnt = pfslsanl.getUndCnt();
             sTotCnt = pfslsanl.getTotCnt();
             sDlySls = pfslsanl.getDlySls();
             sDlyCnt = pfslsanl.getDlyCnt();
             sDlyVar = pfslsanl.getDlyVar();
             
             String sGrpNm = "DC Area";
             if(sGrp.trim().equals("2")){ sGrpNm = "NY Store"; }
             if(sGrp.trim().equals("3")){ sGrpNm = "NE Area"; }
          %>
          <tr id="trGrp" class="DataTable2">
            <td class="DataTable1" nowrap><%=sGrpNm%></td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable2" nowrap><%=sDlyCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sDlySls[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>         
               <td class="DataTable2" nowrap>$<%=sCash[j]%></td>    
               <td class="DataTable2" nowrap>$<%=sTotCash[j]%></td>  
               <td class="DataTable2" nowrap><%=sOrdCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLayway[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sGmAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sGmPrc[j]%>%</td>
               <td class="DataTable2" nowrap><%=sUndCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sOrder[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCnt[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sQuaAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCust[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>
               <td class="DataTable2" nowrap><%=sTotCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotal[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>
            <%}%>
            
            <th class="DataTable5">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sEoYOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sLastFyOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sDlvOrd[2]%></td>
            <td class="DataTable21" nowrap>&nbsp;</td>    
            <td class="DataTable1" nowrap><%=sGrpNm%></td>        
          </tr>
          <%}%>
       <%}%>
       <!-- ----------------------- LY Total ------------------------------- -->
       <%
            pfslsanl.setTotals("LY");
            sGrp = pfslsanl.getGrp();
            sLayway = pfslsanl.getLayway();
            sCash = pfslsanl.getCash();
            sSls = pfslsanl.getSls();
            sOrder = pfslsanl.getOrder();
            sTotal = pfslsanl.getTotal();
            sVar = pfslsanl.getVar();
            sGmAmt = pfslsanl.getGmAmt();
            sGmPrc = pfslsanl.getGmPrc();
            sQuaAmt = pfslsanl.getQuaAmt();
            sQuaCnt = pfslsanl.getQuaCnt();
            sCurrFyOrd = pfslsanl.getCurrFyOrd();
            sLastFyOrd = pfslsanl.getLastFyOrd();
            sEoYOrd = pfslsanl.getEoYOrd();
            sDlvOrd = pfslsanl.getDlvOrd();
            sDlvOrdVar = pfslsanl.getDlvOrdVar();
            sPrefvsOp = pfslsanl.getPrefvsOp();
            sQuaCust = pfslsanl.getQuaCust();
            sVarCust = pfslsanl.getVarCust();
            sOrdCnt = pfslsanl.getOrdCnt();
            sUndCnt = pfslsanl.getUndCnt();
            sTotCnt = pfslsanl.getTotCnt();
            sDlySls = pfslsanl.getDlySls();
            sDlyCnt = pfslsanl.getDlyCnt();
            sDlyVar = pfslsanl.getDlyVar();
            sTotCash = pfslsanl.getTotCash();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable2" nowrap><%=sDlyCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sDlySls[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>         
               <td class="DataTable2" nowrap>$<%=sCash[j]%></td> 
               <td class="DataTable2" nowrap>$<%=sTotCash[j]%></td>     
               <td class="DataTable2" nowrap><%=sOrdCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLayway[j]%></td>               
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sGmAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sGmPrc[j]%>%</td>
               <td class="DataTable2" nowrap><%=sUndCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sOrder[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sQuaAmt[j]%></td>
               <td class="DataTable2" nowrap><%=sQuaCust[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>
               <td class="DataTable2" nowrap><%=sTotCnt[j]%></td>
               <td class="DataTable2" nowrap>$<%=sTotal[j]%></td>
               <td class="DataTable21" nowrap>&nbsp;</td>
            <%}%>
            <th class="DataTable5">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sEoYOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sLastFyOrd[2]%></td>
            <td class="DataTable2" nowrap>$<%=sDlvOrd[2]%></td>
            <td class="DataTable21" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap><%=sGrp%></td>
       </tr>

       <!-- ----------------------- LY Total ------------------------------- -->


     </table>
       <p style="text-align:left; font-size:14px">
       <b><u>Patio Sales:</u></b> Patio Sales represented under these columns will appear on other ‘Flash Sales and Stock Ledger’ inquiries under Div 50, and Div 95 (Class: 5000, 9985).
       <br><b><u>Released (Delivered) Orders:</u></b> Orders that were released from CP POS and delivered to customers. Sales are recorded in Div 50, and Div 95.
       <br><b><u>Cash/Carry:</u></b> Transactions that were 'Cash/Carry' (rung directly in CP POS, and taken by the customer – and not entered as an order on the Intranet).  Sales are recorded in Div 50.
       <br><b><u>Open (Undelievered):</u></b>  Orders that have been entered on the Intranet, but not yet released from CP POS.  When released, overnight processing updates patio order as 'Completed'.

       <br>
       <b><u>Note:</u></b> Under the "Total" column it is possible that sales from the same order
       may be included in both TY and LY totals.  This occurs when there is an open/undelivered
       order<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; as of the last day of the fiscal year (i.e., Year 1) and it ships during the following
       year (i.e., Year 2). The order will be included in the "Open/Undelivered" column in
       <br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Year 1 and again in the "Released/Delivered Orders" column in Year 2.


      </TD>
     </TR>
    </TBODY>
   </TABLE>
   <div id="dvElapse" style="font-size:8px;"></div>
   <script>
   var EndDate = new Date();
   var elapse = (EndDate.getTime() - BegDate) / 1000;
   document.all.dvElapse.innerHTML = elapse + " sec.";   
   </script>
   
</BODY></HTML>
<%
   pfslsanl.disconnect();
   pfslsanl = null;
   }
%>