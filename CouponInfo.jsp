<%@ page import="rciutility.RunSQLStmt, discountcard.CouponInfo, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSelCode = request.getParameter("Code");

   if(sSelCode == null){ sSelCode = "0000"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=CouponInfo.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
      String sUser = session.getAttribute("USER").toString();
      CouponInfo cpninf = null;

      String sCode = "";
      String sName = "";
      String sOrg = "";
      String sOrgt = "";
      String sMed = "";   
      String sCost = "";
      String sDati = "";
      String sCby = "";
      String sRef = "";
      String sCon = "";
      String sTit = "";
      String sCbus = "";
      String sChm = "";
      String sCfax = "";
      String sRmb = "";
      String sDuei = "";
      String sPmt1 = "";
      String sPmt2 = "";
      String sPmt3 = "";
      String sPmt4 = "";
      String sGrp = "";
      String sAdd1 = "";
      String sAdd2 = "";
      String sCty = "";
      String sSta = "";
      String sZip = "";
      String sPhn = "";
      String sFax = "";
      String sTrpi = "";
      String sReso = "";
      String sStri = "";
      String sEndi = "";
      String sGrpn = "";
      String sMar = "";
      String sSchs = "";
      String sEdti = "";
      String sEtmi = "";
      String sCom = "";
      String sCom1 = "";
      String sCom2 = "";
      String sDsc = "";
      String sCpsi = "";
      String sCpei = "";
      String sCtxt = "";
      String sHost = "";
      String sAnsw01 = "";
      String sAnsw02 = "";
      String sAnsw03 = "";
      String sAnsw04 = "";
      String sAnsw05 = "";
      String sAnsw06 = "";
      String sAnsw07 = "";
      String sAnsw08 = "";
      String sAnsw09 = "";
      String sAnsw10 = "";
      String sFedEx = "";

      if(!sSelCode.equals("0000"))
      {
         cpninf = new CouponInfo(sSelCode, sUser);
         cpninf.getCoupon();
         sCode = cpninf.getCode();
         sName = cpninf.getName();
         sOrg = cpninf.getOrg();
         sOrgt = cpninf.getOrgt();
         sMed = cpninf.getMed();
         sCost = cpninf.getCost();
         sDati = cpninf.getDati();
         sCby = cpninf.getCby();
         sRef = cpninf.getRef();
         sCon = cpninf.getCon();
         sTit = cpninf.getTit();
         sCbus = cpninf.getCbus();
         sChm = cpninf.getChm();
         sCfax = cpninf.getCfax();
         sRmb = cpninf.getRmb();
         sDuei = cpninf.getDuei();
         sPmt1 = cpninf.getPmt1();
         sPmt2 = cpninf.getPmt2();
         sPmt3 = cpninf.getPmt3();
         sPmt4 = cpninf.getPmt4();
         sGrp = cpninf.getGrp();
         sAdd1 = cpninf.getAdd1();
         sAdd2 = cpninf.getAdd2();
         sCty = cpninf.getCty();
         sSta = cpninf.getSta();
         sZip = cpninf.getZip();
         sPhn = cpninf.getPhn();
         sFax = cpninf.getFax();
         sTrpi = cpninf.getTrpi();
         sReso = cpninf.getReso();
         sStri = cpninf.getStri();
         sEndi = cpninf.getEndi();
         sGrpn = cpninf.getGrpn();
         sMar = cpninf.getMar();
         sSchs = cpninf.getSchs();
         sEdti = cpninf.getEdti();
         sEtmi = cpninf.getEtmi();
         sCom = cpninf.getCom();
         sCom1 = cpninf.getCom1();
         sCom2 = cpninf.getCom2();
         sDsc = cpninf.getDsc();
         sCpsi = cpninf.getCpsi();
         sCpei = cpninf.getCpei();
         sCtxt = cpninf.getCtxt();
         sHost = cpninf.getHost();
         sAnsw01 = cpninf.getAnsw01();
         sAnsw02 = cpninf.getAnsw02();
         sAnsw03 = cpninf.getAnsw03();
         sAnsw04 = cpninf.getAnsw04();
         sAnsw05 = cpninf.getAnsw05();
         sAnsw06 = cpninf.getAnsw06();
         sAnsw07 = cpninf.getAnsw07();
         sAnsw08 = cpninf.getAnsw08();
         sAnsw09 = cpninf.getAnsw09();
         sAnsw10 = cpninf.getAnsw10();
         sFedEx = cpninf.getFedEx();
      }

      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      String sToday = sdf.format(cal.getTime());
      sdf = new SimpleDateFormat("h:mm a");
      String sCurTime = sdf.format(cal.getTime());
      
      
      StoreSelect strlst = null;
      strlst = new StoreSelect(20);

      int iNumOfStr = strlst.getNumOfStr();
      String [] sStr = strlst.getStrLst(); 
      String sStrJsa = strlst.getStrNum();
      
      String [] sStrRegLst = strlst.getStrRegLst();
      String sStrRegJsa = strlst.getStrReg();
      

%>

<html>
<head>
<title>Coupon_Info</title>

<style>
body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        table.DataTable2 { background: #aaccaa; text-align: left; font-size:12px}
        
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-left: black solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable3 { background:white;padding-top:3px; padding-bottom:3px;
                        text-align:left; ; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable4 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px; vertical-align:top; }
        tr.DataTable41 { background:#ccccff; color: darkred; font-family:Arial; font-size:12px; vertical-align:top; }
        tr.DataTable5 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable6 { background: lightpink; font-family:Arial; font-size:10px }
        tr.DataTable7 { background: #cccfff; font-family:Arial; font-size:10px }
        tr.DataTable8 { background: #ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}

        td.DataTable3 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable31 { border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }
        input.Small1 { font-family:Arial; font-size:10px }
        input.Small2 {background: white; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.Small3 {border:none; font-family:Arial;  font-size:10px }
        input.Small4 {background:#e7e7e7; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.radio { font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvChkItm  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var UserId = "<%=sUser%>";
var Code = "<%=sSelCode%>";

var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStr = [<%=sStrJsa%>]; 
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{  
		   isSafari = true;
	}
    setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvStatus"]);
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getYear()
}
//==============================================================================
// change/add coupon
//==============================================================================
function chgCoupon(code, action)
{
   var msg ="";
   var error = false;

   var code = document.all.Code.value;
   var name = document.all.Name.value;
   var org = document.all.Org.value;
   var orgt = document.all.Orgt.value;
   var med = null;

   for(var i=0; i < document.all.Med.length; i++)
   {
      if(document.all.Med[i].checked ){ med = document.all.Med[i].value; break}
   }

   var ref = document.all.Ref.value;
   var con = document.all.Con.value;
   var tit = document.all.Tit.value;
   var cbus = document.all.Cbus.value;
   var rmb = document.all.Rmb.value;
   var duei = document.all.Duei.value;
   var pmt1 = document.all.Pmt1.value;
   var pmt2 = document.all.Pmt2.value;
   var pmt3 = document.all.Pmt3.value;
   var pmt4 = document.all.Pmt4.value;
   var grp = document.all.Grp.value;
   var add1 = document.all.Add1.value;
   var add2 = document.all.Add2.value;
   var cty = document.all.Cty.value;
   var sta = document.all.Sta.value;
   var zip = document.all.Zip.value;
   var phn = document.all.Phn.value;
   var fax = document.all.Fax.value;
   var reso = document.all.Reso.value;
   var stri = document.all.Stri.value;
   var endi = document.all.Endi.value;
   var grpn = document.all.Grpn.value;
   var mar = document.all.Mar.value;
   var com = document.all.Com.value;
   var com1 = document.all.Com1.value;
   var dsc = document.all.Dsc.value;
   var cpsi = document.all.Cpsi.value;
   var cpei = document.all.Cpei.value;
   var nexerexp = document.all.NeverExp.checked;
   var ctxt = document.all.Ctxt.value;
   var host = document.all.Host.value;
   var com2 = document.all.Com2.value;   

   if(name.trim()==""){ error = true; msg += "Name cannot be blank."}   
   if(grp.trim()==""){ error = true; msg += "\nGroup Name cannot be blank."}
   if(mar.trim()==""){ error = true; msg += "\nRegion Market cannot be blank."}

   // coupon only
   if(med=="COUPON")
   {
      if (nexerexp) { cpei = "12/31/2039"; }
      if(dsc.trim()=="" || isNaN(dsc) || eval(dsc) <= 0 ){ error = true; msg += "\nDiscount $/% cannot be blank, 0, non-numeric or negative."}
      if(cpsi.trim()=="" || cpei.trim()==""){ error = true; msg += "\nCoupon dates cannot be blank." }
      else if((new Date(cpsi.trim())) > (new Date(cpei.trim()))){ error = true; msg += "\nCoupon FROM date greater then TO date." }
      if(ctxt.trim()==""){ error = true; msg += "\nCoupon Text cannot be blank."}
   }
   // tracking only
   if(med=="TRACKING")
   {
      // mandatory if number or date entered
      if(ref.trim()=="" && rmb.trim()==""){ error = true; msg += "\nPercent Reimbersment or Event must be entered"}
      else if(duei.trim()!="" && isNaN(rmb) || eval(rmb) <= 0 ){ error = true; msg += "\nPercent Reimbersment cannot be blank, 0, non-numeric or negative."}
      else if(rmb.trim()!="" && duei.trim()==""){ error = true; msg += "\nReimbersment Due date cannot be blank."}

      //if(stri.trim()!="" && ref.trim()==""){ error = true; msg += "\nEvent name cannot be blank."}
      //if(ref.trim()!="" && stri.trim()==""){ error = true; msg += "\nEvent Start Date cannot be blank."}
      //if(ref.trim()!="" && endi.trim()==""){ error = true; msg += "\nEvent Ending Date cannot be blank."}
   }

   if(chkSpecChar(name)
	  || chkSpecChar(add1) || chkSpecChar(add2) || chkSpecChar(cty) || chkSpecChar(sta)
      || chkSpecChar(phn) || chkSpecChar(fax) || chkSpecChar(reso) || chkSpecChar(stri) || chkSpecChar(endi)
      || chkSpecChar(grpn) || chkSpecChar(mar) || chkSpecChar(com) || chkSpecChar(com1) || chkSpecChar(dsc)
      || chkSpecChar(cpsi) || chkSpecChar(cpei) || chkSpecChar(ctxt) || chkSpecChar(host)      
      )
   {
	   error = true; msg += "\nOne or more fields contained special characters or coma, please remove.";
   }
   
   var answer01 = document.all.Fld01.value.trim();
   var answer02 = document.all.Fld02.value.trim();
   var answer03 = document.all.Fld03.value.trim();
   var answer04 = document.all.Fld04.value.trim();
   var answer05 = document.all.Fld05.value.trim();
   var answer06 = document.all.Fld06.value.trim();
   var answer07 = document.all.Fld07.value.trim();
   var answer08 = document.all.Fld08.value.trim();
   var answer09 = document.all.Fld09.value.trim();
   var answer10 = document.all.Fld10.value.trim();
   
   var fedex = document.all.FedEx.value.trim();

   if(error){ alert(msg); }
   else
   { 
	   sbmCoupon(code, name, org, orgt, med, ref, con, tit, cbus
     	, rmb, duei, pmt1, pmt2, pmt3, pmt4, grp, add1, add2, cty, sta, zip, phn, fax
     	, reso, stri, endi, grpn, mar, com, com1, dsc, cpsi
     	, cpei, ctxt, host, com2
     	, answer01, answer02, answer03, answer04, answer05, answer06, answer07, answer08
     	, answer09, answer10, fedex, action); 
   }
}
//==============================================================================
// check special characters
//==============================================================================
function chkSpecChar(text)
{
	var found = false;
	var spec = "`\","; 
	for(var i=0; i < spec.length; i++)
	{
		if(text.indexOf(spec.substring(i,i+1)) >= 0 )
		{ 
			found = true; break; 
		}
	}
	
	return found;
}
//==============================================================================
// submit Coupon
//==============================================================================
function sbmCoupon(code, name, org, orgt, med, ref, con, tit, cbus
     , rmb, duei, pmt1, pmt2, pmt3, pmt4, grp, add1, add2, cty, sta, zip, phn, fax
     , reso, stri, endi, grpn, mar, com, com1, dsc, cpsi
     , cpei, ctxt, host, com2, answer01, answer02, answer03, answer04, answer05, answer06
     , answer07, answer08, answer09, answer10, fedex, action)
{   
   ;
   if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	 else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	 else{ nwelem = window.frame1.contentDocument.createElement("div");}
   
   nwelem.id = "dvSbmCoupon"

   var html = "<form name='frmCoupon'"
      + " METHOD=Post ACTION='CouponSv.jsp'>"
      + "<input name='Code'>"
      + "<input name='Name'>"
      + "<input name='Org'>"
      + "<input name='Orgt'>"
      + "<input name='Med'>"
      + "<input name='Ref'>"
      + "<input name='Con'>"
      + "<input name='Tit'>"
      + "<input name='Cbus'>"
      + "<input name='Rmb'>"
      + "<input name='Duei'>"
      + "<input name='Pmt1'>"
      + "<input name='Pmt2'>"
      + "<input name='Pmt3'>"
      + "<input name='Pmt4'>"
      + "<input name='Grp'>"
      + "<input name='Add1'>"
      + "<input name='Add2'>"
      + "<input name='Cty'>"
      + "<input name='Sta'>"
      + "<input name='Zip'>"
      + "<input name='Phn'>"
      + "<input name='Fax'>"
      + "<input name='Reso'>"
      + "<input name='Stri'>"
      + "<input name='Endi'>"
      + "<input name='Grpn'>"
      + "<input name='Mar'>"
      + "<input name='Com'>"
      + "<input name='Com1'>"
      + "<input name='Com2'>"
      + "<input name='Dsc'>"
      + "<input name='Cpsi'>"
      + "<input name='Cpei'>"
      + "<input name='Ctxt'>"
      + "<input name='Host'>"
      + "<input name='Answ01'>"
      + "<input name='Answ02'>"
      + "<input name='Answ03'>"
      + "<input name='Answ04'>"
      + "<input name='Answ05'>"
      + "<input name='Answ06'>"
      + "<input name='Answ07'>"
      + "<input name='Answ08'>"
      + "<input name='Answ09'>"
      + "<input name='Answ10'>"
      + "<input name='Action'>"
      + "<input name='FedEx'>"
    html += "</form>"

   nwelem.innerHTML = html;
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
	 {
  	   	window.frame1.document.all.Code.value = code; 	 
  	   	window.frame1.document.all.Name.value = name;
  	 	window.frame1.document.all.Org.value = org;
  	 	window.frame1.document.all.Orgt.value = orgt;
  	 	window.frame1.document.all.Med.value = med;
  	 	window.frame1.document.all.Ref.value = ref; 	 
  	   	window.frame1.document.all.Con.value = con;
  	 	window.frame1.document.all.Tit.value = tit;
  	 	window.frame1.document.all.Cbus.value = cbus;
  	 	window.frame1.document.all.Rmb.value = rmb;
  	 	window.frame1.document.all.Duei.value = duei; 	 
  	   	window.frame1.document.all.Pmt1.value = pmt1;
  	 	window.frame1.document.all.Pmt2.value = pmt2;
  	 	window.frame1.document.all.Pmt3.value = pmt3;
  	 	window.frame1.document.all.Pmt4.value = pmt4;
  	 	window.frame1.document.all.Grp.value = grp; 	 
  	   	window.frame1.document.all.Add1.value = add1;
  	 	window.frame1.document.all.Add2.value = add2;
  	 	window.frame1.document.all.Cty.value = cty;
  	 	window.frame1.document.all.Sta.value = sta;
  	 	window.frame1.document.all.Zip.value = zip; 	 
  	   	window.frame1.document.all.Phn.value = phn;
  	 	window.frame1.document.all.Fax.value = fax;
  	 	window.frame1.document.all.Reso.value = reso;
  	 	window.frame1.document.all.Stri.value = stri;
  	 	window.frame1.document.all.Endi.value = endi; 	 
  	   	window.frame1.document.all.Grpn.value = grpn;
  	 	window.frame1.document.all.Mar.value = mar;
  	 	window.frame1.document.all.Com.value = com;
  	 	window.frame1.document.all.Com1.value = com1;
  	 	window.frame1.document.all.Com2.value = com2; 	 
  	   	window.frame1.document.all.Dsc.value = dsc;
  	 	window.frame1.document.all.Cpsi.value = cpsi;
  	 	window.frame1.document.all.Cpei.value = cpei;
  	 	window.frame1.document.all.Ctxt.value = ctxt;
  	 	window.frame1.document.all.Host.value = host;
  	 	window.frame1.document.all.Answ01.value = answer01;
  	 	window.frame1.document.all.Answ02.value = answer02;
  	 	window.frame1.document.all.Answ03.value = answer03;
  	 	window.frame1.document.all.Answ04.value = answer04;
  	 	window.frame1.document.all.Answ05.value = answer05;
  	 	window.frame1.document.all.Answ06.value = answer06;
  	 	window.frame1.document.all.Answ07.value = answer07;
  	 	window.frame1.document.all.Answ08.value = answer08;
  	 	window.frame1.document.all.Answ09.value = answer09;
  	 	window.frame1.document.all.Answ10.value = answer10;
  	 	window.frame1.document.all.FedEx.value = fedex;
       	window.frame1.document.all.Action.value = action;
 	   
 	    window.frame1.document.frmCoupon.submit();
	 }
   else
   {    
  	    window.frame1.contentDocument.forms[0].Code.value = code; 	 
	   	window.frame1.contentDocument.forms[0].Name.value = name;
	 	window.frame1.contentDocument.forms[0].Org.value = org;
	 	window.frame1.contentDocument.forms[0].Orgt.value = orgt;
	 	window.frame1.contentDocument.forms[0].Med.value = med;
	 	window.frame1.contentDocument.forms[0].Ref.value = ref; 	 
	   	window.frame1.contentDocument.forms[0].Con.value = con;
	 	window.frame1.contentDocument.forms[0].Tit.value = tit;
	 	window.frame1.contentDocument.forms[0].Cbus.value = cbus;
	 	window.frame1.contentDocument.forms[0].Rmb.value = rmb;
	 	window.frame1.contentDocument.forms[0].Duei.value = duei; 	 
	   	window.frame1.contentDocument.forms[0].Pmt1.value = pmt1;
	 	window.frame1.contentDocument.forms[0].Pmt2.value = pmt2;
	 	window.frame1.contentDocument.forms[0].Pmt3.value = pmt3;
	 	window.frame1.contentDocument.forms[0].Pmt4.value = pmt4;
	 	window.frame1.contentDocument.forms[0].Grp.value = grp; 	 
	   	window.frame1.contentDocument.forms[0].Add1.value = add1;
	 	window.frame1.contentDocument.forms[0].Add2.value = add2;
	 	window.frame1.contentDocument.forms[0].Cty.value = cty;
	 	window.frame1.contentDocument.forms[0].Sta.value = sta;
	 	window.frame1.contentDocument.forms[0].Zip.value = zip; 	 
	   	window.frame1.contentDocument.forms[0].Phn.value = phn;
	 	window.frame1.contentDocument.forms[0].Fax.value = fax;
	 	window.frame1.contentDocument.forms[0].Reso.value = reso;
	 	window.frame1.contentDocument.forms[0].Stri.value = stri;
	 	window.frame1.contentDocument.forms[0].Endi.value = endi; 	 
	   	window.frame1.contentDocument.forms[0].Grpn.value = grpn;
	 	window.frame1.contentDocument.forms[0].Mar.value = mar;
	 	window.frame1.contentDocument.forms[0].Com.value = com;
	 	window.frame1.contentDocument.forms[0].Com1.value = com1;
	 	window.frame1.contentDocument.forms[0].Com2.value = com2; 	 
	   	window.frame1.contentDocument.forms[0].Dsc.value = dsc;
	 	window.frame1.contentDocument.forms[0].Cpsi.value = cpsi;
	 	window.frame1.contentDocument.forms[0].Ctxt.value = ctxt;
	 	window.frame1.contentDocument.forms[0].Host.value = host;
	 	window.frame1.contentDocument.forms[0].Answ01.value = answer01;
	 	window.frame1.contentDocument.forms[0].Answ02.value = answer02;
	 	window.frame1.contentDocument.forms[0].Answ03.value = answer03;
	 	window.frame1.contentDocument.forms[0].Answ04.value = answer04;
	 	window.frame1.contentDocument.forms[0].Answ05.value = answer05;
	 	window.frame1.contentDocument.forms[0].Answ06.value = answer06;
	 	window.frame1.contentDocument.forms[0].Answ07.value = answer07;
	 	window.frame1.contentDocument.forms[0].Answ08.value = answer08;
	 	window.frame1.contentDocument.forms[0].Answ09.value = answer09;
	 	window.frame1.contentDocument.forms[0].Answ10.value = answer10; 
	 	window.frame1.contentDocument.forms[0].FedEx.value = fedex;
  	    window.frame1.contentDocument.forms[0].Action.value = action;
 	   
  	    window.frame1.contentDocument.forms[0].submit();
   }   
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
}
//==============================================================================
// Hide selection screen
//==============================================================================
function refresh(code)
{
  window.location.href = "CouponInfo.jsp?Code=" + code
}
//==============================================================================
// Hide selection screen
//==============================================================================
function clrReimb()
{
  document.all.Duei.value="";
}
//==============================================================================
//set selected store 
//==============================================================================
function setSelStr(selobj)
{
	var str = selobj.options[selobj.selectedIndex].value;
	document.all.Host.value = str;
	
	for(var i=0; i < ArrStr.length; i++)
	{
	Mar
	     if(str == ArrStr[i])
	     {
	    	 document.all.Mar.value = ArrStrReg[i];
	    	 break;
	     }
	}
	
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
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp"></div>
<div id="dvStatus" class="dvStatus"></div>
<div id="dvChkItm" class="dvChkItm"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0" width="100%">
     <tr>
      <td ALIGN="left" VALIGN="TOP" width="30%" nowrap>
         <b><font size="-1">
            User: <%=sUser%>&nbsp;
            <br>Coupon/Tracking Id: <%=sSelCode%>
            </font></b>
      </td>
      <td ALIGN="center" VALIGN="TOP" nowrap>
        <b>Coupon/Tracking Id Information
      </td>
      <td ALIGN="right" VALIGN="TOP" width="30%" nowrap>
         <b><font size="-1">Date: <%=sToday%>
         <br>Time: <%=sCurTime%>
         </font></b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3 nowrap>
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="CouponListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page. &nbsp; &nbsp; &nbsp;
      <br>
  <!------------------------- New Skiers Info entry panel --------------------->
     <div id="dvNewSkiers" style="border-width:3px; border-style:ridge; border-color:lightgray; width:100%;">
     <table cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
       <tr class="DataTable">
         <td class="DataTable">
           Code &nbsp; <input class='Small2' name="Code" value="<%=sCode%>" maxlength=4 size=4 onFocus="this.select()" readonly> &nbsp; &nbsp;
           Code Name &nbsp; <input class='Small2' name="Name" value="<%=sName%>" maxlength=30 size=35 onFocus="this.select()"> &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable">
           Type &nbsp; <input class='Small' type="radio" name="Med" value="COUPON"
                          <%if(!sSelCode.equals("0000")){%><%if(sMed.equals("COUPON")){%>checked<%}%> readonly<%} else {%>checked<%}%>>Coupon &nbsp;
                       <input class='Small' type="radio" name="Med" value="TRACKING"
                          <%if(!sSelCode.equals("0000")){%><%if(!sMed.equals("COUPON")){%>checked<%}%> readonly<%}%>>Tracking Id &nbsp;
            <%if(!sSelCode.equals("0000")){%><%=sDati%> <%=sCby%><%} else{%><%=sToday%><%}%>
         
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            Store &nbsp;
            <input class='Small2' name="Host" value="<%=sHost%>" maxlength=2 size=2 readonly> &nbsp; &nbsp;
            &nbsp;
            <select name="SelStr" class="Small" onchange="setSelStr(this)">            
              <option value="0">--- Select Store ---</option> 
              <%for(int i=0; i < iNumOfStr; i++){%>
                  <option value="<%=sStr[i]%>"><%=sStr[i]%></option> 
              <%}%> 
            </select>
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#efefef">
            Group Name &nbsp; <input class='Small2' name="Grp" value="<%=sGrp%>" maxlength=30 size=30 onFocus="this.select()"> &nbsp; &nbsp;
            Region Market &nbsp; <input class='Small2' name="Mar" value="<%=sMar%>" maxlength=3 size=3 onFocus="this.select()"> &nbsp;
            <select class="Small" onChange="document.all.Mar.value = this.value;">
              <option value="">---Select Region----</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="99">99</option>
            </select>&nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#efefef">
            Address 1 &nbsp; <input class='Small2' name="Add1" value="<%=sAdd1%>" maxlength=25 size=25 onFocus="this.select()"> &nbsp; &nbsp;
            Address 2 &nbsp; <input class='Small2' name="Add2" value="<%=sAdd2%>" maxlength=25 size=25 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#efefef">
            City &nbsp; <input class='Small2' name="Cty" value="<%=sCty%>" maxlength=20 size=20 onFocus="this.select()"> &nbsp; &nbsp;
            State &nbsp; <input class='Small2' name="Sta" value="<%=sSta%>" maxlength=3 size=3 onFocus="this.select()"> &nbsp; &nbsp;
            Zip Code &nbsp; <input class='Small2' name="Zip" value="<%=sZip%>" maxlength=10 size=10 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#efefef">
            Phone # &nbsp; <input class='Small2' name="Phn" value="<%=sPhn%>" maxlength=14 size=14 onFocus="this.select()"> &nbsp; &nbsp;
            Business # &nbsp; <input class='Small2' name="Cbus" value="<%=sCbus%>" maxlength=14 size=14 onFocus="this.select()"> &nbsp; &nbsp;
            E-Mail &nbsp; <input class='Small2' name="Com2" value="<%=sCom2%>" maxlength=50 size=52 onFocus="this.select()"> &nbsp; &nbsp;            
         </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable" style="background:#efefef">
           Organization Type &nbsp; <input class='Small2' name="Orgt" value="<%=sOrgt%>" maxlength=10 size=10 onFocus="this.select()"> &nbsp; &nbsp;
           FedEx Shipping/Tracking #  &nbsp; <input class='Small2' name="FedEx" value="<%=sFedEx%>" maxlength=50 size=55 onFocus="this.select()"> &nbsp;
       </td>
       </tr>
       
       <tr class="DataTable">
         <td class="DataTable" style="background:#efe97c">
           <br><b>Valid Through:</b>
         </td>
       </tr>
          <tr class="DataTable">
         <td class="DataTable" style="background:#efe97c">   
			From &nbsp;	
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Cpsi')">&#60;</button>
              <input class='Small2' name="Cpsi" value="<%=sCpsi%>" maxlength=10 size=10 readonly onFocus="this.select()">              <button class="Small" name="Up" onClick="setDate('UP', 'Cpsi')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 200, 300, document.all.Cpsi)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              &nbsp; - &nbsp;


            To &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Cpei')">&#60;</button>
              <input class='Small2' name="Cpei" value="<%=sCpei%>" maxlength=10 size=10 readonly onFocus="this.select()">
              <button class="Small" name="Up" onClick="setDate('UP', 'Cpei')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 400, 300, document.all.Cpei)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              &nbsp;
              <input type="checkbox" name="NeverExp" value="Y">Never Expires
          </td>
       </tr>       

       <tr class="DataTable">
         <td class="DataTable" style="background:#cccfff">
           <br><b>Coupon Info:</b>
         </td>
       </tr>
              
       <tr class="DataTable">
         <td class="DataTable" style="background:#cccfff">
            Discount $/% &nbsp; <input class='Small2' name="Dsc" value="<%=sDsc%>" maxlength=5 size=5 onFocus="this.select()"> &nbsp; &nbsp;
            
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#cccfff">
            Coupon Text &nbsp; <input class='Small2' name="Ctxt" value="<%=sCtxt%>" maxlength=30 size=40 onFocus="this.select()"> &nbsp; &nbsp;
            Comment &nbsp; <input class='Small2' name="Com" value="<%=sCom%>" maxlength=50 size=70 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#cccfff">
            Merchendise Category &nbsp; <input class='Small2' name="Org" value="<%=sOrg%>" maxlength=10 size=10 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#ccffcc">
           <br><b>Tracking/Cashback Info:</b>
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#ccffcc">
            Percent Reimbursment &nbsp; <input class='Small2' name="Rmb" value="<%=sRmb%>" maxlength=5 size=5 onFocus="this.select()"> &nbsp; &nbsp;
            Reimbursment Due: &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Duei')">&#60;</button>
              <input class='Small2' name="Duei" value="<%if(!sDuei.equals("01/01/0001")){%><%=sDuei%><%}%>" readonly maxlength=10 size=10 onFocus="this.select()">
              <button class="Small" name="Up" onClick="setDate('UP', 'Cpsi')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 330, 400, document.all.Duei)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              &nbsp; <a class="Small" href="javascript: clrReimb();">Clear</a>
              &nbsp; &nbsp; &nbsp;
               <a class="Small" href="CustomerPurchase.jsp?Code=<%=sCode%>&Customer=& S Pro- Carrie, S&From=01/01/2000&To=01/01/2099" target="_blank">Customer Sales</a>
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:#ccffcc">
           Payment Made &nbsp;
             1 <input class='Small2' name="Pmt1" value="<%=sPmt1%>" maxlength=30 size=30 onFocus="this.select()"> &nbsp; &nbsp;
             2 <input class='Small2' name="Pmt2" value="<%=sPmt1%>" maxlength=30 size=30 onFocus="this.select()"> &nbsp; &nbsp;
             3 <input class='Small2' name="Pmt3" value="<%=sPmt1%>" maxlength=30 size=30 onFocus="this.select()"> &nbsp; &nbsp;
             4 <input class='Small2' name="Pmt4" value="<%=sPmt1%>" maxlength=30 size=30 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:moccasin">
           <br><b>Event Info:</b>
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:moccasin">
           Name &nbsp; <input class='Small2' name="Ref" value="<%=sRef%>" maxlength=25 size=25 onFocus="this.select()"> &nbsp; &nbsp;
           From &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Stri')">&#60;</button>
              <input class='Small2' name="Stri" value="<%if(!sDuei.equals("01/01/0001")){%><%=sStri%><%}%>" readonly maxlength=10 size=10 onFocus="this.select()">              <button class="Small" name="Up" onClick="setDate('UP', 'Cpsi')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 200, 300, document.all.Stri)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              &nbsp; - &nbsp;


            To &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Endi')">&#60;</button>
              <input class='Small2' name="Endi" value="<%=sEndi%>" readonly maxlength=10 size=10 onFocus="this.select()">
              <button class="Small" name="Up" onClick="setDate('UP', 'Endi')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 400, 300, document.all.Endi)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
         </td>
       </tr>
      
       <tr class="DataTable">
         <td class="DataTable" style="background:moccasin">
            Resort &nbsp; <input class='Small2' name="Reso" value="<%=sReso%>" maxlength=25 size=25 onFocus="this.select()"> &nbsp; &nbsp;
            # in Group &nbsp; <input class='Small2' name="Grpn" value="<%=sGrpn%>" maxlength=6 size=6 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:moccasin">
            Contact Name &nbsp; <input class='Small2' name="Con" value="<%=sCon%>" maxlength=25 size=25 onFocus="this.select()"> &nbsp; &nbsp;
            Phone # &nbsp; <input class='Small2' name="Fax" value="<%=sFax%>" maxlength=14 size=14 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>

       <tr class="DataTable">
         <td class="DataTable" style="background:moccasin">
            Title &nbsp; <input class='Small2' name="Tit" value="<%=sTit%>" maxlength=25 size=25 onFocus="this.select()"> &nbsp; &nbsp;
            Event Comments &nbsp; <input class='Small2' name="Com1" value="<%=sCom1%>" maxlength=50 size=70 onFocus="this.select()"> &nbsp; &nbsp;
         </td>
       </tr>
       
       <tr class="DataTable">
         <td class="DataTable" style="background: #aaccaa">
           <br><b>Questionnaire Answer:</b>
         </td>
       </tr>
       
       <tr class="DataTable">
         <td class="DataTable" style="background: #aaccaa">
           <table class="DataTable2">
           	 <tr>
           	 	<td>How did you hear about Sun & Ski?</td>
           	 	<td><textarea maxlength="256" name="Fld01" cols="100" rows="4"><%=sAnsw01%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>What outdoor activities do you participate in and where?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld02" cols="100" rows="4"><%=sAnsw02%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>How often do you participate in your outdoor activities?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld03" cols="100" rows="4"><%=sAnsw03%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>Are you a member of any outdoor related clubs or organizations?<br>If so, which ones?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld04" cols="100" rows="4"><%=sAnsw04%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>What is your T-shirt size?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld05" cols="100" rows="4"><%=sAnsw05%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>What T-shirt cut would you prefer?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld06" cols="100" rows="4"><%=sAnsw06%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>Do you have a Facebook, Twitter or Instagram profile you'd be willing to share?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld07" cols="100" rows="4"><%=sAnsw07%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>If you answered "yes" to the previous question, please list your social media handles?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld08" cols="100" rows="4"><%=sAnsw08%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>Which of these opportunities to partner with us are you most interested in?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld09" cols="100" rows="4"><%=sAnsw09%></textarea></td>
           	 </tr>
           	 <tr>
           	 	<td>What value do you feel you can bring to the Sun & Ski brand by being a Pro?</td>
           	 	<td><textarea class='Small' maxlength="256" name="Fld10" cols="100" rows="4"><%=sAnsw10%></textarea></td>
           	 </tr>           	            	 
           </table>
         </td>
       </tr>

           </table>
         </td>
       </tr>
       
    </table>
    </div>

    <span style="text-align:center;width:100%">
       <%if(sSelCode.equals("0000")){%><button class="Small" onClick="chgCoupon('0000', 'ADD');">Add Code</button><%}
         else {%>
            <button class="Small" onClick="chgCoupon('<%=sSelCode%>', 'UPDATE');">Change</button>
       <%}%>
    </span>
  <!----------------------- end of new skier entry table ---------------------->


   </tr>

  </table>
 </body>
</html>


<%
  }%>










