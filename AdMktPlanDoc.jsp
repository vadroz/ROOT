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

      String sStmt = "select PDDOCID,PDMKT,dnam,PDDOC,PDCOMMT,PDRECUS"
        + ",char(PDRECDT,usa) as PdRecDt, char(PDRECTM,usa) as PdRecTm"
        + " from rci.AdPlnDoc inner join IpTsFil.IpDists on ddst=pdmkt"
        + " where exists(select 1 from rci.pruser where puuser='" + sUser + "'"
          + " and (pustr=0 or exists(select 1 from IpTsFil.IpStore"
               + " where sstr=pustr and sdis=pdmkt)))"
        + " order by dnam, PDDOCID"
        ;

      //System.out.println(sStmt);
      RunSQLStmt sql_Plan = new RunSQLStmt();
      sql_Plan.setPrepStmt(sStmt);
      ResultSet rs_Plan = sql_Plan.runQuery();

      // select district list
      sStmt = "select ddst, dnam"
        + " from  IpTsFil.IpDists"
        + " order by ddst"
        ;

      RunSQLStmt sql_Market = new RunSQLStmt();
      sql_Market.setPrepStmt(sStmt);
      ResultSet rs_Market = sql_Market.runQuery();

      String sDist = "";
      String sDistNm = "";
      String coma = "";
      while(sql_Market.readNextRecord())
      {
         sDist += coma + "'" + sql_Market.getData("ddst").trim() + "'";
         sDistNm += coma + "'" + sql_Market.getData("dnam").trim() + "'";
         coma = ",";
      }
      sql_Market.disconnect();

      // check allowed district
      sStmt = "select pustr, ddst"
        + " from  rci.pruser"
        + " left join IpTsFil.IpStore on sstr=pustr"
        + " left join IpTsFil.IpDists on sdis=ddst"
        + " where puuser='" + sUser + "'"
        ;
      RunSQLStmt sql_AllDist = new RunSQLStmt();
      sql_AllDist.setPrepStmt(sStmt);
      ResultSet rs_AllDist = sql_AllDist.runQuery();
      String sUsrStr = null;
      String sUsrDist = null;
      if(sql_AllDist.readNextRecord())
      {
         sUsrStr = sql_AllDist.getData("pustr").trim();
         if(sUsrStr.equals("0")){ sUsrDist = "ALL"; }
         else { sUsrDist = sql_AllDist.getData("ddst").trim();}
      }
      sql_AllDist.disconnect();
%>
<html>
<head>
<title>Ad Planning Doc</title>

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
        input.Small {font-family:Arial; font-size:11px }
        select.Small {font-family:Arial; font-size:11px }

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
var Dist = [<%=sDist%>];
var DistNm = [<%=sDistNm%>];
var AllowDist = "<%=sUsrDist%>";
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
function chgPlan(id, mkt, mktnm, commt, docnm, action)
{
   //check if order is paid off
   var hdr = null;
   if(action =="ADD"){hdr = "Add New Planning Document";}
   else if(action =="DLT"){hdr = "Delete Planning Document";}

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPlanDocPanel(id, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(action == "ADD" ){ setDistSel(); }
   if(action == "DLT" )
   {
       document.all.Market.value=mkt;
       document.all.MarketNm.value=mktnm;
       document.all.Comment.value=commt;
       document.all.Doc.value=docnm;

       document.all.Market.readOnly=true;
       document.all.MarketNm.readOnly=true;
       document.all.Comment.readOnly=true;
       document.all.Doc.readOnly=true;
       document.all.selMarket.style.display="none";
   }
   document.all.PlanDocId.value = id;
}
//==============================================================================
// populate Plan document Entry Panel
//==============================================================================
function popPlanDocPanel(id, action)
{
  var panel = "<form name='Upload'  method='post'  enctype='multipart/form-data' action='AdPlanDocSv.jsp'>"
      + "<table width='100%' cellPadding='0' cellSpacing='0'>"
         + "<tr><td class='Prompt'>Market: &nbsp;</td>"
           + "<td class='Prompt'>"
              + "<input name='MarketNm' class='Small' size=50 readonly>&nbsp;"
              + "<input name='Market' type='hidden'>&nbsp;"

  panel += "<select name='selMarket' class='Small' onchange='setMarket(this)'></select>"

  panel += "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' nowrap>Comment: &nbsp;</td>"
           + "<td class='Prompt'>"
  panel += "<input name='Comment' class='Small' size=50 maxlength=100>&nbsp;"

  panel += "<tr><td class='Prompt'>&nbsp;Document: &nbsp;</td>"
        + "<td class='Prompt' colspan=2>"
        + "<input name='PlanDocId' type='hidden'>"
        + "<input name='Action' type='hidden'>"
        + "<input name='User' type='hidden' value='<%=sUser%>'>"

  if(action=='ADD') panel += "<input type='File' name='Doc' class='Small' class='Small' size=50 maxlength=256>"
  else panel += "<input name='Doc' class='Small' class='Small' size=50 maxlength=256 readonly>"
  panel += "</tr>"

  panel += "</td>"
         + "</tr>"
         + "<tr><td id='tdError' colspan='2'></td></tr>"

  panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
      + "<button onClick='vldPlanDoc(&#34;" + id + "&#34;,&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table></form>";
  return panel;
}
//==============================================================================
// set district selection
//==============================================================================
function setDistSel()
{
   document.all.selMarket.options[0] = new Option("---- select market ----", "");
   for(var i=0, j=1; i < Dist.length;i++)
   {
      if(AllowDist == "ALL" || Dist[i] == AllowDist)
      {
        document.all.selMarket.options[j] = new Option(toTitleCase(DistNm[i]), Dist[i] );
        j++;
      }
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
// set selected market
//==============================================================================
function setMarket(sel)
{
    var dist = sel.options[sel.selectedIndex].value.trim();
    var distnm = sel.options[sel.selectedIndex].text.trim();
    if (dist != "NONE")
    {
      document.all.Market.value = dist;
      document.all.MarketNm.value = distnm;
    }
    else
    {
      document.all.Market.value = "";
      document.all.MarketNm.value = "";
    }
}
//==============================================================================
// validate media name
//==============================================================================
function vldPlanDoc(id, action)
{
   var error = false;
   var msg = "";
   var br = "";
   document.all.tdError.innerHTML = "";
   document.all.tdError.style.color = "red";

   var type = document.all.Market.value.trim();
   if(type == ""){error = true; msg += br + "Please select Market"; br = "</br>";}

   var doc = document.all.Doc.value.trim();
   if(doc == ""){error = true; msg += br + "Please enter Document"; br = "</br>";}

   if(error){ document.all.tdError.innerHTML = msg.trim(); }
   else{ sbmPlanDoc(id, action); }
}
//==============================================================================
// validate media name
//==============================================================================
function sbmPlanDoc(id, action)
{
    document.Upload.selMarket.disabled = true;

    document.all.Action.value=action;
    document.Upload.submit();
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
        <br>Ads Planning Document List
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;This Page
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      <%if(sUsrDist.equals("ALL")){%>
         <a href="javascript: chgPlan('0',null,null,null,null, 'ADD')">Add Plan Document</a>
      <%}%>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <th class="DataTable">No.</th>
         <th class="DataTable">Market</th>
         <th class="DataTable">Document</th>
         <th class="DataTable">Comment</th>
         <th class="DataTable">Entry<br>User/Date/Time</th>
         <%if(sUsrDist.equals("ALL")){%>
             <th class="DataTable">Delete</th>
         <%}%>
       </tr>
      <TBODY>

  <!-------------------------- Order List ------------------------------->
  <%int iLine=0;%>
  <%while(sql_Plan.readNextRecord()) {%>
    <%
         String sId = sql_Plan.getData("PdDocId").trim();
         String sMarket = sql_Plan.getData("PdMkt").trim();
         String sMarketNm = sql_Plan.getData("dnam").trim();
         String sDoc = sql_Plan.getData("PdDoc").trim();
         String sCommt = sql_Plan.getData("PdCommt").trim();
         String sRecUs = sql_Plan.getData("PdRecUs").trim();
         String sRecDt = sql_Plan.getData("PdRecDt").trim();
         String sRecTm = sql_Plan.getData("PdRecTm").trim();
    %>
        <tr  class="DataTable">
            <td class="DataTable2"><%=++iLine%></td>
            <td class="DataTable"><%=sMarketNm%></td>
            <td class="DataTable"><a href="AdPlans/<%=sDoc%>" target="_blank"><%=sDoc%></a></td>
            <td class="DataTable"><%=sCommt%></td>
            <td class="DataTable"><%=sRecUs%> <%=sRecDt%> <%=sRecTm%></td>
            <%if(sUsrDist.equals("ALL")){%>
               <td class="DataTable2"><a href="javascript: chgPlan('<%=sId%>','<%=sMarket%>','<%=sMarketNm%>','<%=sCommt%>','<%=sDoc%>', 'DLT');">Dlt</a></td>
            <%}%>
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
sql_Plan.disconnect();
}%>

