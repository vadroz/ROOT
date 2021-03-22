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
              	  
  	  String sPrepStmt = "select DCCLS,DCLEN,DCWDT,DCHGT,DCWGT,DCRECUS,DCRECDT,DCRECTM" 
  	    	 + ",cdiv,cdpt,clnm"
  	    	 + ", case when dctxcat is null then 'NONE' else dctxcat end as dctxcat"
  	  		 + ", case when atcode is null then 'NONE' else atcode end as atcode"
  			 + " from rci.MODIMCLS"
  		   	 + " inner join iptsfil.ipclass on ccls=dccls"
  		   	 + " left join rci.motxcat on ATTXCAT=dctxcat"
  	       	 + " order by DCCLS";       	
  	      	
  	  //System.out.println(sPrepStmt);
  	       	
  	  ResultSet rslset = null;
  	  RunSQLStmt runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	    		   		   
  	  Vector<String> vCls = new Vector<String>();
  	  Vector<String> vName = new Vector<String>();
  	  Vector<String> vDiv = new Vector<String>();
  	  Vector<String> vDpt = new Vector<String>();
  	  Vector<String> vLen = new Vector<String>();
  	  Vector<String> vWidth = new Vector<String>();
  	  Vector<String> vHeight = new Vector<String>();
      Vector<String> vWeight = new Vector<String>();
      Vector<String> vTxCat = new Vector<String>();
      Vector<String> vAvaCode = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {  		  
  		  vCls.add(runsql.getData("DcCls").trim());
  		  vLen.add(runsql.getData("DcLen").trim());
  		  vWidth.add(runsql.getData("DCWDT").trim());
  		  vHeight.add(runsql.getData("DCHGT").trim());
  		  vWeight.add(runsql.getData("DCWGT").trim());
  		  vName.add(runsql.getData("clnm").trim());
  		  vDiv.add(runsql.getData("cDiv").trim());
  		  vDpt.add(runsql.getData("cDpt").trim());
  		  vTxCat.add(runsql.getData("dctxcat").trim());
  		  vAvaCode.add(runsql.getData("atcode").trim());
  		   
  	  }  
  	  
  	  CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
  	  String [] sCls = vCls.toArray(new String[]{});
  	  String [] sLen = vLen.toArray(new String[]{});
  	  String [] sWidth = vWidth.toArray(new String[]{});
  	  String [] sHeight = vHeight.toArray(new String[]{});
  	  String [] sWeight = vWeight.toArray(new String[]{});
  	  String [] sName = vName.toArray(new String[]{});
  	  String [] sDiv = vDiv.toArray(new String[]{});
  	  String [] sDpt = vDpt.toArray(new String[]{});
  	  String [] sTxCat = vTxCat.toArray(new String[]{});
  	  String [] sAvaCode = vAvaCode.toArray(new String[]{});
  	  
  	  //=========================================
  	  // get tax category for Avalara tax codes
  	  //=========================================
  	  sPrepStmt = "select AtTxCat, AtCode" 
  	    	 + " from rci.MOTxCat"  		   	 
  	       	 + " order by AtTxCat";       	
  	      	
  	  //System.out.println(sPrepStmt);
  	       	
  	  rslset = null;
  	  runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	    		   		   
  	  Vector<String> vSelTxCat = new Vector<String>();
      Vector<String> vSelAvaCode = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {  		  
  		  vSelTxCat.add(runsql.getData("attxcat").trim());
  		  vSelAvaCode.add(runsql.getData("atcode").trim());
  	  }  
  	  
  	  String [] sSelTxCat = vSelTxCat.toArray(new String[]{});
  	  String [] sSelAvaCode = vSelAvaCode.toArray(new String[]{});
  	  String sSelTxCatJsa = srvpgm.cvtToJavaScriptArray(sSelTxCat);
  	  String sSelAvaCodeJsa = srvpgm.cvtToJavaScriptArray(sSelAvaCode);
%>

<html>
<head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<style type="text/css" media="print">
  @page { transform: rotate(90deg); }
  .NonPrt  { display:none; }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var NewClsNm = null;
var SelTxCat = [<%=sSelTxCatJsa%>];
var SelAvaCode = [<%=sSelAvaCodeJsa%>];

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
//==============================================================================
// add Ctl comments
//==============================================================================
function chgCls(cls, len, width, height, weight, txcode, action)
{
   var hdr = "Add Class Dimensions";
   if(action == "UPD_CLS"){ hdr = "Update Class Dimensions";}
   else if(action == "DLT_CLS"){ hdr = "Delete Class";}

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popClsPanel(cls, len, width, height,weight, txcode, action)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
   else { document.all.dvItem.style.width = "auto";}
   
   document.all.dvItem.innerHTML = html;      
   document.all.dvItem.style.left = getLeftScreenPos() + 200;
   document.all.dvItem.style.top = getTopScreenPos() + 95;
   document.all.dvItem.style.visibility = "visible";
   
   if(action != "ADD_CLS")
   {
	   document.all.Class.value = cls;
	   document.all.Len.value = len;
	   document.all.Width.value = width
	   document.all.Height.value = height;	 
	   document.all.Weight.value = weight;	
   }
   
   if(action == "DLT_CLS")
   {
	   document.all.Class.readOnly = true;
	   document.all.Len.readOnly = true;
	   document.all.Width.readOnly = true;
	   document.all.Height.readOnly = true;
	   document.all.Weight.readOnly = true;
   }
   if(action == "UPD_CLS")
   {
	   document.all.Class.readOnly = true;	   	   
   }
   
   var sel = document.all.selTxCat;
   sel.options[0] = new Option("--- select Tax Category ----", ""); 
   for(var i=0; i < SelTxCat.length; i++)
   {
	   sel.options[i+1] = new Option(SelTxCat[i] + " ==> " + SelAvaCode[i], SelTxCat[i]); 
   }
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popClsPanel(cls, len, width, height,weight, txcode, action)
{
  var panel = "<table border=1 width=100% cellPadding='0' cellSpacing='0'>"
  panel += "<tr>"
	     + "<td class='td49' nowrap>Class:</td>"
	     + "<td class='td48' nowrap><input name='Class' size=12 maxlength=10>&nbsp; &nbsp;"
	       + "<span id='spnClsNm'></span>"
	     + "</td>"
       + "</tr>"
       + "<tr>"
	     + "<td class='td49' nowrap>Length:</td>"
	     + "<td class='td48' nowrap><input name='Len' size=10 maxlength=10></td>"
       + "</tr>"
       + "<tr>"
	     + "<td class='td49' nowrap>Width:</td>"
	     + "<td class='td48' nowrap><input name='Width' size=10 maxlength=10></td>"
       + "</tr>"
       + "<tr>"
         + "<td class='td49' nowrap>Height:</td>"
         + "<td class='td48' nowrap><input name='Height' size=10 maxlength=10></td>"
       + "</tr>"
       + "<tr>"
       + "<td class='td49' nowrap>Weight:</td>"
       + "<td class='td48' nowrap><input name='Weight' size=10 maxlength=10></td>"
     + "</tr>"
     + "<tr>"
     + "<td class='td49' nowrap>Tax Category:</td>"
     + "<td class='td48' nowrap><input name='TxCat' size=30 maxlength=25 readonly>"
     + "<br><select name='selTxCat' onchange='setTaxCat(this)'></select></td>"
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
	
	var cls = document.all.Class.value.trim();
	var len = document.all.Len.value.trim();
	var width = document.all.Width.value.trim();
	var height = document.all.Height.value.trim();
	var weight = document.all.Weight.value.trim();
	var txcat =  document.all.TxCat.value.trim();
	
	if(cls=="" || eval(cls) == 0){ error=true; msg += "\nPlease enter Class." }
	else if(isNaN(cls)){ error=true; msg += "\nThe Class must be a number." }
	
	if(action == "ADD_CLS")
	{
		if(!getScannedItem(cls)) { error = true; msg = "Class is not found on System.\n" }
		else{ document.all.spnClsNm.innerHTML = NewClsNm; }
	}
		
	if(len=="" || eval(len) == 0){ error=true; msg += "\nPlease enter Length." }
	else if(isNaN(len)){ error=true; msg += "\nThe Length must be a number." }
	
	if(width=="" || eval(width) == 0){ error=true; msg += "\nPlease enter Width." }
	else if(isNaN(width)){ error=true; msg += "\nThe Width must be a number." }
	
	if(height=="" || eval(height) == 0){ error=true; msg += "\nPlease enter Height." }
	else if(isNaN(height)){ error=true; msg += "\nThe Height must be a number." }
	
	if(weight=="" || eval(weight) == 0){ error=true; msg += "\nPlease enter Weight." }
	else if(isNaN(weight)){ error=true; msg += "\nThe Weight must be a number." }
	
	if(txcat==""){ error=true; msg += "\nPlease enter Tax Category." }
	
	if (error) alert(msg);
	else{ sbmCls( cls, len,width,height,weight,txcat, action); }
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
function sbmCls( cls, len,width,height, weight,txcat, action)
{
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='MozuClsDimSv.jsp'>"
       + "<input class='Small' name='Cls'>"
       + "<input class='Small' name='Len'>"       
       + "<input class='Small' name='Width'>"
       + "<input class='Small' name='Height'>"
       + "<input class='Small' name='Weight'>"
       + "<input class='Small' name='TxCat'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Cls.value = cls;
   window.frame1.document.all.Len.value = len;
   window.frame1.document.all.Width.value = width;
   window.frame1.document.all.Height.value = height;
   window.frame1.document.all.Weight.value = weight;
   window.frame1.document.all.TxCat.value = txcat;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
   hidePanel();
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(cls)
{
	var url = "MozuChkClass.jsp?Cls=" + cls;
	var valid = false;
	 
	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
  		var  resp = xmlhttp.responseText;
  		
  		valid = parseElem(resp, "Cls_Valid") == "true";
  		NewClsNm = parseElem(resp, "ClsNm");  		    		
  		
  		//clearInterval( progressIntFunc );
  		//document.all.dvWait.style.visibility = "hidden";
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
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
<title>Mozu Class Dimensions</title>

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
      <br>Mozu Class Dimensions
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
      	<a href="javascript: chgCls(null, null, null, null, null, null, 'ADD_CLS')">Add Class</a> &nbsp; &nbsp; &nbsp;
      	<a href="MozuTaxCat.jsp">Got to Tax Category</a> &nbsp; &nbsp; &nbsp;
      </td>
    </tr>
    <tr>
      <td colspan=3 align=center>
         <table class="tbl02">
           <tr class="trHdr01">
              <th class="th02" nowrap>Div</th>
              <th class="th02" nowrap>Dpt</th>
              <th class="th02" nowrap>Class</th>
              <th class="th02" nowrap>Name</th>
              <th class="th02" nowrap>Length<br>(in)</th>
              <th class="th02" nowrap>Width<br>(in)</th>
              <th class="th02" nowrap>Height<br>(in)</th>
              <th class="th02" nowrap>Weight<br>(lb)</th>
              <th class="th02" nowrap>Tax<br>Category</th>
              <th class="th02" nowrap>Avalara<br>Tax<br>Code</th>
              <th class="th02" nowrap>Delete</th>
           </tr>
            
           <%String sCss1="trDtl04";%>
           <%for(int i=0; i < sCls.length; i++){%>
              <tr class="<%=sCss1%>">
                 <td class="td12" nowrap><%=sDiv[i]%></td>
                 <td class="td12" nowrap><%=sDpt[i]%></td>
                 <td class="td12" nowrap>
                     <a href="javascript: chgCls('<%=sCls[i]%>', '<%=sLen[i]%>', '<%=sWidth[i]%>', '<%=sHeight[i]%>', '<%=sWeight[i]%>', '<%=sTxCat[i]%>', 'UPD_CLS')"><%=sCls[i]%></a>
                 </td>
                 <td class="td11" nowrap><%=sName[i]%></td>
                 <td class="td12" nowrap><%=sLen[i]%></td>
                 <td class="td12" nowrap><%=sWidth[i]%></td>
                 <td class="td12" nowrap><%=sHeight[i]%></td>
                 <td class="td12" nowrap><%=sWeight[i]%></td>
                 <td class="td12" nowrap><%=sTxCat[i]%></td>
                 <td class="td12" nowrap><%=sAvaCode[i]%></td>
                 <td class="td18" nowrap>
                     <a href="javascript: chgCls('<%=sCls[i]%>', '<%=sLen[i]%>', '<%=sWidth[i]%>', '<%=sHeight[i]%>', '<%=sWeight[i]%>', '<%=sTxCat[i]%>', 'DLT_CLS')">Delete</a>
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






