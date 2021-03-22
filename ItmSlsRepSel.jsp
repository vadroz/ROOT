<%@ page import=" rciutility.ClassSelect"%>
<%
   ClassSelect select = new ClassSelect("order by ccls");
   String sDiv = select.getDivNum();
   String sDivName = select.getDivName();
   String sDpt = select.getDptNum();
   String sDptName = select.getDptName();
   String sCls = select.getClsNum();
   String sClsName = select.getClsName();
%>
<!-- ---------------------------- Style -------------------------------- -->
<style>
  body {background:ivory;}
  table.FormTb { background:#FFE4C4;}
  td.FormTb { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }

  table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
  th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
  td.DataTable { background:cornsilk; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-left:3px; padding-right:3px; cursor: hand;
                 text-align:center; font-family:Arial; font-size:10px }
   td.DataTable1 { color:grey; background:cornsilk; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-left:3px; padding-right:3px;
                 text-align:center; font-family:Arial; font-size:10px }
   a.Date:link { color:blue; text-decoration:none }
   a.Date:visited { color:blue; text-decoration:none }
   a.Date:hover { color:red; text-decoration:none }
</style>
<!-- ------------------------- End Style ------------------------------ -->


<script name="javascript">
function bodyLoad(){
  var df = document.forms[0];
  doDivSelect();
  doDptSelect();
  doClsSelect();
  document.forms[0].STR[0].checked = true;
  for(i=1; i < document.forms[0].STR.length; i++)
  {
  document.forms[0].STR[i].checked = false;
  }
}

function doClsSelect() {
    var df = document.forms[0];
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];

   //  populate the class list
        for (var i = 0; i < classes.length; i++)
        {
          df.FROMCLS.options[i] = new Option(clsNames[i], classes[i]);
          df.TOCLS.options[i] = new Option(clsNames[i], classes[i]);
        }
}


function doDivSelect() {
    var df = document.forms[0];
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];

    var allowed;
        //  populate the division list
        for (var i = 0; i < divisions.length; i++)
        {
            df.FROMDIV.options[i] = new Option(divisionNames[i],divisions[i]);
            df.TODIV.options[i] = new Option(divisionNames[i],divisions[i]);
        }

}
//-------------------------------------------------------------------
// populate department DDM
//-------------------------------------------------------------------
function doDptSelect() {
    var df = document.forms[0];
    var depart = [<%=sDpt%>];
    var departNames = [<%=sDptName%>];

    var allowed;
        //  populate the department list
        for (var i = 0; i < depart.length; i++)
        {
          df.FROMDPT.options[i] = new Option(departNames[i],depart[i]);
          df.TODPT.options[i] = new Option(departNames[i],depart[i]);
        }

}

//-------------------------------------------------------------------
// Reset slected fields
//-------------------------------------------------------------------
function RestSel(fld)
{
  if(fld == "Div")
  {
    document.forms[0].FROMDPT.selectedIndex=0;
    document.forms[0].TODPT.selectedIndex=0;
    document.forms[0].FROMCLS.selectedIndex=0;
  }
  else if(fld == "Dpt")
  {
    document.forms[0].FROMDIV.selectedIndex=0;
    document.forms[0].TODIV.selectedIndex=0;
    document.forms[0].FROMCLS.selectedIndex=0;
  }
  else if(fld == "Cls")
  {
    document.forms[0].FROMDPT.selectedIndex=0;
    document.forms[0].FROMDIV.selectedIndex=0;
    document.forms[0].TODPT.selectedIndex=0;
    document.forms[0].TODIV.selectedIndex=0;
  }
}



// reset store field
function rstStores(obj)
{
  var lng = document.forms[0].STR.length;
  var name = " ";
  var start = 0
  if (obj != null)
  {
    name = obj.value;
  }

  if(name == "ALL") start = 1;
  else if(name == "CMP")
  {
    start = 2;
    document.forms[0].STR[0].checked = false;
  }
  else if(name == "CMPD")
  {
    start = 3;
    document.forms[0].STR[0].checked = false;
    document.forms[0].STR[1].checked = false;
  }


  if(obj == null || name == "ALL" || name == "CMP" || name == "CMPD")
  {

    for(i=start; i<lng; i++)
    {
      document.forms[0].STR[i].checked = false;
    }
  }
  else if(obj != null && obj.checked)
  {
    document.forms[0].STR[0].checked = false;
    document.forms[0].STR[1].checked = false;
    document.forms[0].STR[2].checked = false;
  }
}



// Validate form
function Validate(form){
  var error = false;
  var msg = " ";

  if (form.FROM.value == "")
  {
    msg = "Please, select From weekending date.\n";
    error = true;
  }
  else if(form.TO.value == "")
  {
    msg += "Please, select To weekending date.\n";
    error = true;
  }
  else
  {
    var dtMsg = vldDates();
    if(dtMsg != "")
    {
      msg += dtMsg;
      error = true;
    }
  }

  if (error) alert(msg);
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

// Validate dates
function vldDates()
{
  var msg = "";
  return msg;
}
</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD>


<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-- saved from url=(0088)http://192.168.20.64:8080/servlet/formgenerator.FormGenerator?FormGrp=TICKETS&Form=BBT01 -->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item Sales Report</B>
    </td>
  </tr>
  <tr bgColor=moccasin>
    <td align="left" vAlign=to>
        <br><a href="/"><font color="red" size="-1">Home</font></a>&#62;ThisPage
      <FORM  method="GET" action="ItmSlsRepFldSel.jsp" onSubmit="return Validate(this)">

      <TABLE border=1>
        <TBODY>
        <!-- =============================================================== -->
        <!--                From/To Division -->
        <!-- =============================================================== -->
        <TR>
          <TD align=left nowrap>From Division:</TD>
          <TD align=left >
             <SELECT name="FROMDIV" onchange="RestSel('Div');">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
          </TD>
          <TD align=left>To Division:</TD>
          <TD align=left >
             <SELECT name="TODIV" onchange="RestSel('Div');">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
        </TR>
        <!-- =============================================================== -->
        <!--                From/To Departemnt -->
        <!-- =============================================================== -->
        <TR>
            <TD align=left nowrap>From Department</TD>
            <TD align=left>
               <SELECT name="FROMDPT" onchange="RestSel('Dpt');">
                  <OPTION value="ALL">All Department</OPTION>
                </SELECT>
            </TD>
            <TD align=left nowrap>To Department</TD>
            <TD align=left>
               <SELECT name=TODPT onchange="RestSel('Dpt');">
                  <OPTION value="ALL">All Department</OPTION>
                </SELECT>
            </TD>
        </TR>

        <!-- =============================================================== -->
        <!--                From/To Class  -->
        <!-- =============================================================== -->
        <TR>
            <TD align=left >From Class:</TD>
            <TD align=left>
               <SELECT name="FROMCLS" onchange="RestSel('Cls');">
                  <OPTION value="ALL">All Classes</OPTION>
                </SELECT>
            </TD>
            <TD align=left >To Class:</TD>
            <TD align=left>
               <SELECT name="TOCLS" onchange="RestSel('Cls');">
                  <OPTION value="ALL">All Classes</OPTION>
                </SELECT>
            </TD>
        </TR>
        <!-- =============================================================== -->
        <!--                From/To Vendor  -->
        <!-- =============================================================== -->
        <TR>
            <TD align=left >From Vendor:</TD>
            <TD align=left><input name="FROMVEN" value="ALL"></TD>
            <TD align=left >To Vendor:</TD>
            <TD align=left><input name="TOVEN" value="ALL"></TD>
        </TR>
        <!-- =============================================================== -->
        <!--                From/To Style  -->
        <!-- =============================================================== -->
        <TR>
            <TD align=left >From Style:</TD>
            <TD align=left><input name="FROMSTY" value="ALL"></TD>
            <TD align=left >To Style:</TD>
            <TD align=left><input name="TOSTY" value="ALL"></TD>
        </TR>
        <!-- =============================================================== -->
        <!--                From/To Color  -->
        <!-- =============================================================== -->
        <TR>
            <TD align=left >From Color:</TD>
            <TD align=left><input name="FROMCLR" value="ALL"></TD>
            <TD align=left >To Color:</TD>
            <TD align=left><input name="TOCLR" value="ALL"></TD>
        </TR>
        <!-- =============================================================== -->
        <!--                From/To Size  -->
        <!-- =============================================================== -->
        <TR>
            <TD align=left >From Size:</TD>
            <TD align=left><input name="FROMSIZ" value="ALL"></TD>
            <TD align=left >To Size:</TD>
            <TD align=left><input name="TOSIZ" value="ALL"></TD>
        </TR>
        <!-- =============================================================== -->
        <!--                From/To Store  -->
        <!-- =============================================================== -->
        <TR>
          <TD align=left>Store:</TD>
          <TD align=left colspan="5">
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="ALL">ALL
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="CMP">COMP
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="CMPD">COMP + DC
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="01"> 1
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="03"> 3
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="04"> 4
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="05"> 5
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="08"> 8
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="10">10
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="11">11
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="12">12
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="15">15
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="20">20
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="28">28
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="30">30
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="35">35
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="40">40
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="45">45
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="50">50
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="55">55
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="61">61
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="70">70
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="82">82
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="85">85
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="88">88
                <input name="STR" type="checkbox" onclick="rstStores(this)" value="98">98

          </TD>
        </TR>

        <TR>
            <td align=left >From:</td>
            <td ><input type="text" name="FROM" maxsize="10" size="10">
                   <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FROM)" >
                   <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            <td align=left >To: </td>
            <td ><input type="text" name="TO" maxsize="10" size="10">
                   <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].TO)" >
                   <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TR>
        <TR>
           <TD class=FormTb align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>&nbsp;&nbsp;
               <INPUT type=button value="Reset Stores" name=Reset onclick="rstStores(null)">
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
