<%@ page import="java.util.*, java.text.*"%>
<%
    String sSku = request.getParameter("Sku");
%>
<title>Item Search</title>
<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        table.DataTable1 { background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.Error { color:red; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; display:none;}               

        <!-------- select another div/dpt/class pad ------->
        .Small {font-family:Arial; font-size:10px }
        input {border:none; border-bottom: black solid 1px; font-family:Arial; font-size:12px; font-weight:bold}
        input.radio {border:none; font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }

        <!-------- transfer entry pad ------->
        div.Fake { };

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        <!-------- end transfer entry pad ------->

</style>
<SCRIPT language="JavaScript1.2">
var iPoRow = 0;
var Sku = null;
<%if(sSku != null){%>Sku = "<%=sSku%>"<%}%>

var SearchOrClr = false;
var SearchSku = "";
var SearchUpc = "";
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
   clrLine();
   if(Sku != null)
   {
     document.all.Sku.value = Sku;     
     getSkuUpc();
   }
}
//==============================================================================
// get item by SKU
//==============================================================================
function getSkuUpc()
{
   document.all.tdError.innerHTML = "";
   document.all.tdError.style.display = "none";
   var sku = document.all.Sku
   var upc = document.all.Upc
   var skuval = sku.value;
   var upcval = upc.value;
   
   //var SearchSku = "";
   //var SearchUpc = "";
   //if(SearchOrClr)
   if(SearchSku == skuval && SearchUpc == upcval) 	   
   { 
	   clrLine();
	   //SearchOrClr = !SearchOrClr;	   
   }
   else
   {
	    SearchSku = skuval;
	    SearchUpc = upcval;
	   
   		var url = "PsOrdGetItem.jsp?"

   		if (sku.value.trim() != ""  && sku.value.trim() != " ")
   		{
     		url += "Sku=" + sku.value + "&Action=INQ"
     		//window.location.href=url
     		window.frame1.location.href=url
     		//SearchOrClr = !SearchOrClr;
   		}
   		else if (upc.value.trim() != "" && upc.value.trim() != " ")
   		{
     		url += "Upc=" + upc.value + "&Action=INQ"
     		//window.location.href=url
     		window.frame1.location.href=url
     		document.all.tdTotal.focus();
     		//SearchOrClr = !SearchOrClr;
   		}

   		clrTable();   			
   }
   
}

//==============================================================================
// get item by SKU
//==============================================================================
function searchSet(sku)
{
   // Make Set Lines hidden
   for(var i=0; i < document.all.trSet.length; i++)
   {
      document.all.trSet[i].style.display="none";
   }

   var url = "PsOrdGetItem.jsp?"
           + "Sku=" + sku + "&Action=INQ"
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// clear "Adding line" row.
//==============================================================================
function clrLine()
{
   document.all.tbPoList.style.display = "none";

   document.all.tdDesc.innerHTML = "&nbsp;";
   document.all.Sku.value = "";
   document.all.Upc.value = "";
   document.all.Sku.readOnly = false;
   document.all.Upc.readOnly = false;

   document.all.tdTempPrc.innerHTML = "&nbsp;";
   document.all.tdPrice.innerHTML = "&nbsp;";
   document.all.tdGroup.innerHTML = "&nbsp;";
   document.all.tdSugPrc.innerHTML = "&nbsp;";
   document.all.tdClrNm.innerHTML = "&nbsp;";
   document.all.tdVenNm.innerHTML = "&nbsp;";
   document.all.tdVenSty.innerHTML = "&nbsp;";
   document.all.tdTotal.innerHTML = "&nbsp;";

   document.all.Sku.focus();
   // Make Set Lines hidden
   for(var i=0; i < document.all.trSet.length; i++)
   {
      document.all.trSet[i].style.display="none";
   }

   // Make Set Lines hidden
   document.all.trSetLstHdr.style.display="none";
   for(var i=0; i < document.all.trSetLst.length; i++)
   {
      document.all.trSetLst[i].style.display="none";
   }

   document.all.dvItem.innerHTML = "";
   document.all.dvSet.innerHTML = "";
}
//==============================================================================
// clear set and set list table
//==============================================================================
function clrTable()
{
   // Make Set Lines hidden
   for(var i=0; i < document.all.trSet.length; i++)
   {
      document.all.trSet[i].style.display="none";
   }

   // Make Set Lines hidden
   document.all.trSetLstHdr.style.display="none";
   for(var i=0; i < document.all.trSetLst.length; i++)
   {
      document.all.trSetLst[i].style.display="none";
   }
}
//==============================================================================
// set Search
//==============================================================================
function setSearch()
{
   var url = "UpcSearch.jsp";
   var WindowName = 'UPC_Search';
   var WindowOptions = 'resizable=yes , toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,menubar=yes';

   //alert(url);
   window.open(url, WindowName, WindowOptions);
}
//==============================================================================
// populate table with dselected Item
//==============================================================================
function getSearchedItem(sku)
{
   var url = "PsOrdGetItem.jsp?"
   url += "Sku=" + sku + "&Action=INQ"
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// display error
//==============================================================================
function displayError(err)
{   
   document.body.focus();
   //window.frame1.location.href="";
   //window.frame1.close();
   
   msg = "";
   for(var i=0; i < err.length; i++)  {  msg += err[i] + "\n"; }
   //alert(msg);
   document.all.tdError.innerHTML = msg; 
   document.all.tdError.style.display = "block";
   
   document.all.Sku.focus();   
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddLine(desc, sku, upc, set, price, group
    , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
    , sugprc, tempprc, clrnm, vennm, vensty, itmpoqty, disconn, action)
{
   document.all.tdDesc.innerHTML = desc;
   if(disconn == "1")
   { 
	   document.all.tdDesc.innerHTML = desc + "<div style='background:red'>***Warning***<br>Item is Discontinued!!!</div>";    		  
   }   
   document.all.Sku.value = sku;
   document.all.Upc.value = upc;
   
   SearchSku = sku;
   SearchUpc = upc;
   
   document.all.tdTempPrc.innerHTML = tempprc;
   document.all.tdPrice.innerHTML = price;
   document.all.tdGroup.innerHTML = group;

   document.all.tdTotal.innerHTML = eval(qty35[4]) + eval(qty46[4]) + eval(qty50[4])
      + eval(qty86[4]) + eval(qty63[4]) + eval(qty64[4]) + eval(qty68[4]) + eval(qty55[4]);
   document.all.tdSugPrc.innerHTML = sugprc;
   document.all.tdClrNm.innerHTML = clrnm;
   document.all.tdVenNm.innerHTML = vennm;
   document.all.tdVenSty.innerHTML = vensty;
   document.all.tdPOQty.innerHTML = itmpoqty;

   if(set!="1")
   {
     showItemInvPanel(desc, sku, upc, set, price, group
      , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
      , sugprc, tempprc, clrnm, vennm, vensty, itmpoqty, disconn, action);
   }
   if(set != "1") { document.all.dvSet.innerHTML = ""; }
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddSetLines(numofset, setdesc, setsku, setupc, setprice, setgroup
   , setqty35, setqty46, setqty50, setqty86, setqty63, setqty64, setqty68, setqty55
   , setsugprc, settot, setuntprc, settempprc, setclrnm, setvennm, setvensty, setpoqty, setdisconn, action)
{
	 
   for(var i=0; i < numofset; i++)
   {
      document.all.trSet[i].style.display="block";
      document.all.tdSetDesc[i].innerHTML = setdesc[i];      
      document.all.tdSetTotQty[i].innerHTML = settot[i];
      document.all.tdSetPOQty[i].innerHTML = setpoqty[i];
      document.all.tdSetSku[i].innerHTML = setsku[i] + " / " + setupc[i];
      document.all.tdSetTempPrc[i].innerHTML = settempprc[i];
      document.all.tdSetPrice[i].innerHTML = setprice[i];
      document.all.tdSetGroup[i].innerHTML = setgroup[i];
      document.all.tdSetTotal[i].innerHTML = eval(setqty35[i][4]) + eval(setqty46[i][4])
         + eval(setqty50[i][4]) + eval(setqty86[i][4]) + eval(setqty63[i][4])
         + eval(setqty64[i][4]) + eval(setqty68[i][4]) + eval(setqty55[i][4]);
      document.all.tdSetSugPrc[i].innerHTML = setsugprc[i];
      document.all.tdSetClrNm[i].innerHTML = setclrnm[i];
      document.all.tdSetVenNm[i].innerHTML = setvennm[i];
      document.all.tdSetVenSty[i].innerHTML = setvensty[i];
   }

   window.frame1.close();
   
   showSetInvPanel(numofset, setdesc, setsku, setupc, setprice, setgroup
   , setqty35, setqty46, setqty50, setqty86, setqty63, setqty64, setqty68, setqty55
   , setsugprc, settot, setuntprc, settempprc, setclrnm, setvennm, setvensty, setdisconn, action)

   document.all.dvItem.innerHTML = "";
}
//==============================================================================
// populate Set List
//==============================================================================
function popSetLists(numofset, setdesc, setsku, setupc, setprice, setgroup
  , setqty35, setqty46, setqty50, setqty86, setqty63, setqty64, setqty68, setqty55
  , setsugprc, settot, setuntprc, settempprc, setclrnm, setvennm, setvensty, setpoqty, setdisconn, action)
{
   document.all.trSetLstHdr.style.display="block";
   for(var i=0; i < numofset; i++)
   {
      document.all.trSetLst[i].style.display="block";
      document.all.tdLstDesc[i].innerHTML = setdesc[i];
      document.all.tdLstSku[i].innerHTML =
        "<a href='javascript: searchSet(&#34;" + setsku[i] + "&#34;)'>"
               + setsku[i] + " / " + setupc[i] + "</a>";

      document.all.tdLstGroup[i].innerHTML = setgroup[i];
      document.all.tdLstTotQty[i].innerHTML = settot[i];
      //document.all.tdLstPOQty[i].innerHTML = setpoqty[i];
      //document.all.tdLstTempPrc[i].innerHTML = settempprc[i];
      document.all.tdLstTotal.innerHTML = eval(setqty35[i]) + eval(setqty46[i]) + eval(setqty50[i])
          + eval(setqty86[i])
          + eval(setqty63[i]) + eval(setqty64[i]) + eval(setqty68[i]) + eval(setqty55[i]);
      document.all.tdLstSugPrc[i].innerHTML = setsugprc[i];
      document.all.tdLstClrNm[i].innerHTML = setclrnm[i];
      document.all.tdLstVenNm[i].innerHTML = setvennm[i];
      document.all.tdLstVenSty[i].innerHTML = setvensty[i];
   }
 }
//==============================================================================
// populate PO Table
//==============================================================================
function popPoTable(NumOfPoItm, PoSku, LineBySku, PoStr, PoNum, PoQty, PoAdi)
{
   // remove PO line
   var body = document.all.tbodyPoList;
   while (body.childNodes.length > 0)
   {
      body.removeChild(body.firstChild)
   }
   iPoRow = 0;

   document.all.tbPoList.style.display = "block";
   window.frame1.close();

   for(var i=0; i < NumOfPoItm; i++)
   {
      var row = document.createElement("TR");
      row.className="DataTable";
      row.id="trPoItm"; //add ID

      var td = new Array();
      td[0] = addTDElem(PoSku[i], "tdPoSku", "DataTable") // sku
      td[1] = addTDElem(PoStr[i][0], "tdPoStr", "DataTable") // str
      td[2] = addTDElem(PoNum[i][0], "tdPoNum", "DataTable") // P.O.
      td[3] = addTDElem(PoQty[i][0], "tdPoQty", "DataTable") // qty
      td[4] = addTDElem(PoAdi[i][0], "tdPoAdi", "DataTable") // anticipation date

      // add cell to row
      for(var k=0; k < td.length; k++) { row.appendChild(td[k]); }
      iPoRow++;

      // add row to the table
      document.all.tbodyPoList.appendChild(row);
   }
}
//---------------------------------------------------------
// add new TD element
//---------------------------------------------------------
function addTDElem(value, id, classnm)
{
  var td = document.createElement("TD") // Reason
  td.appendChild (document.createTextNode(value))
  td.className=classnm;
  td.id = id;
  return td;
}
//==============================================================================
// show Item Inventory by store table
//==============================================================================
function showItemInvPanel(desc, sku, upc, set, price, group
  , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
  , sugprc, tempprc, clrnm, vennm, vensty, itmpoqty, disconn, action)
{
   var hdr = "Item Inventory By Stores";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
     + "<tr><td class='Prompt' colspan=2>" + popItemInvPanel(desc, sku, upc, set, price, group
          , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
          , sugprc, tempprc, clrnm, vennm, vensty, itmpoqty, disconn, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 250;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 300;
   document.all.dvItem.style.visibility = "visible";
}

//==============================================================================
// show Item Inventory by store table
//==============================================================================
function popItemInvPanel(desc, sku, upc, set, price, group
  , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
  , sugprc, tempprc, clrnm, vennm, vensty, itmpoqty, disconn, action)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr>"
           + "<th class='DataTable' rowspan=2>Short SKU</th>"
           + "<th class='DataTable' rowspan=2>Description</th>"
           + "<th class='DataTable' rowspan=2>Inventory<br>Lines</th>"
           + "<th class='DataTable' rowspan=2 nowrap>Qty Available to<br>Sell Right Now</th>"
           + "<th class='DataTable' rowspan=2 nowrap>Sold<br>(un-delivered)</th>"
           + "<th class='DataTable' rowspan=2>Total<br>Inv</th>"
           + "<th class='DataTable' colspan=3 nowrap>DC Area<br>(Ski Chalet)</th>"
           + "<th class='DataTable' colspan=1 nowrap>NY Store<br>(Ski Stop)</th>"
           + "<th class='DataTable' colspan=4 nowrap>NE Area<br>(Warehouse and Sun & Ski)</th>"
         + "</tr>"
         + "<tr>"
           + "<th class='DataTable'>35</th>"
           + "<th class='DataTable'>46</th>"
           + "<th class='DataTable'>50</th>"

           + "<th class='DataTable'>86</th>"

           + "<th class='DataTable'>55</th>"
           + "<th class='DataTable'>63</th>"
           + "<th class='DataTable'>64</th>"
           + "<th class='DataTable'>68</th>"
         + "</tr>"
  for(var i=0; i < 5; i++)
  {
      panel += "<tr class='DataTable'>"
      if(i==0)
      {	  
        panel += "<td class='DataTable' rowspan=5><a href='OrderLst.jsp?FrOrdDt=01/01/0001"
           + "&ToOrdDt=12/31/2999&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W"
           + "&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F"
           + "&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R"
           + "&Sku=" + sku + "&Cust=&SlsPer=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63"
           + "&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64"
           + "&StrTrf=68&StrTrf=55&StsOpt=CURRENT' target='_blank'>" + sku + "</a></td>"
        panel += "<td class='DataTable' rowspan=5 nowrap>" + desc;
        if(disconn == "1"){ panel += "<div style='background:red'>***Warning***<br>Item is Discontinued!!!</div>"}
        panel += "</td>";
      }

      var summ = (eval(qty35[i]) + eval(qty46[i]) + eval(qty50[i]) + eval(qty86[i]) + eval(qty63[i])
               + eval(qty64[i]) + eval(qty68[i]) + eval(qty55[i])).toFixed(0);
      var invty = "";
      var avlqty = "&nbsp";
      var soldqty = "&nbsp";
      var invfqty = "&nbsp";
      var totqty = "&nbsp";

      var totclr = "white";
      var soldclr = "white";
      var invfclr = "white";
      var avlclr = "white";
      var strclr = "white";

      if(i==0) { invty = "Computer On Hand"; totqty = summ; totclr = "pink"; strclr=totclr;}
      if(i==1) { invty = "Sold (un-delivered)"; soldqty = summ; soldclr = "lightgreen"; strclr=soldclr;  }
      if(i==2) { invty = "Requested INV From"; invfqty = summ; invfclr = "white"; strclr=invfclr;  }
      if(i==3) { invty = "&nbsp; &nbsp; ADJ for Completed Transfer"; invfqty = summ; invfclr = "white"; strclr=invfclr;  }
      if(i==4) { invty = "Available to Sell"; avlqty = summ; avlclr = "yellow"; strclr=avlclr;}

      panel += "<td class='DataTable' nowrap>" + invty + "</td>"
      panel += "<td class='DataTable2' style='background:" + avlclr + ";'>" + avlqty  + "</td>"
      panel += "<td class='DataTable2' style='background:" + soldclr + ";'>" + soldqty + "</td>"
      panel += "<td class='DataTable2' style='background:" + totclr + ";'>" + totqty + "</td>"

      panel += "<td class='DataTable2' style='background:" + strclr + ";'>" + qty35[i] + "</td>"
           + "<td class='DataTable2' style='background:" + strclr + ";'>" + qty46[i] + "</td>"
           + "<td class='DataTable2' style='background:" + strclr + ";'>" + qty50[i] + "</td>"
           + "<td class='DataTable2' style='background:" + strclr + ";'>" + qty86[i] + "</td>"
           + "<td class='DataTable2' style='background:" + strclr + ";'>" + qty55[i] + "</td>"
           + "<td class='DataTable2' style='background:" + strclr + ";'>" + qty63[i] + "</td>"
           + "<td class='DataTable2' style='background:" + strclr + ";'>" + qty64[i] + "</td>"
           + "<td class='DataTable2' style='background:" + strclr + ";'>" + qty68[i] + "</td>"
         + "</tr>"
  }
  //panel += "<tr><td class='DataTable2' colspan=13><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";
  return panel;
}

//==============================================================================
// show Item Inventory by store table
//==============================================================================
function showSetInvPanel(numofset, desc, sku, upc, price, group
  , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
  , sugprc, tot, untprc, tempprc, clrnm, vennm, vensty, disconn, action)
{
   var hdr = "Set Components By Stores";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<tr><td class='Prompt' colspan=2>" + popSetInvPanel(numofset, desc, sku, upc, price, group
          , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
          , sugprc, tot, untprc, tempprc, clrnm, vennm, vensty, disconn, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvSet.innerHTML = html;
   document.all.dvSet.style.pixelLeft= document.documentElement.scrollLeft + 250;
   document.all.dvSet.style.pixelTop= document.documentElement.scrollTop + 300;
   document.all.dvSet.style.visibility = "visible";
}

//==============================================================================
// show Item Inventory by store table
//==============================================================================
function popSetInvPanel(numofset, desc, sku, upc, price, group
  , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
  , sugprc, tot, untprc, tempprc, clrnm, vennm, vensty, disconn, action)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr>"
           + "<th class='DataTable' rowspan=2>Short SKU</th>"
           + "<th class='DataTable' rowspan=2>Description</th>"
           + "<th class='DataTable' rowspan=2>Inventory<br>Lines</th>"
           + "<th class='DataTable' rowspan=2 nowrap>Qty Available to<br>Sell Right Now</th>"
           + "<th class='DataTable' rowspan=2 nowrap>Sold<br>(un-delivered)</th>"
           + "<th class='DataTable' rowspan=2>Total<br>Inv</th>"
           + "<th class='DataTable' colspan=3 nowrap>DC Area<br>(Ski Chalet)</th>"
           + "<th class='DataTable' colspan=1 nowrap>NY Store<br>(Ski Stop)</th>"
           + "<th class='DataTable' colspan=4 nowrap>NE Area<br>(Warehouse and Sun & Ski)</th>"
         + "</tr>"
         + "<tr>"
           + "<th class='DataTable'>35</th>"
           + "<th class='DataTable'>46</th>"
           + "<th class='DataTable'>50</th>"

           + "<th class='DataTable'>86</th>"

           + "<th class='DataTable'>55</th>"
           + "<th class='DataTable'>63</th>"
           + "<th class='DataTable'>64</th>"
           + "<th class='DataTable'>68</th>"
         + "</tr>"
  for(var i=0; i < numofset; i++)
  {
    for(var j=0; j < 5; j++)
    {
      panel += "<tr class='DataTable'>"
      if(j==0)
      {
         panel += "<td class='DataTable' rowspan=5><a href='OrderLst.jsp?FrOrdDt=01/01/0001"
           + "&ToOrdDt=12/31/2999&FrDelDt=01/01/0001&ToDelDt=12/31/2999&Status=T&Status=W"
           + "&Status=U&Status=S&Status=Z&Status=R&Status=X&PyStatus=O&PyStatus=P&PyStatus=F"
           + "&PyStatus=E&InclSO=B&SoStatus=N&SoStatus=A&SoStatus=V&SoStatus=R"
           + "&Sku=" + sku + "&Cust=&SlsPer=&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63"
           + "&StrGrp=64&StrGrp=68&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64"
           + "&StrTrf=68&StrTrf=55&StsOpt=CURRENT' target='_blank'>" + sku[i] + "</td>"
         panel += "<td class='DataTable' rowspan=5 nowrap>" + desc[i] 
         if(disconn[i] == "1"){ panel += "<div style='background:red'>***Warning***<br>Item is Discontinued!!!</div>"}
         panel += "</td>"
      }

      var summ = (eval(qty35[i][j]) + eval(qty46[i][j]) + eval(qty50[i][j]) + eval(qty86[i][j])
         + eval(qty63[i][j]) + eval(qty64[i][j]) + eval(qty68[i][j]) + eval(qty55[i][j])).toFixed(0);
      var invty = "";
      var avlqty = "&nbsp";
      var soldqty = "&nbsp";
      var infqty = "&nbsp";
      var totqty = "&nbsp";

      var totclr = "white";
      var soldclr = "white";
      var avlclr = "white";
      var allclr = "white";

      if(j==0) { invty = "Computer On Hand"; totqty = summ; totclr = "pink"; allclr = totclr; }
      if(j==1) { invty = "Sold (un-delivered)"; soldqty = summ; soldclr = "lightgreen"; allclr = soldclr; }
      if(j==2) { invty = "Requested INV From"; infqty = summ; soldclr = "white"; allclr = soldclr; }
      if(j==3) { invty = "&nbsp; &nbsp; ADJ for Completed Transfer"; infqty = summ; soldclr = "white"; allclr = soldclr; }
      if(j==4) { invty = "Available to Sell"; avlqty = summ; avlclr = "yellow"; allclr = avlclr; }

      panel += "<td class='DataTable' nowrap>" + invty + "</td>"
      panel += "<td class='DataTable2' style='background:" + avlclr + ";'>" + avlqty  + "</td>"
      panel += "<td class='DataTable2' style='background:" + soldclr + ";'>" + soldqty + "</td>"
      panel += "<td class='DataTable2' style='background:" + totclr + ";'>" + totqty + "</td>"

      panel += "<td class='DataTable2' style='background:" + allclr + ";'>" + qty35[i][j] + "</td>"
           + "<td class='DataTable2' style='background:" + allclr + ";'>" + qty46[i][j] + "</td>"
           + "<td class='DataTable2' style='background:" + allclr + ";'>" + qty50[i][j] + "</td>"
           + "<td class='DataTable2' style='background:" + allclr + ";'>" + qty86[i][j] + "</td>"
           + "<td class='DataTable2' style='background:" + allclr + ";'>" + qty55[i][j] + "</td>"
           + "<td class='DataTable2' style='background:" + allclr + ";'>" + qty63[i][j] + "</td>"
           + "<td class='DataTable2' style='background:" + allclr + ";'>" + qty64[i][j] + "</td>"
           + "<td class='DataTable2' style='background:" + allclr + ";'>" + qty68[i][j] + "</td>"
         + "</tr>"
    }
    panel += "<tr><td colspan=15 style='background:grey; font-size:1px; border:grey solid 2px'>&nbsp;</td></tr>"
  }

  panel += "</table>";
  return panel;
}


//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}

//==============================================================================
//chek key pressed
//==============================================================================
function chkKeyPressed(e)
{
	if (e.keyCode == 13) 
	{
     		getSkuUpc();
    }
	 onkeypress="chkKeyPressed(event)"
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>



<body onLoad="bodyLoad()" onkeypress="chkKeyPressed(event)">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->
 <table border="0" cellPadding="0"  cellSpacing="0">
  <tr>
   <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Item Search</b>
      <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
   </td>
   </td>
   <tr>
    <td align=center>
     <table border="1" class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbAddLine">
       <tr>
        <th class="DataTable" nowrap>Short Sku / UPC<br>
             <a class="Small" href="javascript: setSearch()">Search Items</a><br>
        </th>
        <th class="DataTable" nowrap>Description</th>
        <th class="DataTable" nowrap>Qty<br>in Set</th>
        <th class="DataTable" nowrap>Qty Available to<br>Sell Right Now</th>
        <th class="DataTable" nowrap>P.O.<br>Qty</th>
        <th class="DataTable" nowrap>Sales<br>Price</th>
        <th class="DataTable" nowrap>Price</th>
        <th class="DataTable" nowrap>Group/Set<br>Each</th>
        <th class="DataTable" nowrap>MSRP</th>
        <th class="DataTable" nowrap>Color<br>Name</th>
        <th class="DataTable" nowrap>Vendor<br>Name</th>
        <th class="DataTable" nowrap>Vendor<br>Sty</th>
       </tr>

      <tr  class="DataTable">
        <td class="DataTable" nowrap>
           <!-- input class="Small" type="text" name="Sku" onKeyPress="if(event.keyCode==13){ getSkuUpc() }" size=10 maxlength=10> /
           <input class="Small" type="text" name="Upc" onKeyPress="if(event.keyCode==13){ getSkuUpc() }" size=12 maxlength=12><br> -->
           
           <input class="Small" type="text" name="Sku" size=10 maxlength=10> /
           <input class="Small" type="text" name="Upc" size=15 maxlength=13><br>
        </td>
        <td class="DataTable" id="tdDesc" nowrap>&nbsp;</td>
        <td class="DataTable2" id="tdTotQty" nowrap>&nbsp;</td>
        <td class="DataTable2" style="background:yellow;" id="tdTotal" nowrap>&nbsp;</td>
        <td class="DataTable2" id="tdPOQty" nowrap>&nbsp;</td>
        <td class="DataTable1" id="tdTempPrc" nowrap>&nbsp;</td>
        <td class="DataTable1" id="tdPrice" nowrap>&nbsp;</td>
        <td class="DataTable1" id="tdGroup" nowrap>&nbsp;</td>
        <td class="DataTable1" id="tdSugPrc" nowrap>&nbsp;</td>
        <td class="DataTable" id="tdClrNm" nowrap>&nbsp;</td>
        <td class="DataTable" id="tdVenNm" nowrap>&nbsp;</td>
        <td class="DataTable" id="tdVenSty" nowrap>&nbsp;</td>
        <!-- td class="DataTable" id="tdUntPrc" nowrap>&nbsp;</td -->
      </tr>
      <tr>
      	<td class="Error" id="tdError" nowrap colspan=12>&nbsp;</td>
      </tr>
      <!-- --------------------- New Set Components ------------------------ -->
      <%for(int i=0; i < 50; i++) {%>
         <tr  class="DataTable1" id="trSet">
           <td class="DataTable" id="tdSetSku" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdSetDesc" nowrap>&nbsp;</td>
           <td class="DataTable2" id="tdSetTotQty">&nbsp;</td>
           <td class="DataTable2" id="tdSetTotal" style="background:yellow;" nowrap>&nbsp;</td>
           <td class="DataTable2" id="tdSetPOQty">&nbsp;</td>
           <td class="DataTable1" id="tdSetTempPrc" nowrap>&nbsp;</td>
           <td class="DataTable1" id="tdSetPrice" nowrap>&nbsp;</td>
           <td class="DataTable1" id="tdSetGroup" nowrap>&nbsp;</td>
           <td class="DataTable1" id="tdSetSugPrc" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdSetClrNm" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdSetVenNm" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdSetVenSty" nowrap>&nbsp;</td>
         </tr>
      <%}%>
      <!-- ------------------- End of Set Components ----------------------- -->

      <!-- --------------------- New Set Components ------------------------ -->
      <tr  class="DataTable2" id="trSetLstHdr">
         <td class="DataTable2" colspan=15>The above item is also a component in the following SETS/GROUPS.</td>
      </tr>

      <%for(int i=0; i < 200; i++) {%>
         <tr  class="DataTable2" id="trSetLst">
           <td class="DataTable" id="tdLstSku" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdLstDesc" nowrap>&nbsp;</td>
           <td class="DataTable2" id="tdLstTotQty" nowrap>&nbsp;</td>
           <td class="DataTable2" id="tdLstTotal" nowrap>&nbsp;</td>
           <td class="DataTable2" id="tdLstPOQty" nowrap>&nbsp;</td>
           <td class="DataTable1" id="tdLstTempPrc" nowrap>&nbsp;</td>
           <td class="DataTable1" id="tdLstPrice" nowrap>&nbsp;</td>
           <td class="DataTable1" id="tdLstGroup" nowrap>&nbsp;</td>
           <td class="DataTable1" id="tdLstSugPrc" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdLstClrNm" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdLstVenNm" nowrap>&nbsp;</td>
           <td class="DataTable" id="tdLstVenSty" nowrap>&nbsp;</td>
         </tr>
      <%}%>
      <!-- ------------------- End of Set Components ----------------------- -->

    </table>
      <!-- button onClick="getSkuUpc()" id="btnSearch">Search</button -->&nbsp;&nbsp;&nbsp;&nbsp;
      <button onClick="clrLine();" id="btnClear">Press Enter to Clear</button>
    </td>
  </tr>

  <!--========== Inventory by store ====================-->
  <tr>
   <td align=center><br>
      <div id="dvItem" style="width:300px"></div>
   </td>
  </tr>
  <tr>
   <td align=center><br>
      <div id="dvSet" style="width:300px"></div>
   </td>
  </tr>

  <tr>
   <td align=center><br>
    <table  border="1" class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbPoList">
       <tr>
          <th class="DataTable" nowrap>Sku</th>
          <th class="DataTable" nowrap>Str</th>
          <th class="DataTable" nowrap>P.O. #</th>
          <th class="DataTable" nowrap>Qty</th>
          <th class="DataTable" nowrap>Anticipation<br>Date</th>
       </tr>
       <tbody id="tbodyPoList">
       </tbody>
     </table>
   </td>
  </tr>

 </table>
</body>
