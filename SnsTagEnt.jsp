<%@ page import="java.io.*, tagging.SnsTagEnt"%>
<%
   String [] sParam = new String[14];
   String saveFile = null;
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
        sParam[12] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
        sParam[12] = sParam[12].substring(sParam[12].lastIndexOf("\\")+1);
        sParam[13] =  sParam[12].substring(sParam[12].lastIndexOf('.')+1);


        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;

        saveFile = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/SnsTagStd/";
        //saveFile = "/var/tomcat4/webapps/ROOT/SnsTagStd/";
        if (sParam[0].trim().length() < 4)
        {
           sParam[0] = ("0000").substring(0, 4 - sParam[0].trim().length()) + sParam[0].trim();
        }
        saveFile += sParam[0].trim() + sParam[1].trim() + "." + sParam[12].trim();
        out.print(saveFile);

        // find start and end position of file data
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        if(!sParam[12].trim().equals(""))
        {
           if(!sParam[8].trim().equals("DLT"))
           {
              FileOutputStream fileOut = new FileOutputStream(saveFile);
              fileOut.write(dataBytes, startPos, (endPos - startPos));
              fileOut.flush();
              fileOut.close();
           }
        }
  }

  SnsTagEnt savtag = new SnsTagEnt(sParam[0], sParam[1], sParam[2], sParam[3], sParam[4],
             sParam[10], sParam[11], sParam[5], sParam[6], sParam[7], sParam[13], sParam[8], sParam[9]);

  String sUrl = "SnsTagStd.jsp";
  response.sendRedirect(sUrl);
%>
<br>
SF: <%=saveFile%><br>
P0 <%=sParam[0]%><br>
P1 <%=sParam[1]%><br>
P2 <%=sParam[2]%><br>
P3 <%=sParam[3]%><br>
P4 <%=sParam[4]%><br>
P5 <%=sParam[5]%><br>
P6 <%=sParam[6]%><br>
P7 <%=sParam[7]%><br>
P8 <%=sParam[8]%><br>
P9 <%=sParam[9]%><br>
P10 <%=sParam[10]%><br>
P11 <%=sParam[11]%><br>
P12 <%=sParam[12]%><br>
P13 <%=sParam[13]%><br>




