<%@ page import="rciutility.StoreSelect"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect(5);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }

   // call from kiosk
   String sKioskStr = request.getParameter("KioskStr");
   String sKioskSrc = request.getParameter("KioskSrc");

   if(sKioskStr == null){sKioskStr = "NONE";}
   if(sKioskSrc == null){sKioskSrc = "NONE";}
%>
<script name="javascript1.2">
//==============================================================================
function bodyLoad(){
   <%if(!bKiosk){%>doStrSelect();<%}%>
  // clear search fields
  var df = document.forms[0];
  df.CLASS.value = "";
  df.VENDOR.value = "";
  df.STYLE.value = "";
  df.SKU.value = "";
  df.UPC.value = "";
}
// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];
    var store = null;

    for (idx = 1; idx < stores.length; idx++)
    {
      if (stores[idx].length == 1) store = "0" + stores[idx];
      else store = stores[idx];
      df.STORE.options[idx-1 ] = new Option(stores[idx] + " - " + storeNames[idx], store);
    }
}
//------------------------------------------------------------------------------
// Validate form entry
//------------------------------------------------------------------------------
  function Validate(form)
  {
    var error = false;
    var msg="";

    var cls = form.CLASS.value.trim();
    var ven = form.VENDOR.value.trim();
    var sty = form.STYLE.value.trim();
    var sku = form.SKU.value.trim();
    var upc = form.UPC.value.trim();

    if(cls == "" && ven == "" && sty == "" && sku == "" && upc == "")
    {
       error = true;
       msg += "Enter a search criteria";
    }
    else if   ((cls != "" || ven != "" || sty != "")
            && (cls == "" || ven == "" || sty == "")
            && sku == "" && upc == "")
    {
      error = true;
      msg += "For Class-Vendor-Style list, all criterias must be specified";
    }
    else if  (( cls != "" || ven != "" || sty != "") && (sku != "" || upc != "")
           ||   sku != "" && upc != "")
    {
      error = true;
      msg += "Specify only one search criterias";
    }
    else if  (cls !="" && isNaN(cls) || ven !="" && isNaN(ven) || sty !="" && isNaN(sty)
           || sku !="" && isNaN(sku) || upc !="" && isNaN(upc))
    {
      error = true;
      msg += "Some of the selections are not a numeric";
    }

    if(error) alert(msg);
    return error == false;
  }
//------------------------------------------------------------------------------
// submit form
//------------------------------------------------------------------------------
function  submit()
{
  var form = document.forms[0];
  var str = "1"
  if(form.STORE != null)
  {
     str = form.STORE.options[form.STORE.selectedIndex].value;
  }
  var cls = form.CLASS.value;
  var ven = form.VENDOR.value;
  var sty = form.STYLE.value;
  var sku = form.SKU.value;
  var upc = form.UPC.value;
  var user = form.User.value;
  var kioskStr = form.KioskStr.value;
  var kioskSrc = form.KioskSrc.value;

  var url = "servlet/onhand01.OnHands03?STORE=" + str
  if(cls != "") url += "&CLASS=" + cls;
  if(ven != "") url += "&VENDOR=" + ven;
  if(sty != "") url += "&STYLE=" + sty;
  if(sku != "") url += "&SKU=" + sku;
  if(upc!= "") url += "&UPC=" + upc;
  url += "&User=" + user
    + "&KioskStr=" + kioskStr
    + "&KioskSrc=" + kioskSrc;

  url += "&OutSlt=HTML";

  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD>
<SCRIPT language=JavaScript>
		document.write("<style>body {background:ivory;}");
		document.write("table.DataTable { background:#FFE4C4;}");
		document.write("td.DataTable1 { font-family:Verdanda; font-size:18px }");
            document.write("td.DataTable2 { font-family:Verdanda; font-size:18px }");
            document.write("td.DataTable3 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; border-bottom: white solid 1px; border-right: white solid 1px;border-top: white solid 1px;border-left: white solid 1px;}");
		document.write("td.DataTable4 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }");
		document.write("</style>");
           </SCRIPT>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-- saved from url=(0088)http://192.168.20.64:8080/servlet/formgenerator.FormGenerator?FormGrp=TICKETS&Form=BBT01 -->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
       <BR>Inventory Lookup</B>

      <FORM action="javascript:submit()" method="GET"  onsubmit="return Validate(this) ">
            <input name="KioskStr" type="hidden" value="<%=sKioskStr%>">
            <input name="KioskSrc" type="hidden" value="<%=sKioskSrc%>">
      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <!--  Store Selection  -->
        <!-- =============================================================== -->
        <%if(!bKiosk){%>
            <TR>
              <TD class=DataTable align="right" >Store Pricing:</TD>
              <TD class=DataTable colspan="2" align=left>
                <SELECT name="STORE"></SELECT>
            </TD>
        </TR>
        <%}%>
        <!-- =============================================================== -->
        <!--  Class-Vendor Style  -->
        <!-- =============================================================== -->
        <TR>
          <TD class=DataTable4 align=right>Class-Vendor-Style:</TD>
          <TD class=DataTable4 align="left">
            <INPUT maxLength=5 size=5 name="CLASS"> -
            <INPUT maxLength=5 size=5 name="VENDOR"> -
            <INPUT maxLength=5 size=5 name="STYLE">
          </TD>
          <td class=DataTable4 align="left">- or -<td>
        </tr>
        <!-- =============================================================== -->
        <!--  Short Sku Selection  -->
        <!-- =============================================================== -->
        <TR>
          <TD class=DataTable align="right" >Short SKU:</TD>
          <TD class=DataTable align="left"><INPUT maxLength=10 size=10 name="SKU">
          <td class=DataTable4 align="left">- or -<td>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <!--  Manufaturer UPC  -->
        <!-- =============================================================== -->
        <TR>
          <td class=DataTable align="right" >Manufacturer UPC:</TD>
          <td class=DataTable align="left"><INPUT maxLength=12 size=12 name="UPC"><td>
        </TR>
        <!-- =============================================================== -->
        <!--  Command Buttons  -->
        <!-- =============================================================== -->
        <TR>
          <TD class=DataTable4 align=middle colSpan=5>
            <INPUT type=reset value=Clear name=RESET>&nbsp;
            Click here for <a href="OnHands04.jsp?KioskStr=<%=sKioskStr%>&KioskSrc=<%=sKioskSrc%>">Advance Item Search</a></TD>
        </TR>
        <TR>
          <TD class=DataTable4 align=middle colSpan=5>
            <INPUT type=hidden value="<%=sUser%>" name="User">

            <INPUT type=submit value=Submit name="SUBMIT">&nbsp;
        </TR>

      <%if(!bKiosk){%>
        <TR >
          <td colspan=3 valign=bottom align=center><a href="/"><font color="red" size="-1">Rci Home Page</font></a><td>
        </TR>
      <%} else {%>
          <td colspan=3 valign=bottom align=center><a href="/KioskMain.jsp?utm_medium=<%=sKioskStr%>&utm_source=<%=sKioskSrc%>"><font color="red" size="-1">Kiosk Main</font></a><td>
      <%}%>
       </TBODY>
      </TABLE>
     </FORM>
    </TD>
   </TR>
  </TBODY>
</TABLE>
</BODY>
</HTML>
