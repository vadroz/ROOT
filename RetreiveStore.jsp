<%@ page import=" rciutility.StoreSelect, java.util.*"%>
<%
   StoreSelect StrSelect = new StoreSelect();
   String sStr = StrSelect.getStrNum();
   String sStrName = StrSelect.getStrName();
%>

<script name="javascript1.2">
var str = [<%=sStr%>];
var strName = [<%=sStrName%>];

var date = new Date(new Date() - 86400000);

parent.showStores(str, strName);



//==============================================================================
// run on loading
//==============================================================================

</script>