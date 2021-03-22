<%@ page import="rciutility.StoreSelect"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>


<HTML><HEAD>

<style>body {background:ivory;}
  #vertit {position: absolute; writing-mode: tb-rl; filter: flipv fliph; }

  table.DataTable { background:#FFE4C4;}
  td.DataTable1 { font-family:Verdanda; font-size:18px }
  td.DataTable2 { font-family:Verdanda; font-size:18px }
  td.DataTable3 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; border-bottom: white solid 1px; border-right: white solid 1px;border-top: white solid 1px;border-left: white solid 1px;}
  td.DataTable4 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
</style>
<script language=JavaScript></script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

<div id="vertit">Test</div>

<!-- saved from url=(0088)http://192.168.20.64:8080/servlet/formgenerator.FormGenerator?FormGrp=TICKETS&Form=BBT01 -->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
       <BR>Inventory Lookup</B>

      <FORM action="servlet/onhand01.OnHands03?" method="GET"  onsubmit="return Validate(this) ">
      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <!--  Store Selection  -->
        <!-- =============================================================== -->
        <TR>
          <TD class=DataTable align="right" >Store Pricing:</TD>
          <TD class=DataTable colspan="2" align=left>
             <SELECT name="STORE">
               <option value="3">3</option>
               <option value="3">4</option>
               <option value="3">5</option>
               <option value="3">8</option>
               <option value="3">10</option>
               <option value="3">11</option>
               <option value="3">20</option>
               <option value="3">28</option>
               <option value="3">30</option>
               <option value="3">40</option>
               <option value="3">45</option>
               <option value="3">61</option>
               <option value="3">82</option>
               <option value="3">88</option>
               <option value="3">98</option>
             </SELECT>
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
            Click here for <a href="OnHands04.jsp">Advance Item Search</a></TD>
        </TR>
        <TR>
          <TD class=DataTable4 align=middle colSpan=5>
            <INPUT type=submit value=Submit name="SUBMIT">&nbsp;
            <INPUT name="OutSlt" value="HTML" type="hidden">
        </TR>
        <TR >
          <td colspan=3 valign=bottom align=center><a href="/"><font color="red" size="-1">Rci Home Page</font></a><td>
        </TR>
       </TBODY>
      </TABLE>
     </FORM>
    </TD>
   </TR>
  </TBODY>
</TABLE>
</BODY>
<script name="javascript1.2">

bodyLoad()
alert("Test")

function bodyLoad(){
  doStrSelect();
  // clear search fields
  var df = document.forms[0];
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

    var upc = form.UPC.value;

    if(error) alert(msg);
    return error == false;
  }
//------------------------------------------------------------------------------
// submit form
//------------------------------------------------------------------------------
function  submit()
{
  var form = document.forms[0];
  var str = form.STORE.options[form.STORE.selectedIndex].value;
  var upc = form.UPC.value;
//http://192.168.20.64:8080/servlet/onhand01.OnHandsList?DIVISION=40&DEPARTMENT=ANY
//&CLASS=ANY&VENDOR=ANY&STYLE=ANY&COLOR=ANY&SIZE=ANY&OutSlt=HTML&SUBMIT=Submit


  var url = "servlet/onhand01.OnHands03?STORE=" + str
  if(sku != "") url += "&SKU=" + sku;
  if(upc!= "") url += "&UPC=" + upc;

  url += "&OutSlt=HTML";

  //alert(url)
  window.location.href=url;
}
</script>
</HTML>
