<%@ page import="projmgmt.ProjDtl, projmgmt.ProjLstSel, java.util.*, java.io.*"%>
<%
   String sSelProjId = request.getParameter("Proj");
   String sAction = request.getParameter("Action");

   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ProjList.jsp&" + request.getQueryString());
   }
   else
   {
     String sUser = session.getAttribute("USER").toString();

     ProjDtl projdtl = null;

     String sProjId = "0";
     String sName = "";
     String sAssignee = "None";
     String sDesc = "";
     String sType = "";
     String sSystem = "None";
     String sReqBy = sUser;
     String sReqDate = "";
     String sEstComplDt = "";
     String sComplDt = "";
     String sArea = "None";
     String sPriority = "5";
     String sMagnitude = "5";
     String sStatus = "Open";

     if(!sAction.equals("New"))
     {
        projdtl = new ProjDtl(sSelProjId, sUser);

        sProjId = projdtl.getProjId();
        sName = projdtl.getName();
        sDesc = projdtl.getDesc();
        sType = projdtl.getType();
        sSystem = projdtl.getSystem();
        sReqBy = projdtl.getReqBy();
        sReqDate = projdtl.getReqDate();
        sArea = projdtl.getArea();
        sPriority = projdtl.getPriority();
        sMagnitude = projdtl.getMagnitude();
        sStatus = projdtl.getStatus();
        sAssignee = projdtl.getAssignee();
        sEstComplDt = projdtl.getEstComplDt();
        sComplDt = projdtl.getComplDt();
     }

     // get project constants
     ProjLstSel prjsel = new ProjLstSel();

     prjsel.setStatus();
     String sSts = prjsel.getStsJva();
     String sStsDesc = prjsel.getStsDescJva();

     prjsel.setPriority();
     String sPty = prjsel.getPtyJva();
     String sPtyDesc = prjsel.getPtyDescJva();

     prjsel.setMagnitude();
     String sMagn = prjsel.getMagnJva();
     String sMagnDesc = prjsel.getMagnDescJva();

     prjsel.setArea();
     String sSelArea = prjsel.getAreaJva();
     String sAreaDesc = prjsel.getAreaDescJva();

     prjsel.setSystem();
     String sSys = prjsel.getSysJva();
     String sSysDesc = prjsel.getSysDescJva();

     String sDir = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/ProjectDocs";
     File fDir = new File(sDir);
     File [] fList = fDir.listFiles();

     Vector vProjFile = new Vector();

     // format project id to 10 characters string
     String sPrefix = "P_";
     String sTenDig = "0000000000";
     String sFormated = sTenDig.substring(0, 10 - sProjId.length()) + sProjId;
     sPrefix += sFormated;

     if (fList != null && fList.length > 0)
     {
        for(int i=0; i < fList.length; i++)
        {
           if(fList[i].getName().indexOf(sPrefix) >= 0)
           {
              vProjFile.add(fList[i]);
           }
        }
     }
%>

<html>
<head>

<style>body {background:white;}
        a.link1  { color:blue; font-size:14px; font-weight:bold}

        table.DataTable { text-align:center;}
        table.DataTable1 { border:#2b7ebb 2px solid; background:white; text-align:center;}

        th.HdrTable{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#2b7ebb, endColorStr=#1b9cc5,
                 gradientType=0);
                 padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border:white 1px solid;
                 color: #fbb117; vertical-align:top; text-align:center; font-size:12px; font-weight:900 }

        tr.DataTable  { text-align:left; font-size:12px}
        tr.DataTable1 { background:#ececec; text-align:left; font-size:12px}

        tr.Divider { background:#d7d7d7; text-align:left; font-size:5px}
        td.Divider1 { border-bottom:darkblue 1px solid; font-size:1px }

        td.DataTable  { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }
        td.DataTable1 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:center; font-family: Arial;  }
        td.DataTable2 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; font-family: Arial;}
        td.DataTable3 { padding-bottom:15px;}
        td.DataTable30 { background: white; padding-bottom:15px;}
        td.DataTable4  { border:darkblue 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }


        span.spHdr { padding-left:15px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                 border:white 1px solid; text-align:center; font-size:12px; font-weight:900 }


        select.Small { font-size:10px }
        input.Small {border:none; border-bottom: black solid 1px; margin-top:3px;  font-size:10px }
        input.Small1 {font-size:10px }
        .Small { font-size:12px }
        .Medium { font-size:12px }


        div.dvSubmit { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvLoad { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
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

    @media print
    {
      #tdHdrLink { display: none;}
      #tdBotton { display: none;}
      select { display: none;}
      img { display: none;}
    }
</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var Sts = [<%=sSts%>];
var Pty = [<%=sPty%>];
var PtyDesc = [<%=sPtyDesc%>];
var Magn = [<%=sMagn%>];
var MagnDesc = [<%=sMagnDesc%>];
var Area = [<%=sSelArea%>];
var AreaDesc = [<%=sAreaDesc%>];
var Sys = [<%=sSys%>];
var SysDesc = [<%=sSysDesc%>];

var CurSts = "<%=sStatus%>";
var CurPty = "<%=sPriority%>";
var CurMagn = "<%=sMagnitude%>";
var CurArea = "<%=sArea%>";
var CurSys = "<%=sSystem%>";
//--------------- End of Global variables -----------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSubmit", "dvLoad"]);
   popStsMenu();
   popPtyMenu();
   popMagnMenu();
   popAreaMenu();
   popSysMenu();
}
//==============================================================================
// populate status menu box
//==============================================================================
function popStsMenu()
{
   for(var i=0, j=1; i< Sts.length; i++)
   {
      if(Sts[i] != CurSts) { document.all.selSts.options[j++] = new Option(Sts[i], Sts[i]); }
      else { document.all.selSts.options[0] = new Option("--- Current ---", Sts[i]); }
   }
   document.all.selSts.selectedIndex = 0;
}
//==============================================================================
// populate priority menu box
//==============================================================================
function popPtyMenu()
{
   for(var i=0, j=1; i< Pty.length; i++)
   {
      if(Pty[i] != CurPty) { document.all.selPty.options[j++] = new Option(Pty[i] + " - " + PtyDesc[i], Pty[i]); }
      else { document.all.selPty.options[0] = new Option("--- Current ---", Pty[i]); }
   }
   document.all.selPty.selectedIndex = 0;
}
//==============================================================================
// populate magnitude menu box
//==============================================================================
function popMagnMenu()
{
   for(var i=0, j=1; i< Magn.length; i++)
   {
      if(Magn[i] != CurMagn) { document.all.selMagn.options[j++] = new Option(Magn[i] + " - " + MagnDesc[i], Magn[i]); }
      else { document.all.selMagn.options[0] = new Option("--- Current ---", Magn[i]); }
   }
   document.all.selMagn.selectedIndex = 0;
}
//==============================================================================
// populate Business Area menu box
//==============================================================================
function popAreaMenu()
{
   for(var i=0, j=1; i< Area.length; i++)
   {
      if(Area[i] != CurArea) { document.all.selArea.options[j++] = new Option(Area[i], Area[i]); }
      else { document.all.selArea.options[0] = new Option("--- Current ---", Area[i]); }
   }
   document.all.selArea.selectedIndex = 0;
}
//==============================================================================
// populate Business Area menu box
//==============================================================================
function popSysMenu()
{
   for(var i=0, j=1; i< Sys.length; i++)
   {
      if(Sys[i] != CurSys) { document.all.selSys.options[j++] = new Option(Sys[i], Sys[i]); }
      else { document.all.selSys.options[0] = new Option("--- Current ---", Sys[i]); }
   }
   document.all.selSys.selectedIndex = 0;
}
//==============================================================================
// change Status
//==============================================================================
function chgSts(menu)
{
   document.all.Sts.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// change Priority
//==============================================================================
function chgPty(menu)
{
   document.all.Pty.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// change Magnitude
//==============================================================================
function chgMagn(menu)
{
   document.all.Magn.value = menu.options[menu.selectedIndex].value;
}

//==============================================================================
// change Area
//==============================================================================
function chgArea(menu)
{
   document.all.Area.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// change system
//==============================================================================
function chgSys(menu)
{
   document.all.System.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// validate Project property before saving
//==============================================================================
function ValidProj()
{
   var error = false;
   var msg = "";
   var proj = document.all.Proj.value;
   var action = "<%=sAction%>";
   var name = document.all.Name.value;
   var desc = document.all.Desc.value;
   var assignee = document.all.Assignee.value;
   var type = document.all.Type.value;
   var system = document.all.System.value;
   var reqby = document.all.ReqBy.value;
   var estcompdt = document.all.EstCompDt.value;
   var compdt = document.all.CompDt.value;
   var area = document.all.Area.value;
   var pty = document.all.Pty.value;
   var magn = document.all.Magn.value;
   var comm = document.all.Comm.value;
   var sts = document.all.Sts.value;

   if(name.trim() == ""){ error = true; msg="\nPlease, enter project name." }
   if(type.trim() == ""){ error = true; msg="\nPlease, enter project type." }
   if(system.trim() == ""){ error = true; msg="\nPlease, enter system type." }
   if(area.trim() == ""){ error = true; msg="\nPlease, enter affected business area." }
   if(pty.trim() == ""){ error = true; msg="\nPlease, enter project pty." }
   if(magn.trim() == ""){ error = true; msg="\nPlease, enter project magn." }

   if(estcompdt.trim() == ""){ estcompdt = "01/01/0001" }
   if(compdt.trim() == ""){ compdt = "01/01/0001" }


   if (error) { alert(msg); }
   else { sbmProj(proj, name, desc, assignee, type, system, reqby, estcompdt, compdt, area, pty, magn, comm, sts); }
}

//==============================================================================
// save changes project properties
//==============================================================================
function sbmProj(proj, name, desc, assignee, type, system, reqby, estcompdt, compdt, area, pty, magn, comm, sts)
{
   if(window.frame1.document.SavProj != null) { window.frame1.document.removeChild(dvSubmit); }

   var html = "<div name='dvSubmit'>"
        + "<form name='SavProj' action='ProjSave.jsp' method=get>"
        + "<input name='Proj'><br>"
        + "<input name='Name'><br>"
        + "<input name='Desc'><br>"
        + "<input name='Assignee'><br>"
        + "<input name='Type'><br>"
        + "<input name='System'><br>"
        + "<input name='Reqby'><br>"
        + "<input name='EstCompDt'><br>"
        + "<input name='CompDt'><br>"
        + "<input name='Area'><br>"
        + "<input name='Pty'><br>"
        + "<input name='Magn'><br>"
        + "<input name='Sts'><br>"
        + "<input name='Comm'><br>"
        + "<input name='Action'><br>"
        + "</form>"
        + "</div>"

   dvSubmit = document.createElement('div');
   dvSubmit.id = "dvSubmit";
   dvSubmit.innerHTML = html;
   window.frame1.document.appendChild(dvSubmit);

   window.frame1.document.SavProj.Proj.value = proj;
   window.frame1.document.SavProj.Name.value = name;
   window.frame1.document.SavProj.Desc.value = desc;
   window.frame1.document.SavProj.Assignee.value = assignee;
   window.frame1.document.SavProj.Type.value = type;
   window.frame1.document.SavProj.System.value = system;
   window.frame1.document.SavProj.Reqby.value = reqby;
   window.frame1.document.SavProj.EstCompDt.value = estcompdt;
   window.frame1.document.SavProj.CompDt.value = compdt;
   window.frame1.document.SavProj.Area.value = area;
   window.frame1.document.SavProj.Pty.value = pty;
   window.frame1.document.SavProj.Magn.value = magn;
   window.frame1.document.SavProj.Sts.value = sts;
   window.frame1.document.SavProj.Comm.value = comm;
   window.frame1.document.SavProj.Action.value = "<%=sAction%>";

   //window.frame1.document.all.dvSubmit.style.visibility = "visible";
   window.frame1.document.SavProj.submit();
}
//==============================================================================
// set new project id
//==============================================================================
function setNewProjId(projId)
{
   document.all.Proj.value = projId;
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
// load document
//==============================================================================
function loadDoc(projId)
{
   var html = ""
     + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
       + "<td class='BoxName' nowrap>Add Attachement File</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<form name='Upload'  method='post'  enctype='multipart/form-data' action='ProjCopyDoc.jsp'>"
               + "<input type='File' name='Doc' class='Small1' size=50><br>"
               + "<input type='hidden' name='FileName'>"
               + "<input type='hidden' name='fiProjId' >"
           + "</form>"
           + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button>"
           + "</td></tr>"
     + "</table>"

  //alert(html)
  document.all.dvLoad.innerHTML=html;
  document.all.dvLoad.style.pixelLeft=250
  document.all.dvLoad.style.pixelTop=200;
  document.all.dvLoad.style.visibility="visible"
  document.Upload.fiProjId.value = projId;
}

//==============================================================================
// submit Upload
//==============================================================================
function sbmUpload()
{
  var error = false;
  var msg = "";
  var file = document.Upload.Doc.value.trim();
  document.Upload.FileName.value = file;
  if(file == "")
  {
     error = true;
     msg = "Please type full file path"
  }
  if (error) { alert(msg);}
  else
  {
    document.Upload.submit();
  }
}
//==============================================================================
// Delete selected file
//==============================================================================
function dltFile(fileLoc)
{

  var url = "DltFile.jsp?File=" + fileLoc.replaceSpecChar();
  alert(url);
  //window.location = url;
  window.frame1.location = url;
}
//==============================================================================
// reload this page
//==============================================================================
function restart()
{
  window.location.reload();
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvLoad" class="dvLoad"></div>
<!-------------------------------------------------------------------->
  <table border="0">
    <tr>
      <td ALIGN="left" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Project<%if(!sProjId.equals("0")){%>:<span style="color:darkred;font-size:18px ">&nbsp;<%=sProjId%> &nbsp; <%=sName%></span><%}%>
      <br>Status: <%=sStatus%></b><br>

<!-------------------------------------------------------------------->
    <tr>
      <td ALIGN="center" VALIGN="TOP" id="tdHdrLink">
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="ProjLstSel.jsp"><font color="red" size="-1">Project Selection</font></a>&#62;
        <font size="-1">This page</font>

   <tr><td class="Divider1">&nbsp;</td></tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP">

 <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="5" cellSpacing="10">
  <!------------------------- Data Detail ------------------------------>
        <tr class="DataTable">
          <td class="DataTable4" colspan=2>
             <span style="<%if(!sProjId.equals("0")){%>display:none;<%}%>">
                <span class="spHdr">Project ID:</span><input name="Proj" size=10  maxlength=10 class="Small" value="<%=sProjId%>" readonly>
             </span>
             <span class="spHdr">Name:</span>
                  <input name="Name" size=50  maxlength=50 class="Small" value="<%=sName%>" >
             <span class="spHdr">Status</span>
                  <input name="Sts" size=50  maxlength=50 class="Small" value="<%=sStatus%>" readonly>
                  <select name="selSts" class="Small" onchange="chgSts(this)"></select><br><br>
             <span class="spHdr">Description:</span>
                  <textarea name="Desc" class="Medium" value="<%=sName%>" cols=110 rows=3><%=sDesc%></textarea>
          </td>
        </tr>
        <!---------------------------- Next Line ------------------------------>
        <tr class="DataTable">
          <td class="DataTable4">
             <table>
               <tr>
                 <td><span class="spHdr">Assignee:</span>
                 <td><input name="Assignee" size=10  maxlength=10 class="Small" value="<%=sAssignee%>">
                     <select name="selAssign" class="Small"></select><br><br>
              <tr>
                 <td><span class="spHdr">Requered By User</span>
                 <td><input name="ReqBy" size=10  maxlength=10 class="Small" value="<%=sReqBy%>">
                     <select name="selReqBy" class="Small"></select><br><br>

               <tr>
                 <td><span class="spHdr">Estemated Completion Date</span>
                 <td><button class="Small" name="Down" onClick="setDate('DOWN', 'EstCompDt')">&#60;</button>
               <input name="EstCompDt" size=10  maxlength=10 class="Small" <%if(!sEstComplDt.equals("01/01/0001")){%>value="<%=sEstComplDt%>"<%}%>>
               <button class="Small" name="Up" onClick="setDate('UP', 'EstCompDt')">&#62;</button>
                &nbsp;&nbsp;&nbsp;
               <a href="javascript:showCalendar(1, null, null, 160, 280, document.all.EstCompDt)" >
               <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

             <tr>
               <td><span class="spHdr">Completion Date</span>
               <td><button class="Small" name="Down" onClick="setDate('DOWN', 'CompDt')">&#60;</button>
                <input name="CompDt" size=10  maxlength=10 class="Small" <%if(!sComplDt.equals("01/01/0001")){%>value="<%=sComplDt%>"<%}%>>
                <button class="Small" name="Up" onClick="setDate('UP', 'CompDt')">&#62;</button>
                &nbsp;&nbsp;&nbsp;
                <a href="javascript:showCalendar(1, null, null, 450, 260, document.all.CompDt)" >
                <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
             </table>
         <!---------------------------- Next Line ------------------------------>
          <td class="DataTable4" nowrap>
             <table>
               <tr>
                 <td><span class="spHdr">Type:</span>
                 <td><input name="Type" size=30  maxlength=30 class="Small" value="<%=sType%>">
               <tr>
                 <td><span class="spHdr">System:</span>
                 <td><input name="System" size=30  maxlength=30 class="Small" value="<%=sSystem%>">
                     <select name="selSys" class="Small" onchange="chgSys(this)"></select>
               <tr>
                 <td><span class="spHdr">Business Area</span>
                 <td><input name="Area" size=50  maxlength=50 class="Small" value="<%=sArea%>">
                     <select name="selArea" class="Small" onchange="chgArea(this)"></select><br><br>
               <tr>
                 <td><span class="spHdr">Priority</span>
                 <td><input name="Pty" size=20  maxlength=20 class="Small" value="<%=sPriority%>" readonly>
                     <select name="selPty" class="Small" onchange="chgPty(this)"></select>
               <tr>
                 <td><span class="spHdr">Magnitude</span>
                 <td><input name="Magn" size=20  maxlength=20 class="Small" value="<%=sMagnitude%>" readonly>
                     <select name="selMagn" class="Small" onchange="chgMagn(this)"></select><br><br>
             </table>
        <!---------------------------- Next Line ------------------------------>
        <tr class="DataTable">
          <td class="DataTable" colspan=2>

             <br><span class="spHdr">New Comments:</span>
                  <input name="Comm" class="Small" size=150  maxlength=256><br><br>
          </td>
        </tr>
        <tr class="DataTable" id="tdBotton">
          <td class="DataTable1">
             <button onclick="ValidProj()">Save</button>
             <%if(!sProjId.equals("0")){%>
                  &nbsp; &nbsp; &nbsp; &nbsp;
                  <button onClick="loadDoc('<%=sProjId%>')">Load Document</button>
             <%}%>
          </td>
        </tr>
      </table>
     <!--------------------------------------------------------------------->
  </table>

  <table class="DataTable1" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="HdrTable">Project Documents</th>
      <th class="HdrTable">Delete Documanet</th>
    </tr>
    <%  Iterator it = vProjFile.iterator();
        while(it.hasNext()){
           File fDoc = (File)it.next();
           String sDoc = fDoc.getName();
    %>
        <tr class="DataTable1">
           <td class="DataTable"><a href="<%="ProjectDocs/" + sDoc%>" target="_blank"><%=sDoc%></a></td>
           <td class="DataTable"><a href="javascript: dltFile('<%=sDir + "/" + sDoc%>')">Delete</a></td>
        </tr>
    <%}%>
  </table>

<br>
<br>


  <table class="DataTable1" cellPadding="0" cellSpacing="0" width="100%">
    <tr>
      <th class="HdrTable">Type</th>
      <th class="HdrTable">Comment</th>
      <th class="HdrTable">User</th>
      <th class="HdrTable">Date</th>
      <th class="HdrTable">Time</th>
    </tr>
    <%while(projdtl.getNext())
       {
          projdtl.setComtLst();
          int iNumOfCmt = projdtl.getNumOfCmt();
          String [] sCmtId = projdtl.getCmtId();
          String [] sCmtType = projdtl.getCmtType();
          String [] sCmtTxt = projdtl.getCmtTxt();
          String [] sCmtUser = projdtl.getCmtUser();
          String [] sCmtDate = projdtl.getCmtDate();
          String [] sCmtTime = projdtl.getCmtTime();
    %>
      <%for(int i=0; i < iNumOfCmt; i++){%>
         <tr class="DataTable1">
           <td class="DataTable"><%=sCmtType[i]%></td>
           <td class="DataTable"><%=sCmtTxt[i]%></td>
           <td class="DataTable" width="80" nowrap><%=sCmtUser[i]%></td>
           <td class="DataTable" width="50" nowrap><%=sCmtDate[i]%></td>
           <td class="DataTable" width="60" nowrap><%=sCmtTime[i]%></td>
         </tr>
         <tr class="Divider"><td colspan=5>&nbsp</td></tr>
      <%}%>
    <%}%>
  </table>


 </body>
</html>
<%}%>