<%@ page import=" salesvelocity.SlsVelocitySel, rciutility.StoreSelect"%>
<%
    SlsVelocitySel slsVel = new SlsVelocitySel();
    int iNumOfDiv = slsVel.getNumOfDiv();
    int iNumOfDate = slsVel.getNumOfDate();

    String [] sDiv = slsVel.getDiv();
    String [] sDivName = slsVel.getDivName();
    String sDateJSA = slsVel.getDateJSA();

    slsVel.disconnect();

    StoreSelect strlst = new StoreSelect(12);
    int iNumOfStr = strlst.getNumOfStr();
    String [] sStr = strlst.getStrLst();
    strlst = null;
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var DateRange = true;
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
  doSelDate();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate(){
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * dofw);

  document.all.FrWeek.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  document.all.ToWeek.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// switch frome date range to 1 date (WTD/MTD/YTD)
//==============================================================================
function switchDates()
{
  if(DateRange)
  {
    document.all.spnFrom.style.display = "none";
    document.all.btnDate.innerHTML = "Week Range";
  }
  else
  {
     document.all.spnFrom.style.display = "inline";
     document.all.btnDate.innerHTML = "Single Week";
  }
  DateRange = !DateRange;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - (-86400000 * 7));
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//==============================================================================
// validate entries
//==============================================================================
function Validate()
{
   var error = false;
   var msg ="";

   div = new Array();
   divsel = false;
   for(var i=0, j=0; i < document.all.Div.length; i++)
   {
      if(document.all.Div[i].checked){ div[j++]=document.all.Div[i].value; divsel = true; }
   }

   if(!divsel){ error=true; msg += "\nSelect at least 1 division"; }

   // check stores
   str = new Array();
   strsel = false;
   for(var i=0, j=0; i < document.all.Str.length; i++)
   {
      if(document.all.Str[i].checked){ str[j++]=document.all.Str[i].value; strsel = true; }
   }

   if(!strsel){ error=true; msg += "\nSelect at least 1 store"; }


   if (DateRange)
   {
      from = document.all.FrWeek.value;
      to = document.all.ToWeek.value;
   }
   else
   {
      from = document.all.ToWeek.value;
      to = from;
   }

   var sort = null;
   for(var i=0; i < document.all.Sort.length; i++)
   {
      if(document.all.Sort[i].checked){ sort = document.all.Sort[i].value; break; }
   }

   var onpage = document.all.OnPage.options[document.all.OnPage.selectedIndex].text

   if(error){ alert(msg); }
   else { submit(div, str, from, to, sort, onpage); }
}
//==============================================================================
//submit report
//==============================================================================
function submit(div, str, from, to, sort, onpage)
{
   var url = "SlsVelocity.jsp?"
       + "FrWeek=" + from
       + "&ToWeek=" + to
       + "&OnPage=" + onpage
       + "&Sort=" + sort;

   for(var i=0; i < div.length; i++)
   {
      url += "&Div=" + div[i]
   }

   for(var i=0; i < str.length; i++)
   {
      url += "&Str=" + str[i]
   }

   //alert(url);
   window.location.href = url;
}
//==============================================================================
// set Group of divisions
//==============================================================================
function setGrpDiv(action)
{
   for(var i=0; i < document.all.Div.length; i++)
   {
      if(action=="RESET"){document.all.Div[i].checked = false; }
      if(action=="ALL"){document.all.Div[i].checked = true; }
   }
}
//==============================================================================
// set Group of stores
//==============================================================================
function setGrpStr(action)
{
   for(var i=0; i < document.all.Str.length; i++)
   {
      if(action=="RESET"){document.all.Str[i].checked = false; }
      if(action=="ALL"){document.all.Str[i].checked = true; }
   }
}
</script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

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
        <BR>Top Style Sellers Report - Selection</B>

      <TABLE border=0>
        <TBODY>
        <!-- -------------- Select division ---------------------------- -->
        <TR>
          <TD align=right>Division:</TD>
          <TD align=left>
             <table>
                <tr style="font-size:10px">
                <%for(int i=1; i < iNumOfDiv; i++){%>
                   <%if(i==0 || i%15==0){%><tr style="font-size:10px;"><%}%>
                      <td style="text-align:right">
                         <%=sDiv[i]%><input style="font-size:10px" name="Div" type="checkbox" value="<%=sDiv[i]%>" checked> &nbsp;  &nbsp;
                      </td>
                <%}%>
             </table>
          </TD>
        </tr>
        <TR>
          <TD align=center colspan=2>
             <button style="font-size:10px" onClick="setGrpDiv('ALL')">All Divisions</button> &nbsp;
             <button style="font-size:10px" onClick="setGrpDiv('RESET')">Reset</button>
          </TD>

        <!-- -------------- Select Store ---------------------------- -->
        <tr style="background:darkred; font-size:1px"><td colspan=4>&nbsp;</td></tr>
        <TR>
          <TD align=right>Store:</TD>
          <TD align=left>
             <table>
                <tr style="font-size:10px">
                <%for(int i=0; i < iNumOfStr; i++){%>
                   <%if(i==0 || i%15==0){%><tr style="font-size:10px;"><%}%>
                      <td style="text-align:right">
                         <%=sStr[i]%><input style="font-size:10px" name="Str" type="checkbox" value="<%=sStr[i]%>" checked> &nbsp;  &nbsp;
                      </td>
                <%}%>
             </table>
          </TD>
        </tr>
        <TR>
          <TD align=center colspan=2>
             <button style="font-size:10px" onClick="setGrpStr('ALL')">All Stores</button> &nbsp;
             <button style="font-size:10px" onClick="setGrpStr('RESET')">Reset</button>
          </TD>

        <!-- =============================================================== -->
        <tr style="background:darkred; font-size:1px"><td colspan=4>&nbsp;</td></tr>
        <TR>
          <TD align=center colspan=4>
              <span id="spnFrom">From Weekending Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrWeek')">&#60;</button>
              <input name="FrWeek" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrWeek')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 500, 300, document.all.FrWeek)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a> &nbsp; &nbsp; &nbsp;
              </span>

           To Weekending Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToWeek')">&#60;</button>
              <input name="ToWeek" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToWeek')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.ToWeek)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            <br><button class="Small" id="btnDate" onClick="switchDates()">Single Week</button>
          </TD>
        </TR>
        <!-- =============================================================== -->


        <!-- -------------- Select Sorting by Units or Retail -------------- -->
        <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>

        <TR>
          <TD align=left>Sort By:</TD>
          <TD align=center>Number of Top Sellers:</TD>
        </tr>
        <tr>
          <TD align=left nowrap>
             &nbsp;&nbsp;&nbsp;Units<input name="Sort" type="radio" value="U" checked>
             &nbsp;&nbsp;&nbsp;Retail<input name="Sort" type="radio" value="R">
             &nbsp;&nbsp;&nbsp;Gross Margin<input name="Sort" type="radio" value="G">
          </TD>
          <TD align=center>
            <select name="OnPage"><option>30</option><option>50</option><option>100</option></select>
          </TD>
        </tr>
        <!-- -------------- Submit buttons --------------------------------- -->
        <tr>
            <TD align=center colSpan=2>
               <button onClick="Validate()" id="Submit">Submit</button>
           </TD>
          </TR>
          <!-- ------------------------------------------------------------- -->
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
