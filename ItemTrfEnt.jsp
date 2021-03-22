<%@ page import="itemtransfer.ItemTrfEnt, java.util.*"%>
<%
   String sDivision = request.getParameter("DIVISION");
   String sClass = request.getParameter("CLASS");
   String sVendor = request.getParameter("VENDOR");
   String sStyle = request.getParameter("STYLE");
   String sColor = request.getParameter("COLOR");
   String sSize = request.getParameter("SIZE");

   String sIssStr = request.getParameter("ISTR");
   String sDestStr = request.getParameter("DSTR");
   String sQty = request.getParameter("QTY");

   String [] sDestStrArr = request.getParameterValues("DSTRARR");
   String [] sQtyArr = request.getParameterValues("QTYARR");

   String sAction = request.getParameter("ACTION");
   String sDate = request.getParameter("DATE");
   String sRefresh = request.getParameter("Refresh");

   String sBatch = request.getParameter("Batch");

   String sCmpType = request.getParameter("CMPTYPE");
   String sNote = request.getParameter("NOTE");
   if(sCmpType==null) sCmpType=" ";
   if(sNote==null) sNote=" ";


   ItemTrfEnt trfEnt = null;
   int iNumOfCell = 0;
   String sCellJSA = null;
   String sCellInvJSA = null;
   String sCellStsJSA = null;
   String sCellIOJSA = null;
   String sError = " ";

   if(sClass==null) sClass=" ";
   if(sVendor==null) sVendor=" ";
   if(sStyle==null) sStyle=" ";
   if(sColor==null) sColor=" ";
   if(sSize==null) sSize=" ";

   if(sIssStr==null) sIssStr=" ";
   if(sDestStr==null) sDestStr=" ";
   if(sDate==null) sDate="ALL";
   if(sRefresh==null) sRefresh="false ";
   if(sBatch==null) sBatch="0";

    //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";
   String sUser = null;

   sUser = session.getAttribute("USER").toString();
   trfEnt = new ItemTrfEnt(sUser);
   
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
      sAction = "SIGNON";
   }
   else
   {
     if(sAction.equals("APPROVE"))
     {
        trfEnt.approveBatchSts(sBatch);
     }
     else if(sAction.equals("INTRANSIT") || sAction.equals("SENT"))
     {
        trfEnt.chgTrfSts(sDivision, sAction, sDate, sCmpType, sNote, sBatch);
     }
     else if(sAction.equals("DLTBATCH"))
     {
        System.out.print("\nDelete Transfer Batch Number: " + sBatch + " by user " + sUser + ". ");
        trfEnt.dltBatchTrf(sBatch);
        System.out.println("Transfer Batch Number have been deleted.");
     }
     else
     {
       
         System.out.println(sClass + " " + sVendor + " " + sStyle + " " + sColor + " "
         + sSize + " " + sIssStr + " " + sDestStr + " " + sQty + " " + sAction + " "
         + sUser + " " + sBatch);
       if(!sAction.equals("ADDITM"))
       {
          trfEnt.addDltItemTrfEnt(sClass, sVendor, sStyle, sColor, sSize,
                  sIssStr, sDestStr, sQty, sBatch, sAction);
       }
       else
       {
          System.out.println(sClass + " " + sVendor + " " + sStyle + " " + sColor + " "
            + sSize + " " + sIssStr + " " + sDestStrArr[0] + " " + sQtyArr[0] + " " + sBatch + " "
            + sAction);
          trfEnt.addMltStrTrfEnt(sClass, sVendor, sStyle, sColor, sSize,
                             sIssStr, sDestStrArr, sQtyArr, sBatch, sAction);
       }
       iNumOfCell = trfEnt.getNumOfCell();
       sCellJSA = trfEnt.getCellJSA();
       sCellInvJSA = trfEnt.getCellInvJSA();
       sCellStsJSA = trfEnt.getCellStsJSA();
       sCellIOJSA = trfEnt.getCellIOJSA();
       sError = trfEnt.getError();
     }

     trfEnt.disconnect();
   }
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>";
var NumOfCell = "<%=iNumOfCell%>"
var Cell = [<%=sCellJSA%>];
var CellInv = [<%=sCellInvJSA%>];
var CellIO = [<%=sCellIOJSA%>];
var CellSts = [<%=sCellStsJSA%>];
var Error = "<%=sError%>";

var Refresh = <%=sRefresh%>;

SendConfirm(true);

// send employee availability to schedule
function SendConfirm(confirm)
{
  var rtn = parent.location.href;

  if(Action.substring(0, 3) == "ADD" || Action == "DLTITM" || Action == "DLTCVS")
            parent.cnfAddTrf(NumOfCell, Cell, CellIO, CellSts, CellInv);
  else if(Action.substring(0, 3) == "CON") parent.cnfConTrf(NumOfCell, Cell, CellIO, CellSts, CellInv, Error);
  else if(Action == "DLTBATCH") { parent.rtvBatchNumber(); }
  else if(Action == "APPROVE") { parent.location = "ItmBatchApproveSel.jsp"; }
  else if(Action == "INTRANSIT" && !Refresh) parent.location = "DivTrfReqSel.jsp";
  else if(Action == "INTRANSIT" && Refresh) parent.location= rtn;
  else if(Action == "SENT" && !Refresh) parent.location = "DivTrfReqSel.jsp";
  else if(Action == "SENT" && Refresh) parent.location= rtn;
  else if(Action == "SIGNON")
  {
    alert( "Your request cannot be executed because the signon is expired."
         + "\nPlease, press refresh button(F5) and signon again, then repeat"
         + "\nyour request again.");
  }
  // window.close();
}
</SCRIPT>
Class: <%=sClass%><br>
Vendor: <%=sVendor%><br>
Style: <%=sStyle%><br>
Color: <%=sColor%><br>
Size = <%=sSize%><br>
Issued Store: <%=sIssStr%><br>
Dest Store: <%=sDestStr%><br>
Qty: <%=sQty%><br>
Action: <%=sAction%><br>
</html>


