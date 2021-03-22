<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EvMediaNm.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

      String sUser = session.getAttribute("USER").toString();

      String sName = "";
      String sStr = "";
      String sSepr = "";
      boolean bExist = false;

      String sStmt = "select MNMEDID,MNMTYP,MNMEDIA,MNCOMMT,MNRECUS,MNRECDT,MNRECTM"
        + ", (select AMDES from rci.AdMedia where AmTyp=MNMTYP) as MeDesc"
        + " from rci.AdMedNam"
        + " order by MNMTYP, MNMEDIA"
        ;

      RunSQLStmt sql_MedName = new RunSQLStmt();
      sql_MedName.setPrepStmt(sStmt);
      ResultSet rs_MedName = sql_MedName.runQuery();

      String sStmt1 = "select AMTYP, AMDES"
        + " from  rci.AdMedia"
        + " order by amsrt"
        ;

      RunSQLStmt sql_MedGrp = new RunSQLStmt();
      sql_MedGrp.setPrepStmt(sStmt1);
      ResultSet rs_MedGrp = sql_MedGrp.runQuery();

      String sMedType = "";
      String sMedTypeNm = "";
      String coma = "";
      while(sql_MedGrp.readNextRecord())
      {
         sMedType += coma + "'" + sql_MedGrp.getData("AMTYP").trim() + "'";
         sMedTypeNm += coma + "'" + sql_MedGrp.getData("AMDES").trim() + "'";
         coma = ",";
      }
%>
<html>
<head>
<title>Media List</title>

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

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var MedType =  [<%=sMedType%>];
var MedTypeNm =  [<%=sMedTypeNm%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}

//==============================================================================
// add/change media
//==============================================================================
function setMedia(id, type, name, comment, action)
{
   //check if order is paid off
   var hdr = null;
   if(action =="ADDMEDIA"){hdr = "Add New Media";}
   else if(action =="DLTMEDIA"){hdr = "Delete Media";}

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popMediaPanel(id, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(action != "DLTMEDIA"){ setTypeSel(); }
   if(action != "ADDMEDIA")
   {
      for(var i=0; i < MedType.length;i++)
      {
          if(MedType[i] == type){ document.all.TypeNm.value = MedTypeNm[i]; break; }
      }
      document.all.Type.value = type;
      document.all.Media.value = name;
      document.all.Comment.value = comment;
   }
}
//==============================================================================
// populate type selection drop down media
//==============================================================================
function setTypeSel()
{
   document.all.selType.options[0] = new Option("---- select media ----", "");
   for(var i=0, j=1; i < MedType.length;i++, j++)
   {
     document.all.selType.options[j] = new Option(toTitleCase(MedTypeNm[i]), MedType[i] );
   }
}
//==============================================================================
// capitalize first leter of each word
//==============================================================================
function toTitleCase(str)
{
    str = str.toLowerCase();
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}
//==============================================================================
// populate Media Entry Panel
//==============================================================================
function popMediaPanel(id, action)
{
  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt'>Type:</td>"
           + "<td class='Prompt'>"
              + "<input name='TypeNm' class='Small' size=50 readonly>&nbsp;"
              + "<input name='Type' type='hidden'>&nbsp;"

  if(action != "DLTMEDIA")
  {
     panel += "<select name='selType' class='Small' onchange='setMediaType(this)'></select>"
  }

  panel += "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' nowrap>Media Name:</td>"
           + "<td class='Prompt'>"

  if(action != "DLTMEDIA") { panel += "<input name='Media' class='Small' size=50 maxlength=50>&nbsp;" }
  else { panel += "<input name='Media' class='Small' size=50 maxlength=50 readonly>&nbsp;" }

  panel += "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' nowrap>Comment:</td>"
           + "<td class='Prompt'>"
  if(action != "DLTMEDIA") { panel += "<input name='Comment' class='Small' size=50 maxlength=100>&nbsp;"}
  else { panel += "<input name='Comment' class='Small' size=50 maxlength=100 readonly>&nbsp;"}

  panel += "</td>"
         + "</tr>"
         + "<tr><td id='tdError' colspan='2'></td></tr>"

      panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
      + "<button onClick='vldMedia(&#34;" + id + "&#34;,&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// set media tyep
//==============================================================================
function setMediaType(sel)
{
    var type = sel.options[sel.selectedIndex].value.trim();
    var typenm = sel.options[sel.selectedIndex].text.trim();
    if (type != "NONE")
    {
      document.all.Type.value = type;
      document.all.TypeNm.value = typenm;
    }
    else
    {
      document.all.Type.value = "";
      document.all.TypeNm.value = "";
    }
}
//==============================================================================
// validate media name
//==============================================================================
function vldMedia(id, action)
{
   var error = false;
   var msg = "";
   var br = "";
   document.all.tdError.innerHTML = "";
   document.all.tdError.style.color = "red";

   var type = document.all.Type.value.trim();
   if(type == ""){error = true; msg += br + "Please select Type"; br = "</br>";}

   var media = document.all.Media.value.trim();
   if(media == ""){error = true; msg += br + "Please enter Media name"; br = "</br>";}

   var comment = document.all.Comment.value.trim();

   if(error){ document.all.tdError.innerHTML = msg.trim(); }
   else{ sbmMedia(id, type, media, comment, action); }
}
//==============================================================================
// validate media name
//==============================================================================
function sbmMedia(id, type, media, comment, action)
{
    comment = comment.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddMedia'"
       + " METHOD=Post ACTION='EvMediaSv.jsp'>"
       + "<input class='Small' name='Id'>"
       + "<input class='Small' name='Type'>"
       + "<input class='Small' name='Media'>"
       + "<input class='Small' name='Comment'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Id.value = id;
   window.frame1.document.all.Type.value = type;
   window.frame1.document.all.Media.value=media;
   window.frame1.document.all.Comment.value=comment;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddMedia.submit();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Media List
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;This Page
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      <a href="javascript: setMedia('0',null,null,null, 'ADDMEDIA')">Add Media</a>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <th class="DataTable">No.</th>
         <th class="DataTable">Type</th>
         <th class="DataTable">Media</th>
         <th class="DataTable">Comment</th>
         <th class="DataTable">Delete</th>
       </tr>
      <TBODY>

  <!-------------------------- Order List ------------------------------->
  <%int iLine=0;%>
  <%while(sql_MedName.readNextRecord()) {%>
    <%
         String sMeId = sql_MedName.getData("MNMEDID").trim();
         String sMeTyp = sql_MedName.getData("MNMTYP").trim();
         String sMeMedia = sql_MedName.getData("MNMEDIA").trim();
         String sMeCommt = sql_MedName.getData("MNCOMMT").trim();
         String sMeDesc = sql_MedName.getData("MeDesc").trim();
    %>
        <tr  class="DataTable">
            <td class="DataTable2"><%=++iLine%></td>
            <td class="DataTable"><%=sMeDesc%></td>
            <td class="DataTable"><a href="javascript: setMedia('<%=sMeId%>','<%=sMeTyp%>','<%=sMeMedia%>','<%=sMeCommt%>', 'UPDMEDIA');"><%=sMeMedia%></a></td>
            <td class="DataTable"><%=sMeCommt%></td>
            <td class="DataTable2"><a href="javascript: setMedia('<%=sMeId%>','<%=sMeTyp%>','<%=sMeMedia%>','<%=sMeCommt%>', 'DLTMEDIA');">Dlt</a></td>
        </tr>
  <%}%>
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>



<%
sql_MedName.disconnect();
sql_MedGrp.disconnect();
}%>

