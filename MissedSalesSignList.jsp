<%@ page import="salesigns01.MissedSalesSignList, java.io.File, java.util.*, java.text.*"%>
<%
    String sSignType = request.getParameter("SIGN");
    if(sSignType == null) sSignType = "SALES";

    MissedSalesSignList miss = new MissedSalesSignList(sSignType);
    int iNumOfDoc = miss.getNumOfDoc();
    String [] sMissDiv = miss.getMissDiv();
    String [] sMissDivName = miss.getMissDivName();
    String [] sMissDpt = miss.getMissDpt();
    String [] sMissLog = miss.getMissLog();
    miss.disconnect();

    SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    Calendar cal = Calendar.getInstance();
    Date date = cal.getTime();
    String sDate = df.format(date);
%>

<style>body {background:ivory;text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:MintCream; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }

</style>

<!-- ======================================================================= -->
<script language="javascript1.2">

</script>

<!-- ======================================================================= -->

<BODY >
 <table border="0">
  <tr>
     <td align="center"><b>Signs on AS400 <br>that are missing the documents on Internet</b></td>
  </tr>

  <tr>
     <td align="center"><%=sDate%></td>
  </tr>
<!-- ==========================Data Table ================================== -->
  <tr>
   <td align="center">
    <table class="DataTable" align="center" >
      <tr>
        <th class="DataTable" >Div</th>
        <th class="DataTable" >Division Name</th>
        <th class="DataTable" >Department</th>
        <th class="DataTable" >Log Number</th>
      </tr>

      <%for(int i=0;  i < iNumOfDoc; i++){ %>
         <tr>
           <td class="DataTable"><%=sMissDiv[i]%></td>
           <td class="DataTable"><%=sMissDivName[i]%></td>
           <td class="DataTable"><%=sMissDpt[i]%></td>
           <td class="DataTable"><%=sMissLog[i]%></td>
         </tr>
       <%}%>

     </table>
   </td>
  </tr>
 </table>
</BODY>
</HTML>
