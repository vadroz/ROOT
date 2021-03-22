<%@ page import="rciutility.RunSQLStmt, java.sql.*, rental.RentDptClsList, rental.RentClsAvlList, java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("Str");
   String sCont = request.getParameter("Cont");
   String sCls = request.getParameter("Cls");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sGrp = request.getParameter("Grp");
   String sAction = request.getParameter("Action");
   String sSrlNum = request.getParameter("Sn");


   // get departments, classes
   String sUser = session.getAttribute("USER").toString();

   Vector vDpt = new Vector();
   Vector vDptNm = new Vector();
   String sDptJsa = null;
   String sDptNmJsa = null;
   String sClsJsa = null;
   String sClsNmJsa = null;
   String sInvId = "";

   // get items
   RentClsAvlList rentinv = null;
   int iNumOfDat = 0;
   String [] sDate = null;
   String [] sMonth = null;
   String [] sDay = null;
   String sVenJsa = null;
   String sStyJsa = null;
   String sClrJsa = null;
   String sSizJsa = null;
   String sSkuJsa = null;
   String sDescJsa = null;
   String sVenStyJsa = null;
   String sClrNmJsa = null;
   String sSizNmJsa = null;
   String sTotQtyJsa = null;
    
   

   if(sAction.equals("GET_DPT") || sAction.equals("GET_DPT_LEASE"))
   {
     String sStmtDpt = "select cdpt, dnam, count(*) as numofcls"
            + " from IpTsFil.IpClass inner join IpTsFil.IpDepts on ddpt=cdpt"
            + " where exists( select 1 from Rci.ReInv where ccls=eicls )";
     
     if(sGrp.equals("WATER")){ sStmtDpt += " and ddpt in (982)"; }
     else if(sAction.equals("GET_DPT_LEASE")){ sStmtDpt += " and ddpt in (968, 969, 973)"; }
     else { sStmtDpt += " and ddpt not in (968, 969, 973)"; }
     
     sStmtDpt += " group by cdpt, dnam"            
            + " order by cdpt";
     RunSQLStmt runsql = new RunSQLStmt();
     runsql.setPrepStmt(sStmtDpt);
     ResultSet rs = runsql.runQuery();

     while(runsql.readNextRecord())
     {
        vDpt.add(runsql.getData("cdpt").trim());
        vDptNm.add(runsql.getData("dnam"));
     }

     int iNumOfDpt = vDpt.size();
     String [] sSrchDpt = new String[iNumOfDpt];

     for(int i=0; i < iNumOfDpt; i++)
     {
        sSrchDpt[i] = (String)vDpt.get(i);
     }

     RentDptClsList rentdptcls = new RentDptClsList(sSrchDpt, "vrozen");

     sDptJsa = rentdptcls.getDptJsa();
     sDptNmJsa = rentdptcls.getDptNmJsa();
     sClsJsa = rentdptcls.getClsJsa();
     sClsNmJsa = rentdptcls.getClsNmJsa();

     rentdptcls.disconnect();
   }
   
   // get Items
   else if(sAction.equals("GET_ITEMS"))
   {
      rentinv = new RentClsAvlList(sCls, sStr, sFrDate, sToDate, sUser);
      iNumOfDat = rentinv.getNumOfDat();
      sDate = rentinv.getDate();
      sMonth = rentinv.getMonth();
      sDay = rentinv.getDay();

      rentinv.setItemsAsJsa();

      sClsJsa = rentinv.getClsJsa();
      sVenJsa = rentinv.getVenJsa();
      sStyJsa = rentinv.getStyJsa();
      sClrJsa = rentinv.getClrJsa();
      sSizJsa = rentinv.getSizJsa();
      sSkuJsa = rentinv.getSkuJsa();
      sDescJsa = rentinv.getDescJsa();
      sVenStyJsa = rentinv.getVenStyJsa();
      sClsNmJsa = rentinv.getClsNmJsa();
      sClrNmJsa = rentinv.getClrNmJsa();
      sSizNmJsa = rentinv.getSizNmJsa();
      sTotQtyJsa = rentinv.getTotQtyJsa();

      rentinv.disconnect();
   }
   else if(sAction.equals("CHK_SN"))
   {
     String sStmtDpt = "select EIINVID "
            + " from RCI.REINV"
            + " where EISRLN=" + sSrlNum;
     
     RunSQLStmt runsql = new RunSQLStmt();
     runsql.setPrepStmt(sStmtDpt);
     ResultSet rs = runsql.runQuery();

     if(runsql.readNextRecord())
     {
    	 sInvId  = runsql.getData("EIINVID").trim();
     }
   }
%>

<SCRIPT language="JavaScript1.2">
<%if(sAction.equals("GET_DPT") || sAction.equals("GET_DPT_LEASE")){%>
  var Dpt = [<%=sDptJsa%>];
  var DptNm = [<%=sDptNmJsa%>];
  var Cls = [<%=sClsJsa%>];
  var ClsNm = [<%=sClsNmJsa%>];

  parent.rcvAvailDptCls(Dpt, DptNm, Cls, ClsNm)


<%} else if(sAction.equals("GET_ITEMS")){%>
    var Cls = [<%=sClsJsa%>];
    var Ven = [<%=sVenJsa%>];
    var Sty = [<%=sStyJsa%>];
    var Clr = [<%=sClrJsa%>];
    var Siz = [<%=sSizJsa%>];
    var Desc = [<%=sDescJsa%>];
    var ClrNm = [<%=sClrNmJsa%>];
    var SizNm = [<%=sSizNmJsa%>];
    var TotQty = [<%=sTotQtyJsa%>];

    parent.rcvAvailItem(Cls, Ven, Sty, Clr, Siz, Desc, ClrNm, SizNm, TotQty)


<%} else if(sAction.equals("CHK_SN")){%>
    var invid = "<%=sInvId%>";
    var sn = "<%=sSrlNum%>";
    parent.setScanItem(invid, sn); 
<%}%>
}
</SCRIPT>













