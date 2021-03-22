<%
    System.out.println("Start Test01.jsp");
%>
<html>

<head><title>Test_Applete</title></head>

<body><h1>Test Applet</h1>

<object classid = "clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
       codebase = "http://java.sun.com/update/1.5.0/jinstall-1_5-windows-i586.cab#Version=5,0,0,5"
       id="Chart" width=200 height=400>
       <PARAM NAME = CODEBASE VALUE = "/applet">
       <PARAM NAME = CODE VALUE = "testapplet.Test01.class">
       <PARAM NAME = TYSls VALUE = "651331">
       <PARAM NAME = LYSls VALUE = "468602">
       <PARAM NAME = Var VALUE = "39.0">
</object>


</body>
</html>
