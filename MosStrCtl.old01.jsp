<%@ page import="mosregister.MosStrCtl, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sSelSts = request.getParameterValues("Sts");
   String sSelCtl = request.getParameter("Ctl");
   String sSelSku = request.getParameter("Sku");
   String sGrp = request.getParameter("Grp");
   String sSort = request.getParameter("Sort");
   String sType = request.getParameter("Type");
   
   String sWkend = request.getParameter("Wkend");
   String sWkend2 = request.getParameter("Wkend2");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sDateLvl = request.getParameter("DateLvl");
   String sDefect = request.getParameter("Defect");

   if(sDefect == null || sDefect == ""){sDefect = " ";}
   if(sSelStr == null){ sSelStr = new String[]{" "}; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MosStrCtl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	MosStrCtl ctlinfo = new MosStrCtl();
	ctlinfo.setGrpLst(sSelStr, sSelSts, sWkend, sWkend2, sYear, sMonth, sDateLvl,  sSelCtl, sSelSku
		, sGrp, sDefect, sSort, sUser);
	
	int iNumOfReas = ctlinfo.getNumOfReas();
	String [] sReasLst = ctlinfo.getReasLst();
	String [] sRsCol1 = ctlinfo.getRsCol1();
	String [] sRsCol2 = ctlinfo.getRsCol2();
	String [] sRsCol3 = ctlinfo.getRsCol3();
	String [] sRsSubC = ctlinfo.getRsSubC();
	String [] sRsScMax = ctlinfo.getRsScMax();
	String [][] sRsScList = ctlinfo.getRsScList();
	
	String sReasJsa = ctlinfo.getReasJsa();
	int iNumOfGrp = ctlinfo.getNumOfGrp();
	int iNumOfReg = ctlinfo.getNumOfReg();
	String sDispStrAppr = ctlinfo.getDispStrAppr();
	String sAllowStrAppr = ctlinfo.getAllowStrAppr();
	
	String sRsCMaxJsa = ctlinfo.cvtToJavaScriptArray(sRsScMax);
	
	
	String sUserAuth = "";
	if(sUser.equals("vrozen") || sUser.equals("psnyder")
		|| sUser.equals("gorozco") ){sUserAuth = "ALL";}
	
	else if(sUser.equals("gorozco") || sUser.equals("spaoli") || sUser.equals("bstein") || sUser.equals("bstein")
  	  || sUser.equals("satwood") || sUser.equals("dsimpson") || sUser.equals("mhodge")){sUserAuth = "DM";}
	
	boolean bAllowDlt = !sUserAuth.equals("");
	
	String [] sMonArr = new String[]{"Apr", "May", "Jun", "Jul", "Aug", "Sep"
			, "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Total"};
	int imon = Integer.parseInt(sMonth)-1;
	String sMonNm = sMonArr[imon];
	

    boolean bStrMonAppr = sDispStrAppr.equals("1") && sAllowStrAppr.equals("1");     
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>MOS Str Ctl List</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = [<%=ctlinfo.cvtToJavaScriptArray(sSelStr)%>];
var SelSts = [<%=ctlinfo.cvtToJavaScriptArray(sSelSts)%>];
var Week1 = "<%=sWkend%>";
var Week2 = "<%=sWkend2%>";
var Year = "<%=sYear%>";
var Month = "<%=sMonth%>";
var DatLvl = "<%=sDateLvl%>";
var Type = "<%=sType%>";
var Defect = "<%=sDefect%>";
var Grp = "<%=sGrp%>"
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";

var NumOfGrp = "<%=iNumOfGrp%>";
var NumOfReg = "<%=iNumOfReg%>";
var NumOfReas = "<%=iNumOfReas%>";
var ReasLst = [<%=sReasJsa%>];
var ActStr = new Array();

var RsCMax = [<%=sRsCMaxJsa%>];

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   for(var i=0; i < NumOfReas; i++)
   { 
	   if(RsCMax[i] > 0){ switchCat(i); } 
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
//set approve flag for Ctl
//==============================================================================
function setApprove(ctl, i, check)
{
	url = "MosCtlSv.jsp?Ctl=" + ctl;
	if(check) { url += "&Approved=Y"; }
	else { url += "&Approved=N"; }
	
	url += "&Action=APPROVED_CTL";
	window.frame1.location.href = url;
	
	var trnm = "trGrp" + i;
	document.all[trnm].style.background = "lightgreen";
}

//==============================================================================
//set store/month executive Approval
//==============================================================================
function setExecAppr()
{
	url = "MosCtlSv.jsp?Year=" + Year
	  + "&Month=" + Month
	  ;
	 
	for(var i=0; i < ActStr.length;i++)
	{
		url += "&Str=" +  ActStr[i];
	}
	
	url += "&Action=APPROVED_STR";
	
	window.frame1.location.href = url;
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
}



//==============================================================================
// drill down to control
//==============================================================================
function drilldown(str)
{
	var url="MosStrCtl.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>" 
		+ "&Sku=<%=sSelSku%>&Ctl=<%=sSelCtl%>"
		+ "&Grp=Ctl&Type=" + Type
		+ "&Defect=" + Defect 
		;	
	url += "&Str=" +  str;		
	for(var i=0; i < SelSts.length;i++)
	{
		url += "&Sts=" +  SelSts[i];
	}			
	
	window.location.href = url;
}
//==============================================================================
// switch displayed value
//==============================================================================
function switchType(type)
{
	var url="MosStrCtl.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>" 
		+ "&Sku=<%=sSelSku%>&Ctl=<%=sSelCtl%>"
		+ "&Grp=" + Grp 
		+ "&Type=" + type
		+ "&Defect=" + Defect
	;	
	
	for(var i=0; i < SelStr.length;i++)
	{
		url += "&Str=" +  SelStr[i];
	}
	
	for(var i=0; i < SelSts.length;i++)
	{
		url += "&Sts=" +  SelSts[i];
	}	
	
	window.location.href = url;
}

//==============================================================================
// get Sku by store for selected reason report
//==============================================================================
function getSkuByStr(argr)
{
	var url="MosStrSku.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>" 
		+ "&Reas=" + ReasLst[argr]		 
		+ "&Type=" + Type
		+ "&Defect=" + Defect
	;
	
	for(var i=0; i < SelStr.length;i++)
	{
		url += "&Str=" +  SelStr[i];
	}
	
	for(var i=0; i < SelSts.length;i++)
	{
		url += "&Sts=" +  SelSts[i];
	}	
	
	window.location.href = url;
}
//==============================================================================
//get Sku by store by month
//==============================================================================
function getSkuByStrByMon(argr, mon)
{
	var url="MosStrSku.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=" + mon + "&DateLvl=M" 
		+ "&Reas=" + ReasLst[argr]		 
		+ "&Type=" + Type;
	
	for(var i=0; i < SelStr.length;i++)
	{
		url += "&Str=" +  SelStr[i];
	}
	url += "&Sts=Processed"; 	
	
	window.location.href = url;
}
//==============================================================================
// get this report by selected month
//==============================================================================
function getRepByMon(mon)
{
	var url="MosStrCtl.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=" + mon + "&DateLvl=M" 
		+ "&Sku=<%=sSelSku%>&Ctl=<%=sSelCtl%>"
		+ "&Grp=Str&Type=" + Type
		+ "&Defect=" + Defect 
		;	
	for(var i=0; i < SelStr.length;i++)
	{
		url += "&Str=" +  SelStr[i];
	}
	url += "&Sts=Processed";
	
	window.location.href = url;
}
//==============================================================================
// get subcategory summary
//==============================================================================
function getSubCatSum(argStr, argReas, str, ctl)
{
	var url="MosCatSum.jsp?" 
	 + "Ctl=" + ctl 
	 + "&Sts=" + SelSts[0]
	 + "&Wkend=" + Week1
	 + "&Wkend2=" + Week2
	 + "&Year=" + Year
	 + "&Month=" + Month
	 + "&DateLvl=" + DatLvl
	 + "&Reas=" + ReasLst[argReas]
	 + "&ArgStr=" + argStr
	 + "&ArgReas=" + argReas
	;
	
	if(argStr != null){ url += "&Str=" + str; }
	else
	{
		for(var i=0; i < SelStr.length;i++)
		{
			url += "&Str=" +  SelStr[i];
		}
	}
	
	//alert(url)
	window.frame1.location.href=url;
	
	//setSubCatSum(argStr, argReas, ctl);
}
//==============================================================================
//set subcategory summary
//==============================================================================
function setSubCatSum(argStr, argReas, subcat, catqty, catcost, catret)
{
	var dvnm = "dvSubC" + argStr + argReas;
	var dv = document.all[dvnm];	
	var html = "";
	var br = "";
	for(var i=0; i < subcat.length; i++)
	{
		html += br + subcat[i] + ":";
		
		if(Type == "U"){ html += " " + catqty[i]; }
		else if(Type == "C"){ html += " $" + catcost[i]; }
		else if(Type == "R"){ html += " $" + catret[i]; }
		br = "<br>";		
	}
		
	
	dv.innerHTML = html;	 
}
//==============================================================================
//set subcategory summary
//==============================================================================
function switchCat(reas)
{
    var thl1 = document.all.thReasL1;
    var thl2 = document.all.thReasL2;    
    
    thl1[reas].style.color = "green";
    thl2[reas].style.color = "green";
    
    var exp = thl1[reas].colSpan > 1;
    
    // expand/colapse header, row 1 and 2   
    var col = 1;
    if(exp){col=1;}
    else{ col = eval(RsCMax[reas]) + 1; }    
    thl1[reas].colSpan = col;
	thl2[reas].colSpan = col;
	
	// display/hide row 3
	var disp = "none";
	if(!exp){ disp = "block"; }
	for(var i=0; i < RsCMax[reas]; i++)
	{
		var thl1nm = "thReasL3" + reas + i;
		document.all[thl1nm].style.display = disp;
	}
	
	
	// display/hide detail  
	for(var i=0; i < NumOfGrp; i++)
	{
		for(var j=0; j < RsCMax[reas]; j++)
		{
			var thl1nm = "tdCat" + i + reas + j;
			document.all[thl1nm].style.display = disp;
		}
	}
	
	// display/hide region  
	for(var i=0; i < NumOfReg; i++)
	{
		for(var j=0; j < RsCMax[reas]; j++)
		{
			var thl1nm = "tdRegCat" + i + reas + j;
			document.all[thl1nm].style.display = disp;
		}
	}
	
	// display/hide total  
	for(var j=0; j < RsCMax[reas]; j++)
	{
		var thl1nm = "tdTotCat" + reas + j;
		document.all[thl1nm].style.display = disp;
	}	
}
//==============================================================================
// get list of control - sort by comments 
//==============================================================================
function getOtherByCommt(str,ctl)
{
	var url = "MosCtlwOther.jsp?Str=" + str
	+ "&Ctl=" + ctl
	+ "&Wkend=<%=sWkend%>&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>"	
	
	for(var i=0; i < SelSts.length;i++)
	{
		url += "&Sts=" +  SelSts[i];
	}
		
	window.frame1.location.href=url; 
}
//==============================================================================
//set list of control - sort by comments 
//==============================================================================
function setOtherByCommt(ctl, itemid, sku, comm, qty, cost, ret,desc, user)
{
	var hdr = "Other - SKU by Comments";

	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" 
	        + popOtherByCommtPanel(ctl, itemid, sku, comm, qty, cost, ret,desc,user)
	     + "</td></tr>"
	   + "</table>"

	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 240;
	   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 95;
	   document.all.dvItem.style.visibility = "visible";
 
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popOtherByCommtPanel(ctl, itemid, sku, comm, qty, cost, ret,desc, user)
{
	  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
	    + "<tr class='trHdr01'>"
	  		+ "<th class='th02' nowrap>Ctl#</th>"
	  		+ "<th class='th02' nowrap>User</th>"
	  		+ "<th class='th02' nowrap>SKU</th>"
	  		+ "<th class='th02' nowrap>Comments</th>"
	  		+ "<th class='th02' nowrap>Desc</th>"
	  		+ "<th class='th02' nowrap>Qty</th>"
	  		+ "<th class='th02' nowrap>Cost</th>"
	  		+ "<th class='th02' nowrap>Ret</th>" 
	    + "</tr>";

	  for(var i=0; i < ctl.length; i++)
	  {
		if(ctl[i] != "Total"){ panel += "<tr class='trDtl06'>"; }
		else { panel += "<tr class='trDtl04'>"; }
		
	   	panel += "<td  class='td12' nowrap><a href='MosCtlInfo.jsp?Ctl=" + ctl[i] + "' target='_blank'>" + ctl[i] + "</a></td>"
	   		+ "<td  class='td11' nowrap>" + user[i] + "</td>"
	   		+ "<td  class='td12' nowrap>" + sku[i] + "</td>"
	   		+ "<td  class='td11' nowrap>" + comm[i] + "</td>"
	   		+ "<td  class='td11' nowrap>" + desc[i] + "</td>"
	   		+ "<td  class='td12' nowrap>" + qty[i] + "</td>"
	   		+ "<td  class='td12' nowrap>$" + cost[i] + "</td>"
	   		+ "<td  class='td12' nowrap>$" + ret[i] + "</td>"
	   	  + "</tr>"	
	  }
	  
	  panel += "<tr><td class='td18' colspan=7>";
	  panel += " <button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
	  panel += "</table>";
	  return panel;
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
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/2.0 MOS Approval Recap.pdf" class="helpLink" target="_blank">&nbsp;</a></div>
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
            <br><%if(!sDefect.equals("Y")){%>MOS Store Control Summary List<%}
                else {%>Defective Items Store Control Summary List<%}%> 
            <br>
            Store(s): 
            <%String sComa = "";
              for(int i=0; i < sSelStr.length; i++){%>
              <%=sComa + sSelStr[i]%><%sComa=", ";%>
            <%}%>
            <br>Date Level:&nbsp;
            <%if(sDateLvl.equals("A")){%>All<%}%> 
            <%if(sDateLvl.equals("W")){%>Weekend: <%=sWkend%><%}%>
            <%if(sDateLvl.equals("V")){%>From: <%=sWkend%> &nbsp; To: <%=sWkend2%><%}%>
            <%if(sDateLvl.equals("M")){%>Fiscal Month: <%=sMonNm + " / " + sYear%><%}%>
            <%if(sDateLvl.equals("Y")){%>Fiscal Year: <%=sYear%><%}%>
            <br>
            Selected Status:&nbsp;
            <%sComa = "";
              for(int i=0; i < sSelSts.length; i++){%>
                   <%=sComa + sSelSts[i]%><%sComa=", ";%>
            <%}%> 
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MosStrCtlSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;               
              <br>
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="U" <%if(sType.equals("U")){%>checked<%}%>>Unit &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="C" <%if(sType.equals("C")){%>checked<%}%>>Cost &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="R" <%if(sType.equals("R")){%>checked<%}%>>Retail &nbsp;
              
             <br>
              <span style="background:yellow; font-weight:normal;">
              <b>Note:</b>  This page does not include all Unit Adjustments processed out of S/L Inventory (i.e. Physical Inventories, or other Manual entries made by HO/IC)
              </span> 
                <%if(bStrMonAppr){%><br><br><button onclick="setExecAppr()">Executive - Monthly Signoff</button><br><%}%>                     
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
        	<th class="th02" width="5%" rowspan=3>Str</th>
        	<%if(sGrp.equals("Ctl")){%>
        	   <th class="th02" rowspan=3>Ctl</th>
        	   <th class="th02" rowspan=3>Current Sts</th>
        	   <th class="th02" rowspan=3>Created On Date</th>
        	   <th class="th02" rowspan=3>Created By User</th>        	   
        	<%}%>
        	<%for(int i = 0; i < iNumOfReas; i++){%>
        		<th class="th02" id="thReasL1" <%if(sRsSubC[i].equals("Y")){%>colspan=<%=Integer.parseInt(sRsScMax[i]) + 1%><%}%>><%=i+1%></th>
        	<%}%>
        	<%if(sGrp.equals("Ctl")){%>
        	   <th class="th02" colspan=3>Approve?</th>        	   
        	<%}%>            
        	<th class="th02" width="5%" rowspan=3>Total
        	 <br><%if(sType.equals("U")){%>Units<%}
        	 else if(sType.equals("C")){%>Cost<%}
        	 else if(sType.equals("R")){%>Retail<%}%>
        	</th>
        	<%if(sDispStrAppr.equals("1")){%>
        	   <th class="th02" colspan=2>Executive Signoff</th>
        	<%}%>
        </tr>
        <tr class="trHdr01">
        	<%for(int i = 0; i < iNumOfReas; i++){%>
        		<th class="th02" id="thReasL2" width="6%" <%if(sRsSubC[i].equals("Y")){%>colspan="<%=Integer.parseInt(sRsScMax[i]) + 1%>"<%}%>>
        		   <%if(sRsSubC[i].equals("Y")){%><a href="javascript: switchCat('<%=i%>')"><%=sRsCol1[i]%><br><%=sRsCol2[i]%></a><%} 
        		   else {%><%=sRsCol1[i]%><br><%=sRsCol2[i]%><%}%>
        		   <sup style="color:red;"><%if(sRsSubC[i].equals("Y")){%><a href="javascript: switchCat('<%=i%>')">**</a><%}%></sup><br><%=sRsCol3[i]%>
        		   <%if(sReasLst[i].equals("Other")){%><span style="font-size:10px; font-weight:normal;">(See Comments)</span><%}%>
        		</th>        		
        	<%}%>
        	<%if(sGrp.equals("Ctl")){%>
        	   <th class="th02" rowspan=2>Yes</th>
        	   <th class="th02" rowspan=2>Date</th>
        	   <th class="th02" rowspan=2>User</th>
        	<%}%>
        	<%if(sDispStrAppr.equals("1")){%>
        	   <th class="th02" rowspan=2>Date</th>
        	   <th class="th02" rowspan=2>User</th>        	   
        	<%}%>
        </tr>
        
        <tr class="trHdr01">
        	<%for(int i = 0; i < iNumOfReas; i++){%>        	   
       		   <%int max = Integer.parseInt(sRsScMax[i]);       		     
       		   for(int j = 0; j < max; j++){%>
          	        <th class="th19" id="thReasL3<%=i%><%=j%>"><%=sRsScList[i][j]%></th>
        	   <%}%> 	
        	  <th class="th19"><%if(sRsSubC[i].equals("Y")){%>Total<%} else {%><%=i+1%><%}%></th>   
        	<%}%>
        </tr>	
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) {        	   
        	   	ctlinfo.setCtl();
       			String sStr = ctlinfo.getStr();
       			String sCtl = ctlinfo.getCtl();
       			String sCtlSts = ctlinfo.getCtlSts();
       			String sName = ctlinfo.getName();
       			String sCtlUsr = ctlinfo.getCtlUsr();
       			String sCtlDt = ctlinfo.getCtlDt();
       			String sCtlTm = ctlinfo.getCtlTm();
       			String [] sExtQty = ctlinfo.getExtQty();
       			String [] sExtCost = ctlinfo.getExtCost();
       			String [] sExtRet = ctlinfo.getExtRet();
       			String sTotQty = ctlinfo.getTotQty();
       			String sTotCost = ctlinfo.getTotCost();
       			String sTotRet = ctlinfo.getTotRet();
       			String sApprUs = ctlinfo.getApprUs();
       			String sApprDt = ctlinfo.getApprDt();
       			String sStrApprUs = ctlinfo.getStrApprUs();
       			String sStrApprDt = ctlinfo.getStrApprDt();
   			
   				if(sTrCls.equals("trDtl21")){sTrCls = "trDtl20";}
   				else {sTrCls = "trDtl21";} 
   				
   				for(int j = 0; j < iNumOfReas; j++)
   				{
   					if( sExtQty[j].equals("0")){ sExtQty[j] = "&nbsp;"; }
   					if( sExtCost[j].equals(".00")){sExtCost[j] = "&nbsp;"; }
   					if( sExtRet[j].equals(".00")){sExtRet[j] = "&nbsp;";  }
   				}
   				
   				String [] sAmt = new String[iNumOfReas];
   				for(int j = 0; j < iNumOfReas; j++)
   				{
   					if(sType.equals("U")){sAmt[j] = sExtQty[j]; }
   					else if(sType.equals("C")){sAmt[j] = sExtCost[j]; }
   					else if(sType.equals("R")){sAmt[j] = sExtRet[j]; }
   				}
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdStr<%=i%>" class="td12" nowrap>
             	<%if(sGrp.equals("Str")){%><a href="javascript: drilldown('<%=sStr%>')"><%=sStr%></a><%}
             	else {%><%=sStr%><%}%>
             	<script type="text/javascript">ActStr[ActStr.length]="<%=sStr%>";</script>
             </td>
             <%if(sGrp.equals("Ctl")){%>
             	<td id="tdCtl<%=i%>" class="td12" nowrap><a href="MosCtlInfo.jsp?Ctl=<%=sCtl%>"><%=sCtl%></a></td>
             	<td id="tdSts<%=i%>" class="td114" nowrap><%=sCtlSts%></td>
             	<td id="tdCtl<%=i%>" class="td11" nowrap><%=sCtlDt%></td>
             	<td id="tdCtl<%=i%>" class="td11" nowrap><%=sCtlUsr%></td>             	
             <%}%>
             
             <%for(int j = 0; j < iNumOfReas; j++){%>        		
        		<%
        		if(sRsSubC[j].equals("Y"))
    			{
        			ctlinfo.setCatSum(sReasLst[j]);
        			int max = Integer.parseInt(sRsScMax[j]);
        			
       		    	for(int k = 0; k < max; k++){
       		    	    ctlinfo.setCat();
       		    	    String sCatQty = ctlinfo.getTotQty();
						String sCatCost = ctlinfo.getTotCost();
						String sCatRet = ctlinfo.getTotRet();
						String sCatAmt = "&nbsp;";	
						if(sType.equals("U") && !sCatQty.equals("0")){ sCatAmt = sCatQty; }
						else if(sType.equals("C") && !sCatCost.equals(".00")){ sCatAmt = sCatCost; }
						else if(sType.equals("R") && !sCatRet.equals(".00")){ sCatAmt = sCatRet; }
						
					%>						
          	        	<td id="tdCat<%=i%><%=j%><%=k%>" class="td11" nowrap><%=sCatAmt%></td>
        			<%}%>
        	    <%}%>
        	    <td id="tdCost<%=i%>" class="td11" nowrap>
        		   <%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%>        		   
        		   <%if(sReasLst[j].equals("Other")){%>
        		      <a href="javascript: getOtherByCommt('<%=sStr%>','<%=sCtl%>')"><%=sAmt[j]%></a>
        		   <%} else{%><%=sAmt[j]%><%}%>        		   
        		</td> 
        	 <%}%>
        	 
        	 <%if(sGrp.equals("Ctl")){%>
             	<td id="tdApprv<%=i%>" class="td18" nowrap>
             		<%if(bAllowDlt && !sCtlSts.equals("Open") && !sCtlSts.equals("Processed")){%>
             			<input onclick="setApprove('<%=sCtl%>','<%=i%>', this.checked)" class="Small" name="Apprv<%=i%>" 
             			<%if(sCtlSts.equals("Approved")){%>checked<%}%> type="checkbox">
             		<%}%> &nbsp;             		
             		<td id="tdCtl<%=i%>" class="td11" nowrap><%=sApprDt%></td>
             		<td id="tdCtl<%=i%>" class="td11" nowrap><%=sApprUs%></td>
             	</td>             	
             <%}%>
             <td id="tdCost<%=i%>" class="td12" nowrap>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        	 </td>
        	 <%if(sDispStrAppr.equals("1")){%>
        	    <td class="td18"><%=sStrApprDt%></td>
             	<td class="td18"><%=sStrApprUs%></td>
        	 <%}%>
           </tr>
           <%}%>
           
           
           <!-- =========== Region Total ============= -->
           <tr class="Divider"><td colspan=50>&nbsp;</td></tr>
           <%
           for(int i=0; i < iNumOfReg; i++ )
       	   {
        		ctlinfo.setRegTot();       	   
   				String sReg = ctlinfo.getReg();
   				String [] sExtQty = ctlinfo.getExtQty();
   				String [] sExtCost = ctlinfo.getExtCost();
   				String [] sExtRet = ctlinfo.getExtRet();
   				String sTotQty = ctlinfo.getTotQty();
   				String sTotCost = ctlinfo.getTotCost();
   				String sTotRet = ctlinfo.getTotRet();
       		
       			for(int j = 0; j < iNumOfReas; j++)
				{
					if( sExtQty[j].equals("0")){ sExtQty[j] = "&nbsp;"; }
					if( sExtCost[j].equals(".00")){sExtCost[j] = "&nbsp;"; }
					if( sExtRet[j].equals(".00")){sExtRet[j] = "&nbsp;";  }
				}
			
				String [] sAmt = new String[iNumOfReas];
				for(int j = 0; j < iNumOfReas; j++)
				{
					if(sType.equals("U")){sAmt[j] = sExtQty[j]; }
					else if(sType.equals("C")){sAmt[j] = sExtCost[j]; }
					else if(sType.equals("R")){sAmt[j] = sExtRet[j]; }
				}       	   	
           %>
           <tr id="trTot" class="trDtl02">
             <td class="td18" nowrap><b>District <%=sReg%></b></td>
             
             <%if(sGrp.equals("Ctl")){%>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <%}%>
             
             <%for(int j = 0; j < iNumOfReas; j++){%>        		
        		<%if(sRsSubC[j].equals("Y"))
	    		  {
	        		String sRefresh = "Y";
	        		int max = Integer.parseInt(sRsScMax[j]);
	        			
	       		    for(int k = 0; k < max; k++){
	       		    	String sCatAmt = "&nbsp;";
	       		    	ctlinfo.setRegCat(i, j, sRefresh);	       		    		
	       		    	sRefresh = " ";
	       		        String sCatQty = ctlinfo.getTotQty();
						String sCatCost = ctlinfo.getTotCost();
						String sCatRet = ctlinfo.getTotRet();
						System.out.println("reg cat " + sCatCost);
						if(sType.equals("U") && !sCatQty.equals("0")){ sCatAmt = sCatQty; }
						else if(sType.equals("C") && !sCatCost.equals(".00")){ sCatAmt = sCatCost; }
						else if(sType.equals("R") && !sCatRet.equals(".00")){ sCatAmt = sCatRet; }						
					%>						
	          	       	<td id="tdRegCat<%=i%><%=j%><%=k%>" class="td11" nowrap><%=sCatAmt%></td>
	        		<%}%>
	        	 <%}%>
	        	 <td class="td12" nowrap>
        			<b><%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%></b>
        		 </td>	    
        	 <%}%>
        	 <%if(sGrp.equals("Ctl")){%>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 <%}%>
             <td class="td12" nowrap><b>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        		  </b>
        	 </td>
        	 <%if(sDispStrAppr.equals("1")){%>
        	    <td class="td11" nowrap>&nbsp;</td>
             	<td class="td11" nowrap>&nbsp;</td>
        	 <%}%>
           </tr>
           <%}%>
           
            
           <!-- ======Total ================ -->
           <%
       	    ctlinfo.setTotal();
       		String [] sExtQty = ctlinfo.getExtQty();
       		String [] sExtCost = ctlinfo.getExtCost();
       		String [] sExtRet = ctlinfo.getExtRet();
       		String sTotQty = ctlinfo.getTotQty();
       		String sTotCost = ctlinfo.getTotCost();
       		String sTotRet = ctlinfo.getTotRet();
       		
       		for(int j = 0; j < iNumOfReas; j++)
			{
				if( sExtQty[j].equals("0")){ sExtQty[j] = "&nbsp;"; }
				if( sExtCost[j].equals(".00")){sExtCost[j] = "&nbsp;"; }
				if( sExtRet[j].equals(".00")){sExtRet[j] = "&nbsp;";  }
			}
			
			String [] sAmt = new String[iNumOfReas];
			for(int j = 0; j < iNumOfReas; j++)
			{
				if(sType.equals("U")){sAmt[j] = sExtQty[j]; }
				else if(sType.equals("C")){sAmt[j] = sExtCost[j]; }
				else if(sType.equals("R")){sAmt[j] = sExtRet[j]; }
			}
           %>
           <tr class="Divider"><td colspan=50>&nbsp;</td></tr>
           
           <tr id="trTot" class="trDtl03">
             <td class="td18" nowrap><b>Total</b></td>
             
             <%if(sGrp.equals("Ctl")){%>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <%}%>
             
             <%for(int j = 0; j < iNumOfReas; j++){%>
        		<%if(sRsSubC[j].equals("Y"))
    			  {
        			String sRefresh = "Y";
        			int max = Integer.parseInt(sRsScMax[j]);
        			
       		    	for(int k = 0; k < max; k++){
       		    		String sCatAmt = "&nbsp;";
       		    		ctlinfo.setTotCat(j, sRefresh);
       		    		sRefresh = " ";
       		    	    String sCatQty = ctlinfo.getTotQty();
						String sCatCost = ctlinfo.getTotCost();
						String sCatRet = ctlinfo.getTotRet();						
						if(sType.equals("U") && !sCatQty.equals("0")){ sCatAmt = sCatQty; }
						else if(sType.equals("C") && !sCatCost.equals(".00")){ sCatAmt = sCatCost; }
						else if(sType.equals("R") && !sCatRet.equals(".00")){ sCatAmt = sCatRet; }						
					%>						
          	        	<td id="tdTotCat<%=j%><%=k%>" class="td11" nowrap><%=sCatAmt%></td>
        			<%}%>
        	    <%}%>
        	    <td class="td12" nowrap>
        		<%if(sGrp.equals("Str")){%><a href="javascript: getSkuByStr('<%=j%>')"><%}%>
        			<b><%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%></b>
        		<%if(sGrp.equals("Str")){%></a><%}%>	
        		</td>
        	 <%}%>
        	 <%if(sGrp.equals("Ctl")){%>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 	<td class="td12" nowrap>&nbsp;</td> 
        	 <%}%>
             <td class="td12" nowrap><b>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        		  </b>
        	 </td>
        	 <%if(sDispStrAppr.equals("1")){%>
        	    <td class="td11" nowrap>&nbsp;</td>
             	<td class="td11" nowrap>&nbsp;</td>
        	 <%}%>
           </tr>
             
          
      <!----------------------- end of table ------------------------>
      <tr>
      	<td colspan=30>&nbsp;<br>
      *Note: Fiscal week and month have been shifted for EOM reset on Monday night.      
      <br>&nbsp;<br>&nbsp;
      
      <!----------------------- Monthly Recap ------------------------>
 <%if(sGrp.equals("Str") && sSelSts[0].equals("Processed") 
		 && (sDateLvl.equals("M") || sDateLvl.equals("Y"))){%>     
      
        <tr class="trHdr01">
        	<th class="th02" width="5%" rowspan=2>Month</th>
        	<%for(int i = 0; i < iNumOfReas; i++){%>
        		<th class="th02"><%=i+1%></th>
        	<%}%>
        	<th class="th02" width="5%" rowspan=2>Total
        	 	<br><%if(sType.equals("U")){%>Units<%}
        	 		else if(sType.equals("C")){%>Cost<%}
        	 		else if(sType.equals("R")){%>Retail<%}%>
        	</th>
        	<%if(sDispStrAppr.equals("1")){%>
        	   <th class="th02" colspan=2 rowspan=2>&nbsp;</th>
        	<%}%>
        </tr>
        </tr>
        <tr class="trHdr01">
        	<%for(int i = 0; i < iNumOfReas; i++){%>
        		<th class="th02" width="6%">
        		   <%=sRsCol1[i]%><br><%=sRsCol2[i]%><br><%=sRsCol3[i]%>
        		</th>        		
        	<%}%>
        </tr>
        <%
        	ctlinfo.setYTDRecap();
    		int iNumOfMon = ctlinfo.getNumOfMon();
    		sExtCost = null;
    		for(int i=0; i < iNumOfMon + 1; i++ )
    		{
    			ctlinfo.setMonRecap();
    			String sMon = ctlinfo.getMon();
    			sExtQty = ctlinfo.getExtQty();
    			sExtCost = ctlinfo.getExtCost();
    			sExtRet = ctlinfo.getExtRet();
    			sTotQty = ctlinfo.getTotQty();
    			sTotCost = ctlinfo.getTotCost();
    			sTotRet = ctlinfo.getTotRet();    
    			
    			for(int j = 0; j < iNumOfReas; j++)
    			{
    				if( sExtQty[j].equals("0")){ sExtQty[j] = "&nbsp;"; }
    				if( sExtCost[j].equals(".00")){sExtCost[j] = "&nbsp;"; }
    				if( sExtRet[j].equals(".00")){sExtRet[j] = "&nbsp;";  }
    			}
    			
    			sAmt = new String[iNumOfReas];
    			for(int j = 0; j < iNumOfReas; j++)
    			{
    				if(sType.equals("U")){sAmt[j] = sExtQty[j]; }
    				else if(sType.equals("C")){sAmt[j] = sExtCost[j]; }
    				else if(sType.equals("R")){sAmt[j] = sExtRet[j]; }
    			}
    			
    			imon = Integer.parseInt(sMon)-1;
    			sMonNm = sMonArr[imon];
    			String sYtdRowCls = "trDtl03";
    			if(sMonNm.equals("Total")) {sYtdRowCls = "trDtl05"; }
    		%>
    		<tr id="trTot" class="<%=sYtdRowCls%>">
             <td class="td18" nowrap><a href="javascript: getRepByMon('<%=sMon%>')"><b><%=sMonNm%></b></td>
             
             <%if(sGrp.equals("Ctl")){%>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <%}%>
             
             <%for(int j = 0; j < iNumOfReas; j++){%>
        		<td class="td12" nowrap>
        		<%if(sGrp.equals("Str")){%><a href="javascript: getSkuByStrByMon('<%=j%>','<%=sMon%>')"><%}%>
        			<b><%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%></b>
        		<%if(sGrp.equals("Str")){%></a><%}%>	
        		</td>
        	 <%}%>
        	 <%if(sGrp.equals("Ctl")){%>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 	<td class="td12" nowrap>&nbsp;</td>
        	 	<td class="td12" nowrap>&nbsp;</td> 
        	 <%}%>
             <td class="td12" nowrap><b>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        		  </b>
        	 </td>
        	 <%if(sDispStrAppr.equals("1")){%>
        	    <td class="td11" nowrap>&nbsp;</td>
             	<td class="td11" nowrap>&nbsp;</td>
        	 <%}%>
           </tr>
    	<%}%>        
      
  <%}%>      
		</table>  
       
      </tr>
   </table>
 </body>
</html>
<%
ctlinfo.disconnect();
ctlinfo = null;
}
%>