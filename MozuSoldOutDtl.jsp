<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sDiv = request.getParameter("div");
   String sFrom = request.getParameter("from");
   String sTo = request.getParameter("to");
   String sSts = request.getParameter("sts"); 
   
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   	String sStmt = "";
   
   	String sSite = null;
   	sStmt = "select BxSite from RCI.MOSNDBX";           
	System.out.println(sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	if(runsql.readNextRecord())
	{
		sSite = runsql.getData("BxSite");
	}	
	rs.close();
	runsql.disconnect();
   
   
   sStmt = "select opord, opsku, ides, pnsn, pnsts, iret"
	+ " from Rci.MoOrPas"
	+ " inner join rci.MoSpStn on opid=pnpickid"
	+ " inner join rci.MoOrdh on opsite=ohsite and opord=ohord"
	+ " inner join iptsfil.IpItHDr on opsku=isku"
	+ " where opsite='" + sSite + "' and ohordate >='" + sFrom + "'"
	+ " and ohordate <='" + sTo + "'"
	+ " and idiv=" + sDiv	
	;
	
   if(!sSts.equals("ALL")){ sStmt += " and pnsts = '" + sSts + "'";}
   
   sStmt += " order by opord, opsku";
   
   System.out.println(sStmt);

   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   rs = runsql.runQuery();
   int j=0;

   Vector<String> vOrd = new Vector<String>();
   Vector<String> vSku = new Vector<String>();
   Vector<String> vDesc = new Vector<String>();
   Vector<String> vSn = new Vector<String>();
   Vector<String> vSts = new Vector<String>();
   Vector<String> vRet = new Vector<String>();

   while(runsql.readNextRecord())
   {
	   vOrd.add(runsql.getData("opord").trim());
	   vSku.add(runsql.getData("opsku").trim());
	   vDesc.add(runsql.getData("ides").trim());
	   vSn.add(runsql.getData("pnsn").trim());
	   vSts.add(runsql.getData("pnsts").trim());
	   vRet.add(runsql.getData("iret").trim());
   }
   
   runsql.disconnect();
   runsql = null;
%>
<SCRIPT language="JavaScript1.2">
var div = "<%=sDiv%>";
var ord = new Array();
var sku = new Array();
var sn = new Array();
var sts = new Array();
var ret = new Array();

<%for(int i=0; i < vOrd.size() ;i++){%>ord[<%=i%>] = "<%=vOrd.get(i)%>";<%}%>
<%for(int i=0; i < vSku.size() ;i++){%>sku[<%=i%>] = "<%=vSku.get(i)%>";<%}%>
<%for(int i=0; i < vSn.size() ;i++){%>sn[<%=i%>] = "<%=vSn.get(i)%>";<%}%>
<%for(int i=0; i < vSts.size() ;i++){%>sts[<%=i%>] = "<%=vSts.get(i)%>";<%}%>
<%for(int i=0; i < vRet.size() ;i++){%>ret[<%=i%>] = "<%=vRet.get(i)%>";<%}%>

parent.showOrdSku(div, ord, sku, sn, sts, ret);


</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

