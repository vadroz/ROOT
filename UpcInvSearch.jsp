<%@ page import="inventoryreports.UpcInvSearch, java.util.*"%>
<%
   String sSearchStr = request.getParameter("STORE");
   String sSearchUpc = request.getParameter("UPC");
   String sSearchSku = request.getParameter("SKU");
   String sSearchClass = request.getParameter("CLASS");
   String sPiYearMo = request.getParameter("PICal");

   if(sSearchUpc==null) sSearchUpc =" ";
   if(sSearchSku==null) sSearchSku =" ";
   if(sSearchStr==null) sSearchStr =" ";


   int iNumOfItm = 0;
   String [] sCls = null;
   String [] sVen = null;
   String [] sSty = null;
   String [] sClr = null;
   String [] sSiz = null;
   String [] sSku = null;
   String [] sItmDsc = null;
   String [] sVenSty = null;
   String [] sVenName = null;
   String [] sUpc = null;
   String [] sRet = null;
   String [] sArea = null;
    String [] sQty = null;

   UpcInvSearch search = new UpcInvSearch();

   // if one criteria is selected search the items
   if(!sSearchUpc.trim().equals("") || !sSearchSku.trim().equals(""))
   {
     search.setSearch( sSearchStr, sSearchUpc, sSearchSku, sPiYearMo.substring(0, 4),
                       sPiYearMo.substring(4));

     iNumOfItm = search.getNumOfItm();
     sCls = search.getCls();
     sVen = search.getVen();
     sSty = search.getSty();
     sClr = search.getClr();
     sSiz = search.getSiz();
     sSku = search.getSku();
     sItmDsc = search.getItmDsc();
     sVenSty = search.getVenSty();
     sVenName = search.getVenName();
     sUpc = search.getUpc();
     sRet = search.getRet();
     sArea = search.getArea();
     sQty = search.getQty();

     search.disconnect();
   }
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:WhiteSmoke; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px;
                       border-right: darkred solid 1px;
                       text-align:left;}

        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}

        select.Small {font-family:Arial; font-size  :10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<script language="JavaScript1.3">

//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//--------------------------------------------------------
// populate some fields on beginning
//--------------------------------------------------------


function ShowAdjData(cls, ven, sty)
{
  var url="PIDtlAdj.jsp?STORE=<%=sSearchStr%>"
  + "&DIVISION=ALL&DEPARTMENT=ALL"
  + "&CLASS=" + cls
  + "&VENDOR=" + ven
  + "&STYLE=" + sty
  + "&SORT=GROUP"
  + "&PICal=<%=sPiYearMo%>"
  + "&BYCHAIN=Y"
  //alert(url);
  window.location.href=url;
}

</script>
</head>

<body>

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Store: <%=sSearchStr%>
      <br><%if(!sSearchUpc.trim().equals("")){%>Search Item by UPC code: <%=sSearchUpc%><%}
       else if(!sSearchSku.trim().equals("")){%>Search Item by Sku: <%=sSearchSku%><%}
       else  {%>Select Search Criteria: UPC or Short Sku<%}%>
      </b>

      <!-- ---------------------------------------------------------------- -->
      <form action="UpcInvSearch.jsp" name="SearchUPC">
         Search Item by UPC: <input class='small' name='UPC' size="18" maxlength="14"><br>
         Search Item by Short SKU: <input class='small' name='SKU' size="10" maxlength="10"><br>
         <input class='small' name="Search" type="Submit" value="Search">
         <input type="hidden" name="STORE" value="<%=sSearchStr%>">
         <input type="hidden" name="PICal" value="<%=sPiYearMo%>">
      </form>
      <!-- ---------------------------------------------------------------- -->

     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
            <th class="DataTable" nowrap>Class-Ven-Sty-Clr-Size</th>
            <th class="DataTable">A<br>d<br>j</th>
            <th class="DataTable">Short SKU</th>
            <th class="DataTable">UPC</th>
            <th class="DataTable">Item Description</th>
            <th class="DataTable">Vendor Style</th>
            <th class="DataTable">Vendor Name</th>
            <th class="DataTable">Chain<br>Retail</th>
            <th class="DataTable">Area</th>
            <th class="DataTable">Qty</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++) {%>
              <tr class="DataTable">
                <td class="DataTable" nowrap>
                    <%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i]
                       + "-" + sSiz[i]%></td>

                <td class="DataTable" nowrap>
                   <a href="javascript:ShowAdjData('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>');">A</a>
                <td class="DataTable" nowrap><%=sSku[i]%></td>
                <td class="DataTable" nowrap><%=sUpc[i]%></td>
                <td class="DataTable" nowrap><%=sItmDsc[i]%></td>
                <td class="DataTable" nowrap><%=sVenSty[i]%></td>
                <td class="DataTable" nowrap><%=sVenName[i]%></td>
                <td class="DataTable" nowrap><%=sRet[i]%></td>
                <td class="DataTable" nowrap>
                   <%if(!sArea[i].equals("NOF")){%>
                      <a target="_blank" href="PIWIRep.jsp?STORE=<%=sSearchStr%>&AREA=<%=sArea[i]%>&PICal=<%=sPiYearMo%>"><%=sArea[i]%></a><%} else {%><font color="RED">Not Found</font><%}%></td>
                <td class="DataTable" nowrap><%=sQty[i]%></td>
              </tr>
           <%}%>
      </table>
      <% if(iNumOfItm < 14) {
           for(int i=0; i < 14; i++){%>
              <br>
      <%   }
        }%>

      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
