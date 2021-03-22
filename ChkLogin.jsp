<%@ page import="java.util.*"%>
<%
    sTarget = "/SignOn.jsp";
    out.println("Chk: "  +sTarget);
    System.out.println("Chk: "  +sTarget);
    session.getServletContext().getRequestDispatcher(sTarget).forward(request, response);
  }
%>