<%@ page import="inventoryreports.PiWiRep"%>
<%
  String sStore = request.getParameter("STORE");
  String sPiYearMo = request.getParameter("PICal");
  String sSort = request.getParameter("Sort");
  
  if(sSort == null){ sSort = "A"; }
 
  System.out.println(sStore + " " + sSort  + " " + sPiYearMo.substring(4) + " ");
  
  PiWiRep invrep = new PiWiRep(sStore, "ALL", sSort, sPiYearMo.substring(0, 4),
                sPiYearMo.substring(4), "Y");

  int iNumOfArea = invrep.getNumOfArea();
  String [] sArea = invrep.getArea();
  String [] sQty = invrep.getAllQty();
  String [] sCost = invrep.getAllCost();
  String [] sRet = invrep.getAllRet();    
  String [] sTotAllQty = invrep.getTotAllQty();
  String [] sTotAllCost = invrep.getTotAllCost();
  String [] sTotAllRet = invrep.getTotAllRet();

  System.out.println(2);
  invrep.disconnect();
%>

<html>
<head>

<style>
        body {background:ivory;}

        tr.Count {dispaly:block}

        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:cornsilk;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }


</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript">
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
}

//---------------------------------------------------------------------
// show all or only missed areas
//---------------------------------------------------------------------
function colapse()
{
  var ruleNum = 1;
  var style = document.styleSheets[0].rules[ruleNum].style.display;
  
  if(style != "none")
  {	  
    document.styleSheets[0].rules[ruleNum].style.display="none";
  }
  else
  {
	  if(isIE){ document.styleSheets[0].rules[ruleNum].style.display="block"; }
	  else{ document.styleSheets[0].rules[ruleNum].style.display="table-row"; }
  }
}

</SCRIPT>
</head>
<body  onload="bodyLoad();">

   <table border="0" width="100%" height="100%">
    <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Physical Inventory - Area Summary
      <br>Store:<%=sStore%></b><br>
<!------------- end of store selector ---------------------->
        <p style="font-size:10px"><a href="../"><font color="red">Home</font></a>&#62;        
        <a href="PIWIRepSel.jsp"><font color="red">Physical Inventory</font></a>&#62;
        This page
<!------------- start of dollars table ------------------------>
      <table class="DataTable" width="50%"  align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" colspan="4">
                 <a href="javascript: colapse();">Show All or only Missed Areas</a></th>
        </tr>
        <tr>
          <th class="DataTable"><a href="PIWIRepArea.jsp?STORE=<%=sStore%>&AREA=ALL&PICal=<%=sPiYearMo%>&Sort=A">Area</a><br/>#</th>
          <th class="DataTable"><a href="PIWIRepArea.jsp?STORE=<%=sStore%>&AREA=ALL&PICal=<%=sPiYearMo%>&Sort=Q">Qty</a></th>
          <th class="DataTable"><a href="PIWIRepArea.jsp?STORE=<%=sStore%>&AREA=ALL&PICal=<%=sPiYearMo%>&Sort=C">Cost</a></th>
          <th class="DataTable"><a href="PIWIRepArea.jsp?STORE=<%=sStore%>&AREA=ALL&PICal=<%=sPiYearMo%>&Sort=R">Retail</a></th>
        </tr>
        <!-- ---------------------- Detail Loop ----------------------- -->
        <%for(int i=0; i < iNumOfArea; i++){%>
           <tr <%if(!sQty[i].equals("Missed Area")){%>class="Count"<%}%>>
             <td class="DataTable">
                <a href="PIWIRep.jsp?STORE=<%=sStore%>&AREA=<%=sArea[i]%>&PICal=<%=sPiYearMo%>"><%=sArea[i]%></a></td>
             <td class="DataTable" <%if(sQty[i].equals("Missed Area")){%>style="color:red;"<%}%>><%=sQty[i]%></td>
             <td class="DataTable" <%if(sQty[i].equals("Missed Area")){%>style="color:red;"<%}%>><%=sCost[i]%></td>
             <td class="DataTable" <%if(sQty[i].equals("Missed Area")){%>style="color:red;"<%}%>><%=sRet[i]%></td>
           </tr>
        <%}%>

        <!----------------------- totals -------------------------------->
        <tr>
             <td class="DataTable1">Areas 1 - 220 Total</td>
             <td class="DataTable1"><%=sTotAllQty[0]%></td>
             <td class="DataTable1"><%=sTotAllCost[0]%></td>
             <td class="DataTable1"><%=sTotAllRet[0]%></td>
        </tr>
        <tr>
             <td class="DataTable1">Other Areas Total</td>
             <td class="DataTable1"><%=sTotAllQty[1]%></td>
             <td class="DataTable1"><%=sTotAllCost[1]%></td>
             <td class="DataTable1"><%=sTotAllRet[1]%></td>
        </tr>
        <tr>
             <td class="DataTable1">Store Total</td>
             <td class="DataTable1"><%=sTotAllQty[2]%></td>
             <td class="DataTable1"><%=sTotAllCost[2]%></td>
             <td class="DataTable1"><%=sTotAllRet[2]%></td>
        </tr>
       <!----------------------- end totals ----------------------------->
       </table>

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
