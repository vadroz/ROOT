<%@ page import="advertising.AdFileUpload, java.io.*"%>
<%
   String [] sParam = new String[11];
   String saveFile = null;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null && session.getAttribute("ADVERTISES")!=null)
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

        for(int i=0, p1=0, p2=0; i < 10 ;i++)
        {
          if (p1 == 0)
          {
             p2 = file.indexOf(boundary, p1) +  iBndLng;
             p1 = p2+1;
          }
          p2 = file.indexOf(boundary, p1) +  iBndLng;
          p1 = file.substring(p1, p2-iBndLng-4).lastIndexOf('"') + p1 + 1;
          sParam[i] = file.substring(p1, p2-iBndLng-4).trim();
          p1 = p2+1;
        }

        int pos;
        pos = file.indexOf("filename=\"");
        // parse file extenstion -.doc, .pfd, e.t.c.
        sParam[10] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
        sParam[10] = sParam[10].substring(sParam[10].lastIndexOf("\\")+1);
        //System.out.println(sParam[10]);

        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;

        // generat/save/return file name in as400
        AdFileUpload adupl = new AdFileUpload(sParam[0], sParam[1], sParam[2], sParam[3],
                    sParam[4], sParam[5], sParam[10], session.getAttribute("USER").toString(), sParam[9]);
        adupl.disconnect();

        saveFile = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/Advertising/" + sParam[10].trim();
        //saveFile = "/var/tomcat4/webapps/ROOT/Advertising/" + sParam[10].trim();

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
  String sUrl = "AdFisCal.jsp?MonBeg=" + sParam[7] + "&MonName=" + sParam[8] +  "&Market=" + sParam[0] + "&MktName=" + sParam[6];
  response.sendRedirect(sUrl);
%>
Test 101 <br>
<%=saveFile%><br>
<%=sParam[0]%><br>
<%=sParam[1]%><br>
<%=sParam[2]%><br>
<%=sParam[3]%><br>
<%=sParam[4]%><br>
<%=sParam[5]%><br>
<%=sParam[6]%><br>
<%=sParam[7]%><br>
<%=sParam[8]%><br>
<%=sParam[9]%><br>
<%=sParam[10]%><br>

