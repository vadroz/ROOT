<%@ page import="ecommerce.EComKioskSlsCont, ecommerce.EComKioskSlsDiv ,java.util.*, java.text.*, java.math.*"%>
<%
    String sFrDate = request.getParameter("FrDate");
    String sToDate = request.getParameter("ToDate");
    String sSort = request.getParameter("Sort");
    String sReturn = request.getParameter("Return");

    String sSelDiv = request.getParameter("Div");
    String sSelDpt = request.getParameter("Dpt");
    String sSelCls = request.getParameter("Cls");

    if(sSelDiv == null){ sSelDiv = "ALL"; }
    if(sSelDpt == null){ sSelDpt = "ALL"; }
    if(sSelCls == null){ sSelCls = "ALL"; }

    String sSvFrDt = sFrDate;
    String sSvToDt = sToDate;

    String sCurrDate = null;
    Date dt = new Date();
    SimpleDateFormat usafmt = new SimpleDateFormat("MM/dd/yyyy");
    sCurrDate = usafmt.format(dt);

    if(sToDate != null && sFrDate == null)
    {
        if(sToDate.equals("WTD")){ sToDate = sCurrDate; }
        dt = usafmt.parse(sToDate);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(dt);

        // find monday
        calendar.setFirstDayOfWeek(Calendar.MONDAY);
        while (calendar.get(Calendar.DAY_OF_WEEK) != calendar.getFirstDayOfWeek())
        {
            calendar.add(Calendar.DATE, -1);
        }
        dt = calendar.getTime();
        sFrDate = usafmt.format(dt);
    }
    else if(sToDate==null) { sToDate = sCurrDate; }

    if(sFrDate==null) { sFrDate = sCurrDate; }

    if(sSort==null){ sSort = "AMT"; }
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComKioskSlsCont.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}


        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvRange { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
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


<script language="javascript">
//------------------------------------------------------------------------------
var DateRange = true;
var SvFrDt = null;
var SvToDt = null;
<%if(sSvFrDt != null){%>SvFrDt = "<%=sSvFrDt%>";<%}%>
<%if(sSvToDt != null){%>SvToDt = "<%=sSvToDt%>";<%}%>

var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
var Sort = "<%=sSort%>";
var SelDiv = "<%=sSelDiv%>";
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvRange"]);
   <%if(sReturn == null){%>  SelDate() <%}%>
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  SelDate()
{
  var todate = new Date(new Date() - 86400000);
  var dofw = todate.getDay();
  todate = new Date(todate - 86400000 * dofw);
  var frDate = new Date(todate - 86400000 * 6);

  document.all.FromDt.value = (frDate.getMonth()+1) + "/" + frDate.getDate() + "/" + frDate.getFullYear()
  document.all.ToDt.value = (todate.getMonth()+1) + "/" + todate.getDate() + "/" + todate.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - (-86400000 * 7));
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// switch frome date range to 1 date (WTD/MTD/YTD)
//==============================================================================
function switchDates()
{
  if(DateRange)
  {
    document.all.spnFrom.style.display = "none";
    document.all.btnDate.innerHTML = "Date Range";
  }
  else
  {
     document.all.spnFrom.style.display = "inline";
     document.all.btnDate.innerHTML = "One Date";
  }
  DateRange = !DateRange;
}

//==============================================================================
// submit Kiosk
//==============================================================================
function sbmKiosk()
{
   var url = "EComKioskSlsCont.jsp?"
   var from = document.all.FromDt.value;
   var to = document.all.ToDt.value;

   // 2 days
   if(DateRange) { url += "FrDate=" + from + "&ToDate=" + to }
   else{ url += "ToDate=" + to }
   //alert(url)
   window.location.href = url;
}
//==============================================================================
// submit Kiosk with different sort
//==============================================================================
function resort(sortby)
{
   var url = "EComKioskSlsCont.jsp?Sort=" + sortby
   if(SvFrDt != null){ url += "&FrDate=" + SvFrDt; }
   if(SvToDt != null){ url += "&ToDate=" + SvToDt; }

   window.location.href = url;
}
//==============================================================================
// drill down on item groups
//==============================================================================
function drilldown(grp, grpnm)
{
   var url = "EComKioskSlsCont.jsp?FrDate=" + FrDate + "&ToDate=" + ToDate
     + "&Sort=" + Sort
   if(SelDiv == "ALL" && SelDpt == "ALL" && SelCls == "ALL") { url += "&Div=" + grp; }
   else if(SelDpt == "ALL" && SelCls == "ALL") { url += "&Div=" + SelDiv + "&Dpt=" + grp; }
   else if(SelCls == "ALL") { url += "&Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + grp; }

   //alert(url)
   window.location.href = url;
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
<div id="dvRange" class="dvRange">
<TABLE width="100%" border=0>
 <tr style='font-size:11px; font-weight:bold; text-align:center'>
   <td >Select Date Range</td>
</tr>
<TR style="font-size:11px;">
  <TD align=center nowrap>
              <span id="spnFrom">From:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDt')">&#60;</button>
              <input class="Small" name="FromDt" type="text" size=10 maxlength=10 readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDt')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 500, 300, document.all.FromDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a> &nbsp; &nbsp; &nbsp;
              </span>

           To:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDt')">&#60;</button>
              <input  class="Small" name="ToDt" type="text" size=10 maxlength=10  readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDt')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.ToDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            <br><button class="Small" id="submit" onClick="sbmKiosk()">Submit</button>
            &nbsp; &nbsp; &nbsp;
                <button class="Small" id="btnDate" onClick="switchDates()">One Date</button>
          </TD>
  </TR>
  </table>
</div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Kiosk Sales
        <%if(sReturn == null){%>
            <br><%=sFrDate%> - <%=sToDate%>
        <%}%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
  <table border=0 cellPadding="0" cellSpacing="0" id="tbGame">
  <tr>
    <td nowrap>
<!-- ========================= By Store ================================ -->
<%
          EComKioskSlsCont kiosls = new EComKioskSlsCont(sFrDate, sToDate, "STR", sSort, sUser);
%>
       <span style="font-weight:bold">Store <%if(sReturn != null){%>Kiosk<%}%> Sales <%if(sReturn != null){%>Today<%}%></span>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbByStr">
         <tr style="background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px">
           <%if(sReturn == null){%>
             <th><a href="javascript: resort('STR')">Store</a></th>
             <th><a href="javascript: resort('SLS')">Sales</a></th>
             <th><a href="javascript: resort('ORD')">Number<br>of<br>Orders</a></th>
             <th><a href="javascript: resort('TRAN')">Number<br>of Store<br>Transaction</a></th>
             <th><a href="javascript: resort('TRANPRC')">Kiosk<br>Transaction<br>%</a></th>
             <th><a href="javascript: resort('COMM')">Commissions</a></th>
           <%} else {%>
             <th>Store</th>
             <th>Sales</th>
             <th>Number<br>of<br>Orders</th>
             <th>Number<br>of Store<br>Transaction</th>
             <th>Kiosk<br>Transaction<br>%</th>
             <th>Commissions</th>
           <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%kiosls.setNumOfRec();
         int iNumOfRec = kiosls.getNumOfRec();
         for(int i=0; i < iNumOfRec; i++)
         {
            kiosls.setKioskSls();
            String sStr = kiosls.getStr();
            String sEmp = kiosls.getEmp();
            String sEmpNm = kiosls.getEmpNm();
            String sSales = kiosls.getSales();
            String sNumOfOrd = kiosls.getNumOfOrd();
            String sComm = kiosls.getComm();
            String sNumTran = kiosls.getNumTran();
            String sTranPrc = kiosls.getTranPrc();%>

          <tr id="trProd" style="background: #E7E7E7; font-size:12px; text-align:right;padding-top:3px;
              padding-bottom:3px;padding-left:3px;padding-right:3px;">
            <td nowrap><%=sStr%></td>
            <td nowrap>$<%=sSales%></td>
            <td nowrap><%=sNumOfOrd%></td>
            <td nowrap><%=sNumTran%></td>
            <td nowrap><%=sTranPrc%>%</td>
            <td nowrap>$<%=sComm%></td>
          </tr>
       <%}%>
       <!-- totals -->
       <%
          kiosls.setTotSls();
          String sTotSales = kiosls.getSales();
          String sTotNumOfOrd = kiosls.getNumOfOrd();
          String sTotComm = kiosls.getComm();
          String sTotNumTran = kiosls.getNumTran();
          String sTotTranPrc = kiosls.getTranPrc();
       %>
          <tr id="trProd" style="background: cornsilk; font-size:12px; text-align:right;padding-top:3px;
              padding-bottom:3px;padding-left:3px;padding-right:3px;">
            <td nowrap>Total</td>
            <td nowrap>$<%=sTotSales%></td>
            <td nowrap><%=sTotNumOfOrd%></td>
            <td nowrap><%=sTotNumTran%></td>
            <td nowrap><%=sTotTranPrc%>%</td>
            <td nowrap>$<%=sTotComm%></td>
          </tr>


       </table>
       </td>
       <th  nowrap>
         &nbsp;&nbsp;&nbsp;
         <%if(sReturn != null){%><a href="EComKioskSlsCont.jsp?ToDate=WTD">WTD</a><%}%>
         &nbsp;&nbsp;&nbsp;</th>
       <td nowrap>
<!-- ========================= By Employee ================================ -->
<%
          kiosls = new EComKioskSlsCont(sFrDate, sToDate, "EMP", sSort, sUser);
%>

       <span style="font-weight:bold">Employee <%if(sReturn != null){%>Kiosk<%}%> Sales <%if(sReturn != null){%>Today<%}%></span>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbByemp">
         <tr style="background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px">
             <th> Employee</th>
             <th>Store</th>
             <th>Sales</th>
             <th>Number<br>of<br>Orders</th>
             <th>Commissions</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%kiosls.setNumOfRec();
         iNumOfRec = kiosls.getNumOfRec();
         for(int i=0; i < iNumOfRec; i++)
         {
            kiosls.setKioskSls();
            String sStr = kiosls.getStr();
            String sEmp = kiosls.getEmp();
            String sEmpNm = kiosls.getEmpNm();
            String sSales = kiosls.getSales();
            String sNumOfOrd = kiosls.getNumOfOrd();
            String sComm = kiosls.getComm();
        %>

          <tr id="trProd" style="background: #E7E7E7; font-size:12px; text-align:right;padding-top:3px;
              padding-bottom:3px;padding-left:3px;padding-right:3px;">
            <td style="text-align:left;" nowrap><%=sEmp%> <%=sEmpNm%></td>
            <td nowrap><%=sStr%></td>
            <td nowrap>$<%=sSales%></td>
            <td nowrap><%=sNumOfOrd%></td>
            <td nowrap>$<%=sComm%></td>
          </tr>
       <%}%>

       <!-- totals -->
       <%
          kiosls.setTotSls();
          sTotSales = kiosls.getSales();
          sTotNumOfOrd = kiosls.getNumOfOrd();
          sTotComm = kiosls.getComm();
       %>
          <tr id="trProd" style="background: cornsilk; font-size:12px; text-align:right;padding-top:3px;
              padding-bottom:3px;padding-left:3px;padding-right:3px;">
            <td nowrap style="text-align:left;" colspan=2>Total</td>
            <td nowrap>$<%=sTotSales%></td>
            <td nowrap><%=sTotNumOfOrd%></td>
            <td nowrap>$<%=sTotComm%></td>
          </tr>


       </table>
     <!--============================================================ -->
     </table>
      </TD>
     </TR>
     <tr>
       <td>
       Kiosk commission rate is 3%.

       </TD>
     </TR>
     <tr bgColor=moccasin>
       <td align="center">
       <!-- ========================= By Item Groups======================== -->
<%
        EComKioskSlsDiv kiodiv = new EComKioskSlsDiv(sFrDate, sToDate, sSelDiv, sSelDpt, sSelCls, "GRP", sUser);
        String sColHdg = null;
        if(sSelCls != "ALL"){ sColHdg = "SKU"; }
        else if(sSelDpt != "ALL"){ sColHdg = "Class"; }
        else if(sSelDiv != "ALL"){ sColHdg = "Depatment"; }
        else { sColHdg = "Division"; }
%>
       <span style="font-weight:bold">Item Group Sales</span>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbByStr">
         <tr style="background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px">
          <th><%=sColHdg%></th>
          <th>Name</th>
          <th>Sales</th>
          <th>Number<br>of<br>Orders</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%kiodiv.setNumOfRec();
         iNumOfRec = kiodiv.getNumOfRec();
         for(int i=0; i < iNumOfRec; i++)
         {
            kiodiv.setKioskSls();
            String sGrp = kiodiv.getGrp();
            String sGrpNm = kiodiv.getGrpNm();
            String sSales = kiodiv.getSales();
            String sNumOfOrd = kiodiv.getNumOfOrd();
        %>

          <tr id="trProd" style="background: #E7E7E7; font-size:12px; text-align:right;padding-top:3px;
              padding-bottom:3px;padding-left:3px;padding-right:3px;">
            <td nowrap>
             <%if(sSelCls == "ALL"){%><a href="javascript: drilldown('<%=sGrp%>', '<%=sGrpNm%>')"><%=sGrp%></a><%}
               else {%><%=sGrp%><%}%>
            </td>
            <td nowrap style="text-align:left;"><%=sGrpNm%></td>
            <td nowrap>$<%=sSales%></td>
            <td nowrap><%=sNumOfOrd%></td>
          </tr>
       <%}%>
       <!-- totals -->
       <%
          kiodiv.setTotSls();
          sTotSales = kiodiv.getSales();
          sTotNumOfOrd = kiodiv.getNumOfOrd();
       %>
          <tr id="trProd" style="background: cornsilk; font-size:12px; text-align:right;padding-top:3px;
              padding-bottom:3px;padding-left:3px;padding-right:3px;">
            <td nowrap colspan=2>Total</td>
            <td nowrap>$<%=sTotSales%></td>
            <td nowrap><%=sTotNumOfOrd%></td>
          </tr>


       </table>

       </td>
     </tr>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   kiosls.disconnect();
   kiodiv.disconnect();
   }
%>
<script language="javascript">
  <%if(sReturn != null){%>
     var html = document.all.tbGame.outerHTML;
     parent.dvWinterChall.innerHTML = html;
  <%}%>
</script>









