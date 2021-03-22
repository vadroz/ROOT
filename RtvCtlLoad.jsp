<%@ page import="rtvregister.RtvCtlSv,java.util.*, java.io.*"%>
<%
   String [] sParam = new String[10];
   String sCtl = null;
   String sItem = null;
   String sExtension = null;
   String sFileOut = null;

   String sFileName = null;
   File fTo = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null)
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
        sParam[8] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
        sParam[8] = sParam[8].substring(sParam[8].lastIndexOf("\\")+1);
        //sParam[9] =  sParam[9].substring(sParam[9].lastIndexOf('.')+1);

        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;


        sCtl = sParam[1].trim();
        sItem = sParam[2].trim();
        sExtension = sParam[8].trim().substring(sParam[8].trim().lastIndexOf(".") + 1);
        //sFileName = sParam[9].trim();

        // find start and end position of file data
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        // format project id to 10 characters string
        String sTenDig = "0000000000";

        String sUser = session.getAttribute("USER").toString();
        RtvCtlSv ctlsv = new RtvCtlSv();
        
        ctlsv.saveItemPic(sCtl, sItem, sExtension, "Add_Itm_Photo", sUser);        
        sFileName = ctlsv.getFileNm();
        //System.out.println("file=" + sFileName);
        sFileOut = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/RTV/" + sFileName;

        //fTo = new File(sFileOut);
        //fTo.createNewFile();
        FileOutputStream fileOut = new FileOutputStream(sFileOut);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();
    }

  String sUrl = "RtvCtlInfo.jsp?Ctl=" + sCtl;
  response.sendRedirect(sUrl);
  
%>
<br>
Ctl <%=sParam[1]%><br>
Sku <%=sParam[2]%><br>
Extension <%=sExtension%><br>
Absolute Path <%=sParam[3]%><br>
Saved File <%=sFileOut%><br>
sUrl <%=sUrl%><br>

<%}
else{%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to modify claim.")
</SCRIPT>
<%}%>