<%@ page import="rental.RentInvList ,java.util.*, java.text.*"%>
<%
   String [] sSrchCls = request.getParameterValues("Cls");
   String [] sSrchStr = request.getParameterValues("Str");
   String sIncl = request.getParameter("Incl");
   String sSort = request.getParameter("Sort");

   if (sSort == null){ sSort = "ITEM"; }
   if (sIncl == null){ sIncl = " "; }
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RentInvList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   String sUser = session.getAttribute("USER").toString();

   // set flag to allow delete inventory serial number
   boolean bAllowInvDlt = (session.getAttribute("REINVDLT") != null);

   RentInvList rentinv = new RentInvList(sSrchCls, sSrchStr, sIncl, sSort, sUser);
   int iNumOfStr = rentinv.getNumOfStr();
   String [] sStr = rentinv.getStr();
%>
<html>

<head>
<title>Rent_Equipment_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
 		table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
         
        table.DataTable { text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:LemonChiffon; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 {background:#e7e7e7; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}
        #tdAllInv { display: none; }
        #tdAvlInv { display: block; }

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvItem  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvChkItm  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvCont  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
        div.dvComment  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background: #016aab;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;  background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var StrType = true;

var ChkItem = new Array();
var ChkItemDtl = new Array();

var SelObj = null;
var SelStr = null;
var SelCls = null;
var SelVen = null;
var SelSty = null;
var SelClr = null;
var SelSiz = null;
var SelDesc = null;
var SelClrnm = null;
var SelSiznm = null;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvCont", "dvItem", "dvComment"]);
}

//==============================================================================
// show tag availability
//==============================================================================
function showTagAvl(cls, ven,  sty, clr, siz, desc, clrNm, sizNm, invId, srlNum
	    , contId, pickDt, rtnDt,str, itmSts, rmvDt, purchYr, equipTy, irow
	    , testDt, grade, tech, techNm, rmvUs)
{
  var hdr = desc + " &nbsp; Size: " + sizNm + " Store:" + str;

  var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvChkItm&#34;); hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popTagAvlPanel(cls, ven,  sty, clr, siz, desc, clrNm, sizNm, invId, srlNum
		    , contId, pickDt, rtnDt,str, itmSts, rmvDt, purchYr, equipTy, irow
		    , testDt, grade, tech, techNm, rmvUs)

   html += "</td></tr></table>"

   document.all.dvChkItm.innerHTML = html;
   document.all.dvChkItm.style.width = 250;
   document.all.dvChkItm.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvChkItm.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvChkItm.style.visibility = "visible";
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popTagAvlPanel(cls, ven,  sty, clr, siz, desc, clrNm, sizNm, invId, srlNum
	    , contId, pickDt, rtnDt,str, itmSts, rmvDt, purchYr, equipTy, irow
	    , testDt, grade, tech, techNm, rmvUs)
{
   SelStr = str;
   SelCls = cls;
   SelVen = ven;
   SelSty = sty;
   SelClr = clr;
   SelSiz = siz;
   SelDesc = desc;
   SelClrnm = clrNm;
   SelSiznm = sizNm;

   var dummy = "<table>"
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
   panel += "<tr class='DataTable'>"
             + "<th class='DataTable' nowrap>Serial Number</th>"
             + "<th class='DataTable' nowrap>Has Contract?</th>"
             + "<th class='DataTable' nowrap>Sts</th>"
             + "<th class='DataTable' nowrap>T<br>e<br>s<br>t</th>"
             + "<th class='DataTable' nowrap>Test<br>Date</th>"
             + "<th class='DataTable' nowrap>Grade</th>"
             + "<th class='DataTable' nowrap>Tech</th>"
             + "<th class='DataTable' nowrap>Change Item<br>Status</th>"
             + "<th class='DataTable' nowrap>Show<br>Comments</th>"
             + "<th class='DataTable' nowrap>Purchase<br>Year</th>"
             + "<th class='DataTable' nowrap>Equipment<br>Type</th>"
   <%if(bAllowInvDlt){%>+ "<th class='DataTable' nowrap>D<br>l<br>t</th>"<%}%>
          + "</tr>"

   for(var i=0; i < srlNum.length; i++)
   {
      // check if any contract in the future assigned to serial number
      var hasCont = false;
      for(var j=0; j < contId[i].length; j++)
      {
          if(contId[i][j]!=""){ hasCont = true; break;}
      }

      panel += "<tr class='DataTable2'>"
        + "<td class='DataTable' nowrap>" + srlNum[i] + "</td>"

      // link to list of existing contract on that equipment
      if(hasCont)
      {
         panel += "<td class='DataTable2' nowrap><a href='javascript: getContLst(&#34;"
           + invId[i] + "&#34;)'>Yes</a></td>"
      }
      else {panel += "<td class='DataTable2' nowrap>No</td>"}

      if (itmSts[i]==""){ panel += "<td class='DataTable2' nowrap>Ready</td>"; }
      else{panel += "<td class='DataTable2' nowrap>" + itmSts[i] + " &nbsp; Removed:&nbsp;" + rmvUs[i] + "&nbsp;" + rmvDt[i] + " </td>"}
      
      panel += "<td class='DataTable2' nowrap><a href='javascript: setTestStamp(&#34;" + invId[i]
      + "&#34;,&#34;TEST_STAMP&#34;, &#34;" + srlNum[i] +  "&#34;)'>T</a></td>"
      if (testDt[i] != "01/01/0001")
      {
    	  panel += "<td class='DataTable2' nowrap>" + testDt[i] + "</td>";
      	  panel += "<td class='DataTable2' nowrap>" + grade[i] + "</td>";
      	  panel += "<td class='DataTable2' nowrap>" + tech[i] + " - " + techNm[i] + "</td>";
      }
      else
      {
    	  panel += "<td class='DataTable2' nowrap>&nbsp;</td>";
    	  panel += "<td class='DataTable2' nowrap>&nbsp;</td>";
    	  panel += "<td class='DataTable2' nowrap>&nbsp;</td>";
      }

      // link to make serial# unavailable
      if(!hasCont && itmSts[i]=="")
      {
         panel += "<td class='DataTable2' nowrap><a href='javascript: chgItmAvail(&#34;" + invId[i]
           + "&#34;,&#34;RMV_INV_AVAIL&#34;, &#34;" + srlNum[i] +  "&#34;)'>Remove</a></td>"
      }
      //else if(!hasCont && itmSts[i]=="UNAVAIL")
      else if(itmSts[i]=="UNAVAIL")
      {
         panel += "<td class='DataTable2' nowrap><a href='javascript: chgItmAvail(&#34;" + invId[i]
           + "&#34;,&#34;RTN_INV_AVAIL&#34;, &#34;" + srlNum[i] +  "&#34;)'>Activate</a></td>"
      }
      else{panel += "<td class='DataTable2' nowrap>&nbsp;</td>"}

      panel += "<td class='DataTable2' id='tdDspCommt" + i + "' nowrap><a href='javascript: getCommt(&#34;" + invId[i] + "&#34;,&#34;" + i + "&#34;)'>Display</a></td>"

      var etNm = "Any";
      if(equipTy[i] == "L"){ etNm = "Lease"; }
      else if(equipTy[i] == "R"){ etNm = "Rent"; }
      panel += "<td class='DataTable2' nowrap><a href='javascript: updSrlNum(&#34;" + invId[i] + "&#34;,&#34;" + srlNum[i] +  "&#34;,&#34;" + purchYr[i] + "&#34;, &#34;PURCHYR&#34;)'>" + purchYr[i] + "</a></td>"
      panel += "<td class='DataTable2' nowrap><a href='javascript: updSrlNum(&#34;" + invId[i] + "&#34;,&#34;" + srlNum[i] +  "&#34;,&#34;" + equipTy[i] + "&#34;, &#34;EQUIPTY&#34;)'>" + etNm + "</a></td>"
      <%if(bAllowInvDlt){%>
          panel += "<td class='DataTable2' nowrap><a href='javascript: dltSrlNum(&#34;" + invId[i] + "&#34;,&#34;" + srlNum[i] +  "&#34;)'>D</a></td>"
      <%}%>
   }

   panel += "<tr><td class='Prompt1'>"
        + "<button onClick='createSrlNum(&#34;" + str + "&#34;, &#34;" + cls + "&#34;, &#34;"
        + ven + "&#34;, &#34;" + sty + "&#34;, &#34;" + clr + "&#34;, &#34;" + siz + "&#34;, &#34;"
        + desc + "&#34;, &#34;" + clrNm + "&#34;, &#34;" + sizNm + "&#34;)' class='Small'>Add Serial#</button> &nbsp; &nbsp;"
        + '<br>'
        + "<button onClick='dltSrlNumGrp(&#34;" + str + "&#34;, &#34;" + cls + "&#34;, &#34;"
        + ven + "&#34;, &#34;" + sty + "&#34;, &#34;" + clr + "&#34;, &#34;" + siz + "&#34;, &#34;"
        + desc + "&#34;, &#34;" + clrNm + "&#34;, &#34;" + sizNm + "&#34;)' class='Small'>Delete Last Serial#</button> &nbsp; &nbsp;"
        + "</td>"

   panel += "<td class='Prompt1' colspan=7>"
        + "<button onClick='getSrlNum(&#34;" + str + "&#34;, &#34;" + cls + "&#34;, &#34;"
        + ven + "&#34;, &#34;" + sty + "&#34;, &#34;" + clr + "&#34;, &#34;" + siz + "&#34;, &#34;"
        + desc + "&#34;, &#34;" + clrNm + "&#34;, &#34;" + sizNm + "&#34;, &#34;" + irow + "&#34;)' class='Small'>Refresh</button> &nbsp; &nbsp;"

        + "<button onClick='hidePanel(&#34;dvChkItm&#34;); hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
      + "</td>"

        + "</tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// show checked out items
//==============================================================================
function getSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, irow)
{
   hidePanel("dvItem");
   hidePanel("dvCont");

   var date = new Date();
   var mdy = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   
   url="RentTagAvlQuickLst.jsp?Cls=" + cls
   	+ "&Ven=" + ven
   	+ "&Sty=" + sty
   	+ "&Clr=" + clr
   	+ "&Siz=" + siz
   	+ "&Str=" + str
   	+ "&FrDate=" + mdy
   	+ "&ToDate=ENDOFYEAR"
   	+ "&Desc=" + desc
   	+ "&ClrNm=" + clrnm
   	+ "&SizNm=" + siznm
   	+ "&Row=" + irow
   
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// show checked out items
//==============================================================================
function createSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
   var hdr = "Add New Serial Number";

   var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popNewSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 350;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate new serial number panel
//==============================================================================
function popNewSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
   panel += "<tr class='DataTable'>"
             + "<td class='DataTable' nowrap>"
               + "<input name='Reason' type='radio' value='New Inventory' checked>New Inventory &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
               + "<input name='Reason' type='radio' value='Transition from lease fleet'>Transition from lease fleet"
             + "</td>"
          + "</tr>"
          
          + "<tr class='DataTable'>"
            + "<td class='DataTable' nowrap>"
              + "Number of new S/N <input name='Qty' value='1' size=3 maxlength=3>"             
            + "</td>"
       + "</tr>"

   panel += "<tr class='DataTable'><td class='Prompt1' colspan=4>"
         + "<button onClick='vldNewSrlNum(&#34;" + str + "&#34;, &#34;" + cls + "&#34;, &#34;"
         + ven + "&#34;, &#34;" + sty + "&#34;, &#34;" + clr + "&#34;, &#34;" + siz + "&#34;, &#34;"
         + desc + "&#34;, &#34;" + clrnm + "&#34;, &#34;" + siznm + "&#34;)' class='Small'>Add</button> &nbsp; &nbsp;"
        + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
       + "</td>"  
    + "</tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
//validate new serial number
//==============================================================================
function vldNewSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
	var error = false;
	var msg="";
	
	var qty = document.all.Qty.value.trim();
	if(qty == ""){ error=true; msg="Please enter quantity of new S/N"}
	else if(isNaN(qty)){ error=true; msg="Quantity is not numeric"}
	else if( eval(qty) < 1 || eval(qty) > 100){ error=true; msg="Quantity must be from 1 to 100"}
	
	if(error){ alert(msg); }
	else{ sbmNewSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, qty); }
}
//==============================================================================
// submit new serial number
//==============================================================================
function sbmNewSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, qty)
{
   SelStr = str;
   SelCls = cls;
   SelVen = ven;
   SelSty = sty;
   SelClr = clr;
   SelSiz = siz;
   SelDesc = desc;
   SelClrnm = clrnm;
   SelSiznm = siznm;

   var date = new Date();
   var mdy = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   var reason = null;
   for(var i=0; i < document.all.Reason.length; i++)
   {
      if(document.all.Reason[i].checked){ reason = document.all.Reason[i].value; }
   }

   hidePanel("dvItem");
   hidePanel("dvCont");

   url="RentContractSave.jsp?"
         + "Cls=" + cls
         + "&Ven=" + ven
         + "&Sty=" + sty
         + "&Clr=" + clr
         + "&Siz=" + siz
         + "&Str=" + str
         + "&Reason=" + reason
         + "&NumSn=" + qty
         + "&Action=CRT_SRL_NUM"
   ;
   //alert(url);
   window.frame1.location.href=url;
}



//==============================================================================
//delete last serial numbers by number of rows 
//==============================================================================
function dltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
var hdr = "Delete Last Serial Number";

var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
  + "<tr>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
    + "</td></tr>"
html += "<tr><td class='Prompt' colspan=2>"

html += popdltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)

html += "</td></tr></table>"

document.all.dvItem.innerHTML = html;
document.all.dvItem.style.width = 350;
document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 120;
document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate new serial number panel
//==============================================================================
function popdltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
	panel += "<tr class='DataTable'>"
		 + "<td class='DataTable' nowrap>"
		 + "The Only equipments w/o contract will be counted and deleted?"             
		 + "</td>"
	   + "</tr>"
       
       + "<tr class='DataTable'>"
         + "<td class='DataTable' nowrap>"
           + "Delete Last S/N <input name='Qty' value='1' size=3 maxlength=3>"             
         + "</td>"
    + "</tr>"

panel += "<tr class='DataTable'><td class='Prompt1' colspan=4>"
      + "<button onClick='vldDltSrlNumGrp(&#34;" + str + "&#34;, &#34;" + cls + "&#34;, &#34;"
      + ven + "&#34;, &#34;" + sty + "&#34;, &#34;" + clr + "&#34;, &#34;" + siz + "&#34;, &#34;"
      + desc + "&#34;, &#34;" + clrnm + "&#34;, &#34;" + siznm + "&#34;)' class='Small'>Delete</button> &nbsp; &nbsp;"
     + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
    + "</td>"
 + "</tr>"

panel += "</table>";

return panel;
}
//==============================================================================
//validate new serial number
//==============================================================================
function vldDltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
	var error = false;
	var msg="";
	
	var qty = document.all.Qty.value.trim();
	if(qty == ""){ error=true; msg="Please enter quantity of deleting S/N"}
	else if(isNaN(qty)){ error=true; msg="Quantity is not numeric"}
	else if( eval(qty) < 1 || eval(qty) > 100){ error=true; msg="Quantity must be from 1 to 100"}
	
	if(error){ alert(msg); }
	else{ sbmDltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, qty); }
}
//==============================================================================
//submit new serial number
//==============================================================================
function sbmDltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, qty)
{
	SelStr = str;
	SelCls = cls;
	SelVen = ven;
	SelSty = sty;
	SelClr = clr;
	SelSiz = siz;
	SelDesc = desc;
	SelClrnm = clrnm;
	SelSiznm = siznm;

	var date = new Date();
	var mdy = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
	var reason = " ";	

	hidePanel("dvItem");
	hidePanel("dvCont");

	url="RentContractSave.jsp?"
      + "Cls=" + cls
      + "&Ven=" + ven
      + "&Sty=" + sty
      + "&Clr=" + clr
      + "&Siz=" + siz
      + "&Str=" + str
      + "&Reason=" + reason
      + "&NumSn=" + qty
      + "&Action=DLT_LAST_SN"
	;
	//alert(url);
	window.frame1.location.href=url;
}
//==============================================================================
// refresh serial number
//==============================================================================
function refreshSrl()
{
   getSrlNum(SelStr, SelCls, SelVen, SelSty, SelClr, SelSiz, SelDesc, SelClrnm, SelSiznm, 0);
}
//==============================================================================
// get Comments
//==============================================================================
function getCommt(invId, arg)
{
   var objnm = "tdDspCommt" + arg;
   SelObj = document.all[objnm];
   var url = "RentItemComments.jsp?"
     + "InvId=" + invId
     + "&Action=INV_ID_COMMT"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// get comments
//==============================================================================
function showComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
{
   var hdr = "All Comments";
   var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvComment&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
    + "<tr><td class='Prompt'>" + popComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
     + "</td></tr>"
   + "</table>"

   var pos = getObjPosition(SelObj);
   document.all.dvComment.innerHTML = html;
   document.all.dvComment.style.pixelLeft= document.documentElement.scrollLeft + 50;
   document.all.dvComment.style.pixelTop= pos[1] + 25;
   document.all.dvComment.style.visibility = "visible";
}
//==============================================================================
// populate customer equipment
//==============================================================================
function popComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
{
  var dummy="<table>";
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable'>"
         + "<th>Type</th>"
         + "<th width='75%'>Comments</th>"
         + "<th>User</th>"
         + "<th>Date</th>"
         + "<th>Time</th>"
       + "</tr>"

  var clsId = "1";
  for(var i=0, j=0; i < commId.length; i++)
  {
     if(i > 0 && commId[i] != commId[i-1])
     {
        if( clsId=="1" ){ clsId = ""; }
        else { clsId = "1"; }
     }

     if(i == 0 || i > 0 && commId[i] != commId[i-1])
     {
        panel += "<tr class='DataTable" + clsId + "' id='trCommt" + j + "'>"
        panel += "<td class='DataTable' id='tdType" + j + "'>" + subType[i] + "</td>"
        panel += "<td class='DataTable'>"
        j++;
        NumOfCommt = j;
     }

     panel += commt[i];

     if( commId[i] != commId[i+1])
     {
        panel += "</td>"
               + "<td class='DataTable' nowrap>" + recUsr[i] + "</td>"
               + "<td class='DataTable' nowrap>" + recDt[i] + "</td>"
               + "<td class='DataTable' nowrap>" + recTm[i] + "</td>"
          + "</tr>"
     }
  }

  panel += "</table>";
  return panel;
}
//==============================================================================
// filter comments
//==============================================================================
function filterCommt(grp)
{
   for(var i=0; i < NumOfCommt; i++)
   {
      var tdname = "tdType" + i;
      var trname = "trCommt" + i;
      if(grp == "All" || document.all[tdname].innerHTML == grp)
      {
         document.all[trname].style.display="block";
      }
      else{ document.all[trname].style.display="none"; }
      }
}
//==============================================================================
// change item availability
//==============================================================================
function chgItmAvail(invId, action, srlNum )
{
   var hdr = "Remove Item Availability &nbsp; Serial# " + srlNum;

   var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popItmAvail(invId, action)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 350;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popItmAvail(invId, action)
{
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
   panel += "<tr class='DataTable3'>"
             + "<td><textarea name='Commt' cols=70 rows=5></textarea></td>"
          + "</tr>"
   if (action == "RMV_INV_AVAIL")
   {
      panel += "<tr class='DataTable3'>"
            + "<td nowrap>Reason &nbsp; <input name='Reason' type='radio' value='DAMAGED' checked>Damaged"
            + " &nbsp; <input name='Reason' type='radio' value='STOLEN' >Lost/Stolen"
            + " &nbsp; <input name='Reason' type='radio' value='WARNOUT' >Worn out</td>"
          + "</tr>"
   }

   panel += "<tr><td class='Prompt1' colspan=5>"
   if (action == "RMV_INV_AVAIL")
   {
      panel += "<button onClick='setItmUanavail(&#34;" + invId + "&#34;,&#34;" + action
            + "&#34;);' class='Small'>Unavailable</button> &nbsp; &nbsp;"
   }
   else
   {
      panel += "<button onClick='setItmUanavail(&#34;" + invId + "&#34;,&#34;" + action
            + "&#34;);' class='Small'>Make Available</button> &nbsp; &nbsp;"
   }
   panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// set Item status
//==============================================================================
function setItmUanavail(invId, action)
{
   var commt = document.all.Commt.value;
   commt = commt.replace(/\n\r?/g, '<br />');

   var reason = "";
   if (action == "RMV_INV_AVAIL")
   {
      for(var i=0; i < document.all.Reason.length; i++)
      {
         if(document.all.Reason[i].checked)
         {
           reason = document.all.Reason[i].value;
           break;
         }
      }
   }
   else { reason = "AVAILABLE"; }

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmItmAvail"

    var html = "<form name='frmItmAvail'"
       + " METHOD=Post ACTION='RentContractSave.jsp'>"
       + "<input class='Small' name='InvId'>"
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Reason'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);
   window.frame1.document.all.InvId.value = invId;
   window.frame1.document.all.Commt.value=commt;
   window.frame1.document.all.Reason.value=reason;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmItmAvail.submit();
   hidePanel("dvItem");
}

//==============================================================================
// set test stamp
//==============================================================================
function setTestStamp(invId, action, srlNum)
{
	var hdr = "Set Test Stamp &nbsp; Serial# " + srlNum;

	   var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popTestStamp(invId, action)

	   html += "</td></tr></table>"

	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "200"; }
	   else { document.all.dvItem.style.width = "auto"; }
	   
	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
	   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 120;
	   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popTestStamp(invId, action)
{
   var panel = "<table  border=1 width='100%' cellPadding='0' cellSpacing='0' >";
   panel += "<tr class='DataTable3'>"
        + "<td>Grade:</td>"
        + "<td nowrap>" 
          	+ " <input type='radio' name='Grade' value='PASSED'>Passed &nbsp; " 
          	+ " <input type='radio' name='Grade' value='FAILED'>Failed"
        + "</td>"
     + "</tr>"
     + "<tr class='DataTable3'>"
     	+ "<td nowrap>Tech:</td>"
     	+ "<td nowrap><input name='Tech' maxlength='4' size='6'></td>"
  	+ "</tr>"
   
  	panel += "<tr class='DataTable3'>" 
  	 + "<td align=center colspan=2><button onClick='vldItmTest(&#34;" + invId + "&#34;,&#34;" + action
  		+ "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
  	panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"
   	panel += "</table>";
   	return panel;
}
//==============================================================================
//validate item test stamp
//==============================================================================
function vldItmTest(invId, action)
{
	var error = false;
	var msg = "";
	
	var grade = null;
	for(var i=0; i < document.all.Grade.length; i++)
	{
		if(document.all.Grade[i].checked){ grade = document.all.Grade[i].value; break; }
	}
	if(grade == null){ error=true; msg += "\nPlease check grade."; }
	
	var tech = document.all.Tech.value.trim();
	if(tech==""){error = true; msg += "\nPlease enter your employee number"; }
	else if(isNaN(tech)){error = true; msg += "\n>The employee number is not numeric"; }
	else if (!isEmpNumValid(tech)){error = true; msg += "\nEmployee number is invalid."; }	
    
	
	if(error) { alert(msg) }
	else { sbmItmTest(invId, grade, tech, action) }
}
//==============================================================================
//submit Item Test Grade 
//==============================================================================
function sbmItmTest(invId, grade, tech, action)
{
	url = "RentContractSave.jsp?InvId=" + invId
	 + "&Grade=" + grade
	 + "&Tech=" + tech
	 + "&Action=" + action
	;
	if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
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
// reload screen
//==============================================================================
function updSrlNum(invId, srlNum, val, name)
{
   var hdr = "Change Serial# " + srlNum;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSrlNum(invId, srlNum, val, name)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.dvItem.style.visibility = "visible";
   if(name == "PURCHYR"){ document.all.PurchYr.focus(); }
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popSrlNum(invId, srlNum, val, name)
{
   var action = "";
   var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>";
   panel += "<tr class='DataTable3'>"
   if (name == "PURCHYR")
   {
      panel += "<td class='DataTable1' nowrap>Purchase Year: </td>"
             + "<td><input class='Small' name='PurchYr' size=4 maxlength=4></td>"
      action = "UPD_PURCH_YR";
   }
   else if (name == "EQUIPTY")
   {
      panel += "<td class='DataTable1' nowrap>Equipment Type: </td>"
            + "<td nowrap>"
            + "<input name='EquipTy' type='radio' value='L'>Lease &nbsp; "
            + "<input name='EquipTy' type='radio' value='R'>Rental &nbsp;"
            + "<input name='EquipTy' type='radio' value='ANY' checked>Any &nbsp;"
            + "</td>"
      action = "UPD_EQUIP_TYPE";
   }
   panel += "</tr>"

   panel += "<tr><td class='Prompt1' colspan=2>"
   panel += "<button onClick='validateSrlNumParts(&#34;" + invId + "&#34;,&#34;" + action
            + "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
   panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// validate serial number parts updates
//==============================================================================
function validateSrlNumParts(invId, action)
{
   var error = false;
   var msg = "";
   var yr = "";
   var type = "";

   // get current calendar year
   var date = new Date();
   var curYr = eval(date.getFullYear());
   if(action=="UPD_PURCH_YR")
   {
      yr = document.all.PurchYr.value.trim();
      if(yr == ""){ error = true; msg = "Please enter purchase year."; }
      else if(isNaN(yr)){ error = true; msg = "Purchase year is not numeric."; }
      else if(eval(yr) < 2000 || eval(yr) > curYr){ error = true; msg = "Purchase year is out of range."; }
   }
   else if(action=="UPD_EQUIP_TYPE")
   {
      for(var i=0; i < document.all.EquipTy.length; i++)
      {
         if(document.all.EquipTy[i].checked)
         {
            type = document.all.EquipTy[i].value.trim();
            break;
         }
      }
   }

   if(error) { alert(msg) }
   else { sbmSrlNumParts(invId, yr, type, action) }
}
//==============================================================================
// submit serial number updates
//==============================================================================
function sbmSrlNumParts(invId, yr, type, action)
{
   url="RentContractSave.jsp?"
      + "InvId=" + invId
      + "&PurchYr=" + yr
      + "&EquipTy=" + type
      + "&Action=" + action
   ;
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// delete serial
//==============================================================================
function dltSrlNum(invId, srlNum)
{
   var hdr = "Delete Serial# " + srlNum;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += "<table border=1 width='100%' cellPadding=0 cellSpacing=0 align=left>"
       + "<tr style='background: #cccfff; color:red; font-size:14px; font-weight:bold;'>"
           + "<td nowrap>Do you realy want to delete this inventory?</td>"
       + "</tr>"
       + "<tr>"
          + "<td align=center><button onClick='sbmDltSrlNum(&#34;" + invId + "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
          + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button></td>"
       + "<tr>"
     + "</table>"

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 140;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// submit seraila number deletion
//==============================================================================
function sbmDltSrlNum(invId)
{
   url="RentContractSave.jsp?"
      + "InvId=" + invId
      + "&Action=DLT_SRL_NUM"
   ;
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// reload screen
//==============================================================================
function refreshScreen()
{
  window.location.reload();
}
//==============================================================================
// show
//==============================================================================
function getContLst(invId)
{
   var date = new Date();
   var mdy = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

   url="RentalItmContLst.jsp?InvId=" + invId
         + "&FrDate=" + mdy
         + "&ToDate=ENDOFYEAR"
   ;
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// show
//==============================================================================
function showItemCont(InvId, Cont, Cust, PickDt, RetDt, FirstNm, MInit, LastNm, HPhone, CPhone, EMail)
{
  var hdr = "Contract List";

  var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvCont&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popItemCont(InvId, Cont, Cust, PickDt, RetDt, FirstNm, MInit, LastNm, HPhone, CPhone, EMail)

   html += "</td></tr></table>"

   document.all.dvCont.innerHTML = html;
   document.all.dvCont.style.width = 250;
   document.all.dvCont.style.pixelLeft= document.documentElement.scrollLeft + 350;
   document.all.dvCont.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvCont.style.visibility = "visible";
}
//==============================================================================
// populate Item Contract List
//==============================================================================
function popItemCont(InvId, Cont, Cust, PickDt, RetDt, FirstNm, MInit, LastNm, HPhone, CPhone, EMail)
{
var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
   panel += "<tr class='DataTable'>"
             + "<th class='DataTable' nowrap>Contract</th>"
             + "<th class='DataTable' nowrap>Name</th>"
             + "<th class='DataTable' nowrap>Home<br>Phone</th>"
             + "<th class='DataTable' nowrap>Cell<br>Phone</th>"
             + "<th class='DataTable' nowrap>E-Mail</th>"
          + "</tr>"

   for(var i=0; i < Cont.length; i++)
   {
      panel += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap><a href='RentContractInfo.jsp?ContId=" + Cont[i] + "' target='_blank'>" + Cont[i] + "</a></td>"
          + "<td class='DataTable' nowrap>" + FirstNm[i] + " " + MInit[i] + " " + LastNm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + HPhone[i] + "&nbsp;</td>"
          + "<td class='DataTable' nowrap>" + CPhone[i] + "&nbsp;</td>"
          + "<td class='DataTable' nowrap>" + EMail[i] + "&nbsp;</td>"
        + "</tr>"
   }

   panel += "<tr><td class='Prompt1' colspan=5>"
        + "<button onClick='hidePanel(&#34;dvCont&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel(obj)
{
   document.all[obj].innerHTML = " ";
   document.all[obj].style.visibility = "hidden";
}
//==============================================================================
// show help
//==============================================================================
function getHelp(on, obj)
{
   if(on)
   {
      var pos = getObjPosition(obj);
      document.all.dvHelp.innerHTML = "Click to Add";
      document.all.dvHelp.style.pixelLeft = pos[0] + 15;
      document.all.dvHelp.style.pixelTop = pos[1] - 5;
      document.all.dvHelp.style.visibility = "visible";
   }
   else{document.all.dvHelp.style.visibility = "hidden";}
}
//==============================================================================
// redispaly page with or without new items
//==============================================================================
function setInclItem(incl)
{
   var url = "RentInvList.jsp"
   var qstr = window.location.search

   var pos = qstr.indexOf("&Incl=")

   if(pos > 0) { qstr = qstr.substring(0, pos); }
   if(incl){ qstr += "&Incl=Y"; }
   url += qstr;

   //alert(url);
   window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp"></div>
<div id="dvChkItm" class="dvChkItm"></div>
<div id="dvCont" class="dvCont"></div>
<div id="dvItem" class="dvItem"></div>
<div id="dvComment" class="dvComment"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Rental Inventory List
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="RentInvListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
      &nbsp; &nbsp; &nbsp;
      <%if(!sIncl.equals("Y")) {%>Click <a href="javascript: setInclItem(true)">here</a> to include new items<%}
      else {%>Click <a href="javascript: setInclItem(false)">here</a> to exclude new items<%}%>

      <br>
  <!----------------------- Order List ------------------------------>
     <table border="1" class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable" rowspan=2>Dpt</th>
          <th class="DataTable" rowspan=2>Class</th>
          <th class="DataTable" rowspan=2>Description</th>
          <th class="DataTable" rowspan=2>Size</th>
          <th class="DataTable" rowspan=2>Total<br>Qty</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan="<%=iNumOfStr%>">Stores
            <br><span id="spnStrHdr">Inventory</span> &nbsp;
          </th>
       </tr>
       <tr class="DataTable">
          <%for(int i=0; i < iNumOfStr; i++){%>
             <th class="DataTable"><%=sStr[i]%></th>
          <%}%>
       </tr>

  <!-------------------------- Order List ------------------------------->
      <%
       while(rentinv.getNext())
       {
          rentinv.getItemList();

          String sDpt = rentinv.getDpt();
          String sCls = rentinv.getCls();
          String sVen = rentinv.getVen();
          String sSty = rentinv.getSty();
          String sClr = rentinv.getClr();
          String sSiz = rentinv.getSiz();
          String sDesc = rentinv.getDesc();
          String sDptNm = rentinv.getDptNm();
          String sClsNm = rentinv.getClsNm();
          String sClrNm = rentinv.getClrNm();
          String sSizNm = rentinv.getSizNm();
          String sTotQty = rentinv.getTotQty();

          rentinv.getItemDtl();
          String [] sStrQty = rentinv.getStrQty();
          String [] sStrAvlQty = rentinv.getStrAvlQty();
      %>
         <tr class="DataTable1">
           <td class="DataTable"><%=sDptNm%></td>
           <td class="DataTable"><%=sClsNm%></td>
           <td class="DataTable"><%=sDesc%></td>
           <td class="DataTable"><%=sSizNm%></td>
           <td class="DataTable1"><%=sTotQty%></td>
           <th class="DataTable">&nbsp;</th>

           <%for(int i=0; i < iNumOfStr; i++){%>
              <td class="DataTable" id="tdAllInv">&nbsp;<%=sStrQty[i]%></td>
              <td class="DataTable2" id="tdAvlInv" onclick="getSrlNum('<%=sStr[i]%>', '<%=sCls%>', '<%=sVen%>', '<%=sSty%>',
                   '<%=sClr%>', '<%=sSiz%>', '<%=sDesc%>', '<%=sClrNm%>', '<%=sSizNm%>', '<%=i%>')"
                onmouseover="getHelp(true, this)" onmouseout="getHelp(false, this)">
                   <%if(!sStrQty[i].equals("")){%>
                     <span style="cursor:hand; color: blue; text-decoration:underline;"><%=sStrQty[i]%></span>
                   <%} else{%><span style="cursor:hand;">&nbsp;&nbsp;<%}%>
              </td>
           <%}%>
         </tr>
      <%}%>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>


<%  rentinv.disconnect();
  }%>