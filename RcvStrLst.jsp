<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
    StoreSelect StrSelect = null;
    String sStr = null;
    String sStrName = null;
    String sStrAllowed = session.getAttribute("STORE").toString();
    StrSelect = new StoreSelect(9);

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();
%>
<SCRIPT language="JavaScript1.2">

var Stores = [<%=sStr%>]
var StoreNames = [<%=sStrName%>]

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.setStrLst(Stores, StoreNames);
   }
</SCRIPT>
