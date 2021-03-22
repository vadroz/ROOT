<%@ page import="rciutility.RunSQLStmt, java.text.*, java.sql.*, java.util.*"%>
<%
   String sSelVen = request.getParameter("Ven");
   String sSelDiv = request.getParameter("Div");

   if(sSelVen == null){ sSelVen = "ALL"; }
   if(sSelDiv == null){ sSelDiv = "ALL"; }

   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat sdfMDY = new SimpleDateFormat("MM/dd/yyyy");

   String sPrepStmt = "select hono, hadi, hven, vnam, hdiv"
      + " from iptsfil.ippohdr"
      + " inner join iptsfil.IpMrVen on hven=vven"
      + " where hcdi >= CURRENT DATE"
      + " and hsts <> 'C'";

   if(!sSelVen.equals("ALL")) { sPrepStmt += " and hven = " + sSelVen; }
   if(!sSelDiv.equals("ALL")) { sPrepStmt += " and hdiv = " + sSelDiv; }

   sPrepStmt += " order by hadi, hven, hdiv";
   //System.out.println(sPrepStmt);

   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);

   ResultSet rs = runsql.runQuery();

   int iNumOfRec = 0;

   String sPoNum = "";
   String sAntDlvDt = "";
   String sVen = "";
   String sVenName = "";

%>

<script name="javascript1.2">

function bodyload()
{
   var hl1 = document.all.thHdr1.offsetWidth;
   var hl2 = document.all.thHdr2.offsetWidth;
   var hl3 = document.all.thHdr3.offsetWidth;

   var cl1 = document.all.tdCol1[0].offsetWidth;
   var cl2 = document.all.tdCol2[0].offsetWidth;
   var cl3 = document.all.tdCol3[0].offsetWidth;

   if(hl1 > cl1){ document.all.tdCol1[0].style.width  = hl1; }
   else if(hl1 < cl1){ document.all.thHdr1.style.width = cl1; }

   if(hl2 > cl2){ document.all.tdCol2[0].style.width  = hl2; }
   else if(hl2 < cl2){ document.all.thHdr2.style.width = cl2; }


   if(hl3 > cl3){ document.all.tdCol3[0].style.width  = hl3; }
   else if(hl3 < cl3){ document.all.thHdr3.style.width = cl3; }
}
</script>

<STYLE>
DIV.scrollTableALL{
 clear: both;
 overflow: AUTO;
 width: 580px;
 height: 300px;
 POSITION: relative;
 color:black;
}
DIV.scrollTableALL thead td, tfoot td {
 background-color: #1B82E6;
 Z-INDEX: 60;
 position:relative;
}
DIV.scrollTableALL table{
 border:0px;
 cellspacing:1px;
 cellpading:1px;
 TEXT-ALIGN: center;
}

DIV.scrollTableALL thead td{
 TOP: expression(this.offsetParent.scrollTop -2);
}
DIV.scrollTableALL tfoot td{
 TOP: expression(this.offsetParent.clientHeight + this.offsetParent.scrollTop - (this.offsetParent.scrollHeight -2));
}

tr.odd{
 background-color:#FFFFFF;
}
tr.even{
 background-color:#D2E9FF;
}

th.fixedLeftALL, td.fixedLeftALL {
 z-index: 60;
 border-right: 1px solid silver;
 border-left: 1px solid silver;
 LEFT: expression(this.offsetParent.scrollLeft -1);
 POSITION: relative;
}
th.fixedRightALL, td.fixedRightALL {
 z-index: 60;
 border-right: 1px solid silver;
 border-left: 1px solid silver;
 LEFT: expression(this.offsetParent.clientWidth - this.offsetParent.scrollWidth + this.offsetParent.scrollLeft +1);
 POSITION: relative;
}


html>body div.scrollTableALL {
overflow: hidden;
}
html>body tbody.scrollBodyALL {
height: 200px;
overflow: auto;
}
</style>


<body onload="bodyload()" >
<!--table border=1>
<thead>
 <tr>
   <th id="thHdr1">P.O.Number</th>
   <th id="thHdr2">Vendor</th>
   <th id="thHdr3">Vendor Name</th>
 </tr>
 </thead>
</table -->

<!--div style="overflow: auto;border: none; width:300; height:220;
            background-color:white; z-index:10; text-align:center; font-size:10px"-->

<div class="scrollTableALL" id = "scrollTableALL">


<table border=1 id="TableALL" width="100%">

<thead  class="scrollHeadALL" id="scrollHeadALL">

 <tr>
   <td class="fixedLeftALL" style="z-index:80;" id="thHdr1">P.O.Number</td>
   <td id="thHdr2">Vendor</td>
   <td id="thHdr3">Vendor Name</td>
 </tr>
 </thead>

<tbody style="overflow: auto">
<%while(runsql.readNextRecord()){%>
<%
      sPoNum = runsql.getData("hono").trim();
      sVen = runsql.getData("hven").trim();

      String sv = runsql.getData("vnam").trim();
      if(sv.indexOf("#") > 0){ sv = sv.substring(0, sv.indexOf("#")); }
      sVenName = sv;
%>

    <tr style="font-size:16px">
      <td id="tdCol1"><%=sPoNum%></td>
      <td id="tdCol2"><%=sVen%></td>
      <td id="tdCol3"><%=sVenName%></td>
<%}%>
   </tbody>
  </table>
</div>
<%
   runsql.disconnect();
   runsql = null;
%>

</body>





