<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect, inventoryreports.PiCalendar"%>
<% ClassSelect select = null;
   String sMode = request.getParameter("mode");
   if(sMode==null) sMode="1";

   String sDiv = null;
   String sDivName = null;
   String sDpt = null;
   String sDptName = null;
   String sDptGroup = null;
   String sCls = null;
   String sClsName = null;
   String sWkDate = null;
   String sWkDateDsc = null;
   String sMnDate = null;
   String sMnDateDsc = null;
   String sYrDate = null;
   String sYrDateDsc = null;


   if (sMode.equals("1")) {
     select = new ClassSelect();
     sDiv = select.getDivNum();
     sDivName = select.getDivName();
     sDpt = select.getDptNum();
     sDptName = select.getDptName();
     sDptGroup = select.getDptGroup();
     sWkDate = select.getWkDate();
     sWkDateDsc = select.getWkDateDsc();
     sMnDate = select.getMnDate();
     sMnDateDsc = select.getMnDateDsc();
     sYrDate = select.getYrDate();
     sYrDateDsc = select.getYrDateDsc();
   }

   // select class
   if (sMode.equals("2")) {
     select = new ClassSelect(request.getParameter("DIVISION"),
                            request.getParameter("DEPARTMENT"));
     sCls = select.getClsNum();
     sClsName = select.getClsName();
   }

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect(5);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   // get PI Calendar
   PiCalendar setcal = new PiCalendar();
   String sYear = setcal.getYear();
   String sMonth = setcal.getMonth();
   String sDesc = setcal.getDesc();
   setcal.disconnect();
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">

var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad(){
  var df = document.forms[0];
  var mode= <%=sMode%>;
  var sel_Str= "<%=request.getParameter("STORE")%>";
  var str_opt;

  document.forms[0].Sign[0].checked=true;
  document.forms[0].Sign[1].checked=false;
  swtchSel(false);

  doStrSelect();

  if (mode =='1') {
      doDivSelect(null);
  }
  if (mode =='2') {
      var sel_Div= "<%=request.getParameter("DIVISION")%>"
      var sel_Dpt= "<%=request.getParameter("DEPARTMENT")%>"
      var sel_Div_Name = "<%=request.getParameter("DIVNAME")%>"
      var sel_Dpt_Name= "<%=request.getParameter("DPTNAME")%>"

      for (idx = df.DIVISION.length; idx >= 0; idx--) df.DIVISION.options[idx] = null;
      for (idx = df.DEPARTMENT.length; idx >= 0; idx--) df.DEPARTMENT.options[idx] = null;
      df.DIVISION.options[0] = new Option(sel_Div_Name, sel_Div);
      df.DIVISION.selectedIndex = 0;

      df.DEPARTMENT.options[0] = new Option(sel_Dpt_Name, sel_Dpt);
      df.DEPARTMENT.selectedIndex = 0;

      df.CLASS.disabled = false;
      doClsSelect();
  }
  popPICal();
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
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];
    for (idx = 1; idx < stores.length; idx++)
      df.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
}
//==============================================================================
// populate class selection
//==============================================================================
function doClsSelect() {
    var df = document.forms[0];
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];

    //  clear current classes
        for (idx = df.CLASS.length; idx >= 0; idx--)
            df.CLASS.options[idx] = null;
   //  populate the class list
        for (idx = 0; idx < classes.length; idx++){
                df.CLASS.options[idx] = new Option(clsNames[idx], classes[idx]);
        }
}

//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.forms[0];
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];

    var allowed;

    if (id == null || id == 0) {
        //  populate the division list
        for (idx=0, j=0; idx < divisions.length; idx++)
        {
            if(divisions[idx] != "96" && divisions[idx] !== "97")
            {
              df.DIVISION.options[j] = new Option(divisionNames[idx],divisions[idx]);
              j++;
            }
        }
        id = 0;
    }
        allowed = dep_div[id].split(":");

        //  clear current depts
        for (idx = df.DEPARTMENT.length; idx >= 0; idx--)
            df.DEPARTMENT.options[idx] = null;

        //  if all are to be displayed
        if (allowed[0] == "all")
            for (idx = 0; idx < depts.length; idx++)
                df.DEPARTMENT.options[idx] = new Option(deptNames[idx],depts[idx]);

        //  else display the desired depts
        else
            for (idx = 0; idx < allowed.length; idx++)
                df.DEPARTMENT.options[idx] = new Option(deptNames[allowed[idx]],
                                                        depts[allowed[idx]]);
    }

//==============================================================================
// Set Action
//==============================================================================
function setAction(target){
  var form = document.forms[0];
  var action = null;
  form.action = action;
  var sign = form.Sign[1].checked;

   // go to select class
  if(target==0) action = "PINegInvSel.jsp";
  else if(target==1 && sign) action = "PIItmSlsHst.jsp"; // submit item sales history
  else if(target==1 && !sign) action = "PINegInv.jsp"; // submit Negative item quantity on hand
  form.action = action;


}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(){
  var form = document.forms[0];
  var error = false;
  var msg = " ";
  var id_div = form.DIVISION.selectedIndex;
  var id_dpt = form.DEPARTMENT.selectedIndex;
  var id_str = form.STORE.selectedIndex;

  var sel_Cls = "ALL";
  var sel_Div = form.DIVISION.options[id_div].value;
  var sel_Dpt = form.DEPARTMENT.options[id_dpt].value;
  var sel_Str = form.STORE.options[id_str].value;
  var sel_Div_Name = form.DIVISION.options[id_div].text;
  var sel_Dpt_Name = form.DEPARTMENT.options[id_dpt].text;

  var sign = form.Sign[1].checked;
  var sku = form.Sku.value;

  var action;
  var mode = "<%=sMode%>";

  form.DIVNAME.value = sel_Div_Name;
  form.DPTNAME.value = sel_Dpt_Name;

  if(sign && (sku.trim()=="" || isNaN(sku.trim())))
  {
    msg += "Please, enter Short SKU."
    error = true;
  }

  // set form action depend of mode
  if (mode == 2)
  {
    id_cls = form.CLASS.selectedIndex;
    sel_Cls = form.CLASS.options[id_cls].value;
    var id_cls = form.CLASS.selectedIndex;
    form.CLSNAME.value = form.CLASS.options[id_cls].text;
  }

  if (error) alert(msg);
  else  {
      form.mode.value = ++mode;
      if(sel_Str=="CMB") form.STORE.selectedIndex = 1;
  }

    return error == false;
  }

//==============================================================================
// switch selecting parameters from Div/Dpt/Cls to Short Sku
//==============================================================================
function swtchSel(sel)
{
   var ddc = document.all.trDDC;
   var sku = document.all.trSku;

   if(sel)
   {
      for(var i=0; i < ddc.length; i++)
      {
        ddc[i].style.display ="none"
      }
      sku.style.display ="block"
   }
   else
   {
      for(var i=0; i < ddc.length; i++)
      {
         ddc[i].style.display ="block"
      }
      sku.style.display ="none"
   }

}
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}
</script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

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
        <BR>On-Hand - Review by Quantity on Hand - Selection</B>

   <FORM  method="GET" onSubmit="return Validate(this)">
      <TABLE>
       <TBODY>
       <!-- =============================================================== -->
        <TR id="trDDC">
          <TD align=right valign="top">Division:</TD>
          <TD align=left>
             <SELECT name="DIVISION" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
             <br><font size="-1">Warning: Selecting All Divisions will take avery long time to display</font><br>&nbsp;

             <INPUT type=hidden  name=DIVNAME>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR id="trDDC">
          <TD align=right>Department:</TD>
          <TD align=left>
             <SELECT name=DEPARTMENT >
                <OPTION value="ALL">All Department</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DPTNAME>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR id="trDDC">
         <% if (sMode.equals("2")) {%>
            <TD align=right >Class:</TD>
            <TD align=left>
               <SELECT name=CLASS>
                  <OPTION value="ALL">All Classes</OPTION>
                </SELECT>
                <INPUT type=hidden  name=CLSNAME>
            </TD>
             <%} else {%>
             <TD><INPUT type="hidden" value="ALL" name="CLASS"></TD>
             <%}%>
        </TR>
        <!-- =============================================================== -->
        <TR id="trSku">
          <TD align=right ><br>Short Sku or UPC:</TD>
           <TD><br>
              <input name="Sku" type="text" size="12" maxlength="12">&nbsp;&nbsp;
              <INPUT type="hidden" value="1" name="SlsOnTop"></TD>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left>
             <SELECT name="STORE"></SELECT>
             <INPUT type=hidden value="<%=sMode%>" name=mode>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=right ><br>Quantity greater than:</TD>
           <TD><br>
              <input name="Qty" type="text" value="1" size="5" maxlength="5">&nbsp;&nbsp;
              <input name="Sign" type="radio" value="N" checked onClick="swtchSel(false)">Negative&nbsp;&nbsp;
              <input name="Sign" type="radio" value="P" onClick="swtchSel(true)">Positive
          </TD>
        </TR>
         <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell" nowrap>PI Calendar:</TD>
          <TD class="Cell1" colspan=3>
             <select name="PICal"></select>
          </td>
          </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="setAction(1)">
               &nbsp;&nbsp;&nbsp;&nbsp;
           <% if (sMode.equals("1")) {%>
                <INPUT type=submit value="Select Class" name=SUBMIT onClick="setAction(0)">
           <%} else{%>
                <INPUT type="BUTTON" name="Back" value="Select Div/Dept" onClick="javascript:history.back()">
           <%}%>
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
