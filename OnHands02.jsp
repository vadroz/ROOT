<%@ page import="rciutility.StoreSelect"%>
<% StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect(5);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>
<script name="javascript">
function bodyLoad(){
  doStrSelect();
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
//==============================================================================
// shows/hide OnHand Calculation area (in-transit)
//==============================================================================
function showCalc(show)
{
   var calc = document.all.trCalc
   for(var i=0; i < calc.length; i++)
   {
      calc[i].style.display = show;
   }
}

</script>
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
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:helpdesk@retailconcepts.cc">Mail to IT</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.<BR>On-Hand Listing - All Stores</B>

      <FORM action=servlet/onhand02.OnHandsList method="GET"  onsubmit="return Validate(this) ">
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable align=right >Store:</TD>
          <TD class=DataTable colspan="4" align=left>
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable4 align=right>Division:</TD>
          <TD class=DataTable4 align=left><INPUT maxLength=5 size=5
            name=DIVISION></TD><!--/TR-->
        <!--TR-->
          <TD class=DataTable4 align=right>Department:</TD>
          <TD class=DataTable4 align=left><INPUT maxLength=5 size=5
            name=DEPARTMENT value=ANY></TD></TR>
        <TR>
          <TD class=DataTable4 align=center>Class</TD>
          <TD class=DataTable4 align=center>Vendor</TD>
          <TD class=DataTable4 align=center>Style</TD>
          <TD class=DataTable4 align=center>Color</TD>
          <TD class=DataTable4 align=center>Size</TD></TR>
        <TR>
          <TD class=DataTable4 align=left><INPUT maxLength=5 size=5  value="ANY"
            name=CLASS></TD>
          <TD class=DataTable4 align=left><INPUT maxLength=5 size=5 value="ANY"
            name=VENDOR></TD>
          <TD class=DataTable4 align=left><INPUT maxLength=5 size=5
            value=ANY name=STYLE></TD>
          <TD class=DataTable4 align=left><INPUT maxLength=5 size=5
            value=ANY name=COLOR></TD>
          <TD class=DataTable4 align=left><INPUT maxLength=5 size=5
            value=ANY name=SIZE></TD></TR>

        
        <!-- ====================================================================================-->
        <TR><TD colspan=2 class=DataTable4 align=left><b>Return document type:</b></TD></TR>
        <TR><TD></TD>
            <TD class=DataTable4 align=left colspan=4>
              <INPUT type="radio" name="OutSlt" onClick="showCalc('block')" value=HTML checked >
              HTML - Display<br>(further selections below)              
            </TD>
             <TD class=DataTable4 align=left colspan=4>
                 <INPUT type="radio" name="OutSlt" onClick="showCalc('none')" value=EXCEL>
                 Excel - Export<br>
(ALL Computer OH, does not exclude<br>In-Transit Inventory)
                 
             </TD>
             
          </TR>
          
          <!-- Include Items ======================================================================-->
        <TR id="trCalc">
           <TD colspan=2 class=DataTable4 align=left><b>On-Hand Calculation</b></TD>
        </TR>
        <TR id="trCalc">
          <TD></TD>
          <TD colspan=3 class=DataTable4 align=left>
                <INPUT type="radio" name="InTrans" value="N" checked >Include In-Transit<br>
                <INPUT type="radio" name="InTrans" value="A">Exclude In-Transit<br>
                <INPUT type="radio" name="InTrans" value="O">Show In-Transit Only</TD>
        </TR>
          
          <TR><TD class=DataTable4 align=middle colSpan=5><INPUT type=submit value=Submit name=SUBMIT></TD></TR></TBODY></TABLE></FORM></TD></TR></TBODY></TABLE>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<SCRIPT>
  function Validate(form)
  {
  	var error = false;
  var msg;
      //Convert entries to upper case
      form.DIVISION.value = (form.DIVISION.value).toUpperCase();
      form.DEPARTMENT.value = (form.DEPARTMENT.value).toUpperCase();
      form.CLASS.value = (form.CLASS.value).toUpperCase();
      form.VENDOR.value = (form.VENDOR.value).toUpperCase();
      form.STYLE.value = (form.STYLE.value).toUpperCase();
      form.COLOR.value = (form.COLOR.value).toUpperCase();
      form.SIZE.value = (form.SIZE.value).toUpperCase();

      if (form.DIVISION.value.trim() == ""){ form.DIVISION.value = "ANY"}
      
      if (form.DIVISION.value != "ANY"   &&    !isNum(form.DIVISION.value) ) {
          msg = "Division number contains a letter(s) or blank. \n";
          error = true;
      }

      if (form.DEPARTMENT.value != "ANY"   && !isNum(form.DEPARTMENT.value) ) {
          if(error) msg += "Department number contains a letter(s) or blank. \n";
          else  msg = "Department number contains a letter(s) or blank. \n";
          error = true;
      }

      if (form.CLASS.value != "ANY"  && !isNum(form.CLASS.value) ) {
         if(error) msg +=  "Class number contains a letter(s) or blank.  \n";
         else msg = "Class number contains a letter(s) or blank.  \n";
         error = true;
      }

      if (form.VENDOR.value != "ANY"    && !isNum(form.VENDOR.value) ) {
         if(error) msg += "Vendor number contains a letter(s) or blank.  \n";
         else msg = "Vendor number contains a letter(s) or blank.  \n";

          error = true;
      }

      if (form.STYLE.value != "ANY" && !isNum(form.STYLE.value) ) {
       if(error) msg += "Style number contains a letter(s) or blank.  \n";
       else msg = "Style number contains a letter(s) or blank.  \n";
       error = true;
      }

      if (form.COLOR.value != "ANY" && !isNum(form.COLOR.value) ) {
         if(error)  msg += "Color number contains a letter(s)  or blank. \n";
         else msg = "Color number contains a letter(s) or blank. \n";
         error = true;
      }

      if (form.SIZE.value != "ANY" && !isNum(form.SIZE.value) ) {
         if(error) msg += "Size number contains a letter(s) or blank\n";
         else msg = "Size number contains a letter(s) or blank \n";
         error = true;
      }

      if (error)     alert(msg);
      return error == false;
  }

  function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}

</SCRIPT>
</BODY></HTML>
