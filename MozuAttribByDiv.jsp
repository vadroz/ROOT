<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
String sUserId = request.getParameter("User");  
String sDiv = request.getParameter("Div");
String sFromDt = request.getParameter("FromDt");
String sToDt = request.getParameter("ToDt"); 

if(sUserId == null){ sUserId="";}
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  		
	String sStmt = "with divf as(" 
	 + " select idiv, idpt, wcls, wven, wsty, max(ides) as ides, count(*) as count"
	 + ", sum(itiu * iret) as onh" 
	 + ", sum((select sum((iqty - itqr) * i.iret) from iptsfil.IpPoItm i where"
	 + " i.icls=wcls and i.iven=wven and i.isty=wsty and i.iclr=wclr"
	 + " and i.isiz=wsiz and ierr <> 'C'"                            
	 + " and iadi > current date - 14 days"                            
	 + " and iadi < current date + 90 days)"                           
	 + " ) as pon"
	 + " from rci.MoItWeb" 
	 + " inner join iptsfil.IpItHdr on wcls = icls and wven=iven and wsty=isty and wclr=iclr and wsiz=isiz"
	 + " where WDDAT >='"  + sFromDt + "' and WDDAT <='" + sToDt + "'"
	 + " and wduid='" + sUserId + "' and idiv=" + sDiv
	 + " group by idiv, idpt, wcls, wven, wsty"	                                            
	 + " order by idiv, idpt, wcls, wven, wsty"
	 + ")"
	 + " select idiv, idpt, digits(wcls) as wcls, digits(wven) as wven, digits(wsty) as wsty,ides, count"
	 + ", case when pon is null then onh else onh + pon end as ret"
	 + " from divf"
		     ;
	System.out.println(sStmt);
	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	Vector<String> vDiv = new Vector<String>();
	Vector<String> vDpt = new Vector<String>();
	Vector<String> vCls = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vSty = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
	Vector<String> vCount = new Vector<String>();
	Vector<String> vRet = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vDiv.add(runsql.getData("idiv").trim());
		vDpt.add(runsql.getData("idpt").trim());
		vCls.add(runsql.getData("wcls").trim());
		vVen.add(runsql.getData("wven").trim());
		vSty.add(runsql.getData("wsty").trim());
		String desc = runsql.getData("ides");
		desc = desc.replaceAll("'", "`");
		vDesc.add(desc.trim());
		vCount.add(runsql.getData("count").trim());
		vRet.add(runsql.getData("ret").trim());
	}
	
	String [] sDivLst = vDiv.toArray(new String[]{});
	String [] sDpt = vDpt.toArray(new String[]{});
	String [] sCls = vCls.toArray(new String[]{});
	String [] sVen = vVen.toArray(new String[]{});
	String [] sSty = vSty.toArray(new String[]{});
	String [] sDesc = vDesc.toArray(new String[]{});
	String [] sCount = vCount.toArray(new String[]{});
	String [] sRet = vRet.toArray(new String[]{});
	 
	rs.close();
	runsql.disconnect();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();	
%>
	
<SCRIPT>	
var div = [<%=srvpgm.cvtToJavaScriptArray(sDivLst)%>];
var dpt = [<%=srvpgm.cvtToJavaScriptArray(sDpt)%>];
var cls = [<%=srvpgm.cvtToJavaScriptArray(sCls)%>];
var ven = [<%=srvpgm.cvtToJavaScriptArray(sVen)%>];
var sty = [<%=srvpgm.cvtToJavaScriptArray(sSty)%>];
var desc = [<%=srvpgm.cvtToJavaScriptArray(sDesc)%>];
var count = [<%=srvpgm.cvtToJavaScriptArray(sCount)%>];
var ret = [<%=srvpgm.cvtToJavaScriptArray(sRet)%>];
  
parent.showAttribByDiv(div, dpt, cls, ven, sty, desc, count, ret);
   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

