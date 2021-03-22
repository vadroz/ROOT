<%@ page import="java.sql.*, java.util.*"%>
<%
   String sStrAllowed = null;
   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuSrlAsgCtlSel.jsp&APPL=ALL");
   }
   else
   {
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();
%>
<title>Mozu Str Ffl: HO Ctl</title>
<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   doSelDate(1);
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type, optdt)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate3.style.display="none"
     document.all.tdDate4.style.display="block"
   }
   doSelDate(optdt)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   if(type==1)
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      doSelDate(1);
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date();

  df.StsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  date = new Date(new Date() - 31 * 86400000);
  if (type==2){ date = new Date(); }
  else if (type==3){ date = new Date(new Date() - 3 * 86400000); }

  var year =  date.getFullYear();
  if(isSafari){ year = date.getYear(); }
  df.StsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + year

}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  // selected status
  var sts = new Array();
  var sel = false
  for (var i=0, j=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked) { sts[j++] = document.all.Sts[i].value; }
     sel = true;
  }
  if(!sel) {error = false; msg += "Select at least 1 status"}

  var ordsts = new Array();
  var sel = false
  for (var i=0, j=0; i < document.all.OrdSts.length; i++)
  {
     if(document.all.OrdSts[i].checked) { ordsts[j++] = document.all.OrdSts[i].value; }
     sel = true;
  }

  // order date
  var stsfrdate = document.all.StsFrDate.value;
  var ststodate = document.all.StsToDate.value;

  var sku = document.all.Sku.value.trim();
  var ord = document.all.Order.value.trim();

  if (error) alert(msg);
  else{ sbmPlan(sts, stsfrdate, ststodate, sku, ord, ordsts) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(sts, stsfrdate, ststodate, sku, ord, ordsts)
{
  var url = null;
  url = "MozuSrlAsgCtl.jsp?"
      + "StsFrDate=" + stsfrdate
      + "&StsToDate=" + ststodate
      + "&Sku=" + sku
      + "&Ord=" + ord
      + "&OrdSts=" + ordsts

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(sel)
{
   var sts = document.all.Sts;
   for(var i=0; i < sts.length; i++) { sts[i].checked = sel; }
}
//==============================================================================
//set all statuses for selected order
//==============================================================================
function setSts(ord)
{
	if(ord.trim() != "")
	{
		chkStsAll(true)
	}
	else
	{
		var sts = document.all.Sts;
		for(var i=0; i < sts.length ;i++)
		{
			if(i==0 || i == 7){ sts[i].checked = true; }
			else{ sts[i].checked = false; }
		}
	}
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Store Fulfillments - HO Control - Selection</B>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Order Store Assigning Statuses</TD>
        </tr>
        <tr>
            <TD class="Cell1" colspan=5>
              <a class="Small" href="javascript: chkStsAll(true)">All</a> &nbsp; &nbsp;
              <a class="Small" href="javascript: chkStsAll(false)">Reset</a>
        <tr>
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="Open" checked>Open &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Assigned">Assigned &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Printed">Printed &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Picked">Picked &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Problem">Problem &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Resolve">Resolve &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Shipped">Shipped &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Cannot Fill" checked>Cannot Fill &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Sold Out">Sold Out &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Error">Error
              <input class="Small" name="Sts" type="checkbox" value="Cancelled">Calcelled
            </td>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Order Statuses</TD>
        </tr>
            <TD class="Cell1" nowrap>
              <input class="Small" name="OrdSts" type="radio" value="1" checked>Exclude Canceled Orders &nbsp;
              <input class="Small" name="OrdSts" type="radio" value="2">Include Canceled Orders &nbsp;
            </td>
        </TR>
        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select status changed dates</TD></tr>

        <TR>
          <td id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(1,1)">Optional Order Date Selection</button>&nbsp;
             <button id="btnSelDates" onclick="showDates(1,2)">Today</button>&nbsp;
             <button id="btnSelDates" onclick="showDates(1,3)">Last 3 Days</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsFrDate')">&#60;</button>
              <input class="Small" name="StsFrDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'StsFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.StsFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsToDate')">&#60;</button>
              <input class="Small" name="StsToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'StsToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.StsToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(1)">Prior Month</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
          <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
          <TR>
              <TD class="Cell2" align=center colSpan=5>Optional Selection</TD>
          </TR>
           <TR>
              <TD align=center colSpan=5>
                Select SKU: <INPUT name=Sku maxlength=10 size=10>
                 &nbsp; - or -  &nbsp;
                Select Order: <INPUT name=Order onkeyup="setSts(this.value)" maxlength=10 size=10>
              </TD>
          </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>