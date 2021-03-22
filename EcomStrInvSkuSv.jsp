<%@ page import="ecommerce.EcomStrInvSkuSv , java.util.*"%>
<%
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");
   String sSku = request.getParameter("Sku");
   String sQty = request.getParameter("Qty");
   String sPrice = request.getParameter("Price");
   String [] sStr = request.getParameterValues("Str");
   String sNote = request.getParameter("Note");
   String sAction = request.getParameter("Action");

   if(sDiv == null ){ sDiv = " ";}
   if(sDpt == null ){ sDpt = " ";}
   if(sCls == null ){ sCls = " ";}
   if(sVen == null ){ sVen = " ";}
   if(sSty == null ){ sSty = " ";}
   if(sClr == null ){ sClr = " ";}
   if(sSiz == null ){ sSiz = " ";}
   if(sSku == null ){ sSku = " ";}
   if(sQty == null ){ sQty = "0";}
   if(sPrice == null ){ sPrice = "0";}
   if(sStr == null ){ sStr = new String[]{" "}; }
   if(sNote == null ){ sNote = " ";}

   EcomStrInvSkuSv strinvsv = new EcomStrInvSkuSv();
   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMMERCE")!=null)
{
   String sUser = session.getAttribute("USER").toString();

   strinvsv.setSkuInv(sDiv, sDpt, sCls, sVen, sSty, sClr, sSiz, sSku, sQty, sPrice, sStr, sNote, sAction, sUser);
   iNumOfErr = strinvsv.getNumOfErr();
   sError = strinvsv.getError();

   // special Order Item Entry
   strinvsv.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];

   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
     if(NumOfErr > 0) parent.displayError(Error);
     else parent.reload();
   }


<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







