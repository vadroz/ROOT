<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   //if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   if (session.getAttribute("USER")==null)
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
   document.all.tdDate2.style.display="block"
   document.all.tdDate3.style.display="block"
   document.all.tdDate4.style.display="none"
   doSelDate(1)
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
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
   doSelDate(type)
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
      document.all.OrdFrDate.value = "MONTH"
      document.all.OrdToDate.value = "MONTH"
   }
   else
   {
      document.all.tdDate3.style.display="block"
      document.all.tdDate4.style.display="none"
      document.all.ShpFrDate.value = "ALL"
      document.all.ShpToDate.value = "ALL"
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;

  if(type==1)
  {
    var date = new Date(new Date() - 7 * 86400000);
    df.OrdFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    var date = new Date(new Date() - 86400000);
    df.OrdToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
  else
  {
    var date = new Date(new Date() - 86400000);
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
  // order date
  var shpfrdate = document.all.ShpFrDate.value;
  var shptodate = document.all.ShpToDate.value;

  if (error) alert(msg);
  else{ sbmOrdList(sts, ordfrdate, ordtodate, shpfrdate, shptodate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(sts, ordfrdate, ordtodate, shpfrdate, shptodate)
{
  var url = null;
  url = "EComOrdLst.jsp?"
      + "OrdFrDate=" + ordfrdate
      + "&OrdToDate=" + ordtodate
      + "&ShpFrDate=" + shpfrdate
      + "&ShpToDate=" + shptodate

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// Validate searched Order
//==============================================================================
function ValidateOrder()
{
  var error = false;
  var msg = "";

  var ord = document.all.Order.value;
  if (isNaN(ord)) { msg = "Order must be numeric."; error = true; }
  else if( ord <= 0) { msg = "Order number must be greater than 0."; error = true; }

  var site = document.all.Site;
  var sitenm = null;
  for(var i=0; i < site.length; i++)
  {
    if(site[i].checked){ sitenm = site[i].value}
  }

  if (error) alert(msg);
  else{ sbmOrder(sitenm, ord) }
  return error == false;
}
//==============================================================================
// submit searched Order
//==============================================================================
function sbmOrder(site, ord)
{
  var url = "EComOrdInfo.jsp?Site=" + site
   + "&Order=" + ord

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
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="New" checked>New <br>
              <input class="Small" name="Sts" type="checkbox" value="Processing" checked>Processing <br>
              <input class="Small" name="Sts" type="checkbox" value="Pending" checked>Pending<br>
              <input class="Small" name="Sts" type="checkbox" value="Returned" checked>Returned
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="Payment Declined" checked>Payment Declined <br>
              <input class="Small" name="Sts" type="checkbox" value="Awaiting Payment" checked>Awaiting Payment <br>
              <input class="Small" name="Sts" type="checkbox" value="Ready to Ship" checked>Ready to Ship<br>
              <input class="Small" name="Sts" type="checkbox" value="Partially Returned" checked>Partially Returned
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="Pending Shipment" checked>Pending Shipment <br>
              <input class="Small" name="Sts" type="checkbox" value="Partially Shipped" checked>Partially Shipped <br>
              <input class="Small" name="Sts" type="checkbox" value="Shipped" checked>Shipped <br>
              <input class="Small" name="Sts" type="checkbox" value="Partially Backordered" checked>Partially Backordered
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="See Line Items" checked>See Line Items <br>
              <input class="Small" name="Sts" type="checkbox" value="Backordered" checked>Backordered <br>
              <input class="Small" name="Sts" type="checkbox" value="Cancelled" checked>Cancelled
            </TD>
        </TR>

        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select order dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdFrDate')">&#60;</button>
              <input class="Small" name="OrdFrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.OrdFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdToDate')">&#60;</button>
              <input class="Small" name="OrdToDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.OrdToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
          </TD>
        </TR>
        <!-- ============== select Shipping changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select shipping dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate3" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Shipping Date Selection</button>
          </td>
          <TD id="tdDate4" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ShpFrDate')">&#60;</button>
              <input class="Small" name="ShpFrDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ShpFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ShpFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ShpToDate')">&#60;</button>
              <input class="Small" name="ShpToDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ShpToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ShpToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(2)">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>

        <TR>
            <TD align=center valign=top colSpan=5>
               <INPUT class=Small type=radio name="Site" value="SASS" checked> Sun and Ski &nbsp; &nbsp; &nbsp;
               <INPUT class=Small type=radio name="Site" value="SKCH" > Ski Chalet  &nbsp; &nbsp; &nbsp;
               <INPUT class=Small type=radio name="Site" value="SSTP" > Ski Stop  &nbsp; &nbsp; &nbsp;
               <INPUT class=Small type=radio name="Site" value="RLHD" > Rail Head  &nbsp; &nbsp; &nbsp;
               <INPUT class=Small type=radio name="Site" value="RACK" > Car Rack
               <INPUT class=Small type=radio name="Site" value="JOJO" > Joe Johnes
           </TD>
        </TR>
        <TR>
            <TD align=center valign=top colSpan=5>
               <INPUT class=Small type=text name="Order" size=10 maxlength=10>&nbsp;
               <button onClick="ValidateOrder()">Get Order</button>
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