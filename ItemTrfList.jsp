<%@ page import="itemtransfer.ItemTrfList"%>
<%
   String sDivision = request.getParameter("DIVISION");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sVendor = request.getParameter("VENDOR");
   String sStyle = request.getParameter("STYLE");
   String sColor = request.getParameter("COLOR");
   String sSize = request.getParameter("SIZE");

   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sVendor == null) sVendor = " ";
   if(sStyle == null) sStyle = " ";
   if(sColor == null) sColor = " ";
   if(sSize == null) sSize = " ";

   ItemTrfList itemTrf = new ItemTrfList(sClass, sVendor, sStyle, sColor, sSize );

   int iNumOfItm = itemTrf.getNumOfItm();
    String [] sCls = itemTrf.getCls();
    String [] sVen = itemTrf.getVen();
    String [] sSty = itemTrf.getSty();
    String [] sClr = itemTrf.getClr();
    String [] sSiz = itemTrf.getSiz();
    String [] sDesc = itemTrf.getDesc();
    String [] sChainInv = itemTrf.getChainInv();

    int [] iNumOfTrf = itemTrf.getNumOfTrf();
    String [][] sTrfIStr = itemTrf.getTrfIStr();
    String [][] sTrfDStr = itemTrf.getTrfDStr();
    String [][] sTrfQty = itemTrf.getTrfQty();
    String [][] sTrfUser = itemTrf.getTrfUser();
    String [][] sTrfDate = itemTrf.getTrfDate();
    String [][] sTrfTime = itemTrf.getTrfTime();

    String [][] sTrfIOldInv = itemTrf.getTrfIOldInv();
    String [][] sTrfINewInv = itemTrf.getTrfINewInv();
    String [][] sTrfDOldInv = itemTrf.getTrfDOldInv();
    String [][] sTrfDNewInv = itemTrf.getTrfDNewInv();
    String [][] sTrfISls = itemTrf.getTrfISls();
    String [][] sTrfDSls = itemTrf.getTrfDSls();

   itemTrf.disconnect();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:maccasin;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { color:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable3 { color:blue; cursor: hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}

        <!-------- select another div/dpt/class pad ------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }

        <!-------- transfer entry pad ------->
        div.fake { }
        div.dvTransfer { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
        div.dvMenu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:Azure; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { text-align:left; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right;
                    font-family:Arial; font-size:11px; font-weight:bolder}

        td.Menu { cursor:hand; text-align:left; font-family:Arial; font-size:10px;}
        <!-------- end transfer entry pad ------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
this.focus();
var Division ="<%=sDivision%>";
var Department ="<%=sDepartment%>";
var dltCell = null;
//--------------- End of Global variables ----------------
function bodyLoad()
{
}

function deleteTransfer(cls, ven, sty, clr, size, ist, dst, obj)
{
  dltCell = obj;
  var url = "ItemTrfEnt.jsp?"
         + "CLASS=" + cls
         + "&VENDOR=" + ven
         + "&STYLE=" + sty
  if(clr != null)
  {
    url += "&COLOR=" + clr
        + "&SIZE=" + size
  }

  url += "&ISTR=" + ist
      + "&DSTR=" + dst
      + "&ACTION=DLTTRF";

  //alert(url);
  //window.location.href = url;
  window.frame1.location = url;
}

//-------------------------------------------------------------
// Confirm Transfer entry Change or Delete
//-------------------------------------------------------------
function cnfTransfer(confirm)
{
  dltCell.innerHTML="deleted";
  dltCell.style.color="black";
  dltCell.style.cursor="text";
  dltCell.onclick=null;
}


// -------------------------------------------------------------------
//                       Move Boxes
//--------------------------------------------------------------------
var dragapproved=false
var z,x,y
function move(){
if (event.button==1&&dragapproved){
z.style.pixelLeft=temp1+event.clientX-x
z.style.pixelTop=temp2+event.clientY-y
return false
}
}
function drags()
{
  if (!document.all) return;
  var obj = event.srcElement

  if (event.srcElement.className=="Grid")
  {
    while (obj.offsetParent)
    {
      if (obj.id=="dvTransfer")
      {
        z=obj;
        break;
      }
      obj = obj.offsetParent;
    }
    dragapproved=true;
    temp1=z.style.pixelLeft
    temp2=z.style.pixelTop
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
  }
}

document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------
</SCRIPT>


</head>
<title>Transfer Request List</title>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
    <div id="dvTransfer"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Item Transfer Request Listing
      </b>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP">
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%">
        <tr>
          <th class="DataTable" rowspan="2">Item</th>
          <th class="DataTable" rowspan="2">Chain<br>Inv</th>

          <th class="DataTable" rowspan="2">Dlt</th>

          <th class="DataTable" rowspan="2">Qty</th>
          <th class="DataTable" colspan="3">Issued<br>Store</th>
          <th class="DataTable" colspan="3">Destination<br>Store</th>
          <th class="DataTable" rowspan="2">User</th>
          <th class="DataTable" rowspan="2">Date</th>
          <th class="DataTable" rowspan="2">Time</th>
        </tr>
        <tr>
          <th class="DataTable">Str</th>
          <th class="DataTable">Old<br>Inv</th>
          <th class="DataTable">New<br>Inv</th>
          <th class="DataTable">Str</th>
          <th class="DataTable">Old<br>Inv</th>
          <th class="DataTable">New<br>Inv</th>
        </tr>

<!------------------------------- Detail Data --------------------------------->
  <%for(int i=0; i < iNumOfItm; i++) {%>
  <tr  class="DataTable">
        <td class="DataTable1" nowrap rowspan="<%=iNumOfTrf[i]%>">
           <%=sCls[i] + "-" + sVen[i]+ "-" + sSty[i]+ "-" + sClr[i]+ "-" + sSiz[i]%><br>
           <%=sDesc[i]%>
        </td>
        <td class="DataTable" rowspan="<%=iNumOfTrf[i]%>"><%=sChainInv[i]%></td>

        <td class="DataTable3" nowrap id="<%=sCls[i]+sVen[i]+sSty[i]+sClr[i]+sSiz[i]%>"
           onclick="deleteTransfer('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', '<%=sClr[i]%>', '<%=sSiz[i]%>',
           '<%=sTrfIStr[i][0]%>', '<%=sTrfDStr[i][0]%>', this)"><u>dlt</u></td>
        <td class="DataTable2" nowrap><%=sTrfQty[i][0]%></td>

        <td class="DataTable" nowrap><%=sTrfIStr[i][0]%></td>
        <td class="DataTable2" nowrap><%=sTrfIOldInv[i][0]%></td>
        <td class="DataTable2" nowrap><%=sTrfINewInv[i][0]%></td>

        <td class="DataTable" nowrap><%=sTrfDStr[i][0]%></td>
        <td class="DataTable2" nowrap><%=sTrfDOldInv[i][0]%></td>
        <td class="DataTable2" nowrap><%=sTrfDNewInv[i][0]%></td>

        <td class="DataTable" nowrap><%=sTrfUser[i][0]%></td>
        <td class="DataTable" nowrap><%=sTrfDate[i][0]%></td>
        <td class="DataTable" nowrap><%=sTrfTime[i][0]%></td>
  </tr>
  <!-------------------------------Item Detail ---------------------------------->
     <%for(int j=1; j < iNumOfTrf[i]; j++) {%>
       <tr  class="DataTable">
        <td class="DataTable3" nowrap id="<%=sCls[i]+sVen[i]+sSty[i]+sClr[i]+sSiz[i]%>"
           onclick="deleteTransfer('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', '<%=sClr[i]%>', '<%=sSiz[i]%>',
           '<%=sTrfIStr[i][j]%>', '<%=sTrfDStr[i][j]%>', this)"><u>dlt</u></td>

        <td class="DataTable" nowrap><%=sTrfQty[i][j]%></td>

        <td class="DataTable" nowrap><%=sTrfIStr[i][j]%></td>
        <td class="DataTable" nowrap><%=sTrfIOldInv[i][j]%></td>
        <td class="DataTable" nowrap><%=sTrfINewInv[i][j]%></td>

        <td class="DataTable" nowrap><%=sTrfDStr[i][j]%></td>
        <td class="DataTable" nowrap><%=sTrfDOldInv[i][j]%></td>
        <td class="DataTable" nowrap><%=sTrfDNewInv[i][j]%></td>

        <td class="DataTable" nowrap><%=sTrfUser[i][j]%></td>
        <td class="DataTable" nowrap><%=sTrfDate[i][j]%></td>
        <td class="DataTable" nowrap><%=sTrfTime[i][j]%></td>
      </tr>
     <%}%>
<!-------------------------------End Item Detail ------------------------------>
  <%}%>
    <!----------------------- end of data ------------------------>
 </table>
 <!----------------------- end of table ------------------------>

  </table>
 </body>
</html>
