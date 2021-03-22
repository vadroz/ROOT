<%@ page import="java.util.*"%>
<%
	response.setHeader("Content-Encoding", "UTF-8");
	//response.setHeader("Content-Type","text/csv; charset=UTF-8");
	response.setContentType("text/csv; charset=UTF-8");
	response.setHeader("Content-Disposition","inline; filename=FlashSls.csv");

    String sHdr1 = request.getParameter("Hdr1");
    String sHdr2 = request.getParameter("Hdr2");
    String [] sDtl = request.getParameterValues("Dtl");
    int iLen = sDtl.length;
    String [] sArrHdr1 = sHdr1.split(",");
    String [] sArrHdr2 = sHdr2.split(",");  
    
    // header
    out.print(sHdr1); 
    out.print("\n");
    out.print(sHdr2);   
    out.print("\n");
    
    // details 
    for(int i=0; i < iLen; i++)
    {
    	out.print(sDtl[i]); 
    	out.print("\n");
    }
%>