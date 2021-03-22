<%@ page import="unscanablesku.UnscanTrans , java.util.*"%>
<%
   String sStr = request.getParameter("Store");
   String sDate = request.getParameter("Date");
   String sReg = request.getParameter("Reg");
   String sTrans = request.getParameter("Trans");

   UnscanTrans unstrans = null;
   int iNumOfSls = 0;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
    //System.out.println(sStr + " " + sDate + " " + sReg + " " + sTrans);
    unstrans = new UnscanTrans(sStr, sDate, sReg, sTrans, session.getAttribute("USER").toString());
    iNumOfSls = unstrans.getNumOfSls();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   var Sku = new Array(<%=iNumOfSls%>);
   var Upc = new Array(<%=iNumOfSls%>);
   var Emp = new Array(<%=iNumOfSls%>);
   var EmpName = new Array(<%=iNumOfSls%>);
   var VenSty = new Array(<%=iNumOfSls%>);
   var Ret = new Array(<%=iNumOfSls%>);
   var Qty = new Array(<%=iNumOfSls%>);
   var Desc = new Array(<%=iNumOfSls%>);

    <%for(int i=0; i < iNumOfSls; i++)
      {
         unstrans.setSkuSls();
    %>
         Sku[<%=i%>] = "<%=unstrans.getSku()%>";
         Upc[<%=i%>] = "<%=unstrans.getUpc()%>";
         Emp[<%=i%>] = "<%=unstrans.getEmp()%>";
         EmpName[<%=i%>] = "<%=unstrans.getEmpName()%>";
         VenSty[<%=i%>] = "<%=unstrans.getVenSty()%>";
         Ret[<%=i%>] = "<%=unstrans.getRet()%>";
         Qty[<%=i%>] = "<%=unstrans.getQty()%>";
         Desc[<%=i%>] = "<%=unstrans.getDesc()%>";
    <%}%>
    <%unstrans.setSkuTot();%>
    var TotRet = "<%=unstrans.getRet()%>";
    var TotQty = "<%=unstrans.getQty()%>";
    <%unstrans.disconnect();%>

    parent.showTransDtl(Sku, Upc, Emp, EmpName, VenSty, Ret, Qty, Desc, TotRet, TotQty);
}
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







