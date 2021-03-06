<!DOCTYPE html>
<%@ page import="flashreps.SalesTyLy, counterpoint.UplStrDailySls, java.util.*, java.text.DecimalFormat, java.text.SimpleDateFormat, rciutility.RunSQLStmt, java.sql.*, java.math.BigDecimal"%>
<%
   long lStartTime = (new java.util.Date()).getTime();

   String [] sStore = request.getParameterValues("Str"); 
   String sDivision = request.getParameter("Division");
   String sDepartment = request.getParameter("Department");
   String sClass = request.getParameter("Class");
   String sLevel = request.getParameter("Level");
   String sDate = request.getParameter("Date");
   String sPeriod = request.getParameter("Period");
   String sSort = request.getParameter("Sort");
   String sChall = request.getParameter("Chall");

   if(sStore == null) { sStore = new  String[]{"ALL"}; }
   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sLevel == null) sLevel = "S";
   if(sSort == null) sSort = "MTDVAR";
   if(sChall == null) sChall = " ";
   if(sDivision.length() < 2) sDivision += " ";
   if(sDepartment.length() < 3) sDepartment += "  ";
   if(sPeriod == null) sPeriod = "YTDTYLY1";

   //===========================================================================
   // check last date
   //===========================================================================
   String sPrepStmt = "select char(fddate, USA) as lastdate, fddate from rci.fladly where fdtype='S' and fddate <= current date - 1 days and fdgrp=3 order by fddate desc";
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   String sError = runsql.getError();
   String sLastDate = null;
   if (runsql.readNextRecord())
   {
      sLastDate = runsql.getData("lastdate");
      if(sDate == null) sDate = sLastDate;
   }

   //===========================================================================
   // check if date is no today date
   sPrepStmt = "select char(piwe, USA) as wkend from rci.fsyper where piwe='" + sLastDate + "'";
   rslset = null;
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   sError = runsql.getError();

   boolean bMonday = false;
   if (runsql.readNextRecord())
   {
      String sLastISO = runsql.getData("wkend");
      if(sLastDate != null && sLastISO.equals(sLastDate)) { bMonday = true; }
   }
   //===========================================================================

   /*System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
          + sStore + " " + sDate + " " + sLevel + " " + sPeriod + " " + sSort + " " + sChall);*/

    SalesTyLy slsTyLy = new SalesTyLy(sDivision, sDepartment, sClass, sStore, sDate,
                                      sPeriod, sLevel, sSort, sChall);
    int iNumOfGrp = slsTyLy.getNumOfGrp();
    String [] sGrp = slsTyLy.getGrp();
    String [] sGrpName = slsTyLy.getGrpName();    

    String [] sTyDate = slsTyLy.getTyDate();
    String [] sLyDate = slsTyLy.getLyDate();
    String [] sTyHol = slsTyLy.getTyHol();
    String [] sLyHol = slsTyLy.getLyHol();

    int iNumOfReg = slsTyLy.getNumOfReg();
    String [] sReg = slsTyLy.getReg();
    int [] iNumOfStrInReg = slsTyLy.getNumStrInReg();
    String [][] sStr = slsTyLy.getStr();

    String [][] sTySls = slsTyLy.getTySls();
    String [][] sLySls = slsTyLy.getLySls();
    String [][] sDlyPrc = slsTyLy.getDlyPrc();
    String [][] sPrecPrc = slsTyLy.getPrecPrc();

    // Mall / Ski totals
    String [] sMall = slsTyLy.getMall();
    String [][] sMallTySls = slsTyLy.getMallTySls();
    String [][] sMallLySls = slsTyLy.getMallLySls();
    String [][] sMallDlyPrc = slsTyLy.getMallDlyPrc();

    // patio / non-patio totals
    String [] sPatio = slsTyLy.getPatio();
    String [][] sPatioTySls = slsTyLy.getPatioTySls();
    String [][] sPatioLySls = slsTyLy.getPatioLySls();
    String [][] sPatioDlyPrc = slsTyLy.getPatioDlyPrc();

    // Region totals
    String [][] sRegTySls = slsTyLy.getRegTySls();
    String [][] sRegLySls = slsTyLy.getRegLySls();
    String [][] sRegDlyPrc = slsTyLy.getRegDlyPrc();

    // Region comp store totals
    String [][] sRegCompTySls = slsTyLy.getRegCompTySls();
    String [][] sRegCompLySls = slsTyLy.getRegCompLySls();
    String [][] sRegCompDlyPrc = slsTyLy.getRegCompDlyPrc();
    String [][] sRegCompComPrc = slsTyLy.getRegCompComPrc();

    // Comp Store totals
    int iNumOfCompStr = 0;
    String [] sCompStr = null;

    // Report totals
    String [] sRepTySls = slsTyLy.getRepTySls();
    String [] sRepLySls = slsTyLy.getRepLySls();
    String [] sRepDlyPrc = slsTyLy.getRepDlyPrc();

    // Selected Parameters Names
    String sSelDivName = slsTyLy.getSelDivName();
    String sSelDptName = slsTyLy.getSelDptName();
    String sSelClsName = slsTyLy.getSelClsName();
    String sSelStrName = slsTyLy.getSelStrName();

    // Temperature outside store
    int iNumOfStr = slsTyLy.getNumOfStr();
    String [] sTempStr = slsTyLy.getTempStr();
    String [][] sTyTempMin = slsTyLy.getTyTempMin();
    String [][] sTyTempMax = slsTyLy.getTyTempMax();
    String [][] sLyTempMin = slsTyLy.getLyTempMin();
    String [][] sLyTempMax = slsTyLy.getLyTempMax();
    String [] sTyTempAvg = slsTyLy.getTyTempAvg();
    String [] sLyTempAvg = slsTyLy.getLyTempAvg();
    // company total of temperature outside store
    String [] sTyTotTempMin = slsTyLy.getTyTotTempMin();
    String [] sTyTotTempMax = slsTyLy.getTyTotTempMax();
    String [] sLyTotTempMin = slsTyLy.getLyTotTempMin();
    String [] sLyTotTempMax = slsTyLy.getLyTotTempMax();
    String sTyTotTempAvg = slsTyLy.getTyTotTempAvg();
    String sLyTotTempAvg = slsTyLy.getLyTotTempAvg();

    String sArchv = slsTyLy.getArchvJsa();
    String sFutur = slsTyLy.getFuturJsa();

    String sColName = "Str";
    if (sLevel.equals("D")) sColName = "Div";
    if (sLevel.equals("P")) sColName = "Dpt";
    if (sLevel.equals("C")) sColName = "Cls";

    String sLyCol = "LY";
    if (sPeriod.substring(5).equals("PLAN")) sLyCol = "Plan";

    String sDispBy = null;

    if (!sLevel.equals("S")) sDispBy = "Str";
    else if ((sDivision.equals("ALL") || sDivision.substring(0, 2).equals("SK"))&& sDepartment.equals("ALL") && sClass.equals("ALL")) sDispBy = "Div";
    else if (!sDivision.equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL")) sDispBy = "Dpt";
    else if (!sDepartment.equals("ALL") || !sClass.equals("ALL")) sDispBy = "Cls";

    long lEndTime = (new java.util.Date()).getTime();
    long lElapse = (lEndTime - lStartTime) / 1000;
    if (lElapse==0) lElapse = 1;
    //==========================================================================
    // get today sales
    //==========================================================================
    BigDecimal [] bdSalesDaily = new BigDecimal[iNumOfGrp];
    BigDecimal bdSDRep = BigDecimal.valueOf(0);
    BigDecimal bdSDCompN70 = BigDecimal.valueOf(0);
    BigDecimal bdSDComp = BigDecimal.valueOf(0);
    BigDecimal [] bdSDMall = new BigDecimal[2];
    bdSDMall[0] = BigDecimal.valueOf(0);  bdSDMall[1] = BigDecimal.valueOf(0);
    BigDecimal [] bdSDReg = new BigDecimal[5];
    BigDecimal [] bdSDRegComp = new BigDecimal[5];

    for(int i=0; i < bdSDReg.length; i++){ bdSDReg[i] = BigDecimal.valueOf(0); }
    for(int i=0; i < bdSDRegComp.length; i++){ bdSDRegComp[i] = BigDecimal.valueOf(0); }

    String [] sSDMall = new String[2];
    String [] sSDReg = new String[bdSDReg.length];
    String [] sSDRegComp = new String[bdSDRegComp.length];
    String [] sSDComp = new String[2];
    String sSDRep = null;
    String [] sSalesDaily = new String[iNumOfGrp];
    DecimalFormat df = new DecimalFormat("###,###,###");

    String [] sStrLst = new String[]{
       "3",  "4",  "5",  "6", "8", "10", "11", "16", "17", "20", "22", "28","29", "30", "35", "40",
       "42", "45","46", "50", "61", "63", "64", "66", "68", "70", "75", "82", "86", "87", "88", "89", "90",
       "91", "92", "93", "96", "98" };
    boolean [] bMall = new boolean[]{
    false,  true, false, false, false, false, false, false, false, false, false, false, false, false, false, true, true, true,
    false, false, false,  false, false, false, true,  true,  true,  true, false, true, true, true, true,
    false, false, false, false, true };
                           //3  4  5  6  8 10 11 16 17 20 22 28 29 30 35 40 42 45  
    int [] iReg  = new int[]{1, 1, 1, 1, 1, 2, 1, 2, 2, 1, 1, 2, 2, 2, 3, 1, 1, 1,
                         // 46 50 61 63 64 66 68 70 75 82 86 87 88 89 90
                             3, 3, 3, 3, 3, 2, 3, 4, 4, 1, 3, 2, 2, 4, 3,
                         // 91 92 93 96 98    
                             3, 3, 3, 3, 3 };
    boolean [] bCompStr = new boolean[]{
      // 3    4    5       6      8     10    11     16     17     20     22    28    29    30    35     40    42    45
      true, true, false, false,  true,  true, true, false, false, true, false, true, true, true, true,  true, true, true,
      true, true, true, true, true, true, true, true, true, true, true, true, true, true, true,
      false, true, true, true, true};

    for(int i=0, j=0; i < iNumOfGrp; i++)
    {
       for(j=0; j < sStrLst.length; j++)
       {
          if(sGrp[i].trim().equals(sStrLst[j]) ){ break; }
       }
       //System.out.println("j=" + j + " i=" + i + " grp=" + sGrp[i]); 
              
       UplStrDailySls dlySls = new UplStrDailySls();
       dlySls.getStrSales(sGrp[i].trim());
       bdSalesDaily[i] = dlySls.getSalesDlySum();
       bdSDRep = bdSDRep.add(bdSalesDaily[i]);
       

       // comp store
       /*System.out.println("j=" + j +  " len" + bCompStr.length 
         + " i=" + i + " bdSalesDaily.len=" + bdSalesDaily.length);*/
       if(bCompStr[j]){ bdSDComp = bdSDComp.add(bdSalesDaily[i]); }
       if(bCompStr[j] && !sStrLst[j].equals("70")){ bdSDCompN70 = bdSDCompN70.add(bdSalesDaily[i]); }

       sSalesDaily[i] = df.format(bdSalesDaily[i].doubleValue());

       //mall - non-mall
       if(bMall[j]){ bdSDMall[0] = bdSDMall[0].add(bdSalesDaily[i]); }
       else { bdSDMall[1] = bdSDMall[1].add(bdSalesDaily[i]); }

       bdSDReg[iReg[j]-1] = bdSDReg[iReg[j]-1].add(bdSalesDaily[i]);
       if(bCompStr[j]){ bdSDRegComp[iReg[j]-1] = bdSDRegComp[iReg[j]-1].add(bdSalesDaily[i]); }
    }


    sSDMall[0] = df.format(bdSDMall[0].doubleValue());
    sSDMall[1] = df.format(bdSDMall[1].doubleValue());

    for(int i=0; i < bdSDReg.length; i++){ sSDReg[i] = df.format(bdSDReg[i].doubleValue()); }
    for(int i=0; i < bdSDRegComp.length; i++){ sSDRegComp[i] = df.format(bdSDRegComp[i].doubleValue()); }

    sSDRep = df.format(bdSDRep.doubleValue());
    sSDComp[0] = df.format(bdSDCompN70.doubleValue());
    sSDComp[1] = df.format(bdSDComp.doubleValue());

    // day of week
    Calendar calendar = Calendar.getInstance();
    int icalwd = calendar.get(Calendar.DAY_OF_WEEK);
    int iWeekday = 6;
    if(icalwd > 1){ iWeekday = -2 + icalwd; }
    
    
    int [] iColWidth = new int[]{ 13, 4,8,8,8,4,10,10,4,10,10,4,10,10,4, 13 };
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<Meta http-equiv="refresh">
</head>

<body>
<div id="dvPrecPrc" style="position:absolute; visibility:hidden; background-attachment: scroll;
               width:auto; color:darkred;background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px">
</div>
 	<!-- ======================= Clone Header ========================================== -->
    <table id="tblClone" class="DataTable" style="position: absolute; text-align: left" ></table>
    <!-- ======================= End of Clone Header =================================== -->
    
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table id="tblData" class="DataTable" cellPadding="0" cellSpacing="0">
        <tr id="trHdr01" class="TblHdr">
	      <td class="DataTable3"  rowspan="2">
            <a href="javascript: flashSlsSortBy('STR')">Str</a><br><br>
          </td>

          <td class="DataTable31" id="thDlySls" colspan="<%if(bMonday){%>1<%} else {%>2<%}%>">Today<br>Sales</td>
          <td class="DataTable31" colspan="3">Week To Date</td>
          <td class="DataTable31" colspan="3">Month To Date</td>
          <td class="DataTable31" colspan="3">Quarter To Date</td>
          <td class="DataTable31" colspan="3">Year To Date</td>
          
          <td class="DataTable3"  rowspan="2">
            <a href="javascript: flashSlsSortBy('STR')">Str</a><br><br>
          </td>
        </tr>

        <tr id="trHdr02" class="TblHdr">
          <td class="DataTable3" ><a href="javascript: flashSlsSortBy('WTDTY')">TY</a></td>
          <%if(!bMonday){%>
             <td class="DataTable3" ><a href="javascript: flashSlsSortBy('WTDLY')">LY</a></td>
          <%}%>
          <td class="DataTable3" ><a href="javascript: flashSlsSortBy('WTDTY')">TY</a></td>
          <td class="DataTable3" ><a href="javascript: flashSlsSortBy('WTDLY')">LY</a></td>
          <td class="DataTable31"><a href="javascript: flashSlsSortBy('WTDVAR')">Var</a></td>

          <td class="DataTable3" ><a href="javascript: flashSlsSortBy('MTDTY')">TY</a></td>
          <td class="DataTable3" ><a href="javascript: flashSlsSortBy('MTDLY')">LY</a></td>
          <td class="DataTable31" ><a href="javascript: flashSlsSortBy('MTDVAR')">Var</a></td>
          <td class="DataTable3"><a href="javascript: flashSlsSortBy('QTDTY')">TY</a></td>
          <td class="DataTable3"><a href="javascript: flashSlsSortBy('QTDLY')"><%=sLyCol%></a></td>
          <td class="DataTable31"><a href="javascript: flashSlsSortBy('QTDVAR')">Var</a></td>
          <td class="DataTable3"><a href="javascript: flashSlsSortBy('YTDTY')">TY</a></td>
          <td class="DataTable3"><a href="javascript: flashSlsSortBy('YTDLY')"><%=sLyCol%></a></td>
          <td class="DataTable31"><a href="javascript: flashSlsSortBy('YTDVAR')">Var</a></td>
        </tr>
<!------------------------------- Data Detail --------------------------------->
      <% System.out.println("FlashHP=" + 2);
      for(int i=0; i < iNumOfGrp; i++) {%>
        <tr class="DataTable" onmouseover="setHiliFlashSls(this, true);" onmouseout="setHiliFlashSls(this, false);">
          <td class="DataTable41<%if(!sSort.equals("STR") && i < 5){%>4<%} else if(!sSort.equals("STR") && i > iNumOfGrp-6){%>5<%}%>" nowrap >
             <%=sGrp[i]%> -
             <%for(int m=0; m < iReg.length; m++){%>
                  <%if(sGrp[i].trim().equals(sStrLst[m])){%><%=iReg[m]%><%break;}%>
             <%}%>
          </td>

          <td class="DataTable41" id="tdDlySls"><%=sSalesDaily[i]%></td>
          <%if(!bMonday){%>
             <td class="DataTable41" id="tdDlySls"><%=sLySls[i][iWeekday]%></td>
          <%}%>

          <td class="DataTable4<%if(sSort.equals("WTDTY") && i < 5){%>04<%} else if(sSort.equals("WTDTY") && i > iNumOfGrp-6){%>05<%}%>"><%=sTySls[i][7]%></td>
          <td class="DataTable4<%if(sSort.equals("WTDLY") && i < 5){%>04<%} else if(sSort.equals("WTDLY") && i > iNumOfGrp-6){%>05<%}%>"><%=sLySls[i][7]%></td>
          <td class="DataTable41<%if(sSort.equals("WTDVAR") && i < 5){%>4<%} else if(sSort.equals("WTDVAR") && i > iNumOfGrp-6){%>5<%}%>" nowrap
              onmouseover="var pos = getObjPosition(this); document.all.dvPrecPrc.innerHTML = '<%=sPrecPrc[i][7]%>%';
                           document.all.dvPrecPrc.style.pixelLeft= pos[0] + 30; document.all.dvPrecPrc.style.pixelTop= pos[1]; document.all.dvPrecPrc.style.visibility = 'visible';"
              onmouseout="document.all.dvPrecPrc.style.visibility = 'hidden';"
          ><%=sDlyPrc[i][7]%>%</td>

          <td class="DataTable4<%if(sSort.equals("MTDTY") && i < 5){%>04<%} else if(sSort.equals("MTDTY") && i > iNumOfGrp-6){%>05<%}%>"><%=sTySls[i][9]%></td>
          <td class="DataTable4<%if(sSort.equals("MTDLY") && i < 5){%>04<%} else if(sSort.equals("MTDLY") && i > iNumOfGrp-6){%>05<%}%>"><%=sLySls[i][9]%></td>
          <td class="DataTable41<%if(sSort.equals("MTDVAR") && i < 5){%>4<%} else if(sSort.equals("MTDVAR") && i > (iNumOfGrp-6)){%>5<%}%>" nowrap
              onmouseover="var pos = getObjPosition(this); document.all.dvPrecPrc.innerHTML = '<%=sPrecPrc[i][9]%>%'; document.all.dvPrecPrc.style.pixelLeft= pos[0] + 30;  document.all.dvPrecPrc.style.pixelTop= pos[1]; document.all.dvPrecPrc.style.visibility = 'visible';"
              onmouseout="document.all.dvPrecPrc.style.visibility = 'hidden';"
              ><%=sDlyPrc[i][9]%>%</td>

          <td class="DataTable4<%if(sSort.equals("QTDTY") && i < 5){%>04<%} else if(sSort.equals("QTDTY") && i > iNumOfGrp-6){%>05<%}%>"><%=sTySls[i][11]%></td>
          <td class="DataTable4<%if(sSort.equals("QTDLY") && i < 5){%>04<%} else if(sSort.equals("QTDLY") && i > iNumOfGrp-6){%>05<%}%>"><%=sLySls[i][11]%></td>
          <td class="DataTable41<%if(sSort.equals("QTDVAR") && i < 5){%>4<%} else if(sSort.equals("QTDVAR") && i > (iNumOfGrp-6)){%>5<%}%>" nowrap
              onmouseover="var pos = getObjPosition(this); document.all.dvPrecPrc.innerHTML = '<%=sPrecPrc[i][11]%>%'; document.all.dvPrecPrc.style.pixelLeft= pos[0] + 30;  document.all.dvPrecPrc.style.pixelTop= pos[1]; document.all.dvPrecPrc.style.visibility = 'visible';"
              onmouseout="document.all.dvPrecPrc.style.visibility = 'hidden';"
          ><%=sDlyPrc[i][11]%>%</td>

          <td class="DataTable4<%if(sSort.equals("YTDTY") && i < 5){%>04<%} else if(sSort.equals("YTDTY") && i > iNumOfGrp-6){%>05<%}%>"><%=sTySls[i][12]%></td>
          <td class="DataTable4<%if(sSort.equals("YTDLY") && i < 5){%>04<%} else if(sSort.equals("YTDLY") && i > iNumOfGrp-6){%>05<%}%>"><%=sLySls[i][12]%></td>
          <td class="DataTable41<%if(sSort.equals("YTDVAR") && i < 5){%>4<%} else if(sSort.equals("YTDVAR") && i > iNumOfGrp-6){%>5<%}%>" nowrap
              onmouseover="var pos = getObjPosition(this); document.all.dvPrecPrc.innerHTML = '<%=sPrecPrc[i][12]%>%'; document.all.dvPrecPrc.style.pixelLeft= pos[0] + 30;  document.all.dvPrecPrc.style.pixelTop= pos[1]; document.all.dvPrecPrc.style.visibility = 'visible';"
              onmouseout="document.all.dvPrecPrc.style.visibility = 'hidden';"
          ><%=sDlyPrc[i][12]%>%</td>
          
          
          <td class="DataTable41<%if(!sSort.equals("STR") && i < 5){%>4<%} else if(!sSort.equals("STR") && i > iNumOfGrp-6){%>5<%}%>" nowrap >
             <%=sGrp[i]%> -
             <%for(int m=0; m < iReg.length; m++){%>
                  <%if(sGrp[i].trim().equals(sStrLst[m])){%><%=iReg[m]%><%break;}%>
             <%}%>
          </td>
        </tr>
      <%}%>

      <!------------------------ End Details ---------------------------------->
      <!------------------- Mall/Non-Mall Total or Non/-Ski Total ------------->
      <%for(int i=0; i < 2; i++) {%>
        <tr class="DataTable5">
         <td class="DataTable6"><%=sMall[i]%></td>
         <td class="DataTable41" id="tdMallDlySls"><%=sSDMall[i]%></td>
         <%if(!bMonday){%>
            <td class="DataTable41" id="tdMallDlySls"><%=sMallLySls[i][iWeekday]%></td>
         <%}%>

         <td class="DataTable4"><%=sMallTySls[i][7]%></td>
         <td class="DataTable4"><%=sMallLySls[i][7]%></td>
         <td class="DataTable41"><%=sMallDlyPrc[i][7]%>%</td>

         <td class="DataTable4"><%=sMallTySls[i][9]%></td>
         <td class="DataTable4"><%=sMallLySls[i][9]%></td>
         <td class="DataTable41"><%=sMallDlyPrc[i][9]%>%</td>

         <td class="DataTable4"><%=sMallTySls[i][11]%></td>
         <td class="DataTable4"><%=sMallLySls[i][11]%></td>
         <td class="DataTable41"><%=sMallDlyPrc[i][11]%>%</td>

         <td class="DataTable4"><%=sMallTySls[i][12]%></td>
         <td class="DataTable4"><%=sMallLySls[i][12]%></td>
         <td class="DataTable41"><%=sMallDlyPrc[i][12]%>%</td>
         
         <td class="DataTable6"><%=sMall[i]%></td>
       </tr>
      <%}%>
    <!------------------- End  Non/-Ski Total ------------------------------->

    <!------------------- Patio/Non-Patio Total ----------------------------->
      <%for(int i=0; i < 2; i++) {%>
        <tr class="DataTable5">
         <td class="DataTable6"><%=sPatio[i]%></td>
         <td class="DataTable41" id="tdMallDlySls">&nbsp;</td>
         <%if(!bMonday){%>
            <td class="DataTable41" id="tdMallDlySls"><%=sPatioLySls[i][iWeekday]%></td>
         <%}%>

         <td class="DataTable4"><%=sPatioTySls[i][7]%></td>
         <td class="DataTable4"><%=sPatioLySls[i][7]%></td>
         <td class="DataTable41"><%=sPatioDlyPrc[i][7]%>%</td>

         <td class="DataTable4"><%=sPatioTySls[i][9]%></td>
         <td class="DataTable4"><%=sPatioLySls[i][9]%></td>
         <td class="DataTable41"><%=sPatioDlyPrc[i][9]%>%</td>

         <td class="DataTable4"><%=sPatioTySls[i][11]%></td>
         <td class="DataTable4"><%=sPatioLySls[i][11]%></td>
         <td class="DataTable41"><%=sPatioDlyPrc[i][11]%>%</td>

         <td class="DataTable4"><%=sPatioTySls[i][12]%></td>
         <td class="DataTable4"><%=sPatioLySls[i][12]%></td>
         <td class="DataTable41"><%=sPatioDlyPrc[i][12]%>%</td>
         
         <td class="DataTable6"><%=sPatio[i]%></td>
       </tr>
      <%}%>
    <!------------------- End  Non/-Ski Total ------------------------------->


    <!------------------- Regional Total ------------------------------------>
    <%if(sLevel.equals("S")) {%>
      <%for(int i=0; i < iNumOfReg; i++) {%>
        <tr class="DataTable1">
           <%if(sStore[0].substring(0, 3).equals("ALL")){%>
              <td class="DataTable6">Reg <%=sReg[i]%></td>
           <%} else {%>
               <td class="DataTable4">Reg <%=sReg[i]%></td>
           <%}%>

           <td class="DataTable4" id="tdRegDlySls"><%=sSDReg[i]%></td>
           <%if(!bMonday){%>
              <td class="DataTable41" id="tdRegDlySls"><%=sRegLySls[i][iWeekday]%></td>
           <%}%>

           <td class="DataTable4"><%=sRegTySls[i][7]%></td>
           <td class="DataTable4"><%=sRegLySls[i][7]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][7]%>%</td>

           <td class="DataTable4"><%=sRegTySls[i][9]%></td>
           <td class="DataTable4"><%=sRegLySls[i][9]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][9]%>%</td>

           <td class="DataTable4"><%=sRegTySls[i][11]%></td>
           <td class="DataTable4"><%=sRegLySls[i][11]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][11]%>%</td>

           <td class="DataTable4"><%=sRegTySls[i][12]%></td>
           <td class="DataTable4"><%=sRegLySls[i][12]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][12]%>%</td>
           
           <%if(sStore[0].substring(0, 3).equals("ALL")){%>
              <td class="DataTable6">Reg <%=sReg[i]%></td>
           <%} else {%>
               <td class="DataTable4">Reg <%=sReg[i]%></td>
           <%}%>
        </tr>
      <%}%>
    <%}%>


    <!----------------- Regional Com Store Total ------------------------------>
    <%if(sLevel.equals("S")) {%>
      <%for(int i=0; i < iNumOfReg; i++) {%>
        <tr class="DataTable7">
           <%if(sStore[0].substring(0, 3).equals("ALL")){%>
              <td class="DataTable6">Reg <%=sReg[i]%> (Comp Str)</td>
           <%} else {%>
               <td class="DataTable4">Reg <%=sReg[i]%></td>
           <%}%>

           <td class="DataTable4" id="tdRegDlySls"><%=sSDRegComp[i]%></td>
           <%if(!bMonday){%>
              <td class="DataTable41" id="tdRegDlySls"><%=sRegCompLySls[i][iWeekday]%></td>
           <%}%>

           <td class="DataTable4"><%=sRegCompTySls[i][7]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][7]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][7]%>%</td>

           <td class="DataTable4"><%=sRegCompTySls[i][9]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][9]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][9]%>%</td>

           <td class="DataTable4"><%=sRegCompTySls[i][11]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][11]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][11]%>%</td>

           <td class="DataTable4"><%=sRegCompTySls[i][12]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][12]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][12]%>%</td>
           
           <%if(sStore[0].substring(0, 3).equals("ALL")){%>
              <td class="DataTable6">Reg <%=sReg[i]%> (Comp Str)</td>
           <%} else {%>
               <td class="DataTable4">Reg <%=sReg[i]%></td>
           <%}%>
        </tr>
      <%}%>
    <%}%>



    <!------------------- Comp Store Totals -------------------------------------->
    <%if(!sStore[0].equals("COMP")  && !sStore[0].equals("COMPE") && sLevel.equals("S")){%>
    <%
              // Comp Store totals
        for(int i=0; i < 2; i++)
        {
          slsTyLy.setCompStrArr(Integer.toString(i));
          String [] sCompTySls = slsTyLy.getCompTySls();
          String [] sCompLySls = slsTyLy.getCompLySls();
          String [] sCompDlyPrc = slsTyLy.getCompDlyPrc();
          sCompStr = slsTyLy.getCompStr();
          iNumOfCompStr = slsTyLy.getNumOfCompStr();
    %>
        <tr class="DataTable2">
           <td class="DataTable6" nowrap>Comp Str<%if(i==0){%>(w/o70)<%}%>*</td>

           <td class="DataTable6" nowrap id="tdCompDlySls"><%=sSDComp[i]%></td>
           <%if(!bMonday){%>
              <td class="DataTable41" nowrap id="tdCompDlySls"><%=sCompLySls[iWeekday]%></td>
           <%}%>

           <td class="DataTable4"><%=sCompTySls[7]%></td>
           <td class="DataTable4"><%=sCompLySls[7]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[7]%>%</td>

           <td class="DataTable4"><%=sCompTySls[9]%></td>
           <td class="DataTable4"><%=sCompLySls[9]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[9]%>%</td>

           <td class="DataTable4"><%=sCompTySls[11]%></td>
           <td class="DataTable4"><%=sCompLySls[11]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[11]%>%</td>

           <td class="DataTable4"><%=sCompTySls[12]%></td>
           <td class="DataTable4"><%=sCompLySls[12]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[12]%>%</td>
           
           <td class="DataTable6" nowrap>Comp Str<%if(i==0){%>(w/o70)<%}%>*</td>
       </tr>
     <%}%>

    <%}%>
    <!------------------- Report Total -------------------------------------->
        <tr class="DataTable2">
           <td class="DataTable4">Report&nbsp;</td>

           <td class="DataTable4" id="tdRepDlySls"><%=sSDRep%></td>
           <%if(!bMonday){%>
              <td class="DataTable41" id="tdRepDlySls"><%=sRepLySls[iWeekday]%></td>
           <%}%>

           <td class="DataTable4"><%=sRepTySls[7]%></td>
           <td class="DataTable4"><%=sRepLySls[7]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[7]%>%</td>

           <td class="DataTable4"><%=sRepTySls[9]%></td>    
           <td class="DataTable4"><%=sRepLySls[9]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[9]%>%</td>

           <td class="DataTable4"><%=sRepTySls[11]%></td>
           <td class="DataTable4"><%=sRepLySls[11]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[11]%>%</td>

           <td class="DataTable4"><%=sRepTySls[12]%></td>
           <td class="DataTable4"><%=sRepLySls[12]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[12]%>%</td>
           
           <td class="DataTable4">Report&nbsp;</td>
        </tr>
        
        
        <tr id="trScale" class="DataTable" style="visibility: hidden;">
             <%for(int j=0; j < iColWidth.length; j++){%>
                <%if(j > 0 && j < iColWidth.length-1){%>
                	<td class="DataTable41" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ j]; k++){%>0<%}%></td>
                <%}
                else{%>
                	<td class="DataTable41" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ j]; k++){%>W<%}%></td>
                <%}%>
             <%}%>
        </tr>

   </table>
    <!----------------------- end of table ---------------------------------->
  <span style="font-size:10px">*Comp Store totals include <%=iNumOfCompStr%> stores<br>
  &nbsp;Comp Stores: <%String coma=""; for(int i=0; i < iNumOfCompStr; i++){%><%=coma + sCompStr[i]%><%coma=", ";}%>
  </span>

  <style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        table.Prompt { border: gray groove 1px;}

        tr.TblHdr { background: #ffe8d2; font-family:Verdanda; font-size:10px }

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
        td.DataTable404 { background:#47ed86; color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
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
        td.DataTable414 { background: #47ed86; color:blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
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
 </body>

</html>

<SCRIPT language="javascript">
  // parent.spAsOfDate.innerHTML = "As of <%=sDate%>"
  // parent.showFlashSls();
  
</script>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<script type='text/javascript'>//<![CDATA[
var NumOfGrp = "<%=iNumOfGrp%>";                                          
$(window).load(function()
{
 
	cloneRow();

	$(window).bind("scroll", function() 
	{
     	var offsetLeft = $(this).scrollLeft();
		var color = "#bee5ea";
		var posLeft = 0; 
		posLeft = offsetLeft; 		
		
		
		var col0hdr1 = "#thGrp";		 
		$(col0hdr1).css({ left: posLeft, position : "relative", background: "#FFE4C4", border: "darkred solid 1px"});
		var col0hdr2 = "#thGrp1";		 
		$(col0hdr2).css({ left: posLeft, position : "relative", background: "#FFE4C4", border: "darkred solid 1px"});
		
		var col1hdr = "#thFix1";		 
		$(col1hdr).css({ left: posLeft, position : "relative", background: "#FFE4C4"});
		var col2hdr = "#thFix2";		 
		$(col2hdr).css({ left: posLeft, position : "relative", background: "#FFE4C4"});
	
		for(var i=0; i < NumOfGrp; i++)
		{
			if(color=="#bee5ea"){ color = "#f4ecbc";}
	 		else{ color = "#bee5ea"; }
			
			var desc = "#tdGrp" + i;
			$(desc).css({ left: posLeft, position : "relative", background:color, border: "lightsalmon solid 1px" });
			$(desc).css("z-index", 0);	
		}
	
		var offsetTop = $(this).scrollTop();
		
    	if(offsetTop > 153)
    	{
    		$("#trHdr01").css({"display": "none"});
    		$("#trHdr02").css({"display": "none"});
    		$("#tblClone").css({"display": "block"});
    		$("#tblClone").css({top: offsetTop, left: 10});
    		$("#tblClone").css('z-index', 100);
    	}
    	else
    	{	
    		$("#trHdr01").css({"display": "table-row"});
    		$("#trHdr02").css({"display": "table-row"});
    		$("#tblClone").css({"display": "none"});
    	} 
	}); 
	});//]]> 

//==============================================================================
//clone row 
//==============================================================================
function cloneRow() 
{
  var row1 = document.getElementById("trHdr01");  
  var row2 = document.getElementById("trHdr02");
  
  var rowScale = document.getElementById("trScale");
  var table = document.getElementById("tblClone");  
  var clone1 = row1.cloneNode(true); // copy children too  
  var clone2 = row2.cloneNode(true);  
  
  var cloneScale = rowScale.cloneNode(true);
  clone1.id = "trClone01"; // change id or other attributes/contents
  clone2.id = "trClone02";  
  
  cloneScale.id = "trCloneScale";
  table.appendChild(clone1); // add new row to end of table
  table.appendChild(clone2); 
  table.appendChild(cloneScale); // add new row to end of table
  
  var hdr1 = table.childNodes[1].childNodes[0];
  var hdr2 = table.childNodes[2].childNodes[0];
  hdr1.id = "thFix1";
  hdr2.id = "thFix2";
  rowScale.style.visibility="hidden";  
}
</script>

<%slsTyLy.disconnect();
  slsTyLy = null;
%>
