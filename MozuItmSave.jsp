<%@ page import="mozu_com.MozuItmSave , java.util.*"%>
<%
   String sSite = request.getParameter("Site");
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");
   String sDesc = request.getParameter("Desc");
   String sCateg = request.getParameter("Categ");
   String sClrName = request.getParameter("ClrName");
   String sNormClr = request.getParameter("NormClr");
   String sSizName = request.getParameter("SizName");
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

   if(sDesc == null) sDesc = " ";
   if(sCateg == null) sCateg = " ";
   if(sClrName == null) sClrName = " ";
   if(sNormClr == null) sNormClr = " ";
   if(sSizName == null) sSizName = " ";
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

   MozuItmSave itmsav = null;
   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMMERCE")!=null)
{

   /*System.out.println(sCls + " " + sVen + " " + sSty + " " + sClr + " " + sSiz + " "
      + " " + sAction);
   */ 
    //+ "  Sas:" + sSaS + "  SCh:" + sSChO + "  SSTP:" + sSStp +  "  Rebel:"
    //  + sRebel + "  Rack:" + sRack + "  JoJo:" + sJoJo +  " web:" + sWeb +  " taxFree:" + sTaxFree);

   itmsav = new MozuItmSave(sSite, sCls, sVen, sSty, sClr, sSiz, sDesc, sCateg, sClrName, sSizName, sMnf,
       sModel, sMdlYear, sGender, sMap, sNoMap, sMapDt, sWeb, sCat, sSaS, sSChO, sSStp,
       sRebel, sRack, sJoJo, sCushn, sLive, sSavMNF, sTaxFree, sNormClr, sPrdTy
       , sAction, session.getAttribute("USER").toString());
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
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
     if(NumOfErr > 0){ parent.displayError(Error); }
     else if(Action == "DWNLADD"){ parent.setDownBtn(lineId) }
     else parent.reuseFrame();
   }
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







