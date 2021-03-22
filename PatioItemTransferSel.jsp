<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PATIO";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PatioItemTransferSel.jsp&APPL=ALL");
   }
   else
   {
   int iSpace = 6;
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:bottom}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:middle}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:middle;}

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
  document.all.tdDate3.style.display="block"
  document.all.tdDate4.style.display="none"
}
//==============================================================================
// change Store selection
//==============================================================================
function chgStrSel(selstr, type)
{
  var fld = "Store";
  if(type=="TRF"){fld = "TrfStr";}

  var strchk = document.all[fld];

  for(var i=0; i < strchk.length; i++)
  {
      strchk[i].checked = false;
      var numstr = strchk[i].value;
      if(selstr=="ALL") { strchk[i].checked = true}
  }
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(datety)
{
  var df = document.all;
  var date = new Date(new Date() - 7 * 86400000);

  if(datety == "ORD") { df.FrOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
  else{ df.FrDelDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }

  date = new Date(new Date());
  if(datety == "ORD") { df.ToOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
  else { df.ToDelDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP") { date = new Date(new Date(date) - -86400000); }
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(excel)
{
  var error = false;
  var msg = "";

  var stores = document.all.Store;
  var str = new Array();
  var action;

  // at least 1 store must be selected
  var strsel = false;
  for(var i=0, j=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        str[j] = stores[i].value;
        j++;
     }
  }

  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }

  // at least 1 transfer store must be selected
  var trfstr = document.all.TrfStr;
  var trf = new Array();
  var trfsel = false;
  for(var i=0, j=0; i < trfstr.length; i++ )
  {
     if(trfstr[i].checked)
     {
        trfsel=true;
        trf[j] = trfstr[i].value;
        j++;
     }
  }

  if(!trfsel)
  {
    msg += "\n Please, check at least 1 transfer store";
    error = true;
  }

  // status options
  var stsopt = document.all.Status;
  var sts = new Array();
  var stssel = false;
  for(var i=0, j=0; i < stsopt.length; i++ )
  {
     if(stsopt[i].checked)
     {
        stssel=true;
        sts[j] = stsopt[i].value;
        j++;
     }
  }
  if(!stssel) { msg += "\n Please, check at least 1 order status"; error = true; }

  var frorddt = document.all.FrOrdDate.value.trim();
  var toorddt = document.all.ToOrdDate.value.trim();
  var frdeldt = document.all.FrDelDate.value.trim();
  var todeldt = document.all.ToDelDate.value.trim();

  if (error) alert(msg);
  else{ sbmReport(frorddt, toorddt, frdeldt, todeldt, str, trf, sts) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmReport(frorddt, toorddt, frdeldt, todeldt, str, trf, sts)
{
  var url = "PatioItemTransfer.jsp?FrOrd=" + frorddt
    + "&ToOrd=" + toorddt
    + "&FrDel=" + frdeldt
    + "&ToDel=" + todeldt

  // selected store
  for(var i=0; i < str.length; i++) { url += "&Str=" + str[i]; }
  // selected transfer store
  for(var i=0; i < trf.length; i++) { url += "&Trf=" + trf[i]; }
  // selected transfer store
  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i]; }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(datety)
{
   if(datety == "ORD")
   {
      document.all.tdDate1.style.display="none"
      document.all.tdDate2.style.display="block"
   }
   else
   {
      document.all.tdDate3.style.display="none"
      document.all.tdDate4.style.display="block"
   }

   doSelDate(datety)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(datety)
{
   if(datety == 'ORD')
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.FrOrdDate.value = "01/01/0001"
      document.all.ToOrdDate.value = "12/31/2999"
      document.all.tdStsOpt.style.display="none"
   }
   else
   {
      document.all.tdDate3.style.display="block"
      document.all.tdDate4.style.display="none"
      document.all.FrDelDate.value = "01/01/0001"
      document.all.ToDelDate.value = "12/31/2999"
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
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture Item Transfer - Selection</B>

        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

      <TABLE border=0>
        <TBODY>

        <!-- ================== Store selections =========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2"><b>Inventory From Stores:</b>
             <input name="TrfStr" type="checkbox" value="35" >35 &nbsp;&nbsp;
             <input name="TrfStr" type="checkbox" value="46" >46 &nbsp;&nbsp;
             <input name="TrfStr" type="checkbox" value="50" >50 &nbsp;&nbsp;
             <input name="TrfStr" type="checkbox" value="86" >86 &nbsp;&nbsp;
             <input name="TrfStr" type="checkbox" value="63" >63 &nbsp;&nbsp;
             <input name="TrfStr" type="checkbox" value="64" >64 &nbsp;&nbsp;
             <input name="TrfStr" type="checkbox" value="68" >68 &nbsp;&nbsp;
             <input name="TrfStr" type="checkbox" value="55" >55 &nbsp;&nbsp;
             <br>
             <button id="StrGrp" class="Small" onclick="chgStrSel('ALL', 'TRF')">All Stores</button> &nbsp; &nbsp;
             <button id="StrGrp" class="Small" onclick="chgStrSel('Clear', 'TRF')" >Clear</button>
             <br>&nbsp;
          </TD>
        </TR>


        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2"><b>Select Selling Stores:</b>
             <input name="Store" type="checkbox" value="35" checked>35 &nbsp;&nbsp;
             <input name="Store" type="checkbox" value="46" checked>46 &nbsp;&nbsp;
             <input name="Store" type="checkbox" value="50" checked>50 &nbsp;&nbsp;
             <input name="Store" type="checkbox" value="86" checked>86 &nbsp;&nbsp;
             <input name="Store" type="checkbox" value="63" checked>63 &nbsp;&nbsp;
             <input name="Store" type="checkbox" value="64" checked>64 &nbsp;&nbsp;
             <input name="Store" type="checkbox" value="68" checked>68 &nbsp;&nbsp;
             <br>
             <button id="StrGrp" class="Small" onclick="chgStrSel('ALL', 'SHIP')">All Stores</button> &nbsp; &nbsp;
             <button id="StrGrp" class="Small" onclick="chgStrSel('Clear', 'SHIP')" >Clear</button>
          </TD>
        </TR>

        <!-- ======================== Status selection ============================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2"><b><u>Select Order Status</u></b><br><br></TD>
        </tr>
        <TR>
          <td align=center>
             <INPUT type="checkbox" name="Status" value="W" checked>Waiting for Xfer
             <%for(int i=0; i < iSpace; i++){%>&nbsp;<%}%>
             <INPUT type="checkbox" name="Status" value="U" >Transferred<br><%for(int i=0; i < iSpace; i++){%>&nbsp;<%}%>

        <!-- ======================== From Date ======================================= -->
        <TR>
          <TD class=DTb1 id="tdDate1" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <button id="btnSelOrdDates" onclick="showDates('ORD')">Optional Order Date Selection</button>
          </td>
          <TD class=DTb1 id="tdDate2" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>Order Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrOrdDate')">&#60;</button>
              <input class="Small" name="FrOrdDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 250, 200, document.all.FrOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Order Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOrdDate')">&#60;</button>
              <input class="Small" name="ToOrdDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 900, 200, document.all.ToOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelOrdDates" onclick="showAllDates('ORD')">All Date</button>
          </TD>
        </TR>

          <!-- ===================== Delivery dates ===========================-->
        <TR>
          <TD class=DTb1 id="tdDate3" colspan=6 align=center style="padding-top: 10px;" >
             <button id="btnSelDelDates" onclick="showDates('DEL')">Optional Delivery Date Selection</button>
          </td>
          <TD class=DTb1 id="tdDate4" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>Delivery Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDelDate')">&#60;</button>
              <input class="Small" name="FrDelDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDelDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 250, 300, document.all.FrDelDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Delivery Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDelDate')">&#60;</button>
              <input class="Small" name="ToDelDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDelDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 900, 300, document.all.ToDelDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDelDates" onclick="showAllDates('DEL')">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate(false)">
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