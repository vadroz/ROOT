<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*
,rciutility.CallAs400SrvPgmSup"%>
<%
   String sSrchRf = request.getParameter("rf");
   String sSrchDStr = request.getParameter("dstr");
   String sSrchFrDt = request.getParameter("frdt");
   String sSrchToDt = request.getParameter("todt");
      
   if(sSrchRf == null)  { sSrchRf = "";   }
   if(sSrchDStr == null){ sSrchDStr = ""; }
   if(sSrchFrDt == null){ sSrchFrDt = ""; }
   if(sSrchToDt == null){ sSrchToDt = ""; }
   
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RfPackCtnInq.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   	String sUser = session.getAttribute("USER").toString();
   	String sStrAllowed = session.getAttribute("STORE").toString();
   	
   	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   	
   	String sRfCode, sCarton, sWhs, sCnCtl, sDstStr, sPickSts, sQty
      , sCnSts, sCnStsDt, sCnStsTm, sCmpFlag, sCmpDt, sCmpTm;   	
   	
   	String sStmt = "";
   	 
   	
%>
<html>

<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />

<title>RF Pack Inquiry</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<SCRIPT>
//--------------- Global variables -----------------------
var SrchRf = "<%=sSrchRf%>";
var SrchDStr = "<%=sSrchDStr%>";
var SrchFrDt = "<%=sSrchFrDt%>";
var SrchToDt = "<%=sSrchToDt%>";

var LastAction = "";

var NwRfCode = "";

var ExRfCode = "";
 
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvCont", "dvItem", "dvComment"]);
	 	
	 
	doSelDate();
	
	document.all.RfCode.value = SrchRf;
	document.all.DStr.value = SrchDStr;
	
	document.all.RfCode.focus();
	document.all.RfCode.select();
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function doSelDate()
{
	var date = new Date(new Date());
	if(SrchToDt != ""){ date = new Date( SrchToDt );  }
	date.setHours(18)
	document.all.ToDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

	date = new Date(date - 86400000 * 90);
	if(SrchFrDt != ""){ date = new Date( SrchFrDt );  }
	
	document.all.FromDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();    
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
// Hide selection screen
//==============================================================================
function hidePanel(obj)
{   
	if(document.all.CalendarMenu != null){ hidetip2(); }
	document.all[obj].innerHTML = " ";
   	document.all[obj].style.visibility = "hidden";   
}  

 		
//==============================================================================
//check serial number
//==============================================================================
function chkSrlNum(obj)
{
	e = window.event; 
    var keyCode = null;
    
    if(e != null ){ keyCode = e.keyCode || e.which; }
    if ( keyCode == '13' || obj.id=="btnSbmit")
    {
    	var rf = document.getElementById("RfCode").value;
    	var dstr = document.getElementById("DStr").value;
    	var frdt = document.getElementById("FromDt").value;
    	var todt = document.getElementById("ToDt").value;
    	
    	url = "RfPackCtnInq.jsp?rf=" + rf
    	  + "&dstr=" + dstr
    	  + "&frdt=" + frdt
    	  + "&todt=" + todt
    	window.location.href = url;
    }	
}
</SCRIPT>



</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div> 
<!-------------------------------------------------------------------->

    <table class="tbl01">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Carton RF Packing Inquiry
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       This Page. &nbsp; &nbsp;
       <br>
       <table>
         <tr>
         	<td style="text-align: right">RF:</td>
         	<td><input class="Small" name="RfCode" id="RfCode" size=12 maxlength=10 onkeypress="chkSrlNum(this)"></td>
         </tr>
         <tr>	
       		<td style="text-align: right">Destination Store:</td>
       		<td><input class="Small" name="DStr" id="DStr" size="7" maxlength="5"></td>       	
       	 </tr>
         <tr>
       		<td style="text-align: right">From:</td>
       		<td>
       		  <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDt')">&#60;</button>
              <input name="FromDt" id="FromDt" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDt')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 800, 100, FromDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>              
            </td>
       		<td style="text-align: right">&nbsp; To:</td>
            <td>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDt')">&#60;</button>
              <input name="ToDt" id="ToDt" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDt')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 1100, 100, ToDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            </td>
         </tr>
         <tr>
         	<td style="text-align: center" colspan=6>
          		<button id="btnSbmit" onclick="chkSrlNum(this)">Submit</button>
         	</td>
         </tr>
       </table>          
   <br>
   <br>
   <!----------------------- Order List ------------------------------>
     <table class="tbl02" id="tbEntry" width = "1000">
          <tr class="trHdr01">
     	      <th class="th13">Carton</th>
     	      <th class="th13">Carton<br>Sts</th>
     	      <th class="th13">Carton<br>Sts<br>Date/Time</th>
     	      <th class="th13">Dest<br>Str</th>
     	      <th class="th13">Whs</th>
     	      <th class="th13">Pick<br>Ctl</th>     	      
     	      <th class="th13">Qty</th>   
     	  </tr>
      <%
      if(!sSrchRf.equals(""))
      {
     		sStmt = "with cnlogf as ("
     		  + " select L##1, lctn, LDSS, liss, LCTL"
     		  + " from IpTsFil.IpCnLog"
     		  
     		  + " where L##1='" + sSrchRf + "'"
     		; 
     		
     		if(!sSrchDStr.equals("")){ sStmt += " and ldss=" + sSrchDStr; }
     		if(!sSrchFrDt.equals(""))
     		{ 
     			sStmt += " and LSTD >='" + sSrchFrDt + "'";
     			sStmt += " and LSTD <='" + sSrchToDt + "'";
     		}
     		
     		sStmt += "group by   L##1, lctn, LDSS, liss, LCTL" 
     		  + ")"
     	      + "select L##1, lctn, LDSS, liss, LCTL"
     	      + ", (select lSts from IpTsFil.IpCnLog b where a.l##1=b.l##1 and a.lctn=b.lctn order by lstd desc, lstt desc fetch first 1 row only)"
     	      + ", (select lStd from IpTsFil.IpCnLog b where a.l##1=b.l##1 and a.lctn=b.lctn order by lstd desc, lstt desc fetch first 1 row only)"
     	      + ", (select lStt from IpTsFil.IpCnLog b where a.l##1=b.l##1 and a.lctn=b.lctn order by lstd desc, lstt desc fetch first 1 row only)"
     	      + ", PKCTWHS, PKCTPC#,PKCTSTR, PKCTPKS, PKCTTQT, PKCTBDT, PKCTBTM, PKCTCFL, PKCTCDT, PKCTCTM"
     	      + " from cnlogf a"
     	      + " left join iptsmod.IPPKCTL99 on lctn=PKCTCTN "
     		  + " order by lctn";
     		
     		System.out.println("\n" + sStmt);

     	    RunSQLStmt sql_Item = new RunSQLStmt();
     	    sql_Item.setPrepStmt(sStmt);
     	    ResultSet rs_Item = sql_Item.runQuery();
     	    
     	    while(sql_Item.readNextRecord()) 
     	    {
     			sRfCode = sql_Item.getData("L##1").trim();
     			sCarton = sql_Item.getData("LCTN").trim();
     			sDstStr = sql_Item.getData("LDSS").trim();
     			
     			sCnSts = sql_Item.getData("lsts").trim();
     			sCnStsDt = sql_Item.getData("Lstd").trim();
     			sCnStsTm = sql_Item.getData("lstt").trim();
     			sCnCtl = sql_Item.getData("LCtl").trim(); 
     			
     			sWhs = sql_Item.getData("PKCTWHS");
     			if(sWhs == null){
     				sWhs = sql_Item.getData("LISS").trim();
     				sPickSts = "";
     				sQty = "";     			
     				sCmpFlag = "";
     				sCmpDt = "";
     				sCmpTm = "";
     			}
     			else
     			{
     				sPickSts = sql_Item.getData("PKCTPKS").trim();
     				sQty = sql_Item.getData("PKCTTQT").trim();     			
     				sCmpFlag = sql_Item.getData("PKCTCFL").trim();
     				sCmpDt = sql_Item.getData("PKCTCDT").trim();
     				sCmpTm = sql_Item.getData("PKCTCTM").trim();
     			}
     	%>
     	  	<tr class="trDtl04">
           		<td class="td11"><a href="CtnInq.jsp?Carton=<%=sCarton%>" target="_blank"><%=sCarton%></a></td>
           		<td class="td11" nowrap><%=sCnSts%></td>
           		<td class="td11" nowrap><%=sCnStsDt%>&nbsp;<%=sCnStsTm%></td>
           		<td class="td11"><%=sDstStr%></td>
           		<td class="td11"><%=sWhs%></td>
           		<td class="td11"><%=sCnCtl%></td>           		
           		<td class="td11"><%=sQty%></td>
           	</tr>	
       	<%}%> 
     <%}%>
    </table>    
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>


<%  
  }%>