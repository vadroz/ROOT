<%@ page import="rtvregister.RtvRegList, rtvregister.RtvReasonCode"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")== null || session.getAttribute("RTVREG") == null
       && session.getAttribute("RTVREGBUYR") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RtvRegList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      boolean bBuyer = false;
      if(session.getAttribute("RTVREGBUYR") != null) bBuyer = true;


      String sStore = request.getParameter("Store");
      String sStrName = request.getParameter("StrName");
      String sDivision = request.getParameter("Division");
      String sDivisionName = request.getParameter("DivName");
      String sVendor = request.getParameter("Vendor");
      String sReason = request.getParameter("Reason");
      String sFrDate = request.getParameter("FrDate");
      String sAction = request.getParameter("Action");
      String sSort = request.getParameter("Sort");

      if(sSort==null) sSort = "VEN";

      //System.out.print(sStore + "|" + sDivision + "|" + sVendor + "|" + sReason + "|" + sFrDate + "|" + sAction + "|" + sSort + "|");
      RtvRegList rtvreg = new RtvRegList(sStore, sDivision,  sVendor, sReason, sFrDate, sAction, sSort);

      int iNumOfItm = rtvreg.getNumOfItm();
      int iNumOfStr = rtvreg.getNumOfStr();

      RtvReasonCode reasCode = new RtvReasonCode();
      String sReasonLst = reasCode.getReasonCode();
      String sReasonDesc = reasCode.getReasonDesc();

%>

<style>body {background:white;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #F0F0F0; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: MistyRose; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: CornSilk; font-family:Arial; font-size:10px }
        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space: nowrap;}
        td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space: nowrap;}
        td.DataTable2 { cursor:hand; color: blue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space: nowrap; text-decoration: underline;}
        td.DataTable3 { cursor:hand; color: blue; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left; white-space: nowrap;
                        text-decoration: underline;}
        td.DataTable31 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left; white-space: nowrap;}
        td.DataTable4{ padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap;}

        select.Small {font-family:Arial; font-size:10px }
        a.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {text-align:center; padding-left:3px; padding-right:3px; font-family:Arial; font-size:10px; }
        td.Prompt1 {text-align:left; font-family:Arial; font-size:10px; }


</style>


<script name="javascript">
var User = "<%=session.getAttribute("USER").toString()%>";
var NumOfItm = <%=iNumOfItm%>;
var Store = "<%=sStore%>";
var Division = "<%=sDivision%>";
var Vendor = "<%=sVendor%>";
var SelReason = "<%=sReason%>";
var FrDate = "<%=sFrDate%>";
var Action = "<%=sAction%>";

var Reason = [<%=sReasonLst%>];
var ReasonDesc = [<%=sReasonDesc%>];

var SelRow = null;
var Column = ["tdStr", "tdClrName", "tdSizName", "tdSku", "tdDesc", "tdVenName", "tdVenSty",
                "tdReason", "tdCost", "tdComment", "tdDocNum", "tdRaNum", "tdMarkout", "tdRecall", "tdDefect",
                "tdLstDate", "tdRaDate", "tdRaTime", "tdRaUser", "tdRgDate", "tdDelete"];
var ColHdr = ["thStr", "thClrName", "thSizName", "thSku", "thDesc", "thVenName", "thVenSty",
                "thReason", "thCost", "thComment", "thDocNum", "thRaNum", "thMarkout", "thRecall", "thDefect",
                "thLstDate", "thRaDate", "thRaTime", "thRaUser", "thRgDate", "thDelete"];

var ColName = ["Store", "Color Name", "Size Name", "SKU", "Description", "Vendor Name", "Vendor Style",
                "Reason", "Cost", "Comment", "Doc#", "RA#", "Markout", "Recall", "Defect",
                "Last Date", "RA Date", "RA Time", "RA User", "DC Entry Date", "Delete"];
var DspColumn = new Array(ColHdr.length);

// save selcted records for massive update
var SelCol=null;
var SelCell = new Array(NumOfItm);
var SelValue = null;
var SelStr = new Array(NumOfItm);
var SelSku = new Array(NumOfItm);
var SelSeq = new Array(NumOfItm);

var SbmCmd = new Array();
var SbmLoop = 0;
var SbmQty = 0;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
   for(var i=0; i < Column.length; i++) { DspColumn[i] = true;}
}
//==============================================================================
// mark attribute on Item Header
//==============================================================================
function markItem(obj, str, sku, seq, fld)
{
   // allowed not in download mode
   if (obj.innerHTML.trim() != "Y")  { obj.innerHTML = "Y";  }
   else { obj.innerHTML = "&nbsp;"; }

   var url = "RtvRegSave.jsp?Store=" + str
           + "&Search=" + sku
           + "&Seq=" + seq
           + "&Action=" + fld;

   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// select column cells for updates
//==============================================================================
function selColumnCell(obj, i, str, sku, seq, fld)
{
   var hdr = null;

   if(fld=="RANUM") { hdr = document.all.thRaNum;}

   if(SelCol==null || SelCol == fld)
   {
      SelCol = fld;
      if(SelCell[i] == null || !SelCell[i])
      {
         obj.style.backgroundColor="lightsalmon"; SelCell[i] = true; SelStr[i] = str.trim(); SelSku[i] = sku.trim();SelSeq[i] = seq.trim();
         hdr.style.backgroundColor="#fbb917";
         if (SelValue == null) SelValue = obj.innerHTML;
         if (SelValue == "&nbsp;") SelValue = "";
      }
      else
      {
         obj.style.backgroundColor="#F0F0F0"; SelCell[i] = false; SelStr[i] = ""; SelSku[i] = ""; SelSeq[i] = "";
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

   for(var i=0; i < NumOfItm; i++)
   {
      if (SelCell[i] == true)
      {
          if(SelCol=="RANUM") { cell = "tdRaNum" + i ; hdr = "thRaNum";}
          document.all[cell].style.backgroundColor="#F0F0F0";
          document.all[hdr].style.backgroundColor="#FFCC99";
          SelCell[i]=false; SelStr[i] = ""; SelSku[i] = ""; SelSeq[i] = "";
      }
   }
   SelCol = null;
   SelValue = null;
}
//==============================================================================
// update selected colimn cells
//==============================================================================
function colUpdate()
{
   // exit if there are no selection made
   if(SelCol==null) { alert("There is no selected column."); return}

   var colnm = null
   var size = 0;

   //check if order is paid off
   var hdr = "Update Column: ";
   if(SelCol=="RANUM") { colnm = "RA#"; size=10; }
   hdr += colnm;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popGenderPanel(SelCol, colnm)

   html += "</td></tr></table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.width = 250;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.Prompt.style.visibility = "visible";
   document.all.Col.value = SelValue;
   document.all.Col.focus()
}

//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popGenderPanel(col, colnm)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt1' nowrap>" + colnm + "</td>"
           + "<td class='Prompt' colspan='2'>"
             + "<input name=Col class='Small'>"
           + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmColumn(&#34;" + col + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function sbmColumn(col)
{
   var prod = 0;

   var column = document.all.Prompt.innerHTML = document.all.Col.value;

   document.all.Prompt.innerHTML = "<MARQUEE><font size = +2>Wait while table is updating...</font></MARQUEE>";
   document.all.Prompt.style.width = 600;
   document.all.Prompt.style.height = 50;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.Prompt.style.visibility = "visible";

   for(var i=0, j=0; i < NumOfItm; i++)
   {
      if(SelCell[i] != null && SelCell[i])
      {
         var cell = "tdRaNum" + i
         if(SelCol=="RANUM") document.all[cell].innerHTML = column;
         var url = "RtvRegSave.jsp?Store=" + SelStr[i] + "&Search=" + SelSku[i] + "&Seq=" + SelSeq[i]
         if(col=="RANUM") url += "&RaNum=" + column + "&Action=RANUM";

         SbmCmd[j++] = url;
         SbmQty = j;
      }
   }

   reuseFrame(); // submit all requests
}
//--------------------------------------------------------
// reuse frame
//--------------------------------------------------------
function reuseFrame()
{
   if (SbmLoop < SbmQty)
   {
      //alert(SbmCmd[SbmLoop])
      //window.location.href=SbmCmd[SbmLoop];
      window.frame1.location.href = SbmCmd[SbmLoop];
      SbmLoop++;
   }
   else
   {
      SbmCmd = new Array();
      SbmLoop = 0;
      SbmQty = 0;
      hidePanel();
      clrColSel();
   }
}
//---------------------------------------------------------
// retreive Item for update or remove
//---------------------------------------------------------
function rtvItem(str, sku, seq, desc , reason, ranum, markout, recall, comment, defect, id, action)
{
  var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Update RTV Item</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
   // RTV Item attributes
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>Store: " + str
          + "<input name='Store' type='hidden' value='" + str + "'></td>"
        + "</tr>"
        + "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>Sku: " + sku + "&nbsp;&nbsp;Desc: " + desc
          + "<input name='Sku' type='hidden' value='" + sku + "'>"
          + "<input name='Seq' type='hidden' value='" + seq + "'></td>"
        + "</tr>"
   if (action.substring(0, 3) != "DLT")
   {
      if (action == "UPD")
      {
        html += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>Reason: "
          + "<select name='Reason' class='Small' onChange='chkSelReason(this)'></select></td>"
        + "</tr>"
        + "<tr class='DataTable2' id='trComment'>"
          + "<td class='DataTable' nowrap colspan='2'>Comment: "
          + "<input name='Comment' class='Small' type='text' maxlength='50' size='50'"
          + "value='" + comment.trim() + "'></td>"
        + "</tr>"
      }

      if (action == "UPD" || action == "UPDALLRAN")
      {
         html += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>RA#: "
          + "<input name='RaNum' size='20' maxlength='20'  class='Small'></td>"
          + "</tr>"
      }

      if (action == "UPD" || action == "UPDALLMOS")
      {
        html += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>Mark Out Of stock: "
          + "<input name='Mos' type='checkbox' class='Small' value='Y'></td>"
          + "</tr>"
      }

      if (action == "UPD" || action == "UPDALLREC")
      {
         html += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>Recall: "
          + "<input name='Recall' type='checkbox' class='Small' value='Y'></td>"
          + "</tr>"
     }
     if (action == "UPD" || action == "UPDALLDEF")
      {
         html += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>Defective: "
          + "<input name='Defect' type='checkbox' class='Small' value='Y'></td>"
          + "</tr>"
     }
   }

   html += "<tr class='DataTable2'>"
          + "<td class='DataTable' nowrap colspan='2'>";

        if(action.substring(0, 3)=="UPD") { html += "<button id='Save' class='Small' onClick='Validate(&#34;" + action + "&#34;);'>Save</button>&nbsp;&nbsp;" }
        else if(action.substring(0, 3) == "DLT") { html += "<button id='dbDelete' class='Small' onClick='Validate(&#34;" + action + "&#34;);'>Delete</button>&nbsp;&nbsp;" }

        html += "<button id='Close' class='Small' onClick='hidePanel();'>Close</button></td></tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.Prompt.style.visibility = "visible";


   if (action == "UPD")
   {
      document.all.trComment.style.display="none";
      popReasonSel(reason);
   }
   if (id != "ALL" && action.substring(0, 3) != "DLT") popRaMosRecall(ranum, markout, recall, defect);

   if(id!="ALL") SelRow = id.substring(5);
   else SelRow = "ALL";

}
//--------------------------------------------------------
// populate reason list
//--------------------------------------------------------
function popReasonSel(reason)
{
   document.all.Reason.options[0] = new Option("None", "NONE");
   for(var i=0; i < Reason.length; i++)
   {
      document.all.Reason.options[i+1] = new Option(ReasonDesc[i], Reason[i]);
      if(reason.trim() == ReasonDesc[i].trim()) document.all.Reason.selectedIndex = i+1
      if(Reason[i] == "P"){ document.all.trComment.style.display="block"; }
   }
}
//--------------------------------------------------------
// populate reason list
//--------------------------------------------------------
function popRaMosRecall(ranum, markout, recall, defect)
{
   if(ranum.trim() != "" && ranum.trim() != "&nbsp;") document.all.RaNum.value = ranum.trim();
   if (markout == "Y") document.all.Mos.checked = true;
   if (recall == "Y") document.all.Recall.checked = true;
   if (defect == "Y") document.all.Defect.checked = true;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}
//==============================================================================
// check Selected Reason
//==============================================================================
function chkSelReason(obj)
{
   if (obj.value == "P"){ document.all.trComment.style.display="block"; }
   else { document.all.trComment.style.display="none"; }

}
//==============================================================================
// Validate form
//==============================================================================
function Validate(action)
{
  var error = false;
  var msg = " ";
  var str = document.all.Store.value;
  var search = (document.all.Sku.value).trim();
  var seq = (document.all.Seq.value).trim();

  var rcidx = " ";
  var reason = " ";
  var comment = " ";
  var ranum = " ";
  var markout = " ";
  var recall = " ";
  var defect = " ";

  if(action.substring(0, 3) !="DLT")
  {
    if(action =="UPD")
    {
       rcidx = document.all.Reason.selectedIndex;
       if(rcidx > 0) reason = (document.all.Reason.options[rcidx].value).trim();
       comment = document.all.Comment.value
    }

    if(document.all.RaNum != null)    ranum = (document.all.RaNum.value).trim();

    if(document.all.Mos!=null && document.all.Mos.checked)  markout = document.all.Mos.value
    if(document.all.Recall!=null && document.all.Recall.checked) recall = document.all.Recall.value;
    if(document.all.Defect!=null && document.all.Defect.checked) defect = document.all.Defect.value;

    if  (action =="UPD" && (ranum.trim() != "" && (markout.trim()!=" " || recall.trim()!=" ")
      || markout.trim()!=" " && recall.trim()!=" "))
    {
      msg += "\nYou, cannot specify more than 1 action for returning item."
      error = true;
    }
  }

  if (error) alert(msg);
  else
  {
    saveRtventry(str, search, seq, reason, comment, ranum, markout, recall, defect, action);
  }
}
//-------------------------------------------------------------
// Prompt for Media populate media list
//-------------------------------------------------------------
function saveRtventry(str, search, seq,  reason, comment, ranum, markout, recall, defect, action)
{
   var url = 'RtvRegSave.jsp?'
           + "User=" + User;

   if(action.length == 3)
   {
     url += "&Store=" + str
          + "&Search=" + search
          + "&Seq=" + seq
   }
   else
   {
      url += "&Store=" + Store
        + "&Division=" + Division
        + "&Vendor=" + Vendor
        + "&Reason=" + SelReason
        + "&From=" + FrDate
        + "&Select=" + Action
        + "&Search=ALL"
        + "&Seq=0"
   }

   url += "&Reason=" + reason
          + "&Comment=" + comment
          + "&RaNum=" + ranum
          + "&Markout=" + markout
          + "&Recall=" + recall
          + "&Defect=" + defect
          + "&Action=" + action;

   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
   hidePanel();
}

//---------------------------------------------------------
// display found errors
//---------------------------------------------------------
function displayError(NumOfErr, Error)
{
  var msg = "";
  for(var i = 0; i < NumOfErr; i++)
  {
    msg += Error[i] + "\n";
  }

  alert(msg);
  window.frame1.close();
}
//---------------------------------------------------------
// populate Table with entry made to rtvreg file
//---------------------------------------------------------
function popTable(Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Sku, Upc, Desc, ClrName,
              SizName, VenName, VenSty, DocNum, RaNum, Markout, Recall, Comment, Defect, Action)
{
   window.frame1.close();
   document.all.tbRtvEnt.style.visibility="visible"

   if(Action=="UPD")
   {
      updLine(Str[0], Cls[0], Ven[0], Sty[0], Clr[0], Siz[0], Seq[0], Reason[0], Sku[0],
              Upc[0], Desc[0], ClrName[0], SizName[0], VenName[0], VenSty[0], DocNum[0],
              RaNum[0], Markout[0], Recall[0], Comment[0], Defect[0]);
   }
   // refresh page when group update occured
   else if(Action=="DLT")  { dltLine(); }
   else if(Action=="DLTALL")  { window.location.href = "RtvRegListSel.jsp" }
   else if(Action.substring(0, 6)=="UPDALL")  { window.location = window.location;}
}

//------------------------------------------------------------------------
// update rows in line
//------------------------------------------------------------------------
function updLine(Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Sku, Upc, Desc, ClrName,
                  SizName, VenName, VenSty, DocNum, RaNum, Markout, Recall, Comment, Defect)
{
   var cell = "tdReason" + SelRow;
   if(Reason.trim()!="") document.all["trItm" + SelRow].className="DataTable"
   if(Reason.trim()=="") Reason = "&nbsp;";
   document.all[cell].innerHTML = Reason;

   cell = "tdComment" + SelRow
   if(Comment.trim()=="") Comment = "&nbsp;";
   document.all[cell].innerHTML = Comment;

   if(RaNum.trim()=="") RaNum = "&nbsp;";
   cell = "tdRaNum" + SelRow
   document.all[cell].innerHTML = RaNum;

   cell = "tdMarkout" + SelRow
   if(Markout.trim()==" ") Markout = "&nbsp;";
   document.all[cell].innerHTML = Markout;

   cell = "tdRecall" + SelRow
   if(Recall.trim()==" ") Recall = "&nbsp;";
   document.all[cell].innerHTML = Recall;

   cell = "tdDefect" + SelRow
   if(Defect.trim()=="") Defect = "&nbsp;";
   document.all[cell].innerHTML = Defect;

   cell = "tdItm" + SelRow
   document.all[cell].setAttribute("onclick", function(){ rtvItem(Str, Sku, Seq, Desc , Reason, RaNum, Markout, Recall, Comment, Defect, cell, "UPD")});
}

//------------------------------------------------------------------------
// delete rows from table
//------------------------------------------------------------------------
function dltLine()
{
   var cell = "trItm" + SelRow;
   document.all[cell].style.display = "none";
}
//---------------------------------------------------------
// re-sort report by selected fields
//---------------------------------------------------------
function resort(sort)
{
   var url = "RtvRegList.jsp?Store=<%=sStore%>"
           + "&StrName=<%=sStrName%>"
           + "&Division=<%=sDivision%>"
           + "&DivName=<%=sDivisionName%>"
           + "&Vendor=<%=sVendor%>"
           + "&Reason=<%=sReason%>"
           + "&FrDate=<%=sFrDate%>"
           + "&Action=<%=sAction%>"
           + "&Sort=" + sort
   //alert(url)
   window.location.href=url
}
//---------------------------------------------------------
// show selected column
//---------------------------------------------------------
function selctColumn()
{
   //check if order is paid off
   var hdr = "Select Columns";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popColList()

   html += "</td></tr></table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.Prompt.style.visibility = "visible";

   for(var i=0; i < Column.length; i++)
   {
      document.all[Column[i]].checked = DspColumn[i];
   }
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popColList()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

  panel += "<tr>"
  for(var i=0; i < ColName.length; i++)
  {
     panel += "<td class='Prompt'>" + ColName[i] + "</td>"
  }
  panel += "</tr>"

  panel += "<tr>"
  for(var i=0; i < Column.length; i++)
  {
     panel += "<td class='Prompt'>"
            + "<input type='checkbox' name='" + Column[i] + "' class='Small'></td>"
  }
  panel += "</tr>"


  panel += "<tr><td class='Prompt' colspan='" + Column.length + "'><br><br>"
        + "<button onClick='showColumn()' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//---------------------------------------------------------
// show selected columns
//---------------------------------------------------------
function showColumn()
{
   // set selected column array
   for(var i=0; i < Column.length; i++)
   {
      if(document.all[Column[i]].checked) {DspColumn[i] = true; }
      else {DspColumn[i] = false; }
   }

   // show/hide column name
   for(var i=0; i < ColName.length; i++)
   {
       var cell = ColHdr[i]
       if (!DspColumn[i]) { document.all[cell].style.display = "none"; }
       else { document.all[cell].style.display = "block"; }
   }

   for(var i=0; i < NumOfItm; i++)
   {
      for(var j=0; j < Column.length; j++)
      {
         var cell = Column[j] + i
         if (!DspColumn[j]) { document.all[cell].style.display = "none"; }
         else { document.all[cell].style.display = "block"; }
      }
   }

   hidePanel();
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
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>RTV Review</B><br>

       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       <a href="RtvRegListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
       <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript: selctColumn()"><font color="red" size="-1">Columns</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript: colUpdate()">Update</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: clrColSel()">Clear</a>&nbsp;&nbsp;&nbsp;&nbsp;

<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable" id="thStr"  ><a href="javascript: resort('STR')">From<br>Store</a></th>
           <th class="DataTable"  ><a href="javascript: resort('ITEM')">Class-Ven-Sty</a><br>
               <a class="Small" href="javascript: resort('VEN')">(by Vendor)</a>
           </th>
           <th class="DataTable" id="thClrName"  ><a href="javascript: resort('CLRNAME')">Color<br>Name</a></th>
           <th class="DataTable" id="thSizName"  ><a href="javascript: resort('SIZNAME')">Size<br>Name</a></th>
           <th class="DataTable" id="thSku"  ><a href="javascript: resort('SKU')">Short<br>Sku</a></th>
           <th class="DataTable" id="thDesc"  ><a href="javascript: resort('DESC')">Description</a></th>
           <th class="DataTable" id="thVenName"  ><a href="javascript: resort('VENNAME')">Vendor<br>Name</a></th>
           <th class="DataTable" id="thVenSty"  ><a href="javascript: resort('VENSTY')">Vendor<br>Style</a></th>
           <th class="DataTable" id="thReason"  ><a href="javascript: resort('REASON')">Reason</a></th>
           <th class="DataTable" id="thCost"  ><a href="javascript: resort('COST')">Actual<br>Cost</a></th>
           <th class="DataTable" id="thComment"  ><a href="javascript: resort('COMMENT')">Comment</a></th>

           <th class="DataTable" id="thDocNum" >Doc #</th>
           <th class="DataTable" id="thRaNum" >RA #</th>
           <th class="DataTable" id="thMarkout" >Mark Out<br>of Stock</th>
           <th class="DataTable" id="thRecall" >Recall</th>
           <th class="DataTable" id="thDefect" >Defective<br>Item</th>

           <th class="DataTable" id="thLstDate" >Last<br>Receipt<br>Date</th>
           <th class="DataTable" id="thRaDate" >Changed<br>Date</th>
           <th class="DataTable" id="thRaTime" >Changed<br>Time</th>
           <th class="DataTable" id="thRaUser" >Changed<br>Buyer</th>
           <th class="DataTable" id="thRgDate" >DC Entry<br>Date</th>
           <%if(!bBuyer) {%>
              <th id="thDelete" class='DataTable'>Delete</th>
           <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ ){%>
          <%
          rtvreg.setItem();
          String sStrLst = rtvreg.getStr();
          String sCls = rtvreg.getCls();
          String sVen = rtvreg.getVen();
          String sSty = rtvreg.getSty();
          String sClr = rtvreg.getClr();
          String sSiz = rtvreg.getSiz();
          String sSeq = rtvreg.getSeq();
          String sReasonName = rtvreg.getReason();
          String sComment = rtvreg.getComment();
          String sSku = rtvreg.getSku();
          String sUpc = rtvreg.getUpc();
          String sDesc = rtvreg.getDesc();
          String sClrName = rtvreg.getClrName();
          String sSizName = rtvreg.getSizName();
          String sVenName = rtvreg.getVenName();
          String sVenSty = rtvreg.getVenSty();
          String sDocNum = rtvreg.getDocNum();
          String sClsName = rtvreg.getClsName();
          String sDiv = rtvreg.getDiv();
          String sDivName = rtvreg.getDivName();

          String sRaNum = rtvreg.getRaNum();
          String sMarkOutStock = rtvreg.getMarkOutStock();
          String sRecall = rtvreg.getRecall();
          String sRgDate = rtvreg.getRgDate();
          String sRgTime = rtvreg.getRgTime();
          String sRgUser = rtvreg.getRgUser();
          String sRaDate = rtvreg.getRaDate();
          String sRaTime = rtvreg.getRaTime();
          String sRaUser = rtvreg.getRaUser();
          String sCost = rtvreg.getCost();
          String sLstRcpt = rtvreg.getLstRcpt();
          String sDefect = rtvreg.getDefect();
      %>


          <tr id="trItm<%=i%>" class="DataTable<%if(sReasonName.trim().equals("")){%>1<%}%>">
            <td class="DataTable" id="tdStr<%=i%>"><%=sStrLst%></td>
            <td class="DataTable2" id="tdItm<%=i%>"
                onClick="rtvItem(<%=sStrLst%>, '<%=sSku%>', '<%=sSeq%>', '<%=sDesc%>',
                   '<%=sReasonName%>', '<%=sRaNum%>', '<%=sMarkOutStock%>', '<%=sRecall%>',
                   '<%=sComment%>', '<%=sDefect%>' , 'tdItm<%=i%>', 'UPD');">
                <%=sCls + "-" + sVen + "-" + sSty%></td>
            <td class="DataTable" id="tdClrName<%=i%>"><%=sClrName%></td>
            <td class="DataTable" id="tdSizName<%=i%>"><%=sSizName%></td>
            <td class="DataTable" id="tdSku<%=i%>"><%=sSku%></td>
            <td class="DataTable" id="tdDesc<%=i%>"><%=sDesc%></td>
            <td class="DataTable" id="tdVenName<%=i%>"><%=sVenName%></td>
            <td class="DataTable" id="tdVenSty<%=i%>"><%=sVenSty%></td>
            <td class="DataTable" id="tdReason<%=i%>"><%=sReasonName%>&nbsp;</td>
            <td class="DataTable" id="tdCost<%=i%>"><%=sCost%>&nbsp;</td>
            <td class="DataTable" id="tdComment<%=i%>"><%=sComment%>&nbsp;</td>
            <td class="DataTable" id="tdDocNum<%=i%>"><%=sDocNum%>&nbsp;</td>
            <td class="DataTable" id="tdRaNum<%=i%>" onMouseDown="selColumnCell(this, <%=i%>,'<%=sStrLst%>', '<%=sSku%>', '<%=sSeq%>', 'RANUM')"><%=sRaNum%><%if(sRaNum.trim().equals("")){%>&nbsp;<%}%></td>
            <td class="DataTable1" id="tdMarkout<%=i%>" onclick="markItem(this, '<%=sStrLst%>', '<%=sSku%>', '<%=sSeq%>', 'MARKOUT')"><%=sMarkOutStock%><%if(sMarkOutStock.trim().equals("")){%>&nbsp;<%}%></td>
            <td class="DataTable1" id="tdRecall<%=i%>" onclick="markItem(this, '<%=sStrLst%>', '<%=sSku%>', '<%=sSeq%>', 'RECALL')"><%=sRecall%><%if(sRecall.trim().equals("")){%>&nbsp;<%}%></td>
            <td class="DataTable1" id="tdDefect<%=i%>" onclick="markItem(this, '<%=sStrLst%>', '<%=sSku%>', '<%=sSeq%>', 'DEFECT')"><%=sDefect%><%if(sDefect.trim().equals("")){%>&nbsp;<%}%></td>
            <td class="DataTable" id="tdLstDate<%=i%>"><%=sLstRcpt%>&nbsp;</td>
            <td class="DataTable" id="tdRaDate<%=i%>"><%=sRaDate%>&nbsp;</td>
            <td class="DataTable" id="tdRaTime<%=i%>"><%=sRaTime%>&nbsp;</td>
            <td class="DataTable" id="tdRaUser<%=i%>"><%=sRaUser%>&nbsp;</td>
            <td class="DataTable" id="tdRgDate<%=i%>"><%=sRgDate%>&nbsp;</td>
            <%if(!bBuyer) {%>
               <td class="DataTable2" id="tdDelete<%=i%>"
                   onClick="rtvItem(<%=sStrLst%>, '<%=sSku%>', '<%=sSeq%>', '<%=sDesc%>',
                   ' ', ' ', ' ', ' ', ' ', ' ', 'tdDelete<%=i%>', 'DLT');">Delete</td>
            <%}%>
          </tr>
       <%}%>
       </table>
<!-- ======================================================================= -->
       </TD>
     </TR>
     <tr>
       <TD vAlign=top align=left>
<!-- =================== Store Totals ====================================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbTotal">
         <tr  class="DataTable">
           <th class="DataTable">From<br>Store</th>
           <th class="DataTable">Number Of<br>Items</th>
           <th class="DataTable">Total<br>Cost</th>
         </tr>
         <%for(int i=0; i < iNumOfStr; i++ ){%>
          <%
            rtvreg.setStrTotal();
            String sStr = rtvreg.getStr();
            String sTotNum = rtvreg.getTotNum();
            String sCost = rtvreg.getCost();
          %>
          <tr class="DataTable2">
            <td class="DataTable1"><%=sStr%></td>
            <td class="DataTable1"><%=sTotNum%></td>
            <td class="DataTable4"><%=sCost%></td>
          </tr>
         <%}%>
         <%
           rtvreg.setRepTotal();
           String sTotNum = rtvreg.getTotNum();
           String sCost = rtvreg.getCost();
         %>
         <tr class="DataTable2">
            <td class="DataTable1">ReportTotal</td>
            <td class="DataTable1"><%=sTotNum%></td>
            <td class="DataTable4"><%=sCost%></td>
          </tr>
       </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
     rtvreg.disconnect();
   }
%>