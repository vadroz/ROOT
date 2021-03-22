<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PRHIST";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgAvgWageSel.jsp&APPL=" + sAppl);
}
else
{
   sStrAllowed = session.getAttribute("STORE").toString();
   sUser = session.getAttribute("USER").toString();

   StrSelect = new StoreSelect(10);
   String [] sStrArr = StrSelect.getStrLst();
   int iNumOfStr = StrSelect.getNumOfStr();

   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   String sCurDate = sdf.format(dCurDate);

   String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
     + " where pida='" + sCurDate + "'";
   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   runsql.readNextRecord();
   String sYear = runsql.getData("pyr#");
   String sMonth = runsql.getData("pmo#");
   String sMnend = runsql.getData("pime");
   runsql.disconnect();
   runsql = null;
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

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";

var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
  doMonthSelect();
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doMonthSelect(id)
{
  var year = CurYear - 1;
  for (var i=0; i < 3; i++)
  {
     document.all.Year.options[i] = new Option(year, year);
     if (year == CurYear ){ document.all.Year.selectedIndex = i; }
     year++;
  }

  var mon = ["April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"]

  for (var i=0; i < mon.length; i++)
  {
     document.all.Month.options[i] = new Option(mon[i], (i+1));
     if (i == CurMonth ){ document.all.Month.selectedIndex = i; }
  }

}
//==============================================================================
// change action on submit
//==============================================================================
function validate()
{
   var error =false;
   var msg = "";

   var url = null;
   var str = new Array();
   var strfnd = false;

   for(var i=0, j=0; i < document.all.Store.length; i++)
   {
      if(document.all.Store[i].checked){ str[j++] = document.all.Store[i].value; strfnd = true;}
   }
   if(!strfnd){ error = true; msg += "Please check at least 1 store."; }

   var strId = document.all.Store.selectedIndex;
   var year = document.all.Year[document.all.Year.selectedIndex].value
   var monnum = document.all.Month[document.all.Month.selectedIndex].value
   var monname = document.all.Month[document.all.Month.selectedIndex].text

   var over = document.all.Over.value.trim();
   if(isNaN(over)){ error = true; msg += "Value of Over variance is not numeric"; }

   var under = document.all.Under.value.trim();
   if(isNaN(under)){ error = true; msg += "Value of Under variance is not numeric"; }

   if (error) {alert(msg); }
   else { submit(str, year, monnum, monname, over, under) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(str, year, monnum, monname, over, under)
{
    url = "BfdgAvgWage.jsp?Year=" + year + "&Month=" + monnum + "&MonName=" + monname;
    for(var i=0; i < str.length; i++)
    {
       url += "&Str=" + str[i]
    }
    url += "&Over=" + over;
    url += "&Under=" + under;

    //alert(url);
    window.location.href=url;
}
//==============================================================================
// change action on submit
//==============================================================================
function chkStr(check)
{
   for(var i=0; i < document.all.Store.length; i++)
   {
      document.all.Store[i].checked = check;
   }
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
       <br>Payroll: Budget group average wages break-up by subcategories
       </b><br><br>

       <a href="index.jsp">Home</a>

      <table border=0>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td>Select Store:<br><button onClick="chkStr(true)" class="small">All Stores</button>
                          <br><button onClick="chkStr(false)" class="small">Reset</button>
         </td>
         <td>
            <br>
            <table>
              <tr>
                <%for(int i=0; i < iNumOfStr; i++){%>
                   <%if(i > 0 && i%13 == 0){%></tr><tr><%}%>
                   <td style="font-size:12px;">
                      <input name="Store" class="small" type="checkbox" value="<%=sStrArr[i]%>"><%=sStrArr[i]%>
                   </td>
                <%}%>
              </tr>
            </table>

         </td>
      </tr>

      <!-- ===================== Monthly and Quarterly ===================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR id="trYrSel">
          <TD align=right>Fiscal Year:</td>
          <TD align=left><SELECT name="Year"></SELECT></TD>
      </TR>
      <TR id="trMonSel">
          <TD align=right>Fiscal Month:</td>
          <TD align=left><SELECT name="Month"></SELECT></TD>
      </TR>
      <!-- ===================== Mark Deviation ===================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR id="trVar">
          <TD align=right><b>Mark Variance</b></td>
      </TR>
      <TR id="trVar">
          <TD align=right>Over:&nbsp;<input name="Over" value="10" size="2" maxlenth="2" class="small">%</TD>
          <TD align=left>&nbsp;&nbsp; Under:&nbsp;<input name="Under" value="10" size="2" maxlenth="2" class="small">%</TD>
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