<%@ page import="java.util.*, eventcalendar.EvtGrpLst"%>
<%

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=" + request.getRequestURI() + "&APPL=ADVERTISES");
}
else
{
    EvtGrpLst grpLst = new EvtGrpLst();

    int iNumOfGrp = grpLst.getNumOfGrp();
    String [] sGrp = grpLst.getGrp();
    int [] iNumOfCol = grpLst.getNumOfCol();
    String [][] sCol = grpLst.getCol();

    grpLst.disconnect();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center; font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}
  tr.DataTable1 { color: red; background:cornsilk; font-family:Verdanda; font-size:12px; font-weight:bold}
  tr.DataTable2 { background:#e7e7e7; font-family:Arial; text-align:left; font-size:10px;}
  td.DataTable { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 border-right: darkred solid 1px;}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:350; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt {border:none; text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 {border: none; text-align:center; font-family:Arial; font-size:10px; }
  td.Prompt2 {border: none; text-align:right; font-family:Arial; font-size:10px; }
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
  window.document.focus();
}
//==============================================================================
// Add, Update, Delete Group
//==============================================================================
function entGroup(action, grp, cols)
{
   var hdr = null;
   if(action == "ADD") hdr = "Add Group"
   else if(action == "DLT") hdr = "Delete Group: " + grp

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>";

    if(action == "ADD")
    {
      html += "<table width='100%' width='100%' cellPadding='0' cellSpacing='0'>"
          + "<tr><td class='Prompt'>Group: </td>"
            + "<td class='Prompt'><input class='Small' name='Grp' size=50 maxlength=50></td></tr>"
          + "<tr><td class='Prompt1' colspan=2>Column:</td></tr>"
          + crtTable()
          + "</table>"
    }
    if(action == "DLT")
    {
      html += "Press the 'Delete' button to remove selected group from the list"
    }

    html += "</tr></td>" + "<tr><td style='text-align:center;'>"
    if(action == "ADD")
    {
       html += "<button class='Small' onclick='Validate("
        + "&#34;ADD&#34;, &#34;" + grp + "&#34;)'>Submit</button>&nbsp;"
    }
    if(action == "DLT")
    {
       html += "<button class='Small' onclick='Validate("
       + "&#34;DLT&#34;, &#34;" + grp + "&#34;)'>Delete</button>&nbsp;"
    }

    html += "<button class='Small' onclick='hidePanel();'>Close</button></td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvPrompt.style.visibility = "visible";

   if (action == "UPD") popTable(action, grp, cols);
}

//--------------------------------------------------------
// create column table
//--------------------------------------------------------
function crtTable()
{
   var html = "";
   for(var i=0; i < 10; i++)
    {
       html += "<tr><td  class='Prompt2'>" + (i+1) + ".</td>"
            + "<td class='Prompt'><input class='Small' name='Col' size=50 maxlength=50></td></tr>"
    }
   return html;
}


//--------------------------------------------------------
// populate  column table
//--------------------------------------------------------
function popTable(action, grp, cols)
{
   document.all.Grp.value = grp;
   for(var i=0; i < 10; i++)
   {
     if( cols[i] != null) document.all.Col[i].value = cols[i];
   }
}
//--------------------------------------------------------
// Validate entry
//--------------------------------------------------------
function Validate(action, grp)
{
  var msg = ""
  var error = false;
  var cols = new Array(10);

  if(action=="ADD")
  {
     grp = document.all.Grp.value.trim()
     if (grp == "")
     {
       msg = "Group Name is not entered"
       error = true;
     }
  }

  if (error) alert(msg)
  else sbmGroup(action, grp, cols);
}
//--------------------------------------------------------
// Submit group
//--------------------------------------------------------
function sbmGroup(action, grp, cols)
{
  var url = "EvtGrpEnt.jsp?"
      + "Action=" + action
      + "&Grp=" + grp
  if(action != "DLT")
  {
    for(var i=0; i < 10; i++)
    if(cols[i] != null) url += "&Col=" + cols[i]
    else url += "&Col="
  }

  alert(url)
  window.location.href = url;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
}

</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Event Calendar - Work With Group List</b><br>
        <a href="../"><font color="red" size="-1">Home</font></a>;
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" >No.</th>
               <th class="DataTable" >Group Column Name<br>
                  <a href="javascript:entGroup('ADD', null, [null,null,null,null,null,null,null,null,null,null])">(Add new group)</a>
               </th>
               <th class="DataTable" colspan=10>Column Names</th>
               <th class="DataTable" >D<br>e<br>l<br>e<br>t<br>e</th>
             </tr>
           </thead>
           <tbody>
           <!--------------------- Media Detail ----------------------------->
             <%for(int i=0; i < iNumOfGrp; i++){%>
                 <tr class="DataTable2">
                   <td class="DataTable"><%=i+1%>.</td>
                   <td class="DataTable"><%=sGrp[i]%></td>

                 <%for(int j=0; j < 10; j++){%>
                    <td class="DataTable"><%if(j < iNumOfCol[i]) {%><%=sCol[i][j]%><%} else{%>&nbsp;&nbsp;&nbsp;&nbsp;<%}%></td>
                 <%}%>

                 <td class="DataTable">
                     <a href="javascript:entGroup('DLT', '<%=sGrp[i]%>'<%if(iNumOfCol[i] > 0){%>, [<%=grpLst.cvtToJavaScriptArray(sCol[i])%>]<%}%>)">D</a>
                 </td>
                 </tr>
             <%}%>
           </tbody>
         </table>
         <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>