<%@ page import="ecommerce.EcShopReadyOrdLst, java.util.*, java.sql.*"%>
<%
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String [] sSelSts = request.getParameterValues("Sts");
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=EcShopReadyOrdDtl.jsp&APPL=ALL");
}
else
{
   String sUser = session.getAttribute("USER").toString();
   EcShopReadyOrdLst readyordl = new EcShopReadyOrdLst(sFrDate, sToDate, sSelSts, sUser);
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:10px;  vertical-align:top;}
        tr.DataTable1 { background: gold; font-size:12px;}
        tr.DataTable2 { background: lightgreen; font-size:12px;}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px; font-family: Arial }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        th.Prompt { text-align:center; vertical-align:middle; font-family:Arial; font-size:11px; }
        td.Prompt { text-align:left; vertical-align:middle; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:middle; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:middle; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>
<script language="javascript">

var Order = null;

//==============================================================================
// initialize
//==============================================================================
function bodyload()
{
}
//==============================================================================
// show order details
//==============================================================================
function  rtvOrdDtl(ordid)
{
   Order = ordid;
   url = "EcShopReadyOrdDtl.jsp?Order=" + ordid;
   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//==============================================================================
// show order details
//==============================================================================
function showItems(item, qty, price, part, cls, ven, sty, clr, siz, venSty, name)
{
   var hdr = "Order: " + Order + ".  Item List."

    var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popItemList(item, qty, price, part, cls, ven, sty, clr, siz, venSty, name)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate item panel
//==============================================================================
function popItemList(item, qty, price, part, cls, ven, sty, clr, siz, venSty, name)
{
   var dummy = "<table>";
   var panel = "<table border=1 width='100%' cellPadding='3' cellSpacing='0'>"
   panel += "<tr>"
             + "<th class='Prompt'>Item</th>"
             + "<th class='Prompt'>Qty</th>"
             + "<th class='Prompt'>Price</th>"
             + "<th class='Prompt'>Part</th>"

             + "<th class='Prompt'>&nbsp;</th>"

             + "<th class='Prompt'>Long Item Number</th>"
             + "<th class='Prompt'>Vendor<br>Style</th>"
             + "<th class='Prompt'>Volusion<br>Name</th>"
             + "<th class='Prompt'>S<br>a<br>v<br>e</th>"
          + "</tr>"

   for(var i=0; i < item.length; i++)
   {
      panel += "<tr>"
             + "<td class='Prompt' id='tdItem" + i + "'>" + item[i] + "</td>"
             + "<td class='Prompt2'>" + qty[i] + "</td>"
             + "<td class='Prompt2'>" + price[i] + "</td>"
             + "<td class='Prompt2'>" + part[i] + "</td>"

             + "<th class='Prompt'>&nbsp;</th>"

      if(cls[i] != "0000")
      {
          panel += "<td class='Prompt2' nowrap><input class='small' name='Cls" + i + "' value='"+ cls[i] + "' maxlength=4 size=4>"
               + "-<input class='small' name='Ven" + i + "' value='"+ ven[i] + "' maxlength=5 size=5>"
               + "-<input class='small' name='Sty" + i + "' value='"+ sty[i] + "' maxlength=4 size=4>"
               + "-<input class='small' name='Clr" + i + "' value='"+ clr[i] + "' maxlength=3 size=3>"
               + "-<input class='small' name='Siz" + i + "' value='"+ siz[i] + "' maxlength=4 size=4>"
             + "</td>"

          panel += "<td class='Prompt' nowrap>" + venSty[i] + "</td>"
             + "<td class='Prompt' nowrap>" + name[i] + "</td>"
      }
      else
      {
          panel += "<td class='Prompt2' nowrap><input class='small' name='Cls" + i + "' maxlength=4 size=4>"
               + "-<input class='small' name='Ven" + i + "' maxlength=5 size=5>"
               + "-<input class='small' name='Sty" + i + "' maxlength=4 size=4>"
               + "-<input class='small' name='Clr" + i + "' maxlength=3 size=3>"
               + "-<input class='small' name='Siz" + i + "' maxlength=4 size=4>"
             + "</td>"
          panel += "<td class='Prompt2'>&nbsp;</td>"
             + "<td class='Prompt2'>&nbsp;</td>"
      }
      panel += "<td class='Prompt2'><a href='javascript:saveItem(&#34;" +  i + "&#34;)'>S</a></td>"
             + "</tr>"
   }

   panel += "<tr><td class='Prompt1' colspan=13>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

   panel += "</table>";

  return panel;
}

//==============================================================================
// validate item long number and submit to save
//==============================================================================
function saveItem(arg)
{
   var error = false;
   var msg = "";

   var itemnm = "tdItem" + arg;
   var clsnm = "Cls" + arg;
   var vennm = "Ven" + arg;
   var stynm = "Sty" + arg;
   var clrnm = "Clr" + arg;
   var siznm = "Siz" + arg;

   var item = document.all[itemnm].innerHTML.trim();
   var cls = document.all[clsnm].value.trim();
   var ven = document.all[vennm].value.trim();
   var sty = document.all[stynm].value.trim();
   var clr = document.all[clrnm].value.trim();
   var siz = document.all[siznm].value.trim();

   if(isNaN(cls) || eval(cls) == 0){ error = true; msg += "\nClass is not entered or invalid."; }
   if(isNaN(ven) || eval(ven) == 0){ error = true; msg += "\nVendor is not entered or invalid."; }
   if(isNaN(sty) || eval(sty) == 0){ error = true; msg += "\nStyle is not entered or invalid."; }
   if(isNaN(clr) || eval(clr) == 0){ error = true; msg += "\nColor is not entered or invalid."; }
   if(isNaN(siz)){ error = true; msg += "\nSize is not entered or invalid."; }

   if(error) { alert(msg)}
   else
   {
      var url = "EcShopReadyOrdItemSave.jsp?"
        + "Order=" + Order
        + "&Item=" + item
        + "&Cls=" + cls
        + "&Ven=" + ven
        + "&Sty=" + sty
        + "&Clr=" + clr
        + "&Siz=" + siz

      window.frame1.location.href = url;
   }
}
//==============================================================================
// item saving result
//==============================================================================
function saveItemsResult(error)
{
   if ( error != "" ){ alert(error) }
   else { rtvOrdDtl(Order ) }
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>


<body onload="bodyload()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>E-Commerce Shopotron Todays Orders</b>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Order<br>#</th>
          <th class="DataTable" >Order<br>Date</th>
          <th class="DataTable" >Mfg<br>Id</th>
          <th class="DataTable" >Categ Id<br></th>
          <th class="DataTable" >Recipient<br></th>
          <th class="DataTable" >Address</th>
          <th class="DataTable" >Phone</th>
          <th class="DataTable" >Subtotal</th>
          <th class="DataTable" >Tax</th>
          <th class="DataTable" >Total</th>
          <th class="DataTable" >Pack<br>Fee</th>
          <th class="DataTable" >In<br>Store<br>Pickup</th>
          <th class="DataTable" >Ship<br>Type</th>
          <th class="DataTable" >Number of Item</th>
          <th class="DataTable" >Status</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
     <%while(readyordl.getNext()){
         readyordl.getShopOrd();
         int iNumOfOrd = readyordl.getNumOfOrd();
         String [] sOrd = readyordl.getOrd();
         String [] sOrdDt = readyordl.getOrdDt();
         String [] sMfgId = readyordl.getMfgId();
         String [] sCatId = readyordl.getCatId();
         String [] sFName = readyordl.getFName();
         String [] sLName = readyordl.getLName();
         String [] sRecipient = readyordl.getRecipient();
         String [] sAddr1 = readyordl.getAddr1();
         String [] sAddr2 = readyordl.getAddr2();
         String [] sAddr3 = readyordl.getAddr3();
         String [] sCity = readyordl.getCity();
         String [] sState = readyordl.getState();
         String [] sZip = readyordl.getZip();
         String [] sCountry = readyordl.getCountry();
         String [] sPhone = readyordl.getPhone();
         String [] sSubTot = readyordl.getSubTot();
         String [] sTax = readyordl.getTax();
         String [] sTotal = readyordl.getTotal();
         String [] sPackFee = readyordl.getPackFee();
         String [] sInStrPup = readyordl.getInStrPup();
         String [] sShipType = readyordl.getShipType();
         String [] sNumItem = readyordl.getNumItem();
         String [] sSts = readyordl.getSts();
         %>

         <%for(int i=0; i < iNumOfOrd; i++){%>
           <tr class="DataTable" id="trOrd">
             <td class="DataTable1"><a href="javascript: rtvOrdDtl('<%=sOrd[i]%>')"><%=sOrd[i]%></a></td>
             <td class="DataTable1"><%=sOrdDt[i]%></td>
             <td class="DataTable1">&nbsp;<%=sMfgId[i]%></td>
             <td class="DataTable1">&nbsp;<%=sCatId[i]%></td>
             <td class="DataTable1"><%=sFName[i]%> <%=sLName[i]%></td>
             <td class="DataTable1"><%=sAddr1[i]%> <%=sAddr2[i]%> <%=sAddr3[i]%>,
                 <%=sCity[i]%>, <%=sState[i]%>, <%=sZip[i]%><%if(!sCountry[i].trim().equals("")){%>, <%=sCountry[i]%><%}%> </td>
             <td class="DataTable1">&nbsp;<%=sPhone[i]%></td>
             <td class="DataTable2">&nbsp;<%=sSubTot[i]%></td>
             <td class="DataTable2">&nbsp;<%=sTax[i]%></td>
             <td class="DataTable2">&nbsp;<%=sTotal[i]%></td>
             <td class="DataTable2">&nbsp;<%=sPackFee[i]%></td>
             <td class="DataTable1">&nbsp;<%=sInStrPup[i]%></td>
             <td class="DataTable1">&nbsp;<%=sShipType[i]%></td>
             <td class="DataTable1">&nbsp;<%=sNumItem[i]%></td>
             <td class="DataTable1">&nbsp;<%=sSts[i]%></td>
           </tr>
         <%}%>
      <%}%>
      <!------------------------ End Details ---------------------------------->
   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%
  readyordl.disconnect();
  readyordl = null;
  }
%>
