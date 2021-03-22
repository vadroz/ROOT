<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sLast = request.getParameter("Last");
   String sFirst = request.getParameter("First");
   String sPhone = request.getParameter("Phone");
   String sSearchEMail = request.getParameter("EMail");
   String sCont = request.getParameter("Cont");
   String sSearchCust = request.getParameter("Cust");   
   String sAction = request.getParameter("Action");   
   String sSrchZip = request.getParameter("Zip");
   String sSrchStr = request.getParameter("Str");
   
   if (sAction == null || sAction.equals("")){ sAction = "Search_Flex"; }
   if(sCont == null){ sCont = "";  }
   if(sSrchStr == null ){ sSrchStr = "ALL"; }
   
   System.out.println("Cont=" + sCont + " sAction=" + sAction);

   SimpleDateFormat smpDtIso = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat smpDtMdy = new SimpleDateFormat("MM/dd/yyyy");
   SimpleDateFormat smpTmIso = new SimpleDateFormat("HH:mm:ss");
   SimpleDateFormat smpTmUsa = new SimpleDateFormat("hh:mm a");
   SimpleDateFormat smpYear = new SimpleDateFormat("yyyy");

   String sStmt = "select CSCUST,CSFNAME,CSMINIT,CSLNAME,CSADDR1,CSADDR2,CSCITY ,CSSTATE,CSZIP"
     + ",CSEMAIL,CSHPHN,CSCPHN,CSGROUP,CSBIRTDT,CSHGTFT,CSHGTIN,CSWEIGHT,CSSHOSIZ,CSSKITY,CSSTANCE"
     + ",CSMNDSIZ,CSANGLFT,CSANGRGT,CSRECUS,CSRECDT,CSRECTM"
     + ", (select dec(sum(1),3,0) from rci.reconth where cscust=ctcust and ctsts='CANCELLED' and ctrecdt > current date - (365 * 2) days) as cnl"
     + ", (select dec(sum(1),3,0) from rci.reconth where cscust=ctcust and ctsts='OPEN' and ctrecdt > current date - (365 * 2) days) as opn"
     + ", (select dec(sum(1),3,0) from rci.reconth where cscust=ctcust and ctsts='READY' and ctrecdt > current date - (365 * 2) days) as rdy"
     + ", (select dec(sum(1),3,0) from rci.reconth where cscust=ctcust and ctsts='PICKEDUP' and ctrecdt > current date - (365 * 2) days) as pck"
     + ", (select dec(sum(1),3,0) from rci.reconth where cscust=ctcust and ctsts='RETURNED' and ctrecdt > current date - (365 * 2) days) as rtn"
     + ", CsUnrel"
     + ", CsIntl"
     + " from RCI.ReCustH h"
     + " where 1=1";

   
   
   // flexible search
   if(sAction.equals("Search_Only"))
   {
	   	sStmt += " and CSCUST=" + sSearchCust;
   } 
   // search  only main customer 
   else if(sAction.equals("Only_Payee"))
   {
	   sLast = sLast.replaceAll("'", "''"); 
	   sFirst = sFirst.replaceAll("'", "''"); 
	   
	   //sSrchZip
	   	if(!sLast.trim().equals("")){ sStmt +=  " and last_nm like('" + sLast +  "%')"; }
 	   	if(!sFirst.trim().equals("")){ sStmt += " and first_nm like('" + sFirst +  "%')";}
 	   	if(!sPhone.trim().equals(""))
 	   	{
    		sStmt += " and (home_phn like('%" + sPhone +  "%')"
           + " or cell_phn like('%" + sPhone +  "%'))";
 	   	}
 		if(!sCont.trim().equals(""))
 		{
     		sStmt += "exists(select 1 from Rci.ReContS s where s.contract = " + sCont + " and h.cscust = s.SKCUST)";
 		}

 		if(!sSearchEMail.trim().equals("")){ sStmt += " and email like('%" + sSearchEMail +  "%')"; }
 		
 		sStmt += " and exists(select 1 from rci.reconth where cscust=ctcust and ctsts = 'OPEN'" 
 		  + " and ctrecdt > current date - (365 * 2) days"
 		;
 		if(!sSrchStr.equals("ALL")){  sStmt += " and ctstr = " + sSrchStr;  }
 		sStmt += ")";
   }
   else if(sAction.equals("Get_Partner"))
   {
	   sStmt += " and ( exists( select 1 from rci.reconts a where a.skcont <> " + sCont 
	    + " and a.skcust = cscust"
		+ " and exists(select 1 from rci.reconts b where a.skcont=b.skcont " 
	    + " and b.skcust=" + sSearchCust + " and a.skcust <> b.skcust"
	    + ") )"
		+ " or exists(select 1 from RCI.ReCustH j where h.cscust=j.cscust " 
	    + " and j.csrecdt = current date" 
		+ " and exists(select 1 from RCI.ReCustH k where k.cscust=" + sSearchCust   
	    + " and k.cslname = j.cslname and k.csfname <> j.csfname ) )"
	    + ")"
	   ;
   }
   // search for customer info entry (stand alone). search as is 
   else
   {
	    sLast = sLast.replaceAll("'", "''"); 
	    sFirst = sFirst.replaceAll("'", "''"); 
	   
	    //sSrchZip
	   	if(!sLast.trim().equals("")){ sStmt +=  " and last_nm like('" + sLast +  "%')"; }
  	   	if(!sFirst.trim().equals("")){ sStmt += " and first_nm like('" + sFirst +  "%')";}
  	   	if(!sPhone.trim().equals(""))
  	   	{
     		sStmt += " and (home_phn like('%" + sPhone +  "%')"
            + " or cell_phn like('%" + sPhone +  "%'))";
  	   	}
  		if(!sCont.trim().equals(""))
  		{
      		sStmt += "exists(select 1 from Rci.ReContS s where s.contract = " + sCont + " and h.cscust = s.SKCUST)";
  		}

  		if(!sSearchEMail.trim().equals("")){ sStmt += " and email like('%" + sSearchEMail +  "%')"; }
  		
  		sStmt += " and ( exists(select 1 from rci.reconth where cscust=ctcust " 
  		 + " and ctrecdt > current date - (365 * 2) days)"
  		   + " or CSRECDT > current date - (365 * 2) days)"  		 
  		; 
   }
   
   sStmt += " order by last_nm, first_nm";

   System.out.println("Statement=\n" + sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   ResultSetMetaData rsmd = rs.getMetaData();

   int j=0;
   String sComa = "";

   String sCust = "";
   String sFirstNm = "";
   String sMInit = "";
   String sLastNm = "";
   String sAddr1 = "";
   String sAddr2 = "";
   String sCity = "";
   String sState = "";
   String sZip = "";
   String sEMail = "";
   String sHPhone = "";
   String sCPhone = "";
   String sGroup = "";
   String sBDate = "";
   String sHeightFt = "";
   String sHeightIn = "";
   String sWeight = "";
   String sShoeSiz = "";
   String sMondoSiz = "";
   String sAngleLeft = "";
   String sAngleRight = "";
   String sSkierTy = "";
   String sStance = "";
   String sRecUsr = "";
   String sRecDt = "";
   String sRecTm = "";
   String sCntOpn = "";
   String sCntRdy = "";
   String sCntCnl = "";
   String sCntPck = "";
   String sCntRtn = "";
   String sUnrel = "";
   String sIntl = "";
   
   boolean bFound = false; 

   while(runsql.readNextRecord())
   {
      sCust += sComa + "\"" + runsql.getData("cscust").trim() + "\"";
      sFirstNm += sComa + "\"" + runsql.getData("CSFNAME").trim() + "\"";
      sMInit += sComa + "\"" + runsql.getData("CSMINIT").trim() + "\"";
      sLastNm += sComa + "\"" + runsql.getData("CSLNAME").trim() + "\"";
      sAddr1 += sComa + "\"" + runsql.getData("CSADDR1").trim() + "\"";
      sAddr2 += sComa + "\"" + runsql.getData("CSADDR2").trim() + "\"";
      sCity += sComa + "\"" + runsql.getData("CsCity").trim() + "\"";
      sState += sComa + "\"" + runsql.getData("CsState").trim() + "\"";
      sZip += sComa + "\"" + runsql.getData("CsZip").trim() + "\"";
      sEMail += sComa + "\"" + runsql.getData("CsEMail").trim() + "\"";
      sHPhone += sComa + "\"" + runsql.getData("CsHPhn").trim() + "\"";
      sCPhone += sComa + "\"" + runsql.getData("CsCPhn").trim() + "\"";
      sGroup += sComa + "\"" + runsql.getData("CsGroup").trim() + "\"";

      // Calculate age
      int iBirthYear = Integer.parseInt(smpYear.format(smpDtIso.parse(runsql.getData("CSBIRTDT"))));
      int iCurrYear = Integer.parseInt(smpYear.format(new java.util.Date()));
      int iAge = iCurrYear - iBirthYear;
      sBDate += sComa + "\"" + Integer.toString(iAge) + "\"";

      sHeightFt += sComa + "\"" + runsql.getData("CSHGTFT").trim() + "\"";
      sHeightIn += sComa + "\"" + runsql.getData("CSHGTIn").trim() + "\"";
      sWeight += sComa + "\"" + runsql.getData("CsWeight").trim() + "\"";
      sShoeSiz += sComa + "\"" + runsql.getData("CsShoSiz").trim() + "\"";
      sSkierTy += sComa + "\"" + runsql.getData("CsSkiTy").trim() + "\"";
      sStance += sComa + "\"" + runsql.getData("CsStance").trim() + "\"";

      sMondoSiz += sComa + "\"" + runsql.getData("CsMndSiz").trim() + "\"";
      sAngleLeft += sComa + "\"" + runsql.getData("CsAnglft").trim() + "\"";
      sAngleRight += sComa + "\"" + runsql.getData("CsAngRgt").trim() + "\"";

      sRecUsr += sComa + "\"" + runsql.getData("CSRecUs").trim() + "\"";
      sRecDt += sComa + "\"" + smpDtMdy.format(smpDtIso.parse(runsql.getData("CsRecDt"))) + "\"";
      sRecTm += sComa + "\"" + smpTmUsa.format(smpTmIso.parse(runsql.getData("CsRecTm"))) + "\"";

      int cnt = rs.getInt("opn");
      sCntOpn += sComa + "\"" + cnt + "\"";
      
      cnt = rs.getInt("rdy");
      sCntRdy += sComa + "\"" + cnt + "\"";

      cnt = rs.getInt("cnl");
      sCntCnl += sComa + "\"" + cnt + "\"";

      cnt = rs.getInt("pck");
      sCntPck += sComa + "\"" + cnt + "\"";

      cnt = rs.getInt("rtn");
      sCntRtn += sComa + "\"" + cnt + "\"";
      
      sUnrel += sComa + "\"" + runsql.getData("CsUnrel").trim() + "\"";
      
      sIntl += sComa + "\"" + runsql.getData("CsIntl").trim() + "\"";
      
      sComa= ",";
      
      bFound = true; 
   }
%>

<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>";
var Cust = [<%=sCust%>];
var FirstNm = [<%=sFirstNm%>];
var MInit = [<%=sMInit%>];
var LastNm = [<%=sLastNm%>];
var Addr1 = [<%=sAddr1%>];
var Addr2 = [<%=sAddr2%>];
var City = [<%=sCity%>];
var State = [<%=sState%>];
var Zip = [<%=sZip%>];
var EMail = [<%=sEMail%>];
var HPhone = [<%=sHPhone%>];
var CPhone = [<%=sCPhone%>];
var Group = [<%=sGroup%>];
var BDate = [<%=sBDate%>];
var HeightFt = [<%=sHeightFt%>];
var HeightIn = [<%=sHeightIn%>];
var Weight = [<%=sWeight%>];
var ShoeSiz = [<%=sShoeSiz%>];
var SkierTy = [<%=sSkierTy%>];
var Stance = [<%=sStance%>];
var MondoSiz = [<%=sMondoSiz%>];
var AngleLeft = [<%=sAngleLeft%>];
var AngleRight = [<%=sAngleRight%>];
var RecUsr = [<%=sRecUsr%>];
var RecDt = [<%=sRecDt%>];
var RecTm = [<%=sRecTm%>];
var CntOpn  = [<%=sCntOpn%>];
var CntRdy  = [<%=sCntRdy%>];
var CntCnl = [<%=sCntCnl%>];
var CntPck = [<%=sCntPck%>];
var CntRtn = [<%=sCntRtn%>];
var Unrel = [<%=sUnrel%>];
var Intl = [<%=sIntl%>];
var Found = <%=bFound%>;

if(Action == "Search_Only")
{
    if(Found)
    {	
		parent.setCust(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
		, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
		, MondoSiz, AngleLeft, AngleRight, RecDt
		)
    }
	else
	{
		parent.setCustError()
	}
}
else if( Action == "Get_Partner")
{
	parent.showPartners(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
  	, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
  	,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntCnl, CntOpn, CntRdy, CntPck
  	, CntRtn, Unrel, Intl)
}
else
{
	parent.showCustLst(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
  	, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
  	,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntCnl, CntOpn, CntRdy, CntPck
  	, CntRtn, Unrel, Intl)
}
</SCRIPT>
Search parameters:<br>

Stmt: <%=sStmt%><br>

Last = <%=sLast%><br>
First = <%=sFirst%><br>
Phone = <%=sPhone%><br>
EMail = <%=sSearchEMail%><br>
Contract = <%=sCont%><br>









