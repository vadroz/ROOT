<%@ page import="projmgmt.ProjList, projmgmt.ProjLstSel, java.util.*, java.io.*"%>
<%
   String [] sSelSts = request.getParameterValues("Sts");

   String [] sSelType = request.getParameterValues("Type");
   String [] sSelYear = request.getParameterValues("Year");
   String sSelAsg = request.getParameter("Asg");
   String sSelAsgSup = request.getParameter("AsgSup");
   String [] sSelPty = request.getParameterValues("Pty");
   String sSelMagn = request.getParameter("Magn");
   String sSelReqBy = request.getParameter("ReqBy");
   String sSelReqSts = request.getParameter("ReqSts");
   String sSelSys = request.getParameter("Sys");
   String sSelBusArea = request.getParameter("BusArea");

   String sSelReqFrDate = request.getParameter("ReqFrDate");
   String sSelReqToDate = request.getParameter("ReqToDate");
   String sSelLstFrDate = request.getParameter("LstFrDate");
   String sSelLstToDate = request.getParameter("LstToDate");
   String sSort = request.getParameter("Sort");
   String sKeyword = request.getParameter("Keyword");

   if(sSelAsg == null) { sSelAsg = "ALL"; }
   if(sSelAsgSup == null) { sSelAsgSup = "ALL"; }
   if(sSelMagn == null) { sSelMagn = "ALL"; }
   if(sSelReqBy == null) { sSelReqBy = "ALL"; }
   if(sSelReqSts == null) { sSelReqSts = "ALL"; }
   if(sSelSys == null) { sSelSys = "ALL"; }
   if(sSelBusArea == null) { sSelBusArea = "ALL"; }
   if(sSort == null) { sSort = "PROJ"; }
   if(sKeyword == null) { sKeyword = " "; }

   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ProjList.jsp&" + request.getQueryString());
   }
   else
   {
     String sUser = session.getAttribute("USER").toString();

     ProjList projlst = new ProjList(sSelType, sSelYear, sSelAsg, sSelAsgSup, sSelPty, sSelMagn
        , sSelReqBy, sSelReqSts, sSelSys, sSelBusArea, sSelSts, sSelReqFrDate
        , sSelReqToDate, sSelLstFrDate, sSelLstToDate, sKeyword, sSort, sUser);

     ProjLstSel prjsel = new ProjLstSel();
     prjsel.setStatus();
     String sSts = prjsel.getStsJva();     
     String sStsDesc = prjsel.getStsDescJva();
     prjsel.setPriority();
     String sPty = prjsel.getPtyJva();
     String sPtyNm = prjsel.getPtyDescJva();
     
     // check if project has attached documents
     String sDir = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/ProjectDocs";
     int ilen = sDir.length();
     File fDir = new File(sDir);
     File [] fList = fDir.listFiles();             
%>

<html>
<head>
<title>Project List</title>
<style>body {background:F0FFF0;}
        a.link1  { color:red; font-size:14px; font-weight:bold}
        a.small  { color:#fbb117;}

        table.DataTable { border:#2b7ebb 2px solid; background:white; text-align:center;}

        th.HdrTable{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#2b7ebb, endColorStr=#1b9cc5,
                 gradientType=0);
                 padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border:white 1px solid;
                 color: #fbb117; vertical-align:top; text-align:center; font-size:12px; font-weight:900 }

        tr.DataTable  { background:#ecece0; text-align:left; font-size:12px}
        tr.DataTable1 { background:#ececec; text-align:left; font-size:12px}

        tr.Divider { background:#d7d7d7; text-align:left; font-size:5px}

        td.DataTable  { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }
        td.DataTable1 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:center; }
        td.DataTable2 { border:white 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:right;}
        td.DataTable3 { padding-bottom:15px;}
        td.DataTable30 { background: white; padding-bottom:15px;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; }

@media print
{
   #alinkName { text-decoration:none; }
   th.HdrTable { color: black; background: white; border-bottom: black 1px solid;}
   a.small { text-decoration:none; color: black; background: white; font-size:12px;  font-weight:bold}
   td.DataTable  { border-bottom: lightgray 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:left; }
   td.DataTable1 { border-bottom: lightgray 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:center; }
   td.DataTable2 { border-bottom: grey 1px solid; padding-left:5px; padding-right:5px; padding-top:3px; padding-bottom:3px; text-align:right;}
}


</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var Status = [<%=sSts%>];
var ArrPty = [<%=sPty%>];
var ArrPtyDesc = [<%=sPtyNm%>];

var SelType = new Array();
<%for(int i=0; i < sSelType.length; i++){%>SelType[<%=i%>] = "<%=sSelType[i]%>"; <%}%>
var SelYear = new Array();
<%for(int i=0; i < sSelYear.length; i++){%>SelYear[<%=i%>] = "<%=sSelYear[i]%>"; <%}%>
var SelPty = new Array();
<%for(int i=0; i < sSelPty.length; i++){%>SelPty[<%=i%>] = "<%=sSelPty[i]%>"; <%}%>
var SelSts = new Array();
<%for(int i=0; i < sSelSts.length; i++){%>SelSts[<%=i%>] = "<%=sSelSts[i]%>"; <%}%>

var SelAsg = "<%=sSelAsg%>";
var SelAsgSup = "<%=sSelAsgSup%>";
var SelMagn = "<%=sSelMagn%>";
var SelReqBy = "<%=sSelReqBy%>";
var SelReqSts = "<%=sSelReqSts%>";
var SelSys = "<%=sSelSys%>";
var SelBusArea = "<%=sSelBusArea%>";
var SelReqFrDate = "<%=sSelReqFrDate%>";
var SelReqToDate = "<%=sSelReqToDate%>";
var SelLstFrDate = "<%=sSelLstFrDate%>";
var SelLstToDate = "<%=sSelLstToDate%>";

//--------------- End of Global variables -----------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// change project
//==============================================================================
function chgProj(projId, action)
{
   var url = "ProjDtl.jsp?Proj=" + projId
     + "&Action=" + action;

   window.open(url);
}

//==============================================================================
// set Status
//==============================================================================
function setSts(projId, sts)
{
   var hdr = "Proj ID:&nbsp;" + projId;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popStsPanel(projId, sts)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   for(var i=0, j=0; i < Status.length; i++)
   {
      if(Status[i] != sts)
      {
        document.all.selNewSts.options[j] = new Option(Status[i], Status[i]);
        j++;
      }
   }
}
//==============================================================================
// populate Status panel
//==============================================================================
function popStsPanel(projId, sts)
{
  var panel = "<br><table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt' >Current Status:</td>"
           + "<td class='Prompt'>" + sts + "<br></td>"
         + "</tr>"
         + "<tr><td class='Prompt'>New Status:</td>"
           + "<td class='Prompt'>"
             + "<select name='selNewSts' class='Small'></select>" + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmSts(&#34;" + projId + "&#34;)' "
        + "class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// submit status
//==============================================================================
function sbmSts(projId)
{
   hidePanel()
   var sts = document.all.selNewSts.options[document.all.selNewSts.selectedIndex].value
   var url = "ProjSave.jsp?Proj=" + projId
           + "&Sts=" + sts
           + "&Action=UpdSts";
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
//set priority and weight
//==============================================================================
function setPty(projId, pty)
{
	var hdr = "Proj ID:&nbsp;" + projId;
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"  
	  + "<tr>"
        + "<td class='BoxName' nowrap>" + hdr + "</td>"
    	+ "<td class='BoxClose' valign=top>"
      		+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    	+ "</td></tr>"
 		+ "<tr><td class='Prompt' colspan=2>"
            + popPtyPanel(projId, pty)
        + "</td></tr>"
	+ "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
	
	for(var i=0, j=0; i < ArrPty.length; i++)
	{
	   if(ArrPty[i] != pty)
	   {
	      document.all.selNewPty.options[j] = new Option(ArrPty[i] + "-" + ArrPtyDesc[i], ArrPty[i]);
	      j++;
	   }
	}
}
//==============================================================================
//populate priority panel
//==============================================================================
function popPtyPanel(projId, pty)
{
	var panel = "<br><table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<tr><td class='Prompt' >Current Priority:</td>"
        + "<td class='Prompt' id='tdPty'>" + pty + "<br></td>"
      + "</tr>"
      + "<tr><td class='Prompt'>New Priority:</td>"
        + "<td class='Prompt'>"
          + "<select name='selNewPty' class='Small'></select>" + "</td>"
      + "</tr>"
      
	panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
     + "<button onClick='sbmPty(&#34;" + projId + "&#34;)' "
     + "class='Small'>Submit</button>&nbsp;"
     + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

	panel += "</table>";

	return panel;
}
//==============================================================================
//submit priority
//==============================================================================
function sbmPty(projId)
{
hidePanel()
var pty = document.all.selNewPty.options[document.all.selNewPty.selectedIndex].value
var url = "ProjSave.jsp?Proj=" + projId
        + "&Pty=" + pty
        + "&Action=UpdPty";
//alert(url);
window.frame1.location.href=url;
}
//==============================================================================
//set priority and weight
//==============================================================================
function setWgt(projId, wgt)
{
	var hdr = "Proj ID:&nbsp;" + projId;
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"  
	  + "<tr>"
      + "<td class='BoxName' nowrap>" + hdr + "</td>"
  	+ "<td class='BoxClose' valign=top>"
    		+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
  	+ "</td></tr>"
		+ "<tr><td class='Prompt' colspan=2>"
          + popWgtPanel(projId, wgt)
      + "</td></tr>"
	+ "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate priority panel
//==============================================================================
function popWgtPanel(projId, wgt)
{
	var panel = "<br><table border=0 width='100%' cellPadding='0' cellSpacing='0'>"	
    + "<tr><td class='Prompt'>Weigth:</td>"
        + "<td class='Prompt'>"
           + "<input name='Wgt' class='Small' value='" + wgt + "'>" + "</td>"
    + "</tr>"
    
	panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
   + "<button onClick='sbmWgt(&#34;" + projId + "&#34;)' "
   + "class='Small'>Submit</button>&nbsp;"
   + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

	panel += "</table>";

	return panel;
}
//==============================================================================
//submit priority
//==============================================================================
function sbmWgt(projId)
{
hidePanel();
var wgt = document.all.Wgt.value.trim();
var url = "ProjSave.jsp?Proj=" + projId
      + "&Wgt=" + wgt
      + "&Action=UpdWgt";
//alert(url);
window.frame1.location.href=url;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
// reload this page
//==============================================================================
function restart()
{
  window.location.reload();
}
//==============================================================================
// re-sort listing
//==============================================================================
function resort(sort)
{
   var url = "ProjList.jsp?Asg=" + SelAsg
    + "&AsgSup=" + SelAsgSup
    + "&Magn=" + SelMagn
    + "&ReqBy=" + SelReqBy
    + "&ReqSts=" + SelReqSts
    + "&Sys=" + SelSys
    + "&BusArea=" + SelBusArea
    + "&ReqFrDate=" + SelReqFrDate
    + "&ReqToDate=" + SelReqToDate
    + "&LstFrDate=" + SelLstFrDate
    + "&LstToDate=" + SelLstToDate
    + "&Keyword=<%=sKeyword%>"

   for(var i=0; i < SelSts.length; i++) { url += "&Sts=" + SelSts[i] }
   for(var i=0; i < SelType.length; i++) { url += "&Type=" + SelType[i] }
   for(var i=0; i < SelYear.length; i++) { url += "&Year=" + SelYear[i] }
   for(var i=0; i < SelPty.length; i++) { url += "&Pty=" + SelPty[i] }

   url += "&Sort=" + sort
   window.location.href = url;
}
//==============================================================================
// retreive comments
//==============================================================================
function getComment(proj)
{
    var url = "ProjComment.jsp?Proj=" + proj
    //alert(url)
    window.frame1.location.href = url;
}
//==============================================================================
// set comments box
//==============================================================================
function setComment(proj, commt, recUs, recDt, recTm)
{
   var hdr = "Project &nbsp;" + proj + " commnets";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popComment(proj, commt, recUs, recDt, recTm)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 1000;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
// populate comments panel
//==============================================================================
function popComment(proj, commt, recUs, recDt, recTm)
{
	
  var panel = "<textarea name='Comm' class='Small' cols='100' rows='3'></textarea>"
      + "<br><span style='font-size:10px'>Each comment is limited to 256 characters</span><br>";
  panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr>"
         + "<td class='Prompt' >Comments</td>"
         + "<td class='Prompt' >User</td>"
         + "<td class='Prompt' >Date</td>"
         + "<td class='Prompt' >Time</td>"
       + "</tr>"
  for(var i=0; i < commt.length; i++)
  {
    panel += "<tr>"
          + "<td class='Prompt'>" + commt[i] + "</td>"
          + "<td class='Prompt' nowrap>" + recUs[i] + "</td>"
          + "<td class='Prompt' nowrap>" + recDt[i] + "</td>"
          + "<td class='Prompt' nowrap>" + recTm[i] + "</td>"
       + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan='4'><br><br>"
	     + "<button onClick='vldCommt(&#34;" + proj + "&#34;)'  class='Small'>Add</button>"
         + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
//validate comments
//==============================================================================
function vldCommt(proj)
{
	var error = false;
	var msg ="";
	var commt = document.all.Comm.value.trim();
	
	if(commt==""){ error=true; msg="Comment is empty";}
	
	if(error){alert(msg);}
	else{ sbmCommt(proj, commt); }
}
//==============================================================================
//submit priority
//==============================================================================
function sbmCommt(projId, comm)
{		
	hidePanel();
	var url = "ProjSave.jsp?Proj=" + projId
      + "&Comm=" + comm
      + "&Action=AddCommt";
	//alert(url);
	window.frame1.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
    <table border="0">
             <tr>
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Task/Project List</b><br>
<!-------------------------------------------------------------------->
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="ProjLstSel.jsp"><font color="red" size="-1">Selection Filter</font></a>&#62;
        <font size="-1">This page</font>

        &nbsp; &nbsp; &nbsp; &nbsp;
        <a class="link1" href="ProjDtl.jsp?Proj=0&Action=New">Add New</a>

    <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="trHdr">
            <th class="HdrTable">No.</th>
            <th class="HdrTable"><a class="small" href="javascript: resort('PROJ')">Project ID</a></th>
            <th class="HdrTable">Type</th>
            <th class="HdrTable"><a class="small" href="javascript: resort('PTY')">Priority</a></th>
            <th class="HdrTable">Weigth</th>
            <th class="HdrTable"><a class="small" href="javascript: resort('NAME')">Name</a></th>
            <th class="HdrTable"><a class="small" href="javascript: resort('SYSTEM')">System</a></th>
            <th class="HdrTable">Area</th>
            <th class="HdrTable"><a class="small" href="javascript: resort('ASG')">Assignee</a></th>
            <th class="HdrTable">Assignee<br>Support</th>
            <th class="HdrTable">Status</th>
            <th class="HdrTable"><a class="small" href="javascript: resort('LASTDT')">Last<br>Updated</a></th>
            <th class="HdrTable">Description</th>
            <th class="HdrTable"><a class="small" href="javascript: resort('EFF')">Efforts</a></th>
            <th class="HdrTable">C<br>o<br>m<br>m<br>e<br>n<br>t</th>
            <th class="HdrTable"><a class="small" href="javascript: resort('REQBY')">Requested<br>By</a></th>
            <th class="HdrTable"><a class="small" href="javascript: resort('REQDT')">Requested<br>Date</a></th>
            <th class="HdrTable"><a class="small" href="javascript: resort('YEAR')">Fiscal<br>Year</a></th>
            <th class="HdrTable">Doc?</th>
          </tr>
      <!------------------------- Data Detail ------------------------------>
      <%int iCount = 1;
        while(projlst.getNext()){
          projlst.setProjList();
          int iNumOfPrj = projlst.getNumOfPrj();
          String [] sProjId = projlst.getProjId();
          String [] sName = projlst.getName();
          String [] sAssignee = projlst.getAssignee();
          String [] sDesc = projlst.getDesc();
          String [] sType = projlst.getType();
          String [] sSystem = projlst.getSystem();
          String [] sReqBy = projlst.getReqBy();
          String [] sReqDate = projlst.getReqDate();
          String [] sArea = projlst.getArea();
          String [] sPriority = projlst.getPriority();
          String [] sPtyDesc = projlst.getPtyDesc();
          String [] sMagnitude = projlst.getMagnitude();
          String [] sMagnDesc = projlst.getMagnDesc();
          String [] sStatus = projlst.getStatus();
          String [][] sAsgSup = projlst.getAsgSup();
          String [] sFiscYr = projlst.getFiscYr();
          String [] sRecDt = projlst.getRecDt();
          String [] sWgt = projlst.getWgt();
        %>

         <%for(int i=0; i < iNumOfPrj; i++ ) {
        	 
             String sDoc = "";
             // format project id to 10 characters string
             String sPrefix = "P_";
             String sTenDig = "0000000000";
             String sFormated = sTenDig.substring(0, 10 - sProjId[i].length()) + sProjId[i];
             sPrefix += sFormated;
             
             if (fList != null && fList.length > 0)
             {            	
           	    for(int j=0; j < fList.length; j++)
           	    { 	
                    if(fList[j].getName().indexOf(sPrefix) >= 0) { sDoc = "Yes"; break;}
                }
             }          

         %>
         
            <tr class="DataTable">
              <td class="DataTable" nowrap><%=iCount++%></td>
              <td class="DataTable" nowrap><%=sProjId[i]%></td>
              <td class="DataTable" nowrap><%=sType[i]%></td>
              <td class="DataTable1" nowrap><a href="javascript: setPty('<%=sProjId[i]%>', '<%=sPriority[i]%>')"><%=sPriority[i]%>-<%=sPtyDesc[i]%></a></td>
              <td class="DataTable1" nowrap><a href="javascript: setWgt('<%=sProjId[i]%>', '<%=sWgt[i]%>')"><%=sWgt[i]%></a></td>
              <td class="DataTable" nowrap width="25%"><a id="alinkName" href="javascript: chgProj('<%=sProjId[i]%>', 'Update')"><%=projlst.getWrapWords(sName[i], 20)%></a></td>
              <td class="DataTable" nowrap><%=sSystem[i]%></td>
              <td class="DataTable" nowrap><%=sArea[i]%></td>
              <td class="DataTable" nowrap><%=sAssignee[i]%></td>

              <td class="DataTable">
                 <% String coma = "";
                 for(int j=0; j < sAsgSup[i].length; j++){%><%=coma + sAsgSup[i][j]%><%coma=",";%><%}%>
                 &nbsp;
              </td>

              <td class="DataTable"><a href="javascript: setSts('<%=sProjId[i]%>', '<%=sStatus[i]%>')"><%=sStatus[i]%></a></td>
              <td class="DataTable" nowrap><%=sRecDt[i]%></td>
              <td class="DataTable" nowrap width="25%" ><%=projlst.getWrapWords(sDesc[i], 30)%></td>
              <td class="DataTable" nowrap><%=sMagnDesc[i]%></td>
              <td class="DataTable"><a href="javascript: getComment('<%=sProjId[i]%>')">C</a></td>
              <td class="DataTable"><%=sReqBy[i]%></td>
              <td class="DataTable1"><%=sReqDate[i]%></td>
              <td class="DataTable1"><%=sFiscYr[i]%></td>
              <td class="DataTable1"><%=sDoc%></td>
             </tr>
             <tr class="Divider"><td colspan=30>&nbsp</td></tr>
           <%}%>
        <%}%>
      </table>
     <!--------------------------------------------------------------------->
  </table>
 </body>
</html>
<%
   projlst.disconnect();
   projlst = null;
}%>