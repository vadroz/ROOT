<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=SfStrSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	String sStmt = "select pyr#, pmo#, char(pimb,usa) as pimb, char(pime, usa) as pime"
		+ " from rci.fsyper a"
		+ " where exists(select 1 from rci.fsyper b where b.pida = current date " 
		+ " and ( b.pyr# = a.pyr# or b.pyr# + 1 = a.pyr#) and b.pimb <= a.pimb)"
		+ "	group by pyr#, pmo# , pimb, pime " 
		+ " order by   pyr#, pmo#";
	System.out.println(sStmt);
						
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	Vector<String> vFYear = new Vector<String>();
	Vector<String> vFMon = new Vector<String>();
	Vector<String> vMonBeg = new Vector<String>();
	Vector<String> vMonEnd = new Vector<String>();
						
	while(runsql.readNextRecord())
	{
		vFYear.add(runsql.getData("pyr#").trim());
		vFMon.add(runsql.getData("pmo#").trim());
		vMonBeg.add(runsql.getData("pimb").trim());
		vMonEnd.add(runsql.getData("pime").trim());
	}
				
	String [] sFYear = vFYear.toArray(new String[]{});
	String [] sFMon = vFMon.toArray(new String[]{});
	String [] sMonBeg = vMonBeg.toArray(new String[]{});
	String [] sMonEnd = vMonEnd.toArray(new String[]{});
			 
		rs.close();
		runsql.disconnect();
	
	
	sStmt = "select SfYear, SfMon, max(char(SFRECDT, usa)) as lstdt, max(char(SFRECTM, usa)) as lsttm" 
	  + " from rci.SfMnSum group by SfYear, SfMon order by SfYear desc, SfMon desc";
	//System.out.println(sStmt);
			
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();
	Vector<String> vYear = new Vector<String>();
	Vector<String> vMon = new Vector<String>();
	Vector<String> vLstDt = new Vector<String>();
	Vector<String> vLstTm = new Vector<String>();
			
	while(runsql.readNextRecord())
	{
		vYear.add(runsql.getData("SfYear").trim());
		vMon.add(runsql.getData("SfMon").trim());
		vLstDt.add(runsql.getData("lstdt").trim());
		vLstTm.add(runsql.getData("lsttm").trim());
	}
			
	String [] sYear = vYear.toArray(new String[]{});
	String [] sMon = vMon.toArray(new String[]{});
	String [] sLstDt = vLstDt.toArray(new String[]{});
	String [] sLstTm = vLstTm.toArray(new String[]{});
		 
	rs.close();
	runsql.disconnect();
	
	

%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 
<title>StoreForce Download</title>

<SCRIPT>

//--------------- Global variables -----------------------

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}

//==============================================================================
// open generated data
//==============================================================================
function genCsv(year, mon)
{
	var url="SfStrSumGen.jsp?Year=" + year + "&Mon=" + mon
		   

	//alert(url);
	window.frame1.location.href=url;
}

//==============================================================================
// generate storeforse montly summary
//==============================================================================
function opnCsv(year, mon, type)
{
	var url="SfStrSumDwn.jsp?Year=" + year + "&Mon=" + mon
	  + "&Type=" + type;
		   

	//alert(url);
	window.open(url);
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
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->


      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>StoreForce - Store Summary Download
            </b>
            <br>
            
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>
    <!--------------------- List of fiscal month --------------------->
      <table class="tbl02">
        <tr class="trHdr02">
          <th class="th02" colspan=5>Generate new file for selected Fiscal Month</th>
        </tr>  
        <tr class="trHdr01">
          <th class="th02">Fiscal Year</th>
          <th class="th02">Fiscal Month</th>
          <th class="th02">Month Beginning</th>
          <th class="th02">Month Ending</th>
          <th class="th02">Generate<br>CSV</th>
           
        </tr>        
        <%for(int i=0; i < sFYear.length; i++){%>
          <tr class="trDtl04">
            <td class="td12"><%=sFYear[i]%></td>
            <td class="td12"><%=sFMon[i]%></td>
            <td class="td12"><%=sMonBeg[i]%></td>
            <td class="td12"><%=sMonEnd[i]%></td>
            <td class="td18"><a href="javascript: genCsv('<%=sFYear[i]%>', '<%=sFMon[i]%>');">G</a></td>
          </tr>
        <%}%>              
         </table><br><br>      
          
          
    <!--------------------- List of ready downloads --------------------->
      <table class="tbl02">
        <tr class="trHdr02">
          <th class="th02" colspan=5>Download existing file for selected Fiscal Month</th>
        </tr>
        <tr class="trHdr01">
          <th class="th02">Fiscal Year</th>
          <th class="th02">Fiscal Month</th>
          <th class="th02">Date/Time</th>
          <th class="th02">Download<br>Selling</th>
          <th class="th02">Download<br>Non-Selling</th>
        </tr>        
        <%for(int i=0; i < sYear.length; i++){%>
          <tr class="trDtl04">
            <td class="td12"><%=sYear[i]%></td>
            <td class="td12"><%=sMon[i]%></td>
            <td class="td12"><%=sLstDt[i]%> <%=sLstTm[i]%></td>
            <td class="td18"><a href="javascript: opnCsv('<%=sYear[i]%>', '<%=sMon[i]%>', 'S');">D</a></td>
            <td class="td18"><a href="javascript: opnCsv('<%=sYear[i]%>', '<%=sMon[i]%>','N');">D</a></td>
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