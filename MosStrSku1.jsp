<!DOCTYPE html>
<%@ page import="mosregister.MosStrSku, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sSelSts = request.getParameterValues("Sts");
   String sReas = request.getParameter("Reas");
   String sSort = request.getParameter("Sort");
   String sType = request.getParameter("Type");
   
   String sWkend = request.getParameter("Wkend");
   String sWkend2 = request.getParameter("Wkend2");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sDateLvl = request.getParameter("DateLvl");
   
   if(sSort==null || sSort.equals("")){sSort = "Tot"; } 
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MosStrSku.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	MosStrSku ctlinfo = new MosStrSku();
	ctlinfo.setSkuLst(sSelStr, sSelSts, sWkend, sWkend2, sYear, sMonth, sDateLvl
			,  sReas, sType, sSort, sUser);
	
	int iNumOfSku = ctlinfo.getNumOfSku();
	int iNumOfStr = ctlinfo.getNumOfStr();
	
	String sUserAuth = "";
	if(sUser.equals("vrozen") || sUser.equals("psnyder") || sUser.equals("dharris")){sUserAuth = "ALL";}
	else if(sUser.equals("gorozco") || sUser.equals("spaoli") || sUser.equals("kknight")){sUserAuth = "DM";}
	boolean bAllowDlt = !sUserAuth.equals("");
%>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
  
  <LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
  
<style type="text/css">
    table {
  position: relative;
  width: 700px;
  overflow: hidden;
  border-collapse: collapse;
}


/*thead*/
#tbl01 thead {
  position: relative;
  display: block; /*seperates the header from the body allowing it to be positioned*/
  width: 700px;
  overflow: visible;
}

#tbl01 thead th {
  min-width: 280px;
  /*height: 32px;*/
  border: 1px solid #222;
}

#tbl01 thead th:nth-child(1) {/*first cell in the header*/
  position: relative;
  display: table-cell; /*seperates the first cell in the header from the header*/  
}


/*tbody*/
#tbl01 table {
  position: relative;
  width: 700px;
  background-color: #FFE4C4;
  overflow: hidden;
  border-collapse: collapse;
}


/*thead*/
#tbl01 thead {
  position: relative;
  display: block; /*seperates the header from the body allowing it to be positioned*/
  width: 700px;
  overflow: visible;
}

#tbl01 thead th {
  background-color: #FFE4C4;
  min-width: 280px;
  height: 32px;
  border: 1px solid #222;
  vertical-align: text-top;  
}

#tbl01 thead th:nth-child(1) {/*first cell in the header*/
  position: relative;
  display: block; /*seperates the first cell in the header from the header*/
  background-color: #FFE4C4;
}


/*tbody*/
#tbl01 tbody {
  position: relative;
  display: block; /*seperates the tbody from the header*/
  width: 700px;
  height: 239px;
  overflow: scroll;
}

#tbl01 tbody td {
  background-color: #e7e7e7;
  min-width: 280px;
  border: 1px solid #222;
}

#tbl01 tbody tr td:nth-child(1) {  /*the first cell in each tr*/
  position: relative;
  display: block; /*seperates the first column from the tbody*/
  /*height: 40px;*/
  background-color: #e7e7e7;
}
</style>

<title>Floating header</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script>
$(document).ready(function() {
	  $('tbody').scroll(function(e) { //detect a scroll event on the tbody
	  	/*
	    Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
	    of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain 			it's relative position at the left of the table.    
	    */
	    $('thead').css("left", -$("tbody").scrollLeft()); //fix the thead relative to the body scrolling
	    $('thead th:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first cell of the header
	    $('tbody td:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first column of tdbody
	  });
	});

</script>
</head>

<body>
	Retail Concepts, Inc
            <br>MOS Store Control Summary List 
            <br>Reason: <%=sReas%>
            <br>By  
                  <%if(sType.equals("U")){%>Unit<%} 
        		  else if(sType.equals("C")){%>Cost<%} 
        		  else if(sType.equals("R")){%>Retail<%}%>
            <br><br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MosStrCtlSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp; 
              <br>
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="U" <%if(sType.equals("U")){%>checked<%}%>>Unit &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="C" <%if(sType.equals("C")){%>checked<%}%>>Cost &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="R" <%if(sType.equals("R")){%>checked<%}%>>Retail &nbsp;                   
    
  <table id="tbl01">
    <thead id="tbl01">
      <tr id="tbl01">
      	<th id="tbl01" class="th02" style="border-bottom:none;" ><a href="javascript: sortby('Desc')">Description</th>
        <th id="tbl01" class="th02" style="border-bottom:none;"><a href="javascript: sortby('Div')">Div</a></th>
       	<th id="tbl01" class="th02" style="border-bottom:none;" ><a href="javascript: sortby('Sku')">Sku</a></th>
       	<th id="tbl01" class="th02" rowspan=2><a href="javascript: sortby('VenSty')">Vendor Style</a></th>
       	<th id="tbl01" class="th02" rowspan=2><a href="javascript: sortby('VenNm')">Vendor Name</a></th>
       	<th id="tbl01" class="th02" rowspan=2>Color</th>
       	<th id="tbl01" class="th02" rowspan=2>Size</th>
       	<th id="tbl01" class="th02" rowspan=2>Last<br>Received</th>
       	<th id="tbl01" class="th02" rowspan=2>Last<br>Sold</th>
       	<th id="tbl01" class="th02" rowspan=2>Last<br>Markdown</th>
       	<th id="tbl01" class="th02" rowspan=2>Chain Onhand</th>
       	<th id="tbl01" class="th02" colspan="<%=iNumOfStr%>">Stores</th>
       	<th id="tbl01" class="th02" rowspan=2><a href="javascript: sortby('Tot')">Total</a></th>
      </tr>
      <tr id="tbl01">
      	<th id="tbl01" style="border-top:none;">&nbsp;</th>
      	<th id="tbl01" style="border-top:none;"></th>
      	<th id="tbl01" style="border-top:none;"></th>
      	<%for(int j=0; j < iNumOfStr; j++) {%>
           		<th class="th02"><%=sSelStr[j]%></th>
        <%}%>
      </tr>
    </thead>
    
    <tbody id="tbl01">
    <!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfSku; i++) {        	   
        	   	ctlinfo.setSku();
       			String sSku = ctlinfo.getSku();
       			String sDesc = ctlinfo.getDesc();
       			String sVenSty = ctlinfo.getVenSty();
       			String sVenNm = ctlinfo.getVenNm();
       			String sClrNm = ctlinfo.getClrNm();
       			String sSizNm = ctlinfo.getSizNm();
       			String [] sExtQty = ctlinfo.getExtQty();
       			String [] sExtCost = ctlinfo.getExtCost();
       			String [] sExtRet = ctlinfo.getExtRet();
       			String sTotQty = ctlinfo.getTotQty();
       			String sTotCost = ctlinfo.getTotCost();
       			String sTotRet = ctlinfo.getTotRet();
       			String sDiv = ctlinfo.getDiv();
       			String sLstRctDt = ctlinfo.getLstRctDt();
       			String sLstSoldDt = ctlinfo.getLstSoldDt();
       			String sLstMkdnDt = ctlinfo.getLstMkdnDt();
       			String sChnOnh = ctlinfo.getChnOnh();
       			
   				if(sTrCls.equals("trDtl21")){sTrCls = "trDtl20";}
   				else {sTrCls = "trDtl21";} 
   				
   				for(int j = 0; j < iNumOfStr; j++)
   				{
   					if( sExtQty[j].equals("0")){ sExtQty[j] = "&nbsp;"; }
   					if( sExtCost[j].equals(".00")){sExtCost[j] = "&nbsp;"; }
   					if( sExtRet[j].equals(".00")){sExtRet[j] = "&nbsp;";  }
   				}
   				
   				String [] sAmt = new String[iNumOfStr];
   				for(int j = 0; j < iNumOfStr; j++)
   				{
   					if(sType.equals("U")){sAmt[j] = sExtQty[j]; }
   					else if(sType.equals("C")){sAmt[j] = sExtCost[j]; }
   					else if(sType.equals("R")){sAmt[j] = sExtRet[j]; }
   				}
   		   %>  
    
    
      <tr id="tbl01">
      	<td id="tbl01" class="td11"><%=sDesc%></td>
        <td id="tbl01" class="td12"><%=sDiv%></td>
        <td id="tbl01" class="td12"><%=sSku%></td>        
        <td id="tbl01" class="td11"><%=sVenSty%></td>
        <td id="tbl01" class="td11"><%=sVenNm%></td>
        <td id="tbl01" class="td11"><%=sClrNm%></td>
        <td id="tbl01" class="td11"><%=sSizNm%></td>
        <td id="tbl01" class="td11"><%=sLstRctDt%></td>
        <td id="tbl01" class="td11"><%=sLstSoldDt%></td>
        <td id="tbl01" class="td11"><%=sLstMkdnDt%></td>
        <td id="tbl01" class="td11"><%=sChnOnh%></td>
        
        <%for(int j = 0; j < iNumOfStr; j++){%>
        	<td id="tbl01" class="td12" nowrap
        	    onmouseover="showDesc('<%=sDesc%>', '<%=sVenNm%>', this)">
        	   <%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%>
        	</td>
         <%}%>
         
        <td id="tbl01" class="td12" nowrap>
         <%if(sType.equals("U")){%><%=sTotQty%><%} 
           else if(sType.equals("C")){%>$<%=sTotCost%><%} 
           else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        </td>     
        
      </tr>
     <%}%>
    </tbody>
  </table>
  
   
</body>


</html>

<%
ctlinfo.disconnect();
ctlinfo = null;
}
%>
