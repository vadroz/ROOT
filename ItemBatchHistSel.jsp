<!DOCTYPE HTML > 
<%@ page import="itemtransfer.ItemTrfBachList, java.util.*, java.text.*"%>
<%
   	String sSort = request.getParameter("Sort");
   	if(sSort == null || sSort.equals("")){ sSort = "Batch"; }
	
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("TRANSFER") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemBatchHistSel.jsp&APPL=TRANSFER");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Transfer Batch Activity</title>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>


<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
 

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{

  setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
// set Batch Number selection menu
//==============================================================================
function rtvBatchNumber()
{
   var url = "ItemTrfBachList.jsp?Sts=O"

   //alert(url);
   //window.location.href = url;
   window.frame2.location = url;
}
//==============================================================================
//delete Batch number and Items belong to batch
//==============================================================================
function getBatch(batch, name)
{
	var url = "ItemBatchHist.jsp?Batch=" + batch + "&BName=" + name;
	window.location.href = url;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// display hide records 
//==============================================================================
function dispGrp(grp, chkbox)
{
	var disp = "none";
	if(chkbox.checked){ disp = "table-row-group"; }
	document.all[grp].style.display = disp;
}
//==============================================================================
//display hide records 
//==============================================================================
function resort(sort)
{
	var url = "ItemBatchHistSel.jsp?Sort=" + sort;
	window.location.href = url;
}

</script>


<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>



<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<iframe id="frame2" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo1.jpg"></TD></TR> 
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Transfer Batch Activity in Store - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
        &nbsp; <input type="checkbox" name="chbSent" checked onclick="dispGrp('tbdSent', this)">Sent &nbsp; &nbsp;  
        &nbsp; <input type="checkbox" name="chbAppr" checked onclick="dispGrp('tbdAppr', this)">Approved &nbsp; &nbsp;
        &nbsp; <input type="checkbox" name="chbInTrans" checked onclick="dispGrp('tbdIntrans', this)">In-transit &nbsp; &nbsp;

      <table class="tbl02">
        <tr>
          <th class="th02" rowspan=2><a href="javascript: resort('Batch')">Batch #</a></th>
          <th class="th02" rowspan=2><a href="javascript: resort('Div')">Div</a></th>
          <th class="th02" rowspan=2>Comment</th>
          <th class="th02" colspan=2>Creation</th> 
          <th class="th02" colspan=2>Approve</th>
          <th class="th02" rowspan=2>Warehouse</th>
          <th class="th02" rowspan=2>Req<br>Qty</th>
          <th class="th02" rowspan=2>Distro<br>Qty</th>
          <th class="th02" rowspan=2>Xfer<br>%</th>
        </tr>
        <tr>
        	<th class="th02"><a href="javascript: resort('User')">User</a></th>
        	<th class="th02"><a href="javascript: resort('Date')">Date</a></th>
        	<th class="th02"><a href="javascript: resort('ApprUs')">User</a></th>
        	<th class="th02"><a href="javascript: resort('ApprDt')">Date</a></th>
        </tr>
        
        <tbody id="tbdSent">        
        <tr>
          <th class="th02" colspan=11>Sent</th>
        </tr>
       <%            
        	ItemTrfBachList itrfbatch = new ItemTrfBachList("S", sSort, sUser);
        	int iNumOfBch = itrfbatch.getNumOfBch();
        	String [] sOpnBatch = itrfbatch.getBatch();
        	String [] sOpnBComment = itrfbatch.getBComment();
        	String [] sOpnBCrtDate = itrfbatch.getBCrtDate();
        	String [] sOpnBCrtByUser = itrfbatch.getBCrtByUser();
        	String [] sOpnBWrhse = itrfbatch.getBWrhse();
        	String [] sOpnApprDt = itrfbatch.getApprDt();
        	String [] sOpnApprUs = itrfbatch.getApprUs();
        	String [] sDivLst = itrfbatch.getDivLst();
        	String [] sTrnQty = itrfbatch.getTrnQty();
        	String [] sPndQty = itrfbatch.getPndQty();
        	String [] sXferPrc = itrfbatch.getXferPrc();
        %>
        <%for(int i=0; i < iNumOfBch;i++){%>
          <tr id="trId" class="trDtl06">
        	<td class="td11" nowrap><a href="javascript: getBatch('<%=sOpnBatch[i]%>','<%=sOpnBComment[i]%>');"><%=sOpnBatch[i]%></a></td>
        	<td class="td11" nowrap><%=sDivLst[i]%></td>
        	<td class="td11" nowrap><%=sOpnBComment[i]%></td>
        	<td class="td11" nowrap><%=sOpnBCrtByUser[i]%></td>
        	<td class="td11" nowrap><%=sOpnBCrtDate[i]%></td>        	
        	<td class="td11" nowrap><%=sOpnApprUs[i]%></td>
        	<td class="td11" nowrap><%=sOpnApprDt[i]%></td>
        	<td class="td18" nowrap><%=sOpnBWrhse[i]%></td>
        	<td class="td12" nowrap><%=sTrnQty[i]%></td>
        	<td class="td12" nowrap><%=sPndQty[i]%></td>
        	<td class="td12" style="background: #b0edaf" nowrap><%=sXferPrc[i]%>%</td>
          </tr>
        <%}%>
        </tbody>
        
        <!-- ============== Approved ====================== -->
        <tbody id="tbdAppr">
        <tr>
          <th class="th02" colspan=8>Approved</th>
        </tr>  
        <%            
        	itrfbatch = new ItemTrfBachList("A", sSort, sUser);
        	iNumOfBch = itrfbatch.getNumOfBch();
        	sOpnBatch = itrfbatch.getBatch();
        	sOpnBComment = itrfbatch.getBComment();
        	sOpnBCrtDate = itrfbatch.getBCrtDate();
        	sOpnBCrtByUser = itrfbatch.getBCrtByUser();
        	sOpnBWrhse = itrfbatch.getBWrhse();   
        	sOpnApprDt = itrfbatch.getApprDt();
        	sOpnApprUs = itrfbatch.getApprUs(); 
        	sDivLst = itrfbatch.getDivLst();
        %>
        <%for(int i=0; i < iNumOfBch;i++){%>
          <tr id="trId" class="trDtl06">
        	<td class="td11" nowrap><a href="javascript: getBatch('<%=sOpnBatch[i]%>','<%=sOpnBComment[i]%>');"><%=sOpnBatch[i]%></a></td>
        	<td class="td11" nowrap><%=sDivLst[i]%></td>
        	<td class="td11" nowrap><%=sOpnBComment[i]%></td>
        	<td class="td11" nowrap><%=sOpnBCrtByUser[i]%></td>
        	<td class="td11" nowrap><%=sOpnBCrtDate[i]%></td>        	
        	<td class="td11" nowrap><%=sOpnApprUs[i]%></td>
        	<td class="td11" nowrap><%=sOpnApprDt[i]%></td>
        	<td class="td18" nowrap><%=sOpnBWrhse[i]%></td>
          </tr>
        <%}%>
        </tbody>
        <!-- ============== In-Transit ====================== -->
        <tbody id="tbdIntrans">
        <tr>
          <th class="th02" colspan=8>In-Transit</th>
        </tr>  
        <%            
        	itrfbatch = new ItemTrfBachList("I", sSort, sUser);
        	iNumOfBch = itrfbatch.getNumOfBch();
        	sOpnBatch = itrfbatch.getBatch();
        	sOpnBComment = itrfbatch.getBComment();
        	sOpnBCrtDate = itrfbatch.getBCrtDate();
        	sOpnBCrtByUser = itrfbatch.getBCrtByUser();
        	sOpnBWrhse = itrfbatch.getBWrhse();
        	sOpnApprDt = itrfbatch.getApprDt();
        	sOpnApprUs = itrfbatch.getApprUs();
        	sDivLst = itrfbatch.getDivLst();
        %>
        <%for(int i=0; i < iNumOfBch;i++){%>
          <tr id="trId" class="trDtl06">
        	<td class="td11" nowrap><a href="javascript: getBatch('<%=sOpnBatch[i]%>','<%=sOpnBComment[i]%>');"><%=sOpnBatch[i]%></a></td>
        	<td class="td11" nowrap><%=sDivLst[i]%></td>
        	<td class="td11" nowrap><%=sOpnBComment[i]%></td>
        	<td class="td11" nowrap><%=sOpnBCrtByUser[i]%></td>
        	<td class="td11" nowrap><%=sOpnBCrtDate[i]%></td>        	
        	<td class="td11" nowrap><%=sOpnApprUs[i]%></td>
        	<td class="td11" nowrap><%=sOpnApprDt[i]%></td>
        	<td class="td18" nowrap><%=sOpnBWrhse[i]%></td>
          </tr>
        <%}%>
        </tbody>
        
       </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>