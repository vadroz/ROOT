<%@ page import="worldcup.ShowDateGame"%>
<%
    String sDate = request.getParameter("selDate");

    ShowDateGame game = new ShowDateGame(sDate);

    int iNumOfPlr = game.getNumOfPlr();
    String [] sPlayer1Str = game.getPlayer1Str();
    String [] sPlayer1Scr = game.getPlayer1Scr();
    String [] sPlayer1Sls = game.getPlayer1Sls();
    String [] sPlayer1Pln = game.getPlayer1Pln();
    String [] sPlayer1Var = game.getPlayer1Var();

    String [] sPlayer2Str = game.getPlayer2Str();
    String [] sPlayer2Scr = game.getPlayer2Scr();
    String [] sPlayer2Sls = game.getPlayer2Sls();
    String [] sPlayer2Pln = game.getPlayer2Pln();
    String [] sPlayer2Var = game.getPlayer2Var();

    int iNumOfLg = game.getNumOfLg();
    String [] sLeag1Str = game.getLeag1Str();
    String [] sLeag1Scr = game.getLeag1Scr();
    String [] sLeag1Sls = game.getLeag1Sls();
    String [] sLeag1Pln = game.getLeag1Pln();
    String [] sLeag1Var = game.getLeag1Var();

    String [] sLeag2Str = game.getLeag2Str();
    String [] sLeag2Scr = game.getLeag2Scr();
    String [] sLeag2Sls = game.getLeag2Sls();
    String [] sLeag2Pln = game.getLeag2Pln();
    String [] sLeag2Var = game.getLeag2Var();

    game.disconnect();

%>

<html>
<head>

<!-- --------------- Date Selection prompt ----------------------- -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }


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
    var minYear=2003
    var maxYear= 2003;
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
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

    <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Sun & Ski Sports
        <br>World Cup
        <br>Day Point Standings
        <br>On <%=sDate%></b>

      <!----------------- Players table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable" colspan=5>Player 1</th>
            <th class="DataTable">&nbsp;&nbsp;</th>
            <th class="DataTable" colspan=5>Player 2</th>
         </tr>
         <tr>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Total<br>Points</th>
           <th class="DataTable" >Actual<br>Sales</th>
           <th class="DataTable" >Plan<br>Sales</th>
           <th class="DataTable" >Var %</th>


           <th class="DataTable" >&nbsp;&nbsp;</th>

           <th class="DataTable" >Team</th>
           <th class="DataTable" >Total<br>Points</th>
           <th class="DataTable" >Actual<br>Sales</th>
           <th class="DataTable" >Plan<br>Sales</th>
           <th class="DataTable" >Var %</th>


         </tr>
         <%for(int i=0; i < iNumOfPlr; i++ ){%>
           <tr>
             <td class="DataTable" ><%=sPlayer1Str[i]%></td>
             <td class="DataTable2" ><%=sPlayer1Scr[i]%></td>
             <td class="DataTable1" >$<%=sPlayer1Sls[i]%></td>
             <td class="DataTable1" >$<%=sPlayer1Pln[i]%></td>
             <td class="DataTable1" ><%=sPlayer1Var[i]%>%</td>

             <th class="DataTable" >&nbsp;&nbsp;</th>

             <td class="DataTable" ><%=sPlayer2Str[i]%></td>
             <td class="DataTable2" ><%=sPlayer2Scr[i]%></td>
             <td class="DataTable1" >$<%=sPlayer2Sls[i]%></td>
             <td class="DataTable1" >$<%=sPlayer2Pln[i]%></td>
             <td class="DataTable1" ><%=sPlayer2Var[i]%>%</td>

           </tr>
         <%}%>
      </table>
      <!----------------------- end of Players table ------------------------>


      <!----------------- League table ------------------------>
      <!--table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable" colspan=5>League 1</th>
            <th class="DataTable">&nbsp;&nbsp;</th>
            <th class="DataTable" colspan=5>League 2</th>
         </tr>
         <tr>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Total<br>Points</th>
           <th class="DataTable" >Actual<br>Sales</th>
           <th class="DataTable" >Plan<br>Sales</th>
           <th class="DataTable" >Var %</th>


           <th class="DataTable" >&nbsp;&nbsp;</th>

           <th class="DataTable" >Team</th>
           <th class="DataTable" >Total<br>Points</th>
           <th class="DataTable" >Actual<br>Sales</th>
           <th class="DataTable" >Plan<br>Sales</th>
           <th class="DataTable" >Var %</th>

         </tr>
         <%for(int i=0; i < iNumOfLg; i++ ){%>
           <tr>
             <td class="DataTable" ><%=sLeag1Str[i]%></td>
             <td class="DataTable2" ><%=sLeag1Scr[i]%></td>
             <td class="DataTable1" >$<%=sLeag1Sls[i]%></td>
             <td class="DataTable1" >$<%=sLeag1Pln[i]%></td>
             <td class="DataTable1" ><%=sLeag1Var[i]%>%</td>

             <th class="DataTable" >&nbsp;&nbsp;</th>

             <td class="DataTable" ><%=sLeag2Str[i]%></td>
             <td class="DataTable2" ><%=sLeag2Scr[i]%></td>
             <td class="DataTable1" >$<%=sLeag2Sls[i]%></td>
             <td class="DataTable1" >$<%=sLeag2Pln[i]%></td>
             <td class="DataTable1" ><%=sLeag2Var[i]%>%</td>

           </tr>
         <%}%>
      </table -->
      <!----------------------- end of Leags table ------------------------>
      <form  method="GET" action="ShowDateGame.jsp" onSubmit="return Validate(this)">
          <br><font size="-1">Click here to look at selected date point standings:
          <input name="selDate" type="text" size=10 maxlength=10>
          <a href="javascript:showtip2(1, null, null, 300, 250)" >
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
