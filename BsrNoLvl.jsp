<%@ page import="inventoryreports.BsrNoLvl"%>
<%
  String sSelDiv = request.getParameter("Div");
  String sSelDpt = request.getParameter("Dpt");
  String sSelCls = request.getParameter("Cls");
  String sSelVen = request.getParameter("Ven");
  String [] sSelStr = request.getParameterValues("Str");
  String sLevel = request.getParameter("Level");
  String sSort = request.getParameter("Sort");
  if(sSort == null){ sSort = "LONGSKU";}

  //----------------------------------
  // Application Authorization
  //----------------------------------
  if (session.getAttribute("USER")==null)
  {
    response.sendRedirect("SignOn1.jsp?TARGET=PsSchScrSel.jsp");
  }
  else {
   String sUser = session.getAttribute("USER").toString();

   BsrNoLvl bsrnol = new BsrNoLvl(sSelDiv, sSelDpt, sSelCls, sSelVen, sLevel, sSelStr, sSort, sUser );
%>

<html>
<head>

<style>
        body {background:ivory;}

        tr.Count {dispaly:block}

        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        tr.DataTable { background:#e7e7e7; font-size:11px;  font-family:Arial;}

        td.DataTable { padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:left; }
        td.DataTable2 { padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:right; }
        td.DataTable3 { background: cornsilk; padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:right; }

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
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

        .Small { font-size:10px; }
</style>
<SCRIPT language="JavaScript">

function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

   <table border="0" width="100%" height="100%">
    <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Cycle Count Area Summary
      <br>Store:
        <%String sComa = "";%>
        <%for(int i=0; i < sSelStr.length; i++){%><%=sComa%> <%=sSelStr[i]%><%sComa=",";%><%}%>
      </b><br>
<!------------- end of store selector ---------------------->
        <p style="font-size:10px"><a href="../"><font color="red">Home</font></a>&#62;
        <a href="BsrNoLvlSel.jsp"><font color="red">Selection</font></a>&#62;
        This page
<!------------- start of dollars table ------------------------>
      <table border=1 class="DataTable" width="50%"  align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable">Div</th>
          <th class="DataTable">Dpt</th>
          <th class="DataTable">Long Sku</th>
          <th class="DataTable">Short Sku</th>
          <th class="DataTable">Description</th>
          <th class="DataTable">Vendor Name</th>
          <th class="DataTable">Vendor<br>Style</th>
          <th class="DataTable">Color</th>
          <th class="DataTable">Size</th>
          <th class="DataTable">Warehouse<br>Qty</th>
          <th class="DataTable">&nbsp;</th>
          <%for(int i=0; i < sSelStr.length; i++){%><th class="DataTable"><%=sSelStr[i]%></th><%}%>
        </tr>
        <!-- ---------------------- Detail Loop ----------------------- -->
        <%while(bsrnol.getNext()){
           bsrnol.setItemProp();
           String sDiv = bsrnol.getDiv();
           String sDpt = bsrnol.getDpt();
           String sCls = bsrnol.getCls();
           String sVen = bsrnol.getVen();
           String sSty = bsrnol.getSty();
           String sClr = bsrnol.getClr();
           String sSiz = bsrnol.getSiz();
           String sDesc = bsrnol.getDesc();
           String sVenSty = bsrnol.getVenSty();
           String sVenNm = bsrnol.getVenNm();
           String sClrNm = bsrnol.getClrNm();
           String sSizNm = bsrnol.getSizNm();
           String sSku = bsrnol.getSku();
           String sQty = bsrnol.getQty();
           String [] sStr = bsrnol.getStr();
        %>
           <tr class="DataTable">
             <td class="DataTable2"><%=sDiv%></td>
             <td class="DataTable2"><%=sDpt%></td>
             <td class="DataTable1" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
             <td class="DataTable2"><%=sSku%></td>
             <td class="DataTable1" nowrap><%=sDesc%></td>
             <td class="DataTable1" nowrap><%=sVenNm%></td>
             <td class="DataTable1" nowrap><%=sVenSty%></td>
             <td class="DataTable1" nowrap><%=sClrNm%></td>
             <td class="DataTable1" nowrap><%=sSizNm%></td>
             <td class="DataTable3"><%=sQty%></td>
             <th class="DataTable">&nbsp;</th>
             <%for(int i=0; i < sSelStr.length; i++){%>
                <td class="DataTable" <%if(sStr[i].equals("0")){%>style="background:pink;"<%}%>><%=sStr[i]%></td>
             <%}%>
           </tr>
        <%}%>
       <!----------------------- end totals ----------------------------->
       </table>

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
<%
   bsrnol.disconnect();
   bsrnol = null;
 }
%>