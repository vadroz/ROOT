<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%
	String sPoNum = request.getParameter("PO");
   
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=POUplDocList.jsp&APPL=ALL");
   }
   else
   {
	
	String sLeadZero = "0000000000";
	String sPoZero = "";
	int ilen = sPoNum.length();
	if(ilen < 10)
	{  
		sPoZero = sLeadZero.substring(0, 10 - ilen) + sPoNum;
	}
	
    String sStmt = "Select digits(PFSEQ), PFEXT, char(PfRcvDt, usa), pfEmp, PfNCtn, PfNItm, PfCmmt, ename"
    	+ " from RCI.PODOCL inner join rci.rciemp on erci=pfemp"
        + " where PfPoNum='" + sPoZero + "'" 		
        + " order by PfSeq";    
    RunSQLStmt runsql = new RunSQLStmt();
                
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	
	Vector<String> vDocSeq = new Vector<String>();
	Vector<String> vDocExt = new Vector<String>();	
	Vector<String> vRcvDt = new Vector<String>();
	Vector<String> vEmp = new Vector<String>();
	Vector<String> vEmpNm = new Vector<String>();
	Vector<String> vNumCtn = new Vector<String>();
	Vector<String> vNumItm = new Vector<String>();
	Vector<String> vCommt = new Vector<String>();
	while(rs.next())
	{
		vDocSeq.add(rs.getString(1));
		vDocExt.add(rs.getString(2));
		vRcvDt.add(rs.getString(3));
		vEmp.add(rs.getString(4));
		vNumCtn.add(rs.getString(5));
		vNumItm.add(rs.getString(6));
		vCommt.add(rs.getString(7));
		vEmpNm.add(rs.getString(8));
	}
	rs.close();
	runsql.disconnect();
%>

<script name="javascript">
var seq = new Array();  
<%for(int i=0; i < vDocSeq.size(); i++){%>seq[seq.length]="<%=vDocSeq.get(i)%>";<%}%>

var ext = new Array();
<%for(int i=0; i < vDocExt.size(); i++){%>ext[ext.length]="<%=vDocExt.get(i)%>";<%}%>

var rcvdt = new Array();
<%for(int i=0; i < vRcvDt.size(); i++){%>rcvdt[rcvdt.length]="<%=vRcvDt.get(i)%>";<%}%>

var emp = new Array();
<%for(int i=0; i < vEmp.size(); i++){%>emp[emp.length]="<%=vEmp.get(i)%> - <%=vEmpNm.get(i)%>";<%}%>

var ctn = new Array();
<%for(int i=0; i < vNumCtn.size(); i++){%>ctn[ctn.length]="<%=vNumCtn.get(i)%>";<%}%>

var itm = new Array();
<%for(int i=0; i < vNumItm.size(); i++){%>itm[itm.length]="<%=vNumItm.get(i)%>";<%}%>

var commt = new Array();
<%for(int i=0; i < vCommt.size(); i++){%>commt[commt.length]="<%=vCommt.get(i)%>";<%}%>

parent.showDoc("<%=sPoNum%>", seq, ext, rcvdt, emp, ctn, itm, commt);
</script>

<%}%>




