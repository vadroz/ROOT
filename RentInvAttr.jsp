<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String [] sSrchCls = request.getParameterValues("Cls");
   String [] sSrchStr = request.getParameterValues("Str");
   String sIncl = request.getParameter("Incl");
   String sSort = request.getParameter("Sort");

   if (sSort == null){ sSort = "ITEM"; }
   if (sIncl == null){ sIncl = " "; }
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RentInvList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   	String sUser = session.getAttribute("USER").toString();
   
   	String sPrepStmt = "select rvtype, rvven, vnam"
	 + " from Rci.ReVend"
	 + " inner join IPTSFIL.IpMrVen on rvven=vven"   		    
	 + " order by rvtype, vnam";
	   	
   	//System.out.println(sPrepStmt);
	   	
	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();
	   		   
	Vector<String> vVenTy = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vVenNm = new Vector<String>();
	   		   
	while(runsql.readNextRecord())
	{
		vVenTy.add(runsql.getData("rvtype").trim());
		vVen.add(runsql.getData("rvven").trim());
		vVenNm.add(runsql.getData("vnam").trim());
	}
	runsql.disconnect();
	runsql = null;
	
	
	sPrepStmt = "select rmtype, rmModel, rmbrand, vnam, rmage"
		 + " from Rci.ReModel" 
		 + " left join iptsfil.IpMrVen on vven=rmbrand"
		 + " order by rmtype, vnam, rmage, rmModel";			   	
	//System.out.println(sPrepStmt);
			   	
	rslset = null;
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();
			   		   
	Vector<String> vModTy = new Vector<String>();
	Vector<String> vMod = new Vector<String>();
	Vector<String> vModBra = new Vector<String>();
	Vector<String> vModBraNm = new Vector<String>();
	Vector<String> vModAge = new Vector<String>();
			   		   
	while(runsql.readNextRecord())
	{
		vModTy.add(runsql.getData("rmtype").trim());
		vMod.add(runsql.getData("rmmodel").trim());
		vModBra.add(runsql.getData("rmbrand").trim());
		String sVenNm = runsql.getData("vnam");
		if(sVenNm == null) { sVenNm = "";} 
		vModBraNm.add(sVenNm);
		vModAge.add(runsql.getData("rmage").trim());
	}
	runsql.disconnect();
	runsql = null;
	
	
	sPrepStmt = "select RSTYPE, RSGENAGE, RSSIZE, snam"
			 + " from Rci.ReSize"
			 + " inner join iptsfil.IpSizes on rssize=ssiz"
			 + " order by rstype, rsgenage, snam";			   	
	//System.out.println(sPrepStmt);
				   	
	rslset = null;
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sPrepStmt);		   
	runsql.runQuery();
				   		   
	Vector<String> vSizTy = new Vector<String>();
	Vector<String> vSizGen = new Vector<String>();
	Vector<String> vSiz = new Vector<String>();
	Vector<String> vSizNm = new Vector<String>();
				   		   
	while(runsql.readNextRecord())
	{
		vSizTy.add(runsql.getData("rstype").trim());
		vSizGen.add(runsql.getData("RSGENAGE").trim());
		vSiz.add(runsql.getData("rssize").trim());
		String sSizNm = runsql.getData("snam").trim();
		sSizNm = sSizNm.replace("'", "`");
		sSizNm = sSizNm.replace("\"", " ");
		vSizNm.add(sSizNm);
		
	}
	runsql.disconnect();
	runsql = null;
		
	// get current year
	int iYear = Calendar.getInstance().get(Calendar.YEAR);
		
	// current date
	SimpleDateFormat dtf = new SimpleDateFormat("MM/dd/yyyy");
	java.util.Date date = new java.util.Date();		
	String sCurDate = dtf.format(date);
	
	
   %>
<html>

<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />

<title>Rent Inv Attributes</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], [  "dvItem" ]);
	
	rtvVendors();
}    
//==============================================================================
//validate new brand
//==============================================================================
function vldBrand()
{
	var error = false;
	var msg="";
	var errfld = document.all.tdError;
	errfld.innerHTML = ""; 
	var br = "";
	
	var btype = document.all.BrandTy.value;
	if(btype == ""){ error=true; msg += br + "Please select Brand Type"; br = "<br>";}
		
	var brand = document.all.Ven.value.trim();
	if(brand == ""){ error=true; msg += br + "Please select Brand"; br = "<br>";}
	
	
	if(error){ errfld.innerHTML = msg; }
	else
	{
		sbmBrand( btype, brand ); 
	}
}

//==============================================================================
// submit new serial number
//==============================================================================
function sbmBrand( btype, brand )
{   
     if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	 else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	 else{ nwelem = window.frame1.contentDocument.createElement("div");}
   
   nwelem.id = "dvSbmBrand"

   var html = "<form name='frmAddBrand'"
      + " METHOD=Post ACTION='RentInvAttrSv.jsp'>"
      + "<input name='BrandTy'>"
      + "<input name='Brand'>"
      + "<input name='Action'>"
    html += "</form>"

   nwelem.innerHTML = html;
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
	 {
	  	window.frame1.document.all.Brand.value = brand;
	  	window.frame1.document.all.BrandTy.value = btype;
  	 	window.frame1.document.all.Action.value= "ADDBRAND";
 	
 	 	window.frame1.document.frmAddBrand.submit();
	 }
   else
   { 	
	   window.frame1.contentDocument.forms[0].Brand.value = brand;
	   window.frame1.contentDocument.forms[0].BrandTy.value = btype;
  	   window.frame1.contentDocument.forms[0].Action.value= "ADDBRAND";
  	   window.frame1.contentDocument.forms[0].submit();
   }   
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel(obj)
{   
	if(document.all.CalendarMenu != null){ hidetip2(); }
	document.all[obj].innerHTML = " ";
   	document.all[obj].style.visibility = "hidden";   
}  
//==============================================================================
//reload
//==============================================================================
function refreshPage(error, errflg)
{
	if(errflg){ alert(error); }
	else { window.location.reload(); }
}
//==============================================================================
//retreive vendors
//==============================================================================
function rtvVendors()
{
if (Vendor==null)
{
   var url = "RetreiveVendorList.jsp"
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
else { document.all.dvVendor.style.visibility = "visible"; }
}
//==============================================================================
//popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
Vendor = ven;
VenName = venName;
var html = "<input name='FndVen' class='Small' size=5 maxlength=5>&nbsp;"
  + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
  + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;"
  + "<br>"
var dummy = "<table>"

html += "<div id='dvInt' class='dvInternal'>"
      + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
for(var i=0; i < ven.length; i++)
{
  html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
}
html += "</table></div>"
var pos = getObjPosition(document.all.VenNm)

document.all.dvVendor.innerHTML = html;
document.all.dvVendor.style.pixelLeft= pos[0];
document.all.dvVendor.style.pixelTop= pos[1] + 25;
document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
//find selected vendor
//==============================================================================
function findSelVen()
{
var ven = document.all.FndVen.value.trim().toUpperCase();
var vennm = document.all.FndVenName.value.trim().toUpperCase();
var dvVen = document.all.dvVendor
var fnd = false;

// zeroed last search
if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
LastVen = vennm;

for(var i=LastTr+1; i < Vendor.length; i++)
{
  if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break;}
  else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break;}
  document.all.trVen[i].style.color="black";
}

// if found set value and scroll div to the found record
if(fnd)
{
  var pos = document.all.trVen[LastTr].offsetTop;
  document.all.trVen[LastTr].style.color="red";
  dvInt.scrollTop=pos;
}
else { LastTr=-1; }
}
//==============================================================================
//show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
	document.all.VenNm.value = vennm
	document.all.Ven.value = ven
}
//==============================================================================
// set selected brand type
//==============================================================================
function setSelBrandTy(sel)
{
	var selTy = sel.options[sel.selectedIndex].value;	
	var btype = document.all.BrandTy;
	if(selTy !="NONE"){	btype.value=selTy; }
	else{ btype.value=""; }
}
//==============================================================================
//set selected brand type
//==============================================================================
function dltBrand(btype, brand)
{
	var url = "RentInvAttrSv.jsp?BrandTy=" + btype
		+ "&Brand=" + brand
		+ "&Action=DLTBRAND"
	window.frame1.location.href = url;	
}
//==============================================================================
//validate new model
//==============================================================================
function vldModel()
{
	var error = false;
	var msg="";
	var errfld = document.all.tdError1;
	errfld.innerHTML = ""; 
	var br = "";
	
	var mtype = document.all.ModelTy.value;
	if(mtype == ""){ error=true; msg += br + "Please select Model Type"; br = "<br>";}
	
	var mbrand = document.all.ModelBra.value;
	if(mbrand == ""){ error=true; msg += br + "Please select Model Brand"; br = "<br>";}
	
	var mage = document.all.ModelAge.value.trim();
	if(mage == ""){ error=true; msg += br + "Please select Age"; br = "<br>";}
		
	var model = document.all.Model.value.trim();
	if(model == ""){ error=true; msg += br + "Please select Model"; br = "<br>";}
	
	
	if(error){ errfld.innerHTML = msg; }
	else
	{
		sbmModel( mtype, mbrand, mage, model ); 
	}
}

//==============================================================================
//submit new serial number
//==============================================================================
function sbmModel( mtype, mbrand, mage, model )
{   
   if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	 else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	 else{ nwelem = window.frame1.contentDocument.createElement("div");}
 
 nwelem.id = "dvSbmBrand"

 var html = "<form name='frmAddBrand'"
    + " METHOD=Post ACTION='RentInvAttrSv.jsp'>"
    + "<input name='ModelTy'>"
    + "<input name='ModelBra'>"
    + "<input name='ModelAge'>"
    + "<input name='Model'>"
    + "<input name='Action'>"
  html += "</form>"

 nwelem.innerHTML = html;
 
 if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
 else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
 else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
 else{ window.frame1.contentDocument.body.appendChild(nwelem); }

 if(isIE || isSafari)
	 {
	  	window.frame1.document.all.Model.value = model;
	  	window.frame1.document.all.ModelTy.value = mtype;
	  	window.frame1.document.all.ModelBra.value = mbrand;
	  	window.frame1.document.all.ModelAge.value = mage;
	 	window.frame1.document.all.Action.value= "ADDMODEL";
	
	 	window.frame1.document.frmAddBrand.submit();
	 }
 else
 { 	
	   window.frame1.contentDocument.forms[0].Model.value = model;
	   window.frame1.contentDocument.forms[0].ModelTy.value = mtype;
	   window.frame1.contentDocument.forms[0].ModelBra.value = mbrand;
	   window.frame1.contentDocument.forms[0].ModelBra.value = mbrand;
	   window.frame1.contentDocument.forms[0].ModelAge.value = mage;
	   window.frame1.contentDocument.forms[0].Action.value= "ADDMODEL";
	   
	   window.frame1.contentDocument.forms[0].submit();
 }   
}
//==============================================================================
//set selected model type
//==============================================================================
function setSelModelTy(sel)
{
	var selTy = sel.options[sel.selectedIndex].value;	
	var mtype = document.all.ModelTy;
	if(selTy !="NONE"){	mtype.value=selTy; }
	else{ mtype.value=""; } 
	
	var age = document.getElementsByName("selModAge")[0];
	
	for (var i = age.length; i > 0; i--){ age.options[i] = null; }
	 
	if(selTy.indexOf("BIKE"))
	{
		age.options[1] = new Option("ADULT" , "ADULT");
		age.options[2] = new Option("JR" , "JR");
	}
	else
	{
		age.options[1] = new Option("NOAGE" , "NONE");
	} 
	 
}
//==============================================================================
//set selected model brand
//==============================================================================
function setSelModBra(sel)
{
	var selBra = sel.options[sel.selectedIndex].value;	
	var selBraNm = sel.options[sel.selectedIndex].text;
	var mbrand = document.all.ModelBra;
	var mbrandNm = document.all.ModelBraNm;
	if(selBra !="NONE"){ mbrand.value=selBra; mbrandNm.value=selBraNm; }
	else{ mtype.value=""; mbrandNm.value="";}
}
//==============================================================================
//set selected model brand
//==============================================================================
function setSelModAge(sel)
{
	var selAge = sel.options[sel.selectedIndex].value;	
	document.all.ModelAge.value = selAge;
	
}
//==============================================================================
//set selected brand type
//==============================================================================
function dltModel(mtype, mbrand, mage, model)
{
	var url = "RentInvAttrSv.jsp?ModelTy=" + mtype
	    + "&ModelBra=" + mbrand
	    + "&ModelAge=" + mage
		+ "&Model=" + model
		+ "&Action=DLTMODEL"
	window.frame1.location.href = url;	
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table class="tbl01">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Rental Inventory Attribute Entry
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       This Page.<br>
            
   <!----------------------- Order List ------------------------------>
     <table class="tbl02" id="tbEntry">
       <thead id="thead1">
       <tr class="trHdr01">
          <th class="th13">Type</th>
          <th class="th13">Brand</th>
          <th class="th13">Name</th>
          <th class="th13">Dlt</th>
       </tr>
       </thead>
       <tr class="trDtl04" >
          <td class="td11" style="vertical-align: top;"><input name="BrandTy" size=12 maxlength=10 readOnly>
             <select name="selBrandTy" onchange="setSelBrandTy(this)">
               <option value="NONE">--- Select Brand Type ----</option>
               <option value="SKI">Skis</option>
               <option value="SKIPERF">Performance Skis</option>
               <option value="SKIBOOT">Ski Boots</option>
               <option value="SNOWBOARD">Snowboards</option>
               <option value="SBRBOOT">Snowboard Boots</option>
               <option value="WATER">Water Sports</option>
               <option value="BIKESM">Standard Mountain Bikes</option>
               <option value="BIKEHB">Hybrid Mountain Bikes</option>
               <option value="BIKEFS">Full Suspense Mountain Bikes</option>
               <option value="BIKEEL">E-Bikes</option>
               <option value="BIKEYM">Youth Standard Mountain Bikes</option>  
               <option value="BIKEKD">Kid's Trailer</option>
             </select>
          </td>
          <td class="td11" style="vertical-align: top;"><input name="Ven" size=7 maxlength=5 readOnly></td>
          <td class="td11" colspan=2><input name="VenNm" size=27 maxlength=25 readOnly>
          
          <button class="Small" onClick="vldBrand()">Add</button>
          <br>
          <div id="dvVendor" style=" border: gray solid 1px; width:305; height:250;background-color:white; z-index:10; text-align:left; font-size:10px"></div>           
          </td>
          
       </tr>
       <tr class="trDtl04" >
       		<td class="tdError" style="vertical-align: top;" id="tdError" colspan=3></td>
       </tr>
       
       
       <%for(int i=0, j=0; i < vVen.size(); i++){%>
       <tr class="trDtl06">
          <td class="td11" id="tdBrand<%=i%>"><%=vVenTy.get(i)%></td>
          <td class="td11" id="tdBrand<%=i%>"><%=vVen.get(i)%></td>
          <td class="td11" id="tdBrand<%=i%>"><%=vVenNm.get(i)%></td>
          <td class="td18" id="tdBrand<%=i%>"><a href="javascript: dltBrand('<%=vVenTy.get(i)%>','<%=vVen.get(i)%>')">D</a></td>
       </tr>
       <%} %>
        </tbody>
    </table>
    
    <br>
    
    <!-- =================== Model List ================================== -->
    <table class="tbl02" id="tbEntry">
       <thead id="thead2">
       <tr class="trHdr01">
          <th class="th13">Type</th>
          <th class="th13">Brand</th>
          <th class="th13">Age</th>
          <th class="th13">Model</th>
          <th class="th13">Dlt</th>
       </tr>
       <tr class="trDtl04" >
          <td class="td11" style="vertical-align: top;"><input name="ModelTy" size=12 maxlength=10 readOnly>
          	 <select name="selModelTy" onchange="setSelModelTy(this)">
               <option value="NONE">--- Select Model Type ----</option>
               <option value="SKI">Skis</option>
               <option value="SKIPERF">Performance Skis</option>
               <option value="SKIBOOT">Ski Boots</option>
               <option value="SNOWBOARD">Snowboards</option>
               <option value="SBRBOOT">Snowboard Boots</option>
               <option value="WATER">Water Sports</option>
               <option value="BIKESM">Standard Mountain Bikes</option>
               <option value="BIKEHB">Hybrid Mountain Bikes</option>
               <option value="BIKEFS">Full Suspense Mountain Bikes</option>
               <option value="BIKEEL">E-Bikes</option>
               <option value="BIKEYM">Youth Standard Mountain Bikes</option>
               <option value="BIKEKD">Kid's Trailer</option>
             </select>
          </td>
          
          <td class="td11" style="vertical-align: top;">
             <input name="ModelBra" size=5 maxlength=5 readOnly>
             <input name="ModelBraNm" size=27 maxlength=25 readOnly>
          	 <select name="selModBra" onchange="setSelModBra(this)">
               <option value="NONE">--- Select Brand Type ----</option>
               <%for(int i=0; i < vVen.size(); i++ ){%>
                 <option value="<%=vVen.get(i)%>"><%=vVenNm.get(i)%></option>
               <%}%>
             </select>
          </td>
          
          <td class="td11" style="vertical-align: top;">
             <input name="ModelAge" size=10 maxlength=10 readOnly>
             <select name="selModAge" onchange="setSelModAge(this)">
               <option value="NONE">--- Select Age ----</option>
               <option value="ADULT">ADULT</option>
               <option value="JR">JR</option>  
               <option value="NOAGE">NONE</option>
             </select>
          </td>
          
          <td class="td11" style="vertical-align: top;" colspan=2>
          	<input name="Model" size=32 maxlength=30>
          	<button class="Small" onClick="vldModel()">Add</button>
          </td>
       </tr> 
       
       <tr class="trDtl04" >
       		<td class="tdError" style="vertical-align: top;" id="tdError1" colspan=3></td>
       </tr>
       
       </thead>
       
       <%for(int i=0, j=0; i < vMod.size(); i++){%>
       <tr class="trDtl06">
          <td class="td11" id="tdBrand<%=i%>"><%=vModTy.get(i)%></td>
          <td class="td11" id="tdBrand<%=i%>"><%=vModBra.get(i)%> - <%=vModBraNm.get(i)%></td>
          <td class="td11" id="tdBrand<%=i%>"><%=vModAge.get(i)%></td>
          <td class="td11" id="tdBrand<%=i%>"><%=vMod.get(i)%></td>
          <td class="td18" id="tdBrand<%=i%>"><a href="javascript: dltModel('<%=vModTy.get(i)%>','<%=vModBra.get(i)%>','<%=vModAge.get(i)%>','<%=vMod.get(i)%>')">D</a></td>
       </tr>
       <%} %>
       
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>


<%  
  }%>