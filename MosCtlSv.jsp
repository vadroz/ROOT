<%@ page import="mosregister.MosCtlSv, java.util.*, java.io.*"%>
<%
   String sStr = request.getParameter("Str");
   String sCtl = request.getParameter("Ctl");
   String sEmp = request.getParameter("Emp");
   String sDefect = request.getParameter("Defect");
   String sCommt = request.getParameter("Commt");
   String sAction = request.getParameter("Action");
   String sFile = request.getParameter("File");
   String sSts = request.getParameter("Sts");
   
   String [] sSku = request.getParameterValues("Sku");
   String [] sItmReas = request.getParameterValues("Reas");
   String [] sItmCommt = request.getParameterValues("ICmt");
   String [] sQty = request.getParameterValues("Qty");
   
   String [] sName = request.getParameterValues("Name");
   String [] sAddr = request.getParameterValues("Addr");
   String [] sCity = request.getParameterValues("City");
   String [] sState = request.getParameterValues("State");
   String [] sZip = request.getParameterValues("Zip");
   String [] sPhone = request.getParameterValues("Phone");
   
   String [] sDate = request.getParameterValues("Date");   
   String [] sTime = request.getParameterValues("Time");
   String [] sPlace = request.getParameterValues("Place");
   String [] sArea = request.getParameterValues("Area");
   String [] sFoundBy = request.getParameterValues("FoundBy");
   String [] sMgr = request.getParameterValues("Mgr");
   String [] sTftCommt = request.getParameterValues("TftCommt");
   
   String [] sArrStr = request.getParameterValues("Str");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   
   String [] sItmDefect = request.getParameterValues("Dfc");
   
   String sPoNum = request.getParameter("PO");
   String sApproved = request.getParameter("Approved");
   
   String [] sSubCat = request.getParameterValues("SubCat");

   if(sStr == null || sStr == "") { sStr = "0"; }
   if(sCtl == null || sCtl == "") { sCtl = "0"; }
   if(sPoNum == null || sPoNum == "") { sPoNum = " "; }   
   if(sCommt == null || sCommt == "") { sCommt = " "; }     
   if(sEmp == null || sEmp == "") { sEmp = "0"; }
   if(sDefect == null || sDefect == "") { sDefect = " "; }
   if(sItmDefect == null) { sItmDefect = new String[0]; }
   
   MosCtlSv ctlsv = null;
   int iNumOfErr = 0;
   String sError = null;
   
   System.out.println("Action = " + sAction);   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{	
	String sNewCtl = null;
	
	ctlsv = new MosCtlSv(); 

   	String sUser = session.getAttribute("USER").toString();
   	
    if(sAction.equals("ADDCTL"))
    {
    	ctlsv.crtNewCtl(sStr, sCtl, sCommt, sEmp, sDefect, sAction, sUser); 
    	sNewCtl = ctlsv.getNewCtl(); 
    }
    else if(sAction.equals("DLTCTL"))
    {   
    	ctlsv.dltCtl(sCtl, sAction, sUser);
    }       
    else if(sAction.equals("ADD_ITEM") || sAction.equals("DLT_ITEM") || sAction.equals("UPD_ITEM"))
    {
    	//System.out.println("sItmDefect " + sItmDefect);
    	for(int i=0; i < sSku.length; i++ )
    	{
    		if(sName[i]==null || sName[i]==""){ sName[i] = " "; }
    		if(sAddr[i]==null || sAddr[i]==""){ sAddr[i] = " "; }
    		if(sCity[i]==null || sCity[i]==""){ sCity[i] = " "; }
    		if(sState[i]==null || sState[i]==""){ sState[i] = " "; }
    		if(sZip[i]==null || sZip[i]==""){ sZip[i] = " "; }
    		if(sPhone[i]==null || sPhone[i]==""){ sPhone[i] = " "; }
    		if(sSubCat[i]==null || sSubCat[i]==""){ sSubCat[i] = " "; }
    		
    		ctlsv.saveItem(sCtl, sStr, sSku[i], sItmReas[i], "Submitted", sQty[i], sItmCommt[i]
    		 , sName[i], sAddr[i], sCity[i], sState[i], sZip[i], sPhone[i]
    		 , sDate[i], sTime[i], sPlace[i], sArea[i], sFoundBy[i], sMgr[i], sTftCommt[i]
    		 , sEmp, sItmDefect, sSubCat[i], sAction, sUser);
    	}
    }
    else if(sAction.equals("ADD_CLM_COMMENT"))
    {   
    	ctlsv.saveCtlCom(sCtl, sCommt, sAction, sUser);
    }
    else if(sAction.equals("ADD_ITM_COMMENT"))
    {   
    	ctlsv.saveItemCom(sCtl, sSku[0], sCommt, sAction, sUser);
    }
    else if(sAction.equals("Chg_Ctl_Sts"))
    {
    	ctlsv.saveCtlSts(sCtl, sSts, sAction, sUser);
    }
    else if(sAction.equals("Chg_Itm_Sts"))
    {
    	ctlsv.saveItmSts(sCtl, sSku[0], sSts, sAction, sUser);    	
    }
    else if(sAction.equals("Dlt_Itm_Photo"))
    {       	
    	ctlsv.saveItemPic(sCtl, sSku[0], sFile, sAction, sUser);
    	sFile = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/MOS/" + sFile;

        try{
           File f = new File(sFile);
           if(f.exists() && f.isFile())
           {
             f.delete();
           }
           f = null;
        }
        catch( Exception e )
        {
           System.out.println(e.getMessage());
        }
    }
    else if(sAction.equals("APPROVED_CTL"))
    {   
    	ctlsv.saveApprv(sCtl, sApproved, sAction, sUser);
    }
    else if(sAction.equals("APPROVED_STR"))
    {   
    	ctlsv.saveApprvStr(sArrStr, sYear, sMonth, sAction, sUser);
    }
    
    
   // special Order Item Entry
   ctlsv.disconnect();  

%>

<SCRIPT language="JavaScript1.2">
   var Action = "<%=sAction%>";
   var Sts = "<%=sSts%>";
   goBack();
//==============================================================================
// end employee availability to schedule
//==============================================================================
function goBack()
{
	if(Action == "Chg_Ctl_Sts"){ parent.emailSbm(Sts); }
	else if(Action != "ADDCTL"){ parent.location.reload(); }	
	else { parent.showMosLst("<%=sNewCtl%>")  }
}
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>  







