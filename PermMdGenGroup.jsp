<%@ page import="permmdprice.PermMdGenGroup, java.util.*"%>
<%
    String sBatch = request.getParameter("Batch");
    String sShortNm = request.getParameter("ShortNm");
    String sLongNm = request.getParameter("LongNm");
    String sBsrLvl = request.getParameter("BsrLvl");
    String sFrLrd = request.getParameter("FrLrd");
    String sToLrd = request.getParameter("ToLrd");
    String sFrLsd = request.getParameter("FrLsd");
    String sToLsd = request.getParameter("ToLsd");
    String sFrLmd = request.getParameter("FrLmd");
    String sToLmd = request.getParameter("ToLmd");
    String sPermMdn = request.getParameter("PermMdn"); 
    String [] sAttrN = request.getParameterValues("AttrN");
    String [] sAttrV = request.getParameterValues("AttrV");
    String sClearance = request.getParameter("Clearance"); 
    
    String sDiv = request.getParameter("Div");
    String sDpt = request.getParameter("Dpt");
    String sCls = request.getParameter("Cls");
    String sVen = request.getParameter("Ven");
    String sSty = request.getParameter("Sty");
    String sClr = request.getParameter("Clr");
    String sExclude = request.getParameter("Exclude");
    String sAmt = request.getParameter("Amt");
    
    String sMdPrc = request.getParameter("MdPrc");
    String sMdCent = request.getParameter("MdCent");
    
    String sMinRet = request.getParameter("MinRet");
    String sMaxRet = request.getParameter("MaxRet");
    
    String [] sClearPrcEnd = request.getParameterValues("ClearPrcEnd");
    
    String sVenType = request.getParameter("VenType");
    String [] sVenArr = request.getParameterValues("VenA");
    
    String sAction = request.getParameter("Action");
    
    
    if(sBsrLvl == null){ sBsrLvl = "B"; }
    if(sFrLrd == null || sFrLrd.trim().equals("")){ sFrLrd = "NONE"; }
    if(sFrLsd == null || sFrLsd.trim().equals("")){ sFrLsd = "NONE"; }
    if(sFrLmd == null || sFrLmd.trim().equals("")){ sFrLmd = "NONE"; }
    
    if(sToLrd == null || sToLrd.trim().equals("")){ sToLrd = "NONE"; }
    if(sToLsd == null || sToLsd.trim().equals("")){ sToLsd = "NONE"; }
    if(sToLmd == null || sToLmd.trim().equals("")){ sToLmd = "NONE"; }
    
    if(sPermMdn == null){ sPermMdn = "B"; }
    if(sClearance == null){ sClearance = "B"; }
    
    if(sAttrN == null){ sAttrN = new String[]{" "}; }
    if(sAttrV == null){ sAttrN = new String[]{"999"}; }
    
    if(sClearPrcEnd == null){ sClearPrcEnd = new String[]{" "}; }
    if(sVenArr == null){ sVenArr = new String[]{" "}; }
    
    if(sExclude == null){ sExclude = " ";}
    if(sAmt == null){ sAmt = " ";}
    
    System.out.println(sShortNm + "|" + sLongNm + "|" + sBsrLvl + "| Lrd=" + sFrLrd 
     + "| Lsd=" + sFrLsd + "| lmd=" + sFrLmd + "| PM=" + sPermMdn + "| ATT=" + sAttrN[0] 
     + "| sClrn=" + sClearance + "\n\tdiv=" + sDiv + " dpt=" + sDpt + " cls=" + sCls );

   if (session.getAttribute("USER") != null)
   {   
     
	   	String sUser = session.getAttribute("USER").toString();
     	PermMdGenGroup genbatch = new PermMdGenGroup();
     	
     	if(sAction.equals("GenBatch"))
     	{
     		genbatch.updBatch(sBatch, sShortNm, sLongNm 
    		,sBsrLvl
    		,sFrLrd,sToLrd,sFrLsd,sToLsd,sFrLmd,sToLmd
    		,sPermMdn, sClearance,sAttrN, sAttrV
    		,sDiv, sDpt, sCls 
    		,sClearPrcEnd
    		, sVenType, sVenArr
    		, sMdPrc, sMdCent, sMinRet, sMaxRet    	
    		,sUser
    		);
     		
     		sBatch = genbatch.getBatch();
     	}
     	else if(sAction.equals("UpdPrcnt")) 
     	{
     		genbatch.updBatchPercent(sBatch, sMdPrc, sMdCent, sUser);
     	}	
     	
     	else if(sAction.equals("AddExcl") || sAction.equals("DltExcl")
     		   || sAction.equals("AddOvrPrice") || sAction.equals("DltOvrPrice")) 
     	{
     		genbatch.updItemExcl(sBatch, sCls, sVen, sSty, sClr, sExclude, sAmt, sAction ,sUser);
     	}	
     	else if(sAction.equals("SbmPrcSsn")) 
     	{
     		genbatch.sbmPrcSsn(sBatch, sAction, sUser);
     	}	
     	
     	genbatch.disconnect();
%>
<SCRIPT language="JavaScript">
Batch = "<%=sBatch%>"
Action = "<%=sAction%>";
ShortNm = "<%=sShortNm%>"
LongNm = "<%=sLongNm%>"

cls="<%=sCls%>";
ven="<%=sVen%>";
sty="<%=sSty%>";
clr="<%=sClr%>";
exclude="<%=sExclude%>";

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
    if(Action == "GenBatch"){ parent.setNewBatchNumber(Batch, ShortNm, LongNm) }
    else if(Action == "UpdPrcnt"){ parent.restart(Batch) }
    else if(Action == "ExclOrInclitem"){ parent.markExcl(Batch, cls,ven,sty,clr,exclude) }
}

</SCRIPT>

<%}
else {%>

<script language="JavaScript">alert("Your session is expired. Please sign on again.")</script>

<%}%>





