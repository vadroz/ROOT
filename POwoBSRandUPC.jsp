<%@ page import="posend.POwoBSRandUPC"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POwoBSRandUPC.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    if(session.getAttribute("BSREDIT")==null){response.sendRedirect("index.jsp");}

    String [] sDivision = request.getParameterValues("Div");
    String sVendor = request.getParameter("Vendor");
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sDivision.length + "|" + sVendor + sUser);
    POwoBSRandUPC poinclist = new POwoBSRandUPC(sDivision, sVendor, sUser);
    int iRow=0;
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin:none; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}


        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }


</style>


<script name="javascript1.2">
var SelRow = "<%=iRow%>";
var Div = new Array();
<%for(int i=0; i < sDivision.length; i++){%>
     Div[<%=i%>] = "<%=sDivision[i]%>"
<%}%>

//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
}
//==============================================================================
// show Item BSR Editing page
//==============================================================================
function sbmItemList(div, ven)
{
  var url = "ItemBSREdit.jsp?"
          + "Div=" + div
          + "&Dpt=ALL"
          + "&Cls=ALL"
          + "&Ven=" + ven

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// change comments for PO without UPC code
//==============================================================================
function chgUPCComment(po, com)
{
    //check if order is paid off
   var hdr = "Update PO: " + po;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popUPCCommentPanel(po, com)

   html += "</td></tr></table>"

   document.all.dvPOCommt.innerHTML = html;
   document.all.dvPOCommt.style.width = 250;
   document.all.dvPOCommt.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvPOCommt.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvPOCommt.style.visibility = "visible";
   document.all.Comment.value = com;
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popUPCCommentPanel(po, com)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt' nowrap>Comment &nbsp;</td>"
           + "<td class='Prompt' colspan='2'>"

  panel += "<input name=Comment class='Small' size=50 maxlength=50>"

  panel += "</td>" + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmUPCComment(&#34;" + po + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPOCommt.innerHTML = " ";
   document.all.dvPOCommt.style.visibility = "hidden";
}

//==============================================================================
// show Item BSR Editing page
//==============================================================================
function sbmUPCComment(po)
{
  com = document.all.Comment.value.replaceSpecChar();
  hidePanel();
  var url = "POCommentSave.jsp?"
          + "PO=" + po
          + "&Comment=" + com.trim()

  //alert(url)
  //window.location.href=url;
  window.frame1.location.href=url;
}
//==============================================================================
// close frame and restart page
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   window.location.reload()
}
//==============================================================================
// run table filter
//==============================================================================
function runFilter(exclude)
{
	for(var i=0; i < SelRow; i++)
	{
		var onhnm = "tdOnh" + i;
		var onh = document.all[onhnm].innerHTML;
		var rownm = "trRow" + i;
		var row = document.all[rownm];
		
		if(exclude && onh == '&nbsp;')
		{
		   row.style.display = "none"; 	
		}
		else if(!exclude){ row.style.display = "block"; }
	}
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<HTML><HEAD>

<META content="RCI, Inc." name=POList></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="dvPOCommt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Purchase Order w/o BSR or UPC
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="POwoBSRandUPCSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="inpExcl" onclick="runFilter(true)">Has onhands only
          &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="inpExcl" onclick="runFilter(false)"  checked>All
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">           
           <th class="DataTable">Division</th>
           <th class="DataTable">Str</th>
           <th class="DataTable">P.O.<br>Number</th>
           <th class="DataTable">Vendor</th>
           <th class="DataTable">Shipping<br>Delivery Date</th>
           <th class="DataTable">S<br>t<br>s</th>
           <th class="DataTable">Original<br>/Confirmation</th>
           <th class="DataTable">Buyer</th>
           <th class="DataTable">BSR<br>Exists</th>
           <th class="DataTable">UPC<br>Exists</th>
           <th class="DataTable">Last<br>Receipt<br>Date</th>
           <th class="DataTable">Store<br>OnHand</th>
           <th class="DataTable">Comments</th>
           <th class="DataTable">Dist</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%while(poinclist.setNext())
         {
           poinclist.setPOInfo();

           String sPo =  poinclist.getPo();
           String sDiv = poinclist.getDiv();
           String sDivName = poinclist.getDivName();
           String sVen = poinclist.getVen();
           String sVenName = poinclist.getVenName();
           String sAntcDate = poinclist.getAntcDate();
           String sCrtDate = poinclist.getCrtDate();
           String sDisc = poinclist.getDisc();
           String sOrig = poinclist.getOrig();
           String sRevNum = poinclist.getRevNum();
           String sBuyer = poinclist.getBuyer();
           String sShipDate = poinclist.getShipDate();
           String sComment = poinclist.getComment();
           String sSts = poinclist.getSts();
           String sUpcComment = poinclist.getUpcComment();
           String sNoBsr = poinclist.getNoBsr();
           String sNoUpc = poinclist.getNoUpc();
           String sStr = poinclist.getStr();
           String sLastRctDt = poinclist.getLastRctDt();
           String sOnHand = poinclist.getOnHand();
           String sVcDist = poinclist.getVcDist();
         %>
         <tr class="DataTable" id="trRow<%=iRow%>">
            <td class="DataTable1" nowrap><%=sDiv + " - " + sDivName%></td>
            <td class="DataTable2" nowrap><%=sStr%></td>
            <td class="DataTable1" nowrap><a href="POItemLst.jsp?PO=<%=sPo%>" class="small"><%=sPo%></a></td>
            <td class="DataTable1" nowrap><%=sVen + " - " + sVenName%></td>
            <td class="DataTable1" nowrap><%=sShipDate%></td>
            <td class="DataTable" nowrap><%=sSts%></td>
            <td class="DataTable" nowrap><%=sOrig%><%if(!sRevNum.trim().equals("")){%><%="-" + sRevNum%><%}%></td>
            <td class="DataTable" nowrap><%=sBuyer%></td>
            <td class="DataTable" <%if(sNoBsr.equals("1")){%>style="background: pink;"<%}%>nowrap><%if(!sNoBsr.equals("1")){%>Y<%} else{%>N<%}%></td>
            <td class="DataTable" nowrap><%if(!sNoUpc.equals("1")){%>Y<%} else{%>N<%}%></td>
            <td class="DataTable2" nowrap>&nbsp;<%=sLastRctDt%>&nbsp;</td>
            <td class="DataTable2" id="tdOnh<%=iRow%>" nowrap>&nbsp;<%=sOnHand%></td>
            <td class="DataTable1" nowrap><a href="javascript: chgUPCComment('<%=sPo%>', '<%=sUpcComment%>')  "><%=sUpcComment%><%if(sUpcComment.length() == 0){%>Add Comments<%}%></a></td>
            <td class="DataTable" nowrap><%=sVcDist%></td>
          </tr>
       <%iRow++;
         }
       %>
       <script>SelRow = "<%=iRow%>";</script>
       </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   poinclist.disconnect();
   poinclist = null;
%>
<%}%>