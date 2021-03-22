<%@ page import="aim.AmLogLst"%>
<%
   String sSelId = request.getParameter("id");
   String sSelGrp = request.getParameter("grp");
   String [] sSelType = request.getParameterValues("type");

   if(sSelType == null){ sSelType = new String[]{"ALL"}; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AimCouponLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmLogLst loglst = new AmLogLst(sSelId, sSelGrp, sSelType, sUser);
      int iNumOfLog = loglst.getNumOfLog();
%>

<html>
<head>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
  <!----------------------- Comment List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbLog">
       <tr class="DataTable3">
         <th class="DataTable">Type</th>
         <th class="DataTable">Comments</th>
         <th class="DataTable">User, Date, Time</th>
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    for(int i=0; i < iNumOfLog; i++)
    {
      loglst.setLogLst();
      String sLog = loglst.getLog();
      String sId = loglst.getId();
      String sType = loglst.getType();
      int iNumOfLin = loglst.getNumOfLin();
      String [] sText = loglst.getText();
      String sRecUs = loglst.getRecUs();
      String sRecDt = loglst.getRecDt();
      String sRecTm = loglst.getRecTm();
  %>
     <tr class="DataTable3">
       <td class="DataTable" nowrap><%=sType%></td>
       <td class="DataTable" width="80%" nowrap>
          <%for(int j=0; j < iNumOfLin; j++){%><%=sText[j]%><%}%>
       </td>
       <td class="DataTable" nowrap><%=sRecUs%> <%=sRecDt%> <%=sRecTm%></td>
     </tr>
  <%}%>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>


</html>
<%
    loglst.disconnect();
    loglst = null;
%>
<script language="javascript">
  var html = document.all.tbLog.outerHTML;
  parent.showComments(html);
</script>
<%}%>