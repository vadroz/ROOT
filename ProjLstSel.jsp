<%@ page import="projmgmt.ProjLstSel, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ProjLstSel.jsp&APPL=ALL");
   }
   else
   {
      ProjLstSel prjsel = new ProjLstSel();
      prjsel.setStatus();
      String [] sSts = prjsel.getSts();
      String [] sStsDesc = prjsel.getStsDesc();

      prjsel.setPriority();
      String [] sPty = prjsel.getPty();
      String [] sPtyDesc = prjsel.getPtyDesc();
      String sPtyJsa = prjsel.getPtyJva();
      String sPtyDescJsa = prjsel.getPtyDescJva();

      prjsel.setMagnitude();
      String sMagn = prjsel.getMagnJva();
      String sMagnDesc = prjsel.getMagnDescJva();

      prjsel.setArea();
      String sSelArea = prjsel.getAreaJva();
      String sAreaDesc = prjsel.getAreaDescJva();

      prjsel.setSystem();
      String sSys = prjsel.getSysJva();
      String sSysDesc = prjsel.getSysDescJva();

      prjsel.setType();
      String sTypeSel = prjsel.getTypeJva();
      String sTypeDesc = prjsel.getTypeDescJva();

      prjsel.setReqSts();
      String sReqSts = prjsel.getReqStsJva();
      String sReqStsDesc = prjsel.getReqStsDescJva();

      prjsel.setUser();
      String sUserL = prjsel.getUserJva();
      String sUserNmL = prjsel.getUserNmJva();
      String sUserEMailL = prjsel.getUserEMailJva();
      String sUserDeptL = prjsel.getUserDeptJva();

      prjsel = null;
%>


<style>
  body {background:#F0FFF0;}
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
  td.Cell3 {font-size:12px; text-align:center; vertical-align:top}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script name="javascript">
var UserL = [<%=sUserL%>];
var UserLNm = [<%=sUserNmL%>];
var UserDeptL = [<%=sUserDeptL%>];
var Pty = [<%=sPtyJsa%>];
var PtyDesc = [<%=sPtyDescJsa%>];
var Magn = [<%=sMagn%>];
var MagnDesc = [<%=sMagnDesc%>];
var Sys = [<%=sSys%>];
var SysDesc = [<%=sSysDesc%>];
var BusArea = [<%=sSelArea%>];
var BusAreaDesc = [<%=sAreaDesc%>];
var ReqSts = [<%=sReqSts%>];
var ReqStsDesc = [<%=sReqStsDesc%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   document.all.tdDate3.style.display="block"
   document.all.tdDate4.style.display="none"

   setAsg();
   setAsgSup();
   setMagn();
   setReqBy();
   setSystem();
   setBusArea();
   setReqSts();

   if(document.all.Type[1].checked)
   {
      document.all.thYear.style.display="none";
      document.all.tdYear.style.display="none";
   }
   else
   {
      document.all.tdYear.style.display="inline";
      document.all.thYear.style.display="inline";
   }
}
//==============================================================================
// set Assignee, assignee support, Requested by
//==============================================================================
function setAsg()
{
   var i=0;
   document.all.Assignee.options[i] = new Option("Any Assignee", "ALL");
   i++;
   for(var j=0; j < UserL.length; j++)
   {
      if(UserDeptL[j]=="IT")
      {
        document.all.Assignee.options[i] = new Option(UserL[j] + " --- " + UserLNm[j],UserL[j]);
        i++;
      }
   }
}

function setAsgSup(){ setDropDown(UserL, UserLNm, document.all.AsgSup, "Any Assignee Support"); }
function setReqBy(){ setDropDown(UserL, UserLNm, document.all.ReqBy, "Any Requsted by"); }
function setMagn(){ setDropDown(Magn, MagnDesc, document.all.Magn, "Any Efforts"); }
function setSystem(){ setDropDown(Sys, SysDesc, document.all.Sys, "Any Systems"); }
function setBusArea(){ setDropDown(BusArea, BusAreaDesc, document.all.BusArea, "Any Business Areas"); }
function setReqSts(){ setDropDown(ReqSts, ReqStsDesc, document.all.ReqSts, "Any Request Stus"); }

//==============================================================================
// set drop down menu options
//==============================================================================
function setDropDown(opt, optnm, obj, allsel)
{
   var i=0;
   if(allsel != null) { obj.options[i] = new Option(allsel, "ALL"); i++}
   for(var j=0; j < opt.length; i++, j++)
   {
      obj.options[i] = new Option(optnm[j],opt[j]);
   }
}

//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate3.style.display="none"
     document.all.tdDate4.style.display="block"
   }
   doSelDate(type)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   if(type==1)
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.ReqFrDate.value = "MONTH"
      document.all.ReqToDate.value = "MONTH"
   }
   else
   {
      document.all.tdDate3.style.display="block"
      document.all.tdDate4.style.display="none"
      document.all.LstFrDate.value = "ALL"
      document.all.LstToDate.value = "ALL"
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  if(type==1)
  {
    df.ReqFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    df.ReqToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
  else
  {
    df.LstFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    df.LstToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var type = new Array();
  var typesel = false;
  for(var i=0, j=0; i < document.all.Type.length; i++)
  {
     if(document.all.Type[i].checked){ type[j]=document.all.Type[i].value; typesel = true; j++; }
  }
  if(!typesel){ msg = "Please select Type(s)."; error = true; }

  var year = new Array();
  var yearsel = false;
  if(document.all.Type[0].checked)
  {
     for(var i=0, j=0; i < document.all.Year.length; i++)
     {
        if(document.all.Year[i].checked){ year[j]=document.all.Year[i].value; yearsel = true; j++; }
     }
     if(!yearsel){ msg = "Please select Year(s)."; error = true; }
  }
  else { year[0]="0000"; }

  var asg = document.all.Assignee.options[document.all.Assignee.selectedIndex].value;
  var asgsup = document.all.AsgSup.options[document.all.AsgSup.selectedIndex].value;
  var magn = document.all.Magn.options[document.all.Magn.selectedIndex].value;
  var reqby = document.all.ReqBy.options[document.all.ReqBy.selectedIndex].value;
  var reqsts = document.all.ReqSts.options[document.all.ReqSts.selectedIndex].value;
  var sys = document.all.Sys.options[document.all.Sys.selectedIndex].value;
  var busarea = document.all.BusArea.options[document.all.BusArea.selectedIndex].value;

  // selected status
  var sts = new Array();
  var sel = false
  for (var i=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked)
     {
        sts[i] = document.all.Sts[i].value;
        sel = true;
     }
  }
  if(!sel) {error = false; msg += "Select at least 1 status"}

  // selected priorities
  var pty = new Array();
  var ptysel = false;
  for (var i=0; i < document.all.Pty.length; i++)
  {
     if(document.all.Pty[i].checked)
     {
        pty[i] = document.all.Pty[i].value;
        ptysel = true;
     }
  }
  if(!ptysel) { error = true; msg += "Select at least 1 priority"}

  // project creation date
  var ReqFrDate = document.all.ReqFrDate.value;
  var ReqToDate = document.all.ReqToDate.value;
  // project last modified date
  var LstFrDate = document.all.LstFrDate.value;
  var LstToDate = document.all.LstToDate.value;
  var kyword = document.all.Keyword.value.trim();

  if (error) { alert(msg); }
  else { sbmOrdList(type, asg, asgsup, pty, magn, reqby, reqsts, sys, busarea, sts
        , ReqFrDate, ReqToDate, LstFrDate, LstToDate, year, kyword) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(type, asg, asgsup, pty, magn, reqby, reqsts, sys, busarea, sts
       , ReqFrDate, ReqToDate, LstFrDate, LstToDate, year, kyword)
{
  var url = null;
  url = "ProjList.jsp?"

  for(var i=0; i < type.length; i++) { url += "&Type=" + type[i]; }
  for(var i=0; i < year.length; i++) { url += "&Year=" + year[i]; }

  url += "&Asg=" + asg
      + "&AsgSup=" + asgsup
      + "&Magn=" + magn
      + "&ReqBy=" + reqby
      + "&ReqSts=" + reqsts
      + "&Sys=" + sys
      + "&BusArea=" + busarea
      + "&ReqFrDate=" + ReqFrDate
      + "&ReqToDate=" + ReqToDate
      + "&LstFrDate=" + LstFrDate
      + "&LstToDate=" + LstToDate
      + "&Keyword=" + kyword

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }
  for(var i=0; i < pty.length; i++) { url += "&Pty=" + pty[i] }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// Validate searched Project
//==============================================================================
function ValidateProj()
{
  var error = false;
  var msg = "";

  var proj = document.all.ProjId.value;
  if (isNaN(proj)) { msg = "Project must be numeric."; error = true; }
  else if( proj <= 0) { msg = "Project number must be greater than 0."; error = true; }

  if (error) alert(msg);
  else{ sbmProj( proj) }
  return error == false;
}
//==============================================================================
// submit searched project
//==============================================================================
function sbmProj(proj)
{
  var url = "ProjDtl.jsp?Proj=" + proj
    + "&Action=Update"

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko)
{
   var sts = document.all.Sts;
   var mark = false;
   if (chko.checked) mark = true;
   for(var i=0; i < sts.length; i++) { sts[i].checked = mark }
}
//==============================================================================
// check All Status
//==============================================================================
function chkPtyAll(chko)
{
   var pty = document.all.Pty;
   var mark = false;
   if (chko.checked) mark = true;
   for(var i=0; i < pty.length; i++) { pty[i].checked = mark }
}
//==============================================================================
// change type action
//==============================================================================
function chgType()
{
   var proj = false;
   if(!document.all.Type[0].checked)
   {
       document.all.thYear.style.display="none";
       document.all.tdYear.style.display="none";
   }
   else
   {
       document.all.tdYear.style.display="inline";
       document.all.thYear.style.display="inline";
   }
}

</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">
<title>Project List</title>
</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Task/Project List - Selection</B>
        <br><a href="../" class="Small"><font color="red">Home</font></a>

      <TABLE width="80%" border=0>
        <TBODY>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:gray solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=2>Type</TD>
            <TD class="Cell2" id="thYear" colspan=2>Year</TD>
        </tr>
        <tr>
            <TD class="Cell3" colspan=2 nowrap>
               <input class="Small" name="Type" type="checkbox" value="Project" onclick="chgType()">Project
               <input class="Small" name="Type" type="checkbox" value="Task" onclick="chgType()" checked>Task
                  &nbsp; &nbsp; &nbsp;
            </td>
            <TD class="Cell3" id="tdYear" colspan=2 nowrap>
               <input class="Small" name="Year" type="checkbox" value="2012" >2012
               <input class="Small" name="Year" type="checkbox" value="2013" >2013
               <input class="Small" name="Year" type="checkbox" value="2014" >2014
               <input class="Small" name="Year" type="checkbox" value="2015" >2015
               <input class="Small" name="Year" type="checkbox" value="2016" >2016
               <input class="Small" name="Year" type="checkbox" value="2017" checked>2017
               <input class="Small" name="Year" type="checkbox" value="2018" checked>2018               
                  &nbsp; &nbsp; &nbsp;

            </td>
        </TR>

        <!-- ==================== Priority ================================= -->
        <TR>
            <TD class="Cell2" colspan=5>Priority</TD>
        </tr>
        <tr>
            <TD class="Cell2" colspan=5>
              <input class="Small" onclick="chkPtyAll(this)" name="PtyAll" type="checkbox" value="All" checked>All
        <tr>
        <tr>
           <TD class="Cell3" colspan=5 nowrap>
              <%for(int i=0; i < sPty.length; i++){%>
                  <input class="Small" name="Pty" type="checkbox" value="<%=sPty[i]%>" checked><%=sPty[i]%>-<%=sPtyDesc[i]%>
                  &nbsp; &nbsp; &nbsp;
              <%}%>
           </td>


        <!-- =============================================================== -->
        <tr>
            <TD class="Cell3" colspan=5 nowrap>
              <table border=0>
                 <tr>
                    <TD class="Cell" nowrap>Assignee</td>
                    <TD class="Cell1" nowrap><select class="Small" name="Assignee"></select></td>
                    <td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
                    <TD class="Cell" nowrap>Assignee Support</td>
                    <TD class="Cell1" nowrap><select class="Small" name="AsgSup"></select></td>
                  </TR>
                  <tr>
                    <TD class="Cell" nowrap>Effort</td>
                    <TD class="Cell1" nowrap><select class="Small" name="Magn"></select></td>
                  </TR>
                  <tr>
                    <TD class="Cell1" colspan=5>&nbsp;</td>
                  </TR>
                  <tr>
                    <TD class="Cell" nowrap>Requested by</td>
                    <TD class="Cell1" nowrap><select class="Small" name="ReqBy"></select></td>
                    <td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
                    <TD class="Cell" nowrap>System</td>
                    <TD class="Cell1" nowrap><select class="Small" name="Sys"></select></td>
                  </TR>
                  <tr>
                    <TD class="Cell" nowrap>Status</td>
                    <TD class="Cell1" nowrap><select class="Small" name="ReqSts"></select></td>
                    <td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
                    <TD class="Cell" nowrap>Business Area</td>
                    <TD class="Cell1" nowrap><select class="Small" name="BusArea"></select></td>
                  </TR>
              </table>
           </td>
        </TR>

        <!-- ===================== Statuses ================================ -->
        <TR>
            <TD class="Cell2" colspan=5>Statuses</TD>
        </tr>
        <tr>
            <TD class="Cell2" colspan=5>
              <input class="Small" onclick="chkStsAll(this)" name="StsAll" type="checkbox" value="All">All
        <tr>
            <TD class="Cell3" colspan=5 nowrap>
              <%for(int i=0; i < sSts.length; i++){%>
                  <%if(i==6){%><br><%}%>
                  <input class="Small" name="Sts" type="checkbox" value="<%=sSts[i]%>"
                     <%if(!sSts[i].equals("On Hold") && !sSts[i].equals("Completed") && !sSts[i].equals("Cancelled")){%>checked<%}%>><%=sSts[i]%>
                  &nbsp; &nbsp; &nbsp;
              <%}%>
            </td>
        </TR>

        <!-- ============== select Project changes ========================== -->
        <TR><TD style="border-bottom:gray solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select project creation date</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=5 align=center style="padding-top: 10px;" >
             <button class="Small" id="btnSelDates" onclick="showDates(1)">Optional Project Creation Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ReqFrDate')">&#60;</button>
              <input class="Small" name="ReqFrDate" type="text" value="MONTH" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ReqFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ReqFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ReqToDate')">&#60;</button>
              <input class="Small" name="ReqToDate" type="text" value="MONTH" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ReqToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ReqToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button class="Small" id="btnSelDates" onclick="showAllDates(1)">All Date</button>
          </TD>
        </TR>
        <!-- ============== select Shipping changes ========================== -->
        <TR><TD class="Cell2" colspan=5>Select last dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate3" colspan=5 align=center style="padding-top: 10px;" >
             <button class="Small" id="btnSelDates" onclick="showDates(2)">Optional Last Modification Date Selection</button>
          </td>
          <TD id="tdDate4" colspan=5 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'LstFrDate')">&#60;</button>
              <input class="Small" name="LstFrDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'LstFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.LstFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'LstToDate')">&#60;</button>
              <input class="Small" name="LstToDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'LstToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.LstToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button class="Small" id="btnSelDates" onclick="showAllDates(2)">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:gray solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell3" align=center valign=top colSpan=5>
               <INPUT type=text name="ProjId" size=10 maxlength=10>&nbsp;
               <button class="Small" onClick="ValidateProj()">Go</button>
               &nbsp; &nbsp; &nbsp; &nbsp;
               <a class="link1" href="ProjDtl.jsp?Proj=0&Action=New">Add New</a>
               &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
               &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;               
               Lookup: <INPUT type=text name="Keyword" size=30 maxlength=200>&nbsp;
               for ex: inventory, ecom               
           </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:gray solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT  type=submit value=Submit name=SUBMIT onClick="Validate()">
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