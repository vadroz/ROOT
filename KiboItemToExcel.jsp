<%@ page import="mozu_com.KiboItemToExcel ,java.util.*, java.text.*"%>
<%
   	response.setContentType("application/vnd.ms-excel");
   
	String sSrchDiv = request.getParameter("Div");
	String sSrchDpt = request.getParameter("Dpt");
	String sSrchCls = request.getParameter("Cls");
	String sSrchVen = request.getParameter("Ven");
	String sSite = request.getParameter("Site");
	String sFrom = request.getParameter("From");
	String sTo = request.getParameter("To");
	String sFromIP = request.getParameter("FromIP");
	String sToIP = request.getParameter("ToIP");
	String sSrchDownl = request.getParameter("MarkDownl");
	String sExcel = request.getParameter("Excel");
	String sSelParent = request.getParameter("Parent");
	String sSelPon = request.getParameter("Pon");
	String sSelModelYr = request.getParameter("ModelYr");
	String sSelMapExpDt = request.getParameter("MapExpDt");
	String sInvAvl = request.getParameter("InvAvl");
	String sInvStr = request.getParameter("InvStr");
	String sMarkedWeb = request.getParameter("MarkedWeb");
	String sLogSize = request.getParameter("LogSize");
	String [] sAttr = request.getParameterValues("Attr");
        
	if(sSelModelYr==null) { sSelModelYr = " "; }
	if(sSelMapExpDt==null) { sSelMapExpDt = " "; }

	if(sAttr==null){ sAttr = new String[]{" ", " ", " " }; }    

	if(sFromIP==null) { sFromIP = "ALL"; }
	if(sToIP==null) { sToIP = "ALL"; }

	String sSort = request.getParameter("Sort");
	if(sSort==null) { sSort = "ITEM"; }

	if(sLogSize==null) { sLogSize = "0"; }


	if(sInvAvl==null){ sInvAvl = "NONE"; }
	if(sInvStr==null){ sInvStr = "ALL"; }
	if(sMarkedWeb==null) { sMarkedWeb = "N"; }
	
	
	//----------------------------------
	// Application Authorization
	//----------------------------------
	if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
	{
	   response.sendRedirect("SignOn1.jsp?TARGET=MozuParentLst.jsp");
	}
	else
	{
	    String sUser = session.getAttribute("USER").toString();
	    
	    KiboItemToExcel itmLst = new KiboItemToExcel(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen
    		, sSite, sFrom, sTo, sFromIP, sToIP, sSrchDownl, sSelParent, sSelPon, sSelModelYr
    		, sSelMapExpDt, sInvAvl, sInvStr, sMarkedWeb, sAttr, sSort, sUser);
		    
   	
   		out.println("RCI PART NO.\t VENDOR PART NO. \t RCI ITEM DESC \t YEAR \t WEB NAME \t COLOR NAME \t WEB DESCRIPTION \t WEB FEATURES \t WEB TECH SPECS \t PRODUCT DIMENSIONS \t PHOTO");

   		int iNumOfItm = itmLst.getNumOfItm(); 
   		
    	for(int i=0; i < iNumOfItm; i++)
    	{
       		itmLst.setDetail();
       		String sCls = itmLst.getCls();
       		String sVen = itmLst.getVen();
       		String sSty = itmLst.getSty();
       		String sClr = itmLst.getClr();
       		String sDesc = itmLst.getDesc();
       		String sVenSty = itmLst.getVenSty();
       		String sPoClrNm = itmLst.getPoClrNm();
       
       		out.print(sCls + sVen + sSty + "-" + sClr);
       		out.print("\t " + sVenSty);
       		out.print("\t " + sDesc);
       		out.println("\t\t\t " + sPoClrNm);
    	}
    
    	itmLst.disconnect();
%>

<%}%>
