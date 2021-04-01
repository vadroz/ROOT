<%@ page import="posend.POWorkSheetList,java.util.*, posend.POUplDocSv,rciutility.SendMail
, java.util.*, java.io.*, rciutility.RunSQLStmt, java.sql.*"%>
<%
   String [] sParam = new String[11];
   String sPoNum = null;
   String sStr = null;
   String sExtension = null;
   String sRcvDt = null;
   String sEmp = null;
   String sNumCtn = null;
   String sNumUnt = null;
   String sInvNum = null;
   String sCommt = null;
   String sFileOut = null;
   
   if(sNumUnt == null || sNumUnt.equals("")){sNumUnt = "0";}
   if(sInvNum == null || sInvNum.equals("")){sInvNum = " ";}

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
        sParam[10] = file.substring(pos + 10, file.indexOf("\n", pos) - 2);
        sParam[10] = sParam[10].substring(sParam[10].lastIndexOf("\\")+1);
        //sParam[9] =  sParam[9].substring(sParam[9].lastIndexOf('.')+1);

        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;

        sPoNum = sParam[3].trim().substring(0, sParam[3].trim().lastIndexOf("|"));
        sStr = sParam[3].trim().substring(sParam[3].trim().lastIndexOf("|") + 1);
        sExtension = sParam[10].trim().substring(sParam[10].trim().lastIndexOf(".") + 1);
        sRcvDt = sParam[1].trim();
        sEmp = sParam[5].trim();
        sNumCtn = sParam[6].trim();
        sNumUnt = sParam[7].trim();
        sInvNum = sParam[8].trim();
        sCommt = sParam[9].trim();
        
        // find start and end position of file data
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        // format project id to 10 characters string
        String sTenDig = "0000000000";

        String sUser = session.getAttribute("USER").toString();
      
        // save next sequence for PO document in RCI/PODOCL
        POUplDocSv poupldoc = new POUplDocSv();
        poupldoc.savePODoc(sPoNum, sExtension, sRcvDt, sEmp, sNumCtn, sNumUnt, sInvNum, sCommt, sUser);
        String sSeq = poupldoc.getSeq();
        
        sFileName = "PO" + sPoNum + "_" + sSeq.trim() + "." + sExtension;
        
        sFileOut = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/PO_Pack_List/" + sFileName;
       
        System.out.println("File=" + sFileOut);
        
        fTo = new File(sFileOut);
        fTo.createNewFile();
        
        FileOutputStream fileOut = new FileOutputStream(sFileOut);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();
        
        // get employee name 
        String sStmt = "select ename from  rci.rciemp where erci=" + sEmp;
    	RunSQLStmt sql_Emp = new RunSQLStmt();
    	sql_Emp.setPrepStmt(sStmt);
    	ResultSet rs_Emp = sql_Emp.runQuery();
    	String sEmpNm = null;
    	if(sql_Emp.readNextRecord())
    	{
       		sEmpNm = sql_Emp.getData("ename").trim();       
    	}
    	sql_Emp.disconnect();
    	
    	POWorkSheetList polist = new POWorkSheetList();
    	polist.setPOWorkSheet(sPoNum, sUser);
        int iNumOfPo = polist.getNumOfPo();

        String msg = "<table border=1>"
          + "<tr>" 
          	+ "<th>ASN</th>"
          	+ "<th>ASN Date</th>"
          	+ "<th>QTY Shipped</th>"
          	+ "<th>QTY Recieved</th>"          	
          + "</tr>"	
         ;
         		
        if (iNumOfPo > 0)
        {
           polist.setPOArr();
           
           int iNumAsn = polist.getNumAsn();
           String [] sAsnQty = polist.getAsnQty();
           String [] sAsnNum = polist.getAsnNum();
           String [] sAsnDt = polist.getAsnDt();       
           String [] sAsnShpCtn = polist.getAsnShpCtn();
           String [] sAsnRcvCtn = polist.getAsnRcvCtn();
           String [] sAsnShpQty = polist.getAsnShpQty();
           String [] sAsnRcvQty = polist.getAsnRcvQty();
           String [] sAsnRcvUsr = polist.getAsnRcvUsr();
           
           for(int i=0; i < iNumAsn; i++)
           {
        	   msg += "<tr>" 
        			+ "<td>" + sAsnNum[i] + "</td>"
        			+ "<td>" + sAsnDt[i] + "</td>"
        			+ "<td>" + sAsnShpQty[i] + "</td>"
        			+ "<td>" + sAsnRcvQty[i] + "</td>"
        	    + "</tr>"	
        		         ;
           }
        }
        
        msg +=  "</table>";

        polist.disconnect();
        
        
        
        msg += "<table>"
          + "<tr><td>PO:</td><td><b>" + sPoNum + "</b></td>"
          + "<tr><td>Received Date:</td><td><b>" + sRcvDt + "</b></td>"
          + "<tr><td>Verified by Employee:</td><td><b>" + sEmp + " - " + sEmpNm + "</b></td>"
          + "<tr><td>Number of Cartons:</td><td><b>" + sNumCtn + "</b></td>"
          + "<tr><td>Number of Units:</td><td><b>" + sNumUnt + "</b></td>"
          + "<tr><td>Comment:</td><td><b>" + sCommt + "</b></td>"
         + "</table>"		
        ;		
               
        // No mail for Invice
        if(sInvNum.trim().equals(""))
        {
        
        	try {
        		SendMail sndmail = new SendMail();   
        		if(sStr.length() == 1){ sStr = "0" + sStr; }
        		String sFrAddr = "store" + sStr + "@sunandski.com";
        		String sToAddr = "inventorycontrol@sunandski.com" + ",csmith@sunandski.com";
        		
        		sndmail.sendWithAttachments(sFrAddr, sToAddr, null, null
        		, "PO: " + sPoNum + " - Vendor Packing List was added."
        		, msg
        		, new String[]{sFileOut});
        	}
        	catch(Exception e ) 
        	{
        		
        		e.printStackTrace();
        	}
        }
    }  
%>
<br>
<%for(int i=0; i < sParam.length; i++){%>
  <%=i%>. <%=sParam[i]%><br>
<%}%>
Po = <%=sPoNum%> Str = <%=sStr%><br>
Extension .<%=sExtension %><br>
Saved File <%=sFileOut%><br>

<SCRIPT language="JavaScript1.2">
 parent.location.reload();
</SCRIPT>

<%}
else{%>
<SCRIPT language="JavaScript1.2">
 alert("Please Logon again - your session is expired.")
</SCRIPT>
<%}%>