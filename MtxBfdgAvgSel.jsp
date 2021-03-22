<%@ page import="java.util.*, java.sql.*"%>
<%

String sAppl = "PRHIST";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MtxBfdgAvgSel.jsp&APPL=" + sAppl);
}
else
{

  String [] sMon = new String[]{"April", "May", "June", "July", "August", "September", "October", "November"
     , "December", "January", "February", "March", "Annual Worksheet"};
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        .Small {font-size:10px }

        div.dvBdgAvg { position:absolute;  background-attachment: scroll;
              border: MidnightBlue solid 2px; width:150; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; visibility:hidden;}

        tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; }

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script language="javascript">
var aFrame = ["frmComp", "frmStr"
   , "frmMon0", "frmMon1", "frmMon2", "frmMon3", "frmMon4", "frmMon5", "frmMon6"
   , "frmMon7", "frmMon8", "frmMon9", "frmMon10", "frmMon11", "frmMon12"];
var aList = ["liComp", "liStr"
   , "liMon0", "liMon1", "liMon2", "liMon3", "liMon4", "liMon5", "liMon6"
   , "liMon7", "liMon8", "liMon9", "liMon10", "liMon11", "liMon12"];

var aColor = ["#FFE4C4", "#DEB887"
   , "#FF7F50", "#6495ED", "#008B8B", "#FF8C00", "#E9967A", "#8FBC8F", "#2F4F4F"
   , "#B22222", "#228B22", "#DAA520", "#ADFF2F", "#FFB6C1", "red"];

//==============================================================================
// iniitalize at loading
//==============================================================================
function bodyLoad()
{
   setActivFrame("frmComp", "liComp");
}

//==============================================================================
// set active group
//==============================================================================
function setActivFrame(frm, li)
{
   var h = "2000";

   for(var i=0; i < aFrame.length; i++)
   {
     if(frm != aFrame[i])
     {
        document.all[aFrame[i]].style.width = "0";
        document.all[aFrame[i]].style.height = "0";
        document.all[aList[i]].className=" ";
     }
     else
     {
        if(i==0){ h = "400";}
        document.all[frm].style.width = "100%";
        document.all[frm].style.height = h;
        document.all[li].className="current";
        document.all[frm].contentWindow.document.body.style.backgroundColor = aColor[i];
     }
   }
}

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<link href="Tabs/tabs.css" rel="stylesheet" type="text/css" />

<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvBdgAvg" class="dvBdgAvg"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
       <td ALIGN="center" VALIGN="TOP" width="10%">
         <b>Retail Concepts Inc.
         <br>Budget Average Wage Matrix
         </b>
         <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
         <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
       </td>
     </tr>

     <tr bgColor="ivory">
       <td ALIGN="center" VALIGN="TOP">
         <br>
         <ol id="toc">
              <li id="liComp" class="current"><a href="javascript: setActivFrame('frmComp', 'liComp')"><span>Company</span></a></li>
              <li id="liStr" ><a href="javascript: setActivFrame('frmStr', 'liStr')"><span>All Store/All Year</span></a></li>
              <%for(int i=0; i < 13; i++){%>
                 <li id="liMon<%=i%>" ><a href="javascript: setActivFrame('frmMon<%=i%>', 'liMon<%=i%>')"><span><%=sMon[i]%></span></a></li>
              <%}%>
       </ol>

       <iframe id="frmComp" src="MtxCompBfdgAvg.jsp?InFrame=Y"  frameborder=0 height="0" width="">xxxx</iframe>
       <iframe id="frmStr" src="MtxStrBfdgAvg.jsp?InFrame=Y"  frameborder=0 height="0" width=""></iframe>

       <%for(int i=0; i < 13; i++){%>
          <iframe id="frmMon<%=i%>" src="MtxStrMonBfdgAvg.jsp?InFrame=Y&Mon=<%=i+1%>"  frameborder=0 height="0" width="0"></iframe>
       <%}%>

       </td>
     </tr>
    <!----------------------- end of table ---------------------------------->

  </table>
  <div id="dvElapse" style="font-size:8px"></div>
 </body>

</html>

<%
  }
%>
