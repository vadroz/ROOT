<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect, inventoryreports.PiCalendar, java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PIAdjByAreaSel.jsp&APPL=ALL");
   }
   else
   {
      ClassSelect divsel = new ClassSelect();
      String sDiv = divsel.getDivNum();
      String sDivName = divsel.getDivName();

      StoreSelect StrSelect = null;
      String sStr = null;
      String sStrName = null;

      String [] sStrLst = null;
      String [] sStrLstName = null;
      int iNumOfStr = 0;

      String sStrAllowed = session.getAttribute("STORE").toString();
      String sUser = session.getAttribute("USER").toString();
      int iStrAlwLst = 0;

      if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
        StrSelect = new StoreSelect(2);
      }
      else
      {
        Vector vStr = (Vector) session.getAttribute("STRLST");
        String [] sStrAlwLst = new String[ vStr.size()];
        Iterator iter = vStr.iterator();

        while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

        if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
        else StrSelect = new StoreSelect(new String[]{sStrAllowed});
      }

      iNumOfStr = StrSelect.getNumOfStr();
      sStrLst = StrSelect.getStrLst();
      sStrLstName = StrSelect.getStrNameLst();

      sStr = StrSelect.getStrNum();
      sStrName = StrSelect.getStrName();

      // get PI Calendar
      PiCalendar setcal = new PiCalendar();
      String sYear = setcal.getYear();
      String sMonth = setcal.getMonth();
      String sDesc = setcal.getDesc();
      setcal.disconnect();
%>
<title>PI Adj Review</title>
<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top;  text-decoration:underline}

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
var StrLst = [<%=sStr%>];
var StrNmLst = [<%=sStrName%>];

var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];

var Adj_NoCnt = true;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  setDivSel(null);
  setStrSel();

  popPICal();
  
  if(document.all.Adj.value.trim() == "")
  {
	  Adj_NoCnt = false;
  }
}
//==============================================================================
// change Store selection
//==============================================================================
function popPICal()
{
   for(var i=0, j=1; i < PiYear.length; i++, j++)
   {
      document.all.PICal.options[i] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
   }

}
//==============================================================================
// popilate division selection
//==============================================================================
function setDivSel(id) {
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];

    //  populate the division list
    var start = 0
    for (var i = start, j=0; i < divisions.length; i++, j++)
    {
       df.Div.options[j] = new Option(divisionNames[i],divisions[i]);
    }
}
//==============================================================================
// set store drop down menu
//==============================================================================
function setStrSel()
{
   for(var i=1; i < StrLst.length; i++)
   {
      document.all.Str.options[i-1] = new Option(StrLst[i] + " - " + StrNmLst[i], StrLst[i]);
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

  var str = document.all.Str.options[document.all.Str.selectedIndex].value;
  if(str =="NONE"){ error=true; msg +="There is no store selection for this Group."}

  var adj = document.all.Adj.value.trim();  
  var nocnt = document.all.NoCnt.value.trim();
  
  if(Adj_NoCnt) 
  {  
	  if(isNaN(adj)){ error=true; msg +="The Number of items must be numeric."}
	  nocnt = "0";
  }
  else
  {
	  if(isNaN(nocnt)){ error=true; msg +="The Number of items must be numeric."}
	  adj = "0";
  }
  

  var pical = document.all.PICal.options[document.all.PICal.selectedIndex].value.trim();

  if (error) alert(msg);
  else{ sbmPlan(div, str, adj, nocnt, pical) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, str, adj, nocnt, pical)
{
  var url = "PIAdjByArea.jsp?"
      + "Div=" + div
      + "&Str=" + str
      + "&Adj=" + adj
      + "&NoCnt=" + nocnt
      + "&PiCal=" + pical

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
//==============================================================================
//set Timer
//==============================================================================
function setInpFld(fldnm)
{
	if(fldnm == "Adj")
	{ 
		Adj_NoCnt = true;
		document.all.NoCnt.value = "";
		document.all.NoCnt.readOnlu = true;
		document.all.Adj.readOnlu = false;
	}
	else
	{ 
		Adj_NoCnt = false; 
		document.all.Adj.value = "";
		document.all.Adj.readOnlu = true;
		document.all.NoCnt.readOnlu = false;
	}	
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
        <BR>PI Initial Review - Highest (by Division) - Selection</B>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <SELECT name="Div" class="Small">
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT>
          </TD>
        <TR>
            <TD class="Cell" >&nbsp;</TD>
         </TR>


        <TR>
          <TD class="Cell">Store:</TD>
          <TD class="Cell1" colspan=3 nowrap>
             <select name="Str" class="Small"></select>
          </TD>
        </TR>


        <TR>
          <TD class="Cell">PI Calendar:</TD>
          <TD class="Cell1" colspan=3 nowrap>
             <select class="Small" name="PICal"></select>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=4><b><u>Allowable +/- Adjustment</u></b></TD>
        </tr>
        <TR>
            <TD class="Cell2" class="Small" colspan=4>+/-<input name="Adj" onkeydown="setInpFld('Adj')" value="2" size=5 maxlength=3>
            	<br><span style="font-size:11px;">
                 (enter a qty of 2 to review most divisions)</span>
            </TD>
        </tr>
        
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=4><b><u>Top Items with NO COUNTS</u></b></TD>
        </tr>
        <TR>
            <TD class="Cell2" class="Small" colspan=4><input name="NoCnt" onkeydown="setInpFld('NoCnt')" size=5 maxlength=3>
            	<br><span style="font-size:11px;">
                 (enter a qty of 10 to review most divisions)</span>
            </TD>
            
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
