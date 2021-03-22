<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=StrEmpCommSel.jsp&APPL=" + sAppl);
   }
   else {

     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     boolean bAllStrAlw = true;

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       StrSelect = new StoreSelect(10);
     }
     else
     {
       Vector vStr = (Vector) session.getAttribute("STRLST");
       String [] sStrAlwLst = new String[ vStr.size()];
       Iterator iter = vStr.iterator();

       int iStrAlwLst = 0;
       while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

       System.out.println(sStrAllowed);
       if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
       //else StrSelect = new StoreSelect(new String[]{sStrAllowed});
       else { StrSelect = new StoreSelect(sStrAllowed); bAllStrAlw = false;}
    }

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();


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
  .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";

//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
  	
	doStrSelect();
  	doSelDate();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    var j = 0;
    <%if(!bAllStrAlw){%>j=1<%}%>
    for (var i=0; j < stores.length; i++, j++)
    {
      df.Store.options[i] = new Option(stores[j] + " - " + storeNames[j],stores[j]);
    }
    document.all.Store.selectedIndex=0;
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * (dofw - 7));
  document.all.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// change action on submit
//==============================================================================
function validate()
{
   var error =false;
   var msg = "";

   var url = null;
   var str = document.all.Store.options[document.all.Store.selectedIndex].value;
   var strId = document.all.Store.selectedIndex;
   var wkend = document.all.Wkend.value

   url = "StrEmpComm.jsp?Store=" + str + "&StrName=" + storeNames[strId] + "&Wkend=" + wkend;


   if (error) {alert(msg); }
   else { submit(url) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(url)
{
    //alert(url);
    window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body  onload="bodyLoad();">

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Store Employee Commissions - Selection
       </b><br><br>

       <a href="index.jsp">Home</a>

      <table>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td><br>Select Store:<br><br></td><td><br><SELECT name="Store"></SELECT><br><br></td>
      </tr>
      <!-- ============================== Weekly ================================= -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR id="trWkSel">
          <TD align=center colspan=2><br>
           Week Ending Date: &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend')">&#60;</button>
              <input name="Wkend" type="text" size=10 maxlength=10 readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'Wkend')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.Wkend)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <br><br>
          </TD>
      </TR>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button name="submit" onClick="validate()">Submit</button>
      </tr>
      </table>
                </td>
            </tr>
       </table>

        </body>
      </html>
<%}%>