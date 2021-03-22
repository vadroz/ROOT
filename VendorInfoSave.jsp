<%@ page import="rciutility.RunSQLStmt, java.util.*, java.text.*, java.sql.ResultSet"%>
<%
   String sVen = request.getParameter("Ven");
   String sClmInfo = request.getParameter("ClmInfo");
   String sClmEMail = request.getParameter("ClmEMail");
   String sMainPhn = request.getParameter("MainPhn");
   String sMainEMail = request.getParameter("MainEMail");
   String sAcct = request.getParameter("Acct");
   String sContName = request.getParameter("ContName");
   String sContPhn1 = request.getParameter("ContPhn1");
   String sContPhn2 = request.getParameter("ContPhn2");
   String sContEMail = request.getParameter("ContEMail");
   String sRepName = request.getParameter("RepName");
   String sRepPhn1 = request.getParameter("RepPhn1");
   String sRepPhn2 = request.getParameter("RepPhn2");
   String sRepEMail = request.getParameter("RepEMail");
   String sAction = request.getParameter("Action");
   
   if(sClmInfo == null){sClmInfo = " ";}
   if( sClmEMail== null){ sClmEMail = " ";}
   if(sMainPhn == null){sMainPhn = " ";}
   if(sMainEMail == null){sMainEMail = " ";}
   if(sAcct == null){sAcct = " ";}
   if(sContName == null){sContName = " ";}
   if(sContPhn1 == null){sContPhn1 = " ";}
   if(sContPhn2 == null){sContPhn2 = " ";}
   if(sContEMail == null){sContEMail = " ";}
   if(sRepName == null){sRepName = " ";}
   if(sRepPhn1 == null){sRepPhn1 = " ";}
   if(sRepPhn2 == null){sRepPhn2 = " ";}
   if(sRepEMail == null){sRepEMail = " ";}
   
//----------------------------------
// Application Authorization
//----------------------------------
String sUser = session.getAttribute("USER").toString();

if (session.getAttribute("USER")!=null)
{
        String sPrepStmt = "select 1 as result from rci.patvenp"
          + " where VpVen=" + sVen;

        boolean bError = false;

        RunSQLStmt runsql = new RunSQLStmt();
        ResultSet rslset = runsql.getResult();
        runsql.setPrepStmt(sPrepStmt);
        runsql.runQuery();

        if (runsql.readNextRecord())
        {
           sPrepStmt = "update rci.patvenp"
          + " set "
            + " VpAcct = '" + sAcct + "'"
            + ", VpClaim = '" + sClmInfo + "'"
            + ", VpEMail = '" + sClmEMail + "'"

            + ", VpMain1 = '" + sMainPhn + "'"
            + ", VpMEmail = '" + sMainEMail + "'"

            + ", VpCont = '" + sContName + "'"
            + ", VpCPhon1 = '" + sContPhn1 + "'"
            + ", VpCPhon2 = '" + sContPhn2 + "'"
            + ", VpCEMail = '" + sContEMail + "'"

            + ", VpRep = '" + sRepName + "'"
            + ", VpRPhon1 = '" + sRepPhn1 + "'"
            + ", VpRPhon2 = '" + sRepPhn2 + "'"
            + ", VpREMail = '" + sRepEMail + "'"

          + " where VpVen = " + sVen;
          System.out.println(sPrepStmt);
        }
        else
        {
           //System.out.println("Not Exists");
           //bError = true;
           
        	sPrepStmt = "insert into rci.patvenp"
        	          + " values("
        	            + sVen
        	            + ",(select vnam from IpTsFil.IpMrVen where vven =" + sVen +")"
        	            + ", '" + sAcct + "'"
        	            + ", '" + sClmInfo + "'"
        	            + ", '" + sClmEMail + "'"
        	            + ", ' '"

        	            + ", '" + sMainPhn + "'"
        	            + ", '" + sMainEMail + "'"

        	            + ", '" + sContName + "'"
        	            + ", '" + sContPhn1 + "'"
        	            + ", '" + sContPhn2 + "'"
        	            + ", '" + sContEMail + "'"

        	            + ", '" + sRepName + "'"
        	            + ", '" + sRepPhn1 + "'"
        	            + ", '" + sRepPhn2 + "'"
        	            + ", '" + sRepEMail + "'"
        	            
        	            + ", '" + sUser + "'"
        	            + ", current date"
        	            + ", current time"

        	          + ")";
        	          System.out.println(sPrepStmt);
        }

        runsql = new RunSQLStmt();
        int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        runsql.disconnect();

%>


<SCRIPT language="JavaScript1.2">

parent.showVenInfoUpd(<%=bError%>);

</SCRIPT>

<%
}
else {%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to get pictures.")
</SCRIPT>
<%}%>






