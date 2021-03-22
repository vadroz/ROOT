<%@ page import="patiosales.PatioFlashSls, java.util.*, java.text.*"%>
<%
    String sWkend = request.getParameter("Wkend");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PatioFlashSls.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PatioFlashSls pfflash = new PatioFlashSls("ALL", sWkend, "vrozen");
    String [] sTyDate = pfflash.getTyDate();
    String [] sLyDate = pfflash.getLyDate();
    int iNumOfStr = pfflash.getNumOfStr();
    String [] sStrLst = pfflash.getStrLst();
    String [] sGrpLst = pfflash.getGrpLst();

    String [] sWkTyUndel = new String[iNumOfStr + 1];
    String [] sWkLyUndel = new String[iNumOfStr + 1];
    String [] sUnDelGrp = new String[iNumOfStr];
    
    // calculate beginning of week date
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    Calendar c = Calendar.getInstance();
    c.setTime(sdf.parse(sWkend));
    int dofw = c.get(Calendar.DAY_OF_WEEK);    
    int subdy = -6; 
    if(dofw > 1){ subdy = (dofw - 2) * -1; }
    System.out.println("dayofweek=" + dofw + " subtract=" + subdy);
    c.add(Calendar.DATE, subdy);
    String sBegWk = sdf.format(c.getTime());
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

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.DataTable2 { background: #ccffcc; font-size:10px }
        tr.DataTable3 { background: moccasin; font-size:10px }

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


<script name="javascript1.3">
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
        <BR>Patio Orders Entered - by Week<br>
        Compare date Range <%=sTyDate[0]%> thru <%=sTyDate[6]%> to Range <%=sLyDate[0]%> thru <%=sLyDate[6]%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="PatioFlashSlsSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
              <th class="DataTable" colspan=33>Patio Sale Orders - This Week
              <br>(Entered as a direct Sales, or Converted from a Quote)</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable" rowspan=3>Store</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>

             <th class="DataTable" colspan=3>Mon</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Tue</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Wed</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Thu</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Fri</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Sat</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Sun</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>

             <th class="DataTable" colspan=3>W-T-D</th>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 7; i++){%>
                <th class="DataTable3"><%=sTyDate[i].substring(0, 5)%></th>
                <th class="DataTable3"><%=sLyDate[i].substring(0, 5)%></th>
                <th class="DataTable4" rowspan=2>Var</th>
            <%}%>
            <th class="DataTable4" rowspan=2>TY</th>
            <th class="DataTable4" rowspan=2>LY</th>
            <th class="DataTable4" rowspan=2>Var</th>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 7; i++){%>
                <th class="DataTable3">TY</th>
                <th class="DataTable3">LY</th>
            <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfStr; i++ )
         {
            pfflash.setFlashSls();
            String sGrp = pfflash.getGrp();
            String [] sTySls = pfflash.getTySls();
            String [] sLySls = pfflash.getLySls();
            String [] sVar = pfflash.getVar();

            sUnDelGrp[i] = pfflash.getGrp();
            sWkTyUndel[i] = pfflash.getTyUndel();
            sWkLyUndel[i] = pfflash.getLyUndel();

            String sSvGrp = sGrpLst[i];
        %>
            <tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap><a href="OrderLst.jsp?FrOrdDt=<%=sBegWk%>&ToOrdDt=<%=sWkend%>&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=C&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=&SlsPer=&StrGrp=<%=sGrp%>&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT" target="_blank">$<%=sTySls[7]%></a></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
          </tr>
          <!-- -------------------- Group Store Total ---------------------- -->
          <%if(i == iNumOfStr-1 ||  !sSvGrp.equals(sGrpLst[i+1]))
          {
            pfflash.setGrpTot();
            sGrp = pfflash.getGrp();
            sTySls = pfflash.getTySls();
            sLySls = pfflash.getLySls();
            sVar = pfflash.getVar();

            sUnDelGrp[i] = pfflash.getGrp();
            sWkTyUndel[i] = pfflash.getTyUndel();
            sWkLyUndel[i] = pfflash.getLyUndel();

            String sGrpNm = "DC Area";
             if(sGrp.trim().equals("2")){ sGrpNm = "NY Store"; }
             if(sGrp.trim().equals("3")){ sGrpNm = "NE Area"; }
          %>
          <tr id="trProd" class="DataTable2">
            <td class="DataTable1" nowrap><%=sGrpNm%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap>$<%=sTySls[7]%></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
          </tr>
          <%}%>
       <%}%>
       <!-- ------------------- Comp Store Total --------------------------- -->
       <%
            pfflash.setCompStrTot();
            String sGrp = pfflash.getGrp();
            String [] sTySls = pfflash.getTySls();
            String [] sLySls = pfflash.getLySls();
            String sTyUndel = pfflash.getTyUndel();
            String sLyUndel = pfflash.getLyUndel();
            String [] sVar = pfflash.getVar();

            sWkTyUndel[iNumOfStr] = pfflash.getTyUndel();
            sWkLyUndel[iNumOfStr] = pfflash.getLyUndel();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap>$<%=sTySls[7]%></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
       </tr>
              <!-- -------------------------- Total ------------------------------- -->
       <%
            pfflash.setTotals();
            sGrp = pfflash.getGrp();
            sTySls = pfflash.getTySls();
            sLySls = pfflash.getLySls();
            sTyUndel = pfflash.getTyUndel();
            sLyUndel = pfflash.getLyUndel();
            sVar = pfflash.getVar();

            sWkTyUndel[iNumOfStr] = pfflash.getTyUndel();
            sWkLyUndel[iNumOfStr] = pfflash.getLyUndel();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap>$<%=sTySls[7]%></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
       </tr>

   <!-- ======================================================================= -->
   <tr class="DataTable3"><th colspan=33>&nbsp;<br>&nbsp;</th></tr>
   <%pfflash.setQuotes();%>    
         <tr class="DataTable">
              <th class="DataTable" colspan=33>Patio Quotes - This Week
              <br>(Quotes Entered for Customers)</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable" rowspan=3>Store</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>

             <th class="DataTable" colspan=3>Mon</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Tue</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Wed</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Thu</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Fri</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Sat</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>
             <th class="DataTable" colspan=3>Sun</th>
             <th class="DataTable" rowspan=3>&nbsp;</th>

             <th class="DataTable" colspan=3>W-T-D</th>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 7; i++){%>
                <th class="DataTable3"><%=sTyDate[i].substring(0, 5)%></th>
                <th class="DataTable3"><%=sLyDate[i].substring(0, 5)%></th>
                <th class="DataTable4" rowspan=2>Var</th>
            <%}%>
            <th class="DataTable4" rowspan=2>TY</th>
            <th class="DataTable4" rowspan=2>LY</th>
            <th class="DataTable4" rowspan=2>Var</th>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 7; i++){%>
                <th class="DataTable3">TY</th>
                <th class="DataTable3">LY</th>
            <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfStr; i++ )
         {
            pfflash.setFlashSls();
            sGrp = pfflash.getGrp();
            sTySls = pfflash.getTySls();
            sLySls = pfflash.getLySls();
            sVar = pfflash.getVar();

            sUnDelGrp[i] = pfflash.getGrp();
            sWkTyUndel[i] = pfflash.getTyUndel();
            sWkLyUndel[i] = pfflash.getLyUndel();

            String sSvGrp = sGrpLst[i];
        %>
            <tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap>$<%=sTySls[7]%></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
          </tr>
          <!-- -------------------- Group Store Total ---------------------- -->
          <%if(i == iNumOfStr-1 ||  !sSvGrp.equals(sGrpLst[i+1]))
          {
            pfflash.setGrpTot();
            sGrp = pfflash.getGrp();
            sTySls = pfflash.getTySls();
            sLySls = pfflash.getLySls();
            sVar = pfflash.getVar();

            sUnDelGrp[i] = pfflash.getGrp();
            sWkTyUndel[i] = pfflash.getTyUndel();
            sWkLyUndel[i] = pfflash.getLyUndel();

            String sGrpNm = "DC Area";
             if(sGrp.trim().equals("2")){ sGrpNm = "NY Store"; }
             if(sGrp.trim().equals("3")){ sGrpNm = "NE Area"; }
          %>
          <tr id="trProd" class="DataTable2">
            <td class="DataTable1" nowrap><%=sGrpNm%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap>$<%=sTySls[7]%></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
          </tr>
          <%}%>
       <%}%>
       <!-- ------------------- Comp Store Total --------------------------- -->
       <%
            pfflash.setCompStrTot();
            sGrp = pfflash.getGrp();
            sTySls = pfflash.getTySls();
            sLySls = pfflash.getLySls();
            sVar = pfflash.getVar();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap>$<%=sTySls[7]%></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
       </tr>
              <!-- -------------------------- Total ------------------------------- -->
       <%
            pfflash.setTotals();
            sGrp = pfflash.getGrp();
            sTySls = pfflash.getTySls();
            sLySls = pfflash.getLySls();
            sTyUndel = pfflash.getTyUndel();
            sLyUndel = pfflash.getLyUndel();
            sVar = pfflash.getVar();

            sWkTyUndel[iNumOfStr] = pfflash.getTyUndel();
            sWkLyUndel[iNumOfStr] = pfflash.getLyUndel();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap><%=sGrp%></td>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < 7; j++){%>
               <td class="DataTable2" nowrap>$<%=sTySls[j]%></td>
               <td class="DataTable2" nowrap>$<%=sLySls[j]%></td>
               <td class="DataTable2" nowrap><%=sVar[j]%>%</td>
               <th class="DataTable">&nbsp;</th>
            <%}%>
            <td class="DataTable2" nowrap>$<%=sTySls[7]%></td>
            <td class="DataTable2" nowrap>$<%=sLySls[7]%></td>
            <td class="DataTable2" nowrap><%=sVar[7]%>%</td>
       </tr>

     </table>
   
<p>
<div style="font-size:12px; text-align:left; width:80%">
All Patio Sale Orders (In-Stock and Special Orders) on this report, are based on the Date the Patio Sale order was entered (as a direct sale), or converted from an original Quote.
If the Patio Sales Order was entered (or converted to a sale) within the Week dates selected, it is included in this report - regardless of the current status (Open, or Completed.) 
Patio Sale Orders that are appearing as a 'Sale' in this week, may later be cancelled in a subsequent week.
<br>This report does NOT include CASH and CARRY Patio sales.
</div>
      

     <!-- ================================================================== -->
     <!-- ===================== Backlog ==================================== -->
     <!-- ================================================================== -->
       <!--table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
           <th class="DataTable" colspan=25>Backlog</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable" >Store</th>
             <th class="DataTable" >&nbsp;</th>
             <th class="DataTable" >TY</th>
             <th class="DataTable" >&nbsp;</th>
             <th class="DataTable" >LY</th>
         </tr -->
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfStr; i++ ) {%>
            <!--tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap><%=sUnDelGrp[i]%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWkTyUndel[i]%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWkLyUndel[i]%></td>
          </tr -->
       <%}%>
       <!-- -------------------------- Total ------------------------------- -->
       <!--tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap>Total</td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWkTyUndel[iNumOfStr]%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWkLyUndel[iNumOfStr]%></td>
       </tr>
     </table -->


      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   pfflash.disconnect();
   pfflash = null;
   }
%>