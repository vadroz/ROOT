<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
   	response.setContentType("application/vnd.ms-excel");
   
	String sFrom = request.getParameter("FromDt");   
	String sTo = request.getParameter("ToDt");
    String sUser = session.getAttribute("USER").toString();
    
    
    SimpleDateFormat sdfToDate = new SimpleDateFormat("MM/dd/yyyy");
    SimpleDateFormat sdfToStr = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date dFrom = sdfToDate.parse(sFrom);
    sFrom = sdfToStr.format(dFrom);
    java.util.Date dTo = sdfToDate.parse(sTo);
    sTo = sdfToStr.format(dTo);


    String sStmt = "select   opord, PhRecDt, sreg, phstr"
     + ",(select case when substr(pmlog,1,3) = 'OTH' then  substr(pmlog,1,5)" 
     + " else  substr(pmlog,1,3) end" 
     + " from rci.MoSpLoj where opid = pmpickid" 
     + " and pmtype = 'ErrCode' and pmsn=phsn and pmstr=phstr"
     + " order by pmrecdt desc, pmrectm desc"
     + " fetch first 1 row only) as errcode"            
     + ",(select  case when substr(pmlog,1,3) = 'OTH' then  substr(pmlog, 7)" 
     + " else  substr(pmlog, 5) end" 
     + " from rci.MoSpLoj where opid = pmpickid" 
     + " and pmtype = 'ErrCode' and pmsn=phsn and pmstr=phstr"
     + " order by pmrecdt desc, pmrectm desc"
     + " fetch first 1 row only) as errnote"
     + " from  rci.moorpas" 
     + " inner join Table(select phpickid, phstr, phsn, phsts, max(PhRecDt ) as PhRecDt from rci.MoStsHs" 
     + " where PhRecDt >= '" + sFrom + "' and PhRecDt <= '" + sTo + "' and phsts= 'Error'"
     + " and phpickid=opid group by  phpickid, phstr, phsn, phsts )" 
     + " as stshs on 1=1" 
     + " inner join iptsfil.IpItHdr on opsku=isku" 
     + " inner join iptsfil.IpStore t on phstr=sstr" 
     + " where opsite='11961'"
     + " order by PhRecDt, opord,  sreg, phstr"
     ;
   	//System.out.println(sStmt);
   	
    out.println("Date Of Error \tDistrict \tStore \tError \tOrder \tNotes");

    RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();	
	
	while(runsql.readNextRecord())
	{			
		String sDate = runsql.getData("PhRecDt");
		String sReg = runsql.getData("sreg");
		String sStr = runsql.getData("phstr");
		String sOrd = runsql.getData("opord");
		String sErrCode = runsql.getData("errcode");
		String sNote = runsql.getData("errnote");
		out.println( sDate + "\t" + sReg  + "\t" + sStr + "\t" + sErrCode + "\t" + sOrd + "\t" + sNote);
	}
%>


