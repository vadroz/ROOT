<%@ page import="java.io.File, java.util.*"%>
<%
   String sFolder = "Weekly Merchandising Notes";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
      response.sendRedirect("SignOn1.jsp?TARGET=MerchNotesWeekly.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sStrAllowed = session.getAttribute("STORE").toString();

   // create document path
   String sDocPath = sFolder;
   String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/";

   File dir = new File(sPath + sDocPath);
   if (!dir.exists()) {  dir.mkdirs(); }
   File[] files = dir.listFiles();

   Arrays.sort( files, new Comparator()
   {
       public int compare(Object o1, Object o2)
       {
          if (((File)o1).lastModified() > ((File)o2).lastModified())
          {
             return -1;
          }
          else if (((File)o1).lastModified() < ((File)o2).lastModified())
          {
             return +1;
          }
          else
          {
             return 0;
          }
      }
   }
   );
%>


<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
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

//------------------------------------------------------------------------------
// Initialize
//------------------------------------------------------------------------------
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvLoad"]);
   this.focus()
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
                   <br>Store Hiring Matrix</b><br>

  <br><a href="../"><font color="red" size="-1">Home</font></a>

  <table class="DataTable" align="center" >
     <tr>
       <th class="DataTable" width="30%">Documents</th>
     </tr>
     <!-- ================================================================== -->
     <!-- File List -->
     <!-- ================================================================== -->

       <%for(int i=0; i<files.length;i++){
          String sName = files[i].getName();
       %>
             <tr>
                <td class="DataTable1" >
                   <a href="<%=sDocPath + "/" + sName%>"><%=sName%></a>
                </td>

       <%}%>
      </td>
     </tr>
  </table><br>
</BODY>
</HTML>
<%}%>

