<%@ page import="posend.POItemList"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POItemList.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    if(session.getAttribute("BSREDIT")==null){response.sendRedirect("index.jsp");}

    String sPO = request.getParameter("PO");
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sDivision.length + "|" + sVendor + sUser);
    POItemList poiteml = new POItemList(sPO, sUser);

    String sOrdDt = poiteml.getOrdDt();
    String sShipDt = poiteml.getShipDt();
    String sAntcDt = poiteml.getAntcDt();
    String sCnclDt = poiteml.getCnclDt();
    String sOrigPO = poiteml.getOrigPO();
    String sVia = poiteml.getVia();
    String sTerms = poiteml.getTerms();
    String sCommod = poiteml.getCommod();
    String [] sVenAddr = poiteml.getVenAddr();
    String [] sTopCmt = poiteml.getTopCmt();
    String [] sBotCmt = poiteml.getBotCmt();
    String sDisc = poiteml.getDisc();
    String sStatus = poiteml.getStatus();
    String sRevNum = poiteml.getRevNum();
    String [] sShipTo = poiteml.getShipTo();
    String sVcDist = poiteml.getVcDist();
    String sVcPreTi = poiteml.getVcPreTi();
    String sVcFree = poiteml.getVcFree();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;  padding-left:3px;
                       padding-right:3px; text-align:center; font-family:Verdanda; font-size:12px }

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
// show Item BSR Editing page
//==============================================================================
function sbmItemList(cls, ven, sty, clr, siz)
{
  var url = "ItemBSREdit.jsp?"
          + "Div=ALL"
          + "&Dpt=ALL"
          + "&Cls=" + cls
          + "&Ven=" + ven
          + "&Item=" + cls + "-" + ven + "-" + sty + "-" + clr + "-" + siz

  //alert(url)
  window.location.href=url;
}

</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
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
        <BR>Purchase Order: <%=sPO%>
        <br>Item List
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="POwoBSRandUPCSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <a href="javascript: history.go(-1)" class="small"><font color="red">PO w/o BSR and UPC</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;

    <!-- ======================== PO Header Information ======================= -->
        <%/*
            String sOrdDt = poiteml.getOrdDt();
    String sShipDt = poiteml.getShipDt();
    String sAntcDt = poiteml.getAntcDt();
    String sCnclDt = poiteml.getCnclDt();
    String sOrigPO = poiteml.getOrigPO();
    String sVia = poiteml.getVia();
    String sTerms = poiteml.getTerms();
    String sCommod = poiteml.getCommod();
    String [] sVenAddr = poiteml.getVenAddr();
    String [] sTopCmt = poiteml.getTopCmt();
    String [] sBotCmt = poiteml.getBotCmt();
    String sDisc = poiteml.getDisc();
    String sStatus = poiteml.getStatus();
    String sRevNum = poiteml.getRevNum();
    String [] sShipTo = poiteml.getShipTo();
        */%>
        <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
        <tr  class="DataTable">
           <th class="DataTable">P.O.#</th>
           <th class="DataTable">Buyer Ref. No.</th>
           <th class="DataTable">Original/Confirmation</th>

           <th class="DataTable">Ordered</th>
           <th class="DataTable">Ship On</th>
           <th class="DataTable">Anticipate</th>
           <th class="DataTable">Cancel After</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable"><%=sPO%></td>
           <td class="DataTable"><%=sOrigPO%></td>
           <td class="DataTable"><%=sStatus%> <%=sRevNum%></td>

           <td class="DataTable"><%=sOrdDt%></td>
           <td class="DataTable"><%=sShipDt%></td>
           <td class="DataTable"><%=sAntcDt%></td>
           <td class="DataTable"><%=sCnclDt%></td>
         </tr>

         <tr  class="DataTable">
           <th class="DataTable" colspan=3>Vendor Address</th>
           <th class="DataTable" colspan=2>Commodity</th>
           <th class="DataTable">Discount</th>
           <th class="DataTable">Terms</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1" colspan=3><%=sVenAddr[0]%><br><%=sVenAddr[1]%><br><%=sVenAddr[2]%><br><%=sVenAddr[3]%></td>
           <td class="DataTable" colspan=2><%=sCommod%></td>
           <td class="DataTable"><%=sDisc%>%</td>
           <td class="DataTable"><%=sTerms%></td>
         </tr>

         <tr  class="DataTable">
           <th class="DataTable" colspan=7>Comments</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1" colspan=7><%=sTopCmt[0]%> <%=sTopCmt[1]%> <%=sTopCmt[2]%> <%=sTopCmt[3]%></td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1" colspan=7><%=sBotCmt[0]%> <%=sBotCmt[1]%> <%=sBotCmt[2]%></td>
         </tr>
         
         <tr  class="DataTable">
           <th class="DataTable" colspan=7>Vendor Compliance by PO</th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable" colspan=5>Distribution Method</th>
           <th class="DataTable">Vendor<br>Pre-Ticket</th>
           <th class="DataTable">Free<br>Freight</th>
         <tr class="DataTable1">
           <td class="DataTable" colspan=5><%=sVcDist%></td>
           <td class="DataTable"><%=sVcPreTi%></td>
           <td class="DataTable"><%=sVcFree%></td>
         </tr>
         
       </table><br>
   <!-- ========================= PO Item List ================================ -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable">C<br>h<br>g</th>
           <th class="DataTable">Item Number</th>
           <th class="DataTable">Short SKU</th>
           <th class="DataTable">Description</th>
           <th class="DataTable">Color<br>Name</th>
           <th class="DataTable">Size<br>Name</th>
           <th class="DataTable">UPC</th>
           <th class="DataTable">Summary<br>BSR</th>
           <th class="DataTable">Onhand <br>Chain</th>
           <th class="DataTable">Onhand<br>DC</th>
           <th class="DataTable">Cost</th>
           <th class="DataTable">Retail</th>
           <th class="DataTable">Qty</th>
           <th class="DataTable">Vendor<br>Style</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%while(poiteml.setNext())
        {
           poiteml.setPOItems();
           String sCls = poiteml.getCls();
           String sVen = poiteml.getVen();
           String sSty = poiteml.getSty();
           String sClr = poiteml.getClr();
           String sSiz = poiteml.getSiz();
           String sSku = poiteml.getSku();
           String sCost = poiteml.getCost();
           String sRet = poiteml.getRet();
           String sQty = poiteml.getQty();
           String sDesc = poiteml.getDesc();
           String sVenSty = poiteml.getVenSty();
           String sUpc = poiteml.getUpc();
           String sClrName = poiteml.getClrName();
           String sSizName = poiteml.getSizName();
           String sIdeal = poiteml.getIdeal();
           String sChnOnh = poiteml.getChnOnh();
           String sDcOnh = poiteml.getDcOnh();
         %>
         <tr id="trGroup" class="DataTable">
            <%if(sIdeal.equals("")){%>
               <td class="DataTable1" nowrap><a href="javascript: sbmItemList('<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>')">&nbsp;C&nbsp;</a></td>
            <%} else {%><td class="DataTable1" nowrap>&nbsp;</td><%}%>
            <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
            <td class="DataTable1" nowrap><%=sSku%></td>
            <td class="DataTable1" nowrap><%=sDesc%></td>
            <td class="DataTable1" nowrap><%=sClrName%></td>
            <td class="DataTable1" nowrap><%=sSizName%></td>
            <td class="DataTable1" nowrap><%=sUpc%></td>
            <td class="DataTable2" <%if(sIdeal.equals("")){%>style="background: pink;"<%}%> nowrap><%=sIdeal%></td>
            <td class="DataTable2" nowrap><%=sChnOnh%></td>
            <td class="DataTable2" nowrap><%=sDcOnh%></td>
            <td class="DataTable2" nowrap><%=sCost%></td>
            <td class="DataTable2" nowrap><%=sRet%></td>
            <td class="DataTable2" nowrap><%=sQty%></td>
            <td class="DataTable1" nowrap><%=sVenSty%></td>
          </tr>
       <%}%>
       </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   poiteml.disconnect();
   poiteml = null;
%>
<%}%>