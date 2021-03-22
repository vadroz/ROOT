<%@ page import="rciutility.ConnToCounterPoint, mozu_com.FdxFflUpd
, java.util.*, java.text.*, java.io.*, java.math.*, java.sql.*"%>
<%
	String sOrd = request.getParameter("ord");
	String sSku = request.getParameter("sku");	
	String sSn = request.getParameter("sn");
	String sStr =  request.getParameter("str");
	String sPackId =  request.getParameter("packid");
	
	String sAction =  request.getParameter("action");
	String sUser =  request.getParameter("user");
	
	boolean bSuccess = true;
	
	System.out.println("Action=" + sAction);
	
	if(sAction.equals("DltFedexDtl"))  
	{
		ConnToCounterPoint connToCP = new ConnToCounterPoint();
    	connToCP.connToDb("FedEx", "192.168.20.77");
    	Connection con = connToCP.getCurrentConn();
      	  
    	Statement stmt = null;
    	ResultSet rs1 = null;
      	              	  
    	
      	    
    	if(!con.isClosed())
    	{
    		String query = "delete from [dbo].[fdx_ord_dtl]"                                    
      	 	+ " where [orderid] = '" + sOrd + "'"
      	 	+ " and [sku] = '" + sSku + "'"       
      	 	+ " and [s/n] = '" + sSn + "'" 
      	 	+ " and [store] = '" + sStr + "'"
      		; 
      		try
      		{
      			stmt = con.createStatement ();
      			stmt.executeQuery(query);
      			rs1 = stmt.getResultSet();
      			rs1.first();
      		
      			bSuccess = true;     		    
      		}
      		catch (SQLException ex) {
         		System.out.println (ex.getMessage());
         		bSuccess = false;
      		}        
    	}
    	else { 
    		System.out.println("Database is closed."); 
    		bSuccess = false;
    	}
	}
    else if(sAction.equals("UpdFdxDtl"))
    {
    	System.out.println("0");
    	FdxFflUpd itmsav = new FdxFflUpd(sOrd, sStr, sSku, sSn
    		, sPackId, sAction, "vrozen");
    	itmsav.disconnect();
    }
%>
<SCRIPT language="JavaScript1.2">
var action = "<%=sAction%>";
var success = <%=bSuccess%>;

if( action == "DltFedexDtl" || action == "UpdFdxDtl" ){ parent.updLine(action, success); }

</SCRIPT>


