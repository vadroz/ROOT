<%@ page import="patiosales.PatioSalesFYAnalysis, java.util.*;"%>
<%
    String sYear = request.getParameter("Year");
    String sMonth = request.getParameter("Mon");
    String sWeek = request.getParameter("Week");
    String sType = request.getParameter("Type");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PatioSalesFYAnalysis.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PatioSalesFYAnalysis pfslsanl = new PatioSalesFYAnalysis(sYear, sMonth, sWeek, sType, sUser);
    int iNumOfPer = pfslsanl.getNumOfPer();
    String [] sPer = pfslsanl.getPer();

    String [] sMon = new String[]{"April", "May", "June", "July", "August", "September",
       "October", "November", "December", "Junuary", "February", "March"};
    String [] sWk = new String[]{"Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6", };
    String [] sDay = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    String [] sPeriod = null;
    if (sMonth.equals("ALL")){ sPeriod = sMon; }
    else if (sWeek.equals("ALL")){ sPeriod = sWk; }
    else { sPeriod = sDay; }
%>
<HTML>
<HEAD>
<title>Patio Sales</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:center; font-size:11px;}
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:10px }
        th.DataTable4 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:10px }

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background: #b0b0b0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.3">
//------------------------------------------------------------------------------
var Year = "<%=sYear%>";
var Month = "<%=sMonth%>";
var Week = "<%=sWeek%>";
var Type = "<%=sType%>"
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// drill down to month
//==============================================================================
function drillDown(per)
{
   var url = "PatioSalesFYAnalysis.jsp?Year=<%=sYear%>"

   if (Month=="ALL") { per++; url += "&Mon=" + per + "&Week=ALL"}
   else { url += "&Mon=" + Month + "&Week=" + per}

   url += "&Type=" + Type;

   window.location.href = url;
}
//==============================================================================
// switch to different date type
//==============================================================================
function switchDayType()
{
   if(Type == "O") { Type = "D" }
   else { Type = "O" }

   var url = "PatioSalesFYAnalysis.jsp?Year=<%=sYear%>"
     + "&Mon=" + Month
     + "&Week=" + Week
     + "&Type=" + Type

   window.location.href = url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture Flash Sales<br>
            Selected <%if (sMonth.equals("ALL")){%>Year: <%=sYear%>
            <%} else if (sWeek.equals("ALL")) {%>Month: <%=sYear%>/<%=sMon[Integer.parseInt(sMonth.trim()) - 1]%>
            <%} else {%>Weekending: <%=sWeek%><%}%>
        <br><%if(sType.equals("O")){%>By Order Date<%}
            else {%>By Delivery Date<%}%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="PatioSalesFYAnalysisSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <button class="Small" onClick="switchDayType()"><%if( sType.equals("O")){%>By Delivery Date<%}
        else {%>By Order Date<%}%>
        </button>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
              <th class="DataTable"><%if (sMonth.equals("ALL")){%>Months<%} else if (sWeek.equals("ALL")) {%>Weeks<%} else{%>Days<%}%></th>
              <th class="DataTable">Str<br>46</th>
              <th class="DataTable">Str<br>50</th>
              <th class="DataTable">Str<br>86</th>
              <th class="DataTable">Total</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfPer; i++ )
         {
            pfslsanl.setFlashSls();
            String [] sSls = pfslsanl.getSls();
        %>
            <tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap>
              <%if(sMonth.equals("ALL")){%><a href="javascript: drillDown('<%=i%>')"><%=sPeriod[i]%></a>
              <%} else if(sWeek.equals("ALL")){%><a href="javascript: drillDown('<%=sPer[i]%>')"><%=sPeriod[i]%></a>
              <%} else {%><%=sPeriod[i]%><%}%>
            </td>
            <%for(int j=0; j < 4; j++){%>
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
            <%}%>
          </tr>
       <%}%>
       <!-- -------------------------- Total ------------------------------- -->
       <%
            pfslsanl.setTotals();
            String [] sSls = pfslsanl.getSls();
       %>
       <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap>Total</td>
            <%for(int j=0; j < 4; j++){%>
               <td class="DataTable2" nowrap>$<%=sSls[j]%></td>
            <%}%>
       </tr>

     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   pfslsanl.disconnect();
   pfslsanl = null;
   }
%>