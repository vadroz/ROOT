<%@ page import="java.util.*, java.sql.*, rciutility.RunSQLStmt"%>
<%
   String sStr = request.getParameter("Str");
   String sEmp = request.getParameter("Emp");
   String sWkend = request.getParameter("Wkend");

   if(sStr==null){ sStr = "ALL"; }

   String sAppl = "PAYROLL";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
{
     response.sendRedirect("SignOn1.jsp?TARGET=StrEmpCommDtl.jsp&" + request.getQueryString());
}
else
{
      String sStore = "";
      String sPosRet = "";
      String sPosComm = "";
      String sNegRet = "";
      String sNegComm = "";
      String sTotRet = "";
      String sTotComm = "";
      
      String sComa = "";

      String sDate = "", sSku = "", sReg = "", sTran = "", sTos = "", sDesc = "";

      ResultSet rs = null;
      RunSQLStmt runsql = null;


      if(sStr.equals("ALL"))
      {
    	  String sPrepStmt = "with sumf as ("
    		+ "select 'N' as slsret, SCIST as str, sum(SCRET) as ret, sum(sCAMNT) as comm"
    	    + " from rci.ScomHst" 
    	  	+ " where SCSCEM = " + sEmp
    	    + " and SCWEI ='" + sWkend + "'"
    	    + " and  scret < 0"
    	    + " group by SCIST "
    	    	    
    	    + " union"
    	    
    	    + " select 'Y' as slsret, SCIST as str, sum(SCRET) as ret, sum(sCAMNT) as comm"
        	+ " from rci.ScomHst" 
  	        + " where SCSCEM = " + sEmp
    	    + " and SCWEI ='" + sWkend + "'"
    	    + " and  scret > 0"
    	    + " group by SCIST "
    	    
    	    + " union"   
    	    
    	    + " select 'N' as slsret, RCIST as str, sum(RCRET) as ret, sum(RCAMNT) as comm"
        	+ " from rci.RcomHst" 
  	        + " where Rcemp = " + sEmp
    	    + " and RCWEI ='" + sWkend + "'"
    	    + " and RCRET < 0"
    	    + " group by RCIST "
    	    
    	    + " union"   
    	    	
			+ " select 'Y' as slsret, RCIST as str, sum(RCRET) as ret, sum(RCAMNT) as comm"
			+ " from rci.RcomHst" 
  			+ " where Rcemp = " + sEmp
			+ " and RCWEI ='" + sWkend + "'"
			+ " and RCRET > 0"
			+ " group by RCIST "
    	    
    	    + ")"
    	    
    	    + " select str"
    	    + ", (select sum(ret) as ret from sumf b where a.str=b.str and slsret = 'Y' ) as posret"  
    	    + ", (select sum(comm) as ret from sumf b where a.str=b.str and slsret = 'Y' ) as poscomm" 
    	    + ", (select sum(ret) as ret from sumf b where a.str=b.str and slsret = 'N' ) as negret" 
    	    + ", (select sum(comm) as ret from sumf b where a.str=b.str and slsret = 'N' ) as negcomm"  
    	    + ", (select sum(ret) as ret from sumf b where a.str=b.str ) as totret"  
    	    + ", (select sum(comm) as ret from sumf b where a.str=b.str) as totcomm "
    	    + " from sumf a"
    	    + " group by str" 
    	    + " order by str"
    	    ;
    	  
           System.out.println(sPrepStmt);

           runsql = new RunSQLStmt();
           runsql.setPrepStmt(sPrepStmt);
           rs = runsql.runQuery();
           while(runsql.readNextRecord())
           {
             String sQStr = runsql.getData("str");
             sStore += sComa + "\"" + sQStr + "\"";

             String sVal = runsql.getData("posret");
             if (sVal == null){ sVal = "0"; }             
             sPosRet += sComa + "\"" + sVal + "\"";
             
             sVal = runsql.getData("posComm");
             if (sVal == null){ sVal = "0"; }             
             sPosComm += sComa + "\"" + sVal + "\"";
             
             sVal = runsql.getData("negret");
             if (sVal == null){ sVal = "0"; }             
             sNegRet += sComa + "\"" + sVal + "\"";
             
             
             sVal = runsql.getData("negcomm");
             if (sVal == null){ sVal = "0"; }             
             sNegComm += sComa + "\"" + sVal + "\"";             
             
             sVal = runsql.getData("totret");
             if (sVal == null){ sVal = "0"; }             
             sTotRet += sComa + "\"" + sVal + "\"";             
             
             sVal = runsql.getData("totret");
             if (sVal == null){ sVal = "0"; }             
             sTotComm += sComa + "\"" + sVal + "\"";
             
             
             sComa=",";
           }
      }
      else
      {
          String sPrepStmt = "select edai, eret, eqty, ESPC1#, ereg, eent, etos, ides"

           + " from rci.rcisacm inner join rci.fsyper on pida=edai"
           + " inner join rci.rciemp on eemp=erci"
           + " inner join iptsfil.ipithdr on espc1#=isku"

           + " where piwe = '" + sWkend + "' and eemp=" + sEmp
           + " and eist=" + sStr
           + " and (estore = eist or eret < 0 "
           + " or exists(select  1 from rci.prpsld where sdwken = pdte "
           + " and sdrci# = eemp and sdstr = eist and SDTOTH > 0))"
           + " order by edai";

           System.out.println(sPrepStmt);

           rs = null;
           runsql = new RunSQLStmt();
           runsql.setPrepStmt(sPrepStmt);
           rs = runsql.runQuery();

           while(runsql.readNextRecord())
           {
             sDate += sComa + "\"" + runsql.getData("edai") + "\"";
             sPosRet += sComa + "\"" + runsql.getData("eret") + "\"";
             sSku += sComa + "\"" + runsql.getData("ESPC1#") + "\"";
             sReg += sComa + "\"" + runsql.getData("ereg") + "\"";
             sTran += sComa + "\"" + runsql.getData("eent") + "\"";
             sTos += sComa + "\"" + runsql.getData("etos") + "\"";
             sDesc += sComa + "\"" + runsql.getData("ides") + "\"";
             sComa=",";
           }
      }
 %>

<SCRIPT language="JavaScript">
var Store = [<%=sStore%>];
var PosRet = [<%=sPosRet%>];
var PosComm = [<%=sPosComm%>];
var NegRet = [<%=sNegRet%>];
var NegComm = [<%=sNegComm%>];
var TotRet = [<%=sTotRet%>];
var TotComm = [<%=sTotComm%>];
var Date = [<%=sDate%>];
var Sku  = [<%=sSku%>];
var SelStr = "<%=sStr%>"
var Reg = [<%=sReg%>];
var Tran = [<%=sTran%>];
var Tos = [<%=sTos%>];
var Desc = [<%=sDesc%>];

if(SelStr == "ALL"){ parent.showEmpWkCommDtl(Store, PosRet, PosComm, NegRet, NegComm, TotRet, TotComm); }
else{ parent.showStrEmpWkCommDtl(SelStr, Date, PosRet, NegRet, Sku, Reg, Tran, Tos, Desc); }

</SCRIPT>
<%}%>




