<%@ page import="patiosales.OrderIPComp ,java.util.*, java.text.*"%>
<%
   String [] sStatus = request.getParameterValues("Status");
   String sInclSO = request.getParameter("InclSO");
   String [] sSoStatus = request.getParameterValues("SoStatus");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sRRN = request.getParameter("RRN");
   String sSort = request.getParameter("Sort");

   if(sRRN==null) sRRN="0000000000";
   if(sSort==null) sSort="REMDT";
   if(sStatus == null) sStatus = new String[]{" "};
   if(sSoStatus == null) sSoStatus = new String[]{" "};
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderIPComp.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      OrderIPComp ordlst = new OrderIPComp(sStatus, sInclSO, sSoStatus, sFrom, sTo, sRRN, sSort,
                                 session.getAttribute("USER").toString());
      int iNumOfOrd = ordlst.getNumOfOrd();

      String sStatusJsa = ordlst.cvtToJavaScriptArray(sStatus);
      String sSoStatusJsa = ordlst.cvtToJavaScriptArray(sSoStatus);

      String sUser = session.getAttribute("USER").toString();
      boolean bSts = true;
      if  (sUser.trim().equals("cashr35") || sUser.trim().equals("cashr46")
       ||  sUser.trim().equals("cashr50")) bSts = false;

%>

<html>
<head>
<title>Patio_Furniture_Trial_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable0 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: MistyRose ; font-family:Arial; font-size:10px }
        tr.Divider { background:darkred; font-family:Arial; font-size:1px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

         td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:left;}
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Status = [<%=sStatusJsa%>]
var SoStatus = [<%=sSoStatusJsa%>]
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// show screen with different sorting
//==============================================================================
function sortBy(sort)
{
  var url = "OrderIPComp.jsp?From=<%=sFrom%>&To=<%=sTo%>"
  for(var i=0; i < Status.length; i++)
  {
     url += "&Status=" + Status[i];
  }
  for(var i=0; i < SoStatus.length; i++)
  {
     url += "&SoStatus=" + SoStatus[i];
  }
  url += "&InclSO=<%=sInclSO%>" + "&Sort=" + sort;

  //alert(url);
  window.location.href=url;
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Patio Furniture Sales Order List </b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="OrderIPCompSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable" nowrap rowspan=2>Str</th>
        <th class="DataTable" nowrap colspan=13>Patio Furniture Order Information</th>
        <th class="DataTable" nowrap rowspan=2>&nbsp;</th>
        <th class="DataTable" nowrap rowspan=2>S<br>l<br>s</th>
        <th class="DataTable" nowrap colspan=4>Island Pacific Information</th>
        <th class="DataTable" nowrap rowspan=2>Description</th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable" nowrap>Order<br>#</th>
        <th class="DataTable" nowrap>Status</th>
        <th class="DataTable" nowrap>Spec.Order<br>Status</th>
        <th class="DataTable" nowrap>Total<br>Qty</th>
        <th class="DataTable" nowrap>Sub-Total<br>Price</th>
        <th class="DataTable" nowrap>Tax</th>
        <th class="DataTable" nowrap>Total<br>Price</th>

        <th class="DataTable" nowrap>SKU</th>
        <th class="DataTable" nowrap>Reg<br>#</th>
        <th class="DataTable" nowrap>Trans<br>#</th>
        <th class="DataTable" nowrap>Vendor<br>Style</th>
        <th class="DataTable" nowrap>Item<br>Qty</th>
        <th class="DataTable" nowrap>Item<br>Retail</th>

        <th class="DataTable" nowrap>Total<br>Qty</th>
        <th class="DataTable" nowrap>Sub-Total<br>Price</th>
        <th class="DataTable" nowrap>Item<br>Qty</th>
        <th class="DataTable" nowrap>Item<br>Retail</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
  <%for(int i=0; i < iNumOfOrd; i++) {%>
    <%
      ordlst.setOrdCompInfo();

      String sOrdNum = ordlst.getOrdNum();
      String sSts = ordlst.getSts();
      String sStsName = ordlst.getStsName();
      String sSoSts = ordlst.getSoSts();
      String sSoStsName = ordlst.getSoStsName();
      String sOrdTotQty = ordlst.getOrdTotQty();
      String sOrdTotRet = ordlst.getOrdTotRet();
      String sOrdTax = ordlst.getOrdTax();
      String sOrdTotal = ordlst.getOrdTotal();

      int iOrdMax = ordlst.getOrdMax();
      String [] sOrdSku = ordlst.getOrdSku();
      String [] sOrdReg = ordlst.getOrdReg();
      String [] sOrdTran = ordlst.getOrdTran();
      String [] sOrdVenSty = ordlst.getOrdVenSty();
      String [] sOrdQty = ordlst.getOrdQty();
      String [] sOrdRet = ordlst.getOrdRet();

      String sIpeTotQty = ordlst.getIpeTotQty();
      String sIpeTotRet = ordlst.getIpeTotRet();
      //int iIpeMax = ordlst.getIpeMax();
      String [] sIpeQty = ordlst.getIpeQty();
      String [] sIpeRet = ordlst.getIpeRet();

      String [] sDesc = ordlst.getDesc();
      String sStr = ordlst.getStr();
      String [] sUnmatch = ordlst.getUnmatch();
      String sOrdSpo = ordlst.getOrdSpo();
%>
        <tr  class="DataTable<%=sUnmatch[0].trim()%>">
            <td class="DataTable2" rowspan=<%=iOrdMax%>><%=sStr%></td>
            <td class="DataTable" rowspan=<%=iOrdMax%> nowrap><a target="_blank" href="OrderEntry.jsp?Order=<%=sOrdNum%>&List=Y"><%=sOrdNum%></a>
              <%if(sOrdSpo.equals("1")){%><sup style="color:red">spo</sup><%}%>
            </td>
            <td class="DataTable2" nowrap rowspan=<%=iOrdMax%>><%=sStsName%></td>
            <td class="DataTable2" nowrap rowspan=<%=iOrdMax%>><%=sSoStsName%></td>
            <td class="DataTable2" rowspan=<%=iOrdMax%>><%=sOrdTotQty%></td>
            <td class="DataTable2" rowspan=<%=iOrdMax%>><%=sOrdTotRet%></td>
            <td class="DataTable2" rowspan=<%=iOrdMax%>><%=sOrdTax%></td>
            <td class="DataTable2" rowspan=<%=iOrdMax%>><%=sOrdTotal%></td>

            <td class="DataTable2"><%=sOrdSku[0]%></td>
            <td class="DataTable2"><%=sOrdReg[0]%></td>
            <td class="DataTable2"><%=sOrdTran[0]%></td>
            <td class="DataTable" nowrap><%=sOrdVenSty[0]%></td>
            <td class="DataTable2"><%=sOrdQty[0]%></td>
            <td class="DataTable2"><%=sOrdRet[0]%></td>

            <th class="DataTable" nowrap rowspan=<%=iOrdMax%>>&nbsp;</th>
            <th class="DataTable" nowrap rowspan=<%=iOrdMax%>><a href="OrderIPLst.jsp?Order=<%=sOrdNum%>" target="_blank">S</a></th>

            <%if(!sUnmatch[0].equals("1")){%>
               <td class="DataTable2" nowrap rowspan=<%=iOrdMax%>><%=sIpeTotQty%></td>
               <td class="DataTable2" nowrap rowspan=<%=iOrdMax%>><%=sIpeTotRet%></td>
               <td class="DataTable2" nowrap><%=sIpeQty[0]%></td>
               <td class="DataTable2" nowrap><%=sIpeRet[0]%></td>
            <%}
              else {%>
                <td class="DataTable2"  rowspan=<%=iOrdMax%> colspan=2></td>
                <td class="DataTable2"></td>
               <td class="DataTable2"></td>
            <%}%>
            <td class="DataTable"><%=sDesc[0]%></td>
        </tr>
        <%for(int j=1; j < iOrdMax; j++){%>
           <tr class="DataTable<%=sUnmatch[j]%>">
               <td class="DataTable2"><%=sOrdSku[j]%></td>
               <td class="DataTable2"><%=sOrdReg[j]%></td>
               <td class="DataTable2"><%=sOrdTran[j]%></td>
               <td class="DataTable" nowrap><%=sOrdVenSty[j]%></td>
               <td class="DataTable2"><%=sOrdQty[j]%></td>
               <td class="DataTable2"><%=sOrdRet[j]%></td>
               <%if(!sUnmatch[0].equals("1")){%>
                  <td class="DataTable2" nowrap><%=sIpeQty[j]%></td>
                  <td class="DataTable2" nowrap><%=sIpeRet[j]%></td>
               <%}
               else {%>
                  <td class="DataTable2" colspan=2></td>
              <%}%>
              <td class="DataTable"><%=sDesc[j]%></td>
           </tr>
        <%}%>
        <tr class="Divider"><td class="Divider">&nbsp;</td></tr>
      <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
        <button onclick="history.go(-1)">Back</button>
     </td>
   </tr>

  </table>
 </body>
</html>
<%
   ordlst.disconnect();
}%>