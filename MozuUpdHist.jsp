<%@ page import="java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet, rciutility.CallAs400SrvPgmSup"%>
<%

	String sSelParent = request.getParameter("Parent");


	String sStmt = "Select parent, prod, stock, msrp, price, sales, date(recdt) as recdt, time(recdt) as rectm"
		  + " from RCI.MOPRCINV"
		  + " where prod like ('" + sSelParent + "%')"
		  + " order by date(recdt) desc, time(recdt) desc,Parent, prod "		      
	   ;
	
	//System.out.println(sStmt);
	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
 	  
	Vector<String> vParent = new Vector();
	Vector<String> vProd = new Vector();
	Vector<String> vStock = new Vector();
	Vector<String> vMsrp = new Vector();
	Vector<String> vPrice = new Vector();
	Vector<String> vSales = new Vector();
	Vector<String> vDate = new Vector();
	Vector<String> vTime = new Vector();
	
	while(runsql.readNextRecord())
	{
		vParent.add(runsql.getData("parent").trim());
		vProd.add(runsql.getData("prod").trim());
		vStock.add(runsql.getData("stock").trim());
		vMsrp.add(runsql.getData("msrp").trim());
		vPrice.add(runsql.getData("price").trim());
		vSales.add(runsql.getData("sales").trim());
		vDate.add(runsql.getData("recdt").trim());
		vTime.add(runsql.getData("rectm").trim());
	}
	rs.close();
	runsql.disconnect();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();	
	String sParent = srvpgm.cvtToJavaScriptArray(vParent.toArray(new String[]{}));
	String sProd = srvpgm.cvtToJavaScriptArray(vProd.toArray(new String[]{}));
	String sStock = srvpgm.cvtToJavaScriptArray(vStock.toArray(new String[]{}));
	String sMsrp = srvpgm.cvtToJavaScriptArray(vMsrp.toArray(new String[]{}));
	String sPrice = srvpgm.cvtToJavaScriptArray(vPrice.toArray(new String[]{}));
	String sSales = srvpgm.cvtToJavaScriptArray(vSales.toArray(new String[]{}));
	String sDate = srvpgm.cvtToJavaScriptArray(vDate.toArray(new String[]{}));
	String sTime = srvpgm.cvtToJavaScriptArray(vTime.toArray(new String[]{}));
%>
<html>
Parent: <%=sParent%>
<br> Prod <%=sProd%>
<br> <%=sStock%>
<br> <%=sMsrp%>
<br> <%=sPrice%>
<br> <%=sSales%>
<br> <%=sTime%>

<SCRIPT language="JavaScript1.2">
var par = [<%=sParent%>];
var prod = [<%=sProd%>];
var stock = [<%=sStock%>];
var msrp = [<%=sMsrp%>];
var price = [<%=sPrice%>];
var sales = [<%=sSales%>];
var rectime = [<%=sTime%>];
var recdate = [<%=sDate%>];

parent.setUpdHist(par, prod, stock, msrp, price,sales,recdate, rectime);   

</SCRIPT>


