<%@ page import="fileutility.FileQueryLst, java.util.*, java.text.*"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=FileQueryLst.jsp&APPL=ALL");
   }
   else
   {
      // enter detail
      FileQueryLst qrylst = new FileQueryLst("vrozen");
      int iNumOfQry = qrylst.getNumOfQry();
      String [] sKey = qrylst.getKey();
      String [] sTitle = qrylst.getTitle();
      String [] sTitle1 = qrylst.getTitle1();
      String [] sTitle2 = qrylst.getTitle2();
      String [] sStmt = qrylst.getStmt();

      qrylst.disconnect();
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        <!-------- select another div/dpt/class pad ------->
        .Small {font-family:Arial; font-size:10px }
        input {border:none; border-bottom: black solid 1px; font-family:Arial; font-size:12px; font-weight:bold}
        input.radio {border:none; font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }

        <!-------- transfer entry pad ------->
        div.Fake { };
        div.dvOrder  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { text-align:left; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right;
                    font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid3 { text-align:center; font-family:Arial; font-size:10px;}

        td.Menu { text-align:center; font-family:Arial; font-size:10px;}
        <!-------- end transfer entry pad ------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body >

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>File Query List</b><br></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;This Page.
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a target="_blank" href="WrkQuery.jsp"><font color="red" size="-1">New Query</font></a>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable" nowrap>Key</th>
        <th class="DataTable" nowrap>Title</th>
        <th class="DataTable" nowrap>Title1</th>
        <th class="DataTable" nowrap>Title2</th>
        <th class="DataTable" nowrap>Statment</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
      <%for(int i=0; i < iNumOfQry; i++) {%>
          <tr  class="DataTable">
            <td class="DataTable2"><a href="FileQuery.jsp?Query=<%=sKey[i]%>"><%=sKey[i]%></a></td>
            <td class="DataTable2"><%=sTitle[i]%></td>
            <td class="DataTable2"><%=sTitle1[i]%></td>
            <td class="DataTable2"><%=sTitle2[i]%></td>
            <td class="DataTable2"><%=sStmt[i]%></td>
          </tr>
      <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>
<%}%>