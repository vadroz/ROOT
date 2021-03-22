<%@ page import="test_jar_001.*, java.util.*, java.text.*"%>
<%
   CallFromJar cfj = new CallFromJar("Hello");
   String sOut = cfj.getOut();
   System.out.println(sOut);
   
   GetStrList strlist = new GetStrList();
		String [] sStr = strlist.getStr();		
%>

<html>   
<head>
<body> 
test
<h1><%=sOut%></h1>

<%for(int i=0; i < 30 ; i++){%>
    Str=<%=sStr[i]%>;   
<%}%>
 </body>
</html>
