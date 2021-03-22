<%@ page import="rciutility.StoreSelect, rciutility.ClassSelect"%>
<%
//----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("MEMOS")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MemoSel.jsp&APPL=MEMOS&" + request.getQueryString());
   }
   else
   {
    String sUser = session.getAttribute("USER").toString();
    StoreSelect StrSelect = new StoreSelect();
    String sStr = StrSelect.getStrNum();
    String sStrName = StrSelect.getStrName();
    ClassSelect select = new ClassSelect();
    String sDiv = select.getDivNum();
    String sDivName = select.getDivName();
    String [] sType = request.getParameterValues("Type");
    if(sType==null) sType = new String[]{"COR", " ", " ", " ", " ", " "};
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>body {background:ivory; text-align:center;}
  table.DataTable { border:none;}
  td.Text { border:none; text-align:right; vertical-align:top; padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
  td.Field { border:none; text-align:left; padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
  td.Button { border:none; text-align:center; padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
</style>

<SCRIPT language="JavaScript1.2">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var divisions = [<%=sDiv%>];
var divisionNames = [<%=sDivName%>];
//==============================================================================
// run at loading
//==============================================================================
function bodyLoad()
{
    doStrSelect();
    doDivSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
   var df = document.forms[0];

   for (var i = 0; i < stores.length; i++)
   {
     df.STORE.options[i] = new Option(stores[i] + " - " + storeNames[i], stores[i]);
   }
}
//==============================================================================
// Load Divisions
//==============================================================================
function doDivSelect()
{
   var df = document.forms[0];
   for (var i = 0; i < divisions.length; i++)
   {
     df.DIVISION.options[i] = new Option(divisionNames[i], divisions[i]);
   }
}
</SCRIPT>

</head>
<body onLoad="bodyLoad()">
<table height="100%" width="100%" border="0">
<tr>
<td COLSPAN="2" height="20%"><img src="Sun_ski_logo4.png"></td>
</tr>
<tr bgColor="moccasin">
<td bgColor="A7B5E8" WIDTH="15%" VALIGN="TOP"><font face="Arial" size="2" color="#445193">
    &nbsp;&nbsp;<a href="../" class="blue">Home</a></font><font face="Arial" size="1" color="#445193">
<h5>&nbsp;&nbsp;Miscellaneous</h5>
    &nbsp;&nbsp;<a href="MAILTO:helpdesk@retailconcepts.cc" class="blue">Mail to IT</a>
<br>&nbsp;&nbsp;<a href="http://sunandski.com/" class="blue">Our Internet</a>
<br>
</font></td><td VALIGN="TOP" WIDTH="85%" align="center"><b>Retail Concepts Inc.<br>COMPANY Correspondence</b>
<form METHOD="GET" ACTION="servlet/memopool.MemoList">
<table class="DataTable" WIDTH="100%">
  <!-- --------------------------------------------------------------------- -->
  <!-- Memo Date -->
  <!-- --------------------------------------------------------------------- -->
  <tr>
    <td class="Text">Memo Date:</td><td class="Field"><input name="DATE" size=8 maxlength=8 value="ALL"><font size="-1">mm/dd/yy format</font></td>
  </tr>
  <!-- --------------------------------------------------------------------- -->
  <!-- Store -->
  <!-- --------------------------------------------------------------------- -->
  <tr>
     <td class="Text">Stores:</td>
     <td class="Field"><Select name="STORE"></Select></td>
  </tr>
  <!-- --------------------------------------------------------------------- -->
  <!-- Divisions -->
  <!-- --------------------------------------------------------------------- -->
  <tr>
    <td class="Text" >Division:</td>
    <td class="Field" ><Select name="DIVISION" size="1"></Select></td>
  </tr>
  <!-- --------------------------------------------------------------------- -->
  <!-- Search -->
  <!-- --------------------------------------------------------------------- -->
  <tr>
    <td class="Text" >Search in Title:</td>
    <td class="Field" ><input name="SEARCH" size="50"></td>
  </tr>
  <tr>
    <td class="Button" COLSPAN="2">
       <Input name="SUBMIT" type="SUBMIT" value="Submit">
       <Input name="USER" type="hidden" value="<%=sUser%>">
       <%for(int i=0; i < sType.length; i++) {%>
          <Input name="Type" type="hidden" value="<%=sType[i]%>">
       <%}%>
    </td>

  </tr>
</table>
</form>
</td>
</tr>
</table>
</body>
<SCRIPT></SCRIPT>
</html>

<%}%>