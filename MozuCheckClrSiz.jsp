<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");  
   
   String sStmt = null;

   boolean bClrSiz = false;
    
   sStmt = "select wclrnm, wsiznm"
	 + " from Rci.MoItWeb"
	 + " inner join iptsfil.IpItHdr on icls=wcls and iven=wven and isty=wsty and iclr=wclr and isiz=wsiz"
	 + " where wcls=" + sCls + " and wven=" + sVen + " and wsty=" + sSty
	 + " and iAtt01 = '2'"
	 ;
   System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   
   while(sql_Item.readNextRecord())
   {  	   
   	   String sClrNm = sql_Item.getData("wclrnm").trim();
   	   String sSizNm = sql_Item.getData("wsiznm").trim();
       System.out.println("Color=" + sClrNm + " Size= " +  sSizNm);
   	   if(sClrNm.equals("") && sSizNm.equals("")
   		  || sClrNm.equals("8259") && sSizNm.equals("8190"))
   	   {
   		   bClrSiz = true; 
   		   break;
   	   }
   }
   sql_Item.disconnect();
%><Error><%=bClrSiz%></Error>
 










