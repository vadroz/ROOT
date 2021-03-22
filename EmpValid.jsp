<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
, rciutility.CallAs400SrvPgmSup"%>
<%
   	String sEmp = request.getParameter("emp");
	String sPwd = request.getParameter("pwd");
	
	if(sPwd==null){ sPwd = ""; }

   String sStmt = null;   
   sStmt = "select erci, ename, estat, ehors"
		+ ", case when cddpt is not null then 'Y'"
		+ " when estat in ('032','020') then 'Y'"
        + " else 'N' end as goodDpt"
		+ ", pustr"
		+ " from rci.pruser"
		+ " left join rci.rciemp on erci=puauth"
		+ " left join rci.INCCODPT on cddpt = dec(estat)"
		+ " where puuser='" + sEmp + "'"
		+ " and pupswd='" + sPwd + "'";
	
   System.out.println("\nEmpValid.jsp\n" + sStmt); 
	
   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bUpcFound = false;
   String sEmpNum = " ";
   String sEmpNm = " ";
   String sDept = " ";
   String sHorS = " ";
   String sGoodDpt= " ";
   String sUsrStr = " ";
   
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sEmpNum = sql_Item.getData("erci");
      if(sEmpNum == null){ sEmpNum = " "; }
      sEmpNm = sql_Item.getData("ename");
      if(sEmpNm == null){ sEmpNm = " "; }
      sDept = sql_Item.getData("estat");
      if(sDept == null){ sDept = " "; }
      sHorS = sql_Item.getData("ehors");
      if(sHorS == null){ sHorS = " "; }
      sGoodDpt = sql_Item.getData("goodDpt");
      if(sGoodDpt == null){ sGoodDpt = " "; }      
      sUsrStr = sql_Item.getData("pustr");
      if(sUsrStr == null){ sUsrStr = " "; }
   }
   
    
   CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   StringBuffer sbParam = new StringBuffer();
   if(bUpcFound){sbParam.append(srvpgm.setParamString("true", 5));}
   else{sbParam.append(srvpgm.setParamString("false", 5));}
   sbParam.append(srvpgm.setParamString(sEmpNum, 4));
   sbParam.append(srvpgm.setParamString(sEmpNm, 19));
   sbParam.append(srvpgm.setParamString(sDept, 3));
   sbParam.append(srvpgm.setParamString(sHorS, 1));
   sbParam.append(srvpgm.setParamString(sGoodDpt, 1));
   sbParam.append(srvpgm.setParamString(sUsrStr, 5));
   
   sql_Item.disconnect();  
   System.out.println(sbParam.toString());
%><%=sbParam.toString()%>|












