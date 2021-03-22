<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup
     , java.sql.*, java.util.*, java.text.*"
%>  
<%
   String sUpdStr = request.getParameter("str");
   String sUpdHrs = request.getParameter("hrs");
   
//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=PayStrCompHrs.jsp");
}
else
{
	String sUser = session.getAttribute("USER").toString();
	
	if(sUpdHrs != null)
	{
		String sInsert = "update rci.PRSTCMHR set ShHrs=" + sUpdHrs
		  +	", ShUser='" + sUser + "', shrecda=current date, shrecti=current time"
	      + " where ShStr=" + sUpdStr  	      
		;
	  	System.out.println(sInsert);
	  	ResultSet rslset = null;
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.runSinglePrepStmt(sInsert, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	}	
	
	
	String sPrepStmt = "select ShSTR,ShHrs,ShUSER, char(ShRECDA, USA) as ShRECDA, char(ShRECTI, USA) as ShRECTI" 
			+ "	From rci.PRSTCMHR"
			+ " order by store";
  	//System.out.println(sPrepStmt);
	   	
   	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);
	runsql.runQuery();
	Vector vStore = new Vector();
	Vector vHours = new Vector();
	Vector vUser = new Vector();
	Vector vRecDa = new Vector();
	Vector vRecTm = new Vector();
		
	while(runsql.readNextRecord())
	{	
		vStore.add(runsql.getData("ShSTR"));
		vHours.add(runsql.getData("ShHrs"));
		vUser.add(runsql.getData("ShUSER"));
		vRecDa.add(runsql.getData("ShRECDA"));
		vRecTm.add(runsql.getData("ShRECTI"));
	}	
	runsql.disconnect();
	runsql = null;	
		
	String [] sStore = (String []) vStore.toArray(new String[vStore.size()]);
	String [] sHours = (String []) vHours.toArray(new String[vHours.size()]);
	String [] sRecUs = (String []) vUser.toArray(new String[vUser.size()]);
	String [] sRecDa = (String []) vRecDa.toArray(new String[vRecDa.size()]);
	String [] sRecTm = (String []) vRecTm.toArray(new String[vRecTm.size()]);
		
	CallAs400SrvPgmSup as4pgm = new CallAs400SrvPgmSup();
	String sStrJsa = as4pgm.cvtToJavaScriptArray(sStore);
	String sScrJsa = as4pgm.cvtToJavaScriptArray(sHours);
	as4pgm = null;   	
   %>

<html>
<head>
<title>Payroll Str Hrs</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script>
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
//initilial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// set
//==============================================================================
function setHours(str)
{
	var hdr = "Store: " + str;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popHours(str)
	     + "</td></tr>"
	   + "</table>"

	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 330;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate panel
//==============================================================================
function popHours(str)
{
	var panel = "<table class='tbl02'>";
	panel += "<tr class='DataTable4'>"
		 + "<td nowrap class='Medium'colspan=10>SPH: "
		    + "<input name='Hours' size=5 maxlength=5>"
		 + "</td>"
	  + "</tr>"
		  
	panel += "<tr class='DataTable4'>"
	      + "<td id='tdErrorAll' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
	    + "</tr>"

	panel += "<tr class='DataTable4'>"
	      + "<td nowrap class='Small' colspan=10><button onClick='vldHours("
	         + "&#34;" + str + "&#34;"
	         + ")' class='Small'  id='btnSbm'>Submit</button>"
	         + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Cancel</button>"
		  + "</td></tr>"
	return panel;	  
}
//==============================================================================
//validate Hours
//==============================================================================
function vldHours(str)
{	
	var error = false;
	var msg = "";
	var br = "";
	
	document.all.tdErrorAll.innerHTML = "";
	document.all.btnSbm.disable = true;
	
	var hrs = document.all.Hours.value.trim();
	if(hrs==""){error = true; msg += br + "Please enter hours number"; br = "<br>"; }
	else if(isNaN(hrs)){error = true; msg += br + "<br>The hours is not numeric"; br = "<br>"; }
		 
	if(error)
	{
		document.all.tdErrorAll.innerHTML = msg; 
		document.all.btnGenPackId.disabled = false; 
	}
	else { sbmHours(str, hrs);	}
}
//==============================================================================
// submit new Hours
//==============================================================================
function sbmHours(str, hrs)
{
   var url="PayStrCompHrs.jsp?str=" + str + "&hrs=" + hrs;
   window.location.href = url;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel(obj)
{
	document.all[obj].innerHTML = " ";
	document.all[obj].style.visibility = "hidden";
}
//==============================================================================
// reload page
//==============================================================================
function restart(){ window.location.reload(); }

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!----------------------------------------------------------------------------->


<table class="tbl01">
     <tr class="trHdr">
<!-------------------------------------------------------------------->
      <td>
      <b>Retail Concepts, Inc
      <br>Payroll Store Comparison Hours for Daily Hourss
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp;<br>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl02">
        <tr>
          <th class="th01">Store</th>
          <th class="th01">SPH</th>
          <th class="th01">User, Date, Time</th>          
        </tr>        
<!------------------------------- Data Detail --------------------------------->
        <%for(int i=0; i < sStore.length; i++){%>
        <tr>
          <td class="td01"><a href="javascript: setHours('<%=sStore[i]%>');"><%=sStore[i]%></a></td>
          <td class="td01"><%=sHours[i]%></td>
          <td class="td01"><%=sRecUs[i]%>, <%=sRecDa[i]%>, <%=sRecTm[i]%></td>
        </tr>
        
        <%} %>   
      </table>
     </td>
    </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </form>
 </body>
</html>


<%
}%>