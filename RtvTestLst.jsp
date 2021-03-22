<%@ page import="rciutility.GetDataBySQL, java.util.*"%>
<%
   GetDataBySQL testlst = new GetDataBySQL();

   StringBuffer sbTest = new StringBuffer();
   StringBuffer sbTstName = new StringBuffer();

   testlst.setPrepStmt("select TnTest, TnName from rci.TrnLst"
                     + " order by TnSort, TnTest");
   testlst.runQuery();
   String sComa = "";
   while(testlst.readNextRecord()) {
      sbTest.append(sComa + "'" + testlst.getData("TnTest", 1).trim() + "'");
      sbTstName.append(sComa + "'" + testlst.getData("TnName", 0).trim() + "'");
      sComa = ",";
   }

   testlst.disconnect();
   testlst = null;
%>
<script language="Javascript">
var Test = [<%=sbTest.toString()%>];
var TstName = [<%=sbTstName.toString()%>];
parent.setTestList(Test, TstName);
</script>





