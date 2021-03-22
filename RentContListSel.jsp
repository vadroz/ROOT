<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, rciutility.StoreSelect, java.sql.*
, rciutility.CallAs400SrvPgmSup, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null )
{
     response.sendRedirect("SignOn1.jsp?TARGET=RentContListSel.jsp&APPL=ALL");
}
else
{

      StoreSelect StrSelect = null;
      String sStrAllowed = session.getAttribute("STORE").toString();
      String sUser = session.getAttribute("USER").toString();

      if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
        StrSelect = new StoreSelect(27);
      }
      else
      {
         Vector vStr = (Vector) session.getAttribute("STRLST");
         String [] sStrAlwLst = new String[ vStr.size()];
         Iterator iter = vStr.iterator();

         int iStrAlwLst = 0;
         while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

         if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
         else StrSelect = new StoreSelect(new String[]{sStrAllowed});
      }

      String [] sStrAlw = StrSelect.getStrLst();
      
      String sStmt = "select pyr# as year from rci.fsyper where pida=current date";
	   
	  ResultSet rslset = null;
	  RunSQLStmt runsql = new RunSQLStmt();
	  runsql.setPrepStmt(sStmt);		   
	  runsql.runQuery();
			  
	  String sFiscYr = null; 
	  if(runsql.readNextRecord()){ sFiscYr = runsql.getData("year"); }
%>
<title>Rental Contract List</title>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  table.tbl01 {border-top: darkred solid 2px; margin-left: auto; margin-right: auto; 
         text-align:center; vertical-align:top;
         padding: 0px; border-spacing: 0; font-size:12px; }
         
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
  td.Cell3 {border-top: grey solid 1px; margin-left: auto; margin-right: auto; 
         text-align:center; vertical-align:top;
         padding: 0px; border-spacing: 0; font-size:12px; }
  td.Cell4 {font-size:12px; text-align: center; vertical-align:top}
  td.Cell5 { border: grey solid 1px; background: #c8e0d1; margin-left: auto; margin-right: auto; 
         text-align:center; vertical-align:top;
         padding-left: 15px; padding-right: 15px; border-spacing: 0; 
         font-size:14px; font-weight: bold; }
  td.Cell6 {font-size:12px; text-align:center; vertical-align:top}
   
  div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;              
              border: #e7e7e7 ridge 5px; width:auto; background-color:LemonChiffon; z-index:auto;
              text-align:center; font-size:12px;
        border-top-left-radius:8px; border-top-right-radius:8px; 
        border-bottom-left-radius:8px;border-bottom-right-radius:8px; 
    	-moz-border-radius-topright:8px;
    	-moz-border-radius-topleft:8px;
    	-webkit-border-top-right-radius:8px;
    	-webkit-border-top-left-radius:8px;     	           
  }

  div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }

 div.dvHelp { position:absolute;border: none;text-align:center; width: 50px;height:50px; 
     top: 0; right: 50px; font-size:11px; white-space: nowrap;}
  
    
  a.helpLink { background-image:url("/scripts/Help02.png"); display:block;
     height:50px; width:50px; text-indent:-9999px; }
     


  tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; top: expression(this.offsetParent.scrollTop-3);}
  tr.TblRow { background:wite; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle; font-size:11px }
  th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-left: black solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable3 { background:white;padding-top:3px; padding-bottom:3px;
                        text-align:left; ; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable4 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px; vertical-align:top; }
        tr.DataTable41 { background:#ccccff; color: darkred; font-family:Arial; font-size:12px; vertical-align:top; }
        tr.DataTable5 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable6 { background: lightpink; font-family:Arial; font-size:10px }
        tr.DataTable7 { background: #cccfff; font-family:Arial; font-size:10px }
        tr.DataTable8 { background: #ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}

        td.DataTable3 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable31 { border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;} 

  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  </style>
  
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<script name="javascript">
var SelGrp = null;
var FiscYr = "<%=sFiscYr%>";
var StrArr = new Array();

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], [ "dvStatus"]);
	
  	document.all.tdDate3.style.display="block";
  	document.all.tdDate4.style.display="none";
  	document.all.tdDate5.style.display="block";
  
  	document.all.tdDate6.style.display="block";
  	document.all.tdDate7.style.display="none";
 	document.all.tdDate8.style.display="block";
  
  	showDates(3);
  	showAllOpnDates(2)
  
  
  	document.getElementById("tbody1").style.display="none"
}
//==============================================================================
// set sport
//==============================================================================
function setSport()
{
	document.getElementById("tbody1").style.display="block"
	var grp = document.all.Group;
	
	var rent = document.all.RorL;
	rent[0].checked = true;
	rent[1].checked = false;
	rent[2].checked = false;
	var str = document.all.Str;
		
	if(grp[1].checked )
	{			
		rent[1].style.visibility = "hidden";
		rent[2].style.visibility = "hidden";
		// make only store 28 visible
		for(var i=0; i < str.length; i++)
		{
			if(str[i].value == "28" ){ str[i].style.visibility = "visible"; str[i].checked = true;}
			else{ str[i].style.visibility = "hidden"; str[i].checked = false;}
		}
		SelGrp = "WATER";
	}
	else if(grp[0].checked )
	{
		rent[1].style.visibility = "visible";
		rent[2].style.visibility = "visible";
		// make only store 28 visible
		for(var i=0; i < str.length; i++)
		{
			if(str[i].value == "28" )
			{ 
				str[i].style.visibility = "hidden"; 
				str[i].checked = false;
			}
			else
			{ 
				str[i].style.visibility = "visible";
				str[i].checked = true;  
			}
		}
		SelGrp = "SKI";
	}
	if(grp[2].checked )
	{			
		rent[1].style.visibility = "hidden";
		rent[2].style.visibility = "hidden";
		// make only store 28 visible
		// make only store 28 visible
		for(var i=0; i < str.length; i++)
		{
			if(str[i].value == "28" )
			{ 
				str[i].style.visibility = "hidden"; 
				str[i].checked = false;
			}
			else
			{ 
				str[i].style.visibility = "visible";
				str[i].checked = true;  
			}
		}
		SelGrp = "BIKE";
	}	
	else if(grp[3].checked )
	{
		rent[1].style.visibility = "visible";
		rent[2].style.visibility = "visible";
		// make only store 28 visible
		for(var i=0; i < str.length; i++)
		{
			str[i].style.visibility = "visible";
			str[i].checked = true;
		}
		SelGrp = "ALL";
	}
	
	
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
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
     document.all.tdDate5.style.display="none"
   }
   
   doSelDate(type)
   showAllOpnDates(2)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   document.all.tdDate3.style.display="block";   
   document.all.tdDate4.style.display="none";
   document.all.tdDate5.style.display="block";
   document.all.FrDate.value = "ALLDATES";
   document.all.ToDate.value = "ALLDATES";
}
//==============================================================================
//show date selection
//==============================================================================
function showOpnDates(type)
{
	if(type==1)
	{
  		document.all.tdDate1.style.display="none"
  		document.all.tdDate2.style.display="block"
	}
	else
	{
  		document.all.tdDate6.style.display="none"     
  		document.all.tdDate7.style.display="block"
  		document.all.tdDate8.style.display="none"
	}
	
	doSelOpnDate(type)
	showAllDates(2);
}
//==============================================================================
//show optional date selection button
//==============================================================================
function showAllOpnDates(type)
{
document.all.tdDate6.style.display="block";   
document.all.tdDate7.style.display="none";
document.all.tdDate8.style.display="block";
document.all.FrOpnDate.value = "ALLDATES";
document.all.ToOpnDate.value = "ALLDATES";
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
      
  df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  
  //var year = date.getFullYear();
  if(type==3)
  {  
	  df.FrDate.value = "4/16/" + (FiscYr - 1);
	  df.ToDate.value = "4/15/" + FiscYr;
  } 
  if(type==4)
  {  
	  var prioryr = FiscYr - 1;
	  df.FrDate.value = "4/16/" + (prioryr - 1);
	  df.ToDate.value = "4/15/" + (FiscYr - 1);	  
  } 
   
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function doSelOpnDate(type)
{
	var df = document.all;
	var date = new Date(new Date() - 86400000);
   
	df.FrOpnDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();	
	df.ToOpnDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

	//var year = date.getFullYear();
	if(type==3)
	{  
	  df.FrOpnDate.value = "4/16/" + (FiscYr - 1);
	  df.ToOpnDate.value = "4/15/" + FiscYr;
	} 
	if(type==4)
	{
		var prioryr = FiscYr - 1;
	  	df.FrOpnDate.value = "4/16/" + (prioryr - 1);
	  	df.ToOpnDate.value = "4/15/" + (FiscYr - 1);		  
	}
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
// Check all or reset check boxes
//==============================================================================
function chkAllChkbox(objNm, bcheck)
{
   var cbObj = document.all[objNm];
   for(var i=0; i < cbObj.length; i++)
   {
	   if(SelGrp == "SKI" && cbObj[i].value == "28"){ cbObj[i].checked = false;}
	   else if(SelGrp == "SKI" && cbObj[i].value != "28"){ cbObj[i].checked = bcheck;}
	   else if(SelGrp == "WATER" && cbObj[i].value == "28"){ cbObj[i].checked = bcheck;}
	   else if(SelGrp == "WATER" && cbObj[i].value != "28"){ cbObj[i].checked = false;}
	   else if(SelGrp == "BIKE" && cbObj[i].value == "28"){ cbObj[i].checked = false;}
	   else if(SelGrp == "BIKE" && cbObj[i].value != "28"){ cbObj[i].checked = bcheck;}
	   else if(SelGrp == "ALL"){ cbObj[i].checked = bcheck;}
   }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var dummy = "</table>";
  var error = false;
  var msg = "";
  
  var grp = null;
  for(var i=0, k=0; i < document.all.Group.length; i++)
  {
    if(document.all.Group[i].checked) 
    { 
    	grp = document.all.Group[i].value; 
    }
  }

  var rorl = null;
  for(var i=0, k=0; i < document.all.RorL.length; i++)
  {
    if(document.all.RorL[i].checked) 
    { 
    	rorl = document.all.RorL[i].value; 
    }
  }
  
  var sts = new Array();
  var stsfnd = false;

  var Sts = document.all.Sts; 
  
  for(var i=0, k=0; i < Sts.length; i++)
  {
    if(document.all.Sts[i].checked) { sts[k++] = document.all.Sts[i].value; stsfnd = true; }
  }
  if(!stsfnd){ error= true; msg += "Please, check at least 1 status."}

  var str = new Array();
  var strfnd = false;
  var Str = document.all.Str;
  for(var i=0, j=0; i < Str.length; i++)
  {
    if(document.all.Str[i].checked) { str[j] = document.all.Str[i].value; strfnd = true; j++}
  }
  if(!strfnd){ error= true; msg += "Please, check a store."}

  // pickup date
  var frdate = document.all.FrDate.value;
  var todate = document.all.ToDate.value;
  
  //open date
  var fropndate = document.all.FrOpnDate.value;
  var toopndate = document.all.ToOpnDate.value;
  

  if (error) alert(msg);
  else{ sbmRentLst( grp, rorl, sts, str, frdate, todate, fropndate, toopndate ) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmRentLst( grp, rorl, sts, str, frdate, todate, fropndate, toopndate)
{
  var url = "RentContList.jsp?RorL=" + rorl;
  		  
		  
  for(var i=0; i < sts.length; i++)
  {
     url += "&Sts=" + sts[i]
  }
  for(var i=0; i < str.length; i++)
  {
     url += "&Str=" + str[i]
  }
  url += "&Sort=CONT"
       + "&Grp=" + grp
       + "&FrDate=" + frdate
       + "&ToDate=" + todate
       + "&FrOpnDate=" + fropndate
       + "&ToOpnDate=" + toopndate

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// go to individual contract
//==============================================================================
function gotoContract()
{
   if(document.all.Cont.value.trim() == "")
   {
       alert("Please, enter contract number.")
   }
   else
   {
      var url = "RentContractInfo.jsp?Grp=" + SelGrp 
    	+ "&ContId=" + document.all.Cont.value.trim();
      window.open(url);
   }
}
//==============================================================================
//go to individual contract
//==============================================================================
function crtNewContract(grp)
{		
	var url = "RentContractInfo.jsp?Grp=" + grp;
    window.open(url);
}

//==============================================================================
// quick search customer resrvations
//==============================================================================
function ValidateSearch()
{
	var error = false;
	var msg = "";
	var errfld = document.getElementById("spnError");
	errfld.innerHTML = "";
	var br = "";
	
	var cust = document.getElementsByName("Cust")[0].value.trim();
	var lname = document.getElementsByName("LName")[0].value.trim().toUpperCase();
	var fname = document.getElementsByName("FName")[0].value.trim().toUpperCase();
	var phone = document.getElementsByName("Phone")[0].value.trim().toUpperCase();
	
	if(cust == "" && lname=="" && fname=="" && phone=="")
	{ 
		error=true; msg += br + "No Search criterion found"; br="<br>";
	}
	
	if( fname !="" && cust == "" && lname =="" && phone=="")
	{ 
		error=true; msg += br + "First Name only is not enough for search"; br="<br>";
	}
	
	if(error){ errfld.innerHTML=msg;}
	else { getQuickSearch(cust, fname, lname, phone ); }
}
//==============================================================================
// get quick search customer list
//==============================================================================
function getQuickSearch(cust, fname, lname, phone )
{
	var str = "ALL";
	if (StrArr.length == 1 ) { str = StrArr[0]; } 
	
	var url = "RentCustSearch.jsp?"
	     + "Last=" + lname
	     + "&First=" + fname
	     + "&Phone=" + phone
	     + "&EMail="  
	     + "&Cont="
	     + "&Cust=" + cust
	     + "&Str=" + str
	     + "&Action=Only_Payee" 
	   window.frame1.location.href=url
}
//==============================================================================
//customer list
//==============================================================================
function showCustLst(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntOpn, CntRdy, CntCnl, CntPck
, CntRtn, Unrel)
{
	var hdr = "Customer List";

	var html = "<table class='tbl01' cellPadding='0'  cellSpacing='0'>"
  	+ "<tr>"
    	+ "<td class='BoxName' nowrap>" + hdr + "</td>"
    	+ "<td class='BoxClose' valign=top>"
     	 +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    	+ "</td></tr>"
 	+ "<tr><td class='Prompt' colspan=2>" + popCustSelPanel(Cust, FirstNm, MInit, LastNm, Addr1
     , Addr2, City, State, Zip, EMail, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight
     , ShoeSiz, SkierTy, Stance, RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight
     , CntOpn, CntRdy, CntCnl, CntPck, CntRtn, Unrel)
  	+ "</td></tr>"
	+ "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
	else { document.all.dvStatus.style.width = "auto";} 

	document.all.dvStatus.innerHTML = html;
	document.all.dvStatus.style.left=getLeftScreenPos() + 300;
	document.all.dvStatus.style.top=getTopScreenPos() + 100;
	document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
//populate Customer Searched
//==============================================================================
function popCustSelPanel(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntOpn, CntRdy, CntCnl, CntPck
, CntRtn, Unrel)
{
	var panel = "<table class='tbl01'>"
	panel += "<tr class='DataTable7'>"
   		+ "<th nowrap rowspan=2>ID</th>"
   		+ "<th nowrap rowspan=2>Name</th>"
   		+ "<th nowrap rowspan=2>Address</th>"
   		+ "<th nowrap rowspan=2>Date</th>"
   		+ "<th nowrap colspan=5>All Current Contract Statuses</th>"
 	+ "</tr>"
 	+ "<tr class='DataTable7'>"
 		+ "<th nowrap>opened</th>"
 		+ "<th nowrap>ready</th>"	   	
   		+ "<th nowrap>returned</th>"
   		+ "<th nowrap>picked up</th>"
   		+ "<th nowrap>cancelled</th>"   		
 	+ "</tr>"

 for(var i=0; i < Cust.length; i++)
 {
 	FirstNm[i] = FirstNm[i].replace("'", "&#39;");
 	LastNm[i] = LastNm[i].replace("'", "&#39;");
 	
     panel += "<tr class='DataTable8'>"
        + "<td class='DataTable' nowrap>" + Cust[i] + "</td>"
        + "<td class='DataTable' nowrap><a href='javascript: getContSearch(&#34;" + Cust[i] + "&#34;)'>"
           + FirstNm[i] + " " + MInit[i] + " " + LastNm[i] + "</a></td>"
        + "<td class='DataTable' nowrap>" + Addr1[i] + " " + Addr2[i] + " " + City[i] + " " + State[i] + " " + Zip[i] + "</td>"
        + "<td class='DataTable' nowrap>" + RecDt[i] + "</td>"
     var unr = "OK";
     if(Unrel[i]=="Y"){ unr = "<span style='border:red ridge 1px; background:red;font-size:12px;'>***</span>" }

   
     panel +=  "<td class='DataTable' nowrap>" + CntOpn[i] + "</td>"
    	+ "<td class='DataTable' nowrap>" + CntRdy[i] + "</td>"
        + "<td class='DataTable' nowrap>" + CntRtn[i] + "</td>"
        + "<td class='DataTable' nowrap>" + CntPck[i] + "</td>"
        + "<td class='DataTable' nowrap>" + CntCnl[i] + "</td>"       
      + "</tr>"
 }


 panel += "<tr class='DataTable8'><td class='DataTable2' colspan='10'>"
     + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
return panel;
}
//==============================================================================
// get Contract Search
//==============================================================================
function getContSearch(cust)
{
	var url = "RentContSearch.jsp?"
	     + "&Cust=" + cust
    window.frame1.location.href=url
}
//==============================================================================
//show Contract list 
//==============================================================================
function showContLst(Cont, Cust, PickDt, RtnDt, Sts, Str, Online, RecDt)
{
	var hdr = "Customer: " + Cust[0];

	   var html = "<table class='tbl01' cellPadding='0'  cellSpacing='0'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popContLst(Cont, Cust, PickDt, RtnDt, Sts, Str, Online, RecDt)

	   html += "</td></tr></table>"

	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "200"; }
	   else { document.all.dvStatus.style.width = "auto"; }
	   
	   document.all.dvStatus.innerHTML = html;
	   document.all.dvStatus.style.left= getLeftScreenPos() + 400;
	   document.all.dvStatus.style.top= getTopScreenPos() + 180;
	   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
//populate Marked Item Panel
//==============================================================================
function popContLst(Cont, Cust, PickDt, RtnDt, Sts, Str, Online, RecDt)
{
	var panel = "<table  border=1 width='100%' cellPadding='0' cellSpacing='0' >";
	panel += "<tr class='DataTable3'>"
			+ "<th>Contract #</th>"	
			+ "<th>Costumer #</th>"	
			+ "<th>Pick-Up Date</th>"	
			+ "<th>Returned Date</th>"	
			+ "<th>Status</th>"	
			+ "<th>Store</th>"
			+ "<th>On-line</th>"
			+ "<th>Created Date</th>"	
		+ "</tr>";
	for(var i=0; i < Cont.length; i++)
	{	
		panel += "<tr class='DataTable'>"
			+ "<td><a href='javascript: showSelCont(&#34;" + Cont[i] + "&#34;)' >" + Cont[i] + "</a></td>"
			+ "<td>" + Cust[i] + "</td>"
			+ "<td>" + PickDt[i] + "</td>"
			+ "<td>" + RtnDt[i] + "</td>"
			+ "<td>" + Sts[i] + "</td>"
			+ "<td>" + Str[i] + "</td>"
			+ "<td>" + Online[i] + "</td>"
			+ "<td>" + RecDt[i] + "</td>"
		  + "</tr>";
	}
	
	panel += "<tr class='DataTable'>"
    panel += "<td class='DataTable2' colspan=8>"
	panel += "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
		+ "</td></tr>"
	panel += "</table>";
	return panel;
}

//==============================================================================
//go to individual contract
//==============================================================================
function showSelCont(cont)
{
   var url = "RentContractInfo.jsp?Grp=ALL" 
 	+ "&ContId=" + cont;
   window.open(url);
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvStatus.innerHTML = " ";
	document.all.dvStatus.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvItem"></div>
<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp">
<a  class="helpLink" href="Intranet Reference Documents/3.0%20Rental%20Contracts.pdf" title="Click here for help" target="_blank">&nbsp;</a>
</div>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Rental Contract</B>

        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

<!-- ======================= On-line reservation ============================ -->
         
      
      <TABLE border=0>
         <tr>
           <td class="Cell3">   
                  <br>Go to Contract #  / Reservation ID # &nbsp; <input name="Cont" size=10 maxlength=10>&nbsp;
                   <button onClick="gotoContract()" style="font-weight: bold;">GO</button>
                                       
           </TD>
          </TR>
      </table> 
      
      <br>
        
      <TABLE border=0>  
           <tr>
           <td >
              <table border=0 >
              	<tr>
              	  <td class="Cell5" colspan=2>For On-Line Reservations - Lookup Customers</td>
              	</tr>  
              	
              	<tr><td>&nbsp;</td></tr>
              	
              	<tr>
                  <td class="Cell1">Phone Number:</td>
              	  <td class="Cell1"><input name="Phone" size=20 maxlength=25></td>
                </tr>
                
              	<tr style="display: none;">
              	  <td class="Cell1">Customer ID # :</td>
              	  <td class="Cell1"><input name="Cust" size=10 maxlength=10></td>
                </tr> 
                
                <tr>
                  <td class="Cell1">Last Name:</td>
              	  <td class="Cell1"><input name="LName" size=30 maxlength=35></td>
                </tr>
                 
                 <tr>
                  <td class="Cell1">First Name:</td>
              	  <td class="Cell1"><input name="FName" size=30 maxlength=35></td>
                </tr>
                 
                <tr>
              	  <td class="Cell4" colspan="2">   
                	<button style="font-weight: bold;" onClick="ValidateSearch()">Search</button>
                  </td>
                </tr>
                <tr>
              	  <td class="Cell1" colspan="2">   
          			<span id="spnError" style="color:red;"></span>
                  </td>
                </tr>
              </table>                         
           </TD>
          </TR>  
         </TABLE>
         
         <br>
         
           <!-- ======================= Walk-in customer ============================ --> 
         
         <TABLE >
          <tr>
           	  <td class="Cell5" colspan=2>For Walk-In Customers - Start a New Contract Below</td>
          </tr> 
         
          <TR>
          <TD class="Cell6" colspan=4>
             <br>
             <button style="font-size:12px; font-weight: bold;" onclick="crtNewContract('SKI')">Ski/Snowboard</button> &nbsp;
             <button style="font-size:12px; font-weight: bold;" onclick="crtNewContract('WATER')">Watersport</button>  &nbsp;
             <button style="font-size:12px; font-weight: bold;" onclick="crtNewContract('BIKE')">Bike</button> 
            <br>&nbsp;
          </TD>
         </TR>
         
        <tr>	
          	  <td class="Cell5" colspan=2>Rental Contract List</td>          	  
         </tr>  
         <tr>
          <TD class="Cell6" colspan=4>
             <br><b>Filter to Rental Sport Category</b>          
          </TD>
         </tr>  
         <tr>
           <td class="Cell6" colspan=4>
                <input type="radio" class="Small" name="Group" onclick="setSport();" value="SKI">Ski/Snowboard &nbsp;
                <input type="radio" class="Small" name="Group" onclick="setSport();" value="WATER">Waterboard &nbsp;
                <input type="radio" class="Small" name="Group" onclick="setSport();" value="BIKE">Bike &nbsp;
                <input type="radio" class="Small" name="Group" onclick="setSport();" value="ALL">All &nbsp;
                
          </td>
         </tr> 
         
        <tbody id="tbody1"> 
        
        <!-- ======================= Department ============================ -->
         
         <!-- ======================= Rent/Lease ============================ -->
         <TR>
          <TD class="Cell1" colspan=4>
            <br>Rent/Lease:&nbsp; 
                    <input type="radio" class="Small" name="RorL" value="R" checked>Rent &nbsp;
                    <input type="radio" class="Small" name="RorL" value="L">Lease &nbsp;
                    <input type="radio" class="Small" name="RorL" value="B">Both &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                   
                    
                   <br> &nbsp;
          </td>
         </TR>
         <TR>
          <TD class="Cell1" colspan=4>
            Status: <a class="Small" href="javascript: chkAllChkbox('Sts', true)">All Statuses</a>, &nbsp;
                    <a class="Small" href="javascript: chkAllChkbox('Sts', false)">Reset</a>
                    <br>
                    <input type="checkbox" class="Small" name="Sts" value="OPEN" checked>Open &nbsp;
                    <input type="checkbox" class="Small" name="Sts" value="READY" checked>Ready &nbsp;
                    <input type="checkbox" class="Small" name="Sts" value="PICKEDUP" checked>Picked up &nbsp;
                    <input type="checkbox" class="Small" name="Sts" value="RETURNED">Returned &nbsp;
                    <input type="checkbox" class="Small" name="Sts" value="CANCELLED">Cancelled &nbsp;
          </TD>
         </TR>

       <!-- ======================= Store ============================ -->
       <TR><TD style="border-bottom: grey solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1" colspan=4>Stores: &nbsp;
            <a class="Small" href="javascript: chkAllChkbox('Str', true)">All Stores</a>, &nbsp;
            <a class="Small" href="javascript: chkAllChkbox('Str', false)">Reset</a>
          <br>

        <%sStmt = "select store"
           + " from RCI.ReStr"
           + " where store in (";

          String sComa = "";
          for(int i=0; i < sStrAlw.length; i++)
          {
             if(sStrAlw[i] != null){ sStmt += sComa + sStrAlw[i]; sComa = ",";  }
          }
          sStmt +=  ")" ;
          sStmt += " order by store";    
          runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmt);
          ResultSet rs = runsql.runQuery();
          int j=0;

          while(runsql.readNextRecord())
          {
             String sStr = runsql.getData("store").trim();
             sComa= ""; 
         %>
           <%=sComa%>&nbsp;<input type="checkbox" class="Small" name="Str" value="<%=sStr%>" checked><%=sStr%>
              <%j++;%>
              <%sComa=",";%>
              <script>StrArr[StrArr.length] = "<%=sStr%>";</script>
       <%}%>
         <input type="hidden" class="Small" name="Str" value="dummy">
         </TD>
       </TR>
       
       
        <!-- ============== select date ========================== -->
        <TR><TD style="border-bottom: grey solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select Pick Up Date</TD></tr>

		<TR>
			<TD id="tdDate5" colspan=4 align=center style="padding-top: 10px;" >
             	<button id="btnSelDates" onclick="showDates(3)">This Season</button>
             	&nbsp; &nbsp;
             	<button id="btnSelDates" onclick="showDates(4)">Prior Season</button>
             </td>
        <TR>
          
          <TD id="tdDate3" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Pick Up Date Selection</button>
          </td>
          <TD id="tdDate4" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int k=0; k < 20; k++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(2)" style="font-weight: bold;">All Dates</button>
          </TD>
        </TR>
        
        
        <!-- ============== select creation date  ========================== -->
        <TR><TD style="border-bottom: grey solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select Entry Date</TD></tr>

		<TR>
			<TD id="tdDate8" colspan=4 align=center style="padding-top: 10px;" >
             	<button id="btnSelDates" onclick="showOpnDates(3)">This Season</button>
             	&nbsp; &nbsp;
             	<button id="btnSelDates" onclick="showOpnDates(4)">Prior Season</button>
             </td>
        <TR>
          
          <TD id="tdDate6" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showOpnDates(2)">Optional Entry Date Selection</button>
          </td>
          <TD id="tdDate7" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrOpnDate')">&#60;</button>
              <input class="Small" name="FrOpnDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrOpnDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.FrOpnDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int k=0; k < 20; k++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOpnDate')">&#60;</button>
              <input class="Small" name="ToOpnDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOpnDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ToOpnDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllOpnDates(2)">All Dates</button>
          </TD>
        </TR>
        
        
        
        
        <!-- =============================================================== -->
        <TR><TD style="background: grey; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()" style="font-weight: bold;">
               
               <br><br><br>Click <a href="RentContractPrint.jsp?Print=Y" target="_blank">here</a> to print empty SSER/L form.
            </td>
        </tr>
        
        
          </tbody>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>