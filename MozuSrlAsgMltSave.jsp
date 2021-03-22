<%@ page import="mozu_com.MozuSrlAsgSave , java.util.*"%>
<%
   String [] sSite = request.getParameterValues("Site");
   String [] sOrder = request.getParameterValues("Order");
   String [] sSku = request.getParameterValues("Sku");
   String [] sSts = request.getParameterValues("Sts");
   String [] sNote = request.getParameterValues("Note");
   String sAddr = request.getParameter("Addr");
   String [] sStr = request.getParameterValues("Str");
   String sFromStr = request.getParameter("FromStr");
   String sAsgQty = request.getParameter("AsgQ");
   String sSndQty = request.getParameter("SndQ");
   String sMail = request.getParameter("Mail");
   String sStrNote = request.getParameter("StrN");
   String [] sEmp = request.getParameterValues("Emp");
   String [] sQty = request.getParameterValues("Qty");
   String [] sSrn = request.getParameterValues("Srn");
   String [] sAction = request.getParameterValues("Action");
   String [] sOrdLst = request.getParameterValues("OrdL");
   String [] sSiteLst = request.getParameterValues("SiteL");
   String [] sArg = request.getParameterValues("Arg");
   String [] sExcl = request.getParameterValues("Excl");
   String [] sReas = request.getParameterValues("Reas");
   String sPackId = request.getParameter("PackId");
   String sLastArg = request.getParameter("LastArg");
   String sRtvStr = request.getParameter("RtvStr");

    
   if(sLastArg == null){sLastArg = "N";}
   if(sQty == null){sQty = new String[sOrder.length]; for(int i=0; i < sOrder.length; i++){ sQty[i]="0"; } }
   if(sSts == null){sSts = new String[sOrder.length]; for(int i=0; i < sOrder.length; i++){ sSts[i]=" "; } }
   if(sNote == null){sNote = new String[sOrder.length]; for(int i=0; i < sOrder.length; i++){ sNote[i]=" "; }}
   if(sAction == null){sAction = new String[sOrder.length]; for(int i=0; i < sOrder.length; i++){ sAction[i]=" "; } }
   if(sArg == null){sArg = new String[sOrder.length]; for(int i=0; i < sOrder.length; i++){ sArg[i]="0"; } }
   if(sExcl == null){sExcl = new String[sOrder.length];for(int i=0; i < sOrder.length; i++){ sExcl[i]=" "; } }
   if(sReas == null){sReas = new String[sOrder.length]; for(int i=0; i < sOrder.length; i++){ sReas[i]=" "; } }    
   if(sRtvStr == null || sRtvStr == ""){sRtvStr = " ";}
    
  
   System.out.println("sAction=" + sAction[0]);
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   String sUser = session.getAttribute("USER").toString();   
   
   MozuSrlAsgSave itmasgsav = new MozuSrlAsgSave();
   	for(int i=0; i < sSite.length; i++)
   	{
   		String [] aSrn = new String[]{sSrn[i]}; 
   		if(sAction[i].equals("CHGSTRSTS") || sAction[i].equals("FIXSTRSTS"))
   		{
     		/*System.out.println(sOrder[i] + " " + sSku[i] + " " + sSts[i] 
     			+ " aSrn=" + aSrn + " sUser=" + sUser + " sEmp=" + sEmp 
     			+ " sQty=" + sQty + " sNote=" + sNote + " sAction=" + sAction[i]);
     		*/
     		if(sOrder[i].equals("MARKED")){itmasgsav.saveMarkedOrder(sSiteLst, sOrdLst); }
     		
     		itmasgsav.saveStrSts(sSite[i], sOrder[i], sSku[i], sStr[i], sSts[i], aSrn, sEmp[i]
     			, sQty[i], sNote[i], sAction[i], sUser);

     		// add item to exclude from inventory
     		if(sExcl[i].equals("Y") && itmasgsav.getNumOfErr() == 0)
     		{
        		itmasgsav.saveExclded(sSite[i], sOrder[i], sSku[i], sStr[i], sQty[i]
        				, sEmp[i], sReas[i], sUser);
     		}
     
     		if(!sRtvStr.equals(" "))
     		{
    	 		itmasgsav.saveRtv(sSite[i], sOrder[i], sSku[i], sStr[i], sEmp[i]
    	 				, sRtvStr, sUser);
     		}
   		}
   		else if(sAction[i].equals("REASSIGN"))
   		{	   
       		itmasgsav.saveReassign(sSite[i], sOrder[i], sSku[i], aSrn, sStr[i], sFromStr, sSts[i]
       				, sQty[i], sEmp[i], sNote[i], sAction[i], sUser);
   		}
   		else if(sAction[i].equals("QUICKSHIP"))
   		{
       		itmasgsav.saveQuickCompl(sSite[i], sOrder[i], sSku[i], aSrn, sStr[i], sFromStr
       				, sSts[i], sQty[i], sEmp[i], sNote[i], sAction[i], sUser);
   		}
   		else if(sAction[i].equals("ADDCNL"))
   		{
     		itmasgsav.saveCnl(sSite[i], sOrder[i], sSku[i], aSrn, sStr[i], sEmp[i]
     				, sNote[i], sAction[i], sUser);
   		}
   		else if(sAction[i].equals("SENDEMAIL"))
   		{
     		itmasgsav.sendEmail(sSite[i], sOrder[i], sSku[i], sStr[i], sAddr, sNote[i]
     				, sAction[i], sUser);
   		}
   		else if(sAction[i].equals("CHGSTS"))
   		{
     		itmasgsav.saveSts(sSite[i], sOrder[i], sSku[i], sSts[i], sEmp[i]
     				, sNote[i], sAction[i], sUser);
   		}
   		else if(sAction[i].equals("ADDSKUNOTE") || sAction[i].equals("ADDSTRNOTE"))
   		{
     		itmasgsav.saveNote(sSite[i], sOrder[i], sSku[i], sStr[i], sNote[i],sAction[i],sUser);
   		}
   		else if(sAction[i].equals("ADDSTRMAIL"))
   		{
       		itmasgsav.saveNote(sSite[i],sOrder[i],sSku[i],sStr[i],sNote[i],sAction[i],sUser);
   		}   
   		else if(sAction[i].equals("PostPackId"))
   		{
	   		//System.out.println(" i=" + i + " " + sSite[i] + "|" + sOrder[i] + "|" + sSku[i] + "|" + sStr[i] + "|" + sSrn[i]
		  	//	+ "|" + sEmp[i] + "|" + sPackId + "|" + sAction[i] + "|" + sUser);
	   		itmasgsav.savePackID(sSite[i], sOrder[i], sSku[i], sStr[i], sSrn[i]
	   				, sEmp[i], sPackId, sAction[i], sUser);
	   		//System.out.println("sSite.length=" + sSite.length);
	   		if(i == sSite.length - 1)	   
	   		{   
		  		//System.out.println("promoteToShipped ==> " + sOrder + "|" + sStr + "|" + sEmp + "|" 
	        	//	+ sPackId + "|" + sUser);
		  		itmasgsav.promoteToShipped(sSite[i], sOrder[i], sStr[i], sEmp[i], sPackId, sUser);
	   		}
   		}
   		else if(sAction[i].equals("RePrtPackId"))
   		{
	   		//System.out.println("sPackId=" + sPackId);
	   		itmasgsav.reprtPackID(sPackId, sUser);
   		} 	   
   		else
   		{
      		System.out.println("Wrong action");      
   		}
   	}   		
   	int iNumOfErr = itmasgsav.getNumOfErr();
   	String sError = itmasgsav.getErrorJsa();
   		
   // special Order Item Entry
   itmasgsav.disconnect();
   itmasgsav = null;
%>
<SCRIPT language="JavaScript1.2">
   var NumOfErr = "<%=iNumOfErr%>";
   var Error = [<%=sError%>];

   var qty = "<%=sQty%>";
   var sts = "<%=sSts%>";
   var note = "<%=sNote%>";
   var action = "<%=sAction[0]%>";
   var sku = "<%=sSku%>";
   var arg = "<%=sArg%>";
      
   if(NumOfErr == 0){   goBack(); }
   else { dispError(); }
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      if(action == "CHGSTRSTS" || action == "FIXSTRSTS" || action == "ADDCNL" || action == "SENDEMAIL" || action == "PostPackId"
    	  || action == "RePrtPackId"  )
      {
          //parent.updStrProp(sku, sts, qty, action);
          parent.restart(arg);
      }
      else if(action == "REASSIGN") { parent.restart(); }
      else if(action == "QUICKSHIP") { parent.restart(); }
      else if(action == "CHGSTS") { parent.restart(); } //updStsProp(sts, action); }
      else if(action == "ADDSKUNOTE" || action == "ADDSTRNOTE" || action == "ADDSTRMAIL")
      {
         parent.updStrProp(note, action);  
      }

      parent.reuseFrame();
   }

//==============================================================================
// send employee availability to schedule
//==============================================================================
function dispError()
{
   parent.rtnWithError(arg, Error);
}
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

