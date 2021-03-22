<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSite = request.getParameter("Site");
   String sVen = request.getParameter("Ven");
   String sType = request.getParameter("Type");
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   String sStmt = "";
   sStmt = "select VNTYPE, VNNOTE, VNRECUS, VNRECDT, VNRECTM"
     + " from RCI.MoVeNote"
     + " where "
        + " VnSite='" + sSite + "'"
        + " and VnVen=" + sVen
     + " order by VnRecDt desc, VnRecTm desc";
      //System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();
   int j=0;

   Vector<String> vType = new Vector<String>();
   Vector<String> vNote = new Vector<String>();
   Vector<String> vRecUsr = new Vector<String>();
   Vector<String> vRecDt = new Vector<String>();
   Vector<String> vRecTm = new Vector<String>();

   while(runsql.readNextRecord())
   {
      vType.add(runsql.getData("VNTYPE").trim());
      vNote.add(runsql.getData("VNNOTE").trim());
      vRecUsr.add(runsql.getData("VNRECUS").trim());
      vRecDt.add(runsql.getData("VNRECDT").trim());
      vRecTm.add(runsql.getData("VNRECTM").trim());
   }
   
   runsql.disconnect();
   runsql = null;
%>
<SCRIPT language="JavaScript1.2">
var Vendor = "<%=sVen%>";
var Type = new Array();
var Note = new Array();
var RecUsr = new Array();
var RecDt = new Array(); 
var RecTm = new Array();

<%for(int i=0; i < vType.size() ;i++){%>Type[<%=i%>] = "<%=vType.get(i)%>";<%}%>
<%for(int i=0; i < vType.size() ;i++){%>Note[<%=i%>] = "<%=vNote.get(i)%>";<%}%>
<%for(int i=0; i < vType.size() ;i++){%>RecUsr[<%=i%>] = "<%=vRecUsr.get(i)%>";<%}%>
<%for(int i=0; i < vType.size() ;i++){%>RecDt[<%=i%>] = "<%=vRecDt.get(i)%>";<%}%>
<%for(int i=0; i < vType.size() ;i++){%>RecTm[<%=i%>] = "<%=vRecTm.get(i)%>";<%}%>

parent.showLog(Vendor, Type, Note, RecUsr, RecDt, RecTm);


</SCRIPT>


<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

