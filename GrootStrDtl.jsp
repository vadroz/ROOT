<%@ page import="grassroots.GrootStrDtl, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*"%>
<%
   	String sSelStr = request.getParameter("Str");
	String sYear = request.getParameter("Year");
	String sHalf = request.getParameter("Half");
	String sSort = request.getParameter("Sort");
   
   if(sSort == null  || sSort.equals("")) {sSort = "Reg";}
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=GrootStrDtl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	GrootStrDtl grstrd = new GrootStrDtl();    
	grstrd.setGrassRoot(sSelStr, sYear, sHalf, "vrozen");
	
	int iNumOfDtl = grstrd.getNumOfDtl();  
	
	int iNumOfType = grstrd.getNumOfType();
	String [] sType = grstrd.getType();
	String [] sTypeNm = grstrd.getTypeNm();	
	
	boolean bAllow = sStrAllowed.startsWith("ALL");
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Grassroots Expenses</title>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT>
//--------------- Global variables -----------------------
var SelStr = "<%=sSelStr%>";
var Year = "<%=sYear%>";
var Half = "<%=sHalf%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";

var NumOfType = "<%=iNumOfType%>";
var Type = [<%=grstrd.cvtToJavaScriptArray(sType)%>];
var TypeNm = [<%=grstrd.cvtToJavaScriptArray(sTypeNm)%>];
 
 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	 if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	 {
		 isSafari = true;
		 setDraggable();
	 }
	 else
	 {
	 	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
	 }	 
}
//==============================================================================
// set budget for store
//==============================================================================
function setExpense(argt, date, id, spend, desc, action)
{	
	var hdr = "Add Expense. " + TypeNm[argt];
	if(action == "UPDEXP"){ hdr = "Update Expense" + TypeNm[argt];}
	else if(action == "DLTEXP"){ hdr = "Delete Expense" + TypeNm[argt];}
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td colspan=2>" + popExpense(Type[argt], date, id, action)
	     + "</td></tr>"
	   + "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
	else { document.all.dvItem.style.width = "auto";}
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left=getLeftScreenPos() + 300;
	document.all.dvItem.style.top=getTopScreenPos() + 100;
	document.all.dvItem.style.visibility = "visible";
	
	if(action=="UPDEXP")
	{
		 document.all.ExpDate.value = date;	
		 document.all.Spend.value = spend;
		 desc = replaceAll(desc, "@#@", "'");
		 desc = replaceAll(desc, "#@#", "\"");
		 document.all.Desc.value = desc;		 
	}
	else if(action=="DLTEXP")
	{
		 document.all.ExpDate.value = date;
		 document.all.Spend.value = spend;
		 desc = replaceAll(desc, "@#@", "'");
		 desc = replaceAll(desc, "#@#", "\"");
		 document.all.Desc.value = desc;
		 
		 document.all.ExpDate.readOnly = true;
		 document.all.Spend.readOnly = true;
		 document.all.Desc.readOnly = true;
	}
	else if(action=="ADDEXP")
	{
		doSelDate();
	}
}

//==============================================================================
//populate expense
//==============================================================================
function replaceAll(str, search, replacement)
{
    var target = str;
    return target.replace(new RegExp(search, 'g'), replacement);
};
//==============================================================================
//populate expense
//==============================================================================
function popExpense(type, date, id, action)
{	
	var panel = "<table  class='tbl02'>";
	panel += "<tr class='trDtl04'>"
		 + "<td nowrap class='td07'>Date:</td>"
		 + "<td nowrap class='td08'>"
	;
		 
    if(action=="ADDEXP")
    { 
    	panel += "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ExpDate&#34;)'>&#60;</button>" 
    }	
    panel += "<input name='ExpDate' id='ExpDate' type='text' size=10 maxlength=10 readonly>";
	 	
    if(action=="ADDEXP")
    { 
    	  panel += "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;ExpDate&#34;)'>&#62;</button>"
         	+ "&nbsp;<a id='linkCal' href='javascript:showCalendar(1, null, null, 800, 300, document.all.ExpDate)'>"
         	+ "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>";
    }     	
         	
	panel += "</td>"
	  + "</tr>"
	  + "<tr class='trDtl04'>"
		 + "<td nowrap class='td07'>Spend:</td>"
		 + "<td nowrap class='td08'>"
		    + "<input class='Small' name='Spend' id='Spend' size=10 maxlength=10>"
		 + "</td>"
	  + "</tr>"
	  + "<tr class='trDtl04'>"
		 + "<td nowrap class='td07'>Description:</td>"
		 + "<td nowrap class='td08'>"
		    + "<TextArea class='Small' name='Desc' id='Desc' cols=50 rows=5 maxlength='256'></TextArea>"
		 + "</td>"
	  + "</tr>"
	
  	panel += "<tr class='trDtl04'>"
	      + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
	    + "</tr>"

	panel += "<tr class='trDtl04'>"
	   + "<td nowrap class='Small' colspan=2><button onClick='vldStrExp("
	         + "&#34;" + type + "&#34;"
	         + ",&#34;" + id + "&#34;"
	         + ",&#34;" + action + "&#34;"
	         + ")' class='Small' id='btnStrExp'>Submit</button> &nbsp; "
	         + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	   + "</td></tr>"
	
	return panel;	  
}
//==============================================================================
// validate store budget
//==============================================================================
function vldStrExp(type, id, action)
{
	var error = false;
	var msg = "";
	var numsel = 0;
	var br = "";
	document.all.tdError.innerHTML = "";
	document.all.btnStrExp.disabled = true;	
	
	var date = document.getElementById("ExpDate").value.trim();
	
	var spend = document.getElementById("Spend").value.trim();
	if(spend == ""){ error= true; msg += br + "Please enter Spend amount"; br ="<br>";}
	else if(isNaN(spend)){ error= true; msg += br + "The Spend amount is not numeric"; br ="<br>";}
	else if(eval(spend) < 0){ error= true; msg += br + "The Spend amount must be a positive."; br ="<br>";}
	
	var desc = document.getElementById("Desc").value.trim();
	
	if(error)
	{
		document.all.tdError.innerHTML = msg; 
		document.all.btnStrExp.disabled = false; 
	}
	else if(!error){ sbmstrBdg(type,id,date,spend,desc,action); }
}
//==============================================================================
// submit budget amount add/update
//==============================================================================
function sbmstrBdg(type,id,date,spend,desc,action)
{
	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
	
    nwelem.id = "dvSbmStrExp"

    var html = "<form name='frmStrExpense'"
       + " METHOD=Post ACTION='GrootSv.jsp'>"
       + "<input name='Str'>"
       + "<input name='Year'>"
       + "<input name='Half'>"
       + "<input name='Date'>"
       + "<input name='Id'>"
       + "<input name='Type'>"
       + "<input name='Spend'>"
       + "<input name='Desc'>"
       + "<input name='Action'>"
     ;  
    html += "</form>"

   	nwelem.innerHTML = html;
    if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
    else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
    else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
    else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   	if(isIE || isSafari)
	{
   		window.frame1.document.all.Str.value = SelStr;
   		window.frame1.document.all.Year.value = Year;
   		window.frame1.document.all.Half.value = Half;
   		window.frame1.document.all.Date.value = date;
   		window.frame1.document.all.Id.value = id;
   		window.frame1.document.all.Type.value = type;
   		window.frame1.document.all.Spend.value = spend;
   		window.frame1.document.all.Desc.value = desc;  		
   		window.frame1.document.all.Action.value=action;   	    
   		
   		window.frame1.document.frmStrExpense.submit();
	}
   	else
   	{
   		window.frame1.contentDocument.forms[0].Str.value = SelStr;	
   		window.frame1.contentDocument.forms[0].Date.value = date;
   		window.frame1.contentDocument.forms[0].Id.value = id;
   		window.frame1.contentDocument.forms[0].Type.value = type;
   		window.frame1.contentDocument.forms[0].Spend.value = spend;
   		window.frame1.contentDocument.forms[0].Desc.value = desc;
   		window.frame1.contentDocument.forms[0].Action.value=action;
   		
   	    window.frame1.contentDocument.forms[0].submit();
   	}
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
//populate date with yesterdate
//==============================================================================
function doSelDate()
{
	var date = new Date(new Date() - 86400000);
	var dofw = date.getDay();   
	date = new Date(date - 86400000 * (dofw - 7));
	document.all.ExpDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
	var button = document.all[id];
	var date = new Date(button.value);
	date.setHours(18);

	if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
	else if(direction == "UP") date = new Date(new Date(date) - -86400000);
	button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trDtl19">
          <th >
            <b>Retail Concepts, Inc
            <br>Grassroot Store Expenses  
            <br>
            Store: <%=sSelStr%> 
            <br>Fiscal Year: <%=sYear%> 
            <%if(sHalf.equals("1")){%>Quarter: 1,2<%} else{%>Quarter: 3,4<%}%>           
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="GrootStrListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;               
          </th>
        </tr>
                 
        <tr class="trDtl19">
          <td align="center"> 
          <%if(bAllow){%>
            <br>
          	<%for(int j=0; j < iNumOfType; j++){%>
          		<b><%=sTypeNm[j]%>&nbsp;<a href="javascript: setExpense('<%=j%>',null, '0','0', null, 'ADDEXP')">New Entry</a> &nbsp; &nbsp; &nbsp;</b>           	 
          	<%}%>
          	<br>&nbsp;
          <%}%>
           
       <table class="tbl02">
       	<tr class="trHdr01">
       		<th class="th02">Date</th> 
        	<th class="th02">Spend</th>
        	<th class="th02">Description</th>
        	<th class="th02">Update</th>
        	<th class="th02">Delete</th>
       	</tr>
<!------------------------------- order/sku --------------------------------->           
           <%String sTrCls = "trDtl04";
           	 String sSvType = "";
           	 int iType = 0;
             for(int i=0; i < iNumOfDtl; i++) 
             {            	 
        	   	grstrd.setStrSpend();
        	   	String sExpTy = grstrd.getExpTy();
        	   	String sDate = grstrd.getDate();
        	   	String sId = grstrd.getId();
        		String sSpend = grstrd.getSpend();
        		String sDesc = grstrd.getDesc();
        		
        		String sDescRpl = sDesc.replaceAll("'", "@#@");
        		sDescRpl = sDescRpl.replaceAll("\"", "#@#");
        		
           	%>  
           	 <%if(!sSvType.equals(sExpTy)){
           		String sTyName = "";
           		String sCurTy = "";
           		for(int j=0; j < iNumOfType; j++)
           		{
           			if(sType[j].equals(sExpTy))
           			{ 
           				sTyName = sTypeNm[j];
           				sCurTy =  sType[j];
           				iType = j;
           				break;
           			}
           		}    
           		if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
 				else {sTrCls = "trDtl06";}
           	 %>
           	  	<tr class="trHdr04">       				
       				<th class="th02" colspan=5><%=sTyName%></th>
       			</tr>	           	     
           	 <%}%>           
           	 <tr id="trGrp<%=i%>" class="<%=sTrCls%>">             	
             	<td class="td11" nowrap><%=sDate%></td>
             	<td class="td12" nowrap><%=sSpend%></td>
             	<td class="td11"><%=sDesc%></td>        	 	
             	<td class="td12" nowrap><a href="javascript: setExpense('<%=iType%>','<%=sDate%>', '<%=sId%>', '<%=sSpend%>', '<%=sDescRpl%>', 'UPDEXP')">Update</a></td>
             	<td class="td12" nowrap><a href="javascript: setExpense('<%=iType%>','<%=sDate%>', '<%=sId%>', '<%=sSpend%>', '<%=sDescRpl%>', 'DLTEXP')">Delete</a></td>
             </tr>  
           
           
           <!-- =========== Report Total ============= -->         
           <%
             if(!sSvType.equals(sExpTy))
             {
          		sSvType = sExpTy;
           		grstrd.setRepTot(iType+1);
   				sSpend = grstrd.getSpend();
   				sDesc = grstrd.getDesc();
             }	
         	%>         	 
             <tr class="trDtl12">
             	<td class="td11" nowrap>Report Totals</td>
             	<td class="td12" nowrap><%=sSpend%></td>             	
             	<td class="td12" nowrap>&nbsp;</td>
             	<td class="td12" nowrap>&nbsp;</td>
             	<td class="td12" nowrap>&nbsp;</td>
             </tr>
             <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
           <%}%>               
         </table>
      <!----------------------- end of table ------------------------>
      <br>
                
       
      </tr>
   </table>
 </body>
</html>
<%
grstrd.disconnect();
grstrd = null;
}
%>