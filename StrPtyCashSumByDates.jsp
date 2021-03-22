<%@ page import="storepettycash.StrPtyCashSumByDates, java.util.*"%>
<%
    String sFrDate = request.getParameter("FrDate");
    String sToDate = request.getParameter("ToDate");
//----------------------------------
// Application Authorization
//----------------------------------
String sAppl = "PTYCSHAP";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !(session.getAttribute(sAppl) == null))
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrPtyCashSumByDates.jsp");
}
else
{
	StrPtyCashSumByDates strpty = new StrPtyCashSumByDates(sFrDate, sToDate, session.getAttribute("USER").toString());

    int iNumOfTyp = strpty.getNumOfTyp();
    String [] sPtyType = strpty.getPtyType();
    String [] sPtyTypeDesc = strpty.getPtyTypeDesc();
    String [] sPtyTypeColHdg1 = strpty.getPtyTypeColHdg1();
    String [] sPtyTypeColHdg2 = strpty.getPtyTypeColHdg2();

    int iNumOfSpf = strpty.getNumOfSpf();
    String [] sSpiffType = strpty.getSpiffType();
    String [] sSpiffDesc = strpty.getSpiffDesc();
    String [] sSpiffColHdg1 = strpty.getSpiffColHdg1();
    String [] sSpiffColHdg2 = strpty.getSpiffColHdg2();

    int iNumOfStr = strpty.getNumOfStr();
    String [] sStr = strpty.getStr();
    String [][] sPtyAmt = strpty.getPtyAmt();
    String [][] sSpfAmt = strpty.getSpfAmt();
    String [] sSts = strpty.getSts();
    String [] sStrSpent = strpty.getStrSpent();
    String [] sStrOnHand = strpty.getStrOnHand();
    String [] sStrUnacctAmt = strpty.getStrUnacctAmt();
    String [] sStrBegWkBoxAmt = strpty.getStrBegWkBoxAmt();
    String [] sChkSts = strpty.getChkSts();
    String [] sChkPayTo = strpty.getChkPayTo();
    String [] sChkAmt = strpty.getChkAmt();
    String [] sComment = strpty.getComment();

    String sWkdateJsa = strpty.getWkdateJsa();

    String sTotSpent = strpty.getTotSpent();
    String sOnHand = strpty.getOnHand();
    String sUnacctAmt = strpty.getUnacctAmt();
    String sBegWkBoxAmt = strpty.getBegWkBoxAmt();
    String [] sTotPty = strpty.getTotPty();
    String [] sTotSpf = strpty.getTotSpf();
    String sTotCheck = strpty.getTotCheck();

    boolean bAPDept = session.getAttribute("PTYCSHAP") != null;
%>

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
        tr.DataTable2 { background: Azure; font-size:10px; font-weight: bold }

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
        td.Comments { background: white; text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
</style>


<script name="javascript1.3">
var Wkdate = [<%=sWkdateJsa%>];
var DisplayComments = "block";
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEntry", ["dvStatus"]]);
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
// display/hide Onhand amount
//--------------------------------------------------------
function chgStrWkSts(str,sts, onhand)
{
  var hdr = null;
  hdr = "Change Store Weekly Status";
  if(str =="ALL"){ hdr = "Close All Stores Weekly Status"; }

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popChgStrWkSts(str,sts, onhand);

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
function popChgStrWkSts(str,sts, onhand )
{
  var panel = "<table border=0 width='100%' cellPadding='3' cellSpacing='0'>"

  panel += "<tr><td class='Prompt3' nowrap>Status:</td>"
          + "<td class='Prompt' nowrap>"
            + "<select name='selSts' class='Small'>"
              + "<option value='OPEN' >OPEN</option>"
              + "<option value='SUBMIT'>SUBMIT</option>"
              + "<option value='CLOSE' selected>CLOSE</option>"
            + "</select>"
            + "<input type='hidden' name='Str' class='Small' value='" + str + "'>"
            + "<input type='hidden' name='Onhand' class='Small' value='" + onhand + "'>"
          + "</td>"
        + "</tr>"

  panel += "<tr><td class='Prompt3' nowrap>Comments:</td>"
          + "<td class='Prompt' nowrap>"
            + "<textarea name='Comment' cols=100 rows=10 class='Small'></textarea>"
          + "</td>"
        + "</tr>"


  panel += "<tr><td class='Prompt1' colspan=2><br><br>"
        + "<button onClick='ValidateChgStrWkSts()' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// validate weekly spending to A/P or respond from A/P
//--------------------------------------------------------
function ValidateChgStrWkSts()
{
   var msg = "";
   var error = false;

   var str = document.all.Str.value.trim();
   var sts = document.all.selSts.options[document.all.selSts.selectedIndex].value
   var amt = document.all.Onhand.value.trim();
   var comment = document.all.Comment.value.trim().replaceSpecChar();

   if(error) { alert(msg) }
   else
   {
     sbmChgStrWkSts(str, sts, comment)
     if(sts == "CLOSE"){ sbmRollupTotal(str, amt) }
   }
}


//--------------------------------------------------------
// display/hide Onhand amount
//--------------------------------------------------------
function dspOnHandAmt(chkOnhAmt)
{
  if(chkOnhAmt.checked){ document.all.Amount.style.visibility ="visible"; }
  else { document.all.Amount.style.visibility = "hidden"; }
}
//--------------------------------------------------------
// change reimbersing check status
//--------------------------------------------------------
function chgChkSts(str, sts, payto, chkamt, spentamt)
{
  var hdr = null;
  hdr = "Send Check To The Store";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popChkStsPanel(str, sts, payto);

   html += "</td></tr></table>"

   document.all.dvEntry.innerHTML = html;
   document.all.dvEntry.style.width = 250;
   document.all.dvEntry.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvEntry.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvEntry.style.visibility = "visible";
   if (sts == "CHKREQ"){ document.all.Amount.value = spentamt; }
   else { document.all.Amount.value = chkamt; }
}
//--------------------------------------------------------
// populate Column Panel for update
//--------------------------------------------------------
function popChkStsPanel(str, sts, payto)
{
  var panel = "<table border=0 width='100%' cellPadding='3' cellSpacing='0'>"

  panel += "<tr><td class='Prompt3' nowrap>Pay To:</td>"
          + "<td class='Prompt' nowrap>"
            + "<input name='PayTo' class='Small' value='" + payto + "'>"
            + "<input type='hidden' name='Str' class='Small' value='" + str + "'>"
          + "</td>"
        + "</tr>"

  panel += "<tr><td class='Prompt3' nowrap>Check Amount:</td>"
          + "<td class='Prompt' nowrap>"
            + "<input name='Amount' class='Small'>"
          + "</td>"
        + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=2><br><br>"
        + "<button onClick='ValidateChk()' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// validate check status
//--------------------------------------------------------
function ValidateChk()
{
   var msg = "";
   var error = false

   var str = document.all.Str.value.trim();
   var payto = document.all.PayTo.value.trim();
   var amt = document.all.Amount.value.trim();
   var sts = "CHKSNT";

   if(payto=="") { error=true; msg += "Please, Type 'Pay To' name.\n";}

   if(amt=="") { error=true; msg += "Check amount cannot be blank.\n";}
   else if(isNaN(amt)) { error=true; msg += "Check amount is not numeric.\n";}
   else if(eval(amt) <= 0) { error=true; msg += "Check amount cannot be blank or negative.\n";}

   if(error) { alert(msg) }
   else { sbmChkSts(str, sts, payto, amt) }
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
        <br>From Date: <%=sFrDate%> To Date: <%=sToDate%>
        <br>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="StrPtyCashSumByDatesSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp; &nbsp;
        </button>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
            <th class="DataTable" rowspan=2>Store</th>
            <th class="DataTable" rowspan=2>Sts<br>&<br>Comm<br>Log</th>
            <th class="DataTable" colspan=<%=iNumOfTyp%>>Pay Entry Types</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=<%=iNumOfSpf%>>Spiff Types</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
                        <th class="DataTable" rowspan=2>Spent</th>
            <th class="DataTable" rowspan=2>Cash<br>Onhands</th>
            <th class="DataTable" rowspan=2>Amount<br>Unaccounted<br>for</th>
            <th class="DataTable" rowspan=2>Total<br>Petty<br>Cash</th>
         </tr>

         <tr class="DataTable">
            <%for(int j=0; j < iNumOfTyp; j++ ){%>
               <th class="DataTable"><%=sPtyTypeColHdg1[j]%><br><%=sPtyTypeColHdg2[j]%></th>
            <%}%>
            <%for(int j=0; j < iNumOfSpf; j++ ){%>
               <th class="DataTable"><%=sSpiffColHdg1[j]%><br><%=sSpiffColHdg2[j]%></th>
            <%}%>
             
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfStr; i++ ){%>
           <tr class="DataTable">
              <td class="DataTable2" nowrap>
              <%=sStr[i]%></td>
              <th class="DataTable"><a href="javascript: getStsCom('<%=sStr[i]%>')">S<%if(sComment[i].equals("1")){%> & C<%}%></a></th>
              <%for(int j=0; j < iNumOfTyp; j++ ){%>
                 <td class="DataTable2"><%=sPtyAmt[i][j]%></td>
              <%}%>
              <th class="DataTable">&nbsp;</th>
              <%for(int j=0; j < iNumOfSpf; j++ ){%>
                 <td class="DataTable2"><%=sSpfAmt[i][j]%></td>
              <%}%>
              <th class="DataTable">&nbsp;</th>
              
              <td class="DataTable2"><%=sStrSpent[i]%></td>
              <td class="DataTable2"><%=sStrOnHand[i]%></td>
              <td class="DataTable2"><%=sStrUnacctAmt[i]%></td>
              <td class="DataTable2"><%=sStrBegWkBoxAmt[i]%></td>
           </tr>
       <%}%>
       <!-- ============================ Total =========================== -->
       <tr class="DataTable1">
           <td class="DataTable2" nowrap>Total</td>
           <th class="DataTable">&nbsp;</th>
           <%for(int j=0; j < iNumOfTyp; j++ ){%>
              <td class="DataTable2"><%=sTotPty[j]%></td>
           <%}%>
           <th class="DataTable">&nbsp;</th>
           <%for(int j=0; j < iNumOfSpf; j++ ){%>
              <td class="DataTable2"><%=sTotSpf[j]%></td>
           <%}%>
           <th class="DataTable">&nbsp;</th>
            

           <td class="DataTable2"><%=sTotSpent%></td>
           <td class="DataTable2"><%=sOnHand%></td>
           <td class="DataTable2"><%=sUnacctAmt%></td>
           <td class="DataTable2"><%=sBegWkBoxAmt%></td>
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