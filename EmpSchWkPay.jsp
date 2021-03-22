<%@ page import="payrollreports.EmpSchWkPay"%>
<%
    String sStore = request.getParameter("STORE");
    String sEmp = request.getParameter("EmpNum");
    String sWkend = request.getParameter("WEEKEND");

    EmpSchWkPay schpay = new EmpSchWkPay(sStore, sEmp, sWkend);
    String sSchHrs = schpay.getSchHrs();
    String sSchReg = schpay.getSchReg();
    String sSchVac = schpay.getSchVac();
    String sSchHol = schpay.getSchHol();
    String sSchRegPay = schpay.getSchRegPay();
    String sSchCom = schpay.getSchCom();
    String sSchAllPay = schpay.getSchAllPay();
    String sSchAvg = schpay.getSchAvg();
    String sEmpRate = schpay.getEmpRate();
    String sEmpRate3 = schpay.getEmpRate3();
    String sSchSlsHrs = schpay.getSchSlsHrs();
    String sEmpHorS = schpay.getEmpHorS();
    String sEmpComTy = schpay.getEmpComTy();
    String sEmpOrgStr = schpay.getEmpOrgStr();

    schpay.disconnect();
%>


<script name="javascript1.2">
  var SchHrs = "<%=sSchHrs%>";
  var SchReg = "<%=sSchReg%>";
  var SchVac = "<%=sSchVac%>";
  var SchHol = "<%=sSchHol%>";
  var SchRegPay = "<%=sSchRegPay%>";
  var SchCom = "<%=sSchCom%>";
  var SchAllPay = "<%=sSchAllPay%>";
  var SchAvg = "<%=sSchAvg%>";
  var EmpRate = "<%=sEmpRate%>";
  var EmpRate3 = "<%=sEmpRate3%>";
  var SchSlsHrs = "<%=sSchSlsHrs%>";
  var EmpHorS = "<%=sEmpHorS%>";
  var EmpComTy = "<%=sEmpComTy%>";
  var EmpOrgStr = "<%=sEmpOrgStr%>";

  setEmpPay();
//==============================================================================
// Return  employee pays to budget detail page
//==============================================================================
function setEmpPay()
{
   parent.showEmpSchPay(SchHrs, SchReg, SchVac, SchHol, SchRegPay, SchCom, SchAllPay,
                  SchAvg, EmpRate, EmpRate3, SchSlsHrs, EmpHorS, EmpComTy, EmpOrgStr);
}
</script>

<body>None</body>
