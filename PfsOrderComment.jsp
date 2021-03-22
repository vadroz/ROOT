<%@ page import="patiosales.PfsOrderComment, patiosales.OrderEntry, java.util.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sType = request.getParameter("Type");
   String sFilter = request.getParameter("Filter");

   if (sFilter == null){ sFilter = "ALL"; }

   PfsOrderComment getcommt = null;
   String sComments = "";
   OrderEntry ordent = null;

   if(sType.equals("NOT"))
   {
       getcommt = new PfsOrderComment(sOrder, sType);
       sComments = getcommt.getComments();
       getcommt.disconnect();
   }
   else
   {%>

   <%
         ordent = new OrderEntry();
         ordent.setOrdCommt(sOrder);
         int iNumOfCmt = ordent.getNumOfCmt();
  %>
   <table border=1 width="100%" cellPadding=0 cellSpacing=0 id="tblCmtLog">
         <tr class="DataTable">
            <th class="DataTable" colspan=5>
               <input type="checkbox" id="chkFltr" onclick="setCmtFilter(['AUTO', 'PAYMENT'], this, '<%=iNumOfCmt%>')" checked>Auto &nbsp;  &nbsp;
               <input type="checkbox" id="chkFltr" onclick="setCmtFilter(['SOLD TAG'], this, '<%=iNumOfCmt%>')" checked>Sold Tag &nbsp;  &nbsp;
               <input type="checkbox" id="chkFltr" onclick="setCmtFilter(['STORE', 'CUST'], this, '<%=iNumOfCmt%>')" checked>Store &nbsp;  &nbsp;
               <input type="checkbox" id="chkFltr" onclick="setCmtFilter(['BUYER', 'VCN'], this, '<%=iNumOfCmt%>')" checked>Buyer &nbsp;  &nbsp;

               <input type="checkbox" id="chkFltr" onclick="setCmtFilter(['QUOTE', 'QTOS'], this, '<%=iNumOfCmt%>')" checked>Quotes &nbsp;  &nbsp;

               <input type="checkbox" id="chkFltr" onclick="setCmtFilter(['QST1', 'QST2', 'QST3'], this, '<%=iNumOfCmt%>')" checked>Follow Up &nbsp;  &nbsp;
               
               <input type="checkbox" id="chkFltr" onclick="setCmtFilter(['EMAIL'], this, '<%=iNumOfCmt%>')" checked>E-Mail &nbsp;  &nbsp;
            </th>
         <tr class="DataTable">
           <th class="DataTable" width="5%">Type</th>
           <th class="DataTable">Comments<br><span style="font-size:11px;">(Ranked by most recently added)</span></th>
           <th class="DataTable" width="5%">User</th>
           <th class="DataTable" width="15%">Date</th>
           <th class="DataTable" width="5%">Time</th>
         </tr>

         <%
         for(int i=0; i < iNumOfCmt;i++ )
         {
           ordent.rcvOrdCommt(i+1);
           String sCmtId = ordent.getCmtId();
           String sCmtType = ordent.getCmtType();
           String sCmtUser = ordent.getCmtUser();
           String sCmtDate = ordent.getCmtDate();
           String sCmtTime = ordent.getCmtTime();
           String sCmtMax = ordent.getCmtMax();
           String [] sCmtText = ordent.getCmtText();
         %>
             <tr class="DataTable" id="trCmtLog<%=i%>">
               <td class="DataTable2" id="tdCmtTy<%=i%>"><%=sCmtType%></td>
               <td class="DataTable">
                 <%for(int j=0; j < sCmtText.length;j++ ){%><%=sCmtText[j]%><%}%>
               </td>
               <td class="DataTable2" nowrap><%=sCmtUser%></td>
               <td class="DataTable2" nowrap><%=sCmtDate%></td>
               <td class="DataTable2" nowrap><%=sCmtTime%></td>
             </tr>
         <%}%>
       </table>
       <%
          ordent.disconnect();
          ordent = null;
       %>
 <%}%>

<SCRIPT language="JavaScript1.2">
var Comment = "<%=sComments%>";
var Type = "<%=sType%>";
goBack();

//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   if (Type == "NOT")
   {
      parent.showNote(Comment);
   }
   else
   {
      var html = document.all.tblCmtLog.outerHTML;
      parent.showComments(html);
   }
}
</SCRIPT>









