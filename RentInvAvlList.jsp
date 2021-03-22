<%@ page import="rciutility.RunSQLStmt, rental.RentDptClsList ,java.util.*, java.text.*"%>
<%
   String [] sSrchDpt = request.getParameterValues("Dpt");
   String sSrchStr = request.getParameter("Str");
   String sFrDate = request.getParameter("FrDate");
   String sSort = request.getParameter("Sort");
   String sSrchCls = request.getParameter("Cls");
   String [] sSrchTag = request.getParameterValues("Tag");  

   if (sSort == null){ sSort = "ITEM"; }
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

      RentDptClsList rentinv = new RentDptClsList(sSrchDpt, "vrozen");
      int iNumOfDpt = rentinv.getNumOfDpt();
      String [] sDpt = rentinv.getDpt();
      String [] sDptNm = rentinv.getDptNm();
      int [] iNumOfCls = rentinv.getNumOfCls();
      String [][] sCls = rentinv.getCls();
      String [][] sClsNm = rentinv.getClsNm();

      String sDptJsa = rentinv.getDptJsa();
      String sDptNmJsa = rentinv.getDptNmJsa();
      String sClsJsa = rentinv.getClsJsa();
      String sClsNmJsa = rentinv.getClsNmJsa();
%>


<html>
<head>
<title>Rent_Equipment_Availability</title>

<style>body {background:ivory; text-align:left;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;text-align:left;}

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px; vertical-align:top;}
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px; vertical-align:top; }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }
        tr.DataTable4 { background: white; font-size:11px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable4 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}
        #tdAllInv { display: none; }
        #tdAvlInv { display: block; }

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvChkItm  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px; width:20; background-color:LemonChiffon; z-index:0;
              text-align:left; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

        spnCont { display: none; }
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Dpt = [<%=sDptJsa%>];
var DptNm = [<%=sDptNmJsa%>];
var Cls = [<%=sClsJsa%>];
var ClsNm = [<%=sClsNmJsa%>];

var OpenDtl = new Array();

<%if(sSrchTag != null){%>
   var TagArr = new Array();

<%for(int i=0; i < sSrchTag.length; i++){%>TagArr[<%=i%>] = "<%=sSrchTag[i]%>"; <%}%>
   var TagCnt = 0;
<%}%>

var SelCls = null;

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm"]);
   <%if(sSrchCls != null){%>getClsAvail("<%=sSrchCls%>")<%}%>
}
//==============================================================================
// retreive Class Availability
//==============================================================================
function getClsAvail(cls)
{
   SelCls = cls;

   url="RentalClsItmAvail.jsp?Cls=" + cls
     + "&Str=<%=sSrchStr%>"
     + "&FrDate=<%=sFrDate%>"
   ;

   window.frame1.location.href=url;
}
//==============================================================================
// show open tag on redisplay
//==============================================================================
function showTagAgain()
{

  <%if(sSrchTag != null){%>
   if(TagCnt < TagArr.length)
   {
      var i = TagCnt;
      var objnm = "Cls" + TagArr[i]
      var cls = document.all[objnm].value;
      objnm = "Ven" + TagArr[i]
      var ven = document.all[objnm].value;
      objnm = "Sty" + TagArr[i]
      var sty = document.all[objnm].value;
      objnm = "Clr" + TagArr[i]
      var clr = document.all[objnm].value;
      objnm = "Siz" + TagArr[i]
      var siz = document.all[objnm].value;
      objnm = "Desc" + TagArr[i]
      var desc = document.all[objnm].value;
      objnm = "ClrNm" + TagArr[i]
      var clrnm = document.all[objnm].value;
      objnm = "SizNm" + TagArr[i]
      var siznm = document.all[objnm].value;
      getTagAvl(cls, ven, sty, clr, siz, desc, clrnm, siznm, TagArr[i])
      TagCnt++;
   }
  <%}%>
}
//==============================================================================
// retreive Tag (Serial Number) Availability for selected item
//==============================================================================
function getTagAvl(cls, ven, sty, clr, siz, desc, clrnm, siznm, irow)
{
   var max = OpenDtl.length;
   var found = false;
   var fndarg = -1;
   for(var i=0; i < max; i++)
   {
      if(OpenDtl[i]==irow){ found = true; fndarg=i; break;}
   }

   if(!found)
   {
      url="RentalItmTagAvail.jsp?Cls=" + cls
         + "&Ven=" + ven
         + "&Sty=" + sty
         + "&Clr=" + clr
         + "&Siz=" + siz
         + "&Str=<%=sSrchStr%>"
         + "&FrDate=<%=sFrDate%>"
         + "&Desc=" + desc
         + "&ClrNm=" + clrnm
         + "&SizNm=" + siznm
         + "&Row=" + irow
   ;

     OpenDtl[max] = irow;
     window.frame1.location.href=url;
   }
   else
   {
       var rowid = "trRow" + irow;
       var i=0;
       rowid += i;
       while(document.all[rowid] != null)
       {
          var row = document.all[rowid];
          row.parentNode.removeChild(row);
          i++;
          rowid = "trRow" + irow + i;
       }
       OpenDtl[fndarg] = null;
   }
}
//==============================================================================
// show tag availability
//==============================================================================
function showTagAvl(cls, ven, sty, clr, siz, desc, clrNm, sizNm, invId, srlNum, dateQty, dateAvlQty
  , date, month, day, contId, custId, firstNm, lastNm, group, prevDt, nextDt, sts, irow
  , str, itmSts, rmvDt, pickDt, rtnDt)
{

   var dummy="</table>";

   var rowid = "trRow" + irow;
   var tbl = document.all.tbClsDtl;

   for(var i=0; i < tbl.rows.length; i++)
   {
      if(tbl.rows[i].id == rowid)
      {
         irow=i+1;
         break;
      }
   }

   for(var i=0; i < srlNum.length; i++)
   {
     var row = tbl.insertRow(irow);
     row.id = rowid + i;
     row.className="DataTable3"
     var cell = row.insertCell(0);
     cell.className="DataTable1";
     cell.colSpan=3;
     cell.innerHTML = srlNum[i];

     var k=1;
     var color = "OrangeRed";

     if(itmSts[i]=="")
     {

     for(var j=0; j < date.length; j++, k++)
     {
        cell = row.insertCell(k);
        cell.className="DataTable2"
        if(dateAvlQty[i][j]=="")
        {
           if(sts[i][j]=="OPEN") { color = "OrangeRed"; }
           if(sts[i][j]=="READY") { color = "#ff9933"; }
           if(sts[i][j]=="PICKEDUP") { color = "lightblue"; }
           if(sts[i][j]=="RETURNED" && j < date.length-1 && dateAvlQty[i][j+1]=="") { color = "green"; }
           if(sts[i][j]=="RETURNED" && j < date.length-1 && dateAvlQty[i][j+1]!="") { color = "yellow"; }

           var html = "<span onmouseover='showCont(this, &#34;" + contId[i][j] + "&#34;"
                + ",&#34;" + sts[i][j] + "&#34;,&#34;" + firstNm[i][j] + "&#34;"
                + ",&#34;" + lastNm[i][j] + "&#34;,&#34;" + group[i][j] + "&#34;"
                + ",&#34;" + pickDt[i][j] + "&#34;,&#34;" + rtnDt[i][j] + "&#34;"
                + ")'"
                + " onmouseout='/*hideCont()*/'>";
           var dash = true;
           if(j==0 || dateAvlQty[i][j-1]!=""){ html += "&nbsp;<&nbsp;"; dash = false; }
           if(j == date.length - 1 || dateAvlQty[i][j+1]!=""){ html += "&nbsp;>&nbsp;"; dash = false; }
           if(dash){ html += "&nbsp;-&nbsp;"; }

           html += "</span>";
           cell.innerHTML = html;

           cell.style.background = color;
        }
        // caution for renting equipment on the prior date of the rent
        else if(j < date.length - 1 && dateAvlQty[i][j+1]=="")
        {
           if(sts[i][j+1]!="RETURNED"){ cell.style.background = "yellow"; }
           cell.innerHTML = "&nbsp;";
        }
        // caution for renting equipment on the prior date of the rent
        else if(j > 0 && dateAvlQty[i][j-1]=="")
        {
           if(sts[i][j-1]!="RETURNED"){ cell.style.background = "yellow"; }
           cell.innerHTML = "&nbsp;";
        }
        else { cell.innerHTML = "<span onmouseout='hideCont()'>&nbsp;&nbsp;&nbsp;</span>"; }
     }
     }
     else
     {
         cell = row.insertCell(k);
         cell.className = "DataTable2"
         cell.colSpan = date.length;
         cell.innerHTML = itmSts[i] + ", Removed:" + rmvDt[i];
         cell.style.background = "black";
         cell.style.color = "white";
     }
     k++;
     cell = row.insertCell();
     cell.className="DataTable2"
     cell.style.background = "#FFCC99";
     cell.innerHTML = "&nbsp;";

     irow++;
   }

   <%if(sSrchTag != null){%>
      if(TagCnt < TagArr.length){ showTagAgain(); }
   <%}%>

}

//==============================================================================
// fold Tag table
//==============================================================================
function foldTagRow(row)
{
   var tdrow = "tdRow" + row
   document.all[tdrow].innerHTML = "";
}
//==============================================================================
// show Contract and customer
//==============================================================================
function showCont(obj, contId, sts, firstNm, lastNm, group, pickDt, rtnDt)
{
   var html = "<table style='width=100%; font-size:11px'>"
      + "<tr>"
         + "<td style='white-space:nowrap;'>"
           + "Contract: <a href='RentContractInfo.jsp?&ContId=" + contId + "' target='_blank'>"
           + contId + "</a><br>Status: " + sts + "<br>First Name: " + firstNm
           + "<br>Last Name: " + lastNm
           + "<br>Pickup " + pickDt + " &nbsp; Drop off " + rtnDt
         + "</td>"
      + "</tr>"
    + "</table>"

   var pos = getObjPosition(obj);

   document.all.dvHelp.innerHTML = html;
   document.all.dvHelp.style.pixelLeft= pos[0] + 10;
   document.all.dvHelp.style.pixelTop= pos[1] + 1;
   document.all.dvHelp.style.visibility = "visible";
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hideCont()
{
   document.all.dvHelp.innerHTML = " ";
   document.all.dvHelp.style.visibility = "hidden";
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvChkItm.innerHTML = " ";
   document.all.dvChkItm.style.visibility = "hidden";
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(numdy, direction)
{
  var date = new Date("<%=sFrDate%>");

  if(direction == "DOWN") date = new Date(new Date(date) - numdy * 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * numdy);

  var url = "RentInvAvlList.jsp?"

  for(var i=0; i < Dpt.length; i++)
  {
     url += "&Dpt=" + Dpt[i]
  }
  url += "&Sort=ITEM"
       + "&Str=<%=sSrchStr%>"
       + "&FrDate=" + (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
       + "&Cls=" + SelCls

   var max = OpenDtl.length;
   for(var i=0; i < max; i++)
   {
      if(OpenDtl[i]!=null){ url += "&Tag=" + OpenDtl[i]; }
   }


  //alert(url)
  window.location.href=url;
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
<div id="dvHelp" class="dvHelp"></div>
<div id="dvChkItm" class="dvChkItm"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="Left" VALIGN="TOP" nowrap>
        <b>Check Availability
        <br>Store: <%=sSrchStr%>
      </td>
    </tr>

    <tr>
      <td ALIGN="left" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="RentInvAvlListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
      &nbsp; &nbsp; <a href="RentContractInfo.jsp" target="_blank">New Contract</a>
      <br>
      <br>
      <!--a href="javascript: getMarkedItemDtl()">Check out</a -->
  <!-------------------- Department/class List List --------------------------->
     <table class="DataTable" cellPadding="0" cellSpacing="0" id="tbDept">
       <tr class="DataTable">
         <%for(int i=0; i < iNumOfDpt; i++){%>
           <th class="DataTable"><%=sDptNm[i]%>
             <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbClass">
               <%for(int j=0; j < iNumOfCls[i]; j++){%>
                 <tr class="DataTable1">
                   <td class="DataTable"><a href="javascript: OpenDtl = new Array(); getClsAvail('<%=sCls[i][j]%>')"><%=sClsNm[i][j]%></a></td>
                 </tr>
               <%}%>
             </table>
           </th>
         <%}%>
      </tr>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

   <tr>
     <td ALIGN="left" VALIGN="TOP">
       <table border=0>
         <tr>
           <td VALIGN="TOP"><br><div id="dvClsDtl"></div> &nbsp;</td>
   </tr>
  </table>
 </body>
</html>


<%
  }%>