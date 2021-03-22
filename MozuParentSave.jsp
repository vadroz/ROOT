<%@ page import="mozu_com.MozuParentSave , java.util.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sDesc = request.getParameter("Desc");
   String sCateg = request.getParameter("Categ");
   String sExtNm = request.getParameter("ExtNm");
   String sNormClr = request.getParameter("NormClr");
   String sMnf = request.getParameter("Mnf");
   String sModel = request.getParameter("Model");
   String sMdlYear = request.getParameter("MdlYear");
   String sGender = request.getParameter("Gender");   
   String sMap = request.getParameter("Map");
   String sNoMap = request.getParameter("NoMap");
   String sMapDt = request.getParameter("MapDt");
   String sCushn = request.getParameter("Cushn");
   String sWeb = request.getParameter("Web");
   String [] sCat = request.getParameterValues("Cat");
   String sLive = request.getParameter("Live");
   String sSaS = request.getParameter("SaS");
   String sSChO = request.getParameter("SChO");
   String sSStp = request.getParameter("SStp");
   String sRebel = request.getParameter("Rebel");
   String sRack = request.getParameter("Rack");
   String sJoJo = request.getParameter("JoJo");
   String sTaxFree = request.getParameter("TaxFree");
   String sAction = request.getParameter("Action");
   String sSavMNF = request.getParameter("SavMNF");
   String sLineNum = request.getParameter("Line");
   String sPrdTy = request.getParameter("PrdTy");   
   String sLast = request.getParameter("Last");
   String sId = request.getParameter("Id");
   String sProp = request.getParameter("Prop");   
   String sSite = request.getParameter("Site"); //tenant
   String sWgt = request.getParameter("Wgt");
   String sLen = request.getParameter("Len");
   String sWdt = request.getParameter("Wdt");
   String sHgt = request.getParameter("Hgt");
   String sTaxCat = request.getParameter("TaxCat");
   String sToggleTo = request.getParameter("ToggleTo");

   if(sDesc == null || sDesc == "") sDesc = " ";
   if(sCateg == null) sCateg = " ";
   if(sExtNm == null) sExtNm = " ";
   if(sNormClr == null) sNormClr = " ";
   if(sMnf == null) sMnf = " ";
   if(sModel == null) sModel = " ";
   if(sMdlYear == null) sMdlYear = " ";
   if(sGender == null) sGender = " ";
   if(sMap == null) sMap = " ";
   if(sNoMap == null) sNoMap = " ";
   if(sMapDt == null) sMapDt = " ";
   if(sLive == null) sLive = " ";
   if(sPrdTy == null) { sPrdTy = " "; }
   if(sCushn == null) sCushn = "0";
   if(sWeb == null) sWeb = "0";
   if(sSaS == null) sSaS = " ";
   if(sSChO == null) sSChO = " ";
   if(sSStp == null) sSStp = " ";
   if(sRebel == null) sRebel = " ";
   if(sRack == null) sRack = " ";
   if(sJoJo == null) sJoJo = " ";
   if(sTaxFree == null) sTaxFree = " ";
   if(sCat == null) { sCat = new String[]{ "0", "0", "0", "0"}; }
   if(sSavMNF==null) { sSavMNF="N"; }
   if(sLast==null) { sLast="false"; }
   if(sWgt == null) { sWgt = " "; }
   if(sLen == null) { sLen = " "; }
   if(sWdt == null) { sWdt = " "; }
   if(sHgt == null) { sHgt = " "; }
   if(sTaxCat == null) { sTaxCat = " "; }
   if(sId == null) { sId = " "; }
   if(sProp == null) { sProp = " "; }
   
   boolean bLast = Boolean.parseBoolean(sLast);

   MozuParentSave itmsav = null;
   int iNumOfErr = 0;
   String sError = null;
   
   
   System.out.println("Save " + sSite + " " + sCls + " " + sVen + " " + sSty + " id=" + sId + " " + sAction
			  + " " + sMapDt);
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMMERCE")!=null)
{
	itmsav = new MozuParentSave(); 

   String sUser = session.getAttribute("USER").toString(); 	
   
   //System.out.println("Save " + sSite + " " + sCls + " " + sVen + " " + sSty + " id=" + sId + " " + sAction
	//  + " " + sMapDt + " " + sProp + " " + sUser); 
	  //+ " " + sClr + " " + sSiz + " "
      //+ " " + sAction + "  Sas:" + sSaS + "  SCh:" + sSChO + "  SSTP:" + sSStp +  "  Rebel:"
      //+ sRebel + "  Rack:" + sRack + "  JoJo:" + sJoJo +  " web:" + sWeb +  " taxFree:" + sTaxFree);

   if(sAction.equals("SvItemProp"))
   {
	   itmsav.saveProp(sSite, sCls, sVen, sSty, sId, sProp, sAction, sUser);
   }   
   else if(sAction.equals("MoveToIp") || sAction.equals("MoveToEcom"))
   {
	   itmsav.moveToProp(sSite, sCls, sVen, sSty, sId, sProp, sAction, sUser);
   }
   else if(sAction.equals("SendAddPropKibo"))
   {
   	   itmsav.sendPropToKibo(sSite, sCls, sVen, sSty, sId, sProp, sAction, sUser);
   }   
   else if(sAction.equals("Toggle"))
   {
   	   itmsav.saveAttachmentType(sSite, sCls, sVen, sSty, sToggleTo, sAction, sUser);
   }
   else if(!sAction.equals("UPDSHORTDS") && !sAction.equals("UPDFULLDS") && !sAction.equals("UPDWEBDS") 
		     && !sAction.equals("UPDWEBNM")  && !sAction.equals("UPDGOOGLE"))
   {
   	   //System.out.println("saveItem - " +  sSite + "|" + sCls + "|" + sVen + "|" + sSty + "|" + sDesc + "|" + sCateg + "|" + sMnf);	
	   if(sMnf != null && !sMnf.equals("") && sMnf.indexOf("@@1@@") >= 0)
	   {
		   sMnf = sMnf.replaceAll("@@1@@", "`");
	   } 
   	   itmsav.saveItem(sSite, sCls, sVen, sSty, sDesc, sCateg, sMnf,
       		sModel, sMdlYear, sGender, sMap, sNoMap, sMapDt, sWeb, sCat, sSaS, sSChO, sSStp,
       		sRebel, sRack, sJoJo, sCushn, sLive, sSavMNF, sTaxFree, sNormClr, sPrdTy, sExtNm
       		, sWgt, sLen, sWdt, sHgt, sTaxCat , sAction, session.getAttribute("USER").toString());
   }   
   else
   {
	   System.out.println("SaveDesc - " + sSite + "|" + sCls + "|" + sVen + "|" + sSty + "|" + sDesc + "|" + sAction);
	   itmsav.saveDesc(sSite, sCls, sVen, sSty, sDesc, sAction
			   , session.getAttribute("USER").toString());
   }
   // special Order Item Entry
   itmsav.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   var Action = "<%=sAction%>";
   var lineId = "<%=sLineNum%>";
   
   goBack();
//==============================================================================
// end employee availability to schedule
//==============================================================================
   function goBack()
   {
     if(NumOfErr > 0){ parent.displayError(Error); }  
     else if(Action == "SvItemProp" || Action == "MoveToIp" 
    		 || Action == "MoveToEcom"){ parent.location.reload() }
     else if(Action == "DWNLADD"){ parent.setDownBtn(lineId) }
     else if(Action == "SendAddPropKibo"){ parent.setUpdAttrBtn(lineId) }
     else if(Action == "UPDSHORTDS" || Action == "UPDFULLDS" || Action == "UPDWEBDS"  
    		 || Action == "UPDWEBNM" || Action == "UPDGOOGLE"){ parent.sbmDescItem(); }
     else if(Action == "Toggle"){ parent.location.reload() }
     else { parent.reuseFrame(); }
   }
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







