<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.util.*
, java.text.*, java.io.*, java.math.*, java.sql.*"%>
<% 
   String sDays = request.getParameter("Days");
   if(sDays == null || sDays.equals("")){ sDays = "1";} 
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=KiboTodayPrcChg.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	  
	   
	int iNumOfPar = 0;    
	
	int [] iColWidth = new int[]{ 3, 3, 13, 1, 1,1, 1, 8, 8, 8, 1, 8, 8, 9, 1, 31, 17, 32, 20 };   
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>KIBO Today Price Changes</title>

<SCRIPT>

//--------------- Global variables -----------------------
var NumOfPar = "<%=iNumOfPar%>";
var Parent = null;
var ParPrc = null;
var ParSls = null;
var ParCommt = null;
var SelParent = null;
var SelObj = null;
var PrcUnMatch = new Array();
var Continue = false;
var CurArg = 0;
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }	
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
//resend price to all unmatched
//==============================================================================
function setAllUnmatched()
{
	window.status = "Number of All Unmatched: " + PrcUnMatch.length;
	Continue = true;
	CurArg = 0;
	if (PrcUnMatch.length > 0)
	{
		window.status = "Line " + CurArg + " of " + PrcUnMatch.length;		
		getKiboPrice(PrcUnMatch[CurArg]);
		CurArg++;
	}
}

//==============================================================================
// check Kibo Price
//==============================================================================
function getKiboPrice(i)
{		
	var prod = document.getElementById("tdProd" + i);
	Parent = prod;
	var prc = document.getElementById("tdPrc" + i);
	ParPrc = prc.innerHTML;
	var sls = document.getElementById("tdSls" + i);
	ParSls = sls.innerHTML;
	var commt = document.getElementById("tdCommt" + i);
	ParCommt = commt
		
	sbmRtvKiboPrice(prod.innerHTML);
}
//==============================================================================
// retreive KIBo price
//==============================================================================
function sbmRtvKiboPrice(prod)
{
	var url = "KiboCurrPrice.jsp?Prod=" + prod;
	window.frame1.location.href=url;
}
//==============================================================================
// set KIBo price
//==============================================================================
function setKiboPrc(child,ipChlPrc,ipChlSls,kiboChlPrc,kiboChlSls,kiboParPrc,kiboParSls)
{	
	if(child.length == 0 && eval(kiboParPrc) == eval(ParPrc) && eval(kiboParSls) == eval(ParSls))
	{
		Parent.style.background = "#ccffcc";
		ParCommt.innerHTML = "sync.";
	}
	else
	{
		Parent.style.background = "pink";
		ParCommt.innerHTML = "UNsync.";
	}
	
	
	if (Continue && CurArg < PrcUnMatch.length)
	{
		window.status = "Line " + CurArg + " of " + PrcUnMatch.length;		
		getKiboPrice(PrcUnMatch[CurArg]);
		
		setTblTo();
		CurArg++;		
	}
	else
	{ 
		Continue = false; 
		window.status = "All Lines have been updated";
	}
}

//==============================================================================
//scroll table
//==============================================================================
function setTblTo()
{
	var w = $(window);
	var row = $('#tblData').find('tr').eq( PrcUnMatch[CurArg] );

	if (row.length){
	    w.scrollTop( row.offset().top - (w.height()/2) );
	}
}

//==============================================================================
//retreive Children prices
//==============================================================================
function getRtvProdDtl(prod, obj)
{
	SelParent = prod;
	SelObj = obj;
	var url = "KiboChildPrcChg.jsp?Prod=" + prod;
	window.frame1.location.href=url;
}
//==============================================================================
// show Children prices
//==============================================================================
function showChildPrc(prod,proce,sales,clrNm,sizNm,kiPrc,kiSls,recTm,oldPrc,oldSls)
{
	var hdr = "Parent: " + SelParent;
	  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" 
	        + popChildPrc(prod,proce,sales,clrNm,sizNm,kiPrc,kiSls,recTm,oldPrc,oldSls)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "650";}
	  else { document.all.dvItem.style.width = "auto";}
	  
	  var pos = getObjPosition(SelObj);
	  
	  document.all.dvItem.innerHTML = html;
	  
	  document.all.dvItem.style.left = pos[0] + 200;
	  document.all.dvItem.style.top = pos[1] - 50;
	  document.all.dvItem.style.visibility = "visible";
	  
	  window.status = " left=" +  document.all.dvItem.style.left
	   + " top=" +  document.all.dvItem.style.top;
	  
}
//==============================================================================
//populate picked Item
//==============================================================================
function popChildPrc(prod,price,sales,clrNm,sizNm,kiPrc,kiSls,recTm,oldPrc,oldSls)
{
	var panel = "<table cellPadding='0' cellSpacing='0' border=1>";
	panel += "<tr class='trHdr01'>"
		 + "<th class='th02' rowspan=2>Children</th>"
		 + "<th class='th02' colspan=3>Regular Price</th>"
		 + "<th class='th02' colspan=3>Sale Price</th>"		 
		 + "<th class='th02' rowspan=2>Color</th>"
		 + "<th class='th02' rowspan=2>Size</th>"
		 + "<th class='th02' rowspan=2>Time</th>"
	  + "</tr>"
	  + "<tr class='trHdr01'>"
	     + "<th class='th02'>Prior<br>Day<br>Price</th>"
		 + "<th class='th02'>Current<br>Price</th>"
		 + "<th class='th02'>Kibo<br>Price</th>"
		 + "<th class='th02'>Prior<br>Day<br>Sales</th>"
		 + "<th class='th02'>Current<br>Sales</th>"
		 + "<th class='th02'>Kibo<br>Sales</th>"
	  + "</tr>"	 
	  ;
	  
		  
	for(var i=0; i < prod.length; i++)
	{
	    panel += "<tr class='trDtl04'>"
	      + "<td class='td11' nowrap>" + prod[i] + "</td>"
	      + "<td class='td11'>" + oldPrc[i] + "</td>"
	      + "<td class='td11'>" + price[i] + "</td>"
	      + "<td class='td11'>" + kiPrc[i] + "</td>"
	      + "<td class='td11'>" + oldSls[i] + "</td>"
	      + "<td class='td11'>" + sales[i] + "</td>"	      
	      + "<td class='td11'>" + kiSls[i] + "</td>"
	      + "<td class='td11'>" + clrNm[i] + "</td>"
	      + "<td class='td11'>" + sizNm[i] + "</td>"	      
	      + "<td class='td11'>" + recTm[i] + "</td>"
	    + "</tr>"  
  }

  panel += "</tr>";
	
  panel += "<tr class='DataTable4'>"
	      + "<td class='td18' colspan=10>"
	         + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
		  + "</td></tr>"
	
  return panel;
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


<script type='text/javascript'>//<![CDATA[
$(window).load(function()
{		 
  	        var obj = document.getElementById("tdLeft");
	        var pos = getObjPosition(obj);
	        
			cloneRow();

			$(window).bind("scroll", function() 
			{
		     	var offsetLeft = $(this).scrollLeft();
				var color = "#bee5ea";
				var posLeft = 0; 
				posLeft = offsetLeft; 		
				
				var offsetTop = $(this).scrollTop();
		    	if(offsetTop > 150)
		    	{
		    		$("#trHdr01").css({"display": "none"});
		    		$("#trHdr02").css({"display": "none"});		    		
		    		$("#tblClone").css({"display": "block"});		    		
		    		$("#tblClone").css({top: offsetTop, left: pos[0]});
		    		$("#tblClone").css('z-index', 100);
		    	}
		    	else
		    	{	
		    		$("#trHdr01").css({"display": "table-row"});
		    		$("#trHdr02").css({"display": "table-row"});
		    		$("#tblClone").css({"display": "none"});
		    	} 
			}); 
			});//]]> 

		//==============================================================================
		//clone row 
		//==============================================================================
		function cloneRow() 
		{
		  var row1 = document.getElementById("trHdr01");  
		  var row2 = document.getElementById("trHdr02");
		  
		  var rowScale = document.getElementById("trScale");
		  var table = document.getElementById("tblClone");  
		  var clone1 = row1.cloneNode(true); // copy children too  
		  var clone2 = row2.cloneNode(true);		  		  
		  var cloneScale = rowScale.cloneNode(true);
		  
		  
		  clone1.id = "trClone01"; // change id or other attributes/contents
		  clone2.id = "trClone02";
		  cloneScale.id = "trCloneScale";
		  
		// add new row to end of table		  
		  table.appendChild(cloneScale); 
		  table.appendChild(clone1); 		  
		  table.appendChild(clone2);
		  
		  var hdr1 = table.childNodes[1].childNodes[1];
		  var hdr2 = table.childNodes[2].childNodes[1];
		  hdr1.id = "thFix1";
		  hdr2.id = "thFix2";
		  
		  $("#tblClone").css({"display": "none"});  
}
		//==============================================================================
		// remove clone 
		//==============================================================================
		function removeClone() 
		{
			clone = false;
			
			var table = document.getElementById("tblData");
			
			var row1 = document.getElementById("trHdr01c");
			var ri1 = row1.rowIndex;
			table.deleteRow(ri1);
			
			var row2 = document.getElementById("trHdr02c");
			var ri2 = row2.rowIndex;
			table.deleteRow(ri2);
			
			var row1 = document.getElementById("trHdr01");  
			var row2 = document.getElementById("trHdr02");
						
			row1.style.display = "table-row";
			row2.style.display = "table-row";
			
}
// ==============================================================================
</script>	



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
            <br>E-Comm Todays Price Changes
                           
            </b>                                    
          </th>
        </tr>
        <tr>
          <td align=center>
             <a href="../"><font color="red" size="-1">Home</font></a>&#62;
      		 <font size="-1">This Page</font>
      		 <br>A<sup>*</sup> = KIBO Price/Stock Analysis  
      		 &nbsp; &nbsp; 
      		 O<sup>*</sup> = Link to sunandski.com
      		 &nbsp; &nbsp; 
      		 K<sup>*</sup> = Get Selected Item Kibo Price and Update our copy.
      		 &nbsp; &nbsp;
      		 <a class="Small" href="javascript: setAllUnmatched()">Resend Unmatched</a> 
         </td>
       </tr>
      </table>
          
      <!-- ======================= Clone Header ========================================== -->
       <table id="tblClone" class="tbl01" style="position: absolute; text-align: center" ></table>
       <!-- ======================= End of Clone Header =================================== -->		 
      		 
      <table class="tbl02" id="tblData">
        <tr class="trHdr01" id="trHdr01">
          <th class="th02" id="tdLeft" rowspan="2">Div</th>
          <th class="th02" rowspan="2">Dpt</th>
          <th class="th02" rowspan="2">Product</th>
          <th class="th02" rowspan="2">A<sup>*</sup></th>
          <th class="th02" rowspan="2">O<sup>*</sup></th>
          <th class="th02" rowspan="2">K<sup>*</sup></th>
          <th class="th02" rowspan="2">&nbsp;</th>
          <th class="th02" colspan="3">Regular Price</th>
          <th class="th02" rowspan="2">&nbsp;</th>
          <th class="th02" colspan="3">Sale Price</th>
          <th class="th02" rowspan="2">&nbsp;</th>
          <th class="th02" rowspan="2">Description</th>
          <th class="th02" rowspan="2">Vendor<br>Style</th>
          <th class="th02" rowspan="2">Vendor<br>Name</th>
          <th class="th02" rowspan="2">Comment</th>
        </tr>
        <tr class="trHdr01" id="trHdr02">
        <th class="th02">Prior<br>Day<br>IP<br>Price</th>
          <th class="th02">New<br>IP<br>Price</th>          
          <th class="th02">Kibo<br>Current<br>Price</th>
          <th class="th02">Prior<br>Day<br>IP<br>Sales</th>
          <th class="th02">New<br>IP<br>Sales</th>
          <th class="th02">Kibo<br>Current<br>Sales</th>
        </tr>  
        
<!------------------------------- order/sku --------------------------------->
           <%
             String sTrCls = "trDtl06";
           %>
         <%
         	String sProd = null;
         	String sDiv = null;
         	String sDpt = null;
         	String sDesc = null;
         	String sVenSty = null;
         	String sVenNm = null;
         	
         	String sPrice = null;
         	String sSales = null;
         	
         	String sOldPrc = null;
         	String sOldSls = null;
         	
         	String sKiPrc = null;
         	String sKiSls = null;
         	
         	String sStmt = "with parf as ("
     			+ " select substr(prod,1,13) as prod, recdt"
     			+ " from rci.moprcinv a"
     			+ " where recdt >= current date"
     			+ " and exists(select 1 from rci.moprcinv b where a.prod=b.prod and a.recdt > b.recdt " 
     			+ " and (a.price <> b.price or a.sales <> b.sales)"
     			+ "  and recdt >= date(current date)  - " + sDays + " days  and recdt < date(current date))" 
     			+ " )"
     			+ " select a.prod" 
     			+ ", (select price from rci.moprcinv b where b.prod = a.prod and b.recdt=max(a.recdt) fetch first 1 row only)  as price"
     			+ ", (select price from rci.moprcinv b where b.prod = a.prod and date(b.recdt) = date(max(a.recdt)) - 1 days fetch first 1 row only)  as old_price"
     			+ ", (select sales from rci.moprcinv b where b.prod = a.prod and b.recdt=max(a.recdt) fetch first 1 row only)  as sales"
     			+ ", (select sales from rci.moprcinv b where b.prod = a.prod and date(b.recdt) = date(max(a.recdt)) - 1 days fetch first 1 row only)  as old_sales"
     			+ " , idiv, idpt, ides, ivst"
     			+ ", max(ki_prc) as ki_prc"
     			+ ", max(ki_sls) as ki_sls"
     			+ ", vnam"
     			+ " from parf a"
     			+ " left join Table(select idiv, idpt, icls, iven, isty, ides, ivst from iptsfil.IpItHdr where"     			 
     			+ " dec(substr(prod,1,4),4,0) = icls" 
     			+ " and dec(substr(prod,5,5),5,0) = iven"
     			+ " and dec(substr(prod,10,4),4,0) = isty" 
     			+ " fetch first 1 row only) as ih on  1=1"
     			+ " left join rci.MoPrcTod b on b.parent =1 and b.prod=a.prod and b.recdt >= current date"
     			+ " left join iptsfil.IpMrVen on vven=iven"
     			+ " group by idiv, idpt,a.prod, ides, ivst,vnam"
     			+ " order by idiv, idpt,a.prod"
     		;
         	//System.out.println(sStmt);
           	RunSQLStmt runsql = new RunSQLStmt();
 			runsql.setPrepStmt(sStmt);
 			ResultSet rs = runsql.runQuery();	
 			int i=0;
 			while(runsql.readNextRecord())
 			{
 				sProd = runsql.getData("prod").trim();
 				sDiv = runsql.getData("idiv").trim();
 				sDpt = runsql.getData("idpt").trim();
 				sDesc = runsql.getData("ides").trim();
 				sVenSty = runsql.getData("ivst").trim();
 				sVenNm = runsql.getData("vnam").trim();
 				sPrice = runsql.getData("price").trim();
 				sSales = runsql.getData("sales").trim();
 				sOldPrc = runsql.getData("old_price").trim();
 				sOldSls = runsql.getData("old_sales").trim();
 				
 				sKiPrc = runsql.getData("ki_prc");
 				if(sKiPrc == null){ sKiPrc = "Not Found"; }
 				sKiPrc = sKiPrc.trim();
 				sKiSls = runsql.getData("ki_sls");
 				if(sKiSls == null){ sKiSls = "Not Found"; }
 				sKiSls = sKiSls.trim();
 				
				if(sTrCls.equals("trDtl06")){ sTrCls = "trDtl04"; }
				else{ sTrCls = "trDtl06"; }
				
				// mark unsyncronized price and sales with pink, if kibo not found - yellow
				String sPrcStyle = "";
				boolean bPrcUnMatch = false;
				//System.out.println(sPrice + "|" +  sKiPrc + "|" + sPrice.length() + "|" + sKiPrc.length());
				if(!sPrice.equals(sKiPrc) && !sKiPrc.equals("Not Found"))
				{
					sPrcStyle = "style=\"background: pink;\"";
					bPrcUnMatch = true;
				}
				else if(sKiPrc.equals("Not Found")){ sPrcStyle = "style=\"background: yellow;\""; }
				
				String sSlsStyle = "";
				if(!sSales.equals(sKiSls) && !sKiSls.equals("Not Found"))
				{
					sSlsStyle = "style=\"background: pink;\"";
					bPrcUnMatch = true;
				}
				else if(sKiSls.equals("Not Found")){ sSlsStyle = "style=\"background: yellow;\""; }
           %>                           
             <tr id="trPar<%=i%>" class="<%=sTrCls%>">                                 
                <td class="td12" nowrap><%=sDiv%></td>
                <td class="td12" nowrap><%=sDpt%></td>
                <td id="tdProd<%=i%>" class="td11" style="color: blue; text-decoration: underline; cursor: pointer;" 
                     onclick="getRtvProdDtl('<%=sProd%>', this)" nowrap><%=sProd%>
                 </td>
                <td class="td11" nowrap><a href="MozuStockPriceAnlysis.jsp?Site=11961&Parent=<%=sProd%>" target="_blank">A</a></td>
                <td class="td11" nowrap><a href="https://www.sunandski.com/p/<%=sProd%>" target="_blank">O</a></td>                
                <td class="td18" nowrap><a href="javascript: getKiboPrice(<%=i%>) ">K</a></td>
                
                <th class="th27">&nbsp;</th>
                <td class="td11" nowrap><%=sOldPrc%></td>                               
                <td id="tdPrc<%=i%>" class="td12" nowrap><%=sPrice%></td>
                <td class="td11" <%=sPrcStyle%> nowrap><%=sKiPrc%></td>
                
                <th class="th27">&nbsp;</th>
                <td class="td11" nowrap><%=sOldSls%></td>
                <td id="tdSls<%=i%>" class="td12" nowrap><%=sSales%></td>
                <td class="td11" <%=sSlsStyle%> nowrap><%=sKiSls%></td>
                <th class="th27">&nbsp;</th>
                
                <td class="td11" nowrap><%=sDesc%></td>
                <td class="td11" nowrap><%=sVenSty%></td>
                <td class="td11" nowrap><%=sVenNm%></td>
                <td id="tdCommt<%=i%>" class="td11" nowrap>&nbsp;</td>
             </tr>
             <%if(bPrcUnMatch){%>
             <script>PrcUnMatch[PrcUnMatch.length] = "<%=i%>" </script>
             <%}%>	
            	  
           <%
           		i++;
                //if(i == 10){ break;}
 			}
 			
 			iNumOfPar = i;
 	 			rs.close();
 	 			runsql.disconnect(); 
 	 			runsql = null; 	 			
 			%>
 			<tr id="trScale" class="trDtl06" style="visibility: hidden;">
             <td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[0]; k++){%>W<%}%></td>
             <%for(int j=0, a=1; j < iColWidth.length-1; j++, a++){%>              	
              	<td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ a]; k++){%>0<%}%></td>              	             
             <%}%>
             <td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[0]; k++){%>W<%}%></td>
            </tr>
        </table>
            <script>NumOfPar = "<%=iNumOfPar%>";</script>      
         <p class="Small">Total Number of Parents: <%=i%>         
         <br>&nbsp;<br>&nbsp;<br>&nbsp;
      <!----------------------- end of table ------------------------>
        
 </body>
</html>
<%
}
%>