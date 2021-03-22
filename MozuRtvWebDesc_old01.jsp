<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.sql.*,java.text.*, java.util.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");   
   String sType = request.getParameter("Type");
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  	
	String sStmt = "select idsku"
     + " from rci.MoItDesc"
     + " where exists(select 1 from rci.moitweb" 
        + " where exists(select 1 from iptsfil.ipithdr" 
          + " where icls=wcls and wven=iven and wsty=isty and wclr=iclr and wsiz=isiz"
            + " and icls=" + sCls + " and iven=" + sVen + " and isty=" + sSty 
            + " and isku=idsku))"
     + " and idtype='" + sType + "'"
     + " fetch first 1 row only "
	;
	
	RunSQLStmt sql_Sku = new RunSQLStmt();
	sql_Sku.setPrepStmt(sStmt);
	ResultSet rs_Sku = sql_Sku.runQuery();
	String sSku = null;
	if(sql_Sku.readNextRecord())
	{
	   sSku = sql_Sku.getData("idsku").trim();
	}
	sql_Sku.disconnect();
	
	
	sStmt = "select replace(idline, x'0D25', '<br/>' ) as idline "
  	  + " from rci.MoItDesc"
	  + " where idsku=" + sSku
	    + " and idtype='" + sType + "'"
	  + " order by idseq"
	;
	//System.out.println(sStmt);
	RunSQLStmt sql_Desc = new RunSQLStmt();
	sql_Desc.setPrepStmt(sStmt);
	ResultSet rs_Desc = sql_Desc.runQuery();
	Vector<String> vLine = new Vector<String>();
	while(sql_Desc.readNextRecord())
	{
		String s = sql_Desc.getData("idline").toString().replace("\"", "\\\"");		
		vLine.add(s);
	}
	sql_Desc.disconnect();
	
	String sLineJsa = "";
	String [] sLine = new String[]{};
	if(vLine.size() > 0)
	{ 
		sLine = vLine.toArray(new String[]{});		
	}
%>

<SCRIPT>	
   var line = new Array();   
   <%for(int i=0; i < sLine.length; i++){%>
       line[line.length] = "<%=sLine[i]%>";       
   <%}%>   
   parent.showWebDesc(line);
   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

