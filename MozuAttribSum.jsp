<%@ page import="java.text.*, java.util.*, mozu_com.MozuAttribSum"%>
<%
   String sFromDt = request.getParameter("FromDt");
   String sToDt = request.getParameter("ToDt");   
   String sSort = request.getParameter("Sort");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuAttribSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	MozuAttribSum usrattr = new MozuAttribSum();
	usrattr.setAttrByUser(sFromDt,  sToDt, sSort, sUser);
	int iNumOfUsr = usrattr.getNumOfUsr();
%>

<HTML>
<HEAD>
<title>Vendor Attribution Attribution</title>

<META content="RCI, Inc." name="Mozu"></HEAD>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        
        
        table.tbl01 { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
        
        th.DataTable { padding:3px; text-align:center; vertical-align:top}
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { background: #FFCC99; text-align:center; vertical-align:top}
        
        tr.DataTable { background: #E7E7E7; font-size:12px; vertical-align:top; }
        tr.DataTable1 { background: CornSilk; font-size:12px }
        tr.DataTable2 { background: white; font-size:12px;vertical-align:top; }
        tr.DataTable3 { background: #FFCC99; font-size:12px }
        tr.DataTable4 { background: LimonChiffon; font-size:12px }
        tr.DataTable5 { background: #FFCC99; font-size:16px }

        td.DataTable { padding:3px; text-align:center; white-space:}
        td.DataTable1 { padding:3px; text-align:left; white-space:}
        td.DataTable2 { padding:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding:3px; text-align:center; white-space:}
        td.DataTable02 { cursor:hand;padding:3px; text-align:left; white-space:}
        
        td.DataTable3 { border-right: #E7E7E7 ridge 1px; padding:3px; text-align:center; white-space:}
        
        td.Space01 { background: #FFCC99; text-align:left;}
        
        td.Divider { background: darkred; font-size:1px; }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }
        
        div.dvItem { position:absolute; visibility: hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:100;
              text-align:center; vertical-align:top; font-size:10px}

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Cell {font-size:12px; text-align:right; vertical-align:top}
        td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
        td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================
var SelUser = null;
var SelUserNm = null;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHist"]);
}
//==============================================================================
// retrive division attribute
//==============================================================================
function rtvDivAttr(div, user, name)
{
	SelUser = user;
	SelUserNm = name;
	
	var url = "MozuAttribByDiv.jsp?User=" + user
      + "&Div=" + div
	  + "&FromDt=<%=sFromDt%>"
	  + "&ToDt=<%=sToDt%>"
	window.frame1.location.href = url;			
}
//==============================================================================
//show fedex data
//==============================================================================
function showAttribByDiv(div, dpt, cls, ven, sty, desc, count, ret)
{	
	var hdr = "Attributed By Division";
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popAttribByDiv(div, dpt, cls, ven, sty, desc, count, ret)
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=500;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop =  document.documentElement.scrollTop + 350;
	  document.all.dvItem.style.visibility = "visible";
	   
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popAttribByDiv(div, dpt, cls, ven, sty, desc, count,ret)
	{		   
	   var panel = "<table border =1 class='tbl01' id='tblLog'>"
	    + "<tr class='DataTable2'>"
	       + "<td class='DataTable1' colspan='5'>User: " + SelUserNm
	       + "&nbsp;&nbsp;&nbsp;Division: " + div[0] + "</td>"	       
	    + "</tr>"
	    + "<tr class='DataTable3'>"
	       + "<th class='DataTable'>Class-Vendor-Style</th>"
	       + "<th class='DataTable'>Parent</th>"
	       + "<th class='DataTable'>Description</th>"
	       + "<th class='DataTable'>Number<br>Of<br>Children</th>"
	       + "<th class='DataTable'>Ext<br>Ret</th>"
	    + "</tr>"
	    ;
	    
	    for(var i=0; i < div.length;i++)
	    {
	    	panel += "<tr class='DataTable'>"
		       + "<td class='DataTable'>" + cls[i] + "-" + ven[i] + "-" + sty[i] + "</td>"	
		       + "<td class='DataTable'><a href='https://t11961.mozu.com/Admin/s-16493/products/edit/" + cls[i] + ven[i] + sty[i] + "' target='_blank'>" + cls[i] + ven[i] + sty[i] + "</a></td>"
		       + "<td class='DataTable1'>" + desc[i] + "</td>"	
		       + "<td class='DataTable1'>" + count[i] + "</td>"
		       + "<td class='DataTable1'>$" + ret[i] + "</td>"
		    + "</tr>"
		    ;
	    }
		panel += "</table>  <p style='text-align:center'>";
	    panel += "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
	    ;
	        
		return panel;
	}
	//==============================================================================
	// retrive vendor attribute
	//==============================================================================
	function rtvVenAttr(ven, user, name)
	{
		SelUser = user;
		SelUserNm = name;
		
		var url = "MozuAttribByVen.jsp?User=" + user
	      + "&Ven=" + ven
		  + "&FromDt=<%=sFromDt%>"
		  + "&ToDt=<%=sToDt%>"
		window.frame1.location.href = url;			
	}
	//==============================================================================
	//show fedex data
	//==============================================================================
	function showAttribByVen(div, dpt, cls, ven, sty, desc, count, ret)
	{	
		var hdr = "Attributed By Vendor";
		var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
		     + "<tr>"
		       + "<td class='BoxName' nowrap>" + hdr + "</td>"
		       + "<td class='BoxClose' valign=top>"
		         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
		       + "</td></tr>"
		     + "<tr><td class='Prompt' colspan=2>" + popAttribByVen(div, dpt, cls, ven, sty, desc, count, ret)
		       + "</td></tr>"
		     + "</table>"

		  document.all.dvItem.style.width=500;
		  document.all.dvItem.innerHTML = html;
		  document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 300;
		  document.all.dvItem.style.pixelTop =  document.documentElement.scrollTop + 350;
		  document.all.dvItem.style.visibility = "visible";
		   
		}
		//==============================================================================
		// populate panel
		//==============================================================================
		function popAttribByVen(div, dpt, cls, ven, sty, desc, count, ret)
		{		   
		   var panel = "<table border =1 class='tbl01' id='tblLog'>"
		    + "<tr class='DataTable2'>"
		       + "<td class='DataTable1' colspan='6'>User: " + SelUserNm
		       + "&nbsp;&nbsp;&nbsp;Vendor: " + ven[0] + "</td>"	       
		    + "</tr>"
		    + "<tr class='DataTable3'>"
		       + "<th class='DataTable'>Div</th>"
		       + "<th class='DataTable'>Dpt</th>"
		       + "<th class='DataTable'>Class-Vendor-Style</th>"
		       + "<th class='DataTable'>Parent</th>"
		       + "<th class='DataTable'>Description</th>"
		       + "<th class='DataTable'>Number<br>Of<br>Children</th>"
		       + "<th class='DataTable'>Ext<br>Ret</th>"
		    + "</tr>"
		    ;
		    
		    for(var i=0; i < ven.length;i++)
		    {
		    	panel += "<tr class='DataTable'>"		           
		    	   + "<td class='DataTable'>" + div[i] + "</td>"
		    	   + "<td class='DataTable'>" + dpt[i] + "</td>"
			       + "<td class='DataTable' nowrap>" + cls[i] + "-" + ven[i] + "-" + sty[i] + "</td>"
			       + "<td class='DataTable'><a href='https://t11961.mozu.com/Admin/s-16493/products/edit/" + cls[i] + ven[i] + sty[i] + "' target='_blank'>" + cls[i] + ven[i] + sty[i] + "</a></td>"
			       + "<td class='DataTable1' nowrap>" + desc[i] + "</td>"	
			       + "<td class='DataTable1'>" + count[i] + "</td>"	
			       + "<td class='DataTable1'>$" + ret[i] + "</td>"
			    + "</tr>"
			    ;
		    }
			panel += "</table> <p style='text-align:center'>";
		    panel += "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
		    ;
		        
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
	//==============================================================================
	// re-sort
	//==============================================================================
	function resort(sort)
	{
		var url = "MozuAttribSum.jsp?FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>&Sort=" + sort;  
		window.location.href = url;
	}
	//==============================================================================
	// show tooltip
	//==============================================================================
	function showToolTip(obj, data)
	{
		if(data != "")
		{			
			var html = data;
			var pos = getObjPosition(obj);
		
			document.all.dvToolTip.style.width=256;
			document.all.dvToolTip.innerHTML = html;
			document.all.dvToolTip.style.pixelLeft = pos[0] + 50;
			document.all.dvToolTip.style.pixelTop =  pos[1] - 10;
			document.all.dvToolTip.style.visibility = "visible";
		}
		else
		{
			document.all.dvToolTip.style.visibility = "hidden";
		}
	}	
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>

<!----------------- beginning of table ------------------------>          
      <table  border=1 cellPadding="0" cellSpacing="0">      
        <tr id="trTopHdr" class="DataTable5" style="z-index: 50; position: relative; top: expression(this.offsetParent.scrollTop-15);">
          <th colspan=45>
            <b>Retail Concepts, Incs
            <br>Mozu - Employee Attribution Summary
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuAttribSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        
      <!-- ======================================================================= -->
      
              
      	<tr id="trId" class="DataTable3" style="z-index: 50; position: relative; top: expression(this.offsetParent.scrollTop-14);">
           <th class="DataTable" nowrap>No.</th>           
           <th class="DataTable" id="tdhdr1" nowrap><a href="javascript: resort('USER')">User</a></th>
           <th class="DataTable" id="tdhdr10" nowrap><a href="javascript: resort('NAME')">Name</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PRTCNT')">Parent<br>Count</a></th>           
           <th class="DataTable" nowrap><a href="javascript: resort('DAYAVG')">Daily<br>Average</a></th>
           <th class="DataTable" nowrap>Ext<br>Ret</th>
           <th class="DataTable2" nowrap>&nbsp;</th>
           <th class="DataTable" nowrap>Division<br>
              <a href="MozuAttribSumExcel1.jsp?FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>&Sort=USER&Action=By Division">Excel</a>
           </th>
           <th class="DataTable" nowrap>Parent<br>Count</th>
           <th class="DataTable" nowrap>Ext<br>Ret</th>
           <th class="DataTable2" nowrap>&nbsp;</th>
           <th class="DataTable" nowrap>Vendor<br>
              <a href="MozuAttribSumExcel1.jsp?FromDt=<%=sFromDt%>&ToDt=<%=sToDt%>&Sort=USER&Action=By Vendor">Excel</a>
           </th> 
           <th class="DataTable" nowrap>Parent<br>Count</th>
           <th class="DataTable" nowrap>Ext<br>Ret</th>        
        </tr> 
        
 		       
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;        
        for(int i=0; i < iNumOfUsr; i++)
		{ 
        	usrattr.setDetail();			
			String sUserId = usrattr.getUser();
			String sName = usrattr.getName();
			String sParentCnt = usrattr.getParentCnt();
			String sDayAvg = usrattr.getDayAvg();
			String sRet = usrattr.getRet();
			
			usrattr.setUsrDivCnt();
			int iNumOfDiv = usrattr.getNumOfDiv();
			String [] sDiv = usrattr.getDiv();
			String [] sDivPrtCnt = usrattr.getDivPrtCnt();
			String [] sDivRet = usrattr.getDivRet();
			String [] sDivName = usrattr.getDivName();
			
			usrattr.setUsrVenCnt();
			int iNumOfVen = usrattr.getNumOfVen();
			String [] sVen = usrattr.getVen();
			String [] sVenPrtCnt = usrattr.getVenPrtCnt();
			String [] sVenRet = usrattr.getVenRet();
			String [] sVenName = usrattr.getVenName();
			
            bEven = !bEven;
            String sComa = "";
            int iMax = iNumOfDiv;
            if(iNumOfVen > iNumOfDiv){ iMax = iNumOfVen;}
         %>
         <tr id="trId" class="<%if(bEven) {%>DataTable<%} else {%>DataTable2<%}%>">
            <td class="DataTable" nowrap rowspan=<%=iMax+1%>><%=i+1%></td>
            <td class="DataTable1" nowrap rowspan=<%=iMax+1%>><%=sUserId%>&nbsp;</td>
            <td class="DataTable1" nowrap rowspan=<%=iMax+1%>><%=sName%>&nbsp;</td>            
            <td class="DataTable2" nowrap rowspan=<%=iMax+1%>><%=sParentCnt%></td>            
            <td class="DataTable2" nowrap rowspan=<%=iMax+1%>><%=sDayAvg%></td>
            <td class="DataTable2" nowrap rowspan=<%=iMax+1%>>$<%=sRet%></td>
            <th class="DataTable2" nowrap rowspan=<%=iMax+1%>>&nbsp;</th>
            <td class="DataTable">Div</td>
            <td class="DataTable">Count</td>
            <td class="DataTable">Ret</td>
            <th class="DataTable2" nowrap rowspan=<%=iMax+1%>>&nbsp;</th>
            <td class="DataTable">Vendor</td>
            <td class="DataTable">Count</td>
            <td class="DataTable">Ret</td>            
         </tr>  
         
         <%for(int j=0; j < iMax; j++){%>
         	<tr id="trId" class="<%if(bEven) {%>DataTable<%} else {%>DataTable2<%}%>">  
         	              		
            	<td class="DataTable1"><%if(j < iNumOfDiv){%><a href="javascript: rtvDivAttr('<%=sDiv[j]%>','<%=sUserId%>', '<%=sName%>')"><%=sDiv[j]%> - <%=sDivName[j]%></a><%} 
            		else{%>&nbsp;<%}%>
            	</td>
            	<td class="DataTable2"><%if(j < iNumOfDiv){%><%=sDivPrtCnt[j]%><%} else{%>&nbsp;<%}%></td>
            	<td class="DataTable2"><%if(j < iNumOfDiv){%>$<%=sDivRet[j]%><%} else{%>&nbsp;<%}%></td>
            	
            	<td class="DataTable1"><%if(j < iNumOfVen){%><a href="javascript: rtvVenAttr('<%=sVen[j]%>','<%=sUserId%>', '<%=sName%>')"><%=sVen[j]%> - <%=sVenName[j]%></a><%} 
            		else{%>&nbsp;<%}%>
            	</td>
            	<td class="DataTable2"><%if(j < iNumOfVen){%><%=sVenPrtCnt[j]%><%} else{%>&nbsp;<%}%></td>
            	<td class="DataTable2"><%if(j < iNumOfVen){%>$<%=sVenRet[j]%><%} else{%>&nbsp;<%}%></td>
            </tr>          
         <%}%>
             
         <tr><td class="Divider" colspan=14>&nbsp;</td></tr>    
         <%}%>
         
         <!----------------------- total ------------------------>
         <%
         	usrattr.setTotal();
 		 	String sParentCnt = usrattr.getParentCnt();
 		 	String sDayAvg = usrattr.getDayAvg();
 		 	String sRet = usrattr.getRet();
         %>
         
         <tr class="DataTable4">
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap>Total</td>
            <td class="DataTable1">&nbsp;</td>            
            <td class="DataTable2" nowrap><%=sParentCnt%></td>
            <td class="DataTable2" nowrap><%=sDayAvg%></td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>
            <th class="DataTable2" nowrap>&nbsp;</th>
            <td class="DataTable1" colspan=3>&nbsp;</td>
            <th class="DataTable2" nowrap>&nbsp;</th>
            <td class="DataTable1" colspan=3>&nbsp;</td>
         </table>
             
      <!----------------------- end of table ------------------------>
      
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvToolTip" class="dvItem"></div>
<div id="dvHist" class="dvItem"></div>
<!-------------------------------------------------------------------->
       
    </body>
</html>
<%
usrattr.disconnect();
usrattr = null;
}
%>
