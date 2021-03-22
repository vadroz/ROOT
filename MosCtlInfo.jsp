<%@ page import="mosregister.MosCtlInfo, rciutility.RunSQLStmt, java.sql.*
	, rciutility.StoreSelect, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
   String sSelCtl = request.getParameter("Ctl");   

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MosCtlInfo.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sStrAllowed = session.getAttribute("STORE").toString();    
      
      MosCtlInfo ctlinfo = new MosCtlInfo();
  	  ctlinfo.setCtlInfo(sSelCtl, sUser);  	 
	  ctlinfo.setCtlInfo();
	  
	  String sUserAuth = ctlinfo.getUserAuth();
	
	  String sStr = ctlinfo.getStr();
	  String sCtlSts = ctlinfo.getCtlSts();
	  String sName = ctlinfo.getName();
	  String sCtlUsr = ctlinfo.getCtlUsr();
	  String sCtlDt = ctlinfo.getCtlDt();
	  String sCtlTm = ctlinfo.getCtlTm();
	  String sDefect = ctlinfo.getDefect();
	  String sReg = ctlinfo.getReg();
	  
	  String sHdrStsJva = ctlinfo.getHdrStsJva();
  	  String sItmStsJva = ctlinfo.getItmStsJva();
	  	  
  	  // ------ get list of reasons -------
  	  String sPrepStmt = "select MRREAS,MRACTREQ, MRSUBC"
  		   	 + " from rci.MKHDREAS"
  	       	 + " order by MRSORT";       	
  	      	
  	  //System.out.println(sPrepStmt);
  	       	
  	  ResultSet rslset = null;
  	  RunSQLStmt runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	    		   		   
  	  Vector<String> vReason = new Vector<String>();
  	  Vector<String> vActReq = new Vector<String>();
  	  Vector<String> vSubCat = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {
  		  vReason.add(runsql.getData("MRREAS").trim());
  		  vActReq.add(runsql.getData("MRACTREQ").trim());
  		  vSubCat.add(runsql.getData("MRSubC").trim());
  	  }  	    		    
  	  CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
  	  String [] sReason = vReason.toArray(new String[]{});
  	  String [] sActReq = vActReq.toArray(new String[]{});
  	  String [] sSubCat = vSubCat.toArray(new String[]{});
  	  
  	  String sReasonJsa = srvpgm.cvtToJavaScriptArray(sReason);
  	  String sActReqJsa = srvpgm.cvtToJavaScriptArray(sActReq);
  	  String sSubCatJsa = srvpgm.cvtToJavaScriptArray(sSubCat);
  	  
  	  // ------ get list of defect natures -------
  	  sPrepStmt = "select MDDEFECT"
  		   	 + " from rci.MKDEFECT"
  	       	 + " order by MDSORT";       	
  	      	
  	  //System.out.println(sPrepStmt);
  	       	
  	  rslset = null;
  	  runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	    		   		   
  	  Vector<String> vDfcLst = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {
  		  vDfcLst.add(runsql.getData("MdDefect").trim());
  	  }  	    		    
  	  srvpgm = new CallAs400SrvPgmSup();
  	  String [] sDfcLst = vDfcLst.toArray(new String[]{});
  	  String sDfcLstJsa = srvpgm.cvtToJavaScriptArray(sDfcLst);
  	  //------------------------------------------------------
  	  
  	  // ------ get list of subcategory -------
  	  sPrepStmt = "select MRREAS,MRSCAT,MRSORT"
  		   	 + " from rci.MKRECAT"
  	       	 + " order by MRSORT";       	
  	      	
  	  //System.out.println(sPrepStmt);
  	       	
  	  rslset = null;
  	  runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	    		   		   
  	  Vector<String> vScReas = new Vector<String>();
  	  Vector<String> vScCateg = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {
  		vScReas.add(runsql.getData("MrReas").trim());
  		vScCateg.add(runsql.getData("MrSCat").trim());  		
  	  }  	    		    
  	  srvpgm = new CallAs400SrvPgmSup();
  	  String [] sScReas = vScReas.toArray(new String[]{});
  	  String [] sScCateg = vScCateg.toArray(new String[]{});
  	  String sScReasJsa = srvpgm.cvtToJavaScriptArray(sScReas);
  	  String sScCategJsa = srvpgm.cvtToJavaScriptArray(sScCateg);
  	  //------------------------------------------------------
  	  
  	  // ------ get list of defect natures -------
  	  sPrepStmt = "select MAAREA"
  		   	 + " from rci.MKAREA"
  	       	 + " order by MASORT";       	
  	      	
  	  //System.out.println(sPrepStmt);
  	       	
  	  rslset = null;
  	  runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	    		   		   
  	  Vector<String> vArea = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {
  		  vArea.add(runsql.getData("MaArea").trim());
  	  }  	    		    
  	  srvpgm = new CallAs400SrvPgmSup();
  	  String [] sAreaLst = vArea.toArray(new String[]{});
  	  String sAreaLstJsa = srvpgm.cvtToJavaScriptArray(sAreaLst);
  	  //------------------------------------------------------
  	  
  	  boolean bEmpReq = sUser.indexOf("cashr") >= 0 || sUser.indexOf("ecom") >= 0; 
  	  
  	  // get store region
  	  StoreSelect strsel = new StoreSelect(sStr);
  	  String [] sDM = new String[]{"gorozco@sunandski.com", "spaoli@sunandski.com", "kknight@sunandski.com"};
  	  String sDMEmail = "jburke@sunandski.com";
  	  if(sReg.equals("1")){sDMEmail = sDM[0];}
  	  else if(sReg.equals("2")){sDMEmail = sDM[1];}
  	  else if(sReg.equals("3")){sDMEmail = sDM[2];}
  	  
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
  	   
  	  String sAuth = "";
  	  if(dept.equals("112")){sAuth = "ALL";}
  	  else if(dept.equals("001") || dept.equals("002") || dept.equals("963")
  			|| dept.equals("861")) { sAuth = "GM";}
  	  else if(sUser.equals("vrozen") || sUser.equals("psnyder") || sUser.equals("srutherfor") 
  		|| sUser.equals("jburke")){sAuth = "ALL";}
  	  else if(sUser.equals("gorozco") || sUser.equals("spaoli") || sUser.equals("bstein") ){sAuth = "DM";}
  	   
  	  boolean bAllowDlt = !sAuth.equals("");  
  	  boolean bAllowSbm = session.getAttribute("MOSHO") != null;
  	  boolean bAllowUpd = session.getAttribute("MOSDM") != null;
 
%> 
<html>
<head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<style type="text/css" media="print">  
  .NonPrt  { display:none; }
  #Auto { display:none; }
    
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
// orser header info
var CtlNum = "<%=sSelCtl%>";
var StrAllowed = "<%=sStrAllowed%>";
var Store = "<%=sStr%>";
var User = "<%=sUser%>";
var CtlSts = "<%=sCtlSts%>";
var Reason = [<%=sReasonJsa%>];
var ActReq = [<%=sActReqJsa%>];
var SubCat = [<%=sSubCatJsa%>];
var DefectLst = [<%=sDfcLstJsa%>];
var Defect = "<%=sDefect%>"
var Area = [<%=sAreaLstJsa%>];

var ScReas = [<%=sScReasJsa%>];
var ScCateg = [<%=sScCategJsa%>];

var NewSku = "";
var NewDesc = "";
var NewStrQty = "";
var NewOnRtv = "";
var NewOnMos = "";
var NewRemind = "";
var NewRet = "";
var NewDiv = "";
var NewCls = "";

var Excluded = false;
var ExclQty = "";
var ExclDate = "";

var UserAuth = "<%=sAuth%>"; 
var AllowSbm = <%=bAllowSbm%>;
var EmpReq = <%=bEmpReq%>;

var HdrStsLst = [<%=sHdrStsJva%>];
var ItmStsLst = [<%=sItmStsJva%>];

var ItemWithPic = new Array();
var PicPath = new Array();
var ItemPicArg = 0;
var PoNum = null;
var DocNum = null;

var IaName = null;
var IaAddr = null;
var IaCity = null;
var IaState = null;
var IaZip = null;
var IaPhone = null;

var TfDate = null;
var TfTime = null;
var TfPlace = null;
var TfArea = null;
var TfFoundBy = null;
var TfMgr = null;
var TfCommt = null; 

var ArrDfc = new Array();

var ItemExists = false;
var DMEmail = "<%=sDMEmail%>";

var SwimCls = ["704","710","711","9586","630","708","713","714","715","716","9797","3650","3660"];
var ConsumCls = ["7758", "9410","0604", "92"];
var ShowDiv = ["40", "41"];
var ToolObj = null;

var FirstItmCommt = "";

var DispAddInf = false;
var RowNum="0";
var TheftFlag = false;
var GrossrootFlag = false;
var Reload = false;

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvPhoto", "dvReason", "dvToolTip"]);
   
   document.all.spnStsEmail.style.display = "none";
   setItmStsVis(true);
   
   rtvCtlComments();
   
   rtvItemComments();
   rtvItemPictures();   
   rtvLogEntires();

   //if(CtlSts != "Open" && CtlSts != "Processed"){ document.all.trLinks1.style.display = "none"; }
}
//==============================================================================
// add Ctl comments
//==============================================================================
function addCtlHdrCommt(id, text, action)
{
   var hdr = "Claim Comments";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCtlCommentsPanel(id, action)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "300";}
   else { document.all.dvItem.style.width = "auto";}
   
   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.left= document.documentElement.scrollLeft + 40;
   document.all.dvItem.style.top= document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";

   if(text != null){document.all.Comm.value=text;}
   if(action == "DELETE"){document.all.Comm.readOnly=true;}
   document.all.CommId.value = id;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popCtlCommentsPanel(id, action)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<td class='Prompt' nowrap><textarea name='txaComm' id='txaComm' cols='100' rows='5'></textarea>"
           + "<input name='CommId' type='hidden'>"
         + "</td>"
       + "</tr>"

  panel += "<tr>";
  if(action=="ADD")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;ADD_CLM_COMMENT&#34;)' class='Small'>Add Comments</button>&nbsp;"
  }
  else if(action=="UPDATE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;UPD_CLM_COMMENT&#34;)' class='Small'>Update Comments</button>&nbsp;"
  }
  else if(action=="DELETE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;DLT_CLM_COMMENT&#34;)' class='Small'>Delte Comments</button>&nbsp;"
  }

  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}


//==============================================================================
// change status menu
//==============================================================================
function chgStatusMenu()
{   
   if(ItemExists && (UserAuth == "ALL" && CtlSts != "Processed"
     || UserAuth == "GM" && CtlSts != "Approved" && CtlSts != "Processed"
     || AllowSbm && CtlSts != "Approved" && CtlSts != "Processed"))
   {
	   var hdr = "Change Control Number Status";

   	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     	+ "<tr>"
       		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
       		+ "<td class='BoxClose' valign=top>"
         		+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       		+ "</td></tr>"
    	+ "<tr><td class='Prompt' colspan=2>" + popChgStsPanel() + "</td></tr>"
   	   + "</table>"

       document.all.dvItem.innerHTML = html;
   	   document.all.dvItem.style.width = 300;
   	   document.all.dvItem.style.left= document.documentElement.scrollLeft + 300;
   	   document.all.dvItem.style.top= document.documentElement.scrollTop + 125;
   	   document.all.dvItem.style.visibility = "visible";

       chkCurSelSts();
   }
   else
   {
	   if(ItemExists){alert("Status cannot be changed");}
	   else{{alert("There is not a single item on the control. Status cannot be changed.");}}
   }
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popChgStsPanel()
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  
  if((UserAuth == "GM" || UserAuth == "DM" || UserAuth == "ALL") && CtlSts != "Approved" && CtlSts != "Processed"
	  || AllowSbm && CtlSts != "Approved" && CtlSts != "Processed"
		  )	 
  {
	  panel += "<tr><td class='Prompt' nowrap><input name='CtlSts' type='radio' value='" + HdrStsLst[0] + "'></td>"
      	+ "<td class='Prompt' nowrap>" + HdrStsLst[0] + "</td>"
     	+ "</tr>";
	  panel += "<tr><td class='Prompt' nowrap><input name='CtlSts' type='radio' value='" + HdrStsLst[1] + "'></td>"
    	+ "<td class='Prompt' nowrap>" + HdrStsLst[1] + "</td>"
   		+ "</tr>";	
  }
  
  if((User == "psnyder" || User == "srutherfor"  || User == "vrozen" || User == "jburke")
		  && CtlSts != "Processed")
  {
	  
	  panel += "<tr><td class='Prompt' nowrap><input name='CtlSts' type='radio' value='" + HdrStsLst[2] + "'></td>"
      	+ "<td class='Prompt' nowrap>" + HdrStsLst[2] + "</td>"
     	+ "</tr>";
	  panel += "<tr><td class='Prompt' nowrap><input name='CtlSts' type='radio' value='" + HdrStsLst[3] + "'></td>"
    	+ "<td class='Prompt' nowrap>" + HdrStsLst[3] + "</td>"
   		+ "</tr>";	
	  
  }
  
  
  panel += "<tr>";
  panel += "<td class='Prompt1' colspan=2><br><br><button onClick='ValidateCtlSts(&#34;Chg_Ctl_Sts&#34;)' class='Small'>Submit</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";

  return panel;
}

//==============================================================================
// populate dropdown menu for item issues
//==============================================================================
function chkCurSelSts()
{
   for(var i=0; i < HdrStsLst.length; i++)
   {
      if(HdrStsLst[i]==CtlSts && document.all.CtlSts[i] != null) 
      { 
    	  document.all.CtlSts[i].checked = true; 
      }
   }
}
//==============================================================================
//change Item Status Menu
//==============================================================================
function chgItmStsMenu(item, sku, sts)
{
	var hdr = "Change Item Status. SKU: " + sku;

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	  + "<tr>"
	     + "<td class='BoxName' nowrap>" + hdr + "</td>"
	     + "<td class='BoxClose' valign=top>"
	       +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	     + "</td></tr>"
	  + "<tr><td class='Prompt' colspan=2>" + popItmStsPanel()
	     + "</td></tr>"
	+ "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left= document.documentElement.scrollLeft + 300;
	document.all.dvItem.style.top= document.documentElement.scrollTop + 125;
	document.all.dvItem.style.visibility = "visible";
	
	for(var i=0; i < ItmStsLst.length; i++)
	{
		if(ItmStsLst[i]==sts) { document.all.ItmSts[i].checked = true; }
	}
	document.all.ItemId.value = item;
}
//==============================================================================
//populate Entry Panel
//==============================================================================
function popItmStsPanel()
{	
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

	for(var i=0; i < ItmStsLst.length; i++)
	{
  		panel += "<tr><td class='Prompt' nowrap><input name='ItmSts' type='radio' value='" + ItmStsLst[i] + "'></td>"
      		+ "<td class='Prompt' nowrap>" + ItmStsLst[i]
      		+ "<input type='hidden' name='ItemId'>"
      		+ "</td>"
    	+ "</tr>"
	}

	panel += "<tr>";
	panel += "<td class='Prompt1' colspan=2><br><br><button onClick='ValidateItmSts(&#34;Chg_Itm_Sts&#34;)' class='Small'>Submit</button>&nbsp;"
	panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
	panel += "</table>";

	return panel;
}
//==============================================================================
//validate ctl status
//==============================================================================
function ValidateItmSts(action)
{
	var error = false;
	var msg = "";
	var sts = null;

	for(var i=0; i < document.all.ItmSts.length; i++)
	{
		if( document.all.ItmSts[i].checked ) { sts = document.all.ItmSts[i].value.trim(); break; }
	}
	var item = document.all.ItemId.value;
	

	if(error){ alert(msg); }
	else { sbmItmSts(item, sts, action) }
}
//==============================================================================
//submit item status
//==============================================================================
function sbmItmSts(item, sts, action)
{	
	var url = "MosCtlSv.jsp?"
		+ "&Ctl=" + CtlNum
		+ "&Sku=" + item
		+ "&Sts=" + sts
		+ "&Action=" + action

	//alert(url)
	window.frame1.location.href = url;
	hidePanel()
}
//==============================================================================
// populate Control Status from dropdown menu
//==============================================================================
function setCtlSts(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.CtlSts.value = ddmenu.options[i].value;
    }
}
//==============================================================================
// add item comments
//==============================================================================
function addItmComments(item, sku, id, text, action)
{
   var hdr = "SKU " + sku + " Comments";
   var html = "<table border=0 cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
      + "<tr><td class='Prompt' colspan=2>" + popItemCommentsPanel(item, sku, id, text, action) + "</td></tr>"
   + "</table>"
   
   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.left= document.documentElement.scrollLeft + 40;
   document.all.dvItem.style.top= document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";   
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popItemCommentsPanel(item, sku, id, text, action)
{
  var panel = "<table border=1 cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td ><textarea name='txaComm' id='txaComm'  cols=100 rows=5></textarea>"
          + "<input name='CommId' type='hidden'>"
          + "</td>"
       + "</tr>"

  panel += "<tr><td><br><br><button onClick='ValidateItemCommt(&#34;ADD_ITM_COMMENT&#34;, &#34;" + item + "&#34;)' class='Small'>Add Comments</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel1()
{
	document.all.dvReason.style.visibility = "hidden";
}

//==============================================================================
//change Control Number item properties
//==============================================================================
function chgCtlItm(action, item, sku, qty, reas, subcat)
{
   PoNum = null;
   var hdr = "Add Item";
   if(action=="DLT_ITEM"){ hdr = "Delete Item"; }
   if(action=="UPD_ITEM"){ hdr = "Update Item"; }
    
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCtlItmPanel(action)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "400";}
   else { document.all.dvItem.style.width = "auto";}
   
   document.all.dvItem.innerHTML = html; 
   document.all.dvItem.style.left= document.documentElement.scrollLeft + 200;
   document.all.dvItem.style.top= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
   
   if(!Defect){ document.all.tbdDefect.style.display = "none"; }   
   
   if(action=="DLT_ITEM" || action=="UPD_ITEM")
   {
	   document.all.Search.readOnly = true;
	   document.all.Search.value = sku;
	   document.all.trCommt.style.display = "none";
	   if(action=="DLT_ITEM") { document.all.trQty.readOnly = true;}
	   document.all.Qty.value = qty;
	   document.all.SvQty.value = qty;
	   document.all.ItmId.value = item;
	   document.all.Reason.value = reas;
	   
	   //additioanl information
	   document.all.tbdAddInf.style.display = showAddInfo(reas);
	   document.all.tbdCrime.style.display = showTheftInfo(reas);
	   document.all.tbdSubCat.style.display = showSubCatInfo(reas, subcat);
	   
	   search = getScannedItem(sku);
	   document.all.spnOnHand.innerHTML = NewStrQty; 
	   document.all.spnOnRtv.innerHTML = NewOnRtv;
	   document.all.spnOnMos.innerHTML = NewOnMos;
	   document.all.spnRemind.innerHTML = NewRemind;
	   document.all.spnRet.innerHTML = NewRet;
	   
	   
	   if(isItemAddInfoReq(reas, "AddInfo") && getItemAddInfo(item, "AddInfo", null))
	   {
		   document.all.Name.value = IaName;
		   document.all.Addr.value = IaAddr;
		   document.all.City.value = IaCity;
		   document.all.State.value = IaState;
		   document.all.Zip.value = IaZip;
		   document.all.Phone.value = IaPhone;		   
	   }
	   if(isItemAddInfoReq(reas,  "Crime") && getItemAddInfo(item, "Crime", null))
	   {
		   document.all.Date.value = TfDate;
		   document.all.Time.value = TfTime;
		   document.all.Place.value = TfPlace;
		   document.all.Area.value = TfArea;
		   document.all.FoundBy.value = TfFoundBy;
		   document.all.Mgr.value = TfMgr;
		   document.all.TheftCmt.value = TfCommt;
	   }
	   if(Defect && getItemAddInfo(item, "Defect", null))
	   {
		   for(var i=0; i < DefectLst.length ;i++)
		   {
			   for(var j=0; j < ArrDfc.length ;j++)
			   {
			       if(DefectLst[i]==ArrDfc[j])
			       {
			  	   		document.all.Dfc[i].checked = true;
			       }
			   }
		   }    	
	   }
   }
   if(action=="ADD_ITEM")
   {
	   if(!EmpReq){ document.all.Search.focus(); }
	   else{ document.all.Emp.focus(); } 
	   document.all.Qty.value = "1";
	   document.all.SvQty.value = "0";
	   document.all.tbdAddInf.style.display = "none"; //additioanl information
	   document.all.tbdCrime.style.display = "none"; // theft info
	   document.all.tbdSubCat.style.display = "none"; //reason subcategory
	   document.all.tbdDefect.style.display = "none"; // nature of defect	   
	   var date = new Date();
	   document.all.Date.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   }
	
   // set reason or preset for other
   if(Defect == "Y"){ setOtherReas(); }
   else
   { 
	   popReason();
	   popArea();
   }
   
   document.all.tdNote.innerHTML = "";
   if(Excluded)
   { 
	   var exqty = eval(document.all.Qty.value) + eval(ExclQty);
	   document.all.tdNote.innerHTML = "ECOM Exclusions for this SKU already exist."
	    + "<br>With this entry a total Qty of " + exqty + ", will now be excluded from ECOM Fulfillments.";
	   document.all.tdNote.style.color="red";
   }
   else
   {
	   document.all.tdNote.innerHTML = "This SKU/QTY will be excluded from ECOM Fulfillments, until 'Processed' out of inventory.";
	   document.all.tdNote.style.color="green";
   }
   
}
//==============================================================================
// check to show or not additional info
//==============================================================================
function showAddInfo(reas)
{
	var disp = "none";
	for(var i=0; i < Reason.length; i++)
	{
		if(Reason[i] == reas)
		{
			if(ActReq[i]=="AddInfo"){ disp = "block"; }
			break;
		}				
	}
	return disp;
}
//==============================================================================
//show theft additioanl information
//==============================================================================
function showTheftInfo(reas)
{
	var disp = "none";
	for(var i=0; i < Reason.length; i++)
	{
		if(Reason[i] == reas)
		{
			if(ActReq[i]=="Crime"){ disp = "block"; }
			break;
		}				
	}
	return disp;
}
//==============================================================================
//show reason subcategory
//==============================================================================
function showSubCatInfo(reas, subcat)
{
	var disp = "none";
	if(subcat != "")
	{ 
		disp = "block";
		setSubCateg(reas);
		for(var i=0; i < document.all.SubCat.length ;i++)
		{
			document.all.SubCat[i].checked=false;
			if(subcat == document.all.SubCat[i].value)
			{
				document.all.SubCat[i].checked=true;
			}
		}
	}
	
	return disp;
}
//==============================================================================
//check to show or not reason subcategory
//==============================================================================
function showSubCat(reas)
{
	var disp = "none";
	for(var i=0; i < Reason.length; i++)
	{
		if(Reason[i] == reas)
		{
			if(SubCat[i]=="Y"){ disp = "block"; }
			break;
		}				
	}
	return disp;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popCtlItmPanel(action)
{
  var panel = ""; 
  if(action=="DLT_ITEM")
  {
	  panel += "Are You shure that you want delete this item?"
  }
  
  panel += "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  if(EmpReq)
  {
  		panel += "<tr class='trHdr03'><td class='td33'>Employee #</td>"
   		   + "<td class='td32' nowrap colspan=2><input class='Small' name='Emp' size=6 maxlength=4></td>"
  } 		
  panel += "</tr>"
     +  "<tr class='trHdr03'><td class='td33'>Sku/UPC</td>"
            + "<td class='td32' nowrap colspan=2>" 
            	+ "<input class='Small' name='Search' onblur='ValidateSkuOnly(this,&#34;" + action + "&#34;)'>"
            + "&nbsp; &nbsp; <span id='spnDesc'></span>"
            + "<input type='hidden' name='ItmId'>"
            + "</td>"
     + "</tr>"
     
  panel += "<tr class='trHdr03'><td id='tdWarn' class='tdError' colspan=3></td></tr>"
  
  panel += "<tr class='trHdr03' id='trQty' ><td class='td33'>Quantity</td>"
         + "<td class='td32' nowrap colspan=2>" 
             + "<input class='Small' name='Qty' size=10 maxlength=5>"  
             + "<input type='hidden' name='SvQty'>"
         + "</td>"
         
  panel += "<tr class='trHdr03' id='trOnHand' nowrap><td class='td11' colspan=3>"
        + "<table class='tbl04' width='100%'>"
          + "<tr class='trHdr03'><td class='td48' width='30%'>Net On Hand</td><td class='td49' width='10%'><span id='spnOnHand'></span></td>"
            + "<td class='td48' width='10%'>&nbsp; &nbsp; </td>"
          	+ "<td class='td48' width='25%'>Retail</td><td class='td49'><span id='spnRet'></span></td>"  
          + "</tr>"
    	  + "<tr class='trHdr03'><td class='td48'>On an open Defect</td><td class='td49'><span id='spnOnRtv'></span></td></tr>"
    	  + "<tr class='trHdr03'><td class='td48'>On an open MOS</td><td class='td49'><span id='spnOnMos'></span></td></tr>"
    	  + "<tr class='trHdr03'><td class='td48'>Remaining</td><td class='td49'><span id='spnRemind'></span></td></tr>"
    	+ "</table>"
    + "</th>"
     
       
  panel += "<tr class='trHdr03' id='trReas'><td class='td33' rowspan='2' nowrap>Reason</td>"
            + "<td class='td32'><input class='Small' name='Reason' size=20 readonly></td>";
  if(Defect != "Y"){ panel += "<td class='td33' id='tdSelReas'><select class='Small' name='SelReas' onchange='setReason(this)'></select></td>" }
  panel += "</tr>"
  panel += "<tr class='trHdr03' id='trReas1'><td class='tdError' id='tdReasWarn' colspan='2' nowrap>&nbsp;</td></tr>"
  

  panel += "<tr class='trHdr03' style='display:none;'><td class='td33' nowrap>Defective</td>"
            + "<td class='td32' colspan=2 ><input type='checkbox' name='Defect' value='Y'></td>"
       + "</tr>"
  
  panel += "<tbody id='tbdSubCat'><tr class='trDtl19'><td class='td11' id='tdSubCat' colspan=3></td></tr></tbody>"      
  
  panel += "<tr class='trHdr03' id='trCommt' ><td class='td33'>Comment</td>"
       + "<td class='td32' nowrap colspan=2><input class='Small' name='Comment' size=50 maxlength=100>"
       + "</td>"
    + "</tr>"
    
  panel += "<tbody id='tbdAddInf'><tr class='trHdr03'><td class='td33'>Name</td>"
        + "<td class='td32' nowrap colspan=2><input class='Small' name='Name' size=53 maxlength=50>"
        + "&nbsp; <a class='Small' href='javascript: clearItemAddInfo()'>Clear</a></td>"
     + "</tr>"
     + "<tr class='trHdr03'><td class='td33'>Address</td>"
     	+ "<td class='td32' nowrap colspan=2><input class='Small' name='Addr' size=103 maxlength=100></td>"
  	 + "</tr>"
  	 + "<tr class='trHdr03'><td class='td33'>City</td>"
 		+ "<td class='td32' nowrap colspan=2><input class='Small' name='City' size=53 maxlength=50></td>"
	 + "</tr>"
	 + "<tr class='trHdr03'><td class='td33'>State</td>"
		+ "<td class='td32' nowrap colspan=2><input class='Small' name='State' size=5 maxlength=2></td>"
	 + "</tr>"
	 + "<tr class='trHdr03'><td class='td33'>Zip</td>"
		+ "<td class='td32' nowrap colspan=2><input class='Small' name='Zip' size=13 maxlength=10></td>"
	 + "</tr>"
	 + "<tr class='trHdr03'><td class='td33'>Phone</td>"
		+ "<td class='td32' nowrap colspan=2><input class='Small' name='Phone' size=23 maxlength=20></td>"
	 + "</tr></tbody>"
	 
	 panel += "<tbody id='tbdCrime'><tr class='trHdr03'><td class='td33' readOnly>Date</td>"
	        + "<td class='td32' nowrap colspan=2>"
	         + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;Date&#34;, &#34;DAY&#34;)'>d-</button>"
             + "<input class='Small' name='Date' type='text'  size=10 maxlength=10>&nbsp;"
             + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;Date&#34;, &#34;DAY&#34;)'>d+</button>"
             + "&nbsp;&nbsp;&nbsp;"
             + "<a href='javascript:showCalendar(1, null, null, 300, 300, document.all.Date)' >"
             + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
	        + "</td>"
	     + "</tr>"
	     + "<tr class='trHdr03'><td class='td33'>Time</td>"
	     	+ "<td class='td32' nowrap colspan=2><input class='Small' name='Time' size=12 maxlength=10></td>"
	  	 + "</tr>"
	  	 
	  	 + "<tr class='trHdr03' id='trArea'><td class='td33' nowrap>Area in Store</td>"
            + "<td class='td32'><input class='Small' name='Area' size=50 readonly></td>"
            + "<td class='td33' id='tdSelReas'><select class='Small' name='SelArea' onchange='setArea(this)'></select></td>" 
         + "</tr>"
	  	 
	  	 + "<tr class='trHdr03'><td class='td33' nowrap>Place found</td>"
	 	 	+ "<td class='td32' nowrap colspan=2><input class='Small' name='Place' size=27 maxlength=25></td>"
	     + "</tr>"
	     + "<tr class='trHdr03'><td class='td33' nowrap>Found by</td>"
	 	 	+ "<td class='td32' nowrap colspan=2><input class='Small' name='FoundBy' size=27 maxlength=25></td>"
	     + "</tr>"
	     + "<tr class='trHdr03'><td class='td33' nowrap>Mgr on Duty</td>"
	 	 	+ "<td class='td32' nowrap colspan=2><input class='Small' name='Mgr' size=27 maxlength=25></td>"
	     + "</tr>"
	     + "<tr class='trHdr03'><td class='td33'>Comments(256 Char)</td>"
	 	 	+ "<td class='td32' nowrap colspan=2><textarea class='Small' name='TheftCmt' id='TheftCmt' cols=50 rows=6></textarea></td>"
	     + "</tr>"	     
	     + " </tbody>"
	     
	  panel += "<tbody id='tbdDefect'><tr class='trHdr03'><td class='td33'>Reason for Defect</td>"
	  panel += "<td class='td32' colspan=2 nowrap>"
	  
	  panel += "<table class='tbl01'>"
	  var nxtline = true;
	  for(var i=0; i < DefectLst.length ;i++)
	  {
		  if(nxtline){ panel += "<tr class='trDtl19'>" }
		  panel += "<td class='td48' nowrap><input type='checkbox' class='Small' name='Dfc' value='"
	       	 + DefectLst[i] + "'> " + DefectLst[i];
		  if(!nxtline){ panel += "</tr>" } 	 
	      nxtline = !nxtline; 	 
	  }    	
	  
	  panel += "</table>";
	  
	  panel += "</td>"
	      + "</tr>"	      
	 	 + "</tr>" 
	  panel += "</tbody>"
	  
	  // ------ note ----------
	  panel += "<tr class='trHdr03'><td id='tdNote' class='td32' colspan=3 nowrap></td></tr>"
 
	  // ------ error ----------
	  panel += "<tr class='trHdr03'><td id='tdError' class='tdError' colspan=3></td></tr>"
	  
      // ----- buttons ---------
      panel += "<tr class='trHdr03'>";
      // add
      panel += "<td class='td33' colspan='3'><br><br><button onClick='ValidateItm(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
      panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
      panel += "</table>";
  	  return panel;
}

//==============================================================================
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
var button = document.all[id];
var date = new Date(button.value);

date.setHours(18);

if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

if(direction == "DOWN" && ymd=="WK") { date = new Date(new Date(date) - 86400000 * 7 ); }
else if(direction == "UP" && ymd=="WK") { date = new Date(new Date(date) - -86400000 * 7 ); }

button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
} 
//==============================================================================
// preset reason to other
//==============================================================================
function setOtherReas()
{	
	document.all.trReas.style.display = "none";
	document.all.Reason.value = "Other";
  	document.all.tbdAddInf.style.display = "none";
  	document.all.tbdCrime.style.display = "none"; // theft
  	document.all.tbdDefect.style.display = "block";
  	document.all.trCommt.style.display = "block";
  	document.all.tbdSubCat.style.display = "none";
}
//==============================================================================
// populate dropdown menu for item issues
//==============================================================================
function popReason()
{
   document.all.SelReas.options[0] = new Option("--- Select Reason Code ---", "");
   for(var i=0, j=1; i < Reason.length; i++, j++)
   {
	  document.all.SelReas.options[j] = new Option( Reason[i] ,Reason[i]);	  
   }
}
//==============================================================================
//populate dropdown menu for store area (Theft)
//==============================================================================
function popArea()
{
	document.all.SelArea.options[0] = new Option("--- Select Area Code ---", "");
	for(var i=0, j=1; i < Area.length; i++, j++)
	{
		document.all.SelArea.options[j] = new Option( Area[i] ,Area[i]);	  
	}
}
//==============================================================================
// populate Reason Code from dropdown menu
//==============================================================================
function setReason(ddmenu)
{
    var i = 0;
    var optSel = false
    var ddmval = ddmenu.options[ddmenu.selectedIndex].value;
    var warnfld = document.all.tdReasWarn;
    warnfld.innerHTML = "";
    
    for(var j=0; j < Reason.length; j++)
    {
    	if(Reason[j] == ddmval){ i = j; optSel=true; break;  }
    }
    
    if(optSel)
    {
      document.all.Reason.value = ddmval;
      
      if(ActReq[i] == "AddInfo")
      {    	  
    	  document.all.tbdAddInf.style.display = "block"; //additioanl information
    	  document.all.tbdCrime.style.display = "none"; // theft
    	  document.all.tbdDefect.style.display = "none"; // nature of defect	   
    	  if(ddmval != "Warranty"){rtvPrevInfo(ddmval);}
      }
      else if(ActReq[i] == "Crime")
      {
    	  document.all.tbdAddInf.style.display = "none"; 
    	  document.all.tbdCrime.style.display = "block"; // theft
    	  document.all.tbdDefect.style.display = "none"; // nature of defect	   
    	  document.all.trCommt.style.display = "none";
      }      
      else
      { 
    	  document.all.tbdAddInf.style.display = "none";
    	  document.all.tbdCrime.style.display = "none"; // theft
    	  document.all.tbdDefect.style.display = "none"; // nature of defect	   
    	  document.all.trCommt.style.display = "block";
      }
      
      if(SubCat[i] == "Y")
      {    	  
    	  document.all.tbdSubCat.style.display = "block"; //subcategory
    	  setSubCateg(Reason[j]);
      }
      else{document.all.tbdSubCat.style.display = "none";}
      
      if(ddmval == "Donation")
      {
    	  
    	  warnfld.innerHTML = "For <u><b><i>all</i></b></u> Donations - scan and upload the Company's IRS form:"
    	   + "&nbsp;<u><b>501C3</b></u><br>Verifying their Company information, and Tax ID.";
      }    	  
    }
    else
    { 
    	document.all.tbdAddInf.style.display = "none";
    	document.all.tbdCrime.style.display = "none"; // theft
    	document.all.tbdDefect.style.display = "none";
    	document.all.trCommt.style.display = "block";
    }
    
}

//==============================================================================
//populate Area from dropdown menu
//==============================================================================
function setArea(ddmenu)
{
	var i = ddmenu.selectedIndex;
	var ddmval = ddmenu.options[i].value; 
	if(i != 0)
	{
  		document.all.Area.value = ddmval;
	}
} 
//==============================================================================
//populate Defect from dropdown menu
//==============================================================================
function setDefectLst(ddmenu)
{
  var i = ddmenu.selectedIndex;
  var ddmval = ddmenu.options[i].value; 
  if(i != 0)
  {
    document.all.DfcCode.value = ddmval;
  }
}
//==============================================================================
//retreive Previously entered info
//==============================================================================
function setSubCateg(reas)
{
	var td = document.all.tdSubCat;
	var html = "Subcategory:";
	var br = "<br>";
	for(var i=0; i < ScReas.length ;i++)
	{
		if(reas == ScReas[i])
		{
			html += br + "&nbsp;&nbsp;&nbsp; <input type='radio' name='SubCat' value='" + ScCateg[i] + "' >" + ScCateg[i];
		}
	}
	
	td.innerHTML = html;
}
//==============================================================================
// retreive Previously entered info
//==============================================================================
function rtvPrevInfo(reason)
{
	getItemAddInfo(item, "PrevInfo", reason);
	
	document.all.Name.value = IaName;
	document.all.Addr.value = IaAddr;
	document.all.City.value = IaCity;
	document.all.State.value = IaState;
	document.all.Zip.value = IaZip;
	document.all.Phone.value = IaPhone;	
}
//==============================================================================
// clear item additional info
//==============================================================================
function clearItemAddInfo()
{
	document.all.Name.value = "";
	document.all.Addr.value = "";
	document.all.City.value = "";
	document.all.State.value = "";
	document.all.Zip.value = "";
	document.all.Phone.value = "";
}
//==============================================================================
// check if additional infor required
//==============================================================================
function isItemAddInfoReq(reas, search)
{
	var req = false;
   	for(var i=0; i < Reason.length ; i++)
   	{
   		if(reas == Reason[i] && ActReq[i] == search)
   	   	{
   			req = true;
		   	break;
   	   	}
	}
   	
   	return req;
}
//==============================================================================
//check if subcategory req
//==============================================================================
function isItemSubCatReq(reas)
{
	var req = false;
	for(var i=0; i < Reason.length ; i++)
	{
		if(reas == Reason[i] && SubCat[i] == "Y")
	   	{
			req = true;
		   	break;
	   	}
	}
	
	return req;
}
//==============================================================================
//validate sku only
//==============================================================================
function ValidateSkuOnly(inpfld, action )
{
	var error = false;
	var msg = " ";
	var warning = false;
	var msg1 = " ";	
	var br = "";
	var errfld = document.all.tdError;
	errfld.innerHTML = "";
	var warnfld = document.all.tdWarn;
	warnfld.innerHTML = "";
	
	var search = inpfld.value.trim();
	// search by sku
	if(search == "") { error = true; msg = "The search is empty. Please, enter valid SKU or UPC number.\n" }	
	else if(isNaN(search)){ error = true; msg = "The search is invalid. The value must be numeric.\n"; }
	else if(action == "ADD_ITEM")
	{
		search = getScannedItem(search)
		if(search == "") { error = true; msg = "Item is not found on System."; br="<br>";}
		else {  document.all.Search.value = NewSku; document.all.spnDesc.innerHTML = NewDesc; }
		
		if(!error)
		{
			document.all.spnOnHand.innerHTML = NewStrQty; 
			document.all.spnOnRtv.innerHTML = NewOnRtv;
			document.all.spnOnMos.innerHTML = NewOnMos;
			document.all.spnRemind.innerHTML = NewRemind; 
			document.all.spnRet.innerHTML = NewRet;
			
			if(Defect)
			{
				// check for swimming classes
				for(var  i=0; i < SwimCls.length; i++)
				{
					if(NewCls == SwimCls[i])
					{
						warning = true; msg1 += br + "Warning! Swimwear items cannot be returned IF worn!"; 
						br="<br>";
						break;
					}
				}
		    	// check for consuming classes
				/*for(var  i=0; i < ConsumCls.length; i++)
				{
					if(NewCls == ConsumCls[i])
					{
						warning = true; msg1 += br + "Warning! Consumable items cannot be returned, dispose in store."; 
						br="<br>";
						break;
					}
				}*/
				// check for showes
				for(var  i=0; i < ShowDiv.length; i++)
				{
					if(NewDiv == ShowDiv[i])
					{
						warning = true; msg1 += br + "Warning! Mismated footwear cannot be returned as defective items (to #99). Add mismated footwear to an MOS entry, then ship them to #45."; 
						br="<br>";
						break;
					}
				}
			}
			
			if(Excluded)
			{
				document.all.tdNote.innerHTML = "ECOM Exclusions for this SKU already exist."
				    + "<br>With this entry a total Qty of " + ExclQty + ", will now be excluded from ECOM Fulfillments.";
				document.all.tdNote.style.color="red";
			}
			else
			{
			   document.all.tdNote.innerHTML = "This SKU/QTY will be excluded from ECOM Fulfillments, until 'processed' out of inventory.";
			   document.all.tdNote.style.color="green";
			}
		}
	}
	
	if (error){ errfld.innerHTML = msg; }
	if (Defect && warning)
	{ 
		msg1 += "<br>Click here - to continue and add this item:" 
		  + "<input type='checkbox' name='Warning' value='Y'>"
		warnfld.innerHTML = msg1;		
	}
}
//==============================================================================
// validate Item changes
//==============================================================================
function ValidateItm(action)
{
	var error = false;
	var msg = " ";
	var errfld = document.all.tdError;
	errfld.innerHTML = "";
	var br = "";
	
	var reason = document.all.Reason.value.trim();
	var search = document.all.Search.value.trim();
	var emp = "0";
	
	if(EmpReq)
	{
		emp = document.all.Emp.value.trim();
		if(emp==""){error=true; msg += br +  "Please enter your employee number"; br = "<br>";}
		else if(isNaN(emp)){error=true; msg += br +  "Employee Number is not numeric"; br = "<br>";}
		else if(eval(emp) <=0 ){error=true; msg += br +  "Employee Number nust be positive numeric number"; br = "<br>";}
		else if (!isEmpNumValid(emp)){error = true; msg += br +  "Employee number is invalid."; br = "<br>"; }
	}
	
	var comment = " ";
	if(action != "DLT_ITEM")
	{
		comment = document.all.Comment.value.trim();	
    	if(comment==null || comment==""){comment=" ";}
	}
	else{ comment="The " + search + " has been deleted."; }	
    
    if(action != "ADD_ITEM")
    {
    	search = document.all.ItmId.value;
    }
	
	// search by sku
	if(search == "") { error = true; msg += br + "The search is empty. Please, enter valid SKU or UPC number."; br = "<br>"; }	
	else if(isNaN(search)){ error = true; msg += br + "The search is invalid. The value must be numeric."; br = "<br>";}
	else if(action == "ADD_ITEM")
	{
		search = getScannedItem(search)
		if(search == "") { error = true; msg += br + "Item is not found on System."; br = "<br>"; }
		else {  document.all.Search.value = NewSku; document.all.spnDesc.innerHTML = NewDesc; }
	}
	
	var qty = document.all.Qty.value.trim();
	var svqty = document.all.SvQty.value.trim();
	var rem = eval(NewRemind) - (-1 * eval(svqty));
	
	if(qty == "") { error = true; msg += br + "The quantity is empty. Please, enter quantity."; br = "<br>"; }	
	else if(isNaN(qty)){ error = true; msg += br +  "The quantity is invalid. The value must be numeric."; br = "<br>";}
	else if(NewCls != "604" && eval(qty) > rem) 
	{
		error = true; msg +=  br + "Quantity entered is greater than quantity remaining. The remaining quantity is " + NewRemind + "."; br = "<br>"; 
	}
	
	var name = document.all.Name.value.trim();
	var addr = document.all.Addr.value.trim();
	var city = document.all.City.value.trim();
	var state = document.all.State.value.trim();
	var zip = document.all.Zip.value.trim();
	var phone = document.all.Phone.value.trim();
	
	if(isItemAddInfoReq(reason, "AddInfo"))
	{
		if(name == ""){ error = true; msg +=  br + "Please enter Name."; br = "<br>";}
		else if(!isNameCorrect(name)){ error = true; msg +=  br + "Name is incorrect."; br = "<br>";}		
		if(addr == ""){ error = true; msg += br +  "Please enter Address."; br = "<br>";}
		else if(!isNameCorrect(addr)){ error = true; msg += "Address is incorrect."; br = "<br>";}
		if(city == ""){ error = true; msg +=  br + "Please enter City."; br = "<br>";}
		else if(!isNameCorrect(city)){ error = true; msg +=  br + "City is incorrect."; br = "<br>";}
		if(state == ""){ error = true; msg += br +  "Please enter State."; br = "<br>";}		
		if(zip == ""){ error = true; msg +=  br + "Please enter Zip. "; br = "<br>";}
		else if(isNaN(zip)){ error = true; msg += br +  "Zip is incorrect."; br = "<br>";}
		if(phone == ""){ error = true; msg += br +  "Please enter Phone. "; br = "<br>";}
		else if(!isPhoneCorrect(phone)){ error = true; msg += br +  "Pnone is incorrect. "; br = "<br>";}	
	}
	
	// theft additional info
	var date = document.all.Date.value.trim();
	var time = document.all.Time.value.trim();
	var place = document.all.Place.value.trim();
	var foundby = document.all.FoundBy.value.trim();
	var mgr = document.all.Mgr.value.trim();
	var tftcommt = document.all.TheftCmt.value.trim();	
	var area = document.all.Area.value.trim();	
	
	if(isItemAddInfoReq(reason, "Crime"))
	{
		if(date == ""){ error = true; msg += br +  "Please enter Date."; br = "<br>";}
		if(time == ""){ error = true; msg += br +  "Please enter Time."; br = "<br>";}
		if(place == ""){ error = true; msg += br +  "Please enter Place."; br = "<br>";}		
		if(area == ""){ error = true; msg += br +  "Please enter Area in Store."; br = "<br>";}
		if(foundby == ""){ error = true; msg += br +  "Please enter Fond By user name."; br = "<br>";}
		if(mgr == ""){ error = true; msg += br +  "Please enter Manager user name. br = "<br>";";}
		if(tftcommt == ""){ error = true; msg += br +  "Please enter Comment."; br = "<br>";}
	}
	
	if(action == "ADD_ITEM" && isItemAddInfoReq(reason, "Comment") && !Defect)
	{
		if(comment.trim() == ""){ error = true; msg += br +  "Please enter Comment."; br = "<br>";}
	}	
	
	document.all.spnOnHand.innerHTML = NewStrQty; 
	document.all.spnOnRtv.innerHTML = NewOnRtv;
	document.all.spnOnMos.innerHTML = NewOnMos;
	document.all.spnRemind.innerHTML = NewRemind; 
	document.all.spnRet.innerHTML = NewRet;
	
	if(reason==null || reason==""){ msg += br +  "Please select Reason."; error = true; br = "<br>"; }
	
	var dfc = new Array();
	var dfcinp = document.all.Dfc;
	var dfcchecked = false;
	if(Defect)
	{
		for(var i=0; i < dfcinp.length; i++)
		{
			if(dfcinp[i].checked){dfc[dfc.length] = dfcinp[i].value; dfcchecked=true; }
		}
		if(!dfcchecked && action != "DLT_ITEM"){ msg += br + "Please select Reason for Defect."; error = true; br = "<br>"; }
	}
	
	if(Defect && NewRet < 20 && NewCls != "92" && NewCls != "93" && NewCls != "7758"
		 && NewCls != "9410" && NewCls != "604") 
	{ 
		error = true; msg += br + "Items is below $20.00 are not eligible for Defective Return (to #99)."
		 + "<br>If sellable:  Clearly mark &#34;AS IS - Final Sale&#34;, and use reduced SM Sale price ending in $.92 cent ending."
		 + "<br>If not sellable:  Add item to MOS control #, and discard/destroy the item."; 
		br = "<br>"; 
	}
	else if(NewCls == "92" && NewCls == "93" && NewCls == "7758" && NewCls == "9410" 
			&& NewCls == "604")
	{
		error = true; msg += br + "Items that are applied to any part of the body, OR edible are not eligible for Defective Return (to #99)."
		 + "<br>These items should be added to an MOS control #, and discarded or destroyed the item."; 
		br = "<br>";
	}
	//if(NewDiv == "92" || NewDiv == "93") { error = true; msg += br + "This Item belong to division 92 or 93. This Product cannot be return to 99."; br = "<br>"; }
	
	// warning is not checked
	if(action == "ADD_ITEM" && document.all.Warning != null && !document.all.Warning.checked)
	{
		error = true; msg += br + "This item has a warning." 
		  + "<br>Please check warning box on the top of the page to CONTINUIE."; br = "<br>"; 
	}	
	
	var subobj = document.all.SubCat;
	var subcat = "";
	if(isItemSubCatReq(reason))
	{
		var check = false;
		for(var i=0; i < subobj.length ; i++ )
		{
			if(subobj[i].checked){ subcat = subobj[i].value.trim(); check=true; break;}
		}
		if(!check){ error = true; msg += br +  "Please check Subcategory."; br = "<br>";}
	}

	if(error){ errfld.innerHTML =  msg; }
	else
	{
		saveMosEntry( search, reason, comment, qty
		 , name, addr, city, state, zip, phone 
		 , date, time, place, area, foundby, mgr, tftcommt, dfc
		 , emp, subcat, action);
	}
}
//==============================================================================
//check employee number
//==============================================================================
function isEmpNumValid(emp)
{
var valid = true;
var url = "EComItmAsgValidEmp.jsp?Emp=" + emp;
var xmlhttp;
//code for IE7+, Firefox, Chrome, Opera, Safari
if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
//code for IE6, IE5
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
//check if name is correct 
//==============================================================================
function isNameCorrect(name)
{
	var good = true;
	if(name.toUpperCase == "NONE" || name.toUpperCase == "N/A" || name.toUpperCase == "NA")
	{
		good = false;
	}
	
	return good;
}
//==============================================================================
//check if Phone number is correct 
//==============================================================================
function isPhoneCorrect(phn)
{
	var good = true;
	var rmvchar = "";
	for(var i=0; i < phn.length; i++)
	{
		if(!isNaN(phn.substring(i,i+1)) && phn.substring(i,i+1) != " ")
		{
			rmvchar += phn.substring(i,i+1);
		}
	}
	if(rmvchar.length < 10){ good = false; }
	
	return good;
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(item)
{
	var url = "MosCtlValidItem.jsp?Item=" + item
		+ "&Str=" + Store;

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
 		if (xmlhttp.readyState==4 && xmlhttp.status==200)
 		{
    		var  resp = xmlhttp.responseText;
    		
    		valid = parseElem(resp, "UPC_Valid") == "true";
		    NewSku = parseElem(resp, "SKU");
    		NewStrQty = parseElem(resp, "QTY");    		
    		NewOnRtv = parseElem(resp, "OnRTV");
    		NewOnMos = parseElem(resp, "OnMOS");
    		NewRemind = eval(NewStrQty) - eval(NewOnRtv) - eval(NewOnMos);    		
    		NewDesc = parseElem(resp, "DESC"); 
    		NewRet = parseElem(resp, "RET");
    		NewDiv = parseElem(resp, "DIV");
    		NewCls = parseElem(resp, "CLS");
    		
    		Excluded = parseElem(resp, "Excluded") == "true";
    		ExclQty = parseElem(resp, "ExcludedQty");    		
    		ExclDate = parseElem(resp, "ExcluedDate");
    		
    		//clearInterval( progressIntFunc );
    		//document.all.dvWait.style.visibility = "hidden";
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return NewSku;
}
//==============================================================================
//get item additional information
//==============================================================================
function getItemAddInfo(item, type, reason)
{
	var url = "MosCtlItemAddInfo.jsp?Ctl=" + CtlNum 
		+ "&Item=" + item
		+ "&Type=" + type;
	
	// get previously entered info
	if(type=="PrevInfo"){ url += "&Reason=" + reason; }
	
	//window.frame1.location.href=url; 
	
	var exists = false;

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var  resp = xmlhttp.responseText;
			exists = parseElem(resp, "Exists") == "true";
			
			if(type == "AddInfo" || type=="PrevInfo")			
			{
				IaName = parseElem(resp, "Name");
		    	IaAddr = parseElem(resp, "Addr");
		    	IaCity = parseElem(resp, "City");
		    	IaState = parseElem(resp, "State");
		    	IaZip = parseElem(resp, "Zip");
		    	IaPhone = parseElem(resp, "Phone");
			}
			if(type == "Crime")			
			{
				TfDate = parseElem(resp, "Date");
				TfTime = parseElem(resp, "Time");
				TfPlace = parseElem(resp, "Place");
				TfArea = parseElem(resp, "Area");
				TfFoundBy = parseElem(resp, "FoundBy");
				TfMgr = parseElem(resp, "Mgr");
				TfCommt = parseElem(resp, "TftCommt");
			}
			if(type == "Defect")			
			{
				ArrDfc = parseElemArr(resp, "defect");
				exists = ArrDfc.length > 0;
			}			
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return exists;
}
//==============================================================================
//parse XML elements into array
//==============================================================================
function parseElemArr(resp, tag )
{
	var arr = new Array();	
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	
	while(beg >= 0)
	{
		arr[arr.length] = resp.substring(beg, end);
		resp = resp.substring(end + taglen);
		beg = resp.indexOf("<" + tag + ">") + taglen;
		end = resp.indexOf("</" + tag+ ">");
		if(arr.length > 20 || end < 0){ break; }
	}
	return arr;	
}
//==============================================================================
//parse XML elements
//==============================================================================
function parseElem(resp, tag )
{
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	return resp.substring(beg, end);
}
//==============================================================================
// submit Item changes
//==============================================================================
function saveMosEntry(search, reason, commt, qty
		, name, addr, city, state, zip, phone
		, date, time, place, area, foundby, mgr, tftcommt, dfc
		, emp, subcat, action )
{
	var nwelem = "";
	
    if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
    else{ nwelem = window.frame1.contentDocument.createElement("div");}
	nwelem.id = "dvSbmSku"

	var html = "<form name='frmAddSku'"
  		+ " METHOD=Post ACTION='MosCtlSv.jsp'>"
  		+ "<input class='Small' name='Ctl'>"  		
  		+ "<input class='Small' name='Str'>"
  		+ "<input class='Small' name='Emp'>"
  	
  		
  	html += "<input class='Small' name='Sku'>"  		
    	+ "<input class='Small' name='Reas'>"
  		+ "<input class='Small' name='ICmt'>"
  		+ "<input class='Small' name='Qty'>"
  		+ "<input class='Small' name='Name'>"
  		+ "<input class='Small' name='Addr'>"
  		+ "<input class='Small' name='City'>"
  		+ "<input class='Small' name='State'>"
  		+ "<input class='Small' name='Zip'>"
  		+ "<input class='Small' name='Phone'>"
  		
  		+ "<input class='Small' name='Date'>"
  		+ "<input class='Small' name='Time'>"
  		+ "<input class='Small' name='Place'>"
  		+ "<input class='Small' name='Area'>"
  		+ "<input class='Small' name='FoundBy'>"
  		+ "<input class='Small' name='Mgr'>"
  		+ "<textarea class='Small' name='TftCommt' id='TftCommt'></textarea>"
  		+ "<input class='Small' name='SubCat'>"
  		
  	if(Defect == "Y")
  	{  		
  		for(var i=0; i < dfc.length; i++)
  		{
  			html += "<input class='Small' name='Dfc'>";
  		}	
  	}	
  		
  	html += "<input class='Small' name='Action'>"  	    
  	    + "<input class='Small' name='User'>"
  	 + "</form>";

	nwelem.innerHTML = html; 
	
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
	else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
	else if(isSafari){window.frame1.document.body.appendChild(nwelem);}
	else{ window.frame1.contentDocument.body.appendChild(nwelem); }
		
	if(isIE || isSafari)
	{
		set_IE_Form(search, reason, commt, qty
				, name, addr, city, state, zip, phone
				, date, time, place, area, foundby, mgr, tftcommt, dfc
				, emp, subcat, action);
	}
	else 
	{
		set_Chrome_Form(search, reason, commt, qty
				, name, addr, city, state, zip, phone
				, date, time, place, area, foundby, mgr, tftcommt, dfc
				, emp, subcat, action);
	}
	
   
    hidePanel()
}
//==============================================================================
//submit form for IE ad Safari
//==============================================================================
function set_IE_Form(search, reason, commt, qty
		, name, addr, city, state, zip, phone
		, date, time, place, area, foundby, mgr, tftcommt, dfc
		, emp, subcat, action)
{
	window.frame1.document.all.Ctl.value = CtlNum;
	window.frame1.document.all.Str.value = Store;
	window.frame1.document.all.Emp.value = emp;
	
		
	window.frame1.document.all.Sku.value = search;
	window.frame1.document.all.Reas.value = reason;
	window.frame1.document.all.ICmt.value = commt;
	window.frame1.document.all.Qty.value = qty;
	window.frame1.document.all.Name.value = name;
	window.frame1.document.all.Addr.value = addr;
	window.frame1.document.all.City.value = city;
	window.frame1.document.all.State.value = state;
	window.frame1.document.all.Zip.value = zip;
	window.frame1.document.all.Phone.value = phone;

	window.frame1.document.all.Date.value = date;
	window.frame1.document.all.Time.value = time;
	window.frame1.document.all.Place.value = place;
	window.frame1.document.all.Area.value = area;
	window.frame1.document.all.FoundBy.value = foundby;
	window.frame1.document.all.Mgr.value = mgr;
	window.frame1.document.all.TftCommt.value = tftcommt;
	window.frame1.document.all.SubCat.value = subcat;
	
	if(Defect == "Y")
  	{  		
  		for(var i=0; i < dfc.length; i++)
  		{
  			if(dfc.length > 1)
  			{
  				window.frame1.document.all.Dfc[i].value = dfc[i];
  			}
  			else 
  			{
  				window.frame1.document.all.Dfc.value = dfc[i];
  			}
  		}	
  	}
	
	window.frame1.document.all.Action.value = action;
	window.frame1.document.all.User.value = User;
	
	window.frame1.document.frmAddSku.submit();
}
//==============================================================================
//submit form for Chrome,Eadge
//==============================================================================
function set_Chrome_Form(search, reason, commt, qty
		, name, addr, city, state, zip, phone
		, date, time, place, area, foundby, mgr, tftcommt, dfc
		, emp, subcat, action)
{
	window.frame1.contentDocument.forms[0].Ctl.value = CtlNum;
	window.frame1.contentDocument.forms[0].Str.value = Store;
	window.frame1.contentDocument.forms[0].Emp.value = emp;
	
		
	window.frame1.contentDocument.forms[0].Sku.value = search;
	window.frame1.contentDocument.forms[0].Reas.value = reason;
	window.frame1.contentDocument.forms[0].ICmt.value = commt;
	window.frame1.contentDocument.forms[0].Qty.value = qty;
	window.frame1.contentDocument.forms[0].Name.value = name;
	window.frame1.contentDocument.forms[0].Addr.value = addr;
	window.frame1.contentDocument.forms[0].City.value = city;
	window.frame1.contentDocument.forms[0].State.value = state;
	window.frame1.contentDocument.forms[0].Zip.value = zip;
	window.frame1.contentDocument.forms[0].Phone.value = phone;

	window.frame1.contentDocument.forms[0].Date.value = date;
	window.frame1.contentDocument.forms[0].Time.value = time;
	window.frame1.contentDocument.forms[0].Place.value = place;
	window.frame1.contentDocument.forms[0].Area.value = area;
	window.frame1.contentDocument.forms[0].FoundBy.value = foundby;
	window.frame1.contentDocument.forms[0].Mgr.value = mgr;
	window.frame1.contentDocument.forms[0].TftCommt.value = tftcommt;
	window.frame1.contentDocument.forms[0].SubCat.value = subcat;
	
	if(Defect == "Y")
	{  		
		for(var i=0; i < dfc.length; i++)
		{
			if(dfc.length > 1)
			{
				window.frame1.contentDocument.forms[0].Dfc[i].value = dfc[i];
			}
			else 
			{
				window.frame1.contentDocument.forms[0].Dfc.value = dfc[i];
			}
		}	
	}
	
	window.frame1.contentDocument.forms[0].Action.value = action;
	window.frame1.contentDocument.forms[0].User.value = User;
	
	window.frame1.contentDocument.forms[0].submit();
}
//==============================================================================
// check email
//==============================================================================
function checkEmail(email)
{
   var good = true;
   var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
   if (!filter.test(email))
   {
     good = false;
   }
   return good;
}
//==============================================================================
// Add Claim comments
//==============================================================================
function ValidateClmCommt(action)
{
   var comm = document.all.txaComm.value;
   comm = comm.replace(/\n\r?/g, '<br />');   

   var commArr = new Array();
   for(var i=0, j=0, k=0, m=0, n=0; i < comm.length; i++)
   {
      if(comm.substring(i, i+1) == " "){ k++; }
      else { k=0; }

      if( m == 100 ) { j++;  m=0; }

      // no more than 1 blank
      if(k < 2 && n < 2)
      {
         commArr[j] += comm.substring(i, i+1);
         m++;
      }
   }

   // save first line of comments
   sbmNewComm(action, "0000000000", comm, "0000000000");
}
//==============================================================================
// Add Item comments
//==============================================================================
function ValidateItemCommt(action, sku)
{
   var comm = document.all.txaComm.value;
   comm = comm.replace(/\n\r?/g, '<br />');
   var commid = document.all.CommId.value;

   var commArr = new Array();
   for(var i=0, j=0, k=0, m=0, n=0; i < comm.length; i++)
   {
      if(comm.substring(i, i+1) == " "){ k++; }
      else { k=0; }

      if( m == 100 ) { j++;  m=0; }

      // no more than 1 blank
      if(k < 2 && n < 2)
      {
         commArr[j] += comm.substring(i, i+1);
         m++;
      }
   }

   // save first line of comments
   sbmNewComm(action, sku, comm, commid);
}
//==============================================================================
// refresh Claim
//==============================================================================
function sbmNewComm(action, sku, comment, commid)
{
   var nwelem = null; 
   
   if(isIE){ nwelem = window.frame1.document.createElement("div"); }
   else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
   else{ nwelem = window.frame1.contentDocument.createElement("div");}
   
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='MosCtlSv.jsp'>"
       + "<input class='Small' name='Ctl'>"
       + "<input class='Small' name='Sku'>"       
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html; 
    
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
   {
   		window.frame1.document.all.Ctl.value = CtlNum;
   		window.frame1.document.all.Sku.value=sku;
   		window.frame1.document.all.Commt.value=comment;
   		window.frame1.document.all.Action.value=action;
   		
   		window.frame1.document.frmAddComment.submit();
   }
   else
   {     
	   	window.frame1.contentDocument.forms[0].Ctl.value = CtlNum;
  		window.frame1.contentDocument.forms[0].Sku.value=sku;
  		window.frame1.contentDocument.forms[0].Commt.value=comment;
  		window.frame1.contentDocument.forms[0].Action.value=action;
  		
  		window.frame1.contentDocument.forms[0].submit();
   } 
   
   hidePanel();
}
//==============================================================================
// validate ctl status
//==============================================================================
function ValidateCtlSts(action)
{
   var error = false;
   var msg = "";
   var CtlSts = null;

   for(var i=0; i < document.all.CtlSts.length; i++)
   {
      if( document.all.CtlSts[i].checked ) { CtlSts = document.all.CtlSts[i].value.trim(); break; }
   }

   if(error){ alert(msg); }
   else { sbmCtlSts(CtlSts, action) }
}
//==============================================================================
// submit ctl status
//==============================================================================
function sbmCtlSts(sts, action)
{
	// send DM message for Approval request
	if(CtlSts == "Open" && sts == "Submitted")
	{
		//DMEmail += ", vrozen@sunandski.com, psnyder@sunandski.com, dharris@sunandski.com"; // for test only
		 
		var toaddr = DMEmail;
		if(Store=="99"){ toaddr += ",dsimpson@sunandski.com,satwood@sunandski.com,mhodge@sunandski.com"; }
		
		var subj = "Store " + Store 
	    	+ " has submitted an MOS - Control # " + CtlNum + " that needs approval.";	
		var body = " ";
		var incl = true; 
		sbmEMail(toaddr, subj, body, incl, false);
	}
	
    var url = "MosCtlSv.jsp?"
     + "&Ctl=" + CtlNum
     + "&Sts=" + sts
     + "&Action=" + action

   //alert(url)
   window.frame1.location.href = url;
   hidePanel()
}

//==============================================================================
// refresh Claim
//==============================================================================
function refreshClaim(clm, ord)
{
   var url = "MosCtlInfo.jsp?Order=" + ord + "&Claim=" + clm
   window.location.href = url;
}

//==============================================================================
// load item photo
//==============================================================================
function loadPhoto(item)
{
   var html = ""
     + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
       + "<td class='BoxName' nowrap>Add Photo</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<form name='Upload'  method='post' enctype='multipart/form-data' action='MosCtlLoad.jsp'>"
               + "<input type='File' name='Doc' class='Small1' size=50><br>"
               + "<input type='hidden' name='Ctl'>"
               + "<input type='hidden' name='Item' >"
               + "<input type='hidden' name='FileName'>"
           + "</form>"
           + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button> &nbsp; "
           + "<button name='Cancel' class='Small' onClick='hidePanel();'>Cancel</button>"
           + "</td></tr>"
     + "</table>"

  //alert(html)
  document.all.dvItem.innerHTML=html;
  document.all.dvItem.style.width = 200;
  document.all.dvItem.style.left=getLeftScreenPos() + 250;
  document.all.dvItem.style.top=getTopScreenPos() + 200;
  document.all.dvItem.style.visibility="visible"

  document.Upload.Ctl.value = CtlNum;
  document.Upload.Item.value = item;
  document.Upload.Doc.focus();
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// submit Upload
//==============================================================================
function sbmUpload()
{
  var error = false;
  var msg = "";
  var file = document.Upload.Doc.value.trim();
  document.Upload.FileName.value = file;
  if(file == "")
  {
     error = true;
     msg = "Please type full file path"
  }
  if (error) { alert(msg);}
  else
  {
    document.Upload.submit();
  }
}
  
//==============================================================================
// retreive ctl comments
//==============================================================================
function rtvCtlComments()
{
   var url = "MosCtlCommt.jsp?Ctl=" + CtlNum
     + "&Action=Hdr_Comment"
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// set ctl comments
//==============================================================================
function setCtlComments(commid, line, type, commt, recusr, recdt, rectm)
{
   if(commid.length > 0)
   {
	   var panel = "<table id='tblCtlCmt' border=0 width='100%' cellPadding='0' cellSpacing='0'>"
    		panel += "<tr class='trHdr01'>"    	    
    	    + "<th class='th02' >User, Date, Time</th>"
    	    + "<th class='th02' >Control Comments</th>"    	    
    	  + "</tr>"
    	  
       var svCommt = commid[0];
       var dcom = new Array();
       dcom[0] = "";
       var drec = new Array();
       drec[0] = recusr[0] + ", " + recdt[0] + ", " + rectm[0];
       
       for(var i=0, j=0; i < commid.length; i++)
       {
    	   if(svCommt != commid[i])    	   
    	   {    		   
    		   svCommt = commid[i];
    		   j++;
    		   dcom[j] = "";
    		   drec[j] = recusr[i] + ", " + recdt[i] + ", " + rectm[i];
    	   }
    	   
    	   dcom[j] += commt[i];           
       }
    	  
       for(var i=0; i < dcom.length; i++)
       {
    	   panel += "<tr class='trDtl07'>"    		
    	   panel +="<td class='td11' style='width:15%' nowrap>" + drec[i] + "</td>"
    	  	  + "<td class='td11' >" + dcom[i] + "</td>"    	  	  
       }
       panel += "</tr></table>";
	  document.all.dvCTlHdrCommt.innerHTML = panel;
   }
}
//==============================================================================
// retreive item comments
//==============================================================================
function rtvItemComments()
{
	 var url = "MosCtlCommt.jsp?Ctl=" + CtlNum
     + "&Action=Itm_Comment"
     + "&Type=Auto"
     ;

     window.frame2.location.href = url;
}

//==============================================================================
// set item comments
//==============================================================================
function setItemComments(commid, line, type, commt, recusr, recdt, rectm, item, sku
		, desc, vensty, reas)
{
	if(commid.length > 0)
	{
		var panel = "<table id='tblItmCmt' border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	   	panel += "<tr class='trHdr01'>"
	        + "<th class='th02' style='width:15%' >User, Date, Time</th>"
	        + "<th class='th02' >Item Comments</th>"    	    
	      + "</tr>"
	    	  
	    var svCommt = commid[0];	      
	    	      
	    var dcom = new Array();
	    dcom[0] = "";
	    var drec = new Array();
	    drec[0] = recusr[0] + ", " + recdt[0] + ", " + rectm[0];
	    
	    var ditem = new Array();	    
	    var dsku = new Array();	    
	    var dvensty = new Array();
	    var dtype = new Array();
	    var dreas = new Array();
	    var svItem = "";
	    
	    ditem[0] = item[0];	    
	    dsku[0] = sku[0];
	    dtype[0] = type[0];
	    dvensty[0] = vensty[0];
	    dreas[0] = reas[0];
	       
	    for(var i=0, j=0; i < commid.length; i++)
	    {	
	    	if(svCommt != commid[i])    	   
	    	{
	    		svCommt = commid[i];
	    		j++;
	    		dcom[j] = "";
	    		drec[j] = recusr[i] + ", " + recdt[i] + ", " + rectm[i];
	    		ditem[j] = item[i];
	    		dsku[j] = sku[i];
	    		dtype[j] = type[i];
	    		dvensty[j] = vensty[i];
	    		dreas[j] = reas[i];
	    	}	
	    	
	    	dcom[j] += commt[i];           
	    }
	    
	    
	    svItem = ditem[0];
	    panel += "<tr class='trHdr04'>"
	        + "<th class='th02' id='tdItem" + ditem[0] + "' colspan=2>SKU: " + dsku[0] + " &nbsp; Reason: " + dreas[0] + "</th>"
	      + "</tr>"  
	    
	    for(var i=0; i < dcom.length; i++)
	    {
	    	if(svItem != ditem[i])    	   
	    	{
	    		panel += "<tr class='trHdr04'>"
	    	        + "<th class='th02' id='tdItem" + ditem[i] + "' colspan=2>SKU: " + dsku[i] + " &nbsp; Reason: " + dreas[i] + "</th>"
	    	      + "</tr>"
	    	      svItem = ditem[i];
	    	}
	    		    	
	    	if(dtype[i].trim() == "Auto"){	panel += "<tr class='trDtl07' id='Auto'>"	}
	    	else { panel += "<tr class='trDtl07'>" }
	    	panel +="<td class='td11'  nowrap>" + drec[i] + "</td>"
	    	 	  + "<td class='td11' >" + dcom[i] + "</td>"    	  	  
	    }
	    panel += "</tr></table>";
		document.all.dvItmComments.innerHTML = panel;
	}
}
//==============================================================================
//retreive 1st item comments
//==============================================================================
function rtv1stItemComments(item)
{
	 var url = "MosCtlCommt.jsp?Ctl=" + CtlNum
	  + "&Item=" + item		 
    + "&Action=Itm_First_Not_Auto_Comment"

    window.frame2.location.href = url;
}
//==============================================================================
//set 1st item comments
//==============================================================================
function set1stItemComments(commid, line, type, commt, recusr, recdt, rectm, item, sku, desc, vensty)
{
	FirstItmCommt = commt;
	document.all.spn1stCommt.innerHTML = commt;
}
//==============================================================================
// retreive item pictures
//==============================================================================
function rtvItemPictures()
{
	var url = "MosCtlCommt.jsp?Ctl=" + CtlNum
    + "&Action=Itm_Photo"
    window.frame3.location.href = url;
}

//==============================================================================
// set Picture on page //item, file, recusr, recdt, rectm, item, sku, desc, vensty
//==============================================================================
function setPictures(item, pic, recusr, recdt, rectm, item, sku, desc, vensty)
{
   var html = "";
   if(pic.length > 0)
   {
      html = "<table border=1 id='tbl" + item + "Picture'><tr>";
      for(var i=0, j=0; i < pic.length; i++)
      {
         html += "<td id='tdPic" + item[i] + "'>";
         path = "MOS/" + pic[i];
         // only pictures
         if(path.toLowerCase().indexOf(".jpeg") >= 0 || path.toLowerCase().indexOf(".jpg") >= 0
            && path.toLowerCase().indexOf(".tiff") >= 0 || path.toLowerCase().indexOf(".gif") >= 0
            && path.toLowerCase().indexOf(".png") >= 0 || path.toLowerCase().indexOf(".bmp") >= 0
            && path.toLowerCase().indexOf(".svg") >= 0 || path.toLowerCase().indexOf(".vnd") >= 0
            && path.toLowerCase().indexOf(".prs") >= 0 || path.toLowerCase().indexOf(".mp") >= 0
            && path.toLowerCase().indexOf(".dv") >= 0 || path.toLowerCase().indexOf(".pw") >= 0)

         {
            html += "<img style='cursor:pointer;' src='" + path + "' width='100' height='100' alt='Click to Magnified'"
                 + " onclick='window.open(&#34;" + path + "&#34;)'"
                 + " />"
         }
         else
         {
             j++;
             html += "<a style='font-size:10px' href='" + path + "' target='_blank'>Document (" + j + ")</a><br>"
         }

         html += "<br><a class='Small' href='javascript: dltPicture(&#34;" + item[i] + "&#34;,&#34;" + pic[i] + "&#34;)'>Delete</a> &nbsp; &nbsp;"

         html += "</td>";

         var maxPic = ItemWithPic.length;
         ItemWithPic[maxPic] = vensty[i];
         PicPath[maxPic] = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/MOS/" + pic[i];

      }

      html += "</td></tr></table>";
      document.all.dvItmPictures.innerHTML += html + "<br>&nbsp;";
   }
    

   window.frame3.close();
}
//==============================================================================
// scroll to Item comments
//==============================================================================
function showPicMenu(item, sku, ven, vennm, vensty, pic, obj)
{
   var hdr = "Picture Menu";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePhotoMenu();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPicMenuPanel(item, sku, ven, vennm, vensty, pic)
     + "</td></tr>"
   + "</table>"

   var pos = getObjPosition(obj);

   document.all.dvPhoto.innerHTML = html;
   document.all.dvPhoto.style.left = pos[0] + 110;
   document.all.dvPhoto.style.top = pos[1] - 50;
   document.all.dvPhoto.style.visibility = "visible";

   //document.all.tblPicMenu.onmouseout = function() { hidePanel(); };
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function popPicMenuPanel(item, sku, ven, vennm, vensty, pic)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblPicMenu'>"
  panel += "<tr><td class='Prompt'>SKU: " + sku + " Style: " + vensty + "</td></tr>"
       + "<tr><td class='Prompt'><a href='" + pic + "' target='_blank'>Magnified</a></td></tr>"
       + "<tr><td class='Prompt'><a href='javascript: dltPicture(&#34;" + item + "&#34;,&#34;" + pic + "&#34;)'>Delete</a></td></tr>"
       + "<tr><td class='Prompt'>&nbsp;</td></tr>"
       + "<tr><td class='Prompt'><a href='javascript: hidePhotoMenu();'>Cancel</a></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePhotoMenu()
{
   document.all.dvPhoto.innerHTML = " ";
   document.all.dvPhoto.style.visibility = "hidden";
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function dltPicture(item, filenm)
{
   var url = "MosCtlSv.jsp?&Ctl=" + CtlNum
     + "&Sku=" + item
     + "&File=" + filenm
     + "&Action=Dlt_Itm_Photo"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// scroll to Item comments
//==============================================================================
function scrollToItemComm(sku)
{
   var name = "tdItem" + sku;
   var obj = document.all[name];
   if(obj != null)
   {
   		var pos = getObjPosition(obj);
   		window.scrollTo(0, pos[1]);
   }
}
//==============================================================================
// scroll to Item picture
//==============================================================================
function scrollToItemPic(sku)
{
   var name = "tdPic" + sku;
   var obj = document.all[name];
   if(obj != null)
   {
	   var pos = getObjPosition(obj);
   	   window.scrollTo(0, pos[1]);
   }
}
//==============================================================================
//send email message when submitted 
//==============================================================================
function emailSbm(sts)
{
	var sent = false;
	/*if(sts == "Submitted" && TheftFlag)
	{		
		var toaddr = "jlegaspi@sunandski.com,jboyle@sunandski.com,srutherford@sunandski.com,psnyder@sunandski.com,vrozen@sunandski.com";
		//toaddr = "vrozen@sunandski.com";
		var subj = "MOS - Contained Theft";
		var body = "This Ctl# contained stolen item(s)."
		var incl = "Y";
		sbmEMail(toaddr, subj, body, incl, false);
		sent = true;
	}
	
	if(sts == "Submitted" && GrossrootFlag)
	{		
		var toaddr = "tkaminski@sunandski.com,jboyle@sunandski.com,srutherford@sunandski.com,psnyder@sunandski.com,vrozen@sunandski.com";
		//toaddr = "vrozen@sunandski.com";
		var subj = "MOS - Contained Grassroot Marketing";
		var body = "This Ctl# contained grassroot item(s)."
		var incl = "Y";
		sbmEMail(toaddr, subj, body, incl, false);
		sent = true;
	}	
	*/
	window.location.reload();	
}
//==============================================================================
// send email message
//==============================================================================
function setEMail()
{
   var hdr = "Send MOS E-mail to GM";

   var html = "<table class='tbl01' width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popEMailPanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "300"; }
   else { document.all.dvItem.style.width = "auto"; }

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.left=getLeftScreenPos() + 250;
   document.all.dvItem.style.top=getTopScreenPos() + 200;
   document.all.dvItem.style.visibility = "visible";

   document.all.ToAddr.value = setGMEMail();
   if(User == "vrozen"){document.all.ToAddr.value="vrozen@sunandski.com";}
   
   document.all.Subj.value = "Regarding MOS Entry - Control #" + CtlNum;
   document.all.Msg.value = "";
}
//==============================================================================
// set store GM email address 
//==============================================================================
function setGMEMail()
{
	var str = Store;
	if(str.length ==1){ str = "0" + str; }
	var addr = "GM" + str + "@sunandski.com";
	return addr;
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function popEMailPanel()
{
  var panel = "<table class='tbl02' width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt'>E-Mail Address</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='ToAddr'></td></tr>"
       + "<tr><td class='Prompt'>Subject &nbsp;</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='Subj'></td></tr>"
       + "<tr><td class='Prompt'>Message &nbsp;</td></tr>"
         + "<tr><td class='Prompt'><TextArea class='Small' cols=50 rows=3 name='Msg' id='Msg'></TextArea></td></tr>"
       + "<tr><td class='Prompt'>Include MOS information</td></tr>"
         + "<tr><td class='Prompt'>"
            + "<input type='radio' name='Incl' value='Y' checked>Yes &nbsp;  &nbsp; "
            + "<input type='radio' size=50 name='Incl'  value='N'>No"
            + "</td></tr>"

       + "<tr><td class='Prompt1'>"
         + "<button class='Small' onclick='validateEMail()'>Send</button> &nbsp;"
         + "<button class='Small' onclick='hidePanel()'>Cancel</button> &nbsp;"
       + "</td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// validate email message properties
//==============================================================================
function validateEMail()
{
   var msg = "";
   var error = false;

   var toaddr = document.all.ToAddr.value.trim();
   if(toaddr ==""){error=true; msg="Please enter Email Address"; }
   
   var subj = document.all.Subj.value.trim();
   if(subj ==""){error=true; msg="Please enter Subject Address"}

   var body = document.all.Msg.value.trim();

   var incl = document.all.Incl[0].checked;

   if(body =="" && !incl){error=true; msg="Please enter message text or(and) include Control information."}

   if(error){ alert(msg); }
   else { sbmEMail(toaddr, subj, body, incl, true); }
}
//==============================================================================
// send email message
//==============================================================================
function sbmEMail(toaddr, subj, body, incl, addcommt)
{
	document.all.spnStsEmail.style.display = "block";
	//setItmStsVis(false);
		
	var msg = "<style>"
      + " table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100% } "
      + " tr.trHdr01 { background: #FFE4C4; text-align:center; font-size:10px;font-weight:bold; } "
      + " tr.trHdr04 { background: LemonChiffon; text-align:center; font-size:18px;font-weight:bold; } "
      + " th.th02 { border: darkred solid 1px;  text-align:center; vertical-align:top; font-family:Verdanda; font-size:11px; } "
      + " tr.trDtl04 { background: white; text-align:center; font-size:10px; }"
      + " tr.trDtl06 { background: #e7e7e7; text-align:center; font-size:10px; } "
      + " tr.trDtl07 { background: #F8ECE0; text-align:center; font-size:12px; } "
      + " td.td11 {border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:left; vertical-align:middle; padding: 3px; } "
      + " td.td12 { border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:right; vertical-align:middle; padding: 3px; } "
      + " td.td18 { border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:center; vertical-align:middle; padding: 3px; } "
      + " td.td46 { border: none; text-align:right; vertical-align:middle; padding: 3px; } "
      + " td.td45 { border: none; text-align:left; vertical-align:middle; padding: 3px; } " 
      + " #cellLink { display:none; }"
      + " #trLinks1 { display:none; }"
      + " #trBotton1 { display:none; }"
      + " #trDFI { display:none; }"
      + " #tdDFI { display:none; }"
      + " #trInstr { display:none; }"
      + " #tdInstr { display:none; }"
      + " #tblInstr { display:none; }"
      + " .spnItmStsEmail { display:none; }"
      + " .spnItmStsEmail { display: block; }"      
      + " .NonPrt  { display:none; } "      

  msg += "</style> <body>";
  
  //document.all.dvCTlHdrCommt.innerHTML="";

  document.all.spnHdrImg.innerHTML = "";
  document.all.spnHdrImg.style.display="none";
  
  var clm = document.all.tblClaim.outerHTML;
  var itmcmt = "";
  try { itmcmt = document.all.tblItmCmt.outerHTML; }
  catch( err ){}
       
  var pic = document.all.tblClaimPic.outerHTML;
  
  msg += "<br>" + clm 
    + "<br>" + itmcmt       
  ;
  

  if(window.frame2.document.frmSendEmail == null)
  {
	var nwelem = "";
  	
    if(isIE){ nwelem = window.frame2.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame2.document.createElement("div"); }
    else{ nwelem = window.frame2.contentDocument.createElement("div");}
      
  	nwelem.id = "dvSbmCommt"

  	var html = "<form name='frmSendEmail'"
       + " METHOD=Post ACTION='RtvCtlSendEMail.jsp'>"
       + "<input class='Small' name='MailAddr'>"
       + "<input class='Small' name='CCMailAddr'>"
       + "<input class='Small' name='FromMailAddr'>"
       + "<input class='Small' name='Subject'>"
       + "<input class='Small' name='Message'>"
       + "<input class='Small' name='Ctl'>"
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Reload'>"

   //ItemWithPic[ItemWithPic.length] = "patio_logos1.jpg"
   //PicPath[PicPath.length] = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/MainMenu/patio_logos1.jpg";   
    	          
   	for(var i=0; i < ItemWithPic.length; i++)
   	{
    	 html += "<input type='hidden' name='ItemAttach' value='" + ItemWithPic[i] + "'>"
     	html += "<input type='hidden' name='PicAttach' value='" + PicPath[i] + "'>"     
   	}
       
       
   	html += "</form>"

   	nwelem.innerHTML = html;
   	frmcommt = document.all.frmEmail;
   	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame2.document.appendChild(nwelem); }
	else if(isIE){ window.frame2.document.body.appendChild(nwelem); }
	else if(isSafari){window.frame2.document.body.appendChild(nwelem);}
	else{ window.frame2.contentDocument.body.appendChild(nwelem); }
  }

  var svbody="";
   if(isIE || isSafari)
   {
	   svbody = set_IE_Email(msg, toaddr, subj, body, incl, addcommt);  
   }
   else 
   {
	   svbody = set_Chrome_fields(mg, toaddr, subj, body, incl, addcommt);  
   }
   
   hidePanel();
   document.all.spnStsEmail.style.display = "none";

   var text = "E-mail message was sent to " + toaddr
      + "<br>Message: " + svbody;
   
   if(addcommt){ sbmNewComm("ADD_CLM_COMMENT", "0000000000", text); }
}
//==============================================================================
// set fields on IE
//==============================================================================
function set_IE_Email(msg, toaddr, subj, body, incl, addcommt)
{
	window.frame2.document.all.MailAddr.value = toaddr;

	   // send on store mail account
	   var ccmail = "";
	   //if(StrAllowed.indexOf("ALL") >= 0){ ccmail = "<%=sUser%>@sunandski.com"; }
	   //else { ccmail = "Store" + StrAllowed + "@sunandski.com"; }
	   //ccmail += ", pmeyer@sunandski.com, kknight@sunandski.com";
	   
	   window.frame2.document.all.CCMailAddr.value = ccmail;

	   var str = Store;
	   if(Store.length==1){ str = "0" + Store; }
	   var frAddr = "Store" + str + "@sunandski.com"
	   window.frame2.document.all.FromMailAddr.value = frAddr;
	   window.frame2.document.all.Subject.value = subj;
	   window.frame2.document.all.Reload.value = Reload;
	  
	   var svbody = body;
	   
	   if(body != "" && incl)
	   {
	      msg = "<div style='color:blue; font-size:14px;'>" + body + "</div>"
	          + "<br><hr /><br>" + msg;
	   }
	   else if(body != "" && !incl){ msg = body; }

	   msg += "</body>";
	   window.frame2.document.all.Message.value=msg;
	   
	   //alert(msg)
	   window.frame2.document.frmSendEmail.submit();
	   
	   return svbody;
}
//==============================================================================
//set fields on IE
//==============================================================================
function set_Chrome_fields(msg, toaddr, subj, body, incl, addcommt)
{
	window.frame2.contentDocument.forms[0].MailAddr.value = toaddr;

	// send on store mail account
	var ccmail = "";
	    
	window.frame2.contentDocument.forms[0].CCMailAddr.value = ccmail;

	   var str = Store;	   
	   if(Store.length==1){ str = "0" + Store; }
	   var frAddr = "Store" + str + "@sunandski.com"
	   window.frame2.contentDocument.forms[0].FromMailAddr.value = frAddr;
	   window.frame2.contentDocument.forms[0].Subject.value = subj;
	   window.frame2.contentDocument.forms[0].Reload.value = Reload;
	  
	   var svbody = body;
	   
	   if(body != "" && incl)
	   {
	      msg = "<div style='color:blue; font-size:14px;'>" + body + "</div>"
	          + "<br><hr /><br>" + msg;
	   }
	   else if(body != "" && !incl){ msg = body; }

	   msg += "</body>";
	   window.frame2.contentDocument.forms[0].Message.value=msg;	   
	    
	   window.frame2.contentDocument.forms[0].submit(); 
	   
	   return svbody;
}
//==============================================================================
// show Log Entries
//==============================================================================
function rtvLogEntires()
{
   var url = "MosCtlLog.jsp?"
     + "Ctl=" + CtlNum
   //alert(url)
   window.frame4.location.href = url;
}
//==============================================================================
// show Log Entries
//==============================================================================
function setLogSts(type, item, sku, vensty, sts, recusr, recdt, rectm, desc)
{
	if(item.length > 0)
	   {
		   var panel = "<table id='tblAllLog' border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	    		panel += "<tr class='trHdr01'>"    	    
	    	    + "<th class='th02' >Type</th>"
	    	    + "<th class='th02' >Control<br>Status</th>"
	    	    + "<th class='th02' >Sku</th>"
	    	    + "<th class='th02' >Description</th>"
	    	    + "<th class='th02' >Vendor<br>Style</th>"
	    	    + "<th class='th02' >Item<br>Status</th>"
	    	    + "<th class='th02' >User</th>"
	    	    + "<th class='th02' >Date</th>"
	    	    + "<th class='th02' >Time</th>"
	    	  + "</tr>"
	    	  
	       for(var i=0; i < item.length; i++)
	       {
	    	   panel += "<tr class='trDtl07'>"    		
	    	   panel +="<td class='td11'>" + type[i] + "</td>"
	    	   
	    	   if(type[i]=="Ctl"){ panel +="<td class='td11'>" + sts[i] + "</td>" }
	    	   else { panel +="<td class='td11'>&nbsp;</td>" }
	    	   
	    	   panel += "<td class='td11' >" + sku[i] + "</td>"
	    	    + "<td class='td11' >" + desc[i] + "&nbsp;</td>"
	    	  	+ "<td class='td11' >" + vensty[i] + "&nbsp;</td>"	    	  	
	    	  	
	    	   if(type[i]!="Ctl"){ panel +="<td class='td11'>" + sts[i] + "</td>" }
		       else { panel +="<td class='td11'>&nbsp;</td>" }
	    	  	
	    	   panel += "<td class='td11' >" + recusr[i] + "</td>"
	    	   panel += "<td class='td11' >" + recdt[i] + "</td>"
	    	   panel += "<td class='td11' >" + rectm[i] + "</td>"	    	  	
	       }
	       panel += "</tr></table>";
		  document.all.dvLog.innerHTML = panel;
		  document.all.tblCtlLog.style.pageBreakBefore = "always";
	   }	
}
//==============================================================================
//print
//==============================================================================
function print_onclick() {
    window.print();	
    return false;
}
//==============================================================================
// print merchandise return to vendor form  
//==============================================================================
function print_SndForm(item)
{
	var url = "MosPrtRtnForm.jsp?Ctl=" + CtlNum
	  + "&Item=" + item;
    window.location.href = url;
}
//==============================================================================
// set status as link or string
//==============================================================================
function setItmStsVis(show)
{
	var ldisp = "block";
	var edisp = "none";
	if(!show)
	{
		ldisp = "none";
		edisp = "block";
	}
	
	if(document.all.spnItmSts != null && document.all.spnItmSts.length == 1)
	{
		document.all.spnItmSts.style.display = ldisp;
		document.all.spnItmStsEmail.style.display = edisp;
	}
	else if(document.all.spnItmSts != null )
	{
		var lspn = document.all.spnItmSts;
		var espn = document.all.spnItmStsEmail;
		for(var i=0; i < lspn.length; i++)
		{
			lspn[i].style.display = ldisp;
			espn[i].style.display = edisp;
		}
	}
}
//==============================================================================
//get Item additioanl info
//==============================================================================
function getItemInfo(item, reas, obj)
{
  if(!DispAddInf)
  {
	
	ToolObj = obj;
	var html = "";
	
	
	if(isItemAddInfoReq(reas, "AddInfo") && getItemAddInfo(item, "AddInfo", null))
	{
	    html = "Name: " + IaName + "<br>Address: " + IaAddr + "<br>City/State,Zip: " + IaCity
	     + ", " + IaState + ", " + IaZip + "<br>Phone: " + IaPhone;	    
	    html += "<br>Comment: <span id='spn1stCommt'><span>";
	    rtv1stItemComments(item);
	}
	else if(isItemAddInfoReq(reas,  "Crime") && getItemAddInfo(item, "Crime", null))
	{
		html = "Date/Time: " + TfDate + " " + TfTime 
		  + "<br>Place: " + TfPlace + "<br>Area in Store: " + TfArea
		  + "<br>Found by: " + TfFoundBy
		  + "<br>Mgr: " + TfMgr + "<br>Comment: " + TfCommt;
	}
	else if(Defect && getItemAddInfo(item, "Defect", null))
	{
		html = "Defective Reason(s):<br>"
		var coma = "";
		for(var i=0; i < DefectLst.length ;i++)
		{
			for(var j=0; j < ArrDfc.length ;j++)
			{
				if(DefectLst[i]==ArrDfc[j])
			    { 		
					html += coma + ArrDfc[j];
					coma = ",";
			    }
		    }
		}    	
	}
	showItemInfo(html);
  }
  else
  {
	  document.all.dvToolTip.style.visibility = "hidden";
  }
}
//==============================================================================
//get Item additioanl info
//==============================================================================
function showItemInfo(html)
{	
	var pos = getObjPosition(ToolObj);
	document.all.dvToolTip.innerHTML = html;
	document.all.dvToolTip.style.left = pos[0] + 310 ;
	document.all.dvToolTip.style.top = pos[1] - 10;
	document.all.dvToolTip.style.visibility = "visible";
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel2()
{
	document.all.dvToolTip.style.visibility = "hidden";
}
//==============================================================================
//fold/unfold aditional information
//==============================================================================
function dispAddInfo()
{
	var disp = "none";
	if(!DispAddInf && isIE && ua.indexOf("MSIE 7.0") >= 0){ disp = "block"; }
	else if(!DispAddInf ){ disp = "table-row"; }
	
	DispAddInf = !DispAddInf;
	
	for(var i=0; i < RowNum; i++)
	{
		var rownm = "trAddInf" + i;
		var row = document.all[rownm];
		if(row != null)
		{
			for(var j=0; j < row.length; j++)
			{
				row[j].style.display = disp;
			}
		}
		
	}
	
	if(DispAddInf) {document.all.dvToolTip.style.visibility = "hidden";}
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<title>MOS Ctl Entry</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame3"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame4"  src=""  frameborder=0 height="0" width="0"></iframe> 
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvToolTip" class="dvToolTip"></div>
<div id="dvPhoto" class="dvItem"></div>
<div id="dvReason" class="dvItem"></div>
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/1.0 MOS - Entry.pdf" class="helpLink" target="_blank">&nbsp;</a></div>
<!-------------------------------------------------------------------->
   <table  class="tbl01" id="tblClaim" width="100%" >
     <tr>       
      <td ALIGN="center" VALIGN="TOP"nowrap>      
      <span id="spnHdrImg"><img src="Sun_ski_logo4.png" height="50px" alt="Sun and Ski Patio"></span>
      <br><b>MOS / Defective Item(s) Return
      <br>
       </b>
       </td>       
      </tr>

    <tr class="NonPrt">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="MosCtlSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
        &nbsp;&nbsp;&nbsp;        
      </td>
    </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table class="tbl01">
     <tr class="trDtl04">
     	<td class="td11" width="30%" nowrap>Status:     	     
     	    <span id="spnSts">
     	        <%if((bAllowDlt || bAllowSbm)  && !sCtlSts.equals("Processed")){%>
     	    		<a href="javascript: chgStatusMenu();"><%=sCtlSts%></a> &nbsp;
     	    		<span style="font-size:10px;">
     	    		Click on current status, to change entry to be 'Submitted' for DM Approval.
     	    		</span>
     	    	<%} else{%><%=sCtlSts%><%}%>
     	    </span>
     	    <span id="spnStsEmail"><%=sCtlSts%></span>     	    
     	</td>
     	<td class="td11" nowrap>Control Number: <b><%=sSelCtl%></b> </td>
     	<td class="td11">Store: <%=sStr%></td>        
     </tr>   
     <tr class="trDtl04">     	
     	<td class="td11" nowrap>Created On: <%=sCtlDt%> / <%=sCtlTm%></td>
     	<td class="td51" rowspan=2 colspan=2 nowrap>
     	   <%if(sDefect.equals("Y")){%>DEFECTIVE ITEM RETURNS (to #99)<%} else{%>MOS (Mark Out of Stock)<%}%>
     	</td>
     </tr>  
     <tr class="trDtl04">
     	<td class="td11" nowrap>By User: <%=sCtlUsr%></td>     	
     </tr>     
           
   </table>
   
 <!----------------------- end of table ------------------------>
     </td>
   </tr>
    <tr id="trBotton1">
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>   
           <button class="Small" onClick="addCtlHdrCommt(0,null,'ADD');">Add Comments</button> &nbsp;
           <button class="Small" onClick="setEMail( );">Email SM</button>&nbsp;           
           <button class="Small" onClick="print_onclick();">Print</button> &nbsp;                    
      </td>
    </tr>

    <!----------------------- Claim Comments ------------------------>
    <tr>
      <td colspan=3 align=left><br><div id="dvCTlHdrCommt" style="width:100%;"></div><br>&nbsp;</td>
    </tr>
    <!----------------------- Purchased Item List ----------------------------->
    	<tr id="trLinks1">
      		<td colspan=3> 
      		    <%if(sCtlSts.equals("Open")){%>
      		    	<a href="javascript: chgCtlItm('ADD_ITEM', null, null, null, null, null)">Add Sku</a> &nbsp; &nbsp;
      			<%}%>
      			<a href="javascript: dispAddInfo()">Show Reason Details/Un-Show Reason Details</a>
      	 	</td>
    	</tr>
    
    
    <tr>    
      <td colspan=3>
         <table class="tbl01"  width="100%" id="tblItem">
           <tr class="trHdr01">
              <th class="th02" rowspan=2 nowrap>Short SKU<br>UPC</th>
              <th class="th02" rowspan=2 nowrap>Vendor Name<br>Vendor Style</th>
              <th class="th02" rowspan=2 nowrap>Color</th>
              <th class="th02" rowspan=2 nowrap>Size</th>
              <th class="th02" rowspan=2 nowrap>Description<br>Reason</th>
              <th class="th02" rowspan=2 nowrap>QTY</th>
              <th class="th02" rowspan=2 nowrap>Ret</th>
              <th class="th02" rowspan=2 nowrap>Cost</th>
              <th class="th02" rowspan=2 nowrap>Ext.<br>Cost</th>              
              <!-- th class="th02" rowspan=2 nowrap>Status</th -->  
              <th class="th02" id="cellLink" nowrap>Comments</th>
              <th class="th02" id="cellLink" nowrap>Photo</th>
              <th class="th02" id="cellLink" rowspan=2 nowrap>Upd</th>
              <th class="th02" id="cellLink" rowspan=2 nowrap>D<br>l<br>t</th>             
           </tr>
           <tr class="trHdr01">
           		<th class="th02" id="cellLink">Add</th>
           		<th class="th02" id="cellLink">Add</th>           		
           </tr>
            
           <%String sCss1="trDtl04";
             boolean bExists = false;
           %>           
           <% int irow=0;
             while(ctlinfo.getNext())
       	    { 
        	    bExists = true;
       		ctlinfo.setDetail();
       		String sItmId = ctlinfo.getItmId();
       		String sSku = ctlinfo.getSku();
       		String sReas = ctlinfo.getReas();
       		String sItmSts = ctlinfo.getItmSts();
       		String sRecUsr = ctlinfo.getRecUsr();
       		String sRecDt = ctlinfo.getRecDt();
       		String sRecTm = ctlinfo.getRecTm();
       		String sDesc = ctlinfo.getDesc();
       		String sVenSty = ctlinfo.getVenSty();		 
       		String sUpd = ctlinfo.getUpd();
       		String sQty = ctlinfo.getQty();
    		String sCost = ctlinfo.getCost();
    		String sExtCost = ctlinfo.getExtCost();
    		String sClrNm = ctlinfo.getClrNm();
    		String sSizNm = ctlinfo.getSizNm();
    		String sIaName = ctlinfo.getIaName();
    		String sAddr = ctlinfo.getAddr();
    		String sCity = ctlinfo.getCity();
    		String sState = ctlinfo.getState();
    		String sZip = ctlinfo.getZip();
    		String sPhone = ctlinfo.getPhone();
    		String sRet = ctlinfo.getRet();
    		String sExtRet = ctlinfo.getExtRet();
    		String sVenNm = ctlinfo.getVenNm();
    		String sItmDefect = ctlinfo.getItmDefect();
    		String sThfDate = ctlinfo.getThfDate();
    		String sThfTime = ctlinfo.getThfTime();
    		String sThfPlace = ctlinfo.getThfPlace();
    		String sThfFndBy = ctlinfo.getThfFndBy();
    		String sThfMngr = ctlinfo.getThfMngr();
    		String sThfCommt = ctlinfo.getThfCommt();
    		String sThfArea = ctlinfo.getThfArea();    		
    		int iMaxCmt = ctlinfo.getMaxCmt();
    		String sItmSubCat = ctlinfo.getSubCat();
    		
    		boolean bAddInfo = !sIaName.equals("");    		
    		boolean bThfInfo = !sThfDate.equals("01/01/0001");
    		boolean bCommt = iMaxCmt > 0;
       		%>
       		<script>
       		   <%if(sReas.equals("Theft")){%>TheftFlag = true;<%}%>
       		   <%if(sItmSubCat.equals("Grassroots Marketing")){%>GrossrootFlag = true;<%}%>
       		</script>
              <tr class="<%=sCss1%>">
                 <td class="td11" nowrap><%=sSku%></td>
                 <td class="td11" nowrap><%=sVenNm%></td>
                 <td class="td11" nowrap><%=sClrNm%></td>
                 <td class="td11" nowrap><%=sSizNm%></td>
                 <td class="td11" nowrap><%=sDesc%>
                    <%if(sDefect.equals("Y")){%>&nbsp;&nbsp;
                        <a class="Small" href="javascript: print_SndForm('<%=sItmId%>');">Print</button>
                    <%}%>
                 </td>
                 <td class="td12" nowrap><%=sQty%></td>
                 <td class="td11" nowrap>$<%=sRet%></td>
                 <td class="td11" nowrap>$<%=sCost%></td>                 
                 <td class="td11" nowrap>$<%=sExtCost%></td>
                 
                 
                 <td class="td18" id="cellLink" rowspan=2 nowrap>
                 	<%if(sCtlSts.equals("Open")){%>
                 		<a href="javascript: addItmComments('<%=sItmId%>', '<%=sSku%>', 0, null, 'ADD_ITEM_COMMT')">Add</a>
                 	<%}%>
                 </td>                 	
                 <!-- td class="td18" rowspan=2 nowrap><a href="javascript: scrollToItemComm('<%=sItmId%>')"><img style="border:none;"  src="Comments_Img1.bmp" width="15" height="20" alt="Show Comments" /></a></td-->
                 
                 <td class="td18" id="cellLink" rowspan=2 nowrap>
                 	<%if(sCtlSts.equals("Open")){%>
                 		<a href="javascript: loadPhoto('<%=sItmId%>')">Add</a>
                 	<%}%>
                 </td>
                 <!-- td class="td18" rowspan=2 nowrap><a href="javascript: scrollToItemPic('<%=sItmId%>', '<%=sSku%>')"><img style="border:none;"  src="Camera_Img.jpg"  width="40" height="25" alt="Add Photo" /></a></td -->
                 <td class="td18" id="cellLink" rowspan=2 nowrap>
                    <%if(sCtlSts.equals("Open") || bAllowUpd && sCtlSts.equals("Submitted")){%>
                 		<a href="javascript: chgCtlItm('UPD_ITEM','<%=sItmId%>', '<%=sSku%>', '<%=sQty%>','<%=sReas%>','<%=sItmSubCat%>')">Upd</a>
                 	<%}%>
                 </td>
                 <td class="td18" id="cellLink" rowspan=2 nowrap>
                 	<%if(sCtlSts.equals("Open")){%>
                 		<a href="javascript: chgCtlItm('DLT_ITEM','<%=sItmId%>', '<%=sSku%>', '<%=sQty%>','<%=sReas%>','<%=sItmSubCat%>')">D</a>
                 	<%}%>
                 </td>
              </tr>    
              <tr class="<%=sCss1%>">
                 <td class="td12" nowrap><%=sUpd%>&nbsp;</td>
                 <td class="td12" nowrap><%=sVenSty%></td>                 
                 <td class="td11" nowrap>&nbsp;</td>
                 <td class="td11" nowrap>&nbsp;</td>
                 <td class="td12" nowrap onmouseover="getItemInfo('<%=sItmId%>', '<%=sReas%>', this)" onmouseout="hidePanel2()">
                 	<%if(sDefect.equals("Y")){%><%=sItmDefect%><%} else {%><%=sReas%><%}%>
                    &nbsp;
                 </td>
                 <td class="td11" colspan=4><%=sItmSubCat%></td>                  
              </tr>              
              <!-- Additional Information -->
              <%if(bAddInfo){%>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Name: <%=sIaName%></td>
              	</tr>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Address: <%=sAddr%></td>
              	</tr>  
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>City/State,Zip: <%=sCity%>, <%=sState%>, <%=sZip%></td>
              	</tr>             	
              <%}%>
              
              <!-- Theft --> 
              <%if(bThfInfo){%>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Date: <%=sThfDate%> <%=sThfTime%></td>
              	</tr>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Place: <%=sThfPlace%></td>
              	</tr>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Area in Store: <%=sThfArea%></td>
              	</tr>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Found By: <%=sThfFndBy%></td>
              	</tr>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Found By: <%=sThfFndBy%></td>
              	</tr>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>Manager: <%=sThfMngr%></td>
              	</tr>
              	<tr class="trDtl24" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14>Comment: <%=sThfCommt%></td>
              	</tr>
              <%} %>
              
              <!-- Comments --> 
              <%if(bCommt){%>
              	<tr class="<%=sCss1%>" style="display:none" id="trAddInf<%=irow%>">
                	<td class="td11" colspan=14 nowrap>                	
                		<table class="tbl01"  width="100%" id="tblItmCmmt">
                		<%
                		for(int i=0; i < iMaxCmt; i++)
                		{
                			ctlinfo.setItemCommt();
                			String sCmtType = ctlinfo.getCmtType();
                			String sCmtUser = ctlinfo.getCmtUser();
                			String sCmtDate = ctlinfo.getCmtDate();
                			String sCmtTime = ctlinfo.getCmtTime();
                			String sCmtEmp = ctlinfo.getCmtEmp();
                			String sCmtEmpNm = ctlinfo.getCmtEmpNm();
                			String sCmtTxt = ctlinfo.getCmtTxt();
                		%>
                		  <tr class="<%=sCss1%>" id="trAddInf<%=irow%>">
                		    <td class="td11" width="41%">&nbsp;</td>
                			<td class="td11" width="18%" nowrap><%=sCmtUser%>, <%=sCmtDate%>, <%=sCmtTime%></td>
                			<td class="td11"><%=sCmtTxt%></td>
              			  </tr>              		
                		<%}%>
                		</table>
                	</td>
              	</tr>
              <%} %>
              
              
              <%if(sCss1.equals("trDtl06")) { sCss1="trDtl04"; } else { sCss1="trDtl06"; }%>
              <%irow++;%>
           <%}%>
           <script>
           	ItemExists = <%=bExists%>;
           	RowNum = "<%=irow%>";
           </script>
           <!----------------------- end of table ------------------------>
           <%
           	  ctlinfo.setItemTotal();
       		  String sQty = ctlinfo.getQty();
       	      String sExtCost = ctlinfo.getExtCost();
       	      String sExtRet = ctlinfo.getExtRet();       	      
           %>
           <tr class="trDtl15">
               <td class="td11" nowrap colspan=5>Total</td>
               <td class="td12" nowrap><%=sQty%></td>
               <td class="td12" nowrap>&nbsp;</td>
               <td class="td12" nowrap>&nbsp;</td>
               <td class="td11" nowrap>$<%=sExtCost%></td>
               <td class="td12" nowrap colspan=5>&nbsp;</td>
           </tr>      
         </table>
      </td>
    </tr>
    <tr>
      <td align=left>
    <!----------------------- end of table ------------------------>
    <br>
    
    <!-- =========================== total cost recap table ============================ -->
    <%
    	ctlinfo.setRecapTot();
		int iNumOfRec = ctlinfo.getNumOfRec();
		String [] sRecapReas = ctlinfo.getRecapReas();
		String [] sRecapQty = ctlinfo.getRecapQty();
		String [] sRecapCost = ctlinfo.getRecapCost();
		String [] sRecapRet = ctlinfo.getRecapRet();
    %>
    <p text-align=left>        
    <table class="tbl02"  id="tblRecap">
    	<tr class="trHdr01"><th class="th02" colspan=3 nowrap>Total Costs</th></tr>
    	<tr class="trHdr01">
    		<th class="th02">Reason</th>
    		<th class="th02">Total Qty</th>
    		<th class="th02">Total Cost</th>
    	</tr>  
    	<%for(int i=0; i < iNumOfRec; i++){%>
    		<tr class="trDtl04">
               <td class="td11"><%=sRecapReas[i]%></td>
               <td class="td12"><%=sRecapQty[i]%></td>
               <td class="td12">$<%=sRecapCost[i]%></td>
            </tr>   
    	<%}%>    
    	<tr class="trDtl15">
               <td class="td11">&nbsp;</td>
               <td class="td12"><%=sQty%></td>
               <td class="td12">$<%=sExtCost%></td>
        </tr>      
   	</table>
   <!-- ================================================================================== -->
    

    
    <!----------------------- Item Pictures ------------------------>
    <table border=0 cellPadding="0"  cellSpacing="0" id="tblClaimPic">
        <tr  class="NonPrt">
           <td colspan=3 align=left><br><div id="dvItmPictures" style="width:100%;"></div>
        </td>
    </tr>
   </table>

   <!----------------------- Item Pictures ------------------------>
    <table border=0 cellPadding="0"  cellSpacing="0" id="tblCtlLog">
        <tr >
           <td><br><div id="dvLog" style="width:100%;"></div>
        </td>
       </tr>
   </table> 
   
   <!----------------------- Item Comments ------------------------>
    <table border=0 cellPadding="0"  cellSpacing="0" id="tblItmCommt" width="100%">
    	<tr>
      		<td colspan=3 align=left><br><div id="dvItmComments" style="width:100%;"></div></td>
        </tr>
    </table>
     </td>
    </tr>
   </table>
 </body>
</html>
<%
ctlinfo.disconnect();
ctlinfo = null;
}
%>






