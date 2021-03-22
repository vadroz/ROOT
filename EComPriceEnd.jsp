<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComPriceEnd.jsp");
}
else
{
	String sStmt = "Select * from RCI.EcSlsGrp";
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();

	Vector vCents = new Vector();
	Vector vType = new Vector();
	
	while(runsql.readNextRecord())
	{
	    vCents.add(runsql.getData("cents").trim());
	    vType.add(runsql.getData("type").trim());	    
	}       
%>
<HTML>
<HEAD>
<title>ECom Price Endings</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:12px} a:visited.small { color:blue; font-size:12px}  a:hover.small { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:12px;}

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable0 { background: red; font-size:12px }
        tr.DataTable1 { background: CornSilk; font-size:12px }
        tr.DataTable2 { background: CornSilk; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DTError{color:red; font-size:12px;}               

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvTooltip { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:15; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
               

        tr.Prompt { background: lavender; font-size:10px }
        tr.Prompt1 { background: seashell; font-size:10px }
        tr.Prompt2 { background: LightCyan; font-size:11px }

        th.Prompt { background:#FFCC99; text-align:ceneter; vertical-align:midle; font-family:Arial; font-size:11px; }
        td.Prompt { padding-left:3px; padding-right:3px; text-align:left; vertical-align:top; font-family:Arial;}
        td.Prompt1 { padding-left:3px; padding-right:3px; text-align:center; vertical-align:top; font-family:Arial;}
        td.Prompt2 { padding-left:3px; padding-right:3px; text-align:right; font-family:Arial; }
        td.Prompt3 { padding-left:3px; padding-right:3px; text-align:left; vertical-align:midle; font-family:Arial;}


</style>


<script language="javascript1.3">
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   //foldExpandChild();
}
//==============================================================================
//show tag availability
//==============================================================================
function setPrcEnd(cents, type, action)
{
   	var hdr = "Add Cents";
   	if(action == "Upd"){ hdr = "Update Cents"}
   	else if(action == "Dlt"){ hdr = "Delete Cents"}

   	var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
  	   + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
  	     + "<td class='BoxClose' valign=top>"
 	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;); hidePanel(&#34;dvItem&#34;);' alt='Close'>"
 	      + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popPrcEnd(action)

		html += "</td></tr></table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 200;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
    
	document.all.Cents.readOnly = true;	
	document.all.Cents.value = cents;
	if(type == "Reg"){	document.all.Type[0].checked = true; }
	else if(type == "Clr"){	document.all.Type[1].checked = true; }
	else if(type == "Spec"){ document.all.Type[2].checked = true; }
}
//==============================================================================
//populate Marked Item Panel
//==============================================================================
function popPrcEnd(action)
{	
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
    panel += "<tr class='DataTable'>"
    	 + "<td class='DataTable1' nowrap>Cents</td>"
         + "<td class='DataTable1' nowrap><input name='Cents' maxlength=1 size=1></td>"
       + "</tr>"  
       + "<tr class='DataTable'>"   
         + "<td class='DataTable1' nowrap>Sales Type: </td>"
         + "<td class='DataTable1' nowrap>" 
             + "<input name='Type' type='radio' value='Reg'>Regular<br>"
             + "<input name='Type' type='radio' value='Clr'>Clear<br>"
             + "<input name='Type' type='radio' value='Spec'>Special"
         + "</td>"
       + "</tr>"
       
    panel += "<tr class='DataTable'>"
      	 + "<td class='DTError' nowrap id='tdError' colspan=2></td>"
      	+ "</tr>"
      	
       
    panel += "<td class='Prompt1' colspan=7>"
       + "<button onClick='vldCents(&#34;" + action + "&#34;)' class='Small'>Submit</button> &nbsp; &nbsp;"
       + "<button onClick='hidePanel(&#34;dvItem&#34;); hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
       + "</td>"
     + "</tr>"

panel += "</table>";

return panel;
}
//==============================================================================
//validate Cents entry
//==============================================================================
function vldCents(action)
{
	var error=false;
	var msg = "";
	document.all.tdError.innerHTML = "";
	var br = ""; 
     
	var cents = document.all.Cents.value.trim();
	var typeobj = document.all.Type;
	var type = "";
	for(var i=0; i < typeobj.length; i++)
	{
		if(typeobj[i].checked){ type = typeobj[i].value; }
	}
	
	if(error){ document.all.tdError.innerHTML = msg; }
	else{ sbmPrcEnd(cents, type, action); }
}
//==============================================================================
// submit Cents entry
//==============================================================================
function sbmPrcEnd(cents, type, action)
{
	var url="EComPriceEndSave.jsp?"
	  + "&cents=" + cents	 
	  + "&type=" + type
      + "&action=" + action
    ;  
      
    //alert(url)  
    window.frame1.location.href = url;  
}
//==============================================================================
// display error
//==============================================================================
function dispError(msg)
{
   document.all.tdError.innerHTML = msg; 	  
}
//==============================================================================
//display error
//==============================================================================
function restart()
{
   window.location.reload(); 	 
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel(obj)
{
  document.all[obj].innerHTML = " ";
  document.all[obj].style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Item List
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Cents</th>
             <th class="DataTable">Type</th>             
             <th class="DataTable">&nbsp;</th>
             
             <th class="DataTable">Cents</th>
             <th class="DataTable">Type</th>             
             <th class="DataTable">&nbsp;</th>
             
             <th class="DataTable">Cents</th>
             <th class="DataTable">Type</th>             
             <th class="DataTable">&nbsp;</th>
             
             <th class="DataTable">Cents</th>
             <th class="DataTable">Type</th>             
             <th class="DataTable">&nbsp;</th>
             
             <th class="DataTable">Cents</th>
             <th class="DataTable">Type</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < vCents.size() / 5; i++ )
         {            
    	   String sColor1 = "#e7e7e7"; 
    	   if(((String)vType.get(i)).equals("Clr")){sColor1 = "cornsilk";}
    	   else if(((String)vType.get(i)).equals("Spec")){sColor1 = "lightgreen";}
    	   
    	   String sColor2 = "#e7e7e7"; 
    	   if(((String)vType.get(i+20)).equals("Clr")){sColor2 = "cornsilk";}
    	   else if(((String)vType.get(i+20)).equals("Spec")){sColor2 = "lightgreen";}

    	   String sColor3 = "#e7e7e7"; 
    	   if(((String)vType.get(i+40)).equals("Clr")){sColor3 = "cornsilk";}
    	   else if(((String)vType.get(i+40)).equals("Spec")){sColor3 = "lightgreen";}
    	   
    	   String sColor4 = "#e7e7e7"; 
    	   if(((String)vType.get(i+60)).equals("Clr")){sColor4 = "cornsilk";}
    	   else if(((String)vType.get(i+60)).equals("Spec")){sColor4 = "lightgreen";}
    	   
    	   String sColor5 = "#e7e7e7"; 
    	   if(((String)vType.get(i+80)).equals("Clr")){sColor5 = "cornsilk";}
    	   else if(((String)vType.get(i+80)).equals("Spec")){sColor5 = "lightgreen";}
    	   
        %>
         <tr id="trProd" class="DataTable">
            <td class="DataTable2" style="background:<%=sColor1%>;" nowrap ><a class="small" href="javascript: setPrcEnd('<%=vCents.get(i)%>', '<%=vType.get(i)%>','Upd');"><%=vCents.get(i)%></a></td>
            <td class="DataTable1" style="background:<%=sColor1%>;" nowrap ><%=vType.get(i)%></td>
            <th class="DataTable">&nbsp;</th>
            
            <td class="DataTable2" style="background:<%=sColor2%>;" nowrap ><a class="small" href="javascript: setPrcEnd('<%=vCents.get(i+20)%>', '<%=vType.get(i+20)%>','Upd');"><%=vCents.get(i+20)%></a></td>
            <td class="DataTable1"  style="background:<%=sColor2%>;"nowrap ><%=vType.get(i+20)%></td>
            <th class="DataTable">&nbsp;</th>            
                        
            <td class="DataTable2" style="background:<%=sColor3%>;" nowrap ><a class="small" href="javascript: setPrcEnd('<%=vCents.get(i+40)%>', '<%=vType.get(i+40)%>','Upd');"><%=vCents.get(i+40)%></a></td>
            <td class="DataTable1" style="background:<%=sColor3%>;" nowrap ><%=vType.get(i+40)%></td>
            <th class="DataTable">&nbsp;</th>
            
            <td class="DataTable2" style="background:<%=sColor4%>;" nowrap ><a class="small" href="javascript: setPrcEnd('<%=vCents.get(i+60)%>', '<%=vType.get(i+60)%>','Upd');"><%=vCents.get(i+60)%></a></td>
            <td class="DataTable1" style="background:<%=sColor4%>;" nowrap ><%=vType.get(i+60)%></td>
            <th class="DataTable">&nbsp;</th>
            
            <td class="DataTable2" style="background:<%=sColor5%>;" nowrap ><a class="small" href="javascript: setPrcEnd('<%=vCents.get(i+80)%>', '<%=vType.get(i+80)%>','Upd');"><%=vCents.get(i+80)%></a></td>
            <td class="DataTable1" style="background:<%=sColor5%>;" nowrap ><%=vType.get(i+80)%></td>            
         </tr>
       <%}%>

       
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
rs.close();
runsql.disconnect();
}%>
