<%@ page import=" rciutility.ClassSelect, rciutility.GetDataBySQL, rciutility.StoreSelect"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   ClassSelect select = null;
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

   // check running mode
   String sMode = request.getParameter("mode");

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

   StrSelect = new StoreSelect(6);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>

<script name="javascript">
function bodyLoad(){
  var df = document.forms[0];
  var mode= <%=request.getParameter("mode")%>;
  var sel_Str= "<%=request.getParameter("STORE")%>";
  var str_opt;

  for (idx = 0; idx < df.STORE.length; idx++) {
      str_opt = df.STORE.options[idx].value;
      if(df.STORE.options[idx].value == sel_Str){
          df.STORE.selectedIndex = idx;
          break;
      }
  }

  if (mode =='1') {
      doDivSelect(null);
      doDateSelect(0);
      df.REPTYPE[0].checked = true;
      df.LEVEL[0].checked = true;
  }
  if (mode =='2') {
      var sel_Div= "<%=request.getParameter("DIVISION")%>"
      var sel_Dpt= "<%=request.getParameter("DEPARTMENT")%>"
      var sel_Div_Name = "<%=request.getParameter("DIVNAME")%>"
      var sel_Dpt_Name= "<%=request.getParameter("DPTNAME")%>"
      var sel_Date= "<%=request.getParameter("REPDATE")%>"
      var sel_Date_Dsc= "<%=request.getParameter("REPDATEDSC")%>"
      var rep_type= "<%=request.getParameter("REPTYPE")%>"
      var rep_level= "<%=request.getParameter("LEVEL")%>"


      for (idx = df.DIVISION.length; idx >= 0; idx--) df.DIVISION.options[idx] = null;
      for (idx = df.DEPARTMENT.length; idx >= 0; idx--) df.DEPARTMENT.options[idx] = null;
      df.DIVISION.options[0] = new Option(sel_Div_Name, sel_Div);
      df.DIVISION.selectedIndex = 0;

      df.DEPARTMENT.options[0] = new Option(sel_Dpt_Name, sel_Dpt);
      df.DEPARTMENT.selectedIndex = 0;

      df.REPDATE.options[0] = new Option(sel_Date_Dsc, sel_Date);
      df.REPDATE.selectedIndex = 0;

      for (idx = 0; idx < df.REPTYPE.length; idx++) {
       if(df.REPTYPE[idx].value == rep_type){
           df.REPTYPE[idx].checked = true;
           break;
        }
      }

      for (idx = 0; idx < df.LEVEL.length; idx++) {
        if(df.LEVEL[idx].value == rep_level){
           df.LEVEL[idx].checked = true;
           break;
        }
      }

      df.CLASS.disabled = false;
      doClsSelect();
  }

  // populate store dropdown box
  doStrSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 0; idx < stores.length; idx++)
                df.STORE.options[idx] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
}
//==============================================================================
// Load Stores
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
        for (idx = 0; idx < divisions.length; idx++)
            df.DIVISION.options[idx] = new Option(divisionNames[idx],divisions[idx]);
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

    // Populate Report Date Selection menu
    function doDateSelect(id) {
     var df = document.forms[0];
     var wkdate = [<%=sWkDate%>];
     var wkdateDesc = [<%=sWkDateDsc%>];
     var mndate = [<%=sMnDate%>];
     var mndateDesc = [<%=sMnDateDsc%>];
     var yrdate = [<%=sYrDate%>];
     var yrdateDesc = [<%=sYrDateDsc%>];

     //  clear current depts
     for (idx = df.REPDATE.length; idx >= 0; idx--)
                df.REPDATE.options[idx] = null;
     if (id==0){
        for (idx = 0; idx < wkdate.length; idx++)
                df.REPDATE.options[idx] = new Option(wkdateDesc[idx],wkdate[idx]);
     }
     if (id==1){
        for (idx = 0; idx < mndate.length; idx++)
                df.REPDATE.options[idx] = new Option(mndateDesc[idx], mndate[idx]);
     }
     if (id==2){
        for (idx = 0; idx < yrdate.length; idx++)
                df.REPDATE.options[idx] = new Option(yrdateDesc[idx], yrdate[idx]);
     }
    }
// Set Action
function setAction(target){
  var form = document.forms[0];
  var action;
 // go to select class
  if(target==0) action = "ClassSelect.jsp";
 // submit report
  if(target==1) action = "servlet/classreports.ClsSlsRep01";
  form.action = action;
}

// Validate form
  function Validate(){
  var form = document.forms[0];
  var error = false;
  var msg;
  var id_div = form.DIVISION.selectedIndex;
  var id_dpt = form.DEPARTMENT.selectedIndex;
  var id_date = form.REPDATE.selectedIndex;

  var sel_Div = form.DIVISION.options[id_div].value;
  var sel_Dpt = form.DEPARTMENT.options[id_dpt].value;
  var sel_Div_Name = form.DIVISION.options[id_div].text;
  var sel_Dpt_Name = form.DEPARTMENT.options[id_dpt].text;
  var sel_Rep_Dsc = form.REPDATE.options[id_date].text;
  var action;
  var mode = "<%=request.getParameter("mode")%>";

  // set form action depend of mode
  if (mode == 1) {
         form.DIVNAME.value = sel_Div_Name;
         form.DPTNAME.value = sel_Dpt_Name;
         form.REPDATEDSC.value = sel_Rep_Dsc;
  }

  if (error) alert(msg);
  else  {
      form.mode.value = ++mode;
  }


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


</script>


<HTML><HEAD>
<SCRIPT language=JavaScript>
		document.write("<style>body {background:ivory;}");
		document.write("table.DataTable { background:#FFE4C4;}");
		document.write("td.DataTable { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }");
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
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Gross Margin Sales/Inventory Report</B>

      <FORM  method="GET" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable1 align=right>Division:</TD>
          <TD class=DataTable1 align=left>
             <SELECT name="DIVISION" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DIVNAME>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right>Department:</TD>
          <TD class=DataTable align=left>
             <SELECT name=DEPARTMENT >
                <OPTION value="ALL">All Department</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DPTNAME>
          </TD>
        </TR>
        <TR>
         <% if (sMode.equals("2")) {%>
            <TD class=DataTable align=right >Class:</TD>
            <TD class=DataTable align=left>
               <SELECT name=CLASS>
                  <OPTION value="ALL">All Classes</OPTION>
                </SELECT>
            </TD>
             <%} else {%>
             <TD><INPUT type="hidden" value="ALL" name="CLASS"></TD>
             <%}%>
        </TR>
        <TR>
          <TD class=DataTable align=right >Store:</TD>
          <TD class=DataTable align=left>
             <SELECT name="STORE"></SELECT>
             <INPUT type=hidden value="<%=request.getParameter("mode")%>" name=mode>
             <INPUT type=hidden value="0000" name="NXTCLS">
          </TD>
        </TR>

        <TR>
            <TD></TD>
              <TD class=DataTable align=left>
                <INPUT type="radio" name="REPTYPE" value="W"
                    checked onClick="doDateSelect(0)">Weekly Report &nbsp;&nbsp;&nbsp;&nbsp;
                <INPUT type="radio" name="REPTYPE" value="M" onClick="doDateSelect(1)">Monthly Report&nbsp &nbsp;&nbsp;&nbsp;
                <INPUT type="radio" name="REPTYPE" value="Y" onClick="doDateSelect(2)">Year-To-Date Report</TD>
          </TR>
          <TR>
            <TD></TD>
              <TD class=DataTable align=left>
                <INPUT type="radio" name="LEVEL" value="D" onClick="document.forms[0].SUBMIT[1].disabled=false;"
                   checked >Class details &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <INPUT type="radio" name="LEVEL" value="T" onClick="document.forms[0].SUBMIT[1].disabled=true;">
                   Division totals
               </TD>
          </TR>
          <TR>
            <TD class=DataTable align=right >Report Date:</TD>
            <TD class=DataTable align=left>
               <SELECT name=REPDATE >
                  <OPTION value="RECENT">--Most Recent--</OPTION>
               </SELECT>
               <INPUT type=hidden  name=REPDATEDSC>
          </TR>
          <TR>
            <TD></TD>
            <TD class=DataTable align=left colSpan=5>
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
