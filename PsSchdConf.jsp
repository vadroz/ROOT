<%@ page import="rciutility.StoreSelect, payrollreports.PsSchdConf, java.util.*"%>
<%
   String sSelStr = request.getParameter("Store");
   String sWkend = request.getParameter("Wkend");
   if (sSelStr == null) sSelStr = "ALL";

   StoreSelect StrSelect = null;
   String sStrLst = null;
   String sStrLstName = null;
   String sUser = " ";


  //-------------- Security ---------------------
  String sStrLstAllowed = null;
  String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BasicEmp.jsp&APPL=" + sAppl);
   }
   else {
     sUser = session.getAttribute("USER").toString();
     sStrLstAllowed = session.getAttribute("STORE").toString();

  // -------------- End Security -----------------

   StrSelect = new StoreSelect(4);
   sStrLst = StrSelect.getStrNum();
   sStrLstName = StrSelect.getStrName();

   PsSchdConf schconf = new PsSchdConf(sSelStr,sWkend, "vrozen");
%>
<html>
<head>

<style>
 body {background:ivory;}
 a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
 a.lnksel:link { color:red;font-size:10px } a.lnksel:visited { color:red;font-size:10px } a.lnksel:hover { color:red;font-size:10px }


 table.DataTable { background:#FFE4C4;text-align:center;}
 th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

 tr.DataTable0 { background: #e7e7e7; font-family:Arial; font-size:12px }
 tr.DataTable1 { background: white; font-family:Arial; font-size:12px }

 td.DataTable  { padding-top:3px; padding-bottom:3px; text-align:left }
 td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:center }
 td.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:right}
 td.DataTable3 { cursor:hand; padding-top:3px; padding-bottom:3px; text-align:center }

 input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
 select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
 button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
 textarea.small{ text-align:left; font-family:Arial; font-size:10px;}

 td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
 td.Grid1 { cursor: hand; text-align:center; font-family:Arial; font-size:10px;}
 td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}
 td.Grid3 { cursor: hand; text-align:right; font-family:Arial; font-size:10px;}

 td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
 td.Menu1  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:12px; }
 td.Menu2  {text-align:right; font-family:Arial; font-size:12px; }
 td.Menu3  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:10px; }

 div.Menu  {position:absolute;visibility:hidden; background-attachment: scroll;
            border: black solid 3px; width:150px;background-color:Azure; z-index:10;
            text-align:center;}
 div.SetMenu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
 .Small { font-size:10px }
</style>

<SCRIPT language="JavaScript">
//=========================== Global variables =================================
var StrLst = [<%=sStrLst%>];
var StrLstName = [<%=sStrLstName%>];
//======================== End Global variables ================================
//==============================================================================
// populate selection fields on page load
function bodyLoad()
{
   doStrSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.all;

    for (var i=0; i < StrLst.length; i++)
    {
      df.Store.options[i] = new Option(StrLst[i] + " - " + StrLstName[i],StrLst[i]);
    }
}
//==============================================================================
// show other report selection
//==============================================================================
function newStrWkSel()
{
   var str = document.all.Store.options[document.all.Store.selectedIndex].value;
   var url = "PsSchdConf.jsp?Store=" + str
     + "&Wkend=<%=sWkend%>"
   window.location.href=url;
}
//==============================================================================
// deleted Conflict entries
//==============================================================================
function dltConfRec(rec)
{
   // get next
   rec++;

   var conf = document.all.DltRec;
   var url = "PsSchdConfDlt.jsp?";

   for(var i=rec, j=0; i < conf.length; i++)
   {
      if(conf[i].checked)
      {
         url += "Rec=" + i + "&Rrn=" + conf[i].value
         j++;
         conf[i].checked = false;
         break;
      }
   }

   if(j > 0){ window.frame1.location.href=url; }
   else{ window.location.reload(); }
}

</SCRIPT>
</head>
<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
 <div id="menu"></div>
<!-------------------------------------------------------------------->
   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Weekly Schedule Conflicts
      <br>Store: <%=sSelStr%> &nbsp; Weekending date: <%=sWkend%>
      <br>

      </font></b>

      <br>Store: <SELECT name="Store" class="Small"></SELECT>&nbsp;&nbsp;&nbsp;
          <button name="Go" onclick="javascript:newStrWkSel();">Go</button>

      <p><a class="lnksel" href="../">Home</a> &#62;
         <a class="lnksel" href="PsSchdConfSel.jsp">Selection</a>


<!------------- start of dollars table ------------------------>
      <table border=1 class="DataTable" align="center" cellPadding="0" cellSpacing="0">
             <tr>
                <th class="DataTable">Store</th>
                <th class="DataTable">Name</th>
                <th class="DataTable">&nbsp;&nbsp;</th>
                <th class="DataTable">Date</th>
                <th class="DataTable">Group</th>
                <th class="DataTable">Conflicting<br>Schedule Time Entries</th>
                <th class="DataTable">&nbsp;&nbsp;</th>
                <th class="DataTable">RRN</th>
                <th class="DataTable">&nbsp;&nbsp;</th>
                <th class="DataTable">Delete</th>
             </tr>
<!-- ==================== Details ===========================================-->
             <%
             int iLine = 0;
             while(schconf.getNext())
             {
                schconf.setSchConf();
                String sRrn1 = schconf.getRrn1();
                String sRrn2 = schconf.getRrn2();
                String sStr = schconf.getStr();
                String sGrp1 = schconf.getGrp1();
                String sGrp2 = schconf.getGrp2();
                String sSchDt = schconf.getSchDt();
                String sBegTm1 = schconf.getBegTm1();
                String sEndTm1 = schconf.getEndTm1();
                String sBegTm2 = schconf.getBegTm2();
                String sEndTm2 = schconf.getEndTm2();
                String sName = schconf.getName();
                String sGrpNm1 = schconf.getGrpNm1();
                String sGrpNm2 = schconf.getGrpNm2();
             %>
                <tr class="DataTable<%=iLine%>">
                   <td class="DataTable" rowspan=2><%=sStr%></td>
                   <td class="DataTable" rowspan=2><%=sName%></td>
                   <th class="DataTable"rowspan=2>&nbsp;</th>
                   <td class="DataTable" rowspan=2><%=sSchDt%></td>
                   <td class="DataTable"><%=sGrp1%> - <%=sGrpNm1%></td>
                   <td class="DataTable"><%=sBegTm1%> - <%=sEndTm1%></td>
                   <th class="DataTable"rowspan=2>
                      &nbsp;
                       <%if(!sBegTm2.equals(sEndTm1)){%><img src="red_flag1.png" width="15px" height="15px"><%}
                       else{%><img src="eye.png" width="15px" height="15px"><%}%>
                      &nbsp;
                   </th>
                   <td class="DataTable"><%=sRrn1%></td>
                   <th class="DataTable"rowspan=2>&nbsp;</th>
                   <td class="DataTable"><input type="checkbox" name="DltRec" value="<%=sRrn1%>"></td>
                 </tr>
                 <tr class="DataTable<%=iLine%>">
                   <td class="DataTable"><%=sGrp2%> - <%=sGrpNm2%></td>
                   <td class="DataTable"><%=sBegTm2%> - <%=sEndTm2%></td>
                   <td class="DataTable"><%=sRrn2%></td>
                   <td class="DataTable"><input type="checkbox" name="DltRec" value="<%=sRrn2%>"></td>
                </tr>
                <%if(iLine==0){iLine = 1;} else { iLine = 0; }%>
             <%}%>
       </table>
        <button onclick="dltConfRec(-1);">Delete Conflicted Entries</button>
       </td>
    </tr>
  </table>
</body>
</html>

<%
schconf.disconnect();
}%>