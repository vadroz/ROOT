<%@ page import="timecard.TmcardDaily, java.util.*"%>
<%
   String sStr = request.getParameter("Str");
   String sWkend = request.getParameter("Wkend");

   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=TimecardRecap.jsp&" + request.getQueryString());
   }
   else
   {
     String sUser = session.getAttribute("USER").toString();

     TmcardDaily tmcdly = new TmcardDaily(sStr, sWkend);
     String [] sDate = tmcdly.getDate();
     String [] sFixCnt = tmcdly.getFixCnt();
     String [] sAllCnt = tmcdly.getAllCnt();
     String [] sPrc = tmcdly.getPrc();
%>

<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px; text-align:center;}
        th.DataTable { background:#FFCC99; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:green; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:white; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#E7E7E7;  font-size:10px }
        tr.DataTable1 { background:cornSilk;  font-size:10px }
        tr.DataTable2 { background:#ccffcc;  font-size:10px; text-align:center }
        tr.DataTable3 { background:#cccfff;  font-size:11px; text-align:center }

        td.DataTable { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

        td.LineBreak { border-bottom: darkred solid 4px; font-size:1px }
        .break { page-break-before: always; }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
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
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------

//--------------- End of Global variables -----------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" height="100%">
             <tr>
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Timecard Recap</b>
      <br>Str: <%=sStr%> &nbsp;  &nbsp; Weekend: <%=sWkend%>
      <br>
      </b>
      <br>
<!-------------------------------------------------------------------->
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="TimeCardRecapSel.jsp"><font color="red" size="-1">Selector</font></a>&#62;
        <font size="-1">This page</font>
    <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable">Date</th>
            <th class="DataTable">Fix<br>Counter</th>
            <th class="DataTable">All<br>Clockings</th>
            <th class="DataTable">Percents</th>
         </tr>
         <!------------------------- Data Detail ------------------------------>
         <%for(int i=0; i < 8; i++ ) {%>
             <%if(i < 7){%>
                <tr class="DataTable">
                   <td class="DataTable1" nowrap><%=sDate[i]%></td>
             <%} else {%>
                <tr><td class="LineBreak" colspan=22>&nbsp;</td></tr>
                <tr class="DataTable1">
                   <td class="DataTable1">Total</td>
             <%}%>

             <td class="DataTable" >&nbsp;<%=sFixCnt[i]%></td>
             <td class="DataTable" >&nbsp;<%=sAllCnt[i]%></td>
             <td class="DataTable" >&nbsp;<%if(!sPrc[i].equals("")){%><%=sPrc[i]%>%<%}%></td>
           </tr>
         <%}%>
      </table>
     <!--------------------------------------------------------------------->
  </table>
 </body>
</html>
<%
   tmcdly.disconnect();
   tmcdly = null;
}%>