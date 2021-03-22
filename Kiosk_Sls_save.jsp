<%@ page import="google_analytics.Kio_Sls_Save, java.text.*, java.util.*, java.sql.ResultSet"%>
<%
    String sDate = request.getParameter("Date");
    String sEmpNum = request.getParameter("EmpNum");
    String sStore = request.getParameter("Store");
    String sOrder = request.getParameter("Order");
    String sAmount = request.getParameter("Amount");
    String sTrans = request.getParameter("Trans");
    int arg = Integer.parseInt(request.getParameter("arg")) + 1;

    System.out.println(sEmpNum + "|" + sDate + "|" + sStore + "|" + sOrder + "|" + sAmount);

    Kio_Sls_Save savkiod = new Kio_Sls_Save(sEmpNum, sDate, sStore, sOrder, sAmount);
    savkiod.disconnect();
    savkiod = null;

%>
<script language="javascript">
  parent.saveData_in_DB("<%=arg%>")
</script>

