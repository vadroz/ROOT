<%@ page import="payrollreports.SetWkPay, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sStrName = request.getParameter("STRNAME");
   String sWeekend = request.getParameter("WEEKEND");
   String sMonth = request.getParameter("MONBEG");
   String sSort = request.getParameter("SORT");

   if(sSort == null) sSort = "SGEMP";
   String sGrpType = sSort.substring(0,2);
   String sReverse = null;
   if(sGrpType.equals("SG")) sReverse = "GP" + sSort.substring(2);
   else sReverse = "SG" + sSort.substring(2);


  String [] sMgr = null;
  String [] sSls = null;
  String [] sSBk = null;
  String [] sNSl = null;
  String [] sNRc = null;
  String [] sNBk = null;
  String [] sNOt = null;
  String [] sTrn = null;

  String [] sMgrNum = null;
  String [] sSlsNum = null;
  String [] sSBkNum = null;
  String [] sNSlNum = null;
  String [] sNRcNum = null;
  String [] sNBkNum = null;
  String [] sNOtNum = null;
  String [] sTrnNum = null;

  int iNumOfMgr = 0;
  int iNumOfSls = 0;
  int iNumOfSBk = 0;
  int iNumOfNSl = 0;
  int iNumOfNRc = 0;
  int iNumOfNBk = 0;
  int iNumOfNOt = 0;
  int iNumOfTrn = 0;

  String [] sMgrHrs = null;
  String [] sSlsHrs = null;
  String [] sSBkHrs = null;
  String [] sNSlHrs = null;
  String [] sNRcHrs = null;
  String [] sNBkHrs = null;
  String [] sNOtHrs = null;
  String [] sTrnHrs = null;

  String [] sMgrPay = null;
  String [] sSlsPay = null;
  String [] sSBkPay = null;
  String [] sNSlPay = null;
  String [] sNRcPay = null;
  String [] sNBkPay = null;
  String [] sNOtPay = null;

  String [] sTrnPay = null;

  String [] sMgrAvg = null;
  String [] sSlsAvg = null;
  String [] sSBkAvg = null;
  String [] sNSlAvg = null;
  String [] sNRcAvg = null;
  String [] sNBkAvg = null;
  String [] sNOtAvg = null;

  String [] sTrnAvg = null;

  String [] sMgrPGPay = null;
  String [] sSlsPGPay = null;
  String [] sSBkPGPay = null;
  String [] sNSlPGPay = null;
  String [] sNRcPGPay = null;
  String [] sNBkPGPay = null;
  String [] sNOtPGPay = null;
  String [] sTrnPGPay = null;

  //------------------------------
  String [] sMgrActHrs = null;
  String [] sSlsActHrs = null;
  String [] sSBkActHrs = null;
  String [] sNSlActHrs = null;
  String [] sNRcActHrs = null;
  String [] sNBkActHrs = null;
  String [] sNOtActHrs = null;
  String [] sTrnActHrs = null;

  String [] sMgrActPay = null;
  String [] sSlsActPay = null;
  String [] sSBkActPay = null;
  String [] sNSlActPay = null;
  String [] sNRcActPay = null;
  String [] sNBkActPay = null;
  String [] sNOtActPay = null;
  String [] sTrnActPay = null;

  String [] sMgrActAvg = null;
  String [] sSlsActAvg = null;
  String [] sSBkActAvg = null;
  String [] sNSlActAvg = null;
  String [] sNRcActAvg = null;
  String [] sNBkActAvg = null;
  String [] sNOtActAvg = null;
  String [] sTrnActAvg = null;

  String [] sMgrActPrc = null;
  String [] sSlsActPrc = null;
  String [] sSBkActPrc = null;
  String [] sNSlActPrc = null;
  String [] sNRcActPrc = null;
  String [] sNBkActPrc = null;
  String [] sNOtActPrc = null;
  String [] sTrnActPrc = null;
  //------------------------------
  String [] sMgrVarHrs = null;
  String [] sSlsVarHrs = null;
  String [] sSBkVarHrs = null;
  String [] sNSlVarHrs = null;
  String [] sNRcVarHrs = null;
  String [] sNBkVarHrs = null;
  String [] sNOtVarHrs = null;
  String [] sTrnVarHrs = null;

  String [] sMgrVarPay = null;
  String [] sSlsVarPay = null;
  String [] sSBkVarPay = null;
  String [] sNSlVarPay = null;
  String [] sNRcVarPay = null;
  String [] sNBkVarPay = null;
  String [] sNOtVarPay = null;
  String [] sTrnVarPay = null;

  String [] sMgrVarAvg = null;
  String [] sSlsVarAvg = null;
  String [] sSBkVarAvg = null;
  String [] sNSlVarAvg = null;
  String [] sNRcVarAvg = null;
  String [] sNBkVarAvg = null;
  String [] sNOtVarAvg = null;
  String [] sTrnVarAvg = null;
  //------------------------------

  String [] sMgrTtl = null;
  String [] sSlsTtl = null;
  String [] sSBkTtl = null;
  String [] sNSlTtl = null;
  String [] sNRcTtl = null;
  String [] sNBkTtl = null;
  String [] sNOtTtl = null;
  String [] sTrnTtl = null;

  String [] sMgrGrp = null;
  String [] sSlsGrp = null;
  String [] sNSlGrp = null;

  //--------------------------------------------------
  String sTotMgrHrs = null;
  String sTotSlsHrs = null;
  String sTotSBkHrs = null;
  String sTotNSlHrs = null;
  String sTotNRcHrs = null;
  String sTotNBkHrs = null;
  String sTotNOtHrs = null;
  String sTotTrnHrs = null;

  String sTotMgrPay = null;
  String sTotSlsPay = null;
  String sTotSBkPay = null;
  String sTotNSlPay = null;
  String sTotNRcPay = null;
  String sTotNBkPay = null;
  String sTotNOtPay = null;
  String sTotTrnPay = null;

  String sTotMgrAvg = null;
  String sTotSlsAvg = null;
  String sTotSBkAvg = null;
  String sTotNSlAvg = null;
  String sTotNRcAvg = null;
  String sTotNBkAvg = null;
  String sTotNOtAvg = null;
  String sTotTrnAvg = null;

  String sTotMgrPrc = null;
  String sTotSlsPrc = null;
  String sTotSBkPrc = null;
  String sTotNSlPrc = null;
  String sTotNRcPrc = null;
  String sTotNBkPrc = null;
  String sTotNOtPrc = null;
  String sTotTrnPrc = null;
  //--------------------------------------------------
  String sTotActMgrHrs = null;
  String sTotActSlsHrs = null;
  String sTotActSBkHrs = null;
  String sTotActNSlHrs = null;
  String sTotActNRcHrs = null;
  String sTotActNBkHrs = null;
  String sTotActNOtHrs = null;
  String sTotActTrnHrs = null;

  String sTotActMgrPay = null;
  String sTotActSlsPay = null;
  String sTotActSBkPay = null;
  String sTotActNSlPay = null;
  String sTotActNRcPay = null;
  String sTotActNBkPay = null;
  String sTotActNOtPay = null;
  String sTotActTrnPay = null;

  String sTotActMgrAvg = null;
  String sTotActSlsAvg = null;
  String sTotActSBkAvg = null;
  String sTotActNSlAvg = null;
  String sTotActNRcAvg = null;
  String sTotActNBkAvg = null;
  String sTotActNOtAvg = null;
  String sTotActTrnAvg = null;

  String sTotActMgrPrc = null;
  String sTotActSlsPrc = null;
  String sTotActSBkPrc = null;
  String sTotActNSlPrc = null;
  String sTotActNRcPrc = null;
  String sTotActNBkPrc = null;
  String sTotActNOtPrc = null;
  String sTotActTrnPrc = null;
  //--------------------------------------------------
  String sTotVarMgrHrs = null;
  String sTotVarSlsHrs = null;
  String sTotVarSBkHrs = null;
  String sTotVarNSlHrs = null;
  String sTotVarNRcHrs = null;
  String sTotVarNBkHrs = null;
  String sTotVarNOtHrs = null;
  String sTotVarTrnHrs = null;

  String sTotVarMgrPay = null;
  String sTotVarSlsPay = null;
  String sTotVarSBkPay = null;
  String sTotVarNSlPay = null;
  String sTotVarNRcPay = null;
  String sTotVarNBkPay = null;
  String sTotVarNOtPay = null;
  String sTotVarTrnPay = null;

  String sTotVarMgrAvg = null;
  String sTotVarSlsAvg = null;
  String sTotVarSBkAvg = null;
  String sTotVarNSlAvg = null;
  String sTotVarNRcAvg = null;
  String sTotVarNBkAvg = null;
  String sTotVarNOtAvg = null;
  String sTotVarTrnAvg = null;
  //--------------------------------------------------

  String sTotRepHrs = null;
  String sTotRepPay = null;
  String sTotRepAvg = null;
  String sTotActRepHrs = null;
  String sTotActRepPay = null;
  String sTotActRepAvg = null;

  String sTotVarRepHrs = null;
  String sTotVarRepPay = null;
  String sTotVarRepAvg = null;

  //-------------- Security ---------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
  {
     response.sendRedirect("SignOn1.jsp?TARGET=SchWkPay.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }

  // -------------- End Security -----------------
   else{
    SetWkPay WkPay = new SetWkPay(sStore, sWeekend, sSort);
    iNumOfMgr = WkPay.getNumOfMgr();
    sMgr = WkPay.getMgr();
    sMgrNum = WkPay.getMgrNum();
    sMgrHrs = WkPay.getMgrHrs();
    sMgrPay = WkPay.getMgrPay();
    sMgrAvg = WkPay.getMgrAvg();
    sMgrPGPay = WkPay.getMgrPGPay();
    sMgrTtl = WkPay.getMgrTtl();
    sMgrGrp = WkPay.getMgrGrp();
    sMgrActHrs = WkPay.getMgrActHrs();
    sMgrActPay = WkPay.getMgrActPay();
    sMgrActAvg = WkPay.getMgrActAvg();
    sMgrActPrc = WkPay.getMgrActPrc();
    sMgrVarHrs = WkPay.getMgrVarHrs();
    sMgrVarPay = WkPay.getMgrVarPay();
    sMgrVarAvg = WkPay.getMgrVarAvg();

    iNumOfSls = WkPay.getNumOfSls();
    sSls = WkPay.getSls();
    sSlsNum = WkPay.getSlsNum();
    sSlsHrs = WkPay.getSlsHrs();
    sSlsPay = WkPay.getSlsPay();
    sSlsAvg = WkPay.getSlsAvg();
    sSlsPGPay = WkPay.getSlsPGPay();
    sSlsTtl = WkPay.getSlsTtl();
    sSlsGrp = WkPay.getSlsGrp();
    sSlsActHrs = WkPay.getSlsActHrs();
    sSlsActPay = WkPay.getSlsActPay();
    sSlsActAvg = WkPay.getSlsActAvg();
    sSlsActPrc = WkPay.getSlsActPrc();
    sSlsVarHrs = WkPay.getSlsVarHrs();
    sSlsVarPay = WkPay.getSlsVarPay();
    sSlsVarAvg = WkPay.getSlsVarAvg();

    iNumOfSBk = WkPay.getNumOfSBk();
    sSBk = WkPay.getSBk();
    sSBkNum = WkPay.getSBkNum();
    sSBkHrs = WkPay.getSBkHrs();
    sSBkPay = WkPay.getSBkPay();
    sSBkAvg = WkPay.getSBkAvg();
    sSBkPGPay = WkPay.getSBkPGPay();
    sSBkTtl = WkPay.getSBkTtl();
    sSBkActHrs = WkPay.getSBkActHrs();
    sSBkActPay = WkPay.getSBkActPay();
    sSBkActAvg = WkPay.getSBkActAvg();
    sSBkActPrc = WkPay.getSBkActPrc();
    sSBkVarHrs = WkPay.getSBkVarHrs();
    sSBkVarPay = WkPay.getSBkVarPay();
    sSBkVarAvg = WkPay.getSBkVarAvg();

    iNumOfNSl = WkPay.getNumOfNSl();
    sNSl = WkPay.getNSl();
    sNSlNum = WkPay.getNSlNum();
    sNSlHrs = WkPay.getNSlHrs();
    sNSlPay = WkPay.getNSlPay();
    sNSlAvg = WkPay.getNSlAvg();
    sNSlPGPay = WkPay.getNSlPGPay();
    sNSlTtl = WkPay.getNSlTtl();
    sNSlGrp = WkPay.getNSlGrp();
    sNSlActHrs = WkPay.getNSlActHrs();
    sNSlActPay = WkPay.getNSlActPay();
    sNSlActAvg = WkPay.getNSlActAvg();
    sNSlActPrc = WkPay.getNSlActPrc();
    sNSlVarHrs = WkPay.getNSlVarHrs();
    sNSlVarPay = WkPay.getNSlVarPay();
    sNSlVarAvg = WkPay.getNSlVarAvg();

    iNumOfNRc = WkPay.getNumOfNRc();
    sNRc = WkPay.getNRc();
    sNRcNum = WkPay.getNRcNum();
    sNRcHrs = WkPay.getNRcHrs();
    sNRcPay = WkPay.getNRcPay();
    sNRcAvg = WkPay.getNRcAvg();
    sNRcPGPay = WkPay.getNRcPGPay();
    sNRcTtl = WkPay.getNRcTtl();
    sNRcActHrs = WkPay.getNRcActHrs();
    sNRcActPay = WkPay.getNRcActPay();
    sNRcActAvg = WkPay.getNRcActAvg();
    sNRcActPrc = WkPay.getNRcActPrc();
    sNRcVarHrs = WkPay.getNRcVarHrs();
    sNRcVarPay = WkPay.getNRcVarPay();
    sNRcVarAvg = WkPay.getNRcVarAvg();


    iNumOfNBk = WkPay.getNumOfNBk();
    sNBk = WkPay.getNBk();
    sNBkNum = WkPay.getNBkNum();
    sNBkHrs = WkPay.getNBkHrs();
    sNBkPay = WkPay.getNBkPay();
    sNBkAvg = WkPay.getNBkAvg();
    sNBkPGPay = WkPay.getNBkPGPay();
    sNBkTtl = WkPay.getNBkTtl();
    sNBkActHrs = WkPay.getNBkActHrs();
    sNBkActPay = WkPay.getNBkActPay();
    sNBkActAvg = WkPay.getNBkActAvg();
    sNBkActPrc = WkPay.getNBkActPrc();
    sNBkVarHrs = WkPay.getNBkVarHrs();
    sNBkVarPay = WkPay.getNBkVarPay();
    sNBkVarAvg = WkPay.getNBkVarAvg();

    iNumOfNOt = WkPay.getNumOfNOt();
    sNOt = WkPay.getNOt();
    sNOtNum = WkPay.getNOtNum();
    sNOtHrs = WkPay.getNOtHrs();
    sNOtPay = WkPay.getNOtPay();
    sNOtAvg = WkPay.getNOtAvg();
    sNOtPGPay = WkPay.getNOtPGPay();
    sNOtTtl = WkPay.getNOtTtl();
    sNOtActHrs = WkPay.getNOtActHrs();
    sNOtActPay = WkPay.getNOtActPay();
    sNOtActAvg = WkPay.getNOtActAvg();
    sNOtActPrc = WkPay.getNOtActPrc();
    sNOtVarHrs = WkPay.getNOtVarHrs();
    sNOtVarPay = WkPay.getNOtVarPay();
    sNOtVarAvg = WkPay.getNOtVarAvg();

    iNumOfTrn = WkPay.getNumOfTrn();
    sTrn = WkPay.getTrn();
    sTrnNum = WkPay.getTrnNum();
    sTrnHrs = WkPay.getTrnHrs();
    sTrnPay = WkPay.getTrnPay();
    sTrnAvg = WkPay.getTrnAvg();
    sTrnPGPay = WkPay.getTrnPGPay();
    sTrnTtl = WkPay.getTrnTtl();
    sTrnActHrs = WkPay.getTrnActHrs();
    sTrnActPay = WkPay.getTrnActPay();
    sTrnActAvg = WkPay.getTrnActAvg();
    sTrnActPrc = WkPay.getTrnActPrc();
    sTrnVarHrs = WkPay.getTrnVarHrs();
    sTrnVarPay = WkPay.getTrnVarPay();
    sTrnVarAvg = WkPay.getTrnVarAvg();

    //-----------------------------------
    sTotMgrHrs = WkPay.getTotMgrHrs();
    sTotSlsHrs = WkPay.getTotSlsHrs();
    sTotSBkHrs = WkPay.getTotSBkHrs();
    sTotNSlHrs = WkPay.getTotNSlHrs();
    sTotNRcHrs = WkPay.getTotNRcHrs();
    sTotNBkHrs = WkPay.getTotNBkHrs();
    sTotNOtHrs = WkPay.getTotNOtHrs();
    sTotTrnHrs = WkPay.getTotTrnHrs();

    sTotMgrPay = WkPay.getTotMgrPay();
    sTotSlsPay = WkPay.getTotSlsPay();
    sTotSBkPay = WkPay.getTotSBkPay();
    sTotNSlPay = WkPay.getTotNSlPay();
    sTotNRcPay = WkPay.getTotNRcPay();
    sTotNBkPay = WkPay.getTotNBkPay();
    sTotNOtPay = WkPay.getTotNOtPay();
    sTotTrnPay = WkPay.getTotTrnPay();

    sTotMgrAvg = WkPay.getTotMgrAvg();
    sTotSlsAvg = WkPay.getTotSlsAvg();
    sTotSBkAvg = WkPay.getTotSBkAvg();
    sTotNSlAvg = WkPay.getTotNSlAvg();
    sTotNRcAvg = WkPay.getTotNRcAvg();
    sTotNBkAvg = WkPay.getTotNBkAvg();
    sTotNOtAvg = WkPay.getTotNOtAvg();
    sTotTrnAvg = WkPay.getTotTrnAvg();

    sTotMgrPrc = WkPay.getTotMgrPrc();
    sTotSlsPrc = WkPay.getTotSlsPrc();
    sTotSBkPrc = WkPay.getTotSBkPrc();
    sTotNSlPrc = WkPay.getTotNSlPrc();
    sTotNRcPrc = WkPay.getTotNRcPrc();
    sTotNBkPrc = WkPay.getTotNBkPrc();
    sTotNOtPrc = WkPay.getTotNOtPrc();
    sTotNOtPrc = WkPay.getTotNOtPrc();
    sTotTrnPrc = WkPay.getTotTrnPrc();
    //-----------------------------------
    sTotActMgrHrs = WkPay.getTotActMgrHrs();
    sTotActSlsHrs = WkPay.getTotActSlsHrs();
    sTotActSBkHrs = WkPay.getTotActSBkHrs();
    sTotActNSlHrs = WkPay.getTotActNSlHrs();
    sTotActNRcHrs = WkPay.getTotActNRcHrs();
    sTotActNBkHrs = WkPay.getTotActNBkHrs();
    sTotActNOtHrs = WkPay.getTotActNOtHrs();
    sTotActTrnHrs = WkPay.getTotActTrnHrs();

    sTotActMgrPay = WkPay.getTotActMgrPay();
    sTotActSlsPay = WkPay.getTotActSlsPay();
    sTotActSBkPay = WkPay.getTotActSBkPay();
    sTotActNSlPay = WkPay.getTotActNSlPay();
    sTotActNRcPay = WkPay.getTotActNRcPay();
    sTotActNBkPay = WkPay.getTotActNBkPay();
    sTotActNOtPay = WkPay.getTotActNOtPay();
    sTotActTrnPay = WkPay.getTotActTrnPay();

    sTotActMgrAvg = WkPay.getTotActMgrAvg();
    sTotActSlsAvg = WkPay.getTotActSlsAvg();
    sTotActSBkAvg = WkPay.getTotActSBkAvg();
    sTotActNSlAvg = WkPay.getTotActNSlAvg();
    sTotActNRcAvg = WkPay.getTotActNRcAvg();
    sTotActNBkAvg = WkPay.getTotActNBkAvg();
    sTotActNOtAvg = WkPay.getTotActNOtAvg();
    sTotActTrnAvg = WkPay.getTotActTrnAvg();

    sTotActMgrPrc = WkPay.getTotActMgrPrc();
    sTotActSlsPrc = WkPay.getTotActSlsPrc();
    sTotActSBkPrc = WkPay.getTotActSBkPrc();
    sTotActNSlPrc = WkPay.getTotActNSlPrc();
    sTotActNRcPrc = WkPay.getTotActNRcPrc();
    sTotActNBkPrc = WkPay.getTotActNBkPrc();
    sTotActNOtPrc = WkPay.getTotActNOtPrc();
    sTotActNOtPrc = WkPay.getTotActNOtPrc();
    sTotActTrnPrc = WkPay.getTotActTrnPrc();

    //-----------------------------------
    sTotVarMgrHrs = WkPay.getTotVarMgrHrs();
    sTotVarSlsHrs = WkPay.getTotVarSlsHrs();
    sTotVarSBkHrs = WkPay.getTotVarSBkHrs();
    sTotVarNSlHrs = WkPay.getTotVarNSlHrs();
    sTotVarNRcHrs = WkPay.getTotVarNRcHrs();
    sTotVarNBkHrs = WkPay.getTotVarNBkHrs();
    sTotVarNOtHrs = WkPay.getTotVarNOtHrs();
    sTotVarTrnHrs = WkPay.getTotVarTrnHrs();

    sTotVarMgrPay = WkPay.getTotVarMgrPay();
    sTotVarSlsPay = WkPay.getTotVarSlsPay();
    sTotVarSBkPay = WkPay.getTotVarSBkPay();
    sTotVarNSlPay = WkPay.getTotVarNSlPay();
    sTotVarNRcPay = WkPay.getTotVarNRcPay();
    sTotVarNBkPay = WkPay.getTotVarNBkPay();
    sTotVarNOtPay = WkPay.getTotVarNOtPay();
    sTotVarTrnPay = WkPay.getTotVarTrnPay();

    sTotVarMgrAvg = WkPay.getTotVarMgrAvg();
    sTotVarSlsAvg = WkPay.getTotVarSlsAvg();
    sTotVarSBkAvg = WkPay.getTotVarSBkAvg();
    sTotVarNSlAvg = WkPay.getTotVarNSlAvg();
    sTotVarNRcAvg = WkPay.getTotVarNRcAvg();
    sTotVarNBkAvg = WkPay.getTotVarNBkAvg();
    sTotVarNOtAvg = WkPay.getTotActNOtAvg();
    sTotVarTrnAvg = WkPay.getTotVarTrnAvg();
    //-----------------------------------

    sTotRepHrs = WkPay.getTotRepHrs();
    sTotRepPay = WkPay.getTotRepPay();
    sTotRepAvg = WkPay.getTotRepAvg();
    sTotActRepHrs = WkPay.getTotActRepHrs();
    sTotActRepPay = WkPay.getTotActRepPay();
    sTotActRepAvg = WkPay.getTotActRepAvg();

    sTotVarRepHrs = WkPay.getTotVarRepHrs();
    sTotVarRepPay = WkPay.getTotVarRepPay();
    sTotVarRepAvg = WkPay.getTotVarRepAvg();

    WkPay.disconnect();
   }
%>
<html>
<head>
<style>
        body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        a.Menu:link { color:black; text-decoration:none }
        a.Menu:visited { color:black; text-decoration:none }
        a.Menu:hover { color:red; text-decoration:none }

        table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable2 { color:brown;  background: Linen; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:0px; padding-bottom:0px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        td.Total  { background:cornsilk; border-top: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.Total1 { background:cornsilk; border-top: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.Total2 { background:cornsilk; border-top: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.Total3 { color:red; background:cornsilk; border-right: darkred solid 1px; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold }
        td.Total4 { background:cornsilk; border-top: double darkred; padding-right:3px; border-bottom: darkred solid 1px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.Total5 { background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {text-align:left; font-family:Arial; font-size:10px; }



@media screen
{
        td.DataTable { background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable3 { background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable4 { background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
}

@media print {
        td.DataTable {   border-bottom: darkred solid 1px; background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable3 {   border-bottom: darkred solid 1px; background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable4 {   border-bottom: darkred solid 1px; background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
}

</style>
<SCRIPT language="JavaScript1.2">
var Store = "<%=sStore%>"
var StrName = "<%=sStrName%>"
var SelEmp = null;
var SelEmpName = null;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
}
//==============================================================================
// resort by selected column
//==============================================================================
function sortBy(sort)
{
  var uri = "SchWkPay.jsp?STORE=<%=sStore%>"
          + "&STRNAME=<%=sStrName%>"
          + "&WEEKEND=<%=sWeekend%>"
          + "&MONBEG=<%=sMonth%>"
          + "&SORT=" + sort;
  window.location.href = uri;
}
//==============================================================================
// resort by selected column
//==============================================================================
function rtvActPayDtl(empNum, empName)
{
   SelEmp = empNum;
   SelEmpName = empName;

   var url = "ActWkPay.jsp?STORE=<%=sStore%>"
       + "&EmpNum=" + empNum
       + "&WEEKEND=<%=sWeekend%>"
   //alert(url)
   //window.location.href = url;
   window.frame1.location = url;
}

//==============================================================================
// resort by selected column
//==============================================================================
function showEmpPay(hrs, pay, type, tothrs, totpay)
{
  frame1.location="";

  var curLeft = 0;
  var curTop = 0;

  var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Employee Payroll Details</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
   // Employee Number & Name
   html += "<tr>"
          + "<td class='Prompt' nowrap colspan='2'>Store: " + Store + "</td>"
        + "</tr>"
        + "<tr>"
          + "<td class='Prompt' nowrap colspan='2'>Employee: " + SelEmp + " " + SelEmpName + "</td>"
        + "</tr>"

   // payroll detail table
   html += "<tr><td class='Prompt' nowrap colspan='2'>"
      + "<table border='1' width='100%' cellPadding='0' cellSpacing='0'>"
        + popPayDtlTable(hrs, pay, type, tothrs, totpay)
      + "</table></td></tr>"
   html += "</table>"


   curTop = document.documentElement.scrollTop + screen.height/2 - 200;
   curLeft = document.documentElement.scrollLeft + screen.width/2- 100;


   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= curLeft;
   document.all.Prompt.style.pixelTop= curTop;
   document.all.Prompt.style.visibility = "visible";
}
//--------------------------------------------------------
// payroll detail table
//--------------------------------------------------------
function popPayDtlTable(hrs, pay, type, tothrs, totpay)
{
   var html = "<tr>"
          + "<th class='DataTable' >Type</th>"
          + "<th class='DataTable' >Hours</th>"
          + "<th class='DataTable' >Dollars</th>"
      + "</tr>"

   for(var i=0; i < hrs.length; i++)
   {
      html += "<tr>"
          + "<td class='Total' nowrap >" + type[i] + "</td>"
          + "<td class='Total1' nowrap >" + hrs[i] + "</td>"
          + "<td class='Total1' nowrap >" + pay[i] + "</td>"
        + "</tr>"
   }

   html += "<tr>"
          + "<td class='Total1' nowrap >Total</td>"
          + "<td class='Total1' nowrap >" + tothrs + "</td>"
          + "<td class='Total1' nowrap >" + totpay + "</td>"
        + "</tr>"

   return html;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}

</SCRIPT>

<!-------------------------------------------------------------------->
<!-- Drag & Drop objects on the page. This featur is initialize by setBoxclasses()  -->
<!-------------------------------------------------------------------->
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<!-------------------------------------------------------------------->
<body onLoad="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin"><td ALIGN="center" VALIGN="TOP" colspan="3">
      <b>Budget Weekly Pay Details</b>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="left" VALIGN="TOP"><b>&nbsp;Store:&nbsp;<%=sStore + " - " + sStrName%></b></td>
        <td ALIGN="center" VALIGN="TOP">&nbsp;</td>
        <td ALIGN="right" VALIGN="TOP"><b>Week Ending:&nbsp;<%=sWeekend%>&nbsp;</b></td>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="mailto:"><font color="red" size="-1">E-mail</font></a>;&#62;
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a>&#62;
        <a href="FiscalMonthSel.jsp"><font color="red" size="-1">Store Selector</font></a>&#62;
        <a href="FiscalMonthBudget.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&MONBEG=<%=sMonth%>">
          <font color="red" size="-1">Budget</font></a>&#62;
         <font color="red" size="-1">This page</font><br>
         <%if(sGrpType.equals("SG")){%>
            <font size="-1">Click <a href="javascript: sortBy('<%=sReverse%>');"><font size="-1">
              here</font></a> to remove subgroups</font>.
         <%}
         else {%><font size="-1">Click <a href="javascript: sortBy('<%=sReverse%>');"><font color="red">
              here</font></a> to add subgroups</font>.
         <%}%>
        <!------------- start of dollars table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan="2"><a href="javascript:sortBy('<%=sGrpType%>EMP')">Employee</a></th>
           <%if(!sGrpType.equals("SG")){%>
              <th class="DataTable" rowspan="2">Subgroup</th>
           <%}%>
           <th class="DataTable" rowspan="2">Title</th>
           <th class="DataTable" colspan="5">Schedule</th>
           <th class="DataTable" rowspan="2">&nbsp;&nbsp;</th>
           <th class="DataTable" colspan="5">Actual Pay</th>
           <th class="DataTable" rowspan="2">&nbsp;&nbsp;</th>
           <th class="DataTable" colspan="3">Variance</th>
         </tr>
         <tr>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>HRS')">Total<br>hours</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>PAY')">Total<br>Pay $</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>AVG')">Avg<br>wage</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>PRC')">% to<br>Grp</a></th>
           <th class="DataTable" >% of<br>Total</th>

           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTHRS')">Total<br>hours</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTPAY')">Total<br>Pay $</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTAVG')">Avg<br>wage</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTPRC')">% to<br>Grp</a></th>
           <th class="DataTable" >% of<br>Total</th>

           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>VARHRS')">Hours</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>VARPAY')">Pay $</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>VARAVG')">Avg</a></th>
         </tr>
         <!----------------- Managers ------------------------>
         <tr>
           <td class="Total3" colspan="18">Managers</td>
         </tr>
         <%for(int i=0; i < iNumOfMgr; i++) {%>
         <tr>
           <td class="DataTable"><%=sMgr[i]%></td>
           <%if(!sGrpType.equals("SG")){%>
             <td class="DataTable4"><%=sMgrGrp[i]%></td>
           <%}%>
           <td class="DataTable4"><%=sMgrTtl[i]%></td>
           <td class="DataTable3"><%=sMgrHrs[i]%></td>
           <td class="DataTable3">$<%=sMgrPay[i]%></td>
           <td class="DataTable3">$<%=sMgrAvg[i]%></td>
           <td class="DataTable3"><%=sMgrPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sMgrActHrs[i]%></td>
           <td class="DataTable3">$<%=sMgrActPay[i]%></td>
           <td class="DataTable3">$<%=sMgrActAvg[i]%></td>
           <td class="DataTable3"><%=sMgrActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable"><a href="javascript:rtvActPayDtl(<%=sMgrNum[i]%>, '<%=sMgr[i]%>')">D</a></th>
           <td class="DataTable3"><%=sMgrVarHrs[i]%></td>
           <td class="DataTable3">$<%=sMgrVarPay[i]%></td>
           <td class="DataTable3">$<%=sMgrVarAvg[i]%></td>
         </tr>
         <%}%>
         <!----------------- Group Total ------------------------>
         <%if(iNumOfMgr != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <%if(!sGrpType.equals("SG")){%>
             <td class="Total1">&#160;</td>
            <%}%>
            <td class="Total1"><%=sTotMgrHrs%></td>
            <td class="Total1">$<%=sTotMgrPay%></td>
            <td class="Total1">$<%=sTotMgrAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotMgrPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActMgrHrs%></td>
            <td class="Total1">$<%=sTotActMgrPay%></td>
            <td class="Total1">$<%=sTotActMgrAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActMgrPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarMgrHrs%></td>
            <td class="Total1">$<%=sTotVarMgrPay%></td>
            <td class="Total1">$<%=sTotVarMgrAvg%></td>
          </tr>
         <%}%>
         <!----------------- Sellers ------------------------>
         <tr>
           <td class="Total3" colspan="18">Sellers</td>
         </tr>
         <!-----------------Regular Sellers ------------------------>
         <%if(sGrpType.equals("SG")){%>
         <tr>
           <td class="DataTable2" colspan="18">&nbsp;&nbsp;Regular Sales</td>
         </tr>
         <%}%>
        <%for(int i=0; i < iNumOfSls; i++) {%>
         <tr>
           <td class="DataTable"><%=sSls[i]%></td>
           <%if(!sGrpType.equals("SG")){%>
             <td class="DataTable4"><%=sSlsGrp[i]%></td>
           <%}%>
           <td class="DataTable4"><%=sSlsTtl[i]%></td>
           <td class="DataTable3"><%=sSlsHrs[i]%></td>
           <td class="DataTable3">$<%=sSlsPay[i]%></td>
           <td class="DataTable3">$<%=sSlsAvg[i]%></td>
           <td class="DataTable3"><%=sSlsPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sSlsActHrs[i]%></td>
           <td class="DataTable3">$<%=sSlsActPay[i]%></td>
           <td class="DataTable3">$<%=sSlsActAvg[i]%></td>
           <td class="DataTable3"><%=sSlsActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable"><a href="javascript:rtvActPayDtl(<%=sSlsNum[i]%>, '<%=sSls[i]%>')">D</a></th>
           <td class="DataTable3"><%=sSlsVarHrs[i]%></td>
           <td class="DataTable3">$<%=sSlsVarPay[i]%></td>
           <td class="DataTable3">$<%=sSlsVarAvg[i]%></td>
         </tr>
        <%}%>
        <!----------------- Group Total ------------------------>
         <%if(iNumOfSls != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <%if(!sGrpType.equals("SG")){%>
             <td class="Total1">&#160;</td>
            <%}%>
            <td class="Total1"><%=sTotSlsHrs%></td>
            <td class="Total1">$<%=sTotSlsPay%></td>
            <td class="Total1">$<%=sTotSlsAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotSlsPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActSlsHrs%></td>
            <td class="Total1">$<%=sTotActSlsPay%></td>
            <td class="Total1">$<%=sTotActSlsAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActSlsPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarSlsHrs%></td>
            <td class="Total1">$<%=sTotVarSlsPay%></td>
            <td class="Total1">$<%=sTotVarSlsAvg%></td>
          </tr>
         <%}%>
        <!----------------- Bike Sellers ------------------------>
        <%if(sGrpType.equals("SG")){%>
         <tr>
           <td class="DataTable2" colspan="18">&nbsp;&nbsp;Bike Sales</td>
          </tr>
         <%for(int i=0; i < iNumOfSBk; i++) {%>
          <tr>
           <td class="DataTable"><%=sSBk[i]%></td>
           <td class="DataTable4"><%=sSBkTtl[i]%></td>
           <td class="DataTable3"><%=sSBkHrs[i]%></td>
           <td class="DataTable3">$<%=sSBkPay[i]%></td>
           <td class="DataTable3">$<%=sSBkAvg[i]%></td>
           <td class="DataTable3"><%=sSBkPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sSBkActHrs[i]%></td>
           <td class="DataTable3">$<%=sSBkActPay[i]%></td>
           <td class="DataTable3">$<%=sSBkActAvg[i]%></td>
           <td class="DataTable3"><%=sSBkActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable"><a href="javascript:rtvActPayDtl(<%=sSBkNum[i]%>, '<%=sSBk[i]%>')">D</a></th>
           <td class="DataTable3"><%=sSBkVarHrs[i]%></td>
           <td class="DataTable3">$<%=sSBkVarPay[i]%></td>
           <td class="DataTable3">$<%=sSBkVarAvg[i]%></td>
          </tr>
         <%}%>
        <!----------------- Group Total ------------------------>
         <%if(iNumOfSBk != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <td class="Total1"><%=sTotSBkHrs%></td>
            <td class="Total1">$<%=sTotSBkPay%></td>
            <td class="Total1">$<%=sTotSBkAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotSBkPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActSBkHrs%></td>
            <td class="Total1">$<%=sTotActSBkPay%></td>
            <td class="Total1">$<%=sTotActSBkAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActSBkPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarSBkHrs%></td>
            <td class="Total1">$<%=sTotVarSBkPay%></td>
            <td class="Total1">$<%=sTotVarSBkAvg%></td>
          </tr>
         <%}%>
        <%}%>
         <!----------------- Non Selling personnel ------------------------>
         <tr>
           <td class="Total3" colspan="18">Non-Sellers</td>
         </tr>
         <!----------------- Cashiers ------------------------>
        <%if(sGrpType.equals("SG")){%>
         <tr>
           <td class="DataTable2" colspan="18">&nbsp;&nbsp;Cashiers</td>
         </tr>
       <%}%>
        <%for(int i=0; i < iNumOfNSl; i++) {%>
         <tr>
           <td class="DataTable"><%=sNSl[i]%></td>
           <%if(!sGrpType.equals("SG")){%>
             <td class="DataTable4"><%=sNSlGrp[i]%></td>
           <%}%>
           <td class="DataTable4"><%=sNSlTtl[i]%></td>
           <td class="DataTable3"><%=sNSlHrs[i]%></td>
           <td class="DataTable3">$<%=sNSlPay[i]%></td>
           <td class="DataTable3">$<%=sNSlAvg[i]%></td>
           <td class="DataTable3"><%=sNSlPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sNSlActHrs[i]%></td>
           <td class="DataTable3">$<%=sNSlActPay[i]%></td>
           <td class="DataTable3">$<%=sNSlActAvg[i]%></td>
           <td class="DataTable3"><%=sNSlActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable"><a href="javascript:rtvActPayDtl(<%=sNSlNum[i]%>, '<%=sNSl[i]%>')">D</a></th>
           <td class="DataTable3"><%=sNSlVarHrs[i]%></td>
           <td class="DataTable3">$<%=sNSlVarPay[i]%></td>
           <td class="DataTable3">$<%=sNSlVarAvg[i]%></td>
         </tr>
        <%}%>
        <!----------------- Group Total ------------------------>
         <%if(iNumOfNSl != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <%if(!sGrpType.equals("SG")){%>
             <td class="Total1">&#160;</td>
            <%}%>
            <td class="Total1"><%=sTotNSlHrs%></td>
            <td class="Total1">$<%=sTotNSlPay%></td>
            <td class="Total1">$<%=sTotNSlAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotNSlPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActNSlHrs%></td>
            <td class="Total1">$<%=sTotActNSlPay%></td>
            <td class="Total1">$<%=sTotActNSlAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActNSlPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarNSlHrs%></td>
            <td class="Total1">$<%=sTotVarNSlPay%></td>
            <td class="Total1">$<%=sTotVarNSlAvg%></td>
          </tr>
         <%}%>
        <!----------------- Receiving ------------------------>
        <%if(sGrpType.equals("SG")){%>
         <tr>
           <td class="DataTable2" colspan="18">&nbsp;&nbsp;Receiving</td>
         </tr>
        <%for(int i=0; i < iNumOfNRc; i++) {%>
         <tr>
           <td class="DataTable"><%=sNRc[i]%></td>
           <td class="DataTable4"><%=sNRcTtl[i]%></td>
           <td class="DataTable3"><%=sNRcHrs[i]%></td>
           <td class="DataTable3">$<%=sNRcPay[i]%></td>
           <td class="DataTable3">$<%=sNRcAvg[i]%></td>
           <td class="DataTable3"><%=sNRcPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sNRcActHrs[i]%></td>
           <td class="DataTable3">$<%=sNRcActPay[i]%></td>
           <td class="DataTable3">$<%=sNRcActAvg[i]%></td>
           <td class="DataTable3"><%=sNRcActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable"><a href="javascript:rtvActPayDtl(<%=sNRcNum[i]%>, '<%=sNRc[i]%>')">D</a></th>
           <td class="DataTable3"><%=sNRcVarHrs[i]%></td>
           <td class="DataTable3">$<%=sNRcVarPay[i]%></td>
           <td class="DataTable3">$<%=sNRcVarAvg[i]%></td>
         </tr>
        <%}%>
        <!----------------- Group Total ------------------------>
         <%if(iNumOfNRc != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <td class="Total1"><%=sTotNRcHrs%></td>
            <td class="Total1">$<%=sTotNRcPay%></td>
            <td class="Total1">$<%=sTotNRcAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotNRcPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActNRcHrs%></td>
            <td class="Total1">$<%=sTotActNRcPay%></td>
            <td class="Total1">$<%=sTotActNRcAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActNRcPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarNRcHrs%></td>
            <td class="Total1">$<%=sTotVarNRcPay%></td>
            <td class="Total1">$<%=sTotVarNRcAvg%></td>
          </tr>
         <%}%>
        <%}%>
        <!----------------- Bike Shop ------------------------>
        <%if(sGrpType.equals("SG")){%>
         <tr>
           <td class="DataTable2" colspan="18">&nbsp;&nbsp;Bike Shop</td>
         </tr>
        <%for(int i=0; i < iNumOfNBk; i++) {%>
         <tr>
           <td class="DataTable"><%=sNBk[i]%></td>
           <td class="DataTable4"><%=sNBkTtl[i]%></td>
           <td class="DataTable3"><%=sNBkHrs[i]%></td>
           <td class="DataTable3">$<%=sNBkPay[i]%></td>
           <td class="DataTable3">$<%=sNBkAvg[i]%></td>
           <td class="DataTable3"><%=sNBkPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sNBkActHrs[i]%></td>
           <td class="DataTable3">$<%=sNBkActPay[i]%></td>
           <td class="DataTable3">$<%=sNBkActAvg[i]%></td>
           <td class="DataTable3"><%=sNBkActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable"><a href="javascript:rtvActPayDtl(<%=sNBkNum[i]%>, '<%=sNBk[i]%>')">D</a></th>
           <td class="DataTable3"><%=sNBkVarHrs[i]%></td>
           <td class="DataTable3">$<%=sNBkVarPay[i]%></td>
           <td class="DataTable3">$<%=sNBkVarAvg[i]%></td>
         </tr>
        <%}%>
        <!----------------- Group Total ------------------------>
         <%if(iNumOfNBk != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <td class="Total1"><%=sTotNBkHrs%></td>
            <td class="Total1">$<%=sTotNBkPay%></td>
            <td class="Total1">$<%=sTotNBkAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotNBkPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActNBkHrs%></td>
            <td class="Total1">$<%=sTotActNBkPay%></td>
            <td class="Total1">$<%=sTotActNBkAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActNBkPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarNBkHrs%></td>
            <td class="Total1">$<%=sTotVarNBkPay%></td>
            <td class="Total1">$<%=sTotVarNBkAvg%></td>
          </tr>
         <%}%>
         <%}%>
        <!----------------- Other ------------------------>
        <%if(sGrpType.equals("SG")){%>
         <tr>
           <td class="DataTable2" colspan="18">&nbsp;&nbsp;Other</td>
         </tr>
        <%for(int i=0; i < iNumOfNOt; i++) {%>
         <tr>
           <td class="DataTable"><%=sNOt[i]%></td>
           <td class="DataTable4"><%=sNOtTtl[i]%></td>
           <td class="DataTable3"><%=sNOtHrs[i]%></td>
           <td class="DataTable3">$<%=sNOtPay[i]%></td>
           <td class="DataTable3">$<%=sNOtAvg[i]%></td>
           <td class="DataTable3"><%=sNOtPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sNOtActHrs[i]%></td>
           <td class="DataTable3">$<%=sNOtActPay[i]%></td>
           <td class="DataTable3">$<%=sNOtActAvg[i]%></td>
           <td class="DataTable3"><%=sNOtActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable" id="thDtl<%=i%>"><a href="javascript:rtvActPayDtl(<%=sNOtNum[i]%>, '<%=sNOt[i]%>')">D</a></th>
           <td class="DataTable3"><%=sNOtVarHrs[i]%></td>
           <td class="DataTable3">$<%=sNOtVarPay[i]%></td>
           <td class="DataTable3">$<%=sNOtVarAvg[i]%></td>
         </tr>
        <%}%>
        <!----------------- Group Total ------------------------>
         <%if(iNumOfNOt != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <td class="Total1"><%=sTotNOtHrs%></td>
            <td class="Total1">$<%=sTotNOtPay%></td>
            <td class="Total1">$<%=sTotNOtAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotNOtPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActNOtHrs%></td>
            <td class="Total1">$<%=sTotActNOtPay%></td>
            <td class="Total1">$<%=sTotActNOtAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActNOtPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarNOtHrs%></td>
            <td class="Total1">$<%=sTotVarNOtPay%></td>
            <td class="Total1"><%=sTotVarNOtAvg%>%</td>
          </tr>
         <%}%>
        <%}%>

        <!----------------- Trainig ------------------------>
        <%if(sGrpType.equals("SG")){%>
         <tr>
           <td class="Total3" colspan="18">&nbsp;&nbsp;Training</td>
         </tr>
        <%for(int i=0; i < iNumOfTrn; i++) {%>
         <tr>
           <td class="DataTable"><%=sTrn[i]%></td>
           <td class="DataTable4"><%=sTrnTtl[i]%></td>
           <td class="DataTable3"><%=sTrnHrs[i]%></td>
           <td class="DataTable3">$<%=sTrnPay[i]%></td>
           <td class="DataTable3">$<%=sTrnAvg[i]%></td>
           <td class="DataTable3"><%=sTrnPGPay[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable3"><%=sTrnActHrs[i]%></td>
           <td class="DataTable3">$<%=sTrnActPay[i]%></td>
           <td class="DataTable3">$<%=sTrnActAvg[i]%></td>
           <td class="DataTable3"><%=sTrnActPrc[i]%>%</td>
           <td class="DataTable4">--</td>
           <th class="DataTable"><a href="javascript:rtvActPayDtl(<%=sTrnNum[i]%>, '<%=sTrn[i]%>')">D</a></th>
           <td class="DataTable3"><%=sTrnVarHrs[i]%></td>
           <td class="DataTable3">$<%=sTrnVarPay[i]%></td>
           <td class="DataTable3">$<%=sTrnVarAvg[i]%></td>
         </tr>
        <%}%>
        <!----------------- Group Total ------------------------>
         <%if(iNumOfTrn != 0){%>
          <tr>
            <td class="Total" colspan="2">Total</td>
            <td class="Total1"><%=sTotTrnHrs%></td>
            <td class="Total1">$<%=sTotTrnPay%></td>
            <td class="Total1">$<%=sTotTrnAvg%></td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotTrnPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotActTrnHrs%></td>
            <td class="Total1">$<%=sTotActTrnPay%></td>
            <td class="Total1"><%=sTotActTrnAvg%>%</td>
            <td class="Total2">100%</td>
            <td class="Total1"><%=sTotActTrnPrc%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total1"><%=sTotVarTrnHrs%></td>
            <td class="Total1">$<%=sTotVarTrnPay%></td>
            <td class="Total1">$<%=sTotVarTrnAvg%></td>
          </tr>
         <%}%>
        <%}%>
        <!----------------- Store Table ------------------------>
         <tr>
           <td class="Total3" colspan="2">Store Total</td>
           <%if(!sGrpType.equals("SG")){%>
             <td class="Total4">&#160;</td>
            <%}%>
            <td class="Total4"><%=sTotRepHrs%></td>
            <td class="Total4">$<%=sTotRepPay%></td>
            <td class="Total4">$<%=sTotRepAvg%></td>
            <td class="Total5">--</td>
            <td class="Total5">100%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total4"><%=sTotActRepHrs%></td>
            <td class="Total4">$<%=sTotActRepPay%></td>
            <td class="Total4">$<%=sTotActRepAvg%></td>
            <td class="Total5">--</td>
            <td class="Total5">100%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="Total4"><%=sTotVarRepHrs%></td>
            <td class="Total4">$<%=sTotVarRepPay%></td>
            <td class="Total4">$<%=sTotVarRepAvg%></td>
         </tr>
     </table>
<!------------- end of data table ------------------------>
                </td>
            </tr>
       </table>


  </body>
</html>
