<%@ page import="patiosales.OrderEntry, patiosales.PfsOrderComment, rciutility.FormatNumericValue, java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sStock = request.getParameter("Stock");
   String sList = request.getParameter("List");
   String sWarrDtl = request.getParameter("WarrDtl");
   

   if(sList == null) { sList="Y"; }
   if(sStock == null){ sStock = "Y"; }
   if(sWarrDtl == null){ sWarrDtl = "N"; }
   
   if(sWarrDtl.equals("Y")){ session.setAttribute("PFWARORD", "Y"); }

   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   //cal.add(Calendar.DATE, 2);
   String sToday = sdf.format(cal.getTime());

   sdf = new SimpleDateFormat("h:mm a");
   String sCurTime = sdf.format(cal.getTime());
  
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderEntry.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sEntStore = session.getAttribute("STORE").toString();
      if(sEntStore.trim().equals("ALL")) sEntStore = "Home Office";

      // check if user is authotized to change a status
      boolean bAllowChgSts = false;
      if(session.getAttribute("PATIOSTS")!=null) bAllowChgSts = true;
      
      OrderEntry ordent = new OrderEntry();
      String sOrdNum = "0";
      String sSts = "";
      String sSoSts = "";
      String sStr = "";
      String sCust = "";
      String sSlsper = "";
      String sSlpName = "";
      String sDelDate = "";
      String sShipInstr = "";
      String sLastName = "";
      String sFirstName = "";
      String sAddr1 = "";
      String sAddr2 = "";
      String sCity = "";
      String sState = "";
      String sZip = "";
      String sDayPhn = "";
      String sExtWorkPhn = "";
      String sEvtPhn = "";
      String sCellPhn = "";
      String sEMail = "";
      String sAlwEml = "";
      String sSpecOrd = "";
      String sCustPickup = "";
      String sReg = "";
      String sTrans = "";
      String sOrdSubTot = "";
      String sOrdShpPrc = "";
      String sOrdDscAmt = "";
      String sOrdAllDscAmt = "";
      String sOrdDscPrc = "";
      String sOrdAfterDsc = "";
      String sOrdDlvPrc = "";
      String sAssmb_Delvry = "";
      String sOrdMsrp = "";
      String sOrdRet = "";
      String sOrdMsrpDsc = "";
      String sOrdMsrpDscPrc = "";
      String sOrdRetDsc = "";
      String sOrdRetDscPrc = "";
      String sOrdTax = "";
      String sOrdTotal = "";
      String sOrdPaid = "";
      String sGrpItmDsc = "";
      String sSubAftMD = "";
      String sOrdAssmbPrc = "";
      String sProtPlan = "";
      String sTotQty = " ";
      
      String sEntUser = null;
      String sEntDate = null;
      String sEntTime = null;

      String sStrAddr1 = "";
      String sStrAddr2 = "";
      String sStrCity = "";
      String sStrState = "";
      String sStrZip = "";
      String sStrPhn = "";
      String sStrPhnFmt = "";

      String sPySts = "";
      String sStsNm = "New";
      String sSoStsNm = "None";
      String sPyStsNm = "";

      // items
      int iNumOfItm = 0;
      String [] sSku = null;
      String [] sVenSty = null;
      String [] sVen = null;
      String [] sVenName = null;
      String [] sColor = null;
      String [] sUpc = null;
      String [] sDesc = null;
      String [] sQty = null;
      String [] sRet = null;
      String [] sIpRet = null;
      String [] sTotal = null;
      String [] sSet = null;

      // item str/qty
      String [] sQty35 = null;
      String [] sQty46 = null;
      String [] sQty50 = null;
      String [] sQty86 = null;
      String [] sQty63 = null;
      String [] sQty64 = null;
      String [] sQty68 = null;
      String [] sQty55 = null;

      // item set
      int [] iNumOfSet = null;
      String [][] sSetSku = null;
      String [][] sSetVenSty = null;
      String [][] sSetColor = null;
      String [][] sSetUpc = null;
      String [][] sSetDesc = null;
      String [][] sSetQty = null;
      String [][] sSetRet = null;
      String [][] sSetQty35 = null;
      String [][] sSetQty46 = null;
      String [][] sSetQty50 = null;
      String [][] sSetQty86 = null;
      String [][] sSetQty63 = null;
      String [][] sSetQty64 = null;
      String [][] sSetQty68 = null;
      String [][] sSetQty55 = null;

      // special order
      int iNumOfSpc = 0;
      String [] sSoVen = null;
      String [] sSoVenName = null;
      String [] sSoVenSty = null;
      String [] sSoDesc = null;
      String [] sSoSku = null;
      String [] sSoQty = null;
      String [] sSoRet = null;
      String [] sSoClcPrc = null;
      String [] sSoFrmClr = null;
      String [] sSoFrmMat = null;
      String [] sSoFabClr = null;
      String [] sSoFabNum = null;
      String [] sSoItmSiz = null;
      String [] sSoComment = null;
      String [] sSoPoNum = null;
      String [] sSoTotal = null;

      // items as javascript arrays
      String sSkuJsa = null;
      String sVenStyJsa = null;
      String sVenJsa = null;
      String sVenNameJsa = null;
      String sUpcJsa = null;
      String sDescJsa = null;
      String sQtyJsa = null;
      String sRetJsa = null;
      String sIpRetJsa = null;
      String sTotalJsa = null;
      String sSetJsa = null;
      String sQty35Jsa = null;
      String sQty46Jsa = null;
      String sQty50Jsa = null;
      String sQty86Jsa = null;
      String sQty63Jsa = null;
      String sQty64Jsa = null;
      String sQty68Jsa = null;
      String sQty55Jsa = null;

      String sSetSkuJsa = null;
      String sSetUpcJsa = null;
      String sSetDescJsa = null;
      String sSetQtyJsa = null;
      String sSetQty35Jsa = null;
      String sSetQty46Jsa = null;
      String sSetQty50Jsa = null;
      String sSetQty86Jsa = null;
      String sSetQty63Jsa = null;
      String sSetQty64Jsa = null;
      String sSetQty68Jsa = null;
      String sSetQty55Jsa = null;
      String sSetRetJsa = null;

      String [] sSugPrc = null;
      String sSugPrcJsa = null;

      String [] sClcPrc = null;
      String sClcPrcJsa = null;
      String [][] sSetClcPrc = null;
      String sSetClcPrcJsa = null;
   
      String [] sQtyTaken = null;
      String [][] sSetQtyTaken = null;
      String sQtyTakenJsa = null;
      String sSetQtyTakenJsa = null;

      String sSoVenJsa = null;
      String sSoVenNameJsa = null;
      String sSoVenStyJsa = null;
      String sSoDescJsa = null;
      String sSoSkuJsa = null;
      String sSoQtyJsa = null;
      String sSoRetJsa = null;
      String sSoClcPrcJsa = null;
      String sSoFrmClrJsa = null;
      String sSoFrmMatJsa = null;
      String sSoFabClrJsa = null;
      String sSoFabNumJsa = null;
      String sSoItmSizJsa = null;
      String sSoCommentJsa = null;
      String sSoPoNumJsa = null;
      String sSoTotalJsa = null;

      // error
      int iNumOfErr = 0;
      String sError = null;
      String [] sArrErr = null;

      ordent.setCustAnswer();
      String sAnswTextJsa = ordent.getAnswTextJsa();
      String sAnswReqJsa = ordent.getAnswReqJsa();
      
      int iNumOfPic = 0;
      String [] sPicSku = null;
      String [] sPicFile = null;
      
      String sPicSkuJsa = null;
      String sPicFileJsa = null;
      
      boolean bExist = false;
      String sSngDscWarn = "";
      
      boolean bTaxFree = false;

      // generate new job number
      if (!sOrder.trim().equals("0"))
      {
         ordent.serOrderInfo(sOrder.trim());
         sOrdNum = ordent.getOrdNum();
         sSts = ordent.getSts();
         sSoSts = ordent.getSoSts();
         sStr = ordent.getStr();         
         sCust = ordent.getCust();
         sSlsper = ordent.getSlsper();
         sSlpName = ordent.getSlpName();
         sDelDate = ordent.getDelDate();
         sEntUser = ordent.getEntUser();
         sEntDate = ordent.getEntDate();
         sEntTime = ordent.getEntTime();
         sShipInstr = ordent.getShipInstr();
         sLastName = ordent.getLastName();
         sFirstName = ordent.getFirstName();
         sAddr1 = ordent.getAddr1();
         sAddr2 = ordent.getAddr2();
         sCity = ordent.getCity();
         sState = ordent.getState();
         sZip = ordent.getZip();
         sDayPhn = ordent.getDayPhn();
         sExtWorkPhn = ordent.getExtWorkPhn();
         sEvtPhn = ordent.getEvtPhn();
         sCellPhn = ordent.getCellPhn();
         sEMail = ordent.getEMail();
         sAlwEml = ordent.getAlwEml();
         sSpecOrd = ordent.getSpecOrd();    
         sCustPickup = ordent.getCustPickup();
         sReg = ordent.getReg();
         sTrans = ordent.getTrans();

         sOrdSubTot = ordent.getOrdSubTot();
         sOrdShpPrc = ordent.getOrdShpPrc();
         sOrdDscAmt = ordent.getOrdDscAmt();
         sOrdAllDscAmt = ordent.getOrdAllDscAmt();
         sOrdDscPrc = ordent.getOrdDscPrc();
         sOrdAfterDsc = ordent.getOrdAfterDsc();
         sOrdDlvPrc = ordent.getOrdDlvPrc();
         sOrdTax = ordent.getOrdTax();
         sOrdTotal = ordent.getOrdTotal();
         sOrdPaid = ordent.getOrdPaid();
         sOrdMsrp = ordent.getOrdMsrp();
         sOrdRet = ordent.getOrdRet();
         sOrdMsrpDsc = ordent.getOrdMsrpDsc();
         sOrdMsrpDscPrc = ordent.getOrdMsrpDscPrc();
         sOrdRetDsc = ordent.getOrdRetDsc();
         sOrdRetDscPrc = ordent.getOrdRetDscPrc();
         sGrpItmDsc = ordent.getGrpItmDsc();
         sSubAftMD = ordent.getSubAftMD();
         sOrdAssmbPrc = ordent.getOrdAssmbPrc();
         sAssmb_Delvry = ordent.getAssmb_Delvry();
         sProtPlan = ordent.getProtPlan();
         sTotQty = ordent.getTotQty();

         sPySts = ordent.getPySts();
         sStsNm = ordent.getStsNm();
         sSoStsNm = ordent.getSoStsNm();
         sPyStsNm = ordent.getPyStsNm();

         iNumOfErr = ordent.getNumOfErr();
         sError = ordent.getError();
         sArrErr = ordent.getErrorArr();

         bExist = true;
         if(iNumOfErr == 0)
         {
           // items
           iNumOfItm = ordent.getNumOfItm();
           sSku = ordent.getSku();
           sVenSty = ordent.getVenSty();
           sVen = ordent.getVen();
           sVenName = ordent.getVenName();
           sColor = ordent.getColor();
           sUpc = ordent.getUpc();
           sDesc = ordent.getDesc();
           sQty = ordent.getQty();
           sRet = ordent.getRet();
           sIpRet = ordent.getIpRet();
           sTotal = ordent.getTotal();
           sSet = ordent.getSet();

           // item str/qty
           sQty35 = ordent.getQty35();
           sQty46 = ordent.getQty46();
           sQty50 = ordent.getQty50();
           sQty86 = ordent.getQty86();
           sQty63 = ordent.getQty63();
           sQty64 = ordent.getQty64();
           sQty68 = ordent.getQty68();
           sQty55 = ordent.getQty55();

           // item set
           iNumOfSet = ordent.getNumOfSet();
           sSetSku = ordent.getSetSku();
           sSetVenSty = ordent.getSetVenSty();
           sSetColor = ordent.getSetColor();
           sSetUpc = ordent.getSetUpc();
           sSetDesc = ordent.getSetDesc();
           sSetQty = ordent.getSetQty();
           sSetQty35 = ordent.getSetQty35();
           sSetQty46 = ordent.getSetQty46();
           sSetQty50 = ordent.getSetQty50();
           sSetQty86 = ordent.getSetQty86();
           sSetQty63 = ordent.getSetQty63();
           sSetQty64 = ordent.getSetQty64();
           sSetQty68 = ordent.getSetQty68();
           sSetQty55 = ordent.getSetQty55();
           sSetRet = ordent.getSetRet();
           sSugPrc = ordent.getSugPrc();
           sClcPrc = ordent.getClcPrc();
           sSetClcPrc = ordent.getSetClcPrc();
           sQtyTaken = ordent.getQtyTaken();
           sSetQtyTaken = ordent.getSetQtyTaken();

           // special order
           iNumOfSpc = ordent.getNumOfSpc();
           sSoVen = ordent.getSoVen();
           sSoVenName = ordent.getSoVenName();
           sSoVenSty = ordent.getSoVenSty();
           sSoDesc = ordent.getSoDesc();
           sSoSku = ordent.getSoSku();
           sSoQty = ordent.getSoQty();
           sSoRet = ordent.getSoRet();
           sSoClcPrc = ordent.getSoClcPrc();
           sSoFrmClr = ordent.getSoFrmClr();
           sSoFrmMat = ordent.getSoFrmMat();
           sSoFabClr = ordent.getSoFabClr();
           sSoFabNum = ordent.getSoFabNum();
           sSoItmSiz = ordent.getSoItmSiz();
           sSoComment = ordent.getSoComment();
           sSoPoNum = ordent.getSoPoNum();
           sSoTotal = ordent.getSoTotal();

           // item as js arrays
           sSkuJsa = ordent.getSkuJsa();
           sUpcJsa = ordent.getUpcJsa();
           sDescJsa = ordent.getDescJsa();
           sQtyJsa = ordent.getQtyJsa();
           sRetJsa = ordent.getRetJsa();
           sSugPrcJsa = ordent.getSugPrcJsa();
           sTotalJsa = ordent.getTotalJsa();
           sSetJsa = ordent.getSetJsa();

           sClcPrcJsa = ordent.getClcPrcJsa();
           sSetClcPrcJsa = ordent.getSetClcPrcJsa();

           sQtyTakenJsa = ordent.getQtyTakenJsa();
           sSetQtyTakenJsa = ordent.getSetQtyTakenJsa();

           sQty35Jsa = ordent.getQty35Jsa();
           sQty46Jsa = ordent.getQty46Jsa();
           sQty50Jsa = ordent.getQty50Jsa();
           sQty86Jsa = ordent.getQty86Jsa();
           sQty63Jsa = ordent.getQty63Jsa();
           sQty64Jsa = ordent.getQty64Jsa();
           sQty68Jsa = ordent.getQty68Jsa();
           sQty55Jsa = ordent.getQty55Jsa();

           sSetSkuJsa = ordent.getSetSkuJsa();
           sSetUpcJsa = ordent.getSetUpcJsa();
           sSetDescJsa = ordent.getSetDescJsa();
           sSetQtyJsa = ordent.getSetQtyJsa();

           sSetQty35Jsa = ordent.getSetQty35Jsa();
           sSetQty46Jsa = ordent.getSetQty46Jsa();
           sSetQty50Jsa = ordent.getSetQty50Jsa();
           sSetQty86Jsa = ordent.getSetQty86Jsa();
           sSetQty63Jsa = ordent.getSetQty63Jsa();
           sSetQty64Jsa = ordent.getSetQty64Jsa();
           sSetQty68Jsa = ordent.getSetQty68Jsa();
           sSetQty55Jsa = ordent.getSetQty55Jsa();

           sSetRetJsa = ordent.getSetRetJsa();
           sSoVenJsa = ordent.getSoVenJsa();
           sSoVenNameJsa = ordent.getSoVenNameJsa();
           sSoVenStyJsa = ordent.getSoVenStyJsa();
           sSoDescJsa = ordent.getSoDescJsa();
           sSoSkuJsa = ordent.getSoSkuJsa();
           sSoQtyJsa = ordent.getSoQtyJsa();
           sSoRetJsa = ordent.getSoRetJsa();
           sSoClcPrcJsa = ordent.getSoClcPrcJsa();
           sSoFrmClrJsa = ordent.getSoFrmClrJsa();
           sSoFrmMatJsa = ordent.getSoFrmMatJsa();
           sSoFabClrJsa = ordent.getSoFabClrJsa();
           sSoFabNumJsa = ordent.getSoFabNumJsa();
           sSoItmSizJsa = ordent.getSoItmSizJsa();
           sSoCommentJsa = ordent.getSoCommentJsa();
           sSoPoNumJsa = ordent.getSoPoNumJsa();
           sSoTotalJsa = ordent.getSoTotalJsa();

           sStrAddr1 = ordent.getStrAddr1();
           sStrAddr2 = ordent.getStrAddr2();
           sStrCity = ordent.getStrCity();
           sStrState = ordent.getStrState();
           sStrZip = ordent.getStrZip();
           sStrPhn = ordent.getStrPhn();
           sStrPhnFmt = sStrPhn.substring(0,3) + "-" + sStrPhn.substring(3, 6) + "-" + sStrPhn.substring(6); 

           // error
           iNumOfErr = ordent.getNumOfErr();
           sError = ordent.getError();
           
           ordent.setPicList();
           iNumOfPic = ordent.getNumOfPic();
           sPicSku = ordent.getPicSku();
           sPicFile = ordent.getPicFile();
           
           sPicSkuJsa = ordent.cvtToJavaScriptArray(sPicSku);
           sPicFileJsa = ordent.cvtToJavaScriptArray(sPicFile);
           
           ordent.chkSngDscInt(sOrder, "CHKDSCINT", sUser);
           sSngDscWarn = ordent.getSngDscWarn();
         }
         
         bTaxFree = sStr != null 
        	        && (sEntDate.equals("08/17/2019") || sEntDate.equals("08/18/2019")) 
        	        && (sStr.equals("64") || sStr.equals("68"));
      }

      ordent.disconnect();

      /*String sShowSts = null;

      if(sSts == null || sSts.equals("")) sShowSts = "New";
      else if(sSts.equals("O")) sShowSts = "Unpaid";
      else if(sSts.equals("Q")) sShowSts = "Quote";
      else if(iNumOfSpc == 0  || sSts.equals("F") && sOrdTotal.equals("sOrdPaid ")) { sShowSts = "Paid-in-Full"; }
      else if(iNumOfSpc > 0 && sSts.equals("F") && !sOrdTotal.equals("sOrdPaid ")) { sShowSts = "Partial-Paid"; }
      else if(sSts.equals("T")) { sShowSts = "In-Progress"; }
      else if(sSts.equals("R")) { sShowSts = "Ready-To-Delivery"; }
      else if(sSts.equals("C")) { sShowSts = "Completed"; }
      else if(sSts.equals("D")) { sShowSts = "Canceled"; }
      */

      // special order status name
      String sShowSoSts = null;
      if(sSoSts == null) sShowSoSts = "None";
      else if(sSoSts.equals("N")) sShowSoSts = "Non-Approved";
      else if(sSoSts.equals("A")) sShowSoSts = "Approved";
      else if(sSoSts.equals("V")) sShowSoSts = "Placed-w/Vendor";
      else if(sSoSts.equals("R")) sShowSoSts = "Receive-@-DC";

      PfsOrderComment ordnote = new PfsOrderComment(sOrder, "NOT");
      String sComments = ordnote.getComments();

      boolean bAlwWarOrd =  session.getAttribute("PFWARORD") != null;
      //System.out.println("bAlwWarOrd=" + bAlwWarOrd);

      // format Numeric value
      FormatNumericValue fmt = new FormatNumericValue();

if(iNumOfErr == 0)
{
%>

<html>
<head>


<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="http://digitalbush.com/wp-content/uploads/2014/10/jquery.maskedinput.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<style>body {background:white;}

        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        
        table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
        table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
        
        
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable3 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable6 { background:LemonChiffon; color:red; font-family:Arial; font-size:12px;
                        font-weight:bold}
        tr.DataTable7 { background:#CDFFFF; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; vertical-align:bottom;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; vertical-align:bottom;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; vertical-align:bottom;}

        td.DataTable3 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable31 { border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable6 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; vertical-align:middle;}     
                       
        td.DataTable7 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}          

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }
        input.Small1 {background:LemonChiffon; font-family:Arial; font-size:10px }
        input {border:none; border-bottom: black solid 1px; font-family:Arial; font-size:12px; font-weight:bold}
        input.radio {border:none; font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea { border: black solid 1px; font-family:Arial; font-size:12px; font-weight:bold }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvTaxFree2  { position:relative; background: pink;  
           border: orange solid 2px; width:600; text-align: left; font-size:16px}            
              
        div.dvOrdType  { position:absolute; visibility:hidden; background-attachment: scroll; 
              width:200;  z-index:10; color: #339cff;
              text-align:center; font-size:24px; font-family: Arial Black;}
        
             
        .pos_fixed { visibility:hidden; position: fixed; top: 25px; left: 15px;
             border: black solid 2px;   ; color: red; font-size:20px; width:500;
             background-color:LemonChiffon; z-index:10;
        }   

             

        td.BoxName {cursor:move; background: #016aab; 
        color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab; 
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

@media screen
{
    span.spnAster {color:red;}
   .NonPrt { font-size:10px}
   .PrintOnly {display:none }
}
@media print
{
   span.spnAster {display:none}
   .NonPrt { display:none}
   #dvWarn { display:none}
   .PrintOnly {color:black; }
   //tr.DataTable7 { display:none }
}
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var User = "<%=sUser%>";
var RecUsr = ["dmikulan", "kknight", "psnyder", "vrozen"];
var EntStore = "<%=sEntStore%>";

// orser header info
var Order = "<%=sOrdNum%>";
var Sts = "<%=sSts%>";
var PySts = "<%=sPySts%>";
var SoSts = "<%=sSoSts%>";
var Str = "<%=sStr%>";
var Cust = "<%=sCust%>";
var Slsper = "<%=sSlsper%>";
var SlpName = "<%=sSlpName%>";
var DelDate = "<%=sDelDate%>";
var ShipInstr = "<%=sShipInstr%>";
var ShpPrc = "<%=sOrdShpPrc%>"

var DscAmt = "<%=sOrdDscAmt%>"
var AllDscAmt = "<%=sOrdAllDscAmt%>"
var GrpItmDsc = "<%=sGrpItmDsc%>";
var OrdDscPrc = "<%=sOrdDscPrc%>";
var OrdAllDscAmt  = "<%=sOrdAllDscAmt%>";
var OrdAfterDsc = "<%=sOrdAfterDsc%>"
var SubAftMD = "<%=sSubAftMD%>"

var DscPrc = "<%=sOrdDscPrc%>"
var SubTot = "<%=sOrdSubTot%>"
var DlvPrc = "<%=sOrdDlvPrc%>"
var	Assmb_Delvry = "<%=sAssmb_Delvry%>";
var AssmbPrc = "<%=sOrdAssmbPrc%>"
var ProtPlan = "<%=sProtPlan%>"
var Tax = "<%=sOrdTax%>"
var List = "<%=sList%>"
var OrdPaid = "<%=sOrdPaid%>"
var WarrDtl = "<%=sWarrDtl%>"
var ProtPlan = "<%=sProtPlan%>";

// customer info
var LastName = "<%=sLastName%>";
var FirstName = "<%=sFirstName%>";
var Addr1 = "<%=sAddr1%>";
var Addr2 = "<%=sAddr2%>";
var City = "<%=sCity%>";
var State = "<%=sState%>";
var Zip = "<%=sZip%>";
var DayPhn = "<%=sDayPhn%>";
var ExtWorkPhn = "<%=sExtWorkPhn%>";
var EvtPhn = "<%=sEvtPhn%>";
var CellPhn = "<%=sCellPhn%>";
var EMail = "<%=sEMail%>";
var AlwEml = "<%=sAlwEml%>";
var SpecOrd = "<%=sSpecOrd%>";
var CustPickup = "<%=sCustPickup%>";
var Reg = "<%=sReg%>";
var Trans = "<%=sTrans%>";

var Exist = <%=bExist%>;

var NumOfItm = <%=iNumOfItm%>;
var Sku = [<%=sSkuJsa%>];
var Upc = [<%=sUpcJsa%>];
var Desc = [<%=sDescJsa%>];
var SkuQty = [<%=sQtyJsa%>];
var Ret = [<%=sRetJsa%>];
var SugPrc = [<%=sSugPrcJsa%>];
var ClcPrc = [<%=sClcPrcJsa%>];
var QtyTaken = [<%=sQtyTakenJsa%>];
var SetQtyTaken = [<%=sSetQtyTakenJsa%>];
var SetClcPrc = [<%=sSetClcPrcJsa%>];
var SkuTotal = [<%=sTotalJsa%>];
var Set = [<%=sSetJsa%>];
var Qty35 = [<%=sQty35Jsa%>];
var Qty46 = [<%=sQty46Jsa%>];
var Qty50 = [<%=sQty50Jsa%>];
var Qty86 = [<%=sQty86Jsa%>];
var Qty63 = [<%=sQty63Jsa%>];
var Qty64 = [<%=sQty64Jsa%>];
var Qty68 = [<%=sQty68Jsa%>];
var Qty55 = [<%=sQty55Jsa%>];
var UpdSetSku = [<%=sSetSkuJsa%>];
var UpdSetUpc = [<%=sSetUpcJsa%>];
var UpdSetDesc = [<%=sSetDescJsa%>];
var UpdSetQty = [<%=sSetQtyJsa%>];
var UpdSetQty35 = [<%=sSetQty35Jsa%>];
var UpdSetQty46 = [<%=sSetQty46Jsa%>];
var UpdSetQty50 = [<%=sSetQty50Jsa%>];
var UpdSetQty86 = [<%=sSetQty86Jsa%>];
var UpdSetQty63 = [<%=sSetQty63Jsa%>];
var UpdSetQty64 = [<%=sSetQty64Jsa%>];
var UpdSetQty68 = [<%=sSetQty68Jsa%>];
var UpdSetQty55 = [<%=sSetQty55Jsa%>];
var UpdSetRet = [<%=sSetRetJsa%>];
var Status = "<%=sStsNm%>";

var NumOfSpc = <%=iNumOfSpc%>

var SoVen = [<%=sSoVenJsa%>];
var SoVenName = [<%=sSoVenNameJsa%>];
var SoVenSty = [<%=sSoVenStyJsa%>];
var SoDesc = [<%=sSoDescJsa%>];
var SoSku = [<%=sSoSkuJsa%>];
var SoQty = [<%=sSoQtyJsa%>];
var SoRet = [<%=sSoRetJsa%>];
var SoClcPrc = [<%=sSoClcPrcJsa%>];
var SoFrmClr = [<%=sSoFrmClrJsa%>];
var SoFrmMat = [<%=sSoFrmMatJsa%>];
var SoFabClr = [<%=sSoFabClrJsa%>];
var SoFabNum = [<%=sSoFabNumJsa%>];
var SoComment = [<%=sSoCommentJsa%>];
var SoPoNum = [<%=sSoPoNumJsa%>];
var SoItmSiz = [<%=sSoItmSizJsa%>];
var SoTotal = [<%=sSoTotalJsa%>];

var AnswText = [<%=sAnswTextJsa%>];
var AnswReq = [<%=sAnswReqJsa%>];

var NumOfErr = <%=iNumOfErr%>;
var Error = [<%=sError%>] ;

var NumOfSet=0;
var SetSku = null;
var SetUpc = null;
var SetDesc = null;
var SetQty35 = null;
var SetQty46 = null;
var SetQty50 = null;
var SetQty86 = null;
var SetQty63 = null;
var SetQty64 = null;
var SetQty68 = null;
var SetQty55 = null;
var SetTot = null;

var SpoVen = new Array();
var SpoVenName = new Array();
var SpoVenAddr1 = new Array();
var SpoVenAddr2 = new Array();
var SpoVenCity = new Array();
var SpoVenState = new Array();
var SpoVenZip = new Array();
var SpoVenPhn = new Array();

var OrdTotal = 0;
var OrdPaid = 0;
<%if(sOrdTotal != null){%>OrdTotal = "<%=sOrdTotal%>"; OrdPaid = "<%=sOrdPaid%>";<%}%>
var NumOfCmt = 0;

var NextSts = null;
var NextSoSts = null;

var CstProp = null;
var CustArr = null;

// all pation store
var ArrStr = [35, 46, 50, 86, 63, 64, 68, 55];

// array of allowed store
<%if(sStr.equals("35") || sStr.equals("46") || sStr.equals("50")){%>
var ArrAlwStr = [35,46,50,86,0,0,0,0];
<%} else if(sStr.equals("86")){%>
var ArrAlwStr = [35,46,50,86,63,64,68,55];
<%}
else {%>
var ArrAlwStr = [0,0,0,86, 63,64,68,55];
<%}%>



var arrTh = new Array();
var arrThr = new Array();
var arrTd = new Array();
var arrTdi = new Array();
var arrTds = new Array();
var arrTdsi = new Array();
var OtherStr = false;

var CurrArg = null;
var SavType = null;

var Answer = null;
var AnswerText = null;

var NumOfPic = eval("<%=iNumOfPic%>");
var PicSku = [<%=sPicSkuJsa%>];
var PicFile = [<%=sPicFileJsa%>];


var StrAddr1 = "<%=sStrAddr1%>";
var StrAddr2 = "<%=sStrAddr2%>";
var StrCity = "<%=sStrCity%>";
var StrState = "<%=sStrState%>";
var StrZip = "<%=sStrZip%>";
var StrPhn = "<%=sStrPhnFmt%>";
var EntDate = "<%=sEntDate%>";

var SngDscWarn = "<%=sSngDscWarn%>";

jQuery(function($){ $("#DayPhn").mask("(999) 999-9999");	});
jQuery(function($){ $("#EvtPhn").mask("(999) 999-9999");	});
jQuery(function($){ $("#CellPhn").mask("(999) 999-9999");	});

var block = "table-cell";
var TaxFree = <%=bTaxFree%>;

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ block = "block";} 
  
   // return to selection screen
   if(NumOfErr > 0)
   {
      displayError(Error);
      window.location.href = "OrderEntrySel.jsp";
   }

   if (!Exist)
   {
       document.all.tdDetail.style.display = "none";
       document.all.tdDetail1.style.display = "none";
       document.all.tdDetail2.style.display = "none";
       document.all.tdDetail3[0].style.display = "none";
       document.all.tdDetail3[1].style.display = "none";
       document.all.tdDetail4.style.display = "none";
       var date = new Date(new Date() - -86400000 * 14);
       //document.all.DelDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   }
   if (Exist)
   {
	   $("#Sku").focus();
	 //$("#CellPhn").focus();
	 //$("#DayPhn").focus();      
	 //$("#EvtPhn").focus();
		 
     
	 setOrderHeader();
	 
	 setIOrdType();
     
     //$("#Store").focus();
     
   }

   <%if(bAlwWarOrd){%>
   document.all.DelDate.readOnly = false;
   <%}%>

   if(Sts != "C" && Sts != "D" && Sts != "R" && Sts != "Z" && Sts != "E" || WarrDtl == "Y")
   {
     document.all.tbAddLine.style.display = block;
   }
   else
   {
     document.all.tbAddLine.style.display = "none";
   }


   clrLine();

   if (Exist){ showOnlyOrdStr(); }

   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
   
   if(SngDscWarn != "" && Sts != 'C' &&  Sts != 'D')
	{ 	   
		document.all.dvWarn.innerHTML = "Warning!!<br>A Single Discount was applied to this order, " 
		    + "before these last SKU/QTY changes.<br>Please review the comments for previous Single " 
		    + "Discount %/$, then RE-UPDATE the Single Discount.";
		document.all.dvWarn.style.visibility = "visible";
	}   
   
   
   if (Exist && TaxFree){ setTaxFreeBanner(); }
}
//==============================================================================
// show tax free banner
//==============================================================================
function setTaxFreeBanner()
{	
	html = "<b>Tax Free Holiday Weekend:</b> Aug 17-18, 2019 (only) any items < $2,500" 
	 + "<br>Orders must be paid in full on these dates to qualify for tax free!";
	  
	 
	document.all.dvTaxFree2.innerHTML = html;	
}
//==============================================================================
//show order type watermark
//==============================================================================
function setIOrdType()
{
	var html = "";
	
	if(Order == "0"){ html = "New Order"; }
	else if(SpecOrd=="Y"){ html = "Special Order"; }	
	else{ html = "Stock Order"; }
	
	if(Sts=="Q" || Sts=="E")
	{ 
		html += "<br> <span style='color:#d35400;'>(Quote)</span>"; 
	} 
	
	document.all.dvOrdType.innerHTML = html;
	document.all.dvOrdType.style.left= 850;
	document.all.dvOrdType.style.top=110;
	document.all.dvOrdType.style.visibility = "visible";
}
//==============================================================================
// show only current store on detail entry line
//==============================================================================
function showOnlyOrdStr()
{
   OtherStr = false;
   arrTh[0] = document.all.thStr35;  arrTh[1] = document.all.thStr46; arrTh[2] = document.all.thStr50;
   arrTh[3] = document.all.thStr86;  arrTh[4] = document.all.thStr63; arrTh[5] = document.all.thStr64;
   arrTh[6] = document.all.thStr68;  arrTh[7] = document.all.thStr55;

   arrThr[0] = document.all.thRcv35;  arrThr[1] = document.all.thRcv46; arrThr[2] = document.all.thRcv50;
   arrThr[3] = document.all.thRcv86;  arrThr[4] = document.all.thRcv63; arrThr[5] = document.all.thRcv64;
   arrThr[6] = document.all.thRcv68;  arrThr[7] = document.all.thRcv55;

   arrTd[0] = document.all.tdQty35;  arrTd[1] = document.all.tdQty46; arrTd[2] = document.all.tdQty50;
   arrTd[3] = document.all.tdQty86;  arrTd[4] = document.all.tdQty63; arrTd[5] = document.all.tdQty64;
   arrTd[6] = document.all.tdQty68;  arrTd[7] = document.all.tdQty55;

   arrTdi[0] = document.all.tdQtyInp35;  arrTdi[1] = document.all.tdQtyInp46; arrTdi[2] = document.all.tdQtyInp50;
   arrTdi[3] = document.all.tdQtyInp86;  arrTdi[4] = document.all.tdQtyInp63; arrTdi[5] = document.all.tdQtyInp64;
   arrTdi[6] = document.all.tdQtyInp68;  arrTdi[7] = document.all.tdQtyInp55;

   arrTds[0] = document.all.tdSetQty35;  arrTds[1] = document.all.tdSetQty46; arrTds[2] = document.all.tdSetQty50;
   arrTds[3] = document.all.tdSetQty86;  arrTds[4] = document.all.tdSetQty63; arrTds[5] = document.all.tdSetQty64;
   arrTds[6] = document.all.tdSetQty68;  arrTds[7] = document.all.tdSetQty55;

   arrTdsi[0] = document.all.tdSetQty35i;  arrTdsi[1] = document.all.tdSetQty46i; arrTdsi[2] = document.all.tdSetQty50i;
   arrTdsi[3] = document.all.tdSetQty86i;  arrTdsi[4] = document.all.tdSetQty63i; arrTdsi[5] = document.all.tdSetQty64i;
   arrTdsi[6] = document.all.tdSetQty68i;  arrTdsi[7] = document.all.tdSetQty55i;

   for(var i=0; i < ArrStr.length; i++)
   {
       if(Str == ArrStr[i])
       {
          arrTh[i][0].style.display = block; arrTh[i][1].style.display = block;
          arrThr[i].style.display = block;
          arrTd[i].style.display = block; arrTdi[i].style.display = block;
          for(var j=0; j < arrTds[i].length; j++)
          {
             arrTds[i][j].style.display = block; arrTdsi[i][j].style.display = block;
          }
       }
       else
       {
          arrTh[i][0].style.display = "none"; arrTh[i][1].style.display = "none";
          arrThr[i].style.display = "none";
          arrTd[i].style.display = "none"; arrTdi[i].style.display = "none";
          for(var j=0; j < arrTds[i].length; j++)
          {
             arrTds[i][j].style.display = "none"; arrTdsi[i][j].style.display = "none";
          }
       }
   }
}
//==============================================================================
// show other store on item entry screen
//==============================================================================
function showOtherStr()
{
   var disp = "none";
   if(!OtherStr) { disp = block; }

   for(var i=0; i < ArrAlwStr.length; i++)
   {
       if(Str != ArrAlwStr[i] && ArrAlwStr[i] != 0){
          arrTh[i][0].style.display = disp;
          arrTh[i][1].style.display = disp;
          arrThr[i].style.display = disp;
          arrTd[i].style.display = disp; arrTdi[i].style.display = disp;
          for(var j=0; j < arrTds[i].length; j++)
          {
             arrTds[i][j].style.display = disp; arrTdsi[i][j].style.display = disp;
          }
       }
   }
   OtherStr = !OtherStr;
}
//==============================================================================
// set Order/Customer Header Information
//==============================================================================
function setOrderHeader()
{
   document.all.Slsper.value = Slsper;
   document.all.spnSlpName.innerHTML = SlpName;

   // Show quote expiration date
   if ( Sts == "Q")
   {
      if(DelDate == "")
      {
          var date = new Date(new Date() - -86400000 * 7);
          document.all.DelDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
      }
      else if(DelDate == "01/01/0001"){ document.all.DelDate.value = ""; }
      else{ document.all.DelDate.value = DelDate; }
      //document.all.spnDelDate.innerHTML="Quote Expiration Date";
      document.all.spnExpDt.style.display = block;
      document.all.spnDelDate.style.display = "none";
      document.all.spnOrConj.style.display = "none";     
   }
   // Show delivery date, except special order that is not receipted yet.
   else if ( NumOfSpc == 0  || Sts == "C" || Sts == "D"|| SoSts == "V" || SoSts == "R")
   {
      if(SpecOrd != "Y" && CustPickup != "Y" || DelDate != "01/01/0001"){document.all.DelDate.value = DelDate;}
      else if(CustPickup == "Y" && DelDate == "01/01/0001"){   document.all.DelDate.value = "CUST PICKUP"; }
      else if(SpecOrd == "Y"){   document.all.DelDate.value = "Upon Receipt"; }
      //document.all.shwDelDate.innerHTML="Delivery Date";
      document.all.spnExpDt.style.display = "none";
      document.all.spnDelDate.style.display = block;
      document.all.spnOrConj.style.display = "none";
   }
   else if ( NumOfSpc > 0 && (Sts == "S" || Sts == "R" || Sts == "Z" || Sts == "X"))
   {
      document.all.DelDate.value = DelDate;
      if(SpecOrd == "Y" && (SoSts == "N" || SoSts == "A" || SoSts == "V"))
      {
    	  document.all.DelDate.value = "Upon Receipt"; 
      }
      
      
      document.all.Down.style.display="inline";
      document.all.Up.style.display="inline";
      document.all.shwCal.style.display="inline";
      //document.all.spnDelDate.innerHTML="Delivery Date";
      document.all.spnExpDt.style.display = "none";
      document.all.spnDelDate.style.display = block;
      document.all.spnOrConj.style.display = "none";
   }
   else
   {
      document.all.DelDate.value = "Upon Receipt"; // for special order only
      document.all.Down.style.display="none";
      document.all.Up.style.display="none";
      document.all.shwCal.style.display="none";
      //document.all.spnDelDate.innerHTML="Delivery Date";
      document.all.spnExpDt.style.display = "none";
      document.all.spnDelDate.style.display = block;
      document.all.spnOrConj.style.display = "none"; 
   }

   document.all.ShpInstr.value = ShipInstr.showSpecChar();
   document.all.LastName.value = LastName;
   document.all.FirstName.value = FirstName
   document.all.Addr1.value = Addr1.showSpecChar();
   document.all.Addr2.value = Addr2.showSpecChar();
   document.all.City.value = City;
   document.all.State.value = State;
   document.all.Zip.value = Zip;
   
   document.all.DayPhn.value = DayPhn;
   document.all.ExtWorkPhn.value = ExtWorkPhn;
   document.all.EvtPhn.value = EvtPhn;
   document.all.CellPhn.value = CellPhn;

   document.all.EMail.value = EMail;
   document.all.AllowEmail.checked = AlwEml == "Y";

   if(Sts == "C" || Sts == "D" || Sts == "E")
   {
      document.all.Slsper.readOnly = true;
      document.all.DelDate.readOnly = true;
      document.all.ShpInstr.readOnly = true;
      document.all.LastName.readOnly = true;
      document.all.FirstName.readOnly = true;
      document.all.Addr1.readOnly = true;
      document.all.Addr2.readOnly = true;
      document.all.City.readOnly = true;
      document.all.State.readOnly = true;
      document.all.Zip.readOnly = true;
      document.all.DayPhn.readOnly = true;
      document.all.ExtWorkPhn.readOnly = true;
      document.all.EvtPhn.readOnly = true;
      document.all.CellPhn.readOnly = true;
      document.all.EMail.readOnly = true;

      document.all.SaveOrder.style.display="none";
      document.all.tdDetail.style.display = "none";
      document.all.tdDetail1.style.display = "none";
   }
   else
   {
     if(PySts=="O" && NumOfItm > 0) document.all.Sku.focus();
     // Make Set Lines hidden
      for(var i=0; i < document.all.trSet.length; i++)
      {
         document.all.trSet[i].style.display="none";
      }
   }
   document.all.tbAddSpcOrd.style.display="none";
}

//==============================================================================
// validate Order/Customer Header Information
//==============================================================================
function ValidateHdr(type)
{
   var slsp = document.all.Slsper.value.trim();
   var deldate = document.all.DelDate.value;
   var str = document.all.Store.value;
   var shpins = document.all.ShpInstr.value;
   var last = document.all.LastName.value;
   var first = document.all.FirstName.value;
   var addr1 = document.all.Addr1.value;
   var addr2 = document.all.Addr2.value;
   var city = document.all.City.value;
   var state = document.all.State.value;
   var zip = document.all.Zip.value;
   
   //var dayphn = document.all.DayPhn.value;
   var dayphn = cvtPhnNum(document.all.DayPhn);
   
   var ext = document.all.ExtWorkPhn.value;
   var evtphn = cvtPhnNum(document.all.EvtPhn);
   var cellphn = cvtPhnNum(document.all.CellPhn);
   var email = document.all.EMail.value.trim();
   var alwemail = "N"; 
   if( document.all.AllowEmail.checked ){alwemail = "Y"; };

   var msg = "";
   var error = false;

   // check if cashier select Sunday or Saturday. Only manager is allowed to do it
   <%if(sUser.trim().length()==7 && sUser.trim().substring(0, 5).equals("cashr")){%>
     var date = new Date(deldate);
     date.setHours(18)
     var day = date.getDay();
     if (day == 0 || day == 6) { error = true; msg += "Only manager is allowed to use Sunday or Saturday as Delivery Date.\n"}
   <%}%>

   

   if (slsp.trim() == "" || isNaN(slsp.trim()) || eval(slsp.trim()) <= 0){ error = true; msg += "Invalid Salesperson number.\n"}
   if (str.trim() != "35" && str.trim() != "46" && str.trim() != "50" && str.trim() != "86"
       && str.trim() != "63" && str.trim() != "64" && str.trim() != "68"){ error = true; msg += "Invalid store number.\n"}
   
   if (type == "ORD" && shpins.trim() == ""){ error = true; msg += "Enter Special Shipping Instruction.\n"}
   
   if (last.trim() == "" || first.trim() == ""){ error = true; msg += "Enter last and first name.\n"}
   if ((type == "ORD" || type == "WAR") && addr1.trim() == "" && addr2.trim() == ""){ error = true; msg += "Enter street address.\n"}
   if ((type == "ORD" || type == "WAR") && (city.trim() == "" || state.trim() == "" || zip.trim() == "")) { error = true; msg += "Enter city, state & zip code.\n"}
   if (type == "ORD" && dayphn.trim() == "" && evtphn.trim() == "" && cellphn.trim() == "") { error = true; msg += "Enter phone number(s).\n"}

   if (dayphn.trim() != "" && dayphn.trim().length < 10) { error = true; msg += "Day phone number has less than 10 digits.\n"}
   if (evtphn.trim() != "" && evtphn.trim().length < 10) { error = true; msg += "Evening phone number has less than 10 digits.\n"}
   if (cellphn.trim() != "" && cellphn.trim().length < 10) { error = true; msg += "Cell phone number has less than 10 digits.\n"}

   if (email == "") { error = true; msg += "Enter E-Mail addres.\n"}
   else if(!checkEmail(email)){ error=true; msg += "\nInvalid E-Mail address."; }
   
   //---------- delivaery expiration date ------------------
   var specOrd = "";
   if(document.all.chbSpecOrd.checked){ specOrd = "Y"; }
   var custPickup = "";
   if(document.all.chbCustPup.checked){ custPickup = "Y"; }
   
   // remove Upon receipt and customer pickup for quote uncheck customer pickup button
   if(type == "QUO")
   {
	  //deldate = "";
      //document.all.DelDate.value = "";
      
      document.all.Down.style.display="inline";
      document.all.Up.style.display="inline";
      document.all.shwCal.style.display="inline";
      //document.all.spnDelDate.innerHTML="Quote Expiration Date";
   }
   // validate delivery date - always for quote, or if not SO or customer pickup for order
   if (type == "QUO")
   {
     if(deldate == ""){  error = true; msg += "Invalid Quote Expiration.\n" }
     else
     {
        // check, if date is not closed (exclude order for warranty issues).
        if(type != "WAR") { chkClsDt(str, deldate); }
        var dcur = new Date();
        dcur.setHours(16);
        var dtdel = new Date(deldate)
        dtdel.setHours(18);
        if(dcur > dtdel && type != "WAR") {  error = true; msg += "Expiration Date cannot be less then today date.\n"  }
     }
   }   
   else
   {
     if(deldate == "" && specOrd != "Y" && custPickup != "Y"){  error = true; msg += "Invalid Delivery Date.\n" }
     else
     {
        // check, if date is not closed (exclude order for warranty issues).
        if(type != "WAR") { chkClsDt(str, deldate); }
        var dcur = new Date();
        dcur.setHours(16);
        var dtdel = new Date(deldate)
        dtdel.setHours(18);
        if(dcur > dtdel && type != "WAR") {  error = true; msg += "Delivery Date cannot be less then today date.\n"  }
     }
   }
   

   if(error) alert(msg)
   else
   {
	   var allow = true;
	   if(type == "ORD" && Order == "0")
	   {
		   allow = confirm("You are creating a Patio SALE Order, which requires payment in POS today.\nIs this correct?");		   
	   }
	   
	   
	   if(Sts == "" && type != "WAR" && allow) { getCustResp(type); }	
	   else if(allow)
	   {
		   saveOrderHdr(type) 
       };
   }
}
//==============================================================================
// check email
//==============================================================================
function checkEmail(email)
{
   var good = true;
   var notappl = ["N/A", "NA"]
   if (email.toUpperCase() != notappl[0] && email.toUpperCase() != notappl[1])
   {
      var atpos=email.indexOf("@");
      var dotpos=email.lastIndexOf(".");
      if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length){ good = false; }
   }
   return good;
}
//==============================================================================
// check if current date is closed for selection or available
//==============================================================================
function chkClsDt(str, chkdt)
{
   var url = "PfsCheckDelDate.jsp?single=Y";
   url += "&chkdt=" + chkdt
        + "&str=" + str;

   //alert(closed_dates_URL)
   window.frameChkCalendar.location.href=url;
}
//==============================================================================
// marked Closed date as unavailable
//==============================================================================
function markSingleDateSts(close)
{
   //window.frameChkCalendar.location.href=null;
   window.frameChkCalendar.close();
   if (close) alert("Selected date is closed for delivery.")
}

//==============================================================================
// convert phone number in 1 string
//==============================================================================
function cvtPhnNum(phnobj)
{
   var phn = phnobj.value;   
   
   phn = phn.replace(/\(/g, ""); 
   phn = phn.replace(/\)/g, "");
   phn = phn.replace(/\-/g, "");
   phn = phn.replace(/ /g, "");
   
   return phn;
}
//==============================================================================
//replace all
//==============================================================================
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
//==============================================================================
// enforce salesperson to get customer answer
//==============================================================================
function getCustResp(type)
{
   var hdr = "Ask Customer";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCustRespPanel(type)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 200;
   document.all.dvStatus.style.top= getTopScreenPos() + 200;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popCustRespPanel(type)
{
  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr style='color:blue; background:#ccffcc;font-size:12px;font-weight:bold;text-align:center'>"
         + "<td colspan=3 nowrap>How did the customer hear about us?</td>"
       + "</tr>"
  for(var i=0; i < AnswText.length; i++)
  {
       panel += "<tr id='trTrans'><td class='Prompt' nowrap>" + AnswText[i] + "</td>"
            + "<td class='Prompt' nowrap><input class='radio' type='radio' name='Answ' value='" + AnswText[i] + "'></td>"
       panel += "<td class='Prompt'><input name='AddAnsw' size=25 maxlength=50";
       if(AnswReq[i] != "Y"){ panel += " type='hidden' " }
       panel += "></textarea></td>"
       panel += "</tr>"
  }
      panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
          + "<button onClick='validCustAnsw(&#34;" + type + "&#34;)' class='Small'>Submit</button>&nbsp;"
         "</td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// validate customer answer
//==============================================================================
function validCustAnsw(type)
{
   var error =false;
   var msg = "";

   var answsel = false;
   var answobj = document.all.Answ;
   var answ = null;
   var answText = null;
   for(var i=0; i < answobj.length; i++)
   {
      if(answobj[i].checked)
      {
         answ = answobj[i].value.trim();
         answText = document.all.AddAnsw[i].value.trim();
         answsel = true; break;
      }
   }
   if (!answsel){ error=true; msg+="\nSelect the answer."}
   else if(answ == "Other" && answText == "" ){ error=true; msg+="\nPlease, type customer answer." }

   if(error) alert(msg)
   else
   {
      SavType = type;
      Answer = answ;
      AnswerText = answText;
      saveOrderHdr(SavType);
   }
}

//==============================================================================
// save Order/Customer Header Information
//==============================================================================
function saveCustAnsw(order)
{
    Order = order;
    var commt = Answer + ". " + AnswerText;
    var cmtty = "CUST";
    commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='OrderHdrSave.jsp'>"
       + "<input class='Small' name='User'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Comments'>"
       + "<input class='Small' name='CommtType'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame2.document.appendChild(nwelem);

   window.frame2.document.all.User.value = "<%=sUser%>";
   window.frame2.document.all.Order.value = order;

   window.frame2.document.all.Comments.value=commt;
   window.frame2.document.all.CommtType.value=cmtty;
   window.frame2.document.all.Action.value="ADDCUSTRSP";

   //alert(html)
   window.frame2.document.frmAddComment.submit();
}
//==============================================================================
// save Order/Customer Header Information
//==============================================================================
function saveOrderHdr(type)
{
	var alwemail = "N"; 
	if( document.all.AllowEmail.checked ){alwemail = "Y"; };
	
	var specOrd = "";
	if(document.all.chbSpecOrd.checked){ specOrd = "Y"; }
	var custPickup = "";
	if(document.all.chbCustPup.checked){ custPickup = "Y"; }
	
	var url = "OrderHdrSave.jsp?Order=" + Order + "&User=<%=sUser%>"
           + "&Slsper=" + document.all.Slsper.value
           + "&DelDate=" + document.all.DelDate.value
           + "&Store=" + document.all.Store.value
           + "&ShpInstr=" + document.all.ShpInstr.value.replaceSpecChar()
           + "&LastName=" + document.all.LastName.value.toUpperCase()
           + "&FirstName=" + document.all.FirstName.value.toUpperCase()
           + "&Addr1=" + document.all.Addr1.value.toUpperCase().replaceSpecChar()
           + "&Addr2=" + document.all.Addr2.value.toUpperCase().replaceSpecChar()
           + "&City=" + document.all.City.value.toUpperCase()
           + "&State=" + document.all.State.value.toUpperCase()
           + "&Zip=" + document.all.Zip.value
           + "&DayPhn=" + cvtPhnNum(document.all.DayPhn)
           + "&EvtPhn=" + cvtPhnNum(document.all.EvtPhn)
           + "&ExtWorkPhn=" + document.all.ExtWorkPhn.value
           + "&CellPhn=" + cvtPhnNum(document.all.CellPhn)
           + "&EMail=" + document.all.EMail.value
           + "&AlwEml=" + alwemail
           + "&Type=" + type
           + "&Spo=" + specOrd
           + "&CPup=" + custPickup

   if(Exist)
   {
     url += "&Cust=" + Cust
          + "&Action=UPD" + type;
   }
   else
   {
       if(Cust != " "){ url += "&Cust=" + Cust + "&Action=ADD" + type; }
       else { url += "&Cust=0" + "&Action=ADD" + type; }
   }
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}

//==============================================================================
// Change Shipping Price
//==============================================================================
function setShpPrc(shp)
{
   document.all.ShpPrc.style.display="inline";
   document.all.ShpPrc.readOnly = false;
   document.all.ProtPlanPrc.style.display="none";   
   document.all.sbmShpPrc.style.display="inline";   

   if(shp==1)
   {
      document.all.ShpPrc.value = ShpPrc.trim();
      document.all.sbmShpPrc.innerHTML="Shipping";
      document.all.ShpType.value = "S";
   }
   else if(shp==2)
   {
      document.all.ShpPrc.value = DlvPrc.trim();
      document.all.sbmShpPrc.innerHTML="Delivery";
      document.all.ShpType.value = "D";
   }
   else if(shp==3)
   {
      document.all.ShpPrc.value = Tax.trim();
      document.all.sbmShpPrc.innerHTML="Tax";
      document.all.ShpType.value = "T";
   }
   else if(shp==4)
   {
      document.all.ShpPrc.value = "";
      document.all.sbmShpPrc.innerHTML="Paid";
      document.all.ShpType.value = "P";
   }

   else if(shp==5)
   {
      document.all.ShpPrc.value = DscAmt.trim();
      document.all.sbmShpPrc.innerHTML="Discount $";
      document.all.ShpType.value = "C";
   }
   else if(shp==6)
   {
      document.all.ShpPrc.value = "";
      document.all.sbmShpPrc.innerHTML="Discount %";
      document.all.ShpType.value = "E";
   }
   
   else if(shp==7)
   {
      document.all.ShpPrc.value = AssmbPrc.trim();
      document.all.sbmShpPrc.innerHTML="Assembly";
      document.all.ShpType.value = "A";
   }   
   else if(shp==8)
   {
	  document.all.ProtPlanPrc.style.display="inline";
	  document.all.ShpPrc.readOnly = true;
	  document.all.ProtPlanPrc.selectedIndex = 0;
      document.all.ShpPrc.value = ProtPlan.trim();
      document.all.sbmShpPrc.innerHTML="Protection Plan";
      document.all.ShpType.value = "R";
   }

   document.all.ShpPrc.select();
   document.all.ShpPrc.focus();
}
//==============================================================================
//set selected rpotective paln
//==============================================================================
function setProtPlan(sel)
{
	document.all.ShpPrc.value = sel.options[sel.selectedIndex].value.trim();
}
//==============================================================================
// save Shipping Price
//==============================================================================
function sbmShpPrc()
{
   var type = document.all.ShpType.value;
   var shpprc = document.all.ShpPrc.value.trim();
   var error = false;

   var tot = OrdTotal;
   // remove coma from total amount
   if(OrdTotal.indexOf(",") >0)
   {
      tot = OrdTotal.substring(0, OrdTotal.indexOf(",")) + OrdTotal.substring(OrdTotal.indexOf(",") + 1 )
   }

   // calculate discount if specified as procents
   if(type == "C" && shpprc.indexOf("%") > 0)
   {
      shpprc = shpprc.replace("%", "");
      if(!isNaN(shpprc.trim()))
      {
         shpprc = (eval(SubTot) * eval(shpprc) / 100).toFixed(2);                  
      }
   }

   if(shpprc.trim()=="") shpprc = "99";
   else if(isNaN(shpprc.trim())) { alert("Amount is not numreic"); error=true; }
   else if(shpprc < 0 ) { alert("Amount cannot be negative"); error=true; }
   else if(type == "P" && eval(shpprc) > eval(tot) ) { alert("Customer cannot pay more than total price."); error=true; }

   if (!error)
   {
      if(type == "E")
      {
         shpprc = (eval(removeComas(SubAftMD)) * eval(shpprc) / 100).toFixed(2);         
      }

      var url = "OrderHdrSave.jsp?Order=" + Order + "&User=<%=sUser%>"
           + "&ShpPrc=" + shpprc
      if(type == "S") url += "&Action=SHPPRC";
      else if(type == "C") url += "&Action=DSCAMT";
      else if(type == "E") url += "&Action=DSCAMT";
      else if(type == "D") url += "&Action=DLVPRC";
      else if(type == "A") url += "&Action=ASMPRC";      
      else if(type == "T") url += "&Action=OVRTAX";
      else if(type == "P") url += "&Action=PAIDBYCST";
      else if(type == "R") url += "&Action=PROPLAN";

      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
   }
}
//==============================================================================
// display error
//==============================================================================
function showPayProp()
{
   var hdr = "Last Order Payments";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPayPropPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 600;
   document.all.dvStatus.style.top= getTopScreenPos() + 400;
   document.all.dvStatus.style.visibility = "visible";

}
//==============================================================================
// payment property panel
//==============================================================================
function popPayPropPanel()
{
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr style='color:blue; background:#ccffcc;font-size:12px;font-weight:bold;text-align:right'>"
         + "<td nowrap>Reg</td>"
         + "<td nowrap>" + Reg + "</td>"
       + "</tr>"
       + "<tr style='color:blue; background:#ccffcc;font-size:12px;font-weight:bold;text-align:right'>"
         + "<td nowrap>Ticket#</td>"
         + "<td nowrap>" + Trans + "</td>"
       + "</tr>"
       + "<tr style='color:blue; background:#ccffcc;font-size:12px;font-weight:bold;text-align:right'>"
         + "<td nowrap>Paid Amount</td>"
         + "<td nowrap>$" + OrdPaid + "</td>"
       + "</tr>"


      panel += "<tr><td class='Prompt1' colspan='3'>"
            + "<button onClick='hidePanel();' class='Small'>Close</button>"
          + "</td></tr>"

     panel += "</table>";
  return panel;
}

//==============================================================================
// display error
//==============================================================================
function displayError(err)
{
   window.frame1.location.href="";
   window.frame1.close();
   msg = "";
   if(err[0] != "*MULTDISC")
   { 	
	   for(var i=0; i < err.length; i++)
	   { 
	   		msg += err[i] + "\n";
	   }
   }
   else
   {

       var msg = "This Item cannot be changed, OR deleted because it has a Multiple Discount applied."
		     + "\nAny Group or individual discount(s) associated with this item must be removed, before continuing.";
	   
   }

   document.all.Sku.value = "";
   document.all.Upc.value = "";
   
   alert(msg);
}
//==============================================================================
// restart application after heading entry
//==============================================================================
function reStart()
{
   var url = "OrderEntry.jsp?Order=" + Order
   window.location.href=url;
}

//==============================================================================
// restart application after heading entry
//==============================================================================
function reStartNewOrd(ord)
{
   var url = "OrderEntry.jsp?Order=" + ord 
	  + "&WarrDtl=Y"
   window.location.href=url;
}

//==============================================================================
// get item by SKU
//==============================================================================
function getSku(sku, action)
{
   if(sku.value == "5487251" && SpecOrd == "Y" || sku.value != "5487251" && SpecOrd != "Y")
   {
	   	var inpQty = "Qty" + Str
   		document.all[inpQty].focus();
   		var url = "PsOrdGetItem.jsp?Order=" + Order
   		if(action=="ADD") url += "&Sku=" + sku.value + "&Action=" + action
   		else url += "&Sku=" + sku + "&Action=" + action
   		if(action=="UPD"  || document.all.Sku.value.trim() != "" && !document.all.Sku.readOnly)
   		{
      		//window.location.href=url
      		window.frame1.location.href=url
      		document.all.Qty46.select();
   		}
   }
   else
   {
	   if(sku.value == "5487251" && SpecOrd != "Y"){ alert("Special Order Item is not allowed for this order."); }
	   if(sku.value != "5487251" && SpecOrd == "Y"){ alert("Regular Item is not allowed for this special order."); }
   }
}

//==============================================================================
// get item by UPC
//==============================================================================
function getUpc(upc, action)
{
   var inpQty = "Qty" + Str
   document.all[inpQty].focus();
   var url = "PsOrdGetItem.jsp?Order=" + Order + "&Upc=" + upc.value + "&Action=" + action
   if(upc.value.trim() != "" && !document.all.Upc.readOnly)
   {
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      document.all.Qty46.select();
   }
}
//==============================================================================
// check P.O. Number
//==============================================================================
function checkPON(ponum)
{
   var url = "PfsChkPO.jsp?PoNum=" + ponum.value.trim();
   if(ponum.value.trim() != "" && !ponum.readOnly)
   {
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
   }
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function savePONum()
{
   document.all.thSoChg.style.display=block;
   document.all.tdSoChg.style.display=block;

   document.all.SoDesc.readOnly = true;
   document.all.SoQty.readOnly = true;
   document.all.SoPrice.readOnly = true;
   document.all.SoFrmClr.readOnly = true;
   document.all.SoFrmMat.readOnly = true;
   document.all.SoFabClr.readOnly = true;
   document.all.SoFabNum.readOnly = true;
   document.all.SoComment.readOnly = true;

   window.frame1.close();
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddLine(desc, sku, upc, set, price, group
   , qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55
   , sugprc, tempPrc, clrnm, vennm, vensty, itmpoqty, disconn, action)
{
   if(action=="ADD")
   {
     document.all.tdDesc.innerHTML = desc;
     document.all.Sku.value = sku;
     document.all.Upc.value = upc;
     document.all.Sku.readOnly = true;
     document.all.Upc.readOnly = true;
     document.all.Price.value = removeComas(price);
     document.all.thTake.style.display="none";
     document.all.tdTake.style.display="none";
   }
   document.all.tdGroup.innerHTML = removeComas(group);

   if(set == "0" || set == "2")
   {
      document.all.tdQty35.innerHTML = qty35[4];
      document.all.tdQty46.innerHTML = qty46[4];
      document.all.tdQty50.innerHTML = qty50[4];
      document.all.tdQty86.innerHTML = qty86[4];
      document.all.tdQty63.innerHTML = qty63[4];
      document.all.tdQty64.innerHTML = qty64[4];
      document.all.tdQty68.innerHTML = qty68[4];
      document.all.tdQty55.innerHTML = qty55[4];

      //total inventory
      var totqty = 0;
      if(Str ==  "35" || Str ==  "46" || Str ==  "50")
      {
         if(Str != 35){ totqty += eval(qty35[4]); }
         if(Str != 46){ totqty += eval(qty46[4]); }
         if(Str != 50){ totqty += eval(qty50[4]); }
         if(Str != 86){ totqty += eval(qty86[4]); }
      }
      else if( Str ==  "86" )
      {
         totqty += eval(qty35[4]) + eval(qty46[4]) + eval(qty50[4]) + eval(qty63[4])
                 + eval(qty64[4]) + eval(qty68[4]) + eval(qty55[4]);
      }
      else
      {
         if(Str != 63){ totqty += eval(qty63[4]); }
         if(Str != 64){ totqty += eval(qty64[4]); }
         if(Str != 68){ totqty += eval(qty68[4]); }
         if(Str != 55){ totqty += eval(qty55[4]); }
         if(Str != 86){ totqty += eval(qty86[4]); }
      }
      document.all.tdQtyOth.innerHTML = totqty;

      document.all.SetQty.readOnly = true;
      document.all.Qty35.readOnly = false;
      document.all.Qty46.readOnly = false;
      document.all.Qty50.readOnly = false;
      document.all.Qty86.readOnly = false;
      document.all.Qty63.readOnly = false;
      document.all.Qty64.readOnly = false;
      document.all.Qty68.readOnly = false;
      document.all.Qty55.readOnly = false;
      //if (Str == 86) { document.all.Qty86.focus(); }
      //else { document.all.Qty46.focus(); }
   }
   else
   {
      document.all.thSetTot.style.display = block;
      document.all.tdAddSetTot.style.display = block;
      document.all.SetQty.readOnly = false;
      document.all.Qty35.readOnly = true;
      document.all.Qty46.readOnly = true;
      document.all.Qty50.readOnly = true;
      document.all.Qty86.readOnly = true;
      document.all.Qty63.readOnly = true;
      document.all.Qty64.readOnly = true;
      document.all.Qty68.readOnly = true;
      document.all.Qty55.readOnly = true;

      document.all.SetQty.focus();
      document.all.tdQtyOth.innerHTML = "&nbsp;";
      document.all.tdQtyInpOth.innerHTML = "&nbsp;";
   }
   document.all.tdSugPrc.innerHTML = removeComas(sugprc);
}

//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddSetLines(numofset, setdesc, setsku, setupc, setprice, setgroup
  , setqty35, setqty46, setqty50, setqty86, setqty63, setqty64, setqty68, setqty55
  , setsugprc, settot, setuntprc,
  settempprc, setclrnm, setvennm, setvensty, setitmpoqty, setdisconn, action)
{
   NumOfSet = numofset;
   SetSku = setsku;
   SetUpc = setupc;
   SetDesc = setdesc;
   SetQty35 = setqty35;
   SetQty46 = setqty46;
   SetQty50 = setqty50;
   SetQty86 = setqty86;
   SetQty63 = setqty63;
   SetQty64 = setqty64;
   SetQty68 = setqty68;
   SetQty55 = setqty55;
   SetTot = settot;

   var othstr = false;

   for(var i=0; i < numofset; i++)
   {
      if(action=="ADD")
      {
         document.all.trSet[i].style.display=block;
         document.all.tdSetDesc[i].innerHTML = setdesc[i];
         document.all.tdSetSku[i].innerHTML = setsku[i] + " / " + setupc[i];
         document.all.tdSetTake[i].style.display="none";
      }
      document.all.tdSetGroup[i].innerHTML = setgroup[i];
      document.all.tdSetQty35[i].innerHTML = setqty35[i][4];
      document.all.tdSetQty46[i].innerHTML = setqty46[i][4];
      document.all.tdSetQty50[i].innerHTML = setqty50[i][4];
      document.all.tdSetQty86[i].innerHTML = setqty86[i][4];
      document.all.tdSetQty63[i].innerHTML = setqty63[i][4];
      document.all.tdSetQty64[i].innerHTML = setqty64[i][4];
      document.all.tdSetQty68[i].innerHTML = setqty68[i][4];
      document.all.tdSetQty55[i].innerHTML = setqty55[i][4];
      document.all.tdSetTot[i].innerHTML = settot[i];
      document.all.tdSetSugPrc[i].innerHTML = setsugprc[i];

      var totqty = 0;
      if(Str ==  "35" || Str ==  "46" || Str ==  "50")
      {
         if(Str != 35){ totqty += eval(setqty35[i][4]); }
         if(Str != 46){ totqty += eval(setqty46[i][4]); }
         if(Str != 50){ totqty += eval(setqty50[i][4]); }
         if(Str != 86){ totqty += eval(setqty86[i][4]); }
      }
      else if( Str ==  "86" )
      {
         totqty += eval(setqty35[i][4]) + eval(setqty46[i][4]) + eval(setqty50[i][4])
                 + eval(setqty63[i][4]) + eval(setqty64[i][4]) + eval(setqty68[i][4])
                 + eval(setqty55[i][4]);
      }
      else
      {
         if(Str != 63){ totqty += eval(setqty63[i][4]); }
         if(Str != 64){ totqty += eval(setqty64[i][4]); }
         if(Str != 68){ totqty += eval(setqty68[i][4]); }
         if(Str != 55){ totqty += eval(setqty55[i][4]); }
         if(Str != 86){ totqty += eval(setqty86[i][4]); }
      }
      document.all.tdSetQtyOth[i].innerHTML = totqty;

      for(var j=0; j < ArrStr.length; j++)
      {
         if(Str == ArrStr[j])
         {
            for(var k=0; k < arrTds[j].length; k++)
            {
               arrTds[j][k].style.display = block; arrTdsi[j][k].style.display = block;
            }
         }
       else
       {
          for(var k=0; k < arrTds[j].length; k++)
          {
             arrTds[j][k].style.display = "none"; arrTdsi[j][k].style.display = "none";
          }
       }
      }

   }

   window.frame1.close();
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddSpecOrd(desc, sku, upc, action)
{
   showSoTbl(true);

   if(action=="ADD")
   {
     document.all.tdSoSku.innerHTML = sku;
     document.all.SoPrice.value = "";
     document.all.SoFrmClr.value = "";
     document.all.SoFrmMat.value = "";
     document.all.SoFabClr.value = "";
     document.all.SoFabNum.value = "";
     document.all.SoComment.value = "";
     document.all.SoPoNum.value = "";
     document.all.SoQty.value = "1";
     document.all.SoVen.select();

     // changes to add item line
     document.all.tdDesc.innerHTML = desc;
     document.all.Sku.value = sku;
     document.all.Upc.value = upc;
     document.all.Sku.readOnly = true;
     document.all.Upc.readOnly = true;
     document.all.SetQty.readOnly = true;
     document.all.Qty35.readOnly = true;
     document.all.Qty46.readOnly = true;
     document.all.Qty50.readOnly = true;
     document.all.Qty86.readOnly = true;
     document.all.Qty63.readOnly = true;
     document.all.Qty64.readOnly = true;
     document.all.Qty68.readOnly = true;
     document.all.Qty55.readOnly = true;
     document.all.Price.readOnly = true;

     document.all.thAdd.style.display = "none";
     document.all.tdAdd.style.display = "none";
   }
   if(SpoVen.length > 0)
   {
     window.frame1.close();
     window.frame1.location.href=null;
     showVenLst();
   }
   else { getVen(); } // get list of vendor for special order
}

//==============================================================================
// calculate payroll hours
//==============================================================================
function removeComas(number)
{
   var number1 = "";
   var neg = false
   for(var i=0; i < number.length; i++)
   {
      if (number.substring(i, i+1) != "," && number.substring(i, i+1) != "-")
      {
        number1 += number.substring(i, i+1);
      }
      else if(number.substring(i, i+1) == "-"){neg = true;}
   }

   if(neg) { number1 = number1 * (-1) };
   return number1;
}
//==============================================================================
// check vendor entry field
//==============================================================================
function chkVen(obj)
{
	if(obj.value.trim() == "")
	{
		getVen();
	}
}
//==============================================================================
// get Vendor information
//==============================================================================
function getVen()
{
   var url = "PsOrdGetVen.jsp?"
   //window.location.href=url
   window.frame1.location.href=url
   document.all.SoVenSty.select();
}
//==============================================================================
// populate vendor information
//==============================================================================
function popVenInfo(ven, venname, addr1, addr2, city, state, zip, phone)
{
   SpoVen = ven;
   SpoVenName = venname;
   SpoVenAddr1 = addr1;
   SpoVenAddr2 = addr2;
   SpoVenCity = city;
   SpoVenState = state;
   SpoVenPhn = phone;

   showVenLst();

   window.frame1.close();
}
//==============================================================================
// show panel of vendor information
//==============================================================================
function showVenLst()
{
   var hdr = "Vendor List for Special Order";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popVenPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.width = 400;
   document.all.dvStatus.style.left= getLeftScreenPos() + 200;
   document.all.dvStatus.style.top= getTopScreenPos() + 135;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popVenPanel()
{
  var posX = getLeftScreenPos() + 600;
  var posY = getTopScreenPos() + 60;

  var panel = "<table class='DataTable' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr class='DataTable4'><th class='DataTable2'>Vendor<br>Number</th>"
        + "<th class='DataTable2'>Vendor<br>Name</th>"
        + "<th class='DataTable2'>Phone Number</th>"
      + "</tr>"
      + "<tr>"
   for(var i=0; i < SpoVen.length; i++)
   {
      panel += "<tr class='DataTable1'>"
             + "<td class='DataTable3'><a href='javascript:setSelVendor(" + i + ")'>" + SpoVen[i] + "</a></td>"
             + "<td class='DataTable7' nowrap>" + SpoVenName[i] + "</td>"
             + "<td class='DataTable3' nowrap>" + SpoVenPhn[i] + "</td>"
            + "</tr>"
   }

   panel += "&nbsp;" + "<tr class='DataTable5'><td class='DataTable2' colspan=3><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// set selected Vendor
//==============================================================================
function setSelVendor(arg)
{
  document.all.SoVen.value = SpoVen[arg];
  document.all.tdSoVenInfo.innerHTML = SpoVenName[arg];
  hidePanel();
}
//==============================================================================
// process Item: add/update/delete
//==============================================================================
function processLine(action)
{
   var sku = document.all.Sku.value;
   var upc = document.all.Upc.value;

   var desc = document.all.tdDesc.innerHTML;
   var qty35 = document.all.Qty35.value;
   var qty46 = document.all.Qty46.value;
   var qty50 = document.all.Qty50.value;
   var qty86 = document.all.Qty86.value;
   var qty63 = document.all.Qty63.value;
   var qty64 = document.all.Qty64.value;
   var qty68 = document.all.Qty68.value;
   var qty55 = document.all.Qty55.value;
   var setqty = document.all.SetQty.value;
   var price = document.all.Price.value;
   var group = document.all.tdGroup.innerHTML;
   var set = NumOfSet > 0;

   // set components
   var setqty35 = new Array(NumOfSet);
   var setqty46 = new Array(NumOfSet);
   var setqty50 = new Array(NumOfSet);
   var setqty86 = new Array(NumOfSet);
   var setqty63 = new Array(NumOfSet);
   var setqty64 = new Array(NumOfSet);
   var setqty68 = new Array(NumOfSet);
   var setqty55 = new Array(NumOfSet);

   for(var i=0; i < NumOfSet; i++)
   {
      setqty35[i] = document.all.SetQty35[i].value;
      setqty46[i] = document.all.SetQty46[i].value;
      setqty50[i] = document.all.SetQty50[i].value;
      setqty86[i] = document.all.SetQty86[i].value;
      setqty63[i] = document.all.SetQty63[i].value;
      setqty64[i] = document.all.SetQty64[i].value;
      setqty68[i] = document.all.SetQty68[i].value;
      setqty55[i] = document.all.SetQty55[i].value;
   }


   // validate entry - return without adding if any error
   if( Validate(sku, upc, set, qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55, setqty, price, group)
      || (set && ValidateSet(setqty35, setqty46, setqty50, setqty86, setqty63, setqty64, setqty68, setqty55
                              , setqty)) )
   {  return;  }
   else
   {
      if(isNaN(qty35) || qty35.trim()=="") qty35 = 0;
      if(isNaN(qty46) || qty46.trim()=="") qty46 = 0;
      if(isNaN(qty50) || qty50.trim()=="") qty50 = 0;
      if(isNaN(qty86) || qty86.trim()=="") qty86 = 0;
      if(isNaN(qty63) || qty63.trim()=="") qty63 = 0;
      if(isNaN(qty64) || qty64.trim()=="") qty64 = 0;
      if(isNaN(qty68) || qty68.trim()=="") qty68 = 0;
      if(isNaN(qty55) || qty55.trim()=="") qty55 = 0;

      var total = (price * (eval(qty35) + eval(qty46) + eval(qty50) + eval(qty86)
         + eval(qty63) + eval(qty64) + eval(qty68)  + eval(qty55) )).toFixed(2)

      // add line to file
      var url= "OrderDtlSave.jsp?Order=<%=sOrdNum%>&User=<%=sUser%>"    		  
            + "&Sku=" + sku
            + "&Qty35=" + qty35
            + "&Qty46=" + qty46
            + "&Qty50=" + qty50
            + "&Qty86=" + qty86
            + "&Qty63=" + qty63
            + "&Qty64=" + qty64
            + "&Qty68=" + qty68
            + "&Qty55=" + qty55
            + "&SetQty=" + setqty

       if(set) url += "&Set=Y";
       else url += "&Set=N";

       // save component
       for(var i=0; i < NumOfSet; i++)
       {
          url += "&SetSku=" + SetSku[i]
               + "&SetQty35=" + setqty35[i]
               + "&SetQty46=" + setqty46[i]
               + "&SetQty50=" + setqty50[i]
               + "&SetQty86=" + setqty86[i]
               + "&SetQty63=" + setqty63[i]
               + "&SetQty64=" + setqty64[i]
               + "&SetQty68=" + setqty68[i]
               + "&SetQty55=" + setqty55[i]
       }

       url += "&Price=" + price
            + "&Action=" + action

      //alert(url)
      window.frame1.location.href=url

     // clear line
     clrLine();
  }
}

//==============================================================================
// process Special orders Items
//==============================================================================
function processSoLine(action)
{
   var sku = document.all.tdSoSku.innerHTML;
   var ven = document.all.SoVen.value.replaceSpecChar();
   var vensty = document.all.SoVenSty.value.replaceSpecChar();
   var desc = document.all.SoDesc.value.replaceSpecChar();
   var qty = document.all.SoQty.value;
   var price = document.all.SoPrice.value;
   var frmclr = document.all.SoFrmClr.value.replaceSpecChar();
   var frmmat = document.all.SoFrmMat.value.replaceSpecChar();
   var fabclr = document.all.SoFabClr.value.replaceSpecChar();
   var fabnum = document.all.SoFabNum.value.replaceSpecChar();
   var comment = document.all.SoComment.value.replaceSpecChar();
   var ponum = document.all.SoPoNum.value;

   // validate entry - return without adding if any error
   if( ValidateSpc(sku, ven, vensty, desc, qty, price, frmclr, frmmat, fabclr, fabnum, comment, ponum)) {  return;  }
   else
   {
      // add line to file
      var url= "OrderDtlSave.jsp?Order=<%=sOrdNum%>&User=<%=sUser%>"
            + "&Ven=" + ven
            + "&VenSty=" + vensty
            + "&Desc=" + desc
            + "&Sku=" + sku
            + "&SetQty=" + qty
            + "&Price=" + price
            + "&FrmClr=" + frmclr
            + "&FrmMat=" + frmmat
            + "&FabClr=" + fabclr
            + "&FabNum=" + fabnum
            + "&Comment=" + comment
            + "&PoNum=" + ponum
            + "&Action=" + action

      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url

     // clear line
     clrLine();
  }
}

//---------------------------------------------------------
// update/detlete Item
//---------------------------------------------------------
function updLine(arg)
{
   clrLine();
    
   document.all.tdDetail.style.display=block;
   
   CurrArg = arg;

   document.all.tdDesc.innerHTML = Desc[arg];
   document.all.Sku.value = Sku[arg];
   document.all.Upc.value = Upc[arg];
   document.all.Sku.readOnly = true;
   document.all.Upc.readOnly = true;

   document.all.Qty35.value = Qty35[arg];
   document.all.Qty46.value = Qty46[arg];
   document.all.Qty50.value = Qty50[arg];
   document.all.Qty86.value = Qty86[arg];
   document.all.Qty63.value = Qty63[arg];
   document.all.Qty64.value = Qty64[arg];
   document.all.Qty68.value = Qty68[arg];
   document.all.Qty55.value = Qty55[arg];
   document.all.SetQty.value = SkuQty[arg]; //total sku quantity

   document.all.Price.value = Ret[arg];

   document.all.thAdd.style.display="none";
   document.all.tdAdd.style.display="none";
   document.all.thTake.style.display=block;
   document.all.tdTake.style.display=block;
      
   
   if(Str != EntStore && EntStore != "Home Office") 
   {
	   document.all.thChg.style.display="none";
	   document.all.thApplGrp.style.display="none";
	   document.all.thDlt.style.display="none";
	   document.all.tdChg.style.display="none";
	   document.all.tdApplGrp.style.display="none";
	   document.all.tdDlt.style.display="none";	 
	   document.all.thTake.style.display="none";
	   document.all.tdTake.style.display="none"; 
   }
   else if(Sts != "C" && Sts != "D" && Sts != "R" && Sts != "Z" && Sts != "E")
   {
      document.all.thChg.style.display=block;
      document.all.thApplGrp.style.display=block;
      document.all.thDlt.style.display=block;
      document.all.tdChg.style.display=block;
      document.all.tdApplGrp.style.display=block;
      document.all.tdDlt.style.display=block;
   }
   else
   {
      document.all.thChg.style.display="none";
      document.all.thApplGrp.style.display="none";
      document.all.thDlt.style.display="none";
      document.all.tdChg.style.display="none";
      document.all.tdApplGrp.style.display="none";
      document.all.tdDlt.style.display="none";
   }

   if(UpdSetSku[arg].length == 0) { document.all.spnTake[0].style.display=block; document.all.spnTake[1].style.display="none";}
   else{ document.all.spnTake[0].style.display="none";  document.all.spnTake[1].style.display=block;}

   for(var i=0; i < UpdSetSku[arg].length; i++)
   {
      document.all.trSet[i].style.display=block;
      document.all.tdSetDesc[i].innerHTML = UpdSetDesc[arg][i];
      document.all.tdSetSku[i].innerHTML = UpdSetSku[arg][i] + " / " + UpdSetUpc[arg][i];
      document.all.SetQty35[i].value = UpdSetQty35[arg][i];
      document.all.SetQty46[i].value = UpdSetQty46[arg][i];
      document.all.SetQty50[i].value = UpdSetQty50[arg][i];
      document.all.SetQty86[i].value = UpdSetQty86[arg][i];
      document.all.SetQty63[i].value = UpdSetQty63[arg][i];
      document.all.SetQty64[i].value = UpdSetQty64[arg][i];
      document.all.SetQty68[i].value = UpdSetQty68[arg][i];
      document.all.SetQty55[i].value = UpdSetQty55[arg][i];

      var totqty = 0;
      if(Str != 35){ totqty += eval(UpdSetQty35[arg][i]); }
      if(Str != 46){ totqty += eval(UpdSetQty46[arg][i]); }
      if(Str != 50){ totqty += eval(UpdSetQty50[arg][i]); }
      if(Str != 86){ totqty += eval(UpdSetQty86[arg][i]); }
      if(Str != 63){ totqty += eval(UpdSetQty63[arg][i]); }
      if(Str != 64){ totqty += eval(UpdSetQty64[arg][i]); }
      if(Str != 68){ totqty += eval(UpdSetQty68[arg][i]); }
      if(Str != 55){ totqty += eval(UpdSetQty55[arg][i]); }
      document.all.tdSetQtyOthi[i].innerHTML = totqty;
   }

   //total selected quantity
   var totqty = 0;
   if(Str != 35){ totqty += eval(Qty35[arg]); }
   if(Str != 46){ totqty += eval(Qty46[arg]); }
   if(Str != 50){ totqty += eval(Qty50[arg]); }
   if(Str != 86){ totqty += eval(Qty86[arg]); }
   if(Str != 63){ totqty += eval(Qty63[arg]); }
   if(Str != 64){ totqty += eval(Qty64[arg]); }
   if(Str != 68){ totqty += eval(Qty68[arg]); }
   if(Str != 55){ totqty += eval(Qty55[arg]); }
   document.all.tdQtyInpOth.innerHTML = totqty;

   getSku(Sku[arg], "UPD");

}
//---------------------------------------------------------
// update/detlete Special Order Items
//---------------------------------------------------------
function updSoLine(arg)
{
   clrLine();
   document.all.tdDetail1.style.display=block;
   showSoTbl(true);

   document.all.tdSoSku.innerHTML = SoSku[arg];
   document.all.SoVen.value = SoVen[arg];
   document.all.tdSoVenInfo.innerHTML = SoVenName[arg];
   document.all.SoVenSty.value = SoVenSty[arg];
   document.all.SoVen.readOnly = true;
   document.all.SoVenSty.readOnly = true;
   document.all.SoDesc.value = SoDesc[arg];
   document.all.SoQty.value = SoQty[arg];
   document.all.SoPrice.value = SoRet[arg];
   document.all.SoFrmClr.value = SoFrmClr[arg];
   document.all.SoFrmMat.value = SoFrmMat[arg];
   document.all.SoFabClr.value = SoFabClr[arg];
   document.all.SoFabNum.value = SoFabNum[arg];
   document.all.SoComment.value = SoComment[arg].showSpecChar();
   document.all.SoPoNum.value = SoPoNum[arg];

   document.all.thSoAdd.style.display="none";
   document.all.tdSoAdd.style.display="none";

   if(Sts == "Q" || PySts == "O" || PySts == "F" || Sts == "T")
   {
      document.all.thSoChg.style.display=block;
      document.all.tdSoChg.style.display=block;
   }
   else
   {
      document.all.tdSoChg.style.display="none";
      document.all.thSoChg.style.display="none";
   }

   if(Sts != "C" && Sts != "D" && Sts != "E")
   {
      document.all.thSoDlt.style.display = block;
      document.all.tdSoDlt.style.display = block;
   }
   else
   {
      document.all.tdSoDlt.style.display="none";
      document.all.thSoDlt.style.display="none";
      document.all.SoVenSty.readOnly = true;
      document.all.SoDesc.readOnly = true;
      document.all.SoQty.readOnly = true;
      document.all.SoPrice.readOnly = true;
      document.all.SoFrmClr.readOnly = true;
      document.all.SoFrmMat.readOnly = true;
      document.all.SoFabClr.readOnly = true;
      document.all.SoFabNum.readOnly = true;
      document.all.SoComment.readOnly = true;
   }
}
//---------------------------------------------------------
// validate line entry
//---------------------------------------------------------
function Validate(sku, upc, set, qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55, setqty, price, group)
{
   var error = false;
   var msg = "";
   if(sku.trim()=="")
   {
      msg += "Sku is not entered.\n";
      document.all.Sku.select();
      error = true;
   }

   // check entered quantity
   if(isNaN(qty35))
   {
      msg += "Quantity for store 35 is not numeric.\n";
      document.all.Qty35.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty46))
   {
      msg += "Quantity for store 46 is not numeric.\n";
      document.all.Qty46.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty50))
   {
      msg += "Quantity for store 50 is not numeric.\n";
      document.all.Qty50.select();
      error = true;
   }

   // check entered quantity
   if(isNaN(qty86))
   {
      msg += "Quantity for store 86 is not numeric.\n";
      document.all.Qty86.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty63))
   {
      msg += "Quantity for store 63 is not numeric.\n";
      document.all.Qty63.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty64))
   {
      msg += "Quantity for store 64 is not numeric.\n";
      document.all.Qty64.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty68))
   {
      msg += "Quantity for store 68 is not numeric.\n";
      document.all.Qty68.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty55))
   {
      msg += "Quantity for store 55 is not numeric.\n";
      document.all.Qty55.select();
      error = true;
   }

   // check entered quantity
   if(isNaN(setqty))
   {
      msg += "Quantity for set is not numeric.\n";
      document.all.SetQty.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(price))
   {
      msg += "Price is not numeric.\n";
      document.all.Price.select();
      error = true;
   }

   // check entered quantity
   if(!error && !set && (qty35 + qty46 + qty50 + qty86 + qty63 + qty64 + qty68 + qty55) <=0 )
   {
      msg += "You must select at least 1 item.\n";
      error = true;
   }
   else if(!error && set && setqty <=0 )
   {
      msg += "You must select at least 1 set.\n";
      error = true;
   }
   
   // check if single item extended price is to high
   var extItemPrc = clcItemExtPrice(set, qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55, setqty, price);
   if(!set && extItemPrc > 99999 )
   {
	   msg += "Extended Item Price is too high.\n";
	   error = true;
   }
   else if(!error && set && (setqty * price) > 999999 )
   {
      msg += "Extended Item Price is too high.\n";
      error = true;
   }
   
   

   if (error) alert(msg);
   return error;
}
//---------------------------------------------------------
// calculate Item or set extended price
//---------------------------------------------------------
function clcItemExtPrice(set, qty35, qty46, qty50, qty86, qty63, qty64, qty68, qty55, setqty, price)
{
	var extprc = 0;
	if(!set)
	{
		extprc = (cvtNum(qty35) + cvtNum(qty46) + cvtNum(qty50) + cvtNum(qty86) +  cvtNum(qty63) 
		 + cvtNum(qty64) + cvtNum(qty68) + cvtNum(qty55)) * cvtNum(price);
	}
	else
	{
		extprc = cvtNum(setqty) * price;
	}
	
	return extprc;
}
//---------------------------------------------------------
//calculate Item or set extended price
//---------------------------------------------------------
function cvtNum(val)
{ 
	var num = 0;
	if(val != ""){ num = eval(val); }
	return num;
}
//---------------------------------------------------------
// validate line entry
//---------------------------------------------------------
function ValidateSet(setqty35, setqty46, setqty50, setqty86, setqty63, setqty64, setqty68, setqty55, setqty)
{
   var error = false;
   var errors = new Array(10);
   var msg = "";
   var sumqty = new Array(NumOfSet);

   for(var i=0; i < NumOfSet; i++)
   {
      if(sumqty[i]==null) sumqty[i]=0;
      // check entered quantity
      if(isNaN(setqty35[i]))  { document.all.SetQty35[i].select(); errors[0] = true; }
      else if(setqty35[i].trim() !="" && setqty35[i].trim() !=" "){sumqty[i] += eval(setqty35[i]) }

      if(isNaN(setqty46[i]))  { document.all.SetQty46[i].select(); errors[1] = true; }
      else if(setqty46[i].trim() !="" && setqty46[i].trim() !=" "){sumqty[i] += eval(setqty46[i]) }

      if(isNaN(setqty50[i]))  { document.all.SetQty50[i].select(); errors[2] = true; }
      else if(setqty50[i].trim() !="" && setqty50[i].trim() !=" "){sumqty[i] += eval(setqty50[i]) }

      if(isNaN(setqty86[i]))  { document.all.SetQty86[i].select(); errors[3] = true; }
      else if(setqty86[i].trim() !="" && setqty86[i].trim() !=" "){sumqty[i] += eval(setqty86[i]) }

      if(isNaN(setqty63[i]))  { document.all.SetQty63[i].select(); errors[4] = true; }
      else if(setqty63[i].trim() !="" && setqty63[i].trim() !=" "){sumqty[i] += eval(setqty63[i]) }

      if(isNaN(setqty64[i]))  { document.all.SetQty64[i].select(); errors[5] = true; }
      else if(setqty64[i].trim() !="" && setqty64[i].trim() !=" "){sumqty[i] += eval(setqty64[i]) }

      if(isNaN(setqty68[i]))  { document.all.SetQty68[i].select(); errors[6] = true; }
      else if(setqty68[i].trim() !="" && setqty68[i].trim() !=" "){sumqty[i] += eval(setqty68[i]) }

      if(isNaN(setqty55[i]))  { document.all.SetQty55[i].select(); errors[6] = true; }
      else if(setqty55[i].trim() !="" && setqty55[i].trim() !=" "){sumqty[i] += eval(setqty55[i]) }
   }

   if (errors[0]) { msg += "Quantity for store 35 is not numeric.\n"; error = true; }
   if (errors[1]) { msg += "Quantity for store 46 is not numeric.\n"; error = true; }
   if (errors[2]) { msg += "Quantity for store 50 is not numeric.\n"; error = true; }
   if (errors[3]) { msg += "Quantity for store 86 is not numeric.\n"; error = true; }
   if (errors[4]) { msg += "Quantity for store 63 is not numeric.\n"; error = true; }
   if (errors[5]) { msg += "Quantity for store 64 is not numeric.\n"; error = true; }
   if (errors[6]) { msg += "Quantity for store 68 is not numeric.\n"; error = true; }
   if (errors[7]) { msg += "Quantity for store 55 is not numeric.\n"; error = true; }

   // check if number of required component is equal set quantity
   if(!error)
   {
      for(var i=0; i < NumOfSet; i++)
      {
         if(sumqty[i] != SetTot[i] * setqty)
         {
           msg += "Total number of " + SetSku[i] + " - " + sumqty[i]
                + ", must be " + SetTot[i] * setqty + "\n";
           document.all.tdSetSku[i].style.backgroundColor="yellow";
           error = true;
         }
         else { document.all.tdSetSku[i].style.backgroundColor="#e7e7e7";  }
      }
   }

   if (error) alert(msg);
   return error;
}
//---------------------------------------------------------
// validate line special order item entry
//---------------------------------------------------------
function ValidateSpc(sku, ven, vensty, desc, qty, price, frmclr, frmmat, fabclr, fabnum, comment, ponum)
{
   var error = false;
   var msg = "";
   if(sku.trim()=="")
   {
      msg += "Sku is not entered.\n";
      error = true;
   }
   if(ven.trim()=="")
   {
      msg += "Vendor is not entered.\n";
      document.all.SoVen.select();
      error = true;
   }
   if(vensty.trim()=="")
   {
      msg += "Vendor Style is not entered.\n";
      document.all.SoVenSty.select();
      error = true;
   }
   if(desc.trim()=="")
   {
      msg += "Description is not entered.\n";
      document.all.SoDesc.select();
      error = true;
   }

   // check entered quantity
   if(isNaN(qty))
   {
      msg += "Quantity is not numeric.\n";
      document.all.SoQty.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(price))
   {
      msg += "Price is not numeric.\n";
      document.all.SoPrice.select();
      error = true;
   }
   // check entered quantity
   if(price.trim()=="")
   {
      msg += "Price is not entered.\n";
      document.all.SoPrice.select();
      error = true;
   }

   // check entered quantity
   if(!error && qty <=0 )
   {
      msg += "You must select at least 1 item.\n";
      error = true;
   }

   if (error) alert(msg);
   return error;
}
//==============================================================================
// clear "Adding line" row.
//==============================================================================
function clrLine()
{

   NumOfSet = 0;
   document.all.tdDesc.innerHTML = "&nbsp;";
   document.all.Sku.value = "";
   document.all.Upc.value = "";
   document.all.Sku.readOnly = false;
   document.all.Upc.readOnly = false;

   document.all.tdQty35.innerHTML = "&nbsp;";
   document.all.Qty35.value = "";
   document.all.tdQty46.innerHTML = "&nbsp;";
   document.all.Qty46.value = "";
   document.all.tdQty50.innerHTML = "&nbsp;";
   document.all.Qty50.value = "";document.all.SetQty.value = "";
   document.all.tdQty86.innerHTML = "&nbsp;";
   document.all.Qty86.value = "";document.all.SetQty.value = "";
   document.all.tdQty63.innerHTML = "&nbsp;";
   document.all.Qty63.value = "";document.all.SetQty.value = "";
   document.all.tdQty64.innerHTML = "&nbsp;";
   document.all.Qty64.value = "";document.all.SetQty.value = "";
   document.all.tdQty68.innerHTML = "&nbsp;";
   document.all.Qty68.value = "";document.all.SetQty.value = "";
   
   document.all.Price.value = "";
   document.all.tdGroup.innerHTML = "&nbsp;";

   document.all.thAdd.style.display=block;
   document.all.tdAdd.style.display=block;
   document.all.thChg.style.display="none";
   document.all.thApplGrp.style.display="none";
   document.all.thDlt.style.display="none";
   document.all.tdChg.style.display="none";
   document.all.tdApplGrp.style.display="none";
   document.all.tdDlt.style.display="none";
   document.all.thTake.style.display="none";
   document.all.tdTake.style.display="none";

   document.all.thSoAdd.style.display=block;
   document.all.tdSoAdd.style.display=block;
   document.all.thSoChg.style.display="none";
   document.all.thSoDlt.style.display="none";
   document.all.tdSoChg.style.display="none";
   document.all.tdSoDlt.style.display="none";

   document.all.thSetTot.style.display = "none";
   document.all.tdAddSetTot.style.display = "none";

   document.all.tdSoSku.innerHTML = "&nbsp;";
   document.all.SoVen.value = "";
   document.all.SoVenSty.value = "";
   document.all.SoDesc.value = "";
   document.all.SoQty.value = "";
   document.all.SoPrice.value = "";
   document.all.SoFrmClr.value = "";
   document.all.SoFrmMat.value = "";
   document.all.SoFabClr.value = "";
   document.all.SoFabNum.value = "";
   document.all.SoComment.value = "";
   document.all.SoPoNum.value = "";

   if(PySts=="O" && NumOfItm > 0) document.all.Sku.focus();
   // Make Set Lines hidden
   for(var i=0; i < document.all.trSet.length; i++)
   {
      document.all.trSet[i].style.display="none";
   }
   showSoTbl(false);

   <%if(!bAlwWarOrd){%>
      if(PySts !="O" && Sts!="Q" && (NumOfSpc == 0 || SoSts != "N"))
      {
        document.all.tdDetail.style.display="none";
      }
    <%}
    else{%>
       if(Sts!=" ")
       {
         document.all.tdDetail.style.display=block;
       }
    <%}%>

    showOnlyOrdStr();
}

//==============================================================================
// panel to enter the number of item, which was taken by customer
//==============================================================================
function showTakePanel(type, arg)
{
   var hdr = "Enter the Qty taken by the Customer";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popTakePanel(type, arg)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";

   if(type=="ITM")
   {
      document.all.tdTkSku.innerHTML = document.all.Sku.value.trim();
      var totqty =
       -1 * eval(document.all.Qty35.value.trim()) - eval(document.all.Qty46.value.trim())
          - eval(document.all.Qty50.value.trim()) - eval(document.all.Qty86.value.trim())
          - eval(document.all.Qty55.value.trim()) - eval(document.all.Qty63.value.trim())
          - eval(document.all.Qty64.value.trim()) - eval(document.all.Qty68.value.trim())
      document.all.tdTkOrdQty.innerHTML = Math.abs(totqty);
      document.all.tdAlready.innerHTML = QtyTaken[CurrArg];
   }

   if(type=="SET")
   {
      var setsku = document.all.tdSetSku[arg].innerHTML.trim();
      setsku = setsku.substring(0, setsku.indexOf("/") - 1).trim();
      document.all.tdTkSku.innerHTML = setsku;

      var totqty =
       -1 * eval(document.all.SetQty35[arg].value.trim()) - eval(document.all.SetQty46[arg].value.trim())
          - eval(document.all.SetQty50[arg].value.trim()) - eval(document.all.SetQty86[arg].value.trim())
          - eval(document.all.SetQty55[arg].value.trim()) - eval(document.all.SetQty63[arg].value.trim())
          - eval(document.all.SetQty64[arg].value.trim()) - eval(document.all.SetQty68[arg].value.trim())
      document.all.tdTkOrdQty.innerHTML = Math.abs(totqty);
      document.all.tdAlready.innerHTML = SetQtyTaken[CurrArg][arg];
   }
}
//==============================================================================
// populate taken item panel
//==============================================================================
function popTakePanel(type, arg)
{
   var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   panel += "<tr><td class='Prompt' nowrap>Short SKU:</td>"
         + "<td class='Prompt' id='tdTkSku'></td>"
       + "</tr>"

   panel += "<tr><td class='Prompt' nowrap>Order Quantity:</td>"
         + "<td class='Prompt' id='tdTkOrdQty'></td>"
       + "</tr>"

   panel += "<tr id='trReg'><td class='Prompt' nowrap>Quantity Already Taken:</td>"
         + "<td class='Prompt' id='tdAlready'>&nbsp;</td>"
       + "</tr>"

   panel += "<tr id='trReg'><td class='Prompt' nowrap>Quantity Taken:</td>"
         + "<td class='Prompt'><input name='TkQty' size=5 maxsize=5></td>"
       + "</tr>"

   panel += "<tr><td class='Prompt' id='tdError' style='color:red;' nowrap colspan=2></td></tr>"

   panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
        + "<button onClick='ValidateTakeItem(&#34;" + type + "&#34;)' class='Small'>Taken</button>&nbsp;"
        + "<button onClick='RemoveTakeItem(&#34;" + type + "&#34;)' class='Small'>Not Taken</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
      + "</td></tr>"

  panel += "</table>";
  return panel;
}
//==============================================================================
// validate entry on taken item panel
//==============================================================================
function ValidateTakeItem(type)
{
   var error = false;
   var msg = "";
   var br = "";
   var sku = document.all.tdTkSku.innerHTML;
   var tkqty = document.all.TkQty.value.trim();
   if(tkqty == "" || isNaN(tkqty)){error= true; msg +="Invalid quantity"; br = "<br>";}
   else{ tkqty = eval(tkqty);}

   var ordQty = eval(document.all.tdTkOrdQty.innerHTML);
   var already = eval(document.all.tdAlready.innerHTML);
   var together = already - -1 * tkqty;
   if(!error && together > ordQty )
   {
      error= true; msg += br + "Summary of Taken Quantities greater than Order Quantity."; br = "<br>";
   }

   if(error){document.all.tdError.innerHTML = msg;}
   else{ sbmTakeItem(type, sku, tkqty); }
}
//==============================================================================
// save taken item
//==============================================================================
function sbmTakeItem(type, sku, tkqty)
{
   var url = "OrderDtlSave.jsp?Order=" + Order + "&User=<%=sUser%>"
     + "&Sku=" + sku
     + "&Qty=" + tkqty

   if(type=="SET")
   {
      url += "&MainSku=" + Sku[CurrArg]
          + "&Action=ADDSETTAKE"
   }
   else{ url += "&Action=ADDITMTAKE" }
   window.frame1.location.href=url;
}
//==============================================================================
// save taken item
//==============================================================================
function RemoveTakeItem(type)
{
   var sku = document.all.tdTkSku.innerHTML;
   var url = "OrderDtlSave.jsp?Order=" + Order + "&User=<%=sUser%>"
     + "&Sku=" + sku
     + "&Qty=0"

   if(type=="SET")
   {
      url += "&MainSku=" + Sku[CurrArg]
          + "&Action=DLTSETTAKE"
   }
   else{ url += "&Action=DLTITMTAKE" }
   window.frame1.location.href=url;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction)
{
  var button = document.all.DelDate;
  if(button.value.trim() != "")
  {
      var date = new Date(button.value);

      if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
      else if(direction == "UP") date = new Date(new Date(date) - -86400000);
      button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
}
//==============================================================================
// set/erase customer pickup
//==============================================================================
function setCustPickup(chkbx)
{
  //if(chkbx.checked && Sts != "Q" || chkbx.checked && Order=="0"){ document.all.DelDate.value = ""; }
}

//==============================================================================
// show spec ord entry table
//==============================================================================
function  showSoTbl(show)
{
   if(show)
   {
      document.all.tdDetail1.style.display=block;
      document.all.tbAddSpcOrd.style.display=block;
   }
   else { document.all.tbAddSpcOrd.style.display="none"; }
}
//==============================================================================
// show Delivery Date Inquery screen
//==============================================================================
function showDelDateInq()
{
   str = document.all.Store.value.trim();
   //var url = "OrderDelInq.jsp?Date=" + document.all.DelDate.value.trim() + "&Store=" + document.all.Store.value.trim();
   var deldt = document.all.DelDate.value.trim();
   var date = new Date();
   if(deldt != "" && deldt != "CUST PICKUP") {  date = new Date(deldt); }

   // show the delivery week starts on monday of current week
   if(date.getDay() > 1){ date = new Date(new Date(date) - (date.getDay()-1) * 86400000); }
   else if(date.getDay() == 0){ date = new Date(new Date(date) - 6 * 86400000); }
   deldt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

   var url = "PfOrdDeliveryCal.jsp?RtnDt=Y&Date=" + deldt
   if(str == "35" || str == "46" || str == "50" || str == "86") { url += "&Store=35&Store=46&Store=50&Store=86" }
   else if(str == "86" || str == "63" || str == "64" || str == "68") { url += "&Store=63&Store=64&Store=68" }

   if(str == "35" || str == "46" || str == "50" || str == "86" || str == "63" || str == "64" || str == "68")
   {
      var WindowName = 'Delivery_Date_Inquiry';
      var WindowOptions = 'resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=yes';
      window.open(url, WindowName, WindowOptions);
  }
  else { alert("Please, type store number before clicking the 'Delivery Date Inquiry'") }
}
//==============================================================================
// set return delivery date
//==============================================================================
function setRtnDelDt(deldt)
{
   document.all.DelDate.value = deldt;
}
//==============================================================================
// apply Group Price
//==============================================================================
function applyGroupPrice()
{
   var group = document.all.tdGroup.innerHTML.trim();
   if (group != "&nbsp;")
   {
      document.all.Price.value = document.all.tdGroup.innerHTML;
   }
}

//==============================================================================
// get Searched Item
//==============================================================================
function getSearchedItem(sku)
{
   document.all.Sku.value = sku;
   document.all.Sku.focus();
}
//==============================================================================
// get Searched Item
//==============================================================================
function showCustSearchPanel()
{
   var hdr = "Search Customer Information";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCstSearchPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function popCstSearchPanel()
{
  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr id='trReg'><td class='Prompt' nowrap>Last Name:</td>"
         + "<td class='Prompt'><input class='Small1' name='Last' size=50 maxsize=50></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>First Name:</td>"
         + "<td class='Prompt'><input class='Small1' name='First' size=50 maxsize=50></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>Phone:</td>"
         + "<td class='Prompt'><input class='Small1' name='Phone' size=14 maxsize=14></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>E-Mail:</td>"
         + "<td class='Prompt'><input class='Small1' name='SrchEMail' size=50 maxsize=50></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>Order:</td>"
         + "<td class='Prompt'><input class='Small1' name='SrchOrder' size=10 maxsize=10></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='2'><br><br><button onClick='ValidateCustSearch()' class='Small1'>Submit</button>&nbsp;"
  + "<button onClick='hidePanel();' class='Small1'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function ValidateCustSearch()
{
   var error = false;
   var msg = "";

   var last = document.all.Last.value.trim();
   var first = document.all.First.value.trim();
   var phone = document.all.Phone.value.trim();
   var email = document.all.SrchEMail.value.trim();
   var order = document.all.SrchOrder.value.trim();

   if   ((last == null || last == "") && (first == null || first == "")
      && (phone == null || phone == "") && (email == null || email == "")
      && (order == null || order == ""))
   {
      msg = "Please, enter search criteria."
      error = true;
   }
   if(error) { alert(msg) }
   else { sbmCustSearch(last, first, phone, email, order); }
}
//==============================================================================
// start seach customer name
//==============================================================================
function getCustNameLst()
{
   var last = document.all.LastName.value.trim();
   var first = document.all.FirstName.value.trim();
   if   (last != "") { sbmCustSearch(last, first, "", "", "" ) }
}
//==============================================================================
// submit Customer Searched
//==============================================================================
function sbmCustSearch(last, first, phone, email, order)
{
   var url = "PfCstSearch.jsp?"
     + "Last=" + last
     + "&First=" + first
     + "&Phone=" + phone
     + "&EMail=" + email
     + "&Order=" + order
   hidePanel();
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// show Customer Searched
//==============================================================================
function showCustList(cust, cstprop, slsPerson, shipInstr)
{
   if(cust.length > 0)
   {
	   	window.frame1.close();
   		CstProp = cstprop;
   		CustArr = cust;
   		Slsper = slsPerson;
   		ShipInstr = shipInstr;

		var hdr = "Customer List";

   		var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     		+ "<tr>"
       			+ "<td class='BoxName' nowrap>" + hdr + "</td>"
       			+ "<td class='BoxClose' valign=top>"
         			+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       			+ "</td></tr>"
    		+ "<tr><td class='Prompt' colspan=2>" + popCustListPanel(cust, cstprop, slsPerson, shipInstr)
     			+ "</td></tr>"
   		+ "</table>"

		document.all.dvStatus.innerHTML = html;
   		document.all.dvStatus.style.left= getLeftScreenPos() + 670;
   		document.all.dvStatus.style.top= getTopScreenPos() + 100;
   		document.all.dvStatus.style.visibility = "visible";
   }
}
//==============================================================================
// populate Customer List
//==============================================================================
function popCustListPanel(cust, cstprop, slsPerson, shipInstr)
{
  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable1'>"
              + "<th class='DataTable1' nowrap>Cust<br>#</th>"
              + "<th class='DataTable1' nowrap>Phone</th>"
              + "<th class='DataTable1' nowrap>Last<br>Name</th>"
              + "<th class='DataTable1' nowrap>First<br>Name</th>"
              + "<th class='DataTable1' nowrap>Address</th>"
              + "<th class='DataTable1' nowrap>City</th>"
              + "<th class='DataTable1' nowrap>State</th>"
              + "<th class='DataTable1' nowrap>Zip</th>"
         + "</tr>"
  for(var i=0; i < cust.length; i++)
  {
     panel += "<tr class='DataTable'>"
              + "<td class='StrInv1' nowrap>" + cust[i] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][8] + "</td>"
              + "<td class='StrInv1' nowrap><a href='javascript: setCust(" + i + ")'>" + cstprop[i][0] + "</a></td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][1] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][2] + " " + cstprop[i][3] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][5] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][6] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][7] + "</td>"
           + "</tr>"
  }

  panel += "<tr><td class='DataTable'><button onClick='hidePanel();' class='Small1'>Close</button></td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// set Customer on page
//==============================================================================
function setCust(i)
{
  hidePanel(); // close customer list panle

  if(document.all.Slsper.value.trim() == ""){  document.all.Slsper.value = Slsper[i].trim(); }
  if (document.all.ShpInstr.value.trim() == ""){document.all.ShpInstr.value = ShipInstr[i].trim();}

  document.all.LastName.value = CstProp[i][0].trim();
  document.all.FirstName.value = CstProp[i][1].trim();
  document.all.Addr1.value = CstProp[i][2].trim();
  document.all.Addr2.value = CstProp[i][3].trim();
  document.all.City.value = CstProp[i][5].trim();
  document.all.State.value = CstProp[i][6].trim();
  document.all.Zip.value = CstProp[i][7].trim();
  
  document.all.DayPhn.value = CstProp[i][8].trim();
  document.all.ExtWorkPhn.value = CstProp[i][9];
  document.all.EvtPhn.value = CstProp[i][10].trim();   
  document.all.CellPhn.value = CstProp[i][11].trim();
  
  document.all.EMail.value = CstProp[i][12].trim();
  Cust = CustArr[i];
}

//==============================================================================
// add comment
//==============================================================================
function addComment()
{
   var hdr = "Add Comment";

   var html = "<table  class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popNewCommentPanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "500"; }
   else if(isSafari) { document.all.dvStatus.style.width = "auto"; }
   
   document.all.dvStatus.innerHTML = html;
   var left = getLeftScreenPos() + 300;
   var top = getTopScreenPos() + 100;
   document.all.dvStatus.style.left = left + "px";
   document.all.dvStatus.style.top = top + "px";   
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate New Comment
//==============================================================================
function popNewCommentPanel()
{
  var panel = "<table class='tbl02'>"
  panel += "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap>"
                + "<input name='CmtTy' type='radio' value='STORE' checked>Store's"
                + "<input name='CmtTy' type='radio' value='BUYER'>Buyer's &nbsp; &nbsp; &nbsp;"
              + "</td>"
         +  "</tr>"
         + "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap><textarea name='txaComment' id='txaComment' cols=75 rows=4></textarea></td>"
           + "</tr>"
         + "<tr class='DataTable6'><td class='DataTable' id='tdErrMsg' nowrap></td></tr>"
  panel += "<tr><td class='DataTable2'>"
        + "<button onClick='vldNewComment();' class='Small1'>Submit</button> &nbsp; &nbsp;"
        + "<button onClick='hidePanel();' class='Small1'>Close</button>"
        + "</td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// validate New Comment
//==============================================================================
function vldNewComment()
{
   var error = false;
   var msg = "";
   document.all.tdErrMsg.innerHTML="";

   var cmt = document.all.txaComment.value;
   if(cmt==""){error = true; msg = "Please enter comment.";}

   if(error){ document.all.tdErrMsg.innerHTML=msg; }
   else{sbmNewComment()}
}
//==============================================================================
// submit New Comment
//==============================================================================
function sbmNewComment()
{
    var commt = document.all.txaComment.value;
    var cmtty = null;
    for(var i=0; i < document.all.CmtTy.length; i++)
    {
        if(document.all.CmtTy[i].checked){ cmtty = document.all.CmtTy[i].value; break; }
    }

    commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = "";
	
    if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
    else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='OrderHdrSave.jsp'>"
       + "<input class='Small' name='User'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Comments'>"
       + "<input class='Small' name='CommtType'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame1.document.body.appendChild(nwelem);}
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
   {
	    window.frame1.document.all.User.value = "<%=sUser%>";
   		window.frame1.document.all.Order.value = "<%=sOrder%>";
   		window.frame1.document.all.Comments.value=commt;
   		window.frame1.document.all.CommtType.value=cmtty;
   		window.frame1.document.all.Action.value="ADDCOMMENT";
 		window.frame1.document.frmAddComment.submit()
   }
   else
   {
	   window.frame1.contentDocument.forms[0].User.value = "<%=sUser%>";
	   window.frame1.contentDocument.forms[0].Order.value = "<%=sOrder%>";
  	   window.frame1.contentDocument.forms[0].Comments.value=commt;
  	   window.frame1.contentDocument.forms[0].CommtType.value=cmtty;
  	   window.frame1.contentDocument.forms[0].Action.value="ADDCOMMENT";
	   window.frame1.contentDocument.forms[0].submit()
   }	   
}


//==============================================================================
// Add/Update Order/Customer Note
//==============================================================================
function addNote(note)
{
   var hdr = "Add/Update Order/Customer Note";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popNotePanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "500"; }
   else if(isSafari) { document.all.dvStatus.style.width = "auto"; }
   
   document.all.dvStatus.innerHTML = html;
   var left = getLeftScreenPos() + 300;
   var top = getTopScreenPos() + 100;
   document.all.dvStatus.style.left = left + "px";
   document.all.dvStatus.style.top = top + "px";   
   document.all.dvStatus.style.visibility = "visible";

   if(note.trim() !="" ){ document.all.txaComment.value = note; }
}
//==============================================================================
// populate Order/Customer Note
//==============================================================================
function popNotePanel()
{
  var panel = "<table  class='tbl02'>"
  panel += "<tr class='DataTable'>"
              + "<td class='DataTable' nowrap><textarea name='txaComment' id='txaComment' cols=50 rows=4></textarea></td>"
           + "</tr>"
         + "<tr class='DataTable6'><td class='DataTable' id='tdErrMsg' nowrap></td></tr>"
  panel += "<tr><td class='DataTable2'>"
        + "<button onClick='vldNote();' class='Small1'>Submit</button> &nbsp; &nbsp;"
        + "<button onClick='hidePanel();' class='Small1'>Close</button>"
        + "</td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// validate Note
//==============================================================================
function vldNote()
{
   var error = false;
   var msg = "";
   document.all.tdErrMsg.innerHTML="";

   var cmt = document.all.txaComment.value;
   if(cmt==""){error = true; msg = "Please enter note.";}

   if(error){ document.all.tdErrMsg.innerHTML=msg; }
   else{sbmNote()}
}
//==============================================================================
// submit Note
//==============================================================================
function sbmNote()
{
    var commt = document.all.txaComment.value;
    commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = "";
	
    if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
    else{ nwelem = window.frame1.contentDocument.createElement("div");}
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddNote'"
       + " METHOD=Post ACTION='OrderHdrSave.jsp'>"
       + "<input class='Small' name='User'>"
       + "<input class='Small' name='Order'>"
       + "<input class='Small' name='Comments'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame1.document.body.appendChild(nwelem);}
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
   {
	    window.frame1.document.all.User.value = "<%=sUser%>";
   		window.frame1.document.all.Order.value = "<%=sOrder%>";
   		window.frame1.document.all.Comments.value=commt;
   		window.frame1.document.all.Action.value="ADDNOTE";
 		window.frame1.document.frmAddNote.submit();
   }
   else
   {
	    window.frame1.contentDocument.forms[0].User.value = "<%=sUser%>";
	   	window.frame1.contentDocument.forms[0].Order.value = "<%=sOrder%>";
  		window.frame1.contentDocument.forms[0].Comments.value=commt;
  		window.frame1.contentDocument.forms[0].Action.value="ADDNOTE";
		window.frame1.contentDocument.forms[0].submit();	   
   }
}


//==============================================================================
// show print friendly page
//==============================================================================
function showPrintFriendly()
{
   var url = "OrderPrtInfo.jsp?Order=" + Order;
   window.document.location.href = url;
}
//==============================================================================
// print sold tag
//==============================================================================
function showDelTicket()
{
   var url = "PfOrderDelivery.jsp?Order=" + Order

   window.document.location.href = url;
}
//==============================================================================
// print sold tag
//==============================================================================
function showSoldTag()
{
   var hdr = "Show Sold Tag";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr>"
      + "<td class='Prompt1' colspan=2>"
        + "Print for store: <select name='selPrtStr'></select>"
        + "<br>Print by employee: <input name='PrtEmp' size='4' maxlength='4'>"
        + "<br><button onclick='vldSoldTag()'>Submit</button>"
      + "</td>"
    + "</tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 670;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";

   setTrfStrLst();
}
//==============================================================================
// set transfer store list with inventory that used in order
//==============================================================================
function setTrfStrLst()
{
   var trf = new Array();
   for(var i=0; i < Qty35.length;i++)
   {
      if(Qty35[i] != "0" && !chkTrfArr(trf, "35")){ trf[trf.length] = "35"; }
      if(Qty46[i] != "0" && !chkTrfArr(trf, "46")){ trf[trf.length] = "46"; }
      if(Qty50[i] != "0" && !chkTrfArr(trf, "50")){ trf[trf.length] = "50"; }
      if(Qty86[i] != "0" && !chkTrfArr(trf, "86")){ trf[trf.length] = "86"; }
      if(Qty63[i] != "0" && !chkTrfArr(trf, "63")){ trf[trf.length] = "63"; }
      if(Qty64[i] != "0" && !chkTrfArr(trf, "64")){ trf[trf.length] = "64"; }
      if(Qty68[i] != "0" && !chkTrfArr(trf, "68")){ trf[trf.length] = "68"; }
      if(Qty55[i] != "0" && !chkTrfArr(trf, "55")){ trf[trf.length] = "55"; }
   }

   for(var i=0; i < UpdSetQty35.length;i++)
   {
      for(var j=0; j < UpdSetQty35[i].length;j++)
      {
        if(UpdSetQty35[i][j] != "0" && !chkTrfArr(trf, "35")){ trf[trf.length] = "35"; }
        if(UpdSetQty46[i][j] != "0" && !chkTrfArr(trf, "46")){ trf[trf.length] = "46"; }
        if(UpdSetQty50[i][j] != "0" && !chkTrfArr(trf, "50")){ trf[trf.length] = "50"; }
        if(UpdSetQty86[i][j] != "0" && !chkTrfArr(trf, "86")){ trf[trf.length] = "86"; }
        if(UpdSetQty63[i][j] != "0" && !chkTrfArr(trf, "63")){ trf[trf.length] = "63"; }
        if(UpdSetQty64[i][j] != "0" && !chkTrfArr(trf, "64")){ trf[trf.length] = "64"; }
        if(UpdSetQty68[i][j] != "0" && !chkTrfArr(trf, "68")){ trf[trf.length] = "68"; }
        if(UpdSetQty55[i][j] != "0" && !chkTrfArr(trf, "55")){ trf[trf.length] = "55"; }
      }

   }

   if(NumOfSpc > 0)
   {
      trf[trf.length] = Str;
   }

   for(var i=0; i < trf.length;i++)
   {
     document.all.selPrtStr.options[i] = new Option(trf[i],trf[i]);
   }
}
//==============================================================================
// check if transfer store already is not in array
//==============================================================================
function chkTrfArr(arr, str)
{
   var found = false;
   for(var i=0; i < arr.length;i++)
   {
     if(arr[i] == str){found = true; break;}
   }
   return found;
}
//==============================================================================
// validate sold tag
//==============================================================================
function vldSoldTag()
{
   var error =false;
   var msg = "";

   var str = document.all.selPrtStr.options[document.all.selPrtStr.selectedIndex].value;
   var emp = document.all.PrtEmp.value.trim();
   if(emp == ""){ error=true; msg="Employee number is invalid"; }
   else if(isNaN(emp)){ error=true; msg="Employee number is not numeric"; }
   else if(eval(emp) <= 0){ error=true; msg="Employee number must be positive number"; }

   if(error){ alert(msg); }
   else{ sbmSoldTag(str, emp); }
}
//==============================================================================
// submit sold tag
//==============================================================================
function sbmSoldTag(str, emp)
{
   var url = null;
   url = "OrderPrtSoldTag.jsp?Order=" + Order
   url += "&Store=" + str
        + "&Emp=" + emp;
   window.document.location.href = url;
}

//==============================================================================
// print sold tag
//==============================================================================
function sbmSOSoldTag()
{
   var url = "OrderSOPrtSoldTag.jsp?Order=" + Order
   window.document.location.href = url;
}
//==============================================================================
// set comment/log filter
//==============================================================================
function setCmtFilter(cmtty, chkbox)
{
   var disp = "none";
   if(chkbox.checked){ disp = block;}

   for(var i=0; i < NumOfCmt; i++)
   {
      var cell = "tdCmtTy" + i;
      var type = document.all[cell].innerHTML.trim();
      var rownm = "trCmtLog" + i;
      var row = document.all[rownm];
      for(var j=0; j < cmtty.length; j++)
      {
          if(type == cmtty[j]){ row.style.display=disp; }
      }
   }
}
//==============================================================================
// show Discount Calculator
//==============================================================================
function showDiscCalc()
{
   var url = "PfDiscntCalc.jsp?Order=" + Order + "&User=<%=sUser%>";
   var WindowName = 'Patio Calculator';
   var WindowOptions = 'resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=yes';
   window.open(url);
}
//==============================================================================
//send email message
//==============================================================================
function emailOrd(sign)
{
	var hdr = "Send Order/Quote by E-Mail";
	if(sign){ hdr = "EMAIL Phone CC Auth"}

	var html = "<table class='tbl01'>"
  		+ "<tr>"
    		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
    		+ "<td class='BoxClose' valign=top>"
      			+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    		+ "</td></tr>"
 		+ "<tr><td class='Prompt' colspan=2>" + popEMailPanel(sign)
  			+ "</td></tr>"
		+ "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "500"; }
	else if(isSafari) { document.all.dvStatus.style.width = "auto"; }
		   
	document.all.dvStatus.innerHTML = html;
	var left = getLeftScreenPos() + 300;
	var top = getTopScreenPos() + 100;
	document.all.dvStatus.style.left = left + "px";
	document.all.dvStatus.style.top = top + "px";   
	document.all.dvStatus.style.visibility = "visible";

	document.all.ToAddr.value = document.all.EMail.value;
	
	var iOpt = 0; 
	document.all.selEmailAddr.options[iOpt++] = new Option("--- Select email address ---", "NONE"); 
    document.all.selEmailAddr.options[iOpt++] = new Option("Dale Mikulan", "DMikulan@sunandski.com");
    document.all.selEmailAddr.options[iOpt++] = new Option("Kevin Porter", "kporter@sunandski.com");
    document.all.selEmailAddr.options[iOpt++] = new Option("Matt Williams", "MWilliams@sunandski.com");   
    document.all.selEmailAddr.options[iOpt++] = new Option("Kelly Knight", "kknight@sunandski.com");
    document.all.selEmailAddr.options[iOpt++] = new Option("Erin Yee", "eyee@sunandski.com");
    document.all.selEmailAddr.options[iOpt++] = new Option("Polly Snyder", "psnyder@sunandski.com");
    document.all.selEmailAddr.options[iOpt++] = new Option("Vadim Rozen", "vrozen@sunandski.com");
    
    var toAddrNm = "Store" + Str;
    var toAddr = "Store" + Str + "@sunandski.com";
    document.all.selEmailAddr.options[iOpt++] = new Option(toAddrNm, toAddr);
    
	var subj = "";
	if(Sts!="Q"){subj = "Patio Order: " + Order}
	else{subj = "Patio Order Quote: " + Order}
	document.all.Subj.value = subj;
	if(sign){document.all.spnIncl.style.display="none";}
}
//==============================================================================
//populate Picture Menu
//==============================================================================
function popEMailPanel(sign)
{
var panel = "<table class='tbl02'>"
panel += "<tr><td class='Prompt'>E-Mail Address</td></tr>"
      + "<tr><td class='Prompt'><input class='Small' size=50 name='ToAddr'>"
         + "<br><select class='Small' name='selEmailAddr' onchange='setEmailAddr(this)'></select>"
      + "</td></tr>"
    + "<tr><td class='Prompt'>Subject &nbsp;</td></tr>"
      + "<tr><td class='Prompt'><input class='Small' size=50 name='Subj'></td></tr>"
    + "<tr><td class='Prompt'>Message &nbsp;</td></tr>"
      + "<tr><td class='Prompt'><textarea class='Small' cols=100 rows=7 name='Msg' id='Msg'></textarea></td></tr>"
    + "<tr><td class='Prompt'>Include Order Information</td></tr>"
      + "<tr><td class='Prompt'>"
         + "<input type='radio' name='Incl' value='Y' checked>Yes &nbsp;  &nbsp; "
         + "<span id='spnIncl'><input type='radio' size=50 name='Incl'  value='N'>No</span>"
         + "</td></tr>"

    + "<tr><td class='Prompt1'>"
      + "<button class='Small' onclick='validateEMail(" + sign + ")'>Send</button> &nbsp;"
      + "<button class='Small' onclick='hidePanel()'>Cancel</button> &nbsp;"
    + "</td></tr>"
panel += "</table>";

panel += "<span style='display:none'>" 
      + "<input name='CmtTy' type='radio' value='EMAIL' checked>"
      + "<input name='CmtTy' type='radio' value='FAKE'>"
      + "<input name='txaComment' type='Textarea'>"
    + "</span>"

return panel;
}
//==============================================================================
//validate email message properties
//==============================================================================
function validateEMail(sign)
{
var msg = "";
var error = false;

var toaddr = document.all.ToAddr.value.trim();
if(toaddr ==""){error=true; msg="Please enter Email Address"; }

var subj = document.all.Subj.value.trim();
if(subj ==""){error=true; msg="Please enter Subject Address"}

var body = document.all.Msg.value.trim();

var incl = document.all.Incl[0].checked;

if(body =="" && !incl){error=true; msg="Please enter message text or(and) include claim information."}

	if(error){ alert(msg); }
	else 
	{	
		var str = Str;
		if(Str.length==1){ str = "0" + Str; }
		
  		var frAddr = "Store" + str + "@sunandski.com"
  		for(var i=0; i < RecUsr.length; i++)
  		{
	   		if(User == RecUsr[i]){ frAddr =  RecUsr[i] + "@sunandski.com"; break; } 
  		}	
	
  		document.all.txaComment.value = "Emailed " + subj + ". To " + toaddr + ". " + body;	
  		sbmEMail(toaddr, subj, body, incl, sign); 
	}
}
//==============================================================================
// email Order
//==============================================================================
function sbmEMail(toaddr, subj, body, incl, sign)
{    	
   if(incl)
   { 
	   if(sign){ body += "<br>" + getSignForm(); }  
	   body += "<br><br>" + getMsgBody();
   } 
   
   var nwelem = "";
	
   if(isIE){ nwelem = window.frame2.document.createElement("div"); }
   else if(isSafari){ nwelem = window.frame2.document.createElement("div"); }
   else{ nwelem = window.frame2.contentDocument.createElement("div");}
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmSendEmail'"
        + " METHOD=Post ACTION='WarrantyClaimSendEMail.jsp'>"
        + "<input class='Small' name='User'>"
        + "<input class='Small' name='MailAddr'>"
        + "<input class='Small' name='CCMailAddr'>"
        + "<input class='Small' name='FromMailAddr'>"
        + "<input class='Small' name='Subject'>"  
        + "<input class='Small' name='Message'>";
        
    var path = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Patio_Furniture/";    
    for(var i=0; i < NumOfPic; i++)
    {
    	html += "<input type='hidden' name='ItemAttach' value='" + PicSku[i] + "'>"
    	html += "<input type='hidden' name='PicAttach' value='" + path + PicFile[i] + "'>"     
    }     
        
   html += "</form>"
   
   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame2.document.appendChild(nwelem); }
   else if(isIE){ window.frame2.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame2.document.body.appendChild(nwelem);}
   else{ window.frame2.contentDocument.body.appendChild(nwelem); } 
   
   if(isIE || isSafari)
   {
	    window.frame2.document.all.User.value = "<%=sUser%>";
  		window.frame2.document.all.Subject.value = subj;
   		window.frame2.document.all.Message.value = body;
   		window.frame2.document.all.MailAddr.value = toaddr;
   
   		var str = Str;
   		if(Str.length==1){ str = "0" + Str; }
   		window.frame2.document.all.CCMailAddr.value = "GM" + str + "@sunandski.com";
   		var frAddr = "Store" + str + "@sunandski.com"
  		for(var i=0; i < RecUsr.length; i++)
   		{
	   		if(User == RecUsr[i]){ frAddr =  RecUsr[i] + "@sunandski.com"; break; } 
   		}   
   		window.frame2.document.all.FromMailAddr.value = frAddr;    
   		window.frame2.document.frmSendEmail.submit();  
   }
   else
   {
	    window.frame2.contentDocument.forms[0].User.value = "<%=sUser%>";
	   	window.frame2.contentDocument.forms[0].Subject.value = subj;
  		window.frame2.contentDocument.forms[0].Message.value = body;
  		window.frame2.contentDocument.forms[0].MailAddr.value = toaddr;
  
  		var str = Str;
  		if(Store.length==1){ str = "0" + Str; }
  		window.frame2.contentDocument.forms[0].CCMailAddr.value = "GM" + str + "@sunandski.com";
  		var frAddr = "Store" + str + "@sunandski.com"
  		for(var i=0; i < RecUsr.length; i++)
  		{
	   		if(User == RecUsr[i]){ frAddr =  RecUsr[i] + "@sunandski.com"; break; } 
  		}   
  		window.frame2.contentDocument.forms[0].FromMailAddr.value = frAddr;    
  		window.frame2.contentDocument.forms[0].submit(); 
   }
   
   // delay 2 seconds
   var currentTime = new Date().getTime();
   while (currentTime + 2000 >= new Date().getTime()) 
   {
	   
   }
   
   sbmNewComment();
   
   hidePanel();
   
   
}
//==============================================================================
//get message body
//==============================================================================
function getMsgBody()
{
   var body = "";
   body += "<table style='font-family:Arial; font-size:10px; width:100%;' >"
   
	   + "<tr><td style='text-align:left'>"
   
   body += "<table style='border: darkred solid 1px; font-family:Arial; font-size:10px; width:100%;'>"
		  + "<tr><td style='font-weight:bold'><b><i>Sun & Ski</></b></th></tr>"
		  + "<tr><td style='font-weight:bold'>" + StrAddr1 + " " + StrAddr2 + "," + StrCity
		  + "," + StrZip
		  + "</th></tr>"
		  + "<tr><td style='font-weight:bold'>Phone: " + StrPhn + "</th></tr>"
   body += "</table><br>";
   
   var order = "Order: <b>" + Order + "</b>";
   if(Sts=="Q"){order = "Quote: <b>" + Order + "</b>";}
   
   body += "<table style='border: darkred solid 1px; font-family:Arial; font-size:10px; width:100%;'  >"
      + "<tr><td>" + order + "</td><td style='text-align:right;'>Date: "+ EntDate + "</td>"
      + "</tr>"
      
   if(Sts=="Q")
   {
	   body += "<tr><td style='text-align:center;' colspan=2>"	   
	     + "This quote will expire at end of business on: " 
	     + "<span style='font-weight:bold;'><%=sDelDate%></span>"
	   + "</td></tr>"
   }   
      
   body += "<tr><td><b>Salesperson:</b>&nbsp;" + Slsper + " - " + SlpName + "</td>"
   
   if(Sts!="Q")
   {  	  
       body += "<td style='text-align:right;'><b>Delivery Date:</b> &nbsp;" + DelDate + "</td>"
   }
   
   body += "</tr>"
	  
   body += "</table><br>";   
   
   body += "<table style='border: darkred solid 1px; font-family:Arial; font-size:10px;'  width='100%'>"   
	  + "<tr><td style='font-weight:bold'>Last Name</th><td>" + LastName + "</td><td>&nbsp;</td>"
         + "<td style='font-weight:bold'>First Name</td><td>" + FirstName + "</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>"
       
      + "<tr><td style='font-weight:bold'>Address</td><td colspan=7>" + Addr1 + " " + Addr2 + "</td>"
	       
	       + "<tr><td style='font-weight:bold'>City</td><td>" + City + "</td><td>&nbsp;&nbsp;&nbsp;</td>"
	       + "<td style='font-weight:bold'>State</td><td>" + State + "</td><td>&nbsp;&nbsp;&nbsp;</td>"
	       + "<td style='font-weight:bold'>Zip</td><td>" + Zip + "</td></tr>"
	       
	       + "<tr><td style='font-weight:bold'>Daytime Phone x (Ext.)</td><td>" + DayPhn + " x" + ExtWorkPhn + "</td><td>&nbsp;&nbsp;&nbsp;</td>"
	       + "<td style='font-weight:bold'>Evening Phone</td><td>" + EvtPhn + "</td></tr>"
	       
	       + "<tr><td style='font-weight:bold'>Cell Phone</td><td>" + CellPhn + "</td><td>&nbsp;&nbsp;&nbsp;</td>"
	       + "<td style='font-weight:bold'>E-Mail</th><td>" + EMail + "</td></tr>"
	    
	body += "</table><br>";
			
	if(NumOfItm > 0)
	{
       body += "<table border=0 style='font-family:Arial; font-size:10px; width:100%;'>"
	   + "<tr style='background:#e7e7e7;'>" 
	        + "<th>Description</th>" 
	        + "<th>MSRP</th>"
	        + "<th>Price</th>"	        	        
	        + "<th>Disc<br>Price</th>"
	        + "<th>Qty</th>"
	        + "<th>Total<br>Price</th>"	        
	   + "</tr>"			   
			
	   for(var i=0; i < NumOfItm; i++)
	   {
		 body += "<tr>"
		    + "<td>" + Desc[i] + "</td>"
		    + "<td style='text-align:right;'>$" + SugPrc[i] + "</td>"
		    + "<td style='text-align:right;'>$" + Ret[i] + "</td>"
		    + "<td style='text-align:right;'>$" + ClcPrc[i] + "</td>"
		    + "<td style='text-align:right;'>" + SkuQty[i] + "</td>"
		    + "<td style='text-align:right;'>$" + SkuTotal[i] + "</td>"
		 + "</tr>";
	   }			
	   body += "</table>";
	}
	
	if(NumOfSpc > 0)
	{	
	   body += "<table border=1 style='font-family:Arial; font-size:10px; width:100%;'>"
		   + "<tr><th>Short<br><Sku></th>" 
		        + "<th>Vendor</th>"
		        + "<th>Description</th>" 
		        + "<th>Qty</th>"
		        + "<th>Price</th>"
		        + "<th>Disc<br>Price</th>"		        
		        + "<th>Total<br>Price</th>"	        
		   + "</tr>"			   
				
		for(var i=0; i < NumOfSpc; i++)
		{
			body += "<tr>"
			    + "<td>" + SoSku[i] + "</td>"
			    + "<td>" + SoVenName[i] + "<br>" + SoVenSty[i] + "</td>"
			    + "<td>" + SoDesc[i] + "</td>"
			    + "<td>" + SoQty[i] + "</td>"
			    + "<td>" + SoRet[i] + "</td>"
			    + "<td>" + SoClcPrc[i] + "</td>"
			    + "<td>" + SoTotal[i] + "</td>"
			+ "</tr>";
		}			
		body += "</table>";
	}		

	/*
	vrozen@sunandski.com
	*/
	body += "</td></tr>" 
	  + "<tr><td style='text-align:right'>"
	body += "<br><table border=0 style='font-family:Arial; font-size:10px;text-align:right;'>"
       + "<tr><td style='font-weight:bold'>Total Price&nbsp;</th><td nowrap>$" + SubTot + "</td></tr>"
       + "<tr><td style='font-weight:bold'>Multiple Discount &nbsp;</th><td nowrap>$" + GrpItmDsc + "</td></tr>"
       + "<tr><td style='font-weight:bold'>Sub-Total&nbsp;</th><td nowrap>$" + SubAftMD + "</td></tr>"
       + "<tr><td style='font-weight:bold'>Single Discount &nbsp;</th><td nowrap>$" + DscAmt + "</td></tr>"       
       + "<tr><td style='font-weight:bold'>All Discounts &nbsp;</th><td nowrap>$" + OrdAllDscAmt + "</td></tr>"
       + "<tr><td style='font-weight:bold'>After Discounts &nbsp;</th><td nowrap>$" + OrdAfterDsc + "</td></tr>"
       + "<!-- tr><td style='font-weight:bold'>Shipping &nbsp;</th><td nowrap>$" + ShpPrc + "</td></tr -->"
       + "<tr><td style='font-weight:bold'>Assembly and Delivery &nbsp;</th><td nowrap>$" + DlvPrc + "</td></tr>"
       + "<tr><td style='font-weight:bold'>Tax &nbsp;</th><td nowrap>$" + Tax + "</td></tr>"
       + "<tr><td style='font-weight:bold'>Protection Plan &nbsp;</th><td nowrap>$" + ProtPlan + "</td></tr>"
    if(Sts!="Q")
    { 
    	body += "<tr><td style='font-weight:bold'>Paid In Full &nbsp;</th><td nowrap>$" + OrdPaid + "</td></tr>"
    }
    body += "<tr><td style='font-weight:bold'>Total &nbsp;</th><td nowrap>$" + OrdTotal + "</td></tr>"
       
	body += "</table>";   
	   
	body += "</td></tr></table>"
	
    return body;			
}

//==============================================================================
//set selected email address line
//==============================================================================
function setEmailAddr(sel)
{
	document.all.ToAddr.value = sel.options[sel.selectedIndex].value; 
}

//==============================================================================
//get sign CC form - 
//==============================================================================
function getSignForm()
{	
	text = "<h3 style='page-break-before:always;'>&nbsp;</h3>" 
	  + "<br><table>"
	  + "<tr>"
	   + "<td>Dear Patio Customer;"
	   + "<br><br>Thank you for allowing us to process your credit card payment for your Patio Order,"
	      + " over the phone. Please follow the instructions below to complete the" 
	      + " 'Customer Signature of Credit Card Authorization' information."
	     
		+ "<br><br>Customer Instructions:"
	   
		+ "<br><br>1)	PRINT this page, then fill in all blank spaces with the credit card holder's information."
		+ "<br>2)	SIGN on the card holders signature line."	
		+ "<br>3)	SCAN (and email) this completed page back to our store's email address (email address is the REPLY email on this message)."
		+ "<br>4)	CALL the store at <%=sStrPhnFmt%>, and ask to speak to any Manager on Duty, and provide them with your Credit Card #, expiration date, and CVV code (usually on the back of the card - in the signature panel)."


		+ "<br><br>Customer Statement of Credit Card Authorization:"
		
		+ "<br><br>I, ________________________________ hereby authorize Sun & Ski (Retail Concepts, Inc.) to process my credit card ending in"

		+ "<br><br>(last 4 digits only) _____ _____ _____ _____.  For the remaining (or total balance) due on my Patio Order."


		+ "<br><br>My Current Billing Address for this credit card is:"

		+ "<br><br>Name on the card: _______________________________" 

		+ "<br><br>Address: __________________________________"

		+ "<br><br> &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; __________________________________"

		+ "<br><br>City: ______________________ State: _______  Zip:  _________________"


		+ "<br><br>Credit Card Holder's Signature______________________________ Today's Date: ____ / ____ / ________"               
		
	   + "</td>"
	  + "</tr>"
	  
	  
	text += "</table>"
	return text;
}	

//==============================================================================
//load claim photo
//==============================================================================
function loadPhoto(item)
{
	var html = ""
  		+ "<table class='tbl01'>"
    	    + "<tr>"
    			+ "<td class='BoxName' nowrap>Add Photo</td>"
    			+ "<td class='BoxClose' valign=top>"
      				+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    			+ "</td></tr>"
        		+ "<tr colspan='2'>"
        		+ "<td align=center>"
        	+ "<form name='Upload'  method='post' enctype='multipart/form-data' action='OrderPicLoad.jsp'>"
            + "<input type='File' name='Doc' class='Small' size=50><br>"
            + "<input type='hidden' name='Order'>"
            + "<input type='hidden' name='Item' >"
            + "<input type='hidden' name='FileName'>"
        + "</form>"
        	+ "</td></tr>"
        	+ "<tr colspan='2'>"
        	+ "<td align=center>"
        	+ "<button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button> &nbsp; "
        	+ "<button name='Cancel' class='Small' onClick='hidePanel();'>Cancel</button>"
        	+ "</td></tr>"
  		+ "</table>"

	//alert(html)
  	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "400"; }
  	  else if(isSafari) { document.all.dvStatus.style.width = "auto"; }
	
	document.all.dvStatus.innerHTML=html;
  	var left = getLeftScreenPos() + 250;
  	var top = getTopScreenPos() + 300;
  	document.all.dvStatus.style.left = left + "px";
    document.all.dvStatus.style.top = top + "px";
	document.all.dvStatus.style.visibility="visible"

	document.Upload.Order.value = Order;
	document.Upload.Item.value = item;
	document.Upload.Doc.focus();
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvStatus.innerHTML = " ";
	document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
//submit Upload
//==============================================================================
function sbmUpload()
{
	var error = false;
	var msg = "";
	var file = document.Upload.Doc.value.trim();
	document.Upload.FileName.value = file;
	if(file == "")
	{
  		error = true;
  		msg = "Please type full file path"
	}
	if (error) { alert(msg);}
	else { document.Upload.submit(); }
}
//==============================================================================
//delete picture
//==============================================================================
function dltPicture(item, path)
{
 var url = "OrderDltPic.jsp?"
   + "Order=" + Order
   + "&Sku=" + item
   + "&Path=" + path
   + "&Action=DLT_ITM_PICTURE"

 //alert(url)
 window.frame1.location.href = url;
 hidePanel();
}
//==============================================================================
//check which Key Down pressed 
//==============================================================================
function chkKeyDown(fld, line, nextfld, event)
{
	var obj = document.all[name];

	if(fld.value.length == 3 && line < 2 || fld.value.length == 4 && line == 2)
	{
		nextfld.focus();
		nextfld.select();
	}
}
//==============================================================================
//check Special order checkbox 
//==============================================================================
function chkSpecOrd(obj)
{
	if(NumOfSpc > 0 && !obj.checked){ obj.checked = true; }
	if(NumOfItm > 0 && obj.checked){ obj.checked = false; }
}
//==============================================================================
//check Special order checkbox 
//==============================================================================
function clcNewPrice()
{
	var price = document.all.Price.value.trim();
	price = eval(price);
	var off = document.all.PriceOff.value.trim();
	off = eval(off);
	if(off > 0)
	{
		price = (price * (1 - off/100)).toFixed(2);
		document.all.Price.value = price
	}
}
//==============================================================================
//check Special order checkbox 
//==============================================================================
function setShipNA(chb)
{
	var shipi = document.all.ShpInstr;
	
	if(chb.checked && shipi.value.trim() == "")
	{
		shipi.value = "N/A"; 
	}
	if(!chb.checked && shipi.value.trim() == "N/A")
	{
		shipi.value = ""; 
	}
}
//==============================================================================
// show alert 
//==============================================================================
function showAlert(msg)
{
	alert(msg);
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>

</head>
<title>Patio_Furniture_Order_Entry</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frameChkCalendar"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<div id="dvTest" class="dvStatus"></div>
<div id="dvOrdType" class="dvOrdType"></div>
<div id="dvWarn" class="pos_fixed"></div>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="left" VALIGN="TOP" nowrap>
         <b><font size="-1">
            Store: <%=sEntStore%><br>
            User: <%=sUser%></font></b>
      </td>

      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Patio Furniture Sales</b>
      <br><img src="MainMenu/patio_logos1.jpg" height="50px">
             
      <br><span style="font-family: Arial; font-size:10px;">Order Status:</span> 
          <span style="background: #cce6ff; font-family: Arial; font-size:12px;font-weight:bold;"><%=sStsNm%></span> &nbsp; &nbsp; &nbsp;
          <span style="font-family: Arial; font-size:10px;">Payment Status:</span> 
          <span style="background: #cce6ff; font-family: Arial; font-size:12px;font-weight:bold;"><%=sPyStsNm%></span>


         <%if(sSoSts != null && !sSoSts.trim().equals("")){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span style="font-family: Arial; font-size:10px;">Special Order Status:</span> 
            <span style="background: #cce6ff; font-family: Arial; font-size:12px;font-weight:bold;"><%=sShowSoSts%></span>
         <%}%>
         
         <%if(!sSts.equals("Q") && !sSts.equals("E") && !sDelDate.equals("01/01/0001")){%>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         	<span style="font-family: Arial; font-size:10px;">Delivery Date:</span> 
         	<span style="background: #cce6ff; font-family: Arial; font-size:12px;font-weight:bold;"><%=sDelDate%></span>
         <%}%>
         </b>
      </td>         

      <td ALIGN="right" VALIGN="TOP" nowrap>
         <b><font size="-1">Date: <%if(sEntDate == null){%><%=sToday%><%} else  {%><%=sEntDate%><%}%>
         <br>Time: <%if(sEntTime==null){%><%=sCurTime%><%} else {%><%=sEntTime%><%}%></font></b>
      </td>
    </tr>
    <tr class="NonPrt">
      <td ALIGN="left" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="OrderLstSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
        &nbsp;&nbsp;&nbsp;
        <a href="javascript: showCustSearchPanel();">Customer/Order Search</font></a>
        
      </td>
    </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table border=0 cellPadding="0" cellSpacing="0" >
     <tr  class="DataTable">
        <td class="DataTable" nowrap>Order Number <span style="font-size:16px;font-weight:bold;"><%=sOrdNum%></span></td>
        <td class="DataTable" nowrap>
           <span class="spnAster">*</span>Store <input type="text" id="StoreNum" name="Store"
                      <%if(bExist){%>readonly value="<%=sStr%>"<%}
                        else if(!sEntStore.equals("Home Office")){%>value="<%=sEntStore%>"<%}%> size=5 maxlength=5>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <span class="spnAster">*</span>Salesperson <input type="text" name="Slsper" size=4 maxlength=4 >&nbsp;<span id="spnSlpName"></span>
        </td>
        <td class="DataTable" nowrap>
           <%for(int i=0; i < 10; i++){%>&nbsp;<%}%>
           	<%if(!sSts.equals("Q") && !sSts.equals("C") && !sSts.equals("D") && !sSts.equals("E") && iNumOfItm > 0) {%>
            &nbsp; &nbsp; &nbsp; &nbsp;
            <button class="Small" onclick="showSoldTag()"><span style="color:red;">SOLD</span> Tag</button>
           <%}%>
           <%if(!sSts.equals("Q") && !sSts.equals("C") && !sSts.equals("D") && !sSts.equals("E") && iNumOfSpc > 0) {%>
            &nbsp; &nbsp; &nbsp; &nbsp;
            <button class="Small" onclick="sbmSOSoldTag()"><span style="color:red;">SO</span> Tag</button>
           <%}%>
           
           <%for(int i=0; i < 10; i++){%>&nbsp;<%}%>
                   
           <%if(!sDelDate.equals("01/01/0001") && (sPySts.equals("F") || sPySts.equals("P"))){%>
                <span class="NonPrt"><button class="Small" onclick="showDelTicket()">Delivery Ticket</button> &nbsp; </span>
           <%}%>
           
         </td>
     </tr>   
     <tr  class="DataTable">
        <td class="DataTable" colspan="3" nowrap>
          Please un-check this box if the Customer does NOT wish to receive emails about offers and promotions.
           <input type="checkbox" name="AllowEmail" checked> 
        </td>
      </tr>  
   </table>
 <!----------------------- end of table ------------------------>
     </td>
   </tr>
   <tr>
     <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
  <!----------------------- Customer Data ------------------------------>
     <table border=0 cellPadding="0" cellSpacing="0" id="tbCustInfo">
      <tr  class="DataTable">
        <td class="DataTable" nowrap><span class="spnAster">*</span>Last Name <input type="text" name="LastName" size=50 maxlength=50></td>
        <td class="DataTable" nowrap colspan="2"><span class="spnAster">*</span>First Name <input type="text" name="FirstName" size=50 maxlength=50 onblur="getCustNameLst()"></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" colspan="3" nowrap>
           <span class="spnAster">*</span>Address <input type="text" name="Addr1" size=75 maxlength=75><br><%for(int n=0; n < 12; n++){%>&nbsp;<%}%>
                   <input type="text" name="Addr2" size=75 maxlength=75>
        </td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap><span class="spnAster">*</span>City <input type="text" name="City" size=50 maxlength=50></td>
        <td class="DataTable" nowrap><span class="spnAster">*</span>State <input type="text" name="State"  size=2 maxlength=2></td>
        <td class="DataTable" nowrap><span class="spnAster">*</span>Zip <input type="text" name="Zip" size=10 maxlength=10></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap>Daytime Phone x (Ext.)
        <input type="text" id="DayPhn" name="DayPhn" size=12 maxlength=10>
          x <input type="text" name="ExtWorkPhn" size=5 maxlength=5></td>

        <td class="DataTable" colspan="2" nowrap>Evening Phone
         <input type="text" id="EvtPhn" name="EvtPhn" size=12 maxlength=10>         
        </td>

      </tr>
      <tr  class="DataTable">
        <td class="DataTable" colspan="3" nowrap>Cell Phone
          <input type="text" id="CellPhn" name="CellPhn" size=12 maxlength=10> 
          &nbsp;&nbsp;&nbsp;
           <span class="spnAster">*</span>E-Mail <input type="text" id="EMail" name="EMail" size=65 maxlength=65>
           &nbsp;<button class="Small" onclick="emailOrd(false)">EMAIL to Customer</button>
           &nbsp;<button class="Small" onclick="emailOrd(true)">EMAIL Phone CC Auth</button> 
        </td>
      </tr>
      <tr class="NonPrt">
      	<td colspan="3" nowrap><span class="spnAster">*</span> = Fields required for SALE orders.<br></td>
      </tr>
      
      <tr  class="DataTable">
         <td class="DataTable" nowrap colspan=3><span class="spnAster">*</span>          
         Special Shipping Instruction &nbsp;
         <input type="checkbox" name="chbShipNA" value="Y" onclick="setShipNA(this)">N/A &nbsp;
            <textarea  id="ShpInstr" name="ShpInstr" rows="2" cols="100" maxlength="200"></textarea>
                        
      </tr>
      
      <!--  ==== Delivery Date ==== -->
      <tr  class="DataTable">
        <td class="DataTable" colspan="3" nowrap>
          <table border=0>
          	<tr  class="DataTable">
          		<td class="DataTable6" nowrap>
          			<%if(!sSts.equals("C") && !sSts.equals("D") && !sSts.equals("E") && iNumOfSpc == 0){%>
              			<input class="NonPrt" type="checkbox" name="chbSpecOrd"
                		onClick="chkSpecOrd(this)" 
                		<%if(sSpecOrd.equals("Y")){%>checked<%}%>>Special Order
           			<%} else{%><input type="checkbox" name="chbSpecOrd" style="display: none;" <%if(sSpecOrd.equals("Y")){%>checked value="Y"<%} else{%>value=" "<%}%><%}%> > 
        		<td>
        		<td class="DataTable6" rowspan=2 nowrap>
           			 
               			<span id="spnExpDt">Enter <span style="font-weight:bold; color: #d35400;">Quote</span> Expiration Date</span> 
               			 <span id="spnOrConj"><br><b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - or -</b><br></span> 
               			
               			<span id="spnDelDate">Enter <span style="font-weight:bold; color: green;">Sales</span> Delivery Date</span>  
               			
           			 
        		</td>
        		<td class="DataTable6" rowspan=2 nowrap>   
           			<button class="NonPrt" name="Down" id="Down" onClick="setDate('DOWN')">&#60;</button>         
           			<input type="text" name="DelDate" readonly size=10 maxlength=10>
           			<button class="NonPrt" name="Up" id="Up" onClick="setDate('UP')">&#62;</button> &nbsp;&nbsp;
           			<a class="NonPrt" id="shwCal" href="javascript:showCalendar(1, null, null, 600, 300, document.all.DelDate, null, 'PfsCheckDelDate.jsp')" >
           			<img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
           			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           			<button class="Small"   id="shwDelDate" onclick="showDelDateInq();">Display Delivery Schedule</button>            
      			</td>
      		</tr>	
      		<tr  class="DataTable">
      			<td class="DataTable6" nowrap>
      	    		<%if(!sSts.equals("C") && !sSts.equals("D") && !sSts.equals("E") && iNumOfSpc == 0){%>
              			<input class="NonPrt" type="checkbox" name="chbCustPup" onClick="setCustPickup(this)"
                		<%if(sCustPickup.equals("Y")){%>checked<%}%>>Customer Pickup</button>            
           			<%} else{%><input type="hidden" name="chbCustPup" <%if(sCustPickup.equals("Y")){%>checked<%}%> ><%}%>
      			</td>
      	   </tr>
         </table> 
    <tr class="NonPrt">
      	<td colspan="3" nowrap>       
       		<%if(sSts.equals("") || sSts.equals("Q")){%>
         		 <button class="Small" id="SaveQuote" onClick="ValidateHdr('QUO')">Create/Update a <b style="color:  #d35400;font-size:14px">QUOTE</b></button>&nbsp;&nbsp;
       		<%}%>
       		<button class="Small" id="SaveOrder" onClick="ValidateHdr('ORD')">Create/Update a <b style="color: green;font-size:14px">SALE</b></button>&nbsp;&nbsp;
       
       		<%if(bAlwWarOrd){%>
          		<%for(int i=0; i < 50; i++){%> &nbsp;<%}%>
          		<button class="Small" id="SaveWarr" onClick="ValidateHdr('WAR')">Create a WARRANTY (Store Stock/No Prior Order)</button>&nbsp;&nbsp;
       		<%}%>
    	</td>
      </tr>
    
   <!-- =========================================================== -->   
   </table><br>
     </td>
  </tr>
  <!----------------------- end of table ------------------------>
   
  <!--------------------------------------------------------------------------------->
  <!----------------------- Add/Update/Delete New line ------------------------------>
  <!--------------------------------------------------------------------------------->
  <tr class="NonPrt">
     <td colspan="3" id="tdDetail">
     <%if(iNumOfSpc > 0){%>&nbsp;<br>
        <span style="font-weight:bold; font-size:11px">Vendor Style cannot be changed. Delete SO item then re-add SO item correctly.</span>
     <%}%>

     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbAddLine">

       <tr class="DataTable1"><th class="DataTable2" colspan=29>Order Item Entry<th></tr>
       <tr class="DataTable1">
        <th class="DataTable2" rowspan=2 nowrap>Short Sku / UPC<br>
             <a target="_blank" class="Small" href="UpcSearch.jsp">Search Items</a>
             <br><a target="_blank" class="Small" href="ItemSearch.jsp">Search Items In-Stock</a>
        </th>
        <th class="DataTable21" rowspan=2 nowrap>Description</th>
        <th class="DataTable21" colspan=2 id="thStr35" nowrap>Store 35</th>
        <th class="DataTable21" colspan=2 id="thStr46" nowrap>Store 46</th>
        <th class="DataTable21" colspan=2 id="thStr50" nowrap>Store 50</th>
        <th class="DataTable21" colspan=2 id="thStr55" nowrap>Store 55</th>
        <th class="DataTable21" colspan=2 id="thStr63" nowrap>Store 63</th>
        <th class="DataTable21" colspan=2 id="thStr64" nowrap>Store 64</th>
        <th class="DataTable21" colspan=2 id="thStr68" nowrap>Store 68</th>
        <th class="DataTable21" colspan=2 id="thStr86" nowrap>Store 86</th>
        <th class="DataTable21" colspan=2 id="thStrOth" nowrap>Qty Avail<br><a href="javascript: showOtherStr()">(Other Stores)</a></th>
        <th class="DataTable2" rowspan=2 id="thSetTot" nowrap>Complete<br>Set <br>Quantity</th>

        <th class="DataTable2" rowspan=2 nowrap>Enter New Price<br>
             (or % Off, to redisplay Discounted Price)
        
        </th>
        <th class="DataTable2" rowspan=2 nowrap>Group</th>
        <th class="DataTable2" rowspan=2 nowrap>MSRP</th>

        <th class="DataTable2" rowspan=2 id="thAdd" nowrap>A<br>d<br>d</th>
        <th class="DataTable2" rowspan=2 id="thChg" nowrap>U<br>p<br>d</th>
        <th class="DataTable2" rowspan=2 id="thApplGrp" nowrap>G<br>r<br>p</th>
        <th class="DataTable2" rowspan=2 nowrap>C<br>x<br>l</th>
        <th class="DataTable2" rowspan=2 id="thDlt"nowrap>D<br>l<br>t</th>
        <th class="DataTable2" rowspan=2 id="thTake"nowrap>T<br>a<br>k<br>e<br>n</th>        
       </tr>
       <tr class="DataTable1">
        <th class="DataTable2" id="thStr35" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv35"nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr46" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv46"nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr50" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv50" nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr55" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv55" nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr63" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv63" nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr64" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv64" nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr68" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv68" nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr86" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv86" nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStrOth" nowrap>Inv</th>
        <th class="DataTable21" id="thRcvOth" nowrap>Order<br>Quantity</th>
      </tr>

      <tr  class="DataTable3">
        <td class="DataTable5" nowrap>
           <input class="Small" type="text" name="Sku" onBlur="getSku(this, 'ADD') " onKeyPress="if(event.keyCode==13){ getSku(this, 'ADD') }" size=10 maxlength=10> /
           <input class="Small" type="text" name="Upc" onBlur="getUpc(this, 'ADD')" onKeyPress="if(event.keyCode==13 || event.keyCode==9){ getUpc(this, 'ADD') }" size=14 maxlength=13>
           
           <%if(sSpecOrd.equals("Y")){%>
                &nbsp; or &nbsp;
           		<button class="Small" onclick="document.all.Sku.value='5487251'; getSku(document.all.Sku, 'ADD')">SO</button>
           <%}%>
        </td>
        <td class="DataTable31" id="tdDesc" nowrap>&nbsp;</td>
        <td class="DataTable3" id="tdQty35" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp35" nowrap><input type="text" name="Qty35" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty46" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp46" nowrap><input type="text" name="Qty46" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty50" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp50" nowrap><input type="text" name="Qty50" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty55" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp55" nowrap><input type="text" name="Qty55" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty63" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp63" nowrap><input type="text" name="Qty63" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty64" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp64" nowrap><input type="text" name="Qty64" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty68" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp68" nowrap><input type="text" name="Qty68" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty86" nowrap>&nbsp;</td>
        <td class="DataTable31" id="tdQtyInp86" nowrap><input type="text" name="Qty86" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQtyOth" nowrap>&nbsp;</td>
        <td class="DataTable3" id="tdQtyInpOth" nowrap>&nbsp;</td>

        <td class="DataTable3" id="tdAddSetTot" nowrap><input type="text" name="SetQty" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdPrice" nowrap><input type="text" name="Price" size=10 maxlength=10>
            &nbsp;&nbsp;&nbsp; <input type="text" name="PriceOff" size=3 maxlength=2 onblur="clcNewPrice()">% Off 
        </td>
        <td class="DataTable3" id="tdGroup" nowrap>&nbsp;</td>
        <td class="DataTable3" id="tdSugPrc" nowrap>&nbsp;</td>
        <td class="DataTable3" id="tdAdd" nowrap><a href="javascript: processLine('ADD')">A</a></td>
        <td class="DataTable3" id="tdChg" nowrap><a href="javascript: processLine('UPD')">U</a></td>
        <td class="DataTable3" id="tdApplGrp" nowrap><a href="javascript: applyGroupPrice()">G</a></td>
        <td class="DataTable3" nowrap><a href="javascript:clrLine()">C</a></td>
        <td class="DataTable3" id="tdDlt" nowrap><a href="javascript: processLine('DLT')">D</a></td>
        <td class="DataTable3" id="tdTake" nowrap>
          <span id="spnTake"><a href="javascript: showTakePanel('ITM', '0')">T</a></span>
          <span id="spnTake">&nbsp;</span>
        </td>
      </tr>
      <!-- --------------------- New Set Components ------------------------ -->
      <%for(int i=0; i < 50; i++) {%>
         <tr  class="DataTable1" id="trSet">
           <td class="DataTable3" id="tdSetSku" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetDesc" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetQty35" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty35i" nowrap><input type="text" name="SetQty35" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty46" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty46i" nowrap><input type="text" name="SetQty46" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty50" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty50i" nowrap><input type="text" name="SetQty50" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty55" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty55i" nowrap><input type="text" name="SetQty55" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty63" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty63i" nowrap><input type="text" name="SetQty63" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty64" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty64i" nowrap><input type="text" name="SetQty64" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty68" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty68i" nowrap><input type="text" name="SetQty68" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty86" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetQty86i" nowrap><input type="text" name="SetQty86" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQtyOth" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetQtyOthi" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetTot" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetPrice" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetGroup" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetSugPrc" nowrap>&nbsp;</td>
           <td class="DataTable3" colspan=4 nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetTake" nowrap><a href="javascript: showTakePanel('SET', '<%=i%>')">T</a></td>
         </tr>
      <%}%>
      <!-- ------------------- End of Set Components ----------------------- -->
    </table>
    </td>
  </tr>

  <!--------------------------------------------------------------------------->
  <!------------------- Add/Update/Delete Special Order ----------------------->
  <!--------------------------------------------------------------------------->
  <tr class="NonPrt">
     <td colspan="3" id="tdDetail1"><br>

     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbAddSpcOrd">
       <tr  class="DataTable1">
        <th class="DataTable2" colspan=10>Special Order Item Entry</th></tr>
       <tr  class="DataTable1">
        <th class="DataTable2" nowrap>Short Sku</th>
        <th class="DataTable2" nowrap>Vendor</th>
        <th class="DataTable2" nowrap>Vendor Info</th>

        <th class="DataTable2" nowrap>Vendor Style</th>
        <th class="DataTable2" nowrap>Description</th>
        <th class="DataTable2" nowrap>Qty</th>
        <th class="DataTable2" nowrap>Price</th>
        <th class="DataTable2" id="thSoAdd" nowrap>A<br>d<br>d</th>
        <th class="DataTable2" id="thSoChg" nowrap>U<br>p<br>d</th>
        <th class="DataTable2" nowrap>C<br>x<br>l</th>
        <th class="DataTable2" id="thSoDlt"nowrap>D<br>l<br>t</th>
      </tr>

      <tr  class="DataTable3">
        <td class="DataTable5" id="tdSoSku" nowrap>&nbsp;</td>
        <td class="DataTable5" nowrap><input type="text" name="SoVen" onclick="chkVen(this)" readonly size=5 maxlength=5></td>
        <td class="DataTable3" id="tdSoVenInfo" nowrap>&nbsp;</td>
        <td class="DataTable5" nowrap><input type="text" name="SoVenSty" size=15 maxlength=15></td>
        <td class="DataTable5" nowrap><input type="text" name="SoDesc" size=25 maxlength=50></td>
        <td class="DataTable5" nowrap><input type="text" name="SoQty" size=5 maxlength=5></td>
        <td class="DataTable5" nowrap><input type="text" name="SoPrice" size=10 maxlength=10></td>

        <td class="DataTable5" id="tdSoAdd" rowspan=3 nowrap><a href="javascript: processSoLine('ADDSPOR')">A</a></td>
        <td class="DataTable5" id="tdSoChg" rowspan=3 nowrap><a href="javascript: processSoLine('UPDSPOR')">U</a></td>
        <td class="DataTable5" nowrap rowspan=3><a href="javascript:clrLine()">C</a></td>
        <td class="DataTable5" id="tdSoDlt" rowspan=3 nowrap><a href="javascript: processSoLine('DLTSPOR')">D</a></td>
      </tr>

      <tr  class="DataTable1">
        <th class="DataTable2" nowrap>Frame Color</th>
        <th class="DataTable2" nowrap>Frame Material</th>
        <th class="DataTable2" nowrap>Fabric Color</th>
        <th class="DataTable2" nowrap>Fabric Number</th>
        <th class="DataTable2" nowrap colspan=2>Comment</th>
        <th class="DataTable2" nowrap>PO #</th>
      </tr>
      <tr  class="DataTable3">
        <td class="DataTable5" nowrap><input type="text" name="SoFrmClr" size=10 maxlength=20></td>
        <td class="DataTable5" nowrap><input type="text" name="SoFrmMat" size=10 maxlength=20></td>
        <td class="DataTable5" nowrap><input type="text" name="SoFabClr" size=10 maxlength=20></td>
        <td class="DataTable5" nowrap><input type="text" name="SoFabNum" size=5 maxlength=5></td>
        <td class="DataTable5" nowrap colspan=2><input type="text" name="SoComment" size=25 maxlength=25></td>
        <td class="DataTable5" nowrap><input type="text" onBlur="//checkPON(this)" name="SoPoNum" size=10 maxlength=10 readonly></td>
        </tr>
    </table>
   </td>
  </tr>
  <!----------------------- end of table ------------------------>

  <!----------------------- Already Entered Items ------------------------------>
  <tr>
     <td colspan="3"  id="tdDetail2">

    <%if(iNumOfItm > 0) {%>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable"><th class="DataTable" colspan=11>Order Details<th></tr>
       <tr  class="DataTable">
        <th class="DataTable" nowrap>Short Sku</th>
        <th class="DataTable3" nowrap><span style="font-size:10px;">1st Line:&nbsp;</span> &nbsp; Vendor Style<br><span style="font-size:10px;">2nd Line:</span> &nbsp; Vendor Name</th>
        <th class="DataTable" nowrap>Description</th>
        <th class="DataTable" nowrap>Color</th>
        <th class="DataTable" nowrap>MSRP</th>
        <th class="DataTable" nowrap>Our<br>Price</th>
        <th class="DataTable" nowrap>Disc<br>Price</th>        
        <th class="DataTable" nowrap>Total<br>Qty</th>
        <th class="DataTable" nowrap>Total<br>Price</th>
        <th class="DataTable" nowrap>Qty<br>Taken<br>Today</th>
        <th class="DataTable" nowrap>Add<br>Photo/Doc</th>        
      </tr>
      <TBODY>

      <!----------------------- Items ------------------------>
      <%for(int i=0; i < iNumOfItm; i++) {%>
          <tr  class="DataTable">
            <td class="DataTable2" rowspan=2>
            <%if(!sSts.equals("C")  && !sSts.equals("D") && !sSts.equals("R") && !sSts.equals("Z") && !sSts.equals("E")){%>
              <a href="javascript:updLine(<%=i%>)"><%=sSku[i]%></a>
            <%} else{%><%=sSku[i]%><%}%>
              <%if(sSet[i].equals("1")){%><font color="darkbrown">(Set)</font><%}%>
            </td>
            <td class="DataTable"><%=sVenSty[i]%></td>
            <td class="DataTable" rowspan=2><%=sDesc[i]%></td>
            <td class="DataTable" rowspan=2><%=sColor[i]%></td>
            <td class="DataTable1" rowspan=2>$<%=fmt.getFormatedNum(sSugPrc[i], "#,###,###.##")%></td>
            <td class="DataTable1" rowspan=2>$<%=fmt.getFormatedNum(sIpRet[i], "#,###,###.##")%></td>
            <td class="DataTable1" rowspan=2 <%if(!sIpRet[i].equals(sClcPrc[i])){%>style="background: yellow;"<%}%>>$<%=fmt.getFormatedNum(sClcPrc[i], "#,###,###.##")%></td>            
            <td class="DataTable1" rowspan=2><%=sQty[i]%></td>
            <td class="DataTable1" rowspan=2>$<%=sTotal[i]%></td>
            <td class="DataTable1" rowspan=2><%if(iNumOfSet[i] == 0){%><%=sQtyTaken[i]%><%} else {%>&nbsp;<%}%></td>
            <td class="DataTable2" rowspan=2>
                <a href="javascript:loadPhoto('<%=sSku[i]%>')">Upload</a>
            </td>    
          </tr>
          <tr  class="DataTable">
             <td class="DataTable"><%=sVen[i] + " - " + sVenName[i]%></td>
          </tr>

          <%if(sStock != null && iNumOfSet[i] == 0){%>
            <tr class="DataTable7">
               <%
                  String [] sInvStr = new String[8];
                  int iis = 0;
                  if(!sQty35[i].equals("0")){ sInvStr[iis++] = "35: " + sQty35[i]; }
                  if(!sQty46[i].equals("0")){ sInvStr[iis++] = "46: " + sQty46[i]; }
                  if(!sQty50[i].equals("0")){ sInvStr[iis++] = "50: " + sQty50[i]; }
                  if(!sQty86[i].equals("0")){ sInvStr[iis++] = "86: " + sQty86[i]; }
                  if(!sQty55[i].equals("0")){ sInvStr[iis++] = "55: " + sQty55[i]; }
                  if(!sQty63[i].equals("0")){ sInvStr[iis++] = "63: " + sQty63[i]; }
                  if(!sQty64[i].equals("0")){ sInvStr[iis++] = "64: " + sQty64[i]; }
                  if(!sQty68[i].equals("0")){ sInvStr[iis++] = "68: " + sQty68[i]; }
               %>
               <td class="DataTable" style="background:white">&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[0] != null){%><%=sInvStr[0]%><%}%>&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[1] != null){%><%=sInvStr[1]%><%}%>&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[2] != null){%><%=sInvStr[2]%><%}%>&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[3] != null){%><%=sInvStr[3]%><%}%>&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[4] != null){%><%=sInvStr[4]%><%}%>&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[5] != null){%><%=sInvStr[5]%><%}%>&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[6] != null){%><%=sInvStr[6]%><%}%>&nbsp;</td>
               <td class="DataTable"><%if(sInvStr[7] != null){%><%=sInvStr[7]%><%}%>&nbsp;</td>
               <td class="DataTable">&nbsp;</td>
            </tr>
          <%}%>
          <%if(iNumOfSet[i] > 0 && sList.equals("Y")) { %>
              <%for(int j=0; j < iNumOfSet[i]; j++) {%>
                 <tr  class="DataTable1">
                   <td class="DataTable2"><%=sSetSku[i][j]%></td>
                   <td class="DataTable2"><%=sSetUpc[i][j]%></td>
                   <td class="DataTable"><%=sSetDesc[i][j]%></td>
                   <td class="DataTable"><%=sSetColor[i][j]%></td>
                   <td class="DataTable1">&nbsp;</td>
                   <td class="DataTable1">&nbsp;</td>
                   <td class="DataTable1">&nbsp;</td>
                   <td class="DataTable1"><%=sSetQty[i][j]%></td>
                   <td class="DataTable1">&nbsp;</td>
                   <td class="DataTable1"><%=sSetQtyTaken[i][j]%></td>
                 </tr>
                 <%if(sStock != null){%>
                   <tr  class="DataTable7">
                     <%
                        String [] sInvStr = new String[8];
                        int iis = 0;
                        if(!sSetQty35[i][j].equals("0")){ sInvStr[iis++] = "35: " + sSetQty35[i][j]; }
                        if(!sSetQty46[i][j].equals("0")){ sInvStr[iis++] = "46: " + sSetQty46[i][j]; }
                        if(!sSetQty50[i][j].equals("0")){ sInvStr[iis++] = "50: " + sSetQty50[i][j]; }
                        if(!sSetQty86[i][j].equals("0")){ sInvStr[iis++] = "86: " + sSetQty86[i][j]; }
                        if(!sSetQty55[i][j].equals("0")){ sInvStr[iis++] = "55: " + sSetQty55[i][j]; }
                        if(!sSetQty63[i][j].equals("0")){ sInvStr[iis++] = "63: " + sSetQty63[i][j]; }
                        if(!sSetQty64[i][j].equals("0")){ sInvStr[iis++] = "64: " + sSetQty64[i][j]; }
                        if(!sSetQty68[i][j].equals("0")){ sInvStr[iis++] = "68: " + sSetQty68[i][j]; }
                     %>
                     <td class="DataTable"  style="background:white">&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[0] != null){%><%=sInvStr[0]%><%}%>&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[1] != null){%><%=sInvStr[1]%><%}%>&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[2] != null){%><%=sInvStr[2]%><%}%>&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[3] != null){%><%=sInvStr[3]%><%}%>&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[4] != null){%><%=sInvStr[4]%><%}%>&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[5] != null){%><%=sInvStr[5]%><%}%>&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[6] != null){%><%=sInvStr[6]%><%}%>&nbsp;</td>
                     <td class="DataTable"><%if(sInvStr[7] != null){%><%=sInvStr[7]%><%}%>&nbsp;</td>
                     <td class="DataTable">&nbsp;</td>
            </tr>
           <%}%>
         <%}%>
       <%}%>
     <%}%>
     <%if(iNumOfItm > 0){%>
        <tr class="DataTable1">
           <td class="DataTable2">Total</td>
           <td class="DataTable2">&nbsp;</td>
           <td class="DataTable2">&nbsp;</td>
           <td class="DataTable2">&nbsp;</td>
           <td class="DataTable2">$<%=sOrdMsrp%></td>
           <td class="DataTable2">&nbsp;</td>
           <td class="DataTable2">$<%=sOrdAfterDsc%></td>           
           <td class="DataTable2"><%=sTotQty%></td>
           <td class="DataTable2">$<%=sOrdSubTot%></td>
           <td class="DataTable2">&nbsp;</td>
        </tr>
     <%}%>
     <!---------------------------------------------------------------------->

      </TBODY>
    </table><br>
   <%}%>
  <!----------------------- end of table ------------------------>

  <!-------------------------- Special Order ---------------------------------->
  <%if(iNumOfSpc > 0){%>
  <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
      <tr  class="DataTable">
        <th class="DataTable" nowrap colspan="8">Special Orders</th>
      </tr>
       <tr  class="DataTable">
        <th class="DataTable" nowrap>Vendor/<br>Name</th>
        <th class="DataTable" nowrap>Vendor Style</th>
        <th class="DataTable" nowrap>Description/<br>Frame Color</th>
        <th class="DataTable" nowrap>Short Sku/<br>Frame Material</th>
        <th class="DataTable" nowrap>Price/<br>Fabric Color</th>
        <th class="DataTable" nowrap>Discount<br>Price/<br>Fabric #</th>
        <th class="DataTable" nowrap>Qty<br></th>
        <th class="DataTable" nowrap>Total<br>Price/<br>Comment/PO#</th>
      </tr>
      <%for(int i=0; i < iNumOfSpc; i++) {%>
          <tr  class="DataTable">
            <td class="DataTable2" rowspan=1>
              <%if(sSoPoNum[i].equals("")){%>
                 <a href="javascript:updSoLine(<%=i%>)"><%=sSoVen[i]%></a>
              <%} else {%>
                 <a href="javascript:alert('PO has been placed, no changes can be made to this Special Order')"><%=sSoVen[i]%></a>
              <%}%>
            </td>
            <td class="DataTable2" rowspan=1><%=sSoVenSty[i]%></td>
            <td class="DataTable"><%=sSoDesc[i]%></td>
            <td class="DataTable2"><%=sSoSku[i]%></td>
            <td class="DataTable1">$<%=fmt.getFormatedNum(sSoRet[i], "#,###,###.##")%></td>
            <td class="DataTable1">&nbsp;<%if(!sSoClcPrc[i].equals(".00")){%>$<%=fmt.getFormatedNum(sSoClcPrc[i], "#,###,###.##")%><%}%></td>
            <td class="DataTable1"><%=sSoQty[i]%></td>
            <td class="DataTable1">$<%=fmt.getFormatedNum(sSoTotal[i], "#,###,###.##")%></td>
          </tr>
          <tr  class="DataTable">
            <td class="DataTable" colspan=2><%=sSoVenName[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoFrmClr[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoFrmMat[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoFabClr[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoFabNum[i]%>&nbsp;</td>
            <td class="DataTable">&nbsp;</td>
            <td class="DataTable"><%=sSoComment[i]%>&nbsp;
                    <%if(!sSoComment[i].trim().equals("")){%><br><%}%><%="<u>PO# " + sSoPoNum[i] + "</u>"%></td>
          </tr>
      <%}%>

      <%if(iNumOfSpc > 0){%>
             <tr class="DataTable1">
              <td class="DataTable2">Total</td>
              <td class="DataTable2">&nbsp;</td>
              <td class="DataTable2">&nbsp;</td>
              <td class="DataTable2">&nbsp;</td>
              <td class="DataTable2">&nbsp;</td>
              <td class="DataTable2">$<%=sOrdAfterDsc%></td>

              <td class="DataTable2"><%=sTotQty%></td>
              <td class="DataTable2">$<%=sOrdSubTot%></td>
            </tr>
      <%}%>
   </table>
  <%}%>
    </td>
  </tr>
<tr>
    <td id="tdDetail3" colspan=2>      
      <table border=1 style="font-size:10px; text-align:center">
      	<tr>
        	<%for(int i=0; i < iNumOfPic; i++){%><td><%=sPicSku[i]%></td><%}%>
        </tr>
        <tr>	
        	<%for(int i=0; i < iNumOfPic; i++){%>
        	    <td><a href="/Patio_Furniture/<%=sPicFile[i]%>"><%=sPicFile[i]%></a></td>
        	<%}%>
        </tr>
        <tr>	
        	<%for(int i=0; i < iNumOfPic; i++){%>
        	    <td><a href="javascript: dltPicture('<%=sPicSku[i]%>', '<%=sPicFile[i]%>')">Delete</a></td>
        	<%}%>
        </tr>
      </table>
    </td>
</tr>
  <!----------------------- Signature  ------------------------------>
  <tr>
     <td id="tdDetail3" style="font-size:10px;text-align:right" nowrap  colspan=2>
       <%if(iNumOfItm > 0){%>
          <div style="border:1px solid black;font-weight:bold;font-size:12px; background:yellow;width=350px;text-align:left">
              Total MSRP $<%=sOrdMsrp%>, discounted by <%=sOrdMsrpDscPrc%>% saves $<%=sOrdMsrpDsc%>
              <br>Total Discount off OUR Price = <%=sOrdRetDscPrc%>% saves $<%=sOrdRetDsc%>
          </div>
        <br>
      <%}%>
     <td id="tdDetail3" style="font-size:10px;text-align:right;" nowrap rowspan=2>
      <%if(bExist) {%>
       <select class="selSts" name="ProtPlanPrc" onchange="setProtPlan(this)">
        <option value="0">--- Select Protective Plan ---</option>
        <option value="0">None</option>
        <option value="199.99">$199.99 (<b>less</b> then 4000)</option>
        <option value="299.99">$299.99 (<b>over</b> 3999.99)</option>
       </select>
      
       <input class="selSts" name="ShpPrc" size="10" maxlength="10">
       
       <input class="selSts" name="ShpType" type="hidden">
       <button class="selSts" id="sbmShpPrc" onClick="sbmShpPrc()">Shipping</button>
       <table border=0 cellPadding="0" cellSpacing="0" id="tbTotal">
       
       <tr class="DataTable2">
         <td class="DataTable1" >Total Price</td>
         <td class="DataTable1">$<%=sOrdSubTot%></td>         
       </tr>

        <!-- ======== Discount =========== -->
         <%if(iNumOfItm > 0){%>        
          <tr  class="DataTable2">
             <td class="DataTable1" ><a href="javascript: showDiscCalc()">Multiple Discounts - Calculator</a></td>
             <td class="DataTable1">&nbsp;<%if(!sGrpItmDsc.trim().equals(".00")){%>$<%=sGrpItmDsc%><%}%></td>
          </tr>
        <%}%>
        
        <tr class="DataTable2">
         <td class="DataTable1" >Sub-Total</td>
         <td class="DataTable1">$<%=sSubAftMD%></td>         
       </tr>
        
        <tr class="DataTable2">
             <td class="DataTable1" >Single Discount
             	<a href="javascript:setShpPrc(5)" style="font-size:14px;">$</a>&nbsp;&nbsp;
             	<a href="javascript:setShpPrc(6)" style="font-size:14px;">%</a>
             </td>
             <td class="DataTable1">$<%=sOrdDscAmt%></td>             
           </td>
         </tr>
        
          <tr class="DataTable2">
             <td class="DataTable1" >All Discount</td>
             <td class="DataTable1" nowrap><%=sOrdDscPrc%>%  &nbsp; $<%=sOrdAllDscAmt%></td>             
           </td>
          </tr>
        
        <%if(!sGrpItmDsc.trim().equals(".00") || !sOrdDscAmt.trim().equals(".00")){%>
        <tr  class="DataTable2">
             <td class="DataTable1" >After discount</td>
             <td class="DataTable1" style="border:1px black solid">$<%=sOrdAfterDsc%></td>
        </tr>
        <%}%>

        <!-- Show shipping price for special order only -->
        <%if(iNumOfSpc > 0) {%>
           <tr  class="DataTable2">
              <td class="DataTable1" >Shipping</td>
              <td class="DataTable1" >
                <%if(sPySts.equals("O") || sSts.equals("Q")) {%><a href="javascript:setShpPrc(1)">$<%=sOrdShpPrc%></a>
                <%} else {%>$<%=sOrdShpPrc%><%}%>
              </td>
           </tr>
        <%}%>
        <!-- ======== Delivery =========== -->
        <tr  class="DataTable2">
           <td class="DataTable1" nowrap>
           Assembly (<%if(sPySts.equals("O") || sSts.equals("Q")) {%><a href="javascript: setShpPrc(7)">$<%=sOrdAssmbPrc%></a><%} else {%>$<%=sOrdAssmbPrc%><%}%>) 
           and Delivery (<%if(sPySts.equals("O") || sSts.equals("Q")) {%><a href="javascript: setShpPrc(2)">$<%=sOrdDlvPrc%></a><%} else {%>$<%=sOrdDlvPrc%><%}%>)</td>
           <td class="DataTable1" >$<%=sAssmb_Delvry%></td>
        </tr>
        <!-- ======== Tax =========== -->
        <tr  class="DataTable2">
           <td class="DataTable1" <%if(bTaxFree){%>style="background: pink;"<%}%>>Tax</td>
           <td class="DataTable1" <%if(bTaxFree){%>style="background: pink;"<%}%>>
             <%if(sPySts.equals("O") || sSts.equals("Q")) {%><a href="javascript:setShpPrc(3)">$<%=sOrdTax%></a>
             <%} else {%>$<%=sOrdTax%><%}%>
           </td>
        </tr>
        
        <!-- ======== Protection Plan =========== -->
        <tr  class="DataTable2">
           <td class="DataTable1" >Protection Plan</td>
           <td class="DataTable1" ><%if(sPySts.equals("O") || sSts.equals("Q")) {%><a href="javascript: setShpPrc(8)">$<%=sProtPlan%></a><%} else {%>$<%=sProtPlan%><%}%></td>
        </tr>
        
        
        <tr  class="DataTable2">
           <td class="DataTable1" id="tdTotal">Total</td>
           <td class="DataTable1">$<%=sOrdTotal%></td>
        </tr>
        <!-- for special order only -->
        <%if(!sSts.equals("Q") && !sPySts.equals("O")) {%>
           <tr class="DataTable2" style=" font-size:12px;font-weight:bold;" >
              <td class="DataTable1"><%=sPyStsNm%></td>
              <td class="DataTable1">
                <a href="javascript:showPayProp()">$<%=fmt.getFormatedNum(sOrdPaid, "#,###,###.##")%></a>
              </td>
           </tr>
        <%}%>
       </table>
     <%}%>
     </td>

  </tr>  
  <tr>
     <td id="tdDetail4" style="font-size:10px;" nowrap  colspan=2>
      <%if(!sSts.equals("Q")) {%>
        Customer Signatures<br>
        <br>Order Confirmation <b><%for(int i=0; i < 40; i++) {%>_<%}%></b>&nbsp;&nbsp;&nbsp;
        Date: <b><%for(int i=0; i < 20; i++) {%>_<%}%></b><br>
        Sign to confirm that you have reviewed the details of this order and the Patio Sale Policies.<br><br>
      <%}%>
    </td>
 </tr>
 <%if(bTaxFree){%>
    <tr> 
    	<td colspan=5 align=center>
    		<div id="dvTaxFree2" class="dvTaxFree2"></div>
    	</td>
    </tr>
  <%}%>
  
    <tr class="NonPrt">
      <td>
         <%if(!sSts.equals("Q")){%>
            <button class="Small" id="btnPrint" onclick="window.print()">Print</button>
         <%}
           else {%>
            <button class="Small" onclick="showPrintFriendly()">Print</button>
         <%}%>
      </td>
      <td>&nbsp;</td>
    </tr>

    <tr class="NonPrt">
     <td   colspan="3"><br>
       <span style="color:#6B0000; font-size:14px;font-weight:bold;text-decoration:underline">Order/Customer Note</span>
       &nbsp; &nbsp; &nbsp;
       <%if(!sSts.equals("")) {%>
       <a href="javascript: addNote('<%=ordnote.replaceSpecChar(sComments)%>');">Add/Update Order/Customer Notes</a>
       <%}%>
       <table border=1 width="100%" cellPadding=0 cellSpacing=0>
         <tr class="DataTable2">
           <td class="DataTable"><%=sComments%></td>
         </tr>
       </table>
     </td>
    </tr>

    <tr class="NonPrt">   
     <td   colspan="3"><br>
       <span style="color:#6B0000; font-size:14px;font-weight:bold;text-decoration:underline">Order Comments and Log</span>
       &nbsp; &nbsp; &nbsp;
       <a href="javascript: addComment();">Add Comment</a> &nbsp;  &nbsp;  &nbsp;
       <input type="checkbox" onclick="setCmtFilter(['AUTO', 'PAYMENT'], this)" checked>Auto &nbsp;  &nbsp;
       <input type="checkbox" onclick="setCmtFilter(['SOLD TAG'], this)" checked>Sold Tag &nbsp;  &nbsp;
       <input type="checkbox" onclick="setCmtFilter(['STORE', 'CUST'], this)" checked>Store &nbsp;  &nbsp;
       <input type="checkbox" onclick="setCmtFilter(['BUYER', 'VCN'], this)" checked>Buyer &nbsp;  &nbsp;
       <input type="checkbox" onclick="setCmtFilter(['EMAIL', 'CUST'], this)" checked>E-Mail &nbsp;  &nbsp;
 
       <table border=1 width="100%" cellPadding=0 cellSpacing=0>
         <tr class="DataTable">
           <th class="DataTable" width="5%">Type</th>
           <th class="DataTable">Comments</th>
           <th class="DataTable" width="5%">User</th>
           <th class="DataTable" width="15%">Date</th>
           <th class="DataTable" width="5%">Time</th>
         </tr>

         <%
         ordent.setOrdCommt(sOrder);
         int iNumOfCmt = ordent.getNumOfCmt();
         for(int i=0; i < iNumOfCmt;i++ )
         {
           ordent.rcvOrdCommt(i+1);
           String sCmtId = ordent.getCmtId();
           String sCmtType = ordent.getCmtType();
           String sCmtUser = ordent.getCmtUser();
           String sCmtDate = ordent.getCmtDate();
           String sCmtTime = ordent.getCmtTime();
           String sCmtMax = ordent.getCmtMax();
           String [] sCmtText = ordent.getCmtText();
         %>
             <tr class="DataTable" id="trCmtLog<%=i%>">
               <td class="DataTable2" id="tdCmtTy<%=i%>"><%=sCmtType%></td>
               <td class="DataTable">
                 <%for(int j=0; j < sCmtText.length;j++ ){%><%=sCmtText[j]%><%}%>
               </td>
               <td class="DataTable2" nowrap><%=sCmtUser%></td>
               <td class="DataTable2" nowrap><%=sCmtDate%></td>
               <td class="DataTable2" nowrap><%=sCmtTime%></td>
             </tr>
         <%}%>
         <script>NumOfCmt = "<%=iNumOfCmt%>"</script>
       </table>
     </td>
    </tr>



  </table>
<div class="PrintOnly" style="border: black solid 1px; font-size:10px;width:100%;">

<%if(sSts.equals("Q") ){%>
<b>Patio Quote</b>
Quoted prices may reflect current advertised sales, so may be subject to change.
Quantities on this quote are limited to in-stock on hand at the time this quote becomes a sale.
And Special Order items are limited to inventory availability from the Manufacturer,
which would be re-verified at the time this quote becomes a sale.<br>
<%} else {%>

<b>Patio Sale Policies</b>
Returns
<i>In-Stock sales</i>: Once your new furniture has been delivered or removed from a our showroom,
your furniture cannot be returned for a refund, store credit, exchange or otherwise. Please thoroughly examine all items before accepting them.
<i>Special Orders</i>: There can be no changes or cancellations to your special order 24 hours after
the order has been placed with a Sale representative. Your order cannot be returned for a refund,
store credit, exchange or otherwise.  Our Store considers a special order a binding agreement upon
which we make financial commitments.<br><br>

<b>Inspection</b><br>
Our Store takes great pride in the quality and condition of its products.  Every furniture product is
thoroughly inspected and tested before it is delivered to you or placed in one of our showrooms.
However, oversights can happen. Please inspect all merchandise for scratches, dents, or any other
defects prior to removing it from one of our showrooms. For deliveries, please inspect the merchandise
thoroughly for any of the above defects before our delivery personnel leave your home.
If you are unable to be present during delivery and notice any defects, contact your Patio Sale
representative the same day as the delivery.<br><br>

<b>Delivery</b><br>
There is a charge for all local deliveries and professional set up. Long-distance or custom
deliveries may incur additional charges which will be determined at the time of purchase.
If you are having merchandise delivered, you will be contacted the day prior to your
scheduled delivery date to confirm the time of delivery.
Please see above for inspection guidelines.<br><br>
<%}%>

<b>Special Orders</b><br>
If you are placing a special order, please realize that it is a <i>custom order, built especially for you</i>.
We will not place an order until 50% of the total order has been paid.  After 24 hours, this payment
is nonrefundable. If the merchandise that arrives from the factory is not the exact size, dimension or
color you expected it to be, it still cannot be returned. Please see above for information on Patio
Sale return policy. Once a special order has been placed with a Patio Sale representative there can
be no changes or cancellations. For special orders sent directly to you from the manufacturer
(cushions, umbrellas and accessories only), full payment must be received at the time the order is
placed. Please check your Patio Sale invoice with the manufacture's model name and model number
to make sure we are ordering the exact item you intend. Also, please verify the "ship to" address.<br><br>

The <i>estimated</i> delivery time for your special order of __________________________ is _______
to _______ weeks from the time of purchase.  Our Store cannot be held responsible for any
manufacturing or shipping delays that may cause the delivery of your merchandise to exceed your
original quote time.<br><br>
<br>
Customer Initials ________  I have received a copy of the Patio Warranty Information.
<br><br>
<b>Payment</b><br>
Final payment will be due prior to the delivery of your merchandise. Your signature on the front of this
invoice authorizes our store to charge your credit card for any remaining balance remaining on your order.
<div>

 </body>
</html>
<%}
else{%>
  <div style="border:3px solid black; font-size:20px">
    <%for(int i=0; i < iNumOfErr; i++){%><br><%=sArrErr[i]%><%}%>
  </div>
<%}%>
<%
   ordent.disconnect();
   ordent = null;
   ordnote.disconnect();
   ordnote = null;
}%>






