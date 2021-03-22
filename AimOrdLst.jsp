<%@ page import="aim.AmOrdLst"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sSelEmp = request.getParameter("Emp");
   String sSelSku = request.getParameter("Sku");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");

   if (sSelEmp == null) { sSelEmp = " "; }
   if (sSelSku == null) { sSelSku = " "; }
   if (sSort == null) { sSort = "EMP"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AmOrdLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmOrdLst ordlst = new AmOrdLst(sSelStr, sSelEmp, sSelSku, sFrDate, sToDate, sSort, sUser);

      String sSelStrJsa = ordlst.cvtToJavaScriptArray(sSelStr);
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:red;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#cccfff;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:12px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
        td.DataTable1 {padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable1p {background:gray;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
              text-align:center; font-size:10px}
                td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}

        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:bottom; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:bottom; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:bottom; font-family:Arial; font-size:10px; }

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelStr = [<%=sSelStrJsa%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
// restart
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
   document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{
   var url = "AimOrdLst.jsp?"

   for(var i=0; i < SelStr.length; i++)  { url += "&Str=" + SelStr[i] }

   url += "&Emp=<%=sSelEmp%>"
   url += "&Sku=<%=sSelSku%>"
   url += "&FrDate=<%=sFrDate%>"
   url += "&ToDate=<%=sToDate%>"
   url += "&Sort=" + sort

   //alert(url)
   window.location.href = url;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>AIM - Employee Order List
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="AimOrdLstSel.jsp"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

  <!----------------------- Order List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable"><a href="javascript: resort('EMP')">Employee<br>Number</a></th>
         <th class="DataTable"><a href="javascript: resort('NAME')">Employee Name</a></th>
         <th class="DataTable"><a href="javascript: resort('STR')">Store</a></th>
         <th class="DataTable"><a href="javascript: resort('ORDATE')">Order<br>Date</a></th>
         <th class="DataTable"><a href="javascript: resort('SKU')">Short SKU</a></th>
         <th class="DataTable"><a href="javascript: resort('DESC')">Item Desc</a></th>
         <th class="DataTable"><a href="javascript: resort('QTY')">Qty</a></th>
         <th class="DataTable"><a href="javascript: resort('RET')">Ret</a></th>
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    while( ordlst.getNext() )
    {
       ordlst.setOrdLst();
       String sEmp = ordlst.getEmp();
       String sOrd = ordlst.getOrd();
       String sSku = ordlst.getSku();
       String sQty = ordlst.getQty();
       String sRet = ordlst.getRet();
       String sStr = ordlst.getStr();
       String sName = ordlst.getName();
       String sShipToStr = ordlst.getShipToStr();
       String sDesc = ordlst.getDesc();
       String sOrdDt = ordlst.getOrdDt();
  %>
     <tr class="DataTable1">
       <td class="DataTable2"><%=sEmp%></td>
       <td class="DataTable2"><%=sName%></td>
       <td class="DataTable2"><%=sStr%></td>
       <td class="DataTable2"><%=sOrdDt%></td>
       <td class="DataTable2"><%=sSku%></td>
       <td class="DataTable2"><%=sDesc%></td>
       <td class="DataTable2"><%=sQty%></td>
       <td class="DataTable2">$<%=sRet%></td>
     </tr>
  <%}%>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    ordlst.disconnect();
    ordlst = null;
%>
<%}%>