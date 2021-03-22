<%@ page import="payrollreports.BaseSchedWkAdj, java.util.*, java.text.*"%>
<%
   String sWkend = request.getParameter("Wkend");
   String sUser = session.getAttribute("USER").toString();

   String sAppl = "PAYROLL";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=BaseSchedWkAdjSel.jsp&APPL=" + sAppl);
}
else
{
    BaseSchedWkAdj bswkadj = new BaseSchedWkAdj(sWkend, sUser);
    int iNumOfStr = bswkadj.getNumOfStr();
    String [] sStr = bswkadj.getStr();
    String [] sWkPlan = bswkadj.getWkPlan();
    String [] sBsPlan = bswkadj.getBsPlan();
    String [] sWkSchHrs = bswkadj.getWkSchHrs();
    String [] sWkBdgHrs = bswkadj.getWkBdgHrs();
    String [] sBsSchHrs = bswkadj.getBsSchHrs();
    String [] sBsSlsAdj = bswkadj.getBsSlsAdj();
    String [] sBsHrsAdj = bswkadj.getBsHrsAdj();

    String sStrJvs = bswkadj.getStrJvs();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}

        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }

        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable { background: #e7e7e7; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmpList { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSlsGoal { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}

        div.dvWkSel { border: black solid 2px; position:absolute; background-attachment: scroll;
                      width:200; background-color:LemonChiffon; z-index:10;
                      text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>
<script LANGUAGE="JavaScript" src="Calendar.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var Store = [<%=sStrJvs%>];
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   doSelDate();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * (dofw - 7));
  document.all.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// validate adjustments
//==============================================================================
function  validateAdj()
{
   var slsAdj = new Array();
   var hrsAdj = new Array();
   var str = new Array();
   for(var i=0, j=0; i < Store.length; i++)
   {
      var sls = document.all.SlsAdj[i].value.trim();
      var hrs = document.all.HrsAdj[i].value.trim();
      if(sls != "" && sls != "0" || hrs != "" && hrs != "0")
      {
        str[j] = Store[i];
        slsAdj[j] = sls;
        hrsAdj[j] = hrs;
        j++;
      }
   }
   sbmAdjSv(str, slsAdj, hrsAdj);
}
//==============================================================================
// submit adjustment changes
//==============================================================================
function sbmAdjSv(str, slsAdj, hrsAdj)
{
   var url = "BaseSchedWkAdjSave.jsp?Wkend=<%=sWkend%>"
   for(var i=0; i < str.length; i++){ url += "&Str=" + str[i]; }
   for(var i=0; i < str.length; i++){ url += "&Sls=" + slsAdj[i]; }
   for(var i=0; i < str.length; i++){ url += "&Hrs=" + hrsAdj[i]; }

   //alert(url)
   window.frame1.location.href = url
}
//==============================================================================
// return to select screen
//==============================================================================
function returnToSelect()
{
   window.location.href = "BaseSchedWkAdjSel.jsp";
}
//==============================================================================
// show different week
//==============================================================================
function sbmReport()
{
   var wkend = document.all.Wkend.value
   window.location.href = "BaseSchedWkAdj.jsp?Wkend=" + wkend;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSlsGoal" class="dvSlsGoal"></div>
<div id="dvEmpList" class="dvEmpList"></div>
<!----------------------------------------------------------------------------->
<div id="dvWkSel" class="dvWkSel">
  <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend')">&#60;</button>
  <input name="Wkend" class="Small" type="text" size=10 maxlength=10 readonly>&nbsp;
  <button class="Small" name="Up" onClick="setDate('UP', 'Wkend')">&#62;</button>
  <a href="javascript:showCalendar(1, null, null, 10, 90, document.all.Wkend)" >
  <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
  <br><button class="Small" onClick="sbmReport()">Submit</button>
</div >
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Base Schedule Sales Threshold and Hourly Employee Hours Adjustments
      <br>Weekending Date: <%=sWkend%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <a href="BaseSchedWkAdjSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th class="DataTable" rowspan=2><button class="Small" onClick="validateAdj();">Save Changes</button></th>
          <th class="DataTable" colspan="<%=iNumOfStr%>">Store List</th>
        </tr>

        <tr>
          <%for(int i=0; i < iNumOfStr; i++){%>
            <th class="DataTable"><%=sStr[i]%></th>
          <%}%>
        </tr>

        <!-- ======================== Store Value List ===================== -->

        <!-- ===================== Sales =================================== -->
        <tr class="DataTable">
          <td nowrap>Weekly Sales Plan</td>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="DataTable2" nowrap>$<%=sWkPlan[i]%></td>
          <%}%>
        </tr>

        <tr class="DataTable">
          <td nowrap>Base Schedule Sales Threshold</td>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="DataTable2" nowrap>$<%=sBsPlan[i]%></td>
          <%}%>
        </tr>

        <tr class="DataTable">
          <td nowrap>Sales Threshold Adjustment (in 1k)</td>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td><input maxlength=3 size=3 name="SlsAdj" class="Small"
                onKeyDown="if(event.keyCode==13) event.keyCode=9;"
                <%if(!sBsSlsAdj[i].equals("0")){%>value="<%=sBsSlsAdj[i]%>"<%}%>>
             </td>
          <%}%>
        </tr>

        <!-- ===================== Hours =================================== -->
        <tr class="DataTable">
          <td nowrap>Weekly Schedule Hours</td>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="DataTable2" nowrap><%=sWkSchHrs[i]%></td>
          <%}%>
        </tr>

        <tr class="DataTable">
          <td nowrap>Weekly Budget Hours</td>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="DataTable2" nowrap><%=sWkBdgHrs[i]%></td>
          <%}%>
        </tr>

        <tr class="DataTable">
          <td nowrap>Base Schedule Hours</td>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="DataTable2" nowrap><%=sBsSchHrs[i]%></td>
          <%}%>
        </tr>

        <tr class="DataTable">
          <td nowrap>Hourly Employee Hour Adjustment</td>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td><input  maxlength=4 size=4 name="HrsAdj" class="Small"
                onKeyDown="if(event.keyCode==13) event.keyCode=9;"
                <%if(!sBsHrsAdj[i].equals("0")){%>value="<%=sBsHrsAdj[i]%>"<%}%>>
             </td>
          <%}%>
        </tr>

    </table>
    <!----------------------- end of table ---------------------------------->


  </table>
 </body>

</html>

<%}%>






