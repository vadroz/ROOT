<%@ page import=" operatorpanel.GetSysSts"%>
<% GetSysSts ss = new GetSysSts();
   ss.getSystem();
   String [] sStatistics = ss.getSysStatistics();
   String [] sPrmName = ss.getSysStsNames();
   ss.disconnect();
%>
<html>
 <head>
           <SCRIPT language="JavaScript">
		document.write("<style>body {background:ivory;}");
                document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
                document.write("table.DataTable { background:#FFE4C4;border: darkred solid 1px;text-align:center;}");
                document.write("th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }");
                document.write("td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }");
		document.write("td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
                document.write("td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }");
		document.write("</style>");
           </SCRIPT>
 </head>
 <body>
      <div id="tooltip2" style="position:absolute;visibility:hidden;
           border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
      <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
      </div>
  <table>
   <td ALIGN="center" VALIGN="TOP">
      Operator's Panel
      <b><br>Display System Status</b>
   </td></tr>

   <tr><td ALIGN="center" VALIGN="TOP">
      <table class="DataTable" wide="100%">
      <%for (int i=0; i< sStatistics.length; i++){ %>
        <tr><td class="DataTable1" width="80%"><%=sPrmName[i]%></td>
            <td class="DataTable2"><%=sStatistics[i]%></td></tr>
      <%}%>
      </table>
    </td></tr>
    <td ALIGN="center" VALIGN="TOP">
       <button name="Close" value="Close" onClick="javascript:window.close();">Close</button>
       <button name="Refresh" value="Refresh" onClick="javascript:history.go()">Refresh</button>
     </td></tr>
  </table>
 </body>
<SCRIPT>
function hidetip2(){
    document.all.tooltip2.style.visibility="hidden"
}
        </SCRIPT>
      </html>
