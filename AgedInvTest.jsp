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
%>

<style type="text/css">
  table.DataTable { text-align:center;}

  tbody.GrpA { }

  tr.DataTable { font-family:Verdanda; text-align:center; font-size:12px;}
  tr.DataTable5 { font-family:Verdanda; text-align:left; font-size:12px;
   filter: "progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#81a8cb', endColorstr='#4477a1')";
  }
  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
  td.DataTable3 { padding:15px;
    color:#fff;
    text-shadow:1px 1px 1px #568F23;
    border:1px solid #93CE37;
    border-bottom:3px solid #9ED929;
    background-color:#9DD929;
    background:-webkit-gradient( linear, left bottom, left top, color-stop(0.02, rgb(123,192,67)),
    color-stop(0.51, rgb(139,198,66)),
    color-stop(0.87, rgb(158,217,41)));
    background: -moz-linear-gradient(
    center bottom,
    rgb(123,192,67) 2%,
    rgb(139,198,66) 51%,
    rgb(158,217,41) 87% );
    -webkit-border-top-left-radius:5px;
    -webkit-border-top-right-radius:5px;
    -moz-border-radius:5px 5px 0px 0px;
    border-top-left-radius:5px;
    border-top-right-radius:5px;
  }
  td.DataTable4 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}

</style>




<SCRIPT language="JavaScript1.2">

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   var html = "<table border=0 cellPadding='0' cellSpacing='0'>"
      + "<tr style='vertical-align:top;'>"
        //+ "<td >" + setDailyStoreContest() + "</td>"
        //+ "<td>&nbsp; &nbsp; &nbsp;</td>"
        + "<td>" + setStoreContestTotal() + "</td>"
      + "</tr>"
    + "</table>"

   document.write(html)
   //parent.showAgedInvContest(html);
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
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sales</td>"
            + "<td class='DataTable3' id='TotAge'>Daily<br>Sls<br>%</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sls<br>%</td>"
            + "<td class='DataTable3' id='TotAge'>&nbsp;</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sls<br>Scores</td>"
            + "<td class='DataTable3' id='TotAge'>Daily<br>Sls<br>Scores</td>"
            + "<td class='DataTable3' id='TotAge'>Aged<br>Sls<br>Scores</td>"
            + "<td class='DataTable3'>Total<br>Scores</td>"
            //+ "<td class='DataTable3' id='TotAge'>LY<br>Aged<br>Sales</td>"
          + "</tr>"

   html += "<tbody class='GrpA'>";

   // store details
   for(var i=0, j=1; i < NumOfStr; i++, j++ )
   {
      if(ContTotStr[i] == "Total") { html += "</tbody><tr class='DataTable5' style=''>"; }
      else if(ContTotLeage[i] == "A") { html += "<tr class='DataTable'>"; }
      else if(ContTotLeage[i] == "B") { html += "<tr class='DataTable'>"; }
      else if(ContTotLeage[i] == "C") { html += "<tr class='DataTable'>"; }

      html += "<td class='DataTable4'>"
      if(ContTotStr[i] != "Total" && ContTotStr[i].indexOf("Grp") < 0) { html += (j) } else { html += "&nbsp;" }
      html += "</td>"

      html += "<td class='DataTable4'>" + ContTotStr[i] + "</td>"
             + "<td class='DataTable4' id='TotAge'>$" + ContTotAgeSls[i] + "</td>"
             + "<td class='DataTable4' id='TotAge'>" + ContTotSlsPrc[i] + "%</td>"
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
        html += "<tr style='background:green;font-size:1px;'><td colspan=10>&nbsp;</td></tr>";
        j = 0;
        html += "</tbody>";
        if(ContTotLeage[i] == "A") { html += "<tbody style='filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=lightblue, endColorStr=blue, gradientType=0'>"; }
        else if(ContTotLeage[i] == "B") { html += "<tbody style='background:salmon'>"; }
      }
   }

   html += "</table>"
   return html;
}
</SCRIPT>





