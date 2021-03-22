<%@ page import="payrollreports.BdgVsSchAct, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*"%>
<%
   	String [] sSelStr = request.getParameterValues("Str");
	String sWkend = request.getParameter("Wkend");
	String sType = request.getParameter("Type");
	String sYear = request.getParameter("Year");
	String sSort = request.getParameter("Sort");
   
   if(sSort == null  || sSort.equals("")) {sSort = "Reg";}
   if(sWkend == null || sWkend.equals("")){sWkend = " ";}
   if(sYear == null  || sYear.equals("")) {sYear = " ";}
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=BdgVsSchAct.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	BdgVsSchAct schpay = new BdgVsSchAct();    
    schpay.setStrWeek(sSelStr , sType, sWkend, sYear, sUser);
	
	int iNumOfStr = schpay.getNumOfStr();
	String [] sStr = schpay.getStr();
	String [] sStrReg = schpay.getStrReg();
	int iNumOfReg = schpay.getNumOfReg();
	String [] sReg = schpay.getStr();
		
	int iNumOfWk = schpay.getNumOfWk();
	String [] sWeek = schpay.getWeek();
	
	int iNumOfGrp = schpay.getNumOfGrp();
	String [] sGrpName = schpay.getGrpName();  
	
   	if(sYear.trim().equals(""))
   	{
   		String sPrepStmt = "select pyr#, pmo#, pime, piwe from rci.fsyper"
		+ " where pida='" + sWkend + "'";
		//System.out.println(sPrepStmt);
		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);
   		runsql.runQuery();
   		runsql.readNextRecord();
   		sYear = runsql.getData("pyr#");   		   		
   		runsql.disconnect();
   		runsql = null;
   	}
   	
   	String sCurWk = "";
   	String sPrepStmt = "select char(piwe,usa) as wkend from rci.fsyper where pida= current date";
   	//System.out.println(sPrepStmt);
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sPrepStmt);
   	runsql.runQuery();
   	runsql.readNextRecord();
   	sCurWk = runsql.getData("wkend"); 
   	runsql.disconnect();
   	runsql = null;
   	
%> 
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Bdg vs. Sch(Act)</title>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT>
//--------------- Global variables -----------------------
var SelStr = [<%=schpay.cvtToJavaScriptArray(sStr)%>];
var Week = "<%=sWkend%>";
var Year = "<%=sYear%>";
var Type = "<%=sType%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";

var NumOfGrp = "<%=iNumOfGrp%>";
var NumOfReg = "<%=iNumOfReg%>";
var NumOfStr = "<%=iNumOfStr%>";
var NumOfWk = "<%=iNumOfWk%>";

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
	 
	 showAllCol();
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
	url = "BdgVsSchAct.jsp?Type=Y"
      + "&Year=" + Year 
      + "&Str=" + str;	 
	window.location.href=url;
}
//==============================================================================
//show all Columns
//==============================================================================
function showAllCol()
{
	for(var i=0; i < NumOfGrp; i++)
	{
	     var chk = document.getElementById("GrpShow" + i).checked;  
	     showCol(i, chk);
	}
}
//==============================================================================
//show Columns
//==============================================================================
function showCol(grp, chk)
{	
	var disp = "none";
	if(chk){ disp="table-cell"; }
	
	var hdr1 = "thHdr1" + grp;
	var hdr2 = "thHdr2" + grp;
	var hdr3 = "thHdr3" + grp;
	var hdr4 = "thHdr4" + grp;
	
	var ftr1 = "thFtr1" + grp;
	var ftr2 = "thFtr2" + grp;
	var ftr3 = "thFtr3" + grp;
	var ftr4 = "thFtr4" + grp;	
		
	// header
	document.getElementById(hdr1).style.display = disp;
	document.getElementById(hdr2).style.display = disp;
	document.getElementById(hdr3).style.display = disp;
	document.getElementById(hdr4).style.display = disp;
	//footer
	document.getElementById(ftr1).style.display = disp;
	document.getElementById(ftr2).style.display = disp;
	document.getElementById(ftr3).style.display = disp;
	document.getElementById(ftr4).style.display = disp;
	
	var max = NumOfStr;
	if(Type == "Y"){ max=NumOfWk; }
	
	for(var i=0; i < max; i++)
	{
		var bdg  = "tdBdg" + i + "G" + grp;
		var sch  = "tdSch" + i + "G" + grp;
		var hvar = "tdVar" + i + "G" + grp;
		document.getElementById(bdg).style.display = disp;
		document.getElementById(sch).style.display = disp;
		document.getElementById(hvar).style.display = disp;
	}
	
	// regions
	if(Type == "W"){
		for(var i=0; i < NumOfReg; i++)
		{
			var bdg  = "tdRegBdg" + i + "G" + grp;
			var sch  = "tdRegSch" + i + "G" + grp;
			var hvar = "tdRegVar" + i + "G" + grp;
			document.getElementById(bdg).style.display = disp;
			document.getElementById(sch).style.display = disp;
			document.getElementById(hvar).style.display = disp;
		}
	}
	
	// report total
	var bdg  = "tdRepBdg" + grp;
	var sch  = "tdRepSch" + grp;
	var hvar = "tdRepVar" + grp;
	document.getElementById(bdg).style.display = disp;
	document.getElementById(sch).style.display = disp;
	document.getElementById(hvar).style.display = disp;
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
            <br>Budget  vs. Schedule  
            <br>
            Store(s): 
            <%String sComa = "";
              for(int i=0; i < sSelStr.length; i++){%>
              <%=sComa + sSelStr[i]%><%sComa=", ";%>
            <%}%>
            <br>Date Level:&nbsp;
            <%if(sType.equals("W")){%>Weekend: <%=sWkend%><%}%>
            <%if(sType.equals("Y")){%>Fiscal Year: <%=sYear%><%}%>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="BdgVsSchActSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
          </th>
        </tr>
        <tr>
          <td style="font-size:10px; text-align:center;">          
        	<%for(int i=0; i < iNumOfGrp; i++){%>
        	    <input type="checkbox" name="GrpShow<%=i%>" id="GrpShow<%=i%>" onclick="showCol('<%=i%>', this.checked)" 
        	    <%if(!sGrpName[i].equals("Other") && !sGrpName[i].equals("EComm") 
        	    	&& !sGrpName[i].equals("Recover")  && !sGrpName[i].equals("Trn/Meet/Cln")){%>checked<%}%>><%=sGrpName[i]%>&nbsp;&nbsp;        		
        	<%}%>
        	</td>
          </tr>
          <tr>
          	<td style="font-size:12px; text-align:center; font-weight:bold;">
        	* &nbsp; () indicates underscheduled to budget
        	</td>
          </tr> 
        <tr>
          <td>  
       <table class="tbl02">
       <tr class="trHdr01">
        	<th class="th22" rowspan="2"><%if(sType.equals("W")){%>Str<%} else {%>Week<%} %></th>
        	<%for(int i=0; i < iNumOfGrp; i++){%>
        		<th class="th22" colspan="3" id="thHdr1<%=i%>"><%=sGrpName[i]%></th>        	
        	<%}%>
        	<th class="th02" rowspan="2"><%if(sType.equals("W")){%>Str<%} else {%>Week<%} %></th>
       </tr>
       
       <tr class="trHdr01">        	
        	<%for(int i=0; i < iNumOfGrp; i++){%>
        		<th class="th02" id="thHdr2<%=i%>">Bdg</th>
        		<th class="th02" id="thHdr3<%=i%>">Sch</th>
        		<th class="th22" id="thHdr4<%=i%>">Var</th>
        	<%}%>
       </tr>
        	
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = sStrReg[0];
             String sTrCls = "trDtl06"; 
             int iArg = -1;
             int iReg = -1;
           
             int iNumOfRow = iNumOfStr;
             if(sType.equals("Y")){iNumOfRow = iNumOfWk;}           
           %>
           
           <%for(int i=0; i < iNumOfRow; i++) 
             {
        	    if(sType.equals("W")){ schpay.setSingleStrWeek(sStr[i], sWeek[0]); }
        	    else{ schpay.setSingleStrWeek(sStr[0], sWeek[i]); }
        	    
        		String [] sBdgHrs = schpay.getBdgHrs();
        		String [] sSchHrs = schpay.getSchHrs();
        		String [] sHrsVar = schpay.getHrsVar(); 
        		
        		if(sType.equals("Y"))
        		{
        			boolean bCurWk = sCurWk.equals(sWeek[i]);
        			if(bCurWk){ sTrCls = "trDtl04"; }
        			else{ sTrCls = "trDtl06"; }
        		}
           	%>                           
           	<tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             	<td id="tdStr<%=i%>" class="td58" nowrap>
             		<%if(sType.equals("W")){%><a href="javascript: showStr('<%=sStr[i]%>')"><%=sStr[i]%></a>
             		<%} else{%><%=sWeek[i]%><%}%>
             	</td>
             	<%for(int j = 0; j < iNumOfGrp; j++){%>	
             		<td class="td12" id="tdBdg<%=i%>G<%=j%>" nowrap><%if(!sBdgHrs[j].equals(".00")){%><%=sBdgHrs[j]%><%}%></td>
             		<td class="td12" id="tdSch<%=i%>G<%=j%>" nowrap><%if(!sSchHrs[j].equals(".00")){%><%=sSchHrs[j]%><%}%></td>
             		<td class="td58" id="tdVar<%=i%>G<%=j%>" nowrap><%if(!sHrsVar[j].equals(".00")){%><%=sHrsVar[j]%><%}%></td>
        	 	<%}%>
        	 	
        	 	<td id="tdStr<%=i%>" class="td12" nowrap>
             		<%if(sType.equals("W")){%><a href="javascript: showStr('<%=sStr[i]%>')"><%=sStr[i]%></a>
             		<%} else{%><%=sWeek[i]%><%}%>
             	</td>
             </tr>
             
             <!-- =========== Region Total ============= -->  
             <%if(sType.equals("W") 
            	&& (i < iNumOfStr - 1 && !sStrReg[i].equals(sStrReg[i+1]) || i == iNumOfStr - 1)){
               		schpay.setRegGrp(sStrReg[i]);
            	 	sBdgHrs = schpay.getBdgHrs();
         		 	sSchHrs = schpay.getSchHrs();
         			sHrsVar = schpay.getHrsVar();
         			iReg++;
             %>
             <tr class="trDtl12">
             	<td class="td58" nowrap>District <%=sStrReg[i]%></td>
             	<%for(int j = 0; j < iNumOfGrp; j++){%>	
             		<td class="td12" id="tdRegBdg<%=iReg%>G<%=j%>" nowrap><%if(!sBdgHrs[j].equals(".00")){%><%=sBdgHrs[j]%><%}%></td>
             		<td class="td12" id="tdRegSch<%=iReg%>G<%=j%>" nowrap><%if(!sSchHrs[j].equals(".00")){%><%=sSchHrs[j]%><%}%></td>
             		<td class="td58" id="tdRegVar<%=iReg%>G<%=j%>" nowrap><%if(!sHrsVar[j].equals(".00")){%><%=sHrsVar[j]%><%}%></td>
        	 	<%}%>
        	 	<td class="td58" nowrap>District <%=sStrReg[i]%></td>
             </tr>
             <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
             <%
             	if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
 				else {sTrCls = "trDtl06";}
               }%>  
           <%}%>
           
           <!-- =========== Report Total ============= -->  
           <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
           <% 	schpay.setRepGrp();
           		String [] sBdgHrs = schpay.getBdgHrs();
   				String [] sSchHrs = schpay.getSchHrs();
   				String [] sHrsVar = schpay.getHrsVar();   				
         	%>
             <tr class="trDtl12">
             	<td class="td58" nowrap>Report Totals</td>
             	<%for(int j = 0; j < iNumOfGrp; j++){%>	
             		<td class="td12" id="tdRepBdg<%=j%>" nowrap><%if(!sBdgHrs[j].equals(".00")){%><%=sBdgHrs[j]%><%}%></td>
             		<td class="td12" id="tdRepSch<%=j%>" nowrap><%if(!sSchHrs[j].equals(".00")){%><%=sSchHrs[j]%><%}%></td>
             		<td class="td58" id="tdRepVar<%=j%>" nowrap><%if(!sHrsVar[j].equals(".00")){%><%=sHrsVar[j]%><%}%></td>
        	 	<%}%>
        	 	<td class="td58" nowrap>Report Totals</td>
             </tr>
             
             <tr class="trHdr06">
        		<th class="th22" rowspan="2"><%if(sType.equals("W")){%>Str<%} else {%>Week<%} %></th>
        		<%for(int i=0; i < iNumOfGrp; i++){%>
        			<th class="th22" colspan="3" id="thFtr1<%=i%>"><%=sGrpName[i]%></th>        	
        		<%}%>
        		<th class="th21" rowspan="2"><%if(sType.equals("W")){%>Str<%} else {%>Week<%} %></th>
       		</tr>
       
       		<tr class="trHdr06">        	
        		<%for(int i=0; i < iNumOfGrp; i++){%>
        			<th class="th21" id="thFtr2<%=i%>">Bdg</th>
        			<th class="th21" id="thFtr3<%=i%>">Sch</th>
        			<th class="th22" id="thFtr4<%=i%>">Var</th>
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
schpay.disconnect();
schpay = null;
}
%>