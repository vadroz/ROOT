 	
<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.util.*
, java.text.*, java.io.*, java.math.*, java.sql.*"%>
<% 
    
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=FxHdrTest01.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	  
	   
	int iNumOfPar = 0;    
		 	 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
 

<SCRIPT>

//--------------- Global variables -----------------------
var NumOfPar = "<%=iNumOfPar%>";
var Parent = null;
var ParPrc = null;
var ParSls = null;
var ParCommt = null;
var SelParent = null;
//--------------- End of Global variables ----------------
function bodyLoad()
{
     
}
//=========================================================
// check scroll
//=========================================================
$( window ).scroll(function() 
{	
	var row = document.all.trHdr1;
	var elementTop = $(row).offset().top;
	var elementBottom = elementTop + $(row).outerHeight();
	var viewportTop = $(window).scrollTop();
	var viewportBottom = viewportTop + $(window).height();

	if(elementTop + 20 < viewportTop  )
	{
		var offsetTop = $(this).scrollTop();
		offsetTop = offsetTop - elementTop; 
		$("#trHdr1").css({position : "relative", "z-index" : 60, top: offsetTop });
		$("#trHdr2").css({position : "relative", "z-index" : 60, top: offsetTop });
	}
	else 
	{
		$("#trHdr1").css({position : "static"});
		$("#trHdr2").css({position : "static" });
	}
		
	window.status = "elementTop=" + elementTop + " | elementBottom=" + elementBottom
	   + " | viewportTop=" + viewportTop + " | viewportBottom=" + viewportBottom

});
 
</SCRIPT>

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
      		 
      		 
      <table class="tbl02">
        <tr class="trHdr01" id="trHdr1">
          <th class="th02" >Class</th>
          <th class="th02" >Vendor</th>
          <th class="th02" >Style</th>
          <th class="th02" >Color</th>
          <th class="th02" >Size</th>          
          <th class="th02" rowspan="2">Description</th>
          <th class="th02" rowspan="2">Sku</th>
          <th class="th02" rowspan="2">Upd</th>
        </tr>
        <tr class="trHdr01" id="trHdr2">
        	<th class="th02">#</th>
        	<th class="th02">#</th>
        	<th class="th02">#</th>
        	<th class="th02">#</th>
        	<th class="th02">#</th>  
        </tr>  
        
<!------------------------------- order/sku --------------------------------->
           <%
             String sTrCls = "trDtl06";
           %>
         <%
         	String sStmt = "select icls, iven,isty,iclr,isiz,ides,isku,iupd"
     			+ " from iptsfil.ipithdr"
     			+ " fetch first 100 rows only"
     		;
         	//System.out.println(sStmt);
           	RunSQLStmt runsql = new RunSQLStmt();
 			runsql.setPrepStmt(sStmt);
 			ResultSet rs = runsql.runQuery();	
 			int i=0;
 			while(runsql.readNextRecord())
 			{
 				String sCls = runsql.getData("icls").trim();
 				String sVen = runsql.getData("iven").trim();
 				String sSty = runsql.getData("isty").trim();
 				String sClr = runsql.getData("iclr").trim();
 				String sSiz = runsql.getData("isiz").trim();
 				String sDesc = runsql.getData("ides").trim();
 				String sSku = runsql.getData("isku").trim();
 				String sUpd = runsql.getData("iupd").trim();
           %>                           
             <tr id="trPar<%=i%>" class="<%=sTrCls%>">                                 
                <td class="td12" nowrap><%=sCls%></td>
                <td class="td12" nowrap><%=sVen%></td>
                <td class="td12" nowrap><%=sSty%></td>
                <td class="td12" nowrap><%=sClr%></td>
                <td class="td12" nowrap><%=sSiz%></td>
                <td class="td12" nowrap><%=sDesc%></td>
                <td class="td12" nowrap><%=sSku%></td>
                <td class="td12" nowrap><%=sUpd%></td>
             </tr>  
           <%
           		i++;
                //if(i == 10){ break;}
 			}
 			iNumOfPar = i;
 	 			rs.close();
 	 			runsql.disconnect(); 
 	 			runsql = null;
 			%>
                  </table>
            <script>NumOfPar = "<%=iNumOfPar%>";</script>      
         Total Number of Parents: <%=i%>         
         <br>&nbsp;<br>&nbsp;<br>&nbsp;
      <!----------------------- end of table ------------------------>
      </tr>
   </table>   
 </body>
</html>
<%
}
%>