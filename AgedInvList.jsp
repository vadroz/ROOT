<%@ page import="rciutility.RunSQLStmt, rciutility.FormatNumericValue, java.text.*, java.util.*, java.sql.ResultSet"%>
<%
     String sStr = request.getParameter("Str");
     String sSort = request.getParameter("Sort");
     if(sSort == null) { sSort = "idiv, idpt, icls, iven, isty, iclr, isiz"; }

     if(sStr.length() ==1){ sStr = "0" + sStr; }

     String query = "With self  as ("
      + "select idiv, idpt, digits(icls) as icls, digits(iven) as iven"
      + ", digits(isty) as isty, digits(iclr) as iclr, digits(isiz) as isiz, iret, ides"
      + ", dinv" + sStr + ", iret * dinv" + sStr + " as extret"
      + ",ivst"
      + ", case when (select max(ugtin) from iptsfil.IPUPCXF where iCls=uCls and iVen = uVen"
          + " and iSty = uSty and iClr = uClr and iSiz = uSiz"
          + " and substr(ugtin,1,1) <> '4' )  is not null  "
      + " then (select max(ugtin) from iptsfil.IPUPCXF where iCls=uCls and iVen = uVen"
          + " and iSty = uSty and iClr = uClr and iSiz = uSiz"
          + " and substr(ugtin,1,1) <> '4' )"
      + " else igtin end as upd"
      + ", isku"
      + ", vnam"
      + ", clrn"
      + ", snam"
      + " from iptsfil.IpIthdr inner join iptsfil.ipitdtl on icls=dcls and iven=dven"
      + " and isty=dsty and iclr=dclr and isiz=dsiz and drid=0"
      + " inner join iptsfil.IpMrVen on iven=vven"
      + " inner join iptsfil.IpColor on iclr=cclr"
      + " inner join iptsfil.IpSizes on isiz=ssiz"
      + " where"
      + " substr(digits(iret),10,2) in ('94', '96', '97'" 
      + ", '80' , '81', '82', '83', '84', '85', '86', '87', '88', '89')"
      + "  and dinv" + sStr + " > 0"
      + ")"
      + " select * from self"
      + " order by " + sSort
      //+ " fetch first 10 rows only"
      ;

      FormatNumericValue fmt = new FormatNumericValue();
%>
<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { background:#e7e7e7;text-align:center;}
        table.Prompt { border: gray groove 1px;}

        tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
        th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}


        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:cornsilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                        text-align:right;}
        td.DataTable1 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                        text-align:left;}
        td.DataTable2 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                        text-align:center;}

        .Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:2px; font-family:Arial; font-size:10px }
</style>

<html>


<body>
 <table border="0" width="100%" height="100%">
   <tr>
    <td ALIGN="center" VALIGN="TOP">
     <b>Retail Concepts, Inc
     <br>Store Clearance Inventory List
     <br>Store: <%=sStr%>
     <br>
     </b>


    <table class="DataTable" border="1" cellPadding="0" cellSpacing="0">
      <tr class="DataTable">
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=idiv, idpt, icls, iven, isty, iclr, isiz">Div</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=idpt, icls, iven, isty, iclr, isiz">Dpt</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=icls, iven, isty, iclr, isiz">Long Sku</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=isku">Short SKU</a></th>
        <th class="DataTable">UPC</th>
        <th class="DataTable">Color</th>
        <th class="DataTable">Size</th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=vnam">Vendor Name</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=ivst">Vendor<br>Style</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=ides">Description</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=iret desc">Ret</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=dinv<%=sStr%> desc">Qty</a></th>
        <th class="DataTable"><a href="AgedInvList.jsp?Str=<%=sStr%>&Sort=extret desc">Ext<br>Ret</a></th>
      </tr>
      <%
         RunSQLStmt rsql = new RunSQLStmt();
         rsql.setPrepStmt(query);
         rsql.runQuery();
         String sStrqty = "dinv" + sStr;

         while(rsql.readNextRecord()){
        	 String sExtRet = rsql.getData("extret");
        	 if(sExtRet == null){sExtRet = "0";}
         %>
           <tr class="DataTable1">
              <td class="DataTable"><%=rsql.getData("idiv")%></td>
              <td class="DataTable"><%=rsql.getData("idpt")%></td>
              <td class="DataTable1" nowrap>
                 <%=rsql.getData("icls")%>-<%=rsql.getData("iven")%>-<%=rsql.getData("isty")%>
                 -<%=rsql.getData("iclr")%>-<%=rsql.getData("isiz")%>
              </td>
              <td class="DataTable1"><%=rsql.getData("isku")%></td>
              <td class="DataTable1"><%=rsql.getData("upd")%></td>
              <td class="DataTable1"><%=rsql.getData("clrn")%></td>
              <td class="DataTable1"><%=rsql.getData("snam")%></td>
              <td class="DataTable1"><%=rsql.getData("vnam")%></td>
              <td class="DataTable1"><%=rsql.getData("ivst")%></td>
              <td class="DataTable1"><%=rsql.getData("ides")%></td>
              <td class="DataTable"><%=rsql.getData("iret")%></td>
              <td class="DataTable"><%=rsql.getData(sStrqty)%></td>
              <td class="DataTable"><%=fmt.getFormatedNum(sExtRet, "#,###,###.##")%></td>
           </tr>
         <%}%>
         <tr class="DataTable">
           <th class="DataTable" colspan=13>Division Totals</th>
         </tr>
      <%
         query = "select idiv, sum(dinv" + sStr + ") as qty, sum(iret * dinv" + sStr + ") as extret"
              + " from iptsfil.IpIthdr inner join iptsfil.ipitdtl on icls=dcls and iven=dven"
              + " and isty=dsty and iclr=dclr and isiz=dsiz and drid=0"
              + " where"
              + " substr(digits(iret),6,2) in ('94', '96', '97'" 
              + ", '80' , '81', '82', '83', '84', '85', '86', '87', '88', '89')"
              + "  and dinv" + sStr + " > 0"
              + " group by idiv"
              + " order by idiv"
            ;
         System.out.println(query);
         rsql = new RunSQLStmt();
         rsql.setPrepStmt(query);
         rsql.runQuery();
         while(rsql.readNextRecord()){
         %>
           <tr class="DataTable2">
              <td class="DataTable"><%=rsql.getData("idiv")%></td>
              <td class="DataTable" colspan="11">&nbsp;</td>
              <td class="DataTable"><%=fmt.getFormatedNum(rsql.getData("extret"), "#,###,###.##")%></td>
           </tr>
         <%}%>

         <tr class="DataTable">
           <th class="DataTable" colspan=13>Totals</th>
         </tr>
      <%
         query = "select sum(dinv" + sStr + ") as qty, sum(iret * dinv" + sStr + ") as extret"
              + " from iptsfil.IpIthdr inner join iptsfil.ipitdtl on icls=dcls and iven=dven"
              + " and isty=dsty and iclr=dclr and isiz=dsiz and drid=0"
              + " where"
              + " substr(digits(iret),6,2) in ('94', '96', '97'" 
              + ", '80' , '81', '82', '83', '84', '85', '86', '87', '88', '89')"
              + "  and dinv" + sStr + " > 0"
            ;
         System.out.println(query);
         rsql = new RunSQLStmt();
         rsql.setPrepStmt(query);
         rsql.runQuery();
         while(rsql.readNextRecord()){
        	 String sExtRet = rsql.getData("extret");
        	 if(sExtRet == null){sExtRet = "0";}
         %>
           <tr class="DataTable2">
              <td class="DataTable" colspan="12">&nbsp;</td>
              <td class="DataTable"><%=fmt.getFormatedNum(sExtRet, "#,###,###.##")%></td>
           </tr>
         <%}%>

    </table>
  </table>
 </body>
</html>
<%
rsql.disconnect();
rsql = null;
%>
<html>
<head>


