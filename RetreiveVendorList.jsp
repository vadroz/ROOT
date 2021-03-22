<%@ page import=" rciutility.VendorSelect, java.util.*"%>
<%
     String sPatio = request.getParameter("Patio");
     if(sPatio == null){ sPatio = "N"; }
     
     VendorSelect vensel = null;
     if(!sPatio.equals("Y"))
     { 
    	 vensel = new VendorSelect();
     }
     else
     { 
    	 vensel = new VendorSelect(sPatio);
     }
     
     String sVen = vensel.getVenNum();
     String sVenName = vensel.getVenName();
%>

<script name="javascript1.2">
var Ven = [<%=sVen%>];
var VenName = [<%=sVenName%>];

parent.showVendors(Ven, VenName);

//==============================================================================
// run on loading
//==============================================================================

</script>