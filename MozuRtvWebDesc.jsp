<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.sql.*,java.text.*, java.util.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");   
   String sType = request.getParameter("Type");
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  	
	 
	
	String sStmt = "select replace(idline, x'0D25', '<br/>' ) as idline "
  	  + " from rci.MoPrtDsc"
	  + " where idcls=" + sCls + " and idven=" + sVen + " and idsty=" + sSty
	    + " and idtype='" + sType + "'"
	  + " order by idseq"
	;
	//System.out.println(sStmt);
	RunSQLStmt sql_Desc = new RunSQLStmt();
	sql_Desc.setPrepStmt(sStmt);
	ResultSet rs_Desc = sql_Desc.runQuery();
	Vector<String> vLine = new Vector<String>();
	while(sql_Desc.readNextRecord())
	{
		String s = sql_Desc.getData("idline").toString().replace("\"", "\\\"").trim();		
		vLine.add(s);
	}
	sql_Desc.disconnect();
	
	String sLineJsa = "";
	String [] sLine = new String[]{};
	if(vLine.size() > 0)
	{ 
		sLine = vLine.toArray(new String[]{});		
	}
%>

<SCRIPT>	
   var line = new Array();   
   <%for(int i=0; i < sLine.length; i++){%>
       line[line.length] = "<%=sLine[i]%>";       
   <%}%>   
   parent.showWebDesc(line);
   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

