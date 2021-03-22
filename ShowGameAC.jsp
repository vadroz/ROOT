<%@ page import="worldcup.ShowGameAC, worldcup.ShowDateGameAC, worldcup.ShowBrGmAC, worldcup.ShowDateBrGmAC, java.util.*, java.text.*"%>
<%
    ShowGameAC game = new ShowGameAC();
    int iNumOfLg = game.getNumOfLg();
    String [] sLgStr = game.getLgStr();
    String [] sLgSales = game.getLgTySls();
    String sStrTotSls = game.getTotSls();
    game.disconnect();

    ShowBrGmAC brgame = new ShowBrGmAC();
    int iNumOfBrLg = brgame.getNumOfLg();
    String [] sBrLgStr = brgame.getLgStr();
    String [] sBrLgSales = brgame.getLgTySls();
    String [] sBrLgPrc = brgame.getLgPrc();
    String sBrTotSls = brgame.getTotSls();
    String sBrTotPrc = brgame.getTotPrc();

    int iNumOfDSDiv = brgame.getNumOfDiv();
    int iNumOfDSStr = brgame.getNumOfStr();
    String [] sDSDiv = brgame.getDSDiv();
    String [][] sDSStr = brgame.getDSStr();
    String [][] sDSSls = brgame.getDSSls();
    String [] sDSDivTot = brgame.getDSDivTot();
    String [] sDSStrTot = brgame.getDSStrTot();

    brgame.disconnect();

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

    ShowDateGameAC dategame = new ShowDateGameAC(sDate);

    int iNumOfPlr = dategame.getNumOfPlr();
    String [] sPlrLg = dategame.getPlrLg();
    String [] sPlrSales = dategame.getPlrSales();

    int [] iNumOfStr = dategame.getNumOfStr();
    String [][] sStr = dategame.getStr();
    String [][] sStrSales = dategame.getStrSales();
    dategame.disconnect();


    ShowDateBrGmAC brdategame = new ShowDateBrGmAC(sDate);

    int iNumOfBuyer = brdategame.getNumOfPlr();
    String [] sBrPlrLg = brdategame.getPlrLg();
    String [] sBrPlrSales = brdategame.getPlrSales();
    String [] sBrPlrPrc = brdategame.getPlrPrc();

    int [] iNumOfDiv = brdategame.getNumOfDiv();
    String [][] sDiv = brdategame.getDiv();
    String [][] sDivName = brdategame.getDivName();
    String [][] sDivSales = brdategame.getDivSales();
    brdategame.disconnect();
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
        th.DataTable1 { background:white;padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px; border-bottom: darkred solid 1px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }



        td.DataTable { background:#E7E7E7; padding-top:3px; padding-bottom:3px;
                       padding-right:3px; padding-left:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left; font-family:Arial; font-size:10px }

        td.DataTable1 { background:#E7E7E7; padding-top:3px; padding-bottom:3px;
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

        tr.DataTable { background:#E7E7E7; text-align:right; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:GhostWhite; text-align:right; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#c3fdb8 ; text-align:right; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:cornsilk; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable5 { border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}


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
        <br><font size="+1">Aged Inventory Sales Contest</font>
        <br>Starts on 8/14/2006<br><br>
       </b>
     </tr>
<!-------------------------------------------------------------------->
      <tr>
      <td class="Grid" width="60%"><b>Store Contest - accumulative</b><br>

      <!----------------- Leage ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>
           <th class="DataTable" >vs</th>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>

           <th class="DataTable1" colspan=2 rowspan=2><%for(int k=0; k < 40; k++){%>&nbsp;<%}%></th>

           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>
           <th class="DataTable" >vs</th>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>
         </tr>

           <tr>
             <td class="DataTable" ><%=sLgStr[0]%></td>
             <td class="DataTable1" >$<%=sLgSales[0]%></td>
             <th class="DataTable" >&nbsp;</th>
             <td class="DataTable" ><%=sLgStr[1]%></td>
             <td class="DataTable1" >$<%=sLgSales[1]%></td>

             <td class="DataTable" ><%=sLgStr[2]%></td>
             <td class="DataTable1" >$<%=sLgSales[2]%></td>
             <th class="DataTable" >&nbsp;</th>
             <td class="DataTable" ><%=sLgStr[3]%></td>
             <td class="DataTable1" >$<%=sLgSales[3]%></td>
           </tr>
         <!-----------------------  Total -------------------------------->
         <tr>
             <td class="DataTable2" colspan=6 >Total</td>
             <td class="DataTable2" colspan=6 >$<%=sStrTotSls%></td>
           </tr>
       </table>
     </td>
     </tr>


     <!-------------------------------------------------------------------->
      <tr>
      <td class="Grid" width="60%"><br><b>Store Daily Details - <%=sDate%></b>
      <!----------------- Leage 1 of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>
           <th class="DataTable" >vs</th>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>
           <th class="DataTable1" ><%for(int k=0; k < 40; k++){%>&nbsp;<%}%></th>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>
           <th class="DataTable" >vs</th>
           <th class="DataTable" >Team</th>
           <th class="DataTable" >Sales</th>
         </tr>
         <!----------------- Store Sales ------------------------>
         <%if(sPlrLg.length > 0) {%>
           <%for(int j=0; j < iNumOfStr[0]; j++ ){%>
             <tr>
                <td class="DataTable">Store: <%=sStr[0][j]%></td>
                <td class="DataTable1" >$<%=sStrSales[0][j]%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable">Store: <%=sStr[1][j]%></td>
                <td class="DataTable1" >$<%=sStrSales[1][j]%></td>
                <th class="DataTable1" >&nbsp;</th>
                <td class="DataTable">Store: <%=sStr[2][j]%></td>
                <td class="DataTable1" >$<%=sStrSales[2][j]%></td>
                <th class="DataTable" >&nbsp;</th>
                <%if(j < 3) {%>
                  <td class="DataTable">Store: <%=sStr[3][j]%></td>
                  <td class="DataTable1" >$<%=sStrSales[3][j]%></td>
                <%} else {%><td class="DataTable" colspan=2>&nbsp;</td><%}%>
             </tr>
           <%}%>
           <tr>
             <td class="DataTable3" ><%=sPlrLg[0]%></td>
             <td class="DataTable4" >$<%=sPlrSales[0]%></td>
             <th class="DataTable" >vs</th>
             <td class="DataTable3" ><%=sPlrLg[1]%></td>
             <td class="DataTable4" >$<%=sPlrSales[1]%></td>
             <th class="DataTable1" >&nbsp;</th>
             <td class="DataTable3" ><%=sPlrLg[2]%></td>
             <td class="DataTable4" >$<%=sPlrSales[2]%></td>
             <th class="DataTable" >vs</th>
             <td class="DataTable3" ><%=sPlrLg[3]%></td>
             <td class="DataTable4" >$<%=sPlrSales[3]%></td>
         </tr>
         <%}%>
          <!----------------- End Store Sales --------------------->
       </table>
     </tr>

     <tr><td style="border-bottom: darkred solid 1px;">&nbsp;</td></tr>



      <!----------------------- end of Players table ------------------------>
     <tr>
      <td class="Grid" colspan="3">
       <form  method="GET" action="ShowGameAC.jsp" onSubmit="return Validate(this)">
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
