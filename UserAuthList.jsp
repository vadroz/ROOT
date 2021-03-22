<%@ page import="rciutility.CallAs400SrvPgmSup,rciutility.RunSQLStmt
, java.text.SimpleDateFormat, java.sql.*, java.util.*, java.text.*"%>
<%
String sCode = request.getParameter("Code");
String sSelUser = request.getParameter("User");
String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sUser = "";
    String sStr = "";
    String sName = "";
    String sTerm = "";
    String sDept = "";
    String sTitle = "";
    String sLastDt = "";
    String sCommt = "";
    
    String sAppl = "";
    
    String sMenu = "";
    String sParent = "";
    String sSort = "";
    String sType = "";
    String sUrl = "";
		
    CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
    
	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();

	// get list of user by authorization code
	if(sAction.equals("UserByCode"))
	{
    	String sPrepStmt = "select PUUSER,PUSTR"
    		+ ", (select ename from Rci.rciemp where erci=PUAUTH) as ename"
    		+ ", (select esepr from Rci.rciemp where erci=PUAUTH) as esepr"
    		+ ", (select estat from Rci.rciemp where erci=PUAUTH) as estat"
    		+ ", (select etitl from Rci.rciemp where erci=PUAUTH) as etitl"
    		+ ", PUSODT,PUCOMT"
    		+ " from rci.Pruser"
    		+ " where exists(select 1 from rci.PrUserAp where UaUser=PuUser" 
    		+ " and UaAppl='" + sCode + "')"
    		+ " order by PUUSER";

        //System.out.println(sPrepStmt);

    	SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
    	SimpleDateFormat sdfUSA = new SimpleDateFormat("MM/dd/yyyy");

    
    	runsql.setPrepStmt(sPrepStmt);
    	runsql.runQuery();
    
    	Vector<String> vUser = new Vector<String>();
    	Vector<String> vStr = new Vector<String>();
    	Vector<String> vName = new Vector<String>();
    	Vector<String> vTerm = new Vector<String>();
    	Vector<String> vDept = new Vector<String>();
    	Vector<String> vTitle = new Vector<String>();
    	Vector<String> vLastDt = new Vector<String>();    
    	Vector<String> vCommt = new Vector<String>();    
    
    	while(runsql.readNextRecord())
    	{       
       		vUser.add(runsql.getData("PUUSER").trim());
       		vStr.add(runsql.getData("PUSTR").trim());
       
 		    String sValue = runsql.getData("ename");
       		if(sValue == null){ sValue = ""; }
       		vName.add(sValue.trim());
       
       		sValue = runsql.getData("esepr");
       		if(sValue == null){ sValue = ""; }
       		vTerm.add(sValue.trim());
       
       		sValue = runsql.getData("estat");
       		if(sValue == null){ sValue = ""; }
       		vDept.add(sValue.trim());
	       
    		sValue = runsql.getData("etitl");
       		if(sValue == null){ sValue = ""; }       
       		vTitle.add(sValue.trim());
       
       		sValue = runsql.getData("PUSODT");
       		if(sValue == null){ sValue = ""; }
       		vLastDt.add(sValue.trim());
       
       		sValue = runsql.getData("pucomt");
       		if(sValue == null){ sValue = ""; }       
       		sValue = sValue.replaceAll("'", "`");
       		vCommt.add(sValue.trim());
    	}
    		
        
    	sUser = srvpgm.cvtToJavaScriptArray((String[]) vUser.toArray(new String[vUser.size()]));
    	sStr = srvpgm.cvtToJavaScriptArray((String[]) vStr.toArray(new String[vStr.size()]));
    	sName = srvpgm.cvtToJavaScriptArray((String []) vName.toArray(new String[vName.size()]));
    	sTerm = srvpgm.cvtToJavaScriptArray((String []) vTerm.toArray(new String[vTerm.size()]));
    	sDept = srvpgm.cvtToJavaScriptArray((String []) vDept.toArray(new String[vDept.size()]));
    	sTitle = srvpgm.cvtToJavaScriptArray((String []) vTitle.toArray(new String[vTitle.size()]));
    	sLastDt = srvpgm.cvtToJavaScriptArray((String []) vLastDt.toArray(new String[vLastDt.size()]));
    	sCommt = srvpgm.cvtToJavaScriptArray((String []) vCommt.toArray(new String[vCommt.size()]));
	}   
	
	// get list of authorization code by user
	else if(sAction.equals("CodebyUser"))
	{
	   	String sPrepStmt = "select UaAppl"
	   		+ " from rci.PruserAp"
	   		+ " where UaUser='" + sSelUser + "'"
	   		+ " order by UaAppl";
	    //System.out.println(sPrepStmt);
    	
    	runsql.setPrepStmt(sPrepStmt);
    	runsql.runQuery();
    
    	Vector<String> vAppl = new Vector<String>();
    	
    	while(runsql.readNextRecord())
    	{       
       		vAppl.add(runsql.getData("UAAPPL").trim());       		
    	}
    	sAppl = srvpgm.cvtToJavaScriptArray((String[]) vAppl.toArray(new String[vAppl.size()]));    	
	} 
	
	// get list of menus by authorization code
	else if(sAction.equals("MenubyCode"))
	{
	   	String sPrepStmt = "select IMMENU,IMPARENT,IMSORT,IMTYPE,IMURL"
	   		+ " from rci.InetMenu"
	   		+ " where IMAPPL='" + sCode + "'"
	   		+ " order by IMPARENT, IMSORT, IMMENU";
	    System.out.println(sPrepStmt);
	   	
	   	runsql.setPrepStmt(sPrepStmt);
	   	runsql.runQuery();
	   
	   	Vector<String> vMenu = new Vector<String>();
	    Vector<String> vParent = new Vector<String>();
	    Vector<String> vSort = new Vector<String>();
	    Vector<String> vType = new Vector<String>();
	    Vector<String> vUrl = new Vector<String>();
	   	
	   	while(runsql.readNextRecord())
	   	{       
	   		vMenu.add(runsql.getData("immenu").trim());
	   		vParent.add(runsql.getData("imparent").trim());
	   		vSort.add(runsql.getData("imsort").trim());
	   		vType.add(runsql.getData("imtype").trim());
	   		vUrl.add(runsql.getData("imurl").trim());
	   	}
	   	
	   	sMenu = srvpgm.cvtToJavaScriptArray((String[]) vMenu.toArray(new String[vMenu.size()]));
	   	sParent = srvpgm.cvtToJavaScriptArray((String[]) vParent.toArray(new String[vParent.size()]));
	    sSort = srvpgm.cvtToJavaScriptArray((String[]) vSort.toArray(new String[vSort.size()]));
	    sType = srvpgm.cvtToJavaScriptArray((String[]) vType.toArray(new String[vType.size()]));
	    sUrl = srvpgm.cvtToJavaScriptArray((String[]) vUrl.toArray(new String[vUrl.size()]));
	} 
	
    srvpgm.disconnect();    
    runsql.disconnect();
	runsql = null;
%>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="String_Trim_function.js"></script>
<SCRIPT> 
var code = "<%=sCode%>";
var seluser = "<%=sSelUser%>";

<%if(sAction.equals("UserByCode")){%>
var user = [<%=sUser%>];
var str = [<%=sStr%>];
var name = [<%=sName%>];
var term = [<%=sTerm%>];
var dept = [<%=sDept%>];
var title = [<%=sTitle%>];
var lastdt = [<%=sLastDt%>];
var commt = [<%=sCommt%>];
<%}%> 

<%if(sAction.equals("CodebyUser")){%>
var auth = [<%=sAppl%>];  
<%}%>

<%if(sAction.equals("MenubyCode")){%>
var menu = [<%=sMenu%>];
var parmenu = [<%=sParent%>];
var sort = [<%=sSort%>];
var type = [<%=sType%>];
var url = [<%=sUrl%>];
<%}%>
var Action = "<%=sAction%>";

if(Action == "UserByCode"){ parent.showUserLst(code, user,str,name,term,dept,title,lastdt,commt); }
else if(Action == "CodebyUser"){ parent.showAuthLst(seluser, auth); }
else if(Action == "MenubyCode"){ parent.showMenuLst(code, menu, parmenu, sort, type, url ); }
</SCRIPT>
<%
}
else {%>
<script>alert("Please Login.")</script>
<%}%>