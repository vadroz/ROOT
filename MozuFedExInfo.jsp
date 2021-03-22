<%@ page import="java.net.URL,java.sql.*, java.util.*, java.text.*
, rciutility.ConnToCounterPoint, rciutility.CallAs400SrvPgmSup"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
   String sAction = request.getParameter("Action");
   
   String sCompany = request.getParameter("Company");
   String sAddress1 = request.getParameter("Address1");
   String sAddress2 = request.getParameter("Address2");
   String sCity = request.getParameter("City");
   String sState = request.getParameter("State");
   String sZip = request.getParameter("Zip");
   String sPhone = request.getParameter("Phone");
   String sShpMeth = request.getParameter("ShpMeth");
   String [] sSts = request.getParameterValues("Sts");
   String [] sSku = request.getParameterValues("Sku");
   String [] sSrl = request.getParameterValues("Srl");
   String [] sPack = request.getParameterValues("Pack");
   String [] sTrack = request.getParameterValues("Track");
   
   if(sCompany==null){sCompany = " ";}
   if(sAddress1==null){sAddress1 = " ";}
   if(sAddress2==null){sAddress2 = " ";}   
   if(sCity==null){sCity = " ";}
   if(sState==null){sState = " ";}
   if(sZip==null){sZip = " ";}
   if(sPhone==null){sPhone = " ";}
   if(sShpMeth==null){sShpMeth = " ";}
  
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
	Vector vDtl = new Vector();
	String [] sHdr = new String[30];
	int iNumOfCol = 0;
	
	Statement stmt = null;
	ResultSet rs =  null;
	ResultSetMetaData rsmd = null; 
	
	ConnToCounterPoint connToCP = new ConnToCounterPoint();
    connToCP.connToDb("FedEx", "192.168.20.77");
    Connection con = connToCP.getCurrentConn();
    try
    {
    	if(!con.isClosed())
        {
    		if(!sAction.equals("Save"))
    		{    			
    			String sQuery = "select h.orderid,[orderdate],[paymentamount], h.shipfullname" 
    		     + ",h.emailaddress,h.shipcompanyname,h.shipaddress1,h.shipaddress2,h.shipcity" 
    			 + ",h.shipstate,h.shippostalcode,h.shipcountry,h.shipphonenumber,[shipfaxnumber]" 
    		     + ",[customerid],[totalshippingcost],[shippingmethodname],[productcodes],[residential]" 
    			 + ",[billingoption],[packagetype],[shipnotification],[notificationtype]" 
    		     + ",[deliverynotes],[usps],[gl_account],[insurance],[insurance_option]" 
    			 + ",[shippedcomplete],[totalorderweight]"
               
                 + ", case when [Store] is not null then Store else 'NOT FOUND' end as [Store]" 
                 + ", case when [SKU] is not null then [SKU] else 'NOT FOUND' end as [SKU]"
                 + ", case when [S/N] is not null then [S/N] else 'NOT FOUND' end as [S/N]"
                 + ", case when [Status] is not null then [Status] else 'NOT FOUND' end as [Status]"
                 + ", case when [ItemDescription] is not null then [ItemDescription] else 'NOT FOUND' end as [ItemDescription]"
                 + ", case when Manufacturer is not null then Manufacturer else 'NOT FOUND' end as Manufacturer"
                 + ", case when Retail is not null then Retail else 'NOT FOUND' end as Retail"
                 + ", case when PickID is not null then PickID else 'NOT FOUND' end as PickID"
                 + ", case when d.PackID is not null then d.PackID else 'NOT FOUND' end as PackID"
                 + ", case when e.trackingnumber is not null then e.trackingnumber else 'NOT FOUND' end as TrackID"
               
                 + " from [dbo].[fdx_ord_hdr] h " 
                 + " left join [dbo].[fdx_ord_dtl] d on h.orderid=d.orderid" 
                 + " left join [dbo].[fdx_ord_shp] e on d.PackID=e.PackID and d.PackID <> '' and d.packid <> '0'"
                 + " where h.orderid = '" + sOrder + "'"
               ;
    		
    			//System.out.println(sQuery);
    		
    			stmt = con.createStatement ();
    	    	stmt.executeQuery(sQuery);
    	    	rs = stmt.getResultSet();
    	    	rsmd = rs.getMetaData();
    	    	iNumOfCol = rsmd.getColumnCount();
    	    	//System.out.println(iNumOfCol);
    	    
    	    	boolean bFirst = true;
    	    	while(rs.next())
    	    	{
    	    		// save fedex record header
    	    		if(bFirst)
    	    		{
    	    			for(int i=0; i < 30; i++)    	    
    	    			{
	    	    	   		sHdr[i] = rs.getString(i+1);
    		    		}	
    		    		bFirst = false;
    	    		}
    	    	
    	    		String [] sData = new String[10];
    	    	
    	    		for(int i=30, j=0; i < 30 + 10; i++, j++)
    	    		{
    	    	   		sData[j] = rs.getString(i+1); 	
    	    		}  
    	    		vDtl.add(sData);
    	    	}
    	    	rs.close();
    	    	stmt.close();
    		}
    		else
    		{
    			String sQuery = "update [dbo].[fdx_ord_hdr] set" 
    		      + " [shipcompanyname] = '" + sCompany + "'" 
    			  + ",[shipaddress1] = '" + sAddress1 + "'"
    			  + ",[shipaddress2] = '" + sAddress2 + "'"
    		      + ",[shipcity] = '" + sCity + "'"    		      
    	    	  + ",[shipstate] = '" + sState + "'"
    	    	  + ",[shippostalcode] = '" + sZip + "'" 
    	    	  + ",[shipphonenumber] = '" + sPhone + "'"
    	    	  + ",[shippingmethodname] = '" + sShpMeth + "'"    	    	  
    	    	  + " where [orderid] = " + sOrder
    	          ;
    			//System.out.println(sQuery);
    			
    			stmt = con.createStatement ();
    	    	stmt.executeUpdate(sQuery);
    	    	stmt.close();
    	    	
    	    	for(int i=0; i < sSts.length; i++)
    	        {
    	    		sQuery = "update [dbo].[fdx_ord_dtl] set";
    	    		
    	        	if(sSts[i].equals("None")){ sSts[i] = " "; }    	        	
    	        	sQuery += " [Status]='" + sSts[i] + "'";    	        	
    	    		sQuery += " where [orderid] = " + sOrder
    	    		  + " and [SKU] = " + sSku[i]
    	    		  + " and [S/N] = " + sSrl[i]
    	    		;    	    			
    	    		//System.out.println(sQuery);
    	    			
    	    		stmt = con.createStatement ();
    	    		stmt.executeUpdate(sQuery);
    	    		stmt.close();
    	        }
    	    	
    	    	// Save tracking ID
    	    	stmt = con.createStatement ();
    	    	stmt.executeUpdate(sQuery);
    	    	stmt.close();
    	    	
    	    	for(int i=0; i < sTrack.length; i++)
    	        {
    	    		if(!sTrack[i].trim().equals("") && !sTrack[i].trim().equals("NOT FOUND")
    	    				 && !sPack[i].trim().equals("NOT FOUND"))
    	    		{
    	    			Statement stmt1 = null;    	    			
    	    			sQuery = "select PackId from [dbo].[fdx_ord_shp]"
    	    			 +  " where [PackId] = '" + sPack[i] + "'";
    	    			stmt1 = con.createStatement ();
    	    	    	stmt1.executeQuery(sQuery);
    	    	    	rs = stmt1.getResultSet();
    	    	    	if(rs.next())
    	    	    	{    	    			
    	    				sQuery = "update [dbo].[fdx_ord_shp] set";    	    		
    	        	    	sQuery += " [trackingnumber]='" + sTrack[i] + "'";    	        	
    	    		    	sQuery += " where [PackId] = '" + sPack[i] + "'";
    	    				;    	    			
    	    				System.out.println(sQuery);
    	    			
    	    				stmt = con.createStatement ();
    	    				stmt.executeUpdate(sQuery);
    	    				stmt.close();
    	    	    	}
    	    	    	else
    	    	    	{
    	    	    		sQuery = "insert into [dbo].[fdx_ord_shp] " 
    	    	    		+ "([trackingnumber]"
    	    	    		+ ",[PackID]"
    	    	    		+ ",[FedExAccount]"
    	    	    		+ ",[shipfullname]"
    	    	    		+ ",[shipcompanyname]"
    	    	    		+ ",[shipaddress1]"
    	    	    		+ ",[shipaddress2]"
    	    	    		+ ",[shipcity]"
    	    	    		+ ",[shipstate]"
    	    	    		+ ",[shippostalcode]"
    	    	    		+ ",[shipphonenumber]"
    	    	    		+ ",[packageqty]"
    	    	    		+ ",[weight]"
    	    	    		+ ",[srvctype]"
    	    	    		+ ",[pckgtype]"
    	    	    		+ ",[shipdate]"
    	    	    		+ ",[declaredvalue]"
    	    	    		+ ",[billto]"
    	    	    		+ ",[acctnum]"
    	    	    		+ ",[deptnotes]"
    	    	    		+ ",[ref]"
    	    	    		+ ",[ponum]"
    	    	    		+ ",[invnum]"
    	    	    		+ ",[shipid]"
    	    	    		+ ",[pckgcont1]"
    	    	    		+ ",[pckgcont2]"
    	    	    		+ ",[reqsig]"
    	    	    		+ ",[estcost])"
    	    	    		+ " values("
							+ "'" + sTrack[i] +  "','" + sPack[i] + "'"
							+ ", 'SAME'"
							+ ", 'SAME'"
							+ ", 'SAME'"
							+ ", 'SAME'"
							+ ", 'SAME'"
							+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 0 " 
    	    	    		+ ", 0"
    	    	    		+ ", 'SAME'"
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", CURRENT_TIMESTAMP"
    	    	    		+ ", 0"
    	    	    		+ ", 'SAME'"
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", 'SAME'" 
    	    	    		+ ", null" 
    	    	    		+ ", null"
    	    	    		+ ", '0'" 
    	    	    		+ ", '0'"  
							+ ")"
    	    	    		;
    	    	    		System.out.println(sQuery);
        	    			
    	    				stmt1 = con.createStatement ();
    	    				stmt1.executeUpdate(sQuery);
    	    				stmt1.close();
    	    	    	}
    	    		}
    	        }
    	    	
    	    	
    		}
        }
    } catch(java.sql.SQLException e){ System.out.println(e.getMessage()); }
    
    CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();    
%>
<SCRIPT language="JavaScript1.2">

var fxhdr = [<%=srvpgm.cvtToJavaScriptArray(sHdr)%>]; 
var fxdtl = new Array();


<%for(int i=0; i < vDtl.size(); i++){
	String [] sData = (String []) vDtl.get(i);%>
	fxdtl[<%=i%>] = [<%=srvpgm.cvtToJavaScriptArray(sData)%>];
<%}%>
<%if(!sAction.equals("Save")){%>
    parent.showFedEx(fxhdr, fxdtl);
<%} else {%>parent.hidePanel();<%}%>
</SCRIPT>



<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

