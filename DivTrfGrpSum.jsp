<%@ page import="itemtransfer.DivTrfGrpSum, itemtransfer.ItmTrfToStr1, java.util.*"%>
<%
   String sDivision = request.getParameter("DIVISION");
   String sStore = request.getParameter("STORE");

   DivTrfGrpSum grpSum = null;
   int iNumOfGrp = 0;
   String sMain = null;
   String sMainName = null;
   String [] sGrp = null;
   String [] sGrpName = null;

   int [] iNumOfTrfDate = null;
   String [][] sAppDate = null;
   String [][] sAppUser = null;
   String [][] sPrtDate = null;
   String [][] sPrtUser = null;
   String [][] sCmpDate = null;
   String [][] sCmpUser = null;
   String [][] sCmpType = null;
   String [][] sCmpNote = null;

   String [][] sApproved = null;
   String [][] sItmCnt = null;
    String [][] sQty = null;
   String [][] sInTransit = null;
   String [][] sSent = null;
   String [][] sDstStr = null;
   
   String [][] sCrtDate = null;
   String [][] sCrtUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";
   String sStrAllowed = "";

   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=DivTrfGrpSum.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }
     response.sendRedirect(sTarget + sbQuery.toString());
   }
   else
   {
     sStrAllowed = session.getAttribute("STORE").toString();
     grpSum = new DivTrfGrpSum(sDivision, sStore);

     iNumOfGrp = grpSum.getNumOfGrp();
     sMain = grpSum.getMain();
     sMainName = grpSum.getMainName();
     sGrp = grpSum.getGrp();
     sGrpName = grpSum.getGrpName();

     iNumOfTrfDate = grpSum.getNumOfTrfDate();
     sAppDate = grpSum.getAppDate();
     sAppUser = grpSum.getAppUser();
     sPrtDate = grpSum.getPrtDate();
     sPrtUser = grpSum.getPrtUser();
     sCmpDate = grpSum.getCmpDate();
     sCmpUser = grpSum.getCmpUser();
     sCmpType = grpSum.getCmpType();
     sCmpNote = grpSum.getCmpNote();

     sItmCnt = grpSum.getItmCnt();
     sQty = grpSum.getQty();
     sApproved = grpSum.getApproved();
     sInTransit = grpSum.getInTransit();
     sSent = grpSum.getSent();
     sDstStr = grpSum.getDstStr();
     
     sCrtDate = grpSum.getCrtDate();
     sCrtUser = grpSum.getCrtUser();

     grpSum.disconnect();



    ItmTrfToStr1 itmToStr = new ItmTrfToStr1(sStore);

    int iNumOfItm = itmToStr.getNumOfItm();
     

%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background: darkred; text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable  { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:azure; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:seashell; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:cornsilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left;}
        td.DataTable3g { background: #d0f4d8 ;padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}               


               
 div.dvComment { position:absolute; background-attachment: scroll; visibility:hidden;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}
 .small{ text-align:left; font-family:Arial; font-size:10px;}
  
  
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = "<%=sStore%>"
var collapse = null;
//--------------- End of Global variables ----------------
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }	
	
  collapse = "D";
  collapseDetail();    
}

//----------------------------------------
// print transfer request
//----------------------------------------
function printTrfReq(grp, grpName, date, updTrf)
{
  var url="DivTrfReq.jsp?";
  url += "DIVISION=" + grp + "&DIVNAME=" + grpName + "&STORE=" + Store
       + "&APPDATE=" + date

  // change status to intransit on print
  if(updTrf=='Y') chgStatus("I", grp, grpName, date, null);

  //alert(url);
  window.open(url);
}
//--------------------------------------------------------
// Change Transfers Status to approved
//--------------------------------------------------------
function chgStatus(sts, grp, grpName, date, cmpType)
{
   var url = "ItemTrfEnt.jsp?"

   url += "DIVISION=" + grp;

   if(sts=="A") url += "&ACTION=APPROVE";
   if(sts=="I") url += "&ACTION=INTRANSIT";
   if(sts=="S")
   {
      url += "&ACTION=SENT&CMPTYPE=" + cmpType;
      if(cmpType != "ALL") url +=  "&NOTE=" + getComment();
   }
   url += "&DATE=" + date + "&Refresh=true";

  if(sts != "I" ) {
    if(confirm("Are You Sure?????"))
    {
     //alert(url)
     //window.location.href = url;
     //window.frame1.location = url;
    	if(isIE || isSafari){ window.frame1.location.href = url; }
        else if(isChrome || isEdge) { window.frame1.src = url; }     
    }
  }
  else
  {
    //alert(url)
    //window.location.href = url;
    //window.frame1.location = url;
	if(isIE || isSafari){ window.frame1.location.href = url; }
	else if(isChrome || isEdge) { window.frame1.src = url; }
  }
}
//---------------------------------------------------------
// build Comment Entry panel
//---------------------------------------------------------
function getComment()
{
  var cmt = document.all.txaComment.value;
  var cmp="";
  for(var i=0, space=0; i < cmt.length; i++, space++)
  {
    if (cmt.substring(i, i+1) != " ") { space=0; } ;
    if (space <= 1) { cmp += cmt.substring(i, i+1);}
  }

  return cmp;
}
//---------------------------------------------------------
// build Comment Entry panel
//---------------------------------------------------------
function setCommentEntry(sts, grp, grpName, date, type)
{
  var html= "<u><b>Enter Completion Comment</b></u><br>"
   + "Completion status is " + type + ".  Please, enter comments."
   + "<br><textArea name='txaComment' class='small' rows='2' cols='50'></textArea><br>"
   + "<button id='btnComplete' class='small' onClick='sbmCompleteSts(&#34;"
   + sts + "&#34;, &#34;" + grp + "&#34;, &#34;" + grpName  + "&#34;, &#34;" + date  + "&#34;, &#34;" + type
   + "&#34;);'>Complete</button>&nbsp;&nbsp;"
   + "<button id='btnCancel' class='small' onClick='javascript:hiddenComment()'>Cancel</button><br><br>";
  
  	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvComment.style.width = "200"; }
  	else if(isSafari) { document.all.dvComment.style.width = "auto"; }
  
   document.all.dvComment.innerHTML=html;
   document.all.dvComment.style.visibility="visible"
}
//---------------------------------------------------------
// build Comment Entry panel
//---------------------------------------------------------
function sbmCompleteSts(sts, grp, grpName, date, type)
{
  if(document.all.txaComment.value.trim().length > 0)
  {
    chgStatus(sts, grp, grpName, date, type); hiddenComment();
  }
}
//---------------------------------------------------------
// build trim() function
//---------------------------------------------------------
if (!String.prototype.trim) 
{	  
	String.prototype.trim = function () 
	{
	    return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
	};
}
//---------------------------------------------------------
// hidden comment entry panel
//---------------------------------------------------------
function hiddenComment()
{
  document.all.dvComment.style.visibility="hidden";
}

//---------------------------------------------------------
// Collapse/Uncollapse Details
//---------------------------------------------------------
function collapseDetail()
{
  var row = null;
  if(collapse=="D")
  {
    for(var i=0; i < <%=iNumOfItm%>; i++)
    {
       row = "Dtl" + i;
       if(document.all[row] == null) {  break; }
       document.all[row].style.display="none";
    }
    collapse="T";
    if (Store!="ALL")
    {
      document.all.collapse.innerHTML="Display Details"
      document.all.Hdr01.innerHTML="Division Name"
      document.all.Hdr02.innerHTML="&nbsp;"
    }

  }
  else
  {
    for(var i=0; i < <%=iNumOfItm%>; i++)
    {
       row = "Dtl" + i;
       if(document.all[row] == null) { break; }
       
       if(isIE && ua.indexOf("MSIE 7.0") >= 0)
 	   {
    	   document.all[row].style.display="block";
 	   }
       else
       {
    	   document.all[row].style.display="table-row";
       }
    }
    collapse="D";
    if (Store!="ALL")
    {
      document.all.collapse.innerHTML="Collapse Details";
      document.all.Hdr01.innerHTML="Class Name"
      document.all.Hdr02.innerHTML="Vendor Name"
    }
  }
}
//=========================================================
// check scroll
//=========================================================
$(window).scroll(function() 
{	
	var row = document.all.trHdr1;
	var elementTop = $(row).offset().top;
	var elementBottom = elementTop + $(row).outerHeight();
	var viewportTop = $(window).scrollTop();
	var viewportBottom = viewportTop + $(window).height();

	if(elementTop + 20 < viewportTop  )
	{
		var offsetTop = $(this).scrollTop();
		offsetTop = offsetTop - elementTop;
		//$("#trHdr1").css({position : "relative", "z-index" : 60, top: offsetTop - 320 });
		//$("#trHdr2").css({position : "relative", "z-index" : 60, top: offsetTop - 320 });
		$("#trHdr1").css({position : "relative", "z-index" : 60, top: offsetTop });
		$("#trHdr2").css({position : "relative", "z-index" : 60, top: offsetTop });
	}
	else 
	{
		$("#trHdr1").css({position : "static"});
		$("#trHdr2").css({position : "static" });
	}
		
	window.status = "elementTop=" + elementTop + " | elementBottom=" + elementBottom
	   + " | viewportTop=" + viewportTop + " | viewportBottom=" + viewportBottom

});
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
    <div id="dvComment" class="dvComment"></div>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Manage Transfer Requests
      <br><%if(sStore.equals("ALL")){%>Division:<%} else {%>Store:<%}%>
           <%=sMain + " - " + sMainName%> &nbsp;&nbsp
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="TransferReq.html">
         <font color="red" size="-1">Item Transfers</font></a>&#62;
      <a href="DivTrfReqSel.jsp">
         <font color="red" size="-1">Select Report</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      <!-------------------------------------------------------------------->
      </td>
     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
      <b><u>Outgoing Items</u></b>
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan="2"><%if(sStore.equals("ALL")){%>Store<%} else {%>Div<%}%></th>
      <%if(!sStore.equals("ALL") && sStrAllowed != null && sStrAllowed.startsWith("ALL")){%><th class="DataTable" rowspan="2">S<br>h<br>o<br>w</th><%}%>
      <th class="DataTable" colspan="2">Transfer initiated by</th>
      <th class="DataTable" colspan="2">Transfer approved by</th>
      <th class="DataTable" colspan="3">Transfers Out</th>
      <th class="DataTable" colspan="3">Printed</th>
      <th class="DataTable">Work in Progress*</th>
      <th class="DataTable" colspan="3">Sent</th>
    </tr>
    <tr>
      <th class="DataTable">User</th>
      <th class="DataTable">Date</th>
      <th class="DataTable">User</th>
      <th class="DataTable">Date</th>
      <th class="DataTable"># of<br>Stores</th>
      <th class="DataTable">Total<br>Items</th>
      <th class="DataTable">Total<br>Units</th>

      <th class="DataTable">Prt</th>
      <th class="DataTable">User</th>
      <th class="DataTable">Date</th>
      <th class="DataTable">Complete</th>
      <th class="DataTable">User</th>
      <th class="DataTable">Date</th>
      <th class="DataTable">Note</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
    <%for(int i=0; i<iNumOfGrp; i++){%>
      <tr class="DataTable">
         <td class="DataTable1" nowrap rowspan="<%=iNumOfTrfDate[i]%>">
               <%=sGrp[i] + " - " + sGrpName[i]%>
         </td>
      <!-- Class In count-->
        <%for(int j=0; j < iNumOfTrfDate[i]; j++) {%>
         <%if(j>0){%><tr class="DataTable"><%}%>
          <%if(!sStore.equals("ALL") && sStrAllowed != null && sStrAllowed.startsWith("ALL")){%>
            <th class="DataTable">
              <a href="javascript: printTrfReq('<%=sGrp[i]%>', '<%=sGrpName[i]%>', '<%=sAppDate[i][j]%>', 'N')">S</a>
            </th>
          <%}%>
          <td class="DataTable" ><%=sCrtUser[i][j]%></td>
          <td class="DataTable" ><%=sCrtDate[i][j]%></td>
          <td class="DataTable" ><%=sAppUser[i][j]%></td>
          <td class="DataTable" ><%=sAppDate[i][j]%></td>
          <td class="DataTable" ><%=sDstStr[i][j]%>
          <td class="DataTable" ><%=sItmCnt[i][j]%></td>
          <td class="DataTable" ><%=sQty[i][j]%>
          <td class="DataTable" >
             <%if (sStrAllowed != null && !sStrAllowed.startsWith("ALL")){%>
               <a href="javascript: printTrfReq('<%=sGrp[i]%>', '<%=sGrpName[i]%>', '<%=sAppDate[i][j]%>', 'Y')">Print</a>
             <%}%>
          </td>
          <td class="DataTable" ><%=sPrtUser[i][j]%></td>
          <td class="DataTable" ><%if(!sPrtUser[i][j].equals("")){%><%=sPrtDate[i][j]%><%}%></td>
          <td class="DataTable" >
             <%if (!sInTransit[i][j].equals("0")
                && sStrAllowed != null && !sStrAllowed.startsWith("ALL")){ %>
                <a href="javascript: chgStatus('S', '<%=sGrp[i]%>', '<%=sGrpName[i]%>', '<%=sAppDate[i][j]%>', 'ALL')">All?</a>,
                <a href="javascript: setCommentEntry('S', '<%=sGrp[i]%>', '<%=sGrpName[i]%>', '<%=sAppDate[i][j]%>', 'NONE')">None?</a>,
                <a href="javascript: setCommentEntry('S', '<%=sGrp[i]%>', '<%=sGrpName[i]%>', '<%=sAppDate[i][j]%>', 'SOME')">Some?</a>
             <%}
             else if(!sCmpUser[i][j].equals("")){%>
                  <%if(sCmpType[i][j].equals("A")){%>All Sent<%}
                    else if(sCmpType[i][j].equals("S")){%>Some Sent<%}
                    else if(sCmpType[i][j].equals("N")){%>Not Sent<%}%>
             <%}%>
          </td>
          <td class="DataTable" ><%=sCmpUser[i][j]%></td>
          <td class="DataTable" ><%if(!sCmpUser[i][j].equals("")){%><%=sCmpDate[i][j]%><%}%></td>
          <td class="DataTable" ><%=sCmpNote[i][j]%></td>
        </tr>
       <%}%>
    <%}%>
<!---------------------------- end of Detail data ----------------------------->
 </table>
<!--------------------------- end of Outgoing table --------------------------->
<p ><span style="color:red; font-size:12px;font-weight:normal">* Click on "completed?" when finished</span>
<%if(!sStore.equals("ALL")){%>
  <p><b><u>Incoming Items</u></b>
  <br>
      <a href="javascript: collapseDetail();">
         <span id="collapse" style="font-size:10px;font-weight:normal">Collapse Detail</span>
      </a>
  <!----------------- Items Send to store table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr id="trHdr1">
      <th class="DataTable" >Div</th>
      <th class="DataTable" id="Hdr01"></th>
      <th class="DataTable" id="Hdr02"></th>
      <th class="DataTable" >Color</th>
      <th class="DataTable" >Size</th>
      <th class="DataTable" >Description</th>
      <th class="DataTable" >Issuing<br>Store</th>
      <th class="DataTable" >Req<br>Qty</th>
      <th class="DataTable" colspan="2">Originated</th>
      <th class="DataTable" colspan="4">Store Status</th>
      <th class="DataTable" colspan="5">Distribution Status</th>
      <th class="DataTable" >Xfer<br>%</th>      
    </tr>
    <tr  id="trHdr2">
      <th class="DataTable" colspan=8>&nbsp;</th>
      <th class="DataTable" >User</th>
      <th class="DataTable" >Date</th>
      <th class="DataTable" >Status</th>
      <th class="DataTable" >User</th>
      <th class="DataTable" >Date</th>
      <th class="DataTable" >Completion<br>Type</th>
      <th class="DataTable" >Distro<br>Number</th>
      <th class="DataTable" >Distro<br>Date</th>
      <th class="DataTable" >Status</th>
      <th class="DataTable" >Status<br>Date</th>
      <th class="DataTable" >Distro<br>Qty</th>
      <th class="DataTable">&nbsp;</th>
    </tr>
<!------------------------------- Detail Data --------------------------------->

    <%int iDiv=0;%>
    <%int iDtl=0;%>
    <%for(int i=0; i<iNumOfItm; i++){
    	itmToStr.setItmTrfDtl();
    	String sToDiv = itmToStr.getToDiv();
        String sToDivName = itmToStr.getToDivName();
        String sToCls = itmToStr.getToCls();
        String sToVen = itmToStr.getToVen();
        String sToClsName = itmToStr.getToClsName();
        String sToVenName = itmToStr.getToVenName();
        String sToSty = itmToStr.getToSty();
        String sToClr = itmToStr.getToClr();
        String sToSiz = itmToStr.getToSiz();
        String sToClrName = itmToStr.getToClrName();
        String sToSizName = itmToStr.getToSizName();
        String sToSku = itmToStr.getToSku();
        String sToDesc = itmToStr.getToDesc();
        String sToQty = itmToStr.getToQty();
        String sToIssStr = itmToStr.getToIssStr();
        String sToOrigUs = itmToStr.getToOrigUs();
        String sToOrigDt = itmToStr.getToOrigDt();
        String sToSts = itmToStr.getToSts();
        String sToLstUs = itmToStr.getToLstUs();
        String sToLstDt = itmToStr.getToLstDt();
        String sToCmpTy = itmToStr.getToCmpTy();
        String sToDtlOrTot = itmToStr.getToDtlOrTot();
        
        int iPnMax = itmToStr.getPnMax();
        String [] sPnDst = itmToStr.getPnDst();
        String [] sPnDstDt = itmToStr.getPnDstDt();
        String [] sPnSts = itmToStr.getPnSts();
        String [] sPnStsNm = itmToStr.getPnStsNm();
        String [] sPnStsDt = itmToStr.getPnStsDt();
        String [] sPnQty = itmToStr.getPnQty();
        String sPnTotQty = itmToStr.getPnTotQty();
        String sPnCompl = itmToStr.getPnCompl();        
    %>
      <tr class="<%if(sToDtlOrTot.equals("Y")){%>DataTable3<%}
                   else if(sToSts.equals("In Progress")){%>DataTable1<%}
                   else if(sToSts.equals("Available")){%>DataTable2<%}
                   else {%>DataTable<%}%>"
          id="<%if(sToDtlOrTot.equals("Y")){%>Tot<%=iDiv++%><%} else{%>Dtl<%=iDtl++%><%}%>">

         <td class="DataTable" ><%=sToDiv%></td>

         <%if(sToDtlOrTot.equals("Y")){%>
              <td class="DataTable" ><%=sToDivName%></td>
              <td class="DataTable" >&nbsp;</td>
         <%}
           else {%>
              <td class="DataTable1" ><%=sToClsName%></td>
              <td class="DataTable1" ><%=sToVenName%></td>
         <%}%>


         <td class="DataTable" ><%=sToClrName%></td>
         <td class="DataTable" ><%=sToSizName%></td>
         <td class="DataTable" ><%=sToDesc%></td>
         <td class="DataTable" ><%=sToIssStr%></td>
         <td class="DataTable3g" ><%=sToQty%></td>
         <td class="DataTable" ><%=sToOrigUs%></td>
         <td class="DataTable" nowrap><%=sToOrigDt%></td>
         <td class="DataTable" ><%=sToSts%></td>
         <td class="DataTable" ><%=sToLstUs%></td>
         <td class="DataTable" nowrap><%if(!sToLstDt.equals("0001-01-01")){%><%=sToLstDt%><%} else{%>&nbsp;<%} %></td>
         <td class="DataTable" ><%if(!sToLstDt.equals("0001-01-01")){%><%=sToCmpTy%><%} else{%>&nbsp;<%} %></td>
         
         <td class="DataTable3g" ><%String sBr = "";%><%for(int j=0; j < iPnMax; j++){%><%=sBr + sPnDst[j]%><%sBr = "<br>";%><%}%></td>
         <td class="DataTable3g" ><%sBr = "";%><%for(int j=0; j < iPnMax; j++){%><%=sBr + sPnDstDt[j]%><%sBr = "<br>";%><%}%></td>
         <td class="DataTable3g" ><%sBr = "";%><%for(int j=0; j < iPnMax; j++){%><%=sBr + sPnStsNm[j]%><%sBr = "<br>";%><%}%></td>
         <td class="DataTable3g" ><%sBr = "";%><%for(int j=0; j < iPnMax; j++){%><%=sBr + sPnDstDt[j]%><%sBr = "<br>";%><%}%></td>
         <td class="DataTable3g" >
            <%if(sToDtlOrTot.equals("Y")){%><%=sPnTotQty%>            
            <%} else {%>   <%sBr = "";%><%for(int j=0; j < iPnMax; j++){%><%=sBr + sPnQty[j]%><%sBr = "<br>";%><%}%>
            <%}%>
         </td>
         <td class="DataTable3g" >&nbsp;<%=sPnCompl%>%</td> 
      </tr>
    <%}%>
<!---------------------------- end of Detail data ----------------------------->
 </table>
<%}%>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>

<%
    itmToStr.disconnect();
   } 
%>
