<%@ page import="fileutility.PgmSrcUtility ,java.util.*, java.text.*"%>
<%
   String sFile = request.getParameter("File");
   String sLib = request.getParameter("Lib");
   String sMbr = request.getParameter("Mbr");


   PgmSrcUtility pgmsrc = new PgmSrcUtility(sLib, sFile, sMbr);
   String sError = pgmsrc.getError();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}
  a.Small:link { color:blue;  font-size:10px;} a.Small:visited { color:purple; font-size:10px;}  a.Small:hover { color:darkblue; font-size:10px;}

  table.DataTable {font-size:10px;}
  tr.DataTable { font-family:Courier; text-align:left;}
  td.DataTable { padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable1 { color:black; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable2 { color:green; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable3 { color:#fbb117; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable4 { color:darkred; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable5 { color:darkblue; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable6 { color:#7e3817; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable7 { color:#152dc6 ; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}
  td.DataTable8 { color:brown ; padding-top:3px; padding-bottom:1px; padding-right:1px; padding-left:3px;}

</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
}
</SCRIPT>

</head>

<body  onload="bodyLoad();">
  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Program File Utility
       <br>File: <%=sFile%> &nbsp; &nbsp; &nbsp;
           Library: <%=sLib%>  &nbsp; &nbsp; &nbsp;
           Program Name: <%=sMbr%>
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="PgmSrcUtilitySel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
        <font size="-1">This page</font>

    <%if(sError.equals("0")){%>
    <pre>
        <!----------------- start of table ------------------------>
         <table class="DataTable"  width="100%" cellPadding="0" cellSpacing="0">
       <!--------------------- Group List ----------------------------->
       <tbody>
       <%do {%>
         <%
              pgmsrc.rtvSrcCode();
              int iNumOfRec = pgmsrc.getNumOfRec();
              String [] sText = pgmsrc.getText();
              String [] sType = pgmsrc.getType();
              String [] sSeq = pgmsrc.getSeq();
              String [] sDate = pgmsrc.getDate();
          %>
          <%
          for(int i=0; i < iNumOfRec; i++)
          {
              String sClass = "1";

              if(sType[i].equals("CMT*")){ sClass = "2"; }
              else if(sType[i].equals("H-SPEC")){ sClass = "3"; }
              else if(sType[i].equals("P-SPEC")){ sClass = "4"; }
              else if(sType[i].equals("F-SPEC")){ sClass = "5"; }
              else if(sType[i].equals("D-SPEC")){ sClass = "6"; }
              else if(sType[i].equals("I-SPEC")){ sClass = "7"; }
              else if(sType[i].equals("O-SPEC")){ sClass = "8"; }
          %>
           <tr class="DataTable">
             <td class="DataTable"><%=sSeq[i]%></td>
             <td class="DataTable<%=sClass%>" nowrap><%=sText[i]%></td>
             <td class="DataTable"><%=sDate[i]%></td>
           </tr>
         <%}%>
        <%} while(pgmsrc.getNext());%>
         </tbody>
       </table>
       </pre>
       <!----------------- start of ad table ------------------------>
     <%} else {%><h1>Program source file is not found.</h1><%}%>
      </td>
     </tr>
    </table>
  </body>
</html>




<%
   pgmsrc.disconnect();
   pgmsrc = null;
%>