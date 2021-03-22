<%@ page import="rciutility.RunSQLStmt, java.sql.*
	, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%   
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuClsDim.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sStrAllowed = session.getAttribute("STORE").toString();    
              	  
  	  String sPrepStmt = "select AtTxCat, AtCode" 
  	    	 + " from rci.MOTxCat"  		   	 
  	       	 + " order by AtTxCat";       	
  	      	
  	  //System.out.println(sPrepStmt);
  	       	
  	  ResultSet rslset = null;
  	  RunSQLStmt runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	  
      Vector<String> vTxCat = new Vector<String>();
      Vector<String> vAvaCode = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {
  		  vTxCat.add(runsql.getData("attxcat").trim());
  		  vAvaCode.add(runsql.getData("atcode").trim());  		   
  	  }  
  	  
  	  CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
  	  String [] sTxCat = vTxCat.toArray(new String[]{});
  	  String [] sAvaCode = vAvaCode.toArray(new String[]{});
  	  
  	  
%>

<html>
<head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<style type="text/css" media="print">
  @page { transform: rotate(90deg); }
  .NonPrt  { display:none; }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var NewClsNm = null;
 

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
//==============================================================================
// add Ctl comments
//==============================================================================
function chgCls( txcode, avacode, action)
{
   var hdr = "Add Tax Category";
   if(action == "UPD_CLS"){ hdr = "Update Tax Category";}
   else if(action == "DLT_CLS"){ hdr = "Delete Tax Category";}

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popClsPanel(txcode, avacode, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width=250;
   document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 200;
   document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";
   
   if(action != "ADD_CLS")
   {
	   document.all.TxCat.value = txcode;
	   document.all.AvaCode.value = avacode;	    
   }
   
   if(action == "DLT_CLS")
   {
	   document.all.TxCat.readOnly = true;
	   document.all.AvaCode.readOnly = true;
   }
   
   if(action == "UPD_CLS")
   {
	   document.all.TxCat.readOnly = true;	   	   
   }    
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popClsPanel( txcode, avacode, action)
{
  var panel = "<table border=1 width=100% cellPadding='0' cellSpacing='0'>"
  panel += "<tr>"
     + "<td class='td49' nowrap>Tax Category:</td>"
     + "<td class='td48' nowrap><input name='TxCat' size=30 maxlength=25></td>"
   + "</tr>"
   + "<tr>"
   	  + "<td class='td49' nowrap>Avalara Code:</td>"
   	  + "<td class='td48' nowrap><input name='AvaCode' size=25 maxlength=20></td>"
   + "</tr>"   

  panel += "<tr>";
  panel += "<td class='td50' colspan=2><br><br><button onClick='ValidateCls(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"  
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// set tax category
//==============================================================================
function setTaxCat(sel)
{
	var idx = sel.selectedIndex;
	if (idx > 0)
	{
		document.all.TxCat.value = sel.options[idx].value;
	}
	else
	{
		document.all.TxCat.value = "";
	}
	
}
//==============================================================================
// validate Item changes
//==============================================================================
function ValidateCls(action)
{
	var error = false;
	var msg = "";
		
	var txcat =  document.all.TxCat.value.trim();
	var avacode =  document.all.AvaCode.value.trim();
	
	if(txcat==""){ error=true; msg += "\nPlease enter Tax Category." }
	if(avacode==""){ error=true; msg += "\nPlease enter Avalara Code." }
	
	if (error) alert(msg);
	else{ sbmTxCat( txcat, avacode, action); }
}
//==============================================================================
//parse XML elements
//==============================================================================
function parseElem(resp, tag )
{
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	return resp.substring(beg, end);
}
//==============================================================================
// save dimensions
//==============================================================================
function sbmTxCat(txcat, avacode, action)
{
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='MozuTaxCatSv.jsp'>"       
       + "<input class='Small' name='TxCat'>"
       + "<input class='Small' name='AvaCode'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);
  
   window.frame1.document.all.TxCat.value = txcat;
   window.frame1.document.all.AvaCode.value = avacode;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
   hidePanel();
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
// show Error 
//==============================================================================
function showError(exist)
{
	if(exist){alert("Class is already exists")} 
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<title>Mozu Tax Category</title>

<body onload="bodyLoad()"> 
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
   <table  class="tbl01" id="tblClaim">
     <tr>       
      <td ALIGN="center" VALIGN="TOP"nowrap>      
      <span id="spnHdrImg"><img src="Sun_ski_logo4.png" height="50px" alt="Sun and Ski Patio"></span>
      <br>Mozu Tax Category
      <br>
       </b>
       </td>       
      </tr>

    <tr class="NonPrt">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        &nbsp;&nbsp;&nbsp;
      </td>
    </tr>
    <tr id="trLinks1">
      <td colspan=3 align=center>
      	<a href="javascript: chgCls( null, null, 'ADD_CLS')">Add Tax Category</a> &nbsp; &nbsp; &nbsp;
      </td>
    </tr>
    <tr>
      <td colspan=3 align=center>
         <table class="tbl02">
           <tr class="trHdr01">              
              <th class="th02" nowrap>Tax<br>Category</th>
              <th class="th02" nowrap>Avalara<br>Tax<br>Code</th>
              <th class="th02" nowrap>Delete</th>
           </tr>
            
           <%String sCss1="trDtl04";%>
           <%for(int i=0; i < sTxCat.length; i++){%>
              <tr class="<%=sCss1%>">
                 <td class="td11" nowrap>
                     <a href="javascript: chgCls( '<%=sTxCat[i]%>', '<%=sAvaCode[i]%>', 'UPD_CLS')"><%=sTxCat[i]%></a>
                 </td> 
                 <td class="td11" nowrap><%=sAvaCode[i]%></td>
                 <td class="td18" nowrap>
                     <a href="javascript: chgCls( '<%=sTxCat[i]%>', '<%=sAvaCode[i]%>', 'DLT_CLS')">Delete</a>
                 </td>                 
              </tr>
           <%}%>
           <!----------------------- end of table ------------------------>                 
         </table>
      </td>
    </tr>
    
    
   </table>
 </body>
</html>
<%}%>






