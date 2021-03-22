<%@ page import="rciutility.StoreSelect, java.sql.*, java.util.*"%>
<%
   StoreSelect strlst = null;

   String sStrAllowed = null;
   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuSrlAsgSel.jsp&APPL=ALL");
   }
   else
   {
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();
     

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       strlst = new StoreSelect(20);
     }
     else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
     {
       strlst = new StoreSelect(21);
     }
     else
     {
       Vector vStr = (Vector) session.getAttribute("STRLST");
       String [] sStrAlwLst = new String[ vStr.size()];
       Iterator iter = vStr.iterator();

       int iStrAlwLst = 0;
       while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

       if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
       else strlst = new StoreSelect(new String[]{sStrAllowed});
    }

    String sStrJsa = strlst.getStrNum();
    String sStrNameJsa = strlst.getStrName();

    int iNumOfStr = strlst.getNumOfStr();
    String [] sStr = strlst.getStrLst();

    String [] sStrRegLst = strlst.getStrRegLst();
    String sStrRegJsa = strlst.getStrReg();

    String [] sStrDistLst = strlst.getStrDistLst();
    String sStrDistJsa = strlst.getStrDist();
    String [] sStrDistNmLst = strlst.getStrDistNmLst();
    String sStrDistNmJsa = strlst.getStrDistNm();

    String [] sStrMallLst = strlst.getStrMallLst();
    String sStrMallJsa = strlst.getStrMall();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<script name="javascript">
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   doStrSelect();
   doSelDate(1);

   if(ArrStr.length < 3)
   {
      document.all.trMult.style.display="none";
      document.all.trSing.style.display="block";
   }
   else
   {
      document.all.trMult.style.display="block";
      document.all.trSing.style.display="none";
   }
   
   if(ArrStr.length == 3) 
   {
	   for(var i=0; i < document.all.Str.length; i++)
	   {
		   document.all.Str[i].checked=true;
	   }
   }
   else if(ArrStr.length == 2)
   { 
	   document.all.Str.checked=true; 
   } 
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    var j = 0;
    j=1;

    for (var i=0; j < ArrStr.length; i++, j++)
    {
      df.Store.options[i] = new Option(ArrStr[j] + " - " + ArrStrNm[j], ArrStr[j]);
    }
    document.all.Store.selectedIndex=0;
}
//==============================================================================
// set all store or unmark
//==============================================================================
function setAll(on)
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++) { str[i].checked = on; }
}
//==============================================================================
// check by regions
//==============================================================================
function checkReg(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
           str[i].checked = chk1;
        };
     }
  }
}
//==============================================================================
// check by districts
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check mall
//==============================================================================
function checkMall(type)
{
  var str = document.all.Str
  var chk1 = true;
  var chk2 = false;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// show date selection
//==============================================================================
function showDates(type, optdt)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate3.style.display="none"
     document.all.tdDate4.style.display="block"
   }
   doSelDate(optdt)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   if(type==1)
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      doSelDate(1);
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date();

  df.StsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  date = new Date(new Date() - 7 * 86400000);
  if (type==2){ date = new Date(); }
  else if (type==3){ date = new Date(new Date() - 3 * 86400000); }

  df.StsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  // selected status
  var sts = new Array();
  var sel = false;
  for (var i=0, j=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked) { sts[j++] = document.all.Sts[i].value; sel = true; }
  }
  if(!sel) {error = true; msg += "Select at least 1 status"}

  // store
  var selstr = new Array();
  if (ArrStr.length < 3){ selstr[0] = document.all.Store.value; }
  else
  {
     var str = document.all.Str;
     selstr = new Array();
     var numstr = 0
     for(var i=0; i < str.length; i++)
     {
       if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; }
     }
     if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}
  }

  // order date
  var stsfrdate = document.all.StsFrDate.value;
  var ststodate = document.all.StsToDate.value;

  var sku = document.all.Sku.value.trim();
  var ord = document.all.Order.value.trim();

  if (error) alert(msg);
  else{ sbmPlan(sts, stsfrdate, ststodate, selstr, sku, ord) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(sts, stsfrdate, ststodate, selstr, sku, ord)
{
  var url = null;
  url = "MozuSrlAsg.jsp?"
      + "StsFrDate=" + stsfrdate
      + "&StsToDate=" + ststodate
      + "&Sku=" + sku
      + "&Ord=" + ord

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }
  for(var i=0; i < selstr.length; i++){ url += "&Str=" + selstr[i]; }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko, check)
{
   var sts = document.all.Sts;
   for(var i=0; i < sts.length; i++) { sts[i].checked = check; }
}
</script>
<script  src="String_Trim_function.js"></script>
<script  src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
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
        <BR>E-Commerce Store Fulfillments - Selection</B>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Order Store Assigning Statuses</TD>
        </tr>
        <tr>
            <TD class="Cell1" colspan=5>
              <a href="javascript: chkStsAll(this, true)">All</a> &nbsp;
              <a href="javascript: chkStsAll(this, false)">Reset</a> &nbsp;
        <tr>
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="Assigned" checked>Assigned &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Printed" checked>Printed &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Picked" checked>Picked &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Problem" checked>Problem &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Resolve" checked>Resolve &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Shipped">Shipped &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Cannot Fill">Cannot Fill &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Sold Out">Sold Out &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Cancelled">Cancelled &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="Error">Error
            </td>
        </TR>
        <!-- ============== Store List ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <tr id="trSing">
         <td  colspan="5" ><br>Select Store: <SELECT name="Store"></SELECT><br><br></td>
        </tr>

        <!-- ============== Multiple Store selection ======================= -->
        <tr id="trMult">
         <td colspan="5" class="Small" nowrap>

         <%for(int i=0; i < iNumOfStr; i++){%>
                  <input class="Small" name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 14 == 0){%><br><%}%>
              <%}%>
              <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;

              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>OKC</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
              <%}%>

         </td>
        </tr>

        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select status changed dates</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(1,1)">Optional Order Date Selection</button>&nbsp;
             <button id="btnSelDates" onclick="showDates(1,2)">Today</button>&nbsp;
             <button id="btnSelDates" onclick="showDates(1,3)">Last 3 Days</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsFrDate')">&#60;</button>
              <input class="Small" name="StsFrDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'StsFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.StsFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsToDate')">&#60;</button>
              <input class="Small" name="StsToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'StsToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 800, 400, document.all.StsToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(1)">Prior 7 days</button>
          </TD>
        </TR>

          <!-- =============================================================== -->
          <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
          <TR>
              <TD class="Cell2" align=center colSpan=5>Optional Selection</TD>
          </TR>
           <TR>
              <TD align=center colSpan=5>
                Select SKU: <INPUT name=Sku maxlength=10 size=10>
                 &nbsp; - or - &nbsp;
                Select Order: <INPUT name=Order maxlength=10 size=10>
              </TD>
          </TR>


        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
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