<%@ page import="aim.AmEmpLst"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sSort = request.getParameter("Sort");

   if (sSort == null) { sSort = "NAME"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AmEmpLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmEmpLst emplst = new AmEmpLst(sSelStr, sSort, sUser);

      String sSelStrJsa = emplst.cvtToJavaScriptArray(sSelStr);
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:red;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#cccfff;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:12px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
        td.DataTable1 {padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable1p {background:gray;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
              text-align:center; font-size:10px}
                td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}

        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:bottom; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:bottom; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:bottom; font-family:Arial; font-size:10px; }

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelStr = [<%=sSelStrJsa%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
// change employee settings
//==============================================================================
function chgEmp(emp, name, email, waiver, prodty, size, init)
{
   var hdr = emp + " " + name;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popEmpInfo(emp, init)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";

   document.all.Email.value=email;
   if(prodty=="T") {document.all.ProdTy[0].checked=true; }
   else if(prodty=="B") {document.all.ProdTy[1].checked=true; }

   if(size=="T") { document.all.Size[0].checked=true; }
   else if(size=="S") {document.all.Size[1].checked=true; }
   else if(size=="M") {document.all.Size[2].checked=true; }
   else if(size=="L") {document.all.Size[3].checked=true; }
   else if(size=="X") {document.all.Size[4].checked=true; }
   else if(size=="Y") {document.all.Size[5].checked=true; }
}
//==============================================================================
// populate employee panel
//==============================================================================
function popEmpInfo(emp, init)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
            + "<td class='Prompt1'nowrap>E-Mail: </td>"
            + "<td class='Prompt1'nowrap><input class='Small' name='Email' size=50 maxlength=50></td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
            + "<td class='Prompt1' nowrap>Waiver: </td>"
            + "<td class='Prompt' nowrap>"
               + "<span style='font-family: Wingdings;' id='spnWvrCheck'>&#252; </span> &nbsp; &nbsp;"
               + "Init: " + init
               + "<input name='Init' type='hidden' value='" + init + "'>"
            + "</td>"
       + "</tr>"

       + "<tr class='DataTable2'>"
            + "<td class='Prompt1' nowrap>Product: </td>"
            + "<td class='Prompt' nowrap>"
              + "<input type='radio'  name='ProdTy' value='T' checked>T-Shirt &nbsp; &nbsp;"
              + "<input type='radio'  name='ProdTy' value='B'>Bike Jersey"
            + "</td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
            + "<td class='Prompt1' nowrap>Size: </td>"
            + "<td class='Prompt' nowrap>"
              + "<input type='radio'  name='Size' value='T' >X-Small &nbsp; &nbsp;"
              + "<input type='radio'  name='Size' value='S' >Small &nbsp; &nbsp;"
              + "<input type='radio'  name='Size' value='M' checked>Medium &nbsp; &nbsp;"
              + "<input type='radio'  name='Size' value='L' >Large &nbsp; &nbsp;"
              + "<input type='radio'  name='Size' value='X' >X-Large &nbsp; &nbsp;"
              + "<input type='radio'  name='Size' value='Y' >XX-Large &nbsp; &nbsp;"
            + "</td>"
       + "</tr>"

       + "<tr><td style='color:red;font-size:12px' colspan=2 id='tdError' nowrap></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=2>"
        + "<button onClick='vldEmpInf(&#34;" + emp + "&#34;)' class='Small'>Submit</button>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function vldEmpInf(emp)
{
   var error= false;
   var msg = "";
   document.all.tdError.innerHTML="";

   var email = document.all.Email.value.trim();
   if(email == ""){ error=true; msg += "Please enter E-Mail address"}
   else if(email.indexOf("@") < 1 || email.indexOf(".") < 3
        || email.indexOf(".") - email.indexOf("@") < 2)
   {
      error=true; msg += "E-Mail address number is invalid"
   }

   var waiver = "Y";
   var init = document.all.Init.value.trim();

   var prodty = "T";
   if(document.all.ProdTy[1].checked){ prodty = "B"; }

   var size = "X";
   if(document.all.Size[1].checked){ size = "S"; }
   else if(document.all.Size[2].checked){ size = "M"; }
   else if(document.all.Size[3].checked){ size = "L"; }
   else if(document.all.Size[4].checked){ size = "X"; }
   else if(document.all.Size[5].checked){ size = "Y"; }

   if(error){ document.all.tdError.innerHTML=msg; }
   else { sbmAddEmp(emp, email, waiver, prodty, size, init); }
}
//==============================================================================
// submit new employee entry
//==============================================================================
function sbmAddEmp(emp, email, waiver, prodty, size, init)
{
   email = email.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmEvt"

    var html = "<form name='frmAddUpdEmp'"
       + " METHOD=Post ACTION='AimEvtSv.jsp'>"
       + "<input name='emp'>"
       + "<input name='email'>"
       + "<input name='waiver'>"
       + "<input name='init'>"
       + "<input name='prodty'>"
       + "<input name='size'>"
       + "<input name='action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.emp.value = emp;
   window.frame1.document.all.email.value=email;
   window.frame1.document.all.waiver.value=waiver;
   window.frame1.document.all.init.value=init;
   window.frame1.document.all.prodty.value=prodty;
   window.frame1.document.all.size.value=size;

   window.frame1.document.all.action.value="CHGEMPPGM";

   window.frame1.document.frmAddUpdEmp.submit();
}
//==============================================================================
// delete employee settings
//==============================================================================
function dltEmp(emp, name)
{
   var hdr = emp + " " + name;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popDltEmp(emp)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate employee panel
//==============================================================================
function popDltEmp(emp)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr>"
             + "<td style='color:red;font-size:14px' id='tdError' nowrap>"
                + "<br><b>&nbsp;Are you sure that you want to delete this employee?<b>&nbsp;<br>&nbsp;"
             + "</td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1'>"
        + "<button onClick='dltEmpInf(&#34;" + emp + "&#34;)' class='Small'>Delete</button>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// submit new employee entry
//==============================================================================
function dltEmpInf(emp, email, waiver, prodty, size)
{
   var url = "AimEvtSv.jsp?emp=" + emp + "&action=DLTEMPPGM";
   //alert(url)
   window.frame1.location.href=url;
}
//==============================================================================
// restart
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{
   var url = "AimEmpLst.jsp?Store=<%=sSelStr%>"

   for(var i=0; i < SelStr.length; i++)  { url += "&Str=" + SelStr[i] }
   url += "&Sort=" + sort

   //alert(url)
   window.location.href = url;
}
//==============================================================================
// check that employee receved free jersey
//==============================================================================
function rcvFreeJersey(emp)
{
   var url = "AimEvtSv.jsp?emp=" + emp + "&action=CHKFREEJERSEY";
   //alert(url)
   window.frame1.location.href=url;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>AIM - Employees Assigned on Program
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="AimEmpLstSel.jsp"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

  <!----------------------- Order List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable"><a href="javascript: resort('EMP')">Emp<br>Num</a></th>
         <th class="DataTable"><a href="javascript: resort('NAME')">Employee Name</a></th>
         <th class="DataTable">Gender</th>
         <th class="DataTable"><a href="javascript: resort('STR')">Store</a></th>
         <th class="DataTable">All Event<br>Scores</th>
         <th class="DataTable">E-Mail</th>
         <th class="DataTable">Waiver</th>
         <th class="DataTable">T-Shirt<br>Bike Jersey</th>
         <th class="DataTable">Size</th>
         <th class="DataTable">Created/Updated<br>User, Date, Time</th>
         <th class="DataTable">Sent Free<br>Jersey</th>
         <th class="DataTable">&nbsp;</th>
         <th class="DataTable">No Longer<br>with RCI</th>
         <!--th class="DataTable">Delete</th-->
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    while( emplst.getNext() )
    {
       emplst.setEmpLst();
       String sEmp = emplst.getEmp();
       String sName = emplst.getName();
       String sEMail = emplst.getEMail();
       String sWaiver = emplst.getWaiver();
       String sProdTy = emplst.getProdTy();
       String sSize = emplst.getSize();
       String sRecUs = emplst.getRecUs();
       String sRecDt = emplst.getRecDt();
       String sRecTm = emplst.getRecTm();
       String sStr = emplst.getStr();
       String sScore = emplst.getScore();
       String sInit = emplst.getInit();
       String sJersey = emplst.getJersey();
       String sGender = emplst.getGender();
       String sSepr = emplst.getSepr();
       String sComa = "";
  %>
     <tr class="DataTable1">
       <td class="DataTable2"><a href="javascript: chgEmp('<%=sEmp%>', '<%=sName%>', '<%=sEMail%>', '<%=sWaiver%>', '<%=sProdTy%>', '<%=sSize%>', '<%=sInit%>')"><%=sEmp%></a></td>
       <td class="DataTable" nowrap><%=sName%></td>
       <td class="DataTable" nowrap><%=sGender%></td>
       <td class="DataTable1" nowrap><%if(sStr.equals("0")){%>HO<%} else{%><%=sStr%><%}%></td>
       <td class="DataTable1" nowrap>&nbsp;
          <%if(!sScore.equals("")){%><a href="AimEmpScrLst.jsp?emp=<%=sEmp%>&empnm=<%=sName%>"><%=sScore%></a><%}%>
       </td>
       <td class="DataTable" nowrap><%=sEMail%></td>
       <td class="DataTable1" nowrap><%if(sWaiver.equals("Y")){%><span style="font-family: Wingdings;">&#252;</span> &nbsp; <%=sInit%><%} else{%>&nbsp;<%}%></td>
       <td class="DataTable1" nowrap><%if(sProdTy.equals("T")){%>T-Shirt<%} else {%>Bike Jersey<%}%></td>
       <td class="DataTable1" nowrap><%if(sSize.equals("T")){%>X-Small<%} else if(sSize.equals("S")){%>Small<%} else if(sSize.equals("M")){%>Medium<%} else if(sSize.equals("L")){%>Large<%} else if(sSize.equals("X")){%>X-Large<%} else if(sSize.equals("Y")){%>XX-Large<%}%></td>
       <td class="DataTable" nowrap><%=sRecUs%> <%=sRecDt%> <%=sRecTm%></td>
       <td class="DataTable1"><input type="checkbox" onclick="javascript: rcvFreeJersey('<%=sEmp%>')" <%if(sJersey.equals("Y")){%>checked<%}%>></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%if(!sSepr.equals("")){%><a href="javascript: dltEmp('<%=sEmp%>', '<%=sName%>')">Delete?</a><%}%></td>

       <!--td class="DataTable2"><a href="javascript: dltEmp('<%=sEmp%>', '<%=sName%>')">Delete</a></td-->
       </tr>
  <%}%>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    emplst.disconnect();
    emplst = null;
%>
<%}%>