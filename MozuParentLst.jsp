<%@ page import="mozu_com.MozuParentLst"%>
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
    String sLogSize = request.getParameter("LogSize");
    String [] sAttr = request.getParameterValues("Attr");
            
    if(sSelModelYr==null) { sSelModelYr = " "; }
    if(sSelMapExpDt==null) { sSelMapExpDt = " "; }
    
    if(sAttr==null){ sAttr = new String[]{" ", " ", " " }; }    
	
    if(sFromIP==null) { sFromIP = "ALL"; }
    if(sToIP==null) { sToIP = "ALL"; }

    String sSort = request.getParameter("Sort");
    if(sSort==null) { sSort = "ITEM"; }
    
    if(sLogSize==null) { sLogSize = "0"; }


    if(sInvAvl==null){ sInvAvl = "NONE"; }
    if(sInvStr==null){ sInvStr = "ALL"; }
    if(sMarkedWeb==null) { sMarkedWeb = "N"; }
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MozuParentLst.jsp");
}
else
{
    boolean bDwnLoad = session.getAttribute("ECOMDWNL") != null;
    boolean bMarkAttr = session.getAttribute("ECMARKATTR") != null;
    boolean bAllowSendToKibo = session.getAttribute("ECSNDATR")!=null;
    
    String sUser = session.getAttribute("USER").toString();

    MozuParentLst itmLst = new MozuParentLst(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen
       , sSite, sFrom, sTo, sFromIP, sToIP, sSrchDownl, sSelParent, sSelPon, sSelModelYr, sSelMapExpDt
       , sInvAvl, sInvStr, sMarkedWeb, sAttr, sSort, sUser);
    int iNumOfItm = itmLst.getNumOfItm();  

    String [] sGenderLst = new String[]{"M", "W", "B", "G", "A", "Y",
                                         "C", "I", "U", "T", "Z", "E", "F", "H"};
    String [] sGenderName = new String[]{"Men's", "Women's", "Boy's", "Girl's", "Adult", "Youth",
                                         "Children's", "Infant", "Unisex", "Toddler Boy's",
                                         "Toddler Girl's", "Toddler's", "Jr. Boy's", "Jr. Girl's", " "};
    if (sExcel.equals("Y")) { response.setContentType("application/vnd.ms-excel"); }
    
     // --- property list ----------
    int iNumOfProp = itmLst.getNumOfProp();  
    String [] sPropId = itmLst.getPropId();
    String [] sPropType = itmLst.getPropType();
    String [] sPropNm = itmLst.getPropNm();
    
    String sPropIdJsa = itmLst.getPropIdJsa();
    String sPropTypeJsa = itmLst.getPropTypeJsa();
    String sPropNmJsa = itmLst.getPropNmJsa();
    
    String  sAttrJsa = itmLst.cvtToJavaScriptArray( sAttr);
    
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
                       
        th.DataTable2 { background:#ccffcc;text-align:center; vertical-align:top ;font-size:10px }               

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.DataTable2 { color:white; background: grey; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1y { background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1g { background: green; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}               
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.Link1 { color:blue; text-decoration: underline; cursor:pointer; padding-top:3px; padding-bottom:3px; padding-left:3px;
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
        button.Small1 { margin:none; font-size:9px }
        
        div.dvLog { position:absolute; top: expression(this.offsetParent.scrollTop);
               left: expression(this.offsetParent.scrollLeft);
               background-attachment: scroll; border: MidnightBlue solid 1px; width:250;
               background-color:LemonChiffon; z-index:10; text-align:center; font-size:10px}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvOpt { position: absolute; visibility:hidden; background-attachment: scroll;
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
        td.BoxClose {cursor:hand;background:#a0cfec; white-space: nowrap;
               color:white; text-align:right; font-family:Arial; font-size:12px;  }
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
var Attr = [<%=sAttrJsa%>];
var PoNum = "<%=sSelPon%>";

var progressIntFunc = null;
var progressTime = 0;

var DownHistRefreshFunc = null;
var IdleTimeFunc = null;
var IdleTime = 0; 

var OptionSel = null;
var OptionNmSel = null;
var LastTr = -1;
var LastOpt = "";

var SbmDesc = new Array();
var DescArg = null;

var PropId = [<%=sPropIdJsa%>];
var PropType = [<%=sPropTypeJsa%>];
var PropNm = [<%=sPropNmJsa%>];
 
var DwnCls = null;
var DwnVen = null;
var DwnSty = null;

var ColPos = [0,0];
var LogSize = "<%=sLogSize%>";
var CategList = null;

var ProdType = new Array();
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvOpt", "dvLog"]);
        
   // get download item log 
   getDownLog();
   
   //set load to excel with Attributes
   setLoadToExcel();
}
//==============================================================================
// set load to excel with Attributes
//==============================================================================
function setLoadToExcel()
{
	str = "Load To Excel( + Attributes): <select name='selLoadType' id='selLoadType' class='Small' >";
	for(var i=0; i < ProdType.length; i++)
	{
		str += "<option value='" + ProdType[i] + "'>" + ProdType[i] + "</option>";      
	}
	str += "</select>&nbsp;&nbsp;<button onclick='crtExcelwAttr()'>Go</button>";
	document.getElementById("spnLoad").innerHTML = str;
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
   document.all.dvItem.style.left= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.top= document.documentElement.scrollTop + 100;
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
         + "<tr><td class='Prompt3'>Map Expiration Date:</td>"
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

   var url = "MozuParentSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty + "&Clr=" + clr + "&Siz=" + siz
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
           + "&Site=<%=sSite%>"

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

   var url = "MozuParentSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty + "&Clr=" 
		   + clr + "&Siz=" + siz
		   + "&Site=<%=sSite%>"

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
function vldDownl(i,dcls,dven,dsty,web)
{
   var error = false;
   var msg = "";
   
   var clr = null;
   var siz = null;
   var nclr = null;
   var mnf = null;
   var gnd = null;
   var shortds = null;
   var fullds = null;
   var categ = null;
   var webnm = null;   
   
   DwnCls = dcls;
   DwnVen = dven;
   DwnSty = dsty;
   
   if (NumOfItm > 1)
   {
      nclr = document.all.tdNormClr[i].innerHTML; 
      mnf = document.all.tdMnf[i].innerHTML;
      gnd = document.all.tdGender[i].innerHTML;
      shortds = document.all.tdShortDs[i].innerHTML;
      fullds = document.all.tdFullDs[i].innerHTML;
      webnm = document.all.tdDesc[i].innerHTML;
      categ = document.all.tdCateg[i].innerHTML;
   }   
   else
   {
	   nclr = document.all.tdNormClr.innerHTML; 
	   mnf = document.all.tdMnf.innerHTML;
	   gnd = document.all.tdGender.innerHTML;
	   shortds = document.all.tdShortDs.innerHTML;
	   fullds = document.all.tdFullDs.innerHTML;
	   webnm = document.all.tdDesc.innerHTML;
	   categ = document.all.tdCateg.innerHTML;
   }
   
   if(webnm == ""){ error = true; msg += "\nPlease add Web Name."; }
   if(nclr == ""){ error = true; msg += "\nPlease add Normalized Color."; }
   if(mnf == ""){ error = true; msg += "\nPlease add Manufacutrer."; }
   if(gnd == ""){ error = true; msg += "\nPlease add Gender."; }
   if(shortds == ""){ error = true; msg += "\nPlease add Short Description."; }
   if(fullds == ""){ error = true; msg += "\nPlease add Full Description."; }
   if(categ == ""){ error = true; msg += "\nPlease add Category."; }
   if(!web){ error = true; msg += "\nNo child marked for web."; }
   
   
   if(isClrSizExists(dcls,dven,dsty))
   {
	   error = true; msg += "\nOne or more children contains both - 'No Color', 'No Size'.";
   }

   
   if(error){ alert(msg); }
   else { sbmDownl(i,dcls,dven,dsty); }
}
//==============================================================================
// send item to mozu
//==============================================================================
function sbmDownl(i,cls,ven,sty)
{
  // allowed not in download mode
   var url = "MozuParentSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty
    + "&Action=DWNLADD&Line=" + i
    + "&User=" + User
    + "&Site=<%=sSite%>"
    ;
   
   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
//get item additional information
//==============================================================================
function isClrSizExists(cls, ven, sty)
{
	var url = "MozuCheckClrSiz.jsp?Cls=" + cls 
		+ "&Ven=" + ven
		+ "&Sty=" + sty;
	  
	var error = false;

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
			error = parseElem(resp, "Error") == "true";			
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return error;
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
	
	getDownLog();	 
}

//==============================================================================
//set down load link to gerren as it was clicked
//==============================================================================
function setUpdAttrBtn(i)
{
	if (NumOfItm > 1)
	{
		document.all.tdUpdAttr[i].style.backgroundColor="lightgreen"
	}
	else
	{
		document.all.tdUpdAttr.style.backgroundColor="lightgreen"
	}
	
	getDownLog();	 
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getDownLog()
{
	var url = "MozuDownLog.jsp?User=" + User;
	
	var item = new Array();
	var time = new Array();
	var errflg = new Array();
	var error = new Array();

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			//<Item> </Item>
  		   var  resp = xmlhttp.responseText;
  		   item = parseElemArr(resp, "Item");
  		   time = parseElemArr(resp, "Time");
  		   errflg = parseElemArr(resp, "ErrFlg");
  		   error = parseElemArr(resp, "Error");  	
  		   showHistDownLog(item, time, errflg, error); 
		}
	}
	xmlhttp.open("POST",url,false); // asynchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return item.length > 0;
}
//==============================================================================
//parse XML elements into array
//==============================================================================
function parseElemArr(resp, tag )
{
	var arr = new Array();	
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	
	while(beg >= 0)
	{
		arr[arr.length] = resp.substring(beg, end);
		resp = resp.substring(end + taglen);
		beg = resp.indexOf("<" + tag + ">") + taglen;
		end = resp.indexOf("</" + tag+ ">");
		if(arr.length > 20 || end < 0){ break; }
	}
	return arr;	
}
//==============================================================================
// show historical log of item downloading
//==============================================================================
function showHistDownLog(item, time, errflg, error)
{
	var hdr = "Your Today Downloading Log";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblLog1'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "&nbsp;</td>"
	       + "<td class='BoxClose' valign='top'>"
	       		+  "<img src='MinimizeButton.bmp' id='imgMin' onclick='javascript: setHistLog(&#34;0&#34;);' alt='Minimize'>&nbsp;"  
	       		+  "<img src='RestoreButton.bmp'  id='imgMed' onclick='javascript: setHistLog(&#34;1&#34;);' alt='Restore'>&nbsp;"
	       		+  "<img src='MaxButton.bmp'  id='imgMax' onclick='javascript: setHistLog(&#34;2&#34;);' alt='Restore'>"
	       + "</td></tr>"
	     + "</tr>"
	     + "<tr><td class='Prompt' id='tdLog' colspan='2'>"
	        + popHistDownLog(item, time, errflg, error)
	     + "</td></tr>"
	   + "</table>"

	document.all.dvLog.innerHTML = html;
	document.all.dvLog.style.visibility = "visible";
	
	setHistLog(LogSize);
	
	clearInterval( DownHistRefreshFunc );
	DownHistRefreshFunc = setInterval(function() { getDownLog() }, 1000 * 30);
}
//==============================================================================
//populate panel of historical log of items downloaded
//==============================================================================
function popHistDownLog(item, time, errflg, error)
{
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblLog2'>"
	panel += "<tr class='DataTable'><th class='DataTable2'>Item</th>"
	     + "<th class='DataTable2'>Time</th>"
	     + "<th class='DataTable2'>Err</th>"
	     + "<th class='DataTable2'>Error Log</th>"
	  + "</tr>"
   	for(var i=0; i < item.length; i++)
   	{
   		panel += "<tr class='DataTable'>"
   	     	+ "<td class='DataTable1' nowrap width='180'>" + item[i] + "</td>"
   	        + "<td class='DataTable1' nowrap width='60'>" + time[i] + "</td>"
   	     	+ "<td class='DataTable' nowrap width='20'>&nbsp;" + errflg[i] + "&nbsp;</td>"
   	    	+ "<td class='DataTable' nowrap>" + error[i] + "&nbsp;</td>"
   	  	 + "</tr>"
   	}  		
	  
	panel += "</table>";
	
	
	panel = "<div id='dvHistInt' class='dvInternal' style='height:120px'>" + panel + "</div>";
	
	var today = new Date();
	var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    var time = h + ":" + m + ":" + s; 
	
	panel += "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>";
	panel += "<tr class='DataTable1'>"	
	    	+ "<td class='DataTable'><button class='Small1' onclick='getDownLog()'>Refresh</button></td>"
	    	+ "<td class='DataTable'>Last Time Updated: " + time + "</td>"
	    + "</tr>";
	panel += "</table>";
	
	return panel;
}
//==============================================================================
// switch history box size
//==============================================================================
function setHistLog(size)
{
	if(size == "0" )
	{  
		document.all.tdLog.style.display= "none";
		document.all.imgMin.style.display= "none";
		document.all.imgMed.style.display= "inline";
		document.all.imgMax.style.display= "inline";
		document.all.dvLog.style.width = "250";	
		document.all.dvLog.style.height = "auto";
		document.all.dvHistInt.style.display= "none";
	}
	else if(size == "1")
	{  
		document.all.tdLog.style.display= "block";
		document.all.imgMin.style.display= "inline";
		document.all.imgMed.style.display= "none";
		document.all.imgMax.style.display= "inline";
		document.all.dvHistInt.style.display= "block";
		document.all.dvLog.style.width = "400";
		document.all.dvLog.style.height = "50";
		document.all.dvHistInt.style.width = "400";
		document.all.dvHistInt.style.height = "100";
	}
	else if(size == "2")
	{  
		document.all.tdLog.style.display= "block";
		document.all.imgMin.style.display= "inline";
		document.all.imgMed.style.display= "inline";
		document.all.imgMax.style.display= "none";	
		document.all.dvHistInt.style.display= "block";
		document.all.dvLog.style.width = "1000";
		document.all.dvLog.style.height = "500";
		document.all.dvHistInt.style.width = "100%";
		document.all.dvHistInt.style.height = "100%";
	}
	
	LogSize = size;
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
   if(SelCol=="WEBNM") { colnm = "Item Description"; size=250; }
   else if(SelCol=="CATEG") { colnm = "Category"; size=50}
   else if(SelCol=="EXTNM") { colnm = "Extended Name"; size=50}
   else if(SelCol=="NORMCLR") { colnm = "Normalized Color"; size=30 }
   else if(SelCol=="MNF") { colnm = "Manufacturer Name"; size=50 }
   else if(SelCol=="MODEL") { colnm = "Model Name"; size=15  }
   else if(SelCol=="MDLYR") { colnm = "Model Year"; size=4}
   else if(SelCol=="GENDER") { colnm = "MF(Gender)"; size=50 }
   else if(SelCol=="AGE") { colnm = "Age"; size=50 }
   else if(SelCol=="MAP") { colnm = "Map"; size=10}
   else if(SelCol=="NOMAP") { colnm = "NoMap"; size=1}
   else if(SelCol=="MAPDT") { colnm = "Map Expiration Date"; size=10}
   else if(SelCol=="LIVE") { colnm = "Live Date"; size=10}
   else if(SelCol=="PRDTY") { colnm = "Product Type"; size=50 }
   else if(SelCol=="SHORTDESC") { colnm = "Short Description"; size=255 }
   else if(SelCol=="FULLDESC") { colnm = "Full Description"; size=10000 }
   else if(SelCol=="WEBDS") { colnm = "Web Description"; size=75 }
   else if(SelCol=="GOOGLE") { colnm = "Meta Tag Title"; size=70 }
   else if(SelCol=="WEIGHT") { colnm = "Weight"; size=10 }
   else if(SelCol=="LENGTH") { colnm = "Length"; size=10 }
   else if(SelCol=="WIDTH") { colnm = "Width"; size=10 }
   else if(SelCol=="HEIGHT") { colnm = "Height"; size=10 }
   else if(SelCol=="TAXCAT") { colnm = "Tax Category"; size=25 }
   hdr += colnm;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   //if(SelCol =="GENDER") html += "<tr><td class='Prompt' colspan=2>" + popGenderPanel(SelCol, colnm)
   if(SelCol =="NOMAP") { html += "<tr><td class='Prompt' colspan=2>" + popNoMapPanel(SelCol, colnm) }
   else if(SelCol =="SHORTDESC" || SelCol =="FULLDESC" || SelCol =="WEBDS" 
	  || SelCol =="WEBNM" || SelCol =="GOOGLE") { html += "<tr><td class='Prompt' colspan=2>" + popDescPanel(SelCol, colnm, size) }
   else html += "<tr><td class='Prompt' colspan=2>" + popColPanel(SelCol, colnm, size)

   html += "</td></tr></table>"
   
   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 350;
   document.all.dvItem.style.left= ColPos[0];//document.documentElement.scrollLeft + 400;
   document.all.dvItem.style.top= ColPos[1];//document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
   
   if(SelValue == null){ SelValue = "";}
   if(SelCol!="GENDER" && SelCol!="AGE")
   {
		document.all.Col.value = SelValue; 
   		document.all.Col.focus();
   }

   if(SelCol=="MNF"){ getMnfAlias();}
   if(SelCol=="CLRNM")
   {
	   rtvAttrLst("tenant~color");
	   document.all.Col.readOnly = true;	   
   }
   
   if(SelCol=="NORMCLR"){ rtvAttrLst("tenant~normalized-color"); document.all.Col.readOnly = true; }   
   if(SelCol=="SIZNM"){ rtvAttrLst("tenant~size"); document.all.Col.readOnly = true;}
   if(SelCol=="MNF") { rtvAttrLst("tenant~brand"); document.all.Col.readOnly = true; }
   if(SelCol=="GENDER"){ setSelGender();}
   if(SelCol=="AGE"){ setSelAge();}
   if(SelCol=="PRDTY"){ rtvProdType(); document.all.Col.readOnly = true; }
   if(SelCol=="TAXCAT"){ rtvTaxCat(); document.all.Col.readOnly = true; }
   if(SelCol=="CATEG")	   
   {
	   document.all.btnSbmit.disabled = true; 
	   rtvCateg(); document.all.Col.readOnly = true;
   }
   
   if(SelCol=="SHORTDESC" || SelCol=="FULLDESC" || SelCol=="WEBDS" || SelCol=="WEBNM" || SelCol=="GOOGLE")
   {
	   rtvDesc();	   	   
   }
   
   if(SelCol!="WEBNM" && SelCol!="GENDER" && SelCol!="AGE" && SelCol!="MODEL"
		   && SelCol!="EXTNM" && SelCol!="WEBDS")
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
	
	if(document.all.dvOptSel != null )
	{ 
		document.all.dvOptSel.innerHTML = html;
		document.all.dvOptSel.style.height = "20px";
		document.all.dvOptSel.style.display = "block";
	}
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
  else if(col == "GENDER")
  {
	  panel += "<input type='checkbox' name='Col' class='Small' value='Female'>Female &nbsp;"
	    + " &nbsp; <input type='checkbox' name='Col' class='Small' value='Male'>Male";
  }
  else if(col == "AGE")
  {  
	  //Adult, Junior, Youth, Child, Toddler, Infant                                                        	
	  panel += "<input type='checkbox' name='Col' class='Small' value='Adult'>Adult &nbsp;"
	    + " &nbsp; <input type='checkbox' name='Col' class='Small' value='Junior'>Junior &nbsp;"
	    + " &nbsp; <input type='checkbox' name='Col' class='Small' value='Youth'>Youth &nbsp;"
	    + " &nbsp; <input type='checkbox' name='Col' class='Small' value='Child'>Child &nbsp;"
	    + " &nbsp; <input type='checkbox' name='Col' class='Small' value='Toddler'>Toddler &nbsp;"
	    + " &nbsp; <input type='checkbox' name='Col' class='Small' value='Infant'>Infant"
	    ;
  }
  else
  {
     panel += "<input name='Col' class='Small' size=" + size + " maxlength=" + size + ">";
  }
  
  if(SelCol=="CATEG")
  {
	  panel += "<input name='ColId' type='hidden'>";
	  panel += "&nbsp; Search: <input name='SearchCat' class='Small' size" + size + " maxlength=" + size + ">"
	    + "&nbsp;<button class='Small' onclick='getSearCat(true)'>Find</button>"
	    + "&nbsp;<button class='Small' onclick='getSearCat(false)'>All</button>"
	    ;
  }
           
  if(SelCol=="MNF")
  {
     panel += "<br>Save Manufacturers Name "
         + "<input type='checkbox' name='SavMnf' class='Small' value='Y'></tr></td>"
         + "<tr><td class='Prompt1' colspan='3'><div id='dvMnfAlias'>Alias (none)</div>"
  }

  panel += "</td>" + "</tr>"
  
  if( col=="MNF" || col=="NORMCLR" || col=="PRDTY" || col=="CATEG" || col=="TAXCAT")
  {
	  panel += "<tr><td class='Prompt3' nowrap>Select Mozu Options:</td>"
      	+ "<td class='Prompt' colspan='2'>"
      	+ "<div id='dvOptSel' class='dvOptSel'></div>"
      panel += "</td>" + "</tr>"
      if(col != "PRDTY" && col != "CATEG" && col != "NORMCLR" && col != "TAXCAT")
      {
    	  panel += "<tr><td class='Prompt3'colspan=2>"
         	+ "<button class='Small' onclick='crtNewOption(&#34;" + col + "&#34;,&#34;" 
            + colnm + "&#34;)'>Create New Options</button>" 
         	+ "</td></tr>"
      }
  }

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button id='btnSbmit' onClick='sbmColumn(&#34;" + col + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//--------------------------------------------------------
//populate short or Full Description Panel
//--------------------------------------------------------
function popDescPanel(col, colnm, size)
{  
	var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<tr><td class='Prompt3' nowrap>" + colnm + "</td>"
        + "<td class='Prompt'>"
        
  	panel += "<TextArea name='Col' class='Small' cols=120 rows=10></TextArea></td></tr>";
  	
  	panel += "<tr><td class='Prompt3' nowrap></td>"
      	+ "<td class='Prompt'>"
      	+ "<div id='dvOptSel' class='dvOptSel'></div></td></tr>"
	
    panel += "<tr><td class='Prompt1' colspan=2>"
     + "<button onClick='vldDesc(&#34;" + col + "&#34;, &#34;" + size + "&#34;)' class='Small'>Submit</button>&nbsp;"
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
		  + "<button onclick='findSelOpt(true)' class='Small'>Find</button>&nbsp; &nbsp; "
	  	  + "<button onclick='findSelOpt(false)' class='Small'>All</button><br>"
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
function showTaxCat(taxcat)
{
	OptionSel = taxcat;
	clearInterval( progressIntFunc );
			
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	  + "<tr><td nowrap>"   
	  	  + "<input name='FndOpt' class='Small' size=50 maxlength=50>&nbsp;"  	
		  + "<button onclick='findSelOpt(true)' class='Small'>Find</button>&nbsp; &nbsp; "
	  	  + "<button onclick='findSelOpt(false)' class='Small'>All</button><br>"
	    + "</td></tr>"
	  + "</table>"

	html += "<div id='dvInt' class='dvInternal'></div>"
		
	document.all.dvOptSel.innerHTML = html;
	document.all.dvOptSel.style.display = "block";
		
	document.all.dvInt.innerHTML =  loadSelPanel(taxcat);
}
//==============================================================================
//show otpion selection list
//==============================================================================
function showAttr(attr, opts, optnms, prodty, ptid)
{	
	if(attr != "tenant~color"){OptionSel = opts;}
	else { OptionSel = optnms; }
	clearInterval( progressIntFunc );
		
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	  + "<tr><td nowrap>"   
	    + "<input name='FndOpt' class='Small' size=50 maxlength=50>&nbsp;"  	
  	    + "<button onclick='findSelOpt(true)' class='Small'>Find</button>&nbsp; &nbsp; "
  	    + "<button onclick='findSelOpt(false)' class='Small'>All</button><br>"
  	  + "</td></tr>"
	+ "</table>"

	html += "<div id='dvInt' class='dvInternal'></div>"
	
	document.all.dvOptSel.innerHTML = html;
	document.all.dvOptSel.style.display = "block";
	
	document.all.dvInt.innerHTML =  loadSelPanel(opts, optnms, attr);
	
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
  		panel += "<tr id='trOptSel'>"  
  	 	if(attr != "tenant~color" && attr != "tenant~size")   
  	 	{	
  			if(opts[i].indexOf("'") >= 0)
  			{
  				opts[i] = removeQuotes(opts[i]);
  			}
  			if(opts[i].indexOf("'") >= 0)
  			{
  				optnms[i] = removeQuotes(optnms[i]);
  			}
  	 		panel += "<td style='cursor:default;' onclick='javascript: showOptSel(&#34;" + opts[i] + "&#34;)'>" + opts[i].showSpecChar() + "</td>"
  	 	}
  		else 
  		{
  			panel += "<td style='cursor:default;' onclick='javascript: showOptSel(&#34;" + optnms[i] + "&#34;)'>" + optnms[i].showSpecChar() + "</td>"
  		}
  		panel += "</tr>";
	}
	panel += "</table></div>"
	
	return panel;
}
//==============================================================================
//  remove Quotes
//==============================================================================
function removeQuotes(opt)
{   	
   while(opt.indexOf("'") >= 0)
   {
	  opt = opt.replace("'", "&#39;");   
   }
   return opt;
}
//==============================================================================
// set already seleted gender
//==============================================================================
function setSelGender()
{	
	if(SelValue.indexOf("Female") >= 0){  document.all.Col[0].checked = true; }
	if(SelValue.indexOf("Male") >= 0){  document.all.Col[1].checked = true; }
}
//==============================================================================
//set already seleted gender
//==============================================================================
function setSelAge()
{	
	//Adult, Junior, Youth, Child, Toddler, Infant                                                        	
	if(SelValue.indexOf("Adult") >= 0){  document.all.Col[0].checked = true; }
	if(SelValue.indexOf("Junior") >= 0){  document.all.Col[1].checked = true; }
	if(SelValue.indexOf("Youth") >= 0){  document.all.Col[2].checked = true; }
	if(SelValue.indexOf("Child") >= 0){  document.all.Col[3].checked = true; }
	if(SelValue.indexOf("Toddler") >= 0){  document.all.Col[4].checked = true; }
	if(SelValue.indexOf("Infant") >= 0){  document.all.Col[5].checked = true; }	
}
//==============================================================================
//find selected option
//==============================================================================
function findSelOpt(search)
{	
	if(!search){ document.all.FndOpt.value = ""; }
	
	var opt = document.all.FndOpt.value.trim().toUpperCase();
	opt = opt.replace(/'/g,"&#39;");
	var fnd = false;
	var opts = new Array();
	
	LastOpt = opt;
	
	if(opt != "")
	{  
		for(var i=0; i < OptionSel.length; i++)
		{	
			if(OptionSel[i].toUpperCase().indexOf(opt) >= 0) 
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
	document.all.Col.value = opt;
}

//==============================================================================
//show selected Department Selected
//==============================================================================
function showCategSel(id, code)
{
	document.all.Col.value = code;
	document.all.ColId.value = id;
	document.all.btnSbmit.disabled = false;
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
           ven = document.all.tdItem[i].innerHTML.substring(5, 11);
           break;
        }
        else
        {
           ven = document.all.tdItem.innerHTML.substring(5, 11);
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
	    			parent = document.all.tdItem[i].innerHTML.substring(0, 13);
	    			break;
	        	}
	    		else
	    		{
	    			parent = document.all.tdItem.innerHTML.substring(0, 13);
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
// retreive description
//==============================================================================
function rtvDesc()
{
	var cls = 0;
	var ven = 0;
	var type = null;
	if(SelCol=="SHORTDESC"){ type = "Short";}
	else if(SelCol=="FULLDESC"){ type = "Full"; }
	else if(SelCol=="WEBNM"){ type = "WName"; }
	else if(SelCol=="WEBDS"){ type = "WDesc"; }
	else if(SelCol=="GOOGLE"){ type = "Googl"; }
	
	for(var i=0, j=0; i < NumOfItm; i++)
	{
   		if(SelCell[i] != null && SelCell[i])
   		{
     		if (NumOfItm > 1)
     		{        		
        		cls = document.all.tdItem[i].innerHTML.substring(0, 4);
        		ven = document.all.tdItem[i].innerHTML.substring(5, 11);
        		sty = document.all.tdItem[i].innerHTML.substring(12, 19);
     		}
     		else
     		{
         		cls = document.all.tdItem.innerHTML.substring(0, 4);
        		ven = document.all.tdItem.innerHTML.substring(5, 11);
        		sty = document.all.tdItem.innerHTML.substring(12, 19);
     		}
   		}
	}
	var url = "MozuRtvWebDesc.jsp?Cls=" + cls
	  + "&Ven=" + ven
	  + "&Sty=" + sty
	  + "&Type=" + type
	;
	window.frame1.location.href = url;
}
//==============================================================================
//show web description
//==============================================================================
function showWebDesc(line)
{
	// stop wait time panel
	clearInterval( progressIntFunc );
	hidePanel2();
	progressTime = 0;
	
	document.all.dvOptSel.innerHTML = " ";
	document.all.dvOptSel.style.display = "none";
		
	var sText = "";   
	for(var i=0; i < line.length; i++ )
	{
		sText += line[i];
	}
	
	// populate only if not empty, prevent override initial setup
	if(sText.trim() != "")
	{
		document.all.Col.value = sText;
	}
}
//==============================================================================
//retreive description
//==============================================================================
function rtvCateg()
{
	var cls = 0;
	var ven = 0;
	var type = null;
	
	for(var i=0, j=0; i < NumOfItm; i++)
	{
		if(SelCell[i] != null && SelCell[i])
		{
  		if (NumOfItm > 1)
  		{        		
     		cls = document.all.tdItem[i].innerHTML.substring(0, 4);
     		ven = document.all.tdItem[i].innerHTML.substring(5, 11);
     		sty = document.all.tdItem[i].innerHTML.substring(12, 19);
  		}
  		else
  		{
      		cls = document.all.tdItem.innerHTML.substring(0, 4);
     		ven = document.all.tdItem.innerHTML.substring(5, 11);
     		sty = document.all.tdItem.innerHTML.substring(12, 19);
  		}
		}
	}
	
	var url = "MozuRtvWebCateg.jsp?Site=<%=sSite%>";
	window.frame1.location.href = url;   
}
//==============================================================================
//show web description
//==============================================================================
function showWebCateg(id, code)
{
	// stop wait time panel
	clearInterval( progressIntFunc );
	hidePanel2();
	progressTime = 0;
	
	document.all.dvOptSel.innerHTML = " ";
	document.all.dvOptSel.style.display = "none";
		
	clearInterval( progressIntFunc );
		
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	  
	html += "</table>";

	html += "<div id='dvInt' class='dvInternal' ></div>"
	
	document.all.dvOptSel.innerHTML = html;
	document.all.dvOptSel.style.display = "block";
	
	document.all.dvInt.style.width = "500";
	
	
	document.all.dvInt.innerHTML =  loadCategSelPanel(id, code);	
}
//===========================================================
//search category
//===========================================================
function getSearCat(lookup)
{
	var search = document.all.SearchCat.value.trim();
	if(search != ""){ search = search.toUpperCase(); }
	window.status = search;
	
	for(var i=0; i < CategList.length; i++)
	{		
		if(!lookup || CategList[i].toUpperCase().indexOf(search) >= 0)
		{
			var rownm = "trOptSel" + i;
			document.all[rownm].style.display = "block";
		}
		else
		{
			var rownm = "trOptSel" + i;
			document.all[rownm].style.display = "none";
		}
	}
}
//==============================================================================
//find selected option
//==============================================================================
function loadCategSelPanel(id, code)
{
	var panel = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	for(var i=0; i < id.length; i++)
	{
		code[i] = code[i].replace(/\'/g, "&#39;");
		panel += "<tr id='trOptSel" + i + "'>"
		panel += "<td style='cursor:default;' onclick='javascript: showCategSel(&#34;" + id[i] + "&#34;, &#34;" + code[i] + "&#34;)' nowrap>" 
			    + code[i] + "</td>"
		panel += "</tr>";
	}
	panel += "</table></div>"
	
	CategList = code;
	
	return panel;
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
//retreive tax category list
//==============================================================================
function rtvTaxCat()
{
	var url = "MozuTaxCatList.jsp?Site=<%=sSite%>";
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
	   document.all.dvOpt.style.left= document.documentElement.scrollLeft + 400;
	   document.all.dvOpt.style.top= document.documentElement.scrollTop + 150;
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
	else if(col=="NORMCLR"){ attr = "tenant~normalized-color"; }
	else if(col=="GENDER"){ attr = "tenant~gender"; }	
	
	url = "MozuCrtOptOrPropValue.jsp?&Attr=" + attr
	if(attr == "tenant~brand")
	{	
		url +=  "&ProdType=Base&PtId=1";
	}	
	else 
	{
		url +=  "&ProdType=" + SelProdType +  "&PtId=" + SelProdTypeId;
	}
	url	+=  "&OptNm=" + optnm +  "&Site=<%=sSite%>";	
	
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
	document.all.dvProgBar.style.left= document.documentElement.scrollLeft + 400;
	document.all.dvProgBar.style.top= document.documentElement.scrollTop + 300;
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
document.all.dvProgBar.innerHTML = "xxx";
document.all.dvProgBar.style.visibility = "hidden";
}
//==============================================================================
// select column cells for updates
//==============================================================================
function selColumn(fld)
{
   for(var i=0; i < NumOfItm; i++) { selColumnCell(i, null,null,null, fld) }
}

//==============================================================================
// select column cells for updates
//==============================================================================
function selColumnCell(i,cls,ven,sty, fld)
{
   var cell = null;
   var hdr = null;
   
   if (NumOfItm > 1)
   {
     if(fld=="WEBNM") { cell = document.all.tdDesc[i]; hdr = document.all.thDesc;}
     else if(fld=="CATEG") { cell = document.all.tdCateg[i]; hdr = document.all.thCateg;}
     else if(fld=="EXTNM") { cell = document.all.tdExtNm[i]; hdr = document.all.thExtNm;}
     else if(fld=="NORMCLR") { cell = document.all.tdNormClr[i]; hdr = document.all.thNormClr;}
     else if(fld=="MNF") { cell = document.all.tdMnf[i]; hdr = document.all.thMnf}
     else if(fld=="MODEL") { cell = document.all.tdModel[i]; hdr = document.all.thModel}
     else if(fld=="MDLYR") { cell = document.all.tdMdlYear[i]; hdr = document.all.thMdlYear}
     else if(fld=="GENDER") { cell = document.all.tdGender[i]; hdr = document.all.thGender}
     else if(fld=="AGE") { cell = document.all.tdAge[i]; hdr = document.all.thAge}
     else if(fld=="MAP") { cell = document.all.tdMap[i]; hdr = document.all.thMap;}
     else if(fld=="NOMAP") { cell = document.all.tdNoMap[i]; hdr = document.all.thNoMap;}
     else if(fld=="MAPDT") { cell = document.all.tdMapDt[i]; hdr = document.all.thMapDt}
     else if(fld=="LIVE") { cell = document.all.tdLive[i]; hdr = document.all.thLive;}
     else if(fld=="PRDTY") {  cell = document.all.tdPrdTy[i]; hdr = document.all.thPrdTy}
     else if(fld=="SHORTDESC") {  cell = document.all.tdShortDs[i]; hdr = document.all.thShortDs}
     else if(fld=="FULLDESC") {  cell = document.all.tdFullDs[i]; hdr = document.all.thFullDs}
     else if(fld=="WEBDS"){ cell = document.all.tdWebDs[i]; hdr = document.all.thWebDs; }
     else if(fld=="GOOGLE"){ cell = document.all.tdGoogle[i]; hdr = document.all.thGoogle; }
     else if(fld=="WEIGHT"){ cell = document.all.tdWgt[i]; hdr = document.all.thWgt; }
     else if(fld=="LENGTH"){ cell = document.all.tdLen[i]; hdr = document.all.thLen; }
     else if(fld=="WIDTH"){ cell = document.all.tdWdt[i]; hdr = document.all.thWdt; }
     else if(fld=="HEIGHT"){ cell = document.all.tdHgt[i]; hdr = document.all.thHgt; }
     else if(fld=="TAXCAT"){ cell = document.all.tdTaxCat[i]; hdr = document.all.thTaxCat; }
  }
  else
  {
     if(fld=="WEBNM") { cell = document.all.tdDesc; hdr = document.all.thDesc;}
     else if(fld=="CATEG") { cell = document.all.tdCateg; hdr = document.all.thCateg;}
     else if(fld=="EXTNM") { cell = document.all.tdExtNm; hdr = document.all.thExtNm;}
     else if(fld=="NORMCLR") { cell = document.all.tdNormClr; hdr = document.all.thNormClr;}
     else if(fld=="MNF") { cell = document.all.tdMnf; hdr = document.all.thMnf}
     else if(fld=="MODEL") { cell = document.all.tdModel; hdr = document.all.thModel}
     else if(fld=="MDLYR") { cell = document.all.tdMdlYear; hdr = document.all.thMdlYear}
     else if(fld=="GENDER") { cell = document.all.tdGender; hdr = document.all.thGender}
     else if(fld=="AGE") { cell = document.all.tdAge; hdr = document.all.thAge}
     else if(fld=="MAP") { cell = document.all.tdMap; hdr = document.all.thMap;}
     else if(fld=="NOMAP") { cell = document.all.tdNoMap; hdr = document.all.thNoMap;}
     else if(fld=="MAPDT") { cell = document.all.tdMapDt; hdr = document.all.thMapDt}
     else if(fld=="LIVE") { cell = document.all.tdLive; hdr = document.all.thLive}
     else if(fld=="PRDTY") {  cell = document.all.tdPrdTy; hdr = document.all.thPrdTy}
     else if(fld=="SHORTDESC") {  cell = document.all.tdShortDs; hdr = document.all.thShortDs}
     else if(fld=="FULLDESC") {  cell = document.all.tdFullDs; hdr = document.all.thFullDs}
     else if(fld=="WEBDS") { cell = document.all.tdWebDs; hdr = document.all.thWebDs; }
     else if(fld=="GOOGLE") { cell = document.all.tdGoogle; hdr = document.all.thGoogle; }
     else if(fld=="WEIGHT"){ cell = document.all.tdWgt; hdr = document.all.thWgt; }
     else if(fld=="LENGTH"){ cell = document.all.tdLen; hdr = document.all.thLen; }
     else if(fld=="WIDTH"){ cell = document.all.tdWdt; hdr = document.all.thWdt; }
     else if(fld=="HEIGHT"){ cell = document.all.tdHgt; hdr = document.all.thHgt; }
     else if(fld=="TAXCAT"){ cell = document.all.tdTaxCat; hdr = document.all.thTaxCat; }
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
         else if(fld=="WEBNM" && cell.innerHTML=="") { SelValue = setWebName(i); }
         else if(fld=="MODEL" && cell.innerHTML=="") { SelValue = setModelNum(i); }
         else if(fld=="WEBDS" && cell.innerHTML=="") { SelValue = setWebDesc(i); }
         else if(fld=="GOOGLE" && cell.innerHTML=="") { SelValue = setMetaTag(i); }
         else if (SelValue == null) { SelValue = cell.innerHTML; }
         
         showFlyMenu(cell);
      }
      else
      {
         cell.style.backgroundColor="#E7E7E7"; SelCell[i] = false;
      }
   }
}
//==============================================================================
//set extended name
//==============================================================================
function setModelNum(i)
{
	var model ="";
	if (NumOfItm > 1) { model += document.all.tdIpVst[i].innerHTML.trim(); }
	else { model += document.all.tdIpVst.innerHTML.trim();}
	
	model = ucFirstAllWords( model );
	return model;
}
//==============================================================================
//set web description
//==============================================================================
function setWebDesc(i)
{
	var wdesc ="";
	if (NumOfItm > 1) { wdesc += document.all.tdIpDesc[i].innerHTML.trim(); }
	else { wdesc += document.all.tdIpDesc.innerHTML.trim();}
	
	wdesc = ucFirstAllWords( wdesc );
	return wdesc;
}
//==============================================================================
//clear selection
//==============================================================================
function setWebName(i)
{
	var desc ="";
	if (NumOfItm > 1)
	{
		desc += document.all.tdMnf[i].innerHTML.trim();
		var genage = getAgeGenCombination(document.all.tdGender[i].innerHTML.trim(), document.all.tdAge[i].innerHTML.trim());
		if(genage.trim() != "")
		{
			desc += " " + genage; 
		}
		desc += " " + document.all.tdWebDs[i].innerHTML.trim();
		desc += " " + document.all.tdExtNm[i].innerHTML.trim();		
		if(document.all.tdDiv[i].innerHTML.trim() == "020" || document.all.tdDiv[i].innerHTML.trim() == "021"
		|| document.all.tdDiv[i].innerHTML.trim() == "085" || document.all.tdDiv[i].innerHTML.trim() == "088")
		{	
			var modyr = document.all.tdMdlYear[i].innerHTML.trim();
			if(modyr.length >= 4){ modyr = modyr.substring(2,4); }
			desc += " '" + modyr;
		}		
	}  
	else 
	{
		desc += document.all.tdMnf.innerHTML.trim(); 
		var genage = getAgeGenCombination(document.all.tdGender.innerHTML.trim(), document.all.tdAge.innerHTML.trim()); 
		if(genage.trim() != "")
		{
			desc += " " + genage;
		}
		
		desc += " " + document.all.tdWebDs.innerHTML.trim();
		desc += " " + document.all.tdExtNm.innerHTML.trim();
		if(document.all.tdDiv.innerHTML.trim() == "020" || document.all.tdDiv.innerHTML.trim() == "021"
		|| document.all.tdDiv.innerHTML.trim() == "085" || document.all.tdDiv.innerHTML.trim() == "088")
		{
			var modyr = document.all.tdMdlYear.innerHTML.trim();		
			if(modyr.length >= 4){ modyr = modyr.substring(2,4); }
			desc += " '" + modyr;
		}
	}	
	
	desc = ucFirstAllWords( desc );
	return desc;
}
//==============================================================================
//set web description
//==============================================================================
function setMetaTag(i)
{
	var meta ="";
	if (NumOfItm > 1) { meta = document.all.tdDesc[i].innerHTML.trim(); }
	else { meta = document.all.tdDesc.innerHTML.trim(); }
	
	if(meta == "")
	{
		if (NumOfItm > 1) { meta = document.all.tdIpDesc[i].innerHTML.trim(); }
		else { meta = document.all.tdIpDesc.innerHTML.trim(); }
	}
	
	meta = ucFirstAllWords( meta );
	return meta;
}
//==============================================================================
// capitalized first letter of each words
//==============================================================================
function ucFirstAllWords( str )
{    
	var pieces = str.split(" ");
    for ( var i = 0; i < pieces.length; i++ )
    {
        var j = pieces[i].charAt(0).toUpperCase();
        pieces[i] = j + pieces[i].substr(1);
    }
    return pieces.join(" ");
}
//==============================================================================
// get combination of age and gender
//==============================================================================
function getAgeGenCombination( gen, age)
{
	var combo = "";
	
	var agen = gen.split(",");
	var aage = age.split(",");
	
	var multgen = agen.length > 1;
	var numgen = agen.length;
	
	var multage = aage.length > 1;
	var numgen = aage.length;
	
	//men's
	if(!multgen && !multage && agen[0] == "Male" && aage == "Adult")       { combo = "Men's";  }
	else if(!multgen && !multage && agen[0] == "Male" && aage == "Junior") { combo = "Boy's";  }
	else if(!multgen && !multage && agen[0] == "Male" && aage == "Youth")  { combo = "Boy's";  }
	else if(!multgen && !multage && agen[0] == "Male" && aage == "Child")  { combo = "Boy's";  }
	else if(!multgen && !multage && agen[0] == "Male" && aage == "Toddler"){ combo = "Toddler Boy's";  }
	else if(!multgen && !multage && agen[0] == "Male" && aage == "Infant") { combo = "Infant";  }
	// women's
	else if(!multgen && !multage && agen[0] == "Female" && aage == "Adult")  { combo = "Women's";  }
	else if(!multgen && !multage && agen[0] == "Female" && aage == "Junior") { combo = "Junior Girl's";  }
	else if(!multgen && !multage && agen[0] == "Female" && aage == "Youth")  { combo = "Girl's";  }
	else if(!multgen && !multage && agen[0] == "Female" && aage == "Child")  { combo = "Girl's";  }
	else if(!multgen && !multage && agen[0] == "Female" && aage == "Toddler"){ combo = "Toddler Girl's";  }
	else if(!multgen && !multage && agen[0] == "Female" && aage == "Infant") { combo = "Infant";  }
	
	// unisex	
	else if(multgen && aage == "Adult")  { combo = "";  }
	else if(multgen && aage == "Junior")  { combo = "";  }
	else if(multgen && aage == "Youth")  { combo = "Kids'";  }
	else if(multgen && aage == "Child")  { combo = "Kids'";  }
	else if(multgen && aage == "Toddler")  { combo = "Kids'";  }
	else if(multgen && aage == "Infant")  { combo = "Kids'";  }
	
	    
	return combo;
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

   if(SelCol=="WEBNM") { cell = document.all.tdDesc; hdr = document.all.thDesc;}
   else if(SelCol=="CATEG") { cell = document.all.tdCateg; hdr = document.all.thCateg;}
   else if(SelCol=="EXTNM") { cell = document.all.tdExtNm; hdr = document.all.thExtNm;}
   else if(SelCol=="NORMCLR") { cell = document.all.tdNormClr; hdr = document.all.thNormClr;}
   else if(SelCol=="MNF") { cell = document.all.tdMnf; hdr = document.all.thMnf; }
   else if(SelCol=="MODEL") { cell = document.all.tdModel; hdr = document.all.thModel;}
   else if(SelCol=="MDLYR") { cell = document.all.tdMdlYear; hdr = document.all.thMdlYear; }
   else if(SelCol=="GENDER") { cell = document.all.tdGender; hdr = document.all.thGender; }
   else if(SelCol=="AGE") { cell = document.all.tdAge; hdr = document.all.thAge; }
   else if(SelCol=="MAP") { cell = document.all.tdMap; hdr = document.all.thMap; }
   else if(SelCol=="NOMAP") { cell = document.all.tdMap; hdr = document.all.thNoMap; }
   else if(SelCol=="MAPDT") { cell = document.all.tdMapDt; hdr = document.all.thMapDt; }
   else if(SelCol=="LIVE") { cell = document.all.tdLive; hdr = document.all.thLive;}
   else if(SelCol=="PRDTY") { cell = document.all.tdPrdTy; hdr = document.all.thPrdTy}
   else if(SelCol=="SHORTDESC") { cell = document.all.tdShortDs; hdr = document.all.thShortDs}
   else if(SelCol=="FULLDESC") { cell = document.all.tdFullDs; hdr = document.all.thFullDs}
   else if(SelCol=="WEBDS") { cell = document.all.tdWebDs; hdr = document.all.thWebDs;}
   else if(SelCol=="GOOGLE") { cell = document.all.tdGoogle; hdr = document.all.thGoogle;}   
   else if(SelCol=="WEIGHT") { cell = document.all.tdWgt; hdr = document.all.thWgt;}
   else if(SelCol=="LENGTH") { cell = document.all.tdLen; hdr = document.all.thLen;}
   else if(SelCol=="WIDTH") { cell = document.all.tdWdt; hdr = document.all.thWdt;}
   else if(SelCol=="HEIGHT") { cell = document.all.tdHgt; hdr = document.all.thHgt;}
   else if(SelCol=="TAXCAT") { cell = document.all.tdTaxCat; hdr = document.all.thTaxCat;}

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
   
   var column = "";
   var sbmval = "";
   
   if(SelCol=="GENDER") { column = showSelGen( ); }
   else if(SelCol=="AGE") { column = showSelAge( ); }
   else if(SelCol=="CATEG") { column = document.all.Col.value; sbmval = document.all.ColId.value; }
   else { column = document.all.dvItem.innerHTML = document.all.Col.value; }
   
   document.all.dvItem.innerHTML = "<MARQUEE><font size = +2>Wait while table is updating...</font></MARQUEE>";
   document.all.dvItem.style.width = 600;
   document.all.dvItem.style.height = 50;
   document.all.dvItem.style.left= document.documentElement.scrollLeft + 100;
   document.all.dvItem.style.top= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   for(var i=0, j=0; i < NumOfItm; i++)
   {
      if(SelCell[i] != null && SelCell[i])
      {
        if (NumOfItm > 1)
        {
           if(SelCol=="WEBNM") document.all.tdDesc[i].innerHTML = column;
           if(SelCol=="CATEG") { document.all.tdCateg[i].innerHTML = column; }
           if(SelCol=="EXTNM") { document.all.tdExtNm[i].innerHTML = column; }
           if(SelCol=="NORMCLR") document.all.tdNormClr[i].innerHTML = column;
           if(SelCol=="MNF") document.all.tdMnf[i].innerHTML = column;
           if(SelCol=="MODEL") document.all.tdModel[i].innerHTML = column;
           if(SelCol=="MDLYR") document.all.tdMdlYear[i].innerHTML = column;
           if(SelCol=="GENDER") { document.all.tdGender[i].innerHTML = column; }
           if(SelCol=="AGE") { document.all.tdAge[i].innerHTML = column; }
           if(SelCol=="MAP") document.all.tdMap[i].innerHTML = column;
           if(SelCol=="NOMAP") document.all.tdNoMap[i].innerHTML = column;
           if(SelCol=="MAPDT") document.all.tdMapDt[i].innerHTML = column;
           if(SelCol=="LIVE") document.all.tdLive[i].innerHTML = column;
           if(SelCol=="PRDTY") document.all.tdPrdTy[i].innerHTML = column;
           if(SelCol=="WEBDS") { document.all.tdWebDs[i].innerHTML = column; }
           if(SelCol=="WEIGHT") { document.all.tdWgt[i].innerHTML = column; }
           if(SelCol=="LENGTH") { document.all.tdLen[i].innerHTML = column; }
           if(SelCol=="WIDTH") { document.all.tdWdt[i].innerHTML = column; }
           if(SelCol=="HEIGHT") { document.all.tdHgt[i].innerHTML = column; }
           if(SelCol=="TAXCAT") { document.all.tdTaxCat[i].innerHTML = column; }
           
           var testItem = document.all.tdItem[i].innerHTML;
           cls = document.all.tdItem[i].innerHTML.substring(0, 4);
           ven = document.all.tdItem[i].innerHTML.substring(5, 11);
           sty = document.all.tdItem[i].innerHTML.substring(12, 19);
        }
        else
        {
           if(SelCol=="WEBNM") document.all.tdDesc.innerHTML = column;
           if(SelCol=="CATEG") document.all.tdCateg.innerHTML = column;
           if(SelCol=="EXTNM") document.all.tdExtNm.innerHTML = column;
           if(SelCol=="NORMCLR") document.all.tdNormClr.innerHTML = column;
           if(SelCol=="MNF") document.all.tdMnf.innerHTML = column;
           if(SelCol=="MODEL") document.all.tdModel.innerHTML = column;
           if(SelCol=="MDLYR") document.all.tdMdlYear.innerHTML = column;
           if(SelCol=="GENDER") { document.all.tdGender.innerHTML = column; }
           if(SelCol=="AGE") { document.all.tdAge.innerHTML = column; }
           if(SelCol=="MAP") document.all.tdMap.innerHTML = column;
           if(SelCol=="NOMAP") document.all.tdNoMap.innerHTML = column;
           if(SelCol=="MAPDT") document.all.tdMapDt.innerHTML = column;
           if(SelCol=="LIVE") document.all.tdLive.innerHTML = column;
           if(SelCol=="PRDTY") document.all.tdPrdTy.innerHTML = column;      
           if(SelCol=="WEBDS") { document.all.tdWebDs.innerHTML = column; }
           if(SelCol=="WEIGHT") { document.all.tdWgt.innerHTML = column; }
           if(SelCol=="LENGTH") { document.all.tdLen.innerHTML = column; }
           if(SelCol=="WIDTH") { document.all.tdWdt.innerHTML = column; }
           if(SelCol=="HEIGHT") { document.all.tdHgt.innerHTML = column; }
           if(SelCol=="TAXCAT") { document.all.tdTaxCat.innerHTML = column; }           
           // if(document.all.Down != null) document.all.Down.checked = true;
             
           cls = document.all.tdItem.innerHTML.substring(0, 4);
           ven = document.all.tdItem.innerHTML.substring(5, 11);
           sty = document.all.tdItem.innerHTML.substring(12,19);
        }

        var url = "MozuParentSave.jsp?Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty
            + "&SavMNF=" + savven 
            + "&Site=<%=sSite%>"

        if(col=="WEBNM") url += "&Desc=" + column + "&Action=UPDWEBNM";
        else if(col=="CATEG") { url += "&Categ=" + sbmval + "&Action=UPDCATEG"; }
        else if(col=="EXTNM") { url += "&ExtNm=" + column + "&Action=UPDEXTNM"; }
        else if(col=="NORMCLR") url += "&NormClr=" + column + "&Action=UPDNCLR";
        else if(col=="MNF") url += "&Mnf=" + column + "&Action=UPDMNF";
        else if(col=="MODEL") url += "&Model=" + column + "&Action=UPDMODEL";
        else if(col=="MDLYR") url += "&MdlYear=" + column + "&Action=UPDMDLYR";
        else if(col=="GENDER") url += "&Gender=" + column + "&Action=UPDGENDER";
        else if(col=="AGE") url += "&Gender=" + column + "&Action=UPDAGE";
        else if(col=="MAP") url += "&Map=" + column + "&Action=UPDMAP";
        else if(col=="NOMAP") url += "&NoMap=" + column + "&Action=UPDNOMAP";
        else if(col=="MAPDT") url += "&MapDt=" + column + "&Action=UPDMAPDT";
        else if(col=="LIVE") url += "&Live=" + column + "&Action=UPDLIVE";
        else if(col=="PRDTY") url += "&PrdTy=" + column + "&Action=UPDPRDTY";
        else if(col=="WEIGHT") url += "&Wgt=" + column + "&Action=UPDWGT";
        else if(col=="LENGTH") url += "&Len=" + column + "&Action=UPDLEN";
        else if(col=="WIDTH") url += "&Wdt=" + column + "&Action=UPDWDT";
        else if(col=="HEIGHT") url += "&Hgt=" + column + "&Action=UPDHGT";    
        else if(col=="TAXCAT") url += "&TaxCat=" + column + "&Action=UPDTAXCAT";
            
        
        SbmCmd[j++] = url;
        SbmQty = j;
      }
   }
   
   reuseFrame(); // submit all requests
   Used = true;
}
//--------------------------------------------------------
//show selected gender on mai table
//--------------------------------------------------------
function showSelGen( col, cell )
{
	var html ="";
	var coma = "";
	if( document.all.Col[0].checked ){ html += document.all.Col[0].value.trim(); coma = ",";}
	if( document.all.Col[1].checked ){ html += coma + document.all.Col[1].value.trim(); coma = ",";}
	return html;
}
//--------------------------------------------------------
// show selected gender on mai table
//--------------------------------------------------------
function showSelAge( col, cell )
{
	var html ="";
	var coma = "";
	if( document.all.Col[0].checked ){ html += document.all.Col[0].value.trim(); coma = ",";}
	if( document.all.Col[1].checked ){ html += coma + document.all.Col[1].value.trim(); coma = ",";}
	if( document.all.Col[2].checked ){ html += coma + document.all.Col[2].value.trim(); coma = ",";}
	if( document.all.Col[3].checked ){ html += coma + document.all.Col[3].value.trim(); coma = ",";}
	if( document.all.Col[4].checked ){ html += coma + document.all.Col[4].value.trim(); coma = ",";}
	if( document.all.Col[5].checked ){ html += coma + document.all.Col[5].value.trim(); coma = ",";}
	
	return html;
}
//--------------------------------------------------------
// validate description
//--------------------------------------------------------
function vldDesc(col, size)
{
	var action = null;
	var error=false;
	var msg = "";
	
	if(col=="SHORTDESC") { action = "UPDSHORTDS"; }
	else if(col=="FULLDESC"){ action = "UPDFULLDS"; }
	else if(col=="WEBDS"){ action = "UPDWEBDS"; }
	else if(col=="WEBNM"){ action = "UPDWEBNM"; }
	else if(col=="GOOGLE"){ action = "UPDGOOGLE"; }

	var text = document.all.Col.value.trim();
	//if(text==""){ error=true; msg+="\nPlease enter description"; }
	if(text.length > size ){ error=true; msg+="\nDescription is too long"; }
	
	var sel = 0;
	for(var i=0, j=0; i < NumOfItm; i++)
	{
   		if(SelCell[i] != null && SelCell[i]){ sel++ }
	}		
	
	if(error){ alert(msg); }
	else { sbmDesc(col, text, action, sel); }
}
//--------------------------------------------------------
//Hide selection screen
//--------------------------------------------------------
function sbmDesc(col, text, action, sel)
{
	var cls = 0;
	var ven = 0;
	var sty = 0;
	var clr = 0;
	var siz = 0;
	var last = false;
	SbmQty = 0;
	
	document.all.dvItem.innerHTML = "<MARQUEE><font size = +2>Wait while table is updating...</font></MARQUEE>";
	document.all.dvItem.style.width = 600;
	document.all.dvItem.style.height = 50;
	document.all.dvItem.style.left= document.documentElement.scrollLeft + 100;
	document.all.dvItem.style.top= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";

	for(var i=0, j=0; i < NumOfItm; i++)
	{
   		if(SelCell[i] != null && SelCell[i])
   		{
     		if (NumOfItm > 1)
     		{     			
		        cls = document.all.tdItem[i].innerHTML.substring(0, 4);
        		ven = document.all.tdItem[i].innerHTML.substring(5, 11);
        		sty = document.all.tdItem[i].innerHTML.substring(12, 19);
        		
        		if(col=="SHORTDESC") 
        		{ 
        			document.all.tdShortDs[i].innerHTML=text;
        			document.all.tdShortDs[i].style.backgroundColor="#E7E7E7";
        			document.all.thShortDs.style.backgroundColor="#FFCC99";        		    
        		}
        		else if(col=="FULLDESC")
        		{
        			document.all.tdFullDs[i].innerHTML=text;
        			document.all.tdFullDs[i].innerHTML=text;
        			document.all.tdFullDs[i].style.backgroundColor="#E7E7E7";
        			document.all.thFullDs.style.backgroundColor="#FFCC99";
        		}
        		else if(col=="WEBDS")
        		{
        			document.all.tdWebDs[i].innerHTML=text;
        			document.all.tdWebDs[i].innerHTML=text;
        			document.all.tdWebDs[i].style.backgroundColor="#E7E7E7";
        			document.all.thWebDs.style.backgroundColor="#FFCC99";
        		}
        		else if(col=="WEBNM")
        		{
        			document.all.tdDesc[i].innerHTML=text;
        			document.all.tdDesc[i].innerHTML=text;
        			document.all.tdDesc[i].style.backgroundColor="#E7E7E7";
        			document.all.thDesc.style.backgroundColor="#FFCC99";
        		}
        		else if(col=="GOOGLE")
        		{
        			document.all.tdGoogle[i].innerHTML=text;
        			document.all.tdGoogle[i].innerHTML=text;
        			document.all.tdGoogle[i].style.backgroundColor="#E7E7E7";
        			document.all.thGoogle.style.backgroundColor="#FFCC99";
        		}
     		}
     		else
     		{
        		cls = document.all.tdItem.innerHTML.substring(0, 4);
                ven = document.all.tdItem.innerHTML.substring(5, 11);
                sty = document.all.tdItem.innerHTML.substring(12,19);
        		
        		if(col=="SHORTDESC") 
        		{ 
        			document.all.tdShortDs.innerHTML=text;
        			document.all.tdShortDs.style.backgroundColor="#E7E7E7";
        			document.all.thShortDs.style.backgroundColor="#FFCC99";        		    
        		}
        		else if(col=="FULLDESC")
        		{
        			document.all.tdFullDs.innerHTML=text;
        			document.all.tdFullDs.innerHTML=text;
        			document.all.tdFullDs.style.backgroundColor="#E7E7E7";
        			document.all.thFullDs.style.backgroundColor="#FFCC99";
        		}
        		else if(col=="WEBDS")
        		{
        			document.all.tdWebDs.innerHTML=text;
        			document.all.tdWebDs.innerHTML=text;
        			document.all.tdWebDs.style.backgroundColor="#E7E7E7";
        			document.all.thWebDs.style.backgroundColor="#FFCC99";
        		}
        		else if(col=="WEBNM")
        		{
        			document.all.tdDesc.innerHTML=text;
        			document.all.tdDesc.innerHTML=text;
        			document.all.tdDesc.style.backgroundColor="#E7E7E7";
        			document.all.tdDesc.style.backgroundColor="#FFCC99";
        		}
        		else if(col=="GOOGLE")
        		{
        			document.all.tdGoogle.innerHTML=text;
        			document.all.tdGoogle.innerHTML=text;
        			document.all.tdGoogle.style.backgroundColor="#E7E7E7";
        			document.all.thGoogle.style.backgroundColor="#FFCC99";
        		}
     		}
     		
     		if(j == sel){ last = true; } 
     		//sbmDescItem(cls, ven, sty, text, action, last);
     		DescArg = { cls:cls, ven:ven, sty:sty, text:text, action:action, last:last };
     		SbmDesc[SbmDesc.length] = DescArg;
     		SbmQty++;
     		j++;
   		}
	}	
	
	sbmDescItem();
	Used = true;
}
//=================================================================================
//show Flying Menu
//=================================================================================
function sbmDescItem()
{	
	if (SbmLoop < SbmQty)
	{
		var nwelem = window.frame1.document.createElement("div");
    	nwelem.id = "dvSbmDesc"

    	var html = "<form name='frmAddDesc'"
       	+ " METHOD=Post ACTION='MozuParentSave.jsp'>"
       	+ "<input class='Small' name='Site'>"
       	+ "<input class='Small' name='Cls'>"
       	+ "<input class='Small' name='Ven'>"
       	+ "<input class='Small' name='Sty'>"
       	+ "<input class='Small' name='Last'>"
       	+ "<textarea class='Small' name='Desc'></textarea>"
       	+ "<input class='Small' name='Action'>"       
     	+ "</form>"

   		nwelem.innerHTML = html;
     
   		frmcommt = document.all.frmEmail;
   		window.frame1.document.appendChild(nwelem);
   		
   		DescArg = SbmDesc[SbmLoop];

   		window.frame1.document.all.Cls.value="<%=sSite%>";
   		window.frame1.document.all.Cls.value=DescArg.cls;
   		window.frame1.document.all.Ven.value=DescArg.ven;
   		window.frame1.document.all.Sty.value=DescArg.sty;
   		window.frame1.document.all.Desc.value=DescArg.text;
   		window.frame1.document.all.Action.value=DescArg.action;
   		window.frame1.document.all.Last.value=DescArg.last;

   		window.frame1.document.frmAddDesc.submit();
   		
   		SbmLoop++;
	}
	else
	{
	   Used = false;
	   SbmCmd = new Array();
	   SelCell = new Array();
	   clrColSel()
	   SbmLoop = 0;
	   SbmQty = 0;
	   SbmDesc = new Array();
	   hidePanel();	    
	}	
}
//=================================================================================
// show Flying Menu
//=================================================================================
function showFlyMenu(cell)
{
	var html = "<a href='javascript: colUpdate()'>Update</a>,"
	 + "&nbsp;&nbsp;&nbsp;<a href='javascript: clrColSel()'>Clear</a>,"
	 + "&nbsp;&nbsp;&nbsp;<a href='javascript: hidePanel3()'>Close</a>"
	 
		
	var pos = getObjPosition(cell);
	ColPos = pos; 
	 
	document.all.dvFlyMenu.innerHTML = html;
    document.all.dvFlyMenu.style.left= pos[0] + 70;
	document.all.dvFlyMenu.style.top= pos[1] - 10;
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
      
      SbmCmd[SbmLoop] = chkCmd(SbmCmd[SbmLoop]);
      
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
//show table with different sorting
//==============================================================================
function chkCmd(str)
{
	if(str == null || str == "" || str.indexOf("`") < 0 ){ return str; }
	else
	{
		while( str.indexOf("`") >= 0 )
		{
			str = str.replace("`", "@@1@@");
		}
	}
	return str;
}
//==============================================================================
// show table with different sorting
//==============================================================================
function resort(sort)
{
   var url = "MozuParentLst.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>";           
   
   if(LogSize == "2"){ LogSize = "1"; }
   
   url += "&Sort=" + sort
        + "&From=<%=sFrom%>&To=<%=sTo%>&MarkDownl=<%=sSrchDownl%>"
        + "&Excel=N&Site=<%=sSite%>&Sku=&Pon="
        + "&InvAvl=<%=sInvAvl%>"
        + "&InvStr=<%=sInvStr%>"
        + "&MarkedWeb=<%=sMarkedWeb%>"
        + "&LogSize=" + LogSize
        ;
   for(var i=0; i < Attr.length; i++)
   {
	   url += "&Attr=" + Attr[i];
   }    

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
      if( document.all.tdSaS.innerHTML != "Y" && document.all.tdRack.innerHTML != "Y" ){ document.all.trItem.style.display = show; }
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

//==============================================================================
//show childs fro selected parent
//==============================================================================
function showItemList(cls, ven, sty)
{
	var url ="MozuItmLst.jsp?Div=ALL&Dpt=ALL&Cls=ALL&Ven=ALL&From=ALL&To=ALL&FromIP=ALL&ToIP=ALL" 
     + "&MarkDownl=0&Excel=N&Pon=&ModelYr=&MapExpDt=&InvAvl=NONE&MarkedWeb=9&InvStr=ALL"
     + 	"&Parent=" + cls +  ven + sty
     + "&Site=<%=sSite%>"
     window.open(url, '_blank');
}
//==============================================================================
//show Image list
//==============================================================================
function showImgList(cls, ven, sty)
{	
	var url ="MozuImageLst.jsp?Cls=" + cls
	  + "&Ven=" + ven 
	  + "&Sty=" + sty 
	  + "&Site=<%=sSite%>"
    window.open(url, '_blank');
}
//==============================================================================
//show Image list
//==============================================================================
function showAddPropList(cls, ven, sty)
{	
	var url ="MozuItemAddPropList.jsp?Cls=" + cls
	  + "&Ven=" + ven 
	  + "&Sty=" + sty 
	  + "&Site=<%=sSite%>"
  window.open(url, '_blank');
}
//==============================================================================
//show Image list
//==============================================================================
function showAddBindList(cls, ven, sty, prtyid)
{	
	var url ="MozuItemAddBindList.jsp?Cls=" + cls
	  + "&Ven=" + ven 
	  + "&Sty=" + sty 
	  + "&Site=<%=sSite%>"
	  + "&PrTyId=" + prtyid
	window.open(url, '_blank');
}
//==============================================================================
//show Image list
//==============================================================================
function showAddPropNm()
{
	var hdr = "Additioanl Properties Names";
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	   + "<tr>"
	     + "<td class='BoxName' nowrap>" + hdr + "</td>"
	     + "<td class='BoxClose' valign=top>"
	       +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
	     + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>" + popAddPropNm()
	   
	html += "</td></tr></table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.left= document.documentElement.scrollLeft + 700;
	document.all.dvItem.style.top= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";

}
//--------------------------------------------------------
//populate Column Panel
//--------------------------------------------------------
function popAddPropNm()
{  
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<tr><th class='DataTable' nowrap>Id</th>"
	  + "<th class='DataTable' nowrap>Type</th>"
	  + "<th class='DataTable' nowrap>Name</th>"
	 + "</tr>" 
        
    for(var i=0; i < PropId.length ;i++)
    {
    	panel += "<tr>"
    	 + "<td class='Prompt' nowrap>" + PropId[i] + "</td>"
    	 + "<td class='Prompt' nowrap>" + PropType[i] + "</td>"
    	 + "<td class='Prompt' nowrap>" + PropNm[i] + "</td>"
    	+ "</tr>" 
    }
	 
    panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
            + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
    panel += "</table>";
    return panel;    
}
//==============================================================================
//create excel 
//==============================================================================
function crtExcel()
{
	var url = "KiboItemToExcel.jsp?"
        + "Div=<%=sSrchDiv%>"
        + "&Dpt=<%=sSrchDpt%>"
        + "&Cls=<%=sSrchCls%>"
        + "&Ven=<%=sSrchVen%>";           

	if(LogSize == "2"){ LogSize = "1"; }

	url += "&Sort=<%=sSort%>"
     + "&From=<%=sFrom%>&To=<%=sTo%>&MarkDownl=<%=sSrchDownl%>"
     + "&Excel=N&Site=<%=sSite%>&Sku="
     + "&InvAvl=<%=sInvAvl%>"
     + "&InvStr=<%=sInvStr%>"
     + "&MarkedWeb=<%=sMarkedWeb%>"
     + "&LogSize=" + LogSize
     + "&Pon=" + PoNum   
     + "&Parent=<%=sSelParent%>"
    ;
     
     for(var i=0; i < Attr.length; i++)
     {
  	   url += "&Attr=" + Attr[i];
     }    
	
	var WindowName = "ECOM_Item_To_Excel";
    var WindowOptions = "height=500, width=900,left=10,top=10, resizable=yes , toolbar=no, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes";

	//alert(url);
	window.open(url, WindowName, WindowOptions);
	window.status="Table Loaded."
}
//==============================================================================
//create excel 
//==============================================================================
function crtExcelwAttr()
{
	selty = document.all.selLoadType;
	prodty = selty.options[selty.selectedIndex].value; 
	
	
	var url = "KiboItemPropToExcel.jsp?"
        + "Div=<%=sSrchDiv%>"
        + "&Dpt=<%=sSrchDpt%>"
        + "&Cls=<%=sSrchCls%>"
        + "&Ven=<%=sSrchVen%>";           

	if(LogSize == "2"){ LogSize = "1"; }

	url += "&Sort=<%=sSort%>"
     + "&From=<%=sFrom%>&To=<%=sTo%>&MarkDownl=<%=sSrchDownl%>"
     + "&Excel=N&Site=<%=sSite%>&Sku="
     + "&InvAvl=<%=sInvAvl%>"
     + "&InvStr=<%=sInvStr%>"
     + "&MarkedWeb=<%=sMarkedWeb%>"
     + "&LogSize=" + LogSize
     + "&Pon=" + PoNum
     + "&Parent=<%=sSelParent%>"
     + "&ProdType=" + prodty
    ;
     
     
     for(var i=0; i < Attr.length; i++)
     {
  	   url += "&Attr=" + Attr[i];
     }    
	
	var WindowName = "ECOM_Item_To_Excel";
    var WindowOptions = "height=500, width=900,left=10,top=10, resizable=yes , toolbar=no, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes";

	//alert(url);
	window.open(url, WindowName, WindowOptions);
	window.status="Table Loaded."
}
//==============================================================================
//send Item to Kibo 
//==============================================================================
function sendToKibo(i, cls,ven,sty)
{
	url = "MozuParentSave.jsp?Site=<%=sSite%>" 
  	 + "&Cls=" + cls
  	 + "&Ven=" + ven
 	 + "&Sty=" + sty
 	 + "&Action=SendAddPropKibo" 
 	 + "&Line=" + i
 	;
 	window.frame1.location.href=url; 
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<BODY onload="bodyLoad();">
<div id="dvLog" class="dvLog">Download log</div>
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
    <TD vAlign=top align=center>
        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="MozuParentLstSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
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
        <a href="javascript: crtExcel()">Load To Excel</a> &nbsp;&nbsp;
        <span id="spnLoad" style="font-size:11px"></span>
        &nbsp;&nbsp;&nbsp;&nbsp
        <a href="KiboUplDQLog.jsp" target="_blank">All User Upload Log</a> 
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
             <th class="DataTable" rowspan=2>No.</th>
             <%if(bDwnLoad){%><th class="DataTable" rowspan=2>Dwn</th><%}%>
             <th class="DataTable" rowspan=2>Original<br>Download<br>Date</th>
             <%if(bAllowSendToKibo){%><th class="DataTable" rowspan=2>Dwn<br>Attr</th><%}%>
             <th class="DataTable" rowspan=2>Last<br>Download<br>Date</th>
             <th class="DataTable" rowspan=2>Div<br>#</th>
             <th class="DataTable" rowspan=2 >Dpt<br>#</th>
             <th class="DataTable" rowspan=2 ><a href="javascript: resort('ITEM');">Long SKU<br>Cls-Ven-Sty</a></th>
             <th class="DataTable" rowspan=2 >Image</th>
             <th class="DataTable" rowspan=2 >Addtl<br>Prop</th>
             <th class="DataTable" rowspan=2 >Add<br>Bind</th>
             <th class="DataTable" rowspan=2 >Chain<br>Retail</th>
             <th id="thPrdTy" class="DataTable" rowspan=2 >
                <a href="javascript: resort('PRDTY');">Product<br>Type</a>
                <br><br><a href="javascript: selColumn('PRDTY');">Select</a>
             </th>
             <th class="DataTable" rowspan=2 >IP Vendor<br>Name</th>
             <th class="DataTable" rowspan=2 >IP Vendor<br>Style</th>
             <th class="DataTable" rowspan=2 >IP Item<br>Description</th>
             
             <th id="thNormClr" class="DataTable" rowspan=2 >
                <a href="javascript: resort('NORMCLR');">Normalized<br>Color</a>                
             </th>
             
             <th id="thSkiChlt" class="DataTable" colspan=<%if(sInvAvl.equals("STR")){%>2<%} else {%>1<%}%> >On hand<br>Qty</th>
             
             <th id="thMnf" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MNF');">Manufacturer<br>Name</a>
                <br><br><a href="javascript: selColumn('MNF');">Select</a>
             </th>
             <th id="thGender" class="DataTable" rowspan=2 >MF<br>(Gender)
                <br><br><a href="javascript: selColumn('GENDER');">Select</a>
             </th>
             <th id="thAge" class="DataTable" rowspan=2 >Age
                <br><br><a href="javascript: selColumn('AGE');">Select</a>
             </th>
             
             <th id="thCateg" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('CATEG');">Category</a>
                <br><br><a href="javascript: selColumn('CATEG');">Select</a>
             </th>
             
             <th id="thExtNm" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('EXTNM');">Extended<br>Name</a>
                <br><br><a href="javascript: selColumn('EXTNM');">Select</a>
             </th>
             
             <th id="thWebDs" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('WEBDS');">Web<br>Description</a>
                <br><br><a href="javascript: selColumn('WEBDS');">Select</a>
             </th>
             
             <th id="thModel" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MODEL');">Model<br>Number</a>
                <br><br><a href="javascript: selColumn('MODEL');">Select</a>
             </th>
             <th id="thMdlYear" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MDLYR');">Model<br>Year</a>
                <br><br><a href="javascript: selColumn('MDLYR');">Select</a>
             </th>
             
             <th id="thDesc" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('WEBNM');">Web<br>Name</a>
                <br><br><a href="javascript: selColumn('WEBNM');">Select</a>
             </th>             
             
             <th id="thShortDs" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('SHORTDESC');">Short<br>Description</a>
                <br><br><a href="javascript: selColumn('SHORTDESC');">Select</a>
             </th>
             
             <th id="thFullDs" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('FULLDESC');">Full<br>Description</a>
                <br><br><a href="javascript: selColumn('FULLDESC');">Select</a>
             </th>
             <th id="thGoogle" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('GOOGLE');">Meta Tag<br>Title</a>
                <br><br><a href="javascript: selColumn('GOOGLE');">Select</a>
             </th>
             
             <!-- ============== Dimensions, weight ==================== -->
             <th id="thWgt" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('WEIGHT');">Shipping<br>Weight<br>(lbs.)</a>
                <br><a href="javascript: selColumn('WEIGHT');">Select</a>
             </th>
             <th id="thLen" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('LENGTH');">Shipping<br>Length<br>(in)</a>
                <br><a href="javascript: selColumn('LENGTH');">Select</a>
             </th>
             <th id="thWdt" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('Width');">Shipping<br>Width<br>(in)</a>
                <br><a href="javascript: selColumn('Width');">Select</a>
             </th>
             <th id="thHgt" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('HEIGHT');">Shipping<br>Height<br>(in)</a>
                <br><a href="javascript: selColumn('HEIGHT');">Select</a>
             </th>
             <th id="thTaxCat" class="DataTable" rowspan=2 nowrap >
                <a href="javascript: resort('TAXCAT');">Tax<br>Category</a>
                <br><br><a href="javascript: selColumn('TAX');">Select</a>
             </th>             
             <!-- ============ End Dimensions, weight =================== -->
             
             <th id="thMap" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MAP');">Map</a>
                <br><br><a href="javascript: selColumn('MAP');">Select</a>
             </th>
             <th id="thNoMap" class="DataTable" rowspan=2 >
                <a href="javascript: resort('NOMAP');">Map<br>as<br>RCI</a>
                <br><br><a href="javascript: selColumn('NOMAP');">Select</a>
             </th>
             <th id="thMapDt" class="DataTable" rowspan=2 >
                <a href="javascript: resort('MAPDT');">Map Expiration<br>Date</a>
                <br><br><a href="javascript: selColumn('MAPDT');">Select</a>
             </th>

             
             <th id="thLive" class="DataTable" rowspan=2 >Live <br><a href="javascript: selColumn('LIVE');">Select</a></th>
             <th id="thTaxFree"  rowspan=2 class="DataTable">Tax<br>Free</th>
             
             <!-- th id="thTaxFree"  colspan=<%=iNumOfProp%> class="DataTable">
             	<a href="javascript: showAddPropNm()">Additional Properties</a>
             </th --> 
             <th id="thMon"  rowspan=2 class="DataTable">Upl<br>Mon</th>   
             <th id="thFstcrtDt"  rowspan=2 class="DataTable">First<br>Creation<br>Date</th>
             <th id="thFstcrtDt"  rowspan=2 class="DataTable">Last<br>Receipt<br>Date</th>
         </tr>
         
         
         <tr class="DataTable">
             <!-- th class="DataTable"><a href="javascript: resort('INFO');">Inf</a></th -->
             <!-- th class="DataTable"><a href="javascript: resort('SALES');">Sls</a></th -->
             <th class="DataTable"nowrap>Cmpny</th>             
             <%if(sInvAvl.equals("STR")){%>
                 <th class="DataTable"nowrap>Str<br><%=sInvStr%></th>
             <%}%>
             
             <!-- for(int i=0; i < iNumOfProp; i++){ % >
                <th id="thProp< % = i % >" class="DataTable">< % = sPropId[i] % ></th>
             <} -->             
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
            String sWeb = itmLst.getWeb().trim();
            String sDownload = itmLst.getDownload();

            String sOrigDown = itmLst.getOrigDown();
            String sLastDown = itmLst.getLastDown();
            String sCategory = itmLst.getCategory();
            String sCategoryId = itmLst.getCategoryId();             
            String sSaS = itmLst.getSaS();
            String sSkiChalet = itmLst.getSkiChalet();
            String sSStp = itmLst.getSStp();
            String sRack = itmLst.getRack();
            String sRebel = itmLst.getRebel();
            String sJoJo = itmLst.getJoJo();
            String sWarehse1 = itmLst.getWarehse1();
            String sWarehse2 = itmLst.getWarehse2();
            String sTaxFree = itmLst.getTaxFree();
            String sOnPO = itmLst.getOnPO();
            String sOldItem = itmLst.getOldItem();
            String sStrOnHnd = itmLst.getStrOnHnd();
            String sIpVenNm = itmLst.getIpVenNm();
            String sIpVenSty = itmLst.getIpVenSty();
            String sProdType = itmLst.getProdType();
            String sProdTypeId = itmLst.getProdTypeId();
            String sNormClr = itmLst.getNormClr();
            String sShortDesc = itmLst.getShortDesc();
            String sFullDesc = itmLst.getFullDesc();
            String sIpDesc = itmLst.getIpDesc();
            String sAgeReq = itmLst.getAgeReq();
            boolean bAgeReq = sAgeReq.equals("Y");
            
            int iMxGen = itmLst.getMxGen();
            String [] sGenLst = itmLst.getGenLst();
            int iMxAge = itmLst.getMxAge();
            String [] sAgeLst = itmLst.getAgeLst();
            
            String [] sAddItmProp = itmLst.getAddItmProp();
            String sExtNm = itmLst.getExtNm();
            String sWebDesc = itmLst.getWebDesc();
            String sWeight = itmLst.getWeight();
            String sGoogle = itmLst.getGoogle();
            String sLen = itmLst.getLen();
            String sWidth = itmLst.getWidth();
            String sHeight = itmLst.getHeight();
            String [] sDftDim = itmLst.getDftDim();
            String sTaxCat = itmLst.getTaxCat();
            String sFstCrtDt = itmLst.getFstCrtDt();
            String sLstCrtDt = itmLst.getLstCrtDt();
            
            String [] sDimCls = new String[4];            
            for(int k=0; k < 4; k++)
            {	
            	sDimCls[k] = "DataTable1y";
            	if(sDftDim[k].equals("1")){ sDimCls[k] = "DataTable1g"; }
            	else if(sDftDim[k].equals("2")){ sDimCls[k] = "DataTable1g"; }
            	else if(sDftDim[k].equals("3")){ sDimCls[k] = "DataTable1"; }
            }
            
            boolean bMarkItm = sWeb.equals("2") || sWeb.equals("3");
            boolean bDownAllow = !sMnfName.equals("") && !sGender.equals("") && !sWeb.equals("1");
            
            // concatanate on-line product name
            int iGender = -1;
            for (int j=0; j < sGenderLst.length; j++)
            {
               if (sGenderLst[j].equals(sGender)){ iGender = j; break;}
            }
            if (iGender == -1) { iGender = sGenderName.length-1;}
            String sOnLineDesc = sMnfName + " " + sGenderName[iGender] + " " + sDesc + " " + sCategory;
            
            String sComa = "";
            sGender = "";
            for(int j=0; j < iMxGen; j++)
            {
            	sGender += sComa + sGenLst[j];
            	sComa = ",";
            }
            sComa = "";
            String sAge = "";
            for(int j=0; j < iMxAge; j++)
            {
            	sAge += sComa + sAgeLst[j];
            	sComa = ",";
            }
       %>
         <tr id="trItem" class="DataTable<%if(sOldItem.equals("1")){%>2<%}%>">
            <td class="DataTable1" nowrap><%=i+1%></td>
            <script>OnPO[OnPO.length] = <%=sOnPO.equals("1")%>;OldItem[OldItem.length] = <%=sOldItem.equals("1")%>;</script>
            <%if(bDwnLoad){%>                
                 <th class="DataTable" id="tdDownL" <%if(!bDownAllow){%>style="background:pink;"<%}%> >                   
                   <a name="Down" href="javascript: vldDownl(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', <%=sWeb.equals("1")%>)">M</a>
                 </th>
            <%}%>
            <td id="tdOrgDwn" class="DataTable1" nowrap><%=sOrigDown%></td>
            
            <%if(bAllowSendToKibo){%>                
                 <th class="DataTable" id="tdUpdAttr">                   
                   <a name="Down" href="javascript: sendToKibo('<%=i%>',  '<%=sCls%>','<%=sVen%>','<%=sSty%>')">A</a>
                 </th>
            <%}%>
            
            <td id="tdLstDwn" class="DataTable1" nowrap><%=sLastDown%></td>
            <td id="tdDiv" class="DataTable1" nowrap><%=sDiv%></td>
            <td id="tdDpt" class="DataTable02" nowrap onClick="if(!Used){ chgItem(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>') }"><%=sDpt%></td>
            <td id="tdItem" class="Link1" onclick="showItemList('<%=sCls%>','<%=sVen%>','<%=sSty%>')" nowrap>
               <%=sCls + "-" + sVen + "-" + sSty%>
               <%if(sOnPO.equals("1")){%><span style="color:red;"><sup>P.O.</sup></span><%}%>
            </td>
            <td id="tdImage" class="Link1" onclick="showImgList('<%=sCls%>','<%=sVen%>','<%=sSty%>')" nowrap>Image</td>
            <td id="tdImage" class="Link1" onclick="showAddPropList('<%=sCls%>','<%=sVen%>','<%=sSty%>')" nowrap>Prop</td>
            <td id="tdImage" class="Link1" onclick="showAddBindList('<%=sCls%>','<%=sVen%>','<%=sSty%>', '<%=sProdTypeId%>')" nowrap>Bind</td>
            <td id="tdRet" class="DataTable2" nowrap>$<%=sRet%></td>
            <td id="tdPrdTy" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'PRDTY')"<%}%>
                 class="DataTable1" <%if(sProdType.equals("Generic")){%>style="background: red;"<%}%>nowrap><%=sProdType%>
            </td>            
            <td class="DataTable1" nowrap><%=sIpVenNm%></td>
            <td id="tdIpVst" class="DataTable1" nowrap><%=sIpVenSty%></td>
            <td id="tdIpDesc" class="DataTable1" nowrap><%=sIpDesc%></td>
            <td id="tdNormClr" class="DataTable1" nowrap><%=sNormClr%></td>
            
            <td id="tdWrh01" class="DataTable2" nowrap><%=sWarehse1%></td>
            <!-- td id="tdWrh70" class="DataTable2" nowrap><%=sWarehse2%></td -->
            <%if(sInvAvl.equals("STR")){%>
               <td id="tdSku" class="DataTable2" nowrap><%=sStrOnHnd%></td>
            <%}%>
            
            <td id="tdMnf" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'MNF')"<%}%> class="DataTable1" nowrap><%=sMnfName%></td>
            <td id="tdGender" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'GENDER')"<%}%>  class="DataTable" nowrap><%=sGender%></td>
            <td id="tdAge" <%if(bDwnLoad && bAgeReq){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'AGE')"<%}%>  class="DataTable" nowrap><%=sAge%></td>            
            <td id="tdCateg" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'CATEG')"<%}%> class="DataTable1" nowrap><%=sCategory%></td>
            <td id="tdExtNm" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'EXTNM')"<%}%> class="DataTable1" nowrap><%=sExtNm%></td>
            <td id="tdWebDs" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'WEBDS')"<%}%> class="DataTable1" nowrap><%=sWebDesc%></td>            
            <td id="tdModel" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'MODEL')"<%}%>  class="DataTable1" nowrap><%=sModelName%></td>
            <td id="tdMdlYear" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'MDLYR')"<%}%>  class="DataTable1" nowrap><%=sModelYear%></td>
            <td id="tdDesc" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'WEBNM')"<%}%> class="DataTable1" nowrap><%=sDesc%></td>
            <td id="tdShortDs" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'SHORTDESC')"<%}%> class="DataTable1" nowrap><%=sShortDesc%></td>
            <td id="tdFullDs" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'FULLDESC')"<%}%> class="DataTable1" nowrap><%=sFullDesc%></td>
            <td id="tdGoogle" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'GOOGLE')"<%}%> class="DataTable1" nowrap><%=sGoogle%></td>
            
            <td id="tdWgt" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'WEIGHT')"<%}%> class="<%=sDimCls[0]%>" nowrap><%=sWeight%></td>
            <td id="tdLen" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'LENGTH')"<%}%> class="<%=sDimCls[1]%>" nowrap><%=sLen%></td>
            <td id="tdWdt" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'WIDTH')"<%}%> class="<%=sDimCls[2]%>" nowrap><%=sWidth%></td>
            <td id="tdHgt" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'HEIGHT')"<%}%> class="<%=sDimCls[3]%>" nowrap><%=sHeight%></td>            
            <td id="tdTaxCat" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'TAXCAT')"<%}%> class="DataTable1" nowrap><%=sTaxCat%></td>
            
            <td id="tdMap" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'MAP')"<%}%>  class="DataTable2" nowrap><%=sMap%></td>
            <td id="tdNoMap" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'NOMAP')"<%}%>  class="DataTable2" nowrap><%=sNoMap%></td>
            <td id="tdMapDt" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'MAPDT')"<%}%>  class="DataTable1" nowrap><%=sMapExpDate%></td>
            
            <td id="tdLive" <%if(bDwnLoad){%>onMouseDown="selColumnCell(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'LIVE')"<%}%> class="DataTable1" nowrap><%=sLive%></td>
            <td id="tdTaxFree" class="DataTable01" <%if(bDwnLoad){%>onclick="if(!Used){ markItem(<%=i%>, '<%=sCls%>','<%=sVen%>','<%=sSty%>', 'TAXFREE') }"<%}%> nowrap><%=sTaxFree%></td>
            <!--  for(int j=0; j < iNumOfProp; j++){%>
                <td id="tdProp< % = i % >" class="DataTable2">< % = sAddItmProp[j] % ></td>
            < } --> 
            <td id="tdUplMon" class="DataTable01" nowrap> 
               <%if(bDwnLoad){%><a href="MozuUplItemMon.jsp?Cls=<%=sCls%>&Ven=<%=sVen%>&Sty=<%=sSty%>" target="_blank">Mon</a><%} else{%>&nbsp;<%}%>
            </td>
            
            <td id="tdFstCrtDt" class="DataTable01" nowrap><%if(!sFstCrtDt.equals("01/01/0001")){%><%=sFstCrtDt%><%}%></td>
            <td id="tdLstCrtDt" class="DataTable01" nowrap><%if(!sLstCrtDt.equals("01/01/0001")){%><%=sLstCrtDt%><%} else{%>&nbsp;<%}%></td>   
          </tr>
          <script>
          var found = false;
          for(var i=0; i < ProdType.length; i++)
          {
        	  if(ProdType[i] == "<%=sProdType%>" ){ found = true; break; }
          }  
          if(!found ){ ProdType[ProdType.length] = "<%=sProdType%>"; }
          </script>
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