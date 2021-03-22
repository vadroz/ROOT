<%
   int iCount = 0;
   if (session.getAttribute("SSV02")==null){
       session.setAttribute("SSV02", new Integer(iCount));
   }
   else {
    Integer igrCnt = (Integer)session.getAttribute("SSV02");
    iCount =  igrCnt.intValue();
    iCount++;
    session.setAttribute("SSV02", new Integer(iCount));
   }
%>

<html>

<head>
</head>

<body>
<p align="center">
<a href="SessionVar2.jsp">To session 2</a>
<br>Session Varibles: <%=session.getAttribute("SSV02")%>
</body>
</html>
