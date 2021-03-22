<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	Vector<String> vLine = new Vector<String>();
	
	String sLine = "";
	
	String sPrepStmt = "select MBLINE"   	 	
   	 	+ " from rci.INMMSGB"
   	 	+ " where MBHIDE <> 'Y'"
   	 	+ " order by MBID";
   	
   	//System.out.println(sPrepStmt);
   	
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sPrepStmt);		   
   	runsql.runQuery();
   		
   	while(runsql.readNextRecord())
   	{
   		vLine.add(runsql.getData("MBLINE"));
   	}
    
   	runsql.disconnect();
   	runsql = null;
	
%>
<html> 
<table border=1 id="tbConv" style="font-size:12px;border-spacing: 0; border-collapse: collapse; width:100%">    
	<tr>
  		<th style="background:#e3d097; color: black; padding-top:0px; border:darkblue 1px solid;
                 vertical-align:top; text-align:left; font-size:16px; font-weight:bold }" colspan=4>
           <%String sbr = "";%>      
           <%for(int i=0; i < vLine.size(); i++){%>
           		<%=sbr + vLine.get(i)%><%sbr="<br>";%>   
           <%}%>      
        </th>
	</tr>
	
</table>        
  
<SCRIPT>
var html = document.all.tbConv.outerHTML;
parent.dvCompMsg.innerHTML=html;
</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>