<!DOCTYPE html>	
<%@ page import="server_utility.DbgPgmList, java.util.*, java.text.*"%>
<%
String sSrchPgm = request.getParameter("Pgm");
String sPosToPgm = request.getParameter("ToPgm");

if(sSrchPgm==null){ sSrchPgm = " "; }
if(sPosToPgm==null){ sPosToPgm = " "; }
   
String sUser = session.getAttribute("USER").toString();
DbgPgmList pgmlst = new DbgPgmList(sSrchPgm);
	
%>
<html>
<head>

<title>Dbg_Monitor</title>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>

<SCRIPT>

//--------------- Global variables -----------------------
var SelPgm = "<%=sSrchPgm%>";
var PosToPgm = "<%=sPosToPgm%>";

//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
   getHdrWidth("thead1");
   getDtlRowWidth("tbody1");
   
   setTableonSelPgm();
}
//==============================================================================
// set table on selected position
//==============================================================================
function setTableonSelPgm()
{
	var w = $(window);
	var row = $('#tblData').find('tr').eq( PosToPgm );

	if (row.length){
	    w.scrollTop( row.offset().top - (w.height()/2) );
	}
}
//==============================================================================
// reset count
//==============================================================================
function resetDbgProp(pgm, proc,limit,count)
{
	if(limit == "0"){ limit="1"; }
	count="0";
	
	var url = "DbgPgmSv.jsp?pgm=" + pgm
	 + "&proc=" + proc
	 + "&limit=" + limit
	 + "&count=" + count
	 + "&action=Reset"
	;
	window.frame1.location = url;
}
//==============================================================================
// change count
//==============================================================================
function setDbgProp(pgm, proc, limit, count, action)
{
	var hdr = "Change Count";
	if(action=="Add"){hdr = "Add new Program/Procedure";}
	else if(action=="Delete"){hdr = "Delete Program/Procedure";}
	
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popDbgProp(pgm, proc, limit, count, action )
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=200;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
	  
	  if(action=="Chg")
	  {
		 document.all.Pgm.readOnly = true;
		 document.all.Pgm.style.backgroundColor = "#efefef;";
		 document.all.Proc.readOnly = true;
		 document.all.Proc.style.backgroundColor = "#efefef;";
	  }
	  
	  if(action=="Dlt")
	  {
		 document.all.Pgm.readOnly = true;
		 document.all.Pgm.style.backgroundColor = "#efefef;";
		 document.all.Proc.readOnly = true;
		 document.all.Proc.style.backgroundColor = "#efefef;";
		 document.all.Limit.readOnly = true;
		 document.all.Limit.style.backgroundColor = "#efefef;";
		 document.all.Count.readOnly = true;
		 document.all.Count.style.backgroundColor = "#efefef;";
	  }
	  
	  
	  if(action != "Add")
	  {
		  document.all.Pgm.value = pgm;
		  document.all.Proc.value = proc;
		  document.all.Limit.value = limit;
		  document.all.Count.value = count;
	  }
	  else
	  {
		  document.all.Limit.value = "1";
		  document.all.Count.value = "0";
	  }
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popDbgProp(pgm, proc, limit, count, action )
	{
		var panel = "<table class='tbl01' id='tblLog'>"
	     + "<tr>"
	       + "<td class='td08'>Program Name:</td>"
	       + "<td class='td08'><input name='Pgm' maxlength=10 size=15></td>"	       
	     + "</tr>"
	     + "<tr>"
	       + "<td class='td08'>Process:</td>"
	       + "<td class='td08'><input name='Proc' maxlength=20 size=25></td>"	       
	     + "</tr>"
	     + "<tr>"
	       + "<td class='td08'>Limit:</td>"
	       + "<td class='td08'><input name='Limit' maxlength=3 size=3></td>"	       
	     + "</tr>"
	     + "<tr>"
	       + "<td class='td08'>Count:</td>"
	       + "<td class='td08'><input name='Count' maxlength=3 size=3></td>"	       
	     + "</tr>"
	   ;    
 	  
	    panel += "</table> <br/>";
	    panel += "<tr>"
		  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
		   + "</tr>";
		   
	    panel += "</table>"
	        + "<button onClick='vldDbgProp(&#34;" + action + "&#34;);' class='Small'>Save Changes</button>&nbsp; &nbsp;"
	        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
	    ;
	        
		return panel;
}
//==============================================================================
//validate new value
//==============================================================================
function vldDbgProp(action)
{
	var error = false;
	var msg = "";
	var br = "";
	document.all.tdError.innerHTML="";

	var pgm = document.all.Pgm.value.trim();
	var proc = document.all.Proc.value.trim();
	var limit = document.all.Limit.value.trim();
	var count = document.all.Count.value.trim();
	
	if(action=="Add")
	{
        if(pgm==""){error=true; msg += br + "Enter Program Name"; br="<br>";}
        if(proc==""){error=true; msg += br + "Enter Process Name";  br="<br>";}
        if(limit==""){ limit = "1"; }
        if(count==""){ count = "0"; }
	}
	
	if(error){ document.all.tdError.innerHTML=msg; }
	else{ sbmDbgProp(pgm, proc, limit, count, action); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmDbgProp(pgm, proc, limit, count, action)
{
	var url = "DbgPgmSv.jsp?pgm=" + pgm
	 + "&proc=" + proc
	 + "&limit=" + limit
	 + "&count=" + count
	 + "&action=" + action
	;
	window.frame1.location = url;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//Hide selection screen
//==============================================================================
function setHiLi(row, hi)
{
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
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Programming Utility
            <br>Manage Debug Input String Saving    
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp; 
              <a href="javascript: setDbgProp(' ', ' ',' ', ' ', 'Add');">Add</a>           
          </th>
        </tr>
        </table> 
           
      <table class="tbl02" id="tblData">
        <thead id="thead1">
        <tr class="trHdr01">
          <th class="th13">Program<br>(or Service Program)</th>
          <th class="th13">Procedure</th>
          <th class="th13">Change<br>Limit<br>or  Count</th>
          <th class="th13">Number Of<br>Saved Entries</th>                    
          <th class="th13">Already Saved<br>Count</th>  
          <th class="th13">Reset<br>Count</th>
          <th class="th13">Last Saved<br>Date/Time</th>
          <th class="th13">Delete</th>
        </tr>
       </thead>
       <tbody id="tbody1">
<!------------------------------- Detail --------------------------------->
           <%while(pgmlst.getNext()){  
        	   	pgmlst.setDetail();               
        	   	String sPgmNm = pgmlst.getPgmNm();
   				String sProcNm = pgmlst.getProcNm();
   				String sLimit = pgmlst.getLimit();
   				String sCount = pgmlst.getCount();
   				String sRecDt = pgmlst.getRecDt();
   				String sRecTm = pgmlst.getRecTm();    
           %>
              <tr id="tr<%=sPgmNm%>" class="trDtl04" onmouseover="setHiLi(this, true)" onmousout="setHiLi(this, false)">
                <td class="td11" nowrap><%=sPgmNm%></td>
                <td class="td11" nowrap><%=sProcNm%></td>
                <td class="td18" nowrap><a href="javascript: setDbgProp('<%=sPgmNm%>', '<%=sProcNm%>','<%=sLimit%>', '<%=sCount%>', 'Chg');">Chg</a></td>
                <td class="td12" nowrap><%=sLimit%></td>
                <td class="td12" nowrap><%=sCount%></td>
                <td class="td18" nowrap><a href="javascript: resetDbgProp('<%=sPgmNm%>', '<%=sProcNm%>','<%=sLimit%>', '<%=sCount%>');">Reset</a></td>
                <td class="td12" nowrap><%=sRecDt%> <%=sRecTm%></td>
                <td class="td18" nowrap><a href="javascript: setDbgProp('<%=sPgmNm%>', '<%=sProcNm%>','<%=sLimit%>', '<%=sCount%>', 'Dlt');">Dlt</a></td>
                </th>
              </tr>
           <%}%>           
           
         </tbody>
         </table>
      <!----------------------- end of table ------------------------>   
 </body>
</html>
<%
pgmlst.disconnect();
pgmlst = null;
%>