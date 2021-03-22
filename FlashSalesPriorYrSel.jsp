<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect, java.sql.*, rciutility.RunSQLStmt, java.text.*, java.util.*, menu.FlashSalesAvailable"%>
<%
   String sDiv = null;
   String sDivName = null;
   String sDpt = null;
   String sDptName = null;
   String sDptGroup = null;

   ClassSelect  select = new ClassSelect();
   sDiv = select.getDivNum();
   sDivName = select.getDivName();
   sDpt = select.getDptNum();
   sDptName = select.getDptName();
   sDptGroup = select.getDptGroup();

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect(5);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   FlashSalesAvailable flashavail = new FlashSalesAvailable();
   boolean bAvail = flashavail.getAvail();
   flashavail.disconnect();
   if (bAvail)
   {

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }


   // get current fiscal year
      java.util.Date dCurDate = new java.util.Date();
      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      String sCurDate = sdf.format(dCurDate);
      sdf = new SimpleDateFormat("yyyy-MM-dd");

      String sPrepStmt = "select pime, pimb from rci.fsyper"
           + " where pida=pime "
           + " and pyr# >= (select pyr# from rci.fsyper where pida = current date)- 2"
           + " and pyr# <= (select pyr# from rci.fsyper where pida = current date)+ 1"
           + " order by pime";

      //System.out.println(sPrepStmt);
      ResultSet rslset = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.disconnect();
      runsql = null;

      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      runsql.runQuery();
      String sMonEndArr = "";
      String sMonBegArr = "";
      String sComa ="";
      while(runsql.readNextRecord())
      {
         sMonBegArr += sComa + Long.toString(sdf.parse(runsql.getData("pimb")).getTime());
         sMonEndArr += sComa + Long.toString(sdf.parse(runsql.getData("pime")).getTime());
         sComa = ",";
      }
      runsql.disconnect();
      runsql = null;
%>

<style>
        a:link { color:blue; font-size:12px } a:visited { color:blue; font-size:12px }  a:hover { color:blue; font-size:12px }

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
</style>



<script name="javascript">
//================= Global variable ============================================
var MonEndTime = [<%=sMonEndArr%>];
var MonBegTime = [<%=sMonBegArr%>];
var MonBeg = new Array();
var MonEnd = new Array();
//================= End Of Global variable +====================================

function bodyLoad(){
  doStrSelect();
  // populate date with yesterdate
  doSelDate();
  // populate division and department
  doDivSelect(null);

  cvtTimeToDate();
}

//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.all;
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    df.Store.options[0] = new Option(stores[0] + " - " + storeNames[0],stores[0]);
    df.Store.options[1] = new Option("Compare Stores","COMP");
    df.Store.options[2] = new Option("Ski Chalet Stores","SCH");

    for (i = 3, j=1; j < stores.length; i++, j++)
    {
      df.Store.options[i] = new Option(stores[j] + " - " + storeNames[j],stores[j]);
    }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate(){
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.selDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// convert time to date
//==============================================================================
function  cvtTimeToDate()
{
   for(var i=0; i < MonEndTime.length; i++)
   {
      MonEnd[i] = new Date(MonEndTime[i]);
      MonBeg[i] = new Date(MonBegTime[i]);
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="WK") { date = new Date(new Date(date) - 7 * 86400000); }
  else if(direction == "UP" && ymd=="WK") { date = new Date(new Date(date) - 7 * (-86400000)); }

  if(ymd=="MON" || ymd=="YEAR"){ date = getClosedSunday(date, direction, ymd); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// get Closed Suday for selected date
//==============================================================================
function getClosedSunday(date, direction, ymd)
{
   var mnend = getClosedMonthend(date, direction, ymd);
   if (mnend != null){ date = mnend; }
   else
   {
      if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
      else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

      if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
      else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

      var dowk = date.getDay();
      while(dowk != 0)
      {
         date = new Date(new Date(date) - 86400000);
         dowk = date.getDay();
      }
   }
   return date;
}
//==============================================================================
// get closed month ending date
//==============================================================================
function getClosedMonthend(date, direction, ymd)
{
   var calDate = new Date(date);

   var fisDate = null;
   for(var i=0; i < MonEndTime.length; i++)
   {
      if(calDate.getTime() >= MonBegTime[i] && calDate.getTime() <= MonEndTime[i])
      {
         if(direction == "DOWN" && ymd=="MON" && i > 0) { fisDate = MonEnd[i-1]; }
         else if(direction == "UP" && ymd=="MON" && i < (MonEndTime.length - 1)) { fisDate = MonEnd[i+1];  }

         if(direction == "DOWN" && ymd=="YEAR" && i > 11) { fisDate = MonEnd[i-12]; }
         else if(direction == "UP" && ymd=="YEAR" && i < (MonEndTime.length - 12)) { fisDate = MonEnd[i+12]; }

         break;
      }
   }
   return fisDate;
}
//==============================================================================
// populate division dropdown menu
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];

    var allowed;

    if (id == null || id == 0) {
        //  populate the division list
        for (idx = 0; idx < divisions.length; idx++)
            df.Division.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        id = 0;

    }
        allowed = dep_div[id].split(":");

        //  clear current depts
        for (idx = df.Department.length; idx >= 0; idx--)
            df.Department.options[idx] = null;

        //  if all are to be displayed
        if (allowed[0] == "all")
            for (idx = 0; idx < depts.length; idx++)
                df.Department.options[idx] = new Option(deptNames[idx],depts[idx]);

        //  else display the desired depts
        else
            for (idx = 0; idx < allowed.length; idx++)
                df.Department.options[idx] = new Option(deptNames[allowed[idx]],
                                                        depts[allowed[idx]]);
        clearClassSel();
    }
//==============================================================================
// clear Class dropdown menu
//==============================================================================
function clearClassSel()
{
   //  clear current classes
   for (var i = document.all.Class.length; i >= 0; i--)
   {
      document.all.Class.options[i] = null;
   }
   document.all.Class.options[0] = new Option("All Classes","ALL");
}
//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Division.options[document.all.Division.selectedIndex].value
   var dpt = document.all.Department.options[document.all.Department.selectedIndex].value

   var url = "RetreiveDivDptCls.jsp?"
           + "Division=" + div
           + "&Department=" + dpt;
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
   // clear
   for(var i = document.all.Class.length; i >= 0; i--) {document.all.Class.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.Class.options[i] = new Option(clsName[i], cls[i]);
   }
}
//==============================================================================
// check, if level must be set visible or not depend on store selection
//==============================================================================
function onStrChg(str)
{
   if (str.value != "ALL" && str.value != "COMP"){ document.all.spChain.style.visibility = "hidden" }
   else { document.all.spChain.style.visibility = "visible" }
}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(){
  var form = document.all;
  var error = false;
  var msg;
  var divIdx = form.Division.selectedIndex;
  var dptIdx = form.Department.selectedIndex;
  var clsIdx = form.Class.selectedIndex;
  var strIdx = form.Store.selectedIndex;

  var div = form.Division.options[divIdx].value;
  var dpt = form.Department.options[dptIdx].value;
  var cls = form.Class.options[clsIdx].value;
  var str = form.Store.options[strIdx].value;
  var divnm = form.Division.options[divIdx].text;
  var dptnm = form.Department.options[dptIdx].text;
  var clsnm = form.Class.options[clsIdx].text;
  var date = form.selDate.value;
  var level = null;
  var period = null;

  // Report Level
  if(str == "ALL" && !document.all.Chain.checked) level = "S";
  else if(str == "COMP" && !document.all.Chain.checked) level = "S";
  else if(cls != "ALL" || dpt != "ALL") level = "C";
  else if(div != "ALL" ) level = "P";
  else level = "D";

  var lysel = document.all.LYSeL;
  var lyselval = "";
  for(var i=0; i < lysel.length; i++)
  {
     if(lysel[i].checked){ lyselval = lysel[i].value; break; }
  }
  level += lyselval

  // Report type
  if(document.all.Report[0].checked) period = document.all.Report[0].value;
  else if(document.all.Report[1].checked) period = document.all.Report[1].value;
  else if(document.all.Report[2].checked) period = document.all.Report[2].value;
  else if(document.all.Report[3].checked) period = document.all.Report[3].value;


  if (error) alert(msg);
  else submitReport(str, div, divnm, dpt, dptnm, cls, clsnm, date, level, period);

  return error == false;
}
//==============================================================================
// submit report
//==============================================================================
function submitReport(str, div, divnm, dpt, dptnm, cls, clsnm, date, level, period)
{
   var url = "FlashSalesPriorYr.jsp?"
     + "Store=" + str
     + "&Division=" + div
     + "&DivName=" + divnm
     + "&Department=" + dpt
     + "&DptName=" + dptnm
     + "&Class=" + cls
     + "&clsName=" + clsnm
     + "&Date=" + date
     + "&Level=" + level
     + "&Period=" + period

   //alert(url)
   window.location.href=url
}
</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <%if(!bKiosk){%>
       <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
         size=2>&nbsp;&nbsp;<A class=blue
         href="/">Home</A></FONT><FONT
         face=Arial color=#445193 size=1>
         <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
         href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
         class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
      <TD vAlign=top align=middle><B>Retail Concepts Inc.
             <BR>Flash Sales Report - Selection</B>
    <%} else {%>
          <TD vAlign=top align=center width="15%" bgColor=#a7b5e8><a href="/Outsider.jsp"><font color="red" size="-1">Home</font></a><td>
      <%}%>
    <TABLE>
        <TBODY>
        <TR>
          <TD align=right>Division:</TD>
          <TD align=left>
             <SELECT name="Division" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
          <TD align=right>Department:</TD>
          <TD align=left>
             <SELECT name=Department onChange="clearClassSel()">
                <OPTION value="ALL">All Department</OPTION>
             </SELECT> &nbsp;
             <button class="Small" onClick="rtvClasses()">Select Class</button>
          </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        <tr><td><br></td></tr>
        <TR>
          <TD align=right>Class:</TD>
          <TD align=left>
             <SELECT name="Class">
                <OPTION value="ALL">All Classes</OPTION>
             </SELECT>
          </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left>
             <SELECT name="Store" onChange="onStrChg(this)"></SELECT>&nbsp;
             <span id="spChain"><input name="Chain" type="checkbox" value="S">By Chain</span>
          </TD>
        </TR>
         <!-- --------------------------------------------------------------- -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=right >Report:</TD>
          <TD align=left>
             <input name="Report" type="radio" value="MTDTYLY" checked>TY vs. LY MTD &nbsp;&nbsp;
             <input name="Report" type="radio" value="YTDTYLY">TY vs. LY QTD & YTD<br>
             <input name="Report" type="radio" value="MTDTYPLAN">TY vs. Plan MTD &nbsp;&nbsp;
             <input name="Report" type="radio" value="YTDTYPLAN">TY vs. Plan QTD & YTD
          </TD>
        </TR>

        <!-- --------------------------------------------------------------- -->

        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=right >Date:</TD>
           <TD>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'selDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'selDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'selDate', 'WK')">w-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'selDate', 'DAY')">d-</button>
              <input name="selDate" type="text" size=10 maxlength=10 readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'selDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'selDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'selDate', 'WK')">w+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'selDate', 'YEAR')">y+</button>

              <a href="javascript:showCalendar(1, null, null, 580, 350, selDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- ---------------------- Prior Years Selection ------------------ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=right >Prior Years Selection:</TD>
          <TD align=left>
             <input name="LYSeL" type="radio" value="" >TY vs. LY &nbsp;&nbsp;
             <input name="LYSeL" type="radio" value="LY2" checked>TY vs. LLY &nbsp;&nbsp;
             <br><input name="LYSeL" type="radio" value="LY2A">TY vs. 2LY Avg. &nbsp;&nbsp;
             <input name="LYSeL" type="radio" value="LY3A">TY vs. 3LY Avg. &nbsp;&nbsp;
             <br><input name="LYSeL" type="radio" value="LY4A">TY vs. 4LY Avg. &nbsp;&nbsp;
             <input name="LYSeL" type="radio" value="LY5A">TY vs. 5LY Avg. &nbsp;&nbsp;
          </TD>
        </TR>
        <!-- -------------------------- Buttons ---------------------------- -->
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <button onClick="Validate()">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;

           </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}
  else {%>
<script>
   alert("Flash Sales Report is not available.")
   window.location.href = "index.jsp"
</script>
<%}%>




