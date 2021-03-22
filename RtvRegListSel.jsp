<%@ page import="rciutility.StoreSelect, rtvregister.RtvReasonCode, rciutility.DivDptClsSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("RTVREG") == null
    && session.getAttribute("RTVREGBUYR") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RtvRegListSel.jsp&APPL=ALL&");
   }
   else
   {
      StoreSelect StrSelect = new StoreSelect(2);
      String sStr = StrSelect.getStrNum();
      String sStrName = StrSelect.getStrName();

      DivDptClsSelect DivSelect = new DivDptClsSelect();
      String sDiv = DivSelect.getDivNum();
      String sDivName = DivSelect.getDivName();

      RtvReasonCode reasCode = new RtvReasonCode();
      String sReason = reasCode.getReasonCode();
      String sReasonDesc = reasCode.getReasonDesc();

%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space: nowrap;}
        td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap;}
</style>


<script name="javascript">

var User = "<%=session.getAttribute("USER").toString()%>";
var Reason = [<%=sReason%>];
var ReasonDesc = [<%=sReasonDesc%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   popStrSelect();
   popDivSelect();
   popReasCode();
   popFromDate();
}
//==============================================================================
// Load Stores
//==============================================================================
function popStrSelect()
{
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];
    for (idx = 0; idx < stores.length; idx++)
    {
      document.all.Store.options[idx] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
}
//==============================================================================
// Load Stores
//==============================================================================
function popReasCode()
{
    document.all.Reason.options[0] = new Option("Any Reasons", "ALL");
    for (i = 0; i < Reason.length; i++)
    {
      document.all.Reason.options[i+1] = new Option(ReasonDesc[i], Reason[i]);
    }
}
//==============================================================================
// Load Division
//==============================================================================
function popDivSelect() {
    var div = [<%=sDiv%>];
    var divnm = [<%=sDivName%>];

    for (i = 0; i < div.length; i++)
    {
      document.all.Division.options[i] = new Option(divnm[i],div[i]);
    }
}
//==============================================================================
// populate from date
//==============================================================================
function popFromDate()
{
   var time=new Date(new Date().getTime() - 86400000); // get prior date
   var year = time.getFullYear() - 1;
   var month = time.getMonth() + 1;
   var day = time.getDate();
   document.all.FrDate.value = month + "/" + day + "/" + year;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";
  var stridx = document.all.Store.selectedIndex;
  var str = document.all.Store.options[stridx].value;
  var strnm = document.all.Store.options[stridx].text;
  var dividx = document.all.Division.selectedIndex;
  var div = document.all.Division.options[dividx].value;
  var divnm = document.all.Division.options[dividx].text;
  var ven = document.all.Vendor.value;
  var rcidx = document.all.Reason.selectedIndex;
  var reason = (document.all.Reason.options[rcidx].value).trim();
  var from = new Date(document.all.FrDate.value)
  var maxDate= new Date();
  var frdate = document.all.FrDate.value;
  var action = null;
  for(var i=0; i < document.all.Action.length; i++)
  {
     if(document.all.Action[i].checked) action = document.all.Action[i].value;
  }

  // validate from date
  if (document.all.FrDate.value == null || (new Date(from)) == "NaN")
  {
    msg = " Please, enter report from date\n"
    error = true;
  }
  else {document.all.FrDate.value = (from.getMonth()+1) + "/" + from.getDate() + "/" + from.getFullYear()}

  if (from > maxDate)
  {
    msg = from.getFullYear() + " is greater than today date.\n"
    error = true;
  }

  if (ven.trim() == "") ven = "ALL";
  var excel = false
  if (document.all.Excel.checked) { excel = true; }

  // validate from date
  if (ven != "ALL" && isNaN(ven))
  {
    msg = " Vendor number must be numeric. Please, leave Vendor empty for all.\n"
    error = true;
  }

  if(error) alert(msg);
  else sbmRtvList(str, strnm, div, divnm, ven, reason, frdate, excel, action);
}
//-------------------------------------------------------------
// Prompt for Media populate media list
//-------------------------------------------------------------
function sbmRtvList(str, strnm, div, divnm, ven, reason, frdate, excel, action)
{
   var url = "RtvRegList.jsp?"
   if(excel) url = 'RtvRegListExcel.jsp?'

   url += "Store=" + str
    + "&StrName=" + strnm
    + "&Division=" + div
    + "&DivName=" + divnm
    + "&Vendor=" + ven
    + "&Reason=" + reason
    + "&FrDate=" + frdate
    + "&Action=" + action
    + "&User=" + User

   //alert(url);
   window.location.href = url;
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>RTV Review - Selection</B>

      <TABLE>
        <TBODY>

        <!-- =============================================================== -->
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left colspan="3">
             <SELECT name="Store"></SELECT>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
          <TD align=right >Division:</TD>
          <TD align=left colspan="3">
             <SELECT name="Division"></SELECT>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
          <TD align=right >Vendor:</TD>
          <TD align=left colspan="3">
             <input name="Vendor" maxlength=5; size=5>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
          <TD align=right >Reason:</TD>
          <TD align=left colspan="3">
             <SELECT name="Reason"></SELECT>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
          <TD align=right>From Date:</TD>
          <TD align=left colspan="3">
             <input name="FrDate" maxlength=12; size=12>&nbsp;
             <a href="javascript:showCalendar(1, null, null, 300, 250, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD colspan=4 >&nbsp;</TD></TR>
        <TR style="background: darkred;"><TD colspan=4 ></TD></TR>

        <TR>
          <TD align=right >Action Code:</TD>
          <TD align=left colspan="3">
             <input name="Action" type="radio" value="ALL">All &nbsp;&nbsp;&nbsp;
             <input name="Action" type="radio" value="RA">RA# &nbsp;&nbsp;&nbsp;
             <input name="Action" type="radio" value="MOS">MOS &nbsp;&nbsp;&nbsp;
             <input name="Action" type="radio" value="RECALL">Recall &nbsp;&nbsp;&nbsp;
             <input name="Action" type="radio" value="NOCODE" checked>No Action Codes
          </TD>
        </TR>
        <TR style="background: darkred;"><TD colspan=4 ></TD></TR>
        <TR><TD colspan=4 >&nbsp;</TD></TR>
        <!-- =============================================================== -->
        <TR>
          <TD align=center colspan="4">
             <input name=SUBMIT type="Submit" onClick="Validate()" value="Submit"> &nbsp;&nbsp
             <input class="Small" name="Excel" type="checkbox" value="Y">as Excel
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <!-- =============================================================== -->
        </TBODY>
       </TABLE>
       <p>
       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page.</font>
       &nbsp;&nbsp;&nbsp;
       <a href="OnHands03.jsp" class="blue" target="_blank">Item Lookup</a>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>