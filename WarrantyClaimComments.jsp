<%@ page import="patiosales.WarrantyClaimComments ,java.util.*, java.text.*"%>
<%
   String sSelOrder = request.getParameter("Order");
   String sSelClaim = request.getParameter("Claim");
   String sSelItem = request.getParameter("Item");
   String sSku = request.getParameter("Sku");
   String sVen = request.getParameter("Ven");
   String sVenNm = request.getParameter("VenNm");
   String sVenSty = request.getParameter("VenSty");
   String sChg = request.getParameter("Chg");
   String sAction = request.getParameter("Action");

   if(sSelItem==null){sSelItem = "0000000000";}
   if(sChg == null){ sChg = "Y"; }
//----------------------------------
// Application Authorization
//----------------------------------
String sUser = session.getAttribute("USER").toString();

if (session.getAttribute("USER")!=null)
{
    WarrantyClaimComments wcclmcom = new WarrantyClaimComments();
    if(sAction.equals("GET_CLAIM_COMMENTS"))
    {
       wcclmcom.rtvClaimComments(sSelOrder, sSelClaim, sAction, sUser);
    }
    else if(sAction.equals("GET_ITEM_COMMENTS"))
    {
       wcclmcom.rtvItemComments(sSelOrder, sSelClaim, sSelItem, sAction, sUser);
    }

    int iNumOfCmt = wcclmcom.getNumOfCmt();
%>
<body>
<table border=1 cellPadding="0" cellSpacing="0" width="100%"
  id="tbl<%if(sAction.equals("GET_CLAIM_COMMENTS")){%>tblComments<%}
           else {%><%=sSelItem%>Comments<%}%>">
     <tr class="DataTable">
        <th class="DataTable4">User, Date, Time</th>
        <th class="DataTable4"><%if(sAction.equals("GET_ITEM_COMMENTS")){%>SKU <%=sSku%> Style: <%=sVenSty%> Comments<%} else {%>Claim Comments<%}%></th>
        <%if(!sChg.equals("N")){%>
           <th class="DataTable4">U<br>p<br>d</th>
           <th class="DataTable4">D<br>l<br>t</th>
        <%}%>
     </tr>
     <%for(int i=0; i < iNumOfCmt; i++){
         wcclmcom.setComment();
         String sCommId = wcclmcom.getCommId();
         String sType = wcclmcom.getType();
         String sCrtByUser = wcclmcom.getUser();
         String sDate = wcclmcom.getDate();
         String sTime = wcclmcom.getTime();
         String sText = wcclmcom.getText();
     %>
        <tr class="DataTable">
          <td class="DataTable" width="20%"><%=sCrtByUser%> <%=sDate%> <%=sTime%></td>
          <td class="DataTable"><%=sText%></td>
          <%if(!sChg.equals("N")){%>
             <%if(sAction.equals("GET_CLAIM_COMMENTS")){%>
                 <td class="DataTable"><a href="javascript:addClmComment('<%=sCommId%>','<%=sText%>','UPDATE')">Upd</a></td>
                 <td class="DataTable"><a href="javascript:addClmComment('<%=sCommId%>','<%=sText%>','DELETE')">Dlt</a></td>
             <%}%>
             <%if(sAction.equals("GET_ITEM_COMMENTS")){%>
                 <td class="DataTable"><a href="javascript:addItmComments('<%=sSelItem%>', '<%=sSku%>', '<%=sCommId%>', '<%=sText%>','UPDATE')">Upd</a></td>
                 <td class="DataTable"><a href="javascript:addItmComments('<%=sSelItem%>', '<%=sSku%>', '<%=sCommId%>', '<%=sText%>','DELETE')">Dlt</a></td>
             <%}%>
          <%}%>
        </tr>
     <%}%>
</table>
</body>
<%
  wcclmcom.disconnect();
  wcclmcom = null;
%>
<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>"
if(Action == "GET_CLAIM_COMMENTS")
{
   parent.setClaimComments("<%=iNumOfCmt%>");
}
else if(Action == "GET_ITEM_COMMENTS")
{
   parent.setItemComments("<%=iNumOfCmt%>");
}
</SCRIPT>

<%}
else {%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to modify claim.")
</SCRIPT>

<%}%>





