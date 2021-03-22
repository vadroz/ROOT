<%@ page import="patiosales.OrderDelInq ,java.util.*, java.text.*"%>
<%
   String sDate = request.getParameter("Date");
   String sList = request.getParameter("List");
   String sClose = request.getParameter("Close");
   String sStore = request.getParameter("Store");

   if (sDate == null)
   {
      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      sDate = sdf.format(cal.getTime());
   }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderDelInq.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      if (sStore == null) { sStore = "86"; }
      System.out.println("Date: " + sDate + " Str: " + sStore);

      OrderDelInq ordlst = new OrderDelInq(sDate, sStore, session.getAttribute("USER").toString());
      int iNumOfOrd = ordlst.getNumOfOrd();
      String [] sOrdNum = ordlst.getOrdNum();
      String [] sSts = ordlst.getSts();
      String [] sStsName = ordlst.getStsName();
      String [] sSoSts = ordlst.getSoSts();
      String [] sSoStsName = ordlst.getSoStsName();
      String [] sCust = ordlst.getCust();
      String [] sSlsper = ordlst.getSlsper();
      String [] sSlpName = ordlst.getSlpName();
      String [] sDelDate = ordlst.getDelDate();
      String [] sShipInstr = ordlst.getShipInstr();
      String [] sLastName = ordlst.getLastName();
      String [] sFirstName = ordlst.getFirstName();
      String [] sAddr1 = ordlst.getAddr1();
      String [] sAddr2 = ordlst.getAddr2();
      String [] sCity = ordlst.getCity();
      String [] sState = ordlst.getState();
      String [] sZip = ordlst.getZip();
      String [] sDayPhn = ordlst.getDayPhn();
      String [] sExtWorkPhn = ordlst.getExtWorkPhn();
      String [] sEvtPhn = ordlst.getEvtPhn();
      String [] sCellPhn = ordlst.getCellPhn();
      String [] sEMail = ordlst.getEMail();
      String [] sSubTot = ordlst.getSubTot();
      String [] sTax = ordlst.getTax();
      String [] sTotal = ordlst.getTotal();
      String [] sOrgStr = ordlst.getOrgStr();
      String [] sTrfStr55 = ordlst.getTrfStr55();
      String [] sTrfStr35 = ordlst.getTrfStr35();
      String [] sTrfStr46 = ordlst.getTrfStr46();
      String [] sTrfStr50 = ordlst.getTrfStr50();
      String [] sSpcOrd = ordlst.getSpcOrd();

      String sOrdNumJsa = ordlst.getOrdNumJsa();

      ordlst.disconnect();

%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
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

        <!-------- select another div/dpt/class pad ------->
        .Small {font-family:Arial; font-size:10px }
        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }

        <!-------- transfer entry pad ------->
        div.Fake { };
        div.dvOrder  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { text-align:left; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right;
                    font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid3 { text-align:center; font-family:Arial; font-size:10px;}

        td.Menu { text-align:center; font-family:Arial; font-size:10px;}
        <!-------- end transfer entry pad ------->

</style>
<SCRIPT language="JavaScript1.2">
var NumOfOrd = <%=iNumOfOrd%>
var OrdNum = [<%=sOrdNumJsa%>];

//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// Initial process
//==============================================================================
function bodyLoad()
{
   window.focus();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction)
{
  var button = document.all.DelDate;
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  showInq()
{
  var url = "OrderDelInq.jsp?Date=" + document.all.DelDate.value.trim()
          + "&List=<%=sList%>"
          + "&Close=<%=sClose%>"
          + "&Store=<%=sStore%>"
  window.location.href = url;
}
//==============================================================================
// return selected date
//==============================================================================
function  selDate()
{
   opener.document.all.DelDate.value = "<%=sDate%>"
   window.close();
}
//==============================================================================
// open All order on the list for printing
//==============================================================================
function openAllOrd()
{
   var url = "OrderPrint.jsp?Date=<%=sDate%>";

   for(var i=0; i < NumOfOrd; i++)
   {
      url += "&Ord=" + OrdNum[i];
   }

   var WindowName = 'Print_Order_List_By_Delivery_Date';
   var WindowOptions = 'resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';

  //alert(url);
  window.open(url, WindowName, WindowOptions);
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frameChkCalendar"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <div id="dvOrder" class="dvOrder"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Patio Furniture Sales Order Delivery Date Inquiry
      <br>Delivery Date: <%=sDate%>
      <br>Total Number of Delivering Orders: <font color="red"><u><%=iNumOfOrd%></u></font>
      <br>Select Date: &nbsp;
          <button name="Down" onClick="setDate('DOWN')">&#60;</button></span>
          <input type="text" name="DelDate" readonly size=10 maxlength=10 value="<%=sDate%>">
          <button name="Up" onClick="setDate('UP')">&#62;</button>
          &nbsp;&nbsp;
          <a  href="javascript:showCalendar(1, null, null, 100, 200, document.all.DelDate, false, 'PfsCheckDelDate.jsp')" >
          <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>&nbsp;&nbsp;
          <button name="Go" onClick="showInq()">Go</button>
      </b></td>

    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable" nowrap>Order</th>
        <th class="DataTable" nowrap>Sts</th>
        <th class="DataTable" nowrap>Spc.Ord<br>Sts</th>
        <th class="DataTable" nowrap>Delivery<br>Date</th>
        <th class="DataTable" nowrap>Address</th>
        <th class="DataTable" nowrap>Special<br>Order</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
      <%for(int i=0; i < iNumOfOrd; i++) {%>
          <tr  class="DataTable">
            <td class="DataTable2"><%=sOrdNum[i]%></td>
            <td class="DataTable2"><%=sStsName[i]%></td>
            <td class="DataTable2"><%=sSoStsName[i]%></td>
            <td class="DataTable2"><%=sDelDate[i]%></td>
            <td class="DataTable" nowrap><%=sAddr1[i]%> <%=sAddr2[i]%>, <%=sCity[i]%>, <%=sState[i]%>, <%=sZip[i]%></td>

            <td class="DataTable3<%if(sSpcOrd[i].equals("1")){%>2<%}%>">
               <%if(sSpcOrd[i].equals("1")){%>Yes<%} else{%>None<%}%>
            </td>
          </tr>
      <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
        <%if(iNumOfOrd > 0){%><button onclick="openAllOrd()">Open All</button><%}%>
        <%if(sList == null) {%><button onclick="selDate()">Select Date</button><%}%>
        <%if(sClose == null) {%><button onclick="window.close()">Close</button><%}
          else {%><button onclick="history.go(-1)">Back</button><%}%>
     </td>
   </tr>

  </table>
 </body>
</html>
<%}%>