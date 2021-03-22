<%@ page import="worldcup.ShowGame, rciutility.FormatNumericValue, java.util.*, java.text.*"%>
<%
    String sDate = request.getParameter("selDate");
    String sSort = request.getParameter("Sort");

    if (sDate == null)
    {
      Date date;
      SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      cal.add(Calendar.DATE, -1);
      date = cal.getTime();
      sDate = df.format(date);
    }

    if (sSort == null) { sSort = "MTDSCR"; }

    ShowGame game = new ShowGame(sDate, sSort);

    int iNumOfStr = game.getNumOfStr();
    String [] sStr = game.getStr();
    String [] sMtdScr = game.getMtdScr();
    String [] sMtdSls = game.getMtdSls();
    String [] sMtdPln = game.getMtdPln();
    String [] sMtdVar = game.getMtdVar();

    String [] sWtdScr = game.getWtdScr();
    String [] sWtdSls = game.getWtdSls();
    String [] sWtdPln = game.getWtdPln();
    String [] sWtdVar = game.getWtdVar();

    String [] sDlyScr = game.getDlyScr();
    String [] sDlySls = game.getDlySls();
    String [] sDlyPln = game.getDlyPln();
    String [] sDlyVar = game.getDlyVar();

    game.disconnect();

    FormatNumericValue fmt = new FormatNumericValue();
%>

<html>
<head>

<!-- --------------- Date Selection prompt ----------------------- -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       padding-right:6px; padding-left:6px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:#eaeaea; padding-top:3px; padding-bottom:3px;
                       padding-right:6px; padding-left:6px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTableg { background:Yellow; padding-top:3px; padding-bottom:3px;
                       padding-right:6px; padding-left:6px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:#eaeaea; padding-top:3px; padding-bottom:3px;
                       padding-right:6px; padding-left:6px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px;
                       padding-right:6px; padding-left:6px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }

        td.DataTable2g { background:yellow; padding-top:3px; padding-bottom:3px;
                       padding-right:6px; padding-left:6px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.Grid { text-align:center;}


        p.reg {text-align:center; font-family:Arial; font-size:10px}

</style>


<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
//--------------- End of Global variables -----------------------
function bodyLoad(){
  // populate date with yesterdate
      doSelDate();
}
// populate date with yesterdate
function  doSelDate(){
  var da = document.all;
  var date = new Date(new Date() - 86400000);
  da.selDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(form)
  {
    var msg;
    var vld = new Date(document.forms[0].selDate.value)
    var minYear=2011
    var maxYear= 2011;
    var error = false;

  if (document.forms[0].selDate.value == null || (new Date(vld)) == "NaN")
  {
    msg = " Please, enter report date\n"
    error = true;
  }
  else {document.forms[0].selDate.value = (vld.getMonth()+1) + "/" + vld.getDate() + "/" + vld.getFullYear()}

  if (vld.getFullYear() < minYear){
    msg = vld.getFullYear() + " is less that minimum year allowed\n"
    error = true;
  }
  if (vld.getFullYear() > maxYear){
    msg = vld.getFullYear() + " is greater that maximum year allowed\n"
    error = true;
  }

  if (error) alert(msg);
    return error == false;
  }
//==============================================================================
// Validate numeric fields
//==============================================================================
  function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}
//==============================================================================
// resort table
//==============================================================================
function resort(sort)
{
   var url = "ShowGame.jsp?"
     + "selDate=<%=sDate%>"
     + "&Sort=" + sort

   window.location.href = url
}
</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad();">
<div id="tooltip2" style="border: black solid 3px; position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP" colspan="3">
       <b>Sun & Ski Sports
        <br><font size=+2 color="red">March Madness
        <br>Sell It All !!! Tournament</font></b>
        <br><a href="WaterContest/March_Madness_2011_schedule.xls" target="_blank">Schedule</a>
     </tr>
<!-------------------------------------------------------------------->
      <tr>
      <td class="Grid" width="60%">
      <!----------------- Total Scores  ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan=2><a href="javascript: resort('MTDSTR')">Store</a></th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable" colspan=4>Daily Point Standings</th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable" colspan=5>Week-To-Date Point Standings</th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable" colspan=4>Month-To-Date Point Standings</th>
         </tr>
         <tr>

           <th class="DataTable" ><a href="javascript: resort('DLYSCR')">Points</a></th>
           <th class="DataTable" ><a href="javascript: resort('DLYSLS')">Actual<br>Sales</a></th>
           <th class="DataTable" ><a href="javascript: resort('DLYPLAN')">Planned<br>Sales</a></th>
           <th class="DataTable" ><a href="javascript: resort('DLYVAR')">Var %</a></th>

           <th class="DataTable" ><a href="javascript: resort('WTDSCR')">Points</a></th>
           <th class="DataTable" ><a href="javascript: resort('WTDSLS')">Actual<br>Sales</a></th>
           <th class="DataTable" ><a href="javascript: resort('WTDPLAN')">Planned<br>Sales</a></th>
           <th class="DataTable" ><a href="javascript: resort('WTDVAR')">Var %</a></th>
           <th class="DataTable" ><a href="javascript: resort('WTDVAR')">Made<br>Plan</a></th>

           <th class="DataTable" ><a href="javascript: resort('MTDSCR')">Points</a></th>
           <th class="DataTable" ><a href="javascript: resort('MTDSLS')">Actual<br>Sales</a></th>
           <th class="DataTable" ><a href="javascript: resort('MTDPLAN')">Planned<br>Sales</a></th>
           <th class="DataTable" ><a href="javascript: resort('MTDVAR')">Var<br>%</a></th>

         </tr>
         <!-- ================= Details =====================================-->
         <%for(int i=0; i < iNumOfStr; i++ ){%>
           <%if( i == iNumOfStr - 1){%>
           <tr style="background:darkred; font-size:3px;"><td colspan=16>&nbsp;</td></tr>
           <%}%>
           <tr>
             <td class="DataTable<%if(!sSort.equals("MTDSTR")  && ( sSort.indexOf("DLY") >= 0  && i < 8  || sSort.indexOf("WTD") >= 0  && i < 8 || sSort.indexOf("MTD") >= 0  && i < 4) ){%>g<%}%>" ><%=sStr[i]%></td>

             <th class="DataTable">&nbsp;</th>
             <td class="DataTable2" ><%=sDlyScr[i]%></td>
             <td class="DataTable1" >$<%=fmt.getFormatedNum(sDlySls[i], "###,###,###")%></td>
             <td class="DataTable1" >$<%=fmt.getFormatedNum(sDlyPln[i], "###,###,###")%></td>
             <td class="DataTable1" ><%=sDlyVar[i]%>%</td>

             <th class="DataTable">&nbsp;</th>
             <td class="DataTable2" ><%=sWtdScr[i]%></td>
             <td class="DataTable1" >$<%=fmt.getFormatedNum(sWtdSls[i], "###,###,###")%></td>
             <td class="DataTable1" >$<%=fmt.getFormatedNum(sWtdPln[i], "###,###,###")%></td>
             <td class="DataTable1" ><%=sWtdVar[i]%>%</td>
             <td class="DataTable" style="font-family:Wingdings; font-size:12px;" >
             <%if(Integer.parseInt(sWtdSls[i]) >= Integer.parseInt(sWtdPln[i])  ){%>&#0252;<%} else{%>&nbsp;<%}%></td>

             <th class="DataTable">&nbsp;</th>
             <td class="DataTable2" ><%=sMtdScr[i]%></td>
             <td class="DataTable1" >$<%=fmt.getFormatedNum(sMtdSls[i], "###,###,###")%></td>
             <td class="DataTable1" >$<%=fmt.getFormatedNum(sMtdPln[i], "###,###,###")%></td>
             <td class="DataTable1" ><%=sMtdVar[i]%>%</td>
           </tr>
         <%}%>
       </table>
       <!----------------------- end of Leage 1 table ------------------------>
     </td>
     </tr>
      <!----------------------- end of Players table ------------------------>
     <tr>
      <td class="Grid" colspan="3">
       <form  method="GET" action="ShowGame.jsp" onSubmit="return Validate(this)">
          <br><font size="-1">Click here to view a single day point standings:
          <input name="selDate" type="text" size=10 maxlength=10>
          <a href="javascript:showCalendar(1, null, null, 300, 250, null)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>&nbsp;&nbsp;&nbsp;
          <INPUT type=submit value=Submit name=SUBMIT></font>
      </form>

        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <font size="-1">This page</font>
    </td>
   </tr>
  </table>
 </body>
</html>
