<%@ page import="rtvregister.MrVDocUpl, java.io.*"%>
<%
   String [] sParam = new String[2];
   String saveFile = null;
   String sFile = null;
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

        for(int i=0, p1=0, p2=0; i<2 ;i++)
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
        sParam[1] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
        sParam[1] = sParam[1].substring(sParam[1].lastIndexOf('.')+1);

        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;

        // generat/save/return file name in as400
        MrVDocUpl mrvupl = new MrVDocUpl(sParam[0], sParam[1]);
        mrvupl.disconnect();

        sFile = "VEN_" + sParam[0] + "." + sParam[1];
        saveFile = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/VendorDoc/" + sFile.trim();
        //saveFile = "/var/tomcat4/webapps/ROOT/VendorDoc/" + sFile.trim();

        // find start and end position of file data
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        FileOutputStream fileOut = new FileOutputStream(saveFile);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();
    }
%>
<script name="javascript1.2">
var FileExt = "<%=sParam[1]%>"
var File = "<%=sFile%>"
function bodyload()
{
  window.opener.hideUpload();
  window.opener.showDocUpl(File, FileExt);
  this.close();
}
</script>
<body onload="bodyload()"></body>