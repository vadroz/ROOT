<%@ page import="rciutility.SetStrEmp, payrollreports.SetDaySched"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sWeekDay = request.getParameter("WKDATE");
   String sGrp = request.getParameter("GRP");
   String sAction = request.getParameter("ACTION");
   String sFrom = request.getParameter("FROM");
   String sGrpName = null;

   // defined employy group type
   if(sGrp.equals("MNGR")){sGrpName = "Manager"; }
   else if(sGrp.equals("SLSP")){sGrpName = "Selling Personnel"; }
   else {sGrpName = "Non-Selling Personnel"; }

   // get Employees numbers and names
   SetStrEmp StrEmp = new SetStrEmp(sStore);
   int iNumOfEmp = StrEmp.getNumOfEmp();
   String [] sEmpNum = StrEmp.getEmpNum();
   String [] sEmpName = StrEmp.getEmpName();
   String [] sDptName = StrEmp.getDptName();

   // Hours/Minutes array
   String [] sHrsTxt = new String[]{"07","08","09","10","11","12",
                                 "01","02","03","04","05","06",
                                 "07","08","09","10","11"};
   String [] sHrs = new String[17];
   String [] sMin = new String[]{"00", "30"};
   for(int i=7; i<24;i++){
     sHrs[i-7] = Integer.toString(i);
     if (sHrs[i-7].length()== 1) {
        sHrs[i-7] = "0" + sHrs[i-7];
     }
   }
   StrEmp.disconnect();

   // Get employy list that already scheduled for this day and store
   SetDaySched DaySch = new SetDaySched(sStore, sWeekDay, "ALL");
   String sAll = DaySch.getAllEmp();
%>

<html>
<head>
<SCRIPT language="JavaScript">
	document.write("<style>body {background:ivory;}");
        document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
        document.write("table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}");
        document.write("td.DataTable  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }");
        document.write("td.DataTable1  { background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }");
        document.write("td.DataTable2  { background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }");
        document.write("td.DataTable3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:8px; }");
        document.write("</style>");

//--------------- Global variables -----------------------
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var Month = "<%=sMonth%>"
var WeekEnd = "<%=sWeekEnd%>"
var CurDate = "<%=sWeekDay%>";
var Group = "<%=sGrp%>";
var GrpName = "<%=sGrpName%>";
var Action = "<%=sAction%>";
var From = "<%=sFrom%>";
var AllEmp = null;
<%if(sAll != null && sAll.length() != 0){%>
     AllEmp = [<%=sAll%>];
<%}%>

var EmpName = new Array(<%=sEmpName.length%>);
<%for(int i=0;i < sEmpName.length; i++){ %>
   EmpName[<%=i%>] = "<%=sEmpName[i]%>"
<%}%>

var BegTime = null;
var EndTime = null;
var table = null;
var cells = null;
//--------------- End of Global variables -----------------------

function getEmp(){
  var selInd = document.forms[0].SelEmp.selectedIndex;
  var selEmp = document.forms[0].SelEmp.options[document.forms[0].SelEmp.selectedIndex].value;
  document.forms[0].EmpNum.value = selEmp;
  document.forms[0].EmpName.value = EmpName[selInd];
}

// on body load
function bodyload(){
 document.forms[0].SelEmp.selectedIndex = 0;
 document.forms[0].SelEmp.focus();
}

// check entered time
function enterTime(cur){
 var id = cur.id;

 document.forms[0].ResetEntry.disabled = false;

 if (BegTime != null && EndTime != null){
  return; // do not allow to enter more then 2 cells
 }

 if(cur.className=="DataTable1") {
    cur.className="DataTable2"
    if (BegTime == null) {
        BegTime = cur.id;
    }
    else if(BegTime != cur.id ) {EndTime = cur.id; }
 }
 // initialized table and cells variables

 if(table == null){
    table = document.getElementById("TbHrsEnt");
    cells = table.getElementsByTagName("td");
  }

 // change color for all cells includeed in working time
 if (BegTime != null && EndTime != null){
  var found = false;
  // fix error when in time greater than hout time
  if (BegTime > EndTime){
      var saveTime = BegTime;
      BegTime = EndTime;
      EndTime = saveTime;
  }

  for(var i=0; i < cells.length; i++){
   if (cells.item(i).id == BegTime){  found = true; }
   if (found){ cells.item(i).className="DataTable2"; }
   if (cells.item(i).id == EndTime){ found = false; }
  }
 }
 showTime(cur);
}

// Update readonly field that show selected times
function showTime(cur){
  if (BegTime != null){
    document.forms[0].ShwBegTime.value = BegTime.substring(0,2) + ":" + BegTime.substring(2,4);
    var hrs  = BegTime.substring(0,2)
    var type = " AM"
    if (hrs > "12") {
        hrs = hrs - 12;
        type = " PM"
    }
    var min = BegTime.substring(2,4);
    document.all.dvBegTime.innerHTML= hrs + ":" + min + type
    document.all.dvBegTime.style.visibility="visible"
  }
  if (EndTime != null){
    document.forms[0].ShwEndTime.value = document.forms[0].ShwEndTime.value = EndTime.substring(0,2) + ":" + EndTime.substring(2,4);
    var hrs  = EndTime.substring(0,2)
    var type = " AM"
    if (hrs > "12") {
        hrs = hrs - 12;
        type = " PM"
    }
    var min = EndTime.substring(2,4);
    document.all.dvEndTime.innerHTML= hrs + ":" + min + type
    document.all.dvEndTime.style.visibility="visible"

  }
}

// reset hours by resetentry button
function resetHrs(){
 for(var i=0; i < cells.length; i++){
   if (cells.item(i).id >= "0700" && cells.item(i).id <= "2345")
   cells.item(i).className="DataTable1";
 }
 BegTime = null;
 EndTime = null;

 document.all.dvBegTime.innerHTML= null;
 document.all.dvBegTime.style.visibility="hidden"
 document.all.dvEndTime.innerHTML= null;
 document.all.dvEndTime.style.visibility="hidden"

 document.forms[0].ResetEntry.disabled = true;
 document.forms[0].ShwBegTime.value = "";
 document.forms[0].ShwEndTime.value = "";
}

// Validate form entry values
function Validate(docFrm){
  var EmpNum = docFrm.EmpNum.value;
  var EmpName = docFrm.EmpName.value;
  var bgtm = docFrm.ShwBegTime.value;
  var entm = docFrm.ShwEndTime.value;
  var msg = '';
  var error = false;

  // check Employee Name or Number
  if (EmpNum <= " " && EmpName <= " ") { msg = "Please enter employee name or(and) number. \n";}
  // check Employee Beginning Time
  if (AllEmp != null){
    for(var i = 0; i < AllEmp.length; i++){
      if   (AllEmp[i].substring(0, 4) == EmpNum
         && AllEmp[i].substring(5, EmpName.length + 5) == EmpName) {
            msg += "Selected employee already scheduled for this day. \n";
      }
    }
  }
  if (bgtm <= " ") { msg += "Please enter beginning time. \n"; }
  // check Employee Ending Time
  if (entm <= " ") { msg += "Please enter ending time. \n";  }

  // show error messages
  if (msg != ''){
      error = true;
      alert(msg);
  }

  return error == false;
}

function submit(){
  var EmpNum = document.forms[0].EmpNum.value;
  var EmpName = document.forms[0].EmpName.value;
  var bgtm = document.forms[0].ShwBegTime.value;
  var entm = document.forms[0].ShwEndTime.value;

  // change action string
  SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&WKDATE=" + CurDate
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&GRP=" + Group
                + "&EMPNUM=" + EmpNum
                + "&EMPNAME=" + EmpName
                + "&BEGTIME=" + bgtm
                + "&ENDTIME=" + entm
                + "&ACTION=" + Action
                + "&FROM=" + From;
    //alert(SbmString)
  window.location.href = SbmString;
}

// Open prompt window
function openPromptWdw() {
  var MyURL = 'SelectEmployee.jsp';
  var MyWindowName = 'Test01';
  var MyWindowOptions =
   'width=600,height=400, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';
  window.open(MyURL, MyWindowName, MyWindowOptions);
}
</SCRIPT>
</head>


<!--***********************************************************************-->
<!---------------------- Start Body ----------------------------------------->
<!--***********************************************************************-->
 <body onload="bodyload();">

           <table border="0" width="100%" height="100%">
            <tr>
            <td height="20%" COLSPAN="2">
              <img src="Sun_ski_logo4.png" /></td>
             </tr>
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Enter Employee on Schedule</b><br>
<!------------- end of store selector ---------------------->
        <b>Store:&nbsp;<script>document.write(CurStrName);</script>
        &nbsp; &nbsp; &nbsp; Selected Date &nbsp;<script>document.write(CurDate);</script>
        </b>
<!------------- start Form ------------------------>
    <form name="HRSENTRY" action="javascript: submit();" method="GET" onsubmit="return Validate(this);">
      <table>
         <tr>
           <td>Employee Type:</td><td><font color="darkbrown"><%=sGrpName%></font></td>
           <td >&nbsp;&nbsp;&nbsp;&nbsp;Select Employee&nbsp;&nbsp;
           <a href="javascript:openPromptWdw()"><font size="-2">More...</font></a>
           </td>
         </tr>
         <tr>
           <td>Employee Number:</td>
           <td><input name="EmpNum" type="text" size="4" maxlength="4">&nbsp; - and/or -</td>
           <td rowspan="3">&nbsp;&nbsp;&nbsp;&nbsp;
             <select name="SelEmp" size="3" onclick="getEmp();">
              <%for(int i =0; i < iNumOfEmp; i++){%>
                <option value="<%=sEmpNum[i]%>"><%=sEmpName[i]+ " / " + sDptName[i]%></option>
              <%}%>
             </select></td>
         </tr>
         <tr>
           <td>Employee Name:</td>
           <td><input name="EmpName" type="text" size="35" maxlength="35"></td>
         </tr>
       </table>
   <!------------- Hours Entry ------------------------>
       <table class="DataTable" cellPadding="0" cellSpacing="0" id="TbHrsEnt">
         <tr><td class="DataTable" colspan="50">
              Working Hours Entry - click on white cells to select a time, to change - click on reset button
             </td></tr>

         <tr >
           <td class="DataTable" rowspan="3">&nbsp;<button name="ResetEntry" type="button" DISABLED onclick="resetHrs();">Reset</button>&nbsp;</td>
         <%for(int i=0; i < sHrs.length;i++){%>
          <td class="DataTable" colspan="<%=sMin.length%>"><%=sHrsTxt[i]%></td>
         <%}%>
         </tr>
         <tr >
         <%for(int i=0, k=0; i < (sHrs.length * sMin.length); i++, k++){
             if(k >= sMin.length) k=0; %>
          <td class="DataTable3"><%=sMin[k]%></td>
         <%}%>
         </tr>
         <tr>
       <% for(int i=0; i < sHrs.length; i++){ %>
         <% for(int k=0; k < sMin.length; k++){ %>
              <td class="DataTable1" id="<%=sHrs[i]%><%=sMin[k]%>" onclick="enterTime(this);">&nbsp;</td>
          <%}%>
        <%}%>
         </tr>
       </table>
      <!------------- Show selected Hours ------------------------>
       <table width="50%">
         <tr>
           <td align="right" width="15%">Beginning at:</td>
           <td align="left" width="35%"><div id="dvBegTime"  style="visibility:hidden; color:brown; font-weight:bolder "></div></td>
           <td align="right" nowrap>Ending at:</td>
           <td align="left" nowrap><div id="dvEndTime"  style="visibility:hidden; color:brown; font-weight:bolder "></div></td>
         </tr>
         <tr>
           <td align="center">
           <input name="Submit" type="Submit" ></td>
         </tr>
       </table>

      <input name="ShwBegTime" type="hidden" size="5">
      <input name="ShwEndTime" type="hidden" size="5">
      </form>
<!------------- end Form ------------------------>
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a>&#62;
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red"  size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
            <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}
        else {%>
          <a href="FiscalMonthSel.jsp"><font color="red" size="-1">Store/Month Selector</font></a>&#62;
          <a href="FiscalMonthBudget.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>">
              <font color="red" size="-1">Fiscal Month Budget</font></a>&#62;
        <%}%>
        <a href="SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&FROM=<%=sFrom%>">
          <font color="red"  size="-1">Weekly Schedule</font></a>&#62;
        <a href="SchedbyDay.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>">
          <font color="red" size="-1">Daily Schedule</font></a>&#62;
        <font size="-1">This page</font>
<!-------------------------------------------------------->
                </td>
            </tr>
       </table>

        </body>
      </html>
