<%@ page import="employeecenter.AnnualSalaryReview, java.util.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
    String [] sStore = request.getParameterValues("Str");
    String [] sSelDpt = request.getParameterValues("Dept");
    String [] sSelTtl = request.getParameterValues("Ttl");
    String sType = request.getParameter("Type");
    String sSort = request.getParameter("Sort");

    if(sSort ==null){ sSort = "EMPNUM"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("EMPSALARY")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AnnualSalRevLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
     String sUser = session.getAttribute("USER").toString();

     AnnualSalaryReview salrev = new AnnualSalaryReview(sStore, sSelDpt, sSelTtl, sType, sSort, sUser);
     int iNumOfEmp = salrev.getNumOfEmp();

     int iNumOfReg = salrev.getNumOfReg();
     String [] sReg = salrev.getReg();

     out.print("Annual Salary Review Worksheet Summary");
     out.print("Rci#\tEmployee Name\tStore\tH or S\tCommission\tDept\tTitle\tHire Date\tNewDept\tPerformance\tLeadershp\tPotential"
      + "\tRate\tNew Rate\tNew Prc\tLY Hours");

     for(int i=0; i < iNumOfEmp; i++ )
     {
        salrev.setEmpList();
        String sEmp = salrev.getEmp();
            String sEmpName = salrev.getEmpName();
            String sStr = salrev.getStr();
            String sTitle = salrev.getTitle();
            String sRate = salrev.getRate();
            String sHireDate = salrev.getSalary();
            String sCommission = salrev.getCommission();
            String sAdp = salrev.getAdp();
            String sDept = salrev.getDept();
            String sHorS = salrev.getHorS();
            String sAvgRate1 = salrev.getAvgRate1();
            String sAvgRate2 = salrev.getAvgRate2();
            String sRate3 = salrev.getRate3();
            String sRatEffDt = salrev.getRatEffDt();
            String sNewPrc = salrev.getNewPrc();
            String sNewRate = salrev.getNewRate();
            String sPayAmt = salrev.getPayAmt();
            String sPayHrs = salrev.getPayHrs();
            String sMarked = salrev.getMarked();
            String sLyNewAmt = salrev.getLyNewAmt();
            String sLyPrc = salrev.getLyPrc();
            String sLyDiff = salrev.getLyDiff();
            String sRvwWrt = salrev.getRvwWrt();
            String sRvwGvn = salrev.getRvwGvn();
            String sPerf = salrev.getPerf();
            String sLeader = salrev.getLeader();
            String sPotenl = salrev.getPotenl();
            String sPerfNm = salrev.getPerfNm();
            String sLeaderNm = salrev.getLeaderNm();
            String sPotenlNm = salrev.getPotenlNm();
            String sSales = salrev.getSales();
            String sSlsHrs = salrev.getSlsHrs();
            String sLastPyDt = salrev.getLastPyDt();
            String sLLyCom = salrev.getLLyCom();
            String sLyCom = salrev.getLyCom();
            String sTyCom = salrev.getTyCom();
            String sLyCoin = salrev.getLyCoin();
            String sTyCoin = salrev.getTyCoin();
            String sLyPay_Com = salrev.getLyPay_Com();
            String sTyPay_Com = salrev.getTyPay_Com();
            String sNewDept = salrev.getNewDept();
            if(sMarked.equals("1"))
            {
               out.print("\n" +sEmp + "\t" + sEmpName + "\t" + sStr + "\t" + sHorS
                + "\t" + sCommission + "\t" + sDept + "\t" + sTitle + "\t" + sHireDate
                + "\t" + sNewDept
                + "\t" + sPerfNm  + "\t" + sLeaderNm + "\t" + sPotenlNm
                + "\t$" + sRate + "\t$" + sNewRate  + "\t" + sNewPrc + "%"
                + "\t" + sPayHrs
              );
       }
      }
    salrev.disconnect();
   }
%>