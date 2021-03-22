<%@ page import="discountcard.CouponList ,java.util.*, java.text.*"%>
<%
   String sType = request.getParameter("SelType");
   String sFrDate = request.getParameter("SelFrDate");
   String sToDate = request.getParameter("SelToDate");
   String sSelCby = request.getParameter("SelCby");
   String sSelName = request.getParameter("SelName");
   String sReimb = request.getParameter("SelReimb");
   String sActive = request.getParameter("SelActive");
   String sSort = request.getParameter("Sort");

   if (sSort == null){ sSort = "CODE"; }
   if (sSelCby == null){ sSelCby = " "; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "COUPENT";
   if (session.getAttribute("USER")==null
      || session.getAttribute(sAppl)==null && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CouponList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
	   
	  System.out.println(sType + "|" + sFrDate + "|" + sToDate + "|" + sSelCby + "|" + sSelName
			  + "|" + sReimb + "|" + sActive + "|" + sSort); 

   String sUser = session.getAttribute("USER").toString();
   CouponList cpnlst = new CouponList(sType, sFrDate, sToDate, sSelCby, sSelName, sReimb, sActive, sSort, sUser);

%>
<html>
<head>
<title>Coupon_Tracking_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px; text-align:center;}

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
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
        #tdAllInv { display: none; }
        #tdAvlInv { display: block; }

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
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
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Type = "<%=sType%>";
var FrDate = "<%=sFrDate%>" ;
var ToDate = "<%=sToDate%>";
var Sort = "<%=sSort%>";

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// re-sort table
//==============================================================================
function resort(sort)
{
   var url = "CouponList.jsp?Type=" + Type
   + "&FrDate=" + FrDate
   + "&ToDate=" + ToDate
   + "&Sort=" + sort
   //alert(url)
   window.location.href=url;
}
//==============================================================================
// re-sort table
//==============================================================================
function dltCoupon(code)
{
   var url = "CouponSv.jsp?Code=" + code
     + "&Action=DELETE"

   if(confirm("Do you want to delete Coupon/Tracking Id " + code))
   {
      //alert(url)
      window.frame1.location.href=url;
   }
}
//==============================================================================
// refresh page
//==============================================================================
function refresh(code)
{
  var url = "CouponList.jsp?Type=" + Type
   + "&FrDate=" + FrDate
   + "&ToDate=" + ToDate
   + "&Sort=" + Sort
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
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Coupon/Tracking Id Code List</b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="CouponListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
      &nbsp; &nbsp; <a href="CouponInfo.jsp?Code=0000" target="_blank">New Code</a>
      <br>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable"><a href="javascript: resort('CODE')">Code</a></th>
          <th class="DataTable"><a href="javascript: resort('NAME')">Name</a></th>
          <th class="DataTable">Type</th>
          <th class="DataTable"><a href="javascript: resort('CBY')">Entered<br>By</a></th>
          <th class="DataTable"><a href="javascript: resort('DATI')">Date<br>Entered</a></th>
          <th class="DataTable">Organization</th>
          <th class="DataTable"><a href="javascript: resort('CPSI')">Coupon<br>Begin</th>
          <th class="DataTable">Coupon<br>End</th>
          <th class="DataTable">Coupon<br>Text</th>
          <th class="DataTable">Comments</th>
          <th class="DataTable">Coup/Track<br>($ or %)</th>
          <th class="DataTable">%Reimb.</th>
          <th class="DataTable">Due Date<br>forReimb</th>
          <th class="DataTable">Event<br>Start</th>
          <th class="DataTable">Event<br>End</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable">Delete</th>
        </tr>
  <!-------------------------- Order List ------------------------------->
      <%
       while(cpnlst.getNext())
       {
          cpnlst.getCoupon();
          String sCode = cpnlst.getCode();
        String sName = cpnlst.getName();
        String sOrg = cpnlst.getOrg();
        String sOrgt = cpnlst.getOrgt();
        String sMed = cpnlst.getMed();
        String sCost = cpnlst.getCost();
        String sDati = cpnlst.getDati();
        String sCby = cpnlst.getCby();
        String sRef = cpnlst.getRef();
        String sCon = cpnlst.getCon();
        String sTit = cpnlst.getTit();
        String sCbus = cpnlst.getCbus();
        String sChm = cpnlst.getChm();
        String sCfax = cpnlst.getCfax();
        String sRmb = cpnlst.getRmb();
        String sDuei = cpnlst.getDuei();
        String sPmt1 = cpnlst.getPmt1();
        String sPmt2 = cpnlst.getPmt2();
        String sPmt3 = cpnlst.getPmt3();
        String sPmt4 = cpnlst.getPmt4();
        String sGrp = cpnlst.getGrp();
        String sAdd1 = cpnlst.getAdd1();
        String sAdd2 = cpnlst.getAdd2();
        String sCty = cpnlst.getCty();
        String sSta = cpnlst.getSta();
        String sZip = cpnlst.getZip();
        String sPhn = cpnlst.getPhn();
        String sFax = cpnlst.getFax();
        String sTrpi = cpnlst.getTrpi();
        String sReso = cpnlst.getReso();
        String sStri = cpnlst.getStri();
        String sEndi = cpnlst.getEndi();
        String sGrpn = cpnlst.getGrpn();
        String sMar = cpnlst.getMar();
        String sSchs = cpnlst.getSchs();
        String sEdti = cpnlst.getEdti();
        String sEtmi = cpnlst.getEtmi();
        String sCom = cpnlst.getCom();
        String sCom1 = cpnlst.getCom1();
        String sCom2 = cpnlst.getCom2();
        String sDsc = cpnlst.getDsc();
        String sCpsi = cpnlst.getCpsi();
        String sCpei = cpnlst.getCpei();
        String sCtxt = cpnlst.getCtxt();
        String sHost = cpnlst.getHost();

      %>
         <tr class="DataTable1">
           <td class="DataTable1"><a href="CouponInfo.jsp?Code=<%=sCode%>" target="_blank"><%=sCode%></a></td>
           <td class="DataTable"><%=sName%></td>
           <td class="DataTable"><%=sMed%></td>
           <td class="DataTable"><%=sCby%></td>
           <td class="DataTable"><%=sDati%></td>
           <td class="DataTable"><%=sGrp%></td>
           <td class="DataTable"><%if(!sCpsi.equals("01/01/0001")){%><%=sCpsi%><%} else {%>&nbsp;<%}%></td></td>
           <td class="DataTable"><%if(!sCpei.equals("01/01/0001")){%><%=sCpei%><%} else {%>No End<%}%></td>
           <td class="DataTable"><%=sCtxt%></td>
           <td class="DataTable"><%=sCom%></td>
           <td class="DataTable"><%=sDsc%></td>
           <td class="DataTable"><%=sRmb%></td>
           <td class="DataTable"><%if(!sDuei.equals("01/01/0001")){%><%=sDuei%><%} else {%>&nbsp;<%}%></td>
           <td class="DataTable"><%if(!sStri.equals("01/01/0001")){%><%=sStri%><%} else {%>&nbsp;<%}%></td>
           <td class="DataTable"><%if(!sEndi.equals("01/01/0001")){%><%=sEndi%><%} else {%>No End<%}%></td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable"><a href="javascript: dltCoupon('<%=sCode%>')">Dlt</a></td>
         </tr>
      <%}%>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>


<%  cpnlst.disconnect();
  }%>