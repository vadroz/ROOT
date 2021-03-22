<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComDivInclProfile.jsp");
}
else
{
	String sStmt = "Select * from RCI.ECDIPRF";
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();

	Vector vProfile = new Vector();
	Vector vMinQty = new Vector();
	Vector vMinAmt = new Vector();
	Vector vRegSls = new Vector();
	Vector vClrSls = new Vector();
	Vector vSpcSls = new Vector();
	
	while(runsql.readNextRecord())
	{
	    vProfile.add(runsql.getData("Profile").trim());
	    vMinQty.add(runsql.getData("min_qty").trim());
	    vMinAmt.add(runsql.getData("min_amt").trim());
	    vRegSls.add(runsql.getData("sls_reg").trim());
	    vClrSls.add(runsql.getData("sls_clr").trim());
	    vSpcSls.add(runsql.getData("sls_spc").trim());
	}       
%>
<HTML>
<HEAD>
<title>EC-Div-Incl-Profile</title>
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
function setProfile(prof, qty, amt, reg, clr, spc, action)
{
   	var hdr = "Add Profile";
   	if(action == "Upd"){ hdr = "Update Profile"}
   	else if(action == "Dlt"){ hdr = "Delete Profile"}

   	var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
  	   + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
  	     + "<td class='BoxClose' valign=top>"
 	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;); hidePanel(&#34;dvItem&#34;);' alt='Close'>"
 	      + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popProfilePanel(action)

		html += "</td></tr></table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 200;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
    
	if(action =="Dlt")
	{
		document.all.Profile.readOnly = true;
		document.all.MinQty.readOnly = true;
		document.all.MinAmt.readOnly = true;
	}
	if(action =="Upd"){ document.all.Profile.readOnly = true;}	
	
	if(action != "Add")
	{
		document.all.Profile.value = prof;
		document.all.MinQty.value = qty;
		document.all.MinAmt.value = amt;		
	}
}
//==============================================================================
//populate Marked Item Panel
//==============================================================================
function popProfilePanel(action)
{	
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
    panel += "<tr class='DataTable'>"
    	 + "<td class='DataTable1' nowrap>Profile</td>"
         + "<td class='DataTable1' nowrap><input name='Profile' maxlength=1 size=1></td>"
       + "</tr>"  
       + "<tr class='DataTable'>"   
         + "<td class='DataTable1' nowrap>Minimum Quantity: </td>"
         + "<td class='DataTable1' nowrap><input name='MinQty' maxlength=9 size=9></td>"
       + "</tr>"
       + "<tr class='DataTable'>"  
         + "<td class='DataTable1' nowrap>Minimum Amount: </td>"
         + "<td class='DataTable1' nowrap><input name='MinAmt' maxlength=10 size=10></td>"         
       + "</tr>"
       
       + "<tr class='DataTable' id='tdSlsGrp'>"  
     	 + "<td class='DataTable1' nowrap colspan=2>Include by price ending: <br>"
     	 + "</td>"         
   + "</tr>"
       
       
    panel += "<tr class='DataTable'>"
      	 + "<td class='DTError' nowrap id='tdError' colspan=2></td>"
      	+ "</tr>"
      	
       
    panel += "<td class='Prompt1' colspan=7>"
       + "<button onClick='vldProfile(&#34;" + action + "&#34;)' class='Small'>Submit</button> &nbsp; &nbsp;"
       + "<button onClick='hidePanel(&#34;dvItem&#34;); hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
       + "</td>"
     + "</tr>"

panel += "</table>";

return panel;
}
//==============================================================================
//validate Profile entry
//==============================================================================
function vldProfile(action)
{
	var error=false;
	var msg = "";
	document.all.tdError.innerHTML = "";
	var br = ""; 
	
	var prof = document.all.Profile.value.trim();
	if(prof==""){error=true; msg += br + "The Profile cannot be blank."; br="<br>";}
	
	var qty = document.all.MinQty.value.trim();
	if(qty==""){error=true; msg += br + "The Minimum Quantity cannot be blank."; br="<br>";}
	else if(isNaN(qty)){error=true; msg += br + "The Minimum Quantity must be numeric."; br="<br>";}
	else if(eval(qty) < 0){error=true; msg += br + "The Minimum Quantity cannot be negative."; br="<br>";}
	
	var amt = document.all.MinAmt.value.trim();
	if(amt==""){error=true; msg += br + "The Minimum Amount cannot be blank."; br="<br>";}
	else if(isNaN(amt)){error=true; msg += br + "The Minimum Amount must be numeric."; br="<br>";}
	else if(eval(amt) < 0){error=true; msg += br + "The Minimum Amount cannot be negative."; br="<br>";}
	else if(eval(amt) > 9999999.99){ amt = 9999999.99 }
	
	var regsls = "Y"; 
	var clrsls = "Y"; 
	var spcsls = "Y"; 
	
	if(prof!="X" && regsls == "N" && clrsls == "N" && spcsls == "N"){ error=true; msg += br + "Check at least 1 of sale types."; br="<br>";}

	if(error){ document.all.tdError.innerHTML = msg; }
	else{ sbmProfile(prof, qty, amt, regsls, clrsls, spcsls, action); }
}
//==============================================================================
// submit Profile entry
//==============================================================================
function sbmProfile(prof, qty, amt, regsls, clrsls, spcsls, action)
{
	var url="EComDivInclPrfSave.jsp?"
	  + "&prof=" + prof	 
	  + "&regsls=" + regsls
      + "&clr=" + clrsls
      + "&spc=" + spcsls
      + "&action=" + action
      + "&qty=" + qty         
      + "&amt=" + amt
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
             <th class="DataTable">Profile<br>
                <a class="small" href="javascript: setProfile(null,null,null,null,null,null,'Add');">New</a>
             </th>
             <th class="DataTable">Minimum Qty</th>
             <th class="DataTable">Minimum Amount</th>
             <th class="DataTable">Regular</th>             
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < vProfile.size(); i++ )
         {            
        %>
         <tr id="trProd" class="DataTable">
            <td class="DataTable1" nowrap >
               <a class="small" href="javascript: setProfile('<%=vProfile.get(i)%>', '<%=vMinQty.get(i)%>'
                         ,'<%=vMinAmt.get(i)%>','<%=vRegSls.get(i)%>','<%=vClrSls.get(i)%>'
                         ,'<%=vSpcSls.get(i)%>' ,'Upd');"><%=vProfile.get(i)%></a>
            </td>
            <td class="DataTable1" nowrap ><%=vMinQty.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vMinAmt.get(i)%></td>
            <td class="DataTable" nowrap >
               <a class="small" href="javascript: setProfile('<%=vProfile.get(i)%>', '<%=vMinQty.get(i)%>'
                         ,'<%=vMinAmt.get(i)%>','<%=vRegSls.get(i)%>','<%=vClrSls.get(i)%>'
                         ,'<%=vSpcSls.get(i)%>','Dlt');">Delete</a>
            </td>
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
