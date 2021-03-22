<%@ page import="java.io.*, java.util.*, eventcalendar.EvtAdvEnt"%>
<%
   String [] sParam = new String[2];
   String [] sPrmNm = new String[2];
   String saveFile = null;
   String event = "";
   String from = ""; 
   String advid = ""; 
   String medtype = "";  
   String medid = ""; 
   String frdate = "";
   String todate = "";
   String str = "";
   String commt = "";
   String doc = "";
   String action = "";
   String user = "";

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
        //out.println(file + "<br>");

        int lastIndex = contentType.lastIndexOf("=");
        String boundary = contentType.substring(lastIndex + 1,contentType.length());
        int iBndLng = boundary.length();

        int max = sParam.length-1;
        //out.println("max=" + max + "<br>");
        for(int i=0, p1=0, p2=0; i< max;i++)
        {
          if (p1 == 0)
          {
             p2 = file.indexOf(boundary, p1) +  iBndLng;
             p1 = p2+1;
          }

          // parameter name
          int p3 = file.indexOf("name=\"", p2) + 6;
          int p4 = file.indexOf('"', p3);
          sPrmNm[i] = file.substring(p3, p4);
          //out.print(file.substring(p3, p4) + "|");

          p2 = file.indexOf(boundary, p1) +  iBndLng;
          p1 = file.substring(p1, p2-iBndLng-4).lastIndexOf('"') + p1 + 1;
          sParam[i] = file.substring(p1, p2-iBndLng-4).trim();
          p1 = p2+1;
          //System.out.println(i + ". " + sParam[i] + "<br>");
        }

        int pos=0;
        int startPos = 0;
        int endPos = 0;
        
        //System.out.println(sParam[0].length());
        
        int [] len = new int[]{ 50, 10, 10, 2, 10, 10, 10, 250, 100, 256, 10, 10 };
        event = sParam[0].substring(0, len[0]);
        from = sParam[0].substring(len[0], len[0] + len[1]); 
        advid = sParam[0].substring(len[0] + len[1], len[0] + len[1] + len[2]); 
        medtype = sParam[0].substring(len[0] + len[1] + len[2], len[0] + len[1] + len[2] + len[3]);  
        medid = sParam[0].substring(len[0] + len[1] + len[2] + len[3], len[0] + len[1] + len[2] + len[3] + len[4]); 
        frdate = sParam[0].substring( len[0] + len[1] + len[2] + len[3] + len[4]
        		, len[0] + len[1] + len[2] + len[3] + len[4] + len[5]);
        todate = sParam[0].substring(len[0] + len[1] + len[2] + len[3] + len[4] + len[5]
        		, len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6]);
        str = sParam[0].substring(len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6]
        		, len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7]);
        commt = sParam[0].substring(len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7]
        , len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7] + len[8]);
        doc = sParam[0].substring(len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7] + len[8]
        , len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7] + len[8] + len[9]);
        action = sParam[0].substring(len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7] + len[8] + len[9]
        , len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7] + len[8] + len[9] + len[10]);
        user = sParam[0].substring(len[0] + len[1] + len[2] + len[3] + len[4] + len[5] + len[6] + len[7] + len[8] + len[9] + len[10]);
        
        /*System.out.println(event + "|" + from + "|" + advid + "|" + medtype + "|" + medid
     	 + "|" + frdate + "|" + todate + "|" + str + "|" + commt + "|" 
     	 + doc + "|" + action  + "|" + user);
        */
        String [] sStrArr = new String[50];
        for(int i=0; i < 50; i++)
        {
        	int beg = i * 5;
        	int end = beg + 5;
        	if(i < 50) { sStrArr[i] = str.substring(beg, end); }
        	else{ sStrArr[i] = str.substring(beg);  }
        	//System.out.print(" " + sStrArr[i]);
        }
        
        
        saveFile = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Advertising/";
        
        if(action.trim().equals("ADD"))
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
           while(doc.indexOf(sASCII[i]) > 0)
           {
              int j = doc.indexOf(sASCII[i]);
              doc = doc.substring(0, j) + sSpecChar[i] + doc.substring(j+3);
           }
        }
        
        for(int i=0; i < 4; i++)
        {
           while(event.indexOf(sASCII[i]) > 0)
           {
              int j = event.indexOf(sASCII[i]);
              event = event.substring(0, j) + sSpecChar[i] + event.substring(j+3);
           }
        }

        int iNumOfErr = 0;
        String sError = "";
        EvtAdvEnt evtcal = new EvtAdvEnt();
        System.out.println(event);
        evtcal.savEvtAdvByMedia(event, from, advid, medtype, medid, frdate, todate
          , sStrArr, commt, doc, action, user);
        iNumOfErr = evtcal.getNumOfErr();
        sError = evtcal.getError();


        if(iNumOfErr==0)
        {
          if(action.trim().equals("ADD"))
          {
             //out.print(saveFile);
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
var Event = "<%=event.trim()%>";
var From = "<%=from%>";
reStart();
//--------------------------------------------------------
// restart page after entry done
//--------------------------------------------------------
function reStart()
{
  var url = "EvtAdvLst.jsp?Event=" + Event.replaceSpecChar()
          + "&From=" + From;
  //alert(url + " ==> " + Event)
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
