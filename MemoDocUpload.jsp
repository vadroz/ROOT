<%@ page import="java.io.*"%>
<%
   String [] sParam = new String[10];
   String saveFile = null;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null && session.getAttribute("MEMOADD")!=null)
   {
     String contentType = request.getContentType();
     if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {

        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();


        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while (totalBytesRead < formDataLength) {
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }

        String file = new String(dataBytes);

        int lastIndex = contentType.lastIndexOf("=");
        String boundary = contentType.substring(lastIndex + 1,contentType.length());
        int iBndLng = boundary.length();

        for(int i=0, p1=0, p2=0; i< sParam.length ;i++)
        {
          if (p1 == 0)
          {
             p2 = file.indexOf(boundary, p1) +  iBndLng;
             p1 = p2+1;
          }
          p2 = file.indexOf(boundary, p1) +  iBndLng;
          if(p2-iBndLng-4 < 0) { break;}
          p1 = file.substring(p1, p2-iBndLng-4).lastIndexOf('"') + p1 + 1;
          sParam[i] = file.substring(p1, p2-iBndLng-4).trim();
          p1 = p2+1;
        }

        int pos;
        pos = file.indexOf("filename=\"");
        // parse file extenstion -.doc, .pfd, e.t.c.
        sParam[9] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
        sParam[9] = sParam[9].substring(sParam[9].lastIndexOf("\\")+1);
        //sParam[9] =  sParam[9].substring(sParam[9].lastIndexOf('.')+1);

        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;


        saveFile = sParam[1] + sParam[2] + "/";
        for(int i=4; i < sParam.length-1;i++)
        {
          if(sParam[i] != null) saveFile += sParam[i].trim() + "/";
        }
        saveFile += sParam[9].trim();

        // find start and end position of file data
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        FileOutputStream fileOut = new FileOutputStream(saveFile);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();
    }
  }
  String sUrl = "MemoDoc.jsp?Path=" + sParam[1] + "&Folder=" + sParam[2];
  for(int i=4; i < sParam.length-1;i++) {  if(sParam[i] != null) sUrl += "&Key=" + sParam[i]; }
  response.sendRedirect(sUrl);
%>
<br>
SF: <%=saveFile%><br>
P1 <%=sParam[1]%><br>
P2 <%=sParam[2]%><br>
P3 <%=sParam[3]%><br>
P4 <%=sParam[4]%><br>
P4 <%=sParam[5]%><br>
P4 <%=sParam[6]%><br>
P4 <%=sParam[7]%><br>
P4 <%=sParam[8]%><br>
P9 <%=sParam[9]%><br>
