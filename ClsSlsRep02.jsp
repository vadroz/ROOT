<%@ page import="classreports.SetClsRep, java.util.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
    String [] sSelStr = request.getParameterValues("STR");
    String sDivSelType = request.getParameter("DivSelType");

    // for multiple division selection
    String [] sDivMlt = request.getParameterValues("DIVM");

    String [] sDiv = new String[]{ request.getParameter("DIVISION") };
    String sDpt = request.getParameter("DEPARTMENT");
    String sGrp = request.getParameter("CLASS");
    String sFrom = request.getParameter("FROM");
    String sTo = request.getParameter("TO");
    String sSelType = request.getParameter("SELTYPE");
    String sDetail = request.getParameter("DETAIL");
    String sSelGrp = request.getParameter("GROUP");

    StringBuffer sbStrList = new StringBuffer();
    String coma = null;
    for(int i=0; i < sSelStr.length; i++)
    {
       if (coma != null) sbStrList.append(coma);
       if (sSelStr[i].trim().equals("CMPD")) sbStrList.append("COMP + DC");
       else sbStrList.append(sSelStr[i]);
       if (coma == null) coma = ", ";
    }

    String sStore = sbStrList.toString();

    if(sDivSelType.equals("true"))
    {
       sDiv = sDivMlt;
       sDpt = "ALL";
       sGrp = "ALL";
    }

    //System.out.println( "Str: " + sStore  + "  Div: " + sDiv + "  Dpt: " + sDpt + "\n  Grp: " + sGrp
    //  + "  From: " + sFrom  + "  To: " + sTo + "\n  SelType: " + sSelType + "  Detail: " + sDetail
    //  + "  SelGrp: " + sSelGrp );

    session.setMaxInactiveInterval(1200);

    // field selection creen
    boolean [] bSelFld = new boolean[14];

    bSelFld[0] = request.getParameter("SLSRET") != null;
    bSelFld[1] = request.getParameter("SLSCST") != null;
    bSelFld[2] = request.getParameter("SLSUNT") != null;
    bSelFld[3] = request.getParameter("GMRAMT") != null;
    bSelFld[4] = request.getParameter("GMRPRC") != null;
    bSelFld[5] = request.getParameter("ENDRET") != null;
    bSelFld[6] = request.getParameter("ENDCST") != null;
    bSelFld[7] = request.getParameter("ENDUNT") != null;
    bSelFld[8] = request.getParameter("AGERET") != null;
    bSelFld[9] = request.getParameter("AGECST") != null;
    bSelFld[10] = request.getParameter("AGEUNT") != null;
    bSelFld[11] = request.getParameter("AGPRET") != null;
    bSelFld[12] = request.getParameter("AGPCST") != null;
    bSelFld[13] = request.getParameter("AGPUNT") != null;

//-------------------- populate class/store arrays -----------------------------
     /*System.out.println( " " + sStore + "|Dpt: " + sDpt + " " + sGrp + " " + sFrom + " " + sTo
                       + " " + sSelType + " " + sDetail + " " + sSelGrp );
      */
     SetClsRep setClsRep = new SetClsRep(sStore, sDiv, sDpt, sGrp, sFrom, sTo,
                           sSelType, sDetail, sSelGrp);

     for(int i=0; i < sDiv.length; i++){System.out.print(" " + sDiv[i]); }

     int iNumOfCol = setClsRep.getNumOfCol();
     int iNumOfStr = setClsRep.getNumOfStr();
     String [] sColHdg = setClsRep.getColHdg();
     String [] sStr = setClsRep.getStr();


    // selected store
    out.print( "Store: " + sStore + "\n");

    // Column name
    if(sSelGrp.equals("DIV"))
           out.print( "Div\tDiv Name\t\t\t\t\tField Name");
    else if(sSelGrp.equals("DPT"))
           out.print( "Div\tDpt\tDpt Name\t\t\t\tField Name");
    else if(sSelGrp.equals("CLS"))
           out.print( "Div\tDpt\tClass\tClass Name\t\t\tField Name");
    else if(sSelGrp.equals("NON"))
           out.print( "\t\tField Name");


    if (sDetail.equals("D")) out.print( "\tStr #");
    else out.print( "\t");


    for (int i=0; i < iNumOfCol ;i++)
    {
      out.print("\t" + sColHdg[i]);
    }
    out.print("\n");

    //======================================================================
    String [] sRowName = new String[]{"Sales Retail", "Sales Cost", "Sales Unit",
                                      "Gross Margin", "GM %",
                                      "Ending Inv Retail", "Ending Inv Cost", "Ending Inv Unit",
                                      "Aged Inv Retail", "Aged Inv Cost", "Aged Inv Unit",
                                      "Aged Inv Retail %", "Aged Inv Cost %", "Aged Inv Unit %"};
    //======================================================================
    // Data
    int iSkip = 6;
    if(sSelGrp.equals("NON")) { iSkip = 2; }
    int iStr = 0;
    String sComa = "";

    while(setClsRep.getNext())
    {
       System.out.println();
       setClsRep.getGrpInfo();
       String sDivsn = setClsRep.getDiv();
       String sDepart = setClsRep.getDpt();
       String sGroup = setClsRep.getGrp();
       String sGrpName = setClsRep.getGrpName();


       System.out.print(sComa + sGroup + sGrpName);
       sComa = ",";


       if(sSelGrp.equals("DIV")){ out.print("\n" + sGroup + "\t" + sGrpName + "\t\t\t");}
       else if(sSelGrp.equals("DPT")){ out.print("\n" + sDivsn + "\t" + sGroup + "\t" + sGrpName + "\t\t");}
       else if(sSelGrp.equals("CLS")){ out.print("\n" + sDivsn + "\t"  + sDepart + "\t" + sGroup + "\t" + sGrpName + "\t");}

       setClsRep.getGMData();
       int iNumOfGrp = setClsRep.getNumOfGrp();
       String [][] sRet = setClsRep.getRet();
       String [][] sCost = setClsRep.getCost();
       String [][] sUnit = setClsRep.getUnit();
       String [][] sGrsMrg = setClsRep.getGrsMrg();
       String [][] sGrsMrgPrc = setClsRep.getGrsMrgPrc();
       String [][] sNetRet = setClsRep.getNetRet();
       String [][] sEIRet = setClsRep.getEIRet();
       String [][] sEICost = setClsRep.getEICost();
       String [][] sEIUnit = setClsRep.getEIUnit();
       String [][] sAIRet = setClsRep.getAIRet();
       String [][] sAICost = setClsRep.getAICost();
       String [][] sAIUnit = setClsRep.getAIUnit();
       String [][] sAPRet = setClsRep.getAPRet();
       String [][] sAPCost = setClsRep.getAPCost();
       String [][] sAPUnit = setClsRep.getAPUnit();

       out.print("\t\t");

       // filed name loop
       for(int i=0; i < bSelFld.length; i++)
       {
          if(bSelFld[i])
          {
             if(i > 0) { for(int x=0; x < iSkip; x++) { out.print("\t"); }  }

             String [][] sAmt = null;
             if(i == 0) { sAmt = sRet; }
             else if(i == 1) { sAmt = sCost; }
             else if(i == 2) { sAmt = sUnit; }
             else if(i == 3) { sAmt = sGrsMrg; }
             else if(i == 4) { sAmt = sGrsMrgPrc; }
             else if(i == 5) { sAmt = sEIRet; }
             else if(i == 6) { sAmt = sEICost; }
             else if(i == 7) { sAmt = sEIUnit; }
             else if(i == 8) { sAmt = sAIRet; }
             else if(i == 9) { sAmt = sAICost; }
             else if(i == 10) { sAmt = sAIUnit; }
             else if(i == 11) { sAmt = sAPRet; }
             else if(i == 12) { sAmt = sAPCost; }
             else if(i == 13) { sAmt = sAPUnit; }
             else if(i == 14) { sAmt = sNetRet; }

             // store loop
             for(int j=0; j < iNumOfGrp; j++)
             {
                if(sDetail.equals("D") && sSelGrp.equals("NON")) { out.print(sRowName[i] + "\t" + sStr[iStr] + "\t"); }
                else if(sDetail.equals("D")) { out.print(sRowName[i] + "\t" + sStr[j] + "\t"); }
                else { out.print(sRowName[i] + "\t\t"); }
                // selected amounts amounts
                for(int k=0; k < iNumOfCol; k++) { out.print(sAmt[j][k] + "\t"); }

                if(sDetail.equals("D")) { out.print("\n"); } // skip next line
                for(int x=0; x < iSkip; x++) { out.print("\t"); }
             }
             out.print("\n");
          }

       }
       iStr++;
    }

  // Print total
  if(sDivSelType.equals("true"))
  {
    setClsRep.getGMTotal();
    String [][] sRet = setClsRep.getRet();
    String [][] sCost = setClsRep.getCost();
    String [][] sUnit = setClsRep.getUnit();
    String [][] sGrsMrg = setClsRep.getGrsMrg();
    String [][] sGrsMrgPrc = setClsRep.getGrsMrgPrc();
    String [][] sNetRet = setClsRep.getNetRet();
    String [][] sEIRet = setClsRep.getEIRet();
    String [][] sEICost = setClsRep.getEICost();
    String [][] sEIUnit = setClsRep.getEIUnit();
    String [][] sAIRet = setClsRep.getAIRet();
    String [][] sAICost = setClsRep.getAICost();
    String [][] sAIUnit = setClsRep.getAIUnit();
    String [][] sAPRet = setClsRep.getAPRet();
    String [][] sAPCost = setClsRep.getAPCost();
    String [][] sAPUnit = setClsRep.getAPUnit();


    // filed name loop
    out.print("\n Report Total" );
    for(int x=0; x < iSkip; x++) { out.print("\t"); }

    for(int i=0; i < bSelFld.length; i++)
    {
        if(bSelFld[i])
        {
           String [][] sAmt = null;
           if(i == 0) { sAmt = sRet; }
           else if(i == 1) { sAmt = sCost; }
           else if(i == 2) { sAmt = sUnit; }
           else if(i == 3) { sAmt = sGrsMrg; }
           else if(i == 4) { sAmt = sGrsMrgPrc; }
           else if(i == 5) { sAmt = sEIRet; }
           else if(i == 6) { sAmt = sEICost; }
           else if(i == 7) { sAmt = sEIUnit; }
           else if(i == 8) { sAmt = sAIRet; }
           else if(i == 9) { sAmt = sAICost; }
           else if(i == 10) { sAmt = sAIUnit; }
           else if(i == 11) { sAmt = sAPRet; }
           else if(i == 12) { sAmt = sAPCost; }
           else if(i == 13) { sAmt = sAPUnit; }
           else if(i == 14) { sAmt = sNetRet; }


           for(int j=0; j < 1; j++)
           {
              if(sDetail.equals("D")) { out.print(sRowName[i] + "\t AllStore \t"); }
              else { out.print(sRowName[i] + "\t\t"); }
              // selected amounts amounts
              for(int k=0; k < iNumOfCol; k++) { out.print(sAmt[j][k] + "\t"); }
               //if(sDetail.equals("D")) { out.print("\n"); } // skip next line
              for(int x=0; x < iSkip; x++) { out.print("\t"); }
           }
           out.print("\n");
           for(int x=0; x < iSkip; x++) { out.print("\t"); }
        }
    }
  }
  setClsRep.disconnect();
  setClsRep = null;
%>

