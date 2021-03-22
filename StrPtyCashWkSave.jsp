<%@ page import="storepettycash.StrPtyCashWkSave, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sIdNum = request.getParameter("IdNum");
   String sPayType = request.getParameter("PayType");
   String sSpiff = request.getParameter("Spiff");
   String sEmp = request.getParameter("Emp");
   String sPayee = request.getParameter("Payee");
   String sAmt = request.getParameter("Amt");
   String sNote = request.getParameter("Note");

   String sWeek = request.getParameter("Week");
   String sSts = request.getParameter("Sts");
   String sComment = request.getParameter("Comment");
   String sChgOnh = request.getParameter("ChgOnh");

   String sAction = request.getParameter("Action");

   if (sComment == null) { sComment = " "; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    String sUser = session.getAttribute("USER").toString();
    StrPtyCashWkSave ptycash = new StrPtyCashWkSave();

    // add/upd/dlt entry
    if( sAction.equals("ADD") || sAction.equals("UPD") || sAction.equals("DLT"))
    {
       ptycash.savePtyCashSpendings(sIdNum, sStore, sWeek, sPayType, sSpiff, sEmp, sPayee, sAmt, sNote, sAction,  sUser);
    }
    // change status
    else if(sAction.equals("CHGSTS"))
    {
       ptycash.chgPtyCashWeeklyStatus(sStore, sWeek, sSts, sComment, sAction, sUser);
    }
    // change Total
    else if(sAction.equals("CHGTOT"))
    {
       //System.out.println(sStore + "|" + sWeek + "|" + sAmt + "|" + sAction + "|" + sUser);
       ptycash.chgPtyCashBoxTotal(sStore, sWeek, sAmt, sAction, sUser);
    }
    // change chash onhand
    else if(sAction.equals("CHGONH"))
    {
       ptycash.chgPtyCashOnhand(sStore, sWeek, sChgOnh, sAmt, sAction, sUser);
    }
    // change reimbersing check status
    else if(sAction.equals("CHGCHK"))
    {
       //System.out.println(sStore + "|" + sWeek + "|" + sPayee + "|" + sAmt + "|" + sSts + "|" + sAction + "|" + sUser);
       if(sSts.equals("CHKREQ"))  {ptycash.chgCheckStatus(sStore, sWeek, sPayee, " ", "0", sSts, sAction, sUser);}
       else if(sSts.equals("CHKSNT"))  {ptycash.chgCheckStatus(sStore, sWeek, " ", sPayee, sAmt, sSts, sAction, sUser);}
       else if(sSts.equals("CHKRCVD")) {ptycash.chgCheckStatus(sStore, sWeek, " ", " ", sAmt, sSts, sAction, sUser);}
    }
    // rollup total to next week
    else if(sAction.equals("ROLLWK"))
    {
       ptycash.rollupStrWkPtyCashBoxTotal(sStore, sWeek, sAmt, sAction, sUser);
    }


    ptycash.disconnect();
    ptycash = null;

%>

<SCRIPT language="JavaScript1.2">

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.reStart();
   }

</SCRIPT>
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>