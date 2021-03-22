<%@ page import="ecommerce.EComOrdReprint"%>
<%
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");
    String sPrinter = request.getParameter("Printer");
    String sOutq = request.getParameter("Outq");
    String sOutqLib = request.getParameter("OutqLib");
    String sWhsOrStr = request.getParameter("WhsOrStr");
    String sStr = request.getParameter("Str");

    if(sPrinter == null){sPrinter = " ";}
    if(sOutq == null){sOutq = " ";}
    if(sOutqLib == null){sOutqLib = " ";}

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComOrdInfo.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    EComOrdReprint ordprt = new EComOrdReprint();
    if(sWhsOrStr.equals("Y"))
    {
       //System.out.println(1 + "  sPrinter: " + sPrinter + "  sOutq: " + sOutq);
       ordprt.printWhs(sSite, sOrder, sPrinter, sOutq, sOutqLib, sUser);
    }
    else
    {
       //System.out.println(2 + "  sPrinter: " + sPrinter + "  sOutq: " + sOutq);
       ordprt.printStr(sSite, sOrder, sPrinter, sOutq, sOutqLib, sStr, sUser);
    }

%>
<script>
  <%if(!sPrinter.equals("EMAIL")) {%>alert("Order packing slip is printed on QPRINT4.")<%}
    else{%>alert("Order packing slip is emailed to you.")<%}%>
</script>

<%
   ordprt.disconnect();
   }
%>
