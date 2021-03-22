<%@ page import="flashreps.FlashForcast, java.util.*, rciutility.StoreSelect
, rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
   	String sStore = request.getParameter("Str");
	String sDiv = request.getParameter("Div");
	String sDpt = request.getParameter("Dpt");
	String sCls = request.getParameter("Cls");
   	String sFrom = request.getParameter("FrDate");
   	String sNumWk = request.getParameter("NumWk");
   	String sLevel = request.getParameter("Level");
   	String sSort = request.getParameter("Sort");

   	if(sSort==null || sSort.equals("")) { sSort="GRP"; }
   	
   
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=FlashForcast.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();
   
   FlashForcast flashsls = new FlashForcast();
	 
	flashsls.setGenSls( sStore,  sDiv, sDpt, sCls, sFrom, sNumWk, sLevel, sSort, sUser);	 
	
	int iNumOfGrp = flashsls.getNumOfGrp();
	int iNumOfReg = flashsls.getNumOfReg();
	
	String sColHdr = "Str";
	if(sLevel.equals("Div")){sColHdr = "Div"; }
	else if(sLevel.equals("Dpt")){sColHdr = "Dpt"; }
	else if(sLevel.equals("Cls")){sColHdr = "Class"; }
	else if(sLevel.equals("SKU")){sColHdr = "SKU"; }
	
	String sLinkNm = "Str";
	if(sLevel.equals("Str")){sLinkNm = "Hierarchy"; }
	
	boolean bLink = true; 
	if(sLevel.equals("Str")){ bLink = false; }
	
	
	StoreSelect strlst = null;
	if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      strlst = new StoreSelect(20);
    }
    else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
    {
      strlst = new StoreSelect(21);
    }
    else
    {
      Vector vStr = (Vector) session.getAttribute("STRLST");
      String [] sStrAlwLst = new String[ vStr.size()];
      Iterator iter = vStr.iterator();

      int iStrAlwLst = 0;
      while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

      if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
      else strlst = new StoreSelect(new String[]{sStrAllowed});
   }

   String sStrJsa = strlst.getStrNum();
   String sStrNameJsa = strlst.getStrName();   
%>

<html>
<head>
<title>Sales Forecasting Report</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var Div = "<%=sDiv%>";
var Dpt = "<%=sDpt%>";
var Cls = "<%=sCls%>";
var FrDate = "<%=sFrom%>";
var NumWk = "<%=sNumWk%>";
var Level = "<%=sLevel%>";
var Sort = "<%=sSort%>";

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];

//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }  
}
//==============================================================================
// show another selected week
//==============================================================================
function reSort(sort)
{
	var url = "FlashForcast.jsp?Str=" + Store
	+ "&Div=" + Div  
	+ "&Dpt=" + Dpt
	+ "&Cls=" + Cls 
	+ "&FrDate=" + FrDate
	+ "&NumWk=" + NumWk
	+ "&Level=" + Level
	+ "&Sort=" + sort
	;

   //alert(url)
   window.location.href=url;
}
//==============================================================================
//switch between store and Herarchy
//==============================================================================
function switchByStrOrDiv(link)
{ 	   	
	if(!link)
	{ 
		if(Div == "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Div"; } 
		else if(Div != "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Dpt"; }
		else if(Div != "ALL" && Dpt != "ALL" && Cls == "ALL"){ Level = "Cls"; }
	}
	else{ Level = "Str"; }
	
	var url = "FlashForcast.jsp?Str=" + Store
		+ "&Div=" + Div  
		+ "&Dpt=" + Dpt
		+ "&Cls=" + Cls 
		+ "&FrDate=" + FrDate
		+ "&NumWk=" + NumWk
		+ "&Level=" + Level
		+ "&Sort=" + Sort
	;
	//alert(url)
    window.location.href=url;	
}
//==============================================================================
// drill down
//==============================================================================
function drillDown(grp)
{
	if(Level == "Str" && Div == "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Div"; Store = grp; }
	else if(Level == "Str" && Div != "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Dpt"; Store = grp; }
	else if(Level == "Str" && Div != "ALL" && Dpt != "ALL" && Cls == "ALL"){ Level = "Cls"; Store = grp; }
	else if(Level == "Str" && Div != "ALL" && Dpt != "ALL" && Cls != "ALL"){ Level = "SKU"; Store = grp; }
	
	else if(Level == "Div"){ Level = "Dpt"; Div = grp; }
	else if(Level == "Dpt"){ Level = "Cls"; Dpt = grp; }
	else if(Level == "Cls"){ Level = "SKU"; Cls = grp; }
	
	var url = "FlashForcast.jsp?Str=" + Store
		+ "&Div=" + Div  
		+ "&Dpt=" + Dpt
		+ "&Cls=" + Cls 
		+ "&FrDate=" + FrDate
		+ "&NumWk=" + NumWk
		+ "&Level=" + Level
		+ "&Sort=" + Sort
	;
	//alert(url)
	window.location.href=url;
}
</SCRIPT>
</head>

<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Sales Forecasting Report  
            <br> Store: <%=sStore%>
            <br> Divison: <%=sDiv%>
            <%if(!sDpt.equals("ALL")){%>, Department: <%=sDpt%><%}%>
            <%if(!sCls.equals("ALL")){%>, Class: <%=sDpt%><%}%>
            <br>From: <%=sFrom%> - Num Of Week: <%=sNumWk%>
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="FlashForcastSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr align=center>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
        	<th class="th02"><%=sColHdr%>
        		<br>&nbsp;<br><a href="javascript: switchByStrOrDiv(<%=bLink%>)"><%=sLinkNm%></a> 
        	</th>
        	<th class="th02" rowspan=2>Name</th>
        	<th class="th02" rowspan=2>&nbsp;</th>
        	<th class="th02" colspan=2>Sale<br>Ret</th>
          	<th class="th02" colspan=2>Sale<br>Units</th>
          	<th class="th02" colspan=2>OnHand</th>          	
          	<th class="th02" colspan=2>DC</th>
          	<th class="th02" colspan=2>Calculating<br>Weekly<br>Supply</th>
        </tr>
        <tr class="trHdr01">
        <th class="th02"><a href="javascript: reSort('GRP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        
        <th class="th02"><a href="javascript: reSort('RETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('RETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('QTYUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('QTYDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        <th class="th02"><a href="javascript: reSort('ONHUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('ONHDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('WHSUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('WHSDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('SUPUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('SUPDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
       </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) {        	   
        	   	flashsls.setGenLst();
        	   	String sGrp = flashsls.getGrp();
        		String sGrpNm = flashsls.getGrpNm();
        		
        		String sRet = flashsls.getRet();
        		String sQty = flashsls.getQty();
        		String sOnhand = flashsls.getOnhand();
        		String sDcOnh = flashsls.getDcOnh();
        		String sWkSupp = flashsls.getWkSupp();
        		 
        		String sReg = flashsls.getReg();
       			
   				if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				else {sTrCls = "trDtl06";}
   				
   				boolean bRegBrk = false;
   			    if(!sReg.equals(sSvReg) && i > 0){ bRegBrk = true; }
   			 	sSvReg = sReg; 
           %>               
           <%if(bRegBrk){%>
             <tr class="Divider1"><td  colspan="100">&nbsp;</td></tr>
           <%}%>            
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td12" nowrap> 
             	<%if(!sLevel.equals("SKU")){%><a href="javascript: drillDown('<%=sGrp%>')"><%=sGrp%></a><%}
             	else{%><%=sGrp%><%} %>
             </td>
             <td id="tdGrp<%=i%>" class="td11" nowrap><%=sGrpNm%></td>
             <td id="tdGrp<%=i%>" class="td35" nowrap>&nbsp;</td> 
             
             <td colspan=2 class="td12" nowrap>$<%=sRet%></td>
             <td colspan=2 class="td12" nowrap><%=sQty%></td>             
             <td colspan=2 class="td12" nowrap><%=sOnhand%></td>
             <td colspan=2 class="td12" nowrap><%=sDcOnh%></td>
             <td colspan=2 class="td12" nowrap><%=sWkSupp%></td>
           </tr>
              <script></script>	
           <%}%> 
           
              
           <!-- ====== Region Total ================ -->           
           <%
          if(sStore.equals("ALL")){  
           	for(int i=0; i < iNumOfReg; i++ )
			{
				flashsls.setRegTot();
				String sGrp = flashsls.getGrp();
				String sGrpNm = flashsls.getGrpNm();
		
				String sRet = flashsls.getRet();
				String sQty = flashsls.getQty();
				String sOnhand = flashsls.getOnhand();
				String sDcOnh = flashsls.getDcOnh();
				String sWkSupp = flashsls.getWkSupp();
			%>
           
           <tr id="trTot" class="trDtl041">             
             <td class="td11" nowrap colspan=2><%=sGrpNm%></td>
             <td class="td35" nowrap>&nbsp;</td> 
             
             <td colspan=2 class="td12" nowrap>$<%=sRet%></td>
             <td colspan=2 class="td12" nowrap><%=sQty%></td>             
             <td colspan=2 class="td12" nowrap><%=sOnhand%></td>
             <td colspan=2 class="td12" nowrap><%=sDcOnh%></td>
             <td colspan=2 class="td12" nowrap><%=sWkSupp%></td>
             
            </tr>
           <%}%>  
         <%}%>
           <!-- ======Total ================ -->
           <%
           	flashsls.setTotal();
           	String sGrp = flashsls.getGrp();
   			String sGrpNm = flashsls.getGrpNm();
   		
   			String sRet = flashsls.getRet();
   			String sQty = flashsls.getQty();
   			String sOnhand = flashsls.getOnhand();
   			String sDcOnh = flashsls.getDcOnh();
   			String sWkSupp = flashsls.getWkSupp();
   			
           %>  
           <tr id="trTot" class="trDtl12">             
             <td class="td11" nowrap colspan=2>Total</td>
             <td class="td35" nowrap>&nbsp;</td> 
             
             <td colspan=2 class="td12" nowrap>$<%=sRet%></td>
             <td colspan=2 class="td12" nowrap><%=sQty%></td>             
             <td colspan=2 class="td12" nowrap><%=sOnhand%></td>
             <td colspan=2 class="td12" nowrap><%=sDcOnh%></td>
             <td colspan=2 class="td12" nowrap><%=sWkSupp%></td>             
            </tr>         
         </table>
         
        <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
flashsls.disconnect();
flashsls = null;
}
%> 

