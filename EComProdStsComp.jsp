<%@ page import="ecommerce.EComProdStsComp"%>
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
    EComProdStsComp prodlst = new EComProdStsComp(sWeek1, sWeek2, sSort, sUser);
    int iNumOfProd = prodlst.getNumOfProd();
    String  [] sCol1 = new String [] {"PHWSTOCK", "PHWOSTOCK", "PHDIVTOT"
 , "PHDIVVOL", "PHDESCNT", "PHFEATCNT", "PHPHOTOCNT", "PHCATCNT", "PHOPTCNT"
 , "PHDIVPRC", "PHONHAND"
 , "PHLIVE<br>Atributed/Completed/Live", "PHLIVEPRC<br>Atributed/Completed/Live %", "PHCOMNOSTK", "PHCNSPRC"
 , "PHNOTTRN", "PHNTPRC", "PHCOMALL", "PHCAPRC", "PHINCWSTK", "PHIWSPRC"
 , "PHINCWOSTK", "PHIWOSPRC", "PHINCALL", "PHIAPRC "};
%>

<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:12px }

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

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
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

<BODY>
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
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
       <table>
         <tr class="DataTable">
           <th class="DataTable" rowspan=4>Div<br>#</th>
           <th class="DataTable" rowspan=4>Division Name</th>
           <th class="DataTable">&nbsp;</th>
           <th class="DataTable" colspan=35>Attributed/Complete</th>
           <th class="DataTable">&nbsp;</th>
           <th class="DataTable" colspan=31>Attributed/Incomplete</th>
         </tr>
         <tr class="DataTable">
           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=11>Live</th>
           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=7>Not Live<br>With Stock<br>Not Turned On</th>

           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=7>Not Live<br>W/O Stock</th>
           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=7>Attributed<br>Complete<br>Total</th>
           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=11>With Stock</th>
           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=7>W/O Stock</th>
           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=7>Attributed<br>Incomplete<br>Total</th>
           <th class="DataTable" rowspan=3>&nbsp;</th>
           <th class="DataTable" colspan=3>Attributed<br>Total</th>
         </tr>

         <tr class="DataTable">

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
                      
           <th class="DataTable" rowspan=2>&nbsp;</th>           
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           
           <th class="DataTable" rowspan=2>&nbsp;</th>           
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>

           <th class="DataTable">Wk1</th>
           <th class="DataTable">Wk2</th>
           <th class="DataTable">Var</th>
         </tr>
         <tr class="DataTable">
           <%for(int j=0; j < 17; j ++){%>
              <th class="DataTable" colspan=3><%=j+1%></th>
           <%}%>
         </tr>


        <%for(int i=0; i < iNumOfProd; i++){
            prodlst.setDetail();
            String sGrp = prodlst.getGrp();
            String sGrpName = prodlst.getGrpName();
            String [] sWk1Val = prodlst.getWk1Val();
            String [] sWk2Val = prodlst.getWk2Val();
            String [] sVar = prodlst.getVar();
        %>
          <tr class="DataTable">
            <td class="DataTable"><%=sGrp%></td>
            <td class="DataTable1" nowrap><%=sGrpName%></td>


            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[11]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[11]%></td>
            <td class="DataTable2" nowrap><%=sVar[11]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[12]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[12]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[12]%>%</td>
            
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWk1Val[25]%></td>
            <td class="DataTable2" nowrap>$<%=sWk2Val[25]%></td>
            <td class="DataTable2" nowrap><%=sVar[25]%>%</td>


            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[15]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[15]%></td>
            <td class="DataTable2" nowrap><%=sVar[15]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[16]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[16]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[16]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[13]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[13]%></td>
            <td class="DataTable2" nowrap><%=sVar[13]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[14]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[14]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[14]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[17]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[17]%></td>
            <td class="DataTable2" nowrap><%=sVar[17]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[18]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[18]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[18]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[19]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[19]%></td>
            <td class="DataTable2" nowrap><%=sVar[19]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[20]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[20]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[20]%>%</td>
            
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWk1Val[27]%></td>
            <td class="DataTable2" nowrap>$<%=sWk2Val[27]%></td>
            <td class="DataTable2" nowrap><%=sVar[27]%>%</td>
            

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[21]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[21]%></td>
            <td class="DataTable2" nowrap><%=sVar[21]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[22]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[22]%></td>
            <td class="DataTable2" nowrap><%=sVar[22]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[23]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[23]%></td>
            <td class="DataTable2" nowrap><%=sVar[23]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[24]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[24]%></td>
            <td class="DataTable2" nowrap><%=sVar[24]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[2]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[2]%></td>
            <td class="DataTable2" nowrap><%=sVar[2]%>%</td>
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
           <tr class="DataTable">
            <td class="DataTable1" nowrap colspan=2>Total</td>


            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[11]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[11]%></td>
            <td class="DataTable2" nowrap><%=sVar[11]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[12]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[12]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[12]%>%</td>
            
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWk1Val[25]%></td>
            <td class="DataTable2" nowrap>$<%=sWk2Val[25]%></td>
            <td class="DataTable2" nowrap><%=sVar[25]%>%</td>


            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[15]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[15]%></td>
            <td class="DataTable2" nowrap><%=sVar[15]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[16]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[16]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[16]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[13]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[13]%></td>
            <td class="DataTable2" nowrap><%=sVar[13]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[14]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[14]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[14]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[17]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[17]%></td>
            <td class="DataTable2" nowrap><%=sVar[17]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[18]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[18]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[18]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[19]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[19]%></td>
            <td class="DataTable2" nowrap><%=sVar[19]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[20]%>%</td>
            <td class="DataTable2" nowrap><%=sWk2Val[20]%>%</td>
            <td class="DataTable2" nowrap><%=sVar[20]%>%</td>
            
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap>$<%=sWk1Val[27]%></td>
            <td class="DataTable2" nowrap>$<%=sWk2Val[27]%></td>
            <td class="DataTable2" nowrap><%=sVar[27]%>%</td>
            

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[21]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[21]%></td>
            <td class="DataTable2" nowrap><%=sVar[21]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[22]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[22]%></td>
            <td class="DataTable2" nowrap><%=sVar[22]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[23]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[23]%></td>
            <td class="DataTable2" nowrap><%=sVar[23]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[24]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[24]%></td>
            <td class="DataTable2" nowrap><%=sVar[24]%>%</td>

            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sWk1Val[2]%></td>
            <td class="DataTable2" nowrap><%=sWk2Val[2]%></td>
            <td class="DataTable2" nowrap><%=sVar[2]%>%</td>
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