<%@ page import="ecommerce.EComSrlAsgSave, rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%    
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");
    String sAction = request.getParameter("Action");
    
    String sUser = "None";
   
    String sPackId = "NONE";
    
    EComSrlAsgSave itmasgsav = new EComSrlAsgSave();
    sPackId = itmasgsav.genPackID(sSite, sOrder, sAction, sUser);    
%><%=sPackId%>











