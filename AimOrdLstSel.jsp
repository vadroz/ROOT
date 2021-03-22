<%@ page import="rciutility.StoreSelect"%>
<%
   String sStrAllowed = null;

   StoreSelect strsel = new StoreSelect();
   String sStr = strsel.getStrNum();
   String sStrName = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();

   int iSpace = 6;
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
var StrAllowed = "<%=sStrAllowed%>";

//------------------------------------------------------------------------------
// populate fields on page load
//------------------------------------------------------------------------------
function bodyLoad()
{
   checkAll(true)

   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.FrDate.value = "01/01/0001"
      document.all.ToDate.value = "12/31/2999"
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

//==============================================================================
// show date selection
//==============================================================================
function showDates()
{
   document.all.tdDate1.style.display="none"
   document.all.tdDate2.style.display="block"
   doSelDate()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(){
  var df = document.all;
  var date = new Date(new Date() - 7 * 86400000);

  df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  date = new Date(new Date());
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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

   var emp = document.all.Emp.value.trim();
   if(isNaN(emp)){  error=true; msg+="\nThe Employee Number is not numeric."; }

   var sku = document.all.Sku.value.trim();
   if(isNaN(sku)){  error=true; msg+="\nThe SKU is not numeric."; }

   var frdate = document.all.FrDate.value
   var todate = document.all.ToDate.value


   if(error){alert(msg)}
   else{ smbEmpLst(selstr, emp, sku, frdate, todate) }
}
//------------------------------------------------------------------------------
// change action on submit
//------------------------------------------------------------------------------
function smbEmpLst(selstr, emp, sku, frdate, todate)
{
   var url = "AimOrdLst.jsp?";
   for(var i=0; i < selstr.length; i++)
   {
     url += "&Str=" + selstr[i];
   }

   url += "&Emp=" + emp
       + "&Sku=" + sku
       + "&FrDate=" + frdate
       + "&ToDate=" + todate
       ;

   //alert(url);
   window.location.href=url;
}
</SCRIPT>
</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

 <body  onload="bodyLoad();">

  <table border="0" align=center width="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Associates in Motion(AIM) Employee Order List - Selection</b>
       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
       &nbsp; &nbsp; &nbsp; &nbsp;
       <br>

      <table border=0>
      <!-- =============================================================================== -->
      <!-- Store list -->
      <!-- =============================================================================== -->
      <tr>
         <td valign=top>Store:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                <td class="Small" colspan=3>
                    <input type="checkbox" class="Small" name="Str" value="0">Home Office &nbsp;
                </td>
                <%for(int i=0, j=3; i < iNumOfStr; i++){%>
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
                <button onclick="checkAll(false)" class="Small">Reset</button>
         </td>
      </tr>
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="font-size:1px;border-top:1px solid darkred">&nbsp;</td>
      </tr>

      <!-- =============================================================================== -->
      <!-- Employee -->
      <!-- =============================================================================== -->
      <tr>
         <td valign=top>Employee:</td>
         <td colspan=2>&nbsp;<input name="Emp" size=4 maxlength=4> &nbsp; &nbsp;</td>
         <td rowspan=2>Employee or SKU selection(s) will override Store selections</td>
      </tr>
      <!-- =============================================================================== -->
      <!-- Employee -->
      <!-- =============================================================================== -->
      <tr>
         <td valign=top>SKU:</td>
         <td colspan=2>&nbsp;<input name="Sku" size=10 maxlength=10></td>

      <!-- ======================== From Date ======================================= -->
        <TR>
          <TD class=DTb1 id="tdDate1" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <button class="Small" id="btnSelOrdDates" onclick="showDates()">Optional Order Date Selection</button> &nbsp;
          </td>
          <TD class=DTb1 id="tdDate2" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>Order Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 650, document.forms[0].FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Order Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 650, document.forms[0].ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelOrdDates" onclick="showAllDates()">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="font-size:1px;border-top:1px solid darkred">&nbsp;</td>
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
