<%@ page import="classreports.ChallMainLst"%>
<%
    String sType  = "CURRENT";
    String sUser = session.getAttribute("USER").toString();
    ChallMainLst chmainnl = new ChallMainLst(sType, sUser);
%>


<script language="javascript1.2">
var code = new Array();
var name = new Array();
<%
    while(chmainnl.getNext())
    {
       chmainnl.getCodeList();
       int iNumOfChl = chmainnl.getNumOfChl();
       String [] sCode = chmainnl.getCode();
       String [] sName = chmainnl.getName();
       String [] sDesc = chmainnl.getDesc();
       String [] sBegDt = chmainnl.getBegDt();
       String [] sEndDt = chmainnl.getEndDt();
       String [] sResp = chmainnl.getResp();
       String [] sMainPg = chmainnl.getMainPg();
       String [] sLvlBrnz = chmainnl.getLvlBrnz();
       String [] sLvlSlvr = chmainnl.getLvlSlvr();
       String [] sLvlGold = chmainnl.getLvlGold();

       for(int i = 0; i < iNumOfChl; i++){%>
          code[<%=i%>] = "<%=sCode[i]%>";
          name[<%=i%>] = "<%=sName[i]%>";
     <%}
    }
%>

parent.showCurrContests(code, name)

</script>

<%
  chmainnl.disconnect();
  chmainnl = null;
%>