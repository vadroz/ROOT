<%@ page import="projmgmt.ProjSave, java.util.*"%>
<%
   String sProj = request.getParameter("Proj");
   String sName = request.getParameter("Name");
   String sDesc = request.getParameter("Desc");
   String sAssignee = request.getParameter("Assignee");
   String sType = request.getParameter("Type");
   String sSystem = request.getParameter("System");
   String sReqby = request.getParameter("Reqby");
   String sReqSts = request.getParameter("ReqSts");
   String sEstCompDt = request.getParameter("EstCompDt");
   String sCompDt = request.getParameter("CompDt");
   String sArea = request.getParameter("Area");
   String sPty = request.getParameter("Pty");
   String sWgt = request.getParameter("Wgt");
   String sMagn = request.getParameter("Magn");
   String sSts = request.getParameter("Sts");
   String sComm = request.getParameter("Comm");
   String sAsgSup = request.getParameter("AsgSup");
   String [] sAsgSupArr = request.getParameterValues("AsgSupArr");
   String sFiscYr = request.getParameter("FiscYr");
   String sAction = request.getParameter("Action");

   if(sName == null){ sName = " "; }
   if(sDesc == null){ sDesc = " "; }
   if(sAssignee == null){ sAssignee = " "; }
   if(sType == null){ sType = " "; }
   if(sSystem == null){ sSystem = " "; }
   if(sReqby == null){ sReqby = " "; }
   if(sReqSts == null){ sReqSts = " "; }
   if(sEstCompDt == null){ sEstCompDt = "01/01/0001"; }
   if(sCompDt == null){ sCompDt = "01/01/0001"; }
   if(sArea == null){ sArea = " "; }
   if(sPty == null){ sPty = " "; }
   if(sWgt == null){ sWgt = " "; }
   if(sMagn == null){ sMagn = " "; }
   if(sSts == null){ sSts = " "; }
   if(sComm == null){ sComm = " "; }
   if(sFiscYr == null) { sFiscYr = "0000"; }


   if (session.getAttribute("USER")==null)
   {

   }
   else
   {
     String sUser = session.getAttribute("USER").toString();

     ProjSave projsv = new ProjSave();

     if(sAction.equals("New") || sAction.equals("Update"))
     {
    	//System.out.println("sWgt=" + sWgt); 
        projsv.saveProjDtl(sProj, sName, sDesc, sAssignee, sType, sSystem, sReqby,
             sEstCompDt, sCompDt, sArea, sPty, sMagn, sSts, sComm, sReqSts, sFiscYr, sWgt, sAction, sUser);
        if(sAction.equals("New")){ sProj = projsv.getProjId(); }
     }

     if(sAction.equals("UpdSts"))
     {
        projsv.saveProjDtl(sProj, " ", " ", " ", " ", " ", " ",
             " ", " ", " ", " ", " ", sSts, " ", " ", " ", " ", sAction, sUser);
     }
     // update priority
     if(sAction.equals("UpdPty"))
     {
        projsv.saveProjDtl(sProj, " ", " ", " ", " ", " ", " ",
             " ", " ", " ", sPty, " ", " ", " ", " ", " ", " ", sAction, sUser);
     }
     // update weight     
     if(sAction.equals("UpdWgt"))
     {
    	 
        projsv.saveProjDtl(sProj, " ", " ", " ", " ", " ", " ",
             " ", " ", " ", " ", " ", " ", " ", " ", " ", sWgt, sAction, sUser);
     }
     
     if(sAction.equals("AddCommt"))
     {
    	 projsv.saveProjDtl(sProj, " ", " ", " ", " ", " ", " ",
                 " ", " ", " ", " ", " ", " ", sComm, " ", " ", " ", sAction, sUser);
     }

     if((sAction.equals("ADDASGSUP") || sAction.equals("DLTASGSUP")) && sAsgSupArr != null)
     {
        for(int i=0; i < sAsgSupArr.length; i++)
        {
           //System.out.println(sProj + " " + sAsgSupArr[i] + " " + sAction + " " + sUser);
           projsv.saveAsgSup(sProj, sAsgSupArr[i], sAction, sUser);
        }
     }

%>

<script language="JavaScript">
var Action = "<%=sAction%>";
if(Action == "New") { parent.setNewProjId("<%=sProj%>"); }
else if(Action != "DLTASGSUP")
{
   parent.restart();
}

</script>
<br>Action: <%=sAction%>

<br>Proj: <%=sProj%>
<br>Name: <%=sName%>
<br>Desc: <%=sDesc%>
<br>Assignee: <%=sAssignee%>
<br>Type: <%=sType%>
<br>System: <%=sSystem%>
<br>Req By: <%=sReqby%>
<br>Req Sts: <%=sReqSts%>
<br>Est: <%=sEstCompDt%>
<br>Compl: <%=sCompDt%>
<br>Area: <%=sArea%>
<br>Pty: <%=sPty%>
<br>Wgt: <%=sWgt%>
<br>Magnitude: <%=sMagn%>
<br>Sts: <%=sSts%>
<br>Comment: <%=sComm%>
<br>AsgSup: <%=sAsgSup%>
<br>Fisc Year: <%=sFiscYr%>
<%}%>