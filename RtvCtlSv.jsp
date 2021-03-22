<%@ page import="rtvregister.RtvCtlSv, java.util.*, java.io.*"%>
<%
   String sVen = request.getParameter("Ven");
   String sStr = request.getParameter("Str");
   String sCtl = request.getParameter("Ctl");
   String sCommt = request.getParameter("Commt");
   String sAction = request.getParameter("Action");
   String sFile = request.getParameter("File");
   String sSts = request.getParameter("Sts");
   String sReason = request.getParameter("CtlReas");
   
   String [] sSku = request.getParameterValues("Sku");
   String [] sItmReas = request.getParameterValues("Reas");
   String [] sDefect = request.getParameterValues("Dft");
   String [] sItmCommt = request.getParameterValues("ICmt");
   String [] sQty = request.getParameterValues("Qty");
   
   String sPoNum = request.getParameter("PO");

   if(sVen == null || sVen == "") { sVen = "0"; }
   if(sStr == null || sStr == "") { sStr = "0"; }
   if(sCtl == null || sCtl == "") { sCtl = "0"; }
   if(sPoNum == null || sPoNum == "") { sPoNum = " "; }   
   if(sCommt == null || sCommt == "") { sCommt = " "; }
   
   RtvCtlSv ctlsv = null;
   int iNumOfErr = 0;
   String sError = null;
   
   System.out.println("Action = " + sAction);
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{	
	ctlsv = new RtvCtlSv(); 

   	String sUser = session.getAttribute("USER").toString();
   	
    if(sAction.equals("ADDCTL"))
    {
    	ctlsv.crtNewCtl(sVen, sStr, sCtl, sReason, sCommt, sAction, sUser); 
    }
    else if(sAction.equals("DLTCTL"))
    {   
    	ctlsv.dltCtl(sCtl, sAction, sUser);
    }       
    else if(sAction.equals("ADD_ITEM") || sAction.equals("DLT_ITEM") || sAction.equals("UPD_ITEM"))
    {
    	System.out.println(1 + " sku.len=" + sSku.length);    	
    	for(int i=0; i < sSku.length; i++ )
    	{
    		ctlsv.saveItem(sCtl, sStr, sSku[i], sItmReas[i], sDefect[i]
    			, " ", " ", "SUBMIT", " ", " ", sPoNum, sQty[i], sItmCommt[i], sAction, sUser);
    		System.out.println(2);
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
    	sFile = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/RTV/" + sFile;

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
    
   // special Order Item Entry
   ctlsv.disconnect();

%>

<SCRIPT language="JavaScript1.2">
   var Action = "<%=sAction%>";
   
   goBack();
//==============================================================================
// end employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.location.reload();
   }
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







