<%@ page import="strempslsrep.EmpSlsPerform, java.util.*, rciutility.StoreSelect
, rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
   String [] sStore = request.getParameterValues("Str");
   String sFrom = request.getParameter("FrWeek");
   String sTo = request.getParameter("ToWeek");
   String [] sIncl = request.getParameterValues("Incl");
   String sNumOfEmp = request.getParameter("NumEmp");
   String sNumOfHrs = request.getParameter("NumHrs");
   String sActEmp = request.getParameter("ActEmp");
   String sRankSel = request.getParameter("RankSel");
   String sSort = request.getParameter("Sort");   
   String [] sSelTtl = request.getParameterValues("Ttl");

   if(sSort==null) { sSort="SCRSUMDESC"; }
   if(sRankSel==null) { sRankSel="N"; }
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EmpSlsPerform.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sUser = session.getAttribute("USER").toString();
  /* EmpSlsPerform(String [] sSelStr, String sFrom, String sTo, String [] sInclude
           , String sNumOfEmp, String sNumOfHrs, String sActEmp, String sRankSel, String sSort
           , String sUser)
*/
   EmpSlsPerform rank = new EmpSlsPerform(sStore, sFrom, sTo, sIncl, sNumOfEmp, sNumOfHrs
          , sActEmp, sRankSel, sSelTtl, sSort, sUser);
   int  iNumOfEmp = rank.getNumOfEmp();
   String sStrjsa = rank.cvtToJavaScriptArray(sStore);
   String sIncljsa = rank.cvtToJavaScriptArray(sIncl);
   String sTtljsa = rank.cvtToJavaScriptArray(sSelTtl);

   String sStrAllowed = null;
   StoreSelect strsel = new StoreSelect();
   String sAllStr = strsel.getStrNum();

   String [] sColHdr1 = new String[]{"Place", "Str", "Emp #", "Emp Name", "Hire Date", "Dept", "Title"
     , "&nbsp;", "Sls", "Score<br>Sls", "Hrs", "Trans", "Items"
     , "&nbsp;", "Sales<br>per Hour", "Score<br>Sls/Hrs"
     , "&nbsp;", "Item<br>per Trans", "Score<br>Itm/Trn"
     , "&nbsp;", "Score<br>Summary"
   };

   String [] sColHdr2 = new String[]{ "Sales<br>per Hour", "Item<br>per Trans"
     , "&nbsp;", "Sales<br>per Hour", "Item<br>per Trans"
     , "&nbsp;", "Sales<br>per Hour", "Item<br>per Trans"
   };

   rank.rtvDates();
   String sFrDate = rank.getFrDate();
   String sToDate = rank.getToDate();

   //String [] sColor = new String[]{"#ccffcc", "#efefef", "yellow", "pink"};
   String [] sColor = new String[]{"01", "02", "03", "04"};

   String [] sArrSort = new String[]{
    "STRDESC", "STRASCN"
   ,"EMPNDESC", "EMPNASCN"
   , "NAMEDESC","NAMEASCN"
   , "HIREDTDESC","HIREDTASCN"
   , "DPTDESC", "DPTASCN"
   , "TITLESC", "TITLEASCN"
   , "SLSDESC", "SLSASCN"
   , "SCRSLSDESC", "SCRSLSASCN"
   , "HRSDESC", "HRSASCN"
   , "TRANSDESC", "TRANSASCN"
   , "QTYDESC", "QTYASCN"
   , "SLSHRDESC", "SLSHRASCN"
   , "SCRSPHDESC", "SCRSPHASCN"
   , "ITMTRDESC", "ITMTRASCN"
   , "SCRIPTDESC", "SCRIPTASCN"
   , "SCRSUMDESC", "SCRSUMASCN"
   , "WSLSHRDESC", "WSLSHRASCN"
   , "WITMTRHRDESC", "WITMTRASCN"
   , "MSLSHRDESC", "MSLSHRASCN"
   , "MITMTRHRDESC", "MITMTRASCN"
   , "YSLSHRDESC", "YSLSHRASCN"
   , "YITMTRHRDESC", "YITMTRASCN"
   };
   String [] sArrSortNm = new String[]{
    "Store (highest to lowest)", "Store (lowest to highest)"
   ,"Employee Number (highest to lowest)","Employee Number (lowest to highest)"
   ,"Employee Name (highest to lowest)","Employee Name (lowest to highest)"
   ,"Hire Date (highest to lowest)","Hire Date (lowest to highest)"
   ,"Department (highest to lowest)","Department (lowest to highest)"
   ,"Title (highest to lowest)","Title (lowest to highest)"
   ,"Sales (highest to lowest)","Sales (lowest to highest)"
   ,"Sales Score (highest to lowest)", "Sales Score (lowest to highest)"
   ,"Working Hours (highest to lowest)", "Working Hours (lowest to highest)"
   ,"Number of Transactions (highest to lowest)", "Number of Transactions (lowest to highest)"
   ,"Number of Items (highest to lowest)","Number of Items (lowest to highest)"
   ,"Sales per Hours (highest to lowest)","Sales per Hours (lowest to highest)"
   ,"Score of Sales per Hours (highest to lowest)","Score of Sales per Hours (lowest to highest)"
   ,"Items per Transaction (highest to lowest)","Items per Transaction (lowest to highest)"
   ,"Score of Items per Transaction (highest to lowest)","Score of Items per Transaction (lowest to highest)"
   , "Score Summary (highest to lowest)", "Score Summary (lowest to highest)"
   ,"W-T-D Sales per Hours (highest to lowest)","W-T-D Sales per Hours (lowest to highest)"
   ,"W-T-D Items per Transaction (highest to lowest)","W-T-D Items per Transaction  (lowest to highest)"
   ,"Last Month Sales per Hour (highest to lowest)","Last Month Sales per Hour (lowest to highest)"
   ,"Last Items per Transaction (highest to lowest)","Last Items per Transaction (lowest to highest)"
   ,"Y-T-D Sales per Hours (highest to lowest)","Y-T-D Sales per Hours (lowest to highest)"
   ,"Y-T-D Items per Transaction (highest to lowest)","Y-T-D Items per Transaction (lowest to highest)"
   };
   String sSortCap = "";
   int iSort = -1;
   for(int i=0; i < sArrSort.length; i++)
   {
      if(sArrSort[i].equals(sSort))
      {
         iSort = i;
         sSortCap = sArrSortNm[i];
         break;
      }
   }

   String sSelEmpGrp = "";
   String coma = "";
   if(sIncl[0].equals("Y")){ sSelEmpGrp += coma + "Commission Employees"; coma = ", ";}
   if(sIncl[1].equals("Y")){ sSelEmpGrp += coma + "Salespersons"; coma = ", ";}
   if(sIncl[2].equals("Y")){ sSelEmpGrp += coma + "Hourly Non-Sales"; coma = ", ";}
   if(sIncl[3].equals("Y")){ sSelEmpGrp += coma + "Salaried Managers"; coma = ", ";}
   
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
   String [] sAllTtl = new String[vTitle.size()];  
   sAllTtl = vTitle.toArray(sAllTtl);
   String sAllTtlJsa = rank.cvtToJavaScriptArray(sAllTtl);
%>

<html>
<head>

<style>
  body {background:cornsilk;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  
  table.DataTable { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%
             ; border: grey solid 1px; font-size:10px }
  table.DataTable1 { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%; 
              background: LemonChiffon; border: grey solid 1px; font-size:10px }
  
  
  
  th.DataTable { background:#FFCC99;
                 padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable1 { background:#FFCC99; text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable2 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable3 { background:salmon; padding-top:3px; padding-bottom:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable4 { background:#FFCC99; text-align:center; font-family:Verdanda; font-size:10px }
  th.DataTable5 { background:salmon; text-align:center; font-family:Verdanda; font-size:10px }

  tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:LemonChiffon; font-family:Arial; font-size:10px }
  tr.DataTable3 { background:azure; font-family:Arial; font-size:10px }
  tr.DataTable4 { background:#cccfff; font-family:Arial; font-size:10px }


  tr.DataTable01 { background:#ccffcc; font-family:Arial; font-size:10px }
  tr.DataTable02 { background:#efefef; font-family:Arial; font-size:10px }
  tr.DataTable03 { background:yellow; font-family:Arial; font-size:10px }
  tr.DataTable04 { background:pink; font-family:Arial; font-size:10px }

  span.spnLegend01{ background:#ccffcc; font-family:Arial; font-size:12px }
  span.spnLegend02 { background:#efefef; font-family:Arial; font-size:12px }
  span.spnLegend03 { background:yellow; font-family:Arial; font-size:12px }
  span.spnLegend04 { background:pink; font-family:Arial; font-size:12px }

  tr.Divider{ background:darkred; font-size:1px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                 font-size:12px; font-weight:bold}

  td.TYCell { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

  div.dvSelect { position:absolute; background-attachment: scroll; width:350px; 
      background-color:LemonChiffon; z-index:10; text-align:center; font-size:12px}

  td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background: #016aab; color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  .Small { font-size:10px;}

</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var ArrStr = [<%=sAllStr%>];
var ArrSelStr = [<%=sStrjsa%>];
var ArrIncl = [<%=sIncljsa%>];
var FrWeek = "<%=sFrom%>";
var ToWeek = "<%=sTo%>";
var NumOfEmp = "<%=sNumOfEmp%>";
var NumOfHrs = "<%=sNumOfHrs%>";
var Sort = "<%=sSort%>";
var ActEmp = "<%=sActEmp%>";
var RankSel = "<%=sRankSel%>";
var ArrTtl = [<%=sTtljsa%>];
var ArrAllTtl = [<%=sAllTtlJsa%>];
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }	
	
  // set Weekly Selection Panel
  setSelectPanelShort();

  // fold historical data
  if(Sort.substring(0, 1) == "W" || Sort.substring( 0, 1) == "M" || Sort.substring(0, 1) == "Y"){showHist(true);}
  else{showHist(false);}
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = "Select Report Parameters";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvSelect.style.width = "250";}
   else if(isSafari){ document.all.dvSelect.style.width = "250";}
   else { document.all.dvSelect.style.width = "auto";}
   document.all.dvSelect.innerHTML=html;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelWk()

   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;

   // populate from week with to week if litteral range selected
   if(FrWeek == "WTD" || FrWeek == "MTD" || FrWeek == "YTD" || FrWeek == "PMN")
   {
      document.all.FrWeek.value = ToWeek;
      document.all.ToWeek.value = ToWeek;
   }
   else
   {
     document.all.FrWeek.value = FrWeek;
     document.all.ToWeek.value = ToWeek;
   }
   // setup date range
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(FrWeek == grp[i].value){ grp[i].checked = true; break; }
   }
   setDtRange();


   document.all.NumOfEmp.value = NumOfEmp;

   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
      for(var j=0; j < ArrStr.length; j++)
      {
         if(str[i].value == ArrSelStr[j]){ str[i].checked = true;}
         else{ str[i].checked == false; }
      }
   }
   
   var ttl = document.all.Ttl;
   for(var i=0; i < ttl.length; i++)
   {
      for(var j=0; j < ArrAllTtl.length; j++)
      {
         if(ttl[i].value == ArrTtl[j]){ ttl[i].checked = true;}
         else{ ttl[i].checked == false; }
      }
   }

   var incl = document.all.Incl;
   for(var i=0; i < incl.length; i++)
   {
      if(ArrIncl[i]=="Y"){ incl[i].checked = true;}
      else{ incl[i].checked == false; }
   }
   if(ArrIncl[ArrIncl.length - 1] == "Y") { document.all.Seas[0].checked = true; }
   else { document.all.Seas[1].checked = true; }
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table class='DataTable1' border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt1' colspan=3><u>Stores</u></td>"
     + "</tr>"
     + "<tr>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"

  for(var i=1, j=0; i < ArrStr.length; i++, j++)
  {
     if(j > 0 && j % 17 == 0){ panel += "<tr>"}
     panel += "<td class='Small' nowrap>"
          + "<input type='checkbox' class='Small' name='Str' value='" + ArrStr[i] + "'>" + ArrStr[i]
        + "</td>"
  }

  panel += "</table>"
          + "<button onclick='checkAll(true)' class='Small'>Check All</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(false)' class='Small'>Reset</button>"
       + "</td>"
     + "</tr>"

  panel += "<tr style='background:white'>"
     + "<td class='Prompt1' colspan=3><u>Titles</u></td>"
   + "</tr>"
   + "<tr style='background:white'>"
     + "<td class='Prompt1' colspan=3>"
        + "<table border=0>"
            + "<tr>"

for(var i=1, j=0; i < ArrAllTtl.length; i++, j++)
{
   if(j > 0 && j % 10 == 0){ panel += "<tr>"}
   panel += "<td class='Small' nowrap>"
        + "<input type='checkbox' class='Small' name='Ttl' value='" + ArrAllTtl[i] + "'>" + ArrAllTtl[i]
      + "</td>"
}

panel += "</table>"
        + "<button onclick='checkTtlAll(true)' class='Small'>Check All</button> &nbsp; &nbsp;"
        + "<button onclick='checkTtlAll(false)' class='Small'>Reset</button>"
     + "</td>"
   + "</tr>"
    
     

     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3>Date Selection:&nbsp</td>"
     + "</tr>"
     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3>"
           + "<input type='radio' name='DtGrp' value='WTD' onclick='setDtRange()'>W-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='MTD' onclick='setDtRange()'>M-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='YTD' onclick='setDtRange()'>Y-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='PMN' onclick='setDtRange()'>Prior Month &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='RANGE' onclick='setDtRange()' checked>Date Range"
        + "</td>"
      + "</tr>"

    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>From:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FrWeek&#34;)'>&#60;</button>"
          + "<input name='FrWeek' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;FrWeek&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 520, 200, document.all.FrWeek)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>To:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ToWeek&#34;)'>&#60;</button>"
          + "<input name='ToWeek' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;ToWeek&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 520, 300, document.all.ToWeek)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
     + "<tr id='trDt2'>"
       + "<td class='Prompt'  style='background:azure' colspan=3>Selected dates must be a Sunday.</td>"
     + "</tr>"

     // employee groups
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Employee Groups</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='checkbox' class='Small' name='Incl' value='Y'>Commission Employees</td>"
                  + "<td class='Small' nowrap><input type='checkbox' class='Small' name='Incl' value='Y'>Salespersons</td>"
                  + "<td class='Small' nowrap><input type='checkbox' class='Small' name='Incl' value='Y'>Hourly Non-Sales</td>"
              + "</tr>"
              + "<tr>"
                + "<td class='Small' nowrap><input type='checkbox' class='Small' name='Incl' value='Y'>Salaried Managers</td>"
              + "</tr>"
            + "</table>"
       + "</td>"
     + "</tr>"

     // seasonal
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Seasonal</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Seas' value='Y'>Include</td>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Seas' value='N'>Exclude</td>"
              + "</tr>"
            + "</table>"
       + "</td>"
     + "</tr>"

     + "<tr style='background:#cccfff'>"
       + "<td class='Prompt1' nowrap colspan=2>Number Of Employees:</td>"
       + "<td class='Prompt' nowrap><input class='Small' name='NumOfEmp' value='30' size=3 maxlength=3 checked>(Number or ALL)</td>"
     + "</tr>"
     + "<tr style='background:#cccfff'>"
       + "<td class='Prompt1' nowrap colspan=2>Number Of Hours:</td>"
       + "<td class='Prompt' nowrap><input class='Small' name='NumOfHrs' value='10' size=4 maxlength=4></td>"
     + "</tr>"
     + "<tr style='background:#cccfff'>"
       + "<td  class='Prompt1' nowrap colspan=2>Rank based on selection criteria:</td>"
          + "<td  class='Prompt' nowrap colspan=2><input class='Small' type='checkbox' name='RankSel' value='Y'></td>"
     + "</tr>"

     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Active/Inactive Employees</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc; text-align:center;'>"
       + "<td class='Small' colspan=3><input type='radio' class='Small' name='Active' value='1' checked>Active &nbsp; &nbsp; "
       + "<input type='radio' class='Small' name='Active' value='2'>Inactive(termed) &nbsp; &nbsp; "
       + "<input type='radio' class='Small' name='Active' value='3'>Any</td>"
     + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// check all stores
//==============================================================================
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
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
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
         document.all.trDt2[0].style.display="none";
         document.all.trDt2[1].style.display="none";
         document.all.trDt2[2].style.display="none";
         break;
      }
      else if(grp[i].checked)
      {
         document.all.trDt2[0].style.display="block";
         document.all.trDt2[1].style.display="block";
         document.all.trDt2[2].style.display="block";
         break;
      }
   }
}
//==============================================================================
// Validate entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";

   // get selected stores
   var str = document.all.Str;
   var selstr = new Array();
   var numstr = 0
   for(var i=0; i < str.length; i++)
   {
     if(str[i].checked){ selstr[numstr] = str[i].value; numstr++;}
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

   var ranksel = "N";
   if (document.all.RankSel.checked){ ranksel = "Y"; }

   var numemp = document.all.NumOfEmp.value.trim().toUpperCase()
   if(numemp != "ALL")
   {
      if(isNaN(numemp) || eval(numemp) < 0){ error=true; msg+="\nThe Number of Employees is invalid."; }
   }

   var numhrs = document.all.NumOfHrs.value.trim().toUpperCase()
   if(isNaN(numhrs) || eval(numhrs) <= 0){ error=true; msg+="\nThe Number of Hours is invalid."; }

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrWeek, selToWeek, selincl, numemp, numhrs, selact, ranksel, selttl) }
}
//==============================================================================
// change action on submit
//==============================================================================
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
   
   for(var i=0; i < selttl.length; i++)  { url += "&Ttl=" + selttl[i]; }

   url += "&NumEmp=" + numemp;
   url += "&NumHrs=" + numhrs;
   url += "&ActEmp=" + selact;
   url += "&RankSel=" + ranksel;

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// show another selected week
//==============================================================================
function resort(sort)
{
   var url = "EmpSlsPerform.jsp?"
    + "FrWeek=<%=sFrom%>"
    + "&ToWeek=<%=sTo%>"
    + "&NumEmp=<%=sNumOfEmp%>"
    + "&NumHrs=<%=sNumOfHrs%>"
    ;
   for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }
   for(var i=0; i < ArrIncl.length; i++) { url += "&Incl=" + ArrIncl[i]; }
   for(var i=0; i < ArrTtl.length; i++) { url += "&Ttl=" + ArrTtl[i]; }
   

   url += "&Sort=" + sort
        + "&ActEmp=" + ActEmp
        + "&RankSel=" + RankSel


   //alert(url)
   window.location.href=url;

   /*FrWeek=12/30/2012
     ToWeek=12/30/2012
     Str=3&Str=4&Str=5&Str=8&Str=10&Str=11&Str=20&Str=28&Str=29&Str=30&Str=35&Str=40
     Str=42&Str=45&Str=46&Str=50&Str=61&Str=63&Str=64&Str=66&Str=68&Str=75&Str=82&Str=86
     Str=87&Str=88&Str=90&Str=92&Str=93&Str=96&Str=98
     &Incl=Y&Incl=N&Incl=N&Incl=N
     NumEmp=30
     NumHrs=10
   */
}
//==============================================================================
// fold/unfold history
//==============================================================================
function showHist(show)
{
   var disp = "block";
   var disp1 = "none";
   if(!show){ disp= "none"; disp1 = "block"; }

   document.all.lnkUnfold.style.display = disp1;
   var col = document.all.colHist;
   for(var i=0; i < col.length; i++)
   {
      col[i].style.display = disp;
   }
}
</SCRIPT>


</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<body onload="bodyload()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->
 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Employee Sales Performance Sort Report
      <br>Store:
       <%String sComa="";%>
       <%for(int i=0; i < sStore.length; i++){%><%=sComa + sStore[i]%><%sComa=", ";%><%}%>
      <br>
          <%if(sFrom.equals("WTD")){%>Date Range: Week-To-Date<%}
            else if(sFrom.equals("MTD")){%>Date Range: Month-To-Date (<%=sFrDate%> - <%=sToDate%>)<%}
            else if(sFrom.equals("YTD")){%>Date Range: Year-To-Date (<%=sFrDate%> - <%=sToDate%>)<%}
            else if(sFrom.equals("PMN")){%>Date Range: Prior Month (<%=sFrDate%> - <%=sToDate%>)<%}
            else {%>Weekending dates: <%=sFrDate%> - <%=sToDate%><%}%>
      <br>Employee Groups: <%=sSelEmpGrp%>
      <br>Minimum number of hours <%=sNumOfHrs%>
      <br>Sort by <%=sSortCap%>
     <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="EmpSlsPerformSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      </td>
   </tr>
   <tr>
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" border=1 cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan="3">Place</th>
      <th class="DataTable" rowspan="2">Str</th>
      <th class="DataTable" rowspan="2">Emp #</th>
      <th class="DataTable" rowspan="2">Emp Name</th>
      <th class="DataTable" rowspan="2">Hire Date</th>
      <th class="DataTable" rowspan="2">Dept</th>
      <th class="DataTable" rowspan="2">Title</th>
      <th class="DataTable2" rowspan="4">&nbsp;</th>

      <th class="DataTable" rowspan="2">Sls</th>
      <th class="DataTable" rowspan="2">Score<br>Sls</th>
      <th class="DataTable" rowspan="2">Hrs</th>
      <th class="DataTable" rowspan="2">Trans</th>
      <th class="DataTable" rowspan="2">Items</th>
      <th class="DataTable2" rowspan="4">&nbsp;</th>
      <th class="DataTable" rowspan="2">Sales<br>per Hour</th>
      <th class="DataTable" rowspan="2">Score<br>Sls/Hrs</th>
      <th class="DataTable2" rowspan="4">&nbsp;</th>
      <th class="DataTable" rowspan="2">Item<br>per Trans</th>
      <th class="DataTable" rowspan="2">Score<br>Itm/Trn</th>
      <th class="DataTable2" rowspan="4">&nbsp;</th>
      <th class="DataTable" rowspan="2">Score<br>Summary</th>
      <th class="DataTable2" rowspan="4">&nbsp;</th>
      <!--th class="DataTable" rowspan="2">Sales<br>per Trans</th-->

      <th class="DataTable3" rowspan="4"><a id="lnkUnfold" href="javascript: showHist(true)">H<br>i<br>s<br>t</a>&nbsp;</th>
      <th class="DataTable" id="colHist" colspan=2>W-T-D <a href="javascript: showHist(false)">(fold)</a></th>
      <th class="DataTable2" id="colHist" rowspan="4">&nbsp;</th>
      <th class="DataTable" id="colHist" colspan=2>Last Month</th>
      <th class="DataTable2" id="colHist" rowspan="4">&nbsp;</th>
      <th class="DataTable" id="colHist" colspan=2>Y-T-D</th>
      <th class="DataTable" rowspan="3">Place</th>
    </tr>

    <tr>
      <th class="DataTable" id="colHist">Sales<br>per Hour</th>
      <th class="DataTable" id="colHist">Item<br>per Trans</th>

      <th class="DataTable" id="colHist">Sales<br>per Hour</th>
      <th class="DataTable" id="colHist">Item<br>per Trans</th>

      <th class="DataTable" id="colHist">Sales<br>per Hour</th>
      <th class="DataTable" id="colHist">Item<br>per Trans</th>
    </tr>

    <tr>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('STRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('EMPNDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('EMPNASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('NAMEDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('NAMEASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HIREDTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HIREDTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('DPTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('DPTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('TITLEDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('TITLEASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('SLSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('SCRSLSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SCRSLSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('HRSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('TRANSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('TRANSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('QTYDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('QTYASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('SLSHRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLSHRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('SCRSPHDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SCRSPHASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('ITMTRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('ITMTRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('SCRIPTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SCRIPTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('SCRSUMDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SCRSUMASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <!--th class="DataTable">
        <a href="javascript: resort('SLSTRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLSTRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th-->

      <!-- ============ History =============== -->
      <th class="DataTable" id="colHist">
        <a href="javascript: resort('WSLSHRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('WSLSHRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" id="colHist">
        <a href="javascript: resort('WITMTRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('WITMTRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable" id="colHist">
        <a href="javascript: resort('MSLSHRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('MSLSHRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" id="colHist">
        <a href="javascript: resort('MITMTRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('MITMTRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable" id="colHist">
        <a href="javascript: resort('YSLSHRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('YSLSHRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" id="colHist">
        <a href="javascript: resort('YITMTRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('YITMTRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>


    </tr>
    <tr>
     <%for(int i=1; i < 17; i++){%><th class="DataTable4"><%=i%></th><%}%>
     <%for(int i=17; i < 23; i++){%><th class="DataTable4" id="colHist"><%=i%></th><%}%>
     <th class="DataTable4">23</th>
     <th class="DataTable4">24</th>
    </tr>


<!------------------------------- Detail Data --------------------------------->
     <%for(int i=0; i < iNumOfEmp; i++)
     {
       rank.setEmpSlsPerformance();
       String sStr = rank.getStr();
       String sEmp = rank.getEmp();
       String sName = rank.getName();
       String sTitle = rank.getTitle();
       String sDept = rank.getDept();
       String sSls = rank.getSls();
       String sHrs = rank.getHrs();
       String sQty = rank.getQty();
       String sSlsHr = rank.getSlsHr();
       String sTrans = rank.getTrans();
       String sItmTr = rank.getItmTr();
       String sScrSlsHr = rank.getScrSlsHr();
       String sScrItmTr = rank.getScrItmTr();
       String sScrSls = rank.getScrSls();
       String sScrSum = rank.getScrSum();
       String sHorS = rank.getHorS();
       String sSCom = rank.getSCom();
       String sSlsTr = rank.getSlsTr();

       String sWtdSls = rank.getWtdSls();
       String sWtdHrs = rank.getWtdHrs();
       String sWtdQty = rank.getWtdQty();
       String sWtdTrans = rank.getWtdTrans();
       String sWtdSlsHr = rank.getWtdSlsHr();
       String sWtdItmTr = rank.getWtdItmTr();
       String sWtdSlsTr = rank.getWtdSlsTr();

       String sMtdSls = rank.getMtdSls();
       String sMtdHrs = rank.getMtdHrs();
       String sMtdQty = rank.getMtdQty();
       String sMtdTrans = rank.getMtdTrans();
       String sMtdSlsHr = rank.getMtdSlsHr();
       String sMtdItmTr = rank.getMtdItmTr();
       String sMtdSlsTr = rank.getMtdSlsTr();

       String sYtdSls = rank.getYtdSls();
       String sYtdHrs = rank.getYtdHrs();
       String sYtdQty = rank.getYtdQty();
       String sYtdTrans = rank.getYtdTrans();
       String sYtdSlsHr = rank.getYtdSlsHr();
       String sYtdItmTr = rank.getYtdItmTr();
       String sYtdSlsTr = rank.getYtdSlsTr();
       int iPlace = rank.getPlace();
       String sHireDt = rank.getHireDt();
       
       int iClr = 0;
       double dPrc = (double) (iPlace)/iNumOfEmp * 100;
       if (dPrc > 20 && dPrc <= 80){ iClr = 1; }
       else if (dPrc > 80 && dPrc <= 90){ iClr = 2; }
       else if (dPrc > 90){ iClr = 3;}

     %>
       <%if(i > 0 && i%15==0){%>
         <tr>
           <%for(int j=0; j < sColHdr1.length; j++){%><th class="DataTable4"><%=sColHdr1[j]%></th><%}%>
           <th class="DataTable4">&nbsp;</th>
           <th class="DataTable5">&nbsp;</th>
           <%for(int j=0; j < sColHdr2.length; j++){%><th class="DataTable4" id="colHist"><%=sColHdr2[j]%></th><%}%>
           <th class="DataTable4">Place</th>
         </tr>
       <%}%>

         <tr class="DataTable<%=sColor[iClr]%>">
           <td class="DataTable" nowrap><%=iPlace%></td>
           <td class="DataTable" nowrap><%=sStr%></td>
           <td class="DataTable" nowrap><%=sEmp%></td>
           <td class="DataTable1" nowrap><%=sName%></td>
           <td class="DataTable1" nowrap><%=sHireDt%></td>
           <td class="DataTable1" nowrap><%=sDept%></td>
           <td class="DataTable1" nowrap><%=sTitle%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSls%></td>
           <td class="DataTable" nowrap><%=sScrSls%></td>
           <td class="DataTable" nowrap><%=sHrs%></td>
           <td class="DataTable" nowrap><%=sTrans%></td>
           <td class="DataTable" nowrap><%=sQty%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSlsHr%></td>
           <td class="DataTable" nowrap><%=sScrSlsHr%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap><%=sItmTr%></td>
           <td class="DataTable" nowrap><%=sScrItmTr%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap><%=sScrSum%></td>
           <th class="DataTable2">&nbsp;</th>
           <!--td class="DataTable" nowrap>$<%=sSlsTr%></td-->

           <th class="DataTable3">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sWtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sWtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sMtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sMtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sYtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sYtdItmTr%></td>
           <td class="DataTable" nowrap><%=iPlace++%></td>
        </tr>
     <%}%>
<!-------------------------- end of Detail Totals ----------------------------->
<!-------------------------- Report Total Data -------------------------------->
       <%
       rank.setRepTot();
       String sName = rank.getName();
       String sSls = rank.getSls();
       String sHrs = rank.getHrs();
       String sQty = rank.getQty();
       String sSlsHr = rank.getSlsHr();
       String sTrans = rank.getTrans();
       String sItmTr = rank.getItmTr();
       String sSlsTr = rank.getSlsTr();


       String sWtdSls = rank.getWtdSls();
       String sWtdHrs = rank.getWtdHrs();
       String sWtdQty = rank.getWtdQty();
       String sWtdTrans = rank.getWtdTrans();
       String sWtdSlsHr = rank.getWtdSlsHr();
       String sWtdItmTr = rank.getWtdItmTr();
       String sWtdSlsTr = rank.getWtdSlsTr();

       String sMtdSls = rank.getMtdSls();
       String sMtdHrs = rank.getMtdHrs();
       String sMtdQty = rank.getMtdQty();
       String sMtdTrans = rank.getMtdTrans();
       String sMtdSlsHr = rank.getMtdSlsHr();
       String sMtdItmTr = rank.getMtdItmTr();
       String sMtdSlsTr = rank.getMtdSlsTr();

       String sYtdSls = rank.getYtdSls();
       String sYtdHrs = rank.getYtdHrs();
       String sYtdQty = rank.getYtdQty();
       String sYtdTrans = rank.getYtdTrans();
       String sYtdSlsHr = rank.getYtdSlsHr();
       String sYtdItmTr = rank.getYtdItmTr();
       String sYtdSlsTr = rank.getYtdSlsTr();
     %>
        <tr class="Divider"><td colspan=30>&nbsp;</td></tr>
         <tr class="DataTable1">
           <td class="DataTable2"colspan=7 nowrap><%=sName%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSls%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <td class="DataTable" nowrap><%=sHrs%></td>
           <td class="DataTable" nowrap><%=sTrans%></td>
           <td class="DataTable" nowrap><%=sQty%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSlsHr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap><%=sItmTr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <!--td class="DataTable" nowrap>$<%=sSlsTr%></td-->

           <th class="DataTable3">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sWtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sWtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sMtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sMtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sYtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sYtdItmTr%></td>

           <td class="DataTable" nowrap>&nbsp;</td>
        </tr>
  <!-------------------------- company Total Data ----------------------------->
       <%
       rank.setCmpTot();
       sName = rank.getName();
       sSls = rank.getSls();
       sHrs = rank.getHrs();
       sQty = rank.getQty();
       sSlsHr = rank.getSlsHr();
       sTrans = rank.getTrans();
       sItmTr = rank.getItmTr();
       sSlsTr = rank.getSlsTr();

       sWtdSls = rank.getWtdSls();
       sWtdHrs = rank.getWtdHrs();
       sWtdQty = rank.getWtdQty();
       sWtdTrans = rank.getWtdTrans();
       sWtdSlsHr = rank.getWtdSlsHr();
       sWtdItmTr = rank.getWtdItmTr();
       sWtdSlsTr = rank.getWtdSlsTr();

       sMtdSls = rank.getMtdSls();
       sMtdHrs = rank.getMtdHrs();
       sMtdQty = rank.getMtdQty();
       sMtdTrans = rank.getMtdTrans();
       sMtdSlsHr = rank.getMtdSlsHr();
       sMtdItmTr = rank.getMtdItmTr();
       sMtdSlsTr = rank.getMtdSlsTr();

       sYtdSls = rank.getYtdSls();
       sYtdHrs = rank.getYtdHrs();
       sYtdQty = rank.getYtdQty();
       sYtdTrans = rank.getYtdTrans();
       sYtdSlsHr = rank.getYtdSlsHr();
       sYtdItmTr = rank.getYtdItmTr();
       sYtdSlsTr = rank.getYtdSlsTr();
     %>
         <tr class="Divider"><td colspan=30>&nbsp;</td></tr>
         <tr class="Divider"><td colspan=30>&nbsp;</td></tr>

         <tr class="DataTable2">
           <td class="DataTable2"colspan=7 nowrap><%=sName%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSls%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <td class="DataTable" nowrap><%=sHrs%></td>
           <td class="DataTable" nowrap><%=sTrans%></td>
           <td class="DataTable" nowrap><%=sQty%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSlsHr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap><%=sItmTr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <!--td class="DataTable" nowrap>$<%=sSlsTr%></td-->

           <th class="DataTable3">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sWtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sWtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sMtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sMtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sYtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sYtdItmTr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
        </tr>
<!-------------------------- end of Company Totals ---------------------------->
<!-------------------------- Region Totals ------------------------------------>
         <tr class="Divider"><td colspan=30>&nbsp;</td></tr>
<%
     for(int i=0; i < 3; i++ )
     {
       rank.setRegTot(i+1);
       sName = rank.getName();
       sSls = rank.getSls();
       sHrs = rank.getHrs();
       sQty = rank.getQty();
       sSlsHr = rank.getSlsHr();
       sTrans = rank.getTrans();
       sItmTr = rank.getItmTr();
       sSlsTr = rank.getSlsTr();

       sWtdSls = rank.getWtdSls();
       sWtdHrs = rank.getWtdHrs();
       sWtdQty = rank.getWtdQty();
       sWtdTrans = rank.getWtdTrans();
       sWtdSlsHr = rank.getWtdSlsHr();
       sWtdItmTr = rank.getWtdItmTr();
       sWtdSlsTr = rank.getWtdSlsTr();

       sMtdSls = rank.getMtdSls();
       sMtdHrs = rank.getMtdHrs();
       sMtdQty = rank.getMtdQty();
       sMtdTrans = rank.getMtdTrans();
       sMtdSlsHr = rank.getMtdSlsHr();
       sMtdItmTr = rank.getMtdItmTr();
       sMtdSlsTr = rank.getMtdSlsTr();

       sYtdSls = rank.getYtdSls();
       sYtdHrs = rank.getYtdHrs();
       sYtdQty = rank.getYtdQty();
       sYtdTrans = rank.getYtdTrans();
       sYtdSlsHr = rank.getYtdSlsHr();
       sYtdItmTr = rank.getYtdItmTr();
       sYtdSlsTr = rank.getYtdSlsTr();
     %>
         <tr class="Divider"><td colspan=30>&nbsp;</td></tr>
         <tr class="DataTable3">
           <td class="DataTable2"colspan=7 nowrap><%=sName%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSls%></td> 
           <td class="DataTable" nowrap>&nbsp;</td>
           <td class="DataTable" nowrap><%=sHrs%></td>
           <td class="DataTable" nowrap><%=sTrans%></td>
           <td class="DataTable" nowrap><%=sQty%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSlsHr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap><%=sItmTr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <!--td class="DataTable" nowrap>$<%=sSlsTr%></td-->

           <th class="DataTable3">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sWtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sWtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sMtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sMtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sYtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sYtdItmTr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
        </tr>
      <%}%>
<!-------------------------- end of Region Totals ----------------------------->
<!-------------------------- Group Totals ------------------------------------>
     <tr class="Divider"><td colspan=30>&nbsp;</td></tr>
<%
     for(int i=0; i < 4; i++ )
     {
       rank.setGrpTot(i+1);
       sName = rank.getName();
       sSls = rank.getSls();
       sHrs = rank.getHrs();
       sQty = rank.getQty();
       sSlsHr = rank.getSlsHr();
       sTrans = rank.getTrans();
       sItmTr = rank.getItmTr();
       sSlsTr = rank.getSlsTr();

       sWtdSls = rank.getWtdSls();
       sWtdHrs = rank.getWtdHrs();
       sWtdQty = rank.getWtdQty();
       sWtdTrans = rank.getWtdTrans();
       sWtdSlsHr = rank.getWtdSlsHr();
       sWtdItmTr = rank.getWtdItmTr();
       sWtdSlsTr = rank.getWtdSlsTr();

       sMtdSls = rank.getMtdSls();
       sMtdHrs = rank.getMtdHrs();
       sMtdQty = rank.getMtdQty();
       sMtdTrans = rank.getMtdTrans();
       sMtdSlsHr = rank.getMtdSlsHr();
       sMtdItmTr = rank.getMtdItmTr();
       sMtdSlsTr = rank.getMtdSlsTr();

       sYtdSls = rank.getYtdSls();
       sYtdHrs = rank.getYtdHrs();
       sYtdQty = rank.getYtdQty();
       sYtdTrans = rank.getYtdTrans();
       sYtdSlsHr = rank.getYtdSlsHr();
       sYtdItmTr = rank.getYtdItmTr();
       sYtdSlsTr = rank.getYtdSlsTr();
     %>
         <tr class="Divider"><td colspan=30>&nbsp;</td></tr>
         <tr class="DataTable4">
           <td class="DataTable2"colspan=7 nowrap><%=sName%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSls%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <td class="DataTable" nowrap><%=sHrs%></td>
           <td class="DataTable" nowrap><%=sTrans%></td>
           <td class="DataTable" nowrap><%=sQty%></td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>$<%=sSlsHr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap><%=sItmTr%></td>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <td class="DataTable" nowrap>&nbsp;</td>
           <th class="DataTable2">&nbsp;</th>
           <!--td class="DataTable" nowrap>$<%=sSlsTr%></td-->

           <th class="DataTable3">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sWtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sWtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sMtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sMtdItmTr%></td>
           <th class="DataTable2"  id="colHist">&nbsp;</th>
           <td class="DataTable" id="colHist" nowrap>$<%=sYtdSlsHr%></td>
           <td class="DataTable" id="colHist" nowrap><%=sYtdItmTr%></td>

           <td class="DataTable" nowrap>&nbsp;</td>
        </tr>
      <%}%>
<!-------------------------- end of Group Totals ----------------------------->
 </table>
 <p style="text-align:left;"><span class="spnLegend<%=sColor[0]%>"> &nbsp; &nbsp; &nbsp; &nbsp; </span> - Top 10% of employees.
 <br><span class="spnLegend<%=sColor[2]%>"> &nbsp; &nbsp; &nbsp; &nbsp; </span> - Bottom 80% - 90% of employees.
 <br><span class="spnLegend<%=sColor[3]%>"> &nbsp; &nbsp; &nbsp; &nbsp; </span> - Bottom 90% - 100% of employees.
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%rank.disconnect();
  rank = null;
%>
<%}%>