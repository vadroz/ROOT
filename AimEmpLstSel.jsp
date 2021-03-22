<%@ page import="rciutility.StoreSelect"%>
<%
   String sStrAllowed = null;

   StoreSelect strsel = new StoreSelect(18);
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

   if(error){alert(msg)}
   else{ smbEmpLst(selstr) }
}
//------------------------------------------------------------------------------
// change action on submit
//------------------------------------------------------------------------------
function smbEmpLst(selstr){
   var url;

   url = "AimEmpLst.jsp?";
   for(var i=0; i < selstr.length; i++)
   {
     url += "&Str=" + selstr[i];
   }

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
       <br>Associates in Motion(AIM) Event List - Selection</b>
       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
       &nbsp; &nbsp; &nbsp; &nbsp;
       <a href="AimEmpSign.jsp?id=0" >Add Employee</a>
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
