<%@ page import="mozu_com.MozuImageSave, java.util.*, java.io.*"%>
<%
   String [] sParam = new String[10];
   String sSeq = null;
   String sCls = null;
   String sVen = null;
   String sSty = null;
   String sAction = null;
   String sType = null;
   String sCommt = null;
   String sFileOut = null;
   String sExtension = null;
   String sClrId = null;
   
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
        sParam[9] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
        sParam[9] = sParam[9].substring(sParam[9].lastIndexOf("\\")+1);
        
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;

        sExtension = sParam[9].trim().substring(sParam[9].trim().lastIndexOf(".") + 1);
        sCommt = sParam[2].trim();
        sCls = sParam[5].trim().substring(0,4);
        sVen = sParam[5].trim().substring(4, 10);
        sSty = sParam[5].trim().substring(10);
        sAction = sParam[6].trim();
        sType = sParam[7].trim();
        sClrId = sParam[8].trim();
        sSeq = "0";
    
        sFileName = sParam[3].trim();
        
        // find start and end position of file data
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        // format project id to 10 characters string
        String sTenDig = "0000000000";

        String sUser = session.getAttribute("USER").toString();
      
        // save next sequence for PO document in RCI/PODOCL
        MozuImageSave imgsv = new MozuImageSave();        
        //System.out.println("\nParam: " + sCls + "|" + sVen + "|" + sSty  + "|" + sSeq + sFileName + "|" 
        //+ sCommt + "|" + sAction  + "|" + sUser );
        imgsv.saveImage(sCls,  sVen,  sSty, sSeq, sFileName, sCommt, sClrId, sType, sAction, sUser);
        sSeq = imgsv.getSeq();
        sFileName = imgsv.getFileNm();
        
        sFileOut = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Mozu_Images/" + sFileName;
        
        fTo = new File(sFileOut);
        fTo.createNewFile();
        
        FileOutputStream fileOut = new FileOutputStream(sFileOut);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();        
    }  
%>
<br>
<%for(int i=0; i < sParam.length; i++){%>
  <%=i%>. <%=sParam[i]%><br>
<%}%>


Seq = <%=sSeq%><br>
sFileName = <%=sFileName%><br>
Extension .<%=sExtension %><br>
Saved File <%=sFileOut%><br>
Action <%=sAction%><br>
Type <%=sType%><br>
ClrID <%=sClrId%><br>

<SCRIPT language="JavaScript1.2">
  parent.location.reload();
</SCRIPT>

<%}
else{%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to modify claim.")
</SCRIPT>
<%}%>