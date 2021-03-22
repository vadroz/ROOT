<%@ page import="ecommerce.EComUncondExcl"%>
<%
    String sSelStr = request.getParameter("Str");
    String sSelDiv = request.getParameter("Div");
    String sSelDpt = request.getParameter("Dpt");
    String sSelCls = request.getParameter("Cls");
    String sSelVen = request.getParameter("Ven");
    String [] sSts = request.getParameterValues("Sts");
    String sSort = request.getParameter("Sort");
    String sSelSku = request.getParameter("Sku");

    if(sSort == null){ sSort = "SKUASCN"; }
    if(sSelSku == null){ sSelSku = " "; }
    if(sSelDiv == null){ sSelDiv = "ALL"; }
    if(sSelDpt == null){ sSelDpt = "ALL"; }
    if(sSelCls == null){ sSelCls = "ALL"; }
    if(sSelVen == null){ sSelVen = "ALL"; }
    if(sSts == null){ sSts = new String[]{" "}; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComUncondExcl.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    //System.out.println(sSelStr + "|" + sSelDiv + "|" + sSelDpt + "|" + sSelCls
    // + "|" + sSelVen + "|" + sSts[0] + "|" + sSelSku + "|" + sSort + "|" + sUser);
    EComUncondExcl prodlst = new EComUncondExcl(sSelStr, sSelDiv, sSelDpt, sSelCls
                    , sSelVen, sSts, sSelSku, sSort, sUser);
    String sStsJsa = prodlst.cvtToJavaScriptArray(sSts);
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

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
//------------------------------------------------------------------------------
var Sts = [<%=sStsJsa%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true;}
	
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
// add/chg/delete item entry
//==============================================================================
function chgItem(sku, qty, reason, expdt, emp, rdesc, action)
{
   var hdr = "";
   if(action == "ADD") { hdr = "Add SKU " + sku +  " as Defected Items"; }
   else if(action == "CHG") { hdr = "Changed SKU " + sku; }
   else if(action == "DLT") { hdr = "Delete SKU " + sku; }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popUncondItem(action)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "350";}
   else { document.all.dvItem.style.width = "auto";}
   
   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.left = getLeftScreenPos() + 140;
   document.all.dvItem.style.top = getTopScreenPos() + 95;
   document.all.dvItem.style.visibility = "visible";

   if(action == "ADD")
   {
      document.all.Sku.focus();
      document.all.Qty.value = 1;
      var date = new Date(new Date() - -7 * 86400000);
      document.all.ExpDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
      document.all.NoExpDt.checked = true;
      setExpDt(document.all.NoExpDt);

   }
   if(action == "CHG" || action == "DLT")
   {
      document.all.Sku.value = sku;
      document.all.Sku.readOnly = true;
      document.all.Qty.value = qty;
      document.all.Reason.value = reason;
      document.all.Desc.value = rdesc;
      if(expdt == "None")
      {
         document.all.NoExpDt.checked = true;
         setExpDt(document.all.NoExpDt);
      }
      else { document.all.ExpDt.value = expdt; }

      document.all.Emp.value = emp;
   }
   if( action == "DLT")
   {
      document.all.Qty.readOnly = true;
      document.all.Reason.readOnly = true;
      document.all.Desc.readOnly = true;
      document.all.ExpDt.readOnly = true;
      document.all.Emp.readOnly = true;
   }

   document.all.ReasLst.options[0] = new Option("---- Select Reason ----", 0)
   document.all.ReasLst.options[1] = new Option("RTV","RTV")
   document.all.ReasLst.options[2] = new Option("Damaged / used","Damaged / used")
   document.all.ReasLst.options[3] = new Option("Cannot Locate","Cannot Locate")
   document.all.ReasLst.options[4] = new Option("Intransit","Intransit")
   document.all.ReasLst.options[5] = new Option("Other","Other")

}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popUncondItem(action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable1'>"
           + "<td class='DataTable2' >SKU:</td>"
           + "<td class='DataTable1'><input name='Sku' size=8 maxlength=13></td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Quantity:</td>"
           + "<td class='DataTable1'><input name='Qty' size=3 maxlength=3></td>"
       + "</tr>"

       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Reason:</td>"
           + "<td class='DataTable1'><input name='Reason' size=30 maxlength=30 readonly> &nbsp;  &nbsp;  &nbsp; "
              + "<select class='Small' onchange='setReasStr(this)' name='ReasLst'></select>"
           + "</td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Description:</td>"
           + "<td class='DataTable1'><input name='Desc' size=50 maxlength=50>"
           + "</td>"
       + "</tr>"

       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Expiration Date:</td>"
           + "<td class='DataTable1'>"
              + "<span id='spnExpDt'>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ExpDt&#34;)'>&#60;</button>"
              + "<input name='ExpDt' class='Small' size='10' readonly>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;ExpDt&#34;)'>&#62;</button>"
              + "<a href='javascript:showCalendar(1, null, null, 680, 170, document.all.ExpDt)'>"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a> &nbsp; "
              + "</span>"
              + "<input name='NoExpDt' type='checkbox' value='Y' onclick='setExpDt(this)'>No Expiration Date"
           + "</td>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Employee Number:</td>"
           + "<td class='DataTable1'><input name='Emp'  size=4 maxlength=4 ></td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable1' style='color:red; font-weight:bold;' colspan=2 id='tdError'></td>"
       + "</tr>"

  panel += "<tr class='DataTable1'>";
  panel += "<td class='DataTable' colspan=2><br><br><button onClick='Validate(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// set selected reason
//==============================================================================
function  setReasStr(selReas)
{
  if(selReas.options[selReas.selectedIndex].value != "0")
  {
     document.all.Reason.value = selReas.options[selReas.selectedIndex].value;
     if (selReas.options[selReas.selectedIndex].value == "Intransit")
     {
        var expdt = document.all["ExpDt"];
        var date = new Date(new Date() - -86400000 * 3);
        expdt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
        document.all.NoExpDt.checked = false;
        setExpDt(document.all.NoExpDt);
     }
  }
  else{document.all.Reason.value = ""; }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setExpDt(noexp)
{
   if(noexp.checked) { document.all.spnExpDt.style.display = "none"; }
   else{ document.all.spnExpDt.style.display = "inline"; }
}
//==============================================================================
// populate date with prior aor future dates
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
// validate entries
//==============================================================================
function Validate(action)
{
   var error = false;
   var msg = "";
   document.all.tdError.innerHTML = msg;

   var sku = document.all.Sku.value.trim();
   if(sku == ""){ error=true; msg += "<br>Please enter the SKU number." }
   if(isNaN(sku)){ error=true; msg += "<br>The SKU value is not a numeric." }

   var qty = document.all.Qty.value.trim();
   if(qty == ""){ error=true; msg += "<br>Please enter the Quantity of defected items." }
   else if(isNaN(qty)){ error=true; msg += "<br>The Quantity value is not a numeric." }
   else if(eval(qty) <= 0){ error=true; msg += "<br>The Quantity value must be greater than 0." }

   var reas = document.all.Reason.value.trim();
   if(reas == ""){ error=true; msg += "<br>Please enter the Reason for defecting items." }
   var rdesc = document.all.Desc.value.trim();
   if(reas == "Other" && rdesc == ""){ error=true; msg += "<br>Please enter the Reason description." }


   var expdt = document.all.ExpDt.value.trim();
   if(document.all.NoExpDt.checked) { expdt = "None"; }

   var emp = document.all.Emp.value.trim();
   if(emp == ""){ error=true; msg += "<br>Please enter the Employee RCI number." }
   if(isNaN(emp)){ error=true; msg += "<br>The Employee value is not a numeric." }

   if (error){ document.all.tdError.innerHTML = msg; }
   else{ sbmUncondSku(sku, qty, reas, rdesc, expdt, emp, action) }
}
//==============================================================================
// save changes
//==============================================================================
function sbmUncondSku(sku, qty, reas, rdesc, expdt, emp, action)
{
    reas = reas.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmUncondSku"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='EComUncondExclSave.jsp'>"
       + "<input class='Small' name='Str'>"
       + "<input class='Small' name='Sku'>"
       + "<input class='Small' name='Qty'>"
       + "<input class='Small' name='Reason'>"
       + "<input class='Small' name='RDesc'>"
       + "<input class='Small' name='ExpDt'>"
       + "<input class='Small' name='Emp'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Str.value="<%=sSelStr%>";
   window.frame1.document.all.Sku.value=sku;
   window.frame1.document.all.Qty.value=qty;
   window.frame1.document.all.Reason.value=reas;
   window.frame1.document.all.RDesc.value=rdesc;
   window.frame1.document.all.ExpDt.value=expdt;
   window.frame1.document.all.Emp.value=emp;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
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
//==============================================================================
// show errors
//==============================================================================
function resort(sort)
{
   var url= "EComUncondExcl.jsp?Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>"
      + "&Ven=<%=sSelVen%>&Str=<%=sSelStr%>&Sku=<%=sSelSku%>&Sort=" + sort
   for(var i=0; i < Sts.length; i++){ url += "&Sts=" + Sts[i]; }
   window.document.location.href=url;
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
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Items Excluded from Available to Sell - Selection
        </B>

        <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComUncondExclSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: chgItem(null, null, null, null, null, null, 'ADD')">Add Item</a>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Div</th>
             <th class="DataTable">Dpt</th>
             <th class="DataTable">Item Long Number</th>
             <th class="DataTable">Sku</th>
             <th class="DataTable">Name</th>

             <th class="DataTable" rowspan=2>Excl.<br>Qty</th>
             <th class="DataTable" rowspan=2>Store<br>Qty</th>
             <th class="DataTable" rowspan=2>Reason</th>
             <th class="DataTable" rowspan=2>Expiration</th>
             <th class="DataTable" rowspan=2>Employee</th>

             <th class="DataTable">Product<br>Price</th>
             <th class="DataTable">Sales<br>Price</th>
             <th class="DataTable" rowspan=2>Recorded By</th>
             <th class="DataTable" rowspan=2>D<br>l<br>t</th>
         </tr>
         <tr>
           <th class="DataTable" nowrap>
             <a href="javascript: resort('DIVDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
             <a href="javascript: resort('DIVASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
           </th>
           <th class="DataTable" nowrap>
             <a href="javascript: resort('DPTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
             <a href="javascript: resort('DPTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
           </th>
           <th class="DataTable" nowrap>
             <a href="javascript: resort('ITEMDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
             <a href="javascript: resort('ITEMASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
           </th>
           <th class="DataTable" nowrap>
             <a href="javascript: resort('SKUDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
             <a href="javascript: resort('SKUASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
           </th>
           <th class="DataTable" nowrap>
             <a href="javascript: resort('NAMEDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
             <a href="javascript: resort('NAMEASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
           </th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%while(prodlst.getNext())
         {
            prodlst.getProd();
            String sDiv = prodlst.getDiv();
            String sDpt = prodlst.getDpt();
            String sCls = prodlst.getCls();
            String sVen = prodlst.getVen();
            String sSty = prodlst.getSty();
            String sClr = prodlst.getClr();
            String sSiz = prodlst.getSiz();
            String sSku = prodlst.getSku();
            String sInvQty = prodlst.getInvQty();
            String sProdPrc = prodlst.getProdPrc();
            String sSlsPrc = prodlst.getSlsPrc();
            String sVenNm = prodlst.getVenNm();
            String sDesc = prodlst.getDesc();
            String sProdNm = prodlst.getProdNm();
            String sWhsQty = prodlst.getWhsQty();
            String sStr = prodlst.getStr();
            String sUncQty = prodlst.getUncQty();
            String sReason = prodlst.getReason();
            String sExpDt = prodlst.getExpDt();
            String sEmp = prodlst.getEmp();
            String sRecUsr = prodlst.getRecUsr();
            String sRecDt = prodlst.getRecDt();
            String sRecTm = prodlst.getRecTm();
            String sEmpNm = prodlst.getEmpNm();
            String sRsnDesc = prodlst.getRsnDesc();
            String sRsnDesc1 = sRsnDesc.replaceAll("\"", "&#34;");
            sRsnDesc1 = sRsnDesc1.replaceAll("'", " ");
            sRsnDesc1 = sRsnDesc1.replaceAll("'", " ");            
       %>
          <tr class="DataTable">
            <td class="DataTable1" nowrap><%=sDiv%></td>
            <td class="DataTable1" nowrap><%=sDpt%></td>
            <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
            <td class="DataTable1" nowrap><a href="javascript: chgItem('<%=sSku%>', '<%=sUncQty%>','<%=sReason%>', '<%=sExpDt%>', '<%=sEmp%>', '<%=sRsnDesc1%>', 'CHG')"><%=sSku%></a></td>
            <td class="DataTable1" nowrap><%=sProdNm%></td>

            <td class="DataTable5" nowrap><%=sUncQty%></td>
            <td class="DataTable6" nowrap><%=sInvQty%></td>
            <td class="DataTable4" nowrap><%=sReason%>
              <%if(!sRsnDesc.equals("")){%><br><%=sRsnDesc%><%}%>
            </td>
            <td class="DataTable4" nowrap><%=sExpDt%></td>
            <td class="DataTable4" nowrap><%=sEmp%> <%=sEmpNm%></td>

            <td class="DataTable2" nowrap><%=sProdPrc%></td>
            <td class="DataTable2" nowrap><%=sSlsPrc%></td>
            <td class="DataTable4" nowrap><%=sRecUsr%> <%=sRecDt%> <%=sRecTm%></td>
            <th class="DataTable1" nowrap><a href="javascript: chgItem('<%=sSku%>', '<%=sUncQty%>', '<%=sReason%>', '<%=sExpDt%>', '<%=sEmp%>', '<%=sRsnDesc1%>', 'DLT')">D</a></th>
          </tr>
       <%}%>
     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   prodlst.disconnect();
   prodlst = null;
   }
%>