<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
  String sStr = request.getParameter("Str");
  String sCode = request.getParameter("Code");
  String sYear = request.getParameter("Year");
  String sFrDate = request.getParameter("FrDate");
  String sToDate = request.getParameter("ToDate");
  String sSort = request.getParameter("Sort");
  String sInclDiv = request.getParameter("InclDiv");
  String sBogo = request.getParameter("Bogo");
  String sInclCode = request.getParameter("InclCode");
  String sCust = request.getParameter("Cust");
  
//----------------------------------
// Application Authorization
//----------------------------------

if (session.getAttribute("USER")!=null)
{
   String sUser = session.getAttribute("USER").toString();
   
   String sStmt = "";
   RunSQLStmt runsql = null;
   String sRet = "";
   String sDisc = "";
   String sGm$ = "";
   String sCoup= "";
   String sCoupNm= "";
   
   if(!sStr.equals("70"))
   {
	   sStmt = "select ecoup" 
       + ", case when ecoup > 0 then (select anam from rci.AdvCode where acod=ecoup)" 
	   + " else 'No Marketing Code' end as coupNm"
       + ", sum(eret) as eret, sum(edisc) as edisc, sum(eret - ecst) as gm$"
       + " from Rci.RciSacm" 
       + " inner join IpTsFil.IpItHdr on ecls=icls and even=iven and esty=isty and eclr=iclr" 
       + " and esiz=isiz" 
       + " where edai>='" + sFrDate + "'" 
       + " and edai <= '" + sToDate + "'" 
       + " and edisc <> 0 ";
       
       if(!sCode.equals("07") && !sCode.equals("EMP")){ sStmt += " and edsc = " + sCode + " and ecoup <> 1080";  }
       else if(!sCode.equals("EMP")) { sStmt += " and (edsc=7 or ecoup = 1080)";  }
       
       //exclude employee purchases
       if(!sCode.equals("EMP")){ sStmt += " and etos not in ('080', '80')";  }
       else{ sStmt += " and etos in ('080', '80')";  }
       
       if(!sInclDiv.equals("Y")){ sStmt += " and idiv not in (95,96,97,98)"; }
       
       // include/exclude BOGO
       if(sBogo.equals("1"))
       { 
    	   sStmt += " and (edsc not in (2,12) " 
           + "or edsc in (2,12) and abs(eret) <> abs(edisc))"; 
       }
       else if(sBogo.equals("3"))
       { 
    	   sStmt += " and edsc in (2,12) and abs(eret) = abs(edisc) "; 
       }
       
    // include/exclude Marketing Code
       if(sInclCode.equals("2"))
       { 
    	   sStmt += " and ecoup > 0"; 
       }
       else if(sInclCode.equals("3"))
       { 
    	   sStmt += " and ecoup = 0"; 
       }
       
       // include/exclude Store Walk-in custormer 
       if(sCust.equals("2"))
       { 
    	   sStmt += " and not exists(select 1 from IpStore where sspn <> ' ' and epcn = dec(sspn))"; 
       }
       else if(sCust.equals("3"))
       { 
    	   sStmt += " and exists(select 1 from IpStore where sspn <> ' ' and epcn = dec(sspn))"; 
       }
    	   
       sStmt += " and eist=" + sStr; 
       sStmt +=  " group by ecoup";
       
       if(sSort.equals("Coup")){ sStmt +=  " order by ecoup"; }
   	

   System.out.println("\n" + sStmt);
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   runsql.runQuery();
   
   Vector<String> vRet = new Vector<String>();
   Vector<String> vDisc = new Vector<String>();
   Vector<String> vGm$ = new Vector<String>();
   Vector<String> vCoup = new Vector<String>();
   Vector<String> vCoupNm = new Vector<String>();
   		
   while(runsql.readNextRecord())
   {
   		vRet.add(runsql.getData("eret").trim());
   		vDisc.add(runsql.getData("edisc"));
   		vGm$.add(runsql.getData("gm$"));
   		vCoup.add(runsql.getData("ecoup").trim());
   		vCoupNm.add(runsql.getData("coupNm").trim());
   }
   		
   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
   		sRet = srv.cvtToJavaScriptArray( vRet.toArray(new String[]{}) );
   		sDisc = srv.cvtToJavaScriptArray( vDisc.toArray(new String[]{}) );
   		sGm$ = srv.cvtToJavaScriptArray( vGm$.toArray(new String[]{}) );
   		sCoup = srv.cvtToJavaScriptArray( vCoup.toArray(new String[]{}) );
   		sCoupNm = srv.cvtToJavaScriptArray( vCoupNm.toArray(new String[]{}) );
   	}
     
   	    runsql.disconnect();
   	    runsql = null;   		
  
   
%>

<script name="javascript1.2">
var str = "<%=sStr%>";
var code = "<%=sCode%>";
var year = "<%=sYear%>";
var frdate = "<%=sFrDate%>";
var todate = "<%=sToDate%>";		

var ret = [<%=sRet%>];
var disc = [<%=sDisc%>];
var gm$ = [<%=sGm$%>];
var coup = [<%=sCoup%>];
var coupNm = [<%=sCoupNm%>];

parent.showCoup(str, code, year, frdate, todate, ret, disc, gm$, coup, coupNm ); 
</script>

<%}%>








