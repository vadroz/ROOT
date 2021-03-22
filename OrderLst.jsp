<%@ page import="patiosales.OrderLst ,java.util.*, java.text.*"%>
<%
   String [] sStatus = request.getParameterValues("Status");
   String [] sPyStatus = request.getParameterValues("PyStatus");
   String sInclSO = request.getParameter("InclSO");
   String [] sSoStatus = request.getParameterValues("SoStatus");

   String sFrOrdDate = request.getParameter("FrOrdDt");
   String sToOrdDate = request.getParameter("ToOrdDt");

   String sFrDelDate = request.getParameter("FrDelDt");
   String sToDelDate = request.getParameter("ToDelDt");

   String sRRN = request.getParameter("RRN");
   String sSort = request.getParameter("Sort");
   String sSku = request.getParameter("Sku");
   String sSelCust = request.getParameter("Cust");
   String sSlsPer = request.getParameter("SlsPer");
   String sSelOrd = request.getParameter("Order");

   String [] sStrGrp = request.getParameterValues("StrGrp");
   String [] sStrTrf = request.getParameterValues("StrTrf");

   String sStsOpt = request.getParameter("StsOpt");
   String sClaimOnly = request.getParameter("ClaimOnly");

   if(sSku==null) { sSku = " "; }
   if(sSelCust==null){ sSelCust = " ";}
   if(sSlsPer==null) { sSlsPer = " "; }
   if(sSelOrd==null){ sSelOrd = " "; }
   if(sRRN==null) { sRRN="0000000000"; }
   if(sSort==null) { sSort="ENTDT"; }
   if(sStatus == null) { sStatus = new String[]{" "}; }
   if(sPyStatus == null) { sPyStatus = new String[]{" "}; }
   if(sSoStatus == null){ sSoStatus = new String[]{" "}; }
   if(sStsOpt == null) { sStsOpt = "CURRENT";}
   if(sClaimOnly == null) { sClaimOnly = " "; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      //System.out.println("\n" + sStrGrp + "| Status " + sStatus[0] + "| sInclSO " + sInclSO + "| SoStatus " + sSoStatus[0] + "|" + sFrOrdDate
      //  + "|" + sToOrdDate + "|" + sSku + "|" + sRRN + "|" + sSort + "|" + sStsOpt);

      OrderLst ordlst = new OrderLst(sStrGrp, sStrTrf, sStatus, sInclSO, sSoStatus, sFrOrdDate, sToOrdDate
          , sFrDelDate, sToDelDate, sSku , sRRN, sSort, sStsOpt, sClaimOnly, sSelCust
          , sSlsPer, sSelOrd, sPyStatus, session.getAttribute("USER").toString());
      int iNumOfOrd = ordlst.getNumOfOrd();
      String sRepSubTotal = ordlst.getRepSubTotal();
      String sRepTotal = ordlst.getRepTotal();

      String sStatusJsa = ordlst.cvtToJavaScriptArray(sStatus);
      String sPyStatusJsa = ordlst.cvtToJavaScriptArray(sPyStatus);
      String sSoStatusJsa = ordlst.cvtToJavaScriptArray(sSoStatus);

      String sUser = session.getAttribute("USER").toString();
      boolean bSts = true;
      if  (sUser.trim().equals("cashr35") || sUser.trim().equals("cashr46")
       ||  sUser.trim().equals("cashr50") ||  sUser.trim().equals("cashr86")
       ||  sUser.trim().equals("cashr63") ||  sUser.trim().equals("cashr64")
       ||  sUser.trim().equals("cashr68") ||  sUser.trim().equals("cashr55")) bSts = false;

      String sUsrStr = session.getAttribute("STORE").toString();
      boolean bAllowGmPrc = session.getAttribute("PATGMP") != null;

      // statuses and names for order and spec order
      ordlst.setStsLst();
      String sStsLst = ordlst.getStsLstJsa();
      String sStsNmLst = ordlst.getStsNmLstJsa();

      ordlst.setSoStsLst();
      String sSoStsLst = ordlst.getSoStsLstJsa();
      String sSoStsNmLst = ordlst.getSoStsNmLstJsa();
%>

<html>
<head>
<title>Patio_Furniture_Sales_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:left; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable4 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right; font-size:11px; font-weight:bold;}
       
        td.DataTable5 { background: lightsalmon; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}                

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var User = "<%=sUser%>";
var RecUsr = ["dmikulan", "kknight", "psnyder", "vrozen"];

var Status = [<%=sStatusJsa%>]
var PyStatus = [<%=sPyStatusJsa%>]
var SoStatus = [<%=sSoStatusJsa%>]

var NumOfOrd = <%=iNumOfOrd%>
var StrGrp = new Array();
<%for(int i=0; i < sStrGrp.length; i++){%>StrGrp[<%=i%>] = "<%=sStrGrp[i]%>";<%}%>
var StrTrf = new Array();
<%for(int i=0; i < sStrTrf.length; i++){%>StrTrf[<%=i%>] = "<%=sStrTrf[i]%>";<%}%>


//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	showStrTrfCol();

   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
   switchSpcOrd()

   document.all.dvLegend.style.pixelLeft= document.documentElement.scrollLeft + 5;
   document.all.dvLegend.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvLegend.style.visibility = "visible";
   document.all.dvLegend.style.fontSize = "14px";
   document.all.dvLegend.style.width = "300px";
}

//==============================================================================
// show/hide store transfer column depend on store group selection
//==============================================================================
function showStrTrfCol()
{
  var schl = document.all.colSkiChl;
  var sstp = document.all.colSkiStp;
  if (StrGrp == "SKCH")
  {
     for(var i=0; i < sstp.length; i++)  {  sstp[i].style.display = "none"; }
  }
  else if (StrGrp == "SSTP")
  {
     for(var i=0; i < schl.length; i++)  {  schl[i].style.display = "none"; }
  }
}
//==============================================================================
// switch Special Order Progress colomns
//==============================================================================
function switchSpcOrd()
{
   sts = "block";
   sts1 = "inline";
   span = 4;
   spanth = 9;
   if (document.all.colSpcOrd[1].style.display != "none") { sts = "none"; span = 1; spanth = 6; sts1="none"}

   // switch colomns
   document.all.colSpcOrd[0].colSpan=span

   for(var i=1; i < document.all.colSpcOrd.length; i++)
   {
     document.all.colSpcOrd[i].style.display=sts;
   }
   if(NumOfOrd > 0) document.all.lnkSoStamp.style.display=sts1;

   document.all.thSpcOrd.colSpan = spanth;
}


//==============================================================================
// show screen with different sorting
//==============================================================================
function sortBy(sort)
{
  var url = "OrderLst.jsp?FrOrdDt=<%=sFrOrdDate%>&ToOrdDt=<%=sToOrdDate%>"
   + "&FrDelDt=<%=sFrDelDate%>&ToDelDt=<%=sToDelDate%>"

  for(var i=0; i < Status.length; i++)
  {
     url += "&Status=" + Status[i];
  }
  for(var i=0; i < SoStatus.length; i++)
  {
     url += "&SoStatus=" + SoStatus[i];
  }

  url += "&InclSO=<%=sInclSO%>" + "&Sort=" + sort
       + "&Sku=<%=sSku%>"
       + "&Cust=<%=sSelCust%>"
       + "&SlsPer=<%=sSlsPer%>"

  for(var i=0; i < StrGrp.length; i++){url += "&StrGrp=" + StrGrp[i]}
  for(var i=0; i < StrTrf.length; i++){url += "&StrTrf=" + StrTrf[i]}

  url += "&StsOpt=<%=sStsOpt%>";

  //alert(url);
  window.location.href=url;
}

//==============================================================================
// Change Order Status
//==============================================================================
function chgOrdSts(ord, sts, deldt, str)
{
   //check if order is paid off
   var hdr = "Change Order Status. Order:&nbsp;&nbsp;" + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStsPanel(ord, sts, deldt)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";
      
   document.all.DelDate.value = deldt;
   document.all.OrigStr.value = str;
   if(deldt == "01/01/0001")
   { 
	   document.all.DelDate.value = "CUST PICKUP";
	   document.all.Up.disabled = true;
	   document.all.Down.disabled = true;
   }
   
   if(sts != "R"){ document.all.trDelDt.style.display = "none"; }
}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popStsPanel(ord, sts, deldt)
{
  var posX = document.documentElement.scrollLeft + 600;
  var posY = document.documentElement.scrollTop + 60;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr id='trSel'><td class='Prompt'>New Status:</td>"
           + "<td class='Prompt'><select class='Small' name='NewSts' onchange='chkStsChg(this)' size=1>"
              + setNextSts(sts)
           + "</select></td>"
         + "</tr>"
         
  panel += "<tr id='trDelDt'><td class='Prompt'>"
	 	  + "Delivery Date:&nbsp;"
	 	+ "</td>"
	 	+ "<td class='Prompt'>"
     		+ "<button class='NonPrt' name='Down' onClick='setDate(&#34;DOWN&#34;)'>&#60;</button>"
     		+ " <input type='text' name='DelDate' readonly size=10 maxlength=10>"
     		+ "<button class='NonPrt' name='Up' onClick='setDate(&#34;UP&#34;)'>&#62;</button> &nbsp;&nbsp;"
     		+ "<a class='NonPrt' id='shwCal' href='javascript: showCalendar(1, null, null, 700, 100, document.all.DelDate, null, &#34;PfsCheckDelDate.jsp&#34;)' >"
     		+ "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
     		+ "<input name='OrigStr' type='hidden'>"
     	+ "</td>"    	
     + "</tr>"
       

  panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
      + "<button onClick='sbmNewSts(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// set Next Status
//==============================================================================
function setNextSts(sts)
{
   var panel = null;
   panel += "<option value='S'>Ready for Staging</option>"
          + "<option value='Z'>Call Customer for Delivery</option>"
          + "<option value='R'>Ready-To-Delivery</option>"
          + "<option value='X'>Not Delivered</option>"

   return panel;
}
//==============================================================================
//check new status
//==============================================================================
function chkStsChg(sel)
{
	if(sel[sel.selectedIndex].value == "R")
	{
		document.all.trDelDt.style.display = "block";
	}
	else
	{ 		
		document.all.trDelDt.style.display = "none"; 
	}
}
//==============================================================================
// check new status
//==============================================================================
function chkNewSts(sel)
{
  if(sel[sel.selectedIndex].value!="O")
  {
     document.all.trReg.style.display = "block";
     document.all.trTrans.style.display = "block";
  }

  if(sel[sel.selectedIndex].value!="F")
  {
     document.all.Reg.readOnly=true;
     document.all.Trans.readOnly=true;
  }
  else
  {
     document.all.Reg.readOnly=false;
     document.all.Reg.focus();
     document.all.Trans.readOnly=false;
  }
}
//==============================================================================
// submit new status
//==============================================================================
function sbmNewSts(ord)
{
   var reg = "";
   var trans = "";
   var error = false;
   var msg = "";
   var sts = document.all.NewSts[document.all.NewSts.selectedIndex].value
   var deldt = document.all.DelDate.value; 
   var str = document.all.OrigStr.value;
   
   if(sts == "R")
   {
	   // check, if date is not closed (exclude order for warranty issues).
	   chkClsDt(str, deldt);
	   var dcur = new Date();
	   dcur.setHours(16);
	   
	   if(deldt != "CUST PICKUP")
	   { 
		   var dtdel = new Date(deldt)	   
	   	   dtdel.setHours(18);
	       if(dcur > dtdel ) {  error = true; msg += "Del. Date cannot be less then today date.\n"  }
	   }
	   else{  error = true; msg += "Please select Pickup Date.\n"  }
   }   

   if(!error)
   {
      var url = "OrderHdrSave.jsp?Order=" + ord
       + "&Sts=" + sts
       + "&DelDate=" + deldt
       + "&Action=CHGSTS"
       
      if (sts=="F") url += "&Reg=0&Trans=0"
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
   else { alert(msg);}
}
//==============================================================================
//check if current date is closed for selection or available
//==============================================================================
function chkClsDt(str, chkdt)
{
	var url = "PfsCheckDelDate.jsp?single=Y";
	url += "&chkdt=" + chkdt
     + "&str=" + str;

	//alert(closed_dates_URL)
	window.frameChkCalendar.location.href=url;
}
//==============================================================================
//marked Closed date as unavailable
//==============================================================================
function markSingleDateSts(close)
{
	//window.frameChkCalendar.location.href=null;
	window.frameChkCalendar.close();
	if (close) alert("Selected date is closed for delivery.")
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function setDate(direction)
{
	var button = document.all.DelDate;
	if(button.value.trim() != "")
	{
		var date = new Date(button.value);

	    if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
   	    else if(direction == "UP") date = new Date(new Date(date) - -86400000);
   		button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
	}
}
//==============================================================================
// Change Special Order Status
//==============================================================================
function chgSoSts(ord, sts)
{
   var hdr = "Change Special Order Status. Order:&nbsp;&nbsp;" + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popSoStsPanel(ord, sts)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popSoStsPanel(ord, sosts)
{
  var posX = document.documentElement.scrollLeft + 600;
  var posY = document.documentElement.scrollTop + 60;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
     panel += "<tr id='trSel'><td class='Prompt'>New Status:</td>"
           + "<td class='Prompt'><select class='Small' name='NewSoSts' size=1>"
             + setNewSoSts(sosts)
           + "</select></td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
      + "<button onClick='sbmNewSoSts(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// set new special order status
//==============================================================================
function setNewSoSts(sosts)
{
   var panel = null;
   if(sosts == "N") panel = "<option value='A'>Approved</option>"
   if(sosts == "A") panel = "<option value='N'>Non-Approved</option>"

   return panel;
}
//==============================================================================
// submit new special order status
//==============================================================================
function sbmNewSoSts(ord)
{
   var sts = document.all.NewSoSts.value;

   var url = "OrderHdrSave.jsp?Order=" + ord
           + "&Sts=" + sts
           + "&Action=CHGSOSTS"
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
   hidePanel();
}
//==============================================================================
// show comments Panel
//==============================================================================
function showNotePanel(ord, exist)
{
   var hdr = "Order Note. Order:&nbsp;&nbsp;" + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popNotePanel(ord)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.width= 400;
   document.all.dvStatus.style.visibility = "visible";

   // retreive existing comments
   if(exist)
   {
      document.all.Comments.disabled = true;
      document.all.tdButton.style.visibility = "hidden";
      getOrdNote(ord, "NOT");
   }
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popNotePanel(ord, type)
{
  var posX = document.documentElement.scrollLeft + 600;
  var posY = document.documentElement.scrollTop + 60;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr id='trSel'><td class='Prompt'>Comments: </td>"
           + "<td class='Prompt'><TextArea class='Small' name='Comments' rows=4 cols=100>"
           + "</TextArea></td>"
         + "</tr>"
  panel += "<tr><td class='Prompt1' id='tdButton' colspan='2'><br><br>"
      + "<button onClick='sbmNote(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}

//==============================================================================
// submit new special order status
//==============================================================================
function sbmNote(ord)
{
   var text = document.all.Comments.value.trim(" ");

   var url = "OrderHdrSave.jsp?Order=" + ord
           + "&Comments=" + text.replaceSpecChar()
           + "&CommtType=NOT"
           + "&Action=ADDNOTE"
   //alert(text )
   //window.location.href=url
   window.frame1.location.href=url
   hidePanel();
}
//==============================================================================
// show comments and add new panel
//==============================================================================
function showCommtPanel(ord, cmtty, ven, ponum, str, lname, fname, total, ordtype, expdt, ordstsnm)
{
   var hdr = "Order Comments. Order:&nbsp;&nbsp;" + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCmtLogPanel(ord, ponum, str, lname, fname, total, ordtype, expdt, ordstsnm)
      + "</td></tr>"

    + "<tr><td class='Prompt' colspan=2 id='tdCmtLog'>"
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   var l = getLeftScreenPos() + 100;
   var t = getTopScreenPos() + 40;
   document.all.dvStatus.style.Left= l;
   document.all.dvStatus.style.Top= t;
   document.all.dvStatus.style.width= 700;
   document.all.dvStatus.style.visibility = "visible";

   getOrdNote(ord, "CMT");
   
   document.all.tdEmailAddr.style.display="none";
   document.all.tdSubj.style.display = "none";
   
   var iOpt = 0; 
   document.all.selEmailAddr.options[iOpt++] = new Option("--- Select email address ---", "NONE"); 
   document.all.selEmailAddr.options[iOpt++] = new Option("Dale Mikulan", "DMikulan@sunandski.com");
   document.all.selEmailAddr.options[iOpt++] = new Option("Kristen Threlkeld", "KThrelkeld@sunandski.com");
   document.all.selEmailAddr.options[iOpt++] = new Option("Matt Williams", "MWilliams@sunandski.com");   
   document.all.selEmailAddr.options[iOpt++] = new Option("Kelly Knight", "kknight@sunandski.com");
   document.all.selEmailAddr.options[iOpt++] = new Option("Polly Snyder", "psnyder@sunandski.com");
   document.all.selEmailAddr.options[iOpt++] = new Option("Vadim Rozen", "vrozen@sunandski.com");
   
   var toAddrNm = "Store" + str;
   var toAddr = "Store" + str + "@sunandski.com";
   document.all.selEmailAddr.options[iOpt++] = new Option(toAddrNm, toAddr);

   if (cmtty =="VCN")
   {
     document.all.CmtTy[2].checked = true;
     document.all.PoNum.value = ponum;
     document.all.Ven.value = ven;
   }
   else
   {
     document.all.tdVenConf.style.display = "none";
     document.all.CmtTy[0].checked = true;
   }
}
//==============================================================================
// get Order comments
//==============================================================================
function popCmtLogPanel(ord, ponum, str, lname, fname, total, ordtype, expdt, ordstsnm)
{
  var posX = document.documentElement.scrollLeft + 950;
  var posY = document.documentElement.scrollTop + 100;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap>"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='STORE'>Store's"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='BUYER'>Buyer's &nbsp; &nbsp; &nbsp;"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='VCN'>Vendor Confirmation &nbsp; &nbsp; &nbsp;"
                + "<input name='CmtTy' type='radio' onclick='chgCommt(this)' value='EMAIL'>E-Mail &nbsp; &nbsp; &nbsp;"
                
                + "<input name='Order' type='hidden' value='" + ord + "'>"
                + "<input name='OrgStr' type='hidden' value='" + str + "'>"
                + "<input name='LName' type='hidden' value='" + lname + "'>"
                + "<input name='FName' type='hidden' value='" + fname + "'>"
                + "<input name='Total' type='hidden' value='" + total + "'>"
                + "<input name='OrdType' type='hidden' value='" + ordtype + "'>"
                + "<input name='ExpDt' type='hidden' value='" + expdt + "'>"
                + "<input name='OrdStsNm' type='hidden' value='" + ordstsnm + "'>"                
              + "</td>"
         +  "</tr>"

         + "<tr class='DataTable' id='tdVenConf'>"
              + "<td class='DataTable' nowrap>"
                + "Vendor: <input name='Ven' size=8 maxlength=6 readonly> &nbsp; &nbsp; &nbsp;"
                + "Confirmation Number: <input name='VenConf'  size=20 maxsize=20>"
                + "<br>P.O.Number: <input name='PoNum' size=10 readonly> &nbsp; &nbsp; "
                + "Vendor Delivery Date Date: "
                + "<input class='Small' name='VenDelDate' readonly size=10 maxlength=10> &nbsp; &nbsp;"
                + "<a class='Small' id='shwCal' href='javascript:showCalendar(1, null, null," + posX + "," + posY + ", document.all.VenDelDate)' >"
                + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
              + "</td>"
         +  "</tr>"
         
         + "<tr class='DataTable' id='tdSubj'>"
             + "<td class='DataTable' nowrap>Subject: "
             + "<input class='Small' name='Subj' size='50' maxlength='50'> &nbsp; &nbsp;"
             + "</td>"
         +  "</tr>"

         + "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap><textarea name='txaComment' cols=50 rows=4></textarea></td>"
         + "</tr>"
         
         + "<tr class='DataTable'>"
         + "<td class='DataTable' id='tdEmailAddr' nowrap>" 
             + "<input name='EmailAddr' maxlength='50' size='50'>"
             + "<br><select class='Small' name='selEmailAddr' onchange='setEmailAddr(this)'></select>"
         + "</td>"
      + "</tr>"
         
         + "<tr class='DataTable6'><td class='DataTable' id='tdErrMsg' nowrap></td></tr>"
  panel += "<tr><td class='DataTable2'>"
        + "<button onClick='vldNewComment();' class='Small1'>Submit</button> &nbsp; &nbsp;"
        + "<button onClick='hidePanel();' class='Small1'>Close</button>"
        + "</td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// change comment panel
//==============================================================================
function chgCommt(obj)
{
   if(obj.value == "VCN"){document.all.tdVenConf.style.display = "block";}
   else { document.all.tdVenConf.style.display = "none"; }
   
   if(obj.value == "EMAIL") 
   { 
	    document.all.tdEmailAddr.style.display="block";
	    document.all.tdSubj.style.display = "block";
   } 
   else
   { 
	   document.all.tdSubj.style.display = "none";
	   document.all.tdEmailAddr.style.display="none";   
   }
}
//==============================================================================
// validate New Comment
//==============================================================================
function vldNewComment()
{
   var error = false;
   var msg = "";
   document.all.tdErrMsg.innerHTML="";
   document.all.tdErrMsg.style.color="red";

   var order = document.all.Order.value;
   var str = document.all.OrgStr.value;
   var lname = document.all.LName.value;
   var fname = document.all.FName.value;
   var total= document.all.Total.value;
   var ordtype = document.all.OrdType.value;
   var expdt = document.all.ExpDt.value; 
   var ordstsnm = document.all.OrdStsNm.value;

   
   var cmtty = null;
   for(var i=0; i < document.all.CmtTy.length; i++)
   {
       if(document.all.CmtTy[i].checked){ cmtty = document.all.CmtTy[i].value; break; }
   }

   var cmt = document.all.txaComment.value;
   var br = "";

   if(cmtty=="VCN")
   {
      var ven = document.all.Ven.value.trim();
      if(ven == "" || isNaN(ven) || eval(ven) <= 0 || eval(ven) < 999 )
      {
         error = true; msg += br + "Please enter correct vendor number.";
         br = "<br>";
      }
      var conf = document.all.VenConf.value.trim();
      if(conf==""){error = true; msg += br + "Please enter confirmation number."; br = "<br>";}

      var deldt = document.all.VenDelDate.value.trim();
      if(deldt == ""){ error = true; msg += br + "Please enter Vendor Delivery Date."; br = "<br>"; }
      var ponum = document.all.PoNum.value.trim();

      if(!error)
      {
         cmt = "Vendor: " + ven
             + ", P.O. # " + ponum
             + ", Delivery Date: " + deldt
             + ", Conf# " + conf + ". " + cmt.trim();
         br = "<br>";
      }
   }
   
   if(cmt==""){error = true; msg += br + "Please enter comment.";br = "<br>";}

   // -------------- Email -------------------
   var frAddr = "";   
   var toaddr = "";
   var subj = "";    
   var body = cmt;
   if(cmtty=="EMAIL")
   {
	   frAddr = "Store" + str + "@sunandski.com"
	   for(var i=0; i < RecUsr.length; i++)
	   {
		   if(User == RecUsr[i]){ frAddr =  RecUsr[i] + "@sunandski.com"; break; } 
	   }
	   toaddr = document.all.EmailAddr.value.trim();
	   if(toaddr == ""){error = true; msg += br + "Please enter Email recipient address.";br = "<br>";}
	   
	   if(ordstsnm == "Quote"){  subj = "Quote: " + order + " Comments: ";}
	   else{ subj = "Order: " + order + " Comments: "; }
	   
	   if (document.all.Subj.value.trim() == "")
	   {		   
			if(cmt.length < 30){ subj += body; }
			else{ subj += body.substring(0, 30) + "..."; }   
	   }
	   else { subj += document.all.Subj.value.trim(); }
	   cmt = "Emailed " + subj + ". From " + frAddr + ". " + body;	   
   }
   

   if(error){ document.all.tdErrMsg.innerHTML=msg; }
   else{sbmNewComment(order, cmtty, cmt, str, frAddr, toaddr, lname, fname, total, ordtype, expdt, subj, body)}
}
//==============================================================================
// submit New Comment
//==============================================================================
function sbmNewComment(order, cmtty, commt, str, frAddr, toaddr, lname, fname, total, ordtype, expdt, subj, body)
{
    commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='OrderHdrSave.jsp'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Comments'>"
       + "<input class='Small' name='CommtType'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Order.value = order;
   window.frame1.document.all.Comments.value=commt;
   window.frame1.document.all.CommtType.value=cmtty;
   window.frame1.document.all.Action.value="ADDCOMMENT";

   //alert(html)
   window.frame1.document.frmAddComment.submit();   
   
   if(cmtty == "EMAIL")
   {
       sbmEMail(frAddr, toaddr, order, subj, body, str, lname, fname, total, ordtype, expdt)   
   }
}

//==============================================================================
//email Order
//==============================================================================
function sbmEMail(frAddr, toaddr, order, subj, commt, str, lname, fname, total, ordtype, expdt)
{    	
	
	var body = getMsgBody(order, commt, str, lname, fname, total, ordtype, expdt);
	
	var nwelem = window.frame2.document.createElement("div");
	nwelem.id = "dvSbmCommt"

	var html = "<form name='frmSendEmail'"
   + " METHOD=Post ACTION='WarrantyClaimSendEMail.jsp'>"
   + "<input class='Small' name='MailAddr'>"
   + "<input class='Small' name='CCMailAddr'>"
   + "<input class='Small' name='FromMailAddr'>"
   + "<input class='Small' name='Subject'>"
   + "<input class='Small' name='Message'>";
   
	html += "</form>"

	nwelem.innerHTML = html;
	frmcommt = document.all.frmEmail;
	window.frame2.document.appendChild(nwelem);

	window.frame2.document.all.Subject.value = subj;
	window.frame2.document.all.Message.value = body;
	window.frame2.document.all.MailAddr.value = toaddr;

	window.frame2.document.all.CCMailAddr.value = "GM" + str + "@sunandski.com";   
	window.frame2.document.all.FromMailAddr.value = frAddr;
	window.frame2.document.frmSendEmail.submit();
}
//==============================================================================
//get message body
//==============================================================================
function getMsgBody(order, commt, str, lname, fname, total, ordtype, expdt)
{
var body = "";
body += "<table style='font-family:Arial; font-size:10px; width:100%;' >"

	   + "<tr><td style='text-align:left'>" + commt + "</td><tr>"
	   + "<tr><td style='text-align:left'>"
	      + "<table style='border: darkred solid 1px; font-family:Arial; font-size:10px; width:100%;'>"
			  + "<tr><td style='font-weight:bold'><b><i>Sun & Ski</></b></th></tr>"
			  + "<tr><td style='font-weight:bold'>Order: <a href='http://rciweba.retailconcepts.cc/OrderEntry.jsp?Order=" + order + "&List=Y'>" + order  + "</a></td></tr>"
			  + "<tr><td style='font-weight:bold'>Type: " + ordtype  + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Store:" + str  + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Customer: " + lname + ", " + fname + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Total: $" + total  + "</td></tr>"
			  + "<tr><td style='font-weight:bold'>Expiration Date: " + expdt  + "</td></tr>"
	      + "</table><br>"
	   + "</td><tr>"

	body += "</table>";   
	   
	body += "</td></tr></table>"
	
return body;			
}

//==============================================================================
//set selected email address line
//==============================================================================
function setEmailAddr(sel)
{
	EmailAddr.value = sel.options[sel.selectedIndex].value; 
}
//==============================================================================
// get Order comments
//==============================================================================
function getOrdNote(ord, type)
{
   var url = "PfsOrderComment.jsp?Order=" + ord
           + "&Type=" + type
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// set comment/log filter
//==============================================================================
function setCmtFilter(cmtty, chkbox, numcmt)
{
   var disp = "none";
   if(chkbox.checked){ disp = "block";}

   for(var i=0; i < numcmt; i++)
   {
      var cell = "tdCmtTy" + i;
      var type = document.all[cell].innerHTML.trim();
      var rownm = "trCmtLog" + i;
      var row = document.all[rownm];
      for(var j=0; j < cmtty.length; j++)
      {
          if(type == cmtty[j]){ row.style.display=disp; }
      }
   }
}

//==============================================================================
// show Note
//==============================================================================
function showNote(comments)
{
   document.all.Comments.value = comments.trim(" ");
   document.all.Comments.disabled = false;
   document.all.tdButton.style.visibility = "visible";
   window.frame1.location.href = null;
   window.frame1.close();
}
//==============================================================================
// show Comments
//==============================================================================
function showComments(html)
{
    document.all.tdCmtLog.innerHTML = html;
}
//==============================================================================
// display error
//==============================================================================
function displayError(err)
{
   window.frame1.location.href="";
   window.frame1.close();
   msg = "";
   for(var i=0; i < err.length; i++)  {  msg += err[i] + "\n"; }
   alert(msg);

}
//==============================================================================
// restart application after heading entry
//==============================================================================
function reStart()
{
   window.location.reload();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// show Delivery Date Inquery screen
//==============================================================================
function showDelDateInq(area)
{
   var url = null;
   if(area == "DC"){ url = "PfOrdDeliveryCal.jsp?Store=35&Store=46&Store=50";}
   else if(area == "NY"){ url = "PfOrdDeliveryCal.jsp?Store=86";}
   else if(area == "NE"){ url = "PfOrdDeliveryCal.jsp?Store=55&Store=63&Store=64&Store=68";}

   var WindowName = 'Delivery_Date_Inquiry';
   var WindowOptions = 'resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=yes';

  //alert(url);
  window.open(url, WindowName, WindowOptions);

}
//==============================================================================
// show Status Stamp
//==============================================================================
function showStsStamp()
{
   if (document.all.spStsStamp[0] != null)
   {
      for(var i=0; i < document.all.spStsStamp.length; i++)
      {
        if(document.all.spStsStamp[i].style.display=="none") document.all.spStsStamp[i].style.display = "block";
        else document.all.spStsStamp[i].style.display = "none";
      }
   }
   else
   {
      if(document.all.spStsStamp.style.display=="none") document.all.spStsStamp.style.display = "block";
      else document.all.spStsStamp.style.display = "none";
   }
}
//==============================================================================
// show Status Stamp
//==============================================================================
function showPyStsStamp()
{
   if (document.all.spPyStsStamp[0] != null)
   {
      for(var i=0; i < document.all.spPyStsStamp.length; i++)
      {
        if(document.all.spPyStsStamp[i].style.display=="none")
        {
          document.all.spPyStsStamp[i].style.display = "block";
        }
        else document.all.spPyStsStamp[i].style.display = "none";
      }
   }
   else
   {
      if(document.all.spPyStsStamp.style.display=="none")
      {
         document.all.spPyStsStamp.style.display = "block";
      }
      else document.all.spPyStsStamp.style.display = "none";
   }
}

//==============================================================================
// show Special Order Status Stamp
//==============================================================================
function showSoStsStamp()
{
   if (document.all.spSoStsStamp1[0] != null)
   {
      for(var i=0; i < document.all.spSoStsStamp1.length; i++)
      {
        if(document.all.spSoStsStamp1[i].style.display=="none")
        {
           document.all.spSoStsStamp1[i].style.display = "block";
           document.all.spSoStsStamp2[i].style.display = "block";
           document.all.spSoStsStamp3[i].style.display = "block";
        }
        else
        {
           document.all.spSoStsStamp1[i].style.display = "none";
           document.all.spSoStsStamp2[i].style.display = "none";
           document.all.spSoStsStamp3[i].style.display = "none";
        }
      }
   }
   else
   {
      if(document.all.spSoStsStamp1.style.display=="none")
      {
         document.all.spSoStsStamp1.style.display = "block";
         document.all.spSoStsStamp2.style.display = "block";
         document.all.spSoStsStamp3.style.display = "block";
      }
      else
      {
         document.all.spSoStsStamp1.style.display = "none";
         document.all.spSoStsStamp2.style.display = "none";
         document.all.spSoStsStamp3.style.display = "none";
      }
   }
}


//==============================================================================
// set P.O. Vendor's Delivery Date
//==============================================================================
function setPoDelDate(ord, ven, ponum, deldt)
{
   var hdr = "Customer Order:&nbsp;" + ord + "&nbsp; &nbsp;";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPoDelDate(ord, ven, ponum)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(deldt != ""){document.all.DelDate.value = deldt}
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPoDelDate(ord, ven, ponum)
{
  var posX = document.documentElement.scrollLeft + 650;
  var posY = document.documentElement.scrollTop + 100;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr id='trSel'><td class='Prompt'>&nbsp; Vendor:</td>"
             + "<td class='Prompt'>" + ven + "</td></tr>"
           + "<tr id='trSel'><td class='Prompt'>&nbsp; P.O. Number:</td>"
             + "<td class='Prompt'>" + ponum + "</td></tr>"

           + "<tr id='trSel'><td class='Prompt' nowrap><br>&nbsp; Vendor Delivery Date Date:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='DelDate' readonly size=10 maxlength=10> &nbsp; &nbsp;"
             + "<a class='Small' id='shwCal' href='javascript:showCalendar(1, null, null," + posX + "," + posY + ", document.all.DelDate)' >"
             + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' id='tdButton' colspan='2'><br><br>"
      + "<button onClick='sbmVenDelDt(&#34;" + ord + "&#34;, &#34;" + ven + "&#34;, &#34;" + ponum + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// submit new special order status
//==============================================================================
function sbmVenDelDt(ord, ven, ponum)
{
   var deldt = document.all.DelDate.value.trim(" ");
   var msg = "";
   var error = false;
   if(deldt == ""){error = true; msg += "Please, enter Delivery Date.\n"}

   if(error){ alert(msg); }
   else
   {
      var url = "OrderHdrSave.jsp?Order=" + ord
           + "&Ven=" + ven
           + "&PONum=" + ponum
           + "&DelDate=" + deldt
           + "&Action=CHGVNDELDT"
      //alert(deldt)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
}
//==============================================================================
// add PO number on Order
//==============================================================================
function addPoNum(ord, ven, vennm)
{
   var hdr = "Add New PO for Order:&nbsp;" + ord + "&nbsp; &nbsp;";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popAddPoNum(ord, ven, vennm)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popAddPoNum(ord, ven, vennm)
{
  var posX = document.documentElement.scrollLeft + 650;
  var posY = document.documentElement.scrollTop + 100;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable'>"
              + "<th class='DataTable'>Click on<br>selected<br>Vendor</th>"
              + "<th class='DataTable'>Vendor Name</th>"
              + "</tr>"
  for(var i=0; i < ven.length; i++)
  {
      panel += "<tr class='DataTable'>"
          + "<td class='DataTable2'><a href='javascript: setSelVen(&#34;" + ven[i] + "&#34;)'>" + ven[i] + "</a></td>"
          + "<td class='DataTable' nowrap>" + vennm[i] + "</td>"
        + "</tr>"
  }

  panel += "<tr><td colspan=2 nowrap>&nbsp;</td></tr>"

  panel += "<tr>"
           + "<td class='Prompt' nowrap>Vendor: <input class='Small' name='Ven' size=5 readonly></td>"
           + "<td class='Prompt' nowrap> &nbsp; &nbsp; P.O.#: <input class='Small' name='PoNum' size=10 maxlength=10></td>"
         + "</tr>"

  panel += "<tr class='Prompt'><td class='DataTable' id='tdErrMsg' colspan=2 nowrap></td></tr>"

  panel += "<tr><td class='Prompt' id='tdButton' colspan='3'><br><br>"
      + "<button onClick='vldVenPo(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// set Vendor Contact Information
//==============================================================================
function setSelVen(ven)
{
   document.all.Ven.value = ven
}
//==============================================================================
// validate new PO
//==============================================================================
function vldVenPo(ord)
{
   var error = false;
   var msg = "";
   document.all.tdErrMsg.innerHTML="";
   document.all.tdErrMsg.style.color="red";

   var ven = document.all.Ven.value;
   var ponum = document.all.PoNum.value.trim().toUpperCase();

   br = "";
   if(ven == ""){ error = true; msg += br + "Please select Vendor"; br = "<br>"; }
   if(ponum == ""){ error = true; msg += br + "Please enter P.O.#"; br = "<br>"; }

   if(error){ document.all.tdErrMsg.innerHTML=msg; }
   else{sbmNewPO(ord, ven, ponum)}
}
//==============================================================================
// submit new PO
//==============================================================================
function sbmNewPO(ord, ven, ponum)
{
   var url = "OrderHdrSave.jsp?Order=" + ord
              + "&Ven=" + ven
              + "&PONum=" + ponum
              + "&Action=ADDPONUM"
      //alert(url)
      window.frame1.location.href=url
      hidePanel();
}
//==============================================================================
// set Vendor Contact Information
//==============================================================================
function setVenProp(ven, name, cont, phn1, phn2, phn3, email)
{
   var hdr = "Vendor:&nbsp;" + ven + "-" + name + "&nbsp; &nbsp;";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popVenProp(ven, name, cont, phn1, phn2, phn3, email)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(cont != ""){document.all.Contact.value = cont;}
   if(phn1 != ""){document.all.Phone1.value = phn1;}
   if(phn2 != ""){document.all.Phone2.value = phn2;}
   if(phn3 != ""){document.all.Phone3.value = phn3;}
   if(email != ""){document.all.EMail.value = email;}
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popVenProp(ven, name, cont, phn1, phn2, phn3, email)
{
  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Contact Name:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Contact' size=50 maxlength=50> &nbsp; &nbsp;</td>"
         + "</tr>"
             + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Work Phone Number:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Phone1' size=15 maxlength=15> &nbsp; &nbsp;</td>"
         + "</tr>"
         + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Home Phone Number:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Phone2' size=15 maxlength=15> &nbsp; &nbsp;</td>"
         + "</tr>"
         + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; Cellular Number:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='Phone3' size=15 maxlength=15> &nbsp; &nbsp;</td>"
         + "</tr>"
         + "<tr id='trSel'><td class='Prompt' nowrap>&nbsp; E-Mail Address:</td>"
             + "<td class='Prompt' nowrap>"
               + "<input class='Small' name='EMail' size=50 maxlength=50> &nbsp; &nbsp;</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' id='tdButton' colspan='2'><br><br>"
      + "<button onClick='sbmVenProp(&#34;" + ven + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// submit new special order status
//==============================================================================
function sbmVenProp(ven)
{
   var cont = document.all.Contact.value.trim(" ");
   var phn1 = document.all.Phone1.value.trim(" ");
   var phn2 = document.all.Phone2.value.trim(" ");
   var phn3 = document.all.Phone3.value.trim(" ");
   var email = document.all.EMail.value.trim(" ");

   var msg = "";
   var error = false;

   if(error){ alert(msg); }
   else
   {
      var url = "PfVenPropSave.jsp?"
           + "Ven=" + ven
           + "&Contact=" + cont.replaceSpecChar()
           + "&Phone1=" + phn1.replaceSpecChar()
           + "&Phone2=" + phn2.replaceSpecChar()
           + "&Phone3=" + phn3.replaceSpecChar()
           + "&Email=" + email.replaceSpecChar()
           + "&Action=CHGVENPROP"
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
}
//==============================================================================
// print sold tag
//==============================================================================
function showSoldTag(ord, strarr)
{

   var hdr = "Show Sold Tag";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr>"
      + "<td class='Prompt' colspan=2>"
        + "Print for store: <select name='selPrtStr'></select>"
        + "<br>Print by employee: <input name='PrtEmp' size='4' maxlength='4'>"
        + "<br><button onclick='vldSoldTag(&#34;" + ord + "&#34;)'>Submit</button>"
      + "</td>"
    + "</tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 400;
   document.all.dvStatus.style.visibility = "visible";

   for(var i=0; i < strarr.length; i++)
   {
      document.all.selPrtStr.options[i] = new Option(strarr[i], strarr[i]);
   }
}

//==============================================================================
// validate sold tag
//==============================================================================
function vldSoldTag(ord)
{
   var error =false;
   var msg = "";

   var str = document.all.selPrtStr.options[document.all.selPrtStr.selectedIndex].value;
   var emp = document.all.PrtEmp.value.trim();
   if(emp == ""){ error=true; msg="Employee number is invalid"; }
   else if(isNaN(emp)){ error=true; msg="Employee number is not numeric"; }
   else if(eval(emp) <= 0){ error=true; msg="Employee number must be positive number"; }

   if(error){ alert(msg); }
   else{ sbmSoldTag(ord, str, emp); }
}
//==============================================================================
// submit sold tag
//==============================================================================
function sbmSoldTag(ord, str, emp)
{
   var url = "OrderPrtSoldTag.jsp?Order=" + ord
    + "&Store=" + str
    + "&Emp=" + emp;
   window.document.location.href = url;
}
//==============================================================================
// print sold tag
//==============================================================================
function showDelTicket(ord)
{
   var url = "PfOrderDelivery.jsp?Order=" + ord
   window.document.location.href = url;
}
//==============================================================================
//print sold tag
//==============================================================================
function showCustQuo(cust)
{
	//PfQuoteLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=12/31/2999&Cust=0000010959&SlsPer=&Status=A&CommType=QST1&CommType=QST2&CommType=QST3&InclSO=B&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55
	//PfQuoteLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=12/31/2999&Cust=0000010959&SlsPer=&Status=A&CommType=QST1&CommType=QST2&CommType=QST3&InclSO=B&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55
}
//==============================================================================
//show order info
//==============================================================================
function showOrdInfo(show, obj, ord, lastnm, firstnm, dayphn)
{
	if(show)
	{
		var link = "<a target='_blank' href='OrderEntry.jsp?Order=" + ord + "&List=Y'>" + ord + "</a>"
		var html = "Order:" + link  
		  + "&nbsp; Customer: " +  lastnm + ", " + firstnm
		  + "&nbsp; Phn: " + dayphn 
		document.all.dvOrdInfo.innerHTML = html;
		document.all.dvOrdInfo.style.width = "400";
		document.all.dvOrdInfo.style.textAlign = "left";
		
		var pos = getObjPosition(obj);		
		document.all.dvOrdInfo.style.pixelLeft = pos[0] + 40;
		document.all.dvOrdInfo.style.pixelTop= pos[1] - 12;
		
		document.all.dvOrdInfo.style.visibility = "visible";
	}
	else
	{
		document.all.dvOrdInfo.style.visibility = "hidden";
	}
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frameChkCalendar"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<div id="dvOrdInfo" class="dvStatus"></div>
<div id="dvLegend" class="dvStatus"><span style="background:black;color:white">$1253.12<sup >cp&nbsp;ps</sup></span>-This order is out of balance
 &nbsp; <a href="Patio_Furniture\PatioOOB.pdf" target="_blank">Help</a>
</div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Patio Furniture Sales Order List
        <br>Selected Store(s):
        <%String coma = "";%>
           <%for(int i=0; i < sStrGrp.length; i++){%><%=coma%> <%=sStrGrp[i]%><%coma=",";%><%}%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="OrderLstSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
      <span style="font-size:10px">This Week's Delivery Schedule: </span>
         <a href="javascript:showDelDateInq('DC');" style="font-size:10px">DC</a>, &nbsp;
         <a href="javascript:showDelDateInq('NY');" style="font-size:10px">NY</a> &nbsp;
         <a href="javascript:showDelDateInq('NE');" style="font-size:10px">NE</a> &nbsp;
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable"  rowspan=4>No.</th>
        <th class="DataTable"  style="background: yellow" nowrap colspan=14>Customer Order Information</th>
        <th class="DataTable" nowrap rowspan=4>&nbsp;</th>
        <th class="DataTable" nowrap style="background: #cccfff" colspan=14>In-Stock Orders</th>
        <th class="DataTable" nowrap rowspan=4>&nbsp;</th>
        <th class="DataTable" style="background: lightsalmon" id="thSpcOrd" nowrap colspan=6>Special Order</th>
        <th class="DataTable" nowrap rowspan=4>&nbsp;</th>
        <th class="DataTable" nowrap style="background: #ccffcc" colspan=2>Warranty/Issues</th>
        <th class="DataTable" nowrap rowspan=4>&nbsp;</th>
        <th class="DataTable" nowrap colspan=6 style="background: lavender">Vendor Information</th>
       </tr>

       <tr  class="DataTable">
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('STORE')">Str</a></th>
        <th class="DataTable" nowrap rowspan=3 no><a href="javascript: sortBy('QUODT')">Quote<br>Date</a></th>
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('ENTDT')">Sales<br>Date & Time</a></th>
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('SLSP')">Slsp#</a></th>
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('ORDER')">Order #</a>
           <br> <span style="background: lightsalmon; font-weight:normal; font-size: 10px;">(Special Order)</span>
        </th>
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('CUSTNM')">Name</a></th>
        <th class="DataTable" nowrap rowspan=3>Day<br>Phone & Ext</th>
        <th class="DataTable" nowrap rowspan=3>Print<br>Note</th>
        <th class="DataTable" nowrap rowspan=3>C<br>m<br>t<br>and<br>L<br>o<br>g</th>
        <th class="DataTable" nowrap rowspan=3>Order<br>Status<br>
           <%if(iNumOfOrd > 0){%><a href="javascript: showStsStamp()" style="color:darkblue;font-size:10px">(show details)</a><%}%>
        </th>
        <th class="DataTable" nowrap rowspan=3>Payment<br>Status<br>
           <%if(iNumOfOrd > 0){%><a href="javascript: showPyStsStamp()" style="color:darkblue;font-size:10px">(show details)</a><%}%>
        </th>
        <th class="DataTable" nowrap rowspan=3>Merch<br>Total<br>no tax</th>
        <th class="DataTable" nowrap rowspan=3>Total<br>Amt<br>(w/ tax)<br><a href="javascript: sortBy('UNBAL')">OOB</a></th>
        <th class="DataTable" nowrap rowspan=3>GM<br>%</th>

        <!-- =========== In-Stock ============== -->
        <th class="DataTable" nowrap rowspan=3><span style="color:red;">S<br>O<br>L<br>D</span><br>&nbsp;<br>T<br>a<br>g</th>
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('DELDT')">Delivery<br>Date<br>or<br>Quote<br>Expiration<br>Date</a></th>
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('REMDT')">Days<br>Until<br>Delivery<br>or<br>Quote<br>Expiration</a></th>
        <th class="DataTable" nowrap rowspan=3>Ship<br>Instr</th>
        <th class="DataTable" nowrap rowspan=3>D&nbsp;&nbsp;&nbsp;&nbsp;<br>e&nbsp;&nbsp;&nbsp;&nbsp;<br>l&nbsp;&nbsp;T<br>i&nbsp;&nbsp;&nbsp;i<br>v&nbsp;&nbsp;c<br>e&nbsp;&nbsp;k<br>r&nbsp;&nbsp;e<br>y&nbsp;&nbsp;t<br></th>
        <th class="DataTable1" nowrap rowspan=3>L&nbsp;<br>o&nbsp;<br>c&nbsp;<br>&nbsp;&nbsp;&nbsp;S<br>b K<br>y U</th>
        <th class="DataTable" nowrap colspan=3>DC<br><span style="font-size:11px">(Ski Chalet)</span></th>
        <th class="DataTable" nowrap>NY<br><span style="font-size:11px">Ski Stop</span></th>
        <th class="DataTable" nowrap colspan=4>NE<br><span style="font-size:11px">Whse/Sun & Ski</span></th>

        <!-- ==========Special order =================== -->
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('SPCORD')">Special<br>Order<br>(Tag)</a></th>
        <th class="DataTable" id="colSpcOrd" colspan=4>Status<br>
            <a href="javascript: switchSpcOrd()" style="color:darkblue;font-size:10px">(show details)</a>
            <%if(iNumOfOrd > 0){%>&nbsp;&nbsp;&nbsp;<a id="lnkSoStamp" href="javascript: showSoStsStamp()" style="color:darkblue;font-size:10px">Date/Time</a><%}%>
        </th>
        <th class="DataTable" nowrap rowspan=3>RCI<br>P.O.#<br><span style="font-size:9px">(Click 'R' to<br>review PO)</span></th>
        <th class="DataTable" nowrap rowspan=3>Vend<br>Conf?</th>
        <th class="DataTable" nowrap rowspan=3><a href="javascript: sortBy('VENDELDT')">Expected<br>Ship Date<br>from<br>MFG</a></th>
        <th class="DataTable" nowrap rowspan=3>Days<br>Until<br>MFG<br>Ships</th>

        <!-- =========== Warranty/Issues ============== -->
        <th class="DataTable" nowrap rowspan=3>C<br>l<br>a<br>i<br>m<br>#</th>
        <th class="DataTable" nowrap rowspan=3>A<br>d<br>d<br><br>N<br>e<br>w</th>

        <!-- Sku lookup result -->
        <%if(!sSku.trim().equals("")){%>
            <th class="DataTable" nowrap rowspan=3>SKU Qty</th>
            <th class="DataTable" nowrap rowspan=3>SKU Retail</th>
        <%}%>

        <th class="DataTable" nowrap rowspan=3>Number & <a href="javascript: sortBy('VENNAM')">Name</a></th>
        <th class="DataTable" nowrap rowspan=3>Contact</th>
        <th class="DataTable" nowrap rowspan=3>Phone1</th>
        <th class="DataTable" nowrap rowspan=3>Phone2</th>
        <th class="DataTable" nowrap rowspan=3>Phone3</th>
        <th class="DataTable" nowrap rowspan=3>E-Mail</th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable" id="colSkiChl" style="background: #cccfff" nowrap colspan=8>Inventory From</th>
        <th class="DataTable" nowrap rowspan=2><a href="javascript: sortBy('SPCSTS')">Sort by</a></th>
        <th class="DataTable" rowspan=2 id="colSpcOrd" nowrap><a href="javascript: sortBy('APPRVDT')">Approved<br>Date</a></th>
        <th class="DataTable" rowspan=2 id="colSpcOrd" nowrap><a href="javascript: sortBy('PLACEDT')">Placed @<br>Vendor</a></th>
        <th class="DataTable" rowspan=2 id="colSpcOrd" nowrap><a href="javascript: sortBy('RCVATDC')">Rceived<br>@ DC</a></th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable"  style="background: #cccfff" id="colSkiChl" nowrap>35</th>
        <th class="DataTable" style="background: #cccfff" id="colSkiChl" nowrap>46</th>
        <th class="DataTable" style="background: #cccfff" id="colSkiChl" nowrap>50</th>
        <th class="DataTable" style="background: #cccfff" id="colSkiStp" nowrap>86</th>
        <th class="DataTable" style="background: #cccfff" id="colWrHous" nowrap>55</th>
        <th class="DataTable" style="background: #cccfff" id="colSunSki" nowrap>63</th>
        <th class="DataTable" style="background: #cccfff" id="colSunSki" nowrap>64</th>
        <th class="DataTable" style="background: #cccfff" id="colSkiStp" nowrap>68</th>
      </tr>
      <TBODY>

  <!-------------------------- Order List ------------------------------->
  <%for(int i=0; i < iNumOfOrd; i++) {%>
    <%
      ordlst.setOrdHdrInfo();

      String sOrdNum = ordlst.getOrdNum();
      String sSts = ordlst.getSts();
      String sStsName = ordlst.getStsName();
      String sSoSts = ordlst.getSoSts();
      String sSoStsName = ordlst.getSoStsName();
      String sCust = ordlst.getCust();
      String sSlsper = ordlst.getSlsper();
      String sSlpName = ordlst.getSlpName();
      String sDelDate = ordlst.getDelDate();
      String sShipInstr = ordlst.getShipInstr();
      String sLastName = ordlst.getLastName();
      String sFirstName = ordlst.getFirstName();
      String sAddr1 = ordlst.getAddr1();
      String sAddr2 = ordlst.getAddr2();
      String sCity = ordlst.getCity();
      String sState = ordlst.getState();
      String sZip = ordlst.getZip();
      String sDayPhn = ordlst.getDayPhn();
      String sExtWorkPhn = ordlst.getExtWorkPhn();
      String sEvtPhn = ordlst.getEvtPhn();
      String sCellPhn = ordlst.getCellPhn();
      String sEMail = ordlst.getEMail();
      String sSubTot = ordlst.getSubTot();
      String sTax = ordlst.getTax();
      String sTotal = ordlst.getTotal();
      String sOrgStr = ordlst.getOrgStr();

      String sTrfStr35 = ordlst.getTrfStr35();
      String sTrfStr46 = ordlst.getTrfStr46();
      String sTrfStr50 = ordlst.getTrfStr50();
      String sTrfStr86 = ordlst.getTrfStr86();
      String sTrfStr63 = ordlst.getTrfStr63();
      String sTrfStr64 = ordlst.getTrfStr64();
      String sTrfStr68 = ordlst.getTrfStr68();
      String sTrfStr55 = ordlst.getTrfStr55();

      String sSpcOrd = ordlst.getSpcOrd();
      String sEntDate = ordlst.getEntDate();
      String sDaysRemToDel = ordlst.getDaysRemToDel();
      String sReg = ordlst.getReg();
      String sTrans = ordlst.getTrans();
      String sStsDate = ordlst.getStsDate();
      String sStsTime = ordlst.getStsTime();
      String sStsUser = ordlst.getStsUser();
      String [] sSoSDate = ordlst.getSoSDate();
      String [] sSoSTime = ordlst.getSoSTime();
      String [] sSoSUser = ordlst.getSoSUser();
      String sOrdPaid = ordlst.getOrdPaid();
      String sPaidOff = ordlst.getPaidOff();
      String sSkuQty = ordlst.getSkuQty();
      String sSkuRet = ordlst.getSkuRet();
      String sComments = ordlst.getComments();
      String sVenConf = ordlst.getVenConf();
      int iPoMax = ordlst.getPoMax();
      String [] sPoNum = ordlst.getPoNum();
      String [] sVenNum = ordlst.getVenNum();
      String [] sVenDelDt = ordlst.getVenDelDt();
      String [] sVenName = ordlst.getVenName();
      String [] sVenContact = ordlst.getVenContact();
      String [] sVenPhone1 = ordlst.getVenPhone1();
      String [] sVenPhone2 = ordlst.getVenPhone2();
      String [] sVenPhone3 = ordlst.getVenPhone3();
      String [] sVenEMail = ordlst.getVenEMail();
      String [] sVenDelRem = ordlst.getVenDelRem();
      String [] sClaimId = ordlst.getClaimId();
      String sSoldPrtLst = ordlst.getSoldPrtLst();
      String sGmPrc = ordlst.getGmPrc();
      String sPySts = ordlst.getPySts();
      String sPyStsNm = ordlst.getPyStsNm();
      String sPyStsDate = ordlst.getPyStsDate();
      String sPyStsTime = ordlst.getPyStsTime();
      String sPyStsUser = ordlst.getPyStsUser();

      String sSoVen = ordlst.getSoVenJsa();
      String sSoVenNm = ordlst.getSoVenNmJsa();
      String sCpBal = ordlst.getCpBal();
      String sPsBal = ordlst.getPsBal();
      String sQuoDt = ordlst.getQuoDt();
      String sSlsTm = ordlst.getSlsTm();
      String sCustOrd = ordlst.getCustOrd();
      String sCustQuo = ordlst.getCustQuo();
      
      String sTrf55Dn = ordlst.getTrf55Dn();
      String sTrf35Dn = ordlst.getTrf35Dn();
      String sTrf46Dn = ordlst.getTrf46Dn();
      String sTrf50Dn = ordlst.getTrf50Dn();
      String sTrf86Dn = ordlst.getTrf86Dn();
      String sTrf63Dn = ordlst.getTrf63Dn();
      String sTrf64Dn = ordlst.getTrf64Dn();
      String sTrf68Dn = ordlst.getTrf68Dn();


      String sTrfStrArr = "[";
      coma = "";
      if(sTrfStr35.equals("1")){ sTrfStrArr += coma + "'" + "35" + "'"; coma = ","; }
      if(sTrfStr46.equals("1")){ sTrfStrArr += coma + "'" + "46" + "'"; coma = ","; }
      if(sTrfStr50.equals("1")){ sTrfStrArr += coma + "'" + "50" + "'"; coma = ","; }
      if(sTrfStr86.equals("1")){ sTrfStrArr += coma + "'" + "86" + "'"; coma = ","; }
      if(sTrfStr63.equals("1")){ sTrfStrArr += coma + "'" + "63" + "'"; coma = ","; }
      if(sTrfStr64.equals("1")){ sTrfStrArr += coma + "'" + "64" + "'"; coma = ","; }
      if(sTrfStr68.equals("1")){ sTrfStrArr += coma + "'" + "68" + "'"; coma = ","; }
      if(sTrfStr55.equals("1")){ sTrfStrArr += coma + "'" + "55" + "'"; coma = ","; }
      sTrfStrArr += "]";

      String sTypeOfOrd = "IN-STOCK";
      if(sSpcOrd.equals("1")){ sTypeOfOrd = "SPEC ORD"; }
%>
        <tr  class="DataTable">
            <td class="DataTable2"><%=i+1%></td>
            <td class="DataTable2"><%=sOrgStr%></td>
            <td class="DataTable2" nowrap><%=sQuoDt%></td>
            <td class="DataTable2" nowrap><%=sEntDate%> <%=sSlsTm%></td>            
            <td class="DataTable2"><%=sSlsper%></td>
            <td class="DataTable<%if(sSpcOrd.equals("1")){%>5<%} %>" nowrap><a target="_blank" href="OrderEntry.jsp?Order=<%=sOrdNum%>&List=Y"><%=sOrdNum%></a></td>
            <td class="DataTable" nowrap><%=sLastName%>, <%=sFirstName%>
               <%if(!sCustOrd.equals("0")){%><sup><a href="OrderLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=12/31/2999&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R&Sku=&Cust=<%=sCust%>&SlsPer=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55&StsOpt=CURRENT" target="_blank"></>S<%=sCustOrd%><a></a></sup><%}%>
               <%if(!sCustQuo.equals("0")){%><sup><a href="PfQuoteLst.jsp?FrOrdDt=01/01/0001&ToOrdDt=12/31/2999&Cust=<%=sCust%>&SlsPer=&Status=A&CommType=QST1&CommType=QST2&CommType=QST3&InclSO=B&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55" target="_blank">Q<%=sCustQuo%></a></sup><%}%>
            </td>
            <td class="DataTable" nowrap>
              <%if(sDayPhn.trim().length() > 0){%><%=sDayPhn%><%if(sExtWorkPhn.trim().length() > 0){%><%=" x " + sExtWorkPhn%><%}%><%}
                else if(sCellPhn.trim().length() > 0){%><%=sCellPhn%><%}
                else if(sEvtPhn.trim().length() > 0){%><%=sEvtPhn%><%}%>
            </td>
            <td class="DataTable2" nowrap><a href="javascript: showNotePanel(&#34;<%=sOrdNum%>&#34;, <%if(sVenConf.equals("Y")){%>true<%} else {%>false<%}%>)">Note</a></td>
            <td class="DataTable2" nowrap><a href="javascript: showCommtPanel(&#34;<%=sOrdNum%>&#34;, &#34;ALL&#34;,null,null, &#34;<%=sOrgStr%>&#34, &#34;<%=sLastName%>&#34;, &#34;<%=sFirstName%>&#34;, &#34;<%=sTotal%>&#34;, &#34;<%=sTypeOfOrd%>&#34;, &#34;<%=sDelDate%>&#34; ,&#34;<%=sStsName%>&#34;)">C&L</a></td>
            <!--===== Status ====== -->
            <td class="DataTable2" nowrap>
               <%if(sSts.equals("Z") || sSts.equals("R") || sSts.equals("S") || sSts.equals("X")){%>
                 <a href="javascript: chgOrdSts('<%=sOrdNum%>','<%=sSts%>', '<%=sDelDate%>', '<%=sOrgStr%>')"><%=sStsName%></a>
               <%} else {%><%=sStsName%><%}%>
               <span id="spStsStamp" style="display:none"><%=sStsDate%><br><%=sStsTime%><br><%=sStsUser%></span>
            </td>
            <!--===== Pay Status ====== -->
            <td class="DataTable2"
               style="<%if(sPySts.equals("O")){%>background:#FFA8D3;<%}
                    else if(sPySts.equals("P")){%>background:#FFC8E3;<%}
                    else if(sPySts.equals("E")){%>background:#FFDFEF;<%}%>" nowrap><%=sPyStsNm%>
               <span id="spPyStsStamp" style="display:none"><%=sPyStsDate%><br><%=sReg%>/<%=sTrans%><br>$<%=sOrdPaid%></span>
            </td>
            <td class="DataTable2">$<%=sSubTot%></td>
            <td class="DataTable4" 
                <%if(sCpBal.equals("1") || sPsBal.equals("1")){%>style="background:black;color:white"<%}%>>                                
                $<%=sTotal%><%if(sCpBal.equals("1")){%><sup>cp&nbsp;</sup><%}%><%if(sPsBal.equals("1")){%><sup>ps</sup><%}%>
            </td>
            <td class="DataTable1"><%if(bAllowGmPrc && !sGmPrc.equals("100")){%><%=sGmPrc%>%<%}%></td>

            <!-- ===== in-Stock Order ===== -->
            <th class="DataTable" nowrap>&nbsp;</th>
            <td class="DataTable"><%if(!sSts.equals("Q") && !sSts.equals("C") && !sSts.equals("D") && sSpcOrd.equals("0")){%>
                  <a href="javascript: showSoldTag('<%=sOrdNum%>', <%=sTrfStrArr%>)">
                    S<br><%=sSoldPrtLst%>
                  </a>
                <%} else {%>&nbsp;<%}%>
            </td>
            <td class="DataTable2" nowrap>
              <%if(!sSts.equals("Q") && sDelDate.equals("01/01/0001") && !sSpcOrd.equals("1")){%>Cust Pickup
              <%} else if(!sSts.equals("Q") && sSpcOrd.equals("1") && !sSoSts.equals("R")){%>Upon Receipt<%}
              else {%><%if(!sDelDate.equals("01/01/0001")){%><%=sDelDate%><%}%><%}%>
            </td>
            <td class="DataTable2"><%if(sDelDate.equals("01/01/0001") || sDaysRemToDel.equals("0")){%>&nbsp;<%} else {%><%=sDaysRemToDel%><%}%></td>
            <td class="DataTable"><%if(!sShipInstr.trim().equals("")){%>Yes<%} else {%>&nbsp;<%}%></td>
            <td class="DataTable2"><%if(!sSts.equals("Q") && !sSts.equals("C") && !sSts.equals("W")
                && !sSts.equals("T") && !sSts.equals("D") && !sPySts.equals("O")){%>
                  <a href="javascript: showDelTicket('<%=sOrdNum%>')">Tkt</a>
                <%} else {%>&nbsp;<%}%>
            </td>
            <td class="DataTable2"><a target="_blank" href="OrderEntry.jsp?Order=<%=sOrdNum%>&List=Y&Stock=Y">R</a></td>
            <td id="colSkiChl" class="DataTable3<%if(sTrfStr35.equals("1") && !sOrgStr.equals("35")){%>1<%}%>">
              <%if(sTrfStr35.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>
            <td id="colSkiChl" class="DataTable3<%if(sTrfStr46.equals("1") && !sOrgStr.equals("46")){%>1<%}%>">
              <%if(sTrfStr46.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>
            <td id="colSkiChl" class="DataTable3<%if(sTrfStr50.equals("1") && !sOrgStr.equals("50")){%>1<%}%>">
              <%if(sTrfStr50.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>
            <td id="colSkiStp" class="DataTable3<%if(sTrfStr86.equals("1") && !sOrgStr.equals("86")){%>1<%}%>">
              <%if(sTrfStr86.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>
            <td id="colSkiStp" class="DataTable3<%if(sTrfStr55.equals("1") && !sOrgStr.equals("55")){%>1<%}%>">
              <%if(sTrfStr55.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>
            <td id="colSkiStp" class="DataTable3<%if(sTrfStr63.equals("1") && !sOrgStr.equals("63")){%>1<%}%>">
              <%if(sTrfStr63.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>
            <td id="colSkiStp" class="DataTable3<%if(sTrfStr64.equals("1") && !sOrgStr.equals("64")){%>1<%}%>">
              <%if(sTrfStr64.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>
            <td id="colSkiStp" class="DataTable3<%if(sTrfStr68.equals("1") && !sOrgStr.equals("68")){%>1<%}%>">
              <%if(sTrfStr68.equals("1")){%>Yes<%} else {%>&nbsp;<%}%>
            </td>


            <!-- ===== Special Order ===== -->
            <th class="DataTable" nowrap>&nbsp;</th>
            <td class="DataTable3<%if(sSpcOrd.equals("1")){%>2<%}%>" <%if(sSpcOrd.equals("1")){%>onmouseover="showOrdInfo(true, this, '<%=sOrdNum%>', '<%=sLastName%>', '<%=sFirstName%>', '<%=sDayPhn%>')"<%}%> >
               <%if(sSpcOrd.equals("1")){%><a href="OrderSOPrtSoldTag.jsp?Order=<%=sOrdNum%>" target="-blank">Yes</a><%} else{%>&nbsp;<%}%>
            </td>
            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>" nowrap onmouseout="showOrdInfo(false, null, null, null, null, null)">
               <%if(bSts && sSoSts.equals("N") || bSts && sSoSts.equals("A")){%><a href="javascript: chgSoSts(&#34;<%=sOrdNum%>&#34;, &#34;<%=sSoSts%>&#34;)"><%=sSoStsName%></a>
               <%} else {%>
               		<%=sSoStsName%>
               		<%if(sSoSts.equals("R")){%><br><span style="background: lightgreen;">Call Customer for Delivery</span><%}%>
               <%}%>
            </td>
            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>" id="colSpcOrd"><%=sSoSDate[1]%>
                 <span id="spSoStsStamp1" style="display:none"><%=sSoSTime[1]%><br><%=sSoSUser[1]%></span>
            </td>
            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>" id="colSpcOrd"><%=sSoSDate[2]%>
               <span id="spSoStsStamp2" style="display:none"><%=sSoSTime[2]%><br><%=sSoSUser[2]%></span>
            </td>
            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>" id="colSpcOrd"><%=sSoSDate[3]%>
               <span id="spSoStsStamp3" style="display:none"><%=sSoSTime[3]%><br><%=sSoSUser[3]%></span>
            </td>

            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>" style="text-align:left" nowrap>
              <%boolean bAddPo = false;
              for(int j=0; j < iPoMax; j++){
                 bAddPo = sPoNum[j].length() < 10 || sPoNum[j].toUpperCase().startsWith("PM");
              }%>
              <%if(sSpcOrd.equals("1") && bAddPo){%><a href="javascript: addPoNum('<%=sOrdNum%>' , [<%=sSoVen%>], [<%=sSoVenNm%>]) ">Add</a><%}%>

              <%String sComa = "";
                for(int j=0; j < iPoMax; j++){%>
                   <span <%if(sSpcOrd.equals("1") && !sVenConf.equals("Y")){%>style="background:lightpink;"<%}%>><%=sComa + sPoNum[j]%></span>
                   <%if(!sPoNum[j].substring(0, 2).equals("FT")){%>
                       <a href="POWorksheet.jsp?PO=<%=sPoNum[j]%>" target="_balnk">R</a>
                   <%}%>
                   <%sComa = "<br>";%>
                <%}%>
            </td>

            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>">
              <%if(sSpcOrd.equals("1")){%>
                 <%for(int j=0; j < iPoMax; j++){%>
                   <a href="javascript: showCommtPanel(&#34;<%=sOrdNum%>&#34;,&#34;VCN&#34;, '<%=sVenNum[j]%>', '<%=sPoNum[j]%>', '<%=sOrgStr%>', &#34;<%=sLastName%>&#34;, &#34;<%=sFirstName%>&#34;, &#34;<%=sTotal%>&#34;, &#34;<%=sTypeOfOrd%>&#34;, &#34;<%=sDelDate%>&#34;, &#34;<%=sStsName%>&#34;)">VC</a>
                 <%}%>
              <%} else{%>&nbsp;<%}%>
            </td>
            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>" nowrap>
              <%sComa = "";%>
              <%for(int j=0; j < iPoMax; j++){%>
                   <%=sComa%><%=sVenDelDt[j]%><%sComa = "<br>";%>
                <%}%>
            </td>
            <td class="DataTable<%if(sSpcOrd.equals("1")){%>2<%} else{%>3<%}%>" nowrap>
              <%sComa = "";%>
              <%for(int j=0; j < iPoMax; j++){%>
                   <%=sComa%><%=sVenDelRem[j]%><%sComa = "<br>";%>
                <%}%>
            </td>

            <!-- ===== Warranty/issues ===== -->
            <th class="DataTable" nowrap>&nbsp;</th>
            <td class="DataTable2" nowrap>
              <%sComa = "";%>
              <%for(int j=0; j < sClaimId.length; j++){%>
                  <%if(!sClaimId[j].equals("")){%>
                    <a href="WarrantyClaimInfo.jsp?Order=<%=sOrdNum%>&Claim=<%=sClaimId[j]%>" target="_blank"><%=sComa%><%=sClaimId[j]%></a> <%sComa = "<br>";%>
                  <%}%>
              <%}%>
            </td>
            <td class="DataTable2" nowrap><a href="WarrantyClaimInfo.jsp?Order=<%=sOrdNum%>&Claim=0000000000" target="_blank">A</a></td>

            <!-- ===== Vendor Information ===== -->
            <th class="DataTable" nowrap>&nbsp;</th>

            <!-- Sku lookup result -->
            <%if(!sSku.trim().equals("")){%>
                <td class="DataTable1"><%=sSkuQty%></td>
                <td class="DataTable1"><%=sSkuRet%></td>
            <%}%>

            <!-- ------- Vendor Name, contact, phone numbers and email ===== -->
            <!--%if(sUsrStr.trim().equals("ALL")){%-->
               <!-- Vendor Number - Name -->
               <td class="DataTable" nowrap><%sComa = "";
                  for(int j=0; j < iPoMax; j++){%>
                      <a href="javascript: setVenProp('<%=sVenNum[j]%>', '<%=sVenName[j]%>','<%=sVenContact[j]%>', '<%=sVenPhone1[j]%>', '<%=sVenPhone2[j]%>', '<%=sVenPhone3[j]%>', '<%=sVenEMail[j]%>')">
                      <%=sComa + sVenNum[j] + "-" + sVenName[j]%></a>
                      <% sComa = "<br>";%>
                   <%}%>
               </td>
               <!-- Vendor Contact -->
               <td class="DataTable" nowrap><%sComa = "";
                   for(int j=0; j < iPoMax; j++){%><%=sComa + sVenContact[j]%><% sComa = "<br>";%><%}%>
               </td>
               <!-- Vendor Phone 1 -->
               <td class="DataTable" nowrap><%sComa = "";
                for(int j=0; j < iPoMax; j++){%><%=sComa + sVenPhone1[j]%><% sComa = "<br>";%><%}%>
               </td>
               <!-- Vendor Phone 2 -->
               <td class="DataTable" nowrap><%sComa = "";
                   for(int j=0; j < iPoMax; j++){%><%=sComa + sVenPhone2[j]%><% sComa = "<br>";%><%}%>
               </td>
               <!-- Vendor Phone 3 -->
               <td class="DataTable" nowrap><%sComa = "";
                   for(int j=0; j < iPoMax; j++){%><%=sComa + sVenPhone3[j]%><% sComa = "<br>";%><%}%>
               </td>
               <!-- Vendor EMail -->
               <td class="DataTable" nowrap><%sComa = "";
                   for(int j=0; j < iPoMax; j++){%>
                     <a href="mailto:<%=sVenEMail[j]%>?subject=P.O.<%=sPoNum[j]%>&body=To <%=sVenContact[j]%>"><%=sComa + sVenEMail[j]%><% sComa = "<br>";%></a><%}%>
               </td>
            <!--%}%-->
          </tr>
      <%}%>
      <!----------------------------------------------------------------------->
      <!-- Total -->
      <!----------------------------------------------------------------------->
      <tr class="DataTable1">
            <td class="DataTable2" colspan=2>Total</td>
            <td class="DataTable2" colspan=10></td>
            <td class="DataTable4">$<%=sRepSubTotal%></td>
            <td class="DataTable4">$<%=sRepTotal%></td>
            <td class="DataTable2" colspan=40></td>
      </tr>

      </TBODY>
    </table>
    <span style="width:100%;text-align:left;font-size:12px">
      <span style="background:lightpink;">99999</span> - The buyer's Vendor Confirmation for this PO has not been entered.<br>
      John Doe<span style="color:blue;text-decoration: underline;vertical-align: super;font-size: smaller;">S1</span> - This Customer has a multiple sales order at current season.<br>
      Jane Doe<span style="color:blue;text-decoration: underline;vertical-align: super;font-size: smaller;">Q1</span> - This Customer has a multiple quotes at current season.  <br>
    </span>
  <!----------------------- end of table ------------------------>
        <button onclick="history.go(-1)">Back</button>
     </td>
   </tr>

  </table>
 </body>
</html>
<%
   ordlst.disconnect();
}%>


