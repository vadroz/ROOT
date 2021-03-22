<%@ page import="salesvelocity.HCDlyLst, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sStrOpt = request.getParameter("StrOpt");
   String sDatOpt = request.getParameter("DatOpt");
   String sSort = request.getParameter("Sort");

   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");

   if(sFrom == null)
   {
      Date dtPrior  = new Date(new Date().getTime() - 24 * 60 * 60 * 1000);
      sFrom = smp.format(dtPrior);
   }
   if(sTo == null)
   {
      Date dtPrior  = new Date(new Date().getTime() - 24 * 60 * 60 * 1000);
      sTo = smp.format(dtPrior);
   }
   if(sStrOpt == null){ sStrOpt = "STR"; }
   if(sDatOpt == null){ sDatOpt = "NONE"; }
   if(sSort == null){ sSort = "STR"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=HCDlyLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   StoreSelect strsel = new StoreSelect(17);
   String sStrJsa = strsel.getStrNum();
   String sStrNameJsa = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   String sStrRegJsa = strsel.getStrReg();

   String [] sStrDistLst = strsel.getStrDistLst();
   String sStrDistJsa = strsel.getStrDist();
   String [] sStrDistNmLst = strsel.getStrDistNmLst();
   String sStrDistNmJsa = strsel.getStrDistNm();

   String [] sStrMallLst = strsel.getStrMallLst();
   String sStrMallJsa = strsel.getStrMall();

   int iSpace = 6;

   String sUser = session.getAttribute("USER").toString();

   sSelStr = new String[iNumOfStr];
   for(int i=0; i < iNumOfStr; i++)
   {
      sSelStr[i] = sStrLst[i];
   }

   //System.out.println(sStrJsa + "|" + sFrom + "|" + sTo + "|" + sStrOpt + "|" + sDatOpt + "|" + sSort + "|" + sUser);
   HCDlyLst hcdly = new HCDlyLst(sSelStr, sFrom, sTo, "Y", "None", new String[]{"0","0","0"}
                         , "STR", sUser);
   
   
%>
<html>
</head>
<body>
           <!-- ============== Totals =======================================-->
           <%
              hcdly.setTotal();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
           %>
      <table style="border:2px ridge lightgray; background:cornsilk; text-align:left;
             font-size:12px;padding-left:3px; padding-right:3px;padding-top:3px;
             padding-bottom:3px;white-space:nowrap;"
             cellPadding="0" cellSpacing="0" id="tbConv">
         <tr><th style="white-space:nowrap; color:brown; font-size:14px" colspan=2><u>Yesterday's Daily Traffic & Conversion<br>Variance to LY</u></th></tr>

         <tr><th>Traffic</th><td style="text-align:right;<%if(sVaTraf.indexOf("-") > 0){%>color:red<%}%>"><%=sVaTraf%>%</td></tr>
         <tr><th>Conversion Rate</th><td style="text-align:right;<%if(sVaConv.indexOf("-") > 0){%>color:red<%}%>"><%=sVaConv%>%</td></tr>
         <tr><th>Average Sales Price</th><td style="text-align:right;<%if(sVaAsp.indexOf("-") > 0){%>color:red<%}%>"><%=sVaAsp%>%</td></tr>
         <tr><th>Net Sales</th><td style="text-align:right;<%if(sVaTotNet.indexOf("-") > 0){%>color:red<%}%>"><%=sVaTotNet%>%</td></tr>

         <tr><td colspan=2>Updated daily at approximately 9:45 am.</td></tr>
         <!--tr><td colspan=2>Excludes stores 40 & 98 and stores with no LY data</td></tr -->
      </table>
      <!----------------------- end of table ------------------------>
 </body>
 <SCRIPT language="JavaScript1.2">
 //--------------- Global variables -----------------------
 var html = document.all.tbConv.outerHTML;
 parent.document.all.dvConv.innerHTML = html;
 //--------------- End of Global variables ----------------
 </SCRIPT>

</html>
<%
  hcdly.disconnect();
  hcdly = null;
}
%>