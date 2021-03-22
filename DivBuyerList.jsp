<%@ page import="java.util.*, java.text.*, java.sql.*, rciutility.RunSQLStmt"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POWorksheetList.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    String sStmt = "select BDDIV,dnam, BDBUYER, Unam from rci.buyerdiv "
      + " left join Iptsfil.IpUsers on UUID = BDBUYER left join Iptsfil.Ipdivsn on bddiv=ddiv"
      + " order by bddiv";

      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sStmt);
      ResultSet rs = runsql.runQuery();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin:none; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}


        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }


</style>


<script name="javascript1.2">
//------------------------------------------------------------------------------

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<HTML><HEAD>

<META content="RCI, Inc." name=POList></HEAD>
<BODY>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Division - Buyers List
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable">Division</th>
           <th class="DataTable">Buyer Id</th>
           <th class="DataTable">Buyer Name</th>
         </tr>

       <!-- ============================ Details =========================== -->
          <%while(runsql.readNextRecord())
          {
             String sDiv = runsql.getData("bddiv");
             String sDivNm = runsql.getData("dnam");
             if(sDivNm == null){ sDivNm = "<span style='color=red'>Division is not found</span>"; }

             String sBuyer = runsql.getData("bdbuyer");
             String sBuyerNm = runsql.getData("unam");
          %>

            <tr id="trGroup" class="DataTable">
              <td class="DataTable1" nowrap><%=sDiv%> - <%=sDivNm%></td>
              <td class="DataTable" nowrap><%=sBuyer%></td>
              <td class="DataTable1" nowrap><%=sBuyerNm%></td>
            </tr>
          <%}%>
       </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>