<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*,java.text.SimpleDateFormat
, rciutility.CallAs400SrvPgmSup, rciutility.ConnToCounterPoint"%>
<%
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
  
   if(sFrDate == null || sFrDate.trim().equals("")) 
   { 
	   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");
	   // from -7 days
	   Calendar cal = Calendar.getInstance();
	   cal.add(Calendar.DATE, -7);
	   java.util.Date date = cal.getTime();	   
       sFrDate = smp.format(date);
       
       // to -1 day
       cal = Calendar.getInstance();
	   cal.add(Calendar.DATE, -1);
	   date = cal.getTime();
	   sToDate = smp.format(date);
   }
   
   if(sSort == null){ sSort = "rssts, rsord";}
   
//----------------------------------
//Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=MozuOrdAutoRetRecap.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString(); 
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
%>
<HTML>
<HEAD>
<title>ECOM Return Recap</title>
 </HEAD>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css"> 

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script src="XX_Set_Browser.js"></script>
<script src="XX_Get_Visible_Position.js"></script>

 
<script>
//==============================================================================
// Global variables
//==============================================================================
var NumOfRow = 0;
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHist", "dvOpt"]);	
	
	doSelDate();
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function doSelDate()
{
	document.getElementById("FrDate").value = FrDate;
	document.getElementById("ToDate").value = ToDate;
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
	var button = document.all[id];
	var date = new Date(button.value);

	if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
	else if(direction == "UP") date = new Date(new Date(date) - -86400000);
	button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
//submit for different days back
//==============================================================================
function resbm(sel)
{
	var frdate = document.getElementById("FrDate").value;
	var todate = document.getElementById("ToDate").value;
	
	url ="MozuOrdAutoRetRecap.jsp?FrDate=" + frdate
	  + "&ToDate=" + todate
	  + "&Sort=<%=sSort%>"
	;
	window.location.href=url;
}
//==============================================================================
//submit for different days back
//==============================================================================
function resort(sort)
{
	url ="MozuOrdAutoRetRecap.jsp?FrDate=<%=sFrDate%>"
	  + "&ToDate=<%=sToDate%>"
	  + "&Sort=" + sort
	;
	window.location.href=url;
}
//==============================================================================
//submit for different days back
//==============================================================================
function setFilter(sel)
{		
	for(var i = 0; i < NumOfRow; i++)
	{
		var tr = document.getElementById("trId" + i);
		var sts = document.getElementById("tdSts" + i).innerHTML;
		var ref = document.getElementById("tdRefSts" + i).innerHTML;
		
		if(sel == '1' && sts == "ManualReq" && ref != "Closed")
		{
			tr.style.display = "table-row";
		}
		else if(sel == '1'){ tr.style.display = "none"; }
		
		else if(sel == '2' && sts == "ManualReq" && ref == "Closed")
		{
			tr.style.display = "table-row";
		}
		else if(sel == '2'){ tr.style.display = "none"; }
		
		else if(sel == '3' && sts == "Submitted"){ tr.style.display = "table-row"; }
		else if(sel == '3'){ tr.style.display = "none"; }
		
		else if(sel == '4'){ tr.style.display = "table-row"; }
	}
} 
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvOpt" class="dvItem"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!----------------- beginning of table ------------------------>  
<table id="tbl01" class="tbl01">
   <tr id="trTopHdr" style="background:ivory; ">
          <th align=center colspan=2>
            <b>Retail Concepts, Inc
            <br>ECOM Order Auto Return Recap 
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuSoldOutLstSel.jsp"><font color="red" size="-1">Select</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;  
            <br>Select Dates<br>
            
            <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 400, 120, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            
              &nbsp;&nbsp;&nbsp;
            
            <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 600, 120, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>   
             
              &nbsp;&nbsp;&nbsp;
              <button class="Small" onclick="resbm('1');">Go</button>
            <br>
            Show: <input type="radio" name="inpSelSts" value="1" onclick="setFilter('1')">Manual/Error - No Refund 
            &nbsp;&nbsp;&nbsp;
            <input type="radio" name="inpSelSts" value="2" onclick="setFilter('2')">Manual/Error - Refunded   
            &nbsp;&nbsp;&nbsp;
            <input type="radio" name="inpSelSts" value="3" onclick="setFilter('3')">Submitted   
            &nbsp;&nbsp;&nbsp;                               
            <input type="radio" name="inpSelSts" value="4" onclick="setFilter('4')">All
            <br><br>
            <span style="font-size: 12px; font-weight: normal;">
            <b>Note:</b>  Normal KIBO Return Statuses of 'Closed' or 'Refunded' - are auto processed during overnight jobs.   
            </span>
          </th>   
        </tr> 
                
      <!-- ======================================================================= -->
      <tr id="trId" style="background:#FFE4C4;">
      	<th align=center valign="top">
    
    	   <table id="tbl01" class="tbl02">
    	    <tr>
           		<th class="th01" nowrap>No.</th>
           		<th class="th01" nowrap><a href="javascript: resort('rsord')">Order #</a></th>
           		<th class="th01" nowrap><a href="javascript: resort('rscrtdt,rsord')">Create Return<br>Date</a></th>
           		<th class="th01" nowrap><a href="javascript: resort('rssts,rsord')">Status</a></th>
           		<th class="th01" nowrap>KIBO<br>Return<br>Status</th>
           		<th class="th01" nowrap>KIBO<br>Return<br>Date</th>
           		<th class="th01" nowrap>Short SKU</th>
           		<th class="th01" nowrap>Long Item Number</th>
           		<th class="th01" nowrap>Amount</th>
           		<th class="th01" nowrap>Tax</th>
           		<th class="th01" nowrap>Override</th>
           		<th class="th01" nowrap><a href="javascript: resort('rsReas,rsord')">Reason</a></th>
           		<th class="th01" nowrap>Action</th>
           		<th class="th01" nowrap>Option</th>
           		<th class="th01" nowrap>Link<br>To KIBO</th>
           	</tr> 
           	   
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;
        int iOrd = 0;
        
        String sStmt = "select rsord, char(rscrtdt, usa) as rscrtdt, rssku, digits(icls) as icls" 
         + ", digits(iven) as iven, digits(isty) as isty, digits(iclr) as iclr" 
         + ", digits(isiz) as isiz" 
         + ", rssts" 
         
         + ", case when " 
            + " (select b.ROsts from rci.morefh b where  b.ROSITE = rssite and b.ROORD = rsord" 
            + " and b.RORECDT >= rscrtdt order by b.RORECDT fetch first 1 row only)"
         + " is not null then"
        	+ " (select b.ROsts from rci.morefh b where  b.ROSITE = rssite and b.ROORD = rsord" 
            + " and b.RORECDT >= rscrtdt order by b.RORECDT fetch first 1 row only)"
         + " else ' ' end as rosts" 
         
		 + ", case when " 
		 + " (select char(b.RORECDT, usa) from rci.morefh b where  b.ROSITE = rssite and b.ROORD = rsord" 
		 + " and b.RORECDT >= rscrtdt order by b.RORECDT fetch first 1 row only)"
		 + " is not null then"
		 + " (select char(b.RORECDT, usa) from rci.morefh b where  b.ROSITE = rssite and b.ROORD = rsord" 
		 + " and b.RORECDT >= rscrtdt order by b.RORECDT fetch first 1 row only)"
		 + " else ' ' end as rocrtdt" 
         
         + ", rsreas,rsActn,RSROPT" 
         + ", case when riamt is null then 0 else riamt end as riamt" 
         + ", case when ritax is null then 0 else ritax end as ritax" 
         + ", case when ROOVRTX is null then ' ' else ROOVRTX end as ROOVRTX" 
         + ", case when RoOrdId is null then ' ' else RoOrdId end as RoOrdId"
         + " from rci.ecsrlrt" 
         + " inner join iptsfil.IpItHdr on rssku = isku" 
         + " inner join rci.MoPrtDtl on ilcls = icls and ilven=iven and ilsty=isty" 
         + " left join rci.MoRtnItm on riord=rsord  and ricls=icls and riven=iven" 
         + "  and risty=isty and riclr=iclr and risiz=isiz" 
         + " left join rci.MoRtnOrd a on a.roord=rsord and rscrtdt=rscrtdt" 
         + " where rssite = '11961'" 
         + " and rscrtdt >= '" + sFrDate + "'"
         + " and rscrtdt <= '" + sToDate + "'"
         + " order by " + sSort
        ;
        
        System.out.println("\n" + sStmt);
        		
        RunSQLStmt runsql = new RunSQLStmt();
        runsql.setPrepStmt(sStmt);
        ResultSet rs = runsql.runQuery();
        		
        String sSvOrd = null;
        int iLine = 0;
        String svOrd = "";
        String sRowCls = "trDtl06";
        
        while(runsql.readNextRecord())
        {        		  
        	String sOrd = runsql.getData("rsord").trim();
        	String sCrtDt = runsql.getData("rscrtdt").trim();
        	
        	String sSku = runsql.getData("rssku").trim();
        	String sCls = runsql.getData("iCls").trim();
        	String sVen = runsql.getData("iven").trim();
        	String sSty = runsql.getData("isty").trim();
        	String sClr = runsql.getData("iclr").trim();
        	String sSiz = runsql.getData("iSiz").trim();
        	String sSts = runsql.getData("rssts").trim();
        	String sRefSts = runsql.getData("rosts").trim();
        	String sAmt = runsql.getData("riamt").trim();
        	String sTax = runsql.getData("ritax").trim();
        	String sOvrTx = runsql.getData("ROOVRTX").trim();
        	String sReas = runsql.getData("rsReas").trim();
        	String sAction = runsql.getData("rsActn").trim();
        	String sRtnOpt = runsql.getData("rsROpt").trim();
        	String sOrderId = runsql.getData("RoOrdId").trim();
        	String sRefCrtDt = runsql.getData("rocrtdt").trim();
        	
        	bEven = !svOrd.equals(sOrd); 
        	svOrd = sOrd;
        	if(bEven) 
        	{
        		if(sRowCls.equals("trDtl06")) { sRowCls = "trDtl04"; }
        		else { sRowCls = "trDtl06"; }
        	}
        	
        	String sRtnStsClr = "";
        	if(sSts.equals("ManualReq") || sSts.equals("Error")){ sRtnStsClr = "style=\"background: pink;\""; }
        	if(sSts.equals("Submitted")){ sRtnStsClr = "style=\"background: #d2f7e4;\""; }
        	
        	String sRefStsClr = "";
        	if(!sRefSts.equals("Closed")  &&  (sSts.equals("ManualReq") || sSts.equals("Error"))){ sRefStsClr = "style=\"background: pink;\""; }
        	else if(sRefSts.equals("Closed")  &&  (sSts.equals("ManualReq") || sSts.equals("Error"))){ sRefStsClr = "style=\"background: #d2f7e4;\""; }
        	
         %>
         <tr id="trId<%=iLine%>" class="<%=sRowCls%>">            
            <td class="td12" ><%=(++iOrd)%></td>
            <td class="td12" ><%=sOrd%></td>
            <td class="td12" ><%=sCrtDt%></td>
            <td class="td11" id="tdSts<%=iLine%>" <%=sRtnStsClr%>><%=sSts%></td>
            <td class="td11" id="tdRefSts<%=iLine%>" <%=sRefStsClr%>><%=sRefSts%></td>
            <td class="td11" id="tdRefDt<%=iLine%>"  <%=sRefStsClr%>><%=sRefCrtDt%></td>
            <td class="td12" ><%=sSku%></td>
            <td class="td12" ><%=sCls%><%=sVen%><%=sSty%>-<%=sClr%><%=sSiz%></td>            
            <td class="td12" ><%=sAmt%></td>
            <td class="td12" ><%=sTax%></td>
            <td class="td18" ><%=sOvrTx%></td>
            <td class="td11" ><%=sReas%></td>
            <td class="td11" ><%=sAction%></td>
            <td class="td11" ><%=sRtnOpt%></td>
            <td class="td11">
               <a href="https://t11961.mozu.com/Admin/s-16493/orders/edit/<%=sOrderId%>" target="_blank">Kibo</a>
            </td>
         </tr>
       <% iLine++;
         }%>
	  </table>
	  <script type="text/javascript">
	  NumOfRow = "<%=iLine%>";
	  </script>
            <%
            runsql.disconnect();
            runsql = null;
             %> 
      <!----------------------- end of table ------------------------>
    </th>
    <th align=center valign="top">  
      
      <!-- ======================================================================= -->
      <!-- ======================================================================= -->
      <!-- ======================================================================= -->
      
      
       
      
   </table>
   <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

       
    </body>
</html>
<%
}
%>