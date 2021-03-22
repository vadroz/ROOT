<%@ page import="rciutility.StoreSelect
    , rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
   String sStrAllowed = null;

   StoreSelect strsel = new StoreSelect();
   String sStr = strsel.getStrNum();
   String sStrName = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String sStrRegJsa = strsel.getStrReg();
   
   
   	String sStmt = "Select etitl from RCI.RciEmp"
   	  + " where ESEPR = ''"		
   	  + " group by etitl"
   	  + " order by etitl"
   	;
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();

	Vector<String> vTitle = new Vector<String>();	
	while(runsql.readNextRecord())
	{
		vTitle.add(runsql.getData("etitl").trim());
	}       
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

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
var ArrStrReg = [<%=sStrRegJsa%>];


//------------------------------------------------------------------------------
// populate fields on page load
//------------------------------------------------------------------------------
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
  	doWeekSelect();
}
//------------------------------------------------------------------------------
// Weeks Stores
//------------------------------------------------------------------------------
function doWeekSelect() {
    var df = document.all;
    var idx = 0;

    var todate = new Date();
    var sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);

    sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
    df.FrWeek.value = sundayUSA;
    df.ToWeek.value = sundayUSA;
}

//------------------------------------------------------------------------------
// change to date when from date selected. This will be prevent error when from
// date greater than to date
//------------------------------------------------------------------------------
function chgToDate(selTo)
{
  var df = document.all;

  var to = new Date(selTo.options[selTo.selectedIndex].value);
  var from = new Date(df.FROMWK.options[df.FROMWK.selectedIndex].value);

  if(to < from)
  {
    for (var i = 0; i < df.FROMWK.length; i++)
    {
      if(df.FROMWK.options[i].value <= selTo.options[selTo.selectedIndex].value)
      {

        df.FROMWK.selectedIndex = i;
        break;
      }
    }
  }
}
//------------------------------------------------------------------------------
// check all stores
//------------------------------------------------------------------------------
function checkAll(chk)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk;
  }
}
//------------------------------------------------------------------------------
//check all stores
//------------------------------------------------------------------------------
function checkTtlAll(chk)
{
var ttl = document.all.Ttl

for(var i=0; i < ttl.length; i++)
{
  ttl[i].checked = chk;
}
}
//------------------------------------------------------------------------------
// submit trending pick performance
//------------------------------------------------------------------------------
function setPickPerf()
{
   document.all.Incl[0].checked = true;
   document.all.Seas[1].checked = true;
   document.all.Active[0].checked = true;
   document.all.NumOfEmp.value = "30";
   document.all.NumOfHrs.value = "300";
   document.all.RankSel.checked = false;
   document.all.DtGrp[2].checked = true;
   setDtRange();
   Validate();
}
//------------------------------------------------------------------------------
// Validate entry
//------------------------------------------------------------------------------
function Validate()
{
   var error = false;
   var msg = "";

   // get selected stores
   var str = document.all.Str;
   var selstr = new Array();
   var numstr = 0
   var selnm = null;
   for(var i=0; i < str.length; i++)
   {
     if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; selnm = storeNames[i+1]; }
   }
   if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}
   
   // get selected titles
   var ttl = document.all.Ttl;
   var selttl = new Array();
   var numttl = 0
   for(var i=0; i < ttl.length; i++)
   {
     if(ttl[i].checked){ selttl[numttl] = ttl[i].value; numttl++ }
   }
   if (numttl == 0){ error=true; msg+="At least 1 title must be selected.";}

   var selFrWeek = document.all.FrWeek.value.trim();
   var selToWeek = document.all.ToWeek.value.trim();

   var grp = document.all.DtGrp;
   var grpnum = 0;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         grpnum=i;
         selFrWeek = grp[i].value;
         break;
      }
   }

   // get Included employees
   var incl = document.all.Incl;
   var selincl = new Array();
   var bIncl = false;
   for(var i=0, j=0; i < incl.length; i++)
   {
     if(incl[i].checked){ selincl[j] = incl[i].value; bIncl = true; }
     else { selincl[j] = "N"}
     j++;
   }
   if (!bIncl){ error=true; msg+="\nAt least 1 employee group must be selected."; }

   var seas = document.all.Seas;
   for(var i=0; i < seas.length; i++)
   {
      if(seas[i].checked){ selincl[selincl.length] = seas[i].value;  break;}
   }

   // get Included employees
   var active = document.all.Active;
   var selact = "1";
   for(var i=0; i < active.length; i++)
   {
     if(active[i].checked){ selact = active[i].value; }
   }

   var numemp = document.all.NumOfEmp.value.trim().toUpperCase()
   if(numemp != "ALL")
   {
      if(isNaN(numemp) || eval(numemp) <= 0){ error=true; msg+="\nThe Number of Employees is invalid."; }
   }

   var ranksel = "N";
   if (document.all.RankSel.checked){ ranksel = "Y"; }

   var numhrs = document.all.NumOfHrs.value.trim()
   if(isNaN(numhrs) || eval(numhrs) < 0){ error=true; msg+="\nThe Number of Hours is invalid."; }

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrWeek, selToWeek, selincl, numemp, numhrs, selact, ranksel, selttl) }
}
//------------------------------------------------------------------------------
// change action on submit
//------------------------------------------------------------------------------
function submitForm(selstr, selFrWeek, selToWeek, selincl, numemp, numhrs, selact, ranksel, selttl){
   var url;

   url = "EmpSlsPerform.jsp?FrWeek=" + selFrWeek + "&ToWeek=" + selToWeek;
   for(var i=0; i < selstr.length; i++)
   {
     url += "&Str=" + selstr[i];
   }

   for(var i=0; i < selincl.length; i++)
   {
     url += "&Incl=" + selincl[i];
   }
   
   for(var i=0; i < selttl.length; i++)
   {
     url += "&Ttl=" + selttl[i];
   }
   

   url += "&NumEmp=" + numemp;
   url += "&NumHrs=" + numhrs;
   url += "&ActEmp=" + selact;
   url += "&RankSel=" + ranksel;

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// set date ranges
//==============================================================================
function setDtRange()
{
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         document.all.trDt2.style.display="none"; break;
      }
      else if(grp[i].checked)
      {
         document.all.trDt2.style.display="block"; break;
      }
   }
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
     for(var j=0; j < stores.length; j++)
     {
        if(dist != "PATIO" && str[i].value == stores[j] && ArrStrReg[j] == dist
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
     for(var j=0; j < stores.length; j++)
     {
        if(dist != "PATIO" && str[i].value == stores[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
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
       <br>Employee Sales Performance Ranking - Selection</b><br>

      <table border=0>
      <!-- =============================================================================== -->
      <!-- Store list -->
      <!-- =============================================================================== -->
      <tr>
         <td valign=top>Store:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                <%for(int i=0, j=0; i < iNumOfStr; i++){%>
                  <%if(!sStrLst[i].equals("55") && !sStrLst[i].equals("89")){%>
                    <%if(j > 0 && j % 15 == 0){%><tr><%}%>
                    <td class="Small">
                      <input type="checkbox" class="Small" name="Str" value="<%=sStrLst[i]%>"><%=sStrLst[i]%>
                      <%j++;%>
                    </td>
                  <%}%>
                <%}%>
               </tr>
            </table>
            <br><button onclick="checkAll(true)" class="Small">Check All</button> &nbsp; &nbsp;
                <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
                <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
                <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
                <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
                <button onclick="checkAll(false)" class="Small">Reset</button>
         </td>
         
      <!-- =============================================================================== -->
      <!-- Title list -->
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
         <td valign=top>Titles:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                <%for(int i=0, j=0; i < vTitle.size(); i++){%>                  
                    <%if(j > 0 && j % 10 == 0){%><tr><%}%>
                    <td class="Small">
                      <input type="checkbox" class="Small" name="Ttl" value="<%=vTitle.get(i)%>"><%=vTitle.get(i)%>
                      <%j++;%>
                    </td>
                  <%}%>                
               </tr>
            </table>
            <br><button onclick="checkTtlAll(true)" class="Small">Check All</button> &nbsp; &nbsp;                
                <button onclick="checkTtlAll(false)" class="Small">Reset</button>
         </td>   

      <!-- =============================================================================== -->
      <!-- Include group of employee -->
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
         <td valign=middle>Employee Groups:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                  <td class="Small"><input type="checkbox" class="Small" name="Incl" value="Y" checked>Commission Employees</td> &nbsp; &nbsp;
                  <td class="Small"><input type="checkbox" class="Small" name="Incl" value="Y">Salespersons</td>
                  <td class="Small"><input type="checkbox" class="Small" name="Incl" value="Y">Hourly Non-Sales</td>
              </tr>
              <tr>
                <td class="Small"><input type="checkbox" class="Small" name="Incl" value="Y">Salaried Managers</td>
              </tr>
            </table>
         </td>

      <!-- =============================================================================== -->
      <!-- Include group of employee -->
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
         <td valign=middle>Seasonal:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                <td class="Small"><input type="radio" class="Small" name="Seas" value="Y" checked>Include</td>
                <td class="Small"><input type="radio" class="Small" name="Seas" value="N">Exclude</td>
              </tr>
            </table>
         </td>
      <!-- =============================================================================== -->
      <!-- filter active/inactive  -->
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
         <td valign=middle>Active/Inactive Employees:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                  <td class="Small"><input type="radio" class="Small" name="Active" value="1" checked>Active</td>
                  <td class="Small"><input type="radio" class="Small" name="Active" value="2">Inactive(termed)</td>
                  <td class="Small"><input type="radio" class="Small" name="Active" value="3">Any</td>
              </tr>
            </table>
         </td>

      <!-- =============================================================================== -->
      <!-- Number of employees on report -->
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
         <td valign=middle>Number of Employees:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                 <td class="Small"><input class="Small" name="NumOfEmp" value="ALL" size=3 maxlength=3 checked>(Number or ALL)</td>
              </tr>
            </table>
         </td>
      </tr>
      <tr>
         <td colspan=4 valign=middle>Include Employee who worked more than:
            <input class="Small" name="NumOfHrs" value="10" size=4 maxlength=4>
         </td>
      </tr>
      <tr>
         <td colspan=4 valign=middle>Rank based on selection criteria:
            <input class="Small" type="checkbox" name="RankSel" value="Y">
         </td>
      </tr>
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>

      <tr id="trDt1">
        <td align="left">Date Selection:&nbsp</td>
        <td align="left"  class="Small" colspan=2>
          <input type="radio" name="DtGrp" value="WTD" onclick="setDtRange()">W-T-D &nbsp; &nbsp;
          <input type="radio" name="DtGrp" value="MTD" onclick="setDtRange()">M-T-D &nbsp; &nbsp;
          <input type="radio" name="DtGrp" value="YTD" onclick="setDtRange()">Y-T-D &nbsp; &nbsp;
          <input type="radio" name="DtGrp" value="PMN" onclick="setDtRange()">Prior Month &nbsp; &nbsp;
          <input type="radio" name="DtGrp" value="RANGE" onclick="setDtRange()" checked>Date Range
        </td>
      </tr>

      <tr id="trDt2">
        <td align="right">From Week:&nbsp</td>
        <td>
           <button class="Small" name="Down" onClick="setDate('DOWN', 'FrWeek')">&#60;</button>
           <input name="FrWeek" class="Small" size="10" readOnly/>
           <button class="Small" name="Down" onClick="setDate('UP', 'FrWeek')">&#62;</button>
           <a href="javascript:showCalendar(1, null, null, 350, 400, document.all.FrWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
        <td align="right">To Week:&nbsp</td>
        <td>
           <button class="Small" name="Down" onClick="setDate('DOWN', 'ToWeek')">&#60;</button>
           <input name="ToWeek" class="Small" size="10" readOnly/>
           <button class="Small" name="Down" onClick="setDate('UP', 'ToWeek')">&#62;</button>
           <a href="javascript:showCalendar(1, null, null, 650, 400, document.all.ToWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
      </tr>
      <!-- =============================================================================== -->
      <tr>
         <td align="center" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button onClick="setPickPerf()">Trending Peak Performer</button>
         <br><button onClick="Validate()">Submit</button>
      </tr>


      </table>
         <br><br><br><br><br><br>&nbsp;
      </td>

     </tr>
   </table>
  </body>
</html>
