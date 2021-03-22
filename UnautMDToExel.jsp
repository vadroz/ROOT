<%@ page import="unautmdreport.UnautMDToExel, java.util.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
    String sSelStr = request.getParameter("STORE");
    String sSelDiv = request.getParameter("DIVISION");
    String sSelDpt = request.getParameter("DEPARTMENT");
    String sSelCls = request.getParameter("CLASS");
    String sFromDate = request.getParameter("FromDate");
    String sToDate = request.getParameter("ToDate");
    String sMin = request.getParameter("MIN");
    String sMax = request.getParameter("MAX");
    String sAmtType = request.getParameter("AMTTYPE");
    String sEmpPurch = request.getParameter("EMPPURCH");
    String sSort = request.getParameter("SORT");

    if (sSelCls == null) {sSelCls = "ALL"; }
    if (sSort == null) {sSort = " "; }

    out.println("\t\tStore: " + sSelStr
               + "\n\t\tDivision: " + sSelDiv
               + "\tDepartment: " + sSelDpt
               + "\tClass: " + sSelCls
               + "\n\t\tFrom: " + sFromDate
               + "\tTo:" + sToDate
               + "\n\t\tMinimum: " + sMin
               + "\tMaximum: " + sMax
              );
    UnautMDToExel unamdx = new UnautMDToExel(sSelStr, sSelDiv, sSelDpt, sFromDate, sToDate,
                                            sMin, sMax, sAmtType, sEmpPurch, sSort);

     //headers
     out.println("Str \t Cashier \t Reg# \t Trans# \t Date of Sales \t Div# \t Dpt# \t Cls# "
       + "\t Vendor Name \t RCL \t Short SKU \t Item Description \t On Hand \t Qty \t Current Retail"
       + "\t Sold For \t Disc Amt \t Reason \t Emp Purch \t % off \t Date Mkdwn \t Temp Price \t Date");

     while(unamdx.next())
     {
        unamdx.setItemLst();
        int iNumOfItm = unamdx.getNumOfItm();
        String [] sCashr =  unamdx.getCashr();
        String [] sCshName =  unamdx.getCshName();
        String [] sReg =  unamdx.getReg();
        String [] sTran =  unamdx.getTran();
        String [] sStr =  unamdx.getStr();
        String [] sDiv =  unamdx.getDiv();
        String [] sDpt =  unamdx.getDpt();
        String [] sCls =  unamdx.getCls();
        String [] sDesc =  unamdx.getDesc();
        String [] sVenName =  unamdx.getVenName();
        String [] sSku =  unamdx.getSku();
        String [] sSlsDat =  unamdx.getSlsDat();
        String [] sReclass =  unamdx.getReclass();
        String [] sOnHand =  unamdx.getOnHand();
        String [] sQty =  unamdx.getQty();
        String [] sRet =  unamdx.getRet();
        String [] sSoldFor =  unamdx.getSoldFor();
        String [] sDiscAmt =  unamdx.getDiscAmt();
        String [] sDiscPrc =  unamdx.getDiscPrc();
        String [] sDiscCode =  unamdx.getDiscCode();
        String [] sDiscName =  unamdx.getDiscName();
        String [] sExtDisc =  unamdx.getExtDisc();
        String [] sExtDiscName =  unamdx.getExtDiscName();
        String [] sMkdDate =  unamdx.getMkdDate();
        String [] sTmpSls =  unamdx.getTmpSls();
        String [] sTmpDate = unamdx.getTmpDate();

        for(int i=0; i < iNumOfItm; i++ )
        {
           out.println(sStr[i] + "\t" + sCashr[i] + "-" + sCshName[i]
             + "\t" + sReg[i] + "\t" + sTran[i] + "\t" + sSlsDat[i] + "\t" + sDiv[i]
             + "\t" + sDpt[i] + "\t" + sCls[i] + "\t" + sVenName[i] + "\t" + sReclass[i]
             + "\t" + sSku[i] + "\t" + sDesc[i] + "\t" + sOnHand[i]  + "\t" + sQty[i]
             + "\t" + sRet[i] + "\t" + sSoldFor[i] + "\t" + sDiscAmt[i] + "\t" + sDiscCode[i] + " - " + sDiscName[i]
             // + "\t" + sExtDisc[i] + " - " + sExtDiscName[i] + "\t" + sDiscPrc[i]
             + "\t" + sExtDiscName[i] + "\t" + sDiscPrc[i]
             + "\t" + sMkdDate[i] + "\t" + sTmpSls[i] + "\t" + sTmpDate[i]
           );
        }
     }


    out.println("End Of Report");

    unamdx.disconnect();
    unamdx = null;
%>

