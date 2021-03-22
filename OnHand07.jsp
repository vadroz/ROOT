<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page import="onhand01.OnHand07, java.util.*, java.text.*"%>
<%
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=OnHand07.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	OnHand07 onh07 = new OnHand07();
	onh07.setItem(sSelCls,  sSelVen, sSelSty, sUser);
	int iNumOfItm = onh07.getNumOfItm();	
	int iNumOfStr = onh07.getNumOfStr();
	
	String sClsSeasDt = onh07.getClsSeasDt();
	
	String [] sStr = onh07.getStr();
	
	
	int [] iStr = new int[iNumOfStr];
	for(int i=0; i < iNumOfStr;i++)
	{
	    iStr[i] = Integer.parseInt(sStr[i]);
	    //System.out.println("i=" + i + "  str=" + sStr[i]);
	}
	
	int [] iSort = new int[]{1,3,4,6,8,82, 11, 20,22, 90,91,98, 92, 93,96
			, 10,28,29, 40, 42, 35,46,50, 86, 87, 88, 66, 63, 64,68,55, 16, 17 };
			
	System.out.println("iNumOfStr=" + iNumOfStr + " iSort=" + iSort.length);		
	
	int [] iSeq = new int[iNumOfStr];
	for(int i=0; i < iSort.length;i++)
	{
		for(int j=0; j < iNumOfStr; j++)
		{			
			if(iStr[j]==iSort[i]){ iSeq[i] = j; }
		}
	}
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->
 
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>On-Hands Inv/Sls</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelCls = "<%=sSelCls%>";
var SelVen = "<%=sSelVen%>";
var SelSty = "<%=sSelSty%>";
var NumOfItm = "<%=iNumOfItm%>";
var NumOfStr = "<%=iNumOfStr%>";
var ArrMark = ["D.C","Houston Area","Aust","San","Ft.W","Arl","Dal","Tul/Okla/Norm","Cinn"
               ,"Nash","Atla","Ski Chalet","N.Y.","Char","Conc","NH","CT","MA","CO"];
               
var ArrMark = ["D.C","Houston Area","Aust","San","Ft.W","Arl","Dal","Tul/Okla/Norm","Cinn"
               ,"Nash","Atla","Ski Chalet","N.Y.","Char","Conc","NH","CT","MA","CO"];
var ArrMarkStr = [["1"], ["3","4","6","8","82"] , ["11"], ["20","22"], ["90","91","98"]
	, ["92"], ["93","96"], ["10","28","29"], ["40"] , ["42"], ["35"]
	,["46","50", "86"], ["87"], ["88"], ["66"], ["63"], ["64"], ["68","55"], ["16"] ];              
var ExtHdg = "0";       
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   setSelParam();
}
//==============================================================================
//set select margkets 
//==============================================================================
function setSelParam()
{
	var html ="";
	for(var i=0; i < ArrMark.length; i++)
	{
		html += "<input id='SelMrk' type='checkbox' checked onclick='setMarkCol()'>" 
		    + ArrMark[i] + " &nbsp; &nbsp;";
	}
	
	html += "<a class='Small' href='javascript: setMarkAll(true)'>All</a> &nbsp; &nbsp;";
	html += "<a class='Small' href='javascript: setMarkAll(false)'>Reset</a>";
	document.all.dvSelect.innerHTML=html;
}
//==============================================================================
//set selected or unselected market colomns 
//==============================================================================
function setMarkAll(chk)
{
	var sel = document.all.SelMrk;
	for(var i=0; i < sel.length; i++)
	{
		sel[i].checked = chk;
	}
	setMarkCol();
}
//==============================================================================
//set selected or unselected market colomns 
//==============================================================================
function setMarkCol()
{
	var sel = document.all.SelMrk;
	var hdr1 = document.all.MarkHdr1;
	var hdr2 = document.all.MarkHdr2;
	var hdr30 = document.all.MarkHdr30;
	var hdr31 = document.all.MarkHdr31;
	var count = 0;
	
	for(var i=0; i < sel.length; i++)
	{
		var disp="none"; 
		if(sel[i].checked)
		{ 
			if(isIE && ua.indexOf("MSIE 7.0") >= 0) {disp = "block"; }
			else { disp = "table-cell"; }
		}
		hdr1[i].style.display = disp;		 
		
		// store - header line 2
		for(var j=0; j < ArrMarkStr[i].length; j++)
		{
			for(var k=0; k < hdr2.length; k++)
			{	
				if(hdr2[k].innerHTML == ArrMarkStr[i][j])
				{
					hdr2[k].style.display = disp;
					hdr30[k].style.display = disp;
					hdr31[k].style.display = disp;					
					
					for(var m=0; m < NumOfItm; m++)
					{
						var tdnm = "tdOnh" + m;
						var onh = document.all[tdnm];
						var tdnm = "tdSls" + m;
						var sls = document.all[tdnm];
						var tdnm = "tdSlsOff" + m;
						var soff = document.all[tdnm];						
						onh[k].style.display = disp;
						sls[k].style.display = disp;
						if(soff != null){ soff[k].style.display = disp; }
					}
					
					if(disp=="block"){count++;}
				}
			}
			
			var none = 0;
			if(disp=="none")
			{   
				none = 1;
			}
			
			for(var k=0; k < NumOfStr; k++)
			{
				for(var m=0; m < ExtHdg; m++)
				{					
			   		var thnm = "thExtHdr" + (m+1);
			   		var hdr4 = document.all[thnm];
			   		
			   		if(hdr4[k].innerHTML == ArrMarkStr[i][j])
			   		{
				    	hdr4[k].style.display = disp;
			   		}			   		
			   }
			}
		}			
	}
	//ExtHdg
	if(count > 0){ document.all.thStr.colSpan = count * 2; }
	else { document.all.thStr.style.display="none"; }  
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
            <br>Store Inventory/STD Unit Sales Analysis List              
            <br>Class-Vendor-Style: <%=sSelCls.trim()%>-<%=sSelVen%>-<%=sSelSty%> 
            <br><span style="font-size:14px">STD Unit Sales from: <%=sClsSeasDt%></span>             
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;This Page                          
          </th>
        </tr>
        
        <tr class="trHdr">
          <th colspan=45><div id="dvSelect" style="text-align:left;font-size:10px; font-weight:normal;">Select Market</div></th>
        </tr>
           
        <tr>
          <td>  
      <table class="tbl02" id="tblEnt">
        <tr class="trHdr01">
          <th class="th03" rowspan=4>Item Description</th>
          <th class="th03" rowspan=4 >Vendor</th>
          <th class="th03" rowspan=4 >Vendor<br>Style</th>
          <th class="th03" rowspan=4 >Color</th>
          <th class="th03" rowspan=4 >Size</th>
          <th class="th03" rowspan=4 >Short SKU</th>
          <th class="th03" rowspan=4 >UPC</th>
          <!--  th class="th03" rowspan=4 >Chain<br>Sales</th -->
          <th class="th03" rowspan=4 >Chain<br>Ret</th>
          
          <th class="th03" rowspan=4 >&nbsp;</th>
          <th class="th03" rowspan=3 colspan=2>Chain</th>                    
          
          <th class="th03" id="thStr" colspan="<%=iNumOfStr * 2%>" >Store</th>
        </tr>
        <tr class="trHdr01">
          <th class="th03" id="MarkHdr1" colspan=2>D.C</th>
          <th class="th03" id="MarkHdr1" colspan=10>Houston Area</th>
          <th class="th03" id="MarkHdr1" colspan=2>Aust</th>
          <th class="th03" id="MarkHdr1" colspan=4>San</th>
          <th class="th03" id="MarkHdr1" colspan=6>Ft.W</th>
          <th class="th03" id="MarkHdr1" colspan=2>Arl.</th>
          <th class="th03" id="MarkHdr1" colspan=4>Dal.</th>
          <th class="th03" id="MarkHdr1" colspan=6>Tul/Okla/Norm</th>
          <!-- th class="th03" id="MarkHdr1" colspan=2>Cinn</th -->
          <th class="th03" id="MarkHdr1" colspan=4>Nash</th>                                    

          <th class="th03" id="MarkHdr1" colspan=6>Ski Chalet</th>

          <th class="th03" id="MarkHdr1" colspan=2>N.Y.</th>
          <th class="th03" id="MarkHdr1" colspan=2>Char</th>
          <th class="th03" id="MarkHdr1" colspan=2>Conc</th>
          <th class="th03" id="MarkHdr1" colspan=2>NH</th>
          <th class="th03" id="MarkHdr1" colspan=2>CT</th>
          <th class="th03" id="MarkHdr1" colspan=6>MA</th>
          <th class="th03" id="MarkHdr1" colspan=4>CO</th>                      
        </tr>
        <tr class="trHdr01">
          <%for(int j=0; j < iSort.length; j++){%>
          	<th class="th03"  id="MarkHdr2" colspan=2><%=iSort[j]%></th>
          <%}%>
        </tr>
        <tr class="trHdr01">
        	<th class="th03">Inv</th>
          	<th class="th03">Sls</th>
          <%for(int j=0; j < iSort.length; j++){%>
          	<th class="th03" id="MarkHdr30">Inv</th>
          	<th class="th03" id="MarkHdr31">Sls</th>
          <%}%>
        </tr>
          
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvClr = "";
             String sTrCls = "trDtl06";             
             int iArg = 0;
              
           %>
           <%for(int i=0; i < iNumOfItm; i++) {        	   
        	   	onh07.setDetail();
        	   	String sCls = onh07.getCls();
        		String sVen = onh07.getVen();
        		String sSty = onh07.getSty();
        		String sClr = onh07.getClr();
        		String sSiz = onh07.getSiz();
        		String sSku = onh07.getSku();
        		String sDesc = onh07.getDesc();
        		String sVenSty = onh07.getVenSty();
        		String sRet = onh07.getRet();
        		String sChainQty = onh07.getChainQty();
        		String sStock = onh07.getStock();
        		String sUpc = onh07.getUpc();
        		String sVenNm = onh07.getVenNm();
        		String sClrNm = onh07.getClrNm();
        		String sSizNm = onh07.getSizNm();		
        		String [] sOnhand = onh07.getOnhand();
        		String [] sSls = onh07.getSls();
        		String sChainSls = onh07.getChainSls();
        		String [] sSellOff = onh07.getSellOff();
        		String sChainSoff = onh07.getChainSoff();        		
        		String sStdUnit = onh07.getStdUnit();        		
        		String sLvl = onh07.getLvl();
        		String sFrdt = onh07.getFrdt();
        		String sLrdt = onh07.getLrdt();        		 
        			         				
        		if(sLvl.equals("1")) { sTrCls = "trDtl06"; }
        		else if(sLvl.equals("2")) { sTrCls = "trDtl04"; }
        		else if(sLvl.equals("3")) { sTrCls = "trDtl07"; }
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>">
                	<td class="td11" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>>
                	   <%if(sLvl.equals("1")){%><%=sDesc%><%}%> 
                	   <%if(sLvl.equals("2")){%>
                	       <%=sCls%>-<%=sVen%>-<%=sSty%>
                	       <br>FR: <%=sFrdt%>&nbsp; LR: <%=sLrdt%>
                	   <%}%>
                	   <%if(sLvl.equals("3")){%><%=sCls%>-<%=sVen%><%}%>
                	</td>                	
                	<td class="td11" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>><%=sVenNm%></td>
                	<td class="td11" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>><%=sVenSty%></td>
                	<td class="td11" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>><%=sClrNm%></td>
                	<td class="td11" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>><%=sSizNm%></td>
                	<td class="td12" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>><%=sSku%></td>
                	<td class="td12" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>><%=sUpc%></td>                	
                	<!--  td class="td12" nowrap rowspan=1><%=sChainSls%></td -->
                	<td class="td12" nowrap <%if(!sLvl.equals("1")){%>rowspan=2<%}%>> <%if(sLvl.equals("1")){%>$<%=sRet%><%}%></td>
                	
                	<td class="td56" nowrap>Inv<br>Sls</td>                	
                	<td class="td52" nowrap><%=sChainQty%><br>&nbsp;</td>
                	<td class="td53" nowrap>&nbsp;<br><%=sStdUnit%></td>
                	
                	<%for(int j=0; j < iSort.length; j++){%>                	
          				<td class="td52" id="tdOnh<%=i%>" nowrap><%=sOnhand[iSeq[j]]%><br>&nbsp;</td>
          				<td class="td53" id="tdSls<%=i%>" nowrap>&nbsp;<br><%=sSls[iSeq[j]]%></td>          			
          			<%}%>                	
              </tr>
              <%if(!sLvl.equals("1")){%>
                  <tr id="trArea<%=i%>" class="<%=sTrCls%>">
                     <td class="td12" nowrap>&nbsp;</td>
                     <td class="td56" nowrap colspan=2><%=sChainSoff%></td>
                	<%for(int j=0; j < iSort.length; j++){%>                	
          				<td class="td56" id="tdSlsOff<%=i%>" nowrap colspan=2><%=sSellOff[iSeq[j]]%></td>          				          			
          			<%}%>                	 
                  </tr>
              <%}%>
              
              <%if(!sLvl.equals("1")){
            	  iArg++;
              %>
                 <tr class="Divider"><td colspan=86>&nbsp;<td></tr>
                 <tr class="trHdr01">
                 	<th class="th03" colspan=10>Store<th>
                 	<%for(int j=0; j < iSort.length; j++){%>
          				<th class="th03" id="thExtHdr<%=iArg%>" colspan=2><%=iSort[j]%></th>
          			<%}%>
                 </tr>
              <%}%> 
           <%}%> 
          
           <script>ExtHdg = "<%=iArg%>"</script>   
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   <p style="text-align:left;">
   
 </body>
</html>
<%
onh07.disconnect();
onh07 = null;
}
%>