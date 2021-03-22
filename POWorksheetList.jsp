<%@ page import="posend.POWorkSheetList,java.util.*, java.text.*, rciutility.StoreSelect
, rciutility.SetStrEmp"%>
<%

long lStartTime = (new java.util.Date()).getTime();

 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POWorksheetList.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    String sSelStr = request.getParameter("Store");
    String sFrDate = request.getParameter("FromDate");
    String sToDate = request.getParameter("ToDate");
    String sSelSts = request.getParameter("Sts");
    String sInclSO = request.getParameter("InclSO");
    String sSelVen = request.getParameter("Ven");
    String sSelType = request.getParameter("Type");
    String sSort = request.getParameter("Sort");    
    String sUser = session.getAttribute("USER").toString();

    if(sSelStr == null){ sSelStr = "ALL"; }
    if(sFrDate == null){ sFrDate = " "; }
    if(sToDate == null){ sToDate = "ALL"; }
    if(sSelSts == null){ sSelSts = "O"; } // open
    if(sInclSO == null){ sInclSO = " "; } // include special order POs
    if(sSelVen==null) {sSelVen = "ALL"; }
    if(sSort==null) {sSort= "PON"; }
    if(sSelType == null){ sSelType = "B"; } // both
    
    StoreSelect strlst = null;
    String sStrJsa = null;
    String sStrNameJsa = null;
    String sStrAllowed = session.getAttribute("STORE").toString();

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      strlst = new StoreSelect(30);
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
      
      if(!sStrAllowed.startsWith("ALL") && vStr.size() <= 1)
      {
      	sSelStr = sStrAllowed;
      }      
    }
    
    sStrJsa = strlst.getStrNum();
    sStrNameJsa = strlst.getStrName();
    
    
  	//System.out.println("\n" + sSelStr + "|" + sFrDate + "|" + sToDate + "|" + sSelSts
  	// + "|" + sInclSO + "|" + sSelVen + "|" + sSelType + "|" + sSort + "|" + sUser );
    POWorkSheetList polist = new POWorkSheetList();

    polist.setPOWorkSheetList(sSelStr, sFrDate, sToDate, sSelSts
            , sInclSO, sSelVen, sSelType, sSort, sUser);
    
    int iNumOfPo = polist.getNumOfPo();   
    
    // retreive store employees
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sEmpNumJsa = null;
    String sEmpNameJsa = null;
    String sEmpEMailJsa = null;
    
    SetStrEmp getEmp = new SetStrEmp(sAuthStr, "RCI");
    int iEmp = getEmp.getNumOfEmp();
    String [] sEmpNum = getEmp.getEmpNum();
    String [] sEmpName = getEmp.getEmpName();
    String [] sEmpEMail = getEmp.getEmpEMail();
    getEmp.disconnect();
    sEmpNumJsa = polist.cvtToJavaScriptArray(sEmpNum);
    sEmpNameJsa = polist.cvtToJavaScriptArray(sEmpName);
    sEmpEMailJsa = polist.cvtToJavaScriptArray(sEmpEMail);
    
%>
<title>Vendor Drop Shipment List</title>
<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        
        table.DataTable { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%; 
            border: grey solid 1px; font-size:10px }
        table.DataTable1 { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%; 
            background: LemonChiffon; border: grey solid 1px; font-size:10px }
        
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
            border-right: grey solid 1px; border-bottom: grey solid 1px;
            text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        th.DataTable2 { background:#cccfff;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#ccffcc;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
            border-right: grey solid 1px; border-bottom: grey solid 1px;
            padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
            border-right: grey solid 1px; border-bottom: grey solid 1px;
            padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
            border-right: grey solid 1px; border-bottom: grey solid 1px;
            padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
                       
        td.tdError { color:Red;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }                          

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin:none; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:200; background-color: Cornsilk; z-index:1;
              text-align:center; font-size:10px}
        
        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:600; height:400px; overflow-y:scroll; background-color: Cornsilk; z-index:1;
              text-align:center; font-size:10px}      
        
        div.dvCnfDlt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
                    
        div.dvPOLink { position:absolute; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvSelect { position:absolute; background-attachment: scroll;
                width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}
              
        div.dvVendor { position:absolute; visibility:hidden;  
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  		div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  		div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  		div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }
       
        div.dvOptSel { position:absolute; border: gray solid 1px; display:none;
                 width:300; height:250;background-color:yellow; z-index:10; text-align:left; font-size:10px}  
        
        div.dvHelp { position:absolute; border: none;text-align:center; width: 50px;height:50px; 
     	top: 5; right: 30px; font-size:11px; white-space: nowrap;  z-index:10;}
  		a.helpLink { background-image:url("/scripts/Help02.png"); display:block;
     		height:50px; width:50px; text-indent:-9999px; }
        
        td.BoxName {cursor:move; background: #016aab;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:center; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }           
}

</style>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript1.2">
var SelRow = 0;
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var SelStr = "<%=sSelStr%>";
var SelVen = "<%=sSelVen%>";
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
var SelSts = "<%=sSelSts%>";
var InclSO = "<%=sInclSO%>";
var SelType = "<%=sSelType%>";
var NumOfPo = "<%=iNumOfPo%>";

var Vendor = null;
var VenName = null;
var LastVen = "";

var ArrEmp = [<%=sEmpNumJsa%>];
var ArrEmpNm = [<%=sEmpNameJsa%>];
var ArrEmpEMail = [<%=sEmpEMailJsa%>];

var progressIntFunc = null;
var progressTime = 0;
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	// activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt", "dvItem"]);
   
   showPOLInk();
   
   setSelectPanelShort();
}
//==============================================================================
//set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
	var hdr = "Select Report Parameters";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  		+ "<tr>"
    		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
    		+ "<td class='BoxClose' valign=top>"
      			+  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
    	+ "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>"
	html += "</td></tr></table>"
	document.all.dvSelect.innerHTML=html;
}
//==============================================================================
//set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
	var hdr = "Select Report Parameters";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  	 + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
          +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>"

	html += popSelWk()

	html += "</td></tr></table>"
	document.all.dvSelect.innerHTML=html;

	setStrSel();
	setVenSel();
	setSelDate();
	setStsSel();
	setStsIncl();
	setTypeSel();
}
//==============================================================================
//populate Column Panel
//==============================================================================
function popSelWk()
{
	var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
	panel += "<tr id='trDt1'  style='background:khaki'>"
	    	+ "<td class='Prompt' colspan=3>PO Type - EDI/ASN:</td>"
	  	+ "</tr>" 
	  	+ "<tr id='trDt2' style='background: khaki'>"
			+ "<td class='Prompt' colspan=3 nowrap>"
			  + "<input type='radio' name='Type' value='Y'>Yes &nbsp; &nbsp;"
			  + "<input type='radio' name='Type' value='N'>No &nbsp; &nbsp;"
			  + "<input type='radio' name='Type' value='B'>Both &nbsp; &nbsp;"
			+ "</td>"
		+ "</tr>";
		
 	panel += "<tr>"
    	+ "<td class='Prompt2'>Store:</td>"
		+ "<td class='Prompt3' colspan=2>"
   		+ "<select id='Str' class='Small'></select>"
	+ "</td>"
  	+ "</tr>";
  	
  	panel += "<tr id='trDt1' style='background:#ccffcc; text-align:left;'>"
  		+ "<td class='Prompt2'>Vendor:</td>"
		+ "<td class='Prompt3' colspan=2>"
   		+ "<input class='Small' name='VenName' size=30 value='All Vendors' readonly>"
        + "<input class='Small' name='Ven' type='hidden' value='ALL'>&nbsp;"
        + "<button class='Small' name=GetVen onClick='rtvVendors()'>Select Vendors</button>"
  	+ "</tr>" 
  	

    panel += "<tr id='trDt1'  style='background:azure'>"
    	+ "<td class='Prompt' colspan=3>PO Anticipated Date:&nbsp</td>"
  	+ "</tr>"  
 	+ "<tr id='trDt2' style='background:azure'>"
    	+ "<td class='Prompt2' id='td2Dates' width='30px'>From:</td>"
    		+ "<td class='Prompt' id='td2Dates'>"
       			+ "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FrDate&#34;)'>&#60;</button>"
       			+ "<input name='FrDate' class='Small' size='10' readonly>"
       			+ "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;FrDate&#34;)'>&#62;</button>"
    	+ "</td>"
    	+ "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 350, 40, document.all.FrDate)'>"
      		+ "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
 	+ "</tr>"
 	+ "<tr id='trDt2' style='background:azure'>"
    	+ "<td class='Prompt' id='td2Dates' width='30px'>To:</td>"
    	+ "<td class='Prompt' id='td2Dates'>"
       		+ "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ToDate&#34;)'>&#60;</button>"
       		+ "<input name='ToDate' class='Small' size='10' readonly>"
       		+ "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;ToDate&#34;)'>&#62;</button>"
    	+ "</td>"
    	+ "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 350, 120, document.all.ToDate)'>"
      		+ "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
  	+ "</tr>";
  	
  	panel += "<tr id='trDt1'  style='background:#cccfff'>"
    	+ "<td class='Prompt' colspan=3>PO Status:</td>"
  	+ "</tr>" 
  	+ "<tr id='trDt2' style='background: #cccfff'>"
		+ "<td class='Prompt' colspan=3 nowrap>"
		  + "<input type='radio' name='Sts' value='O'>Open &nbsp; &nbsp;"
		  + "<input type='radio' name='Sts' value='C'>Closed &nbsp; &nbsp;"
		  + "<input type='radio' name='Sts' value='B'>Both &nbsp; &nbsp;"
		+ "</td>"
	+ "</tr>" 
  	+ "<tr id='trDt2' style='background: #cccfff'>"
		+ "<td class='Prompt' colspan=3 nowrap>"		  
		  + "<input type='checkbox' name='InclSO' value='Y'>:  Include SO's (Reg/Patio) &nbsp; &nbsp;"
		+ "</td>"
	+ "</tr>";
	
		
  	panel += "<tr><td class='Prompt1' colspan=3>"
     + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
     + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

	panel += "</table>";

	return panel;
}
//==============================================================================
// set store selection 
//==============================================================================
function setStrSel()
{
	var istart = 0;
	if(ArrStr.length == 2){ istart = 1; }
	
	for(var i=istart, j=0; i < ArrStr.length ; i++, j++)
	{
		document.all.Str.options[j] = new Option( ArrStr[i] + " - " + ArrStrNm[i], ArrStr[i] );
		if(ArrStr[i] == SelStr){document.all.Str.selectedIndex = j; }
	}
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function setVenSel()
{
	document.all.Ven.value = SelVen;
	document.all.VenName.value = SelVen;
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function setStsIncl()
{
	if(InclSO=="Y"){document.all.InclSO.checked = true; }
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function  setSelDate()
{	
	if(ToDate == "ALL")
	{
		var date = new Date(new Date() -  180 * 86400000);
		date.setHours(18)
		document.all.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

		var date = new Date(new Date() -  -90 * 86400000);
		date.setHours(18)
		document.all.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
	}
	else
	{
		document.all.FrDate.value = FrDate;
		document.all.ToDate.value = ToDate;		
	}
}
//==============================================================================
// set status selection
//==============================================================================
function setStsSel()
{
	var sts = document.all.Sts;
	for(var i=0; i < sts.length; i++)
	{
	    if(sts[i].value==SelSts){ sts[i].checked = true; }	
	}
		
}
//==============================================================================
//set type selection
//==============================================================================
function setTypeSel()
{
	var type = document.all.Type;
	for(var i=0; i < type.length; i++)
	{
	    if(type[i].value==SelType){ type[i].checked = true; }	
	}
		
}
//==============================================================================
//retreive vendors
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
	else 
	{ 
		document.all.dvVendor.style.visibility = "visible"; 
	}
}
//==============================================================================
//popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
	Vendor = ven;
	VenName = venName;
	var html = "<input name='FndVen' class='Small' size=5 maxlength=5>&nbsp;"
	+ "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
	+ "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;"
	+ "<button onclick='document.all.dvVendor.style.visibility=&#34;hidden&#34;' class='Small'>Close</button><br>"
	
	html += "<div id='dvInt' class='dvInternal'>"
    + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	for(var i=0; i < ven.length; i++)
	{
		html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
	}
	html += "</table></div>"
	
	var pos = getObjPosition(document.all.VenName)

	document.all.dvVendor.innerHTML = html;
	document.all.dvVendor.style.left=pos[0] + 200;
	document.all.dvVendor.style.top= pos[1] + 25;
	document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
//find selected vendor
//==============================================================================
function findSelVen()
{
var ven = document.all.FndVen.value.trim().toUpperCase();
var vennm = document.all.FndVenName.value.trim().toUpperCase();
var dvVen = document.all.dvVendor
var fnd = false;

//zeroed last search
if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
LastVen = vennm;

for(var i=LastTr+1; i < Vendor.length; i++)
{
if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break; }
else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break; }
document.all.trVen[i].style.color="black";
}

//if found set value and scroll div to the found record
if(fnd)
{
var pos = document.all.trVen[LastTr].offsetTop;
document.all.trVen[LastTr].style.color="red";
dvInt.scrollTop=pos;
}
else { LastTr=-1; }
}
//==============================================================================
//show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
	document.all.VenName.value = vennm
	document.all.Ven.value = ven
}

//==============================================================================
//Validate form
//==============================================================================
function Validate()
{
	var error = false;
	var msg = " ";
	
	var str = document.all.Str.options[document.all.Str.selectedIndex].value;
	var frdate = document.all.FrDate.value;
	var todate = document.all.ToDate.value;
	var inclso = " ";
	var ven = document.all.Ven.value;
	
	if(document.all.InclSO.checked){inclso = document.all.InclSO.value; }
	
	var stssel = null;
	var sts = document.all.Sts;
	for(var i=0; i < sts.length; i++)
	{
		if(sts[i].checked){ stssel = sts[i].value;}
	}
	
	var typesel = null;
	var type = document.all.Type;
	for(var i=0; i < type.length; i++)
	{
		if(type[i].checked){ typesel = type[i].value;}
	}

	if (error) alert(msg);
	else { sbmPoList(str, ven, frdate,todate, stssel, inclso, typesel); }
}
//==============================================================================
// submit new selection for this report
//==============================================================================
function sbmPoList(str, ven, frdate,todate, stssel, inclso, typesel)
{
	var url = "POWorksheetList.jsp?Store=" + str
	    + "&Ven=" + ven
		+ "&FromDate=" + frdate 
		+ "&ToDate=" + todate
		+ "&InclSO=" + inclso
		+ "&Sts=" + stssel
		+ "&Type=" + typesel
		+ "&Sort=<%=sSort%>"
	;	
	//alert(url)
	window.location.href=url;
}
//==============================================================================
//link to PO info
//==============================================================================
function showPOLInk()
{
	var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
	  + "<tr class='DataTable1'>"
	     + "<td class='DataTable' nowrap>PO Number: "
	        + "<input name='PONum' class='Small' size='10' maxlength='10'> &nbsp; "
	        + "<button class='Small' onclick='vldPOLink()'>GO</button>"
	     + "</td>"
	     + "<td class='DataTable' nowrap>Position to PO Number: "
	        + "<input name='SetTo' class='Small' size='10' maxlength='10'> &nbsp; "
	        + "<button class='Small' onclick='setView()'>GO</button>"
	     + "</td>"
	  + "</tr>"
	  + "<tr class='DataTable1'>"
	  + "</tr>"
	     + "<td class='tdError' id='tdError' nowrap></td>"
	  + "</tr>"
	html += "</table>"

	document.all.dvPOLink.style.left= 750;
	document.all.dvPOLink.innerHTML = html;	
}
//==============================================================================
//validate PO Link
//==============================================================================
function vldPOLink()
{
    var msg = "";
    var error = false;
    document.all.tdError.innerHTML = "";
    
    var ponum = document.all.PONum.value.trim();
    if(isNaN(ponum)){ error=true; msg = "PO Number is not numeric"; }
    
    if(error){ document.all.tdError.innerHTML = msg; }
    else { sbmPOLink(ponum); }
}
//==============================================================================
//submit PO Link
//==============================================================================
function sbmPOLink(ponum)
{
	var url = "POWorksheet.jsp?PO=" + ponum;
	window.location.href = url;
}
//==============================================================================
//submit PO Link
//==============================================================================
function setView()
{
	document.all.SetTo.style.color = "black";
    var po = document.all.SetTo.value.trim();
	var id = "tdPo" + po;
	var inner_obj = document.getElementById(id);
	if(inner_obj != null)
	{
		var container = document.getElementById("dvBody");	
		var pos = getObjPosition(inner_obj);
		container.scrollTop = pos[1] - 150;		
	}
	else
	{
		document.all.SetTo.style.color = "red";
	}
}
//==============================================================================
// re-sort list
//==============================================================================
function sbmSort(sort)
{
	//Store=ALL&Ven=6056&FromDate=2/1/2020&ToDate=5/10/2021&InclSO= &Sts=B&Type=B&Sort=PON
	//Store=ALL&FromDate=2/1/2020&ToDate=5/10/2021&Sts=B&InclSO= &Type=B&Sort=STR
	
	var url = "POWorksheetList.jsp?Store=<%=sSelStr%>&FromDate=<%=sFrDate%>&ToDate=<%=sToDate%>" 
		 + "&Ven=<%=sSelVen%>"
		 + "&Sts=<%=sSelSts%>"
		 + "&InclSO=<%=sInclSO%>"   
		 + "&Type=<%=sSelType%>"
		 + "&Sort=" + sort

   //alert(url)
   window.location.href=url;
}
//---------------------------------------------------------
// show Comments on panel
//---------------------------------------------------------
function showComment(arg, ponum, commt)
{
  if(commt == "Add a comment") commt="";


  var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Add/Update Comments for P.O. " + ponum + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
  // Comment line
   html += "<tr class='DataTable1'>"
          + "<td class='DataTable' nowrap colspan='2'>Comments: "
          + "<input name='Commt' class='Small' size='70' maxlength='70' value='" + commt + "'></td>"
        + "</tr>"
   // buttons
   html += "<tr class='DataTable1'>"
          + "<td class='DataTable' nowrap colspan='2'>"
          + "<button class='Small' onClick='saveComment(" + arg + ", " + ponum + ")'>Save</button>&nbsp;&nbsp;"
          + "<button class='Small' onClick='hidePanel();'>Cancel</button>"
          + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.left= 200;
   document.all.Prompt.style.top= 200;
   document.all.Prompt.style.visibility = "visible";
}

//--------------------------------------------------------
// save Comments
//--------------------------------------------------------
function saveComment(arg, ponum)
{
   var url = "POSaveComment.jsp?"
     + "PoNum=" + ponum
     + "&Comment=" + document.all.Commt.value.trim();
   //alert(url);
   //window.location.href = url
   window.frame1.location = url;

   if ( document.all.Commt.value.trim() != ""
     && document.all.Commt.value.trim() != " ")
   {
        document.all.linkCmt[arg].innerHTML = document.all.Commt.value.trim();
   }
   else document.all.linkCmt[arg].innerHTML = "Add a comment";
   hidePanel();
}

//==============================================================================
// get ASN Details
//==============================================================================
function getASNDtl(ponum, asn, asndt, ctn, action)
{
	showExistOptProg();
	progressIntFunc = setInterval(function() {showExistOptProg() }, 1000);	
	
   var url = "POAsnDtl.jsp?PO=" + ponum
     + "&ASN=" + asn
     + "&Date=" + asndt
     + "&Action=" + action
   if(action=="Item"){ url += "&Ctn=" + ctn; }  
     
   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//==============================================================================
// show ASN Details
//==============================================================================
function showASNDtl(po, asn, asndt, ctn, shp, rcv, itm, manRcv, ctnSts, ctnInv, ctnDate, ctnTime)
{
	clearInterval( progressIntFunc );
	progressTime = 0;
	document.all.dvOptSel.innerHTML = " ";
	document.all.dvOptSel.style.display = "none";
	
	var html = "<table class='DataTable'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>ASN Carton List</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
     + "<tr><td class='Prompt' colspan=2>" + popAsnDtlPanel(po, asn, asndt, ctn, shp, rcv, itm, manRcv
    		  , ctnSts, ctnInv, ctnDate, ctnTime)
      + "</td></tr>"
     
   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.left= 200;
   document.all.Prompt.style.top= 50;
   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================
//show document
//==============================================================================
function popAsnDtlPanel(po, asn, asndt, ctn, shp, rcv, itm, manRcv, ctnSts, ctnInv, ctnDate, ctnTime)
{
	var panel = ""
		 + "<table class='DataTable1'>"
		   + "<tr>"
		     + "<th style='text-align:center' nowrap>PO: " + po + "</th>"
		     + "<th style='text-align:center' nowrap>ASN: " + asn + "</th>"
		     + "<th style='text-align:center' nowrap>ASN Date: " + asndt + "</th>"		     
		   + "</tr>"
		   + "<tr><td colspan=3>"
		   
		   + "<table border=1 cellPadding='0' cellSpacing='0' style='background: ccffcc; font-size=11px'>"
		   + "<tr style='background: #FDC7AF;'>" 
		     + "<th>No.</th><th>Carton #</th><th># of<br>Items</th><th>Qty<br>Shipped</th><th>Qty<br>Received</th>"
		     + "<th>Manually<br>Received<br>Qty</th>"
		     + "<th>Problem?</th>"
		   + "</tr>"
		   
		var totshp = 0;
		var totrcv = 0; 
		var totman = 0; 
		for(var i=0; i < ctn.length; i++)
		{
			var prob = "";
			if(ctnSts[i]=="DROP SHIP")
			{
				if(ctnInv[i]=='1'){ prob = "Invld Ctn"}
				else if(ctnInv[i]=='2'){ prob = "Prev Rcpt"}
				else if(ctnInv[i]=='3'){ prob = "Not EDI"}
				else if(ctnInv[i]=='4'){ prob = "Invld ASN"}
				else if(ctnInv[i]=='5'){ prob = "Wrong Str"}
				else if(ctnInv[i]=='6'){ prob = "Diff ASN"}
				else if(ctnInv[i]=='7'){ prob = "Invld PO"}
				else if(ctnInv[i]=='8'){ prob = "Busy PO"}
				else if(ctnInv[i]=='9'){ prob = "PO Mismch"}
				prob += " " + ctnDate[i] + " " + ctnTime[i];  
			}
				
			panel += "<tr>"		
			panel += "<td>" + (i + 1) + "</td>"
			panel += "<td><a href='javascript: getASNDtl(&#34;" + po + "&#34;,&#34;" + asn 
			     + "&#34;,&#34;" + asndt + "&#34;,&#34;" + ctn[i] + "&#34;,&#34;Item&#34;)' >" + ctn[i] + "</a></td>"
			panel += "<td style='text-align:center'>" + itm[i] + "</td>"
			panel += "<td style='text-align:center' nowrap>" + shp[i] + "</td>"
			panel += "<td style='text-align:center'>" + rcv[i] + "</td>";	
			panel += "<td style='text-align:center'>" + manRcv[i] + "</td>";
			panel += "<td style='text-align:center' nowrap>" + prob + "</td>";
			panel += "</tr>"
			totshp += eval(shp[i]);
			if(rcv[i] != ""){totrcv += eval(rcv[i]);}
			totman += eval(manRcv[i]);
		}  
		
		panel += "<tr style='background: cornsilk'>"		
		  panel += "<td>&nbsp;</td>"
		  panel += "<td style='text-align: center'>Total</td>"
		  panel += "<td style='text-align: center'>&nbsp;</td>"
		  panel += "<td style='text-align: center ' nowrap>" + totshp + "</td>"
		  panel += "<td style='text-align: center ' nowrap>" + totrcv + "</td>"
		  panel += "<td style='text-align: center ' nowrap>" + totman + "</td>"
		  panel += "<td style='text-align: center ' nowrap>&nbsp;</td>"
		panel += "</tr>"
		
		
		
		panel += "</table>";   
		   
		panel += "</td></tr>";
		panel += "<tr><td style='text-align:center' colspan=3><button class='Small' onclick='hidePanel()'>Close</button></td></tr>";
		panel += "</table>";
		return panel;	  
}
//==============================================================================
//show ASN Details
//==============================================================================
function showASNItem(po, asn, asndt, ctn, sku, shp, rcv, desc, color, size, vensty, upc, rcvuser, seq, manrcv)
{
	clearInterval( progressIntFunc );
	progressTime = 0;
	document.all.dvOptSel.innerHTML = " ";
	document.all.dvOptSel.style.display = "none";
	
	var html = "<table class='DataTable'>"
   	+ "<tr>"
    	+ "<td class='BoxName' nowrap>ASN Carton List</td>"
    	+ "<td class='BoxClose' valign=top>"
      		+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel2();' alt='Close'>"
    	+ "</td>"
  	+ "</tr>"
  	+ "<tr><td class='Prompt' colspan=2>" + popAsnItemPanel(po, asn, asndt, ctn, sku, shp, rcv
  			, desc, color, size, vensty, upc, rcvuser, seq, manrcv)
   	+ "</td></tr>"
  
	html += "</table>"
	
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left= 300;
	document.all.dvItem.style.top= 100;	
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// build asn item panel
//==============================================================================
function popAsnItemPanel(po, asn, asndt, ctn, sku, shp, rcv, desc, color, size, vensty, upc, rcvuser, seq, manrcv)
{
	var rcvus = "";
	if(rcvuser[0].substring(0,4) != "0000"){rcvus = rcvuser[0]; }
	
	var panel = ""
		 + "<table class='DataTable'>"
		   + "<tr>"
		     + "<th class='DataTable' style='text-align: leftr' nowrap>PO: " + po + "</th>"
		     + "<th class='DataTable' style='text-align: left' nowrap>ASN Date: " + asndt + "</th>"
		   + "</tr>"
		   + "<tr>"
		   	 + "<th class='DataTable' style='text-align: left' nowrap>ASN: " + asn + "</th>"
	         + "<th class='DataTable' style='text-align: left' nowrap>Carton: " + ctn + "</th>"
	       + "</tr>"
		   + "<tr>"
			   	 + "<th class='DataTable' style='text-align: left' nowrap>Received by: " + rcvus + "</th>"  
		   + "</tr>"
		   + "<tr><td colspan=2>"
		   
		   + "<table class='DataTable1'>"
		   + "<tr style='background: #FDC7AF;'>" 
		     + "<th class='DataTable'>No.</th>" 
		     + "<th class='DataTable'>Description</th>"
		     + "<th class='DataTable'>Color</th><th class='DataTable'>Size</th>"
		     + "<th class='DataTable'>Vendor Style</th><th class='DataTable'>UPC</th>" 
		     + "<th class='DataTable'>SKU</th><th class='DataTable'>Seq</th>" 
		     + "<th class='DataTable'>Qty<br>Shipped</th><th class='DataTable'>Qty<br>Received</th>"
		     + "<th class='DataTable'>Manually<br>Received<br>Qty</th>"
		   + "</tr>"
		  
		var totshp = 0;
		var totrcv = 0;
		var totman = 0;
		
		for(var i=0; i < sku.length; i++)
		{
			panel += "<tr>"		
			  panel += "<td class='DataTable' nowrap>" + (i + 1) + "</td>"
			  panel += "<td class='DataTable1' nowrap>" + desc[i] + "</td>"
			  panel += "<td class='DataTable1' nowrap>" + color[i] + "</td>"
			  panel += "<td class='DataTable1' nowrap>" + size[i] + "</td>"
			  panel += "<td class='DataTable1' nowrap>" + vensty[i] + "</td>"
			  panel += "<td class='DataTable' nowrap>" + upc[i] + "</td>"
			  panel += "<td class='DataTable' nowrap>" + sku[i] + "</td>"
			  panel += "<td class='DataTable' nowrap>" + seq[i] + "</td>"
			  panel += "<td class='DataTable' nowrap>" + shp[i] + "</td>"
			  panel += "<td class='DataTable'>" + rcv[i] + "</td>";
			  panel += "<td class='DataTable'>" + manrcv[i] + "</td>";
			panel += "</tr>"
			totshp += eval(shp[i]);
			if(rcv[i] != ""){totrcv += eval(rcv[i]);}
			totman += eval(manrcv[i]);
		}  
		   
		panel += "<tr style='background: cornsilk'>"		
		  panel += "<td>&nbsp;</td>"
		  panel += "<td style='text-align: center' colspan=7 >Total</td>"
		  panel += "<td style='text-align: center ' nowrap>" + totshp + "</td>"
		  panel += "<td style='text-align: center ' nowrap>" + totrcv + "</td>"
		  panel += "<td style='text-align: center ' nowrap>" + totman + "</td>"
		panel += "</tr>"   
		   
		panel += "</table>";   
		   
		panel += "</td></tr>";
		panel += "<tr><td style='text-align:center' colspan=2><button class='Small' onclick='hidePanel2()'>Close</button></td></tr>";
		panel += "</table>";
		return panel;	  
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showExistOptProg()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:10px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvOptSel.innerHTML = html;
	document.all.dvOptSel.style.left=400;
	document.all.dvOptSel.style.top=200;
	document.all.dvOptSel.style.height = "20px";
	document.all.dvOptSel.style.display = "block";
}
//==============================================================================
// show document
//==============================================================================
function rtvDoc(po)
{
	var url = "POUplDocList.jsp?PO=" + po
	window.frame1.document.location.href=url;
}
//==============================================================================
//add new vendor packing lsit
//==============================================================================
function showDoc(po, seq, ext, rcvdt, emp, ctn, itm, commt)
{	
	var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
	      + "<tr>"
	       + "<td class='BoxName' nowrap>Vendor Packing Document List</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td>"
	      + "</tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popShowDocPanel(po, seq, ext, rcvdt, emp, ctn, itm, commt)
	      + "</td></tr>"	     
	      + "</td></tr>"

	   html += "</table>"

	   document.all.Prompt.innerHTML = html;
	   document.all.Prompt.style.left= 200;
	   document.all.Prompt.style.top= 50;
	   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================
//add new vendor packing lsit
//==============================================================================
function popShowDocPanel(po, seq, ext, rcvdt, emp, ctn, itm, commt)
{
	var panel = ""
	 + "<table class='DataTable1' style='font-size=12px'>"
	   + "<tr>"
	     + "<td style='text-align:center'>PO: " + po + "</td>" 
	   + "</tr>"
	   + "<tr><td>Documents: "
	   
	   + "<table  class='DataTable1' style='background: ccffcc; font-size=11px'>"
	   + "<tr style='background: #FDC7AF;'>" 
	   + "<th class='DataTable'>Doc</th>"
	   + "<th class='DataTable'>RcvDt</th>" 
	   + "<th class='DataTable'>Emp</th>"
	   + "<th class='DataTable'>Num<br>Of<br>Ctn</th>"  
	   + "<th class='DataTable'>Num<br>Of<br>Units</th>"
	   + "<th class='DataTable'>Comment</th><th>Dlt</th>"
	   + "</tr>"
	   
	for(var i=0; i < seq.length; i++)
	{
		var path = "PO_Pack_List/"
		 + "PO" + po + "_" + seq[i] + "." + ext[i];
		
		panel += "<tr>"
		
		if(ext[i].trim() != ""){ panel += "<td><a href='" + path + "' target='_blank'>" + (i+1) + "</a></td>"; }
		else{ panel += "<td>Cmt</td>"; }
		
		panel += "<td>" + rcvdt[i] + "</td>"
		panel += "<td nowrap>" + emp[i] + "</td>"
		
		if(ext[i].trim() != ""){ panel += "<td style='text-align:center'>" + ctn[i] + "</td>"; }
		else{ panel += "<td>&nbsp;</td>"; }
		
		if(ext[i].trim() != ""){panel += "<td>" + itm[i] + "</td>"; }
		else{ panel += "<td>&nbsp;</td>"; }
		
		panel += "<td nowrap>" + commt[i] + "</td>"		 
		if(ext[i].trim() != ""){ panel += "<td><a href='javascript: dltDoc(&#34;" + po + "&#34;,&#34;" + seq[i] 
		 + "&#34;, &#34;" + ext[i] + "&#34;)'>D</a></td>"; }
		else{ panel += "<td>&nbsp;</td>"; }
		
		panel += "</tr>"
	}  
	panel += "</table>";   
	   
	panel += "</td></tr>";
	panel += "<tr><td style='text-align:center'><button onclick='hidePanel()'>Close</button></td></tr>";
	panel += "</table>";
	return panel;	     
}
//==============================================================================
//add new vendor packing lsit
//==============================================================================
function dltDoc(po, seq, ext)
{
	var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
	      + "<tr>"
	       + "<td class='BoxName' nowrap>Confirm Document Deletion</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td>"
	      + "</tr>"
	     + "<tr><td class='Prompt' colspan=2 nowrap>"
	        + "<br>Are you sure you want to delete this document?<br><br>" 
	        + "<button onclick='hidePanel1()'>Close</button> &nbsp;"
	        + "<button onclick='sbmDltDoc(&#34;" + po + "&#34;,&#34;" + seq 
			+ "&#34;, &#34;" + ext + "&#34;)'>Delete</button><br>&nbsp;"
	      + "</td></tr>"	     
	     
	   html += "</table>"

	   document.all.dvCnfDlt.innerHTML = html;
	   document.all.dvCnfDlt.style.left= 200;
	   document.all.dvCnfDlt.style.top= 50;
	   document.all.dvCnfDlt.style.visibility = "visible";	
}
//==============================================================================
//add new vendor packing lsit
//==============================================================================
function sbmDltDoc(po, seq, ext)
{
	var url= "POUplDocDlt.jsp?PO=" + po
	 + "&Seq=" + seq
	 + "&Ext=" + ext
	window.frame1.location.href=url; 
}
//==============================================================================
// add new vendor packing lsit
//==============================================================================
function addDoc(po, str, asn, asndt, asnshp, asnrcv)
{
	var html = "<table class='DataTable'>"
	      + "<tr>"
	       + "<td class='BoxName' nowrap>Add Vendor Packing List</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td>"
	      + "</tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popAddDocPanel(po, str, asn, asndt, asnshp, asnrcv)
	      + "</td></tr>"	     
	      + "</td></tr>"

	   html += "</table>"

	   document.all.Prompt.innerHTML = html;
	   document.all.Prompt.style.left= 110;
	   document.all.Prompt.style.top= 70;
	   document.all.Prompt.style.visibility = "visible";
	   
	   doSelDate();
	   setEmpLst();
}
//==============================================================================
//add new vendor packing lsit
//==============================================================================
function popAddDocPanel(po, str, asn, asndt, asnshp, asnrcv)
{
	var panel = "";
	
	if(asn.length > 0)
	{
		panel += setAsnSum(asn, asndt, asnshp, asnrcv);
	}
	
	panel += "<table class='DataTable1'>"
	   + "<tr>"
	     + "<td style='text-align:left; font-size:11px'>"
	        + "PO: " + po	         
	           + "<form name='Upload'  method='post' enctype='multipart/form-data' action='POUploadDoc.jsp'>"	           	  
	            + "<table style='text-align:left; font-size:11px'>"
	             + "<tr>" 
	              + "<td nowrap>Date Received:</td>"
	              + "<td>"
	                + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;RcvDt&#34;)'>&#60;</button>"
	                + "<input class='Small' name='RcvDt' maxlength=10 size=10 readonly>"
	                + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;RcvDt&#34;)'>&#62;</button>"
	                + "&nbsp;<a href='javascript:showCalendar(1, null, null, 450, 150, document.all.RcvDt)'>"
	          		+ "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
	                + "<input type='hidden' name='Po' value='" + po + "'>"
               	    + "<input type='hidden' name='FileName'>"
               	  + "</td>"  
	             + "</tr>"
	             
	             + "<tr>" 
	              + "<td nowrap>Verified by Empl#:</td>" 	               
	              + "<td><input class='Small' name='Emp' maxlength=4 size=4>"
	                + "&nbsp;<select class='Small' name='SelEmp' onchange='setSelEmp()'></select>"
	              + "</td>"
	             + "</tr>"
		         
	             + "<tr>" 
	              + "<td nowrap>Total # of Cartons:</td>" 	               
	              + "<td><input class='Small' name='NumCtn' maxlength=3 size=3></td>"
	             + "</tr>"
		         
	             + "<tr>" 
	              + "<td nowrap>Total Units Received:</td>" 	               
	              + "<td><input class='Small' name='NumUnt' maxlength=3 size=3></td>"
	             + "</tr>"
		         
	             + "<tr>"
	              + "<td>Comments:</td>" 	               
	              + "<td><input class='Small' name='Commt' maxlength=100 size=100></td>"
	             + "</tr>"
		       
	             + "<tr>"  
	              + "<td>Document:</td>"	           	   
	              + "<td><input type='File' name='Doc' class='Small' size=50></td>"
	             + "</tr>"
	             
	             + "<tr>"  
	              + "<td style='color:red' id='tdError1' colspan=2></td>"
	             
	            + "</table>"  
	           + "</form>"
	           + "<button name='Submit' class='Small' onClick='vldUpload(true)'>Upload</button> &nbsp; "	           
	           + "<button class='Small' onclick='hidePanel();'>Close</button> &nbsp; "	           
	           + "<button name='sbmCommentt' class='Small' onClick='vldUpload(false)'>Save Comments</button> &nbsp; "	           
	           + "<input type='hidden' name='Str' value='" + str + "'>"
	           + "</td></tr>"
	     + "</table>";
	return panel;	     
}
//==============================================================================
// set ASN summary on top
//==============================================================================
function setAsnSum( asn, asndt, asnshp, asnrcv)
{
	var panel = "<table class='DataTable1'>"
		+ "<tr>"
			+ "<th class='DataTable' nowrap>ASN</th>"
			+ "<th class='DataTable' nowrap>ASN Date</th>"
			+ "<th class='DataTable' nowrap>Qty<br>Shipped</th>"
			+ "<th class='DataTable' nowrap>Qty<br>Received</th>"
		+ "</tr>";     
    for(var i=0; i < asn.length; i++)
    {
    	panel += "<tr class='DataTable'>"		
	    		+ "<td class='DataTable' nowrap>" + asn[i] + "</td>"
	    		+ "<td class='DataTable' nowrap>" + asndt[i] + "</td>"
	    		+ "<td class='DataTable' nowrap>" + asnshp[i] + "</td>"
	    		+ "<td class='DataTable' nowrap>" + asnrcv[i] + "</td>"
			+ "<tr>"
    }  
	panel + "</table>";	
	return panel;
}
//==============================================================================
// validate document entry
//==============================================================================
function vldUpload(saveDoc)
{  
	var error = false;
	var msg = "";
	var br = "";
	document.all.tdError1.innerHTML = "";
	
	var emp = document.all.Emp.value.trim();
	if(emp == ""){ error=true; msg += br + "Please enter your Employee number."; br="<br>";}
	else if (!isEmpNumValid(emp)){error = true; msg += br + "Employee number is invalid."; br="<br>";}
	
	var commt = document.all.Commt.value.trim();
	 
	// save document
	if(saveDoc)
	{	
		var ctn = document.all.NumCtn.value.trim();
		if(ctn == ""){ error=true;  msg += br + "Please enter Number of Cartons you received."; br="<br>";}
		else if(isNaN(ctn)){ error=true; msg += br + "Please enter valid number into Number of Cartons."; br="<br>";}
	
		var unit = document.all.NumUnt.value.trim();
		if(isNaN(unit)){ error=true; msg += br + "Please enter valid number into Number of Units."; br="<br>";}
	
		var doc = document.Upload.Doc.value;
		if(doc == ""){ error=true; msg += br + "Please enter path to uploading document."; br="<br>";}
	}
	// save comment only
	else
	{
		if(commt == ""){ error=true; msg += br + "Please enter Comment text."; br="<br>";}
	}
	
	var po =  document.Upload.Po.value;
	var str = document.all.Str.value;
	if(saveDoc)
	{
		po = po + "|" + str;
		document.Upload.Po.value = po;
	}
	
	if(error){document.all.tdError1.innerHTML = msg;}
	else
	{ 
		if(saveDoc){sbmUpload();}
		else{sbmCommt(po, emp, commt);}
	}
    
}
//==============================================================================
//check employee number
//==============================================================================
function isEmpNumValid(emp)
{
	var valid = true;
	var url = "EComItmAsgValidEmp.jsp?Emp=" + emp;
	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
   		if (xmlhttp.readyState==4 && xmlhttp.status==200)
   		{
      		valid = xmlhttp.responseText.indexOf("true") >= 0;
   		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	return valid;
}
//==============================================================================
//submit new document uploading
//==============================================================================
function sbmUpload()
{	
   var form = document.all.Upload;
   window.frame1.document.body.appendChild(form);   
   window.frame1.document.Upload.FileName.value = window.frame1.document.Upload.Doc.value;  
   window.frame1.document.Upload.SelEmp.disabled=true;
   window.frame1.document.Upload.submit();
   hidePanel();
}
//==============================================================================
//submit new document uploading
//==============================================================================
function sbmCommt(po, emp, commt)
{
	var nwelem = "";
	
	commt = commt.replace(/\n\r?/g, '<br />');

	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
	
    nwelem.id = "dvSaveCommt"

    var html = "<form name='frmSaveCommt'"
       + " METHOD=Post ACTION='PoCommtSv.jsp'>"
       + "<input name='Po'>"
       + "<input name='Emp'>"
       + "<input name='Commt'>"
       + "<input name='Action'>"
    html += "</form>"

   	nwelem.innerHTML = html;
   	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   	else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   	else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
   	else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   	if(isIE || isSafari)
	{
   		window.frame1.document.all.Po.value = po;
   		window.frame1.document.all.Emp.value = emp;
  		window.frame1.document.all.Commt.value = commt;
   		window.frame1.document.all.Action.value="Save_Commt";
   		window.frame1.document.frmSaveCommt.submit();
	}
   	else
   	{
   		window.frame1.contentDocument.forms[0].Po.value = po;
   		window.frame1.contentDocument.forms[0].Emp.value = emp;
  		window.frame1.contentDocument.forms[0].Commt.value = commt;
   		window.frame1.contentDocument.forms[0].Action.value="Save_Commt";
   		window.frame1.contentDocument.forms[0].submit();   		
   	}
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function  restart()
{
	window.location.reload();
}
//==============================================================================
//populate date with yesterdate
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
//populate date with yesterdate
//==============================================================================
function  doSelDate()
{
	var date = new Date();
	date.setHours(18)
    document.all.RcvDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
// set employee selection
//==============================================================================
function setEmpLst()
{	
	if(ArrEmp != null )
	{
		document.all.SelEmp.options[0] = new Option( "---- Select Store Employee ----", "NONE");
		for(var i=0; i < ArrEmp.length;i++)
		{
			document.all.SelEmp.options[document.all.SelEmp.length] = new Option( ArrEmp[i] + " - " + ArrEmpNm[i], ArrEmp[i]);
		}
	}
	document.all.SelEmp.tabIndex="-1";

}
//==============================================================================
//set employee selection
//==============================================================================
function setSelEmp()
{
	document.all.Emp.value = document.all.SelEmp.options[document.all.SelEmp.selectedIndex].value;
}
//--------------------------------------------------------
//Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
	document.all.Prompt.innerHTML = " ";
	document.all.Prompt.style.visibility = "hidden";
}
function hidePanel1()
{
	document.all.dvCnfDlt.innerHTML = " ";
	document.all.dvCnfDlt.style.visibility = "hidden";
}
//--------------------------------------------------------
//Hide selection screen
//--------------------------------------------------------
function hidePanel2()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}
</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<HTML>
<HEAD>
  <META content="RCI, Inc." name=POList>
</HEAD>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
  <div id="dvItem" class="dvItem"></div>
  <div id="dvCnfDlt" class="dvCnfDlt"></div>
  <div id="dvOptSel" class="dvOptSel"></div>
  <!-------------------------------------------------------------------->
  <div id="dvPOLink" class="dvPOLink"></div>
  <div id="dvSelect" class="dvSelect"></div>
  <div id="dvVendor" class="dvVendor"></div>
  
  <div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/Vendor Drop Ship Purchase Orders.pdf" title="Click here for help" class="helpLink" target="_blank">&nbsp;</a></div>
  <!-------------------------------------------------------------------->
  
<!-------------------------------------------------------------------->

<!-- ======================================================================= -->
      <div id="dvBody" style="clear: both; overflow: AUTO; width: 100%; height: 100%; POSITION: relative; color:black;" >
       <table class="DataTable" id="tbRtvEnt">
         <thead>
         
         <tr bgColor=moccasin style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop-2);">
           <td vAlign=top align=middle colspan=25><B>Retail Concepts Inc.
            <br><%if(!sToDate.equals("TODAY")){%>Vendor Drop Shipment List<%}
                else {%>ASN PO Receipts Today<%}%>
            </b><br>
            
            

            <a href="../" class="small"><font color="red">Home</font></a>&#62;            
            <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
          </td>
         </tr>
         <!-- ===================== End report heading ================================== -->
          
         <!-- ===================== table heading line 1 ================================== --> 
         <tr bgColor=moccasin style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop-2);">
         	<th colspan=6>&nbsp;</th>
         	<th class="DataTable" style="background: #cccfff" colspan=5>EDI - Advanced Shipment Notice (ASN) Details</th>
         	<th class="DataTable" style="background: #ccffcc" colspan=4>Total - PO Details</th>
         	<th colspan=12>&nbsp;</th>
         </tr>
         
         <!-- ===================== table heading line 2 ================================== -->         
         <tr class="DataTable" style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop-2);">
           <th class="DataTable">No.</th>
           <th class="DataTable"><a href="javascript: sbmSort('STR')">Str</a></th>           
           <th class="DataTable"><a href="javascript: sbmSort('PON')">P.O.<br>Number</a></th>
           <th class="DataTable"><a href="javascript: sbmSort('VEN')">Vendor</a></th>
           <th class="DataTable">Vendor<br>Packing<br>List</th>
           <th class="DataTable">EDI</th>           
           <th class="DataTable">ASN is Ready<br><a href="javascript: sbmSort('ASNDT')">Shipment Date</a></th>
           <%if(!sToDate.equals("TODAY")){%>
           		<th class="DataTable">Cartons/Items<br>Scan Recvd<br><a href="javascript: sbmSort('LRCTDT')">Date</a></th>
           <%}%>
           <th class="DataTable"># of<br>Ctn<br>Ship</th>
           <th class="DataTable"># of<br>Ctn<br>Recv</th>
           <th class="DataTable">Total<br>Ship<br>Qty</th>
           
           
           <!--  th class="DataTable"><a href="javascript: sbmSort('SHIPDT')">Estimated<br>Ship Date</a></th -->
                      
           <th class="DataTable">Total<br>Recv<br>Qty</th>
           <th class="DataTable">Remain<br>Open<br>Qty</th>
           <th class="DataTable">PO<br>Orig<br>Qty</th>           
           <th class="DataTable">Last/All<br>Receipt<br>Dates</th>
           <th class="DataTable" nowrap><a href="javascript: sbmSort('NUMRCT')"># of<br>Rcpts</a></th>
           <th class="DataTable" nowrap><a href="javascript: sbmSort('RCVPRC')">%<br>Recvd</a></th>
           <th class="DataTable" nowrap><a href="javascript: sbmSort('ONHQTY')">Items w/<br>Neg Qty<br>On Hand</a></th>
           <!-- th class="DataTable">Total<br>Retail</th -->
           
           <th class="DataTable"><a href="javascript: sbmSort('ANTCDT')">Anticipated<br>Delivery Date</a></th>
           
           <%if(sToDate.equals("TODAY")){%>
              <th class="DataTable">Last<br>ASN<br>Receipt</th>
              <th class="DataTable">Corrections</th>
           <%}%>
           
           <th class="DataTable">Invoice<br>Date & <br>Match</th> 
           <th class="DataTable"><a href="javascript: sbmSort('DIV')">Division</a></th>           
           <th class="DataTable">Buyer</th>                      
           <th class="DataTable"><a href="javascript: sbmSort('CNLDT')">Cancel<br>Date</a></a></th>           
           <th class="DataTable"><a href="javascript: sbmSort('BLK')">Original<br>Blockout</a></th>
           <th class="DataTable">Close</th>
         </tr>
         </thead>

       <!-- ============================ Details =========================== -->
       <tbody style="overflow: auto">
       <%for(int i=0; i < iNumOfPo; i++ ){    	   
           polist.setPOArr();
           
           String sPo =  polist.getPo();
           String sDiv = polist.getDiv();
           String sDivName = polist.getDivName();
           String sVen = polist.getVen();
           String sVenName = polist.getVenName();
           String sAntcDate = polist.getAntcDate();
           String sCrtDate = polist.getCrtDate();
           String sDisc = polist.getDisc();
           String sOrig = polist.getOrig();
           String sRevNum = polist.getRevNum();
           String sBuyer = polist.getBuyer();
           String sRetail = polist.getRetail();
           String sCost = polist.getCost();
           String sShipDate = polist.getShipDate();
           String sComment = polist.getComment();
           String sSts = polist.getSts();
           String sBlockout = polist.getBlockout();
           String sStr = polist.getStr();
           //System.out.print(" sstr=" + sStr);
           String sCancelDt = polist.getCancelDt();
           String sLastRctDt = polist.getLastRctDt();
           String sOrigQty = polist.getOrigQty();
           String sRcvQty = polist.getRcvQty();
           String sOpenQty = polist.getOpenQty();
           String sDropShip = polist.getDropShip();
           String sCurrDropShip = polist.getCurrDropShip();
           String sIsEdi = polist.getIsEdi();
           int iNumAsn = polist.getNumAsn();
           String [] sIsAsn = polist.getIsAsn();
           String [] sAsnQty = polist.getAsnQty();
           String [] sAsnNum = polist.getAsnNum();
           String sOnhQty = polist.getOnhQty();
           String sNumDoc = polist.getNumDoc();
           
           if(sPo.equals("113636")){  System.out.println("1.1. Po: " + sPo ); }
           
           int irow=1;
           if(iNumAsn > 1){ irow=iNumAsn; }
           
           String [] sAsnDt = polist.getAsnDt();
           String [] sAsnShpCtn = polist.getAsnShpCtn();
           String [] sAsnRcvCtn = polist.getAsnRcvCtn();
           String [] sAsnShpQty = polist.getAsnShpQty();
           String [] sAsnRcvQty = polist.getAsnRcvQty();
           
           String sClose = polist.getClose();
           String sRcvPrc = polist.getRcvPrc();
           String sNumRct = polist.getNumRct();
           String sInvDt = polist.getInvDt();
           String sInvMatch = polist.getInvMatch();
                      
           int iship = 0;
           int ircv = 0;
           int iremain = 0;
           
           String [] sRcvClr = new String[iNumAsn];
           String [] sRcvTxt = new String[iNumAsn];
           
           try{
           if(iNumAsn == 0){ sRcvClr = new String[]{ " " }; }
           
           
           
           int iAsnTotShpQty = 0;
           sRcvQty = sRcvQty.replaceAll(",", "");
           int iRcvQty = Integer.parseInt(sRcvQty);
            
           
           for(int j=0; j < iNumAsn; j++)
           {
        	   try
        	   {
        		   iAsnTotShpQty += Integer.parseInt(sAsnShpQty[j]);
        	   } 
        	   catch(Exception e){}
           }           
                      
           for(int j=0; j < iNumAsn; j++)
           {
        	   iship = 0;
               ircv = 0;
               iremain = 0;
               
        	   sRcvClr[j] = "";
        	   if(!sAsnShpCtn[j].equals("")){ iship = Integer.parseInt(sAsnShpCtn[j]); }
        	   
        	   if(!sOpenQty.equals("")){iremain = Integer.parseInt(sOpenQty);}
        	   
        	   if(!sAsnRcvCtn[j].trim().equals(""))
        	   {
        		   ircv = Integer.parseInt(sAsnRcvCtn[j]);        		   
        	   }
        	   
        	   if(iship > ircv && iremain > 0 && iRcvQty != iAsnTotShpQty){sRcvClr[j] = "style=\"background: pink\"";}
        	   
        	   sRcvTxt[j] = "";
        	   if(iship > ircv && iremain > 0 && iRcvQty == iAsnTotShpQty){sRcvTxt[j] = "None";}        	   
        	}
           }
           catch(Exception e)
           {
        	   System.out.println(
        		"xxxx sPo=" + sPo        		
        	    + "\niNumAsn=" + iNumAsn
        	    + " sAsnShpCtn=" + sAsnShpCtn[0]
        	    + " sOpenQty=" + sOpenQty
        		+ "\n" +  e.getMessage());        	   
           }
           
           String sAsnJsa = polist.cvtToJavaScriptArray(sAsnNum);
           String sAsnDtJsa = polist.cvtToJavaScriptArray(sAsnDt);
           String sAsnShpQtyJsa = polist.cvtToJavaScriptArray(sAsnShpQty);
           String sAsnRcvQtyJsa = polist.cvtToJavaScriptArray(sAsnRcvQty);            
       %>
         <tr id="trGroup" class="DataTable">
            <td class="DataTable" rowspan=<%=irow%> nowrap><%=i+1%></td>
            <td class="DataTable" rowspan=<%=irow%> nowrap><%=sStr%></td>
            <td class="DataTable1" rowspan=<%=irow%>  nowrap><a href="POWorksheet.jsp?PO=<%=sPo%>" class="small" target="_balnk"><%=sPo%></a></td>
            <td class="DataTable1" rowspan=<%=irow%> nowrap><%=sVenName%></td>                        
            <td class="DataTable1" id='tdPo<%=sPo%>' rowspan=<%=irow%> nowrap>
                <a href="javascript: addDoc('<%=sPo%>', '<%=sStr%>', [<%=sAsnJsa%>], [<%=sAsnDtJsa%>], [<%=sAsnShpQtyJsa%>], [<%=sAsnRcvQtyJsa%>] )">Add</a>&nbsp;&nbsp;
                <%if(!sNumDoc.equals("")){%>
                	<a href="javascript: rtvDoc('<%=sPo%>','<%=sStr%>')">P/L(<%=sNumDoc%>)</a>&nbsp;&nbsp;
                <%}%>
            </td>
            <td class="DataTable" rowspan=<%=irow%> style="<%if(sIsEdi.equals("Y")){%>background:yellow; font-weight:bold;<%}%>" nowrap><%=sIsEdi%></td>
            
            
            <td class="DataTable" nowrap>&nbsp;<%if(iNumAsn > 0){%>
                <%if(!sAsnDt[0].equals("01/01/0001")){%>
            		<a href="javascript: getASNDtl('<%=sPo%>', '<%=sAsnNum[0]%>', '<%=sAsnDt[0]%>', null, 'Carton')"><%=sAsnDt[0]%></a><%}%>
            	<%}%>
            </td>
            
            <%if(!sToDate.equals("TODAY")){%>
               <td class="DataTable" rowspan=<%=irow%> <%if(sCurrDropShip.equals("1")){%>style="background:lightgreen;"<%}%> nowrap>
                    <%if(sDropShip.equals("1")){%><a href="PODropCtnItm.jsp?PO=<%=sPo%>&LastRctDt=<%=sLastRctDt%>" target="_blank"><%=sLastRctDt%></a><%} else {%><%=sLastRctDt%><%}%>
               </td>
            <%}%>            
            <td class="DataTable" nowrap>&nbsp;<%if(iNumAsn > 0){%><%=sAsnShpCtn[0]%><%}%></td>
            <td class="DataTable"  <%=sRcvClr[0]%>  nowrap>&nbsp;<%if(iNumAsn > 0){%><%=sAsnRcvCtn[0]%><%if(sRcvTxt[0]!=null && !sRcvTxt[0].equals("null")){%><%=sRcvTxt[0]%><%}%><%}%></td>
            <td class="DataTable" nowrap>&nbsp;<%if(iNumAsn > 0){%><%=sAsnShpQty[0]%><%}%></td>            
            <td class="DataTable2" rowspan=<%=irow%> nowrap><%=sRcvQty%></td>
            <td class="DataTable2" rowspan=<%=irow%> nowrap><%=sOpenQty%></td>
            <td class="DataTable2" rowspan=<%=irow%> nowrap><%=sOrigQty%></td>
            
            <td class="DataTable" rowspan=<%=irow%>  nowrap>
              <%if(!sLastRctDt.equals("---")){%><a href="POAllReceipt.jsp?PO=<%=sPo%>" target="_blank"><%=sLastRctDt%></a><%} else {%><%=sLastRctDt%><%}%>
            </td>
            
            
            <td class="DataTable2" rowspan=<%=irow%> nowrap><%=sNumRct%></td>
            <td class="DataTable2" rowspan=<%=irow%> nowrap><%=sRcvPrc%></td>
            
            
            <td class="DataTable2<%if(sOnhQty.indexOf("-") > 0){%>1<%}%>" rowspan=<%=irow%> nowrap><%if(!sOnhQty.equals("0")){%><%=sOnhQty%><%}%></td>
            <!-- td class="DataTable2" rowspan=<%=irow%> nowrap>$<%=sRetail%></td -->
            
            <td class="DataTable1" rowspan=<%=irow%> nowrap><%=sAntcDate%></td>
            <%if(sToDate.equals("TODAY")){%>
               <td class="DataTable" rowspan=<%=irow%> <%if(sCurrDropShip.equals("1")){%>style="background:lightgreen;"<%}%> nowrap>
                    <%if(sDropShip.equals("1")){%><a href="PODropCtnItm.jsp?PO=<%=sPo%>&LastRctDt=<%=sLastRctDt%>"><%=sLastRctDt%></a><%} else {%><%=sLastRctDt%><%}%>
               </td>
               <td class="DataTable" rowspan=<%=irow%> <%if(sCurrDropShip.equals("1")){%>style="background:lightgreen;"<%}%> nowrap>
                 <a href="POAllReceipt.jsp?PO=<%=sPo%>&LastRctDt=<%=sLastRctDt%>&Asn=<%if(sToDate.equals("TODAY")){%>Y<%} else{%>N<%}%>">&nbsp;C&nbsp;</a>
               </td>
            <%}%>
            
            <td class="DataTable1" rowspan=<%=irow%> nowrap><%if(!sInvDt.equals("")){%><%=sInvDt + " - " + sInvMatch%><%}%></td>   
            <td class="DataTable1" rowspan=<%=irow%> nowrap><%=sDiv + " - " + sDivName%></td>            
            <td class="DataTable" rowspan=<%=irow%> nowrap><%=sBuyer%></td>  
            <td class="DataTable1" rowspan=<%=irow%> nowrap><%=sCancelDt%></td>            
            <td class="DataTable" rowspan=<%=irow%> nowrap><%=sBlockout%></td>
            <td class="DataTable" rowspan=<%=irow%> nowrap><%=sClose%></td>              
          </tr>
            
          <%if(irow > 1){%>
             <%for(int j=1; j < iNumAsn; j++){%>
                 <%if(sPo.equals("113636")){  System.out.println("4. " + j + ". Po: " + sPo ); } %>
          		<tr id="trGroup" class="DataTable">
            		<td class="DataTable" nowrap>&nbsp;
            		<%if(!sAsnDt[j].equals("01/01/0001")){%><a href="javascript: getASNDtl('<%=sPo%>', '<%=sAsnNum[j]%>', '<%=sAsnDt[j]%>', null, 'Carton')"><%=sAsnDt[j]%></a><%}%></td>
            		<td class="DataTable" nowrap>&nbsp;<%=sAsnShpCtn[j]%></td>
            		<td class="DataTable" <%=sRcvClr[j]%> nowrap>&nbsp;<%=sAsnRcvCtn[j]%><%=sRcvTxt[j]%></td>
            		<td class="DataTable" nowrap>&nbsp;<%=sAsnShpQty[j]%></td>
            	</tr> 	
            <%}%>
          <%}%>
          
       <%}%> 
        </tbody>
       </table>

       <p style="font-size=12px; text-align:left;">
Column Heading Links:
<br>PO Number:  click on the PO #, to open the PO Worksheet.
<br>Vendor Packing List:  click on the Add, to add a vendor packing list
<br>EDI/ASN: Shipment Date: If a date is displayed in this column the ASN is Ready to scan/receive via Paxar.  
<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
     Click on the Date, to view all Cartons shipped on this ASN, then click on the Carton # to view the Items within that carton.
<br>Last Received Date:  click on the Date, to view the Last/All Receipts for this PO. 
<br>
<br>Note:   If a PO is EDI=Y, but there are no Shipment Dates listed, cartons cannot be scanned via Paxar, and will display an error of "Invalid Carton".  
<br>You can either 1) Scan and upload the Packing List, Or 2) Fill out the Drop Shipment worksheet (an submit) to indicate the quantities received.


       </div>
<!-- ======================================================================= -->
</BODY></HTML>
<%
   polist.disconnect();
}%>

<%
long lEndTime = (new java.util.Date()).getTime();
long lElapse = (lEndTime - lStartTime) / 1000;
if (lElapse==0) {lElapse = 1;}
//System.out.println("B/Item X-fer loading Elapse time=" + lElapse + " second(s)");
%>
<p  style="text-align: left; font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>
  












