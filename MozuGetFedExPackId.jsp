<%@ page import="mozu_com.MozuSrlAsgSave, rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%    
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");
    String sAction = request.getParameter("Action");
    
    String sUser = "None";
   
    String sPackId = "NONE";
    
    MozuSrlAsgSave itmasgsav = new MozuSrlAsgSave();
    sPackId = itmasgsav.genPackID(sSite, sOrder, sAction, sUser);    
%><%=sPackId%>











