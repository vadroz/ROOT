<%@ page import="fileutility.FileQuery, fileutility.GetSQLStmt, java.util.*"%>
<%
   String sQuery = null;
   String sUser = request.getParameter("Query");
   String sTitle = null;
   String sTitle1 = null;
   String sTitle2 = null;
   String sCount = null;
   String sStmt = null;
   String [] sColHdg = null;
   String sColHdgJsa = null;
   int iNumOfErr = 0;
   String sError = null;


if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=FileQuery.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   if(request.getParameter("Test") != null)
   {
      sTitle = request.getParameter("Title");
      sTitle1 = request.getParameter("Title1");
      sTitle2 = request.getParameter("Title2");
      sCount = request.getParameter("Count");
      sStmt = request.getParameter("Stmt");
      sColHdg = request.getParameterValues("ColHdg");

      if(sTitle==null) sTitle = "";
      if(sTitle1==null) sTitle1 = "";
      if(sTitle2==null) sTitle2 = "";
      if(sCount==null) sCount = "N";
   }
   else
   {
      sQuery = request.getParameter("Query");

      GetSQLStmt getstmt = new GetSQLStmt(sQuery, session.getAttribute("USER").toString());

      iNumOfErr = getstmt.getNumOfErr();
      sError = getstmt.getError();

      sTitle = getstmt.getTitle();
      sTitle1 = getstmt.getTitle1();
      sTitle2 = getstmt.getTitle2();
      sCount = getstmt.getCount();
      sStmt = getstmt.getStmt();
      sColHdg = getstmt.getColHdg();
      sColHdgJsa = getstmt.getColHdgJsa();

      getstmt.disconnect();
   }

   FileQuery filqry = new FileQuery(sStmt);

   Vector vRecord = filqry.getRecord();
   String [] sValue = null;
   Iterator it = vRecord.iterator();
   sError = filqry.getError();
   filqry.disconnect();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;
                       padding-left:3px; padding-right:3px;padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.Row { background:lightgrey; font-family:Arial; font-size:10px }
        td.Cell { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
        td.Cell2 { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
<%if(request.getParameter("Test") == null) {%>
  var ColHdg = [<%=sColHdgJsa%>]
<%}%>
//--------------- End of Global variables ----------------
function bodyLoad()
{
   <%if(sError != null){%> alert("<%=sError%>") <%}%>
   window.focus();
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------------------->
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
<!-------------------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="Center" VALIGN="TOP" colspan="2" nowrap>
           <b><u><%=sTitle%><br>
           <%if(!sTitle1.trim().equals("")) {%><%=sTitle1%><br><%}%>
           <%if(!sTitle2.trim().equals("")) {%><%=sTitle2%><br><%}%>
           </u></b><br>
      </td>
    </tr>

<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan="2">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="FileUtilitySel.jsp"><font color="red" size="-1">File Selection</font></a>&#62;
          <font size="-1">This Page.</font>

<!-------------------------------------------------------------------->
<!----------------- File Description table ------------------------>
<!-------------------------------------------------------------------->
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
           <%if(sCount.equals("Y")) {%>
              <th class="DataTable">#</th>
              <th class="DataTable">&nbsp;</th>
           <%}%>
           <% for(int i=0; i < sColHdg.length; i++) {%>
              <th class="DataTable"><%=sColHdg[i]%></th>
           <%}%>
        </tr>

        <%
        int rn = 0;
        while(it.hasNext()) {
          rn++;
          if(rn > 2000) break;
        %>

          <tr class="Row">
            <%if(sCount.equals("Y")) {%>
               <td class="Cell2"><%=rn%></td>
               <th class="DataTable">&nbsp;</th>
            <%}%>

        <% sValue = (String[])it.next();
           for(int i=0; i < sValue.length; i++) {%>
              <td class="Cell"><%=sValue[i]%></td>
          <%}%>
          </tr>
        <%}%>


      </table>
<!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%}%>