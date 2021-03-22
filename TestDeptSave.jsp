<%@ page import="rciutility.GetDataBySQL, java.util.*"%>
<%
   String sDept = request.getParameter("Dept");
   String sDptName = request.getParameter("DptName");
   String sTest = request.getParameter("Test");
   String sTstName = request.getParameter("TstName");
   String sAction = request.getParameter("Action");

   GetDataBySQL popfile = new GetDataBySQL();

   String sStmt = null;
   boolean bError = false;
   String sMsg = null;

   if(sAction.equals("ADD"))
   {
      // check if department/test already exist
      sStmt = "select * from rci.TrnDpt where TdDpt='" + sDept + "' and TdTest=" + sTest;
      System.out.println(sStmt);
      popfile.setPrepStmt(sStmt);
      popfile.runQuery();
      if(popfile.readNextRecord()){ bError = true; sMsg="Department/test already exist.";};
      System.out.println("bError " + bError);
      if(!bError)
      {
         sStmt = "insert into rci.TrnDpt values('" + sDept + "', " + sTest + ")";
         popfile.setPrepStmt(sStmt);
         popfile.runQuery();
      }
   }
   else if(sAction.equals("DLT"))
   {
      // check if department/test already exist
      sStmt = "select * from rci.TrnDpt where TdDpt='" + sDept + "' and TdTest=" + sTest;
      System.out.println(sStmt);
      popfile.setPrepStmt(sStmt);
      popfile.runQuery();
      if(!popfile.readNextRecord()){ bError = true; sMsg="Department/test is not found.";};

      if(!bError)
      {
         sStmt = "delete from rci.TrnDpt  where TdDpt='" + sDept + "' and TdTest=" + sTest;
         popfile.setPrepStmt(sStmt);
         popfile.runQuery();
      }
   }

   popfile.disconnect();
   popfile = null;
%>
<script language="Javascript">
     <%if(!bError){%>
        <%if(sAction.equals("ADD")) {%>parent.addNewRecord("<%=sDept%>", "<%=sDptName%>", <%=sTest%>, "<%=sTstName%>")<%}%>
        <%if(sAction.equals("DLT")) {%>parent.updOldRecord()<%}%>
     <%}
       else {%>
         parent.displayError("<%=sMsg%>")
     <%}%>

</script>





