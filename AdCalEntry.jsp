<%@ page import="advertising.AdCalEntry, java.util.*"%>
<%
   String sMonBeg = request.getParameter("MonBeg");
   String sMonName = request.getParameter("MonName");
   String sMarket = request.getParameter("Market");
   String sWkend = request.getParameter("Wkend");
   String sOrgWk = request.getParameter("OrgWk");
   String sSeq = request.getParameter("Seq");
   String sNumWk = request.getParameter("NumWk");
   String sMonWk = request.getParameter("MonWk");
   String sMedia = request.getParameter("Media");
   String sMedIdx = request.getParameter("MedIdx");
   String sMedName = request.getParameter("MedName");
   String sAdType = request.getParameter("AdType");
   String sAdTypeDes = request.getParameter("AdTypeDes");
   String sAdName = request.getParameter("AdName");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sPayee = request.getParameter("Payee");
   String sAdSize = request.getParameter("AdSize");
   String sAdWDay = request.getParameter("AdWDay");
   String sAdRate = request.getParameter("AdRate");
   String sSection = request.getParameter("Section");
   String sSpot = request.getParameter("Spot");
   String sCoopA = request.getParameter("CoopA");
   String sCoopP = request.getParameter("CoopP");
   String sPlnCost = request.getParameter("PlnCost");
   String sActCost = request.getParameter("ActCost");
   String sComment = request.getParameter("Comment");
   String sAction = request.getParameter("Action");
   String sCombo = request.getParameter("Combo");
   String sComboNum = request.getParameter("ComboNum");
   String sComboType = request.getParameter("ComboType");
   String sZone = request.getParameter("Zone");
   String [] sStr = request.getParameterValues("Store");
   String sFilterPromo = request.getParameter("FilterPromo");
   String sFilterMedia = request.getParameter("FilterMedia");

   if(sSeq==null) sSeq = " ";
   if(sNumWk==null) sNumWk = "0";
   if(sMonWk==null) sMonWk = "W";
   if(sFrDate==null || sFrDate.trim().equals("")) sFrDate = "01/01/0001";
   if(sToDate==null || sToDate.trim().equals("")) sToDate = "01/01/0001";
   if(sPayee==null) sPayee = " ";
   if(sSection==null) sSection = " ";
   if(sZone==null) sZone = " ";
   if(sSpot==null) sSpot = " ";
   if(sCoopA==null) sCoopA = "0";
   if(sCoopP==null) sCoopP = "0";
   if(sAdSize==null) sAdSize = " ";
   if(sAdWDay==null) sAdWDay = " ";
   if(sAdRate==null) sAdRate = " ";
   if(sComment==null) sComment = " ";
   if(sStr==null) sStr = new String[]{" "};

   if(sActCost==null || sActCost.trim().equals("")) sActCost = "0";
   if(sPlnCost==null || sPlnCost.trim().equals("")) sPlnCost = "0";
   if(sCombo==null) sCombo = " ";
   if(sComboType==null) sComboType = " ";
   if(sComboNum==null) sComboNum = " ";

   AdCalEntry adEntry = null;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AdCalEntry.jsp&APPL=ADVERTISES&" + request.getQueryString());
   }
   else
   {
     adEntry = new AdCalEntry(sMarket, sAdType, sAdName, sWkend, sOrgWk, sSeq, sNumWk, sMonWk, sMedia, sFrDate, sToDate,
       sPayee, sAdSize, sAdWDay, sAdRate, sSection, sSpot, sCoopA, sCoopP, sPlnCost,
       sActCost, sComment, sStr, sAction, session.getAttribute("USER").toString(), sCombo, sComboType, sComboNum, sZone);

     String sUrl = "AdCal.jsp?MonBeg=" + sMonBeg + "&MonName=" + sMonName;
     if (sFilterPromo!=null) sUrl += "&FilterPromo=" + sFilterPromo + "&FilterAdType=" + sAdType
        + "&FilterAdTypeDes=" + sAdTypeDes + "&FilterAdName=" + sAdName;

     if (sFilterMedia!=null) sUrl += "&FilterMedia=" + sFilterMedia + "&FilterMedCode=" + sMedia
      + "&FilterMedIdx=" + sMedIdx + "&FilterMedName=" + sMedName;

     response.sendRedirect(sUrl);
   }
%>
<html>
<body>

MonBeg: <%=sMonBeg%><br>
MonName: <%=sMonName%><br>
Market: <%=sMarket%><br>
Wkend: <%=sWkend%><br>
OrgWk: <%=sOrgWk%><br>
Seq: <%=sSeq%><br>
sNumWk: <%=sNumWk%><br>
sMonWk: <%=sMonWk%><br>
sMedia: <%=sMedia %><br>
sAdType: <%=sAdType%><br>
sAdName: <%=sAdName%><br>
sFrdate: <%=sFrDate%><br>
sTodate: <%=sToDate%><br>
sPayee: <%=sPayee %><br>
sAdSize: <%=sAdSize%><br>
sAdWday: <%=sAdWDay%><br>
sAdRate: <%=sAdRate%><br>
sSeciotn: <%=sSection %><br>
sSpot: <%=sSpot%><br>
sCoopA: <%=sCoopA%><br>
sCoopP: <%=sCoopP%><br>
sPlnCost: <%=sPlnCost%><br>
sActCost: <%=sActCost%><br>
sComment: <%=sComment%><br>
sAction: <%=sAction%><br>
sCombo: <%=sCombo%><br>
sComboType: <%=sComboType%><br>
sComboNum: <%=sComboNum%><br>
sZone: <%=sZone%><br>
sStr: <%for (int i=0; i < sStr.length; i++)  out.print( "  " + sStr[i]);%><br>

</body>
</html>


