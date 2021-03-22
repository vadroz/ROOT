<%@ page import="mozu_com.KiboItemPropToExcel, java.util.*, java.text.*"%>
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
	String sProdType = request.getParameter("ProdType");
        
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
	    
	    //out.println("sInvAvl=" + sInvAvl + "| sInvStr=" + sInvStr + "| sMarkedWeb=" + sMarkedWeb +  "| sAttr=" + sAttr);
	    
	    KiboItemPropToExcel itmLst = new KiboItemPropToExcel(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen
    		, sSite, sFrom, sTo, sFromIP, sToIP, sSrchDownl, sSelParent, sSelPon, sSelModelYr
    		, sSelMapExpDt, sInvAvl, sInvStr, sMarkedWeb, sAttr, sProdType, sSort, sUser);
		  	
	    
   		out.print("RCI PART NO.\t VENDOR PART NO. \t Product Type \t RCI ITEM DESC"
   		 
   		 + "\t Product Type \t Model \t Model Year \t Age \t MF" 
   		 + " \t Shp Wgth \t Shp Len \t Shp Width \t Shp Hgt"   		 
   		 );
   		
   		int iNumOfProp = itmLst.getNumOfProp();
   		String [] sArrProp = new String[iNumOfProp]; 
   		
   		for(int i=0; i < iNumOfProp; i++)
   	   	{
   			itmLst.setProp();
   	      	String sPropId = itmLst.getPropId();
   	     	sArrProp[i] = sPropId;
   	      	String sPropType = itmLst.getPropType();
   	      	String sPropName = itmLst.getPropName();
   	      	String sPropAttr = itmLst.getPropAttr();
   	      	String sPropIpAttr = itmLst.getPropIpAttr();
   	      	String sPropIpAttrNm = itmLst.getPropIpAttrNm();
   	      	String sPropIpLvl = itmLst.getPropIpLvl();
   	      	out.print(" \t " + sPropName );
   	   	}
   		
   		out.print(" \t WEB NAME \t WEB DESC \t Short Desc \t Full Desc \t ExtName \t MetaTag");
   		
   		out.println("");

   		int iNumOfItm = itmLst.getNumOfItm(); 
   		
   		
    	for(int i=0; i < iNumOfItm; i++)
    	{
       		itmLst.setDetail();
       		String sCls = itmLst.getCls();
       		String sVen = itmLst.getVen();
       		String sSty = itmLst.getSty();
       		String sDesc = itmLst.getDesc();
       		String sVenSty = itmLst.getVenSty();
       		String sWebName = itmLst.getWebName();
            String sWebDesc = itmLst.getWebDesc();
            String sProdTy = itmLst.getProdTy();
            String sModel = itmLst.getModel();
            String sAge = itmLst.getAge();
            String sMfGen = itmLst.getMfGen();
            String sShortDesc = itmLst.getShortDesc();
            String sFullDesc = itmLst.getFullDesc();
            String sMdlYr = itmLst.getMdlYr();
            String sWeight = itmLst.getWeight();
            String sLength = itmLst.getLength();
            String sWidth = itmLst.getWidth();
            String sHeight = itmLst.getHeight();
            String sExtName = itmLst.getExtName();
            String sMetaTag = itmLst.getMetaTag();
                    
       		out.print(sCls + "-" + sVen + "-" + sSty);
       		out.print("\t " + sVenSty);
       		out.print("\t " + sProdType);
       		out.print("\t " + sDesc);
       		
       		out.print("\t " + sProdTy);
       		out.print("\t " + sModel);
       		out.print("\t " + sMdlYr);
       		out.print("\t " + sAge);
       		out.print("\t " + sMfGen );
       		out.print("\t " + sWeight );
       		out.print("\t " + sLength );
       		out.print("\t " + sWidth );
       		out.print("\t " + sHeight );
       		
       		for(int j=0; j < iNumOfProp; j++ )
            { 
       			itmLst.setItemProp(sArrProp[j]);
      			int iNumOfVal = itmLst.getNumOfVal();
      			String [] sValue = itmLst.getPropVal();
      			out.print("\t");
      			for(int k=0; k < iNumOfVal; k++)
      			{
      				out.print( sValue[k] );   
      			}
            }
       		
       	    out.print("\t " + sWebName);
       		out.print("\t " + sWebDesc);
       		out.print("\t " + sShortDesc);
       		out.print("\t " + sFullDesc);
       		out.print("\t " + sExtName);
       		out.print("\t " + sMetaTag);
       		
       		out.println("");
    	}
    
    	itmLst.disconnect();
%>

<%}%>
