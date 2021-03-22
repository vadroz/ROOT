<%@ page import="java.util.*, java.text.*"%>
<%
%>
<HTML>
<HEAD>
<title>Server Logs</title>
<META content="RCI, Inc." name="ServerLog" http-equiv="refresh" content="60"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        table.PgMain { border-spacing: 0px; border-collapse: collapse; width:100%; font-size:10px }
        table.DataTable { font-size:10px }

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px;
                       padding-bottom:3px; text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable0 { background: black; color:white;font-size:12px }
        tr.DataTable1 { background: LemonChiffon; font-size:12px}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableR { background: red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableY { background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableC { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1C { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable2C { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        .Small {font-size:10px }
        .Medium {font-size:11px }
        .btnSmall {font-size:8px; display:none;}
        .Warning {font-size:12px; font-weight:bold; color:red; }

        div.dvLog { width:500px; height:400px; overflow:auto; text-wrap: unrestricted}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Cell {font-size:12px; text-align:right; vertical-align:top}
        td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
        td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
</style>


<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	// developing site
	rtvLogs(false);
	// production
	//rtvLogs(true);
}
//==============================================================================
// retreive log data 
//==============================================================================
function rtvLogs(prod)
{
	
	setLog("tomcat9-stdout", 0, prod);
	setLog("tomcat9-stderr", 1, prod);
	//setLog("localhost_access_log", 2, false);
	//setLog("localhost", 3, false);	
    //setLog("catalina", 4, false);
	//setLog("host-manager", 5, false);
	//setLog("commons-daemon", 6, false);
}

//==============================================================================
// set log data in table  
//==============================================================================
function setLog(log, line, prod)
{	
	var resp = loadLog(log, prod);	
	
	var cellnm = "tdLogNmDev" + line;
	if(prod){ cellnm = "tdLogNmProd" + line; }	
	var cell = document.all[cellnm];	
	cell.innerHTML = parseFileNm(resp); 
	
	var cellnm = "dvLogDev" + line;
	if(prod){ cellnm = "dvLogProd" + line; }
	
	var cell = document.all[cellnm];
	cell.innerHTML = parseLines(resp);
	var t = cell.scrollTop;
	var h = cell.scrollHeight;	 
	cell.scrollTop = cell.scrollHeight; 
}
//==============================================================================
//parse filename 
//==============================================================================
function parseFileNm(resp)
{
	var beg = resp.indexOf("<file>") + "<file>".length;
	var end = resp.indexOf("</file>");
	var file = resp.substring(beg, end);
	
	var beg = resp.indexOf("<lastmoddate>") + "<lastmoddate>".length;
	var end = resp.indexOf("</lastmoddate>");
	var lastdt = resp.substring(beg, end);
	
	return file + " " + lastdt;
}

//==============================================================================
//parse lines 
//==============================================================================
function parseLines(resp)
{
	var beg = resp.indexOf("<$#@lines$#@>") + "<$#@lines$#@>".length;
	var end = resp.indexOf("</$#@lines$#@>");
	
	var lines = resp.substring(beg, end);	
	return lines;
}
//==============================================================================
// load log by ajax
//==============================================================================
function loadLog(log, prod)
{
	   var url = "RtvLogs.jsp?log=" + log 
		 + "&prod=" + prod;
	   var resp = null;

	   var xmlhttp;
	   // code for IE7+, Firefox, Chrome, Opera, Safari
	   if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	   // code for IE6, IE5
	   else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	   xmlhttp.onreadystatechange=function()
	   {
	      if (xmlhttp.readyState==4 && xmlhttp.status==200)
	      {
	         resp = xmlhttp.responseText;	         
	      }
	   }
	   xmlhttp.open("GET",url,false); // synchronize with this apps
	   xmlhttp.send();
	   return resp;
}

</script>

<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<TABLE class="PgMain">
  <TBODY>
   <TR bgColor="moccasin">
    <TD vAlign=top align=left><B>Retail Concepts Inc.
        <BR>Servers Logs 
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;
    </td>
   </tr>
    <TR bgColor=moccasin>
    <TD vAlign="top" align="middle" colspan=2>
<!-- ======================================================================= -->
       <table class="DataTable" cellPadding="0" cellSpacing="0" border=1>
         <tr class="DataTable">             
             <th class="DataTable">Developing Server &nbsp; 
                <button class="Small" onclick="rtvLogs(false);">Refresh</button>
             </th>
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">Production Server &nbsp; 
                <button class="Small" onclick="rtvLogs(true);">Refresh</button>
             </th>
         </tr>
       <!-- ============================ Details =========================== -->
         <%for(int i=0; i < 2; i++){%>
         <tr class="DataTable1">
            <td class="DataTable1" id="tdLogNmDev<%=i%>"></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable1" id="tdLogNmProd<%=i%>"></td>
         </tr>
         <tr class="DataTable0">
           <td class="DataTable1" id="tdLogDev<%=i%>">
              <div id="dvLogDev<%=i%>" class="dvLog"></div>
           </td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable1" id="tdLogProd<%=i%>">
              <div id="dvLogProd<%=i%>" class="dvLog"></div>
           </td>
         </tr>
         <%}%>
   </table>
  </TD>
 </TR>

 </TBODY>
</TABLE>
</BODY></HTML>
