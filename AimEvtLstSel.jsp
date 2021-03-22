<%@ page import="java.util.*, rciutility.StoreSelect"%>
<%
   String sStrAllowed = null;

   int iSpace = 6;

      StoreSelect strlst = new StoreSelect(5);
      int iNumOfStr = strlst.getNumOfStr();
      String [] sStr = strlst.getStrLst();
      String [] sStrName = strlst.getStrNameLst();

      String [] sStrLst = strlst.getStrLst();
      String sStrJsa = strlst.getStrNum();

      String [] sStrRegLst = strlst.getStrRegLst();
      String sStrRegJsa = strlst.getStrReg();

      String [] sStrDistLst = strlst.getStrDistLst();
      String sStrDistJsa = strlst.getStrDist();
      String [] sStrDistNmLst = strlst.getStrDistNmLst();
      String sStrDistNmJsa = strlst.getStrDistNm();

      String [] sStrMallLst = strlst.getStrMallLst();
      String sStrMallJsa = strlst.getStrMall();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .Small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];
//------------------------------------------------------------------------------
// populate fields on page load
//------------------------------------------------------------------------------
function bodyLoad()
{
  document.all.tdDate3.style.display="block"
  document.all.tdDate4.style.display="none"
  setAll(true);
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
      document.all.tdStsOpt.style.display="block"
   }
   else
   {
      document.all.tdDate3.style.display="none"
      document.all.tdDate4.style.display="block"
   }

   doSelDate()
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
      document.all.FrActDt.value = "01/01/0001"
      document.all.ToActDt.value = "12/31/2999"
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(){
  var df = document.all;
  var date = new Date(new Date() - 7 * 86400000);

  df.FrActDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  date = new Date(new Date());
  df.ToActDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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

//------------------------------------------------------------------------------
// Validate entry
//------------------------------------------------------------------------------
function Validate()
{
   var error = false;
   var msg = "";

   var selFrActDt = document.all.FrActDt.value.trim();
   var selToActDt = document.all.ToActDt.value.trim();

   // get Included employees
   var sts = document.all.Sts;
   var selsts = new Array();
   var bSts = false;
   for(var i=0, j=0; i < sts.length; i++)
   {
     if(sts[i].checked){ selsts[j] = sts[i].value; bSts = true; j++;}
   }
   if (!bSts){ error=true; msg+="\nAt least 1 Status must be selected."; }

   var strbox = document.all.Str
   var str = new Array();
   var chkstr = false;
   for(var i=0, j=0; i < strbox.length; i++)
   {
      if(strbox[i].checked){ str[j] = strbox[i].value; chkstr = true; j++}
   }
   if(!chkstr){ msg += br + "Check at least 1 store."; error = true;  br = "<br>";}

   if(error){alert(msg)}
   else{ submitForm(selFrActDt, selToActDt, selsts, str) }
}
//------------------------------------------------------------------------------
// change action on submit
//------------------------------------------------------------------------------
function submitForm(selFrActDt, selToActDt, selsts, str){
   var url;

   url = "AimEvtLst.jsp?From=" + selFrActDt + "&To=" + selToActDt;

   for(var i=0; i < selsts.length; i++) { url += "&Sts=" + selsts[i]; }
   for(var i=0; i < str.length; i++) { url += "&Str=" + str[i]; }

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// set all store or unmark
//==============================================================================
function setAll(on)
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++) { str[i].checked = on; }
}
//==============================================================================
// check by regions
//==============================================================================
function checkReg(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check by districts
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check mall
//==============================================================================
function checkMall(type)
{
  var str = document.all.Str
  var chk1 = true;
  var chk2 = false;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
        {
           str[i].checked = chk1;
        };
     }
  }
}
</SCRIPT>
</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

 <body  onload="bodyLoad();">

  <table border="0" align=center width="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Associates in Motion(AIM) Event List - Selection</b>
       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
       &nbsp; &nbsp; &nbsp; &nbsp;
       <a href="AimEvt.jsp?id=0" >Add Event</a>
       <br>

      <table border=0>
      <!-- =============================================================================== -->
      <!-- Status -->
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
         <td valign=middle>Event Statuses:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                 <td class="Small"><input type="checkbox" class="Small" name="Sts" value="Active" checked>Active</td>
                 <td class="Small"><input type="checkbox" class="Small" name="Sts" value="Completed" >Expired</td>
                 <td class="Small"><input type="checkbox" class="Small" name="Sts" value="Postponed" >Postponed</td>
              </tr>
            </table>
         </td>
      </tr>

      <!-- ======================= Date Selection ========================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <TR>
          <td class=DTb1 id="tdDate3" colspan=6 align=center style="padding-top: 10px;" >
             <button id="btnSelDelDates" onclick="showDates('DEL')">Optional Delivery Date Selection</button>
          </td>
          <td class=DTb1 id="tdDate4" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>Delivery Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrActDt')">&#60;</button>
              <input class="Small" name="FrActDt" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrActDt')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 700, document.all.FrActDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Delivery Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToActDt')">&#60;</button>
              <input class="Small" name="ToActDt" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToActDt')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 700, document.all.ToActDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDelDates" onclick="showAllDates('DEL')">All Date</button>
          </TD>
      </TR>

      <!-- ======================= Date Selection ========================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <TR>
        <td class=DTb1 colspan=4 align=center style="padding-top: 10px;" >
          <input name="Str" type="checkbox" value="0">Home Office
          <%for(int i=0; i < iNumOfStr; i++){%>
                  <input name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i == 13 || i > 15 && i % 15 == 0){%><br><%}%>
              <%}%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;

              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>Okla</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
        </td>
      </tr>

      <!-- =============================================================================== -->
      <tr>
         <td align="center" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button onClick="Validate()">Submit</button>
      </tr>


      </table>
         <br><br><br><br><br><br>&nbsp;
      </td>

     </tr>
   </table>
  </body>
</html>
