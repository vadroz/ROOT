<%@ page import="patiosales.WarrantyClaimInfo ,java.util.*, java.text.*"%>
<%
   String sSelOrder = request.getParameter("Order");
   String sSelClaim = request.getParameter("Claim");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=WarrantyClaimInfo.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sStrAllowed = session.getAttribute("STORE").toString();

      boolean bVenUpd = session.getAttribute("VENCARD")!=null;

      WarrantyClaimInfo wcinf = new WarrantyClaimInfo(sSelOrder, sSelClaim, sUser);

      String sErrMsg = wcinf.getErrMsg();
      String sOrder = wcinf.getOrder();
      String sCust = wcinf.getCust();
      String sStr = wcinf.getStr();
      String sDelDt = wcinf.getDelDt();
      String sSlsPer = wcinf.getSlsPer();
      String sSlsPerNm = wcinf.getSlsPerNm();
      String sAmount = wcinf.getAmount();

      int iNumOfCst = wcinf.getNumOfCst();
      String [] sCustProp = wcinf.getCustProp();
      String [] sCustPropTxt = wcinf.getCustPropTxt();
      String [] sCustValue = wcinf.getCustValue();

      String sClaim = wcinf.getClaim();
      String sClmSts = wcinf.getClmSts();
      String sClmStsDesc = wcinf.getClmStsDesc();
      String sOpnUsr = wcinf.getOpnUsr();
      String sOpnDt = wcinf.getOpnDt();
      String sOpnTm = wcinf.getOpnTm();
      String sResUsr = wcinf.getResUsr();
      String sResDt = wcinf.getResDt();
      String sResTm = wcinf.getResTm();

      String sStrNm = wcinf.getStrNm();
      String sStrAddr1 = wcinf.getStrAddr1();
      String sStrAddr2 = wcinf.getStrAddr2();
      String sStrCity = wcinf.getStrCity();
      String sStrState = wcinf.getStrState();
      String sStrZip = wcinf.getStrZip();
      String sStrPhone = wcinf.getStrPhone();
      int iNumOfPo = wcinf.getNumOfPo();
      String [] sPoNum = wcinf.getPoNum();

      int iNumOfItm = wcinf.getNumOfItm();
      String [] sItem = wcinf.getItem();
      String [] sSku = wcinf.getSku();
      String [] sQty = wcinf.getQty();
      String [] sRet = wcinf.getRet();
      String [] sSet = wcinf.getSet();
      String [] sDesc = wcinf.getDesc();
      String [] sVenSty = wcinf.getVenSty();
      String [] sVen = wcinf.getVen();
      String [] sVenNm = wcinf.getVenNm();
      String [] sClr = wcinf.getClr();
      String [] sClrNm = wcinf.getClrNm();

      String sItemJsa = wcinf.getItemJsa();
      String sSkuJsa = wcinf.getSkuJsa();
      String sVenJsa = wcinf.getVenJsa();
      String sVenNmJsa = wcinf.getVenNmJsa();
      String sVenStyJsa = wcinf.getVenStyJsa();

      String [] sClmQty = wcinf.getClmQty();
      String [] sItemIss = wcinf.getItemIss();
      String [] sItemIssDesc = wcinf.getItemIssDesc();
      String [] sAction = wcinf.getAction();
      String [] sActDesc = wcinf.getActDesc();
      String [] sItemSts = wcinf.getItemSts();
      String [] sItemStsDesc = wcinf.getItemStsDesc();
      String [] sRemoved = wcinf.getRemoved();
      String [] sFinal = wcinf.getFinal();
      String [] sFinalDesc = wcinf.getFinalDesc();
      String [] sItmPo = wcinf.getItmPo();
      String [] sEstShpDt = wcinf.getEstShpDt();

      int iNumOfIss = wcinf.getNumOfIss();
      String sItmIssJsa = wcinf.getItemIssJsa();
      String sItmIssDescJsa = wcinf.getItemIssDescJsa();

      int iNumOfAct = wcinf.getNumOfAct();
      String sItmActJsa = wcinf.getItemActJsa();
      String sItmActDescJsa = wcinf.getItemActDescJsa();

      int iNumOfFin = wcinf.getNumOfFin();
      String sItmFinJsa = wcinf.getItemFinJsa();
      String sItmFinDescJsa = wcinf.getItemFinDescJsa();

      int iNumOfItmSts = wcinf.getNumOfItmSts();
      String sItmStsActJsa = wcinf.getItemStsActJsa();
      String sItmStsJsa = wcinf.getItemStsJsa();
      String sItmStsDescJsa = wcinf.getItemStsDescJsa();

      int iNumOfSts = wcinf.getNumOfSts();
      String sClmStsJsa = wcinf.getClmStsJsa();
      String sClmStsDescJsa = wcinf.getClmStsDescJsa();

      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      String sToday = sdf.format(cal.getTime());
      sdf = new SimpleDateFormat("h:mm a");
      String sCurTime = sdf.format(cal.getTime());
%>

<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-left: black solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable3 { background:white;padding-top:3px; padding-bottom:3px;
                        text-align:left; ; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable4 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable6 { background: lightpink; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}

        td.DataTable3 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable31 { border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }
        input.Small1 {background:LemonChiffon; font-family:Arial; font-size:10px }
        input.Small2 {border:none; background:LemonChiffon; font-family:Arial;  font-size:10px }
        input.radio {border:none; font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

        #divCustInfo { text-align:center; border: ridge 2px lightgray;}
        #tblClaim { width: 100%; }

@media screen
{
   #thCmt { display:block; }
   #thPhoto { display:block; }
   #tdCmt { display:block; }
   #tdPhoto { display:block; }
   #thHassIssue { display:block; }
   #tdHassIssue { display:block; }
}
@media print
{
   #thCmt { display:none; }
   #thPhoto { display:none; }
   #tdCmt { display:none; }
   #tdPhoto { display:none; }
   #thHassIssue { display:none; }
   #tdHassIssue { display:none; }
   .NonPrt  { display:none; }

   button { display:none; }
}


</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
// orser header info
var Order = "<%=sSelOrder%>";
var Claim = "<%=sSelClaim%>";
var Cust = "<%=sCust%>";
var CurClmSts = "<%=sClmSts%>";
var EMailAddr = "<%=sCustValue[12]%>";
var Store = "<%=sStr%>";

var Item = [<%=sItemJsa%>];
var Sku = [<%=sSkuJsa%>];
var Ven = [<%=sVenJsa%>];
var VenNm = [<%=sVenNmJsa%>];
var VenSty = [<%=sVenStyJsa%>];

var ItemCmtArg = 0;
var ItemPicArg = 0;

// Issue, action Status Lists
var IssLst = [<%=sItmIssJsa%>];

// Status
var StsLst = [<%=sClmStsJsa%>];
var StsDescLst = [<%=sClmStsDescJsa%>];

var IssDescLst = [<%=sItmIssDescJsa%>];
var ItmActLst = [<%=sItmActJsa%>];
var ItmActDescLst = [<%=sItmActDescJsa%>];
var ItmStsActLst = [<%=sItmStsActJsa%>];
var ItmStsLst = [<%=sItmStsJsa%>];
var ItmStsDescLst = [<%=sItmStsDescJsa%>];
var ItmFinLst = [<%=sItmFinJsa%>];
var ItmFinDescLst = [<%=sItmFinDescJsa%>];

var ItemWithPic = new Array();
var PicPath = new Array();

var StrAllowed = "<%=sStrAllowed%>";

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus", "dvPhoto"]);

   // retreive claim comments
   if(Claim != "0000000000")
   {
      rtvClmComments();
      if(Item.length > 0)
      {
        rtvItemComments();
        rtvItemPictures();
      }
      getLogEntires();
   }

}
//==============================================================================
// OPen new claim
//==============================================================================
function openClaim()
{
   var url = "WarrantyClaimSave.jsp?"
     + "Order=" + Order
     + "&Action=OPEN_NEW_CLAIM"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// add claim comments
//==============================================================================
function addClmComment(id, text, action)
{
   var hdr = "Claim Comments";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popClaimCommentsPanel(id, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 40;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.visibility = "visible";

   if(text != null){document.all.Comm.value=text;}
   if(action == "DELETE"){document.all.Comm.readOnly=true;}
   document.all.CommId.value = id;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popClaimCommentsPanel(id, action)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<td class='Prompt' nowrap><textarea name='Comm' cols=170 rows=5></textarea>"
           + "<input name='CommId' type='hidden'>"
         + "</td>"
       + "</tr>"

  panel += "<tr>";
  if(action=="ADD")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;ADD_CLM_COMMENT&#34;)' class='Small'>Add Comments</button>&nbsp;"
  }
  else if(action=="UPDATE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;UPD_CLM_COMMENT&#34;)' class='Small'>Update Comments</button>&nbsp;"
  }
  else if(action=="DELETE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;DLT_CLM_COMMENT&#34;)' class='Small'>Delte Comments</button>&nbsp;"
  }

  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}


//==============================================================================
// change customer inforamtion
//==============================================================================
function chgCustInfo(lastnm, firstnm, addr1, addr2, addr3, city, state, zip, daytmPhone
         , ext, evtmPhone, cellPhone, email)
{
   var hdr = "Change Customer Information";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCustInfoPanel(lastnm, firstnm, addr1, addr2, addr3, city, state, zip, daytmPhone
         , ext, evtmPhone, cellPhone, email)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 40;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.visibility = "visible";

   document.all.FirstNm.value = firstnm;
   document.all.LastNm.value = lastnm;
   document.all.Addr1.value = addr1;
   document.all.Addr2.value = addr2;
   document.all.Addr3.value = addr3;
   document.all.City.value = city;
   document.all.State.value = state;
   document.all.Zip.value = zip;
   document.all.DayTmPhone.value = daytmPhone;
   document.all.DayTmPhoneExt.value = ext;
   document.all.EvTmPhone.value = evtmPhone;
   document.all.CellPhone.value = cellPhone;
   document.all.Email.value = email;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popCustInfoPanel(lastnm, firstnm, addr1, addr2, addr3, city, state, zip, daytmPhone
         , ext, evtmPhone, cellPhone, email)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt' nowrap>&nbsp;First Name</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='FirstNm' maxlength=50></td>"
       + "</tr>"
       + "<tr><td class='Prompt' nowrap> &nbsp; Last Name</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='LastNm' maxlength=50></td>"
       + "</tr>"
       + "<tr>"
            + "<td class='Prompt' nowrap>&nbsp; Address</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='Addr1' size=50 maxlength=50>"
       + "</tr>"
       + "<tr>"
            + "<td class='Prompt' nowrap>&nbsp; Line 2</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='Addr2' size=50  maxlength=50>"
       + "</tr>"
       + "<tr>"
            + "<td class='Prompt' nowrap>&nbsp; Line 3</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='Addr3' size=50 maxlength=50>"
       + "</tr>"
       + "<tr>"
            + "<td class='Prompt' nowrap>&nbsp;City</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='City' size=50 maxlength=50></td>"
       + "</tr>"
       + "<tr>"
            + " <td class='Prompt' nowrap> &nbsp; State</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='State' size=50 maxlength=50></td>"
       + "</tr>"
       + "<tr>"
            + " <td class='Prompt' nowrap> &nbsp; Zip</td>"
            + "<td class='Prompt' nowrap><input class='Small' name='Zip' size=10 maxlength=50></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>&nbsp;Day Time Phone</td>"
            + "<td class='Prompt' colspan=2 nowrap><input class='Small' name='DayTmPhone' maxlength=20> &nbsp; ext<input class='Small' name='DayTmPhoneExt' size=4 maxlength=12></td>"
       + "</tr>"
       + "<tr>"
            + "<td class='Prompt' nowrap> &nbsp; Evening Time Phone</td>"
            + "<td class='Prompt' colspan=2 nowrap><input class='Small' name='EvTmPhone' maxlength=20></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>&nbsp;Mobile Phone</td>"
            + "<td class='Prompt' colspan=2 nowrap><input class='Small' name='CellPhone' maxlength=20></td>"
       + "</tr>"
       + "<tr>"
            + " <td class='Prompt' nowrap> &nbsp; Email Address</td>"
            + "<td class='Prompt' colspan=2 nowrap><input class='Small' name='Email' maxlength=50></td>"
       + "</tr>"

      // ----- buttons ---------
      panel += "<tr>";
      panel += "<td class='Prompt1' colspan='4'><br><br><button onClick='ValidateCust()' class='Small'>Save</button>&nbsp;"
      panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
     panel += "</table>";
  return panel;
}
//==============================================================================
// Validate new customer information
//==============================================================================
function ValidateCust()
{
   var error = false;
   var msg = "";

   var firstnm = document.all.FirstNm.value.trim();
   var lastnm = document.all.LastNm.value.trim();
   var addr1 = document.all.Addr1.value.trim();
   var addr2 = document.all.Addr2.value.trim();
   var addr3 = document.all.Addr3.value.trim();
   var city = document.all.City.value.trim();
   var state = document.all.State.value.trim();
   var zip = document.all.Zip.value.trim();
   var dayphn = document.all.DayTmPhone.value.trim();
   var ext = document.all.DayTmPhoneExt.value.trim();
   var evphn = document.all.EvTmPhone.value.trim();
   var cell = document.all.CellPhone.value.trim();
   var email = document.all.Email.value.trim();

   if(firstnm == ""){ error=true; msg +="\nPlease enter First Name";}
   if(lastnm == ""){ error=true; msg +="\nPlease enter Last Name";}
   if(addr1 == "" && addr2 == "" && addr3 == ""){ error=true; msg +="\nPlease enter Address";}
   if(city == ""){ error=true; msg +="\nPlease enter City name";}
   if(state == ""){ error=true; msg +="\nPlease enter State";}
   if(zip == ""){ error=true; msg +="\nPlease enter Zip Code";}
   if(dayphn == "" && evphn=="" && cell==""){ error=true; msg +="\nPlease enter Phone Number";}

   if(error){ alert(msg); }
   else { sbmCustInfo(firstnm, lastnm, addr1, addr2, addr3, city, state, zip, dayphn, ext, evphn, cell, email ) }
}
//==============================================================================
// submit customer information
//==============================================================================
function sbmCustInfo(firstnm, lastnm, addr1, addr2, addr3, city, state, zip, dayphn, ext, evphn, cell, email )
{
   var url = "WarrantyClaimSave.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
     + "&Cust=" + Cust
     + "&FirstNm=" + firstnm.toUpperCase().replaceSpecChar()
     + "&LastNm=" + lastnm.toUpperCase().replaceSpecChar()
     + "&Addr1=" + addr1.toUpperCase().replaceSpecChar()
     + "&Addr2=" + addr2.toUpperCase().replaceSpecChar()
     + "&Addr3=" + addr3.toUpperCase().replaceSpecChar()
     + "&City=" + city.toUpperCase().replaceSpecChar()
     + "&State=" + state.toUpperCase().replaceSpecChar()
     + "&Zip=" + zip
     + "&DayPhn=" + dayphn
     + "&Ext=" + ext
     + "&EvPhn=" + evphn
     + "&Cell=" + cell
     + "&Email=" + email
     + "&Action=CHG_CUSTOMER_INFO"

   //alert(url)
   window.frame1.location.href = url;

}
//==============================================================================
// change status menu
//==============================================================================
function chgStatusMenu()
{
   var hdr = "Change Claim Status";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popChgStsPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 125;
   document.all.dvStatus.style.visibility = "visible";

   chkCurSelSts();
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popChgStsPanel()
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

  for(var i=0; i < StsLst.length; i++)
  {
     panel += "<tr><td class='Prompt' nowrap><input name='ClmSts' type='radio' value='" + StsLst[i] + "'></td>"
         + "<td class='Prompt' nowrap>" + StsDescLst[i] + "</td>"
       + "</tr>"
  }

  panel += "<tr>";
  panel += "<td class='Prompt1' colspan=2><br><br><button onClick='ValidateClmSts(&#34;CHG_CLM_STS&#34;)' class='Small'>Submit</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// populate dropdown menu for item issues
//==============================================================================
function chkCurSelSts()
{
   for(var i=0; i < StsLst.length; i++)
   {
      if(StsLst[i]==CurClmSts) { document.all.ClmSts[i].checked = true; }
   }
}
//==============================================================================
// populate Claim Status from dropdown menu
//==============================================================================
function setClmSts(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.ClmSts.value = ddmenu.options[i].value;
    }
}
//==============================================================================
// add item comments
//==============================================================================
function addItmComments(item, sku, id, text, action)
{
   var hdr = "SKU " + sku + " Comments";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popItemCommentsPanel(item, sku, id, text, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 40;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.visibility = "visible";

   if(text != null){document.all.Comm.value=text;}
   if(action == "DELETE"){document.all.Comm.readOnly=true;}
   document.all.CommId.value = id;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popItemCommentsPanel(item, sku, id, text, action)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<td class='Prompt' nowrap><textarea name='Comm' cols=170 rows=5></textarea>"
          + "<input name='CommId' type='hidden'>"
          + "</td>"
       + "</tr>"

  panel += "<tr>";
  //panel += "<td class='Prompt1'><br><br><button onClick='ValidateItemCommt(&#34;ADD_ITM_COMMENT&#34;, &#34;" + item + "&#34;)' class='Small'>Add Comments</button>&nbsp;"

  if(action=="ADD")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateItemCommt(&#34;ADD_ITM_COMMENT&#34;, &#34;" + item + "&#34;)' class='Small'>Add Comments</button>&nbsp;"
  }
  else if(action=="UPDATE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateItemCommt(&#34;UPD_ITM_COMMENT&#34;, &#34;" + item + "&#34;)' class='Small'>Update Comments</button>&nbsp;"
  }
  else if(action=="DELETE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateItemCommt(&#34;DLT_ITM_COMMENT&#34;, &#34;" + item + "&#34;)' class='Small'>Delte Comments</button>&nbsp;"
  }

  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// change claim item properties
//==============================================================================
function chgClaimItem(item, sku, ven, vennm, vensty, desc, qty, issue, clmqty, act, sts, removed, final_act)
{
   var hdr = "Add/Upd/Rmv Item on Claim";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popClaimItemPanel(item, sku, ven,vennm, vensty, desc, qty, issue, removed, final_act)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(eval(item) > "0000000000")
   {
      document.all.Qty.value = clmqty;
      document.all.ItmIss.value = issue;
      document.all.ItmAct.value = act;
      document.all.ItmSts.value = sts;
      document.all.ItmFin.value = final_act
   }
   popSelIss();
   popSelAct();
   popSelItmSts();
   popSelFin();
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popClaimItemPanel(item, sku, ven, vennm, vensty, desc, qty, issue, removed, final_act)
{

  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel +=
         "<tr><td class='Prompt'>Sku</td>"
            + "<td class='Prompt' nowrap><input class='Small2' name='Sku' value='" + sku + "' readonly>"
            + "<input type='hidden' name='Item' value='" + item + "'></td>"
       + "</tr>"

       + "<tr>"
         + "<td class='Prompt' nowrap>Vendor</td>"
         + "<td class='Prompt' colspan=2 nowrap><input class='Small2' name='Ven' size=5 value='" + ven + "' readonly>&nbsp;" + vennm
       + "</tr>"

       + "<tr>"
         + "<td class='Prompt' nowrap>Vendor Style</td>"
         + "<td class='Prompt' colspan=2 nowrap><input class='Small2' name='VenSty' size=15 value='" + vensty + "' readonly>"
       + "</tr>"

       + "<tr>"
         + "<td class='Prompt' nowrap>Description</td>"
         + "<td class='Prompt' colspan=2 style='color:brown; font-weight:bold'>" + desc + "</td>"
       + "</tr>"
       + "<tr>"
         + "<td class='Prompt' nowrap>Quantity</td>"
         + "<td class='Prompt' colspan=2 >" + qty + "</td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>Claim Q-ty</td>"
            + "<td class='Prompt' colspan=2 ><input class='Small1' name='Qty' size=5 maxsize=5 value='" + qty + "'></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>Issue Code</td>"
            + "<td class='Prompt'><input class='Small1' name='ItmIss' size=10 readonly></td>"
            + "<td class='Prompt'><select class='Small' name='selItmIss' onchange='setItmIss(this)'></select></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>Vendor Action</td>"
            + "<td class='Prompt'><input class='Small1' name='ItmAct' size=10 readOnly></td>"
            + "<td class='Prompt'><select class='Small' name='selItmAct' onchange='setItmAct(this)'></select></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>Current Status</td>"
            + "<td class='Prompt'><input class='Small1' name='ItmSts' size=10 readonly></td>"
            + "<td class='Prompt'><select class='Small' name='selItmSts' onchange='setItmSts(this)'></select></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>Return Authorization #</td>"
            + "<td class='Prompt' colspan=2 ><input class='Small1' name='RANum' size=20 maxsize=20 value=''></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>Final Action</td>"
            + "<td class='Prompt'><input class='Small1' name='ItmFin' size=10 readonly></td>"
            + "<td class='Prompt'><select class='Small' name='selItmFin' onchange='setFinAct(this)'></select></td>"
       + "</tr>"

       + "<tr><td class='Prompt' nowrap>Estimate Shipping Date</td>"
            + "<td class='Prompt' colspan=2>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;EstShpDt&#34;)'>&#60;</button>"
              + "<input class='Small' name='EstShpDt' type='text' size=10 maxlength=10 readonly>&nbsp;"
              + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;EstShpDt&#34;)'>&#62;</button>"
              + " &nbsp;&nbsp;&nbsp; "
              + "<a href='javascript:showCalendar(1, null, null, 650, 500, document.all.EstShpDt)' >"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
            + "</td>"
       + "</tr>"

      // ----- buttons ---------
      panel += "<tr>";
      // add
      if(issue == "") { panel += "<td class='Prompt1' colspan='3'><br><br><button onClick='ValidateItm(&#34;ADD_ITEM&#34;)' class='Small'>Add Issue</button>&nbsp;" }
      else if(removed != 'Y')
      {
         panel += "<td class='Prompt1' colspan='3'><br><br><button onClick='ValidateItm(&#34;UPD_ITEM&#34;)' class='Small'>Update Issue</button>&nbsp;"
         panel += " &nbsp;  &nbsp; &nbsp;<button onClick='ValidateItm(&#34;RMV_ITEM&#34;)' class='Small'>Remove Issue</button>&nbsp;"
      }
      else if(removed == 'Y')
      {
         panel += "<td class='Prompt1' colspan='3'><br><br><button onClick='ValidateItm(&#34;UPD_ITEM&#34;)' class='Small'>Reactivate Item</button>&nbsp;"
      }

      panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
     panel += "</table>";
  return panel;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date();
  if(button.value.trim()!=""){ date = new Date(button.value); }


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate dropdown menu for item issues
//==============================================================================
function popSelIss()
{
   document.all.selItmIss.options[0] = new Option("--- Select Item Issue ---", "");
   for(var i=0; i < IssLst.length; i++)
   {
      document.all.selItmIss.options[i+1] = new Option(IssLst[i] + " - " + IssDescLst[i] ,IssLst[i]);
   }
}
//==============================================================================
// populate Item Issue from dropdown menu
//==============================================================================
function setItmIss(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.ItmIss.value = ddmenu.options[i].value;
    }
}
//==============================================================================
// populate dropdown menu for vendor action
//==============================================================================
function popSelAct()
{
   document.all.selItmAct.options[0] = new Option("--- Select Action ---", "");
   for(var i=0; i < ItmActLst.length; i++)
   {
      document.all.selItmAct.options[i+1] = new Option(ItmActLst[i] + " - " + ItmActDescLst[i] ,ItmActLst[i]);
   }
}

//==============================================================================
// populate dropdown menu for vendor action
//==============================================================================
function popSelFin()
{
   document.all.selItmFin.options[0] = new Option("--- Select Final Action ---", "");
   for(var i=0; i < ItmFinLst.length; i++)
   {
      document.all.selItmFin.options[i+1] = new Option(ItmFinLst[i] + " - " + ItmFinDescLst[i] ,ItmFinLst[i]);
   }
}
//==============================================================================
// populate vendor Action from dropdown menu
//==============================================================================
function setItmAct(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.ItmAct.value = ddmenu.options[i].value;
      popSelItmSts();
      document.all.ItmSts.value = "";
    }
}
//==============================================================================
// populate final Action from dropdown menu
//==============================================================================
function setFinAct(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.ItmFin.value = ddmenu.options[i].value;
    }
}
//==============================================================================
// populate dropdown menu for item status
//==============================================================================
function popSelItmSts()
{
   document.all.selItmSts.options[0] = new Option("--- Select Item Status (action first) ---", "");
   var action = document.all.ItmAct.value;
   // populate only if action already selected
   if(action != "")
   {
      for(var i=0, j=1; i < ItmStsLst.length; i++)
      {
         if(ItmStsActLst[i] == action)
         {
            document.all.selItmSts.options[j++] = new Option(ItmStsLst[i] + " - " + ItmStsDescLst[i] ,ItmStsLst[i]);
         }
      }
   }
}
//==============================================================================
// populate vendor Action from dropdown menu
//==============================================================================
function setItmSts(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.ItmSts.value = ddmenu.options[i].value;
    }
}

//==============================================================================
// validate Item changes
//==============================================================================
function ValidateItm(action)
{
   var error = false;
   var msg = "";

   var item = document.all.Item.value.trim();
   var sku = document.all.Sku.value.trim();
   var ven = document.all.Ven.value.trim();
   var vensty = document.all.VenSty.value.trim();

   var qty = document.all.Qty.value.trim();
   var itmiss = document.all.ItmIss.value.trim();
   var itmact = document.all.ItmAct.value.trim();
   var itmsts = document.all.ItmSts.value.trim();
   var ranum = document.all.RANum.value.trim();
   var itmfin = document.all.ItmFin.value.trim();
   var estshpdt = document.all.EstShpDt.value.trim();

   if( isNaN(qty) ){ error = true; msg += "Quantity must be numeric."; }
   else if( eval(qty) <= 0 ){ error = true; msg += "Quantity must be greater than zero."; }

   if( itmiss == "" ){ error = true; msg += "Please select issue code."; }
   //if( itmact == "" ){ error = true; msg += "Please select action."; }
   //if( itmsts == "" ){ error = true; msg += "Please select status."; }
   //if( itmfin == "" && itmact != ""){ error = true; msg += "Please select final action required."; }

   if(error){ alert(msg); }
   else { sbmItmChg(item, sku, ven, vensty, qty, itmiss, itmact, itmsts, ranum, action, itmfin, estshpdt) }
}
//==============================================================================
// submit Item changes
//==============================================================================
function sbmItmChg(item, sku, ven, vensty, qty, itmiss, itmact, itmsts, ranum, action, itmfin, estshpdt)
{
   var url = "WarrantyClaimSave.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
     + "&Item=" + item
     + "&Sku=" + sku
     + "&Ven=" + ven
     + "&VenSty=" + vensty
     + "&Qty=" + qty
     + "&ItmIss=" + itmiss
     + "&ItmAct=" + itmact
     + "&ItmSts=" + itmsts
     + "&RANum=" + ranum
     + "&ItmFin=" + itmfin
     + "&EstShpDt=" + estshpdt
     + "&Action=" + action


   //alert(url)
   window.frame1.location.href = url;
   hidePanel()
}
//==============================================================================
// Retreive vendor information
//==============================================================================
function getVenInfo(ven)
{
   var url = "WarrantyClaimVen.jsp?Ven=" + ven
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// display Vendor Info
//==============================================================================
function showVenInfo(ven, venNm, acct, claimSbm, form, email, mainPhn, mainEmail, contact, contPhn1, contPhn2
      , contEmail, rep, repPhn1, repPhn2, repEmail, recUsr, recDt, recTm)
{
    var hdr = "Vendor Contact Information";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popVenInfoPanel(ven, venNm, acct, claimSbm, form
       , email, mainPhn, mainEmail, contact, contPhn1, contPhn2 , contEmail, rep, repPhn1,
       repPhn2, repEmail, recUsr, recDt, recTm)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvStatus.style.visibility = "visible";

 <%if(!bVenUpd){%>
   document.all.ClaimInfo.readOnly = true;
   document.all.MainPhn.readOnly = true;
   document.all.ClaimEMail.readOnly = true;
   document.all.Acct.readOnly = true;
   document.all.MainEMail.readOnly = true;
   document.all.ContName.readOnly = true;
   document.all.ContPhn1.readOnly = true;
   document.all.ContPhn2.readOnly = true;
   document.all.ContEMail.readOnly = true;
   document.all.RepName.readOnly = true;
   document.all.RepPhn1.readOnly = true;
   document.all.RepPhn2.readOnly = true;
   document.all.RepEMail.readOnly = true;
 <%}%>
}
//==============================================================================
// populate Vendor Info Panel
//==============================================================================
function popVenInfoPanel(ven, venNm, acct, claimSbm, form, email, mainPhn, mainEmail, contact, contPhn1
           , contPhn2 , contEmail, rep, repPhn1, repPhn2, repEmail, recUsr, recDt, recTm)
{
    var panel = "<table border=0 cellPadding='0' cellSpacing='0' id='tblVenInfo'>"
      + "<tr class='DataTable'>"
      + "<th class='DataTable4' nowrap colspan=5>Vendor: " + ven + " - " +  venNm
      + " <input name='Ven' type='hidden' value='" + ven + "'>"
      + "</th>"
     + "</tr>"

    + "<tr class='DataTable'><td class='DataTable' colspan=5>&nbsp;</td></tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable' nowrap>How to submit claim? &nbsp; </td>"
        + "<td class='DataTable' colspan=4><input name='ClaimInfo' class='Small' size=50 maxlength=50 value='" + claimSbm + "'></td>"
     + "</tr>"

     + "<tr class='DataTable'><td class='DataTable' colspan=5>&nbsp;</td></tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable' nowrap><%for(int i=0; i < 5; i++){%> &nbsp; <%}%>Claim Form</td>"
     if(form != "")
     {
        panel += "<td class='DataTable' nowrap><a href='PolicyAndForms/Form/" + form + ".pdf' target='_blank'>" + form + ".pdf</a>&nbsp;</td>"
     }
     else
     {
        panel += "<td class='DataTable' nowrap>&nbsp;</td>"
     }

     panel += "<th class='DataTable2' rowspan=3 nowrap>&nbsp;</th>"
        + "<td class='DataTable' nowrap>Main Phone:</td>"
        + "<td class='DataTable' nowrap><input name='MainPhn' class='Small' size=15 maxlength=15 value='" + mainPhn + "'>&nbsp;</td>"
     + "</tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable' nowrap><%for(int i=0; i < 5; i++){%> &nbsp; <%}%>Claim EMail:</td>"
        + "<td class='DataTable' nowrap><input name='ClaimEMail' class='Small' size=30 maxlength=30 value='" + email
           + "'><br><a href='javascript: setEMail(&#34;" + email + "&#34;);' >Send Message</a>&nbsp;</td>"
        + "<td class='DataTable' nowrap>Account Number:</td>"
        + "<td class='DataTable' nowrap><input name='Acct' class='Small' size=20 maxlength=20 value='" + acct + "'>&nbsp;</td>"
     + "</tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable' colspan=2>&nbsp;</td>"
        + "<td class='DataTable' nowrap>Main EMail:</td>"
        + "<td class='DataTable' nowrap><input name='MainEMail' class='Small' size=30 maxlength=30 value='" + mainEmail
            + "'><br><a href='javascript: setEMail(&#34;" + mainEmail + "&#34;);'>Send Message</a>&nbsp;</td>"
     + "</tr>"

     + "<tr class='DataTable1'><td class='DataTable' colspan=5>&nbsp;</td></tr>"
     + "<tr class='DataTable1'>"
        + "<td class='DataTable' nowrap><u>Contact Info:</u></td>"
        + "<td class='DataTable'><input name='ContName' class='Small' size=20 maxlength=20 value='" + contact + "'>&nbsp;</td>"
        + "<th class='DataTable2' rowspan=4 nowrap>&nbsp;</th>"
        + "<td class='DataTable' colspan=2 nowrap><u>Vendor Information Last Updated:</u></td>"
     + "</tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable'>&nbsp;</td>"
        + "<td class='DataTable'><input name='ContPhn1' class='Small' size=15 maxlength=15 value='" + contPhn1 + "'>&nbsp;</td>"
        + "<td class='DataTable' colspan=2>&nbsp;" + recUsr + " " + recDt + " " + recTm + "</td>"
     + "</tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable'>&nbsp;</td>"
        + "<td class='DataTable'><input name='ContPhn2' class='Small' size=15 maxlength=15 value='" + contPhn2 + "'>&nbsp;</td>"
        + "<td class='DataTable' colspan=2> &nbsp; </td>"
     + "</tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable'>&nbsp;</td>"
        + "<td class='DataTable'><input name='ContEMail' class='Small' size=30 maxlength=30 value='"
          + contEmail + "'><br><a href='javascript: setEMail(&#34;" + contEmail + "&#34;);'>Send Message</a>&nbsp;</td>"
        + "<td class='DataTable' colspan=2>&nbsp;</td>"
     + "</tr>"


     + "<tr class='DataTable1'><td class='DataTable' colspan=5>&nbsp;</td></tr>"
     + "<tr class='DataTable1'>"
        + "<td class='DataTable'><u>Rep Info:</u></td>"
        + "<td class='DataTable'><input name='RepName' class='Small' size=30 maxlength=30 value='" + rep + "'>&nbsp;</td>"
        + "<th class='DataTable2' rowspan=4 nowrap>&nbsp;</th>"
        + "<td class='DataTable' colspan=2>&nbsp;</td>"
     + "</tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable'>&nbsp;</td>"
        + "<td class='DataTable'><input name='RepPhn1' class='Small' size=15 maxlength=15 value='" + repPhn1 + "'> &nbsp;</td>"
        + "<td class='DataTable' colspan=2>&nbsp;</td>"
     + "</tr>"
     + "<tr class='DataTable1'>"
        + "<td class='DataTable'>&nbsp;</td>"
        + "<td class='DataTable'><input name='RepPhn2' class='Small' size=15 maxlength=15 value='" + repPhn2 + "'>&nbsp;</td>"
        + "<td class='DataTable' colspan=2>&nbsp;</td>"
     + "</tr>"

     + "<tr class='DataTable1'>"
        + "<td class='DataTable'>&nbsp;</td>"
        + "<td class='DataTable'><input name='RepEMail' class='Small' size=30 maxlength=30 value='" + repEmail
            + "'><br><a href='javascript: setEMail(&#34;" + repEmail + "&#34;);'>Send Message</a>&nbsp;</td>"
        + "<td class='DataTable' colspan=2>&nbsp;</td>"
     + "</tr>"

     + "<tr class='DataTable2'>"
        + "<td class='DataTable2' colspan=5>"
        <%if(bVenUpd){%>
           + "<button onClick='validateVenInfo();' class='Small'>Save</button> &nbsp;"
        <%}%>
           + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td>"
     + "</tr>"
     + "</table><br>"


   return panel;
}
//==============================================================================
// Add Claim comments
//==============================================================================
function validateVenInfo()
{
   var error = false;
   var msg = "";

   var ven = document.all.Ven.value.trim();

   var clminfo = document.all.ClaimInfo.value.trim();
   var clmemail = document.all.ClaimEMail.value.trim();
   if(clmemail != "" && !checkEmail(clmemail)){error=true; msg += "Please provide valid claim email address."}

   var mainphn = document.all.MainPhn.value.trim();
   var acct = document.all.Acct.value.trim();
   var mainemail = document.all.MainEMail.value.trim();
   if(mainemail != "" && !checkEmail(mainemail)){error=true; msg += "\nPlease provide valid main email address."}

   var contnm = document.all.ContName.value.trim();
   var contphn1 = document.all.ContPhn1.value.trim();
   var contphn2 = document.all.ContPhn2.value.trim();
   var contemail = document.all.ContEMail.value.trim();
   if(contemail != "" && !checkEmail(contemail)){error=true; msg += "\nPlease provide valid contact email address."}

   var repnm = document.all.RepName.value.trim();
   var repphn1 = document.all.RepPhn1.value.trim();
   var repphn2 = document.all.RepPhn2.value.trim();
   var repemail = document.all.RepEMail.value.trim();
   if(repemail != "" && !checkEmail(repemail)){error=true; msg += "\nPlease provide valid representative email address."}

   if(error){ alert(msg); }
   else { sbmVenInfo(ven, clminfo, clmemail, mainphn, mainemail,  acct, contnm, contphn1, contphn2, contemail
         , repnm, repphn1, repphn2, repemail); }
}
//==============================================================================
// check email
//==============================================================================
function sbmVenInfo(ven, clminfo, clmemail, mainphn, mainemail, acct, contnm, contphn1, contphn2, contemail
         , repnm, repphn1, repphn2, repemail)
{
   var url = "VendorInfoSave.jsp?"
     + "Ven=" + ven
     + "&ClmInfo=" + clminfo
     + "&ClmEMail=" + clmemail
     + "&MainPhn=" + mainphn
     + "&MainEMail=" + mainemail
     + "&Acct=" + acct
     + "&ContName=" + contnm
     + "&ContPhn1=" + contphn1
     + "&ContPhn2=" + contphn2
     + "&ContEMail=" + contemail
     + "&RepName=" + repnm
     + "&RepPhn1=" + repphn1
     + "&RepPhn2=" + repphn2
     + "&RepEMail=" + repemail

     + "&Action=CHG_VEN_INFO"

   //alert(url)
   window.frame1.location.href = url;
   hidePanel();
}
//==============================================================================
// show result of Vendor Information updates
//==============================================================================
function showVenInfoUpd(not_exists)
{
   if(not_exists) { alert("Vendor extended record is not exists.") }
}
//==============================================================================
// check email
//==============================================================================
function checkEmail(email)
{
   var good = true;
   var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
   if (!filter.test(email))
   {
     good = false;
   }
   return good;
}
//==============================================================================
// Add Claim comments
//==============================================================================
function ValidateClmCommt(action)
{
   var comm = document.all.Comm.value;
   comm = comm.replace(/\n\r?/g, '<br />');
   var commid = document.all.CommId.value;

   var commArr = new Array();
   for(var i=0, j=0, k=0, m=0, n=0; i < comm.length; i++)
   {
      if(comm.substring(i, i+1) == " "){ k++; }
      else { k=0; }

      if( m == 100 ) { j++;  m=0; }

      // no more than 1 blank
      if(k < 2 && n < 2)
      {
         commArr[j] += comm.substring(i, i+1);
         m++;
      }
   }

   // save first line of comments
   sbmNewComm(action, "0000000000", comm, commid);
}
//==============================================================================
// Add Item comments
//==============================================================================
function ValidateItemCommt(action, sku)
{
   var comm = document.all.Comm.value;
   comm = comm.replace(/\n\r?/g, '<br />');
   var commid = document.all.CommId.value;

   var commArr = new Array();
   for(var i=0, j=0, k=0, m=0, n=0; i < comm.length; i++)
   {
      if(comm.substring(i, i+1) == " "){ k++; }
      else { k=0; }

      if( m == 100 ) { j++;  m=0; }

      // no more than 1 blank
      if(k < 2 && n < 2)
      {
         commArr[j] += comm.substring(i, i+1);
         m++;
      }
   }

   // save first line of comments
   sbmNewComm(action, sku, comm, commid);
}
//==============================================================================
// refresh Claim
//==============================================================================
function sbmNewComm(action, sku, comment, commid)
{
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='WarrantyClaimSave.jsp'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Sku'>"
       + "<input class='Small' name='Claim'>"
       + "<input class='Small' name='CommId'>"
       + "<input class='Small' name='Comment'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Order.value = Order;
   window.frame1.document.all.Claim.value=Claim;
   window.frame1.document.all.Sku.value=sku;
   window.frame1.document.all.CommId.value=commid;
   window.frame1.document.all.Comment.value=comment;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
   hidePanel();
}
//==============================================================================
// validate claim status
//==============================================================================
function ValidateClmSts(action)
{
   var error = false;
   var msg = "";
   var clmsts = null;

   for(var i=0; i < document.all.ClmSts.length; i++)
   {
      if( document.all.ClmSts[i].checked ) { clmsts = document.all.ClmSts[i].value.trim(); break; }
   }

   if(error){ alert(msg); }
   else { sbmClmSts(clmsts, action) }
}
//==============================================================================
// submit claim status
//==============================================================================
function sbmClmSts(clmsts, action)
{
    var url = "WarrantyClaimSave.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
     + "&ClmSts=" + clmsts
     + "&Action=" + action

   //alert(url)
   window.frame1.location.href = url;
   hidePanel()
}
//==============================================================================
// refresh Claim
//==============================================================================
function refreshClaim(clm, ord)
{
   var url = "WarrantyClaimInfo.jsp?Order=" + ord + "&Claim=" + clm
   window.location.href = url;
}

//==============================================================================
// load claim photo
//==============================================================================
function loadPhoto(item)
{
   var html = ""
     + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
       + "<td class='BoxName' nowrap>Add Photo</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<form name='Upload'  method='post' enctype='multipart/form-data' action='WarrantyClaimLoad.jsp'>"
               + "<input type='File' name='Doc' class='Small1' size=50><br>"
               + "<input type='hidden' name='Order'>"
               + "<input type='hidden' name='Claim'>"
               + "<input type='hidden' name='Item' >"
               + "<input type='hidden' name='FileName'>"
           + "</form>"
           + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button> &nbsp; "
           + "<button name='Cancel' class='Small' onClick='hidePanel();'>Cancel</button>"
           + "</td></tr>"
     + "</table>"

  //alert(html)
  document.all.dvStatus.innerHTML=html;
  document.all.dvStatus.style.pixelLeft=document.documentElement.scrollLeft + 250;
  document.all.dvStatus.style.pixelTop=document.documentElement.scrollTop + 200;
  document.all.dvStatus.style.visibility="visible"

  document.Upload.Order.value = Order;
  document.Upload.Claim.value = Claim;
  document.Upload.Item.value = item;
  document.Upload.Doc.focus();
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// submit Upload
//==============================================================================
function sbmUpload()
{
  var error = false;
  var msg = "";
  var file = document.Upload.Doc.value.trim();
  document.Upload.FileName.value = file;
  if(file == "")
  {
     error = true;
     msg = "Please type full file path"
  }
  if (error) { alert(msg);}
  else
  {
    document.Upload.submit();
  }
}
//==============================================================================
// display help when mouse over row name
//==============================================================================
function displayHelp(text, obj)
{
   if(text != "")
   {
      var html = "<table><tr><td style='font-size:10px' nowrap>" + text + "</td></tr></table>"
      var pos = getObjPosition(obj);
      document.all.dvHelp.innerHTML = html;
      document.all.dvHelp.style.pixelLeft= pos[0] + 10;
      document.all.dvHelp.style.pixelTop= pos[1] - 5;
      document.all.dvHelp.style.visibility = "visible";
   }
}
//==============================================================================
// display help when mouse over row name
//==============================================================================
function hideHelp()
{
   document.all.dvHelp.style.visibility = "hidden";
}
//==============================================================================
// retreive claim comments
//==============================================================================
function rtvClmComments()
{
   var url = "WarrantyClaimComments.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
     + "&Action=GET_CLAIM_COMMENTS"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// set claim comments
//==============================================================================
function setClaimComments(numOfCmt)
{
   if(numOfCmt > 0)
   {
      var html = window.frame1.document.body.innerHTML;
      document.all.dvClmComments.innerHTML = html;
      //document.all.dvClmComments.style.pageBreakBefore = "always";
   }
   window.frame1.close();
}
//==============================================================================
// retreive claim comments
//==============================================================================
function rtvItemComments()
{
   var url = "WarrantyClaimComments.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
     + "&Action=GET_ITEM_COMMENTS"
     + "&Item=" + Item[ItemCmtArg]
     + "&Sku=" + Sku[ItemCmtArg]
     + "&Ven=" + Ven[ItemCmtArg]
     + "&VenNm=" + VenNm[ItemCmtArg]
     + "&VenSty=" + VenSty[ItemCmtArg];

     ItemCmtArg++;

   window.frame2.location.href = url;
}
//==============================================================================
// set claim comments
//==============================================================================
function setItemComments(numOfCmt)
{
   var html = "";
   if(numOfCmt > 0)
   {
      html = window.frame2.document.body.innerHTML;
      document.all.dvItmComments.innerHTML += "<br>" + html;
   }
   if( ItemCmtArg < Sku.length ) { rtvItemComments(); }
   else {   window.frame2.close(); }
}

//==============================================================================
// retreive item pictures
//==============================================================================
function rtvItemPictures()
{
   var url = "WarrantyClaimPictures.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
     + "&Action=GET_ITEM_Pictures"
     + "&Item=" + Item[ItemPicArg]
     + "&Sku=" + Sku[ItemPicArg]
     + "&Ven=" + Ven[ItemPicArg]
     + "&VenNm=" + VenNm[ItemPicArg]
     + "&VenSty=" + VenSty[ItemPicArg]
     ;
     ItemPicArg++;

   window.frame3.location.href = url;
}

//==============================================================================
// set Picture on page
//==============================================================================
function setPictures(item, sku, ven, vennm, vensty, pic)
{
   var html = "";
   if(pic.length > 0)
   {
      html = "<table border=1 id='tbl" + item + "Picture'><tr>";
      for(var i=0, j=0; i < pic.length; i++)
      {
         html += "<td>";
         path = "Warranty_Claims/" + pic[i];
         // only pictures
         if(path.toLowerCase().indexOf(".jpeg") >= 0 || path.toLowerCase().indexOf(".jpg") >= 0
            && path.toLowerCase().indexOf(".tiff") >= 0 || path.toLowerCase().indexOf(".gif") >= 0
            && path.toLowerCase().indexOf(".png") >= 0 || path.toLowerCase().indexOf(".bmp") >= 0
            && path.toLowerCase().indexOf(".svg") >= 0 || path.toLowerCase().indexOf(".vnd") >= 0
            && path.toLowerCase().indexOf(".prs") >= 0 || path.toLowerCase().indexOf(".mp") >= 0
            && path.toLowerCase().indexOf(".dv") >= 0 || path.toLowerCase().indexOf(".pw") >= 0)

         {
            html += "<img style='cursor:pointer;' src='" + path + "' width='100' height='100' alt='Click to Magnified'"
                 + " onclick='window.open(&#34;" + path + "&#34;)'"
                 + " />"
         }
         else
         {
             j++;
             html += "<a style='font-size:10px' href='" + path + "' target='_blank'>Document (" + j + ")</a><br>"
         }

         html += "<br><a class='Small' href='javascript: dltPicture(&#34;" + item + "&#34;,&#34;" + pic[i] + "&#34;)'>Delete</a> &nbsp; &nbsp;"

         html += "</td>";

         var maxPic = ItemWithPic.length;
         ItemWithPic[maxPic] = vensty[i];
         PicPath[maxPic] = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Warranty_Claims/" + pic[i];

      }

      html += "</td></tr></table>";
      document.all.dvItmPictures.innerHTML += html + "<br>&nbsp;";
   }
   if( ItemPicArg < Item.length ) { rtvItemPictures(); }

   window.frame3.close();
}
//==============================================================================
// scroll to Item comments
//==============================================================================
function showPicMenu(item, sku, ven, vennm, vensty, pic, obj)
{
   var hdr = "Picture Menu";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePhotoMenu();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPicMenuPanel(item, sku, ven, vennm, vensty, pic)
     + "</td></tr>"
   + "</table>"

   var pos = getObjPosition(obj);

   document.all.dvPhoto.innerHTML = html;
   document.all.dvPhoto.style.pixelLeft = pos[0] + 110;
   document.all.dvPhoto.style.pixelTop = pos[1] - 50;
   document.all.dvPhoto.style.visibility = "visible";

   //document.all.tblPicMenu.onmouseout = function() { hidePanel(); };
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function popPicMenuPanel(item, sku, ven, vennm, vensty, pic)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblPicMenu'>"
  panel += "<tr><td class='Prompt'>SKU: " + sku + " Style: " + vensty + "</td></tr>"
       + "<tr><td class='Prompt'><a href='" + pic + "' target='_blank'>Magnified</a></td></tr>"
       + "<tr><td class='Prompt'><a href='javascript: dltPicture(&#34;" + item + "&#34;,&#34;" + pic + "&#34;)'>Delete</a></td></tr>"
       + "<tr><td class='Prompt'>&nbsp;</td></tr>"
       + "<tr><td class='Prompt'><a href='javascript: hidePhotoMenu();'>Cancel</a></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePhotoMenu()
{
   document.all.dvPhoto.innerHTML = " ";
   document.all.dvPhoto.style.visibility = "hidden";
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function dltPicture(item, path)
{
   var url = "WarrantyClaimSave.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
     + "&Item=" + item
     + "&Path=" + path
     + "&Action=DLT_ITM_PICTURE"

   //alert(url)
   window.frame1.location.href = url;
   hidePanel();
}
//==============================================================================
// scroll to Item comments
//==============================================================================
function scrollToItemComm(sku)
{
   var name = "tbl" + sku + "Comments";
   var obj = document.all[name];
   var pos = getObjPosition(obj);
   window.scrollTo(0, pos[1]);
}
//==============================================================================
// scroll to Item picture
//==============================================================================
function scrollToItemPic(sku)
{
   var name = "tbl" + sku + "Picture";
   var obj = document.all[name];
   var pos = getObjPosition(obj);
   window.scrollTo(0, pos[1]);
}
//==============================================================================
// send email message
//==============================================================================
function setEMail(toEmail)
{
   var hdr = "Send Claim by E-Mail";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popEMailPanel()
     + "</td></tr>"
   + "</table>"


   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft=document.documentElement.scrollLeft + 250;
   document.all.dvStatus.style.pixelTop=document.documentElement.scrollTop + 200;
   document.all.dvStatus.style.visibility = "visible";

   document.all.ToAddr.value = toEmail;
   document.all.Subj.value = "Order " + Order + ", Claim " + Claim;
   document.all.Msg.value = "";
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function popEMailPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt'>E-Mail Address</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='ToAddr'></td></tr>"
       + "<tr><td class='Prompt'>Subject &nbsp;</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='Subj'></td></tr>"
       + "<tr><td class='Prompt'>Message &nbsp;</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='Msg'></td></tr>"
       + "<tr><td class='Prompt'>Include Claim Information</td></tr>"
         + "<tr><td class='Prompt'>"
            + "<input type='radio' name='Incl' value='Y' checked>Yes &nbsp;  &nbsp; "
            + "<input type='radio' size=50 name='Incl'  value='N'>No"
            + "</td></tr>"

       + "<tr><td class='Prompt1'>"
         + "<button class='Small' onclick='validateEMail()'>Send</button> &nbsp;"
         + "<button class='Small' onclick='hidePanel()'>Cancel</button> &nbsp;"
       + "</td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// validate email message properties
//==============================================================================
function validateEMail()
{
   var msg = "";
   var error = false;

   var toaddr = document.all.ToAddr.value.trim();
   if(toaddr ==""){error=true; msg="Please enter Email Address"; }

   var subj = document.all.Subj.value.trim();
   if(subj ==""){error=true; msg="Please enter Subject Address"}

   var body = document.all.Msg.value.trim();

   var incl = document.all.Incl[0].checked;

   if(body =="" && !incl){error=true; msg="Please enter message text or(and) include claim information."}

   if(error){ alert(msg); }
   else { sbmEMail(toaddr, subj, body, incl); }
}
//==============================================================================
// send email message
//==============================================================================
function sbmEMail(toaddr, subj, body, incl)
{
  var msg = "<style>"
      + " th.DataTable { background:white;padding-top:3px; padding-bottom:3px; text-align:left; font-family:Verdanda; font-size:12px }"
      + " tr.DataTable { background:white; font-family:Arial; font-size:10px } "
      + " tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }"
      + " td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}"
      + " td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}"
      + " td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}"
      + " #thCmt { display:none; }"
      + " #thPhoto { display:none; }"
      + " #tdCmt { display:none; }"
      + " #tdPhoto { display:none; }"
      + " #thHassIssue { display:none; }"
      + " #tdHassIssue { display:none; }"
      + " #tdSpan { display:none; }"
      + " button { display:none; }"
      + " #spnButton1 { display:none; }"
      + " #trButton2 { display:none; }"
      + " .NonPrt  { display:none; } "

  msg += "</style>";

  document.all.spnHdrImg.innerHTML = "Sun & Ski Patio";
  msg += " " + document.all.tblClaim.outerHTML
   //+ "<br>" + document.all.tblClaimPic.outerHTML;

  var nwelem = window.frame2.document.createElement("div");
  nwelem.id = "dvSbmCommt"

  var html = "<form name='frmSendEmail'"
       + " METHOD=Post ACTION='WarrantyClaimSendEMail.jsp'>"
       + "<input class='Small' name='MailAddr'>"
       + "<input class='Small' name='CCMailAddr'>"
       + "<input class='Small' name='FromMailAddr'>"
       + "<input class='Small' name='Subject'>"
       + "<input class='Small' name='Message'>"

   //ItemWithPic[ItemWithPic.length] = "patio_logos1.jpg"
   //PicPath[PicPath.length] = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/MainMenu/patio_logos1.jpg";   
    	          
   for(var i=0; i < ItemWithPic.length; i++)
   {
     html += "<input type='hidden' name='ItemAttach' value='" + ItemWithPic[i] + "'>"
     html += "<input type='hidden' name='PicAttach' value='" + PicPath[i] + "'>"     
   }
       
       
   html += "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame2.document.appendChild(nwelem);

   window.frame2.document.all.MailAddr.value = toaddr;

   // send on store mail account
   var ccmail = null;
   if(StrAllowed.indexOf("ALL") >= 0){ ccmail = "<%=sUser%>@sunandski.com"; }
   else { ccmail = "Store" + StrAllowed + "@sunandski.com"; }

   ccmail += ", kknight@sunandski.com";

   window.frame2.document.all.CCMailAddr.value = ccmail;

   var str = Store;
   if(Store.length==1){ str = "0" + Store; }
   var frAddr = "Store" + str + "@sunandski.com"
   window.frame2.document.all.FromMailAddr.value = frAddr;//"patioclaims@sunandski.com";
   window.frame2.document.all.Subject.value = subj;

   if(body != "" && incl)
   {
      msg = "<div style='color:blue; font-size:14px;'>" + body + "</div>"
          + "<br><hr /><br>" + msg;
   }
   else if(body != "" && !incl){ msg = body; }

   window.frame2.document.all.Message.value=msg;

   //alert(msg)
   window.frame2.document.frmSendEmail.submit();
   hidePanel();

   sbmNewComm("MESSAGE_SENT", "0000000000", "E-mail message was sent to " + toaddr);
}
//==============================================================================
// show Log Entries
//==============================================================================
function getLogEntires()
{
   var url = "WarrantyClaimLog.jsp?"
     + "Order=" + Order
     + "&Claim=" + Claim
   //alert(url)
   window.frame4.location.href = url;
}
//==============================================================================
// show Log Entries
//==============================================================================
function showLogEntires(html)
{
   document.all.tblClaimLog.style.pageBreakBefore = "always";
   document.all.dvLog.innerHTML = html;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<title>Warranty Claim Entry</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame3"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame4"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<div id="dvPhoto" class="dvStatus"></div>
<div id="dvHelp" class="dvHelp"></div>
<!-------------------------------------------------------------------->
   <table border="0" cellPadding="0"  cellSpacing="0" id="tblClaim">
     <tr>
      <td ALIGN="left" VALIGN="TOP" nowrap>
         <b><font size="-1">
            Store: <%=sStr%><br>
            User: <%=sUser%><br>
            <%if(!sClaim.equals("000000000"))%>Claim: <%=sClaim%>
            </font></b>
      </td>

      <td ALIGN="center" VALIGN="TOP"nowrap>
      Patio Furniture Warranty Claim Entry
      <br><span id="spnHdrImg"><img src="MainMenu/patio_logos1.jpg" height="50px" alt="Sun and Ski Patio"></span>
      <br>

<!-- allow to continue only if no errors -->
<%if(sErrMsg.equals("")){%>

      <%if(sSelClaim.equals("0000000000")){%><button class="Small" onClick="openClaim();">Open Claim</button><%}
        else {%>
            <button class="Small" onClick="chgStatusMenu();">Change</button>
      <%}%>



      Status: <span style="background:yellow"><%if(sSelClaim.equals("0000000000")){%>New<%} else {%><%=sClmStsDesc%><%}%></span>
      </b></td>

      <td ALIGN="right" VALIGN="TOP" nowrap>
         <b><font size="-1">Date: <%=sToday%>
         <br>Time: <%=sCurTime%>
         <br>Order: <%=sOrder%>
         <br>P.O.#: <%String sComa="";
           for(int i=0; i < iNumOfPo; i++){%><%=sComa%><a href="POWorksheet.jsp?PO=<%=sPoNum[i]%>" target="_balnk"><%=sPoNum[i]%></a><%sComa=", ";}%>
         </font></b></td>
      </tr>

    <tr class="NonPrt">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="WarrantyClaimInfoSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
        &nbsp;&nbsp;&nbsp;
      </td>
    </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table border=0 cellPadding="0" cellSpacing="0">
     <tr  class="DataTable">
        <td class="DataTable" nowrap> &nbsp; &nbsp; &nbsp; Salesperson <%=sSlsPer%> <%=sSlsPerNm%></td>
        <td class="DataTable" nowrap> &nbsp; &nbsp; &nbsp; Sale Date: <%=sDelDt%> &nbsp;&nbsp;&nbsp;&nbsp;
        <td class="DataTable"> &nbsp; &nbsp; Store: <%=sStr%>, <%=sStrNm%>, <%=sStrAddr1%> <%=sStrAddr2%>, <%=sStrCity%>, <%=sStrState%>, <%=sStrZip%>, Phone: <%=sStrPhone%></td>
     </tr>
   </table>
 <!----------------------- end of table ------------------------>
     </td>
   </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
  <!----------------------- Customer Data ------------------------------>
      <div id="divCustInfo" style="width:100%;">
       <table border=0 cellPadding="0" cellSpacing="0" id="tbCustInfo" width="100%">
         <tr><td style="text-align:left; vertical-align:top; padding-left:10px; padding-top:10px; width: 30%;">
                 <%if(!sSelClaim.equals("0000000000")){%>
                     <button class="Small" onClick="chgCustInfo('<%=sCustValue[0]%>', '<%=sCustValue[1]%>', '<%=sCustValue[2]%>'
                       , '<%=sCustValue[3]%>', '<%=sCustValue[4]%>', '<%=sCustValue[5]%>', '<%=sCustValue[6]%>'
                       , '<%=sCustValue[7]%>', '<%=sCustValue[8]%>', '<%=sCustValue[9]%>', '<%=sCustValue[10]%>'
                       , '<%=sCustValue[11]%>', '<%=sCustValue[12]%>');">Change Customer Info</button> &nbsp;
                 <%}%>
              </td>
         <td>

         <table border=0 cellPadding="0" cellSpacing="0" id="tbCustInfo">
           <tr class="DataTable">

              <td class="DataTable" nowrap>Last, First Name</td><th class="DataTable" nowrap colspan=2><%=sCustValue[0]%>, <%=sCustValue[1]%></th>
           </tr>
           <tr class="DataTable">
              <td class="DataTable" nowrap>Address</td><th class="DataTable" nowrap colspan=2><%=sCustValue[2]%></th>
           </tr>
           <%if(!sCustValue[3].equals("")){%>
              <tr class="DataTable">
                 <td class="DataTable" nowrap>&nbsp;</td><th class="DataTable" nowrap colspan=2><%=sCustValue[3]%></th>
              </tr>
           <%}%>
           <%if(!sCustValue[4].equals("")){%>
              <tr class="DataTable">
                 <td class="DataTable" nowrap>&nbsp;</td><th class="DataTable" nowrap colspan=2><%=sCustValue[4]%></th>
              </tr>
           <%}%>
           <tr class="DataTable">
              <td class="DataTable" nowrap>City, State, Zip</td>
              <th class="DataTable" nowrap><%=sCustValue[5]%>, <%=sCustValue[6]%>, <%=sCustValue[7]%></th>
           </tr>
           <tr class="DataTable">
               <td class="DataTable" nowrap>Day Time Phone</td><th class="DataTable" nowrap><%=sCustValue[8]%>
               <%if(!sCustValue[9].equals("")){%>ext. <%=sCustValue[9]%><%}%></th>
               <td class="DataTable" nowrap>Evening Time Phone</td><th class="DataTable" nowrap><%=sCustValue[10]%></th>
           </tr>
           <tr class="DataTable">
              <td class="DataTable" nowrap>Mobile Phone</td><th class="DataTable" nowrap><%=sCustValue[11]%></th>
              <td class="DataTable" nowrap>E-Mail Address</td><th class="DataTable" nowrap><%=sCustValue[12]%></th>
           </tr>
         </table>
         <td style="text-align:right; vertical-align:top; padding-right:10px; padding-top:10px; width: 20%;">
                 <%if(!sSelClaim.equals("0000000000")){%>
                     &nbsp; <button class="Small" onClick="setEMail(&#34;<%=sCustValue[12]%>&#34;);">Email to Customer</button>
                 <%}%>
         </td>
         </table>
       </div>

         <p>&nbsp;
         <%if(!sSelClaim.equals("0000000000")){%>
           <span id="spnButton1">
             <button class="Small" onClick="addClmComment(0,null,'ADD');">Add Claim Comments</button> &nbsp;
           </span>
         <%}%>
      </td>
    </tr>

    <!----------------------- Claim Comments ------------------------>
    <tr>
      <td colspan=3 align=left><br><div id="dvClmComments" style="width:100%;"></div>
      </td>
    </tr>
    <!----------------------- Purchased Item List ----------------------------->
    <tr>
      <td colspan=3> &nbsp;<br>
         <table border=1 cellPadding="0" cellSpacing="0"  width="100%">
           <tr class="DataTable">
              <th class="DataTable4" <%if(!sClaim.equals("0000000000")){%>rowspan=2<%}%> nowrap>Short SKU</th>
              <th class="DataTable3" <%if(!sClaim.equals("0000000000")){%>rowspan=2<%}%> nowrap><span style="font-size:10px;">1st Line:&nbsp;</span> &nbsp; Vendor Style<br><span style="font-size:10px;">2nd Line:</span> &nbsp; Vendor Name</th>
              <th class="DataTable3" <%if(!sClaim.equals("0000000000")){%>rowspan=2<%}%> nowrap><span style="font-size:10px;">1st Line:&nbsp;</span> &nbsp; Description<br><span style="font-size:10px;">2nd Line:</span> &nbsp; Color</th>
              <th class="DataTable3" <%if(!sClaim.equals("0000000000")){%>rowspan=2<%}%> nowrap>Total<br>Qty</th>
              <th class="DataTable3" <%if(!sClaim.equals("0000000000")){%>rowspan=2<%}%> nowrap>Total<br>Price</th>
              <%if(!sClaim.equals("0000000000")){%>
                 <th class="DataTable" rowspan=2  nowrap>&nbsp;</th>
                 <th class="DataTable4" rowspan=2 id="thHassIssue" nowrap>Issue</th>
                 <th class="DataTable4" rowspan=2 nowrap>Description</th>
                 <th class="DataTable4" rowspan=2 nowrap>Qty</th>
                 <th class="DataTable3" rowspan=2 nowrap><span style="font-size:10px;">1st Line:&nbsp;</span> &nbsp;Vendor Action<br><span style="font-size:10px;">2nd Line:</span> &nbsp;Current Status</th>
                 <th class="DataTable4" rowspan=2 id="thCmt" nowrap>Estimate<br>Ship<br>Date</th>
                 <th class="DataTable4" rowspan=2 nowrap>Final<br>Action</th>
                 <th class="DataTable4" colspan=2 id="thCmt" nowrap>Comments</th>
                 <th class="DataTable4" colspan=2 id="thCmt" nowrap>Photo</th>
              <%}%>
           </tr>
           <%if(!sClaim.equals("0000000000")){%>
             <tr class="DataTable">
               <th class="DataTable4" id="thCmt" nowrap>Add<br><img src="Comments_Img1.bmp" width="15" height="20" alt="Add Comments" /></th>
               <th class="DataTable4" id="thCmt" nowrap>Show<br><img src="Comments_Img1.bmp" width="15" height="20" alt="Show Comments" /></th>
               <th class="DataTable4" id="thPhoto" nowrap>Add<br><img src="Camera_Img.jpg" width="40" height="25" alt="Photo"/></th>
               <th class="DataTable4" id="thPhoto" nowrap>Show<br><img src="Camera_Img.jpg" width="40" height="25" alt="Show Photo"/></th>
             </tr>
           <%}%>

           <%String sCss1="";%>
           <%for(int i=0; i < iNumOfItm; i++){%>
              <tr class="DataTable<%=sCss1%>">
                 <td class="DataTable" onmouseover="displayHelp('P.O# <%=sItmPo[i]%>', this)" onmouseout="hideHelp()" rowspan=2 nowrap>
                    <%if(sSet[i].equals("2")){%> &nbsp; &nbsp; <%}%>
                    <%=sSku[i]%>
                    <%if(sSet[i].equals("1")){%><span style="color=red;">(Set)</span><%}%>
                 </td>
                 <td class="DataTable" nowrap><%=sVenSty[i]%></td>
                 <td class="DataTable" nowrap><%=sDesc[i]%></td>
                 <td class="DataTable" rowspan=2 nowrap><%=sQty[i]%></td>
                 <td class="DataTable" rowspan=2 nowrap>&nbsp;<%if(!sSet[i].equals("2")){%><%=sRet[i]%><%}%></td>
                 <%if(!sClaim.equals("0000000000") && !sSet[i].equals("1")){%>
                    <th class="DataTable" rowspan=2 nowrap>&nbsp;</th>
                    <td class="DataTable2" onmouseover="displayHelp('Add / Update / Remove', this)" onmouseout="hideHelp()" rowspan=2 id="tdHassIssue" nowrap>
                         <a href="javascript: chgClaimItem('<%=sItem[i]%>', '<%=sSku[i]%>', '<%=sVen[i]%>', '<%=sVenNm[i]%>', '<%=sVenSty[i]%>', '<%=wcinf.showSpecChar(sDesc[i])%>', '<%=sQty[i]%>', '<%=sItemIss[i]%>'
                             , '<%=sClmQty[i]%>', '<%=sAction[i]%>', '<%=sItemSts[i]%>', '<%=sRemoved[i]%>', '<%=sFinal[i]%>')">A/U/R</a>
                    </td>
                    <td class="DataTable" rowspan=2 style="text-decoration:<%if(sRemoved[i].equals("Y")){%>line-through<%} else{%>none<%}%>;" >
                           <%=sItemIssDesc[i]%>&nbsp;
                    </td>
                    <td class="DataTable2" rowspan=2 nowrap>&nbsp;<%=sClmQty[i]%></td>
                    <td class="DataTable" style="text-decoration:<%if(sRemoved[i].equals("Y")){%>line-through<%} else{%>none<%}%>;"><%=sActDesc[i]%>&nbsp;</td>
                    <td class="DataTable" rowspan=2 nowrap><%if(!sEstShpDt[i].equals("01/01/0001")){%><%=sEstShpDt[i]%><%} else{%>&nbsp;<%}%></td>
                    <td class="DataTable2" rowspan=2><%=sFinalDesc[i]%>&nbsp;</td>
                    <td class="DataTable2" rowspan=2 nowrap id="tdCmt"><%if(!sClmQty[i].equals("")){%><a href="javascript: addItmComments('<%=sItem[i]%>', '<%=sSku[i]%>', 0,null,'ADD')">Add</a><%}%>&nbsp;</td>
                    <td class="DataTable2" rowspan=2 nowrap id="tdCmt"><%if(!sClmQty[i].equals("")){%><a href="javascript: scrollToItemComm('<%=sItem[i]%>', '<%=sSku[i]%>')"><img style="border:none;"  src="Comments_Img1.bmp" width="15" height="20" alt="Show Comments" /></a><%}%>&nbsp;</td>

                    <td class="DataTable2" rowspan=2 nowrap id="tdPhoto"><%if(!sClmQty[i].equals("")){%><a href="javascript: loadPhoto('<%=sItem[i]%>')">Add</a><%}%>&nbsp;</td>
                    <td class="DataTable2" rowspan=2 nowrap id="tdPhoto"><%if(!sClmQty[i].equals("")){%><a href="javascript:scrollToItemPic('<%=sItem[i]%>', '<%=sSku[i]%>')"><img style="border:none;"  src="Camera_Img.jpg"  width="40" height="25" alt="Add Photo" /></a><%}%>&nbsp;</td>
                 <%}%>
                 <%if(!sClaim.equals("0000000000") && sSet[i].equals("1")){%>
                      <th class="DataTable" rowspan=2 nowrap>&nbsp;</th>
                      <td class="DataTable" rowspan=2 colspan=10 id="tdSpan">&nbsp;</td>
                 <%}%>
               </tr>
               <!-- Line 2 -->
               <tr class="DataTable<%=sCss1%>">
                 <td class="DataTable" nowrap><a href="javascript: getVenInfo('<%=sVen[i]%>', '<%=sVenNm[i]%>')"><%=sVen[i]%> - <%=sVenNm[i]%></a></td>
                 <td class="DataTable" nowrap><%=sClrNm[i]%>&nbsp;</td>
                 <%if(!sClaim.equals("0000000000") && !sSet[i].equals("1")){%>
                    <td class="DataTable" style="text-decoration:<%if(sRemoved[i].equals("Y")){%>line-through<%} else{%>none<%}%>;"><%=sItemStsDesc[i]%> &nbsp;
                      <%if(!sEstShpDt[i].equals("01/01/0001")){%><%=sEstShpDt[i]%><%}%></td>
                 <%}%>
              </tr>
              <%if(sCss1.equals("")) { sCss1="1"; } else { sCss1=""; }%>
           <%}%>
         </table>
      </td>
    </tr>
    <!----------------------- end of table ------------------------>

    <!----------------------- Item Comments ------------------------>
    <tr>
      <td colspan=3 align=left><br><div id="dvItmComments" style="width:100%;"></div>
      </td>
    </tr>
    </table>
    <!----------------------- Item Pictures ------------------------>
    <table border=0 cellPadding="0"  cellSpacing="0" id="tblClaimPic">
        <tr id="trItmPic">
           <td colspan=3 align=left><br><div id="dvItmPictures" style="width:100%;"></div>
        </td>
    </tr>
   </table>

   <!----------------------- Item Pictures ------------------------>
    <table border=0 cellPadding="0"  cellSpacing="0" id="tblClaimLog">
        <tr>
           <td><br><div id="dvLog" style="width:100%;"></div>
        </td>
    </tr>
<%}
else{%><div style="border: red solid 1px; background:lightgreen; font-size:16px; width:200; height:100;"><%=sErrMsg%></div><%}%>
   </table>

 </body>
</html>
<%
  wcinf.disconnect();
  wcinf = null;
}
%>






