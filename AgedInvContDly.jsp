  <%@ page import="worldcup.AgedInvContDly , java.util.*"%>
<%
    String sDate = request.getParameter("Date");

    AgedInvContDly agegame = new AgedInvContDly(sDate);
    int iNumOfStr = agegame.getNumOfStr();
    String sStr1 = agegame.getStr1();

    // Contest results
    String sStr1AgeSls = agegame.getStr1AgeSls();
    String sStr1SlsPrc = agegame.getStr1SlsPrc();
    String sStr1AgePrc = agegame.getStr1AgePrc();
    String sStr1Score1 = agegame.getStr1Score1();
    String sStr1Score2 = agegame.getStr1Score2();
    String sStr1Score3 = agegame.getStr1Score3();
    String sStr1TotScore = agegame.getStr1TotScore();

    String sStr2 = agegame.getStr2();
    String sStr2AgeSls = agegame.getStr2AgeSls();
    String sStr2SlsPrc = agegame.getStr2SlsPrc();
    String sStr2AgePrc = agegame.getStr2AgePrc();
    String sStr2Score1 = agegame.getStr2Score1();
    String sStr2Score2 = agegame.getStr2Score2();
    String sStr2Score3 = agegame.getStr2Score3();
    String sStr2TotScore = agegame.getStr2TotScore();

    String sStr1AgeInv = agegame.getStr1AgeInv();
    String sStr1StrSls = agegame.getStr1StrSls();
    String sStr2AgeInv = agegame.getStr2AgeInv();
    String sStr2StrSls = agegame.getStr2StrSls();

    // Contest totals
    int iNumOfPlr = agegame.getNumOfPlr();
    String sContTotStr = agegame.getContTotStr();
    String sContTotAgeSls = agegame.getContTotAgeSls();
    String sContTotSlsPrc = agegame.getContTotSlsPrc();
    String sContTotAgePrc = agegame.getContTotAgePrc();
    String sContTotScore1 = agegame.getContTotScore1();
    String sContTotScore2 = agegame.getContTotScore2();
    String sContTotScore3 = agegame.getContTotScore3();
    String sContTotScore = agegame.getContTotScore();
    String sContTotLyAgeSls = agegame.getContTotLyAgeSls();
    String sContTotLeage = agegame.getContTotLeage();
    String sContTotStrSls = agegame.getContTotStrSls();
    String sContTotAgeInv = agegame.getContTotAgeInv();

    agegame.disconnect();
    agegame = null;
%>
<SCRIPT language="JavaScript1.2">

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   var html = "<table border=0 cellPadding='0' cellSpacing='0'>"
      + "<tr style='vertical-align:top;'>"
        + "<td >" + setDailyStoreContest() + "</td>"
        + "<td>&nbsp; &nbsp; &nbsp;</td>"
        + "<td>" + setStoreContestTotal() + "</td>"
      + "</tr>"
    + "</table>"

   document.write(html)
   //parent.showAgedInvContest(html);
}

// ------------------------------------------------------
// set Daily Store Contest
// ------------------------------------------------------
function setDailyStoreContest()
{
   var NumOfPlr = <%=iNumOfPlr%>;
   var Str1 = [<%=sStr1%>];
   var Str1AgeSls = [<%=sStr1AgeSls%>];
   var Str1SlsPrc = [<%=sStr1SlsPrc%>];
   var Str1AgePrc = [<%=sStr1AgePrc%>];
   var Str1Score1 = [<%=sStr1Score1%>];
   var Str1Score2 = [<%=sStr1Score2%>];
   var Str1Score3 = [<%=sStr1Score3%>];
   var Str1TotScore = [<%=sStr1TotScore%>];
   var Str1AgeInv = [<%=sStr1AgeInv%>];
   var Str1StrSls = [<%=sStr1StrSls%>];

   var Str2 = [<%=sStr2%>];
   var Str2AgeSls = [<%=sStr2AgeSls%>];
   var Str2SlsPrc = [<%=sStr2SlsPrc%>];
   var Str2AgePrc = [<%=sStr2AgePrc%>];
   var Str2Score1 = [<%=sStr2Score1%>];
   var Str2Score2 = [<%=sStr2Score2%>];
   var Str2Score3 = [<%=sStr2Score3%>];
   var Str2TotScore = [<%=sStr2TotScore%>];
   var Str2AgeInv = [<%=sStr2AgeInv%>];
   var Str2StrSls = [<%=sStr2StrSls%>];

   var html = "<table class='DataTable' cellPadding='0' cellSpacing='0'>"
   html += "<tr class='TblHdr'>"
            +  "<td class='DataTable3' colspan=23>Daily Contest Result - <%=sDate%> (94 cents ending)</td>"
         + "</tr>"
         + "<tr class='TblHdr'>"
            +  "<td class='DataTable3' colspan=11>Player 1</td>"
            +  "<td class='DataTable3' rowspan=2>&nbsp;</td>"
            +  "<td class='DataTable3' colspan=11>Player 2</td>"
         + "</tr>"
            + "<tr class='TblHdr'>"
            +  "<td class='DataTable3'>Store</td>"
            + "<td class='DataTable3'>Total<br>Sales</td>"
            + "<td class='DataTable3'>Aged<br>Sales<br>$.94 ending</td>"
            + "<td class='DataTable3'>Aged<br>Inv $<br>$.94 ending</td>"
            + "<td class='DataTable3'>Daily<br>Sls<br>%</td>"
            + "<td class='DataTable3'>Aged<br>Sls<br>%<br>$.94 ending</td>"
            + "<td class='DataTable3'>&nbsp;</td>"
            + "<td class='DataTable3'>Aged<br>Sls<br>Scores<br>$.94 ending</td>"
            + "<td class='DataTable3'>Daily<br>Sls<br>Scores</td>"
            + "<td class='DataTable3'>Aged<br>Sls<br>Scores<br>$.94 ending</td>"
            + "<td class='DataTable3'>Total<br>Scores</td>"

            + "<td class='DataTable3'>Store</td>"
            + "<td class='DataTable3'>Total<br>Sales</td>"
            + "<td class='DataTable3'>Aged<br>Sales</td>"
            + "<td class='DataTable3'>Aged<br>Inv $<br>$.94 ending</td>"
            + "<td class='DataTable3'>Daily<br>Sls<br>%</td>"
            + "<td class='DataTable3'>Aged<br>Sls<br>%<br>$.94 ending</td>"
            + "<td class='DataTable3'>&nbsp;</td>"
            + "<td class='DataTable3'>Aged<br>Sls<br>Scores<br>$.94 ending</td>"
            + "<td class='DataTable3'>Daily<br>Sls<br>Scores</td>"
            + "<td class='DataTable3'>Aged<br>Sls<br>Scores<br>$.94 ending</td>"
            + "<td class='DataTable3'>Total<br>Scores</td>"
          + "</tr>"

   // store details
   for(var i=0; i < NumOfPlr; i++ )
   {
      if(Str1[i] == "Total") { html += "<tr class='DataTable2'>"; }
      else { html += "<tr class='DataTable'>"; }

      html +=  "<td class='DataTable4'>" + Str1[i] + "</td>"
             + "<td class='DataTable4'>$" + Str1StrSls[i] + "</td>"
             + "<td class='DataTable4'>$" + Str1AgeSls[i] + "</td>"
       if(Str1[i] != "Total")
       {
           html += "<td class='DataTable4'><a href='AgedInvList.jsp?Str=" + Str1[i] + "' target='_blank'>$" + Str1AgeInv[i] + "</a></td>"
       }
       else
       {
           html += "<td class='DataTable4'>$" + Str1AgeInv[i] + "</td>"
       }

      html += "<td class='DataTable4'>" + Str1SlsPrc[i] + "%</td>"
             + "<td class='DataTable4'>" + Str1AgePrc[i] + "%</td>"
             + "<td class='DataTable4'>&nbsp;</td>"
             + "<td class='DataTable4'>" + Str1Score1[i] + "</td>"
             + "<td class='DataTable4'>" + Str1Score2[i] + "</td>"
             + "<td class='DataTable4'>" + Str1Score3[i] + "</td>"
             + "<td class='DataTable4'>" + Str1TotScore[i] + "</td>"

      if(Str1[i] != "Total")
      {
         html += "<td class='DataTable4'>&nbsp;</td>"
             + "<td class='DataTable4' nowrap>" + Str2[i] + "</td>"
             + "<td class='DataTable4'>$" + Str2StrSls[i] + "</td>"
             + "<td class='DataTable4'>$" + Str2AgeSls[i] + "</td>"

         if(Str1[i] != "Total")
         {
           html += "<td class='DataTable4'><a href='AgedInvList.jsp?Str=" + Str2[i] + "' target='_blank'>$" + Str2AgeInv[i] + "</a></td>"
         }
         else
         {
             html += "<td class='DataTable4'>$" + Str2AgeInv[i] + "</td>"
         }

         html += "<td class='DataTable4'>" + Str2SlsPrc[i] + "%</td>"
             + "<td class='DataTable4'>" + Str2AgePrc[i] + "%</td>"
             + "<td class='DataTable4'>&nbsp;</td>"
             + "<td class='DataTable4'>" + Str2Score1[i] + "</td>"
             + "<td class='DataTable4'>" + Str2Score2[i] + "</td>"
             + "<td class='DataTable4'>" + Str2Score3[i] + "</td>"
             + "<td class='DataTable4'>" + Str2TotScore[i] + "</td>"
      }
      else { html += "<td class='DataTable4' colspan=12>&nbsp;</td>" }

      html += "</tr>"
   }

   html += "</table>"
     //+ "<br><a href='AgedInvContDiv.jsp?Div=ALL&Dpt=ALL'>Contest Result by Division</a>"

   return html;
}

// ------------------------------------------------------
// set Store Contest Total Scores
// ------------------------------------------------------
function setStoreContestTotal()
{
   var NumOfStr = <%=iNumOfStr%>;
   var ContTotStr = [<%=sContTotStr%>];
   var ContTotLeage = [<%=sContTotLeage%>];
   var ContTotAgeSls = [<%=sContTotAgeSls%>];
   var ContTotSlsPrc = [<%=sContTotSlsPrc%>];
   var ContTotAgePrc = [<%=sContTotAgePrc%>];
   var ContTotScore1 = [<%=sContTotScore1%>];
   var ContTotScore2 = [<%=sContTotScore2%>];
   var ContTotScore3 = [<%=sContTotScore3%>];
   var ContTotScore = [<%=sContTotScore%>];
   var ContTotLyAgeSls = [<%=sContTotLyAgeSls%>];
   var ContTotAgeInv = [<%=sContTotAgeInv%>];
   var ContTotStrSls = [<%=sContTotStrSls%>];

   var html = "<table class='DataTable' cellPadding='0' cellSpacing='0'>"
   html += "<tr class='TblHdr'>"
            +  "<td class='DataTable3' colspan=19>Total Contest Result &nbsp; "
              + "<a href='javascript:dispTotContDtl()'>fold/unfold</a>"
            + "</td>"
         + "</tr>"
         + "</tr>"
            + "<tr class='TblHdr'>"
            +  "<td class='DataTable3'>Standings</td>"
            +  "<td class='DataTable3'>Store</td>"
            + "<td class='DataTable3' id='TotAge'>Total<br>Sales</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sales</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Inv $</td>"
            + "<td class='DataTable3' id='TotAge'>Daily<br>Sls<br>%</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sls<br>%</td>"
            + "<td class='DataTable3' id='TotAge'>&nbsp;</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sls<br>Scores</td>"
            + "<td class='DataTable3' id='TotAge'>Daily<br>Sls<br>Scores</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sls<br>Scores</td>"
            + "<td class='DataTable3'>Total<br>Scores</td>"
            //+ "<td class='DataTable3' id='TotAge'>LY<br>Aged<br>Sales</td>"
          + "</tr>"

   // store details
   for(var i=0, j=1; i < NumOfStr; i++, j++ )
   {
      if(ContTotStr[i] == "Total") { html += "<tr class='DataTable5'>"; }
      else if(ContTotLeage[i] == "A") { html += "<tr class='DataTable' style='background:lightgreen'>"; }
      else if(ContTotLeage[i] == "B") { html += "<tr class='DataTable' style='background:lightblue'>"; }
      else if(ContTotLeage[i] == "C") { html += "<tr class='DataTable' style='background:salmon'>"; }

      html += "<td class='DataTable4'>"
      if(ContTotStr[i] != "Total" && ContTotStr[i].indexOf("Grp") < 0) { html += (j) } else { html += "&nbsp;" }
      html += "</td>"

      html += "<td class='DataTable4' nowrap>" + ContTotStr[i] + "</td>"
             + "<td class='DataTable4' id='TotAge'>$" + ContTotStrSls[i] + "</td>"
             + "<td class='DataTable4' id='TotAge'>$" + ContTotAgeSls[i] + "</td>"

      if(ContTotStr[i] != "Total" && ContTotStr[i].indexOf("Grp") < 0) {
         html += "<td class='DataTable4' id='TotAge'>"
              + "<a href='AgedInvList.jsp?Str=" + ContTotStr[i] + "' target='_blank'>$" + ContTotAgeInv[i] + "</a>"
              + "</td>"
      } else
      {
          html += "<td class='DataTable4' id='TotAge'>$" + ContTotAgeInv[i] + "</td>"
      }

      html += "<td class='DataTable4' id='TotAge'>" + ContTotSlsPrc[i] + "%</td>"
             + "<td class='DataTable4' id='TotAge'>" + ContTotAgePrc[i] + "%</td>"
             + "<td class='DataTable4' id='TotAge'>&nbsp;</td>"
             + "<td class='DataTable4' id='TotAge'>" + ContTotScore1[i] + "</td>"
             + "<td class='DataTable4' id='TotAge'>" + ContTotScore2[i] + "</td>"
             + "<td class='DataTable4' id='TotAge'>" + ContTotScore3[i] + "</td>"
             + "<td class='DataTable4'>" + ContTotScore[i] + "</td>"
             //+ "<td class='DataTable4' id='TotAge'>$" + ContTotLyAgeSls[i] + "</td>"
         + "</tr>"

      if(ContTotStr[i].indexOf("Grp") >= 0)
      {
        html += "<tr style='background:green;font-size:1px;'><td colspan=12>&nbsp;</td></tr>";
        j = 0;
      }
   }



   html += "</table>"
   return html;
}
</SCRIPT>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        table.Prompt { border: gray groove 1px;}

        tr.TblHdr { background:#FFE4C4; font-family:Verdanda; font-size:10px }

        tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:PaleTurquoise; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:cornsilk; font-size:1px}
        tr.DataTable5 { background:khaki; font-family:Arial; font-size:10px }
        tr.DataTable6 { background:#fdd017; font-family:Arial; font-size:10px }
        tr.DataTable7 { background:#cccfff; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                        border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                        text-align:right;}
        td.DataTable1 { padding-top:2px; padding-bottom:2px; padding-left:2px;
                       padding-right:2px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left;}
        td.DataTable2 { padding-top:1px; padding-right:1px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

        td.DataTable3 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable31 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 2px;
                       text-align:center;}
        td.DataTable312 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 2px;
                       text-align:center; }
        td.DataTable313 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: blue solid 2px;
                       text-align:center;}

        td.DataTable32 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; }

        td.DataTable4 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable404 { background:#fdd017; color:green; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable405 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:center;}

        td.DataTable41 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:center;}
        td.DataTable413 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: blue solid 2px;
                       text-align:center;}
        td.DataTable414 { background:#fdd017; color:green; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:center;}
        td.DataTable415 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:center;}

        td.DataTable6 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;}

        td.DataTable7 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable71 { color: red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:center;}
        td.DataTable712 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable713 {  color: red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: blue solid 2px;
                       text-align:center;}
        td.DataTable714 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:center;}
        .Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:2px; font-family:Arial; font-size:10px }

</style>



