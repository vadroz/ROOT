<%@ page import="mozu_com.MozuImageLst"%>
<%
    String sCls = request.getParameter("Cls");
    String sVen = request.getParameter("Ven");
    String sSty = request.getParameter("Sty");
    String sSite = request.getParameter("Site");
    
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MozuImageLst.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    MozuImageLst imglst = new MozuImageLst();
	imglst.setImageByCVS(sSite, sCls, sVen, sSty, sUser);
	int iNumOfImg = imglst.getNumOfImg();
	
	String sDesc = imglst.getDesc();
	String sVenNm = imglst.getVenNm();
	int iNumOfClr = imglst.getNumOfClr();
	String [] sClr = imglst.getClr();
	String [] sClrNm = imglst.getClrNm();
	String [] sClrId = imglst.getClrId();
	String sClrIdJsa = imglst.cvtToJavaScriptArray(sClrId);
	String sClrNmJsa = imglst.cvtToJavaScriptArray(sClrNm);
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:11px }
        tr.DataTable0 { background: red; font-size:11px }
        tr.DataTable1 { background: CornSilk; font-size:11px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        td.DataTable3{ background: white; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable4 { background: white;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable5 { background: white;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable6 { background: #ccffcc;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable7 { background: #cccfff;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.3">
var Cls = "<%=sCls%>";
var Ven = "<%=sVen%>";
var Sty = "<%=sSty%>";
var NumOfImg = "<%=iNumOfImg%>";
var ClrId = [<%=sClrIdJsa%>];
var ClrNm = [<%=sClrNmJsa%>];

var progressIntFunc = null;
var progressTime = 0;


//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
// add/chg/delete item entry
//==============================================================================
function chgImage(seq, arg, name, clrid, clrnm, action)
{
   var hdr = "";
   if(action == "ADD") { hdr = "Add Image for " + Cls +  "-" + Ven +  "-" + Sty +  "-"; }
   else if(action == "DLT") { hdr = "Delete Image for " + Cls +  "-" + Ven +  "-" + Sty +  "-"; }
   
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popImage(action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 140;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 205;
   document.all.dvItem.style.visibility = "visible";
   
   if(action == "ADD")
   { 
	   document.all.Seq.value = "0"; 
	   document.all.Item.value=Cls + Ven + Sty;
	   document.all.Action.value=action;	 
	   document.all.Comment.value = document.all.tdDesc.innerHTML;
   }
   else
   {
	   document.all.Seq.value = seq;
	   var fname = "tdFile" + arg;	   
	   var file = document.all[fname];
	   document.all.File.value = file.innerHTML;
	   document.all.Name.value = name;
	   
	   var commfld = "tdComm" + arg;
	   var comment = document.all[commfld].innerHTML;
	   if(comment.trim()=="")
	   {
		   document.all.Comment.value = document.all.tdDesc.innerHTML;
	   }
	   else 
	   {
		   document.all.Comment.value = comment;
	   }
	   
	   document.all.ClrId.value = clrid;
	   document.all.spnClrNm.innerHTML = clrnm;
   }
   // populate color selection
   document.all.SelClr.options[0] = new Option("---- Select Color Id ----", ""); 
   for(var i=0, j=1; i < ClrId.length; i++, j++)
   {
	   document.all.SelClr.options[j] = new Option(ClrNm[i], ClrId[i]);
   }	   
   
   if(action == "DLT") {document.all.Comment.readOnly;}
}
//==============================================================================
//populate Color Id with selected color
//==============================================================================
function getClrId(sel)
{
	var clrid = sel.options[sel.selectedIndex].value;
	var clrnm = sel.options[sel.selectedIndex].text;
	document.all.ClrId.value = clrid;
	document.all.spnClrNm.innerHTML = clrnm;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popImage( action)
{
  	var panel = "<form name='Upload'  method='post' enctype='multipart/form-data'"
  	  + " action='MozuUplPicToSrvr.jsp'>"
  	  + "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  	panel += "<tr class='DataTable1'>"
           + "<td class='DataTable2' >File:</td>"
  	if(action == "ADD")
  	{
	  panel += "<td class='DataTable1'><input type='file' name='File' size=100 maxlength=100>" 
  	}
  	else
  	{
	  panel +=  "<td class='DataTable1'><input name='File' size=100 maxlength=100 readonly>"
  	}         
  	panel += "<input type='hidden' name='Seq'>"
           + "</td>"
       + "</tr>"
              
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Image Alt Text:</td>"
           + "<td class='DataTable1'><input name='Comment' size=60 maxlength=44>"
              + "<input type='hidden' name='FileName'>"
           	  + "<input type='hidden' name='Name'>"
           	  + "<input type='hidden' name='Item'>"
              + "<input type='hidden' name='Action'>"
           + "</td>"
       + "</tr>"
       
       + "<tr class='DataTable1'>"
  	   		+ "<td class='DataTable2' >Color:</td>"       		
  	   		+ "<td class='DataTable1'><input name='ClrId' readonly>"
  	   		+ "&nbsp; <span id='spnClrNm'></span>"
       		+ "<br><select name='SelClr' onchange='getClrId(this)'></select>"
  	   		+ "</td>"
  	   + "</tr>"
       
       + "<tr class='DataTable1'>"
           + "<td class='DataTable1' style='color:red; font-weight:bold;' colspan=2 id='tdError'></td>"
       + "</tr>"

  	panel += "<tr class='DataTable1'>";
  	panel += "<td class='DataTable' colspan=2><br><br><button onClick='Validate(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
  	panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  	panel += "</table>";
  	   
  	panel += "</form>";
  	return panel;
}
//==============================================================================
// validate entries
//==============================================================================
function Validate(action)
{
  var error = false;
   var msg = "";
   document.all.tdError.innerHTML = msg;

   var seq = document.all.Seq.value;
   var name = document.all.Name.value;
   var comment = document.all.Comment.value;
   if(comment.length > 44){ comment = comment.substring(0,43); }
   document.all.Comment.value = comment;
   
   var file = document.all.File.value.trim();
   if(file == ""){ error=true; msg += "<br>Please enter the File path." }
   
   var clrid = document.all.ClrId.value.trim();
   if(clrid == ""){ error=true; msg += "<br>Please enter Color Id." }   
        
   if (error){ document.all.tdError.innerHTML = msg; }
   else
   { 
	   if(action == 'ADD'){sbmAddNewImgAs4();}
	   else{ sbmUpdDltImg( seq, file, name, comment, clrid, action ); }
   }
}
//==============================================================================
// add new image in AS400 file only
//==============================================================================
function sbmAddNewImgAs4(  )
{
	var form = document.all.Upload;
	window.frame1.document.body.appendChild(form);   
	window.frame1.document.Upload.FileName.value = window.frame1.document.Upload.File.value; 
	
	var f1sel = frame1.document.getElementById("SelClr");
	f1sel.parentNode.removeChild(f1sel);

	
	window.frame1.document.Upload.submit();
	hidePanel();
	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000); 
}
//==============================================================================
//submit update/delete image
//==============================================================================
function sbmUpdDltImg(seq, file, name, comment, clrid, action)
{
	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvSbmImage"

  	var html = "<form name='frmAddImage'"
     + " METHOD=Post ACTION='MozuUplPicture.jsp'>"
     + "<input class='Small' name='Cls'>"
     + "<input class='Small' name='Ven'>"
     + "<input class='Small' name='Sty'>"
     + "<input class='Small' name='Action'>"
     + "<input class='Small' name='Seq'>" 
     + "<input class='Small' name='File'>"
     + "<input class='Small' name='Name'>"
     + "<input class='Small' name='Comment'>"
     + "<input class='Small' name='ClrId'>"
    
  	html += "</form>";

  	nwelem.innerHTML = html;
  	frmcommt = document.all.frmEmail;
	window.frame1.document.appendChild(nwelem);

 	window.frame1.document.all.Cls.value=Cls;
 	window.frame1.document.all.Ven.value=Ven;
 	window.frame1.document.all.Sty.value=Sty;
 	window.frame1.document.all.Action.value=action;
 
    window.frame1.document.all.Seq.value=seq;
    window.frame1.document.all.File.value=file;
    window.frame1.document.all.Name.value=name;
    window.frame1.document.all.Comment.value=comment;
    window.frame1.document.all.ClrId.value=clrid;
 
 
 	//alert(html)
 	window.frame1.document.frmAddImage.submit();
 	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000); 
}
//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = "";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//upload selected images
//==============================================================================
function uplImage(action)
{
	var upl = new Array();
	var seq = new Array();
	var file = new Array();
	var name = new Array();
	var comment = new Array();
	
	for(var i=0, j=0, k=0; i < NumOfImg; i++)
	{		
		// check if image new or need to be updated
		var wait = getFldVal("Wait", i)
		if(wait == "true")
		{		
			// check if new/updated iamge was selected for uploading
			var fld = "UplImg" + i;
			upl[upl.length] = document.all[fld];
			k = upl.length - 1;
			if(upl[k] != null && upl[k].checked)
			{	
				// save in array selected image properties
				seq[j] = getFldVal("Seq",  i);			
				file[j] = getFldVal("File",  i);
				name[j] = getFldVal("Name",  i);
				comment[j] = getFldVal("Comment",  i);
				if(comment[j].length > 44){ comment[j] = comment[j].substring(0,43); }
				j++;
			}
		}		
	}
	sbmUplImg(seq, file, name, comment, action );
}

//==============================================================================
//refresh screen
//==============================================================================
function sbmUplImg(seq, file, name, comment, action)
{
	var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmImage"

    var html = "<form name='frmAddImage'"
       + " METHOD=Post ACTION='MozuUplPicture.jsp'>"
       + "<input class='Small' name='Cls'>"
       + "<input class='Small' name='Ven'>"
       + "<input class='Small' name='Sty'>"
       + "<input class='Small' name='Action'>"
    ;
    for(var i=0; i < seq.length; i++)
    {	
       html += "<input class='Small' name='Seq'>" 
       + "<input class='Small' name='File'>"
       + "<input class='Small' name='Name'>"
       + "<input class='Small' name='Comment'>"
       
    } 
    html += "</form>";

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Cls.value=Cls;
   window.frame1.document.all.Ven.value=Ven;
   window.frame1.document.all.Sty.value=Sty;
   window.frame1.document.all.Action.value=action;
   
   if(seq.length > 1)
   {
	   for(var i=0; i < seq.length; i++)
   	   {
		   window.frame1.document.all.Seq[i].value=seq[i];
   	   	   window.frame1.document.all.File[i].value=file[i];
   	       window.frame1.document.all.Name[i].value=name[i];
           window.frame1.document.all.Comment[i].value=comment[i];       
       }
   }
   else
   {
	   window.frame1.document.all.Seq.value=seq[0];
	   window.frame1.document.all.File.value=file[0];
	   window.frame1.document.all.Name.value=name[0];
       window.frame1.document.all.Comment.value=comment[0];
   }
   
   //alert(html)
   window.frame1.document.frmAddImage.submit();
   
   progressIntFunc = setInterval(function() {showWaitBanner() }, 1000);    
}
//==============================================================================
// update Image Map properties for all images
//==============================================================================
function updImageMap(action)
{
	var upl = new Array();
	var seq = new Array();
	var name = new Array();
	var clrid = new Array();
	
	for(var i=0; i < NumOfImg; i++)
	{			
		var fld = "UplImg" + i;
		upl[upl.length] = document.all[fld];
		// save in array selected image properties
		seq[i] = getFldVal("Seq",  i);			
		name[i] = getFldVal("Name",  i);
		clrid[i] = getFldVal("ClrId",  i);				
	}
	sbmUpdImgMapProperty(seq, name, clrid, action );
}
//==============================================================================
// submit image map property update
//==============================================================================
function sbmUpdImgMapProperty(seq, name, clrid, action)
{
	var nwelem = window.frame1.document.createElement("div");
	nwelem.id = "dvSbmImage"

  	var html = "<form name='frmAddImage'"
     + " METHOD=Post ACTION='MozuUplPicture.jsp'>"
     + "<input class='Small' name='Site'>"
     + "<input class='Small' name='Cls'>"
     + "<input class='Small' name='Ven'>"
     + "<input class='Small' name='Sty'>"
     + "<input class='Small' name='Action'>"
  	;
  	for(var i=0; i < seq.length; i++)
  	{	
    	html += "<input class='Small' name='Seq'>" 
     	+ "<input class='Small' name='Name'>"
     	+ "<input class='Small' name='ClrId'>"
  	} 
  	html += "</form>";

 	nwelem.innerHTML = html;
 	frmcommt = document.all.frmEmail;
 	window.frame1.document.appendChild(nwelem);

 	window.frame1.document.all.Site.value="<%=sSite%>";
 	window.frame1.document.all.Cls.value=Cls;
 	window.frame1.document.all.Ven.value=Ven;
 	window.frame1.document.all.Sty.value=Sty;
 	window.frame1.document.all.Action.value=action;
 
 	if(seq.length > 1)
 	{
		for(var i=0; i < seq.length; i++)
 	 	{
		 	window.frame1.document.all.Seq[i].value=seq[i];
 	   	 	window.frame1.document.all.Name[i].value=name[i];
        	window.frame1.document.all.ClrId[i].value=clrid[i];       
     	}
 	}
 	else
 	{
		window.frame1.document.all.Seq.value=seq[0];
	 	window.frame1.document.all.Name.value=name[0];
	 	window.frame1.document.all.ClrId.value=clrid[0]; 
 	}
 
 	//alert(html)
 	window.frame1.document.frmAddImage.submit();
 
 	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000); 
}


//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
}

//==============================================================================
//get field values
//==============================================================================
function getFldVal(nm, i)
{
var fld = nm + i;
var val = document.all[fld].value;
return val;
}
//==============================================================================
// refresh screen
//==============================================================================
function refresh()
{
   window.location.reload();
}
//==============================================================================
// show errors
//==============================================================================
function showError(error)
{
   document.all.tdError.innerHTML = "";
   var br = "";
   for(var i=0; i < error.length;i++)
   {
       document.all.tdError.innerHTML += br + error[i];
       br = "<br>";
   }
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
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item Image Uploading - Selection
        </B>

        <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="MozuImageLstSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: chgImage(null, null,  null,null, null, 'ADD')">Add Item</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: uplImage('UPLOAD')">Upload Selected Items</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: updImageMap('UPDIMGMAP')">Update Image Mapping</a>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=0 cellPadding="0" cellSpacing="0">
         <tr class="DataTable1">
             <th>Description: &nbsp; &nbsp; &nbsp; </th>
             <td id="tdDesc"><%=sDesc%></td>
             <th> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</th>
			 <th>Vendor Name: &nbsp; &nbsp; &nbsp; </th>
             <td><%=sVenNm%></td>
         </tr>         
         <tr class="DataTable1">
            <th align="left">Colors: &nbsp; &nbsp; &nbsp; </th>
         	<td colspan=4>
         	<table border=1 cellPadding="0" cellSpacing="0">
         	   <tr class="DataTable">
             		<th class="DataTable">IP Color Id</th>
             		<th class="DataTable">Mozu Color Id</th>
             		<th class="DataTable">Color Name</th>
               </tr>
         	   <%for(int i=0; i < iNumOfClr; i++){%>
         	   		<tr class="DataTable1">
         	   			<td><%=sClr[i]%></td>
         	   			<td><%=sClrId[i]%></td>
         	     		<td><%=sClrNm[i]%></td>
         	   		</tr>
         	   <%}%>
         	</table>
         	</td>
         </tr>
        </table><br>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Upload</th>
             <!--   th class="DataTable">Image</th -->
             <th class="DataTable">Name</th>             
             <th class="DataTable">Color</th>
             <th class="DataTable">File</th>
             <th class="DataTable">Comment</th>
             <th class="DataTable">Delete</th>             
         </tr>         
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfImg; i++)
         {
    	   imglst.setDetail();
    	   String sSeq = imglst.getSeq();
		   String sFile = imglst.getFile();
		   String sName = imglst.getName();			
		   String sComment = imglst.getComment(); 
		   String sWait = imglst.getWait();
		   String sImgClrId = imglst.getImgClrId();
		   String sImgClrNm = imglst.getImgClrNm();	
		   boolean bUpload = sWait.equals("Y");
       %>
          <tr class="DataTable">
            <td class="DataTable1" nowrap>
            	<%if(bUpload){%><input type="checkbox" name="UplImg<%=i%>"></a><%} else {%>&nbsp;<%} %>
            		<input type="hidden" name="Wait<%=i%>" value=<%=bUpload%>>            		
					<input type="hidden" name="Seq<%=i%>" value="<%=sSeq%>">
					<input type="hidden" name="File<%=i%>" value="<%=sFile%>">
					<input type="hidden" name="Name<%=i%>" value="<%=sName%>">
					<input type="hidden" name="Comment<%=i%>" value="<%=sComment%>">
					<input type="hidden" name="ClrId<%=i%>" value="<%=sImgClrId%>">
            </td>
            <!-- td class="DataTable1" nowrap><img src="<%=sFile%>" alt="<%=sName%>" height="70" width="50"></td -->
            <td class="DataTable1" nowrap><a href="javascript: chgImage('<%=sSeq%>', '<%=i%>', '<%=sName%>', '<%=sImgClrId%>', '<%=sImgClrNm%>', 'UPD')"><%=sName%></a></td>
            <td class="DataTable1" nowrap><%=sImgClrId%> <%=sImgClrNm%></td>
            <td class="DataTable1" id="tdFile<%=i%>" nowrap><%=sFile%></td>             
            <td class="DataTable1" id="tdComm<%=i%>" nowrap><%=sComment%></td>
            <td class="DataTable1" nowrap><a href="javascript: chgImage('<%=sSeq%>', '<%=i%>', '<%=sName%>', '<%=sImgClrId%>', '<%=sImgClrNm%>', 'DLT')">Delete</a></td>                       
          </tr>
       <%}%>
     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   imglst.disconnect();
   imglst = null;
   }
%>




















