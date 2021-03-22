<%@ page import="ecommerce.EcomStrInvSku, java.util.*"%>
<%
//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=EcomStrInvSku.jsp");
}
else
{
    String sStrAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();
    EcomStrInvSku strinvl = new EcomStrInvSku();

    int iNumOfSku = strinvl.getNumOfSku();

    int iNumOfStr = strinvl.getNumOfStr();
    String [] sStrLst = strinvl.getStrLst();
    String sStrLstJsa = strinvl.getStrLstJsa();
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

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
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

        .Small {font-size:10px }

</style>
<script language="JavaScript1.2">
//--------------- Global variables -----------------------
var SavArg = 0;
var StrLst = [<%=sStrLstJsa%>];

var Div = new Array();
var Dpt = new Array();
var Cls = new Array();
var Ven = new Array();
var Sty = new Array();
var Clr = new Array();
var Siz = new Array();
var Sku = new Array();
var Qty = new Array();
var Price = new Array();

//--------------- End of Global variables ----------------

function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// Select / Reset all stores
//==============================================================================
function selectStr(line, action)
{
   var arg = eval(line);
   var strobjnm = "Str" + arg;
   str = document.all[strobjnm];

   for(var i=0; i < str.length; i++)
   {
      if(action == "SELECT") { str[i].checked = true; }
      else { str[i].checked = false; }
   }
}
//==============================================================================
// Validate New entered sku
//==============================================================================
function ValidateSingle(line, action)
{
   var error = false;
   var msg = "";
   var div = null;
   var dpt = null;
   var cls = null;
   var ven = null;
   var sty = null;
   var clr = null;
   var siz = null;
   var sku = null;
   var qty = null;
   var price = null;
   var note = null;

   var arg = eval(line);
   var strobjnm = "Str" + arg
   var str = new Array();
   var strnum = new Array();

   var qtyobjnm = "Qty" + arg
   qty = document.all[qtyobjnm].value.trim();
   var prcobjnm = "Price" + arg
   price = document.all[prcobjnm].value.trim();

   var noteobjnm = "Note" + arg
   note = document.all[noteobjnm].value.trim();

   arg = arg - 1;

   if(action == "ADD")
   {
     div = document.all.Div.value.trim();
     dpt = document.all.Dpt.value.trim();
     cls = document.all.Cls.value.trim();
     ven = document.all.Ven.value.trim();
     sty = document.all.Sty.value.trim();
     clr = document.all.Clr.value.trim();
     siz = document.all.Siz.value.trim();
     sku = document.all.Sku.value.trim();
   }

   else
   {
     div = Div[arg];
     dpt = Dpt[arg];
     cls = Cls[arg];
     ven = Ven[arg];
     sty = Sty[arg];
     clr = Clr[arg];
     siz = Siz[arg];
     sku = Sku[arg];
   }

   if(isNaN(div)) { msg = "Invalid Division is entered."; error = true; }
   if(isNaN(dpt)) { msg = "Invalid Department is entered."; error = true; }
   if(isNaN(cls)) { msg = "Invalid Class is entered."; error = true; }
   if(isNaN(ven)) { msg = "\nInvalid Vendor is entered."; error = true; }
   if(isNaN(sty)) { msg = "\nInvalid Style is entered."; error = true; }
   if(isNaN(clr)) { msg = "\nInvalid Color is entered."; error = true; }
   if(isNaN(siz)) { msg = "\nInvalid Size is entered."; error = true; }
   if(isNaN(sku)) { msg = "\nInvalid SKU is entered."; error = true; }
   if(isNaN(qty)) { msg = "\nInvalid Quantity is entered."; error = true; }
   if(isNaN(price)) { msg = "\nInvalid Price is entered."; error = true; }

   if(!error)
   {
      if(div == "" && dpt == "" && cls == "" && ven == "" && sty == "" && clr == "" && siz == "" && sku == "")
      {
         msg = "\nPlease enter at least 1 category."; error = true;
      }
   }

   // populate seleted stores in array
   if(action != "DLT"){ str = document.all[strobjnm]; }

   for(var i=0, j=0; i < str.length; i++)
   {
      if (str[i].checked)
      {
         strnum[j] = str[i].value.trim();
         j++
      }
   }

   if(action != "DLT" && strnum.length == 0){ msg += "\nAt least 1 store must be selected."; error = true;}

   if(error){ alert(msg) }
   else
   {
      sbmSingleSku( div, dpt, cls, ven, sty, clr, siz, sku, qty, price, strnum, note, action);
   }
}

//==============================================================================
// submit single Item
//==============================================================================
function sbmSingleSku(div, dpt, cls, ven, sty, clr, siz, sku, qty, price, strnum, note, action)
{
   var url = "EcomStrInvSkuSv.jsp?"
       + "Div=" + div
       + "&Dpt=" + dpt
       + "&Cls=" + cls
       + "&Ven=" + ven
       + "&Sty=" + sty
       + "&Clr=" + clr
       + "&Siz=" + siz
       + "&Sku=" + sku
       + "&Qty=" + qty
       + "&Price=" + price

   for(var i=0; i <  strnum.length; i++) { url += "&Str=" + strnum[i]}

   url += "&Note=" + note
        + "&Action=" + action;

   //alert(url);
   //window.location.href = url;
   window.frame1.location.href = url;
}

//==============================================================================
// display entry error
//==============================================================================
function displayError(err)
{
   msg = "";
   for(var i=0; i < err.length; i++)
   {
      msg = "\n" + err[i];
   }

   if(msg != ""){ alert(msg); }
}
//==============================================================================
// reload page
//==============================================================================
function reload()
{
  window.location.reload();
}
//==============================================================================
// change color for updated lines
//==============================================================================
function chgColor(obj)
{
   obj.style.background = "yellow"

   // position menu on the screen
   while (obj.offsetParent)
   {
       if (obj.tagName.toLowerCase() == "td"){ break; }
       obj = obj.offsetParent;
    }

    var trName = "trSku" + obj.id.substring(5);
    document.all[trName].style.background = "pink"
}

//==============================================================================
// hilight line
//==============================================================================
function hiliLine(obj)
{
   var color = "#ececec";
   if(obj.style.background != "yellow")
   {
      color = "yellow";
   }
   obj.style.background = color;
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">

<!----------------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!----------------------------------------------------------------------------->

<form action="mailto:vrozen@retailconcepts.cc" method="post" enctype="application/vnd.ms-excel" >
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Included Store Inventory
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" id="tbSku" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan=2>Div</th>
          <th class="DataTable" rowspan=2>Dpt</th>
          <th class="DataTable" rowspan=2>Class</th>
          <th class="DataTable" rowspan=2>Vendor</th>
          <th class="DataTable" rowspan=2>Style</th>
          <th class="DataTable" rowspan=2>Color</th>
          <th class="DataTable" rowspan=2>Size</th>
          <th class="DataTable" rowspan=2>Short<br>SKU</th>
          <th class="DataTable" rowspan=2>Notes</th>
          <th class="DataTable" rowspan=2>Add<br>Upd</th>
          <th class="DataTable" rowspan=2>D<br>l<br>t</th>
          <th class="DataTable" colspan="<%=iNumOfStr%>">Store</th>
          <th class="DataTable" rowspan=2>Minimum<br>Qty</th>
          <th class="DataTable" rowspan=2>Minimum<br>Price</th>
          <th class="DataTable" rowspan=2 nowrap>Select All,<br>Reset All<br>Store</th>
        </tr>
        <tr>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <th class="DataTable"><%=sStrLst[i]%></th>
          <%}%>
        </tr>
<!------------------------------- New SKU Line -------------------------------->
        <tr class="DataTable" id="trItem">
           <td class="DataTable2"><input name="Div" class="Small" maxlength=2 size=2></td>
           <td class="DataTable2"><input name="Dpt" class="Small" maxlength=3 size=3></td>
           <td class="DataTable2"><input name="Cls" class="Small" maxlength=4 size=4></td>
           <td class="DataTable2"><input name="Ven" class="Small" maxlength=5 size=5></td>
           <td class="DataTable2"><input name="Sty" class="Small" maxlength=4 size=4></td>
           <td class="DataTable2"><input name="Clr" class="Small" maxlength=3 size=3></td>
           <td class="DataTable2"><input name="Siz" class="Small" maxlength=4 size=4></td>
           <td class="DataTable2"><input name="Sku" class="Small" maxlength=10 size=10></td>
           <td class="DataTable2"><input name="Note0" class="Small" maxlength=256 size=25></td>

           <td class="DataTable"><a class="Small" href="javascript: ValidateSingle('0', 'ADD')">A</a></td>
           <td class="DataTable">&nbsp;</td>

              <%for(int i=0; i < iNumOfStr; i++){%>
                <td class="DataTable2"><input name="Str0" type=checkbox class="Small" value="<%=sStrLst[i]%>"></td>
           <%}%>

           <td class="DataTable2"><input name="Qty0" class="Small" maxlength=10 size=10></td>
           <td class="DataTable2"><input name="Price0" class="Small" maxlength=10 size=10></td>

           <td class="DataTable"  nowrap>
              <a class="Small" href="javascript: selectStr('0', 'SELECT')">All</a> &nbsp;  &nbsp;  &nbsp;
              <a class="Small" href="javascript: selectStr('0', 'RESET')">Reset</a>
            </td>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfSku; i++){
               strinvl.setSkuFromStore();
               String sDiv = strinvl.getDiv();
               String sDpt = strinvl.getDpt();
               String sCls = strinvl.getCls();
               String sVen = strinvl.getVen();
               String sSty = strinvl.getSty();
               String sClr = strinvl.getClr();
               String sSiz = strinvl.getSiz();
               String sSku = strinvl.getSku();
               String sQty = strinvl.getQty();
               String sPrice = strinvl.getPrice();
               String [] sStr = strinvl.getStr();
               String sNote = strinvl.getNote();
           %>
              <tr class="DataTable" id="trSku<%=i%>" onclick="hiliLine(this)">
                <td class="DataTable2" >&nbsp;<%=sDiv%></td>
                <td class="DataTable2" >&nbsp;<%=sDpt%></td>
                <td class="DataTable2" >&nbsp;<%=sCls%></td>
                <td class="DataTable2">&nbsp;<%=sVen%></td>
                <td class="DataTable2">&nbsp;<%=sSty%></td>
                <td class="DataTable2">&nbsp;<%=sClr%></td>
                <td class="DataTable2">&nbsp;<%=sSiz%></td>
                <td class="DataTable2">&nbsp;<%=sSku%></td>
                <td class="DataTable2"><input name="Note<%=i+1%>" value="<%=sNote%>" class="Small" maxlength=256 size=25></td>

                <td class="DataTable"><a class="Small" href="javascript: ValidateSingle('<%=i+1%>', 'UPD')">U</a></td>
                <td class="DataTable"><a class="Small" href="javascript: ValidateSingle('<%=i+1%>', 'DLT')">D</a></td>

                <%for(int j=0; j < iNumOfStr; j++){%>
                   <td class="DataTable2" id="tdSku<%=i%>"><input name="Str<%=i+1%>" onClick="chgColor(this)" type=checkbox value="<%=sStrLst[j]%>"
                      <%if(sStr[j].equals("1")){%>checked<%}%>>
                   </td>
                <%}%>

                <td class="DataTable2"><input name="Qty<%=i+1%>" value="<%=sQty%>" class="Small" maxlength=10 size=10></td>
                <td class="DataTable2"><input name="Price<%=i+1%>" value="<%=sPrice%>" class="Small" maxlength=10 size=10></td>

                <td class="DataTable">
                   <a class="Small" href="javascript: selectStr('<%=i+1%>', 'SELECT')">All</a> &nbsp;  &nbsp;  &nbsp;
                   <a class="Small" href="javascript: selectStr('<%=i+1%>', 'RESET')">Reset</a>
                </td>

                <script language="JavaScript">
                 Div[<%=i%>] = "<%=sDiv%>";
                 Dpt[<%=i%>] = "<%=sDpt%>";
                 Cls[<%=i%>] = "<%=sCls%>";
                 Ven[<%=i%>] = "<%=sVen%>";
                 Sty[<%=i%>] = "<%=sSty%>";
                 Clr[<%=i%>] = "<%=sClr%>";
                 Siz[<%=i%>] = "<%=sSiz%>";
                 Sku[<%=i%>] = "<%=sSku%>";
                 Qty[<%=i%>] = "<%=sQty%>";
                 Price[<%=i%>] = "<%=sPrice%>";
                </script>

              </tr>
           <%}%>
      </table>
     </td>
    </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </form>
 </body>
</html>


<%
strinvl.disconnect();
strinvl = null;
}%>