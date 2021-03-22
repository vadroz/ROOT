<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect, inventoryreports.PiCalendar"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PITopAdjDiffSel.jsp&APPL=ALL");
   }
   else
   {
      ClassSelect divsel = new ClassSelect();
      String sDiv = divsel.getDivNum();
      String sDivName = divsel.getDivName();
      String sDpt = divsel.getDptNum();
      String sDptName = divsel.getDptName();
      String sDptGroup = divsel.getDptGroup();

      StoreSelect StrSelect = new StoreSelect(3);
      int iNumOfStr = StrSelect.getNumOfStr();
      String [] sStr = StrSelect.getStrLst();
      String [] sStrName = StrSelect.getStrNameLst();

      // get PI Calendar
   PiCalendar setcal = new PiCalendar();
   String sYear = setcal.getYear();
   String sMonth = setcal.getMonth();
   String sDesc = setcal.getDesc();
   setcal.disconnect();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];
var StartTime = null;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect(null);
  popPICal();
}
//==============================================================================
// change Store selection
//==============================================================================
function popPICal()
{
   for(var i=0; i < PiYear.length; i++)
   {
      document.all.PICal.options[i] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
   }
}
//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];
    var chg = id;

    var allowed;

    if (id == null || id == 0)
    {
        //  populate the division list
        var start = 0
        for (var i = start, j=0; i < divisions.length; i++, j++)
        {
        	if(divisions[i] < 94){        
        		df.selDiv.options[j] = new Option(divisionNames[i],divisions[i]);
        	}
        	
        }
        if (id == null && document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        if (id == null) id = 0;
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id].split(":");

    //  clear current depts
    for (var i = df.selDpt.length; i >= 0; i--)
    {
       df.selDpt.options[i] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (var i = 0; i < depts.length; i++)
            df.selDpt.options[i] = new Option(deptNames[i],depts[i]);
    }
    //  else display the desired depts
    else
    {
       for (var i = 0; i < allowed.length; i++)
           df.selDpt.options[i] = new Option(deptNames[allowed[i]], depts[allowed[i]]);
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
   var df = document.all;
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   // clear class
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.selectedIndex=0;
   document.all.selCls.size=1;

}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   var df = document.all;
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
// change Store selection
//==============================================================================
function chgStrSel(str)
{
  var stores = document.all.Str;
  var allstr = document.all.STRALL;
  var sasstr = document.all.STRSAS;
  var schstr = document.all.STRSCH;
  var whsstr = document.all.STRWHS;
  var group = str.value;
  var mark = str.checked;

  // unselect other store if ALL selected
  if (group == "ALL")
  {
     for(var i=0; i < stores.length; i++ ) { stores[i].checked = mark; }
     sasstr.checked = false;
     schstr.checked = false;
     whsstr.checked = false;
  }
  else if (group == "SAS")
  {
    for(var i=0; i < stores.length; i++ )
    {
       if  (eval(stores[i].value) >= 3 && eval(stores[i].value) <= 98 && stores[i].value != "35" && stores[i].value != "46"
         && stores[i].value != "50"  && stores[i].value != "55")
       {
          stores[i].checked = mark;
       }
       else { stores[i].checked = false; }
    }
    allstr.checked = false;
    schstr.checked = false;
    whsstr.checked = false;
  }
  else if (group == "SCH")
  {
    for(var i=0; i < stores.length; i++ )
    {
       if  (stores[i].value == "35" || stores[i].value == "46"
         || stores[i].value == "50" || stores[i].value == "55") { stores[i].checked = mark; }
       else { stores[i].checked = false; }
    }
    allstr.checked = false;
    sasstr.checked = false;
    whsstr.checked = false;
  }
  else if (group == "WHS")
  {
    for(var i=0; i < stores.length; i++ )
    {
       if  (stores[i].value == "1" || stores[i].value == "55") { stores[i].checked = mark; }
       else { stores[i].checked = false; }
    }
    allstr.checked = false;
    sasstr.checked = false;
    schstr.checked = false;
  }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var div = document.all.Div.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var cls = document.all.Cls.value.trim();

  var str = document.all.Str
  var strchk = false;
  var strarr = new Array();
  for(var i=0, j=0; i < str.length; i++)
  {
     if(str[i].checked) { strarr[j]=str[i].value; j++; strchk = true; }
  }
  if(!strchk)
  {
    msg += "Please, select at least one store.\n";
    error = true;
  }

  var numitm = document.all.NumItm.value.trim();

  if(isNaN(numitm)){ error=true; msg +="The Number of items must be numeric."}
  else if(eval(numitm) <= 0){ error=true; msg +="The Number of items must be a positive number."}
  else if(eval(numitm) > 100){ error=true; msg +="The Number of items must be from 1 to 100."}
  
  var sort = ""; 
  for(var i=0; i < document.all.Sort.length; i++)
  {
	  if(document.all.Sort[i].checked)
	  {
		  sort = document.all.Sort[i].value;
		  break;
	  }  
  }	  

  var pical = document.all.PICal[document.all.PICal.selectedIndex].value;

  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, strarr, numitm, pical, sort) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, strarr, numitm, pical, sort)
{
  var url = "PITopAdjDiff.jsp?"
      + "Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&NumItm=" + numitm
      + "&PICal=" + pical
      + "&Sort=" + sort

  for(i=0; i < strarr.length; i++){ url += "&Str=" + strarr[i]}

  //alert(url)
  showWaitPanel()
  window.location.href=url;
}

//==============================================================================
//  display Wait Panel
//==============================================================================
function showWaitPanel()
{
  document.all.SUBMIT.disabled=true;
  StartTime = new Date();

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' id='tdHdr' nowrap>Starting Time " + StartTime.getHours() + ":" + StartTime.getMinutes() + ":" + StartTime.getSeconds() + "</td>"
    + "<tr><td class='Prompt'><br><br><br><marquee>Wait while data is retreiving...</marquee><br><br><br></td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   setTimer();
}

//==============================================================================
//  set Timer
//==============================================================================
function setTimer()
{
	setTimeout("showTime()",1000);
	return false;
}
//==============================================================================
//  set Timer
//==============================================================================
function showTime()
{
   var date = new Date();
   document.all.tdHdr.innerHTML = "Starting Time " +  + StartTime.getHours() + ":" + StartTime.getMinutes() + ":" + StartTime.getSeconds()
     + " &nbsp; &nbsp; Current Time " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
   setTimeout("showTime()",1000);
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>PI Top Adjustment Difference - Selection</B>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT><br>

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
            <TD class="Cell1" nowrap>
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" name=GetCls onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="selCls" class="Small" onchange="showClsSelect(this.selectedIndex);" size=1>
                  <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell">Store:</TD>
          <TD class="Cell1" colspan=3>
             <input name="STRALL" type="checkbox" value="ALL" onclick="chgStrSel(this)" checked>All Stores &nbsp;&nbsp;
             <input name="STRSAS" type="checkbox" value="SAS" onclick="chgStrSel(this)">Sun and Ski &nbsp;&nbsp;
             <input name="STRSCH" type="checkbox" value="SCH" onclick="chgStrSel(this)">Ski Chalet &nbsp;&nbsp;
             <input name="STRWHS" type="checkbox" value="WHS" onclick="chgStrSel(this)">Warehouses &nbsp;&nbsp;
             <br><br>
             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="Str" type="checkbox" value="<%=sStr[i]%>" checked><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i==20 || i==40 || i==60) {%><br><%}%>
             <%}%>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=4><b><u>Num of selected items with positive and negative adjustments.</u></b></TD>
        </tr>
        <TR>
            <TD class="Cell2" class="Small" colspan=4><input name="NumItm" value="10" size=3 maxlength=3></TD>
        </tr>
        
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=4><b><u>Select By</u></b></TD>
        </tr>
        <TR>
            <TD class="Cell2" class="Small" colspan=4>
               <input type="radio" name="Sort" value="Unit" checked> Unit &nbsp; &nbsp; &nbsp;
               <input type="radio" name="Sort" value="Cost"> Cost &nbsp; &nbsp; &nbsp;
               <input type="radio" name="Sort" value="Ret"> Retail
            </TD>
        </tr>
        
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell" nowrap>PI Calendar:</TD>
          <TD class="Cell1" colspan=3>
             <select name="PICal"></select>
          </td>
          </tr>
        <!-- =============================================================== -->

        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
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
