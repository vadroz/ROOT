<%@ page import="inventoryreports.UpcSearch, java.util.*"%>
<%
   String sSearchUpc = request.getParameter("UPC");
   String sSearchSku = request.getParameter("SKU");
   String sSearchClass = request.getParameter("CLASS");
   String sSearchVen = request.getParameter("VEN");
   String sSearchDesc = request.getParameter("DESC");
   String sClsPatio = request.getParameter("ClsPatio");
   String sOnHandOnly = request.getParameter("OnHandOnly");

   // call from kiosk
   String sKioskStr = request.getParameter("KioskStr");
   String sKioskSrc = request.getParameter("KioskSrc");

   if(sKioskStr == null){sKioskStr = "NONE";}
   if(sKioskSrc == null){sKioskSrc = "NONE";}

   if(sSearchUpc==null) sSearchUpc =" ";
   if(sSearchSku==null) sSearchSku =" ";
   if(sSearchClass==null) sSearchClass =" ";
   if(sSearchVen==null) sSearchVen =" ";
   if(sSearchDesc==null) sSearchDesc =" ";
   if(sClsPatio==null) sClsPatio =" ";
   if(sOnHandOnly==null) sOnHandOnly =" ";

   int iNumOfItm = 0;
   String [] sCls = null;
   String [] sVen = null;
   String [] sSty = null;
   String [] sClr = null;
   String [] sSiz = null;
   String [] sSku = null;
   String [] sItmDsc = null;
   String [] sVenSty = null;
   String [] sVenName = null;
   String [] sUpc = null;
   String [] sRet = null;
   String [] sOnHand = null;

   UpcSearch search = new UpcSearch();

   // set class list
   search.setClassList();
   int iNumOfCls = search.getNumOfCls();
   String sDivLstJSA = search.getDivLstJSA();
   String sDptLstJSA = search.getDptLstJSA();
   String sClsLstJSA = search.getClsLstJSA();
   String sClsNameLstJSA = search.getClsNameLstJSA();

   String sDCDivLstJSA = search.getDCDivLstJSA();
   String sDCClsLstJSA = search.getDCClsLstJSA();
   String sDCClsNameLstJSA = search.getDCClsNameLstJSA();

   String sPatVenJSA = search.getPatVenJSA();
   String sPatVenNmJSA = search.getPatVenNmJSA();

   boolean bSearch = false;

   // if one criteria is selected search the items
   if(!sSearchUpc.trim().equals("") || !sSearchSku.trim().equals("")
     || !sSearchClass.trim().equals("") || !sSearchVen.trim().equals("")
     || !sSearchDesc.trim().equals(""))
   {
     bSearch = true;
     search.setSearch(sSearchUpc, sSearchSku, sSearchClass, sSearchVen, sSearchDesc, sClsPatio, sOnHandOnly);

     iNumOfItm = search.getNumOfItm();
     sCls = search.getCls();
     sVen = search.getVen();
     sSty = search.getSty();
     sClr = search.getClr();
     sSiz = search.getSiz();
     sSku = search.getSku();
     sItmDsc = search.getItmDsc();
     sVenSty = search.getVenSty();
     sVenName = search.getVenName();
     sUpc = search.getUpc();
     sRet = search.getRet();
     sOnHand = search.getOnHand();
     search.disconnect();
     search = null;
   }

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:WhiteSmoke; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px;
                       border-right: darkred solid 1px;
                       text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px;
                       border-right: darkred solid 1px;
                       text-align:right;}

        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
                    
        div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:315; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  		div.dvInternal { background: LemonChiffon; width: 310px; height: 210px; overflow: auto; font-size:10px}
  		
        select.Small {font-family:Arial; font-size  :10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<script language="JavaScript1.2">
//--------------- Global variables -----------------------
var NumOfCls = <%=iNumOfCls%>;
var Div = [<%=sDivLstJSA%>];
var Dpt = [<%=sDptLstJSA%>];
var Cls = [<%=sClsLstJSA%>];
var ClsName = [<%=sClsNameLstJSA%>];

var DCDiv = [<%=sDCDivLstJSA%>];
var DCCls = [<%=sDCClsLstJSA%>];
var DCClsName = [<%=sDCClsNameLstJSA%>];

var PatVen = [<%=sPatVenJSA%>];
var PatVenNm = [<%=sPatVenNmJSA%>];

var KioskStr = "<%=sKioskStr%>";
var KioskSrc = "<%=sKioskSrc%>";

var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";
//--------------- End of Global variables ----------------
//--------------------------------------------------------
// populate some fields on beginning
//--------------------------------------------------------
function bodyLoad()
{
  popDivDptCls("0");
  popDivCls("0");
  //popPatVendor();
}
//==============================================================================
// populate drop down menu with div/dpt/cls
//==============================================================================
function popDivDptCls(div)
{
  while(document.forms[0].CLASS[0].options.length > 0)
  {
    document.forms[0].CLASS[0].remove(document.forms[0].CLASS[0].options.length-1);
  }

  for(var i=0, j=0; i < NumOfCls; i++)
  {
	  
    if(div == "0" || Div[i].trim() == div )
    {
       document.forms[0].CLASS[0].options[j] = new Option("Div: " + Div[i] + " Dpt: " + Dpt[i]
           + " Cls: " + Cls[i] + " - " + ClsName[i], Cls[i]);
       j++;
    }
  }
}
//==============================================================================
// populate drop down menu with div/dpt/cls
//==============================================================================
function popDivCls(div)
{
  while(document.forms[0].CLASS[1].options.length > 0)
  {
    document.forms[0].CLASS[1].remove(document.forms[0].CLASS[1].options.length-1);
  }   

  for(var i=0, j=0; i < NumOfCls; i++)
  {
    if(div == "0" || DCDiv[i].trim() == div )
    {
       document.forms[0].CLASS[1].options[j] = new Option("Div: " + DCDiv[i]+ " Cls: " + DCCls[i] + " - "
            + DCClsName[i], DCCls[i]);
       j++;
    }
  }
}
//==============================================================================
//retreive vendors
//==============================================================================
function rtvVendors(patio)
{
	var url = "RetreiveVendorList.jsp?Patio=" + patio
 	window.frame1.location = url;		
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
var dummy = "<table>"

html += "<div id='dvInt' class='dvInternal'>"
    + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
for(var i=0; i < ven.length; i++)
{
html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
}
html += "</table></div>"
var pos = objPosition(document.all.VenName)

document.all.dvVendor.innerHTML = html;
document.all.dvVendor.style.pixelLeft= pos[0] + 270;
document.all.dvVendor.style.pixelTop= pos[1];
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

	// zeroed last search
	if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
	LastVen = vennm;

	for(var i=LastTr+1; i < Vendor.length; i++)
	{
		if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break;}
		else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break;}
		document.all.trVen[i].style.color="black";
	}

	// if found set value and scroll div to the found record
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
	document.all.VEN.value = ven
}
//==============================================================================
//find object postition
//==============================================================================
function objPosition(obj)
{
	var pos = new Array(2);
	pos[0] = 0;
	pos[1] = 0;
	// position menu on the screen
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
  		pos[0] += obj.offsetLeft
  		pos[1] += obj.offsetTop
  		obj = obj.offsetParent;
		}
	}
	else if (obj.x)
	{
		pos[0] += obj.x;
		pos[1] += obj.y;
	}
	return pos;
}


//==============================================================================
// populate drop down menu patio vendor list
//==============================================================================
function popPatVendor()
{
   showVendors(PatVen, PatVenNm)
}
//==============================================================================
// return selected Item
//==============================================================================
function getSelectedItem(sku)
{
   if (opener && !opener.closed)
   {
      try{  opener.getSearchedItem(sku); window.close()}
      catch(e) { window.status = "There is no place to return selection" }
   }
   else {window.status = "There is no place to return selected item."}
}
//==============================================================================
// set active input field
//==============================================================================
function setSelItm(selitm)
{

   document.all.UPC.disabled  = !(selitm.value==1);
   document.all.SKU.disabled  = !(selitm.value==2);
   document.all.CLASS[0].disabled = !(selitm.value==3);
   document.all.ClsPatio[0].disabled = !(selitm.value==3);
   document.all.CLASS[1].disabled = !(selitm.value==4);
   document.all.ClsPatio[1].disabled = !(selitm.value==4);
   
   document.all.VenName.disabled = !(selitm.value==5);
   document.all.ClsPatio[2].disabled = !(selitm.value==5);   
   if(selitm.value==5)
   { 
	   document.all.ClsPatio[2].checked = false;	   
	   popPatVendor();
	   
   }
   else{   document.all.dvVendor.style.visibility="hidden";  }
   
   
   document.all.DESC.disabled = !(selitm.value==6);
   //document.all.ClsPatio[2].disabled = !(selitm.value==6);
}
//==============================================================================
// search value
//==============================================================================
function setDescSearch(srch)
{
   var aSrch = new Array();
   aSrch = srch.split(" ");
   alert(aSrch)
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


</head>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br><%if(!sSearchUpc.trim().equals("")){%>Search Item by UPC code: <%=sSearchUpc%><%}
       else if(!sSearchSku.trim().equals("")){%>Search Item by Sku: <%=sSearchSku%><%}
       else if(!sSearchClass.trim().equals("")){%>Search Items by Class: <%=sSearchClass%><%}
       else  {%>Select Search Criteria: UPC, Short Sku or Class <%}%>
      </b>

      <br>
      <span style="color:brown; font-size:12px;font-weight:bold;text-decoration:underline">
          Discontinued Items and Patio Special Order items are excluded from this search list.
      </span>

      <!-- ---------------------------------------------------------------- -->
      <form action="UpcSearch.jsp" name="SearchUPC">
         <table cellPadding="0" cellSpacing="3">
           <tr><td>Search Item by UPC:</td>
               <td><input onClick="setSelItm(this)" class='small' name='SelItm' type="radio" value="1" checked></td>
               <td><input class='small' name='UPC' size="16" maxlength="13"></td></tr>
           <tr><td>Search Item by Short SKU:</td>
               <td><input onClick="setSelItm(this)" class='small' name='SelItm' type="radio" value="2"></td>
               <td><input class='small' name='SKU' size="10" maxlength="10" disabled></td></tr>
           <tr><td>Search Item by Div/Dpt/Cls:</td>
               <td><input onClick="setSelItm(this)" class='small' name='SelItm' type="radio" value="3"></td>
               <td>
                   <select class='small' name='CLASS' disabled></select>
                   <input class='small' type="radio" name='ClsPatio' disabled onclick="popDivDptCls('50')"> Patio Only
               </td></tr>
           <tr><td>Search Item by Div/Cls:</td>
               <td><input onClick="setSelItm(this)" class='small' name='SelItm' type="radio" value="4"></td>
               <td>
                   <select class='small' name='CLASS' disabled></select>
                   <input class='small' type="radio" name='ClsPatio' disabled onclick="popDivCls('50')"> Patio Only
               </td></tr>
           <tr><td>Search Item by Patio Vendor:</td>
               <td><input onClick="setSelItm(this)" class='small' name='SelItm' type="radio" value="5"></td>
               <td><input class="Small" name="VenName" size=50 value=" --- Select Vendor --- " disabled>
               	   <input class="Small" name="VEN" type="hidden" value="ALL">
               	   <input class='small' type="radio" name="ClsPatio" value="Y" disabled onclick="document.all.dvVendor.style.visibility=&#34;hidden&#34;; rtvVendors('N');"> All Vendor
               	   <!-- button class="Small" name=ClrVen onClick="document.all.VenName.value='All Vendors'; document.all.VEN.value='ALL'">Reset</button -->               
               </td></tr>
           <tr><td>Search Item by Description:</td>
               <td><input onClick="setSelItm(this)" class='small' name='SelItm' type="radio" value="6"></td>
               <td>
                  <input class='small' name='DESC' size="25" maxlength="25" disabled>
                  <!-- <input class='small' type="radio" name="ClsPatio" value="Y" disabled> Patio Only -->
               </td></tr>
           <tr><td>&nbsp;</td>
               <td>&nbsp;</td>
               <td>
                  <input class='small' type="checkbox" name="OnHandOnly" value="Y" checked> Has On Hands
               </td></tr>
           <tr><td colspan=3 align=center>
                 <input class='small' name="Search" type="Submit" value="Search">
                 <input name="KioskStr" type="hidden" value="<%=sKioskStr%>">
                 <input name="KioskSrc" type="hidden" value="<%=sKioskSrc%>">
               </td></tr>
         </table>
      </form>
      <!-- ---------------------------------------------------------------- -->

     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan=3>

      <%if(!bKiosk){%>
         <a href="../"><font color="red" size="-1">Home</font></a>&#62;
         <font size="-1">This Page.</font>
      <%}
      else {%>
        <a href="KioskMain.jsp?utm_medium=<%=sKioskStr%>&utm_source=<%=sKioskSrc%>"><font color="red" size="-1">Kiosk Main</font></a>&#62;
        <font size="-1">This Page.</font>
      <%}%>
      &nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
            <th class="DataTable" nowrap>Class-Ven-Sty</th>
            <th class="DataTable" nowrap>Color</th>
            <th class="DataTable" nowrap>Size</th>
            <th class="DataTable">Short SKU</th>
            <th class="DataTable">UPC</th>
            <th class="DataTable">Item Description</th>
            <th class="DataTable">Vendor Style</th>
            <th class="DataTable">Vendor Name</th>
            <%if(!bKiosk){%><th class="DataTable">Chain<br>Retail</th><%}%>
            <th class="DataTable">**PATIO**<br>Search Items<br>In-Stock</th>
            <th class="DataTable">Chain<br>On Hands</th>
            <th class="DataTable">Store<br>On Hands</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++) {%>
              <tr class="DataTable">
                <%if(sKioskStr.equals("NONE")){%>
                    <td class="DataTable" onClick="getSelectedItem('<%=sSku[i]%>')" nowrap>
                         <%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%></td>
                <%}
                else {%>
                   <td class="DataTable" nowrap>
                       <a href="http://www.sunandski.com/ProductDetails.asp?ProductCode=<%=sCls[i]%><%=sVen[i]%><%=sSty[i]%>&utm_medium=store_<%=sKioskStr%>&utm_campaign=Kiosk&utm_source=<%=sKioskSrc%>"><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%></a></td>
                <%}%>
                <td class="DataTable" nowrap><%=sClr[i]%></td>
                <td class="DataTable" nowrap><%=sSiz[i]%></td>
                <td class="DataTable" nowrap><%=sSku[i]%></td>
                <td class="DataTable" nowrap><%=sUpc[i]%></td>
                <td class="DataTable" nowrap><%=sItmDsc[i]%></td>
                <td class="DataTable" nowrap><%=sVenSty[i]%></td>
                <td class="DataTable" nowrap><%=sVenName[i]%></td>
                <%if(!bKiosk){%><td class="DataTable1" nowrap><%=sRet[i]%></td><%}%>
                <td class="DataTable1" nowrap>
                  <a href="ItemSearch.jsp?Sku=<%=sSku[i]%>" target="_blank">Avail to Sell</a>
                </td>
                <td class="DataTable1" nowrap><%=sOnHand[i]%></td>
                <td class="DataTable1" nowrap>
                   <a href="servlet/onhand01.OnHands03?STORE=03&CLASS=<%=sCls[i]%>&VENDOR=<%=sVen[i]%>&STYLE=<%=sSty[i]%>&User=<%=sUser%>&OutSlt=HTML&KioskStr=<%=sKioskStr%>&KioskSrc=<%=sKioskSrc%>">
                      by Item
                   </a>
                </td>
              </tr>
           <%}%>
      </table>
      <% if(iNumOfItm < 14) {
           for(int i=0; i < 14; i++){%>
              <br>
      <%   }
        }%>
   <br>
      <!----------------------- end of table ------------------------>
  </table>

 </body>
</html>
