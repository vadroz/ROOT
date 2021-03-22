<%@ page import="employeecenter.AnnualSlrEmp, java.util.*, rciutility.FormatNumericValue, java.math.*"%>
<%
    String sSelEmp = request.getParameter("Emp");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("EMPSALARY")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AnnualSlrEmp.jsp");
}
else
{
     String sStrAllowed = session.getAttribute("STORE").toString();
     String sUser = session.getAttribute("USER").toString();
     Vector vStr = (Vector) session.getAttribute("STRLST");

     boolean bSalary = session.getAttribute("EMPSALARY") != null;

        AnnualSlrEmp salemp = new AnnualSlrEmp(sSelEmp, sUser);
        salemp.setEmpInfo();
        String sEmp = salemp.getEmp();
        String sEmpName = salemp.getEmpName();
        String sStr = salemp.getStr();
        String sTitle = salemp.getTitle();
        String sRate = salemp.getRate();
        String sHireDate = salemp.getHireDate();
        String sSCom = salemp.getSCom();
        String sDept = salemp.getDept();
        String sHorS = salemp.getHorS();
        String sNewRt = salemp.getNewRt();
        String sNewDept = salemp.getNewDept();

        FormatNumericValue fmt = new FormatNumericValue();
%>
<HTML>
<HEAD>
<title>Annual_Review</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#e7e7e7;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { background:#e7e7e7;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; vertical-align:top}
        th.DataTable3 { background:yellow;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; vertical-align:top }

        tr.DataTable { background: white; font-size:12px }
        tr.DataTable1 { background: khaki; font-size:12px; font-weight:bold }
        tr.DataTable2 { background: #ccffcc; font-size:5px }
        tr.DataTable3 { background: khaki; font-size:16px;  font-weight:bold}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmp { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
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


<script name="javascript1.2">
var HrsWrk = 0;
var Sales = 0;
var NewComPrc = 0;
var CoorInAvg = 0;
var CoorInPay = 0;
var PayBase = 0;
var PayLS = 0;
var PayMS = 0;
var PayOth = 0;
var PayH = 0;
var PayV = 0;
var PayS = 0;
var SpecCom = 0;
var NewRt = 0;
var AvgLs = 0;
var AvgMs = 0;
var AvgOth = 0;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmp"]);
   document.all.tdTyData.style.display = "none";
}
//==============================================================================
// save new rate
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
   document.all.dvEmp.innerHTML = " ";
   document.all.dvEmp.style.visibility = "hidden";
}
//==============================================================================
// show/hide TY/LY boxes
//==============================================================================
function showBox(chkobj)
{
   var disp = "none";
   if(chkobj.checked){ disp = "inline";}
   if(chkobj.value == "LY"){ document.all.tdLyData.style.display = disp; }
   else if(chkobj.value == "TY"){ document.all.tdTyData.style.display = disp; }
}

//==============================================================================
// calculate new commission
//==============================================================================
function clcNewComm()
{
   var sph = document.all.NewSph.value.trim();
   if(isNaN(sph)){ alert("the SPH is not numeric."); }
   else
   {
     var sls = (HrsWrk * sph).toFixed(2);
     document.all.tdSales.innerHTML = editNum(sls);
     var com = (sls * NewComPrc / 100.00 + eval(SpecCom)).toFixed(2);
     document.all.tdCom.innerHTML = "$" + editNum(com);
     var comavg = (com / HrsWrk).toFixed(2);
     document.all.tdComAvg.innerHTML = "$" + editNum(comavg);

     var tot = (eval(PayBase) + eval(com) + eval(CoorInPay)).toFixed(2);
     var totavg = (eval(NewRt) + eval(comavg) + eval(CoorInAvg)).toFixed(2);//(tot / HrsWrk).toFixed(2);

     document.all.tdSub01Avg.innerHTML = "$" + editNum(totavg);
     document.all.tdSub01.innerHTML = "$" + editNum(tot);

     tot = (eval(tot) + eval(PayLS) + eval(PayMS) + eval(PayOth)).toFixed(2);
     totavg = (eval(NewRt) + eval(comavg) + eval(AvgLs) + eval(AvgMs) + eval(AvgOth)).toFixed(2);//(tot / HrsWrk).toFixed(2);
     //alert("totavg: " + totavg + "\nAvgLs: " + AvgLs + "\nAvgMs: " + AvgMs + "\nAvgOth: " + AvgOth)

     document.all.tdTotRegAvg.innerHTML = "$" + editNum(totavg);
     document.all.tdTotReg.innerHTML = "$" + editNum(tot);

     tot = (eval(tot) + eval(PayH) + eval(PayS) + eval(PayV)).toFixed(2);
     document.all.tdTotEarn.innerHTML = "$" + editNum(tot);
   }
}
//==============================================================================
// save sales per hours
//==============================================================================
function savSPH()
{
   var sph = document.all.NewSph.value.trim();
   if(isNaN(sph)){ alert("The SPH is not numeric."); }
   else
   {
      var url = "NewRateSave.jsp?Emp=<%=sSelEmp%>"
        + "&Sph=" + sph
        + "&Action=SAVSPH"

      //alert(url)
      //window.location.href=url;
      window.frame1.location.href=url;
   }
}
//==============================================================================
// put coma in number
//==============================================================================
function editNum(x)
{
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
<div id="dvEmp" class="dvEmp"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Annual Salary Review Worksheet
        <br><br><%=sEmp%> <%=sEmpName%>
        <br>Department: <%=sDept%>, Title: <%=sTitle%>
        <%if(!sNewDept.equals("")){%> - New: <%=sNewDept%><%}%>
        <%if(!sSCom.equals("")) {%>
           <br>Commissions: <%if(sSCom.equals("R")) {%>Regular<%}
                         else if(sSCom.equals("S")){%>Special<%}%>
        <%}%>
        </B>
        <br><br>

        <a href="index.jsp" class="small"><font color="red">Home</font></a>&#62;
        <a href="AnnualSalaryReviewSel.jsp" class="small"><font color="red">Selection Screen</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="checkbox" name="chkLY" onclick='showBox(this)' value="LY" checked>Last Year &nbsp; &nbsp;
        <input type="checkbox" name="chkTY" onclick='showBox(this)' value="TY">This Year

        <%
          salemp.setStrSls();
          String sStrSls = salemp.getStrSls();
          String sStrHrs = salemp.getStrHrs();
          String sStrSPH = salemp.getStrSPH();
        %>
        <table border=1 cellPadding="0" cellSpacing="0">
        <tr class="DataTable">
             <th class="DataTable" rowspan=2>Days</th>
             <th class="DataTable" colspan=3>Store Average SPH</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable">Hours Worked(exc. HSV)</th>
             <th class="DataTable">Total Sales</th>
             <th class="DataTable">SPH</th>
         </tr>
         <tr class="DataTable">
             <td class="DataTable">All Days</td>
             <td class="DataTable"><%=sStrHrs%></td>
             <td class="DataTable">$<%=sStrSls%></td>
             <td class="DataTable">$<%=sStrSPH%></td>
         </tr>
         <%
          salemp.setStrWkendSls();
          sStrSls = salemp.getStrSls();
          sStrHrs = salemp.getStrHrs();
          sStrSPH = salemp.getStrSPH();
        %>
        <tr class="DataTable">
             <td class="DataTable">Weekends</td>
             <td class="DataTable"><%=sStrHrs%></td>
             <td class="DataTable">$<%=sStrSls%></td>
             <td class="DataTable">$<%=sStrSPH%></td>
         </tr>
       </table><br>

      <table border=0 cellPadding="0" cellSpacing="0">
<!-- ======================================================================= -->
<!-- ====================== Common Values=================================== -->
<!-- ======================================================================= -->
    <%
        salemp.setLYPay();
        String sHrsHL = salemp.getHrsHL();
        String sHrsOT = salemp.getHrsOT();
        String sHrsHSV = salemp.getHrsHSV();
        String sHrsWrk = salemp.getHrsWrk();
        String sPayHL = salemp.getPayHL();
        String sPayOT = salemp.getPayOT();
        String sPayLS = salemp.getPayLS();
        String sPayMS = salemp.getPayMS();
        String sPayHSV = salemp.getPayHSV();
        String sPayCom = salemp.getPayCom();
        String sPayB = salemp.getPayB();
        String sPayF = salemp.getPayF();
        String sPayO = salemp.getPayO();
        String sPayWrk = salemp.getPayWrk();
        String sPayOth = salemp.getPayOth();
        String sPayAll = salemp.getPayAll();
        String sSales = salemp.getSales();
        String sSlsHrs = salemp.getSlsHrs();
        String sAvgWage = salemp.getAvgWage();

        String sHrsH = salemp.getHrsH();
        String sHrsS = salemp.getHrsS();
        String sHrsV = salemp.getHrsV();
        String sPayH = salemp.getPayH();
        String sPayS = salemp.getPayS();
        String sPayV = salemp.getPayV();
        String sPayLMS = salemp.getPayLMS();
        String sComPrc = salemp.getComPrc();
        String sComAvg = salemp.getComAvg();
        String sCooInPay = salemp.getCooInPay();
        String sCooInAvg = salemp.getCooInAvg();
        String sPayBase = salemp.getPayBase();
        String sPaySub01 = salemp.getPaySub01();
        String sAvgSub01 = salemp.getAvgSub01();
        String sSpecCom = salemp.getSpecCom();
        
        BigDecimal bgRateOt = new BigDecimal(Double.parseDouble(sRate));
        bgRateOt = bgRateOt.multiply(BigDecimal.valueOf(1.5));        
        String sRateOT = bgRateOt.toString();
    %>

         <tr>
           <td align=center id="tdCommon" colspan=3><br>

<!-- ======================================================================= -->
<!-- ====================== Last Year ====================================== -->
<!-- ======================================================================= -->
         <tr>
           <td align=center id="tdLyData"><br><b>FY 2016 (LY)</b>

           <table border=1 cellPadding="0" cellSpacing="0" id="tblLy">
         <tr class="DataTable">
             <th class="DataTable" colspan=2>Hours Worked(exc. HSV)</th>
             <th class="DataTable" colspan=2>Total Sales</th>
             <th class="DataTable">SPH</th>
         </tr>
         <tr class="DataTable">
             <td class="DataTable" colspan=2><%=fmt.getFormatedNum(sHrsWrk, "###,###.##")%></td>
             <td class="DataTable" colspan=2>$<%=fmt.getFormatedNum(sSales, "#,###,###.##")%></td>
             <td class="DataTable">$<%=sSlsHrs%></td>
         </tr>
       </table><br>

       <table border=1 cellPadding="0" cellSpacing="0" id="tblLy">
         <tr class="DataTable">
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">Rate/Hour</th>
             <th class="DataTable">Total Dollars</th>
         </tr>

         <tr class="DataTable">
             <th class="DataTable1">Base Rate (HL, SL)*</th>
             <td class="DataTable">$<%=sRate%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayHL, "#,###,###.##")%></td>
         </tr>
         
         <tr class="DataTable">
             <th class="DataTable1">Overtime</th>
             <td class="DataTable">$<%=fmt.getFormatedNum(sRateOT, "#,###,###.##")%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayOT, "#,###,###.##")%></td>
         </tr>
         
         <tr class="DataTable">
             <th class="DataTable1">Commission Rate</th>
             <td class="DataTable">$<%=sComAvg%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayCom, "#,###,###.##")%></td>
         </tr>

         <tr class="DataTable">
             <th class="DataTable1">Coordinator Incentive</th>
             <td class="DataTable">$<%=sCooInAvg%></td>
             <td class="DataTable">$<%=sCooInPay%></td>
         </tr>
        <!-- Sub total 01 -->
         <tr class="DataTable1">
             <th class="DataTable3">Subtotal Base + Commission Rate</th>
             <%
                BigDecimal bg = new BigDecimal(Double.parseDouble(sRate)
                                             + Double.parseDouble(sComAvg)
                                             + Double.parseDouble(sCooInAvg));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sAvgSub01 = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgSub01%></td>
             <%
                bg = new BigDecimal(Double.parseDouble(sPayBase)
                                             + Double.parseDouble(sPayCom)
                                             + Double.parseDouble(sCooInPay));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sPaySub01 = bg.toString();
             %>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPaySub01, "#,###,###.##")%></td>
         </tr>

         <!-- Sub Table 02-->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable">
             <th class="DataTable1">Labor Spiffs (L)</th>
             <%
                if(!sHrsWrk.equals(".00"))
                {
                   bg = new BigDecimal(Double.parseDouble(sPayLS) / Double.parseDouble(sHrsWrk));
                }
                else{ bg = new BigDecimal("0"); }
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                String sAvgLs = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgLs%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayLS, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Paid Spiffs (M)</th>
             <%
                if(!sHrsWrk.equals(".00"))
                {
                   bg = new BigDecimal(Double.parseDouble(sPayMS) / Double.parseDouble(sHrsWrk));
                }
                else{ bg = new BigDecimal("0"); }
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                String sAvgMs = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgMs%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayMS, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Other Misc Pay(F, B, O)</th>
             <%
                if(!sHrsWrk.equals(".00"))
                {
                bg = new BigDecimal(Double.parseDouble(sPayOth) / Double.parseDouble(sHrsWrk));
                }
                else{ bg = new BigDecimal("0"); }
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                String sAvgOth = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgOth%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayOth, "#,###,###.##")%></td>
         </tr>

         <!-- Sub total 02 -->
         <tr class="DataTable1">
             <th class="DataTable3">Subtotal Spiffs + Misc</th>
             <%
                bg = new BigDecimal(Double.parseDouble(sAvgLs)
                                  + Double.parseDouble(sAvgMs)
                                  + Double.parseDouble(sAvgOth));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                String sAvgSub02 = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgSub02%></td>
             <%
                bg = new BigDecimal(Double.parseDouble(sPayLS)
                                             + Double.parseDouble(sPayMS)
                                             + Double.parseDouble(sPayOth));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                String sPaySub02 = bg.toString();
             %>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPaySub02, "#,###,###.##")%></td>
         </tr>


         <!-- Total Regular Earnings -->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable3">
             <th class="DataTable3">Total Regular Earnings</th>
             <%
                bg = new BigDecimal(Double.parseDouble(sAvgSub01)
                                  + Double.parseDouble(sAvgSub02));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                String sAvgSub03 = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgSub03%></td>
             <%
                bg = new BigDecimal(Double.parseDouble(sPaySub01)
                                  + Double.parseDouble(sPaySub02));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                String sPaySub03 = bg.toString();
             %>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPaySub03, "#,###,###.##")%></td>
         </tr>

         <!-- HSV -->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable">
             <th class="DataTable1">Holiday (H)</th>
             <td class="DataTable"><%=sHrsH%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayH, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Sick (S)</th>
             <td class="DataTable"><%=sHrsS%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayS, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Vacation (V)</th>
             <td class="DataTable"><%=sHrsV%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayV, "#,###,###.##")%></td>
         </tr>

         <!-- Total Earnings -->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable3">
             <th class="DataTable3" colspan=2>Total Earnings</th>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayAll, "#,###,###.##")%></td>
          </tr>
     </table>

     </td>
     <td> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>


     <!-- ===================================================================-->
     <!--=============== This Year projection ============================== -->
     <!-- ===================================================================-->
     <%
        salemp.setTYPay();
        sHrsHL = salemp.getHrsHL();
        sHrsOT = salemp.getHrsOT();
        sHrsHSV = salemp.getHrsHSV();
        sHrsWrk = salemp.getHrsWrk();
        sPayHL = salemp.getPayHL();
        sPayOT = salemp.getPayOT();
        sPayLS = salemp.getPayLS();
        sPayMS = salemp.getPayMS();
        sPayHSV = salemp.getPayHSV();
        sPayCom = salemp.getPayCom();
        sPayB = salemp.getPayB();
        sPayF = salemp.getPayF();
        sPayO = salemp.getPayO();
        sPayWrk = salemp.getPayWrk();
        sPayOth = salemp.getPayOth();
        sPayAll = salemp.getPayAll();
        sSales = salemp.getSales();
        sSlsHrs = salemp.getSlsHrs();
        sAvgWage = salemp.getAvgWage();

        sHrsH = salemp.getHrsH();
        sHrsS = salemp.getHrsS();
        sHrsV = salemp.getHrsV();
        sPayH = salemp.getPayH();
        sPayS = salemp.getPayS();
        sPayV = salemp.getPayV();
        sPayLMS = salemp.getPayLMS();
        sComPrc = salemp.getComPrc();
        sComAvg = salemp.getComAvg();
        sCooInPay = salemp.getCooInPay();
        sCooInAvg = salemp.getCooInAvg();
        sPayBase = salemp.getPayBase();
        sPaySub01 = salemp.getPaySub01();
        sAvgSub01 = salemp.getAvgSub01();
        sSpecCom = salemp.getSpecCom();
        
        bgRateOt = new BigDecimal(Double.parseDouble(sNewRt));
        bgRateOt = bgRateOt.multiply(BigDecimal.valueOf(1.5));        
        sRateOT = bgRateOt.toString();
    %>
    <script>
      NewComPrc = "<%=sComPrc%>";
      HrsWrk = "<%=sHrsWrk%>";
      Sales = "<%=sSales%>";
      CoorInAvg = "<%=sCooInAvg%>";
      CoorInPay = "<%=sCooInPay%>";
      PayBase = "<%=sPayBase%>"
      NewRt = "<%=sNewRt%>"
      PayLS = "<%=sPayLS%>";
      PayMS = "<%=sPayMS%>";
      PayOth = "<%=sPayOth%>";
      PayH = "<%=sPayH%>";
      PayV = "<%=sPayV%>";
      PayS = "<%=sPayS%>";
      SpecCom = "<%=sSpecCom%>";
      AvgLs = "<%=sAvgLs%>";
      AvgMs = "<%=sAvgMs%>";
      AvgOth = "<%=sAvgOth%>";
    </script>

     <td align=center id="tdTyData"><BR><b>FY 2017 (TY)</b>

     <table border=1 cellPadding="0" cellSpacing="0" id="tblLy">
         <tr class="DataTable">
             <th class="DataTable" colspan=2>Hours Worked(exc. HSV)</th>
             <th class="DataTable" colspan=2>Total Sales</th>
             <th class="DataTable">SPH</th>
         </tr>
         <tr class="DataTable">
             <td class="DataTable" colspan=2><%=fmt.getFormatedNum(sHrsWrk, "###,###.##")%></td>
             <td class="DataTable" id="tdSales" colspan=2>$<%=fmt.getFormatedNum(sSales, "#,###,###.##")%></td>
             <td class="DataTable">
                $<input name="NewSph" value="<%=sSlsHrs%>" size=7 maxlength=7 onclick="this.select()">
                <button onclick="clcNewComm()">Calculate</button> &nbsp; &nbsp; &nbsp;
                <button onclick="savSPH()">Save SPH</button>
             </td>
         </tr>
       </table><br>


      <table border=1 cellPadding="0" cellSpacing="0" id="tblLy">
         <tr class="DataTable">
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">Rate/Hour</th>
             <th class="DataTable">Total Dollars</th>
         </tr>

         <tr class="DataTable">
             <th class="DataTable1">Base Rate</th>
             <td class="DataTable" id="tdNewRt">$<%=sNewRt%></td>
             <td class="DataTable" id="tdPayBase">$<%=fmt.getFormatedNum(sPayHL, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Overtime (Projected Based off LY act)</th>
             <td class="DataTable">$<%=fmt.getFormatedNum(sRateOT, "#,###,###.##")%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayOT, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Commission Rate &nbsp; <%=sComPrc%>%</th>
             <td class="DataTable" id="tdComAvg">$<%=sComAvg%></td>
             <td class="DataTable" id="tdCom">$<%=fmt.getFormatedNum(sPayCom, "#,###,###.##")%></td>
         </tr>

         <tr class="DataTable">
             <th class="DataTable1">Coordinator Incentive</th>
             <td class="DataTable">$<%=sCooInAvg%></td>
             <td class="DataTable">$<%=sCooInPay%></td>
         </tr>
        <!-- Sub total 01 -->
         <tr class="DataTable1">
             <th class="DataTable3">Subtotal Base + Commission Rate</th>
             <%
                bg = new BigDecimal(Double.parseDouble(sNewRt)
                                             + Double.parseDouble(sComAvg)
                                             + Double.parseDouble(sCooInAvg));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                /*System.out.println(
                   "sNewRt: " + sNewRt + " | " + new BigDecimal(Double.parseDouble(sNewRt))
                 + "\nsComAvg: " + sComAvg + " | " + new BigDecimal(Double.parseDouble(sComAvg))
                 + "\nsCooInAvg: " + sCooInAvg + " | " + new BigDecimal(Double.parseDouble(sCooInAvg))
                 + "\nbg: " + bg
                );*/
                sAvgSub01 = bg.toString();
             %>
             <td class="DataTable" id="tdSub01Avg">$<%=sAvgSub01%></td>
             <%
                bg = new BigDecimal(Double.parseDouble(sPayBase)
                                             + Double.parseDouble(sPayCom)
                                             + Double.parseDouble(sCooInPay));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sPaySub01 = bg.toString();
             %>
             <td class="DataTable" id="tdSub01">$<%=fmt.getFormatedNum(sPaySub01, "#,###,###.##")%></td>
         </tr>

         <!-- Sub Table 02-->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable">
             <th class="DataTable1">Labor Spiffs</th>
             <%
                if(!sHrsWrk.equals(".00"))
                {
                   bg = new BigDecimal(Double.parseDouble(sPayLS) / Double.parseDouble(sHrsWrk));
                }
                else{ bg = new BigDecimal("0"); }
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sAvgLs = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgLs%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayLS, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Paid Spiffs</th>
             <%
                if(!sHrsWrk.equals(".00"))
                {
                   bg = new BigDecimal(Double.parseDouble(sPayMS) / Double.parseDouble(sHrsWrk));
                }
                else{ bg = new BigDecimal("0"); }
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sAvgMs = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgMs%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayMS, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Other Misc Pay</th>
             <%
                if(!sHrsWrk.equals(".00"))
                {
                   bg = new BigDecimal(Double.parseDouble(sPayOth) / Double.parseDouble(sHrsWrk));
                }
                else{ bg = new BigDecimal("0"); }
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sAvgOth = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgOth%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayOth, "#,###,###.##")%></td>
         </tr>

         <!-- Sub total 02 -->
         <tr class="DataTable1">
             <th class="DataTable3">Subtotal Spiffs + Misc</th>
             <%
                bg = new BigDecimal(Double.parseDouble(sAvgLs)
                                  + Double.parseDouble(sAvgMs)
                                  + Double.parseDouble(sAvgOth));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sAvgSub02 = bg.toString();
             %>
             <td class="DataTable">$<%=sAvgSub02%></td>
             <%
                bg = new BigDecimal(Double.parseDouble(sPayLS)
                                             + Double.parseDouble(sPayMS)
                                             + Double.parseDouble(sPayOth));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sPaySub02 = bg.toString();
             %>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPaySub02, "#,###,###.##")%></td>
         </tr>


         <!-- Total Regular Earnings -->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable3">
             <th class="DataTable3">Total Regular Earnings</th>
             <%
                bg = new BigDecimal(Double.parseDouble(sAvgSub01)
                                  + Double.parseDouble(sAvgSub02));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sAvgSub03 = bg.toString();
             %>
             <td class="DataTable" id="tdTotRegAvg">$<%=sAvgSub03%></td>
             <%
                bg = new BigDecimal(Double.parseDouble(sPaySub01)
                                  + Double.parseDouble(sPaySub02));
                bg = bg.setScale(2, BigDecimal.ROUND_HALF_EVEN);
                sPaySub03 = bg.toString();
             %>
             <td class="DataTable" id="tdTotReg">$<%=fmt.getFormatedNum(sPaySub03, "#,###,###.##")%></td>
         </tr>

         <!-- HSV -->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable">
             <th class="DataTable1">Holiday</th>
             <td class="DataTable"><%=sHrsH%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayH, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Sick</th>
             <td class="DataTable"><%=sHrsS%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayS, "#,###,###.##")%></td>
         </tr>
         <tr class="DataTable">
             <th class="DataTable1">Vacation</th>
             <td class="DataTable"><%=sHrsV%></td>
             <td class="DataTable">$<%=fmt.getFormatedNum(sPayV, "#,###,###.##")%></td>
         </tr>

         <!-- Total Earnings -->
         <tr class="DataTable2"><td class="DataTable" colspan=8>&nbsp;</td>
         <tr class="DataTable3">
             <th class="DataTable3" colspan=2>Total Earnings</th>
             <td class="DataTable" id="tdTotEarn">$<%=fmt.getFormatedNum(sPayAll, "#,###,###.##")%></td>
          </tr>
     </table>

        </TD>
       </tr>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
     <tr>
        <td style="text-align:left;">
         *The base rate/hour is the rate that the associate currently is paid.
     <br>*The Total Base dollars includes previous rate of pay and therefore will be different from current rate.
     <br>*TY OT is <b>projected</b> amount using LY hours information, but the associate may not see that same amount TY
     <br>*TY Coordinator GM amount is calculated by looking at LY gross margin (GM$/Number of allocated eligible Coord's*.005)
     </tr>
    </TBODY>
   </TABLE>
   <br><br>&nbsp;
</BODY></HTML>
<%
     salemp.disconnect();
     salemp = null;
   }
%>