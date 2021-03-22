<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.* "%>
<%
   

	String sStmt = "Select fld1"
			  + " from vrlib.MoTest"			  		      
		     ;
			RunSQLStmt runsql = new RunSQLStmt();
			runsql.setPrepStmt(sStmt);
			ResultSet rs = runsql.runQuery();

			String sData = "";
			
			while(runsql.readNextRecord())
		 		{
				sData += "<br>" + runsql.getData("fld1");
			}
			//rs.close();
			runsql.disconnect();
%>
sData  = <%=sData %>
<SCRIPT>	

</SCRIPT>
 