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
      <table border=1 id="tbConv" style="font-size:12px;border-spacing: 0; border-collapse: collapse; width:100%">
         <tr><th style="background:#016aab;
                 padding-top:0px; border:darkblue 1px solid;
                 color: white; vertical-align:top; text-align:center; font-size:16px; font-weight:bold }" colspan=4>
				    <span style="font-size: 10px">Click <a style="color:yellow" href="HCDlyLst.jsp">Here</a> for full Traffic Report</span>
                      &nbsp &nbsp &nbsp	&nbsp &nbsp &nbsp
				    <u>Yesterday's Daily Traffic & Conversion Variance to LY</u>
         &nbsp;<span style="font-size:10px;font-weight:lighter; color: gold;">(Updated daily at approximately 9:45 am.)</span>
         </th></tr>

         <tr style="background: ffc528;">
         	<th>Traffic</th>
         	<th>Conversion Rate</th>
         	<th>Average Sales Price</th>
         	<th>Net Sales</th>
         </tr>
         <tr style="background: cornsilk;">
         	<td style="text-align:center;<%if(sVaTraf.indexOf("-") > 0){%>color:red<%}%>"><%=sVaTraf%>%</td>
         	<td style="text-align:center;<%if(sVaConv.indexOf("-") > 0){%>color:red<%}%>"><%=sVaConv%>%</td>
         	<td style="text-align:center;<%if(sVaAsp.indexOf("-") > 0){%>color:red<%}%>"><%=sVaAsp%>%</td>
         	<td style="text-align:center;<%if(sVaTotNet.indexOf("-") > 0){%>color:red<%}%>"><%=sVaTotNet%>%</td>
         </tr>         
      </table>
      <!----------------------- end of table ------------------------>
 </body>
 <SCRIPT language="JavaScript1.2">
 //--------------- Global variables ----------------------- 
 var html = document.getElementById("tbConv").outerHTML; 
 parent.document.getElementById("dvConv").innerHTML = html;
 //--------------- End of Global variables ----------------
 </SCRIPT>

</html>
<%
  hcdly.disconnect();
  hcdly = null;
}
%>