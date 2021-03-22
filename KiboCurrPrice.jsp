<%@ page import="com.test.api.KiboItemCurrPrice, rciutility.CallAs400Pgm
, java.util.*, java.text.*"%>
<%

	String sSelParent = request.getParameter("Parent");
    String sAll = request.getParameter("All");
    String sResubmit  = request.getParameter("Resubmit");
    
    if(sAll == null || sAll.equals("") ){ sAll = "Single"; }
    if(sResubmit == null || sResubmit.trim().equals("")){ sResubmit = "Y"; }
	
    String sChild = "";	
	String sIpChlPrc = "";
	String sIpChlSls = "";
	String sKiboChlPrc = "";
	String sKiboChlSls = "";
	
	String sKiboParPrc = "";
	String sKiboParSls = "";
    
    if( !sResubmit.equals("Y") )
    {
		KiboItemCurrPrice mprod = new KiboItemCurrPrice("11961");
		mprod.setUpdAll(sAll.equals("All"));
		mprod.getIPItemWithNewPrice(sSelParent);
	
		sChild = mprod.getChild();	
		sIpChlPrc = mprod.getIpChlPrc();
		sIpChlSls = mprod.getIpChlSls();
		sKiboChlPrc = mprod.getKiboChlPrc();
		sKiboChlSls = mprod.getKiboChlSls();
	
		sKiboParPrc = mprod.getKiboParPrc();
		sKiboParSls = mprod.getKiboParSls();
    }
    else
    {	
    	String sCmd = "icls=" + sSelParent.substring( 0, 4) 
    		+ " and iven="  + sSelParent.substring( 4, 10) 
    		+ " and isty="  + sSelParent.substring( 10 ).trim();
    	
    	System.out.println("KiboCurrPrice ==> sCmd=" + sCmd);
    	
    	String [] sParam = new String[]{ sCmd, "VRQPGMR" };
        int [] iPrmLng = { 256, 10 };
    	CallAs400Pgm genXml = new CallAs400Pgm("RCI", "MOPRCXFPC", sParam, iPrmLng);  
    }
%>

<SCRIPT language="JavaScript1.2">
var child = [<%=sChild%>];
var ipChlPrc = [<%=sIpChlPrc%>];
var ipChlSls = [<%=sIpChlSls%>];
var kiboChlPrc = [<%=sKiboChlPrc%>];
var kiboChlSls = [<%=sKiboChlSls%>];

var kiboParPrc = "<%=sKiboParPrc%>";
var kiboParSls = "<%=sKiboParSls%>";

parent.setKiboPrc(child,ipChlPrc,ipChlSls,kiboChlPrc,kiboChlSls,kiboParPrc,kiboParSls);   

</SCRIPT>


