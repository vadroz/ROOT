<%@ page import="salesreport3.WkSlsTrend, java.util.*, rciutility.FormatNumericValue, java.awt.Color, java.io.*, java.math.BigDecimal, java.text.*"%>
<%
   long lStartTime = (new Date()).getTime();

   String [] sStore = request.getParameterValues("Str");
   String [] sDivision = request.getParameterValues("Div");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sVendor = request.getParameter("VENDOR");
   String sFromDt = request.getParameter("FromDt");
   String sToDt = request.getParameter("ToDt");

   String sLevel = request.getParameter("LEVEL");
   String sSortBy = request.getParameter("SORT");
   String sAmtType = request.getParameter("selAmtType");

   if(sDivision == null) sDivision = new String[]{"ALL"};
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sVendor == null) sVendor = "ALL";
   if(sLevel == null) sLevel = "D";
   if(sSortBy == null) sSortBy = "GROUP";
   if(sAmtType == null) sAmtType = "R";

   String sSortTitle = "Sort by";

   if (sLevel.equals("D") && sSortBy.equals("GROUP")) sSortTitle = "Sorted by Divisions";
   else if(sLevel.equals("P") && sSortBy.equals("GROUP")) sSortTitle = "Sorted by Departments";
   else if(sLevel.equals("C") && sSortBy.equals("GROUP")) sSortTitle = "Sorted by Classes";
   else if(sLevel.equals("S") && sSortBy.equals("GROUP")) { sSortTitle = "Sorted by Store";}
   else
   {
     if(sSortBy.substring(3,4).equals("T")) sSortTitle += " TY";
     else if(sSortBy.substring(3,4).equals("L")) sSortTitle += " LY";

     if(sSortBy.substring(1,3).equals("WK")) sSortTitle += " Weekly";
     else if(sSortBy.substring(1,3).equals("MN")) sSortTitle += " Monthly";
     else if(sSortBy.substring(1,3).equals("YR")) sSortTitle += " Yearly";

     else if(sSortBy.substring(1,3).equals("IN")) sSortTitle += " Inventory";
     if(sSortBy.substring(0,1).equals("G")) sSortTitle += " Gross Margin";
     if (sSortBy.substring(3,4).equals("T")
      && !sSortBy.substring(0,1).equals("G")
      && !sSortBy.substring(1,3).equals("IN"))
                 sSortTitle += " Sales";
     else if(sSortBy.substring(3,4).equals("L")
         && !sSortBy.substring(1,3).equals("IN")) sSortTitle += " Sales";
     else if(sSortBy.substring(3,4).equals("D")) sSortTitle += " Variance";
     else if(sSortBy.substring(3,4).equals("V")) sSortTitle += " Variance Percents";
   }


   //System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
   //      + sStore[0] + " " + sFromDt + " " + sLevel + " " + sSortBy);

   WkSlsTrend setSls = new WkSlsTrend(sDivision, sDepartment, sClass, sVendor, sStore,
                          sFromDt, sToDt, sLevel, sSortBy);

    String sSelStr = setSls.getSelStr();
    String sSelDiv = setSls.cvtToJavaScriptArray(sDivision);
    String sSelDpt = setSls.getSelDpt();
    String sSelCls = setSls.getSelCls();

    String [] sGrp = setSls.getGroup();
    //sFromDt = setSls.getCompDate();

    String sGrpJSA = setSls.getGrpJSA();
    String sDivJSA = setSls.getDivJSA();
    String sDptJSA = setSls.getDptJSA();
    String sClsJSA = setSls.getClsJSA();

    String sDivNameJSA = setSls.getDivNameJSA();
    String sDptNameJSA = setSls.getDptNameJSA();
    String sClsNameJSA = setSls.getClsNameJSA();

    int iNumOfSls = setSls.getNumOfSls();
    // Weekly
    String [] sTyWkRet = setSls.getTyWkRet();
    String [] sLyWkRet = setSls.getLyWkRet();
    String [] sTyWkUnt = setSls.getTyWkUnt();
    String [] sLyWkUnt = setSls.getLyWkUnt();
    String [] sTyWkGMrg = setSls.getTyWkGMrg();
    String [] sLyWkGMrg = setSls.getLyWkGMrg();

    String [] sWkRetDiff = setSls.getWkRetDiff();
    String [] sWkRetVar = setSls.getWkRetVar();
    String [] sWkUntDiff = setSls.getWkUntDiff();
    String [] sWkUntVar = setSls.getWkUntVar();
    String [] sWkGMrgDiff = setSls.getWkGMrgDiff();
    String [] sWkGMrgVar = setSls.getWkGMrgVar();
    String [] sWkStkRatio = setSls.getWkStkRatio();
    //Monthly
    String [] sTyMnRet = setSls.getTyMnRet();
    String [] sLyMnRet = setSls.getLyMnRet();
    String [] sTyMnUnt = setSls.getTyMnUnt();
    String [] sLyMnUnt = setSls.getLyMnUnt();
    String [] sTyMnGMrg = setSls.getTyMnGMrg();
    String [] sLyMnGMrg = setSls.getLyMnGMrg();

    String [] sMnRetDiff = setSls.getMnRetDiff();
    String [] sMnRetVar = setSls.getMnRetVar();
    String [] sMnUntDiff = setSls.getMnUntDiff();
    String [] sMnUntVar = setSls.getMnUntVar();
    String [] sMnGMrgDiff = setSls.getMnGMrgDiff();
    String [] sMnGMrgVar = setSls.getMnGMrgVar();
    // Yearly
    String [] sTyYrRet = setSls.getTyYrRet();
    String [] sLyYrRet = setSls.getLyYrRet();
    String [] sTyYrUnt = setSls.getTyYrUnt();
    String [] sLyYrUnt = setSls.getLyYrUnt();
    String [] sTyYrGMrg = setSls.getTyYrGMrg();
    String [] sLyYrGMrg = setSls.getLyYrGMrg();

    String [] sYrRetDiff = setSls.getYrRetDiff();
    String [] sYrRetVar = setSls.getYrRetVar();
    String [] sYrUntDiff = setSls.getYrUntDiff();
    String [] sYrUntVar = setSls.getYrUntVar();
    String [] sYrGMrgDiff = setSls.getYrGMrgDiff();
    String [] sYrGMrgVar = setSls.getYrGMrgVar();

    //inventory
    // Weekly
    String [] sTyInvRet = setSls.getTyInvRet();
    String [] sLyInvRet = setSls.getLyInvRet();
    String [] sTyInvUnt = setSls.getTyInvUnt();
    String [] sLyInvUnt = setSls.getLyInvUnt();

    String [] sInvRetDiff = setSls.getInvRetDiff();
    String [] sInvRetVar = setSls.getInvRetVar();
    String [] sInvUntDiff = setSls.getInvUntDiff();
    String [] sInvUntVar = setSls.getInvUntVar();

    String [] sTyWkGmPrc = setSls.getTyWkGmPrc();
    String [] sTyMnGmPrc = setSls.getTyMnGmPrc();
    String [] sTyYrGmPrc = setSls.getTyYrGmPrc();
    String [] sLyWkGmPrc = setSls.getLyWkGmPrc();
    String [] sLyMnGmPrc = setSls.getLyMnGmPrc();
    String [] sLyYrGmPrc = setSls.getLyYrGmPrc();
    //------------------------ Regional Totals ---------------------------------
    // Weekly
    String [] sRegTyWkRet = setSls.getRegTyWkRet();
    String [] sRegLyWkRet = setSls.getRegLyWkRet();
    String [] sRegTyWkUnt = setSls.getRegTyWkUnt();
    String [] sRegLyWkUnt = setSls.getRegLyWkUnt();
    String [] sRegTyWkGMrg = setSls.getRegTyWkGMrg();
    String [] sRegLyWkGMrg = setSls.getRegLyWkGMrg();

    String [] sRegWkRetDiff = setSls.getRegWkRetDiff();
    String [] sRegWkRetVar = setSls.getRegWkRetVar();
    String [] sRegWkUntDiff = setSls.getRegWkUntDiff();
    String [] sRegWkUntVar = setSls.getRegWkUntVar();
    String [] sRegWkGMrgDiff = setSls.getRegWkGMrgDiff();
    String [] sRegWkGMrgVar = setSls.getRegWkGMrgVar();
    String [] sRegWkStkRatio = setSls.getRegWkStkRatio();
    //Monthly
    String [] sRegTyMnRet = setSls.getRegTyMnRet();
    String [] sRegLyMnRet = setSls.getRegLyMnRet();
    String [] sRegTyMnUnt = setSls.getRegTyMnUnt();
    String [] sRegLyMnUnt = setSls.getRegLyMnUnt();
    String [] sRegTyMnGMrg = setSls.getRegTyMnGMrg();
    String [] sRegLyMnGMrg = setSls.getRegLyMnGMrg();

    String [] sRegMnRetDiff = setSls.getRegMnRetDiff();
    String [] sRegMnRetVar = setSls.getRegMnRetVar();
    String [] sRegMnUntDiff = setSls.getRegMnUntDiff();
    String [] sRegMnUntVar = setSls.getRegMnUntVar();
    String [] sRegMnGMrgDiff = setSls.getRegMnGMrgDiff();
    String [] sRegMnGMrgVar = setSls.getRegMnGMrgVar();
    // Yearly
    String [] sRegTyYrRet = setSls.getRegTyYrRet();
    String [] sRegLyYrRet = setSls.getRegLyYrRet();
    String [] sRegTyYrUnt = setSls.getRegTyYrUnt();
    String [] sRegLyYrUnt = setSls.getRegLyYrUnt();
    String [] sRegTyYrGMrg = setSls.getRegTyYrGMrg();
    String [] sRegLyYrGMrg = setSls.getRegLyYrGMrg();

    String [] sRegYrRetDiff = setSls.getRegYrRetDiff();
    String [] sRegYrRetVar = setSls.getRegYrRetVar();
    String [] sRegYrUntDiff = setSls.getRegYrUntDiff();
    String [] sRegYrUntVar = setSls.getRegYrUntVar();
    String [] sRegYrGMrgDiff = setSls.getRegYrGMrgDiff();
    String [] sRegYrGMrgVar = setSls.getRegYrGMrgVar();

    //inventory
    String [] sRegTyInvRet = setSls.getRegTyInvRet();
    String [] sRegLyInvRet = setSls.getRegLyInvRet();
    String [] sRegTyInvUnt = setSls.getRegTyInvUnt();
    String [] sRegLyInvUnt = setSls.getRegLyInvUnt();

    String [] sRegInvRetDiff = setSls.getRegInvRetDiff();
    String [] sRegInvRetVar = setSls.getRegInvRetVar();
    String [] sRegInvUntDiff = setSls.getRegInvUntDiff();
    String [] sRegInvUntVar = setSls.getRegInvUntVar();

    String [] sRegTyWkGmPrc = setSls.getRegTyWkGmPrc();
    String [] sRegTyMnGmPrc = setSls.getRegTyMnGmPrc();
    String [] sRegTyYrGmPrc = setSls.getRegTyYrGmPrc();
    String [] sRegLyWkGmPrc = setSls.getRegLyWkGmPrc();
    String [] sRegLyMnGmPrc = setSls.getRegLyMnGmPrc();
    String [] sRegLyYrGmPrc = setSls.getRegLyYrGmPrc();

    //--------------------------------------------------------------------------

    //------------------------ Mall/Non-Mall Totals ---------------------------------
    // Weekly
    String [] sMallTyWkRet = setSls.getMallTyWkRet();
    String [] sMallLyWkRet = setSls.getMallLyWkRet();
    String [] sMallTyWkUnt = setSls.getMallTyWkUnt();
    String [] sMallLyWkUnt = setSls.getMallLyWkUnt();
    String [] sMallTyWkGMrg = setSls.getMallTyWkGMrg();
    String [] sMallLyWkGMrg = setSls.getMallLyWkGMrg();

    String [] sMallWkRetDiff = setSls.getMallWkRetDiff();
    String [] sMallWkRetVar = setSls.getMallWkRetVar();
    String [] sMallWkUntDiff = setSls.getMallWkUntDiff();
    String [] sMallWkUntVar = setSls.getMallWkUntVar();
    String [] sMallWkGMrgDiff = setSls.getMallWkGMrgDiff();
    String [] sMallWkGMrgVar = setSls.getMallWkGMrgVar();
    String [] sMallWkStkRatio = setSls.getMallWkStkRatio();
    //Monthly
    String [] sMallTyMnRet = setSls.getMallTyMnRet();
    String [] sMallLyMnRet = setSls.getMallLyMnRet();
    String [] sMallTyMnUnt = setSls.getMallTyMnUnt();
    String [] sMallLyMnUnt = setSls.getMallLyMnUnt();
    String [] sMallTyMnGMrg = setSls.getMallTyMnGMrg();
    String [] sMallLyMnGMrg = setSls.getMallLyMnGMrg();

    String [] sMallMnRetDiff = setSls.getMallMnRetDiff();
    String [] sMallMnRetVar = setSls.getMallMnRetVar();
    String [] sMallMnUntDiff = setSls.getMallMnUntDiff();
    String [] sMallMnUntVar = setSls.getMallMnUntVar();
    String [] sMallMnGMrgDiff = setSls.getMallMnGMrgDiff();
    String [] sMallMnGMrgVar = setSls.getMallMnGMrgVar();
    // Yearly
    String [] sMallTyYrRet = setSls.getMallTyYrRet();
    String [] sMallLyYrRet = setSls.getMallLyYrRet();
    String [] sMallTyYrUnt = setSls.getMallTyYrUnt();
    String [] sMallLyYrUnt = setSls.getMallLyYrUnt();
    String [] sMallTyYrGMrg = setSls.getMallTyYrGMrg();
    String [] sMallLyYrGMrg = setSls.getMallLyYrGMrg();

    String [] sMallYrRetDiff = setSls.getMallYrRetDiff();
    String [] sMallYrRetVar = setSls.getMallYrRetVar();
    String [] sMallYrUntDiff = setSls.getMallYrUntDiff();
    String [] sMallYrUntVar = setSls.getMallYrUntVar();
    String [] sMallYrGMrgDiff = setSls.getMallYrGMrgDiff();
    String [] sMallYrGMrgVar = setSls.getMallYrGMrgVar();

    //inventory
    String [] sMallTyInvRet = setSls.getMallTyInvRet();
    String [] sMallLyInvRet = setSls.getMallLyInvRet();
    String [] sMallTyInvUnt = setSls.getMallTyInvUnt();
    String [] sMallLyInvUnt = setSls.getMallLyInvUnt();

    String [] sMallInvRetDiff = setSls.getMallInvRetDiff();
    String [] sMallInvRetVar = setSls.getMallInvRetVar();
    String [] sMallInvUntDiff = setSls.getMallInvUntDiff();
    String [] sMallInvUntVar = setSls.getMallInvUntVar();

    String [] sMallTyWkGmPrc = setSls.getMallTyWkGmPrc();
    String [] sMallTyMnGmPrc = setSls.getMallTyMnGmPrc();
    String [] sMallTyYrGmPrc = setSls.getMallTyYrGmPrc();
    String [] sMallLyWkGmPrc = setSls.getMallLyWkGmPrc();
    String [] sMallLyMnGmPrc = setSls.getMallLyMnGmPrc();
    String [] sMallLyYrGmPrc = setSls.getMallLyYrGmPrc();

    //--------------------------------------------------------------------------
    //------------------------ DMM and Other Totals ---------------------------------
    // Weekly
    int iNumOfDmm = setSls.getNumOfDmm();
    String [] sDmmGrp = setSls.getDmmGrp();
    String [] sDmmName = setSls.getDmmName();

    String [] sDmmTyWkRet = setSls.getDmmTyWkRet();
    String [] sDmmLyWkRet = setSls.getDmmLyWkRet();
    String [] sDmmTyWkUnt = setSls.getDmmTyWkUnt();
    String [] sDmmLyWkUnt = setSls.getDmmLyWkUnt();
    String [] sDmmTyWkGMrg = setSls.getDmmTyWkGMrg();
    String [] sDmmLyWkGMrg = setSls.getDmmLyWkGMrg();

    String [] sDmmWkRetDiff = setSls.getDmmWkRetDiff();
    String [] sDmmWkRetVar = setSls.getDmmWkRetVar();
    String [] sDmmWkUntDiff = setSls.getDmmWkUntDiff();
    String [] sDmmWkUntVar = setSls.getDmmWkUntVar();
    String [] sDmmWkGMrgDiff = setSls.getDmmWkGMrgDiff();
    String [] sDmmWkGMrgVar = setSls.getDmmWkGMrgVar();
    String [] sDmmWkStkRatio = setSls.getDmmWkStkRatio();

    //Monthly
    String [] sDmmTyMnRet = setSls.getDmmTyMnRet();
    String [] sDmmLyMnRet = setSls.getDmmLyMnRet();
    String [] sDmmTyMnUnt = setSls.getDmmTyMnUnt();
    String [] sDmmLyMnUnt = setSls.getDmmLyMnUnt();
    String [] sDmmTyMnGMrg = setSls.getDmmTyMnGMrg();
    String [] sDmmLyMnGMrg = setSls.getDmmLyMnGMrg();

    String [] sDmmMnRetDiff = setSls.getDmmMnRetDiff();
    String [] sDmmMnRetVar = setSls.getDmmMnRetVar();
    String [] sDmmMnUntDiff = setSls.getDmmMnUntDiff();
    String [] sDmmMnUntVar = setSls.getDmmMnUntVar();
    String [] sDmmMnGMrgDiff = setSls.getDmmMnGMrgDiff();
    String [] sDmmMnGMrgVar = setSls.getDmmMnGMrgVar();
    // Yearly
    String [] sDmmTyYrRet = setSls.getDmmTyYrRet();
    String [] sDmmLyYrRet = setSls.getDmmLyYrRet();
    String [] sDmmTyYrUnt = setSls.getDmmTyYrUnt();
    String [] sDmmLyYrUnt = setSls.getDmmLyYrUnt();
    String [] sDmmTyYrGMrg = setSls.getDmmTyYrGMrg();
    String [] sDmmLyYrGMrg = setSls.getDmmLyYrGMrg();

    String [] sDmmYrRetDiff = setSls.getDmmYrRetDiff();
    String [] sDmmYrRetVar = setSls.getDmmYrRetVar();
    String [] sDmmYrUntDiff = setSls.getDmmYrUntDiff();
    String [] sDmmYrUntVar = setSls.getDmmYrUntVar();
    String [] sDmmYrGMrgDiff = setSls.getDmmYrGMrgDiff();
    String [] sDmmYrGMrgVar = setSls.getDmmYrGMrgVar();

    //inventory
    String [] sDmmTyInvRet = setSls.getDmmTyInvRet();
    String [] sDmmLyInvRet = setSls.getDmmLyInvRet();
    String [] sDmmTyInvUnt = setSls.getDmmTyInvUnt();
    String [] sDmmLyInvUnt = setSls.getDmmLyInvUnt();

    String [] sDmmInvRetDiff = setSls.getDmmInvRetDiff();
    String [] sDmmInvRetVar = setSls.getDmmInvRetVar();
    String [] sDmmInvUntDiff = setSls.getDmmInvUntDiff();
    String [] sDmmInvUntVar = setSls.getDmmInvUntVar();

    String [] sDmmTyWkGmPrc = setSls.getDmmTyWkGmPrc();
    String [] sDmmTyMnGmPrc = setSls.getDmmTyMnGmPrc();
    String [] sDmmTyYrGmPrc = setSls.getDmmTyYrGmPrc();
    String [] sDmmLyWkGmPrc = setSls.getDmmLyWkGmPrc();
    String [] sDmmLyMnGmPrc = setSls.getDmmLyMnGmPrc();
    String [] sDmmLyYrGmPrc = setSls.getDmmLyYrGmPrc();
    //--------------------------------------------------------------------------
    //------------------------ Report Totals ---------------------------------
    // Weekly
    String [] sRepTyWkRet = setSls.getRepTyWkRet();
    String [] sRepLyWkRet = setSls.getRepLyWkRet();
    String [] sRepTyWkUnt = setSls.getRepTyWkUnt();
    String [] sRepLyWkUnt = setSls.getRepLyWkUnt();
    String [] sRepTyWkGMrg = setSls.getRepTyWkGMrg();
    String [] sRepLyWkGMrg = setSls.getRepLyWkGMrg();

    String [] sRepWkRetDiff = setSls.getRepWkRetDiff();
    String [] sRepWkRetVar = setSls.getRepWkRetVar();
    String [] sRepWkUntDiff = setSls.getRepWkUntDiff();
    String [] sRepWkUntVar = setSls.getRepWkUntVar();
    String [] sRepWkGMrgDiff = setSls.getRepWkGMrgDiff();
    String [] sRepWkGMrgVar = setSls.getRepWkGMrgVar();
    String [] sRepWkStkRatio = setSls.getRepWkStkRatio();
    //Monthly
    String [] sRepTyMnRet = setSls.getRepTyMnRet();
    String [] sRepLyMnRet = setSls.getRepLyMnRet();
    String [] sRepTyMnUnt = setSls.getRepTyMnUnt();
    String [] sRepLyMnUnt = setSls.getRepLyMnUnt();
    String [] sRepTyMnGMrg = setSls.getRepTyMnGMrg();
    String [] sRepLyMnGMrg = setSls.getRepLyMnGMrg();

    String [] sRepMnRetDiff = setSls.getRepMnRetDiff();
    String [] sRepMnRetVar = setSls.getRepMnRetVar();
    String [] sRepMnUntDiff = setSls.getRepMnUntDiff();
    String [] sRepMnUntVar = setSls.getRepMnUntVar();
    String [] sRepMnGMrgDiff = setSls.getRepMnGMrgDiff();
    String [] sRepMnGMrgVar = setSls.getRepMnGMrgVar();
    // Yearly
    String [] sRepTyYrRet = setSls.getRepTyYrRet();
    String [] sRepLyYrRet = setSls.getRepLyYrRet();
    String [] sRepTyYrUnt = setSls.getRepTyYrUnt();
    String [] sRepLyYrUnt = setSls.getRepLyYrUnt();
    String [] sRepTyYrGMrg = setSls.getRepTyYrGMrg();
    String [] sRepLyYrGMrg = setSls.getRepLyYrGMrg();

    String [] sRepYrRetDiff = setSls.getRepYrRetDiff();
    String [] sRepYrRetVar = setSls.getRepYrRetVar();
    String [] sRepYrUntDiff = setSls.getRepYrUntDiff();
    String [] sRepYrUntVar = setSls.getRepYrUntVar();
    String [] sRepYrGMrgDiff = setSls.getRepYrGMrgDiff();
    String [] sRepYrGMrgVar = setSls.getRepYrGMrgVar();

    //inventory
    String [] sRepTyInvRet = setSls.getRepTyInvRet();
    String [] sRepLyInvRet = setSls.getRepLyInvRet();
    String [] sRepTyInvUnt = setSls.getRepTyInvUnt();
    String [] sRepLyInvUnt = setSls.getRepLyInvUnt();

    String [] sRepInvRetDiff = setSls.getRepInvRetDiff();
    String [] sRepInvRetVar = setSls.getRepInvRetVar();
    String [] sRepInvUntDiff = setSls.getRepInvUntDiff();
    String [] sRepInvUntVar = setSls.getRepInvUntVar();

    String [] sRepTyWkGmPrc = setSls.getRepTyWkGmPrc();
    String [] sRepTyMnGmPrc = setSls.getRepTyMnGmPrc();
    String [] sRepTyYrGmPrc = setSls.getRepTyYrGmPrc();
    String [] sRepLyWkGmPrc = setSls.getRepLyWkGmPrc();
    String [] sRepLyMnGmPrc = setSls.getRepLyMnGmPrc();
    String [] sRepLyYrGmPrc = setSls.getRepLyYrGmPrc();
    //--------------------------------------------------------------------------


    setSls.disconnect();

    String sColName = "Store";
    if(sLevel.equals("D")){ sColName = "Division"; }
    else if(sLevel.equals("P")) { sColName = "Department"; }
    else if(sLevel.equals("C")) { sColName = "Class"; }
    String sVarName = "$";
    if(sAmtType.equals("U")) sVarName = "#";

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable2h { display:none }
        tr.DataTable3 { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { border-top: double darkred;}
        td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}

        div.dvRepCol { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvToolTip { border: black solid 1px; position:absolute; visibility:hidden; background-attachment: scroll;
               width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        div.selBox {background:cornsilk; border: darkblue solid 2px; padding-top:3px; width:200px; height:30px;
                    font-family:Arial; font-size:11px; text-align:left;}
        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }

        .Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Level = "<%=sLevel%>";
var Combined = <%=sLevel.indexOf('2') >= 0%>;
var Store = new Array(); <%for(int i=0; i < sStore.length; i++){%>Store[<%=i%>] = "<%=sStore[i]%>";<%}%>

var Div = null;
var Dpt = null;
var Cls = null;
var Str = null;

var DivName = null;
var DptName = null;
var ClsName = null;
var Grp = [<%=sGrpJSA%>];
var SortBy = "<%=sSortBy%>";
var FromDate = "<%=sFromDt%>";
var ToDate = "<%=sToDt%>";

var SelCol = new Array();

if(Store == "ALL" && !Combined)
{
  Str = [<%=sGrpJSA%>]
  if(Level=="000" ) { Div = [<%=sDivJSA%>]; DivName = [<%=sDivNameJSA%>];}
  else if(Level=="100") { Dpt = [<%=sDptJSA%>]; DptName = [<%=sDptNameJSA%>]; }
  else if(Level=="010") { Cls = [<%=sClsJSA%>]; ClsName = [<%=sClsNameJSA%>]; }
}
else if(Store == "ALL" && Combined)
{
  if(Level=="200") { Div = [<%=sDivJSA%>]; DivName = [<%=sDivNameJSA%>];}
  else if(Level=="020") { Dpt = [<%=sDptJSA%>]; DptName = [<%=sDptNameJSA%>]; }
  else if(Level=="002") { Cls = [<%=sClsJSA%>]; ClsName = [<%=sClsNameJSA%>]; }
}
else
{
  if(Level=="100") { Div = [<%=sDivJSA%>]; DivName = [<%=sDivNameJSA%>];}
  else if(Level=="010") { Dpt = [<%=sDptJSA%>]; DptName = [<%=sDptNameJSA%>]; }
  else if(Level=="001") { Cls = [<%=sClsJSA%>]; ClsName = [<%=sClsNameJSA%>]; }
}

var SelDiv = [<%=sSelDiv%>];

//--------------- End of Global variables ----------------
function bodyLoad()
{
  if(Store == "ALL" && !Combined) doSelectGrp();
  else
  {
    document.all.dvForm.style.visibility="hidden";
  }

  for(var i=0; i < 10; i++) { SelCol[i] = true; }
  setBoxclasses(["BoxName",  "BoxClose"], ["dvRepCol", "dvToolTip"]);

  // do not show some columns when 2 dates selected
  if(FromDate != "NONE"){ switchOffCol(); }
}


//
function doSelectGrp()
{
    formHtml = "<Form name='LevelDown' >"
    if (Store == "ALL" && (Level == "000" || Level == "200") || Level == "100" && Store != "ALL")
    {
      formHtml += "Select Division: <Select name='DIVISION' class='Small'></Select><br>"
      if (Store == "ALL" && Level == "000") formHtml += "<input name='LEVEL' value='100' type='hidden' >"
      else if (Store == "ALL" && Level == "200") formHtml += "<input name='LEVEL' value='020' type='hidden' >"
      else formHtml += "<input name='LEVEL' value='010' type='hidden'>"
    }
    else if (Store == "ALL" && (Level == "100" || Level == "020") || Level == "010" && Store != "ALL")
    {
      formHtml += "Select Department: <Select name='DEPARTMENT' class='Small'></Select><br>"
      if (Store == "ALL"  && Level == "100") formHtml += "<input  name='LEVEL' value='010' type='hidden'>"
      else if (Store == "ALL"  && Level == "020") formHtml += "<input  name='LEVEL' value='002' type='hidden'>"
      else formHtml += "<input  name='LEVEL' value='001' type='hidden'>"
    }
    else if (Store == "ALL" && Level == "010")
    {
      formHtml += "Select Class: <Select name='CLASS' class='Small'></Select><br>"
      formHtml += "<input name='LEVEL' value='001' type='hidden'>"
    }

    formHtml += "<input name='STORE' value='<%=sStore%>' type='hidden'>"
    formHtml += "<input name='FromDt' value='<%=sFromDt%>' type='hidden'>"

    // show submit button for next level down
    if (Level != "001" && Level != "002")
    {
      formHtml += "<input type='Submit' name='submit' value='  Go  ' class='Small'>"
    }

        // show submit button to get for this level and by store
    if(Combined)
    {
      formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<input type='Submit' name='ByStore' value='SbmByStore' onclick='checkLevel();' class='Small'>"
    }

    formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<input type='BUTTON' name='Back' value='Back' onClick='javascript:history.back()' class='Small'>"
      + "</Form>"

    document.all.dvForm.innerHTML=formHtml
    document.all.dvForm.style.visibility="visible";

    if( Store == "ALL" && (Level == "000" || Level == "200")
     || Level == "100" && Store != "ALL")
             for(var i=0; i < Div.length;i++){ document.LevelDown.DIVISION.options[i] = new Option(Div[i] + " - " + unescape(DivName[i]), Div[i]); }
    else if( Store == "ALL" && (Level == "100" || Level == "020")
          || Level == "010" && Store != "ALL")
             for(var i=0; i < Dpt.length;i++){ document.LevelDown.DEPARTMENT.options[i] = new Option(Dpt[i] + " - " + unescape(DptName[i]), Dpt[i]); }
    else if( Store == "ALL" && (Level == "010" || Level == "002")
          || Level == "001" && Store != "ALL")
             for(var i=0; i < Cls.length;i++){ document.LevelDown.CLASS.options[i] = new Option(Cls[i] + " - " + unescape(ClsName[i]), Cls[i]); }
}

//==============================================================================
// drill down by Div/dpt/class
//==============================================================================
function drillDown(arg)
{
  var url = "WkSlsTrend.jsp?"
  var group = "";
  var idx = 0;
  for (i=0; i<Grp[arg].length; i++)
  {
    if(Grp[arg].substring(i, i+1) != "-") group += Grp[arg].substring(i, i+1);
    else break;
  }

  for(var i=0; i < Store.length; i++) {  url += "&Str=" + Store[i]; }

  if (Store.length > 1)
  {
    if(Level == "D") { url += "&Div=" + group + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=P"; }
    else if(Level == "P"){ url += "&Div=<%=sDivision[0]%>&DEPARTMENT=" + group + "&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=C"; }
    else if(Level == "C"){ url += "&Div=<%=sDivision[0]%>&DEPARTMENT=<%=sDepartment%>&CLASS=" + group + "&VENDOR=<%=sVendor%>&LEVEL=S"; }
  }
  else
  {
    if(Level == "D") { url += "&Div=" + group + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=P"}
    else if(Level == "P"){ url += "&Div=<%=sDivision[0]%>&DEPARTMENT=" + group + "&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=C"}
  }

    url += "&FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>"
      + "&SORT=<%=sSortBy%>&selAmtType=<%=sAmtType%>";
  //alert(url);
  window.location.href = url;
}
//==============================================================================
// Show data by Store
//==============================================================================
function showByStore(drill, grp)
{
  var url = "WkSlsTrend.jsp?"

  var group = "";
  var idx = 0;

  for (i=0; i<grp.length; i++)
  {
    if(grp.substring(i, i+1) != "-") group += grp.substring(i, i+1);
    else break;
  }

  for(var i=0; i < Store.length; i++) {  url += "&Str=" + Store[i]; }

  if (drill)
  {
    if(Level == "D") { url += "&Div=" + group + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=S"}
    else if(Level == "P"){ url += "&Div=<%=sDivision[0]%>&DEPARTMENT=" + group + "&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=S" }
    else if(Level == "C"){ url += "&Div=<%=sDivision[0]%>&DEPARTMENT=<%=sDepartment%>&CLASS=" + group + "&VENDOR=<%=sVendor%>&LEVEL=S"}
  }
  else
  {
     for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]; }
     url += "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=S"
  }
  url += "&FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>"
      + "&SORT=<%=sSortBy%>&selAmtType=<%=sAmtType%>";
  //alert(url);
  window.location.href = url;
}
//==============================================================================
// drill down by Div/dpt/class
//==============================================================================
function showByDivision(str)
{
  var arg = 0;
  for(;arg < Store.length; arg++)
  {
     if(str == Store[arg]){break;}
  }

  var url = "WkSlsTrend.jsp?&Str=" + Store[arg];
  var dpt = "<%=sDepartment%>";
  var cls = "<%=sClass%>";

  for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]; }
  url += "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>"

  if((SelDiv[0] == "ALL" || SelDiv.length > 1) && dpt == "ALL" && cls == "ALL") url += "&LEVEL=D"
  else if(dpt == "ALL" && cls == "ALL") url += "&LEVEL=P"
  else url += "&LEVEL=C"

  url += "&FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>"
       + "&SORT=<%=sSortBy%>"
       + "&selAmtType=<%=sAmtType%>"

  //alert(url);
  window.location.href = url;
}

//==============================================================================
// resort
//==============================================================================
function reSort(sort)
{
  var url = "WkSlsTrend.jsp?"
  for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]; }

  url += "&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=<%=sLevel%>"
          + "&FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>"
          + "&selAmtType=<%=sAmtType%>"
          + "&SORT=" + sort;
  for(var i=0; i < Store.length; i++) {  url += "&Str=" + Store[i]; }

  //alert(url);
  window.location.href = url;
}
//==============================================================================
// Switch between Reatil and Units
//==============================================================================
function switchAmtType(type)
{
  if (SortBy != "GROUP" && type=="R") SortBy = "R" + SortBy.substring(1);
  else if (SortBy != "GROUP" && type=="U") SortBy = "U" + SortBy.substring(1);

  var url = "WkSlsTrend.jsp?"
  for(var i=0; i < SelDiv.length; i++){ url += "&Div=" + SelDiv[i]; }
  url += "&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=<%=sClass%>&VENDOR=<%=sVendor%>&LEVEL=<%=sLevel%>"
          + "&FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>"
          + "&selAmtType=" + type
          + "&SORT=" + SortBy;
  for(var i=0; i < Store.length; i++) {  url += "&Str=" + Store[i]; }
  //alert(url);
  window.location.href = url;
}

//-----------------------------------------------------------------------
// Select report columns to be displayed
//-----------------------------------------------------------------------
function selRepCol()
{
   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Select Report Columns</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
   //vendor totals

   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Retail Sales (W-T-D)</td>"
        + "</tr>"
   html += "<tr class='DataTable2<%if(!sFromDt.equals("NONE")){%>h<%}%>' >"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Retail Sales (M-T-D)</td>"
        + "</tr>"
   html += "<tr class='DataTable2<%if(!sFromDt.equals("NONE")){%>h<%}%>'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox' >Retail Inventory on Hand</td>"
        + "</tr>"
   html += "<tr class='DataTable2<%if(!sFromDt.equals("NONE")){%>h<%}%>'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Retail Sales (Y-T-D)</td>"
        + "</tr>"
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Gross Margin Week</td>"
        + "</tr>"
   html += "<tr class='DataTable2<%if(!sFromDt.equals("NONE")){%>h<%}%>'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Gross Margin Month</td>"
        + "</tr>"
   html += "<tr class='DataTable2<%if(!sFromDt.equals("NONE")){%>h<%}%>'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Gross Margin Year</td>"
        + "</tr>"

   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Gross Margin Percents Week</td>"
        + "</tr>"
   html += "<tr class='DataTable2<%if(!sFromDt.equals("NONE")){%>h<%}%>'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Gross Margin Percents Month</td>"
        + "</tr>"
   html += "<tr class='DataTable2<%if(!sFromDt.equals("NONE")){%>h<%}%>'>"
          + "<td class='DataTable1' nowrap colspan='2'><input name='RepCol' type='checkbox'>Gross Margin Percents Year</td>"
        + "</tr>"

   html += "<tr class='DataTable2'>"
          + "<td class='DataTable3' colspan='2'><button class='Small' id='Submit' onClick='showRepCol();'>Show</td>"
        + "</tr>"

   html += "</table>"

   document.all.dvRepCol.innerHTML = html;
   document.all.dvRepCol.style.pixelLeft= 400;
   document.all.dvRepCol.style.pixelTop= 200;
   document.all.dvRepCol.style.visibility = "visible";

   for(var i=0; i < 10; i++) { if(SelCol[i]) document.all.RepCol[i].checked = true; }
}
//-----------------------------------------------------------------------
// Show report columns
//-----------------------------------------------------------------------
function showRepCol()
{
   // retail Sales week ending date
   if(document.all.RepCol[0].checked) { showSingleRepCol(document.all.RSWK, "block");  SelCol[0] = true; }
   else { showSingleRepCol(document.all.RSWK, "none");  SelCol[0] = false; }

   // retail Sales M-T-D
   if(document.all.RepCol[1].checked) { showSingleRepCol(document.all.RSMN, "block");  SelCol[1] = true; }
   else { showSingleRepCol(document.all.RSMN, "none");  SelCol[1] = false; }

   // retail inventory on hand
   if(document.all.RepCol[2].checked) { showSingleRepCol(document.all.RIOH, "block");  SelCol[2] = true; }
   else { showSingleRepCol(document.all.RIOH, "none");  SelCol[2] = false; }

   // retail Sales Y-T-D
   if(document.all.RepCol[3].checked) { showSingleRepCol(document.all.RSYR, "block");  SelCol[3] = true; }
   else { showSingleRepCol(document.all.RSYR, "none");  SelCol[3] = false; }

   // Gross Margin Week
   if(document.all.RepCol[4].checked) { showSingleRepCol(document.all.GMWK, "block");  SelCol[4] = true; }
   else { showSingleRepCol(document.all.GMWK, "none");  SelCol[4] = false; }

   // Gross Margin Month
   if(document.all.RepCol[5].checked) { showSingleRepCol(document.all.GMMN, "block");  SelCol[5] = true; }
   else { showSingleRepCol(document.all.GMMN, "none");  SelCol[5] = false; }

   // Gross Margin Year
   if(document.all.RepCol[6].checked) { showSingleRepCol(document.all.GMYR, "block");  SelCol[6] = true; }
   else { showSingleRepCol(document.all.GMYR, "none");  SelCol[6] = false; }

   if(SelCol[4] || SelCol[5] || SelCol[6]) { showSingleRepCol(document.all.GMDL, "block");}
   else  { showSingleRepCol(document.all.GMDL, "none"); }



   // Gross Margin % Week
   if(document.all.RepCol[7].checked) { showSingleRepCol(document.all.GPWK, "block");  SelCol[7] = true; }
   else { showSingleRepCol(document.all.GMWK, "none");  SelCol[7] = false; }

   // Gross Margin % Month
   if(document.all.RepCol[8].checked) { showSingleRepCol(document.all.GPMN, "block");  SelCol[8] = true; }
   else { showSingleRepCol(document.all.GMMN, "none");  SelCol[8] = false; }

   // Gross Margin % Year
   if(document.all.RepCol[9].checked) { showSingleRepCol(document.all.GPYR, "block");  SelCol[9] = true; }
   else { showSingleRepCol(document.all.GMYR, "none");  SelCol[9] = false; }

   if(SelCol[7] || SelCol[8] || SelCol[9]) { showSingleRepCol(document.all.GMPR, "block");}
   else  { showSingleRepCol(document.all.GMPR, "none"); }

   hidePanel()
}
//==============================================================================
// switch off columns if date range selected
//==============================================================================
function switchOffCol()
{
   // retail Sales M-T-D

   document.all.GMDL[1].colSpan = 4;
   document.all.GMPR[1].colSpan = 2;
   showSingleRepCol(document.all.RSMN, "none");  SelCol[1] = false;
   showSingleRepCol(document.all.RIOH, "none");  SelCol[2] = false;
   showSingleRepCol(document.all.RSYR, "none");  SelCol[3] = false;
   showSingleRepCol(document.all.GMMN, "none");  SelCol[5] = false;
   showSingleRepCol(document.all.GMYR, "none");  SelCol[6] = false;
   showSingleRepCol(document.all.GPMN, "none");  SelCol[8] = false;
   showSingleRepCol(document.all.GPYR, "none");  SelCol[9] = false;
}
//-----------------------------------------------------------------------
// Show report columns
//-----------------------------------------------------------------------
function showSingleRepCol(col, show)
{
   for(var j=0; j < col.length; j++) { col[j].style.display = show; }
}
//-----------------------------------------------------------------------
// hide panel
//-----------------------------------------------------------------------
function hidePanel(){ document.all.dvRepCol.style.visibility = "hidden"; }

//==============================================================================
// show prompt text
//==============================================================================
function showToolTips(text, obj )
{
   var pos = getObjPosition(obj);

   document.all.dvToolTip.innerHTML = text;
   document.all.dvToolTip.style.pixelLeft=pos[0] + 35;
   document.all.dvToolTip.style.pixelTop=pos[1] - 10;
   document.all.dvToolTip.style.visibility = "visible";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<!-- ======================================================================= -->
<body onload="bodyLoad()">
<!-- ======================================================================= -->
<div id="dvRepCol" class="dvRepCol"></div>
<div id="dvToolTip" class="dvToolTip"></div>
<!-- ======================================================================= -->

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="left" width="300">
       <div id="dvForm" class="dvForm"></div>
      </td>
<!-------------------------------------------------------------------->
      <td ALIGN="left" VALIGN="TOP" style="padding-left:10px;padding-top:3px; padding-right:10px;" nowrap>
        <div id="selBox" class="selBox">
           <u>Report Selections</u>
           <br>Store: <b>
           <%String sComa = "";
             for(int i=0; i < sStore.length; i++){%><%=sComa%><%if(i == 11)%><br> &nbsp; &nbsp; <%=sStore[i]%><%sComa=", ";%><%}%>
           </b>
           <br>Div: <b>
           <%sComa = "";
             for(int i=0; i < sDivision.length; i++){%><%=sComa%><%if(i == 11)%><br> &nbsp; &nbsp; <%=sDivision[i]%><%sComa=", ";%><%}%>
           </b>
           <br>Dpt: <b><%=sSelDpt%></b>
           <br>Class: <b><%=sSelCls%></b>
           <br>Vendor: <b><%=sVendor%></b>
           </div>
      </td>
<!-------------------------------------------------------------------->

      <td ALIGN="center" VALIGN="TOP" nowrap>
        <b>Retail Concepts, Inc
        <br>Sales Trend by Class Report
        <br>
        <%if(sFromDt.equals("NONE")){%>Week Ending: <%=sToDt%>&nbsp;&nbsp<%}
          else {%>From Week: <%=sFromDt%>&nbsp;&nbsp To Week: <%=sToDt%>&nbsp;&nbsp<%}%>
        <br><%=sSortTitle%></b>
      </td>

      <td ALIGN="left" width="500">&nbsp;</td>
    </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan=4>

      <a href="<%if(!bKiosk) {%>index.jsp<%} else {%>Outsider.jsp<%}%>"><font color="red" size="-1">Home</font></a>&#62;
      <a href="WkSlsTrendSel.jsp"><font color="red" size="-1">Report Selection</font></a>&#62;

      <font size="-1">This Page.
          &nbsp;&nbsp;&nbsp;&nbsp;
          <a href="javascript:selRepCol();">Select Report Column</a>
          &nbsp;&nbsp;&nbsp;&nbsp;
          <a href="javascript: switchAmtType('<%if(sAmtType.equals("R")){%>U<%} else {%>R<%}%>')">Switch to <%if(sAmtType.equals("R")){%>Units<%} else {%>Retails<%}%></a>
          </font>


<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable"  rowspan="3"><a href="javascript: reSort('GROUP')"><%=sColName%></a></th>
          <th class="DataTable"  rowspan="3">
            <%if(!sLevel.equals("S") && sStore.length > 1 ){%>
                <a href="javascript: showByStore(false, 0)">B<br>y<br>S<br>t<br>r</a><%}
              else{%>&nbsp;&nbsp;<%}%></th>

          <%if(sAmtType.equals("R")){%>
            <th class="DataTable"  rowspan="2" id="RSWK" colspan="4" >Retail Sales<br>Week Ending Date</th>
            <th class="DataTable"  rowspan="3">&nbsp;&nbsp;</th>
            <th class="DataTable"  rowspan="2" id="RSMN" colspan="4">Retail Sales<br>Month To Date</th>
            <th class="InvData"  rowspan="3">&nbsp;&nbsp;</th>

            <th class="InvData"  rowspan="2" id="RIOH" colspan="5">Retail Inventory<br>On Hand</th>
            <th class="DataTable"  rowspan="3">&nbsp;&nbsp;</th>

            <th class="DataTable"  rowspan="2" id="RSYR" colspan="4">Retail Sales<br>Year To Date</th>
          <%}
            else if(sAmtType.equals("U")){%>
            <th class="DataTable"  rowspan="2" id="RSWK" colspan="4">Unit Sales<br>Week Ending Date</th>
            <th class="DataTable"  rowspan="3">&nbsp;&nbsp;</th>
            <th class="DataTable"  rowspan="2" id="RSMN" colspan="4">Unit Sales<br>Month To Date</th>
            <th class="InvData"  rowspan="3">&nbsp;&nbsp;</th>

            <th class="InvData"  rowspan="2" id="RIOH" colspan="4">Unit Inventory<br>On Hand</th>
            <th class="DataTable"  rowspan="3">&nbsp;&nbsp;</th>

            <th class="DataTable"  rowspan="2" id="RSYR" colspan="4">Unit Sales<br>Year To Date</th>
          <%}%>

          <th class="DataTable" id="GMDL">&nbsp;&nbsp;</th>
          <th class="DataTable" id="GMDL" colspan="14">Gross Margin Dollars</th>
          <th class="DataTable" id="GMPR">&nbsp;&nbsp;</th>
          <th class="DataTable" id="GMPR" colspan="7">Gross Margin Percents</th>
        </tr>
        <tr>
          <th class="DataTable" id="GMWK" rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable" id="GMWK" colspan="4">Week</th>
          <th class="DataTable" id="GMMN" rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable" id="GMMN" colspan="4">Month</th>
          <th class="DataTable" id="GMYR" rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable" id="GMYR" colspan="4">Year</th>

          <th class="DataTable" id="GPWK" rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable" id="GPWK" colspan="2">Week</th>
          <th class="DataTable" id="GPMN" colspan="2">Month</th>
          <th class="DataTable" id="GPYR" colspan="2">Year</th>
        </tr>
        <tr>
          <th class="DataTable" id="RSWK"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>WKT')">TY</a></th>
          <th class="DataTable" id="RSWK"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>WKL')">LY</a></th>
          <th class="DataTable" id="RSWK"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>WKD')">Var</a><br>(<%=sVarName%>)</th>
          <th class="DataTable" id="RSWK"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>WKV')">Var</a><br>(%)</th>

          <th class="DataTable" id="RSMN"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>MNT')">TY</a></th>
          <th class="DataTable" id="RSMN"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>MNL')">LY</a></th>
          <th class="DataTable" id="RSMN"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>MND')">Var</a><br>(<%=sVarName%>)</th>
          <th class="DataTable" id="RSMN"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>MNV')">Var</a><br>(%)</th>

          <th class="InvData" id="RIOH"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>INT')">TY</a></th>
	  <th class="InvData" id="RIOH"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>INL')">LY</a></th>
          <th class="InvData" id="RIOH"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>IND')">Var</a><br>(<%=sVarName%>)</th>
          <th class="InvData" id="RIOH"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>INV')">Var</a><br>(%)</th>
          <%if(sAmtType.equals("R")){%><th class="InvData" id="RIOH" onmouseover="showToolTips('Based on most current week&#180;s sales', this )" onmouseout='document.all.dvToolTip.style.visibility = &#34;hidden&#34;;'><a href="javascript: reSort('RSSR')">Stock</a><br>/Sales Ratio</th><%}%>

          <th class="DataTable" id="RSYR"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>YRT')">TY</a></th>
          <th class="DataTable" id="RSYR"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>YRL')">LY</a></th>
          <th class="DataTable" id="RSYR"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>YRD')">Var</a><br>(<%=sVarName%>)</th>
          <th class="DataTable" id="RSYR"><a href="javascript: reSort('<%if(sAmtType.equals("R")){%>R<%} else {%>U<%}%>YRV')">Var</a><br>(%)</th>

          <th class="DataTable" id="GMWK"><a href="javascript: reSort('GWKT')">TY</a></th>
          <th class="DataTable" id="GMWK"><a href="javascript: reSort('GWKL')">LY</a></th>
          <th class="DataTable" id="GMWK"><a href="javascript: reSort('GWKD')">Var</a><br>($)</th>
          <th class="DataTable" id="GMWK"><a href="javascript: reSort('GWKV')">Var</a><br>(%)</th>

          <th class="DataTable" id="GMMN"><a href="javascript: reSort('GMNT')">TY</a></th>
          <th class="DataTable" id="GMMN"><a href="javascript: reSort('GMNL')">LY</a></th>
          <th class="DataTable" id="GMMN"><a href="javascript: reSort('GMND')">Var</a><br>($)</th>
          <th class="DataTable" id="GMMN"><a href="javascript: reSort('GMNV')">Var</a><br>(%)</th>

          <th class="DataTable" id="GMYR"><a href="javascript: reSort('GYRT')">TY</a></th>
          <th class="DataTable" id="GMYR"><a href="javascript: reSort('GYRL')">LY</a></th>
          <th class="DataTable" id="GMYR"><a href="javascript: reSort('GYRD')">Var</a><br>($)</th>
          <th class="DataTable" id="GMYR"><a href="javascript: reSort('GYRV')">Var</a><br>(%)</th>

          <th class="DataTable" id="GPWK">TY</th>
          <th class="DataTable" id="GPWK">LY</th>
          <th class="DataTable" id="GPMN">TY</th>
          <th class="DataTable" id="GPMN">LY</th>
          <th class="DataTable" id="GPYR">TY</th>
          <th class="DataTable" id="GPYR">LY</th>
	 </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfSls; i++) {%>


           <%if(sLevel.equals("S")){%>
              <tr class="DataTable">
                <td class="DataTable1" nowrap>
                  <%if(sLevel.equals("S")){%>
                     <a href="javascript: showByDivision('<%=sGrp[i]%>')"><%=sGrp[i]%></a>
                  <%} else {%><%=sGrp[i]%><%}%></td>
                <th class="DataTable">&nbsp;</th>
            <%}
              else {%>
              <tr class="DataTable">
                <td class="DataTable1" nowrap>
                  <%if(!sLevel.equals("C")){%>
                     <a href="javascript:drillDown('<%=i%>')"><%=sGrp[i]%></a>
                  <%}
                    else {%><%=sGrp[i]%><%}%></td>
                <th class="DataTable">
                  <%if(!sLevel.equals("S") && sStore.length > 1) {%><a href="javascript: showByStore(true, '<%=sGrp[i]%>')">S</a><%} else{%>&nbsp;<%}%></th>
            <%}%>

            <%if(sAmtType.equals("R")){%>
                <td class="DataTable" id="RSWK" nowrap>$<%=sTyWkRet[i]%></td>
                <td class="DataTable" id="RSWK" nowrap>$<%=sLyWkRet[i]%></td>
                <td class="DataTable" id="RSWK" nowrap>$<%=sWkRetDiff[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sWkRetVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap id="RSMN">$<%=sTyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sLyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sMnRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSMN"><%=sMnRetVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap>$<%=sTyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sLyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sInvRetDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sInvRetVar[i]%>%</td>
                <td class="InvData" id="RIOH" nowrap><%=sWkStkRatio[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap>$<%=sTyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sLyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sYrRetDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sYrRetVar[i]%>%</td>
            <%}
              // in units
              else {%>
                <td class="DataTable" id="RSWK" nowrap><%=sTyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sLyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sWkUntDiff[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sWkUntVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" id="RSMN" nowrap><%=sTyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sLyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sMnUntDiff[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sMnUntVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap><%=sTyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sLyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sInvUntDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sInvUntVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap><%=sTyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sLyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sYrUntDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sYrUntVar[i]%>%</td>
            <%}%>

                <!--Gross Margin Week -->
                <th class="DataTable" id="GMWK">&nbsp;</th>
                <td class="DataTable" id="GMWK" nowrap>$<%=sTyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sLyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sWkGMrgDiff[i]%></td>
                <td class="DataTable" id="GMWK" nowrap><%=sWkGMrgVar[i]%>%</td>

                <!--Gross Margin Month -->
                <th class="DataTable" id="GMMN">&nbsp;</th>
                <td class="DataTable" id="GMMN" nowrap>$<%=sTyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sLyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sMnGMrgDiff[i]%></td>
                <td class="DataTable" id="GMMN" nowrap><%=sMnGMrgVar[i]%>%</td>

                <!--Gross Margin weekly -->
                <th class="DataTable" id="GMYR">&nbsp;</th>
                <td class="DataTable" id="GMYR" nowrap>$<%=sTyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sLyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sYrGMrgDiff[i]%></td>
                <td class="DataTable" id="GMYR" nowrap><%=sYrGMrgVar[i]%>%</td>


                <th class="DataTable" id="GPWK">&nbsp;</th>
                <td class="DataTable" id="GPWK" nowrap><%=sTyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPWK" nowrap><%=sLyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sTyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sLyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sTyYrGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sLyYrGmPrc[i]%>%</td>
              </tr>
           <%}%>
      <!------------------- Company Total -------------------------------->

      <!------------------- Mall/Non-Mall Total -------------------------------->
      <%if(sStore.length > 1){%>
         <tr class="DataTable4"><td class="DataTable2"></td></tr>
         <%for(int i=0; i < 2; i++) {%>
              <tr class="DataTable2">
                <td class="DataTable1" nowrap><%if(i==0){  out.print("Mall"); } else { out.print("Non-Mall"); }%></td>
                <th class="DataTable">&nbsp;</th>

             <%if(sAmtType.equals("R")){%>
                <td class="DataTable" nowrap id="RSWK" >$<%=sMallTyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sMallLyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sMallWkRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSWK" ><%=sMallWkRetVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" nowrap id="RSMN">$<%=sMallTyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sMallLyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sMallMnRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSMN"><%=sMallMnRetVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap>$<%=sMallTyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sMallLyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sMallInvRetDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sMallInvRetVar[i]%>%</td>
                <td class="InvData" id="RIOH" nowrap><%=sMallWkStkRatio[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap>$<%=sMallTyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sMallLyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sMallYrRetDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sMallYrRetVar[i]%>%</td>
             <%}
               else {%>
                <td class="DataTable" id="RSWK" nowrap><%=sMallTyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sMallLyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sMallWkUntDiff[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sMallWkUntVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSMN" nowrap><%=sMallTyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sMallLyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sMallMnUntDiff[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sMallMnUntVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap><%=sMallTyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sMallLyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sMallInvUntDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sMallInvUntVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap><%=sMallTyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sMallLyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sMallYrUntDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sMallYrUntVar[i]%>%</td>
             <%}%>

                <!--Gross Margin Week -->
                <th class="DataTable" id="GMWK">&nbsp;</th>
                <td class="DataTable" id="GMWK" nowrap>$<%=sMallTyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sMallLyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sMallWkGMrgDiff[i]%></td>
                <td class="DataTable" id="GMWK" nowrap><%=sMallWkGMrgVar[i]%>%</td>

                <!--Gross Margin Month -->
                <th class="DataTable" id="GMMN">&nbsp;</th>
                <td class="DataTable" id="GMMN" nowrap>$<%=sMallTyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sMallLyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sMallMnGMrgDiff[i]%></td>
                <td class="DataTable" id="GMMN" nowrap><%=sMallMnGMrgVar[i]%>%</td>

                <!--Gross Margin weekly -->
                <th class="DataTable" id="GMYR">&nbsp;</th>
                <td class="DataTable" id="GMYR" nowrap>$<%=sMallTyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sMallLyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sMallYrGMrgDiff[i]%></td>
                <td class="DataTable" id="GMYR" nowrap><%=sMallYrGMrgVar[i]%>%</td>

                <!-- GM % -->
                <th class="DataTable" id="GPWK">&nbsp;</th>
                <td class="DataTable" id="GPWK" nowrap><%=sMallTyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPWK" nowrap><%=sMallLyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sMallTyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sMallLyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sMallTyYrGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sMallLyYrGmPrc[i]%>%</td>
              </tr>
           <%}%>
         <%}%>


      <!------------------- DMM & Other Divisions Total ----------------------->
      <%if(sDivision[0].equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL")){%>
         <tr class="DataTable4"><td class="DataTable2"></td></tr>
         <%for(int i=0; i < iNumOfDmm; i++) {%>
              <tr class="DataTable5">
                <td class="DataTable1" nowrap><%=sDmmName[i]%></td>
                <th class="DataTable">&nbsp;</th>

            <%if(sAmtType.equals("R")){%>
                <td class="DataTable" nowrap id="RSWK" >$<%=sDmmTyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sDmmLyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sDmmWkRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSWK" ><%=sDmmWkRetVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap id="RSMN">$<%=sDmmTyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sDmmLyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sDmmMnRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSMN"><%=sDmmMnRetVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap>$<%=sDmmTyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sDmmLyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sDmmInvRetDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sDmmInvRetVar[i]%>%</td>
                <td class="InvData" id="RIOH" nowrap><%=sDmmWkStkRatio[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap>$<%=sDmmTyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sDmmLyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sDmmYrRetDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sDmmYrRetVar[i]%>%</td>
             <%}
               else {%>
                <td class="DataTable" id="RSWK" nowrap><%=sDmmTyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sDmmLyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sDmmWkUntDiff[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sDmmWkUntVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSMN" nowrap><%=sDmmTyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sDmmLyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sDmmMnUntDiff[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sDmmMnUntVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap><%=sDmmTyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sDmmLyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sDmmInvUntDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sDmmInvUntVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap><%=sDmmTyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sDmmLyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sDmmYrUntDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sDmmYrUntVar[i]%>%</td>
             <%}%>

                <!--Gross Margin Week -->
                <th class="DataTable" id="GMWK">&nbsp;</th>
                <td class="DataTable" id="GMWK" nowrap>$<%=sDmmTyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sDmmLyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sDmmWkGMrgDiff[i]%></td>
                <td class="DataTable" id="GMWK" nowrap><%=sDmmWkGMrgVar[i]%>%</td>

                <!--Gross Margin Month -->
                <th class="DataTable" id="GMMN">&nbsp;</th>
                <td class="DataTable" id="GMMN" nowrap>$<%=sDmmTyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sDmmLyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sDmmMnGMrgDiff[i]%></td>
                <td class="DataTable" id="GMMN" nowrap><%=sDmmMnGMrgVar[i]%>%</td>

                <!--Gross Margin weekly -->
                <th class="DataTable" id="GMYR">&nbsp;</th>
                <td class="DataTable" id="GMYR" nowrap>$<%=sDmmTyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sDmmLyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sDmmYrGMrgDiff[i]%></td>
                <td class="DataTable" id="GMYR" nowrap><%=sDmmYrGMrgVar[i]%>%</td>

                <!-- GM % -->
                <th class="DataTable" id="GPWK">&nbsp;</th>
                <td class="DataTable" id="GPWK" nowrap><%=sDmmTyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPWK" nowrap><%=sDmmLyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sDmmTyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sDmmLyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sDmmTyYrGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sDmmLyYrGmPrc[i]%>%</td>
              </tr>
           <%}%>
         <%}%>

      <!------------------- Regional Total -------------------------------->
      <%if(sLevel.equals("S")){%>
         <tr><td class="DataTable2"></td></tr>
         <%for(int i=0; i < 4; i++) {%>
              <tr class="DataTable1">
                <td class="DataTable1" nowrap>Region <%if(i==3){%>99<%} else {%><%=i+1%><%}%></td>
                <th class="DataTable">&nbsp;</th>

             <%if(sAmtType.equals("R")){%>
                <td class="DataTable" nowrap id="RSWK" >$<%=sRegTyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sRegLyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sRegWkRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSWK" ><%=sRegWkRetVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" nowrap id="RSMN">$<%=sRegTyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sRegLyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sRegMnRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSMN"><%=sRegMnRetVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap>$<%=sRegTyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sRegLyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sRegInvRetDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRegInvRetVar[i]%>%</td>
                <td class="InvData" id="RIOH" nowrap>$<%=sRegWkStkRatio[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap>$<%=sRegTyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sRegLyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sRegYrRetDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRegYrRetVar[i]%>%</td>
             <%}
               else {%>
                <td class="DataTable" id="RSWK" nowrap><%=sRegTyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sRegLyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sRegWkUntDiff[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sRegWkUntVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSMN" nowrap><%=sRegTyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sRegLyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sRegMnUntDiff[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sRegMnUntVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap><%=sRegTyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRegLyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRegInvUntDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRegInvUntVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap><%=sRegTyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRegLyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRegYrUntDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRegYrUntVar[i]%>%</td>
             <%}%>

                <!--Gross Margin Week -->
                <th class="DataTable" id="GMWK">&nbsp;</th>
                <td class="DataTable" id="GMWK" nowrap>$<%=sRegTyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sRegLyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sRegWkGMrgDiff[i]%></td>
                <td class="DataTable" id="GMWK" nowrap><%=sRegWkGMrgVar[i]%>%</td>

                <!--Gross Margin Month -->
                <th class="DataTable" id="GMMN">&nbsp;</th>
                <td class="DataTable" id="GMMN" nowrap>$<%=sRegTyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sRegLyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sRegMnGMrgDiff[i]%></td>
                <td class="DataTable" id="GMMN" nowrap><%=sRegMnGMrgVar[i]%>%</td>

                <!--Gross Margin weekly -->
                <th class="DataTable" id="GMYR">&nbsp;</th>
                <td class="DataTable" id="GMYR" nowrap>$<%=sRegTyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sRegLyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sRegYrGMrgDiff[i]%></td>
                <td class="DataTable" id="GMYR" nowrap><%=sRegYrGMrgVar[i]%>%</td>

                <!-- GM % -->
                <th class="DataTable" id="GPWK">&nbsp;</th>
                <td class="DataTable" id="GPWK" nowrap><%=sRegTyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPWK" nowrap><%=sRegLyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sRegTyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sRegLyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sRegTyYrGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sRegLyYrGmPrc[i]%>%</td>
              </tr>
           <%}%>
         <%}%>
      <!------------------- Report Total -------------------------------->
         <tr><td class="DataTable2"></td></tr>
         <%for(int i=0; i < 1; i++) {%>
              <tr class="DataTable3">
                <td class="DataTable1" nowrap>Totals</td>
                <th class="DataTable">&nbsp;</th>

            <%if(sAmtType.equals("R")){%>
                <td class="DataTable" nowrap id="RSWK" >$<%=sRepTyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sRepLyWkRet[i]%></td>
                <td class="DataTable" nowrap id="RSWK" >$<%=sRepWkRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSWK" ><%=sRepWkRetVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" nowrap id="RSMN">$<%=sRepTyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sRepLyMnRet[i]%></td>
                <td class="DataTable" nowrap id="RSMN">$<%=sRepMnRetDiff[i]%></td>
                <td class="DataTable" nowrap id="RSMN"><%=sRepMnRetVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap>$<%=sRepTyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sRepLyInvRet[i]%></td>
                <td class="InvData" id="RIOH" nowrap>$<%=sRepInvRetDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRepInvRetVar[i]%>%</td>
                <td class="InvData" id="RIOH" nowrap><%=sRepWkStkRatio[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap>$<%=sRepTyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sRepLyYrRet[i]%></td>
                <td class="DataTable" id="RSYR" nowrap>$<%=sRepYrRetDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRepYrRetVar[i]%>%</td>
             <%}
               else {%>
                <td class="DataTable" id="RSWK" nowrap><%=sRepTyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sRepLyWkUnt[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sRepWkUntDiff[i]%></td>
                <td class="DataTable" id="RSWK" nowrap><%=sRepWkUntVar[i]%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSMN" nowrap><%=sRepTyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sRepLyMnUnt[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sRepMnUntDiff[i]%></td>
                <td class="DataTable" id="RSMN" nowrap><%=sRepMnUntVar[i]%>%</td>

                <th class="InvData">&nbsp;</th>
                <td class="InvData" id="RIOH" nowrap><%=sRepTyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRepLyInvUnt[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRepInvUntDiff[i]%></td>
                <td class="InvData" id="RIOH" nowrap><%=sRepInvUntVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="RSYR" nowrap><%=sRepTyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRepLyYrUnt[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRepYrUntDiff[i]%></td>
                <td class="DataTable" id="RSYR" nowrap><%=sRepYrUntVar[i]%>%</td>
             <%}%>


                <!--Gross Margin Week -->
                <th class="DataTable" id="GMWK">&nbsp;</th>
                <td class="DataTable" id="GMWK" nowrap>$<%=sRepTyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sRepLyWkGMrg[i]%></td>
                <td class="DataTable" id="GMWK" nowrap>$<%=sRepWkGMrgDiff[i]%></td>
                <td class="DataTable" id="GMWK" nowrap><%=sRepWkGMrgVar[i]%>%</td>

                <!--Gross Margin Month -->
                <th class="DataTable" id="GMMN">&nbsp;</th>
                <td class="DataTable" id="GMMN" nowrap>$<%=sRepTyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sRepLyMnGMrg[i]%></td>
                <td class="DataTable" id="GMMN" nowrap>$<%=sRepMnGMrgDiff[i]%></td>
                <td class="DataTable" id="GMMN" nowrap><%=sRepMnGMrgVar[i]%>%</td>

                <!--Gross Margin weekly -->
                <th class="DataTable" id="GMYR">&nbsp;</th>
                <td class="DataTable" id="GMYR" nowrap>$<%=sRepTyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sRepLyYrGMrg[i]%></td>
                <td class="DataTable" id="GMYR" nowrap>$<%=sRepYrGMrgDiff[i]%></td>
                <td class="DataTable" id="GMYR" nowrap><%=sRepYrGMrgVar[i]%>%</td>

                <!-- GM % -->
                <th class="DataTable" id="GPWK">&nbsp;</th>
                <td class="DataTable" id="GPWK" nowrap><%=sRepTyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPWK" nowrap><%=sRepLyWkGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sRepTyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPMN" nowrap><%=sRepLyMnGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sRepTyYrGmPrc[i]%>%</td>
                <td class="DataTable" id="GPYR" nowrap><%=sRepLyYrGmPrc[i]%>%</td>
              </tr>
           <%}%>
      </table>
	  <p/>
	  <span>
	  Note:  For YTD analysis, Sun & Ski Cash is applied as a discount and reduces Retail Sales (on this page), but we do not reduce sales on the Flash Sales pages, so Total Retail Sales will not match between these two views. 
	  </span>
      <!----------------------- end of table ------------------------>
  </table>
<%
      long lEndTime = (new Date()).getTime();
      long lElapse = (lEndTime - lStartTime) / 1000;
      if (lElapse==0) lElapse = 1;
%>
<p style="font-size:10px;">Elapse: <%=lElapse%> sec
 </body>
</html>
