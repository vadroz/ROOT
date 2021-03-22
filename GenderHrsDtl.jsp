<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("Str");
   String sWeek = request.getParameter("Week");
   String sGend = request.getParameter("Gend");

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   SimpleDateFormat smpDtIso = new SimpleDateFormat("yyyyMMdd");
   SimpleDateFormat smpDtMdy = new SimpleDateFormat("MM/dd/yyyy");
   SimpleDateFormat smpTmIso = new SimpleDateFormat("HH:mm:ss");
   SimpleDateFormat smpTmUsa = new SimpleDateFormat("hh:mm a");
   
   java.util.Date dWkend = smpDtMdy.parse(sWeek);
   java.util.Date dWkbeg = new java.util.Date(); 
   dWkbeg.setTime(dWkend.getTime() - (long) 6* 1000*60*60*24 );
   
   String sWkbeg = smpDtIso.format(dWkbeg);
   String sWkend = smpDtIso.format(dWkend);
   

   String sStmt = "";
   sStmt = "select erci, ename, esepr, ehdat, etdat"                                                       
	+ ", case when ehdat >= " + sWkbeg +  " and ehdat <= " + sWkend +  " then 3"                 
	+ "  when etdat >= " + sWkbeg +  " and etdat <= " + sWkend +  " then 2"                 
	+ "  when ehdat <= " + sWkbeg +  " and (etdat > " + sWkend +  " or etdat = 0) then 1"  
	+ "  else 4"                                                      
	+ "	 end as type"                                            
	+ "	from rci.RciEmp"                                                       
	+ "	where estore = " + sStr                                               
	+ " and ehors='H' and escom in ('S','R')"                         
	+ " and egend= '" + sGend + "'"
	+ " and ehdat <=" + sWkend 
	+ " and (etdat >= " + sWkbeg + "  or etdat = 0)"
	+ " order by ename"  
	;

   //System.out.println("\n" + sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();
   int j=0;

   String sEmp = "";
   String sEmpNm = "";
   String sType = "";
   String sSepr = "";
   String sHirDt = "";
   String sTrmDt = "";
   String sComa = "";

   while(runsql.readNextRecord())
   {
      sEmp += sComa + "\"" + runsql.getData("erci").trim() + "\"";
      sEmpNm += sComa + "\"" + runsql.getData("ename").trim() + "\"";
      sType += sComa + "\"" + runsql.getData("type").trim() + "\"";
      sSepr += sComa + "\"" + runsql.getData("eSepr").trim() + "\"";
      sHirDt += sComa + "\"" + runsql.getData("ehdat").trim().replaceAll("\"", "'") + "\"";
      sTrmDt += sComa + "\"" + runsql.getData("etdat").trim().replaceAll("\"", "'") + "\"";
      sComa= ",";
   }
   runsql.disconnect();
   runsql = null;
%>
<SCRIPT language="JavaScript1.2">

var Str = "<%=sStr%>";
var Week = "<%=sWeek%>";
var Gend = "<%=sGend%>";
var Emp = [<%=sEmp%>];
var EmpNm = [<%=sEmpNm%>];
var Type = [<%=sType%>];
var Sepr = [<%=sSepr%>];
var HirDt = [<%=sHirDt%>];
var TrmDt = [<%=sTrmDt%>];

parent.showEmpList(Str, Week, Gend, Emp, EmpNm, Type, Sepr, HirDt, TrmDt);


</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

