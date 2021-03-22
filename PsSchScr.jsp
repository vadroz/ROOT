<%@ page import="payrollreports.PsSchScr"%>
<%
  String sWeek = request.getParameter("Week");
  String sSort = request.getParameter("Sort");
  String sAllEmp = request.getParameter("AllEmp");
  String sCalc = request.getParameter("Calc");

  if(sSort == null){ sSort = "STORE"; }
  if(sAllEmp == null){ sAllEmp = "SLS"; }
  if(sCalc == null){ sCalc = "PERCENT"; }

  PsSchScr schscr = new PsSchScr(sWeek, sAllEmp, sCalc, sSort);


  String sWkBeg = schscr.getWkBeg();
  String sMnBeg = schscr.getMnBeg();
  int iNumOfStr = schscr.getNumOfStr();
%>

<html>
<head>
<title>Daily Schedule Score</title>

<style> body {background:ivory;  vertical-align:bottom;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:left; font-family:Arial; font-size:10px }
         td.DataTable2 { background:CornSilk;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:right; font-family:Arial; font-size:10px }
         td.DataTable3 { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:8px }

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; }

        .Small { font-size:10px; }

    @media screen
    {
        tr.Hdr {display:none; }
    }
    @media print
    {
        tr.Hdr {display:block }
    }
</style>
<SCRIPT language="JavaScript">

function bodyLoad()
{
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
    <tr bgColor="moccasin">
     <td style="vertical-align:top; text-align:center;">
      <b>Retail Concepts, Inc
      <br>Daily Schedule Score
      <br>Weekend: <%=sWeek%></b>
<!------------- end of store selector ---------------------->
        <br><a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="PsSchScrSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
        <font size="-1">This page</font>

        &nbsp; &nbsp; &nbsp;
        <%if(!sAllEmp.equals("ALL")){%>
           <a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=<%=sSort%>&AllEmp=ALL&Calc=<%=sCalc%>"><font color="red" size="-1">All Employees</font></a>
        <%} else {%>
           <a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=<%=sSort%>&AllEmp=SLS&Calc=<%=sCalc%>"><font color="red" size="-1">Sales Personnel Only</font></a>
        <%}%>

        &nbsp; &nbsp; &nbsp;
        <%if(!sCalc.equals("STDDEV")){%>
           <a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=<%=sSort%>&AllEmp=<%=sAllEmp%>&Calc=STDDEV"><font color="red" size="-1">Standard Deviation</font></a>
        <%} else {%>
           <a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=<%=sSort%>&AllEmp=<%=sAllEmp%>&Calc=PERCENT"><font color="red" size="-1">Percent Deviation</font></a>
        <%}%>

  <!-------------------- start of dollars table ----------------------------->
      <table class="DataTable" align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan=4><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGION">Reg</a></th>
          <th class="DataTable" rowspan=4><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STORE">Store</a></th>
          <th class="DataTable" rowspan=2>Sort</th>
          <th class="DataTable" colspan=8>Score</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" rowspan=2>Weekly<br>Sales Goal<br>(85%)</th>
          <th class="DataTable" rowspan=2>Weekly<br>Scheduled<br>Sales Hours</th>
          <th class="DataTable" rowspan=2>Base Weekly<br>Scheduled<br>Sales Hours</th>
          <th class="DataTable" rowspan=2>Avg<br>Scheduled<br>Sales</th>
          <th class="DataTable" rowspan=2>Mon-Fri<br>Avg<br>Scheduled<br>Sales</th>
          <th class="DataTable" rowspan=2>Sat-Sun<br>Avg<br>Scheduled<br>Sales</th>
          <th class="DataTable" rowspan=2>Standard<br>Deviation</th>
          <th class="DataTable" rowspan=2># of Hrs<br>&nbsp;> Threshold</th>
          <th class="DataTable" rowspan=4>SPH<br>Threshold</th>
        </tr>
        <tr>
          <th class="DataTable">Mon</th>
          <th class="DataTable">Tue</th>
          <th class="DataTable">Wed</th>
          <th class="DataTable">Thu</th>
          <th class="DataTable">Fri</th>
          <th class="DataTable">Sat</th>
          <th class="DataTable">Sun</th>
          <th class="DataTable">Total</th>
        </tr>
        <tr>
          <th class="DataTable">By Str</th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRMON">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRTUE">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRWED">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRTHU">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRFRI">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRSAT">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRSUN">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRTOTAL">S</a></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRGOAL">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRWKSCH">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRBSSCH">S</a></th>
          <th class="DataTable" colspan=3><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRTOTAVG">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STRSTDDEV">S</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=STROVR500">S</a></th>
          
        </tr>
        <tr>
          <th class="DataTable">By Reg</th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGMON">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGTUE">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGWED">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGTHU">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGFRI">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGSAT">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGSUN">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGTOTAL">R</a></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGGOAL">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGWKSCH">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGBSSCH">R</a></th>
          <th class="DataTable" colspan=3><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGTOTAVG">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGSTDDEV">R</a></th>
          <th class="DataTable"><a href="PsSchScr.jsp?Week=<%=sWeek%>&Sort=REGOVR500">R</a></th>

        </tr>
     <!-- ---------------------- Detail Loop ----------------------- -->
     <%String sSvReg = null;%>
     <%for(int i=0; i < iNumOfStr; i++)
     {
        schscr.setScores();
        String sStr = schscr.getStr();
        String sReg = schscr.getReg();
        String sStrNm = schscr.getStrNm();
        String sStdDev = schscr.getStdDev();
        String sAvg = schscr.getAvg();
        String sTotGoal85 = schscr.getTotGoal85();
        String [] sDlyGoal85 = schscr.getDlyGoal85();
        String sAbove = schscr.getAbove();
        String sBelow = schscr.getBelow();
        String sGood = schscr.getGood();
        String [] sScrGoal = schscr.getScrGoal();
        String [] sDlyScr = schscr.getDlyScr();
        String sWkSlsHrs = schscr.getWkSlsHrs();
        String sBsSlsHrs = schscr.getBsSlsHrs();
        String sMFAvg = schscr.getMFAvg();
        String sSSAvg = schscr.getSSAvg();
        String sSHNum = schscr.getSHNum();
        String sSlsLvl = schscr.getSlsLvl();
      %>
        <%if(sSort.indexOf("REG") >= 0 && sSvReg != null && !sSvReg.equals(sReg)){%>
           <tr><td colspan=12 style="background:brown; font-size:2px;">&nbsp;</td></tr>
        <%}%>
        <%sSvReg = sReg;%>

        <tr>
          <td class="DataTable1"><%=sReg%></td>
          <td class="DataTable1"><a href="PsEmpNum.jsp?STORE=<%=sStr%>&STRNAME=<%=sStrNm%>&MONBEG=<%=sMnBeg%>&WEEKEND=<%=sWeek%>&WKDATE=<%=sWkBeg%>&FROM=BUDGET&WKDAY=Monday&SELSEC=SELL&AllEmp=<%=sAllEmp%>&Calc=<%=sCalc%>" target="_blank"><%=sStr%> - <%=sStrNm%></a></td>

          <th class="DataTable"><a href="PsWkSched.jsp?STORE=<%=sStr%>&STRNAME=<%=sStrNm%>&MONBEG=<%=sMnBeg%>&WEEKEND=<%=sWeek%>&FROM=BUDGET" target="_blank">S</a></th>
          <%for(int j=0; j < 7; j++){%>
            <td class="DataTable">
              <span style="width:100%;color:<%if(Integer.parseInt(sDlyScr[j]) > 90){%>green<%}
               else if(Integer.parseInt(sDlyScr[j]) < 25){%>black<%}
               else if(Integer.parseInt(sDlyScr[j]) < 50){%>red<%}%>
               <%if(Integer.parseInt(sDlyScr[j]) < 25){%>;background:pink<%}%>"><%=sDlyScr[j]%>%</span>
            </td>
          <%}%>
          <td class="DataTable2">
            <span style="color:<%if(Integer.parseInt(sGood) > 90){%>green<%}
               else if(Integer.parseInt(sGood) < 50){%>red<%}%>"><%=sGood%>%</span>
          </td>

          <th class="DataTable">&nbsp;</th>
          <td class="DataTable2">$<%=sTotGoal85%></td>
          <td class="DataTable2"><%=sWkSlsHrs%></td>
          <td class="DataTable2"><%=sBsSlsHrs%></td>
          <td class="DataTable2">$<%=sAvg%></td>
          <td class="DataTable2">$<%=sMFAvg%></td>
          <td class="DataTable2">$<%=sSSAvg%></td>
          <td class="DataTable2">$<%=sStdDev%></td>
          <td class="DataTable2"><%=sSHNum%></td>
          <td class="DataTable2"><%=sSlsLvl%></td>
        </tr>
      <%}%>
   </table>

   Scores above <span style="color:green">90%</span> are shown in GREEN.
   Scores below <span style="color:red">50%</span> are shown in RED.

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
<%schscr.disconnect();%>