<%

%>
<SCRIPT language="JavaScript1.2">
window.frame5.location.href="Div1Challenge.jsp?Sort=VAR";

// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function showThermometer(html)
{
   document.all.tdThermometer.innerHTML = html;
}
// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function showDiv1Sls(html)
{
   document.all.tdTyLyVar.innerHTML = html;
}
// ------------------------------------------------------
// set required Sales increase
// ------------------------------------------------------
function showSlsIncrease(html)
{
   document.all.tdSlsIncr.innerHTML = html;
}
// ------------------------------------------------------
// set Sales data retreiving date
// ------------------------------------------------------
function showAsOfDate(html)
{
   window.frame5.close();
   document.all.spAsOfDate.innerHTML = html;
}
</SCRIPT>
<body>
<!-- ======================================================================= -->
<iframe  id="frame5"  src=""  frameborder=1 height="200" width="800"></iframe>
<!-- ======================================================================= -->
<br>14 Million Dollars challenge

<table border= 1>

   <tr>
      <td id="tdFlash" valign="top" rowspan=2 nowrap>&nbsp;</td>
      <td  id="tdSlsIncr" valign="top" colspan=2>&nbsp;</td>
   </tr>


   <tr>
     <td  id="tdTyLyVar" valign="top">&nbsp;</td>
     <td style="vertical-align:top" id="tdThermometer">&nbsp;</td>
   </tr>
</table>
</body>



