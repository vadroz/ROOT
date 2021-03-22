<%@ page import="payrollreports.StrEmpComm, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sWkend = request.getParameter("Wkend");

   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=StrEmpComm.jsp&" + request.getQueryString());
   }
   else
   {
     String sUser = session.getAttribute("USER").toString();

     StrEmpComm empcomm = new StrEmpComm(sStore, sWkend, sUser);

     String [] sWeek = empcomm.getWeek();

     int iNumOfEmp = empcomm.getNumOfEmp();
     String [] sEmp = empcomm.getEmp();
     String [] sStr = empcomm.getStr();
     String [] sName = empcomm.getName();
     String [] sDept = empcomm.getDept();
     String [] sTitle = empcomm.getTitle();
     String [] sHorS = empcomm.getHorS();
     String [][] sWkPay = empcomm.getWkPay();
     String [][] sWkSpec = empcomm.getWkSpec();
     String [][] sWkReg = empcomm.getWkReg();
     String [][] sWkSpcCom = empcomm.getWkSpcCom();
     String [] sSCom = empcomm.getSCom();
%>

<html>
<head>
<META content="RCI, Inc." name="E-Commerce">
</head>
<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px; text-align:center;}
        th.DataTable { background:#FFCC99; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:green; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:white; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:black; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:1px }

        tr.DataTable { background:#E7E7E7;  font-size:10px }
        tr.DataTable1 { background:cornSilk;  font-size:10px }
        tr.DataTable2 { background:#ccffcc;  font-size:11px; text-align:center }
        tr.DataTable3 { background:#ccffcc;  font-size:11px; text-align: right }
        tr.DataTable4 { background: cornsilk;  font-size:11px; text-align: right }

        td.DataTable { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

        td.DataTable3 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable4 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable5 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }

        td.LineBreak { border-bottom: darkred solid 4px; font-size:1px }
        .break { page-break-before: always; }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
        div.dvDtl { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;  background: #016aab;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;  background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        .Parag01 { text-align:left;}
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var Weeks = new Array(2);
Weeks[0] = "<%=sWeek[0]%>";
Weeks[1] = "<%=sWeek[1]%>";

var SelEmp = null;
var SelEmpNm = null;
var SelWeek = null;

//--------------- End of Global variables -----------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
// get employee weekly commission details
//==============================================================================
function getWkDtl(emp, empnm, wk)
{
   SelEmp = emp;
   SelEmpNm = empnm;
   SelWeek = Weeks[wk];

   var url = "StrEmpCommDtl.jsp?Emp=" + emp
      + "&Wkend=" + Weeks[wk]

   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//==============================================================================
// show  employee weekly commission details
//==============================================================================
function showEmpWkCommDtl(str, posret, poscomm, negret, negcomm, totret, totcomm)
{
  var hdr = "Employee:&nbsp;" + SelEmp + "&nbsp; Week: " + SelWeek;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popCommPanel(str, posret, poscomm, negret, negcomm, totret, totcomm)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 380;
   document.all.dvItem.style.left= getLeftScreenPos() + 300;
   document.all.dvItem.style.top= getTopScreenPos() + 100;
   document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
// populate employee commission panel
//==============================================================================
function popCommPanel(str, posret, poscomm, negret, negcomm, totret, totcomm)
{
   var dummy = "<table>";
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
   panel += "<tr class='DataTable2'><th>Store</th>"
	   	   + "<th class='DataTable3'>&nbsp;</th>"
           + "<th>Sales</th>"
           + "<th>Sales<br>Comm</th>"
           + "<th class='DataTable3'>&nbsp;</th>"
           + "<th>Returns</th>"
           + "<th>Returns<br>Comm</th>"
           + "<th class='DataTable3'>&nbsp;</th>"
           + "<th>Net<br>Sales</th>"
           + "<th>Net<br>Comm</th>"
         + "</tr>"
    ;
         
   var empposret = 0;
   var empposcomm = 0;
   var empnegret = 0;
   var empnegcomm = 0;
   var emptotret = 0;
   var emptotcomm = 0;
         
   for(var i=0; i < str.length; i++)
   {
       panel += "<tr class='DataTable3'>"
           + "<td>" + str[i] + "</td>"
           + "<th class='DataTable3'>&nbsp;</th>"
           + "<td>" + posret[i] + "</td>"
           + "<td>" + poscomm[i] + "</td>"
           + "<th class='DataTable3'>&nbsp;</th>"
           + "<td>" + negret[i] + "</td>"
           + "<td>" + negcomm[i] + "</td>"
           + "<th class='DataTable3'>&nbsp;</th>"
           + "<td><a href='javascript:getWkCommSls(&#34;" + str[i] + "&#34;,&#34;"
             + SelEmp + "&#34;,&#34;" + SelWeek + "&#34;)'>" + totret[i] + "</a></td>"
           + "<td>" + totcomm[i] + "</td>"
         + "</tr>"
         ;
       empposret += eval(posret[i]);
       empposcomm += eval(poscomm[i]);
       empnegret += eval(negret[i]);
       empnegcomm += eval(negcomm[i]);  
       emptotret += eval(totret[i]);
       emptotcomm += eval(totcomm[i]);
   }
   
   empposret = empposret.toFixed(2);
   empposcomm = empposcomm.toFixed(2);
   empnegret = empnegret.toFixed(2);
   empnegcomm = empnegcomm.toFixed(2);
   emptotret = emptotret.toFixed(2);
   emptotcomm = emptotcomm.toFixed(2);
   
   panel += "<tr class='DataTable4'>"
       + "<td>Total</td>"
       + "<th class='DataTable3'>&nbsp;</th>"
       + "<td>" + empposret + "</td>"
       + "<td>" + empposcomm + "</td>"
       + "<th class='DataTable3'>&nbsp;</th>"
       + "<td>" + empnegret + "</td>"
       + "<td>" + empnegcomm + "</td>"
       + "<th class='DataTable3'>&nbsp;</th>"
       + "<td>" + emptotret + "</td>"
       + "<td>" + emptotcomm + "</td>"
     + "</tr>"
     ;
   
   panel += "<tr class='DataTable2'><td class='Prompt1' colspan='10'>"
     + "<p class='Parag01'><span>"
       + "<br> &nbsp; <u><b>Calculations for Total Employee Commission Paid:</b></u>"
       + "<br>All commissions for sales and returns are accumulated and paid to the"
       + "<br>salesperson (employee) for their Home store."
       + "<br><br>For Commissions " 
       + "<span style='color: darkred; font-size:11px; font-style: italic; font-weight:bold;'>outside</span>" 
       + " an employee’s Home Store:"
       + "<br> &nbsp; &nbsp; - If the employee HAS recorded work hours, all commissions for sales"
       + "<br> &nbsp; &nbsp; &nbsp; and returns are accumulated and paid to the salesperson (employee)."
       + "<br> &nbsp; &nbsp; - If the employee DOES NOT have recorded work hours, ONLY the returns"
       + "<br> &nbsp; &nbsp; &nbsp; are considered 'validated POS returns' and will be deducted from the"
       + "<br> &nbsp; &nbsp; &nbsp; salesperson (employee's) commission pay."
     + "</span>"

   panel += "<tr class='DataTable2'><td class='Prompt1' colspan='10'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

   panel += "</table>";

  return panel;
}
//==============================================================================
// get employee weekly commission details
//==============================================================================
function getWkCommSls(str, emp, wk)
{
   SelEmp = emp;
   SelWeek = Weeks[wk];
   hidePanel();

   var url = "StrEmpSlsComm.jsp?Emp=" + emp
      + "&Wkend=" + wk
      + "&Str=" + str
      + "&EmpNm=" + SelEmpNm

   //alert(url)
   window.open(url);
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvDtl" class="dvDtl"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" height="100%">
             <tr>
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Store Employee Commissions</b><br>
<!-------------------------------------------------------------------->
      <b>Store:&nbsp;<%=sStore%>
      <br>Pay Period: <%=sWeek[0]%>, <%=sWeek[1]%></b>
      <br>
<!-------------------------------------------------------------------->
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrEmpCommSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <font size="-1">This page</font>
    <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable" rowspan=3>Employee</th>
            <th class="DataTable" rowspan=3>Str</th>
            <th class="DataTable" rowspan=3>Ttl</th>
            <th class="DataTable" rowspan=3>Dept</th>
            <th class="DataTable" rowspan=3>Hourly<br>Salary</th>
            <th class="DataTable" rowspan=3>&nbsp;</th>
            <th class="DataTable" colspan=18>Pay Period Weeks<br>Commissions Only</th>
         </tr>
         <tr>
            <th class="DataTable" colspan=5>Week 1<br><%=sWeek[0]%></th>
            <th class="DataTable" colspan=5>Week 2<br><%=sWeek[1]%></th>
            <th class="DataTable" colspan=4>Total</th>
          </tr>
          <tr>
            <th class="DataTable">D<br>t<br>l</th>
            <th class="DataTable">Reg<br>Comm</th>
            <th class="DataTable">Coordinator<br>GM% Comm</th>
            <th class="DataTable">Spec<br>Comm</th>
            <th class="DataTable">Total</th>

            <th class="DataTable">D<br>t<br>l</th>
            <th class="DataTable">Reg<br>Comm</th>
            <th class="DataTable">Coordinator<br>GM% Comm</th>
            <th class="DataTable">Spec<br>Comm</th>
            <th class="DataTable">Total</th>

            <th class="DataTable">Reg<br>Comm</th>
            <th class="DataTable">Coordinator<br>GM% Comm</th>
            <th class="DataTable">Spec<br>Comm</th>
            <th class="DataTable">Total</th>
          </tr>
         <!------------------------- Data Detail ------------------------------>
         <%for(int i=0; i < iNumOfEmp; i++ ) {%>
             <%if(i < iNumOfEmp - 1){%>
                <tr class="DataTable">
                   <td class="DataTable1" nowrap><%=sEmp[i] + " " + sName[i]%></td>
                   <td class="DataTable1" nowrap><%=sStr[i]%></td>
                   <td class="DataTable1" nowrap>&nbsp;<%=sTitle[i]%></td>
                   <td class="DataTable1" nowrap>&nbsp;<%=sDept[i]%></td>
                   <td class="DataTable2" >&nbsp;<%=sHorS[i]%></td>
             <%} else {%>
                <tr><td class="LineBreak" colspan=23>&nbsp;</td></tr>
                <tr class="DataTable1">
                   <td class="DataTable1" colspan=5>Store Total</td>
             <%}%>

             <th class="DataTable" >&nbsp;</th>

             <%if(i < iNumOfEmp - 1){%><th class="DataTable" ><a href="javascript: getWkDtl('<%=sEmp[i]%>', '<%=sName[i]%>', 0)">D</a></th><%}
             else{%><td class="DataTable1">&nbsp;</td><%}%>

             <td class="DataTable" >&nbsp;<%if(!sWkReg[i][0].equals(".00")){%>$<%=sWkReg[i][0]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkSpec[i][0].equals(".00")){%>$<%=sWkSpec[i][0]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkSpcCom[i][0].equals(".00")){%>$<%=sWkSpcCom[i][0]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkPay[i][0].equals(".00")){%>$<%=sWkPay[i][0]%><%}%></td>

             <%if(i < iNumOfEmp - 1){%><th class="DataTable" ><a href="javascript: getWkDtl('<%=sEmp[i]%>', '<%=sName[i]%>', 1)">D</a></th><%}
             else{%><td class="DataTable1">&nbsp;</td><%}%>
             <td class="DataTable" >&nbsp;<%if(!sWkReg[i][1].equals(".00")){%>$<%=sWkReg[i][1]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkSpec[i][1].equals(".00")){%>$<%=sWkSpec[i][1]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkSpcCom[i][1].equals(".00")){%>$<%=sWkSpcCom[i][1]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkPay[i][1].equals(".00")){%>$<%=sWkPay[i][1]%><%}%></td>

             <td class="DataTable" >&nbsp;<%if(!sWkReg[i][2].equals(".00")){%>$<%=sWkReg[i][2]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkSpec[i][2].equals(".00")){%>$<%=sWkSpec[i][2]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkSpcCom[i][2].equals(".00")){%>$<%=sWkSpcCom[i][2]%><%}%></td>
             <td class="DataTable" >&nbsp;<%if(!sWkPay[i][2].equals(".00")){%>$<%=sWkPay[i][2]%><%}%></td>
             </tr>
         <%}%>
      </table>
     <!--------------------------------------------------------------------->
  </table>
  <br><span>
  <u><b>Calculations for Total Employee Commission Paid:</b></u>
     <br>All commissions for sales and returns are accumulated and paid to the salesperson (employee) for their Home store.
     <br>For Commissions outside an employee’s Home Store:
     <br>&nbsp;- If the employee HAS recorded work hours, all commissions for sales and returns are accumulated and paid to the salesperson (employee).
     <br>&nbsp;- If the employee DOES NOT have recorded work hours, ONLY the returns are considered ‘validated POS returns’ and will be deducted from the original salesperson (employee’s) commission pay.
  </span>
 </body>
</html>
<%
   empcomm.disconnect();
   empcomm = null;
}%>