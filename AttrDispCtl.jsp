<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet"%>  
<%
 String sAttr = request.getParameter("Attr");
 String sHide = request.getParameter("Hide");
 String sDisp = request.getParameter("Disp");
 
if (session.getAttribute("USER")!=null)
{
	if(sAttr != null && sHide != null && sDisp != null)
	{
		String sStmt = "update rci.MoAttrH set";
		
		if(sHide.equals("M")){ sStmt += " PAHIDEM='" + sDisp + "'"; }
		else if(sHide.equals("E")){ sStmt += " PAHIDEA='" + sDisp + "'"; }
		else if(sHide.equals("I")){ sStmt += " PAHIDEI='" + sDisp + "'"; }
		
		sStmt += " where pasite='11961' and PaAttr='" + sAttr + "'";				
					
		System.out.println("\n" + sStmt);
					
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		runsql.disconnect();
		runsql = null;
	} 
	
	
	String sStmt = "select PAID, PAATTR, PAFQN,PATYPE,PAHIDEM,PAHIDEA,PAHIDEI" 
	 + " from rci.MoAttrH" 
	 + " where pasite='11961'" 
	 + " order  by PAATTR"
	 ;
	
	//System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vId = new Vector<String>();	
	Vector<String> vAttr = new Vector<String>();
	Vector<String> vFqn = new Vector<String>();
	Vector<String> vType = new Vector<String>();
	Vector<String> vHideM = new Vector<String>();
	Vector<String> vHideE = new Vector<String>();
	Vector<String> vHideI = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vId.add(runsql.getData("PaId").trim());
		vAttr.add(runsql.getData("PAATTR").trim());	
		vFqn.add(runsql.getData("PAFQN").trim());
		vType.add(runsql.getData("PATYPE").trim());		
		vHideM.add(runsql.getData("PAHIDEM").trim());
		vHideE.add(runsql.getData("PAHIDEA").trim());
		vHideI.add(runsql.getData("PAHIDEI").trim());
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

<title>Attr Display Ctl</title>

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
            <br>Attribute Display Control
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
          <th class="th02" rowspan=2>ID</th>
          <th class="th02" rowspan=2>Attribute</th>
          <th class="th02" rowspan=2>FQN</th>
          <th class="th02" rowspan=2>Type</th>
          <th class="th02" colspan=3>Hide</th>
        </tr>    
        
        <tr class="trHdr01">
         <th class="th02">Maintenance</th>
         <th class="th02">Export</th>
         <th class="th02">Item<br>Attribution</th>
        </tr>
        
        <%
        String sRowCls = "trDtl06";
        for(int i=0; i < vAttr.size(); i++){
        	if(sRowCls.equals("trDtl06")){ sRowCls = "trDtl04";}
        	else { sRowCls = "trDtl06"; }
        	
        	String sCheckedM = "";
        	if(vHideM.get(i).equals("Y")){ sCheckedM = "checked"; }
        	String sCheckedE = "";
        	if(vHideE.get(i).equals("Y")){ sCheckedE = "checked"; }
        	String sCheckedI = "";
        	if(vHideI.get(i).equals("Y")){ sCheckedI = "checked"; }
        %>
          
          <tr id="trId" class="<%=sRowCls%>">
	        <td class="td11" nowrap><%=vId.get(i)%></td>
	        <td class="td11" nowrap><%=vAttr.get(i)%></td>
	        <td class="td11" nowrap><%=vFqn.get(i)%></td>
	        <td class="td18" nowrap><%=vType.get(i)%></td>
	        <td class="td18" nowrap>
	           	<input type="checkbox" name="HideM" id="HideM" value="Y" <%=sCheckedM%> 
	           		onclick="setHide('<%=vAttr.get(i)%>', this)">
	        </td>
	        <td class="td18" nowrap>
	        	<input type="checkbox" name="HideE" id="HideE" value="Y" <%=sCheckedE%>
	        		onclick="setHide('<%=vAttr.get(i)%>', this)">
	        </td>
	        <td class="td18" nowrap> 
	        	<input type="checkbox" name="HideI" id="HideI" value="Y" <%=sCheckedI%>
	        		onclick="setHide('<%=vAttr.get(i)%>', this)">
	        </td>
	      </tr>   
        <%}%>
       </table>
       
      
    </td>
   </tr>
 </table>
   
 </body>
</html>
<%}%>