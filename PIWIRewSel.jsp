<%@ page import="rciutility.StoreSelect, inventoryreports.PiCalendar"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   // get PI Calendar
   PiCalendar setcal = new PiCalendar();
   String sYear = setcal.getYear();
   String sMonth = setcal.getMonth();
   String sDesc = setcal.getDesc();
   setcal.disconnect();
%>

<script name="javascript">
var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];

function bodyLoad(){
  doStrSelect();
  popPICal();
}
// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];
    var store = null;

    for (idx = 1; idx < stores.length; idx++){
                if (stores[idx].length == 1) store = "0" + stores[idx];
                else store = stores[idx];
                df.STORE.options[idx-1 ] = new Option(stores[idx] + " - " + storeNames[idx], store);
    }
}

//==============================================================================
// change Store selection
//==============================================================================
function popPICal()
{
   for(var i=0; i < PiYear.length; i++)
   {
      document.all.PICal.options[i] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
   }
}

</script>
<HTML><HEAD>

<style>
 body {background:ivory;}
 table.DataTable { background:#FFE4C4;}
 td.DataTable1 { font-family:Verdanda; font-size:18px }
 td.DataTable2 { font-family:Verdanda; font-size:18px }
 td.DataTable3 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; border-bottom: white solid 1px; border-right: white solid 1px;border-top: white solid 1px;border-left: white solid 1px;}
 td.DataTable4 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
</style>

<SCRIPT language="JavaScript1.2">
function Validate(form){
  var error = false;
  var msg;

    //Convert entries to upper case
    form.AREA.value = (form.AREA.value).toUpperCase();
    if (form.AREA.value!="ALL" && isNaN(form.AREA.value)
       || form.AREA.value=="")
    {
       error = true;
       msg = "The value in Area is invalid"
    }

      if (error) alert(msg);
      else
      {
        //  Add Action
        if (form.AREA.value=="ALL") form.action="PIWIRewArea.jsp"
        else form.action="PIWIRew.jsp"
      }

  return error == false;
  }
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
    <TD vAlign=top align=middle><B>Retail Concepts Inc.

      <BR>Cycle Count Area Summary - Selection</B>

      <FORM method="GET"  onsubmit="return Validate(this) ">
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable align=right >Store:</TD>
          <TD class=DataTable colspan="2" align=left>
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>

        <TR style="display:none;">
          <TD class=DataTable4 align=right>Area:</TD>
          <TD class=DataTable4 align=left>
             <INPUT maxLength=5 size=5 name="AREA" value="ALL">
              <span style="font-size:12px">(or a specific Area #)</span>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR style="display:none;"><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR style="display:none;">
          <TD class="Cell" nowrap>PI Calendar:</TD>
          <TD class="Cell1"><select name="PICal"></select></td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <td class=DataTable4>&nbsp;</td>
            <TD class=DataTable4 align=left>
              <INPUT type=submit value=Submit name=SUBMIT>
            </TD>
           </TR>
          </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
  </TABLE>
</BODY></HTML>
