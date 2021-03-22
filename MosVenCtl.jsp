<%@ page import="mosregister.MosVenCtl, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelVen = request.getParameter("Ven");
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
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MosVenCtl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	MosVenCtl ctlinfo = new MosVenCtl();
	ctlinfo.setGrpLst(sSelStr, sSelVen, sSelSts, sWkend, sWkend2, sYear, sMonth, sDateLvl,  sSelCtl, sSelSku
		, sGrp, sDefect, sSort, sUser);
	
	int iNumOfReas = ctlinfo.getNumOfReas();
	String [] sReasLst = ctlinfo.getReasLst();
	String [] sRsCol1 = ctlinfo.getRsCol1();
	String [] sRsCol2 = ctlinfo.getRsCol2();
	String [] sRsCol3 = ctlinfo.getRsCol3();
	String sReasJsa = ctlinfo.getReasJsa();
	int iNumOfGrp = ctlinfo.getNumOfGrp();
	int iNumOfReg = ctlinfo.getNumOfReg();
	
	String sUserAuth = "";
	if(sUser.equals("vrozen") || sUser.equals("psnyder") || sUser.equals("dharris")){sUserAuth = "ALL";}
	else if(sUser.equals("achrist") || sUser.equals("spaoli") || sUser.equals("bstein")){sUserAuth = "DM";}
	
	boolean bAllowDlt = !sUserAuth.equals("");
	
	String [] sMonArr = new String[]{"Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"};
	int imon = Integer.parseInt(sMonth)-1;
	String sMonNm = sMonArr[imon];
	
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
var SelVen = "<%=sSelVen%>";
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
var NumOfReas = "<%=iNumOfReas%>";
var ReasLst = [<%=sReasJsa%>];

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
function drilldown(sel)
{	
	var url="MosVenCtl.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>" 
		+ "&Sku=<%=sSelSku%>&Ctl=<%=sSelCtl%>"
		+ "&Type=" + Type
		+ "&Defect=" + Defect
		;
	
	if(Grp == "Ven")
	{ 
		url += "&Ven=" + sel;
		url += "&Grp=Str";
		for(var i=0; i < SelStr.length;i++)
		{
			url += "&Str=" +  SelStr[i];
		}
	}
	if(Grp == "Str")
	{
		url += "&Ven=" + SelVen;
		url += "&Str=" + sel;
		url += "&Grp=Ctl";
	}	
	
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
	var url="MosVenCtl.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>" 
		+ "&Sku=<%=sSelSku%>&Ctl=<%=sSelCtl%>"
		+ "&Grp=" + Grp 
		+ "&Type=" + type+ "&Defect=" + Defect
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
		+ "&Ven=<%=sSelVen%>"
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
            <br><%if(!sDefect.equals("Y")){%>MOS Vendor Control Summary List<%}
                else {%>Defective Items Vendor Control Summary List<%}%> 
            <br>
            Store(s): 
            <%String sComa = "";
              for(int i=0; i < sSelStr.length; i++){%>
              <%=sComa + sSelStr[i]%><%sComa=", ";%>
            <%}%>
            <br>Date Level:&nbsp;
            <%if(sDateLvl.equals("A")){%>All<%}%>
            <%if(sDateLvl.equals("W")){%>Weekend: <%=sWkend%><%}%>
            <%if(sDateLvl.equals("W")){%>Weekend: <%=sWkend%><%}%>
            <%if(sDateLvl.equals("V")){%>From: <%=sWkend%> &nbsp; To: <%=sWkend2%><%}%>
            <%if(sDateLvl.equals("M")){%>Fiscal Month: <%=sMonNm + " / " + sYear%><%}%>
            <%if(sDateLvl.equals("Y")){%>Fiscal Year: <%=sYear%><%}%> 
            <br>
            Selected Status:&nbsp;
            <%sComa = "";
              for(int i=0; i < sSelSts.length; i++){%><%=sComa + sSelSts[i].trim()%><%sComa=", ";%><%}%> 
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MosVenCtlSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp; 
              <br>
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="U" <%if(sType.equals("U")){%>checked<%}%>>Unit &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="C" <%if(sType.equals("C")){%>checked<%}%>>Cost &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="R" <%if(sType.equals("R")){%>checked<%}%>>Retail &nbsp;                   
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
        	<th class="th02" width="5%" rowspan=2>
        	   <%if(sGrp.equals("Ven")){%>Vendor<%}
        	     else if(sGrp.equals("Str") || sGrp.equals("Ctl")){%>Str<%}%>
        	</th>
        	<%if(sGrp.equals("Ctl")){%>
        	   <th class="th02" rowspan=2>Ctl</th>
        	   <th class="th02" rowspan=2>Sts</th>        	           	   
        	<%}%>
        	<%for(int i = 0; i < iNumOfReas; i++){%>
        		<th class="th02"><%=i+1%></th>
        	<%}%>        	            
        	<th class="th02" width="5%" rowspan=2>Total
        	<br><%if(sType.equals("U")){%>Units<%}
        	      else if(sType.equals("C")){%>Cost<%}
        	      else if(sType.equals("R")){%>Retail<%}%></th>
        </tr>
        <tr class="trHdr01">
        	<%for(int i = 0; i < iNumOfReas; i++){%>
        		<th class="th02" width="6%">
        		   <%=sRsCol1[i]%><br><%=sRsCol2[i]%><br><%=sRsCol3[i]%>
        		</th>        		
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
       			String [] sExtQty = ctlinfo.getExtQty();
       			String [] sExtCost = ctlinfo.getExtCost();
       			String [] sExtRet = ctlinfo.getExtRet();
       			String sTotQty = ctlinfo.getTotQty();
       			String sTotCost = ctlinfo.getTotCost();
       			String sTotRet = ctlinfo.getTotRet();
       			String sVen = ctlinfo.getVen();
       			String sVenNm = ctlinfo.getVenNm();
       			
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
             <td id="tdStr<%=i%>" class="td11" nowrap>
                <%if(sGrp.equals("Ven")){%><a href="javascript: drilldown('<%=sVen%>')"><%=sVen%>-<%=sVenNm%></a><%}
                  else if(sGrp.equals("Str")){%><a href="javascript: drilldown('<%=sStr%>')"><%=sStr%></a><%}
             	  else {%><%=sStr%><%}%>
             </td>
             <%if(sGrp.equals("Ctl")){%>
             	<td id="tdCtl<%=i%>" class="td12" nowrap><a href="MosCtlInfo.jsp?Ctl=<%=sCtl%>"><%=sCtl%></a></td>
             	<td id="tdSts<%=i%>" class="td114" nowrap><%=sCtlSts%></td>             	             	
             <%}%>
             
             <%for(int j = 0; j < iNumOfReas; j++){%>
        		<td id="tdCost<%=i%>" class="td12" nowrap>
        		   <%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%>
        		</td>
        	 <%}%>
        	 
        	 
             <td id="tdCost<%=i%>" class="td12" nowrap>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        	 </td>
           </tr>
           <%}%>
           
           
           <!-- =========== Region Total ============= -->
           <!-- tr class="Divider"><td colspan=20>&nbsp;</td></tr>
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
             <%}%>
             
             <%for(int j = 0; j < iNumOfReas; j++){%>
        		<td class="td12" nowrap>
        			<b><%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%></b>
        		</td>
        	 <%}%>
        	  
             <td class="td12" nowrap><b>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        		  </b>
        	 </td>
           </tr>
           <%}%>
           -->
            
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
           <tr class="Divider"><td colspan=20>&nbsp;</td></tr>
           
           <tr id="trTot" class="trDtl03">
             <td class="td18" nowrap><b>Total</b></td>
             
             <%if(sGrp.equals("Ctl")){%>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             	<td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <%}%>
             
             <%for(int j = 0; j < iNumOfReas; j++){%>
        		<td class="td12" nowrap>
        		<%if(sGrp.equals("Str")){%><a href="javascript: getSkuByStr('<%=j%>')"><%}%>
        			<b><%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%></b>
        		<%if(sGrp.equals("Str")){%></a><%}%>	
        		</td>
        	 <%}%>
        	  
             <td class="td12" nowrap><b>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        		  </b>
        	 </td>
           </tr>
             
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
ctlinfo.disconnect();
ctlinfo = null;
}
%>