<%@ page import="java.io.*, eventcalendar.EvtAdvEnt"%>
<%
   String [] sParam = new String[18];
   String saveFile = null;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null && session.getAttribute("EVTCALCHG")!=null)
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

        int max = sParam.length-1;
        for(int i=0, p1=0, p2=0; i< max;i++)
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
          if (i==16 && sParam[14].equals("DLT")){max--;}
        }

        int pos=0;
        int startPos = 0;
        int endPos = 0;

        saveFile = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Advertising/";
        
        if(sParam[14].equals("ADD"))
        {
           pos = file.indexOf("filename=\"");
           sParam[sParam.length-1] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
           sParam[sParam.length-1] = sParam[sParam.length-1].substring(sParam[sParam.length-1].lastIndexOf("\\")+1);
           pos = file.indexOf("\n", pos) + 1;
           pos = file.indexOf("\n", pos) + 1;
           pos = file.indexOf("\n", pos) + 1;
           // find start and end position of file data
           int boundaryLocation = file.indexOf(boundary, pos) - 4;
           startPos = ((file.substring(0, pos)).getBytes()).length;
           endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
        }
        else
        {
          sParam[sParam.length-1] = sParam[sParam.length-2];
        }

        saveFile += sParam[sParam.length-1].trim();

        // Replace ASCII characters
        String [] sASCII = new String[]{ "%27", "%23", "%26", "%25" };
        String [] sSpecChar = new String[]{ "'", "#", "&", "%" };
        for(int i=0; i < 4; i++)
        {
           while(sParam[12].indexOf(sASCII[i]) > 0)
           {
              int j = sParam[12].indexOf(sASCII[i]);
              sParam[12] = sParam[12].substring(0, j) + sSpecChar[i] + sParam[12].substring(j+3);
           }
        }

        //System.out.println(sParam[17]);

        EvtAdvEnt evtcal = new EvtAdvEnt();
        evtcal.savEvtAdvNewspaper(sParam[12], sParam[13], sParam[0], sParam[9],
            new String[]{sParam[2], sParam[3], sParam[4], sParam[5], sParam[6], sParam[7], sParam[8]},
            sParam[11], sParam[17], sParam[14], sParam[15]);
        int iNumOfErr = evtcal.getNumOfErr();
        String sError = evtcal.getError();
        evtcal.disconnect();

        if(iNumOfErr==0)
        {
          if(sParam[14].equals("ADD"))
          {
             FileOutputStream fileOut = new FileOutputStream(saveFile);
             fileOut.write(dataBytes, startPos, (endPos - startPos));
             fileOut.flush();
             fileOut.close();
          }
          else
          {
             File f = new File(saveFile);
             if(f.exists()) { f.delete(); }
          }
        }
        else { System.out.println(sError);
        }
    }
  }

  //String sUrl = "EvtAdvLst.jsp?Event=" + sParam[12] + "&From=" + sParam[13];
  //response.sendRedirect(sUrl);
%>

<script LANGUAGE="JavaScript1.2">
var Event = "<%=sParam[12]%>";
var From = "<%=sParam[13]%>";
reStart();
//--------------------------------------------------------
// restart page after entry done
//--------------------------------------------------------
function reStart()
{
  var url = "EvtAdvLst.jsp?Event=" + Event.replaceSpecChar()
          + "&From=" + From;
  //alert(url)
  window.location.href = url;
}
//--------------------------------------------------------
// Replace &, # signs on escape sequense;
//--------------------------------------------------------
function String.prototype.replaceSpecChar()
{
    var s = this;
    var newStr = "";
    var obj = ["'", "#", "&", "%"];
    for(var i=0; i < s.length; i++)
    {
       var l = s.substring(i,i+1);
       for(var j=0; j < obj.length; j++)
       {
          if(l == obj[j])  {  l = escape(obj[j]); break; }
       }
       newStr += l;
    }
    return newStr;
}
//--------------------------------------------------------
// show  ',  &, # charachters on screen
//--------------------------------------------------------
function String.prototype.showSpecChar()
{
    var s = this;
    var chk = ["%27", "%26", "%23", "%25"];
    var exc = ["&#39;", "&#38;", "&#35;", "&#37;"];
    for(var i=0; i < chk.length; i++)
    {
       while (s.match(chk[i])) { s = s.replace(chk[i], unescape(exc[i])); }
    }
    return s;
}

</script>

