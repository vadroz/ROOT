<%@ page import="rciutility.StoreSelect, java.util.*"%>
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

   boolean bAllowWeekly = false;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sStrAllowed = null;

   System.out.println(0);
   String sAppl = "PRBGACVAR";
   System.out.println("appl=" +  session.getAttribute(sAppl));
   System.out.println(1);
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PsActAvgVarSel.jsp&APPL=" + sAppl);
   }
   else
   {

     sStrAllowed = session.getAttribute("STORE").toString();
     boolean bReg1Alw = session.getAttribute(sAppl + "1") != null;
     boolean bReg2Alw = session.getAttribute(sAppl + "2") != null;
     boolean bReg3Alw = session.getAttribute(sAppl + "3") != null;

     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     int iStrAlwLst = 0;
     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (sStrAllowed != null)
     {
        if (sStrAllowed.startsWith("ALL"))
        {
            StrSelect = new StoreSelect(5);
        }
        else
        {
           if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst);}
           else StrSelect = new StoreSelect(new String[]{sStrAllowed});
        }

        sStr = StrSelect.getStrNum();
        sStrName = StrSelect.getStrName();
        if(sStrAllowed.startsWith("ALL") || vStr != null && vStr.size() > 1){ bAllowWeekly = true; }
        StrSelect = null;
     }
%>

<html>
<head>
<style>body {background:ivory;}
       a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
       table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
       th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
       td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
       td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
       td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

       .Small {font-size:10px }
</style>

<script language="javascript">
 var stores = [<%=sStr%>];
 var storeNames = [<%=sStrName%>];

//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
    doStrSelect();
    setNumOfWeek();
    setStrGrp();
    doWeekSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.forms[0];
    var idx = 0;
    var idy = 0;

    <%if(bReg1Alw){%>stores[stores.length] = "Reg 1"; storeNames[storeNames.length] = "";<%}%>
    <%if(bReg2Alw){%>stores[stores.length] = "Reg 2"; storeNames[storeNames.length] = "";<%}%>
    <%if(bReg3Alw){%>stores[stores.length] = "Reg 3"; storeNames[storeNames.length] = "";<%}%>

    <%if(!sStrAllowed.startsWith("ALL")){%> idy = 1;<%}%>

    for (; idy < stores.length; idx++, idy++)
    {
       df.STORE.options[idx] = new Option(stores[idy] + " - " + storeNames[idy], stores[idy]);
    }
    document.getStore.STORE.selectedIndex=0;
}
//==============================================================================
// Number of week fields
//==============================================================================
function setNumOfWeek()
{
   if(document.all.WkSel[0].checked)
   {
      document.all.tr1wk.style.display = "block";
      document.all.tr2wk.style.display = "none";
   }
   else if(document.all.WkSel[1].checked)
   {
      document.all.tr1wk.style.display = "none";
      document.all.tr2wk.style.display = "block";
   }
}
//==============================================================================
// Number of week fields
//==============================================================================
function setStrGrp()
{
   var str = document.all.STORE.options[document.all.STORE.selectedIndex].value;
   if(str == "ALL" || str.indexOf("Reg") >= 0) { document.all.trGrp.style.display = "block"; }
   else { document.all.trGrp.style.display = "none"; }
}
//==============================================================================
// Weeks
//==============================================================================
function doWeekSelect(id)
{
   var date = new Date(new Date() - 86400000);
   date.setHours(18);
   if(date.getDay() > 0)
   {
     date = new Date(date - 86400000 * date.getDay());
     date = new Date(date - 86400000 * (-7));
   }

   cvtDt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   document.all.Week.value = cvtDt;
   document.all.FrWeek.value = cvtDt;
   document.all.ToWeek.value = cvtDt;
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var url = "";
   var selStore = document.getStore.STORE.options[document.getStore.STORE.selectedIndex].value;
   var strid = 0;
   for(var i=0; i < storeNames.length; i++)
   {
      if(stores[i] == selStore){ strid = i; break; }
   }
   var strnm = storeNames[strid];

   var wknum = 1;
   if(document.all.WkSel[0].checked){ wknum = 2; }

   var grp = 1;
   if(document.getStore.GrpSel[1].checked){ grp = 2; }

   var week = document.getStore.Week.value
   var frwk = document.getStore.FrWeek.value
   var towk = document.getStore.ToWeek.value

   // change from and to weeks for one week selections
   if(document.all.WkSel[0].checked){ frwk = "BEGWEEK"; towk = week; }

   // show all store for 1 week
   if (selStore != "ALL" && selStore.indexOf("Reg") < 0)
   {
     url = "PsActAvgVar.jsp"
         + "?Store=" + selStore
         + "&StrNm=" + strnm
         + "&From=" + frwk
         + "&To=" + towk
   }
   // show 1 month for 1 store
   else
   {
      if(grp == 1){ url = "PsActAvgVarCmpByGrp.jsp?Store=" + selStore + "&From=" + frwk + "&To=" + towk }
      else { url = "PsActAvgVarAllStr.jsp?Store=" + selStore + "&From=" + frwk + "&To=" + towk }
   }

    //alert(url);
    window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>



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
      <br>Budget vs. Actual Variances - Selection<br>
      </b>
      <a href="../" class="small"><font color="red">Home</font></a>

      <form name="getStore" action="javascript:submitForm()">
      <table border="0" cellPadding="0" cellSpacing="0">

      <!-- ================================================================= -->
      <tr><td colspan=4 align="center"><b>Select Store</b></td>
      <tr><td colspan="4" align="center">Store:&nbsp;<SELECT name="STORE" class="Small" onchange="setStrGrp()"></SELECT></td>
      <tr id="trGrp">
         <td colspan="4" align="center">
            <input name="GrpSel" type="radio" value="1" class="Small" checked>By Budget Groups
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input name="GrpSel" type="radio" value="2" class="Small">By Store
         </td>
      </tr>
      <tr><td colspan="4">&nbsp;</td></td>

      <!-- ================================================================= -->
      <tr style="background:darkred; font-size:1px"><td colspan=4>&nbsp;</td></tr>
      <tr>
         <td colspan="4" align="center"><b>Select Week(s)</b></td>
      </tr>
      <tr>
         <td colspan="4" align="center">
            <input name="WkSel" type="radio" value="1" class="Small" onclick="setNumOfWeek();" checked>One week
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input name="WkSel" type="radio" value="2" class="Small" onclick="setNumOfWeek();">Two weeks
         </td>
      </tr>

      <tr><td colspan="4">&nbsp;</td></td>

      <tr id="tr1wk">
        <td colspan="4" align="center">Week:&nbsp; <input name="Week" class="Small" size="10" readOnly/>
         <a href="javascript:showCalendar(1, null, null, 650, 350, document.all.Week)">
         <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
      </tr>

      <tr id="tr2wk">
        <td align="right">From Week:&nbsp</td><td><input name="FrWeek" class="Small" size="10" readOnly/>
           <a href="javascript:showCalendar(1, null, null, 650, 350, document.all.FrWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
        <td align="right">To Week:&nbsp</td><td><input name="ToWeek" class="Small" size="10" readOnly/>
           <a href="javascript:showCalendar(1, null, null, 650, 350, document.all.ToWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
      </tr>
      <tr><td colspan="4">&nbsp;</td></td>

      <!-- ================================================================= -->
      <tr style="background:darkred; font-size:1px"><td colspan=4>&nbsp;</td></tr>
      <tr>
         <td colspan="4" align="center"><br><input type="submit" value="Submit" class="Small"></td>
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>

 <%}%>