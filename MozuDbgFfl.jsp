<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
  String sSelOrd = request.getParameter("Ord");  
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuDbgFfl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	String sStmt = "";
	if(sSelOrd != null){
	   sStmt = "select uddata from rci.EcUDatb" 
	  	+ " where UDSITE = 'MOORPASW' and udTable = 'SETSTRSTS'"
	  	+ " and substr(uddata, 11, 10) like ('%" + sSelOrd + "%')"	  
	  	+ " order by REC_DS"
	  ;
	}
	else 
	{
		sStmt = "select uddata from rci.EcUDatb" 
			  	+ " where UDSITE = 'MOORPASW' and udTable = 'SETSTRSTS'"
			  	+ " and substr(uddata, 36, 20)  in ('Picked','Shipped')"
			  	+ " and substr(uddata, 10 + 10  + 10 + 5 + 20 + (3 * 100) + 4 + 1  , 10)  = '0'"	
	  	+ " order by REC_DS"
						     ;
	}
	//System.out.println(sStmt);
			
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
	int [] iLng = {  10, 10, 10, 5, 20, 3 * 100, 4, 10, 256, 20, 10 };	   
	int iOut = 0;
	for(int i=0; i < iLng.length; i++){ iOut += iLng[i]; }
%>

<HTML>
<HEAD>
<title>ECOM FFL Debug</title>

<META content="RCI, Inc." name="Mozu"></HEAD>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        
        
        table.tbl01 { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
        
        th.DataTable { padding:3px; text-align:center; vertical-align:top}
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        
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
var SelObj = null;
var NumOfRec = 0;
var ord = new Array();
var sku = new Array();
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHist"]);
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getStrCommt(site, ord, sku, obj)
{
	obj.style.background = "Pink";
	SelObj = obj;

	url = "MozuSrlAsgCommt.jsp?"
  	 + "Site=" + site
  	 + "&Order=" + ord
  	 + "&Sku=" + sku
 	 + "&Str=0"
  	 + "&Action=GETSTRCMMT"

	window.frame1.location.href = url;
}
//==============================================================================
//display comment for selected store
//==============================================================================
function showComments(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
{
var hdr = "Comments. Order: " + ord + " &nbsp; SKU: " + sku ;
var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  + "<tr>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    + "</td></tr>"
  + "<tr><td class='Prompt' colspan=2>" + popComment(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
    + "</td></tr>"
  + "</table>"

document.all.dvItem.style.width=700;
document.all.dvItem.innerHTML = html;
document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 590;
document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate panel
//==============================================================================
function popComment(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
{
var panel = "<table border=1 style='font-size:12px' cellPadding='0' cellSpacing='0' width='100%' id='tblLog'>"
 + "<tr style='background:#FFCC99'>"
    + "<th>S/N</th>"
    + "<th>Type</th>"
    + "<th>Store</th>"
    + "<th nowrap>Emp #</th>"
    + "<th>Comment</th>"
    + "<th>Recorded by</th>"
 + "</tr>"
for(var i=0; i < commt.length; i++)
{
   panel += "<tr><td nowrap>" + serial[i] + "</td>"
   panel += "<td nowrap>" + type[i] + "</td>"

   if(str[i] != "0") { panel += "<td style='text-align:right' nowrap>" + str[i] + "&nbsp;</td>" }
   else{ panel += "<td style='text-align:right' nowrap>H.O.&nbsp;</td>" }
   panel += "<td nowrap>&nbsp;" + emp[i] + "</td>"
     + "<td>" + commt[i] + "&nbsp;</td>"
     + "<td nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
}

 panel += "</table>"
     + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
     + "<button onClick='printLog();' class='Small'>Print</button>"
     
return panel;
}
//==============================================================================
//open new window with Log 
//==============================================================================
function printLog()
{
	var tbl = document.all.tblLog.outerHTML;
	  var WindowOptions =
	   'width=600,height=500, left=100,top=50, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';
	var win = window.open("", "PrintLog", WindowOptions);
	win.document.write(tbl);
	hidePanel();
}
//==============================================================================
// delete marked records
//==============================================================================
function dltEntry()
{
	ord = new Array();
	sku = new Array();
	
	for(var i=0; i < NumOfRec; i++)
	{
		var inpnm = "inpDlt" + i;
		var fld = document.all[inpnm];
		if(fld.checked)
		{
			ord[ord.length] = fld.value.substr(1,10);
			sku[sku.length] = fld.value.substr(12);
		}
	}
 	var hdr = "Delete Order/SKU";
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
		+ "<tr>"
  			+ "<td class='BoxName' nowrap>" + hdr + "</td>"
  			+ "<td class='BoxClose' valign=top>"
    			+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
  			+ "</td></tr>"
		+ "<tr><td class='Prompt' colspan=2>" + popDltEntry()
  			+ "</td></tr>"
	+ "</table>"

	document.all.dvItem.style.width=700;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate panel
//==============================================================================
function popDltEntry()
{
	var panel = "<div>";
	for(var i=0; i < ord.length; i++)
	{
		panel += "<br>" + ord[i] + "-" + sku[i];		
	}
	panel += "</div>";

	panel += "</table>"
 	  + "<button onClick='sbmDltEntry();' class='Small'>Submit</button>&nbsp;"
 	  + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
   
	return panel;
}
//==============================================================================
//populate panel
//==============================================================================
function sbmDltEntry()
{
   var url = "MozuDbgFflDlt.jsp?";
   for(var i=0; i < ord.length; i++)
   {
	   url += "&o=" + ord[i] + "&s=" + sku[i]
   }
   window.frame1.location.href = url;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
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
            <br>Mozu - Debug FFL
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        
      <!-- ======================================================================= -->
      
              
      	<tr id="trId" class="DataTable3" style="z-index: 50; position: relative; top: expression(this.offsetParent.scrollTop-14);">
      	   <th class="DataTable" nowrap>Site</th>
      	   <th class="DataTable" nowrap>Order</th>      	   
      	   <th class="DataTable" nowrap>L<br>o<br>g</th>
      	   <th class="DataTable" nowrap>HO<br>Ctrl</th>
      	   <th class="DataTable" nowrap>Sku</th>
      	   <th class="DataTable" nowrap>Str</th>
      	   <th class="DataTable" nowrap>Sts</th>
      	   <th class="DataTable" nowrap>S/N</th>
           <th class="DataTable" nowrap>Emp</th>
           <th class="DataTable" nowrap>Qty</th>
           <th class="DataTable" nowrap>Text</th>
           <th class="DataTable" nowrap>Action</th>
           <th class="DataTable" nowrap>User</th>
           <th class="DataTable" nowrap><a href="javascript: dltEntry()">Dlt</a></th>     
        </tr> 
        
 		       
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;  
        int i=0;
        while(runsql.readNextRecord())
		{
			String sOut = runsql.getData("uddata");	
			
			String sSite = srvpgm.parseOutValue(sOut, 0, iLng).trim();
			String sOrd = srvpgm.parseOutValue(sOut, 1, iLng).trim();
			String sSku = srvpgm.parseOutValue(sOut, 2, iLng).trim();
			String sStr = srvpgm.parseOutValue(sOut, 3, iLng).trim();
			String sSts = srvpgm.parseOutValue(sOut, 4, iLng).trim();
			String sSrn = srvpgm.parseOutValue(sOut, 5, iLng).trim();
			String sEmp = srvpgm.parseOutValue(sOut, 6, iLng).trim();
			String sQty = srvpgm.parseOutValue(sOut, 7, iLng).trim();
			String sText = srvpgm.parseOutValue(sOut, 8, iLng).trim();
			String sAction = srvpgm.parseOutValue(sOut, 9, iLng).trim();
			String sUserId = srvpgm.parseOutValue(sOut, 10, iLng).trim();
			
            bEven = !bEven;
            String sComa = "";
         %>
         <tr id="trId" class="<%if(bEven) {%>DataTable<%} else {%>DataTable2<%}%>">
            
            <td class="DataTable"><%=sSite%></td>
            <td class="DataTable"><a href="MozuDbgFfl.jsp?Ord=<%=sOrd%>"  target="_blank"><%=sOrd%></td>
            
            <th class="DataTable" style="vertical-align:middle;" id="thLog<%=i%>">
               <a href="javascript: getStrCommt('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>', document.all.thLog<%=i%> );">&nbsp;Log&nbsp;</a>
            </th>
            
            <th class="DataTable" style="vertical-align:middle;"> 
            <a href="MozuSrlAsgCtl.jsp?StsFrDate=01/01/2016&StsToDate=12/31/2099&Ord=<%=sOrd%>&OrdSts=1&Sts=Open&Sts=Assigned&Sts=Printed&Sts=Picked&Sts=Problem&Sts=Resolve&Sts=Shipped&Sts=Cannot Fill&Sts=Sold Out&Sts=Error&Sts=Cancelled" target="_blank">
            HC</a>
            <td class="DataTable"><%=sSku%></td>
            <td class="DataTable"><%=sStr%></td>
            <td class="DataTable"><%=sSts%></td>
            <td class="DataTable"><%=sSrn%></td>
            <td class="DataTable"><%=sEmp%></td>
            <td class="DataTable"><%=sQty%></td>
            <td class="DataTable1"><%=sText%></td>
            <td class="DataTable"><%=sAction%></td>
            <td class="DataTable1"><%=sUserId%></td>
            <td class="DataTable1"><input type="checkbox" name="inpDlt<%=i%>" value="o<%=sOrd%>s<%=sSku%>"></td>                      
         </tr>  
         
         <%i++;
         } 
        	 
		rs.close();
		runsql.disconnect();
		%>
         <script>NumOfRec="<%=i%>";</script>
        
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
srvpgm.disconnect();
srvpgm = null;
} %>
