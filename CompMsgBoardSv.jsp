<%@ page import="rciutility.RunSQLStmt, java.text.*, java.util.*, java.sql.ResultSet"%>
<%
     String sAction = request.getParameter("Action");
     // message
     String sMbName = request.getParameter("MbName");
     String sMbText = request.getParameter("MbText");
     String sMbFont = request.getParameter("MbFont");
     String sMbColor = request.getParameter("MbColor");
     String sMbBgClr = request.getParameter("MbBgClr");
     // alarm
     String sMaStrNm = request.getParameter("MaStrNm");
     String sMaStpNm = request.getParameter("MaStpNm");
     String sMaMsgDa = request.getParameter("MaMsgDa");
     String sMaMsgTi = request.getParameter("MaMsgTi");
     String sMaStrTm = request.getParameter("MaStrTm");
     String sMaStpTm = request.getParameter("MaStpTm");

     System.out.println(sMaMsgDa + "|" + sMaMsgTi);
     if(sMaMsgDa == null || sMaMsgDa.trim().equals("")) { sMaMsgDa = "current date"; }
     else{ sMaMsgDa = "'" + sMaMsgDa + "'"; }
     if(sMaMsgTi == null || sMaMsgTi.trim().equals("")) { sMaMsgTi = "current time"; }
     else{ sMaMsgTi = "'" + sMaMsgTi + "'"; }
     System.out.println(sMaMsgDa + "|" + sMaMsgTi);

     //MaStrNm=CPDOWN&selStrMsg=CPDOWN&MaStpNm=&selStpMsg=NOT_SELECTED&MaMsgDa=&MaMsgTi=&MaStrTm=10&MaStpTm=0&Action=ADDALARM

     String query = null;

     if(sAction.equals("ADD"))
     {
        query = "insert into rci.MSGBOARD"
          + " values("
            + "'" + sMbName + "'"
            + ",'" + sMbText + "'"
            + "," + sMbFont
            + ",'" + sMbColor + "'"
            + ",'" + sMbBgClr + "'"
          + ")";
     }
     else if(sAction.equals("UPD"))
     {
        query = "update rci.MSGBOARD"
          + " set "
            + " Text = '" + sMbText + "'"
            + ", Font_Size = " + sMbFont
            + ", Color = '" + sMbColor + "'"
            + ", Bg_Clr = '" + sMbBgClr + "'"
          + " where Name = '" + sMbName + "'";
     }
     else if(sAction.equals("DLT"))
     {
        query = "delete from rci.MSGBOARD"
          + " where Name = '" + sMbName + "'";
     }

     if(sAction.equals("ADDALARM"))
     {
        query = "insert into rci.MsgBAct"
          + " values("
            + "'" + sMaStrNm + "'"
            + ",'" + sMaStpNm + "'"
            + "," + sMaMsgDa
            + "," + sMaMsgTi
            + "," + sMaStrTm
            + "," + sMaStpTm
          + ")";
     }
     if(sAction.equals("UPDALARM"))
     {
        query = "update rci.MsgBAct"
          + " set"
            + " Start_Tm = " + sMaStrTm
            + ",Stop_Tm = " + sMaStpTm
          + " where Start_Nm='" + sMaStrNm + "'"
          + " and Stop_Nm='" + sMaStpNm + "'"
          + " and Msg_Date=" + sMaMsgDa
          + " and Msg_Time=" + sMaMsgTi;
     }
     if(sAction.equals("ACTSTOPALARM"))
     {
        query = "update rci.MsgBAct"
          + " set"
            + " Start_Tm = 0"
            + ",Msg_Date = current date"
            + ",Msg_Time = current time"
          + " where Start_Nm='" + sMaStrNm + "'"
          + " and Stop_Nm='" + sMaStpNm + "'"
          + " and Msg_Date=" + sMaMsgDa
          + " and Msg_Time=" + sMaMsgTi;
     }


     if(sAction.equals("DLTALARM"))
     {
        query = "delete from rci.MsgBAct"
          + " where Start_Nm='" + sMaStrNm + "'"
          + " and Stop_Nm='" + sMaStpNm + "'"
          + " and Msg_Date=" + sMaMsgDa
          + " and Msg_Time=" + sMaMsgTi;
     }

     System.out.println(query);

     RunSQLStmt rsql = new RunSQLStmt();
     int irs = rsql.runSinglePrepStmt(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
%>
<HTML>
<HEAD>
<title>RCI Message Board</title>
<META content="RCI, Inc." name="RCI_Message_Board">
</HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Verdanda; font-size:12px }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:right; font-family:Verdanda; font-size:12px; font-weight:bold; }

   div.dvSbmSts { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
</style>


<script name="javascript1.2">
window.location.href="CompMsgBoardMaint.jsp";
</script>





