  <%@ page import="menu.SalesChallenge , java.util.*"%>
<%
    String sSort = request.getParameter("Sort");
    if (sSort == null) sSort = "VAR";

    // Charts and table for div 1 challenage
    SalesChallenge slschell = new SalesChallenge(sSort);
    String sTySales = slschell.getTySales();
    String sLySales = slschell.getLySales();
    String sTyPos = slschell.getTyPos();
    String sLyPos = slschell.getLyPos();
    String sVar = slschell.getVar();
    String sAsOfDate = slschell.getAsOfDate();

    int iNumOfStr = slschell.getNumOfStr();
    String sStr = slschell.getStr();
    String sStrTySales = slschell.getStrTySales();
    String sStrLySales = slschell.getStrLySales();
    String sStrVar = slschell.getStrVar();

    String sTotTySales = slschell.getTotTySales();
    String sTotLySales = slschell.getTotLySales();
    String sTotVar = slschell.getTotVar();

    String sTotTyTo17M = slschell.getTotTyTo17M();
    String sTotLyToEOY = slschell.getTotLyToEOY();
    String sIncrease17M = slschell.getIncrease17M();
    String sIncrease17HM = slschell.getIncrease17HM();
    String sIncrease18M = slschell.getIncrease18M();
    String sTotPlan = slschell.getTotPlan();

    slschell.disconnect();
    slschell = null;
%>
<SCRIPT language="JavaScript1.2">

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.showThermometer(setThermometer());
   parent.showDiv1Sls(setDiv1Sls());
   parent.showSlsIncrease(setSlsIncrease());
   parent.showAsOfDate(" As of <%=sAsOfDate%>");
   //parent.document.all.spanChall.innerHTML = setStrIncentSel();
}

// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function setDiv1Sls()
{
   var NumOfStr = <%=iNumOfStr%>;
   var Store = [<%=sStr%>];
   var TySales = [<%=sStrTySales%>];
   var LySales = [<%=sStrLySales%>];
   var Var = [<%=sStrVar%>];

   var TotTySales = "<%=sTotTySales%>";
   var TotLySales = "<%=sTotLySales%>";
   var TotVar = "<%=sTotVar%>";

   var html = "<span id='spanChall' style='font-size:10px'></span><br>"
      + "<table class='Therm' cellPadding='0' cellSpacing='0'>"
   html += "<tr class='Div1Sls1'>"
         +  "<th class='Div1Sls'><a href='javascript: rtvDiv1Sls(&#34;STR&#34;)'>Store</a></th>"
         +  "<th class='Div1Sls'>This Year</th>"
         +  "<th class='Div1Sls'>Plan</th>"
         + "<th class='Div1Sls'><a href='javascript: rtvDiv1Sls(&#34;VAR&#34;)'>Var</a></th>"
   // store details
   for(var i=0; i < NumOfStr; i++ )
   {
      if(Var[i] > 0) html += "<tr class='Div1Sls'>";
      else  html += "<tr class='Div1Sls3'>";
      html +=  "<td class='Div1Sls'>" + Store[i] + "</td>"
         +  "<td class='Div1Sls'>$" + TySales[i] + "</td>"
         +  "<td class='Div1Sls'>$" + LySales[i] + "</td>"
         + "<td class='Div1Sls'>" + Var[i] + "%</td>"

   }

   // totals
   html += "<tr class='Div1Sls2'>"
         +  "<td class='Div1Sls'>Total</td>"
         +  "<td class='Div1Sls'>$" + TotTySales + "</td>"
         +  "<td class='Div1Sls'>$" + TotLySales + "</td>"
         + "<td class='Div1Sls'  nowrap>" + TotVar + "%</td>"

   html += "</table>"
   return html;
}

// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
/*function setThermometer()
{
   var TySales = "<%=sTySales%>";
   var LySales = "<%=sLySales%>";
   var TyPos = "<%=sTyPos%>";
   var LyPos = "<%=sLyPos%>";
   var Var = "<%=sVar%>"
   var TotPlan = Math.round(eval(<%=sTotPlan%>) / 1000000);

   var html = "<table class='Therm' cellPadding='0' cellSpacing='0'>"
   html += "<tr class='Therm'>"
         +  "<td class='Therm41'>TY</td>"
         + "<td class='Therm41'>&nbsp;</td>"
         +  "<td class='Therm41'>Plan</td>"
         + "<td class='Therm41'>&nbsp;</td>"

   for(var i=0, j=TotPlan * 10, k=0, l=TotPlan; i < TotPlan * 10; i++, j--)
   {
      html += "<tr class='Therm'>"
      if(TyPos >= j) { html += "<td class='Therm1' width='20px'>&nbsp;</td>" }
      else { html += "<td class='Therm3' width='20px'>&nbsp;</td>" }

      // divider
      html += "<td class='Therm3' width='5px'>&nbsp;</td>"

      if(LyPos >= j) { html += "<td class='Therm2' width='20px'>&nbsp;</td>" }
      else { html += "<td class='Therm3' width='20px'>&nbsp;</td>" }

      // divider
      if(k == 10){ k = 0;}

      if(i==0 && k == 0) { html += "<td class='Therm51' rowspan='10'>$" + l + "M</td>";}
      else if(k == 0) { html += "<td class='Therm5' rowspan='10'>$" + l + "M</td>";}

      if(k == 0) {l--;}
      k++;

      html += "</tr>"
   }
   html += "<tr class='Therm'>"
         +  "<td class='Therm42' nowrap>This Year<br>$" + TySales + "</td>"
         + "<td class='Therm42' nowrap>&nbsp;</td>"
         +  "<td class='Therm42' nowrap>Plan<br>$" + LySales + "</td>"
         +  "<td class='Therm42' nowrap>Var<br>&nbsp;&nbsp;&nbsp;" + Var + "%</td>"
   html += "</table>"

   return html;
}
*/
// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function setThermometer()
{
   var TySales = "<%=sTySales%>";
   var LySales = "<%=sLySales%>";

   var TyPos = "<%=sTyPos%>";
   var LyPos = "<%=sLyPos%>";
   var Var = "<%=sVar%>"
   var TotPlan = Math.round(26);
   var TotPlan2 = Math.round(13);

   var html = "<table class='Therm' cellPadding='0' cellSpacing='0'>"
   html += "<tr class='Therm'>"
         +  "<td class='Therm41'>TY</td>"
         + "<td class='Therm41'>&nbsp;</td>"
         +  "<td class='Therm41'>Plan</td>"
         + "<td class='Therm41'>&nbsp;</td>"

   var done = false;
   for(var i=0, j=TotPlan2 * 10, k=0, l=TotPlan, m=TotPlan2 * 10; i < TotPlan2 * 10; i++, j--, m--)
   {
      html += "<tr class='Therm'>"
      if(TyPos >= j || i == TotPlan2 * 10 - 1) { html += "<td class='Therm1' width='20px'>&nbsp;</td>" }
      else { html += "<td class='Therm3' width='20px'>&nbsp;</td>" }

      // divider
      html += "<td class='Therm3' width='5px'>&nbsp;</td>"

      if(LyPos >= m || i == TotPlan2 * 10 - 1) { html += "<td class='Therm2' width='20px'>&nbsp;</td>"; }
      else { html += "<td class='Therm3' width='20px'>&nbsp;</td>" }

      // divider
      if(k == 10){ k = 0;}

      if(i==0 && k == 0) { html += "<td class='Therm51' rowspan='10'>$" + l + "M</td>";}
      else if(k == 0) { html += "<td class='Therm5' rowspan='10'>$" + l + "M</td>";}

      if(k == 0) {l--;l--;}
      k++;

      html += "</tr>"
   }
   html += "<tr class='Therm'>"
         +  "<td class='Therm42' nowrap>This Year<br>$" + TySales + "</td>"
         + "<td class='Therm42' nowrap>&nbsp;</td>"
         +  "<td class='Therm42' nowrap>Plan<br>$" + LySales + "</td>"
         +  "<td class='Therm42' nowrap>Var<br>&nbsp;&nbsp;&nbsp;" + Var + "%</td>"
   html += "</table>"

   return html;
}
// ------------------------------------------------------
// Increase in Sales required for 17M challenge
// ------------------------------------------------------
function setSlsIncrease()
{
   var TySales = "<%=sTySales%>";
   var LySales = "<%=sLySales%>";
   var Var = "<%=sVar%>"

   var TotTyTo17M = "<%=sTotTyTo17M%>"
   var TotLyToEOY = "<%=sTotLyToEOY%>"
   var Increase17M = "<%=sIncrease17M%>"
   var Increase17HM = "<%=sIncrease17HM%>"
   var Increase18M = "<%=sIncrease18M%>"
   var TotPlan = "<%=sTotPlan%>"

   var html="<table class='Therm' cellPadding='0' cellSpacing='0'>"

   html += "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1  '>January-February Sales TY</th>"
           +  "<td class='Div1Sls'>$" + TySales + "</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1  '>January-February Plan</th>"
           +  "<td class='Div1Sls'>$" + LySales + "</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1'>January-February increase over plan</th>"
           +  "<td class='Div1Sls'>" + Increase17M + "%</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1'>Sales needed to reach plan</th>"
           +  "<td class='Div1Sls1'>$" + TotTyTo17M + "</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1'>Plan for remainder of contest</th>"
           +  "<td class='Div1Sls1'>$" + TotLyToEOY + "</td>"
         + "</tr>"
         + "<tr class='Div1Sls21'>"
           +  "<th class='Div1Sls1'>% increase needed for remainder <br> of year to reach Gold</th>"
           +  "<td class='Div1Sls11'>" + Increase17HM + "%</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1'>% increase needed for remainder <br> of year to reach Silver</th>"
           +  "<td class='Div1Sls11'>" + Increase18M + "%</td>"
         + "</tr>"

   html += "</table>"
   return html;
}

// ------------------------------------------------------
// Set store selection
// ------------------------------------------------------
function setStrIncentSel()
{
   var html = null;
   var NumOfStr = <%=iNumOfStr%>;
   var Store = [<%=sStr%>];
   Store.sort(numOrdA);
   var dummy = "<select><select>"
   html = "<br><b><u>Store Employee Incentives</u></b><br>"
        + "Store (All Weeks) <select id='selStr' style='font-size:10px'>"

   // store details
   for(var i=0; i < NumOfStr; i++ )
   {
      html +=  "<option>" + Store[i] + "</option>"
   }

   html += "</select>&nbsp;"
         + "<button onClick='showStoreScores(&#34;S&#34;)'>Go</button>"

   // weekends
   html += "<br>&nbsp; &nbsp; &nbsp;- or - <br>Week (All Store) <select id='selWeek' style='font-size:10px'>"

   var date = new Date("10/25/2010");
   var toDate = new Date("03/27/2011");
   var today = new Date();
   date.setHours(18);
   var selected = false;
   var select = '';

   while(date <= toDate)
   {
      if(!selected && date >= today){ selected = true; select = 'selected'; }
      else {select = ''; }

      html +=  "<option " + select + " >" + (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() + "</option>"
      date = new Date(date - (-7) * 86400000);
   }

   html += "</select>&nbsp;"
         + "<button onClick='showStoreScores(&#34;W&#34;)'>Go</button>"

   return html;
}
// ------------------------------------------------------
// sort numeric array
// ------------------------------------------------------
function numOrdA(a, b){ return (eval(a) - eval(b)); }

</SCRIPT>







