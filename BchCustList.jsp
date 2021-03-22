<%@ page import="badcredhist.BchCustList ,java.util.*, java.text.*"%>
<%
   String sSrchStr = request.getParameter("Str");
   if(sSrchStr == null){ sSrchStr = "ALL"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BchCustList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   String sUser = session.getAttribute("USER").toString();
   String sStrAllowed = session.getAttribute("STORE").toString();
   boolean bChgAllowed = false;
   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
      bChgAllowed = true;
   }

   BchCustList bchcustl = new BchCustList(sSrchStr, sUser);
%>
<html>
<head>
<title>Missing_Customer_Info</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: LemonChiffon; font-family:Arial; font-size:10px; text-align:center;}

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
        td.DataTable31 {background: orange; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
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
        #tdAllInv { display: none; }
        #tdAvlInv { display: block; }

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

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
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelStr = "<%=sSrchStr%>";
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// get store notes
//==============================================================================
function getReplyNote(cust, fname, mname, lname, note)
{var hdr = "Customer: " + cust + " &nbsp; Store Notes";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popReplyNotePanel(cust, fname, mname, lname, note)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 140;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.visibility = "visible";
   document.all.Note.value = note;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popReplyNotePanel(cust, fname, mname, lname, note)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable9'>"
            + "<td style='text-align:left;'>Name: "
            + fname + " " + mname + " " + lname + "</td>"
          + "</td>"
          + "<tr class='DataTable9'>"
            + "<td style='text-align:center;'>"
               + "<textarea class='Small' name='Note' cols=120 rows=5></textarea>"
            + "</td>"
          + "</td>"
        + "</tr>"

  panel += "<tr class='DataTable9'>";
  panel += "<td colspan=2 ><br><br><button onClick='ValidateNote(&#34;" + cust + "&#34;)' class='Small'>Save</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// validate new status
//==============================================================================
function ValidateNote(cust)
{
   var error=false;
   var msg = "";

   var note = document.all.Note.value.trim();
   if(note == ""){ error=true; msg += "\nPlease enter Note text." }

   var action = "STR_NOTE";

   if(error){ alert(msg); }
   else{ sbmStrNote(cust, note, action) }
}
//==============================================================================
// submit new status
//==============================================================================
function sbmStrNote(cust, note, action)
{

    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='BchSave.jsp'>"
       + "<input class='Small' name='CustId'>"
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.CustId.value = cust;
   window.frame1.document.all.Commt.value=note;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
}
//==============================================================================
// delete customer
//==============================================================================
function dltCust(cust, fname, mname, lname)
{
   var hdr = "Customer: " + cust;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStatusPanel(cust, fname, mname, lname)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 140;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popStatusPanel(cust, fname, mname, lname)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable9'>"
            + "<td style='text-align:left;'>Name: "
            + fname + " " + mname + " " + lname + "</td>"
          + "</td>"
          + "<tr class='DataTable9'>"
            + "<td style='text-align:center;'>Are you sure - you want to delete customer?</td>"
          + "</td>"
        + "</tr>"

  panel += "<tr class='DataTable9'>";
  panel += "<td colspan=2 ><br><br><button onClick='ValidateSts(&#34;" + cust + "&#34;)' class='Small'>Delete</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// validate new status
//==============================================================================
function ValidateSts(cust)
{
   var error=false;
   var msg = "";
   var action = "DLT_CUST";

   if(error){ alert(msg); }
   else{ sbmNewSts(cust, action) }
}
//==============================================================================
// submit new status
//==============================================================================
function sbmNewSts(cust, action)
{
   var url = "BchSave.jsp?"
     + "&CustId=" + cust
     + "&Action=" + action

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// restart
//==============================================================================
function restart(cust)
{
   var url ="BchCustList.jsp?&Str=" + SelStr;

   window.location.href = url;
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
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
    <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <div >
           <table style="border:lightblue outset 3px;background: yellow; font-family:Arial; width:100% ">
              <tr>
                <td colspan=3>Current Promotion: 12 Months No Interest WITH Monthly Payments*<td>
              </tr>
              <tr>
                <td width="25%">Current Promo Code :112
                <br>Current Application Color: <span style="color: orange; font-weight:bold">ORANGE</span>
                <!--br>*Minimum purchase transaction of $999 to qualify for promotional financing -->
                <br>*No minimum purchase required to qualify for promotional financing
                </td>
                <td style="color:red; font-size:30; text-align:center;">No Card - No Sale</td>
                <td width="25%">&nbsp;</td>
              </tr>
           </table>
        </div>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc.
      </td>
    </tr>

     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Missing Customer Information
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="BchCustListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
      <% if(bChgAllowed) {%>&nbsp; &nbsp; <a href="BchCustInfo.jsp" target="_blank">New Contract</a><%}%>
      &nbsp; &nbsp; <a href="javascript: if (confirm('Did you check the customer list below?')){ window.location.href = 'https://businesscenter.synchronybusiness.com/portal/login' }">Synchrony Access</a>
      <br>
      <br>
      <span style="font-size:22;font-family:Arial">
        If your customer or account last 4 digits is listed below issues must be resolved before proceeding.
      </span>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable" rowspan=2>Customer</th>
          <th class="DataTable" rowspan=2>Card</th>
          <th class="DataTable" rowspan=2>Store</th>
          <th class="DataTable" rowspan=2>Problem Description</th>
          <th class="DataTable" rowspan=2>Issues/Clear by/Comments</th>
          <th class="DataTable" rowspan=2>R<br>e<br>p<br>l<br>y</th>
          <th class="DataTable" colspan=3>Posted</th>
          <% if(bChgAllowed) {%>
             <th class="DataTable" rowspan=2>Delete</th>
          <%}%>
        </tr>

        <tr class="DataTable">
          <th class="DataTable">User</th>
          <th class="DataTable">Date</th>
          <th class="DataTable">Time</th>
       </tr>
   <!-------------------------- Example ------------------------------->
       <tr class="DataTable2"><td style="border-bottom:darkred solid 1px; font-size:12px; font-weight:bold" colspan=10>Example</td>
       <tr class="DataTable">
          <td class="DataTable">JOHN JACOBS SMITH</td>
          <td class="DataTable">9999</td>
          <td class="DataTable">03</td>
          <td class="DataTable">Application form not signed.<br>
             Contact Store 8 (281-823-5154) and have the Application Form faxed to you for customer's signature.<br>
             Make sure the Name and signature on the DRIVER'S LICENSE, GE credit card and Application form matches.
             Affix your initial on the verified by portion of Application form.
          </td>
          <td class="DataTable">
              1/20/2012: Contacted Store 8, applilcation faxed to us, customer was properly ID'd,
              signed application form, photo and signatures matched. Faxed copy back to Store 8.
              Customer is happy. Jim Stout.
          </td>
          <td class="DataTable">R</td>
          <td class="DataTable">eocampo</td>
          <td class="DataTable">01/12/2012</td>
          <td class="DataTable">12:34 PM</td>
          <% if(bChgAllowed) {%>
             <td class="DataTable">Delete</td>
          <%}%>
        </tr>
        <tr class="DataTable2"><td style="border-bottom:darkred solid 4px; font-size:12px; font-weight:bold" colspan=10>&nbsp;</td>
  <!-------------------------- Order List ------------------------------->
      <%
       while(bchcustl.getNext())
       {
          bchcustl.getCustInfo();

          String sCust = bchcustl.getCust();
          String sFName = bchcustl.getFName();
          String sMName = bchcustl.getMName();
          String sLName = bchcustl.getLName();
          String sCard = bchcustl.getCard();
          String sStr = bchcustl.getStr();
          String sByUser = bchcustl.getByUser();
          String sRecDt = bchcustl.getRecDt();
          String sRecTm = bchcustl.getRecTm();
          String sComment = bchcustl.getComment();
          String sNote = bchcustl.getNote();
      %>
         <tr class="DataTable1">
           <td class="DataTable">
             <% if(bChgAllowed) {%>
                <a href="BchCustInfo.jsp?&CustId=<%=sCust%>" target="_blank">
                   <%=sFName%> <%=sMName%> <%=sLName%>
                </a>
             <%} else {%><%=sFName%> <%=sMName%> <%=sLName%><%}%>
           </td>
           <td class="DataTable2"><%=sCard%></td>
           <td class="DataTable1"><%=sStr%></td>
           <td class="DataTable"><%=sComment%></td>
           <td class="DataTable"><%=sNote%></td>
           <td class="DataTable"><a href="javascript: getReplyNote('<%=sCust%>', '<%=sFName%>'
               , '<%=sMName%>', '<%=sLName%>', '<%=sNote%>')">R</a></td>
           <td class="DataTable2"><%=sByUser%></td>
           <td class="DataTable2"><%=sRecDt%></td>
           <td class="DataTable2"><%=sRecTm%></td>
           <% if(bChgAllowed) {%>
             <td class="DataTable"><a href="javascript: dltCust('<%=sCust%>', '<%=sFName%>'
               , '<%=sMName%>', '<%=sLName%>')">Delete</a></td>
           <%}%>
         </tr>
      <%}%>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>


<%  bchcustl.disconnect();
  }%>