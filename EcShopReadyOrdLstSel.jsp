<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComOrdLstSel.jsp&APPL=ALL");
   }
   else
   {
%>

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

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
     doSelDate(type)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
    document.all.tdDate1.style.display="block"
    document.all.tdDate2.style.display="none"
    document.all.OrdFrDate.value = "MONTH"
    document.all.OrdToDate.value = "MONTH"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  if(type==1)
  {
    df.OrdFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    df.OrdToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
  else
  {
    df.ShpFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    df.ShpToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
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
  for (var i=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked) sts[i] = document.all.Sts[i].value;
     sel = true;
  }
  if(!sel) {error = false; msg += "Select at least 1 status"}

  // order date
  var ordfrdate = document.all.OrdFrDate.value;
  var ordtodate = document.all.OrdToDate.value;

  if (error) alert(msg);
  else{ sbmOrdList(sts, ordfrdate, ordtodate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(sts, ordfrdate, ordtodate)
{
  var url = null;
  url = "EcShopReadyOrdLst.jsp?"
      + "FrDate=" + ordfrdate
      + "&ToDate=" + ordtodate

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko)
{
   var sts = document.all.Sts;
   var mark = false;
   if (chko.checked) mark = true;
   for(var i=0; i < sts.length; i++) { sts[i].checked = mark }
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
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Order List - Selection</B>
        <br><a href="../" class="small"><font color="red">Home</font></a>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Order Statuses</TD>
        </tr>
        <tr>
            <TD class="Cell2" colspan=5>
              <input class="Small" onclick="chkStsAll(this)" name="StsAll" type="checkbox" value="All" checked>All
        <tr>
            <TD class="Cell1" nowrap><input class="Small" name="Sts" type="checkbox" value="NEW" checked>New
            <TD class="Cell1" nowrap><input class="Small" name="Sts" type="checkbox" value="PROCESSING" checked>Processing
            <TD class="Cell1" nowrap><input class="Small" name="Sts" type="checkbox" value="SUBMIT" checked>Submited
            <TD class="Cell1" nowrap><input class="Small" name="Sts" type="checkbox" value="IGNORE" checked>Ignore
        </TR>

        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select order dates when item was uploaded</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(1)">Optional Order Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdFrDate')">&#60;</button>
              <input class="Small" name="OrdFrDate" type="text" value="MONTH" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.OrdFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdToDate')">&#60;</button>
              <input class="Small" name="OrdToDate" type="text" value="MONTH" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.OrdToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(1)">Month</button>
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