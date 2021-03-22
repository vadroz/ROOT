<%@ page import="aim.AmEmpScrLst"%>
<%
   String sEmp = request.getParameter("emp");
   String sEmpNm = request.getParameter("empnm");
   String sSort = request.getParameter("sort");

   if (sSort == null) { sSort = "DATE"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AmEmpScrLst.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmEmpScrLst empscr = new AmEmpScrLst(sEmp, sSort, sUser);
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:red;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#cccfff;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:cornsilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
        td.DataTable1 {padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable1p {background:gray;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
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

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// restart
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// show errors
//==============================================================================
function showError(err)
{
   var br = "";
   for(var i=0; i < err.length; i++)
   {
     document.all.tdError.innerHTML= br + err[i];
     br = "<br>"
   }
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>AIM Employee Score List
        <br><%=sEmp%>&nbsp;<%=sEmpNm%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="AimEvtLstSel.jsp"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;
  <!----------------------- Order List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable">Event</th>
         <th class="DataTable">Earned<br>Scores</th>
         <th class="DataTable">Score<br>Date</th>
         <th class="DataTable">Recorded By</th>
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    while( empscr.getNext() )
    {
      empscr.setAmEmpScrLst();
      String sEvt = empscr.getEvt();
      String sName = empscr.getName();
      String sScore = empscr.getScore();
      String sScrDt = empscr.getScrDt();
      String sRecUs = empscr.getRecUs();
      String sRecDt = empscr.getRecDt();
      String sRecTm = empscr.getRecTm();
  %>
     <tr class="DataTable1">
       <td class="DataTable"><%=sName%></td>
       <td class="DataTable2"><%=sScore%></td>
       <td class="DataTable2"><%=sScrDt%></td>
       <td class="DataTable"><%=sRecUs%> <%=sRecDt%> <%=sRecTm%></td>
       </tr>
  <%}%>
     <%
        empscr.setTotal();
        String sTotScr = empscr.getTotScr();
     %>
     <tr class="DataTable3">
       <td class="DataTable">Total</td>
       <td class="DataTable2"><%=sTotScr%></td>
       <td class="DataTable2">&nbsp;</td>
       <td class="DataTable">&nbsp;</td>
       </tr>

      </TBODY>
    </table>

  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    empscr.disconnect();
    empscr = null;
%>
<%}%>