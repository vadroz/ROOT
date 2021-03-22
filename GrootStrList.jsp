<%@ page import="grassroots.GrootStrList, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*"%>
<%
   	String [] sSelStr = request.getParameterValues("Str");
	String sYear = request.getParameter("Year");
	String sHalf = request.getParameter("Half");
	String sSort = request.getParameter("Sort");
   
   if(sSort == null  || sSort.equals("")) {sSort = "Reg";}
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=GrootStrList.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	GrootStrList grstrl = new GrootStrList();    
	grstrl.setGrassRoot(sSelStr, sYear, sHalf, sUser);
	
	int iNumOfStr = grstrl.getNumOfStr();
	String [] sStr = grstrl.getStr();
	String [] sStrReg = grstrl.getStrReg();
	int iNumOfReg = grstrl.getNumOfReg();
	String [] sReg = grstrl.getStr();   	
	
	int iNumOfType = grstrl.getNumOfType();
	String [] sType = grstrl.getType();
	String [] sTypeNm = grstrl.getTypeNm();	
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
var SelStr = [<%=grstrl.cvtToJavaScriptArray(sStr)%>];
var Year = "<%=sYear%>";
var Half = "<%=sHalf%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";

var NumOfReg = "<%=iNumOfReg%>";
var NumOfStr = "<%=iNumOfStr%>";
var NumOfType = "<%=iNumOfType%>";
var Type = [<%=grstrl.cvtToJavaScriptArray(sType)%>];
var TypeNm = [<%=grstrl.cvtToJavaScriptArray(sTypeNm)%>];

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
function setBudget(str, argt, bdg, action)
{
	var hdr = "Store: " + str + " / " + TypeNm[argt];
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td colspan=2>" + popStrBdg(str, Type[argt], bdg, action)
	     + "</td></tr>"
	   + "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "150";}
	else { document.all.dvItem.style.width = "auto";}
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left=getLeftScreenPos() + 300;
	document.all.dvItem.style.top=getTopScreenPos() + 100;
	document.all.dvItem.style.visibility = "visible";
	
	if(action=="UPDBDG")
	{
		var bdgf = document.getElementById("Bdg");
		bdgf.value = bdg; 
	}
}
//==============================================================================
//populate store budget
//==============================================================================
function popStrBdg(str, type, bdg, action)
{	
	var panel = "<table class='tbl02' width='100%'>";
	panel += "<tr class='trDtl04'>"
		 + "<td nowrap class='Medium'colspan=10>Budget: "
		    + "<input class='Small' name='Bdg' id='Bdg' size=13 maxlength=10>&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;"
		 + "</td>"
	  + "</tr>"
	
  	panel += "<tr class='trDtl04'>"
	      + "<td id='tdErrorAll' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
	    + "</tr>"

	panel += "<tr class='trDtl04'>"
	      + "<td nowrap class='Small' colspan=10><button onClick='vldStrBdg("
	         + "&#34;" + str + "&#34;"
	         + ",&#34;" + type + "&#34;"
	         + ",&#34;" + action + "&#34;"
	         + ")' class='Small' id='btnStrBdg'>Submit</button>"
	         + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
		  + "</td></tr>"
	
	return panel;	  
}
//==============================================================================
// validate store budget
//==============================================================================
function vldStrBdg(str, type, action)
{
	var error = false;
	var msg = "";
	var numsel = 0;
	var br = "";
	document.all.tdErrorAll.innerHTML = "";
	document.all.btnStrBdg.disabled = true;	
	
	var bdg = document.getElementById("Bdg").value.trim();
	if(bdg == ""){ error= true; msg += br + "Please enter Budget amount"; br ="<br>";}
	else if(isNaN(bdg)){ error= true; msg += br + "The Budget amount is not numeric"; br ="<br>";}
	else if(eval(bdg) < 0){ error= true; msg += br + "The Budget amount must be a positive."; br ="<br>";}
	
	if(error)
	{
		document.all.tdErrorAll.innerHTML = msg; 
		document.all.btnStrBdg.disabled = false; 
	}
	else if(!error){ sbmstrBdg(str, type, bdg, action); }
}
//==============================================================================
// submit budget amount add/update
//==============================================================================
function sbmstrBdg(str,type,bdg,action)
{
	url = "GrootSv.jsp?Str=" + str
	 + "&Year=<%=sYear%>"
	 + "&Half=<%=sHalf%>"
	 + "&Type=" + type
	 + "&Bdg=" + bdg
	 + "&Action=" + action
	;
	
	if(isIE || isSafari){ window.frame1.location.href = url; }
    else if(isChrome || isEdge) { window.frame1.src = url; }
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
// show store
//==============================================================================
function showStr(str)
{
	url = "GrootStrDtl.jsp?Type=Y"
	      + "&Year=" + Year
	      + "&Half=" + Half
	      + "&Str=" + str 
	window.location.href=url;
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
          <th colspan=60>
            <b>Retail Concepts, Inc
            <br>Grassroot Store(s) Expenses  
            <br>
            Store(s): 
            <%String sComa = "";
              for(int i=0; i < sSelStr.length; i++){%>
              <%=sComa + sSelStr[i]%><%sComa=", ";%>
            <%}%>
            <br>Fiscal Year: <%=sYear%> 
            <%if(sHalf.equals("1")){%>Quarter: 1,2<%} else{%>Quarter: 3,4<%}%>           
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="GrootStrListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
          </th>
        </tr>
                 
        <tr>
          <td>  
       <table class="tbl02">
       	<tr class="trHdr01">
       		<th class="th22" rowspan=2>Str</th>
        	<%for(int j=0; j < iNumOfType; j++){%>
        		<th class="th22" colspan=3><%=sTypeNm[j]%></th>
        	<%}%>        	
       	</tr>
       	<tr class="trHdr01">       		
       		<%for(int j=0; j < iNumOfType; j++){%>
        		<th class="th02">Budget</th>
        		<th class="th02">Spend</th>
        		<th class="th22">Balance</th>
        	<%}%>
       	</tr>
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = sStrReg[0];
             String sTrCls = "trDtl06"; 
             int iArg = -1;
             int iReg = -1;                          
           %>
           
           <%for(int i=0; i < iNumOfStr; i++) 
             {
        	   	grstrl.setStrSpend();
        	   	String [] sSpend = grstrl.getSpend();
        		String [] sBudget = grstrl.getBudget();
        		String [] sBallance = grstrl.getBallance();
           	%>                           
           	<tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             	<td id="tdStr<%=i%>" class="td59" nowrap>
             		<a href="javascript: showStr('<%=sStr[i]%>')"><%=sStr[i]%></a>
             	</td>
             	<%for(int j=0; j < iNumOfType; j++){%>
             		<td class="td12" nowrap>
             	   		<%if(bAllow){%>
             		  		<%if(sBudget[j].equals(".00")){%><a href="javascript: setBudget('<%=sStr[i]%>','<%=j%>','0', 'ADDBDG')">Add</a>
             	      		<%} else { %><a href="javascript: setBudget('<%=sStr[i]%>','<%=j%>', '<%=sBudget[j]%>','UPDBDG')"><%=sBudget[j]%></a><%}%>
             	   		<%} else {%><%=sBudget[j]%><%}%>
             		</td>
             		<td class="td12" nowrap><%=sSpend[j]%></td>
             		<td class="td58" nowrap><%=sBallance[j]%></td>
             	<%}%>        	 	
             </tr>
             
             <!-- =========== Region Total ============= -->  
             <%if(i < iNumOfStr - 1 && !sStrReg[i].equals(sStrReg[i+1]) || i == iNumOfStr - 1){
               		grstrl.setRegTot(sStrReg[i]);
               		sSpend = grstrl.getSpend();
            		sBudget = grstrl.getBudget();
            		sBallance = grstrl.getBallance();
         			iReg++;
             %>
             <tr class="trDtl12">
             	<td class="td59" nowrap>District <%=sStrReg[i]%></td>
             	  <%for(int j=0; j < iNumOfType; j++){%>
             		<td class="td12" nowrap><%=sBudget[j]%></td>
             		<td class="td12" nowrap><%=sSpend[j]%></td>             	
             		<td class="td58" nowrap><%=sBallance[j]%></td>
             	  <%}%>
             </tr>
             <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
             <%
             	if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
 				else {sTrCls = "trDtl06";}
               }%>  
           <%}%>
           
           <!-- =========== Report Total ============= -->  
           <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
           <% 	
           		grstrl.setRepTot();
           		String [] sSpend = grstrl.getSpend();
   				String [] sBudget = grstrl.getBudget();
   				String [] sBallance = grstrl.getBallance();
         	%>
             <tr class="trDtl12">
             	<td class="td59" nowrap>Report Totals</td>
             	<%for(int j=0; j < iNumOfType; j++){%>             		
             		<td class="td12" nowrap><%=sBudget[j]%></td>
             		<td class="td12" nowrap><%=sSpend[j]%></td>             	
             		<td class="td58" nowrap><%=sBallance[j]%></td>
             	<%}%>	
             </tr>             
         </table>
      <!----------------------- end of table ------------------------>
      <br>
                
       
      </tr>
   </table>
 </body>
</html>
<%
grstrl.disconnect();
grstrl = null;
}
%>