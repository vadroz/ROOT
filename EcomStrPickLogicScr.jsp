<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup
     , java.sql.*, java.util.*, java.text.*"
%>  
<%
   String sUpdStr = request.getParameter("str");
   String sUpdScr = request.getParameter("scr");
   
//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=EcomStrPickLogicScr.jsp");
}
else
{
	String sUser = session.getAttribute("USER").toString();
	
	if(sUpdScr != null)
	{
		String sInsert = "update rci.EcStrScr set SCSCORE=" + sUpdScr
		  +	", ScUser='" + sUser + "', screcda=current date, screcti=current time"
	      + " where ScStr=" + sUpdStr  	      
		;
	  	System.out.println(sInsert);
	  	ResultSet rslset = null;
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.runSinglePrepStmt(sInsert, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	}	
	
	
	String sPrepStmt = "select SCSTR,SCSCORE,SCUSER,SCRECDA,SCRECTI" 
			+ "	From rci.EcStrScr"
			+ " order by store";
  	//System.out.println(sPrepStmt);
	   	
   	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);
	runsql.runQuery();
	Vector vStore = new Vector();
	Vector vScore = new Vector();
	Vector vUser = new Vector();
	Vector vRecDa = new Vector();
	Vector vRecTm = new Vector();
		
	while(runsql.readNextRecord())
	{	
		vStore.add(runsql.getData("SCSTR"));
		vScore.add(runsql.getData("SCSCORE"));
		vUser.add(runsql.getData("SCUSER"));
		vRecDa.add(runsql.getData("SCRECDA"));
		vRecTm.add(runsql.getData("SCRECTI"));
	}	
	runsql.disconnect();
	runsql = null;	
		
	String [] sStore = (String []) vStore.toArray(new String[vStore.size()]);
	String [] sScore = (String []) vScore.toArray(new String[vScore.size()]);
	String [] sRecUs = (String []) vUser.toArray(new String[vUser.size()]);
	String [] sRecDa = (String []) vRecDa.toArray(new String[vRecDa.size()]);
	String [] sRecTm = (String []) vRecTm.toArray(new String[vRecTm.size()]);
		
	CallAs400SrvPgmSup as4pgm = new CallAs400SrvPgmSup();
	String sStrJsa = as4pgm.cvtToJavaScriptArray(sStore);
	String sScrJsa = as4pgm.cvtToJavaScriptArray(sScore);
	as4pgm = null;   	
   %>

<html>
<head>
<title>EC-Str PL Scores</title>
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
function setScore(str)
{
	var hdr = "Store: " + str;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popScore(str)
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
function popScore(str)
{
	var panel = "<table class='tbl02'>";
	panel += "<tr class='DataTable4'>"
		 + "<td nowrap class='Medium'colspan=10>Score: "
		    + "<input name='Score' size=5 maxlength=5>"
		 + "</td>"
	  + "</tr>"
		  
	panel += "<tr class='DataTable4'>"
	      + "<td id='tdErrorAll' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
	    + "</tr>"

	panel += "<tr class='DataTable4'>"
	      + "<td nowrap class='Small' colspan=10><button onClick='vldScore("
	         + "&#34;" + str + "&#34;"
	         + ")' class='Small'  id='btnSbm'>Submit</button>"
	         + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Cancel</button>"
		  + "</td></tr>"
	return panel;	  
}
//==============================================================================
//validate score
//==============================================================================
function vldScore(str)
{	
	var error = false;
	var msg = "";
	var br = "";
	
	document.all.tdErrorAll.innerHTML = "";
	document.all.btnSbm.disable = true;
	
	var scr = document.all.Score.value.trim();
	if(scr==""){error = true; msg += br + "Please enter score number"; br = "<br>"; }
	else if(isNaN(scr)){error = true; msg += br + "<br>The score is not numeric"; br = "<br>"; }
		 
	if(error)
	{
		document.all.tdErrorAll.innerHTML = msg; 
		document.all.btnGenPackId.disabled = false; 
	}
	else { sbmScore(str, scr);	}
}
//==============================================================================
// submit new score
//==============================================================================
function sbmScore(str, scr)
{
   var url="EcomStrPickLogicScr.jsp?str=" + str + "&scr=" + scr;
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
      <br>ECOM Store Pick Logic Scores
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp;<br>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl02">
        <tr>
          <th class="th01">Store</th>
          <th class="th01">Score</th>
          <th class="th01">User, Date, Time</th>          
        </tr>        
<!------------------------------- Data Detail --------------------------------->
        <%for(int i=0; i < sStore.length; i++){%>
        <tr>
          <td class="td01"><a href="javascript: setScore('<%=sStore[i]%>');"><%=sStore[i]%></a></td>
          <td class="td01"><%=sScore[i]%></td>
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