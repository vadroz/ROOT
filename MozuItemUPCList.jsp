<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
, org.json.*"%>
<%@ page contentType="application/json" %>
<%
   String sCls = request.getParameter("cls");
   String sVen = request.getParameter("ven");
   String sSty = request.getParameter("sty");
   String sClr = request.getParameter("clr");
   String sSiz = request.getParameter("siz");

   String sStmt = null;
   sStmt = "select uupd"
     	+ " from IpTsFil.IPUPCXF a"     	
     	+ " where ucls=" + sCls + " and uven=" + sVen + " and usty=" + sSty
     	+ " and uclr=" + sClr + " and usiz=" + sSiz
     	+ " order by uupd desc"
     	;   
   //System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bUpcFound = false;
   
   Vector<String> vUpc = new Vector<String>();   
   while(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      vUpc.add(sql_Item.getData("uupd"));      
   }
   sql_Item.disconnect();
   
   String [] sArrUpc = vUpc.toArray(new String[]{});   

   JSONObject json = new JSONObject();
   JSONArray  joUPCs = new JSONArray();
   JSONObject joUPC;
   for(int i=0; i < sArrUpc.length; i++)
   {
	   joUPC = new JSONObject();
	   joUPC.put("upc", sArrUpc[i]);
	   joUPCs.put(joUPC);
   }
   json.put("upc_list", joUPCs);   
%><%=json.toString()%>













