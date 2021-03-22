<%@ page import=" classreports.ChBonusLst, java.util.*"%>
<%
    String sCode = request.getParameter("Code");
    String sName = request.getParameter("Name");

 if (session.getAttribute("USER")!=null)
 {

    String sUser = session.getAttribute("USER").toString();

    ChBonusLst chbonlst = new ChBonusLst(sCode, sUser);
    String sEmpGrp = chbonlst.getEmpGrp();
    String sType = chbonlst.getType();
    String sBonusType = chbonlst.getBonusType();
    String sPayBrnz = chbonlst.getPayBrnz();
    String sPaySlvr = chbonlst.getPaySlvr();
    String sPayGold = chbonlst.getPayGold();
%>

<script name="javascript1.2">
var EmpGrp = [<%=sEmpGrp%>];
var Type = [<%=sType%>];
var BonusType = [<%=sBonusType%>];
var PayBrnz = [<%=sPayBrnz%>];
var PaySlvr = [<%=sPaySlvr%>];
var PayGold = [<%=sPayGold%>];

parent.showBonuses("<%=sCode%>", "<%=sName%>", EmpGrp, Type, BonusType, PayBrnz, PaySlvr, PayGold);

//==============================================================================
// run on loading
//==============================================================================

</script>

<%
   chbonlst.disconnect();
   chbonlst = null;
}
else {%> alert("Your session is expired. Please refresh your screen.") <%}%>