<%@ page import="specialorder.SpecOrdInfo"%>
<%
   String sSelStr = request.getParameter("Str");
   String sSelOrd = request.getParameter("Ord");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SpecOrdLst.jsp&APPL=ALL");
   }
   else
   {
    String sUser = session.getAttribute("USER").toString();

    SpecOrdInfo spcordl = new SpecOrdInfo(sSelStr, sSelOrd, sUser);

    int iNumOfDtl = spcordl.getNumOfDtl();
    String sStr = spcordl.getStr();
    String sOrd = spcordl.getOrd();
    String sOrDate = spcordl.getOrDate();
    String sReg = spcordl.getReg();
    String sTicket = spcordl.getTicket();
    String sType = spcordl.getType();
    String sStatus = spcordl.getStatus();
    String sRevision = spcordl.getRevision();
    String sOrdAmt = spcordl.getOrdAmt();
    String sPONum = spcordl.getPONum();
    String sVenPO = spcordl.getVenPO();
    String sAntDate = spcordl.getAntDate();
    String sCashier = spcordl.getCashier();
    String sOrdTotAmt = spcordl.getOrdTotAmt();
    String sCustId = spcordl.getCustId();
    String sCustName = spcordl.getCustName();
    String sComment = spcordl.getComment();
    String sCashrNm = spcordl.getCashrNm();
    String sVenTot = spcordl.getVenTot();
    String sVenShpAmt = spcordl.getVenShpAmt();
    String sFlag1 = spcordl.getFlag1();
    String sFlag2 = spcordl.getFlag2();
    String sFlag3 = spcordl.getFlag3();
    String sFlag4 = spcordl.getFlag4();
    String sFlag5 = spcordl.getFlag5();
    String sFlag6 = spcordl.getFlag6();
    String sShpCost = spcordl.getShpCost();
    String sGmPrc1 = spcordl.getGmPrc1();
    String sAcknUsr = spcordl.getAcknUsr();
    String sAcknDt = spcordl.getAcknDt();
    String sCost = spcordl.getCost();
    String sVenCostTot = spcordl.getVenCostTot();
    String sItemRet = spcordl.getItemRet();
    String sGmPrc2 = spcordl.getGmPrc2();
    String sGmPrc3 = spcordl.getGmPrc3();
    String sGmPrc4 = spcordl.getGmPrc4();
    String sGmAmt1 = spcordl.getGmAmt1();
    String sGmAmt2 = spcordl.getGmAmt2();
    String sGmAmt3 = spcordl.getGmAmt3();
    String sGmAmt4 = spcordl.getGmAmt4();

    String [] sSeq = spcordl.getSeq();
    String [] sSku = spcordl.getSku();
    String [] sDesc = spcordl.getDesc();
    String [] sQty = spcordl.getQty();
    String [] sRet = spcordl.getRet();
    String [] sActSku = spcordl.getActSku();
    String [] sReqDate = spcordl.getReqDate();
    String [] sFromStr = spcordl.getFromStr();
    String [] sDiv = spcordl.getDiv();
    String [] sCode1 = spcordl.getCode1();
    String [] sDesc1 = spcordl.getDesc1();
    String [] sCode2 = spcordl.getCode2();
    String [] sDesc2 = spcordl.getDesc2();
    String [] sCode3 = spcordl.getCode3();
    String [] sDesc3 = spcordl.getDesc3();
    String [] sSalesperson = spcordl.getSalesperson();
    String [] sAlert = spcordl.getAlert();
    String [] sSlsPerNm = spcordl.getSlsPerNm();

    String [] sStsLst = new String[]{"Open", "PO Plased", "Receited", "Closed", "Cancelled"};
    String sStsNm = "";
    for(int i=0; i < sStsLst.length; i++)
    {
       if(sStatus.equals(sStsLst[i].substring(0, 1)))  { sStsNm = sStsLst[i];  break; }
       else if(sStatus.equals("X"))  { sStsNm = sStsLst[sStsLst.length - 1];  break; }
    }


    String [] sTypeCode = new String[]{"SO", "BSSO", "ST", "BSRO", "SSRO", "RENT"};
    String [] sTypeLst = new String[]{"Special Order", "Bike Shop Special Order", "Special Transfer",
                    "Special Order Requisition Order", "Rent"};
    String sTypeNm = "";
    for(int i=0; i < sStsLst.length; i++)
    {
       if(sType.equals(sTypeCode[i]))  { sTypeNm = sTypeLst[i];  break; }
    }

    String sStrAllowed = session.getAttribute("STORE").toString();
    boolean bAlwApprv = sStrAllowed != null && sStrAllowed.startsWith("ALL");
%>

<html>
<head>
<title>Spec Ord Info</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        
        table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
  	    table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
         
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:white;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#cccfff; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:middle}
        td.DataTable1 {padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:middle}

        div.dvComment { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
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

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelStr = "<%=sSelStr%>"
var SelOrd = "<%=sSelOrd%>"
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
   setBoxclasses(["BoxName",  "BoxClose"], ["dvComment"]);
}

//==============================================================================
// initialize process
//==============================================================================
function setNewCommt()
{
   var hdr = "Enter New Comments";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvComment&#34;);' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popNewCommtPanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvComment.style.width = "250"; }
   else { document.all.dvComment.style.width = "auto"; }
   
   document.all.dvComment.innerHTML = html;
   document.all.dvComment.style.left=getLeftScreenPos() + 250;
   document.all.dvComment.style.top=getTopScreenPos() + 220;
   document.all.dvComment.style.visibility = "visible";
}
//==============================================================================
// populate comments panel
//==============================================================================
function popNewCommtPanel()
{
  var panel = "<table class='tbl02'>"
        + "<tr class='DataTable4'>"
          + "<td class='DataTable1'>"
            + "<textArea name='txaCommt' id='txaCommt'  cols='80' rows='5' maxlength='256'></textArea>"
          + "</td>"
        + "</tr>"

  panel += "<td class='DataTable1'>"
          + "<button id='btnAdd' onClick='ValidateNewCmmt();' class='Small'>Add</button> &nbsp; &nbsp; "
          + "<button onClick='hidePanel(&#34;dvComment&#34;);' class='Small'>Close</button>"
        + "</td>";
  panel += "</table>";
  return panel;
}
//==============================================================================
// Hide Panel
//==============================================================================
function hidePanel(objnm)
{
   document.all[objnm].innerHTML = " ";
   document.all[objnm].style.visibility = "hidden";
}

//==============================================================================
// validate comments
//==============================================================================
function ValidateNewCmmt()
{
   var error=false;
   var msg = "";
   var commt = document.all.txaCommt.value;
   commt = commt.replace(/\n\r?/g, '<br />');
   if(commt.trim() == "") { error=true; msg="\nPlease enter comments."; }

   if(error){ alert(msg); }
   else { sbmAddCommt(commt); }
}
//==============================================================================
// validate comments
//==============================================================================
function sbmAddCommt(commt)
{
	var nwelem = "";
	
    if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
    else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='SpecOrdSave.jsp'>"
       + "<input class='Small' name='Store'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
	  else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
	  else if(isSafari){window.frame1.document.body.appendChild(nwelem);}
	  else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
   {
	   window.frame1.document.all.Store.value = SelStr;	
   	   window.frame1.document.all.Order.value = SelOrd;
       window.frame1.document.all.Commt.value=commt;
       window.frame1.document.all.Action.value="ADD_COMMT";
       window.frame1.document.frmAddComment.submit();
   }
   else
   {
	   window.frame1.contentDocument.forms[0].Store.value = SelStr;	
   	   window.frame1.contentDocument.forms[0].Order.value = SelOrd;
       window.frame1.contentDocument.forms[0].Commt.value=commt;
       window.frame1.contentDocument.forms[0].Action.value="ADD_COMMT";
       window.frame1.contentDocument.forms[0].submit();
   }
   
}

//==============================================================================
// validate comments
//==============================================================================
function setAckn(box)
{
   var url = "SpecOrdSave.jsp?Store=" + SelStr + "&Order=" + SelOrd;
   if(box.checked){ url += "&Action=ADD_ACKNOWLEDGE"; }
   else{ url += "&Action=RMV_ACKNOWLEDGE"; }

   window.frame1.location.href = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvComment" class="dvComment"></div>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>CP POS Order Information
        <br>Store: <%=sStr%>  &nbsp; Order: <%=sOrd%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="SpecOrdLstSel.jsp"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

      <!--a href="javascript: markAll()">Mark All</a -->
  <!----------------------- Order Header -------------------------------------->
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable1">Store</th><td class="DataTable"><%=sStr%></td><th class="DataTable" rowspan=3>&nbsp;</th>
         <th class="DataTable1">Order Date</th><td class="DataTable"><%=sOrDate%></td><th class="DataTable" rowspan=3>&nbsp</th>
         <th class="DataTable1">Customer Id</th><td class="DataTable"><%=sCustId%></td><th class="DataTable" rowspan=3>&nbsp</th>
         <th class="DataTable1">Status</th><td class="DataTable" colspan=2><%=sStsNm%></td>
      </tr>

      <tr class="DataTable">
         <th class="DataTable1">CP Order</th><td class="DataTable"><%=sOrd%></td>
         <th class="DataTable1">IP Order</th><td class="DataTable">&nbsp;<%=sPONum%></td>
         <th class="DataTable1">Customer Name</th><td class="DataTable"><%=sCustName%></td>
         <th class="DataTable1">Order type</th><td class="DataTable" colspan=2><%=sTypeNm%></td>
      </tr>

      <tr class="DataTable">
        <th class="DataTable1">Station/Ticket</th><td class="DataTable"><%=sReg%>/<%=sTicket%> </td>
        <th class="DataTable1">User/Cashier</th><td class="DataTable"><%=sCashrNm%></td>
        <th class="DataTable1">Salesperson</th><td class="DataTable"><%if(sSalesperson.length > 0){%><%=sSlsPerNm[0]%><%}%></td>
        <th class="DataTable1">Vendor PO# Assigned</th><td class="DataTable" colspan=2><%=sVenPO%></td>
      </tr>

      <tr class="DataTable">
        <th class="DataTable1">Comments</th><td class="DataTable" colspan=11><%=sComment%>&nbsp;</td>
      </tr>

      <!-- =============== 2nd table ===================== -->
      <tr class="DataTable"><td class="DataTable" colspan=12>&nbsp;</td></tr>

      <tr class="DataTable">
        <th class="DataTable3" colspan=2>Original Order $ Rung at POS</th>
        <th class="DataTable" rowspan=4>&nbsp;</th>
        <th class="DataTable3" colspan=2>Vendor Cost</th>
        <th class="DataTable" rowspan=4>&nbsp;</th>
        <th class="DataTable3" colspan=2>Actual $ Paid by Customer</th>
        <th class="DataTable" rowspan=4>&nbsp;</th>
        <th class="DataTable3" colspan=3>GM Recap (With Shipping)</th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable1">Part/Items</th><td class="DataTable"><%=sItemRet%></td>
        <th class="DataTable1">Part/Items</th><td class="DataTable">
           <%if(!sCost.equals(".00")){%><%=sCost%><%} else {%><%=sVenTot%><%}%>
        </td>
        <th class="DataTable1">Part/Items</th><td class="DataTable">
          <%if(sOrdAmt.equals(sOrdTotAmt)){%><%=sItemRet%><%} else {%>&nbsp; -<%}%>
        </td>
        <th class="DataTable" rowspan=3>Vendor Cost<br>vs.<br>Original Order $</th>
            <th class="DataTable">GM $</th>
            <th class="DataTable">GM %</th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable1">Shipping</th><td class="DataTable"><%=sShpCost%></td>
        <th class="DataTable1">Shipping Cost</th><td class="DataTable"><%=sVenShpAmt%></td>
        <th class="DataTable1">Shipping</th><td class="DataTable">
          <%if(sOrdAmt.equals(sOrdTotAmt)){%><%=sShpCost%><%} else {%>&nbsp; -<%}%>
        </td>
        <td class="DataTable" rowspan=2>&nbsp;<%if(!sGmPrc1.equals("100") && !sGmPrc1.equals("0")){%>$<%=sGmAmt1%><%}%></td>
        <td class="DataTable" rowspan=2>&nbsp;<%if(!sGmPrc1.equals("100") && !sGmPrc1.equals("0")){%><%=sGmPrc1%>%<%}%></td>
      </tr>

      <tr class="DataTable">
        <th class="DataTable1">Total</th><td class="DataTable"><%=sOrdTotAmt%></td>
        <th class="DataTable1">Total</th><td class="DataTable">
           <%if(!sVenCostTot.equals(".00")){%><%=sVenCostTot%><%} else {%><%=sVenTot%><%}%>
        </td>

        <th class="DataTable1">Total</th><td class="DataTable">
          <%if(sOrdAmt.equals(sOrdTotAmt)){%><%=sOrdTotAmt%><%} else {%>&nbsp; -<%}%>
        </td>
      </tr>

      <tr class="DataTable">
        <td class="DataTable1" colspan=9 rowspan=7>&nbsp;</td>
        <th class="DataTable" rowspan=2>Vendor Cost<br>vs.<br>Actual $ Paid by Customer</th>
            <th class="DataTable">GM $</th>
            <th class="DataTable">GM %</th>
        </tr>
      <tr class="DataTable">
         <td class="DataTable">&nbsp;<%if(!sGmPrc2.equals("100")){%>$<%=sGmAmt2%><%}%></td>
         <td class="DataTable">&nbsp;<%if(!sGmPrc2.equals("100")){%><%=sGmPrc2%>%<%}%></td>
      </tr>

      <tr class="DataTable">
          <th class="DataTable3" colspan=3>GM Recap (Without Shipping)</th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable" rowspan=2>Vendor Cost<br>vs.<br>Original Order $</th>
            <th class="DataTable">GM $</th>
            <th class="DataTable">GM %</th>
      </tr>

      <tr class="DataTable">
          <td class="DataTable">&nbsp;<%if(!sGmPrc3.equals("100")){%>$<%=sGmAmt3%><%}%></td>
          <td class="DataTable">&nbsp;<%if(!sGmPrc3.equals("100")){%><%=sGmPrc3%>%<%}%></td>
      </tr>

      <tr class="DataTable">
        <th class="DataTable" rowspan=2>Vendor Cost<br>vs.<br>Actual $ Paid by Customer</th>
            <th class="DataTable">GM $</th>
            <th class="DataTable">GM %</th>
      </tr>

      <tr class="DataTable">
         <td class="DataTable">&nbsp;<%if(!sGmPrc4.equals("100")){%>$<%=sGmAmt4%><%}%></td>
         <td class="DataTable">&nbsp;<%if(!sGmPrc4.equals("100")){%><%=sGmPrc4%>%<%}%></td>
      </tr>

    </table>

    <!--tr class="DataTable">
        <th class="DataTable1">&nbsp;</th><td class="DataTable">&nbsp;</td>
        <th class="DataTable1">&nbsp;</th><td class="DataTable">&nbsp;</td>
        <th class="DataTable1">GM%</th><td class="DataTable">&nbsp;<%if(!sGmPrc1.equals("100") && !sGmPrc1.equals("0")){%><%=sGmPrc1%>%<%}%></td>
      </tr -->

    <br><br>
    <b><u>Issue Flags</u></b>
    <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
        <tr class="DataTable">
          <th class="DataTable">Cancelled</th>
          <th class="DataTable">No Shipping Charged</th>
          <th class="DataTable">GM% < 40.0</th>
          <th class="DataTable">100% Discount</th>
        </tr>
        <tr class="DataTable">
          <td class="DataTable1">&nbsp;<%=sFlag1%></td>
          <td class="DataTable1">&nbsp;<%=sFlag2%></td>
          <td class="DataTable1">&nbsp;<%=sFlag3%></td>
          <td class="DataTable1">&nbsp;<%=sFlag4%></td>
        </tr>
    </table>
    <br><br>
<b><u>Item List</u></b>
      <!----------------------- Order Header -------------------------------------->
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable1">
         <th class="DataTable2">Item</th>
         <th class="DataTable2">Div</th>
         <th class="DataTable2">Required<br>Date</th>
         <th class="DataTable2">From<br>Store</th>

         <th class="DataTable2">Description</th>
         <th class="DataTable2">Qty</th>
         <th class="DataTable2">Sold For</th>
         <th class="DataTable2">Prompt 1</th>
         <th class="DataTable2">Prompt 2</th>
         <th class="DataTable2">Prompt 3</th>
         <th class="DataTable2">Reason<br>(Not ordered)</th>
      </tr>
      <%for(int i=0; i < iNumOfDtl; i++){%>
        <tr class="DataTable">
           <td class="DataTable"><%=sSku[i]%></td>
           <td class="DataTable1">&nbsp;<%=sDiv[i]%></td>
           <td class="DataTable">&nbsp;<%=sReqDate[i]%></td>
           <td class="DataTable">&nbsp;<%=sFromStr[i]%></td>
           <!--td class="DataTable">&nbsp;<%=sCode2[i]%>
              <%if(!sCode3[i].equals("")){%><br><%=sCode3[i]%><%}%>
           </td -->
           <td class="DataTable"><%=sDesc[i]%></td>
           <td class="DataTable1">&nbsp;<%=sQty[i]%></td>
           <td class="DataTable1">&nbsp;<%=sRet[i]%></td>
           <td class="DataTable"><%=sCode1[i]%>&nbsp;<%=sDesc1[i]%></td>
           <td class="DataTable"><%=sCode2[i]%>&nbsp;<%=sDesc2[i]%></td>
           <td class="DataTable"><%=sCode3[i]%>&nbsp;<%=sDesc3[i]%></td>
           <td class="DataTable" style="color:red"><%=sAlert[i]%>&nbsp;</td>
        </tr>
      <%}%>
     </table>

  <!----------------------- end of table ------------------------>
  <br>
  <%if(bAlwApprv){%>
     <input type="checkbox" id="AcknFlag" value="Y" <%if(!sAcknUsr.equals("")){%>checked<%}%>
       onclick="setAckn(this)"> Comments Approved
       &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <%}%>
  <button class="Small" onclick="setNewCommt()">New Comments</button>
  <!----------------------- Comments -------------------------------------->
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable2">
         <th class="DataTable2" width="5%" rowspan=2>Type</th>
         <th class="DataTable2" rowspan=2>Comments</th>
         <th class="DataTable2" width="20%" colspan=3>Created</th>
      </tr>
      <tr class="DataTable2">
         <th class="DataTable2">User</th>
         <th class="DataTable2">Entered Date</th>
         <th class="DataTable2">Entered Date</th>
      </tr>

      <%while(spcordl.getNextComment()){
         spcordl.setComments();
         String sCmtType = spcordl.getCmtType();
         String sText = spcordl.getText();
         String sCmtUser = spcordl.getUser();
         String sDate = spcordl.getDate();
         String sTime = spcordl.getTime();
      %>
        <tr class="DataTable">
           <td class="DataTable1"><%=sCmtType%></td>
           <td class="DataTable"><%=sText%></td>
           <td class="DataTable1"><%=sCmtUser%></td>
           <td class="DataTable1"><%=sDate%></td>
           <td class="DataTable1"><%=sTime%></td>
        </tr>
      <%}%>
     </table>

     </td>
   </tr>
   <tr>
     <td><br>

  </table>
 </body>
</html>
<%
    spcordl.disconnect();
    spcordl = null;
%>
<%}%>