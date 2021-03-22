<%@ page import="java.io.*, java.util.*, java.net.*"%>
<%
     try{
        Socket socket = new Socket("127.0.0.1", 8765);

        OutputStream os = socket.getOutputStream();

        String s = "CLOSE!\n";
        byte [] buffer = s.getBytes();
        os.write(buffer);
     }
     catch(Exception e){ System.out.println(e.getMessage());}

%>
<script name="javascript1.2">
window.open(location.href, "_self");
window.close();
</script>