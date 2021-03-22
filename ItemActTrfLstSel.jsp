<%@ page import=" rciutility.StoreSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemActTrfLstSel.jsp&APPL=ALL");
   }
   else
   {
     StoreSelect StrSelect = new StoreSelect(0);
     String sStr = StrSelect.getStrNum();
     String sStrName = StrSelect.getStrName();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doStrSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.all;

    for (idx = 1; idx < stores.length; idx++)
    {
      df.Str.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx], stores[idx]);
    }
    document.all.Str.selectedIndex=0;
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var str = document.all.Str.options[document.all.Str.selectedIndex].value.trim();
  var strnm = document.all.Str.options[document.all.Str.selectedIndex].text.trim();

  if (error) alert(msg);
  else{ sbmScannerTransfer(str, strnm) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmScannerTransfer(str, strnm)
{
  var url = null;
  url = "ItemActTrfLst.jsp?"

  url += "Store=" + str
      + "&StrName=" + strnm
  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Scanner Transfer - Selection</B>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell" >Store:</TD>
          <TD class="Cell1" >
             <select name="Str"></select>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>