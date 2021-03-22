<html>
<head>
<title>
Product Tickets Print Panel
</title>
     <style type="text/css">
       body {background:ivory;}
       a.blue:visited {  font-weight: bold; color: #663399}
       a.blue:link {  font-weight: bold; color: #0000FF}
     </style>

</head>

<body>
<Table Border=0 CELLSPACING="5" CELLPADDING="0" width="100%"
height="100%">
<tr>
    <td height="20%" COLSPAN=2>
        <img src="Sun_ski_logo4.png"></td>
<tr>
    <td WIDTH="15%"  bgColor="A7B5E8">
    <font color=#445193 size=1 face=Arial>
    <h5>&nbsp;&nbsp;Miscellaneous</h5>
    &nbsp;&nbsp; <a class="blue" href="MAILTO:helpdesk@retailconcepts.cc">Mail to IT</a></li>
    <br>&nbsp;&nbsp;&nbsp;<a class="blue" href="http://sunandski.com/">Our Internet</a></li>


    </font></td>
    <td WIDTH="85%" nowrap valign="top"
        bgColor="moccasin">
      <applet
        codebase = "/intranet/applet"
        code     = "bbtclient/BBTClient01.class"
        name     = "BBTClient"
        width    = "400" height   = "300" hspace   = "60" vspace   = "15" align    = "top">

      <% out.println("<param NAME=RRN value='");
         out.println( request.getParameter("RRN"));   out.println("'>"); %>
      <% out.println("<param NAME=CLASS value='");
         out.println( request.getParameter("CLASS")); out.println("'>"); %>
      <% out.println("<param NAME=VENDOR value='");
         out.println( request.getParameter("VENDOR")); out.println("'>"); %>
      <% out.println("<param NAME=STYLE value='");
         out.println( request.getParameter("STYLE")); out.println("'>"); %>
      <% out.println("<param NAME=COLOR value='");
         out.println( request.getParameter("COLOR")); out.println("'>"); %>
      <% out.println("<param NAME=SIZE value='");
         out.println( request.getParameter("SIZE")); out.println("'>"); %>
      <% out.println("<param NAME=DOLLARS value='");
         out.println( request.getParameter("DOLLARS")); out.println("'>"); %>
      <% out.println("<param NAME=CENTS value='");
         out.println( request.getParameter("CENTS")); out.println("'>"); %>
      <% out.println("<param NAME=SUGDLRS value='");
        out.println( request.getParameter("SUGDLRS")); out.println("'>"); %>
      <% out.println("<param NAME=SUGCNTS value='");
        out.println( request.getParameter("SUGCNTS")); out.println("'>"); %>
      <% out.println("<param NAME=ITMDES value='");
        out.println( request.getParameter("ITMDES")); out.println("'>"); %>
      <% out.println("<param NAME=VENNAME value='");
        out.println( request.getParameter("VENNAME")); out.println("'>"); %>
      <% out.println("<param NAME=EXTDES1 value='");
        out.println( request.getParameter("EXTDES1")); out.println("'>"); %>
      <% out.println("<param NAME=EXTDES2 value='");
        out.println( request.getParameter("EXTDES2")); out.println("'>"); %>
      <% out.println("<param NAME=EXTDES3 value='");
        out.println( request.getParameter("EXTDES3")); out.println("'>"); %>
      <% out.println("<param NAME=EXTDES4 value='");
        out.println( request.getParameter("EXTDES4")); out.println("'>"); %>
      </applet>

    </td>
</tr>
</TABLE>
<br>
<p>Download fonts:
<a class="blue" href="Fonts/boulder.TTF">Boulder</a>
<a class="blue" href="Fonts/TT0586M.TTF">EngraversGothic BT</a>
</body>
</html>
