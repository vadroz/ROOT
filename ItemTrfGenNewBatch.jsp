<%@ page import="itemtransfer.ItemTrfGenNewBatch , java.util.*"%>
<%
    String sBComment = request.getParameter("BComment");
    String sBWhse = request.getParameter("BWhse");
    String sWhsQty = request.getParameter("WhsQty");
    String sBsrLvl = request.getParameter("BsrLvl");
    String sFrLrd = request.getParameter("FrLrd");
    String sToLrd = request.getParameter("ToLrd");
    String sFrLsd = request.getParameter("FrLsd");
    String sToLsd = request.getParameter("ToLsd");
    String sFrLmd = request.getParameter("FrLmd");
    String sToLmd = request.getParameter("ToLmd");
    String sPermMdn = request.getParameter("PermMdn"); 
    String sWGt0 = request.getParameter("WGt0");
    String sBsrMin = request.getParameter("BsrMin");
    String sBsrIdeal = request.getParameter("BsrIdeal");
    String sBsrMax = request.getParameter("BsrMax");
    String [] sAttrN = request.getParameterValues("AttrN");
    String [] sAttrV = request.getParameterValues("AttrV");
    String sClearance = request.getParameter("Clearance"); 
    
    
    if(sWhsQty == null){ sWhsQty = "0"; }
    if(sBsrLvl == null){ sBsrLvl = "B"; }
    if(sFrLrd == null || sFrLrd.trim().equals("")){ sFrLrd = "NONE"; }
    if(sFrLsd == null || sFrLsd.trim().equals("")){ sFrLsd = "NONE"; }
    if(sFrLmd == null || sFrLmd.trim().equals("")){ sFrLmd = "NONE"; }
    
    if(sToLrd == null || sToLrd.trim().equals("")){ sToLrd = "NONE"; }
    if(sToLsd == null || sToLsd.trim().equals("")){ sToLsd = "NONE"; }
    if(sToLmd == null || sToLmd.trim().equals("")){ sToLmd = "NONE"; }
    
    if(sPermMdn == null){ sPermMdn = "B"; }
    if(sClearance == null){ sClearance = "B"; }
    
    if(sWGt0 == null){ sWGt0 = "A"; }
    if(sBsrMin == null){ sBsrMin = "A"; }
    if(sBsrIdeal == null){ sBsrIdeal = "A"; }
    if(sBsrMax == null){ sBsrMax = "A"; }
    
    if(sAttrN == null){ sAttrN = new String[]{" "}; }
    if(sAttrV == null){ sAttrN = new String[]{"999"}; }
    
    System.out.println(sBComment + "|" + sBWhse + "|" + sWhsQty + "|" + sBsrLvl + "| Lrd=" + sFrLrd + "| Lsd=" + sFrLsd
    		 + "| lmd=" + sFrLmd + "| PM=" + sPermMdn + "| ATT=" + sAttrN[0] + "| sClrn=" + sClearance);

   if (session.getAttribute("USER")==null || session.getAttribute("TRANSFER") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemTrfGenNewBatch.jsp&APPL=TRANSFER");
   }
   else 
   {
     String sUser = session.getAttribute("USER").toString();
     ItemTrfGenNewBatch genbatch = new ItemTrfGenNewBatch(sBComment, sBWhse 
    	,sWhsQty,sBsrLvl
    	,sFrLrd,sToLrd,sFrLsd,sToLsd,sFrLmd,sToLmd
    	,sPermMdn, sClearance,sAttrN, sAttrV
    	, sWGt0, sBsrMin, sBsrIdeal, sBsrMax 
    	,sUser);
     String sBatch = genbatch.getBatch();
     genbatch.disconnect();
%>
<SCRIPT language="JavaScript">
Batch = "<%=sBatch%>"
BComment = "<%=sBComment%>"
BWhse = "<%=sBWhse%>"
goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.setNewBatchNumber(Batch, BWhse, BComment)
}

</SCRIPT>

<%}%>





