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
     String sAssignee = "";
     String sDesc = "";
     String sType = "";
     String sSystem = "";
     String sReqBy = "";
     String sReqSts = "";
     String sReqDate = "";
     String sEstComplDt = "";
     String sComplDt = "";
     String sArea = "";
     String sPriority = "5";
     String sMagnitude = "5";
     String sStatus = "Open";
     String sAsgSup = "[]";
     String sAsgSupNm = "[]";
     String sFiscYr = "";
     String sWgt = "";

     if(!sAction.equals("New"))
     {
        projdtl = new ProjDtl(sSelProjId, sUser);

        sProjId = projdtl.getProjId();
        sName = projdtl.getName();
        sDesc = projdtl.getDesc();
        sType = projdtl.getType();
        sSystem = projdtl.getSystem();
        sReqBy = projdtl.getReqBy();
        sReqSts = projdtl.getReqSts();
        sReqDate = projdtl.getReqDate();
        sArea = projdtl.getArea();
        sPriority = projdtl.getPriority();
        sMagnitude = projdtl.getMagnitude();
        sStatus = projdtl.getStatus();
        sAssignee = projdtl.getAssignee();
        sEstComplDt = projdtl.getEstComplDt();
        sComplDt = projdtl.getComplDt();
        sAsgSup = projdtl.getAsgSupJsa();
        sAsgSupNm = projdtl.getAsgSupNmJsa();
        sFiscYr = projdtl.getFiscYr();
        sWgt = projdtl.getWgt();
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

     prjsel.setType();
     String sTypeSel = prjsel.getTypeJva();
     String sTypeDesc = prjsel.getTypeDescJva();

     prjsel.setReqSts();
     String sReqStsSel = prjsel.getReqStsJva();
     String sReqStsDesc = prjsel.getReqStsDescJva();

     prjsel.setUser();
     String sUserL = prjsel.getUserJva();
     String sUserNmL = prjsel.getUserNmJva();
     String sUserEMailL = prjsel.getUserEMailJva();
     String sUserDeptL = prjsel.getUserDeptJva();

     prjsel = null;

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
<title>Project Detail</title>

<style>body {background:white;}
        a.link1  { color:blue; font-size:14px; font-weight:bold}
        a.link2  { color:blue; font-size:10px; font-weight:bold}
        a.link3  { color:blue; font-size:12px; font-weight:bold}

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

        th.DataTable { background:#FFCC99;padding-top:3px;padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable  { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }
        td.DataTable1 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:center; font-family: Arial;  }
        td.DataTable2 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; font-family: Arial;}
        td.DataTable3 { padding-bottom:15px;}
        td.DataTable30 { background: white; padding-bottom:15px;}
        td.DataTable4  { border:darkblue 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }


        span.spHdr { padding-left:15px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                 border:white 1px solid; vertical-align:top; text-align:center; font-size:12px; font-weight:900 }


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
      #spFilter { display: none;}
      select { display: none;}
      img { display: none;}
    }
</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var Action = "<%=sAction%>";

var Sts = [<%=sSts%>];
var Pty = [<%=sPty%>];
var PtyDesc = [<%=sPtyDesc%>];
var Magn = [<%=sMagn%>];
var MagnDesc = [<%=sMagnDesc%>];
var Area = [<%=sSelArea%>];
var AreaDesc = [<%=sAreaDesc%>];
var Sys = [<%=sSys%>];
var SysDesc = [<%=sSysDesc%>];
var Type = [<%=sTypeSel%>];
var TypeDesc = [<%=sTypeDesc%>];
var AsgSup = [<%=sAsgSup%>];
var AsgSupNm = [<%=sAsgSupNm%>];
var ReqStsSel = [<%=sReqStsSel%>];
var ReqStsDesc = [<%=sReqStsDesc%>];

var UserL = new Array();       <%if(!sUserL.trim().equals("")){%>UserL = [<%=sUserL%>];<%}%>
var UserNmL = new Array();     <%if(!sUserL.trim().equals("")){%>UserNmL = [<%=sUserNmL%>];<%}%>
var UserEMailL = new Array();  <%if(!sUserL.trim().equals("")){%>UserEMailL = [<%=sUserEMailL%>];<%}%>
var UserDeptL = new Array();     <%if(!sUserL.trim().equals("")){%>UserDeptL = [<%=sUserDeptL%>];<%}%>

var CurSts = "<%=sStatus%>";
var CurPty = "<%=sPriority%>";
var CurMagn = "<%=sMagnitude%>";
var CurArea = "<%=sArea%>";
var CurType = "<%=sType%>";
var CurSys = "<%=sSystem%>";
var CurAsgn = "<%=sAssignee%>";
var CurReqBy = "<%=sReqBy%>";
var CurReqSts = "<%=sReqSts%>";
var FiscYr = "<%=sFiscYr%>";
var Weight = "<%=sWgt%>";

//--------------- End of Global variables -----------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSubmit", "dvLoad"]);

   popFsYrMenu();
   popStsMenu();
   popPtyMenu();
   popMagnMenu();
   popAreaMenu();
   popSysMenu();
   popTypeMenu();
   popUserMenu();
   setSpnAsgSup();
   setReqStsMenu();

   if(Action == "New"){ document.all.trAsgSup.style.display = "none"; }
}
//==============================================================================
// populate Fiscal Year menu box
//==============================================================================
function popFsYrMenu()
{
   var begYr = 2012;
   var date = new Date();
   var endYr = date.getFullYear() + 2;

   if(Action == "New" || CurType=="Task"){ document.all.selFsYr.options[0] = new Option("--- Please Select ---", " "); }
   for(var i=begYr, j=1; i < endYr; i++)
   {
      if(FiscYr != i) { document.all.selFsYr.options[j++] = new Option(i, i); }
      else { document.all.selFsYr.options[0] = new Option("--- Current ---", i); }
   }
   document.all.selFsYr.selectedIndex = 0;

   if(Action !="New" && CurType=="Task"){ document.all.spnYear.style.display="none";}
   else{ document.all.spnYear.style.display="block"; }
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
      else
      {
         document.all.selPty.options[0] = new Option("--- Current ---", Pty[i]);
         document.all.PtyDesc.value = Pty[i] + " - " + PtyDesc[i];
      }
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
      else
      {
        document.all.MagnDesc.value = Magn[i] + " - " + MagnDesc[i];
        document.all.selMagn.options[0] = new Option("--- Current ---", Magn[i]);
      }
   }
   document.all.selMagn.selectedIndex = 0;
}
//==============================================================================
// populate Business Area menu box
//==============================================================================
function popAreaMenu()
{
   if(Action == "New"){ document.all.selArea.options[0] = new Option("--- Please Select ---", " "); }
   else { document.all.selArea.options[0] = new Option("--- Current ---", Area[0]); }

   for(var i=0, j=1; i< Area.length; i++)
   {
      if(Area[i] != CurArea) { document.all.selArea.options[j++] = new Option(Area[i], Area[i]); }
   }

   document.all.selArea.selectedIndex = 0;
}
//==============================================================================
// populate Business Area menu box
//==============================================================================
function popSysMenu()
{
   if(Action == "New"){ document.all.selSys.options[0] = new Option("--- Please Select ---", " " ); }
   else { document.all.selSys.options[0] = new Option("--- Current ---", Sys[0]); }

   for(var i=0, j=1; i< Sys.length; i++)
   {
      if(Sys[i] != CurSys) { document.all.selSys.options[j++] = new Option(Sys[i], Sys[i]); }
   }
   document.all.selSys.selectedIndex = 0;
}
//==============================================================================
// populate type dropdown menu
//==============================================================================
function popTypeMenu()
{
   if(Action == "New"){ document.all.selType.options[0] = new Option("--- Please Select ---", " " ); }
   else
   {
      for(var i=0, j=0; i< Type.length; i++)
      {
         if(Type[i] == CurType) { document.all.selType.options[j++] = new Option("--- Current ---", Type[i]); }
      }
   }

   for(var i=0, j=1; i< Type.length; i++)
   {
      if(Type[i] != CurType) { document.all.selType.options[j++] = new Option(Type[i], Type[i]); }
   }
   document.all.selType.selectedIndex = 0;
}
//==============================================================================
// populate request status list
//==============================================================================
function setReqStsMenu()
{
   if(Action == "New"){ document.all.selReqSts.options[0] = new Option("--- Please Select ---", " " ); }
   else { document.all.selReqSts.options[0] = new Option("--- Current ---", ReqStsSel[0]); }

   for(var i=0, j=1; i< ReqStsSel.length; i++)
   {
      if(ReqStsSel[i] != CurReqSts) { document.all.selReqSts.options[j++] = new Option(ReqStsSel[i] + " - " + ReqStsDesc[i], ReqStsSel[i]); }
   }
   document.all.selReqSts.selectedIndex = 0;
}
//==============================================================================
// populate user menus
//==============================================================================
function popUserMenu()
{
   // populate assignee
   if(Action == "New"){ document.all.selAssign.options[0] = new Option("--- Please Select ---", " "); }
   else { document.all.selAssign.options[0] = new Option("--- Current ---", CurAsgn);}
   for(var i=0, j=1; i < UserL.length; i++)
   {
      if(UserL[i] != CurAsgn && UserDeptL[i]=="IT") { document.all.selAssign.options[j++]
         = new Option(UserL[i] + " " + UserNmL[i], UserL[i]); }
   }
   document.all.selAssign.selectedIndex = 0;

   // populate requested by user
   if(Action == "New"){ document.all.selReqBy.options[0] = new Option("--- Please Select ---", " "); }
   else { document.all.selReqBy.options[0] = new Option("--- Current ---", CurReqBy); }
   for(var i=0, j=1; i< UserL.length; i++)
   {
      if(UserL[i] != CurReqBy) { document.all.selReqBy.options[j++]
         = new Option(UserL[i] + " " + UserNmL[i] + " (" + UserDeptL[i] + ")", UserL[i]); }
   }
   document.all.selReqBy.selectedIndex = 0;

}
//==============================================================================
// populate assignee support list
//==============================================================================
function setSpnAsgSup()
{
   var asg = "";
   var coma = "";
   for(var i=0; i < AsgSup.length; i++)
   {
      asg += coma + AsgSup[i];
      coma = ", ";
   }

   document.all.spnAsgSup.innerHTML = asg;
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
   document.all.PtyDesc.value = menu.options[menu.selectedIndex].text;
}
//==============================================================================
// change Magnitude
//==============================================================================
function chgMagn(menu)
{
   document.all.Magn.value = menu.options[menu.selectedIndex].value;
   document.all.MagnDesc.value = menu.options[menu.selectedIndex].text;
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
// change type
//==============================================================================
function chgType(menu)
{
   document.all.Type.value = menu.options[menu.selectedIndex].value;

   // Year is required only for projects
   if(document.all.Type.value=="Task"){ document.all.spnYear.style.display="none";}
   else{ document.all.spnYear.style.display="block"; }
}
//==============================================================================
// change fiscal Year
//==============================================================================
function chgFsYr(menu)
{
   document.all.FiscYr.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// change assignee
//==============================================================================
function chgAssign(menu)
{
   document.all.Assignee.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// change requered by user name
//==============================================================================
function chgReqBy(menu)
{
   document.all.ReqBy.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// change type
//==============================================================================
function chgReqSts(menu)
{
   document.all.ReqSts.value = menu.options[menu.selectedIndex].value;
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
   var reqsts = document.all.ReqSts.value;
   var estcompdt = document.all.EstCompDt.value;
   var compdt = document.all.CompDt.value;
   var area = document.all.Area.value;
   var pty = document.all.Pty.value;
   var wgt = document.all.Weight.value;
   var magn = document.all.Magn.value;
   var comm = document.all.Comm.value;
   var sts = document.all.Sts.value;
   var fsyr = "0";
   if(type.trim() == "Project") { fsyr = document.all.FiscYr.value; }
   else { fsyr="0"; }

   if(name.trim() == ""){ error = true; msg+="\nPlease, enter project name." }
   if(type.trim() == ""){ error = true; msg+="\nPlease, enter project type." }
   if(type.trim() == "Project" && (fsyr.trim() == "" || fsyr.trim() == "0")){ error = true; msg+="\nPlease, enter fiscal year." }
   if(system.trim() == ""){ error = true; msg+="\nPlease, enter system type." }
   if(area.trim() == ""){ error = true; msg+="\nPlease, enter affected business area." }
   if(pty.trim() == ""){ error = true; msg+="\nPlease, enter project pty." }
   if(magn.trim() == ""){ error = true; msg+="\nPlease, enter project magn." }
   if(reqsts.trim() == ""){ error = true; msg+="\nPlease, enter requst status." }
   if(comm.trim().length > 256){ error = true; msg+="\nComments is over the limit of 256 characters." }

   if(estcompdt.trim() == ""){ estcompdt = "01/01/0001" }
   if(compdt.trim() == ""){ compdt = "01/01/0001" }

   if (error) { alert(msg); }
   else { sbmProj(proj, name, desc, assignee, type, system, reqby, estcompdt, compdt
          , area, pty, magn, comm, sts, reqsts, fsyr, wgt); }
}

//==============================================================================
// save changes project properties
//==============================================================================
function sbmProj(proj, name, desc, assignee, type, system, reqby, estcompdt, compdt
          , area, pty, magn, comm, sts, reqsts, fsyr, wgt)
{
   if(window.frame1.document.SavProj != null) { window.frame1.document.removeChild(dvSubmit); }

   var html = "<div name='dvSubmit'>"
        + "<form name='SavProj' action='ProjSave.jsp' method=get>"
        + "<input name='Proj'>"
        + "<input name='Name'><br>"
        + "<input name='Desc'>"
        + "<input name='Assignee'><br>"
        + "<input name='Type'>"
        + "<input name='System'>"
        + "<input name='Reqby'>"
        + "<input name='ReqSts'><br>"
        + "<input name='EstCompDt'>"
        + "<input name='CompDt'>"
        + "<input name='Area'>"
        + "<input name='Pty'><br>"
        + "<input name='Wgt'><br>"
        + "<input name='Magn'>"
        + "<input name='Sts'>"
        + "<input name='Comm'><br>"
        + "<input name='FiscYr'>"
        + "<input name='Action'><br>"

   html += "<br></form>"
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
   window.frame1.document.SavProj.ReqSts.value = reqsts;
   window.frame1.document.SavProj.EstCompDt.value = estcompdt;
   window.frame1.document.SavProj.CompDt.value = compdt;
   window.frame1.document.SavProj.Area.value = area;
   window.frame1.document.SavProj.Pty.value = pty;
   window.frame1.document.SavProj.Wgt.value = wgt;
   window.frame1.document.SavProj.Magn.value = magn;
   window.frame1.document.SavProj.Sts.value = sts;
   window.frame1.document.SavProj.Comm.value = comm;
   window.frame1.document.SavProj.FiscYr.value = fsyr;
   window.frame1.document.SavProj.Action.value = "<%=sAction%>";

   //window.frame1.document.all.dvSubmit.style.visibility = "visible";
   window.frame1.document.SavProj.submit();
}
//==============================================================================
// set new project id
//==============================================================================
function setNewProjId(projId)
{
   var url = "ProjDtl.jsp?Proj=" + projId
           + "&Action=Update";
   window.location.href = url;
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
               + "<input type='hidden' name='ProjId' >"
           + "</form>"
           + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button> &nbsp; "
           + "<button name='Cancel' class='Small' onClick='hidePanel();'>Cancel</button>"
           + "</td></tr>"
     + "</table>"

  //alert(html)
  document.all.dvLoad.innerHTML=html;
  document.all.dvLoad.style.pixelLeft=300
  document.all.dvLoad.style.pixelTop=500;
  document.all.dvLoad.style.visibility="visible"
  document.Upload.ProjId.value = projId;
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
// add new user
//==============================================================================
function addNewUser()
{
   var html = ""
     + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
       + "<td class='BoxName' nowrap>Add New User</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
           + "<tr>"
           + "<td colspan='2' class='Prompt' nowrap>"
           + "<form name='AddUser'  method='post'  action='ProjUserSave.jsp'>"
             + " &nbsp; User: &nbsp;&nbsp; <input name='User' class='Small1' size=10 maxlength=10><br>"
             + " &nbsp; Name: &nbsp;<input name='Name' class='Small1' size=50 maxlength=50> &nbsp; <br>"
             + " &nbsp; EMail: <input name='EMail' class='Small1' size=50 maxlength=50><br>"
             + " &nbsp; Department: <select name='Dept' class='Small'></select><br>"
           + "</form>"
           + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<button name='Submit' class='Small' onClick='validateNewUser()'>Add</button>"
           + "</td></tr>"
     + "</table>"

  //alert(html)
  document.all.dvLoad.innerHTML=html;
  document.all.dvLoad.style.pixelLeft=350
  document.all.dvLoad.style.pixelTop=200;
  document.all.dvLoad.style.visibility="visible"

  for(var i=0; i < Area.length; i++){ document.AddUser.Dept.options[i] = new Option(AreaDesc[i], Area[i])}
}
//==============================================================================
// validate new user
//==============================================================================
function validateNewUser()
{
   var error = false;
   var msg = "";
   var user = document.AddUser.User.value.trim();
   var name = document.AddUser.Name.value.trim();
   var email = document.AddUser.EMail.value.trim();
   var dept = document.AddUser.Dept.options[document.AddUser.Dept.selectedIndex].value.trim();

   if(user.trim() == ""){ error = true; msg+="\nPlease, enter user id." }
   if(name.trim() == ""){ error = true; msg+="\nPlease, enter user name." }
   if(email.trim() == ""){ error = true; msg+="\nPlease, enter user email." }

   if (error) { alert(msg); }
   else
   {
     sbmAddNewUser();
     hidePanel();
     addUserToMenu(user, name, email, dept);
   }
}
//==============================================================================
// submit adding new user form
//==============================================================================
function sbmAddNewUser()
{
   if(window.frame1.document.SavUser != null) { window.frame1.document.removeChild(SavUser); }
   dvSubmit = document.createElement('div');
   dvSubmit.id = "dvSubmit";
   dvSubmit.innerHTML = dvLoad.innerHTML;
   window.frame1.document.appendChild(dvSubmit);
   //alert(window.frame1.document.AddUser.innerHTML);
   window.frame1.document.AddUser.submit();
}
//==============================================================================
// populate user menu
//==============================================================================
function addUserToMenu(user, name, email)
{
   var i = 0;
   if(document.all.selAssign.options != null && document.all.selAssign.options.length > 0)
   {
     i = document.all.selAssign.options.length;
   }
   document.all.selAssign.options[i] = new Option(user + " " + name, user);
   document.all.selAssign.selectedIndex = i;

   var i = 0;
   if(document.all.selReqBy.options != null && document.all.selReqBy.options.length > 0)
   {
     i = document.all.selReqBy.options.length;
   }
   document.all.selReqBy.options[i] = new Option(user + " " + name, user);
   document.all.selReqBy.selectedIndex = i;

   UserL[i] = user;
   UserNmL[i] = name;
   UserEMailL[i] = email;
}
//==============================================================================
// set Assignee Support
//==============================================================================
function setAsgSup()
{
   var html = ""
     + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
       + "<td class='BoxName' nowrap>Update Assignee Suport List</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
           + "<tr>"
           + "<td colspan='2' class='Prompt' nowrap>"
             + popAsgSup()
           + "</td></tr>"

     + "</table>"

  //alert(html)
  document.all.dvLoad.innerHTML=html;
  document.all.dvLoad.style.pixelLeft=350
  document.all.dvLoad.style.pixelTop=200;
  document.all.dvLoad.style.visibility="visible"
}
//==============================================================================
// populate assignee support list
//==============================================================================
function popAsgSup()
{
   dummy="<table>";
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
     + "<tr class='DataTable'>"
        + "<th class='DataTable'>Id"
           + "<input type='hidden' name='chkDltAsgSup' value='DUMMY'>"
        + "</th>"
        + "<th class='DataTable'>Name</th>"
        + "<th class='DataTable'>Delete</th>"
     + "</th>"

     for(var i=0; i < AsgSup.length; i++)
     {
        panel += "<tr class='DataTable'>"
           + "<td style='text-align:left'>" + AsgSup[i] + "</td>"
           + "<td style='text-align:left'>" + AsgSupNm[i] + "</td>"
           + "<td style='text-align:center'>"
              + "<input type='checkbox' name='chkDltAsgSup' value='" + AsgSup[i] + "'>"
           + "</td>"
         + "</tr>"
     }

     panel += "<tr class='DataTable'>"
        + "<th class='DataTable' colspan=3>Add New Assignee support</th>"
     + "</th>"

     for(var i=0; i < UserL.length; i++)
     {
        if(UserDeptL[i] == "IT")
        {
            panel += "<tr class='DataTable'>"
                  + "<td style='text-align:left'>" + UserL[i] + "</td>"
                  + "<td style='text-align:left'>" + UserNmL[i] + "</td>"
                  + "<td style='text-align:center'>"
                     + "<input type='checkbox' name='chkAddAsgSup' value='" + UserL[i] + "'>"
                  + "</td>"
                + "</tr>"
        }
     }

  panel += "<tr>"
           + "<td align=center colspan='3'>"
           + "<button name='Submit' class='Small' onClick='dltAsgSup(); addAsgSup();'>Add/Delete</button>"
           + "</td></tr>"

   panel += "</table>";

   //UserL

   return panel
}
//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvLoad.innerHTML="";
   document.all.dvLoad.style.visibility="hidden";
}

//==============================================================================
// delete Assignee support
//==============================================================================
function dltAsgSup()
{
   var url="ProjSave.jsp?Proj=<%=sSelProjId%>"
   var asgsup = document.all.chkDltAsgSup;
   var max = asgsup.length;
   for(var i=1; i < max; i++)
   {
      if(asgsup[i].checked)
      {
        url += "&AsgSupArr=" + asgsup[i].value;
      }
   }
   url += "&Action=DLTASGSUP"
   //alert(url)
   window.frame1.location.href=url;
}
//==============================================================================
// add Assignee Supports
//==============================================================================
function addAsgSup()
{
   var url="ProjSave.jsp?Proj=<%=sSelProjId%>"
   var asgsup = document.all.chkAddAsgSup;
   var max = asgsup.length;
   for(var i=0; i < max; i++)
   {
      if(asgsup[i].checked)
      {
        url += "&AsgSupArr=" + asgsup[i].value;
      }
   }
   url += "&Action=ADDASGSUP"
   //alert(url)
   window.frame2.location.href=url;
}

//==============================================================================
// send email
//==============================================================================
function sendEmail()
{
   // get email to list
   var emailTo = new Array();
   for(var i=0, j=0; i < document.all.EmailTo.length; i++)
   {
     if(document.all.EmailTo[i].checked && document.all.EmailTo[i].value == "REQUESTER"){ emailTo[j] = document.all.ReqBy.value; j++; }
     if(document.all.EmailTo[i].checked && document.all.EmailTo[i].value == "ASIGNEE"){ emailTo[j] = document.all.Assignee.value; j++; }
     if(document.all.EmailTo[i].checked && document.all.EmailTo[i].value == "SUPPORT")
     {
       for(var k=0; k < AsgSup.length; k++){emailTo[j] = AsgSup[k]; j++; }
     }
     if(document.all.EmailTo[i].checked && document.all.EmailTo[i].value == "SHELLY"){ emailTo[j] = "snixon"; j++; }
   }

   // find email address
   var emailAddr = "";
   var separ = "";
   for(var i=0; i < emailTo.length; i++)
   {
      for(var j=0; j < UserL.length; j++)
      {
         if(UserL[j] == emailTo[i]){ emailAddr += separ + UserEMailL[j]; separ = "," ; break; }
      }
   }

   var msg = "<style>"
      + " table.DataTable { text-align:center;}"
      + " table.DataTable1 { border:#2b7ebb 2px solid; background:white; text-align:center;}"
      + " th.HdrTable{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#2b7ebb, endColorStr=#1b9cc5,"
      + " gradientType=0); padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border:white 1px solid;"
      + " color: #fbb117; vertical-align:top; text-align:center; font-size:12px; font-weight:900 }"
      + " tr.DataTable  { text-align:left; font-size:12px}"
      + " tr.DataTable1 { background:#ececec; text-align:left; font-size:12px}"
      + " tr.Divider { background:#d7d7d7; text-align:left; font-size:5px}"
      + " td.Divider1 { border-bottom:darkblue 1px solid; font-size:1px }"
      + " th.DataTable { background:#FFCC99;padding-top:3px;padding-top:3px; padding-bottom:3px;"
      + " padding-left:3px; padding-right:3px; text-align:center; font-family:Verdanda; font-size:12px }"
      + " td.DataTable  { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }"
      + " td.DataTable1 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:center; font-family: Arial;  }"
      + " td.DataTable2 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; font-family: Arial;}"
      + " td.DataTable3 { padding-bottom:15px;}"
      + " td.DataTable30 { background: white; padding-bottom:15px;}"
      + " td.DataTable4  { border:darkblue 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }"
      + " span.spHdr { padding-left:15px; padding-right:3px; padding-top:3px; padding-bottom:3px;"
      + " border:white 1px solid; vertical-align:top; text-align:center; font-size:12px; font-weight:900 }"
      + " button { display:none; }"
      + " #Notemail { display:none; }"

  msg += "</style>";

  msg += " " + document.all.bdMain.innerHTML;

  var nwelem = window.frame2.document.createElement("div");
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmSendEmail'"
       + " METHOD=Post ACTION='ProjSendEMail.jsp'>"
       + "<input class='Small' name='MailAddr'>"
       + "<input class='Small' name='CCMailAddr'>"
       + "<input class='Small' name='FromMailAddr'>"
       + "<input class='Small' name='Subject'>"
       + "<input class='Small' name='Message'>"
   html += "</form>"

   nwelem.innerHTML = html;
   window.frame2.document.appendChild(nwelem);
   window.frame2.document.all.MailAddr.value = emailAddr;

   window.frame2.document.all.CCMailAddr.value = "";
   window.frame2.document.all.FromMailAddr.value = "itprojandtask@sunandski.com";
   window.frame2.document.all.Subject.value = "Project " + document.all.Proj.value;
   window.frame2.document.all.Message.value=msg;

   //alert(msg)
   window.frame2.document.frmSendEmail.submit();
}
//==============================================================================
// reload this page
//==============================================================================
function restart()
{
  window.location.reload();
}

//==============================================================================
// clear assignee or requested by fieldss
//==============================================================================
function clrUser(fld)
{
   document.all[fld].value = "";
}

//==============================================================================
// apply comment filter or shows all
//==============================================================================
function applyCmtFltr(filter)
{
   var row = document.all.trCmt;
   var type = document.all.tdCmtType;
   for(var i=0; i < row.length; i++)
   {
       if(type[i].innerHTML == filter || filter == "ALL"){ row[i].style.display = "block"; }
       else { row[i].style.display = "none"; }
   }
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


</head>
<body onload="bodyLoad()" id="bdMain">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvLoad" class="dvLoad"></div>
<!-------------------------------------------------------------------->
  <table border="0">
    <tr>
      <td ALIGN="left" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Task/Project<%if(!sProjId.equals("0")){%>:<span style="color:darkred;font-size:18px ">&nbsp;<%=sProjId%> &nbsp; <%=sName%></span><%}%>
      <br>Status: <%=sStatus%></b><br>

<!-------------------------------------------------------------------->
    <tr>
      <td ALIGN="center" VALIGN="TOP" id="tdHdrLink">
        <span id="Notemail"><button onclick="ValidProj()">Save</button>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <span id="Notemail">        
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="ProjLstSel.jsp"><font color="red" size="-1">Selection Filter</font></a>&#62;
        <font size="-1">This page</font>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <a class="link2" href="javascript: addNewUser();">Add New User</a>
        &nbsp; &nbsp; &nbsp;
        <a class="link2" href="ProjDtl.jsp?Proj=0&Action=New">Add New</a>
        </span>

   <tr><td class="Divider1">&nbsp;</td></tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP">

 <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="5" cellSpacing="10">
  <!------------------------- Data Detail ------------------------------>
        <tr class="DataTable">
          <td class="DataTable4" colspan=2 nowrap>
             <span style="<%if(!sProjId.equals("0")){%>display:none;<%}%>">
                <span class="spHdr">Project ID:</span><input name="Proj" size=10  maxlength=10 class="Small" value="<%=sProjId%>" readonly>
             </span>


             <span class="spHdr">Type:</span>
                 <input name="Type" size=30  maxlength=30 class="Small" value="<%=sType%>" readonly>
                     <span id="Notemail"><select name="selType" class="Small" onchange="chgType(this)"></select></span>

             <span class="spHdr">Name:</span>
                  <input name="Name" size=50  maxlength=50 class="Small" value="<%=sName%>" >

             <br>
             <span id="spnYear"><br><span class="spHdr">Year:</span>
                  <input name="FiscYr" size=4  maxlength=4 class="Small" value="<%=sFiscYr%>" readonly>
                  <span id="Notemail"><select name="selFsYr" class="Small" onchange="chgFsYr(this)"></select><br></span>
             </span>

             <br><span class="spHdr">Status</span>
                  <input name="Sts" size=30  maxlength=50 class="Small" value="<%=sStatus%>" readonly>
                  <span id="Notemail"><select name="selSts" class="Small" onchange="chgSts(this)"></select></span><br><br>
             <span class="spHdr">Description:</span>
                  <textarea name="Desc" class="Medium" value="<%=sName%>" cols=110 rows=3><%=sDesc%></textarea>
          </td>
        </tr>
        <!---------------------------- Next Line ------------------------------>
        <tr class="DataTable">
          <td class="DataTable4">
             <table border=0>
               <tr>
                 <td valign="middle"><span class="spHdr">Requested By User</span>
                 <td valign="top" nowrap><input name="ReqBy" size=10  maxlength=10 class="Small" value="<%=sReqBy%>" readonly>
                     <span id="Notemail"><select name="selReqBy" class="Small" onchange="chgReqBy(this)"></select> &nbsp; <a class="link2" href="javascript: clrUser('ReqBy');">Clear</a></span>
               </tr>

               <tr style="display:none;">
                 <td valign="middle" nowrap><span class="spHdr">Request Status:<br></span>
                 <td valign="top" nowrap><input name="ReqSts" size=30  maxlength=30 class="Small" value="Submitted" readonly>
                     <span id="Notemail"><select name="selReqSts" class="Small" onchange="chgReqSts(this)"></select></span>
                 </td>
               </tr>

               <tr>
                 <td valign="middle"><span class="spHdr">Assignee:</span>
                 <td valign="top" nowrap><input name="Assignee" size=10  maxlength=10 class="Small" value="<%=sAssignee%>" readonly>
                     <span id="Notemail"><select name="selAssign" class="Small" onchange="chgAssign(this)"></select> &nbsp; <a class="link2" href="javascript: clrUser('Assignee');">Clear</a><br></span><br>
               <tr>
               <tr id="trAsgSup">
                 <td valign="middle" nowrap><span class="spHdr">Assignee Support:</span>
                 <td valign="top" nowrap><span id="spnAsgSup" style="border-bottom:1px solid black;font-size:12px">&nbsp;</span> &nbsp; &nbsp; &nbsp; &nbsp;
                     <span id="Notemail"><a class="link2" href="javascript: setAsgSup();">Update</a></span>
                 </td>
               <tr>
                 <td valign="middle" nowrap><span class="spHdr">Need To Complete By</span>
                 <td valign="top" nowrap><span id="Notemail"><button class="Small" name="Down" onClick="setDate('DOWN', 'EstCompDt')">&#60;</button></span>
               <input name="EstCompDt" size=10  maxlength=10 class="Small" <%if(!sEstComplDt.equals("01/01/0001")){%>value="<%=sEstComplDt%>"<%}%>>
               <span id="Notemail"><button class="Small" name="Up" onClick="setDate('UP', 'EstCompDt')">&#62;</button>
                &nbsp;&nbsp;&nbsp;
               <a href="javascript:showCalendar(1, null, null, 160, 280, document.all.EstCompDt)" >
               <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
               </span>

             <tr>
               <td valign="middle" nowrap><span class="spHdr">Completion Date</span>
               <td valign="top" nowrap><span id="Notemail"><button class="Small" name="Down" onClick="setDate('DOWN', 'CompDt')">&#60;</button></span>
                <input name="CompDt" size=10  maxlength=10 class="Small" <%if(!sComplDt.equals("01/01/0001")){%>value="<%=sComplDt%>"<%}%>>
                <span id="Notemail"><button class="Small" name="Up" onClick="setDate('UP', 'CompDt')">&#62;</button>
                &nbsp;&nbsp;&nbsp;
                <a href="javascript:showCalendar(1, null, null, 450, 260, document.all.CompDt)" >
                <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
                </span>
             </table>
         <!---------------------------- Next Line ------------------------------>
          <td class="DataTable4" nowrap>
             <table>
               <tr>
                 <td valign="middle" nowrap><span class="spHdr">System:</span>
                 <td valign="top" nowrap><input name="System" size=25  maxlength=30 class="Small" value="<%=sSystem%>" readonly>
                     <span id="Notemail"><select name="selSys" class="Small" onchange="chgSys(this)"></select></span>
               <tr>
                 <td valign="middle" nowrap><span class="spHdr">Business Area</span>
                 <td valign="top" nowrap><input name="Area" size=25  maxlength=50 class="Small" value="<%=sArea%>" readonly>
                     <span id="Notemail"><select name="selArea" class="Small" onchange="chgArea(this)"></select></span><br><br>
               <tr>
                 <td valign="middle"><span class="spHdr">Priority</span>
                 <td valign="top" nowrap><input name="PtyDesc" class="Small" readonly>
                     <input name="Pty" type="hidden" value="<%=sPriority%>" readonly>
                     <span id="Notemail"><select name="selPty" class="Small" onchange="chgPty(this)"></select></span>
                 </td>
               </tr>
               <tr>
                 <td valign="middle"><span class="spHdr">Weight</span></td>
                 <td valign="top" nowrap><input name="Weight" class="Small" value="<%=sWgt%>">                                 
                 </td>
               </tr>
                     
               <tr>
                 <td valign="middle"><span class="spHdr">Effort</span>
                 <td valign="top" nowrap><input name="MagnDesc" class="Small" readonly>
                     <input name="Magn" type="hidden" class="Small" value="<%=sMagnitude%>" readonly>
                     <span id="Notemail"><select name="selMagn" class="Small" onchange="chgMagn(this)"></select></span><br><br>
             </table>
        <!---------------------------- Next Line ------------------------------>
        <tr class="DataTable">
          <td class="DataTable1" colspan=2>

             <br><span id="Notemail"><span class="spHdr">New Comments:</span>
                  <textarea name="Comm" class="Small" cols="100" rows="3"></textarea><br>
                  <span style="font-size:10px">Each comment is limited to 256 characters</span></span>
                  <br>
          </td>
        </tr>
        <tr class="DataTable" id="tdBotton">
          <td class="DataTable1" nowrap>
             <span id="Notemail"><button onclick="ValidProj()">Save</button>
             &nbsp; &nbsp; &nbsp;
             <span id="Notemail"><button onclick="sendEmail()">Send Email</button>
             <input name="EmailTo" type="checkbox" value="REQUESTER">Requester &nbsp;
             <input name="EmailTo" type="checkbox" value="ASIGNEE" checked>Assignee &nbsp;
             <input name="EmailTo" type="checkbox" value="SUPPORT" checked>Support &nbsp;
             <input name="EmailTo" type="checkbox" value="SHELLY">Shelly &nbsp;

             <%if(!sProjId.equals("0")){%>
                  &nbsp; &nbsp; &nbsp; &nbsp;
                  <button onClick="loadDoc('<%=sProjId%>')">Load Document</button>
             <%}%>
             </span>
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
           <td class="DataTable"><a href="<%="ProjectDocs/" + sDoc.trim()%>" target="_blank"><%=sDoc%></a></td>
           <td class="DataTable"><a href="javascript: dltFile('<%=sDir + "/" + sDoc%>')">Delete</a></td>
        </tr>
    <%}%>
  </table>

<br>
<br>
<%if(!sAction.equals("New")){%>

   <span id="spFilter" style="font-size:12px;">Comment filter:
      <a class="link3" href="javascript: applyCmtFltr('User');">User</a>, &nbsp;
      <a class="link3" href="javascript: applyCmtFltr('Auto');">Auto</a>, &nbsp;
      <a class="link3" href="javascript: applyCmtFltr('ALL');">All</a>
   </span>

  <table class="DataTable1" cellPadding="0" cellSpacing="0" width="100%">
    <tr>
      <th class="HdrTable">Type</th>
      <th class="HdrTable" width="75%">Comment</th>
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
         <tr class="DataTable1" id="trCmt">
           <td class="DataTable" id="tdCmtType"><%=sCmtType[i]%></td>
           <td class="DataTable"><%=sCmtTxt[i]%></td>
           <td class="DataTable" nowrap><%=sCmtUser[i]%></td>
           <td class="DataTable" nowrap><%=sCmtDate[i]%></td>
           <td class="DataTable" nowrap><%=sCmtTime[i]%></td>
         </tr>
         <tr class="Divider"><td colspan=5>&nbsp</td></tr>
      <%}%>
    <%}%>
  </table>
<%}%>
 </body>
</html>
<%
  if(projdtl != null) {  projdtl.disconnect();  projdtl=null; }
}%>