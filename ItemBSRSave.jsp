<%@ page import="java.util.*, onhand01.ItemBSRSave"%>
<%
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");   
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");
   String [] sIdeal = request.getParameterValues("Ideal");
   String [] sMax = request.getParameterValues("Max");
   String [] sMin = request.getParameterValues("Min");   
   String sType = request.getParameter("Type");   
   String [] sItem = request.getParameterValues("Item");   
   String sAction = request.getParameter("Action");
   
   String sSelBsrLvl = request.getParameter("BsrLvl"); 
   String sFrLastRcvDt = request.getParameter("FrLastRcvDt");
   String sToLastRcvDt = request.getParameter("ToLastRcvDt");
   String sFrLastSlsDt = request.getParameter("FrLastSlsDt");
   String sToLastSlsDt = request.getParameter("ToLastSlsDt");
   String sFrLastMdnDt = request.getParameter("FrLastMdnDt");
   String sToLastMdnDt = request.getParameter("ToLastMdnDt");
   String sPermMdn = request.getParameter("PermMdn");
   String sNeverOuts = request.getParameter("NeverOuts");
   String sFrStr = request.getParameter("FrStr");
   String sToStr = request.getParameter("ToStr");
   String sBlIdeal = request.getParameter("BlIdeal");
   String sBlMax = request.getParameter("BlMax");
   String sBlMin = request.getParameter("BlMin");
   
   if(sDiv == null) { sDiv = " "; }
   if(sDpt == null) { sDpt = " "; }    
   if(sCls == null) { sCls = " "; }
   if(sItem == null){ sItem = new String[0]; }
   
   ItemBSRSave itmbsr = new ItemBSRSave();
   if(sAction.equals("CHGBSR"))
   {
   		itmbsr.saveItemBSR(sCls, sVen, sSty, sClr, sSiz, sMin, sIdeal, sMax);
   }
   else if(sAction.equals("APPLY"))
   {
	   itmbsr.ApplyToAllItems(sType, sMin[0], sIdeal[0], sMax[0], sDiv, sDpt, sCls, sItem, sAction);	   
   }   
   else if(sAction.equals("CpyFrmStr"))
   {
	   System.out.println("Action=" + sAction);
	   
	   itmbsr.copyFromStr(sDiv, sDpt, sCls, sVen, sSty
		    	, sSelBsrLvl, sFrLastRcvDt, sToLastRcvDt, sFrLastSlsDt, sToLastSlsDt, sFrLastMdnDt, sToLastMdnDt
		    	, sPermMdn, sNeverOuts, sFrStr, sToStr, sBlIdeal, sBlMax, sBlMin);	   
   }   
   else if(sAction.equals("ZeroStr"))
   {
	   System.out.println("Action=" + sAction);
	   
	   itmbsr.zeroStr(sDiv, sDpt, sCls, sVen, sSty
		    	, sSelBsrLvl, sFrLastRcvDt, sToLastRcvDt, sFrLastSlsDt, sToLastSlsDt, sFrLastMdnDt, sToLastMdnDt
		    	, sPermMdn, sNeverOuts, sFrStr, sToStr, sBlIdeal, sBlMax, sBlMin);	   
   }
   
   String sError = itmbsr.getError();
   

   itmbsr.disconnect();
   itmbsr = null;
%>

<html>
<head>


<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Error = "<%=sError%>";
var Action = "<%=sAction%>";
goBack();
//==============================================================================
// return result
//==============================================================================
function goBack()
{
   if(Action == "CHGBSR" ){parent.updateLine(Error);}
   else if(Action == "APPLY" ){parent.location.reload();}
   else if(Action == "CpyFrmStr" ){parent.location.reload();}
   else if(Action == "ZeroStr" ){parent.location.reload();}
}
</SCRIPT>