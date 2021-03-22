<%@ page import="onhand01.ItemBSRMissing, java.util.*"%>
<%
   response.setContentType("application/vnd.ms-excel");

   String sExample = request.getParameter("Example");
   String [] sSrchDiv = request.getParameterValues("Div");
   String [] sChkStr = request.getParameterValues("Str");

if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=ItemMissBSR.jsp&" + request.getQueryString());
}
else
{
    ItemBSRMissing itmbsr = new ItemBSRMissing(sSrchDiv, sExample, sChkStr);

    // header
    out.println("\t\tItem List with Missing BSR Level");
    out.print("Selected Divisions:");
    for(int i=0; i < sSrchDiv.length; i++) { out.print("\t" + sSrchDiv[i]); }

    out.println("\nExamplary Store:" + sExample);

    out.print("Checked Store:\t");
    String sComa="";
    for(int i=0; i < sChkStr.length; i++) { out.print(sComa + sChkStr[i]); sComa=", "; }

    out.print("\nDiv\tDpt\tCls-Ven-Sty\tDescription\tVenr-Sty\tOn-hand");

    for(int i=0; i < sChkStr.length; i++) { out.print("\tOn-hand"); }
    out.print("\tBSR");
    for(int i=0; i < sChkStr.length; i++) { out.print("\tBSR"); }

    out.print("\n\t\t\t\t\t" + sExample);
    for(int i=0; i < sChkStr.length; i++) { out.print("\t" + sChkStr[i]); }
    out.print("\t" + sExample);
    for(int i=0; i < sChkStr.length; i++) { out.print("\t" + sChkStr[i]); }

    while(itmbsr.getNext())
    {
      itmbsr.setItmList();
      int iNumOfItm = itmbsr.getNumOfItm();
      String [] sDiv = itmbsr.getDiv();
      String [] sDpt = itmbsr.getDpt();
      String [] sCls = itmbsr.getCls();
      String [] sVen = itmbsr.getVen();
      String [] sSty = itmbsr.getSty();
      String [] sDesc = itmbsr.getDesc();
      String [] sVenSty = itmbsr.getVenSty();
      String [][] sOnHand = itmbsr.getOnHand();
      String [][] sBsr = itmbsr.getBsr();

      for(int i=0; i < iNumOfItm; i++)
      {
         out.print("\n" + sDiv[i] + "\t" + sDpt[i]
           + "\t" + sCls[i] + "-" + sVen[i] + "-" + sSty[i]
           + "\t" + sDesc[i] + "\t" + sVenSty[i]
         );
         for(int j=0; j < sOnHand[i].length; j++)
         {
            out.print("\t" + sOnHand[i][j]);
         }
         for(int j=0; j < sBsr[i].length; j++)
         {
            out.print("\t" + sBsr[i][j]);
         }
      }
    }

    itmbsr.disconnect();

}
%>