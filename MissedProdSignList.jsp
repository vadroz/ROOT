<%@ page import="salesigns01.MissedProdSignList, java.io.File, java.util.*, java.text.*"%>
<%
    MissedProdSignList miss = new MissedProdSignList();
    int iNumOfDoc = miss.getNumOfDoc();
    String [] sMissDiv = miss.getMissDiv();
    String [] sMissDivName = miss.getMissDivName();
    String [] sMissCls = miss.getMissCls();
    String [] sMissVnd = miss.getMissVnd();
    String [] sMissSty = miss.getMissSty();
    String [] sMissClr = miss.getMissClr();
    String [] sMissSiz = miss.getMissSiz();
    String [] sMissCrD = miss.getMissCrD();
    String [] sMissPath = miss.getMissPath();
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
     <td align="center"><b>Missing Product Signs List</b></td>
  </tr>

  <tr>
     <td align="center"><%=sDate%></td>
  </tr>
<!-- ==========================Data Table ================================== -->
  <tr>
   <td align="center">
    <table class="DataTable" align="center" >
      <tr>
        <th class="DataTable" >No.</th>
        <th class="DataTable" >Div</th>
        <th class="DataTable" >Division Name</th>
        <th class="DataTable" >Class</th>
        <th class="DataTable" >Vendor</th>
        <th class="DataTable" >Style</th>
        <th class="DataTable" >Color</th>
        <th class="DataTable" >Size</th>
        <th class="DataTable" >Creation<br>Date</th>
        <th class="DataTable" >Path</th>
      </tr>

      <%for(int i=0;  i < iNumOfDoc; i++){ %>
         <tr>
           <td class="DataTable"><%=i%></td>
           <td class="DataTable"><%=sMissDiv[i]%></td>
           <td class="DataTable"><%=sMissDivName[i]%></td>
           <td class="DataTable"><%=sMissCls[i]%></td>
           <td class="DataTable"><%=sMissVnd[i]%></td>
           <td class="DataTable"><%=sMissSty[i]%></td>
           <td class="DataTable"><%=sMissClr[i]%></td>
           <td class="DataTable"><%=sMissSiz[i]%></td>
           <td class="DataTable"><%=sMissCrD[i]%></td>
           <td class="DataTable"><%=sMissPath[i]%></td>
         </tr>
       <%}%>

     </table>
   </td>
  </tr>
 </table>
</BODY>
</HTML>
