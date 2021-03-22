<%@ page import="patiosales.OrderEntry , java.util.*, java.io.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sSku = request.getParameter("Sku");
   String sPath = request.getParameter("Path");
   String sAction = request.getParameter("Action");
   
   OrderEntry ordent = new OrderEntry();   
   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
   ordent.dltItmPicture(sOrder, sSku, sPath, sAction, session.getAttribute("USER").toString());    
   // special Order Item Entry
   
   try{
	     sPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Patio_Furniture/" + sPath;
	     System.out.println("sPath: " + sPath);
         File f = new File(sPath);
         System.out.println("f.exists() && f.isFile() =  " + f.exists() + " " + f.isFile());
         if(f.exists() && f.isFile())
         {
           f.delete();
         }
         f = null;
      }
      catch( Exception e )
      {
         System.out.println(e.getMessage());
      }

   
   
   ordent.disconnect();
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   var Action = "<%=sAction%>";

   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
      parent.reStart(); 
}
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







