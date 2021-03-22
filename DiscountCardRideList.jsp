<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=DiscountCardRideList.jsp");
}
else
{
   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();

   String sPrepStmt = "select rnam, rdat, einame, count(*) as cnt"
     + " from rci.advridf inner join rci.ecevitm on eiride=rnam"
     + " where rnam <> ' '"
     + " group by rnam, rdat, einame"
     + " order by rnam, einame"
     ;

   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();

%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.3">
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// set orders for selected sku
//==============================================================================
function setOrd(sku, startdt)
{
   var url = "DiscountCardRideSales.jsp?Sku=" + sku
           + "&StartDt=" + startdt
   window.frame1.location.href = url;
}
//==============================================================================
// show orders for selected sku
//==============================================================================
function showOrd(sku, site, ord, orddt, fnam, lnam)
{
   var hdr = "Sku:&nbsp;" + sku;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popOrdPanel(site, ord, orddt, fnam, lnam)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popOrdPanel(site, ord, orddt, fnam, lnam)
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><th class='DataTable' >Site</th>"
           + "<th class='DataTable'>Order</th>"
           + "<th class='DataTable'>Order<br>Date</th>"
           + "<th class='DataTable'>Name</th>"
         + "</tr>"

  for(var i=0; i < ord.length; i++)
  {
      panel += "<tr class='DataTable1'>"
          + "<td class='DataTable' nowrap>" + site[i] + "</td>"
          + "<td class='DataTable' nowrap>" + ord[i] + "</td>"
          + "<td class='DataTable' nowrap>" + orddt[i] + "</td>"
          + "<td class='DataTable' nowrap>" + lnam[i] + ", " +  fnam[i] + "</td>"
        + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan='4'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Discount Cards, Rides and Items
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Ride</th>
             <th class="DataTable">Start Date</th>
             <th class="DataTable">Discount Card</th>
             <th class="DataTable">SKU</th>
             <th class="DataTable">Description</th>
             <th class="DataTable">Long Item Number</th>
             <th class="DataTable">Handler</th>
             <th class="DataTable">Number<br>of<br>Purchase</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%int iSku=0;%>
       <%while(runsql.readNextRecord()){
           String sRide = runsql.getData("rnam");
           String sStrDt = runsql.getData("rdat");
           String sDiscCard = runsql.getData("einame");
           String sNumOfSku = runsql.getData("cnt");

           // Discount card SKU list
           RunSQLStmt sqlDC = new RunSQLStmt();

          String sStmtDC = "select eisku, digits(icls) as icls, digits(iven) as iven, "
           + "digits(isty) as isty, digits(iclr) as iclr, digits(isiz) as isiz, eihndlr, ides,"
           + "(select count(*) from rci.EcOrdh"
           + " where exists(select 1 from rci.ecordd "
           + " where ohordate >='" + sStrDt + "' and ohsite=odsite and ohord=odord and eisku=odsku)) as PurchNum"
           + " from rci.ecevitm inner join IpTsFil.IpItHdr on isku=eisku"
           + " where einame ='" + sDiscCard + "'"
           + " and eiride='" + sRide + "'"
           + " order by eisku"
           ;

           sqlDC.setPrepStmt(sStmtDC);
           sqlDC.runQuery();
           boolean bNext = true;
       %>
         <tr class="DataTable">
             <td class="DataTable1" rowspan="<%=sNumOfSku%>"><%=sRide%></td>
             <td class="DataTable" rowspan="<%=sNumOfSku%>"><%=sStrDt%></td>
             <td class="DataTable1" rowspan="<%=sNumOfSku%>"><%=sDiscCard%></td>
             <%while(sqlDC.readNextRecord()){
                String sSku = sqlDC.getData("eiSku");
                String sHandler = sqlDC.getData("eihndlr");
                String sDesc = sqlDC.getData("ides");
                String sCls = sqlDC.getData("icls");
                String sVen = sqlDC.getData("iven");
                String sSty = sqlDC.getData("isty");
                String sClr = sqlDC.getData("iclr");
                String sSiz = sqlDC.getData("isiz");
                String sPurchNum = sqlDC.getData("PurchNum");
             %>
                <%if(!bNext){%><tr class="DataTable"><%}%>
                  <td class="DataTable"><%=sSku%></td>
                  <td class="DataTable1"><%=sDesc%></td>
                  <td class="DataTable1"><%=sCls%><%=sVen%><%=sSty%>-<%=sClr%><%=sSiz%></td>

                  <td class="DataTable1"><%=sHandler%></td>
                  <td class="DataTable"><%if(!sPurchNum.equals("0")){%><a href="javascript: setOrd('<%=sSku%>', '<%=sStrDt%>')"><%=sPurchNum%></a><%} else {%>&nbsp;<%}%></td>
                <%bNext = false;%>
                </tr>
             <%}%>
         <%

            sqlDC.disconnect();
            sqlDC = null;
         %>
       <%}%>
       <!-- -------------------------- Total ------------------------------- -->


       <!-- -------------------------- Total for Ski Division -------------- -->
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   runsql.disconnect();
   runsql = null;
   }
%>