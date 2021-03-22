  <%@ page import="worldcup.AgedInvContStr , java.util.*"%>
<%
    String sSort = request.getParameter("Sort");
    if(sSort == null){ sSort = "Grp@A"; }

    AgedInvContStr agegame = new AgedInvContStr(sSort);

    int iNumOfStr = agegame.getNumOfStr();

    // Contest totals
    String [] sContTotStr = agegame.getContTotStr();
    String [] sContTotAgeSls = agegame.getContTotAgeSls();
    String [] sContTotSlsPrc = agegame.getContTotSlsPrc();
    String [] sContTotAgePrc = agegame.getContTotAgePrc();
    String [] sContTotLyAgeSls = agegame.getContTotLyAgeSls();
    String [] sContTotStrSls = agegame.getContTotStrSls();
    String [] sContTotAgeInv = agegame.getContTotAgeInv();
    String [] sLeag = agegame.getLeag();

    agegame.disconnect();
    agegame = null;

    String [] sArrSort = new String[]{"Grp@D", "Grp@A","Str@D", "Str@A", "Sales@D", "Sales@A"
    , "AgedSls@D", "AgedSls@A",  "AgedInv@D", "AgedInv@A", "SlsPrc@D", "SlsPrc@A"
    , "AgedPrc@D", "AgedPrc@A"};
    String [] sArrOpacity = new String[sArrSort.length];
    int iSort = 0;
    for(int i=0; i < sArrSort.length; i++)
    {
       if(sArrSort[i].equals(sSort)){ iSort = i; sArrOpacity[i] = "";}
       else{ sArrOpacity[i]="filter:alpha(opacity=20);";}
    }


%>
<title>Clr Inv Sales-by Store</title>
<style>body {background:ivory; text-align:center; }
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center; font-size:10px;}
        table.Prompt { border: gray groove 1px;}

        tr.TblHdr { background:#FFE4C4; font-family:Verdanda; font-size:12px }
        th.DataTable { border: #ffffff outset 2px; background:lightgrey; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                        text-align:center;}

        th.DataTable1 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px; text-align:center;}

        tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:PaleTurquoise; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:cornsilk; font-size:1px}
        tr.DataTable5 { background:khaki; font-family:Arial; font-size:10px }
        tr.DataTable6 { background:#fdd017; font-family:Arial; font-size:10px }
        tr.DataTable7 { background:#cccfff; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                        text-align:right;}
        td.DataTable1 { padding-top:2px; padding-bottom:2px; padding-left:2px;
                       padding-right:2px;
                       text-align:left;}
        td.DataTable2 { padding-top:1px; padding-right:1px;}

        td.DataTable3 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable31 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable312 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center; }
        td.DataTable313 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}

        td.DataTable32 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center; }

        td.DataTable4 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable404 { background:#fdd017; color:green; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable405 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}

        td.DataTable41 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable413 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable414 { background:#fdd017; color:green; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable415 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}

        td.DataTable6 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;}

        td.DataTable7 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable71 { color: red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable712 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable713 {  color: red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        td.DataTable714 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       text-align:center;}
        .Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:2px; font-family:Arial; font-size:10px }

</style>

<SCRIPT language="JavaScript1.2">
</SCRIPT>


<body>
  <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Clearance Inventory Sales - by Store</b>
      <br><span style="font-size:11px;">(Current Price Ending in: 94-97, or 80-89)
      <br>Accumulative Sales - Fiscal YTD</span>
      

     <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      </td>
   </tr>
   <tr>
      <td ALIGN="center" VALIGN="TOP">

   <table border=1 class='DataTable' cellPadding='0' cellSpacing='0'>
      <tr class='TblHdr'>
        <td class='DataTable3' colspan=19>Total Contest Result &nbsp;</td>
      </tr>
      <tr class='TblHdr'>
         <!--  th class='DataTable1' rowspan=2>Standings</th -->
         <th class='DataTable1'>Group</th>
         <th class='DataTable1'>Store</th>
         <th class='DataTable1' id='TotAge'>Total<br>Sales</th>
         <th class='DataTable1' id='TotAge'>Clearance<br>Sales</th>
         <th class='DataTable1' id='TotAge'>Starting<br>Clearance<br>Inv $</th>
         <th class='DataTable1' id='TotAge'>Clearance to Total<br>Sales&nbsp;%</th>
         <th class='DataTable1' id='TotAge'>Clearance Sls %</th>
      </tr>

      <%int iOpac=0;%>
      <tr class='TblHdr'>
         <th class='DataTable'>
            <a href="AgedInvContStr.jsp?Sort=Grp@D"><img src="arrowDown.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Descending"></a>
            &nbsp; &nbsp;
            <a href="AgedInvContStr.jsp?Sort=Grp@A"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Ascending"></a>
         </th>
         <th class='DataTable'>
            <a href="AgedInvContStr.jsp?Sort=Str@D"><img src="arrowDown.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Descending"></a>
            &nbsp; &nbsp;
            <a href="AgedInvContStr.jsp?Sort=Str@A"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Ascending"></a>
         </th>
         <th class='DataTable' id='TotAge'>
            <a href="AgedInvContStr.jsp?Sort=Sales@D"><img src="arrowDown.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Descending"></a>
            &nbsp; &nbsp;
            <a href="AgedInvContStr.jsp?Sort=Sales@A"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Ascending"></a>
         </th>
         <th class='DataTable' id='TotAge'>
            <a href="AgedInvContStr.jsp?Sort=AgedSls@D"><img src="arrowDown.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Descending"></a>
            &nbsp; &nbsp;
            <a href="AgedInvContStr.jsp?Sort=AgedSls@A"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Ascending"></a>
         </th>
         <th class='DataTable' id='TotAge'>
            <a href="AgedInvContStr.jsp?Sort=AgedInv@D"><img src="arrowDown.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Descending"></a>
            &nbsp; &nbsp;
            <a href="AgedInvContStr.jsp?Sort=AgedInv@A"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Ascending"></a>
         </th>
         <th class='DataTable' id='TotAge'>
            <a href="AgedInvContStr.jsp?Sort=SlsPrc@D"><img src="arrowDown.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Descending"></a>
            &nbsp; &nbsp;
            <a href="AgedInvContStr.jsp?Sort=SlsPrc@A"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Ascending"></a>
         </th>
         <th class='DataTable' id='TotAge'>
            <a href="AgedInvContStr.jsp?Sort=AgedPrc@D"><img src="arrowDown.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Descending"></a>
            &nbsp; &nbsp;
            <a href="AgedInvContStr.jsp?Sort=AgedPrc@A"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;<%=sArrOpacity[iOpac++]%>"  alt="Ascending"></a>
         </th>
      </tr>

   <!-- store details -->
   <%for(int i=0, j=1; i < iNumOfStr; i++, j++ ){%>
      <%if(sContTotStr[i].equals("Total")) {%><tr class='DataTable5'><%}
      else {%><tr class='DataTable'><%}%>

         <!-- td class='DataTable4'>
            <%if(!sContTotStr[i].equals("Total") && sContTotStr[i].indexOf("Grp") < 0) {%> <%=j%><%} else {%>&nbsp;<%}%>
         </td -->

         <td class='DataTable4' nowrap>&nbsp;<%=sLeag[i]%></td>
         <td class='DataTable4' nowrap><%=sContTotStr[i]%></td>
         <td class='DataTable4' id='TotAge'>$<%=sContTotStrSls[i]%></td>
         <td class='DataTable4' id='TotAge'>$<%=sContTotAgeSls[i]%></td>

         <%if(!sContTotStr[i].equals("Total") && sContTotStr[i].indexOf("Grp") < 0) {%>
            <td class='DataTable4' id='TotAge'>
               <a href='AgedInvList.jsp?Str=<%=sContTotStr[i]%>' target='_blank'>$<%=sContTotAgeInv[i]%></a>
            </td>
         <%} else {%><td class='DataTable4' id='TotAge'>$<%=sContTotAgeInv[i]%></td><%}%>

         <td class='DataTable4' id='TotAge'><%=sContTotSlsPrc[i]%>%</td>
         <td class='DataTable4' id='TotAge'><%=sContTotAgePrc[i]%>%</td>
      </tr>

      <%if(sContTotStr[i].indexOf("Grp") >= 0){%>
         <tr style='background:green;font-size:1px;'><td colspan=12>&nbsp;</td></tr>
        <%j = 0;%>
      <%}%>
   <%}%>
   </table>
  </tr>
 </table>
</body>











