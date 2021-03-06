<%@ page import="patiosales.PfQuoteLst ,java.util.*, java.text.*, rciutility.FormatNumericValue"%>
<%
   String [] sStatus = request.getParameterValues("Status");
   String sInclSO = request.getParameter("InclSO");
   String [] sCommType = request.getParameterValues("CommType");

   String sFrOrdDate = request.getParameter("FrOrdDt");
   String sToOrdDate = request.getParameter("ToOrdDt");  

   String sRRN = request.getParameter("RRN");
   String sSort = request.getParameter("Sort");
   String sSelCust = request.getParameter("Cust");
   String sSlsPer = request.getParameter("SlsPer");
   String sSelOrd = request.getParameter("Order");

   String [] sStrGrp = request.getParameterValues("StrGrp");
   String [] sStrTrf = request.getParameterValues("StrTrf");

   String sClaimOnly = request.getParameter("ClaimOnly");

   if(sSelCust==null){ sSelCust = " ";}
   if(sSlsPer==null) { sSlsPer = " "; }
   if(sSelOrd==null){ sSelOrd = " "; }
   if(sRRN==null) { sRRN="0000000000"; }
   if(sSort==null) { sSort="CUSTNM"; }
   if(sStatus == null) { sStatus = new String[]{" "}; }
   if(sCommType == null){ sCommType = new String[]{" "}; }
   if(sClaimOnly == null) { sClaimOnly = " "; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PfQuoteLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      //System.out.println("\n" + sStrGrp + "| Status " + sStatus[0] + "| sInclSO " + sInclSO + "| CommType " + sCommType[0] + "|" + sFrOrdDate
      //  + "|" + sToOrdDate + "|" + sSku + "|" + sRRN + "|" + sSort + "|" + sStsOpt);
      PfQuoteLst ordlst = new PfQuoteLst(sStrGrp, sStrTrf, sStatus, sCommType
        , sInclSO, sFrOrdDate, sToOrdDate, sRRN, sSort, sSelCust, sSlsPer, sSelOrd
        , session.getAttribute("USER").toString());
      int iNumOfOrd = ordlst.getNumOfOrd();
      String sRepTotal = ordlst.getRepTotal();

      String sStatusJsa = ordlst.cvtToJavaScriptArray(sStatus);
      String sCommTypeJsa = ordlst.cvtToJavaScriptArray(sCommType);

      String sUser = session.getAttribute("USER").toString();
      boolean bSts = true;
      if  (sUser.trim().equals("cashr35") || sUser.trim().equals("cashr46")
       ||  sUser.trim().equals("cashr50") ||  sUser.trim().equals("cashr86")
       ||  sUser.trim().equals("cashr63") ||  sUser.trim().equals("cashr64")
       ||  sUser.trim().equals("cashr68") ||  sUser.trim().equals("cashr55")) bSts = false;

      String sUsrStr = session.getAttribute("STORE").toString();
      boolean bAllowGmPrc = session.getAttribute("PATGMP") != null;

      // statuses and names for order and spec order
      ordlst.setStsLst();
      String sStsLst = ordlst.getStsLstJsa();
      String sStsNmLst = ordlst.getStsNmLstJsa();

      // format Numeric value
      FormatNumericValue fmt = new FormatNumericValue();
      
%>

<html>
<head>
<title>Patio_Furniture_Sales_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        
        table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
 		table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
        
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:left; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable4 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right; font-size:11px; font-weight:bold;}
                        
        td.DataTable5 { background:#FFCC99; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}                

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background: #016aab;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        
        .FollowUp01 { color:blue; }
        .FollowUp02 { background:yellow; }
        .FollowUp03 { color:red; }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var User = "<%=sUser%>";
var RecUsr = ["dmikulan", "kknight", "psnyder", "vrozen"];

var Status = [<%=sStatusJsa%>]
var CommType = [<%=sCommTypeJsa%>]

var NumOfOrd = <%=iNumOfOrd%>
var StrGrp = new Array();
<%for(int i=0; i < sStrGrp.length; i++){%>StrGrp[<%=i%>] = "<%=sStrGrp[i]%>";<%}%>
var StrTrf = new Array();
<%for(int i=0; i < sStrTrf.length; i++){%>StrTrf[<%=i%>] = "<%=sStrTrf[i]%>";<%}%>

var blockCell = "table-cell";
var blockRow = "table-row";

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ blockCell="block"; blockRow="block"; }
	
	showStrTrfCol();

    setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}

//==============================================================================
// show/hide store transfer column depend on store group selection
//==============================================================================
function showStrTrfCol()
{
  var schl = document.all.colSkiChl;
  var sstp = document.all.colSkiStp;
  if (StrGrp == "SKCH")
  {
     for(var i=0; i < sstp.length; i++)  {  sstp[i].style.display = "none"; }
  }
  else if (StrGrp == "SSTP")
  {
     for(var i=0; i < schl.length; i++)  {  schl[i].style.display = "none"; }
  }
}
//==============================================================================
// show screen with different sorting
//==============================================================================
function sortBy(sort)
{
  var url = "PfQuoteLst.jsp?FrOrdDt=<%=sFrOrdDate%>&ToOrdDt=<%=sToOrdDate%>"

  for(var i=0; i < Status.length; i++)
  {
     url += "&Status=" + Status[i];
  }

  for(var i=0; i < CommType.length; i++)
  {
     url += "&CommType=" + CommType[i];
  }

  url += "&InclSO=<%=sInclSO%>" + "&Sort=" + sort
       + "&Cust=<%=sSelCust%>"
       + "&SlsPer=<%=sSlsPer%>"

  for(var i=0; i < StrGrp.length; i++){url += "&StrGrp=" + StrGrp[i]}
  for(var i=0; i < StrTrf.length; i++){url += "&StrTrf=" + StrTrf[i]}

  //alert(url);
  window.location.href=url;
}

//==============================================================================
// Change Order Status
//==============================================================================
function chgOrdSts(ord, sts)
{
   //check if order is paid off
   var hdr = "Change Order Status. Order:&nbsp;&nbsp;" + ord;

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStsPanel(ord, sts)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}   
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popStsPanel(ord, sts)
{
  var posX = getLeftScreenPos() + 600;
  var posY = getTopScreenPos() + 60;

  var panel = "<table  class='tbl02'>"
     panel += "<tr id='trSel'><td class='Prompt' width='10%'>New Status:</td>"
           + "<td class='Prompt'><select class='Small' name='NewSts' size=1>"
              + setNextSts(sts)
           + "</select></td>"
         + "</tr>"

         + "<tr id='trSel'><td class='Prompt'>Emp#:</td>"
            + "<td class='Prompt'><input class='Small' name='Emp' size=4 maxlength=4></td>"
         + "</tr>"

         + "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap colspan=2><textarea name='txaComment' id='txaComment' cols=50 rows=4></textarea></td>"
              + "</td>"
         + "</tr>"

         + "<tr><td style='font-color:red; font-size:14px' id='tdErrMsg' colspan=2 nowrap></td></tr>"

      panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
      + "<button onClick='vldNewSts(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// set Next Status
//==============================================================================
function setNextSts(sts)
{
   var panel = null;
   if(sts=="Q"){ panel += "<option value='E'>Close</option>" }
   if(sts=="E"){ panel += "<option value='Q'>Quote (Reactivate)</option>" }

   return panel;
}
//==============================================================================
// check new status
//==============================================================================
function chkNewSts(sel)
{
  if(sel[sel.selectedIndex].value!="O")
  {
     document.all.trReg.style.display = blockRow;
     document.all.trTrans.style.display = blockRow;
  }

  if(sel[sel.selectedIndex].value!="F")
  {
     document.all.Reg.readOnly=true;
     document.all.Trans.readOnly=true;
  }
  else
  {
     document.all.Reg.readOnly=false;
     document.all.Reg.focus();
     document.all.Trans.readOnly=false;
  }
}
//==============================================================================
// validate new status
//==============================================================================
function vldNewSts(ord)
{
   var error = false;
   var msg = "";
   document.all.tdErrMsg.innerHTML="";
   document.all.tdErrMsg.style.color="red";

   var empnum = document.all.Emp.value.trim();
   if(empnum == "" || isNaN(empnum))
   {
      error = true; msg += "Please enter correct employee number.";
   }

   var commt = document.all.txaComment.value.trim();
   var sts = document.all.NewSts.options[document.all.NewSts.selectedIndex].value;

   if(error){ document.all.tdErrMsg.innerHTML=msg; }
   else{sbmNewSts(ord, empnum, sts, commt)}
}
//==============================================================================
// submit new status
//==============================================================================
function sbmNewSts(ord, empnum, sts, commt)
{
   commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = "";
	
    if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
    else{ nwelem = window.frame1.contentDocument.createElement("div");}
   
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmChgSts'"
       + " METHOD=Post ACTION='OrderHdrSave.jsp'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Sts'>"
       + "<input class='Small' name='EmpNum'>"
       + "<input class='Small' name='Comments'>"
       + "<input class='Small' name='CommtType'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame1.document.body.appendChild(nwelem);}  
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
   {
	   window.frame1.document.all.Order.value = ord;
	   window.frame1.document.all.Sts.value=sts;
	   window.frame1.document.all.EmpNum.value=empnum;
	   window.frame1.document.all.Comments.value=commt;
	   window.frame1.document.all.CommtType.value="USER";
	   window.frame1.document.all.Action.value="CHGSTS";
	   window.frame1.document.frmChgSts.submit();   
   }
   else
   {
	   window.frame1.contentDocument.forms[0].Order.value = ord;
	   window.frame1.contentDocument.forms[0].Sts.value=sts;
	   window.frame1.contentDocument.forms[0].EmpNum.value=empnum;
	   window.frame1.contentDocument.forms[0].Comments.value=commt;
	   window.frame1.contentDocument.forms[0].CommtType.value="USER";
	   window.frame1.contentDocument.forms[0].Action.value="CHGSTS";
	   window.frame1.contentDocument.forms[0].submit();   
   }
	  
}
//==============================================================================
// Change Special Order Status
//==============================================================================
function chgSoSts(ord, sts)
{
   var hdr = "Change Special Order Status. Order:&nbsp;&nbsp;" + ord;

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popSoStsPanel(ord, sts)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popSoStsPanel(ord, sosts)
{
  var posX = getLeftScreenPos() + 600;
  var posY = getTopScreenPos() + 60;

  var panel = "<table class='tbl02'>"
     panel += "<tr id='trSel'><td class='Prompt'>New Status:</td>"
           + "<td class='Prompt'><select class='Small' name='NewSoSts' size=1>"
             + setNewSoSts(sosts)
           + "</select></td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
      + "<button onClick='sbmNewSoSts(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// set new special order status
//==============================================================================
function setNewSoSts(sosts)
{
   var panel = null;
   if(sosts == "N") panel = "<option value='A'>Approved</option>"
   if(sosts == "A") panel = "<option value='N'>Non-Approved</option>"

   return panel;
}
//==============================================================================
// submit new special order status
//==============================================================================
function sbmNewSoSts(ord)
{
   var sts = document.all.NewSoSts.value;

   var url = "OrderHdrSave.jsp?Order=" + ord
           + "&Sts=" + sts
           + "&Action=CHGSOSTS"
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
   hidePanel();
}
//==============================================================================
// show comments and add new panel
//==============================================================================	
function showCommtPanel(ord, cmtty, ven, ponum, str, lname, fname, total, ordtype, expdt)
{
   var hdr = "Order Comments. Order:&nbsp;&nbsp;" + ord;

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCmtLogPanel(ord, ponum, str, lname, fname, total, ordtype, expdt)
      + "</td></tr>"

    + "<tr><td class='Prompt' colspan=2 id='tdCmtLog'>"
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 200;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.width= 700;
   document.all.dvStatus.style.visibility = "visible";

   getOrdNote(ord, "CMT");

   document.all.spnStep1.style.display="none";
   document.all.spnStep2.style.display="none";
   document.all.spnStep3.style.display="none";
   
   document.all.tdEmailAddr.style.display="none";
   document.all.tdSubj.style.display = "none";
   
   var iOpt = 0; 
   document.all.selEmailAddr.options[iOpt++] = new Option("--- Select email address ---", "NONE"); 
   document.all.selEmailAddr.options[iOpt++] = new Option("Dale Mikulan", "DMikulan@sunandski.com");
   document.all.selEmailAddr.options[iOpt++] = new Option("Matt Williams", "MWilliams@sunandski.com");   
   document.all.selEmailAddr.options[iOpt++] = new Option("Kelly Knight", "kknight@sunandski.com");
   document.all.selEmailAddr.options[iOpt++] = new Option("Polly Snyder", "psnyder@sunandski.com");
   document.all.selEmailAddr.options[iOpt++] = new Option("Vadim Rozen", "vrozen@sunandski.com");
   
   var toAddrNm = "Store" + str;
   var toAddr = "Store" + str + "@sunandski.com";
   document.all.selEmailAddr.options[iOpt++] = new Option(toAddrNm, toAddr);
   
   if (cmtty =="VCN")
   {
     document.all.CmtTy[5].checked = true;
     document.all.PoNum.value = ponum;
     document.all.Ven.value = ven;
     document.all.tdQuo.style.display = "none";
   }
   else if (cmtty =="QST1")
   {
     document.all.CmtTy[0].checked = true;
     document.all.tdVenConf.style.display = "none";
     document.all.spnStep1.style.display="block";
   }
   else if (cmtty =="QST2")
   {
     document.all.CmtTy[1].checked = true;
     document.all.tdVenConf.style.display = "none";
     document.all.spnStep2.style.display="block";
   }
   else if (cmtty =="QST3")
   {

     document.all.CmtTy[2].checked = true;
     document.all.tdVenConf.style.display = "none";
     document.all.spnStep3.style.display="block";
   }
   else
   {
     document.all.tdVenConf.style.display = "none";
     document.all.CmtTy[3].checked = true;
     document.all.tdQuo.style.display = "none";
     document.all.spnStep1.style.display="block";
   }
}
//==============================================================================
// get Order comments
//==============================================================================
function popCmtLogPanel(ord, ponum, str, lname, fname, total, ordtype, expdt)
{
  var posX = getLeftScreenPos() + 950;
  var posY = getTopScreenPos() + 100;

  var panel = "<table class='tbl02'>"
  panel += "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap colspan=2>"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='QST1'>1st Step"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='QST2'>2nd Step"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='QST3'>3rd Step"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='STORE'>Store's"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='BUYER'>Buyer's &nbsp; &nbsp; &nbsp;"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='VCN'>Vendor Confirmation &nbsp; &nbsp; &nbsp;"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='EMAIL'>E-Mail &nbsp; &nbsp; &nbsp;"
                
                + "<input name='Order' type='hidden' value='" + ord + "'>"
                + "<input name='Store' type='hidden' value='" + str + "'>"
                + "<input name='LName' type='hidden' value='" + lname + "'>"
                + "<input name='FName' type='hidden' value='" + fname + "'>"
                + "<input name='Total' type='hidden' value='" + total + "'>"
                + "<input name='OrdType' type='hidden' value='" + ordtype + "'>"
                + "<input name='ExpDt' type='hidden' value='" + expdt + "'>"
              + "</td>"
         +  "</tr>"

         + "<tr class='DataTable' id='tdVenConf'>"
              + "<td class='DataTable' nowrap colspan=2>"
                + "Vendor: <input name='Ven' size=5 readonly> &nbsp; &nbsp; &nbsp;"
                + "Confirmation Number: <input name='VenConf'  size=20 maxsize=20>"
                + "<br>P.O.Number: <input name='PoNum' size=10 readonly> &nbsp; &nbsp; "
                + "Vendor Delivery Date Date: "
                + "<input class='Small' name='VenDelDate' readonly size=10 maxlength=10> &nbsp; &nbsp;"
                + "<a class='Small' id='shwCal' href='javascript:showCalendar(1, null, null," + posX + "," + posY + ", document.all.VenDelDate)' >"
                + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
              + "</td>"
         +  "</tr>"

         + "<tr class='DataTable' id='tdQuo'>"
              + "<td class='DataTable' nowrap colspan=2>"
                + "Employee #: <input name='Emp' size=4> &nbsp; &nbsp; &nbsp;"
              + "</td>"
         +  "</tr>"

         + "<tr class='DataTable' id='tdSubj'>"
    	     + "<td class='DataTable' nowrap>Subject: "
      	         + "<input class='Small' name='Subj' size='50' maxlength='50'> &nbsp; &nbsp;"
    	     + "</td>"
   		 +  "</tr>"         
         
         + "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap><textarea name='txaComment' id='txaComment' cols=50 rows=4></textarea></td>"
              + "<td class='DataTable'><u>Example:</u>"
                + "<span id='spnStep1'>I called the customer on 4/29 at 8pm, to thank them for coming in, they said..</span>"
                + "<span id='spnStep2'>I sent a Thank you card (or emailed the customer) on 4/29/13.</span>"
                + "<span id='spnStep3'>I called the customer to communicate that we would like to earn their business, they said..</span>"
              + "</td>"
         + "</tr>"
         + "<tr class='DataTable'>"
            + "<td class='DataTable' id='tdEmailAddr' nowrap>" 
                + "<input name='EmailAddr' maxlength=50 size=50>"
                + "<br><select class='Small' name='selEmailAddr' onchange='setEmailAddr(this)'></select>"
            + "</td>"
         + "</tr>"
         + "<tr class='DataTable6'><td class='DataTable' id='tdErrMsg' nowrap colspan=2></td></tr>"
  panel += "<tr><td class='DataTable2' colspan=2>"
        + "<button onClick='vldNewComment();' class='Small1'>Submit</button> &nbsp; &nbsp;"
        + "<button onClick='hidePanel();' class='Small1'>Close</button> &nbsp; &nbsp;"        
        + "</td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// change comment panel
//==============================================================================
function chgCommt(obj)
{
   if(obj.value == "VCN"){document.all.tdVenConf.style.display = blockCell;}
   else { document.all.tdVenConf.style.display = "none"; }
   
   if(obj.value == "EMAIL") 
   { 
	    document.all.tdEmailAddr.style.display=blockCell;
	    document.all.tdSubj.style.display = blockCell;
   } 
   else
   { 
	   document.all.tdSubj.style.display = "none";
	   document.all.tdEmailAddr.style.display="none";   
   }

   document.all.spnStep1.style.display="none";
   document.all.spnStep2.style.display="none";
   document.all.spnStep3.style.display="none";
   document.all.tdQuo.style.display = "none";
   
   if(obj.value == "QST1"){document.all.spnStep1.style.display="block"; document.all.tdQuo.style.display = blockCell;}
   if(obj.value == "QST2"){document.all.spnStep2.style.display="block"; document.all.tdQuo.style.display = blockCell;}
   if(obj.value == "QST3"){document.all.spnStep3.style.display="block"; document.all.tdQuo.style.display = blockCell;}
}
//==============================================================================
// validate New Comment
//==============================================================================
function vldNewComment()
{
   var error = false;
   var msg = "";
   document.all.tdErrMsg.innerHTML="";
   document.all.tdErrMsg.style.color="red";

   var order = document.all.Order.value;
   var cmtty = null;
   var empnum = "";

   for(var i=0; i < document.all.CmtTy.length; i++)
   {
       if(document.all.CmtTy[i].checked){ cmtty = document.all.CmtTy[i].value; break; }
   }

   var cmt = document.all.txaComment.value;
   var br = "";

   if(cmtty=="VCN")
   {
      var ven = document.all.Ven.value.trim();
      if(ven == "" || isNaN(ven) || eval(ven) <= 0 || eval(ven) < 999 )
      {
         error = true; msg += br + "Please enter correct vendor number.";
         br = "<br>";
      }
      var conf = document.all.VenConf.value.trim();
      if(conf==""){error = true; msg += br + "Please enter confirmation number."; br = "<br>";}

      var deldt = document.all.VenDelDate.value.trim();
      if(deldt == ""){ error = true; msg += br + "Please enter Vendor Delivery Date."; br = "<br>"; }
      var ponum = document.all.PoNum.value.trim();

      if(!error)
      {
         cmt = "Vendor: " + ven
             + ", P.O. # " + ponum
             + ", Delivery Date: " + deldt
             + ", Conf# " + conf + ". " + cmt.trim();
         br = "<br>";
      }
   }

   if(cmtty.substring(0,3)=="QST")
   {
      var empnum = document.all.Emp.value.trim();
      if(empnum == "" || isNaN(empnum))
      {
         error = true; msg += br + "Please enter correct employee number.";
         br = "<br>";
      }
      if(!error)
      {
         cmt = "Emp#: " + empnum + ". " + cmt.trim();
      }
   }

   if(cmt==""){error = true; msg += br + "Please enter comment.";br = "<br>";}
   
   // -------------- Email -------------------
   var str = document.all.Store.value;
   var lname = document.all.LName.value;
   var fname = document.all.FName.value;
   var total= document.all.Total.value;
   var ordtype = document.all.OrdType.value;
   var expdt = document.all.ExpDt.value; 

   var frAddr = "";   
   var toaddr = "";
   var subj = "";    
   var body = cmt;
   if(cmtty=="EMAIL")
   {
	   frAddr = "Store" + str + "@sunandski.com"
	   for(var i=0; i < RecUsr.length; i++)
	   {
		   if(User == RecUsr[i]){ frAddr =  RecUsr[i] + "@sunandski.com"; break; } 
	   }
	   toaddr = document.all.EmailAddr.value.trim();
	   if(toaddr == ""){error = true; msg += br + "Please enter Email recipient address.";br = "<br>";}
	   
	   subj = "Quote: " + order + " Comments: ";
	   var s = document.all.Subj.value.trim();
	   
	   if (document.all.Subj.value.trim() == "")
	   {		   
			if(cmt.length < 30){ subj += body; }
			else{ subj += body.substring(0, 30) + "..."; }   
	   }
	   else { subj += document.all.Subj.value.trim(); }
	   cmt = "Emailed " + subj + ". From " + frAddr + ". " + body;	   
   }
   
   if(error){ document.all.tdErrMsg.innerHTML=msg; }
   else{sbmNewComment(order, cmtty, cmt, empnum, str, frAddr, toaddr, lname, fname, total, ordtype, expdt, subj, body)}
}
//==============================================================================
// submit New Comment
//==============================================================================
function sbmNewComment(order, cmtty, commt, empnum, str, frAddr, toaddr, lname, fname, total, ordtype, expdt, subj, body)
{
    commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = "";
	
    if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
    else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='OrderHdrSave.jsp'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Comments'>"
       + "<input class='Small' name='CommtType'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame1.document.body.appendChild(nwelem); }  
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
   {
	   window.frame1.document.all.Order.value = order;
	   window.frame1.document.all.Comments.value=commt;
	   window.frame1.document.all.CommtType.value=cmtty;
	   window.frame1.document.all.Action.value="ADDCOMMENT";
	   window.frame1.document.frmAddComment.submit();
   }
   else
   {
	   window.frame1.contentDocument.forms[0].Order.value = order;
	   window.frame1.contentDocument.forms[0].Comments.value=commt;
	   window.frame1.contentDocument.forms[0].CommtType.value=cmtty;
	   window.frame1.contentDocument.forms[0].Action.value="ADDCOMMENT";
	   window.frame1.contentDocument.forms[0].submit();
   }
   
   sbmEMail(frAddr, toaddr, order, body, str, lname, fname, total, ordtype, expdt, subj)
}

//==============================================================================
//email Order
//==============================================================================
function sbmEMail(frAddr,toaddr, order, commt, str, lname, fname, total, ordtype, expdt, subj)
{    		
	commt = commt.replace(/\n\r?/g, '<br />');
	
	var body = getMsgBody(order, commt, str, lname, fname, total, ordtype, expdt);
	
	var nwelem = "";
	
    if(isIE){ nwelem = window.frame2.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame2.document.createElement("div"); }
    else{ nwelem = window.frame2.contentDocument.createElement("div");}
	
    nwelem.id = "dvSbmCommt"

	var html = "<form name='frmSendEmail'"
     + " METHOD=Post ACTION='WarrantyClaimSendEMail.jsp'>"
     + "<input class='Small' name='MailAddr'>"
     + "<input class='Small' name='CCMailAddr'>"
     + "<input class='Small' name='FromMailAddr'>"
     + "<input class='Small' name='Subject'>"
     + "<input class='Small' name='Message'>";
     
	html += "</form>"

	nwelem.innerHTML = html;
	frmcommt = document.all.frmEmail;
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame2.document.appendChild(nwelem); }
	else if(isIE){ window.frame2.document.body.appendChild(nwelem); }
	else if(isSafari){window.frame2.document.body.appendChild(nwelem); } 
	else{ window.frame2.contentDocument.body.appendChild(nwelem); }

	if(isIE || isSafari)
	{
		window.frame2.document.all.Subject.value = subj;
		window.frame2.document.all.Message.value = body;
		window.frame2.document.all.MailAddr.value = toaddr;
		window.frame2.document.all.CCMailAddr.value = "GM" + str + "@sunandski.com";
		window.frame2.document.all.FromMailAddr.value = frAddr;
		window.frame2.document.frmSendEmail.submit();
	}
	else
	{
		window.frame2.contentDocument.forms[0].Subject.value = subj;
		window.frame2.contentDocument.forms[0].Message.value = body;
		window.frame2.contentDocument.forms[0].MailAddr.value = toaddr;
		window.frame2.contentDocument.forms[0].CCMailAddr.value = "GM" + str + "@sunandski.com";
		window.frame2.contentDocument.forms[0].FromMailAddr.value = frAddr;
		window.frame2.contentDocument.forms[0].submit();
	}
}
//==============================================================================
//get message body
//==============================================================================
function getMsgBody(order, commt, str, lname, fname, total, ordtype, expdt)
{
var body = "";
body += "<table style='font-family:Arial; font-size:10px; width:100%;' >"

	   + "<tr><td style='text-align:left'>" + commt + "</td><tr>"
	   + "<tr><td style='text-align:left'>"
	      + "<table style='border: darkred solid 1px; font-family:Arial; font-size:10px; width:100%;'>"
			  + "<tr><td style='font-weight:bold'><b><i>Sun & Ski</></b></th></tr>"
			  + "<tr><td style='font-weight:bold'>Order: <a href='http://rciweba.retailconcepts.cc/OrderEntry.jsp?Order=" + order + "&List=Y'>" + order  + "</a></td></tr>"
			  + "<tr><td style='font-weight:bold'>Type: " + ordtype  + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Store:" + str  + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Customer: " + lname + ", " + fname + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Total: $" + total  + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Expiration Date: " + expdt  + "</td></tr>"
	      + "</table><br>"
	   + "</td><tr>"

	body += "</table>";   
	   
	body += "</td></tr></table>"
	
 return body;			
}


//==============================================================================
// show comments and add new panel
//==============================================================================
function showCommtLst(ord, cmtty)
{
   var hdr = "Order Comments. Order:&nbsp;&nbsp;" + ord;

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"

    + "<tr><td class='Prompt' colspan=2 id='tdCmtLog'></td></tr>"
    + "<tr><td class='Prompt1' colspan=2 id='tdButtons'><button onClick='hidePanel();' class='Small1'>Close</button></td></tr>"

   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 200;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.width= 700;
   document.all.dvStatus.style.visibility = "visible";

   getOrdNote(ord, "CMT");
}

//==============================================================================
//set selected email address line
//==============================================================================
function setEmailAddr(sel)
{
	document.all.EmailAddr.value = sel.options[sel.selectedIndex].value; 
}
//==============================================================================
// get Order comments
//==============================================================================
function getOrdNote(ord, type)
{
   var url = "PfsOrderComment.jsp?Order=" + ord
           + "&Type=" + type
           + "&Filter=QST"
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// show Comments
//==============================================================================
function showComments(html)
{
    document.all.tdCmtLog.innerHTML = html;
    //document.all.chkFltr[0].checked = false;
    document.all.chkFltr[0].click();
    document.all.chkFltr[1].click();
    document.all.chkFltr[2].click();
    document.all.chkFltr[3].click();
    document.all.chkFltr[4].click();
}

//==============================================================================
// set comment/log filter
//==============================================================================
function setCmtFilter(cmtty, chkbox, numcmt)
{
   var disp = "none";
   if(chkbox.checked){ disp = blockRow;}

   for(var i=0; i < numcmt; i++)
   {
      var cell = "tdCmtTy" + i;
      var type = document.all[cell].innerHTML.trim();
      var rownm = "trCmtLog" + i;
      var row = document.all[rownm];
      for(var j=0; j < cmtty.length; j++)
      {
          if(type == cmtty[j]){ row.style.display=disp; }
      }
   }
}

//==============================================================================
// display error
//==============================================================================
function displayError(err)
{
   window.frame1.location.href="";
   window.frame1.close();
   msg = "";
   for(var i=0; i < err.length; i++)  {  msg += err[i] + "\n"; }
   alert(msg);
}
//==============================================================================
// restart application after heading entry
//==============================================================================
function reStart()
{   
   window.location.reload();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// show Delivery Date Inquery screen
//==============================================================================
function showDelDateInq(area)
{
   var url = null;
   if(area == "DC"){ url = "PfOrdDeliveryCal.jsp?Store=35&Store=46&Store=50";}
   else if(area == "NY"){ url = "PfOrdDeliveryCal.jsp?Store=86";}
   else if(area == "NE"){ url = "PfOrdDeliveryCal.jsp?Store=55&Store=63&Store=64&Store=68";}

   var WindowName = 'Delivery_Date_Inquiry';
   var WindowOptions = 'resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=yes';

  //alert(url);
  window.open(url, WindowName, WindowOptions);

}
//==============================================================================
// show Status Stamp
//==============================================================================
function showStsStamp()
{
   if (document.all.spStsStamp[0] != null)
   {
      for(var i=0; i < document.all.spStsStamp.length; i++)
      {
        if(document.all.spStsStamp[i].style.display=="none") document.all.spStsStamp[i].style.display = "block";
        else document.all.spStsStamp[i].style.display = "none";
      }
   }
   else
   {
      if(document.all.spStsStamp.style.display=="none") document.all.spStsStamp.style.display = "block";
      else document.all.spStsStamp.style.display = "none";
   }
}
//==============================================================================
// show Status Stamp
//==============================================================================
function showPyStsStamp()
{
   if (document.all.spPyStsStamp[0] != null)
   {
      for(var i=0; i < document.all.spPyStsStamp.length; i++)
      {
        if(document.all.spPyStsStamp[i].style.display=="none")
        {
          document.all.spPyStsStamp[i].style.display = "block";
        }
        else document.all.spPyStsStamp[i].style.display = "none";
      }
   }
   else
   {
      if(document.all.spPyStsStamp.style.display=="none")
      {
         document.all.spPyStsStamp.style.display = "block";
      }
      else document.all.spPyStsStamp.style.display = "none";
   }
}

//==============================================================================
// show Special Order Status Stamp
//==============================================================================
function showSoStsStamp()
{
   if (document.all.spSoStsStamp1[0] != null)
   {
      for(var i=0; i < document.all.spSoStsStamp1.length; i++)
      {
        if(document.all.spSoStsStamp1[i].style.display=="none")
        {
           document.all.spSoStsStamp1[i].style.display = "block";
           document.all.spSoStsStamp2[i].style.display = "block";
           document.all.spSoStsStamp3[i].style.display = "block";
        }
        else
        {
           document.all.spSoStsStamp1[i].style.display = "none";
           document.all.spSoStsStamp2[i].style.display = "none";
           document.all.spSoStsStamp3[i].style.display = "none";
        }
      }
   }
   else
   {
      if(document.all.spSoStsStamp1.style.display=="none")
      {
         document.all.spSoStsStamp1.style.display = "block";
         document.all.spSoStsStamp2.style.display = "block";
         document.all.spSoStsStamp3.style.display = "block";
      }
      else
      {
         document.all.spSoStsStamp1.style.display = "none";
         document.all.spSoStsStamp2.style.display = "none";
         document.all.spSoStsStamp3.style.display = "none";
      }
   }
}


//==============================================================================
// set P.O. Vendor's Delivery Date
//==============================================================================
function setPoDelDate(ord, ven, ponum, deldt)
{
   var hdr = "Customer Order:&nbsp;" + ord + "&nbsp; &nbsp;";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPoDelDate(ord, ven, ponum)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(deldt != ""){document.all.DelDate.value = deldt}
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPoDelDate(ord, ven, ponum)
{
  var posX = getLeftScreenPos() + 650;
  var posY = getTopScreenPos() + 100;

  var panel = "<table class='tbl02'>"
  panel += "<tr id='trSel'><td class='Prompt'>&nbsp; Vendor:</td>"
             + "<td class='Prompt'>" + ven + "</td></tr>"
           + "<tr id='trSel'><td class='Prompt'>&nbsp; P.O. Number:</td>"
             + "<td class='Prompt'>" + ponum + "</td></tr>"

           + "<tr id='trSel'><td class='Prompt' nowrap><br>&nbsp; Vendor Delivery Date Date:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='DelDate' readonly size=10 maxlength=10> &nbsp; &nbsp;"
             + "<a class='Small' id='shwCal' href='javascript:showCalendar(1, null, null," + posX + "," + posY + ", document.all.DelDate)' >"
             + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' id='tdButton' colspan='2'><br><br>"
      + "<button onClick='sbmVenDelDt(&#34;" + ord + "&#34;, &#34;" + ven + "&#34;, &#34;" + ponum + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// submit new special order status
//==============================================================================
function sbmVenDelDt(ord, ven, ponum)
{
   var deldt = document.all.DelDate.value.trim(" ");
   var msg = "";
   var error = false;
   if(deldt == ""){error = true; msg += "Please, enter Delivery Date.\n"}

   if(error){ alert(msg); }
   else
   {
      var url = "OrderHdrSave.jsp?Order=" + ord
           + "&Ven=" + ven
           + "&PONum=" + ponum
           + "&DelDate=" + deldt
           + "&Action=CHGVNDELDT"
      //alert(deldt)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
}
//==============================================================================
// add PO number on Order
//==============================================================================
function addPoNum(ord, ven, vennm)
{
   var hdr = "Add New PO for Order:&nbsp;" + ord + "&nbsp; &nbsp;";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popAddPoNum(ord, ven, vennm)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popAddPoNum(ord, ven, vennm)
{
  var posX = getLeftScreenPos() + 650;
  var posY = getTopScreenPos() + 100;

  var panel = "<table class='tbl02'>"
  panel += "<tr class='DataTable'>"
              + "<th class='DataTable'>Click on<br>selected<br>Vendor</th>"
              + "<th class='DataTable'>Vendor Name</th>"
              + "</tr>"
  for(var i=0; i < ven.length; i++)
  {
      panel += "<tr class='DataTable'>"
          + "<td class='DataTable2'><a href='javascript: setSelVen(&#34;" + ven[i] + "&#34;)'>" + ven[i] + "</a></td>"
          + "<td class='DataTable' nowrap>" + vennm[i] + "</td>"
        + "</tr>"
  }

  panel += "<tr><td colspan=2 nowrap>&nbsp;</td></tr>"

  panel += "<tr>"
           + "<td class='Prompt' nowrap>Vendor: <input class='Small' name='Ven' size=5 readonly></td>"
           + "<td class='Prompt' nowrap> &nbsp; &nbsp; P.O.#: <input class='Small' name='PoNum' size=10 maxlength=10></td>"
         + "</tr>"

  panel += "<tr class='Prompt'><td class='DataTable' id='tdErrMsg' colspan=2 nowrap></td></tr>"

  panel += "<tr><td class='Prompt' id='tdButton' colspan='3'><br><br>"
      + "<button onClick='vldVenPo(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// set Vendor Contact Information
//==============================================================================
function setSelVen(ven)
{
   document.all.Ven.value = ven
}
//==============================================================================
// validate new PO
//==============================================================================
function vldVenPo(ord)
{
   var error = false;
   var msg = "";
   document.all.tdErrMsg.innerHTML="";
   document.all.tdErrMsg.style.color="red";

   var ven = document.all.Ven.value;
   var ponum = document.all.PoNum.value.trim().toUpperCase();

   br = "";
   if(ven == ""){ error = true; msg += br + "Please select Vendor"; br = "<br>"; }
   if(ponum == ""){ error = true; msg += br + "Please enter P.O.#"; br = "<br>"; }

   if(error){ document.all.tdErrMsg.innerHTML=msg; }
   else{sbmNewPO(ord, ven, ponum)}
}
//==============================================================================
// submit new PO
//==============================================================================
function sbmNewPO(ord, ven, ponum)
{
   var url = "OrderHdrSave.jsp?Order=" + ord
              + "&Ven=" + ven
              + "&PONum=" + ponum
              + "&Action=ADDPONUM"
      //alert(url)
      window.frame1.location.href=url
      hidePanel();
}
//==============================================================================
// set Vendor Contact Information
//==============================================================================
function setVenProp(ven, name, cont, phn1, phn2, phn3, email)
{
   var hdr = "Vendor:&nbsp;" + ven + "-" + name + "&nbsp; &nbsp;";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popVenProp(ven, name, cont, phn1, phn2, phn3, email)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(cont != ""){document.all.Contact.value = cont;}
   if(phn1 != ""){document.all.Phone1.value = phn1;}
   if(phn2 != ""){document.all.Phone2.value = phn2;}
   if(phn3 != ""){document.all.Phone3.value = phn3;}
   if(email != ""){document.all.EMail.value = email;}
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popVenProp(ven, name, cont, phn1, phn2, phn3, email)
{
  var panel = "<table  class='tbl02'>"
  panel += "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Contact Name:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Contact' size=50 maxlength=50> &nbsp; &nbsp;</td>"
         + "</tr>"
             + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Work Phone Number:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Phone1' size=15 maxlength=15> &nbsp; &nbsp;</td>"
         + "</tr>"
         + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Home Phone Number:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Phone2' size=15 maxlength=15> &nbsp; &nbsp;</td>"
         + "</tr>"
         + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Cellular Number:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Phone3' size=15 maxlength=15> &nbsp; &nbsp;</td>"
         + "</tr>"
         + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; E-Mail Address:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='EMail' size=50 maxlength=50> &nbsp; &nbsp;</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' id='tdButton' colspan='2'><br><br>"
      + "<button onClick='sbmVenProp(&#34;" + ven + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// submit new special order status
//==============================================================================
function sbmVenProp(ven)
{
   var cont = document.all.Contact.value.trim(" ");
   var phn1 = document.all.Phone1.value.trim(" ");
   var phn2 = document.all.Phone2.value.trim(" ");
   var phn3 = document.all.Phone3.value.trim(" ");
   var email = document.all.EMail.value.trim(" ");

   var msg = "";
   var error = false;

   if(error){ alert(msg); }
   else
   {
      var url = "PfVenPropSave.jsp?"
           + "Ven=" + ven
           + "&Contact=" + cont.replaceSpecChar()
           + "&Phone1=" + phn1.replaceSpecChar()
           + "&Phone2=" + phn2.replaceSpecChar()
           + "&Phone3=" + phn3.replaceSpecChar()
           + "&Email=" + email.replaceSpecChar()
           + "&Action=CHGVENPROP"
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
}
//==============================================================================
// print sold tag
//==============================================================================
function showSoldTag(ord, strarr)
{

   var hdr = "Show Sold Tag";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr>"
      + "<td class='Prompt' colspan=2>"
        + "Print for store: <select name='selPrtStr'></select>"
        + "<br>Print by employee: <input name='PrtEmp' size='4' maxlength='4'>"
        + "<br><button onclick='vldSoldTag(&#34;" + ord + "&#34;)'>Submit</button>"
      + "</td>"
    + "</tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "450";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 200;
   document.all.dvStatus.style.top= getTopScreenPos() + 400;
   document.all.dvStatus.style.visibility = "visible";

   for(var i=0; i < strarr.length; i++)
   {
      document.all.selPrtStr.options[i] = new Option(strarr[i], strarr[i]);
   }
}

//==============================================================================
// validate sold tag
//==============================================================================
function vldSoldTag(ord)
{
   var error =false;
   var msg = "";

   var str = document.all.selPrtStr.options[document.all.selPrtStr.selectedIndex].value;
   var emp = document.all.PrtEmp.value.trim();
   if(emp == ""){ error=true; msg="Employee number is invalid"; }
   else if(isNaN(emp)){ error=true; msg="Employee number is not numeric"; }
   else if(eval(emp) <= 0){ error=true; msg="Employee number must be positive number"; }

   if(error){ alert(msg); }
   else{ sbmSoldTag(ord, str, emp); }
}
//==============================================================================
// submit sold tag
//==============================================================================
function sbmSoldTag(ord, str, emp)
{
   var url = "OrderPrtSoldTag.jsp?Order=" + ord
    + "&Store=" + str
    + "&Emp=" + emp;
   window.document.location.href = url;
}
//==============================================================================
// print sold tag
//==============================================================================
function showDelTicket(ord)
{
   var url = "PfOrderDelivery.jsp?Order=" + ord
   window.document.location.href = url;
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Patio Furniture Quote Review List
        <br>Selected Store(s):
        <%String coma = "";%>
           <%for(int i=0; i < sStrGrp.length; i++){%><%=coma%> <%=sStrGrp[i]%><%coma=",";%><%}%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="PfQuoteLstSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable"  rowspan=2>No.</th>
        <th class="DataTable"  style="background: yellow" nowrap colspan=11>Customer Order Information</th>
        <th class="DataTable" nowrap rowspan=2>&nbsp;</th>
        <th class="DataTable"  style="background: lightgreen" nowrap>Slsp#</th>
        <th class="DataTable1"  style="background: lightgreen" nowrap colspan=3>Follow Up Steps
           <br> &nbsp; &nbsp; &nbsp; <div style="background:white; font-weight:bold;"># of days before Follow Up Steps are Past Due
           <br> &nbsp; &nbsp; &nbsp; Step 1 - 2 days after initial Quote
           <br> &nbsp; &nbsp; &nbsp; Step 2 - 5 days after initial Quote
           <br> &nbsp; &nbsp; &nbsp; Step 3 - 8 days after initial Quote
           <br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (excludes Sunday's)  
           <br> &nbsp; &nbsp; &nbsp; <span class="FollowUp02">YELLOW</span> text = past due Steps
           <br> &nbsp; &nbsp; &nbsp; <span class="FollowUp03">RED</span> dates = past due Entries
           
           </div>
        </th>
        <th class="DataTable"  style="background: lightgreen" nowrap>Unsuccessfull<br>Sale</th>
       </tr>

       <tr  class="DataTable">
        <th class="DataTable" nowrap><a href="javascript: sortBy('CUSTNM')">Name</a></th>
        <th class="DataTable" nowrap>Day<br>Phone & Ext</th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('STORE')">Str</a></th>        
        <th class="DataTable" nowrap><a href="javascript: sortBy('ENTDT')">Entry<br>Date</a></th>        
        <th class="DataTable" nowrap><a href="javascript: sortBy('ORDER')">Order #</a></th>
        
        
        <th class="DataTable" nowrap>C<br>m<br>t<br>and<br>L<br>o<br>g</th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('ORDAMT')">Total<br>Amt<br>(w/ tax)</a></th>
        <th class="DataTable" nowrap>GM<br>%</th>

        <th class="DataTable" nowrap>Quote<br>Status<br>
           <%if(iNumOfOrd > 0){%><a href="javascript: showStsStamp()" style="color:darkblue;font-size:10px">(show details)</a><%}%>
        </th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('SPCORD')">Type<br>of<br>Order</a></th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('DELDA')">Expiration<br>Date</a></th>

        <th class="DataTable" nowrap><a href="javascript: sortBy('SLSP')">Orig<br>Slsp#</a></th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('STEP1')">Step 1<br>(Initial Phone<br>Call)</a></th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('STEP2')">Step 2<br>(Thank You<br>Card / Email)</a></th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('STEP3')">Step 3<br>(Final Phone<br>Call)</a></th>
        <th class="DataTable" nowrap><a href="javascript: sortBy('STEP4')">Closed</a></th>
      </tr>

      <TBODY>

  <!-------------------------- Order List ------------------------------->
  <%
  String sSvCust = "";
  String sSvDate = "";
  
  for(int i=0, j=1; i < iNumOfOrd; i++) {%>
    <%
      ordlst.setOrdHdrInfo();

      String sOrdNum = ordlst.getOrdNum();
      String sSts = ordlst.getSts();
      String sStsName = ordlst.getStsName();
      String sCust = ordlst.getCust();
      String sSlsper = ordlst.getSlsper();
      String sSlpName = ordlst.getSlpName();
      String sDelDate = ordlst.getDelDate();
      String sShipInstr = ordlst.getShipInstr();
      String sLastName = ordlst.getLastName();
      String sFirstName = ordlst.getFirstName();
      String sAddr1 = ordlst.getAddr1();
      String sAddr2 = ordlst.getAddr2();
      String sCity = ordlst.getCity();
      String sState = ordlst.getState();
      String sZip = ordlst.getZip();
      String sDayPhn = ordlst.getDayPhn();
      String sExtWorkPhn = ordlst.getExtWorkPhn();
      String sEvtPhn = ordlst.getEvtPhn();
      String sCellPhn = ordlst.getCellPhn();
      String sEMail = ordlst.getEMail();
      String sSubTot = ordlst.getSubTot();
      String sTax = ordlst.getTax();
      String sTotal = ordlst.getTotal();
      String sOrgStr = ordlst.getOrgStr();

      String sTrfStr35 = ordlst.getTrfStr35();
      String sTrfStr46 = ordlst.getTrfStr46();
      String sTrfStr50 = ordlst.getTrfStr50();
      String sTrfStr86 = ordlst.getTrfStr86();
      String sTrfStr63 = ordlst.getTrfStr63();
      String sTrfStr64 = ordlst.getTrfStr64();
      String sTrfStr68 = ordlst.getTrfStr68();
      String sTrfStr55 = ordlst.getTrfStr55();

      String sSpcOrd = ordlst.getSpcOrd();
      String sEntDate = ordlst.getEntDate();
      String sStsDate = ordlst.getStsDate();
      String sStsTime = ordlst.getStsTime();
      String sStsUser = ordlst.getStsUser();
      String sSkuQty = ordlst.getSkuQty();
      String sSkuRet = ordlst.getSkuRet();
      String sComments = ordlst.getComments();
      String sGmPrc = ordlst.getGmPrc();

      String sFup1 = ordlst.getFup1();
      String sFup1Comm = ordlst.getFup1Comm();
      String sFup1User = ordlst.getFup1User();
      String sFup1Date = ordlst.getFup1Date();
      String sFup1Time = ordlst.getFup1Time();

      String sFup2 = ordlst.getFup2();
      String sFup2Comm = ordlst.getFup2Comm();
      String sFup2User = ordlst.getFup2User();
      String sFup2Date = ordlst.getFup2Date();
      String sFup2Time = ordlst.getFup2Time();

      String sFup3 = ordlst.getFup3();
      String sFup3Comm = ordlst.getFup3Comm();
      String sFup3User = ordlst.getFup3User();
      String sFup3Date = ordlst.getFup3Date();
      String sFup3Time = ordlst.getFup3Time();

      String sFup4 = ordlst.getFup4();
      String sFup4Comm = ordlst.getFup4Comm();
      String sFup4User = ordlst.getFup4User();
      String sFup4Date = ordlst.getFup4Date();
      String sFup4Time = ordlst.getFup4Time();
      String sCustOrd = ordlst.getCustOrd();
      String sCustQuo = ordlst.getCustQuo();

      String sVenConf = ordlst.getVenConf();
      Date dCurrDt = new Date();
      
      SimpleDateFormat smpUsa = new SimpleDateFormat("MM/dd/yyyy");
      SimpleDateFormat smpYmd = new SimpleDateFormat("yyyyMMdd");
      // step 1 
      Date dEntDate = smpUsa.parse(sEntDate);      
      String sFup1_Class = "FollowUp01";      
      if(sFup1Date.equals("01/01/0001") && ordlst.clcNumOfDays(sEntDate, "CURRENT DATE") > 2){ sFup1_Class = "FollowUp02";}
      else if(!sFup1Date.equals("01/01/0001") && ordlst.clcNumOfDays(sEntDate, sFup1Date) > 2){ sFup1_Class = "FollowUp03";}
    		
      // step 2
      String sFup2_Class = "FollowUp01";
      if(sFup2Date.equals("01/01/0001") && ordlst.clcNumOfDays(sEntDate, "CURRENT DATE") > 5) { sFup2_Class = "FollowUp02";}
      else if(!sFup2Date.equals("01/01/0001") && ordlst.clcNumOfDays(sEntDate, sFup2Date) > 5){ sFup2_Class = "FollowUp03";}
            
      // step 3
      String sFup3_Class = "FollowUp01";     
      if(sFup3Date.equals("01/01/0001") && ordlst.clcNumOfDays(sEntDate, "CURRENT DATE") > 8) { sFup3_Class = "FollowUp02";}
      else if(!sFup3Date.equals("01/01/0001") && ordlst.clcNumOfDays(sEntDate, sFup3Date) > 8){ sFup3_Class = "FollowUp03";}
      
     /* System.out.println("Ord=" + sOrdNum + " Class3=" + sFup3_Class + " Fup3Dt=" + sFup3Date 
    		+ " EntDt=" + sEntDate + " diff=" + ordlst.clcNumOfDays(sEntDate, sFup3Date) );
     */
    boolean bSame = false;   
    if(sSort.equals("CUSTNM"))
    {
    	if(sSvCust.equals(sCust) && sSvDate.equals(sEntDate))
    	{
    		bSame = true;
    	}
    	sSvCust = sCust;
    	sSvDate = sEntDate;
    }
    
    String sTypeOfOrd = "IN-STOCK";
    if(sSpcOrd.equals("1")){ sTypeOfOrd = "SPEC ORD"; }
%>
        <tr  class="DataTable">
            <td class="DataTable2"><%if(!bSame){%><%=j++%><%} else{%>&nbsp;<%}%></td>
            
            <%if(!bSame){%>            
            	<td class="DataTable" nowrap><%=sLastName%>, <%=sFirstName%>
            	  <%if(!sCustOrd.equals("0")){%><sup><a href="OrderLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=12/31/2999&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=<%=sCust%>&SlsPer=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT" target="_blank"></>S<%=sCustOrd%><a></a></sup><%}%>
                  <%if(!sCustQuo.equals("0")){%><sup><a href="PfQuoteLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=12/31/2999&Cust=<%=sCust%>&SlsPer=&Status=A&CommType=QST1&CommType=QST2&CommType=QST3&InclSO=B&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55" target="_blank">Q<%=sCustQuo%></a></sup><%}%>
            	</td>
            	<td class="DataTable" nowrap>
        	      	<%if(sDayPhn.trim().length() > 0){%><%=sDayPhn%><%if(sExtWorkPhn.trim().length() > 0){%><%=" x " + sExtWorkPhn%><%}%><%}
	        	        else if(sCellPhn.trim().length() > 0){%><%=sCellPhn%><%}
    	        	    else if(sEvtPhn.trim().length() > 0){%><%=sEvtPhn%><%}%>
            	</td>
            	<td class="DataTable2"><%=sOrgStr%></td>
            	<td class="DataTable2"><%=sEntDate%></td>            	
            <%} else {%>
               <td class="DataTable5" colspan=4>&nbsp;</td>
            <%}%>
            
            
                        
            <td class="DataTable2"><a target="_blank" href="OrderEntry.jsp?Order=<%=sOrdNum%>&List=Y"><%=sOrdNum%></a></td>            
            
            <td class="DataTable2" nowrap><a href="javascript: showCommtPanel(&#34;<%=sOrdNum%>&#34;, &#34;ALL&#34;, null, null, &#34;<%=sOrgStr%>&#34;, &#34;<%=sLastName%>&#34;, &#34;<%=sFirstName%>&#34;, &#34;<%=sTotal%>&#34;, &#34;<%=sTypeOfOrd%>&#34;, &#34;<%=sDelDate%>&#34;)">C&L</a></td>

            <td class="DataTable4">$<%=sTotal%></td>
            <td class="DataTable1"><%if(bAllowGmPrc && !sGmPrc.equals("100")){%><%=sGmPrc%>%<%}%></td>

            <!--===== Status ====== -->
            <td class="DataTable2" nowrap>
                 <a href="javascript: chgOrdSts('<%=sOrdNum%>','<%=sSts%>')"><%if(sSts.equals("Q")){%>Open<%} else {%>Closed<%}%></a>
               <span id="spStsStamp" style="display:none"><%=sStsDate%><br><%=sStsTime%><br><%=sStsUser%></span>
            </td>

            <td class="DataTable2" nowrap><%if(sSpcOrd.equals("1")){%>SPEC ORD<%} else {%>IN-STOCK<%}%></td>
            <td class="DataTable2"><%=sDelDate%></td>

            <!-- ===== in-Stock Order ===== -->
            <th class="DataTable" nowrap>&nbsp;</th>

            <td class="DataTable" nowrap><%=sSlsper%> <%=sSlpName%></td>
            <td class="DataTable2" nowrap>
               <%if(sFup1.equals("1")){%>
                  <a href="javascript: showCommtLst(&#34;<%=sOrdNum%>&#34;, &#34;QST1&#34;)">
                     <span class="<%=sFup1_Class%>"><%=sFup1Date%></span>
                  </a>
               <%} else {%><a href="javascript: showCommtPanel(&#34;<%=sOrdNum%>&#34;, &#34;QST1&#34;, &#34;<%=sOrgStr%>&#34;, &#34;<%=sLastName%>&#34;, &#34;<%=sFirstName%>&#34;, &#34;<%=sTotal%>&#34;, &#34;<%=sTypeOfOrd%>&#34;, &#34;<%=sDelDate%>&#34;)">
                           <span class="<%=sFup1_Class%>">Initial Call</span>
                       </a><%}%>
            </td>

            <td class="DataTable2" nowrap>
               <%if(sFup2.equals("1")){%>
                  <a href="javascript: showCommtLst(&#34;<%=sOrdNum%>&#34;, &#34;QST2&#34;)">
                     <span class="<%=sFup2_Class%>"><%=sFup2Date%></span>
                  </a>
               <%} else {%>
                  <a href="javascript: showCommtPanel(&#34;<%=sOrdNum%>&#34;, &#34;QST2&#34;, &#34;<%=sOrgStr%>&#34;, &#34;<%=sLastName%>&#34;, &#34;<%=sFirstName%>&#34;, &#34;<%=sTotal%>&#34;, &#34;<%=sTypeOfOrd%>&#34;, &#34;<%=sDelDate%>&#34;)">
                         <span class="<%=sFup2_Class%>">Send Email/Card</span>
                  </a><%}%>
            </td>

            <td class="DataTable2" nowrap>
               <%if(sFup3.equals("1")){%>
                  <!--a href="javascript: showCommtLst(&#34;<%=sOrdNum%>&#34;, &#34;QST3&#34;)" -->
                  <a href="javascript: showCommtPanel(&#34;<%=sOrdNum%>&#34;, &#34;QST3&#34;, &#34;<%=sOrgStr%>&#34;, &#34;<%=sLastName%>&#34;, &#34;<%=sFirstName%>&#34;, &#34;<%=sTotal%>&#34;, &#34;<%=sTypeOfOrd%>&#34;, &#34;<%=sDelDate%>&#34;)">
                     <span class="<%=sFup3_Class%>"><%=sFup3Date%></span>
                  </a>
               <%} else {%>
                  <a href="javascript: showCommtPanel(&#34;<%=sOrdNum%>&#34;, &#34;QST3&#34;, &#34;<%=sOrgStr%>&#34;, &#34;<%=sLastName%>&#34;, &#34;<%=sFirstName%>&#34;, &#34;<%=sTotal%>&#34;, &#34;<%=sTypeOfOrd%>&#34;, &#34;<%=sDelDate%>&#34;)">
                       <span class="<%=sFup3_Class%>">Final Call</span>
                  </a><%}%>
            </td>

            <td class="DataTable2" nowrap>
               <%if(sFup4.equals("1")){%>
                  <a href="javascript: showCommtLst(&#34;<%=sOrdNum%>&#34;, &#34;QST4&#34;)">
                     <%=sFup4Date%>
                  </a>
               <%}%>
            </td>
          </tr>
      <%}%>
      <!----------------------------------------------------------------------->
      <!-- Total -->
      <!----------------------------------------------------------------------->
      <tr class="DataTable1">
            <td class="DataTable2" colspan=2>Total</td>
            <td class="DataTable2" colspan=5></td>
            <td class="DataTable4">$<%=sRepTotal%></td>
            <td class="DataTable2" colspan=40></td>
      </tr>

      </TBODY>
    </table>

  <!----------------------- end of table ------------------------>
        <button onclick="history.go(-1)">Back</button>
     </td>
   </tr>

  </table>
 </body>
</html>
<%
   ordlst.disconnect();
}%>


