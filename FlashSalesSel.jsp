<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect, java.sql.*, rciutility.RunSQLStmt
, java.text.*, java.util.*, menu.FlashSalesAvailable"%>
<%
	StoreSelect strlst = null;
	String sStrAllowed = null;
	String sUser = null;

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=FlashSalesSel.jsp&APPL=ALL");
}
else
{
  	sStrAllowed = session.getAttribute("STORE").toString();
  	sUser = session.getAttribute("USER").toString();
  
  	strlst = new StoreSelect(24);  	
  	
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

	FlashSalesAvailable flashavail = new FlashSalesAvailable();
   	boolean bAvail = flashavail.getAvail();
   	flashavail.disconnect();
   	if (bAvail)   
   	{

   		boolean bKiosk = session.getAttribute("USER") == null;
   		sUser = "KIOSK";
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

<title>Sales Forecasting Report</title>

<script name="javascript">
//================= Global variable ============================================
var MonEndTime = [<%=sMonEndArr%>];
var MonBegTime = [<%=sMonBegArr%>];
var MonBeg = new Array();
var MonEnd = new Array();

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";

//================= End Of Global variable +====================================

function bodyLoad()
{
    // selelct all store
	setAll(true);
  
  	// populate date with yesterdate
  	doSelDate();
  	// populate division and department
  	doDivSelect(null);

  cvtTimeToDate();
}

 
//==============================================================================
//set all store or unmark
//==============================================================================
function setAll(on)
{
var str = document.all.Str;
for(var i=0; i < str.length; i++) { str[i].checked = on; }
}
//==============================================================================
//check 2 group of bike sale stores (Pandemia measures)
//==============================================================================
function checkGrp(grp)
{
	var str = document.all.Str
	 
	//check 1st selected group check status and save it
	var find = false;
	var arrGrp1 = ["3","4","6","8","15","16","17","25","77","82","87","88"];
	var arrGrp2 = [ "10","11","22","28","29","35","40","42","50","66","90","91","93","96","98" ];
	for(var i=0; i < str.length; i++)
	{
		find = false;
		str[i].checked = false;
		if(grp == "100")
		{
			for(var j=0; j < arrGrp1.length; j++)
			{			
				if(str[i].value == arrGrp1[j])
   				{
     				str[i].checked = true;
     				find = true;
     				break;
   				};   			
			}
		}
		
		if(grp == "110")
		{
			for(var j=0; j < arrGrp2.length; j++)
			{			
				if(str[i].value == arrGrp2[j])
   				{
     				str[i].checked = true;
     				find = true;
     				break;
   				};   			
			}
		}
	}
}
//==============================================================================
//check by regions
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
     if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist && str[i].value != "5"	 
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
     if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist  && str[i].value != "5"	 
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
//check by districts
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
//check mall
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
function Validate()
{
  var form = document.all;
  var error = false;
  var msg = "";
  var divIdx = form.Division.selectedIndex;
  var dptIdx = form.Department.selectedIndex;
  var clsIdx = form.Class.selectedIndex;

  var div = form.Division.options[divIdx].value;
  var dpt = form.Department.options[dptIdx].value;
  var cls = form.Class.options[clsIdx].value;
  var divnm = form.Division.options[divIdx].text;
  var dptnm = form.Department.options[dptIdx].text;
  var clsnm = form.Class.options[clsIdx].text;
  var date = form.selDate.value;
  var level = null;
  var period = null;
  
//store
  var selstr = new Array();
  var str = document.all.Str;
  selstr = new Array();
  var numstr = 0
  for(var i=0; i < str.length; i++)
  {
    if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; }
  }
  if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}  
  else if (selstr.length == ArrStr.length - 1){ selstr = new Array(); selstr[0] = "ALL"; }
 
  // Report Level  
  if(selstr.length > 0 && selstr[0] == "ALL" && !document.all.Chain.checked){ level = "S"; }
  else if(selstr.length > 1 && !document.all.Chain.checked){ level = "S"; }
  else if(cls != "ALL" || dpt != "ALL") { level = "C"; }
  else if(div != "ALL" ) { level = "P"; }
  else { level = "D"; }

  // Report type
  if(document.all.Report[0].checked) period = document.all.Report[0].value;
  else if(document.all.Report[1].checked) period = document.all.Report[1].value;
  else if(document.all.Report[2].checked) period = document.all.Report[2].value;
  else if(document.all.Report[3].checked) period = document.all.Report[3].value;


  if (error) alert(msg);
  else submitReport(selstr, div, divnm, dpt, dptnm, cls, clsnm, date, level, period);

  return error == false;
}
//==============================================================================
// submit report
//==============================================================================
function submitReport(str, div, divnm, dpt, dptnm, cls, clsnm, date, level, period)
{
   var url = "FlashSalesTyLy.jsp?"     
     + "&Division=" + div
     + "&DivName=" + divnm
     + "&Department=" + dpt
     + "&DptName=" + dptnm
     + "&Class=" + cls
     + "&clsName=" + clsnm
     + "&Date=" + date
     + "&Level=" + level
     + "&Period=" + period
     
   for(var i=0; i < str.length; i++)
   {
	  url += "&Str=" + str[i]; 
   }

   //alert(url)
   window.location.href=url;
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
    <TD colSpan=2 height="20%" align=center><IMG src="Sun_ski_logo4.png"></TD></TR>
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
        
        <!-- ============== Multiple Store selection ======================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <tr id="trMult">
         <td colspan="5" class="Small" nowrap>

         <%for(int i=0; i < iNumOfStr; i++){%>
                  <input class="Small" name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 14 == 0){%><br><%}%>
              <%}%>
              <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;
              
              <!--  button onclick='checkGrp(&#34;100&#34;)' class='Small'>Bikes-Jay</button --> 
              <!--  button onclick='checkGrp(&#34;110&#34;)' class='Small'>Bikes-Jeremy</button -->  

              <!--button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
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
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button --> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br>
              
              <span id="spChain"><input name="Chain" type="checkbox" value="S">By Chain</span>
              <br><br>
              <%}%>

         </td>
        </tr>
        
        
        
         <!-- --------------------------------------------------------------- -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=right >Report:</TD>
          <TD align=left>
             <input name="Report" type="radio" value="MTDTYLY" checked>TY vs. LY MTD &nbsp;&nbsp;
             <input name="Report" type="radio" value="YTDTYLY">TY vs. LY QTD & YTD<br>
             <input name="Report" type="radio" value="MTDTYPLAN">TY vs. Target MTD &nbsp;&nbsp;
             <input name="Report" type="radio" value="YTDTYPLAN">TY vs. Target QTD & YTD
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
<%}%>




