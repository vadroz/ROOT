<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.* "%>
<%
String sSite = request.getParameter("Site");   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  		
		String sStmt = "select AtTxCat" 
	  	 	 + " from rci.MOTxCat"  		   	 
	  	     + " order by AtTxCat"; 
			  
		     ;
			RunSQLStmt runsql = new RunSQLStmt();
			runsql.setPrepStmt(sStmt);
			ResultSet rs = runsql.runQuery();

			Vector<String> vTaxCat = new Vector<String>();
			
			while(runsql.readNextRecord())
			{
				vTaxCat.add(runsql.getData("AtTxCat").trim()); 
			}
			rs.close();
			runsql.disconnect();
%>
	
<SCRIPT>	
var taxcat = new Array(); 
<%for(int i=0; i < vTaxCat.size(); i++){%>taxcat[taxcat.length] = "<%=vTaxCat.get(i)%>";<%}%> 
   
   parent.showTaxCat(taxcat);
   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

