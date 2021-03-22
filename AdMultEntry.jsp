<%@ page import="advertising.AdMultEntry, java.util.*"%>
<%
   String sMult = request.getParameter("Mult");

   AdMultEntry admult = new AdMultEntry(sMult);

   String sGrp = admult.getGrp();
   String sMed = admult.getMed();
   String sPromType = admult.getPromType();;
   String sPromDesc = admult.getPromDesc();;
   String sOrgWk = admult.getOrgWk();
   String sNumWk = admult.getNumWk();
   String sPayee = admult.getPayee();
   String sSize = admult.getSize();
   String sWkDay = admult.getWkDay();
   String sRate = admult.getRate();
   String sSect = admult.getSect();
   String sSpot = admult.getSpot();
   String sBDat = admult.getBDat();
   String sEDat = admult.getEDat();
   String sPlnCost = admult.getPlnCost();
   String sActCost = admult.getActCost();
   String sUser = admult.getUser();
   String sDate = admult.getDate();
   String sTime = admult.getTime();
   String sComment = admult.getComment();
   String sCoopA = admult.getCoopA();
   String sCoopP = admult.getCoopP();
   int iNumOfMkt = admult.getNumOfMkt();
   String [] sMkt = admult.getMkt();

   admult.disconnect();

   if(sGrp.equals("NP")) sGrp = "Newspaper";
   else if(sGrp.equals("RA")) sGrp = "Radio";
   else if(sGrp.equals("TV")) sGrp = "TV";
   else if(sGrp.equals("ZZ")) sGrp = "Other";

   if(sPromType.equals("P")) sPromType = "Promotion";
   else if(sPromType.equals("E")) sPromType = "Event";
   else if(sPromType.equals("N")) sPromType = "Non-Event";
   else if(sPromType.equals("M")) sPromType = "Media Commitment";
   else if(sPromType.equals("X")) sPromType = "None";

   if(sWkDay.equals("1")) sWkDay = "Monday";
   if(sWkDay.equals("2")) sWkDay = "Tuesday";
   if(sWkDay.equals("3")) sWkDay = "Wednesday";
   if(sWkDay.equals("4")) sWkDay = "Thursday";
   if(sWkDay.equals("5")) sWkDay = "Friday";
   if(sWkDay.equals("6")) sWkDay = "Saturday";
   if(sWkDay.equals("0")) sWkDay = "Sunday";
%>
<html>
<head>
<style>
@media screen { body {background:ivory;} }
@media print{  body {background:white;} }

 td.DataTable {  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 text-align:left; font-family:Arial; font-size:10px }
 td.DataTable1 { color:red;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 text-align:left; font-family:Arial; font-size:10px }
 td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 text-align:center; font-family:Arial; font-size:10px }
</style>
</head>

<SCRIPT language="JavaScript1.2">
</SCRIPT>
<body onLoad="focus()">
<!-------------------------------------------------------------------->
  <table border="0" width="100%" cellPadding="0" cellSpacing="0">
    <tr>
       <td class="DataTable2" colspan="8"><font size="+2">Multiple Market Entry</font></td>
    </tr>
    <tr>
       <td class="DataTable" nowrap>Group:</td><td class="DataTable1" nowrap><%=sGrp%></td>
       <td class="DataTable" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td class="DataTable1" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
       <td class="DataTable" nowrap>Media:</td><td class="DataTable1" nowrap><%=sMed%></td>
    </tr>
    <tr>
       <td class="DataTable" nowrap>Promotion Type:</td><td class="DataTable1" nowrap><%=sPromType%></td>
       <td class="DataTable" nowrap>&nbsp;</td><td class="DataTable1" nowrap>&nbsp;</td>
       <td class="DataTable" nowrap>Promotion:</td><td class="DataTable1" nowrap><%=sPromDesc%></td>
    </tr >
    <tr>
       <td class="DataTable" nowrap>Start at:</td><td class="DataTable1" nowrap><%=sOrgWk%></td>
       <td class="DataTable" nowrap>&nbsp;</td><td class="DataTable1" nowrap>&nbsp;</td>
       <td class="DataTable" nowrap>Num. of Weeks:</td><td class="DataTable1" nowrap><%=sNumWk%></td>
    </tr>
    <tr>
       <td class="DataTable" nowrap>Payee:</td><td class="DataTable1" nowrap><%=sPayee%>&nbsp;</td>
       <td class="DataTable" nowrap>&nbsp;</td><td class="DataTable1" nowrap>&nbsp;</td>
       <td class="DataTable" nowrap>Size:</td><td class="DataTable1" nowrap><%=sSize%>&nbsp;</td>
    </tr>
    <tr >
       <td class="DataTable" nowrap>Day:</td><td class="DataTable1" nowrap><%=sWkDay%>&nbsp;</td>
       <td class="DataTable" nowrap>&nbsp;</td><td class="DataTable1" nowrap>&nbsp;</td>
       <td class="DataTable" nowrap>Date:</td><td class="DataTable1" nowrap><%=sBDat%>&nbsp;</td>
    </tr>
    <tr >
       <td class="DataTable" nowrap>Rate:</td><td class="DataTable1" nowrap><%="$" + sRate%>&nbsp;</td>
       <td class="DataTable" nowrap>&nbsp;</td><td class="DataTable1" nowrap>&nbsp;</td>
       <td class="DataTable" nowrap>Type of Charge:</td><td class="DataTable1" nowrap><%=sSpot%>&nbsp;</td>
    </tr>
    <tr >
       <td class="DataTable" nowrap>Planed Cost:</td><td class="DataTable1" nowrap><%="$" + sPlnCost%>&nbsp;</td>
       <td class="DataTable" nowrap>&nbsp;</td><td class="DataTable1" nowrap>&nbsp;</td>
       <td class="DataTable" nowrap>Comment:</td><td class="DataTable1" nowrap><%=sComment%>&nbsp;</td>
    </tr>
    <tr >
       <td class="DataTable" nowrap>User:</td><td class="DataTable1" nowrap><%=sUser%></td>
       <td class="DataTable" nowrap>&nbsp;</td><td class="DataTable1" nowrap>&nbsp;</td>
       <td class="DataTable" nowrap>Date:</td><td class="DataTable1" nowrap><%=sDate%></td>
    </tr>
    <tr >
       <td class="DataTable">Markets:</td>
       <td class="DataTable1" colspan="5">
         <% String sComa = "";
            for(int i=0; i < iNumOfMkt; i++) {%>
               <%=sComa + sMkt[i]%>
               <%sComa=", ";%>
         <% }%>
       </td>
    </tr>
    <tr >
       <td class="DataTable2" colspan="6"><a href="javascript: window.close()">Close</a></td>
    </tr>
  </table>
</body>
</html>


