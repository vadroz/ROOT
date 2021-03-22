<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ItemTrfDiffSel.jsp&APPL=ALL");
}
else
{
    StoreSelect StrSelect = null;
    String sStr = null;
    String sStrName = null;
    String sStrCtn = null;

    String sStrAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      StrSelect = new StoreSelect(5);
    }
    else
    {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     int iStrAlwLst = 0;
     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
     else StrSelect = new StoreSelect(new String[]{sStrAllowed});
    }

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();
    sStrCtn = StrSelect.getStrCtn();
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<script name="javascript">
var Stores = [<%=sStr%>]
var StoreNames = [<%=sStrName%>]
var StrCtn = [<%=sStrCtn%>]
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doIstStrSelect();
  doSelDate();
}
//==============================================================================
// Load Issuing Stores
//==============================================================================
function doIstStrSelect()
{
   var str = document.all.IssStr;

   for (i = 1; i < Stores.length; i++)
   {
     str.options[i-1] = new Option(Stores[i] + " - " + StoreNames[i],Stores[i]);
   }
   str.selectedIndex=0;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";
  var iss = document.all.IssStr.options[document.all.IssStr.selectedIndex].value
  var frdate = document.all.FrDate.value;
  var todate = document.all.ToDate.value;

  if (error) alert(msg);
  else{ sbmItmScan(iss, frdate, todate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmItmScan(iss, frdate, todate)
{
  var url = null;
  url = "ItemTrfDiff.jsp?IssStr=" + iss
      + "&From=" + frdate
      + "&To=" + todate

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// close Submitting frame
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   alert("Report has been submitted")
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  var date = new Date(new Date() - 86400000 * 30);
  df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
  else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

  if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
  else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();" style="text-align:center">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Select Stores For Item Transfer Discrepancy Report</b><br>

      <table border=0>
      <!-- ==================== select issuing Store ========================== -->
      <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
      <tr>
         <td ALIGN="right" width="50%">Issuing Store:</td><td ALIGN="left"><SELECT name="IssStr" class="Small"></SELECT></td>
      <tr>

      <!-- ==================== select Date Range ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=2><b><u>Select Sales Dates</u></b></TD></tr>

        <TR>
          <TD id="tdDate2" colspan=2 align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate', 'DAY')">d-</button>
              <input class="Small" name="FrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date: </b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate', 'DAY')">d-</button>
              <input class="Small" name="ToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 800, 400, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
        <!-- ===================== Submit Report =========================== -->
        <tr>
          <td colspan=2  ALIGN="center">
            <button name="submit" onClick="Validate()">Submit</button>
          </td>
        </tr>
        <!-- =============================================================== -->

      </table>
                </td>
            </tr>
       </table>

</BODY></HTML>
<%}%>







