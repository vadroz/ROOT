<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.io.*, java.util.*"%>
<%
   String [] sParam = new String[8];
   String [] sPrmNm = new String[8];
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
          //out.println(i + ". " + sParam[i] + "<br>");
        }

        int pos=0;
        int startPos = 0;
        int endPos = 0;

        saveFile = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/AdPlans/";
        //saveFile = "/var/tomcat4/webapps/ROOT/Advertising/";

        if(sParam[4].equals("ADD"))
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
           while(sParam[2].indexOf(sASCII[i]) > 0)
           {
              int j = sParam[2].indexOf(sASCII[i]);
              sParam[2] = sParam[2].substring(0, j) + sSpecChar[i] + sParam[2].substring(j+3);
           }
        }

        String sStmt = null;
        if(sParam[4].equals("ADD"))
        {
           sStmt = "insert into rci.AdPlnDoc values("
             + " default, '" + sParam[1] + "','" + sParam[sParam.length-1] + "','"
             + sParam[2] + "','" + sParam[5] + "', current date, current time" + ")"
           ;
        }
        if(sParam[4].equals("DLT"))
        {
           sStmt = "delete from rci.AdPlnDoc "
             + " where PDDOCID=" + sParam[3]
            ;
        }

        RunSQLStmt sql_PlanDoc = new RunSQLStmt();
        int irs = sql_PlanDoc.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        sql_PlanDoc.disconnect();

        if(sParam[4].equals("ADD"))
        {
             //out.print(saveFile);
             FileOutputStream fileOut = new FileOutputStream(saveFile);
             fileOut.write(dataBytes, startPos, (endPos - startPos));
             fileOut.flush();
             fileOut.close();
        }
        else
        {
             //out.print(saveFile);
             File f = new File(saveFile);
             if(f.exists()) { f.delete(); }
        }
    }
  }
%>

<script LANGUAGE="JavaScript1.2">
reStart();
//--------------------------------------------------------
// restart page after entry done
//--------------------------------------------------------
function reStart()
{
  var url = "AdMktPlanDoc.jsp";
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
