<%@ page import="payrollreports.AvgPayCons, java.util.*"%>
<%
   String sWeekend = request.getParameter("selDate");
   String sInfo = request.getParameter("Info");
   String sCons = request.getParameter("Cons");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("PAYROLL")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AvgPayCons.jsp&APPL=PAYROLL&" + request.getQueryString());
   }
   else
   {
       AvgPayCons avgpay = new AvgPayCons(sWeekend, sInfo, sCons);

       int iNumOfStr = avgpay.getNumOfStr();
       String [] sStr = avgpay.getStr();

       int iNumOfFld = avgpay.getNumOfFld();
       String [][] sTyWtd = avgpay.getTyWtd();
       String [][] sTyMtd = avgpay.getTyMtd();
       String [][] sTyQtd = avgpay.getTyQtd();
       String [][] sTyYtd = avgpay.getTyYtd();
       String [][] sLyWtd = avgpay.getLyWtd();
       String [][] sLyMtd = avgpay.getLyMtd();
       String [][] sLyQtd = avgpay.getLyQtd();
       String [][] sLyYtd = avgpay.getLyYtd();

       //totals
       String [] sRepTyWtd = avgpay.getRepTyWtd();
       String [] sRepTyMtd = avgpay.getRepTyMtd();
       String [] sRepTyQtd = avgpay.getRepTyQtd();
       String [] sRepTyYtd = avgpay.getRepTyYtd();
       String [] sRepLyWtd = avgpay.getRepLyWtd();
       String [] sRepLyMtd = avgpay.getRepLyMtd();
       String [] sRepLyQtd = avgpay.getRepLyQtd();
       String [] sRepLyYtd = avgpay.getRepLyYtd();

       avgpay.disconnect();

       String sColumn1 = null;
       String [] sColumn2 = null;

       // Selling / Commissions
       if(sCons.equals("C"))
       {
          sColumn1 = "Dept: 042, 062, 072 091 and Sales Commissions";
          sColumn2 = new String[]{"(M)Base<br>Pay", "Hourly<br>Pay", "Commsn<br>Pay",
          "Labor<br>Spiff", "Other<br>Pay", "Total<br>Pay"};
       }
       // Selling / Non-Commissions
       else if(sCons.equals("N"))
       {
          sColumn1 = "Selling / Dept:042, 044, 072, 091 and Non-Commission";
          sColumn2 = new String[]{"Hourly<br>Pay", "Commsn<br>Pay",
          "Labor<br>Spiff", "Other<br>Pay", "Total<br>Pay"};
       }
       // Non-Selling / Other Department
       else if(sCons.equals("O"))
       {
          sColumn1 = "Non-Selling / Other Departments";
          sColumn2 = new String[]{"Hourly<br>Pay", "Commsn<br>Pay",
          "Labor<br>Spiff", "Other<br>Pay", "Total<br>Pay"};
       }
       // Manager
       else if(sCons.equals("M"))
       {
          sColumn1 = "Manager Assistants";
          sColumn2 = new String[]{"Mgr<br>Assist", "Total<br>Pay"};
       }
       // Bike Manager
       else if(sCons.equals("B"))
       {
          sColumn1 = "Bike Manager";
          sColumn2 = new String[]{"Bike<br>Mgr", "Total<br>Pay"};
       }
       // Total Hours
       else if(sCons.equals("H"))
       {
          sColumn1 = "Total Hourly";
          sColumn2 = new String[]{"Total<br>Hourly", "Total<br>Pay"};
       }
       // Total Pay
       else if(sCons.equals("T"))
       {
          sColumn1 = "Total ";
          sColumn2 = new String[]{"Total<br>Pay", "Total"};
       }

       // -------------------------------------------------
       // Manager
       else if(sCons.equals("0"))
       {
          sColumn1 = "Managers";
          sColumn2 = new String[]{"Managers / Dept: 001, 011", "Total<br>Pay"};
       }
       // Selles
       else if(sCons.equals("1"))
       {
          sColumn1 = "Selling / Dept: 042, 043, 044, 045, 047, 055, 056, 061, 062, 071, 072, 091, 097 and Sales Commission";
          sColumn2 = new String[]{"(M)Base<br>Pay", "Hourly<br>Pay", "Commsn<br>Pay",
          "Labor<br>Spiff", "Other<br>Pay", "Total<br>Pay"};
       }
       // Selling / Non-Commissions
       else if(sCons.equals("2") || sCons.equals("3") || sCons.equals("4") || sCons.equals("5")
            || sCons.equals("5") || sCons.equals("6") || sCons.equals("7") || sCons.equals("8"))
       {
          if(sCons.equals("2"))  sColumn1 = "Cashiers/Oper.Coor / Dept: 022, 093";
          else if(sCons.equals("3"))  sColumn1 = "Shipping/Receiving / Dept: 032";
          else if(sCons.equals("4"))  sColumn1 = "Bike Tech / Dept: 054";
          else if(sCons.equals("5"))  sColumn1 = "Climbing Wall / Dept: 082";
          else if(sCons.equals("6"))  sColumn1 = "Ski Instuctor / Dept: 076";
          else if(sCons.equals("7"))  sColumn1 = "Ski Tech / Dept: 074";
          else if(sCons.equals("8"))  sColumn1 = "Merchandisers / Dept: 095";

          sColumn2 = new String[]{"Hourly<br>Pay", "Commsn<br>Pay",
          "Labor<br>Spiff", "Other<br>Pay", "Total<br>Pay"};
       }
%>
<html>
<head>
<style>
        body {background:LemonChiffon; text-align:center;}

        td.DataTableW  { border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }
        td.DataTableM  { border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }
        td.DataTableQ  { border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }
        td.DataTableY  { border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }

        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }

        td.DataTable1  { border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }

        tr.Div { background:darkred; border-bottom: darkred solid 1px;}

        .small{ text-align:left; font-family:Arial; font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
var NumOfFld = <%=iNumOfFld%>;
var elmColor;
//---------------------------------------------------------
// work on loading time
//---------------------------------------------------------
function bodyLoad()
{
   switchColumn(true, "W");
   switchColumn(true, "M");
   switchColumn(true, "Q");
   switchColumn(true, "Y");
}
//---------------------------------------------------------
// work on loading time
//---------------------------------------------------------
function switchColumn(fold, group)
{
   var col1 = group + "01"
   var col2 = group + "02"
   var col3 = new Array();

   for(var i=0, j=0; i < NumOfFld-1; i++)
   {
     col3[j] = group + "03" + i; j++;
     col3[j] = group + "04" + i; j++;
     col3[j] = group + "05" + i; j++;
   }

   if(fold)
   {
      try { document.all[col1].style.display="block" } catch(e) { alert(1)}
      try { document.all[col2].style.display="none" } catch(e) { alert(2)}
      for(var i=0; i < col3.length; i++)
      {
        try { document.all[col3[i]].style.display="none"; } catch(e) { alert(3)}
      }
      if(group=="W") document.styleSheets[0].rules[1].style.display="none";
      if(group=="M") document.styleSheets[0].rules[2].style.display="none";
      if(group=="Q") document.styleSheets[0].rules[3].style.display="none";
      if(group=="Y") document.styleSheets[0].rules[4].style.display="none";
   }
   else
   {
      document.all[col1].style.display="none"
      document.all[col2].style.display="block"
      for(var i=0; i < col3.length; i++)
      {
        document.all[col3[i]].style.display="block";
      }

      if(group=="W") document.styleSheets[0].rules[1].style.display="block";
      if(group=="M") document.styleSheets[0].rules[2].style.display="block";
      if(group=="Q") document.styleSheets[0].rules[3].style.display="block";
      if(group=="Y") document.styleSheets[0].rules[4].style.display="block";
   }
}
//-------------------------------------------------------------------------------
// change text color on mouse moved over table row
//-------------------------------------------------------------------------------
function mouseOver (obj){
  elmColor = obj.style.color;
  obj.style.color = "blue";
}
//-------------------------------------------------------------------------------
// change text color on mouse moved out table row
//-------------------------------------------------------------------------------
function mouseOut (obj){
  obj.style.color = elmColor;
}
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad()" >
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
   <b><font size="+2">Store Payroll by Department - Store Summary (Excl. H, V, S, B)</font>&nbsp;&nbsp;
   <%if(sInfo.equals("D")) {%>(Dollars)<%}%>
   <%if(sInfo.equals("H")) {%>(Hours)<%}%>
   <%if(sInfo.equals("A")) {%>(Average Pay)<%}%><br>
   Week Ending: <%=sWeekend%><br><%=sColumn1%></b><br><br>

   <a href="../"><font color="red" size="-1">Home</font></a>&#62;
   <a href="AvgPayConsSel.jsp"><font color="red" size="-1">Report Selection</font></a>&#62;
   <font size="-1">This page.</font>

   <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
         <th rowspan="3"class='DataTable'>Store</th>
         <th rowspan="3"class='DataTable'>&nbsp;</th>
         <th colspan="2"  id="W01" class='DataTable' nowrap>Week-To-Date (<a href="javascript: switchColumn(false, 'W')">unfold</a>)</th>
         <th colspan="<%=iNumOfFld * 2%>" id="W02" class='DataTable' nowrap>Week-To-Date (<a href="javascript: switchColumn(true, 'W')">fold</a>)</th>

         <th rowspan="3"class='DataTable'>&nbsp;</th>
         <th colspan="2" id="M01" class='DataTable' nowrap class='DataTable'>Month-To-Date (<a href="javascript: switchColumn(false, 'M')">unfold</a>)</th>
         <th colspan="<%=iNumOfFld * 2%>" id="M02" class='DataTable' nowrap class='DataTable'>Month-To-Date (<a href="javascript: switchColumn(true, 'M')">fold</a>)</th>

         <th rowspan="3"class='DataTable'>&nbsp;</th>
         <th colspan="2" id="Q01" class='DataTable' nowrap class='DataTable'>Quater-To-Date (<a href="javascript: switchColumn(false, 'Q')">unfold</a>)</th>
         <th colspan="<%=iNumOfFld * 2%>" id="Q02" class='DataTable' nowrap class='DataTable'>Quater-To-Date (<a href="javascript: switchColumn(true, 'Q')">fold</a>)</th>

         <th rowspan="3"class='DataTable'>&nbsp;</th>
         <th colspan="2" id="Y01" class='DataTable' nowrap class='DataTable'>Year-To-Date (<a href="javascript: switchColumn(false, 'Y')">unfold</a>)</th>
         <th colspan="<%=iNumOfFld * 2%>" id="Y02" class='DataTable' nowrap class='DataTable'>Year-To-Date (<a href="javascript: switchColumn(true, 'Y')">fold</a>)</th>
      </tr>
      <tr>
        <%String [] sPrefix = {"W", "M", "Q", "Y"};%>
        <%for(int i=0; i < 4; i++) {%>
           <%for(int j=0; j < iNumOfFld; j++) {%>
            <th colspan="2" nowrap id="<%=sPrefix[i]%>03<%=j%>" class='DataTable' ><%=sColumn2[j]%></th>
           <%}%>
        <%}%>
      </tr>
      <tr>
         <%for(int i=0; i < 4; i++) {%>
            <%for(int j=0; j < iNumOfFld; j++) {%>
              <th id="<%=sPrefix[i]%>04<%=j%>" class='DataTable'>TY</th>
              <th id="<%=sPrefix[i]%>05<%=j%>" class='DataTable'>LY</th>
            <%}%>
         <%}%>
      </tr>
     <!---------------- Detail ---------------------------------------------------->
      <%for(int i=0; i < iNumOfStr; i++) {%>
        <tr onmouseover="mouseOver(this)" onmouseout="mouseOut(this)" >
           <td class="DataTable1" style="background: white;"><%=sStr[i]%></td>
           <th class='DataTable'>&nbsp;</th>
           <!-- ========== Week-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableW" style="background: white;"><%=sTyWtd[i][j]%></td>
              <td class="DataTableW" style="background: #E7E7E7;"><%=sLyWtd[i][j]%></td>
           <%}%>
           <td class="DataTable1" style="background: white;"><%=sTyWtd[i][iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: #E7E7E7;"><%=sLyWtd[i][iNumOfFld-1]%></td>
           <th class='DataTable'>&nbsp;</th>

           <!-- ========== Month-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableM" style="background: white;"><%=sTyMtd[i][j]%></td>
              <td class="DataTableM" style="background: #E7E7E7;"><%=sLyMtd[i][j]%></td>
           <%}%>
           <td class="DataTable1" style="background: white;"><%=sTyMtd[i][iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: #E7E7E7;"><%=sLyMtd[i][iNumOfFld-1]%></td>
           <th class='DataTable'>&nbsp;</th>

           <!-- ========== Quater-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableQ" style="background: white;"><%=sTyQtd[i][j]%></td>
              <td class="DataTableQ" style="background: #E7E7E7;"><%=sLyQtd[i][j]%></td>
           <%}%>
           <td class="DataTable1" style="background: white;"><%=sTyQtd[i][iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: #E7E7E7;"><%=sLyQtd[i][iNumOfFld-1]%></td>
           <th class='DataTable'>&nbsp;</th>

           <!-- ========== Quater-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableY" style="background: white;"><%=sTyYtd[i][j]%></td>
              <td class="DataTableY" style="background: #E7E7E7;"><%=sLyYtd[i][j]%></td>
           <%}%>
           <td class="DataTable1" style="background: white;"><%=sTyYtd[i][iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: #E7E7E7;"><%=sLyYtd[i][iNumOfFld-1]%></td>
        </tr>
      <%}%>


      <!----------------------------------------------------------------------->
      <!---------------- Total ------------------------------------------------>
      <!----------------------------------------------------------------------->
        <tr class="Div"><td colspan="53"></td>
        <tr onmouseover="mouseOver(this)" onmouseout="mouseOut(this)" >
           <td class="DataTable1" style="background: Cornsilk;">Total</td>
           <th class='DataTable'>&nbsp;</th>
           <!-- ========== Week-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableW" style="background: Cornsilk;"><%=sRepTyWtd[j]%></td>
              <td class="DataTableW" style="background: burlywood1;"><%=sRepLyWtd[j]%></td>
           <%}%>
           <td class="DataTable1" style="background: Cornsilk;"><%=sRepTyWtd[iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: burlywood1;"><%=sRepLyWtd[iNumOfFld-1]%></td>
           <th class='DataTable'>&nbsp;</th>

           <!-- ========== Month-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableM" style="background: Cornsilk;"><%=sRepTyMtd[j]%></td>
              <td class="DataTableM" style="background: burlywood1;"><%=sRepLyMtd[j]%></td>
           <%}%>
           <td class="DataTable1" style="background: Cornsilk;"><%=sRepTyMtd[iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: burlywood1;"><%=sRepLyMtd[iNumOfFld-1]%></td>
           <th class='DataTable'>&nbsp;</th>

           <!-- ========== Quater-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableQ" style="background: Cornsilk;"><%=sRepTyQtd[j]%></td>
              <td class="DataTableQ" style="background: burlywood1;"><%=sRepLyQtd[j]%></td>
           <%}%>
           <td class="DataTable1" style="background: Cornsilk;"><%=sRepTyQtd[iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: burlywood1;"><%=sRepLyQtd[iNumOfFld-1]%></td>
           <th class='DataTable'>&nbsp;</th>

           <!-- ========== Quater-to-date =============== -->
           <%for(int j=0; j < iNumOfFld-1; j++) {%>
              <td class="DataTableY" style="background: Cornsilk;"><%=sRepTyYtd[j]%></td>
              <td class="DataTableY" style="background: burlywood1;"><%=sRepLyYtd[j]%></td>
           <%}%>
           <td class="DataTable1" style="background: Cornsilk;"><%=sRepTyYtd[iNumOfFld-1]%></td>
           <td class="DataTable1" style="background: burlywood1;"><%=sRepLyYtd[iNumOfFld-1]%></td>
        </tr>
    </table>
</body>
</html>

<% } %>

