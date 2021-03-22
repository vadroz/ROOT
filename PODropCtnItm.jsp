<%@ page import="posend.PODropCtnItm"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=PODropCtnItm.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    String sPoNum = request.getParameter("PO");
    String sUser = session.getAttribute("USER").toString();
    String sLastRctDt = request.getParameter("LastRctDt");

    PODropCtnItm porct = new PODropCtnItm(sPoNum);

    String [] sRct = porct.getRct();
    String [] sRctDt = porct.getRctDt();

    int iNumOfCtn = porct.getNumOfCtn();
    String [] sCtnRct = porct.getCtnRct();
    String [] sCtn = porct.getCtn();
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

        #trItem{display:none;}

</style>


<script name="javascript1.2">
var DispDtl = "block";

//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   //setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
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
// fold unfold items
//==============================================================================
function showItemDtl()
{
   for(var i=0; i < document.all.trItem.length; i++)
   {
      document.all.trItem[i].style.display = DispDtl;
   }
   if(DispDtl == "block"){ DispDtl = "none"; }
   else { DispDtl = "block"; }
}


</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<HTML><HEAD>

<META content="RCI, Inc." name=porct></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Purchase Order Receipts
        <br>P.O.# <%=sPoNum%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="POWorksheetList.jsp?Sort=STR" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;

        <a href="javascript: showItemDtl()" class="small">fold/unfold</a>
          &nbsp;&nbsp;&nbsp;&nbsp;
        <%if(sLastRctDt != null){%>
           <a style="font-size:12px; font-weight:bold;" href="POAllReceipt.jsp?PO=<%=sPoNum%>&LastRctDt=<%=sLastRctDt%>&Asn=Y">Corrections</a>
        <%}%>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable">Receipt</th>
           <th class="DataTable">Carton</th>
           <th class="DataTable">UPC</th>
           <th class="DataTable">Seq</th>
           <th class="DataTable">Vendor Style</th>
           <th class="DataTable">Desc</th>
           <th class="DataTable">P.O. Qty</th>
           <th class="DataTable">Carton<br>Quantity</th>
         </tr>
         <tr id="trItem" style="font-size:1px"><td colspan=8>&nbsp;</td></tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfCtn; i++ ){
           porct.setCtnItmNum();
           int iNumOfItm = porct.getNumOfItm();
           String sTotCtnQty = porct.getTotCtnQty();
       %>
         <tr id="trCtn" class="DataTable1">
            <td class="DataTable" nowrap><%=sCtnRct[i]%></td>
            <td class="DataTable" nowrap><%=sCtn[i]%></td>

            <td class="DataTable" nowrap>Number Of Items: <%=iNumOfItm%></td>
            <td class="DataTable" colspan="4">&nbsp;</td>
            <td class="DataTable"><%=sTotCtnQty%></td>
         </tr>
         <%for(int j=0; j < iNumOfItm; j++)
           {
              porct.setCtnItems();
              String sCls = porct.getCls();
              String sVen = porct.getVen();
              String sSty = porct.getSty();
              String sClr = porct.getClr();
              String sSiz = porct.getSiz();
              String sSku = porct.getSku();
              String sDesc = porct.getDesc();
              String sSeq = porct.getSeq();
              String sQty = porct.getQty();
              String sCtnQty = porct.getCtnQty();
              String sUpc = porct.getUpc();
              String sVenSty = porct.getVenSty();
        %>
         <tr id="trItem" class="DataTable">
            <td class="DataTable" nowrap colspan=2>&nbsp;</td>
            <!--  td class="DataTable" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td -->
            <td class="DataTable" nowrap><%=sUpc%></td>
            <td class="DataTable" nowrap>&nbsp;<%=sSeq%></td>
            <!--  td class="DataTable" nowrap><%=sSku%></td -->
            <td class="DataTable" nowrap><%=sVenSty%></td>
            <td class="DataTable" nowrap><%=sDesc%></td>
            <td class="DataTable" nowrap><%=sQty%></td>
            <td class="DataTable" nowrap><%=sCtnQty%></td>
          </tr>
          <%}%>
       <%}%>
       </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
  porct.disconnect();
  porct = null;
}%>