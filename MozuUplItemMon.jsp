<!DOCTYPE html>	
<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
    String sCls = request.getParameter("Cls");
    String sVen = request.getParameter("Ven");
    String sSty = request.getParameter("Sty"); 

    
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuUplItemMon.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStmt = "Select IDRECTS, IDSITE, IDPRNT,digits(IDCLS) as idcls" 
      + ",digits(IDVEN) as idven, digits(IDSTY) as idsty,digits(IDCLR) as idclr,digits(IDSIZ) as idsiz"
	  + ",IDPROC,IDERFLG,IDERR,IDUSER"
	  +	", (select max(ides) from iptsfil.IpItHdr where icls=idcls and iven=idven and isty=idsty) as ides"			  
      + " from RCI.MOITDLOG";
	
	if(sCls != null)
	{
	   sStmt += " where idcls=" + sCls + " and idven=" + sVen + " and idsty=" + sSty;	
	}
	
    sStmt += " order by IDRECTS desc,IDCLS,IDVEN,IDSTY,IDCLR,IDSIZ,IDSITE,IDPRNT"
      + " fetch first 50 rows only"
     ;
    System.out.println(sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);  
	ResultSet rs = runsql.runQuery();

	Vector vSite = new Vector();
	Vector vParent = new Vector();
	Vector vCls = new Vector();
	Vector vVen = new Vector();
	Vector vSty = new Vector();
	Vector vClr = new Vector();
	Vector vSiz = new Vector();
	Vector vDesc = new Vector();
	Vector vUser = new Vector();
	Vector vRecTs = new Vector();
	Vector vErrFlg = new Vector();
	Vector vError = new Vector();
	
	while(runsql.readNextRecord())
	{
	    vSite.add(runsql.getData("idsite").trim());
	    vParent.add(runsql.getData("idprnt").trim());
	    vCls.add(runsql.getData("idCls").trim());
	    vVen.add(runsql.getData("idVen").trim());
	    vSty.add(runsql.getData("idSty").trim());
	    vClr.add(runsql.getData("idClr").trim());
	    vSiz.add(runsql.getData("idSiz").trim());
	    vDesc.add(runsql.getData("ides").trim());
	    vUser.add(runsql.getData("iduser").trim());
	    vRecTs.add(runsql.getData("idrects").trim());
	    vErrFlg.add(runsql.getData("idErFlg").trim());
	    vError.add(runsql.getData("idErr").trim());
	}
	rs.close();
	runsql.disconnect();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Mozu Upload Monitor</title>

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
   progressIntFunc = setInterval(function() { location.reload() }, 1000 * 30);
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
            <br>Mozu - Recently Upload Items Monitor 
            <br>(refreshes every 30 seconds)  
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02" id="tblDtl">
        <tr class="trHdr01">
          <th class="th02">No.</th>
          <th class="th02">Site</th>
          <th class="th02">Parent</th>
          <th class="th02">Item Number</th>
          <th class="th02">Description</th>          
          <th class="th02">User</th>
          <th class="th02">Date & Time</th>
          <th class="th02">Error Y?</th>
          <th class="th02">Error</th>          
        </tr>       
<!------------------------------- Detail --------------------------------->
		<tbody id="tbDtl">
		<%for(int i=0; i < vCls.size(); i++ ){%>
		   <tr id="trId" class="trDtl04">
		      <td class="td12" nowrap><%=(i + 1)%></td>
              <td class="td12" nowrap><%=vSite.get(i)%></td>
              <td class="td12" nowrap><%=vParent.get(i)%></td>
              <td class="td12" nowrap><%=vCls.get(i)%><%=vVen.get(i)%><%=vSty.get(i)%>
                -<%=vClr.get(i)%><%=vSiz.get(i)%>
              </td>
              <td class="td12" nowrap><%=vDesc.get(i)%></td>
              <td class="td12" nowrap><%=vUser.get(i)%></td>
              <td class="td12" nowrap><%=vRecTs.get(i)%></td>
              <td class="td18" nowrap><%=vErrFlg.get(i)%></td>
              <td class="td12" nowrap><input class="Small" value="<%=vError.get(i)%>" size="100" readonly></td>
           </tr>     
		<%}%>
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