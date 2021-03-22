<%@ page import="worldcup.ShowGameTS, worldcup.ShowDateGameTS, java.util.*, java.text.*"%>
<%
    ShowGameTS game = new ShowGameTS();
    int iNumOfLg = game.getNumOfLg();
    String [] sLgStr = game.getLgStr();
    String [] sLgScr = game.getLgScr();
    String [] sLgTySls = game.getLgTySls();
    String [] sLgLySls = game.getLgLySls();
    String [] sLgVar = game.getLgVar();

    game.disconnect();

    String sDate = request.getParameter("selDate");
    if (sDate == null)
    {
      Date date;
      SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      cal.add(Calendar.DATE, -1);
      date = cal.getTime();
      sDate = df.format(date);
    }

    ShowDateGameTS dategame = new ShowDateGameTS(sDate);

    int iNumOfPlr = dategame.getNumOfPlr();
    String [] sPlr1Lg = dategame.getPlr1Lg();
    String [] sPlr1Scr = dategame.getPlr1Scr();
    String [] sPlr1TySls = dategame.getPlr1TySls();
    String [] sPlr1LySls = dategame.getPlr1LySls();
    String [] sPlr1Var = dategame.getPlr1Var();

    String [] sPlr2Lg = dategame.getPlr2Lg();
    String [] sPlr2Scr = dategame.getPlr2Scr();
    String [] sPlr2TySls = dategame.getPlr2TySls();
    String [] sPlr2LySls = dategame.getPlr2LySls();
    String [] sPlr2Var = dategame.getPlr2Var();

    int [] iNumOfStr = dategame.getNumOfStr();
    String [][] sStr = dategame.getStr();
    String [][] sStrTySls = dategame.getStrTySls();
    String [][] sStrLySls = dategame.getStrLySls();
    String [][] sStrVar = dategame.getStrVar();

    dategame.disconnect();
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
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left; font-family:Arial; font-size:10px }
        td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable3 { background:azure; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 { background:azure; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right; font-family:Arial; font-size:10px }

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

// Validate form
  function Validate(form){
    var msg;
    var vld = new Date(document.forms[0].selDate.value)
    var minYear=2006
    var maxYear= 2006;
    var error = false;


  if (document.forms[0].selDate.value == null
  || (new Date(vld)) == "NaN")
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
// Validate numeric fields
  function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}

</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad();">
<div id="tooltip2" style="border: black solid 3px; position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP" colspan="3">
       <b>Sun & Ski Sports<br>
        <br><h3>2006 King of The Water Contest</h3>
       </b>
     </tr>
<!-------------------------------------------------------------------->
      <tr>
      <td><img src="WaterContest/Team1.jpg" width="90" height="80"></td>
      <td class="Grid" width="60%">

      <!----------------- Leage 1 of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Total<br>Points</th>
           <th class="DataTable" >This Year<br>Sales</th>
           <th class="DataTable" >Last Year<br>Sales</th>
           <th class="DataTable" >Var %</th>

         </tr>
         <%for(int i=0; i < iNumOfLg; i++ ){%>
           <tr>
             <td class="DataTable" ><%=sLgStr[i]%></td>
             <td class="DataTable2" ><%=sLgScr[i]%></td>
             <td class="DataTable1" >$<%=sLgTySls[i]%></td>
             <td class="DataTable1" >$<%=sLgLySls[i]%></td>
             <td class="DataTable1" nowrap><%=sLgVar[i]%>%</td>
           </tr>
         <%}%>
       </table>
     </td>
     <td><img src="WaterContest/Team2.jpg" width="90" height="90"></td>
     </tr>
     <!-------------------------------------------------------------------->
      <tr>
      <td><img src="WaterContest/Team3.jpg" width="90" height="80"></td>
      <td class="Grid" width="60%">
       <br>

      <!----------------- Leage 1 of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Today<br>Points</th>
           <th class="DataTable" >This Year<br>Sales</th>
           <th class="DataTable" >Last Year<br>Sales</th>
           <th class="DataTable" >Var %</th>

           <th class="DataTable" >&nbsp;vs&nbsp;</th>

           <th class="DataTable" >Team</th>
           <th class="DataTable" >Today<br>Points</th>
           <th class="DataTable" >This Year<br>Sales</th>
           <th class="DataTable" >Last Year<br>Sales</th>
           <th class="DataTable" >Var %</th>

         </tr>
         <%int iPlr=0;
           for(int i=0; i < iNumOfPlr && sStr[iPlr].length > 0; i++ ){%>
           <tr>
             <td class="DataTable3" >&nbsp;<%=sStr[iPlr][0]%></td>
             <td class="DataTable2" ><%=sPlr1Scr[i]%></td>
             <td class="DataTable4" >$<%=sPlr1TySls[i]%></td>
             <td class="DataTable4" >$<%=sPlr1LySls[i]%></td>
             <td class="DataTable4" ><%=sPlr1Var[i]%>%</td>

             <th class="DataTable" >&nbsp;</th>

             <%if(sStr[iPlr+1].length <= 0) {%><td class="DataTable3" colspan=5>&nbsp;</td><%}
               else {%>
                <td class="DataTable3" >&nbsp;<%if(sStr[iPlr+1].length > 0){%><%=sStr[iPlr+1][0]%><%}%></td>
                <td class="DataTable2" ><%=sPlr2Scr[i]%></td>
                <td class="DataTable4" >$<%=sPlr2TySls[i]%></td>
                <td class="DataTable4" >$<%=sPlr2LySls[i]%></td>
                <td class="DataTable4" ><%=sPlr2Var[i]%>%</td>
             <%}%>
           </tr>
           <%iPlr += 2;%>
           <!----------------- End Store Sales --------------------->
         <%}%>
       </table>
     </td>
     <td><img src="WaterContest/Team4.jpg" width="80" height="90"></td>
     </tr>

      <!----------------------- end of Players table ------------------------>
     <tr>
      <td class="Grid" colspan="3">
       <form  method="GET" action="ShowGameTS.jsp" onSubmit="return Validate(this)">
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
