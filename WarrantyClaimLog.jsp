<%@ page import="patiosales.WarrantyClaimLog ,java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sClaim = request.getParameter("Claim");

//----------------------------------
// Application Authorization
//----------------------------------
String sUser = session.getAttribute("USER").toString();

if (session.getAttribute("USER")!=null)
{
    WarrantyClaimLog wcloge = new WarrantyClaimLog();
    wcloge.getClaimLog(sOrder, sClaim, sUser);
%>
<body>
   <table border=1 cellPadding="0" cellSpacing="0" id="tblLog" >
     <tr  class="DataTable">
        <th class="DataTable4" colspan=10>Review of Issue/Warranty Tracking<br>&nbsp;</th>
     </tr>
     <tr  class="DataTable">
        <th class="DataTable4" nowrap>Claim Status</th>
        <th class="DataTable4" nowrap>SKU</th>
        <th class="DataTable4" nowrap>Vendor</th>
        <th class="DataTable4" nowrap>Vendor Style</th>
        <th class="DataTable4" nowrap>Issue</th>
        <th class="DataTable4" nowrap>Action</th>
        <th class="DataTable4" nowrap>Item Status</th>
        <th class="DataTable4" nowrap>User</th>
        <th class="DataTable4" nowrap>Date</th>
        <th class="DataTable4" nowrap>Time</th>
     </tr>
     <!-- ========================== Details =============================== -->
     <%while(wcloge.getNext())
       {
          wcloge.setClaimLogArr();
          int iNumOfLog = wcloge.getNumOfLog();
          String [] sSource = wcloge.getSource();
          String [] sItem = wcloge.getItem();
          String [] sSku = wcloge.getSku();
          String [] sVen = wcloge.getVen();
          String [] sVenSty = wcloge.getVenSty();
          String [] sIssue = wcloge.getIssue();
          String [] sAction = wcloge.getAction();
          String [] sSts = wcloge.getSts();
          String [] sRecUser = wcloge.getRecUser();
          String [] sRecDate = wcloge.getRecDate();
          String [] sRecTime = wcloge.getRecTime();
          String [] sIssNm = wcloge.getIssNm();
          String [] sActNm = wcloge.getActNm();
          String [] sStsNm = wcloge.getStsNm();

          for(int i=0; i < iNumOfLog; i++){%>
             <tr  class="DataTable<%if(sIssue[i].equals("REMOVED")){%>6<%}%>">
              <td class="DataTable" nowrap><%if(sSource[i].equals("CLAIM")){%><%=sStsNm[i]%><%} else {%>&nbsp;<%}%></td>
              <td class="DataTable" nowrap>&nbsp;<%=sSku[i]%></td>
              <td class="DataTable" nowrap>&nbsp;<%=sVen[i]%></td>
              <td class="DataTable" nowrap>&nbsp;<%=sVenSty[i]%></td>
              <td class="DataTable" nowrap><%=sIssNm[i]%>&nbsp;</td>
              <td class="DataTable" nowrap><%=sActNm[i]%>&nbsp;</td>
              <td class="DataTable" nowrap><%if(!sSource[i].equals("CLAIM")){%><%=sStsNm[i]%><%}%>&nbsp;</td>
              <td class="DataTable" nowrap><%=sRecUser[i]%></td>
              <td class="DataTable" nowrap><%=sRecDate[i]%></td>
              <td class="DataTable" nowrap><%=sRecTime[i]%></td>
             </tr>
          <%}%>
     <%}%>


   </table>
</body>
<SCRIPT language="JavaScript1.2">
  var html = document.all.tblLog.outerHTML
  //alert(document.all.tblLog.outerHTML);
  parent.showLogEntires(html);
</SCRIPT>

<%
    wcloge.disconnect();
    wcloge = null;
}
else {%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to modify claim.")
</SCRIPT>

<%}%>





