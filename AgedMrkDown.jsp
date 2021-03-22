<%@ page import="agedanalysis.AgedMrkDown, java.util.*, java.text.*"%>
<%
   long lStartTime = (new Date()).getTime();

   String sDivision = request.getParameter("Div");
   String sDepartment = request.getParameter("Dpt");
   String sClass = request.getParameter("Cls");

   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";

   /*System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
          + sStore  + " " + sLevel + " " + sByStr);*/
    AgedMrkDown agemkd = new AgedMrkDown(sDivision, sDepartment, sClass);

    int iNumOfGrp = agemkd.getNumOfGrp();
    String sColumn = "Class";
    if (sDivision.equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL")){ sColumn = "Division"; }
    else if (sDepartment.equals("ALL") && sClass.equals("ALL")){ sColumn = "Department"; }
%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-right:3px; padding-left:3px;  padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }
        tr.Divider { background:darkred; font-size:3px }

        tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
}

//--------------------------------------------------------
// Show data by Store
//--------------------------------------------------------
function drillDown(grp)
{
  var url = "AgedMrkDown.jsp?"

  var div = "<%=sDivision%>";
  var dpt = "<%=sDepartment%>";
  var cls = "<%=sClass%>";

  if(div=="ALL" && dpt == "ALL" && cls == "ALL")  { div = grp; }
  else if(dpt == "ALL" && cls == "ALL")  { dpt = grp; }
  else if(cls == "ALL")  { cls = grp; }

  url += "Div=" + div
       + "&Dpt=" + dpt
       + "&Cls=" + cls
  //alert(url);
  window.location.href = url;
}
</SCRIPT>


</head>
<body onload="bodyLoad()">

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Aged Inventory Markdown Analisys</b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <b>
       <br>Division: <%=sDivision%>
       &nbsp;&nbsp; Department: <%=sDepartment%>
       &nbsp;&nbsp; Class: <%=sClass%></b><br>


      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="AgedMrkDownSel.jsp">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable" rowspan=2><%=sColumn%></th>
          <th class="DataTable" rowspan=2>Last Didgit</th>

          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=3>Retail</th>

          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=3>Cost</th>

          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=3>Unit</th>

          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable" colspan=3>Markup</th>
        </tr>

        <tr>
	  <th class="DataTable">All</th>
          <th class="DataTable">1 Year Old</th>
          <th class="DataTable">2 Year Old</th>

          <th class="DataTable">All</th>
          <th class="DataTable">1 Year Old</th>
          <th class="DataTable">2 Year Old</th>

          <th class="DataTable">All</th>
          <th class="DataTable">1 Year Old</th>
          <th class="DataTable">2 Year Old</th>

          <th class="DataTable">All</th>
          <th class="DataTable">1 Year Old</th>
          <th class="DataTable">2 Year Old</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++)
           {
              agemkd.setGrpInfo();
              String sGrp = agemkd.getGrp();
              String sGrpName = agemkd.getGrpName();
              String [] sLstDgt = agemkd.getLstDgt();
              String [] sRetAll = agemkd.getRetAll();
              String [] sRet1Yr = agemkd.getRet1Yr();
              String [] sRet2Yr = agemkd.getRet2Yr();

              String [] sCstAll = agemkd.getCstAll();
              String [] sCst1Yr = agemkd.getCst1Yr();
              String [] sCst2Yr = agemkd.getCst2Yr();

              String [] sUntAll = agemkd.getUntAll();
              String [] sUnt1Yr = agemkd.getUnt1Yr();
              String [] sUnt2Yr = agemkd.getUnt2Yr();

              String [] sMupAll = agemkd.getMupAll();
              String [] sMup1Yr = agemkd.getMup1Yr();
              String [] sMup2Yr = agemkd.getMup2Yr();

              String sTotRetAll = agemkd.getTotRetAll();
              String sTotRet1Yr = agemkd.getTotRet1Yr();
              String sTotRet2Yr = agemkd.getTotRet2Yr();

              String sTotCstAll = agemkd.getTotCstAll();
              String sTotCst1Yr = agemkd.getTotCst1Yr();
              String sTotCst2Yr = agemkd.getTotCst2Yr();

              String sTotUntAll = agemkd.getTotUntAll();
              String sTotUnt1Yr = agemkd.getTotUnt1Yr();
              String sTotUnt2Yr = agemkd.getTotUnt2Yr();

              String sTotMupAll = agemkd.getTotMupAll();
              String sTotMup1Yr = agemkd.getTotMup1Yr();
              String sTotMup2Yr = agemkd.getTotMup2Yr();
           %>
              <tr class="DataTable">
                <%if (sClass.equals("ALL")){%>
                   <td class="DataTable1" rowspan=5 nowrap><a href="javascript: drillDown('<%=sGrp%>')"><%=sGrp + " - " + sGrpName%></a></td>
                <%} else{%><td class="DataTable1" rowspan=5 nowrap><%=sGrp + " - " + sGrpName%></td><%}%>

                <%for(int j=0; j < 5; j++){%>
                   <%if(j > 0){%><tr class="DataTable"><%}%>
                     <td class="DataTable2" nowrap>
                       <%if(sLstDgt[j].equals("R")){%>Regular<%} else if(sLstDgt[j].equals("1")){%>"1,2,3"<%} else{%><%=sLstDgt[j]%><%}%>
                     </td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sRetAll[j]%></td>
                     <td class="DataTable" nowrap><%=sRet1Yr[j]%></td>
                     <td class="DataTable" nowrap><%=sRet2Yr[j]%></td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sCstAll[j]%></td>
                     <td class="DataTable" nowrap><%=sCst1Yr[j]%></td>
                     <td class="DataTable" nowrap><%=sCst2Yr[j]%></td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sUntAll[j]%></td>
                     <td class="DataTable" nowrap><%=sUnt1Yr[j]%></td>
                     <td class="DataTable" nowrap><%=sUnt2Yr[j]%></td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sMupAll[j]%>%</td>
                     <td class="DataTable" nowrap><%=sMup1Yr[j]%>%</td>
                     <td class="DataTable" nowrap><%=sMup2Yr[j]%>%</td>
                   </tr>
                <%}%>
                <tr class="DataTable3">
                  <td class="DataTable1"nowrap>Total</td>
                  <td class="DataTable2" nowrap>All</td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sTotRetAll%></td>
                     <td class="DataTable" nowrap><%=sTotRet1Yr%></td>
                     <td class="DataTable" nowrap><%=sTotRet2Yr%></td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sTotCstAll%></td>
                     <td class="DataTable" nowrap><%=sTotCst1Yr%></td>
                     <td class="DataTable" nowrap><%=sTotCst2Yr%></td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sTotUntAll%></td>
                     <td class="DataTable" nowrap><%=sTotUnt1Yr%></td>
                     <td class="DataTable" nowrap><%=sTotUnt2Yr%></td>

                     <th class="DataTable">&nbsp;</th>
                     <td class="DataTable" nowrap><%=sTotMupAll%>%</td>
                     <td class="DataTable" nowrap><%=sTotMup1Yr%>%</td>
                     <td class="DataTable" nowrap><%=sTotMup2Yr%>%</td>
                </tr>
                <tr class="Divider"><td colspan=10>&nbsp;</td>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
  </table>

    <%
     long lEndTime = (new Date()).getTime();
     long lElapse = (lEndTime - lStartTime) / 1000;
     if (lElapse==0) lElapse = 1;
    %>
   <p style="text-align:left;font-size:10px; font-weigth:bold;"><%=lElapse%> sec.</td>
 </body>
</html>
