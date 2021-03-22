<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup
     , rciutility.RtvStrGrp, java.sql.*, java.util.*, java.text.*"
%>  

<%
	String [] sSelStr = request.getParameterValues("Str");
	String sFrom = request.getParameter("From");
	String sTo = request.getParameter("To");	
	String [] sSelCol = request.getParameterValues("col");
    
   	
	SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");
   	
   	if(sFrom == null)
   	{   		
   		java.util.Date dtPrior  = new java.util.Date();
   		Calendar c = Calendar.getInstance();
   	    c.setTime(dtPrior);
   	    c.add(Calendar.DAY_OF_MONTH, -364);
   	    dtPrior = c.getTime();   	   	
      	sFrom = smp.format(dtPrior);
    }
   	if(sTo == null)
   	{
		java.util.Date dtPrior  = new java.util.Date(new java.util.Date().getTime() - 24 * 60 * 60 * 1000);
      	sTo = smp.format(dtPrior);
   	}
   	if(sSelCol == null)
    { 
 	   sSelCol = new String[8];
 	   for(int i=0; i < 8; i++){ sSelCol[i] = Integer.toString(i); }		   
    }
 //----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=HC52wkGraph.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   StoreSelect strsel = new StoreSelect();
   String sStrJsa = strsel.getStrNum();
   String sStrNameJsa = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   String sStrRegJsa = strsel.getStrReg();

   String [] sStrDistLst = strsel.getStrDistLst();
   String sStrDistJsa = strsel.getStrDist();
   String [] sStrDistNmLst = strsel.getStrDistNmLst();
   String sStrDistNmJsa = strsel.getStrDistNm();

   String [] sStrMallLst = strsel.getStrMallLst();
   String sStrMallJsa = strsel.getStrMall();
   
   RtvStrGrp rtvstr = new RtvStrGrp();
   String sGrpNmJsa = rtvstr.getGrpJsa();
   String sGrpBtnJsa = rtvstr.getGrpBtnJsa();
   String sGrpStrJsa = rtvstr.getStrJsa();  

   int iSpace = 6;

   if(sSelStr ==null)
   {
      Vector vStr = new Vector();
      for(int i=0; i < iNumOfStr; i++)
      {
         if(!sStrLst[i].equals("55") && !sStrLst[i].equals("89") )
         {
           vStr.add(sStrLst[i]);
         }
      }

      sSelStr = (String [])vStr.toArray(new String[vStr.size()]);;
   }

   String sUser = session.getAttribute("USER").toString();
   
   // format Numeric value
   
   String sPrepStmt = "with weekf as (" 
		+ "select a.piwe as to_week" 
		+ ", (select b.piwe from rci.fsyper b where b.piwe = a.piwe - 364 days and b.pida=b.piwe) as fr_week"
		+ "	From rci.fsyper a"
		+ " where a.pida >= '" + sFrom + "'"
		+ " and a.pida <= '" + sTo + "'"
		+ " group by piwe"
		+ " order by piwe desc"
		+ "),  hcsumf as ("
		+ " select to_week, dec(sum(DCTRF),11,0) as traf" 
		+ ", dec(sum(DCTRAN),11,2) as tran" 
		+ ", dec(sum(DCTOTS),11,2) as sls"
		+ " from rci.Hcdly"
		+ " inner join weekf on date >= fr_week and date <= to_week"
		+ " where str in (";
	String sComma = "";	
	for(int i=0; i< sSelStr.length; i++)
	{
		sPrepStmt += sComma + sSelStr[i];
		sComma = ",";
	}
	sPrepStmt += ")";
		
	sPrepStmt += " group by to_week"
		+ ")"
		+ " select to_week, traf, tran, sls"
		+ ", dec(tran / traf * 100, 11,2) as conv"
		+ ", dec(sls / tran * 100, 11,2) as asp"
		+ " from hcsumf"
		+ " order by to_week" 
	;
   	System.out.println(sPrepStmt);
   	
   	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);
	runsql.runQuery();
	Vector vStore = new Vector();
	Vector vWeek = new Vector();
	Vector vTraf = new Vector();
	Vector vConv = new Vector();
	Vector vTran = new Vector();
	Vector vAsp = new Vector();
	Vector vSls = new Vector();
	String sSvStr = null;
	
	while(runsql.readNextRecord())
	{	
		vWeek.add(runsql.getData("to_week"));
		vTraf.add(runsql.getData("traf"));		
		vConv.add(runsql.getData("conv"));
		vTran.add(runsql.getData("tran"));
		vAsp.add(runsql.getData("asp"));
		vSls.add(runsql.getData("sls"));		
	}
	runsql.disconnect();
	runsql = null;	
	
	String [] sWeek = (String []) vWeek.toArray(new String[vWeek.size()]);
	String [] sTraf = (String []) vTraf.toArray(new String[vTraf.size()]);
	String [] sConv = (String []) vConv.toArray(new String[vConv.size()]);
	String [] sTran = (String []) vTran.toArray(new String[vTran.size()]);
	String [] sAsp = (String []) vAsp.toArray(new String[vAsp.size()]);
	String [] sSls = (String []) vSls.toArray(new String[vSls.size()]);
	
	
	CallAs400SrvPgmSup as4pgm = new CallAs400SrvPgmSup();
   	String sWeekJsa = as4pgm.cvtToJavaScriptArray(sWeek);
   	String sTrafJsa = as4pgm.cvtToJavaScriptArray(sTraf);
   	String sConvJsa = as4pgm.cvtToJavaScriptArray(sConv);
   	String sTranJsa = as4pgm.cvtToJavaScriptArray(sTran);
   	String sAspJsa = as4pgm.cvtToJavaScriptArray(sAsp);
   	String sSlsJsa = as4pgm.cvtToJavaScriptArray(sSls);
   	String sSelStrJsa = as4pgm.cvtToJavaScriptArray(sSelStr);
   	String sSelColJsa = as4pgm.cvtToJavaScriptArray(sSelCol);
   	as4pgm = null;   	
	
 %>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<title>HeadCount-52 Week</title>
<!-- =============== Style ================================= -->
<style>
  .hdr01 {font-size:18px;font-weight:bold;}
  .hdr02 {font-size:14px;font-weight:bold;}
  .TYLegend01 {font-size:12px;background: #BD0E0E;}
  .TYLegend02 {font-size:12px;background: #DCDCDC;}
  .TYLegend03 {font-size:12px;background: #2CF762;}  
  
  .box {border:2px solid #0094ff;}
  .box h2 {background:#0094ff;color:white;padding:10px;}
  .box p {color:#333;padding:10px;}
  .box {
    -moz-border-radius-topright:5px;
    -moz-border-radius-topleft:5px;
    -webkit-border-top-right-radius:5px;
    -webkit-border-top-left-radius:5px;
    border-radius:5px;    
   }
   
   div.dvSelect { position:absolute; background-attachment: scroll;
              border: #e7e7e7 ridge 5px; width:auto; background-color:LemonChiffon; z-index:auto;
              text-align:center; font-size:12px
    	-moz-border-radius-topright:8px;
    	-moz-border-radius-topleft:8px;
    	-webkit-border-top-right-radius:8px;
    	-webkit-border-top-left-radius:8px;
    	border-radius:8px;              
    }
   
   td.BoxName {background: linear-gradient(to bottom, MidnightBlue , #a0cfec);              
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}              
   table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; }
   table.tbl02 { border:#e7e7e7 ridge 2px; padding: 0px; border-spacing: 0; border-collapse: collapse; }
   
   td.td01 { text-align:right; vertical-align:middle; font-family:Arial; font-size:10px; }
   td.td02 { text-align:left; vertical-align:middle; font-family:Arial; font-size:10px; } 
   td.td03 { text-align:center; vertical-align:middle; font-family:Arial; font-size:10px; }
   
   td.Separator01 { border-top: #EFFBEF ridge 2px; font-size:1px; }
   td.Separator02 { background: salmon ridge px; font-size:1px; }     
   
   .Small {font-size:10px; text-align:left;}
   .Small1 {font-size:10px; text-align:center;}
   .Medium {font-size:12px }
   .Medium1 {font-size:12px; font-weight:bold; }
   
   select.Small {margin-top:3px; font-family:Arial; font-size:10px }
   input.Small {margin-top:3px; font-family:Arial; font-size:10px }
   button.Small {margin-left:0px; margin-right:0px; margin-top:3px; font-family:Arial; font-size:10px }   
      
  </style>
<!-- =============== end of Style ================================= -->
<script type="text/javascript" src="scripts/Chart.js-master/Chart.js"></script>



<script>
//==========================================================================
//global varaibles
//==========================================================================
var ArrWeek = [<%=sWeekJsa%>];
var ArrTraf = [<%=sTrafJsa%>];
var ArrConv = [<%=sConvJsa%>];
var ArrTran = [<%=sTranJsa%>];
var ArrAsp = [<%=sAspJsa%>];
var ArrSls = [<%=sSlsJsa%>];

var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];
var ArrGrpNm = [<%=sGrpNmJsa%>];
var ArrGrpBtn = [<%=sGrpBtnJsa%>];
var ArrGrpStr = [<%=sGrpStrJsa%>];

var ArrSelStr = [<%=sSelStrJsa%>];
var ArrSelCol = [<%=sSelColJsa%>];

var FrDate = "<%=sFrom%>";
var ToDate = "<%=sTo%>";

// graph data and options
var data = {
	    labels: [],
	    datasets: [
	        {
	        	label: "This",
	            fillColor: "rgba(189,14,14,0.2)",
	            strokeColor: "rgba(189,14,14,1)",
	            pointColor: "rgba(189,14,14,1)",
	            pointStrokeColor: "#fff",
	            pointHighlightFill: "#fff",
	            pointHighlightStroke: "rgba(151,187,205,1)",
	            data: []
	        },
	        {
	            label: "Goal",
	            fillColor: "rgba(44,247,98,0.2)",
	            strokeColor: "rgba(44,247,98,1)",
	            pointColor: "rgba(44,247,98,1)",
	            pointStrokeColor: "#fff",
	            pointHighlightFill: "#fff",
	            pointHighlightStroke: "rgba(151,187,205,1)",
	            data: []
	        },
	    ]
	};

var options = {
    scaleShowGridLines : true,
    scaleGridLineColor : "rgba(0,0,0,.05)",
    scaleGridLineWidth : 1,
    bezierCurve : true,
    bezierCurveTension : 0.4,
    pointDot : true,
    pointDotRadius : 4,
    datasetStroke : true,	    
    datasetStrokeWidth : 2,
    datasetFill : true
};


//==========================================================================
// initial process
//==========================================================================
function bodyload()
{
	if(ArrSelCol.indexOf("0") >= 0){ drawGraph(ArrWeek, ArrTraf, 'Chart01', ["205","52","22"] ); }
	else{ document.all.dvBox01.style.display = "none"; }
	if(ArrSelCol.indexOf("1") >= 0){ drawGraph(ArrWeek, ArrTran, 'Chart02', ["44","247","98"] ); }
	else{ document.all.dvBox02.style.display = "none"; }
	if(ArrSelCol.indexOf("2") >= 0){ drawGraph(ArrWeek, ArrSls, 'Chart03', ["22","95","205"] ); }
	else{ document.all.dvBox03.style.display = "none"; }
	if(ArrSelCol.indexOf("3") >= 0){ drawGraph(ArrWeek, ArrConv, 'Chart04', ["255","128","0"] ); }
	else{ document.all.dvBox04.style.display = "none"; }
	if(ArrSelCol.indexOf("4") >= 0){ drawGraph(ArrWeek, ArrAsp, 'Chart05', ["64","205","22"] ); }
	else{ document.all.dvBox05.style.display = "none"; }
	
	setSelectPanelShort(); 
}


//==============================================================================
//set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
	var space = ""; for(var i=0; i < 8;i++){space = "&nbsp;"; }
	
	var hdr = space + "Select Report Parameters" + space;

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  	+ "<tr>"
    	+ "<td class='BoxName' nowrap>" + hdr + "</td>"
    	+ "<td class='BoxName' valign=top>"
      		+  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
    	+ "</td></tr>"
	html += "<tr><td class='td01' colspan=2>"
	html += "</td></tr></table>"

	document.all.dvSelect.innerHTML=html;
	document.all.dvSelect.style.pixelLeft= document.documentElement.scrollLeft + 500;
	document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 10;	
}

//==============================================================================
//set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
	var hdr = "Select Report Parameters";

	var html = "<table class='tbl01'>"
	    + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	      + "<td class='BoxName' valign=top>"
	        +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
	      + "</td></tr>"
	html += "<tr><td class='td01' colspan=2>"
	   
	html += popSelWk();

	html += "</td></tr></table>"
	document.all.dvSelect.innerHTML=html;
	
	setInitStrSel();	
	setInitDateSel();
	setInitColSel();	
}	
//==============================================================================
//populate Column Panel
//==============================================================================
function popSelWk()
{
	var panel = "<table class='tbl02'>"
	    + "<tr>"
	       + "<td class='td02' colspan=3><u>Stores</u></td>"
	     + "</tr>"
	     + "<tr>"
	       + "<td class='td02' colspan=3>"
	          + "<table class='tbl01'>"
	              + "<tr>"

	  for(var i=1, j=0; i < ArrStr.length; i++, j++)
	  {
	     if(j > 0 && j % 17 == 0){ panel += "<tr>"}
	     panel += "<td class='Small' nowrap>"
	          + "<input type='checkbox' class='Small' name='Str' value='" + ArrStr[i] + "'>" + ArrStr[i]
	        + "</td>"
	  }

	  
	  var space = " &nbsp; &nbsp;";            
	  panel += "</table>"
	          + space + "<button onclick='checkAll(true)' class='Small'>All</button>"
	          + space + "<button onclick='checkAll(false)' class='Small'>Reset</button>";
	  
	  
	  // add store group buttons
	  for(var i=0; i < ArrGrpNm.length; i++)
	  {
		  if(ArrGrpBtn[i]=="Mall (7)") { panel += "<br>"; } 
		  else if(ArrGrpBtn[i]=="All Brick & Mortar") { panel += "<br>"; } 
		  panel += space + "<button onclick='checkStrGrp(&#34;" + ArrGrpNm[i] + "&#34;,&#34;" + ArrGrpBtn[i] + "&#34;, this)' class='Small'>" + ArrGrpBtn[i] + "</button>"
		   
	  }
	  
	  panel += "<br>Note: Clicking the Store Group button more than once, toggles to INCLUDE or EXCLUDE the stores in this group." 
	          
	  panel += "</td>"
	    + "</tr>"
	     
	    + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
	     
	    + "<tr id='trDt2' style='background:azure'>"
	       + "<td class='td01' id='td2Dates'>&nbsp;&nbsp;&nbsp;&nbsp;</td>"
	       + "<td class='td01' id='td2Dates'>From:</td>"
	       + "<td class='td02' id='td2Dates'>"
	       	  + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;, &#34;YEAR&#34;)'>-y</button>"
	          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;, &#34;WEEK&#34;)'>-w</button>"
	          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;, &#34;DAY&#34;)'>-d</button>"
	          + "<input name='From' class='Small' size='10' >"
	          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;, &#34;DAY&#34;)'>d+</button>"
	          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;, &#34;WEEK&#34;)'>w+</button>"
	          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;, &#34;YEAR&#34;)'>y+</button>"
	          + " &nbsp; <a href='javascript:showCalendar(1, null, null, 450, 170, document.all.From)'>"
	          + "<img src='calendar.gif' alt='Calendar td01' width='34' height='21'></a></td>"	       
	    + "</tr>"
	    + "<tr id='trDt2' style='background:azure'>"
	       + "<td class='td01' id='td2Dates'>&nbsp;</td>"
	       + "<td class='td01' id='td2Dates'>To:</td>"
	       + "<td class='td02' id='td2Dates' >"
	          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;To&#34;)'>&#60;</button>"
	          + "<input name='To' class='Small' size='10' >"
	          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;To&#34;)'>&#62;</button>"       
	          + " &nbsp; <a href='javascript:showCalendar(1, null, null, 450, 250, document.all.To)'>"
	              + "<img src='calendar.gif' alt='Calendar td01' width='34' height='21'></a></td>"
	     + "</tr>"
	    
	     + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
	   
	     + "<tr style='background:#ccffcc'>"
	       + "<td class='td01' colspan=3>"      
	          + "<table class='tbl01'>"
	          
	          + "<tr><td class='Small1' nowrap colspan='2'>Selected Groups:"
	          			+ "<button onclick='chkColAll(true)' class='Small'>All</button> &nbsp; &nbsp;"
	          			+ "<button onclick='chkColAll(false)' class='Small'>Reset</button>"            
	        		+ "</td>"
	             + "<td class='Small' nowrap><input type='checkbox' class='Small' name='SelCol' value='0'>Trafic</td>"
	             + "<td class='Small' nowrap><input type='checkbox' class='Small' name='SelCol' value='1'>Conversion Rate</td>"
	             + "<td class='Small' nowrap><input type='checkbox' class='Small' name='SelCol' value='2'>Transactions</td>"
	             
	          + "</tr>"
	          + "<tr><td class='Small' nowrap colspan='2'>&nbsp;</td>" 
		          + "<td class='Small' nowrap><input type='checkbox' class='Small' name='SelCol' value='3'>Avg Sales Price</td>"   
		          + "<td class='Small' nowrap><input type='checkbox' class='Small' name='SelCol' value='4'>Tot Sales</td>"
              + "</tr>"	          
	        + "</table>"          

	      + "</tr>"
	      + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
	      
	  panel += "<tr><td class='td03' colspan=3>"
	        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
	        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

	  panel += "</table>";

	  return panel;
}
//==============================================================================
//Validate entry
//==============================================================================
function Validate()
{
	var error = false;
	var msg = "";
	var br = "";

	// get selected stores
	var str = document.all.Str;
	var selstr = new Array();
	var numstr = 0
	for(var i=0; i < str.length; i++)
	{
  		if(str[i].checked){ selstr[numstr] = str[i].value; numstr++;}
	}
	if (numstr == 0){ error=true; msg+="At least 1 store must be selected."; br = "<br>";}

	// get date
	var selFrom = " ";
	var selTo = " ";
	selFrom = document.all.From.value.trim();
	selTo = document.all.To.value.trim();
	
	// get selected columns
	var col = document.all.SelCol;
	var selcol = new Array();
	var numcol = 0
	for(var i=0; i < col.length; i++)
	{
  		if(col[i].checked){ selcol[numcol] = col[i].value; numcol++;}
	}
	if (numcol == 0){ error=true; msg+="At least 1 column must be selected."; br = "<br>";}

	if(error){alert(msg)}
	else{ submitForm(selstr, selFrom, selTo, selcol); }
}
//==============================================================================
//change action on submit
//==============================================================================
function submitForm(selstr, selFrom, selTo, selcol)
{
	var url;
	url = "HC52wkGraph.jsp?From=" + selFrom + "&To=" + selTo;
	for(var i=0; i < selstr.length; i++) { url += "&Str=" + selstr[i]; }
	for(var i=0; i < selcol.length; i++){ url += "&col=" + selcol[i]; }   
	
	//alert(url);
	window.location.href=url;
}
//==============================================================================
//check all stores
//==============================================================================
function checkAll(chk)
{
	var str = document.all.Str

	for(var i=0; i < str.length; i++)
	{
	  str[i].checked = chk;
	}
}
//==============================================================================
//check all columns
//==============================================================================
function chkColAll(chk)
{
	var col = document.all.SelCol;
	for(var i=0; i < col.length; i++){ col[i].checked = chk; }
}	
//==============================================================================
//check by regions
//==============================================================================
function checkStrGrp(grp, btn, obj)
{
var str = document.all.Str
var chk1 = false;
var chk2 = false;

// find location of clicked button in store group array
var argg = -1;
for(var i=0; i < ArrGrpNm.length; i++)
{
   if(ArrGrpNm[i]==grp){argg=i; break;}
}  

// check 1st selected group check status and save it
var find = false;
for(var i=0; i < str.length; i++)
{
  for(var j=0; j < ArrGrpStr[argg].length; j++)
  {    	
     if(str[i].value == ArrGrpStr[argg][j])
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
  for(var j=0; j < ArrGrpStr[argg].length; j++)
  {
 	var s = str[i].value;
  	var g = ArrGrpStr[argg][j];
 	if(str[i].value == ArrGrpStr[argg][j])
     {
        str[i].checked = chk1;           
        break;
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
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id, type)
{
var button = document.all[id];
var date = new Date(button.value);
if (type == "DAY")
{	
	if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
	else if(direction == "UP") date = new Date(new Date(date) - -86400000);
}
else if (type == "WEEK")
{	 
	if(direction == "DOWN") date = new Date(new Date(date) - (7) * 86400000);
	else if(direction == "UP") date = new Date(new Date(date) - (-7) * 86400000);
}
else if (type == "YEAR")
{	
	var year = date.getFullYear();
	if(direction == "DOWN") date = new Date(new Date(date.setFullYear(eval(year) - 1)));
	else if(direction == "UP") date = new Date(new Date(date.setFullYear(eval(year) + 1)));
}

button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
//set initial store selection
//==============================================================================
function setInitStrSel()
{
	var str = document.all.Str;
	for(var i=0; i < str.length; i++)
	{
	   for(var j=0; j < ArrStr.length; j++)
	   {
	      if(str[i].value == ArrSelStr[j]){ str[i].checked = true;}
	      else{ str[i].checked == false; }
	   }
	}
}
//==============================================================================
//set initial date selection
//==============================================================================
function setInitDateSel()
{
	document.all.From.value = FrDate;
    document.all.To.value = ToDate;
	
	// set date selection to last date
	//date = new Date(new Date() - 24*60*60*1000)	
	//document.all.From.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() 
    //document.all.To.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() 
}
//==============================================================================
//set initial column selection
//==============================================================================
function setInitColSel()
{
	// checked selected columns
	var col = document.all.SelCol;
	for(var i=0; i < col.length; i++)
	{
	   for(var j=0; j < ArrSelCol.length; j++)
	   {
	      if(col[i].value == ArrSelCol[j]){ col[i].checked = true;}
	      else{ col[i].checked == false; }
	   }
	}
}

//==========================================================================
//initial process
//==========================================================================
function drawGraph(xVal, yVal, canvas, color)
{
	// marks on axsel X
	for(var i=0; i < xVal.length; i++){ data.labels[i] = xVal[i]; }
	// data for  axsel Y
	for(var i=0; i < yVal.length; i++){ data.datasets[0].data[i] = yVal[i]; }
	
	data.datasets[0].fillColor = "rgba(" + color[0] + "," + color[1] + "," + color[2] + ",0.2)";
	data.datasets[0].strokeColor = "rgba(" + color[0] + "," + color[1] + "," + color[2] + ",1)";
	data.datasets[0].pointColor = "rgba(" + color[0] + "," + color[1] + "," + color[2] + ",1)";
	
	var ctx = document.getElementById(canvas).getContext("2d");      
	var myLineChart = new Chart(ctx).Line(data, options);
}

</script>
<script src="String_Trim_function.js"></script>
<script src="MoveBox.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>


<HTML><HEAD>

</HEAD>
<BODY onload="bodyload()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->

<span class="hdr01">Headcount Summary - 52 Week Statistics</span><br>
<span class="hdr02">From: <%=sFrom%> &nbsp; To: <%=sTo%></span><br>
<span class="hdr02"></span><br>

<div class="box" id="dvBox01">
    <h2>Traffic</h2>    
	<canvas id="Chart01" width="1200" height="600"></canvas>
</div><br>
<div class="box" id="dvBox02">
    <h2>Transactions</h2>
	<canvas id="Chart02" width="1200" height="600"></canvas>
</div><br>
<div class="box" id="dvBox03">
    <h2>Sales</h2>
	<canvas id="Chart03" width="1200" height="600"></canvas>
</div><br>
<div class="box" id="dvBox04">
    <h2>Conversion</h2>
	<canvas id="Chart04" width="1200" height="600"></canvas>
</div><br>
<div class="box" id="dvBox05">
    <h2>Average Sales Price</h2>
	<canvas id="Chart05" width="1200" height="600"></canvas>
</div><br>
</BODY></HTML>
<%}%>








