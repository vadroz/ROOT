<%@ page import="storepettycash.StrPtyCashDayLog, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelStr = request.getParameter("Str");
   String sEndDate = request.getParameter("Date");
   if(sEndDate==null){sEndDate = "END";}
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=StrPtyCashDayLog.jsp.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	StrPtyCashDayLog stptlog = new StrPtyCashDayLog(sSelStr, sEndDate, sUser);
	int iNumOfEnt = stptlog.getNumOfEnt();
	
	 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Petty Cash Log</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Store = "<%=sSelStr%>"; 

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//save daily log
//==============================================================================
function validateDaylyLog()
{
	 var error=false;
	 var msg = "";
	 var errmsg = document.all.tdError;
	 var br = "";
	 errmsg.innerHTML = "";
	
	 cash = document.all.Cash.value.trim();
	 if(cash==""){ error=true; msg += br + "The Cash amount cannot be blank"; br = "<br>"; }
	 else if(isNaN(cash)){ error=true; msg += br + "The Cash amount is not numeric"; br = "<br>"; }
	 
	 check = document.all.Check.value.trim();
	 if(check==""){ error=true; msg += br + "The Check amount cannot be blank"; br = "<br>"; }
	 else if(isNaN(check)){ error=true; msg += br + "The Check amount is not numeric"; br = "<br>"; }
	 
	 var action = "Add";	 
	 
	 if(error){ errmsg.innerHTML = msg; }
	 else{ saveDaylyLog(cash, check, action); }
}
//==============================================================================
// save daily log
//==============================================================================
function saveDaylyLog(cash, check, action)
{
	var url = "StrPtyCashDayLogSv.jsp?Str=" + Store
	 + "&Cash=" + cash
	 + "&Check=" + check
	 + "&Action=" + action
	;
	 
	window.frame1.location.href=url;
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trDtl19">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Store Petty Cash Reconciliation Log Entries 
            <br>Store: <%=sSelStr%>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="StrPtyCashDayLogSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;                                 
          </th>
        </tr>
        <tr>
          <td>  
          <br>
          <table class="tbl09" border=1>
           <tr class="trHdr01">
             <td class="td48" nowrap>Cash: &nbsp; <input name="Cash" size=11 maxlength=10></td>           
             <td class="td48" nowrap>Check: &nbsp; <input name="Check" size=11 maxlength=10></td>
             <td class="td48" nowrap><button onclick="validateDaylyLog()">Save</button></td>
           </tr>
           <tr class="trHdr01">
           		<td class="tdError" id="tdError" colspan=4></td>           
           </tr>
          </table> 
        
      <br>    
      <table class="tbl09" border=1>
        <tr class="trHdr01">
        	<th class="th02">Date</th>
        	<th class="th02">Time</th>
        	<th class="th02">User</th>
        	<th class="th02">Paid</th>
        	<th class="th02">Cash</th>
        	<th class="th02">Check</th>
        	<th class="th02">Total</th>
        	<th class="th02">Budget</th>
        	<th class="th02">Var</th>
        </tr>
         
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfEnt; i++) {        	    
        	   	stptlog.setDayLog();
           		String sPaid = stptlog.getPaid();
           		String sCash = stptlog.getCash();
           		String sCheck = stptlog.getCheck();
           		String sSpUser = stptlog.getUser();
            	String sDate = stptlog.getDate();
            	String sTime = stptlog.getTime();
           		String sTotal = stptlog.getTotal();
           		String sBudget = stptlog.getBudget();
           		String sVar = stptlog.getVar();
           		if(sTrCls.equals("trDtl04")){sTrCls = "trDtl06";}
           		else{ sTrCls = "trDtl04"; }
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
           	 <td class="td48" nowrap><%=sDate%></td>
           	 <td class="td48" nowrap><%=sTime%></td>
           	 <td class="td48" nowrap><%=sSpUser%></td>
             <td class="td48" nowrap><%=sPaid%></td>
             <td class="td48" nowrap><%=sCash%></td>
             <td class="td48" nowrap><%=sCheck%></td>
             <td class="td48" nowrap><%=sTotal%></td>
             <td class="td48" nowrap><%=sBudget%></td>
             <td class="td48" nowrap><%=sVar%></td>   
           </tr>
           <%}%>
             
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
stptlog.disconnect();
stptlog = null;
}
%>