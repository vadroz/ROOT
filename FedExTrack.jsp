<%@ page import="java.text.SimpleDateFormat, java.math.BigDecimal, rciutility.ConnToCounterPoint, java.net.URL, java.sql.*, java.sql.*,java.util.*, java.text.*"%>
<%
    String sFrDate = request.getParameter("FrDate");
    String sToDate = request.getParameter("ToDate");
    String sOrder = request.getParameter("Order");

	String sStmt = "Select";
	
	if(sFrDate == null || sToDate == null ){ sStmt += " TOP 1000"; } 
	
	sStmt += " [orderid],[orderdate],[paymentamount],[shipfullname],[emailaddress],[shippostalcode],[productcodes],[shippedcomplete]"
	  + ", [shippingmethodname]"		
	  + " FROM [FedEx].[dbo].[fdx_ord_hdr] ";
	
	if((sOrder == null || sOrder.trim().equals(""))  && sFrDate != null && sToDate != null ){ sStmt += " where orderdate >='" + sFrDate + "'" + " and orderdate <='" + sToDate + "'"; }
	if(sOrder != null && !sOrder.trim().equals("")){ sStmt += " where orderid =" + sOrder;  }
	
	sStmt += " Order by [orderid] desc"
	;
	System.out.println(sStmt);
	
	
	ConnToCounterPoint connToFx = new ConnToCounterPoint();
	connToFx.connToDb("FedEx", "192.168.20.77"); 
    Connection con = connToFx.getCurrentConn();

	Vector vOrd = new Vector();
	Vector vOrdDate = new Vector();
	Vector vPayAmt = new Vector();
	Vector vShipName = new Vector();
	Vector vEmail = new Vector();
	Vector vShipZip = new Vector();
	Vector vProd = new Vector();
	Vector vComplete = new Vector();
	Vector vShipMth = new Vector();
	boolean bRecordFound = false;	
	Statement stmt = null;
	ResultSetMetaData rsmd = null;
	ResultSet rs = null;
	
	try
	{
		stmt = con.createStatement();
	    stmt.executeQuery(sStmt);
	    rs = stmt.getResultSet();	    
	    while(rs.next())
	    {
		   bRecordFound = true;
		   vOrd.add(rs.getString(1));
		   vOrdDate.add(rs.getString(2));
		   vPayAmt.add(rs.getString(3));
		   vShipName.add(rs.getString(4));
		   vEmail.add(rs.getString(5));
		   vShipZip.add(rs.getString(6));
		   vProd.add(rs.getString(7));
		   vComplete.add(rs.getString(8));
		   vShipMth.add(rs.getString(9));
     	}
	}
	catch (SQLException ex) { System.out.println (ex.getMessage()); }	
%>
<HTML>
<HEAD>
<title>FedEx Tracking</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:12px} a:visited.small { color:blue; font-size:12px}  a:hover.small { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:12px;}
        
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:9px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: white; font-size:12px }
        tr.DataTable2 { background: yellow; font-size:12px }
        tr.DataTable12 { background: yellow; font-size:12px }
        

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DTError{color:red; font-size:12px;}               

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvTooltip { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:15; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
               

        tr.Prompt { background: lavender; font-size:10px }
        tr.Prompt1 { background: seashell; font-size:10px }
        tr.Prompt2 { background: LightCyan; font-size:11px }

        th.Prompt { background:#FFCC99; text-align:ceneter; vertical-align:midle; font-family:Arial; font-size:11px; }
        td.Prompt { padding-left:3px; padding-right:3px; text-align:left; vertical-align:top; font-family:Arial;}
        td.Prompt1 { padding-left:3px; padding-right:3px; text-align:center; vertical-align:top; font-family:Arial;}
        td.Prompt2 { padding-left:3px; padding-right:3px; text-align:right; font-family:Arial; }
        td.Prompt3 { padding-left:3px; padding-right:3px; text-align:left; vertical-align:midle; font-family:Arial;}


</style>


<script language="javascript1.3">
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   doSelDate(1);
}
//==============================================================================
//show optional date selection button
//==============================================================================
function showAllDates(type)
{
  if(type==1)
  {
     document.all.tdDate1.style.display="block"
     document.all.tdDate2.style.display="none"
     doSelDate(1);
  }
}
//==============================================================================
//show date selection
//==============================================================================
function showDates(type, optdt)
{
    if(type==1)
    {
      document.all.tdDate1.style.display="none"
      document.all.tdDate2.style.display="block"
    }
    else
    {
       document.all.tdDate3.style.display="none"
       document.all.tdDate4.style.display="block"
    }
    doSelDate(optdt)
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
var df = document.all;
var date = new Date();

df.StsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
date = new Date(new Date() - 7 * 86400000);
if (type==2){ date = new Date(); }
else if (type==3){ date = new Date(new Date() - 3 * 86400000); }

df.StsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
var button = document.all[id];
var date = new Date(button.value);


if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
else if(direction == "UP") date = new Date(new Date(date) - -86400000);
button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function sbmFedExList()
{
	var url = null;
	var frdate = document.all.StsFrDate.value;
	var todate = document.all.StsToDate.value;
	var ordnum = document.all.OrdNum.value;
	
	frdate = fixDate(frdate);
	todate = fixDate(todate);
	
	url = "FedExTrack.jsp?"
	      + "FrDate=" + frdate
	      + "&ToDate=" + todate	 
	      + "&Order=" + ordnum

	//alert(url)
    window.location.href=url; 
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function fixDate(sdate)
{	
	var date = new Date(sdate);
	var mon = date.getMonth()+1;
	if(mon < 10){ mon = '0' + mon; }
	var day = date.getDate();
	if(day < 10){ day = '0' + day; }
	
	var fxdate = mon + "/" + day + "/" + date.getFullYear()
	return fxdate;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Federal Express - Tracking List
        </B><br>
        
        <table border=0 cellPadding="0" cellSpacing="0">
                   <!-- ============== select Order changes ========================== -->
           <TR><TD style="font-size:1px;border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        
           <!-- ============== select Order changes ========================== -->
           <TR><TD style="font-size:1px;border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
           <TR><TD class="DataTable" colspan=5>Order: <input class="Small" name="OrdNum" type="text" size=10 maxlength=10></TD></tr>

           <TR>
              <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
                <button id="btnSelDates" onclick="showDates(1,1)">Optional Order Date Selection</button>&nbsp;                
              </td>
              <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
                <b>From Date:</b>
                <button class="Small" name="Down" onClick="setDate('DOWN', 'StsFrDate')">&#60;</button>
                <input class="Small" name="StsFrDate" type="text" size=10 maxlength=10>&nbsp;
                <button class="Small" name="Up" onClick="setDate('UP', 'StsFrDate')">&#62;</button>
                &nbsp;&nbsp;&nbsp;
                <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.StsFrDate)" >
                <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

                <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

                <b>To Date:</b>
                <button class="Small" name="Down" onClick="setDate('DOWN', 'StsToDate')">&#60;</button>
                <input class="Small" name="StsToDate" type="text" size=10 maxlength=10>&nbsp;
                <button class="Small" name="Up" onClick="setDate('UP', 'StsToDate')">&#62;</button>
                &nbsp;&nbsp;&nbsp;
                <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.StsToDate)" >
                <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
                <button id="btnSelDates" onclick="showAllDates(1)">Prior 7 days</button>
          </TD>
        </TR>
        <TR><TD class="DataTable" colspan="5" ><button onclick="sbmFedExList();">Submit</button></TD></TR>
        <TR><TD style="font-size:1px;border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        </table>
        

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Order</th>
             <th class="DataTable">Order<br>Date</th>
             <th class="DataTable">Pay<br>Amt</th>
             <th class="DataTable">Ship<br>Name</th>
             <th class="DataTable">Email</th>
             <th class="DataTable">Shipping<br>Zip<br>Code</th>
             <th class="DataTable">Shipping<br>Method</th>
             <th class="DataTable">Warehouse</th>
             <th class="DataTable">SKU</th>
             <th class="DataTable">S/N</th>
             <th class="DataTable">Status</th>
             <th class="DataTable">Item Description</th>
             <th class="DataTable">Vendor</th>
             <th class="DataTable">Ret</th>
             <th class="DataTable">Pack Id</th>
             <th class="DataTable">Complete</th>             
           </tr>
       <!-- ============================ Details =========================== -->
   <%if(bRecordFound){%>    
       <%String sSvOrd = (String) vOrd.get(0); 
         String sClass = "DataTable1";         
       %>  
       <%for(int i=0; i < vOrd.size(); i++ ){%>      
       <%  
           String sOrd = (String) vOrd.get(i);           
           if(sClass.equals("DataTable1")){sClass = "DataTable";}
           else {sClass = "DataTable1";}
           sSvOrd = sOrd;                      
       %>   
       <%
            sStmt = "SELECT [Store],[SKU],[S/N],[Status],[ItemDescription],[Manufacturer]"
              + ",cast([Retail] as varchar) as ret,[PackID]"
              + " FROM [FedEx].[dbo].[fdx_ord_dtl]"
              + " where orderId='" + sOrd + "'";
            //if(i==0){System.out.println(sStmt);}
            ResultSet rsd = null;
            Vector vStr = new Vector();
            Vector vSku = new Vector();
            Vector vSn = new Vector();
            Vector vSts = new Vector();
            Vector vDesc = new Vector();
            Vector vVen = new Vector();
            Vector vRet = new Vector();
            Vector vPackId = new Vector();
            String sDesc = "";
            boolean bRfd = false; 
            try
            {
            	stmt = con.createStatement();
        	    stmt.executeQuery(sStmt);
        	    rs = stmt.getResultSet();	    
        	    while(rs.next())
        	    {
        	       bRfd = true;
        		   vStr.add(rs.getString(1));
        		   vSku.add(rs.getString(2));
        		   vSn.add(rs.getString(3));
        		   vSts.add(rs.getString(4));
        		   vDesc.add(rs.getString(5));
        		   vVen.add(rs.getString(6));
        		   vRet.add(rs.getString(7));
        		   vPackId.add(rs.getString(8));
        	    }   
            }
            catch (Exception e){ System.out.println (e.getMessage()); }
         %>       
         <tr id="trProd" class="<%=sClass%>">
            <td class="DataTable1" nowrap rowspan="<%=vStr.size()%>"><%=vOrd.get(i)%></td>
            <td class="DataTable1" nowrap rowspan="<%=vStr.size()%>" ><%=vOrdDate.get(i)%></td>
            <td class="DataTable1" nowrap rowspan="<%=vStr.size()%>" ><%=vPayAmt.get(i)%></td>
            <td class="DataTable1" nowrap rowspan="<%=vStr.size()%>" ><%=vShipName.get(i)%></td>            
            <td class="DataTable1" nowrap rowspan="<%=vStr.size()%>" ><%=vEmail.get(i)%></td>
            <td class="DataTable1" nowrap rowspan="<%=vStr.size()%>" ><%=vShipZip.get(i)%></td>
            <td class="DataTable1" nowrap rowspan="<%=vStr.size()%>" ><%=vShipMth.get(i)%></td>
            
            <%for(int j=0; j < vStr.size(); j++ ){%>
               <%if(j > 0){%></tr><tr id="trProd" class="<%=sClass%>"><%}%>
               <td class="DataTable2" nowrap ><%=vStr.get(j)%></td>
               <td class="DataTable2" nowrap ><%=vSku.get(j)%></td>
               <td class="DataTable2" nowrap ><%=vSn.get(j)%></td>
               <td class="DataTable1" nowrap ><%=vSts.get(j)%></td>
               <td class="DataTable1" nowrap ><%=((String) vDesc.get(j)).toLowerCase()%></td>
               <td class="DataTable1" nowrap ><%=((String) vVen.get(j)).toLowerCase()%></td>
               <td class="DataTable2" nowrap ><%=vRet.get(j)%></td>
               <td class="DataTable2" nowrap ><%=vPackId.get(j)%></td>
               <%if(j == 0){%><td class="DataTable1" nowrap rowspan="<%=vStr.size()%>" ><%=vComplete.get(i)%></td><%}%>
            <%}%>                   
         </tr>         
       <%}%>
    <%}%>       
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
