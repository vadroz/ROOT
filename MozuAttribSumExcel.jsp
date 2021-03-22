<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*, rciutility.CallAs400SrvPgmSup"
    
%>

<%
String sFromDt = request.getParameter("FromDt");
String sToDt = request.getParameter("ToDt");
String sAction = request.getParameter("Action");
if(sAction == null){ sAction = "By Division";}
 
response.setContentType("text/csv");
response.setHeader("Content-Disposition", "attachment; filename=Emp_Attr_Sum02.csv");

//----------------------------------
// Application Authorization
//----------------------------------
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuAttribSumExcel.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	 String sStmt = "";
	 
	 if(sAction.equals("By Division"))
	 {
	 
     sStmt = "with divf as(" 
	 + " select idiv, idpt, wcls, wven, wsty, max(ides) as ides, count(*) as count"
	 + ", sum(itiu * iret) as onh" 
	 + ", sum((select sum((iqty - itqr) * i.iret) from iptsfil.IpPoItm i where"
	 + " i.icls=wcls and i.iven=wven and i.isty=wsty and i.iclr=wclr"
	 + " and i.isiz=wsiz and ierr <> 'C'"                            
	 + " and iadi > current date - 14 days"                            
	 + " and iadi < current date + 90 days)"                           
	 + " ) as pon, max(WDDAT) as wddat, wduid"
	 + " from rci.MoItWeb" 
	 + " inner join iptsfil.IpItHdr on wcls = icls and wven=iven and wsty=isty and wclr=iclr and wsiz=isiz"
	 + " where WDDAT >='"  + sFromDt + "' and WDDAT <='" + sToDt + "'"
	 + " group by idiv, idpt, wcls, wven, wsty, wduid"
	 + ")"
	 + " select idiv, idpt, digits(wcls) as wcls, digits(wven) as wven, digits(wsty) as wsty,ides, count"
	 + ", case when pon is null then onh else onh + pon end as ret"
	 + ", wddat, wduid, dnam, vnam"
	 + " from divf"
	 + " inner join iptsfil.IpDivsn on ddiv=idiv"
	 + " inner join iptsfil.IpMrVen on vven=wven"
	 + " order by wduid, idiv, idpt, wcls, wven, wsty"
		     ;
	  //System.out.println(sStmt);
	
	}
	else if(sAction.equals("By Vendor"))
	{
		sStmt =  "with venf as("  
		 + "select idiv, idpt, wcls, wven, wsty, max(ides) as ides, count(*) as count"               
		 + ", sum(itiu * iret) as onh" 
		 + ", sum((select sum((iqty - itqr) * i.iret) from iptsfil.IpPoItm i where"
		 + " i.icls=wcls and i.iven=wven and i.isty=wsty and i.iclr=wclr"
		 + " and i.isiz=wsiz and ierr <> 'C'"                            
		 + " and iadi > current date - 14 days"                            
		 + " and iadi < current date + 90 days)"                           
		 + " ) as pon, max(WDDAT) as wddat, wduid"
		 + " from rci.MoItWeb" 
		 + " inner join iptsfil.IpItHdr on wcls = icls and wven=iven and wsty=isty and wclr=iclr and wsiz=isiz"
		 + " where WDDAT >='"  + sFromDt + "' and WDDAT <='" + sToDt + "'"		 
		 + " group by idiv, idpt, wcls, wven, wsty, wduid"	
		 + ")"
		 + " select idiv, idpt, digits(wcls) as wcls, digits(wven) as wven, digits(wsty) as wsty,ides, count"
		 + ", case when pon is null then onh else onh + pon end as ret"
		 + ", wddat, wduid, dnam, vnam"
		 + " from venf"
		 + " inner join iptsfil.IpDivsn on ddiv=idiv"
		 + " inner join iptsfil.IpMrVen on vven=wven"
		 + " order by wduid, wven, idiv, idpt, wcls, wsty"
		 ;
	}	 
	 
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	
	String sHdr = "User";
	if(sAction.equals("By Vendor")){ sHdr += ",Vendor"; }
	sHdr += ",Div";
	sHdr += ",Dpt";
	sHdr += ",Parent";
	sHdr += ",Description";
	sHdr += ",Number Of Children";
	sHdr += ",Extended Retail";
	sHdr += ",Download Date";
	out.println(sHdr);
	
	while(runsql.readNextRecord())
	{			
	    String desc = runsql.getData("ides");
		desc = desc.replaceAll("'", "`");
	
		String sLine = runsql.getData("wduid");
		if(sAction.equals("By Vendor")){ sLine += "," + runsql.getData("wven") + " - " + runsql.getData("vnam"); }
	
		sLine += "," + runsql.getData("idiv") + " - " + runsql.getData("dnam");
		sLine += "," + runsql.getData("idpt");
		sLine += "," + runsql.getData("wcls") + runsql.getData("wven") + runsql.getData("wsty");
		sLine += "," + desc;
		sLine += "," + runsql.getData("count");
		sLine += "," + runsql.getData("ret");
		sLine += "," + runsql.getData("wddat");	 
		out.println(sLine);
	}
  
}
%>
