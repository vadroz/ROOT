<!DOCTYPE html>	
<%@ page import="mozu_com.MozuProdStsComp, rciutility.FormatNumericValue"%>
<%
    String sWeek1 = request.getParameter("Week1");
    String sWeek2 = request.getParameter("Week2");
    String sSort = request.getParameter("Sort");

    if(sSort==null) sSort = "GRP";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MozuProdStsComp.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    MozuProdStsComp prodlst = new MozuProdStsComp(sWeek1, sWeek2, sSort, sUser);
    int iNumOfProd = prodlst.getNumOfProd();
    String  [] sCol1 = new String [] {"PHWSTOCK", "PHWOSTOCK", "PHDIVTOT"
 , "PHDIVVOL", "PHDESCNT", "PHFEATCNT", "PHPHOTOCNT", "PHCATCNT", "PHOPTCNT"
 , "PHDIVPRC", "PHONHAND"
 , "PHLIVE<br>Atributed/Completed/Live", "PHLIVEPRC<br>Atributed/Completed/Live %", "PHCOMNOSTK", "PHCNSPRC"
 , "PHNOTTRN", "PHNTPRC", "PHCOMALL", "PHCAPRC", "PHINCWSTK", "PHIWSPRC"
 , "PHINCWOSTK", "PHIWOSPRC", "PHINCALL", "PHIAPRC "};
    
 	// format Numeric value
    FormatNumericValue fmt = new FormatNumericValue();
%>

<HTML>
<HEAD>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Mozu Prod Comp</title>   


<BODY>
<TABLE class="tbl01">
  <TBODY>
  <TR  class="trHdr">
    <TD vAlign=top align=left><B>Retail Concepts Inc.
        <BR>E-Commerce Product Status Comparison
        <br>Week1: <%=sWeek1%> &nbsp; Week2: <%=sWeek2%>
        <br>
        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="MozuProdStsCompSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
  </tr>
  <TR>
    <TD vAlign=top align=left >
       <table  class="tbl02">
         <tr class="trHdr01">
           <th class="th02" rowspan=3>Div<br>#</th>
           <th class="th02" rowspan=3>Division Name</th>
           <th class="th02" rowspan=3>&nbsp;</th>
           <th class="th02" colspan=11>Live</th>    
         </tr>

          <tr class="trHdr01">
           <th class="th02" colspan=3>Units</th>
           <th class="th02" rowspan=2>&nbsp;</th>
           <th class="th02" colspan=3>Retail</th>           
          </tr>

         <tr class="trHdr01">
           <th class="th02">Wk1</th>
           <th class="th02">Wk2</th>
           <th class="th02">Var</th>
           
           <th class="th02">Wk1</th>
           <th class="th02">Wk2</th>
           <th class="th02">Var</th>

         </tr>
          
        <%boolean bRow = false; %> 
        <%for(int i=0; i < iNumOfProd; i++){
            prodlst.setDetail();
            String sGrp = prodlst.getGrp();
            String sGrpName = prodlst.getGrpName();
            String [] sWk1Val = prodlst.getWk1Val();
            String [] sWk2Val = prodlst.getWk2Val();
            String [] sVar = prodlst.getVar();
            String sRowCls = "trDtl06";
            if(bRow){sRowCls = "trDtl04";}
            bRow =!bRow;
        %>
          <tr class="<%=sRowCls%>">
            <td class="td11"><%=sGrp%></td>
            <td class="td11" nowrap><%=sGrpName%></td>

            <td class="td35">&nbsp;</td>
            <td class="td12" nowrap><%=fmt.getFormatedNum(sWk1Val[11], "#,###,###")%></td>
            <td class="td12" nowrap><%=fmt.getFormatedNum(sWk2Val[11], "#,###,###")%></td>
            <td class="td12" nowrap><%=sVar[11]%>%</td>

            <td class="td35">&nbsp;</td>
            <td class="td12" nowrap>$<%=fmt.getFormatedNum(sWk1Val[25], "#,###,###.##")%></td>
            <td class="td12" nowrap>$<%=fmt.getFormatedNum(sWk2Val[25], "#,###,###.##")%></td>
            <td class="td12" nowrap><%=sVar[25]%>%</td>
           </tr>
           <%}%>
           
           
           <!-- ========== Total =============================== -->
           <tr class="DataTable">
              <td style="background:darkred; font-size:1px;" colspan=80>&nbsp;</td>
           </tr> 
           
           <%
              prodlst.setTotal();              
              String [] sWk1Val = prodlst.getWk1Val();
              String [] sWk2Val = prodlst.getWk2Val();
              String [] sVar = prodlst.getVar();           
           %>
           <tr class="trDtl04">
            <td class="td11" nowrap colspan=2>Total</td>

            <td class="td35">&nbsp;</td>
            <td class="td12" nowrap><%=fmt.getFormatedNum(sWk1Val[11], "#,###,###")%></td>
            <td class="td12" nowrap><%=fmt.getFormatedNum(sWk2Val[11], "#,###,###")%></td>
            <td class="td12" nowrap><%=sVar[11]%>%</td>

            <td class="td35">&nbsp;</td>
            <td class="td12" nowrap>$<%=fmt.getFormatedNum(sWk1Val[25], "#,###,###.##")%></td>
            <td class="td12" nowrap>$<%=fmt.getFormatedNum(sWk2Val[25], "#,###,###.##")%></td>
            <td class="td12" nowrap><%=sVar[25]%>%</td>
          </tr>
            <!-- ======================================== -->
           </td>
         </tr>
       </table>
    </td>
   </tr>
  </table>
</body>
</html>
<%
    prodlst.disconnect();
    prodlst = null;
   }
%>