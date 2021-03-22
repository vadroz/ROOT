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
	
	String sStmt = "select case when PSSTR is null then 0 else psstr end as psstr"
	    + ", pyr#, pper, piwe"
	    + ", case when psstr is null  or psstr > 0 then 'N' else  'Y' end as has"
		+ " from rci.fsyper a"
		+ " left join rci.ptschdh on psdate >= piwb and psdate <= piwe"
		+ " where pida >= current date - 6 days" 
		+ "	group by psstr, pyr#, pyr#, pper, piwe " 
		+ " order by psstr, piwe"
		+ " fetch first 4 rows only"
		;
	System.out.println(sStmt);
						
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	Vector<String> vStr = new Vector<String>();
	Vector<String> vFYear = new Vector<String>();
	Vector<String> vFPer = new Vector<String>();
	Vector<String> vWeek = new Vector<String>();
	Vector<String> vHas = new Vector<String>();
						
	while(runsql.readNextRecord())
	{
		vStr.add(runsql.getData("psstr").trim());
		vFYear.add(runsql.getData("pyr#").trim());
		vFPer.add(runsql.getData("pper").trim());
		vWeek.add(runsql.getData("piwe").trim());
		vHas.add(runsql.getData("has").trim());
	}
				
	String [] sStr = vStr.toArray(new String[]{});
	String [] sFYear = vFYear.toArray(new String[]{});
	String [] sFPer = vFPer.toArray(new String[]{});
	String [] sWeek = vWeek.toArray(new String[]{});
	String [] sHas = vHas.toArray(new String[]{});
			 
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
//submit Upload
//==============================================================================
function sbmUpload()
{
	var error = false;
	var msg = "";
	var file = document.Upload.Doc.value.trim();
	 
	if(file == "")
	{
  		error = true;
  		msg = "Please type full file path"
	}
	//Store_03_2016_24.csv'
	var i = file.indexOf("StoreForce") + 11;
	var filenm = file.substring(i);
	i = filenm.indexOf(".csv");
	var filenm = filenm.substring(0, i);
	var arr = filenm.split("_");
	var str = arr[1];
	var yr = arr[2];
	var per = arr[3];
	
	if (error) { alert(msg);}
	else
	{
		document.all.Str.value = str;
		document.all.Year.value = yr;
		document.all.Per.value = per;
		
 		document.Upload.submit();
	}
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
            <br>StoreForce - Store Weekly Schedule Download
            </b>
            <br>
            
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr class="trHdr">
          <th >
          <br>
          
          <form name='Upload'  method='post' enctype='multipart/form-data' action='SfSchedSv.jsp'>
           Schedule File(.csv) <input type='File' name='Doc' class='Small1' size=50><br> 
               <input type='hidden' name='Str'>
               <input type='hidden' name='Year' >
               <input type='hidden' name='Per'>
          </form>
          <button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button>
            <br>
            <br>
           </th>
        </tr>  
        <tr>
          <td>
    <!--------------------- List of fiscal month --------------------->
      <table class="tbl02">
        <tr class="trHdr02">
          <th class="th02" colspan=5>Weeks and schedules</th>
        </tr>  
        <tr class="trHdr01">
          <th class="th02">Fiscal<br>Year</th>
          <th class="th02">Fiscal<br>Period</th>
          <th class="th02">Weekending</th>
          <th class="th02">Store</th>
          <th class="th02">Count</th>
        </tr>        
        <%for(int i=0; i < sFYear.length; i++){%>
          <tr class="trDtl04">
            <td class="td12"><%=sFYear[i]%></td>
            <td class="td12"><%=sFPer[i]%></td>
            <td class="td12"><%=sWeek[i]%></td>
            <td class="td12"><%if(!sStr[i].equals("0")){%><%=sStr[i]%><%}%></td>
            <td class="td18"><%if(!sStr[i].equals("0")){%><%=sHas[i]%><%}%></td>
          </tr>
        <%}%>              
         </table><br><br>      
          
    
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
}
%>