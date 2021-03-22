<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat
, java.sql.*, java.util.*"%>
<%
   StoreSelect strlst = null;

   String sStrAllowed = null;
   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MosStrCtlSel.jsp&APPL=ALL");
   }
   else
   {
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();
     

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       strlst = new StoreSelect(23);
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

<title>MOS Str Ctl List</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";
var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   doStrSelect();
   
   showWkend()
   doMonthSelect()
   showDates()
   
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
//show date selection
//==============================================================================
function showDates()
{
var rangeType = "";
for(var i=0; i < document.all.DatLvl.length; i++)
{
   if ( document.all.DatLvl[i].checked ) { rangeType = document.all.DatLvl[i].value; }
}

if(rangeType == "A")
{
   document.all.trWeek.style.display = "none"
   document.all.trWeek2.style.display = "none"
   document.all.trYrSel.style.display = "none"
   document.all.trMonSel.style.display = "none"
}

if(rangeType == "W")
{
   document.all.trWeek.style.display = "block"
   document.all.trWeek2.style.display = "none"
   document.all.trYrSel.style.display = "none"
   document.all.trMonSel.style.display = "none"
}
if(rangeType == "V")
{
   document.all.trWeek.style.display = "block"
   document.all.trWeek2.style.display = "block"
   document.all.trYrSel.style.display = "none"
   document.all.trMonSel.style.display = "none"
}
if(rangeType == "M")
{
   document.all.trWeek.style.display = "none"
   document.all.trWeek2.style.display = "none"
   document.all.trYrSel.style.display = "block"
   document.all.trMonSel.style.display = "block"
}
if(rangeType == "Y")
{
   document.all.trWeek.style.display = "none"
   document.all.trWeek2.style.display = "none"
   document.all.trYrSel.style.display = "block"
   document.all.trMonSel.style.display = "none"
}
}
//==============================================================================
//populate date selection
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
 document.all.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
 document.all.Wkend2.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
//Weeks Stores
//==============================================================================
function doMonthSelect()
{
var year = 2008;
for (var i=0; i < CurYear - 2008 + 1; i++)
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
//populate date with yesterdate
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

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  // store or sku selection
  var sku = document.all.Sku.value.trim();
  var ctl = document.all.Ctl.value.trim();
  
  // selected status
  var sts = new Array();
  var sel = false;
  for (var i=0, j=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked) { sts[j++] = document.all.Sts[i].value; sel = true; }
  }
  if(!sel && ctl == "") {error = true; msg += "Select at least 1 status"}

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
     if (numstr == 0 && ctl == ""){ error=true; msg+="At least 1 store must be selected.";}
  }
  var grp = "Str";
  if(numstr == 1){ grp = "Ctl"; }
  
  
  var type = null;
  for(var i=0; i < document.all.Type.length; i++)
  {
	  if( document.all.Type[i].checked ){ type = document.all.Type[i].value; break; }
  }
  
  // MOS date
  var wkend = document.all.Wkend.value;
  var wkend2 = document.all.Wkend2.value;
  var year = document.all.Year.value;
  var month = document.all.Month.value;
  var datelvl = document.all.DatLvl[0].value;
  for(var i=0; i < document.all.DatLvl.length; i++)
  {
     if(document.all.DatLvl[i].checked) { datelvl = document.all.DatLvl[i].value; }
  }
  
  var defect = " ";
  if(document.all.MosDef[1].checked){ defect = "Y";}  

  if (error) alert(msg);
  else if( ctl == ""){ sbmRecap(sts, selstr, sku, ctl, grp, type
		  , wkend, wkend2, year, month, datelvl, defect) }  
  else if( ctl != ""){ sbmCtl(ctl) }
  
  //return error == false;
}
//==============================================================================
// Submit Store recap list
//==============================================================================
function sbmRecap(sts, selstr, sku, ctl, grp, type
		, wkend, wkend2, year, month, datelvl, defect)
{
  var url = null;
  url = "MosStrCtl.jsp?"
      + "&Sku=" + sku
      + "&Ctl=" + ctl   
      + "&Grp=" + grp
      + "&Type=" + type
  
  url += "&Wkend=" + wkend;
  url += "&Wkend2=" + wkend2;
  url += "&Year=" + year;
  url += "&Month=" + month;
  url += "&DateLvl=" + datelvl;
  url += "&Defect=" + defect;

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }
  for(var i=0; i < selstr.length; i++){ url += "&Str=" + selstr[i]; }
  
  //alert(url)
  window.location.href=url;
}
//==============================================================================
//submit control
//==============================================================================
function sbmCtl(ctl)
{
	var url="MosCtlInfo.jsp?Ctl=" + ctl;
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
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/2.0 MOS Approval Recap.pdf" class="helpLink" target="_blank">&nbsp;</a></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=center height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>MOS Store Control Number - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR class="trDtl19">
            <TD class="td09" colspan=5>MOS or Defect</TD>
        </tr>
        <tr class="trDtl19">
            <TD class="td09" nowrap>
              <input class="Small" name="MosDef" type="radio" value="M" checked>MOS &nbsp; &nbsp; &nbsp;
              <input class="Small" name="MosDef" type="radio" value="D">Defective Item(s) return to 99 &nbsp;
            </td>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR class="trDtl19">
            <TD class="td09" colspan=5>Order Store Assigning Statuses</TD>
        </tr>
        <!-- tr class="trDtl19">
            <TD class="td09" colspan=5>
              <a href="javascript: chkStsAll(this, true)">All</a> &nbsp;
              <a href="javascript: chkStsAll(this, false)">Reset</a> &nbsp;
            </TD>
        </tr -->    
        <tr class="trDtl19">
            <TD class="td09" nowrap>
              <input class="Small" name="Sts" type="radio" value="Open" >Open (not submitted) &nbsp;
              <input class="Small" name="Sts" type="radio" value="Submitted" checked>Submitted (not approved) &nbsp;
              <input class="Small" name="Sts" type="radio" value="Approved" >Approved by DM &nbsp;
              <input class="Small" name="Sts" type="radio" value="Processed">Processed out of Inventory &nbsp;              
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
              <button onclick='checkReg(&#34;4&#34;)' class='Small'>Dist 4</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
                          
              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
              <%}%>

         </td>
        </tr>

          <!-- ============== Date Selection ========================== -->
          <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>          
        <TR class="trDtl19"><TD class="td09" colspan=4><b><u>Date selection:</b></u></TD></tr>

         <TR class="trDtl19"><TD class="td09" id="tdDate3" colspan=4>
              <p><b><u>Date Level Selection:</u></b>
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='A' checked>All &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='W' > Week &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='V' > Weeks Range &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='M' > Month &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" onclick="showDates()" value='Y' > Year &nbsp;&nbsp;
          </TD>
        </TR>

        <TR id="trWeek"  class="trDtl19">
          <TD class="td09" colspan=4>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend', 'WK')">w-</button>
             <input class="Small" name="Wkend" type="text"  size=10 maxlength=10>&nbsp;
             <button class="Small" name="Up" onClick="setDate('UP', 'Wkend', 'WK')">w+</button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 300, 300, document.all.Wkend)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </TD>
        </TR>
        <TR id="trWeek2"  class="trDtl19">
          <TD class="td09" colspan=4>
             <button class="Small" name="Down2" onClick="setDate('DOWN', 'Wkend2', 'WK')">w-</button>
             <input class="Small" name="Wkend2" type="text"  size=10 maxlength=10>&nbsp;
             <button class="Small" name="Up2" onClick="setDate('UP', 'Wkend2', 'WK')">w+</button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 650, 300, document.all.Wkend2)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </TD>
        </TR>
        <TR id="trWeek3"  class="trDtl19">
          <TD class="td09" colspan=4>        
           *Note: Fiscal week and month have been shifted for EOM reset on Monday night.
          </TD>
       </TR>   
        <!-- ======================== Monthly and Yearly ===================== -->
        <TR id="trYrSel"  class="trDtl19">
            <TD class="td07" colspan=2><b>Fiscal Year:</b></td>
            <TD class="td08" colspan=2><SELECT name="Year"></SELECT></TD>
        </TR>
        <TR id="trMonSel"  class="trDtl19">
            <TD class="td07" colspan=2><b>Fiscal Month:</b></td>
            <TD class="td08" colspan=2><SELECT name="Month"></SELECT></TD>
        </TR>
         

          <!-- =============================================================== -->
          <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
          <TR  class="trDtl19">
              <TD class="td09" align=center colSpan=5>Optional Selection</TD>
          </TR>
          <TR>
              <TD align=center colSpan=5>
                Select SKU: <INPUT name=Sku maxlength=10 size=10>
                 &nbsp; - or - &nbsp;
                Select Control: <INPUT name=Ctl maxlength=10 size=10>
              </TD>
          </TR>
        <!-- =============================================================== -->
          <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
          <TR  class="trDtl19">
              <TD class="td09" align=center colSpan=5>Select type of information</TD>
          </TR>
          <TR>
              <TD align=center colSpan=5>
                <INPUT name="Type" type="radio" value="U">Unit &nbsp; 
                <INPUT name="Type" type="radio" value="C" checked>Cost &nbsp; 
                <INPUT name="Type" type="radio" value="R">Retail &nbsp;                                
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