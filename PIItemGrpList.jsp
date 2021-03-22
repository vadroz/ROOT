<%@ page import="inventoryreports.PIItemGrpList, java.util.*"%>
<%
//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=PIItemGrpList.jsp");
}
else
{
    String sStrAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();
    PIItemGrpList piitmg = new PIItemGrpList(sUser);

    int iNumOfItm = piitmg.getNumOfItm();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;text-align:center;}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#ececec; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        .Small {font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;border: black solid 2px; width:200; background-color:#ccffcc; z-index:10;text-align:center; font-size:12px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
    .Small {margin-top:3px; font-size:10px }

</style>
<script language="JavaScript1.2">
var SavArg = 0;

var Cls = new Array();
var Ven = new Array();
var Sty = new Array();
var Clr = new Array();
var Siz = new Array();
var OnHand = new Array();
var Transit = new Array();
var ActOnh = new Array();
var Net = new Array();

//--------------- Global variables -----------------------

//--------------- End of Global variables ----------------
function bodyLoad()
{
}
//==============================================================================
// calculate Adjustment Quantity
//==============================================================================
function calcAdjQty()
{
   var adjqty = document.all.AdjOnh;
   var tdadj = document.all.tdAdj;

   for(var i=0; i < OnHand.length; i++)
   {
      if(!isNaN(adjqty[i].value.trim()) && adjqty[i].value.trim() != "")
      {
         tdadj[i].innerHTML = eval(adjqty[i].value.trim()) - eval(Net[i]);
      }
      else
      {
         tdadj[i].innerHTML = "&nbsp;"
      }
   }
}

//==============================================================================
// calculate Adjustment Quantity
//==============================================================================
function Validate()
{
   var error = false;

   var adjqty = document.all.AdjOnh;
   var tdnet = document.all.tdNet;
   ActOnh = new Array();

   for(var i=0; i < OnHand.length; i++)
   {
      if(adjqty[i].value.trim() != "" && isNaN(adjqty[i].value.trim()))
      {
         tdadj[i].innerHTML = "Error"; error = true;
      }
      else { ActOnh[i] = adjqty[i].value.trim(); }
   }
   if(error){ alert("Invalid quantity entered in 'Actual on hand' column") }
   else
   {
      //document.all.SbmCount.disabled = true;
      document.all.ClcAdj.disabled = true;
      document.all.MailCount.disabled = true;
      sbmSaveAll();
   }
}
//==============================================================================
// submit save item count
//==============================================================================
function sbmSaveAll()
{
   SavArg = 0;
   sendNext();
}
//==============================================================================
// submit single Item
//==============================================================================
function sendNext()
{
   if (SavArg < Cls.length)
   {
     var url = "PIItemAdjCountSv.jsp?"
       + "Cls=" + Cls[SavArg]
       + "&Ven=" + Ven[SavArg]
       + "&Sty=" + Sty[SavArg]
       + "&Clr=" + Clr[SavArg]
       + "&Siz=" + Siz[SavArg]
       + "&OnHand=" + OnHand[SavArg]
       + "&Transit=" + Transit[SavArg]
       + "&ActOnh=" + ActOnh[SavArg]
       + "&Action=SAVE";


     //window.location.href = url;
     window.frame1.location.href = url;
   }
   else
   {
      var url = "PIItemAdjCountSv.jsp?" + "Action=SEND";
      window.frame1.location.href = url;
      window.status="Wait to send and clear page!"
      sleep(25000)
      window.location.reload();
   }

   SavArg++;
}
//==============================================================================
// submit EMail item counts
//==============================================================================
function sbmMail()
{
    var answer = confirm(
        "I have verified that the Actual On-Hand quantities entered are correct and agree that the"
        + "\nadjustments should be applied to my inventory.  I understand that the shrink or swell"
        + "\ncaused by these adjustments will be incorporated into my end-of-year total shrink amount."
        + "\n\nAlso, I have verified that the In-Transit Quantities have not yet been received in my store"
        + "\nand were not included in our counts.")
      if (answer)
      {
        Validate();
      }
}
//==============================================================================
// get transection detailed
//==============================================================================
function getTransDtl(str, sku)
{
  var url = "InvLUpItemPending.jsp?Sku=" + sku + "&#38;Str=" + str;
  //window.location.href = url;
  window.frame1.location.href = url;
}
//==============================================================================
// sleep
//==============================================================================
function sleep(milliSeconds)
{
   var startTime = new Date().getTime(); // get the current time
   while (new Date().getTime() < startTime + milliSeconds); // hog cpu
}

//==============================================================================
// Show shipped quantity and date
//==============================================================================
function showShipped(sku, str, allTran, allShip, max, shipQty, shipDate, picked)
{
  var html =  "<table border='1' style='font-size:12px; width:100%; ' cellPadding='1' cellSpacing='1' >"
   + "<tr style='background: blue;color:white;' >"
     + "<td  colspan=2 style='font-weight:bolder; text-align:center;' >"
     + " SKU:" + sku + "  Store " + str
     + "</td>"
   + "</tr>"

   + "<tr style='background: #ccccff;' >"
     + "<th>" + "Category" + "</th>"
     + "<th>" + "Quantity" + "</th>"
   + "</tr>"

   + "<tr>"
     + "<td>" + "All In-Transit" + "</td>"
     + "<td style='text-align:right' >" + allTran + "</td>"
   + "</tr>"

   + "<tr>"
     + "<td>" + "DC Processing" + "</td>"
     + "<td style='text-align:right' >" + picked + "</td>"
   + "</tr>"

   + "<tr>"
     + "<td>" + "Already Shipped Quantity" + "</td>"
     + "<td style='text-align:right' >" + allShip + "</td>"
   + "</tr>"

   + "<tr style='background: #ccccff;' >"
     + "<th colspan='2' >" + "Ship Date(s)" + "</th>"
   + "</tr>"

   for(var i=0; i < max; i++)
   {

      html += "<tr>"
              + "<td style='text-align:center' >" + shipDate[i] + "</td>"
              + "<td style='text-align:right' >" + shipQty[i] + "</td>"
           + "</tr>"
   }

   html += "<tr>"
           + "<td style='text-align:center;' colspan=2 >" + "<button style='font-size:10px;' onClick='hidePanel()'> Close </button>" + "<td>"
        + "</tr>"
  + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
  document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">

<form action="mailto:vrozen@retailconcepts.cc" method="post" enctype="application/vnd.ms-excel" >
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin" style="position: relative; top: expression(this.offsetParent.scrollTop);">
<!-------------------------------------------------------------------->
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Inventory Adjustment - Count Entry
      <br>Store: <%=sStrAllowed%>
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp;
    </tr>
    <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
       <thead>
        <tr style="position: relative; top: expression(this.offsetParent.scrollTop);">
	  <th class="DataTable">Item Number</th>
          <th class="DataTable">Short<br>SKU</th>
          <th class="DataTable">Color<br>Name</th>
          <th class="DataTable">Size<br>Name</th>
          <th class="DataTable">Vendor<br>Name</th>
          <th class="DataTable">Description</th>
          <th class="DataTable">On Hand</th>
          <th class="DataTable">In Transit</th>
          <th class="DataTable">Net</th>
          <th class="DataTable">Actual<br>On Hand</th>
          <th class="DataTable">Adj<br>Qty</th>
        </tr>
       </thead>
       <tbody style="overflow: auto">
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++)
             {
               piitmg.setItemProperty();
               String sCls = piitmg.getCls();
               String sVen = piitmg.getVen();
               String sVenNm = piitmg.getVenNm();
               String sSty = piitmg.getSty();
               String sClr = piitmg.getClr();
               String sClrNm = piitmg.getClrNm();
               String sSiz = piitmg.getSiz();
               String sSizNm = piitmg.getSizNm();
               String sSku = piitmg.getSku();
               String sDesc = piitmg.getDesc();
               String sOnHand = piitmg.getOnHand();
               String sActOnh = piitmg.getActOnh();
               String sTransit = piitmg.getTransit();
               String sNet = piitmg.getNet();
           %>
              <tr class="DataTable" id="trItem">
                <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
                <td class="DataTable"><%=sSku%></td>
                <td class="DataTable1"><%=sClrNm%></td>
                <td class="DataTable1"><%=sSizNm%></td>
                <td class="DataTable1"><%=sVenNm%></td>
                <td class="DataTable1" nowrap><%=sDesc%></td>
                <td class="DataTable2" id="tdOnHand"><%=sOnHand%></td>
                <td class="DataTable2" id="tdTransit"><a href="javascript: getTransDtl('1', '<%=sSku%>')"><%=sTransit%></a></td>
                <td class="DataTable2" id="tdNet"><%=sNet%></td>
                <td class="DataTable2">
                  <input class="Small" name="AdjOnh" value="<%=sActOnh%>" maxlength=5 size=5>
                </td>
                <td class="DataTable2" id="tdAdj">&nbsp;</td>
                <script language="JavaScript">
                 Cls[<%=i%>] = "<%=sCls%>"; Ven[<%=i%>] = "<%=sVen%>";  Sty[<%=i%>] = "<%=sSty%>";
                 Clr[<%=i%>] = "<%=sClr%>"; Siz[<%=i%>] = "<%=sSiz%>";
                 OnHand[<%=i%>] = "<%=sOnHand%>"; Transit[<%=i%>] = "<%=sTransit%>";
                 Net[<%=i%>] = "<%=sNet%>";
                </script>

              </tr>
           <%}%>
        </tbody>
      </table>
      <button id="ClcAdj" class="Small" onClick="calcAdjQty()">Calculate</button>
      <!-- button id="SbmCount"  class="Small" onClick="Validate()">Save</button -->
      <button id="MailCount" class="Small" onClick="sbmMail()">Finalize <br>&amp;<br>Email</button>
     </td>
    </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </form>

<!-- ======================================================================= -->
<div id="dvItem" class="dvItem"></div>
<!-- ======================================================================= -->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-- ======================================================================= -->


 </body>
</html>


<%
piitmg.disconnect();
piitmg = null;
}%>