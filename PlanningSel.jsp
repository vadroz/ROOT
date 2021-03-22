<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PlanningSel.jsp&APPL=ALL");
   }
   else
   {

      ClassSelect divsel = null;
      StoreSelect strsel = null;

      String sDiv = null;
      String sDivName = null;
      String sDpt = null;
      String sDptName = null;
      String sDptGroup = null;
      String sCls = null;
      String sClsName = null;

      divsel = new ClassSelect();
      sDiv = divsel.getDivNum();
      sDivName = divsel.getDivName();
      sDpt = divsel.getDptNum();
      sDptName = divsel.getDptName();
      sDptGroup = divsel.getDptGroup();

      strsel = new StoreSelect(14);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var DivLst = [<%=sDiv%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect(null);
}

//==============================================================================
// populate class selection
//==============================================================================
function doClsSelect() {
    var df = document.all;
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];
    document.all.DivArg.value = 0;

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
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];
    var chg = id;

    var allowed;

    if (id == null || id == 0)
    {
        //  populate the division list
        for (idx = 1; idx < divisions.length; idx++)
        {
           df.selDiv.options[idx-1] = new Option(divisionNames[idx],divisions[idx]);
        }
        id = 0
        if (document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id+1].split(":");

    //  clear current depts
    for (idx = df.selDpt.length; idx >= 0; idx--)
    {
       df.selDpt.options[idx] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (idx = 0; idx < depts.length; idx++)
            df.selDpt.options[idx] = new Option(deptNames[idx],depts[idx]);
    }
    //  else display the desired depts
    else
    {
       for (idx = 0; idx < allowed.length; idx++)
           df.selDpt.options[idx] = new Option(deptNames[allowed[idx]], depts[allowed[idx]]);
    }

    if(chg!=null)
    {
      showDptSelect(0);
      showClsSelect(0);
    }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showDptSelect(id)
{
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   // clear class
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.selectedIndex=0;
   document.all.selCls.size=1
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   document.all.ClsName.value = document.all.selCls.options[id].text
   document.all.Cls.value = document.all.selCls.options[id].value
}
//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Div.value
   var dpt = document.all.Dpt.value

   var url = "RetreiveDivDptCls.jsp?"
           + "Division=" + div
           + "&Department=" + dpt;
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
   // clear
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.selCls.options[i] = new Option(clsName[i], cls[i]);
   }
   document.all.selCls.size=5
}
//==============================================================================
// change Store selection
//==============================================================================
function chgStrSel(selstr)
{
  var strchk = document.all.STORE;

  for(var i=0; i < strchk.length; i++)
   {
      strchk[i].checked = false;
      var numstr = strchk[i].value;

      if(selstr=="ALL") { strchk[i].checked = true}
      else if(selstr=="OPEN" && numstr <= 98 && numstr != 2 && numstr != 6 && numstr != 7
        && numstr != 12 && numstr != 13 && numstr != 15 && numstr !=32 && numstr !=55 && numstr !=56
        && numstr !=59 && numstr !=62 && numstr !=68 && numstr !=71 && numstr !=72 && numstr !=75
        && numstr !=76 && numstr !=85 && numstr !=87 && numstr !=89 && numstr !=94)
      { strchk[i].checked = true}
      else if(selstr=="COMP" && numstr != 98 && numstr != 2 && numstr != 6 && numstr != 7
        && numstr != 12 && numstr != 13 && numstr != 15 && numstr !=32 && numstr !=55 && numstr !=56
        && numstr !=59 && numstr !=62  && numstr !=68 && numstr !=71 && numstr !=72 && numstr !=75
        && numstr !=76 && numstr !=85 && numstr !=87 && numstr !=89 && numstr !=94  // exclude vertual stores
        && numstr !=29 && numstr !=40 && numstr !=42 && numstr !=90) // exclude new store
      { strchk[i].checked = true}
      else if(selstr=="SAS" && numstr >= 3 && numstr <= 98 && numstr != 35 && numstr != 46 && numstr != 55
        && numstr != 70 && numstr != 86 && numstr != 89)
      { strchk[i].checked = true}
      else if(selstr=="SCH" && (numstr == 35 || numstr == 46 || numstr == 55))
      { strchk[i].checked = true}
      else if(selstr=="SSC" && numstr >= 3 && numstr <= 98
        && numstr != 86 && numstr != 89)
      { strchk[i].checked = true}
   }
}
//==============================================================================
// change Division selection
//==============================================================================
function chgDivSel(seldiv)
{
  var divchk = document.all.Div;
  var check = false;
   if(seldiv=="ALL") { check = true;}

  for(var i=0; i < divchk.length; i++) { divchk[i].checked = check; }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(appl)
{
  var error = false;
  var msg = " ";

  var div = new Array();
  var divfnd = false;
  if(document.all.Mult.checked)
  {
     for(var i=0, j=0; i < DivLst.length; i++)
     {
        if(document.all.Div[i].checked){div[j++] = document.all.Div[i].value; divfnd = true;}
     }
     if(!divfnd){ error = true; msg += "\nPlease, select at least 1 division."}
  }
  else
  {
     div[0] = document.all.Div.value.trim();
  }


  var dpt = document.all.Dpt.value.trim();
  var cls = document.all.Cls.value.trim();

  var ucr = "R";
  if (document.all.AlwChg[1].checked) ucr="C";
  else if (document.all.AlwChg[2].checked) ucr="U";

  var stores = document.all.STORE;
  var str = new Array();
  var action;

  // at least 1 store must be selected
  var strsel = false;
  for(var i=0, j=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        str[j] = stores[i].value;
        j++;
     }
  }

  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }

  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, str, ucr, appl) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, str, ucr, appl)
{
  var url = null;
  if(appl) url = "PlanSps.jsp?"
  else url = "PlanAppr.jsp?"

  url += "&DEPARTMENT=" + dpt
      + "&CLASS=" + cls
  for(var i=0; i < div.length; i++)
  {
     url += "&Div=" + div[i]
  }

  // selected store
  for(var i=0; i < str.length; i++)
  {
     url += "&STORE=" + str[i]
  }
  // UCR
  url += "&AlwChg=" + ucr;
  url += "&Result=3";

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// change division mode
//==============================================================================
function chgDivMode(chkbx)
{
   var html = "";
   var dispSng = null;

   if(chkbx.checked)
   {
      for(var i=1; i < DivLst.length; i++)
      {
         if(i > 0 && i%18 == 0){ html +="<br>"; }
         html += "<input class='Small' name='Div' type='checkbox' value='" + DivLst[i] + "'>" + DivLst[i] + "&nbsp;&nbsp;"
      }
      document.all.trMult.style.display="block";
      dispSng = "none"
   }
   else
   {
      dispSng = "block";
      document.all.trMult.style.display="none";
   }

   document.all.spnMult.innerHTML = html;

   for(var i=0; i < document.all.trSing.length; i++)
   {
      document.all.trSing[i].style.display = dispSng;
   }
}
</script>
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
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

      <TABLE border=0>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD align=center colspan=6>
             <input name="Mult" type="checkbox" onclick="chgDivMode(this)" value="Y">Multiple Division
          </TD>
        </TR>

        <TR id="trMult" style="display:none;">
          <TD align=center colspan=6>
             <button id="STRGRP" class="Small" onclick="chgDivSel('ALL')" checked>All</button> &nbsp;
             <button id="STRGRP" class="Small" onclick="chgDivSel('Clear')" checked>Clear</button>
             <br><span id="spnMult" class="Small"></span>

          </TD>
        </TR>


        <TR id="trSing">
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT>
          </TD>
        <!-- ======================= Department ============================ -->
          <TD class="Cell">Department:</TD>
          <TD class="Cell1">
             <input class="Small" name="DptName" size=50 value="All Departments" readonly>
             <input class="Small" name="Dpt" type="hidden" value="ALL"><br>
             <SELECT class="Small" name=selDpt onchange="showDptSelect(this.selectedIndex);"  size=5>
                <OPTION value="ALL">All Departments</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
            <TD class="Cell" colspan=4>&nbsp;</TD>
         </TR>
        <!-- ========================== Class ============================== -->
        <TR id="trSing">
            <TD class="Cell" >Class:</TD>
            <TD class="Cell1" colspan=3>
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" value="Select Class" name=SUBMIT onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="selCls" class="Small" onchange="showClsSelect(this.selectedIndex);">
                 <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>

        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4">&nbsp;</TD></TR>
        <TR>
          <TD class="Cell">Store:</TD>
          <TD class="Cell1" colspan=3 nowrap>
             <button id="STRGRP" class="Small" onclick="chgStrSel('ALL')" checked>All</button>
             <button id="STRGRP" class="Small" onclick="chgStrSel('OPEN')" >Open Stores</button>
             <button id="STRGRP" class="Small" onclick="chgStrSel('COMP')" >Comp Stores</button>
             <button id="STRGRP" class="Small" onclick="chgStrSel('SAS')" >Sun & Ski</button>
             <button id="STRGRP" class="Small" onclick="chgStrSel('SCH')" >Ski Chalet</button>
             <button id="STRGRP" class="Small" onclick="chgStrSel('SSC')" >Ski Chalet + Sun & Ski</button> &nbsp; &nbsp;

             <button id="STRGRP" class="Small" onclick="chgStrSel('Clear')" >Clear</button>
             <br>


             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="STORE" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if( i == 18 || i == 36) {%><br><%}%>
             <%}%>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell" nowrap> <br>Change Plan:</TD>
           <TD class="Cell1">
              <br><input name="AlwChg" type="radio" value="R" checked>Retail<br>
              <input name="AlwChg" type="radio" value="C" >Cost<br>
              <input name="AlwChg" type="radio" value="U" >Unit
          </TD>
        </TR>
        <!-- =============================================================== -->
        <!-- TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR -->
        <TR>
          <!-- TD align=right > <br>Show Result in:</TD -->
          <TD>
               <input name="Result" value="3" type="hidden">
              <!-- br><Select name="Result">
                  <option value="1">Ones</option>
                  <option value="2">100</option>
                  <option value="3">1k</option>
                  <option value="4">10k</option>
                  </Select><br -->
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate(true)">
           <% if(session.getAttribute("PLNAPPROVE") != null) {%>&nbsp;&nbsp;&nbsp;&nbsp;
                <button value="Submit" id=SUBMIT onClick="Validate(false)">Approve</button>
           <%}%>

           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>