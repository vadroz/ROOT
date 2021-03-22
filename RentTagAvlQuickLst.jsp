<%@ page import="rental.RentTagAvlQuickLst, java.util.*, java.text.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");
   String sStr = request.getParameter("Str");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sDesc = request.getParameter("Desc");
   String sClrNm = request.getParameter("ClrNm");
   String sSizNm = request.getParameter("SizNm");
   String sRow = request.getParameter("Row");

   if(sToDate == null){ sToDate = "TWOWEEKS"; }

   String sUser = session.getAttribute("USER").toString();
   System.out.println(sCls + "|" + sVen + "|" + sSty + "|" + sClr + "|" + sSiz + "|" + sStr + "|"
        + sFrDate + "|" + sToDate + "|" + sUser );
   RentTagAvlQuickLst rentinv = new RentTagAvlQuickLst(sCls, sVen, sSty, sClr, sSiz, sStr, sFrDate, sToDate, sUser );   
%>


<SCRIPT language="JavaScript1.2">
var Str = "<%=sStr%>";

var Cls = "<%=sCls%>";
var Ven = "<%=sVen%>";
var Sty = "<%=sSty%>";
var Clr = "<%=sClr%>";
var Siz = "<%=sSiz%>";
var Desc = "<%=sDesc%>";
var ClrNm = "<%=sClrNm%>";
var SizNm = "<%=sSizNm%>";
var Row = "<%=sRow%>";
var Str = "<%=sStr%>";

var InvId = new Array();
var SrlNum = new Array();
var ItmSts = new Array();
var ContId = new Array();
var PickDt = new Array();
var RtnDt = new Array();
var RmvDt = new Array();
var PurchYr = new Array();
var EquipTy = new Array();
var TestDt = new Array();
var Grade = new Array();
var Tech = new Array();
var TechNm = new Array();
var RmvUs = new Array();
var Brand = new Array();
var Model = new Array();
var AddDt = new Array();
var MfgSn = new Array();
var Life = new Array();
var VenNm = new Array();
var CmAddUs = new Array();
var CmAddDt = new Array();
var CmAddTm = new Array();
var PiStr = new Array();
var PiArea = new Array();
var PiDate = new Array();
var PiTime = new Array();
var ContSts = new Array();

  <%
     int i = 0;
     //System.out.print("\nFirst");
     while(rentinv.getNext())
     {
        rentinv.getItemList();

        String sInvId = rentinv.getInvId();
        String sSrlNum = rentinv.getSrlNum();
        String sItmSts = rentinv.getItmSts();        
        String sContId = rentinv.getContId();
        String sPickDt = rentinv.getPickDt();
        String sRtnDt = rentinv.getReturnDt();
        String sRmvDt = rentinv.getRmvDt();
        String sPurchYr = rentinv.getPurchYr();
        String sEquipTy = rentinv.getEquipTy();
        String sTestDt = rentinv.getTestDt();
        String sGrade = rentinv.getGrade();
        String sTech = rentinv.getTech();
        String sTechNm = rentinv.getTechNm();
        String sRmvUs = rentinv.getRmvUs();
        String sBrand = rentinv.getBrand();
        String sModel = rentinv.getModel();
        String sAddDt = rentinv.getAddDt();
        String sMfgSn = rentinv.getMfgSn();
        String sLife = rentinv.getLife();
        String sVenNm = rentinv.getVenNm();
        String sCmAddUs = rentinv.getCmAddUs();
        String sCmAddDt = rentinv.getCmAddDt();
        String sCmAddTm = rentinv.getCmAddTm();
        String sPiStr = rentinv.getPiStr();
        String sPiArea = rentinv.getPiArea();
        String sPiDate = rentinv.getPiDate();
        String sPiTime = rentinv.getPiTime();
        String sContSts = rentinv.getContSts();
        
        //System.out.print("\nSrlNum: " + sSrlNum + "\nsPickDt: " + sPickDt + "\nsRtnDt: " + sRtnDt );
   %>
        InvId[<%=i%>] = "<%=sInvId%>";
        SrlNum[<%=i%>] = "<%=sSrlNum%>";
        ItmSts[<%=i%>] = "<%=sItmSts%>";
        ContId[<%=i%>] = "<%=sContId%>";
        PickDt[<%=i%>] = "<%=sPickDt%>";
        RtnDt[<%=i%>] = "<%=sRtnDt%>";
        RmvDt[<%=i%>] = "<%=sRmvDt%>";
        PurchYr[<%=i%>] = "<%=sPurchYr%>";
        EquipTy[<%=i%>] = "<%=sEquipTy%>";
        TestDt[<%=i%>] = "<%=sTestDt%>";
        Grade[<%=i%>] = "<%=sGrade%>";
        Tech[<%=i%>] = "<%=sTech%>";
        TechNm[<%=i%>] = "<%=sTechNm%>";
        RmvUs[<%=i%>] = "<%=sRmvUs%>";
        Brand[<%=i%>] = "<%=sBrand%>";
        Model[<%=i%>] = "<%=sModel%>";
        AddDt[<%=i%>] = "<%=sAddDt%>";
        MfgSn[<%=i%>] = "<%=sMfgSn%>";
        Life[<%=i%>] = "<%=sLife%>";
        VenNm[<%=i%>] = "<%=sVenNm%>";
        CmAddUs[<%=i%>] = "<%=sCmAddUs%>";
        CmAddDt[<%=i%>] = "<%=sCmAddDt%>";
        CmAddTm[<%=i%>] = "<%=sCmAddTm%>";
        PiStr[<%=i%>] = "<%=sPiStr%>";
        PiArea[<%=i%>] = "<%=sPiArea%>";
        PiDate[<%=i%>] = "<%=sPiDate%>"; 
        PiTime[<%=i%>] = "<%=sPiTime%>"; 
        ContSts[<%=i%>] = "<%=sContSts%>";
   <%
        i++;
     }
     rentinv.disconnect();
   %>

   parent.showTagAvl(Cls, Ven,  Sty, Clr, Siz, Desc, ClrNm, SizNm, InvId, SrlNum
    , ContId, PickDt, RtnDt, Str, ItmSts, RmvDt, PurchYr, EquipTy, Row, TestDt
    , Grade, Tech, TechNm, RmvUs, Brand, Model, AddDt, MfgSn, Life, VenNm
    , CmAddUs, CmAddDt, CmAddTm, PiStr, PiArea, PiDate, PiTime, ContSts)

</SCRIPT>













