<!DOCTYPE html>	
<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSelCust = request.getParameter("Cust");
   String sOrd = request.getParameter("Ord");
   String [] sSku = request.getParameterValues("Sku");
   String [] sUps = request.getParameterValues("Ups");
   String [] sStr = request.getParameterValues("Str");
   String [] sSrn = request.getParameterValues("Srl");
   String [] sReas = request.getParameterValues("Reas");
   String [] sDesc = request.getParameterValues("Desc");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=EcPrtSrlRtn.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStmt = null;
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rs = null;
    
    sStmt = "Select * from RCI.ECORDH where ohsite='SASS' and ohord=" + sOrd;            
	//System.out.println(sStmt);    
    
    runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();
	
	String sBComp = null;
	String sBFirst = null;
	String sBLast = null;
	String sBAdd1 = null;
	String sBAdd2 = null;
	String sBCity = null;
	String sBState = null;
	String sBZip = null;
	String sBPhone = null;
	
	String sSComp = null;
	String sSFirst = null;
	String sSLast = null;
	String sSAdd1 = null;
	String sSAdd2 = null;
	String sSCity = null;
	String sSState = null;
	String sSZip = null;
	String sSPhone = null;	
	
	if(rs.next())
	{
		sBComp = rs.getString("OHBCOMP").trim();
		sBFirst = rs.getString("OHBFNAM").trim();
		sBLast = rs.getString("OHBLNAM").trim();
		sBAdd1 = rs.getString("OHBADD1").trim();
		sBAdd2 = rs.getString("OHBADD2").trim();
		sBCity = rs.getString("OHBCITY").trim();
		sBState = rs.getString("OHBSTATE").trim();
		sBZip = rs.getString("OHBZIP").trim();
		sBPhone = rs.getString("OHBPHN").trim();
		
		sSComp = rs.getString("OHSCOMP").trim();
		sSFirst = rs.getString("OHSFNAM").trim();
		sSLast = rs.getString("OHSLNAM").trim();
		sSAdd1 = rs.getString("OHSADD1").trim();
		sSAdd2 = rs.getString("OHSADD2").trim();
		sSCity = rs.getString("OHSCITY").trim();
		sSState = rs.getString("OHSSTATE").trim();
		sSZip = rs.getString("OHSZIP").trim();
		sSPhone = rs.getString("OHSPHN").trim();
	}
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<style>
   html, body { height: 100%; }
   
   .footer { position:absolute; width:100%; text-align:left; 
             }
   
</style>

<title>Print Returns</title>

<SCRIPT>

//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	var pos = getObjPosition(document.all.pBot);
	if(pos[1] > 800){ document.all.dvFooter.style.pixelTop=pos[1]; }
	else{ document.all.dvFooter.style.pixelTop=800; }
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">


<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=0 width="100%">
        <tr>
          <th style="font-size:24px;text-align:left;">
          <img  src="/MainMenu/Sun & Ski Black.jpg" height="50">             
          </th>
        <tr>  
          <th style="font-size:14px;text-align:left;">  
            ECOM Item Return
          </th>
        </tr>
        <tr>
          <td>  
      <table width="100%">
        <tr>
          <th style="background:#efefef; text-align:left; width=50%;">Bill To:</th>
          <th style="background:#efefef; text-align:left; width=50%;">Ship To:</th>
        </tr>            
        
        
        <tr>
          <td style="vertical-align:top;">
           <table style="vertical-align:top; font-weight:bold;">        
        		<%if(!sBComp.equals("")){%><tr><td style="font-size:18px;"><%=sBComp%></td></tr><%}%>
        		<%if(!sBFirst.equals("") || !sBLast.equals("")){%><tr><td style="font-size:18px;"><%=sBFirst%>, <%=sBLast%></td></tr><%}%>
        		<%if(!sBAdd1.equals("")){%><tr><td style="font-size:18px;"><%=sBAdd1%></td></tr><%}%>
        		<%if(!sBAdd2.equals("")){%><tr><td style="font-size:18px;"><%=sBAdd2%></td></tr><%}%>
        		<tr><td style="font-size:18px;"><%=sBCity%>, <%=sBState%> <%=sBZip%></td></tr>
           </table>		        
        </td>
        	<td style="vertical-align:top;">
        	  <table style="vertical-align:top; font-weight:bold;">        
        		<%if(!sSComp.equals("")){%><tr><td style="font-size:18px;"><%=sSComp%></td></tr><%}%>
        		<%if(!sSFirst.equals("") || !sSLast.equals("")){%><tr><td style="font-size:18px;"><%=sSFirst%>, <%=sSLast%></td></tr><%}%>
        		<%if(!sSAdd1.equals("")){%><tr><td style="font-size:18px;"><%=sSAdd1%></td></tr><%}%>
        		<%if(!sSAdd2.equals("")){%><tr><td style="font-size:18px;">a|<%=sSAdd2%></td></tr><%}%>
        		<tr><td style="font-size:18px;"><%=sSCity%>, <%=sSState%> <%=sSZip%></td></tr>
             </table>
        	</td>
        </tr>
       </table>
      <!----------------------- end of table ------------------------>
      </tr>
      <!-- ===================== Details ====================== -->
      <tr>
      	<td colspan=2>
      	 <table width="100%"> 
      		<tr>
          		<th style="background:#efefef;">SKU</th>
          		<th style="background:#efefef;">UPS</th>
          		<th style="background:#efefef;">S/N</th>
          		<th style="background:#efefef;">Description</th>
          		<th style="background:#efefef;">Store</th>
          		<th style="background:#efefef;">Qty</th>
      		</tr>
      		<%for(int i=0; i < sSku.length; i++){%>
      			<tr> 
      		 		<td style="text-align:center;"><%=sSku[i]%></td>
      		 		<td style="text-align:center;"><%=sUps[i]%></td>
      		 		<td style="text-align:right;"><%=sSrn[i]%></td>
      		 		<td style="text-align:left;"><%=sDesc[i]%></td>
      		 		<td style="text-align:center;"><%=sStr[i]%></td>
      		 		<td style="text-align:center;">1</td>
      			</tr>
      		<%}%>   
      	 </table>
      	</td>
      </tr>
   </table>
   <p id="pBot" />

   <div id="dvFooter" class="footer">
    	<div style="font-weight:bold;width:100%;text-align:center;">Thank you for shopping with Sun and Ski!</div>
    	<br>   
        <span style="text-align:left;">
         Your return has been received and will be processed by our ECOMMERCE department.
         <br>If you have any questions please feel free to reach us at 
		 <br>customersupport@sunandski.com
		 <br>866-786-3869
		 <br>or you can live chat with us at sunandski.com
    </div>
   
   
 </body>
</html>
<%
}
%>