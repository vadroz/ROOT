<%@ page import="menu.Menu, java.util.*"%>
<%
   String sParent = request.getParameter("Parent");
   String sRoot = request.getParameter("Root");
   String sUser = request.getParameter("User");

   Menu menu = new Menu(sParent, sUser);
   int iNumOfMenu = menu.getNumOfMenu();
   String sMenu = menu.getMenu();
   String sUrl = menu.getUrl();
   String sType = menu.getType();

   menu.disconnect();
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Root = <%=sRoot%>;
var Menu = [<%=sMenu%>];
var Url = [<%=sUrl%>];
var Type = [<%=sType%>];
var Parent = "<%=sParent%>"

setMenu();

// send menu arrays
function setMenu()
{
  parent.setMenuBar(Parent, Menu, Url, Type);
  parent.showMenuBar(Root, Menu, Url, Type, true);
}
</SCRIPT>
<body>
 Parent = <%=sParent%>
 Menu = "<%=sMenu%>";
 Url = "<%=sUrl%>";
</body>
</html>


