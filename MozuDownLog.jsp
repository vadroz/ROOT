<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
String sUser = request.getParameter("User"); 

		String sStmt = "Select IDRECTS, char(time(IDRECTS)) as time, IDSITE, IDPRNT"
		  + ",digits(IDCLS) as idcls,digits(IDVEN) as idven, digits(IDSTY) as idsty"
		  + ",digits(IDCLR) as idclr,digits(IDSIZ) as idsiz"
		  + ",IDPROC,IDERFLG,IDERR,IDUSER"
		  + " from RCI.MOITDLOG"
		  + " where iduser='" + sUser + "'"
		  + " and date(IDRECTS) = current date"
		  + " order by IDRECTS desc,IDCLS,IDVEN,IDSTY,IDCLR,IDSIZ,IDSITE,IDPRNT"
		  + " fetch first 50 rows only"
		 ;
		//System.out.println(sStmt);
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);  
		ResultSet rs = runsql.runQuery();

		Vector<String> vParent = new Vector<String>();
		Vector<String> vTime = new Vector<String>();
		Vector<String> vCls = new Vector<String>();
		Vector<String> vVen = new Vector<String>();
		Vector<String> vSty = new Vector<String>();
		Vector<String> vClr = new Vector<String>();
		Vector<String> vSiz = new Vector<String>();
		Vector<String> vUser = new Vector<String>();
		Vector<String> vRecTs = new Vector<String>();
		Vector<String> vErrFlg = new Vector<String>();
		Vector<String> vError = new Vector<String>();
		
		while(runsql.readNextRecord())
		{
		    vParent.add(runsql.getData("idprnt").trim());
		    vTime.add(runsql.getData("time").trim());
		    vCls.add(runsql.getData("idCls").trim());
		    vVen.add(runsql.getData("idVen").trim());
		    vSty.add(runsql.getData("idSty").trim());
		    vClr.add(runsql.getData("idClr").trim());
		    vSiz.add(runsql.getData("idSiz").trim());
		    vUser.add(runsql.getData("iduser").trim());
		    vRecTs.add(runsql.getData("idrects").trim());
		    vErrFlg.add(runsql.getData("idErFlg").trim());
		    vError.add(runsql.getData("idErr").trim());
		}
		rs.close();
		runsql.disconnect();
%>
<%for(int i=0; i < vParent.size(); i++){%>
<Time><%=vTime.get(i)%></Time><Item><%=vCls.get(i)%><%=vVen.get(i)%><%=vSty.get(i)%><%if(vParent.get(i).equals("2")){%>-<%=vClr.get(i)%><%=vSiz.get(i)%><%}%></Item><ErrFlg><%=vErrFlg.get(i)%></ErrFlg><Error><%=vError.get(i)%></Error><br/>
<%}%>












