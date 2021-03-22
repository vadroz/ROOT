<%@ page import="payrollreports.ActWkPay"%>
<%
    String sStore = request.getParameter("STORE");
    String sEmp = request.getParameter("EmpNum");
    String sWkend = request.getParameter("WEEKEND");   

    ActWkPay actpay = new ActWkPay(sStore, sEmp, sWkend);

    int iNumOfPay = actpay.getNumOfPay();

    String sActHrs = actpay.getActHrs();
    String sActWage = actpay.getActWage();
    String sActType = actpay.getActType();

    String sTotActHrs = actpay.getTotActHrs();
    String sTotActWage = actpay.getTotActWage();
    String sTotActType = actpay.getTotActType();

    actpay.disconnect();
%>


<script name="javascript1.2">
  var ActHrs = [<%=sActHrs%>];
  var ActPay = [<%=sActWage%>];
  var ActType = [<%=sActType%>];

  var TotActHrs = "<%=sTotActHrs%>";
  var TotActPay = "<%=sTotActWage%>";

  setEmpPay();
//==============================================================================
// Return  employee pays to budget detail page
//==============================================================================
function setEmpPay()
{
   parent.showEmpPay(ActHrs, ActPay, ActType, TotActHrs, TotActPay);
}
</script>

<body>None</body>
