<%@ page import="patiosales.WarrantyClaimList ,java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sSelOrder = request.getParameter("Order");
   String [] sSelClmSts = request.getParameterValues("Status");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sSort = request.getParameter("Sort");

   if(sSelOrder == null){sSelOrder = "ALL";}
   if(sSort == null){sSort = "CLAIM";}

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=WarrantyClaimList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

      //From=01/01/0001&To=12/31/2999&Status=OPEN&Status=AWTPHOTO&Status=PHOTOUPL&Status=VENCONT
      System.out.println();

      WarrantyClaimList wclist = new WarrantyClaimList(sSelStr, sSelOrder, sFrom, sTo, sSelClmSts, sSort, "vrozen");

      String sUser = session.getAttribute("USER").toString();
%>

<html>
<head>
<title>Warranty Claim List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        table.DataTable1 { background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 {background:#e7e7e7; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:50; background-color:Lightgrey; z-index:10;
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
var ClmSts = new Array();
<%for(int i=0; i < sSelClmSts.length; i++){%>ClmSts[<%=i%>] = "<%=sSelClmSts[i]%>"; <%}%>
var FrDate = "<%=sFrom%>";
var ToDate = "<%=sTo%>";

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// display help when mouse over row name
//==============================================================================
function displayHelp(text, obj)
{
   if(text != "")
   {
      var html = "<table><tr><td style='font-size:10px' nowrap>" + text + "</td></tr></table>"
      var pos = getObjPosition(obj);
      document.all.dvHelp.innerHTML = html;
      document.all.dvHelp.style.pixelLeft= pos[0] + 50;
      document.all.dvHelp.style.pixelTop= pos[1] - 25;
      document.all.dvHelp.style.visibility = "visible";
   }
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hideHelp()
{

   document.all.dvHelp.innerHTML = " ";
   document.all.dvHelp.style.visibility = "hidden";
}
//==============================================================================
// get Logs
//==============================================================================
function getLogs(claim, order)
{
   var url = "WarrantyClaimLog.jsp?"
     + "Order=" + order
     + "&Claim=" + claim
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// Get Claim and Item Comments
//==============================================================================
function getComms(claim, order)
{
   var url = "WarrantyClaimComments.jsp?"
     + "Order=" + order
     + "&Claim=" + claim
     + "&Action=GET_CLAIM_COMMENTS"
     + "&Chg=N"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// set claim comments
//==============================================================================
function setClaimComments(numOfCmt)
{
   var hdr = "Claim Comments";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>"

   if (numOfCmt > 0){ html += window.frame1.document.body.innerHTML; }
   else { html += "No Comments"; }

   html += "</td></tr>"
      + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 40;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.width = 800;
   document.all.dvStatus.style.visibility = "visible";

   window.frame1.close();
}
//==============================================================================
// show Log Entries
//==============================================================================
function showLogEntires(tbl_log)
{
   var hdr = "Claim Log entries";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + tbl_log
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 40;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{

   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// sort report by selected columns
//==============================================================================
function resort(sort)
{
   var url = "WarrantyClaimList.jsp?From=" + FrDate
    + "&To=" + ToDate
   for(var i=0; i < ClmSts.length ;i++)
   {
     url += "&Status=" + ClmSts[i];
   }
   url += "&Sort=" + sort;
   window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp"></div>
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Patio Furniture Warranty Claim List
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="WarrantyClaimListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable" rowspan=2><a href="javascript:resort('CLAIM')">Claim Number</a></th>
          <th class="DataTable" colspan=2>Opened</th>
          <th class="DataTable" rowspan=2><a href="javascript:resort('STR')">Store</a></th>
          <th class="DataTable" rowspan=2>Order Number</th>
          <th class="DataTable" rowspan=2>Customer</th>
          <th class="DataTable" rowspan=2>Status</th>
          <th class="DataTable" colspan=4>Items</th>
          <th class="DataTable" colspan=5>Last Activity</th>
       </tr>
       <tr class="DataTable">
          <th class="DataTable">User</th>
          <th class="DataTable">Date</th>

          <th class="DataTable">No.</th>
          <th class="DataTable">Vendor</th>
          <th class="DataTable">Vendor<br>Action</th>
          <th class="DataTable">Current<br>Status</th>
          <th class="DataTable">Estimate<br>Ship<br>Date</th>

          <th class="DataTable">User</th>
          <th class="DataTable"><a href="javascript:resort('ACTIV')">Date</a></th>
          <th class="DataTable">Log</th>
          <th class="DataTable">Comments</th>
       </tr>
      <TBODY>

  <!-------------------------- Order List ------------------------------->
      <%
       while(wclist.getNext())
    {
       wclist.setClaimInfo();
       String sOrder = wclist.getOrder();
       String sClaim = wclist.getClaim();
       String sClmSts = wclist.getClmSts();

       String sLastUsr = wclist.getLastUsr();
       String sLastDt = wclist.getLastDt();
       String sLastTm = wclist.getLastTm();

       String sClmStsDesc = wclist.getClmStsDesc();

       String sOpenUsr = wclist.getOpenUsr();
       String sOpenDt = wclist.getOpenDt();
       String sOpenTm = wclist.getOpenTm();
       String sCust = wclist.getCust();
       String sCustLastNm = wclist.getCustLastNm();
       String sCustFirstNm = wclist.getCustFirstNm();
       String sCustAddr1 = wclist.getCustAddr1();
       String sCustAddr2 = wclist.getCustAddr2();
       String sCustCity = wclist.getCustCity();
       String sCustState = wclist.getCustState();
       String sCustZip = wclist.getCustZip();
       String sOrdStr = wclist.getOrdStr();

       int iNumOfItm = wclist.getNumOfItm();
       String [] sEstShpDt = wclist.getEstShpDt();
       String [] sVenAct = wclist.getVenAct();
       String [] sItmSts = wclist.getItmSts();
       String [] sEsdWarn = wclist.getEsdWarn();
       String [] sVen = wclist.getVen();
       String [] sVenNm = wclist.getVenNm();
       String sLate = wclist.getLate();
      %>
         <tr class="DataTable">
          <td class="DataTable"><a href="WarrantyClaimInfo.jsp?Order=<%=sOrder%>&Claim=<%=sClaim%>" target="_blank"><%=sClaim%></a></td>
          <td class="DataTable"><%=sOpenUsr%></td>
          <td class="DataTable"><%=sOpenDt%></td>
          <td class="DataTable2"><%=sOrdStr%></td>
          <td class="DataTable"><%=sOrder%></td>
          <td class="DataTable" onmouseover="displayHelp('<%=sCustAddr1%><br><%=sCustAddr2%><br><%=sCustCity%>, <%=sCustState%>, <%=sCustZip%>', this)" onmouseout="hideHelp()" >
          <%=sCustFirstNm%>&nbsp;<%=sCustLastNm%></td>
          <td class="DataTable" nowrap><%=sClmStsDesc%></td>
          <td class="DataTable1" nowrap><%=iNumOfItm%></td>
          
          <td class="DataTable" nowrap><%if(iNumOfItm == 0){%>&nbsp;<%}%><%String sBreak = "";%>
             <%for(int i=0; i < iNumOfItm; i++){%><%=sBreak + sVen[i] + " - " + sVenNm[i]%><%=sBreak = "<br>"%><%}%>
          </td>          
          <td class="DataTable" nowrap><%if(iNumOfItm == 0){%>&nbsp;<%}%><%sBreak = "";%>
             <%for(int i=0; i < iNumOfItm; i++){%><%=sBreak + sVenAct[i]%><%=sBreak = "<br>"%><%}%>
          </td>
          <td class="DataTable" nowrap><%if(iNumOfItm == 0){%>&nbsp;<%}%><%sBreak = "";%>
             <%for(int i=0; i < iNumOfItm; i++){%><%=sBreak + sItmSts[i]%><%=sBreak = "<br>"%><%}%>
          </td>
          <td class="DataTable"><%if(iNumOfItm == 0){%>&nbsp;<%}%><%sBreak = "";%>
            <%for(int i=0; i < iNumOfItm; i++){%>
               <span <%if(sEsdWarn[i].equals("1")){%>style="font-weight:bold;background-color:yellow"<%}%>>
                 <%=sBreak + sEstShpDt[i]%><%=sBreak = "<br>"%>
               </span>
            <%}%>
          </td>
          <td class="DataTable"><%=sLastUsr%></td>
          <td class="DataTable" <%if(sLate.equals("Y")){%>style="background:#e7e7e7;"<%}%>><%=sLastDt%></td>
          <th class="DataTable"><a href="javascript: getLogs('<%=sClaim%>', '<%=sOrder%>')">Log</a></th>
          <th class="DataTable"><a href="javascript: getComms('<%=sClaim%>', '<%=sOrder%>')">Comments</a></th>
      </tr>
      <%}%>
      </TBODY>
    </TABLE>
  <!----------------------- end of table ------------------------>
        <button onclick="history.go(-1)">Back</button>
        <p align=left>
        <span style="font-weight:bold;background-color:yellow;font-size:12px">99/99/9999</span>&nbsp;
        <span style="font-size:12px">Expected Ship Date is within 2 weeks, please call the Vendor to ensure item(s) will be shipped as scheduled!</span>
     </td>
   </tr>

  </table>
  <div id="dvClmComments" style="width:100%;">
 </body>
</html>
<%
   wclist.disconnect();
   wclist = null;
}%>


