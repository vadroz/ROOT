<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*
	, java.util.*, rciutility.CallAs400SrvPgmSup
	, rciutility.StoreSelect "
%>
<%
   String [] sSelSts = request.getParameterValues("Sts");
   String sStrCtl = request.getParameter("Str");

   if(sSelSts == null)
   {
	   sSelSts = new String[]{"Open", "Submitted"};
   } 
   if(sStrCtl == null)
   {
	   sStrCtl = "ALL";
   } 
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MosCtlSel.jsp&APPL=ALL");
}
else
{
	   	String sStrAllowed = session.getAttribute("STORE").toString();
	   	String sUser = session.getAttribute("USER").toString();
	   	
	   	StoreSelect strlst = null;
    	if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
        {
          strlst = new StoreSelect(23);
        }
        else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
        {
          strlst = new StoreSelect(21);
        }
        else
        {
          Vector vStr = (Vector) session.getAttribute("STRLST");
          String [] sStrAlwLst = new String[ vStr.size()];
          Iterator iter = vStr.iterator();

          int iStrAlwLst = 0;
          while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

          if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
          else strlst = new StoreSelect(new String[]{sStrAllowed});
       }

       String sStrJsa = strlst.getStrNum();
       String sStrNameJsa = strlst.getStrName();
       String [] sArrStr = strlst.getStrLst();	
	   	
	   	
	   	String sPrepStmt = "select MHCTLID,MHSTR,MHCTLSTS,MHNAME, MHRECUS,MHRECDT,MHRECTM, MhEmp, ename"
	   	 + ", (select sum(MICOST) from rci.MKITEM where MICTLID = MHCTLID) as cost"
	   	 + ", (select sum(MiQty) from rci.MKITEM where MICTLID = MHCTLID) as qty"
	   	 + ",(select MlRecUs from rci.MKHDRLOG where MLCTLID=MHCTLID and MlSts='Approved' order by MLLOGID desc fetch first 1 row only) as apprus" 
	   	 + ",(select MlRecDt from rci.MKHDRLOG where MLCTLID=MHCTLID and MlSts='Approved' order by MLLOGID desc fetch first 1 row only) as apprdt"
	   	 + ",(select MlRecUs from rci.MKHDRLOG where MLCTLID=MHCTLID and MlSts='Submitted' order by MLLOGID desc fetch first 1 row only) as sbmus" 
	   	 + ",(select MlRecDt from rci.MKHDRLOG where MLCTLID=MHCTLID and MlSts='Submitted' order by MLLOGID desc fetch first 1 row only) as sbmdt"
	     + ",(select MlRecDt from rci.MKHDRLOG where MLCTLID=MHCTLID and MlSts='Processed' order by MLLOGID desc fetch first 1 row only) as procdt"
	   	 + ",MHDFCT"
	   	 + " from rci.mkhdr "
	   	 + " left join rci.rciemp on MhEmp=erci"
	   	 + " where MHCTLSTS in (";
	   	 
	   	String coma = "";
	   	for(int i=0; i < sSelSts.length; i++)
	   	{
	   		
	   		sPrepStmt += coma + " '" + sSelSts[i] + "'";
	   		coma = ",";
	   	}	   	
	   	sPrepStmt += ")";
	   	
	   	if(sStrCtl.equals("ALL"))
	   	{
	   	sPrepStmt += " and mhstr in (";
	   	coma = "";
	   	for(int i=0; i < sArrStr.length; i++)
	   	{	   		
	   		if(sArrStr[i] != null)
	   		{
	   			sPrepStmt += coma + " " + sArrStr[i];
	   			coma = ",";
	   		}
	   	}	   	
	   	sPrepStmt += ")";
	   	}
	   	else
	   	{
	   		sPrepStmt += " and mhstr = " + sStrCtl;
	   	}
	   	
	   	
	   	sPrepStmt += " order by MHCTLID desc";       	
      	
       	System.out.println(sPrepStmt);
       	
      	ResultSet rslset = null;
      	RunSQLStmt runsql = new RunSQLStmt();
    	runsql.setPrepStmt(sPrepStmt);		   
    	runsql.runQuery();
    		   		   
    	Vector<String> vCtl = new Vector<String>();
    	Vector<String> vCStr = new Vector<String>();
    	Vector<String> vSts = new Vector<String>();
    	Vector<String> vName = new Vector<String>();
    	Vector<String> vRecUsr = new Vector<String>();
    	Vector<String> vRecDt = new Vector<String>();
    	Vector<String> vRecTm = new Vector<String>();
    	Vector<String> vCost = new Vector<String>();
    	Vector<String> vQty = new Vector<String>();
    	Vector<String> vApprUsr = new Vector<String>();
    	Vector<String> vApprDt = new Vector<String>();
    	Vector<String> vSbmUsr = new Vector<String>();
    	Vector<String> vSbmDt = new Vector<String>();
    	Vector<String> vProcDt = new Vector<String>();
    	Vector<String> vDefect = new Vector<String>();
    		   		   
    	while(runsql.readNextRecord())
    	{
    		vCtl.add(runsql.getData("Mhctlid"));
    		vCStr.add(runsql.getData("MHSTR"));
    		String sts = runsql.getData("MHCTLSTS").trim(); 
    		vSts.add(sts);
    		vName.add(runsql.getData("MHNAME"));
    		    		
    		String sEmp = runsql.getData("Mhemp");
    		if(!sEmp.equals("0"))
    		{
    			String sEmpNm = runsql.getData("ename");
    			vRecUsr.add( runsql.getData("MHRECUS") + "(" + sEmp + " " + sEmpNm + ")");
    			
    		}
    		else { vRecUsr.add(runsql.getData("MHRECUS")); }
    		
    		vRecDt.add(runsql.getData("MHRECDT"));
    		vRecTm.add(runsql.getData("MHRECTM"));
    		String cost = runsql.getData("cost");
    		if(cost == null){ cost = "0"; }
    		vCost.add(cost);
    		String qty = runsql.getData("qty");
    		if(qty == null){ qty = "0"; }
    		vQty.add(qty);
    		
    		String logdt = runsql.getData("apprdt");
    		String logus = runsql.getData("apprus");    				
    		if(logus != null && (sts.equals("Approved") || sts.equals("Processed"))){ vApprDt.add(logdt); vApprUsr.add(logus); }
    		else { vApprDt.add(""); vApprUsr.add(""); }
    		
    		logdt = runsql.getData("sbmdt");
    		logus = runsql.getData("sbmus");    				
    		if(logus != null){ vSbmDt.add(logdt); vSbmUsr.add(logus); }
    		else { vSbmDt.add(""); vSbmUsr.add(""); }
    		
    		logdt = runsql.getData("procdt");    				
    		if(logdt != null){ vProcDt.add(logdt); }
    		else { vProcDt.add(""); }
    		
    		vDefect.add(runsql.getData("MHDfct"));
        }
    	runsql.disconnect();
    	runsql = null;
    	
    	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();	
    	
    	String [] sCtl = vCtl.toArray(new String[]{});
    	String [] sCStr = vCStr.toArray(new String[]{});
    	String [] sSts = vSts.toArray(new String[]{});
    	String [] sName = vName.toArray(new String[]{});
    	String [] sRecUsr = vRecUsr.toArray(new String[]{});
    	String [] sRecDt = vRecDt.toArray(new String[]{});
    	String [] sRecTm = vRecTm.toArray(new String[]{});
    	String [] sCost = vCost.toArray(new String[]{});
    	String [] sQty = vQty.toArray(new String[]{});
    	String [] sApprUs = vApprUsr.toArray(new String[]{});
    	String [] sApprDt = vApprDt.toArray(new String[]{});
    	String [] sSbmUs = vSbmUsr.toArray(new String[]{});
    	String [] sSbmDt = vSbmDt.toArray(new String[]{});
    	String [] sProcDt = vProcDt.toArray(new String[]{});
    	String [] sDefect = vDefect.toArray(new String[]{});
    	    	
    	
       
       boolean bEmpReq = sUser.indexOf("cashr") >= 0 || sUser.indexOf("ecom") >= 0; 
       
       // get user authorization  
       sPrepStmt = "select estat from Rci.Rciemp where exists(select 1 from rci.PrUser" 
         + " where puuser='" + sUser + "' and erci=puauth)";       
       runsql = new RunSQLStmt();
       runsql.setPrepStmt(sPrepStmt);		   
       runsql.runQuery();       
       String dept = "";
       
       if(runsql.readNextRecord()) { dept = runsql.getData("estat"); }
       runsql.disconnect();
   	   runsql = null;
   	   
   	   String sUserAuth = "";
   	   if(dept.equals("112")){sUserAuth = "ALL";}
   	   else if(dept.equals("001")){sUserAuth = "GM";}
   	   else if(sUser.equals("vrozen") || sUser.equals("psnyder") || sUser.equals("jburke")){sUserAuth = "ALL";}
   	   else if(sUser.equals("gorozco") || sUser.equals("spaoli") || sUser.equals("bstein")){sUserAuth = "DM";}
   	   
   	   boolean bAllowDlt = !sUserAuth.equals("");
   	   String [] sArrSts = new String[]{"Open", "Submitted","Approved","Processed" };
   	   String [] sChkSts = new String[sArrSts.length];
   	   for(int i=0; i < sArrSts.length; i++)
   	   {
   	   	   sChkSts[i] = "";
   		   for(int j=0; j < sSelSts.length; j++)   			   
    	   {   
   			   
   			   if(sArrSts[i].equals(sSelSts[j]) )
   			   {
   				   sChkSts[i] = "checked";
   			   }
    	   }
   	   }
%>
<html>
<head>		 
	<title>MOS Control Selection</title>
</head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var User = "<%=sUser%>";
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var EmpReq = <%=bEmpReq%>;

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var StrCtl = "<%=sStrCtl%>";
var UserAuth = "<%=sUserAuth%>";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{    
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
  	popStrSelect();
  	document.all.tdComment.style.display="none";
  	document.all.tdComment1.style.display="none";
}
//==============================================================================
//Load Stores
//==============================================================================
function popStrSelect()
{
	document.all.SelStr.options[0] = new Option("--- Select Store ----","NONE");
	for (idx = 1; idx < ArrStr.length; idx++)
 	{
   		document.all.SelStr.options[idx] = new Option(ArrStr[idx] + " - " + ArrStrNm[idx],ArrStr[idx]);
 	}
	
	var start = 0;
	if(ArrStr.length <= 2){start=1;}
	for (i = 0, j=start; j < ArrStr.length; i++, j++)
 	{
   		document.all.StrCtl.options[i] = new Option(ArrStr[j] + " - " + ArrStrNm[j],ArrStr[j]);
   		if(StrCtl == ArrStr[j]){ document.all.StrCtl.selectedIndex = i; }
 	}
	
}
//==============================================================================
//show/hide comment input field
//==============================================================================
function showComment(obj)
{
	if(obj.checked)
	{
		document.all.tdComment.style.display="block";
	  	document.all.tdComment1.style.display="block";	
	}
	else
	{
		document.all.tdComment.style.display="none";
	  	document.all.tdComment1.style.display="none";
	}
}
//==============================================================================
// find object postition
//==============================================================================
function objPosition(obj)
{
   var pos = new Array(2);
   pos[0] = 0;
   pos[1] = 0;
   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var str = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;
  if(str=="NONE"){error=true; msg += "\nStore must be selected.";}
  
  var emp = "0";
  if(EmpReq)
  {
	  emp = document.all.Emp.value.trim();
	  if(emp==""){error=true; msg += "\nPlease enter your employee number";}
	  else if(isNaN(emp)){error=true; msg += "\nEmployee Number is not numeric";}
	  else if(eval(emp) <=0 ){error=true; msg += "\nEmployee Number nust be positive numeric number";}
	  else if (!isEmpNumValid(emp)){error = true; msg += "\nEmployee number is invalid."; }
  }
  
  var defect = " ";
  if(document.all.Defect[1].checked){ defect = "Y"; }
  if(!document.all.Defect[0].checked && !document.all.Defect[1].checked)
  { 
	  error=true; msg += "\nPlease select MOS or Defective Item(s).";
  }
  
  var bcomm = document.all.BComment.value.trim();
  
  if (error) alert(msg);
  else { sbmCtl(str, "0", bcomm, emp,defect, "ADDCTL"); }
  return error == false;
}
//==============================================================================
// Submit list
//==============================================================================
function sbmCtl(str, ctl, commt, emp,defect, action)
{
	if(isIE){ nwelem = window.frame3.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame3.document.createElement("div"); }
	else{ nwelem = window.frame3.contentDocument.createElement("div");}
	
	nwelem.id = "dvSbmCtl";	
		
	var html = "<form name='frmAddCtl'"
   	+ " METHOD=Post ACTION='MosCtlSv.jsp'>"
   	+ "<input class='Small' name='Str'>"
   	+ "<input class='Small' name='Ctl'>"   	
   	+ "<input class='Small' name='Commt'>"
   	+ "<input class='Small' name='Defect'>"
   	+ "<input class='Small' name='Emp'>"
   	+ "<input class='Small' name='Action'>"       
 	+ "</form>"
 	;

	nwelem.innerHTML = html; 
	
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame3.document.appendChild(nwelem); }
    else if(isIE){ window.frame3.document.body.appendChild(nwelem); }
    else if(isSafari){ window.frame3.document.body.appendChild(nwelem); }
    else{ window.frame3.contentDocument.body.appendChild(nwelem); }
	 
	if(isIE || isSafari)
	{
		window.frame3.document.all.Str.value=str;
		window.frame3.document.all.Ctl.value=ctl;
		window.frame3.document.all.Commt.value=commt;
		window.frame3.document.all.Emp.value=emp;
		window.frame3.document.all.Defect.value=defect;
		window.frame3.document.all.Action.value=action;	

		window.frame3.document.frmAddCtl.submit();
	}
	else 
	{		 
		window.frame3.contentDocument.forms[0].Str.value=str;
		window.frame3.contentDocument.forms[0].Ctl.value=ctl;
		window.frame3.contentDocument.forms[0].Commt.value=commt;
		window.frame3.contentDocument.forms[0].Emp.value=emp;
		window.frame3.contentDocument.forms[0].Defect.value=defect;
		window.frame3.contentDocument.forms[0].Action.value=action;
		
		window.frame3.contentDocument.forms[0].submit();
	}
}
//==============================================================================
// go to new control
//==============================================================================
function gotoNewCtl()
{
}
//==============================================================================
// close Submitting frame
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   alert("Report has been submitted")
}

//==============================================================================
// delete Batch number and Items belong to batch
//==============================================================================
function dltBatch()
{
   if(BCrtByUser[document.all.Batch.selectedIndex - 1] == "<%=sUser%>"
      || "<%=sUser%>" == "vrozen" || "<%=sUser%>" == "phelfert")
   {

      var batch = document.all.Batch.options[document.all.Batch.selectedIndex].value.trim();
      var comment = document.all.Batch.options[document.all.Batch.selectedIndex].text.trim();

      var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
        + "<tr>"
          + "<td class='BoxName' nowrap>Batch:" + comment + "</td>"
          + "<td class='BoxClose' valign=top>"
             +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
          + "</td></tr>"
        + "<tr><td class='Prompt' colspan=2>" + popBatch(batch) + "</td></tr></table>"

      document.all.dvItem.innerHTML = html;
      document.all.dvItem.style.pixelLeft=200;
      document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
      document.all.dvItem.style.visibility = "visible";
   }
   else { alert("This batch is not created by you.\nYou may to delete only your own batch.") }
}
//==============================================================================
// populate batch deletion panel
//==============================================================================
function popBatch(batch)
{
  var panel = "<table border=0 style='font-size:16px; font-weight:bold' width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td >Delete selected batch number and all items assign for this batch.</td></tr>"
         + "<tr><td style='color:red;'>Do you want to delete this batch?</td></tr>"

  panel += "<tr><td class='Prompt1' colspan='5'><br>"
        + "<button style='font-size:10px' onClick='sbmBatchDlt(&#34;" + batch + "&#34;);' >Delete</button> &nbsp; &nbsp;"
        + "<button style='font-size:10px' onClick='hidePanel();' >Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// submit control number 
//==============================================================================
function sbmBatchDlt(batch)
{
  var url = 'MosCtlDtl.jsp?'
    + "Batch=" + batch
    + "&ACTION=DLTBATCH";

    if(confirm("This is a last chance. Are You Sure?????"))
   {
       document.all.btnOpenWdw.style.visibility='hidden';
       document.all.btnDltBatch.style.visibility='hidden';

       //alert(url);
       //window.location.href = url;
       window.frame2.location = url;       
   }

   hidePanel();
}
//==============================================================================
// show Mos List for selected control number   
//==============================================================================
function  showMosLst(ctl)
{
	var url = "MosCtlInfo.jsp?Ctl=" + ctl
	window.location.href = url;
}
//==============================================================================
// delete batch number 
//==============================================================================
function dltCtl(i ,ctl, user)
{	
	//if(User != user)
	//{
		//var nm = "tdName" + i;		
		//var name = document.all[nm].innerHTML;

	    var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	        + "<tr>"
	          + "<td class='BoxName' nowrap>Control: " + ctl + "</td>"
	          + "<td class='BoxClose' valign=top>"
	             +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	          + "</td></tr>"
	        + "<tr><td class='Prompt' colspan=2>" + popCtl(ctl, name) + "</td></tr></table>"

	      document.all.dvItem.innerHTML = html;
	      document.all.dvItem.style.pixelLeft=200;
	      document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	      document.all.dvItem.style.visibility = "visible";
	  // }
	  // else { alert("This batch is not created by you.\nYou may to delete only your own batch.") }
	}
//==============================================================================
// populate batch deletion panel
//==============================================================================
function popCtl(ctl, name)
{
  var panel = "<table border=0 style='font-size:16px; font-weight:bold' width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td >Delete selected control number and all items assign for this control.</td></tr>"
         + "<tr><td style='color:red;'>Do you want to delete this control?</td></tr>"
  panel += "<tr><td class='Prompt1' colspan='5'><br>"
        + "<button style='font-size:10px' onClick='sbmCtlDlt(&#34;" + ctl + "&#34;);' >Delete</button> &nbsp; &nbsp;"
        + "<button style='font-size:10px' onClick='hidePanel();' >Close</button></td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// submit control deletion
//==============================================================================
function sbmCtlDlt(ctl)
{
	var url = 'MosCtlSv.jsp?'
  		+ "Ctl=" + ctl
  		+ "&Action=DLTCTL";

  	if(confirm("This is a last chance. Are You Sure?????"))
 	{
     	window.frame2.location = url;     	
 	}

 	hidePanel();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//check employee number
//==============================================================================
function isEmpNumValid(emp)
{
var valid = true;
var url = "EComItmAsgValidEmp.jsp?Emp=" + emp;
var xmlhttp;
// code for IE7+, Firefox, Chrome, Opera, Safari
if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
// code for IE6, IE5
else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

xmlhttp.onreadystatechange=function()
{
   if (xmlhttp.readyState==4 && xmlhttp.status==200)
   {
      valid = xmlhttp.responseText.indexOf("true") >= 0;
   }
}
xmlhttp.open("GET",url,false); // synchronize with this apps
xmlhttp.send();

return valid;
}
//==============================================================================
//check All Status
//==============================================================================
function chkStsAll(sel)
{
	var sts = document.all.Sts;
	for(var i=0; i < sts.length; i++) { sts[i].checked = sel; }
}
//==============================================================================
//check All Status
//==============================================================================
function sbmSelSts()
{
	var url = "MosCtlSel.jsp?";
	var sts = document.all.Sts;
	for(var i=0; i < sts.length; i++) 
	{ 
		if(sts[i].checked)
		{
			url += "&Sts=" + sts[i].value;
		}	
	}
	
	var str = document.all.StrCtl[document.all.StrCtl.selectedIndex].value;
	url += "&Str=" + str;
	
	window.location.href = url;
} 

//==============================================================================
//check All Status
//==============================================================================
function gotoCtl()
{
	var msg = "";
	var error = false;
	
	var ctl = document.all.SelCtl.value.trim();
	if(ctl == "") { error = true; msg = "Please, type Control Number";}
	else if(isNaN(ctl)) { error = true; msg = "The Control Number must be numeric";}
	else if(eval(ctl) <= 0) { error = true; msg = "The Control Number must be greater then 0";}
	
	if(!error)
	{
		var url = "MosCtlInfo.jsp?Ctl=" + ctl;
		window.location.href = url;
	}
	else
	{
	    alert(msg);	
	}
		
}
</script>


<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>



<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<iframe id="frame2" src="" frameborder=0 height="0" width="0"></iframe>
<iframe id="frame3" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvItem" class="dvItem"></div>
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/1.0 MOS - Entry.pdf" title="Click here for help" class="helpLink" target="_blank">&nbsp;</a></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--  TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD>
  </TR -->
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>MOS/Defective Item(s) Return Entry - Selection </B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE border=0>
        <TBODY>
        
        
        <!-- ========================== Vendor ============================== -->
        
        <tr class="trDtl19">
            <TD class="td09" colspan=2>Store:
            	<select class="Small" name="SelStr"></select>
            </TD>
        </tr>        
        <%if(bEmpReq){%>
        	<tr class="trDtl19">
            	<TD class="td07" >Employee:</TD>
            	<TD class="td08" nowrap>
            		<input class="Small" name="Emp" maxlength=4 size=6>
            	</TD>
        	</tr>
        <%}%>
        <tr class="trDtl19">
        	<TD class="td09" id="tdDefect" colspan=2>Please select one of the following:              
              <input type="radio" class="Small" name="Defect" value=" ">
              MOS
              <input type="radio" class="Small" name="Defect" value="Y">
              Defective Item(s) Return             
            </TD>
        </tr>
        <tr class="trDtl19">
        	<TD class="td07" id="tdComment">Comments:</td>
        	<TD class="td08"  id="tdComment1" nowrap>
              <input class="Small" name="BComment" size=100 maxlength=100>              
            </TD>
        </tr>
        <tr  class="trDtl19">           
        	<TD  class="td09"  colspan=2>        	
        	<button onClick="Validate()">Create a New Control #</button><br>
        	</TD>
        </tr>
        <!-- ========================== Control ============================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr style="text-align:center">
        	<td colspan=4 style="text-align:center">
        	<b>Select Control# Statuses:</b><br>
        	
        	<a class="Small" href="javascript: chkStsAll(true)">All</a> &nbsp; &nbsp;
            <a class="Small" href="javascript: chkStsAll(false)">Reset</a>
            <input class="Small" name="Sts" type="checkbox" value="Open" <%=sChkSts[0]%>>Open &nbsp;
            <input class="Small" name="Sts" type="checkbox" value="Submitted" <%=sChkSts[1]%>>Submitted &nbsp;
            <input class="Small" name="Sts" type="checkbox" value="Approved"  <%=sChkSts[2]%>>Approved &nbsp;
            <input class="Small" name="Sts" type="checkbox" value="Processed" <%=sChkSts[3]%>>Processed &nbsp;
            <!-- button class="Small" onclick="sbmSelSts()">Go</button -->
            </td>
        </tr>
            
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr style="text-align:center">
        	<td colspan=4 style="text-align:center">
        	<b>Select Control#:</b><br>
        	<span style="font-size:11px">(to Add SKUs or Update Control #)</span>
        	<br>
        	Store: <select class="Small" name="StrCtl"></select>&nbsp;
        	<button class="Small" onclick="sbmSelSts()">Go</button>
        	
        	<%if(sUser.equals("vrozen") || sUser.equals("psnyder")){%>
        	  	<span style="font-size:12px">
        	  	&nbsp; &nbsp; &nbsp; 
        			Display Ctl#: 
        			<input name="SelCtl" class="Small"> &nbsp; 
        			<button onclick="gotoCtl()" class="Small">Go</button>
        		</span>
        	<%}%>
            
        	<br>
        		<div id="dvCtlExt" style="border: gray solid 1px;
                          width:500; height:150; z-index:10; 
                          text-align:center; font-size:10px">
        		<div id="dvCtlInt" style="text-align:center; width: 1000px; height: 300px; overflow: auto; font-size:10px">        		   	
        			<table border=1 cellPadding="0" cellSpacing="0">
        			  <thead>
        			  <tr class="trHdr05" >
        				<th class="th08" style="width:50px">Control</th>
        				<th class="th08">Store</th>
        				<th class="th08">MOS<br>or<br>Defect</th>
        				<th class="th08">Status</th>
        				<th class="th08">Date</th>
        				<th class="th08">User</th>        	
        				<th class="th08">Total<br>Qty</th>			
        				<th class="th08">Total<br>Cost</th>
        				<th class="th08">Submitted<br>Date</th>
        				<th class="th08">Submitted<br>by User</th>
        				<th class="th08">Approved<br>Date</th>
        				<th class="th08">Approved<br>by User</th>
        				<th class="th08">Processed<br>Date</th>        				
        				<%if(bAllowDlt){%><th class="th08">Dlt</th><%}%>
        		      </tr>
        		      </thead>
        		       		 
        			  <%for(int i=0; i < sCtl.length; i++){%>
        				<tr class="trDtl06">
        				  <td id="tdCtl<%=i%>" class="td49" style="width:50px;"><a href="javascript: showMosLst('<%=sCtl[i]%>')"><%=sCtl[i]%></a></td>
        				  <td id="tdVen<%=i%>" class="td48"><%=sCStr[i]%></td>
        				  <td id="tdVen<%=i%>" class="td50">
        				     <%if(sDefect[i].equals("Y")){%>DEFECT<%} else {%>MOS<%}%>
        				  </td>
        				  <td id="tdSts<%=i%>" class="td48" nowrap><%=sSts[i]%></td>
        				  <td id="tdUsr<%=i%>" class="td48" nowrap><%=sRecDt[i]%></td>
        				  <td id="tdUsr<%=i%>" class="td48" nowrap><%=sRecUsr[i]%></td>
        				  <td id="tdQty<%=i%>" class="td49" nowrap><%=sQty[i]%></td>
        				  <td id="tdCost<%=i%>" class="td49" nowrap>$<%=sCost[i]%></td>
        				  <td id="tdSbmDt<%=i%>" class="td48" nowrap><%=sSbmDt[i]%>&nbsp;</td>
        				  <td id="tdSbmUs<%=i%>" class="td48" nowrap><%=sSbmUs[i]%>&nbsp;</td>
        				  <td id="tdApprDt<%=i%>" class="td48" nowrap><%=sApprDt[i]%>&nbsp;</td>
        				  <td id="tdApprUs<%=i%>" class="td48" nowrap><%=sApprUs[i]%>&nbsp;</td>
        				  <td id="tdProcDt<%=i%>" class="td48" nowrap><%=sProcDt[i]%>&nbsp;</td>
        				  <%if(bAllowDlt){%>       	
        				  	<td class="td49">
        				  	    <%if(!sSts[i].equals("Processed")){%>
        				  		<a href="javascript: dltCtl('<%=i%>','<%=sCtl[i]%>', '<%=sRecUsr[i]%>')">D</a>
        				  		<%} else {%>&nbsp;<%}%>
        				  	</td>
        				  <%}%>			  
        				</tr>  
        			  <%}%>
        			</table>
        		</div>
        		</div>  
        	</td>
        </tr>
         
         </TBODY>
        </TABLE>
        <br>&nbsp;<br>
        
     	
         
      </TD>
     </TR>
      
     	
         
    </TBODY>
   </TABLE>
</BODY></HTML>
<%} %>