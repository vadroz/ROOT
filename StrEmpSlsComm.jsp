<%@ page import="java.util.*, java.sql.*, rciutility.RunSQLStmt, java.math.*"%>
<%
   String sStr = request.getParameter("Str");
   String sEmp = request.getParameter("Emp");
   String sEmpNm = request.getParameter("EmpNm");
   String sWkend = request.getParameter("Wkend");

   if(sStr==null){ sStr = "ALL"; }


if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrEmpSlsComm.jsp&" + request.getQueryString());
}
else
{
      Vector<String> vStore = new Vector<String>();
      Vector<String> vRet = new Vector<String>();
      Vector<String> vQty = new Vector<String>();
      Vector<String> vEmp = new Vector<String>();
      Vector<String> vEmpNm = new Vector<String>();
      Vector<String> vDate = new Vector<String>();
      Vector<String> vSku  = new Vector<String>();
      Vector<String> vReg = new Vector<String>();
      Vector<String> vTran = new Vector<String>();
      Vector<String> vDesc = new Vector<String>();
      Vector<String> vPct = new Vector<String>();
      Vector<String> vDiv = new Vector<String>();
      Vector<String> vType = new Vector<String>();
      Vector<String> vComm = new Vector<String>();

      String sPrepStmt = "select 'Special' as type , scdai as date,  erci, ename, ehors"
    	+ ", SCREG as reg, SCENT as trans, SCPRCT as comm_prc, SCAMNT as comm_amt"
    	+ ", isku, idiv, icls, ides, scret as ret,  dec(scqty,9,0)  as qty"    	
    	+ " from rci.scomHst" 
    	+ " inner join rci.rciemp on SCSCEM=erci"
    	+ " left join iptsfil.IpItHdr on isku=scsku"
    	+ " where SCSCEM =" + sEmp + " and SCIST = " + sStr
        + " and SCWEI ='" + sWkend + "'"
        + " union "
        + " select 'Regular' as type ,rcdai as date,  erci, ename, ehors" 
        + ", rCREG as reg,rCENT as trans, rCPRCT as comm_prc,rCAMNT as comm_amt"
        + ", isku, idiv, icls, ides"
        + ", rcret as ret, dec(rcqty,9,0) as qty"
        + " from rci.rcomHst"
        + " inner join rci.rciemp on rcemp=erci"
        + " left join iptsfil.IpItHdr on isku=rcsku"
        + " where rcemp = " + sEmp + " and rCIST = " + sStr
        + "	and rCWEI = '" + sWkend + "'"
        + " order by date, isku"
    	;	  
    	
      System.out.println(sPrepStmt);

      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      ResultSet rs = runsql.runQuery();

      while(runsql.readNextRecord())
      {
    	 vType.add(runsql.getData("type"));
         vEmp.add(runsql.getData("erci"));
         vEmpNm.add(runsql.getData("ename"));
         vDate.add(runsql.getData("date"));
         vRet.add(runsql.getData("ret"));
         vQty.add(runsql.getData("qty"));
         vSku.add(runsql.getData("isku"));
         vReg.add(runsql.getData("reg"));
         vTran.add(runsql.getData("trans"));
         vDesc.add(runsql.getData("ides"));
         String sDiv = runsql.getData("idiv");
         vDiv.add(sDiv);
         String sCls = runsql.getData("icls");
         vPct.add( runsql.getData("comm_prc") ); 
         vComm.add( runsql.getData("comm_amt") );
     }
      
     double dComm = 0.00;
     double dRet = 0.00;
 %>
<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center; font-size:10px}
        th.DataTable { background:#FFCC99; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:green; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:white; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#E7E7E7;   }
        tr.DataTable1 { background:cornSilk;}
        tr.DataTable2 { background:#ccffcc; text-align:center }
        tr.DataTable3 { background:#cccfff;  font-size:11px; text-align:center }

        td.DataTable { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Arial; font-size:10px }

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

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
        .Parag01 { text-align:left;}
</style>
<SCRIPT language="JavaScript">
</SCRIPT>
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
      <b>Store:&nbsp;<%=sStr%>
      <br>Employee: <%=sEmp%> <%=sEmpNm%>
      <br>Pay Period: <%=sWkend%></b>
      <br>
<!-------------------------------------------------------------------->
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrEmpCommSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <font size="-1">This page</font>
    <!----------------- beginning of table ------------------------>
      <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable">Sale<br>Date</th>
            <th class="DataTable">Employee</th>
            <th class="DataTable">Reg<br>#</th>
            <th class="DataTable">Trans<br>#</th>
            <th class="DataTable">Div</th>
            <th class="DataTable">SKU</th>
            <th class="DataTable">Item<br>Description</th>
            <th class="DataTable">Qty</th>
            <th class="DataTable">Sales<br>Amount</th>
            <th class="DataTable">Comm<br>%</th>
            <th class="DataTable">Comm<br>Amt</th>
            <th class="DataTable">Comm<br>type</th>
         </tr>
         <%for(int i=0; i < vEmp.size(); i++ )
         {
        	 BigDecimal bd = new BigDecimal(vComm.get(i));
        	 String sComm = bd.toString();
             dComm += bd.doubleValue();

             bd = new BigDecimal(vRet.get(i));
             dRet += bd.doubleValue();
         %>
           <tr>
            <td class="DataTable"><%=vDate.get(i)%></td>
           	<td class="DataTable1"><%=vEmp.get(i)%> - <%=vEmpNm.get(i)%></td>
           	<td class="DataTable"><%=vReg.get(i)%></td>
           	<td class="DataTable"><%=vTran.get(i)%></td>
           	<td class="DataTable"><%=vDiv.get(i)%></td>
           	<td class="DataTable"><%=vSku.get(i)%></td>
           	<td class="DataTable1"><%=vDesc.get(i)%></td>
           	<td class="DataTable"><%=vQty.get(i)%></td>
           	<td class="DataTable">$<%=vRet.get(i)%></td>
           	<td class="DataTable"><%=vPct.get(i)%>%</td>
           	<td class="DataTable">$<%=vComm.get(i)%></td>
           	<td class="DataTable"><%=vType.get(i)%></td>
           </tr>
         <%}%>
         <!-- ========================= totals ========================== -->
         <%
         	BigDecimal bd = new BigDecimal(dRet);
         	bd = bd.setScale(2, BigDecimal.ROUND_HALF_EVEN);
         	String sRet = bd.toString();
         	
         	bd = new BigDecimal(dComm);
         	bd = bd.setScale(2, BigDecimal.ROUND_HALF_EVEN);
         	String sComm = bd.toString();
         %>
         <tr class="DataTable1">
           <td class="DataTable">Total</td>
           <td class="DataTable" colspan=7>&nbsp;</td>
           <td class="DataTable">$<%=sRet%></td>
           <td class="DataTable">&nbsp;</td>
           <td class="DataTable">$<%=sComm%></td>
           <td class="DataTable">&nbsp;</td>
         </tr>
      <!--------------------------------------------------------------------->
  </table>
  <p class="Parag01"><span>
  <u><b>Calculations for Total Employee Commission Paid:</b></u>
     <br>All commissions for sales and returns are accumulated and paid to the salesperson (employee) for their Home store.
     <br>For Commissions outside an employee’s Home Store:
     <br>&nbsp;- If the employee HAS recorded work hours, all commissions for sales and returns are accumulated and paid to the salesperson (employee).
     <br>&nbsp;- If the employee DOES NOT have recorded work hours, ONLY the returns are considered ‘validated POS returns’ and will be deducted from the original salesperson (employee’s) commission pay.
  </span>
 </body>
</html>
<%}%>




