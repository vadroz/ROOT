<!DOCTYPE html>	
<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.sql.*, java.util.*, java.text.*"%>
<%   
   String sFrDate = request.getParameter("From");
   String sToDate = request.getParameter("To");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PiAreaEnt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	RunSQLStmt sql_Area = null;
	ResultSet rs_Area = null;
	   
    String sStmt = "with ordf as ("
    	+ "	select * from rci.MoOrdh"
    	+ "	where OhOrDate >= '" + sFrDate + "' and OhOrDate <= '" + sToDate + "'"
    	+ " and  ohordsts not in ('Abandoned', 'Cancelled')"
    	+ ")" 
    	+ " select char(OhOrDate, usa) as OhOrDate"
    	+ ", (select count(*) from ordf b where a.ohordate=b.ohordate and OhType='Online') as onlcount"
    	+ ", (select dec(Sum(OdTret),11,2) from Rci.MoOrdd where ODCANCEL <> 'Y'"
    	+ " and exists(select 1 from ordf b where odsite=b.ohsite and odord=b.ohord and a.ohordate=b.ohordate and OhType='Online') ) as onlRet"
    	+ ", (select dec(Sum(OdQty),11,0) from Rci.MoOrdd where ODCANCEL <> 'Y'"
    	+ " and exists(select 1 from ordf b where odsite=b.ohsite and odord=b.ohord and a.ohordate=b.ohordate and OhType='Online') ) as onlQty"

    	+ ",  (select count(*) from ordf b where a.ohordate=b.ohordate and OhType='Offline') as oflcount"
    	+ ", (select dec(Sum(OdTret),11,2) from Rci.MoOrdd where  ODCANCEL <> 'Y'" 
    	+ " and exists(select 1 from ordf b where odsite=b.ohsite and odord=b.ohord and a.ohordate=b.ohordate and OhType='Offline') ) as oflRet"
    	+ ", (select dec(Sum(OdQty),11,0) from Rci.MoOrdd where  ODCANCEL <> 'Y'"
    	+ " and exists(select 1 from ordf b where odsite=b.ohsite and odord=b.ohord and a.ohordate=b.ohordate and OhType='Offline') ) as oflQty"
    		
    	+ " from ordf a"            
        + " group by OhOrDate"
        + " order by OhOrDate"
	;   
   
    System.out.println(sStmt);
   	sql_Area = new RunSQLStmt();
   	sql_Area.setPrepStmt(sStmt);
   	rs_Area = sql_Area.runQuery();
	   	   
	// if already excists - delete existing entries
	Vector<String> vOrdDate = new Vector<String>();
	Vector<String> vOnlCnt = new Vector<String>();
	Vector<String> vOnlRet = new Vector<String>();
	Vector<String> vOnlQty = new Vector<String>();
	
	Vector<String> vOflCnt = new Vector<String>();
	Vector<String> vOflRet = new Vector<String>();
	Vector<String> vOflQty = new Vector<String>();
	
	while(sql_Area.readNextRecord())
	{
		vOrdDate.add(sql_Area.getData("OhOrDate"));
		
		if(!sql_Area.getData("onlcount").equals("0")){ vOnlCnt.add(sql_Area.getData("onlcount")); }
		else{vOnlCnt.add(" ");}
		if(sql_Area.getData("onlRet") != null){ vOnlRet.add(sql_Area.getData("onlRet")); }
		else{vOnlRet.add(" ");}
		if(sql_Area.getData("onlQty") != null){ vOnlQty.add(sql_Area.getData("onlQty")); }
		else{vOnlRet.add(" ");}
		
		if(!sql_Area.getData("oflcount").equals("0")){ vOflCnt.add(sql_Area.getData("oflcount")); }
		else{vOflCnt.add(" ");}		
		if(sql_Area.getData("oflQty") != null){ vOflQty.add(sql_Area.getData("oflQty")); }
		else{vOflQty.add(" ");}
		if(sql_Area.getData("oflRet") != null){ vOflRet.add(sql_Area.getData("oflRet")); }
		else{vOflRet.add(" ");}
	}
	sql_Area.disconnect();   	
	   	
	String [] sOrdDate = vOrdDate.toArray(new String [] {});
	String [] sOnlCnt = vOnlCnt.toArray(new String [] {});
	String [] sOnlQty = vOnlQty.toArray(new String [] {});
	String [] sOnlRet = vOnlRet.toArray(new String [] {});
	
	String [] sOflCnt = vOflCnt.toArray(new String [] {});
	String [] sOflQty = vOflQty.toArray(new String [] {});
	String [] sOflRet = vOflRet.toArray(new String [] {});
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Mozu Order Type Summary</title>

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>


<SCRIPT>

//--------------- Global variables -----------------------
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";

var progressIntFunc = null;
var progressTime = 0;
 
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()" >

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu Order Type Summary
            <br>From: <%=sFrDate %> Through: <%=sToDate%> 
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuOrdTypeSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02" id="tblArea">
        <tr class="trHdr01">
          <th class="th02" rowspan=2>Order<br>Date</th>
          <th class="th17" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=3>Online</th>
          <th class="th17" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=3 >Offline</th>
                    
        </tr>
        <tr class="trHdr01">
          <th class="th02">Qty</th>
          <th class="th02">Unit</th>
          <th class="th02">Ret</th>
          
          <th class="th02">Qty</th>
          <th class="th02">Unit</th>
          <th class="th02">Ret</th>
        </tr>        
<!------------------------------- order/sku --------------------------------->
      <%for(int i=0; i < sOrdDate.length; i++) {%>                           
        <tr  class="trdtl04">
        	<td class="td12" nowrap><%=sOrdDate[i]%></td>
        	<td class="td43" nowrap>&nbsp;</td>
        	<td class="td12" nowrap><%=sOnlCnt[i]%></td>
        	<td class="td12" nowrap><%=sOnlQty[i]%></td>
        	<td class="td12" nowrap>$<%=sOnlRet[i]%></td>
        	<td class="td43" nowrap>&nbsp;</td>
        	<td class="td12" style="background:#ccffcc;" nowrap><%=sOflCnt[i]%></td>
        	<td class="td12" style="background:#ccffcc;" nowrap><%=sOflQty[i]%></td>
        	<td class="td12" style="background:#ccffcc;" nowrap><%=sOflRet[i]%></td>
        </tr>
      <%}%>
      
      </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
}
%>