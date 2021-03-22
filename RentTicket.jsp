<%@ page import="rciutility.RunSQLStmt, rental.RentTicket ,java.util.*, java.text.*"%>
<%
   String sSelContId = request.getParameter("ContId");
   String sPrint = request.getParameter("Print");
   String sSelGrp = request.getParameter("Grp");

   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=RentTicket.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();
    RentTicket rentinfo = new RentTicket(sSelContId, "vrozen");
    String sCont = rentinfo.getCont();
    String sStr = rentinfo.getStr();
    String sCust = rentinfo.getCust();
    String sFName = rentinfo.getFName();
    String sMInit = rentinfo.getMInit();
    String sLName = rentinfo.getLName();
    String sAddr1 = rentinfo.getAddr1();
    String sAddr2 = rentinfo.getAddr2();
    String sCity = rentinfo.getCity();
    String sState = rentinfo.getState();
    String sZip = rentinfo.getZip();
    String sEMail = rentinfo.getEMail();
    String sHPhone = rentinfo.getHPhone();
    String sCPhone = rentinfo.getCPhone();
    String sPickDt = rentinfo.getPickDt();
    String sReturnDt = rentinfo.getReturnDt();
    String sUserNm = rentinfo.getUserNm();
    String sGroup = rentinfo.getGroup();
    sSelGrp = sGroup;
    
    int iNumOfPkg = rentinfo.getNumOfPkg();
    String [] sPackage = rentinfo.getPackage();
    String [] sQty = rentinfo.getQty();
    String [] sPrice = rentinfo.getPrice();

    String sPoles = rentinfo.getPoles();
    String sSkiers = rentinfo.getSkiers();
    String sDays = rentinfo.getDays();
    String sTotAdlDays = rentinfo.getTotAdlDays();
    String sTotJunDays = rentinfo.getTotJunDays();
    String sTotPoles = rentinfo.getTotPoles();
    String sTotal = rentinfo.getTotal();
    String sTotQty = rentinfo.getTotQty();
    String sTotPolQty = rentinfo.getTotPolQty();
    String sAddAdlDays = rentinfo.getAddAdlDays();
    String sAddJunDays = rentinfo.getAddJunDays();
    String sFreeDays = rentinfo.getFreeDays();
    String sDmgWaiverQty = rentinfo.getDmgWaiverQty();
    String sDmgWaiverTot = rentinfo.getDmgWaiverTot();
    String sDiscPrc = rentinfo.getDiscPrc();
    String sDiscAmt = rentinfo.getDiscAmt();

    int iNumOfSki = rentinfo.getNumOfSki();
    String [] sSkier = rentinfo.getSkier();
    int [] iSkrPackMax = rentinfo.getSkrPackMax();
    String [][] sSkrPackSku = rentinfo.getSkrPackSku();
    String [][] sSkrPackName = rentinfo.getSkrPackName();
    String [][] sSkrPackQty = rentinfo.getSkrPackQty();
    String [][] sSkrPackRet = rentinfo.getSkrPackRet();    

    int iDays = Integer.parseInt(sDays);

    rentinfo.disconnect();
%>

<html>
<head>
<title>Rent_Ticket</title>

<style>
body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-left: black solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable3 { background:white;padding-top:3px; padding-bottom:3px;
                        text-align:left; ; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable4 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable6 { background: lightpink; font-family:Arial; font-size:10px }
        tr.DataTable7 { background:white; font-family:Arial; font-size:14px; font-weight: bold;}
        tr.Divider { background:black; font-family:Arial; font-size:1px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}

        td.DataTable3 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable31 { border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
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

        .Small {font-family:Arial; font-size:10px }
        input.Small1 { font-family:Arial; font-size:10px }
        input.Small2 {border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.radio { font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }
        span.Type {font-size:12px; font-weight:bold; text-decoration:underline;}

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

@media print
{
        td.tdOnlyDisp{ display:none;}
}
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvStatus"]);
   <%if(sPrint != null){%>print(this);<%}%>
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
<!-------------------------------------------------------------------->
  <table border="0" cellPadding="0"  cellSpacing="0" width="100%">

     <tr>
      <td ALIGN="center" VALIGN="TOP" COLSPAN="2" nowrap>
        <span style="font-size:22px; font-weight:bold">POS Ticket Sheet</span>
        <br>Please take this sheet to POS to pay for your rental equipment<br>&nbsp;
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP" COLSPAN="2">
      <table border="0" cellPadding="0" cellSpacing="0" id="tbDept" width="100%" >
        <tr class="DataTable">
          <td rowspan="4" width="25%">&nbsp;</td>
          <td class="DataTable"nowrap><b><%if(!sHPhone.equals("")){%><%=sHPhone%><%} else {%><%=sCPhone%><%}%></b></td>
          <td class="DataTable1" nowrap>Contract Dates &nbsp; 
                         <span style="font-size: 16px; font-weight: bold;"><%=sPickDt%> - <%=sReturnDt%></span></td>
          <td rowspan="4" width="30%">&nbsp;</td>
        </tr>
        <tr class="DataTable">
          <td class="DataTable"><%=sFName%> <%=sMInit%> <%=sLName%></td>
          <td class="DataTable1">Contract # &nbsp; <span style="font-size: 16px; font-weight: bold;"><%=sCont%></span></td>
        </tr>
        <tr class="DataTable">
          <td class="DataTable"><%=sAddr1%> <%=sAddr2%></td>
          <td class="DataTable1">Total # of Renters &nbsp; <%=sSkiers%></td>
        </tr>
        <tr class="DataTable">
          <td class="DataTable"><%=sCity%>, <%=sState%> <%=sZip%><br><%=sEMail%></td>
          <td class="DataTable1">
             <%if(iDays < 30){%># of rental days &nbsp; <%=sDays%><%}
             else {%>Seasonal Lease<%}%>
             <%if(sFreeDays.equals("Y")){%><br>* Free pick up and drop off days<%}%>
          </td>
        </tr>        

        <tr class="DataTable">
          <td width="25%">&nbsp;</td>
          <td class="DataTable">
            <table border="1" cellPadding="0" cellSpacing="0">
              <tr class="DataTable">
               <th class="DataTable">Renters</th>
               <th class="DataTable">Names</th>
               <th class="DataTable">Rented Items</th>
               <th class="DataTable">Qty</th>
               <th class="DataTable" nowrap>Per Day Price</th>
              </tr>
                  <%for(int i=0; i < iNumOfSki; i++){%>
                     <tr class="DataTable">
                       <td class="DataTable" nowrap><%=i+1%></td>
                       <td class="DataTable" nowrap><%=sSkier[i]%></td>
                       <td class="DataTable" nowrap>
                         <%String sBr = "";%> 
                         <%for(int j=0; j < iSkrPackMax[i]; j++){%>
                               <%=sBr + sSkrPackName[i][j]%><%sBr = "<br>";%>
                         <%}%>
                       </td>
                       <td class="DataTable" nowrap>
                         <% sBr = "";%> 
                         <%for(int j=0; j < iSkrPackMax[i]; j++){%>
                               <%=sBr + sSkrPackQty[i][j]%><%sBr = "<br>";%>
                         <%}%>
                       </td>
                       <td class="DataTable" nowrap>
                         <% sBr = "";%> 
                         <%for(int j=0; j < iSkrPackMax[i]; j++){%>
                               <%=sBr + sSkrPackRet[i][j]%><%sBr = "<br>";%>
                         <%}%>
                       </td>
                    </tr>
               <%}%>
            </table>
          </td>
       </tr>

        <tr class="DataTable">
          <td class="DataTable2" colspan=4>
           <br><b>Cashier add rental items to the ticket <u>FIRST</u>, to ensure charges are correct -
           before adding other items to the ticket!</b>
          </td>
        </tr>
     </table>
    </td>
   </tr>

   <tr>
      <td ALIGN="center" VALIGN="TOP" COLSPAN="2"><br>
        <u>Consolidated charges of Rental Equipment for all renters:</u>
      </td>
   </tr>

   <tr>
      <td ALIGN="right" VALIGN="MIDDLE" width="50%">
         Rental Entered By: <%=sUserNm%>
         <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>
         <br> <br>
         Total # of Renters: <%=sSkiers%>
         <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

      <td ALIGN="left" VALIGN="TOP"><br>
        <table border="1" cellPadding="0" cellSpacing="0" width="50%">
          <tr class="DataTable">
            <th class="DataTable">Rented Items:</th>
            <th class="DataTable" nowrap>Total QTY <%if(iDays < 30){%><br>(# of Rental Days)<%}%></th>
            <th class="DataTable">Price</th>
          </tr>
          <%for(int i=0; i < iNumOfPkg; i++){%>
            <tr class="DataTable">
              <td class="DataTable" nowrap><%=sPackage[i]%></td>
              <td class="DataTable1"><%=sQty[i]%></td>
              <td class="DataTable1"><%=sPrice[i]%></td>
            </tr>
          <%}%>
          
          <%if(iDays >= 30){%>
          <!--  tr class="DataTable">
            <td class="DataTable">Add Days</td>
            <td class="DataTable" nowrap><%=sAddAdlDays%><br><%=sAddJunDays%></td>
            <td class="DataTable1" nowrap><%=sTotAdlDays%><br><%=sTotJunDays%></td>
          </tr -->
          <%}%> 
          
          
          <tr class="DataTable">
            <td class="DataTable">
               <%if(sSelGrp.equals("SKI")){%>Poles<%} 
                 else if(sSelGrp.equals("WATER")) {%>Paddles<%} 
                 else if(sSelGrp.equals("BIKE")){%>Hemlets<%}%>
            </td>
            <td class="DataTable1"><%=sTotPolQty%></td>
            <td class="DataTable1"><%=sTotPoles%></td>
          </tr>
          
          <tr class="DataTable">
            <td class="DataTable">Damage Insurance</td>
            <td class="DataTable1"><%=sDmgWaiverQty%></td>
            <td class="DataTable1"><%=sDmgWaiverTot%></td>
          </tr>
          
          <%if(!sDiscPrc.equals("0") && !sDiscPrc.equals("")){%>
          	<tr class="DataTable">
            	<td class="DataTable1">Discount</td>
           		<td class="DataTable1"><%=sDiscPrc%>%</td>
            	<td class="DataTable1" nowrap>(<%=sDiscAmt%>)</td>
          	</tr>
          <%}%>
          <tr class="DataTable">
            <td class="DataTable1">Total</td>
            <td class="DataTable1"><%=sTotQty%></td>
            <td class="DataTable1" nowrap><%=sTotal%></td>
          </tr>

        </table>
      </td>
   </tr>
   <tr>
      <td ALIGN="right" VALIGN="MIDDLE" width="50%">
        <b><br>Equipment is Due back (by close of business) on:
         &nbsp; &nbsp; &nbsp; &nbsp;   
          <span style="font-size:22px;"><%=sReturnDt%></span>
        </b>
      </td>
   </tr>

  </table>
 </body>
</html>

<%
  }%>










