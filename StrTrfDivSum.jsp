<%@ page import="itemtransfer.StrTrfDivSum, java.util.*"%>
<%
   String sDivision = request.getParameter("DIVISION");
   String sStore = request.getParameter("STORE");

   StrTrfDivSum divSum = null;
   int iNumOfGrp = 0;
   String sMain = null;
   String sMainName = null;
   String [] sGrp = null;
   String [] sGrpName = null;

   int [] iNumOfTrfDate = null;
   String [][] sAppDate = null;
   String [][] sAppUser = null;
   String [][] sPrtDate = null;
   String [][] sPrtUser = null;
   String [][] sCmpDate = null;
   String [][] sCmpUser = null;

   String [][] sApproved = null;
   String [][] sItmCnt = null;
    String [][] sQty = null;
   String [][] sInTransit = null;
   String [][] sSent = null;
   String [][] sDstStr = null;


   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";
   String sStrAllowed = "";

   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=StrTrfDivSum.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }
     response.sendRedirect(sTarget + sbQuery.toString());
   }
   else
   {
     sStrAllowed = session.getAttribute("STORE").toString();
     divSum = new StrTrfDivSum(sDivision, sStore);

     iNumOfGrp = divSum.getNumOfGrp();
     sMain = divSum.getMain();
     sMainName = divSum.getMainName();
     sGrp = divSum.getGrp();
     sGrpName = divSum.getGrpName();

     iNumOfTrfDate = divSum.getNumOfTrfDate();
     sAppDate = divSum.getAppDate();
     sAppUser = divSum.getAppUser();
     sPrtDate = divSum.getPrtDate();
     sPrtUser = divSum.getPrtUser();
     sCmpDate = divSum.getCmpDate();
     sCmpUser = divSum.getCmpUser();

     sItmCnt = divSum.getItmCnt();
     sQty = divSum.getQty();
     sApproved = divSum.getApproved();
     sInTransit = divSum.getInTransit();
     sSent = divSum.getSent();
     sDstStr = divSum.getDstStr();

     divSum.disconnect();
   }
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left;}

        <!------------------------------------------------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        <!------------------------------------------------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{

}

//----------------------------------------
// print transfer request
//----------------------------------------
function printTrfReq(strdiv, main, mainName, grp, grpName)
{
  var url="DivTrfReq.jsp?";
  if(strdiv) { url += "DIVISION=" + grp + "&DIVNAME=" + grpName + "&STORE=" + main }
  else { url += "DIVISION=" + main + "&DIVNAME=" + mainName + "&STORE=" + grp }

  // change status to intransit on print
  chgStatus("I", strdiv, main, mainName, grp, grpName);

  //alert(url);
  window.open(url);
}
//--------------------------------------------------------
// Change Transfers Status to approved
//--------------------------------------------------------
function chgStatus(sts, strdiv, main, mainName, grp, grpName)
{
   var url = "ItemTrfEnt.jsp?"

   if(strdiv) { url += "DIVISION=" + grp}
   else { url += "DIVISION=" + main }

   if(sts=="A") url += "&ACTION=APPROVE";
   if(sts=="I") url += "&ACTION=INTRANSIT";
   if(sts=="S") url += "&ACTION=SENT";
   url += "&Refresh=true";

  if(sts != "I" ) {
    if(confirm("Are You Sure?????"))
    {
     //alert(url)
     //window.location.href = url;
     window.frame1.location = url;
    }
    else
    {
      document.all.APPROVE.checked=false;
    }
  }
  else
  {
    //alert(url)
     //window.location.href = url;
     window.frame1.location = url;
  }
}


</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Manage Transfer Requests
      <br><%if(sStore.equals("ALL")){%>Division:<%} else {%>Store:<%}%>
           <%=sMain + " - " + sMainName%> &nbsp;&nbsp
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP">

      <a href="index.html"><font color="red" size="-1">Home</font></a>&#62;
      <a href="TransferReq.html">
         <font color="red" size="-1">Item Transfers</font></a>&#62;
      <a href="DivTrfReqSel.jsp">
         <font color="red" size="-1">Select Report</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      <!-------------------------------------------------------------------->
      </td>
     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan="2"><%if(sStore.equals("ALL")){%>Store<%} else {%>Div<%}%></th>
      <th class="DataTable" colspan="2">Transfer initiated by</th>
      <th class="DataTable" colspan="3">Transfers Out</th>
      <th class="DataTable" colspan="3">Printed</th>
      <th class="DataTable">Work in Progress*</th>
      <th class="DataTable" colspan="2">Sent</th>
    </tr>
    <tr>
      <th class="DataTable">User</th>
      <th class="DataTable">Date</th>
      <th class="DataTable"># of<br>Stores</th>
      <th class="DataTable">Total<br>Items</th>
      <th class="DataTable">Total<br>Units</th>

      <th class="DataTable">Prt</th>
      <th class="DataTable">User</th>
      <th class="DataTable">Date</th>
      <th class="DataTable">Complete</th>
      <th class="DataTable">User</th>
      <th class="DataTable">Date</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
    <%for(int i=0; i<iNumOfGrp; i++){%>
      <tr class="DataTable">
         <td class="DataTable1" nowrap rowspan="<%=iNumOfTrfDate[i]%>">
               <%=sGrp[i] + " - " + sGrpName[i]%>
         </td>
      <!-- Class In count-->
        <%for(int j=0; j < iNumOfTrfDate[i]; j++) {%>
         <%if(j>0){%><tr class="DataTable"><%}%>
          <td class="DataTable" ><%=sAppUser[i][j]%></td>
          <td class="DataTable" ><%=sAppDate[i][j]%></td>
          <td class="DataTable" ><%=sDstStr[i][j]%>
          <td class="DataTable" ><%=sItmCnt[i][j]%></td>
          <td class="DataTable" ><%=sQty[i][j]%>
          <td class="DataTable" >
             <%if (sStrAllowed != null && !sStrAllowed.startsWith("ALL")){%>
               <a href="javascript: printTrfReq('<%=sStore.equals("ALL")%>', '<%=sMain%>', '<%=sMainName%>', '<%=sGrp[i]%>', '<%=sGrpName[i]%>')">Print</a>
             <%}%>
          </td>
          <td class="DataTable" ><%=sPrtUser[i][j]%></td>
          <td class="DataTable" ><%if(!sPrtUser[i][j].equals("")){%><%=sPrtDate[i][j]%><%}%></td>
          <td class="DataTable" >
             <%if (!sInTransit[i][j].equals("0")
                && sStrAllowed != null && !sStrAllowed.startsWith("ALL")){%>
                <a href="javascript: chgStatus('S','<%=sStore.equals("ALL")%>', '<%=sMain%>', '<%=sMainName%>', '<%=sGrp[i]%>', '<%=sGrpName[i]%>')">Completed?</a>
             <%}
             else if(!sCmpUser[i][j].equals("")){%>Done<%}%>
          </td>
          <td class="DataTable" ><%=sCmpUser[i][j]%></td>
          <td class="DataTable" ><%if(!sCmpUser[i][j].equals("")){%><%=sCmpDate[i][j]%><%}%></td>
        </tr>
       <%}%>
    <%}%>
<!---------------------------- end of Detail data ----------------------------->
 </table>
 <p><span style="color:red; font-size:12px;font-weight:normal">* Click on "completed?" when finished</span>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
