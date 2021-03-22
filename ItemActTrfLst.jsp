<%@ page import="java.util.*,  itemtransfer.ItemActTrfLst"%>
<%
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemActTrfLst.jsp&APPL=ALL");
   }
   else
   {
      ItemActTrfLst scntrf = new ItemActTrfLst(sStore, session.getAttribute("USER").toString());
      int iNumOfItm = scntrf.getNumOfItm();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}
  a.Small:link { color:blue;  font-size:10px;} a.Small:visited { color:purple; font-size:10px;}  a.Small:hover { color:darkblue; font-size:10px;}

  table.DataTable { border: gray solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: gray solid 1px; border-right: gray solid 1px;}

  tr.DataTable1 { background:#e7e7e7; text-align:left; font-size:10px;}
  tr.Break { background:#FFCC99; font-family:Verdanda; text-align:center; font-size:10px;}

  td.DataTable { border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable2 { border-bottom: gray solid 1px; border-right: gray solid 1px; text-align:center;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}

  td.Break {border-bottom: gray solid 1px; border-right: gray solid 2px;}


  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px }


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  .Small1{ text-align:center; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Store = "<%=sStore%>";
var NumOfItm = <%=iNumOfItm%>
var Carton = new Array(NumOfItm);
var Cls = new Array(NumOfItm);
var Ven = new Array(NumOfItm);
var Sty = new Array(NumOfItm);
var Clr = new Array(NumOfItm);
var Siz = new Array(NumOfItm);
var Desc = new Array(NumOfItm);
var Seq = new Array(NumOfItm);
var Qty = new Array(NumOfItm);

var NewQty = null;
var SelItem = null;
var Action = null;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
}
//==============================================================================
// show Item change panel
//==============================================================================
function chgItem(i)
{
   SelItem = i;
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Item: " + Cls[i] + "-" + Ven[i] + "-" + Sty[i] + "-" + Clr[i] + "-" + Siz[i] + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popItemPanel(i)+ "</td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvPrompt.style.visibility = "visible";

   // populate current quantity
   document.all.Qty.value = Qty[i];
   document.all.Qty.select();
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popItemPanel(i)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Description
  panel += "<tr><td class='Prompt2' nowrap>Item Description:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' colspan=2>" + Desc[i] + "</td></tr>";
  // Store
  panel += "<tr><td class='Prompt2' nowrap>Quantity:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><input name='Qty' size=5 maxlength=5></td>"
         + "</tr>";

  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='Validate(" + i + ")' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//==============================================================================
// get object coordinats
//==============================================================================
function getPosition(obj)
{
   var pos = [0, 0];

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
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.style.visibility = "hidden";
   SelItem = null;
   NewQty = null;
}
//==============================================================================
// delete item from transfer file
//==============================================================================
function dltItem(i)
{
   if (confirm('Please confirm that record must be deleted?'))
   {
      SelItem = i;
      Submit(i, 0, "DELETE")
   }
}
//--------------------------------------------------------
// Validate entry
//--------------------------------------------------------
function Validate(i)
{
   var error=false;
   var msg = "";
   var action = "UPDQTY";

   var qty = document.all.Qty.value.trim();
   if(isNaN(qty)){ error = true; msg="Quantity must be numeric.";}

   if(error){ alert(msg) }
   else(Submit(i, qty, action))
}
//--------------------------------------------------------
// submit changes
//--------------------------------------------------------
function Submit(i, qty, action)
{
   NewQty = qty;
   Action = action;
   url = "ItemActTrfSave.jsp?"
       + "Str=" + Store
       + "&Tran=" + Carton[i]
       + "&Cls=" + Cls[i]
       + "&Ven=" + Ven[i]
       + "&Sty=" + Sty[i]
       + "&Clr=" + Clr[i]
       + "&Siz=" + Siz[i]
       + "&Seq=" + Seq[i]
       + "&Qty=" + qty
       + "&Action=" + action

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}
//==============================================================================
// update line with new quantity
//==============================================================================
function updateLine(err)
{
   if(err){ alert("Error Occured! Item is not update.") }
   else
   {
      if (Action == "UPDQTY")
      {
         var cell = "tdQty" + SelItem;
         document.all[cell].innerHTML = NewQty;
      }
      else if(Action == "DELETE")
      {
         var row = "trItem" + SelItem;
         //document.all.dvTop.removeChild(table1);
         var tbd = document.all.tbdItem;
         var rowo = document.all[row];
         tbd.removeChild(rowo);
      }
   }
   hidePanel();
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Scanner Item Transfers
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;&#62
        <a href="ItemActTrfLstSel.jsp"><font color="red" size="-1">Selection</font></a>;&#62
        <font size="-1">This page</font>
        <!----------------- start of ad table ------------------------>
         <table id="tblItem" class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" >D<br>l<br>t</th>
               <th class="DataTable" >Carton<br>Number</th>
               <th class="DataTable" >Div</th>
               <th class="DataTable" >Dpt</th>
               <th class="DataTable" >Item Long SKU</th>
               <th class="DataTable" >Description</th>
               <th class="DataTable" >Qty</th>
               <th class="DataTable" >Ext<br>Ret</th>
               <th class="DataTable" >Dest<br>Store</th>
               <th class="DataTable" >Short SKU</th>
               <th class="DataTable" >UPC</th>
               <th class="DataTable" >Vendor<br>Style</th>
               <th class="DataTable" >Vendor<br>Name</th>
               <th class="DataTable" >Transfer<br>Date</th>
               <th class="DataTable" >Approved</th>
               <th class="DataTable" >Reason</th>
               <th class="DataTable" >Recall<br>Number</th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody id="tbdItem">
        <%
        for(int i=0; i < iNumOfItm; i++)
        {
          scntrf.setItmList();
          String sDiv = scntrf.getDiv();
          String sDpt = scntrf.getDpt();
          String sCls = scntrf.getCls();
          String sVen = scntrf.getVen();
          String sSty = scntrf.getSty();
          String sClr = scntrf.getClr();
          String sSiz = scntrf.getSiz();
          String sSku = scntrf.getSku();
          String sUpc = scntrf.getUpc();
          String sDesc = scntrf.getDesc();
          String sVenSty = scntrf.getVenSty();
          String sVenName = scntrf.getVenName();
          String sTrfDate = scntrf.getTrfDate();
          String sQty = scntrf.getQty();
          String sRet = scntrf.getRet();
          String sDstStr = scntrf.getDstStr();
          String sApproved = scntrf.getApproved();
          String sReason = scntrf.getReason();
          String sRecall = scntrf.getRecall();
          String sCarton = scntrf.getCarton();
          String sTrnType = scntrf.getTrnType();
          String sTrnSeq = scntrf.getTrnSeq();
        %>
            <tr id="trItem<%=i%>" class="DataTable1">
               <th class="DataTable" nowrap>
                 <a class="Small" href="javascript: dltItem(<%=i%>)">D</a></th>
               <td class="DataTable2"><%=sCarton%></td>
               <td class="DataTable2"><%=sDiv%></td>
               <td class="DataTable2"><%=sDpt%></td>
               <td class="DataTable2" nowrap>
                    <a class="Small" href="javascript: chgItem(<%=i%>)">
                    <%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></a></td>
               <td class="DataTable2" nowrap><%=sDesc%></td>
               <td id="tdQty<%=i%>" class="DataTable2" nowrap><%=sQty%></td>
               <td class="DataTable2" nowrap><%=sRet%></td>
               <td class="DataTable2" nowrap><%=sDstStr%></td>
               <td class="DataTable2"><%=sSku%></td>
               <td class="DataTable2"><%=sUpc%></td>
               <td class="DataTable2"><%=sVenSty%></td>
               <td class="DataTable2" nowrap><%=sVenName%></td>
               <td class="DataTable2"><%=sTrfDate%></td>
               <td class="DataTable2"><%=sApproved%>&nbsp;</td>
               <td class="DataTable2"><%=sReason%></td>
               <td class="DataTable2"><%=sRecall%>&nbsp;</td>
               <script>Carton["<%=i%>"] = "<%=sCarton%>"; Cls["<%=i%>"] = "<%=sCls%>";Ven["<%=i%>"] = "<%=sVen%>";Sty["<%=i%>"] = "<%=sSty%>";Clr["<%=i%>"] = "<%=sClr%>";Siz["<%=i%>"] = "<%=sSiz%>";Qty["<%=i%>"] = "<%=sQty%>";Desc["<%=i%>"] = "<%=sDesc%>";
                       Seq["<%=i%>"] = "<%=sTrnSeq%>";</script>
            </tr>
          <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>

<%
    scntrf.disconnect();
    scntrf = null;
  }
%>