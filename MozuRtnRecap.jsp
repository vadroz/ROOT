<!DOCTYPE html>	
<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*, java.math.*"%>
<%
String sFrDate = request.getParameter("FrDate");
String sToDate = request.getParameter("ToDate");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuRtnRecap.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStmt = "with sumf as (" 
		+ " select  rsreas, case when odret is not null then odret else iret end as ret"
		
		+ " from rci.EcSrlRt"
		+ " left join rci.MoOrdd on odsite=rssite and odord=rsord and odsku=rssku" 
		+ " inner join iptsfil.IpItHdr on isku=rssku"
		+ " where RSCRTDT >= '" + sFrDate + "' and RSCRTDT <= '" + sToDate + "'"
		+ " )"
		+ " select rsreas, dec(sum(ret),9,2) as ret"
		+ ", count(*) as qty"
		+ " from sumf"
		+ "	group by rsreas"
		+ " order by rsreas"
     ;
	//System.out.println("\n" + sStmt);
	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);  
	ResultSet rs = runsql.runQuery();

	Vector<String> vReas = new Vector<String>();
	Vector<String> vRet = new Vector<String>();
	Vector<String> vQty = new Vector<String>();
	 
	while(runsql.readNextRecord())
	{
		vReas.add(runsql.getData("rsreas").trim());
		String sRet = runsql.getData("ret");
		if(sRet != null){ vRet.add(sRet.trim());}
		else{vRet.add("0");}
		
		String sQty = runsql.getData("qty");
		if(sQty != null){ vQty.add(sQty.trim());}
		else{vQty.add("0");}		  
	}
	rs.close();
	runsql.disconnect();
%>
<html>
<head>
 
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Mozu Return by Reason</title>

<SCRIPT>

//--------------- Global variables -----------------------
var BegTime = "Current";
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);  
   //progressIntFunc = setInterval(function() { location.reload() }, 1000 * 30);
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
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu Item Return Summary By Reason
             
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuRtnRecapSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02" id="tblDtl">
        <tr class="trHdr01">
          <th class="th02">Reason</th>
          <th class="th02">Retail</th>
          <th class="th02">Qty</th>
         </tr>       
<!------------------------------- Detail --------------------------------->
		<tbody id="tbDtl">
		<%
			double dRet = 0;
		    int iQty = 0;
		%>
		
		<%for(int i=0; i < vReas.size(); i++ ){
			dRet += Double.parseDouble(vRet.get(i));
			iQty += Integer.parseInt(vQty.get(i));
		%>
		   <tr id="trId" class="trDtl04">
              <td class="td11" nowrap><%=vReas.get(i)%></td>
              <td class="td12" nowrap>$<%=vRet.get(i)%></td>
              <td class="td12" nowrap><%=vQty.get(i)%></td> 
           </tr>     
		<%}%>
		<!-- ========== Total ============= -->
		<%
			BigDecimal bdRet = BigDecimal.valueOf(dRet);
		 	bdRet = bdRet.setScale(2, BigDecimal.ROUND_HALF_EVEN);
		%>
		<tr id="trId" class="trDtl12">
              <td class="td11" nowrap>Total</td>
              <td class="td12" nowrap>$<%=bdRet%></td>
              <td class="td12" nowrap><%=iQty%></td> 
        </tr>
		
		</tbody>
           
      </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
}
%>