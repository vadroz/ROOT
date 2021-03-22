<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
	String sCls = request.getParameter("Cls");
	String sLen = request.getParameter("Len");
	String sWidth = request.getParameter("Width");
	String sHeight = request.getParameter("Height");
	String sWeight = request.getParameter("Weight");
	String sTxCat = request.getParameter("TxCat");
	String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") != null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();	
	
	boolean bExist = false;
	RunSQLStmt runsql = new RunSQLStmt();	
	
	if(sAction.equals("ADD_CLS"))
	{		
		// check if record exists
		String sExist = "select DcCls from rci.MODIMCLS where DcCls=" + sCls;	
		//System.out.println(sExist); 
		runsql.setPrepStmt(sExist);		   
		runsql.runQuery();
		if(runsql.readNextRecord()){bExist = true;}
		runsql.disconnect();
		
		
		
		if(!bExist)
		{
			String sInsert = "insert into rci.MODIMCLS values("
				 + sCls + "," + sLen + "," + sWidth + "," + sHeight + "," + sWeight
				 + ",'" + sUser + "', current date, current time"	
				 + ",'" + sTxCat + "'"
		   	     + ")";   	
			System.out.println(sInsert); 
			runsql = new RunSQLStmt();
			runsql.setPrepStmt(sInsert);		   
			int irs = runsql.runSinglePrepStmt(sInsert, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			runsql.disconnect();
			runsql = null;
		}
	}
	
	// delete existing records for selected year/quoter and score name 
	if(sAction.equals("DLT_CLS"))
	{		
	   	String sDelete = "delete from rci.MODIMCLS where DcCls=" + sCls;
	   	//System.out.println(sDelete);  
	   	runsql = new RunSQLStmt();
	   	runsql.setPrepStmt(sDelete);
	   	int irs = runsql.runSinglePrepStmt(sDelete, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	   	runsql.disconnect();
	}
	// delete existing records for selected year/quoter and score name 
	if(sAction.equals("UPD_CLS"))
	{		
	   	String sUpdate = "update rci.MODIMCLS set"
	   		+ " dclen=" + sLen
	   		+ ", dcwdt=" + sWidth
	   		+ ", dchgt=" + sHeight
	   		+ ", dctxcat='" + sTxCat + "'"	   		 
	   		+ ", dcRecUs='" + sUser + "'"
	   		+ ", dcRecDt=current date"
	   		+ ", dcRecTm=current time"	   		
			+ " where DcCls=" + sCls;
	   	//System.out.println(sUpdate);  
	   	runsql = new RunSQLStmt();
	   	runsql.setPrepStmt(sUpdate);
	   	int irs = runsql.runSinglePrepStmt(sUpdate, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	   	runsql.disconnect();
	}
	
	
%>
<html>
<SCRIPT>

var exist = <%=bExist%>;
var Action = "<%=sAction%>";
if(Action == "ADD_CLS" && exist){ parent.showError(exist);  }
else { parent.location.reload();  }

</SCRIPT>
</html>
<%
}
else
{%>
	<script>
	alert("Your session is expired. Please signon again.")
	</script>
<%}%>