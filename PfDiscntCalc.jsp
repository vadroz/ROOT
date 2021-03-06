<%@ page import="patiosales.OrderEntry, rciutility.FormatNumericValue, java.util.*, java.text.*, java.math.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sUser =  request.getParameter("User");


   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   //cal.add(Calendar.DATE, 2);
   String sToday = sdf.format(cal.getTime());

   sdf = new SimpleDateFormat("h:mm a");
   String sCurTime = sdf.format(cal.getTime());

    
      
      OrderEntry ordent = new OrderEntry();
      ordent.serOrderInfo(sOrder.trim());

      int iNumOfItm = ordent.getNumOfItm();
      String [] sSku = ordent.getSku();
      String [] sVenSty = ordent.getVenSty();
      String [] sVen = ordent.getVen();
      String [] sVenName = ordent.getVenName();
      String [] sColor = ordent.getColor();
      String [] sUpc = ordent.getUpc();
      String [] sDesc = ordent.getDesc();
      String [] sQty = ordent.getQty();
      String [] sRet = ordent.getRet();
      String [] sIpRet = ordent.getIpRet();

      String sSkuJsa = ordent.cvtToJavaScriptArray(ordent.getSku());
      String sVenStyJsa = ordent.cvtToJavaScriptArray(ordent.getVenSty());
      String sVenJsa = ordent.cvtToJavaScriptArray(ordent.getVen());
      String sVenNameJsa = ordent.cvtToJavaScriptArray(ordent.getVenName());
      String sColorJsa = ordent.cvtToJavaScriptArray(ordent.getColor());
      String sUpcJsa = ordent.cvtToJavaScriptArray(ordent.getUpc());
      String sDescJsa = ordent.cvtToJavaScriptArray(ordent.getDesc());
      String sQtyJsa = ordent.cvtToJavaScriptArray(ordent.getQty());
      String sRetJsa = ordent.cvtToJavaScriptArray(ordent.getRet());
      String sIpRetJsa = ordent.cvtToJavaScriptArray(ordent.getIpRet());
      String sTotalJsa = ordent.cvtToJavaScriptArray(ordent.getTotal());

      ordent.setGrpDisc(sOrder);
      ordent.getGrpDisc();
      int iNumOfGrp = ordent.getNumOfGrp();
      String [] sGrpNum = ordent.getGrpNum();
      String [] sGrpDscPrc = ordent.getGrpDscPrc();
      String [] sGrpDscAmt = ordent.getGrpDscAmt();
      String [] sGrpNewAmt = ordent.getGrpNewAmt();
      String [] sGrpOrg = ordent.getGrpOrg();
      String [] sGrpMax = ordent.getGrpMax();
      String [] sGrpTot = ordent.getGrpTot();
      

      String sGrpNumJsa = ordent.getGrpNumJsa();
      String sGrpDscPrcJsa = ordent.getGrpDscPrcJsa();
      String sGrpDscAmtJsa = ordent.getGrpDscAmtJsa();
      String sGrpNewAmtJsa = ordent.getGrpNewAmtJsa();
      String sGrpOrgJsa = ordent.getGrpOrgJsa();
      String sGrpMaxJsa = ordent.getGrpMaxJsa();
      String sGrpTotJsa = ordent.getGrpTotJsa();
      

      // format Numeric value
      FormatNumericValue fmt = new FormatNumericValue();
%>

<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:white; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; vertical-align:middle;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; vertical-align:middle;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; vertical-align:middle;}
        td.DataTable3 { color:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; vertical-align:middle;}

        .Small {font-family:Arial; font-size:10px }
        input.Small1 {background:LemonChiffon; font-family:Arial; font-size:10px }
        input {border:none; border-bottom: black solid 1px; font-family:Arial; font-size:12px; font-weight:bold}
        input.radio {border:none; font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea.NoBorder {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

@media screen
{
}
@media print
{
}
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
// orser header info
var Order = "<%=sOrder%>";
var NumOfItm = "<%=iNumOfItm%>";
var Sku = [<%=sSkuJsa%>];
var VenSty = [<%=sVenStyJsa%>];
var Ven = [<%=sVenJsa%>];
var VenName = [<%=sVenNameJsa%>];
var Color =[<%=sColorJsa%>];
var Upc = [<%=sUpcJsa%>]
var Desc = [<%=sDescJsa%>];
var Qty = [<%=sQtyJsa%>];
var Ret = [<%=sRetJsa%>];
var IpRet = [<%=sIpRetJsa%>];
var Total = [<%=sRetJsa%>];

var ItmNewRet = new Array();
var ItmCustSave = new Array();

var SvNumOfGrp = eval("<%=iNumOfGrp%>");
var SvGrpNum = [<%=sGrpNumJsa%>];
var SvGrpDscPrc = [<%=sGrpDscPrcJsa%>];
var SvGrpAmtPrc = [<%=sGrpDscAmtJsa%>];
var SvGrpNewAmt = [<%=sGrpNewAmtJsa%>];

// group item
var aGroup = new Array();
var aGrpSku = new Array();
var aGrpSeq = new Array();
var aGrpRetObj = new Array();
var aGrpRetAmt = new Array();

var aIdSku = new Array();
var aIdSeq = new Array();
var aIdGrp = new Array();
var aIdDscAmt = new Array();
var aIdDscPrc = new Array();
var aIdUpgAmt = new Array();
var aIdNewRet = new Array();

// group
var MaxGrp = <%=iNumOfGrp%>;
var CurArg = -1;
var aGrpPrc = new Array();
var aGrpDscAmt = new Array();
var aGrpAmt = new Array();
var aGrpOrig = new Array();
var aGrpNewAmt = new Array();

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	document.all.btnGrpCalc.style.display="none";
   	setSavedGrp();
   	clcOrdTot();
}

//==============================================================================
// set saved group
//==============================================================================
function setSavedGrp()
{
   //var max = MaxGrp;
   var numitm = 0;
   var grptot = 0;
   for(var i=0, k=0; i < Sku.length; i++)
   {
       for(var j=0; j < Qty[i]; j++)
       {
          var cb = "SvItmGrp" + i + "_" + j
          var cbobj = document.all[cb];
          var grpNum = cbobj.value.trim();
          if( grpNum != "")
          {
             aGrpSku[aGrpSku.length] = i;
             aGrpSeq[aGrpSeq.length] = j;
             aGroup[aGroup.length] = grpNum - 1;
             var gn = "tdGrpNum" + k;
             document.all[gn].innerHTML = grpNum;

             cb = "Grp" + i + "_" + j
             document.all[cb].style.display = "none";

             numitm++;
             var nr = "NewRet" + i + "_" + j;
             aGrpRetObj[aGrpRetObj.length] = document.all[nr];
             aGrpRetAmt[aGrpRetAmt.length] = Ret[i];
          }
          k++;
       }
   }
   document.all.btnGrpCalc.style.display="block";
   if(MaxGrp > 0)
   {
     clcNewGrpRet();
     clcNewGrpItmRet();
   }
   clcNewRet();
}

//==============================================================================
// calculate order total
//==============================================================================
function clcOrdTot()
{
   var ordtot = 0;
   var orig = 0;
   var custsave = 0;
   for(var i=0; i < ItmNewRet.length; i++)
   {
      for(var j=0; j < ItmNewRet[i].length; j++)
      {
         ordtot += eval(ItmNewRet[i][j]);
         orig += eval(Ret[i]);
         custsave += eval(ItmCustSave[i][j]);
      }
   }

   document.all.TotNewRet.innerHTML = "$" + (ordtot).toFixed(2);
   document.all.TotOrgRet.innerHTML = "$" + (orig).toFixed(2);
   document.all.TotCustSave.innerHTML = "$" + (custsave).toFixed(2);
}
//==============================================================================
// validate new retail price
//==============================================================================
function vldNewRet(clcOrSav)
{
   var ordtot = 0;
   var error = false;
   var msg = "";

   for(var i=0; i < ItmNewRet.length; i++)
   {

      for(var j=0; j < ItmNewRet[i].length; j++)
      {
         msg = "";
         var br = "";
         var nr = "NewRet" + i + "_" + j;
         var newret = document.all[nr];

         var da = "DscAmt" + i + "_" + j;
         var dscamt = document.all[da].value.trim();
         
         if(isNaN(dscamt)){error = true; msg += br + "The Discount Amount is not numeric"; br="<br>";}

         var dp = "DscPrc" + i + "_" + j;
         var dscprc = document.all[dp].value.trim();
         if(isNaN(dscprc)){error = true; msg += br + "The Discount Percent is not numeric"; br="<br>";}

         if(dscamt != 0 && dscprc != 0){error = true; msg += br + "Select only discount $ or %."; br="<br>";}

         var ua = "UpgAmt" + i + "_" + j;
         var upgamt = document.all[ua].value.trim();
         if(isNaN(upgamt)){error = true; msg += br + "The Upgrade Amount is not numeric"; br="<br>";}

         
         var err = "Err" + i + "_" + j;
         if(error){ document.all[err].innerHTML = msg; }
         else { document.all[err].innerHTML = ""; } 
      }
   }
   
   if(!error && !clcNewRet())
   {
  	 error = true; alert("No Group or Item Discounts entered. Press 'Remove - All'.");
   }

   
   
   
   if(!error)
   {
     if(clcOrSav == "C")
     {
    	 clcNewRet();
    	 clcOrdTot();
     }
     else if(clcOrSav == "S")
     {       	 
    	 disableBtn();
    	 CurArg = -1;         
         saveNewGrpRet();
     }
   }
}
//==============================================================================
//calculate new retail price
//==============================================================================
function disableBtn()
{
	document.all.btnClc.disabled = true;
	document.all.btnSave.disabled = true;
	document.all.btnClose.disabled = true;
	document.all.btnReset.disabled = true;
}
//==============================================================================
// calculate new retail price
//==============================================================================
function clcNewRet()
{
   var ordtot = 0;

   aIdSku = new Array();
   aIdSeq = new Array();
   aIdGrp = new Array();
   aIdDscAmt = new Array();
   aIdDscPrc = new Array();
   aIdUpgAmt = new Array();
   aIdNewRet = new Array();
   
   var changed = false;

   for(var i=0, k=0; i < ItmNewRet.length; i++)
   {
      for(var j=0; j < ItmNewRet[i].length; j++, k++)
      {
         aIdSku[k] = Sku[i];
         aIdSeq[k] = j+1;
         aIdGrp[k] = getGroupNum(i,j);

         var nr = "NewRet" + i + "_" + j;
         var newret = document.all[nr];

         var da = "DscAmt" + i + "_" + j;
         var dscamt = (document.all[da]).value.trim();
         if(dscamt == "" ) { dscamt = "0"; }
         var dscamt = eval(dscamt);
         
         var cs = "CustSave" + i + "_" + j;
         var custsave = document.all[cs];

         // retreive original or recalculated group retail price
         var ret = getItmRet(i,j);
         ItmNewRet[i][j] = ret;       
         newret.innerHTML = ret;

         if(dscamt != 0)
         {
            ItmNewRet[i][j] = (ret - dscamt).toFixed(4);
            newret.innerHTML = ItmNewRet[i][j];
         }

         var dp = "DscPrc" + i + "_" + j;
         var dscprc = (document.all[dp]).value.trim();
         if(dscprc == "") {  dscprc = "0";  }
         dscprc = eval(dscprc);
                   
         if(dscprc != 0)
         {
            ItmNewRet[i][j] = (ret * (1 - dscprc / 100)).toFixed(4);
            newret.innerHTML = ItmNewRet[i][j];
         }

         var ua = "UpgAmt" + i + "_" + j;
         var upgamt = (document.all[ua]).value.trim();
         if(upgamt == 0){ upgamt = "0"; }
         upgamt = eval(upgamt);
         
         if(upgamt != 0)
         {
            ItmNewRet[i][j] = (ret - -1 * upgamt).toFixed(4);
            newret.innerHTML = ItmNewRet[i][j];
         }
         
         // customer save         
         ItmCustSave[i][j] = (Ret[i] - ItmNewRet[i][j]).toFixed(2)
         custsave.innerHTML = ItmCustSave[i][j];
         

         aIdDscAmt[k] = dscamt;
         aIdDscPrc[k] = dscprc;
         aIdUpgAmt[k] = upgamt;
         aIdNewRet[k] = ItmNewRet[i][j];
         
         if(!changed && Ret[i] - ItmNewRet[i][j] != 0)
         { 
        	 var diff = Ret[i] - ItmNewRet[i][j];
        	 changed = true;
         }

         ordtot += eval(ItmNewRet[i][j]);
      }
   }
   document.all.TotNewRet.innerHTML = "$" + (ordtot).toFixed(2);
   
   return changed;
}
//==============================================================================
// retreive original or recalculated group retail price
//==============================================================================
function saveNewGrpRet()
{
   var nwelem = "";
   if(isIE){ nwelem = window.frame1.document.createElement("div"); }
   else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
   else{ nwelem = window.frame1.contentDocument.createElement("div");}
      
   nwelem.id = "dvSbmGrp"      
  
   var html = "<form name='frmSaveGrp'"
      + " METHOD=Post ACTION='OrderDtlSave.jsp'>"
      + "<input name='Order'>";
   
   for(var i=0; i < MaxGrp; i++)
   {
	   html +=  "<input name='GrpDscPrc'>"
          + "<input name='GrpDscAmt'>"
          + "<input name='GrpNewAmt'>"
          + "<input name='GrpTot'>"
   } 
   
   html += "<input name='Clear'>"
   	+ "<input name='Action'>"
   	+ "</form>"  

   nwelem.innerHTML = html;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame1.document.body.appendChild(nwelem);}
   else{ window.frame1.contentDocument.body.appendChild(nwelem); } 

   for(var i=00; i < MaxGrp; i++)
   {
   		if(isIE || isSafari)
   		{
   			if(MaxGrp == 1){ save_IE_grp_single(i); }
   			else{ save_IE_grp_mult(i); }
   		}
   		else
   		{
   			if(MaxGrp == 1){ save_Chrome_grp_single(i); }
   			else{ save_Chrome_grp_mult(i); }
   		}
   }
   
   if(isIE || isSafari) 
   { 
	   window.frame1.document.all.Action.value = "SaveGrpDsc";
	   window.frame1.document.all.Order.value = Order;
   }
   else
   { 
	   window.frame1.contentDocument.forms[0].Order.value = Order;
	   window.frame1.contentDocument.forms[0].Action.value = "SaveGrpDsc";    
   }
      
   if(isIE || isSafari) { window.frame1.document.frmSaveGrp.submit(); }
   else{ window.frame1.contentDocument.forms[0].submit(); }
   
}
//==============================================================================
// save group for IE browser for single items
//==============================================================================
function save_IE_grp_single(i)
{	  	 
  	window.frame1.document.all.GrpDscPrc.value = aGrpPrc[i];
 	window.frame1.document.all.GrpDscAmt.value = aGrpDscAmt[i];
 	window.frame1.document.all.GrpNewAmt.value = aGrpNewAmt[i];
  	window.frame1.document.all.GrpTot.value = aGrpNewAmt[i];  		
}
//==============================================================================
//save group for IE browser for multiple items
//==============================================================================
function save_IE_grp_mult(i)
{	
	window.frame1.document.all.GrpDscPrc[i].value = aGrpPrc[i];
	window.frame1.document.all.GrpDscAmt[i].value = aGrpDscAmt[i];
	window.frame1.document.all.GrpNewAmt[i].value = aGrpNewAmt[i];
	window.frame1.document.all.GrpTot[i].value = aGrpNewAmt[i];	 	
}
//==============================================================================
//save group for Chrome browser fo 1 row
//==============================================================================
function save_Chrome_grp_single(i)
{ 	  
    window.frame1.contentDocument.forms[0].GrpDscPrc.value = aGrpPrc[i];
 	window.frame1.contentDocument.forms[0].GrpDscAmt.value = aGrpDscAmt[i];
 	window.frame1.contentDocument.forms[0].GrpNewAmt.value = aGrpNewAmt[i];
    window.frame1.contentDocument.forms[0].GrpTot.value = aGrpNewAmt[i];
}
//==============================================================================
//save group for Chrome browser fo multiple row
//==============================================================================
function save_Chrome_grp_mult(i)
{ 	  
  window.frame1.contentDocument.forms[0].GrpDscPrc[i].value = aGrpPrc[i];
	window.frame1.contentDocument.forms[0].GrpDscAmt[i].value = aGrpDscAmt[i];
	window.frame1.contentDocument.forms[0].GrpNewAmt[i].value = aGrpNewAmt[i];
  window.frame1.contentDocument.forms[0].GrpTot[i].value = aGrpNewAmt[i];
}
//==============================================================================
// retreive item discount
//==============================================================================
function saveNewItmRet()
{
	var nwelem = "";
   	
	if(isIE){ nwelem = window.frame2.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame2.document.createElement("div"); }
	else{ nwelem = window.frame2.contentDocument.createElement("div");}
	      
    nwelem.id = "dvSbmGrp"
    var html = "<form name='frmSaveGrp'"
        + " METHOD=Post ACTION='OrderDtlSave.jsp'>"
        + "<input name='Order'>"

   for(var i=0; i < aIdSku.length; i++)
   {
	   html += "<input name='IdSku'>"
          + "<input name='IdSeq'>"
          + "<input name='IdGrp'>"
          + "<input name='IdDscAmt'>"
          + "<input name='IdDscPrc'>"
          + "<input name='IdUpgAmt'>"
          + "<input name='IdNewRet'>"
   }
   
   html += "<input name='Clear'>"
          + "<input name='Action'>"
   html += "</form>"

   nwelem.innerHTML = html;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame2.document.appendChild(nwelem); }
   else if(isIE){ window.frame2.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame2.document.body.appendChild(nwelem);}
   else{ window.frame2.contentDocument.body.appendChild(nwelem); }

   for(var i=0; i < aIdSku.length; i++)
   {
      if(isIE || isSafari)
	  {
    	  if(aIdSku.length == 1){ save_IE_Item_single(i); }
    	  else{ save_IE_Item_mult(i); }
	  }
      else
      {
    	  if(aIdSku.length == 1){ save_Chrome_Item_single(i); }
    	  else{ save_Chrome_Item_mult(i); }
      }
   }
   
   if(isIE || isSafari)
   {	   
	   window.frame2.document.all.Order.value = Order;
	   window.frame2.document.all.Action.value = "SaveItmDsc";
	   window.frame2.document.frmSaveGrp.submit();  
   }
   else
   {
	   window.frame2.contentDocument.forms[0].Order.value = Order; 
       window.frame2.contentDocument.forms[0].Action.value = "SaveItmDsc";
       window.frame2.contentDocument.forms[0].submit();        
   }    
}
//==============================================================================
// save item discount for IE browser
//==============================================================================
function save_IE_Item_single(i)
{	
	
  	window.frame2.document.all.IdSku.value = aIdSku[i];
  	window.frame2.document.all.IdSeq.value = aIdSeq[i];
  	window.frame2.document.all.IdGrp.value = aIdGrp[i];
  	window.frame2.document.all.IdDscAmt.value = aIdDscAmt[i];
  	window.frame2.document.all.IdDscPrc.value = aIdDscPrc[i];
  	window.frame2.document.all.IdUpgAmt.value = aIdUpgAmt[i];
  	window.frame2.document.all.IdNewRet.value = aIdNewRet[i];
  	window.frame2.document.all.Action.value = "SaveItmDsc";
}
//==============================================================================
//save item discount for IE browser
//==============================================================================
function save_IE_Item_mult(i)
{		
	window.frame2.document.all.IdSku[i].value = aIdSku[i];
	window.frame2.document.all.IdSeq[i].value = aIdSeq[i];
	window.frame2.document.all.IdGrp[i].value = aIdGrp[i];
	window.frame2.document.all.IdDscAmt[i].value = aIdDscAmt[i];
	window.frame2.document.all.IdDscPrc[i].value = aIdDscPrc[i];
	window.frame2.document.all.IdUpgAmt[i].value = aIdUpgAmt[i];
	window.frame2.document.all.IdNewRet[i].value = aIdNewRet[i];
	
}
//==============================================================================
//save item discount for IE browser
//==============================================================================
function save_Chrome_Item_single(i)
{	 
	window.frame2.contentDocument.forms[0].IdSku.value = aIdSku[i];
    window.frame2.contentDocument.forms[0].IdSeq.value = aIdSeq[i];
    window.frame2.contentDocument.forms[0].IdGrp.value = aIdGrp[i];
    window.frame2.contentDocument.forms[0].IdDscAmt.value = aIdDscAmt[i];
    window.frame2.contentDocument.forms[0].IdDscPrc.value = aIdDscPrc[i];
    window.frame2.contentDocument.forms[0].IdUpgAmt.value = aIdUpgAmt[i];
    window.frame2.contentDocument.forms[0].IdNewRet.value = aIdNewRet[i];
}
//==============================================================================
//save item discount for IE browser
//==============================================================================
function save_Chrome_Item_mult(i)
{
	window.frame2.contentDocument.forms[0].IdSku[i].value = aIdSku[i];
    window.frame2.contentDocument.forms[0].IdSeq[i].value = aIdSeq[i];
    window.frame2.contentDocument.forms[0].IdGrp[i].value = aIdGrp[i];
    window.frame2.contentDocument.forms[0].IdDscAmt[i].value = aIdDscAmt[i];
    window.frame2.contentDocument.forms[0].IdDscPrc[i].value = aIdDscPrc[i];
    window.frame2.contentDocument.forms[0].IdUpgAmt[i].value = aIdUpgAmt[i];
    window.frame2.contentDocument.forms[0].IdNewRet[i].value = aIdNewRet[i];
}

//==============================================================================
//reload page
//==============================================================================
function restart()
{
	try
	{ 
		opener.location.reload();	
	} 
	catch(err){  } 
    window.location.reload();
}
//==============================================================================
// search group number
//==============================================================================
function getGroupNum(itm_i, itm_j)
{
   var grp = "0";
   for(var i=0; i < MaxGrp; i++)
   {
      for(var j=0; j < aGroup.length; j++)
      {
         if(aGrpSku[j] == itm_i && aGrpSeq[j] == itm_j)
         {
            grp = aGroup[j] + 1;
            break;
         }
      }
   }

   return grp;
}
//==============================================================================
// retreive original or recalculated group retail price
//==============================================================================
function getItmRet(itm_i, itm_j)
{
   var ret = Ret[itm_i];
   for(var i=0; i < MaxGrp; i++)
   {
      for(var j=0; j < aGroup.length; j++)
      {
         if(aGrpSku[j] == itm_i && aGrpSeq[j] == itm_j)
         {
            ret = aGrpRetAmt[j];
         }
      }
   }

   return ret;
}
//==============================================================================
// validate group retail price
//==============================================================================
function clearAll()
{
   var r = confirm("Do you really want to remove all item and group discounts?");
   if (r == true)
   {
      url = "OrderDtlSave.jsp?Order=" + Order
          + "&Action=ClearItmDisc"
      window.frame1.location.href=url
   }
}
//==============================================================================
// re-start
//==============================================================================
function reStart()
{
   window.location.reload();
}
//==============================================================================
// set item as group
//==============================================================================
function setItmGrp()
{
   var max = MaxGrp;
   var check = false;
   var numitm = 0;
   var grptot = 0;
   for(var i=0, k=0; i < Sku.length; i++)
   {
       for(var j=0; j < Qty[i]; j++)
       {
          var cb = "Grp" + i + "_" + j
          var cbobj = document.all[cb];
          if(cbobj.checked)
          {
             aGrpSku[aGrpSku.length] = i;
             aGrpSeq[aGrpSeq.length] = j;
             aGroup[aGroup.length] = max;
             check = true;
             var gn = "tdGrpNum" + k;
             document.all[gn].innerHTML = max + 1 ;
             cbobj.checked = false;
             cbobj.style.display = "none";
             numitm++;
             var nr = "NewRet" + i + "_" + j;
             aGrpRetObj[aGrpRetObj.length] = document.all[nr];
             aGrpRetAmt[aGrpRetAmt.length] = Ret[i];
          }
          k++;
       }
   }

   if(!check){ alert("You did not check any group")}
   else
   {
      addGrpRow(MaxGrp, numitm);
      MaxGrp++;
      clcNewGrpRet();
      document.all.btnGrpCalc.style.display="block";
   }
}
//==============================================================================
// add group row
//==============================================================================
function addGrpRow(grp, numitm)
{
   var tbody = document.getElementById("tblGrp").getElementsByTagName("TBODY")[1];

   var row = document.createElement("TR");
   var td1 = document.createElement("td")
   var td2 = document.createElement("td")
   var td3 = document.createElement("td")
   var td4 = document.createElement("td")
   var td5 = document.createElement("td")
   var td6 = document.createElement("td")
   var td7 = document.createElement("td")
   var td8 = document.createElement("td")
   var td9 = document.createElement("td")

   row.className="DataTable";
   td1.className="DataTable";
   td2.className="DataTable";
   td3.className="DataTable";
   td4.className="DataTable";
   td5.className="DataTable";
   td6.className="DataTable";
   td7.className="DataTable";
   td8.className="DataTable";
   td9.className="DataTable";

   td1.innerHTML=grp+1;
   td2.innerHTML=numitm;
   td3.innerHTML="&nbsp;";
   td4.innerHTML="<input class='Small' name='GrpDscPrc" + grp + "' size=10 maxlength=10>%";
   td5.innerHTML="<input class='Small' name='GrpDscAmt" + grp + "' size=10 maxlength=10>%";
   td6.innerHTML="$<input class='Small' name='GrpNewGrp" + grp + "' size=10 maxlength=10>";
   td7.innerHTML="&nbsp;";
   td8.innerHTML="&nbsp;";
   td9.innerHTML="&nbsp;";

   row.id = "trGrp" + grp;
   td3.id = "tdGrpOrg" + grp;
   td7.id = "tdGrpErr" + grp;
   td7.style.color = "red";
   td8.id = "tdGrpTot" + grp;
   td9.id = "tdGrpSave" + grp;

   row.appendChild(td1);
   row.appendChild(td2);
   row.appendChild(td3);
   row.appendChild(td4);
   row.appendChild(td5);
   row.appendChild(td6);
   row.appendChild(td7);
   row.appendChild(td8);
   row.appendChild(td9);

   tbody.appendChild(row);
}
//==============================================================================
// set item as group
//==============================================================================
function rmvItmGrp()
{
   var check = false;
   aGrpSku = new Array();
   aGrpSeq = new Array();
   aGroup = new Array();

   for(var i=0, k=0; i < Sku.length; i++)
   {
       for(var j=0; j < Qty[i]; j++)
       {
          var cb = "Grp" + i + "_" + j
          var cbobj = document.all[cb];
          var gn = "tdGrpNum" + k;
          document.all[gn].innerHTML = "None";
          cbobj.checked = false;
          cbobj.style.display = "inline";
          k++;
       }
   }

   // remove groups
   var tbody = document.getElementById("tblGrp").getElementsByTagName("TBODY")[1];
   for(var i=0; i < MaxGrp; i++)
   {
      var rownm = "trGrp" + i;
      var row = document.getElementById(rownm);
      tbody.removeChild(tbody.childNodes[0])
   }
   document.all.btnGrpCalc.style.display="none";
   MaxGrp = 0;
}
//==============================================================================
// validate group retail price
//==============================================================================
function vldGrpRet()
{
   var error = false;
   var msg = "";
   for(var i=0; i < MaxGrp; i++)
   {
       msg = "";
       var br = "";
       var dp = "GrpDscPrc" + i;
       var dscprc = document.all[dp].value.trim();

       if(isNaN(dscprc)){error = true; msg += br + "The Discount Percent is not numeric"; br="<br>";}
       else{ aGrpPrc[i] = eval(dscprc); }

       var da = "GrpNewGrp" + i;
       var dscamt = document.all[da].value.trim();
       if(isNaN(dscamt)){error = true; msg += br + "The New Group Amount is not numeric"; br="<br>";}
       else{ aGrpAmt[i] = eval(dscamt); }

       da = "GrpDscAmt" + i;
       dscamt = document.all[da].value.trim();
       if(isNaN(dscamt)){error = true; msg += br + "The Group Discount Amount is not numeric"; br="<br>";}
       else{ aGrpDscAmt[i] = eval(dscamt); }

       if(dscprc != "" && dscamt != ""){error = true; msg += br + "You cannot use % and new $ amt for same group."; br="<br>";}

       var err = "tdGrpErr" + i;
       if(error){ document.all[err].innerHTML = msg; }
       else{ document.all[err].innerHTML = "&nbsp;"; }

   }
   if(!error)
   {
      clcNewGrpRet();
      clcNewGrpItmRet();
      clcNewRet();
      clcOrdTot()
   }
}
//==============================================================================
// calculate group retail price
//==============================================================================
function clcNewGrpRet()
{
   for(var i=0; i < MaxGrp; i++)
   {
      var grptot = 0;

      for(var j=0; j < aGroup.length; j++)
      {
         if(aGroup[j] == i)
         {
           grptot += eval(Ret[aGrpSku[j]]);
         }
      }


      if(aGrpPrc[i] > 0){  aGrpNewAmt[i] = (grptot * (1 - aGrpPrc[i] / 100)).toFixed(2); }
      else if(aGrpDscAmt[i] > 0){ aGrpNewAmt[i] = grptot - eval(aGrpDscAmt[i]); }
      else if(aGrpAmt[i] > 0){ aGrpNewAmt[i] = aGrpAmt[i]; }
      else{ aGrpNewAmt[i] = grptot; }

      aGrpOrig[i] = grptot;
      var cell = "tdGrpTot" + i;
      document.all[cell].innerHTML = aGrpNewAmt[i];

      cell = "tdGrpOrg" + i;
      document.all[cell].innerHTML = grptot.toFixed(2);
      
      // customer saves 
      cell = "tdGrpSave" + i;
      document.all[cell].innerHTML = (grptot - aGrpNewAmt[i]).toFixed(2);
      
   }
}
//==============================================================================
// calculate group retail price
//==============================================================================
function clcNewGrpItmRet()
{
   for(var i=0; i < MaxGrp; i++)
   {
      var prc = aGrpNewAmt[i] / aGrpOrig[i];
 
      for(var j=0; j < aGroup.length; j++)
      {
         if(aGroup[j] == i)
         {
            aGrpRetAmt[j] = (eval(Ret[aGrpSku[j]]) * prc).toFixed(4);
            aGrpRetObj[j].innerHTML = aGrpRetAmt[j];
            aGrpRetObj[j].style.color = "blue";
         }
      }
   }
   //aGrpNewAmt
}
//==============================================================================
// group all item
//==============================================================================
function grpAllItm()
{
   for(var i=0, k=0; i < Sku.length; i++)
   {
       for(var j=0; j < Qty[i]; j++)
       {
          var cb = "Grp" + i + "_" + j
          var cbobj = document.all[cb];
          if(!cbobj.checked && cbobj.style.display != "none"){ cbobj.checked = true; }
       }
   }
}
//==============================================================================
//close window and refresh order entry screen
//==============================================================================
function closeWin()
{
	try{ opener.location.reload();	} catch(err){  }  
	window.close();
}


</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<title>Patio Calculator</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0" width="90%">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Multiple Discounts - Calculator
      <br>Order: <%=sOrder%>
      </b>
     </td>
    </tr>
    <!-- ============ Grouping Items ================== -->
    <tr>
      <td ALIGN="center" VALIGN="TOP"  colspan="3" nowrap>&nbsp;<br>
       <span style="font-size:12px;font-weight:bold;">Item Grouping
         <br>Check mark all items in the furniture Group 
       <span>
       
       <table class="DataTable" border="1" cellPadding="0"  cellSpacing="0">
          <tr class="DataTable">
             <th class="DataTable">Short<br>SKU</th>
             <th class="DataTable">Description</th>
             <th class="DataTable">Retail</th>
             <th class="DataTable">Seq<br>#</th>
             <th class="DataTable">Group<br><button onclick="grpAllItm()" class="Small">All</button></th>
             <th class="DataTable">Qty</th>
          </tr>
          <!-- ============ Items ================== -->
          <%for(int i=0; i < iNumOfItm; i++){%>
             <%int iClr = i%2; String sClr=""; if(iClr > 0){sClr="1";}
               String sStyle = "";
               if(!sIpRet[i].equals(sRet[i])){ sStyle = "style=\"background: yellow;\""; }
             %>
             <tr class="DataTable<%=sClr%>">
               <td class="DataTable" id="tdSku<%=i%>" rowspan="<%=sQty[i]%>"><%=sSku[i]%></td>
               <td class="DataTable" rowspan="<%=sQty[i]%>"><%=sDesc[i]%></td>
               <td class="DataTable" rowspan="<%=sQty[i]%>" <%=sStyle%>>$<%=sRet[i]%></td>

               <%for(int j=0; j < Integer.parseInt(sQty[i]); j++){
                     ordent.setItemDisc(sOrder, sSku[i], Integer.toString(j+1));
                     ordent.getItemDisc();
                     String sItmGrp = ordent.getItmGrp();
                     String sItmNewRet = ordent.getItmNewRet();
               %>
                  <%if(j > 0){%><tr class="DataTable<%=sClr%>"><%}%>
                  <td class="DataTable1"><%=j+1%></td>
                  <td class="DataTable" nowrap><input class="Small1" type="checkbox" name="Grp<%=i%>_<%=j%>" value="<%=sItmGrp%>" size="3" maxlength=3>&nbsp;
                     <input name="SvItmGrp<%=i%>_<%=j%>" type="hidden" value="<%=sItmGrp%>">
                  </td>
                  <td class="DataTable1">1<input name="OrgRet<%=i%>_<%=j%>" type="hidden" value="<%=sItmNewRet%>"></td>
               <%}%>
             </tr>
          <%}%>
       </table>
       <button class="Small" onclick="setItmGrp()">Grouping</button> &nbsp; &nbsp;
       <!--button class="Small" onclick="rmvItmGrp()">Ungroup</button-->       
       &nbsp; &nbsp;
       </td>
      </tr>

    <!-- ============ Item Groups  ================== -->
    <tr>
      <td ALIGN="center" VALIGN="TOP"  colspan="3" nowrap>&nbsp;<br>
       <span style="font-size:12px;font-weight:bold;">Created Groups<span>
       <table class="DataTable" border="1" id="tblGrp" cellPadding="0"  cellSpacing="0">
          <tr class="DataTable">
             <th class="DataTable">Group</th>
             <th class="DataTable">Number<br>of<br>Items</th>
             <th class="DataTable">Sale</th>
             <th class="DataTable">Disc<br>%</th>
             <th class="DataTable">Disc<br>Amt</th>
             <th class="DataTable">Group<br>Price</th>
             <th class="DataTable">Error</th>
             <th class="DataTable">Group Total</th>
             <th class="DataTable">Discounted<br>Amount</th>

          </tr>
          <tbody id="tbdGrp">
            <%for(int i=0; i < iNumOfGrp; i++){%>
              <tr id="tdGrpRet<%=i%>"  class="DataTable">
                <td class="DataTable1"><%=sGrpNum[i]%><%%></td>
                <td class="DataTable1"><%=sGrpMax[i]%></td>
                <td class="DataTable" id="tdGrpOrg<%=i%>"><%=sGrpOrg[i]%></td>
                <td class="DataTable"><input class="Small" name="GrpDscPrc<%=i%>" size=10 maxlength=10
                     <%if(!sGrpDscPrc[i].equals(".00")){%>value="<%=sGrpDscPrc[i]%>"<%}%>>
                </td>
                <td class="DataTable"><input class="Small" name="GrpDscAmt<%=i%>" size=10 maxlength=10
                     <%if(!sGrpDscAmt[i].equals(".00")){%>value="<%=sGrpDscAmt[i]%>"<%}%>>
                </td>
                <td class="DataTable"><input class="Small" name="GrpNewGrp<%=i%>" size=10 maxlength=10
                     <%if(!sGrpNewAmt[i].equals(".00")){%>value="<%=sGrpNewAmt[i]%>"<%}%>>
                </td>
                <td class="DataTable" id="tdGrpErr<%=i%>">&nbsp;</td>
                <td class="DataTable2" id="tdGrpTot<%=i%>"><%=sGrpTot[i]%></td>
                <td class="DataTable2" id="tdGrpSave<%=i%>">&nbsp;</td>
              </tr>
              <script language="javascript">
                aGrpPrc[<%=i%>] = eval("<%=sGrpDscPrc[i]%>").toFixed(2);
                aGrpDscAmt[<%=i%>] = eval("<%=sGrpDscAmt[i]%>").toFixed(2);
                aGrpAmt[<%=i%>] = eval("<%=sGrpNewAmt[i]%>").toFixed(2);
                aGrpNewAmt[<%=i%>] = eval("0").toFixed(2);
              </script>
            <%}%>
          </tbody>
       </table>
       <button class="Small" id="btnGrpCalc" onclick="vldGrpRet()">Calculate</button> &nbsp; &nbsp;
     </td>
    </tr>

    <!-- ============ Individual Items ================== -->
    <tr>
      <td ALIGN="center" VALIGN="TOP"  colspan="3" nowrap>&nbsp;<br>
       <span style="font-size:12px;font-weight:bold;">Individual Items<span>
       <table class="DataTable" border="1" cellPadding="0"  cellSpacing="0">
          <tr class="DataTable">
             <th class="DataTable">Short<br>SKU</th>
             <th class="DataTable">Description</th>
             <th class="DataTable">Price as entered<br>On Order (% Disc)
             </th>
             <th class="DataTable">Group</th>
             <th class="DataTable">Seq<br>#</th>
             <th class="DataTable">Qty</th>
             
             <th class="DataTable">Disc<br>%</th>
             <th class="DataTable">Disc<br>Amt</th>
             <th class="DataTable">Upgrade<br>Amt</th>
             
             
             <th class="DataTable">Error</th>
             <th class="DataTable">New<br>Price</th>
             <th class="DataTable">Discounted<br>Amount</th>
          </tr>
          <!-- ============ Items ================== -->
          <%for(int i=0, k=0; i < iNumOfItm; i++){%>
             <%int iClr = i%2; String sClr=""; if(iClr > 0){sClr="1";}
               String sStyle = "";
               String sOrdPrice = sRet[i];
               if(!sIpRet[i].equals(sRet[i]))
               { 
            	   sStyle = "style=\"background: yellow;\"";
            	   BigDecimal bdRet = BigDecimal.valueOf(Double.parseDouble(sRet[i])); 
            	   BigDecimal bdIpRet = BigDecimal.valueOf(Double.parseDouble(sIpRet[i]));
            	   BigDecimal bd100 = new BigDecimal("100");
            	   BigDecimal bdDsc = bdRet.subtract(bdIpRet)
            			.divide(bdIpRet, 2, BigDecimal.ROUND_HALF_UP).multiply(bd100);   
            	   sOrdPrice = "(" 
            			+ bdDsc.toString() + "%"
            			+ "<br>$" + sRet[i]
            			+ ")"; 
               }
             %>
             <tr class="DataTable<%=sClr%>">
               <td class="DataTable" rowspan="<%=sQty[i]%>"><%=sSku[i]%></td>
               <td class="DataTable" rowspan="<%=sQty[i]%>"><%=sDesc[i]%></td>
               <td class="DataTable2" rowspan="<%=sQty[i]%>" <%=sStyle%>>$<%=sOrdPrice%></td>

               <script language="javascript">
                 ItmNewRet[<%=i%>] = new Array();
                 ItmCustSave[<%=i%>] = new Array();
               </script>

               <%for(int j=0; j < Integer.parseInt(sQty[i]); j++){
                     ordent.setItemDisc(sOrder, sSku[i], Integer.toString(j+1));
                     ordent.getItemDisc();
                     String sItmGrp = ordent.getItmGrp();
                     String sItmDscAmt = ordent.getItmDscAmt();
                     String sItmDscPrc = ordent.getItmDscPrc();
                     String sItmUpgAmt = ordent.getItmUpgAmt();
                     String sItmNewRet = ordent.getItmNewRet();
                     
                     if(sItmNewRet.equals(".00")){sItmNewRet = sRet[i]; }
                     if(sItmDscAmt.equals(".0000")){sItmDscAmt = "";}
                     if(sItmUpgAmt.equals(".0000")){sItmUpgAmt = "";}
                     if(sItmDscPrc.equals(".0000")){sItmDscPrc = "";}
                     String sDiscStyle = "";
                     System.out.println("sIpRet=" + sIpRet[i] + " sItmNewRet=" + sItmNewRet);
                     if(!sIpRet[i].equals(sItmNewRet)){sDiscStyle = "style='background: yellow;'";}
               %>
               <script language="javascript">
                 ItmNewRet[<%=i%>][<%=j%>] = "<%=sItmNewRet%>";
                 ItmCustSave[<%=i%>][<%=j%>] = "";
               </script>

                  <%if(j > 0){%><tr class="DataTable<%=sClr%>"><%}%>
                  <td class="DataTable1" id="tdGrpNum<%=k++%>">None</td>
                  <td class="DataTable1"><%=j+1%></td>
                  <td class="DataTable1">1</td>                  
                  <td class="DataTable"><input class="Small" name="DscPrc<%=i%>_<%=j%>" value="<%=sItmDscPrc%>" size="10" maxlength=10>%</td>
                  <td class="DataTable">$<input class="Small" name="DscAmt<%=i%>_<%=j%>" value="<%=sItmDscAmt%>" size="10" maxlength=10></td>
                  <td class="DataTable">$<input class="Small" name="UpgAmt<%=i%>_<%=j%>" value="<%=sItmUpgAmt%>" size="10" maxlength=10></td>                                    
                  <td class="DataTable3" id="Err<%=i%>_<%=j%>"></td>
                  <td class="DataTable2" id="NewRet<%=i%>_<%=j%>"><%=sItmNewRet%></td>
                  <td class="DataTable2" id="CustSave<%=i%>_<%=j%>">&nbsp;</td>
               <%}%>
             </tr>
          <%}%>
          <!-- =========== Total ============= -->
          <tr class="DataTable2">
             <td class="DataTable2" colspan=2>Total:</td>
             <td class="DataTable" id="TotOrgRet">&nbsp;</td>
             <td class="DataTable2" colspan=7>Total:</td>
             <td class="DataTable2" id="TotNewRet">&nbsp;</td>
             <td class="DataTable2" id="TotCustSave">&nbsp;</td>
          </tr>
       </table>
       <button class="Small" id="btnClc" onclick="vldNewRet('C')">Calculate Discounts</button> &nbsp; &nbsp;
       <button class="Small" id="btnSave" onclick="vldNewRet('S')">Save Discounts</button> &nbsp; &nbsp;
       <button class="Small" id="btnClose" onclick="closeWin()">Close</button> &nbsp; &nbsp;
       <br><br><button class="Small" id="btnReset" onclick="clearAll()">Remove - All</button>
      </td>
    </tr>
  </table>
  
<%
  ordent.disconnect(); ordent = null;
%>







