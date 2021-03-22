<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sAction = request.getParameter("Action");
   String sType = request.getParameter("Type");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null)
   {
      String sUser = session.getAttribute("USER").toString();
      String sStmt = null;
      String sMedType = "";
      String sMedTypeNm = "";

      String sMedia = "";
      String sMedId = "";

      if(sAction.equals("GETMEDTYPE"))
      {
         sStmt = "select AMTYP, AMDES"
           + " from  rci.AdMedia"
           + " where exists(select 1 from rci.ADMEDNAM where AmTyp=MnMTyp)"
           + " order by amsrt"
         ;

         RunSQLStmt sql_MedType = new RunSQLStmt();
         sql_MedType.setPrepStmt(sStmt);
         ResultSet rs_MedType = sql_MedType.runQuery();
         String coma = "";
         while(sql_MedType.readNextRecord())
         {
           sMedType += coma + "'" + sql_MedType.getData("AMTYP").trim() + "'";
           sMedTypeNm += coma + "'" + sql_MedType.getData("AMDES").trim() + "'";
           coma = ",";
         }
         sql_MedType.disconnect();
     }

     else if(sAction.equals("GETMEDIA"))
      {
         sStmt = "select MNMEDID, MNMEDIA"
           + " from rci.AdMedNam"
           + " where MnMTyp='" + sType + "'"
           + " order by MNMEDIA"
         ;
         //System.out.println(sStmt);
         RunSQLStmt sql_MedName = new RunSQLStmt();
         sql_MedName.setPrepStmt(sStmt);
         ResultSet rs_MedName = sql_MedName.runQuery();
         String coma = "";
         while(sql_MedName.readNextRecord())
         {
           sMedia += coma + "'" + sql_MedName.getData("MnMedia").trim() + "'";
           sMedId += coma + "'" + sql_MedName.getData("MnMedId").trim() + "'";
           coma = ",";
         }
         sql_MedName.disconnect();
     }

%>
<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>";

if(Action == "GETMEDTYPE")
{
   var medTypeLst = [<%=sMedType%>];
   var medTypeNmLst = [<%=sMedTypeNm%>];
   parent.setMedTypeSel(medTypeLst, medTypeNmLst);
}
if(Action == "GETMEDIA")
{
   var mediaLst = [<%=sMedia%>];
   var medIdLst = [<%=sMedId%>];
   parent.setMediaSel(medIdLst, mediaLst);
}
</SCRIPT>
<%}
else {%><SCRIPT language="JavaScript1.2">alert("You must to sign on.")</SCRIPT><%}%>

