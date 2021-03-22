<%@ page import="server_utility.Su_Modify_File_List, java.util.*, java.text.*, java.io.*"%>
<%
    String sFrom = request.getParameter("from");
    if(sFrom==null)
    {
       Date dtFrom = new Date((new Date()).getTime() - 24*60*60*1000 );
       SimpleDateFormat smpdf = new SimpleDateFormat("MM/dd/yyyy");
       sFrom = smpdf.format(dtFrom);
    }
    
    ServletContext sc = session.getServletContext();
    String x = sc.getRealPath("/");
    System.out.println(x);
    
    
    Su_Modify_File_List modfile = new Su_Modify_File_List(sFrom);
    modfile.setByMod(false);
    
    String [] sProj = modfile.getProj();    
    File [] fClasses = modfile.getCls();
    
    System.out.println(fClasses == null);
    %>
<HTML>
<HEAD>
<title>Modified Classes</title>
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
        <BR>Modified Classes 
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
             <th class="DataTable">Workspace (\\rcifile\sass\build) &nbsp; 
                <button class="Small" onclick="rtvLogs(false);">Refresh</button>
             </th>
         </tr>
       <!-- ============================ Details =========================== -->
         <tr class="DataTable">             
             <th class="DataTable">Projects</th>
             
         <%if(sProj!=null){
              for(String spj : sProj){%>
                 <tr class="DataTable">             
                    <td class="DataTable"><%=spj%></td>
                 </tr> 
              <%}%>
         <%}%> 
       </table>
  </TD>
 </TR>

 </TBODY>
</TABLE>
</BODY></HTML>
