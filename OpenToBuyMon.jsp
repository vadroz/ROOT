<%@ page import="agedanalysis.OpenToBuyEOY, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDivName = request.getParameter("DIVNAME");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sDptName = request.getParameter("DPTNAME");
   String sClass = request.getParameter("CLASS");
   String sClsName = request.getParameter("CLSNAME");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";
   if(sDivName == null) sDivName = "All Divisions";
   if(sDepartment == null) sDepartment = "ALL";
   if(sDptName == null) sDptName = "All Departments";
   if(sClass == null) sClass = "ALL";
   if(sClsName == null) sClsName = "All Classes";

   //System.out.println(sStore  + " " + sDivision + " " + sDepartment + " " + sClass );
   OpenToBuyEOY opnbuy = new OpenToBuyEOY(sStore, sDivision, sDepartment, sClass, "Y");

    String sGrp = opnbuy.cvtToJavaScriptArray(opnbuy.getGrp());
    String sGrpName = opnbuy.cvtToJavaScriptArray(opnbuy.getGrpName());
    String sBegInvA = opnbuy.cvtToJavaScriptArray(opnbuy.getBegInvA());
    String sBegInvB = opnbuy.cvtToJavaScriptArray(opnbuy.getBegInvB());
    String sBegVar = opnbuy.cvtToJavaScriptArray(opnbuy.getBegVar());
    String sEndInvA = opnbuy.cvtToJavaScriptArray(opnbuy.getEndInvA());
    String sEndInvB = opnbuy.cvtToJavaScriptArray(opnbuy.getEndInvB());
    String sEndVar = opnbuy.cvtToJavaScriptArray(opnbuy.getEndVar());
    String sLessA = opnbuy.cvtToJavaScriptArray(opnbuy.getLessA());
    String sLessB = opnbuy.cvtToJavaScriptArray(opnbuy.getLessB());
    String sLessVar = opnbuy.cvtToJavaScriptArray(opnbuy.getLessVar());
    String sMosA = opnbuy.cvtToJavaScriptArray(opnbuy.getMosA());
    String sMosB = opnbuy.cvtToJavaScriptArray(opnbuy.getMosB());
    String sMosVar = opnbuy.cvtToJavaScriptArray(opnbuy.getMosVar());
    String sOpnRcvA = opnbuy.cvtToJavaScriptArray(opnbuy.getOpnRcvA());
    String sOpnRcvB = opnbuy.cvtToJavaScriptArray(opnbuy.getOpnRcvB());
    String sOpnRcvVar = opnbuy.cvtToJavaScriptArray(opnbuy.getOpnRcvVar());

    String sTotal = opnbuy.getTotal();
    String sTotBegInvA = opnbuy.getTotBegInvA();
    String sTotBegInvB = opnbuy.getTotBegInvB();
    String sTotBegVar = opnbuy.getTotBegVar();
    String sTotEndInvA = opnbuy.getTotEndInvA();
    String sTotEndInvB = opnbuy.getTotEndInvB();
    String sTotEndVar = opnbuy.getTotEndVar();
    String sTotLessA = opnbuy.getTotLessA();
    String sTotLessB = opnbuy.getTotLessB();
    String sTotLessVar = opnbuy.getTotLessVar();
    String sTotMosA = opnbuy.getTotMosA();
    String sTotMosB = opnbuy.getTotMosB();
    String sTotMosVar = opnbuy.getTotMosVar();
    String sTotOpnRcvA = opnbuy.getTotOpnRcvA();
    String sTotOpnRcvB = opnbuy.getTotOpnRcvB();
    String sTotOpnRcvVar = opnbuy.getTotOpnRcvVar();

    // History
    String sHGrp = opnbuy.cvtToJavaScriptArray(opnbuy.getHGrp());
    String sHGrpName = opnbuy.cvtToJavaScriptArray(opnbuy.getHGrpName());
    String sHBegInvA = opnbuy.cvtToJavaScriptArray(opnbuy.getHBegInvA());
    String sHBegInvB = opnbuy.cvtToJavaScriptArray(opnbuy.getHBegInvB());
    String sHBegVar = opnbuy.cvtToJavaScriptArray(opnbuy.getHBegVar());
    String sHEndInvA = opnbuy.cvtToJavaScriptArray(opnbuy.getHEndInvA());
    String sHEndInvB = opnbuy.cvtToJavaScriptArray(opnbuy.getHEndInvB());
    String sHEndVar = opnbuy.cvtToJavaScriptArray(opnbuy.getHEndVar());
    String sHLessA = opnbuy.cvtToJavaScriptArray(opnbuy.getHLessA());
    String sHLessB = opnbuy.cvtToJavaScriptArray(opnbuy.getHLessB());
    String sHLessVar = opnbuy.cvtToJavaScriptArray(opnbuy.getHLessVar());
    String sHMosA = opnbuy.cvtToJavaScriptArray(opnbuy.getHMosA());
    String sHMosB = opnbuy.cvtToJavaScriptArray(opnbuy.getHMosB());
    String sHMosVar = opnbuy.cvtToJavaScriptArray(opnbuy.getHMosVar());
    String sHOpnRcvA = opnbuy.cvtToJavaScriptArray(opnbuy.getHOpnRcvA());
    String sHOpnRcvB = opnbuy.cvtToJavaScriptArray(opnbuy.getHOpnRcvB());
    String sHOpnRcvVar = opnbuy.cvtToJavaScriptArray(opnbuy.getHOpnRcvVar());

    String sHTotal = opnbuy.getHTotal();
    String sHTotBegInvA = opnbuy.getHTotBegInvA();
    String sHTotBegInvB = opnbuy.getHTotBegInvB();
    String sHTotBegVar = opnbuy.getHTotBegVar();
    String sHTotEndInvA = opnbuy.getHTotEndInvA();
    String sHTotEndInvB = opnbuy.getHTotEndInvB();
    String sHTotEndVar = opnbuy.getHTotEndVar();
    String sHTotLessA = opnbuy.getHTotLessA();
    String sHTotLessB = opnbuy.getHTotLessB();
    String sHTotLessVar = opnbuy.getHTotLessVar();
    String sHTotMosA = opnbuy.getHTotMosA();
    String sHTotMosB = opnbuy.getHTotMosB();
    String sHTotMosVar = opnbuy.getHTotMosVar();
    String sHTotOpnRcvA = opnbuy.getHTotOpnRcvA();
    String sHTotOpnRcvB = opnbuy.getHTotOpnRcvB();
    String sHTotOpnRcvVar = opnbuy.getHTotOpnRcvVar();

   opnbuy.disconnect();
 %>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//report parameters
var Grp = [<%=sGrp%>];
var GrpName = [<%=sGrpName%>];
var BegInvA = [<%=sBegInvA%>];
var BegInvB = [<%=sBegInvB%>];
var BegVar = [<%=sBegVar%>];

var EndInvA = [<%=sEndInvA%>];
var EndInvB = [<%=sEndInvB%>];
var EndVar = [<%=sEndVar%>];
var LessA = [<%=sLessA%>];
var LessB = [<%=sLessB%>];
var LessVar = [<%=sLessVar%>];
var MosA = [<%=sMosA%>];
var MosB = [<%=sMosB%>];
var MosVar = [<%=sMosVar%>];
var OpnRcvA = [<%=sOpnRcvA%>];
var OpnRcvB = [<%=sOpnRcvB%>];
var OpnRcvVar = [<%=sOpnRcvVar%>];

var Total = "<%=sTotal%>";
var TotBegInvA = "<%=sTotBegInvA%>";
var TotBegInvB = "<%=sTotBegInvB%>";
var TotBegVar = "<%=sTotBegVar%>";
var TotEndInvA = "<%=sTotEndInvA%>";
var TotEndInvB = "<%=sTotEndInvB%>";
var TotEndVar = "<%=sTotEndVar%>";
var TotLessA = "<%=sTotLessA%>";
var TotLessB = "<%=sTotLessB%>";
var TotLessVar = "<%=sTotLessVar%>";
var TotMosA = "<%=sTotMosA%>";
var TotMosB = "<%=sTotMosB%>";
var TotMosVar = "<%=sTotMosVar%>";
var TotOpnRcvA = "<%=sTotOpnRcvA%>";
var TotOpnRcvB = "<%=sTotOpnRcvB%>";
var TotOpnRcvVar = "<%=sTotOpnRcvVar%>";

// history
var HGrp = [<%=sHGrp%>];
var HGrpName = [<%=sHGrpName%>];
var HBegInvA = [<%=sHBegInvA%>];
var HBegInvB = [<%=sHBegInvB%>];
var HBegVar = [<%=sHBegVar%>];
var HEndInvA = [<%=sHEndInvA%>];
var HEndInvB = [<%=sHEndInvB%>];
var HEndVar = [<%=sHEndVar%>];
var HLessA = [<%=sHLessA%>];
var HLessB = [<%=sHLessB%>];
var HLessVar = [<%=sHLessVar%>];
var HMosA = [<%=sHMosA%>];
var HMosB = [<%=sHMosB%>];
var HMosVar = [<%=sHMosVar%>];
var HOpnRcvA = [<%=sHOpnRcvA%>];
var HOpnRcvB = [<%=sHOpnRcvB%>];
var HOpnRcvVar = [<%=sHOpnRcvVar%>];

var HTotal = "<%=sHTotal%>";
var HTotBegInvA = "<%=sHTotBegInvA%>";
var HTotBegInvB = "<%=sHTotBegInvB%>";
var HTotBegVar = "<%=sHTotBegVar%>";
var HTotEndInvA = "<%=sHTotEndInvA%>";
var HTotEndInvB = "<%=sHTotEndInvB%>";
var HTotEndVar = "<%=sHTotEndVar%>";
var HTotLessA = "<%=sHTotLessA%>";
var HTotLessB = "<%=sHTotLessB%>";
var HTotLessVar = "<%=sHTotLessVar%>";
var HTotMosA = "<%=sHTotMosA%>";
var HTotMosB = "<%=sHTotMosB%>";
var HTotMosVar = "<%=sHTotMosVar%>";
var HTotOpnRcvA = "<%=sHTotOpnRcvA%>";
var HTotOpnRcvB = "<%=sHTotOpnRcvB%>";
var HTotOpnRcvVar = "<%=sHTotOpnRcvVar%>";


popMonthDetail();
//---------------------------------------------------------
// populate Monthly detail arrays
//---------------------------------------------------------
function popMonthDetail()
{
    parent.showOTBbyMon(Grp, GrpName, BegInvA, BegInvB, BegVar, EndInvA, EndInvB, EndVar, LessA, LessB, LessVar,
         MosA, MosB, MosVar, OpnRcvA, OpnRcvB, OpnRcvVar,
         Total, TotBegInvA, TotBegInvB, TotBegVar, TotEndInvA, TotEndInvB, TotEndVar, TotLessA, TotLessB, TotLessVar,
         TotMosA, TotMosB, TotMosVar, TotOpnRcvA, TotOpnRcvB, TotOpnRcvVar,
         HGrp, HGrpName, HBegInvA, HBegInvB, HBegVar, HEndInvA, HEndInvB, HEndVar, HLessA, HLessB, HLessVar,
         HMosA, HMosB, HMosVar, HOpnRcvA, HOpnRcvB, HOpnRcvVar,
         HTotal, HTotBegInvA, HTotBegInvB, HTotBegVar, HTotEndInvA, HTotEndInvB, HTotEndVar, HTotLessA, HTotLessB, HTotLessVar,
         HTotMosA, HTotMosB, HTotMosVar, HTotOpnRcvA, HTotOpnRcvB, HTotOpnRcvVar
         );

    parent.frame1.close();
}

</script>