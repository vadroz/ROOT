<%@ page import="rciutility.ExecuteAs400Cmd, java.util.*, java.util.concurrent.TimeUnit"%>
<%
	String sStr = request.getParameter("Str");
    
	ExecuteAs400Cmd cmd = new ExecuteAs400Cmd();
	
	if(sStr.length() == 1){ sStr = "0" + sStr; } 
	
	String sPrinter = "S" + sStr + "OUTQ";
	
	cmd.runAS400Cmd("endwtr " + sPrinter + " *immed" );
	
	boolean bSuccess = cmd.getSuccess();
	int iNumOfMsg  = cmd.getNumOfMsg();
	String [] sMsgText = cmd.getMsgText();
	String [] sMsgId = cmd.getMsgId();
	String [] sMsgSeverity = cmd.getMsgSeverity();

	for(int i=0; i < iNumOfMsg; i++)
	{
	  System.out.println("id=" + sMsgId[i] + " severity=" + sMsgSeverity[i]  
		+ "\nMsg = " + sMsgText[i]
	  );
	}
	
	System.out.println(" success=" + bSuccess);
	
	TimeUnit.SECONDS.sleep(6);
	
	cmd.runAS400Cmd("STRRMTWTR " + sPrinter);  

	bSuccess = cmd.getSuccess();
	iNumOfMsg  = cmd.getNumOfMsg();
	sMsgText = cmd.getMsgText();
	sMsgId = cmd.getMsgId();
	sMsgSeverity = cmd.getMsgSeverity();

	for(int i=0; i < iNumOfMsg; i++)
	{
	  System.out.println("id=" + sMsgId[i] + " severity=" + sMsgSeverity[i]  
		+ "\nMsg = " + sMsgText[i]
	  );
	}
	
	System.out.println(" success=" + bSuccess);
	
	cmd.disconnect();
%>
<script>
var success = <%=bSuccess%>;

parent.showMsg(success);

</script>
