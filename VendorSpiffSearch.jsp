<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet"%>  
<%
 String sSearch = request.getParameter("Search");
 
if (session.getAttribute("USER")!=null)
{
	 
	String sStmt = "select rank() over(order by SPEDATE, SPETIME) as rank" 
	 + ",SPSTR, SPEMP,SPPAYEE,SPAMT,SPEDATE,SPETIME, snnote"
	 + " from rci.StrPtyD" 
	 + " inner join rci.StrPtyN on snidnum=spidnum" 
	 + " where SPEDATE>='2020-01-13'" 
	 + " and SPSPIFF = 'VENDOR'" 
	 + " and upper(snnote) like ('%NIL%')" 
	 + " order by SPEDATE, SPETIME"
	 ;
	
	//System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vRank = new Vector<String>();	
	Vector<String> vStr = new Vector<String>();
	Vector<String> vEmp = new Vector<String>();
	Vector<String> vPayee = new Vector<String>();
	Vector<String> vAmt = new Vector<String>();
	Vector<String> vEntDt = new Vector<String>();
	Vector<String> vEntTm = new Vector<String>();
	Vector<String> vNote = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vRank.add(runsql.getData("rank").trim());
		vStr.add(runsql.getData("spstr").trim());	
		vEmp.add(runsql.getData("spemp").trim());
		vPayee.add(runsql.getData("SPPAYEE").trim());		
		vAmt.add(runsql.getData("spamt").trim());
		vEntDt.add(runsql.getData("SPEDATE").trim());
		vEntTm.add(runsql.getData("SPETIME").trim());
		vNote.add(runsql.getData("snnote").trim());
	}
	rs.close();
	runsql.disconnect();
	 
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>Nills Spiff Ctl</title>

<SCRIPT>
//--------------- Global variables -----------------------
var BegTime = "Current";
var progressIntFunc = null;
var progressTime = 0;


SelPos = [0,0];

//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{
		isSafari = true;
	}
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvEdi"]); 
}

//==============================================================================
// get PO List for selected vendor and status
//==============================================================================
function setHide(attr, inp)
{
	var inpNm = inp.name;
	var disp = "";
	if(inp.checked){ disp = "Y"; }
	
	var url = "AttrDispCtl.jsp?Attr=" + attr;
	
	if(inpNm == "HideM"){ url += "&Hide=M&Disp=" + disp; }
	else if(inpNm == "HideE"){ url += "&Hide=E&Disp=" + disp; }
	else if(inpNm == "HideI"){ url += "&Hide=I&Disp=" + disp; }
		
	window.frame1.location.href = url;
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
<div id="dvEdi" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Store Petty Cash - Spiff Control
            <br>Vendor: Nils 
            <br>Search description: "*Nil*"
            <br>Start Date: 01/13/2020      
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font>
          </th>                    
        </tr>
  <tr class="trHdr">
    <td>
       <table class="tbl02" id="tblSsn">
        <tr class="trHdr01">
          <th class="th02" >No.</th>
          <th class="th02" >Str</th>
          <th class="th02" >Employee</th>
          <th class="th02" >Amt</th>
          <th class="th02" >Description</th>
          <th class="th02" >Entry Date/Time</th>
        </tr>    
        
        <%
        String sRowCls = "trDtl06";
        Double dTot = 0.00;
        for(int i=0; i < vStr.size(); i++)
        {
        	if(sRowCls.equals("trDtl06")){ sRowCls = "trDtl04";}
        	else { sRowCls = "trDtl06"; }
        	
        	dTot = dTot.sum(dTot,  Double.parseDouble(vAmt.get(i)));
        %>
          
          <tr id="trId" class="<%=sRowCls%>">
	        <td class="td11" nowrap><%=vRank.get(i)%></td>
	        <td class="td11" nowrap><%=vStr.get(i)%></td>
	        <td class="td11" nowrap><%=vEmp.get(i)%> - <%=vPayee.get(i)%></td>
	        <td class="td12" nowrap>$<%=vAmt.get(i)%></td>	        
	        <td class="td11" nowrap><%=vNote.get(i)%></td>
	        <td class="td18" nowrap><%=vEntDt.get(i)%> <%=vEntTm.get(i)%></td>	         
	      </tr>   
        <%}%>
        <tr id="trId" class="trDtl12">
            <td class="td11" nowrap>Total</td>
            <td class="td11" colspan=2>&nbsp;</td>
	        <td class="td12" nowrap>$<%=dTot%></td>
	        <td class="td11" colspan=2>&nbsp;</td>
	    </tr>
       </table>
       
      
    </td>
   </tr>
 </table>
   
 </body>
</html>
<%}%>