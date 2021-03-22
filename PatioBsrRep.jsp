<%@ page import="patiosales.PatioBsrRep"%>
<%
    String sFrDate = request.getParameter("FrDate");
    String sToDate = request.getParameter("ToDate");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PatioBsrRep.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PatioBsrRep pibsr = new PatioBsrRep(sFrDate, sToDate, "vrozen");
    int iNumOfItm = pibsr.getNumOfItm();
%>
<HTML>
<HEAD>
<title>Patio Sales</title>
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
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
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
//-------------------- Global Variables ----------------------------------------
var NumOfItm = <%=iNumOfItm%>
var Fold = "none";
//-------------------- End Global Variables ------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   displayStr();
}
//==============================================================================
// run on loading
//==============================================================================
function displayStr()
{
   // fold/unfold header
   for(var i=0; i < document.all.thStr46.length; i++)
   {
     document.all.thStr46[i].style.display = Fold;
     document.all.thStr50[i].style.display = Fold;
     document.all.thStr55[i].style.display = Fold;
     document.all.thStr86[i].style.display = Fold;
     if (Fold == "none")
     {
        document.all.thSold.colSpan = 1;
        document.all.thOnhand.colSpan = 1;
        document.all.thPO.colSpan = 1;
        document.all.thBsr.colSpan = 1;
        document.all.thNeed.colSpan = 1;
     }
     else
     {
        document.all.thSold.colSpan = 5;
        document.all.thOnhand.colSpan = 5;
        document.all.thPO.colSpan = 5;
        document.all.thBsr.colSpan = 5;
        document.all.thNeed.colSpan = 5;
     }
   }

   // fold/unfold details
   for(var i=0; i < NumOfItm; i++)
   {
      for(var j=0; j < 4; j++)
      {
         var ord = "tdOrdI" + i + "S" + j;
         document.all[ord].style.display = Fold;
         var onh = "tdOnhI" + i + "S" + j;
         document.all[onh].style.display = Fold;
         var poq = "tdPoqI" + i + "S" + j;
         document.all[poq].style.display = Fold;
         var bsr = "tdBsrI" + i + "S" + j;
         document.all[bsr].style.display = Fold;
         var need = "tdNeeI" + i + "S" + j;
         document.all[need].style.display = Fold;
      }
   }

   if (Fold == "none") Fold = "block";
   else Fold = "none";
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


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
        <BR>Patio Furniture Replenishment Report<br>
        Compare date Range <%=sFrDate%> thru <%=sToDate%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="PatioBsrRepSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: displayStr();">fold/unfold</a>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2>Item</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>

             <th id="thSold" class="DataTable" colspan=5>Sold</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th id="thOnhand" class="DataTable" colspan=5>Onhand</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th id="thPO" class="DataTable" colspan=5>P.O.</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th id="thBsr" class="DataTable" colspan=5>BSR<br>Level</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th id="thNeed" class="DataTable" colspan=5>Need</th>

             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" rowspan=2>Sku</th>
             <th class="DataTable" rowspan=2>Description</th>
             <th class="DataTable" rowspan=2>Vendor Name</th>
             <th class="DataTable" rowspan=2>Vendor Style</th>
         </tr>
         <tr class="DataTable">
           <%for(int i=0; i < 5; i++){%>
             <th id="thStr46" class="DataTable">46</th>
             <th id="thStr50" class="DataTable">50</th>
             <th id="thStr55" class="DataTable">55</th>
             <th id="thStr86" class="DataTable">86</th>
             <th id="thStrTot" class="DataTable">Tot</th>
           <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ )
         {
            pibsr.setItmList();
            String sCls = pibsr.getCls();
            String sVen = pibsr.getVen();
            String sSty = pibsr.getSty();
            String sClr = pibsr.getClr();
            String sSiz = pibsr.getSiz();
            String sSku = pibsr.getSku();
            String sDesc = pibsr.getDesc();
            String sVenNm = pibsr.getVenNm();
            String sVenSty = pibsr.getVenSty();
            String [] sOrdQty = pibsr.getOrdQty();
            String [] sOnhand = pibsr.getOnhand();
            String [] sPOQty = pibsr.getPOQty();
            String [] sBsrLevel = pibsr.getBsrLevel();
            String [] sNeed = pibsr.getNeed();
        %>
            <tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>

            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < sOrdQty.length; j++){%>
               <td id="tdOrdI<%=i%>S<%=j%>" class="DataTable2" nowrap><%=sOrdQty[j]%></td>
            <%}%>

            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < sOnhand.length; j++){%>
               <td id="tdOnhI<%=i%>S<%=j%>" class="DataTable2" nowrap><%=sOnhand[j]%></td>
            <%}%>

            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < sPOQty.length; j++){%>
               <td id="tdPoqI<%=i%>S<%=j%>" class="DataTable2" nowrap><%=sPOQty[j]%></td>
            <%}%>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < sBsrLevel.length; j++){%>
               <td id="tdBsrI<%=i%>S<%=j%>" class="DataTable2" nowrap><%=sBsrLevel[j]%></td>
            <%}%>
            <th class="DataTable">&nbsp;</th>
            <%for(int j=0; j < sNeed.length; j++){%>
               <td id="tdNeeI<%=i%>S<%=j%>" class="DataTable2" nowrap><%=sNeed[j]%></td>
            <%}%>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable1" nowrap><%=sSku%></td>
            <td class="DataTable1" nowrap><%=sDesc%></td>
            <td class="DataTable1" nowrap><%=sVenNm%></td>
            <td class="DataTable1" nowrap><%=sVenSty%></td>
          </tr>
       <%}%>
     </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   pibsr.disconnect();
   pibsr = null;
   }
%>