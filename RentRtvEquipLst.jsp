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
   Vector vSport = new Vector();
   String sDptJsa = null;
   String sDptNmJsa = null;
   String sSportJsa = null;
   String sClsJsa = null;
   String sClsNmJsa = null;

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
   String sUnasgQtyJsa = null;
   String sInvId = "";
   String sDesc = "";
   String sSizNm = "";
   
   String sAssig_Cont = "";
   String sSnSts = "";
   String sSnClsNm = "";

   //System.out.println(sAction);
   
   if(sAction.equals("GET_DPT") || sAction.equals("GET_DPT_LEASE"))
   {
     String sStmtDpt = "select cdpt, dnam, count(*) as numofcls"
            + ", case when cdpt = 982  then 'Water'"
            + " when cdpt = 964  then 'Bike'"
            + " when cdpt in (968, 969, 973)  then 'Lease'"
            + " else 'Ski' end as Sport"
    		+ " from IpTsFil.IpClass inner join IpTsFil.IpDepts on ddpt=cdpt"
            + " where exists( select 1 from Rci.ReInv where ccls=eicls )";
     
     
     //if(sGrp.equals("WATER")){ sStmtDpt += " and ddpt in (982)"; }
     //if(sGrp.equals("BIKE")){ sStmtDpt += " and ddpt in (964)"; }
     //else if(sAction.equals("GET_DPT_LEASE")){ sStmtDpt += " and ddpt in (968, 969, 973)"; }
     //else { sStmtDpt += " and ddpt not in (964, 968, 969, 973, 982)"; }
     
     sStmtDpt += " group by cdpt, dnam"            
            + " order by sport, cdpt";
     
     //System.out.println(sStmtDpt);
     
     RunSQLStmt runsql = new RunSQLStmt();
     runsql.setPrepStmt(sStmtDpt);
     ResultSet rs = runsql.runQuery();

     while(runsql.readNextRecord())
     {
        vDpt.add(runsql.getData("cdpt").trim());
        vDptNm.add(runsql.getData("dnam"));
        vSport.add(runsql.getData("sport"));
     }

     int iNumOfDpt = vDpt.size();
     String [] sSrchDpt = new String[iNumOfDpt];
     String [] sSrchSport = new String[iNumOfDpt];

     for(int i=0; i < iNumOfDpt; i++)
     {
        sSrchDpt[i] = (String)vDpt.get(i);
        sSrchSport[i] = (String)vSport.get(i);
     }

     RentDptClsList rentdptcls = new RentDptClsList(sSrchDpt, "vrozen");

     sDptJsa = rentdptcls.getDptJsa();
     sDptNmJsa = rentdptcls.getDptNmJsa();
     sSportJsa = rentdptcls.cvtToJavaScriptArray(sSrchSport);
     sClsJsa = rentdptcls.getClsJsa();
     sClsNmJsa = rentdptcls.getClsNmJsa();

     rentdptcls.disconnect();
   }
   
   // get Items
   else if(sAction.equals("GET_ITEMS"))
   {
	  //System.out.println(sCls + "|" + sStr + "|" + sFrDate + "|" + sToDate + "|" + sUser);
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
      sUnasgQtyJsa = rentinv.getUnasgQtyJsa();

      rentinv.disconnect();
   }
   else if(sAction.startsWith("CHK_SN"))
   {
	   String sStmt = "select EIINVID, ides, snam, EiSts"
	     + ", case when (select Ivcont from rci.ReContI where ivinvid=eiinvid and ivscan='Y'" 
	     + " and exists(select 1 from rci.reconth where ivcont=ctcont" 
	     + " and ctsts in ( 'OPEN', 'READY', 'PICKEDUP'))"
	     + " fetch first 1 row only) is null " 
	     + " then 'N' " 
	     + " else  (select char(Ivcont) from rci.ReContI where ivinvid=eiinvid and ivscan='Y'" 
	     + " and exists(select 1 from rci.reconth where ivcont=ctcont" 
	     + " and ctsts in ( 'OPEN', 'READY', 'PICKEDUP'))"
	     + " fetch first 1 row only) " 
	     + " end as assig_Cont"  
	     + ", clnm "
	     + " from RCI.REINV"
	     + " inner join IpTsFil.IpItHDr on icls=eicls and iven=eiven and isty=eisty"               
	     + " and iclr=eiclr and isiz=eisiz"
	     + " inner join IpTsFil.IpSizes on ssiz=eisiz"
	     + " inner join IpTsFil.IpClass on ccls=eicls"
	     + " where EISRLN='" + sSrlNum + "'";
	     
	     System.out.println("\n" + sStmt);
	     
	     RunSQLStmt runsql = new RunSQLStmt();
	     runsql.setPrepStmt(sStmt);
	     ResultSet rs = runsql.runQuery();

	     if(runsql.readNextRecord())
	     {
	    	 sInvId  = runsql.getData("EIINVID").trim();
	    	 sDesc = runsql.getData("ides").trim();
	    	 sSizNm = runsql.getData("snam").trim();
	    	 sAssig_Cont = runsql.getData("assig_Cont");
             sSnSts = runsql.getData("eists").trim();
             sSnClsNm =  runsql.getData("clnm").trim();
	     }
	   }

%>

<SCRIPT language="JavaScript1.2">
<%if(sAction.equals("GET_DPT") || sAction.equals("GET_DPT_LEASE")){%>
  var Dpt = [<%=sDptJsa%>];
  var DptNm = [<%=sDptNmJsa%>];
  var Sport = [<%=sSportJsa%>];
  var Cls = [<%=sClsJsa%>];
  var ClsNm = [<%=sClsNmJsa%>];

  parent.rcvAvailDptCls(Dpt, DptNm, Cls, ClsNm, Sport)


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
    var UnasgQty = [<%=sUnasgQtyJsa%>];

    parent.rcvAvailItem(Cls, Ven, Sty, Clr, Siz, Desc, ClrNm, SizNm, TotQty, UnasgQty)


<%} else if(sAction.equals("CHK_SN_1")){%>
    var invid = "<%=sInvId%>";
    var sn = "<%=sSrlNum%>";
    var desc = "<%=sDesc%>";
    var siznm= "<%=sSizNm%>";
    var assig_Cont = "<%=sAssig_Cont%>"
    var sts = "<%=sSnSts%>";
    var snClsNm = "<%=sSnClsNm%>";
    parent.setScanItem(invid, sn, desc, siznm, assig_Cont,sts, snClsNm); 

<%} else if(sAction.equals("CHK_SN_2")){%>
    var invid = "<%=sInvId%>";
    var sn = "<%=sSrlNum%>";
    var desc = "<%=sDesc%>";
    var siznm= "<%=sSizNm%>";
    var assig_Cont = "<%=sAssig_Cont%>"
    var sts = "<%=sSnSts%>";
    var snClsNm = "<%=sSnClsNm%>";
    parent.vldSrlNum(invid, sn, desc, siznm, assig_Cont,sts, snClsNm); 
<%}
%>
</SCRIPT>