<%@ page import="rciutility.RunSQLStmt, java.sql.*,rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=InetStrGrpLst.jsp&APPL=ALL");
}
else     
{
   StoreSelect strsel = new StoreSelect();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrNmLst = strsel.getStrNameLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   
   String sUser = session.getAttribute("USER").toString(); 
   
   String sStmt = "select ISGRP,ISGRPNM,ISDESC, ISSORT " 
     + " from rci.istrgrp "
     + " order by issort"
   ;
   //System.out.println(sStmt); 
   RunSQLStmt sql_Grp = new RunSQLStmt();
   sql_Grp.setPrepStmt(sStmt);	    
   ResultSet rs_Grp = sql_Grp.runQuery();		    
   Vector vGrp = new Vector();
   Vector vGrpNm = new Vector();
   Vector vGrpDesc = new Vector();
   Vector vGrpSort = new Vector();
   while(sql_Grp.readNextRecord())		    
   {   	
	   vGrp.add(sql_Grp.getData("IsGrp").trim());
	   vGrpNm.add(sql_Grp.getData("IsGrpNm").trim());
	   vGrpDesc.add(sql_Grp.getData("IsDesc").trim());
	   vGrpSort.add(sql_Grp.getData("IsSort").trim());
   }
   sql_Grp.disconnect();
   
%>
<html>
<head>
<title>Str Grp</title>

<style>body {background:ivory;text-align:center; }
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { background:#FFE4C4;text-align:center;}

        th.DataTable  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:14px }


        tr.DataTable  { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }        
        tr.DataTable2  { background:gray; color:white; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#F6CEF5; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}

        td.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable4 { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        .Small {font-size:10px }
        select.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}
              
       div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
        td.Error { color:red;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:left;}
</style>
<SCRIPT language="JavaScript1.2">

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
//set selected Quantity
//==============================================================================
function setGrp(grp,name,desc, sort, action)
{
	var hdr = "Add New Group";
	if(action=="UpdGrp"){ hdr = "Update Group"; }
	else if(action=="DltGrp"){ hdr = "Delete Group"; }
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  	  	+ "<tr>"
    		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
    		+ "<td class='BoxClose' valign=top>"
		      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    		+ "</td></tr>"
 		+ "<tr><td class='Prompt' colspan=2>" + popGrpPanel(grp,name,desc, sort, action)
  		+ "</td></tr>"
	+ "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 100;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";	
	
	if(action!="AddGrp")
	{
		document.all.Group.value = grp;
		document.all.Group.readOnly = true;		
		document.all.GrpNm.value = name;
		document.all.GrpDesc.value = desc;
		document.all.Sort.value = sort;
	}
}
//==============================================================================
// populate store group entry panel
//==============================================================================
function popGrpPanel(grp,name,desc, sort, action)
{
	var panel= "<table cellPadding='0' cellSpacing='0'>"
	    + "<tr class='DataTable1'>"
	       + "<td nowrap class='DataTable1'>Group: </td>"
	       + "<td nowrap class='DataTable1'><input class='Small' name='Group' maxlength=10 size=10></td>"
	    + "</tr>"
	    + "<tr class='DataTable1'>"
	       + "<td nowrap class='DataTable1'>Button Label: </td>"
	       + "<td nowrap class='DataTable1'><input class='Small' name='GrpNm' maxlength=20 size=20></td>"
	    + "</tr>"
	    + "<tr class='DataTable1'>"
	       + "<td nowrap class='DataTable1'>Description: </td>"
	       + "<td nowrap class='DataTable1'><input class='Small' name='GrpDesc' maxlength=50 size=50></td>"
	    + "</tr>"
	    
	    + "<tr class='DataTable1'>"
	       + "<td nowrap class='DataTable1'>Sort: </td>"
	       + "<td nowrap class='DataTable1'><input class='Small' name='Sort' maxlength=3 size=3></td>"
	    + "</tr>"
	    
	    + "<tr class='DataTable1'>"
	       + "<td class='Error' id='tdError' colspan=2></td>"	       
	    + "</tr>"
	    + "<tr>"
	         + "<td nowrap class='DataTable1'><button onClick='vldGrp(&#34;"+ action +"&#34;)' class='Small'>Submit</button> &nbsp;"
	       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	    + "</td></tr></table>"
	return panel;
}
//==============================================================================
//validate store group entries
//==============================================================================
function vldGrp(action)
{
	var error=false;
	var msg="";
	document.all.tdError.innerHTML = msg;
	var br = "";
	
	var grp = document.all.Group.value.trim();
	if(grp==""){ error=true; msg+= br + "Please enter Group."; br = "<br>"; }
	
	var name = document.all.GrpNm.value.trim();
	if(name==""){ error=true; msg+= br + "Please enter Button Label."; br = "<br>"; }
	
	var desc = document.all.GrpDesc.value.trim();
	if(desc==""){ error=true; msg+= br + "Please enter Description."; br = "<br>"; }
	
	var sort = document.all.Sort.value.trim();
	if(sort==""){ error=true; msg+= br + "Please enter sort sequence."; br = "<br>"; }
	else if(isNaN(sort)){ error=true; msg+= br + "Sort sequence is not numeric."; br = "<br>"; }
		
	if(error){ document.all.tdError.innerHTML = msg; }
	else{ sbmGrp(grp, name, desc, sort, action); }
}
//==============================================================================
//submit store group entries
//==============================================================================
function sbmGrp(grp, name, desc, sort, action)
{
	var nwelem = window.frame1.document.createElement("div");
	   nwelem.id = "dvSbmGrp"
	   aSelOrd = new Array();

	   var html = "<form name='frmChgGrp'"
	    + " METHOD=Post ACTION='InetStrGrpSave.jsp'>"
	    + "<input name='Grp'>"
	    + "<input name='Name'>"
	    + "<input name='Desc'>"
	    + "<input name='Sort'>"	    
	    + "<input name='Action'>"
	   html += "</form>"

	   nwelem.innerHTML = html;
	   window.frame1.document.appendChild(nwelem);

	   window.frame1.document.all.Grp.value = grp.replace(/\n\r?/g, '<br />');
	   window.frame1.document.all.Name.value = name.replace(/\n\r?/g, '<br />');
	   window.frame1.document.all.Desc.value = desc.replace(/\n\r?/g, '<br />');
	   window.frame1.document.all.Sort.value = sort;
	   window.frame1.document.all.Action.value=action;

	   window.frame1.document.frmChgGrp.submit();
}
//==============================================================================
// save or store for group  
//==============================================================================
function setStr(grp, obj)
{
	var nwelem = window.frame1.document.createElement("div");
	   nwelem.id = "dvSbmStr"
	   aSelOrd = new Array();

	   var html = "<form name='frmChgStr'"
	    + " METHOD=Post ACTION='InetStrGrpSave.jsp'>"
	    + "<input name='Grp'>"
	    + "<input name='Str'>"	    	    
	    + "<input name='Action'>"
	   html += "</form>"

	   nwelem.innerHTML = html;
	   window.frame1.document.appendChild(nwelem);

	   var str = obj.value;
	   var action = "AddStr";
	   if(!obj.checked){ action="DltStr"; }
	   
	   window.frame1.document.all.Grp.value = grp.replace(/\n\r?/g, '<br />');
	   window.frame1.document.all.Str.value = str;
	   window.frame1.document.all.Action.value=action;

	   window.frame1.document.frmChgStr.submit();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//restart this page
//==============================================================================
function restart(){ location.reload();  }
//==============================================================================
//highlight row for easier navigation
//==============================================================================
function hiliRow(row,hili)
{
	if(hili){ row.style.background="gold";}
	else{ row.style.background="white";}
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=0 class="DataTable" cellPadding="0" cellSpacing="0">
        <thead>
        <tr>
          <th class="DataTable1" style="border-right:none" colspan=31>
            <b>Retail Concepts, Inc
              <br>Internet Store Group List            
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <a href="javascript: setGrp(null,null,null,null, 'AddGrp')">Add New Group</a>        

       <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="DatTaable">
           <th class="DataTable" rowspan="2">Group</th>
           <th class="DataTable" rowspan="2">Sort</th>
           <th class="DataTable" rowspan="2">Button<br>Abbreviation</th>
           <th class="DataTable" rowspan="2">Description</th>
           <th class="DataTable" colspan="<%=iNumOfStr%>">Stores</th>
           <th class="DataTable" rowspan="2">Upd</th>
           <th class="DataTable" rowspan="2">Dlt</th>
         </tr>
         <tr class="DataTable">
           <%for(int i=0; i < iNumOfStr; i++){%>
              <th class="DataTable"><%=sStrLst[i]%></th>
           <%}%> 
         </tr>
 <!------------------------------- Data Detail --------------------------------->
        <%for(int i=0; i < vGrp.size(); i++){
        	sStmt = "select itstr " 
        	   + " from rci.istrgrps where itgrp='" + vGrp.get(i) + "' order by itstr";
        	   
        	RunSQLStmt sql_Str = new RunSQLStmt();
        	sql_Str.setPrepStmt(sStmt);	    
        	ResultSet rs_Str = sql_Str.runQuery();		    
        	Vector vStr = new Vector();
        	while(sql_Str.readNextRecord()){ vStr.add(sql_Str.getData("ItStr").trim()); }
        	sql_Str.disconnect();
        	  
        	String [] sGrpStr = new String[vStr.size()];
        	for(int j=0; j < vStr.size(); j++)
        	{         		   
        	   sGrpStr[j] = (String)vStr.get(j);
            }  
        %>
           <tr class="DataTable" onmouseover="hiliRow(this,true)" onmouseout="hiliRow(this,false)"> 
             <td class="DataTable1"><%=vGrp.get(i)%></td>
             <td class="DataTable1"><%=vGrpSort.get(i)%></td>
             <td class="DataTable1"><%=vGrpNm.get(i)%></td>
             <td class="DataTable1"><%=vGrpDesc.get(i)%></td>
             <%for(int j=0; j < iNumOfStr; j++){%>
               <td class="DataTable"><input type="checkbox" value="<%=sStrLst[j]%>"
                  <%for(int k=0; k < sGrpStr.length; k++)
                    {%> 
                	  <%if(sStrLst[j].trim().equals(sGrpStr[k].trim())){%>checked<%}%>
                    <%}%>             
                 onclick="setStr('<%=vGrp.get(i)%>',this)" >   
               </td>
             <%}%>
             <td class="DataTable1"><a href="javascript: setGrp('<%=vGrp.get(i)%>','<%=vGrpNm.get(i)%>','<%=vGrpDesc.get(i)%>','<%=vGrpSort.get(i)%>', 'UpdGrp')">Upd</a></td>
             <td class="DataTable1"><a href="javascript: setGrp('<%=vGrp.get(i)%>','<%=vGrpNm.get(i)%>','<%=vGrpDesc.get(i)%>','<%=vGrpSort.get(i)%>', 'DltGrp')">Dlt</a></td>
           </tr>
        <%}%>      
 <!----------------------- end of table ------------------------>                     
       </table>

      </th>
     </tr>
   </table>
 </body>
</html>
<%}%>