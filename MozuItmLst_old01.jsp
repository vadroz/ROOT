<%@ page import="mozu_com.MozuItmLst"%>
<%
    String sSrchDiv = request.getParameter("Div");
    String sSrchDpt = request.getParameter("Dpt");
    String sSrchCls = request.getParameter("Cls");
    String sSrchVen = request.getParameter("Ven");
    String sSite = request.getParameter("Site");
    String sFrom = request.getParameter("From");
    String sTo = request.getParameter("To");
    String sFromIP = request.getParameter("FromIP");
    String sToIP = request.getParameter("ToIP");
    String sSrchDownl = request.getParameter("MarkDownl");
    String sExcel = request.getParameter("Excel");
    String sSelParent = request.getParameter("Parent");
    String sSelPon = request.getParameter("Pon");
    String sSelModelYr = request.getParameter("ModelYr");
    String sSelMapExpDt = request.getParameter("MapExpDt");
    String sInvAvl = request.getParameter("InvAvl");
    String sInvStr = request.getParameter("InvStr");
    String sMarkedWeb = request.getParameter("MarkedWeb");
   
    if(sSelModelYr==null) { sSelModelYr = " "; }
    if(sSelMapExpDt==null) { sSelMapExpDt = " "; }

    if(sFromIP==null) { sFromIP = "ALL"; }
    if(sToIP==null) { sToIP = "ALL"; }

    String sSort = request.getParameter("Sort");
    if(sSort==null) { sSort = "ITEM"; }

    if(sInvAvl==null){ sInvAvl = "NONE"; }
    if(sInvStr==null){ sInvStr = "ALL"; }
    if(sMarkedWeb==null) { sMarkedWeb = "N"; }
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MozuItmLst.jsp");
}
else
{
    boolean bDwnLoad = session.getAttribute("ECOMDWNL") != null;
    boolean bMarkAttr = session.getAttribute("ECMARKATTR") != null;
    String sUser = session.getAttribute("USER").toString();

    MozuItmLst itmLst = new MozuItmLst(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen
       , sSite, sFrom, sTo, sFromIP, sToIP, sSrchDownl, sSelParent, sSelPon, sSelModelYr, sSelMapExpDt
       , sInvAvl, sInvStr, sMarkedWeb, sSort, sUser);
    int iNumOfItm = itmLst.getNumOfItm();

    String [] sGenderLst = new String[]{"M", "W", "B", "G", "A", "Y",
                                         "C", "I", "U", "T", "Z", "E", "F", "H"};
    String [] sGenderName = new String[]{"Men's", "Women's", "Boy's", "Girl's", "Adult", "Youth",
                                         "Children's", "Infant", "Unisex", "Toddler Boy's",
                                         "Toddler Girl's", "Toddler's", "Jr. Boy's", "Jr. Girl's", " "};
    if (sExcel.equals("Y")) { response.setContentType("application/vnd.ms-excel"); }
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.DataTable2 { color:white; background: grey; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable02 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}



        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvOpt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:#E1F5A9; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvProgBar { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; height:25px; background-color:azure; z-index:10;
              text-align:left; font-size:12px}
              
        div.dvFlyMenu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:50; height:25px; background-color:azure; z-index:10;
              text-align:left; font-size:12px}
                          
        div.dvOptSel { border: gray solid 1px; display:none;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
        div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
 		div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  		div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }      

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

		td.Error { color: red; text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; }
</style>


<script name="javascript1.2">
var NumOfItm = <%=iNumOfItm%>;
var Used = false;
var SbmCmd = new Array();
var SbmLoop = 0;
var SbmQty = 0;
var SelCol=null;
var SelCell = new Array(NumOfItm);
var SelValue = null;
var ShowOnLineDesc = true;
var OnPO = new Array();
var ShowPOOnly = false;
var OldItem = new Array();
var ShowOldItem = false;
var ShowUnattr = false;
var SelProdType = null;
var SelProdTypeId = null;
var User = "<%=sUser%>";

var progressIntFunc = null;
var progressTime = 0;

var OptionSel = null;
var OptionNmSel = null;
var LastTr = -1;
var LastOpt = "";
 
var DispCol = true;

var SelIpOptId = null;
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvOpt"]);
   showOptCol();
}

//==============================================================================
// show optiunal columns
//==============================================================================
function showOptCol()
{
	var disp = "block";
	if(DispCol){disp = "none";}
	document.all.thSku.style.display = disp;
	document.all.thDesc.style.display = disp;
	document.all.thShortDs.style.display = disp;
	document.all.thFullDs.style.display = disp;
	document.all.thCateg.style.display = disp;
	document.all.thMnf.style.display = disp;
	document.all.thModel.style.display = disp;
	document.all.thMdlYear.style.display = disp;
	document.all.thGender.style.display = disp;
	document.all.thMap.style.display = disp;
	document.all.thNoMap.style.display = disp;
	document.all.thMapDt.style.display = disp;
	document.all.thLive.style.display = disp;
	//document.all.thUpc.style.display = disp;
	document.all.thTaxFree.style.display = disp;
	
	if (NumOfItm > 1)
	{
		for(var i=0; i < NumOfItm; i++)
		{
			document.all.tdSku[i].style.display = disp;
			document.all.tdDesc[i].style.display = disp;
			document.all.tdShortDs[i].style.display = disp;
			document.all.tdFullDs[i].style.display = disp;
			document.all.tdCateg[i].style.display = disp;
			document.all.tdMnf[i].style.display = disp;
			document.all.tdModel[i].style.display = disp;
			document.all.tdMdlYear[i].style.display = disp;
			document.all.tdGender[i].style.display = disp;
			document.all.tdMap[i].style.display = disp;
			document.all.tdNoMap[i].style.display = disp;
			document.all.tdMapDt[i].style.display = disp;
			document.all.tdLive[i].style.display = disp;
			//document.all.tdUpc[i].style.display = disp;
			document.all.tdTaxFree[i].style.display = disp;
		}
	}
	else
	{
		document.all.tdSku.style.display = disp;
		document.all.tdDesc.style.display = disp;
		document.all.tdShortDs.style.display = disp;
		document.all.tdFullDs.style.display = disp;
		document.all.tdCateg.style.display = disp;
		document.all.tdMnf.style.display = disp;
		document.all.tdModel.style.display = disp;
		document.all.tdMdlYear.style.display = disp;
		document.all.tdGender.style.display = disp;
		document.all.tdMap.style.display = disp;
		document.all.tdNoMap.style.display = disp;
		document.all.tdMapDt.style.display = disp;
		document.all.tdLive.style.display = disp;
		//document.all.tdUpc.style.display = disp;
		document.all.tdTaxFree.style.display = disp;
	}
	
	DispCol = !DispCol;
}
//==============================================================================
// run on loading
//==============================================================================
function chgItem(i,cls,ven,sty,clr,siz)
{
   //check if order is paid off
   var div = null; var dpt = null; var item = null; var desc = null; var categ = null; var webi = null; var webs = null;
   var cat1 = null; var cat2 = null; var cat3 = null; var cat4 = null; var clrnm = null; var siznm = null;
   var upc = null; var sku = null; var mnf = null; var model = null; var mdlyear = null; var map = null;
   var nomap = null; var mapdt = null; var gender = null; var downl= null; var live = null;

   if (NumOfItm > 1)
   {
     item = document.all.tdItem[i];
     desc = document.all.tdDesc[i];
     categ = document.all.tdCateg[i];
     webi = "";//document.all.tdWebI[i];
     webs = document.all.tdWebS[i];
     cat1 = "";// document.all.tdCat1[i];
     cat2 = "";// document.all.tdCat2[i];
     cat3 = "";// document.all.tdCat3[i];
     cat4 = "";// document.all.tdCat4[i];
     div = document.all.tdDiv[i];
     dpt = document.all.tdDpt[i];
     sku = document.all.tdSku[i];
     upc = document.all.tdUpc[i];
     clrnm = document.all.tdColor[i];
     normclr = document.all.tdNormClr[i];
     siznm = document.all.tdSize[i];
     mnf = document.all.tdMnf[i];
     model = document.all.tdModel[i];
     mdlyear = document.all.tdMdlYear[i];
     map = document.all.tdMap[i];
     nomap = document.all.tdNoMap[i];
     mapdt = document.all.tdMapDt[i];
     gender = document.all.tdGender[i];
     live = document.all.tdLive[i];
     if(document.all.Down != null && document.all.Down[i] != null) { downl = document.all.Down[i]; }
   }
   else
   {
     item = document.all.tdItem;
     desc = document.all.tdDesc;
     categ = document.all.tdCateg;
     webi = "";// document.all.tdWebI;
     webs = document.all.tdWebS;
     cat1 = "";// document.all.tdCat1;
     cat2 = "";// document.all.tdCat2;
     cat3 = "";// document.all.tdCat3;
     cat4 = "";// document.all.tdCat4;
     div = document.all.tdDiv;
     dpt = document.all.tdDpt;
     sku = document.all.tdSku;
     upc = document.all.tdUpc;
     clrnm = document.all.tdColor;
     normclr = document.all.tdNormClr;
     siznm = document.all.tdSize;
     mnf = document.all.tdMnf;
     model = document.all.tdModel;
     mdlyear = document.all.tdMdlYear;
     map = document.all.tdMap;
     nomap = document.all.tdNoMap;
     mapdt = document.all.tdMapDt;
     gender = document.all.tdGender;
     live = document.all.tdLive;
     if(document.all.Down != null) { downl = document.all.Down; }
   }

   var hdr = "Item:&nbsp;" + item.innerHTML + "&nbsp;" + desc.innerHTML;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popItmPanel(i,cls,ven,sty,clr,siz, div, dpt, desc, categ, sku, upc, clrnm, siznm,
                      mnf, model, mdlyear, map, nomap, mapdt, gender, downl, webi, webs,
                      cat1, cat2, cat3, cat4, live)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   if(webi.innerHTML == "Y") document.all.Web[0].checked = true;
   else if(webs.innerHTML == "Y") document.all.Web[1].checked = true;
   else document.all.Web[2].checked = true;

   if(cat1.innerHTML == "Y") document.all.Cat[0].checked = true;
   if(cat2.innerHTML == "Y") document.all.Cat[1].checked = true;
   if(cat3.innerHTML == "Y") document.all.Cat[2].checked = true;
   if(cat4.innerHTML == "Y") document.all.Cat[3].checked = true;
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popItmPanel(i,cls,ven,sty,clr,siz, div, dpt, desc, categ, sku, upc, clrnm, siznm, mnf,
    model, mdlyear, map, nomap, mapdt, gender, downl, webi, webs, cat1, cat2, cat3, cat4, live)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt' >Division:</td>"
           + "<td class='Prompt' colspan='2'>" + div.innerHTML + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt'>Department:</td>"
           + "<td class='Prompt' colspan='2'>" + dpt.innerHTML + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt'>Short SKU:</td>"
           + "<td class='Prompt' colspan='2'>" + sku.innerHTML + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt'>UPC:</td>"
           + "<td class='Prompt' colspan='2'>" + upc.innerHTML + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Description:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name=Desc class='Small' value='" + desc.innerHTML + "' size=50 maxlength=50>"
           + "</td>"
         + "<tr><td class='Prompt3'>Category:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name=Categ class='Small' value='" + categ.innerHTML + "' size=50 maxlength=50>"
           + "</td>"
         + "<tr><td class='Prompt3'>Color Name:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name=ClrNm class='Small' value='" + clrnm.innerHTML + "' size=50 maxlength=50>"
           + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Size Name:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name=SizNm class='Small' value='" + siznm.innerHTML + "' size=25 maxlength=25>"
           + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Web:</td>"
           + "<td class='Prompt'><input type=radio name=Web value=1>Info<br>"
           + "<input type=radio name=Web value=2>Sales</td>"
           + "<td class='Prompt3'><input type=radio name=Web value=0>None</td>"
         +  "</tr>"
         + "<tr><td class='Prompt3'>Catalog:</td>"
           + "<td class='Prompt'><input type=checkbox name=Cat value=1>Spring'06"
           + "<input type=checkbox name=Cat value=2>Fall'06<br>"
           + "<input type=checkbox name=Cat value=3>Spring'07"
           + "<input type=checkbox name=Cat value=4>Fall'07</td>"
         +  "</tr>"
         + "<tr><td class='Prompt'>Manufacturer:</td>"
           + "<td class='Prompt' colspan='2'><input name=Mnf class='Small' value='" + mnf.innerHTML + "' size=25 maxlength=25>" + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Model:</td>"
           + "<td class='Prompt' colspan='2' ><input name=Model class='Small' value='" + model.innerHTML + "' size=15 maxlength=15>"
           + "<br>Year: <input name=MdlYear class='Small' value='" + mdlyear.innerHTML + "' size=4 maxlength=4>"
           + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Gender:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<select name=Gender class='Small'>"
              + "<option value='M'>Mens</option>"
              + "<option value='W'>Womens</option>"
              + "<option value='B'>Boys</option>"
              + "<option value='G'>Girls</option>"
              + "<option value='A'>Adult</option>"
              + "<option value='Y'>Youth</option>"
              + "<option value='C'>Children</option>"
              + "<option value='I'>Infant</option>"
              + "<option value='U'>Unisex</option>"
              + "<option value='T'>Toddler Boys</option>"
              + "<option value='Z'>Toddler Girls</option>"
              + "<option value='E'>Toddler</option>"
              + "<option value='F'>Jr. Boys</option>"
              + "<option value='H'>Jr. Girls</option>"
              + "<option value=' '>No Gender</option>"
              + "</select>"
           + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Map:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name=Map class='Small' value='" + map.innerHTML + "' size=30 maxlength=25>"
           + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Map as RCI Price:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<select name=NoMap class='Small'>"
                + "<option value='Y'>Yes</option>"
                + "<option value='N'>No</option>"
              + "</select>"
           + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Map Experation Date:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name=MapDt class='Small' value='" + mapdt.innerHTML + "' size=30 maxlength=25>"
           + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt3'>Live Date:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name=Live class='Small' value='" + live.innerHTML + "' size=50 maxlength=50>"
           + "</td>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<!-- button onClick='sbmItem(" + i + ",&#34;" + cls + "&#34;,&#34;" + ven + "&#34;,&#34;" + sty
        + "&#34;,&#34;" + clr + "&#34;,&#34;" + siz + "&#34;)' "
        + "class='Small'>Submit</button -->&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//--------------------------------------------------------
//Hide selection screen
//--------------------------------------------------------
function hidePanel3()
{
	document.all.dvFlyMenu.innerHTML = " ";
	document.all.dvFlyMenu.style.visibility = "hidden";
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function sbmItem(i,cls,ven,sty,clr,siz)
{
//check if order is paid off
   var div = null; var dpt = null; var item = null; var desc = null; var categ = null; var webi = null; var webs = null;
   var cat1 = null; var cat2 = null; var cat3 = null; var cat4 = null; var clrnm = null; var siznm = null;
   var upc = null; var sku = null; var mnf = null; var model = null; var mdlyear = null; var map = null;
   var nomap = null; var mapdt = null; var gender = null; var downl= null; var live = null;

   if (NumOfItm > 1)
   {
     item = document.all.tdItem[i];
     desc = document.all.tdDesc[i];
     categ = document.all.tdCateg[i];
     webi = "";// document.all.tdWebI[i];
     webs = document.all.tdWebS[i];
     cat1 = "";// document.all.tdCat1[i];
     cat2 = "";// document.all.tdCat2[i];
     cat3 = "";// document.all.tdCat3[i];
     cat4 = "";// document.all.tdCat4[i];
     div = document.all.tdDiv[i];
     dpt = document.all.tdDpt[i];
     sku = document.all.tdSku[i];
     upc = document.all.tdUpc[i];
     clrnm = document.all.tdColor[i];
     notmclr = document.all.tdNormClr[i];
     siznm = document.all.tdSize[i];
     mnf = document.all.tdMnf[i];
     model = document.all.tdModel[i];
     mdlyear = document.all.tdMdlYear[i];
     map = document.all.tdMap[i];
     nomap = document.all.tdNoMap[i];
     mapdt = document.all.tdMapDt[i];
     gender = document.all.tdGender[i];
     downl = document.all.Down[i];
     live = document.all.tdLive[i];
   }
   else
   {
     item = document.all.tdItem;
     desc = document.all.tdDesc;
     categ = document.all.tdCateg;
     webi = "";// document.all.tdWebI;
     webs = document.all.tdWebS;
     cat1 = "";// document.all.tdCat1;
     cat2 = "";// document.all.tdCat2;
     cat3 = "";// document.all.tdCat3;
     cat4 = "";// document.all.tdCat4;
     div = document.all.tdDiv;
     dpt = document.all.tdDpt;
     sku = document.all.tdSku;
     upc = document.all.tdUpc;
     clrnm = document.all.tdColor;
     normclr = document.all.tdNormClr;
     siznm = document.all.tdSize;
     mnf = document.all.tdMnf;
     model = document.all.tdModel;
     mdlyear = document.all.tdMdlYear;
     map = document.all.tdMap;
     nomap = document.all.tdNoMap;
     mapdt = document.all.tdMapDt;
     gender = document.all.tdGender;
     downl = document.all.Down;
     live = document.all.tdLive;
   }

   desc.innerHTML = document.all.Desc.value;
   categ.innerHTML = document.all.Categ.value;
   clrnm.innerHTML = document.all.ClrNm.value;
   siznm.innerHTML = document.all.SizNm.value;
   mnf.innerHTML = document.all.Mnf.value;
   model.innerHTML = document.all.Model.value;
   mdlyear.innerHTML = document.all.MdlYear.value;
   gender.innerHTML = document.all.Gender.options[document.all.Gender.selectedIndex].value;
   map.innerHTML = document.all.Map.value;
   no.innerHTML = document.all.NoMap.options[document.all.NoMap.selectedIndex].value;
   mapdt.innerHTML = document.all.MapDt.value;
   live.innerHTML = document.all.Live.value;
   if(downl != null) downl.checked = true;

   if (document.all.Web[0].checked) webi.innerHTML = "Y";
   else webi.innerHTML == "";
   if (webs.checked) webs.innerHTML = "Y";
   else webs.innerHTML == "";

   if (document.all.Cat[0].checked) { cat1.innerHTML = "Y"; }
   else { cat1.innerHTML = ""; }
   if (document.all.Cat[1].checked) cat2.innerHTML = "Y";
   else cat2.innerHTML = "";
   if (document.all.Cat[2].checked) cat3.innerHTML = "Y";
   else cat3.innerHTML = "";
   if (document.all.Cat[3].checked) cat4.innerHTML = "Y";
   else cat4.innerHTML = "";

   var url = "MozuItmSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty + "&Clr=" + clr + "&Siz=" + siz
           + "&Desc=" + document.all.Desc.value
           + "&Categ=" + document.all.Categ.value
           + "&ClrName=" + document.all.ClrNm.value
           + "&SizName=" + document.all.SizNm.value
           + "&Mnf=" + document.all.Mnf.value
           + "&Model=" + document.all.Model.value
           + "&MdlYear=" + document.all.MdlYear.value
           + "&Gender=" + document.all.Gender.options[document.all.Gender.selectedIndex].value
           + "&Map=" + document.all.Map.value
           + "&NoMap=" + document.all.NoMap.value
           + "&MapDt=" + document.all.MapDt.value
           + "&Live=" + document.all.Live.value

   if (document.all.Web[0].checked) url += "&Web=1"
   else if (document.all.Web[1].checked) url += "&Web=2"
   else url += "&Web=0"

   if (document.all.Cat[0].checked) { url += "&Cat=1"; } else { url += "&Cat=0"; }
   if (document.all.Cat[1].checked) { url += "&Cat=1"; } else { url += "&Cat=0"; }
   if (document.all.Cat[2].checked) { url += "&Cat=1"; } else { url += "&Cat=0"; }
   if (document.all.Cat[3].checked) { url += "&Cat=1"; } else { url += "&Cat=0"; }
   url += "&Cat=0";

   url += "&Action=UPD";

   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url

   hidePanel();
}
//==============================================================================
// mark attribute on Item Header
//==============================================================================
function markItem(i,cls,ven,sty,clr,siz, fld)
{
   var webi = null, webs = null, cat1 = null, cat2 = null, cat3 = null, cat4 = null,
       allsite=null, sas=null, schlo = null, sstp=null, rebel = null, rack = null, jojo = null, taxfree = null;
   // allowed not in download mode
   if (document.all.tdWebS[i] != null)
   {
     webi = "";// document.all.tdWebI[i];
     webs = document.all.tdWebS[i];
     cat1 = "";// document.all.tdCat1[i];
     cat2 = "";// document.all.tdCat2[i];
     cat3 = "";// document.all.tdCat3[i];
     cat4 = "";// document.all.tdCat4[i];
     allsite = ""; //allsite = document.all.tdAllSites[i];
     sas = document.all.tdSaS[i];
     schlo = "";//document.all.tdSkiChlt[i];
     sstp = "";// document.all.tdSStp[i];
     rebel = "";// document.all.tdRebel[i];
     rack = "";// document.all.tdRack[i];
     jojo = "";// document.all.tdJoJo[i];
     taxfree = document.all.tdTaxFree[i];
   }
   else
   {
     webi = "";// document.all.tdWebI;
     webs = document.all.tdWebS;
     cat1 = "";// document.all.tdCat1;
     cat2 = "";// document.all.tdCat2;
     cat3 = "";// document.all.tdCat3;
     cat4 = "";// document.all.tdCat4;
     allsite = "";// document.all.tdAllSites;
     sas = document.all.tdSaS;
     schlo = "";// document.all.tdSkiChlt;
     sstp = "";// document.all.tdSStp;
     rebel = "";// document.all.tdRebel;
     rack = "";// document.all.tdRack;
     jojo = "";// document.all.tdJoJo;
     taxfree = document.all.tdTaxFree;
   }

   var web = 0;
   var cat = [0,0,0,0]
   var web = 0;
   var sasval = ' ';
   var schlval = ' ';
   var sstpval = ' ';
   var rebelval = ' ';
   var rackval = ' ';
   var jojoval = ' ';
   var taxfreeval = ' ';

   if (cat1.innerHTML == "Y") cat[0] = "1";
   if (cat2.innerHTML == "Y") cat[1] = "1";
   if (cat3.innerHTML == "Y") cat[2] = "1";
   if (cat4.innerHTML == "Y") cat[3] = "1";

   if (fld == "WEBI") { if (webi.innerHTML != 'Y') { webi.innerHTML = "Y"; webs.innerHTML = "&nbsp;"; web = 1; } else webi.innerHTML = "&nbsp;"; }
   else if (fld == "WEBS") { if (webs.innerHTML != 'Y') { webi.innerHTML = "&nbsp;"; webs.innerHTML = "Y"; web = 3;} else webs.innerHTML = "&nbsp;";}
   else if (fld == "CAT1") { if (cat1.innerHTML != 'Y') { cat1.innerHTML = "Y"; cat[0] = 1 } else { cat1.innerHTML = "&nbsp;"; cat[0] = 0;}}
   else if (fld == "CAT2") { if (cat2.innerHTML != 'Y') { cat2.innerHTML = "Y"; cat[1] = 1;} else { cat2.innerHTML = "&nbsp;"; cat[1] = 0;}}
   else if (fld == "CAT3") { if (cat3.innerHTML != 'Y') { cat3.innerHTML = "Y"; cat[2] = 1;} else { cat3.innerHTML = "&nbsp;"; cat[2] = 0;}}
   else if (fld == "CAT4") { if (cat4.innerHTML != 'Y') { cat4.innerHTML = "Y"; cat[3] = 1;} else { cat4.innerHTML = "&nbsp;"; cat[3] = 0;}}
   else if (fld == "SAS") { if (sas.innerHTML != 'Y') { sas.innerHTML = "Y"; sasval = 'Y';} else { sas.innerHTML = "&nbsp;"; sasval = '%20'; }}
   else if (fld == "SCHO") { if (schlo.innerHTML != 'Y') { schlo.innerHTML = "Y"; schlval = 'Y';} else { schlo.innerHTML = "&nbsp;"; schlval = '%20'; }}
   else if (fld == "SSTP") { if (sstp.innerHTML != 'Y') { sstp.innerHTML = "Y"; sstpval = 'Y';} else { sstp.innerHTML = "&nbsp;"; sstpval = '%20'; }}
   else if (fld == "REBEL") { if (rebel.innerHTML != 'Y') { rebel.innerHTML = "Y"; rebelval='Y'} else { rebel.innerHTML = "&nbsp;"; rebelval="%20"}}
   else if (fld == "RACK") { if (rack.innerHTML != 'Y') { rack.innerHTML = "Y"; rackval='Y'} else { rack.innerHTML = "&nbsp;"; rackval="%20"}}
   else if (fld == "JOJO") { if (jojo.innerHTML != 'Y') { jojo.innerHTML = "Y"; jojoval='Y'} else { jojo.innerHTML = "&nbsp;"; jojoval="%20"}}
   else if (fld == "TAXFREE") { if (taxfree.innerHTML != 'Y') { taxfree.innerHTML = "Y"; taxfreeval='Y'} else { taxfree.innerHTML = "&nbsp;"; taxfreeval="%20"}}
   else if (fld == "ALLSITES") { if (allsite.innerHTML != 'Y') { sas.innerHTML = "Y"; schlo.innerHTML = 'Y'; sstp.innerHTML = "Y"; rebel.innerHTML = "Y"; rack.innerHTML = "Y"; jojo.innerHTML = "Y"; sasval='Y'; schlval='Y'; sstpval='Y'; rebelval='Y'; rackval='Y'; jojoval='Y'}}

   var url = "MozuItmSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty + "&Clr=" + clr + "&Siz=" + siz

   if (fld.substring(0, 3) == "WEB") url += "&Web=" + web + "&Action=UPDWEB";
   if (fld.substring(0, 3) == "CAT") url += "&Cat=" + cat[0] + "&Cat=" + cat[1]  + "&Cat=" + cat[2]  + "&Cat=" + cat[3]
                                          + "&Action=UPDCAT";
   if (fld == "SAS") url += "&SaS=" + sasval + "&Action=UPDSAS";
   if (fld == "SCHO") url += "&SChO=" + schlval + "&Action=UPDSCHO";
   if (fld == "SSTP") url += "&SStp=" + sstpval + "&Action=UPDSSTP";
   if (fld == "REBEL") url += "&Rebel=" + rebelval + "&Action=UPDREBEL";
   if (fld == "RACK") url += "&Rack=" + rackval + "&Action=UPDRACK";
   if (fld == "JOJO") url += "&JoJo=" + jojoval + "&Action=UPDJOJO";
   if (fld == "TAXFREE") url += "&TaxFree=" + taxfreeval + "&Action=UPDTAXFREE";
   if (fld == "ALLSITES") url += "&SaS=Y&SChO=Y&SStp=Y&Rebel=Y&Rack=Y&JoJo=Y&Action=UPDALLSITE";

   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// validate item downloaded
//==============================================================================
function vldDownl(i,dcls,dven,dsty,dclr,dsiz)
{
   var error = false;
   var msg = "";
   
   var clr = null;
   var siz = null;
   var nclr = null;
   var mnf = null;
   var gnd = null;
   var web = null;
   
   if (NumOfItm > 1)
   {
      clr = document.all.tdColor[i].innerHTML;   
      nclr = document.all.tdNormClr[i].innerHTML; 
      siz = document.all.tdSize[i].innerHTML; 
      mnf = document.all.tdMnf[i].innerHTML;
      gnd = document.all.tdGender[i].innerHTML;
      web = document.all.tdWebN[i].innerHTML;
   }   
   else
   {
	   clr = document.all.tdColor.innerHTML;   
	   nclr = document.all.tdNormClr.innerHTML; 
	   siz = document.all.tdSize.innerHTML; 
	   mnf = document.all.tdMnf.innerHTML;
	   gnd = document.all.tdGender.innerHTML;
	   web = document.all.tdWebN.innerHTML;
   }
   
   if(clr == ""){ error = true; msg += "\nPlease add Color."; }
   if(nclr == ""){ error = true; msg += "\nPlease add Normalized Color."; }
   if(siz == ""){ error = true; msg += "\nPlease add Size."; }
   if(mnf == ""){ error = true; msg += "\nPlease add Manufacutrer."; }
   if(gnd == ""){ error = true; msg += "\nPlease add Gender."; }
   if(web != "2"){ error = true; msg += "\nWeb Id must be equal 2."; }
   
   if(error){ alert(msg); }
   else { sbmDownl(i,dcls,dven,dsty,dclr,dsiz); }
}
//==============================================================================
// send item to mozu
//==============================================================================
function sbmDownl(i,cls,ven,sty,clr,siz)
{
  // allowed not in download mode
   var url = "MozuItmSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty + "&Clr=" + clr + "&Siz=" + siz
   url += "&Action=DWNLADD&Line=" + i
     + "&User=" + User;
   
   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// set down load link to gerren as it was clicked
//==============================================================================
function setDownBtn(i)
{
	if (NumOfItm > 1)
	{
		document.all.tdDownL[i].style.backgroundColor="lightgreen"
	}
	else
	{
		document.all.tdDownL.style.backgroundColor="lightgreen"
	}
}
//==============================================================================
// update selected colimn cells
//==============================================================================
function colUpdate()
{
	// hide flying menu
	   hidePanel3();
	
   // exit if there are no selection made
   if(SelCol==null) { alert("There is no selected column."); return}

   var colnm = null
   var size = 0;

   //check if order is paid off
   var hdr = "Update Column: ";
   if(SelCol=="DESC") { colnm = "Item Description"; size=50; }
   else if(SelCol=="CATEG") { colnm = "Category"; size=50}
   else if(SelCol=="CLRNM") { colnm = "Color Name"; size=50 }
   else if(SelCol=="NORMCLR") { colnm = "Normalized Color"; size=30 }
   else if(SelCol=="SIZNM") { colnm = "Size Name"; size=50 }
   else if(SelCol=="MNF") { colnm = "Manufacturer Name"; size=50 }
   else if(SelCol=="MODEL") { colnm = "Model Name"; size=15  }
   else if(SelCol=="MDLYR") { colnm = "Model Year"; size=4}
   else if(SelCol=="GENDER") { colnm = "Gender"; size=50 }
   else if(SelCol=="MAP") { colnm = "Map"; size=10}
   else if(SelCol=="NOMAP") { colnm = "NoMap"; size=1}
   else if(SelCol=="MAPDT") { colnm = "Map Expiration Date"; size=10}
   else if(SelCol=="LIVE") { colnm = "Live Date"; size=10}
   else if(SelCol=="PRDTY") { colnm = "Product Type"; size=50 }
   hdr += colnm;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   //if(SelCol =="GENDER") html += "<tr><td class='Prompt' colspan=2>" + popGenderPanel(SelCol, colnm)
   if(SelCol =="NOMAP") html += "<tr><td class='Prompt' colspan=2>" + popNoMapPanel(SelCol, colnm)
   else html += "<tr><td class='Prompt' colspan=2>" + popColPanel(SelCol, colnm, size)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
   
   if(SelValue == null){ SelValue = "";}
   document.all.Col.value = SelValue;
   document.all.Col.focus();

   if(SelCol=="MNF"){ getMnfAlias();}
   if(SelCol=="CLRNM")
   {
	   rtvAttrLst("tenant~color");
	   document.all.Col.readOnly = true;	   
   }
   
   if(SelCol=="NORMCLR"){ rtvAttrLst("tenant~normalized-color"); document.all.Col.readOnly = true; }   
   if(SelCol=="SIZNM"){ rtvAttrLst("tenant~size"); document.all.Col.readOnly = true;}
   if(SelCol=="MNF") { rtvAttrLst("tenant~brand"); document.all.Col.readOnly = true; }
   if(SelCol=="GENDER"){ rtvAttrLst("tenant~gender"); document.all.Col.readOnly = true; }
   if(SelCol=="PRDTY"){ rtvProdType(); document.all.Col.readOnly = true; }

   if(SelCol!="DESC")
   {
   		showExistOptProg();   
   		progressIntFunc = setInterval(function() {showExistOptProg() }, 1000);
   }
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showExistOptProg()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:10px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvOptSel.innerHTML = html;
	document.all.dvOptSel.style.height = "20px";
	document.all.dvOptSel.style.display = "block";
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popColPanel(col, colnm, size)
{  
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>" + colnm + "</td>"
           + "<td class='Prompt' colspan='2'>"

  if(col == "LIVE")
  {
     var date = null;
     if(SelValue.trim()=="")
     {
        date = new Date()
        SelValue = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
     }
     else {date = new Date(SelValue.trim())}
     var mon = date.getMonth();
     var year = date.getFullYear();

     panel += "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;Col&#34;)'>&#60;</button>"
           + "<input class='Small' name='Col' type='text' value='ALL' size=10 maxlength=10>&nbsp;"
           + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;Col&#34;)'>&#62;</button>&nbsp;&nbsp;&nbsp;"
           + "<a href='javascript:showCalendar(1," + mon + "," + year + ", document.documentElement.scrollLeft + 300, document.documentElement.scrollTop + 220, document.all.Col)' >"
           + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a><br>"
  }
  else
  {
     panel += "<input name='Col' class='Small' size=" + size + " maxlength=" + size + ">"
  }

  if(SelCol=="MNF")
  {
     panel += "<br>Save Manufacturers Name "
         + "<input type='checkbox' name='SavMnf' class='Small' value='Y'></tr></td>"
         + "<tr><td class='Prompt1' colspan='3'><div id='dvMnfAlias'>Alias (none)</div>"
  }

  panel += "</td>" + "</tr>"
  
  if(col=="CLRNM" || col=="SIZNM" || col=="MNF" || col=="GENDER" || col=="NORMCLR" || col=="PRDTY")
  {
	  panel += "<tr><td class='Prompt3' nowrap>Select Mozu Options:</td>"
      	+ "<td class='Prompt' colspan='2'>"
      	+ "<div id='dvOptSel' class='dvOptSel'></div>"
      panel += "</td>" + "</tr>"
      if(col != "PRDTY" && col != "NORMCLR")
      {
    	  panel += "<tr><td class='Prompt2'colspan=2>"
         	+ "<button class='Small' onclick='crtNewOption(&#34;" + col + "&#34;,&#34;" 
            + colnm + "&#34;)'>Create New Options</button>" 
         	+ "</td></tr>"
      }
  }

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmColumn(&#34;" + col + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
//show otpion selection list
//==============================================================================
function showProdType(type, id)
{
	OptionSel = type;
	clearInterval( progressIntFunc );
			
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	  + "<tr><td nowrap>"   
	  	  + "<input name='FndOpt' class='Small' size=50 maxlength=50>&nbsp;"  	
		  + "<button onclick='findSelOpt(true, &#34;" + type + "&#34;)' class='Small'>Find</button>&nbsp; &nbsp; "
	  	  + "<button onclick='findSelOpt(false, &#34;" + type + "&#34;)' class='Small'>All</button><br>"
	    + "</td></tr>"
	  + "</table>"

	html += "<div id='dvInt' class='dvInternal'></div>"
		
	document.all.dvOptSel.innerHTML = html;
	document.all.dvOptSel.style.display = "block";
		
	document.all.dvInt.innerHTML =  loadSelPanel(type);
}
//==============================================================================
//show otpion selection list
//==============================================================================
function showAttr(attr, opts, optnms, prodty, ptid)
{	
	if(attr != "tenant~color" && attr != "tenant~size"){OptionSel = opts;}
	else { OptionSel = optnms; }
	clearInterval( progressIntFunc );
		
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	  + "<tr><td nowrap>"   
	    + "<input name='FndOpt' class='Small' size=50 maxlength=50>&nbsp;"  	
  	    + "<button onclick='findSelOpt(true, &#34;" + attr + "&#34;)' class='Small'>Find</button>&nbsp; &nbsp; "
  	    + "<button onclick='findSelOpt(false, &#34;" + attr + "&#34;)' class='Small'>All</button><br>"
  	  + "</td></tr>"
	+ "</table>"

	html += "<div id='dvInt' class='dvInternal'></div>"
	
	document.all.dvOptSel.innerHTML = html;
	document.all.dvOptSel.style.display = "block";
	
	document.all.dvInt.innerHTML =  loadSelPanel(opts, optnms, attr);
	
	if(attr == "tenant~color" && document.all.Col.value.trim() == ""){ setPreSelIpOpt(attr); }
	else if(attr == "tenant~size" && document.all.Col.value.trim() == ""){ setPreSelIpOpt(attr); }
	
	SelProdType = prodty;
	SelProdTypeId = ptid;
}
//==============================================================================
//find selected option
//==============================================================================
function loadSelPanel(opts, optnms, attr)
{
	var panel = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	for(var i=0; i < opts.length; i++)
	{
  		panel += "<tr id='trOptSel" + i + "'>"
  	 	if(attr != "tenant~color" && attr != "tenant~size")
  	 	{	
  			panel += "<td style='cursor:default;' onclick='javascript: showOptSel(&#34;" + findOptArg(opts[i]) + "&#34;)'>" + opts[i].showSpecChar() + "</td>"
  	 	}
  		else 
  		{
  			panel += "<td style='cursor:default;' onclick='javascript: showOptSel(&#34;" + findOptArg(optnms[i]) + "&#34;)'>" + optnms[i].showSpecChar() + "</td>"
  		}
  		panel += "</tr>";
	}
	panel += "</table></div>"
	
	return panel;
}
//==============================================================================
//load option argument
//==============================================================================
function setPreSelIpOpt(attr)
{	
	var found = false;
	var len = SelIpOptId.length;
	SelIpOptId = SelIpOptId.toLowerCase();
	
	var words = SelIpOptId.split(" "); 
	
	
	if(attr == "tenant~size" && SelIpOptId.indexOf("1/2") >= 0)
	{
		SelIpOptId = SelIpOptId.replace("1/2", "").trim();
		SelIpOptId += ".5";
	}
	 
	for(var i=0; i < OptionSel.length; i++)
	{
		if(OptionSel[i].toLowerCase() == SelIpOptId)
		{ 
			document.all.Col.value = OptionSel[i]; 
			document.all.FndOpt.value = OptionSel[i];
			
			var trnm = "trOptSel" + i
			var tr = document.getElementById(trnm);
			tr.scrollIntoView();
			found = true;
			break;
		}
	}
}
//==============================================================================
// load option argument
//==============================================================================
function findOptArg(search)
{
	var arg = 0;
	for(var i=0; i < OptionSel.length; i++)
	{
		if(OptionSel[i] == search){ arg = i; break;}
	}
	
	return arg;
}
//==============================================================================
//find selected option
//==============================================================================
function findSelOpt(search, attr)
{	
	if(!search){ document.all.FndOpt.value = ""; }
	
	var opt = document.all.FndOpt.value.trim().toUpperCase();
	var fnd = false;
	var opts = new Array();
	
	LastOpt = opt;
	
	if(opt != "")
	{  
		for(var i=0; i < OptionSel.length; i++)
		{
  			if(attr != "tenant~color" && OptionSel[i].toUpperCase().indexOf(opt) >= 0
  			   || attr == "tenant~color" && OptionSel[i].toUpperCase().indexOf(opt) == 0	) 
  			{ 
  				fnd = true;
  				opts[opts.length] = OptionSel[i];
  			}
		}

		// if found set value and scroll div to the found record
		if(fnd)
		{
  			//var pos = document.all.trOptSel[LastTr].offsetTop;
  			//document.all.trOptSel[LastTr].style.color="red";
  			//dvInt.scrollTop=pos;
		}
	}
	else
	{
		opts = OptionSel;
	}
	
	document.all.dvInt.innerHTML =  loadSelPanel(opts);
}
//==============================================================================
//show selected Department Selected
//==============================================================================
function showOptSel(opt)
{	
	document.all.Col.value = OptionSel[opt];
}
//--------------------------------------------------------
// get manufacterers Aliases
//--------------------------------------------------------
function getMnfAlias()
{
   var ven = 0;
   // search for first selected item and retreive a vendor number
   for(var i=0, j=0; i < NumOfItm; i++)
   {
      if(SelCell[i] != null && SelCell[i])
      {
        if (NumOfItm > 1)
        {
           ven = document.all.tdItem[i].innerHTML.substring(5, 10);
           break;
        }
        else
        {
           ven = document.all.tdItem.innerHTML.substring(5, 10);
        }
      }
   }

   var url = "EComVendorAlias.jsp?Ven=" + ven + "&Action=LIST";
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//--------------------------------------------------------
// populate manufacterers Aliases
//--------------------------------------------------------
function popMnfAlias(Ven, VenName)
{
    var dummy = "<table>"

    var panel = "<b>Vendor Alias</b>";
    if(VenName != null && VenName.length > 0)
    {
       panel += "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
       for(var i=0; i < VenName.length; i++)
       {
          panel += "<tr><td class='Prompt3' nowrap>"
            + "<a href='javascript: setVenAlias(&#34;"
                + VenName[i].replaceSpecChar() + "&#34;)'>" + VenName[i]
            + "</a>"
            + "<td class='Prompt3'><button class='Small' onclick='dltVenAlias(&#34;"
            + Ven + "&#34;, &#34;" + VenName[i].replaceSpecChar() + "&#34;)'>x</button>"
       }
       panel += "</table>";
       document.all.dvMnfAlias.innerHTML = panel;
    }
}
//--------------------------------------------------------
// set selected vendor name alias
//--------------------------------------------------------
function setVenAlias(vennm)
{
   document.all.Col.value=vennm;
}
//--------------------------------------------------------
// delete Vendor Alias
//--------------------------------------------------------
function dltVenAlias(ven, venname)
{
   var url = "EComVendorAlias.jsp?Ven=" + ven + "&VenName=" + venname + "&Action=DELETE";
   //window.location.href=url
   window.frame1.location.href=url
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popGenderPanel(col, colnm)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>" + colnm + "</td>"
           + "<td class='Prompt' colspan='2'>"
             + "<select name=Col class='Small'>"
               + "<option value='M'>Mens</option>"
               + "<option value='W'>Womens</option>"
               + "<option value='B'>Boys</option>"
               + "<option value='G'>Girls</option>"
               + "<option value='A'>Adult</option>"
               + "<option value='Y'>Youth</option>"
               + "<option value='C'>Children</option>"
               + "<option value='I'>Infant</option>"
               + "<option value='U'>Unisex</option>"
               + "<option value='T'>Toddler Boys</option>"
               + "<option value='Z'>Toddler Girls</option>"
               + "<option value='E'>Toddler</option>"
              + "<option value='F'>Jr. Boys</option>"
              + "<option value='H'>Jr. Girls</option>"
               + "<option value=' '>No Gender</option>"
             + "</select>"
           + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmColumn(&#34;" + col + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// populate No Map Column Panel
//--------------------------------------------------------
function popNoMapPanel(col, colnm)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>" + colnm + "</td>"
           + "<td class='Prompt' colspan='2'>"
             + "<select name=Col class='Small'>"
               + "<option value='Y'>Yes</option>"
               + "<option value='N'>No</option>"
             + "</select>"
           + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmColumn(&#34;" + col + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
//retreive attribute list
//==============================================================================
function rtvAttrLst(attr)
{
	var parent = "NONE";
	if(attr != "tenant~brand" && attr != "tenant~gender" && attr != "tenant~normalized-color")
	{
		
		for(var i=0, j=0; i < NumOfItm; i++)
		{
			if(SelCell[i] != null && SelCell[i])
	    	{
	    		if (NumOfItm > 1)
	        	{	
	    			parent = document.all.tdItem[i].innerHTML.substring(0, 15);
	    			break;
	        	}
	    		else
	    		{
	    			parent = document.all.tdItem.innerHTML.substring(0, 15);
	    			break;
	    		}
	    	}
		}
	}
		
	var url = "MozuAttrList.jsp?Parent=" + parent
	  + "&Attr=" + attr
	  + "&Site=<%=sSite%>"
	;
	window.frame1.location.href = url;
}

//==============================================================================
// retreive product types
//==============================================================================
function rtvProdType()
{
	var url = "MozuProdTypeList.jsp?Site=<%=sSite%>";
	window.frame1.location.href = url;
}

//==============================================================================
//set selected options
//==============================================================================
function crtNewOption(col, colnm)
{
	   var hdr = "Add New ";
	   
	   
	   if(col=="CLRNM"){ hdr += "Color"; }
	   else if(col=="NORMCLR"){ hdr += "Normailized Color"; }
	   else if(col=="SIZNM"){ hdr += "Size"; }
	   else if(col=="MNF"){ hdr += "Manufacturer"; }
	   
	   hdr += " in Mozu database";

	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>" + popNewOptionPanel(col, colnm)
	   
	   html += "</td></tr></table>"

	   document.all.dvOpt.innerHTML = html;
	   document.all.dvOpt.style.width = 250;
	   document.all.dvOpt.style.pixelLeft= document.documentElement.scrollLeft + 400;
	   document.all.dvOpt.style.pixelTop= document.documentElement.scrollTop + 150;
	   document.all.dvOpt.style.visibility = "visible";
	   
	   document.all.OptNm.focus();
}

//==============================================================================
// populate new mozu option panel 
//==============================================================================
function popNewOptionPanel(col, colnm)
{  
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>" + colnm + "</td>"
      + "<td class='Prompt' colspan='2'>" 
        + "<input name='OptNm' class='Small' maxlength=50></tr></td>"  
      + "</td></tr>"; 
  panel += "<tr><td class='Error'  id='tdNewOptErr' colspan=2></td></tr>"; 
  
  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button id='btnNewOptVal' onClick='vldNewOpt(&#34;" + col + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel1();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
//populate new mozu option panel 
//==============================================================================
function vldNewOpt(col)
{
	var error = false;
	var msg = "";	
	document.all.tdNewOptErr.innerHTML = "";
	
	var optnm = document.all.OptNm.value.trim();
	if(optnm == ""){ error=true; msg = "Please enter new value"; }	
	
	if(error){ document.all.tdNewOptErr.innerHTML = msg; }
	else { sbmNewOpt(col, optnm) }
}
//==============================================================================
//populate new mozu option panel 
//==============================================================================
function sbmNewOpt(col, optnm)
{
	document.all.btnNewOptVal.disabled=true;
	
	var attr = null;
	if(col=="MNF"){ attr = "tenant~brand"; }
	else if(col=="CLRNM"){ attr = "tenant~color"; }
	else if(col=="NORMCLR"){ attr = "tenant~normalized-color"; }
	else if(col=="SIZNM"){ attr = "tenant~size"; }
	else if(col=="GENDER"){ attr = "tenant~gender"; }	
	
	url = "MozuCrtOptOrPropValue.jsp?&Attr=" + attr
		+  "&ProdType=" + SelProdType
		+  "&PtId=" + SelProdTypeId		
		+  "&OptNm=" + optnm	
	    +  "&Site=<%=sSite%>"; 
	//alert(url)
	//window.location.href = url;
	window.frame1.location.href = url;
	
	progressIntFunc = setInterval(function() {showProgress() }, 1000);
}
//==============================================================================
//show error from Mozu New Option creation  
//==============================================================================
function showProgress()
{	
	progressTime++; 
	var html = "Please wait while new attribute is loading<br>"
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
// show error from Mozu New Option creation  
//==============================================================================
function showAddOptErr(error)
{
	 alert("Error on Mozu option creation event:\n" + error)
}
//==============================================================================
// update mozu option   
//==============================================================================
function updMozuOpt(attr)
{		
	hidePanel1();
	rtvAttrLst(attr);
	
	clearInterval( progressIntFunc );
	hidePanel2();
	progressTime = 0;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel1()
{
document.all.dvOpt.innerHTML = " ";
document.all.dvOpt.style.visibility = "hidden";
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
// select column cells for updates
//==============================================================================
function selColumn(fld)
{
   for(var i=0; i < NumOfItm; i++) { selColumnCell(i, null,null,null,null,null, fld) }
   
   //populate search name 
   var found = false;
   
   if(fld=="CLRNM")
   {
	   for(var i=0; i < NumOfItm; i++)
       {
		   var tdnm = "tdPoClrNm" + i; 
		   if(document.all[tdnm].innerHTML.trim() != "")
		   {
			   SelIpOptId = document.all[tdnm].innerHTML;
			   found = true;
			   break;
		   }
	   }   
	   if(!found){  SelIpOptId = document.all.tdIpClrNm0.innerHTML; }
   }
   
   if(fld=="SIZNM"){ SelIpOptId = document.all.tdIpSizNm0.innerHTML; }
}
//==============================================================================
//set search preload color name - PO color is preferred
//==============================================================================
function setSearchClr(poclrnm,ipclrnm)
{
	if(poclrnm.trim()!=""){ SelIpOptId=poclrnm; }
	else{ SelIpOptId=ipclrnm; }
}
//==============================================================================
// select column cells for updates
//==============================================================================
function selColumnCell(i,cls,ven,sty,clr,siz, fld)
{
   var cell = null;
   var hdr = null;
   if (NumOfItm > 1)
   {
     if(fld=="DESC") { cell = document.all.tdDesc[i]; hdr = document.all.thDesc;}
     else if(fld=="CATEG") { cell = document.all.tdCateg[i]; hdr = document.all.thCateg;}
     else if(fld=="CLRNM") { cell = document.all.tdColor[i]; hdr = document.all.thColor;}
     else if(fld=="NORMCLR") { cell = document.all.tdNormClr[i]; hdr = document.all.thNormClr;}
     else if(fld=="SIZNM") {  cell = document.all.tdSize[i]; hdr = document.all.thSize}
     else if(fld=="MNF") { cell = document.all.tdMnf[i]; hdr = document.all.thMnf}
     else if(fld=="MODEL") { cell = document.all.tdModel[i]; hdr = document.all.thModel}
     else if(fld=="MDLYR") { cell = document.all.tdMdlYear[i]; hdr = document.all.thMdlYear}
     else if(fld=="GENDER") { cell = document.all.tdGender[i]; hdr = document.all.thGender}
     else if(fld=="MAP") { cell = document.all.tdMap[i]; hdr = document.all.thMap;}
     else if(fld=="NOMAP") { cell = document.all.tdNoMap[i]; hdr = document.all.thNoMap;}
     else if(fld=="MAPDT") { cell = document.all.tdMapDt[i]; hdr = document.all.thMapDt}
     else if(fld=="LIVE") { cell = document.all.tdLive[i]; hdr = document.all.thLive;}
     else if(fld=="PRDTY") {  cell = document.all.tdPrdTy[i]; hdr = document.all.thPrdTy}
  }
  else
  {
     if(fld=="DESC") { cell = document.all.tdDesc; hdr = document.all.thDesc;}
     else if(fld=="CATEG") { cell = document.all.tdCateg; hdr = document.all.thCateg;}
     else if(fld=="CLRNM") { cell = document.all.tdColor; hdr = document.all.thColor;}
     else if(fld=="NORMCLR") { cell = document.all.tdNormClr; hdr = document.all.thNormClr;}
     else if(fld=="SIZNM") {  cell = document.all.tdSize; hdr = document.all.thSize}
     else if(fld=="MNF") { cell = document.all.tdMnf; hdr = document.all.thMnf}
     else if(fld=="MODEL") { cell = document.all.tdModel; hdr = document.all.thModel}
     else if(fld=="MDLYR") { cell = document.all.tdMdlYear; hdr = document.all.thMdlYear}
     else if(fld=="GENDER") { cell = document.all.tdGender; hdr = document.all.thGender}
     else if(fld=="MAP") { cell = document.all.tdMap; hdr = document.all.thMap;}
     else if(fld=="NOMAP") { cell = document.all.tdNoMap; hdr = document.all.thNoMap;}
     else if(fld=="MAPDT") { cell = document.all.tdMapDt; hdr = document.all.thMapDt}
     else if(fld=="LIVE") { cell = document.all.tdLive; hdr = document.all.thLive}
     else if(fld=="PRDTY") {  cell = document.all.tdPrdTy; hdr = document.all.thPrdTy}
  }

   if(SelCol==null || SelCol == fld)
   {
      SelCol = fld;
      if(SelCell[i] == null || SelCell[i] == false)
      {
         cell.style.backgroundColor="cornsilk";
         SelCell[i] = true;
         hdr.style.backgroundColor="#fbb917";
         if(fld=="NOMAP" && (cell.innerHTML==" " || cell.innerHTML=="") && SelValue == null ) { SelValue = "N"; }
         else if (SelValue == null) SelValue = cell.innerHTML;
         
         showFlyMenu(cell);
      }
      else
      {
         cell.style.backgroundColor="#E7E7E7"; SelCell[i] = false;
      }
   }
}
//==============================================================================
// clear selection
//==============================================================================
function clrColSel()
{
   // do not clear, if no selection
   if(SelCol==null) return;

   var cell = null;
   var hdr = null;

   if(SelCol=="DESC") { cell = document.all.tdDesc; hdr = document.all.thDesc;}
   else if(SelCol=="CATEG") { cell = document.all.tdCateg; hdr = document.all.thCateg;}
   else if(SelCol=="CLRNM") { cell = document.all.tdColor; hdr = document.all.thColor}
   else if(SelCol=="NORMCLR") { cell = document.all.tdNormClr; hdr = document.all.thNormClr;}
   else if(SelCol=="SIZNM") { cell = document.all.tdSize; hdr = document.all.thSize}
   else if(SelCol=="MNF") { cell = document.all.tdMnf; hdr = document.all.thMnf; }
   else if(SelCol=="MODEL") { cell = document.all.tdModel; hdr = document.all.thModel;}
   else if(SelCol=="MDLYR") { cell = document.all.tdMdlYear; hdr = document.all.thMdlYear; }
   else if(SelCol=="GENDER") { cell = document.all.tdGender; hdr = document.all.thGender; }
   else if(SelCol=="MAP") { cell = document.all.tdMap; hdr = document.all.thMap; }
   else if(SelCol=="NOMAP") { cell = document.all.tdMap; hdr = document.all.thNoMap; }
   else if(SelCol=="MAPDT") { cell = document.all.tdMapDt; hdr = document.all.thMapDt; }
   else if(SelCol=="LIVE") { cell = document.all.tdLive; hdr = document.all.thLive;}
   else if(SelCol=="PRDTY") { cell = document.all.tdPrdTy; hdr = document.all.thPrdTy}

   for(var i=0; i < NumOfItm; i++)
   {
      if(NumOfItm > 1)
      {
        cell[i].style.backgroundColor="#E7E7E7";
        hdr.style.backgroundColor="#FFCC99";
        SelCell[i]=false;
      }
      else
      {
        cell.style.backgroundColor="#E7E7E7";
        hdr.style.backgroundColor="#FFCC99";
        SelCell[i]=false;
      }
   }
   SelCol = null;
   SelValue = null;
   
   hidePanel3();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function sbmColumn(col)
{
   var cls = 0;
   var ven = 0;
   var sty = 0;
   var clr = 0;
   var siz = 0;

   var savven = "N";
   if(SelCol=="MNF" && document.all.SavMnf.checked) { savven = "Y"; }

   var column = document.all.dvItem.innerHTML = document.all.Col.value;


   document.all.dvItem.innerHTML = "<MARQUEE><font size = +2>Wait while table is updating...</font></MARQUEE>";
   document.all.dvItem.style.width = 600;
   document.all.dvItem.style.height = 50;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   for(var i=0, j=0; i < NumOfItm; i++)
   {
      if(SelCell[i] != null && SelCell[i])
      {
        if (NumOfItm > 1)
        {
           if(SelCol=="DESC") document.all.tdDesc[i].innerHTML = column;
           if(SelCol=="CATEG") document.all.tdCateg[i].innerHTML = column;
           if(SelCol=="CLRNM") document.all.tdColor[i].innerHTML = column;
           if(SelCol=="NORMCLR") document.all.tdNormClr[i].innerHTML = column;
           if(SelCol=="SIZNM") document.all.tdSize[i].innerHTML = column;
           if(SelCol=="MNF") document.all.tdMnf[i].innerHTML = column;
           if(SelCol=="MODEL") document.all.tdModel[i].innerHTML = column;
           if(SelCol=="MDLYR") document.all.tdMdlYear[i].innerHTML = column;
           if(SelCol=="GENDER") document.all.tdGender[i].innerHTML = column;
           if(SelCol=="MAP") document.all.tdMap[i].innerHTML = column;
           if(SelCol=="NOMAP") document.all.tdNoMap[i].innerHTML = column;
           if(SelCol=="MAPDT") document.all.tdMapDt[i].innerHTML = column;
           if(SelCol=="LIVE") document.all.tdLive[i].innerHTML = column;
           if(SelCol=="PRDTY") document.all.tdPrdTy[i].innerHTML = column;
           // if(document.all.Down != null && document.all.Down[i] != null) document.all.Down[i].checked = true;
           cls = document.all.tdItem[i].innerHTML.substring(0, 4);
           ven = document.all.tdItem[i].innerHTML.substring(5, 10);
           sty = document.all.tdItem[i].innerHTML.substring(11, 15);
           clr = document.all.tdItem[i].innerHTML.substring(16, 19);
           siz = document.all.tdItem[i].innerHTML.substring(20);
        }
        else
        {
           if(SelCol=="DESC") document.all.tdDesc.innerHTML = column;
           if(SelCol=="CATEG") document.all.tdCateg.innerHTML = column;
           if(SelCol=="CLRNM") document.all.tdColor.innerHTML = column;
           if(SelCol=="NORMCLR") document.all.tdNormClr.innerHTML = column;
           if(SelCol=="SIZNM") document.all.tdSize.innerHTML = column;
           if(SelCol=="MNF") document.all.tdMnf.innerHTML = column;
           if(SelCol=="MODEL") document.all.tdModel.innerHTML = column;
           if(SelCol=="MDLYR") document.all.tdMdlYear.innerHTML = column;
           if(SelCol=="GENDER") document.all.tdGender.innerHTML = column;
           if(SelCol=="MAP") document.all.tdMap.innerHTML = column;
           if(SelCol=="NOMAP") document.all.tdNoMap.innerHTML = column;
           if(SelCol=="MAPDT") document.all.tdMapDt.innerHTML = column;
           if(SelCol=="LIVE") document.all.tdLive.innerHTML = column;
           if(SelCol=="PRDTY") document.all.tdPrdTy.innerHTML = column;
           // if(document.all.Down != null) document.all.Down.checked = true;
           cls = document.all.tdItem.innerHTML.substring(0, 4);
           ven = document.all.tdItem.innerHTML.substring(5, 10);
           sty = document.all.tdItem.innerHTML.substring(11, 15);
           clr = document.all.tdItem.innerHTML.substring(16, 19);
           siz = document.all.tdItem.innerHTML.substring(20);
        }

        var url = "MozuItmSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty + "&Clr=" + clr + "&Siz=" + siz
            + "&SavMNF=" + savven

        if(col=="DESC") url += "&Desc=" + column + "&Action=UPDDESC";
        else if(col=="CATEG") url += "&Categ=" + column + "&Action=UPDCATEG";
        else if(col=="CLRNM") url += "&ClrName=" + column + "&Action=UPDCLRN";
        else if(col=="NORMCLR") url += "&NormClr=" + column + "&Action=UPDNCLR";
        else if(col=="SIZNM") url += "&SizName=" + column + "&Action=UPDSIZN";
        else if(col=="MNF") url += "&Mnf=" + column + "&Action=UPDMNF";
        else if(col=="MODEL") url += "&Model=" + column + "&Action=UPDMODEL";
        else if(col=="MDLYR") url += "&MdlYear=" + column + "&Action=UPDMDLYR";
        else if(col=="GENDER") url += "&Gender=" + column + "&Action=UPDGENDER";
        else if(col=="MAP") url += "&Map=" + column + "&Action=UPDMAP";
        else if(col=="NOMAP") url += "&NoMap=" + column + "&Action=UPDNOMAP";
        else if(col=="MAPDT") url += "&MapDt=" + column + "&Action=UPDMAPDT";
        else if(col=="LIVE") url += "&Live=" + column + "&Action=UPDLIVE";
        else if(col=="PRDTY") url += "&PrdTy=" + column + "&Action=UPDPRDTY";

        SbmCmd[j++] = url;
        SbmQty = j;
      }
   }
   
   reuseFrame(); // submit all requests
   Used = true;
}
//--------------------------------------------------------
//--------------------------------------------------------
function showFlyMenu(cell)
{
	var html = "<a href='javascript: colUpdate()'>Update</a>,"
	 + "&nbsp;&nbsp;&nbsp;<a href='javascript: clrColSel()'>Clear</a>,"
	 + "&nbsp;&nbsp;&nbsp;<a href='javascript: hidePanel3()'>Close</a>"
	 
		
	var pos = getObjPosition(cell) 
	 
	document.all.dvFlyMenu.innerHTML = html;
    document.all.dvFlyMenu.style.pixelLeft= pos[0] + 70;
	document.all.dvFlyMenu.style.pixelTop= pos[1] - 10;
	document.all.dvFlyMenu.style.visibility = "visible";
}

//--------------------------------------------------------
// reuse frame
//--------------------------------------------------------
function reuseFrame()
{
   if (SbmLoop < SbmQty)
   {
      //alert(SbmCmd[SbmLoop]);
      //window.location.href=SbmCmd[SbmLoop];
      window.frame1.location.href= SbmCmd[SbmLoop];
      SbmLoop++;
   }
   else
   {
      Used = false;
      SbmCmd = new Array();
      SelCell = new Array();
      SbmLoop = 0;
      SbmQty = 0;
      hidePanel();
      clrColSel();
   }
}
//==============================================================================
// show table with different sorting
//==============================================================================
function resort(sort)
{
   var url = "MozuItmLst.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>";
   url += "&Sort=" + sort
        + "&From=<%=sFrom%>&To=<%=sTo%>&MarkDownl=<%=sSrchDownl%>"
        + "&Excel=N&Site=<%=sSite%>&Sku=&Pon="
        + "&InvAvl=<%=sInvAvl%>"
        + "&InvStr=<%=sInvStr%>"
        + "&MarkedWeb=<%=sMarkedWeb%>"
        ;

   //alert(url)
   window.location.href=url;
}
//==============================================================================
// show On-Line Description
//==============================================================================
function showOnLineDesc()
{
   var disp = "block";
   if(ShowOnLineDesc) { disp = "none"; }
   else { disp = "block"; }

   document.all.thOnLine.style.display = disp;
   if(NumOfItm > 1)
   {
      for(var i=0; i < NumOfItm; i++)
      {
         document.all.tdOnLine[i].style.display = disp;
      }
   }
   else { document.all.tdOnLine.style.display = disp; }

   ShowOnLineDesc = !ShowOnLineDesc;
}
//==============================================================================
// show switch mode to show/fold unattributed items only
//==============================================================================
function switchAttr()
{
   var show = null;
   if (!ShowUnattr){ ShowUnattr = true; show = "none"; }
   else { ShowUnattr = false; show = "block"; }

   if (NumOfItm > 1)
   {
     for(var i=0; i < NumOfItm; i++)
     {
        if( document.all.tdSaS[i].innerHTML != "Y" && document.all.tdRack[i].innerHTML != "Y"){ document.all.trItem[i].style.display = show; }
     }
   }
   else
   {
      if( document.all.tdSaS[i].innerHTML != "Y" && document.all.tdRack[i].innerHTML != "Y" ){ document.all.trItem.style.display = show; }
   }
}
//==============================================================================
// show switch mode to show/fold items on PO only
//==============================================================================
function switchPOOnly()
{
   var show = null;
   if (!ShowPOOnly){ ShowPOOnly = true; show = "none"; }
   else { ShowPOOnly = false; show = "block"; }

   if (NumOfItm > 1)
   {
     for(var i=0; i < NumOfItm; i++)
     {
        if( !OnPO[i] ){ document.all.trItem[i].style.display = show; }
     }
   }
   else
   {
      if( !OnPO[i] ){ document.all.trItem.style.display = show; }
   }
}
//==============================================================================
// show old item
//==============================================================================
function switchOldItem()
{
   var show = null;
   if (!ShowOldItem){ ShowOldItem = true; show = "none"; }
   else { ShowOldItem = false; show = "block"; }

   if (NumOfItm > 1)
   {
     for(var i=0; i < NumOfItm; i++)
     {
        if( OldItem[i] ){ document.all.trItem[i].style.display = show; }
     }
   }
   else
   {
      if( OldItem[i] ){ document.all.trItem.style.display = show; }
   }
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvOpt" class="dvOpt"></div>
<div id="dvProgBar" class="dvProgBar"></div>   
<div id="dvFlyMenu" class="dvFlyMenu"></div>

<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0  cellPadding="0" cellSpacing="0">
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Item List
        </B><br>
        <B>Retail Concepts Inc.
    </td>
  </tr>
  <TR bgColor=moccasin>
    <TD vAlign=top align=left>
        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="MozuItmLstSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: colUpdate()">Update</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: clrColSel()">Clear</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: showOnLineDesc()"><span id="spnShowDesc">On-Line Description</span></a>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: switchPOOnly()">Show/Fold Items is not on P.O.</a>
        &nbsp;&nbsp;
        <a href="javascript: switchOldItem()">Show/Fold Old Items</a>
        &nbsp;&nbsp;
        <a href="javascript: switchAttr()">Show/Fold Attributed Items Only</a>
        &nbsp;&nbsp;
        <a href="javascript: showOptCol()">Show/Fold Item Properties</a>        
    </td>
  </tr>
  <%if(iNumOfItm >= 1000){%>
     <TR bgColor=moccasin>
        <TD vAlign=top align=left>Warning. This list shows only first 1000 items.</td>
      </tr>
  <%}%>
  <TR bgColor=moccasin>
    <TD vAlign=top align=center>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <%if(bDwnLoad){%><th class="DataTable" rowspan=2>Dwn</th><%}%>
             <th class="DataTable" rowspan=2>Last<br>Download<br>Date</th>
             <th class="DataTable" rowspan=2>Div<br>#</th>
             <th class="DataTable" rowspan=2 >Dpt<br>#</th>
             <th class="DataTable" rowspan=2 ><a href="javascript: resort('ITEM');">Long SKU<br>Cls-Ven-Sty-Clr-Siz</a></th>
             <th class="DataTable" rowspan=2 >Chain<br>Retail</th>
             <th id="thPrdTy" class="DataTable" rowspan=2 >
                <a href="javascript: resort('PRDTY');">Product<br>Type</a>
                <br><br><a href="javascript: selColumn('PRDTY');">Select</a>
             </th>
             <th class="DataTable" rowspan=2 >IP Color<br>Name</th>
             <th class="DataTable" rowspan=2 >PO Color<br>Name</th>             
             <th class="DataTable" rowspan=2 >IP Size<br>Name</th>
             <th class="DataTable" rowspan=2 >IP Vendor<br>Name</th>
             <th class="DataTable" rowspan=2 >IP Vendor<br>Style</th>
             
             <th class="DataTable" rowspan=2 >Web<br>Id</th>
             <th id="thWeb" class="DataTable">Web</th>             
             <th id="thSkiChlt" class="DataTable" rowspan=2 >Sun<br>&<br>Ski</th>
             
             <th id="thColor" class="DataTable" rowspan=2 >
                <a href="javascript: resort('COLOR');">Color<br>Name</a>
                <br><br><a href="javascript: selColumn('CLRNM');">Select</a>
             </th>
             <th id="thNormClr" class="DataTable" rowspan=2 >
                <a href="javascript: resort('NORMCLR');">Normalized<br>Color</a>
                <br><br><a href="javascript: selColumn('NORMCLR');">Select</a>
             </th>
             <th id="thSize" class="DataTable" rowspan=2 >
                <a href="javascript: resort('SIZE');">Size<br>Name</a>
                <br><br><a href="javascript: selColumn('SIZNM');">Select</a>
             </th>
             
             
             <th id="thSkiChlt" class="DataTable"  >Onhands<br>Q-ty</th>
             <!-- th id="thSkiChlt" class="DataTable" colspan=2 >BSR<br>Q-ty</th -->
             <th id="thSku" class="DataTable" rowspan=2 ><a href="javascript: resort('SKU');">Short<br>SKU</a></th>
             
             <th id="thDesc" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('DESC');">Style<br>Name</a>
                <!-- br><br><a href="javascript: selColumn('DESC');">Select</a -->
             </th>
             
             <th id="thShortDs" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('SHORTDESC');">Short<br>Description</a>
                <!-- br><br><a href="javascript: selColumn('SHORTDESC');">Select</a -->   
             </th>
             
             <th id="thFullDs" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('FULLDESC');">Full<br>Description</a>
                <!-- br><br><a href="javascript: selColumn('FULLDESC');">Select</a -->
             </th>
             
             
             <th id="thCateg" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('CATEG');">Category</a>
                <!-- br><br><a href="javascript: selColumn('CATEG');">Select</a -->
             </th>
             <!-- th id="thOnLine" class="DataTable" rowspan=2 nowrap >On-line<br>Name</th -->
             <th id="thMnf" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MNF');">Manufacturer<br>Name</a>
                <br><br><a href="javascript: selColumn('MNF');">Select</a>
             </th>
             <th id="thModel" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MODEL');">Model<br>Number</a>
                <br><br><a href="javascript: selColumn('MODEL');">Select</a>
             </th>
             <th id="thMdlYear" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MDLYR');">Model<br>Year</a>
                <br><br><a href="javascript: selColumn('MDLYR');">Select</a>
             </th>
             <th id="thGender" class="DataTable" rowspan=2 >
                <a href="javascript: resort('GENDER');">Gender</a>
                <br><br><a href="javascript: selColumn('GENDER');">Select</a>
             </th>
             <th id="thMap" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MAP');">Map</a>
                <br><br><a href="javascript: selColumn('MAP');">Select</a>
             </th>
             <th id="thNoMap" class="DataTable" rowspan=2 >
                <a href="javascript: resort('NOMAP');">Map<br>as<br>RCI</a>
                <br><br><a href="javascript: selColumn('NOMAP');">Select</a>
             </th>
             <th id="thMapDt" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MAPDT');">Map Experation<br>Date</a>
                <br><br><a href="javascript: selColumn('MAPDT');">Select</a>
             </th>

             
             <th id="thLive" class="DataTable" rowspan=2 >Live <br><a href="javascript: selColumn('LIVE');">Select</a></th>
             <th id="thUpc" class="DataTable" rowspan=2 ><a href="javascript: resort('UPC');">UPC</th>
             <th id="thTaxFree"  rowspan=2 class="DataTable">Tax<br>Free</th>
         </tr>
         <tr class="DataTable">
             <!-- th class="DataTable"><a href="javascript: resort('INFO');">Inf</a></th -->
             <th class="DataTable"><a href="javascript: resort('SALES');">Sls</a></th>
             <th class="DataTable"nowrap>All<br>Str</th>             
             <%if(sInvAvl.equals("STR")){%>
                 <th class="DataTable"nowrap>Str<br><%=sInvStr%></th>
             <%}%>
             <!-- th class="DataTable"nowrap>BSR<br>1</th>
             <th class="DataTable"nowrap>BSR<br>70</th -->
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ )
         {
            itmLst.setDetail();
            String sDiv = itmLst.getDiv();
            String sDpt = itmLst.getDpt();
            String sCls = itmLst.getCls();
            String sVen = itmLst.getVen();
            String sSty = itmLst.getSty();
            String sClr = itmLst.getClr();
            String sSiz = itmLst.getSiz();
            String sSku = itmLst.getSku();
            String sUpc = itmLst.getUpc();
            String sRet = itmLst.getRet();
            String sDesc = itmLst.getDesc();
            String sMnfName = itmLst.getMnfName();
            String sModelName = itmLst.getModelName();
            String sModelYear = itmLst.getModelYear();
            String sGender = itmLst.getGender();
            String sLive = itmLst.getLive();
            String sMap = itmLst.getMap();
            String sNoMap = itmLst.getNoMap();
            String sMapExpDate = itmLst.getMapExpDate();
            String sClrName = itmLst.getClrName();
            String sSizName = itmLst.getSizName();
            String sWeb = itmLst.getWeb();
            String [] sCatalog = itmLst.getCatalog();
            String sDownload = itmLst.getDownload();

            String sLastDown = itmLst.getLastDown();
            String sCategory = itmLst.getCategory();
            String sSaS = itmLst.getSaS();
            String sSkiChalet = itmLst.getSkiChalet();
            String sSStp = itmLst.getSStp();
            String sRack = itmLst.getRack();
            String sRebel = itmLst.getRebel();
            String sJoJo = itmLst.getJoJo();
            String sWarehse1 = itmLst.getWarehse1();
            String sWarehse2 = itmLst.getWarehse2();
            String sBsr01 = itmLst.getBsr01();
            String sBsr70 = itmLst.getBsr70();
            String sTaxFree = itmLst.getTaxFree();
            String sOnPO = itmLst.getOnPO();
            String sOldItem = itmLst.getOldItem();
            String sStrOnHnd = itmLst.getStrOnHnd();
            String sIpClrNm = itmLst.getIpClrNm();
            String sIpSizNm = itmLst.getIpSizNm();
            String sIpVenNm = itmLst.getIpVenNm();
            String sIpVenSty = itmLst.getIpVenSty();
            String sPoClrNm = itmLst.getPoClrNm();
            String sProdType = itmLst.getProdType();
            String sProdTypeId = itmLst.getProdTypeId();
            String sNormClr = itmLst.getNormClr();
            String sShortDesc = itmLst.getShortDesc();
            String sFullDesc = itmLst.getFullDesc();
            
            boolean bMarkItm = sWeb.equals("2") || sWeb.equals("3");
            
            
            boolean bDownAllow = !sClrName.equals("") && !sSizName.equals("")
              && !sMnfName.equals("") && !sGender.equals("") && sWeb.equals("2");
            

            // concatanate on-line product name
            int iGender = -1;
            for (int j=0; j < sGenderLst.length; j++)
            {
               if (sGenderLst[j].equals(sGender)){ iGender = j; break;}
            }
            if (iGender == -1) { iGender = sGenderName.length-1;}
            String sOnLineDesc = sMnfName + " " + sGenderName[iGender] + " " + sDesc + " " + sCategory;
       %>
         <tr id="trItem" class="DataTable<%if(sOldItem.equals("1")){%>2<%}%>">
            <script>OnPO[OnPO.length] = <%=sOnPO.equals("1")%>;OldItem[OldItem.length] = <%=sOldItem.equals("1")%>;</script>
            <%if(bDwnLoad){%>                
                 <th class="DataTable" id="tdDownL" <%if(!bDownAllow){%>style="background:pink;"<%}%> >                   
                   <a name="Down" href="javascript: vldDownl(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>' )">M</a>
                 </th>
            <%}%>
            <td id="tdLstDwn" class="DataTable1" nowrap><%=sLastDown%></td>
            <td id="tdDiv" class="DataTable1" nowrap><%=sDiv%></td>
            <td id="tdDpt" class="DataTable02" nowrap onClick="if(!Used){ chgItem(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>') }"><%=sDpt%></td>
            <td id="tdItem" class="DataTable1" nowrap>
               <%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz %>
               <%if(sOnPO.equals("1")){%><span style="color:red;"><sup>P.O.</sup></span><%}%>
            </td>
            <td id="tdRet" class="DataTable2" nowrap>$<%=sRet%></td>
            <td id="tdPrdTy" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'PRDTY')"<%}%> class="DataTable1" nowrap><%=sProdType%></td>            
            <td class="DataTable1" id="tdIpClrNm<%=i%>" nowrap><%=sIpClrNm%></td>
            <td class="DataTable1" id="tdPoClrNm<%=i%>" nowrap><%=sPoClrNm%></td>
            <td class="DataTable1" id="tdIpSizNm<%=i%>" nowrap><%=sIpSizNm%></td>
            <td class="DataTable1" nowrap><%=sIpVenNm%></td>
            <td class="DataTable1" nowrap><%=sIpVenSty%></td>
            <td id="tdWebN" class="DataTable1" nowrap><%=sWeb%></td>
            <td id="tdWebS" <%if(bMarkAttr){%>onclick="if(!Used){ markItem(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'WEBS') }"<%}%> class="DataTable01" nowrap><%if(sWeb.equals("0")){%>N<%} else {%>Y<%}%></td>
            <td id="tdSaS" class="DataTable01" <%if(bMarkItm){%>onclick="if(!Used){ markItem(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'SAS') }"<%}%> nowrap><%=sSaS%></td>
            <td id="tdColor" <%if(bDwnLoad){%>onMouseDown="setSearchClr('<%=sPoClrNm%>','<%=sIpClrNm%>'); selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'CLRNM')"<%}%> class="DataTable1" nowrap><%=sClrName%></td>
            <td id="tdNormClr" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'NORMCLR')"<%}%> class="DataTable1" nowrap><%=sNormClr%></td>
            <td id="tdSize" <%if(bDwnLoad){%>onMouseDown="SelIpOptId='<%=sIpSizNm%>'; selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'SIZNM')"<%}%> class="DataTable1" nowrap><%=sSizName%></td>
            
            <td id="tdWhs1" class="DataTable2" nowrap><%=sWarehse1%></td>
            <!-- td id="tdWhs2" class="DataTable2" nowrap><%=sWarehse2%></td -->
            <%if(sInvAvl.equals("STR")){%>
               <td id="tdOnhand" class="DataTable2" nowrap><%=sStrOnHnd%></td>
            <%}%>
            <!-- td id="tdBsr01" class="DataTable2" nowrap><%=sBsr01%></td>
            <td id="tdBsr70" class="DataTable2" nowrap><%=sBsr70%></td-->
            <td id="tdSku" class="DataTable" nowrap><%=sSku%></td>
            <td id="tdDesc" class="DataTable1" nowrap><%=sDesc%></td>
            
            <!-- td id="tdShortDs" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'SHORTDESC')"<%}%> class="DataTable1" nowrap><%=sShortDesc%></td -->
            <!-- td id="tdFullDs" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'FULLDESC')"<%}%> class="DataTable1" nowrap><%=sFullDesc%></td -->
            <td id="tdShortDs" class="DataTable1" nowrap><%=sShortDesc%></td>
            <td id="tdFullDs" class="DataTable1" nowrap><%=sFullDesc%></td>
            
            <td id="tdCateg" class="DataTable1" nowrap><%=sCategory%></td>
            <!-- td id="tdOnLine" class="DataTable1" nowrap><%=sOnLineDesc%></td -->
            <td id="tdMnf" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'MNF')"<%}%> class="DataTable1" nowrap><%=sMnfName%></td>
            <td id="tdModel" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'MODEL')"<%}%>  class="DataTable1" nowrap><%=sModelName%></td>
            <td id="tdMdlYear" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'MDLYR')"<%}%>  class="DataTable1" nowrap><%=sModelYear%></td>
            <td id="tdGender" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'GENDER')"<%}%>  class="DataTable" nowrap><%=sGender%></td>
            <td id="tdMap" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'MAP')"<%}%>  class="DataTable2" nowrap><%=sMap%></td>
            <td id="tdNoMap" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'NOMAP')"<%}%>  class="DataTable2" nowrap><%=sNoMap%></td>
            <td id="tdMapDt" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'MAPDT')"<%}%>  class="DataTable1" nowrap><%=sMapExpDate%></td>
            
            <td id="tdLive" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'LIVE')"<%}%> class="DataTable1" nowrap><%=sLive%></td>
            <td id="tdUpc" class="DataTable" nowrap><%=sUpc%></td>
            <td id="tdTaxFree" class="DataTable01" <%if(bDwnLoad){%>onclick="if(!Used){ markItem(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>', 'TAXFREE') }"<%}%> nowrap><%=sTaxFree%></td>
          </tr>
       <%}%>
     </table>
<!-- ======================================================================= -->
<p style="text-align:left; ">
<span style="color:blue; background:pink; text-align:left; "><b><u>M</u></b></span>-This item is not ready for Mozu downloading. 
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
 
<%
   itmLst.disconnect();
   }
%>