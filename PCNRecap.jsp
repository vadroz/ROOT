<%@ page import="pcn.PCNRecap"%>
<%
    String sStore = request.getParameter("STORE");

    String sFromDate = request.getParameter("FromDate");
    String sToDate = request.getParameter("ToDate");
    String sSort = request.getParameter("Sort");

    if(sSort==null && sStore.equals("ALL")) sSort = "STR";
    else if(sSort==null && !sStore.equals("ALL")) sSort = "CSHNAME";

    PCNRecap pcnrecap = new PCNRecap(sStore, sFromDate, sToDate, sSort);
    int iNumOfCsh = pcnrecap.getNumOfCsh();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

</style>


<script name="javascript1.2">
var SelRow = 0;
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}
</script>

<HTML><HEAD>

<META content="RCI, Inc." name=RCNRecap></HEAD>
<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Preferred Customer Number(PCN) Recap
        <br>Store: <%=sStore%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="PCNRecapSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;

<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr  class="DataTable">
           <%if(!sStore.equals("ALL")) {%>
              <th class="DataTable" rowspan="2"><a href="PCNRecap.jsp?STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=CSHNUM">Cashier<br>#</a></th>
           <%}%>
           <%if(!sStore.equals("ALL")) {%>
              <th class="DataTable" rowspan="2"><a href="PCNRecap.jsp?STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=CSHNAME">Cashier Name</a></th>
           <%}%>
           <th class="DataTable" rowspan="2">
              <%if(sStore.equals("ALL")) {%><a href="PCNRecap.jsp?STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=STR">Store</a>
              <%} else {%>Assign to<br>Store<%}%>
           </th>
           <%if(!sStore.equals("ALL")) {%>
              <th class="DataTable" rowspan="2">Title</th>
           <%}%>
           <th class="DataTable" rowspan="2">Total<br># Total</th>
           <th class="DataTable" colspan="2">Invalid PCN's</th>
           <th class="DataTable" colspan="2">Valid PCN's</th>
         </tr>
           <th class="DataTable"><a href="PCNRecap.jsp?STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=INVTRN">#<br>Trans#</a></th>
           <th class="DataTable"><a href="PCNRecap.jsp?STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=INVPRC">%<br>Tran</a></th>
           <th class="DataTable"><a href="PCNRecap.jsp?STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=VALTRN">#<br>Trans#</a></th>
           <th class="DataTable"><a href="PCNRecap.jsp?STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=VALPRC">%<br>Tran</a></th>

         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfCsh; i++ )
         {
            pcnrecap.setDetail();
            String sCsh = pcnrecap.getCsh();
            String sCshName = pcnrecap.getCshName();
            String sStr = pcnrecap.getStr();
            String sTitle = pcnrecap.getTitle();
            String sNumTrn = pcnrecap.getNumTrn();
            String sInvTrn = pcnrecap.getInvTrn();
            String sInvPrc = pcnrecap.getInvPrc();
            String sValTrn = pcnrecap.getValTrn();
            String sValPrc = pcnrecap.getValPrc();
       %>
         <tr id="trGroup" class="DataTable">
            <%if(!sStore.equals("ALL")) {%>
              <td class="DataTable1" nowrap><%=sCsh%></td>
              <td class="DataTable1" nowrap><%=sCshName%></td>
            <%}%>
            <%if(sStore.equals("ALL")) {%>
              <td class="DataTable" nowrap><a class="small" href="PCNRecap.jsp?STORE=<%=sStr%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sort=CSHNAME"><%=sStr%></a></td>
            <%} else {%>
              <td class="DataTable" nowrap><%=sStr%></td>
            <%}%>
            <%if(!sStore.equals("ALL")) {%>
              <td class="DataTable1" nowrap><%=sTitle%></td>
            <%}%>
            <td class="DataTable" nowrap><%=sNumTrn%></td>
            <td class="DataTable" nowrap><%=sInvTrn%></td>
            <td class="DataTable" nowrap><%=sInvPrc%>%</td>
            <td class="DataTable" nowrap><%=sValTrn%></td>
            <td class="DataTable" nowrap><%=sValPrc%>%</td>
          </tr>
       <%}%>
       <%
          pcnrecap.setTotal();
          String sTotNumTrn = pcnrecap.getTotNumTrn();
          String sTotInvTrn = pcnrecap.getTotInvTrn();
          String sTotInvPrc = pcnrecap.getTotInvPrc();
          String sTotValTrn = pcnrecap.getTotValTrn();
          String sTotValPrc = pcnrecap.getTotValPrc();
       %>
       <tr id="trTot" class="DataTable1">
         <td class="DataTable1" colspan=<%if(sStore.equals("ALL")) {%>1<%} else {%>4<%}%> nowrap>Total</td>
         <td class="DataTable1" nowrap><%=sTotNumTrn%></td>
         <td class="DataTable1" nowrap><%=sTotInvTrn%></td>
         <td class="DataTable1" nowrap><%=sTotInvPrc%>%</td>
         <td class="DataTable1" nowrap><%=sTotValTrn%></td>
         <td class="DataTable1" nowrap><%=sTotValPrc%>%</td>
       </tr>
     </table>
<!-- ======================================================================= -->
      <span style="font-size:12px"><b>Valid PCN's</b> - are any 10-digit phone #'s having an area code between
            201 and 989, and all <u>store</u> specific 'International' phone #'s (i.e., 0030000001, etc.)</span>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   pcnrecap.disconnect();
%>