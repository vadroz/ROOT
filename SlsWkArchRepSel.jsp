<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SlsWkArchRepSel.jsp&APPL=ALL");
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

      String [] sDivArr = divsel.getDivArr();

      strsel = new StoreSelect(4);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();

      // get current fiscal year
      java.util.Date dCurDate = new java.util.Date();
      SimpleDateFormat sdfUSA = new SimpleDateFormat("MM/dd/yyyy");
      SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
      String sCurDate = sdfUSA.format(dCurDate);

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


      sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
           + " where pida=pime and piYB >= current date - 6 years and piYE <= current date + 2 years";
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      runsql.runQuery();
      String sYrArr = "";
      String sMonArr = "";
      String sMonEndArr = "";
      String sMonEndArrUsa = "";

      String sComa ="";
      while(runsql.readNextRecord())
      {
         sYrArr += sComa + "'" + runsql.getData("pyr#") + "'";
         sMonArr += sComa + "'" + runsql.getData("pmo#") + "'";
         sMonEndArr += sComa + "'" + runsql.getData("pime") + "'";
         sMonEndArrUsa += sComa + "'" + sdfUSA.format(sdfISO.parse(runsql.getData("pime"))) + "'";
         sComa = ",";
      }
%>
<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}

  #trMultDiv { display:none}
  #trSingleDiv { display:block}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;
var CurMonEnd = eval("<%=sMnend%>");

var YrArr = [<%=sYrArr%>];
var MonArr = [<%=sMonArr%>];
var MonEndArr = [<%=sMonEndArr%>];
var MonEndArrUsa = [<%=sMonEndArrUsa%>];

var MultView = false;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect(null);
  document.all.trWeek.style.display="block"

  showAllDates()
  doMonthSelect();
  showDates()
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
function doDivSelect(id) {
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
// change Store selection
//==============================================================================
function chgStrSel(str)
{
  var stores =  document.all.STORE;
  var selstr = str.value;

  // unselect other store if ALL selected
  if (str.value=="ALL" && str.checked || str.value=="SAS" && str.checked
   || str.value=="SCH" && str.checked || str.value=="SAS70" && str.checked
   || str.value=="REG01" && str.checked || str.value=="REG02" && str.checked
   || str.value=="REG03" && str.checked
   )
  {
     for(var i=0; i < stores.length; i++ )
     {
        if(selstr != stores[i].value) stores[i].checked=false;
     }
  }
  else if (str.value!="ALL" && str.value!="SAS" && str.value!="SCH" && str.value!="SAS70"
        && str.value!="REG01" && str.value!="REG02" && str.value!="REG03")  {
     stores[0].checked=false;
     stores[1].checked=false;
     stores[2].checked=false;
     stores[3].checked=false;
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

   if(rangeType == "W")
   {
      document.all.trWeek.style.display = "block"
      document.all.trYrSel.style.display = "none"
      document.all.trMonSel.style.display = "none"
      hideTooltips();
   }
   if(rangeType == "M")
   {
      document.all.trWeek.style.display = "none"
      document.all.trYrSel.style.display = "block"
      document.all.trMonSel.style.display = "block"
      showMonthEnd('FROM');
      showMonthEnd('TO');
   }
   if(rangeType == "Y")
   {
      document.all.trWeek.style.display = "none"
      document.all.trYrSel.style.display = "block"
      document.all.trMonSel.style.display = "none"
      hideTooltips();
   }
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
      document.all.trWeek.style.display="block"
      var date = new Date(new Date() - 86400000);

      // to sales date
      document.all.SlsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

      // from sales date
      var day = 0;
      for(var i=0; i < 7; i++)
      {
         day = date.getDay();
         if (date.getDay()==0){ break; }
         date = new Date(date.getTime() - 86400000);
      }
      document.all.SlsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
      document.all.DatLvl[0].checked = true;
      document.all.DatLvl[1].checked = false;
      document.all.DatLvl[2].checked = false;
}

//==============================================================================
// Weeks Stores
//==============================================================================
function doMonthSelect(id)
{
  var year = YrArr[0];
  for (var i=0; i < YrArr[YrArr.length-1] - YrArr[0] + 1; i++)
  {
     document.all.FrYear.options[i] = new Option(year, year);
     document.all.ToYear.options[i] = new Option(year, year);
     if (year == CurYear )
     {
        document.all.FrYear.selectedIndex = i;
        document.all.ToYear.selectedIndex = i;
     }
     year++;
  }

  var mon = ["April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"]

  for (var i=0; i < mon.length; i++)
  {
     document.all.FrMonth.options[i] = new Option(mon[i], (i+1));
     document.all.ToMonth.options[i] = new Option(mon[i], (i+1));
     if (i == CurMonth )
     {
        document.all.FrMonth.selectedIndex = i;
        document.all.ToMonth.selectedIndex = i;
     }

  }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.SlsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  df.SlsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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

  if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
  else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

  if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
  else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
  var divMult = document.all.DivM;
  var dpt = document.all.Dpt.value.trim();
  var dptnm = document.all.DptName.value.trim();
  var cls = document.all.Cls.value.trim();
  var clsnm = document.all.ClsName.value.trim();
  var ven = document.all.Ven.value.trim();
  var vennm = document.all.VenName.value.trim();

  // get selected divisions
  var divarr = new Array();
  var divsel = false;
  for(var i=0, j=0; i < divMult.length; i++ )
  {
     if(divMult[i].checked)
     {
        divsel=true;
        divarr[j] = divMult[i].value;
        j++;
     }
  }

  if(MultView && !divsel)
  {
    msg += "\n Please, check at least 1 division";
    error = true;
  }

  // get selected stores
  var stores = document.all.STORE;
  var str = new Array();
  // at least 1 store must be selected
  var strsel = false;
  for(var i=0, j=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        str[j] = stores[i].value;
        j++;
     }
  }

  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }

  // get item summary option
  var sumoptfld = document.all.SumOpt;
  var sumopt = new Array();
  // at least 1 store must be selected
  var sumoptsel = false;
  for(var i=0, j=0; i < sumoptfld.length; i++ )
  {
     if(sumoptfld[i].checked)
     {
        sumoptsel=true;
        sumopt[j] = sumoptfld[i].value;
        j++;
     }
  }

  if(!sumoptsel)
  {
    //msg += "\n Please, check at least 1 Detail/Summary option";
    //error = true;
    sumopt[0] = "NON";
  }

  // get store summary option
  var stroptfld = document.all.StrOpt;
  var stropt = null;
  for(var i=0; i < stroptfld.length; i++ )
  {
     if(stroptfld[i].checked) { stropt = stroptfld[i].value; break;}
  }

  // get date summary option
  var dateoptfld = document.all.DatLvl;
  var dateopt = null;
  for(var i=0; i < dateoptfld.length; i++ )
  {
     if(dateoptfld[i].checked) { dateopt = dateoptfld[i].value; break;}
  }

  // sales date
  var slsfrdate = null;
  var slstodate = null;
  var slsfryear = null;
  var slstoyear = null;
  var slsfrmonth = null;
  var slstomonth = null;

  if(dateopt == "W")
  {
     slsfrdate = document.all.SlsFrDate.value;
     slstodate = document.all.SlsToDate.value;
  }
  else if(dateopt == "M")
  {
     slsfryear = document.all.FrYear.value;
     slstoyear = document.all.ToYear.value;
     slsfrmonth = document.all.FrMonth.value;
     slstomonth = document.all.ToMonth.value;
  }
  else if(dateopt == "Y")
  {
     slsfryear = document.all.FrYear.value;
     slstoyear = document.all.ToYear.value;
  }

  var sumdate = "N";
  if (SumDate.checked){ sumdate = "Y"; }

  var dataopt = new Array();
  var dataoptsel = false;
  for(var i=0, j=0; i < document.all.DataOpt.length; i++)
  {
     if(document.all.DataOpt[i].checked){ dataopt[j] = document.all.DataOpt[i].value; j++; dataoptsel=true;}
  }
  if(!dataoptsel)
  {
    msg += "\n Please, check at least 1 Report Data Option.";
    error = true;
  }

  var comment = document.all.Comment.value.trim();

  var incly = "N";
  if(document.all.InclLy.checked){ incly = "Y" };

  var inclly = "N";
  if(document.all.InclLLy.checked){ inclly = "Y" };

  if (error) alert(msg);
  else{ sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, str, slsfrdate, slstodate,
     slsfryear, slstoyear, slsfrmonth, slstomonth, sumopt, stropt, comment, dateopt, dataopt,
     incly, inclly, sumdate, divarr) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, str, slsfrdate, slstodate,
  slsfryear, slstoyear, slsfrmonth, slstomonth, sumopt, stropt, comment, dateopt, dataopt,
  incly, inclly, sumdate, divarr)
{
  var url = null;
  url = "SlsRep04.jsp?"

  if(!MultView) { url += "Div=" + div  }
  else
  {
     var amp = "";
     for(var i=0; i < divarr.length; i++) { url += amp + "Div=" + divarr[i]; amp = "&";}
  }

  url += "&Dpt=" + dpt
       + "&Cls=" + cls
       + "&Ven=" + ven

  // selected store
  for(var i=0; i < str.length; i++)
  {
     url += "&Str=" + str[i]
  }

  if(dateopt == "W") { url += "&FrDate=" + slsfrdate + "&ToDate=" + slstodate; }
  if(dateopt == "M") { url += "&FrYear=" + slsfryear + "&ToYear=" + slstoyear + "&FrMonth=" + slsfrmonth + "&ToMonth=" + slstomonth; }
  if(dateopt == "Y") { url += "&FrYear=" + slsfryear + "&ToYear=" + slstoyear ; }
  url += "&SumDate=" + sumdate;

  // selected item summary options
  for(var i=0; i < sumopt.length; i++)
  {
     url += "&SO=" + sumopt[i]
  }

  // selected store summary options
  url += "&StrLvl=" + stropt

  // include LY comparison
  url += "&IncLY=" + incly
  // include LLY comparison
  url += "&IncLLY=" + inclly

  url += "&Comment=" + comment.replaceSpecChar();

  // selected date summary options
  url += "&DatLvl=" + dateopt

  // selected report data
  for(var i=0; i < dataopt.length; i++) { url += "&Data=" + dataopt[i] }

  //alert(url)
  //window.location.href=url;
  window.frame1.location.href=url;
}
//==============================================================================
// close Submitting frame
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   alert("Report has been submitted")
}
//==============================================================================
// show month ending date as tooltip
//==============================================================================
function showMonthEnd(datgrp)
{
   var year;
   var mon;
   var pos;

   // get date summary option
   var dateoptfld = document.all.DatLvl;
   var dateopt = null;
   for(var i=0; i < dateoptfld.length; i++ )
   {
     if(dateoptfld[i].checked) { dateopt = dateoptfld[i].value; break;}
   }

   if(dateopt == "M")
   {
      var tooltip;
      if(datgrp == "FROM")
      {
         year = document.all.FrYear.options[document.all.FrYear.selectedIndex].value
         mon = document.all.FrMonth.options[document.all.FrMonth.selectedIndex].value
         tooltip = document.all.tooltip1;
         pos = getObjPosition(document.all.FrMonth);
      }
      else
      {
         tooltip = document.all.tooltip2;
         year = document.all.ToYear.options[document.all.ToYear.selectedIndex].value
         mon = document.all.ToMonth.options[document.all.ToMonth.selectedIndex].value
         pos = getObjPosition(document.all.ToMonth);
      }

      var arg = ((eval(year) - YrArr[0])) * 12 + eval(mon) - 1;

      tooltip.innerHTML = MonEndArrUsa[arg];
      tooltip.style.pixelLeft = pos[0] + 80;
      tooltip.style.pixelTop = pos[1] - 15 ;
      tooltip.style.visibility = "visible";
   }

}
//==============================================================================
// show month ending date as tooltip
//==============================================================================
function hideTooltips()
{
   document.all.tooltip1.style.visibility = "hidden";
   document.all.tooltip2.style.visibility = "hidden";
}

//==============================================================================
// switch between single and multiple divisions selections
//==============================================================================
function switchDiv(group)
{
   var single = document.all.trSingleDiv;
   var mult = document.all.trMultDiv;
   var sdisp = "none";
   var mdisp = "block";

   if(group == "SINGLE"){ sdisp = "block"; mdisp = "none"; MultView = false;}
   else { MultView = true; }

   for(var i=0; i < single.length; i++){ single[i].style.display = sdisp; }
   for(var i=0; i < mult.length; i++){ mult[i].style.display = mdisp; }
}

//==============================================================================
// disable enter key
//==============================================================================
function disableEnterKey(e)
{
     var key;
     if(window.event)
     {
          key = window.event.keyCode; //IE
     }
     return (key != 13);
}
document.onkeypress = disableEnterKey;
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip1" style="position:absolute; visibility:hidden; background-color:LemonChiffon; z-index:10; font-size:10px; "></div>
<div id="tooltip2" style="position:absolute; visibility:hidden; background-color:LemonChiffon; z-index:10; font-size:10px;"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--TR><TD height="20%"><IMG src="Sun_ski_logo1.jpg"></TD></TR -->

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Sales Archive Report (Excel)</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>&nbsp; &nbsp; &nbsp; &nbsp;
            <a href="SlsRepJobMon.jsp" target="_blank"><font color="blue" size="-1">Report Monitor</font></a>

      <TABLE border=0>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR id="trSingleDiv">
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
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
        <TR id="trSingleDiv">
            <TD class="Cell" >&nbsp;</TD>
         </TR>
        <!-- ========================== Class ============================== -->
        <TR id="trSingleDiv">
            <TD class="Cell" >Class:</TD>
            <TD class="Cell1">
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" value="Select Class" name=SUBMIT onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="selCls" class="Small" onchange="showClsSelect(this.selectedIndex);">
                 <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>
        <TR id="trSingleDiv">
           <TD class="Cell2" colspan=5>
              <button class="Small" onClick="switchDiv('MULTIPLE')">Multiple Divisions</button>
           </td>
        </TR>

        <!-- ===================== Multiple Division Selection ============= -->
        <TR id="trMultDiv">
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" colspan=3 nowrap>
            <%for(int i=0; i < sDivArr.length; i++){%>
               <%if(i > 0 && i % 17 == 0){%><br/><%}%>
               <input class="Small" name="DivM" type="checkbox" value="<%=sDivArr[i]%>"> <%=sDivArr[i]%> &nbsp; &nbsp;
            <%}%>
          </TD>
        </TR>
        <TR id="trMultDiv">
           <TD class="Cell1" colspan=4>
              <button class="Small"  onClick="switchDiv('SINGLE')">Single Divisions</button>
           </td>
        </TR>

        <!-- ========================== Vendor ============================== -->
        <TR>
            <TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap colspan=3>
              <input class="Small" name="VenName" size=50 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button><br>
            </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell">Store:</TD>
          <TD class="Cell1" colspan=3 nowrap>
             <input name="STORE" type="checkbox" value="ALL" onclick="chgStrSel(this)" checked>Total Stores&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="SAS" onclick="chgStrSel(this)" >Sun & Ski&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="SCH" onclick="chgStrSel(this)" >Ski Chalet&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="SAS70" onclick="chgStrSel(this)" >Sun & Ski + 70&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="REG01" onclick="chgStrSel(this)" >Region 1&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="REG02" onclick="chgStrSel(this)" >Region 2&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="REG03" onclick="chgStrSel(this)" >Region 3&nbsp;&nbsp;
             <br>


             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="STORE" type="checkbox" onclick="chgStrSel(this)" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i > 0 && i % 18 == 0) {%><br><%}%>
             <%}%>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <!-- ============== select Shipping changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Select Sales Dates</b></u></TD></tr>

        <TR><TD class="Cell2" id="tdDate3" colspan=4>
              <p><b><u>Date Level Selection:</u></b>
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='W' > Week &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='M' > Month &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='Y' > Year &nbsp;&nbsp;
              <input class="Small" name="SumDate" type="checkbox" onclick="showDates()" value='Y' > Summary Only &nbsp;&nbsp;
          </TD>
        </TR>

        <TR  id="trWeek">
          <TD colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'DAY')">d-</button>
              <input class="Small" name="SlsFrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.SlsFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date: </b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'DAY')">d-</button>
              <input class="Small" name="SlsToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.SlsToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
      <!-- ======================== Monthly and Yearly ===================== -->
      <TR id="trYrSel">
          <TD align=center colspan=2><b>From Fiscal Year Ending:</b> <SELECT name="FrYear" onchange="showMonthEnd('FROM')"></SELECT></TD>
          <TD align=center colspan=2><b>To Fiscal Year Ending:</b> <SELECT name="ToYear" onchange="showMonthEnd('TO')"></SELECT></TD>
      </TR>
      <TR id="trMonSel">
          <TD align=center colspan=2><b>From Fiscal Month:</b> <SELECT name="FrMonth" onchange="showMonthEnd('FROM')"></SELECT></TD>
          <TD align=center colspan=2><b>To Fiscal Month:</b> <SELECT name="ToMonth" onchange="showMonthEnd('TO')"></SELECT></TD>
      </TR>
      <TR>
          <TD align=center colspan=4><input type="checkbox" name="InclLy" value="Y"><b>Include LY comparison</b>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input type="checkbox" name="InclLLy" value="Y"><b>Include LLY comparison</b></TD>
      </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Item Detail/Summary Options</b></u></TD></tr>

        <TR>
          <TD class="Cell2" colspan=4>
             <input name="SumOpt" type="checkbox" value="DIV" checked>Divison &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" value="DPT" checked>Department &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" value="CLS" checked>Class &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" value="VEN">Vendor &nbsp; &nbsp;

          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Store Level Break Options</b></u></TD></tr>

        <TR>
          <TD class="Cell2" colspan=4>
             <input name="StrOpt" type="radio" value="STR" checked>Store &nbsp; &nbsp;
             <input name="StrOpt" type="radio" value="REG" >Region &nbsp; &nbsp;
             <input name="StrOpt" type="radio" value="NONE">None &nbsp; &nbsp;
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Select report data</b></u></TD></tr>

        <TR>
          <TD class="Cell2" colspan=5>
            <table border=0>
             <tr>
              <td class="Cell2" align=center colspan=2><u>&nbsp;&nbsp;Sales:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></td>
              <td class="Cell2" align=center colspan=2><u>&nbsp;&nbsp;&nbsp;Gross Margin:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></td>
              <td class="Cell2" align=center colspan=2><u>Ending Inventory:</u></td>
              <td class="Cell2" align=center colspan=4><u>&nbsp;&nbsp;&nbsp;&nbsp;Aged Inventory:&nbsp;&nbsp;</u></td>              
              <td class="Cell2" style="text-decoration:underline" align=center colspan=2>
                <%for(int i=0; i < 40; i++){%>&nbsp;<%}%>Markdowns<%for(int i=0; i < 40; i++){%>&nbsp;<%}%>
              </td>
              <td class="Cell2" align=center colspan=2><u>Purchase:</u></td>
              <!--td class="Cell2" align=center colspan=2><u>Traffic:</u></td -->
              <td class="Cell2" align=center colspan=4><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          Clearance - Sls, Inv:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></td>
             </tr>
             <tr>
              <td class="Cell2" align=right >Retail</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="SLSRET"></td>
              <td class="Cell2" align=right >GM Dollars</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="GMRAMT"></td>
              <td class="Cell2" align=right >Retail</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="ENDRET"></td>
              <td class="Cell2" align=right >Retail</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="AGERET"></td>
              <td class="Cell2" align=right > - %</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="AGPRET"></td>
              <td class="Cell2" align=right >General</td>
              <td class="Cell1" align=left><input type="checkbox" name="DataOpt" value="MDGEN"></td>
              <td class="Cell2" align=right >&nbsp;At Retail</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="PRCHRET"></td>
              <!--td class="Cell2" align=right >&nbsp;Traffic</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="TRAFFIC"></td-->
              <td class="Cell2" align=right >&nbsp;Retail Sls</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="CLRSLSRET"></td>
              <td class="Cell2" align=right >&nbsp;Retail Inv</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="CLRINVRET"></td>
            </tr>
            <tr>
              <td class="Cell2" align=right>Cost</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="SLSCST"></td>
              <td class="Cell2" align=right >GM %:</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="GMRPRC"></td>
              <td class="Cell2" align=right>Cost</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="ENDCST"></td>
              <td class="Cell2" align=right>Cost</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="AGECST"></td>
              <td class="Cell2" align=right> - %</td>
              <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="AGPCST"></td>

              <td class="Cell">&nbsp;</td>
              <td class="Cell1"><u>POS</u></td>
              <td class="Cell2" align=right >&nbsp;At Cost</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="PRCHCST"></td>

              <!--td class="Cell2" align=right >&nbsp;# of Trans</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="NUMTRANS"></td-->
              <td class="Cell2" align=right >&nbsp;Cost Sls</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="CLRSLSCST"></td>
              <td class="Cell2" align=right >&nbsp;Cost Inv</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="CLRINVCST"></td>
             </tr>
             <tr>
               <td class="Cell2" align=right>Units</td>
               <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="SLSUNT"></td>
               <td class="Cell2" colspan=2>&nbsp;</td>
               <td class="Cell2" align=right>Units</td>
               <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="ENDUNT"></td>
               <td class="Cell2" align=right>Units</td>
               <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="AGEUNT"></td>
               <td class="Cell2" align=right> - %</td>
               <td class="Cell2" align=left><input type="checkbox" name="DataOpt" value="AGPUNT"></td>
               <td class="Cell2" >&nbsp;</td>
               <td class="Cell2" align=right>Authorized<input type="checkbox" name="DataOpt" value="MDAUT">
                  &nbsp;&nbsp;&nbsp;
                  Unauthorized<input type="checkbox" name="DataOpt" value="MDUAU">
                  &nbsp;&nbsp;&nbsp;
                  Total POS<input type="checkbox" name="DataOpt" value="MDPOS">
               </td>
               <td class="Cell2" align=right >&nbsp;At Unit</td>
               <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="PRCHUNT"></td>
               <td class="Cell2" align=right >&nbsp;Unit Sls</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="CLRSLSUNT"></td>
              <td class="Cell2" align=right >&nbsp;Unit Inv</td>
              <td class="Cell2" align=left ><input type="checkbox" name="DataOpt" value="CLRINVUNT"></td>
             </tr>

             <tr>
                <td class="Cell2" colspan=10>&nbsp;</td>
                <td class="Cell2" align=right>Total</td>
                <td class="Cell1"><input type="checkbox" name="DataOpt" value="MDTOT"></td>
             </tr>
           </table>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=4>
               Comment: <input  name="Comment" size=100 maxlength=100><br>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
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