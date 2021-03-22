<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
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

      StoreSelect strsel = null;

      String sDiv = null;
      String sDivName = null;
      String sDpt = null;
      String sDptName = null;
      String sDptGroup = null;
      String sCls = null;
      String sClsName = null;

       

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
	
  	showWkend()
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
    
    date = new Date(date.getTime() - 7 * 86400000);
    
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
  
  var stores = document.all.SelStr;
  var str = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;
  
  // sales date
  var wkend = document.all.Wkend.value;
  var wkend2 = document.all.Wkend2.value;  

  if (error) alert(msg);
  else{ sbmSlsRep(str, wkend, wkend2); }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(str, wkend, wkend2)
{
  var url = null;
  url = "GenderHrs.jsp?"
  url += "Str=" + str
  url += "&FrWeek=" + wkend;
  url += "&ToWeek=" + wkend2;
  
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
        <BR>Employee Availability by Gender - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE>
        <TBODY>
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
        <TR><TD class="Cell2" colspan=4 align=center><b><u>Week Selection:</b></u></TD></tr>

        <TR id="trWeek">
          <TD class="Cell2" colspan=2 align=center>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend', 'WK')">w-</button>
             <input class="Small" name="Wkend" type="text"  size=10 maxlength=10>&nbsp;
             <button class="Small" name="Up" onClick="setDate('UP', 'Wkend', 'WK')">w+</button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 300, 300, document.all.Wkend)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </TD>
          <TD class="Cell2" colspan=2 align=center>
             <button class="Small" name="Down2" onClick="setDate('DOWN', 'Wkend2', 'WK')">w-</button>
             <input class="Small" name="Wkend2" type="text"  size=10 maxlength=10>&nbsp;
             <button class="Small" name="Up2" onClick="setDate('UP', 'Wkend2', 'WK')">w+</button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 650, 300, document.all.Wkend2)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </TD>
        </TR>
          
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD class="Cell2" colSpan=4 align=center>
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