<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("Str");
   String sCont = request.getParameter("Cont");
   String sCust = request.getParameter("Cust");
   String sFirstNm = request.getParameter("FirstNm");
   String sMInit = request.getParameter("MInit");
   String sLastNm = request.getParameter("LastNm");
   
   // get departments, classes
   String sUser = session.getAttribute("USER").toString();

   String sStmt = "select ci.inv_id, i.srl_num, ides, snam"
	  + ", vnam, EIMODEL"
      + " from rci.reconti ci"
      + " inner join rci.reinv i on ci.inv_id = i.inv_id"
      + " left join iptsfil.IpItHdr ih on i.class = icls and i.vendor=iven and i.style = isty"
        + " and i.color=iclr and i.size = isiz "
      + " left join iptsfil.IpSizes on isiz=ssiz "
      + " left join iptsfil.IpMrVen on EIBRAND=vven"
      + " where ci.cust_id = " + sCust + " and ci.contract <> " + sCont        
      + " group by ci.inv_id, i.srl_num, ides, snam, vnam, EIMODEL";

  // System.out.println(sStmt);
   
   RunSQLStmt runsql = new RunSQLStmt();

   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   String sInvId = "";
   String sSrlNum = "";
   String sDesc = "";
   String sSizeNm = "";
   String sBrand = "";
   String sModel = "";
   String coma = "";

   while(runsql.readNextRecord())
   {
      sInvId += coma + "\"" + runsql.getData("inv_id").trim() + "\"";
      sSrlNum += coma + "\"" + runsql.getData("srl_num").trim() + "\"";
      sDesc += coma + "\"" + runsql.getData("ides").trim() + "\"";
      sSizeNm += coma + "\"" + runsql.getData("snam").trim() + "\"";
      sBrand += coma + "\"" + runsql.getData("vnam").trim() + "\"";
      sModel += coma + "\"" + runsql.getData("EIMODEL").trim() + "\"";
      coma = ",";
   }
%>

<SCRIPT language="JavaScript1.2">
  var Cust = "<%=sCust%>";
  var FirstNm = "<%=sFirstNm%>";
  var MInit = "<%=sMInit%>";
  var LastNm = "<%=sLastNm%>";
  var InvId = [<%=sInvId%>];
  var SrlNum = [<%=sSrlNum%>];
  var Desc = [<%=sDesc%>];
  var SizeNm = [<%=sSizeNm%>];
  var Brand = [<%=sBrand%>];
  var Model = [<%=sModel%>];

  parent.showUsedEquip(Cust, FirstNm, MInit, LastNm, InvId, SrlNum, Desc, SizeNm, Brand, Model);

</SCRIPT>













