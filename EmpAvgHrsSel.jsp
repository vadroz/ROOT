<%@ page import="rciutility.StoreSelect, java.sql.*, rciutility.RunSQLStmt"%>
<%
   String sStrAllowed = null;

   StoreSelect strsel = new StoreSelect();
   String sStr = strsel.getStrNum();
   String sStrName = strsel.getStrName();
   String sReg = strsel.getStrReg();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();

   String sPrepStmt = "select char(piyb + 6 days, usa) as piyb "
     + " from rci.fsyper"
     + " where pida= current date";

   System.out.println(sPrepStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   ResultSet rs = runsql.runQuery();
   String sYrBeg = null;

   if(runsql.readNextRecord())
   {
      sYrBeg = runsql.getData("piyb");
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

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var strReg = [<%=sReg%>];
var StrAllowed = "<%=sStrAllowed%>";
var YrBeg = "<%=sYrBeg%>";

//------------------------------------------------------------------------------
// populate fields on page load
//------------------------------------------------------------------------------
function bodyLoad(){
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
    
    frdate = new Date(sunday - (86400000 * 7 * 51 + 1) );    
    df.FrWeek.value = eval(frdate.getMonth()+1) + "/" + frdate.getDate() + "/" + frdate.getFullYear(); 
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

  for(var i=0; i < <%=iNumOfStr%>; i++)
  {
     str[i].checked = chk;
  }
}
//------------------------------------------------------------------------------
// check all stores
//------------------------------------------------------------------------------
function checkReg(reg)
{
  var str = document.all.Str
  
  for(var i=1, j=0; i < <%=iNumOfStr+1%>; i++, j++)
  {
     if(strReg[i] == reg)
     {
    	 str[j].checked = true;    	 
     }
     else{ str[j].checked = false; }
  }  
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

   // get Included employees
   var active = document.all.Active;
   var selact = "1";
   for(var i=0; i < active.length; i++)
   {
     if(active[i].checked){ selact = active[i].value; }
   }

   var numhrs = document.all.NumOfHrs.value.trim()
   if(isNaN(numhrs) || eval(numhrs) < 0){ error=true; msg+="\nThe Number of Hours is invalid."; }

   // get Included employees
   var ttl = document.all.Title;
   var selttl = new Array();
   for(var i=0, j=0; i < ttl.length; i++)
   {
     if(ttl[i].checked){ selttl[j] = ttl[i].value; j++}
   }


   if(error){alert(msg)}
   else{ submitForm(selstr, selFrWeek, selToWeek, selincl, numhrs, selact, selttl) }
}
//------------------------------------------------------------------------------
// change action on submit
//------------------------------------------------------------------------------
function submitForm(selstr, selFrWeek, selToWeek, selincl, numhrs, selact, selttl){
   var url;

   url = "EmpAvgHrs.jsp?FrWeek=" + selFrWeek + "&ToWeek=" + selToWeek;
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
     url += "&TtlExc=" + selttl[i];
   }
   if(selttl.length == 0){url += "&TtlExc=NONE";}

   url += "&ActEmp=" + selact;
   url += "&NumHrs=" + numhrs;

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
</SCRIPT>
</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

 <body  onload="bodyLoad();">

  <table border="0" align=center width="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Employee Average Hours - Selection</b><br>
       <a href="/"><font color="red" size="-1">Home</font></a>


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
                    <%if(j > 0 && j % 15 == 0){%><tr><%}%>
                    <td class="Small">
                      <input type="checkbox" class="Small" name="Str" value="<%=sStrLst[i]%>"><%=sStrLst[i]%>
                      <%j++;%>
                    </td>

                <%}%>
               </tr>
            </table>
            <br><button onclick="checkAll(true)" class="Small">Check All</button> &nbsp; &nbsp;
                <button onclick="checkReg('1')" class="Small">Reg 1</button> &nbsp; &nbsp;
                <button onclick="checkReg('2')" class="Small">Reg 2</button> &nbsp; &nbsp;
                <button onclick="checkReg('3')" class="Small">Reg 3</button> &nbsp; &nbsp;
                <button onclick="checkReg('99')" class="Small">Reg 99</button> &nbsp; &nbsp;
                <button onclick="checkAll(false)" class="Small">Reset</button>
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
                  <td class="Small"><input type="checkbox" class="Small" name="Incl" value="H">Hourly</td>
                  <td class="Small"><input type="checkbox" class="Small" name="Incl" value="S">Salaried</td>
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
      </tr>
      <tr>
         <td colspan=4 valign=middle>Include Employee who averaged more than:
            <input class="Small" name="NumOfHrs" value="30" size=3 maxlength=3>
         </td>
      </tr>

      <tr>
         <td valign=middle>Exclude:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                  <td class="Small"><input type="checkbox" class="Small" name="Title" value="FT">FT</td>
                  <td class="Small"><input type="checkbox" class="Small" name="Title" value="PT">PT</td>
                  <td class="Small"><input type="checkbox" class="Small" name="Title" value="SE">SE</td>
              </tr>
            </table>
         </td>
      </tr>

      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>

      <tr id="trDt1">
        <td align="left">Date Selection:&nbsp</td>
        <td align="left"  class="Small" colspan=2 style="display:none">
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
           <a href="javascript:showCalendar(1, null, null, 650, 350, document.all.FrWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
        <td align="right">To Week:&nbsp</td>
        <td>
           <button class="Small" name="Down" onClick="setDate('DOWN', 'ToWeek')">&#60;</button>
           <input name="ToWeek" class="Small" size="10" readOnly/>
           <button class="Small" name="Down" onClick="setDate('UP', 'ToWeek')">&#62;</button>
           <a href="javascript:showCalendar(1, null, null, 650, 350, document.all.ToWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
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
