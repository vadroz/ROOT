<%@ page import="storepettycash.StrPtyCashDayLog, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelStr = request.getParameter("Str");
   String sEndDate = request.getParameter("Date");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
     	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	SimpleDateFormat smpMdy = new SimpleDateFormat("MM/dd/yyyy");
	Date dEndDt = smpMdy.parse(sEndDate);	
	Date dStrDate = new Date(dEndDt.getTime() - 7 * 24 * 3600 * 1000);
		 
	System.out.println("dStrDate=" + dStrDate);
	
	StrPtyCashDayLog stptlog = new StrPtyCashDayLog(sSelStr, sEndDate, sUser);
	int iNumOfEnt = stptlog.getNumOfEnt();
	String [] sPaid = new String[iNumOfEnt];
  	String [] sCash = new String[iNumOfEnt];
  	String [] sCheck = new String[iNumOfEnt];
  	String [] sSpUser = new String[iNumOfEnt];
  	String [] sDate = new String[iNumOfEnt];
  	String [] sTime = new String[iNumOfEnt];
  	String [] sTotal = new String[iNumOfEnt];
  	String [] sBudget = new String[iNumOfEnt];
  	String [] sVar = new String[iNumOfEnt];
	 
	
	for(int i=0; i < iNumOfEnt; i++) 
	{        	    
		stptlog.setDayLog();
		
		String slogdt = stptlog.getDate();
      	Date dlogdt = smpMdy.parse(slogdt);
      	
      	//System.out.println("dlogdt=" + dlogdt + "\nCompareTo=" + dlogdt.compareTo(dStrDate));
      	sPaid[i] = stptlog.getPaid();
      	sCash[i] = stptlog.getCash();
      	sCheck[i] = stptlog.getCheck();
      	sSpUser[i] = stptlog.getUser();
      	sDate[i] = stptlog.getDate();
      	sTime[i] = stptlog.getTime();
      	sTotal[i] = stptlog.getTotal();
      	sBudget[i] = stptlog.getBudget();
      	sVar[i] = stptlog.getVar();      	
  	}
	
	String sPaidJsa = stptlog.cvtToJavaScriptArray(sPaid);
	String sCashJsa = stptlog.cvtToJavaScriptArray(sCash);
  	String sCheckJsa = stptlog.cvtToJavaScriptArray(sCheck);
  	String sSpUserJsa = stptlog.cvtToJavaScriptArray(sSpUser);
  	String sDateJsa = stptlog.cvtToJavaScriptArray(sDate);
  	String sTimeJsa = stptlog.cvtToJavaScriptArray(sTime);
  	String sTotalJsa = stptlog.cvtToJavaScriptArray(sTotal);
  	String sBudgetJsa = stptlog.cvtToJavaScriptArray(sBudget);
  	String sVarJsa = stptlog.cvtToJavaScriptArray(sVar);
%>
             
<html>  
<SCRIPT>
var str = "<%=sSelStr%>"
var paid = [<%=sPaidJsa%>];
var cash = [<%=sCashJsa%>];
var check = [<%=sCheckJsa%>];
var user = [<%=sSpUserJsa%>];
var date = [<%=sDateJsa%>];
var time = [<%=sTimeJsa%>];
var total = [<%=sTotalJsa%>];
var budget = [<%=sBudgetJsa%>];
var boxvar = [<%=sVarJsa%>]; 

parent.setLogList(str,paid,cash,check, user,date,time,total,budget,boxvar);

</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>
             