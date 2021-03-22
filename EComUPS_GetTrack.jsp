<%@ page import="java.util.*, java.text.*, ecommerce.EComUPS_GetTrack"%>
<%
   String sStr = request.getParameter("Str");
   String sFile = request.getParameter("File");
   String sOrder = request.getParameter("Order");

   //System.out.println(sStr + "|" + sOrder);

   EComUPS_GetTrack fextrack = new EComUPS_GetTrack();

   if (sOrder == null)
   {
      if(sFile==null)
      {
         sFile = sStr + "-live.csv";
         if(sStr.equals("3")) {sFile = "03-live.csv"; }
         else if( sStr.equals("4")){ sFile = "04-live.csv";}
         else if( sStr.equals("29")){ sFile = "029-live.csv";}
         else if( sStr.equals("86")){ sFile = "086-live.csv";}
         else if( sStr.equals("90")){ sFile = "090-live.csv";}
         //sFile = "/" + sFile + "/";
      }
      System.out.println("Str: " + sStr + " File: " + sFile);
      fextrack.getTrackIdList(sStr, sFile);

      //System.out.println(" Str 45 ??? " + sStr.equals("45"));  
      if(sStr.equals("92"))
      {
         sFile = sStr + "B-live.csv";
         //sFile = "/" + sFile + "/";
         System.out.println("Str: " + sStr + " File: " + sFile);
         fextrack.getTrackIdList(sStr, sFile);
      }
      else if(sStr.equals("45"))    
      {
    	 System.out.println(" Str 45 !!!! ");  
         sFile = sStr + "b-live.csv";
         //sFile = "/" + sFile + "/";
         System.out.println("Str: " + sStr + " File: " + sFile);
         fextrack.getTrackIdList(sStr, sFile);
      }
      System.out.println("FedEx Tracking Id received.");
   }
   else
   {

   }
      fextrack.disconnect();
      fextrack = null;
%>
<script language="javascript">
try{
    parent.refresh();
   }
catch(err)
{
   //alert(err)
}
</script>





