<%@ page import="ecommerce.EComSrlAsgSave , java.util.*"%>
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
   String [] sSrn = request.getParameterValues("Srn");
   String sAction = request.getParameter("Action");
   String [] sOrdLst = request.getParameterValues("OrdL");
   String [] sSiteLst = request.getParameterValues("SiteL");
   String sArg = request.getParameter("Arg");
   String sExcl = request.getParameter("Excl");
   String sReas = request.getParameter("Reas");
   String sPackId = request.getParameter("PackId");
   String sLastArg = request.getParameter("LastArg");

   if(sQty == null){sQty = "0";}
   if(sSts == null){sSts = " ";}
   if(sNote == null){sNote = " ";}
   if(sAction == null){sAction = " ";}
   if(sArg == null){sArg = "0";}
   if(sExcl == null){sExcl = " ";}
   if(sReas == null){sReas = " ";}
   if(sLastArg == null){sLastArg = "N";}
  
   //System.out.println("sAction=" + sAction);
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   String sUser = session.getAttribute("USER").toString();
   
   EComSrlAsgSave itmasgsav = new EComSrlAsgSave();
   if(sAction.equals("CHGSTRSTS") || sAction.equals("FIXSTRSTS"))
   {
     //System.out.println(sOrder);
     if(sOrder.equals("MARKED")){itmasgsav.saveMarkedOrder(sSiteLst, sOrdLst); }
     itmasgsav.saveStrSts(sSite, sOrder, sSku, sStr, sSts, sSrn, sEmp, sQty, sNote, sAction, sUser);

     // add item to exclude from inventory
     if(sExcl.equals("Y") && itmasgsav.getNumOfErr() == 0)
     {
        itmasgsav.saveExclded(sSite, sOrder, sSku, sStr, sQty, sEmp, sReas, sUser);
     }
   }
   else if(sAction.equals("REASSIGN"))
   {	   
       itmasgsav.saveReassign(sSite, sOrder, sSku, sSrn, sStr, sFromStr, sSts, sQty, sEmp, sNote, sAction, sUser);
   }
   else if(sAction.equals("QUICKSHIP"))
   {
       itmasgsav.saveQuickCompl(sSite, sOrder, sSku, sSrn, sStr, sFromStr, sSts, sQty, sEmp, sNote, sAction, sUser);
   }
   else if(sAction.equals("ADDCNL"))
   {
     itmasgsav.saveCnl(sSite, sOrder, sSku, sSrn, sStr, sEmp, sNote, sAction, sUser);
   }
   else if(sAction.equals("SENDEMAIL"))
   {
     itmasgsav.sendEmail(sSite, sOrder, sSku, sStr, sAddr, sNote, sAction, sUser);
   }
   else if(sAction.equals("CHGSTS"))
   {
     itmasgsav.saveSts(sSite, sOrder, sSku, sSts, sEmp, sNote, sAction, sUser);
   }
   else if(sAction.equals("ADDSKUNOTE") || sAction.equals("ADDSTRNOTE"))
   {
     itmasgsav.saveNote(sSite,sOrder,sSku,sStr,sNote,sAction,sUser);
   }
   else if(sAction.equals("ADDSTRMAIL"))
   {
       itmasgsav.saveNote(sSite,sOrder,sSku,sStr,sNote,sAction,sUser);
   }   
   else if(sAction.equals("PostPackId"))
   {
	   itmasgsav.savePackID(sSite, sOrder, sSku, sStr, sSrn[0], sEmp, sPackId, sAction, sUser);
	   //System.out.println("sLastArg=" + sLastArg);
	   if(sLastArg.equals("Y"))
	   {
		  itmasgsav.promoteToShipped(sSite, sOrder, sStr, sEmp, sPackId, sUser);
	   }
   }
   else if(sAction.equals("RePrtPackId"))
   {
	   //System.out.println("sPackId=" + sPackId);
	   itmasgsav.reprtPackID(sPackId, sUser);
   } 	   
   else
   {
      System.out.println("Wrong action");
      //System.out.println(sOrder + " " + sSku  + " " + sNote.trim() + " " + sSts + "|"
      //     + sAsgQty[0] + " " + sSndQty[0] + "|" + sMail[0].trim() + "|" + sStrNote[0].trim());
      //itmasgsav.saveSkuChanges(sSite, sOrder, sSku,  sSts, sNote, sStr
      // , sAsgQty, sSndQty, sMail, sStrNote, sEmp, sAction, sUser);
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
      if(action == "CHGSTRSTS" || action == "FIXSTRSTS" || action == "ADDCNL" || action == "SENDEMAIL" || action == "PostPackId"
    	  || action == "RePrtPackId"  )
      {
          //parent.updStrProp(sku, sts, qty, action);
          parent.restart(arg);
      }
      else if(action == "REASSIGN") { parent.restart(); }
      else if(action == "QUICKSHIP") { parent.restart(); }
      else if(action == "CHGSTS") { parent.restart(); } //updStsProp(sts, action); }
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

