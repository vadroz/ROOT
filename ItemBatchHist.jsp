<!DOCTYPE html>	
<%@ page import="itemtransfer.ItemBatchHist, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sBatch = request.getParameter("Batch");
   String sBatchNm = request.getParameter("BName");
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "ITEM"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=ItemBatchHist.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	ItemBatchHist itmtrans = new ItemBatchHist(sBatch, sSort, sUser);
	int iNumOfItm = itmtrans.getNumOfItm();     
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Item Return</title>

<!-- >script src="https://code.jquery.com/jquery-1.11.1.min.js"></script -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<SCRIPT>

//--------------- Global variables -----------------------
var Batch = "<%=sBatch%>";
var Detail = true;
var NumOfItm = "<%=iNumOfItm%>";
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
//==============================================================================
// show details
//==============================================================================
function showDtl()
{
	 var disp = "none";
	 if(Detail){ disp = "table-row"; }
	 for(var i=0; i < NumOfItm; i++)
	 {
		 	 
		 var flag = "tdTotFlg" + i;
		 var tot = document.all[flag].value;
		 if(tot != 'Y')
		 {
		 	var row = "trItm" + i;	
		 	document.all[row].style.display = disp;
		 }
	 }
	 Detail = !Detail;
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <br><br><br><br>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45 align=center>
            <b>Retail Concepts, Inc
            <br>Transfer Batch Activity in Stores
            <br>Batch: <%=sBatch%> - <%=sBatchNm%>
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="ItemBatchHistSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp; 
              <a href="javascript: showDtl();">Fold/Unfold Details</a>                                       
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">           
          <th class="th02" rowspan=2>Iss<br>Str</th>
          <th class="th02" rowspan=2 >Dest<br>Str</th>
          <th class="th02" rowspan=2 >Long Item Number</th>
          <th class="th02" rowspan=2 >Desc</th>          
          <th class="th02" rowspan=2 >Trans<br>Qty</th>
          <th class="th02" rowspan=2 >Sent<br>Qty</th>          
          <th class="th02" rowspan=2 >Sts</th>
          <th class="th02" rowspan=2 >Printed<br>User, Date</th>
          <th class="th02" rowspan=2 >Completed<br>User Date Type</th>   
          <th class="th02" colspan=5>Distribution Status</th>
          <th class="th02" rowspan=2>Xfer %</th>
        </tr>
        <tr class="trHdr01">           
          <th class="th02">Distro #</th>
          <th class="th02">Iss Str<br>Sent Date</th>
          <th class="th02">Current<br>Status</th>
          <th class="th02">Dest Str<br>Recv  Date</th>
          <th class="th02">Total<br>Qty</th>
        </tr>  
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06";  
             String sTrHide = "";
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfItm; i++) {        	   
        	   itmtrans.setItemLst();
               String sCls  = itmtrans.getCls();
               String sVen  = itmtrans.getVen();
               String sSty  = itmtrans.getSty();
               String sClr  = itmtrans.getClr();
               String sSiz  = itmtrans.getSiz();
               String sIssStr  = itmtrans.getIssStr();
               String sDestStr  = itmtrans.getDestStr();
               String sTrfQty  = itmtrans.getTrfQty();
               String sSts  = itmtrans.getSts();
               
               String sPrintBy  = itmtrans.getPrintBy();
               String sPrintDt  = itmtrans.getPrintDt();
               String sPrint = " "; 
               if(!sPrintDt.equals("01/01/0001")){sPrint = sPrintBy + ", " + sPrintDt;}               
               
               String sCompBy  = itmtrans.getCompBy();
               String sCompDt  = itmtrans.getCompDt();
               
               
               String sCompTy  = itmtrans.getCompTy();
               String sSntQty  = itmtrans.getSntQty();
               String sDesc  = itmtrans.getDesc();
               String sTotFlag  = itmtrans.getTotFlag();
               
               String sStsNm = "Sent";           
               String sCompTyNm = "";
               if(sCompTy.equals("A")){ sCompTyNm = "ALL"; }
               else if(sCompTy.equals("N")){ sCompTyNm = "None"; }
               else if(sCompTy.equals("S")){ sCompTyNm = "Some"; }
               
               String sComp = " "; 
               if(!sCompDt.equals("01/01/0001")){sComp = sCompBy + ", " + sCompDt + ", " + sCompTyNm;}
                              
               if(sTotFlag.equals("Y"))
               { 
            	   sTrCls = "trDtl15";
            	   sTrHide = "";
               }
               else 
               { 
            	   sTrCls = "trDtl06";            	   
            	   sTrHide = "style=\"display:none;\"";
               }
               
           %>
                <tr id="trItm<%=i%>" class="<%=sTrCls%>" <%=sTrHide%>>                 
                <td class="td11" nowrap><%=sIssStr%>
                	<input type="hidden" name="tdTotFlg<%=i%>" value="<%=sTotFlag%>">
                </td>
                <td class="td11" nowrap><%=sDestStr%></td>
                <td class="td11" nowrap><%if(!sTotFlag.equals("Y")){%><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%><%} %> &nbsp;</td>
                <td class="td11" nowrap><%=sDesc%></td>                
                <td class="td11" nowrap><%=sTrfQty%></td>
                <td class="td11" nowrap><%=sSntQty%></td>
                <td class="td11" nowrap><%=sStsNm%></td>
                <td class="td11" nowrap><%=sPrint%></td>
                <td class="td11" nowrap><%=sComp%></td>  
                
                <%
                itmtrans.setPndDstLst();
                int iNumOfDst = itmtrans.getNumOfDst();
                String [] sPnDst = itmtrans.getPnDst();
                String [] sPnDstDt = itmtrans.getPnDstDt();
                String [] sPnSts = itmtrans.getPnSts();
                String [] sPnStsNm = itmtrans.getPnStsNm();
                String [] sPnStsDt = itmtrans.getPnStsDt();
                String [] sPnQty = itmtrans.getPnQty();
                String sPnTotQty = itmtrans.getPnTotQty();
                String sPnCompl = itmtrans.getPnCompl();                
                %>                
                <td class="td11" nowrap>
                   <%String sbr=""; for(int j=0; j < iNumOfDst; j++){%><%=sbr + sPnDst[j]%> <%sbr="<br>";}%>
                </td>
                <td class="td11" nowrap>
                   <%sbr=""; for(int j=0; j < iNumOfDst; j++){%><%=sbr + sPnDstDt[j]%> <%sbr="<br>";}%>
                </td>
                <td class="td11" nowrap>
                   <%sbr=""; for(int j=0; j < iNumOfDst; j++){%><%=sbr + sPnStsNm[j]%> <%sbr="<br>";}%>
                </td>
                <td class="td11" nowrap>
                   <%sbr=""; for(int j=0; j < iNumOfDst; j++){%><%=sbr + sPnStsDt[j]%> <%sbr="<br>";}%>
                </td>                
                <td class="td12" nowrap><%=sPnTotQty%></td>
                <td class="td12" style="background: #b0edaf" nowrap>
                   <%if(!sPnCompl.equals("")){%><%=sPnCompl%>%<%} %>
                </td>
              </tr>
           <%}%>           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   <!-- ==================================================== -->
   <p>
   <br><br><div id="dvLog"></div >
   <!-- ==================================================== -->
   
 </body>
</html>
<%
itmtrans.disconnect();
itmtrans = null;
}
%>