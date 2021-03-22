<%@ page import="menu.POWoBsrUpcList , java.util.*"%>
<%
    POWoBsrUpcList powobsr = new POWoBsrUpcList();

    int iNumOfDiv = powobsr.getNumOfDiv();
    String sDiv = powobsr.getDiv();
    String sDivName = powobsr.getDivName();
    String sNumOfNoBsr = powobsr.getNumOfNoBsr();
    String sNumOfNoUpc = powobsr.getNumOfNoUpc();

    powobsr.disconnect();
    powobsr = null;
%>
<SCRIPT language="JavaScript1.2">
var Div = [<%=sDiv%>];
var DivName = [<%=sDivName%>];
var NumOfNoBsr = [<%=sNumOfNoBsr%>];
var NumOfNoUpc = [<%=sNumOfNoUpc%>];

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.showPOWoBsrUpc(Div, DivName, NumOfNoBsr, NumOfNoUpc);
}
</SCRIPT>







