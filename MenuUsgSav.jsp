<%@ page import="rciutility.RunSQLStmt, java.util.*, java.text.*, java.sql.ResultSet"%>
<%
    String sUrl = request.getParameter("Url");
    String sMenu = request.getParameter("Menu");
    String sUser = request.getParameter("User");

    if(sMenu == null ){sMenu = " ";}
    if(sUser == null ){sUser = " ";}

    Calendar cal = Calendar.getInstance();
    //cal.add(Calendar.DATE, -1);
    Date date = cal.getTime();

    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat tf = new SimpleDateFormat("HH.mm.ss");
    String sUsgDate = df.format(date);
    String sUsgTime = tf.format(date);

    //System.out.print(sUsgDate + "  URL:" + sUrl + " User: " + sUser);

    if(sUrl != null){
       String sPrepStmt = "insert into rci.IMNUUSG values("
           + "'" + sUrl + "'" + ","
           + "'" + sUser + "'" + ", current date, current time, "
           + "'" + sMenu + "'"
        + ")";

      //System.out.println("\n" + sPrepStmt);

       ResultSet rslset = null;
       RunSQLStmt runsql = new RunSQLStmt();
       runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
       runsql.disconnect();
       runsql = null;
    }
%>

