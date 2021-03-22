<%@ page import="rental.RentTagAvlList, java.util.*, java.text.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");
   String sStr = request.getParameter("Str");
   String sDesc = request.getParameter("Desc");
   String sClrNm = request.getParameter("ClrNm"); 
   String sSizNm = request.getParameter("SizNm");
   String sRow = request.getParameter("Row");

   String sUser = session.getAttribute("USER").toString();
   //System.out.println(sCls + "|" + sVen + "|" + sSty + "|" + sClr + "|" + sSiz + "|" + sStr + "|"
   //     + sFrDate + "|" + sToDate + "|" + sUser );
   RentTagAvlList rentinv = new RentTagAvlList(sCls, sVen, sSty, sClr, sSiz, sStr, sFrDate, sToDate, sUser );
   int iNumOfDat = rentinv.getNumOfDat();
   String sDate = rentinv.getDateJsa();
   String sMonth = rentinv.getMonthJsa();
   String sDay = rentinv.getDayJsa();

%>


<SCRIPT language="JavaScript1.2">
var Date = [<%=sDate%>];
var Month = [<%=sMonth%>];
var Day = [<%=sDay%>];

var Cls = "<%=sCls%>";
var Ven = "<%=sVen%>";
var Sty = "<%=sSty%>";
var Clr = "<%=sClr%>";
var Siz = "<%=sSiz%>";
var Desc = "<%=sDesc%>";
var ClrNm = "<%=sClrNm%>";
var SizNm = "<%=sSizNm%>";
var Row = "<%=sRow%>"

var InvId = new Array();
var SrlNum = new Array();
var DateQty = new Array();
var DateAvlQty = new Array();
var ContId = new Array();
var CustId = new Array();
var FirstNm = new Array();
var LastNm = new Array();
var Group = new Array();
var PrevDt = new Array();
var NextDt = new Array();
var Sts = new Array();

   <%
     int i = 0;
     while(rentinv.getNext())
     {
        rentinv.getItemList();

        String sInvId = rentinv.getInvId();
        String sSrlNum = rentinv.getSrlNum();
        String sQty = rentinv.getQty();

        rentinv.getItemDtl();
        String sDateQty = rentinv.getDateQtyJsa();
        String sDateAvlQty = rentinv.getDateAvlQtyJsa();
        String sContId = rentinv.getContIdJsa();
        String sCustId = rentinv.getCustIdJsa();
        String sFirstNm = rentinv.getFirstNmJsa();
        String sLastNm = rentinv.getLastNmJsa();
        String sGroup = rentinv.getGroupJsa();
        String sPrevDt = rentinv.getPrevDtJsa();
        String sNextDt = rentinv.getNextDtJsa();
        String sStsJsa = rentinv.getStsJsa();
   %>
        InvId[<%=i%>] = "<%=sInvId%>";
        SrlNum[<%=i%>] = "<%=sSrlNum%>";
        DateQty[<%=i%>] = [<%=sDateQty%>];
        DateAvlQty[<%=i%>] = [<%=sDateAvlQty%>];
        ContId[<%=i%>] = [<%=sContId%>];
        CustId[<%=i%>] = [<%=sCustId%>];
        FirstNm[<%=i%>] = [<%=sFirstNm%>];
        LastNm[<%=i%>] = [<%=sLastNm%>];
        Group[<%=i%>] = [<%=sGroup%>];
        PrevDt[<%=i%>] = [<%=sPrevDt%>];
        NextDt[<%=i%>] = [<%=sNextDt%>];
        Sts[<%=i%>] = [<%=sStsJsa%>];
   <%
        i++;
     }
     rentinv.disconnect();
   %>

   parent.showTagAvl(Cls, Ven,  Sty, Clr, Siz, Desc, ClrNm, SizNm, InvId, SrlNum
    , DateQty, DateAvlQty, Date, Month, Day, ContId, CustId, FirstNm, LastNm, Group
    , PrevDt, NextDt, Sts, Row )

</SCRIPT>













