<%@ page import="server_utility.DispLogs, java.util.*"%>
<%
String sFile = request.getParameter("log");
String sProd = request.getParameter("prod");

//if(sFile==null){ sFile="tomcat9-stdout"; }
if(sFile==null){ sFile="localhost"; }
if(sProd==null){ sProd="false"; }
boolean bProd = Boolean.parseBoolean(sProd); 

DispLogs displog = new DispLogs(bProd, sFile); 
String [] sLogList = displog.getLogList();
String [] sModifyDt = displog.getModifyDt();
displog.readFile(sLogList[0]);
%>
<file><%=sLogList[0]%></file><lastmoddate><%=sModifyDt[0]%></lastmoddate>
<$#@lines$#@>   
  <% int i=0; 
     while( displog.readLine() ){%>       
       <%=displog.getLine().trim()%><br>
       <%i++;%> 
     <%}%>
</$#@lines$#@>  