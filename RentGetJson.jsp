<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
, rciutility.CallAs400SrvPgmSup"%>

<%
   //response.setContentType("application/javascript");

   String sContId = request.getParameter("ContId");
   
   String sStmt = "select CTRECDT, CTSTR ,CTCONT,CTPICDt,CTRTNDt,CTCUST,CSFNAME, CSLNAME" 
   	+ ", (select log from rci.ReOnlog where" 
    + "(" 
   	+ "ctstr = 15 and log like ('%\"store\":\"15\"%')" 
    + " or ctstr = 16 and log like ('%\"store\":\"16\"%')"
    + " or ctstr = 17 and log like ('%\"store\":\"17\"%')" 
    + " or ctstr = 28 and log like ('%\"store\":\"28\"%')"
    + " or ctstr = 30 and log like ('%\"store\":\"30\"%')"
    + " or ctstr = 35 and log like ('%\"store\":\"35\"%')"
    + " or ctstr = 50 and log like ('%\"store\":\"50\"%')"		
   	+ " or ctstr = 64 and log like ('%\"store\":\"64\"%')"
   	+ " or ctstr = 66 and log like ('%\"store\":\"66\"%')"
   	+ " or ctstr = 68 and log like ('%\"store\":\"68\"%')"
   	+ " or ctstr = 77 and log like ('%\"store\":\"77\"%')"
    + " or ctstr = 86 and log like ('%\"store\":\"86\"%')"
    + " or ctstr = 87 and log like ('%\"store\":\"87\"%')"
   	+ " or ctstr = 88 and log like ('%\"store\":\"88\"%')" 
   	+ ")" 
    + " and upper(log) like ('%' concat upper(trim(CSLNAME)) concat '%')" 
   	+ " and upper(log) like ('%' concat upper(trim(CSFNAME)) concat '%')" 
    + " and  date(rec_ts) = ctrecdt" 
   	+ " order by rec_ts desc" 
    + " fetch first 1 row only) as log" 
   	+ " from  rci.ReContH" 
    + " inner join rci.ReCustH on ctcust=cscust" 
   	+ " where ctcont=" + sContId
   ;    
  
   System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   ResultSetMetaData rsmd = rs.getMetaData();

   int j=0;
    
    
   
%>
 
<%  
   String sLog = null;
   if(runsql.readNextRecord())
   {
	   sLog = runsql.getData("log");
   }
   if(sLog == null)
   {
	   sLog = "{\"Result\"  : \"*** Not found ***\"}";
   }
   else
   { 
	   sLog = sLog.trim();
   }
%>

 
<html>
<body>

<h2>Show Contract Entry Parameters</h2>
<div id="dvLog"><%=sLog %></div>

<p id="demo"></p>



</body>
</html>

<script>

var text =  document.getElementById("dvLog").innerHTML
var obj = JSON.parse(text);

var val0 = Object.values(obj);
var key0 = Object.keys(obj)

var demo = document.getElementById("demo");
demo.innerHTML = parse("", key0, val0, 1);

// parse 
function parse(a, key, val, tab) 
{	
	for (var i = 0; i < val.length; i++) 
	{
		if (typeof val[i] === 'object' && val[i] !== null) 
		{
			var obj1 = new Object(val[i]);
			var val1 = Object.values(obj1);
			var key1 = Object.keys(obj1);
			
			a += "<br>"
			for(var j = 0; j < tab; j++){ a += " &nbsp; &nbsp; &nbsp;"}				
			a += key[i] + " ------------- ";
			
			a += parse(a, key1, val1, ++tab);
		}
		
		
		a += "<br>"
		for(var j = 0; j < tab; j++){ a += " &nbsp; &nbsp; &nbsp;"}
		a += key[i] + " = " + val[i];
	}
	return a;
}
</script>



