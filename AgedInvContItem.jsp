<%@ page import="java.util.*, java.text.*, worldcup.AgedInvContItem"%>
<%
   String sStr = request.getParameter("Str");
   String sSelDate = request.getParameter("Date");
   String sGrp = request.getParameter("Grp");
   String sLevel = request.getParameter("Level");
   String sUser = session.getAttribute("USER").toString();

   if(sSelDate == null){ sSelDate = "LAST";}

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AgedInvContItem.jsp&APPL=ALL" + "&" + request.getQueryString());
}
else
{
    AgedInvContItem agegame = new AgedInvContItem(sStr, sSelDate, sGrp, sLevel, sUser);


    // Convert date to string, retreive current date
    String sDateLine = null;
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    if(sSelDate.equals("LAST"))
    {
       Date date = new Date((new Date()).getTime() - 86400000);
       sDateLine = "As of Date: " + sdf.format(date);
    }
    else if(sSelDate.equals("ALL"))
    {
       Date date = new Date((new Date()).getTime() - 86400000);
       sDateLine = "From 3/16/2009  Through " + sdf.format(date);
    }
    else { sDateLine = "As of Date: " + sSelDate; }
%>

<style>body {background:ivory;font-family: Verdanda}
         a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}
                 a:hover { color:red; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: white; font-size:10px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable11 { background: #FFCC99; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

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

        #tdMargin { display: none; }
</style>
<html>
<head><Meta http-equiv="refresh"></head>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
}

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Aged Inventory Sales Contest Item Details
      <br><%=sDateLine%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th class="DataTable">Store<br>
          <th class="DataTable">Div</th>
          <th class="DataTable">Dpt</th>
          <th class="DataTable">Long Item Number</th>
          <th class="DataTable">Short Sku</th>
          <th class="DataTable">Desc</th>
          <th class="DataTable">Vendor<br>Style</th>
          <th class="DataTable">Retail</th>
          <th class="DataTable">Cost</th>
          <th class="DataTable">Qty</th>
          <th class="DataTable">Margin</th>
        </tr>
     <!------------------------- Budget Group --------------------------------------->
     <%while(agegame.getNext()){%>
        <%
           agegame.setItemSls();
           int iNumOfItm = agegame.getNumOfItm();
           String [] sStore = agegame.getStore();
           String [] sDiv = agegame.getDiv();
           String [] sDpt = agegame.getDpt();
           String [] sCls = agegame.getCls();
           String [] sVen = agegame.getVen();
           String [] sSty = agegame.getSty();
           String [] sClr = agegame.getClr();
           String [] sSiz = agegame.getSiz();
           String [] sSku = agegame.getSku();
           String [] sDesc = agegame.getDesc();
           String [] sVenSty = agegame.getVenSty();
           String [] sRet = agegame.getRet();
           String [] sCost = agegame.getCost();
           String [] sQty = agegame.getQty();
           String [] sMargin = agegame.getMargin();
       %>
        <%for(int i=0; i < iNumOfItm; i++){%>
        <!-- Store Details -->
          <tr class="DataTable">
            <td class="DataTable1" nowrap><%=sStore[i]%></td>
            <td class="DataTable1" nowrap><%=sDiv[i]%></td>
            <td class="DataTable1" nowrap><%=sDpt[i]%></td>
            <td class="DataTable1" nowrap><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
            <td class="DataTable1" nowrap><%=sSku[i]%></td>
            <td class="DataTable1" nowrap><%=sDesc[i]%></td>
            <td class="DataTable1" nowrap><%=sVenSty[i]%></td>
            <td class="DataTable1" nowrap>$<%=sRet[i]%></td>
            <td class="DataTable1" nowrap>$<%=sCost[i]%></td>
            <td class="DataTable1" nowrap><%=sQty[i]%></td>
            <td class="DataTable1" nowrap><%=sMargin[i]%>%</td>
        </tr>
       <%}%>
     <%}%>
     <!------------------------- Report Total --------------------------------->
     <%
         agegame.setRepTot();
         String sTotRet = agegame.getTotRet();
         String sTotCost = agegame.getTotCost();
         String sTotQty = agegame.getTotQty();
         String sTotMargin = agegame.getTotMargin();
     %>
     <tr class="DataTable2">
        <td class="DataTable1" colspan=7 nowrap>Total</td>
        <td class="DataTable1" nowrap>$<%=sTotRet%></td>
        <td class="DataTable1" nowrap>$<%=sTotCost%></td>
        <td class="DataTable1" nowrap><%=sTotQty%></td>
        <td class="DataTable1" nowrap><%=sTotMargin%>%</td>
     </tr>
   </table>
   <!----------------------- end of table ---------------------------------->
  </table>
 </body>

</html>
<%
  agegame.disconnect();
  agegame=null;
%>

<%}%>






