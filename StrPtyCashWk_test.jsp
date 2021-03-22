
<HTML>
<HEAD>
<title>Store Petty Cash</title>
<META content="RCI, Inc." name="Store_Petty_Cash"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:center; font-size:11px;}
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:10px }
        th.DataTable4 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:10px }

        th.DataTable5 { background:#82caff ;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:10px }

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:12px; font-weight: bold }
        tr.DataTable2 { background: azure; font-size:10px;}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background: #b0b0b0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEntry { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
        td.Prompt4 { color: red; text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; font-weight:bold}
        td.Comments { background: white; text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
</style>


<script name="javascript1.3">
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEntry", "dvStatus"]);
   
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

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 10;
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

   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.width = 250;
   document.all.dvEntry.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvEntry.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvEntry.style.visibility = "visible";

   if(action == "ADD")
   {
     document.all.PayType[0].checked = true;
     document.all.Spiff[0].checked = true;
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
    document.all.trSpiff.style.display = "block"
    document.all.selEmpLst.style.display = "block"
    document.all.Emp.style.display = "inline";
    document.all.linkToOtherStr.style.display = "inline"
    document.all.Emp.value = "";
    document.all.Payee.readOnly = true;
    document.all.Payee.value = "";

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

      note = document.all.Note.value.trim(); 
      if(payty == "SPIFF" 
         && (spiff== 'VENDOR' || spiff == 'CONTEST' || spiff == 'OTHER' || spiff == 'HOMEOFFICE') 
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
   var nwelem = window.frame1.document.createElement("div");
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
   window.frame1.document.appendChild(nwelem);
   
   note = note.replace(/\n\r?/g, '<br />');

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

   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.width = 250;
   document.all.dvEntry.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvEntry.style.pixelTop= document.documentElement.scrollTop + 100;
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

  return panel;
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
function sbmRollupTotal(str, amt)
{
    
   //window.frame1.location.href = html
}
//--------------------------------------------------------
// submit weekly spending to A/P for review
//--------------------------------------------------------
function sbmCheckSts(payto)
{
    
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

   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.width = 250;
   document.all.dvEntry.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvEntry.style.pixelTop= document.documentElement.scrollTop + 100;
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

   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.width = 250;
   document.all.dvEntry.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvEntry.style.pixelTop= document.documentElement.scrollTop + 100;
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
   var html = "StrPtyCashWkSave.jsp?Store=" + str
     + "&Week=" + week
     + "&Sts=CHKRCVD"
     + "&Amt=" + amt
     + "&Action=CHGCHK"

   //alert(html)
   //window.location.href = html
   window.frame1.location.href = html
}
//--------------------------------------------------------
// display/hide Onhand amount
//--------------------------------------------------------
function dspOnHandAmt(chkOnhAmt)
{
  if(chkOnhAmt.checked){ document.all.trOnhand.style.display ="none"; }
  else { document.all.trOnhand.style.display = "block"; }
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
     </table>

      </TD>
     </TR>

     <tr>
       <td style="font-size:12px;">
       Legend:
<br>*Super feet Spiffs are $5.00 for every pair of super feet sold.
<br>*Buyer/ Vendor Spiffs are spiffs given by the home office.
<br>*Keep it peddling spiffs is $5.00 for any 3 or 5 year program sold.
<br>*Contest spiffs are created at the store level by managers on duty.
<br>*GE spiffs are $5.00 for applications and $25.00 for GE purchase over $1,000.
<br>*Home office spiffs are created by the Home office and include cashier spiffs.
<br>*Winter challenge spiffs are earned by winning district winter challenge. Spiff must be approved by DM before pay out.
<br>*Bike tent spiffs are only earned during or leading up to bike tent sales.
<br>*Other should only be used if the spiff given does not match any type above.

       </TD>
     </TR>

    </TBODY>
   </TABLE>
</BODY></HTML>
