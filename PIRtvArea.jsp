<%@ page import="inventoryreports.PiRtvArea, java.util.*"%>
<%
   String sClass = request.getParameter("CLASS");
   String sVendor = request.getParameter("VENDOR");
   String sStyle = request.getParameter("STYLE");
   String sColor = request.getParameter("COLOR");
   String sSize = request.getParameter("SIZE");
   String sStore = request.getParameter("STORE");
   String sPiYearMo = request.getParameter("PICal");

   if(sClass==null) sClass=" ";
   if(sVendor==null) sVendor=" ";
   if(sStyle==null) sStyle=" ";
   if(sColor==null) sColor="ALL";
   if(sSize==null) sSize="ALL";
   if(sStore==null) sStore="ALL";

   //System.out.println(sClass + "|" + sVendor + "|" + sStyle + "|" + sColor + "|" + sSize
   //   + "|" + sStore + "|" + sPiYearMo.substring(0, 4) + "|" + sPiYearMo.substring(4));
   PiRtvArea rtvArea = new PiRtvArea(sClass, sVendor, sStyle, sColor, sSize, sStore,
                         sPiYearMo.substring(0, 4), sPiYearMo.substring(4));
   int iNumOfArea = rtvArea.getNumOfArea();
   String [] sArea = rtvArea.getArea();
   String [] sQty = rtvArea.getQty();
   String [] sLoc = rtvArea.getLoc();
   String [] sBin = rtvArea.getBin();
   rtvArea.disconnect();
%>
<html>
<head>
<style>
 body {background:ivory;text-align:center;}
 table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
function bodyload()
{
  window.focus();
  document.all.close.focus();
}
</SCRIPT>
<body onload="bodyload()">
<table class="DataTable" cellPadding="0" cellSpacing="0">

<!------------------------------- Data Detail --------------------------------->
           <tr class="DataTable">
             <th class="DataTable">Area<br>Location<br>Bin</th>
           <%for(int i=0; i < iNumOfArea; i++) {%>
                <td class="DataTable" nowrap><a href="PIWIRep.jsp?STORE=<%=sStore%>&AREA=<%=sArea[i]%>&PICal=<%=sPiYearMo%>" target="_blank"><%=sArea[i]%></a>
                <br><%if(sLoc[i].length() > 0){%><%=sLoc[i].substring(0,2)%>-<%=sLoc[i].substring(2,4)%>-<%=sLoc[i].substring(4)%><%} else {%>&nbsp;<%}%>
                <br><%=sBin[i]%>
                </td>
           <%}%>
        </tr>
        <tr class="DataTable">
             <th class="DataTable">Qty</th>
           <%for(int i=0; i < iNumOfArea; i++) {%>
                <td class="DataTable" nowrap><%=sQty[i]%></td>
           <%}%>
        </tr>
      </table>
      <!----------------------- end of table ------------------------>
<p align=center>
  <button name="close" onclick="window.close()">Close</button>

</body>
</html>


