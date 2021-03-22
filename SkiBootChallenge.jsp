  <%@ page import="menu.SkiBootChallenge , java.util.*"%>
<%
    String sSort = request.getParameter("Sort");
    if (sSort == null) sSort = "VAR";

    // Charts and table for div 1 challenage
    SkiBootChallenge slschell = new SkiBootChallenge(sSort);
    String sTySales = slschell.getTySales();
    String sLySales = slschell.getLySales();
    String sTyPos = slschell.getTyPos();
    String sLyPos = slschell.getLyPos();
    String sVar = slschell.getVar();
    String sAsOfDate = slschell.getAsOfDate();

    String sTotTyTo10M = slschell.getTotTyTo10M();
    String sTotLyToEOY = slschell.getTotLyToEOY();
    String sIncrease10M = slschell.getIncrease10M();

    int iNumOfStr = slschell.getNumOfStr();
    String sStr = slschell.getStr();
    String sStrTySales = slschell.getStrTySales();
    String sStrLySales = slschell.getStrLySales();
    String sStrVar = slschell.getStrVar();

    String sTotTySales = slschell.getTotTySales();
    String sTotLySales = slschell.getTotLySales();
    String sTotVar = slschell.getTotVar();

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
   parent.showSkiBootChart(setThermometer());
   parent.showSkiBootIncrease(setSlsIncrease());
   parent.showSkiBootSls(setSkiBootSls());
   //parent.showAsOfDate(" As of <%=sAsOfDate%>");
}

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

   var html = "<table class='Therm' cellPadding='0' cellSpacing='0'>"
   html += "<tr class='Therm'>"
         +  "<td class='Therm41'>TY</td>"
         + "<td class='Therm41'>&nbsp;</td>"
         +  "<td class='Therm41'>LY</td>"
         + "<td class='Therm41'>&nbsp;</td>"

   for(var i=0, j=5 * 10, k=0, l=2; i < 5 * 10; i++, j--)
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

      if(k == 0) {l = (l - 2/5).toFixed(1);}
      k++;

      html += "</tr>"
   }
   html += "<tr class='Therm'>"
         +  "<td class='Therm42'>This Year<br>$" + TySales + "</td>"
         + "<td class='Therm42'>&nbsp;</td>"
         +  "<td class='Therm42'>Last Year<br>$" + LySales + "</td>"
         +  "<td class='Therm42'>Var<br>&nbsp;&nbsp;&nbsp;" + Var + "%</td>"
   html += "</table>"

   return html;
}
// ------------------------------------------------------
// Increase in Sales required for 10M challenge
// ------------------------------------------------------
function setSlsIncrease()
{
   var TySales = "<%=sTySales%>";
   var LySales = "<%=sLySales%>";
   var Var = "<%=sVar%>"

   var TotTyTo10M = "<%=sTotTyTo10M%>"
   var TotLyToEOY = "<%=sTotLyToEOY%>"
   var Increase10M = "<%=sIncrease10M%>"

   var html="<table class='Therm' cellPadding='0' cellSpacing='0'>"

   html += "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1  '>November-March Sales</th>"
           +  "<td class='Div1Sls'>$" + TySales + "</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1'>Nov-Mar Increase (TY / LY Variance)</th>"
           +  "<td class='Div1Sls'>" + Var + "%</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1'>Sales needed to reach 18% increase</th>"
           +  "<td class='Div1Sls1'>$" + TotTyTo10M + "</td>"
         + "</tr>"
         + "<tr class='Div1Sls2'>"
           +  "<th class='Div1Sls1'>LY Sales for remainder through fiscal March</th>"
           +  "<td class='Div1Sls1'>$" + TotLyToEOY + "</td>"
         + "</tr>"
         + "<tr class='Div1Sls21'>"
           +  "<th class='Div1Sls1'>% increase needed for remainder of year <br>to reach 18% increase</th>"
           +  "<td class='Div1Sls11'>" + Increase10M + "%</td>"
         + "</tr>"
   html += "</table>"
   return html;
}
// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function setSkiBootSls()
{
   var NumOfStr = <%=iNumOfStr%>;
   var Store = [<%=sStr%>];
   var TySales = [<%=sStrTySales%>];
   var LySales = [<%=sStrLySales%>];
   var Var = [<%=sStrVar%>];

   var TotTySales = "<%=sTotTySales%>";
   var TotLySales = "<%=sTotLySales%>";
   var TotVar = "<%=sTotVar%>";

   var html="<table class='Therm' cellPadding='0' cellSpacing='0'>"
   html += "<tr class='Div1Sls1'>"
         +  "<th class='Div1Sls'><a href='javascript: rtvSkiBootSls(&#34;STR&#34;)'>Store</a></th>"
         +  "<th class='Div1Sls'>This Year</th>"
         +  "<th class='Div1Sls'>Last Year</th>"
         + "<th class='Div1Sls'><a href='javascript: rtvSkiBootSls(&#34;VAR&#34;)'>Var</a></th>"
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
         + "<td class='Div1Sls'>" + TotVar + "%</td>"

   html += "</table>"
   return html;
}
// ------------------------------------------------------
// sort numeric array
// ------------------------------------------------------
function numOrdA(a, b){ return (eval(a) - eval(b)); }

</SCRIPT>







