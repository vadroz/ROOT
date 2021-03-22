<%@ page import="inventoryreports.PiWiRentRew"%>
<%
  String sStore = request.getParameter("STORE");
  String sArea = request.getParameter("AREA");
  String sSortBy = request.getParameter("SORT");
  String sPiYearMo = request.getParameter("PICal");
  String sSum = request.getParameter("Sum");
  String sMbr = request.getParameter("Mbr");
  String sSelDiv = request.getParameter("Div");

  if (sSortBy==null) sSortBy = "5";
  if (sSum==null) sSum = "N";
  if (sSelDiv == null || sSelDiv.trim().equals("")){sSelDiv="ALL";}

  System.out.println(sStore + "|" + sArea + "|" + sSortBy + "|" + sPiYearMo
		  + "|" +  sSum + "|" + sMbr );
  PiWiRentRew invrep = new PiWiRentRew(sStore, sArea, sSortBy, sPiYearMo.substring(0, 4)
                              ,  sPiYearMo.substring(4), sSum, sMbr);
  invrep.setSingleArea();
%>

<html>
<head>

<style> body {background:ivory;  vertical-align:bottom;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:left; font-family:Arial; font-size:10px }
         td.DataTable2 { background:CornSilk;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
         td.DataTable3 { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:8px }
                       
          td.DataTable4 { background: lemonchiffon;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:12px }
                       
          td.DataTable5 { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; 
                       text-align:center; font-family:Arial; font-size:10px }   
          td.DataTable6 { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-top: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }          

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; }

        .Small { font-size:10px; }

    @media screen
    {
        tr.Hdr {display:none; }
    }
    @media print
    {
        tr.Hdr {display:block }
    }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
var NumOfItm = '0';

var SelDiv = "<%=sSelDiv%>";
var ArrDiv = new Array();
var ArrArg = new Array();

var ArrDivSng = new Array();
var TotQty = 0;

function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){  isSafari = true; }
	
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
   
    
}

 
 
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvSelWk.innerHTML = " ";
   document.all.dvSelWk.style.visibility = "hidden";
}
 
//==============================================================================
// retrieve Log for this str/area
//==============================================================================
function getLog(str,area)
{
	url = "PIWIRentLog.jsp?Str=" + str
	  + "&Area=" + area
	  + "&PICal=<%=sPiYearMo%>";
	;
	window.frame1.location = url;
}
//==============================================================================
// show Log  
//==============================================================================
function showLog(str, area, sn, user, date, time, otharea)
{
	
	var hdr = "Log for Str: " + str + " Area: " + area;

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popLog(sn, user, date, time, otharea);

	   html += "</td></tr></table>"

	   document.all.dvSelWk.innerHTML = html;
	   document.all.dvSelWk.style.pixelLeft= 400;
	   document.all.dvSelWk.style.pixelTop= 100;
	   document.all.dvSelWk.style.visibility = "visible";
}
//==============================================================================
//populate Column Panel
//==============================================================================
function popLog(sn, user, date, time, otharea)
{
	var panel = "<table border=0 cellPadding=0 cellSpacing=0 width='100%'>"
 	  + "<tr>"
 	  	+ "<th class='DataTable'>S/N</th>"
 	  	+ "<th class='DataTable'>User</th>"
 	  	+ "<th class='DataTable'>Date</th>"
 	  	+ "<th class='DataTable'>Time</th>"
 	  	+ "<th class='DataTable'>S/N also<br>scanned<br>In Area</th>"
 	  + "</tr>"
	;
 	var svSn = sn[0];  
 	for(var i=0; i < sn.length ; i++)
 	{ 		
 		panel += "<tr>";
 		
 		// show line only between diferent S/N
 		var cursn = sn[i]; 
 		if(svSn == cursn)
 		{
 			panel += "<td class='DataTable5'>" + sn[i] +  "</td>";
 			panel += "<td class='DataTable5'>" + user[i] +  "</td>";
 	 		panel += "<td class='DataTable5'>" + date[i] +  "</td>";
 	 		panel += "<td class='DataTable5'>" + time[i] +  "</td>";
 	 		panel += "<td class='DataTable5'>" + otharea[i] +  "</td>";
 		}
 		else
 		{
 			panel += "<td class='DataTable6'>" + sn[i] +  "</td>";
 			panel += "<td class='DataTable6'>" + user[i] +  "</td>";
 	 		panel += "<td class='DataTable6'>" + date[i] +  "</td>";
 	 		panel += "<td class='DataTable6'>" + time[i] +  "</td>";
 	 		panel += "<td class='DataTable6'>" + otharea[i] +  "</td>";
 		}
 		svSn = sn[i];
 		
 		
 		panel += "</tr>";
 	}  
 	  
	panel += "<tr><th colspan='4'><button onClick='hidePanel();' class='Small'>Close</button></th></tr>"
	panel += "</table>";

	return panel;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
    <tr bgColor="moccasin">
     <td style="vertical-align:top; text-align:center;">
      <b>Retail Concepts, Inc
      <br>Rental Equipment Area Count Review
      <br>Store:<%=sStore%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          Area: <span id="spnArea" style="font-size:22px;"><%=sArea%></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          Total Count <span id="spnTotal" style="font-size:22px;"></span> 
      </b>
<!------------- end of store selector ---------------------->
       <br>
       <a href="/"><font color="red" size="-1">Home</font></a>&#62;
       <font size="-1">This Page. </font>
       &nbsp;&nbsp;&nbsp;
       <a  href="javascript: getLog('<%=sStore%>','<%=sArea%>')">Display Log</a>
       <br>
       
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable"><a href="javascript: reSort('1')">Department</a></th>
          <th class="DataTable"><a href="javascript: reSort('2')">Class</a></th>
          <th class="DataTable"><a href="javascript: reSort('3')">Brand</a></th>
          <th class="DataTable"><a href="javascript: reSort('4')">Size</a></th>
          <th class="DataTable"><a href="javascript: reSort('5')">Serial<br>Number</a>
            <br>&nbsp;<span style="border: 1 black solid ;background: pink;">999999</span> - Single Scan 
            <br>&nbsp;<span style="border: 1 black solid ;background: yellow;">999999</span> - Miss Mated 
          </th>
          <th class="DataTable">S/N also<br>scanned<br> In Area </th>
          <th class="DataTable">Model</th>
          <th class="DataTable">Life</th>
          <th class="DataTable">Trade</th>
          <th class="DataTable">Purchase<br>Year</th>          
        </tr>
     <!-- ---------------------- Detail Loop ----------------------- -->
     <% int iOverFlow = 1;
        int iArg = -1; 
     %>

     <%while(invrep.getNext())
     {
    	 invrep.setItemProp();
         String sStr = invrep.getStr();
         String sSnArea = invrep.getSnArea();
         String sSrlNum = invrep.getUpc();
         String sBrand = invrep.getBrand();
         String sModel = invrep.getModel();
         String sLife = invrep.getLife();
         String sTrade = invrep.getTrade();
         String sSize = invrep.getSize();
         String sEqpTy = invrep.getEqpTy();
         String sPurchYr = invrep.getPurchYr();
         String sDptNm = invrep.getDptNm();
         String sClsNm = invrep.getClsNm();
         String sVenNm = invrep.getVenNm();
         String sSizNm = invrep.getSizNm();
         String sPair = invrep.getPair();
         String sSequen = invrep.getSequen();
         String sMisPlace = invrep.getMisPlace();
         String sOthArea = invrep.getOthArea();
         
         boolean bSboard = sClsNm.equals("D-ADULT BASIC SNOWBOARDS")
           || sClsNm.equals("L-ADULT BASIC SNOWBOARDS")
           || sClsNm.equals("D-JR SNOWBOARDS")
           || sClsNm.equals("L-JR SNOWBOARDS")
          ;      	
         
     	 iArg++;
        %>
   
           <tr id="trItem<%=iArg%>">
           	  <td class="DataTable1"><%=sDptNm%></td>
           	  <td class="DataTable1"><%=sClsNm%></td>
           	  <td class="DataTable1"><%=sVenNm%></td>
           	  <td class="DataTable1"><%=sSizNm%></td>
           	  <td class="DataTable" 
           	    <%if(!sPair.equals("1") && !bSboard){%>style="background: pink;"<%}
           	      else if(sSequen.equals("0")) {%>style="background: yellow;"<%}%>><%=sSrlNum%>
           	  </td>
           	  <td class="DataTable"><%=sOthArea%></td>
           	  <td class="DataTable1"><%=sModel%></td>
           	  <td class="DataTable"><%=sLife%></td>
           	  <td class="DataTable"><%=sTrade%></td>
           	  <td class="DataTable"><%=sPurchYr%></td>           	  
           </tr>
       
     <%}%>
     <%invrep.setTotQty();
     String sTotQty = invrep.getTotQty();
     %>
     	<tr >
        	<td class="DataTable4" colspan=11>Total Number of S/N: &nbsp;<font size="+2"><b><%=sTotQty%></b></font></td>
     	</tr>  
    </table>
    <script type="text/javascript">
        TotQty = "<%= sTotQty%>";
        document.getElementById("spnTotal").innerHTML = TotQty; 
    </script>

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
<% invrep.disconnect();%>
