<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sItem = request.getParameter("Item");
   String sCtl = request.getParameter("Ctl");
   String sType = request.getParameter("Type");
   String sReason = request.getParameter("Reason");
   
   String sStmt = null;

   boolean bUpcFound = false;
   
   String sName = "";
   String sAddr = "";
   String sCity = "";
   String sState = "";
   String sZip = "";
   String sPhone = "";
   
   String sDate = "";
   String sTime = "";
   String sPlace = "";
   String sArea = "";
   String sFoundBy = "";
   String sMgr = "";
   String sTftCommt = "";
   String [] sItmDfc = null;
   
   //System.out.println("sType=" + sType);
   
   if(sType.equals("AddInfo"))
   {
	   sStmt = "select MACTLID,MAITEMID,MANAME,MAADDR,MACITY,MASTATE,MAZIP,MAPHONE "
		+ " from Rci.MKITMADD"
		+ " where MACTLID=" + sCtl + " and MAITEMID = " + sItem;
   	   //System.out.println(sStmt);

   	   RunSQLStmt sql_Item = new RunSQLStmt();
       sql_Item.setPrepStmt(sStmt);
       ResultSet rs_Item = sql_Item.runQuery();
   
       if(sql_Item.readNextRecord())
       {
    	   bUpcFound = true;
      	   sName = sql_Item.getData("MANAME").trim();
           sAddr = sql_Item.getData("MAADDR").trim();
           sCity = sql_Item.getData("MACITY").trim();
           sState = sql_Item.getData("MASTATE").trim();       
           sZip = sql_Item.getData("MAZIP").trim();
           sPhone = sql_Item.getData("MAPHONE").trim();
       }
       sql_Item.disconnect();
   }   
   else if(sType.equals("Crime"))
   {
	   sStmt = "select char(MTDATE, usa) as Mtdate,MTTIME, MTPLACE, MTFNDBY, MTMNGR, MTCOMMT, MtArea"
		+ " from Rci.MKITMThf"
	 	+ " where MtCTLID=" + sCtl + " and MtITEMID = " + sItem;
	   //System.out.println(sStmt);

	   RunSQLStmt sql_Item = new RunSQLStmt();
	   sql_Item.setPrepStmt(sStmt);
	   ResultSet rs_Item = sql_Item.runQuery();
		   
	   if(sql_Item.readNextRecord())
	   {
	   	   bUpcFound = true;
	   	   sDate = sql_Item.getData("MtDate").trim();
	   	   sTime = sql_Item.getData("MtTime").trim();
	   	   sPlace = sql_Item.getData("MtPlace").trim();
	   	   sArea = sql_Item.getData("MtArea").trim();
	   	   sFoundBy = sql_Item.getData("MtFndBy").trim();
	   	   sMgr = sql_Item.getData("MtMngr").trim();
	   	   sTftCommt = sql_Item.getData("MtCommt").trim();
	   }
	   sql_Item.disconnect();
   }
   //previuosly enter info on same reason code 
   else if(sType.equals("PrevInfo"))
   {
	   sStmt = "select MACTLID,MAITEMID,MANAME,MAADDR,MACITY,MASTATE,MAZIP,MAPHONE "
		+ " from Rci.MKITMADD"
		+ " where MACTLID=" + sCtl 
		+ " and exists(select 1 from rci.MkItem where MICTLID=MACTLID " 
		+ " and MIREAS = '" + sReason + "' and MIITEMID=MAITEMID)"
		+ " order by MAITEMID desc"
		;
   	   //System.out.println(sStmt);

   	   RunSQLStmt sql_Item = new RunSQLStmt();
       sql_Item.setPrepStmt(sStmt);
       ResultSet rs_Item = sql_Item.runQuery();
   
       if(sql_Item.readNextRecord())
       {
    	   bUpcFound = true;
      	   sName = sql_Item.getData("MANAME").trim();
           sAddr = sql_Item.getData("MAADDR").trim();
           sCity = sql_Item.getData("MACITY").trim();
           sState = sql_Item.getData("MASTATE").trim();       
           sZip = sql_Item.getData("MAZIP").trim();
           sPhone = sql_Item.getData("MAPHONE").trim();
       }
       sql_Item.disconnect();
   }
   else if(sType.equals("Defect"))
   {
	   sStmt = "select MGDEFECT"
		+ " from Rci.MKITMDFC"
	 	+ " where MgCTLID=" + sCtl + " and MgITEMID = " + sItem;
	   //System.out.println(sStmt);

	   RunSQLStmt sql_Item = new RunSQLStmt();
	   sql_Item.setPrepStmt(sStmt);
	   ResultSet rs_Item = sql_Item.runQuery();
	   
	   Vector<String> vItmDfc = new Vector<String>(); 
		   
	   while(sql_Item.readNextRecord())
	   {
		   vItmDfc.add(sql_Item.getData("MGDEFECT").trim());
	   }
	   
	   sItmDfc = (String [])vItmDfc.toArray(new String[vItmDfc.size()]);
	   
	   sql_Item.disconnect();
   }
%>
<%if(!sType.equals("Defect")){%>
<Exists><%=bUpcFound%></Exists>
<Name><%=sName%></Name><Addr><%=sAddr%></Addr><City><%=sCity%></City><State><%=sState%></State><Zip><%=sZip%></Zip><Phone><%=sPhone%></Phone>
<Date><%=sDate%></Date><Time><%=sTime%></Time><Place><%=sPlace%></Place><Area><%=sArea%></Area><FoundBy><%=sFoundBy%></FoundBy><Mgr><%=sMgr%></Mgr><TftCommt><%=sTftCommt%></TftCommt>
<%}
else {%>
<%for(int i=0; i < sItmDfc.length; i++){%><defect><%=sItmDfc[i]%></defect><%}%>
<%}%>











