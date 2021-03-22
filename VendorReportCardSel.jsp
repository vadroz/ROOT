<%@ page import="java.util.*, rciutility.SetMonths"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=VendorReportCardSel.jsp&APPL=ALL");
}
else
{
   SetMonths setmon = new SetMonths();
   int iNumOfMon = setmon.getNumOfMon();
   String sMonBeg = setmon.getMonBegJSA();
   String sMonEnd = setmon.getMonEndJSA();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { border: gray solid 1px; width:280; height:250;background-color:
                 white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.3" src="Calendar.js">
</script>


<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var MonBeg = [<%=sMonBeg%>];
var MonEnd = [<%=sMonEnd%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  document.all.tdDate1.style.display="block"
  document.all.tdDate2.style.display="none"
  rtvVendors();
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(show)
{
   document.all.tdDate1.style.display="none"
   document.all.tdDate2.style.display="block"
   doSelDate()
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   document.all.FromDate.value = "ALL"
   document.all.ToDate.value = "ALL"
   document.all.FromMon.value = "1"
   document.all.ToMon.value = "27"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(){
  var df = document.all;
  df.FromDate.value = MonBeg[26];
  df.FromMon.value = 1;
  df.ToDate.value = MonEnd[1];
  df.ToMon.value = 27;

  for(var i=1; i < 27; i++)
  {
     df.SelMonBeg.options[i-1] = new Option(MonBeg[i], MonBeg[i]);
     df.SelMonEnd.options[i-1] = new Option(MonEnd[i], MonEnd[i]);
  }
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
   Vendor = new Array(ven.length - 1);
   VenName = new Array(ven.length - 1);
   for(var i=1; i < ven.length; i++)
   {
      Vendor[i-1] = ven[i];
      end = venName[i].length;
      if (venName[i].indexOf("#") > 0) {  end = venName[i].indexOf("#"); }
      VenName[i-1] = venName[i].substring(0,end);
   }

   var html = "<input name='FndVen' class='Small' size=4 maxlength=4>&nbsp;"
     + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
     + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;<br>"
   var dummy = "<table>"

   html += "<div id='dvInt' class='dvInternal'>"
         + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
   for(var i=0; i < Vendor.length; i++)
   {
     html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;"
          + Vendor[i] + "&#34;, &#34;" + VenName[i] + "&#34;)'>" + VenName[i] + "</td></tr>"
   }
   html += "</table></div>"

   document.all.dvVendor.innerHTML = html;
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
     if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break}
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
// change selected date
//==============================================================================
function chgSelDate(type)
{
   if(type=="BEG")
   {
      document.all.FromDate.value = document.all.SelMonBeg.options[document.all.SelMonBeg.selectedIndex].value
      document.all.FromMon.value = 27 - document.all.SelMonBeg.selectedIndex
   }
   if(type=="END")
   {
      document.all.ToDate.value = document.all.SelMonEnd.options[document.all.SelMonEnd.selectedIndex].value
      document.all.ToMon.value = 27 - document.all.SelMonEnd.selectedIndex
   }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var ven = document.all.Ven.value.trim();
  var venname = document.all.VenName.value.trim();
  var frmon = document.all.FromMon.value;
  var tomon = document.all.ToMon.value;
  var frdate = document.all.FromDate.value;
  var todate = document.all.ToDate.value;

  if ( document.all.FromDate.value != "ALL"
    && new Date(document.all.FromDate.value).getTime() > new Date(document.all.ToDate.value).getTime())
  { error=true; msg += "From Date is greater than To Date.\n";  }

  if ( frdate == "ALL") { frdate = MonBeg[26]; }
  if ( todate == "ALL") { todate = MonEnd[1]; }

  if(ven == "SELECT_VENDOR") {error=true; msg += "Please, select vendor.\n";}

  if (error) alert(msg);
  else{ sbmPlan(ven, venname, frmon, tomon, frdate, todate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(ven, venname, frmon, tomon, frdate, todate)
{
  var url = null;
  url = "VendorReportCard.jsp?"
  url += "Ven=" + ven
       + "&VenName=" + venname.replaceSpecChar()
       + "&From=" + frmon
       + "&To=" + tomon
       + "&FromDt=" + frdate
       + "&ToDt=" + todate;

  //alert(url)
  window.location.href=url;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
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
        <BR>Vendor Performance - Selection</B>

      <TABLE>
        <TBODY>
        <!-- ========================== Vendor ============================== -->
            <TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap>
              <input class="Small" name="VenName" size=50 value="--- Select Vendor ---" readonly>
              <input class="Small" name="Ven" type="hidden" value="SELECT_VENDOR"><br>
              <div id="dvVendor" class="dvVendor"></div>
            </TD>
        </TR>

        <!-- ============== select latest changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates()">Optional Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <table>
             <tr>
                 <td valign="top"><b>From Date:</b></td>
                 <td><input class="Small" name="FromDate" type="text" readOnly value="ALL" size=10 maxlength=10>
                     <input class="Small" name="FromMon" type="hidden" value="1"><br>
                     <select class="Small" name="SelMonBeg" onClick="chgSelDate('BEG')"></select>
                 </td>
                 <td valign="top"><b>To Date:</b></td>
                 <td><input class="Small" name="ToDate" type="text" readOnly value="ALL" size=10 maxlength=10>
                     <input class="Small" name="ToMon" type="hidden" value="27"><br>
                     <select class="Small" name="SelMonEnd" onClick="chgSelDate('END')"></select>
                 </td>
              </tr>
              </table>
              <button id="btnSelDates" onclick="showAllDates()">All Date</button>
          </TD>
        </TR>
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