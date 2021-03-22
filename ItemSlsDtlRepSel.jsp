<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.*, java.util.* "%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemSlsDtlRepSel.jsp&APPL=ALL");
   }
   else
   {
      StoreSelect strsel = new StoreSelect(4);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();

      String sYesterday = null;
      String sWeekBeg = null;

      String query = "select char(pida, usa) as pida, char(piwb, usa) as piwb from rci.fsyper where pida= current date - 1 days";
      RunSQLStmt rsql = new RunSQLStmt();
      rsql.setPrepStmt(query);
      rsql.runQuery();

      if(rsql.readNextRecord())
      {
         sYesterday = rsql.getData("pida");
         sWeekBeg = rsql.getData("piwb");
      }
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

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Yesterday = "<%=sYesterday%>"
var WeekBeg = "<%=sWeekBeg%>"
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  document.all.tdDate1.style.display="block"
  document.all.tdDate2.style.display="none"
  document.all.tdDate3.style.display="none"

  showAllDates()

  chgStrSel("ALL");
}

//==============================================================================
// change Store selection
//==============================================================================
function chgStrSel(str)
{
  if (str == "ALL")
  {
    var stores = document.all.Store;
    var strchk = document.all.StrAll.checked;

    for(var i=0; i < stores.length; i++ )
    {
       stores[i].checked=strchk;
    }
  }
  else
  {
      document.all.StrAll.checked = false;
  }
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
     document.all.tdDate3.style.display="block"
   }
   else
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
     document.all.tdDate3.style.display="block"
   }
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
      // to sales date
      document.all.SlsFrDate.value = WeekBeg;
      document.all.SlsToDate.value = Yesterday;
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

//==============================================================================
// change Summary option depend on selection
//==============================================================================
function chgSumOpt(clear)
{
  var sumopt = document.all.SumOpt;
  var max = sumopt.length;

  // clear all option when NONE selected
  if(clear)
  {
     for(var i=0; i < max; i++ )
     {
        if(i < max-1) { sumopt[i].checked = false; }
     }
  }
  else
  {
     sumopt[sumopt.length - 1].checked = false;
  }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  var sku = document.all.Sku.value.trim();
  if(sku.trim()== "" || isNaN(sku)){ msg += "\n Sku is not correct."; error = true; }

  var stores = document.all.Store;
  var str = new Array();
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

  if(!strsel) { msg += "\n Please, check at least 1 store"; error = true; }


  // sales date
  var slsfrdate = document.all.SlsFrDate.value;
  var slstodate = document.all.SlsToDate.value;

  if (error) alert(msg);
  else{ sbmSlsRep(sku, str, slsfrdate, slstodate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(sku, str, slsfrdate, slstodate)
{
  var url = null;
  url = "ItemSlsDtlRep.jsp?"

  url += "Sku=" + sku

  // selected store
  for(var i=0; i < str.length; i++)
  {
     url += "&Str=" + str[i]
  }

  url += "&From=" + slsfrdate
       + "&To=" + slstodate

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// disable enter key
//==============================================================================
function disableEnterKey(e)
{
     var key;
     if(window.event)
     {
          key = window.event.keyCode; //IE
     }
     return (key != 13);
}
document.onkeypress = disableEnterKey;
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--TR><TD height="20%"><IMG src="Sun_ski_logo4.png"></TD></TR -->

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item Sales Details - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>&nbsp; &nbsp; &nbsp; &nbsp;
      <TABLE>
        <TBODY>
       <!-- =============================================================== -->
        <TR>
          <TD class="Cell2" colspan=4>Sku:
             <input name="Sku" maxlength=7 size=7>

        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell">Store:</TD>
          <TD class="Cell1" colspan=3>
             <input name="StrAll" type="checkbox" value="ALL" onclick="chgStrSel(this.value)" checked>Total Stores&nbsp;&nbsp;
             <br>


             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="Store" type="checkbox" onclick="chgStrSel(this.value)" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i == 15 || i == 30) {%><br><%}%>
             <%}%>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <!-- ============== select Shipping changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Select Sales Dates</b></u> <br>If no date selected, defaulted dates are week-to-date</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'DAY')">d-</button>
              <input class="Small" name="SlsFrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.SlsFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date: </b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'DAY')">d-</button>
              <input class="Small" name="SlsToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.SlsToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
        <TR><TD class="Cell2" id="tdDate3" colspan=4>
              <p><button id="btnSelDates" onclick="showAllDates()">Week-To-Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=4>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
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