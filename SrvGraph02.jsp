<%@ page import="rciutility.StoreSelect, payrollreports.SetMsgBrd, java.util.*"%>
<%@ page import="java.awt.*,java.awt.image.*,java.io.*,com.sun.image.codec.jpeg.*"%>
<%
response.setContentType("image/jpeg");
//*****Make a Simple Image object*****
  BufferedImage image=new BufferedImage(500,100, BufferedImage.TYPE_INT_RGB);
  Graphics g=image.getGraphics();

  g.setColor(Color.blue);
  g.fillRect(425,25,50,50);

  g.setColor(Color.red);
  g.setFont(new Font("Serif", Font.ITALIC, 48));
  g.drawString("Hello World!", 10, 50);

  JPEGImageEncoder encoder=JPEGCodec.createJPEGEncoder(response.getOutputStream());
  encoder.encode(image);
  out.flush();
  out.clear();
 //*****End a Simple Image object*****
  response.setContentType("text/html");
  out.println("<br><br><br><br><br><br><br><br><br><br><br><br>Test");
  out.flush();
  out.clear();
%>
<html>
<head>

</head>
<body>
<p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p><p>
Privet mir!!!
</body>
</html>
