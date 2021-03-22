<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("Str");
   String sArea = request.getParameter("Area");
   String sPiYearMo = request.getParameter("PICal");

   
   String sStmt = "select WIMID, LUSER, LDATE, LTIME"
		+ ",(select b.liarea from rci.PiWiLog b where b.wimid = a.wimid " 
        + " and (a.listor <> b.listor or a.liarea <> b.liarea)" 
		+ " and exists(select 1 from Rci.FsyPer where pime < b.ldate" 
        + " and pyr# = " + sPiYearMo.substring(0, 4) 
        + " and pmo# =" + sPiYearMo.substring(4) + ")"                  
	    + " fetch first 1 row only) as othArea"
		+ " from RCI.PIWILOG a"
		+ " where listor=" + sStr
		+ " and liarea=" + sArea
		+ " order by rrn(a)"
	;
   
   System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   
   Vector<String> vSn = new Vector<String>();
   Vector<String> vUser = new Vector<String>();
   Vector<String> vDate = new Vector<String>();
   Vector<String> vTime = new Vector<String>();
   Vector<String> vOthArea = new Vector<String>();
   
   while(sql_Item.readNextRecord())
   {
      vSn.add(sql_Item.getData("wimid").trim());
      vUser.add(sql_Item.getData("luser").trim());
      vDate.add(sql_Item.getData("ldate").trim());
      vTime.add(sql_Item.getData("ltime").trim());
      String otha = sql_Item.getData("othArea");
      if(otha == null){otha = "&nbsp;";}
      vOthArea.add(otha.trim());
      
   }   
   sql_Item.disconnect();
   
   String sSn = "";
   String sUser = "";
   String sDate = "";
   String sTime = "";
   String sOthArea = "";
   String sComa = "";
   
   for(int i=0; i < vSn.size(); i++)
   {
	   sSn += sComa + "\"" + vSn.get(i) + "\"";
	   sUser += sComa + "\"" + vUser.get(i) + "\"";
	   sDate += sComa + "\"" + vDate.get(i) + "\"";
	   sTime += sComa + "\"" + vTime.get(i) + "\"";
	   sOthArea += sComa + "\"" + vOthArea.get(i) + "\"";
	   sComa = ","; 
   }
%>
<script>
var str = "<%=sStr%>";
var area = "<%=sArea%>";
var sn = [<%=sSn%>];
var user = [<%=sUser%>];
var date = [<%=sDate%>];
var time = [<%=sTime%>];
var otharea = [<%=sOthArea%>]

parent.showLog(str, area, sn, user, date, time, otharea);

</script>













