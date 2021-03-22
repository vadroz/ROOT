<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*
,rciutility.CallAs400SrvPgmSup"%>
<%
   String sSrchCls = request.getParameter("Cls");
   String sSrchStr = request.getParameter("Str");
   String sSrchSiz = request.getParameter("Siz");
   String sSrchSizNm = request.getParameter("SizNm");
   String sSrchSn = request.getParameter("SrlNum");
   String sAction = request.getParameter("Action");
   
   if(sSrchCls == null){sSrchCls = "";}
   if(sSrchStr == null){sSrchStr = "";}
   if(sSrchSiz == null){sSrchSiz = "";}
   if(sSrchSizNm == null){sSrchSizNm = "";}
   if(sAction == null){sAction = "Standalone";}
   
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RentInvAdd.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   	String sUser = session.getAttribute("USER").toString();
   	String sStrAllowed = session.getAttribute("STORE").toString();
   	
   	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   	
   	String sPrepStmt = "select rvtype, rvven, vnam"
	 + " from Rci.ReVend"
	 + " inner join IPTSFIL.IpMrVen on rvven=vven"   		    
	 + " order by rvtype, vnam";
	   	
   	//System.out.println(sPrepStmt);
	   	
	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();
	   		   
	Vector<String> vVenTy = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vVenNm = new Vector<String>();
	   		   
	while(runsql.readNextRecord())
	{
		vVenTy.add(runsql.getData("rvtype").trim());
		vVen.add(runsql.getData("rvven").trim());
		vVenNm.add(runsql.getData("vnam").trim());
	}
	runsql.disconnect();
	runsql = null;
	
	sPrepStmt = "select rmtype, rmModel, rmbrand, rmage"
		 + " from Rci.ReModel"   		    
		 + " order by rmtype, rmbrand, rmage, rmModel";			   	
	//System.out.println(sPrepStmt);
			   	
	rslset = null;
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();
			   		   
	Vector<String> vModTy = new Vector<String>();
	Vector<String> vMod = new Vector<String>();
	Vector<String> vModVen = new Vector<String>();
	Vector<String> vModAge = new Vector<String>();
			   		   
	while(runsql.readNextRecord())
	{
		vModTy.add(runsql.getData("rmtype").trim());
		vMod.add(runsql.getData("rmmodel").trim());
		vModVen.add(runsql.getData("rmbrand").trim());
		vModAge.add(runsql.getData("rmage").trim());
	}
	runsql.disconnect();
	runsql = null;
	
	String [] sArrModTy = vModTy.toArray(new String[vMod.size()]);
	String [] sArrMod = vMod.toArray(new String[vMod.size()]);
	String [] sArrModVen = vModVen.toArray(new String[vMod.size()]);
	String [] sArrModAge = vModAge.toArray(new String[vMod.size()]);
	
	String sModTyJsa = srvpgm.cvtToJavaScriptArray(sArrModTy);
	String sModJsa = srvpgm.cvtToJavaScriptArray(sArrMod);
	String sModVenJsa = srvpgm.cvtToJavaScriptArray(sArrModVen);
	String sModAgeJsa = srvpgm.cvtToJavaScriptArray(sArrModAge);
	
	// ================= size list ============
	sPrepStmt = "select RSTYPE, RSGENAGE, RSSIZE, snam"
			 + " from Rci.ReSize"
			 + " inner join iptsfil.IpSizes on rssize=ssiz"
			 + " order by rstype, rsgenage, snam";			   	
	//System.out.println(sPrepStmt);
				   	
	rslset = null;
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();
				   		   
	Vector<String> vSizTy = new Vector<String>();
	Vector<String> vSizGen = new Vector<String>();
	Vector<String> vSiz = new Vector<String>();
	Vector<String> vSizNm = new Vector<String>();
				   		   
	while(runsql.readNextRecord())
	{
		vSizTy.add(runsql.getData("rstype").trim());
		vSizGen.add(runsql.getData("RSGENAGE").trim());
		vSiz.add(runsql.getData("rssize").trim());
		String sSizNm = runsql.getData("snam").trim();
		sSizNm = sSizNm.replace("'", "`");
		sSizNm = sSizNm.replace("\"", " ");
		vSizNm.add(sSizNm);
		
	}
	runsql.disconnect();
	runsql = null;
		
	// get current year
	int iYear = Calendar.getInstance().get(Calendar.YEAR);
		
	// current date
	SimpleDateFormat dtf = new SimpleDateFormat("MM/dd/yyyy");
	java.util.Date date = new java.util.Date();		
	String sCurDate = dtf.format(date);
	
	
	sPrepStmt = "select EIINVID,EISTR,EICLS,EISRLN,EIPRCHYR,EIBRAND,EIMODEL,EIADDDT,EIMFGSN,EILIFE,EITRADE"
		+ ",clnm, vnam, snam"	
		+ " from Rci.ReInv"			 
		+ " inner join iptsfil.IpClass on eicls=ccls"
		+ " inner join iptsfil.IpMrVen on eibrand=vven"
		+ " inner join iptsfil.IpSizes on eisiz=ssiz"
		+ " where EIRECDT = current date and EIRECUS='" + sUser + "'"
		+ " order by EIRECTM desc";			   	
	//System.out.println(sPrepStmt);
				   	
	rslset = null;
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();
				   		   
	Vector<String> vNwInvD = new Vector<String>();
	Vector<String> vNwStr = new Vector<String>();
	Vector<String> vNwCls = new Vector<String>();
	Vector<String> vNwSn = new Vector<String>();
	Vector<String> vNwPerchYr = new Vector<String>();
	Vector<String> vNwBrand = new Vector<String>();
	Vector<String> vNwModel = new Vector<String>();
	Vector<String> vNwAddDt = new Vector<String>();
	Vector<String> vNwMfgSn = new Vector<String>();
	Vector<String> vNwLife = new Vector<String>();
	Vector<String> vNwClsNm = new Vector<String>();
	Vector<String> vNwVenNm = new Vector<String>();	
	Vector<String> vNwSizNm = new Vector<String>();
	Vector<String> vNwTrade = new Vector<String>();
				   		   
	while(runsql.readNextRecord())
	{
		vNwInvD.add(runsql.getData("EIINVID").trim());
		vNwStr.add(runsql.getData("eiStr").trim());
		vNwCls.add(runsql.getData("eiCls").trim());
		vNwSn.add(runsql.getData("EISRLN").trim());
		vNwPerchYr.add(runsql.getData("EIPRCHYR").trim());
		vNwBrand.add(runsql.getData("eiBrand").trim());
		vNwModel.add(runsql.getData("eiModel").trim());
		vNwAddDt.add(runsql.getData("eiAddDt").trim());
		vNwMfgSn.add(runsql.getData("eiMfgSn").trim());
		vNwLife.add(runsql.getData("eiLife").trim());
		vNwTrade.add(runsql.getData("eiTrade").trim());
		vNwClsNm.add(runsql.getData("clnm").trim());
		vNwVenNm.add(runsql.getData("vnam").trim());
		vNwSizNm.add(runsql.getData("snam").trim());
	}
	runsql.disconnect();
	runsql = null;
	
	// get current FY year
	sPrepStmt = "select pyr#"
			 + " from Rci.FsyPer"
			 + " where pida = current date";			   	
	//System.out.println(sPrepStmt);
	rslset = null;
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();				   		   
	String sYear = "";
	runsql.readNextRecord();
	sYear = runsql.getData("pyr#"); 
	iYear = Integer.parseInt(sYear);
	runsql.disconnect();
	runsql = null;
	
	String sSrchClsNm = "";
	System.out.println("\nClass Selection ==>" + sAction);
	if(sAction.equals("CrtNewForStrCls"))
	{
		// get current FY year
		sPrepStmt = "select clnm"
	 	+ " from iptsfil.IpClass"
	 	+ " where ccls =" + sSrchCls;	
	    
		System.out.println("sPrepStmt: " + sPrepStmt);
		
	    rslset = null;
		runsql = new RunSQLStmt();
		runsql.setPrepStmt(sPrepStmt);		   
		runsql.runQuery();				   		   
	
		runsql.readNextRecord();
		sSrchClsNm = runsql.getData("clnm"); 
		runsql.disconnect();
		runsql = null;
	}
	boolean bAllowAttr = sUser.equals("vrozen") || sUser.equals("psnyder") || sUser.equals("kknight")
			|| sUser.equals("criley") || sUser.equals("jburke")
			|| sUser.equals("kporter") || sUser.equals("jmorris")
			;
   %>
<html>

<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />

<title>Rent-Add Inv</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>

<SCRIPT>
//--------------- Global variables -----------------------
var SrchCls = "<%=sSrchCls%>";
var SrchClsNm = "<%=sSrchClsNm%>";
var SrchStr = "<%=sSrchStr%>";
var SrchSiz = "<%=sSrchSiz%>";
var SrchSizNm = "<%=sSrchSizNm%>";
var SrchSn = "<%=sSrchSn%>";
var Action = "<%=sAction%>";
var SvAction = "<%=sAction%>";

var ModTy = [<%=sModTyJsa%>];
var ModLst = [<%=sModJsa%>];
var ModVen = [<%=sModVenJsa%>];
var ModAge = [<%=sModAgeJsa%>];

var LastAction = "";

var NwStr = "";
var NwSizNm = "";
var NwSn = "";
var NwVenNm = "";
var NwModel = "";
var NwMfgSn = "";
var NwPurchYr = "";
var NwLife = "";
var NwTrade = "";
var NwAddDt = "";
var InvSts = null;

var ExInvId = "";
var ExStr = "";
var ExCls = "";
var ExSiz = "";
var ExSrlNum = "";
var ExPerchYr = "";
var ExBrand = "";
var ExModel = "";
var ExMfgSn = "";
var ExLife = "";
var ExTrade = "";
var ExClsNm = "";
var ExVenNm = "";
var ExSizNm = "";
var ExInvSts = "";
var ExReason = "";
var ExCont = "";
var ExContPD = "";
var ExContRD = "";
var ExContSts = "";
var ExTestDt = "";
var ExGrade = "";
var ExTech = "";
var ExAddDt = "";
var ExAddTm = "";
var ExAddUs = "";
 
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvCont", "dvItem", "dvComment"]);
	 	
	document.getElementById("tblVen01").style.display = "none";
	document.getElementById("tblVen02").style.display = "none";
	document.getElementById("tblVen03").style.display = "none";
	document.getElementById("tblVen04").style.display = "none";
	document.getElementById("tblVen05").style.display = "none";	
	document.getElementById("tblVen06").style.display = "none";	
	document.getElementById("tblVen07").style.display = "none";
	document.getElementById("tblVen08").style.display = "none";
	document.getElementById("tblVen09").style.display = "none";
	document.getElementById("tblVen10").style.display = "none";
	document.getElementById("tblVen11").style.display = "none";
	document.getElementById("tblVen12").style.display = "none";
	
	document.getElementById("tblSize01").style.display = "none";
	document.getElementById("tblSize02").style.display = "none";
	document.getElementById("tblSize03").style.display = "none";
	document.getElementById("tblSize04").style.display = "none";
	document.getElementById("tblSize05").style.display = "none";
	document.getElementById("tblSize06").style.display = "none";
	document.getElementById("tblSize07").style.display = "none";
	document.getElementById("tblSize08").style.display = "none";
	document.getElementById("tblSize09").style.display = "none";
	document.getElementById("tblSize10").style.display = "none";
	document.getElementById("tblSize11").style.display = "none";
	document.getElementById("tblSize12").style.display = "none";
	document.getElementById("tblSize13").style.display = "none";
	document.getElementById("tblSize14").style.display = "none";
	document.getElementById("tblSize15").style.display = "none";
	
	document.getElementById("spnEquip0").style.display = "none";
	document.getElementById("spnEquip1").style.display = "none";
	document.getElementById("spnEquip2").style.display = "none";
	document.getElementById("spnEquip3").style.display = "none";
	document.getElementById("spnEquip4").style.display = "none";
	document.getElementById("spnEquip5").style.display = "none";
	document.getElementById("spnEquip6").style.display = "none";
	document.getElementById("spnEquip7").style.display = "none";
	document.getElementById("spnEquip8").style.display = "none";
	
	
	document.getElementById("tbody1").style.visibility = "hidden";
	
	if(Action == "UpdInvBySrlNum")
	{
		var sn = document.all.SrlNum;
		sn.value = SrchSn;
		chkSrlNum(sn);
	}
	document.all.SrlNum.focus();
}
//==============================================================================
//validate new serial number
//==============================================================================
function vldSrlNum()
{
	var error = false;
	var msg="";
	var errfld = document.all.tdError;
	errfld.innerHTML = ""; 
	var br = "";
	
	var str = null;
	var strobj = document.all.Str;
	for(var i=0; i < strobj.length  ;i++)
	{
		if(strobj[i].checked){ str = strobj[i].value; break; }
	}
	if(!str){ error=true; msg += br + "Please select Store"; br = "<br>"; }
	
	var trade = null;
	var tradeobj = document.all.Trade;
	for(var i=0; i < tradeobj.length  ;i++)
	{
		if(tradeobj[i].checked){ trade = tradeobj[i].value; break; }
	}
	if(!trade){ error=true; msg += br + "Please select Trade-In flag"; br = "<br>"; } 
	
	var srlnum = document.all.SrlNum.value.trim();
	
	var rety = null;
	var retyobj = document.all.RentTy;
	for(var i=0; i < retyobj.length  ;i++)
	{
		if(retyobj[i].checked){ rety = retyobj[i].value; break; }
	}
	if(!rety){ error=true; msg += br + "Please select Rent Type"; br = "<br>"; }
	
	var grp = null;
	var grpobj = document.all.Group;
	for(var i=0; i < grpobj.length  ;i++)
	{
		if(grpobj[i].checked){ grp = grpobj[i].value; break; }
	}
	if(!grp){ error=true; msg += br + "Please select Group"; br = "<br>"; } 
	
	var eqty = null;
	var eqtyobj = document.all.EquipTy;
	for(var i=0; i < eqtyobj.length  ;i++)
	{
		if(eqtyobj[i].checked){ eqty = eqtyobj[i].value; break; }
	}
	if(!eqty && grp != "WATER"){ error=true; msg += br + "Please select Equipment Type"; br = "<br>"; } 
	
	
	var brand = document.all.Brand.value.trim();
	if(brand == ""){ error=true; msg += br + "Please select Brand"; br = "<br>";}
	
	var model = document.all.Model.value.trim();
	if(model == ""){ error=true; msg += br + "Please select Model"; br = "<br>";}
	
	var mfgsn = document.all.MfgSn.value.trim();
	
	var size = document.all.Size.value.trim();
	if( size == ""){ error=true; msg += br + "Please select Size"; br = "<br>";}
	
	var year = null;
	var yearobj = document.all.Year;
	for(var i=0; i < yearobj.length  ;i++)
	{
		if(yearobj[i].checked){ year = yearobj[i].value; break; }
	}
	if(!year){ year = "0";} 
	
	var life = null;
	var lifeobj = document.all.Life;
	for(var i=0; i < lifeobj.length  ;i++)
	{
		if(lifeobj[i].checked){ life = lifeobj[i].value; break; }
	}
	if(!life){ error=true; msg += br + "Please select Left of Life Years"; br = "<br>"; } 
			
	var adddt = document.all.AddDt.value.trim();
	
	var action = "ADDNEWINV";
	if(ExInvId != "") { action = "UPDNEWINV"; }
		
	if(error){ errfld.innerHTML = msg; }
	else
	{
		NwStr = str;
		NwSizNm = document.all.SizeNm.value;
		NwSn = srlnum;
		NwVenNm = document.all.BrandNm.value.trim();;
		NwModel = model;
		NwMfgSn = mfgsn;
		NwPurchYr = year;
		NwLife = life;
		NwTrade = trade;
		NwAddDt = adddt;
		
		LastAction = action;
		
		sbmNewSrlNum( str, rety, grp, eqty, srlnum, brand, model, mfgsn, size, year,life,trade,adddt,action ); 
	}
}

//==============================================================================
// submit new serial number
//==============================================================================
function sbmNewSrlNum( str, rety, grp, eqty, srlnum, brand, model, mfgsn, size, year,life
		,trade,adddt,action )
{   
   clearIframeContent("frame1");

   if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	 else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	 else{ nwelem = window.frame1.contentDocument.createElement("div");}
   
   nwelem.id = "dvSbmAddInv"

   var html = "<form name='frmAddInv'"
      + " METHOD=Post ACTION='RentContractSave.jsp'>"
      + "<input name='Str'>"
      + "<input name='RentTy'>"
      + "<input name='Grp'>"
      + "<input name='EquipTy'>"
      + "<input name='SrlNm'>"
      + "<input name='Brand'>"      
      + "<input name='Model'>"
      + "<input name='MfgSn'>"
      + "<input name='Siz'>"
      + "<input name='PurchYr'>"
      + "<input name='Life'>"
      + "<input name='Trade'>"
      + "<input name='AddDt'>"
      + "<input name='Action'>"
      + "<input name='User'>"
    html += "</form>"

   nwelem.innerHTML = html;
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
	 {
	    window.frame1.document.all.Str.value = str;
	    window.frame1.document.all.RentTy.value = rety;
  	 	window.frame1.document.all.Grp.value = grp;
  	 	window.frame1.document.all.EquipTy.value = eqty;
  	 	window.frame1.document.all.SrlNm.value = srlnum;
  	 	window.frame1.document.all.Brand.value = brand;
  	 	window.frame1.document.all.Model.value = model;
  	 	window.frame1.document.all.MfgSn.value = mfgsn;
  	 	window.frame1.document.all.Siz.value = size;
  	 	window.frame1.document.all.PurchYr.value = year;
  	 	window.frame1.document.all.Life.value = life;
  	 	window.frame1.document.all.Trade.value = trade;
  	 	window.frame1.document.all.AddDt.value = adddt;  	 	
 	 	window.frame1.document.all.Action.value= action;
 	 	window.frame1.document.all.User.value= "<%=sUser%>";
 	
 	 	window.frame1.document.frmAddInv.submit();
	 }
   else
   {
	   	window.frame1.contentDocument.forms[0].Str.value = str; 
	   	window.frame1.contentDocument.forms[0].RentTy.value = rety;
  	   	window.frame1.contentDocument.forms[0].Grp.value = grp;
  	   	window.frame1.contentDocument.forms[0].EquipTy.value = eqty;
  	 	window.frame1.contentDocument.forms[0].SrlNm.value = srlnum;
  	 	window.frame1.contentDocument.forms[0].Brand.value = brand;
  	 	window.frame1.contentDocument.forms[0].Model.value = model;
  	 	window.frame1.contentDocument.forms[0].MfgSn.value = mfgsn;
  	 	window.frame1.contentDocument.forms[0].Siz.value = size;
  	 	window.frame1.contentDocument.forms[0].PurchYr.value = year;
  	 	window.frame1.contentDocument.forms[0].Life.value = life;
  	 	window.frame1.contentDocument.forms[0].Trade.value = trade;
  	 	window.frame1.contentDocument.forms[0].AddDt.value = adddt;
  	   
  	   	window.frame1.contentDocument.forms[0].Action.value=action;
  	    window.frame1.contentDocument.forms[0].User.value="<%=sUser%>";
  	 	window.frame1.contentDocument.forms[0].submit();
   }   
}
//==============================================================================
//clear  iframe content
//==============================================================================
function clearIframeContent(id) 
{    
  try 
  {    	
  	if(isSafari)
  	{    		
  		try 
    	    {   
  			if(window.frame1.document.body == null)
  			{
  				var iframe = document.getElementById(id);
  				document.body.removeChild(iframe)
  				var frame = $("#frame0").clone();    			
  				document.appenChild(frame);
  			}
    		}
    		catch(e)
    		{
    			alert(e.message)
    		}
  	}
  	else
  	{
  		var iframe = document.getElementById(id);
  		var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	    	doc.body.innerHTML = "";
  	}
	}
	catch(e) 
	{
	    //alert(e.message);
  }
  return false;
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
// Hide selection screen
//==============================================================================
function hidePanel(obj)
{   
	if(document.all.CalendarMenu != null){ hidetip2(); }
	document.all[obj].innerHTML = " ";
   	document.all[obj].style.visibility = "hidden";   
}  
//==============================================================================
//show selected Vendor
//==============================================================================
function setBrand(ven, vennm)
{
	document.all.Brand.value = ven
	document.all.BrandNm.value = vennm 
	setModelSelTable(true);
} 
//==============================================================================
// set Model Selection Table
//==============================================================================
function setModelSelTable(clear)
{
	var ven = document.all.Brand.value;
	
	document.all.tdModelSel.innerHTML = "";
	if(clear)
	{
		document.all.Model.value = "";
	}
	
	var grpobj = document.all.Group;
	var grp = "";
	for(var i=0; i < grpobj.length; i++)
	{
	   if(grpobj[i].checked){ grp = grpobj[i].value; break; }
	}
	
	var eqty = "";
	for(var i=00; i < document.all.EquipTy.length; i++)
	{
		if(document.all.EquipTy[i].checked){ eqty = document.all.EquipTy[i].value; break;}
	}
		
	if(eqty == "Male" || eqty == "Female"){ eqty = "ADULT"; }
	if(eqty == "Jr" ){ eqty = "JR"; }
	
	var html = "<table>"
	for(var i=0, j=0; i < ModLst.length; i++)
	{
		if(ModTy[i] == grp && ModVen[i] == ven && ModAge[i] == eqty)
		{ 
			if(j > 0 || j % 3 == 0){ html += "</tr>"; }
			if(j== 0 || j % 3 == 0){ html += "<tr>";}
		
			html += "<td><a href='javascript: setModel(&#34;" 
			    + ModLst[i] + "&#34;)'>" + ModLst[i] + "</a>&nbsp;</td";
		   	
			j++;
		   	if(j == ModLst.length - 1){ html += "</tr>"; }
		}
	}
	
	
	if(grp=="BIKE")
	{
		for(var i=0, j=0; i < ModLst.length; i++)
		{
			if(ModTy[i] == eqty && ModVen[i] == ven)
			{ 
				if(j > 0 || j % 3 == 0){ html += "</tr>"; }
				if(j== 0 || j % 3 == 0){ html += "<tr>";}
			
				html += "<td><a href='javascript: setModel(&#34;" 
				    + ModLst[i] + "&#34;)'>" + ModLst[i] + "</a>&nbsp;</td";
			   	
				j++;
			   	if(j == ModLst.length - 1){ html += "</tr>"; }
			}
		}
	}
	
	
	
	
	html += "</table>";
	
	document.all.tdModelSel.innerHTML = html;
}
//==============================================================================
//show selected Model
//==============================================================================
function setModel(mod)
{
	document.all.Model.value = mod;	
}

//==============================================================================
//show selected Length/Size
//==============================================================================
function setSize(size, sizenm)
{
	document.all.Size.value = size;
	document.all.SizeNm.value = sizenm;
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
// refresh table
//==============================================================================
function refreshTbl(invid, cls, clsnm)
{	
	var tbody = document.getElementById("tbody2");
	var row = tbody.insertRow(0);
	row.className = "trDtl04";

	if(invid == "null"){ invid = ExInvId; }
	if(cls == "null"){ cls = ExCls; }
	if(clsnm == "null"){ clsnm = ExClsNm; }
	if(NwStr == ""){ NwStr = ExStr; }
	if(NwSizNm == ""){ NwSizNm = ExSizNm; }
	if(NwSn == ""){ NwSn = ExSrlNum; }
	if(NwVenNm == ""){ NwVenNm = ExVenNm; }
	if(NwModel == ""){ NwModel = ExModel; }
	if(NwMfgSn == ""){ NwMfgSn = ExMfgSn; }
	if(NwPurchYr == ""){ NwPurchYr = ExPerchYr; }
	if(NwLife == ""){ NwLife = ExLife; }
	if(NwTrade == ""){ NwTrade = ExTrade; }
	
	var td = new Array(12);
	td[0] = addElem("td", "td11", NwStr);
	td[1] = addElem("td", "td11", clsnm);
	td[2] = addElem("td", "td11", NwSizNm);
	
	td[3] = addElem("td", "td11", "");
	var newlink = document.createElement("a");
	var func = "javascript: updInvId('" + NwSn + "')";
	newlink.setAttribute("href", func);
	newlink.innerHTML = NwSn;
	td[3].appendChild(newlink);
	
	td[4] = addElem("td", "td11", NwVenNm);
	td[5] = addElem("td", "td11", NwModel);
	td[6] = addElem("td", "td11", NwMfgSn);
	td[7] = addElem("td", "td18", NwPurchYr);
    td[8] = addElem("td", "td11", NwLife);    
    td[9] = addElem("td", "td18", NwTrade);
    td[10] = addElem("td", "td18", NwAddDt);
    
    td[11] = addElem("td", "td18", "");
    var newlink = document.createElement("a");
	var func = "javascript: dltInvId('" + invid + "', '" + NwSn + "')";
	newlink.setAttribute("href", func);
	newlink.innerHTML = "D";
	td[11].appendChild(newlink);  
    
    
    for(var i=0; i < td.length; i++)
	{
    	row.appendChild(td[i]);
	}	
    
    clearEntryPanel();
}
//==============================================================================
//refresh table
//==============================================================================
function addElem(elem, cls, value)
{
	var td = document.createElement(elem);
    td.className = cls;
    td.appendChild (document.createTextNode(value));
    
    return td;
}
//==============================================================================
// clear entry Panel
//==============================================================================
function clearEntryPanel()
{
	Action = "";
	for(var i=0; i < document.all.Group.length; i++)
	{
		document.all.Group[i].checked = false;
	}
	
	for(var i=0; i < document.all.EquipTy.length; i++)
	{
		document.all.EquipTy[i].checked = false;
	}
	
	for(var i=0; i < document.all.RentTy.length; i++)
	{
		document.all.RentTy[i].checked = false;
	}
	
	document.all.SrlNum.value = "";
	document.all.SrlNum.readOnly = false;
	document.all.SrlNum.focus();	
	document.all.Brand.value = "";
	document.all.BrandNm.value = "";
	document.all.Model.value = "";
	document.all.MfgSn.value = "";
	document.all.Size.value = "";
	document.all.SizeNm.value = "";
	for(var i=0; i < document.all.Year.length; i++)
	{
		document.all.Year[i].checked = false;
	}
	for(var i=0; i < document.all.Life.length; i++)
	{
		document.all.Life[i].checked = false;
	}
	
	document.all.Trade[0].checked = false;
	document.all.Trade[1].checked = true;
	
	document.getElementById("tblVen01").style.display = "none";
	document.getElementById("tblVen02").style.display = "none";
	document.getElementById("tblVen03").style.display = "none";
	document.getElementById("tblVen04").style.display = "none";
	document.getElementById("tblVen05").style.display = "none";
	document.getElementById("tblVen06").style.display = "none";
	document.getElementById("tblVen07").style.display = "none";
	document.getElementById("tblVen08").style.display = "none";
	document.getElementById("tblVen09").style.display = "none";
	document.getElementById("tblVen10").style.display = "none";
	document.getElementById("tblVen11").style.display = "none";
	document.getElementById("tblVen12").style.display = "none";
	
	document.getElementById("tblSize01").style.display = "none";
	document.getElementById("tblSize02").style.display = "none";
	document.getElementById("tblSize03").style.display = "none";
	document.getElementById("tblSize04").style.display = "none";
	document.getElementById("tblSize05").style.display = "none";
	document.getElementById("tblSize06").style.display = "none";
	document.getElementById("tblSize07").style.display = "none";
	document.getElementById("tblSize08").style.display = "none";
	document.getElementById("tblSize09").style.display = "none";
	document.getElementById("tblSize10").style.display = "none";
	document.getElementById("tblSize11").style.display = "none";
	document.getElementById("tblSize12").style.display = "none";
	document.getElementById("tblSize13").style.display = "none";
	document.getElementById("tblSize14").style.display = "none";
	document.getElementById("tblSize15").style.display = "none";
	
	document.getElementById("spnEquip0").style.display = "none";
	document.getElementById("spnEquip1").style.display = "none";
	document.getElementById("spnEquip2").style.display = "none";
	document.getElementById("spnEquip3").style.display = "none";
	document.getElementById("spnEquip4").style.display = "none";
	document.getElementById("spnEquip5").style.display = "none";
	document.getElementById("spnEquip6").style.display = "none";
	document.getElementById("spnEquip7").style.display = "none";
	document.getElementById("spnEquip8").style.display = "none";	
	
	document.getElementById("tbody1").style.visibility = "hidden";
	
	document.getElementById("tdInvSts").innerHTML = "";
}
//==============================================================================
//refresh table
//==============================================================================
function dltInvId(id,sn)
{
	var msg = "Do you realy want to delete this serial number " + sn + "?";
	if(confirm(msg))
	{
		url="RentContractSave.jsp?InvId=" + id
		   + "&Action=DLT_SRL_NUM";
	    window.frame1.location.href=url;
	}
}
//==============================================================================
//reload
//==============================================================================
function refreshSrl()
{
	window.location.reload();
}

//==============================================================================
// update barcode id
//==============================================================================
function updInvId(srlnum)
{
	var sn = document.all.SrlNum;
	sn.value = srlnum;
	Action = "UpdInvBySrlNum";
	chkSrlNum(sn);
}
		
//==============================================================================
//check serial number
//==============================================================================
function chkSrlNum(obj)
{
	e = window.event; 
    var keyCode = null;
    if(Action == ""){ Action = SvAction; }
    
    
    if(e != null ){ keyCode = e.keyCode || e.which; }
    if ( Action == "UpdInvBySrlNum" || keyCode == '13' )
    {
    	ExInvId = "";
		ExStr = "";
		ExCls = "";
		ExSiz = "";
		ExSrlNum = "";
		ExPerchYr = "";
		ExBrand = "";
		ExModel = "";
		ExMfgSn = "";
		ExLife = "";
		ExTrade = "";
		ExClsNm = "";
		ExVenNm = "";
		ExSizNm = "";
		ExInvSts = "";
		ExReason = "";
		ExCont = "";
		ExContPD = "";
		ExContRD = "";
		ExContSts = "";
		ExTestDt = "";
		ExGrade = "";
		ExTech = "";
		ExAddDt = "";
		ExAddTm = "";
		ExAddTm = "";
		
    	var sts = document.getElementById("spnSts");
    	    	
    	if(obj.value.trim() == ""){ alert("Please enter S/N") }
    	else if(getScannedItem(obj.value))
    	{
    		InvSts = "UPDATE";
    		sts.innerHTML = "*** UPDATE ***";  
    		sts.style.color = "blue"; 
    		
    		// populate S/N Status and last contract
    		popStsTbl();
    		
    		popUpdInv();
    	}
    	else
    	{
    		InvSts = "NEW";
    		sts.innerHTML = "*** New ***";
    		sts.style.color = "green"; 
    		
    		// if this page called from RentInvList.jsp - Add New Serial#
    		if(Action == "CrtNewForStrCls")
    		{
    			setStrCls();
    		}

    	}
    	sts.style.fontSize = "24px";
    	
    	document.getElementById("tbody1").style.visibility = "visible";
    	obj.readOnly = true;
    	e.keyCode = 0;
    }
    window.event.cancelBubble = true;     
}

//=====================================================================================
// popilate Status table
//=====================================================================================
function popStsTbl()
{
	var invsts = document.getElementById("tdInvSts");
	var html = "<table class='tbl02'>"
 	  + "<tr class='trDtl06'>"
 	  + "<td class='td11'>Added</td>";
 	   	
    if(ExInvSts == "")
  	{ 
  	     html += "<td class='td11' style='background: #ccffcc;'><a href='javascript: chgItmAvail(&#34;" + ExInvId
           + "&#34;,&#34;RMV_INV_AVAIL&#34;, &#34;" + ExSrlNum +  "&#34;);'>Status</a></td>"
  	}
  	else 
  	{
  		 html += "<td class='td11' style='background: #ccffcc;'><a href='javascript: chgItmAvail(&#34;" + ExInvId
           + "&#34;,&#34;RTN_INV_AVAIL&#34;, &#34;" + ExSrlNum +  "&#34;);'>Status</a></td>"
  	}  
    
    html += "<td class='td11'>Reason</td>" 
    html += "<td class='td11'><a href='javascript: setTestStamp(&#34;" + ExInvId
    + "&#34;,&#34;TEST_STAMP&#34;, &#34;" + ExSrlNum +  "&#34;)'>Tech Test</a></td>"
    html += "<td class='td11'>Tech</td>"
    	html += "<td class='td11'>Grade</td>"   
    	
	html += "<td class='td11'><a href='javascript: dltInvId(&#34;" + ExInvId +  "&#34;, &#34;" + ExSrlNum +  "&#34;)'>Delete</a></td>";
	
	html += "</tr>";
	
	
	html +=	"<tr class='trDtl04'>"
		  + "<td class='td11'>" + ExAddDt + " " + ExAddTm + " " + ExAddUs + "</td>";
		  
	if(ExInvSts != "")
	{
		var reasonNm = "&nbsp;";
	 	if(ExReason.indexOf("DAMAGED") >= 0) { reasonNm = "Damaged";}
	 	if(ExReason.indexOf("NOT COUNTED") >= 0){ reasonNm = ExReason; }
	 	if(ExReason.indexOf("STOLEN") >= 0){ reasonNm = "Lost/Stolen";}
	    if(ExReason.indexOf("WARNOUT") >= 0){ reasonNm = "Warn Out";}
	    if(ExReason.indexOf("DUPLICATE S/N") >= 0){ reasonNm = "Duplicate S/N";}
	    
		html +=  "<td class='td11' style='color: red;'>" + ExInvSts + "</td>"
		 + "<td class='td11'>" + reasonNm + "</td>"; 	
	} 
	else
	{
		html += "<td class='td11' style='color: red;'>"
		if(ExCont != ""){ html += "Out On Contract"; } else { html += "Available"; }
		html += "</td><td class='td11'>&nbsp;</td>";
	} 
	
	
	
	html += "<td class='td11'>" + ExTestDt + "</td>"		
	html += "<td class='td11'>" + ExTech + "</td>"
	html += "<td class='td11'>" + ExGrade + "</td>"
	html += "<td class='td11'>&nbsp;</td>"
		  + "</tr>"   
	    ;
	

	if(ExCont != "")
	{
	  html +=	"<tr class='trDtl04'>"
		  + "<td class='td11'>&nbsp;</td>"
		  + "<td class='td11'><a href='RentContractInfo.jsp?ContId=" + ExCont + "' target='_blank'>" + ExCont + "</a>" + " " + ExContSts +"</td>"	
		  + "<td class='td11' colspan=2>Picked Up: " + ExContPD + "</td>"
		  + "<td class='td11' colspan=2>Return Date: " + ExContRD + "</td>"
		  + "<td class='td11'>&nbsp;</td>"
		  + "</tr>"   
		   ;
	}
		  
		  
	html += "</table>"
	
	invsts.innerHTML = html;
}	
//==============================================================================
//change item availability
//==============================================================================
function chgItmAvail(invId, action, srlNum )
{
var hdr = "Change Item Status &nbsp; Serial# " + srlNum;

var html = "<table class='tbl02'>"
  + "<tr>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
    + "</td></tr>"
html += "<tr><td class='Prompt' colspan=2>"

html += popItmAvail(invId, action)

html += "</td></tr></table>"

document.all.dvItem.innerHTML = html;
document.all.dvItem.style.width = 600;
document.all.dvItem.style.left= getLeftScreenPos() + 300;
document.all.dvItem.style.top= getTopScreenPos() + 120;
document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate Marked Item Panel
//==============================================================================
function popItmAvail(invId, action)
{
var panel = "<table class='tbl02'>";
panel += "<tr class='trDtl15'>"
          + "<td><textarea name='Commt' cols=70 rows=5></textarea></td>"
       + "</tr>"
if (action == "RMV_INV_AVAIL")
{
   panel += "<tr class='trDtl15'>"
         + "<td nowrap>Reason" 
         + " &nbsp; <input name='Reason' type='radio' value='DAMAGED' checked>Damaged"
         + " &nbsp; <input name='Reason' type='radio' value='STOLEN' >Lost/Stolen"
         + " &nbsp; <input name='Reason' type='radio' value='WARNOUT' >Worn out"
         + " &nbsp; <input name='Reason' type='radio' value='DUPLICATE S/N' >Duplicate S/N</td>"         
       + "</tr>"
}

       
panel += "<tr><td class='Prompt1' colspan=5>"
if (action == "RMV_INV_AVAIL")
 {
 	panel += "<button onClick='setItmUanavail(&#34;" + invId + "&#34;,&#34;" + action
 	            + "&#34;);' class='Small'>Unavailable</button> &nbsp; &nbsp;"
  }
     	   else
     	   {
     	      panel += "<button onClick='setItmUanavail(&#34;" + invId + "&#34;,&#34;" + action
     	            + "&#34;);' class='Small'>Make Available</button> &nbsp; &nbsp;"
     	   }

panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
     + "</td></tr>"

panel += "</table>";

return panel;
}
//==============================================================================
//set Item status
//==============================================================================
	function setItmUanavail(invId, action) 
	{
		var commt = document.all.Commt.value;
		commt = commt.replace(/\n\r?/g, '<br />');

		var reason = "";
		if (action == "RMV_INV_AVAIL") {
			for (var i = 0; i < document.all.Reason.length; i++) {
				if (document.all.Reason[i].checked) {
					reason = document.all.Reason[i].value;
					break;
				}
			}
		} else {
			reason = "AVAILABLE";
		}

		var nwelem = window.frame1.document.createElement("div");
		nwelem.id = "dvSbmItmAvail"

		var html = "<form name='frmItmAvail'"
    + " METHOD=Post ACTION='RentContractSave.jsp'>"
				+ "<input class='Small' name='InvId'>"
				+ "<input class='Small' name='Commt'>"
				+ "<input class='Small' name='Reason'>"
				+ "<input class='Small' name='Action'>" + "</form>"

		nwelem.innerHTML = html;
		window.frame1.document.appendChild(nwelem);
		window.frame1.document.all.InvId.value = invId;
		window.frame1.document.all.Commt.value = commt;
		window.frame1.document.all.Reason.value = reason;
		window.frame1.document.all.Action.value = action;

		//alert(html)
		window.frame1.document.frmItmAvail.submit();
		hidePanel("dvItem");
	}
	//=====================================================================================
	// refresh screen after statyus change
	//=====================================================================================
	function refreshScreen() 
	{
		var url = "RentInvAdd.jsp?SrlNum=<%=sSrchSn%>&Action=UpdInvBySrlNum";
		window.location.href = url;
}
//=====================================================================================
// if this page called from RentInvList.jsp - Add New Serial# withselected store color
//=====================================================================================
function setStrCls()
{
	var strobj = document.all.Str;
	for(var i=0; i < strobj.length  ;i++)
	{
		if(strobj[i].value == SrchStr ){ strobj[i].checked = true; break; }
	}
	
	var retyobj = document.all.RentTy;
	for(var i=0; i < retyobj.length  ;i++)
	{
		if(retyobj[i].value == SrchClsNm.substring(0,1)){ retyobj[i].checked=true; break; }
	}	
	
	// check groups - ski, snow board boots 
	var a = SrchClsNm.indexOf("SKIS");
	var b = SrchClsNm.indexOf("SKI BOOTS");	
	var c = SrchClsNm.indexOf("SNOWBOARDS");
	var d = SrchClsNm.indexOf("SB BOOTS");
	var e = SrchClsNm.indexOf("WATER");
	var f = SrchClsNm.indexOf("BIKES");
	
	var grpobj = document.all.Group;
	var selgrp = null;
	if(a > 0){ grpobj[0].checked=true; selgrp = grpobj[0]; }
	else if(b > 0){ grpobj[1].checked=true; selgrp = grpobj[1]; }
	else if(c > 0){ grpobj[2].checked=true; selgrp = grpobj[2]; }
	else if(d > 0){ grpobj[3].checked=true; selgrp = grpobj[3]; }
	else if(e > 0){ grpobj[4].checked=true; selgrp = grpobj[4]; }
	
	// equipment type: men, women, jr	
	var aa = (a > 0 || c > 0) && SrchClsNm.indexOf("ADULT") > 0;
	var bb = (b > 0 || d > 0) && SrchClsNm.indexOf(" MENS") > 0;
	var cc = (b > 0 || d > 0) && SrchClsNm.indexOf(" WOMENS") > 0;
	var dd = SrchClsNm.indexOf("JR") > 0;
	
	var eqtyobj = document.all.EquipTy;
	
	if(aa){ eqty = eqtyobj[0].checked=true; }
	else if(bb){ eqty = eqtyobj[0].checked=true; }
	else if(cc){ eqty = eqtyobj[1].checked=true; }
	else if(dd){ eqty = eqtyobj[2].checked=true; }
	
	// length/size
	document.all.Size.value = SrchSiz;
	document.all.SizeNm.value = SrchSizNm;
	
	setBrandList(false);
}
//==============================================================================
//populate updating inventory
//==============================================================================
function popUpdInv()
{
	var strobj = document.all.Str;
	for(var i=0; i < strobj.length  ;i++)
	{
		if(strobj[i].value == ExStr ){ strobj[i].checked = true; break; }
	}
	
	var retyobj = document.all.RentTy;
	for(var i=0; i < retyobj.length  ;i++)
	{
		if(retyobj[i].value == ExClsNm.substring(0,1)){ retyobj[i].checked=true; break; }
	}
	
	// check groups - ski, snow board boots 
	var a = 0;
	if (ExClsNm.indexOf("SKIS") >= 0 && ExClsNm.indexOf("PERFORMANCE") < 0){ a = 1; }
	var b = ExClsNm.indexOf("SKI BOOTS");	
	var c = ExClsNm.indexOf("SNOWBOARD");
	var d = ExClsNm.indexOf("SB BOOTS");
	
	var e = 0;
	if(ExCls == "6810" || ExCls == "6811" || ExCls == "6812" || ExCls == "6813"
		 || ExCls == "6815" || ExCls == "6820")
	{
		e = 6; 
	}
	var f = ExClsNm.indexOf("PERFORMANCE SKIS");
	
	
	var grpobj = document.all.Group;
	var selgrp = null;
	if(a > 0){ grpobj[0].checked=true; selgrp = grpobj[0]; }
	else if(f > 0){ grpobj[1].checked=true; selgrp = grpobj[1]; }
	else if(b > 0){ grpobj[2].checked=true; selgrp = grpobj[2]; }	
	else if(c > 0){ grpobj[3].checked=true; selgrp = grpobj[3]; }
	else if(d > 0){ grpobj[4].checked=true; selgrp = grpobj[4]; }
	else if(e > 0){ grpobj[6].checked=true; selgrp = grpobj[6]; }
	
	
	// equipment type: men, women, jr	
	var aa = (a > 0 || c > 0 || f > 0) && ExClsNm.indexOf("ADULT") > 0;
	var bb = (b > 0 || d > 0) && ExClsNm.indexOf(" MENS") > 0;
	var cc = (b > 0 || d > 0) && ExClsNm.indexOf(" WOMENS") > 0;
	var dd = ExClsNm.indexOf("JR") > 0;
	
	var ee = 0;	
	if(ExCls == "6810"){ ee = 1;}	
	else if(ExCls == "6811"){ ee = 2;}	
	else if(ExCls == "6812"){ ee = 3;}	
	else if(ExCls == "6813"){ ee = 4;}	
	else if(ExCls == "6815"){ ee = 5;}	
	else if(ExCls == "6820"){ ee = 6;}	
	
	var eqtyobj = document.all.EquipTy;
	
	if(aa){ eqty = eqtyobj[0].checked=true; }
	else if(bb){ eqty = eqtyobj[0].checked=true; }
	else if(cc){ eqty = eqtyobj[1].checked=true; }
	else if(dd){ eqty = eqtyobj[2].checked=true;  }	
	else if(ee == 1){ eqty = eqtyobj[3].checked=true;  }
	else if(ee == 2){ eqty = eqtyobj[4].checked=true;  }
	else if(ee == 3){ eqty = eqtyobj[5].checked=true;  }
	else if(ee == 4){ eqty = eqtyobj[6].checked=true;  }
	else if(ee == 5){ eqty = eqtyobj[7].checked=true;  }
	else if(ee == 6){ eqty = eqtyobj[8].checked=true;  }
	
	// brand
	document.all.Brand.value = ExBrand;
	document.all.BrandNm.value = ExVenNm;	
	// model	
	document.all.Model.value = ExModel;
	// manufacturer serial number	
	document.all.MfgSn.value = ExMfgSn;
	// length/size
	document.all.Size.value = ExSiz;
	document.all.SizeNm.value = ExSizNm;
	// Purchase Year
	var yearobj = document.all.Year;
	for(var i=0; i < yearobj.length  ;i++)
	{
		if(yearobj[i].value == ExPerchYr){ yearobj[i].checked = true; break; }
	}
	// remaining life
	var lifeobj = document.all.Life;
	for(var i=0; i < lifeobj.length  ;i++)
	{
		if(lifeobj[i].value == ExLife){ lifeobj[i].checked = true; break; }
	}
	
	// trade-in
	var tradeobj = document.all.Trade;
	if(ExTrade == "Y"){ tradeobj[0].checked = true;  tradeobj[1].checked = false; }
	else { tradeobj[0].checked = false;  tradeobj[1].checked = true; }
	
	
	if(e == 0) 
	{
		setBrandList(false);
	}	
	if(e > 0) 
	{ 
		setEquipTypes("BIKE"); 
		setBikeEquipList();
	}	
	
		
}
//==============================================================================
//set brand list visible for selected equipment group
//==============================================================================
function setBrandList(clear)
{
 	var grpobj = document.all.Group;   
 	var grp = "";
 	for(var i=0; i < grpobj.length; i++)
 	{
		if(grpobj[i].checked){ grp = grpobj[i].value; break; }
 	}
 
 	if(clear)
 	{
 		document.all.Brand.value = "";
		document.all.BrandNm.value = ""; 
		document.all.tdModelSel.innerHTML = "";
		document.all.Model.value = "";
		document.all.Size.value = "";
		document.all.SizeNm.value = "";
 	}
 
 	if(grp == "SKI")
 	{ 
	   document.getElementById("tblVen01").style.display = "block";
	   document.getElementById("tblVen02").style.display = "none";
	   document.getElementById("tblVen03").style.display = "none";
	   document.getElementById("tblVen04").style.display = "none";
	   document.getElementById("tblVen05").style.display = "none";
	   document.getElementById("tblVen06").style.display = "none";
	   document.getElementById("tblVen07").style.display = "none";
	   document.getElementById("tblVen08").style.display = "none";
	   document.getElementById("tblVen09").style.display = "none";
	   document.getElementById("tblVen10").style.display = "none";
	   document.getElementById("tblVen11").style.display = "none";
	   document.getElementById("tblVen12").style.display = "none";
 	}	
 	else if(grp == "SKIPERF")
 	{ 
	   document.getElementById("tblVen01").style.display = "none";
	   document.getElementById("tblVen02").style.display = "none";
	   document.getElementById("tblVen03").style.display = "none";
	   document.getElementById("tblVen04").style.display = "none";
	   document.getElementById("tblVen05").style.display = "none";
	   document.getElementById("tblVen06").style.display = "none";
	   document.getElementById("tblVen07").style.display = "none";
	   document.getElementById("tblVen08").style.display = "none";
	   document.getElementById("tblVen09").style.display = "none";
	   document.getElementById("tblVen10").style.display = "none";
       document.getElementById("tblVen11").style.display = "none";
	   document.getElementById("tblVen12").style.display = "block";
 	}
 	else if(grp == "SKIBOOT")
 	{ 
	   document.getElementById("tblVen01").style.display = "none";
	   document.getElementById("tblVen02").style.display = "block";
	   document.getElementById("tblVen03").style.display = "none";
	   document.getElementById("tblVen04").style.display = "none";
	   document.getElementById("tblVen05").style.display = "none";
	   document.getElementById("tblVen06").style.display = "none";
	   document.getElementById("tblVen07").style.display = "none";
	   document.getElementById("tblVen08").style.display = "none";
	   document.getElementById("tblVen09").style.display = "none";
	   document.getElementById("tblVen10").style.display = "none";
       document.getElementById("tblVen11").style.display = "none";
	   document.getElementById("tblVen12").style.display = "none";
 	}
 else if(grp == "SNOWBOARD")
 { 
	   document.getElementById("tblVen01").style.display = "none";
	   document.getElementById("tblVen02").style.display = "none";
	   document.getElementById("tblVen03").style.display = "block";
	   document.getElementById("tblVen04").style.display = "none";
	   document.getElementById("tblVen05").style.display = "none";
	   document.getElementById("tblVen06").style.display = "none";
	   document.getElementById("tblVen07").style.display = "none";
	   document.getElementById("tblVen08").style.display = "none";
	   document.getElementById("tblVen09").style.display = "none";
	   document.getElementById("tblVen10").style.display = "none";
	   document.getElementById("tblVen11").style.display = "none";
	   document.getElementById("tblVen12").style.display = "none";
 }
 else if(grp == "SBRBOOT")
 { 
	   document.getElementById("tblVen01").style.display = "none";
	   document.getElementById("tblVen02").style.display = "none";
	   document.getElementById("tblVen03").style.display = "none";
	   document.getElementById("tblVen04").style.display = "block";
	   document.getElementById("tblVen05").style.display = "none";	
	   document.getElementById("tblVen06").style.display = "none";
	   document.getElementById("tblVen07").style.display = "none";
	   document.getElementById("tblVen08").style.display = "none";
	   document.getElementById("tblVen09").style.display = "none";
	   document.getElementById("tblVen10").style.display = "none";
	   document.getElementById("tblVen11").style.display = "none";
	   document.getElementById("tblVen12").style.display = "none";
 }
 else if(grp == "WATER")
 { 
	   document.getElementById("tblVen01").style.display = "none";
	   document.getElementById("tblVen02").style.display = "none";
	   document.getElementById("tblVen03").style.display = "none";
	   document.getElementById("tblVen04").style.display = "none";
	   document.getElementById("tblVen05").style.display = "block";
	   document.getElementById("tblVen06").style.display = "none";
	   document.getElementById("tblVen07").style.display = "none";
	   document.getElementById("tblVen08").style.display = "none";
	   document.getElementById("tblVen09").style.display = "none";
	   document.getElementById("tblVen10").style.display = "none";
	   document.getElementById("tblVen11").style.display = "none";
	   document.getElementById("tblVen12").style.display = "none";
 }
 	
 	
 else if(grp.indexOf("BIKE") >= 0)
 { 
	   document.getElementById("tblVen01").style.display = "none";
	   document.getElementById("tblVen02").style.display = "none";
	   document.getElementById("tblVen03").style.display = "none";
	   document.getElementById("tblVen04").style.display = "none";
	   document.getElementById("tblVen05").style.display = "none";
	   document.getElementById("tblVen06").style.display = "none";
	   document.getElementById("tblVen07").style.display = "none";
	   document.getElementById("tblVen08").style.display = "none";
	   document.getElementById("tblVen09").style.display = "none";
	   document.getElementById("tblVen10").style.display = "none";
	   document.getElementById("tblVen11").style.display = "none";
	   document.getElementById("tblVen12").style.display = "none";
 }	
 
 setEquipTypes(grp);
 
 setGenList(clear);
}
//==============================================================================
//set equipment types by selected groups 
//==============================================================================
function setEquipTypes(grp)
{	
	if(grp.indexOf("BIKE") < 0)
	{
		document.getElementById("spnEquip0").style.display = "inline";
		document.getElementById("spnEquip1").style.display = "inline";
		document.getElementById("spnEquip2").style.display = "inline";
		
		document.getElementById("spnEquip3").style.display = "none";
		document.getElementById("spnEquip4").style.display = "none";
		document.getElementById("spnEquip5").style.display = "none";
		document.getElementById("spnEquip6").style.display = "none";
		document.getElementById("spnEquip7").style.display = "none";
		document.getElementById("spnEquip8").style.display = "none";
	}
	else
	{
		document.getElementById("spnEquip0").style.display = "none";
		document.getElementById("spnEquip1").style.display = "none";
		document.getElementById("spnEquip2").style.display = "none";
		
		document.getElementById("spnEquip3").style.display = "inline";
		document.getElementById("spnEquip4").style.display = "inline";
		document.getElementById("spnEquip5").style.display = "inline";
		document.getElementById("spnEquip6").style.display = "inline";
		document.getElementById("spnEquip7").style.display = "inline";
		document.getElementById("spnEquip8").style.display = "inline";
	}
	
	
}
//==============================================================================
//set bike group list
//==============================================================================
function setBikeEquipList()
{
	var rentty = document.getElementsByName("RentTy");
	rentty[0].checked = true;
	
	var eqty = "";
	for(var i=00; i < document.all.EquipTy.length; i++)
	{
		if(document.all.EquipTy[i].checked){ eqty = document.all.EquipTy[i].value; break;}
	}
	
	document.getElementById("tblVen01").style.display = "none";
	document.getElementById("tblVen02").style.display = "none";
	document.getElementById("tblVen03").style.display = "none";
	document.getElementById("tblVen04").style.display = "none";
	document.getElementById("tblVen05").style.display = "none";
	document.getElementById("tblVen06").style.display = "none";
	document.getElementById("tblVen07").style.display = "none";
	document.getElementById("tblVen08").style.display = "none";
	document.getElementById("tblVen09").style.display = "none";
	document.getElementById("tblVen10").style.display = "none";
	document.getElementById("tblVen11").style.display = "none";
	document.getElementById("tblVen12").style.display = "none";
	
	document.getElementById("tblSize01").style.display = "none";
	document.getElementById("tblSize02").style.display = "none";
	document.getElementById("tblSize03").style.display = "none";
	document.getElementById("tblSize04").style.display = "none";
	document.getElementById("tblSize05").style.display = "none";
	document.getElementById("tblSize06").style.display = "none";
	document.getElementById("tblSize07").style.display = "none";
	document.getElementById("tblSize08").style.display = "none";
	document.getElementById("tblSize09").style.display = "none";
	document.getElementById("tblSize10").style.display = "none";
	document.getElementById("tblSize11").style.display = "none";
	document.getElementById("tblSize12").style.display = "none";
	document.getElementById("tblSize13").style.display = "none";
	document.getElementById("tblSize14").style.display = "none";
	document.getElementById("tblSize15").style.display = "none";
	
	var tblven = "tblVen";
	
	if(eqty == "BIKESM"){ tblven += "06"; }
	else if(eqty == "BIKEHB"){ tblven += "07"; }
	else if(eqty == "BIKEFS"){ tblven += "08"; }
	else if(eqty == "BIKEEL"){ tblven += "09"; }
	else if(eqty == "BIKEYM"){ tblven += "10"; }
	else if(eqty == "BIKEKD"){ tblven += "11"; }
	
	document.getElementById(tblven).style.display = "block";
	
	setModelSelTable(false);
	
	if(eqty == "BIKESM"){ document.getElementById("tblSize09").style.display = "block"; }
	if(eqty == "BIKEHB"){ document.getElementById("tblSize10").style.display = "block"; }
	if(eqty == "BIKEFS"){ document.getElementById("tblSize11").style.display = "block"; }
	if(eqty == "BIKEEL"){ document.getElementById("tblSize12").style.display = "block"; }
	if(eqty == "BIKEYM"){ document.getElementById("tblSize13").style.display = "block"; }
	if(eqty == "BIKEKD"){ document.getElementById("tblSize14").style.display = "block"; }
	
	   
}
//==============================================================================
//set Model and Size group
//==============================================================================
function setGenList(clear)
{
	var grp = "";
	for(var i=00; i < document.all.Group.length; i++)
	{
		if(document.all.Group[i].checked){ grp = document.all.Group[i].value; break;}
	}
	
	var eqty = "";
	for(var i=00; i < document.all.EquipTy.length; i++)
	{
		if(document.all.EquipTy[i].checked){ eqty = document.all.EquipTy[i].value; break;}
	}
	
	if(eqty == "Male" || eqty == "Female"){ eqty = "ADULT"; }
	else if(eqty == "Jr"){ eqty = "JR"; }
	
	document.getElementById("tblSize01").style.display = "none";
	document.getElementById("tblSize02").style.display = "none";
	document.getElementById("tblSize03").style.display = "none";
	document.getElementById("tblSize04").style.display = "none";
	document.getElementById("tblSize05").style.display = "none";
	document.getElementById("tblSize06").style.display = "none";
	document.getElementById("tblSize07").style.display = "none";
	document.getElementById("tblSize08").style.display = "none";
	document.getElementById("tblSize09").style.display = "none";
	document.getElementById("tblSize10").style.display = "none";
	document.getElementById("tblSize11").style.display = "none";
	document.getElementById("tblSize12").style.display = "none";
	document.getElementById("tblSize13").style.display = "none";
	document.getElementById("tblSize14").style.display = "none";
	document.getElementById("tblSize15").style.display = "none";
		
	if(grp == "SKI" && eqty == "ADULT"){ document.getElementById("tblSize01").style.display = "block"; }
	if(grp == "SKI" && eqty == "JR"){ document.getElementById("tblSize02").style.display = "block"; }
	if(grp == "SKIPERF" && eqty == "ADULT"){ document.getElementById("tblSize15").style.display = "block"; }	
	if(grp == "SKIBOOT" && eqty == "ADULT"){ document.getElementById("tblSize03").style.display = "block"; }
	if(grp == "SKIBOOT" && eqty == "JR"){ document.getElementById("tblSize04").style.display = "block"; }
	if(grp == "SNOWBOARD" && eqty == "ADULT"){ document.getElementById("tblSize05").style.display = "block"; }
	if(grp == "SNOWBOARD" && eqty == "JR"){ document.getElementById("tblSize06").style.display = "block"; }
	if(grp == "SBRBOOT" && eqty == "ADULT"){ document.getElementById("tblSize07").style.display = "block"; }
	if(grp == "SBRBOOT" && eqty == "JR"){ document.getElementById("tblSize08").style.display = "block"; }
	
	setModelSelTable(clear);
}
//==============================================================================
//set test stamp
//==============================================================================
function setTestStamp(invId, action, srlNum)
{
	var hdr = "Set Test Stamp &nbsp; Serial# " + srlNum;

	   var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popTestStamp(invId, action)

	   html += "</td></tr></table>"

	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "200"; }
	   else { document.all.dvItem.style.width = "auto"; }
	   
	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.left= getLeftScreenPos() + 300;
	   document.all.dvItem.style.top= getTopScreenPos() + 120;
	   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate Marked Item Panel
//==============================================================================
function popTestStamp(invId, action)
{
var panel = "<table  border=1 width='100%' cellPadding='0' cellSpacing='0' >";
panel += "<tr class='trDtl15'>"
     + "<td>Grade:</td>"
     + "<td nowrap>" 
       	+ " <input type='radio' name='Grade' value='PASSED'>Passed &nbsp; " 
       	+ " <input type='radio' name='Grade' value='FAILED'>Failed"
     + "</td>"
  + "</tr>"
  + "<tr class='trDtl15'>"
  	+ "<td nowrap>Tech:</td>"
  	+ "<td nowrap><input name='Tech' maxlength='4' size='6'></td>"
	+ "</tr>"

	panel += "<tr class='trDtl15'>" 
	 + "<td align=center colspan=2><button onClick='vldItmTest(&#34;" + invId + "&#34;,&#34;" + action
		+ "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
	panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
     + "</td></tr>"
	panel += "</table>";
	return panel;
}
//==============================================================================
//validate item test stamp
//==============================================================================
function vldItmTest(invId, action)
{
	var error = false;
	var msg = "";
	
	var grade = null;
	for(var i=0; i < document.all.Grade.length; i++)
	{
		if(document.all.Grade[i].checked){ grade = document.all.Grade[i].value; break; }
	}
	if(grade == null){ error=true; msg += "\nPlease check grade."; }
	
	var tech = document.all.Tech.value.trim();
	if(tech==""){error = true; msg += "\nPlease enter your employee number"; }
	else if(isNaN(tech)){error = true; msg += "\n>The employee number is not numeric"; }
	else if (!isEmpNumValid(tech)){error = true; msg += "\nEmployee number is invalid."; }	
 
	
	if(error) { alert(msg) }
	else { sbmItmTest(invId, grade, tech, action) }
}
//==============================================================================
//submit Item Test Grade 
//==============================================================================
function sbmItmTest(invId, grade, tech, action)
{
	url = "RentContractSave.jsp?InvId=" + invId
	 + "&Grade=" + grade
	 + "&Tech=" + tech
	 + "&Action=" + action
	 + "&User=<%=sUser%>"
	;
	if(isIE || isSafari){ window.frame1.location.href = url; }
	else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(sn)
{
	var valid = true;
	var url = "RentChkSrlNum.jsp?Sn=" + sn;

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
			
			valid = getXmlValue("SN_Valid", resp) == "true";
			if(valid)
			{
				ExInvId = getXmlValue("InvId", resp);
				ExStr = getXmlValue("Str", resp);
				ExCls = getXmlValue("Cls", resp);
				ExSiz = getXmlValue("Siz", resp);
				ExSrlNum = getXmlValue("SrlNum", resp);
				ExPerchYr = getXmlValue("PerchYr", resp);
				ExBrand = getXmlValue("Brand", resp);
				ExModel = getXmlValue("Model", resp);
				ExMfgSn = getXmlValue("MfgSn", resp);
				ExLife = getXmlValue("Life", resp);
				ExTrade = getXmlValue("Trade", resp);
				ExClsNm = getXmlValue("ClsNm", resp);
				ExVenNm = getXmlValue("VenNm", resp);
				ExSizNm = getXmlValue("SizNm", resp);
				ExInvSts = getXmlValue("InvSts", resp);
				ExReason = getXmlValue("Reason", resp);
				ExCont = getXmlValue("Cont", resp);
				ExContPD = getXmlValue("ContPD", resp);
				ExContRD = getXmlValue("ContRD", resp);
				ExContSts = getXmlValue("ContSts", resp);
				ExTestDt = getXmlValue("TestDt", resp);
				ExGrade = getXmlValue("Grade", resp);
				ExTech = getXmlValue("Tech", resp);
				ExAddDt = getXmlValue("AddDt", resp);
				ExAddTm = getXmlValue("AddTm", resp);
				ExAddUs = getXmlValue("AddUs", resp);
			}
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
}
//==============================================================================
// get XML value 
//==============================================================================
function getXmlValue(tag, resp)
{
	var opntag = "<" + tag + ">";
	var beg = resp.indexOf(opntag) + opntag.length;
	var clstag = "</" + tag + ">";
	var end = resp.indexOf(clstag);
	xmlval = resp.substring(beg, end);
	return xmlval;
}


</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvChkItm" class="dvItem"></div>
<div id="dvCont" class="dvItem"></div>
<div id="dvItem" class="dvItem"></div>
<div id="dvComment" class="dvItem"></div>

<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp">
<a  class="helpLink" href="Intranet Reference Documents/5.0%20Equipment%20Entry.pdf" title="Click here for help" target="_blank">&nbsp;</a>
</div>
 
<!-------------------------------------------------------------------->

    <table class="tbl01">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Rental Inventory Entry
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       This Page. &nbsp; &nbsp;
       
       <%if(bAllowAttr){%><a href="RentInvAttr.jsp" target="_blank">New Attributes</a><%} %>
            
   <!----------------------- Order List ------------------------------>
     <table class="tbl02" id="tbEntry" width = "1000">
       <!-- ========= S/N Barcode ID -->
       <tr class="trHdr01" height="25">
          <th align=right>SS Barcode ID &nbsp; &nbsp; &nbsp;
                <br>
                or &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          		<br>MFG Barcode S/N: &nbsp; &nbsp; &nbsp;
          </th>
          <td colspan=2 align=left><input name="SrlNum" style="font-size:18px; font-weight: bold;" size=17 maxlength=15 onkeypress="chkSrlNum(this)">
          &nbsp; <span id="spnSts"></span>
          </td>
       </tr>
       <tr class="trHdr01" height="25">
        <td   style="align-content: right; ">&nbsp;</td>
        <td colspan=2 id="tdInvSts" style="align-content: right; "></td>
       </td> 
       
       
       <tbody id="tbody1">
       
       <!-- ======== Store ============ -->
       <tr class="trHdr01" height="20">
          <th align=right width="180">Str:&nbsp;</th>
          <td colspan=2 align=left>
              <input name="Str" type="radio" value="15" <%if(sStrAllowed.equals("15")){%>checked<%}%>>15 &nbsp;
              <input name="Str" type="radio" value="16" <%if(sStrAllowed.equals("16")){%>checked<%}%>>16 &nbsp;
              <input name="Str" type="radio" value="17" <%if(sStrAllowed.equals("17")){%>checked<%}%>>17 &nbsp;              
              <input name="Str" type="radio" value="28" <%if(sStrAllowed.equals("28")){%>checked<%}%>>28 &nbsp;
              <input name="Str" type="radio" value="35" <%if(sStrAllowed.equals("35")){%>checked<%}%>>35 &nbsp;
              <input name="Str" type="radio" value="50" <%if(sStrAllowed.equals("50")){%>checked<%}%>>50 &nbsp;
              <input name="Str" type="radio" value="64" <%if(sStrAllowed.equals("64")){%>checked<%}%>>64 &nbsp;
              <input name="Str" type="radio" value="66" <%if(sStrAllowed.equals("66")){%>checked<%}%>>66 &nbsp;
              <input name="Str" type="radio" value="68" <%if(sStrAllowed.equals("68")){%>checked<%}%>>68 &nbsp;
            <br>
              <input name="Str" type="radio" value="77" <%if(sStrAllowed.equals("77")){%>checked<%}%>>77 &nbsp;
              <input name="Str" type="radio" value="86" <%if(sStrAllowed.equals("86")){%>checked<%}%>>86 &nbsp;
              <input name="Str" type="radio" value="87" <%if(sStrAllowed.equals("87")){%>checked<%}%>>87 &nbsp;
              <input name="Str" type="radio" value="88" <%if(sStrAllowed.equals("88")){%>checked<%}%>>88 &nbsp;
             
          </td>
       </tr>
          
        <!-- =============== Trade-In =================== -->
       <tr class="trHdr01">
          <th align=right>Trade-In:&nbsp;</th>
          <td colspan=2 align=left>
             <input type="radio" name="Trade" value="Y">Yes  &nbsp;
             <input type="radio" name="Trade" value=" " checked>No
          </td>          
       </tr>
       
       <!-- =========== Rent type daily/lease =========== -->
       <tr class="trHdr01" height="20">
          <th align=right>Rent Type:&nbsp;</th>
          <td colspan=2 align=left>
              <input name="RentTy" type="radio" value="D">Daily &nbsp;
              <input name="RentTy" type="radio" value="L">Lease &nbsp;              
       	  </td>
       </tr>
       
              
       <tr class="trHdr01" height="20">
          <th align=right>Group:&nbsp;</th>
          <td colspan=2 align=left>
              <input name="Group" type="radio" value="SKI" onclick="setBrandList(true);">Std Ski &nbsp;
              <input name="Group" type="radio" value="SKIPERF" onclick="setBrandList(true);">Perf Ski &nbsp;
              <input name="Group" type="radio" value="SKIBOOT" onclick="setBrandList(true);">Ski Boots &nbsp;              
              <input name="Group" type="radio" value="SNOWBOARD" onclick="setBrandList(true);">Snowboard &nbsp;
              <input name="Group" type="radio" value="SBRBOOT" onclick="setBrandList(true);">Snowboard Boots &nbsp;
              <input name="Group" type="radio" value="WATER" onclick="setBrandList(true);">Water &nbsp;
              <input name="Group" type="radio" value="BIKE" onclick="setBrandList(true);">Bikes &nbsp;              
          </td>
       </tr>
       
       <tr class="trHdr01" height="20" id="trEqTy">
          <th align=right nowrap>Equipment Type:&nbsp;</th>
          <td colspan=2 align=left>
              <span id="spnEquip0"><input name="EquipTy" type="radio" value="Male" onclick="setGenList();">Male &nbsp;</span>
              <span id="spnEquip1"><input name="EquipTy" type="radio" value="Female" onclick="setGenList();">Female &nbsp;</span>
              <span id="spnEquip2"><input name="EquipTy" type="radio" value="Jr" onclick="setGenList();">Junior &nbsp;</span>
              
              <span id="spnEquip3"><input name="EquipTy" type="radio" value="BIKESM" onclick="setBikeEquipList();">Standard Mountain Bikes&nbsp;</span>
              <span id="spnEquip4"><input name="EquipTy" type="radio" value="BIKEHB" onclick="setBikeEquipList();">Hybrid Mountain Bikes&nbsp;</span>
              <span id="spnEquip5"><input name="EquipTy" type="radio" value="BIKEFS" onclick="setBikeEquipList();">Full Suspense Mountain Bikes&nbsp;<br>
              <span id="spnEquip6"><input name="EquipTy" type="radio" value="BIKEEL" onclick="setBikeEquipList();">E-Bikes&nbsp;</span>
              <span id="spnEquip7"><input name="EquipTy" type="radio" value="BIKEYM" onclick="setBikeEquipList();">Youth Standard Mountain Bikes&nbsp;</span>
              <span id="spnEquip8"><input name="EquipTy" type="radio" value="BIKEKD" onclick="setBikeEquipList();">Kid's Trailer&nbsp;</span>                           
          </td>
       </tr>
       
       
       
       <tr class="trHdr02" style="vertical-align: top;" height="100">
          <th style="vertical-align: top;"  align=right>Brand:&nbsp;</th>
          <td style="vertical-align: top;" align=left>
          	<input name="Brand" size=5 maxlength=5 readOnly>
          	<input name="BrandNm" size=35 maxlength=25 readOnly>
          	<br><span style="font-size:10px;">(Select Group to get a list of brands)</span>
          </td>	
          <td style="vertical-align: top;" align=left nowrap>&nbsp;
            <table id="tblVen01">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("SKI")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen02">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("SKIBOOT")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen03">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("SNOWBOARD")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen04">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("SBRBOOT")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen05">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("WATER")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen06">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("BIKESM")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen07">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("BIKEHB")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen08">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("BIKEFS")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen09">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("BIKEEL")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen10">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("BIKEYM")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen11">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("BIKEKD")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblVen12">
              <tr>
          	<%for(int i=0, j=0; i < vVen.size(); i++){%>
          	    <%if(vVenTy.get(i).equals("SKIPERF")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setBrand('<%=vVen.get(i)%>', '<%=vVenNm.get(i)%>')"><%=vVenNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	
          </td>
       </tr>
       <!-- ============= Model ======================= -->
       <tr class="trHdr03">
          <th style="vertical-align: top" align=right>Model:&nbsp;</th>
          <td align=left style="vertical-align: top">
              <input name="Model" size=35 maxlength=30 readOnly>
              <br><span style="font-size:10px;">(Select Group to get a list of models)</span>
          </td>
          <td align=left style="vertical-align: top" id="tdModelSel"></td>  
       </tr>
       
       <tr class="trHdr01">
          <th align=right> Alternate Vendor Mfg S/N:&nbsp;</th>
          <td colspan=2 align=left><input name="MfgSn" size=31 maxlength=30></td>
       </tr>
       
       <!-- ============= Size Ranges ======================= -->
       <tr class="trHdr02" style="vertical-align: top">
          <th align=right>Length/Size:&nbsp;</th>
          <td align=left><input name="Size" size=8 maxlength=5 readOnly>&nbsp;<input name="SizeNm" size=25 maxlength=25 readOnly> 
               <br><span style="font-size:10px;">(Select Group and Equipment type to get a list of length/sizes)</span>
          </td>
          <td align=left>
          	<table id="tblSize01">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SKI") && vSizGen.get(i).equals("ADULT")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a> &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize02">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SKI") && vSizGen.get(i).equals("JR")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize03">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SKIBOOT") && vSizGen.get(i).equals("ADULT")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize04">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SKIBOOT") && vSizGen.get(i).equals("JR")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize05">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SNOWBOARD") && vSizGen.get(i).equals("ADULT")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize06">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SNOWBOARD") && vSizGen.get(i).equals("JR")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize07">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SBRBOOT") && vSizGen.get(i).equals("ADULT")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize08">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SBRBOOT") && vSizGen.get(i).equals("JR")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize09">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("BIKESM")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize10">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("BIKEHB")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize11">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("BIKEFS")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize12">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("BIKEEL")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize13">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("BIKEYM")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize14">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("BIKEKD")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          	<table id="tblSize15">
              <tr>
          	   <%for(int i=0, j=0; i < vSiz.size(); i++){%>
          	    <%if(vSizTy.get(i).equals("SKIPERF")){%>          	    
          	    <%if(j > 0 && j % 3 == 0){%></tr><tr><%}%>   
          	    	<td>
          	       		<a href="javascript: setSize('<%=vSiz.get(i)%>','<%=vSizNm.get(i)%>')"><%=vSizNm.get(i)%></a>  &nbsp;
          	    	</td>
          	      <%j++;%>        	    
          	    <%}%>
          	   <%}%>  
          	  </tr>    
          	</table>
          	
          </td>          
       </tr>
       
       <!-- =============== Remaining Life (years) =================== -->
       <tr class="trHdr01">
          <th align=right>Remaining Life (years):&nbsp;</th>
          <td colspan=2 align=left>
             <%for(int i=0; i < 7; i++){%>
             	<input type="radio" name="Life" value="<%=7-i%>"><%=7-i%> &nbsp;  
             <%}%>
          </td>          
       </tr>
       
       
       <!-- =============== Purchase Year =================== -->
       <tr class="trHdr01">
          <th align=right>Purchase Year:&nbsp;</th>
          <td colspan=2 align=left>
             <%for(int i=0; i < 5; i++){%>
             	<input type="radio" name="Year" value="<%=iYear - i%>"><%=iYear - i%>  &nbsp;
             <%}%>
          </td>          
       </tr>
       
       <!-- =============== Added to Fleet Date =================== -->
       <tr style="display:none;">
          <!-- th align=right>Added to Fleet Date:&nbsp;</th>
          <td colspan=2 align=left>
          <button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;AddDt&#34;)'>&#60;</button>
          <input class='Small' name='AddDt' type='text' value="" size=10 maxlength=10>&nbsp;
          <button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;AddDt&#34;)'>&#62;</button>
          &nbsp;&nbsp;
          <a href='javascript: showCalendar(1, null, null, 500, 500, document.all.AddDt)' >
          <img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>
          
          </td -->
          <td><input type="hidden" class='Small' name='AddDt' type='text' value="<%=sCurDate%>" size=10 maxlength=10>&nbsp;</td>          
       </tr>
       
       <tr class="trHdr01">
          <th align=center colspan=3>
          	<button class="Small" onclick="vldSrlNum();">Submit</button> &nbsp;
          	<button class="Small" onclick="clearEntryPanel();">Reset</button>
          </th>        
       </tr>
       
       <!-- ======== errors ======== -->
       <tr class="trHdr01">
          <td class="tdError" colspan=3 id="tdError"></td>          
       </tr>
       
       </tbody>
     </table>   
      <br><br>
  <!----------------------- Order List ------------------------------>
     <table  class="tbl04" id="tbDetail">
      <thead id="thead1">
       <tr class="trHdr01">
          <th class="th13">Str</th>
          <th class="th13">Class</th>
          <th class="th13">Length/Size</th> 
          <th class="th13">SS<br>Barcode<br>Id</th>
          <th class="th13">Brand</th>
          <th class="th13">Model</th>
          <th class="th13">Manufacturer<br>S/N</th>
          <th class="th13">Purchase<br>Year</th>
          <th class="th13">Remaining<br>Life<br>(years)</th>
          <th class="th13">Trade-In</th>
          <th class="th13">Added<br>Date</th>  
          <th class="th13">Dlt</th>                     
       </tr>
     </thead> 
     <tbody id="tbody2">
  <!-------------------------- Order List ------------------------------->
      <%for(int i=0; i < vNwInvD.size(); i++){%>
        <tr class="trDtl06">
	    	<td class="td11"><%=vNwStr.get(i)%></td>
			<td class="td11"><%=vNwClsNm.get(i)%></td>
			<td class="td11"><%=vNwSizNm.get(i)%></td>
			<td class="td11"><a href="javascript: updInvId('<%=vNwSn.get(i)%>')"><%=vNwSn.get(i)%></a></td>			
			<td class="td11"><%=vNwVenNm.get(i)%></td>
			<td class="td11"><%=vNwModel.get(i)%></td>
			<td class="td11"><%=vNwMfgSn.get(i)%></td>			
			<td class="td18"><%=vNwPerchYr.get(i)%></td>
			<td class="td11"><%=vNwLife.get(i)%></td>
			<td class="td18"><%=vNwTrade.get(i)%></td>
			<td class="td11"><%=vNwAddDt.get(i)%></td>
			<td class="td18"><a href="javascript: dltInvId('<%=vNwInvD.get(i)%>', '<%=vNwSn.get(i)%>')">D</a></td>
		</tr>	   
      <%}%> 
      </tbody>
    </table>
    
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>


<%  
  }%>