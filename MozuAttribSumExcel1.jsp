<%@ page import="mozu_com.MozuAttribSumGenExcel, rciutility.RunSQLStmt
 , java.sql.*,java.text.*, java.util.*, rciutility.CallAs400SrvPgmSup, java.io.*
   "
contentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
%>

<%
String sFromDt = request.getParameter("FromDt");
String sToDt = request.getParameter("ToDt");
String sAction = request.getParameter("Action");
if(sAction == null){ sAction = "By Division";} 
 
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
	 + " ) as pon, max(WLTDD) as WLTDD, wduid"
	 + " from rci.MoItWeb" 
	 + " inner join iptsfil.IpItHdr on wcls = icls and wven=iven and wsty=isty and wclr=iclr and wsiz=isiz"
	 + " where WLTDD >='"  + sFromDt + "' and WLTDD <='" + sToDt + "'"
	 + " group by idiv, idpt, wcls, wven, wsty, wduid"
	 + ")"
	 + " select idiv, idpt, digits(wcls) as wcls, digits(wven) as wven, digits(wsty) as wsty,ides, count"
	 + ", case when pon is null then onh else onh + pon end as ret"
	 + ", WLTDD, wduid, dnam, vnam"
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
		 + " ) as pon, max(WLTDD) as WLTDD, wduid"
		 + " from rci.MoItWeb" 
		 + " inner join iptsfil.IpItHdr on wcls = icls and wven=iven and wsty=isty and wclr=iclr and wsiz=isiz"
		 + " where WLTDD >='"  + sFromDt + "' and WLTDD <='" + sToDt + "'"		 
		 + " group by idiv, idpt, wcls, wven, wsty, wduid"	
		 + ")"
		 + " select idiv, idpt, digits(wcls) as wcls, digits(wven) as wven, digits(wsty) as wsty,ides, count"
		 + ", case when pon is null then onh else onh + pon end as ret"
		 + ", WLTDD, wduid, dnam, vnam"
		 + " from venf"
		 + " inner join iptsfil.IpDivsn on ddiv=idiv"
		 + " inner join iptsfil.IpMrVen on vven=wven"
		 + " order by wduid, wven, idiv, idpt, wcls, wsty"
		 ;
	}	 
	 	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	try 
	{	 
    
    String sFile = "empatrsum";
	MozuAttribSumGenExcel crtbook = new MozuAttribSumGenExcel();
	crtbook.setBook(sFile);  
    
	int rowCount = 0;
	int columnCount = 0;  
	
	// report name    
	crtbook.setMergingArea(0, 0, 0, 8);
	crtbook.setMergingArea(1, 1, 0, 8);
    crtbook.setRow(rowCount++); 
    crtbook.setStringCell(0, "Mozu - Employee Attribution Summary", true, (short) 47, false);    
    crtbook.setRow(rowCount++); 
    crtbook.setStringCell(0, "From: " + sFromDt + "   To: " + sToDt, true, (short) 47, false);
        
    // report column headers    
    crtbook.setRow(rowCount++);     
    columnCount = 0;
    crtbook.setStringCell(columnCount++, "User");
    if(sAction.equals("By Vendor")){ crtbook.setStringCell(columnCount++, "Vendor");} 
    crtbook.setRowHdrCell(0, "row_hdr 1");
    crtbook.setRowHdrCell(columnCount++, "Div");
    crtbook.setRowHdrCell(columnCount++, "Dpt");
    crtbook.setRowHdrCell(columnCount++, "Parent");
    crtbook.setRowHdrCell(columnCount++, "Description");
    crtbook.setRowHdrCell(columnCount++, "Number \n Of \n Children");
    crtbook.setRowHdrCell(columnCount++, "Extended \n Retail");
    crtbook.setRowHdrCell(columnCount++, "Download \n Date");
    
    short [] shArrColor = new short[]{22,26,27,29,31,42,43};
    String svUser = "";    
    int iColor = 0;
    short shColor = shArrColor[iColor];
    
	while(runsql.readNextRecord())
	{		
		crtbook.setRow(rowCount++); 
		columnCount = 0;
		
		String desc = runsql.getData("ides");
		desc = desc.replaceAll("'", "`");
		
		// set user id cell color
		String sUserId = runsql.getData("wduid");
		if(!sUserId.equals(svUser))
		{
			svUser = sUserId;
			shColor = shArrColor[iColor];
			iColor++;
			if(iColor >= shArrColor.length){ iColor=0; }
		}
		
		crtbook.setStringCell(columnCount++, sUserId, false, shColor, false);
		if(sAction.equals("By Vendor")) { crtbook.setStringCell(columnCount++, runsql.getData("wven")); }
		crtbook.setStringCell(columnCount++, runsql.getData("idiv"));
		crtbook.setStringCell(columnCount++, runsql.getData("idpt"));
		
		String sParent = runsql.getData("wcls") + runsql.getData("wven") + runsql.getData("wsty");		
		crtbook.setStringCell(columnCount++, sParent);
		
		crtbook.setStringCell(columnCount++, desc);
		crtbook.setStringCell(columnCount++, runsql.getData("count"));
		crtbook.setStringCell(columnCount++, runsql.getData("ret"));
		crtbook.setStringCell(columnCount++, runsql.getData("WLTDD"));
	}
	
	crtbook.postBook();
	String sGenFilePath = crtbook.getFilePath();
	String sGenFileName = crtbook.getFileName(); 
	
	response.sendRedirect("tempfile/" + sGenFileName);
	
	} 
	catch (Exception e) { e.printStackTrace(); }   
}	
%>







