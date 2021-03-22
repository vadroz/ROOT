<%@ page import="supplyorder.SupOrderInfo, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelOrd = request.getParameter("Ord");
   String sSelGrp = request.getParameter("Grp");

   if(sSelOrd == null){ sSelOrd = "0000000000"; }
   if(sSelGrp == null){ sSelGrp = "NONE"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=SupOrderInfo.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
      StoreSelect StrSelect = null;
      String sStrAllowed = session.getAttribute("STORE").toString();
      String sUser = session.getAttribute("USER").toString();

      String sStrJsa = "";
      String sStrNmJsa = "";
      int iNumOfStr = 0;

      if(sSelOrd.equals("0000000000"))
      {
         if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
         {
            StrSelect = new StoreSelect(15);
         }
         else
         {
            Vector vStr = (Vector) session.getAttribute("STRLST");
            String [] sStrAlwLst = new String[ vStr.size()];
            Iterator iter = vStr.iterator();

            int iStrAlwLst = 0;
            while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

            if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
            else StrSelect = new StoreSelect(new String[]{sStrAllowed});
         }

            sStrJsa = StrSelect.getStrNum();
            sStrNmJsa = StrSelect.getStrName();
            iNumOfStr = StrSelect.getNumOfStr();
         }

      SupOrderInfo supord = new SupOrderInfo(sSelOrd, sUser);

      int iNumOfGrp = supord.getNumOfGrp();
      String [] sGrp = supord.getGrp();
      String [] sGrpNm = supord.getGrpNm();
      int [] iNumOfCls = supord.getNumOfCls();
      String [][] sGrpCls = supord.getGrpCls();
      String [][] sGrpClsNm = supord.getGrpClsNm();
      String [][] sGrpClsMax = supord.getGrpClsMax();

      String sGrpJsa = supord.getGrpJsa();
      String sGrpNmJsa = supord.getGrpNmJsa();

      String sOrd = "";
      String sStr = "";
      String sSts = "New";
      String sOrdDt = "";
      String sRecUs = sUser;
      String sRecUsNm = sUser;


      if(!sSelOrd.equals("0000000000"))
      {
         supord.setOrdInfo();
         sOrd = supord.getOrd();
         sStr = supord.getStr();
         sOrdDt = supord.getOrdDt();
         sSts = supord.getSts();
         sRecUs = supord.getRecUs();
         sRecUsNm = supord.getRecUsNm();
      }
      else
      {
      }

      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      String sToday = sdf.format(cal.getTime());
      sdf = new SimpleDateFormat("h:mm a");
      String sCurTime = sdf.format(cal.getTime());
%>

<html>
<head>
<title>Supply Order</title>

<style>
body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
 		table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-left: black solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable4 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px; vertical-align:top; }
        tr.DataTable8 { background: #ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}

        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.DataTable6 { filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#aaffaa
                          , endColorStr=white, gradientType=0);
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       font-size:12px; text-align:center}



        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }
        input.Small1 { font-family:Arial; font-size:10px }
        input.Small2 {background: white; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.Small3 {border:none; font-family:Arial;  font-size:10px }
        input.Small4 {background:#e7e7e7; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.radio { font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }

        div.dvSelLst  {  position: absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvNotes  { left: 125px; top: 10px; position: fixed ;  background-attachment: scroll;
              border: black solid 2px; width:400; background-color:LemonChiffon; z-index:10;
              text-align: left; font-size:14px; padding-left:5px;}      

        div.dvChkItm  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background: #016aab; 
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab; 
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var StrLst = [<%=sStrJsa%>];
var StrNmLst = [<%=sStrNmJsa%>];
var UserId = "<%=sUser%>";
var Order = "<%=sSelOrd%>";
var Status = "<%=sSts%>";

var GrpLst = [<%=sGrpJsa%>];
var GrpNmLst = [<%=sGrpNmJsa%>];
var NumOfDtl = new Array();

var ClsSku = null;
var ClsSkuDesc = null;
var ClsStock = null;
var ClsOnOrd = null;
var ClsMaxQty = null;
var ClsVenSty = null;
var ClsVenNm = null;

var SbmSku = null;
var SbmQty = null;
var SbmAct = null;
var SelGrp = "<%=sSelGrp%>"
var PanelPos = null;

var AlcDate = null;
var AcknDate = null;
var AllocNum = null;

var blockRow= "table-row";
var blockCell= "table-cell";
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.getElementById("dvNotes").style.position = "absolute"; }
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ blockRow = "block"; blockCell="block"; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvSelLst"]);
   	if(SelGrp != "NONE"){ setActivGrp(SelGrp); }
   	//else{ setActivGrp(GrpLst[0]); }
   	else { setConsolidate(); }
   	<%if(sSelOrd.equals("0000000000")) {%> setStrSel(); <%}%>
}
//==============================================================================
//  set store selection
//==============================================================================
function setStrSel()
{
   if(StrLst.length > 2)
   {
       document.all.selStr.options[0] = new Option("--- Select Store ---", "");
       for(var i=1; i < StrLst.length; i++)
       {
           document.all.selStr.options[i] = new Option(StrLst[i] + " - " + StrNmLst[i], StrLst[i]);
       }
   }
   else
   {
       document.all.Store.value = StrLst[1];
   }
}
//==============================================================================
// set active group
//==============================================================================
function setActivGrp(grp)
{
   for(var i=0; i < GrpLst.length; i++)
   {
      var linm = "li" + GrpLst[i];
      var clsgrp = "trClsGrp" + i;
      if(grp == GrpLst[i])
      {
         document.all[linm].className="current";
         if(Status == "Open") { document.all[clsgrp].style.display = blockRow; }
         for(var j=0; j < NumOfDtl[i]; j++)
         {
            var rownm = "tr" + GrpLst[i] + j;
            document.all[rownm].style.display = blockRow;
         }
      }
      else
      {
         document.all[linm].className=" ";
         document.all[clsgrp].style.display="none";
         for(var j=0; j < NumOfDtl[i]; j++)
         {
            var rownm = "tr" + GrpLst[i] + j;
            document.all[rownm].style.display="none";
         }
      }
   }
}
//==============================================================================
// set consolidate group
//==============================================================================
function setConsolidate()
{
   for(var i=0; i < GrpLst.length; i++)
   {
      var linm = "li" + GrpLst[i];
      var clsgrp = "trClsGrp" + i;

      document.all[linm].className=" ";
      if(Status == "Open") { document.all[clsgrp].style.display = blockRow; }

      for(var j=0; j < NumOfDtl[i]; j++)
      {
         var rownm = "tr" + GrpLst[i] + j;
         document.all[rownm].style.display = blockRow;
      }
   }
   document.all.liCONS.className="current";
}
//==============================================================================
// validate order header information
//==============================================================================
function printGrp(grp, str, grpnm)
{
   var url="SupOrdAllClsList.jsp?Grp=" + grp
    + "&Ord=<%=sSelOrd%>"
    + "&Str=" + str
    + "&GrpNm=" + grpnm
    ;
   window.open(url);
}

//==============================================================================
// get sku list for selected class
//==============================================================================
function getSkuList(cls, clsnm, grp, str, obj)
{
   SelGrp = grp;
   PanelPos = getObjPosition(obj);

   var url="SupOrdClsList.jsp?Ord=<%=sSelOrd%>"
    + "&Cls=" + cls
    + "&ClsNm=" + clsnm
    + "&Str=" + str
    ;

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// set sku list for selected class
//==============================================================================
function setSkuLst(cls, clsnm, sku, skudesc, stock, onord, maxqty, vensty, vennm, unit, umqty)
{
   ClsSku = sku;
   ClsSkuDesc = skudesc;
   ClsStock = stock;
   ClsOnOrd = onord;
   ClsMaxQty = maxqty;
   ClsVenSty = vensty;
   ClsVenNm = vennm;

   SbmSku = null;
   SbmQty = null;
   SbmAct = null;


   var hdr = "Class: " + cls + " " + clsnm + " &nbsp; ";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popSkuLstPanel(sku, skudesc, stock, onord, maxqty, vensty, vennm, unit, umqty)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvSelLst.style.width = "350";}
   else { document.all.dvSelLst.style.width = "auto";}
   
   document.all.dvSelLst.innerHTML = html;
   document.all.dvSelLst.style.left= getLeftScreenPos() + 250;
   document.all.dvSelLst.style.top= PanelPos[1] + 20;
   document.all.dvSelLst.style.visibility = "visible";
}
//==============================================================================
// populate sku List selection panel
//==============================================================================
function popSkuLstPanel(sku, skudesc, stock, onord, maxqty, vensty, vennm, unit, umqty)
{
  var panel = "<div style='height: 300px ; overflow: none;'>"
     + "<div style='height: 300px ; overflow: auto;'>"
     //+ "<span style='width:100%; background: CornSilk; font-size:10px'>Click on SKU to add it to order. Do not forget specified a quantity.</span>"
     + "<table  class='tbl02'>"
       + "<thead>"
        + "<tr class='DataTable4'>"
          //+ "<th class='DataTable1' nowrap>Add</th>"
          + "<th class='DataTable1' nowrap>Short SKU</th>"
          + "<th class='DataTable1' nowrap>ID#</th>"
          //+ "<th class='DataTable1' nowrap>Vendor Name</th>"
          + "<th class='DataTable1'>Description</th>"
          + "<th class='DataTable1'>In<br>Stock</th>"
          + "<th class='DataTable1'>On<br>Order</th>"
          + "<th class='DataTable1'>U/M</th>"
          + "<th class='DataTable1'>U/M<br>Qty</th>"
          + "<th class='DataTable1'>Maximum<br>Order<br>Qty</th>"
          + "<th class='DataTable1'>Order<br>Qty</th>"
          + "<th class='DataTable1' id='thError'>Error</th>"
        + "</tr>"
      + "</thead>"
      + "<tbody>"

  for(var i=0; i < sku.length; i++)
  {
      panel += "<tr class='DataTable9' id='trSku" + i + "'>"
      /* + "<td class='DataTable2' nowrap>"
      if(eval(stock[i]) > 0)
      {
          panel += "<input type='checkbox' name='inpChk" + i + "'"
                + " onclick='moveFocus(&#34;" + i + "&#34;)' value='" + i + "'>"
      }else { panel += "&nbsp;" }
      */
      panel += "</td>"
          + "<td class='DataTable2' nowrap>" + sku[i] + "</td>"
          + "<td class='DataTable' nowrap>" + vensty[i] + "</td>"
          //+ "<td class='DataTable' nowrap>" + vennm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + skudesc[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + stock[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + onord[i] + "</td>"
          + "<td class='DataTable1' nowrap>&nbsp;" + unit[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + umqty[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + maxqty[i] + "</td>"
          + "<td class='DataTable1' nowrap>"
       if(eval(stock[i]) > 0){
           panel += "<input class='Small' name='inpQty" + i + "'"
                 + " onchange='chkSku(&#34;" + i + "&#34;)' size='5' maxlength='5'>"
       } else { panel += "&nbsp;"}
       panel += "</td>";

       panel += "<td class='DataTable2' nowrap id='tdError" + i + "'>&nbsp;</td>"
        + "</tr>"
  }

  panel += "</tbody>"
  panel += "</table></div>";
  panel += "<span style='width:100%; text-align:center'>"
          + "<button id='btnAdd' onClick='ValidateNewSku(&#34;" + sku.length + "&#34;);' class='Small'>Add</button> &nbsp; &nbsp; "
          + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</span></div>";
  return panel;
}
//==============================================================================
// mark item for add
//==============================================================================
function chkSku(arg)
{
   var box = "inpChk" + arg
   document.all[box].checked = true;
}
//==============================================================================
// mark item for add
//==============================================================================
function moveFocus(arg)
{
   var box = "inpQty" + arg
   document.all[box].focus();
   document.all[box].select();
}
//==============================================================================
// validate sku entry
//==============================================================================
function ValidateNewSku( numSku )
{
   var error = false;
   var msg = "";

   var sku = new Array();
   var iqty = new Array();
   var numSelSku = 0;

   for(var i=0, j=0; i < numSku; i++)
   {
      //var chknm = "inpChk" + i
      var errnm = "tdError" + i
      document.all[errnm].innerHTML="&nbsp;";
      var errsku = false;

      var iqtynm = "inpQty" + i;

      if(document.all[iqtynm] != null && document.all[iqtynm].value.trim() != "")
      {
        iqty[j] = document.all[iqtynm].value.trim();
        sku[j] = ClsSku[i];

        var avail = eval(ClsStock[i]) - eval(ClsOnOrd[i]);

        if(iqty[j]==""){error=true; errsku=true; msg="Please enter requered quantity"; }
        else if(isNaN(iqty[j])) {error=true; errsku=true; msg="Required quantity is not numeric, please correct"; }
        else if(eval(iqty[j]) <= 0) {error=true; errsku=true; msg="Required quantity must be a positive value, please correct"; }
        else if(avail < eval(iqty[j]) ) {error=true; errsku=true; msg="Required quantity greater than in stock minus on-order, please correct"; }
        else if(eval(ClsMaxQty[i]) > 0 &&  eval(iqty[j]) > eval(ClsMaxQty[i]) ) {error=true; errsku=true; msg="Required quantity greater than maximum allowed, please correct"; }

        if(errsku)
        {
           document.all[errnm].innerHTML=msg;
           document.all[errnm].style.color="red";
        }
        numSelSku++;
        j++;
      }
   }
   if(numSelSku == 0){ error=true; alert("No SKU was selected."); }

   var action = "ADD_SKU";

   if(!error)
   {
      document.all.btnAdd.disabled = true;

      SbmSku = sku;
      SbmQty = iqty;
      SbmAct = action;
      hidePanel();
      sbmSku(0);
   }
}
//==============================================================================
// submit sku changes
//==============================================================================
function sbmSku(i)
{
   if(i < SbmSku.length)
   {
      var url="SupOrdSave.jsp?Ord=<%=sSelOrd%>"
       + "&Sku=" + SbmSku[i]
       + "&Qty=" + SbmQty[i]
       + "&Action=" + SbmAct
       + "&Next=" + ++i
      //alert(url);
      window.frame1.location.href = url;
   }
   else
   {
      restart("<%=sSelOrd%>");
   }
}
//==============================================================================
// change contract status
//==============================================================================
function chgStatusMenu(ord, cursts)
{
   var hdr = "Order: " + ord + "  Current Status: " + cursts + " &nbsp; ";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStatusPanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvSelLst.style.width = "250";}
   else { document.all.dvSelLst.style.width = "auto";}
   
   document.all.dvSelLst.innerHTML = html;
   document.all.dvSelLst.style.left= getLeftScreenPos() + 140;
   document.all.dvSelLst.style.top= getTopScreenPos() + 95;
   document.all.dvSelLst.style.visibility = "visible";

   getSelStatus();
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popStatusPanel()
{
  var panel = "<table class='tbl02'>"
  panel += "<tr class='DataTable9'>"
          + "<td>Status </td>"
          + "<td colspan=5 nowrap><select name='selSts' class='Small'></select></td>"
        + "</tr>"

  panel += "<tr class='DataTable9'>";
  panel += "<td colspan=7 align=center><br><br><button onClick='sbmSts()' class='Small'>Change</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function sbmSts()
{
    var sts = document.all.selSts[document.all.selSts.selectedIndex].value

    var url="SupOrdSave.jsp?Ord=<%=sSelOrd%>"
       + "&Sts=" + sts
       + "&Action=CHG_ORD_STS"
    //alert(url);
    window.frame1.location.href = url;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function getSelStatus(sel)
{
   var url="SupOrdConst.jsp?Const=STATUS"
    + "&Function=setSelStatus"
    + "&Field=selSts";
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function setSelStatus(fld, constVal, constDesc)
{
   for(var i=0; i < 2; i++)
   {
      document.all[fld].options[i] = new Option( constDesc[i], constVal[i])
   }
   document.all[fld].options[i] = new Option( constDesc[constVal.length-1], constVal[constVal.length-1])

}
//==============================================================================
// delete sku
//==============================================================================
function dltSku(sku, desc, grp)
{
 SelGrp = grp;

 var hdr = "Delete SKU: " + sku + " &nbsp; ";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popDltSkuPanel(sku, desc)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvSelLst.style.width = "250";}
   else { document.all.dvSelLst.style.width = "auto";}
   
   document.all.dvSelLst.innerHTML = html;
   document.all.dvSelLst.style.left= getLeftScreenPos() + 340;
   document.all.dvSelLst.style.top= getTopScreenPos() + 135;
   document.all.dvSelLst.style.visibility = "visible";
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popDltSkuPanel(sku, desc)
{
  var panel = "<table class='tbl02'>"
  panel += "<tr class='DataTable9'><tr class='DataTable9'><td>&nbsp;</td></tr>"
        + "<tr class='DataTable9'>"
          + "<td nowrap>&nbsp; SKU: &nbsp;</td>"
          + "<td nowrap>" + sku + " - " + desc + " &nbsp;</td>"
        + "</tr>"

  panel += "<tr class='DataTable9'>";
  panel += "<td align=center colspan=7><br><br><button onClick='sbmDltSku(&#34;" + sku + "&#34;)' class='Small'>Delete</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// submit sku deletion
//==============================================================================
function sbmDltSku(sku)
{
    var url="SupOrdSave.jsp?Ord=<%=sSelOrd%>"
       + "&Sku=" + sku
       + "&Action=DLT_SKU"
    //alert(url);
    window.frame1.location.href = url;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function updSku(sku, qty, instock, onord, desc, grp)
{

 SelGrp = grp;

 var hdr = "Update SKU: " + sku + " &nbsp; ";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popUpdSkuPanel(sku, qty, instock, onord, desc)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvSelLst.style.width = "250";}
   else { document.all.dvSelLst.style.width = "auto";}
   
   document.all.dvSelLst.innerHTML = html;
   document.all.dvSelLst.style.left= getLeftScreenPos() + 340;
   document.all.dvSelLst.style.top= getTopScreenPos() + 135;
   document.all.dvSelLst.style.visibility = "visible";
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popUpdSkuPanel(sku, qty, instock, onord, desc)
{
  var panel = "<table class='tbl02'>"
  panel += "<tr class='DataTable8'><td colspan=2>&nbsp;</td></tr>"
        + "<tr class='DataTable8'>"
          + "<td nowrap>&nbsp; SKU: &nbsp;</td>"
          + "<td nowrap>" + sku + " &nbsp;</td>"
        + "</tr>"
        + "<tr class='DataTable8'>"
          + "<td nowrap>&nbsp; Description: &nbsp;</td>"
          + "<td nowrap>" + desc + " &nbsp;</td>"
        + "</tr>"

        + "<tr class='DataTable8'>"
          + "<td nowrap>&nbsp; Qty</td>"
          + "<td nowrap><input class='Small' name='Qty' size=5 maxlength=5  value='" + qty + "'></td>"
        + "</tr>"

        + "<tr class='DataTable8'>"
          + "<td nowrap>&nbsp; In-Stock: &nbsp;</td>"
          + "<td nowrap>" + instock + "&nbsp; </td>"
        + "</tr>"

        + "<tr class='DataTable8'>"
          + "<td nowrap>&nbsp; On Order: &nbsp;</td>"
          + "<td nowrap>" + onord + "&nbsp; </td>"
        + "</tr>"

  panel += "<tr class='DataTable8'>";
  panel += "<td align=center colspan=7><br><br><button onClick='ValidateUpdSku(&#34;"
     + sku + "&#34;,&#34;" + instock + "&#34;,&#34;" + onord + "&#34;)' class='Small'>Update</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// submit sku deletion
//==============================================================================
function ValidateUpdSku(sku, instock, onord)
{
   var error=false;
   var msg="";
   var qty = document.all.Qty.value.trim();

   var avail = eval(instock) - eval(onord);

   if(qty==""){ error=true; msg += "\nPlease enter quantity." }
   else if(isNaN(qty)){ error=true; msg += "\nQuantity is not numeric." }
   else if(eval(qty) <= 0){ error=true; msg += "\nQuantity must be a positive number." }
   else if(avail < eval(qty) ) {error=true; errsku=true; msg="Required quantity greater than in stock minus on-order, please correct"; }
   //else if(eval(ClsMaxQty[i]) > 0 &&  eval(qty) > eval(ClsMaxQty[i]) ) {error=true; errsku=true; msg="Required quantity greater than maximum allowed, please correct"; }


   if(error){alert(msg);}
   else{ sbmUpdSku(sku, qty) }
}
//==============================================================================
// submit sku deletion
//==============================================================================
function sbmUpdSku(sku, qty)
{
    var url="SupOrdSave.jsp?Ord=<%=sSelOrd%>"
       + "&Sku=" + sku
       + "&Qty=" + qty
       + "&Action=UPD_SKU"
    //alert(url);
    window.frame1.location.href = url;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvSelLst.innerHTML = " ";
   document.all.dvSelLst.style.visibility = "hidden";
}
//==============================================================================
// populate store with selection
//==============================================================================
function chgStr(selstr)
{
   document.all.Store.value = selstr.options[selstr.selectedIndex].value
}
//==============================================================================
// validate order header information
//==============================================================================
function openOrd()
{
   var error = false;
   var msg = "";
   var str = document.all.Store.value.trim();

   if(str==""){error=true; msg+="Please, select store."}

   if(error){ alert(msg); }
   else{ sbmOpnOrd(str); }
}
//==============================================================================
// validate order header information
//==============================================================================
function sbmOpnOrd(str)
{
   var url = "SupOrdSave.jsp?Ord=0"
    + "&Sts=New"
    + "&Str=" + str
    + "&Action=OPEN_ORD";

   //alert(url);
   window.frame1.location.href = url;
}


//==============================================================================
// validate order header information
//==============================================================================
function restart(ord)
{
   var url = "SupOrderInfo.jsp?Ord=" + ord
   if(SelGrp != "NONE"){ url += "&Grp=" + SelGrp; }
   window.location.href = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<link href="Tabs/tabs.css" rel="stylesheet" type="text/css" />


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvSelLst" class="dvSelLst"></div>
<!-------------------------------------------------------------------->
<div id="dvNotes" class="dvNotes">
<b>You MUST use the "change" button to update the status to 
<br>"submitted" to have the order placed and sent to the DC. 
</b>
</div>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0" width="100%">
     <tr>
      <td ALIGN="left" VALIGN="TOP" width="30%" nowrap>
         <b><font size="-1">
             User: <%=sUser%>&nbsp;
            </font>
            </b>
      </td>
      <td ALIGN="center" VALIGN="TOP" nowrap>
        <b>Supply Order
        <br><span style="font-size:18px; font-weight:bold">Order: <%=sSelOrd%></span>
        <br>
          <%if(sSelOrd.equals("0000000000")){%><button class="Small" onClick="openOrd();">Open Order</button><%}
            else if(sSts.equals("Open") || sSts.equals("Submitted") || sSts.equals("Cancelled")){%>
            <button class="Small" onClick="chgStatusMenu('<%=sSelOrd%>', '<%=sSts%>');">Change</button>
          <%}%>

          Status: <span style="background:yellow"><%if(sSelOrd.equals("0000000000")){%>New<%} else {%><%=sSts%><%}%></span>

      </td>
      <td ALIGN="right" VALIGN="TOP" width="30%" nowrap>
         <b><font size="-1">Date: <%=sToday%>
         <br>Time: <%=sCurTime%>

         </font></b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3 nowrap>
         <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
         <a href="SupOrdListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page. &nbsp; &nbsp; &nbsp;
         <br>
      </td>
   </tr>
<!-- ==================== Order Information ================================ -->
   <tr>
     <td ALIGN="center" VALIGN="TOP" colspan=3 nowrap>
       <div id="dvCont" style="border-width:3px; border-style:ridge; border-color:lightgray; width:100%;">
         <table cellPadding="0" cellSpacing="0" width="100%">
           <tr class="DataTable">
             <td class="DataTable6">
              Store: <input name="Store" class='Small2' size="5" maxlength="5" value="<%=sStr%>" readonly>
              <%if(sSelOrd.equals("0000000000") && iNumOfStr > 1){%><select class="Small" name="selStr" onchange="chgStr(this)"></select><%}%>
                &nbsp; &nbsp;&nbsp; &nbsp;
              Order Date: <%if(sSelOrd.equals("0000000000")){%><%=sToday%><%} else {%><%=sOrdDt%><%}%>
                &nbsp; &nbsp;&nbsp; &nbsp;
              Opened by: <%=sRecUsNm%>
             </td>
           </tr>
         </table>
       </div>
      </td>
   </tr>
<!-- ======================= Navigation Tabs =============================== -->
   <tr>
    <td ALIGN="left" VALIGN="TOP" colspan=3 nowrap <%if(sSelOrd.equals("0000000000")){%>style="display:none;"<%}%>>
     <br>
       <ol id="toc">
         <%for(int i=0; i < iNumOfGrp; i++){%>
           <li id="li<%=sGrp[i]%>" <%if(i==0){%>class="current"<%}%>>
             <a href="javascript: setActivGrp('<%=sGrp[i]%>')"><span><%=sGrpNm[i]%>&nbsp;
                <img style="border:none;" src="PrinterIcon.png" width="20px" height="20px" onclick="printGrp('<%=sGrp[i]%>', '<%=sStr%>', '<%=sGrpNm[i]%>')"></span>
             </a>
           </li>
         <%}%>
         <li id="liCONS"><a href="javascript: setConsolidate()"><span>All</span></a></li>
       </ol>

       <div style="border: #48f solid 3px;clear: left;padding: 1em;">

<!-- ==================== Group Class List ================================= -->
        <%if(sSts.equals("Open")){%><u>Select Sku</u><%}%>
        <%for(int i=0; i < iNumOfGrp; i++){%>
            <table border=0 cellPadding="5" cellSpacing="0" id="tbl<%=sGrp[i]%>">
              <tr class="DataTable" id="trClsGrp<%=i%>"
                 <%if(!sSts.equals("Open")){%>style="display:none;"<%}%>>
                <%for(int k=0; k < iNumOfCls[i]; k++){%>
                   <td><a href="javascript: getSkuList('<%=sGrpCls[i][k]%>', '<%=sGrpClsNm[i][k]%>', '<%=sGrp[i]%>', '<%=sStr%>', document.all[&#34;tbl<%=sGrp[i]%>&#34;])"><%=sGrpClsNm[i][k]%></a></td>
                <%}%>
              </tr>
            </table>
        <%}%>

   <table border=3 cellPadding="0" cellSpacing="0">
     <tr class="DataTable4">
        <th class="DataTable1" rowspan=2>SKU</th>
        <th class="DataTable1" rowspan=2>ID#</th>
        <!-- th class="DataTable1">Vendor Name</th -->
        <th class="DataTable1" rowspan=2>Description</th>
        <th class="DataTable1" rowspan=2>U/M</th>
        <th class="DataTable1" rowspan=2>U/M<br>Qty</th>
        <th class="DataTable1" rowspan=2>In<br>Stock</th>
        <th class="DataTable1" rowspan=2>Order<br>Qty</th>
        <th class="DataTable1" colspan=2>Alloc: <span id="spnAlcDa"></span></th>
        <!-- th class="DataTable1">Other<br>Store<br>Orders</th -->
        <%if(sSts.equals("Open")){%>
           <th class="DataTable1" rowspan=2>Upd</th>
           <th class="DataTable1" rowspan=2>Dlt</th>
        <%}%>
     </tr>
     <tr class="DataTable4">
        <th class="DataTable1">Qty</th>
        <th class="DataTable1">Sts</th>
     </tr>
<!-- ==================== Group ============================================ -->
     <%for(int i=0; i < iNumOfGrp; i++){%>
        <%
          supord.setOrdDtl(sGrp[i]);
          int iNumOfDtl = supord.getNumOfDtl();
          String [] sSku = supord.getSku();
          String [] sOQty = supord.getOQty();
          String [] sSQty = supord.getSQty();
          String [] sRQty = supord.getRQty();
          String [] sDtlRecUs = supord.getDtlRecUs();
          String [] sDtlRecDt = supord.getDtlRecDt();
          String [] sDtlRecTm = supord.getDtlRecTm();
          String [] sCls = supord.getCls();
          String [] sVen = supord.getVen();
          String [] sSty = supord.getSty();
          String [] sClr = supord.getClr();
          String [] sSiz = supord.getSiz();
          String [] sDesc = supord.getDesc();
          String [] sVenSty = supord.getVenSty();
          String [] sVenNm = supord.getVenNm();
          String [] sInStock = supord.getInStock();
          String [] sOnOrd = supord.getOnOrd();
          String [] sUom = supord.getUom();
          String [] sMxQty = supord.getMxQty();
          String [] sOthStrOrd = supord.getOthStrOrd();
          String [] sAlloc = supord.getAlloc();
          String [] sAlcDa = supord.getAlcDa();
          String [] sAckn = supord.getAckn();
          String [] sAckDa = supord.getAckDa();
          String [] sAlcQty = supord.getAlcQty();
          String [] sPndSts = supord.getPndSts();
          String [] sAllocNum = supord.getAllocNum();
          %>
          <%for(int j=0; j < iNumOfDtl; j++){%>
                <tr class="DataTable1" id="tr<%=sGrp[i]%><%=j%>">
                   <td class="DataTable"><%=sSku[j]%></td>
                   <td class="DataTable"><%=sVenSty[j]%></td>
                   <!-- td class="DataTable"><%=sVenNm[j]%></td -->
                   <td class="DataTable"><%=sDesc[j]%></td>
                   <td class="DataTable"><%=sUom[j]%>&nbsp;</td>
                   <td class="DataTable1"><%=sMxQty[j]%></td>
                   <td class="DataTable1"><%=sInStock[j]%></td>
                   <!-- td class="DataTable1"><%=sOthStrOrd[j]%></td -->
                   <td class="DataTable1"><%=sOQty[j]%></td>
                   <td class="DataTable1">
                     <%if(sAlloc[j].equals("Y")){%><%=sAlcQty[j]%>
                     <%} else{%>&nbsp;<%}%>
                   </td>
                   <td class="DataTable">
                     <%if(sAlloc[j].equals("Y")){%>
                         <%if(!sAckn[j].equals("Y")){%><%=sPndSts[j]%><%}
                         else {%>Ackn as Received - <%=sAckDa[j]%><%}%>
                         <script language="javascript">
                           AlcDate = "<%=sAlcDa[j]%>";
                           AllocNum = "<%=sAllocNum[j]%>";
                           document.all.spnAlcDa.innerHTML = AllocNum + "<br>" + AlcDate;
                           <%if(sAckn[j].equals("Y")){%>AcknDate = "<%=sAlcDa[j]%>";<%}%>
                         </script>
                     <%} else{%>&nbsp;<%}%>
                   </td>

                   <%if(sSts.equals("Open")){%>
                      <td class="DataTable"><a href="javascript: updSku('<%=sSku[j]%>', '<%=sOQty[j]%>', '<%=sInStock[j]%>', '<%=sOnOrd[j]%>', '<%=sDesc[j]%>', '<%=sGrp[i]%>')">Upd</a></td>
                      <td class="DataTable"><a href="javascript: dltSku('<%=sSku[j]%>', '<%=sDesc[j]%>', '<%=sGrp[i]%>')">Dlt</a></td>
                   <%}%>
                </tr>
          <%}%>
          <script>NumOfDtl[<%=i%>] = "<%=iNumOfDtl%>"</script>
       <%}%>
         </table>
         </div>
        </td>
       </tr>

      </table>
     <td>
   </tr><!-- ================== End Group ========================================== -->
  </table>

  <span style="font-size:12px;"><br>
       <br><br><u><b>Item Allocation Statuses:</b></u>
         <br> &nbsp; &nbsp; -&nbsp; Ready to Pick:  The items are waiting to be "picked" from DC stock.
         <br> &nbsp; &nbsp; -&nbsp; Being Picked: The items are currently being "picked" and prepared for shipment in the DC.
         <br> &nbsp; &nbsp; -&nbsp; In-Transit: The item has been shipped to your store.
         <br> &nbsp; &nbsp; -&nbsp; Not Shipped:  The item ordered could not be fullfilled, re-ordered when inventory is available.
         <br> &nbsp; &nbsp; -&nbsp; Ackn as Received - The item  has been acknowledged as received at the store.
     </span>

  <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
 </body>
</html>


<%
  supord.disconnect();
  supord = null;
  }%>










