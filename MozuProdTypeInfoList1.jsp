<!DOCTYPE html>	
<%@ page import="com.test.api.MozuProdTypeInfoList, java.util.*, java.text.*"%>
<%   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=EComFxUnship.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	Date dtStart = new Date();
	MozuProdTypeInfoList protyl = new MozuProdTypeInfoList();	
	int iNumOfTy = protyl.getNumOfTy();
	
	String [] sProdTy = protyl.getProdTy();
	String [][] sPtAttr = protyl.getPtAttr();
	String [][] sPtProp =  protyl.getPtProp();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Mozu Prod Type</title>

<SCRIPT>

//--------------- Global variables -----------------------

var OptId = null;
var OptNm = null;
var LastTr = -1;
var LastOpt = "";

var progressIntFunc = null;
var progressTime = 0;
var progressAllTime = 0;

var ExclAttrNm = ["availability" ,"product-crosssell" ,"Popularity", "Rating"
     ,"product-related" ,"product-upsell"];

var AttrId = new Array();
var AttrNm = new Array();
var AttrTy = new Array();
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   setToolbox();
}
//==============================================================================
//retreive attribute values
//==============================================================================
function setToolbox()
{
	var html= "<table style='text-align: left;'>"
	 + "<tr>"
	    + "<td>"
	 		+ "<a class='Small' href='javascript: rtvAttrVal(&#34;Tenant~Color&#34;)'>Colors</a><br>"
	 	+ "</td>"
	 + "</tr>"	
	 + "<tr>"
	    + "<td>"
     		+ "<a class='Small' href='javascript: crtAttr()'>New Attributes</a>"
     	+ "</td>"
	 + "</tr>"
	 + "<tr>"
	    + "<td>"
  		   + "<a class='Small' href='javascript: rtvListTypeAttrLst()'>Attributes List</a>"
  	    + "</td>"
	 + "</tr>"
	 + "<tr>"
	    + "<td>"
		   + "<a class='Small' href='javascript: crtProdType()'>New Product Type</a>"
	    + "</td>"
	 + "</tr>"
     "</table>";
    document.all.dvSelect.innerHTML = html; 
}
//==============================================================================
//retreive attribute values
//==============================================================================
function rtvListTypeAttrLst()
{
	var url="MozuRtvListTypeAttrList.jsp";
	window.frame1.loacation.href=url;
}
//==============================================================================
// retreive attribute values
//==============================================================================
function rtvAttrVal(attr)
{
	var url="MozuRtvSelAttrList.jsp?Attr=" + attr;
	window.frame1.location.href=url;
}
//==============================================================================
//show color list
//==============================================================================
function showOptList(max, optid, optnm)
{
	OptId = optid;
	OptNm = optnm;
	var hdr = "Colors";
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popOptList(max, optid, optnm)
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=850;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate option lsit panel
//==============================================================================
function popOptList(max, optid, optnm)
{
	var panel = "<table class='tbl01' id='tblFind'>"
	+ "<tr class='trDtl03'>"
	   + "<td class='td01'><input class='Small' name='FindOptId' maxlength=5 size=5></td>"
	   + "<td class='td01'><input class='Small' name='FindOptNm' maxlength=100 size=50></td>"
	   + "<td class='td01'><button class='Small' onclick='findOpt()'>Find</button></td>"
	+ "</tr>"
	+ "<tr><td colspan=3>"
	+ "<div id='dvInt' class='dvInternal'>"
	 + "<table class='tbl01' id='tblOpt'>"
	    + "<tr>"
	       + "<th>Id</th>"
	       + "<th>Value</th>"
	    + "</tr>";
	for(var i=0; i < max; i++)
	{
		panel += "<tr class='trDtl03' id='trOpt'>"
			   + "<td class='td01'>" + optid[i] + "</td>"
			   + "<td class='td02' nowrap>" + optnm[i] + "</td>"
	}
	
	 panel += "</table>"
	  + "</div>" 
	  + "</td></tr>"
	 + "</table>"
	 + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;";
	        
	return panel;	    
}

//==============================================================================
//Hide selection screen
//==============================================================================
function findOpt()
{
	var id = document.all.FindOptId.value.trim().toUpperCase();
	var optnm = document.all.FindOptNm.value.trim().toUpperCase();
	var dvItm = document.all.dvItem;
	var fnd = false;

	// zeroed last search
	if(id != "" && id != " " || LastOpt != optnm) LastTr=-1;
	LastOpt = optnm;

	for(var i=LastTr+1; i < OptId.length; i++)
	{
	   if(id != "" && id != " " && id == OptId[i]) { fnd = true; LastTr=i; break;}
	   else if(optnm != "" && optnm != " " && OptNm[i].toUpperCase().indexOf(optnm) >= 0) { fnd = true; LastTr=i; break;}
	   document.all.trOpt[i].style.color="black";
	}

	// if found set value and scroll div to the found record
	if(fnd)
	{
	   var pos = document.all.trOpt[LastTr].offsetTop;
	   document.all.trOpt[LastTr].style.color="red";
	   document.all.FindOptId.value = "";	   
	   dvInt.scrollTop=pos;
	}
	else { LastTr=-1; }	
}

//==============================================================================
//create new attribute
//==============================================================================
function crtAttr()
{
	var hdr = "Create New Attribute";
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"	       
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popNewAttr()
	       + "</td></tr>"
	     + "</table>"

	  
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate 'new attribute' panel
//==============================================================================
function popNewAttr()
{
	var panel = "<table class='tbl01' id='tblAtrr'>"
	+ "<tr class='trDtl03'><td class='td01'>Attribute:</td>" 
	   + "<td class='td02'> <input class='Small' name='AttrNm' size=50 maxlength=50></td>"	
	+ "</tr>"
	+ "<tr class='trDtl03'><td class='td01'>Label:</td>" 
	   + "<td class='td02'> <input class='Small' name='AttrLbl' size=50 maxlength=50></td>"	
	+ "</tr>"
	+ "<tr class='trDtl03'><td class='td01'>Description:</td>" 
	   + "<td class='td02'> <input class='Small' name='AttrDesc' size=50 maxlength=50></td>"	
	+ "</tr>"
	+ "<tr class='trDtl03'><td class='td01'>Data Type:</td>" 
	   + "<td class='td02'>"
	      + "<input type='radio' class='Small' name='AttrData' value='TextBox' checked> TextBox &nbsp; "
	      + "<input type='radio' class='Small' name='AttrData' value='TextArea'> TextArea &nbsp; "
	      + "<input type='radio' class='Small' name='AttrData' value='List'> List"
	   + "</td>"	
	+ "</tr>"
	+ "<tr class='trDtl03'><td class='td01'>Type:</td>" 
	   + "<td class='td02'>"
	      + "<input type='checkbox' class='Small' name='AttrType'> Option &nbsp; "
	      + "<input type='checkbox' class='Small' name='AttrType'> Property &nbsp; "
	      + "<input type='checkbox' class='Small' name='AttrType'> Extra"
	   + "</td>"	
	+ "</tr>"
	
	+ "<tr class='trDtl09'><td id='tdError' class='tdError' colspan=2></td></tr>"	
	
	 panel += "</table>"	  
	 + "<button id='btnAddAttr' onClick='vldNewAttr();' class='Small'>Add</button>&nbsp;"
	 + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}
//==============================================================================
// validate new attribute
//==============================================================================
function vldNewAttr()
{
	var error=false;
	var msg = "";
	var br="";
	document.all.tdError.innerHTML = "";
	
	var attr = document.all.AttrNm.value.trim();
	if(attr ==""){error=true; msg += br + "Please enter Attribute"; br="<br>";}
	
	var lbl = document.all.AttrLbl.value.trim();
	if(lbl==""){ error=true; msg += br + "Please enter label"; br="<br>";}
	
	var desc = document.all.AttrDesc.value.trim();
	if(desc==""){ error=true; msg += br + "Please enter Description"; br="<br>";}
	
	var data = "";
	for(var i=0; i < document.all.AttrData.length; i++)
	{
		if(document.all.AttrData[i].checked){ data = document.all.AttrData[i].value; }		
	}
	
	var type = [ false, false, false ];
	var tyobj = document.all.AttrType;
	var tyfind = false;
	for(var i=0; i < tyobj.length; i++)
	{
		if(tyobj[i].checked){ type[i] = true; tyfind=true;}		
	}
	if(!tyfind){ error=true; msg += br + "Please check at least 1 Type of new attribute."; br="<br>"; }
	
	var valty = "PreDefined"; //AdminEntered
	if(data=="List"){ valty="PreDefined"; }
	else if(data=="TextBox"){ valty="AdminEntered"; }
	else if(data=="TextArea"){ valty="AdminEntered"; }
	
	if(error){ document.all.tdError.innerHTML = msg; }
	else{ sbmNewAttr(attr, lbl, desc, data, type, valty ); }
}
//==============================================================================
// submite new attribute
//==============================================================================
function sbmNewAttr(attr, lbl, desc, data, type, valty )
{
	document.all.btnAddAttr.disabled = true;
	
	var url="MozuCrtAttr.jsp?Attr=" + attr
	 + "&Label=" + lbl
	 + "&Desc=" + desc
	 + "&InpTy=" + data
	 + "&ValueTy=" + valty
	;
	for(var i=0; i < type.length; i++){ url += "&AttrTy=" + type[i]; }
	
	clearInterval( progressIntFunc );
	progressAllTime = 0;	
	progressIntFunc = setInterval(function() {showProgress("Please wait. Attribute creating."); }, 1000);
	
	//window.location.href = url;
	window.frame1.location.href = url;	
}
//==============================================================================
//show error
//==============================================================================
function showError(error)
{
	document.all.tdError.innerHTML = error;
}
//==============================================================================
// create new product type
//==============================================================================
function crtProdType()
{
	clearInterval( progressIntFunc );
	progressAllTime = 0;
	
	progressIntFunc = setInterval(function() {showProgress("Please wait. Retreiving options and properties."); }, 1000);
	
	var url = "MozuRtvAttrLst.jsp"
	window.frame1.location.href = url;
}
//==============================================================================
//show options / Properties list  
//==============================================================================
function showOptPropList(attr, attrnm, attrty)
{
	clearInterval( progressIntFunc );
	progressAllTime = 0;
	hidePanel2();
	
	AttrId = attr;
	AttrNm = attrnm;
	AttrTy = attrty;
	setNewProdType();
}

//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel2()
{
document.all.dvProgBar.innerHTML = " ";
document.all.dvProgBar.style.visibility = "hidden";
}
//==============================================================================
// create new product type
//==============================================================================
function setNewProdType()
{
	var hdr = "Create New Product Type";
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popNewProdType()
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=850;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate option lsit panel
//==============================================================================
function popNewProdType()
{
	var panel = "<table class='tbl01' id='tblFind'>"
	+ "<tr class='trDtl03'><td class='td02'>Product Type: <input class='Small' name='ProdType' size=50 maxlength=50></td></tr>"
	+ "<tr><td>"
	+ "<div id='dvInt' class='dvInternal'>"
	+ "<table class='tbl01' id='tblSel'>"
		+ "<tr><th>Options</th><th>Properties</th></tr>"
		+ "<tr><td style='vertical-align:top;'>" + getAttrTbl("O") + "</td>"
		+ "<td style='vertical-align:top;'>" + getAttrTbl("P") + "</td></tr>"
	
	 panel += "</table>"
	  + "</div>" 
	  + "</td></tr>"
	 + "</table>"
	 + "<button onClick='vldProdTy();' class='Small'>Add</button>&nbsp;";
	 + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}
//==============================================================================
//set attribute selection table  
//==============================================================================
function getAttrTbl(type)
{
	var panel = "<table class='tbl01' id='tblOpt'>"
      + "<tr>"
    	+ "<th>Select</th>"
    	+ "<th>Name</th>"
 	  + "</tr>";
	for(var i=0; i < AttrId.length; i++)
	{
		var excl = false;
		if(type="P")
		{
			for(var j=0; j < ExclAttrNm.length ;j++)
			{
				if(AttrNm[i]==ExclAttrNm[j]){excl=true; break;}
			}
		}
		
		if(AttrTy[i]==type && !excl)
		{			
			panel += "<tr class='trDtl03' id='trOpt'>"
		   	+ "<td class='td02'><input id='Sel" + type + "Id" + i + "' type='checkbox' value='" + AttrId[i] + "'></td>"
		   	+ "<td class='td02' nowrap>" + AttrNm[i] + "</td>";
		}	   
	}
	panel += "</table>";
	return panel;
}

//==============================================================================
//validate new Product type
//==============================================================================
function vldProdTy()
{
	
}
//==============================================================================
//show error from Mozu New Option creation  
//==============================================================================
function showProgress(text)
{		
	progressTime++; 
	progressAllTime++;
	
	var html = text + " " + progressAllTime + ".s"
	  + "<br>"	 
	  + "<table><tr style='font-size:10px;'>"
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){progressTime=0;}
	
	document.all.dvProgBar.innerHTML = html;
  	document.all.dvProgBar.style.width = 250;
	document.all.dvProgBar.style.pixelLeft= document.documentElement.scrollLeft + 400;
	document.all.dvProgBar.style.pixelTop= document.documentElement.scrollTop + 300;
	document.all.dvProgBar.style.visibility = "visible";

}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
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
<div id="dvSelect" class="dvSelect"></div>
<div id="dvItem" class="dvItem"></div>
<div id="dvProgBar" class="dvProgBar"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu - Product Type List
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02">No.</th>
          <th class="th02">Product Type </th>
          <th class="th02">Attributes</th>
          <th class="th02">Properties</th>          
        </tr>
       
<!------------------------------- Detail --------------------------------->
           <%for(int i=0; i < iNumOfTy; i++) {%>
              <tr id="trId" class="trDtl04">
                <td class="td12" nowrap><%=i+1%></td>
                <td class="td11" nowrap><%=sProdTy[i]%></td>                
                <td class="td11">
                  <% String sComa = "";
                    for(int j=0; j < sPtAttr[i].length; j++){%>
                  	   <%=sComa + sPtAttr[i][j]%><% sComa=",";%>
                  <%}%>
                </td>
                <td class="td11">
                  <% sComa = "";
                    for(int j=0; j < sPtProp[i].length; j++){%>
                  	   <%=sComa + sPtProp[i][j]%><% sComa=",";%>
                  <%}%>
                </td>                
              </tr>
           <%}%>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   <%
   Date dtEnd = new Date();
   long laps = (dtEnd.getTime() - dtStart.getTime()) / 1000;   
   %>
   <%=laps%>.sec
 </body>
</html>
<%
}
%>