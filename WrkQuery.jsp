<%@ page import="java.util.*"%>
<%
   String sKey = request.getParameter("Key");
   String sTitle = request.getParameter("Title");
   String sTitle1 = request.getParameter("Title1");
   String sTitle2 = request.getParameter("Title2");
   String sCount = request.getParameter("Count");
   String sStmt = request.getParameter("Stmt");
   String [] sColHdg = request.getParameterValues("ColHdg");
   String sAction = request.getParameter("Action");

   if (sKey == null) { sKey = "0"; }
   if (sTitle == null) { sTitle = ""; }
   if (sTitle1 == null) { sTitle1 = ""; }
   if (sTitle2 == null) { sTitle2 = ""; }
   if (sAction == null) { sAction = "ADD"; }

%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;
                       padding-left:3px; padding-right:3px;padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.FileDsc  { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px;
                      padding-right:3px; border-bottom: darkred solid 1px; text-align:left;
                      font-family:Verdanda; font-size:12px;}
        td.FileDsc1 { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px;
                      padding-right:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                      text-align:center; font-family:Verdanda; font-size:12px; font-weight:bold}


        tr.Row { background:lightgrey; font-family:Arial; font-size:10px }
        tr.Row1 { background:Cornsilk; font-family:Arial; font-size:10px }

        td.Cell { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
        td.Cell1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:right;}

        td.Cell2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:Center;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Div1 { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        tr.Grid { background:darkblue; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        tr.Grid1 { background:LightBlue; text-align:center; font-family:Arial; font-size:11px;}
        tr.Grid2 { background:LightBlue; text-align:center; font-family:Arial; font-size:10px;}
        tr.Grid3 { background:LightBlue; text-align:left; font-family:Arial; font-size:10px;}

        td.Grid  { color:white; text-align:center; padding-left:3px; padding-right:3px;}
        td.Grid1  { color:white; text-align:right;}
        td.Grid2  { padding-left:3px; padding-right:3px;}
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Key = "<%=sKey%>";
var Title = "<%=sTitle%>";
var Title1 = "<%=sTitle1%>";
var Title2 = "<%=sTitle2%>";
var Stmt = "<%=sStmt%>";
var Count = "<%=sCount%>";
var ColHdg = new Array();
<%
   if(sColHdg != null)
   {
       for(int i=0; i < sColHdg.length; i++){%>ColHdg[<%=i%>]="<%=sColHdg[i]%>";<%}
   }%>

var Action = "<%=sAction%>";
var WinNum = 0;
//--------------- End of Global variables ----------------
function bodyLoad()
{
   if(Action != "ADD")
   {
      document.all.Statement.value = Stmt;
      document.all.Title.value = Title;
      document.all.Title1.value = Title1;
      document.all.Title2.value = Title2;
      if(Count=="Y") document.all.Count.checked = true;
      for(var i=0; i < ColHdg.length; i++)
      {
         document.all.Col[i].value = ColHdg[i]
      }
   }
}
//---------------------------------------------------------------------
// submit query
//---------------------------------------------------------------------
function submitQuery()
{
  var url = "FileQuery.jsp?"
          + "Stmt=" + document.all.Statement.value.trim()
          + "&Test=Y"
          + "&Title=" + document.all.Title.value.trim()
          + "&Title1=" + document.all.Title1.value.trim()
          + "&Title2=" + document.all.Title2.value.trim()
          + "&Count=" + document.all.Count.value.trim()
  for(var i=0; i < 50; i++)
  {
     var col = document.all.Col[i].value.trim()
     if(col != "" && col != " "){ url += "&ColHdg=" + col}
  }

  var WindowName = 'Query';
  var WindowOptions = 'resizable=yes , toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,menubar=yes';

  //alert(url);
  window.open(url, WindowName, WindowOptions);
}

//---------------------------------------------------------------------
// save query
//---------------------------------------------------------------------
function saveQuery()
{
  var url = "FileQuerySave.jsp?"
          + "Key=" + Key.trim()
          + "&Stmt=" + document.all.Statement.value.trim()
          + "&Title=" + document.all.Title.value.trim()
          + "&Title1=" + document.all.Title1.value.trim()
          + "&Title2=" + document.all.Title2.value.trim()
          + "&Count=" + document.all.Count.value.trim()
  for(var i=0; i < 50; i++)
  {
     var col = document.all.Col[i].value.trim();
     if(col != "" && col != " "){ url += "&ColHdg=" + col}
  }
  url += "&Action=" + Action

  //alert(url);
  //window.location.href = url;
  window.frame1.location.href = url;
}
//---------------------------------------------------------------------
// display Error
//---------------------------------------------------------------------
function displayError(err)
{
   var msg = new Array();
   for(var i=0;  i < err.length; i++) { msg[i] + err[i] }
   alert(err)
}
//---------------------------------------------------------------------
// display Error
//---------------------------------------------------------------------
function restart(key, action)
{
   var url = "WrkQuery.jsp?"
   if (action != "DLT")
   {
     url += "Key=" + key
          + "&Stmt=" + document.all.Statement.value.trim()
          + "&Title=" + document.all.Title.value.trim()
          + "&Title1=" + document.all.Title1.value.trim()
          + "&Title2=" + document.all.Title2.value.trim()
          + "&Count=" + document.all.Count.value.trim()
     for(var i=0; i < 50; i++)
     {
       var col = document.all.Col[i].value.trim();
       if(col != "" && col != " "){ url += "&ColHdg=" + col}
     }
     url += "&Action=UPD"
  }
  else  { url += "&Action=ADD" }

  window.location.href=url;
}
//---------------------------------------------------------------------
// display Error
//---------------------------------------------------------------------
function getFileFields()
{
  var url = "FileUtility.jsp";
  WinNum = WinNum + 1;
  var WindowName = 'Query' + WinNum;
  var WindowOptions = 'resizable=yes , toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,menubar=yes';

  //alert(url);
  window.open(url, WindowName, WindowOptions);
}
//---------------------------------------------------------------------
// display Error
//---------------------------------------------------------------------
function popFldLst(fld)
{
   stmt = document.all.Statement.value.trim()
   document.all.Statement.value = stmt + fld;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="200" width="100%"></iframe>
<!-------------------------------------------------------------------------------->
<div id="Clause" class="Div1"></div>
<!-------------------------------------------------------------------------------->
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
<!-------------------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="Center" colspan=2 nowrap>
           <b><u>Display File Fields</u></b><br><br>
      </td>
    </tr>
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
       <td ALIGN="center" colspan=2 VALIGN="TOP">

          <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <font size="-1">This Page.</font>
       </td>
     </tr>
<!-------------------------------------------------------------------->
<!-- Title -->
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>Title:</b></td>
       <td ALIGN="left" VALIGN="TOP"><input class="Small" name="Title" size=50 maxlength=50></td>
     </tr>
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>Title1:</b></td>
       <td ALIGN="left" VALIGN="TOP"><input class="Small" name="Title1" size=50 maxlength=50></td>
     </tr>
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>Title2:</b></td>
       <td ALIGN="left" VALIGN="TOP"><input class="Small" name="Title2" size=50 maxlength=50></td>
     </tr>
<!-------------------------------------------------------------------->
<!-- Select -->
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>Statement:</b><br>
         <a href="javascript: getFileFields()">File Description</a>
       </td>
       <td ALIGN="left" VALIGN="TOP"><textArea class="Small" name="Statement" cols="100" rows="10"></textArea></td>
     </tr>
<!-------------------------------------------------------------------->
<!-- Record Count -->
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>Show Column Count:</b></td>
       <td ALIGN="left" VALIGN="TOP"><input type="checkbox" value="Y" name="Count"></td>
     </tr>
<!-------------------------------------------------------------------->
<!-- Select -->
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>Columns:</b></td>
       <td ALIGN="left" VALIGN="TOP">
         <div style="overflow: auto; height: 250; border: 5px solid #c3fdb8;background:cornsilk; " >
            <%for(int i=0, j=1; i < 50; i++, j++){%>
               <input type="text" class="Small" name="Col" size="30" maxlength=30>
               <%if(j==4){%><br><%j=0;}%>
            <%}%>
         </div>
       </td>
     </tr>

<!-------------------------------------------------------------------->
<!-- Select -->
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan=2>
         <button onClick="submitQuery()">Run</button>&nbsp;&nbsp;&nbsp;&nbsp;
         <button onClick="saveQuery()">Save</button>
       </td>
     </tr>

<!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
