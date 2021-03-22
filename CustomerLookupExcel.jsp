<%@ page import="discountcard.CustomerLookup, java.util.*, java.text.*"%>
<%
      response.setContentType("application/vnd.ms-excel");

      String sSrchCode = request.getParameter("Code");
      String sSrchName = request.getParameter("Name");
      String sSrchTeam = request.getParameter("Team");
      String sSrchPhone1 = request.getParameter("Phone1");
      String sSrchPhone2 = request.getParameter("Phone2");
      String sSrchPhone3 = request.getParameter("Phone3");
      String sSrchEMail = request.getParameter("EMail");
      String sSrchRide = request.getParameter("Ride");
      String sSrchFrom = request.getParameter("From");
      String sSrchTo = request.getParameter("To");


      if(sSrchCode==null) sSrchCode = " ";
      if(sSrchName==null) sSrchName = " ";
      if(sSrchTeam==null) sSrchTeam = " ";
      if(sSrchPhone1==null) sSrchPhone1 = " ";
      if(sSrchPhone2==null) sSrchPhone2 = " ";
      if(sSrchPhone3==null) sSrchPhone3 = " ";
      if(sSrchEMail==null) sSrchEMail = " ";
      if(sSrchRide==null) sSrchRide = " ";
      if(sSrchFrom==null) sSrchFrom = "01/01/2000";
      if(sSrchTo==null) sSrchTo = "01/01/2099";

      int iNumOfCust = 0;
      CustomerLookup custlup = new CustomerLookup();

      custlup.searchCustomer(sSrchCode, sSrchName, sSrchTeam, sSrchPhone1, sSrchPhone2, sSrchPhone3, sSrchEMail,
            sSrchRide, sSrchFrom, sSrchTo, session.getAttribute("USER").toString());
      iNumOfCust = custlup.getNumOfCust();

      out.println("\t\t\tRetail Concepts, Inc" );
      out.println("\t\t\tCustomer List" );
      out.println("Tracking Id\tFirst Name\tLast Name\tAddress\tCity\tState\tZip\tPhone\tE-Mail\tTeam\tGroup\tRide\tSales" );
      for(int i=0; i < iNumOfCust; i++)
      {
         custlup.setCustomer();
         String sCode = custlup.getCode();
         String sFName = custlup.getFName();
         String sLName = custlup.getLName();
         String sAddr1 = custlup.getAddr1();
         String sAddr2 = custlup.getAddr2();
         String sCity = custlup.getCity();
         String sState = custlup.getState();
         String sZip = custlup.getZip();
         String sPhone = custlup.getPhone();
         String sBusPhn = custlup.getBusPhn();
         String sHomePhn = custlup.getHomePhn();
         String sFax = custlup.getFax();
         String sEMail = custlup.getEMail();
         String sTeam = custlup.getTeam();
         String sGroup = custlup.getGroup();
         String sRide = custlup.getRide();
         String sSales = custlup.getSales();


         out.print(sCode);
         out.print("\t" + sFName);
         out.print("\t" + sLName);
         out.print("\t" + sAddr1 + sAddr2);
         out.print("\t" + sCity);
         out.print("\t" + sState);
         out.print("\t" + sZip);
         out.print("\t" + sPhone);
         out.print("\t" + sEMail);
         out.print("\t" + sTeam);
         out.print("\t" + sGroup);
         out.print("\t" + sRide);
         out.println("\t" + sSales);
      }

  custlup.disconnect();
%>