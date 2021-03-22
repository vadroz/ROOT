<%@ page import="rciutility.StoreSelect, java.util.*, java.text.*, java.sql.*, rciutility.RunSQLStmt"%>
<%
    String sSelStr = request.getParameter("Store");
    String sFrom = request.getParameter("FrDate");
    String sTo = request.getParameter("ToDate");

    String sPrepStmt = null;
    ResultSet rs = null;
    RunSQLStmt runsql = null;

    StoreSelect StrSelect = null;
    String sStrNum = null;
    String sStrName = null;
    String sStrAllowed = null;
    String sUser = null;
    int iStrAlwLst = 0;

//==============================================================================
// Application Authorization
//==============================================================================
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ArchiveTransInvAdj.jsp");
   }
//==============================================================================
   else {
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      StrSelect = new StoreSelect(3);
    }
    else
    {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
     else StrSelect = new StoreSelect(new String[]{sStrAllowed});
    }

    sStrNum = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();




    if(sSelStr != null)
    {
      sPrepStmt = "select AtIst, AtDiv, AtDpt, AtCls, clnm, AtRet, AtQty, AtPDat, AtTxt, AtSRet, AtVlc"
         + " from rci.ARCTRAN inner join Iptsfil.IpClass on ccls=AtCls"
         + " where attrcd in ('74', '75')"
         + " and attxt <> ' ' and attxt not like '%SALES%'"
         + " and atist = " + sSelStr
         + " and atpdat >= '" + sFrom + "'"
         + " and atpdat <= '" + sTo + "'"
         ;
System.out.println("\n" + sPrepStmt);

      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      rs = runsql.runQuery();
    }
%>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px; text-align:center;}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#ececec; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        .Small {font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;border: black solid 2px; width:200; background-color:#ccffcc; z-index:10;text-align:center; font-size:12px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
    .Small {margin-top:3px; font-size:10px }

</style>
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var stores = [<%=sStrNum%>];
var storeNames = [<%=sStrName%>];
var SelStr = null; <%if(sSelStr != null){%>SelStr = "<%=sSelStr%>";<%}%>
var FrDate = null; <%if(sFrom != null){%>FrDate = "<%=sFrom%>";<%}%>
var ToDate = null; <%if(sTo != null){%>ToDate = "<%=sTo%>";<%}%>
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
  doStrSelect();
  showAllDates()
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.forms[0];

    var selidx = 0;
    for (idx = 1; idx < stores.length; idx++)
    {
      df.Store.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
      if(SelStr != null && SelStr == stores[idx]) { selidx = idx-1; }
    }
    df.Store.selectedIndex=selidx;
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
      var date = new Date(new Date() - 86400000);

      // to sales date
      if(ToDate == null)
      {
         document.all.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
      }
      else { document.all.ToDate.value = ToDate }

      // from sales date
      date = new Date(date.getTime() - 60 * 86400000);

      if(FrDate == null)
      {
          document.all.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
      }
      else { document.all.FrDate.value = FrDate }
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
  else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

  if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
  else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


</script>

<body align=center  onload="bodyLoad();">
  <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr>
<!-------------------------------------------------------------------->
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Mark Out of Stock Inquiry

      <form action="ArchiveTransInvAdj.jsp" method="get">
        <table>
        <TR><TD ALIGN="center"><b>Store:</b> &nbsp; <select class="Small" name="Store"><select></TR>
        <TR>
          <TD align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate', 'DAY')">d-</button>
              <input class="Small" name="FrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 200, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date: </b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate', 'DAY')">d-</button>
              <input class="Small" name="ToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 800, 200, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
       </table>
       <input type="Submit" class="Small">
      </form>

      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp;

<%if(sSelStr != null){%>

<table class="DataTable" cellPadding="0" cellSpacing="0">
  <tr>
    <th class="DataTable">Store</th>
    <th class="DataTable">Div</th>
    <th class="DataTable">Dpt</th>
    <th class="DataTable">Class</th>
    <th class="DataTable">Store<br>Retail</th>
    <th class="DataTable">Store<br>Cost</th>
    <th class="DataTable">Qty</th>
    <th class="DataTable">Posting Dat</th>
    <th class="DataTable">Text</th>
  </tr>

  <%while(runsql.readNextRecord())
  {
     String sStr = runsql.getData("atist");
     String sDiv =  runsql.getData("atdiv");
     String sDpt = runsql.getData("atdpt");
     String sCls = runsql.getData("atcls");
     String sClsNm = runsql.getData("clnm");
     String sRet = runsql.getData("atret");
     String sQty = runsql.getData("atqty");
     String sDate = runsql.getData("atpdat");
     String sText = runsql.getData("attxt");
     String sSRet = runsql.getData("atsret");
     String sSCost = runsql.getData("atvlc");
  %>

  <tr class="DataTable">
      <td class="DataTable"><%=sStr%></td>
      <td class="DataTable"><%=sDiv%></td>
      <td class="DataTable"><%=sDpt%></td>
      <td class="DataTable1"><%=sCls%> - <%=sClsNm%></td>
      <td class="DataTable2"><%=sSRet%></td>
      <td class="DataTable2"><%=sSCost%></td>
      <td class="DataTable2"><%=sQty%></td>
      <td class="DataTable"><%=sDate.substring(5,7) + "/" + sDate.substring(8) + "/" + sDate.substring(0,4)%></td>
      <td class="DataTable1"><%=sText%></td>
    </tr>

  <%}%>
</table>
<%}%>
</table>
</body>
<%
   if(sSelStr != null){
      runsql.disconnect();
      runsql = null;
   }
}
%>