<%@ page import="salesreport.SlsRep04"%>
<%
      String [] sDiv = request.getParameterValues("Div");
      String sDpt = request.getParameter("Dpt");
      String sCls = request.getParameter("Cls");
      String sVen = request.getParameter("Ven");
      String [] sStr = request.getParameterValues("Str");
      String sFrDate = request.getParameter("FrDate");
      String sToDate = request.getParameter("ToDate");
      String sFrYear = request.getParameter("FrYear");
      String sFrMonth = request.getParameter("FrMonth");
      String sToYear = request.getParameter("ToYear");
      String sToMonth = request.getParameter("ToMonth");
      String [] sSumOpt = request.getParameterValues("SO");
      String sStrLvl = request.getParameter("StrLvl");
      String sComment = request.getParameter("Comment");
      String sDatLvl = request.getParameter("DatLvl");
      String [] sData = request.getParameterValues("Data");
      String sIncLY = request.getParameter("IncLY");
      String sIncLLY = request.getParameter("IncLLY");
      String sSumDate = request.getParameter("SumDate");


      if(sFrDate==null){ sFrDate = " ";}
      if(sToDate==null){ sToDate = " ";}  
      if(sFrYear==null){ sFrYear = " ";}
      if(sToYear==null){ sToYear = " ";}
      if(sFrMonth==null){ sFrMonth = " ";}
      if(sToMonth==null){ sToMonth = " ";}

      String sUser = session.getAttribute("USER").toString();

      System.out.println(0);
      SlsRep04 slsrep = new SlsRep04(sDiv, sDpt, sCls, sVen, sStr,
      sFrDate, sToDate, sFrYear, sToYear, sFrMonth, sToMonth, sIncLY, sIncLLY, sSumDate, sDatLvl,
                      sSumOpt, sStrLvl, sComment, sData, sUser );

      slsrep.disconnect();
      slsrep = null;
%>
<script language="javascript">

parent.closeFrame();
</script>


