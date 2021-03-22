<%@ page import=" salesvelocity.SlsVelocitySel, rciutility.StoreSelect"%>
<%
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
  setItemGroup();
}
//==============================================================================
// populate item group dropdown menu
//==============================================================================
function setItemGroup()
{
   document.all.Group.options[0] = new Option("KEYITEMS", "KEYITEMS");
   document.all.Group.options[1] = new Option("NEVEROUT", "NEVEROUT");
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

   var group = document.all.Group.options[document.all.Group.selectedIndex].value;

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

   /*var sort = null;
   for(var i=0; i < document.all.Sort.length; i++)
   {
      if(document.all.Sort[i].checked){ sort = document.all.Sort[i].value; break; }
   }
   */

   var lvlobj = document.all.Level;
   var level = null;
   for(var i=0; i < lvlobj.length; i++)
   {
       if(lvlobj[i].checked){ level = lvlobj[i].value; break; }
   }

   if(error){ alert(msg); }
   else { submit(group, str, from, to, "U", level); }
}
//==============================================================================
//submit report
//==============================================================================
function submit(group, str, from, to, sort, level)
{
   var url = "SlsVelocityGrp.jsp?"
       + "Group=" + group
       + "&FrWeek=" + from
       + "&ToWeek=" + to
       + "&Sort=" + sort
       + "&Level=" + level
       ;

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

<TABLE height="100%" width="100%" border=0 bgcolor=moccasin>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item Group Sellers Report - Selection</B>

      <TABLE border=0>
        <TBODY>
        <!-- -------------- Select division ---------------------------- -->
        <TR>
          <TD align=right>Item Groups:</TD>
          <TD align=left><select name="Group"></select></TD>
        </tr>
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
        <tr style="background:darkred; font-size:1px"><td colspan=4>&nbsp;</td></tr>
        <TR>
          <TD align=center colspan=4>
            Level:
              <input name="Level" type="radio" value="S" checked>Style
                 &nbsp; &nbsp; &nbsp;
              <input name="Level" type="radio" value="I">Item
          </td>
        </tr>
        <!-- =============================================================== -->
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
