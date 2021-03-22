<%@ page import="timecard.TimecardInc, java.util.*"%>
<%
   System.out.print(0);
   String sWkend = request.getParameter("Wkend");
   String sBadOnly = request.getParameter("BadOnly");

   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=TimecardInc.jsp&" + request.getQueryString());
   }
   else
   {
     String sUser = session.getAttribute("USER").toString();
     TimecardInc tmcinc = new TimecardInc(sWkend, sBadOnly);
     int iNumOfStr = tmcinc.getNumOfStr();
     String [] sStr = tmcinc.getStr();
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
        td.DataTable11 { background:#E7E7E7; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
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
      <br>Timecard vs.  Schedule Inconsistency</b><br>
<!-------------------------------------------------------------------->
      <br>Weekend: <%=sWkend%></b>
      <br>
<!-------------------------------------------------------------------->
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="TimecardIncSel.jsp"><font color="red" size="-1">Selector</font></a>&#62;
        <font size="-1">This page</font>
        &nbsp; &nbsp; &nbsp;
        <%if(sBadOnly.equals("0")){%>
           <a class="Small" href="TimecardInc.jsp?Wkend=<%=sWkend%>&BadOnly=1">Inconcistency Only</a>
        <%}
        else {%>
           <a class="Small" href="TimecardInc.jsp?Wkend=<%=sWkend%>&BadOnly=0">All</a>
        <%}%>
    <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable" rowspan=2>Store</th>
            <th class="DataTable" rowspan=2>Employee</th>
            <th class="DataTable" rowspan=2>Dept</th>
            <th class="DataTable" rowspan=2>Title</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
              <th class="DataTable" colspan=4>Timecard</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=3>Schedule</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=2>Inconsistency</th>
         </tr>
         <tr>
            <th class="DataTable">Vac<br>Days</th>
            <th class="DataTable">Hol<br>Days</th>
            <th class="DataTable">Sick<br>Days</th>
            <th class="DataTable">Fixes<br>or<br>4/8 hrs.</th>

            <th class="DataTable">Vac<br>Days</th>
            <th class="DataTable">Hol<br>Days</th>
            <th class="DataTable">Req<br>Off</th>

            <th class="DataTable">Vac</th>
            <th class="DataTable">Hol</th>
         </tr>
         <!------------------------- Data Detail ------------------------------>
         <%for(int i=0; i < iNumOfStr; i++ )
         {
            tmcinc.setEmpLst();
            int iNumOfEmp = tmcinc.getNumOfEmp();
            String [] sEmp = tmcinc.getEmp();
            String [] sName = tmcinc.getName();
            String [] sTcVac = tmcinc.getTcVac();
            String [] sTcHol = tmcinc.getTcHol();
            String [] sTcSick = tmcinc.getTcSick();
            String [] sTcFix = tmcinc.getTcFix();
            String [] sTcFix2 = tmcinc.getTcFix2();
            String [] sScVac = tmcinc.getScVac();
            String [] sScHol = tmcinc.getScHol();
            String [] sScOff = tmcinc.getScOff();
            String [] sVacInc = tmcinc.getVacInc();
            String [] sHolInc = tmcinc.getHolInc();
            String [] sDept = tmcinc.getDept();
            String [] sTitle = tmcinc.getTitle();

            if(iNumOfEmp > 0){
         %>
              <tr  id="trDtl" class="DataTable<%if(sVacInc[0].equals("1") || sHolInc[0].equals("1") || !sTcFix2[0].equals("") ){%>1<%}%>">
                <td class="DataTable11" rowspan=<%=iNumOfEmp%>  id="tdStr">
                <a href="PrWkSched.jsp?STORE=<%=sStr[i]%>&STRNAME=%20&MONBEG=<%=sWkend%>&WEEKEND=<%=sWkend%>" target="_blank"><%=sStr[i]%></a></td>
                <%for(int j=0; j < iNumOfEmp; j++ ){%>
                  <%if(j > 0){%><tr class="DataTable<%if(sVacInc[j].equals("1") || sHolInc[j].equals("1") || !sTcFix2[j].equals("")){%>1<%}%>"><%}%>
                  <td class="DataTable1"><a href="EmpTmcVsSched.jsp?Wkend=<%=sWkend%>&Str=<%=sStr[i]%>&Emp=<%=sEmp[j]%>&EmpName=<%=sName[j]%>"><%=sEmp[j] + " " + sName[j]%></a></td>
                  <td class="DataTable1">&nbsp;<%=sDept[j]%></td>
                  <td class="DataTable1">&nbsp;<%=sTitle[j]%></td>
                  <th class="DataTable">&nbsp;</th>
                  <td class="DataTable1">&nbsp;<%=sTcVac[j]%></td>
                  <td class="DataTable1">&nbsp;<%=sTcHol[j]%></td>
                  <td class="DataTable1">&nbsp;<%=sTcSick[j]%></td>
                  <td class="DataTable1">&nbsp;<%=sTcFix2[j]%></td>
                  <th class="DataTable">&nbsp;</th>
                  <td class="DataTable1">&nbsp;<%=sScVac[j]%></td>
                  <td class="DataTable1">&nbsp;<%=sScHol[j]%></td>
                  <td class="DataTable1">&nbsp;<%=sScOff[j]%></td>
                  <th class="DataTable">&nbsp;</th>
                  <td class="DataTable" style="font-family:Wingdings;" ><%if(sVacInc[j].equals("1")){%>&#0252;<%} else{%>&nbsp;<%}%></td>
                  <td class="DataTable" style="font-family:Wingdings;" ><%if(sHolInc[j].equals("1")){%>&#0252;<%} else{%>&nbsp;<%}%></td>
                <%}%>
           <%}%>
         <%}%>
      </table>
     <!--------------------------------------------------------------------->
  </table>
 </body>
</html>
<%
   tmcinc.disconnect();
   tmcinc = null;
}%>