<%@ page import="java.io.File, java.util.*"%>
<%
   String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/";
   String sFolder = request.getParameter("Folder");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrAnnualDoc.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   File dir = new File(sPath + sFolder);
   if (!dir.exists()) {  dir.mkdirs(); }
   File[] docs = dir.listFiles();

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
  document.all.dvLoad.style.pixelLeft=document.documentElement.scrollLeft + 250
  document.all.dvLoad.style.pixelTop=document.documentElement.scrollTop + 100;
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
                   <br>Store Annual Employee Review Documents</b><br>

  <br><a href="../"><font color="red" size="-1">Home</font></a>

  <table class="DataTable" align="center" >
     <tr>
       <th class="DataTable" colspan=2>Document</th>
     </tr>
     <!-- ================================================================== -->
     <!-- File List -->
     <!-- ================================================================== -->
       <%for(int i=0; i<docs.length;i++){%>
          <tr>
             <td class="DataTable" >
                 <%if(docs[i].isDirectory()){%>
                   <a href="StrAnnualDoc.jsp?Folder=<%=sFolder + "/" + docs[i].getName()%>"><%=docs[i].getName()%></a>
                 <%}
                   else {%>
                     <a href="<%=sFolder + "/" + docs[i].getName()%>"><%=docs[i].getName()%></a>
                 <%}%>
             </td>
             <td class="DataTable" >
                <a href="javascript: dltFile('<%=sPath + sFolder + "/" + docs[i].getName()%>')">D</a>
             </td>
           </tr>
       <%}%>
      </td>
     </tr>
  </table><br>
     <button onClick="loadDoc()">Load Document</button>

</BODY>
</HTML>
<%}%>