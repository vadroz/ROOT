<%@ page import="rciutility.RtvClassGrpList, java.util.*"%>
<%
   String sGrp = request.getParameter("grp");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    String sUser = session.getAttribute("USER").toString();

    RtvClassGrpList rtvgrp = new RtvClassGrpList();
    rtvgrp.setClsList(sGrp);
	rtvgrp.getClsList();
	int iNumOfCls = rtvgrp.getNumOfCls();
	String sCls = rtvgrp.getClsJsa();
	String sClsNm = rtvgrp.getClsNmJsa();
%>

<SCRIPT language="JavaScript1.2">
var Cls = [<%=sCls%>];
var ClsNm = [<%=sClsNm%>];

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.setGrpClsSel(Cls, ClsNm);
   }

</SCRIPT>
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>