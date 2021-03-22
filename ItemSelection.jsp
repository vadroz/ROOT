<%@ page import="java.util.Vector, rciutility.GetDataBySQL, onhand01.JspSelect"%>
<% JspSelect select = null;

   String sDiv = null;
   String sDivName = null;
   String sDpt = null;
   String sDptName = null;
   String sDptGroup = null;
   String sCls = null;
   String sClsName = null;
   String sClsGroup = null;
   String sClsGroupByDiv = null;
   String sVen  = null;
   String sVenName = null;
   String sClr = null;
   String sClrName = null;
   String sSiz = null;
   String sSizName = null;


   // check running mode
   String sMode = request.getParameter("mode");
   if (sMode.equals("1")) {
   select = new JspSelect();
   sDiv = select.getDivNum();
   sDivName = select.getDivName();
   sDpt = select.getDptNum();
   sDptName = select.getDptName();
   sDptGroup = select.getDptGroup();
   }
   if (sMode.equals("2")) {
     select = new JspSelect(request.getParameter("DIVISION"),
                            request.getParameter("DEPARTMENT"));
     sCls = select.getClsNum();
     sClsName = select.getClsName();
     sClsGroup = select.getClsGroup();
     sClsGroupByDiv = select.getClsGroupByDiv();
     sVen  = select.getVenNum();
     sVenName = select.getVenName();
     sClr = select.getClrNum();
     sClrName = select.getClrName();
     sSiz = select.getSizNum();
     sSizName = select.getSizName();
   }



%>

<script name="javascript">
function bodyLoad(){
  var df = document.forms[0];
  var mode= <%=request.getParameter("mode")%>
  if (mode =='1') {
      doDivSelect(null);
      df.CLASS.disabled = true;
      df.VENDOR.disabled = true;
      df.STYLE.disabled = true;
      df.COLOR.disabled = true;
      df.SIZE.disabled = true;
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
      df.DIVISION.disabled = true;

      df.DEPARTMENT.options[0] = new Option(sel_Dpt_Name, sel_Dpt);
      df.DEPARTMENT.selectedIndex = 0;
      df.DEPARTMENT.disabled = true;

      df.CLASS.disabled = false;
      doClsSelect();
  }
}

function doClsSelect() {
    var df = document.forms[0];
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];
    var cls_dpt = [<%=sClsGroup%>];
    var cls_div = [<%=sClsGroupByDiv%>];

    //  clear current classes
        for (idx = df.CLASS.length; idx >= 0; idx--)
            df.CLASS.options[idx] = null;
   //  populate the class list
        for (idx = 0; idx < classes.length; idx++){
                df.CLASS.options[idx] = new Option(clsNames[idx], classes[idx]);
        }
   //  populate the vendors, colors, sizes
   //     for (idx = 0; idx < vendors.length; idx++) df.VENDOR.options[idx] = new Option(venNames[idx], vendors[idx]);
   //    for (idx = 0; idx < colors.length; idx++) df.COLOR.options[idx] = new Option(clrNames[idx], colors[idx]);
   //    for (idx = 0; idx < sizes.length; idx++) df.SIZE.options[idx] = new Option(sizNames[idx], sizes[idx]);

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

function doDptSelect(id) {
    var df = document.forms[0];
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];
    var cls_dpt = [<%=sClsGroup%>];
    var cls_div = [<%=sClsGroupByDiv%>];
    var allowed_dpt;
    var allowed_div;
    var id_div = df.DIVISION.selectedIndex;

        allowed_dpt = cls_dpt[id].split(":");
        allowed_div = cls_div[id_div].split(":");

        //  clear current depts
        for (idx = df.CLASS.length; idx >= 0; idx--)
            df.CLASS.options[idx] = null;

        //  if all are to be displayed
        if (allowed_dpt[0] == "all")
          if (allowed_div[0] == "all")
            for (idx = 0; idx < classes.length; idx++)
                df.CLASS.options[idx] = new Option(clsNames[idx],classes[idx]);
          else
              for (idx = 0; idx < allowed_div.length; idx++)
                df.CLASS.options[idx] = new Option(clsNames[allowed_div[idx]],
                                                        classes[allowed_div[idx]]);

        //  else display the desired depts
        else
            for (idx = 0; idx < allowed_dpt.length; idx++)
                df.CLASS.options[idx] = new Option(clsNames[allowed_dpt[idx]],
                                                        classes[allowed_dpt[idx]]);
    }

function moreParams(){
  var df = document.forms[0];
  var id_div = df.DIVISION.selectedIndex;
  var id_dpt = df.DEPARTMENT.selectedIndex;
  var sel_Div = df.DIVISION.options[id_div].value;
  var sel_Div_Name = df.DIVISION.options[id_div].text;
  var sel_Dpt = df.DEPARTMENT.options[id_dpt].value;
  var sel_Dpt_Name = df.DEPARTMENT.options[id_dpt].text;
  var cur_mode = <%=request.getParameter("mode")%>
  var nxt_mode = 2;

  if (cur_mode==2) nxt_mode = 3;
  window.location = "ItemSelection.jsp?action=servlet/onhand01.OnHandsList"
                  + "?mode=" + nxt_mode
                  + "&DIVISION=" + sel_Div  + "&DIVNAME=" + sel_Div_Name
                  + "&DEPARTMENT=" + sel_Dpt + "&DPTNAME=" + sel_Dpt_Name ;
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
    <TD vAlign=top align=middle><B>Retail Concepts Inc.<BR>On-Hand Listing - All Stores</B>

      <FORM method="GET" >
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable1 align=right>Division:</TD>
          <TD class=DataTable1 align=left>
             <SELECT name="DIVISION" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ANY">Any Division</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right>Department:</TD>
          <TD class=DataTable align=left>
             <SELECT name=DEPARTMENT onchange="doDptSelect(this.selectedIndex);">
                <OPTION value="ANY">Any Department</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right >Class</TD>
          <TD class=DataTable align=left>
             <SELECT name=CLASS>
                <OPTION value="ANY">Any Classes</OPTION>
              </SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right>Vendor</TD>
          <TD class=DataTable align=left>
             <SELECT name=VENDOR >
               <OPTION value="ANY">Any Vendors</OPTION>
             </SELECT></TD>
        </TR>
        <TR>
          <TD class=DataTable align=right>Style</TD>
          <TD class=DataTable align=left>
             <INPUT maxLength=5 size=5 value=ANY name=STYLE></TD>
        </TR>
        <TR>
          <TD class=DataTable align=center>Color</TD>
          <TD class=DataTable align=left>
            <SELECT name=COLOR>
               <OPTION value="ANY">Any Colors</OPTION>
             </SELECT></TD>
         </TR>
        <TR>
          <TD class=DataTable align=center>Size</TD>
          <TD class=DataTable align=left>
            <SELECT name=SIZE>
               <OPTION value="ANY">Any Sizes</OPTION>
             </SELECT></TD>
        </TR>
        <TR><TD colspan=2 class=DataTable align=left><b>Return document type:</b></TD></TR>
        <TR><TD></TD>
            <TD class=DataTable align=left>
             <INPUT type="radio" name="OutSlt" value="EXCEL" checked >Excel</TD>
             <TD></TD>
             <TD class=DataTable align=left>
              <INPUT type="radio" name="OutSlt" value="HTML">HTML</TD>
          </TR>
          <TR>
            <TD class=DataTable align=middle colSpan=5>
                 <BUTTON name="More" value="mode" type="button" onclick="moreParams()">More Selection...</BUTTON>
              </TD>
            <TD class=DataTable align=middle colSpan=5>
               <BUTTON type=button value=Submit name=SUBMIT  onclick="Validate()">Submit</BUTTON>
            </TD>
          </TR>
         </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>



   <SCRIPT>
  function Validate(){
  var form = document.forms[0];
  var error = false;
  var msg;
  var id_div = form.DIVISION.selectedIndex;
  var id_dpt = form.DEPARTMENT.selectedIndex;
  var id_cls = form.CLASS.selectedIndex;
  var id_ven = form.VENDOR.selectedIndex;
  var id_clr = form.COLOR.selectedIndex;
  var id_siz = form.SIZE.selectedIndex;

  var sel_Div = form.DIVISION.options[id_div].value;
  var sel_Dpt = form.DEPARTMENT.options[id_dpt].value;
  var sel_Cls = form.CLASS.options[id_cls].value;
  var sel_Ven = form.VENDOR.options[id_ven].value;
  var sel_Sty = form.STYLE.value;
  var sel_Clr = form.COLOR.options[id_clr].value;
  var sel_Siz = form.SIZE.options[id_siz].value;
  var sel_Out = form.OutSlt;
  var outType = 0;

  if (sel_Out[1].checked) outType = 1;

  var action= "<%=request.getParameter("action")%>";



      // At least one of the parameters should not be ANY
      if (sel_Div == "ANY" && sel_Dpt == "ANY" && sel_Cls == "ANY"){
        msg = "At least one of the parameters (Divisions, Department, Class)\n should be specified!";
        error = true;
      }

      if (error) alert(msg);
      else
           window.location = action
                  + "?DIVISION=" + sel_Div + "&DEPARTMENT=" + sel_Dpt
                  + "&CLASS=" + sel_Cls + "&VENDOR=" + sel_Ven
                  + "&STYLE=" + sel_Sty + "&COLOR=" + sel_Clr
                  + "&SIZE=" + sel_Siz
                  + "&OutSlt=" + sel_Out[outType].value;

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
