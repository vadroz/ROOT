<%@ page import="rtvregister.MrVendList"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("MRVENDCHG") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MrVendList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sVendor = request.getParameter("Vendor");
      String sSearch = request.getParameter("Search");

      if(sVendor==null) sVendor = "0";
      if(sSearch==null) sSearch = " ";

      //System.out.print(sVendor + " " + sSearch);
      MrVendList mrvlst = new MrVendList(sVendor, sSearch);

      int iNumOfVen = mrvlst.getNumOfVen();
      String [] sVen = mrvlst.getVen();
      String [] sVenName = mrvlst.getVenName();

      String [] sCstCont = mrvlst.getCstCont();
      String [] sCstAddr = mrvlst.getCstAddr();
      String [] sCstPhone = mrvlst.getCstPhone();
      String [] sCstWeb = mrvlst.getCstWeb();
      String [] sCstEMail = mrvlst.getCstEMail();
      String [] sCstIns = mrvlst.getCstIns();

      String [] sRciCont = mrvlst.getRciCont();
      String [] sRciAddr = mrvlst.getRciAddr();
      String [] sRciPhone = mrvlst.getRciPhone();
      String [] sRciWeb = mrvlst.getRciWeb();
      String [] sRciEMail = mrvlst.getRciEMail();
      String [] sRciIns = mrvlst.getRciIns();

      String [] sAllowRate = mrvlst.getAllowRate();
      String [] sSigned = mrvlst.getSigned();
      String [] sPrtName = mrvlst.getPrtName();
      String [] sTitle = mrvlst.getTitle();
      String [] sSignDate = mrvlst.getSignDate();
      String [] sDoc = mrvlst.getDoc();
      String [] sFileExt = mrvlst.getFileExt();

      String [] sCrtDate = mrvlst.getCrtDate();
      String [] sCrtTime = mrvlst.getCrtTime();
      String [] sCrtUser = mrvlst.getCrtUser();
      String [] sLstDate = mrvlst.getLstDate();
      String [] sLstTime = mrvlst.getLstTime();
      String [] sLstUser = mrvlst.getLstUser();

      String [] sAcct = mrvlst.getAcct();
      String [] sCoop = mrvlst.getCoop();
      String [] sCoopPrc = mrvlst.getCoopPrc();
      String [] sFrgAlw = mrvlst.getFrgAlw();
      String [] sFrgAlwPrc = mrvlst.getFrgAlwPrc();
      String [] sPreTick = mrvlst.getPreTick();
      String [] sSupTick = mrvlst.getSupTick();

      boolean bMoreRec = mrvlst.getMoreRec();

      mrvlst.disconnect();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: #b5eaaa; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space: nowrap;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space: nowrap;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap;}

        td.DataTable3 { cursor:hand; color:blue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap; text-decoration: underline;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:left;
                   font-family:Arial; font-size:10px; }


</style>


<script name="javascript1.2">
var User = "<%=session.getAttribute("USER").toString()%>";

var Vendor = "<%=sVendor%>";
var Search = "<%=sSearch%>";

var LastVendor = new Array();
<%if(iNumOfVen > 0){%>LastVendor = <%=sVen[iNumOfVen-1]%><%}%>

var SelRow = 0;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt", "dvUpload"]);
}
//==============================================================================
// new Search
//==============================================================================
function newSearch()
{
   var ven = document.all.Vendor.value
   if(isNaN(ven) || ven.trim()=="") ven = 0;
   var vennm = document.all.Search.value;
   if(vennm.trim()=="") vennm = " ";

   var url = 'MrVendList.jsp?'
    + "Vendor=" + ven
    + "&Search=" + vennm

   //alert(url);
   window.location.href = url;
}
//==============================================================================
// show next page
//==============================================================================
function showMoreRec()
{
   var url = 'MrVendList.jsp?'
    + "Vendor=" + LastVendor
    + "&Search=" + Search;

   //alert(url);
   window.location.href = url;
}

//---------------------------------------------------------
// show Vendor for update
//---------------------------------------------------------
function showVend(ven, vennm, doc, fileext, rate, sign, prtname, title, signdate,
                  acct, coop, coopprc, frgalw, frgalwprc, pretk, suptk, num)
{

  rtvVend(ven);

  var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Update Vendor: " + ven + " - " + vennm + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"


      + "<tr>"
       + "<td class='DataTable' colspan='2' nowrap>"

        + "<table border='1'  width='100%' cellPadding='0' cellSpacing='0'>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Vendor Name: </td>"
           + "<td class='DataTable1' nowrap>"
             + "<input name='VenName' class='Small' maxlength=25 size=30 value='" + vennm + "'></td>"
           + "<td class='DataTable2' nowrap>Allow Rate: </td>"
           + "<td class='DataTable1' nowrap>"
             + "<input name='AlwRate' class='Small' maxlength=7 size=7 value='" + rate + "'></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Signed by:  </td>"
           + "<td class='DataTable1' nowrap>"
             + "<input name='Signed' class='Small' maxlength=25 size=25 value='" + sign + "'></td>"
           + "<td class='DataTable2' nowrap>Print Name: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<input name='PrtName' class='Small' maxlength=25 size=25 value='" + prtname + "'></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Title: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<input name='Title' class='Small' maxlength=25 size=25 value='" + title + "'></td>"
           + "<td class='DataTable2' nowrap>Signed Date: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<input name='SignDate' class='Small' maxlength=25 size=25 value='" + signdate + "'>"
           + "<input name='Doc' type='hidden' class='Small' value='" + doc + "'>"
           + "<input name='FileExt' type='hidden' class='Small' value='" + fileext + "'></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>RCI Account: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<input name='Acct' class='Small' maxlength=20 size=20 value='" + acct + "'></td>"
           + "<td class='DataTable2' nowrap>&nbsp;</td>"
           + "<td class='DataTable1' nowrap>&nbsp;</td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Co-op?: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<select name='Coop' class='Small'><option value='N'>N</option><option value='Y'>Y</option></select></td>"
           + "<td class='DataTable2' nowrap>Coop %: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<input name='CoopPrc' class='Small' maxlength=20 size=20 value='" + coopprc + "'></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Freght Allowance?: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<select name='FrgAlw' class='Small'><option value='N'>N</option><option value='Y'>Y</option></select></td>"
           + "<td class='DataTable2' nowrap>Freght Allowance %: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<input name='FrgAlwPrc' class='Small' maxlength=20 size=20 value='" + frgalwprc + "'></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Pre-ticketing by vendor?: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<select name='PreTick' class='Small'><option value='N'>N</option><option value='Y'>Y</option></select></td>"
           + "<td class='DataTable2' nowrap>RCI to suply tickets?: </td>"
           + "<td class='DataTable1' nowrap>"
           + "<select name='SupTick' class='Small'><option value='N'>N</option><option value='Y'>Y</option></select></td>"
         + "</tr>"

        + "<tr class='DataTable1'>"
           + "<th class='DataTable' colspan='2'>Return by Customer: </th>"
           + "<th class='DataTable' colspan='2'>Return by RCI: </th>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Contact Name: </td>"
           + "<td class='DataTable1' nowrap><input name='CstCont' class='Small' maxlength=50 size=25></td>"
           + "<td class='DataTable2' nowrap>Contact Name: </td>"
           + "<td class='DataTable1' nowrap><input name='RciCont' class='Small' maxlength=50 size=25></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Phone: </td>"
           + "<td class='DataTable1' nowrap><input name='CstPhone' class='Small' maxlength=50 size=25></td>"
           + "<td class='DataTable2' nowrap>Phone: </td>"
           + "<td class='DataTable1' nowrap><input name='RciPhone' class='Small' maxlength=50 size=25></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Web: </td>"
           + "<td class='DataTable1' nowrap><input name='CstWeb' class='Small' maxlength=50 size=25></td>"
           + "<td class='DataTable2' nowrap>Web: </td>"
           + "<td class='DataTable1' nowrap><input name='RciWeb' class='Small' maxlength=50 size=25></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>e-Mail: </td>"
           + "<td class='DataTable1' nowrap><input name='CstEMail' class='Small' maxlength=50 size=25></td>"
           + "<td class='DataTable2' nowrap>e-Mail: </td>"
           + "<td class='DataTable1' nowrap><input name='RciEMail' class='Small' maxlength=50 size=25></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Mail to:</td>"
           + "<td class='DataTable1' nowrap><textArea name='CstAddr' class='Small' cols=50 rows=3></textArea></td>"
           + "<td class='DataTable2' nowrap>Mail to:</td>"
           + "<td class='DataTable1' nowrap><textArea name='RciAddr' class='Small'  cols=50 rows=3></textArea></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable2' nowrap>Instruction:</td>"
           + "<td class='DataTable1' nowrap><textArea name='CstIns' class='Small' cols=50 rows=3></textArea></td>"
           + "<td class='DataTable2' nowrap>Instruction:</td>"
           + "<td class='DataTable1' nowrap><textArea name='RciIns' class='Small'  cols=50 rows=3></textArea></td>"
         + "</tr>"

         + "<tr class='DataTable1'>"
           + "<td class='DataTable' colspan='2' nowrap>"
           + "<div id='dvDoc'><a target='_blank' href='VendorDoc/VEN_" + ven + "." + fileext.trim() + "'>Show Document</a></div></td>"
           + "<td class='DataTable' colspan='2' nowrap>"
           + "<button class='Small' id='Upload' onClick='uploadDoc(&#34;"
           + ven + "&#34;, &#34;" + vennm + "&#34;)'>Upload Document</button>"
           + "</td>"
         + "</tr>"

         + "</table>"

         + "<button class='Small' id='Save' onClick='Validate(&#34;" + ven + "&#34;)'>Save</button>&nbsp;&nbsp;"
         + "<button class='Small' id='Cancel' onClick='hidePanel()'>Cancel</button>&nbsp;&nbsp;"

        + "</td>"
       + "</tr>"

   html += "</table>"

   var pos = objPosition(document.all["tdVen" + num]);

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= pos[0] + 75;
   document.all.Prompt.style.pixelTop= pos[1] + 25;
   document.all.Prompt.style.visibility = "visible";

   if (doc != "Y") document.all.dvDoc.style.visibility="hidden";

   if (coop == "Y") { document.all.Coop.selectedIndex=1; }
   if (frgalw == "Y") { document.all.FrgAlw.selectedIndex=1; }
   if (pretk == "Y") { document.all.PreTick.selectedIndex=1; }
   if (suptk == "Y") { document.all.SupTick.selectedIndex=1; }

   SelRow = num;
}

//--------------------------------------------------------
// position objec on the screen
//--------------------------------------------------------
function objPosition(obj)
{
   var curLeft = 0;
   var curTop = 0;
   var pos = new Array(2);


   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       curLeft += obj.offsetLeft
       curTop += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     curLeft += obj.x;
     curTop += obj.y;
   }

   pos[0]=curLeft;
   pos[1]=curTop;
   return pos;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}

//---------------------------------------------------------
// retreive complete vendor information
//---------------------------------------------------------
function rtvVend(ven)
{
  var url = 'MrVendInfo.jsp?'
    + "Vendor=" + ven;

   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}

//==============================================================================
// Validate form
//==============================================================================
function Validate(ven)
{
  var error = false;
  var msg = " ";

  var vennm = document.all.VenName.value;
  var alwrate = document.all.AlwRate.value;
  var signed = document.all.Signed.value;
  var prtnm = document.all.PrtName.value;
  var title = document.all.Title.value;
  var signda = document.all.SignDate.value;
  var doc = document.all.Doc.value;
  var fileext = document.all.FileExt.value;

  var acct = document.all.Acct.value;
  var coop = document.all.Coop.value;
  var coopprc = document.all.CoopPrc.value;
  var frgalw = document.all.FrgAlw.value;
  var frgalwprc = document.all.FrgAlwPrc.value;
  var pretk = document.all.PreTick.value;
  var suptk = document.all.SupTick.value;

  var cstcont = document.all.CstCont.value;
  var cstphn = document.all.CstPhone.value;
  var cstweb = document.all.CstWeb.value;
  var csteml = document.all.CstEMail.value;
  var cstaddr = (document.all.CstAddr.value).trim();
  var cstins = (document.all.CstIns.value).trim();

  var rcicont = document.all.RciCont.value;
  var rciphn = document.all.RciPhone.value;
  var rciweb = document.all.RciWeb.value;
  var rcieml = document.all.RciEMail.value;
  var rciaddr = document.all.RciAddr.value;
  var rciins = document.all.RciIns.value;


  if(isNaN(alwrate))
  {
    msg += "Allowed rate is not a numeric.\n"
    error = true;
  }

  if(isNaN(coopprc))
  {
    msg += "Co-op percents are not a numeric.\n"
    error = true;
  }
  if(isNaN(frgalwprc))
  {
    msg += "Freight allowance percents are not a numeric.\n"
    error = true;
  }

  if(coop=="N") { coopprc = 0;}
  if(frgalw=="N") frgalwprc = 0;

  if(cstaddr.length > 250)
  {
    msg += "Customer Address is to long.\n"
    error = true;
  }

  if(cstins.length > 500)
  {
    msg += "Customer Instruction is to long.\n"
    error = true;
  }

  if(rciaddr.trim().length > 500)
  {
    msg += "RCI Address is to long.\n"
    error = true;
  }

  if(rciins.trim().length > 500)
  {
    msg += "RCI Instruction is to long.\n"
    error = true;
  }

  if (error) alert(msg);
  else
  {
    saveMrVenEnt(ven, vennm, alwrate, signed, prtnm, title, signda, doc, fileext,
                 acct, coop, coopprc, frgalw, frgalwprc, pretk, suptk,
                 cstcont, cstphn, cstweb, csteml, cstaddr, cstins,
                 rcicont, rciphn, rciweb, rcieml, rciaddr, rciins);
  }
}
//-------------------------------------------------------------
// Prompt for Media populate media list
//-------------------------------------------------------------
function saveMrVenEnt(ven, vennm, alwrate, signed, prtnm, title, signda, doc, fileext,
                      acct, coop, coopprc, frgalw, frgalwprc, pretk, suptk,
                      cstcont, cstphn, cstweb, csteml, cstaddr, cstins,
                      rcicont, rciphn, rciweb, rcieml, rciaddr, rciins)
{
   cstaddr = cvtText(cstaddr);
   rciaddr = cvtText(rciaddr);
   cstins = cvtText(cstins);
   rciins = cvtText(rciins);

   var url = 'MrVendSave.jsp?'
    + "Vendor=" + ven
    + "&VenName=" + vennm
    + "&AlwRate=" + alwrate
    + "&Signed=" + signed
    + "&PrtName=" + prtnm
    + "&Title=" + title
    + "&SignDate=" + signda
    + "&CstCont=" + cstcont
    + "&CstPhone=" + cstphn
    + "&CstWeb=" + cstweb
    + "&CstEMail=" + csteml
    + "&CstAddr=" + cstaddr
    + "&CstIns=" + cstins
    + "&RciCont=" + rcicont
    + "&RciPhone=" + rciphn
    + "&RciWeb=" + rciweb
    + "&RciEMail=" + rcieml
    + "&RciAddr=" + rciaddr
    + "&RciIns=" + rciins
    + "&Acct=" + acct
    + "&Coop=" + coop
    + "&CoopPrc=" + coopprc
    + "&FrgAlw=" + frgalw
    + "&FrgAlwPrc=" + frgalwprc
    + "&PreTick=" + pretk
    + "&SupTick=" + suptk
    + "&User=" + User;

   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
   updTableRow(ven, vennm, alwrate, signed, prtnm, title, signda, doc, fileext,
               acct, coop, coopprc, frgalw, frgalwprc, pretk, suptk,
               cstphn, cstweb, csteml, cstaddr, cstins, rciphn, rciweb, rcieml, rciaddr, rciins)
   hidePanel();
}

//---------------------------------------------------------
// convert text -  replace next line %0A on &#92;n
//---------------------------------------------------------
function cvtText(text)
{
   var newstr = "";
   for(var i=0; i < text.length; i++)
   {
      if(escape(text.substring(i, i+1)) == "%0A") { newstr += "&#92;n" }
      else { newstr += text.substring(i, i+1) }
   }
   return newstr;
}

//------------------------------------------------------------------------
// update rows in line
//------------------------------------------------------------------------
function updTableRow(ven, vennm, alwrate, signed, prtnm, title, signda, doc, fileext,
          acct, coop, coopprc, frgalw, frgalwprc, pretk, suptk,
          cstphn, cstweb, csteml, cstaddr, cstins, rciphn, rciweb, rcieml, rciaddr, rciins)
{
     document.all["tdVen" + SelRow].onclick=
        function(){ showVend(ven, vennm, doc, fileext, alwrate, signed, prtnm, title, signda,
                    acct, coop, coopprc, frgalw, frgalwprc, pretk, suptk, SelRow);};

     document.all["tdVenName" + SelRow].innerHTML = vennm;
     if(cstaddr.trim()!="") document.all["tdCAddr" + SelRow].innerHTML = "Y";
     else document.all["tdCAddr" + SelRow].innerHTML = "";
     if(rciaddr.trim()!="") document.all["tdRAddr" + SelRow].innerHTML = "Y";
     else document.all["tdRAddr" + SelRow].innerHTML = "";

     if(cstphn.trim()!="") document.all["tdCPhone" + SelRow].innerHTML = "Y";
     else document.all["tdCPhone" + SelRow].innerHTML = "";
     if(rciphn.trim()!="") document.all["tdRPhone" + SelRow].innerHTML = "Y";
     else document.all["tdRPhone" + SelRow].innerHTML = "";

     if(cstweb.trim()!="") document.all["tdCWeb" + SelRow].innerHTML = "Y";
     else document.all["tdCWeb" + SelRow].innerHTML = "";
     if(rciweb.trim()!="") document.all["tdRWeb" + SelRow].innerHTML = "Y";
     else document.all["tdRWeb" + SelRow].innerHTML = "";

     if(csteml.trim()!="") document.all["tdCEmail" + SelRow].innerHTML = "Y";
     else document.all["tdCEmail" + SelRow].innerHTML = "";
     if(rcieml.trim()!="") document.all["tdREmail" + SelRow].innerHTML = "Y";
     else document.all["tdREmail" + SelRow].innerHTML = "";

     if(cstins.trim()!="") document.all["tdCIns" + SelRow].innerHTML = "Y";
     else document.all["tdCIns" + SelRow].innerHTML = "";
     if(rciins.trim()!="") document.all["tdRIns" + SelRow].innerHTML = "Y";
     else document.all["tdRIns" + SelRow].innerHTML = "";

     document.all["tdRate" + SelRow].innerHTML = alwrate;
     document.all["tdSign" + SelRow].innerHTML = signed;
     document.all["tdPrt" + SelRow].innerHTML = prtnm;
     document.all["tdTitle" + SelRow].innerHTML = title;
     document.all["tdSiDa" + SelRow].innerHTML = signda;
}
function uploadDoc(ven, vennm)
{
   var html = ""
    + "<table width='100%' cellPadding='0' cellSpacing='0'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Upload Document for " + vennm + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hideUpload();' alt='Close'>"
       + "</td>"
      + "</tr>"

      + "<tr class='DataTable2' >"
        + "<td class='DataTable' colspan='2'>"
          + "<form name='Upload' method='post' enctype='multipart/form-data' action='MrVDocUpl.jsp'>"
            + "<input type='hidden' name='Vendor' class='small' value='" + ven + "'>"
            + "<input type='file' name='Doc' class='small' size=100 ><br>"
          + "</form>"
          + "<button name='btnUpload' class='small' onClick='sbmUpload()' >Upload</button>&nbsp;&nbsp;"
          + "<button name='btnCancel' class='small' onClick='hideUpload()'>Cancel</button>"
        + "</td></tr>"
    + "</table>"

  // alert(ads)
  document.all.dvUpload.innerHTML=html;
  document.all.dvUpload.style.pixelLeft= (document.documentElement.scrollLeft + screen.width - 580) / 2
  document.all.dvUpload.style.pixelTop= document.documentElement.scrollTop + screen.height - 500;
  document.all.dvUpload.style.visibility="visible"

}
//------------------------------------------------------------------------------
// submit Uploading document
//------------------------------------------------------------------------------
function sbmUpload()
{
  var form = document.Upload;
  var error = false;
  var msg = "";

  var file = form.Doc.value.trim();

  if(file == "")
  {
     error = true;
     msg = "Please type full file path"
  }
  if(error) alert(msg)
  else
  {
     form.target = "DocUpload";
     open("", "DocUpload", "width=0,height=0, left=3000,top=3000, resizable=no , toolbar=no, location=no, directories=no, status=no, scrollbars=no,menubar=no")
     form.submit();
     this.focus();
  }
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hideUpload()
{
   document.all.dvUpload.innerHTML = " ";
   document.all.dvUpload.style.visibility = "hidden";
}
//---------------------------------------------------------
// show Uploaded document link
//---------------------------------------------------------
function showDocUpl(file, fileext)
{
   var html = "<a target='_blank' href='VendorDoc/" + file + "'>Show Document</a>";
   document.all.dvDoc.innerHTML=html;
   document.all.dvDoc.style.visibility="visible";

   var vennm = document.all.VenName.value;
   var alwrate = document.all.AlwRate.value;
   var signed = document.all.Signed.value;
   var prtnm = document.all.PrtName.value;
   var title = document.all.Title.value;
   var signda = document.all.SignDate.value;
   var doc = document.all.Doc.value;
   var fileext = document.all.FileExt.value;

   var acct = document.all.Acct.value;
   var coop = document.all.Coop.value;
   var coopprc = document.all.CoopPrc.value;
   var frgalw = document.all.FrgAlw.value;
   var frgalwprc = document.all.FrgAlwPrc.value;
   var pretk = document.all.PreTick.value;
   var suptk = document.all.SupTick.value;

   document.all["tdVen" + SelRow].onclick=
        function(){ showVend(ven, vennm, doc, fileext, alwrate, signed, prtnm, title, signda,
                    acct, coop, coopprc, frgalw, frgalwprc, pretk, suptk, SelRow);};
}
//---------------------------------------------------------
// populate Table with entry made to rtvreg file
//---------------------------------------------------------
function popAddr(CstCont, CstPhone, CstWeb, CstEMail, CstAddr, CstIns,
                 RciCont, RciPhone, RciWeb, RciEMail, RciAddr, RciIns)
{
   updAddr(CstCont, CstPhone, CstWeb, CstEMail, CstAddr, CstIns,
           RciCont, RciPhone, RciWeb, RciEMail, RciAddr, RciIns)
}
//------------------------------------------------------------------------
// update address for selected vendor
//------------------------------------------------------------------------
function updAddr(CstCont, CstPhone, CstWeb, CstEMail, CstAddr, CstIns,
                 RciCont, RciPhone, RciWeb, RciEMail, RciAddr, RciIns)
{
    if(document.all.CstPhone == null) return; //skip on back button

    document.all.CstCont.value = CstCont;
    document.all.CstPhone.value = CstPhone;
    document.all.CstWeb.value = CstWeb;
    document.all.CstEMail.value = CstEMail;
    for(var i=0; i < CstAddr.length; i++) { document.all.CstAddr.value += CstAddr[i].trim() + "\n"; }
    for(var i=0; i < CstIns.length; i++) { document.all.CstIns.value += CstIns[i].trim(); }

    // rci address
    document.all.RciCont.value = RciCont;
    document.all.RciPhone.value = RciPhone;
    document.all.RciWeb.value = RciWeb;
    document.all.RciEMail.value = RciEMail;
    for(var i=0; i < RciAddr.length; i++) { document.all.RciAddr.value += RciAddr[i]  + "\n";}
    for(var i=0; i < RciIns.length; i++) { document.all.RciIns.value += RciIns[i].trim(); }
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
  <div id="dvUpload" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Merchandise Vendor List</B><br>

        <table border=0 cellPadding="0" cellSpacing="0" id="tbSearch">
          <tr><td align="right">Vendor:&nbsp;</td>
              <td align="left"><input class="Small" name="Vendor" maxlength=5 size=5></td>
              <td align="center">- or -</td>
          </tr>
          <tr><td align="right">Name:&nbsp;</td>
              <td align="left"><input class="Small" name="Search" maxlength=25 size=25></td>
              <td align="right">&nbsp;&nbsp;&nbsp;<input onClick="newSearch()" type="submit" class="Small" name="Submit" value="Search"></td>
          </tr>
        </table>

       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page.</font>

<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable" >Vendor</th>
           <th class="DataTable" >Vendor<br>Name</th>

           <th class="DataTable" >&nbsp;</th>
           <th class="DataTable" >Cust<br>Cont<br>Name</th>
           <th class="DataTable" >Cust<br>Addr</th>
           <th class="DataTable" >Cust<br>Phn</th>
           <th class="DataTable" >Cust<br>Web</th>
           <th class="DataTable" >Cust<br>E-Mail</th>
           <th class="DataTable" >Cust<br>Instr</th>

           <th class="DataTable" >&nbsp;</th>
           <th class="DataTable" >RCI<br>Cont<br>Name</th>
           <th class="DataTable" >RCI<br>Addr</th>
           <th class="DataTable" >RCI<br>Phn</th>
           <th class="DataTable" >RCI<br>Web</th>
           <th class="DataTable" >RCI<br>E-Mail</th>
           <th class="DataTable" >RCI<br>Instr</th>

           <th class="DataTable" >&nbsp;</th>
           <th class="DataTable" >Doc</th>
           <th class="DataTable" >Rate</th>
           <th class="DataTable" >Signed<br>by</th>
           <th class="DataTable" >PrtName</th>
           <th class="DataTable" >Title</th>
           <th class="DataTable" >Signed<br>Date</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfVen; i++ ){%>
          <tr id="trVen<%=i%>" class="DataTable">
            <td class="DataTable3"
               onClick="showVend('<%=sVen[i]%>', '<%=sVenName[i]%>', '<%=sDoc[i]%>', '<%=sFileExt[i]%>', '<%=sAllowRate[i]%>',
                 '<%=sSigned[i]%>', '<%=sPrtName[i]%>', '<%=sTitle[i]%>', '<%=sSignDate[i]%>',
                 '<%=sAcct[i]%>', '<%=sCoop[i]%>', '<%=sCoopPrc[i]%>', '<%=sFrgAlw[i]%>',
                 '<%=sFrgAlwPrc[i]%>', '<%=sPreTick[i]%>', '<%=sSupTick[i]%>', <%=i%>)"
                        id="tdVen<%=i%>" ><%=sVen[i]%></td>
            <td class="DataTable1" id="tdVenName<%=i%>"><%=sVenName[i]%></td>

            <th class="DataTable" >&nbsp;</th>

            <td class="DataTable2" id="tdCAddr<%=i%>" ><%=sCstCont[i]%></td>
            <td class="DataTable2" id="tdCAddr<%=i%>" ><%=sCstAddr[i]%></td>
            <td class="DataTable2" id="tdCPhone<%=i%>" ><%=sCstPhone[i]%></td>
            <td class="DataTable2" id="tdCWeb<%=i%>" ><%=sCstWeb[i]%></td>
            <td class="DataTable2" id="tdCEmail<%=i%>" ><%=sCstEMail[i]%></td>
            <td class="DataTable2" id="tdCIns<%=i%>" ><%=sCstIns[i]%></td>

            <th class="DataTable" >&nbsp;</th>

            <td class="DataTable2" id="tdCAddr<%=i%>" ><%=sRciCont[i]%></td>
            <td class="DataTable2" id="tdRAddr<%=i%>" ><%=sRciAddr[i]%></td>
            <td class="DataTable2" id="tdRPhone<%=i%>" ><%=sRciPhone[i]%></td>
            <td class="DataTable2" id="tdRWeb<%=i%>" ><%=sRciWeb[i]%></td>
            <td class="DataTable2" id="tdREmail<%=i%>" ><%=sRciEMail[i]%></td>
            <td class="DataTable2" id="tdRIns<%=i%>" ><%=sRciIns[i]%></td>

            <th class="DataTable" >&nbsp;</th>

            <td class="DataTable1" id="tdDoc<%=i%>" ><%=sDoc[i]%></td>
            <td class="DataTable2" id="tdRate<%=i%>" ><%=sAllowRate[i]%></td>
            <td class="DataTable1" id="tdSign<%=i%>" ><%=sSigned[i]%></td>
            <td class="DataTable1" id="tdPrt<%=i%>" ><%=sPrtName[i]%></td>
            <td class="DataTable1" id="tdTitle<%=i%>" ><%=sTitle[i]%></td>
            <td class="DataTable1" id="tdSiDa<%=i%>" ><%=sSignDate[i]%></td>
          </tr>
       <%}%>
       </table>
<!-- ======================================================================= -->
      <%if(bMoreRec){%><button class="Small" name="More" onClick="showMoreRec()">More</button><%}%>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>