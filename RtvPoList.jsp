<%@ page import="rciutility.RunSQLStmt, java.text.*, java.sql.*, java.util.*"%>
<%
   String sSelVen = request.getParameter("Ven");
   String sSelDiv = request.getParameter("Div");

   if(sSelVen == null){ sSelVen = "ALL"; }
   if(sSelDiv == null){ sSelDiv = "ALL"; }

   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat sdfMDY = new SimpleDateFormat("MM/dd/yyyy");

   String sPrepStmt = "select hono, hadi, hven, vnam, hdiv"

      + ", (select dec(sum(bstk70),9,2) from iptsfil.IpPoItm h left join iptsfil.IPBSDtl"
      + " on bcls=icls and bven=iven and bsty=isty and bclr=iclr"
      + " and bsiz=isiz and brid=0 where iono=hono) as bsr_70 "

      + " ,(Select  dec(sum(sqrm),9,2) from iptsfil.IpPoItm h inner join ipwmfil.IPStock d on d.scls = h.icls"
      + " and d.sven = h.iven and d.ssty = h.isty and d.sclr = h.iclr and d.ssiz = h.isiz "
      + " and (swhs = 1 or swhs = 70) and spnd='W' where h.iono=hono)  as in_stock"

      + " ,(Select  dec(sum(iret * (iqty - itqr)),9,2) from iptsfil.IpPoItm h where h.iono=hono) as total_retail"

      + " from iptsfil.ippohdr"
      + " inner join iptsfil.IpMrVen on hven=vven"
      + " where hcdi >= CURRENT DATE"
      + " and hsts <> 'C'"
      + " and exists(select 1 from iptsfil.IppoItm pi where iono=hono"
      + " and exists(select 1 from iptsfil.IpItHdr ih where pi.icls= ih.icls"
      + " and pi.iven=ih.iven and pi.isty=ih.isty and pi.iclr=ih.iclr"
      + " and pi.isiz=ih.isiz and iatt01 = 3))";

   if(!sSelVen.equals("ALL")) { sPrepStmt += " and hven = " + sSelVen; }
   if(!sSelDiv.equals("ALL")) { sPrepStmt += " and hdiv = " + sSelDiv; }

   sPrepStmt += " order by hadi, hven, hdiv";
   //System.out.println(sPrepStmt);

   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);

   ResultSet rs = runsql.runQuery();

   int iNumOfRec = 0;

   String sPoNum = "";
   String sAntDlvDt = "";
   String sVen = "";
   String sVenName = "";
   String sDiv = "";
   String sBsr70 = "";
   String sInStock = "";
   String sTotRet = "";

   String coma = "";
   while(runsql.readNextRecord())
   {
      sPoNum += coma + "\"" + runsql.getData("hono").trim() + "\"";
      sAntDlvDt += coma + "\"" +  sdfMDY.format(sdfISO.parse(runsql.getData("hadi"))).trim() + "\"";
      sVen += coma + "\"" +  runsql.getData("hven").trim() + "\"";

      String sv = runsql.getData("vnam").trim();
      if(sv.indexOf("#") > 0){ sv = sv.substring(0, sv.indexOf("#")); }
      sVenName += coma + "\"" + sv + "\"";

      sDiv += coma + "\"" +  runsql.getData("hdiv").trim() + "\"";

      String sRes = runsql.getData("bsr_70");
      if(sRes == null){ sRes = "0"; } else { sRes = sRes.trim(); }
      sBsr70 += coma + "\"" + sRes + "\"";

      sRes = runsql.getData("in_stock");
      if(sRes == null){ sRes = "0"; } else { sRes = sRes.trim(); }
      sInStock += coma + "\"" +  sRes + "\"";

      sRes = runsql.getData("total_retail");
      if(sRes == null){ sRes = "0"; } else { sRes = sRes.trim(); }
      sTotRet += coma + "\"" + sRes + "\"";

      coma = ",";
      iNumOfRec++;
   }

   runsql.disconnect();
   runsql = null;

%>

<script name="javascript1.2">
var PoNum = [<%=sPoNum%>];
var AntDlvDt = [<%=sAntDlvDt%>];
var Ven = [<%=sVen%>];
var VenName = [<%=sVenName%>];
var Div = [<%=sDiv%>];
var Bsr70 = [<%=sBsr70%>];
var InStock = [<%=sInStock%>];
var TotRet = [<%=sTotRet%>];

parent.showPoNum(PoNum, AntDlvDt, Ven, VenName, Div, Bsr70, InStock, TotRet);
</script>


