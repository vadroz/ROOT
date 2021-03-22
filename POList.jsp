<%@ page import="posend.POList"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POList.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    if(session.getAttribute("POSEND")==null){response.sendRedirect("index.jsp");}

    String [] sDivision = request.getParameterValues("Div");
    String sVendor = request.getParameter("Vendor");
    String sFromDate = request.getParameter("FromDate");
    String sToDate = request.getParameter("ToDate");
    String sDaType = request.getParameter("DaType");
    String sSort = request.getParameter("Sort");
    String sSelSts = request.getParameter("Sts");
    String sUser = session.getAttribute("USER").toString();

    if(sSort==null) sSort= "PON";

    POList polist = new POList(sDivision, sVendor, sFromDate, sToDate, sDaType, sSort, sUser, sSelSts);

    int iNumOfPo = polist.getNumOfPo();
    String [] sPo =  polist.getPo();
    String [] sDiv = polist.getDiv();
    String [] sDivName = polist.getDivName();
    String [] sVen = polist.getVen();
    String [] sVenName = polist.getVenName();
    String [] sAntcDate = polist.getAntcDate();
    String [] sCrtDate = polist.getCrtDate();
    String [] sDisc = polist.getDisc();
    String [] sOrig = polist.getOrig();
    String [] sRevNum = polist.getRevNum();
    String [] sBuyer = polist.getBuyer();
    String [] sRetail = polist.getRetail();
    String [] sCost = polist.getCost();
    String [] sShipDate = polist.getShipDate();
    String [] sComment = polist.getComment();
    String [] sSts = polist.getSts();

    polist.disconnect();

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
var SelRow = 0;
var Div = new Array();
<%for(int i=0; i < sDivision.length; i++){%>
     Div[<%=i%>] = "<%=sDivision[i]%>"
<%}%>
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
}
//==============================================================================
// re-sort list
//==============================================================================
function sbmSort(sort)
{
   var url = "POList.jsp?Vendor=<%=sVendor%>"
   for(var i=0; i < Div.length; i++)
   {
      url += "&Div=" + Div[i];
   }
   url += "&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&Sts=<%=sSelSts%>&Sort=" + sort

   //alert(url)
   window.location.href=url;
}
//---------------------------------------------------------
// show Comments on panel
//---------------------------------------------------------
function showComment(arg, ponum, commt)
{
  if(commt == "Add a comment") commt="";


  var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Add/Update Comments for P.O. " + ponum + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
  // Comment line
   html += "<tr class='DataTable1'>"
          + "<td class='DataTable' nowrap colspan='2'>Comments: "
          + "<input name='Commt' class='Small' size='70' maxlength='70' value='" + commt + "'></td>"
        + "</tr>"
   // buttons
   html += "<tr class='DataTable1'>"
          + "<td class='DataTable' nowrap colspan='2'>"
          + "<button class='Small' onClick='saveComment(" + arg + ", " + ponum + ")'>Save</button>&nbsp;&nbsp;"
          + "<button class='Small' onClick='hidePanel();'>Cancel</button>"
          + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 200;
   document.all.Prompt.style.pixelTop= 200;
   document.all.Prompt.style.visibility = "visible";
}

//--------------------------------------------------------
// save Comments
//--------------------------------------------------------
function saveComment(arg, ponum)
{
   var url = "POSaveComment.jsp?"
     + "PoNum=" + ponum
     + "&Comment=" + document.all.Commt.value.trim();
   //alert(url);
   //window.location.href = url
   window.frame1.location = url;

   if ( document.all.Commt.value.trim() != ""
     && document.all.Commt.value.trim() != " ")
   {
        document.all.linkCmt[arg].innerHTML = document.all.Commt.value.trim();
   }
   else document.all.linkCmt[arg].innerHTML = "Add a comment";
   hidePanel();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}
//==============================================================================
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<HTML><HEAD>

<META content="RCI, Inc." name=POList></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Available Purchase Order List
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="POListSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable"><a href="javascript: sbmSort('DIV')">Division</a></th>
           <th class="DataTable"><a href="javascript: sbmSort('PON')">P.O.<br>Number</a></th>
           <th class="DataTable"><a href="javascript: sbmSort('VEN')">Vendor</a></th>
           <th class="DataTable"><a href="javascript: sbmSort('SHIPDT')">Shipping<br>Delivery Date</a></th>
           <th class="DataTable">S<br>t<br>s</th>
           <th class="DataTable">Original<br>/Confirmation</th>
           <th class="DataTable">Retail</th>
           <th class="DataTable">Cost</th>
           <th class="DataTable">Buyer</th>
           <th class="DataTable">Comments</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfPo; i++ ){%>
         <tr id="trGroup" class="DataTable">
            <td class="DataTable1" nowrap><%=sDiv[i] + " - " + sDivName[i]%></td>
            <td class="DataTable1" nowrap><a href="POPrint.jsp?PO=<%=sPo[i]%>" class="small"><%=sPo[i]%></a></td>
            <td class="DataTable1" nowrap><%=sVen[i] + " - " + sVenName[i]%></td>
            <td class="DataTable1" nowrap><%=sShipDate[i]%></td>
            <td class="DataTable" nowrap><%=sSts[i]%></td>
            <td class="DataTable" nowrap><%=sOrig[i]%><%if(!sRevNum[i].trim().equals("")){%><%="-" + sRevNum[i]%><%}%></td>
            <td class="DataTable" nowrap><%=sRetail[i]%></td>
            <td class="DataTable" nowrap><%=sCost[i]%></td>
            <td class="DataTable" nowrap><%=sBuyer[i]%></td>
            <td class="DataTable1" nowrap>
                 <a id="linkCmt" href="javascript: showComment('<%=i%>', '<%=sPo[i]%>', document.all.linkCmt[<%=i%>].innerHTML)">
                   <%if(sComment[i].trim().equals("")) {%>Add a comment<%} else {%><%=sComment[i]%><%}%></a></td>
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