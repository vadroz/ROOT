<%@ page import="itemtransfer.ItemList_v2, java.util.*"%>
<%
   String sDivision = request.getParameter("Div");
   String sDepartment = request.getParameter("Dpt");
   String sClass = request.getParameter("Cls");
   String sVendor = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");       
   String sBatch = request.getParameter("Batch");   
   String sBWhse = request.getParameter("BWhse");
   String sBComment = request.getParameter("BComment");
   String sRrn = request.getParameter("Rrn");
   String sPageSize = request.getParameter("PageSize");
    
   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sClass == null) sVendor = "Vendor";
   if(sSelSty == null) sSelSty = "ALL";
   
   if(sRrn == null){ sRrn = "0";}
   if(sPageSize == null){ sPageSize = "30";}
   
   long lStartTime = (new Date()).getTime();
    
   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";
   String sStrAllowed = "";

   //System.out.println(session.getAttribute("USER") + " appl: " + session.getAttribute("APPLICATION"));
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=ItemList.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }

      response.sendRedirect(sTarget + sbQuery.toString());
   }
   else {
     sStrAllowed = session.getAttribute("STORE").toString().trim();
     if (!sStrAllowed.startsWith("ALL"))
     {
        response.sendRedirect("ItemSel_v2.jsp");
     }

     //System.out.println("ItemList_v2.jsp" + sDivision + "|" + sDepartment + "|" + sClass + "|" + sVendor + "|"
     //  + sSelSty + "|" + sBatch + "|" + sBComment);
     ItemList_v2 itemLst = new ItemList_v2(sDivision, sDepartment, sClass, sVendor, sSelSty, sBatch, sBComment, sRrn,sPageSize);

     int iNumOfCVS = itemLst.getNumOfCVS();
     int iNumOfStr = itemLst.getNumOfStr();
     String [] sStr = itemLst.getStr();
     String sStrJSA = itemLst.getStrJSA();
     String sStrRegJSA = itemLst.getStrRegJSA();
     String sStrDstJSA = itemLst.getStrDstJSA();
     String sStrDstNmJSA = itemLst.getStrDstNmJSA();
     String sStrMallJSA = itemLst.getStrMallJSA();

     sBatch = itemLst.getBatch();
     
     boolean bEof = itemLst.getEof();
     String sLastRrn = itemLst.getLastRrn();     
     
     //System.out.println( "Batch=" + sBatch + "|" + sBComment);
         
   // color code for transfer items
   String [] sColor = new String[]{"255 255 0", "0 255 0",
                                   "255 105 180", "180 150 255",
                                   "255 69 0", "0 191 255"
                                   };
   boolean bTrfWhse = sBWhse.equals("W");
    
%>

<html>
<head>
<title>Buyer Item X-fer</title>
<style>body {background: ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: ivory solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: ivory solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: #ccccff; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: #ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; text-align:left;}
        td.DataTable4 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable5 { cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable6 { background:moccasin; cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}

        td.DataTable7 { background:moccasin; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:center;}
        td.DataTable8 { background:moccasin; cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; text-align:left;}
        td.DataTable9 { background:moccasin; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable10 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}

        td.DataTable11 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                         visibility:hidden;  text-align:right;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        <!-------- select another div/dpt/class pad ------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small1 {width:20; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        .Small {font-size:10px; }

        <!-------- transfer entry pad ------->
        div.fake { }
        div.dvTransfer { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvMenu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:Azure; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { text-align:left; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right;
                    font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid3 { text-align:center; font-family:Arial; font-size:10px;}

        td.Menu { cursor:hand; text-align:left; font-family:Arial; font-size:10px;}


        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        <!-------- end transfer entry pad ------->

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>



<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Division ="<%=sDivision%>";
var Department ="<%=sDepartment%>";

var NumOfCVS = "<%=iNumOfCVS%>";
var Stores = [<%=sStrJSA%>];
var StrReg = [<%=sStrRegJSA%>];
var StrDst = [<%=sStrDstJSA%>];
var StrDstNm = [<%=sStrDstNmJSA%>];
var StrMall = [<%=sStrMallJSA%>];
 
var trfFromCell = null;
var trfCls = null;
var trfVen = null;
var trfSty = null;
var trfClr = null;
var trfSize = null;
var trfFromStr = null;
var trfToStr = null;
var trfBegInv = 0;
var trfEndInv = 0;
var trfQty = 0;

var draged=false;
var disabledCell = new Array(1000);
var daCellMax = 0;

var TrfWhse = <%=bTrfWhse%>;
var aStrCol = new Array();

var aCellItmInvId = new Array();
var aCellCvsInvId = new Array();
var aCellItmSlsId = new Array();
var aCellCvsSlsId = new Array();
var aCellSellOfId= new Array();

var aItmInvByStr = new Array();
var aItmSlsByStr = new Array();
var aCvsInvByStr = new Array();
var aCvsSlsByStr = new Array();
var aCvsSellByStr= new Array();

var StartTime = "<%=lStartTime%>";
var EndTime = "<%=lStartTime%>";

var SpreadQty = 0;

//--------------- End of Global variables ----------------
function bodyLoad()
{  			
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{  
	   isSafari = true;
	}
	
	
	//setItemByStr();
}
 
//==========================================================================
// set Item and CVS cell id by stores
//==========================================================================
function setItemByStr()
{
	for(var i=0; i < Stores.length; i++)
	{
		aItmInvByStr[i] = new Array();
		aItmSlsByStr[i] = new Array();
		aCvsInvByStr[i] = new Array();
		aCvsSlsByStr[i] = new Array();
		aCvsSellByStr[i] = new Array();
		
		for(var j=0, k=0; j < aCellItmInvId.length; j++)
		{   
			var search = aCellItmInvId[j].substring(22);
			if(search == Stores[i])
			{
				aItmInvByStr[i][k] = aCellItmInvId[j];
				aItmSlsByStr[i][k] = aCellItmSlsId[j];
				k++;
			}
		}
		
		for(var j=0, k=0; j < aCellCvsInvId.length; j++)
		{   
			var search = aCellCvsInvId[j].substring(15);
			if(search == Stores[i])			
			{
				aCvsInvByStr[i][k] = aCellCvsInvId[j];
				aCvsSlsByStr[i][k] = aCellCvsSlsId[j];
				aCvsSellByStr[i][k] = aCellSellOfId[j];
				k++;
			}
		}
	}
}
//--------------------------------------------------------------------------
// go to next page 
//--------------------------------------------------------------------------
function getNextPage()
{	   
	var url = "ItemList_v2.jsp?Div=<%=sDivision%>" 
	  + "&Dpt=<%=sDepartment%>" 
	  + "&Cls=<%=sClass%>" 
	  + "&Ven=<%=sVendor%>" 
	  + "&Batch=<%=sBatch%>" 
	  + "&BWhse=<%=sBWhse%>" 
	  + "&BComment=<%=sBComment%>"
	  + "&Rrn=<%=sLastRrn%>"
	  + "&PageSize=<%=sPageSize%>"
	 ; 
	window.location.href = url;   
}
//--------------------------------------------------------------------------
//Show Item/CVS menue
//--------------------------------------------------------------------------
function showMenu(cls, ven, sty, clr, size, obj, ecomAttr, ecomQty, ecPar)
{
var pos = [0, 0];
var menuHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      + "<tr align='center'>"
if(clr == null){ menuHtml += "<td class='Grid' nowrap>" + cls  + "-" + ven + "-" + sty + "</td>"; }
else { menuHtml += "<td class='Grid' nowrap>" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>"; }
menuHtml +="<td  class='Grid2'>"
+ "<img src='CloseButton.bmp' onclick='hidedvTransfer();' alt='Close'>"
+ "</td></tr>"

+ "<tr><td class='Menu' onclick='displayTransfers(&#34;"
+ cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
+ clr + "&#34;, &#34;" + size + "&#34;)'>"
+ "<u>Display Transfers</u></td></tr>"

+ "<tr><td class='Menu' onclick='deleteTransfers(&#34;"
+ cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
+ clr + "&#34;, &#34;" + size + "&#34;)'>"
+ "<u>Delete Transfers</u></td></tr>"

+ "<tr><td class='Menu' onclick='addConsolidate(&#34;"
+ cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
+ clr + "&#34;, &#34;" + size + "&#34;)'>"
+ "<u>Consolidate Transfers</u></td></tr>"

if(ecomAttr == "Y")
{	   
   menuHtml += "<tr><td class='Menu' onclick='gotoVolusion(&#34;" + ecPar + "&#34;)'>"
     + "<u>ECOM in-stock(" + ecomQty + ")</u></td></tr>"
}

menuHtml += "<tr><td class='Menu' onclick='hidedvTransfer();'>"
+ "<u>Close Menu</u></td></tr>"


pos = clcPosition(obj);

document.all.dvTransfer.className="dvMenu";
document.all.dvTransfer.innerHTML=menuHtml
document.all.dvTransfer.style.width=150;
document.all.dvTransfer.style.pixelLeft=pos[0];
document.all.dvTransfer.style.pixelTop=pos[1];
document.all.dvTransfer.style.visibility="visible"
}

function clcPosition(obj)
{
 var pos = [0, 0];

 if (obj.offsetParent) {
   while (obj.offsetParent){
     pos[0] += obj.offsetLeft
     pos[1] += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    pos[0] += obj.x;
    pos[1] += obj.y;
 }

 pos[0] += 5;
 pos[1] += 20;
 return pos;
}

//---------------------------------------------------------
// Display list of transfers for selected item or CVS
//---------------------------------------------------------
function displayTransfers(cls, ven, sty, clr, size)
{
  var url = 'ItemTrfList.jsp?'
    + "DIVISION=" + Division
    + "&DEPARTMENT=" + Department
    + "&CLASS=" + cls
    + "&VENDOR=" + ven
    + "&STYLE=" + sty
 if(clr != "null")
 {
   url += "&COLOR=" + clr
       + "&SIZE=" + size
 }

  var WindowName = 'ItemTransferList';
  var WindowOptions =
   'width=700,height=300, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
  hidedvTransfer();
}

//-------------------------------------------------------------
// Delete list of transfers for selected item or Cls/Ven/Sty
//-------------------------------------------------------------
function deleteTransfers(cls, ven, sty, clr, size)
{
  var url = 'ItemTrfEnt.jsp?'
    + "&CLASS=" + cls
    + "&VENDOR=" + ven
    + "&STYLE=" + sty
    + "&Batch=<%=sBatch%>"

 if(clr != "null")
 {
   url += "&COLOR=" + clr
       + "&SIZE=" + size
       + "&ACTION=DLTITM";
 }
 else url += "&ACTION=DLTCVS";

 // hide the panel
 hidedvTransfer();

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
}

//-------------------------------------------------------------
// Add Consolidation transfers for selected item or Cls/Ven/Sty[/Clr/Siz]
//-------------------------------------------------------------
function addConsolidate(cls, ven, sty, clr, size)
{
  var trfHtml = null;

  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = null;
  trfSize = null;

  trfHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"
  if(clr == "null"){ trfHtml += "<td class='Grid'>Cls/Ven/Sty: " + cls  + "-" + ven + "-" + sty + "</td>"; }
  else {
         trfClr = clr;
         trfSize = size;
         trfHtml += "<td class='Grid'>Item:" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>"; }
  trfHtml +="<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidedvTransfer();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td class='Grid3' colsapn='2' nowrap>Destination store: <Select name='DestStr' class='Small'>"
         + "</Select><br>"
         + "<input name='Consolidate' type='button' class='Small' value='Consolidate' "
         + "onclick='javascript:consolidateTransfers(&#34;"
         + cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
         + clr + "&#34;, &#34;" + size + "&#34;);'>&nbsp;&nbsp;"
         + "<input name='Cancel' type='button' class='Small' value='Cancel' onclick='javascript:hidedvTransfer();'>"
         + "</td></tr>"

  trfHtml +="</table>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=trfHtml
  document.all.dvTransfer.style.width=200
  document.all.dvTransfer.style.Left=260
  document.all.dvTransfer.style.Top=getTopScreenPos() +20
  document.all.dvTransfer.style.visibility="visible"

  loadDestStr(0);

}
//-------------------------------------------------------------
// Consolidate transfers for selected item or Cls/Ven/Sty[/Clr/Siz]
//-------------------------------------------------------------
function consolidateTransfers(cls, ven, sty, clr, size)
{
  dst = document.all.DestStr.options[document.all.DestStr.selectedIndex].value
  var url = 'ItemTrfEnt.jsp?'
    + "&CLASS=" + cls
    + "&VENDOR=" + ven
    + "&STYLE=" + sty
  if(clr != "null")
  {
    url += "&COLOR=" + clr
       + "&SIZE=" + size
       + "&ACTION=CONITM";
  }
  else url += "&ACTION=CONCVS";

  url += "&ISTR=0"
     + "&DSTR=" + dst
     + "&QTY=0"
     + "&Batch=<%=sBatch%>"

 // hide the panel
 hidedvTransfer();

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
}
//-------------------------------------------------------------
//goto Volusion
//-------------------------------------------------------------
function gotoVolusion(parent)
{
	var url ="http://www.sunandski.com/p/" + parent
 var WindowName = 'ECOM';
 var WindowOptions =
'width=900,height=500, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=no';

//alert(url)
window.open(url, WindowName, WindowOptions);
hidedvTransfer();
}
//--------------------------------------------------------------------------
// Transfer CVS to another store
//--------------------------------------------------------------------------
function transferCVS(str, cls, ven, sty, clr, size, inv, obj)
{
  var trfHtml = null;

  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = clr;
  trfSize = size;
  trfFromCell = obj;
  trfBegInv = eval(inv);

  // return with error message if no inventory
  if(inv=="" ||  eval(inv) <= 0)
  {
    alert("No Items found in selected store");
    return;
  }

  trfHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"
  if(clr == null){ trfHtml += "<td class='Grid'>Cls/Ven/Sty: " + cls  + "-" + ven + "-" + sty + "</td>"; }
  else { trfHtml += "<td class='Grid'>Item:" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>"; }
  trfHtml +="<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidedvTransfer();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td class='Grid1'>Issuing store: "
         + "<input name='IssStr' type='text' class='Small' value="
         + str + " maxlength='2' size='2' readonly></td></tr>"
         + "<tr><td class='Grid1'>Destination store: <Select name='DestStr' class='Small'>"
         + "</Select></td></tr>"
         + "<tr><td class='Grid1'>Quantity: "
         + "<input name='Quantity' type='text' class='Small' value="
         + inv + "  maxlength=9 size=9>&nbsp;&nbsp;"
         + "<input name='Add' type='button' class='Small' value='Add' onclick='javascript:addCVSTransfer();'>&nbsp;&nbsp;"
         + "<input name='Cancel' type='button' class='Small' value='Cancel' onclick='javascript:hidedvTransfer();'>"
         + "</td></tr>"

  trfHtml +="</table>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=trfHtml
  document.all.dvTransfer.style.width=250
  document.all.dvTransfer.style.Left=260
  document.all.dvTransfer.style.Top=getTopScreenPos() +20
  document.all.dvTransfer.style.visibility="visible"

  if(clr == null){ document.all.Quantity.readOnly=true; }
  loadDestStr(str);
}

//--------------------------------------------------------------------------
// Transfer Items to another store
//--------------------------------------------------------------------------
function transferItem(str, cls, ven, sty, clr, size, inv, obj)
{
  var trfHtml = null;
  
  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = clr;
  trfSize = size;
  trfFromCell = obj;
  trfBegInv = eval(inv);

  SpreadQty = 0;
  
  // return with error message if no inventory
  if(inv=="" ||  eval(inv) <= 0)
  {
    alert("No Items found in selected store");
    return;
  }

  trfHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"

  trfHtml += "<td class='Grid'>Item:" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>";
  trfHtml += "<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:resetTransfer(" + str + ");hidedvTransfer();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td class='Grid1'>Issuing store: "

         + "<input name='IssStr' type='text' class='Small' value="
         + str + " maxlength='2' size='2' readonly>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
         + "Qty: " + inv + "&nbsp;&nbsp;&nbsp;"

         + "Destributing: <input name='DestrInv' type='text' class='Small' value="
         + inv + " maxlength='5' size='5' onchange='chkDestrInv(" + inv + ")'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
         + "<span id='spnBalance'></span>"
         + "&nbsp;&nbsp;&nbsp;"
         + "<span id='spnSpread'></span>"
        + "</td>"
       + "</tr>"

  trfHtml += "<tr><td>"
         + "<table class='DataTable1' cellPadding='0' cellSpacing='0'>"
         + "<tr class='DataTable2'><td class='DataTable' rowspan='2'>Destination stores:</td>"

  // Store numbers
  for(var i=0; i<Stores.length; i++)
  {
    if(Stores[i] != str && Stores[i] != "70")
    {
    	trfHtml += "<td class='DataTable'>" + Stores[i] + "</td>"
    }
  }

  trfHtml += "</tr>"
         + "<tr class='DataTable2'>"
  // store check box
  for(var i=0; i<Stores.length; i++)
  {
    if(Stores[i] != str && Stores[i] != "70")
    {
    	trfHtml += "<td class='DataTable'><input name='DestStr" + i + "' class='Small' type=checkbox value='"
             + Stores[i] + "' onclick='dspQtyBox(" + i + ")'></td>"
    }
  }

  trfHtml += "</tr>"
         + "<tr class='DataTable2'><td class='DataTable'>Quantity: "

  for(var i=0; i<Stores.length; i++)
  {
     if(Stores[i] != str  && Stores[i] != "70")
     trfHtml += "<td class='DataTable11' id='Qty" + i +"'><input name='Quantity" + i + "' type='text' class='Small1'"
              + " maxlength=9 size=3 onkeyup='showBalance(" + str + ", this)'></td>"
  }
  trfHtml += "</tr>"

  trfHtml += "</table></td></tr>"
  
  
  trfHtml  += "<tr><td><button class='Small' onClick='setAll(true, &#34;" + str + "&#34;)'>All Store</button>&nbsp;"
             + "<button onclick='checkReg(&#34;1&#34;, &#34;" + str + "&#34;)' class='Small'>Dist 1</button>&nbsp;"
             + "<button onclick='checkReg(&#34;2&#34;, &#34;" + str + "&#34;)' class='Small'>Dist 2</button>&nbsp;"
             + "<button onclick='checkReg(&#34;3&#34;, &#34;" + str + "&#34;)' class='Small'>Dist 3</button>&nbsp;"
             + "<button onclick='checkReg(&#34;99&#34;, &#34;" + str + "&#34;)' class='Small'>Dist 99</button>&nbsp;"
             + "<button onclick='checkDist(&#34;9&#34;, &#34;" + str + "&#34;)' class='Small'>Houston</button>&nbsp;"
             + "<button onclick='checkDist(&#34;20&#34;, &#34;" + str + "&#34;)' class='Small'>Dallas/FtW</button>&nbsp;"
             + "<button onclick='checkDist(&#34;35&#34;, &#34;" + str + "&#34;)' class='Small'>Ski Chalet</button>&nbsp;"
             + "<button onclick='checkDist(&#34;38&#34;, &#34;" + str + "&#34;)' class='Small'>Boston</button> &nbsp;"
             + "<button onclick='checkDist(&#34;41&#34;, &#34;" + str + "&#34;)' class='Small'>OKC</button> &nbsp;"
             + "<button onclick='checkDist(&#34;52&#34;, &#34;" + str + "&#34;)' class='Small'>Charl</button>&nbsp;"
             + "<button onclick='checkDist(&#34;53&#34;, &#34;" + str + "&#34;)' class='Small'>Nash</button> &nbsp;"             
             + "<button onclick='checkMall(&#34;&#34;, &#34;" + str + "&#34;)' class='Small'>Mall</button>&nbsp;"
             + "<button onclick='checkMall(&#34;NOT&#34;, &#34;" + str + "&#34;)' class='Small'>Non-Mall</button>&nbsp;"
             + "<button class='Small' onClick='resetTransfer(&#34;" + str + "&#34;)'>Reset</button><br><br>"
         + "</td>"
        + "</tr>"
     
  

  trfHtml += "<tr><td><input name='Add' type='button' class='Small' value='Add' onclick='addItmTransfer(" + str + ");' disabled>&nbsp;&nbsp;"
         + "<input name='Cancel' type='button' class='Small' value='Cancel' onclick='resetTransfer(" + str + "); hidedvTransfer();'>&nbsp;&nbsp;"
         + "<input name='Reset' type='button' class='Small' value='Reset' onclick='resetTransfer(" + str + ");'>&nbsp;&nbsp;"
         + "<input name='Evenly' type='button' class='Small' value='Destribute Evenly' onclick='destrEvenly(" + str + ");' disabled>"
         + "</td></tr>"

  trfHtml +="</table>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=trfHtml
  document.all.dvTransfer.style.width=250
  document.all.dvTransfer.style.Left=260
  document.all.dvTransfer.style.Top=getTopScreenPos() +20
  document.all.dvTransfer.style.visibility="visible"

}
 
//==============================================================================
//set all store or unmark
//==============================================================================
function setAll(on, str)
{	
	for(var i=0; i<Stores.length; i++)
	{
	    if(Stores[i] != str)
	    {
	    	 var inpStr = "DestStr" + i;
	    	 document.all[inpStr].checked = on; 
	    	 dspQtyBox(i)
	    }
	}	
}
//==============================================================================
//check by regions
//==============================================================================
function checkReg(dist, str)
{
	resetTransfer(str);
	
	for(var i=0; i < Stores.length; i++)
	{
	    if(Stores[i] != str)
	    {
	    	var inpStrNm = "DestStr" + i;
    		var inpobj = document.all[inpStrNm];
    		if(dist == StrReg[i])
	    	{
	    		inpobj.checked = true;
	    		dspQtyBox(i)
	    	} 
	    }  		
	}
}
//==============================================================================
//check by districts
//==============================================================================
function checkDist(dist, str)
{
	resetTransfer(str);
	
	for(var i=0; i < Stores.length; i++)
	{
	    if(Stores[i] != str)
	    {
	    	var inpStrNm = "DestStr" + i;
    		var inpobj = document.all[inpStrNm];
    		
	    	if(dist == StrDst[i])
	    	{
	    		inpobj.checked = true;
	    		dspQtyBox(i)
	    	} 
	    }  		
	}
}

//==============================================================================
//check mall
//==============================================================================
function checkMall(type, str)
{
	resetTransfer(str);
	
	for(var i=0; i < Stores.length; i++)
	{
	    if(Stores[i] != str && Stores[i] != '1')
	    {
	    	var inpStrNm = "DestStr" + i;
    		var inpobj = document.all[inpStrNm];
    		
	    	if(type == StrMall[i])
	    	{
	    		inpobj.checked = true;
	    		dspQtyBox(i)
	    	} 
	    }  		
	}
}
//-------------------------------------------------------------
// load destination Store select on transfer entry panel
//-------------------------------------------------------------
function  loadDestStr(str)
{
  for(var i=0, j=0; i < Stores.length; i++)
  {
    if (Stores[i] != str && Stores[i] != "70")
    {
      document.all.DestStr.options[j++] = new Option(Stores[i], Stores[i]);
    }
  }
}
//-------------------------------------------------------------
// check entered destributing value
//-------------------------------------------------------------
function chkDestrInv(inv)
{
  var dst = document.all.DestrInv.value;
  if(isNaN(dst) || dst < 1 || dst > inv || dst == "" || dst.substring(0, 3) == " ")
  {
     document.all.DestrInv.value=inv;
  }
}
//-------------------------------------------------------------
// display destributed quantity
//-------------------------------------------------------------
function showBalance(str, box)
{
  var sum=0;
  var inpbox = null;
  var chkbox = null;
  var spnHTML = null

  var inv = document.all.DestrInv.value;
  // return for empty box
  //if(box.value == "" || box.value.substring(0,1) == " ")  { return; }
  if(!isNaN(box.value))
  {
    for(var i=0; i < Stores.length; i++)
    {
      if(Stores[i] != str && Stores[i] != "70")
      {
        chkbox = "DestStr" + i;
        if(document.all[chkbox].checked)
        {
           inpbox = "Quantity" + i;
           if(!document.all[inpbox].value == "" && !document.all[inpbox].value.substring(0,1) == " ")
           {
             sum += eval(document.all[inpbox].value);
           }
        }
      }
    }
    //check if value is not grater than inventory
    spnHTML = "Destributed: " + sum;
    if (inv < sum)
    {
      spnHTML += "<font color=red> ==> is greater than destributing quantity!!!</font>";
      document.all.Add.disabled=true;
    }
    else { document.all.Add.disabled=false }
    document.all.spnBalance.innerHTML=spnHTML;
  }
  else
  {
    document.all.spnBalance.innerHTML= "&#34;" + box.value  + "&#34;"
      + "<font color=red> is not a valid number!!!</font>";
      document.all.Add.disabled=true;
  }

}

//-------------------------------------------------------------
// display/hide Quantity input fields for checked item
//-------------------------------------------------------------
function dspQtyBox(strIdx)
{
   var cell = "Qty" + strIdx;
   var inpbox = "Quantity" + strIdx;
   var chkbox = "DestStr" + strIdx;

   if(document.all[chkbox].checked)
   {
     document.all[cell].style.visibility = "visible";
     document.all.Evenly.disabled=false;
   }
   else
   {
     document.all[cell].style.visibility = "hidden";
     document.all[inpbox].value = "";
     document.all.spnBalance.innerHTML="";
   }
   
   var spread = document.getElementById("spnSpread");
   SpreadQty = 0;
   if(spread != null)
   {
	   for(var i=0; i < Stores.length; i++)
	   {
		   str = document.getElementsByName("DestStr" + i)[0];
		   if(str != null && str.checked)
		   {
			   SpreadQty++;
			   spread.innerHTML = " Stores Selected: " + SpreadQty;
		   }
	   }
   }
   
}

//-------------------------------------------------------------
// reset Transfer pannel
//-------------------------------------------------------------
function resetTransfer(str)
{
  var chkbox = null;
  var inpbox = null;
  var cell = null;
  for(var i=0; i < Stores.length; i++)
  {
    if (Stores[i] != str && Stores[i] != "70")
    {
      chkbox = "DestStr" + i;
      document.all[chkbox].checked = false;
      inpbox = "Quantity" + i;
      document.all[inpbox].value = "";
      cell = "Qty" + i;
      document.all[cell].style.visibility = "hidden";
    }
  }
  document.all.Add.disabled=true;
  document.all.Evenly.disabled=true;
  document.all.spnBalance.innerHTML="";
  
  SpreadQty = 0;
  var spread = document.getElementById("spnSpread");
  if(spread != null)
  {
    spread.innerHTML = "";
  }
}


//-------------------------------------------------------------
// Add Item Transfers
//-------------------------------------------------------------
function destrEvenly(str)
{
  var inv = document.all.DestrInv.value;
  var qty = 0;
  var rmd = inv;
  var max=0;
  var boxes = new Array(Stores.length);
  var inpbox = null;
  var chkbox = null;
  var spnHTML = null;

  // get nuber of checked stores
  for(var i=0; i < Stores.length; i++)
  {
    if(Stores[i] != str &&  Stores[i] != "70")
    {
      chkbox = "DestStr" + i;
      if(document.all[chkbox].checked)
      {
         boxes[max]=document.all["Quantity" + i];
         boxes[max].value = 0;
         max++;
      }
    }
  }

  // destribute items
  if(max > 0)
  {
    qty = getQuantity(inv, max)
    var left = 0;
    if (qty * max < inv) left = inv - qty * max;
    var bx = 0;
    var current = 0;

    do
    {
      if(bx == max) { bx = 0; }

      if (rmd >= qty)
      {
        current = eval(boxes[bx].value)
        // destribute remainder
        if (left > 0)
        {
          current++;
          left = left - 1
          rmd = rmd - 1
        }
        boxes[bx].value = current + qty;
        rmd = rmd - qty;
      }
      if (rmd < qty && qty > 1)  { qty = 1; }
      bx++;
    } while(rmd > 0)
  }
  document.all.Add.disabled=false;
}

//--------------------------------------------------------------------------------
// calculate number of items per selected store for "Destribute Evenly" button
//--------------------------------------------------------------------------------
function getQuantity(inv, boxes)
{
  var qty = inv / boxes
  if (qty < 1) qty = 1;
  else if(Math.round(qty) * boxes > inv)  qty = Math.round(qty) - 1;
  else { qty = Math.round(qty) }
  return qty;
}
//-------------------------------------------------------------
// Add Item Transfers
//-------------------------------------------------------------
function addItmTransfer(str)
{
 var url = null;
 var ist = document.all.IssStr.value;
 var qty = new Array(Stores.length);
 var dst = new Array(Stores.length);
 var chkbox = null;
 var inpbox = null;
 var j = -1;

 for(var i=0; i < Stores.length; i++)
 {
    chkbox = "DestStr" + i;
    inpbox = "Quantity" + i;
    if(Stores[i] != str && document.all[chkbox] != null
    	&& document.all[chkbox].checked && document.all[inpbox].value > 0)
    {
      j++;
      qty[j] = document.all[inpbox].value;
      dst[j] = Stores[i];
    }
  }


 if (j < 0 ) { alert("There are no transfered items!!!") }
 else {
   url = "ItemTrfEnt.jsp?"
    + "CLASS=" + trfCls + "&VENDOR=" + trfVen + "&STYLE=" + trfSty + "&COLOR=" + trfClr
    + "&SIZE=" + trfSize
    + "&ISTR=" + ist
    + "&Batch=<%=sBatch%>";

   for(var i=0; i <= j; i++)
   {
     url += "&DSTRARR=" + dst[i]
      + "&QTYARR=" + qty[i];
   }

   url += "&ACTION=ADDITM";

   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
   // hide the panel
   resetTransfer(str);
   hidedvTransfer();
  }
}

//-------------------------------------------------------------
// Add CVS Transfer
//-------------------------------------------------------------
function addCVSTransfer()
{
 var ist = document.all.IssStr.value;
 var dst = document.all.DestStr.options[document.all.DestStr.selectedIndex].value;
 var qty = document.all.Quantity.value;

 trfToStr = dst;
 trfEndInv = eval(trfBegInv) - eval(qty);
 trfQty = eval(qty);

 var url = "ItemTrfEnt.jsp?"
         + "CLASS=" + trfCls
         + "&VENDOR=" + trfVen
         + "&STYLE=" + trfSty
 if(trfClr != null)
 {
   url += "&COLOR=" + trfClr
       + "&SIZE=" + trfSize
 }

 url += "&ISTR=" + ist
     + "&DSTR=" + dst
     + "&QTY=" + qty
     + "&Batch=<%=sBatch%>"
     + "&ACTION=ADD";

 // hide the panel
 hidedvTransfer();

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
}

//------------------------------------------------------------------------
// drag data
//------------------------------------------------------------------------
function dragData(str, cls, ven, sty, clr, size, obj)
{
  var inv = 0;

  if(isNum(escape(obj.innerHTML))) { inv = eval(escape(obj.innerHTML));}
  // return with error message if no inventory
  if(eval(inv) <= 0)
  {
    alert("No Items found in selected store");
    return;
  }
  else if(TrfWhse && str != 1 && str != 70)
  {
    alert("Selected store is not warehouse.\nYou must select store 1 or 70 for this batch.");
    return;
  }
  else if(!TrfWhse && (str == 1 || str == 70))
  {
    alert("Selected Store is warehouse.\n You should not select store 1 or 70 for this batch.");
    return;
  }

  if(!isCellAvailable(obj.id))
  {
    alert("Operation is Unavailable");
    return;
  }

  draged=true;
  trfFromCell = obj;
  trfFromStr = str;
  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = clr;
  trfSize = size;
  trfBegInv = eval(inv);
  trfQty = eval(inv);
}

//------------------------------------------------------------------------
// show  draged data in small panel
//------------------------------------------------------------------------
function showDragedCell()
{
  var dragHtml = "From: " + trfFromStr
      + " Qty: " + trfBegInv + " To: <span id=Dest></span>"
      + "&nbsp;<a href='javascript: releaseData()'>close</a>"
      + "<br><span id=Permission style='color:red'></span>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=dragHtml
  document.all.dvTransfer.style.width=200;
  document.all.dvTransfer.style.Left=260;
  document.all.dvTransfer.style.Top=getTopScreenPos() +20;
  document.all.dvTransfer.style.visibility="visible"
}

//------------------------------------------------------------------------
// drop data
//------------------------------------------------------------------------
function dropData(str, cls, ven, sty, clr, size, inv, obj)
{
  trfToStr=str;
  trfEndInv = 0;

  if (str == "70" )	 
  {
	  releaseData();
	  alert("You cannot transfer item to store 70")	  
  }
  else if (str != trfFromStr && cls==trfCls && ven==trfVen && sty==trfSty && clr==trfClr && size==trfSize)
  {
    var url = "ItemTrfEnt.jsp?"
           + "CLASS=" + trfCls
           + "&VENDOR=" + trfVen
           + "&STYLE=" + trfSty
    if(clr != null)  { url += "&COLOR=" + trfClr + "&SIZE=" + trfSize }

    url += "&ISTR=" + trfFromStr
        + "&DSTR=" + str
        + "&QTY=" + trfQty
        + "&Batch=<%=sBatch%>"
        + "&ACTION=ADD";

    // hide the panel
    hidedvTransfer();

    //alert(url);
    //window.location.href = url;
    window.frame1.location = url;
    draged=false;
  }
  else if(str == trfFromStr && cls==trfCls && ven==trfVen && sty==trfSty && clr==trfClr && size==trfSize)
  {
     releaseData();
     if(clr == null)
     {
       transferCVS(trfFromStr, trfCls, trfVen, trfSty, trfClr, trfSize, trfBegInv, trfFromCell);
     }
     else
     {
       transferItem(trfFromStr, trfCls, trfVen, trfSty, trfClr, trfSize, trfBegInv, trfFromCell);
     }
  }
  else { releaseData(); }
}
//-------------------------------------------------------------
// Confirm entery of new Transfer
//-------------------------------------------------------------
function cnfAddTrf(NumOfCell, Cell, CellIO, CellSts, CellInv)
{
  //alert(NumOfCell + "\nIO: " + CellIO + "\nInv: "+ CellInv)
  chgDestStrCellForAllItems(NumOfCell, Cell, CellIO, CellSts, CellInv);
}

//-------------------------------------------------------------
// Confirm entery of new consolidate Transfer
//-------------------------------------------------------------
function cnfConTrf(NumOfCell, Cell, CellIO, CellSts, CellInv, Error)
{
  //alert(NumOfCell + "\n" + Cell + "\n" + CellIO + "\n" + CellSts + "\n"+ CellInv)
  var errmsg = "There is at least one transfer already exist for selected item(s)."
       + "\nPlease, delete all existing transfers before consolidation."
  if (Error == "1") alert(errmsg);
  else chgDestStrCellForAllItems(NumOfCell, Cell, CellIO, CellSts, CellInv);
}
//------------------------------------------------------------------------
// lock all color/size for this style
//------------------------------------------------------------------------
function  chgDestStrCellForAllItems(NumOfCell, Cell, CellIO, CellSts, CellInv)
{
  var csCell = null, csCellId = null, frmInv=null, toInv=null;

  for(var i=0; i < NumOfCell; i++)
  {
     if (CellIO[i]=="" && CellSts[i]=="" && Cell[i].substring(0,1)=="i")
          { document.all[Cell[i]].style.backgroundColor="lightgrey"; }
     if (CellIO[i]=="" && CellSts[i]=="" && Cell[i].substring(0,1)=="c")
          { document.all[Cell[i]].style.backgroundColor="seashell"; }
     else if (CellIO[i]=="I" && CellSts[i]=="O") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[0]%>)"; }
     else if (CellIO[i]=="D" && CellSts[i]=="O"){ document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[1]%>)";}
     else if (CellIO[i]=="I" && CellSts[i]=="A") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[2]%>)"; }
     else if (CellIO[i]=="D" && CellSts[i]=="A") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[3]%>)"; }
     else if (CellIO[i]=="I" && CellSts[i]=="I") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[4]%>)"; }
     else if (CellIO[i]=="D" && CellSts[i]=="I") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[5]%>)"; }

    // if(CellInv[i]!="") alert(CellInv[i])
    document.all[Cell[i]].innerHTML=CellInv[i];
    if (CellIO[i]=="D" || CellSts[i] != "O" && CellSts[i]!="")
    {
      document.all[Cell[i]].style.cursor="text";
      disabledCell[daCellMax++] = Cell[i];
    }
    else  document.all[Cell[i]].style.cursor="hand";


    setCellAvailable(Cell[i]);
  }

}


//------------------------------------------------------------------------
// realese drag data
//------------------------------------------------------------------------
function releaseData()
{
  hidedvTransfer();
  draged=false;
}
//------------------------------------------------------------------------
// close transfer entry panel
//------------------------------------------------------------------------
function hidedvTransfer(){
    document.all.dvTransfer.style.visibility="hidden"
}

//------------------------------------------------------------------------
// check if tested value is numeric
function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}


function colapse()
{
  var style = document.styleSheets[0].rules[7].style.display;
  if(style != "none")
  {
    document.styleSheets[0].rules[7].style.display="none";
  }
  else
  {
    document.styleSheets[0].rules[7].style.display="block";
  }
}

//------------------------------------------------------------------------
// check if operation on cell allowed
//------------------------------------------------------------------------

function isCellAvailable(objId)
{
  var avail = true;
  for(var i=0; i < daCellMax; i++)
  {
    if(objId==disabledCell[i])
    {
      avail=false;
      break;
    }
  }
  return avail;
}

//------------------------------------------------------------------------
// set Cell available again
//------------------------------------------------------------------------
function setCellAvailable(objId)
{
  for(var i=0; i < daCellMax; i++)
  {
    if(objId==disabledCell[i])
    {
      disabledCell[i] = "";
    }
  }
}



// -------------------------------------------------------------------
//                       Move Boxes
//--------------------------------------------------------------------
var dragapproved=false
var z,x,y
//=====================================================================
// Move
//=====================================================================
function move()
{
	if (event.button==1&&dragapproved)
	{		
		var l = eval(temp1.replace("px", "")) + eval(event.clientX) - x;	
		var t = eval(temp2.replace("px", "")) + eval(event.clientY)-y;
		z.style.Left=l; //temp1+event.clientX-x
		z.style.Top=t; //temp2+event.clientY-y
		
		return false
	}
}


//=====================================================================
// drag
//=====================================================================
function drags()
{
  if (!document.all) return;
  var obj = event.srcElement

  if (event.srcElement.className=="Grid")
  {
    while (obj.offsetParent)
    {
      if (obj.id=="dvTransfer")
      {
        z=obj;
        break;
      }
      obj = obj.offsetParent;
    }
    dragapproved=true;
    temp1=z.style.Left
    temp2=z.style.Top
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
  }

  // move table cell data
  if ((event.srcElement.className=="StrInv"
    || event.srcElement.className=="StrInv1") && draged==true)
  {
    z=obj;
    dragapproved=true;
    temp1=z.style.Left
    temp2=z.style.Top
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
    showDragedCell();
  }
}


/* show store number that cursor is moving over to help
   user drop in right box */
function chgDragBox(str, cls, ven, sty, clr, size, inv, obj)
{
  document.all.Dest.innerHTML=str;
  //check if items can be droped in this shell
  if (cls==trfCls && ven==trfVen && sty==trfSty && clr==trfClr && size==trfSize)
        document.all.Permission.innerHTML="(!) OK (!)";
  else  document.all.Permission.innerHTML="(!) Do not drop (!)";
}

document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------

// -------------------------------------------------------
// redisplay store headings with selected freaquency
// -------------------------------------------------------
function redispStrLine(idx)
{
  var stlId = null;

  for(var i=0, cnt=1 ; i < NumOfCVS; i++, cnt++)
  {
    stlId = "STRHDR"+i;
    if (cnt == idx)
    {
      document.all[stlId].style.display="block";
      cnt=0;
    }
    else document.all[stlId].style.display="none";
  }
}
//==============================================================================
// get PO List
//==============================================================================
function getPOList(cls, ven, sty, clr, siz)
{
   var url = "ItemPOList.jsp?Str=1"
     + "&Cls=" + cls
     + "&Ven=" + ven
     + "&Sty=" + sty
     + "&Clr=" + clr
     + "&Siz=" + siz

   //alert(url)
   //window.location.href = url
   window.frame1.location.href = url
}
//==============================================================================
// show PO List
//==============================================================================
function showPOList(ponum, antDt, poqty)
{
  var hdr = "PO List";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popPOList(ponum, antDt, poqty);

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.Left= getLeftScreenPos() + 150;
   document.all.dvItem.style.Top= getTopScreenPos()  + 100;
   document.all.dvItem.style.visibility = "visible";
}

//--------------------------------------------------------
// populate Column Panel for update
//--------------------------------------------------------
function popPOList(ponum, antDt, poqty)
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='3' cellSpacing='0'>"

  panel += "<tr class='DataTable3'>"
          + "<th nowrap>PO Number</th>"
          + "<th nowrap>Anticipation<br>Delivery Date</th>"
          + "<th>Qty</th>"
        + "</tr>"

  for(var i=0; i < ponum.length; i++)
  {
     panel += "<tr class='DataTable4'>"
           + "<td nowrap>" + ponum[i] + "</td>"
           + "<td nowrap>" + antDt[i] + "</td>"
           + "<td nowrap>" + poqty[i] + "</td>"
         + "</tr>"
  }

  panel += "<tr class='DataTable4'><td class='Prompt1' colspan=3>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//show list of store 
//==============================================================================
function strSel()
{
	var hdr = "Select Store Columns";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>"

	html += popStrSel();

	html += "</td></tr></table>"
	
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.Left= getLeftScreenPos() + 150;
	document.all.dvItem.style.Top= getTopScreenPos()  + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate store list selection
//==============================================================================
function popStrSel()
{
	var panel = "<table border=1 width='100%' cellPadding='3' cellSpacing='0'>"

	panel += "<tr class='DataTable3'>"
      + "<th nowrap>Stores</th>"
     + "</tr>"

	panel += "<tr class='DataTable4'><td nowrap>"

	for(var i=0; i < Stores.length; i++)
	{
  		panel += "&nbsp;&nbsp;<input name='strsel' type='checkbox' value='" + Stores[i] + "'>" + Stores[i]
  		if(i > 0 && i%15==0){ panel += "<br>"; }
	}
	panel += "&nbsp;&nbsp;<a href='javascript: setAllStr(true)'>All</a>"
	panel += "&nbsp;&nbsp;<a href='javascript: setAllStr(false)'>Reset</a>"
	panel += "</td></tr>"

	panel += "<tr class='DataTable4'><td class='Prompt1' colspan=3>"
	 + "<button onClick='showSelStr();' class='Small'>Select</button>&nbsp;"
     + "<button onClick='hidePanel();' class='Small'>Close</button>" 
     + "</td></tr>"

	panel += "</table>";

	return panel;
}
//==============================================================================
//show selected store columns 
//==============================================================================
function showSelStr()
{
	var str = document.all.strsel;
	aStrCol = new Array();
	var itot = 0;
	for(var i=0; i < str.length; i++)
	{		
		aStrCol[i] = str[i].checked;
		
		
		var shl2 = document.getElementById("StrHdrL2" + i);
		var shInv = document.getElementById("StrInv" + i);
		var shSls = document.getElementById("StrSls" + i);
		  
		var aItmInv = new Array();
		
		
		if(aStrCol[i])
		{ 
			itot++;
			shl2.style.display = "block";	
			shInv.style.display = "block";
			shSls.style.display = "block";
		 
			for(var j=0; j < NumOfCVS; j++)
			{	
				var shl3nm = "StrHdrL3" + j + "_" + i;
				var shl3 = document.all[shl3nm];				
				shl3.style.display = "block";			 
			}
			
			for(var j=0; j < aItmInv.length; j++)
			{
				document.getElementById(aItmInv[j] + j).style.display = "block";	
			}
			
			for(var j=0; j < aItmInvByStr[i].length; j++)
			{
				var celnm = aItmInvByStr[i][j];
				var celli = document.getElementById(celnm);
				var celnm = aItmSlsByStr[i][j];
				var cells = document.getElementById(celnm);
				celli.style.display = "block";
				cells.style.display = "block";
			}
			for(var j=0; j < aCvsInvByStr[i].length; j++)
			{
				var celli = document.getElementById(aCvsInvByStr[i][j]);
				celli.style.display = "block";
				var cells = document.getElementById(aCvsSlsByStr[i][j]);
				cells.style.display = "block";
				var cellf = document.getElementById(aCvsSellByStr[i][j]);				
				cellf.style.display = "block";				
			}
		}
		else
		{
			shl2.style.display = "none";
			shInv.style.display = "none";
			shSls.style.display = "none";

			for(var j=0; j < NumOfCVS; j++)
			{	
				var shl3nm = "StrHdrL3" + j + "_" + i;
				var shl3 = document.all[shl3nm];				
				shl3.style.display = "none";			 
			}
			
			for(var j=0; j < aItmInv.length; j++)
			{
				document.getElementById(aItmInv[j] + j).style.display = "none";	
			}
			
			for(var j=0; j < aItmInvByStr[i].length; j++)
			{
				var celnm = aItmInvByStr[i][j];
				var celli = document.getElementById(celnm);
				celli.style.display = "none";
				
				var celnm = aItmSlsByStr[i][j];
				var cells = document.getElementById(celnm);				
				cells.style.display = "none";
			}
			for(var j=0; j < aCvsInvByStr[i].length; j++)
			{
				var celli = document.getElementById(aCvsInvByStr[i][j]);
				celli.style.display = "none";
				var cells = document.getElementById(aCvsSlsByStr[i][j]);				
				cells.style.display = "none";
				var cellf = document.getElementById(aCvsSellByStr[i][j]);				
				cellf.style.display = "none";
			}
		}
	}
	document.all.StrHdrL1.colSpan = itot * 2;
	hidePanel();
}
//==============================================================================
//set store selection on/off 
//==============================================================================
function setAllStr(chk)
{
	var str = document.all.strsel;
	for(var i=0; i < str.length; i++)
	{
		str[i].checked = chk;
	}
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
<script>StartTime = Date.now();</script>
<!-------------------------------------------------------------------->
<iframe id="frame1" src=""  height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
  <div id="dvTransfer"></div>
<!-------------------------------------------------------------------->
  <div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Transfer Request Selection
      <br>Div: <%=sDivision%> &nbsp;&nbsp
          Dpt: <%=sDepartment%> &nbsp;&nbsp
          Class: <%=sClass%> &nbsp;&nbsp
      <br>Batch: <%=sBComment%><br><%if(sBWhse.equals("W")){%>(From Warehouse - Located Stock Only)<%} else {%>(From Stores)<%}%>
      </b>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP">


<!-- ------------ Legend -------------- -->
  <table border=0 cellPadding="0" cellSpacing="0">
   <tr>
     <td>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
       <tr><th class="DataTable">Status</th><th class="DataTable">From</th><th class="DataTable">&nbsp;&nbsp;To&nbsp;&nbsp;</th></tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">Pending</td>
          <td style="background: rgb(<%=sColor[0]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[1]%>); border-top: darkred solid 1px">&nbsp;</td>
       </tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">Approved</td>
          <td style="background: rgb(<%=sColor[2]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[3]%>); border-top: darkred solid 1px">&nbsp;</td>
        </tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">In Progress</td>
          <td style="background: rgb(<%=sColor[4]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[5]%>); border-top: darkred solid 1px">&nbsp;</td>
        </tr>

      </table >
    </td>
    <td style="font-size:10px;vertical-align: bottom;"> &nbsp; * - selloff percentage calculation does not include negative inventory.</td>
   </tr>
  </table >
   <!-- ----Aquamarine-------- End Legend -------------- -->

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ItemSel_v2.jsp">
         <font color="red" size="-1">Select Items</font></a>&#62;<font size="-1">
      This Page.
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%if(!bEof){%><a href="javascript: getNextPage()">Next Page</a><%}%>

      <!-- Change number of visible store number lines -->
      <!--  Show store numbers on every    
      <a href="javascript: redispStrLine(1)">1</a>,&nbsp;
      <a href="javascript: redispStrLine(2)">2</a>,&nbsp;
      <a href="javascript: redispStrLine(3)">3</a>,&nbsp;
      <a href="javascript: redispStrLine(4)">4</a>,&nbsp;
      <a href="javascript: redispStrLine(5)">5</a>&nbsp;
      style 
      -->
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: strSel()">Store Selection</a>,&nbsp;
      </font>
      
      
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2" colspan="2">Item Number<br>          
              <a href="javascript:colapse();">Fold/Unfold</a></th>
          <th class="DataTable"  rowspan="3">B<br>A<br>S<br>?</th>    
          <th class="DataTable" rowspan="2" colspan="2">Chain</th>
          <th class="DataTable" id="StrHdrL1" colspan="<%=iNumOfStr * 2%>">Stores</th>
          <th class="DataTable" rowspan="2" colspan="2">Item Number<br>          
              <a href="javascript:colapse();">Fold/Unfold</a>
          </th>
          
        </tr>

        <tr>
          <%for(int i=0; i<iNumOfStr; i++){%>
             <%if(sStr[i].equals("99")){%>
               <th class="DataTable" id="StrHdrL2" ><%=sStr[i]%></th>
             <%}
             else {%>
               <th class="DataTable" id="StrHdrL2<%=i%>" colspan="2"><%=sStr[i]%></th>
             <%}%>
          <%}%>
        </tr>

        <tr>
          <th class="DataTable">Class-Ven-Sty</th>
          <th class="DataTable">Clr-Size</th>

          <th class="DataTable">Inv</th>
          <th class="DataTable">Sls</th>

          <%for(int i=0; i<iNumOfStr; i++){%>
             <%if(sStr[i].equals("99")){%>
                <th class="DataTable" id="StrInv<%=i%>">Inv</th>
             <%}
               else {%>
                <th class="DataTable" id="StrInv<%=i%>">Inv</th>
                <th class="DataTable" id="StrSls<%=i%>">Sls</th>
             <%}%>
          <%}%>

          <th class="DataTable">Clr-Size</th>
          <th class="DataTable">Class-Ven-Sty</th>
        </tr>

<!------------------------------- Detail Data --------------------------------->	  
  <%for(int i=0; i < iNumOfCVS; i++) {
		itemLst.setItemLst();
  		itemLst.setNumOfItm();
      	int iNumOfItm = itemLst.getNumOfItm();
  %>
  <!-------------------------------Item Detail ---------------------------------->
  <%for(int j=0; j < iNumOfItm; j++) {
	 	itemLst.setItemDtl(j);
  		String sCls = itemLst.getCls();
  		String sVen = itemLst.getVen();
  		String sSty = itemLst.getSty();
  		String sClr = itemLst.getClr();
  		String sSiz = itemLst.getSiz();
    
  		String [] sInv = itemLst.getInv();
  		String [] sSlsQty = itemLst.getSlsQty();
  		String [] sIssQty = itemLst.getIssQty();
  		String [] sDstQty = itemLst.getDstQty();
  		String [] sSts = itemLst.getSts();
  		String sChnInv = itemLst.getChnInv();
    	String sChnSls = itemLst.getChnSls();
    	String [] sCellId = itemLst.getCellId();
    	String sBsrLvl = itemLst.getBsrLvl();
    	
    	//String sBsrClr = "";
    	//if(sBsrLvl.equals("N")){sBsrClr = "style=\"background: pink; \""; }
  %>
    <tr  class="DataTable">
        <td class="DataTable1" nowrap
            onclick="showMenu('<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', this, ' ', ' ' )">
         <%if(j==0){%><%=sCls + "-" + sVen + "-" + sSty%><%} else {%>&nbsp;<%}%></td>		
        <td class="DataTable1" nowrap><a href="javascript: getPOList('<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>')"><%=sClr + "-" + sSiz%></a></td>
        <td class="DataTable9" nowrap>&nbsp;<%=sBsrLvl%></td>
        <td class="DataTable8" nowrap>&nbsp;<%=sChnInv%></td>
        <td class="DataTable9" nowrap>&nbsp;<%=sChnSls%></td>
        <!-- store inv & dtl on item Level -->

        <%for(int k=0; k < iNumOfStr; k++){
        	String sCellClr = "";        	
        	if(!sIssQty[k].trim().equals("") && sSts[k].equals("O")) { sCellClr = "style=\"background: rgb(" + sColor[0]+ ");\" "; }
        	else if(!sDstQty[k].trim().equals("") && sSts[k].equals("O")) { sCellClr = "style=\"background: rgb(" + sColor[1]+ ");\" "; }
        	else if(!sIssQty[k].trim().equals("") && sSts[k].equals("A")) { sCellClr = "style=\"background: rgb(" + sColor[2]+ ");\" "; }
        	else if(!sDstQty[k].trim().equals("") && sSts[k].equals("A")) { sCellClr = "style=\"background: rgb(" + sColor[3]+ ");\" "; }
        	else if(!sIssQty[k].trim().equals("") && sSts[k].equals("I")) { sCellClr = "style=\"background: rgb(" + sColor[4]+ ");\" "; }
        	else if(!sDstQty[k].trim().equals("") && sSts[k].equals("I")) { sCellClr = "style=\"background: rgb(" + sColor[5]+ ");\" "; }
        	 
        %>
            <!-- ----------------- -->
            <script>
              aCellItmInvId[aCellItmInvId.length] = "i<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>";
              aCellItmSlsId[aCellItmSlsId.length] = "isls<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>";
            </script>   
               
            <td class="StrInv" <%=sCellClr%> nowrap
                id="i<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>"
                onmousedown="dragData('<%=sStr[k]%>','<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', this)"
                onmouseup="dropData('<%=sStr[k]%>','<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sInv[k]%>', this)"
                onmouseover="if(draged==true){chgDragBox('<%=sStr[k]%>','<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sInv[k]%>', this)}"
                ><%=sInv[k]%></td>                  
            <td class="DataTable10"  id="isls<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>" onmouseup="releaseData()">&nbsp;<%=sSlsQty[k]%></td>                        
        <%}%>

        <td class="DataTable1" nowrap><%=sClr + "-" + sSiz%></td>
        <td class="DataTable1" nowrap
            onclick="showMenu('<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', this, ' ', ' ')">
            <%if(j==0){%><%=sCls + "-" + sVen + "-" + sSty%><%} else {%>&nbsp;<%}%></td>
    </tr>
  <%}%>
<!-------------------------------End Item Detail ------------------------------>
  <!------------------------------- CVS Detail --------------------------------->
    <%
    itemLst.setCVS();
    String sCls = itemLst.getCls();
	String sVen = itemLst.getVen();
	String sSty = itemLst.getSty();
    String sDesc = itemLst.getDesc();    
    String sRet = itemLst.getRet();
    String sOrgRet = itemLst.getOrgRet();
    String sSlsUnt = itemLst.getSlsUnt();
    String sCost = itemLst.getCost();
    String sMdDate = itemLst.getMdDate();
    String sFrtRct = itemLst.getFrtRct();
    String sLstRct = itemLst.getLstRct();
    String sVenSty = itemLst.getVenSty();
    String [] sInv = itemLst.getInv();
	String [] sSlsQty = itemLst.getSlsQty();
	String [] sIssQty = itemLst.getIssQty();
	String [] sDstQty = itemLst.getDstQty();
	String [] sSts = itemLst.getSts();
	String [] sSellOff = itemLst.getSellOff();	
	String sTotSellOff = itemLst.getTotSellOff();
	String sChnInv = itemLst.getChnInv();
	String sChnSls = itemLst.getChnSls();   
	String [] sCellId = itemLst.getCellId();
	String sLstSlsDt = itemLst.getLstSlsDt();
	String sEcomAttr = itemLst.getEcomAttr();
	String sEcomQty = itemLst.getEcomQty();
	String sEcomPar = itemLst.getEcomPar();
    %>
    <tr class="DataTable1">
      <td class="DataTable5" nowrap rowspan="2" colspan="3"
          onclick="showMenu('<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', null, null, this, '<%=sEcomAttr%>', '<%=sEcomQty%>', '<%=sEcomPar%>')">
        <span style="font-size:11px; font-weight:bolder"><%=sDesc%></span>
        <%if(sEcomAttr.equals("Y")){%>
        	<a href="javascript: gotoVolusion('<%=sEcomPar%>')">ECOM(<%=sEcomQty%>)</a>
        <%}%>
        <br>
        OR: <%=sOrgRet%>&nbsp;&nbsp;C: <%=sCost%>&nbsp;&nbsp;<b>R: <span style="font-size: 14px;"><%=sRet%></span></b><br>
        VST: <%=sVenSty%><br>
        FR: <%=sFrtRct%>&nbsp;&nbsp;LR: <%=sLstRct%><br>
        LS: <%=sLstSlsDt%>&nbsp;&nbsp;LM: <%=sMdDate%>
      </td>

      <td class="DataTable8" nowrap>&nbsp;<%=sChnInv%></td>
      <td class="DataTable9" nowrap>&nbsp;<%=sChnSls%></td>

      <!-- store inv & dtl on CVS Level -->
      <%for(int j=0; j < iNumOfStr; j++){
    	String sCellClr = "";        	
      	if(!sIssQty[j].trim().equals("") && sSts[j].equals("O")) { sCellClr = "style=\"background: rgb(" + sColor[0]+ ");\" "; }
      	else if(!sDstQty[j].trim().equals("") && sSts[j].equals("O")) { sCellClr = "style=\"background: rgb(" + sColor[1]+ ");\" "; }
      	else if(!sIssQty[j].trim().equals("") && sSts[j].equals("A")) { sCellClr = "style=\"background: rgb(" + sColor[2]+ ");\" "; }
      	else if(!sDstQty[j].trim().equals("") && sSts[j].equals("A")) { sCellClr = "style=\"background: rgb(" + sColor[3]+ ");\" "; }
      	else if(!sIssQty[j].trim().equals("") && sSts[j].equals("I")) { sCellClr = "style=\"background: rgb(" + sColor[4]+ ");\" "; }
      	else if(!sDstQty[j].trim().equals("") && sSts[j].equals("I")) { sCellClr = "style=\"background: rgb(" + sColor[5]+ ");\" "; }
      	 
      %>
      <!-- ----------------- -->
        
           <td class="StrInv"
           id="c<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" <%=sCellClr%>
           onmousedown="dragData('<%=sStr[j]%>','<%=sCls%>', '<%=sVen%>', '<%=sSty%>', null, '<%=iNumOfItm%>', this)"
           onmouseup="dropData('<%=sStr[j]%>','<%=sCls%>', '<%=sVen%>', '<%=sSty%>', null, '<%=iNumOfItm%>', '<%=sInv[j]%>', this)"
           onmouseover="if(draged==true){chgDragBox('<%=sStr[j]%>','<%=sCls%>', '<%=sVen%>', '<%=sSty%>', null, <%=iNumOfItm%>, '<%=sInv[j]%>', this)}">
           <%=sInv[j]%></td>
          <td class="DataTable" id="csls<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" onmouseup="releaseData()">&nbsp;<%=sSlsQty[j]%></td>
          <script>
              aCellCvsInvId[aCellCvsInvId.length] = "c<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
              aCellCvsSlsId[aCellCvsSlsId.length] = "csls<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
      	  </script>         
      <%}%>

      <td class="DataTable5" nowrap rowspan="2" colspan="2"
          onclick="showMenu('<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', null, null, this, ' ', ' ')">
        <span style="font-size:11px; font-weight:bolder"><%=sDesc%></span><br>
        C: <%=sCost%>&nbsp;&nbsp;R: <%=sRet%>&nbsp;&nbsp;OR: <%=sOrgRet%><br>
        M: <%=sMdDate%>&nbsp;&nbsp;VST: <%=sVenSty%><br>
        FR: <%=sFrtRct%>&nbsp;&nbsp;LR: <%=sLstRct%><br>
        LS: <%=sLstSlsDt%>&nbsp;&nbsp;
      </td>
    </tr>

    <tr class="DataTable1">
      <td class="DataTable7" colspan="2">&nbsp;<%=sTotSellOff%></td>
      <%for(int j=0; j < iNumOfStr; j++){%>
        <%if(!sStr[j].equals("99")){%>
           <td class="DataTable4" id="csell<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" colspan="2" onmouseup="releaseData()">&nbsp;<%=sSellOff[j]%></td>
        <%}
        else {%>
           <td class="DataTable4" id="csell<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" >&nbsp;<%=sSellOff[j]%></td>
        <%}%>
        
        <script>
              aCellSellOfId[aCellSellOfId.length] = "csell<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
      	</script>
        
      <%}%>
    </tr>

      <tr id="STRHDR<%=i%>">
        <td class="StrLst" colspan="5">Stores</td>
        <%for(int j=0; j < iNumOfStr; j++){%>
           <%if(!sStr[j].equals("99")){%>
           <td class="StrLst" id="StrHdrL3<%=i%>_<%=j%>"  colspan="2"><%=sStr[j]%></td>
           <%}
             else {%>
               <td class="StrLst" id="StrHdr3<%=i%>" ><%=sStr[j]%></td>
           <%}%>
        <%}%>
        <td class="StrLst" colspan="2">Stores</td>
      </tr>         
   <%}%>
    <!----------------------- end of data ------------------------>
 </table>
 <%if(!bEof){%><a class="Small" href="javascript: getNextPage()">Next Page</a><%}%>
 <!----------------------- end of table ------------------------>
<%
long lEndTime = (new Date()).getTime();
long lElapse = (lEndTime - lStartTime) / 1000;
if (lElapse==0) {lElapse = 1;}
//System.out.println("B/Item X-fer loading Elapse time=" + lElapse + " second(s)");
%>
<p  style="text-align: left; font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>
  </table>
 <script type="text/javascript">
 var EndTime = Date.now();
 var lapse = (EndTime - StartTime) / 1000;
 window.status = "lapse=" + lapse;
 </script> 
 </body>
</html> 
<% 
	itemLst.disconnect();
	itemLst = null;	
}
%>

