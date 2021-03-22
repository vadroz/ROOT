<%@ page import="rciutility.GetDataBySQL , java.util.*"%>
<%
   String sPoNum = request.getParameter("PoNum");
   String sComment = request.getParameter("Comment");
   System.out.println(sPoNum);

   //======================================================================
   // add leading 0 to PO number
   //======================================================================
   char[] cInp = new char[10];
   int iStart = 10 - sPoNum.length();
   for(int i=0, j=0; i < 10; i++)
   {
     if (i < iStart){ cInp[i] = '0'; }
     else  { cInp[i] = sPoNum.charAt(j); j++; }
   }
   sPoNum = new String(cInp);

   //======================================================================
   // update PO header
   //======================================================================
   GetDataBySQL svPoCmt = new GetDataBySQL();
   svPoCmt.setPrepStmt("update iptsfil.ippohdr set hbc3='" + sComment + "' where hono = '" + sPoNum + "'");
   svPoCmt.runQuery();
   svPoCmt.disconnect();
%>

<SCRIPT language="JavaScript1.2">
goBack();

// send employee availability to schedule
function goBack()
{
  parent.frame1.close();
}
</SCRIPT>
