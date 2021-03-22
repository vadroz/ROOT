<%@ page import="java.io.File, java.util.*"%>
<%
   String sPath = request.getParameter("Path");
   String sFolder = request.getParameter("Folder");
   String [] sKey = request.getParameterValues("Key");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MemoDoc.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sAppl=null;
   if(session.getAttribute("MEMOADD") != null) sAppl = "MEMOADD";

   // create document path
   String sDocPath = sFolder;
   for(int i=0; i < sKey.length; i++)
   {
     sDocPath += "/" + sKey[i];
   }

   File dir = new File(sPath + sDocPath);
   if (!dir.exists()) {  dir.mkdirs(); }
   File[] signs = dir.listFiles();

%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }

        div.Cal { position:absolute; visibility:hidden; background-attachment: scroll;
                    border: black solid 2px; width:300; background-color:cornsilk; z-index:10;
                    text-align:left; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Dtl   {text-align:left; font-family:Arial; font-size:12px; }
        td.Dtl1  {background-color: blue; color:white; border-bottom: black solid 1px; text-align:center; font-family:Arial; font-size:11px; font-weight:bold}
        td.Dtl2  {background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Dtl3   {text-align:center; font-family:Arial; font-size:12px; }
        .Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:2px; font-family:Arial; font-size:10px }
</style>
<script language="JavaScript1.2">

var Path = "<%=sPath%>";
var Folder = "<%=sFolder%>";
var Keys = new Array();
<%for(int i=0; i < sKey.length; i++){%> Keys[<%=i%>]="<%=sKey[i]%>"; <%}%>

//------------------------------------------------------------------------------
// Initialize
//------------------------------------------------------------------------------
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvLoad"]);
   this.focus()
}
//------------------------------------------------------------------------------
// Load New Document
//------------------------------------------------------------------------------
function loadDoc()
{
   var html = ""
     + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
       + "<td class='BoxName' nowrap>Select Another Report</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td class='Dtl3'>"
           + "<form name='Upload'  method='post'  enctype='multipart/form-data' action='MemoDocUpload.jsp'>"
               + "<input type='File' name='Doc' class='Small' size=50><br>"
               + "<input type='hidden' name='Path' value='" + Path + "'>"
               + "<input type='hidden' name='Folder' value='" + Folder + "'>"
               + "<input type='hidden' name='FileName'>"
               + popKeys()
           + "</form>"
           + "<button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button>"
           + "</td></tr>"
     + "</table>"

  //alert(html)
  document.all.dvLoad.innerHTML=html;
  document.all.dvLoad.style.pixelLeft=250
  document.all.dvLoad.style.pixelTop=100;
  document.all.dvLoad.style.visibility="visible"

}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvLoad.innerHTML = " ";
   document.all.dvLoad.style.visibility = "hidden";
}

//------------------------------------------------------------------------------
// submit Upload
//------------------------------------------------------------------------------
function popKeys()
{
   var html = "";
   for(var i=0; i < Keys.length; i++)
   {
      html += "<input type='hidden' name='Key' value='" + Keys[i] + "'>"
   }
   return html
}
//------------------------------------------------------------------------------
// submit Upload
//------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------
// Delete selected file
//------------------------------------------------------------------------------
function dltFile(fileLoc)
{

  var url = "DltFile.jsp?File=" + fileLoc.replaceSpecChar();
  //alert(url);
  //window.location = url;
  window.frame1.location = url;
}
//------------------------------------------------------------------------------
// restart this page after file would be deleted
//------------------------------------------------------------------------------
function restart()
{
   window.frame1.close();
   window.location.reload();
}
</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<!-------------------------------------------------------------------->


<BODY onLoad="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-- ----------------------------------------------------------------------- -->
<div id="dvLoad" class="Cal"></div>
<!-- ----------------------------------------------------------------------- -->
<p align="center"> <b>RETAIL CONCEPTS, INC.
                   <br>Document List</b><br>
                   <br><font size="-1">You are now in:
                   <%for(int i=0; i < sKey.length; i++){%>><%=sKey[i]%><%}%> section
                   </font>

  <br><a href="../"><font color="red" size="-1">Home</font></a>

  <table class="DataTable" align="center" >
     <tr>
       <th class="DataTable" colspan=2>Document or folder</th>
     </tr>
     <!-- ================================================================== -->
     <!-- File List -->
     <!-- ================================================================== -->
       <%for(int i=0; i<signs.length;i++){%>
          <tr>
            <!-- show link if directory -->
            <%if(signs[i].isDirectory()) {%>
               <td class="DataTable" colspan=2>
                 <a href="ServerSignList.jsp?Path=<%=sPath + "/" + signs[i].getName()%>"><%=signs[i].getName()%></a>
               </td>
            <%}
              else {%>
                 <td class="DataTable" >
                     <a href="<%=sDocPath + "/" + signs[i].getName()%>"><%=signs[i].getName()%></a>
                 </td>
                 <td class="DataTable" >
                  <a href="javascript: dltFile('<%=sPath + sDocPath + "/" + signs[i].getName()%>')">D</a>
               </td>
            <%}%>
       <%}%>
      </td>
     </tr>
  </table><br>
  <%if(sAppl != null) {%>
     <button onClick="loadDoc()">Load Document</button>
  <%}%>
</BODY>
</HTML>
<%}%>