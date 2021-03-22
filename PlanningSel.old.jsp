<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect"%>
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

   StrSelect = new StoreSelect(0);
   int iNumOfStr = StrSelect.getNumOfStr();
   String [] sStr = StrSelect.getStrLst();
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad(){
  var df = document.forms[0];
  var mode= <%=sMode%>;
  var str_opt;

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
        for (idx = 1; idx < divisions.length; idx++)
            df.DIVISION.options[idx-1] = new Option(divisionNames[idx],divisions[idx]);
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
// change Store selection
//==============================================================================
function chgStrSel(str)
{
  var stores =  document.all.STORE;
  // unselect other store if ALL selected
  if(str.value=="ALL" && str.checked)
  {
     for(var i=1; i < stores.length; i++ ) { stores[i].checked=false; }
  }
  else if(str.value!="ALL") stores[0].checked=false;
}
//==============================================================================
// Set Action
//==============================================================================
function setAction(target){
  var form = document.forms[0];
  var action = null;
  form.action = action;

   // go to select class
  if(target==0) action = "PlanningSel.jsp";
 // submit report
  if(target==1) action = "PlanSps.jsp";
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
  var sel_Cls = "ALL";
  var sel_Div = form.DIVISION.options[id_div].value;
  var sel_Dpt = form.DEPARTMENT.options[id_dpt].value;
  var sel_Div_Name = form.DIVISION.options[id_div].text;
  var sel_Dpt_Name = form.DEPARTMENT.options[id_dpt].text;

  var stores = document.all.STORE;
  var action;
  var mode = "<%=sMode%>";


  // set form action depend of mode
  if (mode == 1)
  {
         form.DIVNAME.value = sel_Div_Name;
         form.DPTNAME.value = sel_Dpt_Name;
  }
  else
  {
    id_cls = form.CLASS.selectedIndex;
    sel_Cls = form.CLASS.options[id_cls].value;
  }

  // at least 1 store must be selected
  var strsel = false;
  for(var i=0; i < stores.length; i++ )
  {
     if(stores[i].checked) { strsel=true; break; }
  }

  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }

  if (error) alert(msg);
  else{ form.mode.value = ++mode; }
  return error == false;
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
        <BR>Planning - Selection</B>

      <FORM  method="GET" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD align=right>Division:</TD>
          <TD align=left colspan="3">
             <SELECT name="DIVISION" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DIVNAME>
          </TD>
        </TR>
        <TR>
          <TD align=right>Department:</TD>
          <TD align=left colspan="3">
             <SELECT name=DEPARTMENT >
                <OPTION value="ALL">All Department</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DPTNAME>
          </TD>
        </TR>
        <TR>
         <% if (sMode.equals("2")) {%>
            <TD align=right >Class:</TD>
            <TD align=left colspan="3">
               <SELECT name=CLASS>
                  <OPTION value="ALL">All Classes</OPTION>
                </SELECT>
            </TD>
             <%} else {%>
             <TD><INPUT type="hidden" value="ALL" name="CLASS"></TD>
             <%}%>
        </TR>
        <!-- =============================================================== -->
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left colspan="3">
             <input name="STORE" type="checkbox" value="ALL" onclick="chgStrSel(this)" checked>All&nbsp;&nbsp;
             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="STORE" type="checkbox" onclick="chgStrSel(this)" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i == 10) {%><br><%}%>
             <%}%>

             <INPUT type=hidden value="<%=sMode%>" name=mode>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD align=right > <br>Change Plan:</TD>
           <TD>
              <br><input name="AlwChg" type="radio" value="R" checked>Retail<br>
              <input name="AlwChg" type="radio" value="C" >Cost<br>
              <input name="AlwChg" type="radio" value="U" >Unit
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
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
