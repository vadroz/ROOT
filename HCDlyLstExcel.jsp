<%@ page import="salesvelocity.HCDlyLst, rciutility.StoreSelect, rciutility.RunSQLStmt, rciutility.RtvStrGrp, java.sql.*, java.util.*, java.text.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");    
   String sStrOpt = request.getParameter("StrOpt");
   String sDatOpt = request.getParameter("DatOpt");
   String sMissOpt = request.getParameter("MissOpt");
   String sDatBrk = request.getParameter("DatBrk");   
   String sSort = request.getParameter("Sort");
   String [] sSelCol = request.getParameterValues("col");
   String [] sSelGrp = request.getParameterValues("grp");
   String [] sGoal = request.getParameterValues("Goal");
   String sPrint = request.getParameter("print");

   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");
   
   if(sFrom == null)
   {
      java.util.Date dtPrior  = new java.util.Date(new java.util.Date().getTime() - 24 * 60 * 60 * 1000);
      sFrom = smp.format(dtPrior);
   }
   if(sTo == null)
   {
	   java.util.Date dtPrior  = new java.util.Date(new java.util.Date().getTime() - 24 * 60 * 60 * 1000);
      sTo = smp.format(dtPrior);
   }
   if(sStrOpt == null){ sStrOpt = "STR"; }
   if(sDatOpt == null){ sDatOpt = "NONE"; }
   if(sDatBrk == null){ sDatBrk = "None"; }
   if(sMissOpt == null){ sMissOpt = "Y"; }
   if(sSort == null){ sSort = "STR"; }
   if(sGoal == null){ sGoal= new String[3]; sGoal[0] = "10"; sGoal[1] = "10"; sGoal[2] = "10";}
   if(sSelCol == null)
   { 
	   sSelCol = new String[8];
	   for(int i=0; i < 8; i++){ sSelCol[i] = Integer.toString(i); }		   
   }
   if(sSelGrp == null)
   { 
	   sSelGrp = new String[3];
	   for(int i=0; i < 3; i++){ sSelGrp[i] = Integer.toString(i); }		   
   }
      
   boolean bGoalHdr = false;
   for(int i=0; i < sSelGrp.length; i++){ if(sSelGrp[i] == "3"){bGoalHdr = true;}  }
   
   if(sPrint == null || sPrint.equals("")){sPrint = "N"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=HCDlyLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   StoreSelect strsel = new StoreSelect();
   String sStrJsa = strsel.getStrNum();
   String sStrNameJsa = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   String sStrRegJsa = strsel.getStrReg();

   String [] sStrDistLst = strsel.getStrDistLst();
   String sStrDistJsa = strsel.getStrDist();
   String [] sStrDistNmLst = strsel.getStrDistNmLst();
   String sStrDistNmJsa = strsel.getStrDistNm();

   String [] sStrMallLst = strsel.getStrMallLst();
   String sStrMallJsa = strsel.getStrMall();

   int iSpace = 6;

   if(sSelStr ==null)
   {
      Vector vStr = new Vector();
      for(int i=0; i < iNumOfStr; i++)
      {
         if(!sStrLst[i].equals("55") && !sStrLst[i].equals("89")
            && !sStrLst[i].equals("70")	 && !sStrLst[i].equals("75")		 )
         {
           vStr.add(sStrLst[i]);
         }
      }

      sSelStr = (String [])vStr.toArray(new String[vStr.size()]);;
   }

   String sUser = session.getAttribute("USER").toString();
   boolean bUpdStrGrp = session.getAttribute("ITMAINT") != null;
   
 

   //System.out.println(sFrom + "|" + sTo + "|" + sStrOpt + "|" + sDatOpt + "|" + sSort + "|" + sUser);
   HCDlyLst hcdly = new HCDlyLst(sSelStr, sFrom, sTo, sMissOpt, sDatBrk, sGoal, sSort, sUser);
   int iNumOfDtl = hcdly.getNumOfStr();
   int iNumOfReg = hcdly.getNumOfReg();
   int iNumOfGrp = hcdly.getNumOfGrp();
   int iNumOfPer = hcdly.getNumOfPer();
   String [] sPer = hcdly.getPer();
   String sPerJva = hcdly.cvtToJavaScriptArray(sPer);
   String sSelColJsa = hcdly.cvtToJavaScriptArray(sSelCol);
   String sSelGrpJsa = hcdly.cvtToJavaScriptArray(sSelGrp);
   String sGoalJsa = hcdly.cvtToJavaScriptArray(sGoal);
   
   RtvStrGrp rtvstr = new RtvStrGrp();
   String sGrpNmJsa = rtvstr.getGrpJsa();
   String sGrpBtnJsa = rtvstr.getGrpBtnJsa();
   String sGrpStrJsa = rtvstr.getStrJsa();  
   
   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   String sCurDate = sdf.format(dCurDate);

   String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
     + " where pida='" + sCurDate + "'";
   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   runsql.readNextRecord();
   String sYear = runsql.getData("pyr#");
   String sMonth = runsql.getData("pmo#");
   String sMnend = runsql.getData("pime");
   runsql.disconnect();
   runsql = null;
   
%>
<html>
<head>
<title>Conversion</title>

<style>body {background:ivory;text-align:center; }
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { background:#FFE4C4;text-align:center;}

        th.DataTable  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:14px }


        tr.DataTable  { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#E1F5A9; font-family:Arial; font-size:10px }        
        tr.DataTable2  { background:gray; color:white; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#F6CEF5; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#F3E2A9; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:#EFFBEF; font-family:Arial; font-size:10px }
        tr.DataTable6 { background:#D8CEF6; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}

        td.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable4 { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        .Small {font-size:10px }
        .Small1 {font-size:10px; text-align:center;}
        .Medium {font-size:12px }
        .Medium1 {font-size:12px; font-weight:bold; }
        select.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.dvGraph { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:20;
              text-align:center; vertical-align:top; font-size:10px}      

       div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:1;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
        td.Prompt4 { text-align:left; vertical-align:middle; font-family:Arial; font-size:10px; }
        
        td.Separator01 { border-top: #EFFBEF ridge 2px; font-size:1px; }
        td.Separator02 { background: salmon ridge px; font-size:1px; }
</style>
<SCRIPT>

//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
}
</SCRIPT>


<table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
        <thead>
        <tr style="z-index: 60; position: relative; left: -1; 
             <%if(!sPrint.equals("Y")){%>top: expression(this.offsetParent.scrollTop-2);<%}%>">
          <th class="DataTable1" style="border-right:none" colspan=45>
            <b>Retail Concepts, Inc
            <br>Performance vs. Opportunity
            <br>Stores:
               <%String sComa = "";%>
               <%for(int i=0; i < sSelStr.length;i++){%>
                  <%if(i > 0 && i%20 == 0){%><br><%}%>
                  <%=sComa%><%=sSelStr[i]%>
                  <%sComa = ", ";%>
               <%}%>

              <br><%if(sFrom.equals("WTD")){%>Week-To-Date<%}
                    else if(sFrom.equals("MTD")){%>Month-To-Date<%}
                    else if(sFrom.equals("QTD")){%>Quater-To-Date<%}
                    else if(sFrom.equals("YTD")){%>Year-To-Date<%}
                    else if(sFrom.equals("PMN")){%>Prior Month<%}                    
                    else {%>
                       From: <span id="spnFrHdr"><%=sFrom%></span> &nbsp;&nbsp;&nbsp;&nbsp;
                       To: <span id="spnToHdr"><%=sTo%></span> &nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
            </b>            
        </tr>


        <tr style="z-index: 60; position: relative; left: -1; 
            <%if(!sPrint.equals("Y")){%>top: expression(this.offsetParent.scrollTop-2);<%}%>">
          <th class="DataTable">Str</th>
          <th class="DataTable">Date</th>

          <th class="DataTable" id="col0h0" colspan=4>(A)<br>Traffic<br><%if(bGoalHdr){ %>Goal as % of LY: <%=sGoal[0]%>%<%}%></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col1h0" colspan=4>Conversion<br>Rate<%if(bGoalHdr){ %><br>Goal as % of LY: <%=sGoal[1]%>%<%}%></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col2h0" colspan=4>Transactions</th>          
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col3h0" colspan=4>Average Sales<br>Price<%if(bGoalHdr){ %><br>Goal as % of LY: <%=sGoal[2]%>%<%}%></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col4h0" colspan=4>Total Sales</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col5h0" colspan=4>Returns</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col6h0" colspan=4>(B)<br>Net Sales</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col7h0">(B) - (A)<br>Performance<br>vs.<br>Opportunity</th>
        </tr>

        <tr>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col0hs">TY</th>
          <th class="DataTable" id="col0hs">LY</th>
          <th class="DataTable" id="col0hs">Var</th>
          <th class="DataTable" id="col0hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col1hs">TY</th>
          <th class="DataTable" id="col1hs">LY</th>
          <th class="DataTable" id="col1hs">Var</th>
          <th class="DataTable" id="col1hs">Goal</th>          
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col2hs">TY</th>
          <th class="DataTable" id="col2hs">LY</th>
          <th class="DataTable" id="col2hs">Var</th>
          <th class="DataTable" id="col2hs">Goal</th>          
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col3hs">TY</th>
          <th class="DataTable" id="col3hs">LY</th>
          <th class="DataTable" id="col3hs">Var</th>
          <th class="DataTable" id="col3hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col4hs">TY</th>
          <th class="DataTable" id="col4hs">LY</th>
          <th class="DataTable" id="col4hs">Var</th>
          <th class="DataTable" id="col4hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col5hs">TY</th>
          <th class="DataTable" id="col5hs">LY</th>
          <th class="DataTable" id="col5hs">Var</th>
          <th class="DataTable" id="col5hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col6hs">TY</th>
          <th class="DataTable" id="col6hs">LY</th>
          <th class="DataTable" id="col6hs">Var</th>
          <th class="DataTable" id="col6hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col7hs">Var</th>
        </tr>

        </thead>
<!------------------------------- Detail --------------------------------->
           <%int iLine=0;%>           
           <%for(int i=0; i < iNumOfDtl; i++) {
        	  hcdly.setHeadCounts();              
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              String sMissed = hcdly.getMissed();   
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>
              <%if(!sDatBrk.equals("None")){%>
                  <tr class="DataTable"><td class="Separator02" colspan=38>&nbsp;</td></tr>
              <%}%>
              <tr id="trId<%=iLine%>" class="DataTable<%if(sTyTraf.equals("0") || sLyTraf.equals("0")){%>2<%} else if(sMissed.equals("Y")){%>3<%}%>">
                <td class="DataTable"><%=sStr%> <%if(iNumOfPer > 0){%>(G)<%}%></td>
                <td class="DataTable">&nbsp;</td>
                
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0" nowrap><%=sTyTrans %></td>
                <td class="DataTable" id="col2d1" nowrap><%=sLyTrans %></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3" nowrap><%=sGlTrans %></td>
                
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0" nowrap>$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1" nowrap>$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3" nowrap>$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0" nowrap>$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1" nowrap>$<%=sLyTotSls%></td>                
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3" nowrap>$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0" nowrap>$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1" nowrap>$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3" nowrap>$<%=sGlTotRet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col6d0" nowrap>$<%=sTyTotNet%></td>
                <td class="DataTable" id="col6d1" nowrap>$<%=sLyTotNet%></td>
                <td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable" id="col6d3" nowrap>$<%=sGlTotNet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt %>%</td>                
                <!-- ============== Detail Period Breaks ====================================-->                
                <%
                for(int j = 0; j < iNumOfPer; j++)
                {
             	   hcdly.setHdCntPer(sStr, j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    sMissed = hcdly.getMissed();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>
                    <tr id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" -->                
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    	        	    <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>        	        	
    	        	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>    	        	    
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>
                <%}%>
                <%iLine++;%>                
           <%}%>
           <!-- ============== Region Totals ====================================-->
           <%for(int i=0; i < iNumOfReg; i++) {               
              hcdly.setRegTot();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>              
              <tr id="trId<%=iLine%>" class="DataTable4">
                <td class="DataTable" nowrap>Dist <%=sStr%> <%if(iNumOfPer > 0){%>(G)<%}%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0"><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1"><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3"><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
                <td class="DataTable" id="col2d1"><%=sLyTrans%></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3"><%=sGlTrans%></td>                
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col6d0">$<%=sTyTotNet%></td>
                <td class="DataTable" id="col6d1">$<%=sLyTotNet%></td>
                <td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable" id="col6d3">$<%=sGlTotNet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>
                
                <!-- ============== Region Period Breaks ====================================-->
                <%                
                for(int j = 0; j < iNumOfPer; j++ )
                {
             	   hcdly.setRegPer(sStr, j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>                    
                    <tr id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" -->           
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
	        	        <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>        	        	
    	        	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>                	    
                <%}%>
                <%iLine++;%>
             <%}%>             
             
             <!-- ============== Group Totals ====================================-->
           <%for(int i=0; i < iNumOfGrp; i++) {               
              hcdly.setGrpTot();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>
              <tr id="trId<%=iLine%>" class="DataTable6">
                <td class="DataTable" nowrap><%=sStr%> <%if(iNumOfPer > 0){%>(G)<%}%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0"><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1"><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3"><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
                <td class="DataTable" id="col2d1"><%=sLyTrans%></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3"><%=sGlTrans%></td>                
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col6d0">$<%=sTyTotNet%></td>
                <td class="DataTable" id="col6d1">$<%=sLyTotNet%></td>
                <td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable" id="col6d3">$<%=sGlTotNet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>
                
                <!-- ============== Group Period Breaks ====================================-->
                <%
                for(int j = 0; j < iNumOfPer; j++ )
                {
                   hcdly.setGrpPer(Integer.toString(i+1), j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>
                    <tr id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" --> 
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
	        	        <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>        	        	
    	        	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>    
                <%}%> 
                <%iLine++;%>                         
             <%}%>
             
           <!-- ============== Totals =======================================-->
           <%
              hcdly.setTotal();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>
              <tr  id="trId<%=iLine%>"  class="DataTable1">
                <td class="DataTable"><%=sStr%> <%if(iNumOfPer > 0){%>(G)<%}%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0"><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1"><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3"><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
                <td class="DataTable" id="col2d1"><%=sLyTrans%></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3"><%=sGlTrans%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col6d0">$<%=sTyTotNet%></td>
                <td class="DataTable" id="col6d1">$<%=sLyTotNet%></td>
                <td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable" id="col6d3">$<%=sGlTotNet%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>
                
                <!-- ============== Report Total Period Breaks ====================================-->
                <%
                for(int j = 0; j < iNumOfPer; j++ )
                {
             	   hcdly.setTotPer( j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>
                    <tr  id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" -->   
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    	        	    <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>
        	        	<th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable">&nbsp;</th>
                		<td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>    
                <%}%>                
      </table>
      <!----------------------- end of table ------------------------>
      <script type="text/javascript">AllLines = eval("<%=iLine%>");</script>
 </div>
 <span style="text-align:left;font-size:14px">
      Conversion statistics are updated daily at approximately 9:45 am.
 </span>
 <br><br>
 <span style="text-align:left;font-size:14px">
      <span style="background:gray; color:white;font-weight:bold">Stores</span> shaded in gray are not included in totals.
 </span>
 <br>
 <span style="text-align:left;font-size:14px">
      <span style="background:#F6CEF5; font-weight:bold">Stores</span> shaded in pink are not completely included in totals.
 </span>
 <br>
 <span style="text-align:left;font-size:14px">
 PvO is calculated on the traffic variance column vs. the net sales variance column.
 </span> 
 </body>
</html>
<%
  hcdly.disconnect();
  hcdly = null;
}
%>