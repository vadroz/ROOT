<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*
, rciutility.CallAs400SrvPgmSup, rciutility.ConnToCounterPoint"%>
<%
   String sDays = request.getParameter("days");
   String sOrd = request.getParameter("ord");

   if(sDays == null || sDays.trim().equals("")) { sDays="0"; }
   
   if(sOrd == null || sOrd.trim().equals("")) { sOrd = "0"; }
   else if( !sOrd.trim().equals("") && !sOrd.trim().equals("0")) { sDays = "0"; }
   
//----------------------------------
//Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=MozuSoldOutLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	 
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
%>
	
<HTML>
<HEAD>
<title>Fix FedEx Database</title>
 </HEAD>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css"> 

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script src="XX_Set_Browser.js"></script>
<script src="XX_Get_Visible_Position.js"></script>

 
<script>
//==============================================================================
// Global variables
//==============================================================================
var UpdLine = null;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHist", "dvOpt"]);
	
}
//==============================================================================
// submit for different days back
//==============================================================================
function resbm(sel)
{
	var days = document.getElementById("selDays");
	var day = days.options[days.selectedIndex].value;
	
	var ord = document.getElementById("SelOrd").value.trim();
	
	url ="MozuOrdFdxLst.jsp?";
	
	if(sel == "1"){ url += "days=" + day; }
	else if(sel == "2"){ url += "ord=" + ord; }
	
	window.location.href=url;
}
//==============================================================================
// show selected order only
//==============================================================================
function getSngOrd(ord)
{
	url ="MozuOrdFdxLst.jsp?ord=" + ord;
	window.location.href=url;
}

//==============================================================================
// delete selected Fedex detail record only 
//==============================================================================
function dltFdxRec(line, ord, sku, sn,str)
{
	UpdLine = line;
	
	url ="FedExUpdDtlChg.jsp?ord=" + ord
	 + "&sku=" + sku
	 + "&sn=" + sn
	 + "&str=" + str
	 + "&action=DltFedexDtl"
	;
	window.frame1.location.href=url;
}
//==============================================================================
//delete selected Fedex detail record only 
//==============================================================================
function insUpdFedex(line,ord, sku, str, sn, packid)
{
	UpdLine = line;
	
	url ="FedExUpdDtlChg.jsp?ord=" + ord
	 + "&sku=" + sku
	 + "&sn=" + sn
	 + "&str=" + str
	 + "&packid=" + packid
	 + "&action=UpdFdxDtl"
	 + "&user=<%=sUser%>"
	;
	window.frame1.location.href=url;
}
//==============================================================================
// mark line 
//==============================================================================
function updLine(action, success)
{	
	var lineNm = "trId" + UpdLine;
	var row = document.getElementById(lineNm);
	var msg = "";
	var color = "";
	
	if(action == "DltFedexDtl")
	{		
		msg = "Record have been deleted.";
		color = "#4d8ff9";
	}
	else if(action == "UpdFdxDtl")
	{
		msg = "Record have been updated.";
		color ="#f4e242";
	}
	
	alert(msg);
	row.style.backgroundColor = color;
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
            <br>Mozu - Fix FedEx Packing for Recent Orders 
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuSoldOutLstSel.jsp"><font color="red" size="-1">Select</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;  
            <br> Select Days back: 
            <select name="selDays" id=="selDays">
              <option value="0">0</option>
              <option value="1" selected>1</option>
              <option value="2" >2</option>
              <option value="3" >3</option>
              <option value="4" >4</option>
              <option value="5" >5</option>
            </select>
            &nbsp; &nbsp;
            <button class="Small" onclick="resbm('1');">Go</button>
            <br>
            - or - 
            <br>
            Select Order number: <input name="SelOrd" id="SelOrd" maxlength=10 size=15>
            &nbsp; &nbsp;
            <button class="Small" onclick="resbm('2');">Go</button>                               
          </th>   
        </tr> 
                
      <!-- ======================================================================= -->
      <tr id="trId" style="background:#FFE4C4;">
      	<th align=center valign="top">
    
    	   <table id="tbl01" class="tbl02">
    	    <tr>
           		<th class="th01" rowspan="2" nowrap>No.</th>
           		<th class="th01" rowspan="2" nowrap>Order<br>#</th>
           		<th class="th01" rowspan="2" nowrap>Order<br>Date</th>
           		<th class="th01" rowspan="2" nowrap>Order<br>Status</th>
           		<th class="th01" rowspan="2" nowrap>&nbsp;</th>
           		<th class="th01" rowspan="2" nowrap>SKU<br>#</th>
           		<th class="th01" rowspan="2" nowrap>S/N</th>
           		<th class="th01" rowspan="2" nowrap>Str<br>#</th>
           		<th class="th01" rowspan="2" nowrap>Pack<br>Id</th>
           		<th class="th01" rowspan="2" nowrap>Packing<br>Date</th>
           		<th class="th01" rowspan="2" nowrap>Update<br>FedEx<br>==></th>
           		<th class="th01" nowrap colspan=3>FedEx</th>           		
           		<th class="th01" rowspan="2" nowrap>Delete</th>
           	</tr> 
           	<tr>
           		<th class="th01" nowrap>Str</th>
           		<th class="th01" nowrap>Packing<br>Id</th>
           		<th class="th01" nowrap>Shipping<br>Status</th>
           	</tr>
               
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;
        int iOrd = 0;
        
        String sStmt = " select opord, ohordate, ohordsts, opsku,pnsn, pnstr, pnrecdt, FDPCKID"                                
          + " from rci.MoOrPas"
          + " inner join rci.MoOrdh on ohsite = opsite and ohord = opord"
          + " inner join rci.MoSpStn on opid=pnpickid"
          + " left join rci.MoFdxPId p on opord=fdord and fdsku = opsku" 
          + " and pnsn=fdsrn and pnstr=fdstr"                     
          + " where ohordsts <> 'Cancelled' and pnsts = 'Shipped'"
        ;
          
        if(!sOrd.equals("") && !sOrd.equals("0"))
        { 
        	sStmt += " and opord = " + sOrd; 
        }
        else
        {
        	sStmt += " and pnrecdt = current date - " + sDays + " days ";
        }		  
        		  
        sStmt += " order by opord, opsku, pnstr, pnsn";
        
        System.out.println(sStmt);
        		
        RunSQLStmt runsql = new RunSQLStmt();
        runsql.setPrepStmt(sStmt);
        ResultSet rs = runsql.runQuery();
        		
        String sSvOrd = null;
        int iLine = -1;
        while(runsql.readNextRecord())
        {
        		  
        	String sOrdNum = runsql.getData("opord").trim();
        	String sOrdDate = runsql.getData("ohordate").trim();
        	String sOrdSts = runsql.getData("ohordsts").trim();
        	String sSku = runsql.getData("opsku").trim();
        	String sSn = runsql.getData("pnsn").trim();
        	String sStr = runsql.getData("pnstr").trim();
        	String sPackId = runsql.getData("FDPCKID");
        	String sPackDt = runsql.getData("pnrecdt");
        		  
        	if(sPackId == null) { sPackId = ""; }
        	else{ sPackId = sPackId.trim(); }
        			
        	// get fedex data
        			
        	ConnToCounterPoint connToCP = new ConnToCounterPoint();
            connToCP.connToDb("FedEx", "192.168.20.77");
            Connection con = connToCP.getCurrentConn();
              	  
            Statement stmt = null;
            ResultSet rs1 = null;
              	  
            boolean bFdxFound = false; 
            Vector<String> vFdxPackId = new Vector<String>();
            Vector<String> vFdxStr = new Vector<String>();
            Vector<String> vFdxSts = new Vector<String>();
            Vector<String> vFdxShpRet = new Vector<String>();
              	              	  
            boolean bSuccess = false;
              	    
            if(!con.isClosed())
            {
            	String query = "select [store],[packid],[status],[shpret] "                                         
              	 + " from [dbo].[fdx_ord_dtl]"                                    
              	 + " where [orderid] = '" + sOrdNum + "'"
              	 + " and [sku] = '" + sSku + "'"       
              	 + " and [s/n] = '" + sSn + "'"              		    
              	; 
              	try
              	{
              		stmt = con.createStatement ();
              		stmt.executeQuery(query);
              		rs1 = stmt.getResultSet();
              		while(rs1.next())
              		{
              			bFdxFound = true;
              		    if(rs1.getString(1) == null){ vFdxStr.add(" "); }
                        else { vFdxStr.add(rs1.getString(1)); }
              		    if(rs1.getString(2) == null){ vFdxStr.add(" "); }
                        else { vFdxPackId.add(rs1.getString(2)); }
              		    if(rs1.getString(3) == null){ vFdxSts.add( " "); }
                        else { vFdxSts.add(rs1.getString(3)); }
              		    if(rs1.getString(4) == null){ vFdxShpRet.add( " "); }
                        else { vFdxShpRet.add(rs1.getString(4)); }
              		   	}
              }
              catch (SQLException ex) {
                 System.out.println (ex.getMessage());
              }        
            }
            else { System.out.println("Database is closed."); }
               
               
               boolean bNewOrd = sSvOrd == null || !sSvOrd.equals(sOrdNum);               
               sSvOrd = sOrdNum;
               
               if(bNewOrd) {bEven = !bEven; iOrd++;}
               
               String sColor1 = "";
               String sColor2 = "";
               boolean bMismatch = false;
               for(int j=0; j < vFdxStr.size(); j++)
               {
            	   // store mismatch on FFL site
            	   if(sColor1.equals("") && !sStr.equals(vFdxStr.get(j))) 
            	   { 
            		   sColor1 = "style=\"background: khaki\""; 
            		   bMismatch = true;
            	   }
            	   // package mismatch on FFL site
            	   if(sColor1.equals("") && !sPackId.trim().equals("") && !sPackId.equals(vFdxPackId.get(j)))
                   { 
                	   sColor2 = "style=\"background: khaki\"";
                	   bMismatch = true;
                   }
            	   
               }
               boolean bMult = vFdxStr != null && vFdxStr.size() > 1;
               String sWarn = "&nbsp;";
               if(bMult){ sWarn = "<span style=\"color:red;font-weight:bold;\">!!!</span>"; }
               iLine++;
               
               
         %>
         <tr id="trId<%=iLine%>" class="<%if(bEven) {%>trDtl06<%} else {%>trDtl04<%}%>">            
            <%if(bNewOrd){%>
            	<td class="td12" ><%=(iOrd)%></td>
            	<td class="td11"><a href="javascript: getSngOrd('<%=sOrdNum%>')"><%=sOrdNum%></a></td>
            	<td class="td18"><%=sOrdDate%></td>
            	<td class="td11" ><%=sOrdSts%></td>
            <%}
            else {%>
                <td class="td12" colspan=4>&nbsp;</td>
            <%}%>
            <td class="Separator06" nowrap>&nbsp;</td>  
         	
         	<td class="td12" ><%=sSku%></td>
         	<td class="td12" ><%=sSn%></td>
         	<td class="td12" <%=sColor1%>><%=sStr%></td>
         	<td class="td12" <%=sColor2%>><%=sPackId%></td>
         	<td class="td12" ><%=sPackDt%></td>
         	
         	<td class="Separator07" nowrap>
         			<%if(!bMult && bMismatch || vFdxStr.size() == 0){%>
         				<a href="javascript: insUpdFedex('<%=iLine%>','<%=sOrdNum%>', '<%=sSku%>', '<%=sStr%>','<%=sSn%>', '<%=sPackId%>')">Upd</a>
         			<%}%>
         			<%=sWarn%>
         		</td>
         		
         	<%for(int j=0; j < vFdxStr.size(); j++){
         		String sColor3 = "";
                String sColor4 = "";
                
                // store mismatch on FedEx site
                if(!sStr.equals(vFdxStr.get(j)))
                { 
             	   sColor3 = "style=\"background: pink\""; 
                }                
                // package mismatch on FedEx site
                if(!sPackId.trim().equals("") && !sPackId.equals(vFdxPackId.get(j)))
                { 
             	   sColor4 = "style=\"background: pink\""; 
                }                
         	%>	
         		<%if(j > 0){%>
         		   </tr>
         		   <tr id="trId<%=iLine%>" class="<%if(bEven) {%>trDtl06<%} else {%>trDtl04<%}%>">
         		   <td class="td12" colspan=4>&nbsp;</td>
         		   <td class="Separator06" nowrap>&nbsp;</td>
         		   <td class="td12" colspan=4>a&nbsp;</td>
         		<%}%>
         		<td class="td12" <%=sColor3%>><%=vFdxStr.get(j)%></td>
         		<td class="td12" <%=sColor4%>><%=vFdxPackId.get(j)%></td> 
         		<td class="td12" ><%=vFdxSts.get(j)%></td>
         		<td class="td12" >
         			<%if(bMult){%>
         				<a href="javascript: dltFdxRec('<%=iLine%>','<%=sOrdNum%>', '<%=sSku%>', '<%=sSn%>', '<%=vFdxStr.get(j)%>')">Dlt Fedex</a>
         			<%}%>
         		</td>
         	<%}%>
          </tr>   	
             
           <%   
             //if(iOrd >= 50 ){ break; } 			
           %>
    	   
       <%}%>
	  </table>
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