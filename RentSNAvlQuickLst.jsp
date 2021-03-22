<%@ page import="rental.RentSNAvlQuickLst, java.util.*, java.text.*"%>
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
   RentSNAvlQuickLst rentinv = new RentSNAvlQuickLst(sCls, sVen, sSty, sClr, sSiz, sStr, sFrDate, sToDate, sUser );   
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
 

  <%
     int i = 0;
     //System.out.print("\nFirst");
     while(rentinv.getNext())
     {
        rentinv.getItemList();

        String sInvId = rentinv.getInvId();
        String sSrlNum = rentinv.getSrlNum();
         
        
        //System.out.print("\nSrlNum: " + sSrlNum + "\nsPickDt: " + sPickDt + "\nsRtnDt: " + sRtnDt );
   %>
        InvId[<%=i%>] = "<%=sInvId%>";
        SrlNum[<%=i%>] = "<%=sSrlNum%>";
        
   <%
        i++;
     }
     rentinv.disconnect();
   %>

   parent.showTagAvl(Cls, Ven,  Sty, Clr, Siz, Desc, ClrNm, SizNm, InvId, SrlNum)

</SCRIPT>













