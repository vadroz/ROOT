<%@ page import="dcfrtbill.DcStockSum, inventoryreports.PiCalendar, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.*"%>
<%
   String sWkend = request.getParameter("Wkend");
   
   if(sWkend==null)
   { 
	   String sStmt = "select char(piwb - 1 days, usa) as wkend from rci.fsyper where pida=current date";
	   
	   ResultSet rslset = null;
	   RunSQLStmt runsql = new RunSQLStmt();
	   runsql.setPrepStmt(sStmt);		   
	   runsql.runQuery();
			  
	  if(runsql.readNextRecord()){ sWkend = runsql.getData("wkend"); }
   } 

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=DcStockSum.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      //System.out.println("sort=" + sSort);
      DcStockSum dcsum = new DcStockSum(sWkend);
      
      String sTyWkend = dcsum.getTyWkend();
      String sLyWkend = dcsum.getLyWkend();
%>
<title>DC Productivity</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript">
var SelWkEnd = "<%=sWkend%>";
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
	doSelDate();
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function doSelDate()
{
	var df = document.all;
	var date = new Date(SelWkEnd);
	df.SelWkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()	
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
	var button = document.all[id];
	var date = new Date(button.value);
	date.setHours(18); 

	if(direction == "DOWN") date = new Date(new Date(date) - 7 * 86400000);
	else if(direction == "UP") date = new Date(new Date(date) - 7 * (-86400000));
	button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// submit report with selected date
//==============================================================================
function sbmReport()
{
	var wkend = document.all.SelWkend.value;
	var url = "DcStockSum.jsp?Wkend=" + wkend;
	window.location.href=url;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table class="tbl01">
    <tr class="trHdr">
      <th>
       <b>Retail Concepts, Inc
       <br>DC Productivity
       <br>Week Ending: &nbsp; 
       <button class="Small" name="Down" onClick="setDate('DOWN', 'SelWkend')">&#60;</button>
              <input name="SelWkend" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SelWkend')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 600, 100, document.all.SelWkend)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              
               &nbsp; &nbsp;
               <button class="Small" onClick="sbmReport()">Go</button>
       </b>       
       <br>
        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="DcStockSum.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
      </th>
    </tr>  
    
    <tr class="trHdr">
      <td>
      
      <table class="tbl02">
      	
       <%
       	 String sTrCls = "trDtl06"; 
         for(int i=1; i < 4; i++)   	 
         {   
        	 
        	 String sColHdg = "Week Ending";
        	 if(i==2){sColHdg = "Month-To-Date";}
        	 if(i==3){sColHdg = "Year-To-Date";}
       %>
        <%if(i==2 || i==3){%>
        	<tr class="trHdr">
          		<th class="th02" colspan=21>&nbsp;<br>&nbsp;<br>&nbsp;</th>
        	</tr>  
        <%} %>
        <tr class="trHdr01">
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=6>This Year <%=sColHdg%> <%=sTyWkend%></th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=6>Last Year <%=sColHdg%> <%=sLyWkend%></th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=6>Variance</th>
        </tr>
        <tr class="trHdr01">
          <th class="th02">#</th>
          <th class="th02"># Cartons</th>
          <th class="th02"># Pallets</th>
          <th class="th02">Units</th>
          <th class="th02">$ at Cost</th>
          <th class="th02">$ at Retail</th>
          
          <th class="th02">#</th>
          <th class="th02"># Cartons</th>
          <th class="th02"># Pallets</th>
          <th class="th02">Units</th>
          <th class="th02">$ at Cost</th>
          <th class="th02">$ at Retail</th>
          
          <th class="th02">#</th>
          <th class="th02"># Cartons</th>
          <th class="th02"># Pallets</th>
          <th class="th02">Units</th>
          <th class="th02">$ at Cost</th>
          <th class="th02">$ at Retail</th>
        </tr>  
           
    	   <%for(int j=1; j < 11; j++)
    	   {
    		    dcsum.setDcSum(i, j);
       	    
    		    String sTyNum = dcsum.getTyNum();
        		String sTyCart = dcsum.getTyCart();
        		String sTyPallet = dcsum.getTyPallet();
        		String sTyUnit = dcsum.getTyUnit();
        		String sTyCost = dcsum.getTyCost();
        		String sTyRet = dcsum.getTyRet();
        		
        		String sLyNum = dcsum.getLyNum();
        		String sLyCart = dcsum.getLyCart();
        		String sLyPallet = dcsum.getLyPallet();
        		String sLyUnit = dcsum.getLyUnit();
        		String sLyCost = dcsum.getLyCost();
        		String sLyRet = dcsum.getLyRet();
        		
        		String sVarNum = dcsum.getVarNum();
        		String sVarCart = dcsum.getVarCart();
        		String sVarPallet = dcsum.getVarPallet();
        		String sVarUnit = dcsum.getVarUnit();
        		String sVarCost = dcsum.getVarCost();
        		String sVarRet = dcsum.getVarRet();
    	   	
    	   	    if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
    			else {sTrCls = "trDtl06";}
    	   		
    	   	    String sGrp = "";
    	   	    if(j==1)      { sGrp = "&nbsp; &nbsp; &nbsp; New"; }
    	   	    else if(j==2) { sGrp = "&nbsp; &nbsp; &nbsp; OS"; }
    	   	    else if(j==3) { sGrp = "Receipts"; }
    	   	 	else if(j==4) { sGrp = "&nbsp; &nbsp; &nbsp; Unlocated"; }
    	   	    else if(j==5) { sGrp = "&nbsp; &nbsp; &nbsp; Located"; }
    	   	    else if(j==6) { sGrp = "Picked"; }
    	   	    else if(j==7) { sGrp = "Shipments"; }
    	   	    else if(j==8) { sGrp = "EOD On Hand"; }
    	   	    else if(j==9) { sGrp = "Transfer In"; }
    	   		else if(j==10){ sGrp = "RTV's"; }    	   		
       %>
         <%if(j==1) {%>
           <tr id="trStr<%=i%>" class="<%=sTrCls%>">
             <td class="td11" nowrap>Check Ins</td>
           </tr>
         <%}%>
         <%if(j==4) {%>
           <tr id="trStr<%=i%>" class="<%=sTrCls%>">
             <td class="td11" nowrap>Putaway</td>
           </tr>
         <%}%>
         <tr id="trStr<%=i%>" class="<%=sTrCls%>">
             <td class="td11" nowrap><%=sGrp%></td>
             <td class="td12" nowrap><%=sTyNum%></td>
             <td class="td12" nowrap><%=sTyCart%></td>
             <td class="td12" nowrap><%=sTyPallet%></td>
             <td class="td12" nowrap><%=sTyUnit%></td>
             <td class="td12" nowrap>$<%=sTyCost%></td>
             <td class="td12" nowrap>$<%=sTyRet%></td>
             <td class=td72>&nbsp;</td>
             <td class="td12" nowrap><%=sLyNum%></td>
             <td class="td12" nowrap><%=sLyCart%></td>
             <td class="td12" nowrap><%=sLyPallet%></td>
             <td class="td12" nowrap><%=sLyUnit%></td>
             <td class="td12" nowrap>$<%=sLyCost%></td>
             <td class="td12" nowrap>$<%=sLyRet%></td>
             <td class=td72>&nbsp;</td>
             <td class="td12" nowrap><%=sVarNum%>%</td>   
             <td class="td12" nowrap><%=sVarCart%>%</td>
             <td class="td12" nowrap><%=sVarPallet%>%</td>
             <td class="td12" nowrap><%=sVarUnit%>%</td>
             <td class="td12" nowrap><%=sVarCost%>%</td>
             <td class="td12" nowrap><%=sVarRet%>%</td>
         </tr>    
         <%}%>           
           </tr>
       <%}%>
      
      </td>
    </tr>      
       
    </table>
    
  </body>
</html>

<%
dcsum.disconnect();
dcsum = null;
  }
%>



