<%@ page import="aim.AmEvtLst"%>
<%
   String [] sSelSts = request.getParameterValues("Sts");
   String sFrDate = request.getParameter("From");
   String sToDate = request.getParameter("To");
   String [] sSelStr = request.getParameterValues("Str");
   String sSort = request.getParameter("Sort");

   if (sSort == null) { sSort = "NAME"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AmEvtLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmEvtLst evtlst = new AmEvtLst(sSelSts, sFrDate, sToDate, sSelStr, sSort, sUser);

      String sSelStsJsa = evtlst.cvtToJavaScriptArray(sSelSts);
      String [] sWkDayNm = new String[]{"&nbsp;", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
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
var SelSts = [<%=sSelStsJsa%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{
   var url = "AimEvtLst.jsp?"

   for(var i=0; i < SelSts.length; i++)  { url += "&Sts=" + SelSts[i] }

   url += "&From=<%=sFrDate%>"
   url += "&To=<%=sToDate%>"
   url += "&Sort=" + sort

   //alert(url)
   window.location.href = url;
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
        <br>AIM Event List
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
         <th class="DataTable"><a href="javascript: resort('ID')">Evt<br>ID</a></th>
         <th class="DataTable"><a href="javascript: resort('NAME')">Event Name</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('BEGDT')">Beginning<br>Date</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('EXPDT')">Expiration<br>Date</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('STS')">Status</a></th>
         <th class="DataTable" rowspan=2>Scores<br>Levels</th>
         <th class="DataTable" rowspan=2>Number of<br>Participants</th>
         <th class="DataTable" rowspan=2>Earned<br>Scores</th>
         <th class="DataTable" rowspan=2>Lvl 1<br>Scr</th>
         <th class="DataTable" rowspan=2>Lvl 2<br>Scr</th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('FRQ')">Frequency</a></th>
         <th class="DataTable" rowspan=2>Weekday</th>
         <th class="DataTable" rowspan=2>Last<br>Time Updated</th>
         <th class="DataTable" rowspan=2>Stores</th>
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    while( evtlst.getNext() )
    {
      evtlst.setAmEvtLst();
      String sEvtId = evtlst.getEvtId();
      String sName = evtlst.getName();
      String sBegDt = evtlst.getBegDt();
      String sExpDt = evtlst.getExpDt();
      String sSts = evtlst.getSts();
      String sFreq = evtlst.getFreq();
      String sRecUs = evtlst.getRecUs();
      String sRecDt = evtlst.getRecDt();
      String sRecTm = evtlst.getRecTm();
      String sAsgEmp = evtlst.getAsgEmp();
      int iNumOfScr = evtlst.getNumOfScr();
      String [] sEvtScr = evtlst.getEvtScr();
      String sEarned = evtlst.getEarned();
      String sWkday = evtlst.getWkday();
      String sL1Scr = evtlst.getL1Scr();
      String sL2Scr = evtlst.getL2Scr();
      int iNumOfEvtStr = evtlst.getNumOfEvtStr();
      String [] sEvtStr = evtlst.getEvtStr();

      String sComa = "";
  %>
     <tr class="DataTable1">
       <td class="DataTable2"><a href="AimEvt.jsp?id=<%=sEvtId%>" target="_blank"><%=sEvtId%></a></td>
       <td class="DataTable" nowrap><%=sName%></td>
       <td class="DataTable"><%=sBegDt%></td>
       <td class="DataTable"><%=sExpDt%></td>
       <td class="DataTable2"><%=sSts%></td>
       <td class="DataTable">
          <%sComa = "";
            for(int i=0; i < iNumOfScr; i++){%>
               <%=sComa%><%=sEvtScr[i]%><%sComa=", ";%>
          <%}%>
       </td>
       <td class="DataTable2"><a href="AimEvtEmpLst.jsp?id=<%=sEvtId%>&name=<%=sName%>" target="_blank"><%=sAsgEmp%></a></td>
       <td class="DataTable2"><%=sEarned%></td>
       <td class="DataTable2"><%=sL1Scr%></td>
       <td class="DataTable2"><%=sL2Scr%></td>
       <td class="DataTable"><%=sFreq%></td>
       <td class="DataTable"><%=sWkDayNm[Integer.parseInt(sWkday)]%></td>
       <td class="DataTable" nowrap><%=sRecUs%> <%=sRecDt%> <%=sRecTm%></td>
       <td class="DataTable" nowrap>
          <%sComa = "";
            String br = "";
            for(int i=0; i < iNumOfEvtStr; i++){%>
               <%=sComa%>
               <%if(i > 0 &&  i % 15 == 0){%><br><%}%>
               <%if(sEvtStr[i].equals("0")){%>HO<%} else {%><%=sEvtStr[i]%><%}%><%sComa=",";%>
          <%}%>&nbsp;
       </td>
       </tr>
  <%}%>
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    evtlst.disconnect();
    evtlst = null;
%>
<%}%>