<%@ page import="rciutility.StoreSelect"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StoreEvent.jsp&APPL=ALL");
}
else
{
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;


    StrSelect = new StoreSelect();

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();
%>

<html>
<head>
<style>
  td.DTb1 { text-align:left; }
  td.DTb11 { text-align:right; }
  sup { color:red; vertical-align:top; font-size:12px;}
</style>
<SCRIPT language="JavaScript">

//==============================================================================
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
//==============================================================================
// initializing
//==============================================================================
function bodyLoad()
{
  doStrSelect();
}

//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    for (i = 1; i < stores.length; i++)
    {
      document.all.Store.options[i-1] = new Option(stores[i] + " - " + storeNames[i],
                                           stores[i]);
    }
    document.all.Store.selectedIndex=0;
}
//==============================================================================
// change action on submit
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";
   var str = document.all.Store.options[document.all.Store.selectedIndex].value;
   var strnm = storeNames[document.all.Store.selectedIndex+1].trim();
   var event = document.all.Event.value.trim(" ");
   var date = document.all.Date.value.trim(" ");
   var time = document.all.Time.value.trim(" ");
   var desc = document.all.Desc.value.trim(" ");
   var cont = document.all.ContName.value.trim(" ");
   var phone = document.all.ContPhone.value.trim(" ");
   var email = document.all.ContEMail.value.trim(" ");

   if(event == "" || event == " ") {error = true;  msg += "Please, enter Event Name.\n"}
   if(date == "" || date == " ") {error = true;  msg += "Please, enter Event Date.\n"}
   if(time == "" || time == " ") {error = true;  msg += "Please, enter Event Time.\n"}
   if(desc == "" || desc == " ") {error = true;  msg += "Please, enter Description.\n"}
   if(cont == "" || cont == " ") {error = true;  msg += "Please, enter Contact Name.\n"}
   if(phone == "" || phone == " ") {error = true;  msg += "Please, enter Contact Phone.\n"}
   if(email == "" || email == " ") {error = true;  msg += "Please, enter Contact EMail.\n"}

   if(error){ alert(msg); }
   else { submitForm(str, strnm, event, date, time, desc, cont, phone, email) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(str, strnm, event, date, time, desc, cont, phone, email){
   var url = "StoreEventSend.jsp"
        + "?Store=" + str
        + "&StrName=" + strnm
        + "&Event=" + event
        + "&Date=" + date
        + "&Time=" + time
        + "&Desc=" + desc
        + "&Cont=" + cont
        + "&Phone=" + phone
        + "&EMail=" + email

   //alert(url);
   window.location.href=url;
}
</SCRIPT>
<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>

</head>
 <body  onload="bodyLoad();">
  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Store Event Entry<br>

      <a href="../"><font color="red" size="-1">Home</font></a>&#62
      <font size="-1">This page</font>

      <table>
      <!-- ======================== Store ====================================== -->
      <tr>
         <td class=DTb11 >Store:</td><td><SELECT name="Store"></SELECT><sup>*</sup></td>
         <td colspan="2" align="center"></td>
      </tr>

      <!-- ======================== Event ======================================= -->
        <TR>
          <TD class=DTb11 >Event Name:</TD>
          <TD><input name="Event" type="text" size=50 maxlength=50><sup>*</sup></TD>
        </TR>
        <!-- ======================== Date ======================================= -->
        <TR>
          <TD class=DTb11>Event Date:</TD>
          <TD><input name="Date" type="text" size=10 maxlength=10><sup>*</sup></TD>
        </TR>
        <!-- ======================== Time ======================================= -->
        <TR>
          <TD class=DTb11>Event Time:</TD>
          <TD><input name="Time" type="text" size=10 maxlength=10><sup>*</sup></TD>
        </TR>
        <!-- ======================== Description ======================================= -->
        <TR>
          <TD class=DTb11>Description:</TD>
          <TD><TextArea name="Desc" cols=80 rows=4></TextArea><sup>*</sup></TD>
        </TR>
        <!-- ======================== Contact ======================================= -->
        <TR>
          <TD class=DTb11>Contact Person:</TD>
          <TD><input name="ContName" type="text" size=50 maxlength=50><sup>*</sup></TD>
        </TR>
        <TR>
          <TD class=DTb11>Contact Phone:</TD>
          <TD><input name="ContPhone" type="text" size=14 maxlength=14><sup>*</sup></TD>
        </TR>
        <TR>
          <TD class=DTb11>Contact E-Mail:</TD>
          <TD><input name="ContEMail" type="text" size=50 maxlength=50><sup>*</sup></TD>
        </TR>

        <!-- ========================   Note  ================================= -->
        <TR>
          <TD class=DTb1 colspan=2><font color=red>*</font> <font size="-1">Note: Please, enter information in all fields.</font></td>
        </TR>

        <!-- ======================== Buttons  ================================= -->
        <TR>
          <TD class=DTb1 align=center>&nbsp;</td>
          <td><button onclick="Validate()">Send</button></TD>
        </TR>
      <!-- ==========================++++++===================================== -->
      </table>
      </td>
     </tr>
    </table>

   </body>
</html>
<%}%>