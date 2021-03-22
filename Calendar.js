 document.write("<style>");
 document.write("table.CalTbl { background:cornsilk; border: black solid 1px;text-align:center; font-size:10px;z-index:4;}");
 document.write("th.CalTbl { background: lightgrey; border-bottom: black solid 1px; font-size:10px}");
 document.write("th.CalTbl1 { border-bottom: black solid 1px; font-size:10px}");
 document.write("td.CalTbl { cursor:hand; color:blue; background: white; font-size:10px}");
 document.write("a:hover.acal { background: lightsalmon; text-decoration: none}");
 document.write("a:link.acal { color: blue; text-decoration: none}");
 document.write("a:visited.acal { color: blue; text-decoration: none}");
 document.write(".selMoYr { display: none; font-size:10px}");
 document.write("</style>")

 var leftX = 1;
 var topY = 1;
 var element = 0
 var rtnFld = null;
 var Append = false;
 var MonDates = new Array();
 var NumDates = 0;
 var Closed = new Array();
 var ChkDates = false;
 var Closed_dates_URL = null;
 var Closed_dates_Available = false;
 
 var isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
//Firefox 1.0+
var isFirefox = typeof InstallTrigger !== 'undefined';
//Safari 3.0+ "[object HTMLElementConstructor]" 
var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || safari.pushNotification);
//Internet Explorer 6-11
var isIE = /*@cc_on!@*/false || !!document.documentMode;
//Edge 20+
var isEdge = !isIE && !!window.StyleMedia;
//Chrome 1+
var isChrome = !!window.chrome && !!window.chrome.webstore;
//Blink engine detection
var isBlink = (isChrome || isOpera) && !!window.CSS;
//==============================================================================
// show Calendar - replace value
//==============================================================================
function showCalendar(e, mon, year, l, t, obj, append, closed_dates_URL, closed_dates_Available){
  rtnFld = obj;
  leftX = l;
  topY = t;
  element = e;
  MonDates = new Array();
  NumDates = 0;
  Closed = new Array();
  Closed_dates_URL = null;
  Closed_dates_Available = false;

  if(append != null && append) Append = append;

  var newDiv = document.getElementById("CalendarMenu")

  if(newDiv==null)
  {
      newDiv  = document.createElement('div');
      newDiv.id="CalendarMenu"
      document.body.appendChild(newDiv);
  }

  document.all.CalendarMenu.innerHTML=CrtCalendar(mon, year)
  document.all.CalendarMenu.style.position="absolute";
  document.all.CalendarMenu.style.backgroundColor = "LemonChiffon"
	  
	  
  if(isIE)
  {	  
	  document.all.CalendarMenu.style.pixelLeft=leftX;
	  document.all.CalendarMenu.style.pixelTop=topY;   
  }
  else if(isChrome || isEdge) 
  {
	  document.all.CalendarMenu.style.left=leftX;
	  document.all.CalendarMenu.style.top=topY;
  }	 
  else if(isSafari) 
  {    
	  document.all.CalendarMenu.style.left=leftX;
	  document.all.CalendarMenu.style.top=topY;
  }	 
  document.all.CalendarMenu.style.zIndex = "99";

  if (closed_dates_URL != null)
  {
     Closed_dates_URL = closed_dates_URL;
     Closed_dates_Available = closed_dates_Available;
     check_Closed_Dates();
  }

  document.all.CalendarMenu.style.visibility="visible"
}

//==============================================================================
// hide panel
//==============================================================================
function hidetip2()
{   
  /*if (document.all)
    document.all.CalendarMenu.style.visibility="hidden"
    else if (document.layers)
    {
      clearInterval(currentscroll)
      document.CalendarMenu.visibility="hidden"
    }*/
	
	document.all.CalendarMenu.style.visibility="hidden";
}
//==============================================================================
// Creat Calendar
//==============================================================================
function CrtCalendar(mon, year){
  var todate = new Date();

  if (mon == null){
     mon = todate.getMonth();
     year = todate.getFullYear();
  }
  
  var bdate = new Date(year, mon, "01");
  
  //console.log(" " + year + " - " + mon + " - " + bdate);
  
  var weekday;
  var first = true;
  var text = "<table class='CalTbl' border=2>"
           + popHeader(bdate.getMonth(), bdate.getFullYear());

  while(mon == bdate.getMonth()){
     weekday = bdate.getDay();
    // next line
    if (weekday == 0 || first){
       text = text + "<tr>";
    }

    text = text + popTable(bdate, first, weekday);

    first = false;

    if (weekday == 6){
      text = text + "</tr>";
    }

   //Next Date
    bdate.setDate(bdate.getDate() + 1);
  }
  text = text + "<tr><th colspan=7><a  class='acal' href='javascript:hidetip2()'><font size='2'>Cancel</font></a></th></tr>";
  text = text + "</table>";

  return text;
}
//==============================================================================
// populate table headings
//==============================================================================
function popHeader(mon, year){
  var text
  var aMon = new Array("January","February","March","April","May","June", "July",
                       "August", "September", "October", "November", "December");


  var prv = new Date(year, mon-1, "01");
  var fut = new Date(year, mon+1, "01");
  var prvMon = prv.getMonth();
  var futMon = fut.getMonth();
  var prvYr = prv.getFullYear();
  var futYr = fut.getFullYear();

  text = "<table>  <tr>"
       + "<th class='CalTbl'><a class='acal' href='javascript:showCalendar("
       + element + "," + prvMon + "," + prvYr + "," + leftX + "," + topY
       + ", rtnFld, null, Closed_dates_URL, Closed_dates_Available)'><img src='left.gif' alt='Previous month' style='border=none' width=15 height=10></a></th>"
       
       + "<th class='CalTbl' colspan='5'>"
          + "<a href='javascript: setMonSel(&#34;M&#34;,&#34;" + aMon[mon] + "&#34;,&#34;" + year + "&#34;)'>" + aMon[mon] + "</a>"
          
          + "&nbsp;<a href='javascript: setMonSel(&#34;Y&#34;,&#34;" + aMon[mon] + "&#34;,&#34;" + year + "&#34;)'>" + year + "</a>"
          
          + "<br><select name='selMonYr' class='selMoYr' onchange='setMonYr(this)'></select>"
       + "</th>"
       
       + "<th class='CalTbl'>"
       + "<a class='acal' href='javascript:showCalendar(" + element + "," + futMon + "," + futYr + ","
       + leftX + "," + topY + ", rtnFld, null, Closed_dates_URL, Closed_dates_Available)'><img src='right.gif' style='border=none' alt='Next month' width=15 height=10></a></th>"
       + "</tr>"
       + "<tr><th  class='CalTbl1'>Su</th><th class='CalTbl1' >Mo</th><th class='CalTbl1'>Tu</th><th class='CalTbl1'>We</th><th class='CalTbl1'>Th</th><th class='CalTbl1'>Fr</th><th class='CalTbl1'>Sa</th></tr>"

  return text;
}
//==============================================================================
// populate table details
//==============================================================================
function popTable(bdate, first, weekday){
var text = " "
var date = bdate.getDate()

  if (first == true){
     for(i=0; i < weekday; i++){
        text = text + "<td class='CalTbl'></td>"
     }
  }

  if (bdate.getDate() < 10 ){
     date = "&nbsp;" + bdate.getDate()
  }
  
  var mdy = (bdate.getMonth() + 1) + "/" + bdate.getDate() + "/" + bdate.getFullYear();
  text = text + "<td class='CalTbl' id='tdDate' onClick='sentValue(&#39;" + mdy + "&#39;, this)'>"
       + date + "</td>";
  MonDates[NumDates] = mdy;
  Closed[NumDates++] = false;

  return text;
}
//==============================================================================
// check if current date is closed for selection or available
//==============================================================================
function check_Closed_Dates()
{
   var url = Closed_dates_URL + "?";

   for(var i=0; i < NumDates; i++)
   {
      url += "&chkdt=" + MonDates[i];
   }

   //alert(Closed_dates_URL)
   //window.location.href=url;
   window.frameChkCalendar.location.href=url;
}
//==============================================================================
// marked Closed date as unavailable
//==============================================================================
function markClosed(closed)
{
   dates = document.all.tdDate;
   for(var i=0; i < closed.length; i++)
   {
      dates[closed[i]].style.color="white";
      dates[closed[i]].style.backgroundColor="lightgrey";
      dates[closed[i]].style.cursor="text";
      ChkDates = true;
      Closed[closed[i]] = true;
   }

   //window.frameChkCalendar.location.href=null;
   window.frameChkCalendar.close();
}
//==============================================================================
// return value to selected field
//==============================================================================
function sentValue(selDate, selCell){
  // check if date is not closed
  if (!Closed_dates_Available && selCell.style.color=="white") { return; }

  if (rtnFld != null)
  {
     if(Append) { rtnFld.value += selDate; }
     else { rtnFld.value = selDate; }
  }
  else
  {

    if (document.forms[0] != null && document.forms[0].selDate != null)
    {
       if(Append) { document.forms[0].selDate.value += selDate; }
       else { document.forms[0].selDate.value = selDate; }
    }
  }
  hidetip2();
}
//==============================================================================
// show month selection 
//==============================================================================
function setMonSel(type, mon, year)
{
	var sel = document.all.selMonYr;
	
	var aMon = new Array("January","February","March","April","May","June", "July",
            "August", "September", "October", "November", "December");
	var date = new Date()
	var begyr = date.getFullYear() + 1;
	
	// clear selection
	while(sel.options.length > 0)
	{
		sel.options[sel.options.length-1] = null;
	}
	 
	sel.style.display = "block";
	
	if(type=="M")
	{
		for(var i=0; i < aMon.length; i++)
		{
			sel.options[i] = new Option(aMon[i], i + "|" + year);
			if(mon==aMon[i]){ sel.selectedIndex=i; }
		}
	}
	else
	{
		// find current month number
		var monid = "0";
		for(var i=0; i < aMon.length; i++)
		{		
			if(mon==aMon[i]){ monid=i; break;}
		}
		 
		for(var i=0; i < 5; i++)
		{
			var optyr = begyr-i;
			sel.options[i] = new Option(optyr, monid + "|" + optyr);
			if(year==optyr){ sel.selectedIndex=i; }
		}
	}	
}


//==============================================================================
//show month selection 
//==============================================================================
function setMonYr(sel)
{
	
	var selid = sel.selectedIndex;
	var monyr = sel.options[selid].value;
	
	 
	var amonyr = monyr.split("|"); 
		
	showCalendar(element, amonyr[0], amonyr[1], leftX, topY
			, rtnFld, null, Closed_dates_URL, Closed_dates_Available);
}







