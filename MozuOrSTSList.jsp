<!DOCTYPE html>	
<%@ page import="mozu_com.MozuOrSTSList, java.util.*, java.text.*"%>
<%
String sSelStr = request.getParameter("Store");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuOrSTSList.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	String sStrAllowed = session.getAttribute("STORE").toString();
	
	if(sSelStr==null)
	{
		if(!sStrAllowed.equals("ALL")) { sSelStr = sStrAllowed; }
		else { sSelStr = "1"; }
	}    
	
	MozuOrSTSList orstsl = new MozuOrSTSList(sSelStr);	
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>S-T-S_Ord_List</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = "<%=sSelStr%>";
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//show fedex data
//==============================================================================
function setPropValue(id, type, prop, attr, value )
{
	var hdr = "Update " + prop
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popPropValue(id, type, prop, value )
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=500;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
	  
	  document.all.Prop.value = value.trim();
	  document.all.Id.value = id;
	  
	  if(type=="LIST") { rtvAttrLst(attr); }
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popPropValue(id, type, prop, value )
	{		   
	   var panel = "<table class='tbl01' id='tblLog'>"
	    + "<tr>"
	       + "<td class='td08'>";
	    if(type=="LIST")  
	    { 
	    	panel += "<input name='Prop' maxlength=50 size=50 readOnly>"
	    	 + "<br><br>Select:<select name='selOpt' onchange='setSelProp(this)'></select>"
	    }	    
	    else if(type=="TEXT")
	    {
	    	panel += "<TextArea class='Small' name='Prop' cols=100 rows=10></TextArea>";
	    }
	    panel += "<input type='hidden' name='Id'>";	     
	    panel += "</td>";	       
	    panel += "</tr>";  
	    
		panel += "</table> <br/>";
	    panel += "<tr>"
  		  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
		   + "</tr>";
		   
	    panel += "</table>"
	        + "<button onClick='vldPropValue();' class='Small'>Save Changes</button>&nbsp; &nbsp;"
	        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
	    ;
	        
		return panel;
}
//==============================================================================
//validate new value
//==============================================================================
function vldPropValue()
{
	var error = false;
  	var msg = "";
  	document.all.tdError.innerHTML="";

  	var id = document.all.Id.value.trim();
  	var prop = document.all.Prop.value;
  	var i = prop.indexOf("\n");  
  	prop = prop.replace(/\n/g, "\\n");
  	
  	if(error){ document.all.tdError.innerHTML=msg; }
  	else{ sbmPropValue(id, prop); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmPropValue(id, prop)
{
	
  	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvSbmStrSts"
  	
  	var html = "<form name='frmItmProp'"
     + " METHOD=Post ACTION='MozuParentSave.jsp'>"
     + "<input name='Site'>"
     + "<input name='Cls'>"
     + "<input name='Ven'>"
     + "<input name='Sty'>"
     + "<input name='Id'>"
     + "<input name='Prop'>"       
     + "<input name='Action'>"

  	html += "</form>"
  	
  		
  	nwelem.innerHTML = html;
  	window.frame1.document.body.appendChild(nwelem);

  	window.frame1.document.all.Cls.value = Cls;
  	window.frame1.document.all.Ven.value = Ven;
  	window.frame1.document.all.Sty.value = Sty;
  	window.frame1.document.all.Id.value = id;
  	window.frame1.document.all.Prop.value = prop;
  	window.frame1.document.all.Action.value="SvItemProp";
  
  	window.frame1.document.frmItmProp.submit();
}

//==============================================================================
//show fedex data
//==============================================================================
function chkHandling(site, ord, pack, sku, sn, action)
{
	var hdr = "&nbsp; &nbsp; Handling for Order: " + ord + ", SKU: " + sku
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popChkHandling(site, ord, pack, sku, sn, action)
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=350;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";	 	  
}
//==============================================================================
//populate panel
//==============================================================================
function popChkHandling(site, ord, pack, sku, sn, action)
{		   
 var panel = "<table class='tbl01' id='tblLog'>"
  + "<tr>"
     + "<td class='td08'>"
        + "Order is being marked received by your store"
        + "<br>AND picked up by the customer."
        + "<br><br>&nbsp; &nbsp; &nbsp; IS THIS CORRECT?"
        + "<br><br>Customer will NOT be notified to pick up package."        
     + "</td>"	       
	+ "</tr>";  
 panel += "</table>"
	   + "<button id='btnSbm' onClick='markItem(&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" 
	   + pack + "&#34;,&#34;" + sku + "&#34;,&#34;" + sn+ "&#34;,&#34;" + action + "&#34;);' class='Small'>Submit</button>&nbsp; &nbsp;"
	   + "<button onClick='hidePanel();' class='Small'>Cancel</button>&nbsp;"
	;
	        
	return panel;
}
//==============================================================================
//mark Item as Received or handled
//==============================================================================
function markItem(site, ord, pack, sku, sn, action)
{	
	if(document.all.btnSbm != null) { document.all.btnSbm.disabled = true; }
	
	var url = "MozuOrSTSSave.jsp?"
	 + "Site=" + site
	 + "&Ord=" + ord
	 + "&Pack=" + pack
	 + "&Sku=" + sku   
	 + "&Sn=" + sn
	 + "&Action=" + action
	
    window.frame1.location.href=url;	
}

//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()" >
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->

      <!----------------- beginning of table ------------------------>
      <table class="tbl01">              
        <tr class="trHdr" >
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu - Ship-To-Store <span style="color:blue; font-size:24px; font-weight:bold"><%=sSelStr%></span> Order List   
             
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr >
          <td>  
       
          
      <!-- ======================================================================= -->
          
      <table class="tbl02">        
      	<tr id="trId" class="trHdr01">
           <th class="th01" nowrap>Order #</th>
           
           <th class="th01" id="tdhdr1" nowrap>Pack Id</th>
           <th class="th01" id="tdhdr2" nowrap>SKU</th>           
           <th class="th01" id="tdhdr3" nowrap>Serial<br>Number</th>
           <th class="th01" id="tdhdr4"nowrap>Sent<br>By Store</th>
           <th class="th01" id="tdhdr4"nowrap>Order<br>Date</th>
           <th class="th01" id="tdhdr4"nowrap>Received<br>By Store</th>
           <th class="th01" id="tdhdr5" nowrap>Ready To<br>Pickup</th>
           <th class="th01" id="tdhdr6"nowrap>Customer<br>was<br>Notified</th>
           <th class="th01" id="tdhdr7"nowrap>Handling</th>
           <th class="th01" id="tdhdr8" nowrap>UPS</th>
           <th class="th01" id="tdhdr9" nowrap>Description</th>
           <th class="th01" id="tdhdr10" nowrap>Vendor Name</th>
           
           <th class="th01" id="tdhdr11" nowrap>Picked By</th>
           <th class="th01" id="tdhdr12" nowrap>Ship To</th>
           <th class="th01" id="tdhdr13" nowrap>Home<br>Phone</th>
           <th class="th01" id="tdhdr14" nowrap>Mobile<br>Phone</th>
           <th class="th01" id="tdhdr15" nowrap>Work<br>Phone</th>
        </tr>        
<!------------------------------- Detail --------------------------------->
        
        <% boolean bEven = true;
        int iLine = 0;
        while(orstsl.getNext()){
         	orstsl.getOrder();
            String sSite = orstsl.getSite();
            String sOrd = orstsl.getOrd();
            String sStr = orstsl.getStr();
            String sCust = orstsl.getCust();
            String sHdrRcv = orstsl.getHdrRcv();
     	    String sHdrRcvDt = orstsl.getHdrRcvDt();
     	    String sHdrRcvTm = orstsl.getHdrRcvTm();	   
            String sRdy = orstsl.getRdy();
   	   	   	String sRdyDt = orstsl.getRdyDt();
   	   	   	String sRdyTm = orstsl.getRdyTm();
   	   	   	String sBroRdy = orstsl.getBroRdy();
  	   	   	String sBroRdyDt = orstsl.getBroRdyDt();
  	       	String sBroRdyTm = orstsl.getBroRdyTm();
            String sCompl = orstsl.getCompl();
            String sComplDt = orstsl.getComplDt();
            String sComplTm = orstsl.getComplTm();
            String sPickBy = orstsl.getPickBy();
            String sFirstNm = orstsl.getFirstNm();
            String sLastNm = orstsl.getLastNm();       
            String sPhnHome = orstsl.getPhnHome();
            String sPhnMob = orstsl.getPhnMob();
            String sPhnWork = orstsl.getPhnWork();
            String sOrdDt = orstsl.getOrdDt();
             
            int iNumOfPack = orstsl.getNumOfPack();
            
            bEven = !bEven;
         %>
         <%if(iLine > 0 && iLine % 15 == 0){%>
         <tr id="trId" class="trHdr01">           
           <th class="th01" nowrap>Order #</th>           
           <th class="th01" id="tdhdr1" nowrap>Pack Id</th>
           <th class="th01" id="tdhdr2" nowrap>SKU</th>           
           <th class="th01" id="tdhdr3" nowrap>Srl Num</th>
           <th class="th01" id="tdhdr4"nowrap>Snt by Str</th>
           <th class="th01" id="tdhdr4"nowrap>Ord Dt</th>
           <th class="th01" id="tdhdr4"nowrap>Rcv by Str</th>
           <th class="th01" id="tdhdr5" nowrap>Rdy To Pickup</th>
           <th class="th01" id="tdhdr6"nowrap>Cust was Notif</th>
           <th class="th01" id="tdhdr7"nowrap>Handling</th>
           <th class="th01" id="tdhdr8" nowrap>UPS</th>
           <th class="th01" id="tdhdr9" nowrap>Description</th>
           <th class="th01" id="tdhdr10" nowrap>Vendor Name</th>
           
           <th class="th01" id="tdhdr11" nowrap>Picked By</th>
           <th class="th01" id="tdhdr12" nowrap>Ship To</th>
           <th class="th01" id="tdhdr13" nowrap>H.Phone</th>
           <th class="th01" id="tdhdr14" nowrap>M.Phone</th>
           <th class="th01" id="tdhdr15" nowrap>W.Phone</th>
        </tr>
         <%}%>
         <%iLine++;%>
         <tr id="trId" class="<%if(sCompl.equals("Y")){%>trDtl041<%} 
               else if(bEven) {%>trDtl06<%} else {%>trDtl04<%}%>">
            <td class="td04" nowrap rowspan="<%=iNumOfPack%>"><%=sOrd%></td>
            
            <!-- ===== First SKU lane ========== -->            
      		<%
      		   orstsl.getPackLst();
      	   	   String sSku = orstsl.getSku();
      	   	   String sSrlN = orstsl.getSrlN();
      	   	   String sDesc = orstsl.getDesc();
      	   	   String sVenNm = orstsl.getVenNm();
      	   	   String sUps = orstsl.getUps();
      	   	   String sRcv = orstsl.getRcv();
      	   	   String sRcvDt = orstsl.getRcvDt();
      	   	   String sRcvTm = orstsl.getRcvTm();      	   	   
      	   	   String sHdl = orstsl.getHdl();
      	   	   String sHdlDt = orstsl.getHdlDt();
      	   	   String sHdlTm = orstsl.getHdlTm();
      	   	   String sPack = orstsl.getPack();
      	   	   String sFrStr = orstsl.getFrStr();
      	   	   
      	   	   //System.out.println("xxx sSku=" + sSku + " Rcv=|" + sRcv + "| " + sRcvDt + " " + sRcv.equals("Y"));
      		%>
      		    <td class="td04" nowrap><%=sPack%></td>
      			<td class="td04" nowrap><%=sSku%></td>
            	<td class="td04" nowrap><%=sSrlN%></td>
            	<td class="td04" nowrap><%=sFrStr%></td>
            	<td class="td04" nowrap rowspan="<%=iNumOfPack%>"><%=sOrdDt%></td>
            	<td class="td06" nowrap>
            		<%if(sRcv.equals("Y")){%><%=sRcvDt%> <%=sRcvTm%><%}
            		else if(!sCompl.equals("Y")) {%><input onclick="markItem('<%=sSite%>','<%=sOrd%>', '<%=sPack%>', '<%=sSku%>', '<%=sSrlN%>','Received')" type="checkbox" value="Y"><%}%>
            	</td>
            	
            	<td class="td06" nowrap rowspan="<%=iNumOfPack%>">
            		<%if(sRdy.equals("Y")){%><%=sRdyDt%> <%=sRdyTm%><%}
            		else if(sHdrRcv.equals("Y") && !sCompl.equals("Y")){%><input onclick="markItem('<%=sSite%>','<%=sOrd%>', '<%=sPack%>', '<%=sSku%>', '<%=sSrlN%>','Ready')" type="checkbox" value="Y"><%}%>
            	</td>
            	
            	<td class="td06" nowrap rowspan="<%=iNumOfPack%>"> 
            		<%if(sBroRdy.equals("Y")){%><%=sBroRdyDt%> <%=sBroRdyTm%><%}%>            		
            	</td>
            	
            	<td class="td06" nowrap rowspan="<%=iNumOfPack%>"> 
            	     <%if(sCompl.equals("Y")){%><%=sComplDt%> <%=sComplTm%><%}
            	     else if(sRcv.equals("Y") && sRdy.equals("Y")){%><input onclick="chkHandling('<%=sSite%>','<%=sOrd%>', '<%=sPack%>','<%=sSku%>', '<%=sSrlN%>','Handled')" type="checkbox" value="Y"><%}%>
            	</td>
            	<td class="td06" nowrap><%=sUps%></td>
            	<td class="td05" nowrap><%=sDesc%></td>
            	<td class="td05" nowrap><%=sVenNm%></td>
            	
      		<!-- ===== End Of First SKU lane ========== -->
      		 
      		  <td class="td05" nowrap rowspan="<%=iNumOfPack%>"><%=sPickBy%></td>
              <td class="td05" nowrap rowspan="<%=iNumOfPack%>"><%=sFirstNm%> <%=sLastNm%></td>              
              <td class="td05" nowrap rowspan="<%=iNumOfPack%>"><%=sPhnHome%></t>
              <td class="td05" nowrap rowspan="<%=iNumOfPack%>"><%=sPhnMob%></td>
              <td class="td05" nowrap rowspan="<%=iNumOfPack%>"><%=sPhnWork%></td>
            </tr>
            
            <!-- ===== Other SKU lanes ========== -->
            <%for(int i=1; i < iNumOfPack; i++) {
      		   orstsl.getPackLst();
      	   	   sSku = orstsl.getSku();
      	   	   sSrlN = orstsl.getSrlN();
      	   	   sDesc = orstsl.getDesc();
      	   	   sVenNm = orstsl.getVenNm();
      	   	   sUps = orstsl.getUps();
      	   	   sRcv = orstsl.getRcv();
      	   	   sRcvDt = orstsl.getRcvDt();
      	   	   sRcvTm = orstsl.getRcvTm();
      	   	   sHdl = orstsl.getHdl();
      	   	   sHdlDt = orstsl.getHdlDt();
      	   	   sHdlTm = orstsl.getHdlTm();
      	   	   sPack = orstsl.getPack();  
      	   	   sFrStr = orstsl.getFrStr();
      		%>
      		  <tr id="trId" class="<%if(sCompl.equals("Y")){%>trDtl041<%} 
                  else if(bEven) {%>trDtl06<%} else {%>trDtl04<%}%>">
      		    <td class="td04" nowrap><%=sPack%></td>
      			<td class="td04" nowrap><%=sSku%></td>
            	<td class="td04" nowrap><%=sSrlN%></td>
            	<td class="td04" nowrap><%=sFrStr%></td>
            	
            	<td class="td06" nowrap>
            		<%if(sRcv.equals("Y")){%><%=sRcvDt%> <%=sRcvTm%><%}
            		else if(!sCompl.equals("Y")) {%><input onclick="markItem('<%=sSite%>','<%=sOrd%>', '<%=sPack%>','<%=sSku%>', '<%=sSrlN%>','Received')" type="checkbox" value="Y"><%}%>
            	</td>
            	
            	<td class="td06" nowrap><%=sUps%></td>
            	<td class="td05" nowrap><%=sDesc%></td>
            	<td class="td05" nowrap><%=sVenNm%></td>
            	            	
           	</tr>
      		<%}%>
      		<tr><td class="Separator04" colspan=15>&nbsp;</td></tr>   
         <%}%>
         </tbody>
         </table>
             
      <!----------------------- end of table ------------------------>
      </tr>      
   </table>   

 </body>
</html>
<%
orstsl.disconnect();
orstsl = null;
}
%>