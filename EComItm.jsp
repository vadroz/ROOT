<%@ page import="java.util.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
    String sCls = request.getParameter("Cls");
    String sVen = request.getParameter("Ven");
    String sSty = request.getParameter("Sty");
    String sClr = request.getParameter("Clr");
    String sSiz = request.getParameter("Siz");
    String sMnfName = request.getParameter("MnfName");
    String sModelName = request.getParameter("ModelName");
    String sModelYear = request.getParameter("ModelYear");
    String sGender = request.getParameter("Gender");
    String sMap = request.getParameter("Map");
    String sMapExpDate = request.getParameter("MapExpDate");
    String sIntro = request.getParameter("Intro");
    String sFeatures = request.getParameter("Features");


    if(sMnfName == null) sMnfName = " ";
    if(sModelName == null) sModelName = " ";
    if(sModelYear == null) sModelYear = " ";
    if(sGender == null) sGender = " ";
    if(sMap == null) sMap = " ";
    if(sMap == null) sMapExpDate = " ";
    if(sIntro == null) sIntro = " ";
    if(sFeatures == null) sFeatures = " ";

    session.setMaxInactiveInterval(1200);
%>

<table border=1>
 <tr>
  <th>Class</th><th>Vendor</th><th>Style</th><th>Color</th><th>Size</th>
 </tr>
 <tr>
  <td><%=sCls%></td><td><%=sVen%></td><td><%=sSty%></td><td><%=sClr%></td><td><%=sSiz%></td>
  <td><%=sMnfName%></td><td><%=sModelName%></td><td><%=sModelYear%></td><td><%=sGender%></td>
  <td><%=sMap%></td><td><%=sMap%></td><td><%=sIntro%></td><td><%=sFeatures%></td>
 </tr>
</table>







