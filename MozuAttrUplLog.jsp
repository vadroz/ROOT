<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
String sUser = request.getParameter("User"); 

		String sStmt = "Select ALRECDT, char(time(ALRECDT)) as time, ALSITE"
		  + ", AlAction, AlParam, AlErrFlg, AlError"		
		  + " from RCI.MOATRLOG"
		  + " where date(ALRECDT) = current date"
		  + " order by ALRECDT desc"
		  + " fetch first 50 rows only"  
		 ;
		//System.out.println(sStmt);
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);  
		ResultSet rs = runsql.runQuery();

		Vector<String> vAction = new Vector<String>();
		Vector<String> vParam = new Vector<String>();
		Vector<String> vTime = new Vector<String>();
		Vector<String> vRecTs = new Vector<String>();
		Vector<String> vErrFlg = new Vector<String>();
		Vector<String> vError = new Vector<String>();
		
		while(runsql.readNextRecord())
		{
			vAction.add(runsql.getData("AlAction").trim());
		    vParam.add(runsql.getData("AlParam").trim());
		    vTime.add(runsql.getData("time").trim());
		    vRecTs.add(runsql.getData("alrecdt").trim());
		    vErrFlg.add(runsql.getData("alErrFlg").trim());
		    vError.add(runsql.getData("alError").trim());		    
		}
		rs.close();
		runsql.disconnect();
%>
<%for(int i=0; i < vAction.size(); i++){%>
<Time><%=vTime.get(i)%></Time><Action><%=vAction.get(i)%></Action><Param><%=vParam.get(i)%></Param><ErrFlg><%=vErrFlg.get(i)%></ErrFlg><Error><%=vError.get(i)%></Error><br/>
<%}%>












