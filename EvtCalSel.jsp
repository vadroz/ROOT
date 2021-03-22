<%@ page import="rciutility.StoreSelect,rciutility.RunSQLStmt
, java.util.*, java.text.*, java.io.*, java.math.*, java.sql.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     out.println(request.getRequestURI());
     response.sendRedirect("SignOn1.jsp?TARGET=EvtCalSel.jsp&APPL=ALL");
   }
   else
   {
	   	
		 String sStrAllowed = session.getAttribute("STORE").toString();
	   	 String sUser = session.getAttribute("USER").toString();
	   	 
	   	 StoreSelect strlst = null;     

	     //if (sStrAllowed != null && sStrAllowed.startsWith("ALL")) { 
	       strlst = new StoreSelect(20);
	     //}
	    // else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
	    /*  {
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
         */
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
	   	   
	   
	   String sStmt = "select * from rci.fsyper where pida = current date";
       	System.out.println(sStmt);
       	RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		ResultSet rs = runsql.runQuery();	
		String sYear = null;
		if(runsql.readNextRecord())
		{
			sYear = runsql.getData("pYr#").trim();
		}		
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  

  div.dvMenu {position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10}

</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript1.2">
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var OptGroup = new Array();
var CurYear = "<%=sYear%>"
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   setYear(true);
   doStrSelect();
}
//==============================================================================
// Setup Year drop-menu
//==============================================================================
function setYear(curOnly)
{
  var curDate = new Date();
  var curMonth = curDate.getMonth() + 1;
  var curYear = CurYear;
  //var curYear = curDate.getFullYear();
  //if (curMonth > 3) curYear = eval(curYear) + 1;
  var max = 2;
  var year = curYear;
  if (!curOnly) { year = curYear - 5;  max = 6; }

  var optg = new Array();
  var selyr = new Array();

  // clear options
  for(var i=document.all.Year.length-1; i > 0; i--)
  {
    document.all.Year.options[i]=null;
  }

  // clear option groups
  for(var i=0; i < OptGroup.length; i++)
  {
    document.all.Year.removeChild(OptGroup[i]);
  }
  OptGroup = new Array();

  for(var i=0, k=0, l=0; i < max; i++)
  {
    optg[i] = document.createElement('optgroup');
    optg[i].label = year;
    document.all.Year.appendChild(optg[i]);
    OptGroup[i] = optg[i];

     for(var j=0; j < 4; j++)
     {
        document.all.Year.options[k] = new Option(year + " / " + (j+1) + " Qtr", year + "/" + (j+1));
        // select current year
        if(year == curYear) selyr[l++] = k;
        k++;
     }
     year++;
  }

  if (curOnly ) {  for(var i=0; i < l; i++) {  document.all.Year.options[selyr[i]].selected=true; } }
}
//==============================================================================
//Load Stores
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
//set all store or unmark
//==============================================================================
function setAll(on)
{
var str = document.all.Str;
for(var i=0; i < str.length; i++) { str[i].checked = on; }
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
     if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
       || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
       || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
       || str[i].value == "68" || str[i].value == "86"))
       
       || (dist == "BIKE" && (str[i].value == "3" || str[i].value == "4" || str[i].value == "6" 
       || str[i].value == "8" || str[i].value == "10" || str[i].value == "16" || str[i].value == "20" 
       || str[i].value == "22" || str[i].value == "42" || str[i].value == "82" || str[i].value == "87"       
       || str[i].value == "88" || str[i].value == "90" || str[i].value == "91" || str[i].value == "93" 
       || str[i].value == "96" || str[i].value == "98"))
       
       )
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
       || str[i].value == "68" || str[i].value == "86"))
       
       || (dist == "BIKE" && (str[i].value == "3" || str[i].value == "4" || str[i].value == "6" 
       || str[i].value == "8" || str[i].value == "10" || str[i].value == "16" || str[i].value == "20" 
       || str[i].value == "22" || str[i].value == "42" || str[i].value == "82" || str[i].value == "87"       
       || str[i].value == "88" || str[i].value == "90" || str[i].value == "91" || str[i].value == "93" 
       || str[i].value == "96" || str[i].value == "98"))
     )
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
// Validate
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";
  var selq = false;
  var selnum = 0;
  
  var qtr = new Array();
  for(var i=0; i < document.all.Year.length; i++)
  {
     if(document.all.Year.options[i].selected)
     {
        qtr[qtr.length] = document.all.Year.options[i].value;
     }
  }

  var type = new Array();
  for(var i=0; i < document.all.Type.length; i++)
  {
     if(document.all.Type[i].checked){ type[type.length] = document.all.Type[i].value.trim();  selnum += 1; }
  }
  if(selnum == 0) { error=true; msg += "At least 1 event type must be checked."}
  
  //store
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
  }

  if (error) alert(msg);
  else{ sbmEvtCal(qtr, type, selstr) }
}
//==============================================================================
// submit Event Clendar
//==============================================================================
function sbmEvtCal(qtr, type, str)
{
   var url = "EvtCalLst.jsp?"
   for(var i=0; i < qtr.length; i++) { url += "&Qtr=" + qtr[i]; }
   for(var i=0; i < type.length; i++) { url += "&Type=" + type[i]; }
   for(var i=0; i < str.length; i++) { url += "&Str=" + str[i]; }

   //alert(url);
   window.location.href = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body  onload="bodyLoad();">

<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2" align="center">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Event Calendar - Selection</b><br>

      <table>
      <!-- ----------------------------------------------------------------- -->
      <!-- Year Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td valign="Top">Fiscal Year:</td>
         <td>
            <SELECT name="Year" size="12" multiple="true" class="small"></SELECT>
         </td>
      </tr>

      <!-- ----------------------------------------------------------------- -->
      <!-- Event Type Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr><td style="background:darkred; font-size:1px;" colspan=2>&nbsp;</td></tr>
      <tr>
         <td valign="Top">Event Type:</td>
         <td>             
            <input type="checkbox" id="Type" value="GENERIC" checked> Store Sale Event
            &nbsp;&nbsp;&nbsp; 
            <input type="checkbox" id="Type" value="GRASSROOT" checked> Grassroots/Events
            &nbsp;&nbsp;&nbsp; 
            <input type="checkbox" id="Type" value="TRAINING" checked> Training
            &nbsp;&nbsp;&nbsp; 
            <input type="checkbox" id="Type" value="STROPS" checked> Store Ops
         </td>
      </tr>

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
              <button onclick='checkReg(&#34;BIKE&#34;)' class='Small'>Bike</button> &nbsp; &nbsp;
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

      <!-- ----------------------------------------------------------------- -->
      <!-- Command buttons -->
      <!-- ----------------------------------------------------------------- -->
      <tr><td style="background:darkred; font-size:1px;" colspan=2>&nbsp;</td></tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;
         <button onclick="Validate()">Submit</button>
         <br>Click <a href="javascript: setYear(false)">here</a> to add more quarters/years in selection.
      </tr>
      </table>
      <a href="../"><font color="red" size="-1">Home</font></a>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>