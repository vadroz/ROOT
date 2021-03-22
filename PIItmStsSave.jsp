<%@ page import="java.util.*, java.text.*, inventoryreports.PIItmStsSave"%>
<%
   String sStore = request.getParameter("Store");
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sClass = request.getParameter("Class");
   String sVendor = request.getParameter("Vendor");
   String sStyle = request.getParameter("Style");
   String sColor = request.getParameter("Color");
   String sSize = request.getParameter("Size");
   String sPiYearMo = request.getParameter("PICal");
   String sInit = request.getParameter("Init");
   String sComm = request.getParameter("Comm");
   String sStatus = request.getParameter("Status");
   String sUser = request.getParameter("User");

   if(sDiv == null){ sDiv = " "; }
   if(sDpt == null){ sDpt = " "; }
   if(sClass == null){ sClass = " "; }
   if(sVendor == null){ sVendor = " "; }
   if(sStyle == null){ sStyle = " "; }
   if(sColor == null){ sColor = " "; }
   if(sSize == null){ sSize = " "; }
   if(sComm == null){ sComm = " "; }

   System.out.println(sDiv + " " + sDpt + " " + sClass + " " + sVendor + " " + sStyle + " " + sColor + " " + sSize
   + " " + sPiYearMo + " " + sInit + " " + sComm + " " + sStatus + " " + sUser);
   PIItmStsSave savePiSts = new PIItmStsSave(sDiv, sDpt, sClass, sVendor, sStyle, sColor, sSize,
      sStore, sPiYearMo.substring(0, 4), sPiYearMo.substring(4), sInit, sComm, sStatus, sUser);
   savePiSts.disconnect();
%>


<script language="javascript">
  //parent.window.location.reload()
</script>


