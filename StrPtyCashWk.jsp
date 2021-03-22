<%@ page import="storepettycash.StrPtyCashWk, java.util.*, java.text.*"%>
<%
    String sStore = request.getParameter("Store");
    String sWkend = request.getParameter("Wkend");
//----------------------------------
// Application Authorization
//----------------------------------
String sAppl = "PTYCSH";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !(session.getAttribute(sAppl) == null))
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrPtyCashWk.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    StrPtyCashWk strpty = new StrPtyCashWk(sStore, sWkend, session.getAttribute("USER").toString());
    int iNumOfEnt = strpty.getNumOfEnt();
    String [] sIdNum = strpty.getIdNum();
    String [] sStr = strpty.getStr();
    String [] sPayDate = strpty.getPayDate();
    String [] sPayType = strpty.getPayType();
    String [] sSpiff = strpty.getSpiff();   
    String [] sEmp = strpty.getEmp();
    String [] sPayee = strpty.getPayee();
    String [] sAmt = strpty.getAmt();
    String [] sUser = strpty.getUser();
    String [] sDate = strpty.getDate();
    String [] sPTyDesc = strpty.getPTyDesc();
    String [] sSpfDesc = strpty.getSpfDesc();
    String [] sNote = strpty.getNote();

    String sPtyTypeJsa = strpty.getPtyTypeJsa();
    String sPtyTypeDescJsa = strpty.getPtyTypeDescJsa();
    String sPtyTypeColHdg1Jsa = strpty.getPtyTypeColHdg1Jsa();
    String sPtyTypeColHdg2Jsa = strpty.getPtyTypeColHdg2Jsa();

    String sSpiffTypeJsa = strpty.getSpiffTypeJsa();
    String sSpiffDescJsa = strpty.getSpiffDescJsa();
    String sSpiffColHdg1Jsa = strpty.getSpiffColHdg1Jsa();
    String sSpiffColHdg2Jsa = strpty.getSpiffColHdg2Jsa();

    String sEmpListJsa = strpty.getEmpListJsa();
    String sEmpNameJsa = strpty.getEmpNameJsa();

    String sTotSpent = strpty.getTotSpent();
    String sOnHand = strpty.getOnHand();
    String sUnacctAmt = strpty.getUnacctAmt();
    String sBegWkBoxAmt = strpty.getBegWkBoxAmt();

    String sStrWkSts = strpty.getStrWkSts();
    String sStrWkStsComm = strpty.getStrWkStsComm();

    int iNumOfChk = strpty.getNumOfChk();
    String [] sChkStr = strpty.getChkStr();
    String [] sChkWeek = strpty.getChkWeek();
    String [] sChkPayTo = strpty.getChkPayTo();
    String [] sChkAmt = strpty.getChkAmt();

    boolean bAPDept = session.getAttribute("PTYCSHAP") != null;
    
    SimpleDateFormat sdfToDate = new SimpleDateFormat("MM/dd/yyyy");
    Date dWkend = sdfToDate.parse(sWkend);
    dWkend.setHours(0); dWkend.setMinutes(0); dWkend.setSeconds(0);
    
    
    Date dCurr = new Date();
    dCurr.setHours(0); dCurr.setMinutes(0); dCurr.setSeconds(0);
    long lDiff = dWkend.getTime() - dCurr.getTime();   
    lDiff = lDiff / (24*60*60);
    
    boolean bDeadTime = lDiff < 0;
    boolean bAllowChg = sStrWkSts.equals("OPEN") && !bDeadTime;    
%>

<HTML>
<HEAD>
<title>Store Petty Cash</title>
<META content="RCI, Inc." name="Store_Petty_Cash"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
       
        table.DataTable { padding: 0px; border-spacing: 0; border-collapse: collapse; 
                border: grey solid 1px; font-size:10px }
        table.DataTable1 { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%; 
                background: LemonChiffon; border: grey solid 1px; font-size:10px }
        
        
        th.DataTable { border-bottom: grey solid 1px; border-right: grey solid 1px; background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { border-bottom: grey solid 1px; border-right: grey solid 1px;cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { border-bottom: grey solid 1px; border-right: grey solid 1px; padding-top:3px; padding-bottom:3px; text-align:center; font-size:11px;}
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:10px }
        th.DataTable4 { border-bottom: grey solid 1px; border-right: grey solid 1px; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:10px }

        th.DataTable5 { border-bottom: grey solid 1px; border-right: grey solid 1px; background:#82caff ;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:10px }

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:12px; font-weight: bold }
        tr.DataTable2 { background: azure; font-size:10px;}

        td.DataTable { border-bottom: grey solid 1px; border-right: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { border-bottom: grey solid 1px; border-right: grey solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { border-bottom: grey solid 1px; border-right: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { border-bottom: grey solid 1px; border-right: grey solid 1px; background: #b0b0b0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable01 { border-bottom: grey solid 1px; border-right: grey solid 1px; cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEntry { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;  background: #016aab;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;  background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
        td.Prompt4 { color: red; text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; font-weight:bold}
        td.Comments { background: white; text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript1.3">
var PtyType = [<%=sPtyTypeJsa%>];
var PtyTypeDesc = [<%=sPtyTypeDescJsa%>];
var PtyTypeColHdg1 = [<%=sPtyTypeColHdg1Jsa%>];
var PtyTypeColHdg2 = [<%=sPtyTypeColHdg2Jsa%>];

var SpiffType = [<%=sSpiffTypeJsa%>];
var SpiffDesc = [<%=sSpiffDescJsa%>];
var SpiffColHdg1 = [<%=sSpiffColHdg1Jsa%>];
var SpiffColHdg2 = [<%=sSpiffColHdg2Jsa%>];

var EmpList = [<%=sEmpListJsa%>];
var EmpName = [<%=sEmpNameJsa%>];

var StrWkSts = "<%=sStrWkSts%>";
var StrWkStsComm = "<%=sStrWkStsComm%>";
var DisplayComments = "block";
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEntry", "dvStatus"]);
   showStatus()
}

//==============================================================================
// show Entry  panel
//==============================================================================
function showStatus()
{
  var hdr = "Store Weekly Petty Cash Status";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "</td></tr>"

   html += "<tr><td class='Prompt1'>" + StrWkSts
          + " &nbsp; &nbsp; &nbsp; <a href='javascript: showComments()' class='Small'>Comment</a>"
        + "</td></tr>"
   html += "<tr><td class='Comments' id='tdStsComm'>"
          + "<textarea readonly>" + StrWkStsComm + "</textarea>"
        + "</td></tr>"

   html += "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "250";}
   else { document.all.dvStatus.style.width = "auto";}
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 10;
   document.all.dvStatus.style.top=getTopScreenPos() + 10;
   document.all.dvStatus.style.visibility = "visible";
   document.all.tdStsComm.style.display = "none";
}

//==============================================================================
// show Entry  panel
//==============================================================================
function showComments()
{
   document.all.tdStsComm.style.display = DisplayComments;
   if(DisplayComments=="block"){ DisplayComments = "none"; }
   else { DisplayComments = "block"; }
}
//==============================================================================
// show Entry  panel
//==============================================================================
function showEntry(action, idnum, paytype, spiff, emp, payee, amt)
{
  var hdr = "Add New Petty Cash Entry";
  if(action == "UPD") { hdr = "Update Petty Cash Entry" }
  else if(action == "DLT") { hdr = "Delete Petty Cash Entry" }

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

    if(action == "ADD") { html += popAddEntryPanel(action)}
    else { html += popUpdEntryPanel(action, idnum, paytype, spiff, emp, payee, amt)}

   html += "</td></tr></table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvEntry.style.width = "250";}
   else { document.all.dvEntry.style.width = "auto";}
   document.all.dvEntry.innerHTML = html;   
   document.all.dvEntry.style.left=getLeftScreenPos() + 150;
   document.all.dvEntry.style.top=getTopScreenPos() + 100;
   document.all.dvEntry.style.visibility = "visible";

   if(action == "ADD")
   {
     document.all.PayType[0].checked = true;
     document.all.Spiff[0].checked = true;
     alert("All non-spiff expenses of $50 or more must be pre-approved through Store Ops");
   }

}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popAddEntryPanel(action)
{
  var panel = "<table border=0 width='100%' cellPadding='3' cellSpacing='0'>"
        + "<tr id='trPayType'><td class='Prompt3' nowrap>Pay Type:</td>"
           + "<td class='Prompt' nowrap>"
             + setPayTypePanel()
           + "</td>"
         + "</tr>"

         + "<tr id='trSpiff'><td class='Prompt3' nowrap>Spiff:</td>"
           + "<td class='Prompt' nowrap>"
             + setSpiffPanel()
           + "</td>"
         + "</tr>"

         + "<tr><td class='Prompt3' nowrap>Paid To:</td>"
           + "<td class='Prompt' nowrap>"
             + "<input name='Emp' size=4 maxlength=4 class='Small' readOnly> &nbsp; "
             + "<input name='Payee' size=30 maxlength=30 class='Small' readOnly><br>"
             + setEmpPanel()
             + " &nbsp; <a id='linkToOtherStr' href='javascript: openOtherStoreWdw()'>Other Store</a>"
           + "</td>"
         + "</tr>"

         + "<tr><td class='Prompt3' nowrap>Amount:</td>"
           + "<td class='Prompt' nowrap>"
             + "<input name='Amount' size=10 maxlength=10 class='Small'> &nbsp; "
           + "</td>"
         + "</tr>"
         
         + "<tr><td class='Prompt3' nowrap>Description:</td>"
         + "<td class='Prompt' nowrap>"
           + "<input name='Note' size=50 maxlength=50 class='Small'> &nbsp; "
         + "</td>"
       + "</tr>"
         

  panel += "<tr><td class='Prompt1' colspan=2><br><br>"
        + "<button onClick='ValidateEntry(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// populate Column Panel for update
//--------------------------------------------------------
function popUpdEntryPanel(action, idnum, paytype, spiff, emp, payee, amt)
{
  var panel = "<table border=0 width='100%' cellPadding='3' cellSpacing='0'>"
        + "<tr id='trPayType'><td class='Prompt3' nowrap>Pay Type:</td>"
           + "<td class='Prompt' nowrap>" + paytype
           + "<input name='IdNum' type=hidden' value='" + idnum + "'>"
           + "</td>"
         + "</tr>"

         + "<tr id='trSpiff'><td class='Prompt3' nowrap>Spiff:</td>"
           + "<td class='Prompt' nowrap>" + spiff + "</td>"
         + "</tr>"

         + "<tr><td class='Prompt3' nowrap>Paid To:</td>"
           + "<td class='Prompt' nowrap>" + emp + " " + payee +"</td>"
         + "</tr>"

  if(action != "DLT")
  {
     panel += "<tr><td class='Prompt3' nowrap>Amount:</td>"
           + "<td class='Prompt' nowrap>"
             + "<input name='Amount' size=10 maxlength=10 class='Small' value='" + amt + "'> &nbsp; "
           + "</td>"
         + "</tr>"
  }
  else
  {
     panel += "<tr><td class='Prompt3' nowrap>Amount:</td>"
           + "<td class='Prompt' nowrap>" + amt + "</td>"
         + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan=2><br><br>"
        + "<button onClick='ValidateEntry(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// set Pay type on panel
//--------------------------------------------------------
function setPayTypePanel()
{
   var panel = "<table border=1 cellPadding='0' cellSpacing='0'>";

   panel += "<tr>"
   for(var i=0; i < PtyType.length; i++)
   {
     panel += "<th class='DataTable' nowrap>" + PtyTypeColHdg1[i] + "<br>" + PtyTypeColHdg2[i] + "</th>"
   }
   panel += "</tr>"

   panel += "<tr>"
   for(var i=0; i < PtyType.length; i++)
   {
     panel += "<td class='Prompt1' nowrap><input type='radio' name='PayType' onClick='chgPayType(this)' class='Small' value='"
           + PtyType[i] + "'></td>"
   }
   panel += "</tr>"
   panel += "</table>";
   return panel;
}
//--------------------------------------------------------
// set Spiff type on panel
//--------------------------------------------------------
function setSpiffPanel()
{
   var panel = "<table border=1 cellPadding='0' cellSpacing='0'>";

   panel += "<tr>"
   for(var i=0; i < SpiffType.length; i++)
   {
     panel += "<th class='DataTable' nowrap>" + SpiffColHdg1[i] + "<br>" + SpiffColHdg2[i] + "</td>"
   }
   panel += "</tr>"

   panel += "<tr>"
   for(var i=0; i < SpiffType.length; i++)
   {
     panel += "<td class='Prompt1' nowrap><input type='radio' name='Spiff' class='Small' value='"
           + SpiffType[i] + "'></td>"
   }
   panel += "</tr>"

   panel += "</table>";
   return panel;
}

//--------------------------------------------------------
// set Spiff type on panel
//--------------------------------------------------------
function setEmpPanel()
{
   var panel = "<select class='Small' onClick='selEmpName(this)' name='selEmpLst'>"
   for(var i=0; i < EmpList.length; i++)
   {
     panel += "<option value='" + i + "'>" + EmpList[i] + " " + EmpName[i] + "</option>"
   }
   panel += "</select>"
   return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvEntry.innerHTML = " ";
   document.all.dvEntry.style.visibility = "hidden";
}
//==============================================================================
// Open prompt window
//==============================================================================
function openOtherStoreWdw() {
  var fileType = "RCI";

  var MyURL = 'SelectEmployee.jsp?EMPNUM=Emp&EMPNAME=Payee&TYPE=FIELD&FILETYPE='
          + fileType + "&STORE=<%=sStore%>";
  var MyWindowName = 'Test01';
  var MyWindowOptions =
   'width=600,height=400, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';

  //alert(MyURL)
  window.open(MyURL, MyWindowName, MyWindowOptions);
}
//--------------------------------------------------------
// change Pay Type
//--------------------------------------------------------
function chgPayType(paytype)
{
  if(paytype.value != "SPIFF")
  {
    document.all.trSpiff.style.display = "none"
    document.all.selEmpLst.style.display = "none"
    document.all.Emp.style.display = "none";
    document.all.Emp.value = "";
    document.all.Payee.readOnly = false;
    document.all.linkToOtherStr.style.display = "none"
  }
  else
  {    
	if(isIE && ua.indexOf("MSIE 7.0") >= 0)
	{ 
		document.all.trSpiff.style.display = "block";	
    	document.all.selEmpLst.style.display = "block";
    	document.all.Emp.style.display = "inline";
    	document.all.linkToOtherStr.style.display = "inline"
    	document.all.Emp.value = "";
    	document.all.Payee.readOnly = true;
    	document.all.Payee.value = "";
	}
	else
	{
		document.all.trSpiff.style.display = "table-row";	
    	document.all.selEmpLst.style.display = "table-row";
    	document.all.Emp.style.display = "inline";
    	document.all.linkToOtherStr.style.display = "inline"
    	document.all.Emp.value = "";
    	document.all.Payee.readOnly = true;
    	document.all.Payee.value = "";
	}
  }
}

//--------------------------------------------------------
// select employee
//--------------------------------------------------------
function selEmpName(selEmp)
{
   var selIdx = selEmp.options[selEmp.selectedIndex].value
   document.all.Emp.value = EmpList[selIdx];
   document.all.Payee.value = EmpName[selIdx];
}

//--------------------------------------------------------
// Validate Petty Cash entry
//--------------------------------------------------------
function ValidateEntry(action)
{
   var msg = "";
   var error = false;

   var idnum = " ";
   var payty = " ";
   var spiff = " ";
   var emp = " ";
   var payee = " ";
   var amt = " ";
   var note = " ";

   if (action != "ADD")
   {
      idnum = document.all.IdNum.value.trim();
   }

   if (action == "ADD")
   {
      for(var i=0; i < document.all.PayType.length; i++)
      {
        if(document.all.PayType[i].checked){ payty = document.all.PayType[i].value}
      }


      if (payty == "SPIFF")
      {
         for(var i=0; i < document.all.Spiff.length; i++)
         {
            if(document.all.Spiff[i].checked){ spiff = document.all.Spiff[i].value}
         }
      }

      emp = document.all.Emp.value.trim();
      payee = document.all.Payee.value.trim();
      if (payee == ""){ error=true; msg += "\n 'Paid To' name is blank."}

   }

   if (action != "DLT")
   {
      amt = document.all.Amount.value.trim();
      if (isNaN(amt)){ error=true; msg += "\n Amount is not correct."}
      else if (eval(amt) <= 0 || eval(amt) > 500){ error=true; msg += "\n Amount are 0 or greater than $500."}
      
      //[ 'SUPERFEET', 'VENDOR', 'WINCHL', 'CONTEST', 'BIKETENT', 'KIP', 'OTHER', 'HOMEOFFICE'];

      if(action != "UPD"){ note = document.all.Note.value.trim(); }
      
      if(payty == "SPIFF" 
         && (spiff== 'VENDOR' || spiff == 'CONTEST' || spiff == 'OTHER' || spiff == 'HOMEOFFICE'
        	 || spiff == 'REFERRALSPIFF') 
    	 && note == ""){error=true; msg += "\n Please type Description.";}
   }

   if(error){alert(msg)}
   else{ sbmEntry(idnum, payty, spiff, emp, payee, amt, note, action) }
}
//--------------------------------------------------------
// submit entry
//--------------------------------------------------------
function sbmEntry(idnum, payty, spiff, emp, payee, amt, note, action)
{
   clearIframeContent("frame1");
   var nwelem = "";
   if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
   nwelem.id = "dvSbmEntry"
   aSelOrd = new Array();

   var html = "<form name='frmNewEntry'"
    + " METHOD=Post ACTION='StrPtyCashWkSave.jsp'>"
    + "<input name='Store'>"
    + "<input name='Week'>"
    + "<input name='IdNum'>"
    + "<input name='PayType'>"
    + "<input name='Spiff'>"
    + "<input name='Emp'>"
    + "<input name='Payee'>"
    + "<input name='Amt'>"
    + "<input name='Note'>"
    + "<input name='Action'>"
   html += "</form>"

   hidePanel();

   nwelem.innerHTML = html;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }
       
   note = note.replace(/\n\r?/g, '<br />');

   	if(isIE || isSafari)
   	{
   		window.frame1.document.all.Store.value = "<%=sStore%>";
   		window.frame1.document.all.Week.value = "<%=sWkend%>";
   		window.frame1.document.all.IdNum.value = idnum;
  		window.frame1.document.all.PayType.value = payty;
   		window.frame1.document.all.Spiff.value = spiff;
   		window.frame1.document.all.Emp.value = emp;
   		window.frame1.document.all.Payee.value = payee;
   		window.frame1.document.all.Amt.value = amt;
   		window.frame1.document.all.Note.value = note;
   		window.frame1.document.all.Action.value=action;

   		window.frame1.document.frmNewEntry.submit();
   	}
   	else
	{
		window.frame1.contentDocument.forms[0].Store.value = "<%=sStore%>";
   		window.frame1.contentDocument.forms[0].Week.value = "<%=sWkend%>";
   		window.frame1.contentDocument.forms[0].IdNum.value = idnum;
  		window.frame1.contentDocument.forms[0].PayType.value = payty;
   		window.frame1.contentDocument.forms[0].Spiff.value = spiff;
   		window.frame1.contentDocument.forms[0].Emp.value = emp;
   		window.frame1.contentDocument.forms[0].Payee.value = payee;
   		window.frame1.contentDocument.forms[0].Amt.value = amt;
   		window.frame1.contentDocument.forms[0].Note.value = note;
   		window.frame1.contentDocument.forms[0].Action.value=action; 
   		
   		window.frame1.contentDocument.forms[0].submit();
	}
}
//--------------------------------------------------------
// show change status Panel
//--------------------------------------------------------
function showChgStsPanel(onhand)
{
  var hdr = "Change Status of Petty Cash Weekly Spending ";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popChgStsPanel(onhand);

   html += "</td></tr></table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvEntry.style.width = "250";}
   else { document.all.dvEntry.style.width = "auto";}
   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.left=getLeftScreenPos() + 150;
   document.all.dvEntry.style.top=getTopScreenPos() + 100;
   document.all.dvEntry.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Column Panel for update
//--------------------------------------------------------
function popChgStsPanel(onhand)
{
  var panel = "<table border=0 width='100%' cellPadding='3' cellSpacing='0'>"

  panel += "<tr><td class='Prompt3' nowrap>Status:</td>"
          + "<td class='Prompt' nowrap>"
            + "<select name='selSts' class='Small'>"
              + "<option value='SUBMIT' selected>SUBMIT</option>"

  <%if(bAPDept){%>
     panel += "<option value='OPEN' >OPEN</option>"
            + "<option value='CLOSE'>CLOSE</option>"
  <%}%>

  panel += "</select>"
          + "</td>"
        + "</tr>"

  <%if (sStrWkSts.equals("OPEN")){%>
       panel += "<tr><td class='Prompt3' nowrap>Pay To:</td>"
              + "<td class='Prompt' nowrap>"
                + "<input name='PayTo' maxlength=30 size=30 class='Small'>"
              + "</td>"
           + "</tr>"

       panel += "<tr><td class='Prompt4' colspan=2>I attest that there is the following amount"
               + " of cash on hand at the time of this submital: $" + onhand
               + ". &nbsp;<input type='checkbox' name='ChgOnhand' onclick='dspOnHandAmt(this)' class='Small'> Yes?"
          + "</td>"
       panel += "<tr id='trOnhand'><td class='Prompt3' nowrap>Amount on hands:</td>"
          + "<td class='Prompt' nowrap>"
            + "<input name='Amount' class='Small'>&nbsp; Please, explain."
          + "</td>"
        + "</tr>"
  <%}%>

  panel += "<tr><td class='Prompt3' nowrap>Comments:</td>"
          + "<td class='Prompt' nowrap>"
            + "<textarea name='Comment' cols=100 rows=10 class='Small'></textarea>"
          + "</td>"
        + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=2><br><br>"
        + "<button onClick='ValidateChgSts()' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
//clear  iframe content
//==============================================================================
function clearIframeContent(id) 
{
  var iframe = document.getElementById(id);
  try 
  {
  	var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	      doc.body.innerHTML = "";
	}
	catch(e) 
	{
	      // alert(e.message);
  }
  return false;
}
//==============================================================================
//show iframe content
//==============================================================================
function showIframeContent(id) 
{
	var iframe = document.getElementById(id);
  try 
  {
	      var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	      alert(doc.body.innerHTML);
	}
	catch(e) {
	   alert(e.message);
	}
  return false;
}
//--------------------------------------------------------
// validate weekly spending to A/P or respond from A/P
//--------------------------------------------------------
function ValidateChgSts()
{
   var msg = "";
   var error = false
   var sts = document.all.selSts.options[document.all.selSts.selectedIndex].value
   var payto = " ";
   var comment = document.all.Comment.value.trim().replaceSpecChar();
   var chgonh = " ";
   var amt = "0";

   <%if (sStrWkSts.equals("OPEN")){%>
      payto = document.all.PayTo.value.trim();
      if (payto == ""){ error=true; msg += "Please, type 'Pay To' name for reimbersing check.\n";}

      if(!document.all.ChgOnhand.checked)
      {
         chgonh = "Y";
         amt = document.all.Amount.value.trim();
         if (isNaN(amt)){ error=true; msg += "Amount is not correct.\n"}
         else if (amt==""){ error=true; msg += "Type amount on hands.\n"}

         if (comment==""){ error=true; msg += "Your comments is required.\n"}
      }
      else { amt = 0; }
   <%}%>

   if(error) { alert(msg) }
   else
   {
       sbmChgSts(sts, comment);
       if (sts == "SUBMIT")
       {
         sbmCheckSts(payto);
         if(chgonh =="Y") { sbmTotBox(amt, chgonh, "CHGONH"); }
       }
       else if(sts == "CLOSE"){ sbmRollupTotal(str, amt) }
   }
}

//--------------------------------------------------------
// submit weekly spending to A/P for review
//--------------------------------------------------------
function sbmChgSts(sts, comment)
{
   var url = "StrPtyCashWkSave.jsp?Store=<%=sStore%>"
     + "&Week=<%=sWkend%>"
     + "&Sts=" + sts
     + "&Comment=" + comment
     + "&Action=CHGSTS"

   //alert(url)
   //window.location.href = url
   if(isIE){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
   else if(isSafari){ window.frame1.location.href = url; }
}
//--------------------------------------------------------
// submit weekly spending to A/P for review
//--------------------------------------------------------
function sbmRollupTotal(str, amt)
{
   var html = "StrPtyCashWkSave.jsp?Store=" + str
     + "&Week=<%=sWkend%>"
     + "&Amt=" + amt
     + "&Action=ROLLWK"

   //alert(html)
   window.location.href = html
   //window.frame1.location.href = html
}
//--------------------------------------------------------
// submit weekly spending to A/P for review
//--------------------------------------------------------
function sbmCheckSts(payto)
{
   var url = "StrPtyCashWkSave.jsp?Store=<%=sStore%>"
     + "&Week=<%=sWkend%>"
     + "&Sts=CHKREQ"
     + "&Payee=" + payto
     + "&Action=CHGCHK"

   //alert(url)
   //window.location.href = url
   if(isIE){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
   else if(isSafari){ window.frame1.location.href = url; }
}
//--------------------------------------------------------
// display/hide Onhand amount
//--------------------------------------------------------
function chgTotalBoxAmount(action)
{
  var hdr = null;
  if(action=="CHGTOT"){ hdr = "Change Total Amount"; }
  else if(action=="CHGONH"){ hdr = "Change Cash Onhand"; }

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popTotalBoxAmount(action);

   html += "</td></tr></table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvEntry.style.width = "250";}
   else { document.all.dvEntry.style.width = "auto";}
   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.left=getLeftScreenPos() + 150;
   document.all.dvEntry.style.top=getTopScreenPos() + 100;
   document.all.dvEntry.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Column Panel for update
//--------------------------------------------------------
function popTotalBoxAmount(action)
{
  var panel = "<table border=0 width='100%' cellPadding='3' cellSpacing='0'>"

  if(action=="CHGTOT")
  {
     panel += "<tr><td class='Prompt3' nowrap>Change Total Petty Cash Amount:</td>"
          + "<td class='Prompt' nowrap>"
            + "<input name='Amount' class='Small'>"
          + "</td>"
        + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan=2><br><br>"
        + "<button onClick='ValidateTotBox(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// validate weekly spending to A/P or respond from A/P
//--------------------------------------------------------
function ValidateTotBox(action)
{
   var msg = "";
   var error = false
   var chgonh = " ";
   var amt = document.all.Amount.value.trim();


   if(action=="CHGTOT"){ amt = document.all.Amount.value.trim(); }
   else if(action=="CHGONH")
   {
     if(document.all.ChgOnhand.checked){ chgonh = "Y"; }
     else { amt = 0; }
   }

   if(error) { alert(msg) }
   else { sbmTotBox(amt, chgonh, action) }
}

//--------------------------------------------------------
// submit weekly spending to A/P for review
//--------------------------------------------------------
function sbmTotBox(amt, chgonh, action)
{
   var url = "StrPtyCashWkSave.jsp?Store=<%=sStore%>"
     + "&Week=<%=sWkend%>"
     + "&ChgOnh=" + chgonh
     + "&Amt=" + amt
     + "&Action=" + action

   //alert(url)
   //window.location.href = url
   if(isIE){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
   else if(isSafari){ window.frame1.location.href = url; }
}
//--------------------------------------------------------
// receive Reimbersing Check
//--------------------------------------------------------
function rcvRmbChk(str, week, chkamt, totamt)
{
  var hdr = "Receive Reimbersing Check";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popRmbChk(str, week, chkamt, totamt);

   html += "</td></tr></table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvEntry.style.width = "250";}
   else { document.all.dvEntry.style.width = "auto";}
   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.left=getLeftScreenPos() + 150;
   document.all.dvEntry.style.top=getTopScreenPos() + 100;
   document.all.dvEntry.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Column Panel for update
//--------------------------------------------------------
function popRmbChk(str, week, chkamt, totamt)
{
  var panel = "<table border=0 cellPadding='3' cellSpacing='0'>"

  panel += "<tr><td class='Prompt3' nowrap>Check Amount:</td>"
          + "<td class='Prompt' nowrap>$" + chkamt + "</td>"
        + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=2><br><br>"
        + "<button onClick='ValidateRmbChk(&#34;"
           + str + "&#34;, &#34;"
           + week + "&#34;, &#34;"
           + chkamt + "&#34;, &#34;"
           + totamt + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// validate weekly spending to A/P or respond from A/P
//--------------------------------------------------------
function ValidateRmbChk(str, week, chkamt, totamt)
{
   var msg = "";
   var error = false

   if(error) { alert(msg) }
   else
   {
     sbmRmbChk(str, week, chkamt);
     sbmTotBox(eval(chkamt) + eval(totamt), " ", "CHGTOT");
   }
}
//--------------------------------------------------------
// submit Reimbersing Check
//--------------------------------------------------------
function sbmRmbChk(str, week, amt)
{
   var url = "StrPtyCashWkSave.jsp?Store=" + str
     + "&Week=" + week
     + "&Sts=CHKRCVD"
     + "&Amt=" + amt
     + "&Action=CHGCHK"

   //alert(url)
   //window.location.href = url;    
   if(isIE){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
   else if(isSafari){ window.frame1.location.href = url; }
}
//--------------------------------------------------------
// display/hide Onhand amount
//--------------------------------------------------------
function dspOnHandAmt(chkOnhAmt)
{
  	if(chkOnhAmt.checked){ document.all.trOnhand.style.display ="none"; }
  	else 
  	{ 
	  	if(isIE && ua.indexOf("MSIE 7.0") >= 0) {document.all.trOnhand.style.display = "block";}
	  	else {document.all.trOnhand.style.display = "table-row";}
  	}
}
//--------------------------------------------------------
// restart after add/update/delete
//--------------------------------------------------------
function reStart()
{
   window.location.reload();
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>



<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvEntry" class="dvEntry"></div>
<div id="dvStatus" class="dvEntry"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Store Petty Cash Weekly Entry
        <br>Store: <%=sStore%> &nbsp; &nbsp; &nbsp; &nbsp;
        Petty Cash Period Ending: <%=sWkend%><br>
        </B><br>
        <br>  
        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="StrPtyCashWkSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp; &nbsp;
        </button>
    </td >
  </tr>
       
  <tr>
  	<td style="font-size:14px;background:yellow;border:black 1px solid;">
     	<span style="font-size:24px;text-align:center; width:100%">Attention</span>
     	<br>
     	Petty Cash Checks by default will always be written out to the Store Manager 
     	unless otherwise noted. 
     	For any changes necessitated by extended absence, position changes etc. the EOW 
     	closing Key-Holder must send an ACTION to Finance 
     	(Expense Reports & Petty Cash) by close of business Sunday. 
     	The DM must approve this requested change in the ACTION  
     	before EOD  the following Monday for the check to be cut in a timely manner.     	     	
  	</td>
  </tr>
       
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.   
<!-- ======================================================================= -->
       <table class="DataTable" id="tbRtvEnt">
         <tr class="DataTable">
            <th class="DataTable">Pay<br>Date<br>
              <%if(bAllowChg){%><a href="javascript: showEntry('ADD', null, null, null, null, null, null)">New Entry</a><%}%>
            </th>
            <th class="DataTable">C<br>h<br>a<br>n<br>g<br>e</th>
            <th class="DataTable">Pay<br>Type</th>            
            <th class="DataTable">Spiff</th>
            <th class="DataTable">Description</th>
            <th class="DataTable">Emp</th>
            <th class="DataTable">Pay To</th>            
            <th class="DataTable">Amount</th>
            <th class="DataTable">D<br>e<br>l<br>e<br>t<br>e</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfEnt; i++ ){%>
           <tr class="DataTable">
              <td class="DataTable" nowrap><%=sPayDate[i]%></td>
              <td class="DataTable">
                 <%if(bAllowChg){%><a href="javascript: showEntry('UPD', '<%=sIdNum[i]%>','<%=sPTyDesc[i]%>','<%=sSpfDesc[i]%>','<%=sEmp[i]%>', &#34;<%=sPayee[i]%>&#34;,'<%=sAmt[i]%>')">&nbsp;C&nbsp;</a><%}%>
              </td>
              <td class="DataTable1" nowrap><%=sPTyDesc[i]%></td>
              <td class="DataTable1" nowrap><%=sSpfDesc[i]%></td>
              <td class="DataTable1" nowrap><%=sNote[i]%>&nbsp;</td>
              <td class="DataTable2" nowrap><%=sEmp[i]%></td>
              <td class="DataTable1" nowrap><%=sPayee[i]%></td>              
              <td class="DataTable2" nowrap><%=sAmt[i]%></td>
              <td class="DataTable">
              <%if(bAllowChg){%><a href="javascript: showEntry('DLT', '<%=sIdNum[i]%>','<%=sPTyDesc[i]%>','<%=sSpfDesc[i]%>','<%=sEmp[i]%>', &#34;<%=sPayee[i]%>&#34;,'<%=sAmt[i]%>')">&nbsp;D&nbsp;</a><%}%>
              </td>
           </tr>
       <%}%>
       <!-- ============================ Total ============================= -->
       <tr class="DataTable1">
          <td class="DataTable2" colspan=6 nowrap>
             Total spending (spiffs, meals, supplies entered):
             <br>Cash on hands (actual coins, bills & uncashed petty cash checks on-hand):
             <br>Amount unaccounted for:
             <br>Total petty cash (Total spending + Cash on hands):
          </td>
          <td class="DataTable2" nowrap>
             <%=sTotSpent%>
             <br><%=sOnHand%>
             <br><%=sUnacctAmt%>
             <br><%if(bAPDept && !sStrWkSts.equals("PROCESSED")){%><a href="javascript: chgTotalBoxAmount('CHGTOT')"><%=sBegWkBoxAmt%></a><%} else {%><%=sBegWkBoxAmt%><%}%>
          </td>

      <!-- ============= Pending Check List ===================== -->
          <td class="DataTable2" colspan=3>
           <%if(iNumOfChk > 0){%>
             <table border=1 cellPadding="0" cellSpacing="0">
               <tr>
                 <th class="DataTable5" colspan=3>Reimbersing Checks</th>
                 <th class="DataTable5" rowspan=2>R<br>c<br>v</th>
               </tr>
               <tr>
                 <th class="DataTable5">Week</th>
                 <th class="DataTable5">Pay To</th>
                 <th class="DataTable5">Amount</th>
               </tr>
               <%for(int i=0; i < iNumOfChk; i++){%>
                 <tr class="DataTable2">
                    <td class="DataTable2"><%=sChkWeek[i]%></td>
                    <td class="DataTable1"><%=sChkPayTo[i]%></td>
                    <td class="DataTable2"><%=sChkAmt[i]%></td>
                    <td class="DataTable2"><a href="javascript: rcvRmbChk('<%=sChkStr[i]%>','<%=sChkWeek[i]%>', '<%=sChkAmt[i]%>', '<%=sBegWkBoxAmt%>')">R</a></td>
                 </tr>
               <%}%>
             </table>
           <%}%>
          </td>
       </tr>


       <tr class="DataTable1">
          <td class="DataTable1" colspan=10 nowrap>
            <%if(sStrWkSts.equals("OPEN")){%>
               Click <a href="javascript: showChgStsPanel('<%=sOnHand%>')">here</a> to send weekly spending for review by A/P department.
            <%}%>
            <%if(bAPDept && sStrWkSts.equals("SUBMIT")){%>
               Click <a href="javascript: showChgStsPanel()">here</a> to change status.
            <%}%>
          </td>
       </tr>
     </table>

      </TD>
     </TR>
     
     

     <tr>   
       <td style="text-align:center">
<table>
  <tr>
  	<td style="font-size:12px;text-align:center>
       <span style="font-size:14px;"><b>IMPORTANT NOTES:</b></span>
		
		<br>*Spiffs are created ONLY by the home office. 
		<br>*Salaried Managers may earn VENDOR SPIFFS ONLY. Ex. Superfeet	
		<br>*Bike tent spiffs are only earned during or leading up to bike tent sales.
		<br>*Other should only be used if the spiff given does not match any type above.	
		<br>*Super feet Spiffs are $5.00 for every pair of super feet sold.
		<br>*Keep it peddling spiffs is $5.00 for any 3 or 5 year program sold.
		<br>*GE spiffs are $5.00 for applications and $25.00 for GE purchase over $1,000.
		
	</td>
</tr>
</table>
       </TD>
     </TR>

    </TBODY>
   </TABLE>
</BODY></HTML>
<%

   strpty.disconnect();
   strpty = null;
   }
%>
