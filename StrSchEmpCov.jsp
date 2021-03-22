<%@ page import="payrollreports.StrSchEmpCov, java.util.*"%>
<%
    String sStore = request.getParameter("Store");
    String sStoreNm = request.getParameter("StoreNm");
    String sWkend = request.getParameter("Wkend");
    String sSlsMaxLvl = request.getParameter("SlsMaxLvl");
    String sSlsMinLvl = request.getParameter("SlsMinLvl");
    String sGroup = request.getParameter("Group");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrSchEmpCov.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    StrSchEmpCov empcov = new StrSchEmpCov(sStore, sWkend, sSlsMaxLvl, sSlsMinLvl, sGroup, sUser);
    String sMonBeg = empcov.getMonBeg();

    String [] sColHdg1 = new String[]{"9", "10", "11", "12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"};
    String [] sColHdg2 = new String[]{"AM", "AM", "AM", "PM", "PM", "PM", "PM", "PM", "PM", "PM", "PM", "PM", "PM", "PM"};
%>
<HTML>
<HEAD>
<title>Emp_Cov_Analysis</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>
        body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: CornSilk; text-align:center; font-size:8px }
        tr.DataTable2 { background: seashell; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.Skip1 {font-size:1px }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }


        div.dvSelect { position:absolute; visibility: visible; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        tr.Prompt { background-color:#F0F0F0; font-size:10px; }
        tr.Prompt1{ background-color:LemonChiffon; font-size:10px; }
        tr.Prompt2{ background-color:white; font-size:10px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1{ text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2{ text-align:right; font-family:Arial; font-size:10px; }
</style>


<script name="javascript1.2">
var sHrCellAll = true;
var Store = new Array();
var StrName = new Array();
var WkSls = new Array();
var WkNumEmp = new Array();
var WkNumHrs = new Array();
var WkSlsHr = new Array();
var WkNumNoCov = new Array();
var WkNumBoth = new Array();
var WkNumMax = new Array();
var WkNumMin = new Array();
var NumOfStr = 0;

var RowColor = new Array();

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setHrsCellColor();
   setRegHrsCellVisibility();
   setStrTotal();
}
//==============================================================================
// set Hour cell colors
//==============================================================================
function setHrsCellColor()
{
   var hrsmax = document.all.tdHrs1;
   var hrsmin = document.all.tdHrs2;
   var zerocov = document.all.tdHrs3;

   if(hrsmax != null)
   {
      for(var i=0; i < hrsmax.length; i++) { hrsmax[i].style.backgroundColor = "pink"; }
   }

   if(hrsmin != null)
   {
     for(var i=0; i < hrsmin.length; i++) { hrsmin[i].style.backgroundColor = "lightgreen"; }
   }
   if(zerocov != null)
   {
     for(var i=0; i < zerocov.length; i++) { zerocov[i].style.backgroundColor = "#ffe87c"; }
   }

}
//==============================================================================
// set Hour cell with no violation visbile or unvisible
//==============================================================================
function setRegHrsCellVisibility()
{
   sHrCellAll = !sHrCellAll;
   var hrsreg = document.all.tdHrs;
   var color;
   if(!sHrCellAll) { color = "#E7E7E7"; }
   else { color = "black"; }

   if(hrsreg != null)
   {
      for(var i=0; i < hrsreg.length; i++) { hrsreg[i].style.color = color; }
   }
}

//==============================================================================
// set Hour cell colors
//==============================================================================
function setStrTotal()
{
   var html = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
     + "<th class='DataTable'>Store</th>"
     + "<th class='DataTable'>Daily<br>Sales</th>"
     + "<th class='DataTable'>Num<br>Employee</th>"
     + "<th class='DataTable'>Num<br>Hrs</th>"
     + "<th class='DataTable'>Daily<br>Sales<br>per Hour</th>"
     + "<th class='DataTable'>No<br>Cov</th>"
     + "<th class='DataTable'># of<br>Time<br>Slots</th>"
     + "<th class='DataTable'>Exceed<br>Threshold</th>"
     + "<th class='DataTable'>Less<br>Min<br>Level</th>"
     + "</tr>"

     for(var i=0; i < NumOfStr; i++)
     {
       html += "<tr class='Prompt2'>"
         + "<td class='DataTable1'>" + Store[i] + " - " + StrName[i] + "</td>"
         + "<td class='DataTable2'>" + WkSls[i] + "</td>"
         + "<td class='DataTable2'>" + WkNumEmp[i] + "</td>"
         + "<td class='DataTable2'>" + WkNumHrs[i] + "</td>"
         + "<td class='DataTable2'>" + WkSlsHr[i] + "</td>"
         + "<td class='DataTable2'>" + WkNumNoCov[i] + "</td>"
         + "<td class='DataTable2'>" + WkNumBoth[i] + "</td>"
         + "<td class='DataTable2'>" + WkNumMax[i] + "</td>"
         + "<td class='DataTable2'>" + WkNumMin[i] + "</td>"
       + "</tr>"
     }

   html += "</table>"

   document.all.dvSelect.innerHTML = html;
}

//==============================================================================
// set Hour cell colors
//==============================================================================
function setHiLiRow(row, hili)
{
   var cell = row.getElementsByTagName("td");
   for(var i=0; i < cell.length; i++)
   {
      if(hili){ RowColor[i] = cell[i].style.color; cell[i].style.color = "red" }
      else { cell[i].style.color = RowColor[i]; }
   }

}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Store Scheduled Employee Coverage Analysis
        <br>Store: <%=sStoreNm%>
        <br>Weekend: <%=sWkend%>
        <br>Coverage Threhshold: $<%=sSlsMaxLvl%> / Per Hour
        <br>Coverage Minimum Level: $<%=sSlsMinLvl%> / Per Hour
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="StrSchEmpCovSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <br>
        <!-- =================== Store/Wk total  =========================== -->
        <table border=1 cellPadding="0" cellSpacing="0" id="tbDetail">
          <tr><th class="DataTable">Store Totals</th></tr>
          <tr><td><div id="dvSelect"></div></td></tr>
        </table>
        <br><br>
<!-- =================== Weekly Schedule Analysis =========================== -->
       <table border=1 bgcolor="#E7E7E7" cellPadding="0" cellSpacing="0" id="tbDetail">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2>Store</th>
             <th class="DataTable" rowspan=2>Day of Week</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" colspan="14">Hours &nbsp; &nbsp;
                <a href="javascript:setRegHrsCellVisibility()">Show All/Invisible</a>
             </th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" rowspan=2>Daily<br>Sales</th>
             <th class="DataTable" rowspan=2>Num<br>Employee</th>
             <th class="DataTable" rowspan=2>Num<br>Hrs</th>
             <th class="DataTable" rowspan=2>Daily<br>Sales<br>per Hour</th>
             <th class="DataTable" rowspan=2>No<br>Cov</th>
             <th class="DataTable" rowspan=2># of<br>Time<br>Slots</th>
             <th class="DataTable" rowspan=2>Exceed<br>Threshold</th>
             <th class="DataTable" rowspan=2>Less<br>Min<br>Level</th>
          </tr>
          <tr class="DataTable">
            <%for(int j=0; j < sColHdg1.length; j++){%><th class="DataTable"><%=sColHdg1[j]%><br><%=sColHdg2[j]%></th><%}%>
          </tr>
    <!-- ============================ Details =========================== -->
    <%while(empcov.getNext()){%>
    <%
         empcov.getSchedCov();
         int iNumOfDay = empcov.getNumOfDay();
         String [] sStr = empcov.getStr();
         String [] sStrName = empcov.getStrName();
         String [] sDay = empcov.getDay();
         String [] sDlySls = empcov.getDlySls();
         boolean [] bNoDayCov = empcov.getNoDayCov();

         boolean [][] bUncovMax = empcov.getUncovMax();
         boolean [][] bUncovMin = empcov.getUncovMin();
         boolean [][] bZeroCov = empcov.getZeroCov();
         String [][] sUncovMax = empcov.getsUncovMax();
         String [][] sUncovMin = empcov.getsUncovMin();
         String [][] sZeroCov = empcov.getsZeroCov();
         String [][] sUncColor = empcov.getUncColor();

         String [][] sEmpHr = empcov.getEmpHr();
         String [][] sSlsHr = empcov.getSlsHr();
         String [][] sSlsEmp = empcov.getSlsEmp();
         int [] iNumMax = empcov.getNumMax();
         int [] iNumMin = empcov.getNumMin();
         int [] iNumBoth = empcov.getNumBoth();
         int [] iNumNoCov = empcov.getNumNoCov();
         String [] sDlyNumEmp = empcov.getDlyNumEmp();
         String [] sDlyNumHrs = empcov.getDlyNumHrs();
         String [] sDlySlsHr = empcov.getDlySlsHr();
    %>
      <%if(iNumOfDay > 0){%>
         <tr class="DataTable" onMouseOver="setHiLiRow(this, true)" onMouseOut="setHiLiRow(this, false)">
            <td class="DataTable" rowspan="<%=(iNumOfDay * 3 + 2)%>"><%=sStr[0]%><br>
               <a href="SchedbyWeek.jsp?STORE=<%=sStr[0]%>&STRNAME=<%=sStrName[0]%>&MONBEG=<%=sMonBeg%>&WEEKEND=<%=sWkend%>" target="_Blank">Schedule</a>
            </td>

         <%for(int i=0; i < iNumOfDay; i++){%>
            <td class="DataTable" rowspan="3"><%=sDay[i]%></td>

            <%if(!bNoDayCov[i]){%>
               <td class="DataTable1" nowrap>Emp/Hr</td>
               <%for(int j=2; j < 16; j++){%><td id="tdHrs<%=sUncColor[i][j]%>" class="DataTable2">&nbsp;<%=sEmpHr[i][j]%></td><%}%>
               <th class="DataTable" rowspan=3>&nbsp;</th>
               <td class="DataTable2" rowspan=3>$<%=sDlySls[i]%></td>
               <td class="DataTable2" rowspan=3><%=sDlyNumEmp[i]%></td>
               <td class="DataTable2" rowspan=3><%=sDlyNumHrs[i]%></td>
               <td class="DataTable2" rowspan=3>$<%=sDlySlsHr[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumNoCov[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumBoth[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumMax[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumMin[i]%></td>


               <tr class="DataTable" onMouseOver="setHiLiRow(this, true)" onMouseOut="setHiLiRow(this, false)">
                 <td class="DataTable1" nowrap>Sls/Hr $</td>
                 <%for(int j=2; j < 16; j++){%><td id="tdHrs<%=sUncColor[i][j]%>" class="DataTable2">&nbsp;<%=sSlsHr[i][j]%></td><%}%>

               <tr class="DataTable" onMouseOver="setHiLiRow(this, true)" onMouseOut="setHiLiRow(this, false)">
                 <td class="DataTable1" nowrap>Sls/Emp/Hr $</td>
                 <%for(int j=2; j < 16; j++){%><td id="tdHrs<%=sUncColor[i][j]%>" class="DataTable2">&nbsp;<%=sSlsEmp[i][j]%></td><%}%>

               <tr class="DataTable" onMouseOver="setHiLiRow(this, true)" onMouseOut="setHiLiRow(this, false)">
            <%}
              // day with now coverage
              else {%>
               <td class="DataTable1" rowspan=3>No Coverage</td><td class="Skip1" colspan=14></td>
               <th class="DataTable" rowspan=3>&nbsp;</th>
               <td class="DataTable2" rowspan=3><%=sDlySls[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumNoCov[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumBoth[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumMax[i]%></td>
               <td class="DataTable2" rowspan=3><%=iNumMin[i]%></td>


               <tr class="DataTable" onMouseOver="setHiLiRow(this, true)" onMouseOut="setHiLiRow(this, false)"><td class="Skip1" colspan=14></td>
               <tr class="DataTable" onMouseOver="setHiLiRow(this, true)" onMouseOut="setHiLiRow(this, false)"><td class="Skip1" colspan=14></td>
               <tr class="DataTable" onMouseOver="setHiLiRow(this, true)" onMouseOut="setHiLiRow(this, false)">
            <%}%>
         <%}%>
       <%}%>
           <!-- ============= Total ======================================== -->
           <%
             // Store Weekly Totals
             empcov.getWeeklySchedCov();
             String sWkSls = empcov.getWkSls();
             String sWkNumEmp = empcov.getWkNumEmp();
             String sWkNumHrs = empcov.getWkNumHrs();
             String sWkSlsHr = empcov.getWkSlsHr();
             int iWkNumMax = empcov.getWkNumMax();
             int iWkNumMin = empcov.getWkNumMin();
             int iWkNumBoth = empcov.getWkNumBoth();
             int iWkNumNoCov = empcov.getWkNumNoCov();
           %>
           <tr class="DataTable2">
             <td class="DataTable" colspan=16>Total</td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable2">$<%=sWkSls%></td>
             <td class="DataTable2"><%=sWkNumEmp%></td>
             <td class="DataTable2"><%=sWkNumHrs%></td>
             <td class="DataTable2">$<%=sWkSlsHr%></td>
             <td class="DataTable2"><%=iWkNumNoCov%></td>
             <td class="DataTable2"><%=iWkNumBoth%></td>
             <td class="DataTable2"><%=iWkNumMax%></td>
             <td class="DataTable2"><%=iWkNumMin%></td>
           </tr>

           <script>
               Store[NumOfStr] = "<%=sStr[0]%>"; StrName[NumOfStr] = "<%=sStrName[0]%>"; WkSls[NumOfStr] = "<%=sWkSls%>"; WkNumEmp[NumOfStr] = "<%=sWkNumEmp%>";
               WkNumHrs[NumOfStr] = "<%=sWkNumHrs%>"; WkSlsHr[NumOfStr] = "<%=sWkSlsHr%>"; WkNumNoCov[NumOfStr] = "<%=iWkNumNoCov%>";
               WkNumBoth[NumOfStr] = "<%=iWkNumBoth%>"; WkNumMax[NumOfStr] = "<%=iWkNumMax%>"; WkNumMin[NumOfStr++] = "<%=iWkNumMin%>";
         </script>

           <!-- Divider -->
           <tr class="DataTable1">
             <td class="Skip1" colspan=3>&nbsp;</td>
             <%for(int j=0; j < sColHdg1.length; j++){%><td><%=sColHdg1[j]%></td><%}%>
             <td>&nbsp;</td><td>Dly Sls</td><td>Num Emp</td><td># Hrs</td>
             <td>Sls/Hr</td><td>No Cov</td><td># T S</td><td># Ex Thrs</td><td>Min Lvl</td>
           </tr>
    <%}%>
    <!-- ================================================================== -->
     </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   empcov.disconnect();
   empcov = null;
   }
%>