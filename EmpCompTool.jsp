<%@ page import="payrollreports.EmpCompTool, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*"%>
<%
   	String sSelStr = request.getParameter("Str");
	
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=EmpCompTool.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	EmpCompTool comptool = new EmpCompTool(sSelStr, " ", "vrozen");

    int iNumOfMn = comptool.getNumOfMn();
    String [] sMnName = comptool.getMnName();
    String [] sMnBeg = comptool.getMnBeg();
    String [] sMnEnd = comptool.getMnEnd();
    
    String sCompRate = comptool.getCompPrc();
    String [] sSlsPerHr = comptool.getSlsPerHr();
    String [] sComRate = comptool.getComRate();
    String [] sSpiffAvg = comptool.getSpiffAvg();
    String [] sTotRate = comptool.getTotRate();
    
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Sls Comp Tool</title>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT>
//--------------- Global variables ----------------------- 
var User = "<%=sUser%>"; 

var CompPrc = "<%=sCompRate%>";
var SlsPerHr = [<%=comptool.cvtToJavaScriptArray(sSlsPerHr)%>];
var ComRate = [<%=comptool.cvtToJavaScriptArray(sComRate)%>];
var Spiff = [<%=comptool.cvtToJavaScriptArray(sSpiffAvg)%>];

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	 if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	 else{ setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]); }	 
}
//==============================================================================
//calculate total rate on new base rate
//==============================================================================
function calcTotRt()
{
	var newRate = document.all.Base.value.trim();
	if(isNaN(newRate) || newRate == "")
	{ 
		newRate = 0; document.all.Base.value = "";
	}
	
	var sph = document.all.SPH;
	var cprc = document.all.ComPrc;
	var comrt = document.all.tdComRate;
	var spiff = document.all.tdSpiff;
	var base = document.all.spnBase;
	var total = document.all.spnTotal;
	
	var tot = eval("0"); 
	var nummon = eval("0");
	for(var i=0; i < 12; i++)
	{ 
		if(document.all.inpChk[i].checked)
		{			
			tot += eval(sph[i].value);
			nummon++;			
		}
	}
	if(nummon == 0){ nummon = 1; }
	sph[12].value = (tot / nummon).toFixed(2);   
	
	tot = eval("0"); 
	for(var i=0; i < 12; i++)
	{ 
		if(document.all.inpChk[i].checked)
		{
			tot += eval(cprc[i].value);
		}
	}
	cprc[12].value = (tot / nummon).toFixed(2);
	
	tot = eval("0"); 
	for(var i=0; i < 12; i++)
	{ 
		if(document.all.inpChk[i].checked)
		{
			tot += eval(comrt[i].value);
		}
	}
	comrt[12].value = (tot / nummon).toFixed(2);
	
	tot = eval("0"); 
	for(var i=0; i < 12; i++)
	{ 
		if(document.all.inpChk[i].checked)
		{
			tot += eval(spiff[i].innerHTML);
		}
	}
	spiff[12].innerHTML = (tot / nummon).toFixed(2);
	
	 
	for(var i=0; i < 13; i++)
	{		
		var res1 = eval("0");
		if(i==12 || document.all.inpChk[i].checked)
		{
			res1 = eval(sph[i].value * cprc[i].value) /  100;
		}	
		var res2 = res1 + eval(spiff[12].innerHTML);
		var res3 = res2 + eval(newRate);
		comrt[i].innerHTML = res1.toFixed(2);
		base[i].innerHTML = newRate; 
		total[i].innerHTML = res3.toFixed(2);
				
	}
}
//==============================================================================
//calculate total rate on new base rate
//==============================================================================
function reset()
{		  
	var sph = document.all.SPH;
	var cprc = document.all.ComPrc;
	var comrt = document.all.tdComRate;
	var base = document.all.spnBase;
	var total = document.all.spnTotal;
	var monChk = document.all.inpChk;
	
	for(var i=0; i < 13; i++)
	{
		sph[i].value = SlsPerHr[i];
		cprc[i].value = CompPrc;
		comrt[i].innerHTML = ComRate[i]; 
		base[i].innerHTML = "";
		total[i].innerHTML = "";
	}	
}
//==============================================================================
//uncheck month selection
//==============================================================================
function checkMon(check)
{
	var monChk = document.all.inpChk;
	
	for(var i=0; i < 12; i++)
	{
		monChk[i].checked = check;
	}
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
        <tr>
          <th>
            <b>Retail Concepts, Inc
            <br>Salesperson Compensation Tool <sup>*</sup>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="EmpCompToolSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              <br><br>
              Enter Base Pay per Hr. <input class="Small" name="Base" maxlength=4 size="6">
              <button onclick="calcTotRt()">Calculate</button>
              <button onclick="reset()">Reset</button>
              <br><br>Store: <%=sSelStr%>
          </th>
        </tr>       
        <tr>        
          <td style="text-align:center;">
            &nbsp;<br>&nbsp;<br> 
        <b>Rolling 12 Months</b>    
       <table class="tbl04">
       <tr class="trHdr01">
       	  <th class="th07">&nbsp;</th>
          <%for(int i=0; i < iNumOfMn; i++){%>
           	<th class="th02"><%=sMnName[i]%></th>
          <%}%>            
          <th class="th02">Average</th>
       </tr>
       
       <tr class="trHdr01">
       	  <th class="th07">Included Month <sup>7)</th>
          <%for(int i=0; i < iNumOfMn; i++){%>
           	<th class="th02"><input name="inpChk" type="checkbox" checked></th>
          <%}%>            
          <th class="th02">
          	<a class="Small" href="javascript: checkMon(true)">check</a> &nbsp;
          	/ &nbsp;
          	<a class="Small" href="javascript: checkMon(false)">uncheck</a>
          </th>
       </tr>
       
  <!-- ======================================================================== -->
       <!-- ======== SPH ======== -->       
       <tr class="trDtl04">
          <th class="th07"  >SPH <sup>1)</sup> &nbsp;</th>
          <%for(int i=0; i < iNumOfMn + 1; i++){%>
          	<td class="td12" id="tdSph"><input class="Small" name="SPH" value="<%=sSlsPerHr[i]%>" maxlength=7 size=9></td>
          <%}%>
       </tr>
       
       <!-- ======== Commission % (per Store) ======== -->
       <tr class="trDtl04">
          <th class="th07">Comm % <sup>2)</sup> &nbsp;</th>
          <%for(int i=0; i < iNumOfMn + 1; i++){%>
          	<td class="td12" id="tdCompRt"><input class="Small" name="ComPrc" value="<%=sCompRate%>" maxlength=4 size=6></td>
          <%}%>
       </tr>
       
       <!-- ======== Commission Rate  ======== -->
       <tr class="trDtl04">
          <th class="th07">Comm Pay per Hr. <sup>3)</sup> &nbsp;</th>
          <%for(int i=0; i < iNumOfMn + 1; i++){%>
          	<td class="td12" id="tdComRate"><%=sComRate[i]%></td>
          <%}%>
       </tr>
       
       <!-- ======== Spiff Average Rate  ======== -->
       <tr class="trDtl04">
          <th class="th07">Spiff Pay per Hr. <sup>4)</sup> &nbsp;</th>
          <%for(int i=0; i < iNumOfMn + 1; i++){%>
          	<td class="td12" id="tdSpiff"><%=sSpiffAvg[i]%></td>
          <%}%>
       </tr>       
      
      
      <!-- ======== Base Rate  ======== -->
       <tr class="trDtl04">
          <th class="th07" >Base Pay per Hr. <sup>5)</sup> &nbsp;</th>
          <%for(int i=0; i < iNumOfMn+ 1; i++){%>
          	<td class="td12" id="tdBase"><span class="Small" id="spnBase"></td>
          <%}%>          
       </tr>
       
       <!-- ======== Total Rate  ======== -->
       <tr class="trDtl03">
          <th class="th07">Total Pay per Hr. <sup>6)</sup> &nbsp;</th>
          <%for(int i=0; i < iNumOfMn + 1; i++){%>
          	<td class="td12" id="tdTotal"><span class="Small" id="spnTotal"></span></td>
          <%}%>          
       </tr>  
       <tr class="trDtl04">
         <td class="td11" colspan=14>&nbsp;<br>
         1) SPH: By default this is from Selling Coordinators and Non Coordinator Selling actuals, but can be adjusted up or down to model different selling productivity.
	 <br>2) Comm %: By default this is 2%, but can be adjusted to reflect Peak Performer %.
     <br>3) Comm Pay per Hr.: This is the SPH x the Comm %
     <br>4) Spiff Pay per Hr.: This comes from paid spiffs to Selling Coordinators and Non Coordinator Selling and does NOT include labor spiffs.
     <br>5) Base Pay per Hr.: This is from the top input.
     <br>6) Total Pay per Hr.: This is the sum of Commission + Spiff's + Base Pay per Hr.
     <br>7) You can calculate partial year averages for seasonal employees. Check the boxes for the months they will work to adjust the average.  
         </td>
      </tr>        
      </table>      
            <!----------------------- end of report ------------------------>
       <br><span style="font-size:10px;">
       * Please remember this tool is for modeling potential pay based off of historical avgs. and does not guarantee actual pay.
       </span>     
      </tr>
         
   </table>
    
 </body>
</html>
<%
comptool.disconnect();
comptool = null;
}
%>