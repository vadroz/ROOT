<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.* "%>
<%
String sSite = request.getParameter("Site");   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  		
	String sStmt = "Select TPID, TPNAME"
			  + " from RCI.MOTNPRTY"
			  + " where tpsite= '" + sSite + "'"
			  + " order by TPNAME"		      
		     ;
			RunSQLStmt runsql = new RunSQLStmt();
			runsql.setPrepStmt(sStmt);
			ResultSet rs = runsql.runQuery();

			Vector<String> vPrdType = new Vector<String>();
			Vector<String> vPrdTypeId = new Vector<String>();
			
			while(runsql.readNextRecord())
			{
				vPrdType.add(runsql.getData("TPNAME").trim());
				vPrdTypeId.add(runsql.getData("TPID").trim());
			}
			rs.close();
			runsql.disconnect();
%>
	
<SCRIPT>	
var type = new Array();
var id = new Array();   
<%for(int i=0; i < vPrdType.size(); i++){%>type[type.length] = "<%=vPrdType.get(i)%>";<%}%>
<%for(int i=0; i < vPrdTypeId.size(); i++){%>id[id.length] = "<%=vPrdTypeId.get(i)%>";<%}%>
   
   parent.showProdType(type, id);
   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

