<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComRmaLstSel.jsp&APPL=ALL");
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
function showDates()
{
   document.all.tdDate1.style.display="none"
   document.all.tdDate2.style.display="block"
   doSelDate();
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   document.all.CrtFrDate.value = "ALL"
   document.all.CrtToDate.value = "ALL"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
   var df = document.all;
   var date = new Date(new Date() - 86400000);
   df.CrtFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   df.CrtToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
   var sts = document.all.Sts;
   var stsval = new Array();
   var stschk = false;
   for(var i=0, j=0; i < Sts.length; i++)
   {
      if(sts[i].checked) { stsval[j] = document.all.Sts[i].value; j++; stschk = true;}
   }
   if(!stschk){ error = true; msg += "\nCheck at least one status."; }

   // order date
   var crtfrdate = document.all.CrtFrDate.value;
   var crttodate = document.all.CrtToDate.value;

   if (error) alert(msg);
   else{ sbmOrdList(stsval, crtfrdate, crttodate ) }
   return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(sts, CrtFrDate, CrtToDate)
{
   var url = null;
   url = "EComRmaLst.jsp?"
       + "From=" + CrtFrDate
       + "&To=" + CrtToDate
       + "&Action=LIST"

   for(var i=0; i < sts.length; i++)
   {
      url += "&Sts=" + sts[i];
   }

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

   if (error) alert(msg);
   else{ sbmOrder(ord) }
   return error == false;
}
//==============================================================================
// submit searched Order
//==============================================================================
function sbmOrder(ord)
{
  var url = "EComRmaLst.jsp?Sts=N&Sts=M&Sts=S&Sts=P"
       + "&Order=" + ord
       + "&From=ALL"
       + "&To=ALL"
       + "&Action=ORDER"

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko)
{
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce - Returned Item List - Selection</B>
        <br><a href="../" class="small"><font color="red">Home</font></a>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Returned Item Statuses</TD>
        </tr>
            <TD class="Cell1" nowrap colspan=5>
              <input class="Small" name="Sts" type="checkbox" value="N" checked>New &nbsp; &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="M" checked>Marked &nbsp; &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="S">Skiped &nbsp; &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="P">Processed &nbsp; &nbsp;
        </TR>

        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select dates when item was added RCI</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates()">Optional Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'CrtFrDate')">&#60;</button>
              <input class="Small" name="CrtFrDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'CrtFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.CrtFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'CrtToDate')">&#60;</button>
              <input class="Small" name="CrtToDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'CrtToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.CrtToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates()">All Dates</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD align=center valign=top colSpan=5>- or - &nbsp;&nbsp;&nbsp;
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