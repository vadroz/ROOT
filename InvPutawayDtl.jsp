<!DOCTYPE html>	
<%@ page import="inventoryreports.InvPutawayDtl, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelSrc = request.getParameter("Src");
   String sSelDesc = request.getParameter("Desc");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=InvPutawayDtl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	InvPutawayDtl invputawy = new InvPutawayDtl();
	invputawy.setInvSum(sSelSrc);
	int iNumOfInv = invputawy.getNumOfInv();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Putaway Details</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelSrc = "<%=sSelSrc%>";
var SelDesc = "<%=sSelDesc%>";
var NumOfInv = "<%=iNumOfInv%>"
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
    
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
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Putaway Stock Detail Report 
            <br><%=sSelDesc%>          
            </b>                                    
          </th>
        </tr>
        <tr>
          <td>
             <a href="../"><font color="red" size="-1">Home</font></a>&#62;
      		 <font size="-1">This Page</font>   
      		 
      <table class="tbl02">
        <tr class="trHdr01">           
          <th class="th02" rowspan=2>Item Number</th>
          <th class="th02" rowspan=2>Short SKU</th>
          <th class="th02" rowspan=2>UPC</th>
          <th class="th02" rowspan=2>Description</th>
          <th class="th02" rowspan=2>Vendor<br>Style</th>
          <th class="th02" rowspan=2>Vendor<br>Name</th>          
          <th class="th02" rowspan=2>Color</th>
          <th class="th02" rowspan=2>Size</th>
          <th class="th02" rowspan=2>Activity<br>Date</th>
          <th class="th02" rowspan=2>Qty<br>Recv</th>
          <th class="th02" rowspan=2>Pend<br>Qty</th>
          <th class="th02" rowspan=2>DC<br>Qty</th>
          <th class="th02" rowspan=2>101<br>Qty</th> 
          <th class="th02" colspan=5>Warehouse Activity</th> 
        </tr>
        <tr class="trHdr01">
          <th class="th02">Location</th>
          <th class="th02">Bin</th>
          <th class="th02">Act.<br>Qty</th>
          <th class="th02">Rema</th>
          <th class="th02">User</th>  
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%
             String sTrCls = "trDtl06";
             String sSvCls = null;
             String sSvVen = null;
             String sSvSty = null;
             String sSvClr = null;
             String sSvSiz = null;
           %>
         <%for(int i=0; i < iNumOfInv; i++) {        	   
        	invputawy.setDetail();   			  
        	String sCls = invputawy.getCls();
			String sVen = invputawy.getVen();
			String sSty = invputawy.getSty();			
			String sClr = invputawy.getClr();
			String sSiz = invputawy.getSiz();
			String sDate = invputawy.getDate();
			String sQtyIn = invputawy.getQtyIn();
			String sQty = invputawy.getQty();
			String sCost = invputawy.getCost();
			String sRet = invputawy.getRet();
			String sVenSty = invputawy.getVenSty();
			String sVenNm = invputawy.getVenNm();
			String sRow = invputawy.getRow();
			String sSec = invputawy.getSec();
			String sLevel = invputawy.getLevel();
			String sBin = invputawy.getBin();
			String sLogQty = invputawy.getLogQty();
			String sBal = invputawy.getBal();
			String sRcdUser = invputawy.getUser();
			String sWhs001Qty = invputawy.getWhs001Qty();
			String sWhs101Qty = invputawy.getWhs101Qty();
			String sClrNm = invputawy.getClrNm();
			String sSizNm = invputawy.getSizNm();
			String sDesc = invputawy.getDesc();	
			String sPoNum = invputawy.getPoNum();
			String sSku = invputawy.getSku();
			String sUpd = invputawy.getUpd();
			
			boolean bNew = false;
			if(i==0 || !sSvCls.equals(sCls) || !sSvVen.equals(sVen) || !sSvSty.equals(sSty) 
					|| !sSvClr.equals(sClr) || !sSvSiz.equals(sSiz))
			{
				bNew = true;
				sSvCls = sCls;
	            sSvVen = sVen;
	            sSvSty = sSty;
	            sSvClr = sClr;
	            sSvSiz = sSiz;
	            
	            if(sTrCls.equals("trDtl06")){ sTrCls = "trDtl04"; }
				else{ sTrCls = "trDtl06"; }
			}
           %>                           
             <tr id="trInv<%=i%>" class="<%=sTrCls%>">
                <td class="td11" nowrap>
                  <%if(bNew){%><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%><%}%>
                </td>
                <td class="td11" nowrap><%if(bNew){%><%=sSku%><%} %></td>
                <td class="td11" nowrap><%if(bNew){%><%=sUpd%><%} %></td>
                <td class="td11" nowrap><%if(bNew){%><%=sDesc%><%} %></td>
                <td class="td11" nowrap><%if(bNew){%><%=sVenSty%><%}%></td>
                <td class="td11" nowrap><%if(bNew){%><%=sVenNm%><%} %></td>
                <td class="td11" nowrap><%if(bNew){%><%=sClrNm%><%} %></td>
                <td class="td11" nowrap><%if(bNew){%><%=sSizNm%><%} %></td>    
                <td class="td12" nowrap><%=sDate%></td>
                <td class="td12" nowrap><%=sQtyIn%></td>
                <td class="td12" nowrap><%=sQty%></td>
                <td class="td12" nowrap><%if(bNew){%><%=sWhs001Qty%><%}%></td>
                <td class="td12" nowrap><%if(bNew){%><%=sWhs101Qty%><%}%></td>                 
                <td class="td11" nowrap><%=sRow%>-<%=sSec%>-<%=sLevel%></td>
                <td class="td11" nowrap><%=sBin%></td>
                <td class="td12" nowrap><%=sLogQty%></td>
                <td class="td12" nowrap><%=sBal%></td>
                <td class="td11" nowrap><%=sRcdUser%></td>
                            
              </tr>
              <script></script>	
           <%}%>
           
           <!-- ==============Total Line  -->
           
           <!-- tr id="trTotal" class="Divider">
               <td class="td18" colspan=25>&nbsp;</td>
           </tr>     
           
            
           <tr id="trTotal" class="Divider">
               <td class="td18" colspan=25>&nbsp;</td>
           </tr -->  
           
           <%
           	invputawy.setRepTot();
   			String sQtyIn = invputawy.getQtyIn();
   			String sQty = invputawy.getQty();
   			String sCost = invputawy.getCost();
   			String sRet = invputawy.getRet(); 
           %>
           
           <!-- tr id="trTotal" class="trDtl03">
                <td class="td11" colspan=3>Report Total</td>
                <td class="td18" colspan=3></td>
                <td class="td12" nowrap><%=sQtyIn%></td>
                <td class="td12" nowrap><%=sQty%></td>
           </tr -->
         </table>
         <br>&nbsp;<br>&nbsp;<br>&nbsp;
      <!----------------------- end of table ------------------------>
      </tr>
   </table>   
 </body>
</html>
<%
invputawy.disconnect();
invputawy = null;
}
%>