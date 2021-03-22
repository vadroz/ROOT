<%@ page import="vendorsupport.VendorClnComment , java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sDate = request.getParameter("Date");
   String sVendor = request.getParameter("Vendor");
   String sAvailable = request.getParameter("Available");
   String sDisponly = request.getParameter("Disponly");
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("VENDOR")!=null)
{

   String sUser = session.getAttribute("USER").toString();

   //System.out.println(" " + sStore + " " + sVendor + " " + sDate);
   VendorClnComment vencomt = new VendorClnComment(sStore, sVendor, sDate, sUser);
   vencomt.setComment();
   String sComment = vencomt.getComment();
   vencomt.setBrand();
   String sBrand = vencomt.getBrand();
   String sBrandSel = vencomt.getBrandSel();

   vencomt.disconnect();
   vencomt = null;
%>
<SCRIPT language="JavaScript1.2">
var Comment = "<%=sComment%>";
var Brand = [<%=sBrand%>];
var BrandSel = [<%=sBrandSel%>];
var Available = <%=sAvailable%>
var Disponly = <%=sDisponly%>
goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
       parent.popComment(Comment, Brand, BrandSel, Available, Disponly);
   }
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







