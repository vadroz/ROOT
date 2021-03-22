<%@ page import="rciutility.GetDataBySQL, java.util.*"%>
<%
   GetDataBySQL deptlst = new GetDataBySQL();

   StringBuffer sbDept = new StringBuffer();
   StringBuffer sbDptName = new StringBuffer();

   deptlst.setPrepStmt("select udky, uddes1 from rci.FsyUdc"
                     + " where  udsy='PY' and udrt='PR' and udky>='001'"
                     + " order by udky");
   deptlst.runQuery();
   String sComa = "";
   while(deptlst.readNextRecord()) {
      sbDept.append(sComa + "'" + deptlst.getData("UDKY", 0).trim() + "'");
      sbDptName.append(sComa + "'" + deptlst.getData("UDDES1", 0).trim() + "'");
      sComa = ",";
   }

   deptlst.disconnect();
   deptlst = null;
%>
<script language="Javascript">
var Dpt = [<%=sbDept.toString()%>];
var DptName = [<%=sbDptName.toString()%>];
parent.setDeptList(Dpt, DptName);
</script>





