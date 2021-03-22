<%@ page import="grassroots.GrootSv, java.util.*, java.io.*"%>
<%
   String sStr = request.getParameter("Str");
   String sYear = request.getParameter("Year");
   String sHalf = request.getParameter("Half");
   String sType = request.getParameter("Type");
   String sBdg = request.getParameter("Bdg");
   String sDate = request.getParameter("Date");
   String sId = request.getParameter("Id");
   String sSpend = request.getParameter("Spend");
   String sDesc = request.getParameter("Desc");
   String sAction = request.getParameter("Action");
      
   GrootSv grrotsv = null;
   int iNumOfErr = 0;
   String sError = null;
   
   //System.out.println("Action = " + sAction);   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{	
		
	grrotsv = new GrootSv(); 

   	String sUser = session.getAttribute("USER").toString();
   	
    if(sAction.equals("ADDBDG") || sAction.equals("UPDBDG"))
    {
    	grrotsv.saveStrBdg(sStr, sYear, sHalf, sType, sBdg, sAction, sUser);
    }
    else if(sAction.equals("ADDEXP") || sAction.equals("UPDEXP") || sAction.equals("DLTEXP"))
    {
    	//System.out.println("\n" + sStr + "|" + sYear + "|" + sHalf + "|" + sDate + "|" + sId
    	//   + "|" + sSpend + "|" + sDesc + "|" + sAction + "|" + sUser);
    	grrotsv.saveStrExp(sStr, sYear, sHalf, sDate, sId, sType, sSpend, sDesc, sAction, sUser);
    }        
    
   // special Order Item Entry
   grrotsv.disconnect();  

%>
Action=<%=sAction%>
<SCRIPT language="JavaScript1.2">
   var Action = "<%=sAction%>";
   goBack();
//==============================================================================
// end employee availability to schedule
//==============================================================================
function goBack()
{
	if(Action == "ADDBDG" || Action == "UPDBDG"
		|| Action == "ADDEXP" || Action == "UPDEXP" || Action == "DLTEXP")
	{ 
		parent.location.reload(); 
	}
}
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>  







