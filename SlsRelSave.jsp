<%@ page import="classreports.SlsRelSave, java.util.*"%>
<%
    String [] sFrom = request.getParameterValues("From");
    String [] sFromNm = request.getParameterValues("FromNm");
    String [] sTo = request.getParameterValues("To");
    String [] sToNm = request.getParameterValues("ToNm");
    String sRepName = request.getParameter("RepName");
    String sAction = request.getParameter("Action");

    //System.out.println("Code: " + sRepName + "\nAction: " + sAction);
    SlsRelSave slsRepSv = new SlsRelSave(sRepName, sFrom, sTo, sAction);

    String sError = slsRepSv.getError().trim();
    //System.out.println("Error: " + sError);
    slsRepSv.disconnect();

%>

<script name="javascript">
var RepName = "<%=sRepName%>";
var From = new Array();
<%for(int i=0; i < sFrom.length; i++) {%>   From[<%=i%>] = "<%=sFrom[i]%>"; <%}%>
var To = new Array();
<%for(int i=0; i < sTo.length; i++) {%>   To[<%=i%>] = "<%=sTo[i]%>"; <%}%>
var Error = "<%=sError%>";

chkResult();
//========================================================
// check return result
//========================================================
function chkResult()
{
   parent.getResult(Error);
}

</script>