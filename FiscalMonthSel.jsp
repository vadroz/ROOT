<%@ page import="rciutility.StoreSelect, payrollreports.SetMonth, payrollreports.SetWeeks, java.util.*"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sMonBegJSA = null;
   String sMonEndJSA = null;
   String sWeeksJSA = null;
   String sMonthsJSA = null;
   String sBsMonName = null;
   int iStrBase = 0;

   String  sBaseWkJSA = null;
   String  sBsWkNameJSA = null;
   String sBsMonBegJSA = null;
   int iNumOfWeeks = 0;


   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sStrAllowed = null;
   String sAccess = null;
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=FiscalMonthSel.jsp&APPL=" + sAppl);
   }
   else {
     sAccess = session.getAttribute("ACCESS").toString();
     sStrAllowed = session.getAttribute("STORE").toString();

     if (sAccess != null && !sAccess.equals("1"))
     {
       response.sendRedirect("index.jsp");
     }
   }
   //-------------- End Security -----------------
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     int iStrAlwLst = 0;
     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

   if (sStrAllowed != null) {
     if (sStrAllowed.startsWith("ALL"))
     {
       StrSelect = new StoreSelect(5);
     }
     else
     {
       if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); sStrAllowed = "DM";}
       else StrSelect = new StoreSelect(new String[]{sStrAllowed});
     }

     sStr = StrSelect.getStrNum();
     sStrName = StrSelect.getStrName();

     SetMonth setmon = new SetMonth();
     int iNumOfMonth = setmon.getNumOfWeeks();
     sMonBegJSA = setmon.getMonBegJSA();
     sMonEndJSA = setmon.getMonEndJSA();
     iStrBase = setmon.getStrBase();
     sBsMonName = setmon.getBsMonName();
     setmon.disconnect();

     SetWeeks SetWk = new SetWeeks("11WK");
     iNumOfWeeks = SetWk.getNumOfWeeks();
     sWeeksJSA = SetWk.getWeeksJSA();
     sMonthsJSA = SetWk.getMonthBegJSA();

     sBaseWkJSA = SetWk.getBaseWkJSA();
     sBsWkNameJSA = SetWk.getBsWkNameJSA();
     sBsMonBegJSA = SetWk.getBsMonBegJSA();

     SetWk.disconnect();
   }
%>

<html>
<head>
<SCRIPT language="JavaScript">
		document.write("<style>body {background:ivory;}");
                document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
                document.write("table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}");
                document.write("th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }");
                document.write("td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }");
		document.write("td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
                document.write("td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
		document.write("</style>");


var Access = "<%=sAccess%>";
if (Access=="1"){
 var stores = [<%=sStr%>];
 var storeNames = [<%=sStrName%>];
 var MonBegs = [<%=sMonBegJSA%>];
 var MonEnds = [<%=sMonEndJSA%>];
 var StrBase = "<%=iStrBase%>";
 var BsMonName = "<%=sBsMonName%>";
 var StrAllowed;
 <%if (sStrAllowed != null) {%>
       StrAllowed = "<%=sStrAllowed.trim()%>"
 <%}%>

 var RegMon = false;
 <%if(!sStrAllowed.startsWith("ALL") && vStr != null && vStr.size() > 1){%> RegMon = true; <%}%>

 var Weeks = [<%=sWeeksJSA%>];
 var MonthWks = [<%=sMonthsJSA%>];
 var BaseWk = [<%=sBaseWkJSA%>];
 var BsMonBeg = [<%=sBsMonBegJSA%>];
 var BsWkName = [<%=sBsWkNameJSA%>];
 var NumBase = <%=iNumOfWeeks%>

}
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad(){
  if (Access=="1")
  {
    doStrSelect();
    doWeekSelect();
    doMonthSelect();
    document.forms[0].FISMON.disabled=false;
    document.forms[0].WEEK.disabled=true;
  }
  else
  {
    alert("Sorry, you are not authorized for this page.\n"
        + "If you've got this message in error - contact the HQ Help Desk.");
    window.location.href="StrScheduling.html";
  }
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.forms[0];
    var idx = 0;
    var idy = 0;

    stores[stores.length] = "100"
    storeNames[storeNames.length] = "Special Events Only"


    if(StrAllowed != "ALL" && StrAllowed != "DM") idy = 1;
    for (; idy < stores.length; idx++, idy++)
    {
      df.STORE.options[idx] = new Option(stores[idy] + " - " + storeNames[idy],
                                         stores[idy]);
    }

    if(StrAllowed != "ALL" && !RegMon) document.getStore.STORE.selectedIndex=0;
    else document.getStore.STORE.selectedIndex=1;
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doWeekSelect(id) {
    var df = document.forms[0];
    var idx = 0;
    for (idx = 0; idx < Weeks.length; idx++)
    {
       df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
    }
    df.WEEK.selectedIndex = 5;

    for (idy=0; idy < NumBase; idy++, idx++)
    {
      df.WEEK.options[idx] =
            new Option(BsWkName[idy], BaseWk[idy]);
    }
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doMonthSelect(id) {
  var df = document.forms[0];
  for (idx = 0; idx < MonBegs.length; idx++)
       if(idx < StrBase)
       {
         df.FISMON.options[idx] =
              new Option(MonBegs[idx] + " - " + MonEnds[idx], MonBegs[idx]);
       }
       else
       {
         df.FISMON.options[idx] =
                new Option(BsMonName, MonBegs[idx]);
       }

}
//==============================================================================
// change month dropdown menu
//==============================================================================
function chgWkMon(option)
{
  if (option.value=="ALL")
  {
    document.forms[0].FISMON.disabled=true;
    document.forms[0].WEEK.disabled=false;
  }
  else
  {
    document.forms[0].FISMON.disabled=false;
    document.forms[0].WEEK.disabled=true;
  }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var selStore = document.getStore.STORE.options[document.getStore.STORE.selectedIndex].value;
   var idx = document.getStore.WEEK.selectedIndex;
   var selMonth = null;

   // check if base schedule or regular schedule
   if (idx < MonthWks.length)
   {
     selMonth = MonthWks[idx]
   }
   else
   {
     selMonth = BsMonBeg[idx - MonthWks.length];
   }

   // show all store for 1 week
   if (selStore=="ALL")
   {

     SbmString = "FisMonBudgAllStr.jsp"
         + "?MONBEG=" + selMonth
         + "&WEEKEND=" + document.getStore.WEEK.options[idx].value
   }

   // show 1 month for 1 store
   else
   {
     SbmString = "FiscalMonthBudget.jsp"
              + "?STORE=" + selStore
              + "&STRNAME="
              + storeNames[document.getStore.STORE.selectedIndex]
              + "&MONBEG="
              + document.getStore.FISMON.options[document.getStore.FISMON.selectedIndex].value
   }

    //alert(SbmString);
    window.location.href=SbmString;
}
</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

         <div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

           <table border="0" width="100%" height="100%">
            <tr>
            <td height="20%" COLSPAN="2">
              <img src="Sun_ski_logo4.png" /></td>
             </tr>
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Fiscal Month Budget<br>
      <br>Select Store and Fiscal Month </b><br>

      <form name="getStore" action="javascript:submitForm()">
      <table>
      <tr>
         <td>Select Store:</td><td><SELECT name="STORE" onchange="chgWkMon(this)"></SELECT></td>
      <tr>
        <td>Select Fiscal Month:</td><td><SELECT name="FISMON">
            </SELECT></td>
      </tr>
      <tr>
        <td>Select Week:</td><td><SELECT name="WEEK">
            </SELECT></td>
      </tr>
      <tr>
         <td colspan="2" align="center"><input type="submit" value="Submit"></td>
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
