<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sUser = null;
//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=ItemAvailSel.jsp");
}
else
{
   sUser = session.getAttribute("USER").toString();
   //StrSelect = new StoreSelect(10);
   StrSelect = new StoreSelect(5);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>
<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>


<script name="javascript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var User = "<%=sUser%>";
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   doStrSelect();
}

//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    for (idx = 1; idx < stores.length; idx++)
    {
      df.Store.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
    document.all.Store.selectedIndex=0;
}

//==============================================================================
// change action on submit
//==============================================================================
function validate()
{
   var error =false;
   var msg = "";

   var str = document.all.Store.options[document.all.Store.selectedIndex].value;
   var cls = document.all.Cls.value.trim();
   var ven = document.all.Ven.value.trim();
   var sty = document.all.Sty.value.trim();
   var sku = document.all.Sku.value.trim();
   var upc = document.all.Upc.value.trim();

   if(sku != "" && isNaN(sku)){ error = true; msg += "\nSku is not numeric." }

   if(cls == "" && ven == "" && sty == "" && sku == "" && upc == ""){ error = true; msg += "\nYou mast select one of search criteria." }
   else if((cls == "" || ven == "") && sku == "" && upc == ""){ error = true; msg += "\nPlease type Class-Vendor." }

   if (error) {alert(msg); }
   else { submit(str, sku, upc, cls, ven, sty) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(str, sku, upc, cls, ven, sty){
   SbmString = "ItemAvail.jsp"
        + "?Store=" + str
        + "&Sku=" + sku
        + "&Upc=" + upc
        + "&Cls=" + cls
        + "&Ven=" + ven
        + "&Sty=" + sty

    //alert(SbmString);
    window.location.href=SbmString;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<!-- ======================================================================= -->
<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Item Availability Report - Selection
       </b><br><br>

       <a href="index.jsp">Home</a>&#62;

      <table>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td><br>Select Store:<br><br></td><td><br><SELECT name="Store"></SELECT><br><br></td>
      </tr>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>

      <TR>
          <TD align=center colspan=2>
           Short SKU:&nbsp;
              <input name="Sku" type="text" size=10 maxlength=10> -
          </TD>
      </TR>

      <TR>
          <TD align=center colspan=2> - or -
      </TR>

      <TR>
          <TD align=center colspan=2>
           UPD Code:&nbsp;
              <input name="Upc" type="text" size=12 maxlength=12> -
          </TD>
      </TR>

      <TR>
          <TD align=center colspan=2> - or -
      </TR>

      <TR>
          <TD align=center colspan=2>
           Class - Vendor - Style:&nbsp;
              <input name="Cls" type="text" size=4 maxlength=4> -
              <input name="Ven" type="text" size=5 maxlength=5> -
              <input name="Sty" type="text" size=4 maxlength=4>
          </TD>
      </TR>

      <TR>
          <TD align=center colspan=2> - or -
      </TR>




      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button name="submit" onClick="validate()">Submit</button>
      </tr>
      </table>
                </td>
            </tr>
       </table>

        </body>
<%}%>