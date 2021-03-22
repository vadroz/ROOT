<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*,java.text.SimpleDateFormat
, rciutility.CallAs400SrvPgmSup, rciutility.ConnToCounterPoint"%>
<%
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
  
   if(sFrDate == null || sFrDate.trim().equals("")) 
   { 
	   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");
	   // from -7 days
	   Calendar cal = Calendar.getInstance();
	   cal.add(Calendar.DATE, -7);
	   java.util.Date date = cal.getTime();	   
       sFrDate = smp.format(date);
       
       // to -1 day
       cal = Calendar.getInstance();
	   cal.add(Calendar.DATE, -1);
	   date = cal.getTime();
	   sToDate = smp.format(date);
   }
   
   if(sSort == null){ sSort = "rssts, rsInv";}
   
//----------------------------------
//Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=FedexInvoice.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString(); 
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
%>
<HTML>
<HEAD>
<title>FedEx Invoice List</title>
 </HEAD>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css"> 

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script src="XX_Set_Browser.js"></script>
<script src="XX_Get_Visible_Position.js"></script>

 
<script>
//==============================================================================
// Global variables
//==============================================================================
var NumOfRow = 0;
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvOpt"]);	
	 
}
//==============================================================================
//submit for different days back
//==============================================================================
function getPoList(inv, invdt)
{
	url = "FedexInvDtl.jsp?Inv=" + inv
		  + "&InvDt=" + invdt
		  + "&Action=POList"
		;
	window.frame1.location.href=url;
}
//==============================================================================
//submit for different days back
//==============================================================================
function showPOList(inv, invDt, pon, cost, lineh, total, fuel, gain, payAmt)
{
	var hdr = "PO List for Invoice: " + inv + " " + invDt;

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	  + "<tr>"
	  + "<td class='BoxName' nowrap>" + hdr + "</td>"
	  + "<td class='BoxClose' valign=top>"
	    +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	  + "</td></tr>"
	html += "<tr><td   style='text-align:left;' colspan=2>"

	html += popPOList(inv, invDt, pon, cost, lineh, total, fuel, gain, payAmt)

	html += "</td></tr></table>"
        
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "800";}
	else { document.all.dvItem.style.width = "auto";}
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft= 400;
	document.all.dvItem.style.pixelTop= 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popPOList(inv, invDt, pon, cost, lineh, total, fuel, gain, payAmt)
{
  var panel = "<div style='text-align:left;'>"	
  panel += "<table id='tblDtl1' border=0   cellPadding=0 cellSpacing=0>"
    + "<tr>"
     + "<th class='th01' style='width: 31px;'>No.</th>"
     + "<th class='th01' style='width: 77px;'>PO</th>"
     + "<th class='th01' style='width: 76px;'>Hist<br>Cost</th>"
     + "<th class='th01' style='width: 76px;'>Line Haul</th>"
     + "<th class='th01' style='width: 76px;'>Total<brAccess</th>"
     + "<th class='th01' style='width: 76px;'>Fuel</th>"
     + "<th class='th01' style='width: 76px;'>Gain</th>"
     + "<th class='th01' style='width: 76px;' > Pay<br>Amount</th>"
     + "<tr>"
     + "</table>"
    ;
    panel += "</div>"
    panel += "<div style='overflow: scroll; height: 400px; text-align:left'>" 
    panel += "<table id='tblDtl2' border=0  cellPadding=0 cellSpacing=0 >";
    	    
    for(var i=0; i < pon.length; i++)
    {
    	panel += "<tr class='trDtl04'>"
    	  + "<td class='td12' style='width: 25px;'>" + (i+1) + "</td>"
    	  + "<td class='td12' style='width: 70px;'><a href='javascript: getPonDtl(&#34;" + inv + "&#34;,&#34;" + invDt + "&#34;,&#34;" + pon[i] + "&#34;)'>" + pon[i] + "</a></td>"
    	  + "<td class='td12' style='width: 70px;'>" + cost[i] + "</td>"
    	  + "<td class='td12' style='width: 70px;'>" + lineh[i] + "</td>"
    	  + "<td class='td12' style='width: 70px;'>" + total[i] + "</td>"
    	  + "<td class='td12' style='width: 70px;'>" + fuel[i] + "</td>"
    	  + "<td class='td12' style='width: 70px;'>" + gain[i] + "</td>"
    	  + "<td class='td12' style='width: 70px;'>" + payAmt[i] + "</td>"
    	 + "</tr>"
    	 ;
    } 
    panel += "</tr>" 
    panel += "<tr><td class='td18' colspan=10>"
       + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button>&nbsp;"
    panel += "</table>"
    + "</div>"
  ;

  return panel;
}
//==============================================================================
//submit for different days back
//==============================================================================
function getPonDtl(inv, invdt, pon)
{
	url = "FedexInvDtl.jsp?Inv=" + inv
		  + "&InvDt=" + invdt
		  + "&Pon=" + pon
		  + "&Action=PODtl"
		;
	window.frame1.location.href=url;
}
//==============================================================================
// show PO Details 
//==============================================================================
function showPODtl(inv, invDt, pon 
		  ,trcId,srvcTy,srvcCd,srvcTy,srvcCd, shpDt, gfrt, disc, net, currNet
		  ,bench, gain, fuel, addHand, addrCorr, codFees, dclAcc, delAreaSurch
		  , residDel, satDel, othacc, groundDisc1, groundDisc2, total
		  , ecOrd, ecOrdTot, ecOrdShipSub, ecOrdHandle)
{
	var hdr = "PO Detail for Invoice: " + inv + " " + invDt + " PO:" + pon;

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	  + "<tr>"
	  + "<td class='BoxName' nowrap>" + hdr + "</td>"
	  + "<td class='BoxClose' valign=top>"
	    +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel(&#34;dvOpt&#34;);' alt='Close'>"
	  + "</td></tr>"
	html += "<tr><td   style='text-align:left;' colspan=2>"

	html += popPODtl(inv, invDt, pon 
			  ,trcId,srvcTy,srvcCd,srvcTy,srvcCd, shpDt, gfrt, disc, net, currNet
			  ,bench, gain, fuel, addHand, addrCorr, codFees, dclAcc, delAreaSurch
			  , residDel, satDel, othacc, groundDisc1, groundDisc2, total
			  , ecOrd, ecOrdTot, ecOrdShipSub, ecOrdHandle);

	html += "</td></tr></table>"
        
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvOpt.style.width = "1200";}
	else { document.all.dvOpt.style.width = "auto";}
	   
	document.all.dvOpt.innerHTML = html;
	document.all.dvOpt.style.pixelLeft= 100;
	document.all.dvOpt.style.pixelTop= 50;
	document.all.dvOpt.style.visibility = "visible";
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popPODtl(inv, invDt, pon 
		  , trcId,srvcTy,srvcCd,srvcTy,srvcCd, shpDt, gfrt, disc, net, currNet
		  , bench, gain, fuel, addHand, addrCorr, codFees, dclAcc, delAreaSurch
		  , residDel, satDel, othacc, groundDisc1, groundDisc2, total
		  , ecOrd, ecOrdTot, ecOrdShipSub, ecOrdHandle)
{
   var panel = "<table id='tblDtl1' border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
     + "<th class='th01' style='width: 29px;'>No.</th>"
     + "<th class='th01' style='width: 88px;'>Tracking Id</th>"
     + "<th class='th01' style='width: 108px;'>Service Type</th>"
     + "<th class='th01' style='width: 205px;'>Service Code</th>"
     + "<th class='th01' style='width: 106px;'>Shipping Date</th>"
     + "<th class='th01' style='width: 66px;'>Net</th>"
     + "<th class='th01' style='width: 66px;'>Disc</th>"
     + "<th class='th01' style='width: 66px;'>Total</th>"
     + "<th class='th01' style='width: 66px;'>ECOM<br>Order</th>"
     + "<th class='th01' style='width: 66px;'>ECOM<br>Order<br>Total</th>"
     + "<th class='th01' style='width: 66px;'>ECOM<br>Order<br>Shipping</th>"
     + "<th class='th01' style='width: 66px;'>ECOM<br>Order<br>Handle</th>"
     + "<tr>"
     + "</table>"
    ;
    panel += "<div style='overflow: scroll; height: 400px;  text-align:left'>" 
    panel += "<table id='tblDtl3' border=0 cellPadding=0 cellSpacing=0 >";
    	    
    for(var i=0; i < trcId.length; i++)
    {
    	panel += "<tr class='trDtl04'>"
    	  + "<td class='td12' style='width: 22px;'>" + (i+1) + "</td>"
    	  + "<td class='td11' style='width: 80px;' nowrap>" + trcId[i] + "</td>"
    	  + "<td class='td11' style='width: 100px;' nowrap>" + srvcTy[i] + "</td>"
    	  + "<td class='td11' style='width: 200px;' nowrap>" + srvcCd[i] + "</td>"
    	  + "<td class='td18' style='width: 100px;' nowrap>" + shpDt[i] + "</td>"
    	  + "<td class='td12' style='width: 60px;' nowrap>" + net[i] + "</td>"
    	  + "<td class='td12' style='width: 60px;' nowrap>" + disc[i] + "</td>"
    	  + "<td class='td12' style='width: 60px;' nowrap>" + total[i] + "</td>"
    	  + "<td class='td12' style='width: 60px;' nowrap>" + ecOrd[i] + "</td>"
    	  + "<td class='td12' style='width: 60px;' nowrap>" + ecOrdTot[i] + "</td>"
    	  + "<td class='td12' style='width: 60px;' nowrap>" + ecOrdShipSub[i] + "</td>"
    	  + "<td class='td12' style='width: 60px;' nowrap>" + ecOrdHandle[i] + "</td>"
    	 + "</tr>"
    	 ;
    } 
    panel += "</tr>" 
    panel += "<tr><td class='td18' colspan=20>"
       + "<button onClick='hidePanel(&#34;dvOpt&#34;);' class='Small'>Close</button>&nbsp;"
    panel += "</table>"
    + "</div>"
  ;

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel(divnm)
{
   document.getElementById(divnm).innerHTML = " ";	
   document.getElementById(divnm).style.visibility = "hidden";
}
//==============================================================================
//submit for different days back
//==============================================================================
function resort(sort)
{
	url ="FedexInvoice.jsp?FrDate=<%=sFrDate%>"
	  + "&ToDate=<%=sToDate%>"
	  + "&Sort=" + sort
	;
	window.location.href=url;
}
 
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvOpt" class="dvItem"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!----------------- beginning of table ------------------------>  
<table id="tbl01" class="tbl01">
   <tr id="trTopHdr" style="background:ivory; ">
          <th align=center colspan=2>
            <b>Retail Concepts, Inc
            <br>FedEx Invoice List 
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuSoldOutLstSel.jsp"><font color="red" size="-1">Select</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;  
            
          </th>   
        </tr> 
                
      <!-- ======================================================================= -->
      <tr id="trId" style="background:#FFE4C4;">
      	<th align=center valign="top">
    
    	   <table id="tbl01" class="tbl02">
    	    <tr>
           		<th class="th01" nowrap>No.</th>
           		<th class="th01" nowrap>Invoice Number</th>
           		<th class="th01" nowrap>Invoice Date</th>
           	</tr> 
           	   
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;
        int iOrd = 0;
        
        String sStmt = "select FHINV,char(FHINVDT, usa) as FHINVDT" 
          + " from rci.FCHDR"
          + " group by FHINV,FHINVDT"
          + " order by FHINV desc,FHINVDT"
        ;
        
        System.out.println("\n" + sStmt);
        		
        RunSQLStmt runsql = new RunSQLStmt();
        runsql.setPrepStmt(sStmt);
        ResultSet rs = runsql.runQuery();
        		
        String sSvOrd = null;
        int iLine = 0;
        String svOrd = "";
        String sRowCls = "trDtl06";
        
        while(runsql.readNextRecord())
        {        		  
        	String sInv = runsql.getData("FHINV").trim();
        	String sInvDt = runsql.getData("FHINVDT").trim(); 
        	
        	bEven = !svOrd.equals(sInv); 
        	svOrd = sInv;
        	if(bEven) 
        	{
        		if(sRowCls.equals("trDtl06")) { sRowCls = "trDtl04"; }
        		else { sRowCls = "trDtl06"; }
        	}
         %>
         <tr id="trId<%=iLine%>" class="<%=sRowCls%>">            
            <td class="td12" ><%=(++iOrd)%></td>
            <td class="td11" ><a href="javascript: getPoList('<%=sInv%>', '<%=sInvDt%>')"><%=sInv%></a></td>
            <td class="td12" ><%=sInvDt%></td>
         </tr>
       <% iLine++;
         }%>
	  </table>
	  <script type="text/javascript">
	  NumOfRow = "<%=iLine%>";
	  </script>
            <%
            runsql.disconnect();
            runsql = null;
             %> 
      <!----------------------- end of table ------------------------>
    </th>
    <th align=center valign="top">  
      
      <!-- ======================================================================= -->
      <!-- ======================================================================= -->
      <!-- ======================================================================= -->
      
      
       
      
   </table>
   <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

       
    </body>
</html>
<%
}
%>