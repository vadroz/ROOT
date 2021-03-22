<%@ page import=" rciutility.ClassSelect, rciutility.SetWeeks, rciutility.StoreSelect"%>
<%
   ClassSelect select = new ClassSelect("order by ccls");
   String sDiv = select.getDivNum();
   String sDivName = select.getDivName();
   String sDpt = select.getDptNum();
   String sDptName = select.getDptName();
   String sCls = select.getClsNum();
   String sClsName = select.getClsName();

   // Get year weeks
   int iNumOfYr = 4;
   SetWeeks setweeks = new SetWeeks(iNumOfYr);
   setweeks.set4Week();
   String [] sYear = setweeks.get4Years();
   int [] iNumOfWk = setweeks.getNumOfWk();
   String sNumOfWkJSA = setweeks.getNumOfWkJSA();
   String [][] s4YrWeek = setweeks.get4YrWeek();
   String [][] sMonthName = setweeks.getMonthName();
   String [][] sNumOfWkMon = setweeks.getNumOfWkMon();
   int iCurWk = setweeks.getCurWk();

   StoreSelect strsel = new StoreSelect(4);
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStr = strsel.getStrLst();

   setweeks.disconnect();
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
   .Small {font-size:10px}
</style>
<!-- ------------------------- End Style ------------------------------ -->


<script name="javascript">
var NumOfWk = [<%=sNumOfWkJSA%>];
var NumOfYr = <%=iNumOfYr%>
var fromDate;
var toDate;

var fromRow;
var toRow;
var fromCol;
var toCol;
var SelType;
var DivSelType = true;
var divisions = [<%=sDiv%>];
var divisionNames = [<%=sDivName%>];

//==============================================================================
// initial process
//==============================================================================
function bodyLoad(){
  var df = document.forms[0];

  chgDivSelType();
  doDivSelect();
  doDptSelect();
  doClsSelect();
  document.forms[0].DateType[0].checked=true
  chgDateSel('W');

  setMultDiv();
}
//==============================================================================
// Select Classes
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
// load divisions
//==============================================================================
function doDivSelect() {
    var df = document.forms[0];
    var allowed;
        //  populate the division list
        for (idx = 0; idx < divisions.length; idx++)
            df.DIVISION.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        id = 0;
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
        for (idx = 0; idx < depart.length; idx++)
            df.DEPARTMENT.options[idx] = new Option(departNames[idx],depart[idx]);
        id = 0;
}

//-------------------------------------------------------------------
// Reset slected fields
//-------------------------------------------------------------------
function RestSel(fld)
{
  if(fld == "Div")
  {
    document.forms[0].DEPARTMENT.selectedIndex=0;
    document.forms[0].CLASS.selectedIndex=0;
  }
  else if(fld == "Dpt")
  {
    document.forms[0].DIVISION.selectedIndex=0;
    document.forms[0].CLASS.selectedIndex=0;
  }
  else if(fld == "Cls")
  {
    document.forms[0].DEPARTMENT.selectedIndex=0;
    document.forms[0].DIVISION.selectedIndex=0;
  }
}

//==============================================================================
// Select Date
//==============================================================================
function selDate(date, row, col, type)
{
  var lastYear = type == "Y" && row == "7" && col == "0";
  if (SelType == type && !lastYear)
  {
    if(fromDate==null)
    {
      fromDate = date;
      fromRow = row;
      fromCol = col;
      document.all.dvFrom.innerHTML= "<b>" + date + "<b>"
      document.all.dvFrom.style.visibility="visible"
      document.forms[0].FROM.value = date
    }
    else if(toDate==null)
    {
      toDate = date;
      toRow = row;
      toCol = col;
      document.all.dvTo.innerHTML= "<b>" + date + "<b>"
      document.all.dvTo.style.visibility="visible"
      document.forms[0].TO.value = date
    }
    else
    {
      alert("From and To weekending dates already selected.\nPlease, press Reset Dates button." );
    }
  }
  else (alert("You click on date in the wrong column."))
}
//==============================================================================
// reset dates
//==============================================================================
function rstDates()
{
    fromDate = null;
    fromRow = null;
    fromCol = null;
    document.all.dvFrom.style.visibility="hidden"
    document.forms[0].FROM.value = "";
    toDate = null;
    toRow = null;
    toCol = null;
    document.all.dvTo.style.visibility="hidden"
    document.forms[0].TO.value = "";
}
//==============================================================================
// reset store field
//==============================================================================
function rstStores(grp)
{
   var strchk = document.all.STR

   for(var i=0; i < strchk.length; i++)
   {
      strchk[i].checked = false;
      if(grp=="ALL") { strchk[i].checked = true}
      else if(grp=="CMP" && strchk[i].value != 1 && strchk[i].value != 2 && strchk[i].value != 6
        && strchk[i].value != 55 && strchk[i].value != 60 && strchk[i].value != 70
        && strchk[i].value != 71 && strchk[i].value != 75 && strchk[i].value != 85
        && strchk[i].value != 86 && strchk[i].value != 89 && strchk[i].value != 99
        && strchk[i].value != 100 && strchk[i].value != 101 && strchk[i].value != 102
        && strchk[i].value != 199 && strchk[i].value != 63 && strchk[i].value != 93
        && strchk[i].value != 56&& strchk[i].value != 59)
      { strchk[i].checked = true}
      else if(grp=="CMPD" && strchk[i].value != 2 && strchk[i].value != 6
        && strchk[i].value != 55 && strchk[i].value != 60 && strchk[i].value != 70
        && strchk[i].value != 71 && strchk[i].value != 75 && strchk[i].value != 85
        && strchk[i].value != 86 && strchk[i].value != 89 && strchk[i].value != 99
        && strchk[i].value != 100 && strchk[i].value != 101 && strchk[i].value != 102
        && strchk[i].value != 199 && strchk[i].value != 63 && strchk[i].value != 93
        && strchk[i].value != 56&& strchk[i].value != 59)
      { strchk[i].checked = true}
   }
}

//==============================================================================
// changed date selection - week, month, year
//==============================================================================
function chgDateSel(type)
{
  SelType = type;

  if(type=='W')
  {
    chgTblCellClr("W", 60, "blue", "hand");
    chgTblCellClr("M", 12, "black", "text");
    chgTblCellClr("Y", 1, "black", "text");
  }
  else if(type=='M')
  {
    chgTblCellClr("M", 12, "blue", "hand");
    chgTblCellClr("W", 60, "black", "text");
    chgTblCellClr("Y", 1, "black", "text");
  }
  else if(type=='Y')
  {
    chgTblCellClr("Y", 1, "blue", "hand");
    chgTblCellClr("M", 12, "black", "text");
    chgTblCellClr("W", 60, "black", "text");
    var id = type + (NumOfYr-1) + 0;
    document.getElementById("Y70").style.cursor="text";
    document.getElementById("Y70").style.color="black";
  }
}

//==============================================================================
// change colors on weekend table cells
//==============================================================================
function chgTblCellClr(type, max, color, cursor)
{
  for (i=0; i<max; i++)
  {
    for(k=0; k<NumOfYr; k++)
    {
      id = type + k + i;
      if(document.getElementById(id))
      {
       document.getElementById(id).style.cursor=cursor;
       document.getElementById(id).style.color=color;
      }
    }
  }
}
//==============================================================================
// Validate form
//==============================================================================
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
  var str = form.STR
  var strchk = false;
  for(var i=0; i < str.length; i++)
  {
     if(str[i].checked) { strchk = true; }
  }
  if(!strchk)
  {
    msg += "Please, select at least one store.\n";
    error = true;
  }

  // check that at least division selected if multiple choice selected
  if(DivSelType)
  {
      var div = document.all.DIVM
      var divchk = false;
      var coma = "";
      var divarrsel = "";
      for(var i=0; i < div.length; i++)
      {
         if(div[i].checked) { divchk = true; divarrsel += coma + i; coma = ","}
      }
      if(!divchk)
      {
         msg += "Please, select at least one division.\n";
         error = true;
      }
      else
      {
         document.all.DivArrSel.value = divarrsel;
      }
  }

  if (error) alert(msg);
  return error == false;
}
//==============================================================================
// Validate dates
//==============================================================================
function vldDates()
{
  var msg = "";
  if(toCol < fromCol || toCol == fromCol && toRow < fromRow)
  {
     msg = "To date cannot be greater than From date.\n";
  }
  else
  {
     var mon = 0;
     for(i = fromCol; i < toCol; i++)
     {
          mon = parseFloat(mon)  + parseFloat(NumOfWk[i]);
     }
     SelType
     mon = parseFloat(mon) + parseFloat(toRow) - parseFloat(fromRow) + 1;
     if (SelType=="W" && parseFloat(mon) > 72) { msg = mon + " has been selected. Only 72 weeks is allowed.\n"; }
  }

  return msg;
}

//==============================================================================
// change Division Selection type - Multiple/Single
//==============================================================================
function chgDivSelType()
{
   var single = "none"
   var mult = "block"
   if (DivSelType) { single = "block"; mult = "none" }
   document.all.trDivDpt.style.display = single
   document.all.trClass.style.display = single
   document.all.trMultDiv.style.display = mult

   DivSelType = !DivSelType;
   document.all.DivSelType.value = DivSelType;
}
//==============================================================================
// set Multiple Divisions
//==============================================================================
function setMultDiv()
{
   var html = "";

   //  populate the division list
   for (var i = 1; i < divisions.length; i++)
   {
      html += "<input name='DIVM' type='checkbox' value='" + divisions[i] + "'>"
            + divisions[i] + "&nbsp; &nbsp;"
      if(i== 18) { html += "<br>" }
   }

   document.all.dvDivMult.innerHTML = html;
}
</script>


<HTML><HEAD>


<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-- saved from url=(0088)http://192.168.20.64:8080/servlet/formgenerator.FormGenerator?FormGrp=TICKETS&Form=BBT01 -->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>GM Data Download</B>

      <FORM  method="GET" action="ClsSlsRepFldSel.jsp" onSubmit="return Validate(this)">
      <input type="hidden" name="DivSelType">
      <input type="hidden" name="DivArr" value="<%=sDiv%>">
      <input type="hidden" name="DivArrSel">

      <TABLE border=1>
        <TBODY>

      <TR id="trMultDiv">
      <!--  ================================================================ -->
      <!--        Division   -->
      <!--  ================================================================ -->
          <TD class=FormTb align=right>Division:</TD>
          <TD class=FormTb align=left colspan=4>
             <div id="dvDivMult"></div>
             <button class="Small" onclick="chgDivSelType()" >Single</button>
          </TD>
      </tr>

      <TR id="trDivDpt">
      <!--  ================================================================ -->
      <!--        Division   -->
      <!--  ================================================================ -->
          <TD class=FormTb align=right>Division:</TD>
          <TD class=FormTb align=left>
             <SELECT name="DIVISION" onchange="RestSel('Div');">
                <OPTION value="ALL">All Division</OPTION>
             </SELECT> &nbsp;
             <button class="Small" onclick="chgDivSelType()" >Multiple</button>
          </TD>
      <!--  ================================================================ -->
      <!--        Department   -->
      <!--  ================================================================ -->
            <TD nowrap class=FormTb align=center>- or -</TD>
            <TD class=FormTb align=right >Department</TD>
            <TD class=FormTb align=left>
               <SELECT name="DEPARTMENT" onchange="RestSel('Dpt');">
                  <OPTION value="ALL">All Department</OPTION>
                </SELECT>
            </TD>
        </TR>

      <!--  ================================================================ -->
      <!--        Class   -->
      <!--  ================================================================ -->
         <TR id="trClass">
            <TD class=FormTb align=right >Class:</TD>
            <TD class=FormTb align=left>
               <SELECT name="CLASS" onchange="RestSel('Cls');">
                  <OPTION value="ALL">All Classes</OPTION>
                </SELECT>
            </TD>
        </TR>
        <TR>
        <!--  ================================================================ -->
      <!--        Store   -->
      <!--  ================================================================ -->
          <TD class=FormTb align=right>Store:</TD>
          <TD class=FormTb align=left colspan="4">
                <button class="Small" onclick="rstStores('ALL')" value="ALL">ALL</button>
                <button class="Small" onclick="rstStores('CMP')" value="ALL">CMP</button>
                <button class="Small" onclick="rstStores('CMPD')" value="ALL">CMPD</button>
                <button class="Small" onclick="rstStores('NONE')" value="ALL">Reset</button>

                <table border=0 cellPadding=0 cellSpacing=0 style="font-size:10px">
                   <%for(int i=0; i < iNumOfStr; i++){%>
                      <%if(i == iNumOfStr / 2){%><tr><%}%>
                      <td><input class="Small" name="STR" type="checkbox"  value="<%=sStr[i]%>"><%=sStr[i]%> &nbsp;</td>
                   <%}%>
                </table>
          </TD>
        </TR>
      <!--  ================================================================ -->
      <!--       Date     -->
      <!--  ================================================================ -->
        <TR>
            <td class="FormTb" align=right >From:</td>
            <td class="FormTb"><div id="dvFrom"></div>
                 <INPUT type="hidden"  name="FROM"></td>
            <td class=FormTb align=left >To: </td>
            <td class="FormTb"><div id="dvTo"></div>
                 <INPUT type="hidden"  name="TO"></td>
          </TR>
        <TR>
           <TD class=FormTb align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>&nbsp;&nbsp;
               <INPUT type=button value="Reset Stores" name=Reset onclick="rstStores(null)">
               <INPUT type=button value="Reset Dates" name=Reset onclick="rstDates()">
           </TD>
          </TR>
<!-- ---------------Week selection table -------------------------------- -->
     <TR>
      <TD align="center" colspan="5">
       <table class="DataTable" width="100%" cellPadding="0" cellSpacing="0">
         <!-- header 1 line -->
         <tr>
         <th class="DataTable" colspan="32">
           Week<input name="DateType" value="W" type="radio" onclick="chgDateSel('W')" checked>
           Month<input name="DateType" value="M" type="radio" onclick="chgDateSel('M')">
           Year<input name="DateType" value="Y" type="radio" onclick="chgDateSel('Y')">
         </tr>
         <tr>
          <%for(int i=0; i < iNumOfYr; i++){%>
           <th class="DataTable" colspan="3" id="Y<%=i%>0"
                onclick="selDate('<%=sYear[i]%>', <%=i%>, <%=0%>, 'Y')">
                <%=sYear[i]%></th>
           <th class="DataTable" >&#160;&#160;</th>
          <%}%>
         </tr>
         <!-- header 2 line -->
         <tr>
          <%for(int i=0; i < iNumOfYr; i++){%>
           <th class="DataTable" >Month</th>
           <th class="DataTable" >&#160;</th>
           <th class="DataTable" >Weekending</th>
           <th class="DataTable" >&#160;&#160;</th>
          <%}%>
         </tr>

        <% int [] week= new int[iNumOfYr]; for(int i=0; i < iNumOfYr; i++){week[i]=10;}
           int [] month = new int[iNumOfYr]; for(int i=0; i < iNumOfYr; i++){month[i]=-1;}

           for(int i=0; i < 53; i++){%>
           <tr>
           <%for(int k=0; k < iNumOfYr; k++){%>
              <%if(iNumOfWk[k] > i){
                   // month name
                   if(month[k] < 0 || week[k] >= Integer.parseInt(sNumOfWkMon[k][month[k]]))
                   {
                      week[k] = 0;
                      month[k] += 1; %>
                     <td class="DataTable" id="M<%=k%><%=month[k]%>"
                         onclick="selDate('<%=sYear[k]%>/<%=sMonthName[k][month[k]]%>', <%=i%>, <%=k%>, 'M')"
                         rowspan="<%=sNumOfWkMon[k][month[k]]%>">
                          <%=sMonthName[k][month[k]]%></td>
                 <%}
                   week[k] += 1;
                   %>
                <td class="DataTable"><%=week[k]%></td>

                <%if(k==iNumOfYr-1 && i >= iCurWk){%>
                  <td class="DataTable1"><%=s4YrWeek[k][i]%></td>
                <%}
                  else{ %>
                  <td class="DataTable" id="W<%=k%><%=i%>"
                       onclick="selDate('<%=s4YrWeek[k][i]%>', <%=i%>, <%=k%>, 'W')">
                      <%=s4YrWeek[k][i]%></td>
                <%}%>
              <%}
                else{%>
                <th class="DataTable">&#160;</th>
                <th class="DataTable">&#160;</th>
                <th class="DataTable">&#160;</th>
              <%}%>
              <th class="DataTable" >&#160;</th>
            <%}%>
           </tr>
         <%}%>
       </table>
      </TD>
     </TR>
<!-- ---------------Week selection table -------------------------------- -->

         </TBODY>
        </TABLE>
       </FORM>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
