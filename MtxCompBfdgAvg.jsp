<%@ page import="payrollreports.MtxCompBfdgAvg, rciutility.StoreSelect ,java.util.*, java.sql.*"%>
<%
String sInFrame = request.getParameter("InFrame");
if(sInFrame == null){sInFrame = "N";}

String sAppl = "PRHIST";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MtxCompBfdgAvg.jsp&APPL=" + sAppl);
}
else
{
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sYear + "|" + sMonth + "|" + sSelStr + "|" + sSelBdgGrp + "|" + sUser);
    MtxCompBfdgAvg bdgmtx = new MtxCompBfdgAvg();


   StoreSelect StrSelect = new StoreSelect();
   String sStr = StrSelect.getStrNum();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: #EfEf9f; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvBdgAvg { position:absolute;  background-attachment: scroll;
              border: MidnightBlue solid 2px; width:150; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; visibility:hidden;}

        tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; }

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script language="javascript">
var Str = [<%=sStr%>];
var Grp = new Array();
//==============================================================================
// iniitalize at loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvBdgAvg"]);
}
//==============================================================================
// set new Average wages
//==============================================================================
function setNewAvg(grp, grpnm, avg)
{
   var hdr = "Change Budget Average Wage";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblHrsEarn'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2 id='dvHrsEarn'>"
          + "<div id='dvCals' style='overflow:auto;'>"
            + popCalcFormulaAvgWage(grp, grpnm, avg)
          + "</div>"
       + "</td></tr>"
     + "</table>"

   document.all.dvBdgAvg.innerHTML=html
   document.all.dvBdgAvg.style.pixelLeft=document.documentElement.scrollLeft + 600;
   document.all.dvBdgAvg.style.pixelTop=document.documentElement.scrollTop + 70;
   document.all.dvBdgAvg.style.visibility="visible"
   document.all.Avg.focus();
   document.all.Avg.select();
}
//==============================================================================
// set panel
//==============================================================================
function popCalcFormulaAvgWage(grp, grpnm, avg)
{

    var panel = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
       + "<tr class='DataTable'>"
          + "<td class='DataTable2' nowrap>Budget Group: </td>"
          + "<td class='DataTable1' nowrap>" + grp + "</td>"
       + "</tr>"
       + "<tr class='DataTable'>"
          + "<td class='DataTable2' nowrap>Name: </td>"
          + "<td class='DataTable1' nowrap>" + grpnm + "</td>"
       + "</tr>"
       + "<tr class='DataTable'>"
          + "<td class='DataTable2' nowrap>Average Wage: </td>"
          + "<td class='DataTable' nowrap><input name='Avg' size=10 maxsize=10 value='" + avg + "'></td>"
       + "</tr>"
       + "<tr class='DataTable'>"
          + "<td class='DataTable2' colspan=2>"
             + "<button onClick='validAvg(&#34;" + grp + "&#34;);' class='Small'>Change</button> &nbsp; &nbsp;"
             + "<button onClick='hidePanel();' class='Small'>Close</button>"
          + "</td>"
       + "</tr>"
     + "</table>"

    return panel;
}
//==============================================================================
// validate new entries
//==============================================================================
function validAvg(grp)
{
   var error= false;
   var msg = "";

   var avg = document.all.Avg.value.trim();

   if(avg == ""){ error=true; msg += "\nPlease, enter average wage value." }
   else if(isNaN(avg)){ error=true; msg += "\nAverage wage must be numeric value." }
   else if(eval(avg) < 0){ error=true; msg += "\nAverage wage cannot be negative." }

   if(error){alert(msg)}
   else{ sbmAvg(grp, avg)}
}
//==============================================================================
// submit new entries
//==============================================================================
function sbmAvg(grp, avg)
{
   var url = "MtxBdgAvgSave.jsp?Grp=" + grp
    + "&Avg=" + avg
    + "&Action=UPD_COMP_AVG"

   window.frame1.location.href = url;
}
//==============================================================================
// Apply Matrix to selected store and stores
//==============================================================================
function setApplyMtx()
{
   var hdr = "Apply Matrix to Store/Month";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblHrsEarn'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2 id='dvHrsEarn'>"
            + popApplyMtx()
       + "</td></tr>"
     + "</table>"

   document.all.dvBdgAvg.innerHTML=html
   document.all.dvBdgAvg.style.width = 420;
   document.all.dvBdgAvg.style.pixelLeft = document.documentElement.scrollLeft + 400;
   document.all.dvBdgAvg.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvBdgAvg.style.visibility="visible";
}
//==============================================================================
// Apply Matrix to selected store and stores
//==============================================================================
function popApplyMtx()
{
    var panel = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"

    panel += "<tr class='DataTable3'>"
          + "<td class='DataTable'>"
             + "<a class='small' href='javascript: chkAllStr(&#34;ALL&#34;)'>All Store<a> &nbsp; &nbsp;"
             + "<a class='small' href='javascript: chkAllStr(&#34;CLEAR&#34;)'>Clear<a> &nbsp; &nbsp;"
          + "</td>"
       + "</tr>"

    panel += "<tr class='DataTable1'>"
       + "<td class='DataTable1'>"
       + "<table><tr class='DataTable1'>"

    for(var i=1; i < Str.length; i++)
    {
       if(i > 0 && i%10 ==0){ panel += "</tr><tr class='DataTable1'>"}
       panel += "<td class='DataTable1'><input type='checkbox' name='Str' value='" + Str[i] + "'>" + Str[i] + "</td>"
    }
    panel += "</table>"
    panel += "</td></tr>"

    panel += "<tr class='DataTable3'>"
          + "<td class='DataTable'>"
             + "<a class='small' href='javascript: chkAllGrp(&#34;ALL&#34;)'>All Budget Group<a> &nbsp; &nbsp;"
             + "<a class='small' href='javascript: chkAllGrp(&#34;CLEAR&#34;)'>Clear<a> &nbsp; &nbsp;"
          + "</td>"
       + "</tr>"

    panel += "<tr class='DataTable1'>"
       + "<td class='DataTable1'>"
       + "<table><tr class='DataTable1'>"

    for(var i=0; i < Grp.length; i++)
    {

       if(i > 0 && i%5 ==0){ panel += "</tr><tr class='DataTable1'>"}
       panel += "<td class='DataTable1'><input type='checkbox' name='Grp' value='" + Grp[i] + "'>" + Grp[i] + "</td>"
    }
    panel += "</table>"
    panel += "</td></tr>"

    panel += "<tr class='DataTable3'>"
          + "<td class='DataTable'>"
             + "<button onClick='validApply();' class='Small'>Change</button> &nbsp; &nbsp;"
             + "<button onClick='hidePanel();' class='Small'>Close</button>"
          + "</td>"
       + "</tr>"
     + "</table>"

    return panel;
}
//==============================================================================
// check/clear all stores
//==============================================================================
function chkAllStr(type)
{
   var chk = true;
   if(type=="CLEAR")
   {
      chk = false;
   }
   for(var i=0; i < document.all.Str.length; i++)
   {
       document.all.Str[i].checked=chk
   }
}
//==============================================================================
// check/clear all month
//==============================================================================
function chkAllGrp(type)
{
   var chk = true;
   if(type=="CLEAR")
   {
      chk = false;
   }
   for(var i=0; i < document.all.Grp.length; i++)
   {
       document.all.Grp[i].checked=chk
   }
}
//==============================================================================
// validate - apply matrix to store
//==============================================================================
function validApply()
{
   var error= false;
   var msg = "";

   var str = document.all.Str;
   var strval = new Array();
   var strsel = false;
   for(var i=0,j=0; i < str.length; i++)
   {
      if(str[i].checked){ strval[j++]=str[i].value; strsel = true; }
   }
   if(!strsel){ error=true; msg+="\nPlease, select at least 1 store." }

   var grp = document.all.Grp;
   var grpval = new Array();
   var grpsel = false;
   for(var i=0,j=0; i < grp.length; i++)
   {
      if(grp[i].checked){ grpval[j++]=grp[i].value; grpsel = true; }
   }
   if(!grpsel){ error=true; msg+="\nPlease, select at least 1 group." }


   if(error){alert(msg)}
   else{ sbmApplyMtx(strval, grpval)}
}
//==============================================================================
// submit - apply matrix to store
//==============================================================================
function sbmApplyMtx(str, grp)
{
   var url = "MtxBdgAvgSave.jsp?Action=APPLY_CMP_MTX"
   for(var i=0; i < str.length; i++)  {  url += "&Str=" + str[i]; }
   for(var i=0; i < grp.length; i++)  {  url += "&Grp=" + grp[i]; }

   //alert(url)
   window.frame1.location.href = url;

   hidePanel();
}
//==============================================================================
// submit new entries
//==============================================================================
function restart()
{	 
	//window.location.reload();
	window.parent.location = document.referrer;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvBdgAvg.innerHTML = " ";
   document.all.dvBdgAvg.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<body id="bdCmp" onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvBdgAvg" class="dvBdgAvg"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
       <td ALIGN="center" VALIGN="TOP" width="10%">
         <b>Retail Concepts Inc.
         <br>Company Budget Average Wage Matrix
         </b>
         <br>
         <%if(!sInFrame.equals("Y")) {%>
            <a href="../" class="small"><font color="red">Home</font></a>&#62;
            <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;

            <a href="MtxStrBfdgAvg.jsp" class="small">Store Budget Matrix</a>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
         <%}%>
         <a href="javascript: setApplyMtx()" class="small">Apply Matrix</a>
       </td>
     </tr>

     <tr bgColor="ivory">
       <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable">Budget Group</th>
           <th class="DataTable">Name</th>
           <th class="DataTable">Average Wage</th>
         </tr>
     <!------------------------------- Data Detail --------------------------------->
      <%while(bdgmtx.getNext()){
         bdgmtx.setBdgAvg();
         String sGrp = bdgmtx.getGrp();
         String sGrpNm = bdgmtx.getGrpNm();
         String sGrpType = bdgmtx.getGrpType();
         String sAvg = bdgmtx.getAvg();
      %>
         <tr class="DataTable">
           <td class="DataTable1"><a href="javascript: setNewAvg('<%=sGrp%>', '<%=sGrpNm%>', '<%=sAvg%>')"><%=sGrp%></a></td>
           <td class="DataTable1"><%=sGrpNm%></td>
           <td class="DataTable2"><%=sAvg%></td>
         </tr>
         <script>Grp[Grp.length]="<%=sGrp%>"</script>
      <%}%>
      <!------------------------ End Details ---------------------------------->
   </table>
   </td>
   </tr>
    <!----------------------- end of table ---------------------------------->

  </table>
  <div id="dvElapse" style="font-size:8px"></div>
 </body>

</html>

<%
  bdgmtx.disconnect();
  bdgmtx = null;
  }
%>
