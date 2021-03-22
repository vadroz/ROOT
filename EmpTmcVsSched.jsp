<%@ page import="timecard.EmpTmcVsSched, java.util.*, java.text.*"%>
<%
   String sWkend = request.getParameter("Wkend");
   String sStr = request.getParameter("Str");
   String sEmp = request.getParameter("Emp");
   String sEmpName = request.getParameter("EmpName");

   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EmpTmcVsSched.jsp&" + request.getQueryString());
   }
   else
   {
     String sUser = session.getAttribute("USER").toString();
     EmpTmcVsSched emptmsc = new EmpTmcVsSched(sWkend, sStr, sEmp);

     String sOrigStr = emptmsc.getOrigStr();
     String sDept = emptmsc.getDept();
     String sTitle = emptmsc.getTitle();
     String sHorS = emptmsc.getHorS();
     String sSepar = emptmsc.getSepar();
     String sHired = emptmsc.getHired();
     String sTerm = emptmsc.getTerm();
     String sSlsCom = emptmsc.getSlsCom();

     DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
     String [] sDates = new String[7];
     try
     {
         Date wkday = df.parse(sWkend);
         wkday.setTime(wkday.getTime() + 18 * 60 * 60 * 1000  - 6 * 86400000);
         for(int i=0; i < 7; i++)
         {
            sDates[i] = df.format(wkday);
            wkday.setTime(wkday.getTime() + 86400000);
         }
     }
     catch (Exception e) { System.out.println(e.getMessage()); }
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
var SuspOnly = false;
//--------------- End of Global variables -----------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" height="100%">
             <tr>
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Employee Timecard vs. Schedule<br>
<!-------------------------------------------------------------------->
      <br>Store <%=sStr%>
      <br><%=sEmp%> <%=sEmpName%>
      <br>Weekend: <%=sWkend%>
      </b>
      <br>
      <table border=1 cellPadding="0" cellSpacing="0">
         <tr style="text-align:left;font-size:12px;"><th>Original store &nbsp;<th><td style="padding:3px;"><%=sOrigStr%></td></tr>
         <tr style="text-align:left;font-size:12px;"><th>Department &nbsp;<th><td style="padding:3px;"><%=sDept%></td></tr>
         <tr style="text-align:left;font-size:12px;"><th>Title &nbsp;<th><td style="padding:3px;"><%=sTitle%></td></tr>
         <tr style="text-align:left;font-size:12px;"><th>Hourly/Salary &nbsp;<th><td style="padding:3px;"><%=sHorS%></td></tr>
         <tr style="text-align:left;font-size:12px;"><th>Sales Commisions &nbsp;<th><td style="padding:3px;"><%=sSlsCom%></td></tr>
      </table>
      <br>
      <br>
<!-------------------------------------------------------------------->
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="TimecardIncSel.jsp"><font color="red" size="-1">Selector</font></a>&#62;
        <font size="-1">This page</font>

    <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable" rowspan=2>Source</th>
            <th class="DataTable">Mon</th>
            <th class="DataTable">Tue</th>
            <th class="DataTable">Wed</th>
            <th class="DataTable">Thu</th>
            <th class="DataTable">Fri</th>
            <th class="DataTable">Sat</th>
            <th class="DataTable">Sun</th>
         </tr>
         <tr>
            <%for(int i=0; i < 7; i++){%><th id="WkDate" class="DataTable"><%=sDates[i]%></th><%}%>
         </tr>
         <!------------------------- Data Detail ------------------------------>
         <tr class="DataTable">
            <td class="DataTable1">Timecard Entries</td>
            <%for(int i=0; i < 7; i++ ){
                emptmsc.setTimeCard();
                int iMax = emptmsc.getMax();
                String [] sType = emptmsc.getType();
                String [] sTmIn = emptmsc.getTmIn();
                String [] sTmOut = emptmsc.getTmOut();
            %>
               <td class="DataTable1">
                  <%for(int j=0; j < iMax; j++){%>
                      <span <%if(sType[j].equals("VAC")){%>style="background:lightblue"<%}
                            else if(sType[j].equals("HOL")){%>style="background:lightgreen"<%}
                            else if(sType[j].equals("SICK")){%>style="background:salmon"<%}
                            else if(sType[j].indexOf("*") >= 0){%>style="background:pink"<%}%>
                            >

                            <%=sType[j]%> <%=sTmIn[j]%> - <%=sTmOut[j]%><br>
                      </span>
                  <%}%>
                  &nbsp;
               </td>
            <%}%>

         <!--------------------- Schedule -------------->
         <tr class="DataTable">
            <td class="DataTable1">Payroll Schedule</td>
            <%for(int i=0; i < 7; i++ ){
                emptmsc.setSched();
                int iMax = emptmsc.getMax();
                String [] sType = emptmsc.getType();
                String [] sTmIn = emptmsc.getTmIn();
                String [] sTmOut = emptmsc.getTmOut();
            %>
               <td class="DataTable1">
                  <%for(int j=0; j < iMax; j++){%>
                      <span <%if(sType[j].equals("VAC")){%>style="background:lightblue"<%}
                            else if(sType[j].equals("HOL")){%>style="background:lightgreen"<%}
                            else if(sType[j].equals("OFF")){%>style="background:gold"<%}%>>
                         <%=sType[j]%> <%=sTmIn[j]%> - <%=sTmOut[j]%></span><br>
                  <%}%>
                  &nbsp;
               </td>
            <%}%>
      </table>
     <!--------------------------------------------------------------------->
  </table>
 </body>
</html>
<%
   emptmsc.disconnect();
   emptmsc = null;
}%>