<%@ page import="rciutility.StoreSelect, payrollreports.BasicEmp, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   if (sStore == null) sStore = "3";

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String sUser = " ";

   int iNumOfEmp = 0;
   String [] sEmp = null;
   String [] sFName = null;
   String [] sLName = null;
   String [] sTitle = null;
   String [] sDept = null;
   String [] sHorS = null;
   String [] sRate = null;
   String [] sSCom = null;

   String sEmpJSA = null;
   String sFNameJSA = null;
   String sLNameJSA = null;
   String sTitleJSA = null;
   String sDeptJSA = null;
   String sHorSJSA = null;
   String sRateJSA = null;
   String sSComJSA = null;

   int iNumOfDpt = 0;
   String sDeptListJSA = null;
   String sDeptNameJSA = null;

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BasicEmp.jsp&APPL=" + sAppl);
   }
   else {
     sAccess = session.getAttribute("ACCESS").toString();
     sUser = session.getAttribute("USER").toString();
     sStrAllowed = session.getAttribute("STORE").toString();

  // -------------- End Security -----------------

   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
      StrSelect = new StoreSelect(4);
   }
   else
   {
      StrSelect = new StoreSelect(sStrAllowed);
   }


   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   if (!sStrAllowed.trim().equals("ALL")) sStore = sStrAllowed;

   //do not allow work with application for acess<>1
     if (!sStrAllowed.startsWith("ALL"))
     {
        response.sendRedirect("index.jsp");
     }

   BasicEmp bscEmp = new BasicEmp(sStore);

   iNumOfEmp = bscEmp.getNumOfEmp();
   sEmp = bscEmp.getEmp();
   sFName = bscEmp.getFistName();
   sLName = bscEmp.getLastName();
   sTitle = bscEmp.getTitle();
   sDept = bscEmp.getDept();
   sHorS = bscEmp.getHorS();
   sRate = bscEmp.getRate();
   sSCom = bscEmp.getSCom();
   sEmpJSA = bscEmp.getEmpJSA();
   sFNameJSA = bscEmp.getFNameJSA();
   sLNameJSA = bscEmp.getLNameJSA();
   sTitleJSA = bscEmp.getTitleJSA();
   sDeptJSA = bscEmp.getDeptJSA();
   sHorSJSA = bscEmp.getHorSJSA();
   sRateJSA = bscEmp.getRateJSA();
   sSComJSA = bscEmp.getSComJSA();

   iNumOfDpt = bscEmp.getNumOfDpt();
   sDeptListJSA = bscEmp.getDeptListJSA();
   sDeptNameJSA = bscEmp.getDeptNameJSA();

   bscEmp.disconnect();
  }
%>
<html>
<head>

<style>
 body {background:ivory;}
 a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
 table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
 th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

 tr.DataTable  { background: lightgrey; font-family:Arial; font-size:10px }
 tr.DataTable1 { background: white; font-family:Arial; font-size:10px }
 tr.DataTable2 { background: pink; font-family:Arial; font-size:10px }

 td.DataTable  { border-top:darkred solid 1px; border-right:darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:left }
 td.DataTable1 { border-top:darkred solid 1px; border-right:darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:center }
 td.DataTable2 { border-top:darkred solid 1px; border-right:darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right}
 td.DataTable3 { cursor:hand; border-top:darkred solid 1px; border-right:darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:center }

 input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
 select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
 button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
 textarea.small{ text-align:left; font-family:Arial; font-size:10px;}

 td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
 td.Grid1 { cursor: hand; text-align:center; font-family:Arial; font-size:10px;}
 td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}
 td.Grid3 { cursor: hand; text-align:right; font-family:Arial; font-size:10px;}

 td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
 td.Menu1  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:12px; }
 td.Menu2  {text-align:right; font-family:Arial; font-size:12px; }
 td.Menu3  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:10px; }

 div.Menu  {position:absolute;visibility:hidden; background-attachment: scroll;
            border: black solid 3px; width:150px;background-color:Azure; z-index:10;
            text-align:center;}
 div.SetMenu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
</style>

<SCRIPT language="JavaScript">
var StrAlllowed;
var FName;
var LName;
var Title;
var Dept;
var HorS;
var Rate;
var SCom;

var NumOfDpt = 0;
var DeptList;
var DeptName;

<%if(sStrAllowed!=null){%>
  StrAllowed = "<%=sStrAllowed.trim()%>";
  EmpNum = [<%=sEmpJSA%>];
  FName = [<%=sFNameJSA%>];
  LName = [<%=sLNameJSA%>];
  Title = [<%=sTitleJSA%>];
  Dept = [<%=sDeptJSA%>];
  HorS = [<%=sHorSJSA%>];
  Rate = [<%=sRateJSA%>];
  SCom = [<%=sSComJSA%>];

  NumOfDpt = <%=iNumOfDpt%>;
  DeptList = [<%=sDeptListJSA%>];
  DeptName = [<%=sDeptNameJSA%>];
<%}%>

var Stores = [<%=sStr%>];
var StrNames = [<%=sStrName%>];
var CurStore = "<%=sStore.trim()%>";

var SelEmp;
var Action;

// populate selection fields on page load
function bodyLoad()
{
doStrSelect();
}

// Load Stores
function doStrSelect() {
    var df = document.all;

    for (idx = 1; idx < Stores.length; idx++)
    {
      df.STORE.options[idx-1] = new Option(Stores[idx] + " - " + StrNames[idx],Stores[idx]);
      if (Stores[idx] == CurStore)
      {
        df.STORE.selectedIndex=idx-1;
      }
    }
}

//======================== Menu ================================================
function CellMenu(obj, idx)
{
  var emp = EmpNum[idx];
  var fname = FName[idx];
  var lname = LName[idx];

  var Menu;
  var MenuEmp = "<td class='Grid' nowrap><b>&nbsp;&nbsp;" + emp
    + " " + fname + " " + lname + "&nbsp;&nbsp;</b>" + "</td>";
  var MenuDlt = "<tr><td class='Menu' onclick='dltEmpSbm(&#34;"
    + emp + "&#34;); hideMenu();'>Delete</td></tr>";
  var MenuChg = "<tr><td class='Menu' onclick='setEmpMenu("
    + idx + ",&#34;CHG&#34;);'>Change</td></tr>";
  var MenuCpy = "<tr><td class='Menu' onclick='setEmpMenu("
    + idx + ",&#34;CPY&#34;);'>Copy</td></tr>";

  var curLeft = 0;
  var curTop = 0;
  MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
   + MenuEmp
   + "<td class='Grid2' valign=top>"
   +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
   + "</td></tr>"
   + MenuChg + MenuCpy + MenuDlt
   + "<tr><td colspan='2' class='Menu' align='center' "
   + "onclick='hideMenu();'>Close"
   + "</td></tr>"
   + "</table>"

 // position menu close to cell area
 if (obj.offsetParent) {
   while (obj.offsetParent){
     curLeft += obj.offsetLeft
     curTop += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    curLeft += obj.x;
    curTop += obj.y;
 }


    if (curTop > (document.documentElement.scrollTop + screen.height - 250))
    {
      curTop = document.documentElement.scrollTop + screen.height - 300;
    }
    curLeft += 70;
    if (curLeft > (document.documentElement.scrollLeft + screen.width - 200))
    {
      curLeft = document.documentElement.scrollLeft + screen.width - 200;
    }

  document.all.menu.className="Menu";
  document.all.menu.innerHTML=MenuHtml
  document.all.menu.style.pixelLeft=curLeft
  document.all.menu.style.pixelTop=curTop
  document.all.menu.style.visibility="visible"
}

// Show Add/chg Employee menu
function setEmpMenu(idx, act)
{
    var emp;
    var fname;
    var lname;

  if(idx!=null)
  {
    emp = EmpNum[idx];
    fname = FName[idx];
    lname = LName[idx];
  }

  var Menu;
  var MenuEmp;
  if(idx != null)
  {
    MenuEmp = "<td class='Grid' nowrap><b>&nbsp;&nbsp;" + emp
      + " " + fname + " " + lname + "&nbsp;&nbsp;</b>" + "</td>";
  }
  else  MenuEmp = "<td class='Grid' nowrap><b>&nbsp;&nbsp;"
           + "New Employee&nbsp;&nbsp;</b></td>";

  var MenuSet = "<tr><td class='Grid1' nowrap>"
    + "<table width='100%' cellPadding='0' cellSpacing='0'>"
     + "<tr><td class='Grid3'>First Name:&#160;</td><td><input class='small' type='text' name='FName' size='15' maxlength='15'></td></tr>"
     + "<tr><td class='Grid3'>Last Name:&#160;</td><td><input class='small' type='text' name='LName' size='15' maxlength='15'></td></tr>"
     + "<tr><td class='Grid3'>Title:&#160;</td><td><input class='small' type='text' name='Title'  size='12' maxlength='12'></td></tr>"
     + "<tr><td class='Grid3'>Salary type:&#160;</td><td class='Grid1'><input class='small' type='radio' name='Salary' value='H' checked>Hourly"
     + "&#160;&#160;&#160;&#160;<input class='small' type='radio' name='Salary' value='S'>Salary</td></tr>"
     + "<tr><td class='Grid3'>&#160;Department:&#160;</td><td><select class='small' name='Dept'></select></td></tr>"
     + "<tr><td class='Grid3'>Rate:&#160;</td><td><input class='small' type='text' name='Rate'  size='11' maxlength='11'></td></tr>"
     + "<tr><td class='Grid3'>Commision:&#160;</td>"
     + "<td  class='Grid1'><input class='small' type='radio' name='SCom' value='R'>Regular&#160;&#160;&#160;&#160;"
     + "<input class='small' type='radio' name='SCom' value='S'>Special&#160;&#160;&#160;&#160;"
     + "<input class='small' type='radio' name='SCom' value='N' checked>None"
     + "</td></tr>"
    + "</table>"
    + "</td></tr>";

  var curLeft = 0;
  var curTop = 0;
  MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
   + MenuEmp
   + "<td class='Grid2' valign=top>"
   +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
   + "</td></tr>"
   + MenuSet
   + "<tr><td colspan='2' class='Grid1' align='center'>"
   + "<button class='small' onclick='if(validEmp()){ submitEmp()}'>Add/Change</button>&#160;&#160;"
   + "<button class='small' onclick='hideMenu();'>Close</button>"
   + "</td></tr>"
   + "<tr><td></td></tr><tr><td></td></tr>"
   + "</table>"

  document.all.menu.className="SetMenu";
  document.all.menu.innerHTML=MenuHtml
  document.all.menu.style.pixelLeft=260
  document.all.menu.style.pixelTop=document.documentElement.scrollTop+100
  document.all.menu.style.visibility="visible"

  SelEmp = emp;
  if(act=="ADD") Action="ADD";
  else
  {
    if(act=="CPY") Action="ADD";
    else Action="CHG";
    document.all.FName.value = FName[idx];
    document.all.LName.value = LName[idx];
    document.all.Title.value = Title[idx];
    // Do not show salary for management people
    if (Title[idx] != "MGR 40" && Title[idx] != "ASTMGR40"
     && Title[idx] != "SRASST4") document.all.Rate.value = Rate[idx];

    // unchecked salary type
    for(i=0; i<2;i++)
    {
     document.all.Salary[i].checked = false;
    }
    if(HorS[idx]=='H')  document.all.Salary[0].checked = true;
    if(HorS[idx]=='S')  document.all.Salary[1].checked = true;

    for(i=0; i<3;i++)
    {
     document.all.SCom[i].checked = false;
    }

    if(SCom[idx]=='R') document.all.SCom[0].checked = true;
    else if(SCom[idx]=='S') document.all.SCom[1].checked = true;
    else document.all.SCom[2].checked = true;
  }
  // set Department select drop down box
  setDeptSelect(idx);
}

// close drop menu
function hideMenu()
{
    document.all.menu.style.visibility="hidden"
}

//---------------------------------------------------------
// set Department select drop down box
//---------------------------------------------------------
function setDeptSelect(idx)
{
  for(i=0; i < NumOfDpt; i++)
  {
    document.all.Dept.options[i] = new Option(DeptList[i] + " - " + DeptName[i], DeptList[i]);
    if(idx!=null && Dept[idx]==DeptList[i])
    {
      document.all.Dept.selectedIndex = i
    }
  }
}
//---------------------------------------------------------
// validate changed or added employee properties
//---------------------------------------------------------
function validEmp()
{
  var msg = "";
  var error = false;

  // validate first name
  if (!vldText(document.all.FName.value))
  {
    msg += "Please, enter first name\n";
    error = true
  }

  // validate last name
  if (!vldText(document.all.LName.value))
  {
    msg += "Please, enter last name\n";
    error = true
  }

  // validate department
  var rate = eval(document.all.Rate.value);
  if (!isNum(rate) || rate <= 0)
  {
    msg += "Please, enter hourly rate\n";
    error = true
  }

  // dispaly error
  if(error) alert(msg)
  return error == false;
}

// validate text field
function vldText(text)
{
  var fnd = false;
  for(i=0; i<text.length; i++)
  {
    if (text.substring(i,i+1) != " ") fnd = true;
  }
  return fnd
}

// is string contained correct numeric
function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if (ch != '.' && "0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}

// Add/change employee
function submitEmp()
{
   hideMenu();
   var saltyp; //salary type
   if(document.all.Salary[0].checked) saltyp = "H";
   else saltyp = "S";

   var scom; //sales commission
   if(document.all.SCom[0].checked) scom = "R";
   else if(document.all.SCom[1].checked) scom = "S";
   else scom = "N";

   if (SelEmp == null) SelEmp = "NEW";

   var rate = Math.round(eval(document.all.Rate.value) * 100)

   var URL = "SavBasEmp.jsp?STORE=" + CurStore
           + "&EMPNUM=" + SelEmp
           + "&FNAME=" + document.all.FName.value
           + "&LNAME=" + document.all.LName.value
           + "&TITLE=" + document.all.Title.value
           + "&DEPT=" + document.all.Dept.value
           + "&SALARY=" + saltyp
           + "&RATE=" + rate
           + "&SCOM=" + scom
           + "&ACTION=" + Action;
   //alert(URL);
   window.location.href = URL;
}

// Submit employee deleting
function dltEmpSbm(emp)
{
   hideMenu();
   var URL = "SavBasEmp.jsp?STORE=" + CurStore
           + "&EMPNUM=" + emp
           + "&ACTION=DLT";
   //alert(URL);
   window.location.href = URL;

}

//========================================================================
// retreive selected store and week
function newStrWkSel()
{
 var strIdx = document.all.STORE.selectedIndex
 var str = document.all.STORE.options[strIdx].value
 var strnm = StrNames[strIdx+1];

 var loc = "BasicEmp.jsp?STORE=" + str + "&STRNAME=" + strnm
 //alert(loc)
 window.location.href=loc;
}


// ---------------- Move Boxes ---------------------------------------
var dragapproved=false
var z,x,y
function move(){
if (event.button==1&&dragapproved){
z.style.pixelLeft=temp1+event.clientX-x
z.style.pixelTop=temp2+event.clientY-y
return false
}
}
function drags(){
if (!document.all)
return
var obj = event.srcElement

if (event.srcElement.className=="Grid"
    || event.srcElement.className=="Menu"
    || event.srcElement.className=="Menu1"){
   while (obj.offsetParent){
     if (obj.id=="menu" || obj.id=="MsgMenu")
     {
       z=obj;
       break;
     }
     obj = obj.offsetParent;
   }
  dragapproved=true;
  temp1=z.style.pixelLeft
  temp2=z.style.pixelTop
  x=event.clientX
  y=event.clientY
  document.onmousemove=move
}
}
document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------
</SCRIPT>
</head>
<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
 <div id="menu"></div>
<!-------------------------------------------------------------------->
   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Employees for Base Scheduling<br>

      </font></b>

      <br>Store: <SELECT name="STORE"></SELECT>&nbsp;&nbsp;&nbsp;
          <button name="Go" onclick="javascript:newStrWkSel();">Go</button>

      <p><a href="../"><font color="red">Home</font></a>
        <!-- a href="StrScheduling.html"><font color="red">Payroll</font></a -->

<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center">
             <tr>
                <th class="DataTable">Employee #<br>
                    <a href="javascript:setEmpMenu(null, 'ADD')">New Employee</a></th>
                <th class="DataTable">First Name</th>
                <th class="DataTable">Last Name</th>
                <th class="DataTable">Title</th>
                <th class="DataTable">H or S</th>
                <th class="DataTable">Dpt</th>
                <th class="DataTable">Salary<br>Per Hour</th>
                <th class="DataTable">Sales<br>Com</th>
             </tr>
             <%for(int i=0; i < iNumOfEmp; i++){%>
                <tr class="DataTable">
                   <td class="DataTable3" id="<%=i%>" onclick="CellMenu(this, '<%=i%>')">
                        <%=sEmp[i]%></td>
                   <td class="DataTable"><%=sFName[i]%></td>
                   <td class="DataTable"><%=sLName[i]%></td>
                   <td class="DataTable"><%=sTitle[i]%></td>
                   <td class="DataTable1">&#160;<%=sHorS[i]%>&#160;</td>
                   <td class="DataTable1"><%=sDept[i]%></td>
                   <td class="DataTable2">
                       <%if(!sTitle[i].equals("MGR 40")
                         && !sTitle[i].equals("ASTMGR40")
                         && !sTitle[i].equals("SRASST40")) {%><%=sRate[i]%>
                       <%} else {%>----<%}%></td>
                   <td class="DataTable2">&#160;<%=sSCom[i]%>&#160;</td>
                </tr>
             <%}%>
       </table>

       </td>
    </tr>
  </table>
</body>
</html>
