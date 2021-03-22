<%@ page import="ecommerce.EComItmAsgSave , java.util.*"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
   String sSku = request.getParameter("Sku");
   String sSts = request.getParameter("Sts");
   String sNote = request.getParameter("Note");
   String sAddr = request.getParameter("Addr");
   String sStr = request.getParameter("Str");
   String sFromStr = request.getParameter("FromStr");
   String sAsgQty = request.getParameter("AsgQ");
   String sSndQty = request.getParameter("SndQ");
   String sMail = request.getParameter("Mail");
   String sStrNote = request.getParameter("StrN");
   String sEmp = request.getParameter("Emp");
   String sQty = request.getParameter("Qty");
   String sAction = request.getParameter("Action");
   String [] sOrdLst = request.getParameterValues("OrdL");
   String [] sSiteLst = request.getParameterValues("SiteL");
   String sArg = request.getParameter("Arg");
   String sExcl = request.getParameter("Excl");
   String sReas = request.getParameter("Reas");


   if(sQty == null){sQty = "0";}
   if(sSts == null){sSts = " ";}
   if(sNote == null){sNote = " ";}
   if(sAction == null){sAction = " ";}
   if(sArg == null){sArg = "0";}
   if(sExcl == null){sExcl = " ";}
   if(sReas == null){sReas = " ";}
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   EComItmAsgSave itmasgsav = new EComItmAsgSave();
   if(sAction.equals("CHGSTRSTS"))
   {
     //System.out.println(sOrder);
     if(sOrder.equals("MARKED")){itmasgsav.saveMarkedOrder(sSiteLst, sOrdLst); }

     itmasgsav.saveStrSts(sSite, sOrder, sSku, sStr, sSts, sQty, sEmp, sNote, sAction, session.getAttribute("USER").toString());
     // add item to exclude from inventory
     //System.out.println("sReas: " + sReas);
     if(sExcl.equals("Y") && itmasgsav.getNumOfErr() == 0)
     {
        itmasgsav.saveExclded(sSite, sOrder, sSku, sStr, sQty, sEmp, sReas, session.getAttribute("USER").toString());
     }
   }
   else if(sAction.equals("REASSIGN"))
   {
       itmasgsav.saveReassign(sSite, sOrder, sSku, sStr, sFromStr, sSts, sQty, sEmp, sNote, sAction, session.getAttribute("USER").toString());
   }
   else if(sAction.equals("QUICKSHIP"))
   {
       itmasgsav.saveQuickCompl(sSite, sOrder, sSku, sStr, sFromStr, sSts, sQty, sEmp, sNote, sAction, session.getAttribute("USER").toString());
   }
   else if(sAction.equals("ADDCNL"))
   {
     itmasgsav.saveCnl(sSite, sOrder, sSku, sStr, sEmp, sNote, sAction, session.getAttribute("USER").toString());
   }
   else if(sAction.equals("SENDEMAIL"))
   {
     itmasgsav.sendEmail(sSite, sOrder, sSku, sStr, sAddr, sNote, sAction, session.getAttribute("USER").toString());
   }
   else if(sAction.equals("CHGSTS"))
   {
     itmasgsav.saveSts(sSite, sOrder, sSku, sSts, sEmp, sNote, sAction, session.getAttribute("USER").toString());
   }
   else if(sAction.equals("ADDSKUNOTE") || sAction.equals("ADDSTRNOTE"))
   {
     itmasgsav.saveNote(sSite,sOrder,sSku,sStr,sNote,sAction,session.getAttribute("USER").toString());
   }
   else if(sAction.equals("ADDSTRMAIL"))
   {
       itmasgsav.saveNote(sSite,sOrder,sSku,sStr,sNote,sAction,session.getAttribute("USER").toString());
   }
   else
   {
      System.out.println("Wrong action");
      //System.out.println(sOrder + " " + sSku  + " " + sNote.trim() + " " + sSts + "|"
      //     + sAsgQty[0] + " " + sSndQty[0] + "|" + sMail[0].trim() + "|" + sStrNote[0].trim());
      //itmasgsav.saveSkuChanges(sSite, sOrder, sSku,  sSts, sNote, sStr
      // , sAsgQty, sSndQty, sMail, sStrNote, sEmp, sAction, session.getAttribute("USER").toString());
   }
   int iNumOfErr = itmasgsav.getNumOfErr();
   String sError = itmasgsav.getErrorJsa();

   // special Order Item Entry
   itmasgsav.disconnect();
   itmasgsav = null;
%>
<SCRIPT language="JavaScript1.2">
   var NumOfErr = "<%=iNumOfErr%>";
   var Error = [<%=sError%>];

   var qty = "<%=sQty%>";
   var sts = "<%=sSts%>";
   var note = "<%=sNote%>";
   var action = "<%=sAction%>";
   var sku = "<%=sSku%>";
   var arg = "<%=sArg%>";

   if(NumOfErr == 0){   goBack(); }
   else { dispError(); }
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      if(action == "CHGSTRSTS" || action == "ADDCNL" || action == "SENDEMAIL")
      {
          //parent.updStrProp(sku, sts, qty, action);
          parent.restart(arg);
      }
      else if(action == "CHGSTS") { parent.restart(); } //updStsProp(sts, action); }
      else if(action == "REASSIGN") { parent.restart(); }
      else if(action == "QUICKSHIP") { parent.restart(); }
      else if(action == "ADDSKUNOTE" || action == "ADDSTRNOTE" || action == "ADDSTRMAIL")
      {
         parent.updStrProp(note, action);
      }

      parent.reuseFrame();
   }

//==============================================================================
// send employee availability to schedule
//==============================================================================
function dispError()
{
   parent.rtnWithError(arg, Error);
}
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

