<%@ page import="java.util.*, java.text.*, payrollreports.AllwBdgWkHist"%>
<%
   String sWkend = request.getParameter("Week");

   String sUser = session.getAttribute("USER").toString();

   String sAppl = "PRHIST";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=AllwBdgWkHist.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
    AllwBdgWkHist abhist = new AllwBdgWkHist(sWkend, sUser);

    int iNumOfCol = abhist.getNumOfCol();
    String [] sHdr1 = abhist.getHdr1();
    String [] sHdr2 = abhist.getHdr2();

    int iNumOfGrp = abhist.getNumOfGrp();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable2 { background:#FFCC99; white-space: nowrap; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; text-align:left; font-size:12px }
        th.DataTable3 { background:#ccffcc; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable4 { background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable5 { background:#ccffcc; writing-mode: tb-rl; filter: flipv fliph;
                        padding-left:1px; padding-right:1px; padding-top:10px;
                        font-size:12px; text-align:left;}

        tr.DataTable { background: white; font-size:10px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }
        tr.DataTable31 { background: #ffff99; font-size:10px }
        tr.DataTable32 { background: gold; font-size:10px }
        tr.DataTable33 { background: white; font-size:10px }
        tr.DataTable4 { color:Maroon; background: Khaki; font-size:10px }
        tr.DataTable5 { background: Moccasin; font-size:10px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable01 { background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable02 { background: Khaki; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable21 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable22 {  background: azure; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable2p { background: #d0d0d0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2g { background:lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2r { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.DataTable210 { background: lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable211 { background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable3 { background: black; font-size:12px }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmpList { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSlsGoal { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}

        div.dvHelp { position:absolute; visibility:hidden; background-attachment: scroll;
               width:150; background-color:LemonChiffon; z-index:10;
              text-align:left; font-size:12px}

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
<html>
<head><Meta http-equiv="refresh"></head>

<SCRIPT language="JavaScript">
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpList"]);
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvEmpList" class="dvEmpList"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Weekly Budget vs. Schedule and Actual Payroll (History)
      <br>Weekending date: <%=sWkend%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <a href="AllwBdgWkHistSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: displayAllHelp()">Help</a>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th colspan=9></th>
          <th class="DataTable3" colspan=20>Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.)</th>
        </tr>
        <tr>
          <th colspan=2></th>
          <th class="DataTable4" colspan=6>Sales</th>
          <th colspan=1></th>
          <th class="DataTable4" colspan=7>P/R Hours</th>
          <th></th>
          <th class="DataTable4" colspan=3>P/R $'s</th>
          <th class="DataTable4" colspan=3>Hourly Rate</th>
          <th></th>
          <th class="DataTable4" colspan=5>Variance</th>
          <th></th>
          <th class="DataTable4" colspan=6>T/M/C</th>
          <th></th>
          <th class="DataTable4" colspan=5>Actual Processed Payroll</th>
        </tr>
        <tr>
          <th class="DataTable" style="vertical-align:middle" rowspan=2>Store</th>
          <%for(int i=0; i < iNumOfCol; i++){%>
             <%if(i==0 || i==6 || i==13 || i==19 || i==24 || i==30 ){%><th class="DataTable" rowspan=2>&nbsp;</th><%}%>
             <th class="DataTable2"><%=sHdr1[i]%></th>
          <%}%>
        </tr>
        <tr>
            <%for(int i=0; i < iNumOfCol; i++){%>
             <th class="DataTable"><%if(sHdr2[i].equals("")){%>&nbsp;<%}%><%=sHdr2[i]%></th>
          <%}%>
        </tr>

     <tr class="Divdr1"></td><td colspan=43>&nbsp;</td></tr>
     <!------------------------- Region --------------------------------------->
     <%for(int i=0; i < iNumOfGrp; i++){
         abhist.setBdgHist();
         String sGrp = abhist.getGrp();
         String [] sAmt = abhist.getAmt();
     %>
        <%if(sGrp.indexOf("Total") >= 0){%>
           <tr class="Divdr1"></td><td colspan=43>&nbsp;</td></tr>
           <tr class="Divdr1"></td><td colspan=43>&nbsp;</td></tr>
        <%}%>

        <tr class="DataTable<%if(sGrp.indexOf("Reg") >= 0 || sGrp.indexOf("Total") >= 0){%>5<%}%>">
           <td class="DataTable" nowrap><%=sGrp%></td>
           <!-- ------------------- Stores --------------------------------------->
           <%for(int j=0; j < iNumOfCol; j++){%>
               <%if(j==0 || j == 6 || j==13 || j==19 || j==24 || j==30){%><th class="DataTable">&nbsp;</th><%}%>
               <td class="DataTable<%if(j==6){%>01<%}%><%if(j==9 || j==10){%>02<%}%>" nowrap>&nbsp;<%=sAmt[j]%></td>
           <%}%>
        </tr>
        <%if(sGrp.indexOf("Reg") >= 0){%>
           <tr class="Divdr1"></td><td colspan=43>&nbsp;</td></tr>
        <%}%>
     <%}%>
   </table>
    <!----------------------- end of table ---------------------------------->
  </table>
 </body>

</html>

<%abhist.disconnect();%>

<%}%>






