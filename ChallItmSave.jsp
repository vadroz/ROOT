<%@ page import=" classreports.ChallItmSave, java.util.*"%>
<%
    String sCode = request.getParameter("Code");
    String [] sDiv = request.getParameterValues("AddDiv");
    String [] sDpt = request.getParameterValues("AddDpt");
    String [] sCls = request.getParameterValues("AddCls");
    String [] sVen = request.getParameterValues("AddVen");
    String sAction = request.getParameter("Action");

    if(sDiv == null ){ sDiv = new String[]{" "}; }
    if(sDpt == null ){ sDpt = new String[]{" "}; }
    if(sCls == null ){ sCls = new String[]{" "}; }
    if(sVen == null ){ sVen = new String[]{" "}; }

    //System.out.println(request.getQueryString());

 if (session.getAttribute("USER")!=null)
 {

    String sUser = session.getAttribute("USER").toString();

    ChallItmSave chitmsv = new ChallItmSave(sCode, sDiv, sDpt, sCls, sVen, sAction, sUser);
%>

<script name="javascript1.2">
parent.redisplay();

//==============================================================================
// run on loading
//==============================================================================

</script>

<%
   chitmsv.disconnect();
   chitmsv = null;
}
else {%> alert("Your session is expired. Please refresh your screen.") <%}%>