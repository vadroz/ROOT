<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MarkdownInqSel.jsp&APPL=ALL");
   }
   else
   {

      ClassSelect divsel = null;
      StoreSelect strsel = null;

      String sDiv = null;
      String sDivName = null;
      String sDpt = null;
      String sDptName = null;
      String sDptGroup = null;
      String sCls = null;
      String sClsName = null;

      divsel = new ClassSelect();
      sDiv = divsel.getDivNum();
      sDivName = divsel.getDivName();
      sDpt = divsel.getDptNum();
      sDptName = divsel.getDptName();
      sDptGroup = divsel.getDptGroup();

      strsel = new StoreSelect(7);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();
      String sStrJsa = strsel.getStrNum();
      String sStrNameJsa = strsel.getStrName();   

      //============================================
      // get current fiscal year
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

<title>Gender Sales Productivity</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];

var blockRow = "table-row";
var blockCell = "table-cell";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ blockRow = "block"; blockCell = "block"; }
	
  	doDivSelect(null);
  	showWkend()
  	doMonthSelect()
  	showDates()
  	setStrLst();
}
//==============================================================================
// set store selection
//==============================================================================
function  setStrLst()
{
	for(var i=0; i < ArrStr.length; i++)
	{
		document.all.SelStr.options[i] = new Option(ArrStr[i] + " - " + ArrStrNm[i], ArrStr[i]);
	}
}
//==============================================================================
// show date selection
//==============================================================================
function showDates()
{
   var rangeType = "";
   for(var i=0; i < document.all.DatLvl.length; i++)
   {
      if ( document.all.DatLvl[i].checked ) { rangeType = document.all.DatLvl[i].value; }
   }

   if(rangeType == "V")
   {
      document.all.trWeek.style.display = blockRow;
      document.all.trYrSel.style.display = "none"
      document.all.trMonSel.style.display = "none"
   }
   if(rangeType == "M")
   {
      document.all.trWeek.style.display = "none"
      document.all.trYrSel.style.display = blockRow;
      document.all.trMonSel.style.display = blockRow;
   }
   if(rangeType == "Y")
   {
      document.all.trWeek.style.display = "none"
      document.all.trYrSel.style.display = blockRow;
      document.all.trMonSel.style.display = "none"
   }
}
//==============================================================================
// populate date selection
//==============================================================================
function showWkend()
{
    var date = new Date(new Date() - 86400000);

    // from sales date
    var day = 0;
    for(var i=0; i < 7; i++)
    {
       day = date.getDay();
       if (date.getDay()==0){ break; }
       date = new Date(date.getTime() - 86400000);
    }
    document.all.Wkend2.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
    
    date = new Date(date.getTime() - 6 * 86400000);
    
    document.all.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doMonthSelect()
{
  var year = CurYear - 2;
  for (var i=0; i < 3; i++)
  {
     document.all.Year.options[i] = new Option(year, year);
     if (year == CurYear )
     {
        document.all.Year.selectedIndex = i;
     }
     year++;
  }

  var mon = ["April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"]

  for (var i=0; i < mon.length; i++)
  {
     document.all.Month.options[i] = new Option(mon[i], (i+1));
     if (i == CurMonth )
     {
        document.all.Month.selectedIndex = i;
     }

  }
}

//==============================================================================
// populate class selection
//==============================================================================
function doClsSelect() {
    var df = document.all;
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];
    document.all.DivArg.value = 0;

    //  clear current classes
        for (idx = df.CLASS.length; idx >= 0; idx--)
            df.CLASS.options[idx] = null;
   //  populate the class list
        for (idx = 0; idx < classes.length; idx++)
        {
                df.CLASS.options[idx] = new Option(clsNames[idx], classes[idx]);
        }
}

//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id)
{
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];
    var chg = id;

    var allowed;

    if (id == null)
    {
        //  populate the division list
        for (idx = 0; idx < divisions.length; idx++)
        {
           df.selDiv.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        }
        id = 0
        if (document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id].split(":");

    //  clear current depts
    for (idx = df.selDpt.length; idx >= 0; idx--)
    {
       df.selDpt.options[idx] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (idx = 0; idx < depts.length; idx++)
            df.selDpt.options[idx] = new Option(deptNames[idx],depts[idx]);
    }
    //  else display the desired depts
    else
    {
       for (idx = 0; idx < allowed.length; idx++)
           df.selDpt.options[idx] = new Option(deptNames[allowed[idx]], depts[allowed[idx]]);
    }

    if(chg!=null)
    {
      showDptSelect(0);
      showClsSelect(0);
    }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showDptSelect(id)
{
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   // clear class
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.selectedIndex=0;
   document.all.selCls.size=1
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   document.all.ClsName.value = document.all.selCls.options[id].text
   document.all.Cls.value = document.all.selCls.options[id].value
}
//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Div.value
   var dpt = document.all.Dpt.value

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
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.selCls.options[i] = new Option(clsName[i], cls[i]);
   }
   document.all.selCls.size=5
}

//==============================================================================
// change Summary option depend on selection
//==============================================================================
function chgSumOpt(clear)
{
  var sumopt = document.all.SumOpt;
  var max = sumopt.length;

  // clear all option when NONE selected
  if(clear)
  {
     for(var i=0; i < max; i++ )
     {
        if(i < max-1) { sumopt[i].checked = false; }
     }
  }
  else
  {
     sumopt[sumopt.length - 1].checked = false;
  }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  var div = document.all.Div.value.trim();
  var divnm = document.all.DivName.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var dptnm = document.all.DptName.value.trim();
  var cls = document.all.Cls.value.trim();
  var clsnm = document.all.ClsName.value.trim();
  //var ven = document.all.Ven.value.trim();
  //var vennm = document.all.VenName.value.trim();

  var stores = document.all.SelStr;
  var str = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;
  
  // sales date
  var wkend = document.all.Wkend.value;
  var wkend2 = document.all.Wkend2.value;
  var year = document.all.Year.value;
  var month = document.all.Month.value;
  var datelvl = document.all.DatLvl[0].value;
  for(var i=0; i < document.all.DatLvl.length; i++)
  {
     if(document.all.DatLvl[i].checked) { datelvl = document.all.DatLvl[i].value; }
  }
  
  if(datelvl == "V"){ year = "ALL"; month = "ALL"; }
  else if(datelvl == "M"){ wkend = "ALL"; wkend2 = "ALL"; }
  else if(datelvl == "Y"){ wkend = "ALL"; wkend2 = "ALL"; month = "ALL"; }
  

  // get Level break options
  var bystrfld = document.all.BYSTR;
  var level = "Str";
  for(var i=0; i < bystrfld.length; i++ )
  {
     if(bystrfld[i].checked && bystrfld[i].value == "N") 
     {     	 
    	 if(cls !="ALL") { level = "SKU"; }
    	 else if(dpt !="ALL" && cls=="ALL") { level = "Cls"; }
    	 else if(div != "ALL" && dpt =="ALL" && cls=="ALL") { level = "Dpt"; }
    	 else if(div == "ALL" && dpt =="ALL" && cls=="ALL") { level = "Div"; }
    	 break;
     }
  }

  if (error) alert(msg);
  else{ sbmSlsRep(div, dpt, cls, str, wkend, wkend2, year, month, datelvl, level); }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(div, dpt, cls, str, wkend, wkend2, year, month, datelvl, level)
{
  var url = null;
  url = "FlashSlsGender.jsp?"
  url += "Str=" + str
      + "&Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      //+ "&Ven=" + ven
      //+ "&VenName=" + vennm

  url += "&FrDate=" + wkend;
  url += "&ToDate=" + wkend2;
  url += "&Year=" + year;
  url += "&Month=" + month;
  url += "&Level=" + level;
  url += "&DatLvl=None";
  
  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check/uncheck All Store
//==============================================================================
function chkAllStr(chk)
{
   var str = document.all.STORE;
   for(var i=0; i < <%=iNumOfStr%> ; i++) { str[i].checked = chk; }
}

//==============================================================================
// retreive vendors
//==============================================================================
function rtvVendors()
{
   if (Vendor==null)
   {
      var url = "RetreiveVendorList.jsp"
      //alert(url);
      //window.location.href = url;
      window.frame1.location = url;
   }
   else { document.all.dvVendor.style.visibility = "visible"; }
}
//==============================================================================
// popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
   Vendor = ven;
   VenName = venName;
   var html = "<input name='FndVen' class='Small' size=5 maxlength=5>&nbsp;"
     + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
     + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;"
     + "<button onclick='document.all.dvVendor.style.visibility=&#34;hidden&#34;' class='Small'>Close</button><br>"
   var dummy = "<table>"

   html += "<div id='dvInt' class='dvInternal'>"
         + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
   for(var i=0; i < ven.length; i++)
   {
     html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
   }
   html += "</table></div>"
   var pos = objPosition(document.all.VenName)

   document.all.dvVendor.innerHTML = html;
   document.all.dvVendor.style.pixelLeft= pos[0];
   document.all.dvVendor.style.pixelTop= pos[1] + 25;
   document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
// find selected vendor
//==============================================================================
function findSelVen()
{
  var ven = document.all.FndVen.value.trim().toUpperCase();
  var vennm = document.all.FndVenName.value.trim().toUpperCase();
  var dvVen = document.all.dvVendor
  var fnd = false;

  // zeroed last search
  if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
  LastVen = vennm;

  for(var i=LastTr+1; i < Vendor.length; i++)
  {
     if(ven != "" && ven != " " && ven == Vendor[i]) {  fnd = true; LastTr=i; break}
     else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break}
     document.all.trVen[i].style.color="black";
  }

  // if found set value and scroll div to the found record
  if(fnd)
  {
     var pos = document.all.trVen[LastTr].offsetTop;
     document.all.trVen[LastTr].style.color="red";
     dvInt.scrollTop=pos;
  }
  else { LastTr=-1; }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
   document.all.VenName.value = vennm
   document.all.Ven.value = ven
}

//==============================================================================
// find object postition
//==============================================================================
function objPosition(obj)
{
   var pos = new Array(2);
   pos[0] = 0;
   pos[1] = 0;
   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  date.setHours(18);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="WK") { date = new Date(new Date(date) - 86400000 * 7 ); }
  else if(direction == "UP" && ymd=="WK") { date = new Date(new Date(date) - -86400000 * 7 ); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<TABLE class="tbl05">
  <TBODY>

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Gender Sales Productivity - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD>Division:</TD>
          <TD>
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT>
          </TD>
        <!-- ======================= Department ============================ -->
          <TD class="Cell">Department:</TD>
          <TD class="Cell1">
             <input class="Small" name="DptName" size=50 value="All Departments" readonly>
             <input class="Small" name="Dpt" type="hidden" value="ALL"><br>
             <SELECT class="Small" name=selDpt onchange="showDptSelect(this.selectedIndex);"  size=5>
                <OPTION value="ALL">All Departments</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
            <TD class="Cell" >&nbsp;</TD>
         </TR>
        <!-- ========================== Class ============================== -->
        <TR>
            <TD class="Cell" >Class:</TD>
            <TD class="Cell1">
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" value="Select Class" name=SUBMIT onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="selCls" class="Small" onchange="showClsSelect(this.selectedIndex);">
                 <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>

        <!-- ========================== Vendor ============================== -->
            <!-- TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap>
              <input class="Small" name="VenName" size=50 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button><br>
            </TD -->
        </TR>

        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell">Store:</TD>
          <TD class="Cell1" colspan=3>
             <select class="Small"  name="SelStr" id="SelStr"></select>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Date selection:</b></u></TD></tr>

        <TR><TD class="Cell2" id="tdDate3" colspan=4 nowrap>
              <p><b><u>Date Level Selection:</u></b>
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='V' checked> Date Range &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='M' > Month &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='Y' > Year &nbsp;&nbsp;
          </TD>
        </TR>

        <TR id="trWeek">
          <TD class="Cell2" colspan=2>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend', 'DAY')">d-</button>
             <input class="Small" name="Wkend" type="text"  size=10 maxlength=10>&nbsp;
             <button class="Small" name="Up" onClick="setDate('UP', 'Wkend', 'DAY')">d+</button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 300, 300, document.all.Wkend)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </TD>
          <TD class="Cell2" colspan=2>
             <button class="Small" name="Down2" onClick="setDate('DOWN', 'Wkend2', 'DAY')">d-</button>
             <input class="Small" name="Wkend2" type="text"  size=10 maxlength=10>&nbsp;
             <button class="Small" name="Up2" onClick="setDate('UP', 'Wkend2', 'DAY')">d+</button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 650, 300, document.all.Wkend2)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </TD>
        </TR>
        <!-- ======================== Monthly and Yearly ===================== -->
        <TR id="trYrSel">
            <TD class="Cell2" colspan=4><b>Fiscal Year:</b><SELECT name="Year"></SELECT></TD>
        </TR>
        <TR id="trMonSel">
            <TD class="Cell2" colspan=4><b>Fiscal Month:</b><SELECT name="Month"></SELECT></TD>
        </TR>
         
         <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Report by:</b></u></TD></tr>

        <TR>
          <TD class="Cell2" colspan=4>
             <input name="BYSTR" type="radio" value="Y" checked>Store &nbsp; &nbsp;
              <input name="BYSTR" type="radio" value="N">Div/Dpt/Cls/Ven
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=4>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>

</BODY></HTML>
<%}%>